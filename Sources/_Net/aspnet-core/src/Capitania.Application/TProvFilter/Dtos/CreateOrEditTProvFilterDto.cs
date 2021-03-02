using Abp.Application.Services.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.TProvFilter.Dtos
{
    public class CreateOrEditTProvFilterDto : EntityDto<int>
    {
        
        public int IDUNICA { get; set; }

        public int? FUNDO { get; set; }
        
        public string PROV_COD { get; set; }
        
        public string PROV_DATA { get; set; }
        
        public string PP_ISIN { get; set; }
        
        public string PP_COD { get; set; }
        
        public string DESCR { get; set; }
        
        public string PP_TIPO { get; set; }
        
        public DateTime? DT_CREATED { get; set; }
        
        public DateTime? DT_DELETED { get; set; }
        
        public bool DELETED { get; set; }
    }
}
