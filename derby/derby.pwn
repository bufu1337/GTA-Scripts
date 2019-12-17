#include <a_samp>
//==============================================================================
#define green 0x33FF33AA
//==============================================================================
public OnFilterScriptInit()
{
	print("\n=================================================================");
 	print("---------------------------Now Running----------------------------");
	print("---------------------DK's Bloodring + Hotring---------------------");
	print("----------------------Created By: D4RKKNIGH7----------------------");
	print("------------------Date Realesed: Augest 5, 2008-------------------");
	print("==================================================================");
	print("\n");
	return 1;
}
//==============================================================================
public OnPlayerConnect(playerid)
{
SendClientMessageToAll(green, "Hotring + Destruction Derby script started)");
SendClientMessageToAll(green, "Type /DHHelp for help");
return 1;
}
//==============================================================================
public OnGameModeInit()
{
	new Bloodring1 = AddStaticVehicle(504,-1362.5380,935.4382,1036.1627,11.9693,51,39);
	new Bloodring2 = AddStaticVehicle(504,-1354.9216,936.9025,1036.1865,11.4474,26,1);
	new Bloodring3 = AddStaticVehicle(504,-1347.9816,938.5251,1036.2086,17.2109,51,39);
	new Bloodring4 = AddStaticVehicle(504,-1339.8698,940.6771,1036.2238,18.4515,26,1);
	new Bloodring5 = AddStaticVehicle(504,-1332.3375,943.4537,1036.2646,26.7424,51,39);
	new Bloodring6 = AddStaticVehicle(504,-1322.5753,947.4240,1036.3134,38.2701,26,1);
	new Bloodring7 = AddStaticVehicle(504,-1484.8319,952.8900,1036.6896,324.0055,57,38);
	new Bloodring8 = AddStaticVehicle(504,-1494.3698,959.7955,1036.8184,314.1709,45,29);
	new Bloodring9 = AddStaticVehicle(504,-1501.6788,968.0242,1036.9706,302.8020,57,38);
	new Bloodring10 = AddStaticVehicle(504,-1508.9163,978.1009,1037.1545,285.9980,45,29);
	new Bloodring11 = AddStaticVehicle(504,-1512.1407,989.0095,1037.3413,272.8888,57,38);
	new Bloodring12 = AddStaticVehicle(504,-1512.8153,1000.7128,1037.5297,254.0581,45,29);
	new Hotring1 = AddStaticVehicle(494,-1371.2085,917.5561,1039.2465,269.5774,42,33);
	new Hotring2 = AddStaticVehicle(494,-1371.2794,912.1659,1040.1747,269.5517,54,36);
	new Hotring3 = AddStaticVehicle(494,-1371.5074,907.4009,1041.1002,271.9054,75,79);
	new Hotring4 = AddStaticVehicle(494,-1378.5878,919.9799,1038.8773,271.9310,92,101);
	new Hotring5 = AddStaticVehicle(494,-1378.6255,914.7642,1039.6747,269.6944,98,109);
	new Hotring6 = AddStaticVehicle(494,-1378.6936,909.5298,1040.6760,270.8418,36,117);
	LinkVehicleToInterior(Bloodring1,15);
	LinkVehicleToInterior(Bloodring2,15);
	LinkVehicleToInterior(Bloodring3,15);
	LinkVehicleToInterior(Bloodring4,15);
	LinkVehicleToInterior(Bloodring5,15);
	LinkVehicleToInterior(Bloodring6,15);
	LinkVehicleToInterior(Bloodring7,15);
	LinkVehicleToInterior(Bloodring8,15);
	LinkVehicleToInterior(Bloodring9,15);
	LinkVehicleToInterior(Bloodring10,15);
	LinkVehicleToInterior(Bloodring11,15);
	LinkVehicleToInterior(Bloodring12,15);
	LinkVehicleToInterior(Hotring1,15);
	LinkVehicleToInterior(Hotring2,15);
	LinkVehicleToInterior(Hotring3,15);
	LinkVehicleToInterior(Hotring4,15);
	LinkVehicleToInterior(Hotring5,15);
	LinkVehicleToInterior(Hotring6,15);
	return 1;
}
//==============================================================================
public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/join derby", cmdtext, true, 10) == 0){
		SetPlayerInterior(playerid,15);
		SetPlayerPos(playerid,-1431.6122,936.7097,1036.5121);
		return 1;
		}
	if (strcmp("/join race", cmdtext, true, 10) == 0){
		SetPlayerInterior(playerid,15);
		SetPlayerPos(playerid,-1390.9362,905.0969,1041.5259);
		return 1;
		}
	if (strcmp("/back", cmdtext, true, 10) == 0){
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,2496.1658,-1666.0916,13.3438);
		return 1;
		}
	if (strcmp("/Start derby", cmdtext, true, 10) == 0){
		SetPlayerInterior(playerid,15);
		GivePlayerMoney(playerid,-5000);
		SetPlayerPos(playerid,-1431.6122,936.7097,1036.5121);
		GameTextForAll("~w~Someone ~b~has started a Derby ~G~to join type ~W~/Join Derby",11000,9);
		return 1;
		}
	if (strcmp("/Start race", cmdtext, true, 10) == 0){
	    SetPlayerInterior(playerid,15);
		GivePlayerMoney(playerid,-5000);
		SetPlayerPos(playerid,-1390.9362,905.0969,1041.5259);
		GameTextForAll("~w~Someone ~b~has started a race ~G~to join type ~W~/Join race",11000,9);
		return 1;
		}
	if (strcmp("/Credits", cmdtext, true, 10) == 0){
	SendClientMessage(playerid, green, "Created By D4RKKNIGH7");
	return 1;
	}
	if (strcmp("/DHHelp", cmdtext, true, 10) == 0){
	SendClientMessageToAll(green, "To Start a Destruction Derby type /start derby (COSTS $5000)");
	SendClientMessageToAll(green, "To enter a Destruction Derby type /Join derby");
	SendClientMessageToAll(green, "To Start a Hotring Race type /start Race (COSTS $5000)");
	SendClientMessageToAll(green, "To Enter a Hotring Race type /join race)");
	SendClientMessageToAll(green, "To see who made this type /credits");
	return 1;
	}
	return 0;
}
//==============================================================================
