using Abp.Authorization;
using Capitania.Authorization;
using Capitania.DashboardXml.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashboardXml
{
    [AbpAuthorize(PermissionNames.Pages_DashboardXml)]
    public class DashboardXmlAppService : CapitaniaAppServiceBase, IDashboardXmlAppService
    {
        public List<DashboardXmlDto> ObterDadosDashXml(DateTime vDataBase)
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("select ID, DataHora, Arquivo, Pasta, CASE Situacao WHEN 1 THEN 'OK' WHEN 0 THEN 'NOK' END as Situacao, Observacao");
            vSQL.AppendLine("  from TLogArquivoXml");
            vSQL.AppendLine(String.Format(" where Cast(DataHora as Date) = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine(" order by DataHora");

            List<DashboardXmlDto> vDados = GeneralHelper.GetData<DashboardXmlDto>(vSQL.ToString());

            return vDados;
        }
    }
}
