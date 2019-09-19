using System.Threading.Tasks;
using Capitania.Configuration.Dto;

namespace Capitania.Configuration
{
    public interface IConfigurationAppService
    {
        Task ChangeUiTheme(ChangeUiThemeInput input);
    }
}
