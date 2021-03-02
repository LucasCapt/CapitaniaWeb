using Capitania.TConfiguracao.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capitania.Web.Models.TConfiguracao
{
    public class TConfiguracaoListViewModel
    {
        public IReadOnlyList<TConfiguracaoDto> Configuracoes { get; set; }
    }
}
