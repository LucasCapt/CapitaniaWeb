namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class TRegras
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ID { get; set; }

        [StringLength(255)]
        public string NOME { get; set; }

        [StringLength(255)]
        public string MAXMIN { get; set; }

        public double? LIMITE { get; set; }

        [Key]
        [Column(Order = 1)]
        public bool POR { get; set; }

        public int? POR_Prop { get; set; }

        [Key]
        [Column(Order = 2)]
        public bool PARA { get; set; }

        public int? PARA_Prop { get; set; }

        [StringLength(255)]
        public string PARA_Valor { get; set; }

        public int? WORKLOW { get; set; }

        public double? WARN { get; set; }

        [StringLength(255)]
        public string PARA_COMP { get; set; }

        [Key]
        [Column(Order = 3)]
        public bool ABERTA { get; set; }

        [Key]
        [Column(Order = 4)]
        public bool MOVEMENTRULE { get; set; }

        [Key]
        [Column(Order = 5)]
        public bool ANDRULE { get; set; }

        public int? AND_Prop { get; set; }

        [StringLength(255)]
        public string AND_Valor { get; set; }

        [StringLength(255)]
        public string AND_COMP { get; set; }

        public DateTime? DT_CREATED { get; set; }

        public DateTime? DT_DELETED { get; set; }

        [Key]
        [Column(Order = 6)]
        public bool DELETED { get; set; }

        [Key]
        [Column(Order = 7)]
        public bool REFISSUE { get; set; }

        [StringLength(255)]
        public string ISSUE_PROP { get; set; }

        [StringLength(255)]
        public string ESCOPO { get; set; }

        [Key]
        [Column(Order = 8)]
        public bool ISSUE_QUANT { get; set; }

        [StringLength(255)]
        public string LIM_REF { get; set; }

        [Key]
        [Column(Order = 9)]
        public bool AND2RULE { get; set; }

        public int? AND2_PROP { get; set; }

        [StringLength(255)]
        public string AND2_VALOR { get; set; }

        [StringLength(255)]
        public string AND2_COMP { get; set; }

        [Key]
        [Column(Order = 10)]
        public bool AND3RULE { get; set; }

        public int? AND3_PROP { get; set; }

        [StringLength(255)]
        public string AND3_VALOR { get; set; }

        [StringLength(255)]
        public string AND3_COMP { get; set; }

        [Key]
        [Column(Order = 11)]
        public bool CONECTOR { get; set; }
    }
}
