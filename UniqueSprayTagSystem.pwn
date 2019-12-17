/* 
	Spray Tag System created by NurbWill;
	
	
	Topic: http://forum.sa-mp.com/showthread.php?t=499642
	Version: 0.2b (DOF2)
	Skype: Nurb.Will
	
	Thanks
		Zeex by ZCMD
		Incognito by Streamer
		DOF2 by ...
*/


#include 	<a_samp>
#include 	<streamer>
#include 	<zcmd>
#include 	<dof2>

/* 
	##############################################################
	######################## DEFINE'S ############################
	##############################################################
*/

// ######### Config's #########
#define 	SPRAYTAG_FOLDER 			"spraytags/%s.ini"

#define 	MAX_PLAYERS_TAGS 			(5) 					// Maximum spray tags created by player.
#define 	SPRAY_TAG_TIMER 			(4) 					// Seconds to create the spray tag.
#define 	SPRAY_TAG_OBJECT 			(19353) 				// Spray Tag Object ID
#define 	SPRAY_TAG_OBJECT_DISTANCE 	(200.0) 				// Distance that can be seen the spray tag.

// ######### Custom Dialog's Type #########
#define 	TYPE_LIST_MENU 				(0)
#define 	TYPE_LIST_EDIT 				(1)
#define 	TYPE_LIST_CREATE 			(2)
#define 	TYPE_LIST_TAGS 				(3)	
#define 	TYPE_LIST_TAGS_DELETE 		(4)
#define 	TYPE_LIST_TAGS_CREATE 		(5)
#define 	TYPE_LIST_TAGS_FIND 		(6)

// ######### Dialog's ID #########
#define 	SPRAYTAG_MENU 				(9800)
#define 	SPRAYTAG_DELETE 			(9801)
#define 	SPRAYTAG_CREATE 			(9802)
#define 	SPRAYTAG_CREATE_MAIN 		(9803)
#define 	SPRAYTAG_CREATE_TEXT 		(9804)
#define 	SPRAYTAG_CREATE_FONT 		(9805)
#define 	SPRAYTAG_CREATE_SIZE 		(9806)
#define 	SPRAYTAG_CREATE_COLOR 		(9807)
#define 	SPRAYTAG_CREATE_FINISH 		(9808)
#define 	SPRAYTAG_EDIT_MAIN 			(9809)
#define 	SPRAYTAG_EDIT_TEXT 			(9810)
#define 	SPRAYTAG_EDIT_FONT 			(9811)
#define 	SPRAYTAG_EDIT_SIZE 			(9812)
#define 	SPRAYTAG_EDIT_COLOR 		(9813)
#define 	SPRAYTAG_EDIT_FINISH 		(9814)
#define 	SPRAYTAG_EDIT_LIST 			(9815)
#define 	SPRAYTAG_FIND				(9816)
#define 	SPRAYTAG_DIALOG_RETURN		(9817)

/* 
	##############################################################
	########################## VAR'S #############################
	##############################################################
*/

enum SPRAYTAG_DATA
{
	_spObject,
	_spText[50],
	_spFontColor,
	_spBold,
	_spFontSize,
	_spFont[50],
	Float:_spPosX,
	Float:_spPosY,
	Float:_spPosZ,
	Float:_spPosRX,
	Float:_spPosRY,
	Float:_spPosRZ,
	_spVW,
	_spInt
}

new 
	SprayTags[MAX_PLAYERS][MAX_PLAYERS_TAGS][SPRAYTAG_DATA],
	spraytag_object[MAX_PLAYERS],
	spraytag_timer[MAX_PLAYERS],
	spraytag_timer_left[MAX_PLAYERS],
	spraytag_find[MAX_PLAYERS],
	spraytag_slot[MAX_PLAYERS],
	spraytag_text[MAX_PLAYERS],
	spraytag_size[MAX_PLAYERS],
	spraytag_bold[MAX_PLAYERS],
	spraytag_color[MAX_PLAYERS],
	spraytag_font[MAX_PLAYERS],
	Float:spraytag_positions[MAX_PLAYERS][6]
;

/* 
	##############################################################
	######################### PUBLIC'S ###########################
	##############################################################
*/

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Spray Tag System [DOF2] - English Version | Versão: 0.2b - By: Nurb Will;");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	DOF2_Exit();
}

public OnPlayerConnect(playerid)
{
	Tag_Load(playerid);
	return 1;
}

forward SprayTag_Dialog(iPlayerID, iType);
public SprayTag_Dialog(iPlayerID, iType)
{
	new 
		szDialog[500],
		szText[50],
		szFont[50],
		szBold[4],
		szColor[30]
	;
	
	switch(iType)
	{
		case TYPE_LIST_MENU:
		{
			ShowPlayerDialog(iPlayerID, SPRAYTAG_MENU, DIALOG_STYLE_LIST, "{F7EC6F}Spray Tag - {469BF0}Menu", "Create spray tag\nEdit spray tag\nDelete spray tag\nTrack spray tag's", "Select", "Exit");
		}
		case TYPE_LIST_CREATE:
		{
			switch(spraytag_bold[iPlayerID])
			{
				case 0: szBold = "No";
				case 1: szBold = "Yes";
			}
			switch(spraytag_color[iPlayerID])
			{
				case -65536: szColor = "{FF0000}Red";
				case -16468988: szColor = "{04B404}Green";
				case -16730675: szColor = "{00B5CD}Light Blue";
				case -256: szColor = "{FFFF00}Yellow";
				case -16776961: szColor = "{0000FF}Blue";
				case -8092540: szColor = "{848484}Grey";
				case -65281: szColor = "{FF00FF}Pink";
				case -1: szColor = "{FFFFFF}White";
			}
			
			format(szText, 50, spraytag_text[iPlayerID]);
			format(szFont, 50, spraytag_font[iPlayerID]);
			
			format(szDialog, sizeof szDialog, "\
				{F7EC6F}Text: %s\n\
				{F7EC6F}Font: %s\n\
				{F7EC6F}Size: %d\n\
				{F7EC6F}Color: %s\n\
				{F7EC6F}Bold: %s\n\
				{FFB957}Create Tag",
				szText, 
				szFont, 
				spraytag_size[iPlayerID],
				szColor, 
				szBold
			);
			ShowPlayerDialog(iPlayerID, SPRAYTAG_CREATE_MAIN, DIALOG_STYLE_LIST, "{F7EC6F}Spray Tag - {469BF0}Customization", szDialog, "Select", "Back");
		}
		case TYPE_LIST_EDIT:
		{
			switch(spraytag_bold[iPlayerID])
			{
				case 0: szBold = "No";
				case 1: szBold = "Yes";
			}
			switch(spraytag_color[iPlayerID])
			{
				case -65536: szColor = "{FF0000}Red";
				case -16468988: szColor = "{04B404}Green";
				case -16730675: szColor = "{00B5CD}Light Blue";
				case -256: szColor = "{FFFF00}Yellow";
				case -16776961: szColor = "{0000FF}Blue";
				case -8092540: szColor = "{848484}Grey";
				case -65281: szColor = "{FF00FF}Pink";
				case -1: szColor = "{FFFFFF}White";
			}

			format(szDialog, sizeof szDialog, "\
				{F7EC6F}Text: %s\n\
				{F7EC6F}Font: %s\n\
				{F7EC6F}Size: %d\n\
				{F7EC6F}Color: %s\n\
				{F7EC6F}Bold: %s\n\
				{1EAAD9}Edit Tag",
				spraytag_text[iPlayerID], 
				spraytag_font[iPlayerID], 
				spraytag_size[iPlayerID],
				szColor, 
				szBold
			);
			ShowPlayerDialog(iPlayerID, SPRAYTAG_EDIT_LIST, DIALOG_STYLE_LIST, "{F7EC6F}Spray Tag - {469BF0}Customization", szDialog, "Select", "Back");
		}
		case TYPE_LIST_TAGS:
		{
			new 
				szName[MAX_PLAYER_NAME]
			;
					
			GetPlayerName(iPlayerID, szName, sizeof szName);
			for(new i; i < MAX_PLAYERS_TAGS; i++)
			{
				new szTag[24];
				format(szTag, sizeof szTag, "{F7EC6F}Free");
				if(SprayTags[iPlayerID][i][_spPosX] != 0.0 && SprayTags[iPlayerID][i][_spPosY] != 0.0)
				{
					format(szTag, sizeof(szTag), "{F7EC6F}Spray Tag #%i", i);
				}
				format(szDialog, sizeof(szDialog), "%s%s\n", szDialog, szTag);
			}
			
			ShowPlayerDialog(iPlayerID, SPRAYTAG_EDIT_MAIN, DIALOG_STYLE_LIST, "{F7EC6F}Spray Tag - {469BF0}Edit your tag's", szDialog, "Select", "Back");
		}
		case TYPE_LIST_TAGS_DELETE:
		{
			new 
				szName[MAX_PLAYER_NAME]
			;
					
			GetPlayerName(iPlayerID, szName, sizeof szName);
					
			for(new i; i < MAX_PLAYERS_TAGS; i++)
			{
				new szTag[24];
				format(szTag, sizeof szTag, "{F7EC6F}Free");
				if(SprayTags[iPlayerID][i][_spPosX] != 0.0 && SprayTags[iPlayerID][i][_spPosY] != 0.0)
				{
					format(szTag, sizeof(szTag), "{F7EC6F}Spray Tag #%i", i);
				}
				format(szDialog, sizeof(szDialog), "%s%s\n", szDialog, szTag);
			}
			ShowPlayerDialog(iPlayerID, SPRAYTAG_DELETE, DIALOG_STYLE_LIST, "{F7EC6F}Spray Tag - {469BF0}Delete your tag's", szDialog, "Select", "Back");
		}
		case TYPE_LIST_TAGS_CREATE:
		{
			new 
				szName[MAX_PLAYER_NAME]
			;
					
			GetPlayerName(iPlayerID, szName, sizeof szName);
					
			for(new i; i < MAX_PLAYERS_TAGS; i++)
			{
				new szTag[24];
				format(szTag, sizeof szTag, "{F7EC6F}Free");
				if(SprayTags[iPlayerID][i][_spPosX] != 0.0 && SprayTags[iPlayerID][i][_spPosY] != 0.0)
				{
					format(szTag, sizeof(szTag), "{F7EC6F}Spray Tag #%i", i);
				}
				format(szDialog, sizeof(szDialog), "%s%s\n", szDialog, szTag);
			}
			ShowPlayerDialog(iPlayerID, SPRAYTAG_CREATE, DIALOG_STYLE_LIST, "{F7EC6F}Spray Tag - {469BF0}Select a free slot", szDialog, "Select", "Back");
		}
		case TYPE_LIST_TAGS_FIND:
		{
			new 
				szName[MAX_PLAYER_NAME]
			;
					
			GetPlayerName(iPlayerID, szName, sizeof szName);
					
			for(new i; i < MAX_PLAYERS_TAGS; i++)
			{
				new szTag[24];
				format(szTag, sizeof szTag, "{F7EC6F}Free");
				if(SprayTags[iPlayerID][i][_spPosX] != 0.0 && SprayTags[iPlayerID][i][_spPosY] != 0.0)
				{
					format(szTag, sizeof(szTag), "{F7EC6F}Spray Tag #%i", i);
				}
				format(szDialog, sizeof(szDialog), "%s%s\n", szDialog, szTag);
			}
			ShowPlayerDialog(iPlayerID, SPRAYTAG_FIND, DIALOG_STYLE_LIST, "{F7EC6F}Spray Tag - {469BF0}Select the tag you wish to find", szDialog, "Select", "Back");
		}
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(spraytag_find[playerid])
	{
		SendClientMessage(playerid, -1, "You arrived on your tag spray.");
		DisablePlayerCheckpoint(playerid);
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case SPRAYTAG_DIALOG_RETURN: SprayTag_Dialog(playerid, TYPE_LIST_MENU);
		case SPRAYTAG_MENU:
		{
			if(!response) return 1;
			switch(listitem)
			{
				case 0: 
				{
					SprayTag_Dialog(playerid, TYPE_LIST_TAGS_CREATE);
				}
				case 1: SprayTag_Dialog(playerid, TYPE_LIST_TAGS);
				case 2: SprayTag_Dialog(playerid, TYPE_LIST_TAGS_DELETE);
				case 3:  SprayTag_Dialog(playerid, TYPE_LIST_TAGS_FIND);
			}
		}
		case SPRAYTAG_EDIT_MAIN:
		{
			if(!response) return SprayTag_Dialog(playerid, TYPE_LIST_MENU);
			if(SprayTags[playerid][listitem][_spPosX] == 0.0)
				return ShowPlayerDialog(playerid, SPRAYTAG_DIALOG_RETURN, DIALOG_STYLE_MSGBOX, "{F7EC6F}Spray Tag - {BD0000} Ops!!", "Ops! There's nothing in that slot.", "Back", "");
				
			spraytag_slot[playerid] = listitem;
			
			spraytag_bold[playerid] = SprayTags[playerid][listitem][_spBold];
			spraytag_color[playerid] = SprayTags[playerid][listitem][_spFontColor];
			format(spraytag_text[playerid], 50, SprayTags[playerid][listitem][_spText]);
			format(spraytag_font[playerid], 50, SprayTags[playerid][listitem][_spFont]);
			spraytag_size[playerid] = SprayTags[playerid][listitem][_spFontSize];
			SprayTag_Dialog(playerid, TYPE_LIST_EDIT);
		}
		case SPRAYTAG_DELETE:
		{
			if(!response) return SprayTag_Dialog(playerid, TYPE_LIST_MENU);
			
			if(SprayTags[playerid][listitem][_spPosX] == 0.0)
				return ShowPlayerDialog(playerid, SPRAYTAG_DIALOG_RETURN, DIALOG_STYLE_MSGBOX, "{F7EC6F}Spray Tag - {BD0000} Ops!!", "Ops! There's nothing in that slot.", "Back", "");
				
			new 
				szMessage[60]
			;
				
			Tags_Clear(playerid, listitem);
			format(szMessage, sizeof szMessage, "[Spray Tag] A spray tag #%i foi deletada com sucesso.", listitem);
			SendClientMessage(playerid, -1, szMessage);
			SprayTag_Dialog(playerid, TYPE_LIST_MENU);
		}
		case SPRAYTAG_FIND:
		{
			if(!response) return SprayTag_Dialog(playerid, TYPE_LIST_MENU);
			
			if(SprayTags[playerid][listitem][_spPosX] == 0.0)
				return ShowPlayerDialog(playerid, SPRAYTAG_DIALOG_RETURN, DIALOG_STYLE_MSGBOX, "{F7EC6F}Spray Tag - {BD0000} Ops!!", "Ops! There's nothing in that slot.", "Back", "");
				
			new 
				szMessage[60]
			;
			spraytag_find[playerid] = SetPlayerCheckpoint(playerid, SprayTags[playerid][listitem][_spPosX], SprayTags[playerid][listitem][_spPosY], SprayTags[playerid][listitem][_spPosZ], 3.0);
			format(szMessage, sizeof szMessage, "[Spray Tag] Um checkpoint foi marcado na sua spraytag #%i.", listitem);
			SendClientMessage(playerid, -1, szMessage);
		}
		case SPRAYTAG_CREATE:
		{
			if(!response) return SprayTag_Dialog(playerid, TYPE_LIST_MENU);
			
			if(SprayTags[playerid][listitem][_spPosX] == 0.0)
			{
				spraytag_slot[playerid] = listitem;
				format(spraytag_text[playerid], 50, "Exemplo");
				format(spraytag_font[playerid], 50, "Arial");
				spraytag_color[playerid] = -1;
				spraytag_size[playerid] = 24;
				spraytag_bold[playerid] = 0;
				SprayTag_Dialog(playerid, TYPE_LIST_CREATE);
			} else ShowPlayerDialog(playerid, SPRAYTAG_DIALOG_RETURN, DIALOG_STYLE_MSGBOX, "{F7EC6F}Spray Tag - {BD0000} Ops!!", "Ops! This slot is already being used.", "Back", "");
		}
		case SPRAYTAG_EDIT_LIST:
		{
			if(!response) return SprayTag_Dialog(playerid, TYPE_LIST_TAGS);
			
			new 
				iIndex = spraytag_slot[playerid]
			;
			
			switch(listitem)
			{
				case 0: ShowPlayerDialog(playerid, SPRAYTAG_EDIT_TEXT, DIALOG_STYLE_INPUT, "{F7EC6F}Spray Tag - {469BF0}Text", "Enter the text you would like to appear on the Spray Tag", "Done", "Back");
				case 1: ShowPlayerDialog(playerid, SPRAYTAG_EDIT_FONT, DIALOG_STYLE_LIST, "{F7EC6F}Spray Tag - {469BF0}Font", "Arial\nCourier\nImpact\nPricedown\nDaredevil\nBombing\naaaiight! fat\nFrom Street Art\nGhang\nGraffogie\nGraphers Blog\nNosegrind Demo", "Done", "Back");
				case 2: ShowPlayerDialog(playerid, SPRAYTAG_EDIT_SIZE, DIALOG_STYLE_INPUT, "{F7EC6F}Spray Tag - {469BF0}Size", "Enter the size do you want appear on the Spray Tag", "Done", "Back");
				case 3: ShowPlayerDialog(playerid, SPRAYTAG_EDIT_COLOR, DIALOG_STYLE_LIST, "{F7EC6F}Spray Tag - {469BF0}Color", "{FF0000}Red\n{04B404}Green\n{00B5CD}Light Blue\n{FFFF00}Yellow\n{0000FF}Blue\n{848484}Grey\n{FF00FF}Pink\n{FFFFFF}White", "Done", "Back");
				case 4: 
				{
					switch(spraytag_bold[playerid])
					{
						case 0: spraytag_bold[playerid] = 1;
						case 1: spraytag_bold[playerid] = 0;
					}
					SprayTag_Dialog(playerid, TYPE_LIST_EDIT);
				}
				case 5: 
				{
					EditDynamicObject(playerid, SprayTags[playerid][iIndex][_spObject]);
					SetPVarInt(playerid, "SPRAYTAG_EDIT", 2);
				}
			}
		}
		case SPRAYTAG_EDIT_TEXT:
		{
			if(!response) return SprayTag_Dialog(playerid, TYPE_LIST_EDIT);
			format(spraytag_text[playerid], 32, inputtext);
			SprayTag_Dialog(playerid, TYPE_LIST_EDIT);
		}
		case SPRAYTAG_EDIT_FONT:
		{
			if(!response) return SprayTag_Dialog(playerid, TYPE_LIST_EDIT);
			format(spraytag_font[playerid], 32, inputtext);
			SprayTag_Dialog(playerid, TYPE_LIST_EDIT);
		}
		case SPRAYTAG_EDIT_SIZE:
		{
			if(!response) return SprayTag_Dialog(playerid, TYPE_LIST_EDIT);
			spraytag_size[playerid] = strval(inputtext);
			SprayTag_Dialog(playerid, TYPE_LIST_EDIT);
		}
		case SPRAYTAG_EDIT_COLOR:
		{
			if(!response) return SprayTag_Dialog(playerid, TYPE_LIST_EDIT);
			new iColor;
			switch(listitem)
	        {
	            case 0: iColor = HexToInt("0xFFFF0000");
	            case 1: iColor = HexToInt("0xFF04B404");
	            case 2: iColor = HexToInt("0xFF00B5CD");
	            case 3: iColor = HexToInt("0xFFFFFF00");
	            case 4: iColor = HexToInt("0xFF0000FF");
	            case 5: iColor = HexToInt("0xFF848484");
	            case 6: iColor = HexToInt("0xFFFF00FF");
	            case 7: iColor = HexToInt("0xFFFFFFFF");
	        }
			spraytag_color[playerid] = iColor;
			SprayTag_Dialog(playerid, TYPE_LIST_EDIT);
		}
		
		case SPRAYTAG_CREATE_MAIN:
		{
			if(!response) return SprayTag_Dialog(playerid, TYPE_LIST_TAGS_CREATE);
			switch(listitem)
			{
				case 0: ShowPlayerDialog(playerid, SPRAYTAG_CREATE_TEXT, DIALOG_STYLE_INPUT, "{F7EC6F}Spray Tag - {469BF0}Text", "Enter the text you would like to appear on the Spray Tag", "Done", "Back");
				case 1: ShowPlayerDialog(playerid, SPRAYTAG_CREATE_FONT, DIALOG_STYLE_LIST, "{F7EC6F}Spray Tag - {469BF0}Font", "Arial\nCourier\nImpact\nPricedown\nDaredevil\nBombing\naaaiight! fat\nFrom Street Art\nGhang\nGraffogie\nGraphers Blog\nNosegrind Demo", "Done", "Back");
				case 2: ShowPlayerDialog(playerid, SPRAYTAG_CREATE_SIZE, DIALOG_STYLE_INPUT, "{F7EC6F}Spray Tag - {469BF0}Size", "Enter the size do you want appear on the Spray Tag", "Done", "Back");
				case 3: ShowPlayerDialog(playerid, SPRAYTAG_CREATE_COLOR, DIALOG_STYLE_LIST, "{F7EC6F}Spray Tag - {469BF0}Color", "{FF0000}Red\n{04B404}Green\n{00B5CD}Light Blue\n{FFFF00}Yellow\n{0000FF}Blue\n{848484}Grey\n{FF00FF}Pink\n{FFFFFF}White", "Done", "Back");
				case 4: 
				{
					switch(spraytag_bold[playerid])
					{
						case 0: spraytag_bold[playerid] = 1;
						case 1: spraytag_bold[playerid] = 0;
					}
					SprayTag_Dialog(playerid, TYPE_LIST_CREATE);
				}
				case 5: 
				{
					new 
						Float:Position[3],
						szText[50],
						szFont[50]
					;
					
					GetPlayerPos(playerid, Position[0], Position[1], Position[2]);
					format(szText, 50, spraytag_text[playerid]);
					format(szFont, 50, spraytag_font[playerid]);
					
					spraytag_object[playerid] = CreateDynamicObject(SPRAY_TAG_OBJECT, Position[0]-1.0, Position[1], Position[2], 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, SPRAY_TAG_OBJECT_DISTANCE);
					SetDynamicObjectMaterialText(spraytag_object[playerid], 0, szText, OBJECT_MATERIAL_SIZE_512x512, szFont, spraytag_size[playerid], spraytag_bold[playerid], spraytag_color[playerid], 0, 1);
					EditDynamicObject(playerid, spraytag_object[playerid]);
					SetPVarInt(playerid, "SPRAYTAG_EDIT", 1);
				}
			}
		}
		case SPRAYTAG_CREATE_TEXT:
		{
			if(!response) return SprayTag_Dialog(playerid, TYPE_LIST_CREATE);
			format(spraytag_text[playerid], 50, inputtext);
			SprayTag_Dialog(playerid, TYPE_LIST_CREATE);
		}
		case SPRAYTAG_CREATE_FONT:
		{
			if(!response) return SprayTag_Dialog(playerid, TYPE_LIST_CREATE);
			format(spraytag_font[playerid], 50, inputtext);
			SprayTag_Dialog(playerid, TYPE_LIST_CREATE);
		}
		case SPRAYTAG_CREATE_SIZE:
		{
			if(!response) return SprayTag_Dialog(playerid, TYPE_LIST_CREATE);
			spraytag_size[playerid] = strval(inputtext);
			SprayTag_Dialog(playerid, TYPE_LIST_CREATE);
		}
		case SPRAYTAG_CREATE_COLOR:
		{
			if(!response) return SprayTag_Dialog(playerid, TYPE_LIST_CREATE);
			new iColor;
			switch(listitem)
	        {
	            case 0: iColor = HexToInt("0xFFFF0000");
	            case 1: iColor = HexToInt("0xFF04B404");
	            case 2: iColor = HexToInt("0xFF00B5CD");
	            case 3: iColor = HexToInt("0xFFFFFF00");
	            case 4: iColor = HexToInt("0xFF0000FF");
	            case 5: iColor = HexToInt("0xFF848484");
	            case 6: iColor = HexToInt("0xFFFF00FF");
	            case 7: iColor = HexToInt("0xFFFFFFFF");
	        }
			spraytag_color[playerid] = iColor;
			SprayTag_Dialog(playerid, TYPE_LIST_CREATE);
		}
	}

	return 1;
}

public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) 
{
	if(response == EDIT_RESPONSE_FINAL)
	{
		if(GetPVarInt(playerid, "SPRAYTAG_EDIT") == 1)
		{
			if(!IsPlayerInRangeOfPoint(playerid, 3, x, y, z))
			{
				DestroyDynamicObject(spraytag_object[playerid]);
				DeletePVar(playerid, "SPRAYTAG_EDIT");
				return SendClientMessage(playerid, -1, "You are not near the spray tag.");
			}
			
			spraytag_positions[playerid][0] = x;
			spraytag_positions[playerid][1] = y;
			spraytag_positions[playerid][2] = z;
			spraytag_positions[playerid][3] = rx;
			spraytag_positions[playerid][4] = ry;
			spraytag_positions[playerid][5] = rz;
			
			spraytag_timer[playerid] = SetTimerEx("SprayTag", 1000, true, "ii", playerid, 2);
			
			ApplyAnimation(playerid, "SPRAYCAN", "spraycan_full", 4.0, 1, 1, 1, 0, 0, 1);
			
			spraytag_timer_left[playerid] = SPRAY_TAG_TIMER;
			DestroyDynamicObject(spraytag_object[playerid]);
		}
		if(GetPVarInt(playerid, "SPRAYTAG_EDIT") == 2)
		{
			new 
				iIndex = spraytag_slot[playerid]
			;
			
			if(!IsPlayerInRangeOfPoint(playerid, 3, x, y, z))
			{
				DestroyDynamicObject(SprayTags[playerid][iIndex][_spObject]);
				SprayTag_Spawn(playerid, iIndex);
				DeletePVar(playerid, "SPRAYTAG_EDIT");
				return SendClientMessage(playerid, -1, "You are not near the spray tag.");
			}
				
			spraytag_positions[playerid][0] = x;
			spraytag_positions[playerid][1] = y;
			spraytag_positions[playerid][2] = z;
			spraytag_positions[playerid][3] = rx;
			spraytag_positions[playerid][4] = ry;
			spraytag_positions[playerid][5] = rz;
			
			spraytag_timer[playerid] = SetTimerEx("SprayTag", 1000, true, "ii", playerid, 1);
			
			ApplyAnimation(playerid, "SPRAYCAN", "spraycan_full", 4.0, 1, 1, 1, 0, 0, 1);
			
			spraytag_timer_left[playerid] = SPRAY_TAG_TIMER;
			DestroyDynamicObject(SprayTags[playerid][iIndex][_spObject]);
		}
	}
	if(response == EDIT_RESPONSE_CANCEL)
	{
		if(GetPVarInt(playerid, "SPRAYTAG_EDIT") >= 1)
		{
			DestroyDynamicObject(spraytag_object[playerid]);
			DestroyDynamicObject(SprayTags[playerid][spraytag_slot[playerid]][_spObject]);
			SprayTag_Spawn(playerid, spraytag_slot[playerid]);
			DeletePVar(playerid, "SPRAYTAG_EDIT");
		}
	}
	return 1;
}

forward SprayTag(playerid, type);
public SprayTag(playerid, type)
{
	new 
		iIndex = spraytag_slot[playerid]
	;
	
	if(!IsPlayerConnected(playerid))
	{
		spraytag_timer_left[playerid] = 0;
		DeletePVar(playerid, "SPRAYTAG_EDIT");
		KillTimer(spraytag_timer[playerid]);
		return 1;
	}
	
	spraytag_timer_left[playerid]--;
	
	switch(type)
	{
		case 1: 
		{
			if(spraytag_timer_left[playerid] == 0)
			{
				DestroyDynamicObject(SprayTags[playerid][iIndex][_spObject]);
				DestroyDynamicObject(spraytag_object[playerid]);
				
				format(SprayTags[playerid][iIndex][_spText], 50, spraytag_text[playerid]);
				format(SprayTags[playerid][iIndex][_spFont], 50, spraytag_font[playerid]);
				
				SprayTags[playerid][iIndex][_spPosX] = spraytag_positions[playerid][0];
				SprayTags[playerid][iIndex][_spPosY] = spraytag_positions[playerid][1];
				SprayTags[playerid][iIndex][_spPosZ] = spraytag_positions[playerid][2];
				SprayTags[playerid][iIndex][_spPosRX] = spraytag_positions[playerid][3];
				SprayTags[playerid][iIndex][_spPosRY] = spraytag_positions[playerid][4];
				SprayTags[playerid][iIndex][_spPosRZ] = spraytag_positions[playerid][5];
				SprayTags[playerid][iIndex][_spFontColor] = spraytag_color[playerid];
				SprayTags[playerid][iIndex][_spFontSize] = spraytag_size[playerid];
				SprayTags[playerid][iIndex][_spBold] = spraytag_bold[playerid];
				
				SprayTag_Spawn(playerid, iIndex);
				Tags_Save(playerid, iIndex);
				
				ClearAnimations(playerid);
				ApplyAnimation(playerid, "GRAFFITI", "graffiti_Chkout", 4.0, 0, 0, 0, 0, 0, 1);
				KillTimer(spraytag_timer[playerid]);
			}
		}
		case 2: 
		{
			if(spraytag_timer_left[playerid] == 0)
			{
				SprayTag_Create(playerid, spraytag_slot[playerid]);
				ClearAnimations(playerid);
				ApplyAnimation(playerid, "GRAFFITI", "graffiti_Chkout", 4.0, 0, 0, 0, 0, 0, 1);
				KillTimer(spraytag_timer[playerid]);
			}
		}
	}
	DeletePVar(playerid, "SPRAYTAG_EDIT");
	return 1;
}

/* 
	##############################################################
	######################### COMMAND'S ##########################
	##############################################################
*/

/*CMD:loadtags(playerid)
{
	Tag_Load(playerid);
	return 1;
}*/

CMD:tags(playerid) 
{
	if(IsPlayerConnected(playerid)) SprayTag_Dialog(playerid, TYPE_LIST_MENU);
	return 1;
}

/* 
	##############################################################
	######################### STOCK'S ############################
	##############################################################
*/

stock SprayTag_Create(playerid, iIndex)
{
	if(IsPlayerConnected(playerid))
	{
		new 
			szMessage[128]
		;
		
		SprayTags[playerid][iIndex][_spPosX] = spraytag_positions[playerid][0];
		SprayTags[playerid][iIndex][_spPosY] = spraytag_positions[playerid][1];
		SprayTags[playerid][iIndex][_spPosZ] = spraytag_positions[playerid][2];
		SprayTags[playerid][iIndex][_spPosRX] = spraytag_positions[playerid][3];
		SprayTags[playerid][iIndex][_spPosRY] = spraytag_positions[playerid][4];
		SprayTags[playerid][iIndex][_spPosRZ] = spraytag_positions[playerid][5];
		
		format(SprayTags[playerid][iIndex][_spText], 50, spraytag_text[playerid]);
		format(SprayTags[playerid][iIndex][_spFont], 50, spraytag_font[playerid]);
		
		SprayTags[playerid][iIndex][_spFontColor] = spraytag_color[playerid];
		SprayTags[playerid][iIndex][_spFontSize] = spraytag_size[playerid];
		SprayTags[playerid][iIndex][_spBold] = spraytag_bold[playerid];
		
		SprayTag_Spawn(playerid, iIndex);
		Tags_Save(playerid, iIndex);
		
		format(szMessage, sizeof szMessage, "[Spray Tag] You have created a spray tag with ID # %i.", iIndex);
		SendClientMessage(playerid, -1, szMessage);
	}
}

stock SprayTag_Spawn(playerid, iIndex)
{
	SprayTags[playerid][iIndex][_spObject] = CreateDynamicObject(SPRAY_TAG_OBJECT, SprayTags[playerid][iIndex][_spPosX], SprayTags[playerid][iIndex][_spPosY], SprayTags[playerid][iIndex][_spPosZ], SprayTags[playerid][iIndex][_spPosRX], SprayTags[playerid][iIndex][_spPosRY], SprayTags[playerid][iIndex][_spPosRZ], SprayTags[playerid][iIndex][_spVW], SprayTags[playerid][iIndex][_spInt], -1, SPRAY_TAG_OBJECT_DISTANCE);
	SetDynamicObjectMaterialText(SprayTags[playerid][iIndex][_spObject], 0, SprayTags[playerid][iIndex][_spText], OBJECT_MATERIAL_SIZE_512x512, SprayTags[playerid][iIndex][_spFont], SprayTags[playerid][iIndex][_spFontSize], SprayTags[playerid][iIndex][_spBold], SprayTags[playerid][iIndex][_spFontColor], 0, 1);
	return 1;
}

stock Tag_Load(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new 
			szFile[40],
			szLine[28],
			szName[MAX_PLAYER_NAME]
		;
		GetPlayerName(playerid, szName, MAX_PLAYER_NAME);
		format(szFile, 40, SPRAYTAG_FOLDER, szName);
		
		for(new i; i < MAX_PLAYERS_TAGS; i++)
		{
			format(szLine, sizeof szLine, "Text%i", i); format(SprayTags[playerid][i][_spText], 50, DOF2_GetString(szFile, szLine));
			format(szLine, sizeof szLine, "Font%i", i); format(SprayTags[playerid][i][_spFont], 50, DOF2_GetString(szFile, szLine));
			format(szLine, sizeof szLine, "FontSize%i", i); SprayTags[playerid][i][_spFontSize] = DOF2_GetInt(szFile, szLine);
			format(szLine, sizeof szLine, "FontBold%i", i); SprayTags[playerid][i][_spBold] = DOF2_GetInt(szFile, szLine);
			format(szLine, sizeof szLine, "FontColor%i", i); SprayTags[playerid][i][_spFontColor] = DOF2_GetInt(szFile, szLine);
			format(szLine, sizeof szLine, "PosX%i", i); SprayTags[playerid][i][_spPosX] = DOF2_GetFloat(szFile, szLine);
			format(szLine, sizeof szLine, "PosY%i", i); SprayTags[playerid][i][_spPosY] = DOF2_GetFloat(szFile, szLine);
			format(szLine, sizeof szLine, "PosZ%i", i); SprayTags[playerid][i][_spPosZ] = DOF2_GetFloat(szFile, szLine);
			format(szLine, sizeof szLine, "RotX%i", i); SprayTags[playerid][i][_spPosRX] = DOF2_GetFloat(szFile, szLine);
			format(szLine, sizeof szLine, "RotY%i", i); SprayTags[playerid][i][_spPosRY] = DOF2_GetFloat(szFile, szLine);
			format(szLine, sizeof szLine, "RotZ%i", i); SprayTags[playerid][i][_spPosRZ] = DOF2_GetFloat(szFile, szLine);
			format(szLine, sizeof szLine, "VirtualWorld%i", i); SprayTags[playerid][i][_spVW] = DOF2_GetInt(szFile, szLine);
			format(szLine, sizeof szLine, "Interior%i", i); SprayTags[playerid][i][_spInt] = DOF2_GetInt(szFile, szLine);
			
			if(SprayTags[playerid][i][_spPosX] != 0.0) 
			{
				SprayTag_Spawn(playerid, i);
			} 
		}
	}
	return 1;
}

stock Tags_Clear(playerid, iIndex)
{
	format(SprayTags[playerid][iIndex][_spText], 50, "Exemplo");
	format(SprayTags[playerid][iIndex][_spFont], 50, "Arial");
	SprayTags[playerid][iIndex][_spFontSize] = 24;
	SprayTags[playerid][iIndex][_spBold] = 0;
	SprayTags[playerid][iIndex][_spFontColor] = -1;
	SprayTags[playerid][iIndex][_spPosX] = 0.0;
	SprayTags[playerid][iIndex][_spPosY] = 0.0;
	SprayTags[playerid][iIndex][_spPosZ] = 0.0;
	SprayTags[playerid][iIndex][_spPosRX] = 0.0;
	SprayTags[playerid][iIndex][_spPosRY] = 0.0;
	SprayTags[playerid][iIndex][_spPosRZ] = 0.0;
	SprayTags[playerid][iIndex][_spVW] = 0;
	SprayTags[playerid][iIndex][_spInt] = 0;
	DestroyDynamicObject(SprayTags[playerid][iIndex][_spObject]);
	Tags_Save(playerid, iIndex);
	return 1;
}

stock Tags_Save(playerid, iIndex)
{
	if(IsPlayerConnected(playerid))
	{
		new 
			szFile[32],
			szLine[128],
			szName[MAX_PLAYER_NAME]
		;

		GetPlayerName(playerid, szName, MAX_PLAYER_NAME);
		format(szFile, 32, SPRAYTAG_FOLDER, szName);
		if(!DOF2_FileExists(szFile)) DOF2_CreateFile(szFile);
		{
			format(szLine, sizeof szLine, "Text%i", iIndex); DOF2_SetString(szFile, szLine, SprayTags[playerid][iIndex][_spText]);
			format(szLine, sizeof szLine, "Font%i", iIndex); DOF2_SetString(szFile, szLine, SprayTags[playerid][iIndex][_spFont]);
			format(szLine, sizeof szLine, "FontSize%i", iIndex); DOF2_SetInt(szFile, szLine, SprayTags[playerid][iIndex][_spFontSize]);
			format(szLine, sizeof szLine, "FontBold%i", iIndex); DOF2_SetInt(szFile, szLine, SprayTags[playerid][iIndex][_spBold]);
			format(szLine, sizeof szLine, "FontColor%i", iIndex); DOF2_SetInt(szFile, szLine, SprayTags[playerid][iIndex][_spFontColor]);
			format(szLine, sizeof szLine, "PosX%i", iIndex); DOF2_SetFloat(szFile, szLine, SprayTags[playerid][iIndex][_spPosX]);
			format(szLine, sizeof szLine, "PosY%i", iIndex); DOF2_SetFloat(szFile, szLine, SprayTags[playerid][iIndex][_spPosY]);
			format(szLine, sizeof szLine, "PosZ%i", iIndex); DOF2_SetFloat(szFile, szLine, SprayTags[playerid][iIndex][_spPosZ]);
			format(szLine, sizeof szLine, "RotX%i", iIndex); DOF2_SetFloat(szFile, szLine, SprayTags[playerid][iIndex][_spPosRX]);
			format(szLine, sizeof szLine, "RotY%i", iIndex); DOF2_SetFloat(szFile, szLine, SprayTags[playerid][iIndex][_spPosRY]);
			format(szLine, sizeof szLine, "RotZ%i", iIndex); DOF2_SetFloat(szFile, szLine, SprayTags[playerid][iIndex][_spPosRZ]);
			format(szLine, sizeof szLine, "VirtualWorld%i", iIndex); DOF2_SetInt(szFile, szLine, SprayTags[playerid][iIndex][_spVW]);
			format(szLine, sizeof szLine, "Interior%i", iIndex); DOF2_SetInt(szFile, szLine, SprayTags[playerid][iIndex][_spInt]);
			DOF2_SaveFile();
		} 
	}
	return 1;
}

stock HexToInt(string[]) // Created by Zamaroth
{
	if (string[0] == 0) return 0;
	
	new 
		i,
		cur = 1,
		res = 0
	;
	
	for (i = strlen(string); i > 0; i --) {
		if (string[i-1] < 58) res = res + cur * (string[i-1]-48); else res = res + cur * (string[i-1]-65+10);
		cur = cur * 16;
	}
	return res;
}