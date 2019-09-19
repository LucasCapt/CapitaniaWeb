VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FTituloHist 
   Caption         =   "Histórico do Título"
   ClientHeight    =   4875
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   MinButton       =   0   'False
   ScaleHeight     =   4875
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   4455
      Left            =   0
      TabIndex        =   0
      Top             =   360
      Width           =   4695
      _ExtentX        =   8281
      _ExtentY        =   7858
      _Version        =   393216
      BackColor       =   16761087
   End
   Begin VB.Label Label1 
      Caption         =   "nome"
      Height          =   255
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   4695
   End
End
Attribute VB_Name = "FTituloHist"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Public Sub showfor(x As CPapel)
    Dim i As Integer
    Dim db As Database, rs As Recordset
    Dim datas(1000) As Date, N As Integer
    
    
    Set db = OpenTheDatabase
    Set rs = db.OpenRecordset("SELECT DISTINCT DATA FROM TPAPELPROP WHERE PAPEL = '" + x.ID + "' AND DATA <=" + SQLBaseDate + " ORDER BY DATA")
    If Not rs.EOF Then rs.MoveFirst
    N = 0
    While Not rs.EOF
        N = N + 1
        datas(N) = rs("DATA")
        rs.MoveNext
    Wend
    
    Me.Label1 = x.nome + " (" + x.ID + ")"
    Grid.Cols = N + 1
    For i = 1 To N
        Grid.TextMatrix(0, i) = Format(datas(i), "dd-MMM-yyyy")
        Grid.ColAlignment(i) = 3
    Next i
    Grid.Rows = 1
    For i = 1 To Props.c.Count
        Grid.AddItem Props.c(i).nome
    Next i
    
    Set rs = db.OpenRecordset("SELECT * FROM TPAPELPROP WHERE PAPEL='" + x.ID + "' AND DATA <=" + SQLBaseDate + " ORDER BY PROPRIEDADE, DATA")
    If Not rs.EOF Then rs.MoveFirst
    While Not rs.EOF
        i = Props.SearchIndex(rs("PROPRIEDADE"))
        For j = 1 To N
            If datas(j) = rs("DATA") Then jj = j
        Next j
        Grid.TextMatrix(i, jj) = rs("VALOR")
        rs.MoveNext
    Wend
    db.Close
    Me.Show
End Sub


Private Sub form_resize()
    Grid.Width = max(1, Me.Width - 150)
    If Me.Height > 850 Then Grid.Height = Me.Height - 850
    Ajusta
End Sub

Private Sub Ajusta()
    Dim i As Integer
    c1 = Grid.Width * 0.25
    If c1 < 1500 Then c1 = 1500
    Grid.ColWidth(0) = c1
    
    c2 = (Grid.Width - c1 - 300) / (Grid.Cols - 1)
    If c2 < 500 Then c2 = 500
    For i = 1 To Grid.Cols - 1
        Grid.ColWidth(i) = c2
    Next i
End Sub

Public Sub newrefresh()
End Sub

