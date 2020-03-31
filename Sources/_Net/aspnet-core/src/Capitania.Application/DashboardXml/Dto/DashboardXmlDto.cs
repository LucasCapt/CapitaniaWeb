using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashboardXml.Dto
{
    public class DashboardXmlDto
    {
        public DateTime DataHora { get; set; }
        public string Arquivo { get; set; }
        public string Pasta { get; set; }
        public string Situacao { get; set; }
        public string Observacao { get; set; }
    }
}
