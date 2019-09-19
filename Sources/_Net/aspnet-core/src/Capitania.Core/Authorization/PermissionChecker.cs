using Abp.Authorization;
using Capitania.Authorization.Roles;
using Capitania.Authorization.Users;

namespace Capitania.Authorization
{
    public class PermissionChecker : PermissionChecker<Role, User>
    {
        public PermissionChecker(UserManager userManager)
            : base(userManager)
        {
        }
    }
}
