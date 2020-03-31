using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashboardGerencial.Dto
{
    public class LimiteCreditoConsAtivoDto
    {
        public string Regra { get; set; }
        public double Limite { get; set; }
        public double Posicao { get; set; }
        public double Delta { get; set; }
        public string Compliant { get; set; }

    }
}
