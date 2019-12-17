#include <a_samp>
#include <dutils>

#define green 0x0AFF0AAA
#define red 0xFF0000FF

new Androm;
new Missile;
new Flare;

forward Drop();
forward RestartObjects();
forward Bombs();

#define FILTERSCRIPT

#pragma tabsize 0

#if defined FILTERSCRIPT

new IsBombing =0;

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("      Airstrike FS");
	print("    By Backwardsman97");
	print("--------------------------------------\n");
	Androm = CreateObject(14553,-2299.105224,1957.136596,-50.107460,0.000000,0.000000,0.000000);
	Missile = CreateObject(3786,-2299.105224,1957.136596,-50.107460,0.000000,0.000000,0.000000);
	Flare = CreateObject(354,-2299.105224,1957.136596,-50.107460,0.000000,0.000000,0.000000);
	IsBombing = 0;
	return 1;
}

public OnFilterScriptExit ()
{
DestroyObject(Androm);
DestroyObject(Flare);
DestroyObject(Missile);
}

#endif

public OnPlayerCommandText(playerid, cmdtext[])
{
	new idx;
	new cmd[256];
	cmd = strtok(cmdtext, idx);

	if (strcmp("/airstrike", cmdtext, true, 10) == 0 && IsPlayerAdmin(playerid))
	if (IsBombing == 1)
	{
	SendClientMessage(playerid,red,"The Plane is already bombing.");
	return 1;
	}
	else if (IsBombing == 0) {
	SendClientMessageToAll(green,"The LV Pirate Ship will be bombed in a few seconds!");
	SetTimer("RestartObjects",30000,false);
	SetObjectPos(Androm,2272.327636,1548.834716,99.044952);
	MoveObject(Androm,2001.431030,1534.774414,86.366203,25);
	SetObjectRot(Androm,20.000000,0.000000,270.982543);
	SetObjectPos(Missile,-2299.105224,1957.136596,-50.107460);
	SetObjectPos(Flare,-2299.105224,1957.136596,-50.107460);
	SetTimer("Drop",10000,false);
	SetTimer("Bombs",13500,false);
	IsBombing = 1;
	return 1;
}
	if (strcmp("/endstrike", cmdtext, true, 10) == 0 && IsPlayerAdmin(playerid))
	if (IsBombing == 0)
	{
	SendClientMessage(playerid,red,"There is not an airstrike going on right now!");
	return 1;
	}
	else if (IsBombing == 1) {
	SendClientMessage(playerid,green,"The Airstrike was successfully cancelled.");
	SetObjectPos(Androm,-2299.105224,1957.136596,-50.107460);
	SetObjectPos(Missile,-2299.105224,1957.136596,-50.107460);
	SetObjectPos(Flare,-2299.105224,1957.136596,-50.107460);
	IsBombing = 0;
	return 1;
	}
    return 0;
}

public RestartObjects ()
{
SetObjectPos(Androm,-2299.105224,1957.136596,-50.107460);
SetObjectPos(Missile,-2299.105224,1957.136596,-50.107460);
SetObjectPos(Flare,-2299.105224,1957.136596,-50.107460);
IsBombing = 0;
}

public Drop ()
{
MoveObject(Androm,1840.356323,1534.774414,74.097160,25);
SetObjectRot(Androm,10.000000,0.000000,270.982543);
SetObjectPos(Missile,2015.849731,1536.505004,84.750396);
SetObjectRot(Missile,0.000000,-45.000000,2.279041);
SetObjectPos(Flare,2015.564697,1536.482299,84.369766);
SetObjectRot(Flare,0.000000,-34.000000,0.000000);
MoveObject(Missile,2000.651855,1544.847534,12.300948,20);
MoveObject(Flare,2000.651855,1544.847534,12.300948,20);
}

public Bombs ()
{
SetObjectPos(Missile,-2299.105224,1957.136596,-50.107460);
SetObjectPos(Flare,-2299.105224,1957.136596,-50.107460);
CreateExplosion(2001.7601,1544.1123,13.5859,0,5);
CreateExplosion(1997.7090,1540.6654,13.5859,0,3);
CreateExplosion(1999.5951,1550.9025,13.6193,4,4);
CreateExplosion(2003.6548,1547.4248,13.5859,0,4);
}

#pragma unused ret_memcpy
