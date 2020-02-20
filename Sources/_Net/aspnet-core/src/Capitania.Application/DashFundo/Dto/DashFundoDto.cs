using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.DashFundo.Dto
{
    public class DashFundoDto
    {
        public DashFundoDto()
        {
            this.Fundo = new FundoDto();
            this.Quotas = new List<QuotaDto>();
            this.Patrimonio = new List<PatrimonioLiquidoDto>();
            this.Posicao = new List<PosicaoDto>();
            this.FundoAsset = new List<FundoAssetDto>();
            this.CashReport = new List<CashReportDto>();
            this.ViolacoesFalhas = new List<ViolacoesDto>();
            this.ViolacoesAlertas = new List<ViolacoesDto>();
        }
        public FundoDto Fundo { get; set; } 
        public List<QuotaDto> Quotas { get; set; } 
        public List<PatrimonioLiquidoDto> Patrimonio { get; set; } 
        public List<PosicaoDto> Posicao { get; set; } 
        public List<FundoAssetDto> FundoAsset { get; set; }
        public List<CashReportDto> CashReport { get; set; }
        public List<ViolacoesDto> ViolacoesFalhas { get; set; }
        public List<ViolacoesDto> ViolacoesAlertas { get; set; }


    }
}
