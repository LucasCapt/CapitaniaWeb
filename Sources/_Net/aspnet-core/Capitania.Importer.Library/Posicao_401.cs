using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Capitania.Importer.Library
{
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlRootAttribute("arquivoposicao_4_01", Namespace = "", IsNullable = false)]
    public partial class ArquivoPosicao_4_01_type
    {

        private Fundo_type[] fundoField;

        private Carteira_type[] carteiraField;

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("fundo")]
        public Fundo_type[] fundo
        {
            get
            {
                return this.fundoField;
            }
            set
            {
                this.fundoField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("carteira")]
        public Carteira_type[] carteira
        {
            get
            {
                return this.carteiraField;
            }
            set
            {
                this.carteiraField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class Fundo_type
    {

        private header_fundo_type headerField;

        private partplanprev_type[] partplanprevField;

        private titpublico_type[] titpublicoField;

        private titprivado_type[] titprivadoField;

        private debenture_type[] debentureField;

        private acoes_type[] acoesField;

        private opcoesacoes_type[] opcoesacoesField;

        private opcoesderiv_type[] opcoesderivField;

        private opcoesflx_type[] opcoesflxField;

        private termorv_type[] termorvField;

        private termorf_type[] termorfField;

        private futuros_type[] futurosField;

        private swap_type[] swapField;

        private caixa_type[] caixaField;

        private cotas_type[] cotasField;

        private despesas_type despesasField;

        private outrasdespesas_type[] outrasdespesasField;

        private provisao_type[] provisaoField;

        private corretagem_type[] corretagemField;

        private imovel_type[] imoveisField;

        private opcoesmoedasotcl_type[] opcoesmoedasotcField;

        private forwardsmoedas_type[] forwardsmoedasField;

        private participacoes_type[] participacoesField;

        private fidc_type[] fidcField;

        /// <remarks/>
        public header_fundo_type header
        {
            get
            {
                return this.headerField;
            }
            set
            {
                this.headerField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("partplanprev")]
        public partplanprev_type[] partplanprev
        {
            get
            {
                return this.partplanprevField;
            }
            set
            {
                this.partplanprevField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("titpublico")]
        public titpublico_type[] titpublico
        {
            get
            {
                return this.titpublicoField;
            }
            set
            {
                this.titpublicoField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("titprivado")]
        public titprivado_type[] titprivado
        {
            get
            {
                return this.titprivadoField;
            }
            set
            {
                this.titprivadoField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("debenture")]
        public debenture_type[] debenture
        {
            get
            {
                return this.debentureField;
            }
            set
            {
                this.debentureField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("acoes")]
        public acoes_type[] acoes
        {
            get
            {
                return this.acoesField;
            }
            set
            {
                this.acoesField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("opcoesacoes")]
        public opcoesacoes_type[] opcoesacoes
        {
            get
            {
                return this.opcoesacoesField;
            }
            set
            {
                this.opcoesacoesField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("opcoesderiv")]
        public opcoesderiv_type[] opcoesderiv
        {
            get
            {
                return this.opcoesderivField;
            }
            set
            {
                this.opcoesderivField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("opcoesflx")]
        public opcoesflx_type[] opcoesflx
        {
            get
            {
                return this.opcoesflxField;
            }
            set
            {
                this.opcoesflxField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("termorv")]
        public termorv_type[] termorv
        {
            get
            {
                return this.termorvField;
            }
            set
            {
                this.termorvField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("termorf")]
        public termorf_type[] termorf
        {
            get
            {
                return this.termorfField;
            }
            set
            {
                this.termorfField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("futuros")]
        public futuros_type[] futuros
        {
            get
            {
                return this.futurosField;
            }
            set
            {
                this.futurosField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("swap")]
        public swap_type[] swap
        {
            get
            {
                return this.swapField;
            }
            set
            {
                this.swapField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("caixa")]
        public caixa_type[] caixa
        {
            get
            {
                return this.caixaField;
            }
            set
            {
                this.caixaField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("cotas")]
        public cotas_type[] cotas
        {
            get
            {
                return this.cotasField;
            }
            set
            {
                this.cotasField = value;
            }
        }

        /// <remarks/>
        public despesas_type despesas
        {
            get
            {
                return this.despesasField;
            }
            set
            {
                this.despesasField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("outrasdespesas")]
        public outrasdespesas_type[] outrasdespesas
        {
            get
            {
                return this.outrasdespesasField;
            }
            set
            {
                this.outrasdespesasField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("provisao")]
        public provisao_type[] provisao
        {
            get
            {
                return this.provisaoField;
            }
            set
            {
                this.provisaoField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("corretagem")]
        public corretagem_type[] corretagem
        {
            get
            {
                return this.corretagemField;
            }
            set
            {
                this.corretagemField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("imoveis")]
        public imovel_type[] imoveis
        {
            get
            {
                return this.imoveisField;
            }
            set
            {
                this.imoveisField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("opcoesmoedasotc")]
        public opcoesmoedasotcl_type[] opcoesmoedasotc
        {
            get
            {
                return this.opcoesmoedasotcField;
            }
            set
            {
                this.opcoesmoedasotcField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("forwardsmoedas")]
        public forwardsmoedas_type[] forwardsmoedas
        {
            get
            {
                return this.forwardsmoedasField;
            }
            set
            {
                this.forwardsmoedasField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("participacoes")]
        public participacoes_type[] participacoes
        {
            get
            {
                return this.participacoesField;
            }
            set
            {
                this.participacoesField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("fidc")]
        public fidc_type[] fidc
        {
            get
            {
                return this.fidcField;
            }
            set
            {
                this.fidcField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class header_fundo_type
    {

        private string isinField;

        private string cnpjField;

        private string nomeField;

        private string dtposicaoField;

        private string nomeadmField;

        private string cnpjadmField;

        private string nomegestorField;

        private string cnpjgestorField;

        private string nomecustodianteField;

        private string cnpjcustodianteField;

        private decimal valorcotaField;

        private decimal quantidadeField;

        private double patliqField;

        private decimal valorativosField;

        private decimal valorreceberField;

        private decimal valorpagarField;

        private decimal vlcotasemitirField;

        private double vlcotasresgatarField;

        private string codanbidField;

        private int tipofundoField;

        private nivelrsc_type nivelrscField;

        private bool nivelrscFieldSpecified;

        /// <remarks/>
        public string isin
        {
            get
            {
                return this.isinField;
            }
            set
            {
                this.isinField = value;
            }
        }

        /// <remarks/>
        public string cnpj
        {
            get
            {
                return this.cnpjField;
            }
            set
            {
                this.cnpjField = value;
            }
        }

        /// <remarks/>
        public string nome
        {
            get
            {
                return this.nomeField;
            }
            set
            {
                this.nomeField = value;
            }
        }

        /// <remarks/>
        public string dtposicao
        {
            get
            {
                return this.dtposicaoField;
            }
            set
            {
                this.dtposicaoField = value;
            }
        }

        /// <remarks/>
        public string nomeadm
        {
            get
            {
                return this.nomeadmField;
            }
            set
            {
                this.nomeadmField = value;
            }
        }

        /// <remarks/>
        public string cnpjadm
        {
            get
            {
                return this.cnpjadmField;
            }
            set
            {
                this.cnpjadmField = value;
            }
        }

        /// <remarks/>
        public string nomegestor
        {
            get
            {
                return this.nomegestorField;
            }
            set
            {
                this.nomegestorField = value;
            }
        }

        /// <remarks/>
        public string cnpjgestor
        {
            get
            {
                return this.cnpjgestorField;
            }
            set
            {
                this.cnpjgestorField = value;
            }
        }

        /// <remarks/>
        public string nomecustodiante
        {
            get
            {
                return this.nomecustodianteField;
            }
            set
            {
                this.nomecustodianteField = value;
            }
        }

        /// <remarks/>
        public string cnpjcustodiante
        {
            get
            {
                return this.cnpjcustodianteField;
            }
            set
            {
                this.cnpjcustodianteField = value;
            }
        }

        /// <remarks/>
        public decimal valorcota
        {
            get
            {
                return this.valorcotaField;
            }
            set
            {
                this.valorcotaField = value;
            }
        }

        /// <remarks/>
        public decimal quantidade
        {
            get
            {
                return this.quantidadeField;
            }
            set
            {
                this.quantidadeField = value;
            }
        }

        /// <remarks/>
        public double patliq
        {
            get
            {
                return this.patliqField;
            }
            set
            {
                this.patliqField = value;
            }
        }

        /// <remarks/>
        public decimal valorativos
        {
            get
            {
                return this.valorativosField;
            }
            set
            {
                this.valorativosField = value;
            }
        }

        /// <remarks/>
        public decimal valorreceber
        {
            get
            {
                return this.valorreceberField;
            }
            set
            {
                this.valorreceberField = value;
            }
        }

        /// <remarks/>
        public decimal valorpagar
        {
            get
            {
                return this.valorpagarField;
            }
            set
            {
                this.valorpagarField = value;
            }
        }

        /// <remarks/>
        public decimal vlcotasemitir
        {
            get
            {
                return this.vlcotasemitirField;
            }
            set
            {
                this.vlcotasemitirField = value;
            }
        }

        /// <remarks/>
        public double vlcotasresgatar
        {
            get
            {
                return this.vlcotasresgatarField;
            }
            set
            {
                this.vlcotasresgatarField = value;
            }
        }

        /// <remarks/>
        public string codanbid
        {
            get
            {
                return this.codanbidField;
            }
            set
            {
                this.codanbidField = value;
            }
        }

        /// <remarks/>
        public int tipofundo
        {
            get
            {
                return this.tipofundoField;
            }
            set
            {
                this.tipofundoField = value;
            }
        }

        /// <remarks/>
        public nivelrsc_type nivelrsc
        {
            get
            {
                return this.nivelrscField;
            }
            set
            {
                this.nivelrscField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool nivelrscSpecified
        {
            get
            {
                return this.nivelrscFieldSpecified;
            }
            set
            {
                this.nivelrscFieldSpecified = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    public enum nivelrsc_type
    {

        /// <remarks/>
        BB,

        /// <remarks/>
        MM,

        /// <remarks/>
        MA,

        /// <remarks/>
        AA,

        /// <remarks/>
        [System.Xml.Serialization.XmlEnumAttribute("")]
        Item,
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class header_carteira_type
    {

        private string cnpjcpfField;

        private string codcartField;

        private string dtposicaoField;

        private string nomeField;

        private tpcli_type tpcliField;

        private string codcntcorField;

        private string nomegestorField;

        private string cnpjgestorField;

        private string nomecustodianteField;

        private string cnpjcustodianteField;

        private decimal patliqField;

        private decimal tributosField;

        private decimal valorativosField;

        private decimal valorreceberField;

        private decimal valorpagarField;

        /// <remarks/>
        public string cnpjcpf
        {
            get
            {
                return this.cnpjcpfField;
            }
            set
            {
                this.cnpjcpfField = value;
            }
        }

        /// <remarks/>
        public string codcart
        {
            get
            {
                return this.codcartField;
            }
            set
            {
                this.codcartField = value;
            }
        }

        /// <remarks/>
        public string dtposicao
        {
            get
            {
                return this.dtposicaoField;
            }
            set
            {
                this.dtposicaoField = value;
            }
        }

        /// <remarks/>
        public string nome
        {
            get
            {
                return this.nomeField;
            }
            set
            {
                this.nomeField = value;
            }
        }

        /// <remarks/>
        public tpcli_type tpcli
        {
            get
            {
                return this.tpcliField;
            }
            set
            {
                this.tpcliField = value;
            }
        }

        /// <remarks/>
        public string codcntcor
        {
            get
            {
                return this.codcntcorField;
            }
            set
            {
                this.codcntcorField = value;
            }
        }

        /// <remarks/>
        public string nomegestor
        {
            get
            {
                return this.nomegestorField;
            }
            set
            {
                this.nomegestorField = value;
            }
        }

        /// <remarks/>
        public string cnpjgestor
        {
            get
            {
                return this.cnpjgestorField;
            }
            set
            {
                this.cnpjgestorField = value;
            }
        }

        /// <remarks/>
        public string nomecustodiante
        {
            get
            {
                return this.nomecustodianteField;
            }
            set
            {
                this.nomecustodianteField = value;
            }
        }

        /// <remarks/>
        public string cnpjcustodiante
        {
            get
            {
                return this.cnpjcustodianteField;
            }
            set
            {
                this.cnpjcustodianteField = value;
            }
        }

        /// <remarks/>
        public decimal patliq
        {
            get
            {
                return this.patliqField;
            }
            set
            {
                this.patliqField = value;
            }
        }

        /// <remarks/>
        public decimal tributos
        {
            get
            {
                return this.tributosField;
            }
            set
            {
                this.tributosField = value;
            }
        }

        /// <remarks/>
        public decimal valorativos
        {
            get
            {
                return this.valorativosField;
            }
            set
            {
                this.valorativosField = value;
            }
        }

        /// <remarks/>
        public decimal valorreceber
        {
            get
            {
                return this.valorreceberField;
            }
            set
            {
                this.valorreceberField = value;
            }
        }

        /// <remarks/>
        public decimal valorpagar
        {
            get
            {
                return this.valorpagarField;
            }
            set
            {
                this.valorpagarField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    public enum tpcli_type
    {

        /// <remarks/>
        F,

        /// <remarks/>
        J,
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class Carteira_type
    {

        private header_carteira_type headerField;

        private partplanprev_type[] partplanprevField;

        private titpublico_type[] titpublicoField;

        private titprivado_type[] titprivadoField;

        private debenture_type[] debentureField;

        private acoes_type[] acoesField;

        private opcoesacoes_type[] opcoesacoesField;

        private opcoesderiv_type[] opcoesderivField;

        private opcoesflx_type[] opcoesflxField;

        private termorv_type[] termorvField;

        private termorf_type[] termorfField;

        private futuros_type[] futurosField;

        private swap_type[] swapField;

        private caixa_type[] caixaField;

        private cotas_type[] cotasField;

        private despesas_type despesasField;

        private outrasdespesas_type[] outrasdespesasField;

        private provisao_type[] provisaoField;

        private corretagem_type[] corretagemField;

        private imovel_type[] imoveisField;

        private opcoesmoedasotcl_type[] opcoesmoedasotcField;

        private forwardsmoedas_type[] forwardsmoedasField;

        private participacoes_type[] participacoesField;

        private fidc_type[] fidcField;

        /// <remarks/>
        public header_carteira_type header
        {
            get
            {
                return this.headerField;
            }
            set
            {
                this.headerField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("partplanprev")]
        public partplanprev_type[] partplanprev
        {
            get
            {
                return this.partplanprevField;
            }
            set
            {
                this.partplanprevField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("titpublico")]
        public titpublico_type[] titpublico
        {
            get
            {
                return this.titpublicoField;
            }
            set
            {
                this.titpublicoField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("titprivado")]
        public titprivado_type[] titprivado
        {
            get
            {
                return this.titprivadoField;
            }
            set
            {
                this.titprivadoField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("debenture")]
        public debenture_type[] debenture
        {
            get
            {
                return this.debentureField;
            }
            set
            {
                this.debentureField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("acoes")]
        public acoes_type[] acoes
        {
            get
            {
                return this.acoesField;
            }
            set
            {
                this.acoesField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("opcoesacoes")]
        public opcoesacoes_type[] opcoesacoes
        {
            get
            {
                return this.opcoesacoesField;
            }
            set
            {
                this.opcoesacoesField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("opcoesderiv")]
        public opcoesderiv_type[] opcoesderiv
        {
            get
            {
                return this.opcoesderivField;
            }
            set
            {
                this.opcoesderivField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("opcoesflx")]
        public opcoesflx_type[] opcoesflx
        {
            get
            {
                return this.opcoesflxField;
            }
            set
            {
                this.opcoesflxField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("termorv")]
        public termorv_type[] termorv
        {
            get
            {
                return this.termorvField;
            }
            set
            {
                this.termorvField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("termorf")]
        public termorf_type[] termorf
        {
            get
            {
                return this.termorfField;
            }
            set
            {
                this.termorfField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("futuros")]
        public futuros_type[] futuros
        {
            get
            {
                return this.futurosField;
            }
            set
            {
                this.futurosField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("swap")]
        public swap_type[] swap
        {
            get
            {
                return this.swapField;
            }
            set
            {
                this.swapField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("caixa")]
        public caixa_type[] caixa
        {
            get
            {
                return this.caixaField;
            }
            set
            {
                this.caixaField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("cotas")]
        public cotas_type[] cotas
        {
            get
            {
                return this.cotasField;
            }
            set
            {
                this.cotasField = value;
            }
        }

        /// <remarks/>
        public despesas_type despesas
        {
            get
            {
                return this.despesasField;
            }
            set
            {
                this.despesasField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("outrasdespesas")]
        public outrasdespesas_type[] outrasdespesas
        {
            get
            {
                return this.outrasdespesasField;
            }
            set
            {
                this.outrasdespesasField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("provisao")]
        public provisao_type[] provisao
        {
            get
            {
                return this.provisaoField;
            }
            set
            {
                this.provisaoField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("corretagem")]
        public corretagem_type[] corretagem
        {
            get
            {
                return this.corretagemField;
            }
            set
            {
                this.corretagemField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("imoveis")]
        public imovel_type[] imoveis
        {
            get
            {
                return this.imoveisField;
            }
            set
            {
                this.imoveisField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("opcoesmoedasotc")]
        public opcoesmoedasotcl_type[] opcoesmoedasotc
        {
            get
            {
                return this.opcoesmoedasotcField;
            }
            set
            {
                this.opcoesmoedasotcField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("forwardsmoedas")]
        public forwardsmoedas_type[] forwardsmoedas
        {
            get
            {
                return this.forwardsmoedasField;
            }
            set
            {
                this.forwardsmoedasField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("participacoes")]
        public participacoes_type[] participacoes
        {
            get
            {
                return this.participacoesField;
            }
            set
            {
                this.participacoesField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("fidc")]
        public fidc_type[] fidc
        {
            get
            {
                return this.fidcField;
            }
            set
            {
                this.fidcField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class partplanprev_type
    {

        private long cnpbField;

        private decimal percpartField;

        /// <remarks/>
        public long cnpb
        {
            get
            {
                return this.cnpbField;
            }
            set
            {
                this.cnpbField = value;
            }
        }

        /// <remarks/>
        public decimal percpart
        {
            get
            {
                return this.percpartField;
            }
            set
            {
                this.percpartField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class titpublico_type
    {

        private string isinField;

        private string codativoField;

        private string cusipField;

        private string dtemissaoField;

        private string dtoperacaoField;

        private string dtvencimentoField;

        private decimal qtdisponivelField;

        private decimal qtgarantiaField;

        private int depgarField;

        private bool depgarFieldSpecified;

        private decimal pucompraField;

        private decimal puvencimentoField;

        private bool puvencimentoFieldSpecified;

        private decimal puposicaoField;

        private decimal puemissaoField;

        private bool puemissaoFieldSpecified;

        private decimal principalField;

        private decimal tributosField;

        private decimal valorfindispField;

        private decimal valorfinemgarField;

        private double coupomField;

        private string indexadorField;

        private decimal percindexField;

        private caracteristica_type caracteristicaField;

        private decimal percprovcredField;

        private bool percprovcredFieldSpecified;

        private compromisso_type compromissoField;

        private classeCDTV_type classeoperacaoField;

        private string idinternoativoField;

        private nivelrsc_type nivelrscField;

        private bool nivelrscFieldSpecified;

        private aluguel_type aluguelField;

        /// <remarks/>
        public string isin
        {
            get
            {
                return this.isinField;
            }
            set
            {
                this.isinField = value;
            }
        }

        /// <remarks/>
        public string codativo
        {
            get
            {
                return this.codativoField;
            }
            set
            {
                this.codativoField = value;
            }
        }

        /// <remarks/>
        public string cusip
        {
            get
            {
                return this.cusipField;
            }
            set
            {
                this.cusipField = value;
            }
        }

        /// <remarks/>
        public string dtemissao
        {
            get
            {
                return this.dtemissaoField;
            }
            set
            {
                this.dtemissaoField = value;
            }
        }

        /// <remarks/>
        public string dtoperacao
        {
            get
            {
                return this.dtoperacaoField;
            }
            set
            {
                this.dtoperacaoField = value;
            }
        }

        /// <remarks/>
        public string dtvencimento
        {
            get
            {
                return this.dtvencimentoField;
            }
            set
            {
                this.dtvencimentoField = value;
            }
        }

        /// <remarks/>
        public decimal qtdisponivel
        {
            get
            {
                return this.qtdisponivelField;
            }
            set
            {
                this.qtdisponivelField = value;
            }
        }

        /// <remarks/>
        public decimal qtgarantia
        {
            get
            {
                return this.qtgarantiaField;
            }
            set
            {
                this.qtgarantiaField = value;
            }
        }

        /// <remarks/>
        public int depgar
        {
            get
            {
                return this.depgarField;
            }
            set
            {
                this.depgarField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool depgarSpecified
        {
            get
            {
                return this.depgarFieldSpecified;
            }
            set
            {
                this.depgarFieldSpecified = value;
            }
        }

        /// <remarks/>
        public decimal pucompra
        {
            get
            {
                return this.pucompraField;
            }
            set
            {
                this.pucompraField = value;
            }
        }

        /// <remarks/>
        public decimal puvencimento
        {
            get
            {
                return this.puvencimentoField;
            }
            set
            {
                this.puvencimentoField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool puvencimentoSpecified
        {
            get
            {
                return this.puvencimentoFieldSpecified;
            }
            set
            {
                this.puvencimentoFieldSpecified = value;
            }
        }

        /// <remarks/>
        public decimal puposicao
        {
            get
            {
                return this.puposicaoField;
            }
            set
            {
                this.puposicaoField = value;
            }
        }

        /// <remarks/>
        public decimal puemissao
        {
            get
            {
                return this.puemissaoField;
            }
            set
            {
                this.puemissaoField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool puemissaoSpecified
        {
            get
            {
                return this.puemissaoFieldSpecified;
            }
            set
            {
                this.puemissaoFieldSpecified = value;
            }
        }

        /// <remarks/>
        public decimal principal
        {
            get
            {
                return this.principalField;
            }
            set
            {
                this.principalField = value;
            }
        }

        /// <remarks/>
        public decimal tributos
        {
            get
            {
                return this.tributosField;
            }
            set
            {
                this.tributosField = value;
            }
        }

        /// <remarks/>
        public decimal valorfindisp
        {
            get
            {
                return this.valorfindispField;
            }
            set
            {
                this.valorfindispField = value;
            }
        }

        /// <remarks/>
        public decimal valorfinemgar
        {
            get
            {
                return this.valorfinemgarField;
            }
            set
            {
                this.valorfinemgarField = value;
            }
        }

        /// <remarks/>
        public double coupom
        {
            get
            {
                return this.coupomField;
            }
            set
            {
                this.coupomField = value;
            }
        }

        /// <remarks/>
        public string indexador
        {
            get
            {
                return this.indexadorField;
            }
            set
            {
                this.indexadorField = value;
            }
        }

        /// <remarks/>
        public decimal percindex
        {
            get
            {
                return this.percindexField;
            }
            set
            {
                this.percindexField = value;
            }
        }

        /// <remarks/>
        public caracteristica_type caracteristica
        {
            get
            {
                return this.caracteristicaField;
            }
            set
            {
                this.caracteristicaField = value;
            }
        }

        /// <remarks/>
        public decimal percprovcred
        {
            get
            {
                return this.percprovcredField;
            }
            set
            {
                this.percprovcredField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool percprovcredSpecified
        {
            get
            {
                return this.percprovcredFieldSpecified;
            }
            set
            {
                this.percprovcredFieldSpecified = value;
            }
        }

        /// <remarks/>
        public compromisso_type compromisso
        {
            get
            {
                return this.compromissoField;
            }
            set
            {
                this.compromissoField = value;
            }
        }

        /// <remarks/>
        public classeCDTV_type classeoperacao
        {
            get
            {
                return this.classeoperacaoField;
            }
            set
            {
                this.classeoperacaoField = value;
            }
        }

        /// <remarks/>
        public string idinternoativo
        {
            get
            {
                return this.idinternoativoField;
            }
            set
            {
                this.idinternoativoField = value;
            }
        }

        /// <remarks/>
        public nivelrsc_type nivelrsc
        {
            get
            {
                return this.nivelrscField;
            }
            set
            {
                this.nivelrscField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool nivelrscSpecified
        {
            get
            {
                return this.nivelrscFieldSpecified;
            }
            set
            {
                this.nivelrscFieldSpecified = value;
            }
        }

        /// <remarks/>
        public aluguel_type aluguel
        {
            get
            {
                return this.aluguelField;
            }
            set
            {
                this.aluguelField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    public enum caracteristica_type
    {

        /// <remarks/>
        N,

        /// <remarks/>
        V,
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class compromisso_type
    {

        private string dtretornoField;

        private decimal puretornoField;

        private string indexadorcompField;

        private decimal perindexcompField;

        private decimal txoperacaoField;

        private classeCV_type classecompField;

        /// <remarks/>
        public string dtretorno
        {
            get
            {
                return this.dtretornoField;
            }
            set
            {
                this.dtretornoField = value;
            }
        }

        /// <remarks/>
        public decimal puretorno
        {
            get
            {
                return this.puretornoField;
            }
            set
            {
                this.puretornoField = value;
            }
        }

        /// <remarks/>
        public string indexadorcomp
        {
            get
            {
                return this.indexadorcompField;
            }
            set
            {
                this.indexadorcompField = value;
            }
        }

        /// <remarks/>
        public decimal perindexcomp
        {
            get
            {
                return this.perindexcompField;
            }
            set
            {
                this.perindexcompField = value;
            }
        }

        /// <remarks/>
        public decimal txoperacao
        {
            get
            {
                return this.txoperacaoField;
            }
            set
            {
                this.txoperacaoField = value;
            }
        }

        /// <remarks/>
        public classeCV_type classecomp
        {
            get
            {
                return this.classecompField;
            }
            set
            {
                this.classecompField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    public enum classeCV_type
    {

        /// <remarks/>
        C,

        /// <remarks/>
        V,
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    public enum classeCDTV_type
    {

        /// <remarks/>
        C,

        /// <remarks/>
        D,

        /// <remarks/>
        T,

        /// <remarks/>
        V,
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class aluguel_type
    {

        private string dtvencalugField;

        private decimal txalugField;

        private bool txalugFieldSpecified;

        private string indexadoralugField;

        private decimal percalugField;

        private bool percalugFieldSpecified;

        /// <remarks/>
        public string dtvencalug
        {
            get
            {
                return this.dtvencalugField;
            }
            set
            {
                this.dtvencalugField = value;
            }
        }

        /// <remarks/>
        public decimal txalug
        {
            get
            {
                return this.txalugField;
            }
            set
            {
                this.txalugField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool txalugSpecified
        {
            get
            {
                return this.txalugFieldSpecified;
            }
            set
            {
                this.txalugFieldSpecified = value;
            }
        }

        /// <remarks/>
        public string indexadoralug
        {
            get
            {
                return this.indexadoralugField;
            }
            set
            {
                this.indexadoralugField = value;
            }
        }

        /// <remarks/>
        public decimal percalug
        {
            get
            {
                return this.percalugField;
            }
            set
            {
                this.percalugField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool percalugSpecified
        {
            get
            {
                return this.percalugFieldSpecified;
            }
            set
            {
                this.percalugFieldSpecified = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class titprivado_type
    {

        private string isinField;

        private string codativoField;

        private string cusipField;

        private string dtemissaoField;

        private string dtoperacaoField;

        private string dtvencimentoField;

        private string cnpjemissorField;

        private decimal qtdisponivelField;

        private decimal qtgarantiaField;

        private int depgarField;

        private bool depgarFieldSpecified;

        private decimal pucompraField;

        private decimal puvencimentoField;

        private decimal puposicaoField;

        private decimal puemissaoField;

        private decimal principalField;

        private decimal tributosField;

        private decimal valorfindispField;

        private decimal valorfinemgarField;

        private double coupomField;

        private string indexadorField;

        private decimal percindexField;

        private caracteristica_type caracteristicaField;

        private decimal percprovcredField;

        private bool percprovcredFieldSpecified;

        private compromisso_type compromissoField;

        private classeCDTV_type classeoperacaoField;

        private string idinternoativoField;

        private nivelrsc_type nivelrscField;

        private bool nivelrscFieldSpecified;

        private aluguel_type aluguelField;

        /// <remarks/>
        public string isin
        {
            get
            {
                return this.isinField;
            }
            set
            {
                this.isinField = value;
            }
        }

        /// <remarks/>
        public string codativo
        {
            get
            {
                return this.codativoField;
            }
            set
            {
                this.codativoField = value;
            }
        }

        /// <remarks/>
        public string cusip
        {
            get
            {
                return this.cusipField;
            }
            set
            {
                this.cusipField = value;
            }
        }

        /// <remarks/>
        public string dtemissao
        {
            get
            {
                return this.dtemissaoField;
            }
            set
            {
                this.dtemissaoField = value;
            }
        }

        /// <remarks/>
        public string dtoperacao
        {
            get
            {
                return this.dtoperacaoField;
            }
            set
            {
                this.dtoperacaoField = value;
            }
        }

        /// <remarks/>
        public string dtvencimento
        {
            get
            {
                return this.dtvencimentoField;
            }
            set
            {
                this.dtvencimentoField = value;
            }
        }

        /// <remarks/>
        public string cnpjemissor
        {
            get
            {
                return this.cnpjemissorField;
            }
            set
            {
                this.cnpjemissorField = value;
            }
        }

        /// <remarks/>
        public decimal qtdisponivel
        {
            get
            {
                return this.qtdisponivelField;
            }
            set
            {
                this.qtdisponivelField = value;
            }
        }

        /// <remarks/>
        public decimal qtgarantia
        {
            get
            {
                return this.qtgarantiaField;
            }
            set
            {
                this.qtgarantiaField = value;
            }
        }

        /// <remarks/>
        public int depgar
        {
            get
            {
                return this.depgarField;
            }
            set
            {
                this.depgarField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool depgarSpecified
        {
            get
            {
                return this.depgarFieldSpecified;
            }
            set
            {
                this.depgarFieldSpecified = value;
            }
        }

        /// <remarks/>
        public decimal pucompra
        {
            get
            {
                return this.pucompraField;
            }
            set
            {
                this.pucompraField = value;
            }
        }

        /// <remarks/>
        public decimal puvencimento
        {
            get
            {
                return this.puvencimentoField;
            }
            set
            {
                this.puvencimentoField = value;
            }
        }

        /// <remarks/>
        public decimal puposicao
        {
            get
            {
                return this.puposicaoField;
            }
            set
            {
                this.puposicaoField = value;
            }
        }

        /// <remarks/>
        public decimal puemissao
        {
            get
            {
                return this.puemissaoField;
            }
            set
            {
                this.puemissaoField = value;
            }
        }

        /// <remarks/>
        public decimal principal
        {
            get
            {
                return this.principalField;
            }
            set
            {
                this.principalField = value;
            }
        }

        /// <remarks/>
        public decimal tributos
        {
            get
            {
                return this.tributosField;
            }
            set
            {
                this.tributosField = value;
            }
        }

        /// <remarks/>
        public decimal valorfindisp
        {
            get
            {
                return this.valorfindispField;
            }
            set
            {
                this.valorfindispField = value;
            }
        }

        /// <remarks/>
        public decimal valorfinemgar
        {
            get
            {
                return this.valorfinemgarField;
            }
            set
            {
                this.valorfinemgarField = value;
            }
        }

        /// <remarks/>
        public double coupom
        {
            get
            {
                return this.coupomField;
            }
            set
            {
                this.coupomField = value;
            }
        }

        /// <remarks/>
        public string indexador
        {
            get
            {
                return this.indexadorField;
            }
            set
            {
                this.indexadorField = value;
            }
        }

        /// <remarks/>
        public decimal percindex
        {
            get
            {
                return this.percindexField;
            }
            set
            {
                this.percindexField = value;
            }
        }

        /// <remarks/>
        public caracteristica_type caracteristica
        {
            get
            {
                return this.caracteristicaField;
            }
            set
            {
                this.caracteristicaField = value;
            }
        }

        /// <remarks/>
        public decimal percprovcred
        {
            get
            {
                return this.percprovcredField;
            }
            set
            {
                this.percprovcredField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool percprovcredSpecified
        {
            get
            {
                return this.percprovcredFieldSpecified;
            }
            set
            {
                this.percprovcredFieldSpecified = value;
            }
        }

        /// <remarks/>
        public compromisso_type compromisso
        {
            get
            {
                return this.compromissoField;
            }
            set
            {
                this.compromissoField = value;
            }
        }

        /// <remarks/>
        public classeCDTV_type classeoperacao
        {
            get
            {
                return this.classeoperacaoField;
            }
            set
            {
                this.classeoperacaoField = value;
            }
        }

        /// <remarks/>
        public string idinternoativo
        {
            get
            {
                return this.idinternoativoField;
            }
            set
            {
                this.idinternoativoField = value;
            }
        }

        /// <remarks/>
        public nivelrsc_type nivelrsc
        {
            get
            {
                return this.nivelrscField;
            }
            set
            {
                this.nivelrscField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool nivelrscSpecified
        {
            get
            {
                return this.nivelrscFieldSpecified;
            }
            set
            {
                this.nivelrscFieldSpecified = value;
            }
        }

        /// <remarks/>
        public aluguel_type aluguel
        {
            get
            {
                return this.aluguelField;
            }
            set
            {
                this.aluguelField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class debenture_type
    {

        private string isinField;

        private string coddebField;

        private sn_type debconvField;

        private sn_type debpartlucroField;

        private sn_type sPEField;

        private string cusipField;

        private string dtemissaoField;

        private string dtoperacaoField;

        private string dtvencimentoField;

        private string cnpjemissorField;

        private decimal qtdisponivelField;

        private decimal qtgarantiaField;

        private int depgarField;

        private bool depgarFieldSpecified;

        private decimal pucompraField;

        private decimal puvencimentoField;

        private decimal puposicaoField;

        private decimal puemissaoField;

        private decimal principalField;

        private decimal tributosField;

        private decimal valorfindispField;

        private decimal valorfinemgarField;

        private double coupomField;

        private string indexadorField;

        private decimal percindexField;

        private caracteristica_type caracteristicaField;

        private decimal percprovcredField;

        private bool percprovcredFieldSpecified;

        private compromisso_type compromissoField;

        private classeCDTV_type classeoperacaoField;

        private string idinternoativoField;

        private nivelrsc_type nivelrscField;

        private bool nivelrscFieldSpecified;

        private aluguel_type aluguelField;

        /// <remarks/>
        public string isin
        {
            get
            {
                return this.isinField;
            }
            set
            {
                this.isinField = value;
            }
        }

        /// <remarks/>
        public string coddeb
        {
            get
            {
                return this.coddebField;
            }
            set
            {
                this.coddebField = value;
            }
        }

        /// <remarks/>
        public sn_type debconv
        {
            get
            {
                return this.debconvField;
            }
            set
            {
                this.debconvField = value;
            }
        }

        /// <remarks/>
        public sn_type debpartlucro
        {
            get
            {
                return this.debpartlucroField;
            }
            set
            {
                this.debpartlucroField = value;
            }
        }

        /// <remarks/>
        public sn_type SPE
        {
            get
            {
                return this.sPEField;
            }
            set
            {
                this.sPEField = value;
            }
        }

        /// <remarks/>
        public string cusip
        {
            get
            {
                return this.cusipField;
            }
            set
            {
                this.cusipField = value;
            }
        }

        /// <remarks/>
        public string dtemissao
        {
            get
            {
                return this.dtemissaoField;
            }
            set
            {
                this.dtemissaoField = value;
            }
        }

        /// <remarks/>
        public string dtoperacao
        {
            get
            {
                return this.dtoperacaoField;
            }
            set
            {
                this.dtoperacaoField = value;
            }
        }

        /// <remarks/>
        public string dtvencimento
        {
            get
            {
                return this.dtvencimentoField;
            }
            set
            {
                this.dtvencimentoField = value;
            }
        }

        /// <remarks/>
        public string cnpjemissor
        {
            get
            {
                return this.cnpjemissorField;
            }
            set
            {
                this.cnpjemissorField = value;
            }
        }

        /// <remarks/>
        public decimal qtdisponivel
        {
            get
            {
                return this.qtdisponivelField;
            }
            set
            {
                this.qtdisponivelField = value;
            }
        }

        /// <remarks/>
        public decimal qtgarantia
        {
            get
            {
                return this.qtgarantiaField;
            }
            set
            {
                this.qtgarantiaField = value;
            }
        }

        /// <remarks/>
        public int depgar
        {
            get
            {
                return this.depgarField;
            }
            set
            {
                this.depgarField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool depgarSpecified
        {
            get
            {
                return this.depgarFieldSpecified;
            }
            set
            {
                this.depgarFieldSpecified = value;
            }
        }

        /// <remarks/>
        public decimal pucompra
        {
            get
            {
                return this.pucompraField;
            }
            set
            {
                this.pucompraField = value;
            }
        }

        /// <remarks/>
        public decimal puvencimento
        {
            get
            {
                return this.puvencimentoField;
            }
            set
            {
                this.puvencimentoField = value;
            }
        }

        /// <remarks/>
        public decimal puposicao
        {
            get
            {
                return this.puposicaoField;
            }
            set
            {
                this.puposicaoField = value;
            }
        }

        /// <remarks/>
        public decimal puemissao
        {
            get
            {
                return this.puemissaoField;
            }
            set
            {
                this.puemissaoField = value;
            }
        }

        /// <remarks/>
        public decimal principal
        {
            get
            {
                return this.principalField;
            }
            set
            {
                this.principalField = value;
            }
        }

        /// <remarks/>
        public decimal tributos
        {
            get
            {
                return this.tributosField;
            }
            set
            {
                this.tributosField = value;
            }
        }

        /// <remarks/>
        public decimal valorfindisp
        {
            get
            {
                return this.valorfindispField;
            }
            set
            {
                this.valorfindispField = value;
            }
        }

        /// <remarks/>
        public decimal valorfinemgar
        {
            get
            {
                return this.valorfinemgarField;
            }
            set
            {
                this.valorfinemgarField = value;
            }
        }

        /// <remarks/>
        public double coupom
        {
            get
            {
                return this.coupomField;
            }
            set
            {
                this.coupomField = value;
            }
        }

        /// <remarks/>
        public string indexador
        {
            get
            {
                return this.indexadorField;
            }
            set
            {
                this.indexadorField = value;
            }
        }

        /// <remarks/>
        public decimal percindex
        {
            get
            {
                return this.percindexField;
            }
            set
            {
                this.percindexField = value;
            }
        }

        /// <remarks/>
        public caracteristica_type caracteristica
        {
            get
            {
                return this.caracteristicaField;
            }
            set
            {
                this.caracteristicaField = value;
            }
        }

        /// <remarks/>
        public decimal percprovcred
        {
            get
            {
                return this.percprovcredField;
            }
            set
            {
                this.percprovcredField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool percprovcredSpecified
        {
            get
            {
                return this.percprovcredFieldSpecified;
            }
            set
            {
                this.percprovcredFieldSpecified = value;
            }
        }

        /// <remarks/>
        public compromisso_type compromisso
        {
            get
            {
                return this.compromissoField;
            }
            set
            {
                this.compromissoField = value;
            }
        }

        /// <remarks/>
        public classeCDTV_type classeoperacao
        {
            get
            {
                return this.classeoperacaoField;
            }
            set
            {
                this.classeoperacaoField = value;
            }
        }

        /// <remarks/>
        public string idinternoativo
        {
            get
            {
                return this.idinternoativoField;
            }
            set
            {
                this.idinternoativoField = value;
            }
        }

        /// <remarks/>
        public nivelrsc_type nivelrsc
        {
            get
            {
                return this.nivelrscField;
            }
            set
            {
                this.nivelrscField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool nivelrscSpecified
        {
            get
            {
                return this.nivelrscFieldSpecified;
            }
            set
            {
                this.nivelrscFieldSpecified = value;
            }
        }

        /// <remarks/>
        public aluguel_type aluguel
        {
            get
            {
                return this.aluguelField;
            }
            set
            {
                this.aluguelField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    public enum sn_type
    {

        /// <remarks/>
        S,

        /// <remarks/>
        N,
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class acoes_type
    {

        private string isinField;

        private string cusipField;

        private string codativoField;

        private double qtdisponivelField;

        private int loteField;

        private double qtgarantiaField;

        private double valorfindispField;

        private double valorfinemgarField;

        private decimal tributosField;

        private decimal puposicaoField;

        private decimal percprovcredField;

        private int tpcontaField;

        private classeCDTV_type classeoperacaoField;

        private string dtvencalugField;

        private decimal txalugField;

        private bool txalugFieldSpecified;

        private string cnpjinterField;

        /// <remarks/>
        public string isin
        {
            get
            {
                return this.isinField;
            }
            set
            {
                this.isinField = value;
            }
        }

        /// <remarks/>
        public string cusip
        {
            get
            {
                return this.cusipField;
            }
            set
            {
                this.cusipField = value;
            }
        }

        /// <remarks/>
        public string codativo
        {
            get
            {
                return this.codativoField;
            }
            set
            {
                this.codativoField = value;
            }
        }

        /// <remarks/>
        public double qtdisponivel
        {
            get
            {
                return this.qtdisponivelField;
            }
            set
            {
                this.qtdisponivelField = value;
            }
        }

        /// <remarks/>
        public int lote
        {
            get
            {
                return this.loteField;
            }
            set
            {
                this.loteField = value;
            }
        }

        /// <remarks/>
        public double qtgarantia
        {
            get
            {
                return this.qtgarantiaField;
            }
            set
            {
                this.qtgarantiaField = value;
            }
        }

        /// <remarks/>
        public double valorfindisp
        {
            get
            {
                return this.valorfindispField;
            }
            set
            {
                this.valorfindispField = value;
            }
        }

        /// <remarks/>
        public double valorfinemgar
        {
            get
            {
                return this.valorfinemgarField;
            }
            set
            {
                this.valorfinemgarField = value;
            }
        }

        /// <remarks/>
        public decimal tributos
        {
            get
            {
                return this.tributosField;
            }
            set
            {
                this.tributosField = value;
            }
        }

        /// <remarks/>
        public decimal puposicao
        {
            get
            {
                return this.puposicaoField;
            }
            set
            {
                this.puposicaoField = value;
            }
        }

        /// <remarks/>
        public decimal percprovcred
        {
            get
            {
                return this.percprovcredField;
            }
            set
            {
                this.percprovcredField = value;
            }
        }

        /// <remarks/>
        public int tpconta
        {
            get
            {
                return this.tpcontaField;
            }
            set
            {
                this.tpcontaField = value;
            }
        }

        /// <remarks/>
        public classeCDTV_type classeoperacao
        {
            get
            {
                return this.classeoperacaoField;
            }
            set
            {
                this.classeoperacaoField = value;
            }
        }

        /// <remarks/>
        public string dtvencalug
        {
            get
            {
                return this.dtvencalugField;
            }
            set
            {
                this.dtvencalugField = value;
            }
        }

        /// <remarks/>
        public decimal txalug
        {
            get
            {
                return this.txalugField;
            }
            set
            {
                this.txalugField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool txalugSpecified
        {
            get
            {
                return this.txalugFieldSpecified;
            }
            set
            {
                this.txalugFieldSpecified = value;
            }
        }

        /// <remarks/>
        public string cnpjinter
        {
            get
            {
                return this.cnpjinterField;
            }
            set
            {
                this.cnpjinterField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class opcoesacoes_type
    {

        private string isinField;

        private string cusipField;

        private string codativoField;

        private string ativobaseField;

        private decimal qtdisponivelField;

        private decimal valorfinanceiroField;

        private decimal precoexercicioField;

        private string dtvencimentoField;

        private classeCV_type classeoperacaoField;

        private decimal tributosField;

        private decimal puposicaoField;

        private decimal premioField;

        private decimal percprovcredField;

        private bool percprovcredFieldSpecified;

        private int tpcontaField;

        private sn_type hedgeField;

        private int tphedgeField;

        /// <remarks/>
        public string isin
        {
            get
            {
                return this.isinField;
            }
            set
            {
                this.isinField = value;
            }
        }

        /// <remarks/>
        public string cusip
        {
            get
            {
                return this.cusipField;
            }
            set
            {
                this.cusipField = value;
            }
        }

        /// <remarks/>
        public string codativo
        {
            get
            {
                return this.codativoField;
            }
            set
            {
                this.codativoField = value;
            }
        }

        /// <remarks/>
        public string ativobase
        {
            get
            {
                return this.ativobaseField;
            }
            set
            {
                this.ativobaseField = value;
            }
        }

        /// <remarks/>
        public decimal qtdisponivel
        {
            get
            {
                return this.qtdisponivelField;
            }
            set
            {
                this.qtdisponivelField = value;
            }
        }

        /// <remarks/>
        public decimal valorfinanceiro
        {
            get
            {
                return this.valorfinanceiroField;
            }
            set
            {
                this.valorfinanceiroField = value;
            }
        }

        /// <remarks/>
        public decimal precoexercicio
        {
            get
            {
                return this.precoexercicioField;
            }
            set
            {
                this.precoexercicioField = value;
            }
        }

        /// <remarks/>
        public string dtvencimento
        {
            get
            {
                return this.dtvencimentoField;
            }
            set
            {
                this.dtvencimentoField = value;
            }
        }

        /// <remarks/>
        public classeCV_type classeoperacao
        {
            get
            {
                return this.classeoperacaoField;
            }
            set
            {
                this.classeoperacaoField = value;
            }
        }

        /// <remarks/>
        public decimal tributos
        {
            get
            {
                return this.tributosField;
            }
            set
            {
                this.tributosField = value;
            }
        }

        /// <remarks/>
        public decimal puposicao
        {
            get
            {
                return this.puposicaoField;
            }
            set
            {
                this.puposicaoField = value;
            }
        }

        /// <remarks/>
        public decimal premio
        {
            get
            {
                return this.premioField;
            }
            set
            {
                this.premioField = value;
            }
        }

        /// <remarks/>
        public decimal percprovcred
        {
            get
            {
                return this.percprovcredField;
            }
            set
            {
                this.percprovcredField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool percprovcredSpecified
        {
            get
            {
                return this.percprovcredFieldSpecified;
            }
            set
            {
                this.percprovcredFieldSpecified = value;
            }
        }

        /// <remarks/>
        public int tpconta
        {
            get
            {
                return this.tpcontaField;
            }
            set
            {
                this.tpcontaField = value;
            }
        }

        /// <remarks/>
        public sn_type hedge
        {
            get
            {
                return this.hedgeField;
            }
            set
            {
                this.hedgeField = value;
            }
        }

        /// <remarks/>
        public int tphedge
        {
            get
            {
                return this.tphedgeField;
            }
            set
            {
                this.tphedgeField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class opcoesderiv_type
    {

        private string isinField;

        private int mercadoField;

        private string ativoField;

        private string serieField;

        private callput_type callputField;

        private decimal quantidadeField;

        private decimal valorfinanceiroField;

        private decimal tributosField;

        private decimal precoexercicioField;

        private decimal premioField;

        private string dtvencimentoField;

        private classeCV_type classeoperacaoField;

        private decimal puposicaoField;

        private sn_type hedgeField;

        private int tphedgeField;

        /// <remarks/>
        public string isin
        {
            get
            {
                return this.isinField;
            }
            set
            {
                this.isinField = value;
            }
        }

        /// <remarks/>
        public int mercado
        {
            get
            {
                return this.mercadoField;
            }
            set
            {
                this.mercadoField = value;
            }
        }

        /// <remarks/>
        public string ativo
        {
            get
            {
                return this.ativoField;
            }
            set
            {
                this.ativoField = value;
            }
        }

        /// <remarks/>
        public string serie
        {
            get
            {
                return this.serieField;
            }
            set
            {
                this.serieField = value;
            }
        }

        /// <remarks/>
        public callput_type callput
        {
            get
            {
                return this.callputField;
            }
            set
            {
                this.callputField = value;
            }
        }

        /// <remarks/>
        public decimal quantidade
        {
            get
            {
                return this.quantidadeField;
            }
            set
            {
                this.quantidadeField = value;
            }
        }

        /// <remarks/>
        public decimal valorfinanceiro
        {
            get
            {
                return this.valorfinanceiroField;
            }
            set
            {
                this.valorfinanceiroField = value;
            }
        }

        /// <remarks/>
        public decimal tributos
        {
            get
            {
                return this.tributosField;
            }
            set
            {
                this.tributosField = value;
            }
        }

        /// <remarks/>
        public decimal precoexercicio
        {
            get
            {
                return this.precoexercicioField;
            }
            set
            {
                this.precoexercicioField = value;
            }
        }

        /// <remarks/>
        public decimal premio
        {
            get
            {
                return this.premioField;
            }
            set
            {
                this.premioField = value;
            }
        }

        /// <remarks/>
        public string dtvencimento
        {
            get
            {
                return this.dtvencimentoField;
            }
            set
            {
                this.dtvencimentoField = value;
            }
        }

        /// <remarks/>
        public classeCV_type classeoperacao
        {
            get
            {
                return this.classeoperacaoField;
            }
            set
            {
                this.classeoperacaoField = value;
            }
        }

        /// <remarks/>
        public decimal puposicao
        {
            get
            {
                return this.puposicaoField;
            }
            set
            {
                this.puposicaoField = value;
            }
        }

        /// <remarks/>
        public sn_type hedge
        {
            get
            {
                return this.hedgeField;
            }
            set
            {
                this.hedgeField = value;
            }
        }

        /// <remarks/>
        public int tphedge
        {
            get
            {
                return this.tphedgeField;
            }
            set
            {
                this.tphedgeField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    public enum callput_type
    {

        /// <remarks/>
        C,

        /// <remarks/>
        P,
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class opcoesflx_type
    {

        private string isinField;

        private tipoopcao_type tipoField;

        private callput_type callputField;

        private string dtoperacaoField;

        private string dtexercicioField;

        private string ativoField;

        private sn_type garantiaField;

        private decimal premioField;

        private decimal puposicaoField;

        private decimal quantidadeField;

        private decimal valorfinanceiroField;

        private decimal tributosField;

        private decimal precoexercicioField;

        private classeCV_type classeoperacaoField;

        private sn_type hedgeField;

        private int tphedgeField;

        /// <remarks/>
        public string isin
        {
            get
            {
                return this.isinField;
            }
            set
            {
                this.isinField = value;
            }
        }

        /// <remarks/>
        public tipoopcao_type tipo
        {
            get
            {
                return this.tipoField;
            }
            set
            {
                this.tipoField = value;
            }
        }

        /// <remarks/>
        public callput_type callput
        {
            get
            {
                return this.callputField;
            }
            set
            {
                this.callputField = value;
            }
        }

        /// <remarks/>
        public string dtoperacao
        {
            get
            {
                return this.dtoperacaoField;
            }
            set
            {
                this.dtoperacaoField = value;
            }
        }

        /// <remarks/>
        public string dtexercicio
        {
            get
            {
                return this.dtexercicioField;
            }
            set
            {
                this.dtexercicioField = value;
            }
        }

        /// <remarks/>
        public string ativo
        {
            get
            {
                return this.ativoField;
            }
            set
            {
                this.ativoField = value;
            }
        }

        /// <remarks/>
        public sn_type garantia
        {
            get
            {
                return this.garantiaField;
            }
            set
            {
                this.garantiaField = value;
            }
        }

        /// <remarks/>
        public decimal premio
        {
            get
            {
                return this.premioField;
            }
            set
            {
                this.premioField = value;
            }
        }

        /// <remarks/>
        public decimal puposicao
        {
            get
            {
                return this.puposicaoField;
            }
            set
            {
                this.puposicaoField = value;
            }
        }

        /// <remarks/>
        public decimal quantidade
        {
            get
            {
                return this.quantidadeField;
            }
            set
            {
                this.quantidadeField = value;
            }
        }

        /// <remarks/>
        public decimal valorfinanceiro
        {
            get
            {
                return this.valorfinanceiroField;
            }
            set
            {
                this.valorfinanceiroField = value;
            }
        }

        /// <remarks/>
        public decimal tributos
        {
            get
            {
                return this.tributosField;
            }
            set
            {
                this.tributosField = value;
            }
        }

        /// <remarks/>
        public decimal precoexercicio
        {
            get
            {
                return this.precoexercicioField;
            }
            set
            {
                this.precoexercicioField = value;
            }
        }

        /// <remarks/>
        public classeCV_type classeoperacao
        {
            get
            {
                return this.classeoperacaoField;
            }
            set
            {
                this.classeoperacaoField = value;
            }
        }

        /// <remarks/>
        public sn_type hedge
        {
            get
            {
                return this.hedgeField;
            }
            set
            {
                this.hedgeField = value;
            }
        }

        /// <remarks/>
        public int tphedge
        {
            get
            {
                return this.tphedgeField;
            }
            set
            {
                this.tphedgeField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    public enum tipoopcao_type
    {

        /// <remarks/>
        A,

        /// <remarks/>
        E,
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class termorv_type
    {

        private string isinField;

        private string cusipField;

        private string ativoField;

        private string dtoperacaoField;

        private string dtvencimentoField;

        private sn_type garantiaField;

        private decimal puposicaoField;

        private decimal quantidadeField;

        private decimal valorfinanceiroField;

        private decimal tributosField;

        private decimal puvencField;

        private int tpcontaField;

        private classeCV_type classeoperacaoField;

        private sn_type hedgeField;

        private int tphedgeField;

        /// <remarks/>
        public string isin
        {
            get
            {
                return this.isinField;
            }
            set
            {
                this.isinField = value;
            }
        }

        /// <remarks/>
        public string cusip
        {
            get
            {
                return this.cusipField;
            }
            set
            {
                this.cusipField = value;
            }
        }

        /// <remarks/>
        public string ativo
        {
            get
            {
                return this.ativoField;
            }
            set
            {
                this.ativoField = value;
            }
        }

        /// <remarks/>
        public string dtoperacao
        {
            get
            {
                return this.dtoperacaoField;
            }
            set
            {
                this.dtoperacaoField = value;
            }
        }

        /// <remarks/>
        public string dtvencimento
        {
            get
            {
                return this.dtvencimentoField;
            }
            set
            {
                this.dtvencimentoField = value;
            }
        }

        /// <remarks/>
        public sn_type garantia
        {
            get
            {
                return this.garantiaField;
            }
            set
            {
                this.garantiaField = value;
            }
        }

        /// <remarks/>
        public decimal puposicao
        {
            get
            {
                return this.puposicaoField;
            }
            set
            {
                this.puposicaoField = value;
            }
        }

        /// <remarks/>
        public decimal quantidade
        {
            get
            {
                return this.quantidadeField;
            }
            set
            {
                this.quantidadeField = value;
            }
        }

        /// <remarks/>
        public decimal valorfinanceiro
        {
            get
            {
                return this.valorfinanceiroField;
            }
            set
            {
                this.valorfinanceiroField = value;
            }
        }

        /// <remarks/>
        public decimal tributos
        {
            get
            {
                return this.tributosField;
            }
            set
            {
                this.tributosField = value;
            }
        }

        /// <remarks/>
        public decimal puvenc
        {
            get
            {
                return this.puvencField;
            }
            set
            {
                this.puvencField = value;
            }
        }

        /// <remarks/>
        public int tpconta
        {
            get
            {
                return this.tpcontaField;
            }
            set
            {
                this.tpcontaField = value;
            }
        }

        /// <remarks/>
        public classeCV_type classeoperacao
        {
            get
            {
                return this.classeoperacaoField;
            }
            set
            {
                this.classeoperacaoField = value;
            }
        }

        /// <remarks/>
        public sn_type hedge
        {
            get
            {
                return this.hedgeField;
            }
            set
            {
                this.hedgeField = value;
            }
        }

        /// <remarks/>
        public int tphedge
        {
            get
            {
                return this.tphedgeField;
            }
            set
            {
                this.tphedgeField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class termorf_type
    {

        private string isinField;

        private string dtvencativoField;

        private string dtoperField;

        private string dtvencimentoField;

        private decimal qtdField;

        private decimal puoperacaoField;

        private decimal puvencimentoField;

        private decimal puposicaoField;

        private decimal puemissaoField;

        private decimal principalField;

        private decimal valorfinField;

        private decimal tributosField;

        private double coupomField;

        private string indexadorField;

        private decimal percindexField;

        private caracteristica_type caracteristicaField;

        private classeCVA_type classeoperacaoField;

        private sn_type hedgeField;

        private int tphedgeField;

        private string idinternoativoField;

        private nivelrsc_type nivelrscField;

        private bool nivelrscFieldSpecified;

        /// <remarks/>
        public string isin
        {
            get
            {
                return this.isinField;
            }
            set
            {
                this.isinField = value;
            }
        }

        /// <remarks/>
        public string dtvencativo
        {
            get
            {
                return this.dtvencativoField;
            }
            set
            {
                this.dtvencativoField = value;
            }
        }

        /// <remarks/>
        public string dtoper
        {
            get
            {
                return this.dtoperField;
            }
            set
            {
                this.dtoperField = value;
            }
        }

        /// <remarks/>
        public string dtvencimento
        {
            get
            {
                return this.dtvencimentoField;
            }
            set
            {
                this.dtvencimentoField = value;
            }
        }

        /// <remarks/>
        public decimal qtd
        {
            get
            {
                return this.qtdField;
            }
            set
            {
                this.qtdField = value;
            }
        }

        /// <remarks/>
        public decimal puoperacao
        {
            get
            {
                return this.puoperacaoField;
            }
            set
            {
                this.puoperacaoField = value;
            }
        }

        /// <remarks/>
        public decimal puvencimento
        {
            get
            {
                return this.puvencimentoField;
            }
            set
            {
                this.puvencimentoField = value;
            }
        }

        /// <remarks/>
        public decimal puposicao
        {
            get
            {
                return this.puposicaoField;
            }
            set
            {
                this.puposicaoField = value;
            }
        }

        /// <remarks/>
        public decimal puemissao
        {
            get
            {
                return this.puemissaoField;
            }
            set
            {
                this.puemissaoField = value;
            }
        }

        /// <remarks/>
        public decimal principal
        {
            get
            {
                return this.principalField;
            }
            set
            {
                this.principalField = value;
            }
        }

        /// <remarks/>
        public decimal valorfin
        {
            get
            {
                return this.valorfinField;
            }
            set
            {
                this.valorfinField = value;
            }
        }

        /// <remarks/>
        public decimal tributos
        {
            get
            {
                return this.tributosField;
            }
            set
            {
                this.tributosField = value;
            }
        }

        /// <remarks/>
        public double coupom
        {
            get
            {
                return this.coupomField;
            }
            set
            {
                this.coupomField = value;
            }
        }

        /// <remarks/>
        public string indexador
        {
            get
            {
                return this.indexadorField;
            }
            set
            {
                this.indexadorField = value;
            }
        }

        /// <remarks/>
        public decimal percindex
        {
            get
            {
                return this.percindexField;
            }
            set
            {
                this.percindexField = value;
            }
        }

        /// <remarks/>
        public caracteristica_type caracteristica
        {
            get
            {
                return this.caracteristicaField;
            }
            set
            {
                this.caracteristicaField = value;
            }
        }

        /// <remarks/>
        public classeCVA_type classeoperacao
        {
            get
            {
                return this.classeoperacaoField;
            }
            set
            {
                this.classeoperacaoField = value;
            }
        }

        /// <remarks/>
        public sn_type hedge
        {
            get
            {
                return this.hedgeField;
            }
            set
            {
                this.hedgeField = value;
            }
        }

        /// <remarks/>
        public int tphedge
        {
            get
            {
                return this.tphedgeField;
            }
            set
            {
                this.tphedgeField = value;
            }
        }

        /// <remarks/>
        public string idinternoativo
        {
            get
            {
                return this.idinternoativoField;
            }
            set
            {
                this.idinternoativoField = value;
            }
        }

        /// <remarks/>
        public nivelrsc_type nivelrsc
        {
            get
            {
                return this.nivelrscField;
            }
            set
            {
                this.nivelrscField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool nivelrscSpecified
        {
            get
            {
                return this.nivelrscFieldSpecified;
            }
            set
            {
                this.nivelrscFieldSpecified = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    public enum classeCVA_type
    {

        /// <remarks/>
        C,

        /// <remarks/>
        V,

        /// <remarks/>
        A,
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class futuros_type
    {

        private string isinField;

        private string ativoField;

        private string cnpjcorretoraField;

        private string serieField;

        private decimal quantidadeField;

        private decimal vltotalposField;

        private decimal tributosField;

        private string dtvencimentoField;

        private decimal vlajusteField;

        private classeCV_type classeoperacaoField;

        private sn_type hedgeField;

        private int tphedgeField;

        /// <remarks/>
        public string isin
        {
            get
            {
                return this.isinField;
            }
            set
            {
                this.isinField = value;
            }
        }

        /// <remarks/>
        public string ativo
        {
            get
            {
                return this.ativoField;
            }
            set
            {
                this.ativoField = value;
            }
        }

        /// <remarks/>
        public string cnpjcorretora
        {
            get
            {
                return this.cnpjcorretoraField;
            }
            set
            {
                this.cnpjcorretoraField = value;
            }
        }

        /// <remarks/>
        public string serie
        {
            get
            {
                return this.serieField;
            }
            set
            {
                this.serieField = value;
            }
        }

        /// <remarks/>
        public decimal quantidade
        {
            get
            {
                return this.quantidadeField;
            }
            set
            {
                this.quantidadeField = value;
            }
        }

        /// <remarks/>
        public decimal vltotalpos
        {
            get
            {
                return this.vltotalposField;
            }
            set
            {
                this.vltotalposField = value;
            }
        }

        /// <remarks/>
        public decimal tributos
        {
            get
            {
                return this.tributosField;
            }
            set
            {
                this.tributosField = value;
            }
        }

        /// <remarks/>
        public string dtvencimento
        {
            get
            {
                return this.dtvencimentoField;
            }
            set
            {
                this.dtvencimentoField = value;
            }
        }

        /// <remarks/>
        public decimal vlajuste
        {
            get
            {
                return this.vlajusteField;
            }
            set
            {
                this.vlajusteField = value;
            }
        }

        /// <remarks/>
        public classeCV_type classeoperacao
        {
            get
            {
                return this.classeoperacaoField;
            }
            set
            {
                this.classeoperacaoField = value;
            }
        }

        /// <remarks/>
        public sn_type hedge
        {
            get
            {
                return this.hedgeField;
            }
            set
            {
                this.hedgeField = value;
            }
        }

        /// <remarks/>
        public int tphedge
        {
            get
            {
                return this.tphedgeField;
            }
            set
            {
                this.tphedgeField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class swap_type
    {

        private cetipbmf_type cetipbmfField;

        private string isinField;

        private string dtoperacaoField;

        private string dtregistroField;

        private string dtvencimentoField;

        private string cnpjcontraparteField;

        private int garantiaField;

        private decimal vlnotionalField;

        private decimal tributosField;

        private decimal vlmercadoativoField;

        private decimal taxaativoField;

        private string indexadorativoField;

        private decimal percindexativoField;

        private decimal vlmercadopassivoField;

        private decimal taxapassivoField;

        private string indexadorpassivoField;

        private decimal percindexpassivoField;

        private sn_type hedgeField;

        private int tphedgeField;

        private string idinternoativoField;

        /// <remarks/>
        public cetipbmf_type cetipbmf
        {
            get
            {
                return this.cetipbmfField;
            }
            set
            {
                this.cetipbmfField = value;
            }
        }

        /// <remarks/>
        public string isin
        {
            get
            {
                return this.isinField;
            }
            set
            {
                this.isinField = value;
            }
        }

        /// <remarks/>
        public string dtoperacao
        {
            get
            {
                return this.dtoperacaoField;
            }
            set
            {
                this.dtoperacaoField = value;
            }
        }

        /// <remarks/>
        public string dtregistro
        {
            get
            {
                return this.dtregistroField;
            }
            set
            {
                this.dtregistroField = value;
            }
        }

        /// <remarks/>
        public string dtvencimento
        {
            get
            {
                return this.dtvencimentoField;
            }
            set
            {
                this.dtvencimentoField = value;
            }
        }

        /// <remarks/>
        public string cnpjcontraparte
        {
            get
            {
                return this.cnpjcontraparteField;
            }
            set
            {
                this.cnpjcontraparteField = value;
            }
        }

        /// <remarks/>
        public int garantia
        {
            get
            {
                return this.garantiaField;
            }
            set
            {
                this.garantiaField = value;
            }
        }

        /// <remarks/>
        public decimal vlnotional
        {
            get
            {
                return this.vlnotionalField;
            }
            set
            {
                this.vlnotionalField = value;
            }
        }

        /// <remarks/>
        public decimal tributos
        {
            get
            {
                return this.tributosField;
            }
            set
            {
                this.tributosField = value;
            }
        }

        /// <remarks/>
        public decimal vlmercadoativo
        {
            get
            {
                return this.vlmercadoativoField;
            }
            set
            {
                this.vlmercadoativoField = value;
            }
        }

        /// <remarks/>
        public decimal taxaativo
        {
            get
            {
                return this.taxaativoField;
            }
            set
            {
                this.taxaativoField = value;
            }
        }

        /// <remarks/>
        public string indexadorativo
        {
            get
            {
                return this.indexadorativoField;
            }
            set
            {
                this.indexadorativoField = value;
            }
        }

        /// <remarks/>
        public decimal percindexativo
        {
            get
            {
                return this.percindexativoField;
            }
            set
            {
                this.percindexativoField = value;
            }
        }

        /// <remarks/>
        public decimal vlmercadopassivo
        {
            get
            {
                return this.vlmercadopassivoField;
            }
            set
            {
                this.vlmercadopassivoField = value;
            }
        }

        /// <remarks/>
        public decimal taxapassivo
        {
            get
            {
                return this.taxapassivoField;
            }
            set
            {
                this.taxapassivoField = value;
            }
        }

        /// <remarks/>
        public string indexadorpassivo
        {
            get
            {
                return this.indexadorpassivoField;
            }
            set
            {
                this.indexadorpassivoField = value;
            }
        }

        /// <remarks/>
        public decimal percindexpassivo
        {
            get
            {
                return this.percindexpassivoField;
            }
            set
            {
                this.percindexpassivoField = value;
            }
        }

        /// <remarks/>
        public sn_type hedge
        {
            get
            {
                return this.hedgeField;
            }
            set
            {
                this.hedgeField = value;
            }
        }

        /// <remarks/>
        public int tphedge
        {
            get
            {
                return this.tphedgeField;
            }
            set
            {
                this.tphedgeField = value;
            }
        }

        /// <remarks/>
        public string idinternoativo
        {
            get
            {
                return this.idinternoativoField;
            }
            set
            {
                this.idinternoativoField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    public enum cetipbmf_type
    {

        /// <remarks/>
        C,

        /// <remarks/>
        B,

        /// <remarks/>
        O,
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class caixa_type
    {

        private string isininstituicaoField;

        private tpcontacc_type tpcontaField;

        private decimal saldoField;

        private nivelrsc_type nivelrscField;

        private bool nivelrscFieldSpecified;

        /// <remarks/>
        public string isininstituicao
        {
            get
            {
                return this.isininstituicaoField;
            }
            set
            {
                this.isininstituicaoField = value;
            }
        }

        /// <remarks/>
        public tpcontacc_type tpconta
        {
            get
            {
                return this.tpcontaField;
            }
            set
            {
                this.tpcontaField = value;
            }
        }

        /// <remarks/>
        public decimal saldo
        {
            get
            {
                return this.saldoField;
            }
            set
            {
                this.saldoField = value;
            }
        }

        /// <remarks/>
        public nivelrsc_type nivelrsc
        {
            get
            {
                return this.nivelrscField;
            }
            set
            {
                this.nivelrscField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool nivelrscSpecified
        {
            get
            {
                return this.nivelrscFieldSpecified;
            }
            set
            {
                this.nivelrscFieldSpecified = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    public enum tpcontacc_type
    {

        /// <remarks/>
        D,

        /// <remarks/>
        P,

        /// <remarks/>
        N,

        /// <remarks/>
        I,

        /// <remarks/>
        J,
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class cotas_type
    {

        private string isinField;

        private string cnpjfundoField;

        private double qtdisponivelField;

        private double qtgarantiaField;

        private double puposicaoField;

        private decimal tributosField;

        private nivelrsc_type nivelrscField;

        private bool nivelrscFieldSpecified;

        /// <remarks/>
        public string isin
        {
            get
            {
                return this.isinField;
            }
            set
            {
                this.isinField = value;
            }
        }

        /// <remarks/>
        public string cnpjfundo
        {
            get
            {
                return this.cnpjfundoField;
            }
            set
            {
                this.cnpjfundoField = value;
            }
        }

        /// <remarks/>
        public double qtdisponivel
        {
            get
            {
                return this.qtdisponivelField;
            }
            set
            {
                this.qtdisponivelField = value;
            }
        }

        /// <remarks/>
        public double qtgarantia
        {
            get
            {
                return this.qtgarantiaField;
            }
            set
            {
                this.qtgarantiaField = value;
            }
        }

        /// <remarks/>
        public double puposicao
        {
            get
            {
                return this.puposicaoField;
            }
            set
            {
                this.puposicaoField = value;
            }
        }

        /// <remarks/>
        public decimal tributos
        {
            get
            {
                return this.tributosField;
            }
            set
            {
                this.tributosField = value;
            }
        }

        /// <remarks/>
        public nivelrsc_type nivelrsc
        {
            get
            {
                return this.nivelrscField;
            }
            set
            {
                this.nivelrscField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool nivelrscSpecified
        {
            get
            {
                return this.nivelrscFieldSpecified;
            }
            set
            {
                this.nivelrscFieldSpecified = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class despesas_type
    {

        private double txadmField;

        private decimal tributosField;

        private decimal perctaxaadmField;

        private sn_type txperfField;

        private decimal vltxperfField;

        private bool vltxperfFieldSpecified;

        private decimal perctxperfField;

        private bool perctxperfFieldSpecified;

        private decimal percindexField;

        private bool percindexFieldSpecified;

        private decimal outtaxField;

        private bool outtaxFieldSpecified;

        private string indexadorField;

        /// <remarks/>
        public double txadm
        {
            get
            {
                return this.txadmField;
            }
            set
            {
                this.txadmField = value;
            }
        }

        /// <remarks/>
        public decimal tributos
        {
            get
            {
                return this.tributosField;
            }
            set
            {
                this.tributosField = value;
            }
        }

        /// <remarks/>
        public decimal perctaxaadm
        {
            get
            {
                return this.perctaxaadmField;
            }
            set
            {
                this.perctaxaadmField = value;
            }
        }

        /// <remarks/>
        public sn_type txperf
        {
            get
            {
                return this.txperfField;
            }
            set
            {
                this.txperfField = value;
            }
        }

        /// <remarks/>
        public decimal vltxperf
        {
            get
            {
                return this.vltxperfField;
            }
            set
            {
                this.vltxperfField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool vltxperfSpecified
        {
            get
            {
                return this.vltxperfFieldSpecified;
            }
            set
            {
                this.vltxperfFieldSpecified = value;
            }
        }

        /// <remarks/>
        public decimal perctxperf
        {
            get
            {
                return this.perctxperfField;
            }
            set
            {
                this.perctxperfField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool perctxperfSpecified
        {
            get
            {
                return this.perctxperfFieldSpecified;
            }
            set
            {
                this.perctxperfFieldSpecified = value;
            }
        }

        /// <remarks/>
        public decimal percindex
        {
            get
            {
                return this.percindexField;
            }
            set
            {
                this.percindexField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool percindexSpecified
        {
            get
            {
                return this.percindexFieldSpecified;
            }
            set
            {
                this.percindexFieldSpecified = value;
            }
        }

        /// <remarks/>
        public decimal outtax
        {
            get
            {
                return this.outtaxField;
            }
            set
            {
                this.outtaxField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool outtaxSpecified
        {
            get
            {
                return this.outtaxFieldSpecified;
            }
            set
            {
                this.outtaxFieldSpecified = value;
            }
        }

        /// <remarks/>
        public string indexador
        {
            get
            {
                return this.indexadorField;
            }
            set
            {
                this.indexadorField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class outrasdespesas_type
    {

        private int coddespField;

        private double valorField;

        /// <remarks/>
        public int coddesp
        {
            get
            {
                return this.coddespField;
            }
            set
            {
                this.coddespField = value;
            }
        }

        /// <remarks/>
        public double valor
        {
            get
            {
                return this.valorField;
            }
            set
            {
                this.valorField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class provisao_type
    {

        private int codprovField;

        private credeb_type credebField;

        private string dtField;

        private double valorField;

        /// <remarks/>
        public int codprov
        {
            get
            {
                return this.codprovField;
            }
            set
            {
                this.codprovField = value;
            }
        }

        /// <remarks/>
        public credeb_type credeb
        {
            get
            {
                return this.credebField;
            }
            set
            {
                this.credebField = value;
            }
        }

        /// <remarks/>
        public string dt
        {
            get
            {
                return this.dtField;
            }
            set
            {
                this.dtField = value;
            }
        }

        /// <remarks/>
        public double valor
        {
            get
            {
                return this.valorField;
            }
            set
            {
                this.valorField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    public enum credeb_type
    {

        /// <remarks/>
        C,

        /// <remarks/>
        D,
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class corretagem_type
    {

        private string cnpjcorretoraField;

        private bool cnpjcorretoraFieldSpecified;

        private int tpcorretoraField;

        private bool tpcorretoraFieldSpecified;

        private int numopeField;

        private bool numopeFieldSpecified;

        private decimal vlbovField;

        private decimal vlrepassebovField;

        private decimal vlbmfField;

        private decimal vlrepassebmfField;

        private decimal vloutbolsasField;

        private decimal vlrepasseoutbolField;

        /// <remarks/>
        public string cnpjcorretora
        {
            get
            {
                return this.cnpjcorretoraField;
            }
            set
            {
                this.cnpjcorretoraField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool cnpjcorretoraSpecified
        {
            get
            {
                return this.cnpjcorretoraFieldSpecified;
            }
            set
            {
                this.cnpjcorretoraFieldSpecified = value;
            }
        }

        /// <remarks/>
        public int tpcorretora
        {
            get
            {
                return this.tpcorretoraField;
            }
            set
            {
                this.tpcorretoraField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool tpcorretoraSpecified
        {
            get
            {
                return this.tpcorretoraFieldSpecified;
            }
            set
            {
                this.tpcorretoraFieldSpecified = value;
            }
        }

        /// <remarks/>
        public int numope
        {
            get
            {
                return this.numopeField;
            }
            set
            {
                this.numopeField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool numopeSpecified
        {
            get
            {
                return this.numopeFieldSpecified;
            }
            set
            {
                this.numopeFieldSpecified = value;
            }
        }

        /// <remarks/>
        public decimal vlbov
        {
            get
            {
                return this.vlbovField;
            }
            set
            {
                this.vlbovField = value;
            }
        }

        /// <remarks/>
        public decimal vlrepassebov
        {
            get
            {
                return this.vlrepassebovField;
            }
            set
            {
                this.vlrepassebovField = value;
            }
        }

        /// <remarks/>
        public decimal vlbmf
        {
            get
            {
                return this.vlbmfField;
            }
            set
            {
                this.vlbmfField = value;
            }
        }

        /// <remarks/>
        public decimal vlrepassebmf
        {
            get
            {
                return this.vlrepassebmfField;
            }
            set
            {
                this.vlrepassebmfField = value;
            }
        }

        /// <remarks/>
        public decimal vloutbolsas
        {
            get
            {
                return this.vloutbolsasField;
            }
            set
            {
                this.vloutbolsasField = value;
            }
        }

        /// <remarks/>
        public decimal vlrepasseoutbol
        {
            get
            {
                return this.vlrepasseoutbolField;
            }
            set
            {
                this.vlrepasseoutbolField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class imovel_type
    {

        private string logradouroField;

        private string numeroField;

        private string complementoField;

        private string cidadeField;

        private string estadoField;

        private decimal cepField;

        private string nomecomercialField;

        private decimal percpartField;

        private decimal valorcontabilField;

        private string justificativaField;

        private bool justificativaFieldSpecified;

        private decimal valoravaliacaoField;

        private bool valoravaliacaoFieldSpecified;

        private string dtavaliacaoField;

        private tpcli_type tpavaliadorField;

        private bool tpavaliadorFieldSpecified;

        private string cnpjcpfavaliadorField;

        private decimal aluguelcontratadoField;

        private bool aluguelcontratadoFieldSpecified;

        private decimal aluguelatrasadoField;

        private bool aluguelatrasadoFieldSpecified;

        private string opcaorecompraField;

        private string dtopcaorecompraField;

        private string tipoimovelField;

        private string questjurField;

        private string motivoquestjurField;

        private string tipousoField;

        private string matriculaField;

        private bool matriculaFieldSpecified;

        private string cnpjempField;

        /// <remarks/>
        public string logradouro
        {
            get
            {
                return this.logradouroField;
            }
            set
            {
                this.logradouroField = value;
            }
        }

        /// <remarks/>
        public string numero
        {
            get
            {
                return this.numeroField;
            }
            set
            {
                this.numeroField = value;
            }
        }

        /// <remarks/>
        public string complemento
        {
            get
            {
                return this.complementoField;
            }
            set
            {
                this.complementoField = value;
            }
        }

        /// <remarks/>
        public string cidade
        {
            get
            {
                return this.cidadeField;
            }
            set
            {
                this.cidadeField = value;
            }
        }

        /// <remarks/>
        public string estado
        {
            get
            {
                return this.estadoField;
            }
            set
            {
                this.estadoField = value;
            }
        }

        /// <remarks/>
        public decimal cep
        {
            get
            {
                return this.cepField;
            }
            set
            {
                this.cepField = value;
            }
        }

        /// <remarks/>
        public string nomecomercial
        {
            get
            {
                return this.nomecomercialField;
            }
            set
            {
                this.nomecomercialField = value;
            }
        }

        /// <remarks/>
        public decimal percpart
        {
            get
            {
                return this.percpartField;
            }
            set
            {
                this.percpartField = value;
            }
        }

        /// <remarks/>
        public decimal valorcontabil
        {
            get
            {
                return this.valorcontabilField;
            }
            set
            {
                this.valorcontabilField = value;
            }
        }

        /// <remarks/>
        public string justificativa
        {
            get
            {
                return this.justificativaField;
            }
            set
            {
                this.justificativaField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool justificativaSpecified
        {
            get
            {
                return this.justificativaFieldSpecified;
            }
            set
            {
                this.justificativaFieldSpecified = value;
            }
        }

        /// <remarks/>
        public decimal valoravaliacao
        {
            get
            {
                return this.valoravaliacaoField;
            }
            set
            {
                this.valoravaliacaoField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool valoravaliacaoSpecified
        {
            get
            {
                return this.valoravaliacaoFieldSpecified;
            }
            set
            {
                this.valoravaliacaoFieldSpecified = value;
            }
        }

        /// <remarks/>
        public string dtavaliacao
        {
            get
            {
                return this.dtavaliacaoField;
            }
            set
            {
                this.dtavaliacaoField = value;
            }
        }

        /// <remarks/>
        public tpcli_type tpavaliador
        {
            get
            {
                return this.tpavaliadorField;
            }
            set
            {
                this.tpavaliadorField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool tpavaliadorSpecified
        {
            get
            {
                return this.tpavaliadorFieldSpecified;
            }
            set
            {
                this.tpavaliadorFieldSpecified = value;
            }
        }

        /// <remarks/>
        public string cnpjcpfavaliador
        {
            get
            {
                return this.cnpjcpfavaliadorField;
            }
            set
            {
                this.cnpjcpfavaliadorField = value;
            }
        }

        /// <remarks/>
        public decimal aluguelcontratado
        {
            get
            {
                return this.aluguelcontratadoField;
            }
            set
            {
                this.aluguelcontratadoField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool aluguelcontratadoSpecified
        {
            get
            {
                return this.aluguelcontratadoFieldSpecified;
            }
            set
            {
                this.aluguelcontratadoFieldSpecified = value;
            }
        }

        /// <remarks/>
        public decimal aluguelatrasado
        {
            get
            {
                return this.aluguelatrasadoField;
            }
            set
            {
                this.aluguelatrasadoField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool aluguelatrasadoSpecified
        {
            get
            {
                return this.aluguelatrasadoFieldSpecified;
            }
            set
            {
                this.aluguelatrasadoFieldSpecified = value;
            }
        }

        /// <remarks/>
        public string opcaorecompra
        {
            get
            {
                return this.opcaorecompraField;
            }
            set
            {
                this.opcaorecompraField = value;
            }
        }

        /// <remarks/>
        public string dtopcaorecompra
        {
            get
            {
                return this.dtopcaorecompraField;
            }
            set
            {
                this.dtopcaorecompraField = value;
            }
        }

        /// <remarks/>
        public string tipoimovel
        {
            get
            {
                return this.tipoimovelField;
            }
            set
            {
                this.tipoimovelField = value;
            }
        }

        /// <remarks/>
        public string questjur
        {
            get
            {
                return this.questjurField;
            }
            set
            {
                this.questjurField = value;
            }
        }

        /// <remarks/>
        public string motivoquestjur
        {
            get
            {
                return this.motivoquestjurField;
            }
            set
            {
                this.motivoquestjurField = value;
            }
        }

        /// <remarks/>
        public string tipouso
        {
            get
            {
                return this.tipousoField;
            }
            set
            {
                this.tipousoField = value;
            }
        }

        /// <remarks/>
        public string matricula
        {
            get
            {
                return this.matriculaField;
            }
            set
            {
                this.matriculaField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool matriculaSpecified
        {
            get
            {
                return this.matriculaFieldSpecified;
            }
            set
            {
                this.matriculaFieldSpecified = value;
            }
        }

        /// <remarks/>
        public string cnpjemp
        {
            get
            {
                return this.cnpjempField;
            }
            set
            {
                this.cnpjempField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    public enum tipoimovel_type
    {

        /// <remarks/>
        [System.Xml.Serialization.XmlEnumAttribute("01")]
        Item01,

        /// <remarks/>
        [System.Xml.Serialization.XmlEnumAttribute("02")]
        Item02,

        /// <remarks/>
        [System.Xml.Serialization.XmlEnumAttribute("03")]
        Item03,

        /// <remarks/>
        [System.Xml.Serialization.XmlEnumAttribute("04")]
        Item04,

        /// <remarks/>
        [System.Xml.Serialization.XmlEnumAttribute("05")]
        Item05,

        /// <remarks/>
        [System.Xml.Serialization.XmlEnumAttribute("06")]
        Item06,

        /// <remarks/>
        [System.Xml.Serialization.XmlEnumAttribute("07")]
        Item07,

        /// <remarks/>
        [System.Xml.Serialization.XmlEnumAttribute("08")]
        Item08,

        /// <remarks/>
        [System.Xml.Serialization.XmlEnumAttribute("09")]
        Item09,

        /// <remarks/>
        [System.Xml.Serialization.XmlEnumAttribute("10")]
        Item10,

        /// <remarks/>
        [System.Xml.Serialization.XmlEnumAttribute("11")]
        Item11,
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    public enum tipouso_type
    {

        /// <remarks/>
        [System.Xml.Serialization.XmlEnumAttribute("01")]
        Item01,

        /// <remarks/>
        [System.Xml.Serialization.XmlEnumAttribute("02")]
        Item02,

        /// <remarks/>
        [System.Xml.Serialization.XmlEnumAttribute("03")]
        Item03,

        /// <remarks/>
        [System.Xml.Serialization.XmlEnumAttribute("04")]
        Item04,

        /// <remarks/>
        [System.Xml.Serialization.XmlEnumAttribute("05")]
        Item05,
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class opcoesmoedasotcl_type
    {

        private string codoperField;

        private tipoopcao_type tipoField;

        private callput_type callputField;

        private string dtoperacaoField;

        private string dtvencimentoField;

        private string dtexercicioField;

        private string moedaativaField;

        private string moedapassivaField;

        private sn_type garantiaField;

        private decimal premioField;

        private decimal puposicaoField;

        private decimal quantidadeField;

        private decimal valorfinanceiroField;

        private decimal tributosField;

        private decimal precoexercicioField;

        private classeCV_type classeoperacaoField;

        private sn_type hedgeField;

        private int tphedgeField;

        /// <remarks/>
        public string codoper
        {
            get
            {
                return this.codoperField;
            }
            set
            {
                this.codoperField = value;
            }
        }

        /// <remarks/>
        public tipoopcao_type tipo
        {
            get
            {
                return this.tipoField;
            }
            set
            {
                this.tipoField = value;
            }
        }

        /// <remarks/>
        public callput_type callput
        {
            get
            {
                return this.callputField;
            }
            set
            {
                this.callputField = value;
            }
        }

        /// <remarks/>
        public string dtoperacao
        {
            get
            {
                return this.dtoperacaoField;
            }
            set
            {
                this.dtoperacaoField = value;
            }
        }

        /// <remarks/>
        public string dtvencimento
        {
            get
            {
                return this.dtvencimentoField;
            }
            set
            {
                this.dtvencimentoField = value;
            }
        }

        /// <remarks/>
        public string dtexercicio
        {
            get
            {
                return this.dtexercicioField;
            }
            set
            {
                this.dtexercicioField = value;
            }
        }

        /// <remarks/>
        public string moedaativa
        {
            get
            {
                return this.moedaativaField;
            }
            set
            {
                this.moedaativaField = value;
            }
        }

        /// <remarks/>
        public string moedapassiva
        {
            get
            {
                return this.moedapassivaField;
            }
            set
            {
                this.moedapassivaField = value;
            }
        }

        /// <remarks/>
        public sn_type garantia
        {
            get
            {
                return this.garantiaField;
            }
            set
            {
                this.garantiaField = value;
            }
        }

        /// <remarks/>
        public decimal premio
        {
            get
            {
                return this.premioField;
            }
            set
            {
                this.premioField = value;
            }
        }

        /// <remarks/>
        public decimal puposicao
        {
            get
            {
                return this.puposicaoField;
            }
            set
            {
                this.puposicaoField = value;
            }
        }

        /// <remarks/>
        public decimal quantidade
        {
            get
            {
                return this.quantidadeField;
            }
            set
            {
                this.quantidadeField = value;
            }
        }

        /// <remarks/>
        public decimal valorfinanceiro
        {
            get
            {
                return this.valorfinanceiroField;
            }
            set
            {
                this.valorfinanceiroField = value;
            }
        }

        /// <remarks/>
        public decimal tributos
        {
            get
            {
                return this.tributosField;
            }
            set
            {
                this.tributosField = value;
            }
        }

        /// <remarks/>
        public decimal precoexercicio
        {
            get
            {
                return this.precoexercicioField;
            }
            set
            {
                this.precoexercicioField = value;
            }
        }

        /// <remarks/>
        public classeCV_type classeoperacao
        {
            get
            {
                return this.classeoperacaoField;
            }
            set
            {
                this.classeoperacaoField = value;
            }
        }

        /// <remarks/>
        public sn_type hedge
        {
            get
            {
                return this.hedgeField;
            }
            set
            {
                this.hedgeField = value;
            }
        }

        /// <remarks/>
        public int tphedge
        {
            get
            {
                return this.tphedgeField;
            }
            set
            {
                this.tphedgeField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class forwardsmoedas_type
    {

        private tipooperacao_type tipooperacaoField;

        private string moedaativaField;

        private string moedapassivaField;

        private decimal notionalField;

        private decimal taxaField;

        private decimal valorfinanceiroField;

        private decimal tributosField;

        private string dtvencimentoField;

        private classeCV_type classeoperacaoField;

        private sn_type hedgeField;

        private int tphedgeField;

        /// <remarks/>
        public tipooperacao_type tipooperacao
        {
            get
            {
                return this.tipooperacaoField;
            }
            set
            {
                this.tipooperacaoField = value;
            }
        }

        /// <remarks/>
        public string moedaativa
        {
            get
            {
                return this.moedaativaField;
            }
            set
            {
                this.moedaativaField = value;
            }
        }

        /// <remarks/>
        public string moedapassiva
        {
            get
            {
                return this.moedapassivaField;
            }
            set
            {
                this.moedapassivaField = value;
            }
        }

        /// <remarks/>
        public decimal notional
        {
            get
            {
                return this.notionalField;
            }
            set
            {
                this.notionalField = value;
            }
        }

        /// <remarks/>
        public decimal taxa
        {
            get
            {
                return this.taxaField;
            }
            set
            {
                this.taxaField = value;
            }
        }

        /// <remarks/>
        public decimal valorfinanceiro
        {
            get
            {
                return this.valorfinanceiroField;
            }
            set
            {
                this.valorfinanceiroField = value;
            }
        }

        /// <remarks/>
        public decimal tributos
        {
            get
            {
                return this.tributosField;
            }
            set
            {
                this.tributosField = value;
            }
        }

        /// <remarks/>
        public string dtvencimento
        {
            get
            {
                return this.dtvencimentoField;
            }
            set
            {
                this.dtvencimentoField = value;
            }
        }

        /// <remarks/>
        public classeCV_type classeoperacao
        {
            get
            {
                return this.classeoperacaoField;
            }
            set
            {
                this.classeoperacaoField = value;
            }
        }

        /// <remarks/>
        public sn_type hedge
        {
            get
            {
                return this.hedgeField;
            }
            set
            {
                this.hedgeField = value;
            }
        }

        /// <remarks/>
        public int tphedge
        {
            get
            {
                return this.tphedgeField;
            }
            set
            {
                this.tphedgeField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    public enum tipooperacao_type
    {

        /// <remarks/>
        FRW,

        /// <remarks/>
        NDF,
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class participacoes_type
    {

        private string cnpjpartField;

        private decimal valorfinanceiroField;

        /// <remarks/>
        public string cnpjpart
        {
            get
            {
                return this.cnpjpartField;
            }
            set
            {
                this.cnpjpartField = value;
            }
        }

        /// <remarks/>
        public decimal valorfinanceiro
        {
            get
            {
                return this.valorfinanceiroField;
            }
            set
            {
                this.valorfinanceiroField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class fidc_type
    {

        private decimal valorfinanceiroField;

        /// <remarks/>
        public decimal valorfinanceiro
        {
            get
            {
                return this.valorfinanceiroField;
            }
            set
            {
                this.valorfinanceiroField = value;
            }
        }
    }

}
