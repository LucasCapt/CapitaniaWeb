namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("TADTV")]
    public partial class TADTV
    {
        public DateTime? DATA { get; set; }

        [StringLength(255)]
        public string NOME { get; set; }

        public double? ADTV { get; set; }

        public double? ADTVCLASSE { get; set; }

        public double? ADTVCOND { get; set; }

        public double? ADTVCLASSECOND { get; set; }

        public long ID { get; set; }
    }
}
