using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Capitania.Controllers;
using Capitania.FactorHist;
using Capitania.Web.Models.FactorHistorico;
using Microsoft.AspNetCore.Mvc;

namespace Capitania.Web.Controllers
{
    public class FactorHistoricoController : CapitaniaControllerBase
    {
        private readonly IFactorHistAppService _factorHistAppService;

        public FactorHistoricoController(
            IFactorHistAppService dashBoard)
        {
            _factorHistAppService = dashBoard;
        }

        public async Task<IActionResult> Index()
        {
            FactorHistoricoModel vModel = new FactorHistoricoModel();
            vModel.ListagemHistoricoDolar = _factorHistAppService.GetListaFactorHist(FactorHistAppService.FactorDolar);
            vModel.ListagemHistoricoIDA = _factorHistAppService.GetListaFactorHist(FactorHistAppService.FactorIDA);
            vModel.ListagemHistoricoIFIX = _factorHistAppService.GetListaFactorHist(FactorHistAppService.FactorIFIX);
            vModel.ListagemHistoricoIMAB5 = _factorHistAppService.GetListaFactorHist(FactorHistAppService.FactorIMAB5);
            vModel.ListagemHistoricoIPCA10Y = _factorHistAppService.GetListaFactorHist(FactorHistAppService.FactorIPCA10Y);
            vModel.ListagemHistoricoIPCA2Y = _factorHistAppService.GetListaFactorHist(FactorHistAppService.FactorIPCA2Y);
            vModel.ListagemHistoricoIPCA5Y = _factorHistAppService.GetListaFactorHist(FactorHistAppService.FactorIPCA5Y);
            vModel.ListagemHistoricoPRE2Y = _factorHistAppService.GetListaFactorHist(FactorHistAppService.FactorPRE2Y);
            vModel.ListagemHistoricoPRE5Y = _factorHistAppService.GetListaFactorHist(FactorHistAppService.FactorPRE5Y);

            return View(vModel);
        }
    }
}