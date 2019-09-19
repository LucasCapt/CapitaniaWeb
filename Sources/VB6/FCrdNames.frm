VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FCrdNames 
   Caption         =   "Nomes de Crédito"
   ClientHeight    =   8745
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   7560
   LinkTopic       =   "Form1"
   ScaleHeight     =   8745
   ScaleWidth      =   7560
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   8655
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7575
      _ExtentX        =   13361
      _ExtentY        =   15266
      _Version        =   393216
      BackColor       =   12640511
      GridLinesFixed  =   1
      AllowUserResizing=   3
   End
End
Attribute VB_Name = "FCrdNames"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Public GridItem As New Collection

Public Sub newshow()
    Grid.FormatString = "Setor                   |Nome                            |^Código          |Rating     |<CNPJs vinculados                                        "
    Show
    newrefresh
End Sub

Public Sub newrefresh()
    Dim u As CCreditName, vai As Boolean, b As Double
    Grid.Rows = 1
    Set GridItem = New Collection
    L = 0
    For Each u In CrNames.c
        L = L + 1
        GridItem.Add u
        Grid.AddItem u.setor
        Grid.TextMatrix(L, 1) = u.nome
        Grid.TextMatrix(L, 2) = u.Cod
        Grid.TextMatrix(L, 3) = u.Rating
        Grid.TextMatrix(L, 4) = u.CNPJDesc
    Next u
    Grid.Refresh
    Refresh
End Sub

Public Sub MENU_NOVO()
    Dim setor As String
    If Grid.Row > 0 Then setor = GridItem(Grid.Row).setor Else setor = ""
    CrNames.Cria setor
End Sub

Public Sub MENU_EDIT()
    If Grid.Row > 0 Then
        FEditCrdName.showfor GridItem(Grid.Row)
    End If
End Sub

Public Sub MENU_EXCLUI()
    If Grid.Row > 0 Then
        CrNames.Deleta GridItem(Grid.Row)
        Me.newshow
    End If
End Sub

Private Sub form_resize()
    Grid.Width = max(1, Me.Width - 250)
    Grid.Height = max(1, Me.Height - 500)
End Sub

Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub

Private Sub Grid_MouseUp(button As Integer, Shift As Integer, x As Single, y As Single)
    If button = 2 Then PopUpMyMenu
End Sub

Private Sub grid_keyup(keycode As Integer, Shift As Integer)
    If keycode = 93 Then PopUpMyMenu
End Sub

Private Sub PopUpMyMenu()
    Me.PopupMenu FMain.mnu_crdname
End Sub


