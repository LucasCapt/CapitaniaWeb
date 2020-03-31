namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("TLOGERRO")]
    public partial class TLOGERRO
    {
        public DateTime? DATAHORA { get; set; }

        [StringLength(255)]
        public string MSGERRO { get; set; }

        [StringLength(255)]
        public string ITEM { get; set; }

        [StringLength(255)]
        public string USER { get; set; }

        public long ID { get; set; }
    }
}
