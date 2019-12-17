#include <a_samp>

#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

new bool:lmec[MAX_PLAYERS];


public OnPlayerCommandText(playerid, cmdtext[])
{
	dcmd(mec, 3, cmdtext);
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 009)
	{
		if(response == 1)
		{
		    switch(listitem)
		    {
		        case 0:
		        {
		            SetPlayerAttachedObject(playerid, 0, 18649, 6, 0.07000, 0.03000, 0.80000, 90.000000, 0.000000, 0.000000, 1.3, 0.7, 2.3);
				    lmec[playerid] = true;
					GivePlayerWeapon(playerid, 8, 1);
		        }
		        case 1:
		        {
		            SetPlayerAttachedObject(playerid, 0, 18650, 6, 0.07000, 0.03000, 0.80000, 90.000000, 0.000000, 0.000000, 1.3, 0.7, 2.3);
				    lmec[playerid] = true;
					GivePlayerWeapon(playerid, 8, 1);
		        }
		        case 2:
		        {
		            SetPlayerAttachedObject(playerid, 0, 18648, 6, 0.07000, 0.03000, 0.80000, 90.000000, 0.000000, 0.000000, 1.3, 0.7, 2.3);
				    lmec[playerid] = true;
					GivePlayerWeapon(playerid, 8, 1);
		        }
		        case 3:
		        {
		            SetPlayerAttachedObject(playerid, 0, 18647, 6, 0.07000, 0.03000, 0.80000, 90.000000, 0.000000, 0.000000, 1.3, 0.7, 2.3);
				    lmec[playerid] = true;
					GivePlayerWeapon(playerid, 8, 1);
				}
				case 4:
				{
				    SetPlayerAttachedObject(playerid, 0, 18652, 6, 0.07000, 0.03000, 0.80000, 90.000000, 0.000000, 0.000000, 1.3, 0.7, 2.3);
				    lmec[playerid] = true;
					GivePlayerWeapon(playerid, 8, 1);
				}
				case 5:
				{
				    SetPlayerAttachedObject(playerid, 0, 18651, 6, 0.07000, 0.03000, 0.80000, 90.000000, 0.000000, 0.000000, 1.3, 0.7, 2.3);
				    lmec[playerid] = true;
					GivePlayerWeapon(playerid, 8, 1);
				}
			}
		}
		return 1;
	}
	return 0;
}

dcmd_mec(playerid, params[])
{
	#pragma unused params
	if(lmec[playerid] == false)
	{
	    ShowPlayerDialog(playerid, 009, DIALOG_STYLE_LIST, "Light Sabres", "Green\nYellow\nBlue\nRed\nWhite\nPink", "Vybraù", "Zruöiù");
	}
	else
	{
	    RemovePlayerAttachedObject(playerid,0);
	    lmec[playerid] = false;
	}
	return 1;
}
	    
