namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class TFluxos
    {
        [StringLength(15)]
        public string IDFLUXO { get; set; }

        public DateTime? DATA { get; set; }

        public double? AMORT { get; set; }

        public double? JUROS { get; set; }

        [Column(TypeName = "date")]
        public DateTime? DT_CREATED { get; set; }

        [Column(TypeName = "date")]
        public DateTime? DT_DELETED { get; set; }

        [Key]
        public bool DELETED { get; set; }
    }
}
