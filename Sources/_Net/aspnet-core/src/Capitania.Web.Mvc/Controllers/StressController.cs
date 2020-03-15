using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Capitania.Controllers;
using Capitania.Stress;
using Capitania.Web.Models;
using Microsoft.AspNetCore.Mvc;

namespace Capitania.Web.Controllers
{
    public class StressController : CapitaniaControllerBase
    {
        private readonly IStressAppService _ratingNamesDash;

        public StressController(IStressAppService dashBoard)
        {
            _ratingNamesDash = dashBoard;
        }

        public async Task<IActionResult> Index()
        {
            StressModel vModel = new StressModel();
            vModel.DadosStress = _ratingNamesDash.ObterStress();
            return View(vModel);
        }
    }
}