VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CConfig"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'Contém configuração comum a todos os usuários

'------------------------------------------------------------------------------------------------------
'   I m p o r t a ç õ e s
'------------------------------------------------------------------------------------------------------
Public HistFileName As String                   'Nome da planinha de histórico de mercado
Public HistFilePath As String                   'Path da planinha de histórico de mercado
Public HistFileTab As String                    'Tab da planinha de histórico de mercado
Public HistfileIFIX As String                   'Cabeçalho de IFIX na planinha de histórico de mercado
Public HistFileIPCA2Y As String                 'Cabeçalho de IPCA2Y na planinha de histórico de mercado
Public HistFileIPCA5Y As String                 'Cabeçalho de IPCA5Y na planinha de histórico de mercado
Public HistFileIPCA10Y As String                'Cabeçalho de IPCA10Y na planinha de histórico de mercado
Public HistFileIMAB5 As String                  'Cabeçalho de IMAB5 na planinha de histórico de mercado
Public HistFilePre2Y As String                  'Cabeçalho de PRE2Y na planinha de histórico de mercado
Public HistFilePre5Y As String                  'Cabeçalho de PRE5Y na planinha de histórico de mercado
Public HistFileDolar As String                  'Cabeçalho de Dólar na planinha de histórico de mercado
Public HistFileIDA As String                    'Cabeçalho de IDA na planinha de histórico de mercado
Public HistFileRatingsTab As String             'Tab dos ratings de crédito
Public HistFileQuotaTab As String               'Tab das quotas dos fundos próprios

Public PosicFilePrefix As String                'Prefixo (path e file) do arquivo .txt de posição

Public RedemptionFilePath As String             'Path da planinha de resgates
Public RedemptionFileName As String             'Nome da planinha de resgates
Public RedemptionFileTab As String              'Tab da planinha de resgates
Public RedemptionFileTransferTab As String      'Tab da planilha de transferências

Public ShareFilePath As String                  'Path da planilha de Concentração de cotistas
Public ShareFileName As String                  'Nome da planilha de Concentração de cotistas
Public NEGSFilePrefix As String                 'Prefixo (path e file) do arquivo .txt de NEGS (Renda Variável)
Public PricingFilePrefix As String              'Prefixo (path e file) do arquivo .txt de pricing do Administrador

Public CRMDataBase As String                    'Path e file do database do CRM
Public RFETradeSheet As String                  'Path e file da planilha de Trades de RFE
Public RFETradeTab As String                    'Tab da planilha de Trades de RFE

Public FIIFileName As String                    'Path e File do arquivo de pricing de FII
Public FIIFileTab As String                     'Tab da planilha de pricing de FII
Public FIIADTVTab As String                     'Tab da planilha de ADTV de FII

Public XMLANBIMAPath As String                  'Path do arquivo XML ANBIMA de posição
Public XMLANBIMAPrefix As String                'Prefixo do arquivo XML ANBIMA de posição

Public ISINDataBase As String                   'Path e File do Database de ISIN

Public BlotterFileName As String                'Nome (path e nome) do arquivo .txt de boletas

'------------------------------------------------------------------------------------------------------
'   C o n s t a n t e s      d e      R i s c o
'------------------------------------------------------------------------------------------------------
Public ConcentrationFundID As Integer           'ID do fundo a ser reportada a concentração
Public ConcentrationProp1 As String             'Propriedade 1 a ser reportada a concentração
Public ConcentrationProp2 As String             'Propriedade 2 a ser reportada a concentração
Public ConcentrationProp3 As String             'Propriedade 3 a ser reportada a concentração

Public EWMA As Double                           'EWMA do risco de mercado
Public VaRConf As Double                        'T-stat da confiabilidade

Public EDFAAA As Double                         'EDF do rating AAA
Public EDFAA  As Double                         'EDF do rating AA
Public EDFA   As Double                         'EDF do rating A
Public EDFBBB As Double                         'EDF do rating BBB
Public EDFBB  As Double                         'EDF do rating BB
Public EDFB   As Double                         'EDF do rating B
Public EDFCCC As Double                         'EDF do rating CCC

Public EDFAAAask As Double                      'EDF (ask) do rating AAA
Public EDFAAask  As Double                      'EDF (ask) do rating AA
Public EDFAask   As Double                      'EDF (ask) do rating A
Public EDFBBBask As Double                      'EDF (ask) do rating BBB
Public EDFBBask  As Double                      'EDF (ask) do rating BB
Public EDFBask   As Double                      'EDF (ask) do rating B
Public EDFCCCask As Double                      'EDF (ask) do rating CCC

Public CreditRatingProperty As String           'propriedade que contém o Rating de Crédito
Public IRBRatingProperty As String              'propriedade que contém o IRB
Public LastRatingProperty As String             'propriedade que contém a data do último rating
Public CredLGD    As Double                     'LGD Clean
Public CredLGDSec As Double                     'LGD Secured
Public CredCorrel As Double                     'Asset correlation setores diferentes
Public CredCorrelIntra As Double                'Asset correlation setores iguais
Public CredGroupProperty As String              'Grupo de crédito

Public LVV As Double                            'Limite de Volatilidade dos fundos de varejo
Public LVQ As Double                            'Limite de Volatilidade dos fundos qualificados
Public LVP As Double                            'Limite de Volatilidade dos fundos profissionais
Public LSV As Double                            'Limite de Stress dos fundos de varejo
Public LSQ As Double                            'Limite de Stress dos fundos qualificados
Public LSP As Double                            'Limite de Stress dos fundos profissionais
Public LEV As Double                            'Limite de EDF dos fundos de varejo
Public LEQ As Double                            'Limite de EDF dos fundos qualificados
Public LEP As Double                            'Limite de EDF dos fundos profissionais
Public LUV As Double                            'Limite de CreditVaR dos fundos de varejo
Public LUQ As Double                            'Limite de CreditVaR dos fundos qualificados
Public LUP As Double                            'Limite de CreditVaR dos fundos profissionais
Public WarnAt20 As Boolean                      'Warning a 20% off Limite

Public RStress1 As String                       'Cenários do reporte de stress
Public RStress2 As String                       'Cenários do reporte de stress
Public RStress3 As String                       'Cenários do reporte de stress
Public RStress4 As String                       'Cenários do reporte de stress
Public RStress5 As String                       'Cenários do reporte de stress

Public email As String
Public Senha As String

'------------------------------------------------------------------------------------------------------
'   C o n s t a n t e s      d e      C á l c u l o
'------------------------------------------------------------------------------------------------------
'Public GenLvlDI As Double                       'Nível Geral de Taxa de Juros
'Public GenLvlInflation As Double                'Nível Geral de Inflação


'------------------------------------------------------------------------------------------------------
'   C o n s t a n t e s      d e      S t r e s s      d e       L i q u i d e z
'------------------------------------------------------------------------------------------------------
Public CLiqStress As Collection


'------------------------------------------------------------------------------------------------------
'   M a i l e r
'------------------------------------------------------------------------------------------------------
Private MailerNome(100) As String
Private MailerMail(100) As String
Private MailerFunc(100) As String
Private MailerList(100) As String
Public MailerN As Integer


'------------------------------------------------------------------------------------------------------
'   C o n f i g u r a ç ã o    C o l u n a s
'------------------------------------------------------------------------------------------------------
Public FFundoColumnNames As New Collection

Private Const vHistFileName As String = "001"
Private Const vHistFileTab  As String = "002"
Private Const vHistFileIFIX As String = "003"
Private Const vHistFileIPCA2Y As String = "004"
Private Const vHistFileIPCA5Y As String = "005"
Private Const vHistFileIPCA10Y As String = "006"
Private Const vHistFilePath As String = "007"
Private Const vHistFileIMAB5 As String = "008"
Private Const vHistFilePRE2Y As String = "009"
Private Const vHistFilePRE5Y As String = "010"
Private Const vHistFileDolar As String = "011"
Private Const vHistFileIDA As String = "012"
Private Const vHistFileRatingsTab As String = "013"
Private Const vHistFileQuotaTab As String = "014"
Private Const vPosicFilePrefix As String = "015"
Private Const vRedemptionFilePath As String = "016"
Private Const vRedemptionFileName As String = "017"
Private Const vRedemptionFileTab As String = "018"
Private Const vConcentrationFundID As String = "019"
Private Const vConcentrationProperty1 As String = "020"
Private Const vConcentrationProperty2 As String = "021"
Private Const vConcentrationProperty3 As String = "022"
Private Const vRedemptionFileTransferTab As String = "023"
Private Const vShareFilePath As String = "024"
Private Const vShareFileName As String = "025"
Private Const vEWMA As String = "026"
Private Const vEDFAAA As String = "027"
Private Const vEDFAA As String = "028"
Private Const vEDFA As String = "029"
Private Const vEDFBBB As String = "030"
Private Const vEDFBB As String = "031"
Private Const vEDFB As String = "032"
Private Const vEDFCCC As String = "033"
Private Const vEDFAAA_ASK As String = "034"
Private Const vEDFAA_ASK As String = "035"
Private Const vEDFA_ASK As String = "036"
Private Const vEDFBBB_ASK As String = "037"
Private Const vEDFBB_ASK As String = "038"
Private Const vEDFB_ASK As String = "039"
Private Const vEDFCCC_ASK As String = "040"
Private Const vCreditRatingProperty As String = "041"
Private Const vIRBProperty As String = "042"
Private Const vLastRatingProperty As String = "043"
Private Const vLVV As String = "044"
Private Const vLVQ As String = "045"
Private Const vLVP As String = "046"
Private Const vLSV As String = "047"
Private Const vLSQ As String = "048"
Private Const vLSP As String = "049"
Private Const vLEV As String = "050"
Private Const vLEQ As String = "051"
Private Const vLEP As String = "052"
Private Const vLUV As String = "053"
Private Const vLUQ As String = "054"
Private Const vLUP As String = "055"
Private Const vWarnAt20 As String = "056"
Private Const vNegsFilePrefix As String = "057"
Private Const vCRMDatabase As String = "058"
Private Const vRFETradeSheet As String = "059"
Private Const vRFETradeTab As String = "060"
Private Const vPricingFilePrefix As String = "061"
Private Const vGenLvlDI As String = "062"
Private Const vGenLvlInflation As String = "063"
Private Const vCredLGD As String = "064"
Private Const vCredLGDSec As String = "065"
Private Const vCredCorrel As String = "066"
Private Const vCredCorrelIntra As String = "067"
Private Const vCredGroupProperty As String = "068"
Private Const vFIIFileName As String = "069"
Private Const vFIIFileTab As String = "070"
Private Const vXMLANBIMAPath As String = "071"
Private Const vXMLANBIMAPrefix As String = "072"
Private Const vISINDATABASE As String = "073"
Private Const vFIIADTVTab As String = "074"
Private Const vBlotterFileName As String = "075"
Private Const vRStress1 As String = "076"
Private Const vRStress2 As String = "077"
Private Const vRStress3 As String = "078"
Private Const vRStress4 As String = "079"
Private Const vRStress5 As String = "080"
Private Const vemail As String = "081"
Private Const vsenha As String = "082"
Private Const vPathXmlAnbimaRaiz As String = "083"
Private Const vIntervaloTempoProcessamentoImportacaoPlanilhas As String = "084"

Public Sub ReadConfig()
    Dim db As ADODB.Connection, rs As ADODB.Recordset
    Dim vSQL As String
    
    Set db = OpenTheDatabase
    
    'Lê registro de configuração
        Set rs = New ADODB.Recordset
        vSQL = "SELECT * " & vbCr & _
               "  FROM TConfiguracao" & vbCr
        Call rs.open(vSQL, db, adOpenForwardOnly, adLockReadOnly)
        While Not rs.EOF
            Select Case rs("cfg_param")
                Case vHistFilePath
                    HistFilePath = rs("cfg_valor")
                Case vHistFileName
                    HistFileName = rs("cfg_valor")
                Case vHistFileTab
                    HistFileTab = rs("cfg_valor")
                Case vHistFileIFIX
                    HistfileIFIX = rs("cfg_valor")
                Case vHistFileIPCA2Y
                    HistFileIPCA2Y = rs("cfg_valor")
                Case vHistFileIPCA5Y
                    HistFileIPCA5Y = rs("cfg_valor")
                Case vHistFileIPCA10Y
                    HistFileIPCA10Y = rs("cfg_valor")
                Case vHistFileIMAB5
                    HistFileIMAB5 = rs("cfg_valor")
                Case vHistFilePRE2Y
                    HistFilePre2Y = rs("cfg_valor")
                Case vHistFilePRE5Y
                    HistFilePre5Y = rs("cfg_valor")
                Case vHistFileDolar
                    HistFileDolar = rs("cfg_valor")
                Case vHistFileIDA
                    HistFileIDA = rs("cfg_valor")
                Case vHistFileRatingsTab
                    HistFileRatingsTab = rs("cfg_valor")
                Case vHistFileQuotaTab
                    HistFileQuotaTab = rs("cfg_valor")
                Case vEWMA
                    EWMA = rs("cfg_valor")
                Case vPosicFilePrefix
                    PosicFilePrefix = rs("cfg_valor")
                Case vPricingFilePrefix
                    PricingFilePrefix = rs("cfg_valor")
                Case vXMLANBIMAPath
                    XMLANBIMAPath = rs("cfg_valor")
                Case vXMLANBIMAPrefix
                    XMLANBIMAPrefix = rs("cfg_valor")
                Case vISINDATABASE
                    ISINDataBase = rs("cfg_valor")
                Case vRedemptionFilePath
                    RedemptionFilePath = rs("cfg_valor")
                Case vRedemptionFileName
                    RedemptionFileName = rs("cfg_valor")
                Case vRedemptionFileTab
                    RedemptionFileTab = rs("cfg_valor")
                Case vConcentrationFundID
                    ConcentrationFundID = rs("cfg_valor")
                Case vConcentrationProperty1
                    ConcentrationProp1 = rs("cfg_valor")
                Case vConcentrationProperty2
                    ConcentrationProp2 = rs("cfg_valor")
                Case vConcentrationProperty3
                    ConcentrationProp3 = rs("cfg_valor")
                Case vRedemptionFileTransferTab
                    RedemptionFileTransferTab = rs("cfg_valor")
                Case vShareFilePath
                    ShareFilePath = rs("cfg_valor")
                Case vShareFileName
                    ShareFileName = rs("cfg_valor")
                Case vNegsFilePrefix
                    NEGSFilePrefix = rs("cfg_valor")
                Case vEDFAAA
                    EDFAAA = rs("cfg_valor")
                Case vEDFAA
                    EDFAA = rs("cfg_valor")
                Case vEDFA
                    EDFA = rs("cfg_valor")
                Case vEDFBBB
                    EDFBBB = rs("cfg_valor")
                Case vEDFBB
                    EDFBB = rs("cfg_valor")
                Case vEDFB
                    EDFB = rs("cfg_valor")
                Case vEDFCCC
                    EDFCCC = rs("cfg_valor")
                Case vEDFAAA_ASK
                    EDFAAAask = rs("cfg_valor")
                Case vEDFAA_ASK
                    EDFAAask = rs("cfg_valor")
                Case vEDFA_ASK
                    EDFAask = rs("cfg_valor")
                Case vEDFBBB_ASK
                    EDFBBBask = rs("cfg_valor")
                Case vEDFBB_ASK
                    EDFBBask = rs("cfg_valor")
                Case vEDFB_ASK
                    EDFBask = rs("cfg_valor")
                Case vEDFCCC_ASK
                    EDFCCCask = rs("cfg_valor")
                Case vCreditRatingProperty
                    CreditRatingProperty = rs("cfg_valor")
                Case vIRBProperty
                    IRBRatingProperty = rs("cfg_valor")
                Case vLastRatingProperty
                    LastRatingProperty = rs("cfg_valor")
                Case vCredLGD
                    CredLGD = rs("cfg_valor")
                Case vCredLGDSec
                    CredLGDSec = rs("cfg_valor")
                Case vCredCorrel
                    CredCorrel = rs("cfg_valor")
                Case vCredCorrelIntra
                    CredCorrelIntra = rs("cfg_valor")
                Case vCredGroupProperty
                    CredGroupProperty = CritS(rs("cfg_valor"))
                Case vLVV
                    LVV = rs("cfg_valor")
                Case vLVQ
                    LVQ = rs("cfg_valor")
                Case vLVP
                    LVP = rs("cfg_valor")
                Case vLSV
                    LSV = rs("cfg_valor")
                Case vLSQ
                    LSQ = rs("cfg_valor")
                Case vLSP
                    LSP = rs("cfg_valor")
                Case vLEV
                    LEV = rs("cfg_valor")
                Case vLEQ
                    LEQ = rs("cfg_valor")
                Case vLEP
                    LEP = rs("cfg_valor")
                Case vLUV
                    LUV = rs("cfg_valor")
                Case vLUQ
                    LUQ = rs("cfg_valor")
                Case vLUP
                    LUP = rs("cfg_valor")
                Case vWarnAt20
                    WarnAt20 = rs("cfg_valor")
                Case vCRMDatabase
                    CRMDataBase = rs("cfg_valor")
                Case vRFETradeSheet
                    RFETradeSheet = rs("cfg_valor")
                Case vRFETradeTab
                    RFETradeTab = rs("cfg_valor")
                Case vFIIFileName
                    FIIFileName = rs("cfg_valor")
                Case vFIIFileTab
                    FIIFileTab = rs("cfg_valor")
                Case vFIIADTVTab
                    FIIADTVTab = rs("cfg_valor")
                Case vBlotterFileName
                    BlotterFileName = rs("cfg_valor")
                Case vRStress1
                    RStress1 = CritS(rs("cfg_valor"))
                Case vRStress2
                    RStress2 = CritS(rs("cfg_valor"))
                Case vRStress3
                    RStress3 = CritS(rs("cfg_valor"))
                Case vRStress4
                    RStress4 = CritS(rs("cfg_valor"))
                Case vRStress5
                    RStress5 = CritS(rs("cfg_valor"))
                Case vemail
                    email = CritS(rs("cfg_valor"))
                Case vsenha
                    Senha = CritS(rs("cfg_valor"))
            End Select

            rs.MoveNext
        Wend
        
        VaRConf = 2.33
        
    'Lê a mailing list
        Set rs = New ADODB.Recordset
        Call rs.open("SELECT * FROM TMAILINGLIST", db, adOpenForwardOnly, adLockReadOnly)
        While Not rs.EOF
            MailerN = MailerN + 1
            MailerNome(MailerN) = rs("nome")
            MailerMail(MailerN) = rs("email")
            MailerFunc(MailerN) = rs("Function")
            MailerList(MailerN) = rs("Lists")
            rs.MoveNext
        Wend
        
    'Lê constantes de liquidez
        Set CLiqStress = New Collection
        Set rs = New ADODB.Recordset
        Call rs.open("SELECT * FROM TLIQSTRESS", db, adOpenForwardOnly, adLockReadOnly)
        While Not rs.EOF
            Set u = New CNomeValor
            u.nome = rs("TIPO409")
            u.NomeAlt = rs("CONCENTRACAO")
            u.Valor = rs("Saque")
            CLiqStress.Add u
            rs.MoveNext
        Wend
        
    'Lê configurações das colunas do FFundo
        Set FFundoColumnNames = New Collection
        Set rs = New ADODB.Recordset
        Call rs.open("SELECT * FROM TConfigFFundoCols WHERE USERNAME='" + User.username + "'", db, adOpenForwardOnly, adLockReadOnly)
        While Not rs.EOF
            Set u = New CNomeValor
            u.nome = rs("ColumnName")
            FFundoColumnNames.Add u
            rs.MoveNext
        Wend
        
End Sub

Property Get MailerContactEmail(i As Integer) As String
    If i > 0 And i <= MailerN Then MailerContactEmail = MailerMail(i)
End Property

Property Get MailerContactFunction(i As Integer) As String
    If i > 0 And i <= MailerN Then MailerContactFunction = MailerFunc(i)
End Property

Property Get MailerContactList(i As Integer) As String
    If i > 0 And i <= MailerN Then MailerContactList = MailerList(i)
End Property

Property Get ConcentrationP(i As Integer) As String
    If i = 1 Then
        ConcentrationP = ConcentrationProp1
    ElseIf i = 2 Then
        ConcentrationP = ConcentrationProp2
    Else
        ConcentrationP = ConcentrationProp3
    End If
End Property


Property Get GetLiqStress(tipo409 As String, conc As String) As Double
    Dim x As CNomeValor
    For Each x In CLiqStress
        If x.nome = tipo409 And x.NomeAlt = conc Then GetLiqStress = x.Valor
    Next x
End Property



Public Function InsertFFundoCol(x As String) As Boolean
    Dim achou As Boolean, u As CNomeValor
    achou = False
    InsertFFundoCol = False
    For Each u In Config.FFundoColumnNames
        If u.nome = x Then achou = True
    Next u
    If Not achou Then
        Set u = New CNomeValor
        u.nome = x
        InsertFFundoCol = True
        WriteFFundoColDB
        Config.FFundoColumnNames.Add u
    End If
End Function


Public Function DeleteFFundoCol(N As Integer) As Boolean
    If N > 0 And N <= FFundoColumnNames.Count Then
        Config.FFundoColumnNames.remove N
        WriteFFundoColDB
        DeleteFFundoCol = True
    Else
        DeleteFFundoCol = False
    End If
    
End Function


Private Sub WriteFFundoColDB()
    Dim db As ADODB.Connection, rs As ADODB.Recordset, u As CNomeValor
    
    Set db = OpenTheDatabase
    
    db.Execute ("DELETE FROM TCONFIGFFUNDOCOLS WHERE USERNAME='" + User.username + "'")
    For Each u In FFundoColumnNames
        db.Execute ("INSERT INTO TCONFIGFFUNDOCOLS (USERNAME, COLUMNNAME) VALUES ('" + User.username + "','" + u.nome + "')")
    Next u
End Sub

