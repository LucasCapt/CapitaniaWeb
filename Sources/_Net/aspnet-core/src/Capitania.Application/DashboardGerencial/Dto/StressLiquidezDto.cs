using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashboardGerencial.Dto
{
    public class StressLiquidezDto
    {
        public string Fundo { get; set; }
        public double SaqueStress { get; set; }
        public double LiqDisponivel { get; set; }
        public double LiqReq { get; set; }
        public double Percentile { get; set; }

    }
}
