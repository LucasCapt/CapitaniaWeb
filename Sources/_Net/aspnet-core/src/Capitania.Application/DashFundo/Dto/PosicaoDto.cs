using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashFundo.Dto
{
    public class PosicaoDto
    {
        public int IDFundo { get; set; }
        public DateTime Data { get; set; }
        public double Valor { get; set; }
        public string Papel { get; set; }
        public string PapelNome { get; set; }
        public string CodigoCETIP { get; set; }
        public string PapelISIN { get; set; }
        public double PL { get; set; }
        public double ValorPL
        {
            get
            {
                return this.Valor / this.PL;
            }
        }

    }
}
