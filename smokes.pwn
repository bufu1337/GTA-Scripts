#include <a_samp>

new Float:X, Float:Y, Float:Z;
new sg1;
new sg2;
new sg3;
new sg4;
new sg5;

#define COLOR_RED 0xFF6A6AFF

// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

#endif

public OnGameModeInit()
{

	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
if(strcmp(cmdtext, "/sg1", true) == 0)
{
SetTimerEx("GernadeLasting1",15000,0,"i", playerid);
GetPlayerPos(playerid,X, Y, Z);
sg1 = CreateObject(2780, X,Y,Z, 0.0000, 0.0000, 0.0000);
SendClientMessage(playerid, COLOR_RED, "You Threw A Smoke Gernade");
SendClientMessage(playerid, COLOR_RED, "Hurry Before The Smoke Runs Out!");
SendClientMessage(playerid, COLOR_RED, "Please Wait Until This Smoke Disapears Before Doing The Command Again");
SendClientMessage(playerid, COLOR_RED, "Or Try Doing /sg1-5");
PlayerPlaySound(playerid, 1039, X,Y,Z);
return 1;
}

if(strcmp(cmdtext, "/sg2", true) == 0)
{
SetTimerEx("GernadeLasting2",15000,0,"i", playerid);
GetPlayerPos(playerid,X, Y, Z);
sg2 = CreateObject(2780, X,Y,Z, 0.0000, 0.0000, 0.0000);
SendClientMessage(playerid, COLOR_RED, "You Threw A Smoke Gernade");
SendClientMessage(playerid, COLOR_RED, "Hurry Before The Smoke Runs Out!");
SendClientMessage(playerid, COLOR_RED, "Please Wait Until This Smoke Disapears Before Doing The Command Again");
SendClientMessage(playerid, COLOR_RED, "Or Try Doing /sg1-5");
PlayerPlaySound(playerid, 1039, X,Y,Z);
return 1;
}

if(strcmp(cmdtext, "/sg3", true) == 0)
{
SetTimerEx("GernadeLasting3",15000,0,"i", playerid);
GetPlayerPos(playerid,X, Y, Z);
sg3 = CreateObject(2780, X,Y,Z, 0.0000, 0.0000, 0.0000);
SendClientMessage(playerid, COLOR_RED, "You Threw A Smoke Gernade");
SendClientMessage(playerid, COLOR_RED, "Hurry Before The Smoke Runs Out!");
SendClientMessage(playerid, COLOR_RED, "Please Wait Until This Smoke Disapears Before Doing The Command Again");
SendClientMessage(playerid, COLOR_RED, "Or Try Doing /sg1-5");
PlayerPlaySound(playerid, 1039, X,Y,Z);
return 1;
}

if(strcmp(cmdtext, "/sg4", true) == 0)
{
SetTimerEx("GernadeLasting4",15000,0,"i", playerid);
GetPlayerPos(playerid,X, Y, Z);
sg4 = CreateObject(2780, X,Y,Z, 0.0000, 0.0000, 0.0000);
SendClientMessage(playerid, COLOR_RED, "You Threw A Smoke Gernade");
SendClientMessage(playerid, COLOR_RED, "Hurry Before The Smoke Runs Out!");
SendClientMessage(playerid, COLOR_RED, "Please Wait Until This Smoke Disapears Before Doing The Command Again");
SendClientMessage(playerid, COLOR_RED, "Or Try Doing /sg1-5");
PlayerPlaySound(playerid, 1039, X,Y,Z);
return 1;
}

if(strcmp(cmdtext, "/sg5", true) == 0)
{
SetTimerEx("GernadeLasting5",15000,0,"i", playerid);
GetPlayerPos(playerid,X, Y, Z);
sg5 = CreateObject(2780, X,Y,Z, 0.0000, 0.0000, 0.0000);
SendClientMessage(playerid, COLOR_RED, "You Threw A Smoke Gernade");
SendClientMessage(playerid, COLOR_RED, "Hurry Before The Smoke Runs Out!");
SendClientMessage(playerid, COLOR_RED, "Please Wait Until This Smoke Disapears Before Doing The Command Again");
SendClientMessage(playerid, COLOR_RED, "Or Try Doing /sg1-5");
PlayerPlaySound(playerid, 1039, X,Y,Z);
return 1;
}
return 0;
}

forward GernadeLasting1();
forward GernadeLasting2();
forward GernadeLasting3();
forward GernadeLasting4();
forward GernadeLasting5();

public GernadeLasting1()
{
DestroyObject(sg1);
return 1;
}

public GernadeLasting2()
{
DestroyObject(sg2);
return 1;
}

public GernadeLasting3()
{
DestroyObject(sg3);
return 1;
}

public GernadeLasting4()
{
DestroyObject(sg4);
return 1;
}

public GernadeLasting5()
{
DestroyObject(sg5);
return 1;
}