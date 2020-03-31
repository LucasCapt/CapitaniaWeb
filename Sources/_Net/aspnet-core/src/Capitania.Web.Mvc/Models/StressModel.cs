using Capitania.EntityFrameworkCore;
using Capitania.Stress.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capitania.Web.Models
{
    public class StressModel
    {
        public List<StressDto> DadosStress { get; set; } = new List<StressDto>();
    }
}
