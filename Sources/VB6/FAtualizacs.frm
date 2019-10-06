VERSION 5.00
Object = "{0D452EE1-E08F-101A-852E-02608C4D0BB4}#2.0#0"; "FM20.DLL"
Begin VB.Form FAtualizacs 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ultimas Atualizações"
   ClientHeight    =   6255
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5370
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6255
   ScaleWidth      =   5370
   StartUpPosition =   3  'Windows Default
   Begin MSForms.TextBox TextBox1 
      Height          =   2415
      Left            =   120
      TabIndex        =   2
      Top             =   3720
      Width           =   5175
      VariousPropertyBits=   -1400879077
      ScrollBars      =   2
      Size            =   "9128;4260"
      FontName        =   "Courier New"
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
   End
   Begin VB.Label Label2 
      Caption         =   "Data da última carteira dos fundos"
      Height          =   375
      Left            =   240
      TabIndex        =   1
      Top             =   3240
      Width           =   5055
   End
   Begin VB.Label Label1 
      Caption         =   "Label1"
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3015
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5055
   End
End
Attribute VB_Name = "FAtualizacs"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub newshow()
    Dim db As ADODB.Connection, rs As ADODB.Recordset, f As CFundo
    
    Set db = OpenTheDatabase
    
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT MAX(DATA) as A1 FROM TPAPELPROP", db, adOpenForwardOnly, adLockReadOnly)
    a1 = rs("A1")
    
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT MAX(DATA) as A1 FROM TPOSIC", db, adOpenForwardOnly, adLockReadOnly)
    a2 = rs("A1")
    
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT MAX(DATA) as A1 FROM TFACTORHIST", db, adOpenForwardOnly, adLockReadOnly)
    a3 = rs("A1")
        
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT MAX(DATAOBS) as A1 FROM TRESGATES", db, adOpenForwardOnly, adLockReadOnly)
    a4 = rs("A1")
    
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT MAX(DATAOBS) as A1 FROM TTRANSFERS", db, adOpenForwardOnly, adLockReadOnly)
    a5 = rs("A1")
    
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT MAX(DATAOBS) as A1 FROM TMAIORCOTISTA", db, adOpenForwardOnly, adLockReadOnly)
    a6 = rs("A1")
    
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT MAX(DATA) as A1 FROM TTRADES", db, adOpenForwardOnly, adLockReadOnly)
    a7 = rs("A1")
    
    Set rs = New ADODB.Recordset
    Call rs.open("SELECT MAX(ATUALIZADO) as A1 FROM TCTPT", db, adOpenForwardOnly, adLockReadOnly)
    a8 = rs("A1")
    
    
    Me.Label1 = "Atualização das Importações" + Chr(10) + _
                "---------------------------" + Chr(10) + _
                "Posição                   :" + Format(a2, "dd-MMM-yyyy") + Chr(10) + _
                "Mercado                   :" + Format(a3, "dd-MMM-yyyy") + Chr(10) + _
                "Resgate                   :" + Format(a4, "dd-MMM-yyyy") + Chr(10) + _
                "Transferência             :" + Format(a5, "dd-MMM-yyyy") + Chr(10) + _
                "Maior Cotista             :" + Format(a6, "dd-MMM-yyyy") + Chr(10) + _
                "Trade                     :" + Format(a7, "dd-MMM-yyyy") + Chr(10) + Chr(10) + _
                "Atualização da Base        " + Chr(10) + _
                "---------------------------" + Chr(10) + _
                "Propriedade dos Papéis    :" + Format(a1, "dd-MMM-yyyy") + Chr(10) + _
                "Contrapartes              :" + Format(a8, "dd-MMM-yyyy")

    a = ""
    For Each f In Fundos.c
        If f.area <> "EXTERNO" Then _
            a = a + FitString(f.nome, 26, "L") + ": " + Format(f.Dt_LastPortfolio, "dd-MMM-yyyy") + vbCr
    Next f
    Me.TextBox1 = a
    
    Me.Show
End Sub
