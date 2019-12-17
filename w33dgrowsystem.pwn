/*

		SCRIPT NAME: Marijuana growth v2
		AUTHOR: Blunt
		DATE: 03/02/2014
		LAST UPDATE DATE: 03/02/2014
		DESCRIPTION: Comptelely re-written system for more efficiency and general use.

*/

#include <a_samp>
#include <ZCMD>
#include <sscanf2>
#include <streamer>
#include <foreach>
main() {}

#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_GREEN 0x008000AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_YELLOW 0xDABB3E00
#define COLOR_SILVER 0x7BDDA5AA

enum wInfo
{
    bool:wAbleToPlant,
    bool:wAbleToPick,
    wPlantObject,
	Float:wX,
	Float:wY,
	Float:wZ,
	wWeed,
	wSeeds,
	Text3D:wLabel,
	wLabels
};

new WeedInfo[50][wInfo];

forward PlantWeedTimer(playerid);
forward UseWeedTimer(playerid);

public PlantWeedTimer(playerid)
{
	Update3DTextLabelText(WeedInfo[playerid][wLabel],COLOR_SILVER,"PLANT STATUS: Ready to be picked. Use /drugs pick");
	WeedInfo[playerid][wAbleToPick] = true;
}

public UseWeedTimer(playerid)
{
	SetPlayerDrunkLevel(playerid, 0);
	SendClientMessage(playerid,COLOR_WHITE,"INFO: Marijuana effects have faded away.");
}

stock GetName(playerid)
{
    new Name[MAX_PLAYER_NAME];
    if(IsPlayerConnected(playerid))
    {
		GetPlayerName(playerid, Name, sizeof(Name));
	}
	return Name;
}

stock UseWeed(playerid)
{
	WeedInfo[playerid][wWeed] = -1;
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
	SetPlayerDrunkLevel(playerid, 5000);
	SendClientMessage(playerid,COLOR_WHITE,"INFO: Marijuana used, one gram was deducted.");
	SetTimer("UseWeedTimer", 60000*5, 0); // 5 minutes
}

stock GiveSeeds(playerid)
{
    WeedInfo[playerid][wSeeds] = 1;
	SendClientMessage(playerid,COLOR_WHITE,"INFO: Seeds given.");
	WeedInfo[playerid][wAbleToPlant] = true;
}

stock GetSeedInfo(playerid)
{
	new seedinfo[10];
	if(WeedInfo[playerid][wSeeds] == 0) seedinfo = ("No");
	if(WeedInfo[playerid][wSeeds] == 1) seedinfo = ("Yes");
	return seedinfo;
}

public OnFilterScriptInit()
{
	print("Marijuana growth system by Blunt");
	print("Load status: LOADED SUCCESSFULLY");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}


COMMAND:weed(playerid, params[])
{
	new usage[10];
	if(sscanf(params, "s[10]", usage)) return SendClientMessage(playerid,COLOR_GREY,"USAGE: /weed [use/plant/pick]");
	else
	{
	    if(strcmp(usage, "plant", true) == 0)
	    {
	        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be onfoot to perform this command.");
		    if(GetPlayerInterior(playerid) != 0) return SendClientMessage(playerid, COLOR_GREY, "SERVER: You must not be outside to perform this.");
            if(WeedInfo[playerid][wAbleToPlant] == true && WeedInfo[playerid][wSeeds] == 1)
            {
				for(new weed = 0; weed < sizeof(WeedInfo); weed++)
    	    	{
				    new Float:X,Float:Y,Float:Z;
                    ApplyAnimation(playerid, "BOMBER","BOM_Plant_In",4.0,0,0,0,0,0);
                    ApplyAnimation(playerid, "BOMBER","BOM_Plant_In",4.0,0,0,0,0,0); // Applying it twice for ensurity
		            GetPlayerPos(playerid, X, Y, Z);
		            WeedInfo[weed][wPlantObject] = CreateDynamicObject(3409, X, Y, Z-1.0, 0, 0, 0, 0);
		            WeedInfo[weed][wX] = X;
		    		WeedInfo[weed][wY] = Y;
		    		WeedInfo[weed][wZ] = Z;
		    		WeedInfo[weed][wAbleToPlant] = false;
		    		WeedInfo[weed][wSeeds] = 0;
					WeedInfo[weed][wLabel] = Create3DTextLabel("PLANT STATUS: Not ready for picking.",COLOR_SILVER,WeedInfo[weed][wX],WeedInfo[weed][wY],WeedInfo[weed][wZ],10.0,0);
					WeedInfo[weed][wLabels]++;
					SetTimer("PlantWeedTimer",60000*10,0); // 60 seconds times 10 = 10 minutes.
					SendClientMessage(playerid,COLOR_GREEN,"INFO: You have planted your seeds, it will now grow and be ready to /weed pick in 10 minutes.");
		    		return 1;
				}
			}
			else SendClientMessage(playerid,COLOR_GREY,"INFO: Unable to plant seeds, you already have an active plant to maintain.");
		}
		if(strcmp(usage, "pick", true) == 0)
		{
		    if(IsPlayerInRangeOfPoint(playerid,5.0,WeedInfo[playerid][wX],WeedInfo[playerid][wY],WeedInfo[playerid][wZ]))
      		{
			    for(new weed = 0; weed < sizeof(WeedInfo); weed++)
			    {
		            if(WeedInfo[playerid][wAbleToPick] == false) SendClientMessage(playerid,COLOR_GREY,"INFO: You do not have an active plant growing to pick.");
				    ApplyAnimation(playerid, "BOMBER","BOM_Plant_In",4.0,0,0,0,0,0);
					WeedInfo[weed][wAbleToPick] = false;
					DestroyDynamicObject(WeedInfo[weed][wPlantObject]);
					WeedInfo[weed][wWeed] = 50;
					SendClientMessage(playerid, COLOR_GREEN,"INFO: You have picked your marijuana growth, and gained 50 grams in total.");
					Delete3DTextLabel(WeedInfo[weed][wLabel]);
					WeedInfo[weed][wLabels]--;
					return 1;
				}
			}
			else SendClientMessage(playerid,COLOR_GREY,"INFO: You are not near any plants.");
		}
		if(strcmp(usage, "use", true) == 0)
		{
		    if(WeedInfo[playerid][wWeed] >= 1)
		    {
		        UseWeed(playerid);
		        return 1;
		    }
		    else SendClientMessage(playerid,COLOR_GREY,"INFO: You must have at atleast one gram to perform this.");
		}
	}
	return 1;
}

COMMAND:givemeseeds(playerid)
{
	if(!IsPlayerAdmin(playerid)) SendClientMessage(playerid,COLOR_GREY,"INFO: Un-authorized access to this command.");
	GiveSeeds(playerid);
	return 1;
}

COMMAND:drughelp(playerid)
{
	SendClientMessage(playerid, COLOR_GREY, "COMMANDS: /weed /druginfo");
	if(IsPlayerAdmin(playerid)) { SendClientMessage(playerid,COLOR_GREY,"USAGE: /givemeseeds"); }
	return 1;
}

COMMAND:druginfo(playerid)
{
	new info[50];
	SendClientMessage(playerid,COLOR_GREEN,"Narcotic statistics");
	format(info,sizeof(info),"SEEDS:[%s]", GetSeedInfo(playerid));
	SendClientMessage(playerid,COLOR_GREY,info);
	format(info,sizeof(info),"WEED GRAMS:[%d]", WeedInfo[playerid][wWeed]);
	SendClientMessage(playerid,COLOR_GREY,info);
	return 1;
}