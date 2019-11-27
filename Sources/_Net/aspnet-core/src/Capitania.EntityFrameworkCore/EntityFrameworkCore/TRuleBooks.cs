namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class TRuleBooks
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ID { get; set; }

        [StringLength(255)]
        public string Nome { get; set; }

        public DateTime? DT_CREATED { get; set; }

        public DateTime? DT_DELETED { get; set; }

        [Key]
        [Column(Order = 1)]
        public bool DELETED { get; set; }
    }
}
