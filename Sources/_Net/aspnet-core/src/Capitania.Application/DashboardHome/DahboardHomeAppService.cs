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

            vSQL.AppendLine("SELECT datainfo as DataInfo, pl as PL");
            vSQL.AppendLine("  FROM thistrisk");
            vSQL.AppendLine(" WHERE fundo = '_CONSOLIDADO'");
            vSQL.AppendLine("   and datainfo between cast(dateadd(year, -2, getdate()) as date) and cast(GETDATE() as date)");
            vSQL.AppendLine(" ORDER BY DataInfo");

            List<HistoricoPLConsolidadoDto> vDados = GeneralHelper.GetData<HistoricoPLConsolidadoDto>(vSQL.ToString());

            return vDados;
        }

        public List<HistoricoCaixaConsolidadoDto> ObterDadosCaixaPLConsolidado()
        {
            StringBuilder vSQL = new StringBuilder();

            vSQL.AppendLine("SELECT distinct TOP 10 datainfo as DataInfo, (caixa * pl) as Caixa ");
            vSQL.AppendLine("  FROM thistrisk");
            vSQL.AppendLine(" WHERE fundo = '_CONSOLIDADO'");
            vSQL.AppendLine(" ORDER BY DataInfo Desc");

            List<HistoricoCaixaConsolidadoDto> vDados = GeneralHelper.GetData<HistoricoCaixaConsolidadoDto>(vSQL.ToString());

            return vDados.OrderByDescending(w => w.DataInfo).Take(12).ToList(); ;
        }

        public List<HistoricoPLAtivoTotalDto> ObterDadosPLAtivoTotal()
        {
            StringBuilder vSQL = new StringBuilder();

            vSQL.AppendLine("SELECT DataRun as DataInfo, pl as PL");
            vSQL.AppendLine("  FROM thistrisk");
            vSQL.AppendLine(" WHERE fundo = '_CONS_ATIVO'");

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

            vSQL.AppendLine("SELECT [data] as DataFalha, count(*) as NumeroFalhas");
            vSQL.AppendLine("  FROM THistCompBreaches");
            vSQL.AppendLine(" WHERE TIPO = 'BREACH'");
            vSQL.AppendLine(" GROUP BY [data]");

            List<DadosHistoricoBreachesDto> vDados = GeneralHelper.GetData<DadosHistoricoBreachesDto>(vSQL.ToString());

            return vDados.OrderByDescending(w => w.DataFalha).Take(12).ToList(); ;
        }
    }
}
