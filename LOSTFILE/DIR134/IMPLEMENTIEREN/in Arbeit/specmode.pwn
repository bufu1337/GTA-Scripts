/*---------------------------------------------
		SPECTATOR MODE  V4.4
	    BY TESTAKROSS,
		(still some bugs)  Last updated: 8/12/2006
-----------------------------------------------
*/


#include <a_samp>

//	colors
#define COLOR_SYSTEM 0xEFEFF7AA
#define COLOR_YELLOW 0xFFFF00AA

// --------------------------------------
// CONFIGURATION BOX---------------------

#define CAM_REFRESH_RATE 500 // Spectator Camera Refresh Rate (in Ms) It is recommended that you don't use this under 300(pings ;) ).
#define CAM_ZOOM1 6 // Zoom 1 - close
#define CAM_ZOOM2 9 // Zoom 2 - medium
#define CAM_ZOOM3 15 // Zoom 3 - High

// --------------------------------------

new camplayerid;
new zoom;
new PlayerWatching[MAX_PLAYERS] = 0;


//---------------------------MAIN----------------------------------
public OnPlayerConnect(playerid)
{
    PlayerWatching[playerid] = 0;
    return 1;
}


public OnPlayerCommandText(playerid, cmdtext[]) {

new string[256];
new cmd[256];
new name[MAX_PLAYER_NAME];
new camname[MAX_PLAYER_NAME];
new idx;
GetPlayerName(playerid, name, sizeof(name));

cmd = strtok(cmdtext, idx);


//-----------------------------
if (strcmp(cmdtext, "/camhelp", true)==0)
{
		SendClientMessage(playerid, COLOR_YELLOW, "Type /cam [playerid] [zoom] to watch a connected player.");
		SendClientMessage(playerid, COLOR_YELLOW, "zoom types are from 1 to 3. 1 = Close | 2 = Medium | 3 = High");
		SendClientMessage(playerid, COLOR_SYSTEM, "Type /camstop to stop cam-watching a player"); // Please do not change/delete this line :p
		return 1;
}

//-----------------------------
if (strcmp(cmdtext, "/camstop", true)==0)
{
        if (PlayerWatching[playerid] == 1) {
		PlayerWatching[playerid] = 0;
		TogglePlayerControllable(playerid,1);
		SetCameraBehindPlayer(playerid);
		GameTextForPlayer(playerid,"~g~spectator mode ~r~off",4000,6);
		SetPlayerHealth(playerid, 0);
		}
		else {
		SendClientMessage(playerid, COLOR_YELLOW, "You must be be in spectator mode to use this!");
		}
		return 1;
}


//-----------------------------
if (strcmp(cmd, "/cam", true)==0)
{
		new tmp[256];

		// The command...
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_SYSTEM, "USAGE: /cam [playerid] [zoom (1-3)]");
			return 1;
		}
		camplayerid = strval(tmp);

        tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_SYSTEM, "USAGE: /cam [playerid] [zoom (1-3)]");
			return 1;
		}
		zoom = strval(tmp);

		// Spectator...
		if (IsPlayerConnected(camplayerid) && camplayerid != playerid) {

            new Float: x,Float: y,Float: z;
            GetPlayerName(camplayerid, camname, sizeof(camname));

			if (zoom == 1) {
			SetPlayerCameraPos(playerid,x+CAM_ZOOM1,y+CAM_ZOOM1,z+CAM_ZOOM1);
			SetPlayerCameraLookAt(playerid,x,y,z);
			}

			// -----
			if (zoom == 2) {
			SetPlayerCameraPos(playerid,x+CAM_ZOOM2,y+CAM_ZOOM2,z+CAM_ZOOM2);
			SetPlayerCameraLookAt(playerid,x,y,z);
			}

			// -----
			if (zoom == 3) {
			SetPlayerCameraPos(playerid,x+CAM_ZOOM3,y+CAM_ZOOM3,z+CAM_ZOOM3);
			SetPlayerCameraLookAt(playerid,x,y,z);
			}

            if (zoom == 3 || zoom == 2 || zoom == 1) {
			SetTimer("CamRefresh",CAM_REFRESH_RATE,1);
 			PlayerWatching[playerid] = 1;

			// Spectation info texts
			format(string, sizeof(string), "You are now watching player %s (id: %d).", camname ,camplayerid);
			SendClientMessage(playerid,COLOR_YELLOW, string);
            format(string, sizeof(string), "~g~spectator mode~n~~r~viewing:~w~ %s.", camname);
			GameTextForPlayer(playerid,string,4000,6);

			//put the spectator in safe place
			TogglePlayerControllable(playerid,0);
			SetPlayerPos(playerid,0,0,400);


			}
		 return 1;
		}
		else if(!IsPlayerConnected(camplayerid)) {
			format(string, sizeof(string), "%d is not an active player.", camplayerid);
			SendClientMessage(playerid,COLOR_YELLOW, string);
			}
		else if(camplayerid == playerid) {
			SendClientMessage(playerid,COLOR_YELLOW, "You can not spectate yourself!");
			}
		return 1;
	}
	return 0;
}


public OnPlayerDisconnect(playerid)
{
	if (PlayerWatching[playerid] == 1) {
    PlayerWatching[playerid] = 0;
    }
    return 1;
}

public CamRefresh(playerid)
{

	for(new i=0; i<MAX_PLAYERS; i++)
	{
	if (IsPlayerConnected(camplayerid) && PlayerWatching[i] == 1) {
    	new Float:x, Float:y, Float:z;
   		GetPlayerPos(camplayerid,x,y,z);
   		SetPlayerPos(i,x-18,y+18,z+45);
   		SetPlayerColor(i,0x0000FF00);
			if (zoom == 1) {
			SetPlayerCameraPos(i,x+CAM_ZOOM1,y+CAM_ZOOM1,z+CAM_ZOOM1);
			SetPlayerCameraLookAt(i,x,y,z);
			}
			if (zoom == 2) {
			SetPlayerCameraPos(i,x+CAM_ZOOM2,y+CAM_ZOOM2,z+CAM_ZOOM2);
			SetPlayerCameraLookAt(i,x,y,z);
			}
			if (zoom == 3) {
			SetPlayerCameraPos(i,x+CAM_ZOOM3,y+CAM_ZOOM3,z+CAM_ZOOM3);
			SetPlayerCameraLookAt(i,x,y,z);
			}
		}
		else if (!IsPlayerConnected(camplayerid)) {
		SendClientMessage(i,COLOR_YELLOW, "The player you were watching has left the server.");
		PlayerWatching[playerid] = 0;
		TogglePlayerControllable(playerid,1);
		SetCameraBehindPlayer(playerid);
		GameTextForPlayer(playerid,"~g~spectator mode ~r~off",4000,6);
		SetPlayerHealth(playerid, 0);
		}
	}
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

