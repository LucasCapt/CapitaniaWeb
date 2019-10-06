VERSION 5.00
Begin VB.Form F_s_Purge 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Purge"
   ClientHeight    =   3915
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6465
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3915
   ScaleWidth      =   6465
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command5 
      Caption         =   "Delete todos"
      Height          =   375
      Left            =   4800
      TabIndex        =   14
      Top             =   2640
      Width           =   1575
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Delete todos"
      Height          =   375
      Left            =   4800
      TabIndex        =   11
      Top             =   3360
      Width           =   1575
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Elimine TODOS"
      Height          =   375
      Left            =   4800
      TabIndex        =   8
      Top             =   1920
      Width           =   1575
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Elimine esses"
      Height          =   375
      Left            =   4800
      TabIndex        =   7
      Top             =   1440
      Width           =   1575
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Elimine esses"
      Height          =   375
      Left            =   4800
      TabIndex        =   6
      Top             =   960
      Width           =   1575
   End
   Begin VB.Label Label12 
      Alignment       =   1  'Right Justify
      Caption         =   "Label1"
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
      TabIndex        =   16
      Top             =   2640
      Width           =   1095
   End
   Begin VB.Label Label11 
      Caption         =   "papéis vencidos há mais de 3 meses"
      Height          =   255
      Left            =   1200
      TabIndex        =   15
      Top             =   2760
      Width           =   3495
   End
   Begin VB.Label Label10 
      Caption         =   "papéis carregados."
      Height          =   255
      Left            =   1200
      TabIndex        =   13
      Top             =   120
      Width           =   4695
   End
   Begin VB.Label Label9 
      Alignment       =   1  'Right Justify
      Caption         =   "Label1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   0
      TabIndex        =   12
      Top             =   120
      Width           =   1095
   End
   Begin VB.Label Label8 
      Caption         =   "papéis usados pela última vez há mais de 2 anos"
      Height          =   255
      Left            =   1200
      TabIndex        =   10
      Top             =   3480
      Width           =   3495
   End
   Begin VB.Label Label7 
      Alignment       =   1  'Right Justify
      Caption         =   "Label1"
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
      TabIndex        =   9
      Top             =   3360
      Width           =   1095
   End
   Begin VB.Label Label6 
      Caption         =   "Gerados automaticamente"
      Height          =   255
      Left            =   1920
      TabIndex        =   5
      Top             =   1560
      Width           =   1935
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      Caption         =   "Label1"
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
      Left            =   1080
      TabIndex        =   4
      Top             =   1560
      Width           =   735
   End
   Begin VB.Label Label4 
      Caption         =   "Editados e/ou Liberados"
      Height          =   255
      Left            =   1920
      TabIndex        =   3
      Top             =   1080
      Width           =   1935
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      Caption         =   "Label1"
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
      Left            =   1080
      TabIndex        =   2
      Top             =   1080
      Width           =   735
   End
   Begin VB.Label Label2 
      Caption         =   "papéis sem uso em posições atuais ou anteriores (órfãos). Sendo:"
      Height          =   255
      Left            =   1200
      TabIndex        =   1
      Top             =   600
      Width           =   4695
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      Caption         =   "Label1"
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
      TabIndex        =   0
      Top             =   480
      Width           =   1095
   End
End
Attribute VB_Name = "F_s_Purge"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private OrfaoList As New Collection
Private OrfaoListA As New Collection
Private OrfaoListB As New Collection
Private VencidoList As New Collection
Private PassadoList As New Collection

Public Sub newshow()
    Dim p As CPapel, u As CNomeValor, achou As Boolean
Dim db As ADODB.Connection, rs As ADODB.Recordset, N As Integer, SouOrfao As Boolean, UltData As Date
    
    Me.Show
    Label1 = "(calc...)"
    Label3 = "(calc...)"
    Label5 = "(calc...)"
    Label7 = "(calc...)"
    Label12 = "(calc...)"
    Label9 = Str(Papeis.c.Count)
    Me.Refresh
    i = 0
    N = Papeis.c.Count
    
    'Identifica papéis a serem deletados
    
    Set db = OpenTheDatabase
    For Each p In Papeis.c
        i = i + 1
        Label1 = "(" + Format(i / (N + 1), "##0%") + ")"
        Me.Refresh
                
        If p.PosicTotalV = 0 Then
        
            'Verifica órfão
            SouOrfao = False
            Set rs = New ADODB.Recordset
            Call rs.open("SELECT * FROM TAKA WHERE FROMID='" + p.ID + "' OR TOID='" + p.ID + "'", db, adOpenForwardOnly, adLockReadOnly)
            If rs.EOF Then
                'Pode ser... não tem registro na AKA
                 Set rs = New ADODB.Recordset
                 Call rs.open("SELECT * FROM TPOSIC WHERE PAPEL='" + p.ID + "'", db, adOpenForwardOnly, adLockReadOnly)
                 If rs.EOF Then
                     'Papel é um órfão
                     OrfaoList.Add p, p.ID
                     If p.Status = "EDITADO" Or p.Status = "LIBERADO" Then OrfaoListA.Add p, p.ID Else OrfaoListB.Add p, p.ID
                     SouOrfao = True
                 End If
            End If
            
            'Verifica Vencido (que não seja PERP nem OVER nem tenha estado em Carteira após Venc+7)
            If p.Dt_Venc < BaseDate - 92 And p.Class_Rent <> "PERP" And p.Class_Rent <> "OVER" Then
                'Pode ser, mas checa se não esteve em nenhuma carteira após M-3
                Set rs = New ADODB.Recordset
                Call rs.open("SELECT * FROM TAKA WHERE (FROMID='" + p.ID + "' OR TOID='" + p.ID + "') AND (NOT DELETED OR DT_DELETED>" + SQLD(p.Dt_Venc + 7) + ")", db, adOpenForwardOnly, adLockReadOnly)
                If rs.EOF Then
                    'Pode ser... não existe em AKA ou foi deletado da AKA até Venc+7
                    Set rs = New ADODB.Recordset
                    Call rs.open("SELECT * FROM TPOSIC WHERE PAPEL='" + p.ID + "' AND DATA>" + SQLD(p.Dt_Venc + 7), db, adOpenForwardOnly, adLockReadOnly)
                    If rs.EOF Then
                        VencidoList.Add p, p.ID
                    End If
                End If
            End If
            
            'Verifica passado (não utilizado há mais de 2 anos)
            If Not SouOrfao Then
                'Não é órfão, mas pode estar passado
                Set rs = New ADODB.Recordset
                Call rs.open("SELECT * FROM TAKA WHERE (FROMID='" + p.ID + "' OR TOID='" + p.ID + "') AND (NOT DELETED OR DT_DELETED>" + SQLD(BaseDate - 730) + ")", db, adOpenForwardOnly, adLockReadOnly)
                If rs.EOF Then
                    'Pode ser... não existe em AKA ou foi deletado da AKA até 2Y-1
                    Set rs = New ADODB.Recordset
                    Call rs.open("SELECT * FROM TPOSIC WHERE PAPEL='" + p.ID + "' AND DATA>" + SQLD(BaseDate - 730), db, adOpenForwardOnly, adLockReadOnly)
                    If rs.EOF Then
                        PassadoList.Add p, p.ID
                    End If
                    
                End If
            End If

        End If 'posictotalv=0
    Next p
    
    'Reporta
    newrefresh
End Sub


Public Sub newrefresh()
    Label1 = Str(OrfaoList.Count)
    Label3 = Str(OrfaoListA.Count)
    Label5 = Str(OrfaoListB.Count)
    Label7 = Str(PassadoList.Count)
    Label12 = Str(VencidoList.Count)
    Label9 = Str(Papeis.c.Count)
    Me.Refresh
End Sub

Private Sub Command1_Click()
    'Eliminar Liberados
    Dim p As CPapel, db As ADODB.Connection, rs As ADODB.Recordset, p1 As CPapel
    
    Set db = OpenTheDatabase
    For Each p In OrfaoListA
        db.Execute ("DELETE FROM TPAPEL WHERE ID='" + p.ID + "'")
        db.Execute ("DELETE FROM TPAPELPROP WHERE PAPEL='" + p.ID + "'")
        Papeis.c.remove p.ID
        OrfaoList.remove p.ID
        OrfaoListA.remove p.ID
    Next p
    Papeis.Refresh
    newrefresh
    FMain.FazStatusBar

End Sub

Private Sub Command2_Click()
    'Elimina não editados
    Dim p As CPapel, db As ADODB.Connection, rs As ADODB.Recordset, p1 As CPapel
    
    Set db = OpenTheDatabase
    For Each p In OrfaoListB
        db.Execute ("DELETE FROM TPAPEL WHERE ID='" + p.ID + "'")
        db.Execute ("DELETE FROM TPAPELPROP WHERE PAPEL='" + p.ID + "'")
        Papeis.c.remove p.ID
        OrfaoList.remove p.ID
        OrfaoListB.remove p.ID
    Next p
    Papeis.Refresh
    newrefresh
    FMain.FazStatusBar

End Sub

Private Sub Command3_Click()
    'Eliminar TODOS
    Dim p As CPapel, db As ADODB.Connection, rs As ADODB.Recordset, p1 As CPapel
    
    Set db = OpenTheDatabase
    For Each p In OrfaoList
        db.Execute ("DELETE FROM TPAPEL WHERE ID='" + p.ID + "'")
        db.Execute ("DELETE FROM TPAPELPROP WHERE PAPEL='" + p.ID + "'")
        Papeis.c.remove p.ID
        OrfaoListA.remove p.ID
        OrfaoListB.remove p.ID
        OrfaoList.remove p.ID
    Next p
    Papeis.Refresh
    newrefresh
    FMain.FazStatusBar

End Sub


Private Sub Command4_Click()
    'Deletar os velhos
    Dim p As CPapel, db As ADODB.Connection, rs As ADODB.Recordset, p1 As CPapel
    
    Set db = OpenTheDatabase
    For Each p In PassadoList
        db.Execute ("UPDATE TPAPEL SET DELETED=TRUE, DT_DELETED=" + SQLD(BaseDate - 730) + " WHERE ID='" + p.ID + "'")
        Papeis.c.remove p.ID
        PassadoList.remove p.ID
    Next p
    Papeis.Refresh
    newrefresh
    FMain.FazStatusBar

End Sub

Private Sub Command5_Click()
    'Deletar os vencidos
    Dim p As CPapel, db As ADODB.Connection, rs As ADODB.Recordset, p1 As CPapel
    
    Set db = OpenTheDatabase
    For Each p In VencidoList
        db.Execute ("UPDATE TPAPEL SET DELETED=TRUE, DT_DELETED=" + SQLD(p.Dt_Venc + 7) + " WHERE ID='" + p.ID + "'")
        Papeis.c.remove p.ID
        VencidoList.remove p.ID
    Next p
    Papeis.Refresh
    newrefresh
    FMain.FazStatusBar

End Sub
