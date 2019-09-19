VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Begin VB.Form FFundLimits 
   Caption         =   "Limites dos Fundos"
   ClientHeight    =   6255
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9615
   LinkTopic       =   "Form1"
   ScaleHeight     =   6255
   ScaleWidth      =   9615
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   6255
      Left            =   360
      TabIndex        =   0
      Top             =   0
      Width           =   9255
      _ExtentX        =   16325
      _ExtentY        =   11033
      _Version        =   393216
      BackColor       =   12648447
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
Attribute VB_Name = "FFundLimits"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub NewShow()
    Grid.FormatString = "Fundo                                   |Override|>market VaR  |>market Stress|>Duration    |>Credit EL   |>Credit VaR  "
    Me.WindowState = vbNormal
    Me.Show
    Me.NewRefresh
End Sub


Public Sub NewRefresh()
    Dim f As CFundo, L As Integer, q As String
    Grid.Rows = 1
    L = 0
    q = TabStrip1.SelectedItem.Caption
    For Each f In Fundos.c
        If q = "TODOS" Or q = f.area Or (q = "FAVORITOS" And (f.Favorit_Mkt Or f.Favorit_Credit)) Then
            Grid.AddItem f.nome
            L = L + 1
            If f.OverrideLimit Then Grid.TextMatrix(L, 1) = "SIM" Else Grid.TextMatrix(L, 1) = ""
            Grid.TextMatrix(L, 2) = Format(f.Limite("V"), "##0.00%")
            Grid.TextMatrix(L, 3) = Format(f.Limite("S"), "##0.00%")
            Grid.TextMatrix(L, 4) = Format(f.Limite("D"), "##0.00")
            Grid.TextMatrix(L, 5) = Format(f.Limite("E"), "##0.00%")
            Grid.TextMatrix(L, 6) = Format(f.Limite("U"), "##0.00%")
        End If
    Next f
End Sub


Private Sub form_resize()
    Grid.Height = max(1, Me.Height - 350)
    Grid.Width = max(1, Me.Width - 450)
    TabStrip1.Height = Grid.Height
End Sub

Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub

Private Sub TabStrip1_Click()
    NewRefresh
End Sub

