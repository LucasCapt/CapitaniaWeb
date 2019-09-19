using System.Data.Common;
using Microsoft.EntityFrameworkCore;

namespace Capitania.EntityFrameworkCore
{
    public static class CapitaniaDbContextConfigurer
    {
        public static void Configure(DbContextOptionsBuilder<CapitaniaDbContext> builder, string connectionString)
        {
            builder.UseSqlServer(connectionString);
        }

        public static void Configure(DbContextOptionsBuilder<CapitaniaDbContext> builder, DbConnection connection)
        {
            builder.UseSqlServer(connection);
        }
    }
}
