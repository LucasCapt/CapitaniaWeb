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
                return this.Concentracao.FindAll(w => w.Propriedade.Equals("rating")).OrderBy(k => k.ConcentracaoConvertida).ToList();
            }
        }

        public List<DadosConcentracaoDto> ConcentracaoTomador
        {
            get
            {
                return this.Concentracao.FindAll(w => w.Propriedade.Equals("tomador")).OrderBy(k => k.ConcentracaoConvertida).ToList();
            }
        }

        public List<DadosConcentracaoDto> ConcentracaoSegmento
        {
            get
            {
                return this.Concentracao.FindAll(w => w.Propriedade.Equals("segmento")).OrderBy(k => k.ConcentracaoConvertida).ToList();
            }
        }

        public List<DadosHistoricoBreachesDto> HistoricoFalhas { get; set; }

        public List<DadosCashDozeMeses> CashDozeMeses { get; set; }
    }
}
