#include <a_samp>

//SEATBELT! by [K4L]Jacob
//This script is released under the GNU/GPL licensing standards.
//Credit to Seif for creating the original collision code.

#define COLOR_CORAL 0xFF7F50AA
#define COLOR_GREEN 0x33AA33AA


new Seatbelt[MAX_PLAYERS];
new TimerStack;
new Float:VehicleHealthStack[700][3];
new tmp[128];
forward IsABike(vehicleid);
forward VehicleDamageToPlayerHealth(playerid, vehicleid);
forward VehicleDamageToPlayerHealth2(playerid, vehicleid);
forward DisablePlayerKnockout(playerid);
forward IsACopSkin(playerid);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);


public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		return 1;
	}
	return 0;
}

ReturnUser(string[])
{
    new IsNumerical=1;
    new tmpstring[MAX_PLAYER_NAME];
    for(new cell; cell < strlen(string); cell++) if((string[cell]<='0') || (string[cell]>='9'))IsNumerical=0;
    if(IsNumerical)return strval(string);
    else
    {
        for(new players; players < MAX_PLAYERS; players++)
        {
            GetPlayerName(players,tmpstring,sizeof(tmpstring));
            if(strfind(tmpstring,string,true)>-1)return players;
        }
    }
    return INVALID_PLAYER_ID;
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
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(ispassenger == 0)
	{
 		SetTimerEx("VehicleDamageToPlayerHealth",200,1,"ii",playerid, vehicleid);
		return 1;
	}
	else
	{
 		SetTimerEx("VehicleDamageToPlayerHealth2",200,1,"ii",playerid, vehicleid);
 		return 1;
	}
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	Seatbelt[playerid] = 0;
	return 1;
}

public VehicleDamageToPlayerHealth2(playerid, vehicleid)
{
   	if (IsPlayerInVehicle(playerid,vehicleid))
	{
		if(Seatbelt[playerid] == 1)
		{
  			GetVehicleHealth(vehicleid, VehicleHealthStack[vehicleid][0]);
   			if (floatcmp(VehicleHealthStack[vehicleid][0], VehicleHealthStack[vehicleid][1]) == -1)
    		{
    	       	GetPlayerHealth(playerid, VehicleHealthStack[vehicleid][2]);
    	       	SetPlayerHealth(playerid, floatsub(VehicleHealthStack[vehicleid][2], 6));
    	       	if(GetPlayerHealth(playerid) >= 1)
				{
				    SendClientMessage(playerid,COLOR_CORAL,"You are shook up from the collision.");
				    SendClientMessage(playerid,COLOR_CORAL,"Luckily, you were wearing your seatbelt.");
				}
				else
				{
				    SendClientMessage(playerid,COLOR_CORAL,"Your stamina was in bad condition and the force of the collision knocked you out.");
					GameTextForPlayer(playerid,"~r~Out ~w~cold",4000,1);
				}
    		}
    	   	VehicleHealthStack[vehicleid][1] = VehicleHealthStack[vehicleid][0];
    	   	return 1;
   		}
		else
		{
			GetVehicleHealth(vehicleid, VehicleHealthStack[vehicleid][0]);
   			if (floatcmp(VehicleHealthStack[vehicleid][0], VehicleHealthStack[vehicleid][1]) == -1)
    		{
    	       	GetPlayerHealth(playerid, VehicleHealthStack[vehicleid][2]);
    	       	SetPlayerHealth(playerid, floatsub(VehicleHealthStack[vehicleid][2], 45));
    	       	if(GetPlayerHealth(playerid) >= 1)
				{
				    SendClientMessage(playerid,COLOR_CORAL,"You are shook up from the collision.");
				    SendClientMessage(playerid,COLOR_CORAL,"You were not wearing your seatbelt and you were fatally injured.");
				}
				else
				{
				    SendClientMessage(playerid,COLOR_CORAL,"Your stamina was in bad condition and the force of the collision knocked you out.");
					GameTextForPlayer(playerid,"~r~Out ~w~cold",4000,1);
				}
    		}
    	   	VehicleHealthStack[vehicleid][1] = VehicleHealthStack[vehicleid][0];
    	   	return 1;
		}
	}
	return 1;
}

public VehicleDamageToPlayerHealth(playerid, vehicleid)
{
   	if (IsPlayerInVehicle(playerid,vehicleid))
	{
		if(Seatbelt[playerid] == 1)
		{
  			GetVehicleHealth(vehicleid, VehicleHealthStack[vehicleid][0]);
   			if (floatcmp(VehicleHealthStack[vehicleid][0], VehicleHealthStack[vehicleid][1]) == -1)
    		{
    	       	GetPlayerHealth(playerid, VehicleHealthStack[vehicleid][2]);
    	       	SetPlayerHealth(playerid, floatsub(VehicleHealthStack[vehicleid][2], 6));
    	       	if(GetPlayerHealth(playerid) >= 1)
				{
				    SendClientMessage(playerid,COLOR_CORAL,"You are shook up from the collision.");
				    SendClientMessage(playerid,COLOR_CORAL,"Luckily, you were wearing your seatbelt and may continue driving.");
				}
				else
				{
				    SendClientMessage(playerid,COLOR_CORAL,"Your stamina was in bad condition and the force of the collision knocked you out.");
					GameTextForPlayer(playerid,"~r~Out ~w~cold",4000,1);
				}
    		}
    	   	VehicleHealthStack[vehicleid][1] = VehicleHealthStack[vehicleid][0];
    	   	return 1;
   		}
		else
		{
			GetVehicleHealth(vehicleid, VehicleHealthStack[vehicleid][0]);
   			if (floatcmp(VehicleHealthStack[vehicleid][0], VehicleHealthStack[vehicleid][1]) == -1)
    		{
    	       	GetPlayerHealth(playerid, VehicleHealthStack[vehicleid][2]);
    	       	SetPlayerHealth(playerid, floatsub(VehicleHealthStack[vehicleid][2], 45));
    	       	if(GetPlayerHealth(playerid) >= 1)
				{
				    SendClientMessage(playerid,COLOR_CORAL,"You are shook up from the collision.");
				    SendClientMessage(playerid,COLOR_CORAL,"You can not continue driving, as you are frozen from shock. Buckle up, next time.");
					TogglePlayerControllable(playerid, 0);
					TimerStack = SetTimerEx("DisablePlayerKnockout",3500,1,"i",playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_CORAL,"Your stamina was in bad condition and the force of the collision knocked you out.");
					GameTextForPlayer(playerid,"~r~Out ~w~cold",4000,1);
				}
    		}
    	   	VehicleHealthStack[vehicleid][1] = VehicleHealthStack[vehicleid][0];
    	   	return 1;
		}
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new string[128];
	new vehicleid = GetPlayerVehicleID(playerid);
	new giveplayerid;
	if (strcmp("/seatbelt", cmdtext, true, 9) == 0 || strcmp("/helmet", cmdtext, true, 7) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && Seatbelt[playerid] == 0)
		{
		    if(IsABike(vehicleid))
		    {
		        Seatbelt[playerid] = 1;
		        SendClientMessage(playerid, COLOR_GREEN, "You have put on a bike helmet. This will supress the impact of a crash.");
		        return 1;
			}
			else
			{
			    Seatbelt[playerid] = 1;
			    SendClientMessage(playerid, COLOR_GREEN, "You have put on your seatbelt. This will supress the impact of a crash.");
				return 1;
			}
		}
		if(IsPlayerInAnyVehicle(playerid) && Seatbelt[playerid] == 1)
		{
		    if(IsABike(vehicleid))
		    {
		        Seatbelt[playerid] = 0;
		        SendClientMessage(playerid, COLOR_GREEN, "You have taken off your helmet. You will no longer be protected from crashes");
				return 1;
			}
			else
			{
			    Seatbelt[playerid] = 0;
			    SendClientMessage(playerid, COLOR_GREEN, "You have taken off your seatbelt. You will no longer be protected from crashes.");
				return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_CORAL, "You are not in a car/bike, therefore you can not put on a seatbelt or helmet");
		    return 1;
		}
	}
	
	if (strcmp("/checkseatbelt", cmdtext, true, 9) == 0)
	{
	    new idx;
		tmp = strtok(cmdtext, idx);
	   	if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_CORAL, "USAGE: /checkseatbelt [playerid]");
			return 1;
		}
		giveplayerid = ReturnUser(tmp);
		if(IsACopSkin(playerid))
		{
			if(IsPlayerConnected(giveplayerid))
			{
		    	if(giveplayerid != INVALID_PLAYER_ID)
				{
					new Float:x, Float:y, Float:z;
					new PlayerName[24];
					GetPlayerPos(giveplayerid, x, y, z);
					GetPlayerName(giveplayerid, PlayerName, 24);
					if(PlayerToPoint(6.0, playerid, x, y, z) && Seatbelt[giveplayerid] == 1)
					{
						format(string, sizeof(string), "%s is wearing their seatbelt", PlayerName);
					    SendClientMessage(playerid, COLOR_GREEN, string);
					    return 1;
					}
					else if(PlayerToPoint(6.0, playerid, x, y, z) && Seatbelt[giveplayerid] == 0)
					{
						format(string, sizeof(string), "%s is not wearing their seatbelt", PlayerName);
						SendClientMessage(playerid, COLOR_GREEN, string);
						return 1;
					}
					else
					{
					    SendClientMessage(playerid, COLOR_CORAL, "You are not near that player");
						return 1;
					}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_CORAL, "The ID you have entered does not exist");
			    return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_CORAL, "You are not a cop");
		    return 1;
		}
		}
	}
	return 0;
}


public DisablePlayerKnockout(playerid)
{
	TogglePlayerControllable(playerid, 1);
	SendClientMessage(playerid, COLOR_GREEN, "You have recovered from the shock. You can drive again.");
	KillTimer(TimerStack);
	return 1;
}
	
public IsABike(vehicleid)
{   new model = GetVehicleModel(vehicleid);
	if(model == 581 || model == 509 || model == 481 || model == 462 || model == 521 || model == 463 || model == 510 || model == 522 || model == 461 || model == 448 || model == 471 || model == 468 || model == 586)
	{
		return 1;
	}
	return 0;
}

public IsACopSkin(playerid)
{
	if(GetPlayerSkin(playerid) == 280 || GetPlayerSkin(playerid) == 281 || GetPlayerSkin(playerid) == 282 || GetPlayerSkin(playerid) == 283 || GetPlayerSkin(playerid) == 288 || GetPlayerSkin(playerid) == 284 || GetPlayerSkin(playerid) == 285 || GetPlayerSkin(playerid) == 286 || GetPlayerSkin(playerid) == 287)
	{
		return 1;
	}
	return 0;
}
