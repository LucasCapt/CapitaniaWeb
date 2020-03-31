using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capitania.Web.Models.DashboardFundos
{
    public class TFundoViewModel
    {
        public List<TFundoModel> Fundos { get; set; } = new List<TFundoModel>();
        public TFundoDetalheModel DetalhesFundos { get; set; } 
        public List<TQuotaModel> Quotas { get; set; } = new List<TQuotaModel>();
        public List<THistRiskModel> HistoricoRisco { get; set; } = new List<THistRiskModel>();
        public List<TPosicModel> PosicaoFundo { get; set; } = new List<TPosicModel>();
    }
}
