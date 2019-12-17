Imports System.Text.RegularExpressions

Public Class editbox

    Private Sub cancelcode_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cancelcode.Click
        codetoedit.Clear()
        Me.Close()
    End Sub

    Private Sub savecode_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles savecode.Click
        main.setCodeVarables(codetoedit.Text, rowediting.Text)
        codetoedit.Clear()
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        codetoedit.Clear()
    End Sub

    Private Sub functionlist_DoubleClick(ByVal sender As Object, ByVal e As System.EventArgs) Handles functionlist.DoubleClick
        codetoedit.Text = codetoedit.Text & functionlist.SelectedItem & "();"
    End Sub

    Private Sub codetoedit_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles codetoedit.TextChanged
        Dim SaveSelectionStart As Integer = codetoedit.SelectionStart
        Dim SaveSelectionLength As Integer = codetoedit.SelectionLength
        Dim SaveSelectionColor As Color = codetoedit.SelectionColor

        Dim code As String = codetoedit.Text
        Dim code2 As String = codetoedit.Text
        Dim code3 As String = codetoedit.Text
        Dim code4 As String = codetoedit.Text
        Dim code5 As String = codetoedit.Text
        Dim code6 As String = codetoedit.Text
        Dim code7 As String = codetoedit.Text

        Dim match As MatchCollection
        Dim match2 As MatchCollection
        Dim match3 As MatchCollection
        Dim match4 As MatchCollection
        Dim match5 As MatchCollection
        Dim match6 As MatchCollection
        Dim match7 As MatchCollection


        Dim i As Integer

        match = Regex.Matches(code, "if")
        match2 = Regex.Matches(code2, "else")
        match3 = Regex.Matches(code3, "return ")
        match4 = Regex.Matches(code4, "true")
        match5 = Regex.Matches(code5, "false")
        match6 = Regex.Matches(code6, "switch")
        match7 = Regex.Matches(code7, "case")

        Dim results(match.Count - 1) As Integer
        Dim results2(match2.Count - 1) As Integer
        Dim results3(match3.Count - 1) As Integer
        Dim results4(match4.Count - 1) As Integer
        Dim results5(match5.Count - 1) As Integer
        Dim results6(match6.Count - 1) As Integer
        Dim results7(match7.Count - 1) As Integer

        For i = 0 To results.Length - 1
            results(i) = match(i).Index
            codetoedit.SelectionStart = match(i).Index
            codetoedit.SelectionLength = 2
            codetoedit.SelectionColor = Color.Blue
        Next

        For i = 0 To results2.Length - 1
            results2(i) = match2(i).Index
            codetoedit.SelectionStart = match2(i).Index
            codetoedit.SelectionLength = 4
            codetoedit.SelectionColor = Color.Blue
        Next

        For i = 0 To results3.Length - 1
            results3(i) = match3(i).Index
            codetoedit.SelectionStart = match3(i).Index
            codetoedit.SelectionLength = 6
            codetoedit.SelectionColor = Color.Blue
        Next

        For i = 0 To results4.Length - 1
            results4(i) = match4(i).Index
            codetoedit.SelectionStart = match4(i).Index
            codetoedit.SelectionLength = 4
            codetoedit.SelectionColor = Color.Blue
        Next

        For i = 0 To results5.Length - 1
            results5(i) = match5(i).Index
            codetoedit.SelectionStart = match5(i).Index
            codetoedit.SelectionLength = 5
            codetoedit.SelectionColor = Color.Blue
        Next

        For i = 0 To results6.Length - 1
            results6(i) = match6(i).Index
            codetoedit.SelectionStart = match6(i).Index
            codetoedit.SelectionLength = 5
            codetoedit.SelectionColor = Color.Blue
        Next

        For i = 0 To results7.Length - 1
            results7(i) = match7(i).Index
            codetoedit.SelectionStart = match7(i).Index
            codetoedit.SelectionLength = 4
            codetoedit.SelectionColor = Color.Blue
        Next

        codetoedit.SelectionStart = SaveSelectionStart
        codetoedit.SelectionLength = SaveSelectionLength
        codetoedit.SelectionColor = SaveSelectionColor

    End Sub
End Class