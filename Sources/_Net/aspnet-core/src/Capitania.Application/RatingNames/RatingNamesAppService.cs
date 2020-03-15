using Abp.Authorization;
using Capitania.Authorization;
using Capitania.RatingNames.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.RatingNames
{
    [AbpAuthorize(PermissionNames.Pages_RatingNames)]
    public class RatingNamesAppService : CapitaniaAppServiceBase, IRatingNamesAppService
    {
        public List<RatingNamesDto> ObterRatingNames()
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT [DATA] AS Data, SETOR AS Setor, NOME AS Nome, Rating as Rating");
            vSQL.AppendLine("  FROM TRatingNames inner join TRatings on TRatingNames.ID = TRatings.id");
            vSQL.AppendLine(" WHERE [data] >= DATEADD(month, -1, GETDATE()) ");
            vSQL.AppendLine(" order by[data] desc");

            return GeneralHelper.GetData<RatingNamesDto>(vSQL.ToString());
        }
    }
}
