namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("TCNPJNome")]
    public partial class TCNPJNome
    {
        [Key]
        [StringLength(14)]
        public string CNPJ { get; set; }

        [StringLength(15)]
        public string NOMECREDITO { get; set; }
    }
}
