using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Capitania.Controllers;
using Capitania.DashboardXml;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace Capitania.Web.Mvc.Controllers
{
    public class DashboardXmlController : CapitaniaControllerBase
    {
        private readonly IDashboardXmlAppService _dashboardAppService;

        public DashboardXmlController(
            IDashboardXmlAppService dashBoard)
        {
            _dashboardAppService = dashBoard;
        }

        public async Task<IActionResult> Index()
        {
            //Carregar dados 
            ViewBag.DadosDash = _dashboardAppService.ObterDadosDashXml(DateTime.Now);

            ViewBag.DataBase = DateTime.Now;

            return View();
        }

        [NonAction]
        public async Task<SelectList> GetIdiomaList()
        {
            //var idiomas = await new IdiomaRepository().GetIdiomas();
            var selectIdiomaListItem = new List<SelectListItem>();
            //foreach (var itm in idiomas)
            //{
            //    selectIdiomaListItem.Add(new SelectListItem()
            //    {
            //        Text = itm.Idioma,
            //        Value = itm.IdiomaID.ToString()
            //    });
            //}
            return new SelectList(selectIdiomaListItem, "Value", "Text");
        }
    }
}