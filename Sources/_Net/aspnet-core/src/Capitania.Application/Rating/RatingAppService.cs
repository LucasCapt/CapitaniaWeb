using Abp.Authorization;
using Capitania.Authorization;
using Capitania.Rating.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.Rating
{
    [AbpAuthorize(PermissionNames.Pages_Ratings)]
    public class RatingAppService : CapitaniaAppServiceBase, IRatingAppService
    {
        public List<RatingDto> GetRatings()
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT Papel AS PAPEL, Valor AS Valor, [Data] AS Data");
            vSQL.AppendLine("  FROM TPapelProp");
            vSQL.AppendLine(" WHERE Propriedade = 8");
            vSQL.AppendLine(String.Format("   AND DATA >= '{0}'", DateTime.Now.AddMonths(-12).ToString("yyyy-MM-dd")));
            vSQL.AppendLine(" GROUP BY papel, valor, [data]");
            vSQL.AppendLine(" ORDER BY Papel");

            return GeneralHelper.GetData<RatingDto>(vSQL.ToString());
        }
    }
}
