                                                        ///////////////////////
                                                        //////Death Camera/////
                                                        ///////Created by://///
                                                        ///////°Fallout°///////
                                                        ///////////////////////

#include <a_samp>

forward CountDown(playerid);

new CountDownTimer[MAX_PLAYERS];
new KillerID[MAX_PLAYERS];
new bool: PlayerDied[MAX_PLAYERS];
new Float:currtime[MAX_PLAYERS] = 6.0;
new Text:TimeText[MAX_PLAYERS];

public OnPlayerConnect(playerid)
{
	TimeText[playerid] = TextDrawCreate(279.000000,122.000000,"Respawn in: 6.0");
	TextDrawUseBox(TimeText[playerid],1);
	TextDrawBoxColor(TimeText[playerid],0x00000033);
	TextDrawTextSize(TimeText[playerid],364.000000,0.000000);
	TextDrawAlignment(TimeText[playerid],0);
	TextDrawBackgroundColor(TimeText[playerid],0x000000ff);
	TextDrawFont(TimeText[playerid],1);
	TextDrawLetterSize(TimeText[playerid],0.299999,1.100000);
	TextDrawColor(TimeText[playerid],0xffffffff);
	TextDrawSetOutline(TimeText[playerid],1);
	TextDrawSetProportional(TimeText[playerid],1);
	TextDrawSetShadow(TimeText[playerid],1);
}

public OnPlayerDisconnect(playerid, reason)
{
    TextDrawDestroy(TimeText[playerid]);
}

public OnPlayerSpawn(playerid)
{
	if(PlayerDied[playerid] == true)
	{
		PlayerDied[playerid] = false;
	    if(KillerID[playerid] != INVALID_PLAYER_ID)
		{
		    if(IsPlayerInAnyVehicle(KillerID[playerid]))
		    {
				SetPlayerInterior(playerid,GetPlayerInterior(KillerID[playerid]));
				TogglePlayerSpectating(playerid, 1);
				PlayerSpectateVehicle(playerid, GetPlayerVehicleID(KillerID[playerid]));
		    }
		    else
		    {
				SetPlayerInterior(playerid,GetPlayerInterior(KillerID[playerid]));
				TogglePlayerSpectating(playerid, 1);
				PlayerSpectatePlayer(playerid, KillerID[playerid]);
		    }
			TogglePlayerSpectating(playerid, 1);
			TextDrawShowForPlayer(playerid, Text:TimeText[playerid]);
			CountDownTimer[playerid] = SetTimerEx("CountDown",100,1, "i", playerid);
		}
	}
}

public OnPlayerDeath(playerid, killerid, reason)
{
	KillerID[playerid] = killerid;
	PlayerDied[playerid] = true;
}

public CountDown(playerid)
{
	if(currtime[playerid] >= 0.1)
	{
	    currtime[playerid] = floatsub(currtime[playerid], 0.1);
		new String[128];
	    format(String, sizeof String, "Respawn in: %.1f", currtime);
	    TextDrawSetString(Text:TimeText[playerid], String);
	}
	else
	{
		KillTimer(CountDownTimer[playerid]);
		TextDrawHideForPlayer(playerid, Text:TimeText[playerid]);
		currtime[playerid] = 6.0;
		TogglePlayerSpectating(playerid, 0);
	}
}
