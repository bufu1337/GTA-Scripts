////////////////////////////////////////////////////////////////////////////////
//
//                      Lach's Multi AFK System v1.0                          //
//                           by Antonio [G-RP]                                //
//
////////////////////////////////////////////////////////////////////////////////
//
//    FEEL FREE TO EDIT THIS FILTERSCRIPT - BUT LEAVE THE CREDITS IN IT!
//

#include <a_samp>
#define MAX_AFKTIME     6 // In Minutes

forward StartAFK(playerid);
forward StopAFK(playerid);
forward Check();

new Float:Pos[MAX_PLAYERS][3];

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Multi AFK System v1.0 by Antonio[G-RP]");
	print("--------------------------------------\n");

	SetTimer("Check", 1000, 1);
	return 1;
}

public OnFilterScriptExit()
{
	for(new i=0; i<MAX_PLAYERS; i++) {
		StopAFK(i);
	}
	return 1;
}

public Check()
{
	for(new i=0; i<MAX_PLAYERS; i++) {
	    if(!IsPlayerConnected(i)) continue;
	    new Float:x, Float:y, Float:z;
	    GetPlayerPos(i, x, y, z);

	    if(!GetPVarInt(i,"TabbedOut"))
		{
			if((GetTickCount() - GetPVarInt(i, "LastUpdate")) >= 1000) {
				SetPVarInt(i, "TabbedOut", 1);
				CallLocalFunction("StartAFK", "i", i);
			}
			if(x != 0) {
				if(Pos[i][0] == x && Pos[i][1] == y && Pos[i][2] == z) {
					SetPVarInt(i, "AFKTime", GetPVarInt(i, "AFKTime") + 1);
				}
			}

		 	if(!(Pos[i][0] == x && Pos[i][1] == y && Pos[i][2] == z)) {
		    	CallLocalFunction("StopAFK", "i", i);
			}
		}
   		if(GetPVarInt(i, "TabbedOut"))
		{
		    SetPVarInt(i, "AFKTime", GetPVarInt(i, "AFKTime") + 1);
		}

		if(GetPVarInt(i, "AFKTime") == 300) {
  			CallLocalFunction("StartAFK", "i", i);
		}

		if(GetPVarInt(i, "AFKTime") >= MAX_AFKTIME*60) {
            printf("Player AFK time %d", GetPVarInt(i, "AFKTime"));
			new string[70], name[24];
			GetPlayerName(i, name, 24);
			format(string, sizeof(string), "%s was kicked by system for being AFK for %d minute(s).", name, MAX_AFKTIME);
			SendClientMessageToAll(0xFFFFFFFF, string);
		    Kick(i);
		}
		GetPlayerPos(i, Pos[i][0], Pos[i][1], Pos[i][2]);
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	for(new i=0; i<3; i++) {
	    Pos[playerid][i] = 0;
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	DeletePVar(playerid, "TabbedOut");
	DeletePVar(playerid, "LastUpdate");
	return 1;
}

public OnPlayerUpdate(playerid)
{
	SetPVarInt(playerid, "LastUpdate", GetTickCount());
	if(GetPVarInt(playerid, "TabbedOut")) {
	    SetPVarInt(playerid, "TabbedOut", 0);
	    CallLocalFunction("StopAFK", "i", playerid);
	}
	return 1;
}

public StartAFK(playerid)
{
	if(GetPVarInt(playerid, "AFKText")) Delete3DTextLabel(Text3D:GetPVarInt(playerid, "AFKText"));
	SetPVarInt(playerid, "AFKText", _:Create3DTextLabel("Player is AFK", 0xFF0000FF, 0.0, 0.0, 0.0, 25.0, GetPlayerVirtualWorld(playerid), 1));
	Attach3DTextLabelToPlayer(Text3D:GetPVarInt(playerid, "AFKText"), playerid, 0.0, 0.0, 0.3);
	SetPlayerColor(playerid, 0xFF0000FF);
	return 1;
}

public StopAFK(playerid)
{
	if(GetPVarInt(playerid, "AFKText")) Delete3DTextLabel(Text3D:GetPVarInt(playerid, "AFKText"));
	if(GetPVarInt(playerid, "AFKTime")) DeletePVar(playerid, "AFKTime");
	SetPlayerColor(playerid, 0xFFFFFFFF);
	return 1;
}