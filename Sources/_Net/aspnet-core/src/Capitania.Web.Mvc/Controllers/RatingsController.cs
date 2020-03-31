using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Capitania.Controllers;
using Capitania.Rating;
using Capitania.Web.Models.Ratings;
using Microsoft.AspNetCore.Mvc;

namespace Capitania.Web.Controllers
{
    public class RatingsController : CapitaniaControllerBase
    {
        private readonly IRatingAppService _preTradeComplianceService;

        public RatingsController(IRatingAppService dashBoard)
        {
            _preTradeComplianceService = dashBoard;
        }
        public async Task<IActionResult> Index()
        {
            RatingsModel vModel = new RatingsModel();
            vModel.Ratings = _preTradeComplianceService.GetRatings();

            return View(vModel);
        }
    }
}