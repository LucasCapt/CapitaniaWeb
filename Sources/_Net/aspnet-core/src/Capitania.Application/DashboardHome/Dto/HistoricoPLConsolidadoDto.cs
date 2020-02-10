using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashboardHome.Dto
{
    public class HistoricoPLConsolidadoDto
    {
        public DateTime DataInfo { get; set; }
        public double PL { get; set; }
        public double PLSintetico
        {
            get
            {
                return this.PL / 1000000;
            }
        }
    }
}
