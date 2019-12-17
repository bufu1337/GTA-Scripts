#include <a_samp>

#pragma tabsize 0

/*This is my Second release of SFPD gates, this version includes:
Proper SFPD shutter
Actually rotating striped gate :D
Removed "OnPlayerRequestClass" I dont know why it was there in the 1st place...
*/

//DO NOT RELEASE THIS AS YOUR OWN!!!

new SFPDshutter;
new SFPDgate;

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("Mike's SFPD gates 2");
	print("--------------------------------------\n");
	SFPDshutter = CreateObject(10184, -1631.78, 688.24, 8.68, 0.00, 0.00, 90.00);
 	SFPDgate = CreateObject(971, -1571.80, 661.16, 6.08, 0.00, 360.00, 90.00);
	return 1;
}

public OnFilterScriptExit()
{
	print("\n--------------------------------------");
	print("Mike's SFPD gates 2 - Unloaded!");
	print("--------------------------------------\n");
	DestroyObject(SFPDshutter);
	DestroyObject(SFPDgate); //Gates will dissapear on unload.
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
			if (strcmp("/openshutter", cmdtext, true) == 0)
	{
	if(IsPlayerAdmin(playerid)) //At the minute the commands are RCON, an easy way to disable is change "IsPlayerAdmin" to "IsPlayerConnected".
	{
	MoveObject(SFPDshutter,-1631.78, 688.24, 13.68, 1.3);
	new string[256];
	new name[128];
	GetPlayerName(playerid,name,128);
	format(string, sizeof(string), "%s has opened the SFPD shutter!",name);
	SendClientMessageToAll(0x0AFF0AAA, string);
		}
		else
		{
   		return SendClientMessage(playerid,0xFF0000AA,"/openshutter is an RCON command."); //If not RCON
		}
		GameTextForPlayer(playerid, "~G~shutter open!", 3000, 5);
		return 1;
	}

	 			if (strcmp("/closeshutter", cmdtext, true) == 0)
	{
	if(IsPlayerAdmin(playerid)) //At the minute the commands are RCON, an easy way to disable is change "IsPlayerAdmin" to "IsPlayerConnected".
	{
	MoveObject(SFPDshutter,-1631.78, 688.24, 8.68, 1.3);
 		new string[256];
		new name[128];
		GetPlayerName(playerid,name,128);
		format(string, sizeof(string), "%s has closed the SFPD shutter!",name);
		SendClientMessageToAll(0xFF0000AA, string);
		}
		else
		{
   		return SendClientMessage(playerid,0xFF0000AA,"/closeshutter is an RCON command."); //If not RCON
		}
		GameTextForPlayer(playerid, "~r~shutter closed!", 3000, 5);
		return 1;
	}

		 			if (strcmp("/stopshutter", cmdtext, true) == 0)
	{
	if(IsPlayerAdmin(playerid)) //At the minute the commands are RCON, an easy way to disable is change "IsPlayerAdmin" to "IsPlayerConnected".
	{
	StopObject(SFPDshutter);
		new string[256];
		new name[128];
		GetPlayerName(playerid,name,128);
		format(string, sizeof(string), "%s has stopped the SFPD shutter!",name);
		SendClientMessageToAll(0xFF0000AA, string);
		}
		else
		{
   		return SendClientMessage(playerid,0xFF0000AA,"/stopshutter is an RCON command."); //If not RCON
		}
		GameTextForPlayer(playerid, "~r~shutter stopped!", 3000, 5);
		return 1;
	}
	
				if (strcmp("/opengate", cmdtext, true) == 0)
	{
	if(IsPlayerAdmin(playerid)) //At the minute the commands are RCON, an easy way to disable is change "IsPlayerAdmin" to "IsPlayerConnected".
	{
	MoveObject(SFPDgate,-1571.80, 654.16, 6.08, 1.1);
	new string[256];
	new name[128];
	GetPlayerName(playerid,name,128);
	format(string, sizeof(string), "%s has opened the SFPD gate!",name);
	SendClientMessageToAll(0x0AFF0AAA, string);
		}
		else
		{
   		return SendClientMessage(playerid,0xFF0000AA,"/opengate is an RCON command."); //If not RCON
		}
		GameTextForPlayer(playerid, "~G~gate opening...", 3000, 5);
		return 1;
	}
					if (strcmp("/closegate", cmdtext, true) == 0)
	{
	if(IsPlayerAdmin(playerid)) //At the minute the commands are RCON, an easy way to disable is change "IsPlayerAdmin" to "IsPlayerConnected".
	{
 	MoveObject(SFPDgate,-1571.80, 661.16, 6.08, 1.0);
	new string[256];
	new name[128];
	GetPlayerName(playerid,name,128);
	format(string, sizeof(string), "%s has closed the SFPD gate!",name);
	SendClientMessageToAll(0xFF0000AA, string);
		}
		else
		{
   		return SendClientMessage(playerid,0xFF0000AA,"/closegate is an RCON command."); //If not RCON
		}
		GameTextForPlayer(playerid, "~r~gate closing...", 3000, 5);
		return 1;
	}
	
			 			if (strcmp("/stopgate", cmdtext, true) == 0)
	{
	if(IsPlayerAdmin(playerid)) //At the minute the commands are RCON, an easy way to disable is change "IsPlayerAdmin" to "IsPlayerConnected".
	{
	StopObject(SFPDgate);
		new string[256];
		new name[128];
		GetPlayerName(playerid,name,128);
		format(string, sizeof(string), "%s has stopped the SFPD gate!",name);
		SendClientMessageToAll(0xFF0000AA, string);
		}
		else
		{
   		return SendClientMessage(playerid,0xFF0000AA,"/stopgate is an RCON command."); //If not RCON
		}
		GameTextForPlayer(playerid, "~r~gate stopped!", 3000, 5);
		return 1;
	}

	//Teleport
		if (strcmp("//SFPD", cmdtext, true) == 0)
	{
		SetPlayerPos(playerid,-1608.7108,717.6257,12.5503);
		SetPlayerInterior(playerid, 0);
		SendClientMessage(playerid, 0x33AA33AA,"Teleported outside the SFPD.");
		return 1;
	}
	
	return 0;
}
//THE END
