#include <a_samp>
#include <zcmd>

#define RED "{FF0000}"
#define GREEN "{11ED65}"

new HelmetEnabled[MAX_PLAYERS];
new RandomHelmet[] =
{
    18645, //MotorcycleHelmet
	18976,	//MotorcycleHelmet2
	18977, 	//MotorcycleHelmet3
	18978,	//MotorcycleHelmet4
	18979	//MotorcycleHelmet5

};

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Helmet System | Author: Syntax");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	HelmetEnabled[playerid] = 1;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerAttachedObject(playerid, 3, RandomHelmet[random(sizeof(RandomHelmet))], 2, 0.101, -0.0, 0.0, 5.50, 84.60, 83.7, 1, 1, 1);
	return 1;
}

CMD:helmet (playerid)
{
	if (HelmetEnabled[playerid] == 1)
	{
	    HelmetEnabled[playerid] = 0;
	    SendClientMessage(playerid, -1, ">> "RED"Helmet disabled!");
		RemovePlayerAttachedObject(playerid, 3);
	}
	else if (HelmetEnabled[playerid] == 0)
	{
	    HelmetEnabled[playerid] = 1;
	    SendClientMessage(playerid, -1, ">> "GREEN"Helmet enabled!");
		SetPlayerAttachedObject(playerid, 3, RandomHelmet[random(sizeof(RandomHelmet))], 2, 0.101, -0.0, 0.0, 5.50, 84.60, 83.7, 1, 1, 1);
	}
	return 1;
}