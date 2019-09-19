using System.Threading.Tasks;
using Abp.Application.Services;
using Capitania.Sessions.Dto;

namespace Capitania.Sessions
{
    public interface ISessionAppService : IApplicationService
    {
        Task<GetCurrentLoginInformationsOutput> GetCurrentLoginInformations();
    }
}
