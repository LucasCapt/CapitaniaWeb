using Abp.AspNetCore.Mvc.Controllers;
using Abp.IdentityFramework;
using Microsoft.AspNetCore.Identity;

namespace Capitania.Controllers
{
    public abstract class CapitaniaControllerBase: AbpController
    {
        protected CapitaniaControllerBase()
        {
            LocalizationSourceName = CapitaniaConsts.LocalizationSourceName;
        }

        protected void CheckErrors(IdentityResult identityResult)
        {
            identityResult.CheckErrors(LocalizationManager);
        }
    }
}
