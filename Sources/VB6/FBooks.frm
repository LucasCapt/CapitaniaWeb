VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0D452EE1-E08F-101A-852E-02608C4D0BB4}#2.0#0"; "FM20.DLL"
Begin VB.Form FBooks 
   Caption         =   "Livros de Regras"
   ClientHeight    =   7440
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8400
   LinkTopic       =   "Form1"
   ScaleHeight     =   7440
   ScaleWidth      =   8400
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   2655
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   7095
      Left            =   0
      TabIndex        =   0
      Top             =   360
      Width           =   8415
      _ExtentX        =   14843
      _ExtentY        =   12515
      _Version        =   393216
      BackColor       =   16761024
      AllowUserResizing=   3
   End
   Begin MSForms.ToggleButton ToggleButton2 
      Height          =   375
      Left            =   3960
      TabIndex        =   2
      Top             =   0
      Width           =   975
      BackColor       =   -2147483633
      ForeColor       =   -2147483630
      DisplayStyle    =   6
      Size            =   "1720;661"
      Value           =   "0"
      Caption         =   "Expande"
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
      ParagraphAlign  =   3
   End
   Begin MSForms.ToggleButton ToggleButton1 
      Height          =   375
      Left            =   2640
      TabIndex        =   1
      Top             =   0
      Width           =   855
      BackColor       =   -2147483633
      ForeColor       =   -2147483630
      DisplayStyle    =   6
      Size            =   "1508;661"
      Value           =   "0"
      Caption         =   "Filtra"
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
      ParagraphAlign  =   3
   End
End
Attribute VB_Name = "FBooks"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Public GridItem As New Collection

Public Sub newshow()
    Grid.FormatString = "Nome                             |^#Fundos|<Regras                                                                                                                "
    Show
    newrefresh
End Sub

Public Sub newrefresh()
    Dim x As CBook, vai As Boolean, b As Double
    Grid.Rows = 1
    Set GridItem = New Collection
    L = 0
    b = Grid.ColWidth(2)
    For Each x In Books.c
        If Not Me.ToggleButton1 Or InStr(UCase(x.nome), UCase(Me.Text1)) > 0 Then
            L = L + 1
            Grid.AddItem x.nome
            GridItem.Add x
            Grid.TextMatrix(L, 1) = Str(x.FundosAplicN)
            Grid.TextMatrix(L, 2) = x.MinhasRegras
            If Me.ToggleButton2 And b > 0 _
                Then Grid.RowHeight(L) = max(250, min(1500, 150 + Me.TextWidth(Grid.TextMatrix(L, 2)) / b * 250))
        End If
    Next x
    Grid.Refresh
    Refresh
End Sub

Public Sub MENU_NOVO()
    Books.HighLevelCria
End Sub

Public Sub MENU_EDIT()
    If Grid.Row > 0 Then
        FEditBook.showfor GridItem(Grid.Row)
    End If
End Sub


Public Sub MENU_EXCLUI()
    If Grid.Row <> 0 Then
        Books.Deleta GridItem(Grid.Row)
        If FRegras.Visible Then FRegras.newrefresh
        Me.newshow
    End If
End Sub

Private Sub Combo1_lostfocus()
    newrefresh
End Sub

Private Sub form_resize()
    Grid.Width = max(1, Me.Width - 250)
    Grid.Height = max(1, Me.Height - 950)
End Sub


Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub

'----------------------------------------------------------------------------
Private Sub Grid_MouseUp(button As Integer, Shift As Integer, x As Single, y As Single)
    If button = 2 Then PopUpMyMenu
End Sub

Private Sub grid_keyup(keycode As Integer, Shift As Integer)
    If keycode = 93 Then PopUpMyMenu
End Sub

Private Sub PopUpMyMenu()
    Me.PopupMenu FMain.mnua_Book
End Sub

Private Sub Text1_Change()
    newrefresh
End Sub

Private Sub ToggleButton1_Click()
    newrefresh
End Sub

Private Sub ToggleButton2_Click()
    Grid.WordWrap = Me.ToggleButton2
    newrefresh
End Sub
