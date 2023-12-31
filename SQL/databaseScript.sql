USE [db_capitania_prd]
GO
/****** Object:  Table [dbo].[BrokersYTD]    Script Date: 04/01/2020 16:51:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BrokersYTD](
	[BROKER] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TADTV]    Script Date: 04/01/2020 16:51:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TADTV](
	[DATA] [date] NULL,
	[NOME] [nvarchar](255) NULL,
	[ADTV] [float] NULL,
	[ADTVCLASSE] [float] NULL,
	[ADTVCOND] [float] NULL,
	[ADTVCLASSECOND] [float] NULL,
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_TADTV] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TAKA]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TAKA](
	[FromID] [nvarchar](255) NULL,
	[ToID] [nvarchar](255) NULL,
	[DT_CREATED] [date] NULL,
	[DELETED] [bit] NOT NULL,
	[DT_DELETED] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBoleta]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBoleta](
	[DATA] [datetime] NULL,
	[FUNDO] [nvarchar](255) NULL,
	[CONTRAPARTE] [nvarchar](255) NULL,
	[VALOR] [float] NULL,
	[CV] [nvarchar](255) NULL,
	[QUANTIDADE] [float] NULL,
	[PRECO_UNITARIO] [decimal](18, 0) NULL,
	[COMANDO] [nvarchar](255) NULL,
	[DATA_VENCTO] [datetime] NULL,
	[COD_IDENTIF] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBookRegra]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBookRegra](
	[ID] [int] NOT NULL,
	[RuleBook] [int] NULL,
	[Regra] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TCashReportHist]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TCashReportHist](
	[DATA] [datetime] NULL,
	[FUNDO] [nvarchar](255) NULL,
	[CASH] [float] NULL,
	[PCASH] [float] NULL,
	[CASHFREE] [float] NULL,
	[PCASHFREE] [float] NULL,
	[LIQ3M] [float] NULL,
	[REQ3M] [float] NULL,
	[CASHFREE3M] [float] NULL,
	[DISPO] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TCNPJNome]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TCNPJNome](
	[CNPJ] [varchar](14) NOT NULL,
	[NOMECREDITO] [varchar](15) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TConcentra]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TConcentra](
	[Nome] [varchar](60) NULL,
	[Propriedade] [varchar](10) NULL,
	[Concentracao] [float] NULL,
	[ValorProp] [varchar](70) NULL,
	[Data] [date] NULL,
	[TIMESTAMP] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TConfig]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TConfig](
	[HistFileName] [nvarchar](255) NULL,
	[HistFileTab] [nvarchar](255) NULL,
	[HistFileIFIX] [nvarchar](255) NULL,
	[HistFileIPCA2Y] [nvarchar](255) NULL,
	[HistFileIPCA5Y] [nvarchar](255) NULL,
	[HistFileIPCA10Y] [nvarchar](255) NULL,
	[HistFilePath] [nvarchar](255) NULL,
	[HistFileIMAB5] [nvarchar](255) NULL,
	[HistFilePRE2Y] [nvarchar](255) NULL,
	[HistFilePRE5Y] [nvarchar](255) NULL,
	[HistFileDolar] [nvarchar](255) NULL,
	[HistFileIDA] [nvarchar](255) NULL,
	[HistFileRatingsTab] [nvarchar](255) NULL,
	[HistFileQuotaTab] [nvarchar](255) NULL,
	[PosicFilePrefix] [nvarchar](255) NULL,
	[RedemptionFilePath] [nvarchar](255) NULL,
	[RedemptionFileName] [nvarchar](255) NULL,
	[RedemptionFileTab] [nvarchar](255) NULL,
	[ConcentrationFundID] [int] NULL,
	[ConcentrationProperty1] [nvarchar](255) NULL,
	[ConcentrationProperty2] [nvarchar](255) NULL,
	[ConcentrationProperty3] [nvarchar](255) NULL,
	[RedemptionFileTransferTab] [nvarchar](255) NULL,
	[ShareFilePath] [nvarchar](255) NULL,
	[ShareFileName] [nvarchar](255) NULL,
	[EWMA] [float] NULL,
	[EDFAAA] [float] NULL,
	[EDFAA] [float] NULL,
	[EDFA] [float] NULL,
	[EDFBBB] [float] NULL,
	[EDFBB] [float] NULL,
	[EDFB] [float] NULL,
	[EDFCCC] [float] NULL,
	[EDFAAA_ASK] [float] NULL,
	[EDFAA_ASK] [float] NULL,
	[EDFA_ASK] [float] NULL,
	[EDFBBB_ASK] [float] NULL,
	[EDFBB_ASK] [float] NULL,
	[EDFB_ASK] [float] NULL,
	[EDFCCC_ASK] [float] NULL,
	[CreditRatingProperty] [nvarchar](255) NULL,
	[IRBProperty] [nvarchar](255) NULL,
	[LastRatingProperty] [nvarchar](255) NULL,
	[LVV] [float] NULL,
	[LVQ] [float] NULL,
	[LVP] [float] NULL,
	[LSV] [float] NULL,
	[LSQ] [float] NULL,
	[LSP] [float] NULL,
	[LEV] [float] NULL,
	[LEQ] [float] NULL,
	[LEP] [float] NULL,
	[LUV] [float] NULL,
	[LUQ] [float] NULL,
	[LUP] [float] NULL,
	[WarnAt20] [bit] NOT NULL,
	[NegsFilePrefix] [nvarchar](255) NULL,
	[CRMDatabase] [nvarchar](255) NULL,
	[RFETradeSheet] [nvarchar](255) NULL,
	[RFETradeTab] [nvarchar](255) NULL,
	[PricingFilePrefix] [nvarchar](255) NULL,
	[GenLvlDI] [float] NULL,
	[GenLvlInflation] [float] NULL,
	[CredLGD] [float] NULL,
	[CredLGDSec] [float] NULL,
	[CredCorrel] [float] NULL,
	[CredCorrelIntra] [float] NULL,
	[CredGroupProperty] [nvarchar](255) NULL,
	[FIIFileName] [nvarchar](255) NULL,
	[FIIFileTab] [nvarchar](255) NULL,
	[XMLANBIMAPath] [nvarchar](255) NULL,
	[XMLANBIMAPrefix] [nvarchar](255) NULL,
	[ISINDATABASE] [nvarchar](255) NULL,
	[FIIADTVTab] [nvarchar](255) NULL,
	[BlotterFileName] [nvarchar](255) NULL,
	[RStress1] [nvarchar](255) NULL,
	[RStress2] [nvarchar](255) NULL,
	[RStress3] [nvarchar](255) NULL,
	[RStress4] [nvarchar](255) NULL,
	[RStress5] [nvarchar](255) NULL,
	[email] [nvarchar](255) NULL,
	[senha] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TConfigFFundoCols]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TConfigFFundoCols](
	[ColumnName] [nvarchar](255) NULL,
	[username] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TConfiguracao]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TConfiguracao](
	[cfg_param] [varchar](10) NOT NULL,
	[Id] [varchar](10) NOT NULL,
	[cfg_descricao] [varchar](300) NOT NULL,
	[cfg_valor] [varchar](300) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TCrises]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TCrises](
	[NOME] [nvarchar](255) NULL,
	[DT_INI] [datetime] NULL,
	[DT_FIM] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TCTPT]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TCTPT](
	[ID] [int] NOT NULL,
	[Nome] [nvarchar](255) NULL,
	[RazaoSocial] [nvarchar](255) NULL,
	[Atividade] [nvarchar](255) NULL,
	[CNPJ] [nvarchar](255) NULL,
	[Administrador] [nvarchar](255) NULL,
	[CNPJADM] [nvarchar](255) NULL,
	[Endereco] [nvarchar](255) NULL,
	[CEP] [nvarchar](255) NULL,
	[Cidade] [nvarchar](255) NULL,
	[Estado] [nvarchar](255) NULL,
	[Telefone] [nvarchar](255) NULL,
	[email] [nvarchar](255) NULL,
	[Procuradores] [nvarchar](255) NULL,
	[CNPJPROC] [nvarchar](255) NULL,
	[PerfilRisco] [nvarchar](255) NULL,
	[Atualizado] [datetime] NULL,
	[PL] [float] NULL,
	[PoliticamenteExposto_PJ] [bit] NOT NULL,
	[OFAC_PJ] [bit] NOT NULL,
	[BlackList_PJ] [bit] NOT NULL,
	[PoliticamenteExposto_Adm] [bit] NOT NULL,
	[OFAC_Adm] [bit] NOT NULL,
	[BlackList_Adm] [bit] NOT NULL,
	[PoliticamenteExposto_Proc] [bit] NOT NULL,
	[OFAC_Proc] [bit] NOT NULL,
	[BlackList_Proc] [bit] NOT NULL,
	[Status] [nvarchar](255) NULL,
	[FonteScreening] [nvarchar](255) NULL,
	[TIPO] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TFACTORHIST]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TFACTORHIST](
	[FACTORID] [nvarchar](255) NULL,
	[DATA] [datetime] NULL,
	[VALOR] [float] NULL,
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_TFACTORHIST] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TFluxos]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TFluxos](
	[IDFLUXO] [varchar](15) NULL,
	[DATA] [datetime] NULL,
	[AMORT] [float] NULL,
	[JUROS] [float] NULL,
	[DT_CREATED] [date] NULL,
	[DT_DELETED] [date] NULL,
	[DELETED] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TFundoBook]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TFundoBook](
	[Fundo] [int] NULL,
	[Book] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TFundos]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TFundos](
	[ID] [int] NULL,
	[Nome] [nvarchar](255) NULL,
	[LiqNome] [nvarchar](255) NULL,
	[CNPJ] [varchar](14) NULL,
	[Qualif] [nvarchar](255) NULL,
	[IDTitulo] [nvarchar](255) NULL,
	[Consolidation] [nvarchar](255) NULL,
	[TIPO] [nvarchar](255) NULL,
	[PrazoResgate] [int] NULL,
	[LIM_VaR] [float] NULL,
	[LIM_Stress] [float] NULL,
	[LIM_EL] [float] NULL,
	[LIM_UL] [float] NULL,
	[LIM_DUR] [float] NULL,
	[CaixaMandato] [float] NULL,
	[OverrideLimits] [bit] NOT NULL,
	[CONCENTRACAO] [nvarchar](255) NULL,
	[TIPO409] [nvarchar](255) NULL,
	[CredLimRegulam] [bit] NOT NULL,
	[DT_CREATED] [date] NULL,
	[DELETED] [bit] NOT NULL,
	[DT_DELETED] [date] NULL,
	[Area] [nvarchar](255) NULL,
	[Favorit_Cash] [bit] NOT NULL,
	[Favorit_Credit] [bit] NOT NULL,
	[Favorit_mkt] [bit] NOT NULL,
	[LiqMethod] [nvarchar](255) NULL,
	[Tolerancia1] [int] NULL,
	[Tolerancia2] [int] NULL,
	[NOMEBLOTTER] [nvarchar](255) NULL,
	[Rule_NoDayTrd] [bit] NOT NULL,
	[Rule_NoCrssTrd] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[THistAlloc]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THistAlloc](
	[DATA] [datetime] NULL,
	[FUNDO] [nvarchar](255) NULL,
	[ATIVO] [nvarchar](255) NULL,
	[PUFUNDO] [float] NULL,
	[PUGERAL] [float] NULL,
	[COMPLIANT] [nvarchar](255) NULL,
	[CV] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThistAML]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThistAML](
	[Data] [datetime] NULL,
	[Trade] [int] NULL,
	[ctpt] [nvarchar](255) NULL,
	[Compliant] [nvarchar](255) NULL,
	[Coment] [nvarchar](255) NULL,
	[Ativo] [nvarchar](255) NULL,
	[Fundo] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[THistCompBreaches]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THistCompBreaches](
	[FUNDO] [varchar](500) NULL,
	[LIVRO] [varchar](500) NULL,
	[TIPO] [varchar](500) NULL,
	[REGRA] [varchar](500) NULL,
	[REGRATEXTO] [varchar](500) NULL,
	[ALOCACAO] [float] NULL,
	[DATA] [date] NULL,
	[ESCOPO] [varchar](500) NULL,
	[PAPEIS] [nvarchar](max) NULL,
	[VERSAO] [int] NULL,
	[TIPOLIMITE] [varchar](500) NULL,
	[DELTA] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[THistCompl]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THistCompl](
	[Data] [date] NULL,
	[Fundo] [varchar](50) NULL,
	[Livro] [varchar](30) NULL,
	[Result] [varchar](10) NULL,
	[RuleBreaches] [varchar](1000) NULL,
	[DataWrite] [datetime] NULL,
	[RuleBreachText] [varchar](2000) NULL,
	[FUNDSTATUS] [varchar](2000) NULL,
	[DATAINFO] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[THistImportReport]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THistImportReport](
	[DATARUN] [date] NULL,
	[QUAL] [nvarchar](255) NULL,
	[QUEM] [nvarchar](255) NULL,
	[RESULT] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[THistLimCr]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THistLimCr](
	[Código] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[THistRisk]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THistRisk](
	[DataRun] [date] NULL,
	[DataInfo] [date] NULL,
	[Fundo] [varchar](500) NULL,
	[VaR] [float] NULL,
	[VaRQuota] [float] NULL,
	[Stress] [float] NULL,
	[Caixa] [float] NULL,
	[Liq_OK] [varchar](500) NULL,
	[Liq_1] [float] NULL,
	[Liq_5] [float] NULL,
	[Liq_21] [float] NULL,
	[Liq_42] [float] NULL,
	[Liq_63] [float] NULL,
	[Liq_126] [float] NULL,
	[Liq_252] [float] NULL,
	[PL] [float] NULL,
	[Version] [int] NULL,
	[FundType] [varchar](500) NULL,
	[DataWrite] [datetime] NULL,
	[E_Imob] [float] NULL,
	[E_Infl] [float] NULL,
	[E_Pre] [float] NULL,
	[E_dolar] [float] NULL,
	[E_IDA] [float] NULL,
	[E_ImoIdio] [float] NULL,
	[Req_Cash_1] [int] NULL,
	[Req_Cash_5] [float] NULL,
	[Req_Cash_21] [float] NULL,
	[Req_Cash_42] [float] NULL,
	[Req_Cash_63] [float] NULL,
	[Req_Cash_126] [float] NULL,
	[Req_Cash_252] [float] NULL,
	[Crd_EL] [float] NULL,
	[Crd_VaR] [float] NULL,
	[Crd_EL1] [float] NULL,
	[Crd_VaR1] [float] NULL,
	[Area] [varchar](500) NULL,
	[RISKMKTOK] [varchar](500) NULL,
	[RISKCRDOK] [varchar](500) NULL,
	[LIQSTRESSNEED] [float] NULL,
	[LIQSTRESSAVAIL] [float] NULL,
	[LIQSTRESSREQ] [float] NULL,
	[LIQSTRESSPERCENTILE] [float] NULL,
	[FUNDSTATUS] [varchar](500) NULL,
	[Disp] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[THistStress]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THistStress](
	[DATARUN] [date] NULL,
	[FUNDO] [varchar](500) NULL,
	[CENARIO] [varchar](500) NULL,
	[STRESS] [float] NULL,
	[AREA] [varchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[THistTradeErrs]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THistTradeErrs](
	[DATARUN] [datetime] NULL,
	[DATA] [datetime] NULL,
	[TRADEKEY] [nvarchar](255) NULL,
	[ADDR] [nvarchar](255) NULL,
	[FUNDO] [nvarchar](255) NULL,
	[ATIVO] [nvarchar](255) NULL,
	[CV] [nvarchar](255) NULL,
	[QUANT] [float] NULL,
	[TAXA] [float] NULL,
	[PU] [float] NULL,
	[EXTENSO] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TLiqGabarito]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TLiqGabarito](
	[DATA] [datetime] NULL,
	[MESES] [float] NULL,
	[PERCENTIL] [float] NULL,
	[LREQ] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TLiqStress]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TLiqStress](
	[TIPO409] [nvarchar](255) NULL,
	[CONCENTRACAO] [nvarchar](255) NULL,
	[SAQUE] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TLOG]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TLOG](
	[DATAHORA] [datetime] NULL,
	[ACAO] [nvarchar](255) NULL,
	[USER] [nvarchar](255) NULL,
	[COMPUTER] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TLOGERRO]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TLOGERRO](
	[DATAHORA] [datetime] NULL,
	[MSGERRO] [nvarchar](255) NULL,
	[ITEM] [nvarchar](255) NULL,
	[USER] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TLOGPERF]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TLOGPERF](
	[DATAHORA] [datetime] NULL,
	[USER] [nvarchar](255) NULL,
	[OPER] [nvarchar](255) NULL,
	[ITENS] [int] NULL,
	[SECS] [float] NULL,
	[ITEMPERSEC] [float] NULL,
	[SECPERITEM] [float] NULL,
	[VERSAO] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TMailingLIst]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TMailingLIst](
	[Nome] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NULL,
	[Function] [int] NULL,
	[Lists] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TMaiorCotista]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TMaiorCotista](
	[DATAOBS] [date] NULL,
	[FUNDO] [nvarchar](255) NULL,
	[MAXCOT1] [float] NULL,
	[MAXCOT2] [float] NULL,
	[MAXCOT3] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TPapel]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TPapel](
	[Nome] [varchar](100) NULL,
	[ID] [varchar](70) NULL,
	[CODCETIP] [varchar](40) NULL,
	[Fundo] [smallint] NOT NULL,
	[Class_Liq] [varchar](10) NULL,
	[Class_Rentab] [varchar](10) NULL,
	[Data_Emissao] [date] NULL,
	[Data_Vencto] [date] NULL,
	[Duration] [float] NULL,
	[Asset_Value] [float] NULL,
	[Asset_Vol] [float] NULL,
	[CashFlow_ID] [varchar](20) NULL,
	[Senior_Before] [float] NULL,
	[Index] [nvarchar](255) NULL,
	[Yield] [float] NULL,
	[Coupon] [float] NULL,
	[DayCount] [nvarchar](255) NULL,
	[ISIN] [varchar](40) NULL,
	[XMLANBIMA] [nvarchar](255) NULL,
	[DT_CREATED] [date] NULL,
	[DT_DELETED] [date] NULL,
	[DELETED] [bit] NOT NULL,
	[Status] [nvarchar](255) NULL,
	[TIPO] [nvarchar](255) NULL,
	[Holdings] [int] NULL,
	[SENIOR] [nvarchar](255) NULL,
	[NameCr] [nvarchar](255) NULL,
	[CNPJ] [nvarchar](255) NULL,
	[IDPapel] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_TPapel] PRIMARY KEY CLUSTERED 
(
	[IDPapel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TPapelProp]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TPapelProp](
	[Papel] [nvarchar](255) NULL,
	[Propriedade] [int] NULL,
	[Valor] [nvarchar](255) NULL,
	[Data] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TPosic]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TPosic](
	[FUNDO] [int] NULL,
	[PAPEL] [nvarchar](255) NULL,
	[ISIN] [nvarchar](255) NULL,
	[Valor] [float] NULL,
	[DATA] [date] NULL,
	[TIPO] [int] NULL,
	[QUANT] [float] NULL,
	[BLOQUEADO] [float] NULL,
	[ID] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TPOSICLAYOUT2]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TPOSICLAYOUT2](
	[FUNDO] [int] NULL,
	[PAPEL_ISIN] [nvarchar](255) NULL,
	[QUANT] [float] NULL,
	[VALOR] [float] NULL,
	[DATA] [date] NULL,
	[PAPEL_COD] [nvarchar](255) NULL,
	[TIPO] [nvarchar](255) NULL,
	[DTVENC] [date] NULL,
	[DTISSUE] [date] NULL,
	[INDEX] [nvarchar](255) NULL,
	[CUPOM] [float] NULL,
	[PINDEX] [float] NULL,
	[CNPJISSUE] [nvarchar](255) NULL,
	[IMPORTFOLDER] [nvarchar](255) NULL,
	[COMPROMISSADA] [bit] NOT NULL,
	[ID] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TPricing]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TPricing](
	[DATAOBS] [date] NULL,
	[ATIVO] [nvarchar](255) NULL,
	[PRECO] [float] NULL,
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_TPricing] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TPropriedades]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TPropriedades](
	[ID] [int] NULL,
	[Nome] [nvarchar](255) NULL,
	[ValorLivre] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TPropValues]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TPropValues](
	[Propriedade] [int] NULL,
	[Valor] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TProvFilter]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TProvFilter](
	[IDUNICA] [int] NOT NULL,
	[FUNDO] [int] NULL,
	[PROV_COD] [nvarchar](255) NULL,
	[PROV_DATA] [nvarchar](255) NULL,
	[PP_ISIN] [nvarchar](255) NULL,
	[PP_COD] [nvarchar](255) NULL,
	[DESCR] [nvarchar](255) NULL,
	[PP_TIPO] [nvarchar](255) NULL,
	[DT_CREATED] [date] NULL,
	[DT_DELETED] [date] NULL,
	[DELETED] [bit] NOT NULL,
	[ID] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TPTC]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TPTC](
	[DATA] [datetime] NULL,
	[DATARUN] [datetime] NULL,
	[FUNDO] [nvarchar](255) NULL,
	[RESULT] [nvarchar](255) NULL,
	[TRADES] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TPTCDETAIL]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TPTCDETAIL](
	[DATARUN] [datetime] NULL,
	[DATA] [date] NULL,
	[ACTIONBY] [nvarchar](255) NULL,
	[TRADEKEY] [nvarchar](255) NULL,
	[FUNDO] [nvarchar](255) NULL,
	[ADDR] [nvarchar](255) NULL,
	[STATUS] [nvarchar](255) NULL,
	[OBS] [nvarchar](255) NULL,
	[OK] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TQuotas]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TQuotas](
	[DATA] [date] NULL,
	[FUNDO] [int] NULL,
	[QUOTA] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRatingNames]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRatingNames](
	[ID] [nvarchar](50) NULL,
	[NOME] [nvarchar](255) NULL,
	[SETOR] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRatings]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRatings](
	[DATA] [date] NULL,
	[ID] [nvarchar](255) NULL,
	[RATING] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRegras]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRegras](
	[ID] [int] NOT NULL,
	[NOME] [nvarchar](255) NULL,
	[MAXMIN] [nvarchar](255) NULL,
	[LIMITE] [float] NULL,
	[POR] [bit] NOT NULL,
	[POR_Prop] [int] NULL,
	[PARA] [bit] NOT NULL,
	[PARA_Prop] [int] NULL,
	[PARA_Valor] [nvarchar](255) NULL,
	[WORKLOW] [int] NULL,
	[WARN] [float] NULL,
	[PARA_COMP] [nvarchar](255) NULL,
	[ABERTA] [bit] NOT NULL,
	[MOVEMENTRULE] [bit] NOT NULL,
	[ANDRULE] [bit] NOT NULL,
	[AND_Prop] [int] NULL,
	[AND_Valor] [nvarchar](255) NULL,
	[AND_COMP] [nvarchar](255) NULL,
	[DT_CREATED] [datetime] NULL,
	[DT_DELETED] [datetime] NULL,
	[DELETED] [bit] NOT NULL,
	[REFISSUE] [bit] NOT NULL,
	[ISSUE_PROP] [nvarchar](255) NULL,
	[ESCOPO] [nvarchar](255) NULL,
	[ISSUE_QUANT] [bit] NOT NULL,
	[LIM_REF] [nvarchar](255) NULL,
	[AND2RULE] [bit] NOT NULL,
	[AND2_PROP] [int] NULL,
	[AND2_VALOR] [nvarchar](255) NULL,
	[AND2_COMP] [nvarchar](255) NULL,
	[AND3RULE] [bit] NOT NULL,
	[AND3_PROP] [int] NULL,
	[AND3_VALOR] [nvarchar](255) NULL,
	[AND3_COMP] [nvarchar](255) NULL,
	[CONECTOR] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TResgates]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TResgates](
	[DATAOBS] [date] NULL,
	[FUNDO] [varchar](255) NULL,
	[DATALIQ] [date] NULL,
	[VALOR] [float] NULL,
	[DATACANCEL] [date] NULL,
	[CANCELADO] [bit] NOT NULL,
	[TOTAL] [bit] NOT NULL,
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_TResgates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRiskClass]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRiskClass](
	[RiskClass] [nvarchar](255) NULL,
	[Politica] [nvarchar](255) NULL,
	[PublicoAlvo] [nvarchar](255) NULL,
	[Tipo] [nvarchar](255) NULL,
	[ReguaRisco] [nvarchar](255) NULL,
	[M_VaR] [float] NULL,
	[M_Stress] [float] NULL,
	[M_QVaR] [float] NULL,
	[Conc_1] [float] NULL,
	[Conc_2] [float] NULL,
	[Conc_3] [float] NULL,
	[Conc_4] [float] NULL,
	[Cred_el] [float] NULL,
	[Cred_ul] [real] NULL,
	[Cred_el1] [float] NULL,
	[Cred_ul1] [float] NULL,
	[Duration] [float] NULL,
	[PriorTeste] [int] NULL,
	[Vig_Ini] [date] NULL,
	[Vig_fim] [date] NULL,
	[Vig_exp] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRuleBooks]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRuleBooks](
	[ID] [int] NOT NULL,
	[Nome] [nvarchar](255) NULL,
	[DT_CREATED] [datetime] NULL,
	[DT_DELETED] [datetime] NULL,
	[DELETED] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tStress]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tStress](
	[Nome] [nvarchar](255) NULL,
	[Titulo] [nvarchar](255) NULL,
	[Percentual] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TTrades]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TTrades](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[DATA] [date] NULL,
	[HORA] [datetime] NULL,
	[HORA_MS] [float] NULL,
	[FUNDO] [nvarchar](255) NULL,
	[ATIVO] [nvarchar](255) NULL,
	[CV] [nvarchar](255) NULL,
	[QUANT] [float] NULL,
	[TAXA] [float] NULL,
	[PU] [float] NULL,
	[PRICEREF] [float] NULL,
	[PRICESRC] [nvarchar](255) NULL,
	[BROKER] [nvarchar](255) NULL,
	[PRODUTO] [nvarchar](255) NULL,
	[NOMEATIVO] [nvarchar](255) NULL,
	[VALFIN] [float] NULL,
 CONSTRAINT [PK_TTrades] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TTransfers]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TTransfers](
	[DATAOBS] [datetime] NULL,
	[FUNDO] [nvarchar](255) NULL,
	[DATALIQ] [datetime] NULL,
	[VALOR] [float] NULL,
	[DATACANCEL] [datetime] NULL,
	[CANCELADO] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TUsers]    Script Date: 04/01/2020 16:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TUsers](
	[login] [nvarchar](255) NULL,
	[IMPORTA] [int] NULL,
	[REPORTA] [int] NULL,
	[ACESSO] [nvarchar](255) NULL,
	[BATCHUSER] [bit] NOT NULL
) ON [PRIMARY]
GO
