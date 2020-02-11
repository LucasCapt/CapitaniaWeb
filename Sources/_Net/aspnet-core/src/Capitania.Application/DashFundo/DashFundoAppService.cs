using Abp.Authorization;
using Capitania.Authorization;
using Capitania.DashFundo.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashFundo
{
    [AbpAuthorize(PermissionNames.Pages_DashboardControle)]
    public class DashFundoAppService : CapitaniaAppServiceBase, IDashFundoAppService
    {
        public DashFundoDto ObterDadosFundo(int IDFundo)
        {
            DashFundoDto vRetorno = new DashFundoDto();
            StringBuilder vSQL = new StringBuilder();

            vSQL.AppendLine("SELECT ID as IDFundo, Nome as Nome");
            vSQL.AppendLine("  FROM TFUNDOS");
            vSQL.AppendLine(" WHERE NOT (Deleted = 1 AND DT_Deleted <= GetDate())");
            vSQL.AppendLine("   AND DT_CREATED <= GetDate()");
            vSQL.AppendLine(String.Format("   AND ID = {0}", IDFundo));

            vRetorno.Fundo = GeneralHelper.GetData<FundoDto>(vSQL.ToString()).FirstOrDefault();

            vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT TOP 10 Fundo as IDFundo, [Data] as Data, Quota as Quota");
            vSQL.AppendLine("  FROM TQUOTAS");
            vSQL.AppendLine(String.Format(" WHERE Fundo = {0}", IDFundo));
            vSQL.AppendLine(" ORDER BY [Data] Desc");

            vRetorno.Quotas = GeneralHelper.GetData<QuotaDto>(vSQL.ToString());

            vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT DISTINCT TOP 10 DataInfo as DataInfo, Fundo as NomeFundo, (PL / 1000000) as PL ");
            vSQL.AppendLine("  FROM THISTRISK");
            vSQL.AppendLine(String.Format(" WHERE Fundo = '{0}'", vRetorno.Fundo.Nome.Trim()));
            vSQL.AppendLine(" ORDER BY DataInfo Desc");

            vRetorno.Patrimonio = GeneralHelper.GetData<PatrimonioLiquidoDto>(vSQL.ToString());

            vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT TOP 100 Fundo as IDFundo, Data as Data, Papel as Papel, Valor as Valor");
            vSQL.AppendLine("  FROM TPOSIC");
            vSQL.AppendLine(String.Format(" WHERE Fundo = {0}", IDFundo));
            vSQL.AppendLine(" ORDER BY Data Desc");

            vRetorno.Posicao = GeneralHelper.GetData<PosicaoDto>(vSQL.ToString());

            return vRetorno;
        }

        public List<FundoDto> ObterFundos()
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT ID as IDFundo, Nome as Nome");
            vSQL.AppendLine("  FROM TFUNDOS");
            vSQL.AppendLine(" WHERE NOT (Deleted = 1 AND DT_Deleted <= GetDate())");
            vSQL.AppendLine("   AND DT_CREATED <= GetDate()");

            List<FundoDto> vRetorno = GeneralHelper.GetData<FundoDto>(vSQL.ToString());

            return vRetorno;
        }
    }
}
