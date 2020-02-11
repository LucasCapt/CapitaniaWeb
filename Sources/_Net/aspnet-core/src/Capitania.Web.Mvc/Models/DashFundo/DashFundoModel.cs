using Capitania.DashFundo.Dto;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capitania.Web.Models.DashFundo
{
    public class DashFundoModel
    {
        public DashFundoDto Dados { get; set; }
        public FundoDto Fundo { get; set; }
        public long IDFundo { get; set; }
        public SelectList ListaFundos { get; set; }
        public bool ExibirDados { get; set; }
    }
}
