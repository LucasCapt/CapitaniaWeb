using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Capitania.Controllers;
using Capitania.PreTradeCompliance;
using Capitania.Web.Models.PreTradeCompliance;
using Microsoft.AspNetCore.Mvc;

namespace Capitania.Web.Controllers
{
    public class PreTradeComplianceController : CapitaniaControllerBase
    {
        private readonly IPreTradeComplianceAppService _preTradeComplianceService;

        public PreTradeComplianceController(IPreTradeComplianceAppService dashBoard)
        {
            _preTradeComplianceService = dashBoard;
        }
        public async Task<IActionResult> Index()
        {
            PreTradeComplianceModel vModel = new PreTradeComplianceModel();
            vModel.DataBase = DateTime.Now;
            vModel.PreTrades = _preTradeComplianceService.GetPreTradeCompliances(DateTime.Now);

            return View(vModel);
        }

        [HttpPost]
        public async Task<IActionResult> Index(PreTradeComplianceModel vModel)
        {
            DateTime vDataBase = vModel.DataBase;
            //Carregar dados 
            vModel.PreTrades = _preTradeComplianceService.GetPreTradeCompliances(vDataBase);

            return View(vModel);
        }
    }
}