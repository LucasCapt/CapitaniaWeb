using Microsoft.AspNetCore.Mvc;
using Abp.AspNetCore.Mvc.Authorization;
using Capitania.Controllers;

namespace Capitania.Web.Controllers
{
    [AbpMvcAuthorize]
    public class HomeController : CapitaniaControllerBase
    {
        public ActionResult Index()
        {
            return View();
        }
	}
}
