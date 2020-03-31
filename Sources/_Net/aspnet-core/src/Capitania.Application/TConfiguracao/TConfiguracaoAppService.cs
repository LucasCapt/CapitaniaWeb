using Abp.Application.Services.Dto;
using Abp.Authorization;
using Abp.Collections.Extensions;
using Abp.Domain.Repositories;
using Capitania.Authorization;
using Capitania.MultiTenancy;
using Capitania.TConfiguracao.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.TConfiguracao
{
    [AbpAuthorize(PermissionNames.Pages_TConfiguracao)]
    public class TConfiguracaoAppService : CapitaniaAppServiceBase, ITConfiguracaoAppService
    {
        private readonly IRepository<TConfiguracao, string> _TConfiguracaoRepository;
        private readonly IRepository<Tenant> _tenantRepository;

        public TConfiguracaoAppService(IRepository<TConfiguracao, string> tConfiguracaoRepository, IRepository<Tenant> tenantRepositorio)
        {
            _TConfiguracaoRepository = tConfiguracaoRepository;
            _tenantRepository = tenantRepositorio;
        }

        public async Task CreateOrEdit(CreateOrEditTConfiguracaoDto input)
        {
            if (input.Id == null)
            {
                await Create(input);
            }
            else
            {
                await Update(input);
            }
        }

        [AbpAuthorize(PermissionNames.Pages_TConfiguracao_Create)]
        private async Task Create(CreateOrEditTConfiguracaoDto input)
        {
            input.Id = input.Codigo;
            TConfiguracao v = new TConfiguracao();
            v.Codigo = input.Codigo;
            v.Descricao = input.Descricao;
            v.Id = input.Codigo;
            v.Valor = input.Valor;
            await _TConfiguracaoRepository.InsertAsync(v);
        }

        [AbpAuthorize(PermissionNames.Pages_TConfiguracao_Update)]
        private async Task Update(CreateOrEditTConfiguracaoDto input)
        {
            var mensagem = await _TConfiguracaoRepository.FirstOrDefaultAsync(input.Id);
            mensagem.Descricao = input.Descricao;
            mensagem.Valor = input.Valor;
            await _TConfiguracaoRepository.UpdateAsync(mensagem);
        }

        [AbpAuthorize(PermissionNames.Pages_TConfiguracao_Delete)]
        public async Task Delete(EntityDto<string> input)
        {
            await _TConfiguracaoRepository.DeleteAsync(input.Id);
        }

        public async Task<PagedResultDto<TConfiguracaoDto>> GetAll(GetAllTConfiguracaoInput input)
        {
            var filteredProcuracoes = _TConfiguracaoRepository.GetAll()
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false);


            var query = (from o in filteredProcuracoes
                         join o1 in _TConfiguracaoRepository.GetAll() on o.Codigo equals o1.Codigo into j1
                         from s1 in j1.DefaultIfEmpty()

                         select new TConfiguracaoDto()
                         {
                             Codigo = o.Codigo,
                             Descricao = o.Descricao,
                             Valor = o.Valor,
                             Id = o.Id
                         })
                      .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => e.Codigo.ToLower() == input.Filter.ToLower().Trim());

            var totalCount = query.Count();

            var vConfiguracoes = query.OrderBy(k => k.Codigo).ToList();

            return new PagedResultDto<TConfiguracaoDto>(
                totalCount,
                vConfiguracoes
            );
        }

        public async Task<PagedResultDto<GetTConfiguracaoForView>> GetAllConfiguracoes(GetAllTConfiguracaoInput input)
        {
            try
            {
                var currentTenant = await GetCurrentTenantAsync();

                var assigned = _TConfiguracaoRepository.GetAll()
                        .Where(r => !String.IsNullOrEmpty(r.Codigo)) //Pra quem ele procura
                        .Select(e => e.Codigo);

                var associated = assigned.ToList();


                var filteredMensagens = _TConfiguracaoRepository.GetAll()
                    .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false);

                var query = (from o in filteredMensagens
                             select new GetTConfiguracaoForView
                             {
                                 Configuracao = o
                             });

                var totalCount = query.Count();

                var procuracoes = query.ToList();

                return new PagedResultDto<GetTConfiguracaoForView>(
                    totalCount,
                    procuracoes
                );
            }
            catch (Exception ex)
            {
                var a = ex.Message;
                throw;
            }
        }

        public async Task<GetTConfiguracaoForEditOutput> GetTConfiguracaoForEdit(EntityDto<string> input)
        {
            var vConfiguracao = await _TConfiguracaoRepository.FirstOrDefaultAsync(input.Id);

            var output = new GetTConfiguracaoForEditOutput { TConfiguracao = ObjectMapper.Map<CreateOrEditTConfiguracaoDto>(vConfiguracao) };

            return output;
        }

        public async Task<TConfiguracaoDto> GetConfiguracaoDetails(EntityDto<string> input)
        {
            var mensagem = await _TConfiguracaoRepository.SingleAsync(e => e.Codigo == input.Id); //Não usar nunca Get ou GetAsync ou FirstOrDefault, pois esses métodos vão fazer query no banco perguntando pela chave primária "Id" a qual não existe

            TConfiguracaoDto output = new TConfiguracaoDto();
            output.Codigo = mensagem.Codigo;
            output.Descricao = mensagem.Descricao;
            output.Valor = mensagem.Valor;
            output.Id = mensagem.Id;

            return output;
        }

    }
}
