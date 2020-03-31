using Capitania.DashboardXml.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashboardXml
{
    public interface IDashboardXmlAppService
    {
        List<DashboardXmlDto> ObterDadosDashXml(DateTime vDataBase);
    }
}
