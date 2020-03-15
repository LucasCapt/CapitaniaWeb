using Capitania.HistoricoAML.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.HistoricoAML
{
    public interface IHistoricoAMLAppService
    {
        List<HistoricoAMLDto> GetHistoricoAMLDtos();
        List<HistoricoAMLCountPorDataDto> GetHistoricoAMLCountPorDataDtos();
    }
}
