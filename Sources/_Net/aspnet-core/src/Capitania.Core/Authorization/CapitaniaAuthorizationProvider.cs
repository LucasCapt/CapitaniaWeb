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
            context.CreatePermission(PermissionNames.Pages_DashboardGerencial, L("DashboardManager"), multiTenancySides: MultiTenancySides.Host);
            context.CreatePermission(PermissionNames.Pages_DashboardFundo, L("DashFundo"), multiTenancySides: MultiTenancySides.Host);
            context.CreatePermission(PermissionNames.Pages_HistoricoAML, L("AMLHistoric"), multiTenancySides: MultiTenancySides.Host);
            context.CreatePermission(PermissionNames.Pages_FactorHist, L("FactorHistoric"), multiTenancySides: MultiTenancySides.Host);
            context.CreatePermission(PermissionNames.Pages_PreTradeCompliance, L("PreTradeCompliance"), multiTenancySides: MultiTenancySides.Host);
            context.CreatePermission(PermissionNames.Pages_Ratings, L("Ratings"), multiTenancySides: MultiTenancySides.Host);
            context.CreatePermission(PermissionNames.Pages_RatingNames, L("RatingNames"), multiTenancySides: MultiTenancySides.Host);
            context.CreatePermission(PermissionNames.Pages_Stress, L("Stress"), multiTenancySides: MultiTenancySides.Host);
            context.CreatePermission(PermissionNames.Pages_Papel, L("Paper"), multiTenancySides: MultiTenancySides.Host);

        }

        private static ILocalizableString L(string name)
        {
            return new LocalizableString(name, CapitaniaConsts.LocalizationSourceName);
        }
    }
}
