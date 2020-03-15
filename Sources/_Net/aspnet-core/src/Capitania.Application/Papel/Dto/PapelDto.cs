using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.Papel.Dto
{
    public class PapelDto
    {
        public string IdentificadorPapel { get; set; }
        public string Nome { get; set; }
        public string CodigoCETIP { get; set; }
        public string ISIN { get; set; }
        public string CNPJ { get; set; }
        public string Schedule { get; set; }
        public string Tipo { get; set; }
        public DateTime Emissao { get; set; }
        public string ClasseLiquidez { get; set; }
        public string DayCount { get; set; }
        public DateTime Maturidade { get; set; }
        public string NomeCRD { get; set; }
        public double Coupon { get; set; }
        public string Indexador { get; set; }
        public string Tranche { get; set; }
        public string Status { get; set; }
        public int ImobHoldings { get; set; }
        public long IDPapel { get; set; }
    }
}
