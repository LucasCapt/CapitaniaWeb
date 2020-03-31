using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashFundo.Dto
{
    public class CashReportDto
    {
        public DateTime DataInfo { get; set; }
        public double Disponivel { get; set; }
        public double Cash { get; set; }
        public double PercentualCash { get; set; }
        public double Free { get; set; }
        public double PercentualFree { get; set; }
        public double LIQ3m { get; set; }
        public double REG3m { get; set; }
        public double CashFree3m { get; set; }
    }
}
