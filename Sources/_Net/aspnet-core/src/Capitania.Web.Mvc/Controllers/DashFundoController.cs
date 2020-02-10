using Capitania.Controllers;
using Capitania.DashFundo;
using Capitania.Web.Models.DashFundo;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capitania.Web.Mvc.Controllers
{
    public class DashFundoController : CapitaniaControllerBase
    {
        private readonly IDashFundoAppService _dashboardAppService;

        public DashFundoController(
            IDashFundoAppService dashBoard)
        {
            _dashboardAppService = dashBoard;
        }

        public async Task<IActionResult> Index()
        {
            DashFundoModel vModel = new DashFundoModel();
            ViewBag.ListaFundos = GetFundos();
            return View(vModel);
        }

        [HttpPost]
        public async Task<IActionResult> Index(int IDFundo)
        {
            DashFundoModel vModel = new DashFundoModel();
            //Carregar dados 
            vModel.Dados = _dashboardAppService.ObterDadosFundo(IDFundo);

            ViewBag.ListaFundos = GetFundos();

            return View(vModel);
        }

        public async Task<SelectList> GetFundos()
        {
            var vFundos = _dashboardAppService.ObterFundos();
            var selectIdiomaListItem = new List<SelectListItem>();
            foreach (var itm in vFundos)
            {
                selectIdiomaListItem.Add(new SelectListItem()
                {
                    Text = itm.Nome,
                    Value = itm.IDFundo.ToString()
                });
            }
            return new SelectList(selectIdiomaListItem, "Value", "Text");
        }
    }
}
