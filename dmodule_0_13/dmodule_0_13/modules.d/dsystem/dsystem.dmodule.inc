/*
 *            DSystem functions 1.0
 *       (c) Copyright 2007 by DracoBlue
 *
 * @author    : DracoBlue (http://dracoblue.com)
 * @date      : 2nd Dec 2007
 *
 * This file is provided as is (no warranties).
 *
 * Feel free to use it, a little message in
 * about box is honouring thing, isn't it?
 *
 */

/*
 * Send a system msg to the player
 * @param playerid int ID of the player
 * @param msg string Message to sent
 * @return 1
 */
stock SystemMsg(playerid,msg[]) {
   if ((IsPlayerConnected(playerid))&&(strlen(msg)>0)) {
       SendClientMessage(playerid,COLOR_SYSTEM,msg);
   }
   return 1;
}

/*
 * Send a formated system msg to the player
 * @param playerid int ID of the player
 * @param msg string Message to sent
 * @param param int Value to put into the formatted string
 * @return 1
 */
stock SystemMsgFormat(playerid,msg[],param) {
   if ((IsPlayerConnected(playerid))&&(strlen(msg)>0)) {
		new tmp[MAX_STRING];
		format(tmp,MAX_STRING,msg,param);
		SendClientMessage(playerid,COLOR_SYSTEM,tmp);
   }
   return 1;
}

/*
 * Send a formated system msg to the player
 * @param playerid int ID of the player
 * @param msg string Message to sent
 * @param param string StringValue to put into the formatted string
 * @return 1
 */
stock SystemMsgFormatStr(playerid,msg[],param[]) {
   if ((IsPlayerConnected(playerid))&&(strlen(msg)>0)) {
		new tmp[MAX_STRING];
		format(tmp,MAX_STRING,msg,param);
		SendClientMessage(playerid,COLOR_SYSTEM,tmp);
   }
   return 1;
}

/*
 * Send a formated system msg to the player
 * @param playerid int ID of the player
 * @param msg string Message to sent
 * @param param float FloatValue to put into the formatted string
 * @return 1
 */
stock SystemMsgFormatFloat(playerid,msg[],Float:param) {
   if ((IsPlayerConnected(playerid))&&(strlen(msg)>0)) {
		new tmp[MAX_STRING];
		format(tmp,MAX_STRING,msg,param);
		SendClientMessage(playerid,COLOR_SYSTEM,tmp);
   }
   return 1;
}

/*
 * Send a system msg to all players
 * @param msg string Message to sent
 * @return 1
 */
stock SystemMsgAll(msg[]) {
   for (new i=0;i<MAX_PLAYERS;i++) {
     SystemMsg(i,msg);
   }
   return 1;
}

/*
 * Send a bad system msg to a player
 * @param playerid int ID of the player
 * @param msg string Message to sent
 * @return 1
 */
stock BadSystemMsg(playerid,msg[]) {
   if ((IsPlayerConnected(playerid))&&(strlen(msg)>0)) {
	   SendClientMessage(playerid,COLOR_BADSYSTEM,msg);
   }
   return 1;
}

/*
 * Send a formated bad system msg to a player
 * @param playerid int ID of the player
 * @param msg string Message to sent
 * @return 1
 */
stock BadSystemMsgFormat(playerid,msg[],param) {
   if ((IsPlayerConnected(playerid))&&(strlen(msg)>0)) {
		new tmp[MAX_STRING];
		format(tmp,MAX_STRING,msg,param);
		SendClientMessage(playerid,COLOR_BADSYSTEM,tmp);
   }
   return 1;
}

/*
 * Send a formated bad system msg to a player
 * @param playerid int ID of the player
 * @param msg string Message to sent
 * @return 1
 */
stock BadSystemMsgFormatStr(playerid,msg[],param[]) {
   if ((IsPlayerConnected(playerid))&&(strlen(msg)>0)) {
		new tmp[MAX_STRING];
		format(tmp,MAX_STRING,msg,param);
		SendClientMessage(playerid,COLOR_BADSYSTEM,tmp);
   }
   return 1;
}

/*
 * Kicks player and sends formated message to the player first
 * @param playerid int ID of the player
 * @param moderator_id int ID of the moderator
 * @param reason string Reason for kick. Visible for the player.
 */
stock KickPlayer(playerid,moderator_id,reason[]) {
#pragma unused moderator_id
	BadSystemMsgFormatStr(playerid,gettext(playerid,DSYSTEM_YOU_HAVE_BEEN_KICKED),reason);
	Kick(playerid);
}
/*
 * Bans player and sends formated message to the player first
 * @param playerid int ID of the player
 * @param moderator_id int ID of the moderator
 * @param time int lenght of the ban
 * @param reason string Reason for ban. Visible for the player.
 */
stock BanPlayer(playerid,moderator_id,time,reason[]) {
#pragma unused moderator_id
#pragma unused time
	BadSystemMsgFormatStr(playerid,gettext(playerid,DSYSTEM_YOU_HAVE_BEEN_BANNED),reason);
	Ban(playerid);
}

