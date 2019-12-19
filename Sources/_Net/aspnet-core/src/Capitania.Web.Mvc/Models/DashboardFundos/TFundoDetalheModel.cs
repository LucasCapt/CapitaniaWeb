using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capitania.Web.Models.DashboardFundos
{
    public class TFundoDetalheModel : TFundoModel
    {
        public string Qualif { get; set; }
        public string Consolidation { get; set; }
        public string TIPO { get; set; }
        public float LIM_VaR { get; set; }
        public float LIM_Stress { get; set; }
        public float LIM_EL { get; set; }
        public float LIM_UL { get; set; }
        public float LIM_DUR { get; set; }
        public float CaixaMandato { get; set; }
        public string CONCENTRACAO { get; set; }
    }
}
