using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capitania.Web.Models.DashboardFundos
{
    public class TPosicModel
    {
        public int Fundo { get; set; }
        public string Papel { get; set; }
        public string ISIN { get; set; }
        public float Valor { get; set; }
        public DateTime Data { get; set; }
        public float Quantidade { get; set; }
    }
}
