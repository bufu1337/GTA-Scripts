<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class editbox
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.codetoedit = New System.Windows.Forms.RichTextBox
        Me.cancelcode = New System.Windows.Forms.Button
        Me.savecode = New System.Windows.Forms.Button
        Me.row = New System.Windows.Forms.Label
        Me.rowediting = New System.Windows.Forms.Label
        Me.Label1 = New System.Windows.Forms.Label
        Me.Button1 = New System.Windows.Forms.Button
        Me.functionlist = New System.Windows.Forms.ListBox
        Me.Label2 = New System.Windows.Forms.Label
        Me.SuspendLayout()
        '
        'codetoedit
        '
        Me.codetoedit.AcceptsTab = True
        Me.codetoedit.Font = New System.Drawing.Font("Courier New", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.codetoedit.Location = New System.Drawing.Point(12, 12)
        Me.codetoedit.Name = "codetoedit"
        Me.codetoedit.Size = New System.Drawing.Size(603, 309)
        Me.codetoedit.TabIndex = 0
        Me.codetoedit.Text = ""
        '
        'cancelcode
        '
        Me.cancelcode.Location = New System.Drawing.Point(540, 327)
        Me.cancelcode.Name = "cancelcode"
        Me.cancelcode.Size = New System.Drawing.Size(75, 23)
        Me.cancelcode.TabIndex = 1
        Me.cancelcode.Text = "Cancel"
        Me.cancelcode.UseVisualStyleBackColor = True
        '
        'savecode
        '
        Me.savecode.Location = New System.Drawing.Point(378, 327)
        Me.savecode.Name = "savecode"
        Me.savecode.Size = New System.Drawing.Size(75, 23)
        Me.savecode.TabIndex = 2
        Me.savecode.Text = "Save"
        Me.savecode.UseVisualStyleBackColor = True
        '
        'row
        '
        Me.row.AutoSize = True
        Me.row.Location = New System.Drawing.Point(12, 332)
        Me.row.Name = "row"
        Me.row.Size = New System.Drawing.Size(0, 13)
        Me.row.TabIndex = 3
        Me.row.Visible = False
        '
        'rowediting
        '
        Me.rowediting.AutoSize = True
        Me.rowediting.Location = New System.Drawing.Point(91, 332)
        Me.rowediting.Name = "rowediting"
        Me.rowediting.Size = New System.Drawing.Size(13, 13)
        Me.rowediting.TabIndex = 4
        Me.rowediting.Text = "0"
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(18, 332)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(67, 13)
        Me.Label1.TabIndex = 5
        Me.Label1.Text = "Editing Row:"
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(459, 327)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(75, 23)
        Me.Button1.TabIndex = 6
        Me.Button1.Text = "Clear"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'functionlist
        '
        Me.functionlist.FormattingEnabled = True
        Me.functionlist.Items.AddRange(New Object() {"SpawnPlayer", "GetPlayerPos", "SetPlayerPos", "GetPlayerFacingAngle", "SetPlayerFacingAngle", "GetPlayerInterior", "SetPlayerInterior", "GetPlayerHealth", "SetPlayerHealth", "GetPlayerArmour", "SetPlayerArmour", "GetPlayerSkin", "SetPlayerSkin", "GivePlayerWeapon", "GetPlayerName", "TogglePlayerClock", "SetPlayerName", "SetPlayerWantedLevel", "GetPlayerWantedLevel", "TogglePlayerControllable", "ApplyAnimation", "ClearAnimations", "SetWeather", "SetGravity"})
        Me.functionlist.Location = New System.Drawing.Point(621, 31)
        Me.functionlist.Name = "functionlist"
        Me.functionlist.Size = New System.Drawing.Size(191, 290)
        Me.functionlist.TabIndex = 7
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(621, 15)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(86, 13)
        Me.Label2.TabIndex = 8
        Me.Label2.Text = "Useful Functions"
        '
        'editbox
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(824, 355)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.functionlist)
        Me.Controls.Add(Me.Button1)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.rowediting)
        Me.Controls.Add(Me.row)
        Me.Controls.Add(Me.savecode)
        Me.Controls.Add(Me.cancelcode)
        Me.Controls.Add(Me.codetoedit)
        Me.Name = "editbox"
        Me.ShowIcon = False
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Code Editor - v0.2"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents codetoedit As System.Windows.Forms.RichTextBox
    Friend WithEvents cancelcode As System.Windows.Forms.Button
    Friend WithEvents savecode As System.Windows.Forms.Button
    Friend WithEvents row As System.Windows.Forms.Label
    Friend WithEvents rowediting As System.Windows.Forms.Label
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents functionlist As System.Windows.Forms.ListBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
End Class
