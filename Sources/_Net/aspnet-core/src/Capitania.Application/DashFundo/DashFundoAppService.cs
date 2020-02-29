using Abp.Authorization;
using Capitania.Authorization;
using Capitania.DashFundo.Dto;
using Capitania.EntityFrameworkCore;
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

            vSQL.AppendLine("SELECT ID as IDFundo, Nome as Nome,");
            vSQL.AppendLine("       CNPJ as CNPJ, Tipo as Tipo, Qualif as Qualificacao");
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
            vSQL.AppendLine("SELECT Fundo as IDFundo, Data as Data, Papel as Papel, Valor as Valor");
            vSQL.AppendLine("  FROM TPOSIC");
            vSQL.AppendLine(String.Format(" WHERE Fundo = {0}", IDFundo));
            vSQL.AppendLine("   AND [Data] = (SELECT MAX([DATA])");
            vSQL.AppendLine("                   FROM TPOSIC D");
            vSQL.AppendLine(String.Format("                  WHERE Fundo = {0})", IDFundo));
            vSQL.AppendLine(" ORDER BY Data Desc");

            vRetorno.Posicao = GeneralHelper.GetData<PosicaoDto>(vSQL.ToString());

            vRetorno.FundoAsset = ObterFundosAsset(vRetorno.Fundo.Nome, DateTime.Now).OrderByDescending(w=>w.Data).ToList();
            vRetorno.CashReport = ObterCashReport(vRetorno.Fundo.Nome, DateTime.Now);
            vRetorno.ViolacoesFalhas = ObterDadosViolacoesBreachs(vRetorno.Fundo.Nome, DateTime.Now);
            vRetorno.ViolacoesAlertas = ObterDadosViolacoesWarnings(vRetorno.Fundo.Nome, DateTime.Now);
            return vRetorno;
        }

        public List<ConcentracaoDto> ObterDadosConcentracao(int vFundoID)
        {
            StringBuilder vSQL = new StringBuilder();

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

            List<ConcentracaoDto> vDados = GeneralHelper.GetData<ConcentracaoDto>(vSQL.ToString());

            return vDados;

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

        public List<FundoAssetDto> ObterFundosAsset(string vNomeFundo, DateTime vDataBase)
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT Fundo as Fundo, PL as Size, CAIXA as Caixa, VAR as Var, ");
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
            vSQL.AppendLine(String.Format(" WHERE [DATARUN] >= '{0}'", vDataBase.AddDays(-30).ToString("yyyy-MM-dd")));
            vSQL.AppendLine(String.Format("   AND Fundo = '{0}'", vNomeFundo));
            vSQL.AppendLine("   AND FUNDSTATUS <> 'INV'");
            vSQL.AppendLine(" UNION");
            vSQL.AppendLine("SELECT 'Dados Inválidos' as Fundo, 0 as Size, 0 as Caixa, 0 as Var, 0 as Stress, 0 as CTMDR, 0 as CSGMNT, 0 as ElInt, 0 as UlInt, '' as Data");
            vSQL.AppendLine("  FROM THISTRISK");
            vSQL.AppendLine(String.Format(" WHERE [DATARUN] >= '{0}'", vDataBase.AddDays(-30).ToString("yyyy-MM-dd")));
            vSQL.AppendLine(String.Format("   AND Fundo = '{0}'", vNomeFundo));
            vSQL.AppendLine("   AND FUNDSTATUS = 'INV'");
            vSQL.AppendLine(" ORDER BY VAR DESC");

            List<FundoAssetDto> vDados = GeneralHelper.GetData<FundoAssetDto>(vSQL.ToString());

            return vDados;
        }

        public List<CashReportDto> ObterCashReport(string vNomeFundo, DateTime vDataBase)
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT [DATA] as DataInfo,");
            vSQL.AppendLine("       DISPO / 1000000 as Disponivel, CASH / 1000000 as Cash,");
            vSQL.AppendLine("       PCASH PercentualCash, CASHFREE / 1000000 as Free,");
            vSQL.AppendLine("       PCASHFREE PercentualFree, LIQ3M / 1000000 as LIQ3m,");
            vSQL.AppendLine("       REQ3M / 1000000 REG3m, CashFree3m / 1000000 as CashFree3m");
            vSQL.AppendLine("  FROM TCASHREPORTHIST");
            vSQL.AppendLine(String.Format(" WHERE [DATA] >= '{0}'", vDataBase.AddDays(-30).ToString("yyyy-MM-dd")));
            vSQL.AppendLine(String.Format("   AND Fundo = '{0}'", vNomeFundo));

            List<CashReportDto> vDados = GeneralHelper.GetData<CashReportDto>(vSQL.ToString());

            return vDados;
        }

        public List<ViolacoesDto> ObterDadosViolacoesBreachs(string vNomeFundo, DateTime vDataBase)
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT [DATA] as DataInfo, Regra, (Alocacao/1000000) as Alocacao, RegraTexto as TextoRegra, Papeis, 'Vermelho' as Cor");
            vSQL.AppendLine("  FROM THISTCOMPBREACHES");
            vSQL.AppendLine(String.Format(" WHERE [DATA] >= '{0}'", vDataBase.AddDays(-30).ToString("yyyy-MM-dd")));
            vSQL.AppendLine(String.Format("   AND Fundo = '{0}'", vNomeFundo));
            vSQL.AppendLine("   AND TIPOLIMITE = 'V'");
            vSQL.AppendLine("   AND ABS(ALOCACAO) > 1000000");
            vSQL.AppendLine("   AND TIPO = 'BREACH'");
            vSQL.AppendLine("   AND ESCOPO = 'GER'");
            vSQL.AppendLine(" UNION");
            vSQL.AppendLine("SELECT [DATA] as DataInfo, Regra, (Alocacao/1000) as Alocacao, RegraTexto as TextoRegra, Papeis, 'Vermelho' as Cor");
            vSQL.AppendLine("  FROM THISTCOMPBREACHES");
            vSQL.AppendLine(String.Format(" WHERE [DATA] >= '{0}'", vDataBase.AddDays(-30).ToString("yyyy-MM-dd")));
            vSQL.AppendLine(String.Format("   AND Fundo = '{0}'", vNomeFundo));
            vSQL.AppendLine("   AND TIPOLIMITE = 'V'");
            vSQL.AppendLine("   AND (ALOCACAO > 1000 AND ALOCACAO <=1000000)");
            vSQL.AppendLine("   AND TIPO = 'BREACH'");
            vSQL.AppendLine("   AND ESCOPO = 'GER'");
            vSQL.AppendLine(" UNION");
            vSQL.AppendLine("SELECT [DATA] as DataInfo, Regra, Alocacao, RegraTexto as TextoRegra, Papeis, 'Vermelho' as Cor");
            vSQL.AppendLine("  FROM THISTCOMPBREACHES");
            vSQL.AppendLine(String.Format(" WHERE [DATA] >= '{0}'", vDataBase.AddDays(-30).ToString("yyyy-MM-dd")));
            vSQL.AppendLine(String.Format("   AND Fundo = '{0}'", vNomeFundo));
            vSQL.AppendLine("   AND TIPOLIMITE <> 'V'");
            vSQL.AppendLine("   AND TIPO = 'BREACH'");
            vSQL.AppendLine("   AND ESCOPO = 'GER'");

            List<ViolacoesDto> vDados = GeneralHelper.GetData<ViolacoesDto>(vSQL.ToString());

            return vDados;
        }

        public List<ViolacoesDto> ObterDadosViolacoesWarnings(string vNomeFundo, DateTime vDataBase)
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT [DATA] as DataInfo, Regra, (Alocacao/1000000) as Alocacao, RegraTexto as TextoRegra, Papeis, 'Amarelo' as Cor");
            vSQL.AppendLine("  FROM THISTCOMPBREACHES");
            vSQL.AppendLine(String.Format(" WHERE [DATA] >= '{0}'", vDataBase.AddDays(-30).ToString("yyyy-MM-dd")));
            vSQL.AppendLine(String.Format("   AND Fundo = '{0}'", vNomeFundo));
            vSQL.AppendLine("   AND TIPOLIMITE = 'V'");
            vSQL.AppendLine("   AND ABS(ALOCACAO) > 1000000");
            vSQL.AppendLine("   AND TIPO = 'WARN'");
            vSQL.AppendLine("   AND ESCOPO = 'GER'");
            vSQL.AppendLine(" UNION");
            vSQL.AppendLine("SELECT [DATA] as DataInfo, Regra, (Alocacao/1000) as Alocacao, RegraTexto as TextoRegra, Papeis, 'Amarelo' as Cor");
            vSQL.AppendLine("  FROM THISTCOMPBREACHES");
            vSQL.AppendLine(String.Format(" WHERE [DATA] >= '{0}'", vDataBase.AddDays(-30).ToString("yyyy-MM-dd")));
            vSQL.AppendLine(String.Format("   AND Fundo = '{0}'", vNomeFundo));
            vSQL.AppendLine("   AND TIPOLIMITE = 'V'");
            vSQL.AppendLine("   AND (ALOCACAO > 1000 AND ALOCACAO <=1000000)");
            vSQL.AppendLine("   AND TIPO = 'WARN'");
            vSQL.AppendLine("   AND ESCOPO = 'GER'");
            vSQL.AppendLine(" UNION");
            vSQL.AppendLine("SELECT [DATA] as DataInfo, Regra, Alocacao, RegraTexto as TextoRegra, Papeis, 'Amarelo' as Cor");
            vSQL.AppendLine("  FROM THISTCOMPBREACHES");
            vSQL.AppendLine(String.Format(" WHERE [DATA] >= '{0}'", vDataBase.AddDays(-30).ToString("yyyy-MM-dd")));
            vSQL.AppendLine(String.Format("   AND Fundo = '{0}'", vNomeFundo));
            vSQL.AppendLine("   AND TIPOLIMITE <> 'V'");
            vSQL.AppendLine("   AND TIPO = 'WARN'");
            vSQL.AppendLine("   AND ESCOPO = 'GER'");

            List<ViolacoesDto> vDados = GeneralHelper.GetData<ViolacoesDto>(vSQL.ToString());

            return vDados;
        }
    }
}
