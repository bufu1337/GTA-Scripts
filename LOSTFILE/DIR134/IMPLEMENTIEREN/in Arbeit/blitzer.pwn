
#include <a_samp>
// Credits: Peter <3 && Antironix for adding Speeding Limit
// Tekst: Well i didn't care what speedo meter i toke, but the other one didn't worked.
// I just wanted to make the flitspaal and not the speedo meter.
// Thx

//----------------------------------------
new UpdateSeconds = 1; // How frequent do you want it to be updated?
new maxobject = 2; //define how many "flitspalen" you have
//----------------------------------------

public OnFilterScriptInit() {
print("\n----------------------------------");
print("Filterscript Speeding control loaded");
print("----------------------------------\n");
SetTimer("UpdateSpeed", UpdateSeconds*1000, 1);
}

public OnFilterScriptExit() {
print("\n----------------------------------");
print("Filterscript Speeding control un-loaded");
print("----------------------------------\n");
}
forward UpdateSpeed(playerid);
enum SavePlayerPosEnum {
Float:LastX,
Float:LastY,
Float:LastZ
}
#define COLOR_YELLOW 0xFFFF00AA
#define SLOTS 200

new objectcreated;
new SavePlayerPos[SLOTS][SavePlayerPosEnum];
new distance1[MAX_PLAYERS];


public UpdateSpeed(playerid)
{
	new Float:x,Float:y,Float:z;
	new Float:distance,value;
	for(new i=0; i<SLOTS; i++)
	{
		if(IsPlayerConnected(i))
		{
			GetPlayerPos(i, x, y, z);
			distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
    		// Distance: meters in the last second
			value = floatround(distance * 3600);
			if(UpdateSeconds > 1)
			{
				value = floatround(value / UpdateSeconds);
			}
			distance1[i] = floatround(value/1600);

			SavePlayerPos[i][LastX] = x;
			SavePlayerPos[i][LastY] = y;
			SavePlayerPos[i][LastZ] = z;

        	AddFlitsPaal(i, 1278, 2077.5579,1013.2529,10.8203, 20, 100);
        	AddFlitsPaal(i, 1278, 2078.9189,1235.0403,10.3865, 20, 40);
		} // End is-player-connected
	} // End for-loop
} // eind UpdateSpeed function



public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    return 1;
}


public OnPlayerExitVehicle(playerid, vehicleid)
{
   return 1;
}

IsPlayerInCircle(playerid,Float:x,Float:y,radius)
{
    if(GetPlayerDistanceToPoint(playerid,Float:x,Float:y) < radius)
    {
    	return 1;
    }
    return 0;
}

GetPlayerDistanceToPoint(playerid,Float:x,Float:y)
{
    new Float:x1,Float:y1,Float:z1; GetPlayerPos(playerid,x1,y1,z1);
    new Float:tmpdis = floatsqroot(floatpower(floatabs(floatsub(x,x1)),2)+
    floatpower(floatabs(floatsub(y,y1)),2));
    return floatround(tmpdis);
}

stock AddFlitsPaal(playerid, modelid, Float:xx, Float:yy, Float:zz, radius, speed)
{
	new fine[MAX_PLAYERS];
 	new str[256];

 	if(objectcreated!=maxobject)
  	{
    	CreateObject(modelid, xx, yy, zz, 0.0, 0.0, 10);
     	objectcreated++;
  	}
  	if((distance1[playerid])>speed)
  	{
		if(IsPlayerInCircle(playerid, xx, yy, radius)  && GetPlayerState(playerid)== PLAYER_STATE_DRIVER)
		{
			fine[playerid]=((distance1[playerid]*17/10)-speed);
			GivePlayerMoney(playerid, -fine[playerid]);
			format(str,sizeof(str), "You were driving faster than %d(%d) MpH and got fined for $%d",speed, distance1[playerid] ,fine[playerid]);
			SendClientMessage(playerid, COLOR_YELLOW, str);
		}
	}
}



