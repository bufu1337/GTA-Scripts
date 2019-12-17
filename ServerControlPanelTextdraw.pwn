#include <a_samp>

#define IsNull(%1) \
    ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))

#define DIALOG_SERVERNAME             8881
#define DIALOG_SERVERMODE             8882
#define DIALOG_SERVERPASSWORD         8883
#define DIALOG_SERVERMAP              8884
#define DIALOG_SERVERWEATHER          8885
#define DIALOG_SERVERTIME             8886

new PlayerText:CPanel[21][MAX_PLAYERS];
new ServerName[300];
new ServerMode[300];
new ServerPassword[40];
new ServerMap[300];
new ServerWeather;
new ServerTime[3];

stock LoadPlayerTextdraws(playerid)
{
	CPanel[0][playerid] = CreatePlayerTextDraw(playerid, 120.000000, 105.000000, "                                                         ");
	PlayerTextDrawBackgroundColor(playerid, CPanel[0][playerid], 255);
	PlayerTextDrawFont(playerid, CPanel[0][playerid], 1);
	PlayerTextDrawLetterSize(playerid, CPanel[0][playerid], 0.500000, 27.300001);
	PlayerTextDrawColor(playerid, CPanel[0][playerid], -1);
	PlayerTextDrawSetOutline(playerid, CPanel[0][playerid], 0);
	PlayerTextDrawSetProportional(playerid, CPanel[0][playerid], 1);
	PlayerTextDrawSetShadow(playerid, CPanel[0][playerid], 1);
	PlayerTextDrawUseBox(playerid, CPanel[0][playerid], 1);
	PlayerTextDrawBoxColor(playerid, CPanel[0][playerid], 112);
	PlayerTextDrawTextSize(playerid, CPanel[0][playerid], 511.000000, 2.000000);
	PlayerTextDrawSetSelectable(playerid, CPanel[0][playerid], 0);

	CPanel[1][playerid] = CreatePlayerTextDraw(playerid, 120.000000, 102.000000, "                   ");
	PlayerTextDrawBackgroundColor(playerid, CPanel[1][playerid], 255);
	PlayerTextDrawFont(playerid, CPanel[1][playerid], 1);
	PlayerTextDrawLetterSize(playerid, CPanel[1][playerid], 1.400000, 1.000000);
	PlayerTextDrawColor(playerid, CPanel[1][playerid], -1);
	PlayerTextDrawSetOutline(playerid, CPanel[1][playerid], 0);
	PlayerTextDrawSetProportional(playerid, CPanel[1][playerid], 1);
	PlayerTextDrawSetShadow(playerid, CPanel[1][playerid], 1);
	PlayerTextDrawUseBox(playerid, CPanel[1][playerid], 1);
	PlayerTextDrawBoxColor(playerid, CPanel[1][playerid], 1296911871);
	PlayerTextDrawTextSize(playerid, CPanel[1][playerid], 511.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid, CPanel[1][playerid], 0);

	CPanel[2][playerid] = CreatePlayerTextDraw(playerid, 120.000000, 355.000000, "                   ");
	PlayerTextDrawBackgroundColor(playerid, CPanel[2][playerid], 255);
	PlayerTextDrawFont(playerid, CPanel[2][playerid], 1);
	PlayerTextDrawLetterSize(playerid, CPanel[2][playerid], 1.400000, 1.000000);
	PlayerTextDrawColor(playerid, CPanel[2][playerid], -1);
	PlayerTextDrawSetOutline(playerid, CPanel[2][playerid], 0);
	PlayerTextDrawSetProportional(playerid, CPanel[2][playerid], 1);
	PlayerTextDrawSetShadow(playerid, CPanel[2][playerid], 1);
	PlayerTextDrawUseBox(playerid, CPanel[2][playerid], 1);
	PlayerTextDrawBoxColor(playerid, CPanel[2][playerid], 1296911871);
	PlayerTextDrawTextSize(playerid, CPanel[2][playerid], 511.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid, CPanel[2][playerid], 0);

	CPanel[3][playerid] = CreatePlayerTextDraw(playerid, 120.000000, 103.000000, "         ");
	PlayerTextDrawBackgroundColor(playerid, CPanel[3][playerid], 255);
	PlayerTextDrawFont(playerid, CPanel[3][playerid], 1);
	PlayerTextDrawLetterSize(playerid, CPanel[3][playerid], 1.400000, 3.500001);
	PlayerTextDrawColor(playerid, CPanel[3][playerid], -1);
	PlayerTextDrawSetOutline(playerid, CPanel[3][playerid], 0);
	PlayerTextDrawSetProportional(playerid, CPanel[3][playerid], 1);
	PlayerTextDrawSetShadow(playerid, CPanel[3][playerid], 1);
	PlayerTextDrawUseBox(playerid, CPanel[3][playerid], 1);
	PlayerTextDrawBoxColor(playerid, CPanel[3][playerid], 1296911871);
	PlayerTextDrawTextSize(playerid, CPanel[3][playerid], 120.000000, 3.000000);
	PlayerTextDrawSetSelectable(playerid, CPanel[3][playerid], 0);

	CPanel[4][playerid] = CreatePlayerTextDraw(playerid, 515.000000, 103.000000, "         ");
	PlayerTextDrawBackgroundColor(playerid, CPanel[4][playerid], 255);
	PlayerTextDrawFont(playerid, CPanel[4][playerid], 1);
	PlayerTextDrawLetterSize(playerid, CPanel[4][playerid], 1.400000, 3.500001);
	PlayerTextDrawColor(playerid, CPanel[4][playerid], -1);
	PlayerTextDrawSetOutline(playerid, CPanel[4][playerid], 0);
	PlayerTextDrawSetProportional(playerid, CPanel[4][playerid], 1);
	PlayerTextDrawSetShadow(playerid, CPanel[4][playerid], 1);
	PlayerTextDrawUseBox(playerid, CPanel[4][playerid], 1);
	PlayerTextDrawBoxColor(playerid, CPanel[4][playerid], 1296911871);
	PlayerTextDrawTextSize(playerid, CPanel[4][playerid], 507.000000, 4.000000);
	PlayerTextDrawSetSelectable(playerid, CPanel[4][playerid], 0);

	CPanel[5][playerid] = CreatePlayerTextDraw(playerid, 266.000000, 116.000000, "CONTROL PANEL");
	PlayerTextDrawBackgroundColor(playerid, CPanel[5][playerid], 255);
	PlayerTextDrawFont(playerid, CPanel[5][playerid], 2);
	PlayerTextDrawLetterSize(playerid, CPanel[5][playerid], 0.300000, 2.500000);
	PlayerTextDrawColor(playerid, CPanel[5][playerid], -1);
	PlayerTextDrawSetOutline(playerid, CPanel[5][playerid], 1);
	PlayerTextDrawSetProportional(playerid, CPanel[5][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, CPanel[5][playerid], 0);

	CPanel[6][playerid] = CreatePlayerTextDraw(playerid, 267.000000, 321.000000, "ld_otb2:butna");
	PlayerTextDrawBackgroundColor(playerid, CPanel[6][playerid], 0);
	PlayerTextDrawFont(playerid, CPanel[6][playerid], 4);
	PlayerTextDrawLetterSize(playerid, CPanel[6][playerid], 0.810000, 1.000000);
	PlayerTextDrawColor(playerid, CPanel[6][playerid], -1);
	PlayerTextDrawSetOutline(playerid, CPanel[6][playerid], 0);
	PlayerTextDrawSetProportional(playerid, CPanel[6][playerid], 1);
	PlayerTextDrawSetShadow(playerid, CPanel[6][playerid], 1);
	PlayerTextDrawUseBox(playerid, CPanel[6][playerid], 1);
	PlayerTextDrawBoxColor(playerid, CPanel[6][playerid], 255);
	PlayerTextDrawTextSize(playerid, CPanel[6][playerid], 98.000000, 31.000000);
	PlayerTextDrawSetSelectable(playerid, CPanel[6][playerid], 1);

	CPanel[7][playerid] = CreatePlayerTextDraw(playerid, 151.000000, 154.000000, "SERVER HOSTNAME ~w~: TEST SERVER [GAMEMODETYPE] [VERSION]");
	PlayerTextDrawBackgroundColor(playerid, CPanel[7][playerid], 255);
	PlayerTextDrawFont(playerid, CPanel[7][playerid], 1);
	PlayerTextDrawLetterSize(playerid, CPanel[7][playerid], 0.230000, 1.400000);
	PlayerTextDrawColor(playerid, CPanel[7][playerid], 8454143);
	PlayerTextDrawSetOutline(playerid, CPanel[7][playerid], 1);
	PlayerTextDrawSetProportional(playerid, CPanel[7][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, CPanel[7][playerid], 0);

	CPanel[8][playerid] = CreatePlayerTextDraw(playerid, 151.000000, 175.000000, "SERVER MAPNAME ~w~ : SAN ANDREAS");
	PlayerTextDrawBackgroundColor(playerid, CPanel[8][playerid], 255);
	PlayerTextDrawFont(playerid, CPanel[8][playerid], 1);
	PlayerTextDrawLetterSize(playerid, CPanel[8][playerid], 0.230000, 1.400000);
	PlayerTextDrawColor(playerid, CPanel[8][playerid], 8454143);
	PlayerTextDrawSetOutline(playerid, CPanel[8][playerid], 1);
	PlayerTextDrawSetProportional(playerid, CPanel[8][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, CPanel[8][playerid], 0);

	CPanel[9][playerid] = CreatePlayerTextDraw(playerid, 151.000000, 196.000000, "SERVER GAMEMODE ~w~: EVERY TYPE V1.0.4");
	PlayerTextDrawBackgroundColor(playerid, CPanel[9][playerid], 255);
	PlayerTextDrawFont(playerid, CPanel[9][playerid], 1);
	PlayerTextDrawLetterSize(playerid, CPanel[9][playerid], 0.230000, 1.400000);
	PlayerTextDrawColor(playerid, CPanel[9][playerid], 8454143);
	PlayerTextDrawSetOutline(playerid, CPanel[9][playerid], 1);
	PlayerTextDrawSetProportional(playerid, CPanel[9][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, CPanel[9][playerid], 0);

	CPanel[10][playerid] = CreatePlayerTextDraw(playerid, 151.000000, 218.000000, "SERVER PASSWORD ~W~: NO PASSWORD");
	PlayerTextDrawBackgroundColor(playerid, CPanel[10][playerid], 255);
	PlayerTextDrawFont(playerid, CPanel[10][playerid], 1);
	PlayerTextDrawLetterSize(playerid, CPanel[10][playerid], 0.230000, 1.400000);
	PlayerTextDrawColor(playerid, CPanel[10][playerid], 8454143);
	PlayerTextDrawSetOutline(playerid, CPanel[10][playerid], 1);
	PlayerTextDrawSetProportional(playerid, CPanel[10][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, CPanel[10][playerid], 0);

	CPanel[11][playerid] = CreatePlayerTextDraw(playerid, 454.000000, 135.000000, "EDIT");
	PlayerTextDrawBackgroundColor(playerid, CPanel[11][playerid], 255);
	PlayerTextDrawFont(playerid, CPanel[11][playerid], 2);
	PlayerTextDrawLetterSize(playerid, CPanel[11][playerid], 0.240000, 1.000000);
	PlayerTextDrawColor(playerid, CPanel[11][playerid], 8454143);
	PlayerTextDrawSetOutline(playerid, CPanel[11][playerid], 1);
	PlayerTextDrawSetProportional(playerid, CPanel[11][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, CPanel[11][playerid], 0);

	CPanel[12][playerid] = CreatePlayerTextDraw(playerid, 460.000000, 155.000000, "ld_dual:light");
	PlayerTextDrawBackgroundColor(playerid, CPanel[12][playerid], 0);
	PlayerTextDrawFont(playerid, CPanel[12][playerid], 4);
	PlayerTextDrawLetterSize(playerid, CPanel[12][playerid], 0.400000, 0.899999);
	PlayerTextDrawColor(playerid, CPanel[12][playerid], -65281);
	PlayerTextDrawSetOutline(playerid, CPanel[12][playerid], 1);
	PlayerTextDrawSetProportional(playerid, CPanel[12][playerid], 1);
	PlayerTextDrawUseBox(playerid, CPanel[12][playerid], 1);
	PlayerTextDrawBoxColor(playerid, CPanel[12][playerid], 255);
	PlayerTextDrawTextSize(playerid, CPanel[12][playerid], 11.000000, 13.000000);
	PlayerTextDrawSetSelectable(playerid, CPanel[12][playerid], 1);

	CPanel[13][playerid] = CreatePlayerTextDraw(playerid, 460.000000, 175.000000, "ld_dual:light");
	PlayerTextDrawBackgroundColor(playerid, CPanel[13][playerid], 0);
	PlayerTextDrawFont(playerid, CPanel[13][playerid], 4);
	PlayerTextDrawLetterSize(playerid, CPanel[13][playerid], 0.400000, 0.899999);
	PlayerTextDrawColor(playerid, CPanel[13][playerid], -65281);
	PlayerTextDrawSetOutline(playerid, CPanel[13][playerid], 1);
	PlayerTextDrawSetProportional(playerid, CPanel[13][playerid], 1);
	PlayerTextDrawUseBox(playerid, CPanel[13][playerid], 1);
	PlayerTextDrawBoxColor(playerid, CPanel[13][playerid], 255);
	PlayerTextDrawTextSize(playerid, CPanel[13][playerid], 11.000000, 13.000000);
	PlayerTextDrawSetSelectable(playerid, CPanel[13][playerid], 1);

	CPanel[14][playerid] = CreatePlayerTextDraw(playerid, 460.000000, 196.000000, "ld_dual:light");
	PlayerTextDrawBackgroundColor(playerid, CPanel[14][playerid], 0);
	PlayerTextDrawFont(playerid, CPanel[14][playerid], 4);
	PlayerTextDrawLetterSize(playerid, CPanel[14][playerid], 0.400000, 0.899999);
	PlayerTextDrawColor(playerid, CPanel[14][playerid], -65281);
	PlayerTextDrawSetOutline(playerid, CPanel[14][playerid], 1);
	PlayerTextDrawSetProportional(playerid, CPanel[14][playerid], 1);
	PlayerTextDrawUseBox(playerid, CPanel[14][playerid], 1);
	PlayerTextDrawBoxColor(playerid, CPanel[14][playerid], 255);
	PlayerTextDrawTextSize(playerid, CPanel[14][playerid], 11.000000, 13.000000);
	PlayerTextDrawSetSelectable(playerid, CPanel[14][playerid], 1);

	CPanel[15][playerid] = CreatePlayerTextDraw(playerid, 460.000000, 218.000000, "ld_dual:light");
	PlayerTextDrawBackgroundColor(playerid, CPanel[15][playerid], 0);
	PlayerTextDrawFont(playerid, CPanel[15][playerid], 4);
	PlayerTextDrawLetterSize(playerid, CPanel[15][playerid], 0.400000, 0.899999);
	PlayerTextDrawColor(playerid, CPanel[15][playerid], -65281);
	PlayerTextDrawSetOutline(playerid, CPanel[15][playerid], 1);
	PlayerTextDrawSetProportional(playerid, CPanel[15][playerid], 1);
	PlayerTextDrawUseBox(playerid, CPanel[15][playerid], 1);
	PlayerTextDrawBoxColor(playerid, CPanel[15][playerid], 255);
	PlayerTextDrawTextSize(playerid, CPanel[15][playerid], 11.000000, 13.000000);
	PlayerTextDrawSetSelectable(playerid, CPanel[15][playerid], 1);

	CPanel[16][playerid] = CreatePlayerTextDraw(playerid, 286.000000, 325.000000, "CLOSE PANEL");
	PlayerTextDrawBackgroundColor(playerid, CPanel[16][playerid], 255);
	PlayerTextDrawFont(playerid, CPanel[16][playerid], 1);
	PlayerTextDrawLetterSize(playerid, CPanel[16][playerid], 0.270000, 1.700000);
	PlayerTextDrawColor(playerid, CPanel[16][playerid], -1);
	PlayerTextDrawSetOutline(playerid, CPanel[16][playerid], 1);
	PlayerTextDrawSetProportional(playerid, CPanel[16][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, CPanel[16][playerid], 0);

	CPanel[17][playerid] = CreatePlayerTextDraw(playerid, 151.000000, 241.000000, "SERVER WEATHER ~W~: 0");
	PlayerTextDrawBackgroundColor(playerid, CPanel[17][playerid], 255);
	PlayerTextDrawFont(playerid, CPanel[17][playerid], 1);
	PlayerTextDrawLetterSize(playerid, CPanel[17][playerid], 0.230000, 1.400000);
	PlayerTextDrawColor(playerid, CPanel[17][playerid], 8454143);
	PlayerTextDrawSetOutline(playerid, CPanel[17][playerid], 1);
	PlayerTextDrawSetProportional(playerid, CPanel[17][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, CPanel[17][playerid], 0);

	CPanel[18][playerid] = CreatePlayerTextDraw(playerid, 151.000000, 264.000000, "SERVER TIME ~W~: 00:00:00");
	PlayerTextDrawBackgroundColor(playerid, CPanel[18][playerid], 255);
	PlayerTextDrawFont(playerid, CPanel[18][playerid], 1);
	PlayerTextDrawLetterSize(playerid, CPanel[18][playerid], 0.230000, 1.400000);
	PlayerTextDrawColor(playerid, CPanel[18][playerid], 8454143);
	PlayerTextDrawSetOutline(playerid, CPanel[18][playerid], 1);
	PlayerTextDrawSetProportional(playerid, CPanel[18][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, CPanel[18][playerid], 0);

	CPanel[19][playerid] = CreatePlayerTextDraw(playerid, 460.000000, 241.000000, "ld_dual:light");
	PlayerTextDrawBackgroundColor(playerid, CPanel[19][playerid], 0);
	PlayerTextDrawFont(playerid, CPanel[19][playerid], 4);
	PlayerTextDrawLetterSize(playerid, CPanel[19][playerid], 0.400000, 0.899999);
	PlayerTextDrawColor(playerid, CPanel[19][playerid], -65281);
	PlayerTextDrawSetOutline(playerid, CPanel[19][playerid], 1);
	PlayerTextDrawSetProportional(playerid, CPanel[19][playerid], 1);
	PlayerTextDrawUseBox(playerid, CPanel[19][playerid], 1);
	PlayerTextDrawBoxColor(playerid, CPanel[19][playerid], 255);
	PlayerTextDrawTextSize(playerid, CPanel[19][playerid], 11.000000, 13.000000);
	PlayerTextDrawSetSelectable(playerid, CPanel[19][playerid], 1);

	CPanel[20][playerid] = CreatePlayerTextDraw(playerid, 460.000000, 263.000000, "ld_dual:light");
	PlayerTextDrawBackgroundColor(playerid, CPanel[20][playerid], 0);
	PlayerTextDrawFont(playerid, CPanel[20][playerid], 4);
	PlayerTextDrawLetterSize(playerid, CPanel[20][playerid], 0.400000, 0.899999);
	PlayerTextDrawColor(playerid, CPanel[20][playerid], -65281);
	PlayerTextDrawSetOutline(playerid, CPanel[20][playerid], 1);
	PlayerTextDrawSetProportional(playerid, CPanel[20][playerid], 1);
	PlayerTextDrawUseBox(playerid, CPanel[20][playerid], 1);
	PlayerTextDrawBoxColor(playerid, CPanel[20][playerid], 255);
	PlayerTextDrawTextSize(playerid, CPanel[20][playerid], 11.000000, 13.000000);
	PlayerTextDrawSetSelectable(playerid, CPanel[20][playerid], 1);
}

stock ShowCPanel(playerid)
{
	PlayerTextDrawShow(playerid, CPanel[0][playerid]);
	PlayerTextDrawShow(playerid, CPanel[1][playerid]);
	PlayerTextDrawShow(playerid, CPanel[2][playerid]);
	PlayerTextDrawShow(playerid, CPanel[3][playerid]);
	PlayerTextDrawShow(playerid, CPanel[4][playerid]);
	PlayerTextDrawShow(playerid, CPanel[5][playerid]);
	PlayerTextDrawShow(playerid, CPanel[6][playerid]);
	PlayerTextDrawShow(playerid, CPanel[7][playerid]);
	PlayerTextDrawShow(playerid, CPanel[8][playerid]);
	PlayerTextDrawShow(playerid, CPanel[9][playerid]);
	PlayerTextDrawShow(playerid, CPanel[10][playerid]);
	PlayerTextDrawShow(playerid, CPanel[11][playerid]);
	PlayerTextDrawShow(playerid, CPanel[12][playerid]);
	PlayerTextDrawShow(playerid, CPanel[13][playerid]);
	PlayerTextDrawShow(playerid, CPanel[14][playerid]);
	PlayerTextDrawShow(playerid, CPanel[15][playerid]);
	PlayerTextDrawShow(playerid, CPanel[16][playerid]);
	PlayerTextDrawShow(playerid, CPanel[17][playerid]);
	PlayerTextDrawShow(playerid, CPanel[18][playerid]);
	PlayerTextDrawShow(playerid, CPanel[19][playerid]);
	PlayerTextDrawShow(playerid, CPanel[20][playerid]);
	SelectTextDraw(playerid, 0x0080FF);
}

stock HideCPanel(playerid)
{
	for(new i = 0; i < 21; i++)
	{
		PlayerTextDrawHide(playerid, CPanel[i][playerid]);
	}
	CancelSelectTextDraw(playerid);
}

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("Control Panel by Rehasher loaded.");
	print("--------------------------------------\n");

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		LoadPlayerTextdraws(i);
	}
	GetServerVarAsString("hostname", ServerName, sizeof(ServerName));
	GetServerVarAsString("password", ServerPassword, sizeof(ServerPassword));
	GetServerVarAsString("mapname", ServerMap, sizeof(ServerMap));
	GetServerVarAsString("gamemodetext", ServerMode, sizeof(ServerMode));
	printf("%s %s %s %s", ServerName, ServerPassword, ServerMap, ServerMode);
	ServerWeather = 2;
	SetWeather(ServerWeather);
	gettime(ServerTime[0], ServerTime[1], ServerTime[2]);

	SetTimer("UpdateTextdraws", 900, true);
	return 1;
}
new Message[1500];
forward UpdateTextdraws();
public UpdateTextdraws()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		format(Message, sizeof(Message), "SERVER HOSTNAME ~w~: %s", ServerName);
		PlayerTextDrawSetString(i, CPanel[7][i], Message);

		format(Message, sizeof(Message), "SERVER MAPNAME ~w~: %s", ServerMap);
		PlayerTextDrawSetString(i, CPanel[8][i], Message);

		format(Message, sizeof(Message), "SERVER GAMEMODE ~w~: %s", ServerMode);
		PlayerTextDrawSetString(i, CPanel[9][i], Message);

		
		format(Message, sizeof(Message), "SERVER PASSWORD ~w~: %s", ServerPassword);
		PlayerTextDrawSetString(i, CPanel[10][i], Message);

		if(IsNull(ServerPassword))
		{
			PlayerTextDrawSetString(i, CPanel[10][i], "SERVER PASSWORD ~w~: None");
		}

		format(Message, sizeof(Message), "SERVER WEATHER ~w~: %d", ServerWeather);
		PlayerTextDrawSetString(i, CPanel[17][i], Message);

		GetPlayerTime(ServerTime[0], ServerTime[1], ServerTime[2]);
		format(Message, sizeof(Message), "SERVER TIME ~w~: %d:%d:%d", ServerTime[0], ServerTime[1], ServerTime[2]);
		PlayerTextDrawSetString(i, CPanel[18][i], Message);
	}
	return 1;
}
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == CPanel[6][playerid])
    {
         HideCPanel(playerid);
         CancelSelectTextDraw(playerid);
    }
    if(playertextid == CPanel[12][playerid])
    {
    	ShowPlayerDialog(playerid, DIALOG_SERVERNAME, DIALOG_STYLE_INPUT, "Update Server Name", "{FFFFFF} Type a new server name to update it.", "Update", "");
    }
    if(playertextid == CPanel[13][playerid])
    {
    	ShowPlayerDialog(playerid, DIALOG_SERVERMAP, DIALOG_STYLE_INPUT, "Update Server Map Name", "{FFFFFF} Type a new server map name to update it.", "Update", "");
    }
    if(playertextid == CPanel[14][playerid])
    {
    	ShowPlayerDialog(playerid, DIALOG_SERVERMODE, DIALOG_STYLE_INPUT, "Update Server Mode", "{FFFFFF} Type a new server mode name to update it.", "Update", "");
    }
    if(playertextid == CPanel[15][playerid])
    {
    	ShowPlayerDialog(playerid, DIALOG_SERVERPASSWORD, DIALOG_STYLE_INPUT, "Update Server Password", "{FFFFFF} Type a new server password to update it. (Locks the server) (Type None to remove it)", "Update", "");
    }
    if(playertextid == CPanel[19][playerid])
    {
    	ShowPlayerDialog(playerid, DIALOG_SERVERWEATHER, DIALOG_STYLE_INPUT, "Update Server Weather", "{FFFFFF} Type a new weather id to update it.", "Update", "");
    }
    if(playertextid == CPanel[20][playerid])
    {
		ShowPlayerDialog(playerid, DIALOG_SERVERTIME, DIALOG_STYLE_INPUT, "Update Server Time", "{FFFFFF} Type the new time (hour only, example '12') to update it.", "Update", "");
    }
    return 1;
}
public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	LoadPlayerTextdraws(playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp("/cpanel", cmdtext, true, 10) == 0)
	{
		if(IsPlayerAdmin(playerid) == 1)
		{
			ShowCPanel(playerid);
		}
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_SERVERNAME)
	{
		format(ServerName, sizeof(ServerName), "%s", inputtext);
		format(Message, sizeof(Message), "hostname %s", ServerName);
		SendRconCommand(Message);
	}
	if(dialogid == DIALOG_SERVERMAP)
	{
		format(ServerMap, sizeof(ServerMap), "%s", inputtext);
		format(Message, sizeof(Message), "mapname %s", ServerMap);
		SendRconCommand(Message);
	}
	if(dialogid == DIALOG_SERVERMODE)
	{
		format(ServerMode, sizeof(ServerMode), "%s", inputtext);
		format(Message, sizeof(Message), "gamemodetext %s", ServerMode);
		SendRconCommand(Message);
	}
	if(dialogid == DIALOG_SERVERPASSWORD)
	{
		format(ServerPassword, sizeof(ServerPassword), "%s", inputtext);
		format(Message, sizeof(Message), "password %s", ServerPassword);
		SendRconCommand(Message);

		if(strfind(ServerPassword, "None", true) != -1) //returns 4 (!= -1 because -1 would be 'not found')
		{
		    SendRconCommand("password 0");
		}
	}
	if(dialogid == DIALOG_SERVERWEATHER)
	{
		ServerWeather = strval(inputtext);
		SetWeather(ServerWeather);
	}
	if(dialogid == DIALOG_SERVERTIME)
	{
		ServerTime[0] = strval(inputtext);
		SetWorldTime(ServerTime[0]);
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}