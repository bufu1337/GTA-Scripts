// This is a comment
// uncomment the line below if you want to write a filterscript
#define FILTERSCRIPT

#include <a_samp>
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_WHITE 0xFFFFFFAA
#pragma tabsize 0
#define TOUR_SHAKE 500
new ShakeOffer[MAX_PLAYERS];

stock warpmsg(playerid, col, string[])
{
    new end1[256], end2[256], end3[256];
	if(strlen(string) > 90)
	{
		format(end1, sizeof(end1), string);
		format(end2, sizeof(end2), string);
		strdel(end1, 90, 256);
		strdel(end2, 0, 90);
		format(end3, sizeof(end3), "%s ...", end1);
		SendClientMessage(playerid, col, end3);
		format(end3, sizeof(end3), "... %s", end2);
		SendClientMessage(playerid, col, end3);
	}
	else
	{
	    SendClientMessage(playerid, col, string);
	}
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


public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}






public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new tmp[256];
	new cmd[256];
	new idx;
	cmd = strtok(cmdtext, idx);
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];
	new number[256];

    if(strcmp(cmd,"/shake",true)==0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /shake [playerid/PartOfName]");
				return 1;
			}
			new giveplayerid;
			giveplayerid = strval(tmp);
			if (IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			       if (ProxDetectorS(8.0, playerid, giveplayerid))
					   {
					       if(giveplayerid == playerid)
					       {
					            SendClientMessage(playerid, COLOR_GREY, "   You can't handshake yourself");
					            return 1;
					       }
					       new string[256];
					       GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						   GetPlayerName(playerid, sendername, sizeof(sendername));
					       format(string, sizeof(string), "* You offered %s a handshake .", giveplayer);
						   SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						   format(string, sizeof(string), "* %s is offering you a handshake, (type /accept shake[1-7]).", sendername);
						   SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
						   ShakeOffer[giveplayerid] = playerid;
					    }
					    else
					    {
					            SendClientMessage(playerid, COLOR_GREY, "   That player is not near you!");
					    }
				 }
    		}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "   Invalid ID/Name!");
			    return 1;
			}
	    }
		return 1;
	}
	
 	if(strcmp(cmd,"/accept",true)==0)
	{
	
	number = strtok(cmdtext, idx);

	if(!strlen(number)) {
	SendClientMessage(playerid, COLOR_WHITE, "USAGE: /accept [name]");
	SendClientMessage(playerid, COLOR_GREY, "Available names: Shake(1-7)");
	return 1;
	}
if(strcmp(number,"shake",true) == 0)
{
 	if(ShakeOffer[playerid] < TOUR_SHAKE)
	{
 		if(IsPlayerConnected(ShakeOffer[playerid]))
   		{
   		new string[256];
		GetPlayerName(ShakeOffer[playerid], giveplayer, sizeof(giveplayer));
     	GetPlayerName(playerid, sendername, sizeof(sendername));
       format(string, sizeof(string), "* You have accepted the handshake.");
       SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
       format(string, sizeof(string), "* %s has accepted your handshake offer.",sendername);
       ApplyAnimation(playerid,"GANGS","hndshkfa_swt",4.0,0,0,0,0,0);
       ApplyAnimation(ShakeOffer[playerid],"GANGS","hndshkfa_swt",4.0,0,0,0,0,0);
       SendClientMessage(ShakeOffer[playerid], COLOR_LIGHTBLUE, string);
       ShakeOffer[playerid] = TOUR_SHAKE;
       	return 1;
        }
        	else
	        {
         SendClientMessage(playerid, COLOR_GREY, "   No-one has offered a handshake...");
         return 1;
         }
         }
        	}
        			else if(strcmp(number,"shake1",true) == 0)
			{
			    if(ShakeOffer[playerid] < TOUR_SHAKE)
			    {
			        if(IsPlayerConnected(ShakeOffer[playerid]))
			        {
			            new string[256];
                        GetPlayerName(ShakeOffer[playerid], giveplayer, sizeof(giveplayer));
			            GetPlayerName(playerid, sendername, sizeof(sendername));
                        format(string, sizeof(string), "* You have accepted the handshake.");
		            	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			            format(string, sizeof(string), "* %s has accepted your handshake offer.",sendername);
			            ApplyAnimation(playerid,"GANGS","hndshkaa",4.0,0,0,0,0,0);
			            ApplyAnimation(ShakeOffer[playerid],"GANGS","hndshkaa",4.0,0,0,0,0,0);
			            SendClientMessage(ShakeOffer[playerid], COLOR_LIGHTBLUE, string);
                        ShakeOffer[playerid] = TOUR_SHAKE;
                        return 1;
                    }
			        else
			        {
                        SendClientMessage(playerid, COLOR_GREY, "   No-one has offered a handshake...");
                        return 1;
                        }
                    }
          	}
			else if(strcmp(number,"shake2",true) == 0)
			{
			    if(ShakeOffer[playerid] < TOUR_SHAKE)
			    {
			        if(IsPlayerConnected(ShakeOffer[playerid]))
			        {
			            new string[256];
                        GetPlayerName(ShakeOffer[playerid], giveplayer, sizeof(giveplayer));
			            GetPlayerName(playerid, sendername, sizeof(sendername));
                        format(string, sizeof(string), "* You have accepted the handshake.");
		            	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			            format(string, sizeof(string), "* %s has accepted your handshake offer.",sendername);
			            ApplyAnimation(playerid,"GANGS","hndshkba",4.0,0,0,0,0,0);
			            ApplyAnimation(ShakeOffer[playerid],"GANGS","hndshkba",4.0,0,0,0,0,0);
			            SendClientMessage(ShakeOffer[playerid], COLOR_LIGHTBLUE, string);
                        ShakeOffer[playerid] = TOUR_SHAKE;
                        return 1;
                    }
			        else
			        {
                        SendClientMessage(playerid, COLOR_GREY, "   No-one has offered a handshake...");
                        return 1;
                        }
                    }
          	}
			else if(strcmp(number,"shake3",true) == 0)
			{
			    if(ShakeOffer[playerid] < TOUR_SHAKE)
			    {
			        if(IsPlayerConnected(ShakeOffer[playerid]))
			        {
  			            new string[256];
                        GetPlayerName(ShakeOffer[playerid], giveplayer, sizeof(giveplayer));
			            GetPlayerName(playerid, sendername, sizeof(sendername));
                        format(string, sizeof(string), "* You have accepted the handshake.");
		            	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			            format(string, sizeof(string), "* %s has accepted your handshake offer.",sendername);
			            ApplyAnimation(playerid,"GANGS","hndshkca",4.0,0,0,0,0,0);
			            ApplyAnimation(ShakeOffer[playerid],"GANGS","hndshkca",4.0,0,0,0,0,0);
			            SendClientMessage(ShakeOffer[playerid], COLOR_LIGHTBLUE, string);
                        ShakeOffer[playerid] = TOUR_SHAKE;
                        return 1;
                    }
			        else
			        {
                        SendClientMessage(playerid, COLOR_GREY, "   No-one has offered a handshake...");
                        return 1;
                        }
                    }
          	}
			else if(strcmp(number,"shake4",true) == 0)
			{
			    if(ShakeOffer[playerid] < TOUR_SHAKE)
			    {
			        if(IsPlayerConnected(ShakeOffer[playerid]))
			        {
  			            new string[256];
                        GetPlayerName(ShakeOffer[playerid], giveplayer, sizeof(giveplayer));
			            GetPlayerName(playerid, sendername, sizeof(sendername));
                        format(string, sizeof(string), "* You have accepted the handshake.");
		            	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			            format(string, sizeof(string), "* %s has accepted your handshake offer.",sendername);
			            ApplyAnimation(playerid,"GANGS","hndshkcb",4.0,0,0,0,0,0);
			            ApplyAnimation(ShakeOffer[playerid],"GANGS","hndshkcb",4.0,0,0,0,0,0);
			            SendClientMessage(ShakeOffer[playerid], COLOR_LIGHTBLUE, string);
                        ShakeOffer[playerid] = TOUR_SHAKE;
                        return 1;
                    }
			        else
			        {
                        SendClientMessage(playerid, COLOR_GREY, "   No-one has offered a handshake...");
                        return 1;
                        }
                    }
          	}
			else if(strcmp(number,"shake5",true) == 0)
			{
			    if(ShakeOffer[playerid] < TOUR_SHAKE)
			    {
			        if(IsPlayerConnected(ShakeOffer[playerid]))
			        {
  			            new string[256];
                        GetPlayerName(ShakeOffer[playerid], giveplayer, sizeof(giveplayer));
			            GetPlayerName(playerid, sendername, sizeof(sendername));
                        format(string, sizeof(string), "* You have accepted the handshake.");
		            	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			            format(string, sizeof(string), "* %s has accepted your handshake offer.",sendername);
			            ApplyAnimation(playerid,"GANGS","hndshkda",4.0,0,0,0,0,0);
			            ApplyAnimation(ShakeOffer[playerid],"GANGS","hndshkda",4.0,0,0,0,0,0);
			            SendClientMessage(ShakeOffer[playerid], COLOR_LIGHTBLUE, string);
                        ShakeOffer[playerid] = TOUR_SHAKE;
                        return 1;
                    }
			        else
			        {
                        SendClientMessage(playerid, COLOR_GREY, "   No-one has offered a handshake...");
                        return 1;
                        }
                    }
          	}
			else if(strcmp(number,"shake6",true) == 0)
			{
			    if(ShakeOffer[playerid] < TOUR_SHAKE)
			    {
			        if(IsPlayerConnected(ShakeOffer[playerid]))
			        {
  			            new string[256];
                        GetPlayerName(ShakeOffer[playerid], giveplayer, sizeof(giveplayer));
			            GetPlayerName(playerid, sendername, sizeof(sendername));
                        format(string, sizeof(string), "* You have accepted the handshake.");
		            	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			            format(string, sizeof(string), "* %s has accepted your handshake offer.",sendername);
			            ApplyAnimation(playerid,"GANGS","hndshkea",4.0,0,0,0,0,0);
			            ApplyAnimation(ShakeOffer[playerid],"GANGS","hndshkea",4.0,0,0,0,0,0);
			            SendClientMessage(ShakeOffer[playerid], COLOR_LIGHTBLUE, string);
                        ShakeOffer[playerid] = TOUR_SHAKE;
                        return 1;
                    }
			        else
			        {
                        SendClientMessage(playerid, COLOR_GREY, "   No-one has offered a handshake...");
                        return 1;
                        }
                    }
          	}
			else if(strcmp(number,"shake7",true) == 0)
			{
			    if(ShakeOffer[playerid] < TOUR_SHAKE)
			    {
			        if(IsPlayerConnected(ShakeOffer[playerid]))
			        {
  			            new string[256];
                        GetPlayerName(ShakeOffer[playerid], giveplayer, sizeof(giveplayer));
			            GetPlayerName(playerid, sendername, sizeof(sendername));
                        format(string, sizeof(string), "* You have accepted the handshake.");
		            	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			            format(string, sizeof(string), "* %s has accepted your handshake offer.",sendername);
			            ApplyAnimation(playerid,"GANGS","hndshkfa",4.0,0,0,0,0,0);
			            ApplyAnimation(ShakeOffer[playerid],"GANGS","hndshkfa",4.0,0,0,0,0,0);
			            SendClientMessage(ShakeOffer[playerid], COLOR_LIGHTBLUE, string);
                        ShakeOffer[playerid] = TOUR_SHAKE;
                        return 1;
                    }
			        else
			        {
                        SendClientMessage(playerid, COLOR_GREY, "   No-one has offered a handshake...");
                        return 1;
                        }
                    }
                    }
          	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}


forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);
public ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		new VW = GetPlayerVirtualWorld(playerid);
		//radi = 2.0; //Trigger Radius
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);
					//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
					if (((GetPlayerVirtualWorld(i)==VW && tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
					warpmsg(i, col1,string);
					}
					else if (((GetPlayerVirtualWorld(i)==VW && tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
								warpmsg(i, col2,string);

					}
					else if (((GetPlayerVirtualWorld(i)==VW && tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
							warpmsg(i, col3,string);

					}
					else if (((GetPlayerVirtualWorld(i)==VW && tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
							warpmsg(i, col4,string);

					}
					else if (((GetPlayerVirtualWorld(i)==VW && tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
					warpmsg(i, col5,string);

					}
			}
		}
	}//not connected
	return 1;
}

forward ProxDetectorS(Float:radi, playerid, targetid);
public ProxDetectorS(Float:radi, playerid, targetid)
{
	//if (gdebug >= 3){//printf("DEBUG ProxDetectorS()");}
	new Float:posx, Float:posy, Float:posz;
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	//radi = 2.0; //Trigger Radius
	GetPlayerPos(targetid, posx, posy, posz);
	tempposx = (oldposx -posx);
	tempposy = (oldposy -posy);
	tempposz = (oldposz -posz);
	////printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		return 1;
	}
	return 0;
}
