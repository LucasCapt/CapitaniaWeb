using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Abp.Modules;
using Abp.Reflection.Extensions;
using Capitania.Configuration;

namespace Capitania.Web.Host.Startup
{
    [DependsOn(
       typeof(CapitaniaWebCoreModule))]
    public class CapitaniaWebHostModule: AbpModule
    {
        private readonly IHostingEnvironment _env;
        private readonly IConfigurationRoot _appConfiguration;

        public CapitaniaWebHostModule(IHostingEnvironment env)
        {
            _env = env;
            _appConfiguration = env.GetAppConfiguration();
        }

        public override void Initialize()
        {
            IocManager.RegisterAssemblyByConvention(typeof(CapitaniaWebHostModule).GetAssembly());
        }
    }
}
