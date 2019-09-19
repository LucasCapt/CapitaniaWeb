VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Begin VB.Form FTrades 
   Caption         =   "Trades"
   ClientHeight    =   6735
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10035
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   6735
   ScaleWidth      =   10035
   Begin MSComctlLib.TabStrip TabStrip1 
      Height          =   375
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   12975
      _ExtentX        =   22886
      _ExtentY        =   661
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   1
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   6375
      Left            =   0
      TabIndex        =   0
      Top             =   360
      Width           =   9975
      _ExtentX        =   17595
      _ExtentY        =   11245
      _Version        =   393216
   End
End
Attribute VB_Name = "FTrades"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private TabDates(100) As Date
Private NTabDates As Integer

Public Sub newshow()
    Dim d As Date, a As Collection, FirstDate As Date
    'Monta a Tabstrip
        d = BaseDate
        NTabDates = 0
        FirstDate = Fundos.Dt_OldestPortfolio
        TabStrip1.Tabs.Clear
        While d >= FirstDate
            Set a = Trades.TradesOf(d)
            If Not a.Count = 0 Then
                NTabDates = NTabDates + 1
                TabDates(NTabDates) = d
                TabStrip1.Tabs.Add pvcaption:=Format(d, "dd-MMM")
            End If
            d = d - 1
        Wend
        Me.WindowState = 0
        Me.Width = 14500
    'Mostra
        Grid.FormatString = "Data        |Timestamp          |^ID                 |<Fundo                                   |<Cod. Ativo                    |<Ativo                                                |^C/V   |Quant                |Valor               |Addr                    "
        newrefresh
        
    Me.Show
End Sub


Public Sub newrefresh()
    Dim a As Collection, t As CTrade, i As Integer
    Set a = Trades.TradesOf(TabDates(TabStrip1.SelectedItem.Index))
    Grid.Rows = 1
    i = 0
    For Each t In a
        i = i + 1
        Grid.AddItem Format(t.Data, "dd-MMM-yy")
        Grid.TextMatrix(i, 1) = t.TimeStamp
        Grid.TextMatrix(i, 2) = t.ID
        Grid.TextMatrix(i, 3) = t.Fundo
        Grid.TextMatrix(i, 4) = t.Ativo
        Grid.TextMatrix(i, 5) = t.NomeAtivo
        Grid.TextMatrix(i, 6) = t.CV
        Grid.TextMatrix(i, 7) = Format(t.Quant, "###,##0.0000")
        Grid.TextMatrix(i, 8) = Format(t.value, "##,###,##0.00")
        Grid.TextMatrix(i, 9) = t.Addr
    Next t
End Sub


Private Sub form_resize()
    Dim a As Double, b As Double
    a = Grid.Width
    If a = 0 Then a = 1
    Grid.Height = max(1, Me.Height - 900)
    Grid.Width = max(1, Me.Width - 200)
    TabStrip1.Width = Grid.Width
    b = Grid.Width
    For i = 0 To Grid.Cols - 1
        Grid.ColWidth(i) = max(250, Grid.ColWidth(i) * b / a)
    Next i
End Sub

Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub


Private Sub TabStrip1_Click()
    newrefresh
End Sub
