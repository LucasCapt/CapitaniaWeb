using Microsoft.AspNetCore.Mvc.Razor.Internal;
using Abp.AspNetCore.Mvc.Views;
using Abp.Runtime.Session;

namespace Capitania.Web.Views
{
    public abstract class CapitaniaRazorPage<TModel> : AbpRazorPage<TModel>
    {
        [RazorInject]
        public IAbpSession AbpSession { get; set; }

        protected CapitaniaRazorPage()
        {
            LocalizationSourceName = CapitaniaConsts.LocalizationSourceName;
        }
    }
}
