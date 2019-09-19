VERSION 5.00
Object = "{0D452EE1-E08F-101A-852E-02608C4D0BB4}#2.0#0"; "FM20.DLL"
Begin VB.Form FRegraFast 
   BackColor       =   &H00FFC0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Rule"
   ClientHeight    =   7335
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5040
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7335
   ScaleWidth      =   5040
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.Label Label9 
      BackColor       =   &H00C0FFC0&
      Caption         =   "PL sob Regra"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   0
      TabIndex        =   10
      Top             =   4320
      Width           =   4935
   End
   Begin VB.Label Label8 
      BackColor       =   &H00FFC0C0&
      Caption         =   "Escopo:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   0
      TabIndex        =   9
      Top             =   240
      Width           =   4935
   End
   Begin VB.Label Label7 
      BackColor       =   &H000000FF&
      Caption         =   "Situação"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   0
      TabIndex        =   8
      Top             =   4560
      Width           =   4935
   End
   Begin VB.Label Label6 
      BackColor       =   &H00C0FFC0&
      Caption         =   "Delta"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   0
      TabIndex        =   7
      Top             =   4080
      Width           =   4935
   End
   Begin VB.Label Label5 
      BackColor       =   &H00C0FFC0&
      Caption         =   "FUNDO:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   0
      TabIndex        =   6
      Top             =   3840
      Width           =   4935
   End
   Begin VB.Label Label4 
      BackColor       =   &H0080FF80&
      Caption         =   "Papéis afetados"
      Height          =   255
      Left            =   0
      TabIndex        =   5
      Top             =   4800
      Width           =   4935
   End
   Begin MSForms.ListBox ListBox2 
      Height          =   2295
      Left            =   0
      TabIndex        =   4
      Top             =   5040
      Width           =   4935
      BackColor       =   12648384
      ScrollBars      =   3
      DisplayStyle    =   2
      Size            =   "8705;4048"
      MatchEntry      =   0
      FontHeight      =   195
      FontCharSet     =   0
      FontPitchAndFamily=   2
   End
   Begin MSForms.ListBox ListBox1 
      Height          =   2055
      Left            =   0
      TabIndex        =   3
      Top             =   1680
      Width           =   4935
      BackColor       =   16761024
      ScrollBars      =   3
      DisplayStyle    =   2
      Size            =   "8705;3625"
      MatchEntry      =   0
      FontName        =   "Courier New"
      FontHeight      =   180
      FontCharSet     =   0
      FontPitchAndFamily=   2
   End
   Begin VB.Label Label2 
      BackColor       =   &H00FF8080&
      Caption         =   "Books e Fundos que têm esta regra"
      Height          =   255
      Left            =   0
      TabIndex        =   2
      Top             =   1440
      Width           =   4935
   End
   Begin VB.Label Label3 
      BackColor       =   &H00FFC0C0&
      Caption         =   "CONDIÇÃO:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   0
      TabIndex        =   1
      Top             =   480
      Width           =   4935
   End
   Begin VB.Label Label1 
      BackColor       =   &H00FFC0C0&
      Caption         =   "REGRA:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4935
   End
End
Attribute VB_Name = "FRegraFast"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub showfor(x As CRegra, Optional y As CFundo)
    Dim u As CNomeValor, MostraF As Boolean, RR As CRuleResult, us As String, Papeis As String
    If y Is Nothing Then
        'curto
        Me.Height = 4215
        MostraF = False
    Else
        'longo
        Me.Height = 7410
        MostraF = True
    End If
    Label5.Visible = MostraF
    Label6.Visible = MostraF
    Label9.Visible = MostraF
    Label7.Visible = MostraF
    Label4.Visible = MostraF
    ListBox2.Visible = MostraF
    
    Label1 = "NOME: " + x.nome
    Label8 = "Escopo: " + x.Escopo
    Label3 = x.Extensa
    ListBox1.Clear
    For Each u In x.FundosAplic
        ListBox1.AddItem FitString(u.nome, 24, "L") + u.NomeAlt
    Next u
    
    If MostraF Then
        Set RR = y.ComputeRule(x)
        Label5 = "Fundo: " + y.nome
        Label6 = "Delta: " + FNumkMM(RR.Delta)
        Label9 = "PL Sob Regra: " + FormatLimit(RR.MaxOut, x)
        us = y.IAmCompliantWithRule(x, x.Escopo)
        Select Case RR.Compliant
            Case "OK"
                Label7.BackColor = &HC0FFC0
                Label7 = "Compliance: OK"
            Case "WARN"
                Label7.BackColor = &HFFFF&
                Label7 = "Compliance: WARN (" + Format(x.Warn, "##0.00") + "%)"
            Case "BREACH"
                Label7.BackColor = &HFF&
                Label7 = "Compliance: BREACH"
        End Select
        a = ""
        ListBox2.Clear
        Papeis = RR.PapelDescr
        For i = 1 To Len(Papeis)
            b = Mid(Papeis, i, 1)
            a = a + b
            If b = "]" Then
                ListBox2.AddItem a
                a = ""
            End If
        Next i
    End If
    
    Me.Show vbModeless
End Sub

Public Sub newrefresh()
End Sub
