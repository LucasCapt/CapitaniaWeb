using System.ComponentModel.DataAnnotations;

namespace Capitania.Users.Dto
{
    public class ChangeUserLanguageDto
    {
        [Required]
        public string LanguageName { get; set; }
    }
}