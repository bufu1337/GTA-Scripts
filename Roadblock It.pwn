#include <a_samp>

// Top of your script
#define MAX_ROADBLOCKS 85 // Can be anything you want, but don't go over the top.

// Search enum in your script and add this:

enum rInfo
{
    sCreated,
    Float:sX,
    Float:sY,
    Float:sZ,
    sObject,
};
new Roadblocks[MAX_ROADBLOCKS][rInfo];

// Place this under OnPlayerCommandText

	if(strcmp(cmd, "/crb", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && IsACop(playerid) || IsPlayerAdmin(playerid))
     	{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /crb [Roadblock ID]");
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "Available Roadblocks:");
				SendClientMessage(playerid, COLOR_GRAD1, "| 1: Small Roadblock");
				SendClientMessage(playerid, COLOR_GRAD1, "| 2: Medium Roadblock");
				SendClientMessage(playerid, COLOR_GRAD1, "| 3: Big Roadblock");
				SendClientMessage(playerid, COLOR_GRAD1, "| 3: Cone");
				return 1;
			}
            new rb = strval(tmp);
            if (rb == 1)
			{
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
		        GetPlayerPos(playerid, plocx, plocy, plocz);
		        GetPlayerFacingAngle(playerid,ploca);
		        CreateRoadblock(1459,plocx,plocy,plocz,ploca);
		        format(string,sizeof(string),"[HQ]: Officer %s has placed a Roadblock(1) at his position, over.",GPN(playerid));
		        SendRadioMessage(1,COLOR_BLUE,string);
		        GameTextForPlayer(playerid,"~w~Roadblock ~b~Placed!",3000,1);
				return 1;
			}
			else if (rb == 2)
			{
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
		        GetPlayerPos(playerid, plocx, plocy, plocz);
		        GetPlayerFacingAngle(playerid,ploca);
		        CreateRoadblock(978,plocx,plocy,plocz+0.6,ploca);
		        format(string,sizeof(string),"[HQ]: Officer %s has placed a Roadblock(2) at his position, over.",GPN(playerid));
		        SendRadioMessage(1,COLOR_BLUE,string);
		        GameTextForPlayer(playerid,"~w~Roadblock ~b~Placed!",3000,1);
				return 1;
			}
			else if (rb == 3)
			{
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
		        GetPlayerPos(playerid, plocx, plocy, plocz);
		        GetPlayerFacingAngle(playerid,ploca);
		        CreateRoadblock(981,plocx,plocy,plocz+0.9,ploca+180);
		        format(string,sizeof(string),"[HQ]: Officer %s has placed a Roadblock(3) at his position, over.",GPN(playerid));
		        SendRadioMessage(1,COLOR_BLUE,string);
		        GameTextForPlayer(playerid,"~w~Roadblock ~g~Placed!",3000,1);
		        SetPlayerPos(playerid, plocx, plocy+1.3, plocz);
				return 1;
			}
			else if (rb == 4)
			{
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
		        GetPlayerPos(playerid, plocx, plocy, plocz);
		        GetPlayerFacingAngle(playerid,ploca);
		        CreateRoadblock(1238,plocx,plocy,plocz+0.2,ploca);
		        format(string,sizeof(string),"[HQ]: Officer %s has placed a Traffic Cone(1) at his position, over.",GPN(playerid));
		        SendRadioMessage(1,COLOR_BLUE,string);
		        GameTextForPlayer(playerid,"~w~Cone ~g~Placed!",3000,1);
				return 1;
			}
			/*else if (rb == 4)
			{
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
		        GetPlayerPos(playerid, plocx, plocy, plocz);
		        GetPlayerFacingAngle(playerid,ploca);
		        CreateRoadblock(1425,plocx,plocy,plocz+0.6,ploca);
		        format(string,sizeof(string),"[HQ]: Officer %s has placed a Detour Sign(4) at his position, over.",GPN(playerid));
		        SendRadioMessage(1,COLOR_BLUE,string);
		        GameTextForPlayer(playerid,"~w~Sign ~g~Placed!",3000,1);
				return 1;
			}
			else if (rb == 5)
			{
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
		        GetPlayerPos(playerid, plocx, plocy, plocz);
		        GetPlayerFacingAngle(playerid,ploca);
		        CreateRoadblock(3265,plocx,plocy,plocz-0.5,ploca);
		        format(string,sizeof(string),"[HQ]: Officer %s has placed a Will Be Sign(5) at his position, over.",GPN(playerid));
		        SendRadioMessage(1,COLOR_BLUE,string);
		        GameTextForPlayer(playerid,"~w~Sign ~g~Placed!",3000,1);
				return 1;
			}
			else if (rb == 6)
			{
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
		        GetPlayerPos(playerid, plocx, plocy, plocz);
		        GetPlayerFacingAngle(playerid,ploca);
		        CreateRoadblock(3091,plocx,plocy,plocz+0.5,ploca+180);
		        format(string,sizeof(string),"[HQ]: Officer %s has placed a Line Closed Sign(6) at his position, over.",GPN(playerid));
		        SendRadioMessage(1,COLOR_BLUE,string);
		        GameTextForPlayer(playerid,"~w~Sign ~g~Placed!",3000,1);
				return 1;
			}*/
		}
	    return 1;
	}
	else if (strcmp(cmd,"/rrb",true) == 0)
	{
	    if(IsPlayerConnected(playerid) && IsACop(playerid) || IsPlayerAdmin(playerid))
     	{
        	DeleteClosestRoadblock(playerid);
        	format(string,sizeof(string),"[HQ]: Officer %s has removed a Roadblock, over.",GPN(playerid));
	        SendRadioMessage(1,COLOR_BLUE,string);
	        GameTextForPlayer(playerid,"~w~Roadblock ~r~Removed!",3000,1);
		}
	    return 1;
	}
	else if (strcmp(cmd,"/rrball",true) == 0)
	{
	    if(IsPlayerConnected(playerid) && IsACop(playerid) || IsPlayerAdmin(playerid))
     	{
			if(PlayerInfo[playerid][pRank] >= 6 || IsPlayerAdmin(playerid)) // This being the default Chief rank in LA-RP change if neccesary.
			{
        		DeleteAllRoadblocks(playerid);
        		format(string,sizeof(string),"[HQ]: Officer %s has removed all Roadblocks in the area, over.",GPN(playerid));
	        	SendRadioMessage(1,COLOR_BLUE,string);
	        	GameTextForPlayer(playerid,"~b~All ~w~Roadblocks ~r~Removed!",3000,1);
			}
		}
	    return 1;
	}

// Place this under your script

stock CreateRoadblock(Object,Float:x,Float:y,Float:z,Float:Angle)
{
    for(new i = 0; i < sizeof(Roadblocks); i++)
  	{
  	    if(Roadblocks[i][sCreated] == 0)
  	    {
            Roadblocks[i][sCreated] = 1;
            Roadblocks[i][sX] = x;
            Roadblocks[i][sY] = y;
            Roadblocks[i][sZ] = z-0.7;
            Roadblocks[i][sObject] = CreateDynamicObject(Object, x, y, z-0.9, 0, 0, Angle);
	        return 1;
  	    }
  	}
  	return 0;
}

stock DeleteAllRoadblocks(playerid)
{
    for(new i = 0; i < sizeof(Roadblocks); i++)
  	{
  	    if(IsPlayerInRangeOfPoint(playerid, 100, Roadblocks[i][sX], Roadblocks[i][sY], Roadblocks[i][sZ]))
        {
	  	    if(Roadblocks[i][sCreated] == 1)
	  	    {
	  	        Roadblocks[i][sCreated] = 0;
	            Roadblocks[i][sX] = 0.0;
	            Roadblocks[i][sY] = 0.0;
	            Roadblocks[i][sZ] = 0.0;
	            DestroyDynamicObject(Roadblocks[i][sObject]);
	  	    }
  	    }
	}
    return 0;
}

stock DeleteClosestRoadblock(playerid)
{
    for(new i = 0; i < sizeof(Roadblocks); i++)
  	{
  	    if(IsPlayerInRangeOfPoint(playerid, 5.0, Roadblocks[i][sX], Roadblocks[i][sY], Roadblocks[i][sZ]))
        {
  	        if(Roadblocks[i][sCreated] == 1)
            {
                Roadblocks[i][sCreated] = 0;
                Roadblocks[i][sX] = 0.0;
                Roadblocks[i][sY] = 0.0;
                Roadblocks[i][sZ] = 0.0;
                DestroyDynamicObject(Roadblocks[i][sObject]);
                return 1;
  	        }
  	    }
  	}
    return 0;
}
