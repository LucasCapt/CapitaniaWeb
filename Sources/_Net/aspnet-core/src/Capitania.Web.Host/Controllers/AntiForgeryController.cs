using Microsoft.AspNetCore.Antiforgery;
using Capitania.Controllers;

namespace Capitania.Web.Host.Controllers
{
    public class AntiForgeryController : CapitaniaControllerBase
    {
        private readonly IAntiforgery _antiforgery;

        public AntiForgeryController(IAntiforgery antiforgery)
        {
            _antiforgery = antiforgery;
        }

        public void GetToken()
        {
            _antiforgery.SetCookieTokenAndHeader(HttpContext);
        }
    }
}
