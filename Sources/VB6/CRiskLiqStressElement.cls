VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CRiskLiqStressElement"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public Percentil As Double
Public Meses As Double
Public Lreq As Double

Property Get Dias() As Double
    Select Case Meses
        Case 1
            Dias = 21
        Case 2
            Dias = 42
        Case 3
            Dias = 63
        Case 6
            Dias = 126
        Case 12
            Dias = 252
        Case Else
            Dias = Meses * 21
    End Select
End Property

