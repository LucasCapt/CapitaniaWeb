VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CAlocacao"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public DataObs As Date
Public Fundo As String
Public Ativo As String
Public VFundo As Double
Public TFundo As Double
Public QFundo As Double
Public VGeral As Double
Public TGeral As Double
Public QGeral As Double
Public CV As String



Property Get PUFundo() As Double
    Dim Comparavel As Double
    If Left(Ativo, 13) = "Compromissada" Or Left(Ativo, 7) = "Mellon_" Or Left(Ativo, 4) = "FUT " Then Comparavel = TFundo Else Comparavel = VFundo
    If QFundo = 0 Then PUFundo = 0 Else PUFundo = Comparavel / QFundo
End Property

Property Get PUGeral() As Double
    Dim Comparavel As Double
    If Left(Ativo, 13) = "Compromissada" Or Left(Ativo, 7) = "Mellon_" Or Left(Ativo, 4) = "FUT " Then Comparavel = TGeral Else Comparavel = VGeral
    If QGeral = 0 Then PUGeral = 0 Else PUGeral = Comparavel / QGeral
End Property


Property Get Compliant() As String
    If PUGeral = 0 Then
        Compliant = "OK"
    ElseIf Left(Ativo, 13) = "Compromissada" Or Left(Ativo, 7) = "Mellon_" Then
        Compliant = "(OK)"
    ElseIf Abs(PUFundo - PUGeral) / PUGeral < 0.001 Then
        Compliant = "OK"
    ElseIf Abs(PUFundo - PUGeral) / PUGeral < 0.005 Then
        Compliant = "WARN"
    Else
        Compliant = "BREACH"
    End If
End Property
