using Abp.Domain.Repositories;
using Abp.Domain.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.TProvFilter
{
    public class TProvFilterManager : DomainService
    {
        IRepository<TProvFilter, int> _TProvFilterRepository;

        public TProvFilterManager(IRepository<TProvFilter, int> tConfiguracaoRepository)
        {
            _TProvFilterRepository = tConfiguracaoRepository;
        }
    }
}
