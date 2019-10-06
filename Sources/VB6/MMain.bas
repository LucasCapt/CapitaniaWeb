Attribute VB_Name = "MMain"
Public Const LongTimeAgo As Date = 36526

Private vConexao As ADODB.Connection

Public DBFileName As String
Public ConfigFileName As String
Public User As New CUser
Public EhBatch As Boolean
Public ehPreTrade As Boolean
Public MailMessage As String

Public Config As New CConfig

Public Props As New CPropriedades
Public Regras As New CRegras
Public Books As New CBooks
Public Papeis As New CPapeis
Public Fundos As New CFundos
Public Importer As New CImporter
Public Stress As New CStress
Public ComReporter As New C_CompReporter
Public Messenger As New C_Mensagens
Public RiskMgr As New CRisco
Public Emailer As New C_Emailer
Public Trades As New CTrades
Public CrNames As New CCreditNames
Public Debg As New C_Debugger

Public BaseDate As Date
Public MainStatus As String
Public TimeInit As Date

Public Const K_PropName1 = "* Class.Liquidez"
Public Const K_PropName2 = "* Class.Rentab."
Public Const K_PropName3 = "* Indexador"
Public Const K_PropName4 = "* Nome"
Public Const K_PropName5 = "* ISIN"
Public Const K_PropName6 = "* Cod.CETIP"
Public Const K_PropName10 = "# Duration"
Public Const K_PropName11 = "# ADTV"

Public GeneralTimer As Double
Public DebugFlag As Boolean
Public LastErrorTime As Date            'Data da Última Revisão de erro
Public NumErrors As Integer             'Número de erros desde a última revisão

'Public Const Ver = "2.95"                '25-Mar-2019
'Public Const Ver = "2.99"                '03-May-2019
'Public Const Ver = "2.100"               '06-May-2019
'Public Const Ver = "2.101"               '07-May-2019
'Public Const Ver = "2.102"               '09-May-2019
'Public Const Ver = "2.103"               '10-May-2019
'Public Const Ver = "2.104"               '13-May-2019
'Public Const Ver = "2.105"               '15-May-2019
'Public Const Ver = "2.106"               '20-May-2019
'Public Const Ver = "2.107"               '23-May-2019
'Public Const Ver = "2.108"               '28-May-2019
'Public Const Ver = "2.109"               '28-May-2019
'Public Const Ver = "2.110"               '04-Jun-2019
'Public Const Ver = "2.111"               '04-Jun-2019
'Public Const Ver = "2.112"               '10-Jun-2019
'Public Const Ver = "2.113"               '24-Jun-2019
'Public Const Ver = "2.114"               '26-Jun-2019
'Public Const Ver = "2.115"               '10-Jul-2019
'Public Const Ver = "2.116"               '15-Jul-2019
'Public Const Ver = "2.117"               '17-Jul-2019
'Public Const Ver = "2.118"               '18-Jul-2019
'Public Const Ver = "2.119"               '24-Jul-2019
'Public Const Ver = "2.120"               '30-Jul-2019
'Public Const Ver = "2.121"               '31-Jul-2019
'Public Const Ver = "2.122"               '02-Aug-2019
Public Const Ver = "2.123"               '13-Aug-2019

Sub Init()
    
    'Captions e FStart
        FStart.Caption = "Capitânia Enquadramento " + Ver
        FStart.Show vbModeless
        MainStatus = "LIVE"
    
    'Configurações Default
        DBFileName = "\\s07\Enquadramento\Enquadramento.accdb"
        EhBatch = False
        BaseDate = Now()
        
    'Verifica ambiente de Teste
        If FileExists("TestEnvironment.txt") Then DBFileName = "\\Capdc03\Tecnologia\DEVELOPER\ComplianceNew\EnquadramentoTest.accdb"
        
    'Lê usuário
        User.ReadDB
        
    If User.Cleared Then
    
        WriteLog "LOGIN"
        
        EhBatch = User.BatchUser Or Command$ <> "" 'qualquer diretiva = batch
        ehPreTrade = InStr(Command$, "p") > 0  'Pre-Trade Compliance usa a diretiva /p
        
        'Lê Configuração do Database
            FStart.Say ("Lendo Configuração da Base")
            Config.ReadConfig
        
        'Importação
            '(A importação é agnóstica sobre BaseDate)
            Importer.ImportaTudo User.Imports, EhBatch, ehPreTrade, FStart
            
        'Seta o ambiente do usuário
            SetEnvironTo User.acesso
            
        'Seta a data de hoje e recalcula tudo
            SetBaseDateTo Now()
        
        'Busca erros (warnings)
            Papeis.BuscaErros
            Fundos.BuscaErros
        
    Else
        MsgBox ("Acesso não autorizado")
        WriteLog "LOGIN FAILED"
    End If
    
    FStart.Hide
End Sub


Sub ResetAll(Optional f As Form)

    'Aqui todos lêem condicional à BaseDate
    
    If Not f Is Nothing Then f.Say ("Atualizando Risco")
    RiskMgr.Init
    If Not f Is Nothing Then f.Say ("Atualizando Nomes")
    CrNames.Init
    If Not f Is Nothing Then f.Say ("Lendo Propriedades")
    Props.ReadDB
    If Not f Is Nothing Then f.Say ("Lendo Regras")
    Regras.ReadDB
    If Not f Is Nothing Then f.Say ("Lendo Livros")
    Books.ReadDB
    If Not f Is Nothing Then f.Say ("Lendo Papéis")
    Papeis.ReadDB BaseDate
    If Not f Is Nothing Then f.Say ("Lendo Fundos")
    Fundos.ReadDB BaseDate, f
    If Not f Is Nothing Then f.Say ("Linkando Títulos")
    Papeis.Linka
    If Not f Is Nothing Then f.Say ("Lendo Stress")
    Stress.ReadDB
    If Not f Is Nothing Then f.Say ("Lendo Trades")
    Trades.ReadDB Fundos.Dt_OldestPortfolio, FStart
    Trades.ChecaAML
    Trades.ChecaRateio
    
    If Not f Is Nothing Then f.Say ("Recalculando")
    Fundos.Recalc
    Books.Recalc
    Papeis.Refresh 'sempre depois de fundos.recalc
        
    MainStatus = "LIVE"
    
    If User.Reports = 2 Or (User.Reports = 1 And Not JahReportouNoDia) Then
        ComReporter.GravaDB f
        FlagReportouNoDia
    End If
    
End Sub


Sub Main()
    TimeInit = Now()
    If Permisso Then
        Init
        If User.Cleared Then
            If EhBatch Then
                'Já processou. É batch. Envia e-mails e termina
                If User.Reports > 0 Then
                    If ehPreTrade Then
                        'Envia apenas o pre-trade compliance
                        WriteLog "EXECUTA PRETRADE"
                        Fundos.PreTradeCompliance (True)
                        WriteLog "REPORTA PRETRADE"
                        ComReporter.Report_PreTrade ("SYSTEM")
                        WriteLog "ENVIA E-MAILS PRETRADE"
                        MailMessage = Messenger.MessagePreTrade
                        Emailer.SendList MailMessage, "D", "RiskPreTrade"
                    Else
                        'E-mails de final de dia
                        WriteLog "ENVIA E-MAILS EOD"
                        'E-mail de Controle
                            MailMessage = Messenger.Message
                            Emailer.SendList MailMessage, "A", "RiskPointer"
                        'E-mail gerencial
                            MailMessage = Messenger.MessageGerencial
                            Emailer.SendList MailMessage, "B", "RiskGerencial"
                        'E-mail de erros
                            MailMessage = Messenger.MessageErrors
                            Emailer.SendList MailMessage, "C", "RiskErrors"
                    End If
                End If
                Termina
            Else
                'Modo interativo; mostra telas
                FMain.Caption = "Capitânia Enquadramento " + Ver
                FMain.FazStatusBar
                FMain.Show
                FProps.Show: FProps.Hide
                FRegras.Show: FRegras.Hide
                Fpapel.Show: Fpapel.Hide
                Select Case User.acesso
                    Case "TRADER"
                        FTrades.newshow
                    Case Else
                        FFundo.FirstShow Fundos.c(1)
                End Select
                FFundos.newshow
                FFundos.ZOrder (0)
                FMain.WindowState = 2
                FMain.Arrange (1)
            End If
        End If
    End If
End Sub


Sub Termina()
    Dim f As Form
    'Fecha todos os forms
    WriteLog "EXIT"
    For Each f In Forms
        Unload f
    Next f
End Sub

Private Function Permisso() As Boolean
    Permisso = FileExists("N:\keys\cl000001.txt")
End Function


Public Function ThereIsPositionForDate(d As Date) As Boolean
    Dim db As ADODB.Connection, rs As ADODB.Recordset
    
    Set db = OpenTheDatabase
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM TPOSIC WHERE DATA=" + SQLD(d), db, adOpenForwardOnly, adLockReadOnly)
    ThereIsPositionForDate = Not (rs.EOF)
    
End Function


Public Function TestaTrocaData(d As Date) As Boolean
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset, hacart As Boolean, resp As String
    
    If d <= Now() Then
        
        Set db = OpenTheDatabase
        'Procura Última Carteira
        Set rs1 = New ADODB.Recordset
        Call rs1.open("SELECT * FROM TPOSIC WHERE DATA=" + SQLD(d), db, adOpenForwardOnly, adLockReadOnly)
        hacart = Not rs1.EOF
        
        
        If hacart Then
            FStart.newshow ("Alterando data...")
            BaseDate = d
            FMain.FazStatusBar
            'FMain.StatusBar1.Panels(1) = Format(d, "dd-MMM-yyyy")
            ResetAll FStart
            TestaTrocaData = True
            FStart.Hide
        Else
            resp = FTentaImportar.showfor(d)
            Select Case resp
                Case "TXT"
                    Importer.ImportaPosicaoParaData d
                Case "XML"
                    Importer.ImportaXMLANBIMAparaData d
                    Importer.Layt22MainParaData d
                Case "ANYWAY"
                    TestaTrocaData = True
                    SetBaseDateTo d
                Case "CANCEL"
                    TestaTrocaData = False
            End Select
            
            If resp = "TXT" Or resp = "XML" Then
                'Se usuário escolheu importar, tenta ler novamente arquivos
                
                Set db = OpenTheDatabase
                Set rs1 = New ADODB.Recordset
                Call rs1.open("SELECT * FROM TPOSIC WHERE DATA=" + SQLD(d), db, adOpenForwardOnly, adLockReadOnly)
                hacart = Not rs1.EOF
                
                If hacart Then
                    SetBaseDateTo d
                    TestaTrocaData = True
                Else
                    MsgBox ("Importação não foi bem sucedida. Data não foi trocada")
                    TestaTrocaData = False
                End If
            End If
        End If
    Else
        MsgBox ("Não pode abrir data posterior ao dia de hoje")
        TestaTrocaData = False
    End If
End Function

Public Sub SetBaseDateTo(d As Date)
    FStart.newshow ("Alterando data...")
    BaseDate = Int(d)
    FMain.FazStatusBar
    ResetAll FStart
    FStart.Hide
End Sub


Public Sub EnterSimulation()
    FMain.Caption = "Capitânia Risk & Compliance " + Ver + " (MODO SIMULAÇÃO)"
    FMain.BackColor = &HFF00FF
    MainStatus = "SIMULADO"
    FMain.FazStatusBar
    WriteLog "INICIOU SIMULACAO"
End Sub

Public Sub ExitSimulation()
    FStart.newshow ("Resetando posições")
    ResetAll FStart
    FMain.Refaz
    FStart.Hide
    
    MaisStatus = "LIVE"
    FMain.BackColor = &H8000000C
    FMain.Caption = "Capitânia Risk & Compliance " + Ver
    FMain.FazStatusBar
    WriteLog "TERMINOU SIMULACAO"
End Sub


Public Function OpenTheDatabase(Optional ByVal pForceOpenConnection As Boolean = False) As ADODB.Connection

    If (pForceOpenConnection) Then
        If Not vConexao Is Nothing Then
            Call vConexao.Close
        End If
        Set vConexao = Nothing
    End If
    
    If vConexao Is Nothing Then
        Set vConexao = New ADODB.Connection
        Let vConnectionString = "Provider=SQLNCLI11;Server=Win10Dev;Database=db_capitania;Integrated Security=SSPI;DataTypeCompatibility=80"
        Call vConexao.open(vConnectionString)
    End If
    
    Set OpenTheDatabase = vConexao
    
End Function


Public Function OpenAndSetExcel(Excel As Object, FileName As String, FileTab As String) As Object
    Dim NomePuro As String, wb As Object, ws As Object, w1 As Object
    
    If Not Excel Is Nothing Then
        i = Len(FileName)
        While i > 1 And Mid(FileName, i, 1) <> "\": i = i - 1: Wend
        If Mid(FileName, i, 1) = "\" Then
            NomePuro = Right(FileName, Len(FileName) - i)
            For Each w1 In Excel.workbooks
                If w1.Name = NomePuro Then Set wb = w1
            Next w1
            If wb Is Nothing Then
                If FileSystem.Dir(FileName) <> "" Then _
                    Set wb = Excel.workbooks.open(FileName, 2, True, , , , True)
            End If
            If Not wb Is Nothing Then
                If FileTab = "\WORKBOOK" _
                    Then Set OpenAndSetExcel = wb _
                    Else Set OpenAndSetExcel = wb.worksheets(FileTab)
            End If
        End If
    End If
End Function

Public Sub SetEnvironTo(acesso As String)
    Dim u As Boolean
    u = (acesso = "CTRL")
    
    With FMain
        .mnuReimp.Enabled = u
        .mnuImportAll.Enabled = u
        .mnuImportXML.Enabled = u
        .mnuMudaData.Enabled = u
        .mnu_email.Enabled = u
        .mnuPapelTemplate.Enabled = u
        .mnumanu.Enabled = u
        
        .mnua_Papel_Edita.Enabled = u
        .mnua_Papel_Exclui.Enabled = u
        .mnua_Papel_Novo.Enabled = u
        .mnua_Papel_Cflow.Enabled = u
        
        .mnua_Fundo_Edita.Enabled = u
        .mnua_Fundo_Exclui.Enabled = u
        .mnua_Fundo_Novo.Enabled = u
        
        .mnua_Regra_Edita.Enabled = u
        .mnua_Regra_Exlcui.Enabled = u
        .mnua_Regra_NewBook.Enabled = u
        .mnua_Regra_Novo.Enabled = u
        
        .mnua_Prop_Edita.Enabled = u
        .mnua_Prop_Exclui.Enabled = u
        .mnua_Prop_Novo.Enabled = u
        
        .mnua_Book_Edita.Enabled = u
        .mnua_Book_Exclui.Enabled = u
        .mnua_Book_Novo.Enabled = u
    End With
               
End Sub

'----------------------------------------------------------------------------------------------------------------
'     R O T I N A S     H A R D C O D E D
'----------------------------------------------------------------------------------------------------------------

Sub exceptional_Old()
'   Esta rotina reprocessa carteiras entre duas datas

    Dim db As ADODB.Connection, rs As ADODB.Recordset, ds(500) As Date, N As Integer, f As CFundo
    
    FStart.Show


'   -------2 datas já presentes na HistRisk
    '    Set rs = db.Execute("SELECT DISTINCT DATARUN FROM THISTRISK WHERE DATARUN<=#12/04/2019# AND DATARUN>=#10/03/2018#")
    '    N = 0
    '    While Not rs.EOF
    '        N = N + 1
    '        ds(N) = rs("DATARUN")
    '        rs.MoveNext
    '    Wend
    '    db.Close

'   ------datas quaisquer
        N = 4
        ds(1) = DateSerial(2018, 7, 2)
        ds(2) = DateSerial(2018, 8, 31)
        ds(3) = DateSerial(2018, 10, 29)
        ds(4) = DateSerial(2018, 1, 18)
        ds(4) = DateSerial(2018, 1, 17)
        
    
    FStart.Say "Reprocessando"

    For i = 1 To N
        FStart.Say "Reimportando " + Format(ds(i), "dd-MMM-yyyy")
        Importer.ImportaXMLANBIMAparaData ds(i)
        Importer.Layt22MainParaData ds(i)
        SetBaseDateTo ds(i)
        'Grava
            FStart.Say "Gravando " + Format(ds(i), "dd-MMM-yyyy")
            
            '--Regrava todo o resultado de risco e compliance
                ComReporter.GravaDB
            
            '--Regrava apenas Risco de Mercado
                ' Set db = DBEngine.Workspaces(0).OpenDatabase(DBFileName)
                ' For Each f In Fundos.c
                '     db.Execute ("UPDATE THISTRISK SET VAR=" + Str(f.StaticVar) + ", STRESS=" + Str(f.StaticStress) + ", RISKMKTOK='" + f.IAmCompliantWithMarketRisk + "' WHERE FUNDO='" + f.nome + "' AND DATARUN=" + SQLD(ds(i)))
                ' Next f
                ' db.Close
    Next i
    FStart.Hide
End Sub


Sub exceptional()
    MsgBox ("Nenhuma macro programada para execução.")
End Sub

'----------------------------------------------------------------------------------------------------------------
'     F I M    D A S    R O T I N A S     H A R D C O D E D
'----------------------------------------------------------------------------------------------------------------

