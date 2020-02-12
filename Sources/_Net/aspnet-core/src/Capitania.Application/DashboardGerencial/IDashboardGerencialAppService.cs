using Capitania.DashboardGerencial.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashboardGerencial
{
    public interface IDashboardGerencialAppService
    {
        List<FundoAssetDto> ObterFundosAsset(DateTime vDataBase);
        List<CashReportDto> ObterCashReport(DateTime vDataBase);
        List<StressLiquidezDto> ObterStressLiquidez(DateTime vDataBase);
        List<ViolacoesDto> ObterDadosViolacoesBreachs(DateTime vDataBase);
        List<ViolacoesDto> ObterDadosViolacoesWarnings(DateTime vDataBase);
        List<CreditScoreActionDto> ObterCreditScore(DateTime vDataBase);
        List<ConcentracaoDto> ObterConcentracao(DateTime vDataBase);
        List<ContrapartesDto> ObterContrapartes(DateTime vDataBase)
    }
}
