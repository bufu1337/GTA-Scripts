// Version 1.0
inoutmsg_Connect(playerid) {
	for (new p;p<MAX_PLAYERS;p++) if (IsPlayerConnected(p)) {
		SystemMsgFormatStr(p,gettext(p,PLAYER_JOINED_SERVER),PlayerName(playerid));
	}
}

inoutmsg_Disconnect(playerid,reason) {
#pragma unused reason
	for (new p;p<MAX_PLAYERS;p++) if (IsPlayerConnected(p))  {
		SystemMsgFormatStr(p,gettext(p,PLAYER_LEFT_SERVER),PlayerName(playerid));
	}
}