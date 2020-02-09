using Capitania.DashboardHome.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capitania.Web.Models.Home
{
    public class HomeDataModel
    {
        public List<HistoricoPLConsolidadoDto> HistoricoPLConsolidadado { get; set; }
        public List<HistoricoCaixaConsolidadoDto> CaixaConsolidado { get; set; }
        public List<HistoricoPLAtivoTotalDto> AtivoTotal { get; set; }
        public DashboardNumerosDto Numeros { get; set; }
        public List<DadosConcentracaoDto> Concentracao { get; set; }

        public List<DadosConcentracaoDto> ConcentracaoRating
        {
            get
            {
                return this.Concentracao.FindAll(w => w.Propriedade.Equals("rating"));
            }
        }

        public List<DadosConcentracaoDto> ConcentracaoTomador
        {
            get
            {
                return this.Concentracao.FindAll(w => w.Propriedade.Equals("tomador"));
            }
        }

        public List<DadosConcentracaoDto> ConcentracaoSegmento
        {
            get
            {
                return this.Concentracao.FindAll(w => w.Propriedade.Equals("segmento"));
            }
        }

        public List<DadosHistoricoBreachesDto> HistoricoFalhas { get; set; }
    }
}
