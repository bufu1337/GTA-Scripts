#include <a_samp>
#include zcmd
#include sscanf2

/* --------------------------------------------------
    _______ __  __ _____  _____   _______ _______
   [ __   ][ ] [ ][ ___] [ __ ]  [ _____][__  __]
  [ [ ]  ][ ] [ ][ [    [ [_] ] [___  ]    [ ]
 [ [_]  ][ ]_[ ][ [___ [ ____ ] ___[ ]    [ ]
[______][_____][_____][_]   [_][____]    [_]

   --------------------------------------------------
> COMMANDS LIST:
 - /stretcher - spawns them or de-spawns and loads the patient in the ambulance
 - /dropstretcher - stop pushing/pulling the stretcher
 - /pickupstretcher - pick up the stretcher
 - /loadstretcher - put the patient onto the stretcher
 - /unloadstretcher - removes a person from the stretcher
 - /removestretcher - alternative to /stretcher
 - /getoffstretcher - get off from the stretcher
*/


// Global variables
new bool:UsingStretcher[MAX_PLAYERS]; // To check if the player is pushing the stretcher or not
new bool:StretcherSpawned[MAX_PLAYERS]; // To check if player has spawned a stretcher or not
new bool:StretcherLoaded[MAX_PLAYERS]; // To check if there's a patient on the stretcher
new bool:Loaded2Stretcher[MAX_PLAYERS]; // To check from the patient's side if he's loaded on someone's stretcher
new PatientID[MAX_PLAYERS] = 0; // To check the patient's ID, so I can know if that player is connected
new MedicID[MAX_PLAYERS] = 0; // To check the medic's ID, so I can know if he's connected
new Stretcher[MAX_PLAYERS] = 0; // This is an object ID of the stretcher
// end of global variables

forward SpawnStretcher(playerid);

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" [Usable stretcher for medics] by Outcast");
	print("      Build 1.0 - May 1st, 2011.");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
    print("\n--------------------------------------");
	print(" Movable stretcher filterscript ... unloaded");
	print("--------------------------------------\n");
	return 1;
}

public OnPlayerConnect(playerid)
{
	StretcherLoaded[playerid] = false;
	UsingStretcher[playerid] = false;
	PatientID[MedicID[playerid]] = -50;
	MedicID[PatientID[playerid]] = -50;
	MedicID[playerid] = -50;
	PatientID[playerid] = -50;
	Stretcher[playerid] = -50;
	Loaded2Stretcher[playerid] = false;
	StretcherSpawned[playerid] = false;
	return ;
}

public OnPlayerDisconnect(playerid)
{
	DestroyObject(Stretcher[playerid]);
	StretcherLoaded[playerid] = false;
	UsingStretcher[playerid] = false;
	PatientID[MedicID[playerid]] = -50;
	MedicID[PatientID[playerid]] = -50;
	MedicID[playerid] = -50;
	PatientID[playerid] = -50;
	Stretcher[playerid] = -50;
	Loaded2Stretcher[playerid] = false;
	StretcherSpawned[playerid] = false;
	return ;
}

public OnPlayerUpdate(playerid)
{
	if(StretcherLoaded[playerid] == true && UsingStretcher[playerid] == true)
	{
	    if(IsPlayerConnected(PatientID[playerid]))
		{
		    new Float:X, Float:Y, Float:Z, Float:R;
		    GetPlayerPos(playerid, X, Y, Z);
			GetPlayerFacingAngle(playerid, R);
			GetXYBehindThePlayer(playerid, X, Y, 2);
			SetPlayerPos(PatientID[playerid], X, Y, Z + 0.60);
			SetPlayerFacingAngle(PatientID[playerid], R);
			SetCameraBehindPlayer(PatientID[playerid]);
			return 1;
		}
	    else
	    {
	        StretcherLoaded[playerid] = false;
	        PatientID[playerid] = -50;
	        return 1;
	    }
	}

	if(Loaded2Stretcher[playerid] == true && !IsPlayerConnected(MedicID[playerid]))
	{
	    TogglePlayerControllable(playerid, 1);
		Loaded2Stretcher[playerid] = false;
		MedicID[playerid] = -50;
		return 1;
	}
	else return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(UsingStretcher[playerid] == true)
    {
    	VehicleStop(playerid);
    	SendClientMessage(playerid,0xFFFFFF, "You can't enter a vehicle if you're using a stretcher (/dropstretcher)");
    	return 1;
    }
	return 1;
}

// FILTERSCRIPT COMMANDS START HERE...
// -- for spawning a stretcher
CMD:stretcher(playerid) // To spawn a stretcher inside an ambulance
{
	new Float:X, Float:Y, Float:Z, msg[100];
	GetObjectPos(Stretcher[playerid], X, Y, Z);
	if(Loaded2Stretcher[playerid] == true) return SendClientMessage(playerid, 0xFFFFFF, "ERROR: Can't do that while being on a stretcher");
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 416)
	{
	    if(GetPlayerVehicleSeat(playerid) == 2 || GetPlayerVehicleSeat(playerid) == 3)
	    {
	        if(StretcherSpawned[playerid] == false && UsingStretcher[playerid] == false)
	        {

	            RemovePlayerFromVehicle(playerid);
	            SetTimerEx("SpawnStretcher", 1500, false, "i", playerid);
	            GameTextForPlayer(playerid, "Stretcher pulled out", 200, 1);
	            GetPlayerName(playerid, msg, sizeof(msg));
        		format(msg, sizeof(msg), " * %s pulled out a stretcher from the ambulance.", msg);
   				SendNearByMessage(10.00, playerid, 0xC2A2DAAA, msg);
				return 1;

	        }
	        else if(UsingStretcher[playerid] == false && StretcherSpawned[playerid] == true && StretcherLoaded[playerid] == true)
			{
	            DestroyObject(Stretcher[playerid]);
	            if(IsPlayerInRangeOfPoint(playerid, 10.0, X, Y, Z) == 0) return SendClientMessage(playerid, 0xFFFFFF, "ERROR: Stretcher too far from ambulance");
	            if(GetPlayerVehicleSeat(playerid) == 2)
	            {
	            	PutPlayerInVehicle(PatientID[playerid], GetPlayerVehicleID(playerid),3);
	            	TogglePlayerControllable(PatientID[playerid], 1);
	            	StretcherLoaded[playerid] = false; // sets all the variables to false
					UsingStretcher[playerid] = false;
					GameTextForPlayer(PatientID[playerid], "You have been loaded into the ambulance", 200, 1);
					PatientID[playerid] = -50;
					MedicID[PatientID[playerid]] = -50;
					MedicID[playerid] = -50;
					PatientID[playerid] = -50;
					Stretcher[playerid] = -50;
					Loaded2Stretcher[playerid] = false;
					StretcherSpawned[playerid] = false;
					GameTextForPlayer(playerid, "Stretcher and patient loaded into Ambulance", 200, 1);
					format(msg, sizeof(msg), " * %s put the stretcher and the patient in the ambulance.", msg);
   					SendNearByMessage(10.00, playerid, 0xC2A2DAAA, msg);
					return 1;
	            }
				else if(GetPlayerVehicleSeat(playerid) == 3)
				{
				    PutPlayerInVehicle(PatientID[playerid], GetPlayerVehicleID(playerid),2);
                    TogglePlayerControllable(PatientID[playerid], 1);
                    StretcherLoaded[playerid] = false; // sets all the variables to false
					UsingStretcher[playerid] = false;
					GameTextForPlayer(PatientID[playerid], "You have been loaded into the ambulance", 200, 1);
					PatientID[playerid] = -50;
					MedicID[PatientID[playerid]] = -50;
					MedicID[playerid] = -50;
					PatientID[playerid] = -50;
					Stretcher[playerid] = -50;
					Loaded2Stretcher[playerid] = false;
					StretcherSpawned[playerid] = false;
					GameTextForPlayer(playerid, "Stretcher and patient loaded into Ambulance", 200, 1);
				}
				else return SendClientMessage(playerid, 0xFFFFFF, "ERROR: You are not in the back of the Ambulance");

	        }
	        else if(UsingStretcher[playerid] == false && StretcherSpawned[playerid] == true && StretcherLoaded[playerid] == false)
	        {
	            if(IsPlayerInRangeOfPoint(playerid, 10.0, X, Y, Z) == 0) return SendClientMessage(playerid, 0xFFFFFF, "ERROR: Stretcher too far from ambulance");
	            DestroyObject(Stretcher[playerid]);
	            GameTextForPlayer(playerid, "Stretcher loaded into Ambulance", 200, 1);
	            StretcherLoaded[playerid] = false;
				UsingStretcher[playerid] = false;
				Stretcher[playerid] = -500;
				Loaded2Stretcher[playerid] = false;
				StretcherSpawned[playerid] = false;
	        }
	    }
	    else return SendClientMessage(playerid, 0xFFFFFF, "ERROR: You are not in the back of the Ambulance");
	}
	else return SendClientMessage(playerid, 0xFFFFFF, "ERROR: You are not in an Ambulance");
	return 1;
}

public SpawnStretcher(playerid) // USED FOR: Spawning a stretcher after a Timed delay
{
	new Float:X, Float:Y, Float:Z, Float:R;
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, R);
	SetPlayerFacingAngle(playerid, R + 180); // To face the player opposite from the Ambulance
	Stretcher[playerid] =CreateObject(2146, X, Y, Z, 0, 0, 0, 75.0); // Creating an object to attach
	AttachObjectToPlayer(Stretcher[playerid], playerid, 0.00, 1.70, -0.50, 0.0, 0.0, 0.0);
	UsingStretcher[playerid] = true; // Setting variables that I can check later
	StretcherSpawned[playerid] = true;
	return 1;
}
// -- done with spawning a stretcher

CMD:dropstretcher(playerid) // to stop controlling a stretcher
{
    new Float:X, Float:Y, Float:Z, Float:R;
    if(Loaded2Stretcher[playerid] == true) return SendClientMessage(playerid, 0xFFFFFF, "ERROR: Can't do that while being on a stretcher");
   	if(UsingStretcher[playerid] == false) return SendClientMessage(playerid, 0xFFFFFF, "ERROR: You are not using a stretcher");
    GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, R);
	DestroyObject(Stretcher[playerid]); // Destroys the attached object
	if(StretcherLoaded[playerid] == false)
	{
	    GetXYInFrontOfPlayer(playerid, X, Y, 1.70);
		Stretcher[playerid] = CreateObject(2146, X, Y, Z - 0.50, 0, 0, R, 75.0); // Creates a new object on the last known co-ords.
        UsingStretcher[playerid] = false; // Sets a condition that the player is not pushing the stretcher
	}
	else // If there's a patient on it and it's being pulled, not pushed.
	{
	    GetXYBehindThePlayer(playerid, X, Y, 1.70);
	    Stretcher[playerid] = CreateObject(2146, X, Y, Z - 0.50, 0, 0, R, 75.0);
	    UsingStretcher[playerid] = false; // Sets a condition that the player is not pushing the stretcher
	}
	return 1;
}

CMD:pickupstretcher(playerid)
{
    new Float:X, Float:Y, Float:Z;
    if(Loaded2Stretcher[playerid] == true) return SendClientMessage(playerid, 0xFFFFFF, "ERROR: Can't do that while being on a stretcher");
    if(UsingStretcher[playerid] == true) return SendClientMessage(playerid, 0xFFFFFF, "ERROR: You can't use more stretchers (/dropstretcher)");
    for(new i=0; i < 500; i++) // to take someone else's stretcher
    {
    	GetObjectPos(Stretcher[i], X, Y, Z);
    	if(IsPlayerInRangeOfPoint(playerid, 5.0, X, Y, Z) && UsingStretcher[playerid] == false && UsingStretcher[i] == false)
    	{
			if(StretcherLoaded[i] == true && i != playerid) // if there's a patient on the stretchers
			{
        		UsingStretcher[playerid] = true; // change the variables to another player
        		StretcherSpawned[playerid] = true;
        		MedicID[PatientID[i]] = playerid;
        		PatientID[playerid] = PatientID[i];
          		PatientID[i] = -50;
        		StretcherSpawned[i] = false;
        		StretcherLoaded[i] = false;
        		Stretcher[playerid] = Stretcher[i];
          		Stretcher[i] = -50;
        		AttachObjectToPlayer(Stretcher[playerid], playerid, 0.00, -1.70, -0.50, 0.0, 0.0, 0.0);
        		return 1;

        	}
        	else if(StretcherLoaded[i] == false && i != playerid) // if it's empty
        	{
	 			UsingStretcher[playerid] = true; // change the variables to another player
	 			StretcherSpawned[playerid] = true;
        		StretcherSpawned[i] = false;
        		StretcherLoaded[i] = false;
        		Stretcher[playerid] = Stretcher[i];
        		AttachObjectToPlayer(Stretcher[playerid], playerid, 0.00, 1.70, -0.50, 0.0, 0.0, 0.0);
        		Stretcher[i] = -50;
        		return 1;
        	}
        	// added
        	// if you're picking up your own stretcher, not someone elses
        	else if(StretcherLoaded[i] == true && i == playerid) // if there's a patient on the stretchers
			{
        		UsingStretcher[playerid] = true;
        		AttachObjectToPlayer(Stretcher[playerid], playerid, 0.00, -1.70, -0.50, 0.0, 0.0, 0.0);
        		return 1;
        	}
        	else if(StretcherLoaded[i] == false && i == playerid) // if it's empty
        	{
	 			UsingStretcher[playerid] = true;
        		AttachObjectToPlayer(Stretcher[playerid], playerid, 0.00, 1.70, -0.50, 0.0, 0.0, 0.0);
        		return 1;
        	}
    	}
    }
    return SendClientMessage(playerid, 0xFFFFFF, "ERROR: You are not near a stretcher");
}

CMD:loadstretcher(playerid, params[])
{
	new id, Float:X, Float:Y, Float:Z, msg[100], msg2[30];
	if(Loaded2Stretcher[playerid] == true) return SendClientMessage(playerid, 0xFFFFFF, "ERROR: Can't do that while being on a stretcher");
	if(sscanf(params, "i", id)) return SendClientMessage(playerid, 0xFFFFFF, "Usage: /loadstretcher [Player ID]");
	if(id == playerid) return SendClientMessage(playerid, 0xFFFFFF, "ERROR: You can't load yourself onto the stretcher");
	if(StretcherLoaded[playerid] == true) return SendClientMessage(playerid, 0xFFFFFF, "ERROR: You already have a person loaded onto the strether");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, 0xFFFFFF, "ERROR: That player is not connected");
	if(UsingStretcher[playerid] == false || StretcherSpawned[playerid] == false) return SendClientMessage(playerid, 0xFFFFFF, "ERROR: You don't have a stretcher, or you are not using it");

	GetPlayerPos(id, X, Y, Z);
	if(IsPlayerInRangeOfPoint(playerid, 7.0, X, Y, Z))
    {
        if(IsPlayerInAnyVehicle(id) == 1) return SendClientMessage(playerid, 0xFFFFFF, "ERROR: That player is in a vehicle");
        StretcherLoaded[playerid] = true;
        MedicID[id] = playerid;
		PatientID[playerid] = id;
		TogglePlayerControllable(id, 0);
		Loaded2Stretcher[id] = true;

		DestroyObject(Stretcher[playerid]);
		GetPlayerPos(playerid, X, Y, Z);
		Stretcher[playerid] = CreateObject(2146, X, Y, Z - 0.50, 0, 0, 0, 75.0);
        AttachObjectToPlayer(Stretcher[playerid], playerid, 0.00, -1.70, -0.50, 0.0, 0.0, 0.0);
        GetPlayerName(playerid, msg, sizeof(msg));
        format(msg, sizeof(msg), " * %s put %s on the stretcher.", msg, GetPlayerName(PatientID[playerid], msg2, sizeof(msg2)));
   		SendNearByMessage(10.00, playerid, 0xC2A2DAAA, msg);
        return 1;
    }
    else return SendClientMessage(playerid, 0xFFFFFF, "ERROR: That player is too far to be loaded onto the stretcher");
}

CMD:removestretcher(playerid)
{
	new Float:X, Float:Y, Float:Z;
	if(Loaded2Stretcher[playerid] == true) return SendClientMessage(playerid, 0xFFFFFF, "ERROR: Can't do that while being on a stretcher");
    if(UsingStretcher[playerid] == true) return SendClientMessage(playerid, 0xFFFFFF, "ERROR: You can't remove a stretcher while using it (/dropstretcher)");
    for(new i=0; i < 200; i++) // to take someone else's stretcher
    {
    	GetObjectPos(Stretcher[i], X, Y, Z);
    	if(StretcherLoaded[i] == true) return SendClientMessage(playerid, 0xFFFFFF, "ERROR: You can't remove a stretcher with a patient on it (/unloadstretcher)");
    	if(IsPlayerInRangeOfPoint(playerid, 5.0, X, Y, Z) && UsingStretcher[playerid] == false && UsingStretcher[i] == false)
    	{
			DestroyObject(Stretcher[i]);
			Stretcher[i] = -50;
			StretcherSpawned[i] = false;
			GameTextForPlayer(playerid, "Stretchers removed", 200, 1);
			return 1;
		}
	}
	return 1;
}

CMD:unloadstretcher(playerid)
{
	new Float:X, Float:Y, Float:Z, Float:R, msg[100], msg2[30];
	if(Loaded2Stretcher[playerid] == true) return SendClientMessage(playerid, 0xFFFFFF, "ERROR: Can't do that while being on a stretcher");
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, R);
	GetXYInFrontOfPlayer(playerid, X, Y, 3);
    SetPlayerPos(PatientID[playerid], X, Y, Z + 1.80);
    SetPlayerFacingAngle(PatientID[playerid], R);
    TogglePlayerControllable(PatientID[playerid], 1);
    GetPlayerName(PatientID[playerid], msg, sizeof(msg));
    format(msg, sizeof(msg), "You have removed %s from the stretcher.", msg);
    SendClientMessage(playerid, 0xFFFFFF, msg);
    GetPlayerName(playerid, msg, sizeof(msg));
    format(msg, sizeof(msg), "You have been removed from the stretcher by %s.", msg);
    SendClientMessage(PatientID[playerid], 0xFFFFFF, msg);
    format(msg, sizeof(msg), " * %s removed %s from the stretcher.", msg, GetPlayerName(PatientID[playerid], msg2, sizeof(msg2)));
   	SendNearByMessage(10.00, playerid, 0xC2A2DAAA, msg);
	MedicID[PatientID[playerid]] = -50;
	PatientID[playerid] = -50;
	return 1;
}

CMD:getoffstretcher(playerid)
{
	if(Loaded2Stretcher[playerid] == true)
	{
		new Float:X, Float:Y, Float:Z, Float:R, msg[100];
		GetPlayerPos(playerid, X, Y, Z);
		GetPlayerFacingAngle(playerid, R);
		GetXYInFrontOfPlayer(playerid, X, Y, 3);
    	SetPlayerPos(playerid, X, Y, Z + 1.80);
    	SetPlayerFacingAngle(PatientID[playerid], R);
    	TogglePlayerControllable(playerid, 1);

    	GetPlayerName(playerid, msg, sizeof(msg));
    	format(msg, sizeof(msg), " * %s got off from the stretcher.", msg);
    	SendNearByMessage(10.00, playerid, 0xC2A2DAAA, msg);

    	SendClientMessage(playerid, 0xFFFFFF, "You got off from the stretcher.");

		PatientID[MedicID[playerid]] = -50;
		MedicID[playerid] = -50;
		return 1;
	}
	else return SendClientMessage(playerid, 0xFFFFFF, "ERROR: You are not on the stretcher");

}

stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	if (GetPlayerVehicleID(playerid))
	{
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

stock GetXYBehindThePlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	if (GetPlayerVehicleID(playerid))
	{
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	x -= (distance * floatsin(-a, degrees));
	y -= (distance * floatcos(-a, degrees));
}

stock SendNearByMessage(Float:distance, playerid, color, message[100])
{
	new Float:X, Float:Y, Float:Z;
	for(new i=0; i < 500; i++)
    {
		GetPlayerPos(playerid, X, Y, Z);
		if(IsPlayerInRangeOfPoint(i, distance, X, Y, Z))
		{
		    SendClientMessage(i, color, message);
		}
    }
    return 1;
}

stock VehicleStop(playerid)
{
   new Float:x, Float:y, Float:z;
   GetPlayerPos(playerid, x, y, z);
   SetPlayerPos(playerid,x,y,z);
}

// To spawn an ambulance - for testing uncomment this part.
/*CMD:amb(playerid)
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	CreateVehicle(416, X, Y, Z, 0, 1, 1, 0);
	return 1;
}*/