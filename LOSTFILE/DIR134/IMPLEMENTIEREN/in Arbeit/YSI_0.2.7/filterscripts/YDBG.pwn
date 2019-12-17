/*
===================================================================
  If you uncomment the following line YSI will be compiled with
  filterscript options, this is VERY important if you do use it as
  one, otherwise certain features may not work
===================================================================
*/

#define FILTERSCRIPT

/*
===================================================================
  If you uncomment one of the following lines YSI will not include,
  those files in compiling.
  So if you E.G. dont use objects in your script,
  you could uncomment the line #define YSI_NO_OBJECTS,
  and it would leave the Object files out.
  
  Note: Not every combination has been tested (there are currently
  131072 combinations, if you find one which doesn't compile due to
  cross-file dependencies please say.
  
  Also note that excluding either checkpoints or areas will exclude
  properties instantly.  You can also exclude all unwritten new
  libraries for future compatability using:

  #define YSI_VERSION <version>
  
  Where version is the version you are compiling against, current
  ids are:
  
  2 - YSI 0.2 or earlier
  3 - YSI 0.3
===================================================================
*/
  
//#define YSI_NO_TEXT
//#define YSI_NO_COMMANDS
//#define YSI_NO_SYSTEM
//#define YSI_NO_TRACKING
//#define YSI_NO_CALLBACKS
//#define YSI_NO_MASTER
//#define YSI_NO_CLASSES
//#define YSI_NO_PICKUPS
//#define YSI_NO_STANDARD
//#define YSI_NO_MODULES
//#define YSI_NO_OBJECTS
//#define YSI_NO_RACES
//#define YSI_NO_CHECKPOINTS
//#define YSI_NO_AREAS
//#define YSI_NO_GROUPS
//#define YSI_NO_PROPERTIES
//#define YSI_NO_ZONES

#define MAX_DYN_OBJECTS 1010000

#include <YSI>

// State system limited to only 4,294,967,296 states
enum YDBG_STATE
{
	YDBG_STATE_NONE,
	YDBG_STATE_CREATE_AMMU[4],
	YDBG_STATE_AMMU_PRICE[40],
	YDBG_STATE_AMMU_AMMO[40],
	YDBG_STATE_AMMU_TYPE,
	YDBG_STATE_CREATE_PROP,
	YDBG_STATE_PROP_PRICE,
	YDBG_STATE_PROP_REWARD,
	YDBG_STATE_PROP_DELAY,
	YDBG_STATE_FZ_WANT,
	YDBG_STATE_FZ_SPHERE,
	YDBG_STATE_FZ_CIRCLE,
	YDBG_STATE_FZ_CUBE,
	YDBG_STATE_FZ_BOX,
	YDBG_STATE_FZ_POLY,
	YDBG_STATE_MA_WANT,
	YDBG_STATE_MA_SPHERE,
	YDBG_STATE_MA_CIRCLE,
	YDBG_STATE_MA_CUBE,
	YDBG_STATE_MA_BOX,
	YDBG_STATE_MA_POLY,
	YDBG_STATE_TELE
}

new
	Menu:gValueMenu,
	Menu:gAreaMenu,
	//gPlayerMenu[MAX_PLAYERS] = {INVALID_MENU, ...},
	YDBG_STATE:gYDBGPlayerState[MAX_PLAYERS] = {YDBG_STATE_NONE, ...},
	gPlayerCreateData[MAX_PLAYERS][41],
	Text:gPlayerTextDraw[MAX_PLAYERS];

#define AddMoneyMenuData(%1,%2,%3,%4) \
	gPlayerCreateData[playerid][(%1)] += ((gPlayerCreateData[playerid][(%1)] >>> (%2)) < ((%3) - (%4))) ? ((%4) << (%2)) : (0)

#define TakeMoneyMenuData(%1,%2,%3) \
	gPlayerCreateData[playerid][(%1)] -= ((gPlayerCreateData[playerid][(%1)] >>> (%2)) >= (%3)) ? ((%3) << (%2)) : (0)

#if defined FILTERSCRIPT

Script_OnFilterScriptInit()
{
	print("\n------------------------------------");
	print(" YSI Filterscript by your name here");
	print("------------------------------------\n");

	ycmd(kill);
	ycmd("mycommand");
	ycmd(createammu);
	ycmd(createprop);
	ycmd(createbank);
	Langs_AddLanguage("EN", "English");
	Langs_AddFile("core", "YSI");

	gValueMenu = CreateMenu("Set value", 1, 260.0, 200.0, 120.0);
	AddMenuItem(gValueMenu, 0, " +10000");
	AddMenuItem(gValueMenu, 0, " +1000");
	AddMenuItem(gValueMenu, 0, " +100");
	AddMenuItem(gValueMenu, 0, " +10");
	AddMenuItem(gValueMenu, 0, " +1");
	AddMenuItem(gValueMenu, 0, " -1");
	AddMenuItem(gValueMenu, 0, " -10");
	AddMenuItem(gValueMenu, 0, " -100");
	AddMenuItem(gValueMenu, 0, " -1000");
	AddMenuItem(gValueMenu, 0, " -10000");
	AddMenuItem(gValueMenu, 0, "- Done -");
	
	gAreaMenu = CreateMenu("Select area type", 1, 210.0, 200.0, 220.0);
	AddMenuItem(gAreaMenu, 0, "Cube");
	AddMenuItem(gAreaMenu, 0, "Box");
	AddMenuItem(gAreaMenu, 0, "Circle");
	AddMenuItem(gAreaMenu, 0, "Sphere");
	AddMenuItem(gAreaMenu, 0, "Polygon");

	//XML_RemoveItem("XMLrem.xml", "bla", "woo");
/*	new
		bla = XML_AddItem("bla", "foo"),
		one = XML_AddParameter(bla, "first_layer", "name_one");
	XML_AddParameter(bla, "f_layer", "par_one");
	XML_AddParameter(one, "s_layer", "par_two");
	XML_ReplaceItem("XMLrem.xml", "bla", "foo", bla);*/
	//XML_ReplaceItem("XMLrem.xml", "first_layer", "name_one", bla);
	//XML_WriteItem("XMLrem.xml", bla);

 	return 1;
}

Script_OnFilterScriptExit()
{
    return 1;
}

#else

main()
{
    print("\n--------------------------------");
    print(" YSI Gamemode by your name here");
    print("--------------------------------\n");
}

#endif

Text_RegisterTag(tag_with_MY_KILL_HELP);

forward ycmd_kill(playerid, params[], help);
public ycmd_kill(playerid, params[], help)
{
    if (help) Text_Send(playerid, "MY_KILL_HELP");
    else SetPlayerHealth(playerid, 0.0);
    return 1;
}

Script_OnGameModeInit()
{
    // Don't use these lines if it's a filterscript
    #if !defined FILTERSCRIPT
	    SetGameModeText("Blank Script");
	    AddStaticVehicleEx(487, 2040.0568, 1343.4222, 10.6719, 0.0, 0, 0, 20);
	    AddStaticVehicleEx(435, 2040.0568, 1354.4222, 10.6719, 0.0, 0, 0, 20); // long trailer - 1
	    AddStaticVehicleEx(515, 2040.0568, 1365.4222, 10.6719, 0.0, 0, 0, 20); // roadtrain
	    Class_Add(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	    ycmd(kill);
	    ycmd("mycommand");
	    Langs_AddLanguage("EN", "English");
	    Langs_AddFile("core", "YSI");
    #endif
    return 1;
}

Command_(mycommand)
{
    // Your code here
    return 1;
}

Script_OnGameModeExit()
{
	Master_@Master();
    return 1;
}

Script_OnPlayerRequestClass(playerid, classid)
{
    SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
    SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
    SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
    return 1;
}

Script_OnPlayerRequestSpawnEx(playerid, classid)
{
    return 1;
}

Script_OnPlayerConnect(playerid)
{
	new
		Text:td = TextDrawCreate(16.0, 141.0, " ");
	TextDrawAlignment(td, 0);
	TextDrawBackgroundColor(td, 0x000000FF);
	TextDrawFont(td, 1);
	TextDrawLetterSize(td, 0.5, 0.7);
	TextDrawColor(td, 0xFF0000AA);
	TextDrawSetOutline(td, 1);
	TextDrawSetProportional(td, 1);
	TextDrawSetShadow(td, 1);
	TextDrawShowForPlayer(playerid, td);
	gPlayerTextDraw[playerid] = td;
	gYDBGPlayerState[playerid] = YDBG_STATE_NONE;
	return 1;
}

Script_OnPlayerDisconnect(playerid, reason)
{
	TextDrawHideForPlayer(playerid, gPlayerTextDraw[playerid]);
	TextDrawDestroy(gPlayerTextDraw[playerid]);
	#pragma unused reason
    return 1;
}

Script_OnPlayerSpawn(playerid)
{
    return 1;
}

Script_OnPlayerDeath(playerid, killerid, reason)
{
    return 1;
}

Script_OnVehicleSpawn(vehicleid)
{
    return 1;
}

Script_OnVehicleDeath(vehicleid, killerid)
{
    return 1;
}

Script_OnPlayerText(playerid, text[])
{
	new
		states = _:gYDBGPlayerState[playerid];
	switch (states)
	{
		case (_:YDBG_STATE_AMMU_PRICE + 0) .. (_:YDBG_STATE_AMMU_PRICE + 39):
		{
			new
				price = strval(text);
			if (price < 0x00100000)
			{
				HideMenuForPlayerEx(playerid);
				gPlayerCreateData[playerid][states] &= 0xFFF00000;
				gPlayerCreateData[playerid][states] |= price;
				ShowCreateAmmuMenu(playerid, 0);
			}
			return 0;
		}
		case (_:YDBG_STATE_AMMU_AMMO + 0) .. (_:YDBG_STATE_AMMU_AMMO + 39):
		{
			new
				ammo = strval(text);
			if (ammo < 0x00001000)
			{
				HideMenuForPlayerEx(playerid);
				gPlayerCreateData[playerid][states] &= 0x000FFFFF;
				gPlayerCreateData[playerid][states] |= ammo << 20;
				ShowCostAmmuMenu(playerid, states - _:YDBG_STATE_AMMU_AMMO);
			}
			return 0;
		}
	}
    return 1;
}

Script_OnPlayerPrivmsg(playerid, recieverid, text[])
{
    return 1;
}

Script_OnPlayerCommandText(playerid, cmdtext[])
{
    return 0;
}

Script_OnPlayerInfoChange(playerid)
{
    return 1;
}

Script_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    return 1;
}

Script_OnPlayerExitVehicle(playerid, vehicleid)
{
    return 1;
}

Script_OnPlayerStateChange(playerid, newstate, oldstate)
{
    return 1;
}

Script_OnPlayerEnterCheckpointEx(playerid, cpid)
{
    return 1;
}

Script_OnPlayerLeaveCheckpointEx(playerid, cpid)
{
    return 1;
}

Script_OnPlayerEnterRaceCheckpoint(playerid)
{
    return 1;
}

Script_OnPlayerLeaveRaceCheckpoint(playerid)
{
    return 1;
}

Script_OnRconCommand(cmd[])
{
    return 1;
}

Script_OnPlayerPickUpPickup(playerid, pickupid)
{
    return 1;
}

HideMenuForPlayerEx(playerid)
{
	new
		Menu:menu = GetPlayerMenu(playerid);
	HideMenuForPlayer(menu, playerid);
	if (menu != gValueMenu) DestroyMenu(menu);
	TogglePlayerControllable(playerid, 1);
	TextDrawSetString(gPlayerTextDraw[playerid], " ");
}

ShowMenuForPlayerEx(Menu:menu, playerid)
{
	ShowMenuForPlayer(menu, playerid);
	TogglePlayerControllable(playerid, 0);
}

Script_OnPlayerSelectedMenuRow(playerid, row)
{
	HideMenuForPlayerEx(playerid);
	new
		states = _:gYDBGPlayerState[playerid];
	switch (states)
	{
		case (_:YDBG_STATE_CREATE_AMMU + 0):
		{
			if (row < 10) ShowAmmoAmmuMenu(playerid, row);
			else if (row > 10) ShowTypeAmmuMenu(playerid);
			else ShowCreateAmmuMenu(playerid, 1);
		}
		case (_:YDBG_STATE_CREATE_AMMU + 1):
		{
			if (row < 10) ShowAmmoAmmuMenu(playerid, row + 10);
			else if (row > 10) ShowTypeAmmuMenu(playerid);
			else ShowCreateAmmuMenu(playerid, 2);
		}
		case (_:YDBG_STATE_CREATE_AMMU + 2):
		{
			if (row < 10) ShowAmmoAmmuMenu(playerid, row + 20);
			else if (row > 10) ShowTypeAmmuMenu(playerid);
			else ShowCreateAmmuMenu(playerid, 3);
		}
		case (_:YDBG_STATE_CREATE_AMMU + 3):
		{
			if (row < 10) ShowAmmoAmmuMenu(playerid, row + 30);
			else if (row > 10) ShowTypeAmmuMenu(playerid);
			else ShowCreateAmmuMenu(playerid, 0);
		}
		case (_:YDBG_STATE_AMMU_PRICE + 0) .. (_:YDBG_STATE_AMMU_PRICE + 39):
		{
			states -= _:YDBG_STATE_AMMU_PRICE;
			switch (row)
			{
				case 0: gPlayerCreateData[playerid][states] += (gPlayerCreateData[playerid][states] & 0xFFFFF < 0x0000100000 - 10000) ? (10000) : (0);
				case 1: gPlayerCreateData[playerid][states] += (gPlayerCreateData[playerid][states] & 0xFFFFF < 0x0000100000 - 1000) ? (1000) : (0);
				case 2: gPlayerCreateData[playerid][states] += (gPlayerCreateData[playerid][states] & 0xFFFFF < 0x0000100000 - 100) ? (100) : (0);
				case 3: gPlayerCreateData[playerid][states] += (gPlayerCreateData[playerid][states] & 0xFFFFF < 0x0000100000 - 10) ? (10) : (0);
				case 4: gPlayerCreateData[playerid][states] += (gPlayerCreateData[playerid][states] & 0xFFFFF < 0x0000100000 - 1) ? (1) : (0);
				case 5: gPlayerCreateData[playerid][states] -= (gPlayerCreateData[playerid][states] & 0xFFFFF >= 1) ? (1) : (0);
				case 6: gPlayerCreateData[playerid][states] -= (gPlayerCreateData[playerid][states] & 0xFFFFF >= 10) ? (10) : (0);
				case 7: gPlayerCreateData[playerid][states] -= (gPlayerCreateData[playerid][states] & 0xFFFFF >= 100) ? (100) : (0);
				case 8: gPlayerCreateData[playerid][states] -= (gPlayerCreateData[playerid][states] & 0xFFFFF >= 1000) ? (1000) : (0);
				case 9: gPlayerCreateData[playerid][states] -= (gPlayerCreateData[playerid][states] & 0xFFFFF >= 10000) ? (10000) : (0);
				case 10: return ShowCreateAmmuMenu(playerid, 0);
			}
			ShowCostAmmuMenu(playerid, states);
		}
		case (_:YDBG_STATE_AMMU_AMMO + 0) .. (_:YDBG_STATE_AMMU_AMMO + 39):
		{
			states -= _:YDBG_STATE_AMMU_AMMO;
			switch (row)
			{
				case 0: AddMoneyMenuData(states, 20, 0x00001000, 10000);
				case 1: AddMoneyMenuData(states, 20, 0x00001000, 1000);
				case 2: AddMoneyMenuData(states, 20, 0x00001000, 100);
				case 3: AddMoneyMenuData(states, 20, 0x00001000, 10);
				case 4: AddMoneyMenuData(states, 20, 0x00001000, 1);
				case 5: TakeMoneyMenuData(states, 20, 1);
				case 6: TakeMoneyMenuData(states, 20, 10);
				case 7: TakeMoneyMenuData(states, 20, 100);
				case 8: TakeMoneyMenuData(states, 20, 1000);
				case 9: TakeMoneyMenuData(states, 20, 10000);
				case 10: return ShowCostAmmuMenu(playerid, states);
			}
			ShowAmmoAmmuMenu(playerid, states);
		}
		case (_:YDBG_STATE_AMMU_TYPE):
		{
			switch (row)
			{
				case 0: gPlayerCreateData[playerid][40] ^= 1;
				case 1: gPlayerCreateData[playerid][40] ^= 2;
				case 2: return CreateAmmunationFromStats(playerid);
			}
			ShowTypeAmmuMenu(playerid);
		}
		case (_:YDBG_STATE_CREATE_PROP):
		{
			switch (row)
			{
				case 0: return ShowCostPropMenu(playerid);
				case 1: return ShowRewardPropMenu(playerid);
				case 2: return ShowDelayPropMenu(playerid);
				case 3: gPlayerCreateData[playerid][40] ^= 1;
				case 4: gPlayerCreateData[playerid][40] ^= 2;
				case 5: gPlayerCreateData[playerid][40] ^= 4;
				case 6: gPlayerCreateData[playerid][40] ^= 8;
				case 7: return CreatePropertyFromStats(playerid);
			}
			ShowCreatePropMenu(playerid);
		}
		case (_:YDBG_STATE_PROP_PRICE):
		{
			switch (row)
			{
				case 0: AddMoneyMenuData(37, 0, 0x04000000, 10000);
				case 1: AddMoneyMenuData(37, 0, 0x04000000, 1000);
				case 2: AddMoneyMenuData(37, 0, 0x04000000, 100);
				case 3: AddMoneyMenuData(37, 0, 0x04000000, 10);
				case 4: AddMoneyMenuData(37, 0, 0x04000000, 1);
				case 5: TakeMoneyMenuData(37, 0, 1);
				case 6: TakeMoneyMenuData(37, 0, 10);
				case 7: TakeMoneyMenuData(37, 0, 100);
				case 8: TakeMoneyMenuData(37, 0, 1000);
				case 9: TakeMoneyMenuData(37, 0, 10000);
				case 10: return ShowCreatePropMenu(playerid);
			}
			ShowCostPropMenu(playerid);
		}
		case (_:YDBG_STATE_PROP_REWARD):
		{
			switch (row)
			{
				case 0: AddMoneyMenuData(38, 0, 0x00040000, 10000);
				case 1: AddMoneyMenuData(38, 0, 0x00040000, 1000);
				case 2: AddMoneyMenuData(38, 0, 0x00040000, 100);
				case 3: AddMoneyMenuData(38, 0, 0x00040000, 10);
				case 4: AddMoneyMenuData(38, 0, 0x00040000, 1);
				case 5: TakeMoneyMenuData(38, 0, 1);
				case 6: TakeMoneyMenuData(38, 0, 10);
				case 7: TakeMoneyMenuData(38, 0, 100);
				case 8: TakeMoneyMenuData(38, 0, 1000);
				case 9: TakeMoneyMenuData(38, 0, 10000);
				case 10: return ShowCreatePropMenu(playerid);
			}
			ShowRewardPropMenu(playerid);
		}
		case (_:YDBG_STATE_PROP_DELAY):
		{
			switch (row)
			{
				case 0: AddMoneyMenuData(39, 0, 0x00100000, 10000);
				case 1: AddMoneyMenuData(39, 0, 0x00100000, 1000);
				case 2: AddMoneyMenuData(39, 0, 0x00100000, 100);
				case 3: AddMoneyMenuData(39, 0, 0x00100000, 10);
				case 4: AddMoneyMenuData(39, 0, 0x00100000, 1);
				case 5: TakeMoneyMenuData(39, 0, 1);
				case 6: TakeMoneyMenuData(39, 0, 10);
				case 7: TakeMoneyMenuData(39, 0, 100);
				case 8: TakeMoneyMenuData(39, 0, 1000);
				case 9: TakeMoneyMenuData(39, 0, 10000);
				case 10: return ShowCreatePropMenu(playerid);
			}
			ShowDelayPropMenu(playerid);
		}
		case (_:YDBG_STATE_MA_WANT), (_:YDBG_STATE_FZ_WANT):
		{
			StartPointSelection(playerid, row);
		}
	}
	return 1;
}

ShowAmmoAmmuMenu(playerid, weapon)
{
	ShowMenuForPlayerEx(gValueMenu, playerid);
	new
		str[64];
	format(str, sizeof (str), "Set ammo below or enter in text box (Current: %d)", gPlayerCreateData[playerid][weapon] >>> 20);
	TextDrawSetString(gPlayerTextDraw[playerid], str);
	gYDBGPlayerState[playerid] = YDBG_STATE_AMMU_AMMO + YDBG_STATE:weapon;
	return 1;
}

ShowCostAmmuMenu(playerid, weapon)
{
	ShowMenuForPlayerEx(gValueMenu, playerid);
	new
		str[64];
	format(str, sizeof (str), "Set cost below or enter in text box (Current: $%d)", gPlayerCreateData[playerid][weapon] & 0xFFFFF);
	TextDrawSetString(gPlayerTextDraw[playerid], str);
	gYDBGPlayerState[playerid] = YDBG_STATE_AMMU_PRICE + YDBG_STATE:weapon;
	return 1;
}

ShowCostPropMenu(playerid)
{
	ShowMenuForPlayerEx(gValueMenu, playerid);
	new
		str[64];
	format(str, sizeof (str), "Set cost below or enter in text box (Current: $%d)", gPlayerCreateData[playerid][37]);
	TextDrawSetString(gPlayerTextDraw[playerid], str);
	gYDBGPlayerState[playerid] = YDBG_STATE_PROP_PRICE;
	return 1;
}

ShowRewardPropMenu(playerid)
{
	ShowMenuForPlayerEx(gValueMenu, playerid);
	new
		str[64];
	format(str, sizeof (str), "Set payment below or enter in text box (Current: $%d)", gPlayerCreateData[playerid][38]);
	TextDrawSetString(gPlayerTextDraw[playerid], str);
	gYDBGPlayerState[playerid] = YDBG_STATE_PROP_REWARD;
	return 1;
}

ShowDelayPropMenu(playerid)
{
	ShowMenuForPlayerEx(gValueMenu, playerid);
	new
		str[64];
	format(str, sizeof (str), "Set time between rewards below or enter in text box (Current: %dms)", gPlayerCreateData[playerid][39]);
	TextDrawSetString(gPlayerTextDraw[playerid], str);
	gYDBGPlayerState[playerid] = YDBG_STATE_PROP_DELAY;
	return 1;
}

CreatePropertyFromStats(playerid)
{
	new
		Float:x,
		Float:y,
		Float:z,
		data = gPlayerCreateData[playerid][40];
	GetPlayerPos(playerid, x, y, z);
	printf("make");
	new
		prop = CreateProperty(gPlayerCreateData[playerid], x, y, z, gPlayerCreateData[playerid][37], gPlayerCreateData[playerid][38], gPlayerCreateData[playerid][39], data & 1, data & 2, data & 4, data & 8);
	printf("prop: %d", prop);

	new
		str[24],
		xmlProp = XML_AddItem("property", gPlayerCreateData[playerid]);
	if (data & 8) XML_AddParameter(xmlProp, "increase", "1");
	if (data & 4) XML_AddParameter(xmlProp, "reduce", "1");
	if (data & 2) XML_AddParameter(xmlProp, "multi", "1");
	if (data & 1) XML_AddParameter(xmlProp, "sell", "1");
	valstr(str, gPlayerCreateData[playerid][38]);
	XML_AddParameter(xmlProp, "reward", str);
	valstr(str, gPlayerCreateData[playerid][39]);
	XML_AddParameter(xmlProp, "delay", str);
	valstr(str, gPlayerCreateData[playerid][37]);
	XML_AddParameter(xmlProp, "price", str);
	format(str, sizeof (str), "%.2f", z);
	XML_AddParameter(xmlProp, "z", str);
	format(str, sizeof (str), "%.2f", y);
	XML_AddParameter(xmlProp, "y", str);
	format(str, sizeof (str), "%.2f", x);
	XML_AddParameter(xmlProp, "x", str);
	XML_WriteItem("YSI/YDBG/props.xml", xmlProp);

	gPlayerCreateData[playerid] = BlankArray();
	gYDBGPlayerState[playerid] = YDBG_STATE_NONE;
	return 1;
}

#define AmmuWeapData(%1,%2) \
	a[(%1)] = ((data = gPlayerCreateData[playerid][(%1)]) ? ((%2)) : (-1)), b[(%1)] = (data >>> 20), c[(%1)] = (data & 0xFFFFF)

CreateAmmunationFromStats(playerid)
{
	new
		Float:x,
		Float:y,
		Float:z,
		data,
		a[40],
		b[40],
		c[40];
	AmmuWeapData(0,  WEAPON_BRASSKNUCKLE);
	AmmuWeapData(1,  WEAPON_GOLFCLUB);
	AmmuWeapData(2,  WEAPON_NITESTICK);
	AmmuWeapData(3,  WEAPON_KNIFE);
	AmmuWeapData(4,  WEAPON_BAT);
	AmmuWeapData(5,  WEAPON_SHOVEL);
	AmmuWeapData(6,  WEAPON_POOLSTICK);
	AmmuWeapData(7,  WEAPON_KATANA);
	AmmuWeapData(8,  WEAPON_CHAINSAW);
	AmmuWeapData(9,  WEAPON_DILDO);
	AmmuWeapData(10, WEAPON_DILDO2);
	AmmuWeapData(11, WEAPON_VIBRATOR);
	AmmuWeapData(12, WEAPON_VIBRATOR2);
	AmmuWeapData(13, WEAPON_FLOWER);
	AmmuWeapData(14, WEAPON_CANE);
	AmmuWeapData(15, WEAPON_GRENADE);
	AmmuWeapData(16, WEAPON_TEARGAS);
	AmmuWeapData(17, WEAPON_MOLTOV);
	AmmuWeapData(18, WEAPON_COLT45);
	AmmuWeapData(19, WEAPON_SILENCED);
	AmmuWeapData(20, WEAPON_DEAGLE);
	AmmuWeapData(21, WEAPON_SHOTGUN);
	AmmuWeapData(22, WEAPON_SAWEDOFF);
	AmmuWeapData(23, WEAPON_SHOTGSPA);
	AmmuWeapData(24, WEAPON_UZI);
	AmmuWeapData(25, WEAPON_MP5);
	AmmuWeapData(26, WEAPON_AK47);
	AmmuWeapData(27, WEAPON_M4);
	AmmuWeapData(28, WEAPON_TEC9);
	AmmuWeapData(29, WEAPON_RIFLE);
	AmmuWeapData(30, WEAPON_SNIPER);
	AmmuWeapData(31, WEAPON_ROCKETLAUNCHER);
	AmmuWeapData(32, WEAPON_FLAMETHROWER);
	AmmuWeapData(33, WEAPON_MINIGUN);
	AmmuWeapData(34, WEAPON_SATCHEL);
	AmmuWeapData(35, WEAPON_SPRAYCAN);
	AmmuWeapData(36, WEAPON_FIREEXTINGUISHER);
	AmmuWeapData(37, WEAPON_CAMERA);
	AmmuWeapData(39, WEAPON_PARACHUTE);
	AmmuWeapData(39, WEAPON_ARMOUR);
	GetPlayerPos(playerid, x, y, z);
	CreateAmmunation(x, y, z, gPlayerCreateData[playerid][40] & 1, gPlayerCreateData[playerid][40] & 2,
		a[ 0], b[ 0], c[ 0], a[ 1], b[ 1], c[ 1], a[ 2], b[ 2], c[ 2], a[ 3], b[ 3], c[ 3], a[ 4], b[ 4], c[ 4],
		a[ 5], b[ 5], c[ 5], a[ 6], b[ 6], c[ 6], a[ 7], b[ 7], c[ 7], a[ 8], b[ 8], c[ 8], a[ 9], b[ 9], c[ 9],
		a[10], b[10], c[10], a[11], b[11], c[11], a[12], b[12], c[12], a[13], b[13], c[13], a[14], b[14], c[14],
		a[15], b[15], c[15], a[16], b[16], c[16], a[17], b[17], c[17], a[18], b[18], c[18], a[19], b[19], c[19],
		a[20], b[20], c[20], a[21], b[21], c[21], a[22], b[22], c[22], a[23], b[23], c[23], a[24], b[24], c[24],
		a[25], b[25], c[25], a[26], b[26], c[26], a[27], b[27], c[27], a[28], b[28], c[28], a[29], b[29], c[29],
		a[30], b[30], c[30], a[31], b[31], c[31], a[32], b[32], c[32], a[33], b[33], c[33], a[34], b[34], c[34],
		a[35], b[35], c[35], a[36], b[36], c[36], a[37], b[37], c[37], a[38], b[38], c[38], a[39], b[39], c[39]
	);
	
	new
		str[24];
	format(str, sizeof (str), "ammu%.0f,%.0f,%.0f", x, y, z);
	new
		xmlWeap = XML_AddItem("ammunation", str);
	valstr(str, gPlayerCreateData[playerid][40]);
	XML_AddParameter(xmlWeap, "give", str);
	for (new i = 0; i < 40; i++)
	{
		if (a[i] != -1)
		{
			new
				xmlType = XML_AddParameter(xmlWeap, "weapon");
			valstr(str, c[i]);
			XML_AddParameter(xmlType, "price", str);
			valstr(str, b[i]);
			XML_AddParameter(xmlType, "ammo", str);
			valstr(str, a[i]);
			XML_AddParameter(xmlType, "type", str);
		}
	}
	format(str, sizeof (str), "%.2f", z);
	XML_AddParameter(xmlWeap, "z", str);
	format(str, sizeof (str), "%.2f", y);
	XML_AddParameter(xmlWeap, "y", str);
	format(str, sizeof (str), "%.2f", x);
	XML_AddParameter(xmlWeap, "x", str);
	XML_WriteItem("YSI/YDBG/props.xml", xmlWeap);

	gPlayerCreateData[playerid] = BlankArray();
	gYDBGPlayerState[playerid] = YDBG_STATE_NONE;
	return 1;
}

Script_OnPlayerExitedMenu(playerid)
{
	gPlayerCreateData[playerid] = BlankArray();
	gYDBGPlayerState[playerid] = YDBG_STATE_NONE;
    return 1;
}

BlankArray()
{
	static
		empty[sizeof (gPlayerCreateData[])];
	return empty;
}

Script_OnVehicleMod(vehicleid, componentid)
{
    return 1;
}

Script_OnVehiclePaintjob(vehicleid, paintjobid)
{
    return 1;
}

Script_OnVehicleRespray(vehicleid, color1, color2)
{
    return 1;
}

Script_OnPlayerLogin(playerid, yid)
{
    return 1;
}

Script_OnPlayerLogout(playerid, yid)
{
    return 1;
}

Script_OnPlayerEnterArea(playerid, areaid)
{
    return 1;
}

Script_OnPlayerLeaveArea(playerid, areaid)
{
    return 1;
}

Script_OnRaceEnd(raceid)
{
    return 1;
}

Script_OnPlayerExitRace(playerid, raceid)
{
    return 1;
}

Script_OnPlayerFinishRace(playerid, raceid, position, prize, time)
{
    return 1;
}

forward ycmd_createbank(playerid, params[], help);
public ycmd_createbank(playerid, params[], help)
{
	if (help)
	{
		Text_SendFormat(playerid, "YDBG_CREATEBANK_HELP_1", "createbank");
		Text_Send(playerid, "YDBG_CREATEBANK_HELP_2");
	}
	else
	{
		new
			Float:x,
			Float:y,
			Float:z;
		GetPlayerPos(playerid, x, y, z);
		if (params[0] == 1) CreateBank(x, y, z);
		else CreateBank(x, y, z, params);
		new
			str[24];
		if (params[0] == 1) format(str, sizeof (str), "bank%.0f,%.0f,%.0f", x, y, z);
		new
			xmlBank = XML_AddItem("bank", (params[0] == 1) ? (str) : (params));
		format(str, sizeof (str), "%.2f", z);
		XML_AddParameter(xmlBank, "z", str);
		format(str, sizeof (str), "%.2f", y);
		XML_AddParameter(xmlBank, "y", str);
		format(str, sizeof (str), "%.2f", x);
		XML_AddParameter(xmlBank, "x", str);
		XML_WriteItem("YSI/YDBG/props.xml", xmlBank);
	}
	return 1;
}

forward ycmd_createtele(playerid, params[], help);
public ycmd_createtele(playerid, params[], help)
{
	if (help)
	{
		Text_SendFormat(playerid, "YDBG_CREATETELE_HELP_1", "createtele");
		Text_SendFormat(playerid, "YDBG_CREATETELE_HELP_2", "set");
		Text_Send(playerid, "YDBG_CREATETELE_HELP_3");
	}
	else
	{
		if (params[0] != 1)
		{
			gPlayerCreateData[playerid][37] = strval(params);
			new
				pos = chrfind(' ', params);
			if (pos != -1)
			{
				pos = chrnfind(' ', params, pos);
				if (pos != -1) strcpy(gPlayerCreateData[playerid], params[pos], 37);
			}
		}
		GetPlayerPos(playerid, Float:gPlayerCreateData[playerid][38], Float:gPlayerCreateData[playerid][39], Float:gPlayerCreateData[playerid][40]);
		Text_SendFormat(playerid, "YDBG_GO_SET_TELE", "set");
		gYDBGPlayerState[playerid] = YDBG_STATE_TELE;
	}
	return 1;
}

forward ycmd_createma(playerid, params[], help);
public ycmd_createma(playerid, params[], help)
{
	if (help)
	{
		Text_SendFormat(playerid, "YDBG_CREATEMA_HELP_1", "createma");
		Text_SendFormat(playerid, "YDBG_CREATEMA_HELP_2", "set");
		Text_Send(playerid, "YDBG_CREATEMA_HELP_3");
	}
	else
	{
		ShowMenuForPlayerEx(gAreaMenu, playerid);
		gYDBGPlayerState[playerid] = YDBG_STATE_MA_WANT;
	}
	return 1;
}

forward ycmd_set(playerid, params[], help);
public ycmd_set(playerid, params[], help)
{
	if (help)
	{
		Text_SendFormat(playerid, "YDBG_SET_HELP_1", "set");
		Text_SendFormat(playerid, "YDBG_SET_HELP_2", "createma", "createtele", "createfz");
		Text_Send(playerid, "YDBG_SET_HELP_3");
	}
	else
	{
		switch (gYDBGPlayerState[playerid])
		{
			case YDBG_STATE_MA_POLY:
			{
			}
			case YDBG_STATE_TELE:
			{
				new
					Float:x,
					Float:y,
					Float:z;
				GetPlayerPos(playerid, x, y, z);
				CreateTeleport(Float:gPlayerCreateData[playerid][38], Float:gPlayerCreateData[playerid][39], Float:gPlayerCreateData[playerid][40], x, y, z, gPlayerCreateData[playerid][37], gPlayerCreateData[playerid]);
				gPlayerCreateData[playerid] = BlankArray();
			}
			case YDBG_STATE_FZ_POLY:
			{
			}
			default: Text_Send(playerid, "YDBG_SET_NO_NEED");
		}
	}
	return 1;
}

forward ycmd_createprop(playerid, params[], help);
public ycmd_createprop(playerid, params[], help)
{
	if (help)
	{
		Text_SendFormat(playerid, "YDBG_CREATEPROP_HELP_1", "createprop");
		Text_Send(playerid, "YDBG_CREATEPROP_HELP_2");
		Text_Send(playerid, "YDBG_CREATEPROP_HELP_3");
		Text_Send(playerid, "YDBG_CREATEPROP_HELP_4");
		Text_Send(playerid, "YDBG_CREATEPROP_HELP_5");
	}
	else
	{
		if (params[0] == 1) Text_SendFormat(playerid, "YDBG_CREATEAMMU_HELP_1", "createammu");
		else
		{
			gPlayerCreateData[playerid] = BlankArray();
			strcpy(gPlayerCreateData[playerid], params, 37);
			ShowCreatePropMenu(playerid);
		}
	}
	return 1;
}

forward ycmd_createammu(playerid, params[], help);
public ycmd_createammu(playerid, params[], help)
{
	if (help)
	{
		Text_SendFormat(playerid, "YDBG_CREATEAMMU_HELP_1", "createammu");
		Text_Send(playerid, "YDBG_CREATEAMMU_HELP_2");
		Text_Send(playerid, "YDBG_CREATEAMMU_HELP_3");
		Text_Send(playerid, "YDBG_CREATEAMMU_HELP_4");
		Text_Send(playerid, "YDBG_CREATEAMMU_HELP_5");
	}
	else
	{
		gPlayerCreateData[playerid] = BlankArray();
		ShowCreateAmmuMenu(playerid, 0);
	}
	return 1;
}

Script_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

Script_OnPlayerKeyPress(playerid, keyid)
{
	if (keyid == KEY_ACTION)
	{
		switch (gYDBGPlayerState[playerid])
		{
			case YDBG_STATE_FZ_CUBE:
			{
				new
					Float:x1,
					Float:y1,
					Float:z1,
					Float:x2 = gPlayerCreateData[playerid][0],
					Float:y2 = gPlayerCreateData[playerid][1],
					Float:z2 = gPlayerCreateData[playerid][2];
				GetPlayerPos(playerid, x1, y1, z1);
				gPlayerCreateData[playerid][40] &= 0xFF000000;
				gPlayerCreateData[playerid][40] |= Area_AddCube((x1 > x2) ? (x2) : (x1), (y1 > y2) ? (y2) : (y1), (z1 > z2) ? (z2) : (z1), (x1 > x2) ? (x1) : (x2), (y1 > y2) ? (y1) : (y2), (z1 > z2) ? (z2) : (z1));
			}
			case YDBG_STATE_MA_CUBE:
			{
				new
					Float:x1,
					Float:y1,
					Float:z1,
					Float:x2 = gPlayerCreateData[playerid][0],
					Float:y2 = gPlayerCreateData[playerid][1],
					Float:z2 = gPlayerCreateData[playerid][2];
				GetPlayerPos(playerid, x1, y1, z1);
				gPlayerCreateData[playerid][40] &= 0xFF000000;
				gPlayerCreateData[playerid][40] |= Area_AddCube((x1 > x2) ? (x2) : (x1), (y1 > y2) ? (y2) : (y1), (z1 > z2) ? (z2) : (z1), (x1 > x2) ? (x1) : (x2), (y1 > y2) ? (y1) : (y2), (z1 > z2) ? (z2) : (z1));
			}
			case YDBG_STATE_FZ_BOX:
			{
				new
					Float:x1,
					Float:y1,
					Float:x2,
					Float:y2 = gPlayerCreateData[playerid][1];
				GetPlayerPos(playerid, x1, y1, x2);
				x2 = gPlayerCreateData[playerid][0];
				gPlayerCreateData[playerid][40] &= 0xFF000000;
				gPlayerCreateData[playerid][40] |= Area_AddBox((x1 > x2) ? (x2) : (x1), (y1 > y2) ? (y2) : (y1), (x1 > x2) ? (x1) : (x2), (y1 > y2) ? (y1) : (y2));
			}
			case YDBG_STATE_MA_BOX:
			{
				new
					Float:x1,
					Float:y1,
					Float:x2,
					Float:y2 = gPlayerCreateData[playerid][1];
				GetPlayerPos(playerid, x1, y1, x2);
				x2 = gPlayerCreateData[playerid][0];
				gPlayerCreateData[playerid][40] &= 0xFF000000;
				gPlayerCreateData[playerid][40] |= Area_AddBox((x1 > x2) ? (x2) : (x1), (y1 > y2) ? (y2) : (y1), (x1 > x2) ? (x1) : (x2), (y1 > y2) ? (y1) : (y2));
			}
			case YDBG_STATE_FZ_POLY, YDBG_STATE_MA_POLY:
			{
				new
					count = gPlayerCreateData[playerid][40] & 0xFFFFFF;
				if (count < 40)
				{
					new
						Float:x,
						Float:y,
						Float:z;
					GetPlayerPos(playerid, x, y, z);
					gPlayerCreateData[playerid][count++] = (floatround(x * 10.0) << 16) | (floatround(y * 10.0) & 0xFFFF);
				}
			}
		}
	}
	return 1;
}

Script_OnPlayerKeyRelease(playerid, keyid)
{
	#pragma unused playerid, keyid
	return 1;
}

ShowTypeAmmuMenu(playerid)
{
	new
		Menu:ammuMenu = CreateMenu("Assignments", 2, 220.0, 200.0, 100.0, 100.0);
	AddMenuItem(ammuMenu, 0, "Spawn");
	AddMenuItem(ammuMenu, 1, (gPlayerCreateData[playerid][40] & 1) ? ("Yes") : ("No"));
	AddMenuItem(ammuMenu, 0, "Instant");
	AddMenuItem(ammuMenu, 1, (gPlayerCreateData[playerid][40] & 2) ? ("Yes") : ("No"));
	AddMenuItem(ammuMenu, 0, "- Done -");
	AddMenuItem(ammuMenu, 1, " ");
	ShowMenuForPlayerEx(ammuMenu, playerid);
	gYDBGPlayerState[playerid] = YDBG_STATE_AMMU_TYPE;
}

#define AddAmmuMenuItem(%1,%2)													\
	AddMenuItem(ammuMenu, 0, (%2));												\
	if ((weap = gPlayerCreateData[playerid][(%1)]))								\
	{																			\
		format(str, sizeof (str), "@%d, $%d", weap >>> 20, weap & 0xFFFFF);		\
		AddMenuItem(ammuMenu, 1, str);											\
	}																			\
	else AddMenuItem(ammuMenu, 1, "Add...")

ShowCreateAmmuMenu(playerid, page)
{
	if (page >= 4) page = 0;
	new
		Menu:ammuMenu = CreateMenu("Select Weapons", 2, 220.0, 200.0, 100.0, 100.0),
		weap,
		str[16];
	switch (page)
	{
		case 0:
		{
			AddAmmuMenuItem(0, "Brassknuckle");
			AddAmmuMenuItem(1, "Golfclub");
			AddAmmuMenuItem(2, "Night Stick");
			AddAmmuMenuItem(3, "Knife");
			AddAmmuMenuItem(4, "Bat");
			AddAmmuMenuItem(5, "Shovel");
			AddAmmuMenuItem(6, "Poolstick");
			AddAmmuMenuItem(7, "Katana");
			AddAmmuMenuItem(8, "Chainsaw");
			AddAmmuMenuItem(9, "Dildo");
		}
		case 1:
		{
			AddAmmuMenuItem(10, "Dildo 2");
			AddAmmuMenuItem(11, "Vibrator");
			AddAmmuMenuItem(12, "Vibrator 2");
			AddAmmuMenuItem(13, "Flower");
			AddAmmuMenuItem(14, "Cane");
			AddAmmuMenuItem(15, "Grenade");
			AddAmmuMenuItem(16, "Teargas");
			AddAmmuMenuItem(17, "Molotov");
			AddAmmuMenuItem(18, "Colt 45");
			AddAmmuMenuItem(19, "Silenced Pistol");
		}
		case 2:
		{
			AddAmmuMenuItem(20, "Desert Eagle");
			AddAmmuMenuItem(21, "Shotgun");
			AddAmmuMenuItem(22, "Sawnoff");
			AddAmmuMenuItem(23, "Spaz 9");
			AddAmmuMenuItem(24, "Uzi");
			AddAmmuMenuItem(25, "MP5");
			AddAmmuMenuItem(26, "AK47");
			AddAmmuMenuItem(27, "M4");
			AddAmmuMenuItem(28, "TEC9");
			AddAmmuMenuItem(29, "Rifle");
		}
		default:
		{
			AddAmmuMenuItem(30, "Sniper Rifle");
			AddAmmuMenuItem(31, "Rocket Launcher");
			AddAmmuMenuItem(32, "Flame Thrower");
			AddAmmuMenuItem(33, "Minigun");
			AddAmmuMenuItem(34, "Satchel Charge");
			AddAmmuMenuItem(35, "Spraycan");
			AddAmmuMenuItem(36, "Fire Extinguisher");
			AddAmmuMenuItem(37, "Camera");
			AddAmmuMenuItem(38, "Parachute");
			AddAmmuMenuItem(39, "Armour");
		}
	}
	AddMenuItem(ammuMenu, 0, "More...");
	AddMenuItem(ammuMenu, 1, " ");
	AddMenuItem(ammuMenu, 0, "- Done -");
	AddMenuItem(ammuMenu, 1, " ");
	ShowMenuForPlayerEx(ammuMenu, playerid);
	gYDBGPlayerState[playerid] = YDBG_STATE_CREATE_AMMU + YDBG_STATE:page;
	return 1;
}

ShowCreatePropMenu(playerid)
{
	new
		Menu:propMenu = CreateMenu(gPlayerCreateData[playerid], 2, 220.0, 200.0, 100.0, 100.0),
		str[16],
		opt = gPlayerCreateData[playerid][40];
	AddMenuItem(propMenu, 0, "price");
	valstr(str, gPlayerCreateData[playerid][37]);
	AddMenuItem(propMenu, 1, str);
	AddMenuItem(propMenu, 0, "reward");
	valstr(str, gPlayerCreateData[playerid][38]);
	AddMenuItem(propMenu, 1, str);
	AddMenuItem(propMenu, 0, "delay");
	valstr(str, gPlayerCreateData[playerid][39]);
	AddMenuItem(propMenu, 1, str);
	AddMenuItem(propMenu, 0, "sell");
	AddMenuItem(propMenu, 1, (opt & 1) ? ("yes") : ("no"));
	AddMenuItem(propMenu, 0, "multi");
	AddMenuItem(propMenu, 1, (opt & 2) ? ("yes") : ("no"));
	AddMenuItem(propMenu, 0, "reduce");
	AddMenuItem(propMenu, 1, (opt & 4) ? ("yes") : ("no"));
	AddMenuItem(propMenu, 0, "increase");
	AddMenuItem(propMenu, 1, (opt & 8) ? ("yes") : ("no"));
	AddMenuItem(propMenu, 0, "- Done -");
	AddMenuItem(propMenu, 1, " ");
	ShowMenuForPlayerEx(propMenu, playerid);
	gYDBGPlayerState[playerid] = YDBG_STATE_CREATE_PROP;
	return 1;
}

StartPointSelection(playerid, type)
{
	gPlayerCreateData[playerid][40] = type << 24;
	switch (type)
	{
		case 0:
		{
			TextDrawSetString(gPlayerTextDraw[playerid], "Go to the far corner and press action (usually tab)");
			GetPlayerPos(playerid, Float:gPlayerCreateData[playerid][0], Float:gPlayerCreateData[playerid][1], Float:gPlayerCreateData[playerid][2]);
			switch (gYDBGPlayerState[playerid])
			{
				case YDBG_STATE_MA_WANT: gYDBGPlayerState[playerid] = YDBG_STATE_MA_CUBE;
				case YDBG_STATE_FZ_WANT: gYDBGPlayerState[playerid] = YDBG_STATE_FZ_CUBE;
			}
		}
		case 1:
		{
			TextDrawSetString(gPlayerTextDraw[playerid], "Go to the far corner and press action (usually tab)");
			new
				Float:z;
			GetPlayerPos(playerid, Float:gPlayerCreateData[playerid][0], Float:gPlayerCreateData[playerid][1], z);
			switch (gYDBGPlayerState[playerid])
			{
				case YDBG_STATE_MA_WANT: gYDBGPlayerState[playerid] = YDBG_STATE_MA_BOX;
				case YDBG_STATE_FZ_WANT: gYDBGPlayerState[playerid] = YDBG_STATE_FZ_BOX;
			}
		}
		case 2:
		{
			new
				Float:z;
			GetPlayerPos(playerid, Float:gPlayerCreateData[playerid][0], Float:gPlayerCreateData[playerid][1], z);
			ShowCreateCircleMenu(playerid);
			switch (gYDBGPlayerState[playerid])
			{
				case YDBG_STATE_MA_WANT: gYDBGPlayerState[playerid] = YDBG_STATE_MA_CIRCLE;
				case YDBG_STATE_FZ_WANT: gYDBGPlayerState[playerid] = YDBG_STATE_FZ_CIRCLE;
			}
		}
		case 3:
		{
			TextDrawSetString(gPlayerTextDraw[playerid], "Enter the radius in the text box");
			GetPlayerPos(playerid, Float:gPlayerCreateData[playerid][0], Float:gPlayerCreateData[playerid][1], Float:gPlayerCreateData[playerid][2]);
			switch (gYDBGPlayerState[playerid])
			{
				case YDBG_STATE_MA_WANT: gYDBGPlayerState[playerid] = YDBG_STATE_MA_SPHERE;
				case YDBG_STATE_FZ_WANT: gYDBGPlayerState[playerid] = YDBG_STATE_FZ_SPHERE;
			}
		}
		case 4:
		{
			TextDrawSetString(gPlayerTextDraw[playerid], "Go to each corner and press tab~n~Type /set when done");
			new
				Float:x,
				Float:y,
				Float:z;
			GetPlayerPos(playerid, x, y, z);
			gPlayerCreateData[playerid][0] = (floatround(x * 10.0) << 16) | (floatround(y * 10.0) & 0xFFFF);
			gPlayerCreateData[playerid][40]++;
			switch (gYDBGPlayerState[playerid])
			{
				case YDBG_STATE_MA_WANT: gYDBGPlayerState[playerid] = YDBG_STATE_MA_POLY;
				case YDBG_STATE_FZ_WANT: gYDBGPlayerState[playerid] = YDBG_STATE_FZ_POLY;
			}
		}
	}
}

ShowCreateCircleMenu(playerid)
{
	new
		Menu:circMenu = CreateMenu("Create Circle", 2, 220.0, 200.0, 100.0, 100.0),
		str[16];
	AddMenuItem(circMenu, 0, "Radius");
	valstr(str, gPlayerCreateData[playerid][2]);
	AddMenuItem(circMenu, 1, str);
	AddMenuItem(circMenu, 0, "Height");
	valstr(str, gPlayerCreateData[playerid][3]);
	AddMenuItem(circMenu, 1, str);
	AddMenuItem(circMenu, 0, "0 = infinate");
	AddMenuItem(circMenu, 1, " ");
	DisableMenuRow(circMenu, 2);
	AddMenuItem(circMenu, 0, "- Done -");
	AddMenuItem(circMenu, 1, " ");
	ShowMenuForPlayerEx(circMenu, playerid);
	return 1;
}

