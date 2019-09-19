VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CRuleResult"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public Compliant As String          'OK, WARN, BREACH
Public Delta As Double              'Financeiro desenquadrado
Public DeltaW As Double             'Financeiro sob Warning
Public MaxOut As Double             'Maior limite extrapolado
Public Classes As New Collection    'Classes
                                    '   Classe: NomeValor
                                    '       Nome=Papel
                                    '       Valor=Delta
                                    '       NomeAlt=exposure x limite
                                    '       YesNo=

Property Get PapelDescr() As String
    Dim u As CNomeValor, s As String
    s = ""
    For Each u In Classes
        If (Compliant = "BREACH" And u.YesNo) Then
            s = s + u.NomeAlt + " {" + FNumkMM(u.Valor) + "} " + u.nome
        ElseIf (Compliant = "WARN" And Not u.YesNo) Then
            s = s + u.NomeAlt + " {} " + u.nome
        Else 'Warn de MovementRule
            s = s + u.NomeAlt + " {" + FNumkMM(u.Valor) + "} " + u.nome
        End If
    Next u
    PapelDescr = s
End Property


Property Get DeltaOut() As Double
    If Compliant = "BREACH" Then DeltaOut = Delta Else DeltaOut = DeltaW
End Property
