﻿using Capitania.DashFundo.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashFundo
{
    public interface IDashFundoAppService
    {
        DashFundoDto ObterDadosFundo(int IDFundo);
        List<FundoDto> ObterFundos();
    }
}
