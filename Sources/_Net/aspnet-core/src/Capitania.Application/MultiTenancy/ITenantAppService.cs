using Abp.Application.Services;
using Abp.Application.Services.Dto;
using Capitania.MultiTenancy.Dto;

namespace Capitania.MultiTenancy
{
    public interface ITenantAppService : IAsyncCrudAppService<TenantDto, int, PagedTenantResultRequestDto, CreateTenantDto, TenantDto>
    {
    }
}

