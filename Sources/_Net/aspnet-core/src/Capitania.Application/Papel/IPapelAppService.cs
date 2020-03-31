using Capitania.Papel.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.Papel
{
    public interface IPapelAppService
    {
        List<PapelDto> ObterPapeis();
        List<PropriedadePapelDto> ObterPropriedades();
    }
}
