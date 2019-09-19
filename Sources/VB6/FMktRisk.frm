VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Begin VB.Form FMktRisk 
   Caption         =   "Risco de Mercado"
   ClientHeight    =   6855
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10515
   LinkTopic       =   "Form1"
   ScaleHeight     =   6855
   ScaleWidth      =   10515
   StartUpPosition =   3  'Windows Default
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
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   6855
      Left            =   360
      TabIndex        =   0
      Top             =   0
      Width           =   10095
      _ExtentX        =   17806
      _ExtentY        =   12091
      _Version        =   393216
      BackColor       =   12648447
   End
End
Attribute VB_Name = "FMktRisk"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Public Sub NewShow()
    Grid.Rows = 1
    Grid.FormatString = "Fundo                                          |VaR           |Stress        |Expo. Imob.Idx|Dur. Infl.    |Dur. Pré      |Expo. Dolar   |Expo. Imob.Idi"
    NewRefresh
    Me.Show
End Sub


Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub

Private Sub form_resize()
    Grid.Height = max(1, Me.Height - 350)
    Grid.Width = max(1, Me.Width - 450)
    TabStrip1.Height = Grid.Height
End Sub


Public Sub NewRefresh()
    Dim x As CFundo, L As Integer, q As String
    L = 0
    Grid.Rows = 1
    q = TabStrip1.SelectedItem.Caption
    For Each x In Fundos.c
        If x.area = q Or q = "TODOS" Or (q = "FAVORITOS" And x.Favorit_Mkt) Then
            L = L + 1
            Grid.AddItem x.nome
            Grid.TextMatrix(L, 1) = Format(x.StaticVar, "##0.00%")
            Grid.TextMatrix(L, 2) = Format(x.StaticStress, "##0.00%")
            Grid.TextMatrix(L, 3) = Format(x.StaticEImob, "##0.00%")
            Grid.TextMatrix(L, 4) = Format(x.StaticEInfl, "##0.00")
            Grid.TextMatrix(L, 5) = Format(x.StaticEPre, "##0.00")
            Grid.TextMatrix(L, 6) = Format(x.StaticEDolar, "##0.00%")
            Grid.TextMatrix(L, 7) = Format(x.StaticEIdio, "##0.00%")
        End If
    Next x
End Sub

Private Sub TabStrip1_Click()
    NewRefresh
End Sub


Private Sub Grid_dblClick()
    If Grid.Row > 0 Then
        FCreditRisk.NewShow "MERCADO", Grid.TextMatrix(Grid.Row, 0)
    End If
End Sub
