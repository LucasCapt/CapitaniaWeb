using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashFundo.Dto
{
    public class FundoDto
    {
        public int IDFundo { get; set; }
        public string Nome { get; set; }
        public string CNPJ { get; set; }
        public string Tipo { get; set; }
        public string Qualificacao { get; set; }
        public string Tipo409 { get; set; }
        public int PrazoResgate { get; set; }

    }
}
