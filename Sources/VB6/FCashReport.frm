VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Begin VB.Form FCashReport 
   Caption         =   "Cash Report"
   ClientHeight    =   6225
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10995
   LinkTopic       =   "Form1"
   ScaleHeight     =   6225
   ScaleWidth      =   10995
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   6255
      Left            =   360
      TabIndex        =   0
      Top             =   0
      Width           =   10575
      _ExtentX        =   18653
      _ExtentY        =   11033
      _Version        =   393216
      BackColor       =   12648447
      Appearance      =   0
   End
   Begin MSComctlLib.TabStrip TabStrip1 
      Height          =   6735
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   375
      _ExtentX        =   661
      _ExtentY        =   11880
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
Attribute VB_Name = "FCashReport"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub newshow()
    Grid.FormatString = "Fundo                                   |^DispD0     |^Cash       |^Cash %    |^Cash Free |^Cash Free%|^3m Liq   |^3m Req   |^3m Cash Free"
    Me.WindowState = vbNormal
    Me.Show
    Me.newrefresh
End Sub


Public Sub newrefresh()
    Dim f As CFundo, L As Integer, q As String
    Grid.Rows = 1
    L = 0
    q = TabStrip1.SelectedItem.Caption
    For Each f In Fundos.c
        If q = "TODOS" Or q = f.area Or (q = "FAVORITOS" And f.Favorit_Cash) Then
            Grid.AddItem f.nome
            L = L + 1
            Grid.TextMatrix(L, 1) = Format(f.StaticDisp / 1000000#, "##0.0")
            Grid.TextMatrix(L, 2) = Format(f.StaticCash / 1000000#, "##0.0")
            Grid.TextMatrix(L, 3) = Format(f.StaticCashPct, "##0%")
            Grid.TextMatrix(L, 4) = Format(f.StaticCashFree / 1000000#, "##0.0")
            Grid.TextMatrix(L, 5) = Format(f.StaticCashFreePct, "##0%")
            a = f.liquidityAteh(BaseDate + 91) - f.liquidityAteh(BaseDate + 1)
            b = f.LiqNeededAteh(BaseDate + 91)
            Grid.TextMatrix(L, 6) = Format(a / 1000000#, "##0.0")
            Grid.TextMatrix(L, 7) = Format(b / 1000000#, "##0.0")
            Grid.TextMatrix(L, 8) = Format((f.StaticCashFree + a - b) / 1000000#, "##0.0")
        End If
    Next f
End Sub


Private Sub form_resize()
    Grid.Height = max(1, Me.Height - 420)
    Grid.Width = max(1, Me.Width - 450)
    TabStrip1.Height = Grid.Height
End Sub

Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub

Private Sub TabStrip1_Click()
    newrefresh
End Sub
