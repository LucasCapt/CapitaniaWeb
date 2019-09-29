VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CRisco"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

Private S_IFIX(1000) As Double
Private N_IFIX As Integer
Private S_IPCA2Y(1000) As Double
Private N_IPCA2Y As Integer
Private S_IPCA5Y(1000) As Double
Private N_IPCA5Y As Integer
Private S_IPCA10Y(1000) As Double
Private N_IPCA10Y As Integer
Private S_IMAB5(1000) As Double
Private N_IMAB5 As Integer
Private S_Dolar(1000) As Double
Private N_Dolar As Integer
Private S_PRE2Y(1000) As Double
Private N_PRE2Y As Integer
Private S_PRE5Y(1000) As Double
Private N_PRE5Y As Integer
Private S_IDA(1000) As Double
Private N_IDA As Integer

Public LiqStressReq As Collection

Public Lambda As Double

Const MaxLines = 3000
Const MaxCols = 60

Public VolIPCA2Y As Double
Public VolIPCA5Y As Double
Public VolIPCA10Y As Double
Public VolIMAB5 As Double
Public VolIFIX As Double
Public VolDolar As Double
Public VolPRE2Y As Double
Public VolPRE5Y As Double
Public VolIdio As Double
Public VolIDA As Double

Public StressIPCA2Y As Double
Public StressIPCA5Y As Double
Public StressIPCA10Y As Double
Public StressIMAB5 As Double
Public StressIFIX As Double
Public StressDolar As Double
Public StressPRE2Y As Double
Public StressPRE5Y As Double
Public StressIdio As Double
Public StressIDA As Double

Public LastDate As Date

Public Crises As Collection


Public Function VolIPCA(d As Date) As Double
    If (d - BaseDate) / 365.25 < 2 Then
        VolIPCA = VolIPCA2Y
    ElseIf (d - BaseDate) / 365.25 < 5 Then
        VolIPCA = VolIPCA2Y + (VolIPCA5Y - VolIPCA2Y) / 3 * ((d - BaseDate) / 365.25 - 2)
    ElseIf (d - BaseDate) / 365.25 < 10 Then
        VolIPCA = VolIPCA5Y + (VolIPCA10Y - VolIPCA5Y) / 5 * ((d - BaseDate) / 365.25 - 5)
    Else
        VolIPCA = VolIPCA10Y
    End If
End Function


Public Function StressIPCA(d As Date) As Double
    If (d - BaseDate) / 365.25 < 2 Then
        StressIPCA = StressIPCA2Y
    ElseIf (d - BaseDate) / 365.25 < 5 Then
        StressIPCA = StressIPCA2Y + (StressIPCA5Y - StressIPCA2Y) / 3 * ((d - BaseDate) / 365.25 - 2)
    ElseIf (d - BaseDate) / 365.25 < 10 Then
        StressIPCA = StressIPCA5Y + (StressIPCA10Y - StressIPCA5Y) / 5 * ((d - BaseDate) / 365.25 - 5)
    Else
        StressIPCA = StressIPCA10Y
    End If
End Function


Public Function VolPRE(d As Date) As Double
    If (d - BaseDate) / 365.25 < 2 Then
        VolPRE = VolPRE2Y
    ElseIf (d - BaseDate) / 365.25 < 5 Then
        VolPRE = VolPRE2Y + (VolPRE5Y - VolPRE2Y) / 3 * ((d - BaseDate) / 365.25 - 2)
    Else
        VolPRE = VolPRE5Y
    End If
End Function


Public Function StressPRE(d As Date) As Double
    If (d - BaseDate) / 365.25 < 2 Then
        StressPRE = StressPRE2Y
    ElseIf (d - BaseDate) / 365.25 < 5 Then
        StressPRE = StressPRE2Y + (StressPRE5Y - StressPRE2Y) / 3 * ((d - BaseDate) / 365.25 - 2)
    Else
        StressPRE = StressPRE5Y
    End If
End Function



Public Sub Init()
    Dim db As ADODB.Connection, rs As ADODB.Recordset, u As CCrise, d As Date, y As CRiskLiqStressElement
    
    Set db = OpenTheDatabase

    'Defaults
        Lambda = Config.EWMA
        VolIPCA2Y = 0.19
        VolIPCA5Y = 0.19
        VolIPCA10Y = 0.19
        VolIMAB5 = 0.0018
        VolIFIX = 0.005
        VolIDA = 0.0005
                
        StressIPCA2Y = 2.7
        StressIPCA5Y = 2.7
        StressIPCA10Y = 2.7
        StressIMAB5 = 0.041
        StressIFIX = 0.072
        StressIDA = 0.005
                
    'Percorre cada série
        LastDate = BaseDate
        TrataSerie "IFIX", S_IFIX, "LOGN", VolIFIX, StressIFIX, LastDate, N_IFIX, db
        TrataSerie "IPCA2Y", S_IPCA2Y, "NORM", VolIPCA2Y, StressIPCA2Y, LastDate, N_IPCA2Y, db
        TrataSerie "IPCA5Y", S_IPCA5Y, "NORM", VolIPCA5Y, StressIPCA5Y, LastDate, N_IPCA5Y, db
        TrataSerie "IPCA10Y", S_IPCA10Y, "NORM", VolIPCA10Y, StressIPCA10Y, LastDate, N_IPCA10Y, db
        TrataSerie "IMAB5", S_IMAB5, "LOGN", VolIMAB5, StressIMAB5, LastDate, N_IMAB5, db
        TrataSerie "PRE2Y", S_PRE2Y, "NORM", VolPRE2Y, StressPRE2Y, LastDate, N_PRE2Y, db
        TrataSerie "PRE5Y", S_PRE5Y, "NORM", VolPRE5Y, StressPRE5Y, LastDate, N_PRE5Y, db
        TrataSerie "DOLAR", S_Dolar, "LOGN", VolDolar, StressDolar, LastDate, N_Dolar, db
        TrataSerie "IDA", S_IDA, "LOGN", VolIDA, StressIDA, LastDate, N_IDA, db
        
    'Determina a volatilidade idiossincrasica de imobiliário
        VolIdio = VolIFIX * Sqr(1 / (1 / 85 + (1 - 1 / 85) * 0.1) - 1)
        StressIdio = StressIFIX / VolIFIX * VolIdio
        
    'Lê as crises
    Set rs = db.Execute("SELECT * FROM TCRISES ORDER BY DT_INI")
    Set Crises = New Collection
    While Not rs.EOF
        Set u = New CCrise
        u.nome = CritS(rs("NOME"))
        u.Ini = CritD(rs("DT_INI"))
        u.Fim = CritD(rs("DT_FIM"))
        u.Populate db
        Crises.Add u
        rs.MoveNext
    Wend
    
    'Lê o gabarito de stress de liquidez
    Set LiqStressReq = New Collection
    Set rs = db.Execute("SELECT MAX(DATA) AS MAXDATE FROM TLIQGABARITO")
    d = rs("MAXDATE")
    Set rs = db.Execute("SELECT * FROM TLIQGABARITO ORDER BY PERCENTIL, MESES")
    While Not rs.EOF
        Set y = New CRiskLiqStressElement
        y.Lreq = CritNN(rs("LREQ"))
        y.Meses = CritNN(rs("MESES"))
        y.Percentil = CritNN(rs("PERCENTIL"))
        LiqStressReq.Add y
        rs.MoveNext
    Wend
    
End Sub


Private Sub TrataSerie(DBName As String, vetor As Variant, Processo As String, _
            ByRef Vol As Double, ByRef Stress As Double, ByRef LastDate As Date, ByRef N As Integer, db As ADODB.Connection)
            
    Dim rs As ADODB.Recordset, d As Date, Incompleta As Boolean, UltData As Date
    
    'Lê Database para o vetor
        Set rs = db.Execute("SELECT * FROM TFACTORHIST WHERE FACTORID='" + DBName + "' AND DATA<=" + SQLBaseDate + " AND DATA >=" + SQLD(BaseDate - 720) + " ORDER BY DATA")
        i = 0
        While Not rs.EOF
            i = i + 1
            vetor(i) = rs("VALOR")
            d = rs("DATA")
            rs.MoveNext
        Wend
        If d < LastDate Then LastDate = d
        If d < BaseDate - 30 Then
            WriteLogError "Serie de Mercado desatualizada 30+ dias!", DBName
        ElseIf d < BaseDate - 7 Then
            WriteLogError "Serie de Mercado desatualizada 7+ dias", DBName
        End If
        N = i
    
    'Calcula Vol
        v = 0: p = 0
        For k = 0 To i - 2
            v = v + Log(vetor(i - k) / vetor(i - k - 1)) ^ 2 * Lambda ^ k
            p = p + Lambda ^ k
        Next k
        If p <> 0 Then
            If Processo = "NORM" Then
                Vol = Sqr(v / p) * vetor(i)
            Else
                Vol = Sqr(v / p)
            End If
        End If
    
    'Calcula Stress
        If Processo = "NORM" Then
            For k = 1 To i - 22
                If Abs(vetor(k + 20) - vetor(k)) > Stress Then Stress = Abs(vetor(k + 20) - vetor(k))
            Next k
        Else
            For k = 1 To i - 22
                If Abs(Log(vetor(k + 20) / vetor(k))) > Stress Then Stress = Abs(Log(vetor(k + 20) / vetor(k)))
            Next k
        End If
        
End Sub


Public Function VaRHistory(Fundo As CFundo, Optional dtcorte As Date = LongTimeAgo) As Collection
    Dim db As ADODB.Connection, rs As ADODB.Recordset, a As Collection, u As CRiskHistoryElement, d As Date
    
    'Obtem a coleção
        Set a = New Collection
        If dtcorte = LongTimeAgo Then
            If Fundo.MyQuotas.Count > 0 Then d = Fundo.MyQuotas(1).Data Else d = BaseDate
        Else
            d = dtcorte
        End If
        
        Set db = OpenTheDatabase
        Set rs = db.Execute("SELECT * FROM THISTRISK WHERE FUNDO='" + Fundo.nome + _
            "' AND DATAINFO<=" + SQLBaseDate + " AND DATAINFO>=" + SQLD(d) + " AND FUNDSTATUS<>'INV' ORDER BY DATAINFO")
        If Not rs.EOF Then rs.MoveFirst
        While Not rs.EOF
            Set u = New CRiskHistoryElement
            u.Data = rs("DATAINFO")
            u.VaR = CritNN(rs("VAR"))
            u.Stress = CritNN(rs("STRESS"))
            u.QVaR = CritNN(rs("VARQUOTA"))
            a.Add u
            rs.MoveNext
        Wend
    
    'Elimina duplicados
        i = 1
        While i < a.Count - 1
            If a(i + 1).Data = a(i).Data Then a.remove i Else i = i + 1
        Wend
    Set VaRHistory = a
End Function


Public Function FundPerformance(Fundo As CFundo, DataIni As Date, DataFim As Date) As Double
    Dim db As ADODB.Connection, rs As ADODB.Recordset, q1 As Double, q2 As Double
    
    Set db = OpenTheDatabase
    Set rs = db.Execute("SELECT * FROM TQUOTAS WHERE FUNDO=" + Str(Fundo.ID) + " AND DATA <=" + SQLD(DataIni) + " ORDER BY DATA DESC")
    If Not rs.EOF Then
        q1 = rs("QUOTA")
        Set rs = db.Execute("SELECT * FROM TQUOTAS WHERE FUNDO=" + Str(Fundo.ID) + " AND DATA <=" + SQLD(DataFim) + " ORDER BY DATA DESC")
        If Not rs.EOF And q1 > 0 Then
            q2 = rs("QUOTA")
            FundPerformance = q2 / q1 - 1
        Else
            FundPerformance = 0
        End If
    Else
        FundPerformance = 0
    End If
End Function

Public Function FundPerformanceInCrise(f As CFundo, i As Integer) As Double
    If i < 0 Or i > Crises.Count Then
        FundPerformanceInCrise = 0
    Else
        FundPerformanceInCrise = FundPerformance(f, Crises(i).Ini, Crises(i).Fim)
    End If
End Function


Public Function GenLvlInflation() As Double
    GenLvlInflation = (1 + S_PRE2Y(N_PRE2Y) / 100) / (1 + S_IPCA2Y(N_IPCA2Y) / 100) - 1
End Function


Public Function GenLvlDI() As Double
    GenLvlDI = S_PRE2Y(N_PRE2Y) / 100
End Function


Public Function GenLvlInfCupom() As Double
    GenLvlInfCupom = S_IPCA2Y(N_IPCA2Y) / 100
End Function


Public Function LiqPercent(d As Date, Liq As Double) As Double
    Dim arrpercent(200) As Double, arrLReq(200) As Double, N As Double, Perc As Double, Lreq As Double, achou As Boolean
    Dim dant As Date, dpos As Date
    'Acha o mes em cada série de percentile
    'A coleção deve estar ordenada por percentile e mes
    Perc = 0
    N = 0
    For i = 1 To LiqStressReq.Count
        If LiqStressReq(i).Percentil <> Perc Then
            If N > 0 Then arrLReq(N) = Lreq
            N = N + 1
            arrpercent(N) = LiqStressReq(i).Percentil
            dant = BaseDate + LiqStressReq(i).Dias / 252 * 365
            Perc = LiqStressReq(i).Percentil
            achou = False
        End If
        dpos = BaseDate + LiqStressReq(i).Dias / 252 * 365
        If dant = d Then
            Lreq = LiqStressReq(i).Lreq
            achou = True
        ElseIf dpos > d And dant < d And Not achou Then
            'Interpola
            If dant = dpos _
                Then LiqStressReq(i).Lreq _
                Else Lreq = LiqStressReq(i - 1).Lreq + (LiqStressReq(i).Lreq - LiqStressReq(i - 1).Lreq) * (d - dant) / (dpos - dant)
            achou = True
        ElseIf dant > d And Not achou Then
            'anterior à primeira data
            Lreq = LiqStressReq(i).Lreq
            achou = True
        ElseIf Not achou Then
            'ainda não achou, vai colocando o Lreq do último mês
            Lreq = LiqStressReq(i).Lreq
        End If
        dant = dpos
    Next i
    
    'Interpola o percentile
    i = 1
    While i <= N And arrLReq(i) > Liq
        i = i + 1
    Wend
    If i = 1 Then
        LiqPercent = arrpercent(1)
    ElseIf i >= N Then
        LiqPercent = arrpercent(N)
    Else
        If arrLReq(i) = arrLReq(i - 1) _
            Then LiqPercent = arrpercent(i) _
            Else LiqPercent = arrpercent(i - 1) + (arrpercent(i) - arrpercent(i - 1)) * (Liq - arrLReq(i - 1)) / (arrLReq(i) - arrLReq(i - 1))
    End If
End Function
