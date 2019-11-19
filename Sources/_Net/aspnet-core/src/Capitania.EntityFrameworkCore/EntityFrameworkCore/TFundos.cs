namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class TFundos
    {
        public int? ID { get; set; }

        [StringLength(255)]
        public string Nome { get; set; }

        [StringLength(255)]
        public string LiqNome { get; set; }

        [StringLength(14)]
        public string CNPJ { get; set; }

        [StringLength(255)]
        public string Qualif { get; set; }

        [StringLength(255)]
        public string IDTitulo { get; set; }

        [StringLength(255)]
        public string Consolidation { get; set; }

        [StringLength(255)]
        public string TIPO { get; set; }

        public int? PrazoResgate { get; set; }

        public double? LIM_VaR { get; set; }

        public double? LIM_Stress { get; set; }

        public double? LIM_EL { get; set; }

        public double? LIM_UL { get; set; }

        public double? LIM_DUR { get; set; }

        public double? CaixaMandato { get; set; }

        [Key]
        [Column(Order = 0)]
        public bool OverrideLimits { get; set; }

        [StringLength(255)]
        public string CONCENTRACAO { get; set; }

        [StringLength(255)]
        public string TIPO409 { get; set; }

        [Key]
        [Column(Order = 1)]
        public bool CredLimRegulam { get; set; }

        [Column(TypeName = "date")]
        public DateTime? DT_CREATED { get; set; }

        [Key]
        [Column(Order = 2)]
        public bool DELETED { get; set; }

        [Column(TypeName = "date")]
        public DateTime? DT_DELETED { get; set; }

        [StringLength(255)]
        public string Area { get; set; }

        [Key]
        [Column(Order = 3)]
        public bool Favorit_Cash { get; set; }

        [Key]
        [Column(Order = 4)]
        public bool Favorit_Credit { get; set; }

        [Key]
        [Column(Order = 5)]
        public bool Favorit_mkt { get; set; }

        [StringLength(255)]
        public string LiqMethod { get; set; }

        public int? Tolerancia1 { get; set; }

        public int? Tolerancia2 { get; set; }

        [StringLength(255)]
        public string NOMEBLOTTER { get; set; }

        [Key]
        [Column(Order = 6)]
        public bool Rule_NoDayTrd { get; set; }

        [Key]
        [Column(Order = 7)]
        public bool Rule_NoCrssTrd { get; set; }
    }
}
