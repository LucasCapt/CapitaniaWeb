﻿using Abp.Application.Navigation;
using Abp.Localization;
using Capitania.Authorization;

namespace Capitania.Web.Startup
{
    /// <summary>
    /// This class defines menus for the application.
    /// </summary>
    public class CapitaniaNavigationProvider : NavigationProvider
    {
        public override void SetNavigation(INavigationProviderContext context)
        {
            context.Manager.MainMenu
                .AddItem(
                    new MenuItemDefinition(
                        PageNames.Home,
                        L("HomePage"),
                        url: "",
                        icon: "home",
                        requiresAuthentication: true
                    )

                ).AddItem( // Menu items below is just for demonstration!
                    new MenuItemDefinition(
                        "Dashboards",
                        L("Dashboards"),
                        icon: "menu"
                    ).AddItem(new MenuItemDefinition(
                        PageNames.DashboardFundo,
                        L("DashboardFundos"),
                        url: "DashboardFundos",
                        icon: "local_offer",
                        requiredPermissionName: PermissionNames.Pages_DashboardFundos)
                    ).AddItem(
                    new MenuItemDefinition(
                        PageNames.DashboardXml,
                        L("XmlAnbimaFileLog"),
                        url: "DashboardXml",
                        icon: "local_offer",
                        requiredPermissionName: PermissionNames.Pages_DashboardXml)
                    ).AddItem(
                    new MenuItemDefinition(
                        PageNames.DashboardControle,
                        L("DashboardControl"),
                        url: "DashboardControle",
                        icon: "local_offer",
                        requiredPermissionName: PermissionNames.Pages_DashboardControle)
                    ).AddItem(
                    new MenuItemDefinition(
                        PageNames.DashboardGerencial,
                        L("DashboardManager"),
                        url: "DashboardGerencial",
                        icon: "local_offer",
                        requiredPermissionName: PermissionNames.Pages_DashboardGerencial)
                    ).AddItem(
                    new MenuItemDefinition(
                        PageNames.DashFundo,
                        L("DashFundo"),
                        url: "DashboardFundo",
                        icon: "local_offer",
                        requiredPermissionName: PermissionNames.Pages_DashboardFundo)
                    ).AddItem(
                    new MenuItemDefinition(
                        PageNames.HistoricoAML,
                        L("AMLHistoric"),
                        url: "HistoricoAML",
                        icon: "local_offer",
                        requiredPermissionName: PermissionNames.Pages_HistoricoAML)
                    ).AddItem(
                    new MenuItemDefinition(
                        PageNames.FactorHistorico,
                        L("FactorHistoric"),
                        url: "FactorHistorico",
                        icon: "local_offer",
                        requiredPermissionName: PermissionNames.Pages_FactorHist)
                    ).AddItem(
                    new MenuItemDefinition(
                        PageNames.PreTradeCompliance,
                        L("PreTradeCompliance"),
                        url: "PreTradeCompliance",
                        icon: "local_offer",
                        requiredPermissionName: PermissionNames.Pages_PreTradeCompliance)
                    ).AddItem(
                    new MenuItemDefinition(
                        PageNames.Ratings,
                        L("Ratings"),
                        url: "Ratings",
                        icon: "local_offer",
                        requiredPermissionName: PermissionNames.Pages_Ratings)
                    ).AddItem(
                    new MenuItemDefinition(
                        PageNames.RatingNames,
                        L("RatingNames"),
                        url: "RatingNames",
                        icon: "local_offer",
                        requiredPermissionName: PermissionNames.Pages_RatingNames)
                    ).AddItem(
                    new MenuItemDefinition(
                        PageNames.Stress,
                        L("Stress"),
                        url: "Stress",
                        icon: "local_offer",
                        requiredPermissionName: PermissionNames.Pages_Stress)
                    ).AddItem(
                    new MenuItemDefinition(
                        PageNames.Paper,
                        L("Paper"),
                        url: "Papel",
                        icon: "local_offer",
                        requiredPermissionName: PermissionNames.Pages_Papel)
                    ))
                .AddItem(new MenuItemDefinition(
                    "Settings",
                    L("SystemSettings"),
                    icon: "menu").AddItem(
                    new MenuItemDefinition(
                        PageNames.Users,
                        L("Users"),
                        url: "Users",
                        icon: "people",
                        requiredPermissionName: PermissionNames.Pages_Users
                    )
                ).AddItem(
                    new MenuItemDefinition(
                        PageNames.Roles,
                        L("Roles"),
                        url: "Roles",
                        icon: "local_offer",
                        requiredPermissionName: PermissionNames.Pages_Roles
                    )
                ).AddItem(
                    new MenuItemDefinition(
                        PageNames.TConfiguracao,
                        L("TConfigurations"),
                        url: "TConfiguracao",
                        icon: "local_offer",
                        requiredPermissionName: PermissionNames.Pages_TConfiguracao
                    )
                ));
        }

        private static ILocalizableString L(string name)
        {
            return new LocalizableString(name, CapitaniaConsts.LocalizationSourceName);
        }
    }
}
