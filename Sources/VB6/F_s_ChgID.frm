VERSION 5.00
Begin VB.Form F_s_ChgID 
   Caption         =   "Trocar ID de Título"
   ClientHeight    =   4725
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   3315
   LinkTopic       =   "Form1"
   ScaleHeight     =   4725
   ScaleWidth      =   3315
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command2 
      Caption         =   "Cancela"
      Height          =   495
      Left            =   120
      TabIndex        =   7
      Top             =   4200
      Width           =   3135
   End
   Begin VB.CommandButton Command1 
      Caption         =   "CONFIRMA"
      Height          =   495
      Left            =   120
      TabIndex        =   6
      Top             =   3600
      Width           =   3135
   End
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   120
      TabIndex        =   3
      Text            =   "Text1"
      Top             =   1320
      Width           =   3135
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   120
      TabIndex        =   1
      Text            =   "Combo1"
      Top             =   480
      Width           =   3135
   End
   Begin VB.Label Label4 
      Caption         =   "Ela mudará a ID para todas as datas anteriores"
      Height          =   495
      Left            =   120
      TabIndex        =   5
      Top             =   3000
      Width           =   3015
   End
   Begin VB.Label Label3 
      Caption         =   $"F_s_ChgID.frx":0000
      Height          =   1095
      Left            =   120
      TabIndex        =   4
      Top             =   1800
      Width           =   3015
   End
   Begin VB.Label Label2 
      Caption         =   "Nova ID:"
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
      Left            =   120
      TabIndex        =   2
      Top             =   960
      Width           =   3135
   End
   Begin VB.Label Label1 
      Caption         =   "ID que será trocada:"
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
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3135
   End
End
Attribute VB_Name = "F_s_ChgID"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub newshow()
    Dim pp As CPapel
    
    Papeis.FillComboWithNames Me.Combo1
    If Fpapel.Visible Then Set pp = Fpapel.PointedObject
    If Not pp Is Nothing Then
        Me.Combo1 = pp.nome
        Me.Text1 = pp.ISIN
    Else
        Me.Combo1 = ""
        Me.Text1 = ""
    End If
    
    Me.Show vbModal
End Sub

Private Sub Command1_Click()
    Dim db As Database, IDVelho As String, IDNovo As String

    'Executa
    IDVelho = Me.Combo1
    IDNovo = Me.Text1
    If MsgBox("Confirma a substituição do ID de Título" + vbCr + IDVelho + vbCr + "pela ID nova" + vbCr + IDNovo, vbYesNo) = vbYes Then
        Me.Hide
        Set db = OpenTheDatabase
            FStart.Show vbModeless
            FStart.Say ("Substitui ID em Títulos...")
            db.Execute ("UPDATE TPAPEL SET ID='" + IDNovo + "' WHERE ID='" + IDVelho + "'")
            
            FStart.Say ("Substitui ID em Posições...")
            db.Execute ("UPDATE TPOSIC SET PAPEL='" + IDNovo + "' WHERE PAPEL='" + IDVelho + "'")
        
            FStart.Say ("Substitui ID em AKA...")
            db.Execute ("UPDATE TAKA SET FROMID='" + IDNovo + "' WHERE FROMID='" + IDVelho + "'")
            db.Execute ("UPDATE TAKA SET TOID='" + IDNovo + "' WHERE TOID='" + IDVelho + "'")
            db.Execute ("DELETE FROM TAKA WHERE TOID = FROMID")
        
            FStart.Say ("Substitui ID em Propriedades...")
            db.Execute ("UPDATE TPAPELPROP SET PAPEL='" + IDNovo + "' WHERE PAPEL='" + IDVelho + "'")
            
            FStart.Say ("Substitui ID em Trades...")
            db.Execute ("UPDATE TTRADES SET ATIVO='" + IDNovo + "' WHERE ATIVO='" + IDVelho + "'")
            
            MsgBox ("substituição concluída.")
            
            ResetAll FStart
            FMain.Refaz
            FStart.Hide
        db.Close
    Else
        MsgBox ("Substituição cancelada.")
        Me.Hide
    End If
End Sub

Private Sub Command2_Click()
    MsgBox ("Substituição cancelada.")
    Me.Hide
End Sub
