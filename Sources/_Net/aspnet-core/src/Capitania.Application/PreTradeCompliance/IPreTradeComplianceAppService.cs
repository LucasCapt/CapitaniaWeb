using Capitania.PreTradeCompliance.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.PreTradeCompliance
{
    public interface IPreTradeComplianceAppService
    {
        List<PreTradeComplianceDto> GetPreTradeCompliances(DateTime vDataBase);
    }
}
