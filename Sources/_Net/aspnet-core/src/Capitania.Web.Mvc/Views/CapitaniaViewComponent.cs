using Abp.AspNetCore.Mvc.ViewComponents;

namespace Capitania.Web.Views
{
    public abstract class CapitaniaViewComponent : AbpViewComponent
    {
        protected CapitaniaViewComponent()
        {
            LocalizationSourceName = CapitaniaConsts.LocalizationSourceName;
        }
    }
}
