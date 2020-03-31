namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("TLOG")]
    public partial class TLOG
    {
        public DateTime? DATAHORA { get; set; }

        [StringLength(255)]
        public string ACAO { get; set; }

        [StringLength(255)]
        public string USER { get; set; }

        [StringLength(255)]
        public string COMPUTER { get; set; }

        public long ID { get; set; }
    }
}
