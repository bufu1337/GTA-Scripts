//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
// [FS] Car Service By Schwan                       -_-
// -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
#include <a_samp>

new NotCarUp[MAX_PLAYERS];
new washTimer[MAX_PLAYERS];
new EntryTimer[MAX_PLAYERS];

new vehspecTimer;

new gates;

new wash1;
new wash2;
new wash3;

new servis1;
new servis2;
new servis3;
new servis4;

new CarSpecCarUp[MAX_PLAYERS];
new SpecVeh[MAX_PLAYERS];

new Menu:servismenu;

new RandomPlayerWheels[][] = {
	{1073},
	{1074},
	{1075},
	{1076},
	{1077},
	{1078},
	{1079},
	{1080},
	{1082},
	{1081},
	{1083},
	{1084},
	{1085},
	{1096},
	{1097},
	{1098},
	{1025}
};
new RandomPlayerPaintjob[][] = {
	{0},
	{1},
	{2}
};

forward vehspecoff(playerid);
forward Entry(playerid);
forward RandomWheels(playerid);
forward RandomPaintjob(playerid);
forward VehSpecTime();
forward washoff(playerid);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);

#define COLOR_BLUE 0x95DFECFF
#define COLOR_RED 0xFF6A6AFF
#define COLOR_GREEN 0x00FF00FF
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_YELLOW 0xFFFF00AA
#define COLOUR_RED 0xFF0000FF
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_LIGHTBLUE 0x33CCFFAA

#if defined FILTERSCRIPT

#else

#endif

public OnFilterScriptInit()
{
vehspecTimer= SetTimer("VehSpecTime", 1000, 1);

servismenu = CreateMenu("Tuning", 1, 50.0, 180.0, 200.0, 200.0);

AddMenuItem(servismenu, 0, "Sultan");
AddMenuItem(servismenu, 0, "Elegy");
AddMenuItem(servismenu, 0, "Infernus");
AddMenuItem(servismenu, 0, "JESTER");
AddMenuItem(servismenu, 0, "URANUS");
AddMenuItem(servismenu, 0, "FLASH");

CreateObject(8947,1603.930176,1067.470581,12.873093,0.000000,0.000000,-270.001038);
CreateObject(925,1613.963623,1061.370850,10.882217,0.000000,0.000000,56.250233); 
CreateObject(930,1614.697510,1063.050781,10.296188,0.000000,0.000000,33.750153);
CreateObject(2567,1593.188232,1063.113159,11.695385,0.000000,0.000000,90.000328); 
CreateObject(930,1592.784424,1066.670532,10.248601,0.000000,0.000000,146.250565); 
CreateObject(931,1593.469238,1072.652222,10.840818,0.000000,0.000000,236.250946); 
CreateObject(1362,1607.507080,1061.202393,10.418796,0.000000,0.000000,0.000000); 
CreateObject(1362,1606.311890,1061.121460,10.393796,0.000000,0.000000,0.000000); 
CreateObject(1362,1606.904053,1061.739746,10.418796,0.000000,0.000000,0.000000); 
CreateObject(1617,1591.755859,1062.155518,14.436832,0.000000,0.000000,0.000115); 
CreateObject(1618,1591.931030,1061.988159,14.325717,0.000000,0.000000,168.750641); 
CreateObject(2649,1595.933960,1072.525635,15.377554,2.578320,-179.623306,180.000717); 
CreateObject(3631,1603.850220,1073.428223,10.398609,0.000000,0.000000,0.000000); 
CreateObject(1520,1600.699097,1073.657104,11.037235,0.000000,0.000000,0.000000);
CreateObject(1665,1600.947144,1073.673096,11.038558,0.000000,0.000000,0.000000); 
CreateObject(1484,1592.880615,1066.988037,9.951366,0.000000,0.000000,78.750313); 
CreateObject(2844,1600.120605,1060.523438,9.872662,0.000000,0.000000,0.000000); 
CreateObject(2845,1600.388306,1060.888794,9.830293,0.000000,0.000000,101.250397); 
CreateObject(1421,1598.451050,1073.225952,10.582878,0.000000,0.000000,-11.250070); 
CreateObject(2063,1615.005005,1072.763428,10.729265,0.000000,0.000000,-90.000328); 
CreateObject(1738,1609.029053,1074.344727,10.508217,0.000000,0.000000,180.000717); 
CreateObject(1747,1593.424072,1072.803101,11.898851,0.000000,0.000000,67.500244); 
CreateObject(1509,1600.677612,1074.005737,11.175560,0.000000,0.000000,0.000000); 
CreateObject(2342,1606.681274,1074.176270,11.086957,0.000000,0.000000,0.000000); 
CreateObject(2814,1606.120361,1073.593872,10.983038,0.000000,0.000000,0.000000); 
CreateObject(1436,1592.943481,1068.913086,11.329373,0.000000,0.000000,90.000328); 
CreateObject(1428,1594.654419,1061.903076,11.269690,0.000000,0.000000,78.750259); 
CreateObject(3787,1612.676514,1073.384277,10.386546,0.000000,0.000000,0.000000); 
CreateObject(918,1605.508789,1061.698120,10.191841,0.000000,0.000000,33.750153); 
CreateObject(1238,1594.895142,1069.096924,10.109978,0.000000,0.000000,0.000000); 
CreateObject(1238,1594.842285,1066.011475,10.109500,0.000000,0.000000,0.000000); 
CreateObject(1238,1594.805298,1066.931763,10.109165,0.000000,0.000000,0.000000); 
CreateObject(1238,1594.853271,1068.115601,10.109599,0.000000,0.000000,0.000000); 
CreateObject(1238,1595.013062,1070.220215,10.111043,0.000000,0.000000,0.000000); 
CreateObject(1673,1600.967041,1057.082642,10.622448,181.342178,0.000000,112.500412);
CreateObject(1673,1598.891602,1056.328491,10.610147,181.342178,0.000000,78.750259); 
CreateObject(1673,1595.317993,1060.097656,10.559645,181.342178,0.000000,78.750259);
CreateObject(1673,1598.859375,1060.050293,10.589440,181.342178,0.000000,78.750259);
CreateObject(3864,1593.759521,1073.715088,8.716309,0.000000,0.000000,123.750481);
CreateObject(3528,1607.995239,1060.960083,6.909502,0.000000,-120.321541,45.000164);
CreateObject(2226,1594.221436,1073.116821,11.909676,0.000000,0.000000,101.250397);
CreateObject(2232,1596.066895,1073.539551,10.225263,5.156640,71.333466,19.921762);
CreateObject(2232,1596.677979,1073.414185,10.145352,-35.237041,0.000000,-17.188801);

servis1= CreateObject(2679,1600.597778,1069.268311,9.854546,90.241142,0.000000,0.000000);
servis2= CreateObject(2679,1600.596313,1067.004150,9.854553,90.241142,0.000000,0.000057);
servis3=CreateObject(2679,1597.282715,1066.978882,9.826653,91.100586,0.000000,0.000057);
servis4= CreateObject(2679,1597.287354,1069.296143,9.844713,90.241142,0.000000,0.000000);

gates= CreateObject(8948,1615.733032,1067.523926,11.616592,0.000000,0.000000,180.000717);

AddStaticVehicle(559,1623.7092,1067.3308,10.8203,91.5058,-1,-1);
}

public OnFilterScriptExit()
{
	DestroyMenu(Menu:servismenu);
	KillTimer(vehspecTimer);
	return 1;
}

public OnPlayerConnect( playerid )
{
NotCarUp[playerid] = 1;
//SetPlayerMapIcon( playerid, 27, 1604.5216,1067.8246,10.5474, 52, 0 );
}

public OnPlayerDisconnect(playerid, reason)
{
	CarSpecCarUp[playerid] = 0;
	return 1;
}


public OnPlayerCommandText(playerid,cmdtext[])
{
	/*if( !strcmp(cmdtext,"/4iki",true ))
	{
		{
			SetPlayerPos(playerid,1623.7092,1064.3308,10.8203);
		}
		return 1;
	}*/
	
	if( !strcmp(cmdtext,"/car-wash",true ))
	{
		{
		if(NotCarUp[playerid] == 1)
		{
		SendClientMessage(playerid, COLOR_RED, " And Che met you wash, air? You have to be on the jacks!");
		return 1;
		}
		wash1 = CreateObject(9833,1600.315796,1057.088989,12.172827,0.000000,84.225060,99.694984);
		wash2 = CreateObject(9833,1598.153442,1078.591187,12.247868,0.000000,84.225060,-83.365623);
		wash3 = CreateObject(9833,1599.027954,1068.668701,6.497861,0.000000,1.718880,-83.365623);
		washTimer[playerid]= SetTimerEx("washoff", 6000, false, "i", playerid);
		}
		return 1;
	}

	if(strcmp("/opendoor", cmdtext, true, 9) == 0)
	{
		if(PlayerToPoint(7, playerid, 1617.5094,1068.0148,10.8203))
			{
		SendClientMessage(playerid, COLOR_WHITE,"[Vehicle master]:The Vehicle master door is open");
	//	SendClientMessage(playerid, COLOR_WHITE,"[Vehicle master]:Ворота Car Service Открыты");
		MoveObject(gates, 1615.728394,1067.499023,14.925826, 5);
		SetPlayerCameraPos(playerid, 1593.188354,1072.734985,11.3000);
		SetPlayerCameraLookAt(playerid, 1593.188354,1072.734985,11.3000);
		EntryTimer[playerid]=	SetTimerEx("Entry", 1100, false, "i", playerid);
		SendClientMessage(playerid, COLOR_YELLOW,"[Master Info]:Put the car on jacks and Use: / carup");
			 }
			else
			 {
		SendClientMessage(playerid, COLOUR_RED, "You're too far away from the door of the service ");
			 }
		return 1;
	}
	
	if(strcmp("/closedoor", cmdtext, true, 9) == 0)
	{
	 	{
 		SendClientMessage(playerid, COLOR_WHITE,"[Vehicle master]:The Vehicle master door is close");
 	//	SendClientMessage(playerid, COLOR_WHITE,"[Vehicle master]:Ворота Car Service Закрыты");
 		MoveObject(gates, 1615.728394,1067.499023,11.925826, 5);
		}
		return 1;
	}
        

	if( !strcmp(cmdtext,"/cardown",true ))
	{
		{
		MoveObject(servis1, 1600.597778,1069.268311,9.854546, 1);
		MoveObject(servis2, 1600.596313,1067.004150,9.854553, 1);
		MoveObject(servis3, 1597.282715,1066.978882,9.826653, 1);
		MoveObject(servis4, 1597.287354,1069.296143,9.819668, 1);
		SendClientMessage(playerid, COLOR_RED,"[Vehicle master]:car down");
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid,1);
		CarSpecCarUp[playerid] = 0;
		NotCarUp[playerid] = 1;
		}
		return 1;
	}

	if( !strcmp(cmdtext,"/carup",true ))
	{
		if(PlayerToPoint(5, playerid, 1598.6506,1067.9191,13.5383))
			{
		if(IsPlayerInAnyVehicle(playerid))
 			{
		NotCarUp[playerid] = 0;
        MoveObject(servis1, 1600.597778,1069.268311,12.804501, 1);
        MoveObject(servis2, 1600.596313,1067.004150,12.804508, 1);
        MoveObject(servis3, 1597.282715,1066.978882,12.801607, 1);
        MoveObject(servis4, 1597.287354,1069.296143,12.819668, 1);
		SendClientMessage(playerid, COLOR_YELLOW,"[Master Info]:To wash the car use: /car-wash");
		SendClientMessage(playerid, COLOR_YELLOW,"[Master Info]:To Spectate Car to down use: /vehspec");
	    SendClientMessage(playerid, COLOR_LIGHTBLUE,"[Vehicle master]:Vehicle up(To down use: /cardown)");
		TogglePlayerControllable(playerid, 0);
		ShowMenuForPlayer(servismenu, playerid);
		CarSpecCarUp[playerid] = 1;
			}
		else
				{
		SendClientMessage(playerid, COLOUR_RED, "You must be in the car");
				}
    	}
		else
    	{
		SendClientMessage(playerid, COLOUR_RED, " You have to be on jacks Car Service ");
			 }
		return 1;
		}

	if( !strcmp(cmdtext,"/vehspec",true ))
	{
		{
		SetPlayerCameraPos(playerid, 1595.7020,1066.9425,10.8100);
		SetPlayerCameraLookAt(playerid, 1599.7020,1067.9425,13.8203);
		CarSpecCarUp[playerid] = 0;
		SendClientMessage(playerid, COLOR_YELLOW,"[Master Info]:To complete the spec of machine use: /vehspecoff");
		}
		return 1;
	}
	
	if( !strcmp(cmdtext,"/vehspecoff",true ))
	{
		{
	    SetCameraBehindPlayer(playerid);
	    CarSpecCarUp[playerid] = 0;
		}
		return 1;
	}


	if( !strcmp(cmdtext,"/Crshelp",true ))
	{
    	{
        SendClientMessage(playerid,COLOR_WHITE, "Car Servis Help:");
        SendClientMessage(playerid,COLOR_GREY, "'/opendoor - open door Service' '/closedoor - close door service'");
		SendClientMessage(playerid,COLOR_GREY, "'/carup - up car to jacks' '/cardown - down car jacks'");
		SendClientMessage(playerid,COLOR_GREY, "'/vehspec - spectate car.' '/vehspecoff - spectate car off'" );
  		SendClientMessage(playerid,COLOR_GREY, "'/car-wash - wash car'");
    	}
		return 1;
	}
	return 0;
}

public Entry(playerid)
	{
		SetCameraBehindPlayer(playerid);
	 	KillTimer(EntryTimer[playerid]);
	}
	
public washoff(playerid)
	{
//		DestroyObject(wash);
		DestroyObject(wash1);
		DestroyObject(wash2);
		DestroyObject(wash3);
  		SendClientMessage(playerid,COLOR_GREEN, "Your Vehicle Washing");
  		KillTimer(washTimer[playerid]);
	}

public OnPlayerSelectedMenuRow(playerid, row)
{
	if(GetPlayerMenu(playerid) == servismenu)
    {
		new vehicleid = GetPlayerVehicleID(playerid);
    	new cartype = GetVehicleModel(vehicleid);
    	TogglePlayerControllable(playerid, 0);
    	switch(row)
        {
            case 0:
			{ 
   				if(cartype == 560)
  				{
					AddVehicleComponent(vehicleid,1139);
					AddVehicleComponent(vehicleid,1026);
					AddVehicleComponent(vehicleid,1027);
					AddVehicleComponent(vehicleid,1029);
					AddVehicleComponent(vehicleid,1032);
					AddVehicleComponent(vehicleid,1149);
					AddVehicleComponent(vehicleid,1141);
					AddVehicleComponent(vehicleid,1169);
					AddVehicleComponent(vehicleid,1010);
					AddVehicleComponent(vehicleid,1079);
					AddVehicleComponent(vehicleid,1098);
					AddVehicleComponent(vehicleid,1087);
					RandomWheels(playerid);
					SendClientMessage(playerid, COLOR_WHITE,"Your SULTAN tunned!");
					RandomPaintjob(playerid);
					SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.000);
				}
				else
				{
					ShowMenuForPlayer(servismenu, playerid);
					SendClientMessage(playerid, COLOUR_RED,"Choose a car that you sit down!");
				}
            }
            case 1:
			{
 				if(cartype == 562)
				{
					AddVehicleComponent(vehicleid,1146);
					AddVehicleComponent(vehicleid,1034);
					AddVehicleComponent(vehicleid,1035);
					AddVehicleComponent(vehicleid,1036);
					AddVehicleComponent(vehicleid,1040);
					AddVehicleComponent(vehicleid,1149);
					AddVehicleComponent(vehicleid,1171);
					AddVehicleComponent(vehicleid,1010);
					AddVehicleComponent(vehicleid,1079);
					RandomWheels(playerid);
					AddVehicleComponent(vehicleid,1087);
					SendClientMessage(playerid, COLOR_WHITE,"Your ELEGY tunned!");
					RandomPaintjob(playerid);
					SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.000);
				}
				else
				{
					ShowMenuForPlayer(servismenu, playerid);
					SendClientMessage(playerid, COLOUR_RED,"Choose a car that you sit down!");
				}
            }
            case 2:
			{
 				if(cartype == 411)
				{
					AddVehicleComponent(vehicleid,1010);
					AddVehicleComponent(vehicleid,1087);
					RandomWheels(playerid);
					SendClientMessage(playerid, COLOR_WHITE,"Your INFERNUS tunned!");
					SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.000);
				}
				else
				{
					ShowMenuForPlayer(servismenu, playerid);
					SendClientMessage(playerid, COLOUR_RED,"Choose a car that you sit down!");
				}
            }
            case 3:
			{
				if(cartype == 559)
				{
					SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.000);
					AddVehicleComponent(vehicleid,1158);
					AddVehicleComponent(vehicleid,1162);
					AddVehicleComponent(vehicleid,1159);
					AddVehicleComponent(vehicleid,1160);
					AddVehicleComponent(vehicleid,1069);
					AddVehicleComponent(vehicleid,1070);
					AddVehicleComponent(vehicleid,1067);
					AddVehicleComponent(vehicleid,1065);
					AddVehicleComponent(vehicleid,1010);
					AddVehicleComponent(vehicleid,1079);
					AddVehicleComponent(vehicleid,1087);
					RandomWheels(playerid);
					RandomPaintjob(playerid);
					SendClientMessage(playerid, COLOR_WHITE,"Your JESTERS tunned! ");
	 	 		}
				else
				{
					ShowMenuForPlayer(servismenu, playerid);
					SendClientMessage(playerid, COLOUR_RED,"Choose a car that you sit down!");
				}
	    	 }
            case 4:
			{
				if(cartype == 558)
				{
					AddVehicleComponent(vehicleid,1164);
					AddVehicleComponent(vehicleid,1088);
					AddVehicleComponent(vehicleid,1092);
					AddVehicleComponent(vehicleid,1090);
					AddVehicleComponent(vehicleid,1094);
					AddVehicleComponent(vehicleid,1166);
					AddVehicleComponent(vehicleid,1168);
					AddVehicleComponent(vehicleid,1010);
					AddVehicleComponent(vehicleid,1079);
					AddVehicleComponent(vehicleid,1087);
					RandomWheels(playerid);
					SendClientMessage(playerid, COLOR_WHITE,"Your URANUS tunned!");
					RandomPaintjob(playerid);
					SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.000);
				}
				else
				{
					ShowMenuForPlayer(servismenu, playerid);
					SendClientMessage(playerid, COLOUR_RED,"Choose a car that you sit down!");
				}
   	 		 }
            case 5:
			{
				if(cartype == 565)
				{
					AddVehicleComponent(vehicleid,1049);
					AddVehicleComponent(vehicleid,1046);
					AddVehicleComponent(vehicleid,1047);
					AddVehicleComponent(vehicleid,1051);
					AddVehicleComponent(vehicleid,1054);
					AddVehicleComponent(vehicleid,1150);
					AddVehicleComponent(vehicleid,1153);
					AddVehicleComponent(vehicleid,1010);
					AddVehicleComponent(vehicleid,1079);
					AddVehicleComponent(vehicleid,1087);
					RandomWheels(playerid);
					SendClientMessage(playerid, COLOR_WHITE,"Your Flash tunned!");
					RandomPaintjob(playerid);
					SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.000);
				}
				else
				{
					ShowMenuForPlayer(servismenu, playerid);
					SendClientMessage(playerid, COLOUR_RED,"Choose a car that you sit down!");
				}
  		}
        }
    }
    return 1;
}

public VehSpecTime(){

	for(new i = 0; i < MAX_PLAYERS; i++){
	 if(IsPlayerConnected(i)){
		if(SpecVeh[i] >= 1){
		    SpecVeh[i] += 1;
		    if(SpecVeh[i] == 3){
      			SpecVeh[i] = 0;
			}
		}
		if(CarSpecCarUp[i] >= 1){
			CarSpecCarUp[i] += 1;
			if(CarSpecCarUp[i] == 2){
		        SetPlayerCameraPos(i, 1602.5063,1073.6509,13.1000);
		        SetPlayerCameraLookAt(i, 1599.5063,1067.6509,11.9781);
		        //SetPlayerCameraPos(playerid, 1601.9999,1074.357300,11.253327); CAMERA THIS DRINK
				//SetPlayerCameraLookAt(playerid, 1591.9999,1061.357100,11.253327);
											}
		    else if(CarSpecCarUp[i] == 8){
			    SetPlayerCameraPos(i, 1593.1758,1071.9589,12.9333);
		        SetPlayerCameraLookAt(i, 1596.1758,1068.9589,12.9116);
											}
			else if(CarSpecCarUp[i] == 18){
   				SetPlayerCameraPos(i, 1592.0000,1067.5800,14.4444);
		        SetPlayerCameraLookAt(i, 1593.0090,1067.5903,14.4444);
											}
			else if(CarSpecCarUp[i] == 26){
   				SetPlayerCameraPos(i,1598.2629,1061.2808,12.9890);
				SetPlayerCameraLookAt(i,1598.2629,1065.2808,12.9890);
											}
			else if(CarSpecCarUp[i] == 34){
			      CarSpecCarUp[i] = 1;
											}
			}

		}
	}
}

public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z){
    if(IsPlayerConnected(playerid)){
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi))){
			return 1;
		}
	}
	return 0;
}

public RandomWheels(playerid)
{
	{
		new car = GetPlayerVehicleID(playerid);
		new rand = random(sizeof(RandomPlayerWheels));
		AddVehicleComponent(car,RandomPlayerWheels[rand][0]);
    }
    return 1;
}

public RandomPaintjob(playerid)
{
	{
		new car = GetPlayerVehicleID(playerid);
		new rand = random(sizeof(RandomPlayerPaintjob));
		ChangeVehiclePaintjob(car,RandomPlayerPaintjob[rand][0]);
	}
	return 1;
}
