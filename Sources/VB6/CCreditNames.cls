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
    Dim db As Database, rs As Recordset, rs1 As Recordset, u As CCreditName, uu As CNomeValor, d As Date, r As String
    
    'Lê os nomes de crédito
        Set c = New Collection
        Set db = OpenTheDatabase
        Set rs = db.OpenRecordset("SELECT * FROM TRATINGNAMES ORDER BY SETOR, NOME")
        If Not rs.EOF Then rs.MoveFirst
        While Not rs.EOF
            Set u = New CCreditName
            u.nome = rs("NOME")
            u.Cod = rs("ID")
            u.setor = rs("SETOR")
            
            '--Le os cnpjs
            Set u.CNPJ = New Collection
            Set rs1 = db.OpenRecordset("SELECT * FROM TCNPJNOME WHERE NOMECREDITO='" + u.Cod + "'")
            While Not rs1.EOF
                Set uu = New CNomeValor
                uu.nome = rs1("CNPJ")
                uu.NomeAlt = rs1("NOMECREDITO")
                u.CNPJ.Add uu
                rs1.MoveNext
            Wend
            c.Add u
            rs.MoveNext
        Wend
    
    'Lê o último score (média d a d-7) e o W-1 (média d-14 a d-7)

        For Each u In c
        
            Set rs = db.OpenRecordset("SELECT * FROM TRATINGS WHERE ID='" + u.Cod + "' AND DATA<=" + SQLBaseDate + " ORDER BY DATA DESC")
            If rs.EOF Then
                u.Score = "n/a"
                u.ScoreW_1 = "n/a"
            Else
                rs.MoveFirst
                u.Score = rs("RATING")
                u.DtScore = rs("DATA")
                d = rs("DATA")
                While d > BaseDate - 7 And Not rs.EOF
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
                        u.AverageScoreW_1 (rs("RATING"))
                        d = rs("DATA")
                        rs.MoveNext
                    Wend
                End If
            End If
        Next u
    
    db.Close
End Sub

Public Function SearchCreditName(ID As String) As CCreditName
    Dim a As CCreditName
    Set SearchCreditName = Nothing
    For Each a In c
        If UCase(a.Cod) = UCase(ID) Then Set SearchCreditName = a
    Next a
End Function

Public Function SearchCreditNameByName(nome As String) As CCreditName
    Dim a As CCreditName
    Set SearchCreditNameByName = Nothing
    For Each a In c
        If UCase(a.nome) = UCase(nome) Then Set SearchCreditNameByName = a
    Next a
End Function

Public Sub Cria(Optional setor As String = "")
    Dim novoID As String, NovoNome As CCreditName
    novoID = FInput.Pergunte("Código do novo Nome de Crédito")
    If novoID = "" Then
        MsgBox ("Código inválido.")
    ElseIf Not SearchCreditName(novoID) Is Nothing Then
        MsgBox ("Código já existente.")
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
    Dim db As Database, vai As Boolean, i As Integer, CR As Integer
    vai = True
    CR = Papeis.QuemUsaCrName(x.Cod)
    If CR > 0 Then vai = (MsgBox("O nome crédito " + x.Cod + " (" + x.nome + ") é utilizado por " + Str(CR) + " papéis." + vbCr + "Deseja excluir mesmo assim?", vbYesNo) = vbYes)
    If vai Then
        Set db = OpenTheDatabase
        db.Execute ("DELETE FROM TCNPJNOME WHERE NOMECREDITO='" + x.Cod)
        db.Execute ("DELETE FROM TRATINGNAMES WHERE ID='" + x.Cod)
        db.Close
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

