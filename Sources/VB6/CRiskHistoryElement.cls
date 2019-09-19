VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CRiskHistoryElement"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public Data As Date
Public VaR As Double
Public Stress As Double
Public QVaR As Double

Property Get VaRorQ() As Double
    If VaR = 0 Then VaRorQ = QVaR Else VaRorQ = VaR
End Property

