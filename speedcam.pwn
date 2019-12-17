/* Automatic Speeding Camera system, Created by FusiouS


**************************
Version: 1.0, Release 1
SA-MP Version: 0.3c
Credits for speeding cam system: FusiouS
Special thanks & Credits for testing speedometer:
**************************

Features:

- Checks player speed when he is moving with vehicle
- If vehicle speed is over specified speed limit, speeding camera give's fine automatically
- All camera's speed limit can be decided: 1 can be for example 40mp/h, one 60mp/h one 80mp/h and so on..
- Easy camera creating system


TERMS OF USE: You are free to modify this script for your own use.
Do not remove credits or re-release this as your own.

*/


// Required Include
#include <a_samp>

// New stuff
new UpdateSeconds = 1;
new MaxObjects = 20;


public OnFilterScriptInit() {
print("\nAutomatic Speeding Camera System loaded!");
print("Version: 1.0, Release 1");
print("Credits: FusiouS\n");
SetTimer("UpdateSpeed", UpdateSeconds*1000, 1);

// Camera Objects

/*          modelid   X Coord Y Coord  Z Coord      RotateX RotateY  RotateZ */
CreateObject(1616, 1451.7249, -1726.3785, 16.0000, 0.0000, 0.0000, -173.0000); //LSPD NEAR
CreateObject(1616, 1350.4246, -1131.2245, 27.0000, -4.0000, 4.0000, -209.0000); //LS AMMU NEAR
CreateObject(1616, 790.7557, -1776.3378, 21.0000, 0.0000, 0.0000, -135.0000); //LS BEACH
CreateObject(1616, 681.2205, -1139.5607, 22.0000, 0.0000, 0.0000, 251.0000); //NORTH LS
CreateObject(1616, 1797.2307, -2678.8931, 10.0000, 0.0000, 0.0000, 47.0000); //NEAR LS AIRPORT TUNNEL
CreateObject(1616, 2879.8845, -1295.8997, 15.0000, 0.0000, 0.0000, 91.0000); //
CreateObject(1616, 2139.7844, -1534.0510, 10.0000, 0.0000, 0.0000, 207.0000); //MOTORWAY, RAMP TO LS 2
CreateObject(1616, 2263.1226, -1741.4176, 22.0000, 0.0000, 0.0000, 236.0000); //NEAR LS GYM 2
CreateObject(1616, 1073.4392, -1390.1713, 18.0000, 0.0000, 0.0000, 200.0000); //NEAR ALL SAINTS HOSPITAL
CreateObject(1616, -128.4532, -1318.2719, 6.0000, 0.0000, 0.0000, 76.0000); // EXIT OF LOS SANTOS
CreateObject(1616, 1857.1750, -1477.2706, 17.0000, 0.0000, 0.0000, 113.0000); // BRIDGE UPPER HIGHWAY

}

public OnFilterScriptExit() {
print("\nAutomatic Speeding Camera System un-loading!");
print("Successfully un-loaded!");
}
forward UpdateSpeed(playerid);
enum SavePlayerPosEnum {
Float:LastX,
Float:LastY,
Float:LastZ
}
#define COLOR_YELLOW 0xFFFF00AA
#define SLOTS 200
#define COLOR_PURPLE 0xC2A2DAAA

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
			
			
			// Speeding controllers
			
			/*                CoordX    CoordY   CoorZ  Radius Speedlimit (MP/H)    */
			
        	AddSpeedingCam(i, 1350.9496, -1112.5031, 28.0000, 20, 40);
            AddSpeedingCam(i, 790.7557, -1776.3378, 21.0000, 20, 40);
            AddSpeedingCam(i, 681.2205, -1139.5607, 22.0000, 20, 40);
            AddSpeedingCam(i, 1797.2307, -2678.8931, 10.0000, 20, 40);
			AddSpeedingCam(i, 2879.8845, -1295.8997, 15.0000, 20, 40);
 			AddSpeedingCam(i, 2263.1226, -1741.4176, 22.0000, 20, 40);
 			AddSpeedingCam(i, 1073.4392, -1390.1713, 18.0000, 20, 40);
 			AddSpeedingCam(i, -128.4532, -1318.2719, 6.0000, 20, 40);
 			AddSpeedingCam(i, 1857.1750, -1477.2706, 17.0000, 20, 40);
		}
	} 
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

stock AddSpeedingCam(playerid, Float:xx, Float:yy, Float:zz, radius, speed)
{
	new fine[MAX_PLAYERS];
 	new str[256];

 	if(objectcreated!=MaxObjects)
  	{
    	CreateObject(playerid, xx, yy, zz, 0.0, 0.0, 10);
     	objectcreated++;
  	}
  	if((distance1[playerid])>speed)
  	{
		if(IsPlayerInCircle(playerid, xx, yy, radius)  && GetPlayerState(playerid)== PLAYER_STATE_DRIVER)
		{
			fine[playerid]=((distance1[playerid]*17/10)-speed);
			GivePlayerMoney(playerid, -fine[playerid]);
            SendClientMessage(playerid, COLOR_PURPLE, "You bypassed the Police Automatic Speeding camera too fast and its light flashed for you.");
			format(str,sizeof(str), "[SPEED CAM] You were driving faster than %d MP/H (Your speed was %d MP/H) and got fined for $%d",speed, distance1[playerid] ,fine[playerid]);
            GameTextForPlayer(playerid, "~r~AUTOMATIC SPEEDING CAMERA!", 5000, 3);
            PlayerPlaySound(playerid, 1132, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_YELLOW, str);
		}
	}
}

