VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0D452EE1-E08F-101A-852E-02608C4D0BB4}#2.0#0"; "FM20.DLL"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Begin VB.Form FRegras 
   Caption         =   "Regras"
   ClientHeight    =   7695
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   15240
   LinkTopic       =   "Form1"
   ScaleHeight     =   7695
   ScaleWidth      =   15240
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   9960
      TabIndex        =   6
      Text            =   "20"
      Top             =   0
      Width           =   975
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      Left            =   5880
      Style           =   2  'Dropdown List
      TabIndex        =   4
      Top             =   0
      Width           =   2895
   End
   Begin MSComctlLib.TabStrip TabStrip2 
      Height          =   7335
      Left            =   0
      TabIndex        =   3
      Top             =   360
      Width           =   375
      _ExtentX        =   661
      _ExtentY        =   12938
      MultiRow        =   -1  'True
      Placement       =   2
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   4
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "CTRL"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "LIM"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "GER"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab4 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Todas"
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   1560
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   0
      Width           =   2895
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   7335
      Left            =   360
      TabIndex        =   0
      Top             =   360
      Width           =   14895
      _ExtentX        =   26273
      _ExtentY        =   12938
      _Version        =   393216
      BackColor       =   16761024
      AllowUserResizing=   1
   End
   Begin MSForms.ToggleButton ToggleButton2 
      Height          =   375
      Left            =   8880
      TabIndex        =   7
      Top             =   0
      Width           =   1095
      BackColor       =   -2147483633
      ForeColor       =   -2147483630
      DisplayStyle    =   6
      Size            =   "1931;661"
      Value           =   "0"
      Caption         =   "Filtra Num="
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
      ParagraphAlign  =   3
   End
   Begin MSForms.ToggleButton ToggleButton1 
      Height          =   375
      Left            =   4800
      TabIndex        =   5
      Top             =   0
      Width           =   1095
      BackColor       =   -2147483633
      ForeColor       =   -2147483630
      DisplayStyle    =   6
      Size            =   "1931;661"
      Value           =   "0"
      Caption         =   "Filtra prop="
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
      ParagraphAlign  =   3
   End
   Begin VB.Label Label1 
      Caption         =   "Livro de Regras:"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   0
      Width           =   1335
   End
End
Attribute VB_Name = "FRegras"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private flag As Boolean
Private LReg As Collection
Private LastBookEdited As String

Public Sub newshow()
    Dim b As CBook
    Combo1.Clear
    Combo1.AddItem "ALL"
    For Each b In Books.c
        Combo1.AddItem b.nome
    Next b
    Grid.FormatString = "<Nome                                |^#Books|^#Fundos|Regra      |Limite   |Warning    |Por                      |Para                                                                         |Ref (%)               |E (condição adicional de PARA)                                           |Aberta|Movimento"
    flag = True
    Show
    Combo1 = "ALL"
    Props.FillComboWithProps Combo2
    Combo2 = Combo2.List(0)
    newrefresh
End Sub


Public Sub newrefresh()
    Dim c As Collection, r As CRegra, L As Integer, vai As Boolean, uu As String
    
    If Combo1 = "ALL" Or Combo1 = "" Then Set c = Regras.c Else Set c = Books.search(Combo1).c
    Grid.Rows = 1
    L = 0
    Set LReg = New Collection
    
    If ToggleButton1 Then Set pp1 = Props.searchName(Combo2)
    
    For Each r In c
        If Not ToggleButton1 Then
            vai = True
        ElseIf pp1 Is Nothing Then
            vai = False
        Else
            vai = (r.Para_prop Is pp1 Or r.Por_Prop Is pp1 Or r.AND_prop Is pp1)
        End If
        If ToggleButton2 Then vai = vai And (r.Limite = Val(Me.Text1) Or r.Warn = Val(Me.Text1))
        vai = vai And (TabStrip2.SelectedItem.Caption = "Todas" Or TabStrip2.SelectedItem.Caption = r.Escopo)
        If vai Then
            L = L + 1
            Grid.AddItem r.nome
            LReg.Add r
            Grid.TextMatrix(L, 1) = Str(r.BooksAplicN)
            Grid.TextMatrix(L, 2) = Str(r.FundosAplicN)
            Grid.TextMatrix(L, 3) = r.MaxMin
            Grid.TextMatrix(L, 4) = FormatLimit(r.Limite, r)
            Grid.TextMatrix(L, 5) = FormatLimit(r.Warn, r)
            If r.Para_prop Is Nothing Then a1 = "?" Else a1 = r.Para_prop.nome
            If r.Por_Prop Is Nothing Then a2 = "?" Else a2 = r.Por_Prop.nome
            If r.AND_prop Is Nothing Then a3 = "?" Else a3 = r.AND_prop.nome
            If r.AND2_prop Is Nothing Then a4 = "?" Else a4 = r.AND2_prop.nome
            
            If r.Por Then Grid.TextMatrix(L, 6) = a2
            If r.PARA Then Grid.TextMatrix(L, 7) = a1 + " " + r.Para_comp + " " + r.Para_valor Else Grid.TextMatrix(L, 5) = ""
            Grid.TextMatrix(L, 8) = r.Lim_Ref
            
            uu = ""
            If r.ANDRule Then uu = a3 + " " + r.AND_comp + " " + r.AND_valor
            If r.Conector Then a5 = " OU " Else a5 = " E "
            If r.AND2Rule Then uu = uu + a5 + a4 + " " + r.AND2_comp + " " + r.AND2_valor
            If uu <> "" Then Grid.TextMatrix(L, 9) = uu Else Grid.TextMatrix(L, 9) = ""
            
            If r.Aberta Then Grid.TextMatrix(L, 10) = "sim" Else Grid.TextMatrix(L, 10) = "não"
            If r.MovementRule Then Grid.TextMatrix(L, 11) = "sim" Else Grid.TextMatrix(L, 11) = "não"
        End If
    Next r
    Refresh
End Sub


Private Sub Combo1_lostfocus()
    If flag Then newrefresh
End Sub


Private Sub Combo2_Lostfocus()
    newrefresh
End Sub

Public Sub MENU_NOVO()
    Regras.HighLevelCria
End Sub

Public Sub MENU_CLONA()
    If Grid.Row > 0 Then Regras.Clona LReg(Grid.Row)
End Sub

Public Sub MENU_EXCLUI()
    If Grid.Row > 0 Then Regras.Exclui LReg(Grid.Row)
End Sub

Public Sub MENU_NOVOBOOK()
    Books.HighLevelCria
End Sub

Public Sub MENU_INCLUIEMLIVRO()
    Dim a As String, b As CBook
    If Grid.Row > 0 Then
        a = FInput.Pergunte("Entre com o Book a Incluir", "RULEBOOK", LastBookEdited)
        Set b = Books.search(a)
        If Not b Is Nothing Then
            b.AddNewRule LReg(Grid.Row()).ID
            b.WriteDB
            Fundos.Recalc
            Books.Recalc
            FMain.Refaz
            LastBookEdited = a
        Else
            MsgBox ("Livro não encontrado.")
        End If
    End If
End Sub

Public Sub MENU_EDITA()
    If Grid.Row > 0 Then FEditRegra.showfor LReg(Grid.Row)
End Sub

Public Sub CommandButton6_Click()
    If Grid.Row > 0 Then FRegraFast.showfor LReg(Grid.Row)
End Sub

Public Sub Grid_dblClick()
    If Grid.Row <> 0 Then FRegraFast.showfor LReg(Grid.Row)
End Sub

Private Sub form_resize()
    Grid.Width = max(1, Me.Width - 600)
    Grid.Height = max(1, Me.Height - 950)
    Me.TabStrip2.Height = Grid.Height
End Sub

Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
End Sub

Private Sub TabStrip2_Click()
    newrefresh
End Sub


Private Sub ToggleButton1_Click()
    newrefresh
End Sub

Private Sub Text1_Change()
    If ToggleButton2 Then newrefresh
End Sub


'----------------------------------------------------------------------------
Private Sub Grid_MouseUp(button As Integer, Shift As Integer, x As Single, y As Single)
    If button = 2 Then PopUpMyMenu
End Sub

Private Sub grid_keyup(keycode As Integer, Shift As Integer)
    If keycode = 93 Then PopUpMyMenu
End Sub

Private Sub PopUpMyMenu()
    Me.PopupMenu FMain.mnua_Regra
End Sub

Private Sub ToggleButton2_Click()
    newrefresh
End Sub
