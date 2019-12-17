/* Deer Hunting CONCEPT
This script is designed to show the basics to a dear hunting system
using SA:MP 0.3Z functions.
Edit it to fit your standards, and re release it as you like
This script is unlicensed, and therefore, credits are not a requirement.
If you re release it, PM me a link to the thread, i'd love to see what
others did with my concept!

Made by: Mattakil of SA:MP forums.
*/

// 								Let's begin!
//=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%=%

#include <a_samp>
#include <zcmd>

//==============================================================================
// 									DEFINES

#define SpawnTime 60000 //time in milliseconds before the deer changes position
#define Deer 19315 //the object for the deer
#define MaxDeer 1 //how many deer you want spawned, for testing purposes I spawn 1.

#define red 0xFF0000FF
#define yellow 0xFFFF00FF
#define blue 0x0000FFFF
//==============================================================================


//==============================================================================
// 								New functions

new Float:positions[][3] = //array of positions where the deer will spawn
{
	{2456.7625, -124.3695, 30.1576},
	{2593.3740, -114.2172, 48.5642},
	{2598.4680, -225.4654, 35.6671},
	{2330.8091, -164.9444, 22.7093} //Last position does not have comma.
};

new DeerCreated[MaxDeer];
//==============================================================================


//==============================================================================
// 								CALLBACKS

public OnFilterScriptInit()
{
	for(new i; i<=MaxDeer; i++)
	{
	    DeerCreated[i] = CreateObject(Deer, 2330.8091, -164.9444, 22.7093, 0.0, 0.0, 0.0);
	}
	SetTimer("OnDeerRespawn", SpawnTime, true);
	return 1;
}

public OnFilterScriptExit()
{
    for(new i; i<=MaxDeer; i++)
	{
	    DestroyObject(DeerCreated[i]);
	}
	return 1;
}

forward OnDeerRespawn();
public OnDeerRespawn()
{
    new ran = random(sizeof(positions));
    for(new i; i<=MaxDeer; i++)
	{
	    SetObjectPos(DeerCreated[i], positions[ran][0], positions[ran][1], positions[ran][2]);
	}
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(hittype == 3)
	{
		new Float:X, Float:Y, Float:Z;
		GetObjectPos(hitid, X, Y, Z);
		SetObjectRot(hitid, 90, 0, 0);
		SetObjectPos(hitid, X, Y, Z-0.4);
		SendClientMessage(playerid, blue, "[{ffff00}i{0000ff}] {f0f0f0}You hit the deer!");
		return 1;
	}
	return 1;
}
//==============================================================================


//==============================================================================
// 									COMMANDS

CMD:rifle(playerid)
{
	GivePlayerWeapon(playerid, 33, 50);
	SendClientMessage(playerid, blue, "[{ffff00}i{0000ff}] {f0f0f0}You spawned a rifle.");
	return 1;
}

CMD:gotodeer(playerid)//THIS COMMAND WILL HAVE TO BE EDITED IF YOU HAVE MORE THAN 1 DEER!
{
	new Float:X, Float:Y, Float:Z;
	GetObjectPos(DeerCreated[0], X, Y, Z);
	SetPlayerPos(playerid, X, Y+1, Z);
	SendClientMessage(playerid, blue, "[{ffff00}i{0000ff}] {f0f0f0}You have teleported to the deer.");
	return 1;
}

CMD:huntinghelp(playerid)
{
	SendClientMessage(playerid, red, "Commands: {00FF00}/rifle /gotodeer");
	return 1;
}