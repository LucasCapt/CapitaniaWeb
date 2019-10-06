VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FProvFilter 
   Caption         =   "Filtro de Provisões"
   ClientHeight    =   3390
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10605
   LinkTopic       =   "Form1"
   ScaleHeight     =   3390
   ScaleWidth      =   10605
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   3375
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   10575
      _ExtentX        =   18653
      _ExtentY        =   5953
      _Version        =   393216
      Appearance      =   0
   End
End
Attribute VB_Name = "FProvFilter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public c As New Collection

Public Sub newshow()
    Grid.FormatString = "^ID    |Fundo                                   |ProvCod  |^ProvData    |-->ISIN                      |^-->Código            |Descritivo                                |^Tipo        "
    Me.Show
    newrefresh
End Sub

Public Sub newrefresh()
    Dim db As ADODB.Connection, rs As ADODB.Recordset, f As CFundo, pfe As CProvFilterElement
    
    Set db = OpenTheDatabase
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT * FROM TPROVFILTER WHERE DT_CREATED<=" + SQLBaseDate + " AND NOT (DELETED AND DT_DELETED<=" + SQLBaseDate + ")", db, adOpenForwardOnly, adLockReadOnly)
    
    'Lê para dentro de uma collection
    Set c = New Collection
    While Not rs.EOF
        Set pfe = New CProvFilterElement
        pfe.IDUnica = rs("IDUNICA")
        pfe.Fundo = rs("FUNDO")
        pfe.PPCod = rs("PP_COD")
        pfe.PPISIN = rs("PP_ISIN")
        pfe.PPTipo = rs("PP_TIPO")
        pfe.ProvCod = rs("PROV_COD")
        pfe.ProvData = rs("PROV_DATA")
        pfe.Descr = rs("DESCR")
        c.Add pfe
        rs.MoveNext
    Wend
    
    Grid.Rows = 1
    For i = 1 To c.Count
        Grid.AddItem c(i).IDUnica
        Set f = Fundos.search(c(i).Fundo)
        If f Is Nothing Then
            Grid.TextMatrix(i, 1) = "Unknown(" + Str(c(i).Fundo) + ")"
        Else
            Grid.TextMatrix(i, 1) = f.nome
            Grid.TextMatrix(i, 2) = c(i).ProvCod
            Grid.TextMatrix(i, 3) = c(i).ProvData
            Grid.TextMatrix(i, 4) = c(i).PPISIN
            Grid.TextMatrix(i, 5) = c(i).PPTipo
            Grid.TextMatrix(i, 6) = c(i).Descr
            Grid.TextMatrix(i, 7) = c(i).PPTipo
        End If
    Next i
    Me.Show
End Sub

Private Sub Grid_MouseUp(button As Integer, Shift As Integer, x As Single, y As Single)
    If button = 2 Then PopUpMyMenu
End Sub

Private Sub grid_keyup(keycode As Integer, Shift As Integer)
    If keycode = 93 Then PopUpMyMenu
End Sub

Private Sub PopUpMyMenu()
    Me.PopupMenu FMain.mnu_Prov
End Sub

Private Sub form_resize()
    Grid.Height = max(1, Me.Height - 500)
    Grid.Width = max(1, Me.Width - 250)
End Sub

Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then
        CopyRangeToClipboard Grid
    ElseIf keyascii = 13 And Grid.Col > 0 Then
        FEditProv.showfor "VIEW", c(Grid.Row())
    End If
End Sub



Public Sub Nova()
    Dim u As CProvFilterElement, z As CProvFilterElement
    Set u = New CProvFilterElement
    FEditProv.showfor "NEW", u, c
    'newrefresh
End Sub



Public Sub Editar()
    If Grid.Row > 0 Then
        FEditProv.showfor "EDIT", c(Grid.Row())
        'newrefresh
    End If
End Sub



Public Sub Deletar()
    Dim db As ADODB.Connection
    If Grid.Row > 0 Then
        If MsgBox("Confirma a exclusão do filtro de propriedade" + vbCr + Str(c(Grid.Row()).IDUnica) + Chr(10) + c(Grid.Row()).ProvCod + ": " + c(Grid.Row()).ProvData, vbYesNo) = vbYes Then
            Set db = OpenTheDatabase
            db.Execute ("UPDATE TPROVFILTER SET DELETED=TRUE, DT_DELETED=" + SQLBaseDate + " WHERE IDUNICA=" + Str(c(Grid.Row()).IDUnica))
            WriteLog ("DELETOU PROVISAO")
            MsgBox "As alterações só têm efeito durante importação de carteira." + vbCr + "Nada foi alterado nas carteiras atuais."
            newrefresh
        Else
            MsgBox "Exclusão cancelada."
        End If
    End If
End Sub

