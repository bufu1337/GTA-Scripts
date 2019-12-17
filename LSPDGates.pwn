// This script used in the Los Santos gangsta roleplay was scripted and designed and mapped by Johnson. Please do not decide to pretend
// that this script is yours. It was made to help people who have trouble with adding gates at Los Santos Police Department! Great for
// Roleplay servers and cops vs robbers. Please make sure you keep all credits on!

#include <a_samp>

// Gates

new olspd;
new ogate;
new olockers;
new odesks;
new oarm;
new ochief;
new ocells;
new ocell1;
new ocell2;
new olspddesk;

// Colour Defines

#define COLOR_GREEN 0x33AA33AA // Green
#define COLOR_RED 0xAA3333AA // Light Red
#define COLOR_YELLOW 0xFFFF00AA // Yellow
#define COLOR_WHITE 0xFFFFFFAA // Colour White
#define COLOR_BLUE 0x0000BBAA // Normal Blue
#define COLOR_ORANGE 0xFF9900AA // Bright Orange
#define COLOR_BLACK 0x000000AA // Black

main()
{
	print("~~~~~~~~~~~~~~ Los Santos Police Department Gates ~~~~~~~~~~~~~~~");
	print(" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	print("~~~~~~~~~~~~~~~~~ By Johnson (Keep Credits On!) ~~~~~~~~~~~~~~~~~~)");
}

public OnGameModeInit()
{

	// Gates CreateObject:
	
    olspd = CreateObject(2634,246.411529,72.640029,1003.640625,0.000000,0.000000,0.000000); // olspd
	ogate = CreateObject(971,1588.902221,-1638.002807,14.909634,0.000000,0.000000,0.000000); // ogate
	olockers = CreateObject(2634,248.094558,75.794555,1003.640625,0.000000,0.000000,632.000000); // /olockers
	odesks = CreateObject(2634,241.444808,75.821380,1005.591735,0.000000,0.000000,92.000000); // /odesks
	oarm = CreateObject(2634,225.899002,75.926071,1005.039062,0.000000,0.000000,452.000000); // /oarm
	ochief = CreateObject(2634,225.978790,71.837127,1005.039062,0.000000,0.000000,448.000000); // /ochief
	ocells = CreateObject(2634,250.772140,86.826011,1002.445068,0.000000,0.000000,1348.000000); // /ocells
	ocell1 = CreateObject(2634,266.309295,87.537322,1001.039062,0.000000,0.000000,2068.000000); // /ocell1
	ocell2 = CreateObject(2634,266.330261,83.231544,1001.042663,0.000000,0.000000,2068.000000); // /ocell2
	olspddesk = CreateObject(2634,250.690734,63.395851,1003.640625,0.000000,0.000000,268.000000); // /olspddesk

}

public OnPlayerCommandText(playerid, cmdtext[])
{

new cmd[256];

if(strcmp(cmd, "/olockers", true) == 0)
	{
	MoveObject(olockers,248.094558,75.794555,1000.781616,4.0);
	SendClientMessage(playerid, COLOR_GREEN, "[Police Message]: You have successfully opened the gate."); // You Can change this message to anything you want!
	return 1;
}

if(strcmp(cmd, "/clockers", true) == 0)
	{
	MoveObject(olockers,248.094558,75.794555,1003.640625,4.0);
	SendClientMessage(playerid, COLOR_GREEN, "[Police Message]: You have successfully closed the gate."); // You Can change this message to anything you want!
	return 1;
}

if(strcmp(cmd, "/odesks", true) == 0)
	{
	MoveObject(odesks,241.386383,75.821380,1002.186096,4.0);
	SendClientMessage(playerid, COLOR_GREEN, "[Police Message]: You have successfully opened the gate."); // You Can change this message to anything you want!
	return 1;
	}

if(strcmp(cmd, "/cdesks", true) == 0)
	{
	MoveObject(odesks,241.444808,75.821380,1005.591735,4.0);
	SendClientMessage(playerid, COLOR_GREEN, "[Police Message]: You have successfully closed the gate."); // You Can change this message to anything you want!
	return 1;
	}

if(strcmp(cmd, "/oarm", true) == 0)
	{
	MoveObject(oarm,225.899002,75.926071,1002.056396,4.0);
	SendClientMessage(playerid, COLOR_GREEN, "[Police Message]: You have successfully opened the gate."); // You Can change this message to anything you want!
	return 1;
	}

if(strcmp(cmd, "/carm", true) == 0)
{
	MoveObject(oarm,225.899002,75.926071,1005.039062,4.0);
	SendClientMessage(playerid, COLOR_GREEN, "[Police Message]: You have successfully closed the gate."); // You Can change this message to anything you want!
	return 1;
}

if(strcmp(cmd, "/ochief", true) == 0)
{
	MoveObject(ochief,225.978790,71.837127,1002.142944,4.0);
	SendClientMessage(playerid, COLOR_GREEN, "[Police Message]: You have successfully opened the gate."); // You Can change this message to anything you want!
	return 1;
}

if(strcmp(cmd, "/cchief", true) == 0)
{
	MoveObject(ochief,225.978790,71.837127,1005.039062,4.0);
	SendClientMessage(playerid, COLOR_GREEN, "[Police Message]: You have successfully closed the gate."); // You Can change this message to anything you want!
	return 1;
}

if(strcmp(cmd, "/ocells", true) == 0)
{
	MoveObject(ocells,250.772140,86.826011,999.806213,4.0);
	SendClientMessage(playerid, COLOR_GREEN, "[Police Message]: You have successfully opened the gate."); // You Can change this message to anything you want!
	return 1;
}

if(strcmp(cmd, "/ccells", true) == 0)
{
	MoveObject(ocells,250.772140,86.826011,1002.445068,4.0);
	SendClientMessage(playerid, COLOR_GREEN, "[Police Message]: You have successfully closed the gate."); // You Can change this message to anything you want!
	return 1;
}

if(strcmp(cmd, "/ocell1", true) == 0)
{
	MoveObject(ocell1,266.330261,86.019821,1001.042663,4.0);
	SendClientMessage(playerid, COLOR_GREEN, "[Police Message]: You have successfully opened the gate."); // You Can change this message to anything you want!
	return 1;
}

if(strcmp(cmd, "/ccell1", true) == 0)
{
	MoveObject(ocell1,266.309295,87.537322,1001.039062,4.0);
	SendClientMessage(playerid, COLOR_GREEN, "[Police Message]: You have successfully closed the gate."); // You Can change this message to anything you want!
	return 1;
}

if(strcmp(cmd, "/ocell2", true) == 0)
{
	MoveObject(ocell2,266.330261,81.378219,1001.042663,4.0);
	SendClientMessage(playerid, COLOR_GREEN, "[Police Message]: You have successfully opened the gate."); // You Can change this message to anything you want!
	return 1;
}

if(strcmp(cmd, "/ccell2", true) == 0)
{
	MoveObject(ocell2,266.330261,83.231544,1001.042663,4.0);
	SendClientMessage(playerid, COLOR_GREEN, "[Police Message]: You have successfully closed the gate."); // You Can change this message to anything you want!
	return 1;
}



if(strcmp(cmd, "/olspd", true) == 0)
{
	MoveObject(olspd,246.411529,72.640029,1000.911437,4.0);
	SendClientMessage(playerid, COLOR_GREEN, "[Police Message]: You have successfully opened the gate."); // You Can change this message to anything you want!
	return 1;
}

if(strcmp(cmd, "/clspd", true) == 0)
{
	MoveObject(olspd,246.411529,72.640029,1003.640625,4.0);
	SendClientMessage(playerid, COLOR_GREEN, "[Police Message]: You have successfully closed the gate."); // You Can change this message to anything you want!
	return 1;
}

if(!strcmp(cmdtext,"/ogate",true))
{
	MoveObject(ogate,1598.409057,-1638.166381,15.111438,4.0);
	SendClientMessage(playerid, COLOR_GREEN, "[Police Message]: You have successfully opened the gate."); // You Can change this message to anything you want!
    return 1;
}

if(!strcmp(cmdtext,"/cgate",true))
{
    MoveObject(ogate,1588.902221,-1638.002807,14.909634,4.0);
	SendClientMessage(playerid, COLOR_GREEN, "[Police Message]: You have successfully closed the gate."); // You Can change this message to anything you want!
	return 1;
}

if(!strcmp(cmdtext,"/olspddesk",true))
{
	MoveObject(olspddesk,250.690734,63.395851,1000.622924,4.0);
	SendClientMessage(playerid, COLOR_GREEN, "[Police Message]: You have successfully opened the gate."); // You Can change this message to anything you want!
    return 1;
}

if(!strcmp(cmdtext,"/clspddesk",true))
{
	MoveObject(olspddesk,250.690734,63.395851,1003.640625,4.0);
	SendClientMessage(playerid, COLOR_GREEN, "[Police Message]: You have successfully closed the gate."); // You Can change this message to anything you want!
    return 1;
}

if(!strcmp(cmdtext,"/Johnson",true))
{
	SendClientMessage(playerid, COLOR_ORANGE, "This server uses a script or filterscript made by Johnson!");
    return 1;
}

return 1;
}

// Scripted By Johnson (Dont Remove Credits). For more information on how to make just one team be able to use the commands add MadnessJohnson@live.com !

