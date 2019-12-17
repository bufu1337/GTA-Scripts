#include <a_samp>

forward Timer();
forward SetPlayerPosWithObjects(playerid,Float:x,Float:y,Float:z);
/*
	SetPlayerPosWithObjects usage in your gamemode:

		CallRemoteFunction("SetPlayerPosWithObjects","ifff",playerid,newx,newy,newz);
*/

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
{5005, -2069.4666, -128.0637, 37.8785, 0.0000, 0.0000, 0.0000, 500.0},
{5005, -2076.7939, -266.5894, 37.8718, 0.0000, 0.0000, 0.0000, 500.0},
{5005, -2014.5479, -194.4903, 37.8789, 0.0000, 0.0000, 90.0, 500.0},
{5005, -2091.5076, -193.3701, 37.8718, 0.0000, 0.0000, 90.0, 500.0},
{3819, -2016.4919, -142.9535, 35.3222, 0.0000, 0.0000, 0.0000, 500.0},
{3819, -2016.4468, -151.4515, 35.3181, 0.0000, 0.0000, 0.0000, 500.0},
{3819, -2016.4075, -159.8362, 35.3181, 0.0000, 0.0000, 0.0000, 500.0},
{3819, -2016.3309, -168.4807, 35.3181, 0.0000, 0.0000, 0.0000, 500.0},
{3819, -2016.6960, -176.7720, 35.3181, 0.0000, 0.0000, 0.0000, 500.0},
{3819, -2016.7058, -185.3404, 35.3181, 0.0000, 0.0000, 0.0000, 500.0},
{3819, -2016.7909, -193.9414, 35.3181, 0.0000, 0.0000, 0.0000, 500.0},
{3819, -2016.7482, -202.5176, 35.3181, 0.0000, 0.0000, 0.0000, 500.0},
{3819, -2016.9019, -210.9465, 35.3181, 0.0000, 0.0000, 0.0000, 500.0},
{3819, -2016.9359, -219.4355, 35.3181, 0.0000, 0.0000, 0.0000, 500.0},
{3819, -2016.7087, -228.3253, 35.3181, 0.0000, 0.0000, 0.0000, 500.0},
{3819, -2016.8081, -237.0725, 35.3181, 0.0000, 0.0000, 0.0000, 500.0},
{3819, -2016.7461, -245.4331, 35.3252, 0.0000, 0.0000, 0.0000, 500.0},
{3819, -2090.5422, -140.2563, 35.3181, 0.0000, 0.0000, 177.9037, 500.0},
{3819, -2090.1555, -149.1294, 35.3181, 0.0000, 0.0000, 177.0443, 500.0},
{3819, -2089.5908, -158.4133, 35.3181, 0.0000, 0.0000, 180.4820, 500.0},
{3819, -2089.5354, -168.1929, 35.3181, 0.0000, 0.0000, 179.6226, 500.0},
{3819, -2090.0439, -177.5581, 35.3181, 0.0000, 0.0000, 179.6226, 500.0},
{3819, -2089.0090, -187.0073, 35.3181, 0.0000, 0.0000, 180.4820, 500.0},
{3819, -2089.4419, -196.8446, 35.3181, 0.0000, 0.0000, 180.4820, 500.0},
{3819, -2089.0637, -211.8737, 35.3181, 0.0000, 0.0000, 180.4820, 500.0},
{3819, -2089.1323, -227.9193, 35.3181, 0.0000, 0.0000, 179.6226, 500.0},
{3819, -2088.5122, -242.4840, 35.3181, 0.0000, 0.0000, 180.4820, 500.0},
{3279, -2053.0000, -206.0969, 30.3222, 0.0000, 0.0000, 0.0000, 500.0}	// {modelid,x,y,z,rotx,roty,rotz,viewdistance}
	// all params are same as create object, except there is an additional viewdistance parameter. This is the distance
	// a player should be to see the object
};

enum player_info
{
	objid[sizeof(Objects)],
	bool:view[sizeof(Objects)]
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
	print("---\nLoaded xObjects by Boylett\n---");
	timer = SetTimer("Timer",500,1);
	return 1;
}

public OnFilterScriptExit()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		for(new o = 0; o < sizeof(Objects); o++)
		{
			if(Player[i][view][o])
			{
				Player[i][view][o] = false;
				DestroyPlayerObject(i,Player[i][objid][o]);
			}
		}
	}
	
	KillTimer(timer);
}

//------------------------------------------------------------------------------

public OnPlayerConnect(playerid)
{
	for(new i = 0; i < sizeof(Objects); i++) Player[playerid][view][i] = false;
}

public OnPlayerDisconnect(playerid)
{
	for(new i = 0; i < sizeof(Objects); i++)
	{
		if(Player[playerid][view][i])
		{
			Player[playerid][view][i] = false;
			DestroyPlayerObject(playerid,Player[playerid][objid][i]);
		}
	}
}

//------------------------------------------------------------------------------

public Timer()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
		if(IsPlayerConnected(i))
		    PlayerObjectUpdate(i);
}

PlayerObjectUpdate(playerid)
{
	new Float:pos[3];
	GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
	for(new i = 0; i < sizeof(Objects); i++)
	{
	    if(!Player[playerid][view][i])
	    {
	        if(IsInReach(pos[0],pos[1],pos[2],Objects[i][ox],Objects[i][oy],Objects[i][oz],Objects[i][viewdist]))
	        {
	            Player[playerid][view][i] = true;
	            Player[playerid][objid][i] = CreatePlayerObject(playerid,Objects[i][modelid],Objects[i][ox],Objects[i][oy],Objects[i][oz],Objects[i][orx],Objects[i][ory],Objects[i][orz]);
	        }
	    } else if(!IsInReach(pos[0],pos[1],pos[2],Objects[i][ox],Objects[i][oy],Objects[i][oz],Objects[i][viewdist]))
	    {
            Player[playerid][view][i] = false;
            DestroyPlayerObject(playerid,Player[playerid][objid][i]);
	    }
	}
}

public SetPlayerPosWithObjects(playerid,Float:x,Float:y,Float:z)
{
	for(new i = 0; i < sizeof(Objects); i++)
	{
	    if(!Player[playerid][view][i])
	    {
	        if(IsInReach(x,y,z,Objects[i][ox],Objects[i][oy],Objects[i][oz],Objects[i][viewdist]))
	        {
	            Player[playerid][view][i] = true;
	            Player[playerid][objid][i] = CreatePlayerObject(playerid,Objects[i][modelid],Objects[i][ox],Objects[i][oy],Objects[i][oz],Objects[i][orx],Objects[i][ory],Objects[i][orz]);
	        }
	    } else if(!IsInReach(x,y,z,Objects[i][ox],Objects[i][oy],Objects[i][oz],Objects[i][viewdist]))
	    {
            Player[playerid][view][i] = false;
            DestroyPlayerObject(playerid,Player[playerid][objid][i]);
	    }
	}
	SetPlayerPos(playerid,Float:x,Float:y,Float:z);
}

public OnPlayerSpawn(playerid)
	PlayerObjectUpdate(playerid);
