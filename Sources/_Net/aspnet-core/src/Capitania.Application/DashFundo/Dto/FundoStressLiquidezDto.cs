using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashFundo.Dto
{
    public class FundoStressLiquidezDto
    {
        public string NomeFundo { get; set; }
        public DateTime DataStress { get; set; }
        public double StressLiquidez { get; set; }
    }
}
