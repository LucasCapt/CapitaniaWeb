VERSION 5.00
Object = "{0D452EE1-E08F-101A-852E-02608C4D0BB4}#2.0#0"; "FM20.DLL"
Begin VB.Form FReplicaPos 
   Caption         =   "Replica Posição"
   ClientHeight    =   3000
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4185
   LinkTopic       =   "Form1"
   ScaleHeight     =   3000
   ScaleWidth      =   4185
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command2 
      Caption         =   "Cancelar"
      Height          =   375
      Left            =   2040
      TabIndex        =   11
      Top             =   2520
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Replicar"
      Height          =   375
      Left            =   3120
      TabIndex        =   10
      Top             =   2520
      Width           =   975
   End
   Begin VB.ComboBox Combo7 
      Height          =   315
      Left            =   0
      TabIndex        =   9
      Text            =   "Combo1"
      Top             =   1920
      Width           =   735
   End
   Begin VB.ComboBox Combo6 
      Height          =   315
      Left            =   840
      TabIndex        =   8
      Text            =   "Combo2"
      Top             =   1920
      Width           =   2175
   End
   Begin VB.ComboBox Combo5 
      Height          =   315
      Left            =   3120
      TabIndex        =   7
      Text            =   "Combo3"
      Top             =   1920
      Width           =   975
   End
   Begin VB.ComboBox Combo4 
      Height          =   315
      Left            =   0
      TabIndex        =   5
      Text            =   "Combo1"
      Top             =   1080
      Width           =   735
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      Left            =   840
      TabIndex        =   4
      Text            =   "Combo2"
      Top             =   1080
      Width           =   2175
   End
   Begin VB.ComboBox Combo3 
      Height          =   315
      Left            =   3120
      TabIndex        =   3
      Text            =   "Combo3"
      Top             =   1080
      Width           =   975
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   0
      TabIndex        =   1
      Text            =   "Combo1"
      Top             =   360
      Width           =   4095
   End
   Begin MSForms.Label Label3 
      Height          =   255
      Left            =   0
      TabIndex        =   6
      Top             =   1680
      Width           =   4095
      Caption         =   "Para a data:"
      Size            =   "7223;450"
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
   End
   Begin MSForms.Label Label2 
      Height          =   255
      Left            =   0
      TabIndex        =   2
      Top             =   840
      Width           =   4095
      Caption         =   "Da data:"
      Size            =   "7223;450"
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
   End
   Begin MSForms.Label Label1 
      Height          =   255
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4095
      Caption         =   "Replicar a carteira do fundo:"
      Size            =   "7223;450"
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
   End
End
Attribute VB_Name = "FReplicaPos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private mes As Variant
Private Fundo As CFundo

Public Sub newshow()
    mes = Array("Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro")
    Me.Combo4.Clear
    Me.Combo2.Clear
    Me.Combo3.Clear
    Me.Combo7.Clear
    Me.Combo6.Clear
    Me.Combo5.Clear
    Fundos.FillComboListWithNomes Me.Combo1
    For i = 1 To 31: Me.Combo4.AddItem (Str(i)): Me.Combo7.AddItem (Str(i)): Next i
    For i = 1 To 12: Me.Combo2.AddItem (mes(i - 1)): Me.Combo6.AddItem (mes(i - 1)): Next i
    For i = 0 To 5: Me.Combo3.AddItem (Str(Year(Now()) - i)): Me.Combo5.AddItem (Str(Year(Now()) - i)): Next i
    Me.Combo4 = Str(Day(BaseDate))
    Me.Combo2.ListIndex = Month(BaseDate) - 1
    Me.Combo3 = Str(Year(BaseDate))
    Me.Combo7 = Str(Day(BaseDate))
    Me.Combo6.ListIndex = Month(BaseDate) - 1
    Me.Combo5 = Str(Year(BaseDate))
    Me.Show vbModal
End Sub


Private Sub Combo1_lostfocus()
    Dim db As Database, rs As Recordset
    Set Fundo = Fundos.searchName(Combo1)
    If Not Fundo Is Nothing Then
        
        Set db = OpenTheDatabase
        Set rs = db.OpenRecordset("SELECT MAX (DATA) AS MAXDATA FROM TPOSIC WHERE FUNDO=" + Str(Fundo.ID))
        If Not rs.EOF Then
            Me.Combo4 = Str(Day(rs("MAXDATA")))
            Me.Combo2.ListIndex = Month(rs("MAXDATA")) - 1
            Me.Combo3 = Str(Year(rs("MAXDATA")))
        End If
    Else
        MsgBox ("Fundo Inexistente.")
    End If
    db.Close
End Sub

Private Sub Command1_Click()
    Dim db As Database, rs As Recordset, DataFrom As Date, DataTo As Date
    
    Set db = OpenTheDatabase
    If MainStatus <> "LIVE" Then
        MsgBox ("Não pode executar em modo simulado.")
    Else
        If Not Fundo Is Nothing Then
            DataFrom = DateSerial(Val(Combo3), Combo2.ListIndex + 1, Val(Combo4))
            DataTo = DateSerial(Val(Combo5), Combo6.ListIndex + 1, Val(Combo7))
            Set rs = db.OpenRecordset("SELECT * FROM TPOSIC WHERE FUNDO=" + Str(Fundo.ID) + " AND DATA =" + SQLD(DataTo))
            If rs.EOF Then
                vai = True
            Else
                vai = (MsgBox("O fundo " + vbCr + Fundo.nome + vbCr + "já tem posição para a data " + Format(DataTo, "dd-MMM-yyyy") + "." + vbCr + "Sobreescreve", vbQuestion + vbYesNo) = vbYes)
            End If
            If vai Then
                If MsgBox("Confirma cópia da carteira do fundo" + vbCr + Fundo.nome + vbCr + "da data " + Format(DataFrom, "dd-MMM-yyyy") + vbCr + "para a data " + Format(DataTo, "dd-MMM-yyyy"), vbQuestion + vbYesNo) = vbYes Then
                    
                    Set db = OpenTheDatabase
                    db.Execute ("DELETE FROM TPOSIC WHERE FUNDO=" + Str(Fundo.ID) + " AND DATA =" + SQLD(DataTo))
                    Set rs = db.OpenRecordset("SELECT * FROM TPOSIC WHERE FUNDO=" + Str(Fundo.ID) + " AND DATA =" + SQLD(DataFrom))
                    While Not rs.EOF
                        db.Execute ("INSERT INTO TPOSIC (FUNDO, PAPEL, ISIN, VALOR, DATA, TIPO, QUANT, BLOQUEADO) VALUES (" + _
                            Str(Fundo.ID) + ",'" + _
                            CritS(rs("PAPEL")) + "','" + _
                            CritS(rs("ISIN")) + "'," + _
                            Str(CritNN(rs("VALOR"))) + "," + _
                            SQLD(DataTo) + "," + _
                            Str(CritN(rs("TIPO"))) + "," + _
                            Str(CritNN(rs("QUANT"))) + "," + _
                            Str(CritNN(rs("BLOQUEADO"))) + ")")
                        rs.MoveNext
                    Wend
                    db.Close
                    MsgBox ("Replicação concluída")
                    Me.Hide
                Else
                    MsgBox ("Operação cancelada")
                End If
            Else
                MsgBox ("Operação cancelada")
            End If 'Vai
        Else
            MsgBox ("Fundo Inexistente.")
        End If
    End If
End Sub

Private Sub Command2_Click()
    Me.Hide
End Sub
