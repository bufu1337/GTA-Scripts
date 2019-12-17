//==============================================================================

// Player Voice changing system  - created by Haji/Saeko

//   Version: 0.1 Date: 2010-10-16, 19:15.


//==============================================================================
#define FILTERSCRIPT

#include <a_samp>

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------------------");
	print(" Player Voice changing system  - Created by Haji/Saeko");
	print("----------------------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

//------------------------------------------------------------------------------
#else
#endif
//-----------------------------------------------------------------------------

public OnPlayerConnect(playerid)
{
    SetPVarString(playerid,"Speaking","calm voice");

	return 1;
}


public OnPlayerText(playerid, text[])
{
   	new msg[128],speak[12];
	GetPVarString(playerid, "Speaking", speak, 12);
	format(msg, sizeof(msg), "[%s] %s",speak, text);
	for(new player=0; player<MAX_PLAYERS; player++)
	{
  	if(IsPlayerConnected(player))
 	SendPlayerMessageToPlayer(player, playerid, msg);
	}
	return 0;
}



public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/talk", cmdtext, true, 10) == 0)
	{
	    ShowPlayerDialog(playerid, 1, DIALOG_STYLE_LIST, "Choose your speaking style", "Loud\nQuietly\nShout\nWhisper", "Choose", "Exit");
		return 1;
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
if(dialogid == 1)
{
if(response)
{
if(listitem == 0)
{
SetPVarString(playerid,"Speaking", "loud");
}
else if(listitem == 1)
{
SetPVarString(playerid,"Speaking", "quietly");
}
else if(listitem == 2)
{
SetPVarString(playerid,"Speaking", "shouts");
}

else if(listitem == 3)
{
SetPVarString(playerid,"Speaking", "whispers");
}
}
return 1;
}

return 1;
}

//===================================================================================

//And remember, even if you change credits, you won't be creator of the gamemode. : )

//==================================================================================
