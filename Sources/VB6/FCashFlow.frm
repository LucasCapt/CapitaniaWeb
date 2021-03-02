VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0D452EE1-E08F-101A-852E-02608C4D0BB4}#2.0#0"; "FM20.DLL"
Begin VB.Form FCashFlow 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Form1"
   ClientHeight    =   7635
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5190
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7635
   ScaleWidth      =   5190
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   6495
      Left            =   0
      TabIndex        =   0
      Top             =   600
      Width           =   5175
      _ExtentX        =   9128
      _ExtentY        =   11456
      _Version        =   393216
   End
   Begin VB.Label Label1 
      Caption         =   "Datas em mm/dd/yyyy"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   7200
      Width           =   2175
   End
   Begin MSForms.CommandButton CommandButton1 
      Height          =   375
      Left            =   3000
      TabIndex        =   2
      Top             =   7200
      Width           =   2175
      BackColor       =   -2147483626
      Caption         =   "Paste Fluxo de Caixa (Ct-V)"
      Size            =   "3836;661"
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
      ParagraphAlign  =   3
   End
   Begin VB.Label LWarn 
      BackColor       =   &H000000FF&
      Caption         =   "O fluxo de caixa deste papel não está cadastrado. O fluxo abaixo é INDICATIVO."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000014&
      Height          =   615
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   5175
   End
End
Attribute VB_Name = "FCashFlow"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private OKMode As Integer
Private Obj As CPapel

Public Sub showfor(x As CPapel)
    Set Obj = x
    Me.Caption = "Cash flow de " + x.nome
    OKMode = 1
    Grid.Rows = 1
    Grid.FormatString = "Data                    |>Principal            |>Juros              "
    newrefresh
    Me.Show
End Sub

Public Sub newrefresh()
    Dim L As Integer
    LWarn.Visible = Not Obj.CFFound
    Grid.Rows = 1
    L = 0
    For i = 1 To Obj.CF_NFlows
        If Obj.CF_Dt(i) > BaseDate Then
            L = L + 1
            Grid.AddItem Format(Obj.CF_Dt(i), "dd-MMM-yy")
            Grid.TextMatrix(L, 1) = Format(Obj.CF_Pr(i), "##0.0000")
            Grid.TextMatrix(L, 2) = Format(Obj.CF_Ju(i), "##0.0000")
        End If
    Next i
End Sub


Private Sub CommandButton1_Click()
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset, x As CFundo, s1 As String, s2 As String, key As String
    Select Case OKMode
        Case 1
            If Not PasteCF Then MsgBox ("Erros encontrados no Paste")
            Me.Refresh
        Case 2
            'Faz a importação para o Database
            
            Set db = OpenTheDatabase
            If Obj.IDFluxo <> "" Then
                key = Obj.IDFluxo
            ElseIf Obj.CodCetip <> "" Then
                key = Obj.CodCetip
            Else
                key = Obj.ID
            End If
            Obj.IDFluxo = key
            If MainStatus = "LIVE" Then
                db.Execute ("UPDATE TPAPEL SET CASHFLOW_ID='" + key + "' WHERE ID='" + Obj.ID + "'")
                db.Execute ("UPDATE TFLUXOS SET DELETED = 1 , DT_DELETED=" + SQLBaseDate + " WHERE IDFLUXO='" + key + "' AND DELETED = 0")
            End If
            Obj.ResetCFlow
            For i = 1 To Grid.Rows - 1
                Obj.IncluiCFlow CDate(Grid.TextMatrix(i, 0)), Val_1(Grid.TextMatrix(i, 1)), Val_1(Grid.TextMatrix(i, 2))
                If MainStatus = "LIVE" Then _
                    db.Execute ("INSERT INTO TFLUXOS (IDFLUXO, DATA, AMORT, JUROS, DT_CREATED, DELETED, DT_DELETED) VALUES ('" + _
                    key + "', " + _
                    SQLD(CDate(Grid.TextMatrix(i, 0))) + ", " + _
                    Str(Val_1(Grid.TextMatrix(i, 1))) + ", " + _
                    Str(Val_1(Grid.TextMatrix(i, 2))) + ", " + _
                    SQLBaseDate + ",0," + SQLBaseDate + ")")
            Next i
            Obj.CFFound = True
            Obj.FazFluxo
            Fundos.RecalcWRespectTo Obj
            OKMode = 1
            CommandButton1.BackColor = &H80000016
            CommandButton1.Caption = "Paste Fluxo de Caixa (Ct-V)"
            newrefresh
            FMain.Refaz
            Me.Hide
    End Select
End Sub

Private Function Val_1(x As String) As Double
    Dim a As String, m As Double
    m = 1
    If Right(x, 1) < " " And Len(x) > 1 Then
        a = Left(x, Len(x) - 1)
    Else
        a = x
    End If
    
    If Right(a, 1) = "%" And Len(a) > 1 Then
        a = Left(a, Len(a) - 1)
        m = 0.01
    End If
    
    If IsNumeric(a) Then
        Val_1 = Val(a) * m
    Else
        Val_1 = 0
    End If
End Function


Private Sub Grid_keypress(keyascii As Integer)
    If keyascii = 3 Then CopyRangeToClipboard Grid
    If keyascii = 22 Then PasteCF
End Sub


Private Function PasteCF() As Boolean
    Dim a As String, b As String, vai As Boolean
    
    a = Clipboard.GetText
    If Len(a) > 0 Then
        vai = True
        L = 1
        j = 0
        Grid.Rows = 2
        i = 1
        While i < Len(a) And vai
            If Mid(a, i, 1) = Chr(10) Then
                If b = "" Then
                    MsgBox ("Possível erro no formato da importação." + Chr(10) + "Copie matriz N linhas x 3 colunas.")
                    vai = False
                End If
                If Right(b, 1) = Chr(13) Then b = Left(b, Len(b) - 1)
                Grid.TextMatrix(L, j) = b
                If i < Len(a) Then Grid.AddItem " "
                L = L + 1
                j = 0
                b = ""
            ElseIf Mid(a, i, 1) = Chr(9) Then
                If j = 0 Then
                    b = convertedata(b)
                    If Not IsDate(b) Then
                        MsgBox ("Possível erro no formato da data." + Chr(10) + "Copie datas no formato dd/MM/yyyy.")
                        vai = False
                    ElseIf Year(CDate(b)) < 2000 Then
                        MsgBox ("Possível erro no formato da data." + Chr(10) + "Copie datas no formato dd/MM/yyyy.")
                        vai = False
                    End If
                End If
                If b = "" Then
                    MsgBox ("Possível erro no formato da importação." + Chr(10) + "Copie matriz N linhas x 3 colunas.")
                    vai = False
                End If
                Grid.TextMatrix(L, j) = b
                If j < 2 Then j = j + 1
                b = ""
            Else
                b = b + Mid(a, i, 1)
            End If
            i = i + 1
        Wend
        
        If vai Then
            OKMode = 2
            CommandButton1.BackColor = &H80FF&
            CommandButton1.Caption = "Importa Fluxo de Caixa"
        End If
        PasteCF = vai
    Else
        PasteCF = False
    End If
End Function

Private Function convertedata(x As String) As String
    convertedata = ""
    i = InStr(x, "/")
    If i > 0 Then
        mes = Val(Left(x, i - 1))
        If mes <= 12 Then
            u = Mid(x, i + 1)
            i = InStr(u, "/")
            If i > 0 Then
                dia = Val(Left(u, i - 1))
                ano = Val(Mid(u, i + 1))
                convertedata = Format(DateSerial(ano, mes, dia), "dd-MMM-yyyy")
            End If
        End If
    End If
End Function
