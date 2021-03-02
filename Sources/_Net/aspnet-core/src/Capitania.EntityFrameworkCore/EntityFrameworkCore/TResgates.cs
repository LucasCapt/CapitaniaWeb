namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class TResgates
    {
        [Column(TypeName = "date")]
        public DateTime? DATAOBS { get; set; }

        [StringLength(255)]
        public string FUNDO { get; set; }

        [Column(TypeName = "date")]
        public DateTime? DATALIQ { get; set; }

        public double? VALOR { get; set; }

        [Column(TypeName = "date")]
        public DateTime? DATACANCEL { get; set; }

        [Column(Order = 0)]
        public bool CANCELADO { get; set; }

        
        [Column(Order = 1)]
        public bool TOTAL { get; set; }

        [Key]
        public long ID { get; set; }
    }
}
