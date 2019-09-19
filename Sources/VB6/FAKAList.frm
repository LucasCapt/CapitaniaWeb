VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Begin VB.Form FAKAList 
   Caption         =   "Lista de Alias"
   ClientHeight    =   8205
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8790
   LinkTopic       =   "Form1"
   ScaleHeight     =   8205
   ScaleWidth      =   8790
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   8175
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8775
      _ExtentX        =   15478
      _ExtentY        =   14420
      _Version        =   393216
      FixedCols       =   0
      BackColor       =   12648384
      MergeCells      =   1
   End
End
Attribute VB_Name = "FAKAList"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub NewShow()
    Dim x As CNomeValor, L As Integer, pp As CPapel
    Grid.FormatString = "<DE ID                       |<PARA ID                          |Nome (PARA)                                                                        "
    Grid.Rows = 1
    Grid.MergeCol(2) = True
    Grid.MergeCol(1) = True
    For Each x In Papeis.AKAListOrderByTo
        Grid.AddItem ""
        L = L + 1
        Grid.TextMatrix(L, 0) = x.nome
        Grid.TextMatrix(L, 1) = x.NomeAlt
        Set pp = Papeis.search(x.NomeAlt)
        If pp Is Nothing Then Grid.TextMatrix(L, 2) = "Não encontrado" Else Grid.TextMatrix(L, 2) = pp.nome
    Next x
    Me.Show
End Sub


Public Sub NewRefresh()
End Sub

Private Sub form_resize()
    a = Grid.Width
    Grid.Height = max(1, Me.Height - 270)
    Grid.Width = max(1, Me.Width - 120)
    b = Grid.Width
    For i = 0 To Grid.Cols - 1
        Grid.ColWidth(i) = Grid.ColWidth(i) / a * b
    Next i
End Sub

Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub
