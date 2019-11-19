namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("TPapel")]
    public partial class TPapel
    {
        [StringLength(100)]
        public string Nome { get; set; }

        [StringLength(70)]
        public string ID { get; set; }

        [StringLength(40)]
        public string CODCETIP { get; set; }

        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Fundo { get; set; }

        [StringLength(10)]
        public string Class_Liq { get; set; }

        [StringLength(10)]
        public string Class_Rentab { get; set; }

        [Column(TypeName = "date")]
        public DateTime? Data_Emissao { get; set; }

        [Column(TypeName = "date")]
        public DateTime? Data_Vencto { get; set; }

        public double? Duration { get; set; }

        public double? Asset_Value { get; set; }

        public double? Asset_Vol { get; set; }

        [StringLength(20)]
        public string CashFlow_ID { get; set; }

        public double? Senior_Before { get; set; }

        [StringLength(255)]
        public string Index { get; set; }

        public double? Yield { get; set; }

        public double? Coupon { get; set; }

        [StringLength(255)]
        public string DayCount { get; set; }

        [StringLength(40)]
        public string ISIN { get; set; }

        [StringLength(255)]
        public string XMLANBIMA { get; set; }

        [Column(TypeName = "date")]
        public DateTime? DT_CREATED { get; set; }

        [Column(TypeName = "date")]
        public DateTime? DT_DELETED { get; set; }

        [Key]
        [Column(Order = 1)]
        public bool DELETED { get; set; }

        [StringLength(255)]
        public string Status { get; set; }

        [StringLength(255)]
        public string TIPO { get; set; }

        public int? Holdings { get; set; }

        [StringLength(255)]
        public string SENIOR { get; set; }

        [StringLength(255)]
        public string NameCr { get; set; }

        [StringLength(255)]
        public string CNPJ { get; set; }
    }
}
