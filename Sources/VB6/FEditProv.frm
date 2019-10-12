VERSION 5.00
Begin VB.Form FEditProv 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Registro de Provisão"
   ClientHeight    =   4245
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   4965
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4245
   ScaleWidth      =   4965
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox I_DataProv 
      Height          =   285
      Left            =   1680
      TabIndex        =   17
      Text            =   "Text1"
      Top             =   1200
      Width           =   1575
   End
   Begin VB.CommandButton B_OK 
      Caption         =   "OK"
      Height          =   375
      Left            =   3720
      TabIndex        =   16
      Top             =   3720
      Width           =   1095
   End
   Begin VB.CommandButton B_CANCEL 
      Caption         =   "Cancela"
      Height          =   375
      Left            =   2400
      TabIndex        =   15
      Top             =   3720
      Width           =   1095
   End
   Begin VB.ComboBox I_TIPO 
      Height          =   315
      ItemData        =   "FEditProv.frx":0000
      Left            =   1680
      List            =   "FEditProv.frx":0010
      TabIndex        =   14
      Text            =   "Combo1"
      Top             =   3240
      Width           =   3135
   End
   Begin VB.TextBox I_DESC 
      Height          =   285
      Left            =   1680
      TabIndex        =   13
      Text            =   "Text1"
      Top             =   2880
      Width           =   3135
   End
   Begin VB.TextBox I_COD 
      Height          =   285
      Left            =   1680
      TabIndex        =   12
      Text            =   "Text1"
      Top             =   2520
      Width           =   3135
   End
   Begin VB.TextBox I_ISIN 
      Height          =   285
      Left            =   1680
      TabIndex        =   11
      Text            =   "Text1"
      Top             =   2160
      Width           =   3135
   End
   Begin VB.ComboBox I_Fundo 
      Height          =   315
      Left            =   1680
      TabIndex        =   3
      Text            =   "Combo1"
      Top             =   480
      Width           =   3135
   End
   Begin VB.TextBox I_CodProv 
      Height          =   285
      Left            =   1680
      TabIndex        =   2
      Text            =   "Text1"
      Top             =   840
      Width           =   1575
   End
   Begin VB.Label Label9 
      Caption         =   "Tipo do papel"
      Height          =   255
      Left            =   120
      TabIndex        =   10
      Top             =   3240
      Width           =   1455
   End
   Begin VB.Label Label8 
      Caption         =   "Identificação do papel destino:"
      Height          =   375
      Left            =   120
      TabIndex        =   9
      Top             =   1680
      Width           =   4575
   End
   Begin VB.Line Line1 
      X1              =   120
      X2              =   4680
      Y1              =   1560
      Y2              =   1560
   End
   Begin VB.Label Label7 
      Caption         =   "Identificação da provisão:"
      Height          =   375
      Left            =   120
      TabIndex        =   8
      Top             =   120
      Width           =   4575
   End
   Begin VB.Label Label6 
      Caption         =   "Descrição"
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   2880
      Width           =   1455
   End
   Begin VB.Label Label5 
      Caption         =   "Código do papel"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   2520
      Width           =   1455
   End
   Begin VB.Label Label4 
      Caption         =   "ISIN do papel"
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   2160
      Width           =   1455
   End
   Begin VB.Label Label3 
      Caption         =   "Data da Provisão"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   1200
      Width           =   1455
   End
   Begin VB.Label Label2 
      Caption         =   "Código da Provisão"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   840
      Width           =   1455
   End
   Begin VB.Label Label1 
      Caption         =   "Fundo"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   480
      Width           =   1455
   End
End
Attribute VB_Name = "FEditProv"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private ForWhat As String
Private Obj As CProvFilterElement
Private Col As Collection

Public Sub showfor(What As String, x As CProvFilterElement, Optional c As Collection)
    Dim z As CProvFilterElement, f As CFundo, y As Control
    
    ForWhat = What
    Set Col = c
    Set Obj = x
    
    Set f = Fundos.search(x.Fundo)
    Fundos.FillComboListWithNomes Me.I_Fundo
    
    Me.I_COD = Obj.PPCod
    Me.I_CodProv = Obj.ProvCod
    Me.I_DESC = Obj.Descr
    If f Is Nothing Then Me.I_Fundo = Obj.Fundo Else Me.I_Fundo = f.nome
    Me.I_ISIN = Obj.PPISIN
    Me.I_DataProv = Obj.ProvData
    Me.I_TIPO = Obj.PPTipo
    
    For Each y In Me.Controls
        If Left(y.Name, 1) = "I" Then y.Enabled = (ForWhat <> "VIEW")
    Next y
    
    Me.Show
End Sub

Private Sub B_Cancel_Click()
    Me.Hide
End Sub

Private Sub B_OK_Click()
    Dim db As ADODB.Connection, f As CFundo, vai As Boolean, y As CProvFilterElement
        
    vai = True
    If IsNumeric(Me.I_Fundo) Then
        Obj.Fundo = Val(Me.I_Fundo)
    Else
        Set f = Fundos.searchName(Me.I_Fundo)
        If f Is Nothing Then
            MsgBox ("Fundo " + Me.I_Fundo + " não existente.")
            vai = False
        Else
            Obj.Fundo = f.ID
        End If
    End If
    Obj.Descr = Me.I_DESC
    Obj.PPCod = Me.I_COD
    Obj.PPISIN = Me.I_ISIN
    Obj.PPTipo = Me.I_TIPO
    Obj.ProvCod = Me.I_CodProv
    Obj.ProvData = Me.I_DataProv

    If vai Then
        Select Case ForWhat
            Case "VIEW"
                'nada
            Case "NEW"
                If Obj.IDUnica = 0 Then
                    'Verifica se há duplicado
                    For Each y In Col
                        If y.Fundo = Obj.Fundo And y.ProvCod = Obj.ProvCod And y.ProvData = Obj.ProvData Then
                            MsgBox ("Já existe um filtro de provisão para mesmo fundo, data e código" + vbCr + "Não pode incluir")
                            vai = False
                        End If
                    Next y
                
                    If vai Then
                        Set db = OpenTheDatabase
                        db.Execute ("INSERT INTO TPROVFILTER (FUNDO, PROV_COD, PROV_DATA, PP_ISIN, PP_COD, DESCR, PP_TIPO, DT_CREATED, DT_DELETED, DELETED) VALUES (" + Str(Obj.Fundo) + ", '" + Obj.ProvCod + "', '" + _
                        Obj.ProvData + "','" + Obj.PPISIN + "', '" + Obj.PPCod + "', '" + Obj.Descr + "', '" + Obj.PPTipo + "', " + SQLBaseDate + ", " + SQLBaseDate + ", 0)")
                        WriteLog ("EDITOU PROVISAO NOVA")
                        Disclaimer
                        If FProvFilter.Visible Then FProvFilter.newrefresh
                    End If
                Else
                    MsgBox ("Registro já existente na base.")
                    vai = False
                End If
            Case "EDIT"
                If Obj.IDUnica > 0 Then
                    Set db = OpenTheDatabase
                    db.Execute ("UPDATE TPROVFILTER SET FUNDO =" + Str(Obj.Fundo) + ", PROV_COD='" + Obj.ProvCod + "', PROV_DATA='" + _
                    Obj.ProvData + "',PP_ISIN='" + Obj.PPISIN + "', PP_COD='" + Obj.PPCod + "', DESCR='" + Obj.Descr + "', PP_TIPO='" + Obj.PPTipo + "' WHERE IDUNICA=" + Str(Obj.IDUnica))
                    WriteLog ("EDITOU PROVISAO " + Str(Obj.IDUnica))
                    Disclaimer
                    If FProvFilter.Visible Then FProvFilter.newrefresh
                Else
                    MsgBox ("Não há registro na base para alterar.")
                    vai = False
                End If
        End Select
        If vai Then Me.Hide
    End If
End Sub


Private Sub Disclaimer()
    MsgBox ("As alterações efetuadas só têm efeito na importação de carteira XML." + vbCr + "Nada foi alterado nas carteiras atuais.")
End Sub



