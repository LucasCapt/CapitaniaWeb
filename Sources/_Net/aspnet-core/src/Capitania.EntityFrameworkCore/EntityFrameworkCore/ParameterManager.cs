using Abp.Domain.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.EntityFrameworkCore
{
    public static class ParameterManager
    {
        private static List<TConfiguracao.TConfiguracao> parametros = new List<TConfiguracao.TConfiguracao>();

        public static string GetParameterValue(string parameterCode)
        {
            TConfiguracao.TConfiguracao vParametro = parametros.FirstOrDefault(k => k.Codigo.Equals(parameterCode));
            if (vParametro == null)
            {
                CapitaniaDbModel vContexto = new CapitaniaDbModel();
                vParametro = vContexto.Configuracoes.FirstOrDefault(w => w.Codigo.Equals(parameterCode));
                if (vParametro == null)
                    throw new Exception(String.Format("Parametro com código {0} não cadastrado.", parameterCode));

                parametros.Add(vParametro);
            }

            return vParametro.Valor;
        }
    }
}
