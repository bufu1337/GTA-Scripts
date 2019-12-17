Public Class MainForm
    Dim HOLOGEN As New Process
    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        Button2.Enabled = False
        status.Text = "making hologram..."
        If My.Computer.FileSystem.FileExists(My.Application.Info.DirectoryPath + "\bin\holo.png") Then My.Computer.FileSystem.DeleteFile(My.Application.Info.DirectoryPath + "\bin\holo.png")
        My.Computer.FileSystem.CopyFile(SelectEdit.Text, My.Application.Info.DirectoryPath + "\bin\holo.png")
        HOLOGEN = Process.Start(My.Application.Info.DirectoryPath + "\bin\hologen.exe", "holo.png " + NumericUpDown1.Value.ToString + " " + NumericUpDown2.Value.ToString + " " + NumericUpDown3.Value.ToString)
        HOLOGEN.WaitForExit(86000)
        status.Text = "saving..."
        SaveFileDialog1.ShowDialog()
        My.Computer.FileSystem.MoveFile(My.Application.Info.DirectoryPath + "\bin\holo.pwn", SaveFileDialog1.FileName)
        My.Computer.FileSystem.DeleteFile(My.Application.Info.DirectoryPath + "\bin\holo.png")
        status.Text = "done!"
        Button2.Enabled = True
    End Sub

    Private Sub SelectButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SelectButton.Click
        OpenFileDialog1.ShowDialog()
        SelectEdit.Text = OpenFileDialog1.FileName
        If My.Computer.FileSystem.FileExists(OpenFileDialog1.FileName) Then
            Button2.Enabled = True
        Else
            Button2.Enabled = False
        End If
    End Sub
End Class
