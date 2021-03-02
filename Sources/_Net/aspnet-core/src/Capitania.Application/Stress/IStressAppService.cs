using Capitania.Stress.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.Stress
{
    public interface IStressAppService
    {
        List<StressDto> ObterStress();
    }
}
