using Capitania.PreTradeCompliance.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capitania.Web.Models.PreTradeCompliance
{
    public class PreTradeComplianceModel
    {
        public DateTime DataBase { get; set; }
        public List<PreTradeComplianceDto> PreTrades { get; set; }

    }
}
