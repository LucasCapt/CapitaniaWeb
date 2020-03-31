using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Capitania.Controllers;
using Capitania.RatingNames;
using Capitania.Web.Models.RatingNames;
using Microsoft.AspNetCore.Mvc;

namespace Capitania.Web.Controllers
{
    public class RatingNamesController : CapitaniaControllerBase
    {
        private readonly IRatingNamesAppService _ratingNamesDash;

        public RatingNamesController(IRatingNamesAppService dashBoard)
        {
            _ratingNamesDash = dashBoard;
        }

        public async Task<IActionResult> Index()
        {
            RatingNamesModel vModel = new RatingNamesModel();
            vModel.Ratings = _ratingNamesDash.ObterRatingNames();
            return View(vModel);
        }
    }
}