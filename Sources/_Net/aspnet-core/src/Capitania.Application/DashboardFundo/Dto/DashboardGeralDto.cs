using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashboardFundo.Dto
{
    public class DashboardGeralDto
    {
        public string NomeFundo { get; set; }
        public double PL { get; set; }
        public double Caixa { get; set; }
        public double CRD_EL1 { get; set; }
        public double VAR { get; set; }
        public double Stress { get; set; }
        public double LIQSTRESSPERCENTILE { get; set; }
        public DateTime DataInfo { get; set; }
        public DateTime DataRun { get; set; }
    }
}
