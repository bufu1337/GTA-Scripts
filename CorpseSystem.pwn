// Corpse System by Gheecco.

// Include
#include <a_samp>
// Define
#define DIALOG_CMENU    	1
#define DIALOG_CINFO 	    2
#define DIALOG_CSTEAL       3
// Enum
enum CDATA{
ActorID,
Text3D:LabelID,
Name[MAX_PLAYER_NAME],
SkinID,
Money,
Interior,
World,
Float:Pos[4]
};
new cActor[MAX_PLAYERS][CDATA];

#define FILTERSCRIPT
#if defined FILTERSCRIPT
public OnFilterScriptInit()
{
	print("\n____________________________________");
	print(" | Gheecco's Corpse System |");
	print("____________________________________\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#endif

public OnPlayerDisconnect(playerid, reason)
{
	DestroyActor(cActor[playerid][ActorID]);
	Delete3DTextLabel(cActor[playerid][LabelID]);
	format(cActor[playerid][Name], 24, "");
	cActor[playerid][Pos][0] = 0.0;
	cActor[playerid][Pos][1] = 0.0;
	cActor[playerid][Pos][2] = 0.0;
	cActor[playerid][Pos][3] = 0.0;
	cActor[playerid][SkinID] = 0;
	cActor[playerid][Money] = 0;
	cActor[playerid][Interior] = 0;
	cActor[playerid][World] = 0;
	cActor[playerid][ActorID] = 0;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    if(!strcmp(cActor[playerid][Name], ""))
	{
	    DestroyActor(cActor[playerid][ActorID]);
		Delete3DTextLabel(cActor[playerid][LabelID]);
	}
	new string[100];
	GetPlayerName(playerid, cActor[playerid][Name], 24);
	GetPlayerPos(playerid, cActor[playerid][Pos][0],cActor[playerid][Pos][1], cActor[playerid][Pos][2]);
	GetPlayerFacingAngle(playerid, cActor[playerid][Pos][3]);
	cActor[playerid][SkinID] = GetPlayerSkin(playerid);
	cActor[playerid][Money] = GetPlayerMoney(playerid);
	cActor[playerid][Interior] = GetPlayerInterior(playerid);
	cActor[playerid][World] = GetPlayerVirtualWorld(playerid);

	cActor[playerid][ActorID] = CreateActor(cActor[playerid][SkinID],cActor[playerid][Pos][0],cActor[playerid][Pos][1],cActor[playerid][Pos][2],cActor[playerid][Pos][3]);
	SetActorHealth(cActor[playerid][ActorID], 0);
 	ApplyActorAnimation(cActor[playerid][ActorID], "PED", "FLOOR_hit_f", 4.1, 0, 1, 1, 1, 0);
 	format(string, sizeof(string), "Corpse:%s | Actor ID:%d", cActor[playerid][Name], cActor[playerid][ActorID]);
	cActor[playerid][LabelID] = Create3DTextLabel(string, 0xFFFFFFFF, cActor[playerid][Pos][0], cActor[playerid][Pos][1], cActor[playerid][Pos][2], 10.0, cActor[playerid][World], 1);
 	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_CROUCH)
    {
		if(!IsPlayerInAnyVehicle(playerid))
		{
			for(new i=0;i < MAX_PLAYERS;i++)
		    {
	            if(GetPlayerVirtualWorld(playerid) == cActor[i][World])
	            {
		    		if(GetPlayerInterior(playerid) == cActor[i][Interior])
		        	{
		        		if(IsPlayerInRangeOfPoint(playerid, 1.0, cActor[i][Pos][0],cActor[i][Pos][1], cActor[i][Pos][2]))
		        		{
		       	    		new string[60];
		       	    		format(string, sizeof(string), "((Corpse: %s))", cActor[i][Name]);
		       	    		ShowPlayerDialog(playerid, DIALOG_CMENU, DIALOG_STYLE_LIST, string, "Information\n Plunders corpse\n", "Select", "Cancels");
		       	    		break;
						}
					}
				}
			}
		}
	}
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(response)
	{
	    switch(dialogid)
	    {
	        case DIALOG_CMENU:
	        {
	            switch(listitem)
	            {
	        		case 0:
					{
					    for(new i=0;i < MAX_PLAYERS;i++)
                        {
					        if(GetPlayerInterior(playerid) == cActor[i][Interior])
					        {
					        	if(IsPlayerInRangeOfPoint(playerid, 1.0, cActor[i][Pos][0],cActor[i][Pos][1], cActor[i][Pos][2]))
					        	{
					        	    new string[40], string2[256];
					        	    format(string, sizeof(string), "((Corpse: %s))", cActor[i][Name]);
					        	    format(string2, sizeof(string2), "((Name:%s))\n Money:%d\n", cActor[i][Name], cActor[i][Money]);
                                   	ShowPlayerDialog(playerid, DIALOG_CINFO, DIALOG_STYLE_MSGBOX, string, string2, "OK", "Back");

								}
							}
						}
					}
					case 1:
					{
					    for(new i=0;i < MAX_PLAYERS;i++)
                        {
					        if(GetPlayerInterior(playerid) == cActor[i][Interior])
					        {
					        	if(IsPlayerInRangeOfPoint(playerid, 1.0, cActor[i][Pos][0],cActor[i][Pos][1], cActor[i][Pos][2]))
					        	{
					        	    new string[40];
					        	    format(string, sizeof(string), "((Corpse: %s))", cActor[i][Name]);
                  					ShowPlayerDialog(playerid, DIALOG_CSTEAL, DIALOG_STYLE_MSGBOX, string, "You want to steal money from the corpse?", "Yes", "No");
								}
							}
						}
					}
				}
			}
			case DIALOG_CSTEAL:
			{
   				for(new i=0;i < MAX_PLAYERS;i++)
       			{
		        	if(GetPlayerInterior(playerid) == cActor[i][Interior])
			        {
		        		if(IsPlayerInRangeOfPoint(playerid, 1.0, cActor[i][Pos][0],cActor[i][Pos][1], cActor[i][Pos][2]))
			        	{
       	    				new string[120];
			        	    format(string, sizeof(string), "You have looted the corpse((%s))and you get %d $.", cActor[i][Name], cActor[i][Money]);
							SendClientMessage(playerid, -1, string);
							GivePlayerMoney(playerid, cActor[i][Money]);
			    			cActor[i][Money] = 0;
						}
					}
				}
			}
		}
	}
	else
	{
	    switch(dialogid)
	    {
	        case DIALOG_CINFO:
	        {
	            for(new i=0;i < MAX_PLAYERS;i++)
			    {
		            if(GetPlayerVirtualWorld(playerid) == cActor[i][World])
		            {
			    		if(GetPlayerInterior(playerid) == cActor[i][Interior])
			        	{
			        		if(IsPlayerInRangeOfPoint(playerid, 1.0, cActor[i][Pos][0],cActor[i][Pos][1], cActor[i][Pos][2]))
			        		{
			       	    		new string[60];
			       	    		format(string, sizeof(string), "((Corpse: %s))", cActor[i][Name]);
			       	    		ShowPlayerDialog(playerid, DIALOG_CMENU, DIALOG_STYLE_LIST, string, "Information\n Plunders corpse\n", "Select", "Cancels");
			       	    		break;
							}
						}
					}
				}
			}
		}
	}
	return 1;
}