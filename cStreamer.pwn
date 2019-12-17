/*== Info =====================================================================><
	---------------
	cStreamer:
		Version: 1
			by Crusher.
				SA:MP 0.2x
	---------------
	
	Info:
	---------
	cStreamer is an object and an vehicle streamer.
	You can set your own configuration by the defines, here under.
	The object streamer is based on xObjects.
	The vehicle streamer is my own creation.
	---------
	
	Add/Intsall:
	---------
	At your own script replace SetPlayerPos(playerid,x,y,z) with:
		CallRemoteFunction("c_SetPlayerPos","ifffffff",playerid, Float:x, Float:z, Float:y);
	Its change the pos of the player and update the objects and the vehicles. for better teleporting.
	
	Vehicles:
		{ID, Float:x, Float:y, Float:z, angle,	color,	color}
	Objects:
		{ID, Float:x, Float:y, Float:z, Float:rot_x, Float:rot_y, Float:rot_z}
	---------
	Defines:
	---------
	VIEW_DISTANCE 		: the distance for streaming vehicles and objects.
	VEH_RESPAWN_TIME	: the reaspawn time for the vehicles (CreateVehicle).
	CHECK_TIME      	: time for checking player is in reach of some objects or vehicles.
	---------
	
	More info:
	---------
	Email <> jordy_wtf@hotmail.com (only email!)
	xFire <> jordy14nl
	---------
	
==== Script ===================================================================><
*/
//== Defines ==================================================================><
#define VIEW_DISTANCE 250.0
#define VEH_RESPAWN_TIME 50
#define CHECK_TIME 800
//== Includes =================================================================><
#include <a_samp>
//== Somethings ===============================================================><
public 		OnFilterScriptInit() 						c_Init()				;
public 		OnFilterScriptExit() 						c_Exit()				;
public 		OnPlayerConnect(playerid)	 				c_Connect(playerid)		;
public 		OnPlayerDisconnect(playerid,reason) 		c_Disconnect(playerid)	;
public 		OnPlayerSpawn(playerid) 					c_Spawn(playerid)		;
//== Forwards =================================================================><
forward c_Check();
forward c_Init();
forward c_Exit();
forward c_PlayerUpdate(playerid);
forward c_DestroyAll();
forward c_SetPlayerPos(playerid,Float:x,Float:y,Float:z);
forward c_Connect(playerid);
forward c_Disconnect(playerid);
forward c_Spawn(playerid);
//== Enums ====================================================================><
enum OI //ObjectInfo
{
	modelid,
	Float:ox,
	Float:oy,
	Float:oz,
	Float:orx,
	Float:ory,
	Float:orz,
}
enum VI //VehicleInfo
{
	VehID,
	Float:vX,
	Float:vY,
	Float:vZ,
	vAngle,
	vColor1,
	vColor2,
}
//== News =====================================================================><
new
Vehicles[][VI] = // add here you vehicles 
{
//	{ID,  x,     y,     z,     angle,	color,	color}
	{522, 100.0, 100.0, 100.0, 100, 	-1, 	-1},
	{522, 200.0, 200.0, 200.0, 100, 	-1, 	-1},
	{522, 300.0, 300.0, 300.0, 100, 	-1, 	-1},
	{522, 400.0, 400.0, 400.0, 100,		-1, 	-1},
	{522, 500.0, 500.0, 500.0, 100,		-1, 	-1}
},
Objects[][OI] = //add here your objects
{
//  {id,	x,		 	y,       	z,       	rot x,   	rot y,		rot z}
	{18450,	10.0000,	10.0000, 	10.0000, 	0.0000, 	0.0000, 	0.0000},
	{18450,	20.0000,	20.0000, 	20.0000, 	0.0000, 	0.0000, 	0.0000},
	{18450,	30.0000,	30.0000, 	30.0000, 	0.0000, 	0.0000, 	0.0000},
	{18450,	40.0000,	40.0000, 	40.0000, 	0.0000, 	0.0000, 	0.0000},
	{18450,	50.0000,	50.0000, 	50.0000, 	0.0000, 	0.0000, 	0.0000}
};
//== Enums ====================================================================><
enum PIv
{
	vehid[sizeof(Vehicles)],
	bool:viewV[sizeof(Vehicles)]
}
enum PIo
{
	objid[sizeof(Objects)],
	bool:viewO[sizeof(Objects)]
}
//== News =====================================================================><
new
PlayerV[MAX_PLAYERS][PIv],
PlayerO[MAX_PLAYERS][PIo],
CheckTimer,
Float:distance,
CarRespawn,
Destroyed;
//== Bools ====================================================================><
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
//== Publics ==================================================================><
public c_Init()
{
	//print("---> cStreamer Loaded! <---");
	CheckTimer = SetTimer("Check", CHECK_TIME,1);
	CarRespawn = VEH_RESPAWN_TIME;
	distance = VIEW_DISTANCE;
	Destroyed = 0;
	return 1;
}

public c_Exit()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		for(new v=0; v<sizeof(Vehicles); v++)
		{
			if(PlayerV[i][viewV][v])
			{
				PlayerV[i][viewV][v] = false;
				DestroyVehicle(PlayerV[i][vehid][v]);
		}	}
		for(new o=0; o<sizeof(Objects); o++)
		{
		    if(PlayerO[i][viewO][o])
			{
    			PlayerO[i][viewO][o] = false;
				DestroyPlayerObject(i,PlayerO[i][objid][o]);
	}	}	}
	print("---> cStreamer Unloaded! <---");
	KillTimer(CheckTimer);
}

//------------------------------------------------------------------------------

public c_Connect(playerid)
{
	for(new v=0; v<sizeof(Vehicles); v++) {
		PlayerV[playerid][viewV][v] = false;
	}
	for(new i=0; i<sizeof(Objects); i++) {
		PlayerO[playerid][viewO][i] = false;
}   }

public c_Disconnect(playerid)
{
	for(new v=0; v<sizeof(Vehicles); v++) {
		if(PlayerV[playerid][viewV][v]) {
			PlayerV[playerid][viewV][v] = false;
			if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
				RemovePlayerFromVehicle(playerid);
				DestroyVehicle(PlayerV[playerid][vehid][v]);
	}	}	}
	for(new i=0; i<sizeof(Objects); i++)
	{
		if(PlayerO[playerid][viewO][i])
		{
			PlayerO[playerid][viewO][i] = false;
			DestroyPlayerObject(playerid,PlayerO[playerid][objid][i]);
}	}	}

//------------------------------------------------------------------------------

public c_Check()
{
	for(new i = 0; i < MAX_PLAYERS; i++) {
		if(IsPlayerConnected(i)) {
			c_PlayerUpdate(i);
}	}	}

public c_PlayerUpdate(playerid)
{
	if (Destroyed == 0)
	{
		new Float:pos[3];
		GetPlayerPos(playerid,pos[0],pos[1],pos[2]);

	   	for(new i=0; i<sizeof(Objects); i++)
		{
		    if(!PlayerO[playerid][viewO][i])
		    {
		        if(IsInReach(pos[0],pos[1],pos[2],Objects[i][ox],Objects[i][oy],Objects[i][oz],distance))
		        {
		            PlayerO[playerid][viewO][i] = true;
		            PlayerO[playerid][objid][i] = CreatePlayerObject(playerid,Objects[i][modelid],Objects[i][ox],Objects[i][oy],Objects[i][oz],Objects[i][orx],Objects[i][ory],Objects[i][orz]);
		        }
		    }
			else if(!IsInReach(pos[0],pos[1],pos[2],Objects[i][ox],Objects[i][oy],Objects[i][oz],distance))
		    {
	            PlayerO[playerid][viewO][i] = false;
	            DestroyPlayerObject(playerid,PlayerO[playerid][objid][i]);
			}
		}
		for(new v= 0; v<sizeof(Vehicles); v++)
		{
		    if(!PlayerV[playerid][viewV][v])
		    {
		        if(IsInReach(pos[0],pos[1],pos[2],Vehicles[v][vX],Vehicles[v][vY],Vehicles[v][vZ],distance))
		        {
		            PlayerV[playerid][viewV][v] = true;
		            PlayerV[playerid][vehid][v] = CreateVehicle(Vehicles[v][VehID],Vehicles[v][vX],Vehicles[v][vY],Vehicles[v][vZ],Vehicles[v][vAngle],Vehicles[v][vColor1],Vehicles[v][vColor2],CarRespawn);
		        }
		    }
			else if(!IsInReach(pos[0],pos[1],pos[2],Vehicles[v][vX],Vehicles[v][vY],Vehicles[v][vZ],distance))
			{
	            PlayerV[playerid][viewV][v] = false;
	            DestroyVehicle(PlayerV[playerid][vehid][v]);
}	}	}	}
public c_SetPlayerPos(playerid,Float:x,Float:y,Float:z)
{
	SetPlayerPos(playerid,Float:x,Float:y,Float:z);
	if (Destroyed == 0) {
	   	for(new i=0; i<sizeof(Objects); i++) {
		    if(!PlayerO[playerid][viewO][i]) {
		        if(IsInReach(Float:x,Float:y,Float:z,Objects[i][ox],Objects[i][oy],Objects[i][oz],distance)) {
		            PlayerO[playerid][viewO][i] = true;
		            PlayerO[playerid][objid][i] = CreatePlayerObject(playerid,Objects[i][modelid],Objects[i][ox],Objects[i][oy],Objects[i][oz],Objects[i][orx],Objects[i][ory],Objects[i][orz]);
      		}	}
			else if(!IsInReach(Float:x,Float:y,Float:z,Objects[i][ox],Objects[i][oy],Objects[i][oz],distance))	{
	            PlayerO[playerid][viewO][i] = false;
	            DestroyPlayerObject(playerid,PlayerO[playerid][objid][i]);
		}	}
		for(new v= 0; v<sizeof(Vehicles); v++) {
		    if(!PlayerV[playerid][viewV][v]) {
		        if(IsInReach(Float:x,Float:y,Float:z,Vehicles[v][vX],Vehicles[v][vY],Vehicles[v][vZ],distance)) {
		            PlayerV[playerid][viewV][v] = true;
		            PlayerV[playerid][vehid][v] = CreateVehicle(Vehicles[v][VehID],Vehicles[v][vX],Vehicles[v][vY],Vehicles[v][vZ],Vehicles[v][vAngle],Vehicles[v][vColor1],Vehicles[v][vColor2],CarRespawn);
      		}	}
			else if(!IsInReach(Float:x,Float:y,Float:z,Vehicles[v][vX],Vehicles[v][vY],Vehicles[v][vZ],distance)) {
	            PlayerV[playerid][viewV][v] = false;
	            DestroyVehicle(PlayerV[playerid][vehid][v]);
	}	}	} return 1; }

public c_DestroyAll()
{
	for(new p= 0; p<MAX_PLAYERS; p++) {
		for(new v= 0; v<sizeof(Vehicles); v++) {
		    if(!PlayerV[p][viewV][v]) {
      			PlayerV[p][viewV][v] = false;
	           	DestroyVehicle(PlayerV[p][vehid][v]);
		    } else if(!PlayerV[p][viewV][v]) {
	            PlayerV[p][viewV][v] = false;
	            DestroyVehicle(PlayerV[p][vehid][v]);
		}   }
        for(new o=0; o<sizeof(Objects); o++) {
		    if(!PlayerO[p][viewO][o]) {
      			PlayerO[p][viewO][o] = false;
	           	DestroyVehicle(PlayerO[p][objid][o]);
		    } else if(!PlayerO[p][viewO][o]) {
	            PlayerO[p][viewO][o] = false;
	            DestroyVehicle(PlayerO[p][objid][o]);
	}	}	}
    KillTimer(CheckTimer);
    Destroyed = 1;
}

public c_Spawn(playerid)
{
	c_PlayerUpdate(playerid);
}




// YEY 300 lines :P
