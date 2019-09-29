VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FDelAka 
   Caption         =   "Destruição de Alias"
   ClientHeight    =   5010
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6765
   LinkTopic       =   "Form1"
   ScaleHeight     =   5010
   ScaleWidth      =   6765
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command2 
      Caption         =   "Testar os alias do título acima"
      Height          =   375
      Left            =   0
      TabIndex        =   7
      Top             =   600
      Width           =   6735
   End
   Begin VB.TextBox Text1 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   0
      TabIndex        =   6
      Text            =   "Text1"
      Top             =   360
      Width           =   6735
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Cancelar"
      Height          =   375
      Left            =   3720
      TabIndex        =   5
      Top             =   4560
      Width           =   1455
   End
   Begin VB.CommandButton B_OK 
      Caption         =   "Destruir"
      Height          =   375
      Left            =   1440
      TabIndex        =   4
      Top             =   4560
      Width           =   1455
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   2055
      Left            =   0
      TabIndex        =   1
      Top             =   1320
      Width           =   6735
      _ExtentX        =   11880
      _ExtentY        =   3625
      _Version        =   393216
      GridLinesFixed  =   1
      Appearance      =   0
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      Caption         =   "(papel não possui aliases)"
      Height          =   255
      Left            =   0
      TabIndex        =   9
      Top             =   1440
      Width           =   6735
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      Caption         =   "Label2"
      Height          =   255
      Left            =   0
      TabIndex        =   8
      Top             =   1080
      Width           =   6735
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      Caption         =   "Deseja prosseguir a destruição?"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   0
      TabIndex        =   3
      Top             =   4080
      Width           =   6735
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      Caption         =   $"FDelAka.frx":0000
      Height          =   615
      Left            =   0
      TabIndex        =   2
      Top             =   3480
      Width           =   6735
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "Todos os Alias do seguinte título serão eliminados:"
      Height          =   255
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6735
   End
End
Attribute VB_Name = "FDelAka"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private AkasToDel(1000) As String
Private N As Integer
Private ParaID As String


Public Sub showfor(Obj As CPapel)
    ParaID = Obj.ID
    Me.Text1 = ParaID
    Me.Label2.Caption = Obj.nome
    Me.Label3.Visible = False
    Me.Grid.Visible = False
    Me.Show
End Sub

Private Sub B_OK_Click()
    Dim i As Integer, db As ADODB.Connection, rs As ADODB.Recordset, j As Integer
    
    Set db = OpenTheDatabase
    For i = 1 To N
        db.Execute ("UPDATE TPOSIC SET PAPEL='" + ParaID + "' WHERE PAPEL='" + AkasToDel(i) + "'")
        db.Execute ("DELETE FROM TPAPELPROP WHERE PAPEL='" + AkasToDel(i) + "'")
        db.Execute ("DELETE FROM TPAPEL WHERE ID='" + AkasToDel(i) + "'")
        db.Execute ("DELETE FROM TAKA WHERE FROMID='" + AkasToDel(i) + "' AND TOID='" + ParaID + "'")
        j = 1
        While j <= Papeis.akaList.Count
            If Papeis.akaList(j).nome = AkasToDel(i) Then Papeis.akaList.remove j Else j = j + 1
        Wend
    Next i

    MsgBox ("Destruição de Alias concluída.")
    MMain.ResetAll
End Sub

Private Sub Command1_Click()
    MsgBox ("Destruição de Alias cancelada.")
    Me.Hide
End Sub

Private Sub Command2_Click()
    Dim u As CNomeValor, db As ADODB.Connection, rs As ADODB.Recordset, pp As CPapel, i As Integer
    
    Me.Label3.Visible = False
    Me.Grid.Visible = False
    Set pp = Papeis.search(Me.Text1)
    If pp Is Nothing Then
        Me.Label2.Caption = "(não encontrado)"
    Else
        Me.Label2.Caption = pp.nome
        ParaID = pp.ID
        'Preenche a grade
            
            Set db = OpenTheDatabase
            Grid.FormatString = "Alias (De ID)                                              |^Cart   |^Prop   |^Reg    "
            N = 0
            Grid.Rows = 1
            For Each u In Papeis.akaList
                If u.NomeAlt = ParaID Then
                    Grid.AddItem u.nome
                    N = N + 1
                    AkasToDel(N) = u.nome
                    Set rs = db.Execute("SELECT * FROM TPOSIC WHERE PAPEL='" + AkasToDel(N) + "'")
                    If rs.EOF Then Grid.TextMatrix(N, 1) = "" Else Grid.TextMatrix(N, 1) = "X"
                    
                    Set rs = db.Execute("SELECT * FROM TPAPELPROP WHERE PAPEL='" + AkasToDel(N) + "'")
                    If rs.EOF Then Grid.TextMatrix(N, 2) = "" Else Grid.TextMatrix(N, 2) = "X"
                    
                    Set rs = db.Execute("SELECT * FROM TPAPEL WHERE ID='" + AkasToDel(N) + "'")
                    If rs.EOF Then Grid.TextMatrix(N, 3) = "" Else Grid.TextMatrix(N, 3) = "X"
                End If
            Next u
        
            
        If N = 0 Then
            Label3.Visible = True
            Me.Refresh
        Else
            Grid.Visible = True
            Me.Refresh
        End If
    End If
End Sub
