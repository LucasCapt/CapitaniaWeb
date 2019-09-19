VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CPosic"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public Fundo As Long
Public Papel As CPapel
Public Valor0 As Double         'Valor lido da última carteira
Public Quant0 As Double         'Quantidade lida da última carteira

'Obs: ValorD, QuantD, ValorDBD e QuantDBD são atualizados por Fundo.Inclui_Trade e não na leitura da carteira.

Public ValorD As Double         'Valor incremental (dos trades)
Public QuantD As Double         'Quantidade incremental (dos trades)

Public ValorDBD As Double       'Valor incremental na BaseDate
Public QuantDBD As Double       'Quant incremental na BaseDate

Public LiqConstraint As Double 'Dias a partir dos quais a liquidez está liberada (cotização do fundo que a contém)


Property Get Valor() As Double
    'If Quant0 > 0 _
    '    Then Valor = Valor0 / Quant0 * (Quant0 + QuantD) _
    '    Else Valor = Valor0 + ValorD
    
    'Obs: não é garantido que Quant0, QuantD terá dados válidos.
    '     (ex: Simulação de trade só envolve ValorD)
    
    Valor = Valor0 + ValorD
    
End Property

Property Get Quant() As Double
    Quant = Quant0 + QuantD
End Property


Property Get ValorD_1() As Double
    ValorD_1 = Valor0 + ValorD - ValorDBD
End Property


Property Get QuantD_1() As Double
    QuantD_1 = Quant0 + QuantD - QuantDBD
End Property


Public Function liquidityAteh(d As Date, method As String) As Double
    'LiquidityAteh do CPosic
    'Consulta a liquidez interna do papel, acrescenta a liquidez de ADTV (já com decay do cashflow) e o Constraint
    '
    Dim decay As Double
    If Valor > 0 Then
        Select Case method
            Case "CFLOW", "ANBIMA"
                liquidityAteh = Valor * Papel.InternalLiquidityAteh(d, method, 0)
            Case "CONSTR"
                If (d - BaseDate) >= LiqConstraint Then liquidityAteh = Valor * Papel.InternalLiquidityAteh(d, "ANBIMA", 0) Else liquidityAteh = 0
            Case "ADTV"
                decay = 0.2 * Papel.adtv / Valor
                liquidityAteh = min(Valor, Valor * Papel.InternalLiquidityAteh(d, method, decay) + 0.2 * Papel.adtv * (d - BaseDate) / 7 * 5)
        End Select
    Else
        liquidityAteh = 0
    End If
End Function
