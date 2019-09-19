VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form F_ProvFilter 
   Caption         =   "Filtros de Provisão"
   ClientHeight    =   3900
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   9540
   LinkTopic       =   "Form1"
   ScaleHeight     =   3900
   ScaleWidth      =   9540
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   3975
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   9615
      _ExtentX        =   16960
      _ExtentY        =   7011
      _Version        =   393216
   End
End
Attribute VB_Name = "F_ProvFilter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub newShow()
    Dim db As Database, rs As Recordset, f As Fundo, c As New Collection, pfe As CProvFilterElement
    
    Set db = OpenTheDatabase
    Set rs = db.OpenRecordset("SELECT * FROM TPROVFILTER WHERE DT_CREATED<=" + SQLBaseDate + " AND NOT (DELETED AND DT_DELETED<=" + SQLBaseDate + ")")
    
    'Lê para dentro de uma collection
    While Not rs.EOF
        Set pfe = New CProvFilterElement
        pfe.IDUnica = rs("IDUNICA")
        pfe.Fundo = rs("FUNDO")
        pfe.PPCod = rs("PP_COD")
        pfe.PPISIN = rs("PP_ISIN")
        pfe.PPTipo = rs("PP_TIPO")
        pfe.ProvCod = rs("PROV_COD")
        pfe.ProvData = rs("PROV_DATA")
        pfe.Descr = rs("DESC")
        c.Add pfe
    Wend
    db.Close
    
    Grid.Rows = 1
    Grid.FormatString = "ID    |Fundo            |ProvCod|ProvData |-->ISIN            |-->Código          |Descritivo                   |Tipo         "
    
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
            Grid.TextMatrix(i, 7) = c(i).Tipo
        End If
    Next i
    Me.Show
End Sub


Private Sub form_resize()
    If Me.Width > 250 Then Grid.Width = Me.Width - 250
    If Me.Height > 300 Then Grid.Height = Me.Height - 300
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
    Me.PopupMenu FMain.mnu_Prov
End Sub
