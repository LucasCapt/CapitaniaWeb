using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashFundo.Dto
{
    public class FundoAssetDto
    {
        public string Fundo { get; set; }
        public double Size { get; set; }
        public double Caixa { get; set; }
        public double Var { get; set; }
        public double Stress { get; set; }
        public double CTMDR { get; set; }
        public double CSGMNT { get; set; }
        public double ELInt { get; set; }
        public double ULInt { get; set; }
        public DateTime Data { get; set; }
    }
}
