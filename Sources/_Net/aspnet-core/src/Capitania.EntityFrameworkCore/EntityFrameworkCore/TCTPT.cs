namespace Capitania.EntityFrameworkCore
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("TCTPT")]
    public partial class TCTPT
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ID { get; set; }

        [StringLength(255)]
        public string Nome { get; set; }

        [StringLength(255)]
        public string RazaoSocial { get; set; }

        [StringLength(255)]
        public string Atividade { get; set; }

        [StringLength(255)]
        public string CNPJ { get; set; }

        [StringLength(255)]
        public string Administrador { get; set; }

        [StringLength(255)]
        public string CNPJADM { get; set; }

        [StringLength(255)]
        public string Endereco { get; set; }

        [StringLength(255)]
        public string CEP { get; set; }

        [StringLength(255)]
        public string Cidade { get; set; }

        [StringLength(255)]
        public string Estado { get; set; }

        [StringLength(255)]
        public string Telefone { get; set; }

        [StringLength(255)]
        public string email { get; set; }

        [StringLength(255)]
        public string Procuradores { get; set; }

        [StringLength(255)]
        public string CNPJPROC { get; set; }

        [StringLength(255)]
        public string PerfilRisco { get; set; }

        public DateTime? Atualizado { get; set; }

        public double? PL { get; set; }

        [Key]
        [Column(Order = 1)]
        public bool PoliticamenteExposto_PJ { get; set; }

        [Key]
        [Column(Order = 2)]
        public bool OFAC_PJ { get; set; }

        [Key]
        [Column(Order = 3)]
        public bool BlackList_PJ { get; set; }

        [Key]
        [Column(Order = 4)]
        public bool PoliticamenteExposto_Adm { get; set; }

        [Key]
        [Column(Order = 5)]
        public bool OFAC_Adm { get; set; }

        [Key]
        [Column(Order = 6)]
        public bool BlackList_Adm { get; set; }

        [Key]
        [Column(Order = 7)]
        public bool PoliticamenteExposto_Proc { get; set; }

        [Key]
        [Column(Order = 8)]
        public bool OFAC_Proc { get; set; }

        [Key]
        [Column(Order = 9)]
        public bool BlackList_Proc { get; set; }

        [StringLength(255)]
        public string Status { get; set; }

        [StringLength(255)]
        public string FonteScreening { get; set; }

        [StringLength(255)]
        public string TIPO { get; set; }
    }
}
