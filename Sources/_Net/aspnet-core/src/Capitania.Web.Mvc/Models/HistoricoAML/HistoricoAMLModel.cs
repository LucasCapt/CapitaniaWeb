using Capitania.HistoricoAML.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capitania.Web.Models.HistoricoAML
{
    public class HistoricoAMLModel
    {
        public List<HistoricoAMLDto> HistoricoAML { get; set; }
        public List<HistoricoAMLCountPorDataDto> HistoricoAMLContador { get; set; }
    }
}
