using Capitania.Controllers;
using Capitania.TConfiguracao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Capitania.Web.Models.TConfiguracao;
using Abp.Application.Services.Dto;

namespace Capitania.Web.Controllers
{
    public class TConfiguracaoController : CapitaniaControllerBase
    {
        private readonly ITConfiguracaoAppService _messageAppService;

        public TConfiguracaoController(ITConfiguracaoAppService messageAppService)
        {
            _messageAppService = messageAppService;
        }

        public async Task<IActionResult> Index()
        {
            var model = new TConfiguracaoListViewModel();

            return View(model);
        }

        public async Task<ActionResult> TConfiguracaoDetalhesModal(string codigo)
        {
            var message = await _messageAppService.GetConfiguracaoDetails(new EntityDto<string>(codigo));

            var model = new TConfiguracaoDetalhesModalViewModel
            {
                Configuracao = message
            };

            return View("_TConfiguracaoDetalhesModal", model);
        }
    }
}
