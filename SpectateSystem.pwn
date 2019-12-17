#include <a_samp>

#define FILTERSCRIPT
#define colorSPECTATE       0xffffffff//Write a color here :)

new SpectatedPlayer[MAX_PLAYERS];
new bool:IsPlayerSpectating[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Spectate System Loaded..");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == KEY_SUBMISSION && !IsPlayerSpectating[playerid])//Button 2
	{
	    SpectateOn(playerid);
	}
	if(newkeys == KEY_SUBMISSION && IsPlayerSpectating[playerid])//Button 2
	{
	    SpectateOff(playerid);
	}
	if(newkeys == KEY_ANALOG_RIGHT && IsPlayerSpectating[playerid])//Num4
	{
	    SpectatePrevious(playerid);
	}
	if(newkeys == KEY_ANALOG_LEFT && IsPlayerSpectating[playerid])//Num6
	{
	    SpectateNext(playerid);
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
		for(new i=0; i<MAX_PLAYERS; i++)
		{
		    if(IsPlayerConnected(i) && IsPlayerSpectating[i] && SpectatedPlayer[i] == playerid)
		    {
		        new str[128];
		        PlayerSpectateVehicle(i, GetPlayerVehicleID(SpectatedPlayer[i]));
		        format(str, 128, "Spectating type changed, %s entered a vehicle.", GetName(playerid));
		        SendClientMessage(i, colorSPECTATE, str);
		    }
		}
	}
	if(newstate == PLAYER_STATE_ONFOOT)
	{
	    for(new i=0; i<MAX_PLAYERS; i++)
		{
		    if(IsPlayerConnected(i) && IsPlayerSpectating[i] && SpectatedPlayer[i] == playerid)
		    {
		        new str[128];
		        PlayerSpectatePlayer(i, SpectatedPlayer[i]);
		        format(str, 128, "Spectating type changed, %s left the vehicle.", GetName(playerid));
		        SendClientMessage(i, colorSPECTATE, str);
		    }
		}
	}
	return 1;
}

forward SpectateOn(playerid);
public SpectateOn(playerid)
{
	TogglePlayerSpectating(playerid, 1);
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(!IsPlayerConnected(i)) continue;
	    SpectatedPlayer[playerid] = i;
		PlayerSpectatePlayer(playerid, i);
	}
	IsPlayerSpectating[playerid] = true;
	new str[128];
	format(str, 128, "You are now spectating %s (ID:%d).", GetName(SpectatedPlayer[playerid]), SpectatedPlayer[playerid]);
	SendClientMessage(playerid, colorSPECTATE, str);
}

forward SpectateOff(playerid);
public SpectateOff(playerid)
{
	TogglePlayerSpectating(playerid, 0);
	SpectatedPlayer[playerid] = 0;
	IsPlayerSpectating[playerid] = false;
	SendClientMessage(playerid, colorSPECTATE, "You stopped spectating.");
}

forward SpectateNext(playerid);
public SpectateNext(playerid)
{
	SpectatedPlayer[playerid]++;
	for(new i=SpectatedPlayer[playerid]; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i)) continue;
		if(IsPlayerInAnyVehicle(i))
		{
			PlayerSpectateVehicle(playerid, GetPlayerVehicleID(i));
		}
		else
		{
			PlayerSpectatePlayer(playerid, i);
		}
		SpectatedPlayer[playerid] = i;
		break;
	}
	new str[128];
	format(str, 128, "You are now spectating %s (ID:%d).", GetName(SpectatedPlayer[playerid]), SpectatedPlayer[playerid]);
	SendClientMessage(playerid, colorSPECTATE, str);
}

forward SpectatePrevious(playerid);
public SpectatePrevious(playerid)
{
    SpectatedPlayer[playerid]--;
	for(new i=SpectatedPlayer[playerid]; i>-1; i--)
	{
		if(!IsPlayerConnected(i)) continue;
		if(IsPlayerInAnyVehicle(i))
		{
			PlayerSpectateVehicle(playerid, GetPlayerVehicleID(i));
		}
		else
		{
			PlayerSpectatePlayer(playerid, i);
		}
		SpectatedPlayer[playerid] = i;
		break;
	}
	new str[128];
	format(str, 128, "You are now spectating %s (ID:%d).", GetName(SpectatedPlayer[playerid]), SpectatedPlayer[playerid]);
	SendClientMessage(playerid, colorSPECTATE, str);
}

stock GetName(i)
{
	new name[24];
	GetPlayerName(i, name, 24);
	return name;
}