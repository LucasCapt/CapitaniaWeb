using Capitania.Rating.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.Rating
{
    public interface IRatingAppService
    {
        List<RatingDto> GetRatings();
    }
}
