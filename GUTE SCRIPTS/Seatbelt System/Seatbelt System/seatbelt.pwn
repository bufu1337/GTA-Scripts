/*==========================================[[--Made by AcId N rApId A.K.A Jason A.K.A XnightX--]]==========================================
============================================================================================================================================
											||||||||||||||||||||**CREDITS**||||||||||||||||||||||||
											||Fallout for his, "Player Damage On Car Damage" code||
											|||||||||||||||||||||||||||||||||||||||||||||||||||||||
============================================================================================================================================
											       NOTICE: DO NOT REMOVE THE CREDITS
============================================================================================================================================
*/
#include <a_samp>
#include <a_players>

#define MAX_STRING 255
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GREY 0xAFAFAFAA

forward ProxDetector(Float:radi, playerid, str[],col1,col2,col3,col4,col5);
forward OnPlayerUpdate(playerid);

new Seatbelt[MAX_PLAYERS];
new gPlayerLogged[MAX_PLAYERS];
new Float:CarHealth[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("     Roleplay Seatbelt System loaded by Jason AKA AcId n RaPiD...");
}

public OnFilterScriptExit()
{
	print("     Roleplay Seatbelt System unloaded by Jason AKA AcId N rApId..."); // DO NOT REMOVE THIS
}

public OnPlayerConnect(playerid)
{
    gPlayerLogged[playerid] = 0;
	Seatbelt[playerid] = 0;
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

public ProxDetector(Float:radi, playerid, str[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
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
				if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
				{
					SendClientMessage(i, col1, str);
				}
				else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
				{
					SendClientMessage(i, col2, str);
				}
				else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
				{
					SendClientMessage(i, col3, str);
				}
				else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
				{
					SendClientMessage(i, col4, str);
				}
				else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
				{
					SendClientMessage(i, col5, str);
				}
			}
		}
	}//not connected
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    new string[256];
    new sendername[MAX_PLAYER_NAME];
    new cmd[256];
    new idx;
    cmd = strtok(cmdtext, idx);

	if(strcmp(cmd, "/seatbelt", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result) && IsPlayerInAnyVehicle(playerid) == 0)
			{ //line 124
				SendClientMessage(playerid, COLOR_GRAD2, "You need to be in a vehicle in order to use /seatbelt.");
				return 1;
			}
		    if(IsPlayerInAnyVehicle(playerid) == 1 && Seatbelt[playerid] == 0)
			{
			    Seatbelt[playerid] = 1;
			    SendClientMessage(playerid, COLOR_WHITE, "You have put on a seatbelt.");
			    format(string, sizeof(string), "* %s reaches for the seatbelt, and buckles it up.", sendername);
			}
			else if(IsPlayerInAnyVehicle(playerid) == 1 && Seatbelt[playerid] == 1)
			{
				Seatbelt[playerid] = 0;
				SendClientMessage(playerid, COLOR_WHITE, "You have taken off your seatbelt");
				format(string, sizeof(string), "* %s extends his arm unbuckling his seatbelt.", sendername);
			}
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			printf("%s", string);
		}
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    SendClientMessage(playerid, COLOR_LIGHTRED, "Click it or ticket! Type /seatbelt to wear it.");
 	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    new string[256];
    new sendername[MAX_PLAYER_NAME];

	if(IsPlayerInAnyVehicle(playerid) == 1 && Seatbelt[playerid] == 1)
	{
        GetPlayerName(playerid, sendername, sizeof(sendername));
		Seatbelt[playerid] = 0;
		SendClientMessage(playerid, COLOR_WHITE, "You have taken off your seatbelt");
		format(string, sizeof(string), "* %s extends his arm unbuckling his seatbelt.", sendername);
	}
 	else if(IsPlayerInAnyVehicle(playerid) == 1 && Seatbelt[playerid] == 0)
	{
 	Seatbelt[playerid] = 0;
 	return 1;
	}
	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	printf("%s", string);
	return 1;
}

//	if (IsPlayerInAnyVehicle(playerid) == 1 && Seatbelt[playerid] == 1)
//   Seatbelt[playerid] = 0;

//-------------Using FALLOUTS Players Damage on Car Damage - Rest by Jason A.K.A. AcId N rApId----------------
public OnPlayerUpdate(playerid)
{
	if(IsPlayerInAnyVehicle(playerid) == 1 && Seatbelt[playerid] == 0)
	{
		new Float:TempCarHealth;
		GetVehicleHealth(GetPlayerVehicleID(playerid), TempCarHealth);
		new Float:Difference = floatsub(CarHealth[playerid], TempCarHealth);
		if((floatcmp(CarHealth[playerid], TempCarHealth) == 1) && (floatcmp(Difference,100.0) == 1))
		{
		    Difference = floatdiv(Difference, 10.0);
		    new Float:OldHealth;
		    GetPlayerHealth(playerid, OldHealth);
		    SetPlayerHealth(playerid, floatsub(OldHealth, Difference));
		}
		CarHealth[playerid] = TempCarHealth;
	}
	else
	{
		CarHealth[playerid] = 0.0; //To aviod that a player dies when he enters a vehicle
	}
    return 1;
}
