using Capitania.Roles.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.TConfiguracao.Dtos
{
    public class GetTConfiguracaoForEditOutput
    {
        public CreateOrEditTConfiguracaoDto TConfiguracao { get; set; }

        public List<FlatPermissionDto> Permissions { get; set; }

        public List<string> GrantedPermissionNames { get; set; }
    }
}
