using Abp.Application.Services.Dto;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.TConfiguracao.Dtos
{
    public class CreateOrEditTConfiguracaoDto : EntityDto<string>
    {
        [Required]
        public string Codigo { get; set; }

        [Required]
        public string Descricao { get; set; }

        [Required]
        public string Valor { get; set; }
    }
}
