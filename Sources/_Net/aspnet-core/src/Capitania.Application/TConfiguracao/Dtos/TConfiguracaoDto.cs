using Abp.Application.Services.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.TConfiguracao.Dtos
{
    public class TConfiguracaoDto : EntityDto<string>
    {
        public string Codigo { get; set; }

        public string Descricao { get; set; }

        public string Valor { get; set; }
    }
}
