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
        public float PL { get; set; }
        public float Caixa { get; set; }
        public float CRD_EL1 { get; set; }
        public float VAR { get; set; }
        public float Stress { get; set; }
        public float LIQSTRESSPERCENTILE { get; set; }
        public DateTime DataInfo { get; set; }
        public DateTime DataRun { get; set; }
    }
}
