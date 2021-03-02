namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class TUsers
    {
        [StringLength(255)]
        public string login { get; set; }

        public int? IMPORTA { get; set; }

        public int? REPORTA { get; set; }

        [StringLength(255)]
        public string ACESSO { get; set; }

        [Key]
        public bool BATCHUSER { get; set; }
    }
}
