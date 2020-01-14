using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Capitania.Controllers;
using Capitania.DashboardControle;
using Capitania.Web.Models.DashboardControle;
using Microsoft.AspNetCore.Mvc;

namespace Capitania.Web.Mvc.Controllers
{
    public class DashboardControleController : CapitaniaControllerBase
    {
        private readonly IDashboardControleAppService _dashboardAppService;

        public DashboardControleController(
            IDashboardControleAppService dashBoard)
        {
            _dashboardAppService = dashBoard;
        }

        public async Task<IActionResult> Index()
        {
            DashboardControleModel vModel = new DashboardControleModel();
            DateTime vDataBase = DateTime.Now;

            vModel.DataBase = vDataBase;

            //Carregar dados 
            ViewBag.DadosAsset = _dashboardAppService.ObterDadosFundoAsset(vDataBase);
            ViewBag.DadosADV = _dashboardAppService.ObterDadosFundoADV(vDataBase);
            ViewBag.DadosLiquidez = _dashboardAppService.ObterDadosLiquidez(vDataBase);
            ViewBag.DadosCaixa = _dashboardAppService.ObterDadosNecessidadeCaixa(vDataBase);
            ViewBag.DadosBreach = _dashboardAppService.ObterDadosViolacoesBreachs(vDataBase);
            ViewBag.DadosWarning = _dashboardAppService.ObterDadosViolacoesWarnings(vDataBase);

            ViewBag.DataBase = vDataBase;

            return View(vModel);
        }

        [HttpPost]
        public async Task<IActionResult> Index(DashboardControleModel vModel)
        {
            DateTime vDataBase = vModel.DataBase;
            //Carregar dados 
            ViewBag.DadosAsset = _dashboardAppService.ObterDadosFundoAsset(vDataBase);
            ViewBag.DadosADV = _dashboardAppService.ObterDadosFundoADV(vDataBase);
            ViewBag.DadosLiquidez = _dashboardAppService.ObterDadosLiquidez(vDataBase);
            ViewBag.DadosCaixa = _dashboardAppService.ObterDadosNecessidadeCaixa(vDataBase);
            ViewBag.DadosBreach = _dashboardAppService.ObterDadosViolacoesBreachs(vDataBase);
            ViewBag.DadosWarning = _dashboardAppService.ObterDadosViolacoesWarnings(vDataBase);

            ViewBag.DataBase = vDataBase;

            return View(vModel);
        }
    }
}