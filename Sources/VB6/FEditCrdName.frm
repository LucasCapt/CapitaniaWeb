VERSION 5.00
Begin VB.Form FEditCrdName 
   Caption         =   "Nome de Crédito"
   ClientHeight    =   5730
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   4410
   LinkTopic       =   "Form1"
   ScaleHeight     =   5730
   ScaleWidth      =   4410
   StartUpPosition =   3  'Windows Default
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   840
      TabIndex        =   10
      Top             =   960
      Width           =   3495
   End
   Begin VB.ListBox List1 
      Height          =   2010
      Left            =   120
      TabIndex        =   6
      Top             =   1920
      Width           =   4215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Height          =   375
      Left            =   3240
      TabIndex        =   5
      Top             =   5280
      Width           =   1095
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   2040
      TabIndex        =   4
      Top             =   5280
      Width           =   1095
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   120
      TabIndex        =   3
      Top             =   4440
      Width           =   4215
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Inclui CNPJ"
      Height          =   375
      Left            =   120
      TabIndex        =   2
      Top             =   4800
      Width           =   1455
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Exclui CNPJ"
      Height          =   375
      Left            =   2880
      TabIndex        =   1
      Top             =   3960
      Width           =   1455
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   840
      TabIndex        =   0
      Text            =   "Text2"
      Top             =   600
      Width           =   3495
   End
   Begin VB.Label Label5 
      Caption         =   "Label5"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   960
      TabIndex        =   12
      Top             =   240
      Width           =   3375
   End
   Begin VB.Label Label4 
      Caption         =   "Código"
      Height          =   255
      Left            =   120
      TabIndex        =   11
      Top             =   240
      Width           =   615
   End
   Begin VB.Label Label3 
      Caption         =   "Setor"
      Height          =   255
      Left            =   120
      TabIndex        =   9
      Top             =   960
      Width           =   615
   End
   Begin VB.Label Label1 
      Caption         =   "Nome"
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   600
      Width           =   615
   End
   Begin VB.Label Label2 
      Caption         =   "CNPJs associados:"
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   1560
      Width           =   4095
   End
End
Attribute VB_Name = "FEditCrdName"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Obj As CCreditName



Public Sub showfor(x As CCreditName)
    Dim i As Integer, u As CNomeValor
    Set Obj = x
    CrNames.FillComboListWithSectors Me.Combo1
    Me.Label5 = x.Cod
    Me.Text2 = x.Nome
    Me.Combo1 = x.setor
    Me.List1.Clear
    For Each u In x.CNPJ
        Me.List1.AddItem u.Nome
    Next u
    Me.Show vbModal
End Sub


Private Sub Command1_Click()
    'OK
    Dim vai As Boolean, u As CNomeValor, msg As String, db As ADODB.Connection, rs As ADODB.Recordset
    'Verifica chave primária
    
    vai = True
    Set db = OpenTheDatabase
    For i = 0 To Me.List1.ListCount - 1
        Set rs = New ADODB.Recordset
        Call rs.open("SELECT * FROM TCNPJNOME WHERE CNPJ='" + Me.List1.List(i) + "' AND NOMECREDITO<>'" + Obj.Cod + "'", db, adOpenForwardOnly, adLockReadOnly)
        If Not rs.EOF Then
            vai = False
            msg = Me.List1.List(i)
        End If
    Next i
    
    If vai Then
        Obj.Nome = Me.Text2
        Obj.setor = Me.Combo1
        Set Obj.CNPJ = New Collection
        For i = 0 To Me.List1.ListCount - 1
            Set u = New CNomeValor
            u.Nome = Me.List1.List(i)
            u.NomeAlt = Obj.Cod
            Obj.CNPJ.Add u
        Next i
        Obj.WriteDB
        Me.Hide
        FMain.Refaz
    Else
        MsgBox ("CNPJ em duplicidade " + msg + vbCr + "Nada foi alterado.")
    End If
End Sub

Private Sub Command2_Click()
    Me.Hide
End Sub

Private Sub Command3_Click()
    Dim u(1000) As String, N As Integer
    If Text1 <> "" Then Me.List1.AddItem Text1
End Sub

Private Sub Command4_Click()
    Me.List1.RemoveItem (Me.List1.ListIndex)
End Sub

Public Sub newrefresh()
End Sub

