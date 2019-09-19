VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CCreditName"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public Cod As String
Public nome As String
Public setor As String

Public L_Score As String
Public DtScore As Date
Public L_ScoreW_1 As String
Public DtScoreW_1 As Date

'---Variáveis de acumulação de score médio
Private N_AvgScore As Integer
Private N_AvgScoreW_1 As Integer

'---CNPJs associados
Public CNPJ As Collection 'de NomeValor


Public Sub WriteDB()
    Dim db As Database, u As CNomeValor, rs As Recordset
    If MainStatus = "LIVE" Then
        Set db = OpenTheDatabase
        db.Execute ("DELETE FROM TRATINGNAMES WHERE ID='" + Me.Cod + "'")
        db.Execute ("INSERT INTO TRATINGNAMES (ID, NOME, SETOR) VALUES ('" + Me.Cod + "','" + Me.nome + "','" + Me.setor + "')")
        db.Execute ("DELETE FROM TCNPJNOME WHERE NOMECREDITO='" + Me.Cod + "'")
        For Each u In CNPJ
            Set rs = db.OpenRecordset("SELECT * FROM TCNPJNOME WHERE CNPJ='" + u.nome + "'")
            If rs.EOF _
                Then db.Execute ("INSERT INTO TCNPJNOME (CNPJ, NOMECREDITO) VALUES ('" + u.nome + "','" + Me.Cod + "')") _
                Else WriteLogError "CNPJ em Duplicidade. Não incluído", u.nome
        Next u
        db.Close
    End If
End Sub

Property Get CNPJDesc() As String
    Dim a As String, u As CNomeValor
    For Each u In CNPJ
        a = a + u.nome + "  "
    Next u
    CNPJDesc = a
End Property

Property Get Score() As String
    Score = L_Score
End Property

Property Let Score(x As String)
    L_Score = x
    N_AvgScore = 1
End Property

Property Get ScoreW_1() As String
    ScoreW_1 = L_ScoreW_1
End Property

Property Let ScoreW_1(x As String)
    L_ScoreW_1 = x
    N_AvgScoreW_1 = 1
End Property


Public Sub AverageScore(x As String)
    Dim pdtotal As Double
    pdtotal = (PDFromRating(Rating) * N_AvgScore + PDFromRating(RatingFromScore(x))) / (N_AvgScore + 1)
    L_Score = ScoreFromPD(pdtotal)
    N_AvgScore = N_AvgScore + 1
End Sub


Public Sub AverageScoreW_1(x As String)
    Dim pdtotal As Double
    pdtotal = (PDFromRating(RatingW_1) * N_AvgScoreW_1 + PDFromRating(RatingFromScore(x))) / (N_AvgScoreW_1 + 1)
    L_ScoreW_1 = ScoreFromPD(pdtotal)
    N_AvgScoreW_1 = N_AvgScoreW_1 + 1
End Sub


Property Get RatingAction() As String
    If Score = ScoreW_1 Then
        RatingAction = "-"
    ElseIf CredMelhor(Rating, RatingW_1) Then
        RatingAction = "UP"
    ElseIf CredMelhor(RatingW_1, Rating) Then
        RatingAction = "DOWN"
    Else
        RatingAction = "-"
    End If
End Property


Property Get Rating() As String
    Rating = RatingFromScore(L_Score)
End Property


Property Get RatingW_1() As String
    RatingW_1 = RatingFromScore(L_ScoreW_1)
End Property


Property Get ScoreNRating() As String
    If L_Score = "n/a" Or L_Score = "" Then ScoreNRating = L_Score Else ScoreNRating = L_Score + " (" + Rating + ")"
End Property


Property Get ScoreNRatingW_1() As String
    If L_ScoreW_1 = "n/a" Or L_ScoreW_1 = "" Then ScoreNRatingW_1 = L_ScoreW_1 Else ScoreNRatingW_1 = L_ScoreW_1 + " (" + RatingW_1 + ")"
End Property


Private Function RatingFromScore(x As String) As String
    If Left(x, 1) = "D" Then
        RatingFromScore = "CCC"
    Else
        Select Case x
            Case "", "-", "n/a"
                RatingFromScore = ""
            Case "IG1"
                RatingFromScore = "AAA"
            Case "IG2"
                RatingFromScore = "AA+"
            Case "IG3"
                RatingFromScore = "AA"
            Case "IG4"
                RatingFromScore = "AA-"
            Case "IG5"
                RatingFromScore = "A+"
            Case "IG6"
                RatingFromScore = "A"
            Case "IG7"
                RatingFromScore = "A-"
            Case "IG8"
                RatingFromScore = "BBB+"
            Case "IG9"
                RatingFromScore = "BBB"
            Case "IG10"
                RatingFromScore = "BBB-"
            Case "HY1"
                RatingFromScore = "BB+"
            Case "HY2"
                RatingFromScore = "BB"
            Case "HY3"
                RatingFromScore = "BB-"
            Case "HY4"
                RatingFromScore = "B+"
            Case "HY5"
                RatingFromScore = "B"
            Case "HY6"
                RatingFromScore = "B-"
            Case "DS1"
                RatingFromScore = "CCC"
            Case "DS2"
                RatingFromScore = "CC"
            Case "DS3", "DS4", "DS5"
                RatingFromScore = "C"
            Case Else
                RatingFromScore = "BB"
        End Select
    End If
End Function

Private Function ScoreFromPD(PD As Double) As String
    If PD <= Config.EDFAAA / 100 Then
        ScoreFromPD = "IG1"
    ElseIf PD <= (Config.EDFAAA + Config.EDFAA) / 200 Then
        ScoreFromPD = "IG2"
    ElseIf PD <= Config.EDFAA / 100 Then
        ScoreFromPD = "IG3"
    ElseIf PD <= (Config.EDFAA * 2 + Config.EDFA) / 300 Then
        ScoreFromPD = "IG4"
    ElseIf PD <= (Config.EDFAA + Config.EDFA * 2) / 300 Then
        ScoreFromPD = "IG5"
    ElseIf PD <= Config.EDFA / 100 Then
        ScoreFromPD = "IG6"
    ElseIf PD <= (Config.EDFA * 2 + Config.EDFBBB) / 300 Then
        ScoreFromPD = "IG7"
    ElseIf PD <= (Config.EDFA + Config.EDFBBB * 2) / 300 Then
        ScoreFromPD = "IG8"
    ElseIf PD <= Config.EDFBBB / 100 Then
        ScoreFromPD = "IG9"
    ElseIf PD <= (Config.EDFBBB * 2 + Config.EDFBB) / 300 Then
        ScoreFromPD = "IG10"
    ElseIf PD <= (Config.EDFBBB + Config.EDFBB * 2) / 300 Then
        ScoreFromPD = "HY1"
    ElseIf PD <= Config.EDFBB / 100 Then
        ScoreFromPD = "HY2"
    ElseIf PD <= (Config.EDFBB * 2 + Config.EDFB) / 300 Then
        ScoreFromPD = "HY3"
    ElseIf PD <= (Config.EDFBB + Config.EDFB * 2) / 300 Then
        ScoreFromPD = "HY4"
    ElseIf PD <= Config.EDFB / 100 Then
        ScoreFromPD = "HY5"
    ElseIf PD <= (Config.EDFB + Config.EDFCCC) / 200 Then
        ScoreFromPD = "HY6"
    Else
        ScoreFromPD = "DS1"
    End If
End Function
