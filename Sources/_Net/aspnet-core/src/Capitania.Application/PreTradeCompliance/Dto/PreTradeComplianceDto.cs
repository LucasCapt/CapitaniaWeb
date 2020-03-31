using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.PreTradeCompliance.Dto
{
    public class PreTradeComplianceDto
    {
        public DateTime Data { get; set; }
        public string Fundo { get; set; }
        public string Status { get; set; }
        public string TradeKey { get; set; }
    }
}
