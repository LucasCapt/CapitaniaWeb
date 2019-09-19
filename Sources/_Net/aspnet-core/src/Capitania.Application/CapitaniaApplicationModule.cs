using Abp.AutoMapper;
using Abp.Modules;
using Abp.Reflection.Extensions;
using Capitania.Authorization;

namespace Capitania
{
    [DependsOn(
        typeof(CapitaniaCoreModule), 
        typeof(AbpAutoMapperModule))]
    public class CapitaniaApplicationModule : AbpModule
    {
        public override void PreInitialize()
        {
            Configuration.Authorization.Providers.Add<CapitaniaAuthorizationProvider>();
        }

        public override void Initialize()
        {
            var thisAssembly = typeof(CapitaniaApplicationModule).GetAssembly();

            IocManager.RegisterAssemblyByConvention(thisAssembly);

            Configuration.Modules.AbpAutoMapper().Configurators.Add(
                // Scan the assembly for classes which inherit from AutoMapper.Profile
                cfg => cfg.AddProfiles(thisAssembly)
            );
        }
    }
}
