using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Capitania.Controllers;
using Capitania.DashboardControle;
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
            //Carregar dados 
            ViewBag.DadosAsset = _dashboardAppService.ObterDadosFundoAsset(DateTime.Now);
            ViewBag.DadosADV = _dashboardAppService.ObterDadosFundoADV(DateTime.Now);
            ViewBag.DadosLiquidez = _dashboardAppService.ObterDadosLiquidez(DateTime.Now);
            ViewBag.DadosCaixa = _dashboardAppService.ObterDadosNecessidadeCaixa(DateTime.Now);
            ViewBag.DadosBreach = _dashboardAppService.ObterDadosViolacoesBreachs(DateTime.Now);
            ViewBag.DadosWarning = _dashboardAppService.ObterDadosViolacoesWarnings(DateTime.Now);

            ViewBag.DataBase = DateTime.Now;

            return View();
        }
    }
}