namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("TFACTORHIST")]
    public partial class TFACTORHIST
    {
        [StringLength(255)]
        public string FACTORID { get; set; }

        public DateTime? DATA { get; set; }

        public double? VALOR { get; set; }

        public long ID { get; set; }
    }
}
