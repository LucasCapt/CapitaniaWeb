using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capitania.RatingNames.Dto
{
    public class RatingNamesDto
    {
        //[DATA], SETOR, NOME, Rating
        public DateTime Data { get; set; }
        public string Setor { get; set; }
        public string Nome { get; set; }
        public string Rating { get; set; }
    }
}
