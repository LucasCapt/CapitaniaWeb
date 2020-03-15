using Capitania.RatingNames.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.RatingNames
{
    public interface IRatingNamesAppService
    {
        List<RatingNamesDto> ObterRatingNames();
    }
}
