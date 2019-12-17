namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("TPricing")]
    public partial class TPricing
    {
        public DateTime? DATAOBS { get; set; }

        [StringLength(255)]
        public string ATIVO { get; set; }

        public double? PRECO { get; set; }

        public long ID { get; set; }
    }
}
