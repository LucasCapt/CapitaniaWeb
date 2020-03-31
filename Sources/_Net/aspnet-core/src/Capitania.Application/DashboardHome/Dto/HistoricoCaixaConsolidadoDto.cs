using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashboardHome.Dto
{
    public class HistoricoCaixaConsolidadoDto
    {
        public DateTime DataInfo { get; set; }
        public double Caixa { get; set; }

        public double CaixaSintetico
        {
            get
            {
                return this.Caixa / 1000000;
            }
        }
    }
}
