/**
 *            DFairPlay - ServerSide 0.2.2
 *       (c) Copyright 2009 by DracoBlue
 *
 * @author    : DracoBlue (http://dracoblue.com)
 * @date      : 5th April 2009
 * @update    : 12th May 2009
 *
 * This file is provided as is (no warranties).
 *
 * By accessing the dfairplay-query-servers, 
 * you agree to the DFairPlay-Server Terms of
 * Service.
 *
 * It's released under the terms of MIT.
 *
 * Feel free to use it, a little message in
 * about box is honouring thing, isn't it?
 */
#include <a_samp>
#include <pwncurl>

#pragma dynamic 640000
#define DFAIRPLAY_SERVERSIDE_VERSION "0.2.2"
#define DFAIRPLAY_QUERY_SERVER "http://dfairplay-query.webdevberlin.com/"

#if !defined DF_DEBUG
#define DF_DEBUG 0
#endif

#pragma unused df_server_timer

#define DF_MAX_STRING 512

new df_server_timer;
new dfairplay_query_string[DF_MAX_STRING];
new DF_PLAYER_IP[MAX_PLAYERS];

new DF_PLAYER_HAS_DFP[MAX_PLAYERS];

new df_token[12];

new df_time_since_last_token_call = 0;

forward DFairPlayerServerTimer();

/**
 *  Returns an element of a string splitted by ' ', default index is 0.
 *  @param   string
 *           index
 */
stock DF_strtok(const string[], &index,seperator=' ')
{
	new length = strlen(string);
	new offset = index;
	new result[116];
	while ((index < length) && (string[index] != seperator) && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}

	result[index - offset] = EOS;
	if ((index < length) && (string[index] == seperator))
	{
		index++;
	}
	return result;
}


stock DF_callDFFuncRAW(funcname[], params[])
{
#if DF_DEBUG
	printf("--->Calling--->");
#endif
	format(dfairplay_query_string, DF_MAX_STRING, "%s%s/%s",DFAIRPLAY_QUERY_SERVER,funcname,params);
#if DF_DEBUG
	printf("\r\n%s",dfairplay_query_string);
#endif
	new ret_val[DF_MAX_STRING];
	pwncurl_get(dfairplay_query_string, ret_val, DF_MAX_STRING);
#if DF_DEBUG
	printf("\r\n%s",ret_val);
#endif
	return ret_val;
}

stock DF_callDFFuncWithToken(funcname[], params[])
{
#if DF_DEBUG
	printf("--->Calling (with token)--->");
#endif
	format(dfairplay_query_string, DF_MAX_STRING, "%s%s/%s/%s",DFAIRPLAY_QUERY_SERVER,funcname,df_token, params);
#if DF_DEBUG
	printf("\r\n%s",dfairplay_query_string);
#endif
	new ret_val[DF_MAX_STRING];
	pwncurl_get(dfairplay_query_string, ret_val, DF_MAX_STRING);
#if DF_DEBUG
	printf("\r\n%s",ret_val);
#endif
	df_time_since_last_token_call = 0;
	return ret_val;
}

/**
 * Returns if the user has any incidents registered at dfairplay.
 * @return int
 */
stock DF_hasIncidents(playerid)
{
	new str[32];
	format(str,16,"gtasa-samp/%s",DF_PLAYER_IP[playerid]);
	return strval(DF_callDFFuncRAW("has_incidents",str));
}

/**
 * Returns if the dfairplay query server is alive!
 * @return int
 */
stock DF_isAlive()
{
	return strval(DF_callDFFuncRAW("is_alive",""));
}

/**
 * Returns all player_ids on the server, which have incidents.
 * @return str[]
 */
stock DF_getIncidents()
{
	return DF_callDFFuncWithToken("get_incidents","");
}

/**
 * Refresh our session
 * @return str[]
 */
stock DF_ping()
{
	return strval(DF_callDFFuncWithToken("ping",""));
}


/**
 * Adds a user to the server, returns if the user has DFP activated.
 * @return int
 */
stock DF_addUser(playerid)
{
	new str[20];
	format(str, 20, "%d/%s",playerid,DF_PLAYER_IP[playerid]);
	return strval(DF_callDFFuncWithToken("add_user",str)) == 1 ? 1 : 0;
}

/**
 * Adds a user to the server
 * @return int
 */
stock DF_deleteUser(playerid)
{
	new str[20];
	format(str, 20, "%d",playerid);
	DF_PLAYER_HAS_DFP[playerid] = 0;
	return strval(DF_callDFFuncWithToken("delete_user",str));
}


/**
 * This function _must_ be implemented and called, by the filterscript!
 */
DF_OnFilterScriptInit() {
	printf("   | DracoBlue's DFairPlay ServerSide ");
	printf("   |   Version : %s",DFAIRPLAY_SERVERSIDE_VERSION);
	printf("   | ");
	format(df_token,12,"%s",DF_callDFFuncRAW("create_session","gtasa-samp"));
	df_time_since_last_token_call = 0;
	printf("		SessionToken: %s", df_token);
	printf("   `                                   ... started!");
	printf(" ");
    df_server_timer=SetTimer("DFairPlayerServerTimer",60000,1);
	return 1;
}

DF_OnFilterScriptExit() {
	DF_callDFFuncWithToken("destroy_session","");
	return 1;
}

/**
 * This function _must_ be implemented and called, by the filterscript!
 */
DF_OnPlayerConnect(playerid) {
	GetPlayerIp(playerid,DF_PLAYER_IP[playerid],16);
	DF_PLAYER_HAS_DFP[playerid] = DF_addUser(playerid);
    return 1;
}

/**
 * This function _must_ be implemented and called, by the filterscript!
 */
DF_OnPlayerDisconnect(playerid, reason) {
	#pragma unused reason
	DF_deleteUser(playerid);
    return 1;
}

stock DF_checkAndPunishPlayers()
{
	new str[DF_MAX_STRING];
	format(str,512,"%s",DF_callDFFuncWithToken("get_incidents",""));
#if DF_DEBUG
	printf("DF_punishPlayers %s",str);
#endif
	if (strlen(str)>0)
	{
#if DF_DEBUG
		printf("have to punish players! %s",str);
#endif
		new index;
		new player_id_str[3];
		new playerid = -1;
		new done_yet = 0;
		while (!done_yet)
		{
			format(player_id_str,3,"%s",DF_strtok(str, index, ','));
			done_yet = (strlen(player_id_str) == 0);
			if (!done_yet)
			{
				playerid = strval(player_id_str);
				if (IsPlayerConnected(playerid))
				{
#if DF_DEBUG
					printf("We have to kick %d, yay ;).",playerid);
#endif					
					onPlayerHasIncident(playerid);
				}
				else
				{
#if DF_DEBUG
					printf("Had to delete a user, which was still registered for DF but not online!");
#endif					
					DF_deleteUser(playerid);
				}
			}
		}
	}
}

stock getDFairPlayServerVersion()
{
	new str[DF_MAX_STRING];
	format(str, DF_MAX_STRING, "%s", DFAIRPLAY_SERVERSIDE_VERSION);
	return str;
}


stock hasPlayerDFairPlay(playerid)
{
	if (IsPlayerConnected(playerid))
	{
		return (DF_PLAYER_HAS_DFP[playerid]==0) ? false : true;
	}
	return false;
}

public DFairPlayerServerTimer()
{
	df_time_since_last_token_call += 5;
	new i;
	new players_on = 0;
	for (i=0; i<MAX_PLAYERS;i++)
	{
		if (IsPlayerConnected(i))
		{
			players_on++;
		}
	}
	if (players_on!=0)
	{
		DF_checkAndPunishPlayers();
	}
	
	if (df_time_since_last_token_call > 180)
	{
		// just refresh our session ;)
		DF_ping();
	}
}
