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
            vSQL.AppendLine("SELECT [DATA] AS Data, SETOR AS Setor, NOME AS Nome, Coalesce(RatingTo, 'CCC') as Rating");
            vSQL.AppendLine("  FROM TRatingNames inner join TRatings on TRatingNames.ID = TRatings.id LEFT OUTER JOIN TRatingsFromTo on TRatings.RATING = TRatingsFromTo.RatingFrom");
            vSQL.AppendLine(" WHERE [data] = (SELECT MAX([Data])");
            vSQL.AppendLine("                   FROM TRatings as TR");
            vSQL.AppendLine("                  WHERE TR.ID = TRatings.id)");
            vSQL.AppendLine("UNION");
            vSQL.AppendLine("SELECT [DATA] AS Data, SETOR AS Setor, NOME AS Nome, Coalesce(RatingTo, 'CCC') as Rating");
            vSQL.AppendLine("  FROM TRatingNames inner join TRatings on TRatingNames.ID = TRatings.id LEFT OUTER JOIN TRatingsFromTo on TRatings.RATING = TRatingsFromTo.RatingFrom");
            vSQL.AppendLine(" WHERE [data] = (SELECT Dateadd(d, -7, MAX([Data]))");
            vSQL.AppendLine("                   FROM TRatings as TR");
            vSQL.AppendLine("                  WHERE TR.ID = TRatings.id)");
            vSQL.AppendLine("order by[data] desc");

            return GeneralHelper.GetData<RatingNamesDto>(vSQL.ToString());
        }
    }
}
