#include <a_samp>

new schip;
new Float:x, Float:y, Float:z;

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Moving Ship Filterscript by : Rambo_NL");
	print("--------------------------------------\n");
	
	schip = CreateObject(8493,2043.652,1346.013,28.032,0.0,0.0,0.0);
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp(cmdtext,"/ship",true)==0)
		{
		GetObjectPos(schip, x, y, z);
		SetPlayerPos(playerid, x, y, z); // this will get you on the ship
		return 1;
	}
	if(strcmp(cmdtext,"/backward",true)==0)
		{
		GetObjectPos(schip, x, y, z);
		MoveObject(schip, x, y-99999, z, 2); // this wil move the ship backwards
		return 1;
	}
	if(strcmp(cmdtext,"/forward",true)==0)
		{
		GetObjectPos(schip, x, y, z);
		MoveObject(schip, x, y+99999, z, 2); // this wil move the ship forward
		return 1;
	}
	if(strcmp(cmdtext,"/right",true)==0)
		{
		GetObjectPos(schip, x, y, z);
		MoveObject(schip, x+99999, y, z, 2); // this wil move the ship to the right
		return 1;
	}
	if(strcmp(cmdtext,"/left",true)==0)
		{
		GetObjectPos(schip, x, y, z);
		MoveObject(schip, x-999999, y, z, 2); // this wil move the ship to the left
		return 1;
	}
	if(strcmp(cmdtext,"/up",true)==0)
		{
		GetObjectPos(schip, x, y, z);
		MoveObject(schip, x, y, z+999999, 2); // this wil move the ship up
		return 1;
	}
	if(strcmp(cmdtext,"/down",true)==0)
		{
		GetObjectPos(schip, x, y, z);
		MoveObject(schip, x, y, z-999999, 2); // this wil move the ship down
		return 1;
	}
	if(strcmp(cmdtext,"/stop",true)==0)
		{
		StopObject(schip); // this wil stop the ship from moving
		return 1;
	}
	if(strcmp(cmdtext,"/here",true)==0)
		{
		GetPlayerPos(playerid, x, y, z);
		SetObjectPos(schip, x, y-50, z+15); // this wil bring the ship to you
		return 1;
	}
	return 0;
}

