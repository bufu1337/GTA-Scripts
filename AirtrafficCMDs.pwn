#include <a_samp>
/*--------------------------------[ Airline Script ]--------------------------------

	This entire script is made by Bert
	Commands, Functions, Everything - Bert
	Idea - San Andreas Pilots Server ( [SAP] ), Credits for the Idea go to them!!

---------------------------------------------------------------------------------*/
#define MAX_AIRPORTS 4

forward UnBusy(Airportid);
forward TransMittingTakeoff(playerid);
forward TransMittingLand(playerid);
forward UnSOSSent(playerid);
forward TransMittingSOS(playerid);
forward AssignTailNumbers();

new IsSOSSent[MAX_PLAYERS];
new Tailnumbers[11][] = {
	"CO2-SO",
	"CO2-S5",
	"H2O-2F",
	"H2O-3F",
	"NO4-OH",
	"NO4-KA",
	"H3O-69",
	"007-HQ",
	"KGB-13",
	"SOL-V2",
	"BBQ-69"
};
new Float:Airfields[MAX_AIRPORTS][2] = {
	{1471.412, 1483.09}, //LV
	{1751.681, -2464.032}, //LS
	{-1401.345, -233.5575}, //SF
	{163.4902, 2499.065} //AA
};
new String[128];
new String2[128];
new VehicleTailNumber[MAX_VEHICLES][2];
new Airport[MAX_PLAYERS];
new AirportNames[MAX_AIRPORTS][] = {
	"Las Venturas",
	"Los Santos",
	"San Fierro",
	"Abandoned"
};
new IsBusy[MAX_AIRPORTS];
new IsPilot[MAX_PLAYERS] = 1;

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Airtower Control Script by Bert");
	print("--------------------------------------\n");

	AddStaticVehicle(519,1823.0800,-2628.3467,14.4658,1.1075,-1,-1); // LS1
	AddStaticVehicle(519,1752.4818,-2624.9763,14.4658,0.1762,-1,-1); // LS2

	AddStaticVehicle(519,1308.3832,1326.1230,11.7424,271.8051,1,1); // LV1
	AddStaticVehicle(519,1308.9734,1361.9771,11.7392,269.6093,1,1); // LV2

	AddStaticVehicle(519,-1597.7919,-275.8020,15.0705,34.3854,-1,-1); // SF1
	AddStaticVehicle(519,-1626.0074,-297.6174,15.0768,0.3330,-1,-1); // SF2

	AddStaticVehicle(519,215.5439,2542.7646,17.4851,180.8997,-1,-1); // AA1
	AddStaticVehicle(519,190.8071,2543.5164,17.4219,176.9432,-1,-1); // AA2


	SetTimer("AssignTailNumbers", 10000, 0);
	print("Ten seconds after loading, tailnumbering will start");

	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if (strcmp("/pilothelp", cmdtext, true, 10) == 0)
	{
	    SendClientMessage(playerid, 0x33AA33AA, "With this script, you can roleplay you're an onduty pilot!");
	    SendClientMessage(playerid, 0x33AA33AA, "commands: /land /takeoff /sos /pilotcredits");
		return 1;
	}
	if (strcmp("/pilotcredits", cmdtext, true, 10) == 0)
	{
	    SendClientMessage(playerid, 0x33AA33AA, "Everything, including distance functions, is made by Bert");
	    SendClientMessage(playerid, 0x33AA33AA, "Idea: [SAP] Server For Pilots scripted by [SAP]Ontario");
		return 1;
	}
	if (strcmp("/sos", cmdtext, true, 10) == 0)
	{
	    SetTimerEx("TransMittingSOS", 5000, 0, "i", playerid);
		GameTextForPlayer(playerid, "~g~Transmitting...", 3500, 3);
		return 1;
	}
	if (strcmp("/pilotjob", cmdtext, true, 10) == 0)
	{
	    if(IsPilot[playerid])
	    {
	        SendClientMessage(playerid, 0xFFFFFF, "You resigned as a pilot");
	        IsPilot[playerid] = 0;
	    }
	    else
	    {
	    	SendClientMessage(playerid, 0xFFFFFF, "You are now a pilot!");
	    	IsPilot[playerid] = 1;
	    }
		return 1;
	}
	if (strcmp("/takeoff", cmdtext, true, 10) == 0)
	{
	    if(IsPilot[playerid])
	    {
			if(IsAirVehicle(vehicleid))
		    {
		        Airport[playerid] = GetClosestAirfield(playerid);
		        SetTimerEx("TransMittingTakeoff", 5000, 0, "i", playerid);
				GameTextForPlayer(playerid, "~g~Transmitting...", 3500, 3);
			}
			else
			{
			    SendClientMessage(playerid, 0xFFFFFF, "You are not in a  air vehicle");
			}
		}
		else
		{
		    SendClientMessage(playerid, 0xFFFFFF, "You are not a pilot");
		}
		return 1;
	}
	if (strcmp("/land", cmdtext, true, 10) == 0)
	{
	    if(IsPilot[playerid])
	    {
		    if(IsAirVehicle(vehicleid))
		    {
		        Airport[playerid] = GetClosestAirfield(playerid);
				SetTimerEx("TransMittingLand", 5000, 0, "i", playerid);
				GameTextForPlayer(playerid, "~g~Transmitting...", 3500, 3);
			}
			else
			{
			    SendClientMessage(playerid, 0xFFFFFF, "You are not in a air vehicle");
			}
		}
		else
		{
		    SendClientMessage(playerid, 0xFFFFFF, "You are not a pilot");
		}
		return 1;
	}
	return 0;
}

stock IsAirVehicle(carid)
{
    new AirVeh[] = { 592, 577, 511, 512, 593,
		  			 520, 553, 476, 519, 460,
					 513, 548, 425, 417, 487,
					 488, 497, 563, 447, 469
	};
    for(new i = 0; i < sizeof(AirVeh); i++)
    {
        if(GetVehicleModel(carid) == AirVeh[i]) return 1;
    }
    return 0;
}

stock GetClosestAirfield(playerid)
{
	new Float:Dist;
	new Float:Dist2 = 9999;
	new AirfieldNumber;
	for(new i = 0; i < 4; i ++)
	{
	    new Float:x, Float:y, Float:z, Float:x1, Float:y1;
	    GetPlayerPos(playerid, x, y, z);
    	x1 = x-Airfields[i][0];
    	y1 = y-Airfields[i][1];
	    Dist = floatsqroot(x1*x1+y1*y1);
		if(Dist < Dist2)
		{
		    Dist2 = Dist;
		    AirfieldNumber = i;
		}
	}
	return AirfieldNumber;
}

public UnBusy(Airportid)
	IsBusy[Airportid] = 0;

public UnSOSSent(playerid)
	IsSOSSent[playerid] = 0;

public AssignTailNumbers()
{
	for(new i = 0; i< MAX_VEHICLES; i++) SetVehicleToRespawn(i);
	print("All airvehicles have been assigned a tailnumber");
}

public TransMittingSOS(playerid)
{
    new MaxPlayers = GetMaxPlayers(), vehicleid = GetPlayerVehicleID(playerid), Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    if(IsSOSSent[playerid] == 0)
	{
		for(new i = 0; i < MaxPlayers; i ++)
		{
			if(IsPilot[i])
			{
			 	format(String, 128, "~w~ATC: Flight ~b~'%d-%s' ~w~Sends SOS from: (%.0f, %.0f)", VehicleTailNumber[vehicleid][0], Tailnumbers[VehicleTailNumber[vehicleid][1]], x, y);
			 	format(String2, 128, "ATC: Flight '%d-%s' Sends SOS from: (%.0f, %.0f)", VehicleTailNumber[vehicleid][0], Tailnumbers[VehicleTailNumber[vehicleid][1]], x, y);
			 	SendClientMessage(i, 0xFFFFFF, String2);
				GameTextForPlayer(i, String, 6000, 4);
			}
		}
		IsSOSSent[playerid] = 1;
		SetTimerEx("UnSOSSent", 30000, 0, "i", playerid);
	}
	else
	{
		SendClientMessage(playerid, 0xFFFFFF, "You can use /sos only once half a minute!");
	}
}

public TransMittingTakeoff(playerid)
{
    new MaxPlayers = GetMaxPlayers();
    new vehicleid = GetPlayerVehicleID(playerid);
    if(IsBusy[Airport[playerid]] == 0)
	{
		for(new i = 0; i < MaxPlayers; i ++)
		{
			if(IsPilot[i])
			{
			    if(i != playerid)
				{
			 		format(String, 128, "~w~ATC: Flight ~b~'%d-%s' ~w~is going to takeoff from ~r~%s Airport", VehicleTailNumber[vehicleid][0], Tailnumbers[VehicleTailNumber[vehicleid][1]], AirportNames[Airport[playerid]]);
			 		format(String2, 128, "ATC: Flight '%d-%s' is going to takeoff from %s Airport", VehicleTailNumber[vehicleid][0], Tailnumbers[VehicleTailNumber[vehicleid][1]], AirportNames[Airport[playerid]]);
					SendClientMessage(i, 0xFFFFFF, String2);
					GameTextForPlayer(i, String, 6000, 4);
				}
				else
				{
					format(String, 128, "~w~ATC: Flight ~b~'%d-%s' ~w~you are clear to takeoff from ~r~%s Airport", VehicleTailNumber[vehicleid][0], Tailnumbers[VehicleTailNumber[vehicleid][1]], AirportNames[Airport[playerid]]);
					format(String2, 128, "ATC: Flight '%d-%s' you are clear to takeoff from %s Airport", VehicleTailNumber[vehicleid][0], Tailnumbers[VehicleTailNumber[vehicleid][1]], AirportNames[Airport[playerid]]);
					SendClientMessage(i, 0xFFFFFF, String2);
					GameTextForPlayer(i, String, 6000, 4);
				}
			}
		}
		IsBusy[Airport[playerid]] = 1;
		SetTimerEx("UnBusy", 30000, 0, "i", Airport[playerid]);
	}
	else
	{
	    format(String, 128, "The %s Airport is already busy with an other flight, hold on a minute!", AirportNames[Airport[playerid]]);
		format(String2, 128, "~g~The %s Airport is already busy", AirportNames[Airport[playerid]]);
		SendClientMessage(playerid, 0xFFFFFF, String);
		GameTextForPlayer(playerid, String2, 3000, 3);
	}
}

public TransMittingLand(playerid)
{
    new MaxPlayers = GetMaxPlayers();
    new vehicleid = GetPlayerVehicleID(playerid);
	if(IsBusy[Airport[playerid]] == 0)
	{
	    for(new i = 0; i < MaxPlayers; i ++)
	    {
			if(IsPilot[i])
		    {
		        if(i != playerid)
		        {
					format(String, 128, "~w~ATC: Flight ~b~'%d-%s' ~w~is going to land on ~r~%s Airport", VehicleTailNumber[vehicleid][0], Tailnumbers[VehicleTailNumber[vehicleid][1]], AirportNames[Airport[playerid]]);
					format(String2, 128, "ATC: Flight '%d-%s' is going to land on %s Airport", VehicleTailNumber[vehicleid][0], Tailnumbers[VehicleTailNumber[vehicleid][1]], AirportNames[Airport[playerid]]);
		            SendClientMessage(i, 0xFFFFFF, String2);
		            GameTextForPlayer(i, String, 6000, 4);
		        }
		        else
		        {
		            format(String, 128, "~w~ATC: Flight ~b~'%d-%s' ~w~you are clear to land on ~r~%s Airport", VehicleTailNumber[vehicleid][0], Tailnumbers[VehicleTailNumber[vehicleid][1]], AirportNames[Airport[playerid]]);
		            format(String2, 128, "ATC: Flight '%d-%s' you are clear to land on %s Airport", VehicleTailNumber[vehicleid][0], Tailnumbers[VehicleTailNumber[vehicleid][1]], AirportNames[Airport[playerid]]);
		            SendClientMessage(i, 0xFFFFFF, String2);
		            GameTextForPlayer(i, String, 6000, 4);
		        }
		    }
		    IsBusy[Airport[playerid]] = 1;
			SetTimerEx("UnBusy", 30000, 0, "i", Airport[playerid]);
		}
	}
	else
	{
	    format(String, 128, "The %s Airport is already busy with an other flight, hold on a minute!", AirportNames[Airport[playerid]]);
		format(String2, 128, "~g~The %s Airport is already busy", AirportNames[Airport[playerid]]);
		SendClientMessage(playerid, 0xFFFFFF, String);
		GameTextForPlayer(playerid, String2, 3000, 4);
	}
}

public OnVehicleSpawn(vehicleid)
{
	if(IsAirVehicle(vehicleid))
	{
	    VehicleTailNumber[vehicleid][0] = random(99);
	    VehicleTailNumber[vehicleid][1] = random(11);
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(IsAirVehicle(vehicleid))
	{
	    format(String, sizeof(String), "Your tailnumber is '%d-%s'", VehicleTailNumber[vehicleid][0], Tailnumbers[VehicleTailNumber[vehicleid][1]]);
	    SendClientMessage(playerid, 0xFFFFFF, String);
	}
	return 1;
}

// 325 lines! all scripted by moi!