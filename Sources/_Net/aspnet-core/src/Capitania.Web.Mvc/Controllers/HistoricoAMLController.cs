using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Capitania.Controllers;
using Capitania.HistoricoAML;
using Capitania.Web.Models.HistoricoAML;
using Microsoft.AspNetCore.Mvc;

namespace Capitania.Web.Controllers
{
    public class HistoricoAMLController : CapitaniaControllerBase
    {
        private readonly IHistoricoAMLAppService _historicoAMLAppService;

        public HistoricoAMLController(
            IHistoricoAMLAppService dashBoard)
        {
            _historicoAMLAppService = dashBoard;
        }

        public async Task<IActionResult> Index()
        {
            HistoricoAMLModel vModel = new HistoricoAMLModel();
            vModel.HistoricoAML = _historicoAMLAppService.GetHistoricoAMLDtos();
            vModel.HistoricoAMLContador = _historicoAMLAppService.GetHistoricoAMLCountPorDataDtos();

            return View(vModel);
        }
    }
}