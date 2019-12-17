//AI Blinkers by Kinetic
#include <a_samp>
#include <a_players>

//----[Quick Stats]-------------------------------------------------------------
#define timerspeed  500                 //Speed of the timer in milliseconds (1000 = 1 second)
#define blinkerduration 10				//Length of the duration that the blinker will stay on in seconds.
#define rightkey	KEY_LOOK_RIGHT      //The key you press to turn the right blinker on
#define leftkey		KEY_LOOK_LEFT		//The key you press to turn the left blinker on
//------------------------------------------------------------------------------

// PRESSED(newkeys, oldkeys, keys)
#define PRESSED(%0,%1,%2) \
	((((%0) & (%2)) == (%2)) && (((%1) & (%2)) != (%2)))

new tmpcar;
new arrow[MAX_PLAYERS];
new Step[MAX_PLAYERS];
new blinks[MAX_PLAYERS];
new duration[MAX_PLAYERS];
new blinker[MAX_PLAYERS];
new Float:tmpx[MAX_PLAYERS],Float:tmpy[MAX_PLAYERS],Float:tmpz[MAX_PLAYERS],Float:tmpang[MAX_PLAYERS];
new Float:startang[MAX_PLAYERS];

forward Blinker(playerid);

public OnFilterScriptExit()
{
	for(new i=0; i<=GetMaxPlayers(); i++)
	{
	    KillTimer(blinks[i]);
	    DestroyObject(arrow[i]);
	}
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(newkeys, oldkeys, rightkey))
	{
	    if(blinker[playerid] != 1)
	    {
		    KillTimer(blinks[playerid]);
			blinks[playerid] = SetTimerEx("Blinker", timerspeed, true,"%i",playerid);
	    	//blinks[playerid] = SetTimer("Blinker", timerspeed, true);
	    	GetPlayerFacingAngle(playerid, startang[playerid]);
	    	blinker[playerid] = 1;
	    	return 1;
		}
	    if(blinker[playerid] == 1)
	    {
		    KillTimer(blinks[playerid]);
		    DestroyObject(arrow[playerid]);
	    	blinker[playerid] = 0;
	    	GetPlayerFacingAngle(playerid, startang[playerid]);
			duration[playerid] = 0;
	    	return 1;
		}
	}
	if(PRESSED(newkeys, oldkeys, leftkey))
	{
	    if(blinker[playerid] != 2)
	    {
		    KillTimer(blinks[playerid]);
			blinks[playerid] = SetTimerEx("Blinker", timerspeed, true,"%i",playerid);
	    	//blinks[playerid] = SetTimer("Blinker", timerspeed, true);
	    	blinker[playerid] = 2;
	    	return 1;
		}
	    if(blinker[playerid] == 2)
	    {
		    KillTimer(blinks[playerid]);
		    DestroyObject(arrow[playerid]);
	    	blinker[playerid] = 0;
			duration[playerid] = 0;
	    	return 1;
		}
	}
	return 1;
}

public Blinker(playerid)
{
	if(duration[playerid] >= blinkerduration)
	{
	    KillTimer(blinks[playerid]);
	    DestroyObject(arrow[playerid]);
	    duration[playerid] = 0;
	    return 1;
	}
	if(blinker[playerid] == 0)
	{
	    KillTimer(blinks[playerid]);
	    DestroyObject(arrow[playerid]);
	    duration[playerid] = 0;
	    return 1;
	}
	if(blinker[playerid] == 1)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        tmpcar = GetPlayerVehicleID(playerid);
		    GetVehiclePos(tmpcar, tmpx[playerid], tmpy[playerid], tmpz[playerid]);
		    GetVehicleZAngle(tmpcar, tmpang[playerid]);
	        if(Step[playerid] == 0)
	        {
		        arrow[playerid] = CreateObject(1318, tmpx[playerid], tmpy[playerid], tmpz[playerid]+0.7, 90, tmpang[playerid]+89, 180);
				AttachObjectToPlayer(arrow[playerid], playerid, 0, 0, 1.7, 90, 89, 180);
//	    		GameTextForPlayer(playerid, "~g~>>>", 300, 4);
	    		Step[playerid] = 1;
	    		return 1;
			}
			if(Step[playerid] == 1)
			{
				duration[playerid]++;
			    DestroyObject(arrow[playerid]);
	    		Step[playerid] = 0;
			    return 1;
			}
		}
	}
	if(blinker[playerid] == 2)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        tmpcar = GetPlayerVehicleID(playerid);
		    GetVehiclePos(tmpcar, tmpx[playerid], tmpy[playerid], tmpz[playerid]);
		    GetVehicleZAngle(tmpcar, tmpang[playerid]);
	        if(Step[playerid] == 0)
	        {
		        arrow[playerid] = CreateObject(1318, tmpx[playerid], tmpy[playerid], tmpz[playerid]+0.7, 90, tmpang[playerid]-89, 180);
				AttachObjectToPlayer(arrow[playerid], playerid, 0, 0, 1.7, 90, 269, 180);
//	    		GameTextForPlayer(playerid, "~g~<<<", 300, 4);
	    		Step[playerid] = 1;
	    		return 1;
			}
			if(Step[playerid] == 1)
			{
				duration[playerid]++;
			    DestroyObject(arrow[playerid]);
	    		Step[playerid] = 0;
			    return 1;
			}
		}
	}
	return 1;
}