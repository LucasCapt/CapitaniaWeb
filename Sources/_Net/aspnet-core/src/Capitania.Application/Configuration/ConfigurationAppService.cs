using System.Threading.Tasks;
using Abp.Authorization;
using Abp.Runtime.Session;
using Capitania.Configuration.Dto;

namespace Capitania.Configuration
{
    [AbpAuthorize]
    public class ConfigurationAppService : CapitaniaAppServiceBase, IConfigurationAppService
    {
        public async Task ChangeUiTheme(ChangeUiThemeInput input)
        {
            await SettingManager.ChangeSettingForUserAsync(AbpSession.ToUserIdentifier(), AppSettingNames.UiTheme, input.Theme);
        }
    }
}
