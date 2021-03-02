namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class TPropriedades
    {
        public int? ID { get; set; }

        [StringLength(255)]
        public string Nome { get; set; }

        [Key]
        public bool ValorLivre { get; set; }
    }
}
