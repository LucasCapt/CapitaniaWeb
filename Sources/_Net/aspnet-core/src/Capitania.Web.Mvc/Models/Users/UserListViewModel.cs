using System.Collections.Generic;
using Capitania.Roles.Dto;
using Capitania.Users.Dto;

namespace Capitania.Web.Models.Users
{
    public class UserListViewModel
    {
        public IReadOnlyList<UserDto> Users { get; set; }

        public IReadOnlyList<RoleDto> Roles { get; set; }
    }
}
