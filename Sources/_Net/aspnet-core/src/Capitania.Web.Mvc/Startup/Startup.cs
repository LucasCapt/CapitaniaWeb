using System;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Castle.Facilities.Logging;
using Abp.AspNetCore;
using Abp.Castle.Logging.Log4Net;
using Capitania.Authentication.JwtBearer;
using Capitania.Configuration;
using Capitania.Identity;
using Capitania.Web.Resources;
using Abp.AspNetCore.SignalR.Hubs;


namespace Capitania.Web.Startup
{
    public class Startup
    {
        private readonly IConfigurationRoot _appConfiguration;

        public Startup(IHostingEnvironment env)
        {
            _appConfiguration = env.GetAppConfiguration();
        }

        public IServiceProvider ConfigureServices(IServiceCollection services)
        {
            // MVC
            services.AddMvc(
                options => options.Filters.Add(new AutoValidateAntiforgeryTokenAttribute())
            );

            IdentityRegistrar.Register(services);
            AuthConfigurer.Configure(services, _appConfiguration);

            services.AddScoped<IWebResourceManager, WebResourceManager>();

            services.AddSignalR();

            // Configure Abp and Dependency Injection
            return services.AddAbp<CapitaniaWebMvcModule>(
                // Configure Log4Net logging
                options => options.IocManager.IocContainer.AddFacility<LoggingFacility>(
                    f => f.UseAbpLog4Net().WithConfig("log4net.config")
                )
            );
        }

        public void Configure(IApplicationBuilder app, IHostingEnvironment env, ILoggerFactory loggerFactory)
        {
            //Register Syncfusion license
            Syncfusion.Licensing.SyncfusionLicenseProvider.RegisterLicense("MjA4NTU2QDMxMzcyZTM0MmUzMGVVMDM2NjJJOVhnSlFqaU9oMkIrMHY3MmZ2Ni9wNkVqdVhPdmJyUjFBVzg9;MjA4NTU3QDMxMzcyZTM0MmUzMFdoWi83Yjg5bXFiWWJ1c3dZcEZobGEya0lFQUlNdXFjais2b3dIdWw5bXc9;MjA4NTU4QDMxMzcyZTM0MmUzMFZQUlpMcjlBUGJSZ3lWSW91NUNmbjFiNFgrRlFBc0dkaGhqNE5Lam5YRFk9;MjA4NTU5QDMxMzcyZTM0MmUzME5adVBDc1dwclB4T3pVV2l3cjd1Um5IU0w5Q3J0WnorYWw1NnQ2WE5uTkk9;MjA4NTYwQDMxMzcyZTM0MmUzMFVTbVRiajR0QUh0NGVROGdZQlFlS3kya2R4RVoyUVJuMHByN3Y2U0djWHM9;MjA4NTYxQDMxMzcyZTM0MmUzMEV0V3ZDRnlaa25NaXhQeEZCbWRMWFowbyszQW9HTm1zc0hERHhxakRyZWc9;MjA4NTYyQDMxMzcyZTM0MmUzMEZtU2tUeFEzNzY3aEdyZHZtYXUvbE5ZWGNVclIrU2dwdlBMUVluS3FsSDQ9;MjA4NTYzQDMxMzcyZTM0MmUzMG92L0U4RXA4OGkxN21zN1dNYzZJeERPaG9RWTBWaWtSYTNLYVZlL0o1bXM9;MjA4NTY0QDMxMzcyZTM0MmUzMG1JTklnTGNNWGJTM2VPZ3MxS2JublVoTThLYVJtT05TRGhsTTVSQjA1MEE9;NT8mJyc2IWhiZH1nfWN9YGpoYmF8YGJ8ampqanNiYmlmamlmanMDHmg5PCA2IzImPzw/Oj4yEzQ+Mjo/fTA8Pg==;MjA4NTY1QDMxMzcyZTM0MmUzMG5Ec1pQQXFSSHNrcmJpYWtNYVVDaUEwUWJlZi9IRWFyUUpveFA0WGY5Qlk9");

            app.UseAbp(); // Initializes ABP framework.

            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Error");
            }

            app.UseStaticFiles();

            app.UseAuthentication();

            app.UseJwtTokenMiddleware();

            app.UseSignalR(routes =>
            {
                routes.MapHub<AbpCommonHub>("/signalr");
            });

            app.UseMvc(routes =>
            {
                routes.MapRoute(
                    name: "defaultWithArea",
                    template: "{area}/{controller=Home}/{action=Index}/{id?}");

                routes.MapRoute(
                    name: "default",
                    template: "{controller=Home}/{action=Index}/{id?}");
            });
        }
    }
}
