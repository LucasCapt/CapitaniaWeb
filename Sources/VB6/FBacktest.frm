VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Object = "{65E121D4-0C60-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCHRT20.OCX"
Begin VB.Form FBacktest 
   Caption         =   "VaR Backtest"
   ClientHeight    =   5955
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   12465
   LinkTopic       =   "Form1"
   ScaleHeight     =   5955
   ScaleWidth      =   12465
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   5535
      Left            =   0
      TabIndex        =   1
      Top             =   360
      Width           =   5055
      _ExtentX        =   8916
      _ExtentY        =   9763
      _Version        =   393216
      BackColor       =   16777152
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   0
      TabIndex        =   2
      Text            =   "Combo1"
      Top             =   0
      Width           =   5055
   End
   Begin MSChart20Lib.MSChart Chart1 
      Height          =   5535
      Left            =   5160
      OleObjectBlob   =   "FBacktest.frx":0000
      TabIndex        =   0
      Top             =   360
      Width           =   7215
   End
   Begin VB.Label Label1 
      BackColor       =   &H0000C000&
      Caption         =   "Label1"
      Height          =   375
      Left            =   5160
      TabIndex        =   3
      Top             =   0
      Width           =   7215
   End
End
Attribute VB_Name = "FBacktest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Obj As CFundo

Public Sub NewShow()
    Dim uu As String
    Fundos.FillComboListWithNomes Combo1
    uu = Combo1.List(1)
    If FFundos.Visible Then
        If FFundos.Grid.Row > 0 Then uu = FFundos.Grid.TextMatrix(FFundos.Grid.Row, 0)
    End If
    Combo1 = uu
    Set Obj = Fundos.searchName(Combo1)
    Grid.FormatString = "Data           |VaR            |Retorno        |Retorno Ativo  |^Violação       "
    Chart1.chartType = VtChChartType2dLine
    NewRefresh
    Me.Show
End Sub

Public Sub NewRefresh()
    Dim a As Collection, i As Integer, j As Integer, L As Integer, ultvar As Double, r As Double
    Dim VarL(1000) As Double, QL(1000) As Double, NViola As Integer
    If Not Obj Is Nothing Then
        rcdi = (1 + RiskMgr.GenLvlDI) ^ (1 / 252) - 1
        NViola = 0
        '----Faz Grid
        Grid.Rows = 1
        Set a = RiskMgr.VaRHistory(Obj)
        i = 1: j = 2: L = 0
        While i < a.Count Or j < Obj.MyQuotas.Count
            While (a(i).Data < Obj.MyQuotas(j).Data Or j = Obj.MyQuotas.Count) And i < a.Count
                ultvar = a(i).VaR
                L = L + 1
                VarL(L) = ultvar
                QL(L) = 0
                Grid.AddItem Format(a(i).Data, "dd-MMM-yy")
                Grid.TextMatrix(L, 1) = Format(ultvar, "##0.00%")
                Grid.TextMatrix(L, 2) = "0.00%"
                Grid.TextMatrix(L, 3) = "0.00%"
                i = i + 1
            Wend
            
            While a(i).Data = Obj.MyQuotas(j).Data And (i < a.Count And j < Obj.MyQuotas.Count)
                ultvar = a(i).VaR
                If Obj.MyQuotas(j - 1).Valor > 0 Then r = Obj.MyQuotas(j).Valor / Obj.MyQuotas(j - 1).Valor - 1 Else r = 0
                L = L + 1
                VarL(L) = ultvar
                QL(L) = r - rcdi
                Grid.AddItem Format(a(i).Data, "dd-MMM-yy")
                Grid.TextMatrix(L, 1) = Format(ultvar, "##0.00%")
                Grid.TextMatrix(L, 2) = Format(r, "##0.00%")
                Grid.TextMatrix(L, 3) = Format(r - rcdi, "##0.00%")
                If Abs(r - rcdi) > Abs(ultvar) Then Grid.TextMatrix(L, 4) = "SIM": NViola = NViola + 1
                i = i + 1: j = j + 1
            Wend
            
            While (Obj.MyQuotas(j).Data < a(i).Data Or i = a.Count) And j < Obj.MyQuotas.Count
                L = L + 1
                VarL(L) = ultvar
                QL(L) = r - rcdi
                If Obj.MyQuotas(j - 1).Valor > 0 Then r = Obj.MyQuotas(j).Valor / Obj.MyQuotas(j - 1).Valor - 1 Else r = 0
                Grid.AddItem Format(Obj.MyQuotas(j).Data, "dd-MMM-yy")
                Grid.TextMatrix(L, 1) = Format(ultvar, "##0.00%")
                Grid.TextMatrix(L, 2) = Format(r, "##0.00%")
                Grid.TextMatrix(L, 3) = Format(r - rcdi, "##0.00%")
                If Abs(r - rcdi) > Abs(ultvar) Then Grid.TextMatrix(L, 4) = "SIM": NViola = NViola + 1
                j = j + 1
            Wend
                       
        Wend
        
        '---Faz Resumo
        If L > 0 Then
            Me.Label1 = Str(NViola) + " Violações/" + Str(L) + " observações"
            If NViola / L < 5 / 250 Then
                Me.Label1.BackColor = &HC000&
            ElseIf NViola / L < 10 / 252 Then
                Me.Label1.BackColor = &HFFFF&
            Else
                Me.Label1.BackColor = &HFF&
            End If
        Else
            Me.Label1 = "Não há dados"
        End If
            
        
        '----Faz Gráfico
        Chart1.Visible = False
        If L > 0 Then
            Chart1.Plot.Axis(VtChAxisIdX).ValueScale.Auto = False
            Chart1.Plot.Axis(VtChAxisIdX).CategoryScale.Auto = False
            Chart1.Plot.Axis(VtChAxisIdX).CategoryScale.LabelTick = True
            Chart1.Plot.Axis(VtChAxisIdX).CategoryScale.DivisionsPerTick = 21
            Chart1.Plot.Axis(VtChAxisIdX).CategoryScale.DivisionsPerLabel = 21
            Chart1.RowCount = Grid.Rows - 1
            Chart1.ColumnCount = 3
            Chart1.Plot.SeriesCollection(1).DataPoints(-1).Brush.FillColor.Set 100, 100, 200
            Chart1.Plot.SeriesCollection(2).DataPoints(-1).Brush.FillColor.Set 100, 100, 200
            Chart1.Plot.SeriesCollection(3).DataPoints(-1).Brush.FillColor.Set 0, 0, 0
            For i = 1 To Grid.Rows - 1
                Chart1.Row = i
                Chart1.RowLabel = Grid.TextMatrix(i, 0)
                Chart1.Column = 1: Chart1.Data = VarL(i)
                Chart1.Column = 2: Chart1.Data = -VarL(i)
                Chart1.Column = 3: Chart1.Data = QL(i)
            Next i
            Chart1.Visible = True
        End If
    End If
End Sub


Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub


Private Sub Combo1_lostfocus()
    Set Obj = Fundos.searchName(Combo1)
    NewRefresh
End Sub


Private Sub form_resize()
    Grid.Width = min(max(1, Me.Width - 200), 5500)
    Combo1.Width = Grid.Width
    Grid.Height = max(1, Me.Height - 750)
    Chart1.Left = Grid.Width + 10
    Chart1.Width = Me.Width - Grid.Width - 200
    Chart1.Height = Grid.Height
    Label1.Left = Chart1.Left
    Label1.Width = Chart1.Width
End Sub

