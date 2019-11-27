using Abp.Application.Services;
using Abp.Application.Services.Dto;
using Capitania.TConfiguracao.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.TConfiguracao
{
    public interface ITConfiguracaoAppService : IApplicationService
    {
        Task<PagedResultDto<GetTConfiguracaoForView>> GetAll(GetAllTConfiguracaoInput input);

        Task<GetTConfiguracaoForEditOutput> GetTConfiguracaoForEdit(EntityDto<string> input);

        Task CreateOrEdit(CreateOrEditTConfiguracaoDto input);

        Task Delete(EntityDto<string> input);

        Task<PagedResultDto<GetTConfiguracaoForView>> GetAllConfiguracoes(GetAllTConfiguracaoInput input);

        Task<TConfiguracaoDto> GetConfiguracaoDetails(EntityDto<string> input);
    }
}
