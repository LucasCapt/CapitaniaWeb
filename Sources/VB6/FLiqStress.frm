VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Begin VB.Form FLiqStress 
   Caption         =   "Stress de Liquidez"
   ClientHeight    =   6060
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8910
   LinkTopic       =   "Form1"
   ScaleHeight     =   6060
   ScaleWidth      =   8910
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   6015
      Left            =   360
      TabIndex        =   0
      Top             =   0
      Width           =   8535
      _ExtentX        =   15055
      _ExtentY        =   10610
      _Version        =   393216
      BackColor       =   12648447
   End
   Begin MSComctlLib.TabStrip TabStrip2 
      Height          =   6015
      Left            =   0
      TabIndex        =   1
      Top             =   0
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
Attribute VB_Name = "FLiqStress"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub ShowFor()
    Grid.FormatString = "Fundo                                        |Cotização|^StressCVM%|^StressVol%|>Stress $    |>Liquidity   |>Required    "
    Me.Show
    NewRefresh
End Sub

Public Sub NewRefresh()
    Dim f As CFundo, L As Integer, a As Double, b As Double, c As Double, d As Double, q As String
    L = 0
    Grid.Rows = 1
    q = TabStrip2.SelectedItem.Caption
    For Each f In Fundos.c
        If f.area = q Or q = "TODOS" Or (q = "FAVORITOS" And f.Favorit_Cash) Then
            Grid.AddItem f.nome
            L = L + 1
            Grid.TextMatrix(L, 1) = Str(f.PrazoResgate)
            a = Config.GetLiqStress(f.tipo409, f.Concentracao)
            a1 = 1 - Exp(-f.VolPL * 1.64 * Sqr(f.PrazoResgate / 365))
            b = max(a, a1) * f.PLTotal
            c = f.liquidityAteh(BaseDate + f.PrazoResgate)
            d = max(0, b - c)
            Grid.TextMatrix(L, 2) = Format(a, "##0.0%")
            Grid.TextMatrix(L, 3) = Format(a1, "##0.0%")
            Grid.TextMatrix(L, 4) = Format(b / 1000000#, "#,##0.0")
            Grid.TextMatrix(L, 5) = Format(c / 1000000#, "#,##0.0")
            Grid.TextMatrix(L, 6) = Format(d / 1000000#, "#,##0.0")
        End If 'fundo é para mostrar
    Next f 'próximo fundo
End Sub

Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub

Private Sub form_resize()
    If Me.Height > 250 Then Grid.Height = Me.Height - 250
    If Grid.Width > 500 Then Grid.Width = Me.Width - 500
    TabStrip2.Height = Grid.Height
End Sub

Private Sub TabStrip2_Click()
    NewRefresh
End Sub


