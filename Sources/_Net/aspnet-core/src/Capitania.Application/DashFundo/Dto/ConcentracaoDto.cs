using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashFundo.Dto
{
    public class ConcentracaoDto
    {
        public string Fundo { get; set; }
        public string Propriedade { get; set; }
        public string ValorPropriedade { get; set; }
        public double Concentracao { get; set; }

        public double ConcentracaoConvertida
        {
            get
            {
                return Math.Round(this.Concentracao * 100, 1);
            }
        }
    }
}
