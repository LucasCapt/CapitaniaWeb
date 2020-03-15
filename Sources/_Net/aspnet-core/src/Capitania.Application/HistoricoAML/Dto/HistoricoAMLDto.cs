using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.HistoricoAML.Dto
{
    public class HistoricoAMLDto
    {
        public DateTime DataAML { get; set; }
        public int Trade { get; set; }
        public string CTPT { get; set; }
        public string Compliant { get; set; }
        public string Coment { get; set; }
        public string Ativo { get; set; }
        public string Fundo { get; set; }
    }
}
