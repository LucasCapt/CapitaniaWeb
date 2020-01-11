namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("TLOGPERF")]
    public partial class TLOGPERF
    {
        public DateTime? DATAHORA { get; set; }

        [StringLength(255)]
        public string USER { get; set; }

        [StringLength(255)]
        public string OPER { get; set; }

        public int? ITENS { get; set; }

        public double? SECS { get; set; }

        public double? ITEMPERSEC { get; set; }

        public double? SECPERITEM { get; set; }

        [StringLength(255)]
        public string VERSAO { get; set; }

        public long ID { get; set; }
    }
}
