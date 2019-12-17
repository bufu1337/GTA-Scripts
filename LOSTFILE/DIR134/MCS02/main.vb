Imports System.Text.RegularExpressions

Public Class main

    Dim row1code As String = "//Row 1 code"
    Dim row2code As String = "//Row 2 code"
    Dim row3code As String = "//Row 3 code"
    Dim row4code As String = "//Row 4 code"
    Dim row5code As String = "//Row 5 code"
    Dim row6code As String = "//Row 6 code"
    Dim row7code As String = "//Row 7 code"
    Dim row8code As String = "//Row 8 code"
    Dim row9code As String = "//Row 9 code"
    Dim row10code As String = "//Row 10 code"
    Dim row11code As String = "//Row 11 code"
    Dim row12code As String = "//Row 12 code"

    Public Function setCodeVarables(ByVal code As String, ByVal rownum As Integer)
        If rownum = 1 Then
            row1code = code
        ElseIf rownum = 2 Then
            row2code = code
        ElseIf rownum = 3 Then
            row3code = code
        ElseIf rownum = 4 Then
            row4code = code
        ElseIf rownum = 5 Then
            row5code = code
        ElseIf rownum = 6 Then
            row6code = code
        ElseIf rownum = 7 Then
            row7code = code
        ElseIf rownum = 8 Then
            row8code = code
        ElseIf rownum = 9 Then
            row9code = code
        ElseIf rownum = 10 Then
            row10code = code
        ElseIf rownum = 11 Then
            row11code = code
        ElseIf rownum = 12 Then
            row12code = code
        End If
        editbox.Visible = False
        Return True
    End Function

    Private Sub rownumber_SelectedItemChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles menurows.SelectedItemChanged
        If menurows.Text < 1 Or menurows.Text > 12 Then
            MsgBox("Number must be between 1 and 12", MsgBoxStyle.Exclamation, "Whoops!")
            menurows.Text = 1
        End If

        If menurows.Text = 1 Then
            r21.ReadOnly = False
            r22.ReadOnly = False

            r21.ReadOnly = True
            r22.ReadOnly = True

            r31.ReadOnly = True
            r32.ReadOnly = True

            r41.ReadOnly = True
            r42.ReadOnly = True

            r51.ReadOnly = True
            r52.ReadOnly = True

            r61.ReadOnly = True
            r62.ReadOnly = True

            r71.ReadOnly = True
            r72.ReadOnly = True

            r81.ReadOnly = True
            r82.ReadOnly = True

            r91.ReadOnly = True
            r92.ReadOnly = True

            r101.ReadOnly = True
            r102.ReadOnly = True

            r111.ReadOnly = True
            r112.ReadOnly = True

            r121.ReadOnly = True
            r122.ReadOnly = True
        ElseIf menurows.Text = 2 Then
            r21.ReadOnly = False
            r22.ReadOnly = False

            r21.ReadOnly = False
            r22.ReadOnly = False

            r31.ReadOnly = True
            r32.ReadOnly = True

            r41.ReadOnly = True
            r42.ReadOnly = True

            r51.ReadOnly = True
            r52.ReadOnly = True

            r61.ReadOnly = True
            r62.ReadOnly = True

            r71.ReadOnly = True
            r72.ReadOnly = True

            r81.ReadOnly = True
            r82.ReadOnly = True

            r91.ReadOnly = True
            r92.ReadOnly = True

            r101.ReadOnly = True
            r102.ReadOnly = True

            r111.ReadOnly = True
            r112.ReadOnly = True

            r121.ReadOnly = True
            r122.ReadOnly = True
        ElseIf menurows.Text = 3 Then
            r21.ReadOnly = False
            r22.ReadOnly = False

            r21.ReadOnly = False
            r22.ReadOnly = False

            r31.ReadOnly = False
            r32.ReadOnly = False

            r41.ReadOnly = True
            r42.ReadOnly = True

            r51.ReadOnly = True
            r52.ReadOnly = True

            r61.ReadOnly = True
            r62.ReadOnly = True

            r71.ReadOnly = True
            r72.ReadOnly = True

            r81.ReadOnly = True
            r82.ReadOnly = True

            r91.ReadOnly = True
            r92.ReadOnly = True

            r101.ReadOnly = True
            r102.ReadOnly = True

            r111.ReadOnly = True
            r112.ReadOnly = True

            r121.ReadOnly = True
            r122.ReadOnly = True
        ElseIf menurows.Text = 4 Then
            r21.ReadOnly = False
            r22.ReadOnly = False

            r21.ReadOnly = False
            r22.ReadOnly = False

            r31.ReadOnly = False
            r32.ReadOnly = False

            r41.ReadOnly = False
            r42.ReadOnly = False

            r51.ReadOnly = True
            r52.ReadOnly = True

            r61.ReadOnly = True
            r62.ReadOnly = True

            r71.ReadOnly = True
            r72.ReadOnly = True

            r81.ReadOnly = True
            r82.ReadOnly = True

            r91.ReadOnly = True
            r92.ReadOnly = True

            r101.ReadOnly = True
            r102.ReadOnly = True

            r111.ReadOnly = True
            r112.ReadOnly = True

            r121.ReadOnly = True
            r122.ReadOnly = True
        ElseIf menurows.Text = 5 Then
            r21.ReadOnly = False
            r22.ReadOnly = False

            r21.ReadOnly = False
            r22.ReadOnly = False

            r31.ReadOnly = False
            r32.ReadOnly = False

            r41.ReadOnly = False
            r42.ReadOnly = False

            r51.ReadOnly = False
            r52.ReadOnly = False

            r61.ReadOnly = True
            r62.ReadOnly = True

            r71.ReadOnly = True
            r72.ReadOnly = True

            r81.ReadOnly = True
            r82.ReadOnly = True

            r91.ReadOnly = True
            r92.ReadOnly = True

            r101.ReadOnly = True
            r102.ReadOnly = True

            r111.ReadOnly = True
            r112.ReadOnly = True

            r121.ReadOnly = True
            r122.ReadOnly = True
        ElseIf menurows.Text = 6 Then
            r21.ReadOnly = False
            r22.ReadOnly = False

            r21.ReadOnly = False
            r22.ReadOnly = False

            r31.ReadOnly = False
            r32.ReadOnly = False

            r41.ReadOnly = False
            r42.ReadOnly = False

            r51.ReadOnly = False
            r52.ReadOnly = False

            r61.ReadOnly = False
            r62.ReadOnly = False

            r71.ReadOnly = True
            r72.ReadOnly = True

            r81.ReadOnly = True
            r82.ReadOnly = True

            r91.ReadOnly = True
            r92.ReadOnly = True

            r101.ReadOnly = True
            r102.ReadOnly = True

            r111.ReadOnly = True
            r112.ReadOnly = True

            r121.ReadOnly = True
            r122.ReadOnly = True
        ElseIf menurows.Text = 7 Then
            r21.ReadOnly = False
            r22.ReadOnly = False

            r21.ReadOnly = False
            r22.ReadOnly = False

            r31.ReadOnly = False
            r32.ReadOnly = False

            r41.ReadOnly = False
            r42.ReadOnly = False

            r51.ReadOnly = False
            r52.ReadOnly = False

            r61.ReadOnly = False
            r62.ReadOnly = False

            r71.ReadOnly = False
            r72.ReadOnly = False

            r81.ReadOnly = True
            r82.ReadOnly = True

            r91.ReadOnly = True
            r92.ReadOnly = True

            r101.ReadOnly = True
            r102.ReadOnly = True

            r111.ReadOnly = True
            r112.ReadOnly = True

            r121.ReadOnly = True
            r122.ReadOnly = True
        ElseIf menurows.Text = 8 Then
            r21.ReadOnly = False
            r22.ReadOnly = False

            r21.ReadOnly = False
            r22.ReadOnly = False

            r31.ReadOnly = False
            r32.ReadOnly = False

            r41.ReadOnly = False
            r42.ReadOnly = False

            r51.ReadOnly = False
            r52.ReadOnly = False

            r61.ReadOnly = False
            r62.ReadOnly = False

            r71.ReadOnly = False
            r72.ReadOnly = False

            r81.ReadOnly = False
            r82.ReadOnly = False

            r91.ReadOnly = True
            r92.ReadOnly = True

            r101.ReadOnly = True
            r102.ReadOnly = True

            r111.ReadOnly = True
            r112.ReadOnly = True

            r121.ReadOnly = True
            r122.ReadOnly = True
        ElseIf menurows.Text = 9 Then
            r21.ReadOnly = False
            r22.ReadOnly = False

            r21.ReadOnly = False
            r22.ReadOnly = False

            r31.ReadOnly = False
            r32.ReadOnly = False

            r41.ReadOnly = False
            r42.ReadOnly = False

            r51.ReadOnly = False
            r52.ReadOnly = False

            r61.ReadOnly = False
            r62.ReadOnly = False

            r71.ReadOnly = False
            r72.ReadOnly = False

            r81.ReadOnly = False
            r82.ReadOnly = False

            r91.ReadOnly = False
            r92.ReadOnly = False

            r101.ReadOnly = True
            r102.ReadOnly = True

            r111.ReadOnly = True
            r112.ReadOnly = True

            r121.ReadOnly = True
            r122.ReadOnly = True
        ElseIf menurows.Text = 10 Then
            r21.ReadOnly = False
            r22.ReadOnly = False

            r21.ReadOnly = False
            r22.ReadOnly = False

            r31.ReadOnly = False
            r32.ReadOnly = False

            r41.ReadOnly = False
            r42.ReadOnly = False

            r51.ReadOnly = False
            r52.ReadOnly = False

            r61.ReadOnly = False
            r62.ReadOnly = False

            r71.ReadOnly = False
            r72.ReadOnly = False

            r81.ReadOnly = False
            r82.ReadOnly = False

            r91.ReadOnly = False
            r92.ReadOnly = False

            r101.ReadOnly = False
            r102.ReadOnly = False

            r111.ReadOnly = True
            r112.ReadOnly = True

            r121.ReadOnly = True
            r122.ReadOnly = True
        ElseIf menurows.Text = 11 Then
            r21.ReadOnly = False
            r22.ReadOnly = False

            r21.ReadOnly = False
            r22.ReadOnly = False

            r31.ReadOnly = False
            r32.ReadOnly = False

            r41.ReadOnly = False
            r42.ReadOnly = False

            r51.ReadOnly = False
            r52.ReadOnly = False

            r61.ReadOnly = False
            r62.ReadOnly = False

            r71.ReadOnly = False
            r72.ReadOnly = False

            r81.ReadOnly = False
            r82.ReadOnly = False

            r91.ReadOnly = False
            r92.ReadOnly = False

            r101.ReadOnly = False
            r102.ReadOnly = False

            r111.ReadOnly = False
            r112.ReadOnly = False

            r121.ReadOnly = True
            r122.ReadOnly = True
        ElseIf menurows.Text = 12 Then
            r21.ReadOnly = False
            r22.ReadOnly = False

            r21.ReadOnly = False
            r22.ReadOnly = False

            r31.ReadOnly = False
            r32.ReadOnly = False

            r41.ReadOnly = False
            r42.ReadOnly = False

            r51.ReadOnly = False
            r52.ReadOnly = False

            r61.ReadOnly = False
            r62.ReadOnly = False

            r71.ReadOnly = False
            r72.ReadOnly = False

            r81.ReadOnly = False
            r82.ReadOnly = False

            r91.ReadOnly = False
            r92.ReadOnly = False

            r101.ReadOnly = False
            r102.ReadOnly = False

            r111.ReadOnly = False
            r112.ReadOnly = False

            r121.ReadOnly = False
            r122.ReadOnly = False
        End If
    End Sub

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        menurows.SelectedIndex = 0
        r12.Visible = False
        r22.Visible = False
        r32.Visible = False
        r42.Visible = False
        r52.Visible = False
        r62.Visible = False
        r72.Visible = False
        r82.Visible = False
        r92.Visible = False
        r102.Visible = False
        r112.Visible = False
        r122.Visible = False
        Label2.Visible = False
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim menutop As String = ""
        menutop = "new Menu:" & menuvarable.Text & ";" & vbCrLf
        scripttop.Text = menutop

        Dim gamemodeinitfunction As String = ""
        gamemodeinitfunction = menuvarable.Text & " = CreateMenu(" & Chr(34) & menutitle.Text & Chr(34) & ", "
        If twocolumns.Checked Then
            gamemodeinitfunction = gamemodeinitfunction & "2, "
        Else
            gamemodeinitfunction = gamemodeinitfunction & "1, "
        End If
        gamemodeinitfunction = gamemodeinitfunction & "50.0, 180.0, 200.0, 200.0);" & vbCrLf & vbCrLf
        gamemodeinitfunction = gamemodeinitfunction & ""

        gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 0, " & Chr(34) & r11.Text & Chr(34) & ");" & vbCrLf
        If twocolumns.Checked Then
            gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 1, " & Chr(34) & r12.Text & Chr(34) & ");" & vbCrLf
        End If

        If menurows.Text > 1 Then
            gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 0, " & Chr(34) & r21.Text & Chr(34) & ");" & vbCrLf
            If twocolumns.Checked Then
                gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 1, " & Chr(34) & r22.Text & Chr(34) & ");" & vbCrLf
            End If
        End If

        If menurows.Text > 2 Then
            gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 0, " & Chr(34) & r31.Text & Chr(34) & ");" & vbCrLf
            If twocolumns.Checked Then
                gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 1, " & Chr(34) & r32.Text & Chr(34) & ");" & vbCrLf
            End If
        End If

        If menurows.Text > 3 Then
            gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 0, " & Chr(34) & r41.Text & Chr(34) & ");" & vbCrLf
            If twocolumns.Checked Then
                gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 1, " & Chr(34) & r42.Text & Chr(34) & ");" & vbCrLf
            End If
        End If

        If menurows.Text > 4 Then
            gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 0, " & Chr(34) & r51.Text & Chr(34) & ");" & vbCrLf
            If twocolumns.Checked Then
                gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 1, " & Chr(34) & r52.Text & Chr(34) & ");" & vbCrLf
            End If
        End If

        If menurows.Text > 5 Then
            gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 0, " & Chr(34) & r61.Text & Chr(34) & ");" & vbCrLf
            If twocolumns.Checked Then
                gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 1, " & Chr(34) & r62.Text & Chr(34) & ");" & vbCrLf
            End If
        End If

        If menurows.Text > 6 Then
            gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 0, " & Chr(34) & r71.Text & Chr(34) & ");" & vbCrLf
            If twocolumns.Checked Then
                gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 1, " & Chr(34) & r72.Text & Chr(34) & ");" & vbCrLf
            End If
        End If

        If menurows.Text > 7 Then
            gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 0, " & Chr(34) & r81.Text & Chr(34) & ");" & vbCrLf
            If twocolumns.Checked Then
                gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 1, " & Chr(34) & r82.Text & Chr(34) & ");" & vbCrLf
            End If
        End If

        If menurows.Text > 8 Then
            gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 0, " & Chr(34) & r91.Text & Chr(34) & ");" & vbCrLf
            If twocolumns.Checked Then
                gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 1, " & Chr(34) & r92.Text & Chr(34) & ");" & vbCrLf
            End If
        End If

        If menurows.Text > 9 Then
            gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 0, " & Chr(34) & r101.Text & Chr(34) & ");" & vbCrLf
            If twocolumns.Checked Then
                gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 1, " & Chr(34) & r102.Text & Chr(34) & ");" & vbCrLf
            End If
        End If

        If menurows.Text > 10 Then
            gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 0, " & Chr(34) & r111.Text & Chr(34) & ");" & vbCrLf
            If twocolumns.Checked Then
                gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 1, " & Chr(34) & r112.Text & Chr(34) & ");" & vbCrLf
            End If
        End If

        If menurows.Text > 11 Then
            gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 0, " & Chr(34) & r121.Text & Chr(34) & ");" & vbCrLf
            If twocolumns.Checked Then
                gamemodeinitfunction = gamemodeinitfunction & "AddMenuItem(" & menuvarable.Text & ", 1, " & Chr(34) & r122.Text & Chr(34) & ");" & vbCrLf
            End If
        End If
        gamemodeinit.Text = gamemodeinitfunction

        Dim menurowselectedfunction As String = ""
        menurowselectedfunction = menurowselectedfunction & "public OnPlayerSelectedMenuRow(playerid, row)" & vbCrLf
        menurowselectedfunction = menurowselectedfunction & "{" & vbCrLf
        menurowselectedfunction = menurowselectedfunction & "    new Menu:current;" & vbCrLf
        menurowselectedfunction = menurowselectedfunction & "    current = GetPlayerMenu(playerid);" & vbCrLf
        menurowselectedfunction = menurowselectedfunction & "    if(current == " & menuvarable.Text & ")" & vbCrLf
        menurowselectedfunction = menurowselectedfunction & "    {" & vbCrLf
        menurowselectedfunction = menurowselectedfunction & "        switch(row)" & vbCrLf
        menurowselectedfunction = menurowselectedfunction & "        {" & vbCrLf
        menurowselectedfunction = menurowselectedfunction & "            case 0:{" & vbCrLf
        menurowselectedfunction = menurowselectedfunction & "                " & row1code & vbCrLf
        menurowselectedfunction = menurowselectedfunction & "            }" & vbCrLf
        If menurows.Text > 1 Then
            menurowselectedfunction = menurowselectedfunction & "            case 1:{" & vbCrLf
            menurowselectedfunction = menurowselectedfunction & row2code & vbCrLf
            menurowselectedfunction = menurowselectedfunction & "            }" & vbCrLf
        End If

        If menurows.Text > 2 Then
            menurowselectedfunction = menurowselectedfunction & "            case 2:{" & vbCrLf
            menurowselectedfunction = menurowselectedfunction & row3code & vbCrLf
            menurowselectedfunction = menurowselectedfunction & "            }" & vbCrLf
        End If

        If menurows.Text > 3 Then
            menurowselectedfunction = menurowselectedfunction & "            case 3:{" & vbCrLf
            menurowselectedfunction = menurowselectedfunction & row4code & vbCrLf
            menurowselectedfunction = menurowselectedfunction & "            }" & vbCrLf
        End If

        If menurows.Text > 4 Then
            menurowselectedfunction = menurowselectedfunction & "            case 4:{" & vbCrLf
            menurowselectedfunction = menurowselectedfunction & row5code & vbCrLf
            menurowselectedfunction = menurowselectedfunction & "            }" & vbCrLf
        End If

        If menurows.Text > 5 Then
            menurowselectedfunction = menurowselectedfunction & "            case 5:{" & vbCrLf
            menurowselectedfunction = menurowselectedfunction & row6code & vbCrLf
            menurowselectedfunction = menurowselectedfunction & "            }" & vbCrLf
        End If

        If menurows.Text > 6 Then
            menurowselectedfunction = menurowselectedfunction & "            case 6:{" & vbCrLf
            menurowselectedfunction = menurowselectedfunction & row7code & vbCrLf
            menurowselectedfunction = menurowselectedfunction & "            }" & vbCrLf
        End If

        If menurows.Text > 7 Then
            menurowselectedfunction = menurowselectedfunction & "            case 7:{" & vbCrLf
            menurowselectedfunction = menurowselectedfunction & row8code & vbCrLf
            menurowselectedfunction = menurowselectedfunction & "            }" & vbCrLf
        End If

        If menurows.Text > 8 Then
            menurowselectedfunction = menurowselectedfunction & "            case 8:{" & vbCrLf
            menurowselectedfunction = menurowselectedfunction & row9code & vbCrLf
            menurowselectedfunction = menurowselectedfunction & "            }" & vbCrLf
        End If

        If menurows.Text > 9 Then
            menurowselectedfunction = menurowselectedfunction & "            case 9:{" & vbCrLf
            menurowselectedfunction = menurowselectedfunction & row10code & vbCrLf
            menurowselectedfunction = menurowselectedfunction & "            }" & vbCrLf
        End If

        If menurows.Text > 10 Then
            menurowselectedfunction = menurowselectedfunction & "            case 10:{" & vbCrLf
            menurowselectedfunction = menurowselectedfunction & row11code & vbCrLf
            menurowselectedfunction = menurowselectedfunction & "            }" & vbCrLf
        End If

        If menurows.Text > 11 Then
            menurowselectedfunction = menurowselectedfunction & "            case 11:{" & vbCrLf
            menurowselectedfunction = menurowselectedfunction & row12code & vbCrLf
            menurowselectedfunction = menurowselectedfunction & "            }" & vbCrLf
        End If

        menurowselectedfunction = menurowselectedfunction & "        }" & vbCrLf
        menurowselectedfunction = menurowselectedfunction & "    }" & vbCrLf
        menurowselectedfunction = menurowselectedfunction & "    return 1;" & vbCrLf
        menurowselectedfunction = menurowselectedfunction & "}" & vbCrLf
        menurowselectedfunction = menurowselectedfunction & "//You will have to sort the indentation out yourself"

        'Public OnPlayerSelectedMenuRow(playerid, row)
        '{
        '     new Menu:current;
        '     current = GetPlayerMenu(playerid);
        '     if(current == menu)
        '     {
        '          Switch(row)
        '          {
        '               case 0:{
        '               }
        '	            case 1:{
        '	            }
        '          }
        '     }
        '     return 1;
        '}
        menurowselected.Text = menurowselectedfunction

        Dim menuextrainfo As String = ""
        menuextrainfo = "//Use this function to show the menu to a player on a certain event" & vbCrLf & "ShowMenuForPlayer(" & menuvarable.Text & ", playerid);" & vbCrLf & vbCrLf & "//Use this function to hide the menu for a player on a certain event" & vbCrLf & "HideMenuForPlayer(" & menuvarable.Text & ", playerid);"
        extra.Text = menuextrainfo
    End Sub

    Private Sub ExitToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ExitToolStripMenuItem.Click
        Me.Close()
    End Sub

    Private Sub AboutToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles AboutToolStripMenuItem.Click
        about.Visible = True
    End Sub

    Private Sub rowbut1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rowbut1.Click
        editbox.codetoedit.Text = row1code
        editbox.rowediting.Text = 1
        editbox.Visible = True
    End Sub

    Private Sub rowbut2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rowbut2.Click
        editbox.codetoedit.Text = row2code
        editbox.rowediting.Text = 2
        editbox.Visible = True
    End Sub

    Private Sub rowbut3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rowbut3.Click
        editbox.codetoedit.Text = row3code
        editbox.rowediting.Text = 3
        editbox.Visible = True
    End Sub

    Private Sub rowbut4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rowbut4.Click
        editbox.codetoedit.Text = row4code
        editbox.rowediting.Text = 4
        editbox.Visible = True
    End Sub

    Private Sub rowbut5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rowbut5.Click
        editbox.codetoedit.Text = row5code
        editbox.rowediting.Text = 5
        editbox.Visible = True
    End Sub

    Private Sub rowbut6_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rowbut6.Click
        editbox.codetoedit.Text = row6code
        editbox.rowediting.Text = 6
        editbox.Visible = True
    End Sub

    Private Sub rowbut7_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rowbut7.Click
        editbox.codetoedit.Text = row7code
        editbox.rowediting.Text = 7
        editbox.Visible = True
    End Sub

    Private Sub rowbut8_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rowbut8.Click
        editbox.codetoedit.Text = row8code
        editbox.rowediting.Text = 8
        editbox.Visible = True
    End Sub

    Private Sub rowbut9_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rowbut9.Click
        editbox.codetoedit.Text = row9code
        editbox.rowediting.Text = 9
        editbox.Visible = True
    End Sub

    Private Sub Button10_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button10.Click
        editbox.codetoedit.Text = row10code
        editbox.rowediting.Text = 10
        editbox.Visible = True
    End Sub

    Private Sub rowbut11_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rowbut11.Click
        editbox.codetoedit.Text = row11code
        editbox.rowediting.Text = 11
        editbox.Visible = True
    End Sub

    Private Sub rowbut12_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rowbut12.Click
        editbox.codetoedit.Text = row12code
        editbox.rowediting.Text = 12
        editbox.Visible = True
    End Sub

    Private Sub twocolumns_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles twocolumns.CheckedChanged
        If twocolumns.Checked Then
            r12.Visible = True
            r22.Visible = True
            r32.Visible = True
            r42.Visible = True
            r52.Visible = True
            r62.Visible = True
            r72.Visible = True
            r82.Visible = True
            r92.Visible = True
            r102.Visible = True
            r112.Visible = True
            r122.Visible = True
            Label2.Visible = True
        Else
            r12.Visible = False
            r22.Visible = False
            r32.Visible = False
            r42.Visible = False
            r52.Visible = False
            r62.Visible = False
            r72.Visible = False
            r82.Visible = False
            r92.Visible = False
            r102.Visible = False
            r112.Visible = False
            r122.Visible = False
            Label2.Visible = False
        End If
    End Sub

    Private Sub Button5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button5.Click
        scripttop.SelectAll()
        scripttop.Copy()
    End Sub

    Private Sub Button4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button4.Click
        gamemodeinit.SelectAll()
        gamemodeinit.Copy()

    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        menurowselected.SelectAll()
        menurowselected.Copy()

    End Sub

    Private Sub extra_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles extra.TextChanged
        extra.SelectAll()
        extra.Copy()

    End Sub
End Class
