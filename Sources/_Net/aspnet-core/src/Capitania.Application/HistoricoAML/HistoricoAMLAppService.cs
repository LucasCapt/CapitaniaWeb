using Abp.Authorization;
using Capitania.Authorization;
using Capitania.HistoricoAML.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.HistoricoAML
{
    [AbpAuthorize(PermissionNames.Pages_HistoricoAML)]
    public class HistoricoAMLAppService : CapitaniaAppServiceBase, IHistoricoAMLAppService
    {
        public List<HistoricoAMLDto> GetHistoricoAMLDtos()
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT [Data] AS DataAML,");
            vSQL.AppendLine("       Trade AS Trade,");
            vSQL.AppendLine("       ctpt AS CTPT,");
            vSQL.AppendLine("       Compliant AS Compliant,");
            vSQL.AppendLine("       Coment AS Coment,");
            vSQL.AppendLine("       Ativo AS Ativo,");
            vSQL.AppendLine("       Fundo AS Fundo");
            vSQL.AppendLine("  FROM ThistAML");
            vSQL.AppendLine(" WHERE Compliant <> 'OK'");
            vSQL.AppendLine(String.Format("   AND [Data] >= '{0}'", DateTime.Now.AddDays(-30)));

            return GeneralHelper.GetData<HistoricoAMLDto>(vSQL.ToString());
        }

        public List <HistoricoAMLCountPorDataDto> GetHistoricoAMLCountPorDataDtos()
        {
            StringBuilder vSQL = new StringBuilder();

            vSQL.AppendLine("SELECT CAST(CONCAT(CONVERT(VARCHAR(7), [Data], 126), '-01') as Date) AS Data, COUNT(*) AS Contador");
            vSQL.AppendLine("  FROM ThistAML");
            vSQL.AppendLine(" WHERE CONVERT(VARCHAR(7), [Data], 126) IN (SELECT DISTINCT CONVERT(VARCHAR(7), [Data], 126) AS anoMes");
            vSQL.AppendLine("                                               FROM ThistAML");
            vSQL.AppendLine("                                              WHERE [Data] > CAST(DATEADD(year, -1, GETDATE()) as DATE))");
            vSQL.AppendLine("   AND Compliant <> 'OK'");
            vSQL.AppendLine(" GROUP BY CONVERT(VARCHAR(7), [Data], 126)");
            vSQL.AppendLine(" ORDER BY Data");

            return GeneralHelper.GetData<HistoricoAMLCountPorDataDto>(vSQL.ToString());
        }
    }


}
