VERSION 5.00
Begin VB.Form Pixels 
   Caption         =   "Pixels"
   ClientHeight    =   750
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   1920
   LinkTopic       =   "Form1"
   ScaleHeight     =   750
   ScaleWidth      =   1920
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer Checker 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   120
      Top             =   360
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "Running"
      BeginProperty Font 
         Name            =   "Arial Black"
         Size            =   14t25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00008000&
      Height          =   615
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1695
   End
End
Attribute VB_Name = "Pixels"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Checker_Timer()
    On Error Resume Next
    If Dir(App.Path & "\MkDir.txt") = "" Then Exit Sub
    Dim Blank As String
    Open App.Path & "\MkDir.txt" For Input As #1
        Blank = Input$(LOF(1), #1)
    Close #1
    Kill App.Path & "\MkDir.txt"
    MkDir App.Path & "\" & Blank
End Sub

Private Sub Form_Load()
    Checker.Enabled = True
End Sub
