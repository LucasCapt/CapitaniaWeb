namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("TRiskClass")]
    public partial class TRiskClass
    {
        [StringLength(255)]
        public string RiskClass { get; set; }

        [StringLength(255)]
        public string Politica { get; set; }

        [StringLength(255)]
        public string PublicoAlvo { get; set; }

        [StringLength(255)]
        public string Tipo { get; set; }

        [StringLength(255)]
        public string ReguaRisco { get; set; }

        public double? M_VaR { get; set; }

        public double? M_Stress { get; set; }

        public double? M_QVaR { get; set; }

        public double? Conc_1 { get; set; }

        public double? Conc_2 { get; set; }

        public double? Conc_3 { get; set; }

        public double? Conc_4 { get; set; }

        public double? Cred_el { get; set; }

        public float? Cred_ul { get; set; }

        public double? Cred_el1 { get; set; }

        public double? Cred_ul1 { get; set; }

        public double? Duration { get; set; }

        public int? PriorTeste { get; set; }

        [Column(TypeName = "date")]
        public DateTime? Vig_Ini { get; set; }

        [Column(TypeName = "date")]
        public DateTime? Vig_fim { get; set; }

        [Key]
        public bool Vig_exp { get; set; }
    }
}
