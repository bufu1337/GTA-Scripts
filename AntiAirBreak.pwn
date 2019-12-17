/*
==============================================
	   Anty Player AirBreak by RPS 1.3.1
			Update: 19.02.2011
  Wyprodukowano dla Pawno.PL, GTACenter.Info
			oraz forum.sa-mp.com
==============================================
*/
#include <a_samp>

#define DYS 25
#define PENALTY 2 // 0 - BAN | 1 - KICK | 2 - Send message to admins

public OnFilterScriptInit()
	return SetTimer("OnPlayerUpdateEx", 2000, 1);

public OnPlayerSpawn(playerid)	
	return SetPVarInt(playerid, "NoAB", 1);

public OnPlayerStateChange(playerid, newstate, oldstate)
	return SetPVarInt(playerid, "NoAB", 1);

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
	return SetPVarInt(playerid, "NoAB", 1);

public OnPlayerExitVehicle(playerid, vehicleid)
	return SetPVarInt(playerid, "NoAB", 1);
	
public OnPlayerCommandText(playerid, cmdtext[])
{
	SetPVarInt(playerid, "NoAB", 1);
	return 0;
}

forward OnPlayerUpdateEx();
public OnPlayerUpdateEx()
{
    for(new playerid, g = GetMaxPlayers(); playerid < g; playerid++)
	{
	    new Float:pos[3];
		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	    if(GetPlayerSurfingVehicleID(playerid) == INVALID_VEHICLE_ID && !IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPlayerSpecialAction(playerid) != 2 && GetPlayerState(playerid) != PLAYER_STATE_SPAWNED)
	    {
	        if(!GetPVarInt(playerid, "NoAB"))
	        {
         		switch(GetPlayerAnimationIndex(playerid))
				{
					case 958, 959, 961, 962, 965, 971, 1126, 1130, 1132, 1134, 1156, 1208: 
					{
						SetPVarInt(playerid, "NoAB", 1);
						continue;
					}
				}
				
  				if
				(
					(floatabs(pos[0] - GetPVarFloat(playerid, "OldPosX"))) > DYS || (floatabs(GetPVarFloat(playerid, "OldPosX") - pos[0])) > DYS ||
					(floatabs(pos[1] - GetPVarFloat(playerid, "OldPosY"))) > DYS || (floatabs(GetPVarFloat(playerid, "OldPosY") - pos[1])) > DYS ||
					(floatabs(pos[2] - GetPVarFloat(playerid, "OldPosZ"))) > DYS/2 || (floatabs(GetPVarFloat(playerid, "OldPosZ") - pos[2])) > DYS/2
				)
				{
					switch(PENALTY)
					{
						case 0: BanEx(playerid, "Airbreak");
						case 1: Kick(playerid);
						case 2: 
						{
							new str[60],
								name[MAX_PLAYER_NAME];
								
							GetPlayerName(playerid, name, sizeof name);
							format(str, sizeof str, "%s (ID: %d) cheating ! (Airbreak)", name, playerid);
							SendClientMessageToAdmins(-1, str);
						}
					}
				}
			}
			SetPVarInt(playerid, "NoAB", 0);
		}
		SetPVarFloat(playerid, "OldPosX", pos[0]);
		SetPVarFloat(playerid, "OldPosY", pos[1]);
		SetPVarFloat(playerid, "OldPosZ", pos[2]);
	}
	return 1;
}

stock SendClientMessageToAdmins(color, text[])
{ 
	for(new a, g = GetMaxPlayers(); a < g; a++)
		if(IsPlayerConnected(a) && IsPlayerAdmin(a))
			SendClientMessage(a, color, text); 
} 