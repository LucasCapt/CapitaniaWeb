using Capitania.DashboardHome.Dto;
using Capitania.EntityFrameworkCore;
using Capitania.TConfiguracao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashboardHome
{
    public class DahboardHomeAppService : CapitaniaAppServiceBase, IDahboardHomeAppService
    {
        public List<HistoricoPLConsolidadoDto> ObterDadosHistoricoPLConsolidado()
        {
            StringBuilder vSQL = new StringBuilder();

            //vSQL.AppendLine("SELECT datainfo as DataInfo, pl as PL");
            //vSQL.AppendLine("  FROM thistrisk");
            //vSQL.AppendLine(" WHERE fundo = '_CONSOLIDADO'");
            //vSQL.AppendLine("   and datainfo between cast(dateadd(year, -2, getdate()) as date) and cast(GETDATE() as date)");
            //vSQL.AppendLine(" ORDER BY DataInfo");

            vSQL.AppendLine("SELECT DataRun as DataInfo, PL AS PL");
            vSQL.AppendLine("  FROM THistRisk,");
            vSQL.AppendLine("       (SELECT CONVERT(VARCHAR(7), DataRun, 126) AS anoMes, MAX(DataRun) AS UltimaDataMes");
            vSQL.AppendLine("          FROM THistRisk");
            vSQL.AppendLine("         WHERE CONVERT(VARCHAR(7), DataRun, 126) IN (SELECT DISTINCT CONVERT(VARCHAR(7), DataRun, 126) AS anoMes");
            vSQL.AppendLine("                                                       FROM THistRisk");
            vSQL.AppendLine("                                                      WHERE fundo = '_CONSOLIDADO'");
            vSQL.AppendLine("                                                        AND DataRun > CAST(DATEADD(year, -2, GETDATE()) as DATE))");
            vSQL.AppendLine("         GROUP BY CONVERT(VARCHAR(7), DataRun, 126)) AS Tabela1");
            vSQL.AppendLine(" WHERE Tabela1.UltimaDataMes = DataRun");
            vSQL.AppendLine("   AND fundo = '_CONSOLIDADO'");
            vSQL.AppendLine(" ORDER BY DataRun");

            return GeneralHelper.GetData<HistoricoPLConsolidadoDto>(vSQL.ToString());

        }

        public List<HistoricoCaixaConsolidadoDto> ObterDadosCaixaPLConsolidado()
        {
            StringBuilder vSQL = new StringBuilder();

            vSQL.AppendLine("SELECT DataRun DataInfo, (caixa * pl) AS Caixa");
            vSQL.AppendLine("  FROM THistRisk,");
            vSQL.AppendLine("       (SELECT CONVERT(VARCHAR(7), DataRun, 126) AS anoMes, MAX(DataRun) AS UltimaDataMes");
            vSQL.AppendLine("          FROM THistRisk");
            vSQL.AppendLine("         WHERE CONVERT(VARCHAR(7), DataRun, 126) IN (SELECT DISTINCT CONVERT(VARCHAR(7), DataRun, 126) AS anoMes");
            vSQL.AppendLine("                                                       FROM THistRisk");
            vSQL.AppendLine("                                                      WHERE fundo = '_CONSOLIDADO'");
            vSQL.AppendLine("                                                        AND DataRun > CAST(DATEADD(year, -2, GETDATE()) as DATE))");
            vSQL.AppendLine("         GROUP BY CONVERT(VARCHAR(7), DataRun, 126)) AS Tabela1");
            vSQL.AppendLine(" WHERE Tabela1.UltimaDataMes = DataRun");
            vSQL.AppendLine("   AND fundo = '_CONSOLIDADO'");
            vSQL.AppendLine(" ORDER BY DataRun");

            return GeneralHelper.GetData<HistoricoCaixaConsolidadoDto>(vSQL.ToString());

        }

        public List<HistoricoPLAtivoTotalDto> ObterDadosPLAtivoTotal()
        {
            StringBuilder vSQL = new StringBuilder();
            //As subqueries funcionam da mais interna para a mais externa;
            //Primeiro, busca os pultimos doze meses em format yyyy-MM. Veja o "SELECT DISTINCT"
            //Depois, usa o resultado da subquery acima para buscar as últimas datas registradas de cada um dos últimos dozes meses (Tabela1)
            //Por fim, buscam os registros de históricos para as últimas datas com a data no formato yyyy-MM
            vSQL.AppendLine("SELECT DataRun as DataInfo, PL AS PL");
            vSQL.AppendLine("  FROM THistRisk,");
            vSQL.AppendLine("       (SELECT CONVERT(VARCHAR(7), DataRun, 126) AS anoMes, MAX(DataRun) AS UltimaDataMes");
            vSQL.AppendLine("          FROM THistRisk");
            vSQL.AppendLine("         WHERE CONVERT(VARCHAR(7), DataRun, 126) IN (SELECT DISTINCT CONVERT(VARCHAR(7), DataRun, 126) AS anoMes");
            vSQL.AppendLine("                                                       FROM THistRisk");
            vSQL.AppendLine("                                                      WHERE fundo = '_CONS_ATIVO'");
            vSQL.AppendLine("                                                        AND DataRun > CAST(DATEADD(year, -1, GETDATE()) as DATE))");
            vSQL.AppendLine("         GROUP BY CONVERT(VARCHAR(7), DataRun, 126)) AS Tabela1");
            vSQL.AppendLine(" WHERE Tabela1.UltimaDataMes = DataRun");
            vSQL.AppendLine("   AND fundo = '_CONS_ATIVO'");
            vSQL.AppendLine(" ORDER BY DataRun");

            List<HistoricoPLAtivoTotalDto> vDados = GeneralHelper.GetData<HistoricoPLAtivoTotalDto>(vSQL.ToString());

            return vDados.OrderByDescending(w => w.DataInfo).Take(30).ToList(); ;
        }

        public DashboardNumerosDto ObterDadosNumeros()
        {
            DashboardNumerosDto vRetorno = new DashboardNumerosDto();
            StringBuilder vSQL = new StringBuilder();

            vSQL.AppendLine("SELECT COUNT(*) as Total");
            vSQL.AppendLine("  FROM TFundos");
            vSQL.AppendLine(" WHERE NOT (Deleted = 1 AND DT_Deleted <= GetDate())");
            vSQL.AppendLine("   AND DT_CREATED <= GetDate()");
            vSQL.AppendLine("   AND ID NOT IN (73, 60)"); //_CONS_TOTAL, _CONS_ATIVO

            vRetorno.NumeroFundos = GeneralHelper.GetCount(vSQL.ToString());

            vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT distinct ativo as Ativo");
            vSQL.AppendLine("  FROM Ttrades");

            List<DadoAtivoDto> vDados = GeneralHelper.GetData<DadoAtivoDto>(vSQL.ToString());

            vRetorno.NumeroInstrumentos = vDados.Count;

            vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT count(*)");
            vSQL.AppendLine("  FROM TRegras");
            vSQL.AppendLine(" WHERE NOT (Deleted = 1 AND DT_Deleted <= GetDate())");
            vSQL.AppendLine("   AND DT_CREATED <= GetDate()");

            vRetorno.NumeroRegras = GeneralHelper.GetCount(vSQL.ToString());

            vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT count(*)");
            vSQL.AppendLine("  FROM TPAPEL");
            vSQL.AppendLine(" WHERE NOT (Deleted = 1 AND DT_Deleted <= GetDate())");
            vSQL.AppendLine("   AND DT_CREATED <= GetDate()");

            vRetorno.NumeroPapeis = GeneralHelper.GetCount(vSQL.ToString());

            return vRetorno;
        }

        public List<DadosConcentracaoDto> ObterDadosConcentracao()
        {
            DashboardNumerosDto vRetorno = new DashboardNumerosDto();
            StringBuilder vSQL = new StringBuilder();

            string vFundoID = ParameterManager.GetParameterValue(DBParametersConstants.ConcentrationFundID);
            string vPropriedade1 = ParameterManager.GetParameterValue(DBParametersConstants.ConcentrationProperty1);
            string vPropriedade2 = ParameterManager.GetParameterValue(DBParametersConstants.ConcentrationProperty2);
            string vPropriedade3 = ParameterManager.GetParameterValue(DBParametersConstants.ConcentrationProperty3);

            vSQL.AppendLine("SELECT TConcentra.Nome as Fundo, TConcentra.Propriedade as Propriedade, ");
            vSQL.AppendLine("       TConcentra.ValorProp as ValorPropriedade, TConcentra.Concentracao as Concentracao");
            vSQL.AppendLine("  FROM TConcentra, TFundos");
            vSQL.AppendLine(String.Format(" WHERE tfundos.ID = {0}", vFundoID));
            vSQL.AppendLine("   AND tfundos.Nome = TConcentra.Nome");
            vSQL.AppendLine(String.Format("   AND TConcentra.Propriedade in ('{0}', '{1}', '{2}')", vPropriedade1, vPropriedade2, vPropriedade3));
            vSQL.AppendLine("   AND TConcentra.[Data]  = (SELECT MAX([DATA]) FROM TConcentra)");
            vSQL.AppendLine("   AND TConcentra.ValorProp <> ''");
            vSQL.AppendLine(" ORDER BY TConcentra.Nome, TConcentra.Propriedade;");

            List<DadosConcentracaoDto> vDados = GeneralHelper.GetData<DadosConcentracaoDto>(vSQL.ToString());

            return vDados;

        }

        public List<DadosHistoricoBreachesDto> ObterDadosHistoricoBreaches()
        {
            StringBuilder vSQL = new StringBuilder();

            vSQL.AppendLine("SELECT CAST(CONCAT(CONVERT(VARCHAR(7), [Data], 126), '-01') as Date) as DataFalha, count(*) as NumeroFalhas");
            vSQL.AppendLine("  FROM THistCompBreaches");
            vSQL.AppendLine(" WHERE TIPO = 'BREACH'");
            vSQL.AppendLine("   AND [Data] > cast(dateadd(year, -1, getdate()) as date)");
            vSQL.AppendLine(" GROUP BY CONCAT(CONVERT(VARCHAR(7), [Data], 126), '-01')");
            vSQL.AppendLine(" ORDER BY DataFalha");

            return GeneralHelper.GetData<DadosHistoricoBreachesDto>(vSQL.ToString());

        }

        public List<DadosCashDozeMeses> ObterDadosCashDozeMeses()
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT [Data] as DataRun, SUM(CASHFREE3M) AS CaixaLivre3m, SUM(DISPO) AS Disponivel");
            vSQL.AppendLine("  FROM TCashReportHist,");
            vSQL.AppendLine("       (SELECT CONVERT(VARCHAR(7), [Data], 126) as anoMes, MAX([Data]) AS UltimaDataMes");
            vSQL.AppendLine("          FROM TCashReportHist");
            vSQL.AppendLine("         WHERE CONVERT(VARCHAR(7), [Data], 126) IN (SELECT DISTINCT CONVERT(VARCHAR(7), [Data], 126) AS anoMes");
            vSQL.AppendLine("                                                      FROM TCashReportHist");
            vSQL.AppendLine("                                                     WHERE [Data] > CAST(DATEADD(YEAR, -1, GETDATE()) AS DATE))");
            vSQL.AppendLine("                                                     GROUP BY CONVERT(VARCHAR(7), [Data], 126)) AS Tabela1");
            vSQL.AppendLine(" WHERE Tabela1.UltimaDataMes = [Data]");
            vSQL.AppendLine(" GROUP BY [Data]");
            vSQL.AppendLine(" ORDER BY [Data]");

            return GeneralHelper.GetData<DadosCashDozeMeses>(vSQL.ToString());
        }
    }
}
