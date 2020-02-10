using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashFundo.Dto
{
    public class DashFundoDto
    {
        public FundoDto Fundo { get; set; } = new FundoDto();
        public List<QuotaDto> Quotas { get; set; } = new List<QuotaDto>();
        public List<PatrimonioLiquidoDto> Patrimonio { get; set; } = new List<PatrimonioLiquidoDto>();

        public List<PosicaoDto> Posicao { get; set; } = new List<PosicaoDto>();
    }
}
