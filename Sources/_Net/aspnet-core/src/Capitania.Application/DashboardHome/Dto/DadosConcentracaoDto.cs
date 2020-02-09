using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashboardHome.Dto
{
    public class DadosConcentracaoDto
    {
        public string Fundo { get; set; }
        public string Propriedade { get; set; }
        public string ValorPropriedade { get; set; }
        public double Concentracao { get; set; }

        public double ConcentracaoConvertida
        {
            get
            {
                return this.Concentracao * 100;
            }
        }
    }
}
