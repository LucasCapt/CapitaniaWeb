namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class TPOSICLAYOUT2
    {
        public int? FUNDO { get; set; }

        [StringLength(255)]
        public string PAPEL_ISIN { get; set; }

        public double? QUANT { get; set; }

        public double? VALOR { get; set; }

        [Column(TypeName = "date")]
        public DateTime? DATA { get; set; }

        [StringLength(255)]
        public string PAPEL_COD { get; set; }

        [StringLength(255)]
        public string TIPO { get; set; }

        [Column(TypeName = "date")]
        public DateTime? DTVENC { get; set; }

        [Column(TypeName = "date")]
        public DateTime? DTISSUE { get; set; }

        [StringLength(255)]
        public string INDEX { get; set; }

        public double? CUPOM { get; set; }

        public double? PINDEX { get; set; }

        [StringLength(255)]
        public string CNPJISSUE { get; set; }

        [StringLength(255)]
        public string IMPORTFOLDER { get; set; }

        public bool COMPROMISSADA { get; set; }

        public long id { get; set; }
    }
}
