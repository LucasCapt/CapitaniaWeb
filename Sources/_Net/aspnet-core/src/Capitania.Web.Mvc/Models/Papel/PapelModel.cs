using Capitania.Papel.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capitania.Web.Models.Papel
{
    public class PapelModel
    {
        public List<PapelDto> Papeis { get; set; }
        public List<PropriedadePapelDto> Propriedades { get; set; }
    }
}
