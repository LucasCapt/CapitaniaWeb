using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capitania.Web.Models.DashboardFundos
{
    public class TQuotaModel
    {
        public DateTime Data { get; set; }
        public int Fundo { get; set; }
        public float Quota { get; set; }
    }
}
