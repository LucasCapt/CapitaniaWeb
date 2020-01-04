using Abp.Authorization;
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
        public List<DashboardGeralDto> ObterDadosDashPrincipal()
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("select fundo.Nome as NomeFundo, risco.pl, risco.caixa, risco.CRD_EL1, risco.[VaR], ");
            vSQL.AppendLine("       risco.Stress, risco.LIQSTRESSPERCENTILE, risco.DataInfo, risco.DataRun");
            vSQL.AppendLine("  from tfundos as Fundo, Thistrisk as risco");
            vSQL.AppendLine(" where fundo.nome = risco.fundo");
            vSQL.AppendLine("   and datarun = (select max(risco1.DataRun)");
            vSQL.AppendLine("                    from THistRisk as risco1");
            vSQL.AppendLine("                   where Fundo.nome = risco1.Fundo)");
            vSQL.AppendLine(" order by Nome");

            List<DashboardGeralDto> vDados;

            using (SqlConnection vConection = new SqlConnection("data source=win10dev\\sqlexpress;initial catalog=db_capitania_prd;persist security info=True;user id=sa;password=Capitania2019;MultipleActiveResultSets=True;App=EntityFramework"))
            //using (SqlConnection vConection = new SqlConnection("data source =.; initial catalog = db_capitania_prd; Trusted_Connection = True"))
            {
                vConection.Open();
                using (SqlCommand vComando = new SqlCommand(vSQL.ToString(), vConection))
                {
                    using (SqlDataReader vReader = vComando.ExecuteReader())
                    {
                        vDados = DataReaderMapToList<DashboardGeralDto>(vReader);
                    }
                }
                vConection.Close();
            }

            //formatar os dados;
            foreach (var item in vDados)
            {
                item.Caixa = Math.Round(item.Caixa * 100, 1);
                item.CRD_EL1 = Math.Round(item.CRD_EL1 * 100, 1);
                item.LIQSTRESSPERCENTILE = Math.Round(item.LIQSTRESSPERCENTILE * 100, 1);
                item.Stress = Math.Round(item.Stress * 100, 1);
                item.VAR = Math.Round(item.VAR * 100, 1);
            }

            return vDados;
        }


        private static List<T> DataReaderMapToList<T>(IDataReader dr)
        {
            List<T> list = new List<T>();
            T obj = default(T);
            while (dr.Read())
            {
                obj = Activator.CreateInstance<T>();
                foreach (PropertyInfo prop in obj.GetType().GetProperties())
                {
                    if (!object.Equals(dr[prop.Name], DBNull.Value))
                    {
                        prop.SetValue(obj, dr[prop.Name], null);
                    }
                }
                list.Add(obj);
            }
            return list;
        }
    }
}
