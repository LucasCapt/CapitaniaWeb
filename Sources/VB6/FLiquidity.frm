VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Begin VB.Form FLiquidity 
   Caption         =   "Liquidez"
   ClientHeight    =   5790
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   13350
   LinkTopic       =   "Form1"
   ScaleHeight     =   5790
   ScaleWidth      =   13350
   StartUpPosition =   3  'Windows Default
   Begin MSComctlLib.TabStrip TabStrip1 
      Height          =   375
      Left            =   360
      TabIndex        =   1
      Top             =   0
      Width           =   12975
      _ExtentX        =   22886
      _ExtentY        =   661
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   10
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Cobertura"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Ativo"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Delta.Per"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab4 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Delta.Ac"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab5 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Percent"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab6 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Resgates"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab7 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Passivo"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab8 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Passivo ex-resg"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab9 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Net Cash"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab10 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Excess Cash"
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   5415
      Left            =   360
      TabIndex        =   0
      Top             =   360
      Width           =   12975
      _ExtentX        =   22886
      _ExtentY        =   9551
      _Version        =   393216
      BackColor       =   12648447
   End
   Begin MSComctlLib.TabStrip TabStrip2 
      Height          =   6015
      Left            =   0
      TabIndex        =   2
      Top             =   360
      Width           =   375
      _ExtentX        =   661
      _ExtentY        =   10610
      MultiRow        =   -1  'True
      Placement       =   2
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   5
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "ASSET"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "ADV"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "TODOS"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab4 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "FAVORITOS"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab5 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "EXTERNO"
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FLiquidity"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub showfor()
    Dim f As CFundo, L As Integer, i As Integer
    Grid.FormatString = "Fundo                                        |^Cotização|^Vol.PL    |^Vol.Resg  |^Vol.Efet  |^Concentr. |^Compliant    |^Caixa Total     |^1            |^5            |^21           |^42           |^63           |^126          |^252          "
    Me.Show
    newrefresh
End Sub

Public Sub newrefresh()
    Dim f As CFundo, L As Integer, i As Integer, a As Double, b As Double, a1 As Double, u As String, d As Date, q As String
    Dias = Array(0, 1, 5, 21, 42, 63, 126, 252)
    L = 0
    Grid.Rows = 1
    q = TabStrip2.SelectedItem.Caption
    For Each f In Fundos.c
        If f.area = q Or q = "TODOS" Or (q = "FAVORITOS" And f.Favorit_Cash) Then
        
            u = TabStrip1.SelectedItem.Caption
            If u <> "Cobertura" Or Fundos.TypeReportsLiquidity(f.Tipo, f.area) Then
                Grid.AddItem f.nome
                L = L + 1
                a1 = 0: b = 0
                Grid.TextMatrix(L, 1) = Str(f.PrazoResgate)
                Grid.TextMatrix(L, 2) = Format(f.VolPL, "##0%")
                Grid.TextMatrix(L, 3) = Format(f.VolResg, "##0%")
                Grid.TextMatrix(L, 4) = Format(f.VolResgEfet, "##0%")
                
                If f.PLTotal = 0 _
                    Then Grid.TextMatrix(L, 5) = "n.a." _
                    Else Grid.TextMatrix(L, 5) = Format(f.MaiorCotista / f.PLTotal, "##0%")
                Grid.TextMatrix(L, 6) = f.StaticLiquidityOK
                Grid.TextMatrix(L, 7) = Format(f.StaticCash / 1000000#, "###0")
                For i = 1 To 7
                    d = BaseDate + Dias(i) / 252 * 365
                    Select Case u
                        Case "Ativo"
                            Grid.TextMatrix(L, i + 7) = Format(f.liquidityAteh(d) / 1000000#, "##0.0")
                        Case "Delta.Per"
                            If i = 1 Then
                                a1 = f.liquidityAteh(d)
                                Grid.TextMatrix(L, i + 7) = Format(a1 / 1000000#, "##0.0")
                            Else
                                b = f.liquidityAteh(d)
                                Grid.TextMatrix(L, i + 7) = Format((b - a1) / 1000000#, "##0.0")
                                a1 = b
                            End If
                        Case "Delta.Ac"
                            If i = 1 Then
                                a1 = f.liquidityAteh(d)
                                Grid.TextMatrix(L, i + 7) = Format(a1 / 1000000#, "##0.0")
                            Else
                                Grid.TextMatrix(L, i + 7) = Format((f.liquidityAteh(d) - a1) / 1000000#, "##0.0")
                            End If
                        Case "Percent"
                            a = f.PLTotal
                            If a = 0 _
                                Then Grid.TextMatrix(L, i + 7) = "-" _
                                Else Grid.TextMatrix(L, i + 7) = Format(f.liquidityAteh(d) / a, "##0%")
                        Case "Resgates"
                            Grid.TextMatrix(L, i + 7) = Format(f.ResgatesAteh(d) / 1000000#, "##0.0")
                        Case "Passivo"
                            Grid.TextMatrix(L, i + 7) = Format(f.LiqNeededAteh(d) / 1000000#, "##0.0")
                        Case "Passivo ex-resg"
                            Grid.TextMatrix(L, i + 7) = Format(f.LiqExResgAteh(d) / 1000000#, "##0.0")
                        Case "Cobertura"
                            a = f.LiqCovAteh(d)
                            Grid.TextMatrix(L, i + 7) = Format(a, "##0%")
                            If a > 1 Then MakeMeRed L, i + 7
                        Case "Net Cash"
                            a = (f.liquidityAteh(d) - f.LiqNeededAteh(d)) / 1000000#
                            Grid.TextMatrix(L, i + 7) = Format(a, "##0.0")
                            If a < 0 Then MakeMeRed L, i + 7
                        Case "Excess Cash"
                            a = (f.liquidityAteh(d) - f.LiqNeededAteh(d) - f.PLTotal * f.CaixaMandato) / 1000000#
                            Grid.TextMatrix(L, i + 7) = Format(a, "##0.0")
                            If a < 0 Then MakeMeRed L, i + 7
                        Case Else
                            Grid.TextMatrix(L, i + 7) = ""
                    End Select
                Next i
            End If
            
        End If 'fundo é para mostrar
    Next f 'próximo fundo
End Sub


Private Sub MakeMeRed(i As Integer, j As Integer)
    Grid.Row = i
    Grid.Col = j
    Grid.CellForeColor = &HFF&
End Sub

Private Sub TabStrip1_Click()
    newrefresh
End Sub


Private Sub Grid_dblClick()
    Dim f As CFundo, frm As Form
    If Grid.Row > 0 Then
        Set f = Fundos.searchName(Grid.TextMatrix(Grid.Row, 0))
        Set frm = FMain.GetVisibleForm("FFundo")
        If Not frm Is Nothing Then FFundo.newshow f
        Me.ZOrder (0)
        FLiquidityDetailed.showfor (Grid.TextMatrix(Grid.Row, 0))
    End If
End Sub


Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub

Private Sub form_resize()
    If Me.Height > 750 Then Grid.Height = Me.Height - 750
    If Grid.Width > 250 Then Grid.Width = Me.Width - 500
    TabStrip1.Width = Grid.Width
    TabStrip2.Height = Grid.Height
End Sub

Private Sub TabStrip2_Click()
    newrefresh
End Sub
