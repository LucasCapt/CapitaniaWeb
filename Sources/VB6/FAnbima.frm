VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FAnbima 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informações de Risco DDQ ANBIMA"
   ClientHeight    =   7335
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5520
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7335
   ScaleWidth      =   5520
   StartUpPosition =   3  'Windows Default
   Begin VB.ComboBox Combo2 
      Height          =   315
      ItemData        =   "FAnbima.frx":0000
      Left            =   1320
      List            =   "FAnbima.frx":000D
      TabIndex        =   7
      Text            =   "Combo2"
      Top             =   2880
      Width           =   3615
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   120
      TabIndex        =   6
      Text            =   "Combo1"
      Top             =   0
      Width           =   5295
   End
   Begin MSFlexGridLib.MSFlexGrid Grid1 
      Height          =   1815
      Left            =   120
      TabIndex        =   0
      Top             =   720
      Width           =   5295
      _ExtentX        =   9340
      _ExtentY        =   3201
      _Version        =   393216
      Rows            =   7
      Cols            =   5
      GridLinesFixed  =   1
      Appearance      =   0
   End
   Begin MSFlexGridLib.MSFlexGrid Grid2 
      Height          =   2295
      Left            =   120
      TabIndex        =   1
      Top             =   3240
      Width           =   5295
      _ExtentX        =   9340
      _ExtentY        =   4048
      _Version        =   393216
      Rows            =   9
      Cols            =   5
      GridLinesFixed  =   1
      Appearance      =   0
   End
   Begin MSFlexGridLib.MSFlexGrid Grid3 
      Height          =   1335
      Left            =   120
      TabIndex        =   4
      Top             =   6000
      Width           =   5295
      _ExtentX        =   9340
      _ExtentY        =   2355
      _Version        =   393216
      Rows            =   5
      Cols            =   4
      GridLinesFixed  =   1
      Appearance      =   0
   End
   Begin VB.Label Label3 
      Caption         =   "Comportamento em crises"
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   5760
      Width           =   4935
   End
   Begin VB.Label Label2 
      Caption         =   "Histórico de Risco"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   480
      Width           =   4935
   End
   Begin VB.Label Label1 
      Caption         =   "Peak to Valley"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   2880
      Width           =   1095
   End
End
Attribute VB_Name = "FAnbima"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Obj As CFundo

'----- Estrutura da Grid1
Private Dados(6, 4) As Double
Private N(6) As Integer

Private Type TPVElement
    DtPeak As Date
    DtValley As Date
    Peak As Double
    Valley As Double
    DtRecov As Date
    DiasRecov As Integer
    Range As Integer
    Drawdown As Double
End Type


Public Sub newshow()
    Dim uu As String
    
    Me.Show
    
    Fundos.FillComboListWithNomes Combo1
    uu = Combo1.List(1)
    Combo2 = "Todo Histórico"
    If FFundos.Visible Then
        If FFundos.Grid.Row > 0 Then uu = FFundos.Grid.TextMatrix(FFundos.Grid.Row, 0)
    End If
    Combo1 = uu
    Set Obj = Fundos.searchName(Combo1)
    Grid1.FormatString = "<Prazo              |^Var Med      |^VaR Max      |^Stress Med   |^Stress Max   "
    Grid2.FormatString = "Stat                |^1o maior       |^2o maior       |^3o maior       |^4o maior       "
    Grid3.FormatString = "Stat                |crise 1                |crise 2                |crise 3                "
    
    Grid1.TextMatrix(1, 0) = "3m": Grid1.TextMatrix(2, 0) = "6m": Grid1.TextMatrix(3, 0) = "9m"
    Grid1.TextMatrix(4, 0) = "12m": Grid1.TextMatrix(5, 0) = "24m": Grid1.TextMatrix(6, 0) = "Life"
    
    Grid2.TextMatrix(1, 0) = "Drawdown"
    Grid2.TextMatrix(2, 0) = "Data Pico"
    Grid2.TextMatrix(3, 0) = "Pico"
    Grid2.TextMatrix(4, 0) = "Data Vale"
    Grid2.TextMatrix(5, 0) = "Vale"
    Grid2.TextMatrix(6, 0) = "Data Recup."
    Grid2.TextMatrix(7, 0) = "Dias Recup."
    Grid2.TextMatrix(8, 0) = "Range"
    
    
    Grid3.Cols = RiskMgr.Crises.Count + 1
    Grid3.TextMatrix(1, 0) = "Início"
    Grid3.TextMatrix(2, 0) = "Fim"
    Grid3.TextMatrix(3, 0) = "Retorno"
    Grid3.TextMatrix(4, 0) = "Ret.Mensal"
    
    newrefresh
    Me.Refresh
End Sub


Private Sub Processa(v As Double, s As Double, i As Integer)
    N(i) = N(i) + 1
    Dados(i, 1) = Dados(i, 1) + Abs(v)
    If Abs(v) > Abs(Dados(i, 2)) Then Dados(i, 2) = Abs(v)
    Dados(i, 3) = Dados(i, 3) + Abs(s)
    If Abs(s) > Abs(Dados(i, 4)) Then Dados(i, 4) = Abs(s)
End Sub

Public Sub newrefresh()
    Dim i As Integer, v As Double, s As Double
    Dim RH As Collection, dt3m As Date, dt6m As Date, dt9m As Date, dt12m As Double, dt24m As Double
    Dim EstouCaindo As Boolean, PV(1000) As TPVElement, u As TPVElement, NPV As Integer
    Dim u1 As CCrise, r As Double, dm As Double
    Dim TQuotas As New Collection
        
    '---Faz Grid 1 (Histórico de Risco)
        '--Limpa os totalizadores
            For i = 1 To 6
                N(i) = 0
                For j = 1 To 4
                    Dados(i, j) = 0
                Next j
            Next i
            
        '--Percorre
            dt3m = DateSerial(Year(BaseDate), Month(BaseDate) - 3, Day(BaseDate))
            dt6m = DateSerial(Year(BaseDate), Month(BaseDate) - 6, Day(BaseDate))
            dt9m = DateSerial(Year(BaseDate), Month(BaseDate) - 9, Day(BaseDate))
            dt12m = DateSerial(Year(BaseDate), Month(BaseDate) - 12, Day(BaseDate))
            dt24m = DateSerial(Year(BaseDate), Month(BaseDate) - 24, Day(BaseDate))
            
            Set RH = RiskMgr.VaRHistory(Obj, LongTimeAgo)
            For i = 1 To RH.Count
                v = RH(i).VaRorQ
                s = RH(i).Stress
                If RH(i).Data >= dt3m Then Processa v, s, 1
                If RH(i).Data >= dt6m Then Processa v, s, 2
                If RH(i).Data >= dt9m Then Processa v, s, 3
                If RH(i).Data >= dt12m Then Processa v, s, 4
                If RH(i).Data >= dt24m Then Processa v, s, 5
                Processa v, s, 6
            Next i
        
        '--Calcula médias
            For i = 1 To 6
                If N(i) > 0 Then
                    Dados(i, 1) = Dados(i, 1) / N(i)
                    Dados(i, 3) = Dados(i, 3) / N(i)
                Else
                    Dados(i, 1) = -1
                    Dados(i, 3) = -1
                End If
            Next i
        
        '--Reporta
            For i = 1 To 6
                For j = 1 To 4
                    If Dados(i, j) >= 0 _
                        Then Grid1.TextMatrix(i, j) = Format(Dados(i, j), "##0.00%") _
                        Else Grid1.TextMatrix(i, j) = "n/a"
                Next j
            Next i
        Me.Refresh
    
    '---Faz Grid 2 (Peak to Valley)
        RefazGrid2
        Me.Refresh
        
    '---Faz Grid 3 (Comportamento em crises)
        i = 0
        For Each u1 In RiskMgr.Crises
            i = i + 1
            Grid3.TextMatrix(0, i) = u1.nome
            Grid3.TextMatrix(1, i) = Format(u1.Ini, "dd-MMM-yy")
            Grid3.TextMatrix(2, i) = Format(u1.Fim, "dd-MMM-yy")
            r = RiskMgr.FundPerformanceInCrise(Obj, i)
            Grid3.TextMatrix(3, i) = Format(r, "##0.00%")
            dm = u1.DurMos
            If dm > 0 _
                Then Grid3.TextMatrix(4, i) = Format((1 + r) ^ (1 / dm) - 1, "##0.00%") _
                Else Grid3.TextMatrix(4, i) = "n/a"
        Next u1
        
        Me.Refresh
End Sub

Private Sub RefazGrid2()
    Dim EstouCaindo As Boolean, PV(1000) As TPVElement, u As TPVElement, NPV As Integer
    Dim TQuotas As Collection, d As Date
    
     '---Faz Grid 2 (Peak to Valley)
        '--Coleta
            NPV = 0
            EstouCaindo = False
            Select Case Combo2
                Case "Todo Histórico"
                    d = LongTimeAgo
                Case "Últimos 12m"
                    d = BaseDate - 365
                Case "Últimos 24m"
                    d = BaseDate - 365 * 2
                Case Else
                    If IsDate(Combo2) Then
                        d = CDate(Combo2)
                    ElseIf IsNumeric(Combo2) Then
                        d = BaseDate - 30 * Val(Combo2)
                    Else
                        d = LongTimeAgo
                        Combo2 = "Todo Histórico"
                    End If
            End Select
            Set TQuotas = Obj.GetAllQuotasFrom(d)
            For i = 2 To TQuotas.Count
                If TQuotas(i).Valor < TQuotas(i - 1).Valor And TQuotas(i - 1).Valor > 0 And Not EstouCaindo Then
                    'Achou um pico
                    EstouCaindo = True
                    NPV = NPV + 1
                    PV(NPV).DtPeak = TQuotas(i - 1).Data   'data peak
                    PV(NPV).Peak = TQuotas(i - 1).Valor 'peak
                    PV(NPV).Valley = TQuotas(i).Valor 'valley
                    PV(NPV).DtValley = TQuotas(i).Data 'data valley
                    PV(NPV).Drawdown = PV(NPV).Valley / PV(NPV).Peak - 1
                End If
                
                If EstouCaindo And TQuotas(i).Valor < PV(NPV).Valley Then
                    PV(NPV).Valley = TQuotas(i).Valor
                    PV(NPV).DtValley = TQuotas(i).Data
                    PV(NPV).Drawdown = PV(NPV).Valley / PV(NPV).Peak - 1
                End If
                
                If TQuotas(i).Valor > PV(NPV).Peak And EstouCaindo Then
                    'Acabou o peak to valley
                    EstouCaindo = False
                    PV(NPV).DtRecov = TQuotas(i).Data
                    PV(NPV).DiasRecov = PV(NPV).DtRecov - PV(NPV).DtValley
                    PV(NPV).Range = PV(NPV).DtRecov - PV(NPV).DtPeak
                End If
            Next i
            
        '--Ordena
            For i = 1 To NPV - 1
                For j = i + 1 To NPV
                    If PV(j).Drawdown < PV(i).Drawdown Then
                        u = PV(j)
                        PV(j) = PV(i)
                        PV(i) = u
                    End If
                Next j
            Next i
            
        '--Reporta
            For i = 1 To 4
                If i <= NPV Then
                    Grid2.TextMatrix(1, i) = Format(PV(i).Drawdown, "##0.00%")
                    Grid2.TextMatrix(2, i) = Format(PV(i).DtPeak, "dd-MMM-yy")
                    Grid2.TextMatrix(3, i) = Format(PV(i).Peak, "##0.0000")
                    Grid2.TextMatrix(4, i) = Format(PV(i).DtValley, "dd-MMM-yy")
                    Grid2.TextMatrix(5, i) = Format(PV(i).Valley, "##0.0000")
                    Grid2.TextMatrix(6, i) = Format(PV(i).DtRecov, "dd-MMM-yy")
                    Grid2.TextMatrix(7, i) = Format(PV(i).DiasRecov, "##0")
                    Grid2.TextMatrix(8, i) = Format(PV(i).Range, "##0")
                Else
                    For j = 1 To 7
                        Grid2.TextMatrix(j, i) = "n/a"
                    Next j
                End If
                
            Next i
        Refresh
End Sub

Private Sub Combo2_Lostfocus()
    RefazGrid2
End Sub

Private Sub Grid1_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid1
End Sub

Private Sub Grid2_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid2
End Sub

Private Sub Grid3_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid3
End Sub

Private Sub Combo1_lostfocus()
    Set Obj = Fundos.searchName(Combo1)
    newrefresh
End Sub
