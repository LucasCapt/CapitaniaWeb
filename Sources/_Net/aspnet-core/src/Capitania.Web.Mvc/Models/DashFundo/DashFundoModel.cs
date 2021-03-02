using Capitania.DashFundo.Dto;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capitania.Web.Models.DashFundo
{
    public class DashFundoModel
    {
        public DashFundoDto Dados { get; set; }
        public FundoDto Fundo { get; set; }
        public long IDFundo { get; set; }
        public SelectList ListaFundos { get; set; }
        public bool ExibirDados { get; set; }

        public List<ConcentracaoDto> Concentracao { get; set; }

        public List<ConcentracaoDto> ConcentracaoRating
        {
            get
            {
                return this.Concentracao.FindAll(w => w.Propriedade.Equals("rating")).OrderBy(k => k.ConcentracaoConvertida).ToList();
            }
        }

        public List<ConcentracaoDto> ConcentracaoTomador
        {
            get
            {
                return this.Concentracao.FindAll(w => w.Propriedade.Equals("tomador")).OrderBy(k => k.ConcentracaoConvertida).ToList();
            }
        }

        public List<ConcentracaoDto> ConcentracaoSegmento
        {
            get
            {
                return this.Concentracao.FindAll(w => w.Propriedade.Equals("segmento")).OrderBy(k => k.ConcentracaoConvertida).ToList();
            }
        }
    }
}
