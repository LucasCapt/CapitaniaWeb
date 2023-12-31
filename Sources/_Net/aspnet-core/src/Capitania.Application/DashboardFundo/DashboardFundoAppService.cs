﻿using Abp.Authorization;
using Capitania.Authorization;
using Capitania.DashboardFundo.Dto;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashboardFundo
{
    [AbpAuthorize(PermissionNames.Pages_DashboardFundos)]
    public class DashboardFundoAppService : CapitaniaAppServiceBase, IDashboardFundoAppService
    {
        private List<DashboardGeralDto> ObterDadosDashGeral(string Area)
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("select fundo.Nome as NomeFundo, risco.pl, risco.caixa, risco.CRD_EL1, risco.[VaR], ");
            vSQL.AppendLine("       risco.Stress, risco.LIQSTRESSPERCENTILE, risco.DataInfo, risco.DataRun");
            vSQL.AppendLine("  from tfundos as Fundo, Thistrisk as risco");
            vSQL.AppendLine(" where fundo.nome = risco.fundo");
            if (!String.IsNullOrEmpty(Area))
            {
                vSQL.AppendLine(String.Format("   AND fundo.area = '{0}'", Area));
            }
            vSQL.AppendLine("   and datarun = (select max(risco1.DataRun)");
            vSQL.AppendLine("                    from THistRisk as risco1");
            vSQL.AppendLine("                   where Fundo.nome = risco1.Fundo)");
            vSQL.AppendLine(String.Format("   AND DT_CREATED <= '{0}'", DateTime.Now.ToString("yyyy-MM-dd")));
            vSQL.AppendLine(String.Format("   AND NOT (DELETED = 1 AND DT_DELETED <= '{0}')", DateTime.Now.ToString("yyyy-MM-dd")));
            vSQL.AppendLine(" order by Nome");

            List<DashboardGeralDto> vDados = GeneralHelper.GetData<DashboardGeralDto>(vSQL.ToString());

            //formatar os dados;
            //foreach (var item in vDados)
            //{
            //    item.Caixa = Math.Round(item.Caixa * 100, 1);
            //    item.CRD_EL1 = Math.Round(item.CRD_EL1 * 100, 1);
            //    item.LIQSTRESSPERCENTILE = Math.Round(item.LIQSTRESSPERCENTILE * 100, 1);
            //    item.Stress = Math.Round(item.Stress * 100, 1);
            //    item.VAR = Math.Round(item.VAR * 100, 1);
            //}

            return vDados;
        }

        public List<DashboardGeralDto> ObterDadosDashTodos()
        {
            return ObterDadosDashGeral("");
        }


        public List<DashboardGeralDto> ObterDadosDashAsset()
        {
            return ObterDadosDashGeral("ASSET");
        }

        public List<DashboardGeralDto> ObterDadosDashADV()
        {
            return ObterDadosDashGeral("ADV");
        }

        public List<DashboardGeralDto> ObterDadosDashExterno()
        {
            return ObterDadosDashGeral("EXTERNO");
        }
    }
}
