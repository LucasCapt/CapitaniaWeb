using System.Collections.Generic;
using Capitania.Roles.Dto;

namespace Capitania.Web.Models.Common
{
    public interface IPermissionsEditViewModel
    {
        List<FlatPermissionDto> Permissions { get; set; }
    }
}