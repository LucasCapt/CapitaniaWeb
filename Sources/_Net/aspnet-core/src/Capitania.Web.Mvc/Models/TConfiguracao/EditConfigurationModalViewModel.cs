using Abp.AutoMapper;
using Capitania.TConfiguracao.Dtos;
using Capitania.Web.Models.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capitania.Web.Models.TConfiguracao
{
    [AutoMapFrom(typeof(GetTConfiguracaoForEditOutput))]
    public class EditConfigurationModalViewModel : GetTConfiguracaoForEditOutput
    {
        public EditConfigurationModalViewModel(GetTConfiguracaoForEditOutput output)
        {
            output.MapTo(this);
        }
    }
}
