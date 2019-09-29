VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CRegra"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public ID As Integer
Public nome As String
Public MaxMin As String
Public Limite As Double
Public Warn As Double
Public Por As Boolean
Public Por_Prop As CPropriedade
Public PARA As Boolean
Public Para_prop As CPropriedade
Public Para_comp As String
Public Para_valor As String
Public Workflow As Integer
Public Aberta As Boolean
Public MovementRule As Boolean
Public ANDRule As Boolean
Public AND_prop As CPropriedade
Public AND_valor As String
Public AND_comp As String
Public AND2Rule As Boolean
Public AND2_prop As CPropriedade
Public AND2_valor As String
Public AND2_comp As String
Public AND3Rule As Boolean
Public AND3_prop As CPropriedade
Public AND3_valor As String
Public AND3_comp As String
Public Conector As Boolean
'Public RefIssue As Boolean
Public Issue_Prop As CPropriedade
Public Escopo As String
'Public Issue_Quant As Boolean
Public Lim_Ref As String


Public FundosAplicN As Integer
Public BooksAplicN As Integer

Property Get CompliantGivenPL(pl As Double) As String
    If MaxMin = "MAX" Then
        If pl <= Warn Then
            CompliantGivenPL = "OK"
        ElseIf pl <= Limite Then
            CompliantGivenPL = "WARN"
        ElseIf MovementRule And MainStatus = "LIVE" Then
            CompliantGivenPL = "WARN"
        Else
            CompliantGivenPL = "BREACH"
        End If
    Else
        If pl >= Warn Then
            CompliantGivenPL = "OK"
        ElseIf pl >= Limite Then
            CompliantGivenPL = "WARN"
        ElseIf MovementRule And MainStatus = "LIVE" Then
            CompliantGivenPL = "WARN"
        Else
            CompliantGivenPL = "BREACH"
        End If
    End If
End Property



Public Sub WriteDB()
    Dim db As ADODB.Connection, rs As ADODB.Recordset, sbPor As String, sMov As String, sPara As String, order As String, SpPara As String, SpPor As String
    Dim sbAND As String, spand As String, sissue As String, sbissue As String, dst As String, sbquant As String, sbConector As String
    Dim sbAND2 As String, spand2 As String, sbAND3 As String, spand3 As String
    
    If MainStatus = "LIVE" Then
        
        Set db = OpenTheDatabase
        Set rs = db.Execute("SELECT * FROM TREGRAS WHERE ID=" + Str(Me.ID))
        If Not rs.EOF Then
            rs.Close
            db.Execute ("DELETE FROM TREGRAS WHERE ID=" + Str(Me.ID))
        Else
            rs.Close
        End If
        
        If Me.Por Then sbPor = "TRUE" Else sbPor = "FALSE"
        If Me.PARA Then sbPara = "TRUE" Else sbPara = "FALSE"
        
        If Me.ANDRule Then sbAND = "TRUE" Else sbAND = "FALSE"
        If Me.AND2Rule Then sbAND2 = "TRUE" Else sbAND2 = "FALSE"
        If Me.AND3Rule Then sbAND3 = "TRUE" Else sbAND3 = "FALSE"
        If Me.Conector Then sbConector = "TRUE" Else sbConector = "FALSE"
        
        If Me.Aberta Then sbAb = "TRUE" Else sbAb = "FALSE"
        If Me.MovementRule Then sMov = "TRUE" Else sMov = "FALSE"
        sbissue = "FALSE" 'Versão nova usa LIM_REF
        sbquant = "FALSE" 'Versão nova usa LIM_REF
        
        dst = "" + SQLBaseDate + ""
        If Me.Por_Prop Is Nothing Then SpPor = "0" Else SpPor = Str(Me.Por_Prop.ID)
        If Me.Para_prop Is Nothing Then SpPara = "0" Else SpPara = Str(Me.Para_prop.ID)
        If Me.AND_prop Is Nothing Then spand = "0" Else spand = Str(Me.AND_prop.ID)
        If Me.AND2_prop Is Nothing Then spand2 = "0" Else spand2 = Str(Me.AND2_prop.ID)
        If Me.AND3_prop Is Nothing Then spand3 = "0" Else spand3 = Str(Me.AND3_prop.ID)
        If Me.Issue_Prop Is Nothing Then sissue = "0" Else sissue = Str(Me.Issue_Prop.ID)
        
        order = "INSERT INTO TREGRAS (ID, NOME, MAXMIN, LIMITE, POR, POR_PROP, PARA, PARA_PROP, PARA_VALOR, WORKLOW, WARN, PARA_COMP, ABERTA, MOVEMENTRULE, " + _
            "ANDRULE, AND_PROP, AND_VALOR, AND_COMP, CONECTOR, AND2RULE, AND2_PROP, AND2_VALOR, AND2_COMP,AND3RULE, AND3_PROP, AND3_VALOR, AND3_COMP, REFISSUE, ISSUE_PROP, DT_CREATED, DT_DELETED, DELETED, ESCOPO, ISSUE_QUANT, LIM_REF) " + _
            "VALUES (" + Str(Me.ID) + ", '" + Me.nome + "', '" + Me.MaxMin + "'," + Str(Me.Limite) + ", " + sbPor + ", " + SpPor + ", " + sbPara + ", " + SpPara + _
            ", '" + Para_valor + "', 0, " + Str(Me.Warn) + ", '" + Me.Para_comp + "', " + sbAb + ", " + sMov + _
            ", " + sbAND + ", " + Str(spand) + ", '" + AND_valor + "','" + AND_comp + "'," + sbConector + _
            ", " + sbAND2 + ", " + Str(spand2) + ", '" + AND2_valor + "','" + AND2_comp + "'" + _
            ", " + sbAND3 + ", " + Str(spand3) + ", '" + AND3_valor + "','" + AND3_comp + "'" + _
            ", " + sbissue + ", " + sissue + "," + dst + "," + dst + ", FALSE,'" + Me.Escopo + "'," + sbquant + ",'" + Me.Lim_Ref + "')"
        
        db.Execute order
        
        
    End If
End Sub

Property Get Extensa() As String
    Dim a As String, a1 As String
    a = MaxMin + " " + FormatLimit(Me.Limite, Me)
    If Me.Conector Then a1 = " OU " Else a1 = " E "
    If Me.Lim_Ref = "ISSUEQ" Or Me.Lim_Ref = "ISSUEV" Then a = a + " da emissão"
    If Me.Por Then a = a + " POR CADA " + Me.Por_Prop.nome
    If Me.PARA Then a = a + " DE " + Me.Para_prop.nome + " " + Me.Para_comp + " " + Me.Para_valor
    If Me.ANDRule Then a = a + a1 + Me.AND_prop.nome + " " + Me.AND_comp + " " + Me.AND_valor
    If Me.AND2Rule Then a = a + " E " + Me.AND2_prop.nome + " " + Me.AND2_comp + " " + Me.AND2_valor
    If Me.AND3Rule Then a = a + " E " + Me.AND3_prop.nome + " " + Me.AND3_comp + " " + Me.AND3_valor
    If Me.MovementRule Then a = a + " (na movimentação)"
    Extensa = a
End Property


Property Get LimiteExtenso() As String
    LimiteExtenso = MaxMin + " " + FormatLimit(Limite, Me)
End Property

Property Get FundosAplic() As Collection
    Dim fd As CFundo, bk As CBook, rl As CRegra, u As CNomeValor
    Dim a As Collection
    Set a = New Collection
    For Each fd In Fundos.c
        For Each bk In fd.MyBooks
            For Each rl In bk.c
                If rl Is Me Then
                    Set u = New CNomeValor
                    u.nome = fd.nome
                    u.NomeAlt = bk.nome
                    a.Add u
                End If
            Next rl
        Next bk
    Next fd
    Set FundosAplic = a
End Property

Property Get BooksAplic() As Collection
    Dim fd As CFundo, bk As CBook, rl As CRegra, u As CNomeValor
    Dim a As Collection
    Set a = New Collection
    For Each bk In Books.c
        For Each rl In bk.c
            If rl Is Me Then
                Set u = New CNomeValor
                u.nome = bk.nome
                a.Add u
            End If
        Next rl
    Next bk
    Set BooksAplic = a
End Property


Public Sub CloneFrom(x As CRegra)
    Me.Aberta = x.Aberta
    Me.AND_comp = x.AND_comp
    Set Me.AND_prop = x.AND_prop
    Me.AND_valor = x.AND_valor
    Me.ANDRule = x.ANDRule
    
    Me.AND2_comp = x.AND2_comp
    Set Me.AND2_prop = x.AND2_prop
    Me.AND2_valor = x.AND2_valor
    Me.AND2Rule = x.AND2Rule
    
    Me.AND3_comp = x.AND3_comp
    Set Me.AND3_prop = x.AND3_prop
    Me.AND3_valor = x.AND3_valor
    Me.AND3Rule = x.AND3Rule
    
    Me.Escopo = x.Escopo
    Set Me.Issue_Prop = x.Issue_Prop
    Me.Lim_Ref = x.Lim_Ref
    Me.Limite = x.Limite
    Me.MaxMin = x.MaxMin
    Me.MovementRule = x.MovementRule
    Me.PARA = x.PARA
    Me.Para_comp = x.Para_comp
    Set Me.Para_prop = x.Para_prop
    Me.Para_valor = x.Para_valor
    Me.Por = x.Por
    Set Me.Por_Prop = x.Por_Prop
    Me.Warn = x.Warn
    Me.Workflow = x.Workflow
End Sub
