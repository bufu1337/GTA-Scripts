/********************************************************
 Roleplay name checker by FusiouS
 Version: 1.0, Release 1
 SA-MP Version: 0.3c
 Credits: FusiouS
*******************************************************

					Features:
		- Checks if playername is on Firstname_Lastname format
		- If Playername is not on same format, server will kick player, informing that player got wrong typed nickname.


				How to install & use:

	1) Download package and place .pwn file to your filterscripts folder
	2) Compile .pwn file to .amx and write to your server.cfg behind filterscripts: namecheck
	3) Start your server. Filterscript kicks all people which name is not on correct RP-name format.


TERMS OF USE:
- You are free to modify this script for your OWN use.
- DO NOT remove credits
- DO NOT Re-release this as your own work
*/

#include <a_samp>
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_PINK 0xFF66FFAA

new othermarks[] =
{
	'[', ']'
};

new alphabetic[] =
{
	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
	'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
};

new bool: Huge;

public OnPlayerConnect(playerid)
{
	new string[128], pName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
	if(IsPlayerNPC(playerid))
	{
	    return 1;
 	}
	if(strfind(pName, "_", true) == -1)
	{
        SendClientMessage(playerid, COLOR_YELLOW, "You have been kicked from the server. Reason: Invalid Roleplay name");
	    format(string, 128, "SERVER KICK: %s has been kicked from the server. Reason: Invalid roleplay name (example: John_Dalton)", pName);
        SendClientMessageToAll(0xFF66FFAA, string);
		Kick(playerid);
	    return 1;
		} else {
		for(new i; i <= strlen(pName); i++)
		{
		    for(new j; j <= 9; j++)
		    {
		        if(pName[i] == j)
		        {
	                SendClientMessage(playerid, COLOR_YELLOW, "You have been kicked from the server. Reason: Invalid Roleplay name");
					format(string, 128, "SERVER KICK: %s has been kicked from the server. Reason: Invalid roleplay name (example: John_Dalton)", pName);
				    SendClientMessageToAll(0xFF66FFAA, string);
				    Kick(playerid);
				    return 1;
		        }
		    }
		    for(new j; j <= sizeof(othermarks); j++)
		    {
			    if(pName[i] == othermarks[j])
			    {
                    SendClientMessage(playerid, COLOR_YELLOW, "You have been kicked from the server. Reason: Invalid Roleplay name");
				    format(string, 128, "SERVER KICK: %s has been kicked from the server. Reason: Invalid roleplay name (example: John_Dalton)", pName);
				    SendClientMessageToAll(0xFF66FFAA, string);
				    Kick(playerid);
				    return 1;
			    }
			}
			if(i >= 1)
			{
			    if(Huge == true)
			    {
			        Huge = false;
			        continue;
			    }
			    if(pName[i] == '_')
			    {
			        Huge = true;
			        continue;
				}
			    for(new j; j <= sizeof(alphabetic); j++)
			    {
			        if(pName[i] == alphabetic[j])
			        {
                        SendClientMessage(playerid, COLOR_YELLOW, "You have been kicked from the server. Reason: Invalid Roleplay name");
					    format(string, 128, "SERVER KICK: %s has been kicked from the server. Reason: Change your name! FirstName_LastName", pName);
					    SendClientMessageToAll(0xFF66FFAA, string);
					    Kick(playerid);
					    return 1;
			        }
			    }
			}
		}
	}
	return 1;
}
