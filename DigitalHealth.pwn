//   	/$$$$$$$$            /$$ /$$                     /$$$$$$$$
//  	| $$_____/          |__/| $$                    |_____ $$
//  	| $$        /$$$$$$  /$$| $$  /$$$$$$   /$$$$$$      /$$/
//  	| $$$$$    |____  $$| $$| $$ /$$__  $$ /$$__  $$    /$$/
//  	| $$__/     /$$$$$$$| $$| $$| $$$$$$$$| $$  \__/   /$$/
//  	| $$       /$$__  $$| $$| $$| $$_____/| $$        /$$/
//  	| $$      |  $$$$$$$| $$| $$|  $$$$$$$| $$       /$$$$$$$$
//  	|__/       \_______/|__/|__/ \_______/|__/      |________/

/*******************************************************************************
*        		   Digital Health & Armour [DHA] - by FailerZ        	       *
*        				 	       Copyright ©                  		       *
*******************************************************************************/


//================================ [Includes] ==================================
#include          <a_samp>             //Credits to Kalcor/Kye
//================================= [Script] ===================================
//Variables & Arrays
new Text:DigiHP[MAX_PLAYERS];
new Text:DigiAP[MAX_PLAYERS];
//------------------------------------------------------------------------------
//CallBacks & Publics
public OnFilterScriptInit()
{
	print("--------------------------------------");
	print("| Digital Health & Armour by FailerZ |");
	print("|             Loaded                 |");
	print("--------------------------------------");
	return 1;
}
//------------------------------------------------------------------------------
public OnFilterScriptExit()
{
	print("--------------------------------------");
	print("| Digital Health & Armour by FailerZ |");
	print("|             Unloaded               |");
	print("--------------------------------------");
	
 	for(new i; i<GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i))
		{
			TextDrawDestroy(DigiHP[i]);
			TextDrawDestroy(DigiAP[i]);
		}
	}
	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerConnect(playerid)
{
	DigiHP[playerid] = TextDrawCreate(566.000000, 67.000000, "100");
	TextDrawBackgroundColor(DigiHP[playerid], 255);
	TextDrawFont(DigiHP[playerid], 1);
	TextDrawLetterSize(DigiHP[playerid], 0.340000, 0.799998);
	TextDrawColor(DigiHP[playerid], -6291201);
	TextDrawSetOutline(DigiHP[playerid], 1);
	TextDrawSetProportional(DigiHP[playerid], 1);

	DigiAP[playerid] = TextDrawCreate(566.000000, 45.000000, "100");
	TextDrawBackgroundColor(DigiAP[playerid], 255);
	TextDrawFont(DigiAP[playerid], 1);
	TextDrawLetterSize(DigiAP[playerid], 0.340000, 0.799998);
	TextDrawColor(DigiAP[playerid], 1778319615);
	TextDrawSetOutline(DigiAP[playerid], 1);
	TextDrawSetProportional(DigiAP[playerid], 1);
	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerDisconnect(playerid, reason)
{
	TextDrawDestroy(DigiHP[playerid]);
	TextDrawDestroy(DigiAP[playerid]);
	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerSpawn(playerid)
{
	TextDrawShowForPlayer(playerid, DigiHP[playerid]);
	
    new Float:Armour;
	GetPlayerArmour(playerid, Armour);
	if(Armour >= 1) TextDrawShowForPlayer(playerid, DigiAP[playerid]);
	else TextDrawHideForPlayer(playerid, DigiAP[playerid]);
	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerUpdate(playerid)
{
	new Float:Health;
	new HealthNum[15];
	GetPlayerHealth(playerid, Health);
	format(HealthNum, sizeof(HealthNum), "%.0f", Health);
	TextDrawSetString(DigiHP[playerid], HealthNum);
	TextDrawShowForPlayer(playerid, DigiHP[playerid]);

    new Float:Armour;
	GetPlayerArmour(playerid, Armour);
	if(Armour >= 1)
	{
		new ArmourNum[15];
        format(ArmourNum, 15, "%.0f", Armour);
		TextDrawSetString(DigiAP[playerid], ArmourNum);
		TextDrawShowForPlayer(playerid, DigiAP[playerid]);
  	}
	else
	{
		TextDrawHideForPlayer(playerid, DigiAP[playerid]);
	}
    return 1;
}