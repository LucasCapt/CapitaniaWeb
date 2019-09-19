VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Begin VB.Form FProps 
   Caption         =   "Propriedades"
   ClientHeight    =   7575
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10305
   LinkTopic       =   "Form1"
   ScaleHeight     =   7575
   ScaleWidth      =   10305
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   7575
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   10335
      _ExtentX        =   18230
      _ExtentY        =   13361
      _Version        =   393216
      BackColor       =   16761087
      WordWrap        =   -1  'True
   End
End
Attribute VB_Name = "FProps"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub NewShow()
    Grid.FormatString = "Propriedade|Valores"
    Grid.ColWidth(0) = 3000
    Grid.ColWidth(1) = 9000
    Show
    newrefresh
End Sub

Public Sub newrefresh()
    Dim x As CPropriedade, L As Integer
    Grid.Rows = 1
    L = 0
    For Each x In Props.c
        L = L + 1
        Grid.AddItem (x.nome)
        Grid.TextMatrix(L, 1) = x.valores
    Next x
    Refresh
End Sub

Public Sub MENU_NOVO()
    Props.HighLevelCria
End Sub

Public Sub MENU_EDITA()
    'Edita
    If Grid.Row <> 0 Then
        FEditprop.showfor Props.searchName(Grid.TextMatrix(Grid.Row, 0))
    End If
End Sub

Public Sub MENU_EXCLUI()
    Dim p As CPropriedade, vai As Boolean, R1 As CRegra
    If Grid.Row <> 0 Then
        'Verifica se está em alguma regra
        Set p = Props.searchName(Grid.TextMatrix(Grid.Row, 0))
        If Not p Is Nothing Then
            vai = True
            For Each R1 In Regras.c
                If Not R1.Para_prop Is Nothing Then vai = vai And Not R1.Para_prop.ID = p.ID
                If Not R1.Por_Prop Is Nothing Then vai = vai And Not R1.Por_Prop.ID = p.ID
            Next R1
            If vai Then
                If MsgBox("Confirma exclusão da propriedade " + p.nome, vbQuestion + vbYesNo) = vbYes Then
                    Props.Delete p.ID
                    FMain.Refaz
                End If
            Else
                MsgBox ("Propriedade em uso. Impossível excluir")
            End If
        End If
    End If
End Sub

Private Sub form_resize()
    Grid.Width = max(1, Me.Width - 100)
    Grid.Height = max(1, Me.Height - 450)
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
    Me.PopupMenu FMain.mnua_Prop
End Sub
