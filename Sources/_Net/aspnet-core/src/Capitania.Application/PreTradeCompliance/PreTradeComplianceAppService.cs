using Abp.Authorization;
using Capitania.Authorization;
using Capitania.PreTradeCompliance.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.PreTradeCompliance
{
    [AbpAuthorize(PermissionNames.Pages_PreTradeCompliance)]
    public class PreTradeComplianceAppService : CapitaniaAppServiceBase, IPreTradeComplianceAppService
    {
        public List<PreTradeComplianceDto> GetPreTradeCompliances(DateTime vDataBase)
        {
            StringBuilder vSQL = new StringBuilder();

            vSQL.AppendLine("SELECT Data as Data, Fundo as Fundo, Status as Status, TRADEKEY as TradeKey");
            vSQL.AppendLine("  FROM TPTCDETAIL");
            vSQL.AppendLine(String.Format("  WHERE DATA = '{0}'", vDataBase.ToString("yyyy-MM-dd")));
            vSQL.AppendLine(" ORDER BY fundo");

            return GeneralHelper.GetData<PreTradeComplianceDto>(vSQL.ToString());
        }
    }
}
