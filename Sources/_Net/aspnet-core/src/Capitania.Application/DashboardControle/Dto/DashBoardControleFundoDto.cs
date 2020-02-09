using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashboardControle.Dto
{
    public class DashBoardControleFundoDto
    {
        public string Fundo { get; set; }
        public double Size { get; set; }
        public double Dispd0 { get; set; }
        public double Dispd0Normalizado
        {
            get
            {
                return this.Dispd0 / 1000000;
            }
        }
        public double Caixa { get; set; }
        public double Var { get; set; }
        public double VarQuot { get; set; }
        public double Stress { get; set; }
        public string MKTRisk { get; set; }
        public double ElExt { get; set; }
        public DateTime? Data { get; set; }
    }
}
