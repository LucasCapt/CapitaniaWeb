using Abp.Domain.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.TProvFilter
{
    [Table("TProvFilter")]
    public partial class TProvFilter : Entity<long>
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int IDUNICA { get; set; }

        public int? FUNDO { get; set; }

        [StringLength(255)]
        public string PROV_COD { get; set; }

        [StringLength(255)]
        public string PROV_DATA { get; set; }

        [StringLength(255)]
        public string PP_ISIN { get; set; }

        [StringLength(255)]
        public string PP_COD { get; set; }

        [StringLength(255)]
        public string DESCR { get; set; }

        [StringLength(255)]
        public string PP_TIPO { get; set; }

        [Column(TypeName = "date")]
        public DateTime? DT_CREATED { get; set; }

        [Column(TypeName = "date")]
        public DateTime? DT_DELETED { get; set; }

        [Key]
        [Column(Order = 1)]
        public bool DELETED { get; set; }

    }
}
