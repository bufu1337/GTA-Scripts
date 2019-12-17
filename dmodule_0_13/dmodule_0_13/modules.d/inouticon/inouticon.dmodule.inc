// Version 1.0
inouticon_Connect(playerid) {
	new bfcolor;
	bfcolor = GetPlayerColor(playerid);
	SetPlayerColor(playerid,0xFFFFFFAA);
	SendDeathMessage(INVALID_PLAYER_ID,playerid, 200);
	SetPlayerColor(playerid,bfcolor);
}

inouticon_Disconnect(playerid,reason) {
#pragma unused reason
	SendDeathMessage(INVALID_PLAYER_ID, playerid, 201);
}