using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;
using System.Data.SqlClient;
using System.Configuration;
using Capitania.EntityFrameworkCore;
using System.Data;
using System.Runtime.InteropServices;
using Microsoft.Office.Interop.Excel;

namespace Capitania.Importer.Library
{
    public static class ImporterManager
    {
        private static List<FileSystemWatcher> vFileWatchers = new List<FileSystemWatcher>();
        

        public static void Initialize()
        {
            foreach (string vPasta in Directory.GetDirectories(ConfigurationManager.AppSettings["pathRaizXml"]))
            {
                FileSystemWatcher vWatcher = new FileSystemWatcher();
                vWatcher.Path = vPasta;
                vWatcher.NotifyFilter = NotifyFilters.Attributes | NotifyFilters.CreationTime | NotifyFilters.FileName | NotifyFilters.LastAccess |
                                        NotifyFilters.LastWrite | NotifyFilters.Size | NotifyFilters.Security;
                vWatcher.Created += new FileSystemEventHandler(OnCreate);
                vWatcher.EnableRaisingEvents = true;
                vFileWatchers.Add(vWatcher);
            }
        }

        private static void OnCreate(object source, FileSystemEventArgs e)
        {
            System.Threading.Thread.Sleep(20000);
            string vPath = Path.GetDirectoryName(e.FullPath);
            foreach (var xmlFile in Directory.GetFiles(vPath, "*.xml"))
            {
                string vFolder = Path.GetFileName(Path.GetDirectoryName(xmlFile));
                ImportXmlAnbima(xmlFile, vFolder);
            }

        }

        public static void ImportarPosicao()
        {
            //Importar posição txt
            ImportarPosiçaoTexto();
            //Importar posição Xml Anbima
            //ImportXmlAnbima(@"C:\TestFiles\BNY");

        }

        private static void ImportarPosiçaoTexto()
        {

        }

        private static void ImportXmlAnbima(string vXmlFileToImport, string vNomePastaProcessamento)
        {
            List<int> vListaFundos = new List<int>();
            try
            {
                //Carregar os arquivos;
                XmlSerializer serializer = new XmlSerializer(typeof(ArquivoPosicao_4_01_type));

                Capitania.EntityFrameworkCore.CapitaniaDbModel vContexto = new EntityFrameworkCore.CapitaniaDbModel();
                //Para cada pasta no arquivo raiz

                if (File.Exists(vXmlFileToImport))
                {
                    using (FileStream fileStream = new FileStream(vXmlFileToImport, FileMode.Open))
                    {
                        ArquivoPosicao_4_01_type vXmlAnbima = (ArquivoPosicao_4_01_type)serializer.Deserialize(fileStream);

                        if (vXmlAnbima.fundo != null)
                            foreach (var vFundo in vXmlAnbima.fundo)
                            {
                                DateTime vDataPosicao = new DateTime(int.Parse(vFundo.header.dtposicao.Substring(0, 4)), int.Parse(vFundo.header.dtposicao.Substring(4, 2)), int.Parse(vFundo.header.dtposicao.Substring(6, 2)));
                                List<DataRow> vFundos;
                                var vFilter = vContexto.TProvFilter.Where(k => (k.DT_CREATED.Value <= vDataPosicao && !(k.DELETED && k.DT_DELETED.Value <= vDataPosicao))).ToList();
                                StringBuilder vSQL = new StringBuilder();
                                vSQL.AppendLine("select *");
                                vSQL.AppendLine("  from TFundos");
                                vSQL.AppendLine(String.Format(" where CNPJ = '{0}'", vFundo.header.cnpj));
                                vSQL.AppendLine(String.Format("  AND (DELETED = 0 OR DT_DELETED > '{0}')", vDataPosicao.ToString("yyyy-MM-dd")));
                                vSQL.AppendLine(" UNION");
                                vSQL.AppendLine("select *");
                                vSQL.AppendLine("  from TFundos");
                                vSQL.AppendLine(String.Format(" where NOME = '{0}'", vFundo.header.nome));
                                vSQL.AppendLine(String.Format("  AND (DELETED = 0 OR DT_DELETED > '{0}')", vDataPosicao.ToString("yyyy-MM-dd")));

                                using (SqlConnection vConection = new SqlConnection(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["ConexaoDB"]].ConnectionString))
                                {
                                    vConection.Open();
                                    using (SqlCommand vComando = new SqlCommand(vSQL.ToString(), vConection))
                                    {
                                        using (SqlDataReader vReader = vComando.ExecuteReader())
                                        {
                                            var dt = new System.Data.DataTable();
                                            dt.Load(vReader);
                                            vFundos = dt.AsEnumerable().ToList();
                                        }
                                    }
                                    vConection.Close();
                                }

                                if (vFundos.Count > 0)
                                {
                                    int vFundoEmProcessamento = vFundos[0].Field<int>("ID");
                                    if (!vListaFundos.Contains(vFundoEmProcessamento))
                                    {
                                        vListaFundos.Add(vFundoEmProcessamento);
                                        vSQL = new StringBuilder();
                                        vSQL.AppendLine("delete from TPOSICLAYOUT2");
                                        vSQL.AppendLine(String.Format(" where DATA = '{0}'", vDataPosicao.ToString("yyyy-MM-dd")));
                                        vSQL.AppendLine(String.Format("   and FUNDO = {0}", vFundoEmProcessamento));
                                        using (SqlConnection vConection = new SqlConnection(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["ConexaoDB"]].ConnectionString))
                                        {
                                            vConection.Open();
                                            using (SqlCommand vComando = new SqlCommand(vSQL.ToString(), vConection))
                                            {
                                                vComando.ExecuteNonQuery();
                                            }
                                            vConection.Close();
                                        }
                                    }
                                    double vTotalDespesas = 0;
                                    double vValorAResgatar = vFundo.header.vlcotasresgatar;
                                    double vTotalProvisao = -vValorAResgatar;
                                    double vTotalGeral = 0;

                                    #region Ações

                                    if (vFundo.acoes != null)
                                    {
                                        foreach (var acao in vFundo.acoes)
                                        {
                                            TPOSICLAYOUT2 vPosicLayout2 = new TPOSICLAYOUT2();
                                            //FUNDO, TIPO, PAPEL_ISIN, PAPEL_COD, QUANT, VALOR, DATA, DTVENC, DTISSUE, [INDEX], CUPOM,PINDEX,CNPJISSUE, IMPORTFOLDER, COMPROMISSADA
                                            vPosicLayout2.FUNDO = vFundoEmProcessamento;
                                            vPosicLayout2.TIPO = "acoes";
                                            vPosicLayout2.PAPEL_ISIN = acao.isin;
                                            vPosicLayout2.PAPEL_COD = acao.codativo;
                                            vPosicLayout2.QUANT = (double)(acao.qtdisponivel + acao.qtgarantia);
                                            vPosicLayout2.VALOR = (double)(acao.valorfindisp + acao.valorfinemgar);
                                            if (acao.classeoperacao == classeCDTV_type.V)
                                                vPosicLayout2.VALOR = vPosicLayout2.VALOR * -1;
                                            vPosicLayout2.DATA = vDataPosicao;
                                            vPosicLayout2.DTVENC = new DateTime(2000, 01, 01);
                                            vPosicLayout2.DTISSUE = new DateTime(2000, 01, 01);
                                            vPosicLayout2.INDEX = "";
                                            vPosicLayout2.CUPOM = 0;
                                            vPosicLayout2.PINDEX = 0;
                                            vPosicLayout2.CNPJISSUE = "";
                                            vPosicLayout2.IMPORTFOLDER = vNomePastaProcessamento;
                                            vPosicLayout2.COMPROMISSADA = false;
                                            vTotalGeral += vPosicLayout2.VALOR.Value;
                                            vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                        }
                                    }
                                    #endregion

                                    #region Título Privado

                                    if (vFundo.titprivado != null)
                                    {
                                        foreach (var tituloPrivado in vFundo.titprivado)
                                        {
                                            TPOSICLAYOUT2 vPosicLayout2 = new TPOSICLAYOUT2();
                                            vPosicLayout2.FUNDO = vFundoEmProcessamento;
                                            vPosicLayout2.TIPO = "titprivado";
                                            vPosicLayout2.PAPEL_ISIN = tituloPrivado.isin;
                                            vPosicLayout2.PAPEL_COD = tituloPrivado.codativo;
                                            vPosicLayout2.QUANT = (double)(tituloPrivado.qtdisponivel + tituloPrivado.qtgarantia);
                                            vPosicLayout2.VALOR = (double)(tituloPrivado.valorfindisp + tituloPrivado.valorfinemgar);
                                            if (tituloPrivado.classeoperacao == classeCDTV_type.V)
                                                vPosicLayout2.VALOR = vPosicLayout2.VALOR * -1;
                                            vPosicLayout2.DATA = vDataPosicao;
                                            int vAno = int.Parse(tituloPrivado.dtemissao.Substring(0, 4));
                                            int vMes = int.Parse(tituloPrivado.dtemissao.Substring(4, 2));
                                            int vDia = int.Parse(tituloPrivado.dtemissao.Substring(6, 2));
                                            vPosicLayout2.DTISSUE = new DateTime(vAno, vMes, vDia);
                                            vAno = int.Parse(tituloPrivado.dtvencimento.Substring(0, 4));
                                            vMes = int.Parse(tituloPrivado.dtvencimento.Substring(4, 2));
                                            vDia = int.Parse(tituloPrivado.dtvencimento.Substring(6, 2));
                                            vPosicLayout2.DTVENC = new DateTime(vAno, vMes, vDia);
                                            vPosicLayout2.INDEX = tituloPrivado.indexador;
                                            vPosicLayout2.CUPOM = (double)tituloPrivado.coupom / 100;
                                            vPosicLayout2.PINDEX = (double)tituloPrivado.percindex;
                                            vPosicLayout2.CNPJISSUE = tituloPrivado.cnpjemissor.ToString();
                                            vPosicLayout2.IMPORTFOLDER = vNomePastaProcessamento;
                                            vPosicLayout2.COMPROMISSADA = (tituloPrivado.compromisso != null);
                                            vTotalGeral += vPosicLayout2.VALOR.Value;

                                            vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                        }
                                    }
                                    #endregion

                                    #region Título Público

                                    if (vFundo.titpublico != null)
                                    {
                                        foreach (var tituloPublico in vFundo.titpublico)
                                        {
                                            TPOSICLAYOUT2 vPosicLayout2 = new TPOSICLAYOUT2();
                                            vPosicLayout2.FUNDO = vFundoEmProcessamento;
                                            vPosicLayout2.TIPO = "titpublico";
                                            vPosicLayout2.PAPEL_ISIN = tituloPublico.isin;
                                            vPosicLayout2.PAPEL_COD = tituloPublico.codativo;
                                            vPosicLayout2.QUANT = (double)(tituloPublico.qtdisponivel + tituloPublico.qtgarantia);
                                            vPosicLayout2.VALOR = (double)(tituloPublico.valorfindisp + tituloPublico.valorfinemgar);
                                            if (tituloPublico.classeoperacao == classeCDTV_type.V)
                                                vPosicLayout2.VALOR = vPosicLayout2.VALOR * -1;
                                            vPosicLayout2.DATA = vDataPosicao;
                                            int vAno = int.Parse(tituloPublico.dtemissao.Substring(0, 4));
                                            int vMes = int.Parse(tituloPublico.dtemissao.Substring(4, 2));
                                            int vDia = int.Parse(tituloPublico.dtemissao.Substring(6, 2));
                                            vPosicLayout2.DTISSUE = new DateTime(vAno, vMes, vDia);
                                            vAno = int.Parse(tituloPublico.dtvencimento.Substring(0, 4));
                                            vMes = int.Parse(tituloPublico.dtvencimento.Substring(4, 2));
                                            vDia = int.Parse(tituloPublico.dtvencimento.Substring(6, 2));
                                            vPosicLayout2.DTVENC = new DateTime(vAno, vMes, vDia);
                                            vPosicLayout2.INDEX = tituloPublico.indexador;
                                            vPosicLayout2.CUPOM = (double)tituloPublico.coupom / 100;
                                            vPosicLayout2.PINDEX = (double)tituloPublico.percindex;
                                            vPosicLayout2.CNPJISSUE = "";
                                            vPosicLayout2.IMPORTFOLDER = vNomePastaProcessamento;
                                            vPosicLayout2.COMPROMISSADA = (tituloPublico.compromisso != null);
                                            vTotalGeral += vPosicLayout2.VALOR.Value;

                                            vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                        }
                                    }
                                    #endregion

                                    #region Debêntures

                                    if (vFundo.debenture != null)
                                    {
                                        foreach (var debenture in vFundo.debenture)
                                        {
                                            TPOSICLAYOUT2 vPosicLayout2 = new TPOSICLAYOUT2();
                                            vPosicLayout2.FUNDO = vFundoEmProcessamento;
                                            vPosicLayout2.TIPO = "debenture";
                                            vPosicLayout2.PAPEL_ISIN = debenture.isin;
                                            vPosicLayout2.PAPEL_COD = debenture.coddeb;
                                            vPosicLayout2.QUANT = (double)(debenture.qtdisponivel + debenture.qtgarantia);
                                            vPosicLayout2.VALOR = (double)(debenture.valorfindisp + debenture.valorfinemgar);
                                            if (debenture.classeoperacao == classeCDTV_type.V)
                                                vPosicLayout2.VALOR = vPosicLayout2.VALOR * -1;
                                            vPosicLayout2.DATA = vDataPosicao;
                                            int vAno = int.Parse(debenture.dtemissao.Substring(0, 4));
                                            int vMes = int.Parse(debenture.dtemissao.Substring(4, 2));
                                            int vDia = int.Parse(debenture.dtemissao.Substring(6, 2));
                                            vPosicLayout2.DTISSUE = new DateTime(vAno, vMes, vDia);
                                            vAno = int.Parse(debenture.dtvencimento.Substring(0, 4));
                                            vMes = int.Parse(debenture.dtvencimento.Substring(4, 2));
                                            vDia = int.Parse(debenture.dtvencimento.Substring(6, 2));
                                            vPosicLayout2.DTVENC = new DateTime(vAno, vMes, vDia);
                                            vPosicLayout2.INDEX = debenture.indexador;
                                            vPosicLayout2.CUPOM = (double)debenture.coupom / 100;
                                            vPosicLayout2.PINDEX = (double)debenture.percindex;
                                            vPosicLayout2.CNPJISSUE = debenture.cnpjemissor.ToString();
                                            vPosicLayout2.IMPORTFOLDER = vNomePastaProcessamento;
                                            vPosicLayout2.COMPROMISSADA = false;

                                            vTotalGeral += vPosicLayout2.VALOR.Value;

                                            vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                        }
                                    }
                                    #endregion

                                    #region Caixa

                                    if (vFundo.caixa != null)
                                    {
                                        foreach (var caixa in vFundo.caixa)
                                        {
                                            TPOSICLAYOUT2 vPosicLayout2 = new TPOSICLAYOUT2();
                                            vPosicLayout2.FUNDO = vFundoEmProcessamento;
                                            vPosicLayout2.TIPO = "caixa";
                                            vPosicLayout2.DATA = vDataPosicao;
                                            vPosicLayout2.PAPEL_ISIN = caixa.isininstituicao;
                                            vPosicLayout2.PAPEL_COD = "CONTA";
                                            vPosicLayout2.QUANT = (double)caixa.saldo;
                                            vPosicLayout2.VALOR = vPosicLayout2.QUANT;
                                            vPosicLayout2.DTVENC = new DateTime(2000, 01, 01);
                                            vPosicLayout2.DTISSUE = new DateTime(2000, 01, 01);
                                            vPosicLayout2.CUPOM = 0;
                                            vPosicLayout2.PINDEX = 0;
                                            vPosicLayout2.CNPJISSUE = string.Empty;
                                            vPosicLayout2.IMPORTFOLDER = vNomePastaProcessamento;
                                            vPosicLayout2.COMPROMISSADA = false;
                                            vTotalGeral += vPosicLayout2.VALOR.Value;

                                            vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                        }
                                    }
                                    #endregion

                                    #region Cotas

                                    if (vFundo.cotas != null)
                                    {
                                        foreach (var cota in vFundo.cotas)
                                        {
                                            TPOSICLAYOUT2 vPosicLayout2 = new TPOSICLAYOUT2();
                                            vPosicLayout2.FUNDO = vFundoEmProcessamento;
                                            vPosicLayout2.TIPO = "cotas";
                                            vPosicLayout2.DATA = vDataPosicao;
                                            vPosicLayout2.PAPEL_ISIN = cota.isin;
                                            vPosicLayout2.PAPEL_COD = cota.cnpjfundo.ToString();
                                            vPosicLayout2.QUANT = (double)(cota.qtdisponivel + cota.qtgarantia);
                                            vPosicLayout2.VALOR = (double)((double)cota.puposicao * vPosicLayout2.QUANT);
                                            vPosicLayout2.CNPJISSUE = cota.cnpjfundo.ToString();
                                            vPosicLayout2.IMPORTFOLDER = vNomePastaProcessamento;
                                            vPosicLayout2.DTVENC = new DateTime(2000, 01, 01);
                                            vPosicLayout2.DTISSUE = new DateTime(2000, 01, 01);
                                            vPosicLayout2.CUPOM = 0;
                                            vPosicLayout2.PINDEX = 0;
                                            vPosicLayout2.COMPROMISSADA = false;
                                            vTotalGeral += vPosicLayout2.VALOR.Value;

                                            vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                        }
                                    }
                                    #endregion

                                    #region Despesas

                                    if(vFundo.despesas!=null)
                                    vTotalDespesas -= vFundo.despesas.txadm;
                                    if (vFundo.outrasdespesas != null)
                                    {
                                        foreach (var outraDespesas in vFundo.outrasdespesas)
                                        {
                                            vTotalDespesas -= outraDespesas.valor;
                                        }
                                    }
                                    #endregion

                                    #region Provisões

                                    if (vFundo.provisao != null)
                                    {
                                        foreach (var provisao in vFundo.provisao)
                                        {
                                            //provisão, futuros, imoveis, 
                                            object vProvedorFiltro = null;
                                            foreach (var filtro in vFilter)
                                            {
                                                if (vFundoEmProcessamento == filtro.FUNDO && filtro.PROV_COD == provisao.codprov.ToString() && filtro.PROV_DATA == provisao.dt)
                                                {
                                                    vProvedorFiltro = filtro;
                                                }
                                            }

                                            if (vProvedorFiltro == null)
                                            {
                                                if (provisao.credeb == credeb_type.C)
                                                    vTotalProvisao += provisao.valor;
                                                else
                                                    vTotalProvisao -= provisao.valor;
                                            }
                                            else
                                            {
                                                TPOSICLAYOUT2 vPosicLayout2 = new TPOSICLAYOUT2();
                                                vPosicLayout2.FUNDO = vFundoEmProcessamento;
                                                vPosicLayout2.TIPO = (vProvedorFiltro as TProvFilter.TProvFilter).PP_TIPO;
                                                vPosicLayout2.PAPEL_ISIN = (vProvedorFiltro as TProvFilter.TProvFilter).PP_ISIN;
                                                vPosicLayout2.PAPEL_COD = (vProvedorFiltro as TProvFilter.TProvFilter).PP_COD;
                                                vPosicLayout2.QUANT = 1;
                                                vPosicLayout2.VALOR = (double)provisao.valor;
                                                if (provisao.credeb == credeb_type.D)
                                                    vPosicLayout2.VALOR = vPosicLayout2.VALOR * -1;
                                                vPosicLayout2.CNPJISSUE = "";
                                                vPosicLayout2.IMPORTFOLDER = vNomePastaProcessamento;
                                                vPosicLayout2.DTVENC = new DateTime(2000, 01, 01);
                                                vPosicLayout2.DTISSUE = new DateTime(2000, 01, 01);
                                                vPosicLayout2.CUPOM = 0;
                                                vPosicLayout2.PINDEX = 0;
                                                vPosicLayout2.CNPJISSUE = string.Empty;
                                                vPosicLayout2.COMPROMISSADA = false;

                                                vTotalGeral += vPosicLayout2.VALOR.Value;
                                                vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                            }
                                        }
                                    }

                                    #endregion

                                    #region Futuros

                                    if (vFundo.futuros != null)
                                    {
                                        foreach (var futuro in vFundo.futuros)
                                        {
                                            TPOSICLAYOUT2 vPosicLayout2 = new TPOSICLAYOUT2();
                                            vPosicLayout2.FUNDO = vFundoEmProcessamento;
                                            vPosicLayout2.TIPO = "futuros";
                                            vPosicLayout2.DATA = vDataPosicao;
                                            vPosicLayout2.PAPEL_ISIN = futuro.isin;
                                            vPosicLayout2.PAPEL_COD = String.Format("{0}{1}", futuro.ativo, futuro.serie);
                                            string vMSS = "";

                                            if (futuro.ativo.Equals("DAP") && futuro.vltotalpos < 50000 * futuro.quantidade)
                                                vPosicLayout2.QUANT = (double)futuro.quantidade * 120000;
                                            else
                                                vPosicLayout2.QUANT = (double)futuro.vltotalpos;

                                            if (futuro.classeoperacao == classeCV_type.V)
                                                vPosicLayout2.QUANT = vPosicLayout2.QUANT * -1;

                                            vPosicLayout2.VALOR = (double)futuro.vlajuste;

                                            int vAno = int.Parse(futuro.dtvencimento.Substring(0, 4));
                                            int vMes = int.Parse(futuro.dtvencimento.Substring(4, 2));
                                            int vDia = int.Parse(futuro.dtvencimento.Substring(6, 2));
                                            vPosicLayout2.DTISSUE = new DateTime(vAno, vMes, vDia);
                                            vTotalGeral += vPosicLayout2.VALOR.Value;
                                            vPosicLayout2.DTVENC = new DateTime(2000, 01, 01);
                                            vPosicLayout2.DTISSUE = new DateTime(2000, 01, 01);
                                            vPosicLayout2.CUPOM = 0;
                                            vPosicLayout2.PINDEX = 0;
                                            vPosicLayout2.CNPJISSUE = string.Empty;

                                            vPosicLayout2.IMPORTFOLDER = vNomePastaProcessamento;
                                            vPosicLayout2.COMPROMISSADA = false;
                                            vTotalGeral += vPosicLayout2.VALOR.Value;

                                            vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                        }
                                    }
                                    #endregion

                                    #region Imóveis

                                    if (vFundo.imoveis != null)
                                    {
                                        foreach (var imovel in vFundo.imoveis)
                                        {
                                            TPOSICLAYOUT2 vPosicLayout2 = new TPOSICLAYOUT2();
                                            vPosicLayout2.FUNDO = vFundoEmProcessamento;
                                            vPosicLayout2.TIPO = "imoveis";
                                            vPosicLayout2.DATA = vDataPosicao;
                                            vPosicLayout2.PAPEL_ISIN = "IMOVEL";
                                            vPosicLayout2.QUANT = 1;
                                            vPosicLayout2.VALOR = (double)imovel.valoravaliacao;
                                            if (vPosicLayout2.VALOR == 0)
                                                vPosicLayout2.VALOR = (double)imovel.valorcontabil;
                                            vPosicLayout2.PAPEL_COD = String.Format("{0} {1}", imovel.logradouro, imovel.numero);
                                            vPosicLayout2.DTVENC = new DateTime(2000, 01, 01);
                                            vPosicLayout2.DTISSUE = new DateTime(2000, 01, 01);
                                            vPosicLayout2.CUPOM = 0;
                                            vPosicLayout2.PINDEX = 0;
                                            vPosicLayout2.CNPJISSUE = string.Empty;
                                            vPosicLayout2.IMPORTFOLDER = vNomePastaProcessamento;
                                            vPosicLayout2.COMPROMISSADA = false;

                                            vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                        }
                                    }
                                    #endregion

                                    #region Provisão acumulada

                                    if (vTotalProvisao != 0)
                                    {
                                        TPOSICLAYOUT2 vPosicLayout2 = new TPOSICLAYOUT2();
                                        vPosicLayout2.FUNDO = vFundoEmProcessamento;
                                        vPosicLayout2.TIPO = "PROVISAO";
                                        vPosicLayout2.PAPEL_ISIN = "PROVISAO";
                                        vPosicLayout2.PAPEL_COD = "PROVISAO";
                                        vPosicLayout2.QUANT = vTotalProvisao;
                                        vPosicLayout2.VALOR = vTotalProvisao;
                                        vPosicLayout2.DATA = vDataPosicao;
                                        vPosicLayout2.DTVENC = new DateTime(1990, 01, 01);
                                        vPosicLayout2.DTISSUE = new DateTime(1990, 01, 01);
                                        vPosicLayout2.INDEX = "";
                                        vPosicLayout2.PINDEX = 0;
                                        vPosicLayout2.CNPJISSUE = "0";
                                        vPosicLayout2.CUPOM = 0;
                                        vPosicLayout2.PINDEX = 0;
                                        vPosicLayout2.CNPJISSUE = string.Empty;
                                        vPosicLayout2.IMPORTFOLDER = vNomePastaProcessamento;
                                        vPosicLayout2.COMPROMISSADA = false;

                                        vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                    }

                                    #endregion

                                    #region Despesa Acumulada

                                    if (vTotalDespesas != 0)
                                    {
                                        TPOSICLAYOUT2 vPosicLayout2 = new TPOSICLAYOUT2();
                                        vPosicLayout2.FUNDO = vFundoEmProcessamento;
                                        vPosicLayout2.TIPO = "DESPESA";
                                        vPosicLayout2.PAPEL_ISIN = "DESPESA";
                                        vPosicLayout2.PAPEL_COD = "DESPESA";
                                        vPosicLayout2.QUANT = vTotalDespesas;
                                        vPosicLayout2.VALOR = vTotalDespesas;
                                        vPosicLayout2.DATA = vDataPosicao;
                                        vPosicLayout2.DTVENC = new DateTime(1990, 01, 01);
                                        vPosicLayout2.DTISSUE = new DateTime(1990, 01, 01);
                                        vPosicLayout2.INDEX = "";
                                        vPosicLayout2.PINDEX = 0;
                                        vPosicLayout2.CUPOM = 0;
                                        vPosicLayout2.PINDEX = 0;
                                        vPosicLayout2.CNPJISSUE = string.Empty;
                                        vPosicLayout2.IMPORTFOLDER = vNomePastaProcessamento;
                                        vPosicLayout2.COMPROMISSADA = false;

                                        vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                    }

                                    #endregion

                                    #region Outros

                                    if (vFundo.corretagem != null)
                                    {
                                        TPOSICLAYOUT2 vPosicLayout2 = DadosOutros(vNomePastaProcessamento, vDataPosicao, vFundoEmProcessamento, "corretagem");

                                        vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                    }
                                    if (vFundo.fidc != null)
                                    {
                                        TPOSICLAYOUT2 vPosicLayout2 = DadosOutros(vNomePastaProcessamento, vDataPosicao, vFundoEmProcessamento, "fidc");

                                        vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                    }
                                    if (vFundo.forwardsmoedas != null)
                                    {
                                        TPOSICLAYOUT2 vPosicLayout2 = DadosOutros(vNomePastaProcessamento, vDataPosicao, vFundoEmProcessamento, "forwardsmoedas");

                                        vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                    }
                                    if (vFundo.opcoesacoes != null)
                                    {
                                        TPOSICLAYOUT2 vPosicLayout2 = DadosOutros(vNomePastaProcessamento, vDataPosicao, vFundoEmProcessamento, "opcoesacoes");

                                        vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                    }
                                    if (vFundo.opcoesderiv != null)
                                    {
                                        TPOSICLAYOUT2 vPosicLayout2 = DadosOutros(vNomePastaProcessamento, vDataPosicao, vFundoEmProcessamento, "opcoesderiv");

                                        vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                    }
                                    if (vFundo.opcoesflx != null)
                                    {
                                        TPOSICLAYOUT2 vPosicLayout2 = DadosOutros(vNomePastaProcessamento, vDataPosicao, vFundoEmProcessamento, "opcoesflx");

                                        vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                    }
                                    if (vFundo.opcoesmoedasotc != null)
                                    {
                                        TPOSICLAYOUT2 vPosicLayout2 = DadosOutros(vNomePastaProcessamento, vDataPosicao, vFundoEmProcessamento, "opcoesmoedasotc");

                                        vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                    }
                                    if (vFundo.participacoes != null)
                                    {
                                        TPOSICLAYOUT2 vPosicLayout2 = DadosOutros(vNomePastaProcessamento, vDataPosicao, vFundoEmProcessamento, "participacoes");

                                        vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                    }
                                    if (vFundo.partplanprev != null)
                                    {
                                        TPOSICLAYOUT2 vPosicLayout2 = DadosOutros(vNomePastaProcessamento, vDataPosicao, vFundoEmProcessamento, "partplanprev");

                                        vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                    }
                                    if (vFundo.swap != null)
                                    {
                                        TPOSICLAYOUT2 vPosicLayout2 = DadosOutros(vNomePastaProcessamento, vDataPosicao, vFundoEmProcessamento, "swap");

                                        vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                    }
                                    if (vFundo.termorf != null)
                                    {
                                        TPOSICLAYOUT2 vPosicLayout2 = DadosOutros(vNomePastaProcessamento, vDataPosicao, vFundoEmProcessamento, "termorf");

                                        vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                    }
                                    if (vFundo.termorv != null)
                                    {
                                        TPOSICLAYOUT2 vPosicLayout2 = DadosOutros(vNomePastaProcessamento, vDataPosicao, vFundoEmProcessamento, "termorv");

                                        vContexto.TPOSICLAYOUT2.Add(vPosicLayout2);
                                    }

                                    #endregion

                                    vTotalGeral = vTotalGeral + vTotalProvisao + vTotalDespesas;

                                    /*
                                     * Gerar notificação
                                    If Abs(TPL -plind) > 0.05 * plind Then
                                       If Notify Then MsgBox("Fundo " + nome + " inconsistente na importação XML:" + Chr(13) + Format(TPL, "###,###,##0") + " x " + Format(plind, "###,###,##0"))
                                        WriteLogError "Importação PL inconsistente", nome
                                    End If
                                    */
                                    vContexto.SaveChanges();
                                    ProcessImportedXml(vDataPosicao, vFundoEmProcessamento);
                                }


                            }
                        fileStream.Close();
                    }

                    string pathProcessados = Path.Combine(Path.GetDirectoryName(ConfigurationManager.AppSettings["pathRaizXml"]), "Processados");
                    if (!Directory.Exists(pathProcessados))
                        Directory.CreateDirectory(pathProcessados);
                    pathProcessados = Path.Combine(pathProcessados, vNomePastaProcessamento);
                    if (!Directory.Exists(pathProcessados))
                        Directory.CreateDirectory(pathProcessados);
                    string vArquivoDestino = Path.Combine(pathProcessados, Path.GetFileName(vXmlFileToImport));
                    if (File.Exists(vArquivoDestino))
                        File.Delete(vArquivoDestino);
                    File.Move(vXmlFileToImport, vArquivoDestino);
                }
            }
            catch (Exception ex)
            {
                string pathRejeitados = Path.Combine(Path.GetDirectoryName(ConfigurationManager.AppSettings["pathRaizXml"]), "Rejeitados");
                if (!Directory.Exists(pathRejeitados))
                    Directory.CreateDirectory(pathRejeitados);
                pathRejeitados = Path.Combine(pathRejeitados, vNomePastaProcessamento);
                if (!Directory.Exists(pathRejeitados))
                    Directory.CreateDirectory(pathRejeitados);
                string vArquivoDestino = Path.Combine(pathRejeitados, Path.GetFileName(vXmlFileToImport));
                if (File.Exists(vArquivoDestino))
                    File.Delete(vArquivoDestino);
                File.Move(vXmlFileToImport, vArquivoDestino);
            }
        }

        private static TPOSICLAYOUT2 DadosOutros(string vNomePastaProcessamento, DateTime vDataPosicao, int vIDFundo, string vDescricao)
        {
            TPOSICLAYOUT2 vPosicLayout2 = new TPOSICLAYOUT2();
            vPosicLayout2.FUNDO = vIDFundo;
            vPosicLayout2.TIPO = "!outro";
            vPosicLayout2.PAPEL_ISIN = vDescricao;
            vPosicLayout2.PAPEL_COD = "OUTRO";
            vPosicLayout2.QUANT = 0;
            vPosicLayout2.VALOR = 0;
            vPosicLayout2.DATA = vDataPosicao;
            vPosicLayout2.DTISSUE = new DateTime(2000, 01, 01);
            vPosicLayout2.DTVENC = new DateTime(2000, 01, 01);
            vPosicLayout2.INDEX = string.Empty;
            vPosicLayout2.CUPOM = 0;
            vPosicLayout2.PINDEX = 0;
            vPosicLayout2.CNPJISSUE = string.Empty;
            vPosicLayout2.IMPORTFOLDER = vNomePastaProcessamento;
            vPosicLayout2.COMPROMISSADA = false;
            return vPosicLayout2;
        }

        private static string ConvIndex(string valor1, string valor2 = "")
        {
            switch (valor1)
            {
                case "SEL":
                    return "SELIC";
                case "DI1":
                    if (valor2.Equals("+"))
                        return "CDI+";
                    else
                        return "%CDI";
                case "PRE":
                    return "PRE";
                case "IGD":
                    return "IGPM+";
                case "IAP":
                    return "IPCA+";

                default:
                    return "IGPM+";
            }
        }

        private static void ProcessImportedXml(DateTime data, int vFundo)
        {
            StringBuilder vSQL = new StringBuilder();

            vSQL.AppendLine("SELECT FUNDO, PAPEL_ISIN, SUM(QUANT) AS SQ, SUM(VALOR) AS SV, DATA, PAPEL_COD,");
            vSQL.AppendLine("       MAX(TIPO) AS TIPO1, MAX(DTVENC) AS DTVENC1, MIN(DTISSUE) AS DTISSUE1, MAX([INDEX]) AS INDEX1,");
            vSQL.AppendLine("       MIN(CUPOM) AS CUPOM1, MIN(PINDEX) AS PINDEX1, CNPJISSUE, IMPORTFOLDER, COMPROMISSADA");
            vSQL.AppendLine("  FROM TPOSICLAYOUT2");
            vSQL.AppendLine(String.Format(" WHERE DATA= '{0}'", data.ToString("yyyy-MM-dd")));
            vSQL.AppendLine(String.Format("   AND FUNDO = {0}", vFundo));
            vSQL.AppendLine(" GROUP BY FUNDO, PAPEL_ISIN, DATA, PAPEL_COD, CNPJISSUE, IMPORTFOLDER, COMPROMISSADA");
            vSQL.AppendLine(" ORDER BY FUNDO");

            Capitania.EntityFrameworkCore.CapitaniaDbModel vContexto = new EntityFrameworkCore.CapitaniaDbModel();

            using (SqlConnection vConection = new SqlConnection(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["ConexaoDB"]].ConnectionString))
            {
                vConection.Open();
                using (SqlCommand vComando = new SqlCommand(vSQL.ToString(), vConection))
                {
                    using (IDataReader vReader = vComando.ExecuteReader())
                    {
                        bool vPrimeiraIteracao = true;
                        while (vReader.Read())
                        {
                            bool vPapelEncontrado = false;
                            string PPISIN = string.Empty;
                            string ppID = string.Empty;

                            if (vPrimeiraIteracao)
                            {
                                vSQL = new StringBuilder();
                                vSQL.AppendLine("delete from TPosic");
                                vSQL.AppendLine(String.Format(" where DATA = '{0}'", data.ToString("yyyy-MM-dd")));
                                vSQL.AppendLine(String.Format("   and FUNDO = {0}", vFundo));
                                using (SqlCommand vComandoDelete = new SqlCommand(vSQL.ToString(), vConection))
                                {
                                    vComandoDelete.ExecuteNonQuery();
                                }
                                vPrimeiraIteracao = false;
                            }

                            vSQL = new StringBuilder();
                            if (vReader.GetBoolean(vReader.GetOrdinal("COMPROMISSADA")))
                            {
                                vSQL.AppendLine("select *");
                                vSQL.AppendLine("  from TPAPEL");
                                vSQL.AppendLine(" where ID = 'OVER'");

                                using (SqlCommand vComandoBuscaPapel = new SqlCommand(vSQL.ToString(), vConection))
                                {
                                    IDataReader vReaderPapel = vComandoBuscaPapel.ExecuteReader();
                                    vPapelEncontrado = vReaderPapel.Read();
                                    if (vPapelEncontrado)
                                    {
                                        if (!String.IsNullOrEmpty(vReaderPapel[vReaderPapel.GetOrdinal("ISIN")].ToString()))
                                            PPISIN = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ISIN"));
                                        ppID = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ID"));
                                    }
                                    else
                                    {
                                        vSQL = new StringBuilder();
                                        vSQL.AppendLine("select *");
                                        vSQL.AppendLine("  from TPAPEL");
                                        vSQL.AppendLine(" where ID = 'COMPROMISSADA'");
                                        vComandoBuscaPapel.CommandText = vSQL.ToString();
                                        vReaderPapel.Close();
                                        vReaderPapel = vComandoBuscaPapel.ExecuteReader();
                                        vPapelEncontrado = vReaderPapel.Read();
                                        if (vPapelEncontrado)
                                        {
                                            if (!String.IsNullOrEmpty(vReaderPapel[vReaderPapel.GetOrdinal("ISIN")].ToString()))
                                                PPISIN = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ISIN"));
                                            ppID = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ID"));
                                        }
                                    }
                                }
                            }

                            string vPapelISIN = vReader.GetString(vReader.GetOrdinal("PAPEL_ISIN"));

                            if (!vPapelEncontrado && !vPapelISIN.Contains("**") && !vPapelISIN.StartsWith("BR0000"))
                            {
                                vSQL = new StringBuilder();
                                vSQL.AppendLine("SELECT *");
                                vSQL.AppendLine("  FROM TPAPEL");
                                vSQL.AppendLine(String.Format(" WHERE DT_CREATED <= '{0}'", data.Date.ToString("yyyy-MM-dd")));
                                vSQL.AppendLine(String.Format("   AND (DELETED = 0 OR DT_DELETED >='{0}')", data.Date.ToString("yyyy-MM-dd")));
                                vSQL.AppendLine(String.Format("   AND ISIN = '{0}'", vPapelISIN));
                                using (SqlCommand vComandoBuscaPapel = new SqlCommand(vSQL.ToString(), vConection))
                                {
                                    IDataReader vReaderPapel = vComandoBuscaPapel.ExecuteReader();
                                    vPapelEncontrado = vReaderPapel.Read();
                                    if (vPapelEncontrado)
                                    {
                                        if (!String.IsNullOrEmpty(vReaderPapel[vReaderPapel.GetOrdinal("ISIN")].ToString()))
                                            PPISIN = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ISIN"));
                                        ppID = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ID"));
                                    }
                                }
                            }
                            if (!vPapelEncontrado && !vPapelISIN.Contains("**"))
                            {
                                vSQL = new StringBuilder();
                                vSQL.AppendLine("SELECT *");
                                vSQL.AppendLine("  FROM TPAPEL");
                                vSQL.AppendLine(String.Format(" WHERE DT_CREATED <= '{0}'", data.Date.ToString("yyyy-MM-dd")));
                                vSQL.AppendLine(String.Format("   AND (DELETED = 0 OR DT_DELETED >='{0}')", data.Date.ToString("yyyy-MM-dd")));
                                vSQL.AppendLine(String.Format("   AND ID = '{0}'", vPapelISIN));
                                using (SqlCommand vComandoBuscaPapel = new SqlCommand(vSQL.ToString(), vConection))
                                {
                                    IDataReader vReaderPapel = vComandoBuscaPapel.ExecuteReader();
                                    vPapelEncontrado = vReaderPapel.Read();
                                    if (vPapelEncontrado)
                                    {
                                        if (!String.IsNullOrEmpty(vReaderPapel[vReaderPapel.GetOrdinal("ISIN")].ToString()))
                                            PPISIN = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ISIN"));
                                        ppID = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ID"));
                                    }
                                }
                            }

                            if (!vPapelEncontrado)
                            {
                                vSQL = new StringBuilder();
                                vSQL.AppendLine("SELECT *");
                                vSQL.AppendLine("  FROM TAKA");
                                vSQL.AppendLine(String.Format("   WHERE TAKA.FROMID = '{0}'", vPapelISIN));
                                vSQL.AppendLine(String.Format("     AND TAKA.DT_CREATED <= '{0}'", data.ToString("yyyy-MM-dd")));
                                vSQL.AppendLine(String.Format("     AND (TAKA.DELETED =0 OR TAKA.DT_CREATED >= '{0}')", data.ToString("yyyy-MM-dd")));
                                using (SqlCommand vComandoBuscaPapel = new SqlCommand(vSQL.ToString(), vConection))
                                {
                                    IDataReader vReaderPapel = vComandoBuscaPapel.ExecuteReader();
                                    vPapelEncontrado = vReaderPapel.Read();
                                    if (vPapelEncontrado)
                                    {
                                        vSQL = new StringBuilder();
                                        vSQL.AppendLine("SELECT *");
                                        vSQL.AppendLine("  FROM TPAPEL");
                                        vSQL.AppendLine(String.Format(" WHERE ID = '{0}'", vReaderPapel.GetString(vReaderPapel.GetOrdinal("TOID"))));
                                        vComandoBuscaPapel.CommandText = vSQL.ToString();
                                        vReaderPapel.Close();
                                        vReaderPapel = vComandoBuscaPapel.ExecuteReader();
                                        vPapelEncontrado = vReaderPapel.Read();
                                        if (vPapelEncontrado)
                                        {
                                            if (!String.IsNullOrEmpty(vReaderPapel[vReaderPapel.GetOrdinal("ISIN")].ToString()))
                                                PPISIN = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ISIN"));
                                            ppID = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ID"));
                                        }
                                    }
                                }
                            }

                            string vCNPJIssuer = vReader.GetString(vReader.GetOrdinal("CNPJISSUE"));
                            if (!vPapelEncontrado && vReader.GetString(vReader.GetOrdinal("TIPO1")).Equals("cotas"))
                            {
                                vSQL = new StringBuilder();
                                vSQL.AppendLine("SELECT *");
                                vSQL.AppendLine("  FROM TPAPEL");
                                vSQL.AppendLine(String.Format(" WHERE DT_CREATED <= '{0}'", data.Date.ToString("yyyy-MM-dd")));
                                vSQL.AppendLine(String.Format("   AND (DELETED = 0 OR DT_DELETED >='{0}')", data.Date.ToString("yyyy-MM-dd")));
                                vSQL.AppendLine(String.Format("   AND CNPJ <> '' AND CNPJ = '{0}'", vCNPJIssuer));
                                using (SqlCommand vComandoBuscaPapel = new SqlCommand(vSQL.ToString(), vConection))
                                {
                                    IDataReader vReaderPapel = vComandoBuscaPapel.ExecuteReader();
                                    vPapelEncontrado = vReaderPapel.Read();
                                    if (vPapelEncontrado)
                                    {
                                        if (!String.IsNullOrEmpty(vReaderPapel[vReaderPapel.GetOrdinal("ISIN")].ToString()))
                                            PPISIN = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ISIN"));
                                        ppID = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ID"));
                                    }
                                }
                            }
                            if (!vPapelEncontrado && vReader.GetString(vReader.GetOrdinal("TIPO1")).Equals("cotas"))
                            {

                                vSQL = new StringBuilder();
                                vSQL.AppendLine("SELECT *");
                                vSQL.AppendLine("  FROM TFUNDOS");
                                vSQL.AppendLine(String.Format("   WHERE TFUNDOS.CNPJ = '{0}'", vCNPJIssuer));
                                vSQL.AppendLine(String.Format("     AND TFUNDOS.DT_CREATED <= '{0}'", data.ToString("yyyy-MM-dd")));
                                vSQL.AppendLine(String.Format("     AND (TFUNDOS.DELETED =0 OR TFUNDOS.DT_CREATED >= '{0}')", data.ToString("yyyy-MM-dd")));
                                using (SqlCommand vComandoBuscaPapel = new SqlCommand(vSQL.ToString(), vConection))
                                {
                                    IDataReader vReaderPapel = vComandoBuscaPapel.ExecuteReader();
                                    vPapelEncontrado = vReaderPapel.Read();
                                    if (vPapelEncontrado)
                                    {
                                        vSQL = new StringBuilder();
                                        vSQL.AppendLine("SELECT *");
                                        vSQL.AppendLine("  FROM TPAPEL");
                                        vSQL.AppendLine(string.Format(" WHERE ID = '{0}'", vReaderPapel.GetString(vReaderPapel.GetOrdinal("IDTITULO"))));
                                        vComandoBuscaPapel.CommandText = vSQL.ToString();
                                        vReaderPapel.Close();
                                        vReaderPapel = vComandoBuscaPapel.ExecuteReader();
                                        vPapelEncontrado = vReaderPapel.Read();
                                        if (vPapelEncontrado)
                                        {
                                            if (!String.IsNullOrEmpty(vReaderPapel[vReaderPapel.GetOrdinal("ISIN")].ToString()))
                                                PPISIN = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ISIN"));
                                            ppID = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ID"));
                                        }
                                    }
                                }
                            }

                            if (!vPapelEncontrado && vReader.GetString(vReader.GetOrdinal("TIPO1")).Equals("cotas"))
                            {
                                vSQL = new StringBuilder();
                                vSQL.AppendLine("SELECT *");
                                vSQL.AppendLine("  FROM TAKA");
                                vSQL.AppendLine(String.Format("   WHERE TAKA.FROMID = '{0}'", vCNPJIssuer));
                                vSQL.AppendLine(String.Format("     AND TAKA.DT_CREATED <= '{0}'", data.ToString("yyyy-MM-dd")));
                                vSQL.AppendLine(String.Format("     AND (TAKA.DELETED =0 OR TAKA.DT_CREATED >= '{0}')", data.ToString("yyyy-MM-dd")));
                                using (SqlCommand vComandoBuscaPapel = new SqlCommand(vSQL.ToString(), vConection))
                                {
                                    IDataReader vReaderPapel = vComandoBuscaPapel.ExecuteReader();
                                    vPapelEncontrado = vReaderPapel.Read();
                                    if (vPapelEncontrado)
                                    {
                                        vSQL = new StringBuilder();
                                        vSQL.AppendLine("SELECT *");
                                        vSQL.AppendLine("  FROM TPAPEL");
                                        vSQL.AppendLine(String.Format(" WHERE ID = '{0}'", vReaderPapel.GetString(vReaderPapel.GetOrdinal("TOID"))));
                                        vComandoBuscaPapel.CommandText = vSQL.ToString();
                                        vReaderPapel.Close();
                                        vReaderPapel = vComandoBuscaPapel.ExecuteReader();
                                        vPapelEncontrado = vReaderPapel.Read();
                                        if (vPapelEncontrado)
                                        {
                                            if (!String.IsNullOrEmpty(vReaderPapel[vReaderPapel.GetOrdinal("ISIN")].ToString()))
                                                PPISIN = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ISIN"));
                                            ppID = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ID"));
                                        }
                                    }
                                }
                            }



                            string vPapelCod = vReader.GetString(vReader.GetOrdinal("PAPEL_COD"));
                            if (!vPapelEncontrado)
                            {
                                vSQL = new StringBuilder();
                                vSQL.AppendLine("SELECT *");
                                vSQL.AppendLine("  FROM TPAPEL");
                                vSQL.AppendLine(String.Format(" WHERE DT_CREATED <= '{0}'", data.Date.ToString("yyyy-MM-dd")));
                                vSQL.AppendLine(String.Format("   AND (DELETED = 0 OR DT_DELETED >='{0}')", data.Date.ToString("yyyy-MM-dd")));
                                vSQL.AppendLine(String.Format("   AND ID = '{0}'", vPapelCod));
                                using (SqlCommand vComandoBuscaPapel = new SqlCommand(vSQL.ToString(), vConection))
                                {
                                    IDataReader vReaderPapel = vComandoBuscaPapel.ExecuteReader();
                                    vPapelEncontrado = vReaderPapel.Read();
                                    if (vPapelEncontrado)
                                    {
                                        if (!String.IsNullOrEmpty(vReaderPapel[vReaderPapel.GetOrdinal("ISIN")].ToString()))
                                            PPISIN = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ISIN"));
                                        ppID = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ID"));
                                    }
                                }
                            }

                            if (!vPapelEncontrado)
                            {
                                vSQL = new StringBuilder();
                                vSQL.AppendLine("SELECT *");
                                vSQL.AppendLine("  FROM TPAPEL");
                                vSQL.AppendLine(String.Format(" WHERE DT_CREATED <= '{0}'", data.Date.ToString("yyyy-MM-dd")));
                                vSQL.AppendLine(String.Format("   AND (DELETED = 0 OR DT_DELETED >='{0}')", data.Date.ToString("yyyy-MM-dd")));
                                vSQL.AppendLine(String.Format("   AND CODCETIP = '{0}'", vPapelCod));
                                using (SqlCommand vComandoBuscaPapel = new SqlCommand(vSQL.ToString(), vConection))
                                {
                                    IDataReader vReaderPapel = vComandoBuscaPapel.ExecuteReader();
                                    vPapelEncontrado = vReaderPapel.Read();
                                    if (vPapelEncontrado)
                                    {
                                        if (!String.IsNullOrEmpty(vReaderPapel[vReaderPapel.GetOrdinal("ISIN")].ToString()))
                                            PPISIN = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ISIN"));
                                        ppID = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ID"));
                                    }
                                }

                            }

                            if (!vPapelEncontrado)
                            {
                                vSQL = new StringBuilder();
                                vSQL.AppendLine("SELECT *");
                                vSQL.AppendLine("  FROM TAKA");
                                vSQL.AppendLine(String.Format("   WHERE TAKA.FROMID = '{0}'", vPapelCod));
                                vSQL.AppendLine(String.Format("     AND TAKA.DT_CREATED <= '{0}'", data.ToString("yyyy-MM-dd")));
                                vSQL.AppendLine(String.Format("     AND (TAKA.DELETED =0 OR TAKA.DT_CREATED >= '{0}')", data.ToString("yyyy-MM-dd")));
                                using (SqlCommand vComandoBuscaPapel = new SqlCommand(vSQL.ToString(), vConection))
                                {
                                    IDataReader vReaderPapel = vComandoBuscaPapel.ExecuteReader();
                                    vPapelEncontrado = vReaderPapel.Read();
                                    if (vPapelEncontrado)
                                    {
                                        vSQL = new StringBuilder();
                                        vSQL.AppendLine("SELECT *");
                                        vSQL.AppendLine("  FROM TPAPEL");
                                        vSQL.AppendLine(String.Format(" WHERE ID = '{0}'", vReaderPapel.GetString(vReaderPapel.GetOrdinal("TOID"))));
                                        vComandoBuscaPapel.CommandText = vSQL.ToString();
                                        vReaderPapel.Close();
                                        vReaderPapel = vComandoBuscaPapel.ExecuteReader();
                                        vPapelEncontrado = vReaderPapel.Read();
                                        if (vPapelEncontrado)
                                        {
                                            if (!String.IsNullOrEmpty(vReaderPapel[vReaderPapel.GetOrdinal("ISIN")].ToString()))
                                                PPISIN = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ISIN"));
                                            ppID = vReaderPapel.GetString(vReaderPapel.GetOrdinal("ID"));
                                        }
                                    }
                                }
                            }

                            if (!vPapelEncontrado)
                            {
                                TPapel pp = new TPapel();

                                if (vReader.GetBoolean(vReader.GetOrdinal("COMPROMISSADA")))
                                {
                                    pp.ID = "OVER";
                                    pp.ISIN = "OVER";
                                    pp.Nome = "COMPROMISSADA";
                                    pp.Status = "AUTO_TIPO2";
                                    pp.Data_Emissao = DateTime.Now;
                                    pp.Data_Vencto = DateTime.Now;
                                    pp.Index = "CDI+";
                                    pp.Coupon = 0;
                                    pp.DayCount = "Bus/252";
                                    pp.CODCETIP = "OVER";
                                    pp.TIPO = "TITPRIVADO";
                                    pp.Class_Liq = "CASH";
                                    pp.Class_Rentab = "OVER";
                                    pp.SENIOR = "SR_SECURED";
                                    pp.Holdings = 1;
                                }
                                else
                                {
                                    pp.ISIN = vReader.GetString(vReader.GetOrdinal("PAPEL_ISIN"));
                                    if (String.IsNullOrEmpty(pp.ISIN) || pp.ISIN.Contains("**"))
                                        pp.ID = vReader.GetString(vReader.GetOrdinal("PAPEL_COD"));
                                    else
                                        pp.ID = pp.ISIN;

                                    TPapel vPapelTemp = vContexto.TPapel.FirstOrDefault(w => w.ID == pp.ID);
                                    if (vPapelTemp != null)
                                    {
                                        long i = 1;
                                        while (true)
                                        {
                                            string vID = String.Format("{0}({1})", pp.ID, i);
                                            vPapelTemp = vContexto.TPapel.FirstOrDefault(w => w.ID.Equals(vID));
                                            if (vPapelTemp == null)
                                            {
                                                pp.ID = String.Format("{0}({1})", pp.ID, i);
                                                break;
                                            }
                                            i++;
                                        }
                                    }

                                    //'Continua a criação do papel
                                    //'Coloca os defaults
                                    pp.Nome = "Unknown (" + pp.ID + ")";
                                    pp.Status = "AUTO_TIPO2";
                                    pp.Data_Emissao = DateTime.Now;
                                    pp.Data_Vencto = DateTime.Now;
                                    pp.Index = "CDI+";
                                    pp.SENIOR = "SR_CLEAN";
                                    pp.Holdings = 1;
                                    pp.Coupon = 0;
                                    pp.DayCount = "Bus/252";
                                    pp.CODCETIP = vReader.GetString(vReader.GetOrdinal("PAPEL_COD"));
                                    pp.TIPO = "TITPRIVADO";
                                    pp.CNPJ = "";
                                    pp.NameCr = "";

                                    switch (vReader.GetString(vReader.GetOrdinal("TIPO1")))
                                    {
                                        case "cotas":
                                            pp.Class_Liq = "FIDC";
                                            pp.Class_Rentab = "PERP";
                                            pp.TIPO = "COTAS";
                                            pp.CNPJ = vReader.GetString(vReader.GetOrdinal("CNPJISSUE"));
                                            break;
                                        case "caixa":
                                            pp.Class_Liq = "CASH";
                                            pp.Class_Rentab = "OVER";
                                            pp.TIPO = "CAIXA";
                                            break;
                                        case "DESPESA":
                                            pp.Class_Liq = "CASH";
                                            pp.Class_Rentab = "OVER";
                                            pp.TIPO = "DESPESA";
                                            break;
                                        case "PROVISAO":
                                            pp.Class_Liq = "CASH";
                                            pp.Class_Rentab = "OVER";
                                            pp.TIPO = "PROVISAO";
                                            break;
                                        case "titpublico":
                                            pp.Class_Liq = "TITPUB";
                                            pp.Class_Rentab = "MATURITY";
                                            pp.Data_Emissao = vReader.GetDateTime(vReader.GetOrdinal("DTISSUE1"));
                                            pp.Data_Vencto = vReader.GetDateTime(vReader.GetOrdinal("DTVENC1"));
                                            if (vReader.GetDouble(vReader.GetOrdinal("pindex1")) == 100)
                                            {
                                                pp.Coupon = vReader.GetDouble(vReader.GetOrdinal("cupom1"));
                                                pp.Index = ConvIndex(vReader.GetString(vReader.GetOrdinal("INDEX1")), "+");
                                            }
                                            else
                                            {
                                                pp.Coupon = vReader.GetDouble(vReader.GetOrdinal("pindex1"));
                                                pp.Index = ConvIndex(vReader.GetString(vReader.GetOrdinal("INDEX1")), "%");
                                            }
                                            pp.TIPO = "TITPUBLICO";
                                            break;
                                        case "titprivado":
                                            pp.Class_Liq = "DEB476";
                                            if (vReader.GetString(vReader.GetOrdinal("PAPEL_COD")).StartsWith("LF"))
                                            {
                                                pp.Class_Liq = "LF";
                                            }
                                            else
                                            {
                                                if (vReader.GetString(vReader.GetOrdinal("PAPEL_ISIN")).Substring(8, 3) == "CRI")
                                                {
                                                    pp.Class_Liq = "CRI";
                                                }
                                            }
                                            pp.Class_Rentab = "MATURITY";
                                            pp.Data_Emissao = vReader.GetDateTime(vReader.GetOrdinal("DTISSUE1"));
                                            pp.Data_Vencto = vReader.GetDateTime(vReader.GetOrdinal("DTVENC1"));
                                            if (vReader.GetDouble(vReader.GetOrdinal("pindex1")) == 100)
                                            {
                                                pp.Coupon = vReader.GetDouble(vReader.GetOrdinal("cupom1"));
                                                pp.Index = ConvIndex(vReader.GetString(vReader.GetOrdinal("INDEX1")), "+");
                                            }
                                            else
                                            {
                                                pp.Coupon = vReader.GetDouble(vReader.GetOrdinal("pindex1")) / 100;
                                                pp.Index = ConvIndex(vReader.GetString(vReader.GetOrdinal("INDEX1")), "%");
                                            }
                                            pp.TIPO = "TITPRIVADO";
                                            pp.CNPJ = vReader.GetString(vReader.GetOrdinal("CNPJISSUE"));
                                            break;

                                        case "debenture":
                                            pp.Class_Liq = "DEB476";
                                            pp.Class_Rentab = "MATURITY";
                                            pp.Data_Emissao = vReader.GetDateTime(vReader.GetOrdinal("DTISSUE1"));
                                            pp.Data_Vencto = vReader.GetDateTime(vReader.GetOrdinal("DTVENC1"));
                                            if (vReader.GetDouble(vReader.GetOrdinal("pindex1")) == 100)
                                            {
                                                pp.Coupon = vReader.GetDouble(vReader.GetOrdinal("cupom1"));
                                                pp.Index = ConvIndex(vReader.GetString(vReader.GetOrdinal("INDEX1")), "+");
                                            }
                                            else
                                            {
                                                pp.Coupon = (double)vReader.GetDecimal(vReader.GetOrdinal("pindex1")) / 100;
                                                pp.Index = ConvIndex(vReader.GetString(vReader.GetOrdinal("INDEX1")), "%");
                                            }
                                            pp.TIPO = "DEBENTURE";
                                            pp.CNPJ = vReader.GetString(vReader.GetOrdinal("CNPJISSUE"));
                                            break;
                                        case "acoes":
                                            string codigo = vReader.GetString(vReader.GetOrdinal("PAPEL_COD"));
                                            if (decimal.Parse(codigo.Substring(codigo.Length - 2, 2)) > 10 || decimal.Parse(codigo.Substring(codigo.Length - 3, 3)) > 10)

                                            {
                                                //Fundo imobiliário
                                                pp.Class_Liq = "FIILIST";
                                                pp.Class_Rentab = "PERP";
                                                pp.TIPO = "COTAS";
                                            }
                                            else
                                            {
                                                // 'Ação
                                                pp.Class_Liq = "CASH";
                                                pp.Class_Rentab = "PERP";
                                                pp.TIPO = "ACOES";
                                            }
                                            break;

                                        case "futuros":
                                            pp.Class_Liq = "CASH";
                                            pp.Class_Rentab = "OVER";
                                            pp.TIPO = "FUTUROS";
                                            pp.Data_Vencto = vReader.GetDateTime(vReader.GetOrdinal("DTVENC1"));
                                            pp.Nome = "Fut" + pp.CODCETIP;
                                            break;
                                        case "imoveis":
                                            pp.Class_Liq = "FIINLIST";
                                            pp.Class_Rentab = "PERP";
                                            pp.TIPO = "IMOVEL";
                                            pp.Nome = "Imovel " + pp.CODCETIP;
                                            break;
                                        default:
                                            break;
                                    }

                                    if (pp.Coupon > 0.5 || (pp.Coupon > 2 && pp.Index == "%CDI"))
                                    {
                                        //TODO: Gerar notificação
                                        //WriteLogError "Importação de cupom anormal", pp.ID
                                        pp.Coupon = 0;
                                    }

                                    if (!String.IsNullOrEmpty(pp.CNPJ))
                                    {
                                        TCNPJNome vNome = vContexto.TCNPJNome.FirstOrDefault(w => w.CNPJ.Equals(pp.CNPJ));
                                        if (vNome != null)
                                            pp.NameCr = vNome.NOMECREDITO;
                                    }
                                }

                                vContexto.TPapel.Add(pp);
                                vContexto.SaveChanges();
                                PPISIN = pp.ISIN;
                                ppID = pp.ID;
                            }


                            TPosic vPosicao = new TPosic();
                            vPosicao.FUNDO = vReader.GetInt32(vReader.GetOrdinal("fundo"));
                            vPosicao.PAPEL = ppID;
                            vPosicao.ISIN = PPISIN;
                            vPosicao.Valor = vReader.GetDouble(vReader.GetOrdinal("sv"));
                            vPosicao.DATA = data;
                            vPosicao.QUANT = vReader.GetDouble(vReader.GetOrdinal("sq"));
                            vPosicao.TIPO = 2;

                            vContexto.TPosic.Add(vPosicao);


                        }
                        vContexto.SaveChanges();
                    }
                }

                vConection.Close();
            }
        }

        public static void ImportarResgates()
        {
            //Obter última data dos resgates
            Capitania.EntityFrameworkCore.CapitaniaDbModel vContexto = new EntityFrameworkCore.CapitaniaDbModel();
            DateTime vUltimaData = vContexto.TResgates.Where(w => w.DATAOBS.Value <= DateTime.Now).Max(k => k.DATAOBS).Value;
            if (vUltimaData.Date < new DateTime(2012, 1, 1).Date)
                vUltimaData = new DateTime(2012, 1, 1);

            if (vUltimaData.Date < DateTime.Now.Date)
            {


                DateTime vCutDate = vUltimaData.AddDays(-365);
                //Abrir a planilha excel.
                string vArquivoLeitura = Path.Combine(ParameterManager.GetParameterValue(DBParametersConstants.RedemptionFilePath), ParameterManager.GetParameterValue(DBParametersConstants.RedemptionFileName));
                string vNomePlanilhaResgates = ParameterManager.GetParameterValue(DBParametersConstants.RedemptionFileTab);
                string vNomePlanilhaTransferencia = ParameterManager.GetParameterValue(DBParametersConstants.RedemptionFileTransferTab);
                Application xlApp = new Application();
                Workbook xlWorkbook = xlApp.Workbooks.Open(vArquivoLeitura, null, true);
                _Worksheet planilhaResgates = (_Worksheet)xlWorkbook.Sheets[vNomePlanilhaResgates];
                _Worksheet planilhaTransferencias = (_Worksheet)xlWorkbook.Sheets[vNomePlanilhaTransferencia];

                #region Importar Resgates

                #region Apagar resgates do último ano

                StringBuilder vSQL = new StringBuilder();
                vSQL.AppendLine("delete from TRESGATES");
                vSQL.AppendLine(String.Format(" where DATAOBS >= '{0}'", vCutDate.ToString("yyyy-MM-dd")));
                using (SqlConnection vConection = new SqlConnection(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["ConexaoDB"]].ConnectionString))
                {
                    vConection.Open();
                    using (SqlCommand vComando = new SqlCommand(vSQL.ToString(), vConection))
                    {
                        vComando.ExecuteNonQuery();
                    }
                    vConection.Close();
                }

                #endregion

                int i = 16384;
                int vMaxLines = 30000;

                DateTime? vDataCelula = (planilhaResgates.Cells[i, 1] as Range).Value;
                while ((vDataCelula == null || vDataCelula > vCutDate) && i > 4)
                {
                    i = i / 2;
                    vDataCelula = (planilhaResgates.Cells[i, 1] as Range).Value;
                }

                if (i == 4)
                    i = 3;

                vDataCelula = (planilhaResgates.Cells[i, 1] as Range).Value;
                while (vDataCelula != null && i < vMaxLines && vDataCelula < vCutDate)
                {
                    i++;
                    vDataCelula = (planilhaResgates.Cells[i, 1] as Range).Value;
                }

                while (vDataCelula != null && i < vMaxLines && vDataCelula <= DateTime.Now)
                {
                    TResgates vResgate = new TResgates();
                    vResgate.DATAOBS = vDataCelula;
                    vResgate.FUNDO = (planilhaResgates.Cells[i, 2] as Range).Value;
                    if ((planilhaResgates.Cells[i, 6] as Range).Value == null)
                        vResgate.DATALIQ = vResgate.DATAOBS;
                    else
                        vResgate.DATALIQ = (DateTime)(planilhaResgates.Cells[i, 6] as Range).Value;

                    string vValor = (planilhaResgates.Cells[i, 5] as Range).Value.ToString();
                    vValor = vValor.Replace("R$", "").Replace(",", ".");
                    while (vValor.IndexOf(".") != vValor.LastIndexOf("."))
                        vValor = vValor.Remove(vValor.IndexOf("."));

                    vValor = vValor.Replace(".", ",");
                    vResgate.VALOR = double.Parse(vValor);
                    string vCancelado = (planilhaResgates.Cells[i, 9] as Range).Value;
                    vResgate.CANCELADO = (!String.IsNullOrEmpty(vCancelado));
                    vResgate.TOTAL = ((planilhaResgates.Cells[i, 7] as Range).Value.ToString() == "T");
                    DateTime vDataCancelamento;
                    string vStringData = string.Empty;
                    if ((planilhaResgates.Cells[i, 10] as Range).Value != null)
                        vStringData = (planilhaResgates.Cells[i, 10] as Range).Value.ToString();
                    if (DateTime.TryParse(vStringData, out vDataCancelamento))
                        vResgate.DATACANCEL = vDataCancelamento;
                    else
                        vResgate.DATACANCEL = new DateTime(2000, 01, 01);

                    vContexto.TResgates.Add(vResgate);
                    i++;

                    vDataCelula = (planilhaResgates.Cells[i, 1] as Range).Value;
                }

                vContexto.SaveChanges();

                #endregion

                #region Importar Transferências

                //Abrir a planilha excel.

                #region Apagar resgates do último ano

                vSQL = new StringBuilder();
                vSQL.AppendLine("delete from TTRANSFERS");
                vSQL.AppendLine(String.Format(" where DATAOBS >= '{0}'", vCutDate.ToString("yyyy-MM-dd")));
                using (SqlConnection vConection = new SqlConnection(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["ConexaoDB"]].ConnectionString))
                {
                    vConection.Open();
                    using (SqlCommand vComando = new SqlCommand(vSQL.ToString(), vConection))
                    {
                        vComando.ExecuteNonQuery();
                    }
                    vConection.Close();
                }

                #endregion

                i = 2048;

                DateTime? vValorDataCelular = (planilhaTransferencias.Cells[i, 1] as Range).Value;
                while ((vValorDataCelular == null || vValorDataCelular > vCutDate) && i > 4)
                {
                    i = i / 2;
                    vValorDataCelular = (planilhaTransferencias.Cells[i, 1] as Range).Value;
                }

                if (i == 4)
                    i = 3;

                vValorDataCelular = (planilhaTransferencias.Cells[i, 1] as Range).Value;
                while (vValorDataCelular != null && i < vMaxLines && vValorDataCelular < vCutDate)
                {
                    i++;
                    vValorDataCelular = (planilhaTransferencias.Cells[i, 1] as Range).Value;
                }

                while (vValorDataCelular != null && i < vMaxLines && vValorDataCelular <= DateTime.Now)
                {
                    TTransfers vTransfer = new TTransfers();
                    vTransfer.DATAOBS = vValorDataCelular;
                    vTransfer.FUNDO = (planilhaTransferencias.Cells[i, 4] as Range).Value;
                    if ((planilhaTransferencias.Cells[i, 6] as Range).Value == null)
                        vTransfer.DATALIQ = vTransfer.DATAOBS;
                    else
                        vTransfer.DATALIQ = (DateTime)(planilhaTransferencias.Cells[i, 6] as Range).Value;

                    string vValor = (planilhaResgates.Cells[i, 5] as Range).Value.ToString();
                    vValor = vValor.Replace("R$", "").Replace(",", ".");
                    while (vValor.IndexOf(".") != vValor.LastIndexOf("."))
                        vValor = vValor.Remove(vValor.IndexOf("."));

                    vValor = vValor.Replace(".", ",");
                    vTransfer.VALOR = double.Parse(vValor);
                    string vCancelado = (planilhaTransferencias.Cells[i, 9] as Range).Value;
                    vTransfer.CANCELADO = (!String.IsNullOrEmpty(vCancelado));
                    DateTime vDataCancelamento;
                    string vStringData = string.Empty;
                    if ((planilhaResgates.Cells[i, 10] as Range).Value != null)
                        vStringData = (planilhaResgates.Cells[i, 10] as Range).Value.ToString();
                    if (DateTime.TryParse(vStringData, out vDataCancelamento))
                        vTransfer.DATACANCEL = vDataCancelamento;
                    else
                        vTransfer.DATACANCEL = new DateTime(2000, 01, 01);

                    vContexto.TTransfers.Add(vTransfer);
                    i++;
                    vValorDataCelular = (planilhaTransferencias.Cells[i, 1] as Range).Value;
                }

                vContexto.SaveChanges();

                xlWorkbook.Close(false);
                xlApp.Quit();
                #endregion
            }

            //TODO: Marcar flag de importação do dia;
            //TODO: Logar importação

        }

        public static void ImportarSeriesDeRisco()
        {

            string vArquivoLeitura = Path.Combine(ParameterManager.GetParameterValue(DBParametersConstants.HistFilePath), ParameterManager.GetParameterValue(DBParametersConstants.HistFileName));
            string vNomePlanilhaImportacao = ParameterManager.GetParameterValue(DBParametersConstants.HistFileTab);
            Application xlApp = new Application();
            Workbook xlWorkbook = xlApp.Workbooks.Open(vArquivoLeitura, null, true);
            _Worksheet planilhaImportacao = (_Worksheet)xlWorkbook.Sheets[vNomePlanilhaImportacao];


            #region Importa séries de mercado

            ImportarSerie("IFIX", ParameterManager.GetParameterValue(DBParametersConstants.HistFileIFIX), planilhaImportacao);
            ImportarSerie("IPCA2Y", ParameterManager.GetParameterValue(DBParametersConstants.HistFileIPCA2Y), planilhaImportacao);
            ImportarSerie("IPCA5Y", ParameterManager.GetParameterValue(DBParametersConstants.HistFileIPCA5Y), planilhaImportacao);
            ImportarSerie("IPCA10Y", ParameterManager.GetParameterValue(DBParametersConstants.HistFileIPCA10Y), planilhaImportacao);
            ImportarSerie("IMAB5", ParameterManager.GetParameterValue(DBParametersConstants.HistFileIMAB5), planilhaImportacao);
            ImportarSerie("PRE2Y", ParameterManager.GetParameterValue(DBParametersConstants.HistFilePRE2Y), planilhaImportacao);
            ImportarSerie("PRE5Y", ParameterManager.GetParameterValue(DBParametersConstants.HistFilePRE5Y), planilhaImportacao);
            ImportarSerie("DOLAR", ParameterManager.GetParameterValue(DBParametersConstants.HistFileDolar), planilhaImportacao);
            ImportarSerie("IDA", ParameterManager.GetParameterValue(DBParametersConstants.HistFileIDA), planilhaImportacao);

            #endregion

            #region Importa ratings

            vNomePlanilhaImportacao = ParameterManager.GetParameterValue(DBParametersConstants.HistFileRatingsTab);
            planilhaImportacao = xlWorkbook.Sheets[vNomePlanilhaImportacao];
            int i = 1;
            string vConteudoCelula = (planilhaImportacao.Cells[1, i] as Range).Value;
            while (!String.IsNullOrEmpty(vConteudoCelula) && i < 256)
            {
                if (vConteudoCelula.Contains(" "))
                {
                    vConteudoCelula = vConteudoCelula.Trim().Substring(0, vConteudoCelula.IndexOf(" "));
                    DateTime? vDate = (planilhaImportacao.Cells[4, i] as Range).Value;
                    if (vDate != null)
                    {
                        StringBuilder vSQL = new StringBuilder();
                        vSQL.AppendLine("delete from TRATINGS");
                        vSQL.AppendLine(String.Format(" where ID = '{0}'", vConteudoCelula));
                        vSQL.AppendLine(String.Format("   and DATA >= '{0}'", vDate.Value.ToString("yyyy-MM-dd")));
                        using (SqlConnection vConection = new SqlConnection(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["ConexaoDB"]].ConnectionString))
                        {
                            vConection.Open();
                            using (SqlCommand vComando = new SqlCommand(vSQL.ToString(), vConection))
                            {
                                vComando.ExecuteNonQuery();
                            }

                            int j = 4;
                            vDate = (planilhaImportacao.Cells[j, i] as Range).Value;
                            while (vDate != null)
                            {
                                vSQL.AppendLine("INSERT INTO TRATINGS (DATA, ID, RATING) values (");
                                vSQL.AppendLine(String.Format("'{0}', '{1}', '{2}');", vDate.Value.ToString("yyyy-MM-dd"), vConteudoCelula, (planilhaImportacao.Cells[j, i + 1] as Range).Value));
                                using (SqlCommand vComando = new SqlCommand(vSQL.ToString(), vConection))
                                {
                                    vComando.ExecuteNonQuery();
                                }
                                j++;
                                vDate = (planilhaImportacao.Cells[j, i] as Range).Value;
                            }
                            vConection.Close();
                        }
                    }
                }
                i++;
                i++;
                vConteudoCelula = (planilhaImportacao.Cells[1, i] as Range).Value;
            }

            #endregion

            #region Importa quotas

            vNomePlanilhaImportacao = ParameterManager.GetParameterValue(DBParametersConstants.HistFileQuotaTab);
            planilhaImportacao = xlWorkbook.Sheets[vNomePlanilhaImportacao];

            i = 1;
            double? vValorCelula = (planilhaImportacao.Cells[1, i] as Range).Value;
            while (vValorCelula != null && i < 256)
            {
                double vIDFundo = vValorCelula.Value;
                DateTime? vDate = (planilhaImportacao.Cells[6, i] as Range).Value;
                if (vDate != null)
                {
                    StringBuilder vSQL = new StringBuilder();
                    vSQL.AppendLine("delete from TQUOTAS");
                    vSQL.AppendLine(String.Format(" where FUNDO = '{0}'", vIDFundo));
                    vSQL.AppendLine(String.Format("   and DATA >= '{0}'", vDate.Value.ToString("yyyy-MM-dd")));
                    using (SqlConnection vConection = new SqlConnection(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["ConexaoDB"]].ConnectionString))
                    {
                        vConection.Open();
                        using (SqlCommand vComando = new SqlCommand(vSQL.ToString(), vConection))
                        {
                            vComando.ExecuteNonQuery();
                        }

                        int j = 6;
                        vDate = (planilhaImportacao.Cells[j, i] as Range).Value;
                        while (vDate != null)
                        {
                            vSQL.AppendLine("INSERT INTO TQUOTAS (DATA, FUNDO, QUOTA) values (");
                            vSQL.AppendLine(String.Format("'{0}', '{1}', {2});", vDate.Value.ToString("yyyy-MM-dd"), vIDFundo, (planilhaImportacao.Cells[j, i + 1] as Range).Value.ToString().Replace(",", ".")));
                            using (SqlCommand vComando = new SqlCommand(vSQL.ToString(), vConection))
                            {
                                vComando.ExecuteNonQuery();
                            }
                            j++;
                            vDate = (planilhaImportacao.Cells[j, i] as Range).Value;
                        }
                        vConection.Close();
                    }
                }

                i = i + 3;
                vValorCelula = (planilhaImportacao.Cells[1, i] as Range).Value;
            }

            #endregion

            xlWorkbook.Close(false);
            xlApp.Quit();

            //TODO: Marcar flag de importação do dia;
            //TODO: Logar importação
        }

        public static void ImportarMaiorCotistas()
        {
            string vArquivoLeitura = Path.Combine(ParameterManager.GetParameterValue(DBParametersConstants.ShareFilePath), ParameterManager.GetParameterValue(DBParametersConstants.ShareFileName));
            string vNomePlanilhaImportacao = "DATA";
            Application xlApp = new Application();
            Workbook xlWorkbook = xlApp.Workbooks.Open(vArquivoLeitura, null, true);
            _Worksheet planilhaImportacao = xlWorkbook.Sheets[vNomePlanilhaImportacao];

            DateTime? vData = (planilhaImportacao.Cells[1, 1] as Range).Value;
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("delete from TMAIORCOTISTA");
            vSQL.AppendLine(String.Format(" where DATAOBS = '{0}'", vData.Value.ToString("yyyy-MM-dd")));
            using (SqlConnection vConection = new SqlConnection(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["ConexaoDB"]].ConnectionString))
            {
                vConection.Open();
                using (SqlCommand vComando = new SqlCommand(vSQL.ToString(), vConection))
                {
                    vComando.ExecuteNonQuery();
                }

                for (int i = 1; i <= xlWorkbook.Worksheets.Count; i++)
                {
                    string vNomeQuota = xlWorkbook.Worksheets.Item[i].Name;
                    if (!vNomeQuota.Equals("DATA"))
                    {
                        planilhaImportacao = xlWorkbook.Sheets[vNomeQuota]; ;
                        int Col = 3;
                        double? vValor = (planilhaImportacao.Cells[2, 3] as Range).Value;

                        string vValorHeader = (planilhaImportacao.Cells[1, 4] as Range).Value;
                        if ((!String.IsNullOrEmpty(vValorHeader) && vValorHeader.ToString().Equals("VALOR BRUTO")) || vValor == null)
                            Col = 4;

                        int k = 2;
                        int j = 1;
                        double?[] vValores = { 0, 0, 0 };

                        string vConteudoCelula = (planilhaImportacao.Cells[k, 1] as Range).Value;
                        while (!String.IsNullOrEmpty(vConteudoCelula) && k < 100 && j < 4)
                        {
                            string vValorCelular = (planilhaImportacao.Cells[i, Col + 1] as Range).Value;
                            if (String.IsNullOrEmpty(vValorCelular))
                            {
                                double? vValorCotista = (planilhaImportacao.Cells[k, Col] as Range).Value;
                                if (vValorCotista != null)
                                    vValores[j - 1] = vValorCotista;
                                else
                                    vValores[j - 1] = 0;
                                j++;
                            }
                            k++;
                            vConteudoCelula = (planilhaImportacao.Cells[k, 1] as Range).Value;
                        }

                        vSQL = new StringBuilder();
                        vSQL.AppendLine("INSERT INTO TMAIORCOTISTA (DATAOBS, FUNDO, MAXCOT1, MAXCOT2, MAXCOT3) VALUES (");
                        vSQL.AppendLine(String.Format("'{0}', '{1}', {2}, {3}, {4});", vData.Value.ToString("yyyy-MM-dd"), vNomeQuota, vValores[0].ToString().Replace(",", "."), vValores[1].ToString().Replace(",", "."), vValores[2].ToString().Replace(",", ".")));
                        using (SqlCommand vComando = new SqlCommand(vSQL.ToString(), vConection))
                        {
                            vComando.ExecuteNonQuery();
                        }
                    }
                }

                vConection.Close();
            }

            xlWorkbook.Close(false);
            xlApp.Quit();
            //TODO: Marcar flag de importação do dia;
            //TODO: Logar importação
        }

        public static void ImportarTrades()
        {
            Capitania.EntityFrameworkCore.CapitaniaDbModel vContexto = new EntityFrameworkCore.CapitaniaDbModel();

            DateTime? vMaxData = vContexto.TTrades.Max(w => w.DATA);
            if (vMaxData == null)
                vMaxData = DateTime.Now.AddDays(-30);

            if (vMaxData.Value.Date > DateTime.Now.Date)
                vMaxData = DateTime.Now.AddDays(-1);

            vMaxData = vMaxData.Value.AddDays(-15);
            StringBuilder vSQL = new StringBuilder();
            vSQL.AppendLine("delete from TTRADES");
            vSQL.AppendLine(String.Format(" where DATA >= '{0}'", vMaxData.Value.ToString("yyyy-MM-dd")));
            using (SqlConnection vConection = new SqlConnection(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["ConexaoDB"]].ConnectionString))
            {
                vConection.Open();
                using (SqlCommand vComando = new SqlCommand(vSQL.ToString(), vConection))
                {
                    vComando.ExecuteNonQuery();
                }

                string vArquivoLeitura = ParameterManager.GetParameterValue(DBParametersConstants.RFETradeSheet);
                string vNomePlanilhaResgates = ParameterManager.GetParameterValue(DBParametersConstants.RFETradeTab);
                Application xlApp = new Application();
                Workbook xlWorkbook = xlApp.Workbooks.Open(vArquivoLeitura, null, true);
                _Worksheet planilhaTrades = (_Worksheet)xlWorkbook.Sheets[vNomePlanilhaResgates];

                int hi = 16000;
                int lo = 10;
                int meio = (hi + lo) / 2;
                DateTime? celmeio = new DateTime(1990, 01, 01);

                while (hi > lo && celmeio != vMaxData.Value)
                {
                    meio = (hi + lo) / 2;
                    celmeio = (planilhaTrades.Cells[meio, 1] as Range).Value;
                    if (celmeio == null || celmeio > vMaxData.Value)
                        hi = meio - 1;
                    else
                        lo = meio + 1;
                }

                int i = meio;
                DateTime? vData = (planilhaTrades.Cells[i, 1] as Range).Value;
                while (vData >= vMaxData && i > 5)
                {
                    i--;
                    vData = (planilhaTrades.Cells[i, 1] as Range).Value;
                }
                vData = (planilhaTrades.Cells[i, 1] as Range).Value;
                while (vData != null && vData < vMaxData)
                {
                    i++;
                    vData = (planilhaTrades.Cells[i, 1] as Range).Value;
                }

                vData = (planilhaTrades.Cells[i, 1] as Range).Value;
                while (vData != null)
                {

                    TTrades vTrade = new TTrades();
                    vTrade.DATA = vData;
                    vTrade.HORA = DateTime.Now;
                    vTrade.HORA_MS = (DateTime.Now - DateTime.Today).TotalSeconds;
                    vTrade.FUNDO = (planilhaTrades.Cells[i, 2] as Range).Value.ToString();
                    vTrade.ATIVO = (planilhaTrades.Cells[i, 10] as Range).Value.ToString();
                    vTrade.CV = (planilhaTrades.Cells[i, 4] as Range).Value.ToString();
                    string vValor = (planilhaTrades.Cells[i, 5] as Range).Value.ToString();
                    vValor = vValor.Replace("R$", "").Replace(",", ".");
                    while (vValor.IndexOf(".") != vValor.LastIndexOf("."))
                        vValor = vValor.Remove(vValor.IndexOf("."));

                    vValor = vValor.Replace(".", ",");
                    vTrade.QUANT = double.Parse(vValor);
                    vTrade.TAXA = 0;
                    vValor = (planilhaTrades.Cells[i, 6] as Range).Value.ToString();
                    vValor = vValor.Replace("R$", "").Replace(",", ".");
                    while (vValor.IndexOf(".") != vValor.LastIndexOf("."))
                        vValor = vValor.Remove(vValor.IndexOf("."));

                    vValor = vValor.Replace(".", ",");
                    vTrade.PU = double.Parse(vValor);
                    vTrade.PRICEREF = 0;
                    vTrade.PRICESRC = string.Empty;
                    vTrade.BROKER = (planilhaTrades.Cells[i, 3] as Range).Value.ToString();
                    vTrade.PRODUTO = (planilhaTrades.Cells[i, 23] as Range).Value.ToString();
                    vTrade.NOMEATIVO = (planilhaTrades.Cells[i, 24] as Range).Value.ToString();
                    vValor = (planilhaTrades.Cells[i, 7] as Range).Value.ToString();
                    vValor = vValor.Replace("R$", "").Replace(",", ".");
                    while (vValor.IndexOf(".") != vValor.LastIndexOf("."))
                        vValor = vValor.Remove(vValor.IndexOf("."));

                    vValor = vValor.Trim().Replace(".", ",");
                    vTrade.VALFIN = double.Parse(vValor);
                    vContexto.TTrades.Add(vTrade);

                    i++;
                    vData = (planilhaTrades.Cells[i, 1] as Range).Value;
                }

                vContexto.SaveChanges();
                //importar arquivo .negs

                DateTime vDataAtual = DateTime.Now;
                vData = vMaxData;
                while (vData <= vDataAtual)
                {
                    string vValorParametroNegsFilePrefixo = ParameterManager.GetParameterValue(DBParametersConstants.NegsFilePrefix);
                    string vPrefixoNegsFile = Path.GetFileName(vValorParametroNegsFilePrefixo);
                    string vNegFilePath = Path.GetDirectoryName(vValorParametroNegsFilePrefixo);

                    foreach (string vFile in Directory.GetFiles(vNegFilePath, String.Format("{0}*{1}.txt", vPrefixoNegsFile, vData.Value.ToString("dd_MM_yyyy"))))
                    {
                        var vLinhas = File.ReadLines(vFile);
                        foreach (var vLinha in vLinhas)
                        {
                            if (!vLinha.StartsWith("0#") && !vLinha.StartsWith("99#"))
                            {
                                string[] vValores = vLinha.Substring(1).Split('#');
                                string vFundo = vValores[1];
                                string vCV = vValores[2];
                                string vAtivo = vValores[5];
                                string vBroker = vValores[7];
                                decimal vQuantidade = decimal.Parse(vValores[9].Replace(".", ","));
                                decimal vPreco = decimal.Parse(vValores[10].Replace(".", ","));
                                TTrades vTrade = new TTrades();
                                vTrade.DATA = vData;
                                vTrade.HORA = DateTime.Now;
                                vTrade.HORA_MS = (DateTime.Now - DateTime.Today).TotalSeconds;
                                vTrade.FUNDO = vFundo;
                                vTrade.ATIVO = vAtivo;
                                vTrade.CV = vCV;
                                vTrade.QUANT = (double)vQuantidade;
                                vTrade.TAXA = (double)vPreco;
                                vTrade.PU = (double)vPreco;
                                vTrade.PRICEREF = 0;
                                vTrade.PRICESRC = string.Empty;
                                vTrade.BROKER = vBroker;
                                vTrade.PRODUTO = "RV";
                                vContexto.TTrades.Add(vTrade);
                            }
                        }

                    }

                    vData = vData.Value.AddDays(1);
                }

                vContexto.SaveChanges();

                xlWorkbook.Close(false);
                xlApp.Quit();

                vConection.Close();
            }

            //TODO: Marcar flag de importação do dia;
            //TODO: Logar importação
        }

        public static void ImportarPrincing()
        {
            Capitania.EntityFrameworkCore.CapitaniaDbModel vContexto = new EntityFrameworkCore.CapitaniaDbModel();
            DateTime? vUltimaData = vContexto.TPricing.Max(w => w.DATAOBS);
            if (vUltimaData != null)
                vUltimaData = vUltimaData.Value.AddDays(-5);

            if (vUltimaData.Value.Date < new DateTime(2015, 10, 1))
                vUltimaData = new DateTime(2015, 10, 1);

            if (vUltimaData.Value.Date < DateTime.Now.Date)
            {
                string vArquivoLeitura = ParameterManager.GetParameterValue(DBParametersConstants.FIIFileName);
                string vNomePlanilhaPricing = ParameterManager.GetParameterValue(DBParametersConstants.FIIFileTab);
                Application xlApp = new Application();
                Workbook xlWorkbook = xlApp.Workbooks.Open(vArquivoLeitura, null, true);
                _Worksheet planilaPricing = (_Worksheet)xlWorkbook.Sheets[vNomePlanilhaPricing];

                vUltimaData = vUltimaData.Value.AddDays(1);
                string vFileNomePrefixo = ParameterManager.GetParameterValue(DBParametersConstants.PricingFilePrefix);
                while (vUltimaData.Value.Date < DateTime.Now.Date)
                {
                    string vFileName = string.Format("{0}{1}.txt", vFileNomePrefixo, vUltimaData.Value.ToString("yyyyMMdd"));
                    if (File.Exists(vFileName))
                    {
                        var vLinhas = File.ReadLines(vFileName);
                        List<string> vAtivosProcessados = new List<string>();
                        foreach (var vLinha in vLinhas)
                        {
                            if (!String.IsNullOrEmpty(vLinha))
                            {
                                if (vLinha.StartsWith("RF;"))
                                {
                                    string[] vValores = vLinha.Split(';');
                                    string vAtivo = vValores[2];
                                    string TipoPr = vValores[5];
                                    if (!TipoPr.Equals("CRIVT") && !TipoPr.Equals("CRIPR") && !TipoPr.Equals("DEBVT") && !TipoPr.Equals("DBPRV") && !vAtivosProcessados.Contains(String.Format(@"\{0}\", vAtivo)))
                                        vAtivosProcessados.Add(String.Format(@"\{0}\", vAtivo));
                                    decimal vValor = decimal.Parse(vValores[11].Replace(".", ","));
                                    StringBuilder vSQL = new StringBuilder();
                                    vSQL.AppendLine("DELETE FROM TPRICING");
                                    vSQL.AppendLine(String.Format(" WHERE DATAOBS = '{0}' ", vUltimaData.Value.ToString("yyyy-MM-dd")));
                                    vSQL.AppendLine(String.Format("   AND ATIVO = '{0}'", vAtivo));
                                    using (SqlConnection vConection = new SqlConnection(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["ConexaoDB"]].ConnectionString))
                                    {
                                        vConection.Open();
                                        using (SqlCommand vComando = new SqlCommand(vSQL.ToString(), vConection))
                                        {
                                            vComando.ExecuteNonQuery();
                                        }

                                        vSQL = new StringBuilder();
                                        vSQL.AppendLine(String.Format("INSERT INTO TPRICING (DATAOBS, ATIVO, PRECO) VALUES ('{0}', '{1}', {2})", vUltimaData.Value.ToString("yyyy-MM-dd"), vAtivo, vValor.ToString().Replace(",", ".")));
                                        using (SqlCommand vComando = new SqlCommand(vSQL.ToString(), vConection))
                                        {
                                            vComando.ExecuteNonQuery();
                                        }

                                        vConection.Close();
                                    }
                                }
                            }
                        }
                    }

                    int j = 1;
                    var vConteudoCelula = (planilaPricing.Cells[1, j] as Range).Value;
                    while (vConteudoCelula != null)
                    {
                        string vAtivo = string.Empty;

                        if (vConteudoCelula.ToString().Contains(" "))
                            vAtivo = vConteudoCelula.ToString().Substring(0, vConteudoCelula.ToString().IndexOf(" "));
                        else
                            vAtivo = vConteudoCelula.ToString();

                        int i = 4;
                        DateTime? vDataCelula = (planilaPricing.Cells[i, j] as Range).Value;
                        while (vDataCelula != null && vDataCelula != vUltimaData)
                        {
                            i++;
                            vDataCelula = (planilaPricing.Cells[i, j] as Range).Value;
                        }


                        vDataCelula = (planilaPricing.Cells[i, j] as Range).Value;
                        if (vDataCelula == vUltimaData)
                        {
                            using (SqlConnection vConection = new SqlConnection(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["ConexaoDB"]].ConnectionString))
                            {
                                vConection.Open();
                                StringBuilder vSQL = new StringBuilder();
                                vSQL.AppendLine("DELETE FROM TPRICING ");
                                vSQL.AppendLine(String.Format(" WHERE DATAOBS = '{0}'", vUltimaData.Value.ToString("yyyy-MM-dd")));
                                vSQL.AppendLine(String.Format("   AND ATIVO = '{0}'", vAtivo));
                                using (SqlCommand vComando = new SqlCommand(vSQL.ToString(), vConection))
                                {
                                    vComando.ExecuteNonQuery();
                                }
                                TPricing vPricing = new TPricing();
                                vPricing.DATAOBS = vUltimaData;
                                vPricing.ATIVO = vAtivo;
                                string vValor = (planilaPricing.Cells[i, j + 1] as Range).Value.ToString();
                                vValor = vValor.Replace("R$", "").Replace(",", ".");
                                while (vValor.IndexOf(".") != vValor.LastIndexOf("."))
                                    vValor = vValor.Remove(vValor.IndexOf("."));

                                vValor = vValor.Replace(".", ",");
                                vPricing.PRECO = double.Parse(vValor);
                                vContexto.TPricing.Add(vPricing);

                                vConection.Close();
                            }
                        }
                        j = j + 3;
                        vConteudoCelula = (planilaPricing.Cells[1, j] as Range).Value;
                    }
                    vUltimaData = vUltimaData.Value.AddDays(1);
                }
                vContexto.SaveChanges();

                xlWorkbook.Close(false);
                xlApp.Quit();
            }


            //TODO: Marcar flag de importação do dia;
            //TODO: Logar importação
        }

        public static void ImportarADTV()
        {
            Capitania.EntityFrameworkCore.CapitaniaDbModel vContexto = new EntityFrameworkCore.CapitaniaDbModel();
            DateTime? vUltimaData = vContexto.TADTV.Where(k => k.DATA <= DateTime.Now).Max(w => w.DATA);
            if (vUltimaData != null)
                vUltimaData = vUltimaData.Value.AddDays(-5);

            if (vUltimaData.Value.Date < new DateTime(2015, 10, 1))
                vUltimaData = new DateTime(2015, 10, 1);

            if (vUltimaData.Value.Date < DateTime.Now.Date)
            {
                string vArquivoLeitura = ParameterManager.GetParameterValue(DBParametersConstants.FIIFileName);
                string vNomePlanilhaPricing = ParameterManager.GetParameterValue(DBParametersConstants.FIIADTVTab);
                Application xlApp = new Application();
                Workbook xlWorkbook = xlApp.Workbooks.Open(vArquivoLeitura, null, true);
                _Worksheet planilaPricing = (_Worksheet)xlWorkbook.Sheets[vNomePlanilhaPricing];

                int j = 1;
                var vConteudoCelula = (planilaPricing.Cells[1, j] as Range).Value;
                while (vConteudoCelula != null)
                {
                    string vAtivo = string.Empty;

                    if (vConteudoCelula.ToString().Contains(" "))
                        vAtivo = vConteudoCelula.ToString().Substring(0, vConteudoCelula.ToString().IndexOf(" "));
                    else
                        vAtivo = vConteudoCelula.ToString();

                    int i = 4;
                    DateTime vData = new DateTime(2015, 10, 1);
                    DateTime? vDataCelula = (planilaPricing.Cells[i, j] as Range).Value;
                    while (vDataCelula != null && i < 100)
                    {
                        if (vDataCelula > vUltimaData)
                        {
                            vData = vDataCelula.Value;
                            double? vValor = (planilaPricing.Cells[1, j + 1] as Range).Value;
                            if (vValor != null)
                            {
                                double? vADTVCond = (planilaPricing.Cells[1, j + 2] as Range).Value;
                                if (vADTVCond == null)
                                {
                                    vADTVCond = vValor;
                                }
                                using (SqlConnection vConection = new SqlConnection(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["ConexaoDB"]].ConnectionString))
                                {
                                    vConection.Open();
                                    StringBuilder vSQL = new StringBuilder();
                                    vSQL.AppendLine("DELETE FROM TADTV ");
                                    vSQL.AppendLine(String.Format(" WHERE NOME = '{0}'", vAtivo));
                                    vSQL.AppendLine(String.Format("   AND DATA = '{0}'", vData.ToString("yyyy-MM-dd")));
                                    using (SqlCommand vComando = new SqlCommand(vSQL.ToString(), vConection))
                                    {
                                        vComando.ExecuteNonQuery();
                                    }
                                    TADTV vTADTV = new TADTV();
                                    vTADTV.DATA = vData;
                                    vTADTV.NOME = vAtivo;
                                    vTADTV.ADTV = vValor;
                                    vTADTV.ADTVCOND = vADTVCond;
                                    vTADTV.ADTVCLASSE = vValor;
                                    vTADTV.ADTVCLASSECOND = vADTVCond;
                                    vContexto.TADTV.Add(vTADTV);

                                    vConection.Close();
                                }
                            }

                        }
                        i++;
                        vDataCelula = (planilaPricing.Cells[i, j] as Range).Value;
                    }
                    j = j + 3;
                    vConteudoCelula = (planilaPricing.Cells[1, j] as Range).Value;
                }

                vContexto.SaveChanges();
                xlWorkbook.Close(false);
                xlApp.Quit();
            }


            //TODO: Marcar flag de importação do dia;
            //TODO: Logar importação
        }
        private static void ImportarSerie(string dbName, string nomePlanilha, _Worksheet planilha)
        {
            DateTime vUltimaData = DateTime.Now.AddDays(-3650);
            Capitania.EntityFrameworkCore.CapitaniaDbModel vContexto = new EntityFrameworkCore.CapitaniaDbModel();
            DateTime dataLimite = DateTime.Now.AddDays(-720);
            DateTime? vLastDate = vContexto.TFACTORHIST.Where(w => w.FACTORID.Equals(dbName) && w.DATA < DateTime.Now && w.DATA > dataLimite).Max(k => k.DATA);
            bool vImcompleta = false;
            if (vLastDate == null)
                vImcompleta = true;
            else
            {
                vUltimaData = vLastDate.Value;
                vImcompleta = VerificarIncompleta(vUltimaData);
            }

            int j = SearchColumn(nomePlanilha, planilha);
            if (j != 0)
            {
                int i = 4;
                DateTime? vConteudoCelula = (planilha.Cells[i, j] as Range).Value;
                while (vConteudoCelula != null && i < 2000)
                {
                    DateTime vData;
                    if (vConteudoCelula > vUltimaData)
                    {
                        TFACTORHIST vHist = new TFACTORHIST();
                        vHist.FACTORID = dbName;
                        vHist.DATA = vConteudoCelula.Value;
                        vHist.VALOR = (planilha.Cells[i, j + 1] as Range).Value;
                        vContexto.TFACTORHIST.Add(vHist);
                    }

                    i++;
                    vConteudoCelula = (planilha.Cells[i, j] as Range).Value;
                }

                vContexto.SaveChanges();

            }
        }

        private static int SearchColumn(string x, _Worksheet planilha)
        {
            int i = 1;

            while ((planilha.Cells[1, i] as Range).Value != x && i < 100)
            {
                i++;
                i++;
            }

            if ((planilha.Cells[1, i] as Range).Value == x)
                return i;
            else
                return 0;
        }

        private static bool VerificarIncompleta(DateTime vData)
        {
            if (vData.DayOfWeek == DayOfWeek.Monday)
                return (vData < vData.AddDays(-3));
            else
                return (vData < vData.AddDays(-1));
        }
    }
}
