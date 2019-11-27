namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("TPTCDETAIL")]
    public partial class TPTCDETAIL
    {
        public DateTime? DATARUN { get; set; }

        [Column(TypeName = "date")]
        public DateTime? DATA { get; set; }

        [StringLength(255)]
        public string ACTIONBY { get; set; }

        [StringLength(255)]
        public string TRADEKEY { get; set; }

        [StringLength(255)]
        public string FUNDO { get; set; }

        [StringLength(255)]
        public string ADDR { get; set; }

        [StringLength(255)]
        public string STATUS { get; set; }

        [StringLength(255)]
        public string OBS { get; set; }

        [Key]
        public bool OK { get; set; }
    }
}
