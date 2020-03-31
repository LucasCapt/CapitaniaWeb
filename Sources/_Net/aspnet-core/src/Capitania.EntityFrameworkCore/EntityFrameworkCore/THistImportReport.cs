namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("THistImportReport")]
    public partial class THistImportReport
    {
        [Column(TypeName = "date")]
        public DateTime? DATARUN { get; set; }

        [StringLength(255)]
        public string QUAL { get; set; }

        [StringLength(255)]
        public string QUEM { get; set; }

        [StringLength(255)]
        public string RESULT { get; set; }

        public long ID { get; set; }
    }
}
