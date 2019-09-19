VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Begin VB.Form FAlloc 
   Caption         =   "Relatório de Alocação"
   ClientHeight    =   6735
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   12285
   LinkTopic       =   "Form1"
   MinButton       =   0   'False
   ScaleHeight     =   6735
   ScaleWidth      =   12285
   StartUpPosition =   3  'Windows Default
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   0
      TabIndex        =   1
      Text            =   "Combo1"
      Top             =   0
      Width           =   12255
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   6375
      Left            =   360
      TabIndex        =   0
      Top             =   360
      Width           =   11895
      _ExtentX        =   20981
      _ExtentY        =   11245
      _Version        =   393216
      BackColor       =   12648447
      AllowUserResizing=   1
   End
   Begin MSComctlLib.TabStrip TabStrip1 
      Height          =   6375
      Left            =   0
      TabIndex        =   2
      Top             =   360
      Width           =   375
      _ExtentX        =   661
      _ExtentY        =   11245
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
Attribute VB_Name = "FAlloc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Public Sub ShowFor(Optional x As CPapel = Nothing)
    Dim f As CFundo, L As Integer, v As Double
    Papeis.FillComboWithNames Combo1
    If x Is Nothing Then Set x = Papeis.searchName(Combo1.List(1))
    Combo1 = x.nome
    Me.Show
    NewRefresh
End Sub

Public Sub NewRefresh()
    Dim x As CPapel, f As CFundo
    Dim v1 As Double, q1 As Double, v2 As Double, q2 As Double, v As Double
    
    Set x = Papeis.searchName(Combo1)
    Grid.Rows = 2
    Grid.FormatString = "Fundo                                  |^Direto      |^Direto        |^Direto         |^Direto      |^Aberto      |^Aberto        |^Aberto         |^Aberto      "
    Grid.MergeCells = flexMergeRestrictRows
    Grid.MergeRow(0) = True
    PintaLinha Grid, 1, &HC0C0C0
    Grid.TextMatrix(1, 1) = "Quant"
    Grid.TextMatrix(1, 2) = "PU 000"
    Grid.TextMatrix(1, 3) = "Valor"
    Grid.TextMatrix(1, 4) = "Part."
    Grid.TextMatrix(1, 5) = "Quant"
    Grid.TextMatrix(1, 6) = "PU 000"
    Grid.TextMatrix(1, 7) = "Valor"
    Grid.TextMatrix(1, 8) = "Part."
    L = 1
    
    
    q = TabStrip1.SelectedItem.Caption
    For Each f In Fundos.c
        If f.area = q Or q = "TODOS" Or (q = "FAVORITOS" And (f.Favorit_Mkt Or f.Favorit_Credit Or f.Favorit_Cash)) Then
            L = L + 1
            Grid.AddItem f.nome
            v = f.PLTotal
            f.PapelValues x.nome, False, v1, q1
            f.PapelValues x.nome, True, v2, q2
                        
            If q1 = 0 Then
                Grid.TextMatrix(L, 1) = "-"
                Grid.TextMatrix(L, 2) = "-"
            Else
                Grid.TextMatrix(L, 1) = Format(q1, "###,###,##0")
                Grid.TextMatrix(L, 2) = Format(v1 / q1 / 1000, "###0.000")
            End If
            Grid.TextMatrix(L, 3) = Format(v1, "###,###,##0")
            
            If q2 = 0 Then
                Grid.TextMatrix(L, 5) = "-"
                Grid.TextMatrix(L, 6) = "-"
            Else
                Grid.TextMatrix(L, 5) = Format(q2, "###,###,##0")
                Grid.TextMatrix(L, 6) = Format(v2 / q2 / 1000, "###0.000")
            End If
            Grid.TextMatrix(L, 7) = Format(v2, "###,###,##0")
            
            If v = 0 Then
                Grid.TextMatrix(L, 4) = "-"
                Grid.TextMatrix(L, 8) = "-"
            Else
                Grid.TextMatrix(L, 4) = Format(v1 / v, "##0.00%")
                Grid.TextMatrix(L, 8) = Format(v2 / v, "##0.00%")
            End If
            
        End If
    Next f
    Me.Refresh
End Sub


Private Sub Combo1_lostfocus()
    NewRefresh
End Sub

Private Sub form_resize()
    Grid.Height = max(1, Me.Height - 450)
    Grid.Width = max(1, Me.Width - 450)
    TabStrip1.Height = Grid.Height
End Sub

Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub

Private Sub TabStrip1_Click()
    NewRefresh
End Sub
