using Abp.Authorization;
using Capitania.Authorization;
using Capitania.DashboardGerencial.Dto;
using Capitania.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashboardGerencial
{
    [AbpAuthorize(PermissionNames.Pages_DashboardControle)]
    public class DashboardGerencialAppService : CapitaniaAppServiceBase, IDashboardGerencialAppService
    {
        public List<FundoAssetDto> ObterFundosAsset(DateTime vDataBase)
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT Fundo, PL as Size, CAIXA as Caixa, VAR as Var, ");
            vSQL.AppendLine("       STRESS as Stress, ");
            vSQL.AppendLine("       (SELECT COALESCE(MAX(CONCENTRACAO), 0) AS MAXCONC");
            vSQL.AppendLine("          FROM TCONCENTRA");
            vSQL.AppendLine("         WHERE TCONCENTRA.NOME = THISTRISK.FUNDO");
            vSQL.AppendLine("           AND VALORPROP NOT IN ('Tesouro', 'BNY Mellon', 'BNYMellon', 'Caixa')");
            vSQL.AppendLine(String.Format("           AND TCONCENTRA.DATA = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine(String.Format("           AND TCONCENTRA.Propriedade = '{0}') as CTMDR,", ParameterManager.GetParameterValue(DBParametersConstants.ConcentrationProperty1)));
            vSQL.AppendLine("       (SELECT COALESCE(MAX(CONCENTRACAO), 0) AS MAXCONC");
            vSQL.AppendLine("          FROM TCONCENTRA");
            vSQL.AppendLine("         WHERE TCONCENTRA.NOME = THISTRISK.FUNDO");
            vSQL.AppendLine("           AND VALORPROP NOT IN ('Tesouro', 'BNY Mellon', 'BNYMellon', 'Caixa')");
            vSQL.AppendLine(String.Format("           AND TCONCENTRA.DATA = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine(String.Format("           AND TCONCENTRA.Propriedade = '{0}') as CSGMNT,", ParameterManager.GetParameterValue(DBParametersConstants.ConcentrationProperty2)));
            vSQL.AppendLine("       crd_el1 as ElInt, crd_var1 as UlInt, DATAINFO as Data");
            vSQL.AppendLine("  FROM THISTRISK");
            vSQL.AppendLine(String.Format(" WHERE [DATARUN] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine(String.Format("   AND AREA = '{0}'", "ASSET"));
            vSQL.AppendLine("   AND FUNDSTATUS <> 'INV'");
            vSQL.AppendLine(" UNION");
            vSQL.AppendLine("SELECT Fundo + ' - DADOS INVÁLIDOS', 0 as Size, 0 as Caixa, 0 as Var, 0 as Stress, 0 as CTMDR, 0 as CSGMNT, 0 as ElInt, 0 as UlInt, '' as Data");
            vSQL.AppendLine("  FROM THISTRISK");
            vSQL.AppendLine(String.Format(" WHERE [DATARUN] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine(String.Format("   AND AREA = '{0}'", "ASSET"));
            vSQL.AppendLine("   AND FUNDSTATUS = 'INV'");
            vSQL.AppendLine(" ORDER BY VAR DESC");

            List<FundoAssetDto> vDados = GeneralHelper.GetData<FundoAssetDto>(vSQL.ToString());

            return vDados;
        }

        public List<CashReportDto> ObterCashReport(DateTime vDataBase)
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT Fundo as Fundo,");
            vSQL.AppendLine("       DISPO / 1000000 as Disponivel, CASH / 1000000 as Cash,");
            vSQL.AppendLine("       PCASH PercentualCash, CASHFREE / 1000000 as Free,");
            vSQL.AppendLine("       PCASHFREE PercentualFree, LIQ3M / 1000000 as LIQ3m,");
            vSQL.AppendLine("       REQ3M / 1000000 REG3m, CashFree3m / 1000000 as CashFree3m");
            vSQL.AppendLine("  FROM TCASHREPORTHIST");
            vSQL.AppendLine(String.Format(" WHERE [DATA] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            
            List<CashReportDto> vDados = GeneralHelper.GetData<CashReportDto>(vSQL.ToString());

            return vDados;
        }

        public List<StressLiquidezDto> ObterStressLiquidez(DateTime vDataBase)
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT Fundo as Fundo,");
            vSQL.AppendLine("       (LIQSTRESSNEED / 1000000) as SaqueStress, (LIQSTRESSavail / 1000000) as LiqDisponivel,");
            vSQL.AppendLine("       (LIQSTRESSREQ /1000000) as LiqReq, LIQSTRESSPERCENTILE as Percentile");
            vSQL.AppendLine("  FROM THISTRISK");
            vSQL.AppendLine(String.Format(" WHERE [DATARUN] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine("   AND NOT (FUNDTYPE IN ('CONS', 'CLOSED') OR AREA = 'EXTERNO')");

            List<StressLiquidezDto> vDados = GeneralHelper.GetData<StressLiquidezDto>(vSQL.ToString());

            return vDados;
        }

        public List<ViolacoesDto> ObterDadosViolacoesBreachs(DateTime vDataBase)
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT Fundo, Regra, (Alocacao/1000000) as Alocacao, RegraTexto as TextoRegra, Papeis, 'Vermelho' as Cor");
            vSQL.AppendLine("  FROM THISTCOMPBREACHES");
            vSQL.AppendLine(String.Format(" WHERE [DATA] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine("   AND TIPOLIMITE = 'V'");
            vSQL.AppendLine("   AND ABS(ALOCACAO) > 1000000");
            vSQL.AppendLine("   AND TIPO = 'BREACH'");
            vSQL.AppendLine("   AND ESCOPO = 'GER'");
            vSQL.AppendLine(" UNION");
            vSQL.AppendLine("SELECT Fundo, Regra, (Alocacao/1000) as Alocacao, RegraTexto as TextoRegra, Papeis, 'Vermelho' as Cor");
            vSQL.AppendLine("  FROM THISTCOMPBREACHES");
            vSQL.AppendLine(String.Format(" WHERE [DATA] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine("   AND TIPOLIMITE = 'V'");
            vSQL.AppendLine("   AND (ALOCACAO > 1000 AND ALOCACAO <=1000000)");
            vSQL.AppendLine("   AND TIPO = 'BREACH'");
            vSQL.AppendLine("   AND ESCOPO = 'GER'");
            vSQL.AppendLine(" UNION");
            vSQL.AppendLine("SELECT Fundo, Regra, Alocacao, RegraTexto as TextoRegra, Papeis, 'Vermelho' as Cor");
            vSQL.AppendLine("  FROM THISTCOMPBREACHES");
            vSQL.AppendLine(String.Format(" WHERE [DATA] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine("   AND TIPOLIMITE <> 'V'");
            vSQL.AppendLine("   AND TIPO = 'BREACH'");
            vSQL.AppendLine("   AND ESCOPO = 'GER'");

            List<ViolacoesDto> vDados = GeneralHelper.GetData<ViolacoesDto>(vSQL.ToString());

            return vDados;
        }

        public List<ViolacoesDto> ObterDadosViolacoesWarnings(DateTime vDataBase)
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT Fundo, Regra, (Alocacao/1000000) as Alocacao, RegraTexto as TextoRegra, Papeis, 'Amarelo' as Cor");
            vSQL.AppendLine("  FROM THISTCOMPBREACHES");
            vSQL.AppendLine(String.Format(" WHERE [DATA] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine("   AND TIPOLIMITE = 'V'");
            vSQL.AppendLine("   AND ABS(ALOCACAO) > 1000000");
            vSQL.AppendLine("   AND TIPO = 'WARN'");
            vSQL.AppendLine("   AND ESCOPO = 'GER'");
            vSQL.AppendLine(" UNION");
            vSQL.AppendLine("SELECT Fundo, Regra, (Alocacao/1000) as Alocacao, RegraTexto as TextoRegra, Papeis, 'Amarelo' as Cor");
            vSQL.AppendLine("  FROM THISTCOMPBREACHES");
            vSQL.AppendLine(String.Format(" WHERE [DATA] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine("   AND TIPOLIMITE = 'V'");
            vSQL.AppendLine("   AND (ALOCACAO > 1000 AND ALOCACAO <=1000000)");
            vSQL.AppendLine("   AND TIPO = 'WARN'");
            vSQL.AppendLine("   AND ESCOPO = 'GER'");
            vSQL.AppendLine(" UNION");
            vSQL.AppendLine("SELECT Fundo, Regra, Alocacao, RegraTexto as TextoRegra, Papeis, 'Amarelo' as Cor");
            vSQL.AppendLine("  FROM THISTCOMPBREACHES");
            vSQL.AppendLine(String.Format(" WHERE [DATA] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine("   AND TIPOLIMITE <> 'V'");
            vSQL.AppendLine("   AND TIPO = 'WARN'");
            vSQL.AppendLine("   AND ESCOPO = 'GER'");

            List<ViolacoesDto> vDados = GeneralHelper.GetData<ViolacoesDto>(vSQL.ToString());

            return vDados;
        }

        public List<CreditScoreActionDto> ObterCreditScore(DateTime vDataBase)
        {
            /*
            public string Nome { get; set; }
            public string Score { get; set; }
            public string ScoreW { get; set; }
            public string Action { get; set; } 
            */
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT Nome as Nome, TRATINGS.Ratings + ' (' + RatingFromScore(TRATINGS.Ratings) + ')' as Score ");
            vSQL.AppendLine("  FROM TRATINGNAMES left outer join TRATINGS on TRATINGS.ID = TRATINGNAMES.ID");
            vSQL.AppendLine(String.Format(" WHERE TRATINGS.[DATA] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine(" ORDER BY SETOR, NOME, TRATINGS.[DATA] DESC");
            

            List<CreditScoreActionDto> vDados = GeneralHelper.GetData<CreditScoreActionDto>(vSQL.ToString());

            return vDados;
        }

        public List<ConcentracaoDto> ObterConcentracao(DateTime vDataBase)
        {
            StringBuilder vSQL = new StringBuilder();
            string vFundoID = ParameterManager.GetParameterValue(DBParametersConstants.ConcentrationFundID);

            string vPropriedade1 = ParameterManager.GetParameterValue(DBParametersConstants.ConcentrationProperty1);
            string vPropriedade2 = ParameterManager.GetParameterValue(DBParametersConstants.ConcentrationProperty2);
            string vPropriedade3 = ParameterManager.GetParameterValue(DBParametersConstants.ConcentrationProperty3);

            vSQL.AppendLine("SELECT Propriedade as Propriedade, ValorProp as Nome, (TCONCENTRA.Concentracao) as Percentual");
            vSQL.AppendLine("  FROM TCONCENTRA, TFUNDOS");
            vSQL.AppendLine(" WHERE TFUNDOS.NOME = TCONCENTRA.NOME");
            vSQL.AppendLine(String.Format("   AND TFUNDOS.ID = {0}", vFundoID));
            vSQL.AppendLine(String.Format("   AND [DATA] = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine(String.Format("   AND Propriedade in ( '{0}', '{1}', '{2}')", vPropriedade1, vPropriedade2, vPropriedade3));
            vSQL.AppendLine(" ORDER BY TCONCENTRA.CONCENTRACAO DESC");

            List<ConcentracaoDto> vDados = GeneralHelper.GetData<ConcentracaoDto>(vSQL.ToString());

            return vDados;
        }

        public List<ContrapartesDto> ObterContrapartes(DateTime vDataBase)
        {
            StringBuilder vSQL = new StringBuilder();

            vSQL.AppendLine("SELECT Nome as Contraparte, RazaoSocial as RazaoSocial, Atualizado as Atualizacao");
            vSQL.AppendLine("  FROM TCTPT");
            vSQL.AppendLine(" WHERE PERFILRISCO='ALTO'");

            List<ContrapartesDto> vDados = GeneralHelper.GetData<ContrapartesDto>(vSQL.ToString());

            return vDados;
        }
    }
}
