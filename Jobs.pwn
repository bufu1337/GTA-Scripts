// Awesome Jobs (System) | Version 3.0
//==============================================================================
//------------------------------------------------------------------------------
// If You Find Bug In This Script Pm Me (mohamadasyrafakmal@gmail.com) Okay!
// Thank You To Support My Work :D // You Want To Edit Yes You Can!
// Sorry I'm Bad English
//------------------------------------------------------------------------------
//==============================================================================
#include <a_samp>
#include <zcmd>
//==============================================================================
enum Main {
	Harvest,
	Pizzaboy,
	Sweeper,
	Plumber,
	Trash,
	Flight
}
//==============================================================================
#define DIALOG_EX     300
#define WHITE         0xFFFFFFFF
#define YELLOW        0xFFFF00FF
#define LIME_GREEN    0x99FF00FF
#define LIGHT_BLUE    0x00FFFFFF
#define BRIGHT_RED    0xFF0000FF
#define LIGHT_GREEN   0x00FF00FF
//==============================================================================
new Info[MAX_PLAYERS][Main];
//==============================================================================
public OnFilterScriptInit()
{
	print("\n - Awesome Jobs (System) | Version 3.0 | By [Ak]mal - Loaded! - \n");
	return 1;
}
//==============================================================================
public OnFilterScriptExit()
{
    print("\n - Awesome Jobs (System) | Version 3.0 | By [Ak]mal - Unloaded! - \n");
	return 1;
}
//==============================================================================
public OnPlayerConnect(playerid)
{
	Info[playerid][Harvest] = 0;
	Info[playerid][Pizzaboy] = 0;
	Info[playerid][Sweeper] = 0;
	Info[playerid][Plumber] = 0;
	Info[playerid][Trash] = 0;
	Info[playerid][Flight] = 0;
	return 1;
}
//==============================================================================
public OnPlayerDisconnect(playerid, reason)
{
    Info[playerid][Harvest] = 0;
    Info[playerid][Pizzaboy] = 0;
    Info[playerid][Sweeper] = 0;
    Info[playerid][Plumber] = 0;
    Info[playerid][Trash] = 0;
    Info[playerid][Flight] = 0;
	return 1;
}
//==============================================================================
public OnPlayerSpawn(playerid)
{
	SendClientMessage(playerid, YELLOW, "----------------------------------------------------------------");
	SendClientMessage(playerid, LIGHT_GREEN, "[Ak]mal 'Hello, now you can start to find some money with /jobs'");
	SendClientMessage(playerid, YELLOW, "----------------------------------------------------------------");
	return 1;
}
//==============================================================================
public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}
//==============================================================================
public OnVehicleSpawn(vehicleid)
{
	return 1;
}
//==============================================================================
public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}
//==============================================================================
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}
//==============================================================================
public OnPlayerExitVehicle(playerid, vehicleid)
{
    if(Info[playerid][Harvest] >= 1)
	{
		GameTextForPlayer(playerid, "~r~Fail!", 3000, 4);
		DisablePlayerCheckpoint(playerid);
		Info[playerid][Harvest] = 0;
	}
	if(Info[playerid][Pizzaboy] >= 1)
	{
		GameTextForPlayer(playerid, "~r~Fail!", 3000, 4);
		DisablePlayerCheckpoint(playerid);
		Info[playerid][Pizzaboy] = 0;
	}
	if(Info[playerid][Sweeper] >= 1)
	{
		GameTextForPlayer(playerid, "~r~Fail!", 3000, 4);
		DisablePlayerCheckpoint(playerid);
		Info[playerid][Sweeper] = 0;
	}
	if(Info[playerid][Plumber] >= 1)
	{
		GameTextForPlayer(playerid, "~r~Fail!", 3000, 4);
		DisablePlayerCheckpoint(playerid);
		Info[playerid][Plumber] = 0;
	}
	if(Info[playerid][Trash] >= 1)
	{
		GameTextForPlayer(playerid, "~r~Fail!", 3000, 4);
		DisablePlayerCheckpoint(playerid);
		Info[playerid][Trash] = 0;
	}
	if(Info[playerid][Flight] >= 1)
	{
		GameTextForPlayer(playerid, "~r~Fail!", 3000, 4);
		DisablePlayerCheckpoint(playerid);
		Info[playerid][Flight] = 0;
	}
	return 1;
}
//==============================================================================
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}
//==============================================================================
public OnPlayerEnterCheckpoint(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 532)
    {
        if(Info[playerid][Harvest] == 1)
		{
            Info[playerid][Harvest] = 2;
            SetPlayerCheckpoint(playerid, -488.9691, -1454.4095, 13.6985, 7);
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            return 1;
        }
        if(Info[playerid][Harvest] == 2)
		{
            Info[playerid][Harvest] = 3;
            SetPlayerCheckpoint(playerid, -491.1559, -1590.0781, 6.0986, 7);
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            return 1;
        }
        if(Info[playerid][Harvest] == 3)
		{
            Info[playerid][Harvest] = 4;
            SetPlayerCheckpoint(playerid, -517.1489, -1494.8715, 10.6554, 7);
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            return 1;
        }
        if(Info[playerid][Harvest] == 4)
		{
            Info[playerid][Harvest] = 5;
            SetPlayerCheckpoint(playerid, -537.1957, -1495.2427, 9.5398, 7);
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            return 1;
        }
        if(Info[playerid][Harvest] == 5)
		{
            Info[playerid][Harvest] = 6;
            SetPlayerCheckpoint(playerid, -538.4468, -1594.6807, 7.9598, 7);
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            return 1;
        }
        if(Info[playerid][Harvest] == 6)
		{
            Info[playerid][Harvest] = 7;
            SetPlayerCheckpoint(playerid, -562.2611, -1505.3055, 8.7389, 7);
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            return 1;
        }
        if(Info[playerid][Harvest] == 7)
		{
            Info[playerid][Harvest] = 0;
            DisablePlayerCheckpoint(playerid);
            GameTextForPlayer(playerid, "~y~+$5000", 3000, 4);
            SendClientMessage(playerid, LIGHT_BLUE, "You have recieved $5000 for finish this work!");
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            GivePlayerMoney(playerid, 5000);
            return 1;
        }
    }
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 448)
    {
		if(Info[playerid][Pizzaboy] == 1)
		{
			SetPlayerCheckpoint(playerid, 892.1605, -1646.7218, 13.1179, 1);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Pizzaboy] = 2;
			return 1;
		}
		if(Info[playerid][Pizzaboy] == 2)
		{
			SetPlayerCheckpoint(playerid, 982.3013, -1808.7444, 13.8082, 1);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Pizzaboy] = 3;
			return 1;
		}
		if(Info[playerid][Pizzaboy] == 3)
		{
			SetPlayerCheckpoint(playerid, 1184.0013, -1273.2177, 13.1063, 1);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Pizzaboy] = 4;
			return 1;
		}
		if(Info[playerid][Pizzaboy] == 4)
		{
			SetPlayerCheckpoint(playerid, 1437.4880, -936.8912, 35.8308, 1);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Pizzaboy] = 5;
			return 1;
		}
		if(Info[playerid][Pizzaboy] == 5)
		{
			SetPlayerCheckpoint(playerid, 1497.1315, -692.6124, 94.7500, 1);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Pizzaboy] = 6;
			return 1;
		}
		if(Info[playerid][Pizzaboy] == 6)
		{
			DisablePlayerCheckpoint(playerid);
			GameTextForPlayer(playerid, "~y~+$10000", 3000, 4);
			SendClientMessage(playerid, LIGHT_BLUE, "You have recieved $10000 for finish this work!");
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			GivePlayerMoney(playerid, 10000);
			Info[playerid][Pizzaboy] = 0;
			return 1;
		}
    }
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 574)
    {
		if(Info[playerid][Sweeper] == 1)
		{
			SetPlayerCheckpoint(playerid, 1042.7010, -1535.9454, 13.0884, 2);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Sweeper] = 2;
			return 1;
		}
		if(Info[playerid][Sweeper] == 2)
		{
			SetPlayerCheckpoint(playerid, 940.1602, -1487.0393, 13.0990, 2);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Sweeper] = 3;
			return 1;
		}
		if(Info[playerid][Sweeper] == 3)
		{
			SetPlayerCheckpoint(playerid, 919.7930, -1366.2167, 12.9294, 2);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Sweeper] = 4;
			return 1;
		}
		if(Info[playerid][Sweeper] == 4)
		{
			SetPlayerCheckpoint(playerid, 944.8641, -1284.2758, 14.3901, 2);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Sweeper] = 5;
			return 1;
		}
		if(Info[playerid][Sweeper] == 5)
		{
			SetPlayerCheckpoint(playerid, 1021.8868, -1223.0446, 16.4908, 2);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Sweeper] = 6;
			return 1;
		}
		if(Info[playerid][Sweeper] == 6)
		{
			DisablePlayerCheckpoint(playerid);
			GameTextForPlayer(playerid, "~y~+$5000", 3000, 4);
			SendClientMessage(playerid, LIGHT_BLUE, "You have recieved $5000 for finish this work!");
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			GivePlayerMoney(playerid, 5000);
			Info[playerid][Sweeper] = 0;
			return 1;
		}
    }
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 552)
    {
		if(Info[playerid][Plumber] == 1)
		{
			SetPlayerCheckpoint(playerid, 794.8760, -1329.7904, 13.0770, 3);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Plumber] = 2;
			return 1;
		}
		if(Info[playerid][Plumber] == 2)
		{
			SetPlayerCheckpoint(playerid, 695.1418, -1408.1715, 13.0966, 3);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Plumber] = 3;
			return 1;
		}
		if(Info[playerid][Plumber] == 3)
		{
			SetPlayerCheckpoint(playerid, 623.0133, -1709.7930, 14.0830, 3);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Plumber] = 4;
			return 1;
		}
		if(Info[playerid][Plumber] == 4)
		{
			SetPlayerCheckpoint(playerid, 788.8605, -1781.1523, 12.8875, 3);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Plumber] = 5;
			return 1;
		}
		if(Info[playerid][Plumber] == 5)
		{
			SetPlayerCheckpoint(playerid, 1371.2949, -1873.7583, 13.0718, 3);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Plumber] = 6;
			return 1;
		}
		if(Info[playerid][Plumber] == 6)
		{
			SetPlayerCheckpoint(playerid, 1391.7108, -1797.4404, 13.0778, 3);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Plumber] = 7;
			return 1;
		}
		if(Info[playerid][Plumber] == 7)
		{
			DisablePlayerCheckpoint(playerid);
			GameTextForPlayer(playerid, "~y~+$15000", 3000, 4);
			SendClientMessage(playerid, LIGHT_BLUE, "You have recieved $15000 for finish this work!");
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			GivePlayerMoney(playerid, 15000);
			Info[playerid][Plumber] = 0;
			return 1;
		}
    }
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 408)
    {
		if(Info[playerid][Trash] == 1)
		{
			SetPlayerCheckpoint(playerid, 1107.0607, -1883.4639, 14.0807, 4);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Trash] = 2;
			return 1;
		}
		if(Info[playerid][Trash] == 2)
		{
			SetPlayerCheckpoint(playerid, 441.6707, -1746.8086, 9.5632, 4);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Trash] = 3;
			return 1;
		}
		if(Info[playerid][Trash] == 3)
		{
			SetPlayerCheckpoint(playerid, 1523.6438, -1020.0551, 24.4717, 4);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Trash] = 4;
			return 1;
		}
		if(Info[playerid][Trash] == 4)
		{
			SetPlayerCheckpoint(playerid, 1819.2742, -1141.5520, 24.5859, 4);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Trash] = 5;
			return 1;
		}
		if(Info[playerid][Trash] == 5)
		{
			SetPlayerCheckpoint(playerid, 2224.6501, -1415.2732, 24.3705, 4);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Trash] = 6;
			return 1;
		}
		if(Info[playerid][Trash] == 6)
		{
			SetPlayerCheckpoint(playerid, 1984.2355, -2063.3728, 13.9285, 4);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Trash] = 7;
			return 1;
		}
		if(Info[playerid][Trash] == 7)
		{
			DisablePlayerCheckpoint(playerid);
			GameTextForPlayer(playerid, "~y~+$5000", 3000, 4);
			SendClientMessage(playerid, LIGHT_BLUE, "You have recieved $5000 for finish this work!");
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			GivePlayerMoney(playerid, 5000);
			Info[playerid][Trash] = 0;
			return 1;
		}
    }
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 519)
    {
		if(Info[playerid][Flight] == 1)
		{
			SetPlayerCheckpoint(playerid, 407.1280, 2502.1599, 17.4062, 10);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Flight] = 2;
			return 1;
		}
		if(Info[playerid][Flight] == 2)
		{
			SetPlayerCheckpoint(playerid, -1667.8339, -175.2957, 15.0703, 10);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Flight] = 3;
			return 1;
		}
		if(Info[playerid][Flight] == 3)
		{
			SetPlayerCheckpoint(playerid, 1964.5533, -2450.6382, 14.4693, 10);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Flight] = 4;
			return 1;
		}
		if(Info[playerid][Flight] == 4)
		{
			SetPlayerCheckpoint(playerid, 1334.6736, 1610.5946, 10.8203, 10);
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			Info[playerid][Flight] = 5;
			return 1;
		}
		if(Info[playerid][Flight] == 5)
		{
			DisablePlayerCheckpoint(playerid);
			GameTextForPlayer(playerid, "~y~+$10000", 3000, 4);
			SendClientMessage(playerid, LIGHT_BLUE, "You have recieved $5000 for finish this work!");
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			GivePlayerMoney(playerid, 10000);
			Info[playerid][Flight] = 0;
			return 1;
		}
    }
	return 1;
}
//==============================================================================
public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}
//==============================================================================
public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}
//==============================================================================
public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}
//==============================================================================
public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}
//==============================================================================
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}
//==============================================================================
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_EX + 1)
	{
	    if(response)
	    {
	        if(listitem == 0)
	        {
	            new string[MAX_PLAYERS];
	            //--------------------------------------------------------------
	            if(Info[playerid][Harvest] == 1) return SendClientMessage(playerid, BRIGHT_RED, "You have been already started the harvest work.");
	            if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 532) return SendClientMessage(playerid, BRIGHT_RED, "You must have enter the combine harvester [532].");
	            //--------------------------------------------------------------
	            SetPlayerCheckpoint(playerid, -484.5330, -1480.2612, 13.9457, 7);
	            format(string, sizeof(string), "You must follow the red markers and you will recieve money.");
	            SendClientMessage(playerid, LIME_GREEN, string);
	            Info[playerid][Harvest] = 1;
	            //--------------------------------------------------------------
	            SetVehiclePos(GetPlayerVehicleID(playerid), -485.5200, -1449.1151, 15.7435);
	            SetVehicleZAngle(GetPlayerVehicleID(playerid), 90);
	            SetPlayerVirtualWorld(playerid, 0);
	            SetPlayerInterior(playerid, 0);
	        }
	        if(listitem == 1)
	        {
	            new string[MAX_PLAYERS];
	            //--------------------------------------------------------------
	            if(Info[playerid][Pizzaboy] == 1) return SendClientMessage(playerid, BRIGHT_RED, "You have been already started the pizzaboy work.");
	            if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 448) return SendClientMessage(playerid, BRIGHT_RED, "You must have enter the pizzaboy bike [448].");
	            //--------------------------------------------------------------
	            SetPlayerCheckpoint(playerid, 1231.7543, -1031.4081, 31.5527, 1);
	            format(string, sizeof(string), "You must follow the red markers and you will recieve money.");
	            SendClientMessage(playerid, LIME_GREEN, string);
	            Info[playerid][Pizzaboy] = 1;
	            //--------------------------------------------------------------
	            SetVehiclePos(GetPlayerVehicleID(playerid), 2090.2952, -1796.7637, 12.9823);
	            SetVehicleZAngle(GetPlayerVehicleID(playerid), 90);
	            SetPlayerVirtualWorld(playerid, 0);
	            SetPlayerInterior(playerid, 0);
	        }
	        if(listitem == 2)
	        {
	            new string[MAX_PLAYERS];
	            //--------------------------------------------------------------
	            if(Info[playerid][Sweeper] == 1) return SendClientMessage(playerid, BRIGHT_RED, "You have been already started the sweeper street work.");
	            if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 574) return SendClientMessage(playerid, BRIGHT_RED, "You must have enter the sweeper [574].");
	            //--------------------------------------------------------------
	            SetPlayerCheckpoint(playerid, 1152.3113, -1643.7635, 13.5064, 2);
	            format(string, sizeof(string), "You must follow the red markers and you will recieve money.");
	            SendClientMessage(playerid, LIME_GREEN, string);
	            Info[playerid][Sweeper] = 1;
	            //--------------------------------------------------------------
	            SetVehiclePos(GetPlayerVehicleID(playerid), 1192.9980, -1815.3284, 13.3070);
	            SetVehicleZAngle(GetPlayerVehicleID(playerid), 0);
	            SetPlayerVirtualWorld(playerid, 0);
	            SetPlayerInterior(playerid, 0);
	        }
	        if(listitem == 3)
	        {
	            new string[MAX_PLAYERS];
	            //--------------------------------------------------------------
	            if(Info[playerid][Plumber] == 1) return SendClientMessage(playerid, BRIGHT_RED, "You have been already started the plumber work.");
	            if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 552) return SendClientMessage(playerid, BRIGHT_RED, "You must have enter the utility van [552].");
	            //--------------------------------------------------------------
	            SetPlayerCheckpoint(playerid, 923.2040, -1138.5660, 23.4273, 3);
	            format(string, sizeof(string), "You must follow the red markers and you will recieve money.");
	            SendClientMessage(playerid, LIME_GREEN, string);
	            Info[playerid][Plumber] = 1;
	            //--------------------------------------------------------------
	            SetVehiclePos(GetPlayerVehicleID(playerid), 1042.9666, -919.0737, 42.2275);
	            SetVehicleZAngle(GetPlayerVehicleID(playerid), 0);
	            SetPlayerVirtualWorld(playerid, 0);
	            SetPlayerInterior(playerid, 0);
	        }
	        if(listitem == 4)
	        {
	            new string[MAX_PLAYERS];
	            //--------------------------------------------------------------
	            if(Info[playerid][Trash] == 1) return SendClientMessage(playerid, BRIGHT_RED, "You have been already started the trash master work.");
	            if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 408) return SendClientMessage(playerid, BRIGHT_RED, "You must have enter the trashmaster [408].");
	            //--------------------------------------------------------------
	            SetPlayerCheckpoint(playerid, 1462.9373, -1492.9911, 14.0956, 4);
	            format(string, sizeof(string), "You must follow the red markers and you will recieve money.");
	            SendClientMessage(playerid, LIME_GREEN, string);
	            Info[playerid][Trash] = 1;
	            //--------------------------------------------------------------
	            SetVehiclePos(GetPlayerVehicleID(playerid), 1622.3666, -1813.8547, 14.0602);
	            SetVehicleZAngle(GetPlayerVehicleID(playerid), 180);
	            SetPlayerVirtualWorld(playerid, 0);
	            SetPlayerInterior(playerid, 0);
	        }
	        if(listitem == 5)
	        {
	            new string[MAX_PLAYERS];
	            //--------------------------------------------------------------
	            if(Info[playerid][Flight] == 1) return SendClientMessage(playerid, BRIGHT_RED, "You have been already started the flight (pilot) work.");
	            if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 519) return SendClientMessage(playerid, BRIGHT_RED, "You must have enter the shamal [519].");
	            //--------------------------------------------------------------
	            SetPlayerCheckpoint(playerid, 1477.5029, 1787.5417, 11.7342, 10);
	            format(string, sizeof(string), "You must follow the red markers and you will recieve money.");
	            SendClientMessage(playerid, LIME_GREEN, string);
	            Info[playerid][Trash] = 1;
	            //--------------------------------------------------------------
	            SetVehiclePos(GetPlayerVehicleID(playerid), 1521.8220, 1175.0295, 11.7344);
	            SetVehicleZAngle(GetPlayerVehicleID(playerid), 0);
	            SetPlayerVirtualWorld(playerid, 0);
	            SetPlayerInterior(playerid, 0);
	        }
	    }
	    return 1;
	}
	return 0;
}
//==============================================================================
COMMAND:jobs(playerid, params[])
{
	ShowPlayerDialog(playerid, DIALOG_EX + 1, DIALOG_STYLE_LIST, "Jobs", "{FFFFFF}Harvest\nPizzaboy\nSweeper\nPlumber\nTrash Master\nFlight", "Okay", "Cancel");
	return 1;
}
COMMAND:work(playerid, params[])
{
	return cmd_jobs(playerid, params);
}