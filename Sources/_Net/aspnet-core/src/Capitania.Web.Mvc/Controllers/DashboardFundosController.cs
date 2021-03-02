using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Capitania.Controllers;
using Capitania.DashboardFundo;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace Capitania.Web.Mvc.Controllers
{
    public class DashboardFundosController : CapitaniaControllerBase
    {
        private readonly IDashboardFundoAppService _dashboardAppService;

        public DashboardFundosController(
            IDashboardFundoAppService dashBoard)
        {
            _dashboardAppService = dashBoard;
        }

        public async Task<IActionResult> Index()
        {
            //Carregar dados 
            ViewBag.DadosDash = _dashboardAppService.ObterDadosDashTodos();
            ViewBag.DadosAsset = _dashboardAppService.ObterDadosDashAsset();
            ViewBag.DadosADV = _dashboardAppService.ObterDadosDashADV();
            ViewBag.DadosExt = _dashboardAppService.ObterDadosDashExterno();

            ViewBag.ListaFundos = await GetIdiomaList();

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