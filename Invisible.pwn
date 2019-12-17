#include <a_samp>

#define red 0xFF0000AA
#define yellow 0xFFFF00AA
#define grey 0xC0C0C0AA
#define blue 0x00FFFFAA

#define NAMETAG_DISTANCE 20

new Invis[MAX_PLAYERS];


public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("[ Invisibility ]  By LethaL  [ Loaded ]");
	print("--------------------------------------\n");
	
	SetTimer("HideNameTag",500,1);
	return 1;
}

public OnPlayerConnect(playerid)
{
	Invis[playerid] = 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256], idx;
	cmd = strtok(cmdtext, idx);


	if(strcmp(cmdtext,"/invis2",true)==0)
	{
		if(IsPlayerAdmin(playerid))
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new LVehicleID = GetPlayerVehicleID(playerid);	new int1 = GetPlayerInterior(playerid);
				LinkVehicleToInterior(LVehicleID,int1 + 1);
				SetPlayerColor(playerid,0xFFFFFF00);
				SendClientMessage(playerid,red,"[Cmd]: You Are Now Invisible");
				Invis[playerid] = 1;
			}
			else {
				new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleID;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle); SetPlayerColor(playerid,0xFFFFFF00); new int1 = GetPlayerInterior(playerid);
			    LVehicleID = CreateVehicle(415,X,Y,Z,Angle,1,-1,500000);
				PutPlayerInVehicle(playerid,LVehicleID,0); LinkVehicleToInterior(LVehicleID,int1 + 1);
				SendClientMessage(playerid,red,"[Cmd]: You Are Now Invisible");
				Invis[playerid] = 1;
			}
		}
		else SendClientMessage(playerid,red,"ERROR!");
		return 1;
	}

	if(strcmp(cmdtext,"/uninvis2",true)==0)
	{
		if(IsPlayerAdmin(playerid)) {
			if(IsPlayerInAnyVehicle(playerid)) {
				new LVehicleID = GetPlayerVehicleID(playerid);	new int1 = GetPlayerInterior(playerid);
				LinkVehicleToInterior(LVehicleID,int1); SetPlayerColor(playerid,0xAFAFAFAA);
				SendClientMessage(playerid,red,"[Cmd]: You Are Now Uninvisible");
				Invis[playerid] = 0;
			}
			else {
				SetPlayerColor(playerid,0xAFAFAFAA);
				SendClientMessage(playerid,red,"[Cmd]: You Are Now Uninvisible");
				Invis[playerid] = 0;
			}
		}
		else SendClientMessage(playerid,red,"ERROR!");
		return 1;
	}

	if(strcmp(cmd, "/destroycar", true) == 0) if(IsPlayerAdmin(playerid)) return EraseVehicle(GetPlayerVehicleID(playerid));
	return 0;
}

//==============================================================================
EraseVehicle(vehicleid)
{
    for(new players=0;players<=MAX_PLAYERS;players++)
    {
        new Float:X,Float:Y,Float:Z;
        if (IsPlayerInVehicle(players,vehicleid))
        {
            GetPlayerPos(players,X,Y,Z);
            SetPlayerPos(players,X,Y,Z+2);
            SetVehicleToRespawn(vehicleid);
        }
        SetVehicleParamsForPlayer(vehicleid,players,0,1);
    }
    SetTimerEx("VehRes",3000,0,"d",vehicleid);
    return 1;
}


forward VehRes(vehicleid);
public VehRes(vehicleid)
{
    DestroyVehicle(vehicleid);
}

forward HideNameTag();
public HideNameTag()
{
	for (new i = 0; i < MAX_PLAYERS; i++) 
	{
		for (new x = 0; x < MAX_PLAYERS; x++)
		{
	    	if(!IsPlayerAdmin(i) && Invis[x] == 1)
			{
		   		ShowPlayerNameTagForPlayer(i,x,0);
			}
			else
			{
				ShowPlayerNameTagForPlayer(i,x,1);
			}
	    }
	}
  	return 1;
}

forward Float:GetDistanceBetweenPlayers(p1,p2);
public Float:GetDistanceBetweenPlayers(p1,p2)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	if (!IsPlayerConnected(p1) || !IsPlayerConnected(p2)){
	return -1.00;}
	GetPlayerPos(p1,x1,y1,z1);GetPlayerPos(p2,x2,y2,z2);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}


public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(Invis[playerid] == 1) EraseVehicle(vehicleid);
}

//==============================================================================
strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

//==============================[ E O F ]=======================================
