//-------------------------------------------------
//
//  Creating commands set set player's specials
//  actions.
//  kyeman 2007
//  Invisible put new animations in it
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
 	if(strcmp(cmd, "/surrender", true) == 0) {
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		  SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
          return 1;
     }
	}
    // Drunk
    if(strcmp(cmd, "/drunk", true) == 0) {
        if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
     {
          ApplyAnimation(playerid,"PED", "WALK_DRUNK",4.0,0,1,0,0,0);
          SendClientMessage(playerid, 0xFF0000FF, "You are now walking like a drunk man"); // Walk Drunk
          return 1;
     }
    }
	// Place a Bomb
    if (strcmp("/bomb", cmdtext, true) == 0) {
	      ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // Place Bomb
          SendClientMessage(playerid, 0xFF0000FF, "You are planting a bomb");
		  return 1;
	}
	// Police Arrest
    if (strcmp("/arrest", cmdtext, true, 7) == 0) {
	      ApplyAnimation( playerid,"ped", "ARRESTgun", 4.0, 0, 0, 0, 0, 0); // Gun Arrest
          SendClientMessage(playerid, 0xFF0000FF, "You are arresting someone with your gun");
		  return 1;
    }
	// Laugh
    if (strcmp("/laugh", cmdtext, true) == 0) {
          ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0, 0); // Laugh
          SendClientMessage(playerid, 0xFF0000FF, "You are laughing");
		  return 1;
	}
	// Rob Lookout
    if (strcmp("/lookout", cmdtext, true) == 0) {
          ApplyAnimation(playerid, "SHOP", "ROB_Shifty", 4.0, 0, 0, 0, 0, 0); // Rob Lookout
          SendClientMessage(playerid, 0xFF0000FF, "You are looking out for cops");
		  return 1;
	}
	// Rob Threat
    if (strcmp("/rob", cmdtext, true) == 0) {
          ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 0, 0, 0, 0, 0); // Rob
          SendClientMessage(playerid, 0xFF0000FF, "You are robbing the place");
		  return 1;
	}
	// Wank Out
    if (strcmp("/wankin", cmdtext, true) == 0) {
          ApplyAnimation(playerid, "PAULNMAC", "wank_loop", 4.0, 0, 0, 0, 0, 0); // Wank In
          SendClientMessage(playerid, 0xFF0000FF, "You are wanking");
		  return 1;
 	}
	// Police Arrest
    if (strcmp("/coparrest", cmdtext, true) == 0) {
	      ApplyAnimation(playerid, "POLICE", "plc_drgbst_01", 4.0, 0, 0, 0, 0, 0); // Arrest
          SendClientMessage(playerid, 0xFF0000FF, "You are arresting someone");
		  return 1;
	}
    // Wank In
    if (strcmp("/wankout", cmdtext, true) == 0) {
          ApplyAnimation(playerid, "PAULNMAC", "wank_out", 4.0, 0, 0, 0, 0, 0); // Wank Out
          SendClientMessage(playerid, 0xFF0000FF, "You are wanking out");
		  return 1;
	}
	// Arrested
    if (strcmp("/arrested", cmdtext, true) == 0) {
          ApplyAnimation(playerid, "POLICE", "crm_drgbst_01", 4.0, 0, 0, 0, 0, 0); // Arrested
          SendClientMessage(playerid, 0xFF0000FF, "You are getting arrested");
		  return 1;
	}
	// Injury
    if (strcmp("/injured", cmdtext, true) == 0) {
          ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.0, 0, 0, 0, 0, 0); // Injured
          SendClientMessage(playerid, 0xFF0000FF, "You are injured");
		  return 1;
	}
	// Ass Slapped
    if (strcmp("/slapped", cmdtext, true) == 0) {
          ApplyAnimation(playerid, "SWEET", "ho_ass_slapped", 4.0, 0, 0, 0, 0, 0); // Ass Slapped
          SendClientMessage(playerid, 0xFF0000FF, "You are getting slapped");
		  return 1;
	}
	// Female Smoking
    if (strcmp("/fsmoking", cmdtext, true) == 0) {
          ApplyAnimation(playerid, "SMOKING", "F_smklean_loop", 4.0, 0, 0, 0, 0, 0); // Female Smoking
          SendClientMessage(playerid, 0xFF0000FF, "You are smoking");
		  return 1;
	}
	// Cop Look
    if (strcmp("/coplook", cmdtext, true) == 0) {
          ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 0, 0, 0, 0); // Cop Looking
          SendClientMessage(playerid, 0xFF0000FF, "You are looking");
		  return 1;
	}
	// Lay Down
    if (strcmp("/lay", cmdtext, true, 6) == 0) {
          ApplyAnimation(playerid,"BEACH", "bather", 4.0, 0, 0, 0, 0, 0); // Lay down
          SendClientMessage(playerid, 0xFF0000FF, "You are laying down");
		  return 1;
    }
	// Take Cover
    if (strcmp("/cover", cmdtext, true, 3) == 0) {
          ApplyAnimation(playerid, "ped", "cower", 3.0, 0, 0, 0, 0, 0); // Taking Cover
          SendClientMessage(playerid, 0xFF0000FF, "You are taking cover");
		  return 1;
	}
	// Vomit
    if (strcmp("/vomit", cmdtext, true) == 0) {
	      ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0); // Vomit BAH!
          SendClientMessage(playerid, 0xFF0000FF, "You are puking :S");
		  return 1;
	}
	// Eat Burger
    if (strcmp("/eat", cmdtext, true) == 0) {
	      ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.00, 0, 0, 0, 0, 0); // Eat Burger
          SendClientMessage(playerid, 0xFF0000FF, "You are eating a burger");
		  return 1;
	}
	// Wave
    if (strcmp("/wave", cmdtext, true) == 0) {
	      ApplyAnimation(playerid, "KISSING", "BD_GF_Wave", 3.0, 0, 0, 0, 0, 0); // Wave
          SendClientMessage(playerid, 0xFF0000FF, "You are waving");
		  return 1;
	}
	// Slap Ass
    if (strcmp("/slapass", cmdtext, true) == 0) {
          ApplyAnimation(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0); // Ass Slapping
          SendClientMessage(playerid, 0xFF0000FF, "You are slapping someone's ass");
		  return 1;
	}
	// Death Crawling
    if (strcmp("/death", cmdtext, true) == 0) {
          ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.0, 0, 0, 0, 0, 0); // Dead Crawling
          SendClientMessage(playerid, 0xFF0000FF, "You are crawling dead");
		  return 1;
    }
	// Dealer
    if (strcmp("/deal", cmdtext, true) == 0) {
          ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0); // Deal Drugs
          SendClientMessage(playerid, 0xFF0000FF, "You are drug dealing");
		  return 1;
	}
	// Kiss
    if (strcmp("/kiss", cmdtext, true, 5) == 0) {
          ApplyAnimation(playerid, "KISSING", "Playa_Kiss_02", 3.0, 0, 0, 0, 0, 0); // Kiss
          SendClientMessage(playerid, 0xFF0000FF, "You are kissing someone");
		  return 1;
	}
	// Crack Dieing
    if (strcmp("/crack", cmdtext, true, 6) == 0) {
          ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 0, 0, 0, 0, 0); // Dieing of Crack
          SendClientMessage(playerid, 0xFF0000FF, "You are trippin");
		  return 1;
	}
	// Piss
    if (strcmp("/piss", cmdtext, true, 8) == 0) {
          ApplyAnimation(playerid, "PAULNMAC", "Piss_in", 3.0, 0, 0, 0, 0, 0); // Pissing
          SendClientMessage(playerid, 0xFF0000FF, "You are pissing");
		  return 1;
	}
	// Male Smoking
    if (strcmp("/smoke", cmdtext, true, 4) == 0) {
          ApplyAnimation(playerid,"SMOKING", "M_smklean_loop", 4.0, 0, 0, 0, 0, 0); // Smoke
          SendClientMessage(playerid, 0xFF0000FF, "You are smoking");
		  return 1;
	}
	// Sit
    if (strcmp("/sit", cmdtext, true, 4) == 0) {
          ApplyAnimation(playerid,"BEACH", "ParkSit_M_loop", 4.0, 0, 0, 0, 0, 0); // Sit
          SendClientMessage(playerid, 0xFF0000FF, "You are sitting down");
		  return 1;
    }
	// Fuck U
    if (strcmp("/fu", cmdtext, true, 2) == 0) {
	      ApplyAnimation( playerid,"ped", "fucku", 4.1, 0, 1, 1, 1, 1 ); // Wave fist / Pull fingers (with block hands)
          SendClientMessage(playerid, 0xFF0000FF, "You are now pulling your fingers up");
		  return 1;
    }
	// Strip-Tease
    if (strcmp("/strip", cmdtext, true, 6) == 0)
    {
    switch (cmdtext[7])
    {
        case 'a', 'A':{ ApplyAnimation( playerid,"STRIP", "strip_A", 4.1, 0, 1, 1, 1, 1 ); return 1; } // Strip
        case 'b', 'B':{ ApplyAnimation( playerid,"STRIP", "strip_B", 4.1, 0, 1, 1, 1, 1 ); return 1; } // Strip
        case 'c', 'C':{ ApplyAnimation( playerid,"STRIP", "strip_C", 4.1, 0, 1, 1, 1, 1 ); return 1; } // Strip
        case 'd', 'D':{ ApplyAnimation( playerid,"STRIP", "strip_D", 4.1, 0, 1, 1, 1, 1 ); return 1; } // Strip
        case 'e', 'E':{ ApplyAnimation( playerid,"STRIP", "strip_E", 4.1, 0, 1, 1, 1, 1 ); return 1; } // Strip
        case 'f', 'F':{ ApplyAnimation( playerid,"STRIP", "strip_F", 4.1, 0, 1, 1, 1, 1 ); return 1; } // Strip
        case 'g', 'G':{ ApplyAnimation( playerid,"STRIP", "strip_G", 4.1, 0, 1, 1, 1, 1 ); return 1; } // Strip
    }   SendClientMessage(playerid, 0xFF0000FF, "You are now stripping you pervert");
    return 1;
    }
    // Idle Chat
    if(strcmp(cmd, "/chat", true) == 0)
{
     if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
     {
         ApplyAnimation(playerid,"PED","IDLE_CHAT",4.1,0,1,1,1,1);
         SendClientMessage(playerid, 0xFF0000FF, "You are now talking"); // Chat
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
