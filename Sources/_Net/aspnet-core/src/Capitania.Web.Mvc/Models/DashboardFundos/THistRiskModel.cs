using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capitania.Web.Models.DashboardFundos
{
    public class THistRiskModel
    {
        public DateTime Data { get; set; }
        public int Fundo { get; set; }
        public float VarQuota { get; set; }
    }
}
