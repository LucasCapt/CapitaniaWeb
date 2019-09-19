VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0D452EE1-E08F-101A-852E-02608C4D0BB4}#2.0#0"; "FM20.DLL"
Begin VB.Form FLiquidityDetailMo 
   Caption         =   "Detalhe Mensal do Risco de Liquidez"
   ClientHeight    =   7245
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   7140
   LinkTopic       =   "Form1"
   ScaleHeight     =   7245
   ScaleWidth      =   7140
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   6735
      Left            =   0
      TabIndex        =   0
      Top             =   480
      Width           =   7095
      _ExtentX        =   12515
      _ExtentY        =   11880
      _Version        =   393216
      Rows            =   15
      Appearance      =   0
   End
   Begin MSForms.ComboBox ComboBox1 
      Height          =   375
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   7095
      VariousPropertyBits=   746604571
      DisplayStyle    =   3
      Size            =   "12515;661"
      MatchEntry      =   1
      ShowDropButtonWhen=   2
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
   End
End
Attribute VB_Name = "FLiquidityDetailMo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Public Sub showfor(x As String)
    Fundos.FillComboListWithNomes ComboBox1
    ComboBox1 = x
    Grid.FormatString = "Mes   |Ativo (Cflow) |Ativo (ANBIMA)|Ativo (Constr)|Ativo (ADTV) |Ativo (Efet) |Resg.Program.|Resg.Esperado"
    newrefresh
    
    Me.Show
End Sub

Public Sub newrefresh()
    Dim f As CFundo, dias As Variant
    Dim a1 As Double, a2 As Double, a3 As Double, a4 As Double, a5 As Double, a6 As Double, a7 As Double
    Dim DataAteh As Date, i As Integer, L As Integer
    
    Set f = Fundos.searchName(ComboBox1)
    
    If Not f Is Nothing Then
        L = 0
        Grid.Rows = 1
        For i = 0 To 48
            DataAteh = DateSerial(Year(BaseDate), Month(BaseDate) + i, Day(BaseDate))
            a1 = f.liquidityAteh(DataAteh, "CFLOW")
            a2 = f.liquidityAteh(DataAteh, "ANBIMA")
            a3 = f.liquidityAteh(DataAteh, "CONSTR")
            a4 = f.liquidityAteh(DataAteh, "ADTV")
            a5 = f.liquidityAteh(DataAteh, "DEFAULT")
            a6 = f.ResgatesAteh(DataAteh)
            a7 = f.ResgateEsperadoAteh(DataAteh)
                        
            Grid.AddItem Str(i)
            L = L + 1
            Grid.TextMatrix(L, 1) = Format(a1 / 1000000#, "##0.0")
            Grid.TextMatrix(L, 2) = Format(a2 / 1000000#, "##0.0")
            Grid.TextMatrix(L, 3) = Format(a3 / 1000000#, "##0.0")
            Grid.TextMatrix(L, 4) = Format(a4 / 1000000#, "##0.0")
            Grid.TextMatrix(L, 5) = Format(a5 / 1000000#, "##0.0")
            Grid.TextMatrix(L, 6) = Format(a6 / 1000000#, "##0.0")
            Grid.TextMatrix(L, 7) = Format(a7 / 1000000#, "##0.0")
            
        Next i
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


Private Sub form_resize()
    Grid.Width = max(1, Me.Width - 250)
    Grid.Height = max(1, Me.Height - 1050)
    ComboBox1.Width = Grid.Width
End Sub
