// Mind control script created by JakeMan aka Celson.

#include <a_samp>

new controlling[MAX_PLAYERS];

new controlled[MAX_PLAYERS];

forward IsHoldingKey(playerid);

public OnPlayerDisconnect(playerid, reason)
{
	if(controlling[playerid] > 0)
	{
		ClearAnimations(controlling[playerid]-1);
		SendClientMessage(controlling[playerid]-1,0xFFFFFFFF,"You are now free of mind control.");
		controlled[controlling[playerid]-1] = 0;
		controlling[playerid] = 0;
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
    ApplyAnimation(playerid,"ped","null",0.0,0,0,0,0,0);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[128], idx;
	cmd = strtok(cmdtext, idx);
	if(strcmp(cmd, "/control", true) == 0)
	{
	    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,0xFF0000FF,"Only RCON admins can use this command.");
	    if(controlling[playerid] > 0) return SendClientMessage(playerid,0xFF0000FF,"You are already controlling someone.");
		new tmp[128];
		tmp = strtok(cmdtext, idx);
		if(strlen(tmp) == 0) return SendClientMessage(playerid, 0xFFFFFFFF, "USAGE: /control [ID]");
		if(strval(tmp) == playerid) return SendClientMessage(playerid,0xFF0000FF, "You cannot use this command on yourself.");
		if(!IsPlayerConnected(strval(tmp))) return SendClientMessage(playerid,0xFF0000FF, "Invalid ID");
		if(GetPlayerState(strval(tmp)) != 1) return SendClientMessage(playerid,0xFF0000FF, "The victim must be on foot for you to control them.");
		TogglePlayerSpectating(playerid, 1);
		PlayerSpectatePlayer(playerid,strval(tmp));
		controlling[playerid] = strval(tmp)+1;
		controlled[strval(tmp)] = 1;
		SetTimerEx("IsHoldingKey",100,0,"i",playerid);
		new Float:rot;
		ClearAnimations(strval(tmp));
		GetPlayerFacingAngle(strval(tmp),rot);
		SetPlayerFacingAngle(strval(tmp),floatmul(floatround(floatdiv(Float:rot,9.0),floatround_round),9.0));
		return 1;
	}
	if(strcmp(cmd, "/ceasecontrol", true) == 0)
	{
  		if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,0xFF0000FF,"Only RCON admins can use this command.");
  		if(controlling[playerid] == 0) return SendClientMessage(playerid,0xFF0000FF,"You are not controlling anyone.");
		ClearAnimations(controlling[playerid]-1);
		SendClientMessage(controlling[playerid]-1,0xFFFFFFFF,"You are now free of mind control.");
		controlled[controlling[playerid]-1] = 0;
		controlling[playerid] = 0;
		TogglePlayerSpectating(playerid, 0);
		return 1;
	}
	return 0;
}

public IsHoldingKey(playerid)
{
    if(controlling[playerid] > 0 && IsPlayerConnected(controlling[playerid]-1))
	{
        SetTimerEx("IsHoldingKey",100,0,"i",playerid);
		new keys, updown, leftright;
		GetPlayerKeys(playerid, keys, updown, leftright);
		new victimid = controlling[playerid]-1;
		new interior = GetPlayerInterior(victimid);
		if(GetPlayerInterior(playerid) != interior) return SetPlayerInterior(playerid,interior);
  		if (leftright == KEY_LEFT && updown == KEY_UP)
		{
	  		new Float:Rot;
			GetPlayerFacingAngle(victimid,Rot);
			SetPlayerFacingAngle(victimid,Rot+9);
		}
	  	if (leftright == KEY_RIGHT && updown == KEY_UP)
		{
	  		new Float:Rot;
			GetPlayerFacingAngle(victimid,Rot);
			SetPlayerFacingAngle(victimid,Rot-9);
		}
		if (updown == KEY_UP)
		{
		    if(keys == KEY_SPRINT)
		    {
                ApplyAnimation(victimid,"ped","sprint_civi",4.0,1,1,1,1,0);
		        return 1;
		    }
		    if(keys == KEY_WALK)
		    {
		        ApplyAnimation(victimid,"ped","WALK_player",4.0,1,1,1,1,0);
		        return 1;
		    }
    	    ApplyAnimation(victimid,"ped","run_player",4.0,1,1,1,1,0);
			return 1;
		}
		ApplyAnimation(victimid,"ped","IDLE_stance",4.0,1,1,1,1,0);
		return 1;
	}
	else
	{
	    controlling[playerid] = 0;
		TogglePlayerSpectating(playerid, 0);
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(controlled[playerid] == 1) return ClearAnimations(playerid);
	return 1;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
