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
            vSQL.AppendLine("SELECT TPapelProp.Papel AS PAPEL, TPapelProp.Valor AS Valor, TPapelProp.[Data] AS Data, TPapel.Nome as Nome");
            vSQL.AppendLine("  FROM TPapelProp, TPapel");
            vSQL.AppendLine(" WHERE TPapelProp.Papel = tpapel.ID");
            vSQL.AppendLine("   AND Propriedade = 8");
            vSQL.AppendLine(String.Format("   AND DATA >= '{0}'", DateTime.Now.AddMonths(-12).ToString("yyyy-MM-dd")));
            vSQL.AppendLine(" GROUP BY papel, valor, [data], TPapel.Nome");
            vSQL.AppendLine(" ORDER BY TPapel.Nome");

            return GeneralHelper.GetData<RatingDto>(vSQL.ToString());
        }
    }
}
