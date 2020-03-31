using Capitania.DashboardControle.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashboardControle
{
    public interface IDashboardControleAppService
    {
        List<DashBoardControleFundoDto> ObterDadosFundoAsset(DateTime vDataBase);

        List<DashBoardControleFundoDto> ObterDadosFundoADV(DateTime vDataBase);

        List<DashboardControleLiquidezDto> ObterDadosLiquidez(DateTime vDataBase);

        List<DashboardControleNecessidadeCaixaDto> ObterDadosNecessidadeCaixa(DateTime vDataBase);

        List<DashboardControleViolacoesDto> ObterDadosViolacoesBreachs(DateTime vDataBase);

        List<DashboardControleViolacoesDto> ObterDadosViolacoesWarnings(DateTime vDataBase);
    }
}
