VERSION 5.00
Begin VB.Form FEditRegra 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Edita Regra"
   ClientHeight    =   8415
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   13200
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8415
   ScaleWidth      =   13200
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Escopo 
      Caption         =   "Escopo"
      Height          =   1695
      Left            =   120
      TabIndex        =   37
      Top             =   4680
      Width           =   6375
      Begin VB.CheckBox Check4 
         Caption         =   "A regra só se aplica no momento da movimentação (compra e venda) dos títulos"
         Height          =   495
         Left            =   120
         TabIndex        =   41
         Top             =   1080
         Width           =   6135
      End
      Begin VB.CheckBox Check3 
         Caption         =   "A regra se aplica à carteira aberta (explodida dos fundos investidos)"
         Height          =   495
         Left            =   120
         TabIndex        =   40
         Top             =   600
         Width           =   5895
      End
      Begin VB.ComboBox Combo10 
         Height          =   315
         ItemData        =   "FEditRegra.frx":0000
         Left            =   1440
         List            =   "FEditRegra.frx":000D
         TabIndex        =   38
         Text            =   "Combo1"
         Top             =   240
         Width           =   2775
      End
      Begin VB.Label Label9 
         Caption         =   "Nível"
         Height          =   255
         Left            =   120
         TabIndex        =   39
         Top             =   240
         Width           =   975
      End
   End
   Begin VB.Frame Frame3 
      BackColor       =   &H00FFFF80&
      Caption         =   "Agrupamento por classe"
      Height          =   1695
      Left            =   120
      TabIndex        =   31
      Top             =   6600
      Width           =   6375
      Begin VB.CheckBox Check1 
         BackColor       =   &H00FFFF80&
         Caption         =   "Aplique a regra a cada grupo de posições totalizado por"
         Height          =   255
         Left            =   120
         TabIndex        =   33
         Top             =   360
         Width           =   5895
      End
      Begin VB.ComboBox Combo2 
         Height          =   315
         Left            =   360
         TabIndex        =   32
         Text            =   "Combo2"
         Top             =   720
         Width           =   5655
      End
      Begin VB.Label Label5 
         BackColor       =   &H00FFFF80&
         Caption         =   "(se este box não for marcado, a regra será aplicada ao total dos papéis elegíveis)"
         Height          =   375
         Left            =   120
         TabIndex        =   42
         Top             =   1200
         Width           =   5775
      End
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H0080FF80&
      Caption         =   "Condições de elegibilidade"
      Height          =   7335
      Left            =   6720
      TabIndex        =   15
      Top             =   360
      Width           =   6375
      Begin VB.ComboBox Combo17 
         Height          =   315
         ItemData        =   "FEditRegra.frx":0021
         Left            =   360
         List            =   "FEditRegra.frx":002B
         TabIndex        =   58
         Text            =   "E"
         Top             =   2280
         Width           =   735
      End
      Begin VB.CheckBox Check7 
         BackColor       =   &H0080FF80&
         Caption         =   "E no seguinte critério (3a condição adicional, se houver):"
         Height          =   255
         Left            =   120
         TabIndex        =   56
         Top             =   5760
         Width           =   5775
      End
      Begin VB.CommandButton Command10 
         Caption         =   "Clear"
         Height          =   375
         Left            =   3000
         TabIndex        =   55
         Top             =   6840
         Width           =   735
      End
      Begin VB.CommandButton Command9 
         Caption         =   "<---"
         Height          =   375
         Left            =   3000
         TabIndex        =   54
         Top             =   6360
         Width           =   735
      End
      Begin VB.ComboBox Combo16 
         Height          =   315
         Left            =   3840
         TabIndex        =   53
         Text            =   "Combo2"
         Top             =   6360
         Width           =   2295
      End
      Begin VB.ListBox List4 
         Height          =   840
         Left            =   360
         TabIndex        =   52
         Top             =   6360
         Width           =   2535
      End
      Begin VB.ComboBox Combo15 
         Height          =   315
         ItemData        =   "FEditRegra.frx":0036
         Left            =   3000
         List            =   "FEditRegra.frx":0052
         Style           =   2  'Dropdown List
         TabIndex        =   51
         Top             =   6000
         Width           =   1335
      End
      Begin VB.ComboBox Combo14 
         Height          =   315
         Left            =   360
         TabIndex        =   50
         Text            =   "Combo2"
         Top             =   6000
         Width           =   2535
      End
      Begin VB.ComboBox Combo13 
         Height          =   315
         Left            =   360
         TabIndex        =   49
         Text            =   "Combo2"
         Top             =   4320
         Width           =   2535
      End
      Begin VB.ComboBox Combo12 
         Height          =   315
         ItemData        =   "FEditRegra.frx":0089
         Left            =   3000
         List            =   "FEditRegra.frx":00A5
         Style           =   2  'Dropdown List
         TabIndex        =   48
         Top             =   4320
         Width           =   1335
      End
      Begin VB.ListBox List3 
         Height          =   840
         Left            =   360
         TabIndex        =   47
         Top             =   4680
         Width           =   2535
      End
      Begin VB.ComboBox Combo11 
         Height          =   315
         Left            =   3840
         TabIndex        =   46
         Text            =   "Combo2"
         Top             =   4680
         Width           =   2295
      End
      Begin VB.CommandButton Command8 
         Caption         =   "<---"
         Height          =   375
         Left            =   3000
         TabIndex        =   45
         Top             =   4680
         Width           =   735
      End
      Begin VB.CommandButton Command7 
         Caption         =   "Clear"
         Height          =   375
         Left            =   3000
         TabIndex        =   44
         Top             =   5160
         Width           =   735
      End
      Begin VB.CheckBox Check6 
         BackColor       =   &H0080FF80&
         Caption         =   "E no seguinte critério (2a condição adicional, se houver):"
         Height          =   255
         Left            =   120
         TabIndex        =   43
         Top             =   4080
         Width           =   5775
      End
      Begin VB.CheckBox Check5 
         BackColor       =   &H0080FF80&
         Height          =   255
         Left            =   120
         TabIndex        =   29
         Top             =   2400
         Width           =   255
      End
      Begin VB.CommandButton Command5 
         Caption         =   "Clear"
         Height          =   375
         Left            =   3000
         TabIndex        =   28
         Top             =   3480
         Width           =   735
      End
      Begin VB.CommandButton Command6 
         Caption         =   "<---"
         Height          =   375
         Left            =   3000
         TabIndex        =   27
         Top             =   3000
         Width           =   735
      End
      Begin VB.ComboBox Combo6 
         Height          =   315
         Left            =   3840
         TabIndex        =   26
         Text            =   "Combo2"
         Top             =   3000
         Width           =   2295
      End
      Begin VB.ListBox List2 
         Height          =   840
         Left            =   360
         TabIndex        =   25
         Top             =   3000
         Width           =   2535
      End
      Begin VB.ComboBox Combo7 
         Height          =   315
         ItemData        =   "FEditRegra.frx":00DC
         Left            =   3000
         List            =   "FEditRegra.frx":00F8
         Style           =   2  'Dropdown List
         TabIndex        =   24
         Top             =   2640
         Width           =   1335
      End
      Begin VB.ComboBox Combo8 
         Height          =   315
         Left            =   360
         TabIndex        =   23
         Text            =   "Combo2"
         Top             =   2640
         Width           =   2535
      End
      Begin VB.CheckBox Check2 
         BackColor       =   &H0080FF80&
         Caption         =   "Aplique a regra apenas aos papéis que se enquadrem no seguinte critério:"
         Height          =   255
         Left            =   120
         TabIndex        =   22
         Top             =   720
         Width           =   5895
      End
      Begin VB.ComboBox Combo3 
         Height          =   315
         Left            =   360
         TabIndex        =   21
         Text            =   "Combo2"
         Top             =   960
         Width           =   2535
      End
      Begin VB.ComboBox Combo4 
         Height          =   315
         ItemData        =   "FEditRegra.frx":012F
         Left            =   3000
         List            =   "FEditRegra.frx":014B
         Style           =   2  'Dropdown List
         TabIndex        =   20
         Top             =   960
         Width           =   1335
      End
      Begin VB.ListBox List1 
         Height          =   840
         Left            =   360
         TabIndex        =   19
         Top             =   1320
         Width           =   2535
      End
      Begin VB.ComboBox Combo5 
         Height          =   315
         Left            =   3840
         TabIndex        =   18
         Text            =   "Combo2"
         Top             =   1320
         Width           =   2295
      End
      Begin VB.CommandButton Command3 
         Caption         =   "<---"
         Height          =   375
         Left            =   3000
         TabIndex        =   17
         Top             =   1320
         Width           =   735
      End
      Begin VB.CommandButton Command4 
         Caption         =   "Clear"
         Height          =   375
         Left            =   3000
         TabIndex        =   16
         Top             =   1800
         Width           =   735
      End
      Begin VB.Label Label6 
         BackColor       =   &H0080FF80&
         Caption         =   "no seguinte critério (1a condição adicional, se houver):"
         Height          =   255
         Left            =   1200
         TabIndex        =   57
         Top             =   2400
         Width           =   4215
      End
      Begin VB.Label Label10 
         BackColor       =   &H0080FF80&
         Caption         =   "(se nenhum box abaixo for marcado, a regra será aplicada a todos os papéis)"
         Height          =   255
         Left            =   120
         TabIndex        =   30
         Top             =   360
         Width           =   6015
      End
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H0080C0FF&
      Caption         =   "O limite é:"
      Height          =   2895
      Left            =   1200
      TabIndex        =   11
      Top             =   1560
      Width           =   5295
      Begin VB.OptionButton Option4 
         BackColor       =   &H0080C0FF&
         Caption         =   "percentual da quantidade da emissão (*)"
         Height          =   255
         Left            =   120
         TabIndex        =   36
         Top             =   1320
         Width           =   3855
      End
      Begin VB.OptionButton Option3 
         BackColor       =   &H0080C0FF&
         Caption         =   "valor absoluto (R$)"
         Height          =   375
         Left            =   120
         TabIndex        =   35
         Top             =   600
         Width           =   3855
      End
      Begin VB.ComboBox Combo9 
         Height          =   315
         Left            =   360
         TabIndex        =   34
         Text            =   "Combo2"
         Top             =   2400
         Width           =   4695
      End
      Begin VB.OptionButton Option2 
         BackColor       =   &H0080C0FF&
         Caption         =   "percentual do valor da emissão (*)"
         Height          =   255
         Left            =   120
         TabIndex        =   14
         Top             =   960
         Width           =   3855
      End
      Begin VB.OptionButton Option1 
         BackColor       =   &H0080C0FF&
         Caption         =   "percentual do patrimônio líquido do fundo / carteira"
         Height          =   375
         Left            =   120
         TabIndex        =   13
         Top             =   240
         Value           =   -1  'True
         Width           =   4095
      End
      Begin VB.Label Label8 
         BackColor       =   &H0080C0FF&
         Caption         =   $"FEditRegra.frx":0182
         Height          =   615
         Left            =   360
         TabIndex        =   12
         Top             =   1680
         Width           =   4815
      End
   End
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   4800
      TabIndex        =   9
      Text            =   "Text1"
      Top             =   1080
      Width           =   1695
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Cancela"
      Height          =   375
      Left            =   10320
      TabIndex        =   8
      Top             =   7920
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Height          =   375
      Left            =   11760
      TabIndex        =   7
      Top             =   7920
      Width           =   1215
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   3000
      TabIndex        =   6
      Text            =   "Text1"
      Top             =   1080
      Width           =   1695
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "FEditRegra.frx":0217
      Left            =   1200
      List            =   "FEditRegra.frx":0221
      TabIndex        =   4
      Text            =   "Combo1"
      Top             =   1080
      Width           =   1695
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   1200
      TabIndex        =   2
      Text            =   "Text1"
      Top             =   360
      Width           =   5295
   End
   Begin VB.Label Label7 
      Alignment       =   2  'Center
      BackColor       =   &H0080C0FF&
      Caption         =   "Warning"
      Height          =   255
      Left            =   4800
      TabIndex        =   10
      Top             =   840
      Width           =   1695
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      BackColor       =   &H0080C0FF&
      Caption         =   "Limite:"
      Height          =   255
      Left            =   3000
      TabIndex        =   5
      Top             =   840
      Width           =   1695
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H0080C0FF&
      Caption         =   "Tipo de limite:"
      Height          =   255
      Left            =   1200
      TabIndex        =   3
      Top             =   840
      Width           =   1695
   End
   Begin VB.Label Label2 
      Caption         =   "Nome:"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   360
      Width           =   975
   End
   Begin VB.Label Label1 
      Caption         =   "Identificador:"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   12975
   End
End
Attribute VB_Name = "FEditRegra"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Obj As CRegra


Public Sub showfor(r As CRegra)
    Dim a As String, cc As Control
    
    Props.FillComboWithProps Me.Combo2, True
    Props.FillComboWithProps Me.Combo3, True
    Props.FillComboWithProps Me.Combo8, True
    Props.FillComboWithProps Me.Combo9, True
    Props.FillComboWithProps Me.Combo13, True
    Props.FillComboWithProps Me.Combo14, True

    Set Obj = r
    Me.Text1 = r.nome
    Me.Text2 = Str(r.Limite)
    Me.Text3 = Str(r.Warn)
    Me.Combo1 = r.MaxMin
    Me.Combo10 = r.Escopo
    If r.Conector Then Me.Combo17 = "OU" Else Me.Combo17 = "E"
    
    If Not r.Por_Prop Is Nothing Then Combo2 = r.Por_Prop.nome Else Combo2 = ""
    If Not r.Para_prop Is Nothing Then
        Combo3 = r.Para_prop.nome
        Call Props.FillComboWithPropValues(r.Para_prop.nome, Me.Combo5)
    Else
        Combo3 = ""
        Me.Combo5.Clear
    End If
    
    If Not r.AND_prop Is Nothing Then
        Combo8 = r.AND_prop.nome
        Call Props.FillComboWithPropValues(r.AND_prop.nome, Me.Combo6)
    Else
        Combo8 = ""
        Me.Combo6.Clear
    End If
    
    If Not r.AND2_prop Is Nothing Then
        Combo13 = r.AND2_prop.nome
        Call Props.FillComboWithPropValues(r.AND2_prop.nome, Me.Combo11)
    Else
        Combo13 = ""
        Me.Combo11.Clear
    End If
    
    If Not r.AND3_prop Is Nothing Then
        Combo14 = r.AND3_prop.nome
        Call Props.FillComboWithPropValues(r.AND3_prop.nome, Me.Combo16)
    Else
        Combo14 = ""
        Me.Combo16.Clear
    End If
    
    If r.Issue_Prop Is Nothing Then Combo9 = "" Else Combo9 = r.Issue_Prop.nome
    
    Me.Check1 = Bol2Check(r.Por)
    Me.Check2 = Bol2Check(r.PARA)
    Me.Check3 = Bol2Check(r.Aberta)
    Me.Check4 = Bol2Check(r.MovementRule)
    Me.Check5 = Bol2Check(r.ANDRule)
    Me.Check6 = Bol2Check(r.AND2Rule)
    Me.Check7 = Bol2Check(r.AND3Rule)
    If r.Para_comp = "" Then Me.Combo4 = "=" Else Me.Combo4 = r.Para_comp
    If r.AND_comp = "" Then Me.Combo7 = "=" Else Me.Combo7 = r.AND_comp
    If r.AND2_comp = "" Then Me.Combo12 = "=" Else Me.Combo12 = r.AND2_comp
    If r.AND3_comp = "" Then Me.Combo15 = "=" Else Me.Combo15 = r.AND3_comp
    
    '--Coloca referencia do limite
        Me.Option1.value = False
        Me.Option2.value = False
        Me.Option3.value = False
        Me.Option4.value = False
        Select Case r.Lim_Ref
            Case "PL"
                Me.Option1.value = True
            Case "VALUE"
                Me.Option3.value = True
            Case "ISSUEV"
                Me.Option2.value = True
            Case "ISSUEQ"
                Me.Option4.value = True
        End Select
    
    '--parse para_valor PARA
        Me.List1.Clear
        a = r.Para_valor
        If a <> "" Then
            While InStr(a, ",") > 0
                Me.List1.AddItem Left(a, InStr(a, ",") - 1)
                a = Right(a, Len(a) - InStr(a, ","))
            Wend
            Me.List1.AddItem a
        End If
        
    '--parse para_valor AND
        Me.List2.Clear
        a = r.AND_valor
        If a <> "" Then
            While InStr(a, ",") > 0
                Me.List2.AddItem Left(a, InStr(a, ",") - 1)
                a = Right(a, Len(a) - InStr(a, ","))
            Wend
            Me.List2.AddItem a
        End If
    
    '--parse para_valor AND2
        Me.List3.Clear
        a = r.AND2_valor
        If a <> "" Then
            While InStr(a, ",") > 0
                Me.List3.AddItem Left(a, InStr(a, ",") - 1)
                a = Right(a, Len(a) - InStr(a, ","))
            Wend
            Me.List3.AddItem a
        End If
        
    '--parse para_valor AND3
        Me.List4.Clear
        a = r.AND3_valor
        If a <> "" Then
            While InStr(a, ",") > 0
                Me.List4.AddItem Left(a, InStr(a, ",") - 1)
                a = Right(a, Len(a) - InStr(a, ","))
            Wend
            Me.List4.AddItem a
        End If
    
    Me.Show vbModal
       
End Sub


Private Sub combo3_lostfocus()
    Call Props.FillComboWithPropValues(Me.Combo3, Me.Combo5)
End Sub


Private Sub combo8_lostfocus()
    Props.FillComboWithPropValues Me.Combo8.Text, Me.Combo6
End Sub

Private Sub combo13_lostfocus()
    Props.FillComboWithPropValues Me.Combo13.Text, Me.Combo11
End Sub

Private Sub combo14_lostfocus()
    Props.FillComboWithPropValues Me.Combo14.Text, Me.Combo16
End Sub


Private Sub Command1_Click()
    Dim y As CRegra, vai As Boolean
    
    vai = False
    
    If Text1 <> Obj.nome And Not Regras.searchNome(Text1) Is Nothing Then
        MsgBox ("Tentativa de alterar o nome para um nome já existente. Tente outro.")
    ElseIf Not (Check2Bol(Me.Check2)) And Not (Check2Bol(Me.Check5)) And Not (Check2Bol(Me.Check1)) Then
        MsgBox ("Nenhuma opção de elegibilidade ou de agrupamento foi marcada. Tente novamente.")
    ElseIf Check2Bol(Me.Check5) And Not Check2Bol(Me.Check2) Then
        MsgBox ("Não pode ter a condição adicional sem ter a condição de elegibilidade inicial. Tente novamente.")
    ElseIf Check2Bol(Me.Check6) And Not Check2Bol(Me.Check5) Then
        MsgBox ("Não pode ter a condição adicional 2 sem ter a condição de elegibilidade adicional 1. Tente novamente.")
    ElseIf Check2Bol(Me.Check7) And Not Check2Bol(Me.Check6) Then
        MsgBox ("Não pode ter a condição adicional 3 sem ter a condição de elegibilidade adicional 2. Tente novamente.")
    ElseIf Check2Bol(Me.Check1) And Me.Combo2 = "" Then
        MsgBox ("Agrupamento selecionado, mas propriedade de agrupamento não. Tente novamente.")
    ElseIf (Me.Option4.value Or Me.Option2.value) And Not Check2Bol(Me.Check1) Then
        MsgBox ("Não pode escolher patrimônio de referência da Emissão sem Agrupar (quadro azul). Tente novamente.")
    Else
        vai = True
    End If
    
    If vai Then
      Obj.nome = Me.Text1
      Obj.Limite = Val(Me.Text2)
      Obj.Warn = Val(Me.Text3)
      Obj.MaxMin = Me.Combo1
      Obj.Aberta = Check2Bol(Me.Check3)
      Obj.MovementRule = Check2Bol(Me.Check4)
      Obj.Escopo = Me.Combo10
      Obj.Conector = (Me.Combo17 = "OU")
      
      If Me.Option2.value And Me.Combo9 <> "" Then
        Obj.Lim_Ref = "ISSUEV"
      ElseIf Me.Option4.value And Me.Combo9 <> "" Then
        Obj.Lim_Ref = "ISSUEQ"
      ElseIf Me.Option3.value Then
        Obj.Lim_Ref = "VALUE"
      Else
        Obj.Lim_Ref = "PL"
      End If
      
      Set Obj.Issue_Prop = Props.searchName(Me.Combo9)
            
      If Me.Combo2 = "" Then Obj.Por = False Else Obj.Por = Check2Bol(Me.Check1)
      Set Obj.Por_Prop = Props.searchName(Me.Combo2)
                 
      If Me.Combo3 = "" Then Obj.PARA = False Else Obj.PARA = Check2Bol(Me.Check2)
      Set Obj.Para_prop = Props.searchName(Me.Combo3)
      Obj.Para_comp = Me.Combo4
      Obj.Para_valor = ""
      For i = 0 To Me.List1.ListCount - 1
          Obj.Para_valor = Obj.Para_valor + Trim(Me.List1.List(i)) + ", "
      Next i
      If Obj.Para_valor <> "" Then Obj.Para_valor = Left(Obj.Para_valor, Len(Obj.Para_valor) - 2)
      
      
      If Me.Combo8 = "" Then Obj.ANDRule = False Else Obj.ANDRule = Check2Bol(Me.Check5)
      Set Obj.AND_prop = Props.searchName(Me.Combo8)
      Obj.AND_comp = Me.Combo7
      Obj.AND_valor = ""
      For i = 0 To Me.List2.ListCount - 1
          Obj.AND_valor = Obj.AND_valor + Me.List2.List(i) + ", "
      Next i
      If Obj.AND_valor <> "" Then Obj.AND_valor = Left(Obj.AND_valor, Len(Obj.AND_valor) - 2)
            
      
      If Me.Combo13 = "" Then Obj.AND2Rule = False Else Obj.AND2Rule = Check2Bol(Me.Check6)
      Set Obj.AND2_prop = Props.searchName(Me.Combo13)
      Obj.AND2_comp = Me.Combo12
      Obj.AND2_valor = ""
      For i = 0 To Me.List3.ListCount - 1
          Obj.AND2_valor = Obj.AND2_valor + Me.List3.List(i) + ", "
      Next i
      If Obj.AND2_valor <> "" Then Obj.AND2_valor = Left(Obj.AND2_valor, Len(Obj.AND2_valor) - 2)
      
      
      If Me.Combo14 = "" Then Obj.AND3Rule = False Else Obj.AND3Rule = Check2Bol(Me.Check7)
      Set Obj.AND3_prop = Props.searchName(Me.Combo14)
      Obj.AND3_comp = Me.Combo15
      Obj.AND3_valor = ""
      For i = 0 To Me.List4.ListCount - 1
          Obj.AND3_valor = Obj.AND3_valor + Me.List4.List(i) + ", "
      Next i
      If Obj.AND3_valor <> "" Then Obj.AND3_valor = Left(Obj.AND3_valor, Len(Obj.AND3_valor) - 2)
               
      Obj.WriteDB
    
      Me.Hide
      
      FMain.Refaz
      
      WriteLog "EDITOU REGRA " + Obj.nome
    End If
End Sub

Private Sub Command2_Click()
    Me.Hide
End Sub

Private Sub Command3_Click()
    List1.AddItem Me.Combo5
End Sub

Private Sub Command4_Click()
    Dim i As Integer
    i = List1.ListIndex
    If i > -1 Then
        List1.RemoveItem i
    End If
End Sub


Private Sub Command5_Click()
    Dim i As Integer
    i = List2.ListIndex
    If i > -1 Then
        List2.RemoveItem i
    End If
End Sub

Private Sub Command6_Click()
    List2.AddItem Me.Combo6
End Sub


Private Sub Command7_Click()
    Dim i As Integer
    i = List3.ListIndex
    If i > -1 Then
        List3.RemoveItem i
    End If
End Sub

Private Sub Command8_Click()
    List3.AddItem Me.Combo11
End Sub


Private Sub Command10_Click()
    Dim i As Integer
    i = List4.ListIndex
    If i > -1 Then
        List4.RemoveItem i
    End If
End Sub

Private Sub Command9_Click()
    List4.AddItem Me.Combo16
End Sub




Public Sub newrefresh()
End Sub
