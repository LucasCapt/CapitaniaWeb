using Abp.Authorization;
using Capitania.Authorization;
using Capitania.DashboardControle.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashboardControle
{
    [AbpAuthorize(PermissionNames.Pages_DashboardControle)]
    public class DashboardControleAppService : CapitaniaAppServiceBase, IDashboardControleAppService
    {
        private List<DashBoardControleFundoDto> ObterDadosFundo(string Area, DateTime vDataBase)
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT Fundo, PL as Size, DISP as Dispd0, CAIXA as Caixa, VAR as Var, VARQUOTA as VarQuot, STRESS as Stress, RISKMKTOK as MKTRisk, crd_el as ElExt, DATAINFO as Data");
            vSQL.AppendLine("  FROM THISTRISK");
            vSQL.AppendLine(String.Format(" WHERE [DATARUN] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine(String.Format("   AND AREA = '{0}'", Area));
            vSQL.AppendLine("   AND FUNDSTATUS <> 'INV'");
            vSQL.AppendLine(" UNION");
            vSQL.AppendLine("SELECT Fundo + ' - DADOS INVÁLIDOS', 0 as Size, 0 as Dispd0, 0 as Caixa, 0 as Var, 0 as VarQuot, 0 as Stress, '' as MKTRisk, 0 as ElExt, '' as Data");
            vSQL.AppendLine("  FROM THISTRISK");
            vSQL.AppendLine(String.Format(" WHERE [DATARUN] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine(String.Format("   AND AREA = '{0}'", Area));
            vSQL.AppendLine("   AND FUNDSTATUS = 'INV'");

            List <DashBoardControleFundoDto> vDados = GeneralHelper.GetData<DashBoardControleFundoDto>(vSQL.ToString());

            return vDados;
        }

        public List<DashBoardControleFundoDto> ObterDadosFundoAsset(DateTime vDataBase)
        {
            return ObterDadosFundo("ASSET", vDataBase);
        }

        public List<DashBoardControleFundoDto> ObterDadosFundoADV(DateTime vDataBase)
        {
            return ObterDadosFundo("ADV", vDataBase);
        }

        public List <DashboardControleLiquidezDto> ObterDadosLiquidez(DateTime vDataBase)
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT Fundo, Liq_ok as Compliance, LIQ_1 as D1, LIQ_5 as D5, LIQ_21 as D21, LIQ_42 as D42, LIQ_63 as D63, LIQ_126 as D126, LIQ_252 as D252");
            vSQL.AppendLine("  FROM THISTRISK");
            vSQL.AppendLine(String.Format(" WHERE [DATARUN] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine("   AND NOT (FUNDTYPE IN ('CONS', 'CLOSED') OR AREA = 'EXTERNO')");
            vSQL.AppendLine("   AND FUNDSTATUS <> 'INV'");
            vSQL.AppendLine(" ORDER BY VAR DESC");

            List<DashboardControleLiquidezDto> vDados = GeneralHelper.GetData<DashboardControleLiquidezDto>(vSQL.ToString());

            return vDados;
        }
        
        public List<DashboardControleNecessidadeCaixaDto> ObterDadosNecessidadeCaixa(DateTime vDataBase)
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT Fundo, Liq_ok as Compliance, ");
            vSQL.AppendLine("       REQ_CASH_1 / 1000000 as D1, ");
            vSQL.AppendLine("       REQ_CASH_5 / 1000000 as D5, ");
            vSQL.AppendLine("       REQ_CASH_21 / 1000000 as D21, ");
            vSQL.AppendLine("       REQ_CASH_42 / 1000000 as D42, ");
            vSQL.AppendLine("       REQ_CASH_63 / 1000000 as D63, ");
            vSQL.AppendLine("       REQ_CASH_126 / 1000000 as D126, ");
            vSQL.AppendLine("       REQ_CASH_252 / 1000000 as D252");
            vSQL.AppendLine("  FROM THISTRISK");
            vSQL.AppendLine(String.Format(" WHERE [DATARUN] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine("   AND NOT (FUNDTYPE IN ('CONS', 'CLOSED') OR AREA = 'EXTERNO')");
            vSQL.AppendLine("   AND FUNDSTATUS <> 'INV'");
            vSQL.AppendLine("   AND LIQ_OK = 'BREACH'");
            vSQL.AppendLine(" ORDER BY VAR DESC");

            List<DashboardControleNecessidadeCaixaDto> vDados = GeneralHelper.GetData<DashboardControleNecessidadeCaixaDto>(vSQL.ToString());

            return vDados;
        }

        public List<DashboardControleViolacoesDto> ObterDadosViolacoesBreachs(DateTime vDataBase)
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT Fundo, Regra, (Alocacao/1000000) as Alocacao, RegraTexto as TextoRegra, Papeis");
            vSQL.AppendLine("  FROM THISTCOMPBREACHES");
            vSQL.AppendLine(String.Format(" WHERE [DATA] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine("   AND TIPOLIMITE = 'V'");
            vSQL.AppendLine("   AND ABS(ALOCACAO) > 1000000");
            vSQL.AppendLine("   AND TIPO = 'BREACH'");
            vSQL.AppendLine("   AND ESCOPO = 'CTRL'");
            vSQL.AppendLine(" UNION");
            vSQL.AppendLine("SELECT Fundo, Regra, (Alocacao/1000) as Alocacao, RegraTexto as TextoRegra, Papeis");
            vSQL.AppendLine("  FROM THISTCOMPBREACHES");
            vSQL.AppendLine(String.Format(" WHERE [DATA] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine("   AND TIPOLIMITE = 'V'");
            vSQL.AppendLine("   AND (ALOCACAO > 1000 AND ALOCACAO <=1000000)");
            vSQL.AppendLine("   AND TIPO = 'BREACH'");
            vSQL.AppendLine("   AND ESCOPO = 'CTRL'");
            vSQL.AppendLine(" UNION");
            vSQL.AppendLine("SELECT Fundo, Regra, Alocacao, RegraTexto as TextoRegra, Papeis");
            vSQL.AppendLine("  FROM THISTCOMPBREACHES");
            vSQL.AppendLine(String.Format(" WHERE [DATA] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine("   AND TIPOLIMITE <> 'V'");
            vSQL.AppendLine("   AND TIPO = 'BREACH'");
            vSQL.AppendLine("   AND ESCOPO = 'CTRL'");

            List<DashboardControleViolacoesDto> vDados = GeneralHelper.GetData<DashboardControleViolacoesDto>(vSQL.ToString());

            return vDados;
        }

        public List<DashboardControleViolacoesDto> ObterDadosViolacoesWarnings(DateTime vDataBase)
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT Fundo, Regra, (Alocacao/1000000) as Alocacao, RegraTexto as TextoRegra, Papeis");
            vSQL.AppendLine("  FROM THISTCOMPBREACHES");
            vSQL.AppendLine(String.Format(" WHERE [DATA] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine("   AND TIPOLIMITE = 'V'");
            vSQL.AppendLine("   AND ABS(ALOCACAO) > 1000000");
            vSQL.AppendLine("   AND TIPO = 'BREACH'");
            vSQL.AppendLine("   AND ESCOPO = 'WARN'");
            vSQL.AppendLine(" UNION");
            vSQL.AppendLine("SELECT Fundo, Regra, (Alocacao/1000) as Alocacao, RegraTexto as TextoRegra, Papeis");
            vSQL.AppendLine("  FROM THISTCOMPBREACHES");
            vSQL.AppendLine(String.Format(" WHERE [DATA] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine("   AND TIPOLIMITE = 'V'");
            vSQL.AppendLine("   AND (ALOCACAO > 1000 AND ALOCACAO <=1000000)");
            vSQL.AppendLine("   AND TIPO = 'WARN'");
            vSQL.AppendLine("   AND ESCOPO = 'CTRL'");
            vSQL.AppendLine(" UNION");
            vSQL.AppendLine("SELECT Fundo, Regra, Alocacao, RegraTexto as TextoRegra, Papeis");
            vSQL.AppendLine("  FROM THISTCOMPBREACHES");
            vSQL.AppendLine(String.Format(" WHERE [DATA] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine("   AND TIPOLIMITE <> 'V'");
            vSQL.AppendLine("   AND TIPO = 'WARN'");
            vSQL.AppendLine("   AND ESCOPO = 'CTRL'");

            List<DashboardControleViolacoesDto> vDados = GeneralHelper.GetData<DashboardControleViolacoesDto>(vSQL.ToString());

            return vDados;
        }
    }
}
