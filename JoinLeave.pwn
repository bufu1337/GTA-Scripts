#include <a_samp>
#define FILTERSCRIPT
public OnPlayerConnect(playerid){new pName[MAX_PLAYER_NAME];new string[48];GetPlayerName(playerid, pName, sizeof(pName));format(string, sizeof(string), "%s has joined the server!", pName);SendClientMessageToAll(0xFFFFFFAA, string);return 1;}
public OnPlayerDisconnect(playerid,reason){new Reason[256],string[256],name[24]; GetPlayerName(playerid,name,24);switch(reason) { case 0: Reason = "Timed Out"; case 1: Reason = "Leaving"; case 2: Reason = "Kick/Ban"; }format(string,256,"%s has left the server. (%s)",name,Reason);for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && i != playerid) SendClientMessage(i,0xFFFFFFAA,string);return 1;}
public OnPlayerDeath(playerid, killerid, reason){
if (killerid == INVALID_PLAYER_ID) {SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
} else {
SendDeathMessage(killerid,playerid,reason);}return 1;}
