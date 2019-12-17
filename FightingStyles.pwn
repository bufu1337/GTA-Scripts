#include <a_samp>
#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
public OnPlayerCommandText(playerid, cmdtext[]){dcmd(fightstyle, 12, cmdtext);return 0;}
dcmd_fightstyle(playerid, params[]) {
#pragma unused params
ShowPlayerDialog(playerid, 111111, DIALOG_STYLE_LIST, "Fighting Style's","FIGHT_STYLE_NORMAL\nFIGHT_STYLE_BOXING\nFIGHT_STYLE_KUNGFU\nFIGHT_STYLE_KNEEHEAD\nFIGHT_STYLE_GRABKICK\nFIGHT_STYLE_ELBOW", "Select", "Cancel");return 1;}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 111111 && response)
	{
		switch(listitem)
		{
   			case 0: SetPlayerFightingStyle (playerid, FIGHT_STYLE_NORMAL);
   			case 1: SetPlayerFightingStyle (playerid, FIGHT_STYLE_BOXING);
			case 2: SetPlayerFightingStyle (playerid, FIGHT_STYLE_KUNGFU);
			case 3: SetPlayerFightingStyle (playerid, FIGHT_STYLE_KNEEHEAD);
			case 4: SetPlayerFightingStyle (playerid, FIGHT_STYLE_GRABKICK);
			case 5: SetPlayerFightingStyle (playerid, FIGHT_STYLE_ELBOW);
		}
		return 1;
	}
	return 0;
}
