VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CBlotter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public Data As Date
Public Fundo As String
Public Contraparte As String
Public Valor As Double
Public CV As String
Public Quantidade As Double
Public Preco_Unitario As Double
Public Data_Vencto As Date
Public Cod_Identif As String
Public Simulado As Boolean
