﻿using Capitania.FactorHist.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.FactorHist
{
    public interface IFactorHistAppService
    {
        List<FactorHistDto> GetListaFactorHist(string vFactorID);
    }
}
