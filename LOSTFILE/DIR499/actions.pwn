//-------------------------------------------------
//
//  Creating commands set set player's specials
//  actions.
//  kyeman 2007
//
//-------------------------------------------------

#pragma tabsize 0
#include <a_samp>
#include <core>
#include <float>

//-------------------------------------------------

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

//-------------------------------------------------

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new idx;
	new dancestyle;
	cmd = strtok(cmdtext, idx);
	
	// HANDSUP
 	if(strcmp(cmd, "/handsup", true) == 0) {
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
  	  		return 1;
		}
	}

	// SUICIDE COMMAND
 	if(strcmp(cmd, "/kill", true) == 0) {
	    SetPlayerHealth(playerid,0.0);
  	  	return 1;
	}
	
	// START DANCING
 	if(strcmp(cmd, "/dance", true) == 0) {
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    new tmp[256];
		    
		    // Get the dance style param
      		tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid,0xFF0000FF,"Usage: /dance [style 1-3]");
				return 1;
			}
			
			dancestyle = strval(tmp);
			if(dancestyle < 1 || dancestyle > 3) {
			    SendClientMessage(playerid,0xFF0000FF,"Usage: /dance [style 1-3]");
			    return 1;
			}
			
			if(dancestyle == 1) {
			    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
			} else if(dancestyle == 2) {
			    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
			} else if(dancestyle == 3) {
			    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
			}
 	  		return 1;
		}
	}

	return 0;
}

//-------------------------------------------------
// EOF


