VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0D452EE1-E08F-101A-852E-02608C4D0BB4}#2.0#0"; "FM20.DLL"
Begin VB.Form FLiquidityDetailed 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Detalhe de Risco de Liquidez"
   ClientHeight    =   6165
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9645
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6165
   ScaleWidth      =   9645
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   5655
      Left            =   0
      TabIndex        =   0
      Top             =   480
      Width           =   9615
      _ExtentX        =   16960
      _ExtentY        =   9975
      _Version        =   393216
      Rows            =   16
      RowHeightMin    =   352
      Appearance      =   0
   End
   Begin MSForms.ComboBox ComboBox1 
      Height          =   375
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   9615
      VariousPropertyBits=   746604571
      DisplayStyle    =   3
      Size            =   "16960;661"
      MatchEntry      =   1
      ShowDropButtonWhen=   2
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
   End
End
Attribute VB_Name = "FLiquidityDetailed"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Public Sub showfor(x As String)
    Fundos.FillComboListWithNomes ComboBox1
    ComboBox1 = x
    Grid.FormatString = "                                                                     |^1               |^5               |^21              |^42              |^63              |^126             |^252             "
    Grid.Rows = 16
    Grid.TextMatrix(1, 0) = "Liquidez do Ativo (Cashflow)"
    Grid.TextMatrix(2, 0) = "Liquidez do Ativo (ANBIMA)"
    Grid.TextMatrix(3, 0) = "Liquidez do Ativo (Constrained)"
    Grid.TextMatrix(4, 0) = "Liquidez do Ativo (ADTV)"
    Grid.TextMatrix(5, 0) = "Liquidez do Ativo (Efetiva)"
    Grid.TextMatrix(6, 0) = "Resgates Programados"
    Grid.TextMatrix(7, 0) = "Aportes Programadas"
    Grid.TextMatrix(8, 0) = "Resgates Esperados"
    Grid.TextMatrix(9, 0) = "Ajuste Concentração"
    Grid.TextMatrix(10, 0) = "Necessidade do Passivo"
    Grid.TextMatrix(11, 0) = "Cobertura (ANBIMA)"
    Grid.TextMatrix(12, 0) = "Compliant?"
    Grid.TextMatrix(13, 0) = "Net Cash"
    Grid.TextMatrix(14, 0) = "Excess Cash"
    Grid.TextMatrix(15, 0) = "Stress percentil (ADTV)"
    newrefresh
    
    Me.Show
End Sub

Public Sub newrefresh()
    Dim f As CFundo, Dias As Variant
    Dim a1 As Double, a2 As Double, a3 As Double, a4 As Double, a5 As Double
    Dim DataAteh As Date, g As Double, lp As Double
    
    Dias = Array(0, 1, 5, 21, 42, 63, 126, 252)
    Set f = Fundos.searchName(ComboBox1)
    
    If Not f Is Nothing Then
        For i = 1 To 7
            DataAteh = BaseDate + Dias(i) / 252 * 365
            a1a = f.liquidityAteh(DataAteh, "ANBIMA")
            a1x = f.liquidityAteh(DataAteh, "CONSTR")
            a1b = f.liquidityAteh(DataAteh, "ADTV")
            a1 = f.liquidityAteh(DataAteh, "DEFAULT")
                        
            a2 = f.ResgatesAteh(DataAteh)
            a3 = f.TransfersAteh(DataAteh)
            a4 = f.ResgateEsperadoAteh(DataAteh)
            a5 = f.AjusteConcentrAteh(DataAteh)
            a6 = f.LiqNeededAteh(DataAteh)
            
            Grid.TextMatrix(1, i) = Format(f.liquidityAteh(DataAteh, "CFLOW") / 1000000#, "##0.0")
            Grid.TextMatrix(2, i) = Format(a1a / 1000000#, "##0.0")
            Grid.TextMatrix(3, i) = Format(a1x / 1000000#, "##0.0")
            
            Grid.TextMatrix(4, i) = Format(a1b / 1000000#, "##0.0")
            Grid.TextMatrix(5, i) = Format(a1 / 1000000#, "##0.0")
            
            Grid.TextMatrix(6, i) = Format(a2 / 1000000#, "##0.0")
            Grid.TextMatrix(7, i) = Format(-a3 / 1000000#, "##0.0")
            Grid.TextMatrix(8, i) = Format(a4 / 1000000#, "##0.0")
            If Fundos.TypeReportsLiquidity(f.Tipo, f.area) _
                Then Grid.TextMatrix(9, i) = Format(a5 / 1000000#, "##0.0") _
                Else Grid.TextMatrix(9, i) = "n.a."
            Grid.TextMatrix(10, i) = Format(a6 / 1000000#, "##0.0")
            If a1 = 0 Then
                Grid.TextMatrix(11, i) = "-"
                Grid.TextMatrix(12, i) = "-"
            Else
                Cover = a6 / a1
                Grid.TextMatrix(11, i) = Format(Cover, "##0.0%")
                If Cover < 0.8 Then
                    Grid.TextMatrix(12, i) = "OK"
                ElseIf Cover < 1 Then
                    Grid.TextMatrix(12, i) = "WARN"
                Else
                    Grid.TextMatrix(12, i) = "BREACH"
                End If
            End If
            Grid.TextMatrix(13, i) = Format((a1 - a6) / 1000000#, "##0.0")
            Grid.TextMatrix(14, i) = Format((a1 - a6 - f.PLTotal * f.CaixaMandato) / 1000000#, "##0.0")
            Grid.TextMatrix(15, i) = FormatLiqSt(RiskMgr.LiqPercent(DataAteh, (a1b - a2) / max(1, f.PLTotal)))
            
        Next i
        Grid.FillStyle = flexFillRepeat
        Grid.Row = 1: Grid.Col = 1
        Grid.RowSel = 4: Grid.ColSel = 7
        Grid.CellBackColor = &HE0E0E0
        Grid.RowSel = 1: Grid.ColSel = 1
    Else
        Grid.Clear
    End If
End Sub

Private Sub ComboBox1_lostfocus()
    newrefresh
End Sub


Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub
