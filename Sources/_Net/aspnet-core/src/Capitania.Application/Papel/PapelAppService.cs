using Abp.Authorization;
using Capitania.Authorization;
using Capitania.Papel.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.Papel
{
    [AbpAuthorize(PermissionNames.Pages_Papel)]
    public class PapelAppService : CapitaniaAppServiceBase, IPapelAppService
    {
        public List<PapelDto> ObterPapeis()
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT TPapel.ID as IdentificadorPapel, TPapel.Nome as Nome, CODCETIP as CodigoCETIP, ISIN as ISIN, ");
            vSQL.AppendLine("       CNPJ as CNPJ, Class_Rentab as Schedule, TIPO as Tipo, ");
            vSQL.AppendLine("       Data_Emissao as Emissao, Class_Liq as ClasseLiquidez, DayCount as DayCount, ");
            vSQL.AppendLine("       Data_Vencto as Maturidade, NameCr as NomeCRD, Coupon as Coupon, ");
            vSQL.AppendLine("       [Index] as Indexador, Senior as Tranche, [Status] as Status, Holdings as ImobHoldings, IDPapel as IDPapel");
            vSQL.AppendLine("  FROM TPapel");
            vSQL.AppendLine(" WHERE TPapel.DT_CREATED <= GETDATE()");
            vSQL.AppendLine("   AND NOT(TPapel.DELETED = 1 AND TPapel.DT_DELETED<=GETDATE())");
            vSQL.AppendLine(" ORDER BY TPapel.Nome");

            return GeneralHelper.GetData<PapelDto>(vSQL.ToString());

        }

        public List<PropriedadePapelDto> ObterPropriedades()
        {
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("SELECT P.ID as IDPropriedade, P.Nome as NomePropriedade, V.Valor as ValorPropriedade, V.Papel as IdentificadorPapel");
            vSQL.AppendLine("  FROM TPropriedades AS P LEFT OUTER JOIN TPapelProp AS V ON P.ID = V.Propriedade");

            return GeneralHelper.GetData<PropriedadePapelDto>(vSQL.ToString());
        }
    }
}
