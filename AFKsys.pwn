/*
# Scripted by Mike
# Thanks Lj for indentation
*/

/* ===[INCLUDES]=== */
#include <a_samp>

/* ===[DEFINES]=== */
#define yellow 0xFFFF00AA
#define red 0xFF0000AA

/* ===[VARIABLES]=== */
new isafk[MAX_PLAYERS];
new afktag[MAX_PLAYERS];

/* ===[CALLBACKS]=== */
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("Mikes AFK Filterscript");
	print("--------------------------------------\n");
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/afk", cmdtext, true) == 0)
	{
		if(isafk[playerid] == 0) // if the array called "isafk" is 0 for the player, then
		{
			isafk[playerid] = 1;
			TogglePlayerControllable(playerid,false);
			SetCameraBehindPlayer(playerid);
			new string[256];
			new name[128];
			GetPlayerName(playerid,name,128);
			format(string, sizeof(string), "%s is now AFK",name);
			new setname[16];
			format(setname, sizeof(setname), "%s[AFK]",name);
			if(!strlen(name[11]))
			{
				afktag[playerid] = 1;
				SetPlayerName(playerid,setname);
			}
			SendClientMessageToAll(yellow, string);
			SendClientMessage(playerid, yellow, "Type /BACK when you are back!");
		}
		else //if it is not 0, then:
		{
			return SendClientMessage(playerid,red,"You are already AFK!");
		}
		return 1; //return value
	}
	
	if (strcmp("/back", cmdtext, true) == 0)
	{
		if(isafk[playerid] == 1) // if the array called "isafk" is 1 for the player, then
		{
			isafk[playerid] = 0;
			TogglePlayerControllable(playerid,true);
			SetCameraBehindPlayer(playerid);
			new string[128];
			new name[16];
			GetPlayerName(playerid,name,16);
			new pname[16];
			GetPlayerName(playerid,pname,16);
			strdel(pname, strlen(pname)-5, strlen(pname));
			if(afktag[playerid] == 1)
			{
				afktag[playerid] = 0;
				SetPlayerName(playerid,pname);
			}
			new name2[16];
			GetPlayerName(playerid,name2,16);
			format(string, sizeof(string), "%s is now BACK",name2);
			SendClientMessageToAll(yellow, string);
			SendClientMessage(playerid, yellow, "Type /AFK to go AFK again!");
		}
		else //if it is not 1, then:
		{
			return SendClientMessage(playerid,red,"You are not AFK!");
		}
		return 1; //return value
	}
	return 0;
}
