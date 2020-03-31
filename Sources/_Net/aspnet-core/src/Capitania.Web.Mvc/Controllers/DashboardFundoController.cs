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
    public class DashboardFundoController : CapitaniaControllerBase
    {
        private readonly IDashFundoAppService _dashboardAppService;

        public DashboardFundoController(
            IDashFundoAppService dashBoard)
        {
            _dashboardAppService = dashBoard;
        }

        public async Task<IActionResult> Index()
        {
            DashFundoModel vModel = new DashFundoModel();
            vModel.Dados = new DashFundo.Dto.DashFundoDto();
            vModel.ExibirDados = false;
            vModel.ListaFundos = GetFundos();
            return View(vModel);
        }

        public IActionResult Carregar(int IDFundo)
        {
            DashFundoModel vModel = new DashFundoModel();
            //Carregar dados 
            vModel.Dados = _dashboardAppService.ObterDadosFundo(IDFundo);
            vModel.Concentracao = _dashboardAppService.ObterDadosConcentracao(IDFundo);
            vModel.ExibirDados = true;
            vModel.ListaFundos = GetFundos();

            return View("Index", vModel);
        }

        [NonAction]
        public SelectList GetFundos()
        {
            var vFundos = _dashboardAppService.ObterFundos();
            DashFundo.Dto.FundoDto vFundo = new DashFundo.Dto.FundoDto();
            vFundos = vFundos.OrderBy(w => w.Nome).ToList();
            vFundo.IDFundo = 0;
            vFundo.Nome = "Selecione o Fundo";
            vFundos.Insert(0, vFundo);
            //var selectIdiomaListItem = new List<SelectListItem>();
            //foreach (var itm in vFundos)
            //{
            //    selectIdiomaListItem.Add(new SelectListItem()
            //    {
            //        Text = itm.Nome,
            //        Value = itm.IDFundo.ToString()
            //    });
            //}
            return new SelectList(vFundos, "IDFundo", "Nome");
        }
    }
}
