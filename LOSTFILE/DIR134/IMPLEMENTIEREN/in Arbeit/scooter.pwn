#include <a_samp>
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA


// This is an Car Scooter System by Bboy92
// This Fs Spawnes at Los Santos  Mulholland Inserrecton
// © By Bboy92
// You are allowed to Remove the Text on OnPLayerConnect
// If you got one Server who is running my Sys post it in Sa-Mp Forum in the Topic : http://forum.sa-mp.com/index.php?topic=69856.0
// If you have Problems send me an Email to : admin@east-south-rpg.com
// Or add me in MSN : mirkoiz@hotmail.de or ICQ : 481399424
// Have fun


#define FILTERSCRIPT

#if defined FILTERSCRIPT

new scootergate,entergate;
forward pclose();
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Bboy92´s Big Scooter System Loaded");
	print("--------------------------------------\n");
	return 1;
}

#endif

public OnGameModeInit()
{
	CreateObject(12814, 1670.287964, -1092.766113, 23.375856, 0.0000, 0.0000, 357.4217);
	CreateObject(982, 1671.231689, -1117.808228, 23.564806, 0.0000, 0.0000, 87.6625);
	CreateObject(982, 1654.686768, -1106.256592, 23.589806, 0.0000, 0.0000, 357.4217);
	CreateObject(982, 1655.848633, -1080.622559, 23.589806, 0.0000, 0.0000, 357.4217);
	CreateObject(982, 1669.275024, -1067.756592, 23.592230, 0.0000, 0.0000, 267.1809);
	CreateObject(984, 1656.145752, -1073.671143, 23.535118, 0.0000, 0.0000, 357.4217);
	CreateObject(984, 1679.979492, -1068.271484, 23.570354, 0.0000, 0.0000, 86.8030);
	CreateObject(982, 1685.723267, -1081.413940, 23.592226, 0.0000, 0.0000, 357.4217);
	CreateObject(982, 1684.684814, -1105.491577, 23.364809, 0.0000, 0.0000, 357.4217);
	CreateObject(973, 1676.399536, -1114.140625, 24.223888, 0.0000, 0.0000, 357.4217);
	CreateObject(973, 1667.207275, -1113.733276, 24.223888, 0.0000, 0.0000, 357.4217);
	CreateObject(973, 1661.672241, -1113.462524, 24.253410, 0.0000, 0.0000, 357.4217);
	CreateObject(973, 1657.193970, -1108.622314, 24.223888, 0.0000, 0.0000, 268.0403);
	CreateObject(973, 1657.500122, -1099.569214, 24.223888, 0.0000, 0.0000, 268.0403);
	CreateObject(973, 1658.127075, -1081.171997, 24.223888, 0.0000, 0.0000, 268.0403);
	CreateObject(973, 1658.365845, -1074.201294, 24.223888, 0.0000, 0.0000, 268.0403);
	CreateObject(973, 1663.190918, -1069.702271, 24.223888, 0.0000, 0.0000, 177.7990);
	CreateObject(973, 1672.423706, -1070.050293, 24.223888, 0.0000, 0.0000, 177.7990);
	CreateObject(973, 1680.802979, -1070.397949, 24.263649, 0.0000, 0.0000, 177.7990);
	CreateObject(973, 1683.291870, -1075.353271, 24.223888, 0.0000, 0.0000, 85.8394);
	CreateObject(973, 1682.762939, -1084.303101, 24.223888, 0.0000, 0.0000, 87.5583);
	CreateObject(973, 1682.358032, -1093.578369, 24.223886, 0.0000, 0.0000, 87.5583);
	CreateObject(973, 1682.004639, -1102.681396, 24.223888, 0.0000, 0.0000, 87.5583);
	CreateObject(973, 1681.512451, -1109.824341, 24.181271, 0.0000, 0.0000, 84.7478);
	CreateObject(969, 1637.129517, -1085.310913, 26.948122, 90.2408, 0.0000, 0.0000);
	CreateObject(969, 1637.141968, -1088.452271, 26.948133, 90.2408, 0.0000, 0.0000);
	CreateObject(969, 1628.316162, -1085.330200, 26.948126, 90.2408, 0.0000, 0.0000);
	CreateObject(969, 1628.270874, -1088.452271, 26.948130, 90.2408, 0.0000, 0.0000);
	CreateObject(969, 1637.046021, -1082.124268, 26.973114, 90.2408, 0.0000, 0.0000);
	CreateObject(969, 1628.144287, -1082.158203, 26.948130, 90.2408, 0.0000, 0.0000);
	CreateObject(969, 1637.043457, -1091.590332, 26.573128, 0.0000, 0.0000, 0.0000);
	CreateObject(969, 1628.239258, -1091.556641, 26.573116, 0.0000, 0.0000, 0.0000);
	CreateObject(969, 1628.317017, -1091.466309, 26.623131, 0.0000, 0.0000, 89.3814);
	CreateObject(969, 1628.537354, -1082.737671, 26.623127, 0.0000, 0.0000, 1.7189);
	CreateObject(969, 1637.384888, -1082.453979, 26.623127, 0.0000, 0.0000, 1.7189);
	CreateObject(1655, 1649.421997, -1086.911499, 25.606356, 347.1084, 0.0000, 90.2408);
	CreateObject(1633, 1657.639038, -1086.756348, 24.433964, 0.0000, 359.1406, 90.2408);
	CreateObject(973, 1657.989136, -1088.914063, 25.073875, 0.0000, 17.1887, 0.0000);
	CreateObject(973, 1657.961182, -1084.832275, 24.796915, 0.0000, 17.1887, 0.0000);
	CreateObject(973, 1649.347046, -1083.497192, 26.948395, 0.0000, 9.4538, 341.9518);
	CreateObject(973, 1649.393799, -1090.234375, 27.185333, 0.0000, 351.4056, 198.5303);
	scootergate = CreateObject(974, 1654.455078, -1086.625000, 28.333668, 0.0000, 0.0000, 269.7592);
	CreateObject(974, 1654.408691, -1086.567871, 18.680094, 0.0000, 0.0000, 269.7592);
	CreateObject(971, 1649.682373, -1083.510620, 29.932610, 0.0000, 8.5944, 341.9518);
	CreateObject(971, 1650.360840, -1089.891235, 29.468332, 0.0000, 348.8273, 199.2851);
	CreateObject(1226, 1681.099487, -1095.803345, 27.258087, 0.0000, 0.0000, 0.0000);
	CreateObject(14387, 1657.358643, -1118.373413, 22.436279, 0.0000, 0.0000, 266.3215);
	CreateObject(3863, 1659.845093, -1115.801025, 24.555998, 0.0000, 0.0000, 268.0403);
	CreateObject(1226, 1669.072266, -1070.997437, 27.258089, 0.0000, 0.0000, 97.8714);
	CreateObject(1226, 1668.881958, -1112.655884, 26.922333, 0.0000, 0.0000, 280.9319);
	CreateObject(1226, 1659.226807, -1082.728394, 26.163170, 0.0000, 0.0000, 167.5904);
	entergate = CreateObject(979, 1657.740723, -1091.077881, 24.223888, 0.0000, 0.0000, 89.3814);
	AddStaticVehicle(539,1630.4913,-1089.9491,27.3505,271.4548,79,74); //
	AddStaticVehicle(539,1634.9023,-1090.0009,27.3503,269.1850,79,74); //
	AddStaticVehicle(539,1639.0449,-1090.0599,27.3501,269.1840,79,74); //
	AddStaticVehicle(539,1643.7450,-1089.9902,27.3503,272.6862,79,74); //
	AddStaticVehicle(571,1629.7360,-1083.7452,27.2740,268.8026,66,72); //
	AddStaticVehicle(571,1631.9969,-1083.7906,27.2740,268.8781,66,72); //
	AddStaticVehicle(571,1635.7053,-1083.8584,27.2732,268.9840,66,72); //
	AddStaticVehicle(571,1639.2253,-1083.9059,27.2988,269.4764,66,72); //
	AddStaticVehicle(571,1642.9716,-1083.9333,27.2978,269.7520,66,72); //
	return 1;
}

public OnPlayerConnect(playerid)
{
	new string[256];
	format(string,256,"Hello , this Server is using Bboy92`s Scooter System");
	SendClientMessage(playerid, COLOR_GREEN, string);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp(cmdtext,"/openscooterparkgate",true) == 0)
	{
    	if(IsPlayerAdmin(playerid))
	    {
		    MoveObject(scootergate, 1654.408691, -1086.567871, 18.680094, 2.5);  // 2.5 = Moove Speed
	     	SetTimer("pclose",8000,false);  // 8000 -> 8000ms = Time until the Gate Close
		    new string[256];
		    format(string,256,"You opened the Scooter Parking Place Suessfully ( It will cose in 8 Secounds automatic)");
      		SendClientMessage(playerid, COLOR_GREEN, string);
	 		return 1;
		}
		else
		{
		    new string[256];
		    format(string,256,"You are not an Administrator");
    		SendClientMessage(playerid, COLOR_RED, string);
		}
	}
	if (strcmp(cmdtext,"/openscooterguestgate",true) == 0)
	{
    	if(IsPlayerAdmin(playerid))
	    {
		    MoveObject(entergate, 1654.408691, -1086.567871, 18.680094, 2.5);  // 2.5 = Moove Speed
		    new string[256];
		    format(string,256,"You opened the Scooter Place Suessfully ");
      		SendClientMessage(playerid, COLOR_GREEN, string);
	 		return 1;
		}
		else
		{
		    new string[256];
		    format(string,256,"You are not an Administrator");
    		SendClientMessage(playerid, COLOR_RED, string);
		}
	}
	if (strcmp(cmdtext,"/closescooterguestgate",true) == 0)
	{
    	if(IsPlayerAdmin(playerid))
	    {
		    MoveObject(entergate, 1657.740723, -1091.077881, 24.223888, 2.5);  // 2.5 = Moove Speed
		    new string[256];
		    format(string,256,"You closed the Scooter Place Suessfully ");
      		SendClientMessage(playerid, COLOR_GREEN, string);
	 		return 1;
		}
		else
		{
		    new string[256];
		    format(string,256,"You are not an Administrator");
    		SendClientMessage(playerid, COLOR_RED, string);
		}
	}
	return 0;
}
public pclose()
{
    MoveObject(scootergate, 1654.455078, -1086.625000, 28.333668, 2.5);  // 2.5 = Moove Speed
    return 1;
}
