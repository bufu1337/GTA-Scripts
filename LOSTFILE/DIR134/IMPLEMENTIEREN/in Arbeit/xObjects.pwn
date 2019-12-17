//------------------------------------------------------------------------------

#include <a_samp>

//------------------------------------------------------------------------------

forward Timer();
forward SetPlayerPosWithObjects(playerid,Float:x,Float:y,Float:z);
/*
	SetPlayerPosWithObjects usage in your gamemode:

		CallRemoteFunction("SetPlayerPosWithObjects","ifff",playerid,newx,newy,newz);
*/

//------------------------------------------------------------------------------

// these define the areas edges.

#if !defined AREA_X_START
#define AREA_X_START -2000.0
#endif

#if !defined AREA_Y_START
#define AREA_Y_START -2000.0
#endif

// defines the size of areas

#if !defined AREA_SIZE
#define AREA_SIZE 100
#endif

// these define how many areas there are

#if !defined AREAS_X
#define AREAS_X 40
#endif

#if !defined AREAS_Y
#define AREAS_Y 40
#endif

// defines how many objects can fit in 1 area

#if !defined MAX_AREA_OBJECTS
#define MAX_AREA_OBJECTS 100
#endif

// defines how many objects a player can see

#if !defined MAX_OBJECTS_VIEW
#define MAX_OBJECTS_VIEW 150
#endif

//------------------------------------------------------------------------------

#define AREA_SIZE_MAX AREA_SIZE * 3
#define XMAX AREA_X_START + (AREAS_X * AREA_SIZE) - 1
#define YMAX AREA_Y_START + (AREAS_Y * AREA_SIZE) - 1

new Areas[AREAS_X][AREAS_Y][MAX_AREA_OBJECTS];
new AreaSize[AREAS_X][AREAS_Y];

//------------------------------------------------------------------------------

enum object_info
{
	modelid,
	Float:ox,
	Float:oy,
	Float:oz,
	Float:orx,
	Float:ory,
	Float:orz,
	Float:viewdist
}

new Objects[][object_info] = {
	{0,0.0,0.0,0.0,0.0,0.0,0.0,200.0},
	{0,0.0,0.0,0.0,0.0,0.0,0.0,200.0},
	{0,0.0,0.0,0.0,0.0,0.0,0.0,200.0}
	// {modelid,x,y,z,rotx,roty,rotz,viewdistance}
	// all params are same as create object, except there is an additional viewdistance parameter. This is the distance
	// a player should be to see the object
};

enum player_info
{
	objlist[MAX_OBJECTS_VIEW],
	objliston,
	objids[MAX_OBJECTS_VIEW],
	Float:lastpos[3]
}
new Player[MAX_PLAYERS][player_info];

//------------------------------------------------------------------------------

bool:IsInReach(Float:x,Float:y,Float:z,Float:x2,Float:y2,Float:z2,Float:dist)
{
	x = (x > x2) ? x - x2 : x2 - x;
	if(x > dist) return false;
	y = (y > y2) ? y - y2 : y2 - y;
	if(y > dist) return false;
	z = (z > z2) ? z - z2 : z2 - z;
	if(z > dist) return false;
	return true;
}

//------------------------------------------------------------------------------

new timer;

public OnFilterScriptInit()
{
	print("************************************");
	print("* Loaded xObjects by Boylett");
	timer = SetTimer("Timer",500,1);
	
	new areasused = 0,
	    bool:donearea[AREAS_X][AREAS_Y];

	for(new i = 0; i < sizeof(Objects); i++)
	{
	    new x, y;
	    for(new Float:a = AREA_X_START, d = 0; a <= XMAX; a += AREA_SIZE, d++)
	    {
	        if(Objects[i][ox] < a)
	        {
	            x = d;
	            break;
	        }
		}
		
	    for(new Float:a = AREA_Y_START, d = 0; a <= YMAX; a += AREA_SIZE, d++)
	    {
	        if(Objects[i][oy] < a)
	        {
	            y = d;
	            break;
	        }
		}
		if(AreaSize[x][y] >= MAX_AREA_OBJECTS)
		{
			print("* ----------------------------------");
		    printf("xObjects Error: Object %d had to be missed because there wasnt enough room in its area. Increase the area limit",i);
		} else {
			Areas[x][y][AreaSize[x][y]] = i;
			AreaSize[x][y]++;
			if(!donearea[x][y])
			{
			    donearea[x][y] = true;
			    areasused++;
			}
		}
	}
	print("* ----------------------------------");
	printf("* Objects loaded: %d",sizeof(Objects));
	printf("* Areas used: %d out of %d",areasused,sizeof(AreaSize) * sizeof(AreaSize[]));
	print("************************************");
	return 1;
}

public OnFilterScriptExit()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		for(new o = 0; o < Player[i][objliston]; o++)
		{
			DestroyPlayerObject(i,Player[i][objlist][o]);
		}
	}
	
	KillTimer(timer);
}

//------------------------------------------------------------------------------

public OnPlayerConnect(playerid)
{
 	Player[playerid][objliston] = 0;
	Player[playerid][lastpos][0] = 0.0;
	Player[playerid][lastpos][1] = 0.0;
	Player[playerid][lastpos][2] = 0.0;
}

public OnPlayerDisconnect(playerid)
{
	for(new o = 0; o < Player[playerid][objliston]; o++)
	{
		DestroyPlayerObject(playerid,Player[playerid][objlist][o]);
	}
	Player[playerid][objliston] = 0;
}

//------------------------------------------------------------------------------

public Timer()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
		if(IsPlayerConnected(i))
		{
		    new Float:pos[3];
			GetPlayerPos(i,pos[0],pos[1],pos[2]);
		    PlayerObjectUpdate(i,pos);
		}
}

PlayerObjectUpdate(playerid,Float:pos[3])
{
	new x, y,
		bool:viewing[sizeof(Objects)],
		viewids[sizeof(Objects)];
	
	if(!IsInReach(pos[0],pos[1],pos[2],Player[playerid][lastpos][0],Player[playerid][lastpos][1],Player[playerid][lastpos][2],AREA_SIZE_MAX))
	{
		for(new o = 0; o < Player[playerid][objliston]; o++)
		{
			DestroyPlayerObject(playerid,Player[playerid][objlist][o]);
		}
		Player[playerid][objliston] = 0;
	} else {
		for(new o = 0; o < Player[playerid][objliston]; o++)
		{
			viewids[Player[playerid][objlist][o]] = o;
			viewing[Player[playerid][objlist][o]] = true;
		}
	}
	
	Player[playerid][lastpos] = pos;

    for(new Float:a = AREA_X_START, d = 0; a <= XMAX; a += AREA_SIZE, d++)
    {
        if(pos[0] < a)
        {
            x = d - 1;
            break;
        }
	}

    for(new Float:a = AREA_Y_START, d = 0; a <= YMAX; a += AREA_SIZE, d++)
    {
        if(pos[1] < a)
        {
            y = d - 1;
            break;
        }
	}
	
	for(new maxx = x + 2, tmpx = x; tmpx <= maxx; tmpx++)
	{
	    for(new maxy = y + 2, tmpy = y; tmpy <= maxy; tmpy++)
	    {
			for(new i = 0; i < AreaSize[tmpx][tmpy]; i++)
			{
			    new objectid = Areas[tmpx][tmpy][i];
			    if(!viewing[objectid])
			    {
			        if(IsInReach(pos[0],pos[1],pos[2],Objects[objectid][ox],Objects[objectid][oy],Objects[objectid][oz],Objects[objectid][viewdist]))
			        {
			            if(Player[playerid][objliston] >= MAX_OBJECTS_VIEW)
			            {
			                printf("Player %d has exceeded the object limit. Put a smaller view distance on the objects surrounding this area: %f,%f,%f",playerid,pos[0],pos[1],pos[2]);
			            } else {
			            	viewids[objectid] = Player[playerid][objliston];
			            	viewing[objectid] = true;
			            	Player[playerid][objlist][Player[playerid][objliston]] = objectid;
			            	Player[playerid][objids][Player[playerid][objliston]] = CreatePlayerObject(playerid,Objects[objectid][modelid],Objects[objectid][ox],Objects[objectid][oy],Objects[objectid][oz],Objects[objectid][orx],Objects[objectid][ory],Objects[objectid][orz]);
			            	Player[playerid][objliston]++;
						}
			        }
			    } else if(!IsInReach(pos[0],pos[1],pos[2],Objects[objectid][ox],Objects[objectid][oy],Objects[objectid][oz],Objects[objectid][viewdist]))
			    {
			        Player[playerid][objliston]--;
		            DestroyPlayerObject(playerid,Player[playerid][objids][viewids[objectid]]);
		            Player[playerid][objlist][viewids[objectid]] = Player[playerid][objlist][Player[playerid][objliston]];
		            Player[playerid][objids][viewids[objectid]] = Player[playerid][objids][Player[playerid][objliston]];
		            viewids[Player[playerid][objlist][viewids[objectid]]] = viewids[objectid];
			        viewing[objectid] = false;
			    }
			}
	    }
	}
}

public SetPlayerPosWithObjects(playerid,Float:x,Float:y,Float:z)
{
	new Float:pos[3];
	pos[0] = x;
	pos[1] = y;
	pos[2] = z;
	PlayerObjectUpdate(playerid,pos);
	SetPlayerPos(playerid,Float:x,Float:y,Float:z);
}

public OnPlayerSpawn(playerid)
{
    new Float:pos[3];
	GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
    PlayerObjectUpdate(playerid,pos);
}
