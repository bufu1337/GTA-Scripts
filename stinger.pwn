#include <a_samp>

//#define ALLOWED_PICKUPS 350 // Uncomment this if you know that you will never reach 2048 pickups.

#if defined ALLOWED_PICKUPS
	new iPickups[ALLOWED_PICKUPS][5];
#else
	new iPickups[MAX_PICKUPS][5];
#endif

forward DestroyStinger(stingerid);

public OnFilterScriptInit()
{
	print(" >>> Spike Strips loaded.");
	for(new i = 0; i < sizeof(iPickups); i++){
		iPickups[i][0] = -1;
		iPickups[i][1] = -1;
		iPickups[i][2] = -1;
		iPickups[i][3] = -1;
		iPickups[i][4] = -1;
	}
	return 1;
}

public OnFilterScriptExit()
{
	for(new i = 0; i < sizeof(iPickups); i++){
	    DestroyObject(iPickups[i][0]);
        DestroyPickup(iPickups[i][1]);
        DestroyPickup(iPickups[i][2]);
        DestroyPickup(iPickups[i][3]);
        DestroyPickup(iPickups[i][4]);
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/stinger", cmdtext, true, 8) == 0)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    if(vehicleid == 0){

		    new Float:X, Float:Y, Float:Z, Float:A;
		    GetPlayerPos(playerid, X, Y, Z);
		    GetPlayerFacingAngle(playerid, A);
			CreateSmallStinger(X+(6.0*floatsin(-A, degrees)), Y+(6.0*floatcos(-A, degrees)), Z-0.825, A, GetPlayerVirtualWorld(playerid), 60000);
		}
	    else{
		    new Float:X, Float:Y, Float:Z, Float:A;
		    GetVehiclePos(vehicleid, X, Y, Z);
		    GetVehicleZAngle(vehicleid, A);
			CreateLargeStinger(X-(10.0*floatsin(-A, degrees)), Y-(10.0*floatcos(-A, degrees)), Z-0.325, A, GetPlayerVirtualWorld(playerid), 60000);
	    }
	    return 1;
	}
	if (strcmp("/destroystinger", cmdtext, true, 15) == 0)
	{
	    new Float:X, Float:Y, Float:Z;
	    for(new stingerid = 0; stingerid < sizeof(iPickups); stingerid++){
	        if(iPickups[stingerid][0] == -1)
	            continue;
	       
	        GetObjectPos(iPickups[stingerid][0], X, Y, Z);
	        if(IsPlayerInRangeOfPoint(playerid, 3.0, X, Y, Z)){
	            DestroyStinger(stingerid);
	            break;
	        }
	    }
	    return 1;
	}
	return 0;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
    for(new stingerid = 0; stingerid < sizeof(iPickups); stingerid++){
    	if(pickupid == iPickups[stingerid][1]){
		    new Float:X, Float:Y, Float:Z, Float:A;
		    GetObjectPos(iPickups[stingerid][0], X, Y, Z);
		    GetObjectRot(iPickups[stingerid][0], A, A, A);
		    new Float:dis1 = floatsin(-A, degrees), Float:dis2 = floatcos(-A, degrees);
	        PopPlayerTires(playerid);
	        DestroyPickup(pickupid);
    	    if(iPickups[stingerid][3] == -1){ // Small Stinger
    	        iPickups[stingerid][1] = CreatePickup(1007, 14, X+(1.5*dis1), Y+(1.5*dis2), Z, GetPlayerVirtualWorld(playerid));
    	    }
    	    else{ // Large Stinger
				iPickups[stingerid][1] = CreatePickup(1007, 14, X+(4.0*dis1), Y+(4.0*dis2), Z, GetPlayerVirtualWorld(playerid));
    	    }
    	    break;
    	}
    	else if(pickupid == iPickups[stingerid][2]){
	    	new Float:X, Float:Y, Float:Z, Float:A;
		    GetObjectPos(iPickups[stingerid][0], X, Y, Z);
		    GetObjectRot(iPickups[stingerid][0], A, A, A);
		    new Float:dis1 = floatsin(-A, degrees), Float:dis2 = floatcos(-A, degrees);
	        PopPlayerTires(playerid);
	        DestroyPickup(pickupid);
    	    if(iPickups[stingerid][3] == -1){ // Small Stinger
    	        iPickups[stingerid][2] = CreatePickup(1007, 14, X-(1.5*dis1), Y-(1.5*dis2), Z, GetPlayerVirtualWorld(playerid));
    	    }
    	    else{ // Large Stinger
				iPickups[stingerid][2] = CreatePickup(1007, 14, X+(1.25*dis1), Y+(1.25*dis2), Z, GetPlayerVirtualWorld(playerid));
    	    }
    	    break;
    	}
    	else if(pickupid == iPickups[stingerid][3]){
		    new Float:X, Float:Y, Float:Z, Float:A;
		    GetObjectPos(iPickups[stingerid][0], X, Y, Z);
		    GetObjectRot(iPickups[stingerid][0], A, A, A);
		    new Float:dis1 = floatsin(-A, degrees), Float:dis2 = floatcos(-A, degrees);
	        PopPlayerTires(playerid);
	        DestroyPickup(pickupid);
			iPickups[stingerid][3] = CreatePickup(1007, 14, X-(4.0*dis1), Y-(4.0*dis2), Z, GetPlayerVirtualWorld(playerid));
    	    break;
    	}
    	else if(pickupid == iPickups[stingerid][4]){
		    new Float:X, Float:Y, Float:Z, Float:A;
		    GetObjectPos(iPickups[stingerid][0], X, Y, Z);
		    GetObjectRot(iPickups[stingerid][0], A, A, A);
		    new Float:dis1 = floatsin(-A, degrees), Float:dis2 = floatcos(-A, degrees);
	        PopPlayerTires(playerid);
	        DestroyPickup(pickupid);
			iPickups[stingerid][4] = CreatePickup(1007, 14, X-(1.25*dis1), Y-(1.25*dis2), Z, GetPlayerVirtualWorld(playerid));
    	    break;
    	}
    }
	return 1;
}

stock PopPlayerTires(playerid){
	new vehicleid = GetPlayerVehicleID(playerid);
	if(vehicleid != 0){
		new panels, doors, lights, tires;
		GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
		UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 15);
	}
}

stock CreateLargeStinger(Float:X, Float:Y, Float:Z, Float:A, virtualworld, timer){
	for(new stingerid = 0; stingerid < sizeof(iPickups); stingerid++){
		if(iPickups[stingerid][0] == -1){
		    new Float:dis1 = floatsin(-A, degrees), Float:dis2 = floatcos(-A, degrees);
			iPickups[stingerid][0] = CreateObject(2892, X, Y, Z, 0.0, 0.0, A);
			iPickups[stingerid][1] = CreatePickup(1007, 14, X+(4.0*dis1), Y+(4.0*dis2), Z, virtualworld);
			iPickups[stingerid][2] = CreatePickup(1007, 14, X+(1.25*dis1), Y+(1.25*dis2), Z, virtualworld);
			iPickups[stingerid][3] = CreatePickup(1007, 14, X-(4.0*dis1), Y-(4.0*dis2), Z, virtualworld);
			iPickups[stingerid][4] = CreatePickup(1007, 14, X-(1.25*dis1), Y-(1.25*dis2), Z, virtualworld);
			if(timer > 0){
				SetTimerEx("DestroyStinger", timer, 0, "i", stingerid);
			}
			return stingerid;
		}
	}
	return -1;
}

stock CreateSmallStinger(Float:X, Float:Y, Float:Z, Float:A, virtualworld, timer){
	for(new stingerid = 0; stingerid < sizeof(iPickups); stingerid++){
		if(iPickups[stingerid][0] == -1){
		    new Float:dis1 = floatsin(-A, degrees), Float:dis2 = floatcos(-A, degrees);
			iPickups[stingerid][0] = CreateObject(2899, X, Y, Z, 0.0, 0.0, A);
			iPickups[stingerid][1] = CreatePickup(1007, 14, X+(1.5*dis1), Y+(1.5*dis2), Z, virtualworld);
			iPickups[stingerid][2] = CreatePickup(1007, 14, X-(1.5*dis1), Y-(1.5*dis2), Z, virtualworld);
			if(timer > 0){
				SetTimerEx("DestroyStinger", timer, 0, "i", stingerid);
			}
			return stingerid;
		}
	}
	return -1;
}

public DestroyStinger(stingerid){
	DestroyObject(iPickups[stingerid][0]);
	DestroyPickup(iPickups[stingerid][1]);
	DestroyPickup(iPickups[stingerid][2]);
	DestroyPickup(iPickups[stingerid][3]);
	DestroyPickup(iPickups[stingerid][4]);
	iPickups[stingerid][0] = -1;
	iPickups[stingerid][1] = -1;
	iPickups[stingerid][2] = -1;
	iPickups[stingerid][3] = -1;
	iPickups[stingerid][4] = -1;
}
