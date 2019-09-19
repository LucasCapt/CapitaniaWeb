VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CPreTradeCompItem"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public Fundo As String
Public Book As String
Public regra As CRegra
Public Result As Integer
Public PLSubA As Double
Public PLSubB As Double
Public DeltaA As Double
Public DeltaB As Double
Public PapeisA As String
Public PapeisB As String
Public MyTrade As CTrade
Public Trade As String

Property Get Comment() As String
    Select Case Result
        Case 1
            Comment = "Passou"
        Case 2
            Comment = "Piorou " + regra.nome + ": {" + FNumkMM(DeltaB) + " x " + FNumkMM(DeltaA) + "} (" + FormatLimit(PLSubB, regra) + ") x L=" + regra.LimiteExtenso
        Case 3
            Comment = "Violou " + regra.nome + ": {" + FNumkMM(DeltaB) + " x " + FNumkMM(DeltaA) + "} (" + FormatLimit(PLSubB, regra) + ") x L=" + regra.LimiteExtenso
    End Select
End Property


