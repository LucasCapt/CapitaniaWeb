VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CTrade"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public ID As Long
Public Data As Date
Public Broker As String
Public Fundo As String
Public Ativo As String
Public CV As String
Public Quant As Double
Public Taxa As Double
Public PU As Double
Public Produto As String
Public NomeAtivo As String
Public ValFin As Double
Public Hora As Date
Public Hora_ms As Double

Public MyFund As CFundo
Public MyPaper As CPapel
Public MyPosic As CPosic
Public Addr As String   'status do endereçamento

Public Comparavel As Double
Public BandaLow As Double
Public BandaHigh As Double
Public BandaLow2 As Double
Public BandaHigh2 As Double

Public Compliant As String
Public Points As Integer
Public ExtPoints As Integer

Public ComplAlloc As String
Public VAlloc As Double
Public QAlloc As Double
Public PAlloc As Double
Public VAlloc1 As Double
Public QAlloc1 As Double
Public PAlloc1 As Double


Property Get Timestamp() As String
    Timestamp = Format(Hora, "HH:MM:SS") + Right(Format(Hora_ms - Int(Hora_ms), "#.00"), 3)
End Property

Property Get value() As Double
    If ValFin = 0 Then value = Quant * PU Else value = ValFin
End Property

Property Get ValFinCV() As Double
    If CV = "C" Then ValFinCV = value Else ValFinCV = -value
End Property


Property Get QuantCV() As Double
    If CV = "C" Then QuantCV = Quant Else QuantCV = -Quant
End Property

Public Sub Endereca()
    Set MyFund = Fundos.searchNameBlotter(Fundo)
    Set MyPaper = Papeis.searchCETIP(Ativo)
    If MyPaper Is Nothing Then Set MyPaper = Papeis.search(Ativo)
    If MyPaper Is Nothing Then Set MyPaper = Papeis.searchISIN(Ativo)
    If MyPaper Is Nothing Then Set MyPaper = Papeis.searchName(Ativo)
    Addr = ""
    If MyFund Is Nothing Then Addr = "NoFnd"
    If MyPaper Is Nothing Then Addr = Addr + "NoPpr"
    If Addr = "" Then Addr = "OK"
        
    Select Case Addr
        Case "OK"
            MyFund.AddTrade Me
        Case "NoFnd"
            WriteLogError "Trade não achou Fundo", Fundo
        Case "NoPpr"
            WriteLogError "Trade não achou Ativo", Ativo
        Case "NoFndNoPpr"
            WriteLogError "Trade não achou Fundo/Ativo", Fundo + "/" + Ativo
    End Select
End Sub

Property Get Extenso() As String
    Extenso = Fundo + " " + CV + " " + Format(Quant, "###,##0.000") + " " + Ativo + " @ " + Format(PU, "#####0.000")
End Property

Property Get Exempt() As Boolean
    Exempt = (Ativo = "Mellon_Cash" Or _
                Ativo = "Mellon_LI" Or _
                Right(Ativo, 3) = "FIM" Or _
                Right(Ativo, 8) = "DI FI CP" Or _
                Left(Ativo, 5) = "Fundo" Or _
                Right(Ativo, 2) = "DI" Or _
                Left(Ativo, 3) = "FUT")
End Property



Property Get TradeKey() As String
    TradeKey = Fundo + "_" + Ativo + "_" + CV + "_" + Format(Quant, "############0") + "_" + Format(PU, "##########0.000000000")
End Property

