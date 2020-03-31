using Microsoft.AspNetCore.Mvc;
using Abp.AspNetCore.Mvc.Authorization;
using Capitania.Controllers;
using Capitania.DashboardHome;
using System.Threading.Tasks;
using Capitania.Web.Models.Home;

namespace Capitania.Web.Controllers
{
    [AbpMvcAuthorize]
    public class HomeController : CapitaniaControllerBase
    {
        private readonly IDahboardHomeAppService _dashboardHome;

        public HomeController(
            IDahboardHomeAppService dashBoard)
        {
            _dashboardHome = dashBoard;
        }

        public async Task<IActionResult> Index()
        {
            HomeDataModel vModel = new HomeDataModel();
            //Carregar dados 
            vModel.HistoricoPLConsolidadado = _dashboardHome.ObterDadosHistoricoPLConsolidado();
            vModel.CaixaConsolidado = _dashboardHome.ObterDadosCaixaPLConsolidado();
            vModel.AtivoTotal = _dashboardHome.ObterDadosPLAtivoTotal();
            vModel.Numeros = _dashboardHome.ObterDadosNumeros();
            vModel.Concentracao = _dashboardHome.ObterDadosConcentracao();
            vModel.HistoricoFalhas = _dashboardHome.ObterDadosHistoricoBreaches();
            vModel.CashDozeMeses = _dashboardHome.ObterDadosCashDozeMeses();

            return View(vModel);
        }
	}
}
