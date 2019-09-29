VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CFundos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public c As New Collection


Public Sub ReadDB(Data1 As Date, Optional f As Form)
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset, x As CFundo
    Dim pl As Double, a As Double, d As Date, b As Date, mxdata As Date
    Dim PlHist(2000) As Double, PLData(2000) As Date, i As Integer, NPL As Integer, PLMedio As Double
    Dim t0 As Date, td As Double, ti As Integer, t1 As Double, t2 As Double, t3 As Double, t4 As Double, t5 As Double, t6 As Double, t7 As Double, ttt As Double
    Dim AllQuotas As Variant, AllMaxDates As Variant
        
    GeneralTimer = 0
    t0 = Timer: ti = 0
    Set c = New Collection
    
    Set db = OpenTheDatabase
    
    'Lê todas as séries de quotas
    tt = Timer
    Set rs = db.Execute("SELECT * FROM TQUOTAS WHERE DATA<=" + SQLBaseDate + " AND DATA>=" + SQLD(BaseDate - 365) + " ORDER BY FUNDO, DATA")
    AllQuotas = rs.GetRows(rs.RecordCount)
    t6 = t6 + (Timer - tt)
    
    'Lê todas as últimas datas
    tt = Timer
    Set rs = db.Execute("SELECT DISTINCT FUNDO, MAX(DATA) FROM TPOSIC WHERE DATA<=" + SQLD(Data1) + " GROUP BY FUNDO")
    AllMaxDates = rs.GetRows(rs.RecordCount)
    t2 = t2 + Timer - tt
        
    'Lê os fundos
    Set rs = db.Execute("SELECT * FROM TFUNDOS WHERE DT_CREATED<=" + SQLBaseDate + " AND NOT (DELETED AND DT_DELETED<=" + SQLBaseDate + ") ORDER BY NOME")
    If Not rs.EOF Then rs.MoveFirst
    While Not rs.EOF
        Set x = New CFundo
        x.nome = rs("Nome")
        
        'If Not f Is Nothing Then f.say "Lendo fundos " + x.Nome
               
        x.ID = rs("ID")
        x.CNPJ = rs("CNPJ")
        x.qualif = CritS(rs("qualif"))
        x.IDTitulo = CritS(rs("IDTITULO"))
        x.Consol = CritS(rs("CONSOLIDATION"))
        If IsNull(rs("LIQNOME")) Then x.nomeLiq = "" Else x.nomeLiq = rs("LIQNOME")
        x.Tipo = CritS(rs("TIPO"))
        x.PrazoResgate = CritN(rs("PrazoResgate"))
        x.CaixaMandato = CritNN(rs("CaixaMandato"))
        x.OverrideLimit = rs("OverrideLimits")
        x.LIM_VaR = CritNN(rs("LIM_VAR"))
        x.LIM_Stress = CritNN(rs("LIM_Stress"))
        x.LIM_EL = CritNN(rs("LIM_EL"))
        x.LIM_UL = CritNN(rs("LIM_UL"))
        x.LIM_Dur = CritNN(rs("LIM_DUR"))
        x.Concentracao = rs("Concentracao")
        x.tipo409 = CritS(rs("Tipo409"))
        x.LimCredReg = rs("CredLimRegulam")
        x.area = CritS(rs("Area"))
        x.Dt_Created = rs("DT_CREATED")
        x.LiqMethod = CritS(rs("LIQMETHOD"))
        x.Tolerancia1 = CritN(rs("TOLERANCIA1"))
        x.Tolerancia2 = CritN(rs("TOLERANCIA2"))
        x.nomeBlotter = CritS(rs("NOMEBLOTTER"))
        x.Rule_NoDayTrd = rs("RULE_NODAYTRD")
        x.Rule_NoCrssTrd = rs("RULE_NOCRSSTRD")
        
        x.Favorit_Cash = rs("FAVORIT_CASH")
        x.Favorit_Credit = rs("FAVORIT_CREDIT")
        x.Favorit_Mkt = rs("FAVORIT_MKT")
                
        'Le livros de regras
            tt = Timer
            Set rs1 = db.Execute("SELECT * FROM TFUNDOBOOK WHERE FUNDO=" + Str(rs("ID")))
            If Not rs1.EOF Then rs1.MoveFirst
            While Not rs1.EOF
                x.AddNewBook (rs1("Book"))
                rs1.MoveNext
            Wend
            rs1.Close
            t1 = t1 + (Timer - tt)
        
        'Le Carteira
            'Esta rotina demora
            tt = Timer
            'Procura a última data no vetor
                x.Dt_LastPortfolio = LongTimeAgo
                For i = 0 To UBound(AllMaxDates, 2)
                    If AllMaxDates(0, i) = x.ID Then x.Dt_LastPortfolio = AllMaxDates(1, i)
                Next i
                    
            'Le a carteira
            If x.Dt_LastPortfolio > LongTimeAgo Then
                Set rs1 = db.Execute("SELECT * FROM TPOSIC WHERE FUNDO=" + Str(rs("ID")) + " AND DATA=" + SQLD(x.Dt_LastPortfolio) + " ORDER BY VALOR DESC")
                rs1.MoveFirst
                While Not rs1.EOF
                    x.IncluiPosic rs1("Papel"), CritNN(rs1("Valor")), CritNN(rs1("Quant")), False, "AUTO_TIPO_1"
                    rs1.MoveNext
                Wend
                rs1.Close
            Else
                x.Dt_LastPortfolio = 0
            End If
            x.Dt_LastInfo = x.Dt_LastPortfolio
            t2 = t2 + (Timer - tt)
        
        
        'Le fila de resgate
            tt = Timer
            x.ResetResgate
            Set rs1 = db.Execute("SELECT * FROM TRESGATES WHERE FUNDO='" + x.nomeLiq + "' AND DATAOBS<=" + SQLBaseDate + " AND DATALIQ>" + SQLBaseDate + " AND (NOT CANCELADO OR DATACANCEL>" + SQLBaseDate + ")")
            While Not rs1.EOF
                x.InlcluiResgate rs1("DATALIQ"), rs1("VALOR"), rs1("TOTAL"), rs1("DATAOBS")
                rs1.MoveNext
            Wend
            rs1.Close
            
        'Le fila de transferências
            x.ResetTransf
            Set rs1 = db.Execute("SELECT * FROM TTRANSFERS WHERE FUNDO='" + x.nomeLiq + "' AND DATAOBS<=" + SQLBaseDate + " AND DATALIQ>" + SQLBaseDate + " AND (NOT CANCELADO OR DATACANCEL>" + SQLBaseDate + ")")
            While Not rs1.EOF
                x.InlcluiTransf rs1("DATALIQ"), rs1("VALOR")
                rs1.MoveNext
            Wend
            rs1.Close
            t3 = t3 + (Timer - tt)
        
        'Calcula Volatilidade do Patrimônio Líquido e guarda a série de PL
            'esta parte demora
            tt = Timer
            Set rs1 = db.Execute("SELECT * FROM THISTRISK WHERE FUNDO='" + x.nome + "' AND DATARUN>=" + SQLD(BaseDate - 1440) + " AND DATARUN<=" + SQLBaseDate + " AND DAY(DATARUN)>26 ORDER BY DATARUN")
            NPL = 0
            If rs1.EOF Then
                x.VolPL = 0
            Else
                pl = rs1("PL")
                d = rs1("DATARUN")
                rs1.MoveNext
                soma = 0
                somasq = 0
                N = 0
                While Not rs1.EOF
                    a = rs1("PL")
                    b = rs1("DATARUN")
                    NPL = NPL + 1
                    PlHist(NPL) = a
                    PLData(NPL) = b
                    If a > 0 And pl > 0 And Month(b) <> Month(d) Then
                        'If a < pl Then
                            soma = soma + Log(a / pl)
                            somasq = somasq + Log(a / pl) ^ 2
                        'End If
                        pl = a
                        N = N + 1
                    End If
                    pl = a
                    d = b
                    rs1.MoveNext
                Wend

                If N > 1 Then
                    x.VolPL = min(0.75, Sqr((somasq - (soma * soma) / N) / (N - 1)) * Sqr(12))
                Else
                    x.VolPL = 0
                End If
            End If
            t4 = t4 + (Timer - tt)
            
        'Calcula Volatilidade do Resgate
            tt = Timer
            Set rs1 = db.Execute("SELECT DATALIQ, SUM(VALOR) AS TTVALUE FROM TRESGATES WHERE FUNDO='" + x.nomeLiq + "' AND DATAOBS>=" + SQLD(BaseDate - 1440) + " AND DATAOBS<=" + SQLBaseDate + " AND NOT CANCELADO GROUP BY DATALIQ ORDER BY DATALIQ")
            If rs1.EOF Or NPL = 0 Then
                x.VolResg = 0
            Else
                'Calcula pl médio p/ default
                    soma = 0
                    For i = 1 To NPL
                        soma = soma + PlHist(i)
                    Next i
                    PLMedio = soma / NPL
                    
                'Faz
                soma = 0
                somasq = 0
                N = 0
                i = 1
                b = rs1("DATALIQ")
                b1 = b
                rs1.MoveNext

                While Not rs1.EOF
                    a = rs1("TTVALUE")
                    b = rs1("DATALIQ")
                    While i < NPL And PLData(i) < b: i = i + 1: Wend
                    If i >= NPL Then
                        If PlHist(NPL) = 0 Then a = a / PlHist(NPL - 1) Else a = a / PlHist(NPL)
                    ElseIf PlHist(i) <= 0 Then
                        a = a / PLMedio
                    Else
                        a = a / PlHist(i)
                    End If

                    soma = soma + a / Sqr(b - b1)
                    somasq = somasq + a ^ 2 / (b - b1)
                    b1 = b
                    rs1.MoveNext
                    N = N + 1
                Wend
                If N > 1 Then
                    x.VolResg = Sqr((somasq - (soma * soma) / N) / (N - 1)) * Sqr(365)
                Else
                    x.VolResg = 0
                End If
            End If
            t5 = t5 + (Timer - tt)
            
            
        'Obtem concentração do maior cotista
            tt = Timer
            Set rs1 = db.Execute("SELECT MAX (DATAOBS) AS MAXDATA FROM TMAIORCOTISTA WHERE FUNDO='" + x.nomeLiq + "' AND DATAOBS<=" + SQLBaseDate)
            If Not rs1.EOF Then
                If Not IsNull(rs1("MAXDATA")) Then
                    mxdata = rs1("MAXDATA")
                    Set rs1 = db.Execute("SELECT * FROM TMAIORCOTISTA WHERE FUNDO='" + x.nomeLiq + "' AND DATAOBS=" + SQLD(mxdata))
                    If Not rs1.EOF Then
                        x.MaiorCotista = rs1("MAXCOT1")
                    End If
                End If
            End If
            If mxdata < BaseDate - 30 Then WriteLogError "Maior cotista desatualizado 30+ dias", Format(mxdata, "DD-MMM-YYYY")
            rs1.Close
            t3 = t3 + (Timer - tt)
            
        'Lê a série de quotas
            tt = Timer
            x.GetYourQuotasIn AllQuotas
            t6 = t6 + (Timer - tt)
            
        c.Add x
        ti = ti + 1
        rs.MoveNext
        
    Wend
    
    
    td = (Timer - t0)
    WriteLogPerf "LE_FUNDOS", ti, td
    WriteLogPerf "LE_FUNDOS_Regras", ti, t1
    WriteLogPerf "LE_FUNDOS_Carteira", ti, t2
    WriteLogPerf "LE_FUNDOS_Cotistas", ti, t3
    WriteLogPerf "LE_FUNDOS_VolPL", ti, t4
    WriteLogPerf "LE_FUNDOS_VolResg", ti, t5
    WriteLogPerf "LE_FUNDOS_Quotas", ti, t6
End Sub

Public Function search(x As Integer) As CFundo
    Dim y As CFundo
    For Each y In c
        If y.ID = x Then Set search = y
    Next y
End Function

Public Function searchCNPJ(x As String) As CFundo
    Dim y As CFundo
    For Each y In c
        If y.CNPJ = x Then Set searchCNPJ = y
    Next y
End Function


Public Function searchName(x As String) As CFundo
    Dim y As CFundo
    For Each y In c
        If y.nome = x Then Set searchName = y
    Next y
End Function

Public Function searchNameBlotter(x As String) As CFundo
    Dim y As CFundo
    For Each y In c
        If y.nomeBlotter = x Then Set searchNameBlotter = y
    Next y
End Function

Public Function searchIDTitulo(x As String) As CFundo
    Dim y As CFundo
    For Each y In c
        If y.IDTitulo = x Then Set searchIDTitulo = y
    Next y
End Function


Public Function Cria(x As String) As CFundo
    Dim db As ADODB.Connection, rs As ADODB.Recordset, y As CFundo, LastNumber As Integer
    
    If MainStatus = "LIVE" Then
        
        Set db = OpenTheDatabase
        Set rs = db.Execute("SELECT MAX (ID) AS MAXID FROM TFUNDOS")
        If rs.EOF Then LastNumber = 0 Else LastNumber = rs("MAXID")
        rs.Close
            
        db.Execute ("INSERT INTO TFUNDOS (ID, NOME, CNPJ, QUALIF, IDTITULO, DT_CREATED, DT_DELETED, DELETED) VALUES (" + Str(LastNumber + 1) + ",'" + x + "', '', FALSE, '', " + SQLBaseDate + "," + SQLBaseDate + ",FALSE)")
        
        
        Set y = New CFundo
        y.ID = LastNumber + 1
        y.nome = x
        c.Add y
        Set Cria = y
    End If
        
    End Function

Public Sub HighLevelCria()
    Dim xnome As String, x As CFundo
    xnome = FInput.Pergunte("Nome do Fundo a ser criado:")
    If xnome <> "" Then
        If searchName(xnome) Is Nothing Then
            Set x = Cria(xnome)
            x.Dt_Created = BaseDate
            x.LiqMethod = "ANBIMA"
            FEditFund.showfor x
        Else
            MsgBox ("Nome já existente.")
        End If
    End If
End Sub


Public Sub ExcluiFundo(x As CFundo)
    Dim db As ADODB.Connection, rs As ADODB.Recordset, y As CFundo
    
    If MainStatus = "LIVE" Then
        
        Set db = OpenTheDatabase
        db.Execute ("UPDATE TFUNDOS SET DELETED=TRUE, DT_DELETED=" + SQLBaseDate + " WHERE ID=" + Str(x.ID))
    End If
    
    For i = 1 To c.Count - 1
        If c(i) Is x Then c.remove i
    Next i
End Sub


Public Function TypeReportsLiquidity(x As String, area As String) As Boolean
    'TypeReportsLiquidity = Not (x = "CONS" Or x = "CLOSED" Or x = "EXCLUSIVO" Or x = "RESTRITO" Or area = "EXTERNO")
    'TypeReportsLiquidity = Not (x = "CONS" Or x = "CLOSED" Or x = "EXCLUSIVO" Or area = "EXTERNO")
    TypeReportsLiquidity = Not (x = "CONS" Or x = "CLOSED" Or area = "EXTERNO")
End Function


Public Sub FillComboListWithNomes(ByRef x As Object)
    Dim f As CFundo
    x.Clear
    For Each f In c
        x.AddItem f.nome
    Next f
End Sub

Public Sub ResetPreTradeCompl()
    Dim f As CFundo
    For Each f In c
        f.PTCExecuted = False
    Next f
End Sub

Public Sub Recalc()
    Dim f As CFundo
    Dim ti As Integer, t0 As Date, td As Double
    t0 = Timer: ti = 0
    
    For Each f In c
        f.Consolida
    Next f
    
    For Each f In c
        f.Recalc
        ti = ti + 1
    Next f
    
    Books.Recalc 'Refaz referências de books e regras
    ResetPreTradeCompl
    
    'Verifica se há erros
        MMath.AtualizaErros
    td = (Timer - t0)
    WriteLogPerf "RECALC_ALL", ti, td
End Sub

Public Sub RecalcRisk()
    Dim f As CFundo
    Dim ti As Integer, t0 As Date, td As Double
    
    t0 = Timer: ti = 0
    For Each f In c
        f.Recalc
        ti = ti + 1
    Next f
    
    ResetPreTradeCompl
    
    'Verifica se há erros
        MMath.AtualizaErros
    td = (Timer - t0)
    WriteLogPerf "RECALC_RISK", ti, td
End Sub

Public Sub RecalcWRespectTo(pp As CPapel)
    Dim f As CFundo
    Dim ti As Integer, t0 As Date, td As Double
    
    t0 = Timer: ti = 0
    For Each f In c
        If f.PplIHavePaper(pp) Then
            f.Recalc
            ti = ti + 1
        End If
    Next f
    td = (Timer - t0)
    'Verifica se há erros
        MMath.AtualizaErros
    WriteLogPerf "RECALC_PART", ti, td
End Sub


Property Get Dt_LastInfo() As Date
    'Retorna a data mais RECENTE para a qual ALGUM fundo tem informação (carteira+trade)
    Dim f As CFundo, d As Date
    d = LongTimeAgo
    For Each f In c
        If f.Dt_LastInfo > d Then d = f.Dt_LastInfo
    Next f
    Dt_LastInfo = d
End Property

Property Get Dt_OldestPortfolio()
    'Retorna a data mais antiga em que ALGUM fundo tem carteira
    Dim f As CFundo, d As Date
    d = Now()
    For Each f In c
        If f.Dt_LastPortfolio < d And f.Tipo <> "CONS" And f.area <> "EXTERNO" Then d = f.Dt_LastPortfolio
    Next f
    d = max(d, BaseDate - 10)
    Dt_OldestPortfolio = d
End Property


Public Sub BuscaErros()
    Dim f As CFundo
    For Each f In c
        If f.MyQuotas.Count = 0 And f.area <> "EXTERNO" And f.Tipo <> "CONS" And f.tipo409 <> "EXT" Then _
            WriteLogError "Warn: Fundo sem histórico de quotas (??)", f.nome
    Next f
End Sub


Public Sub PreTradeCompliance(Mandatory As Boolean, Optional Form1 As Form)
    Dim f As CFundo, t0 As Double, ti As Double, N As Integer
    t0 = Now()
    N = 0
    For Each f In c
        If Not Form1 Is Nothing Then Form1.Say ("Executando Pré-Trade Compliance - " + f.nome)
        If Not f.PTCExecuted Or Mandatory Then
            f.PreTradeCompliance
            N = N + 1
        End If
    Next f
    ti = (Now() - t0) * 24 * 3600
    WriteLogPerf "RECALC_PTC", N, ti
End Sub
