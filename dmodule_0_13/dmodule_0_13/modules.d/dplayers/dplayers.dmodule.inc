/*
 *            DPlayers functions 1.1
 *       (c) Copyright 2007 by DracoBlue
 *
 * @author    : DracoBlue (http://dracoblue.com)
 * @date      : 11th Dec 2007
 *
 * This file is provided as is (no warranties).
 *
 * Feel free to use it, a little message in
 * about box is honouring thing, isn't it?
 *
 */

/**
 * Returns the name of the player
 * @param int playerid ID of the player
 * @ingroup player
 * @return string
 */
stock PlayerName(playerid) {
	new name[MAX_STRING];
	if (IsPlayerConnected(playerid))
		GetPlayerName(playerid, name, MAX_STRING);
	else
		name[0]=0;
	return name;
}

/**
 * Returns the name of the player without his tag
 * @param int playerid ID of the player
 * @ingroup player
 * @return string
 */
stock PlayerNameEx(playerid) {
	new name[MAX_STRING];
	if (IsPlayerConnected(playerid)) {
		GetPlayerName(playerid, name, MAX_STRING);
		if (name[0]=='[') {
			// check if the player has tag
	    	new findit;
	    	findit = strfind(name,"]");
	    	if (findit>1 && findit!=strlen(name)-1) {
				// ok, he has a tag, lets strip it down.
				new withouttag[MAX_STRING];
				findit++;
				for (new i=findit;i<strlen(name);i++) {
				withouttag[i-findit]=name[i];
				}
				return withouttag;
	    	}
		}
	} else
		name[0]=0;
	return name;
}

/**
 * Return if player has a clan-tag
 * @param int playerid ID of the player
 * @ingroup player
 * @return boolean
 * @see PlayerTag
 */
stock PlayerHasTag(playerid) {
	new playername[MAX_STRING];
	format(playername,MAX_STRING,"%s",PlayerName(playerid));
	if (strlen(playername)==0) return false;
	if (playername[0]=='[') {
    	new findit;
    	findit = strfind(playername,"]");
    	if (findit>1 && findit!=strlen(playername)-1) {
    		return true;
    	}
	}
	return false;
}


/**
 * Return the clan-tag of a player
 * @param int playerid ID of the player
 * @ingroup player
 * @return string
 * @see PlayerHasTag
 */
stock PlayerTag(playerid) {
	new tag[MAX_STRING];
	tag[0]=0;
	new playername[MAX_STRING];
	format(playername,MAX_STRING,"%s",PlayerName(playerid));
	
	if (playername[0]=='[') {
		new findit;
		findit = strfind(playername,"]",false,0);
		if ((findit>1)&&(findit!=(strlen(playername)-1))) {
			for (new i=1;i<findit;i++) {
				tag[i-1]=playername[i];
			}
  		}
	}
	return tag;
}

/**
 * Return the ID of a player via autocomplete
 * (-1 if player not found, -2 if multiple autocomplete options)
 * @param string partofname Part of the name
 * @param bool withoutclantag Set if the clantag should be ignored
 * @ingroup player
 * @return int
 * @see PlayerHasTag
 * @see PlayerTag
 */
stock PlayerID(partofname[],withoutclantag=true) {
	if (strlen(partofname)==0) return -1;
	new i;
	new correctsigns_userid=-1; // set to INVALID_PLAYERS
	new resultcount=0;
	if (withoutclantag) {
		for (i=0;i<MAX_PLAYERS;i++) {
			if (IsPlayerConnected(i)) {
				if (strcmp(PlayerNameEx(i),partofname,true)==0) {
					return i;
				}
			}
		}
	
		// If we are _here_ it wasn't exact name. 
	
		// autocomplete 
		for (i=0;i<MAX_PLAYERS;i++) {
			if (IsPlayerConnected(i)) {
				if (strfind(PlayerNameEx(i),partofname,true)==0) {
					resultcount++;
					correctsigns_userid=i;
				}
				if (resultcount>1) {
					return -2; // return MULTIPLE_PLAYERID
				}
			}
	    }
	} else {
		for (i=0;i<MAX_PLAYERS;i++) {
			if (IsPlayerConnected(i)) {
				if (strcmp(PlayerName(i),partofname,true)==0) {
					return i;
				}
			}
		}
	
		// If we are _here_ it wasn't exact name. 
	
		// autocomplete 
		for (i=0;i<MAX_PLAYERS;i++) {
			if (IsPlayerConnected(i)) {
				if (strfind(PlayerName(i),partofname,true)==0) {
					resultcount++;
					correctsigns_userid=i;
				}
				if (resultcount>1) {
					return -2; // return MULTIPLE_PLAYERID
				}
			}
	    }
	}
	return correctsigns_userid;
}

/**
 * Return the health of a player
 * @param int playerid ID of the player
 * @ingroup player
 * @return int
 */
stock PlayerHealth(playerid){
	return Val(PlayerHealth,playerid);
}

/**
 * Return the armor of a player
 * @param int playerid ID of the player
 * @ingroup player
 * @return int
 */
stock PlayerArmor(playerid){
	new Float:armor;
	GetPlayerArmour(playerid,armor);
	return floatround(armor);
}
