#include <a_samp>

#define FILTERSCRIPT
#define COLOR_WHITE 0xFFFFFFAA

#if defined FILTERSCRIPT
main()
{
}
public OnFilterScriptInit()
{
	CreateObject(3980, -2388.208496, 1985.848877, 9.943201, 0.0000, 0.0000, 180.0000);
    CreateObject(8130, -2388.198730, 1973.442627, 30.036606, 0.0000, 0.0000, 180.0000);
    CreateObject(8397, -2440.680908, 1967.175537, 30.493496, 0.0000, 0.0000, 270.0000);
    CreateObject(8397, -2336.697754, 1966.923950, 30.493496, 0.0000, 0.0000, 267.4217);
    CreateObject(9087, -2388.586426, 2000.828369, 20.084578, 0.0000, 0.0000, 0.0000);
    CreateObject(9087, -2372.208496, 2001.322144, 20.084579, 0.0000, 0.0000, 0.0000);
    CreateObject(9087, -2405.917969, 2000.875610, 20.084579, 0.0000, 0.0000, 0.0000);
    CreateObject(1645, -2363.887207, 2002.305420, 20.518290, 0.0000, 0.0000, 180.0000);
    CreateObject(1645, -2366.522461, 2002.336304, 20.518290, 0.0000, 0.0000, 180.0000);
    CreateObject(1646, -2361.504883, 2007.189941, 20.523571, 0.0000, 0.0000, 180.0000);
    CreateObject(14582, -2387.553467, 2004.700806, 23.670273, 0.0000, 0.0000, 0.0000);
    CreateObject(18077, -2380.255859, 2007.031738, 20.749653, 0.0000, 0.0000, 191.2500);
    CreateObject(11495, -2381.347412, 1937.676147, 1.289894, 0.0000, 0.0000, 180.0000);
	CreateVehicle(487, -2434.1697, 2010.7983, 21.9229, 101.1543, 1, 1, 60000);
	CreateVehicle(452, -2376.5583, 1929.3948, -0.3787, 180.1543, 0, 0, 60000);	

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


public OnPlayerCommandText(playerid, cmdtext[])
{
	
	if (strcmp("/shouse", cmdtext, true, 10) == 0)
	{
		SetPlayerPos(playerid, -2381.3816,1929.9998,2.4930);
		SetPlayerFacingAngle(playerid, 179.4);
		return 1;
	}
	if (strcmp("/shouseroof", cmdtext, true, 10) == 0)
	{
		SetPlayerPos(playerid, -2430.0625,2004.2324,20.9847);
		SetPlayerFacingAngle(playerid, 136.4);
		return 1;
	}
	if (strcmp("/shelp", cmdtext, true, 10) == 0)
	{
		SendClientMessage(playerid, COLOR_WHITE, "/shouse /shouseroof");
		return 1;
	}	
	return 0;
    }
    
    