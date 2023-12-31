VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CCreditNames"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

Public c As Collection

Public Sub Init()
    Dim db As ADODB.Connection, rs As ADODB.Recordset, rs1 As ADODB.Recordset, u As CCreditName, uu As CNomeValor, d As Date, r As String
    
    'L� os nomes de cr�dito
        Set c = New Collection
        Set db = OpenTheDatabase(True)
        Set rs = New ADODB.Recordset
        Call rs.open("SELECT * FROM TRATINGNAMES ORDER BY SETOR, NOME", db, adOpenForwardOnly, adLockReadOnly)
        If Not rs.EOF Then rs.MoveFirst
        While Not rs.EOF
            DoEvents
            Set u = New CCreditName
            u.Nome = rs("NOME")
            u.Cod = rs("ID")
            u.setor = rs("SETOR")
            Call FStart.Say("Atualizando nomes: " & u.Nome)
            
            '--Le os cnpjs
            Set u.CNPJ = New Collection
            Set rs1 = New ADODB.Recordset
            Call rs1.open("SELECT * FROM TCNPJNOME WHERE NOMECREDITO='" + u.Cod + "'", db, adOpenForwardOnly, adLockReadOnly)
            While Not rs1.EOF
                DoEvents
                Set uu = New CNomeValor
                uu.Nome = rs1("CNPJ")
                uu.NomeAlt = rs1("NOMECREDITO")
                u.CNPJ.Add uu
                rs1.MoveNext
            Wend
            c.Add u
            rs.MoveNext
        Wend
    
    'L� o �ltimo score (m�dia d a d-7) e o W-1 (m�dia d-14 a d-7)

        For Each u In c
            DoEvents
            Set rs = New ADODB.Recordset
            Call FStart.Say("Atualizando nomes: " & u.Nome)
            Call rs.open("SELECT * FROM TRATINGS WHERE ID='" + u.Cod + "' AND DATA<=" + SQLBaseDate + " ORDER BY DATA DESC", db, adOpenForwardOnly, adLockReadOnly)
            If rs.EOF Then
                u.Score = "n/a"
                u.ScoreW_1 = "n/a"
            Else
                rs.MoveFirst
                u.Score = rs("RATING")
                u.DtScore = rs("DATA")
                d = rs("DATA")
                While d > BaseDate - 7 And Not rs.EOF
                    DoEvents
                    d = rs("DATA")
                    r = rs("RATING")
                    u.AverageScore (r)
                    rs.MoveNext
                Wend
                If d > BaseDate - 7 Then
                    u.Score = "n/a"
                    u.ScoreW_1 = "n/a"
                Else
                    u.ScoreW_1 = r
                    u.DtScoreW_1 = d
                    While d > BaseDate - 14 And Not rs.EOF
                        DoEvents
                        u.AverageScoreW_1 (rs("RATING"))
                        d = rs("DATA")
                        rs.MoveNext
                    Wend
                End If
            End If
        Next u
    
End Sub

Public Function SearchCreditName(ID As String) As CCreditName
    Dim a As CCreditName
    Set SearchCreditName = Nothing
    For Each a In c
        If UCase(a.Cod) = UCase(ID) Then Set SearchCreditName = a
    Next a
End Function

Public Function SearchCreditNameByName(Nome As String) As CCreditName
    Dim a As CCreditName
    Set SearchCreditNameByName = Nothing
    For Each a In c
        If UCase(a.Nome) = UCase(Nome) Then Set SearchCreditNameByName = a
    Next a
End Function

Public Sub Cria(Optional setor As String = "")
    Dim novoID As String, NovoNome As CCreditName
    novoID = FInput.Pergunte("C�digo do novo Nome de Cr�dito")
    If novoID = "" Then
        MsgBox ("C�digo inv�lido.")
    ElseIf Not SearchCreditName(novoID) Is Nothing Then
        MsgBox ("C�digo j� existente.")
    Else
        Set NovoNome = New CCreditName
        NovoNome.Cod = novoID
        NovoNome.setor = setor
        Set NovoNome.CNPJ = New Collection
        c.Add NovoNome
        FEditCrdName.showfor NovoNome
    End If
End Sub

Public Sub Deleta(x As CCreditName)
    Dim db As ADODB.Connection, vai As Boolean, i As Integer, CR As Integer
    vai = True
    CR = Papeis.QuemUsaCrName(x.Cod)
    If CR > 0 Then vai = (MsgBox("O nome cr�dito " + x.Cod + " (" + x.Nome + ") � utilizado por " + Str(CR) + " pap�is." + vbCr + "Deseja excluir mesmo assim?", vbYesNo) = vbYes)
    If vai Then
        Set db = OpenTheDatabase
        db.Execute ("DELETE FROM TCNPJNOME WHERE NOMECREDITO='" + x.Cod)
        db.Execute ("DELETE FROM TRATINGNAMES WHERE ID='" + x.Cod)
        For i = 1 To c.Count
            If c(i) Is x Then c.remove i
        Next i
        Fundos.RecalcRisk
        FMain.Refaz
    End If
End Sub


Public Sub FillComboListWithSectors(x As ComboBox)
    Dim f As CCreditName, f1 As CCreditName, h As New Collection
    x.Clear
    For Each f In c
        achou = False
        For Each f1 In h
            If f1.setor = f.setor Then achou = True
        Next f1
        If Not achou Then h.Add f
    Next f
    
    For Each f In h
        x.AddItem f.setor
    Next f
End Sub

