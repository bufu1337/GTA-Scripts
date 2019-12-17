/*
	DeathBody ScriptBase (Carry,Creation,Destroy)
	You can use this script where you want.

	© Copyright Jumbo(iJumbo) 2013
	Thanks Kalcor for mapandreas (http://forum.sa-mp.com/showthread.php?t=120013)
*/
#include 										<a_samp>
#include 										<mapandreas>
#define 										FILTERSCRIPT
#define 										MAX_DEATH_BODY 							100 //Max death bodyes can script create
#define 										DEATH_BODY_OFFSET 						0.3 //The offset of the body from the Z ground from mapandreas
#define 										DEATH_BODY_MAX_ERROR 					"DeathBodySYSTEM-WARNING: Max death body reached."
#define                                         DEATH_BODY_NO_BODY                      "You don't have any death body in your hands"
#define                                         DEATH_BODY_NO_NEAR                      "There is no death body near you"
#define                                         DEATH_BODY_FIND_RANGE                   2.0 //The range for find a deathbody (with /pickupbody)
#define 										DEATH_BODY_CARRY_X 						0.060999 //carry offset X
#define 										DEATH_BODY_CARRY_Y						0.028999 //carry offset Y
#define 										DEATH_BODY_CARRY_Z						-0.393999 //carry offset Z
#define 										DEATH_BODY_CARRY_RX						-20.699985 //carry offset RX
#define 										DEATH_BODY_CARRY_RY						0.000000 //carry offset RY
#define 										DEATH_BODY_CARRY_RZ						-0.60000 //carry offset RZ
#define                                         SLOT_CARRY                              8 //Slot for attached object
forward 										DeathBodyFunction();

/*

Function CreateDeathBody(Float:X, Float:Y, Float:Z, Expire_Seconds = 60)
		 This function create a death body in the x y z position
		 you can also add a expire time (default 60 seconds)


Function DeleteDeathBody(DeathBody_ID)
		 This function delete a death body by giving a deathbody ID

Function DeleteAllDeathBody()
		 This function delete all existing death body

Function FindFreeDeathBody()
		 This function find a free death body id from the MAX_DEATH_BODY

Function FindNearDeathBodyID(playerid,Float:Range)
		 This function find a near body you can give the range


Function PickupDeathBody(playerid)
		 This function pickup a body from the ground

Function DropDeathBody(playerid)
		 This function drop a body to the ground
*/



/*DeathBody ------------------------------------------------------------------*/
enum DEATH_BODY {
	DEATH_BODY_OBJ,
	Float:DEATH_BODY_X,
	Float:DEATH_BODY_Y,
	Float:DEATH_BODY_Z,
	DEATH_BODY_EXPIRE_SECONDS,
	bool:DEATH_BODY_CARRY,
	bool:DEATH_BODY_USED
}
new
	DeathBody[MAX_DEATH_BODY][DEATH_BODY],
	DeathBodyTimer,
	PlayerCarry_DeathBody[MAX_PLAYERS]
;




/*INT ------------------------------------------------------------------------*/
public OnFilterScriptInit()
{
	DeathBodyTimer = SetTimer("DeathBodyFunction",1000,1);
	return 1;
}
/*EXIT -----------------------------------------------------------------------*/
public OnFilterScriptExit()
{
	KillTimer(DeathBodyTimer);
    DeleteAllDeathBody();
	return 1;
}




/*FUNCTIONS ------------------------------------------------------------------*/
public DeathBodyFunction()
{
	for(new db = 0; db != MAX_DEATH_BODY; db++) {
	    for(new i = 0; i != MAX_PLAYERS; i++) {
	        if(IsPlayerInRangeOfPoint(i,3.0,DeathBody[db][DEATH_BODY_X],DeathBody[db][DEATH_BODY_Y],DeathBody[db][DEATH_BODY_Z]) && DeathBody[db][DEATH_BODY_CARRY] == false && DeathBody[i][DEATH_BODY_USED] == true) {
	            if(IsValidObject(DeathBody[db][DEATH_BODY_OBJ])) {
					DestroyObject(DeathBody[db][DEATH_BODY_OBJ]);
					DeathBody[db][DEATH_BODY_OBJ] = CreateObject(3092, DeathBody[db][DEATH_BODY_X],DeathBody[db][DEATH_BODY_Y],DeathBody[db][DEATH_BODY_Z] + DEATH_BODY_OFFSET, 90.0, 90.0, 90.0);
				}
			}
		}
		if(DeathBody[db][DEATH_BODY_USED] ==  true && DeathBody[db][DEATH_BODY_CARRY] == false) {
		    DeathBody[db][DEATH_BODY_EXPIRE_SECONDS] = DeathBody[db][DEATH_BODY_EXPIRE_SECONDS] - 1;
		    if(DeathBody[db][DEATH_BODY_EXPIRE_SECONDS] <= 0) {
		        DeleteDeathBody(db);
		    }
		}
	}
}
public OnPlayerDeath(playerid, killerid, reason)
{
	new Float:POS[3];
	GetPlayerPos(playerid,POS[0],POS[1],POS[2]);
	CreateDeathBody(POS[0],POS[1],POS[2]);
    DropDeathBody(playerid);
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
   	DropDeathBody(playerid);
    return 1;
}







/*STOCK ----------------------------------------------------------------------*/

stock CreateDeathBody(Float:X, Float:Y, Float:Z, Expire_Seconds = 60)
{
	new DeathBodyID = FindFreeDeathBody();
	if(DeathBodyID != -1) {
	    MapAndreas_FindZ_For2DCoord(X,Y,Z);
	    DeathBody[DeathBodyID][DEATH_BODY_USED] = true;
	    DeathBody[DeathBodyID][DEATH_BODY_EXPIRE_SECONDS] = Expire_Seconds;
	    DeathBody[DeathBodyID][DEATH_BODY_X] = X;
	    DeathBody[DeathBodyID][DEATH_BODY_Y] = Y;
	    DeathBody[DeathBodyID][DEATH_BODY_Z] = Z;
		DeathBody[DeathBodyID][DEATH_BODY_OBJ] = CreateObject(3092, X, Y, Z + DEATH_BODY_OFFSET, 90.0, 90.0, 90.0);
	} else print(DEATH_BODY_MAX_ERROR);
}
stock DeleteDeathBody(DeathBody_ID)
{
    if(DeathBody[DeathBody_ID][DEATH_BODY_USED] ==  true) {
        DeathBody[DeathBody_ID][DEATH_BODY_USED] = false;
        DestroyObject(DeathBody[DeathBody_ID][DEATH_BODY_OBJ]);
    }
}
stock DeleteAllDeathBody()
{
    for(new i = 0; i != MAX_DEATH_BODY; i++) {
        if(DeathBody[i][DEATH_BODY_USED] ==  true) {
            DeathBody[i][DEATH_BODY_USED] = false;
    	    DestroyObject(DeathBody[i][DEATH_BODY_OBJ]);
        }
    }
}
stock FindFreeDeathBody()
{
	for(new i = 0; i != MAX_DEATH_BODY; i++) {
	    if(DeathBody[i][DEATH_BODY_USED] == false) {
	        return i;
	    }
	}
	return -1;
}
stock FindNearDeathBodyID(playerid,Float:Range)
{
	for(new i = 0; i != MAX_DEATH_BODY; i++) {
	    if(IsPlayerInRangeOfPoint(playerid,Range,DeathBody[i][DEATH_BODY_X],DeathBody[i][DEATH_BODY_Y],DeathBody[i][DEATH_BODY_Z]) && DeathBody[i][DEATH_BODY_CARRY] == false && DeathBody[i][DEATH_BODY_USED] == true) {
	        return i;
	    }
	}
	return -1;
}
stock PickupDeathBody(playerid)
{
	new DeathBodyID = FindNearDeathBodyID(playerid,DEATH_BODY_FIND_RANGE);
	if(DeathBodyID != -1) {
		PlayerCarry_DeathBody[playerid] = DeathBodyID;
		//
		DeathBody[PlayerCarry_DeathBody[playerid]][DEATH_BODY_CARRY] = true;
		DestroyObject(DeathBody[PlayerCarry_DeathBody[playerid]][DEATH_BODY_OBJ]);
		//
		SetPlayerAttachedObject(playerid,SLOT_CARRY,3092,6,DEATH_BODY_CARRY_X,DEATH_BODY_CARRY_Y,DEATH_BODY_CARRY_Z,DEATH_BODY_CARRY_RX,DEATH_BODY_CARRY_RY,DEATH_BODY_CARRY_RZ);
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_CARRY);
	} else SendClientMessage(playerid,-1,DEATH_BODY_NO_NEAR);
}
stock DropDeathBody(playerid)
{
	if(PlayerCarry_DeathBody[playerid] != -1) {
		new Float:POS[3];
	 	GetPlayerPos(playerid,POS[0],POS[1],POS[2]);
	 	//
	  	DeathBody[PlayerCarry_DeathBody[playerid]][DEATH_BODY_CARRY] = false;
	   	MapAndreas_FindZ_For2DCoord(POS[0],POS[1],POS[2]);
		DeathBody[PlayerCarry_DeathBody[playerid]][DEATH_BODY_X] = POS[0];
	 	DeathBody[PlayerCarry_DeathBody[playerid]][DEATH_BODY_Y] = POS[1];
	  	DeathBody[PlayerCarry_DeathBody[playerid]][DEATH_BODY_Z] = POS[2];
	  	DeathBody[PlayerCarry_DeathBody[playerid]][DEATH_BODY_OBJ] = CreateObject(3092, DeathBody[PlayerCarry_DeathBody[playerid]][DEATH_BODY_X],DeathBody[PlayerCarry_DeathBody[playerid]][DEATH_BODY_Y],DeathBody[PlayerCarry_DeathBody[playerid]][DEATH_BODY_Z]  + DEATH_BODY_OFFSET, 90.0, 90.0, 90.0);
		//
	   	RemovePlayerAttachedObject(playerid,SLOT_CARRY);
	   	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
	   	//
	   	//
	   	PlayerCarry_DeathBody[playerid] = -1;
   	} else SendClientMessage(playerid,-1,DEATH_BODY_NO_BODY);
}
/*COMMANDS -------------------------------------------------------------------*/
public OnPlayerCommandText(playerid, cmdtext[])
{
	/*
		Create a normal death body (60 sec expire)
	*/
    if(strcmp(cmdtext,"/TestDeathBody",true) == 0)
    {
        new Float:POS[3];
        GetPlayerPos(playerid,POS[0],POS[1],POS[2]);
        CreateDeathBody(POS[0],POS[1],POS[2]);
        return 1;
    }
   	/*
		Create a timed death body (5 sec expire)
	*/
    if(strcmp(cmdtext,"/TestDeathBody5",true) == 0)
    {
        new Float:POS[3];
        GetPlayerPos(playerid,POS[0],POS[1],POS[2]);
        CreateDeathBody(POS[0],POS[1],POS[2],5);//Check CreateDeathBody function
        return 1;
    }
   	/*
		Pickup the death body from the ground
	*/
    if(strcmp(cmdtext,"/pickupbody",true) == 0)
    {
        PickupDeathBody(playerid);
        return 1;
    }
   	/*
		Drop the death body in the ground and the timing for exipre will start again
	*/
    if(strcmp(cmdtext,"/dropbody",true) == 0)
    {
    	DropDeathBody(playerid);
        return 1;
    }
	return 0;
}