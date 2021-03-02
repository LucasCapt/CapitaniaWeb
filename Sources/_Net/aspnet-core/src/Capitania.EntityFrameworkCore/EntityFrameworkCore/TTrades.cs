namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class TTrades
    {
        public long ID { get; set; }

        [Column(TypeName = "date")]
        public DateTime? DATA { get; set; }

        public DateTime? HORA { get; set; }

        public double? HORA_MS { get; set; }

        [StringLength(255)]
        public string FUNDO { get; set; }

        [StringLength(255)]
        public string ATIVO { get; set; }

        [StringLength(255)]
        public string CV { get; set; }

        public double? QUANT { get; set; }

        public double? TAXA { get; set; }

        public double? PU { get; set; }

        public double? PRICEREF { get; set; }

        [StringLength(255)]
        public string PRICESRC { get; set; }

        [StringLength(255)]
        public string BROKER { get; set; }

        [StringLength(255)]
        public string PRODUTO { get; set; }

        [StringLength(255)]
        public string NOMEATIVO { get; set; }

        public double? VALFIN { get; set; }
    }
}
