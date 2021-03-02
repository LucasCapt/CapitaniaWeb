using Abp.Domain.Repositories;
using Abp.Domain.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.TConfiguracao
{
    public class TConfiguracaoManager : DomainService
    {
        IRepository<TConfiguracao, string> _TConfiguracaoRepository;

        public TConfiguracaoManager(IRepository<TConfiguracao, string> tConfiguracaoRepository)
        {
            _TConfiguracaoRepository = tConfiguracaoRepository;
        }
    }
}
