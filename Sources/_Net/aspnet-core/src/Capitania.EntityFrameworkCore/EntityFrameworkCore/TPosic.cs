namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("TPosic")]
    public partial class TPosic
    {
        public int? FUNDO { get; set; }

        [StringLength(255)]
        public string PAPEL { get; set; }

        [StringLength(255)]
        public string ISIN { get; set; }

        public double? Valor { get; set; }

        [Column(TypeName = "date")]
        public DateTime? DATA { get; set; }

        public int? TIPO { get; set; }

        public double? QUANT { get; set; }

        public double? BLOQUEADO { get; set; }

        public long ID { get; set; }
    }
}
