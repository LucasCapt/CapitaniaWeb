using Abp.Application.Services;
using Capitania.DashboardFundo.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashboardFundo
{
    public interface IDashboardFundoAppService : IApplicationService
    {
        List<DashboardGeralDto> ObterDadosDashTodos();

        List<DashboardGeralDto> ObterDadosDashAsset();

        List<DashboardGeralDto> ObterDadosDashADV();

        List<DashboardGeralDto> ObterDadosDashExterno();

    }
}
