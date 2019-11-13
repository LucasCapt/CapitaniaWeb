using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;
using System.Data.SqlClient;
using System.Configuration;

namespace Capitania.Importer.Library
{
    public static class ImporterManager
    {
        public static void ImportarPosicao()
        {
            //Importar posição txt
            ImportarPosiçaoTexto();
            //Importar posição Xml Anbima
            ImportXmlAnbima("", DateTime.Now);
        }

        private static void ImportarPosiçaoTexto()
        {

        }

        private static void ImportXmlAnbima(string pathRaizXml, DateTime data)
        {
            //Carregar os arquivos;
            XmlSerializer serializer = new XmlSerializer(typeof(ArquivoPosicao_4_01_type));

            //Para cada pasta no arquivo raiz
            foreach (string vPasta in Directory.GetDirectories(pathRaizXml))
            {
                foreach (string vXmlFile in Directory.GetFiles(vPasta, String.Format("*{0}*.xml", data.ToString("_YYYYMMDD_"))))
                {
                    using (FileStream fileStream = new FileStream(vXmlFile, FileMode.Open))
                    {
                        ArquivoPosicao_4_01_type vXmlAnbima = (ArquivoPosicao_4_01_type)serializer.Deserialize(fileStream);

                        foreach (var vFundo in vXmlAnbima.fundo)
                        {
                            string vCNPJ = vFundo.header.cnpj.ToString();
                            string vNome = vFundo.header.nome;

                            StringBuilder vSQL = new StringBuilder();
                            vSQL.AppendLine("select *");
                            vSQL.AppendLine("  from TFUNDOS");
                            vSQL.AppendLine(String.Format(" where CNPJ = '{0}'", vFundo.header.cnpj.ToString()));
                            vSQL.AppendLine("   and (DELETED = 0 and DT_DELETED > '{0}')");
                            vSQL.AppendLine(" UNION");
                            vSQL.AppendLine("select *");
                            vSQL.AppendLine("  from TFUNDOS");
                            vSQL.AppendLine(String.Format(" where NOME = '{0}'", vFundo.header.nome.ToString()));
                            vSQL.AppendLine("   and (DELETED = 0 and DT_DELETED > '{0}')");

                            //Selecionar na base de dados
                            using (SqlConnection vConexao = new SqlConnection(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["databaseConnection"]].ConnectionString))
                            {

                            }
                        }
                    }
                }
            }

            //vXmlAnbima.fundo
        }
    }
}
