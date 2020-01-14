using Abp.Authorization;
using Abp.Localization;
using Abp.MultiTenancy;

namespace Capitania.Authorization
{
    public class CapitaniaAuthorizationProvider : AuthorizationProvider
    {
        public override void SetPermissions(IPermissionDefinitionContext context)
        {
            context.CreatePermission(PermissionNames.Pages_Users, L("Users"));
            context.CreatePermission(PermissionNames.Pages_Roles, L("Roles"));
            context.CreatePermission(PermissionNames.Pages_Tenants, L("Tenants"), multiTenancySides: MultiTenancySides.Host);
            context.CreatePermission(PermissionNames.Pages_TConfiguracao, L("TConfigurations"), multiTenancySides: MultiTenancySides.Host);
            context.CreatePermission(PermissionNames.Pages_DashboardFundos, L("DashboardFundos"), multiTenancySides: MultiTenancySides.Host);
            context.CreatePermission(PermissionNames.Pages_DashboardXml, L("XmlAnbimaFileLog"), multiTenancySides: MultiTenancySides.Host);
            context.CreatePermission(PermissionNames.Pages_DashboardControle, L("DashboardControl"), multiTenancySides: MultiTenancySides.Host);
        }

        private static ILocalizableString L(string name)
        {
            return new LocalizableString(name, CapitaniaConsts.LocalizationSourceName);
        }
    }
}
