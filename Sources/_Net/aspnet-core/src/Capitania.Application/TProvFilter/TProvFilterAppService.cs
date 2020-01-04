using Abp.Application.Services.Dto;
using Abp.Authorization;
using Abp.Collections.Extensions;
using Abp.Domain.Repositories;
using Capitania.Authorization;
using Capitania.MultiTenancy;
using Capitania.TProvFilter.Dtos;
using Capitania.TProvFIlter;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.TProvFilter
{
    [AbpAuthorize(PermissionNames.Pages_TProvFilter)]
    public class TProvFilterAppService : CapitaniaAppServiceBase, ITProvFilterAppService
    {
        private readonly IRepository<TProvFilter, long> _TConfiguracaoRepository;
        private readonly IRepository<Tenant> _tenantRepository;
        
        public TProvFilterAppService(IRepository<TProvFilter, long> tConfiguracaoRepository, IRepository<Tenant> tenantRepositorio)
        {
            _TConfiguracaoRepository = tConfiguracaoRepository;
            _tenantRepository = tenantRepositorio;
        }

        public async Task CreateOrEdit(CreateOrEditTProvFilterDto input)
        {
            if (input.IDUNICA !=0)
            {
                await Create(input);
            }
            else
            {
                await Update(input);
            }
        }

        [AbpAuthorize(PermissionNames.Pages_TProvFilter_Create)]
        private async Task Create(CreateOrEditTProvFilterDto input)
        {
            var mensagem = ObjectMapper.Map<TProvFilter>(input);
            await _TConfiguracaoRepository.InsertAsync(mensagem);
        }

        [AbpAuthorize(PermissionNames.Pages_TProvFilter_Update)]
        private async Task Update(CreateOrEditTProvFilterDto input)
        {
            var mensagem = await _TConfiguracaoRepository.FirstOrDefaultAsync((int)input.Id);
            ObjectMapper.Map(input, mensagem);
        }

        [AbpAuthorize(PermissionNames.Pages_TProvFilter_Delete)]
        public async Task Delete(EntityDto<int> input)
        {
            await _TConfiguracaoRepository.DeleteAsync(input.Id);
        }

        public async Task<List<TProvFilter>> GetAllProvFilter()
        {
            return await _TConfiguracaoRepository.GetAllListAsync();
        }

        //public async Task<PagedResultDto<GetTConfiguracaoForView>> GetAll(GetAllTConfiguracaoInput input)
        //{
        //    var filteredProcuracoes = _TConfiguracaoRepository.GetAll()
        //                .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false);


        //    var query = (from o in filteredProcuracoes
        //                 join o1 in _TConfiguracaoRepository.GetAll() on o.Codigo equals o1.Codigo into j1
        //                 from s1 in j1.DefaultIfEmpty()

        //                 select new GetTConfiguracaoForView()
        //                 {
        //                     Configuracao = o
        //                 })
        //              .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => e.Configuracao.Codigo.ToLower() == input.Filter.ToLower().Trim());

        //    var totalCount = query.Count();

        //    var vConfiguracoes = query.OrderBy(k => k.Configuracao.Codigo).ToList();

        //    return new PagedResultDto<GetTConfiguracaoForView>(
        //        totalCount,
        //        vConfiguracoes
        //    );
        //}

        //public async Task<PagedResultDto<GetTConfiguracaoForView>> GetAllConfiguracoes(GetAllTConfiguracaoInput input)
        //{
        //    try
        //    {
        //        var currentTenant = await GetCurrentTenantAsync();

        //        var assigned = _TConfiguracaoRepository.GetAll()
        //                .Where(r => !String.IsNullOrEmpty(r.Codigo)) //Pra quem ele procura
        //                .Select(e => e.Codigo);

        //        var associated = assigned.ToList();


        //        var filteredMensagens = _TConfiguracaoRepository.GetAll()
        //            .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false);

        //        var query = (from o in filteredMensagens
        //                     select new GetTConfiguracaoForView
        //                     {
        //                         Configuracao = o
        //                     });

        //        var totalCount = query.Count();

        //        var procuracoes = query.ToList();

        //        return new PagedResultDto<GetTConfiguracaoForView>(
        //            totalCount,
        //            procuracoes
        //        );
        //    }
        //    catch (Exception ex)
        //    {
        //        var a = ex.Message;
        //        throw;
        //    }
        //}

        //public async Task<GetTConfiguracaoForEditOutput> GetTConfiguracaoForEdit(EntityDto<string> input)
        //{
        //    var vConfiguracao = await _TConfiguracaoRepository.FirstOrDefaultAsync(input.Id);

        //    var output = new GetTConfiguracaoForEditOutput { TConfiguracao = ObjectMapper.Map<CreateOrEditTConfiguracaoDto>(vConfiguracao) };

        //    return output;
        //}

        //public async Task<TConfiguracaoDto> GetConfiguracaoDetails(EntityDto<string> input)
        //{
        //    var mensagem = await _TConfiguracaoRepository.SingleAsync(e => e.Codigo == input.Id); //Não usar nunca Get ou GetAsync ou FirstOrDefault, pois esses métodos vão fazer query no banco perguntando pela chave primária "Id" a qual não existe
        //    var currentTenant = await GetCurrentTenantAsync();

        //    var output = ObjectMapper.Map(mensagem, new TConfiguracaoDto());

        //    return output;
        //}
    }
}
