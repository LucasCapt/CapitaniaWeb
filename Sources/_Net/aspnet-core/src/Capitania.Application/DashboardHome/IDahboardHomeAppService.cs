using Capitania.DashboardHome.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashboardHome
{
    public interface IDahboardHomeAppService
    {
        List<HistoricoPLConsolidadoDto> ObterDadosHistoricoPLConsolidado();
        List<HistoricoCaixaConsolidadoDto> ObterDadosCaixaPLConsolidado();
        List<HistoricoPLAtivoTotalDto> ObterDadosPLAtivoTotal();
        DashboardNumerosDto ObterDadosNumeros();
        List<DadosConcentracaoDto> ObterDadosConcentracao();
        List<DadosHistoricoBreachesDto> ObterDadosHistoricoBreaches();
    }
}
