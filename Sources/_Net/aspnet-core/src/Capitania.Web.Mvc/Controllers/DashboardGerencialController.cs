using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Capitania.Controllers;
using Microsoft.AspNetCore.Mvc;

namespace Capitania.Web.Mvc.Controllers
{
    public class DashboardGerencialController : CapitaniaControllerBase
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}