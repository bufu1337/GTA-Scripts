#include <a_samp>

#define FILTERSCRIPT

#if defined FILTERSCRIPT
new HouseEntrance1;
new Exit;
new info;

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Bongs?");
	print("--------------------------------------\n");
	HouseEntrance1 = CreatePickup(1273, 1, -2493.0203,-16.6251,25.7656);
    Exit = CreatePickup(1272, 1, 2466.2590,-1698.1794,1013.5078);
	info = CreatePickup(1239, 1, 2449.3599,-1702.9742,1013.5078);
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/sesh", cmdtext, true, 10) == 0)
	{
		SendClientMessage(playerid, 0x3C64C4FF,"=========FF~Bong~House=======");
		SendClientMessage(playerid, 0x3C64C4FF,"FFA Bong room costs $25 a cone");
		SendClientMessage(playerid, 0x3C64C4FF,"FFA also has $15 for a joint ");
		SendClientMessage(playerid, 0x3C64C4FF,"The commands are /joint /cone");
		SendClientMessage(playerid, 0x3C64C4FF,"=============================");
		return 1;
	}
	if (strcmp("/cone", cmdtext, true, 10) == 0)
	{
        GivePlayerMoney(playerid, -25);
		SendClientMessage(playerid, 0x3C64C4FF,"=========Enjoy=======");
        GameTextForPlayer(playerid, "~w~You are~n~~p~Stoned", 4000, 1);
		SetPlayerWeather(playerid,-66);
		return 1;
	}
	if (strcmp("/joint", cmdtext, true, 10) == 0)
	{
       	GivePlayerMoney(playerid, -15);
		SendClientMessage(playerid, 0x3C64C4FF,"=========Got a new Bob Marley=======");
		return 1;
	}
	return 0;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
     if (pickupid == HouseEntrance1)
     {
     	SetPlayerInterior(playerid, 2);
     	SetPlayerVirtualWorld(playerid, 1);
     	SetPlayerPos(playerid, 2451.77, -1699.80, 1013.51);
	 	SetPlayerFacingAngle(playerid, 16.2501);
	 }

	 if (pickupid == Exit)
	 {
     	SetPlayerInterior(playerid, 0);
     	SetPlayerVirtualWorld(playerid, 0);
     	SetPlayerPos(playerid, -2493.3313,-18.7592,25.7656);
     	SetPlayerFacingAngle(playerid, 90.0);
     	return 1;
	 }

	 if (pickupid == info)
     {
	  SendClientMessage(playerid, 0x3C64C4FF,"Welcome to the FFA Bong Room");
	  SendClientMessage(playerid, 0x3C64C4FF,"Please type /sesh to get started");
	  return 1;
	  }
     return 1;
}
#endif
