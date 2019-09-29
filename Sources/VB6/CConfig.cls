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


Public Sub ReadConfig()
    Dim db As ADODB.Connection, rs As ADODB.Recordset
    
    
    Set db = OpenTheDatabase
    
    'Lê registro de configuração
        Set rs = db.Execute("SELECT * FROM TCONFIG")
        HistFilePath = rs("HistFilePath")
        HistFileName = rs("HistFileName")
        HistFileTab = rs("HistFileTab")
        HistfileIFIX = rs("HistFileIFIX")
        HistFileIPCA2Y = rs("HistfileIPCA2Y")
        HistFileIPCA5Y = rs("HistFileIPCA5Y")
        HistFileIPCA10Y = rs("HistFileIPCA10Y")
        HistFileIMAB5 = rs("HistFileIMAB5")
        HistFilePre2Y = rs("HistFilePre2Y")
        HistFilePre5Y = rs("HistFilePre5Y")
        HistFileDolar = rs("HistFileDolar")
        HistFileIDA = rs("HistFileIDA")
        HistFileRatingsTab = rs("HistFileRatingsTab")
        HistFileQuotaTab = rs("HistFileQuotaTab")
        
        EWMA = rs("EWMA")
        VaRConf = 2.33
        
        PosicFilePrefix = rs("PosicFilePrefix")
        PricingFilePrefix = rs("PricingFilePrefix")
        
        XMLANBIMAPath = rs("XMLANBIMAPath")
        XMLANBIMAPrefix = rs("XMLANBIMAPrefix")
        ISINDataBase = rs("ISINDATABASE")
        
        RedemptionFilePath = rs("RedemptionFilePath")
        RedemptionFileName = rs("RedemptionFileName")
        RedemptionFileTab = rs("RedemptionFileTab")
        
        ConcentrationFundID = rs("ConcentrationFundID")
        ConcentrationProp1 = rs("ConcentrationProperty1")
        ConcentrationProp2 = rs("ConcentrationProperty2")
        ConcentrationProp3 = rs("ConcentrationProperty3")

        RedemptionFileTransferTab = rs("RedemptionFileTransferTab")
        ShareFilePath = rs("ShareFilePath")
        ShareFileName = rs("ShareFileName")
        NEGSFilePrefix = rs("NegsFilePrefix")
        
        EDFAAA = rs("EDFAAA")
        EDFAA = rs("EDFAA")
        EDFA = rs("EDFA")
        EDFBBB = rs("EDFBBB")
        EDFBB = rs("EDFBB")
        EDFB = rs("EDFB")
        EDFCCC = rs("EDFCCC")
        
        EDFAAAask = rs("EDFAAA_ask")
        EDFAAask = rs("EDFAA_ask")
        EDFAask = rs("EDFA_ask")
        EDFBBBask = rs("EDFBBB_ask")
        EDFBBask = rs("EDFBB_ask")
        EDFBask = rs("EDFB_ask")
        EDFCCCask = rs("EDFCCC_ask")
        
        CreditRatingProperty = rs("CreditRatingProperty")
        IRBRatingProperty = rs("IRBProperty")
        LastRatingProperty = rs("LastRatingProperty")
        CredLGD = rs("CredLGD")
        CredLGDSec = rs("CredLGDSec")
        CredCorrel = rs("CredCorrel")
        CredCorrelIntra = rs("CredCorrelIntra")
        CredGroupProperty = CritS(rs("CredGroupProperty"))
                
        
        LVV = rs("LVV")
        LVQ = rs("LVQ")
        LVP = rs("LVP")
        LSV = rs("LSV")
        LSQ = rs("LSQ")
        LSP = rs("LSP")
        LEV = rs("LEV")
        LEQ = rs("LEQ")
        LEP = rs("LEP")
        LUV = rs("LUV")
        LUQ = rs("LUQ")
        LUP = rs("LUP")
        WarnAt20 = rs("WarnAt20")
        
        CRMDataBase = rs("CRMDatabase")
        RFETradeSheet = rs("RFETradeSheet")
        RFETradeTab = rs("RFETradeTab")
        
        'GenLvlDI = rs("GenLvlDI")
        'GenLvlInflation = rs("GenLvlInflation")
        
        FIIFileName = rs("FIIFileName")
        FIIFileTab = rs("FIIFileTab")
        FIIADTVTab = rs("FIIADTVTab")
        
        BlotterFileName = rs("BlotterFileName")
        
        RStress1 = CritS(rs("RStress1"))
        RStress2 = CritS(rs("RStress2"))
        RStress3 = CritS(rs("RStress3"))
        RStress4 = CritS(rs("RStress4"))
        RStress5 = CritS(rs("RStress5"))
        
        email = CritS(rs("Email"))
        Senha = CritS(rs("Senha"))
    
    'Lê a mailing list
        Set rs = db.Execute("SELECT * FROM TMAILINGLIST")
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
        Set rs = db.Execute("SELECT * FROM TLIQSTRESS")
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
        Set rs = db.Execute("SELECT * FROM TConfigFFundoCols WHERE USERNAME='" + User.username + "'")
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

