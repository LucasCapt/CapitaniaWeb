VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CTrades"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public CTrades As Collection
Public CTodayTrades As Collection
Public cctpts As Collection
Public cAlloc As Collection

Public Sub ReadDB(FromDate As Date, Optional f As Form)
    Dim db As ADODB.Connection, rs As ADODB.Recordset, x As CTrade, y As CCtpt
    
    If Not f Is Nothing Then f.Say ("Lendo Trades")
    
    
    Set db = OpenTheDatabase
    
    'Lê Ctpts
        Set cctpts = New Collection
        Set rs = New ADODB.Recordset
        Call rs.open("SELECT * FROM TCTPT", db, adOpenForwardOnly, adLockReadOnly)
        If Not rs.EOF Then rs.MoveFirst
        While Not rs.EOF
            Set y = New CCtpt
            y.ID = rs("ID")
            y.nome = rs("nome")
            y.RazaoSocial = CritS(rs("razaosocial"))
            y.CNPJ = CritS(rs("CNPJ"))
            y.Administrador = CritS(rs("Administrador"))
            y.CNPJADM = CritS(rs("CNPJADM"))
            y.Procuradores = CritS(rs("Procuradores"))
            y.CNPJProc = CritS(rs("CNPJProc"))
            y.Endereco = CritS(rs("Endereco"))
            y.Telefone = CritS(rs("Telefone"))
            y.email = CritS(rs("email"))
            y.Atividade = CritS(rs("Atividade"))
            y.PerfilRisco = CritS(rs("PerfilRisco"))
            y.Atualizado = CritD(rs("Atualizado"))
            cctpts.Add y
            rs.MoveNext
        Wend
    
    'Lê Trades
        Set CTrades = New Collection
        Set CTodayTrades = New Collection
        Set rs = New ADODB.Recordset
        Call rs.open("SELECT * FROM TTRADES WHERE DATA >= " + SQLD(FromDate) + " AND DATA <=" + SQLBaseDate + " ORDER BY FUNDO, ATIVO, CV", db, adOpenForwardOnly, adLockReadOnly)
        If Not rs.EOF Then rs.MoveFirst
        While Not rs.EOF
            Set x = New CTrade
            x.ID = rs("ID")
            x.Fundo = rs("fundo")
            x.Ativo = rs("ativo")
            x.CV = rs("CV")
            x.Quant = rs("quant")
            x.Data = rs("data")
            x.Taxa = rs("taxa")
            x.PU = rs("PU")
            x.Produto = rs("Produto")
            x.Broker = CritS(rs("BROKER"))
            x.NomeAtivo = CritS(rs("NOMEATIVO"))
            x.ValFin = CritNN(rs("ValFin"))
            x.Hora = CritD(rs("Hora"))
            x.Hora_ms = CritNN(rs("HORA_MS"))
            
            If x.ValFin = 0 Then x.ValFin = x.Quant * x.PU
            x.Endereca
            CTrades.Add x
            If x.Data = BaseDate Then CTodayTrades.Add x
            rs.MoveNext
        Wend
        
        'Reporta o status dos Trades
        ComReporter.report_Blotter

End Sub


Public Sub EnderecaForFund(x As CFundo)
    Dim y As CTrade
    x.ResetTrades
    For Each y In CTrades
        If y.Fundo = x.nomeBlotter Then y.Endereca
    Next y
End Sub

Public Sub ChecaAML()
    'verifica se os preços estão dentro do túnel
    Dim p(1000) As Double, t(1000) As Date, N As Integer, q As String, Comparavel As Double
    Dim db As ADODB.Connection, rs As ADODB.Recordset, x As CTrade, y As CTrade
    Dim Sxy As Double, Sx As Double, Sy As Double, Sx2 As Double
    
    Dim Bh As Double, Bl As Double, Bh2 As Double, Bl2 As Double, bh0 As Double, bl0 As Double
    
    
    Set db = OpenTheDatabase
    
    For Each x In CTodayTrades
        'Roda apenas sobre os trades de hoje
        
        If x.Exempt Then
            '-------Ativos Isentos-----------
            x.Compliant = "OK"
            x.BandaHigh = 0
            x.BandaLow = 0
            x.BandaHigh2 = 0
            x.BandaLow2 = 0
            x.Points = 0
            x.ExtPoints = 0
        Else
        
            'Ativos não isentos - fazer banda
            If Left(x.Ativo, 13) = "Compromissada" Or Left(x.Ativo, 4) = "FUT " Then
                q = "TAXA": x.Comparavel = x.Taxa
            Else
                q = "PU": x.Comparavel = x.PU
            End If
            
            If x.BandaHigh = 0 And x.BandaLow = 0 Then

                'Determina bandahigh e bandalow para o ativo pelo registro de pricing externo
                    Set rs = New ADODB.Recordset
                    Call rs.open("SELECT * FROM TPRICING WHERE DATAOBS = " + SQLBaseDate + " AND ATIVO='" + x.Ativo + "'", db, adOpenForwardOnly, adLockReadOnly)
                    If Not rs.EOF Then
                        bh0 = rs("PRECO") * 1.01
                        bl0 = rs("PRECO") * 0.99
                        x.ExtPoints = 1
                    Else
                        bh0 = 0
                        bl0 = 0
                    End If
            
                'Determina bandahigh e bandalow para o ativo pela regressão de trades passados
                    Set rs = New ADODB.Recordset
                    Call rs.open("SELECT * FROM TTRADES WHERE DATA <= " + SQLBaseDate + " AND DATA>=" + SQLD(BaseDate - 365) + " AND ATIVO='" + x.Ativo + "' ORDER BY DATA DESC", db, adOpenForwardOnly, adLockReadOnly)
                    N = 0
                    While Not rs.EOF And N < 250
                        If rs("PU") > 0 Then
                            N = N + 1
                            If q = "TAXA" Then
                                p(N) = Log(rs("Taxa"))
                            Else
                                p(N) = Log(rs("PU"))
                            End If
                            t(N) = rs("DATA")
                        End If
                        rs.MoveNext
                    Wend
                    x.Points = N
                    If N < 2 Then
                        Bh = 0
                        Bl = 0
                        Bh2 = 0
                        Bl2 = 0
                    Else
                        'Faz a regressão
                        Sxy = 0: Sx = 0: Sy = 0: Sx2 = 0
                        For i = 1 To N
                            Sxy = Sxy + p(i) * t(i)
                            Sx = Sx + t(i)
                            Sy = Sy + p(i)
                            Sx2 = Sx2 + t(i) ^ 2
                        Next i
                        If N * Sx2 - Sx ^ 2 = 0 _
                            Then reg_b = 0 _
                            Else reg_b = (N * Sxy - Sx * Sy) / (N * Sx2 - Sx ^ 2)
                        reg_a = (Sy - reg_b * Sx) / N
                        precoproj = reg_a + reg_b * BaseDate
                        
                        erro = 0
                        For i = 1 To N
                            erro = erro + (p(i) - (reg_a + reg_b * t(i))) ^ 2
                        Next i
                        erro = Sqr(erro / N)
    
                        Bh = Exp(precoproj + erro * 2 + 0.001)
                        Bl = Exp(precoproj - erro * 2 - 0.001)
                        Bh2 = Exp(precoproj + erro * 3 + 0.001)
                        Bl2 = Exp(precoproj - erro * 3 - 0.001)
                    End If
                    
                'Consolida os intervalos das bandas pelos 2 métodos
                    x.BandaHigh = max(bh0, Bh)
                    x.BandaHigh2 = max(bh0, Bh2)
                    If bl0 = 0 Then
                        x.BandaLow = Bl
                        x.BandaLow2 = Bl2
                    ElseIf Bl = 0 Then
                        x.BandaLow = bl0
                        x.BandaLow2 = bl0
                    Else
                        x.BandaLow = min(bl0, Bl)
                        x.BandaLow2 = min(bl0, Bl2)
                    End If
                    
                'Coloca a mesma banda em todos os demais produtos do mesmo ativo
                    For Each y In CTodayTrades
                        If y.Ativo = x.Ativo Then
                            y.BandaHigh = x.BandaHigh
                            y.BandaLow = x.BandaLow
                            y.BandaHigh2 = x.BandaHigh2
                            y.BandaLow2 = x.BandaLow2
                            y.Points = x.Points
                            y.ExtPoints = x.ExtPoints
                        End If
                    Next y
                        
            End If 'BandaHigh=0 and BandaLow=0
            
            '---Testa
            If (x.Comparavel > x.BandaHigh2 Or x.Comparavel < x.BandaLow2) And x.Points > 1 Then
                x.Compliant = "WARN-2"
            ElseIf x.Comparavel > x.BandaHigh Or x.Comparavel < x.BandaLow Then
                x.Compliant = "WARN"
            Else
                x.Compliant = "OK"
            End If
            
        End If 'ativos não isentos
    Next x
End Sub


Public Sub ChecaRateio()
    Dim db As ADODB.Connection, rs As ADODB.Recordset, x As CAlocacao

    
    Set db = OpenTheDatabase
    
    Set cAlloc = New Collection
    
     'Determina o PU médio por fundo
        Set rs = New ADODB.Recordset
        Call rs.open("SELECT ATIVO, FUNDO, CV, sum(QUANT) as q1, sum(PU*QUANT) as s1, sum(TAXA*QUANT) as t1 FROM TTRADES WHERE DATA = " + SQLBaseDate + " GROUP BY ATIVO, FUNDO, CV", db, adOpenForwardOnly, adLockReadOnly)
        While Not rs.EOF
            DoEvents
            Set x = New CAlocacao
            x.Ativo = rs("ATIVO")
            x.Fundo = rs("FUNDO")
            x.CV = rs("CV")
            x.QFundo = rs("q1")
            x.VFundo = rs("s1")
            x.TFundo = rs("t1")
            cAlloc.Add x
            rs.MoveNext
        Wend
    
    'Determina a alocacao geral média (todos os fundos)
        Set rs = New ADODB.Recordset
        Call rs.open("SELECT ATIVO, CV, sum(QUANT) as q1, sum(PU*QUANT) as s1, sum(TAXA*QUANT) as t1 FROM TTRADES WHERE DATA = " + SQLBaseDate + " GROUP BY ATIVO, CV", db, adOpenForwardOnly, adLockReadOnly)
        While Not rs.EOF
            For Each x In cAlloc
                If x.Ativo = rs("ATIVO") And x.CV = rs("CV") Then
                    x.QGeral = rs("q1")
                    x.VGeral = rs("s1")
                    x.TGeral = rs("t1")
                End If
            Next x
            rs.MoveNext
        Wend
        
    
End Sub


Public Function searchctpt(x As String) As CCtpt
    Dim y As CCtpt
    For Each y In cctpts
        If UCase(y.nome) = UCase(x) Then Set searchctpt = y
    Next y
End Function


Public Function TradesOf(d As Date) As Collection
    Dim a As New Collection, y As CTrade
    For Each y In CTrades
        If y.Data = d Then a.Add y
    Next y
    Set TradesOf = a
End Function



'Private Function CritS(x) As String
'    If IsNull(x) Then CritS = "" Else CritS = x
'End Function
'
'Private Function CritD(x) As Date
'    If IsNull(x) Then CritD = LongTimeAgo Else CritD = x
'End Function


'Private Function max(a, b) As Variant
'    If a > b Then max = a Else max = b
'End Function
'
'Private Function min(a, b) As Variant
'    If a < b Then min = a Else min = b
'End Function


