namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("TLogArquivoXml")]
    public partial class TLogArquivoXml
    {
        public long ID { get; set; }

        public DateTime DataHora { get; set; }

        [Required]
        [StringLength(200)]
        public string Arquivo { get; set; }

        [Required]
        [StringLength(20)]
        public string Pasta { get; set; }

        public short Situacao { get; set; }

        [Required]
        [StringLength(350)]
        public string Observacao { get; set; }
    }
}
