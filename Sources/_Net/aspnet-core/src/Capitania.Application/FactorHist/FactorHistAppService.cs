using Abp.Authorization;
using Capitania.Authorization;
using Capitania.FactorHist.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.FactorHist
{
    [AbpAuthorize(PermissionNames.Pages_FactorHist)]
    public class FactorHistAppService : CapitaniaAppServiceBase, IFactorHistAppService
    {
        public const string FactorDolar = "DOLAR";
        public const string FactorIDA = "IDA";
        public const string FactorIFIX = "IFIX";
        public const string FactorIMAB5 = "IMAB5";
        public const string FactorIPCA10Y = "IPCA10Y";
        public const string FactorIPCA2Y = "IPCA2Y";
        public const string FactorIPCA5Y = "IPCA5Y";
        public const string FactorPRE2Y = "PRE2Y";
        public const string FactorPRE5Y = "PRE5Y";

        public List<FactorHistDto> GetListaFactorHist(string vFactorID)
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT FACTORID AS FactorID, [Data] as Data, Valor AS Valor");
            vSQL.AppendLine("  FROM TFACTORHIST,");
            vSQL.AppendLine("       (SELECT CONVERT(VARCHAR(7), [Data], 126) AS anoMes, MAX([Data]) AS UltimaDataMes");
            vSQL.AppendLine("          FROM TFACTORHIST");
            vSQL.AppendLine("         WHERE CONVERT(VARCHAR(7), [Data], 126) IN (SELECT DISTINCT CONVERT(VARCHAR(7), Data, 126) AS anoMes");
            vSQL.AppendLine("                                                      FROM TFACTORHIST");
            vSQL.AppendLine(String.Format("                                                     WHERE FACTORID = '{0}'", vFactorID));
            vSQL.AppendLine("                                                       AND [Data] > CAST(DATEADD(year, -1, GETDATE()) AS DATE))");
            vSQL.AppendLine("         GROUP BY CONVERT(VARCHAR(7), [Data], 126)) AS Tabela1");
            vSQL.AppendLine(" WHERE Tabela1.UltimaDataMes = [Data]");
            vSQL.AppendLine(String.Format("   AND FactorID = '{0}'", vFactorID));
            vSQL.AppendLine(" ORDER BY [Data]");

            return GeneralHelper.GetData<FactorHistDto>(vSQL.ToString());
        }
    }
}
