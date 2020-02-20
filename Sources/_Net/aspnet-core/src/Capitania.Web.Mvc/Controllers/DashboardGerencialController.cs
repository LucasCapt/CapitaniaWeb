using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Capitania.Controllers;
using Capitania.DashboardGerencial;
using Capitania.Web.Models.DashboardGerencial;
using Microsoft.AspNetCore.Mvc;

namespace Capitania.Web.Mvc.Controllers
{
    public class DashboardGerencialController : CapitaniaControllerBase
    {
        private readonly IDashboardGerencialAppService _dashboardAppService;

        public DashboardGerencialController(
            IDashboardGerencialAppService dashBoard)
        {
            _dashboardAppService = dashBoard;
        }

        public async Task<IActionResult> Index()
        {
            DashboardGerencialModel vModel = new DashboardGerencialModel();
            DateTime vDataBase = DateTime.Now;

            vModel.DataBase = vDataBase;

            //Carregar dados 
            ViewBag.DadosAsset = _dashboardAppService.ObterFundosAsset(vDataBase);
            ViewBag.DadosCash = _dashboardAppService.ObterCashReport(vDataBase);
            ViewBag.DadosLiquidez = _dashboardAppService.ObterStressLiquidez(vDataBase);
            ViewBag.DadosBreach = _dashboardAppService.ObterDadosViolacoesBreachs(vDataBase);
            ViewBag.DadosWarning = _dashboardAppService.ObterDadosViolacoesWarnings(vDataBase);
            ViewBag.DadosConcentracao = _dashboardAppService.ObterConcentracao(vDataBase).OrderByDescending(w => w.Percentual).ToList();
            ViewBag.DadosContrapartes = _dashboardAppService.ObterContrapartes(vDataBase);

            ViewBag.DataBase = vDataBase;

            return View(vModel);
        }

        [HttpPost]
        public async Task<IActionResult> Index(DashboardGerencialModel vModel)
        {
            DateTime vDataBase = vModel.DataBase;
            //Carregar dados 
            ViewBag.DadosAsset = _dashboardAppService.ObterFundosAsset(vDataBase);
            ViewBag.DadosCash = _dashboardAppService.ObterCashReport(vDataBase);
            ViewBag.DadosLiquidez = _dashboardAppService.ObterStressLiquidez(vDataBase);
            ViewBag.DadosBreach = _dashboardAppService.ObterDadosViolacoesBreachs(vDataBase);
            ViewBag.DadosWarning = _dashboardAppService.ObterConcentracao(vDataBase);
            ViewBag.DadosConcentracao = _dashboardAppService.ObterConcentracao(vDataBase).OrderByDescending(w=>w.Percentual).ToList();
            ViewBag.DadosContrapartes = _dashboardAppService.ObterContrapartes(vDataBase);

            ViewBag.DataBase = vDataBase;

            return View(vModel);
        }
    }
}