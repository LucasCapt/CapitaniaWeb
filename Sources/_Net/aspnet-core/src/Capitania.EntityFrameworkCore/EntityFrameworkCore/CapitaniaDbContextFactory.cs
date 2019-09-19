using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;
using Capitania.Configuration;
using Capitania.Web;

namespace Capitania.EntityFrameworkCore
{
    /* This class is needed to run "dotnet ef ..." commands from command line on development. Not used anywhere else */
    public class CapitaniaDbContextFactory : IDesignTimeDbContextFactory<CapitaniaDbContext>
    {
        public CapitaniaDbContext CreateDbContext(string[] args)
        {
            var builder = new DbContextOptionsBuilder<CapitaniaDbContext>();
            var configuration = AppConfigurations.Get(WebContentDirectoryFinder.CalculateContentRootFolder());

            CapitaniaDbContextConfigurer.Configure(builder, configuration.GetConnectionString(CapitaniaConsts.ConnectionStringName));

            return new CapitaniaDbContext(builder.Options);
        }
    }
}
