using Microsoft.EntityFrameworkCore;
using Abp.Zero.EntityFrameworkCore;
using Capitania.Authorization.Roles;
using Capitania.Authorization.Users;
using Capitania.MultiTenancy;

namespace Capitania.EntityFrameworkCore
{
    public class CapitaniaDbContext : AbpZeroDbContext<Tenant, Role, User, CapitaniaDbContext>
    {
        /* Define a DbSet for each entity of the application */
        
        public CapitaniaDbContext(DbContextOptions<CapitaniaDbContext> options)
            : base(options)
        {
        }
    }
}
