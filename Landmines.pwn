#include <a_samp>
#include <ZCMD>
#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))

#define FILTERSCRIPT
#if defined FILTERSCRIPT
#define MAX_LANDMINES 200
#define GRAY 0xBEC4C3FF

new mine, Text3D: minetext;
new caught[MAX_PLAYERS], mines[MAX_PLAYERS], planted[MAX_PLAYERS];

enum LandMineInfo
{
	active,
	exploded,
	Float: minex, Float: miney, Float: minez
};
new MineInfo[MAX_LANDMINES][LandMineInfo];

public OnFilterScriptInit()
{
	print("\n Landmine FS by Cannary2048");
	CreatePickup(1239, 1, 691.2878,-1566.2411,14.2422, 0);
	Create3DTextLabel("Land Mine Shop\n/buymines",0xFFFFFFFF, 691.2878,-1566.2411,14.2422, 13.0, 0, 0);
	return 1;
}

CMD:buymines(playerid, params[])
{
	ShowPlayerDialog(playerid, 12987, DIALOG_STYLE_MSGBOX, "Land Mine - Buy", "You're going to buy a Landmine.\nAre you sure?{236E1A} ($500)", "Yes", "Cancel");
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{

    switch( dialogid )
	{
	    case 12987:
	    {
		    if(response)
		    {
		        mines[playerid] += 1;
				GivePlayerMoney(playerid, -500);
				SendClientMessage(playerid, -1, "You bought a landmine for $500!");
			}
			if(!response)
			{
			    return 1;
			}
		}
	}
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
}

#endif


public OnPlayerConnect(playerid)
{
	caught[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	caught[playerid] = 0;
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

stock CreateMine(Float:x, Float:y, Float:z)
{
	mine = CreateObject(1213, x, y, z-0.8, 0, 0, 0, 50.0);
	SetObjectMaterial(mine, 0, 964, "cj_crate_will", "CJ_FLIGHT_CASE2", 0);
	minetext = Create3DTextLabel("Land Mine\nStatus: {24F027}Deactivated{FFFFFF}.", 0xFFFFFFFF, x, y, z-0.3, 7.0, 0, 0);
	return 1;
}

stock DeleteMine()
{
	DestroyObject(mine);
	return 1;
}

forward Active();
public Active()
{
    Update3DTextLabelText(minetext, 0xFFFFFFFF, "Land Mine\nStatus: {FFCC00}Activated{FFFFFF}.");
   	for(new i = 0; i < sizeof(MineInfo); i++)
	{
	    MineInfo[i][active] = 1;
	}
}

forward Allowed(playerid);
public Allowed(playerid)
{
	planted[playerid] = 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(HOLDING(KEY_CROUCH | KEY_NO))
	{
		for(new i = 0; i < sizeof(MineInfo); i++)
		{
		    if(planted[playerid] == 0 && mines[playerid] >= 1) //&& mines[playerid] >= 1)
		    {
				planted[playerid] = 1;
		    	GetPlayerPos(playerid, MineInfo[i][minex], MineInfo[i][miney], MineInfo[i][minez]);
		    	CreateMine(MineInfo[i][minex], MineInfo[i][miney], MineInfo[i][minez]);
		    	SetTimer("Active", 2000, 0);
		    	SetTimer("Allowed", 10000, 0);
		    	SendClientMessage(playerid, -1, "You've planted it, now run!");
			}
			else if(mines[playerid] == 0) { return SendClientMessage(playerid, GRAY, "You don't have any mines."); }
			else if(planted[playerid] == 0) { return SendClientMessage(playerid, GRAY, "No, sir! Wait ten seconds."); }
		}
	}
//	else if(mines[playerid] == 1) { SendClientMessage(playerid, GRAY, "You don't have any landmines. Buy it at Marina near the burger shop!"); }
	return 1;
}

forward Arming();
public Arming()
{
	for(new i = 0; i < sizeof(MineInfo); i++)
	{
		CreateExplosion(MineInfo[i][minex], MineInfo[i][miney], MineInfo[i][minez], 11, 2.0);
		CreateExplosion(MineInfo[i][minex], MineInfo[i][miney], MineInfo[i][minez], 11, 2.0);
		DeleteMine();
		Delete3DTextLabel(minetext);
	}
}

public OnPlayerUpdate(playerid)
{
	for(new i = 0; i < sizeof(MineInfo); i++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, MineInfo[i][minex], MineInfo[i][miney], MineInfo[i][minez]) && MineInfo[i][active] == 1)
	    {
	        MineInfo[i][active] = 0;
       		Update3DTextLabelText(minetext, 0xFFFFFFFF, "Land Mine\nStatus: {FF0000}Armed{FFFFFF}.");
		    SetTimer("Arming", 500, 0);
	    }
	}
	return 1;
}