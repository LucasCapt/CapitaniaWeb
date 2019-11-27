namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("TAKA")]
    public partial class TAKA
    {
        [StringLength(255)]
        public string FromID { get; set; }

        [StringLength(255)]
        public string ToID { get; set; }

        [Column(TypeName = "date")]
        public DateTime? DT_CREATED { get; set; }

        [Key]
        public bool DELETED { get; set; }

        [Column(TypeName = "date")]
        public DateTime? DT_DELETED { get; set; }
    }
}
