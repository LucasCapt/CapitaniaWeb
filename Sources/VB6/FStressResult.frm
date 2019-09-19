VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Begin VB.Form FStressResult 
   Caption         =   "Relatorio de Stress"
   ClientHeight    =   6300
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11595
   LinkTopic       =   "Form1"
   ScaleHeight     =   6300
   ScaleWidth      =   11595
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   6255
      Left            =   360
      TabIndex        =   0
      Top             =   0
      Width           =   11295
      _ExtentX        =   19923
      _ExtentY        =   11033
      _Version        =   393216
      BackColor       =   12648447
   End
   Begin MSComctlLib.TabStrip TabStrip1 
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
Attribute VB_Name = "FStressResult"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Obj(1000) As CFundo

Public Sub ShowFor()
    Me.Show
    NewRefresh
End Sub


Private Sub form_resize()
    If Me.Width > 201 Then Grid.Width = Me.Width - 450
    If Me.Height > 401 Then Grid.Height = Me.Height - 400
    TabStrip1.Height = Grid.Height
    If Grid.Cols > 1 Then u = (Grid.Width - 2000) / (Grid.Cols - 1) Else u = 1
    If u < 700 Then u = 700
    For i = 1 To Grid.Cols - 1: Grid.ColWidth(i) = u: Next i
End Sub

Public Sub NewRefresh()
    Dim f As CFundo, L As Integer, q As String
    
    Stress.FillGridColsWithNome Grid
    Grid.ColWidth(0) = 2000
    For i = 1 To Grid.Cols - 1: Grid.ColWidth(i) = 2000: Grid.ColAlignment(i) = 3: Next i
    
    Grid.Rows = 1
    L = 0
    q = TabStrip1.SelectedItem.Caption
    For Each f In Fundos.c
        If f.area = q Or q = "TODOS" Or (q = "FAVORITOS" And (f.Favorit_Mkt Or f.Favorit_Credit)) Then
            L = L + 1
            Grid.AddItem f.nome
            Set Obj(L) = f
        End If
    Next f
    
    'Faz Miolo
    For i = 1 To Grid.Rows - 1
        For j = 1 To Grid.Cols - 1
            Grid.TextMatrix(i, j) = Format(Stress.ApplyToFund(Grid.TextMatrix(0, j), Obj(i)), "###0.00%")
        Next j
    Next i
End Sub


Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub

Private Sub TabStrip1_Click()
    NewRefresh
End Sub
