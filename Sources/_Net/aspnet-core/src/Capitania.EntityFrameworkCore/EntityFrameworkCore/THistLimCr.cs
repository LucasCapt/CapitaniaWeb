namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("THistLimCr")]
    public partial class THistLimCr
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Código { get; set; }
    }
}
