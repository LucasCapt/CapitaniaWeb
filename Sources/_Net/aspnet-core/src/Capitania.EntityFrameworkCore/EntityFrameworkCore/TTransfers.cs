namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class TTransfers
    {
        public DateTime? DATAOBS { get; set; }

        [StringLength(255)]
        public string FUNDO { get; set; }

        public DateTime? DATALIQ { get; set; }

        public double? VALOR { get; set; }

        public DateTime? DATACANCEL { get; set; }

        [Key]
        public bool CANCELADO { get; set; }
    }
}
