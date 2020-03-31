using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Capitania.Controllers;
using Capitania.Papel;
using Capitania.Web.Models.Papel;
using Microsoft.AspNetCore.Mvc;

namespace Capitania.Web.Controllers
{
    public class PapelController : CapitaniaControllerBase
    {
        private readonly IPapelAppService _papelService;

        public PapelController(IPapelAppService dashBoard)
        {
            _papelService = dashBoard;
        }
        public async Task<IActionResult> Index()
        {
            PapelModel vModel = new PapelModel();
            vModel.Papeis = _papelService.ObterPapeis();
            vModel.Propriedades = _papelService.ObterPropriedades();

            return View(vModel);
        }
    }
}