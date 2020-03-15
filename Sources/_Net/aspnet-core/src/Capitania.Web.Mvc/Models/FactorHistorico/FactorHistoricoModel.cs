using Capitania.FactorHist.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capitania.Web.Models.FactorHistorico
{
    public class FactorHistoricoModel
    {
        public List<FactorHistDto> ListagemHistoricoDolar { get; set; }
        public List<FactorHistDto> ListagemHistoricoIDA { get; set; }
        public List<FactorHistDto> ListagemHistoricoIFIX { get; set; }
        public List<FactorHistDto> ListagemHistoricoIMAB5 { get; set; }
        public List<FactorHistDto> ListagemHistoricoIPCA10Y { get; set; }
        public List<FactorHistDto> ListagemHistoricoIPCA2Y { get; set; }
        public List<FactorHistDto> ListagemHistoricoIPCA5Y { get; set; }
        public List<FactorHistDto> ListagemHistoricoPRE2Y { get; set; }
        public List<FactorHistDto> ListagemHistoricoPRE5Y { get; set; }
    }
}
