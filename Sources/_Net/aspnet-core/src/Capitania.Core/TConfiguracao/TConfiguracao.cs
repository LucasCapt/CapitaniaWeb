using Abp.Domain.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.TConfiguracao
{
    [Table("TConfiguracao")]
    public class TConfiguracao : Entity<string>
    {
        [Key]
        [Column("cfg_param")]
        public string Codigo { get; set; }

        [Column("cfg_descricao")]
        public string Descricao { get; set; }

        [Column("cfg_valor")]
        public string Valor { get; set; }

    }
}
