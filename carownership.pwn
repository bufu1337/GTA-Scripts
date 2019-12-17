//===========================Section: Includes==================================
#include <a_samp>
#include <utils>
//===========================Section: Definations===============================
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD6 0xF0F0F0FF
#define COLOR_GREEN 0x33AA33AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_YELLOW2 0xF5DEB3AA
#define COLOR_BLUE 0x2641FEAA

#define DIALOGID 9999
//===========================Section: Forwards==================================
forward split(const strsrc[], strdest[][], delimiter);
forward LoadCar();
forward SaveCarCoords();
forward LoadComponents(vehicleid);
forward OnPropUpdate();
forward IsAnOwnableCar(vehicleid);
forward IsAtDealership(playerid);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward CarMods(vehicleid);

forward ProxDetectorS(Float:radi, playerid, targetid);
forward CarKeys(playerid);
forward SavePlayerData(playerid);
forward ini_GetKey( line[] );
forward ini_GetValue( line[] );
forward OnPlayerKeyStateChange(playerid, newkeys, oldkeys);

new carsonserver = 290;

new OwnableCarOffer[MAX_PLAYERS];
new OwnableCarID[MAX_PLAYERS];
new OwnableCarPrice[MAX_PLAYERS];

new vehName[][] = {
	"Landstalker",
	"Bravura",
	"Buffalo",
	"Linerunner",
	"Perrenial",
	"Sentinel",
	"Dumper",
	"Firetruck",
	"Trashmaster",
	"Stretch",
	"Manana",
	"Infernus",
	"Voodoo",
	"Pony",
	"Mule",
	"Cheetah",
	"Ambulance",
	"Leviathan",
	"Moonbeam",
	"Esperanto",
	"Taxi",
	"Washington",
	"Bobcat",
	"Whoopee",
	"BF Injection",
	"Hunter",
	"Premier",
	"Enforcer",
	"Securicar",
	"Banshee",
	"Predator",
	"Bus",
	"Rhino",
	"Barracks",
	"Hotknife",
	"Trailer",
	"Previon",
	"Coach",
	"Cabbie",
	"Stallion",
	"Rumpo",
	"RC Bandit",
	"Romero",
	"Packer",
	"Monster",
	"Admiral",
	"Squalo",
	"Seasparrow",
	"Pizzaboy",
	"Tram",
	"Trailer",
	"Turismo",
	"Speeder",
	"Reefer",
	"Tropic",
	"Flatbed",
	"Yankee",
	"Caddy",
	"Solair",
	"Berkley's RC Van",
	"Skimmer",
	"PCJ-600",
	"Faggio",
	"Freeway",
	"RC Baron",
	"RC Raider",
	"Glendale",
	"Oceanic",
	"Sanchez",
	"Sparrow",
	"Patriot",
	"ATV",
	"Coastguard",
	"Dinghy",
	"Hermes",
	"Sabre",
	"Rustler",
	"ZR-350",
	"Walton",
	"Regina",
	"Comet",
	"BMX",
	"Burrito",
	"Camper",
	"Marquis",
	"Baggage",
	"Dozer",
	"Maverick",
	"News Chopper",
	"Rancher",
	"FBI Rancher",
	"Virgo",
	"Greenwood",
	"Jetmax",
	"Hotring",
	"Sandking",
	"Blista Compact",
	"Police Maverick",
	"Boxvillde",
	"Benson",
	"Mesa",
	"RC Goblin",
	"Hotring Racer A",
	"Hotring Racer B",
	"Bloodring Banger",
	"Rancher",
	"Super GT",
	"Elegant",
	"Journey",
	"Bike",
	"Mountain Bike",
	"Beagle",
	"Cropduster",
	"Stunt",
	"Tanker",
	"Roadtrain",
	"Nebula",
	"Majestic",
	"Buccaneer",
	"Shamal",
	"Hydra",
	"FCR-900",
	"NRG-500",
	"HPV1000",
	"Cement Truck",
	"Tow Truck",
	"Fortune",
	"Cadrona",
	"FBI Truck",
	"Willard",
	"Forklift",
	"Tractor",
	"Combine",
	"Feltzer",
	"Remington",
	"Slamvan",
	"Blade",
	"Freight",
	"Streak",
	"Vortex",
	"Vincent",
	"Bullet",
	"Clover",
	"Sadler",
	"Firetruck",
	"Hustler",
	"Intruder",
	"Primo",
	"Cargobob",
	"Tampa",
	"Sunrise",
	"Merit",
	"Utility",
	"Nevada",
	"Jeep",
	"Windsor",
	"Monster",
	"Monster",
	"Uranus",
	"Jester",
	"Sultan",
	"Stratum",
	"Elegy",
	"Raindance",
	"RC Tiger",
	"Flash",
	"Tahoma",
	"Savanna",
	"Bandito",
	"Freight Flat",
	"Streak Carriage",
	"Kart",
	"Mower",
	"Dune",
	"Sweeper",
	"Broadway",
	"Tornado",
	"AT-400",
	"DFT-30",
	"Huntley",
	"Stafford",
	"BF-400",
	"News Van",
	"Tug",
	"Trailer",
	"Emperor",
	"Wayfarer",
	"Euros",
	"Hotdog",
	"Club",
	"Freight Box",
	"Trailer",
	"Andromada",
	"Dodo",
	"RC Cam",
	"Launch",
	"Police Car LSPD",
	"Police Car SFPD",
	"Police Car LVPD",
	"Police Ranger",
	"Picador",
	"S.W.A.T",
	"Alpha",
	"Phoenix",
	"Glendale",
	"Sadler",
	"Luggage",
	"Luggage",
	"Stairs",
	"Boxville",
	"Tiller",
	"Utility Trailer"
};
//===========================Section: Variables=================================

enum pInfo
{
	pPcarkey,
	pPcarkey2,
	pPcarkey3,
}
new PlayerInfo[256][pInfo];

enum cInfo
{
	cModel,
	Float:cLocationx,
	Float:cLocationy,
	Float:cLocationz,
	Float:cAngle,
	cColorOne,
	cColorTwo,
	cOwner[MAX_PLAYER_NAME],
	cDescription[12],
	cValue,
	cLicense[14],
	cRegistration,
	cOwned,
	cLock,
	mod1,
	mod2,
	mod3,
	mod4,
	mod5,
	mod6,
	mod7,
	mod8,
	mod9,
	mod10,
	mod11,
	mod12,
	mod13,
	mod14,
	mod15,
	mod16,
	mod17,
	paintjob,
};

new CarInfo[1000][cInfo];

new spoiler[20][0] = {
	{1000},
	{1001},
	{1002},
	{1003},
	{1014},
	{1015},
	{1016},
	{1023},
	{1058},
	{1060},
	{1049},
	{1050},
	{1138},
	{1139},
	{1146},
	{1147},
	{1158},
	{1162},
	{1163},
	{1164}
};

new nitro[3][0] = {
    {1008},
    {1009},
    {1010}
};

new fbumper[23][0] = {
    {1117},
    {1152},
    {1153},
    {1155},
    {1157},
    {1160},
    {1165},
    {1167},
    {1169},
    {1170},
    {1171},
    {1172},
    {1173},
    {1174},
    {1175},
    {1179},
    {1181},
    {1182},
    {1185},
    {1188},
    {1189},
    {1192},
    {1193}
};

new rbumper[22][0] = {
    {1140},
    {1141},
    {1148},
    {1149},
    {1150},
    {1151},
    {1154},
    {1156},
    {1159},
    {1161},
    {1166},
    {1168},
    {1176},
    {1177},
    {1178},
    {1180},
    {1183},
    {1184},
    {1186},
    {1187},
    {1190},
    {1191}
};

new exhaust[28][0] = {
    {1018},
    {1019},
    {1020},
    {1021},
    {1022},
    {1028},
    {1029},
    {1037},
    {1043},
    {1044},
    {1045},
    {1046},
    {1059},
    {1064},
    {1065},
    {1066},
    {1089},
    {1092},
    {1104},
    {1105},
    {1113},
    {1114},
    {1126},
    {1127},
    {1129},
    {1132},
    {1135},
    {1136}
};

new bventr[2][0] = {
    {1042},
    {1044}
};

new bventl[2][0] = {
    {1043},
    {1045}
};

new bscoop[4][0] = {
	{1004},
	{1005},
	{1011},
	{1012}
};

new rscoop[13][0] = {
    {1006},
    {1032},
    {1033},
    {1035},
    {1038},
    {1053},
    {1054},
    {1055},
    {1061},
    {1067},
    {1068},
    {1088},
    {1091}
};

new lskirt[21][0] = {
    {1007},
    {1026},
    {1031},
    {1036},
    {1039},
    {1042},
    {1047},
    {1048},
    {1056},
    {1057},
    {1069},
    {1070},
    {1090},
    {1093},
    {1106},
    {1108},
    {1118},
    {1119},
    {1133},
    {1122},
    {1134}
};

new rskirt[21][0] = {
    {1017},
    {1027},
    {1030},
    {1040},
    {1041},
    {1051},
    {1052},
    {1062},
    {1063},
    {1071},
    {1072},
    {1094},
    {1095},
    {1099},
    {1101},
    {1102},
    {1107},
    {1120},
    {1121},
    {1124},
    {1137}
};

new hydraulics[1][0] = {
    {1087}
};

new base[1][0] = {
    {1086}
};

new rbbars[2][0] = {
    {1109},
    {1110}
};

new fbbars[2][0] = {
    {1115},
    {1116}
};

new wheels[17][0] = {
    {1025},
    {1073},
    {1074},
    {1075},
    {1076},
    {1077},
    {1078},
    {1079},
    {1080},
    {1081},
    {1082},
    {1083},
    {1084},
    {1085},
    {1096},
    {1097},
    {1098}
};

new light[2][0] = {
	{1013},
	{1024}
};

InitComponents(componentid)
{
	new i;
	for(i=0; i<20; i++)
	{
	    if(spoiler[i][0]==componentid) { return 1; }
	}
	for(i=0; i<3; i++)
	{
	    if(nitro[i][0]==componentid) { return 2; }
	}
	for(i=0; i<23; i++)
	{
	    if(fbumper[i][0]==componentid) { return 3; }
	}
	for(i=0; i<22; i++)
	{
	    if(rbumper[i][0]==componentid) { return 4; }
	}
	for(i=0; i<28; i++)
	{
	    if(exhaust[i][0]==componentid) { return 5; }
	}
	for(i=0; i<2; i++)
	{
	    if(bventr[i][0]==componentid) { return 6; }
	}
	for(i=0; i<2; i++)
	{
	    if(bventl[i][0]==componentid) { return 7; }
	}
	for(i=0; i<4; i++)
	{
	    if(bscoop[i][0]==componentid) { return 8; }
	}
	for(i=0; i<13; i++)
	{
	    if(rscoop[i][0]==componentid) { return 9; }
	}
	for(i=0; i<21; i++)
	{
	    if(lskirt[i][0]==componentid) { return 10; }
	}
	for(i=0; i<21; i++)
	{
	    if(rskirt[i][0]==componentid) { return 11; }
	}
	if(hydraulics[0][0]==componentid) { return 12; }
	if(base[0][0]==componentid) { return 13; }
	for(i=0; i<2; i++)
	{
	    if(rbbars[i][0]==componentid) { return 14; }
	}
	for(i=0; i<2; i++)
	{
	    if(fbbars[i][0]==componentid) { return 15; }
	}
	for(i=0; i<17; i++)
	{
	    if(wheels[i][0]==componentid) { return 16; }
	}
	for(i=0; i<2; i++)
	{
	    if(light[i][0]==componentid) { return 17; }
	}
	return 0;
}

//===========================Section: strtok & split============================
strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

public split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
	    if(strsrc[i]==delimiter || i==strlen(strsrc)){
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}
//===========================Section: Callbacks & Functions=====================
public OnFilterScriptInit()
{
	printf("Filterscript carownership.amx Initiated\n");
	LoadCar();

	for(new h = carsonserver; h < sizeof(CarInfo); h++)
	{
		AddStaticVehicleEx(CarInfo[h][cModel],CarInfo[h][cLocationx],CarInfo[h][cLocationy],CarInfo[h][cLocationz]+1.0,CarInfo[h][cAngle],CarInfo[h][cColorOne],CarInfo[h][cColorTwo],60000);
		LoadComponents(h);
	}
	return 1;
}

public OnFilterScriptExit() { return 1; }

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    new carid = GetPlayerVehicleID(playerid);
    if ((newkeys & KEY_SECONDARY_ATTACK))
	{
	    if(IsAnOwnableCar(carid) && CarInfo[carid][cOwned] == 0)
	   	{
	        TogglePlayerControllable(playerid, 1);
	        RemovePlayerFromVehicle(playerid);
	    }
	}
	return 1;
}

public SavePlayerData(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new string3[32];
		new playername3[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playername3, sizeof(playername3));
		format(string3, sizeof(string3), "carkeys/%s.ini", playername3);
		new File: hFile = fopen(string3, io_write);
		if (hFile)
		{
			new var[32];
			format(var, 32, "CarKey=%d\n",PlayerInfo[playerid][pPcarkey]);fwrite(hFile, var);
			format(var, 32, "CarKey2=%d\n",PlayerInfo[playerid][pPcarkey2]);fwrite(hFile, var);
			format(var, 32, "CarKey3=%d\n",PlayerInfo[playerid][pPcarkey3]);fwrite(hFile, var);
			fclose(hFile);
		}
	}
	return 1;
}

public ProxDetectorS(Float:radi, playerid, targetid)
{
    if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		GetPlayerPos(targetid, posx, posy, posz);
		tempposx = (oldposx -posx);
		tempposy = (oldposy -posy);
		tempposz = (oldposz -posz);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

public CarKeys(playerid)
{
    new string2[64];
	new playername2[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername2, sizeof(playername2));
	format(string2, sizeof(string2), "carkeys/%s.ini", playername2);
	new File: UserFile = fopen(string2, io_read);
	if ( UserFile )
	{
		new key[ 256 ] , val[ 256 ];
		new Data[ 256 ];
		while ( fread( UserFile , Data , sizeof( Data ) ) )
		{
			key = ini_GetKey( Data );
			if( strcmp( key , "CarKey" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pPcarkey] = strval( val ); }
			if( strcmp( key , "CarKey2" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pPcarkey2] = strval( val ); }
			if( strcmp( key , "CarKey3" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pPcarkey3] = strval( val ); }
        }
        fclose(UserFile);
        SendClientMessage(playerid, COLOR_WHITE,"Car Keys Loaded!!!");
	}
	return 1;
}

public CarMods(vehicleid)
{
    if(CarInfo[vehicleid][paintjob] > -1 || CarInfo[vehicleid][mod1] > 0 || CarInfo[vehicleid][mod2] > 0 || CarInfo[vehicleid][mod3] > 0 || CarInfo[vehicleid][mod4] > 0 || CarInfo[vehicleid][mod5] > 0 || CarInfo[vehicleid][mod6] > 0 || CarInfo[vehicleid][mod7] > 0 || CarInfo[vehicleid][mod8] > 0)
	{
	    return 1;
	}
	else if (CarInfo[vehicleid][mod9] > 0 || CarInfo[vehicleid][mod10] > 0 || CarInfo[vehicleid][mod11] > 0 || CarInfo[vehicleid][mod12] > 0|| CarInfo[vehicleid][mod13] > 0|| CarInfo[vehicleid][mod14] > 0|| CarInfo[vehicleid][mod15] > 0|| CarInfo[vehicleid][mod16] > 0|| CarInfo[vehicleid][mod17] > 0)
	{
	   return 1;
	}
	return 0;
}

public IsAtDealership(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerToPoint(25.0,playerid,2128.0864,-1135.3912,25.5855) || PlayerToPoint(50,playerid,537.3366,-1293.2140,17.2422) || PlayerToPoint(35,playerid,2521.5544,-1524.4504,23.8365) || PlayerToPoint(50,playerid,2155.0146,-1177.3333,23.8211) || PlayerToPoint(50,playerid,299.1723,-1518.6627,24.6007) || PlayerToPoint(99,playerid,1938.414428,-2643.810058,13.723393))
		{
			return 1;
		}
	}
	return 0;
}

public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

public OnVehicleMod(playerid,vehicleid,componentid)
{
	new mods = InitComponents(componentid);
	if(IsPlayerInVehicle(playerid, vehicleid))
	{
		switch(mods)
		{
			case 1: { CarInfo[vehicleid][mod1] = componentid; }
			case 2: { CarInfo[vehicleid][mod2] = componentid; }
			case 3: { CarInfo[vehicleid][mod3] = componentid; }
			case 4: { CarInfo[vehicleid][mod4] = componentid; }
			case 5: { CarInfo[vehicleid][mod5] = componentid; }
			case 6: { CarInfo[vehicleid][mod6] = componentid; }
			case 7: { CarInfo[vehicleid][mod7] = componentid; }
			case 8: { CarInfo[vehicleid][mod8] = componentid; }
			case 9: { CarInfo[vehicleid][mod9] = componentid; }
			case 10: { CarInfo[vehicleid][mod10] = componentid; }
			case 11: { CarInfo[vehicleid][mod11] = componentid; }
			case 12: { CarInfo[vehicleid][mod12] = componentid; }
			case 13: { CarInfo[vehicleid][mod13] = componentid; }
			case 14: { CarInfo[vehicleid][mod14] = componentid; }
			case 15: { CarInfo[vehicleid][mod15] = componentid; }
			case 16: { CarInfo[vehicleid][mod16] = componentid; }
			case 17: { CarInfo[vehicleid][mod17] = componentid; }
		}
	}
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	if(IsPlayerInVehicle(playerid, vehicleid))
	{
	    if(GetVehicleModel(vehicleid) == 483)
	    {
			switch(paintjobid)
			{
	    		case 0: CarInfo[vehicleid][paintjob] = 0;
	    	}
  		}
  		if(GetVehicleModel(vehicleid) == 534)
	    {
	   		switch(paintjobid)
			{
	    		case 0: CarInfo[vehicleid][paintjob] = 0;
	    		case 1: CarInfo[vehicleid][paintjob] = 1;
	    		case 2: CarInfo[vehicleid][paintjob] = 2;
	    	}
  		}
  		if(GetVehicleModel(vehicleid) == 535)
	    {
	   		switch(paintjobid)
			{
	    		case 0: CarInfo[vehicleid][paintjob] = 0;
	    		case 1: CarInfo[vehicleid][paintjob] = 1;
	    		case 2: CarInfo[vehicleid][paintjob] = 2;
	    	}
  		}
  		if(GetVehicleModel(vehicleid) == 536)
	    {
	   		switch(paintjobid)
			{
	    		case 0: CarInfo[vehicleid][paintjob] = 0;
	    		case 1: CarInfo[vehicleid][paintjob] = 1;
	    		case 2: CarInfo[vehicleid][paintjob] = 2;
	    	}
  		}
  		if(GetVehicleModel(vehicleid) == 558)
	    {
	   		switch(paintjobid)
			{
	    		case 0: CarInfo[vehicleid][paintjob] = 0;
	    		case 1: CarInfo[vehicleid][paintjob] = 1;
	    		case 2: CarInfo[vehicleid][paintjob] = 2;
	    	}
  		}
  		if(GetVehicleModel(vehicleid) == 559)
	    {
	   		switch(paintjobid)
			{
	    		case 0: CarInfo[vehicleid][paintjob] = 0;
	    		case 1: CarInfo[vehicleid][paintjob] = 1;
	    		case 2: CarInfo[vehicleid][paintjob] = 2;
	    	}
  		}
  		if(GetVehicleModel(vehicleid) == 560)
	    {
	   		switch(paintjobid)
			{
	    		case 0: CarInfo[vehicleid][paintjob] = 0;
	    		case 1: CarInfo[vehicleid][paintjob] = 1;
	    		case 2: CarInfo[vehicleid][paintjob] = 2;
	    	}
  		}
  		if(GetVehicleModel(vehicleid) == 561)
	    {
	   		switch(paintjobid)
			{
	    		case 0: CarInfo[vehicleid][paintjob] = 0;
	    		case 1: CarInfo[vehicleid][paintjob] = 1;
	    		case 2: CarInfo[vehicleid][paintjob] = 2;
	    	}
  		}
  		if(GetVehicleModel(vehicleid) == 562)
	    {
	   		switch(paintjobid)
			{
	    		case 0: CarInfo[vehicleid][paintjob] = 0;
	    		case 1: CarInfo[vehicleid][paintjob] = 1;
	    		case 2: CarInfo[vehicleid][paintjob] = 2;
	    	}
  		}
  		if(GetVehicleModel(vehicleid) == 565)
	    {
	   		switch(paintjobid)
			{
	    		case 0: CarInfo[vehicleid][paintjob] = 0;
	    		case 1: CarInfo[vehicleid][paintjob] = 1;
	    		case 2: CarInfo[vehicleid][paintjob] = 2;
	    	}
  		}
  		if(GetVehicleModel(vehicleid) == 567)
	    {
	   		switch(paintjobid)
			{
	    		case 0: CarInfo[vehicleid][paintjob] = 0;
	    		case 1: CarInfo[vehicleid][paintjob] = 1;
	    		case 2: CarInfo[vehicleid][paintjob] = 2;
	    	}
  		}
  		if(GetVehicleModel(vehicleid) == 575)
	    {
	   		switch(paintjobid)
			{
	    		case 0: CarInfo[vehicleid][paintjob] = 0;
	    		case 1: CarInfo[vehicleid][paintjob] = 1;
	    	}
  		}
  		if(GetVehicleModel(vehicleid) == 576)
	    {
	   		switch(paintjobid)
			{
	    		case 0: CarInfo[vehicleid][paintjob] = 0;
	    		case 1: CarInfo[vehicleid][paintjob] = 1;
	    		case 2: CarInfo[vehicleid][paintjob] = 2;
	    	}
  		}
	}
	return 1;
}

public OnPropUpdate()
{
	new idx;
	new File: file2;
	idx = carsonserver;
 	while (idx < sizeof(CarInfo))
	{
		new coordsstring[256];
		format(coordsstring, sizeof(coordsstring), "%d,%f,%f,%f,%f,%d,%d,%s,%s,%d,%s,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n",
		CarInfo[idx][cModel],
		CarInfo[idx][cLocationx],
		CarInfo[idx][cLocationy],
		CarInfo[idx][cLocationz],
		CarInfo[idx][cAngle],
		CarInfo[idx][cColorOne],
		CarInfo[idx][cColorTwo],
		CarInfo[idx][cOwner],
		CarInfo[idx][cDescription],
		CarInfo[idx][cValue],
		CarInfo[idx][cLicense],
		CarInfo[idx][cOwned],
		CarInfo[idx][cLock],
		CarInfo[idx][mod1],
		CarInfo[idx][mod2],
		CarInfo[idx][mod3],
		CarInfo[idx][mod4],
		CarInfo[idx][mod5],
		CarInfo[idx][mod6],
		CarInfo[idx][mod7],
		CarInfo[idx][mod8],
		CarInfo[idx][mod9],
		CarInfo[idx][mod10],
		CarInfo[idx][mod11],
		CarInfo[idx][mod12],
		CarInfo[idx][mod13],
		CarInfo[idx][mod14],
		CarInfo[idx][mod15],
		CarInfo[idx][mod16],
		CarInfo[idx][mod17],
		CarInfo[idx][paintjob]);
		if(idx == carsonserver)
		{
			file2 = fopen("masini.cfg", io_write);
		}
		else
		{
			file2 = fopen("masini.cfg", io_append);
		}
		fwrite(file2, coordsstring);
		idx++;
		fclose(file2);
	}
	return 1;
}

public IsAnOwnableCar(vehicleid)
{
	if(vehicleid >= carsonserver && vehicleid <= 1000) { return 1; }
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    new vehid;
	vehid = GetPlayerVehicleID(playerid);
    if(response)
	{
		if(dialogid == DIALOGID+2)
		{
			if(response)
			{
				if(listitem==0)
				{
					if(CarInfo[vehid][mod1] > 0)
					{
                        new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
                        GetVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    GetVehicleHealth(vehid, CarHP); OldCarHP = CarHP;
	                    GetVehiclePos(vehid,XX,YY,ZZ); CarInfo[vehid][mod1] = 0;
	                    SetVehicleToRespawn(vehid); SetVehiclePos(vehid,XX,YY,ZZ);
	                    PutPlayerInVehicle(playerid,vehid,0); SetVehicleHealth(vehid, OldCarHP);
	                    UpdateVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    SendClientMessage(playerid, COLOR_BLUE,"*  Eleronul a fost scos cu succes!!!");
                        LoadComponents(vehid); OnPropUpdate(); SavePlayerData(playerid);
					}
					else
					{
						SendClientMessage(playerid, COLOR_WHITE,"*  Masina ta nu are Eleron Instalat!!!");
					}
				}
				if(listitem==1)
				{
					if(CarInfo[vehid][mod3] > 0)
					{
                        new Float:XX,Float:YY,Float:ZZ,Float:CarHP,Float:OldCarHP; new panels,doors,lights,tires;
                        GetVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    GetVehicleHealth(vehid, CarHP); OldCarHP = CarHP;
	                    GetVehiclePos(vehid,XX,YY,ZZ); CarInfo[vehid][mod3] = 0;
	                    SetVehicleToRespawn(vehid); SetVehiclePos(vehid,XX,YY,ZZ);
	                    PutPlayerInVehicle(playerid,vehid,0); SetVehicleHealth(vehid, OldCarHP);
	                    UpdateVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    SendClientMessage(playerid, COLOR_BLUE,"*  Spoilerul din fata a fost scos cu succes!!!");
                        LoadComponents(vehid); OnPropUpdate(); SavePlayerData(playerid);
					}
					else
					{
						SendClientMessage(playerid, COLOR_WHITE,"*  Masina ta nu are Spoilerul din fata Instalat!!!");
					}
				}
				if(listitem==2)
				{
					if(CarInfo[vehid][mod4] > 0)
					{
                        new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
                        GetVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    GetVehicleHealth(vehid, CarHP); OldCarHP = CarHP;
	                    GetVehiclePos(vehid,XX,YY,ZZ); CarInfo[vehid][mod4] = 0;
	                    SetVehicleToRespawn(vehid); SetVehiclePos(vehid,XX,YY,ZZ);
	                    PutPlayerInVehicle(playerid,vehid,0); SetVehicleHealth(vehid, OldCarHP);
	                    UpdateVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    SendClientMessage(playerid, COLOR_BLUE,"*  Spoilerul din spate a fost scos cu succes!!!");
                        LoadComponents(vehid); OnPropUpdate(); SavePlayerData(playerid);
					}
					else
					{
						SendClientMessage(playerid, COLOR_WHITE,"*  Masina ta nu are Spoilerul din spate Instalat!!!");
					}
				}
				if(listitem==3)
				{
					if(CarInfo[vehid][mod10] > 0 && CarInfo[vehid][mod11] > 0)
					{
                        new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
                        GetVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    GetVehicleHealth(vehid, CarHP); OldCarHP = CarHP;
	                    GetVehiclePos(vehid,XX,YY,ZZ); CarInfo[vehid][mod11] = 0; CarInfo[vehid][mod10] = 0;
	                    SetVehicleToRespawn(vehid); SetVehiclePos(vehid,XX,YY,ZZ);
	                    PutPlayerInVehicle(playerid,vehid,0); SetVehicleHealth(vehid, OldCarHP);
	                    UpdateVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    SendClientMessage(playerid, COLOR_BLUE,"*  Lateralele au fost scoase cu succes!!!");
                        LoadComponents(vehid); OnPropUpdate(); SavePlayerData(playerid);
					}
					else
					{
						SendClientMessage(playerid, COLOR_WHITE,"*  Masina ta nu are Laterale Instalate!!!");
					}
				}
				if(listitem==4)
				{
					if(CarInfo[vehid][mod9] > 0)
					{
                        new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
                        GetVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    GetVehicleHealth(vehid, CarHP); OldCarHP = CarHP;
	                    GetVehiclePos(vehid,XX,YY,ZZ); CarInfo[vehid][mod9] = 0;
	                    SetVehicleToRespawn(vehid); SetVehiclePos(vehid,XX,YY,ZZ);
	                    PutPlayerInVehicle(playerid,vehid,0); SetVehicleHealth(vehid, OldCarHP);
	                    UpdateVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    SendClientMessage(playerid, COLOR_BLUE,"*  Roof Scoops au fost scoase cu succes!!!");
                        LoadComponents(vehid); OnPropUpdate(); SavePlayerData(playerid);
					}
					else
					{
						SendClientMessage(playerid, COLOR_WHITE,"*  Masina ta nu are Roof Scoops Instalat!!!");
					}
				}
				if(listitem==5)
				{
					if(CarInfo[vehid][mod5] > 0)
					{
                        new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
                        GetVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    GetVehicleHealth(vehid, CarHP); OldCarHP = CarHP;
	                    GetVehiclePos(vehid,XX,YY,ZZ); CarInfo[vehid][mod5] = 0;
	                    SetVehicleToRespawn(vehid); SetVehiclePos(vehid,XX,YY,ZZ);
	                    PutPlayerInVehicle(playerid,vehid,0); SetVehicleHealth(vehid, OldCarHP);
	                    UpdateVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    SendClientMessage(playerid, COLOR_BLUE,"*  Tobele de Esapament au fost scoase cu succes!!!");
                        LoadComponents(vehid); OnPropUpdate(); SavePlayerData(playerid);
					}
					else
					{
						SendClientMessage(playerid, COLOR_WHITE,"*  Masina ta nu are Tobe de Esapament Instalate!!!");
					}
				}
				if(listitem==6)
				{
					if(CarInfo[vehid][mod2] > 0)
					{
                        new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
                        GetVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    GetVehicleHealth(vehid, CarHP); OldCarHP = CarHP;
	                    GetVehiclePos(vehid,XX,YY,ZZ); CarInfo[vehid][mod2] = 0;
	                    SetVehicleToRespawn(vehid); SetVehiclePos(vehid,XX,YY,ZZ);
	                    PutPlayerInVehicle(playerid,vehid,0); SetVehicleHealth(vehid, OldCarHP);
	                    UpdateVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    SendClientMessage(playerid, COLOR_BLUE,"*  Nitro a fost scos cu succes!!!");
                        LoadComponents(vehid); OnPropUpdate(); SavePlayerData(playerid);
					}
					else
					{
						SendClientMessage(playerid, COLOR_WHITE,"*  Masina ta nu are Nitro Instalat!!!");
					}
				}
				if(listitem==7)
				{
					if(CarInfo[vehid][mod12] > 0)
					{
                        new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
                        GetVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    GetVehicleHealth(vehid, CarHP); OldCarHP = CarHP;
	                    GetVehiclePos(vehid,XX,YY,ZZ); CarInfo[vehid][mod12] = 0;
	                    SetVehicleToRespawn(vehid); SetVehiclePos(vehid,XX,YY,ZZ);
	                    PutPlayerInVehicle(playerid,vehid,0); SetVehicleHealth(vehid, OldCarHP);
	                    UpdateVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    SendClientMessage(playerid, COLOR_BLUE,"*  Hidraulica a fost scoasa cu succes!!!");
                        LoadComponents(vehid); OnPropUpdate(); SavePlayerData(playerid);
					}
					else
					{
						SendClientMessage(playerid, COLOR_WHITE,"*  Masina ta nu are Hidraulica Instalata!!!");
					}
				}
				if(listitem==8)
				{
					if(CarInfo[vehid][mod16] > 0)
					{
                        new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
                        GetVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    GetVehicleHealth(vehid, CarHP); OldCarHP = CarHP;
	                    GetVehiclePos(vehid,XX,YY,ZZ); CarInfo[vehid][mod16] = 0;
	                    SetVehicleToRespawn(vehid); SetVehiclePos(vehid,XX,YY,ZZ);
	                    PutPlayerInVehicle(playerid,vehid,0); SetVehicleHealth(vehid, OldCarHP);
	                    UpdateVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    SendClientMessage(playerid, COLOR_BLUE,"*  Rotile au fost scoase cu succes!!!");
                        LoadComponents(vehid); OnPropUpdate(); SavePlayerData(playerid);
					}
					else
					{
						SendClientMessage(playerid, COLOR_WHITE,"*  Masina ta nu are Roti Instalate!!!");
					}
				}
				if(listitem==9)
				{
					if(CarInfo[vehid][paintjob] > -1)
					{
                        new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
                        GetVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    GetVehicleHealth(vehid, CarHP); OldCarHP = CarHP;
	                    GetVehiclePos(vehid,XX,YY,ZZ); CarInfo[vehid][paintjob] = -1;
	                    SetVehicleToRespawn(vehid); SetVehiclePos(vehid,XX,YY,ZZ);
	                    PutPlayerInVehicle(playerid,vehid,0); SetVehicleHealth(vehid, OldCarHP);
	                    UpdateVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    SendClientMessage(playerid, COLOR_BLUE,"*  Tatuajul a fost indepartat cu succes!!!");
                        LoadComponents(vehid); OnPropUpdate(); SavePlayerData(playerid);
					}
					else
					{
						SendClientMessage(playerid, COLOR_WHITE,"*  Masina ta nu are Tatuaj!!!");
					}
				}
				if(listitem==10)
				{
					if(CarMods(vehid))
					{
                        new Float:XX,Float:YY,Float:ZZ; new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
                        GetVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    GetVehicleHealth(vehid, CarHP); OldCarHP = CarHP;
	                    GetVehiclePos(vehid,XX,YY,ZZ); CarInfo[vehid][paintjob] = -1; CarInfo[vehid][mod1] = 0; CarInfo[vehid][mod2] = 0;
	                    CarInfo[vehid][mod3] = 0; CarInfo[vehid][mod4] = 0; CarInfo[vehid][mod5] = 0; CarInfo[vehid][mod6] = 0; CarInfo[vehid][mod7] = 0;
	                    CarInfo[vehid][mod8] = 0; CarInfo[vehid][mod9] = 0; CarInfo[vehid][mod10] = 0; CarInfo[vehid][mod11] = 0; CarInfo[vehid][mod12] = 0;
	                    CarInfo[vehid][mod13] = 0; CarInfo[vehid][mod14] = 0; CarInfo[vehid][mod15] = 0; CarInfo[vehid][mod16] = 0; CarInfo[vehid][mod17] = 0;
	                    SetVehicleToRespawn(vehid); SetVehiclePos(vehid,XX,YY,ZZ);
	                    PutPlayerInVehicle(playerid,vehid,0); SetVehicleHealth(vehid, OldCarHP);
	                    UpdateVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                    SendClientMessage(playerid, COLOR_BLUE,"*  Tuningul a fost indepartat cu succes!!!");
                        LoadComponents(vehid); OnPropUpdate(); SavePlayerData(playerid);
					}
					else
					{
						SendClientMessage(playerid, COLOR_WHITE,"*  Masina ta nu este Tunata!!!");
					}
				}
	        }
	    }
    }
    else
    {
	    SendClientMessage(playerid, COLOR_WHITE,"* Dialog has been hidden");
    }
    return 1;
 }

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(IsAnOwnableCar(vehicleid) && CarInfo[vehicleid][cLock] == 1 && CarInfo[vehicleid][cOwned] == 1)
	{
		if(IsPlayerAdmin(playerid)) { }
		else
		{
			new Float:cx, Float:cy, Float:cz;
  			GetPlayerPos(playerid, cx, cy, cz);
    		SetPlayerPos(playerid, cx, cy, cz);
		}
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
    LoadComponents(vehicleid);
    return 1;
}

public LoadComponents(vehicleid)
{
	if(CarInfo[vehicleid][cOwned] == 1)
	{
        if(CarInfo[vehicleid][mod1] >= 1000 && CarInfo[vehicleid][mod1] <= 1193)
	    {
            if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(CarInfo[vehicleid][mod1])) != CarInfo[vehicleid][mod1]) { AddVehicleComponent(vehicleid,CarInfo[vehicleid][mod1]); }
        }
	    if(CarInfo[vehicleid][mod2] >= 1000 && CarInfo[vehicleid][mod2] <= 1193)
	    {
	        if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(CarInfo[vehicleid][mod2])) != CarInfo[vehicleid][mod2]) { AddVehicleComponent(vehicleid,CarInfo[vehicleid][mod2]); }
	    }
	    if(CarInfo[vehicleid][mod3] >= 1000 && CarInfo[vehicleid][mod3] <= 1193)
	    {
	        if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(CarInfo[vehicleid][mod3])) != CarInfo[vehicleid][mod3]) { AddVehicleComponent(vehicleid,CarInfo[vehicleid][mod3]); }
	    }
	    if(CarInfo[vehicleid][mod4] >= 1000 && CarInfo[vehicleid][mod4] <= 1193)
	    {
	        if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(CarInfo[vehicleid][mod4])) != CarInfo[vehicleid][mod4]) { AddVehicleComponent(vehicleid,CarInfo[vehicleid][mod4]); }
	    }
	    if(CarInfo[vehicleid][mod5] >= 1000 && CarInfo[vehicleid][mod5] <= 1193)
	    {
	        if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(CarInfo[vehicleid][mod5])) != CarInfo[vehicleid][mod5]) { AddVehicleComponent(vehicleid,CarInfo[vehicleid][mod5]); }
	    }
	    if(CarInfo[vehicleid][mod6] >= 1000 && CarInfo[vehicleid][mod6] <= 1193)
	    {
	        if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(CarInfo[vehicleid][mod6])) != CarInfo[vehicleid][mod6]) { AddVehicleComponent(vehicleid,CarInfo[vehicleid][mod6]); }
	    }
	    if(CarInfo[vehicleid][mod7] >= 1000 && CarInfo[vehicleid][mod7] <= 1193)
	    {
	        if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(CarInfo[vehicleid][mod7])) != CarInfo[vehicleid][mod7]) { AddVehicleComponent(vehicleid,CarInfo[vehicleid][mod7]); }
	    }
	    if(CarInfo[vehicleid][mod8] >= 1000 && CarInfo[vehicleid][mod8] <= 1193)
    	{
    	    if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(CarInfo[vehicleid][mod8])) != CarInfo[vehicleid][mod8]) { AddVehicleComponent(vehicleid,CarInfo[vehicleid][mod8]); }
    	}
    	if(CarInfo[vehicleid][mod9] >= 1000 && CarInfo[vehicleid][mod9] <= 1193)
	    {
    	    if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(CarInfo[vehicleid][mod9])) != CarInfo[vehicleid][mod9]) { AddVehicleComponent(vehicleid,CarInfo[vehicleid][mod9]); }
    	}
    	if(CarInfo[vehicleid][mod10] >= 1000 && CarInfo[vehicleid][mod10] <= 1193)
    	{
    	    if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(CarInfo[vehicleid][mod10])) != CarInfo[vehicleid][mod10]) { AddVehicleComponent(vehicleid,CarInfo[vehicleid][mod10]); }
    	}
    	if(CarInfo[vehicleid][mod11] >= 1000 && CarInfo[vehicleid][mod11] <= 1193)
    	{
    	    if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(CarInfo[vehicleid][mod11])) != CarInfo[vehicleid][mod11]) { AddVehicleComponent(vehicleid,CarInfo[vehicleid][mod11]); }
    	}
    	if(CarInfo[vehicleid][mod12] >= 1000 && CarInfo[vehicleid][mod12] <= 1193)
    	{
    	    if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(CarInfo[vehicleid][mod12])) != CarInfo[vehicleid][mod12]) { AddVehicleComponent(vehicleid,CarInfo[vehicleid][mod12]); }
    	}
    	if(CarInfo[vehicleid][mod13] >= 1000 && CarInfo[vehicleid][mod13] <= 1193)
    	{
    	    if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(CarInfo[vehicleid][mod13])) != CarInfo[vehicleid][mod13]) { AddVehicleComponent(vehicleid,CarInfo[vehicleid][mod13]); }
    	}
    	if(CarInfo[vehicleid][mod14] >= 1000 && CarInfo[vehicleid][mod14] <= 1193)
    	{
	        if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(CarInfo[vehicleid][mod14])) != CarInfo[vehicleid][mod14]) { AddVehicleComponent(vehicleid,CarInfo[vehicleid][mod14]); }
    	}
    	if(CarInfo[vehicleid][mod15] >= 1000 && CarInfo[vehicleid][mod15] <= 1193)
    	{
    	    if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(CarInfo[vehicleid][mod15])) != CarInfo[vehicleid][mod15]) { AddVehicleComponent(vehicleid,CarInfo[vehicleid][mod15]); }
    	}
    	if(CarInfo[vehicleid][mod16] >= 1000 && CarInfo[vehicleid][mod16] <= 1193)
    	{
    	    if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(CarInfo[vehicleid][mod16])) != CarInfo[vehicleid][mod16]) { AddVehicleComponent(vehicleid,CarInfo[vehicleid][mod16]); }
    	}
    	if(CarInfo[vehicleid][mod17] >= 1000 && CarInfo[vehicleid][mod17] <= 1193)
    	{
    	    if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(CarInfo[vehicleid][mod17])) != CarInfo[vehicleid][mod17]) { AddVehicleComponent(vehicleid,CarInfo[vehicleid][mod17]); }
	    }
        if(CarInfo[vehicleid][paintjob] > -1) { ChangeVehiclePaintjob(vehicleid,CarInfo[vehicleid][paintjob]); ChangeVehicleColor(vehicleid, 1, 1); }
        else { ChangeVehicleColor(vehicleid, CarInfo[vehicleid][cColorOne], CarInfo[vehicleid][cColorTwo]); }
        if(CarInfo[vehicleid][cLicense] > 0) { SetVehicleNumberPlate(vehicleid,CarInfo[vehicleid][cLicense]); }
    }
    else
    {
        if(CarInfo[vehicleid][cLicense] > 0) { SetVehicleNumberPlate(vehicleid,CarInfo[vehicleid][cLicense]); }
    }
    return 1;
}

public OnPlayerSpawn(playerid)
{
	CarKeys(playerid);
	return 1;
}

public OnPlayerConnect(playerid)
{
    PlayerInfo[playerid][pPcarkey] = -1;
	PlayerInfo[playerid][pPcarkey2] = -1;
	PlayerInfo[playerid][pPcarkey3] = -1;
	for(new h = carsonserver; h < sizeof(CarInfo); h++)
	{
		SetVehicleParamsForPlayer(h,playerid,0,CarInfo[h][cLock]);
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new idx;
	new string[256];
	new cmd[256];
	new tmp[256];
	new sendername[MAX_PLAYER_NAME];
	new playername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new giveplayerid;
	new idcar = GetPlayerVehicleID(playerid);
	cmd = strtok(cmdtext, idx);
	new vehid;
	vehid = GetPlayerVehicleID(playerid);

	if(strcmp(cmd,"/cancel",true)==0)
    {
        if(IsPlayerConnected(playerid))
	    {
			new x_job[256];
			x_job = strtok(cmdtext, idx);
			if(!strlen(x_job)) { return 1; }
			if(strcmp(x_job,"ownablecar",true) == 0) { OwnableCarOffer[playerid] = 999; OwnableCarID[playerid] = 0; OwnableCarPrice[playerid] = 0; }
			else { return 1; }
			format(string, sizeof(string), "* You have canceled: %s.", x_job);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
		return 1;
	}

	if(strcmp(cmd,"/accept",true)==0)
    {
        if(IsPlayerConnected(playerid))
	    {
			new x_job[256];
			x_job = strtok(cmdtext, idx);
			if(!strlen(x_job)) { return 1; }
			if(strcmp(x_job,"ownablecar",true) == 0)
			{
			    if(OwnableCarOffer[playerid] < 999)
			    {
			        if(OwnableCarID[playerid] == 0) { return 1; }
			        if(OwnableCarPrice[playerid] == 0 || OwnableCarPrice[playerid] > 1500001) { return 1; }

			        if(OwnableCarID[playerid] == PlayerInfo[OwnableCarOffer[playerid]][pPcarkey]) { }
			        else if(OwnableCarID[playerid] == PlayerInfo[OwnableCarOffer[playerid]][pPcarkey2]) { }
			        else if(OwnableCarID[playerid] == PlayerInfo[OwnableCarOffer[playerid]][pPcarkey3]) { }
			        else { SendClientMessage(playerid, COLOR_GREY, "  Offer is no longer available"); return 1; }

			        if(GetPlayerMoney(playerid) >= OwnableCarPrice[playerid])
			        {
						if(IsPlayerConnected(OwnableCarOffer[playerid]))
						{
						    GetPlayerName(OwnableCarOffer[playerid], giveplayer, sizeof(giveplayer));
						    GetPlayerName(playerid, sendername, sizeof(sendername));
						    if(PlayerInfo[playerid][pPcarkey] == -1)
							{
								if(GetPlayerVehicleID(OwnableCarOffer[playerid]) == PlayerInfo[OwnableCarOffer[playerid]][pPcarkey])
								{
									PlayerInfo[playerid][pPcarkey] = PlayerInfo[OwnableCarOffer[playerid]][pPcarkey];
						    		PlayerInfo[OwnableCarOffer[playerid]][pPcarkey] = -1;
								}
								else if(GetPlayerVehicleID(OwnableCarOffer[playerid]) == PlayerInfo[OwnableCarOffer[playerid]][pPcarkey2])
								{
									PlayerInfo[playerid][pPcarkey] = PlayerInfo[OwnableCarOffer[playerid]][pPcarkey2];
						    		PlayerInfo[OwnableCarOffer[playerid]][pPcarkey2] = -1;
								}
								else if(GetPlayerVehicleID(OwnableCarOffer[playerid]) == PlayerInfo[OwnableCarOffer[playerid]][pPcarkey3])
								{
									PlayerInfo[playerid][pPcarkey] = PlayerInfo[OwnableCarOffer[playerid]][pPcarkey3];
						    		PlayerInfo[OwnableCarOffer[playerid]][pPcarkey3] = -1;
								}
								else
								{
								    SendClientMessage(playerid, COLOR_GREY, "  Vehicle seller needs to be at his car !");
									return 1;
								}
								format(string, sizeof(string), "* You bought a car for $%d from %s.",OwnableCarPrice[playerid],giveplayer);
								SendClientMessage(playerid, COLOR_WHITE, string);
								format(string, sizeof(string), "* %s has bought your car for $%d.",sendername,OwnableCarPrice[playerid]);
								SendClientMessage(OwnableCarOffer[playerid], COLOR_WHITE, string);
						    	RemovePlayerFromVehicle(OwnableCarOffer[playerid]);
						    	GivePlayerMoney(playerid, - OwnableCarPrice[playerid]);
						    	GivePlayerMoney(OwnableCarOffer[playerid], OwnableCarPrice[playerid]);
						    	strmid(CarInfo[OwnableCarID[playerid]][cOwner], sendername, 0, strlen(sendername), 999);
							}
						    else if(PlayerInfo[playerid][pPcarkey2] == -1)
							{
							    if(GetPlayerVehicleID(OwnableCarOffer[playerid]) == PlayerInfo[OwnableCarOffer[playerid]][pPcarkey])
								{
									PlayerInfo[playerid][pPcarkey2] = PlayerInfo[OwnableCarOffer[playerid]][pPcarkey];
						    		PlayerInfo[OwnableCarOffer[playerid]][pPcarkey] = -1;
								}
								else if(GetPlayerVehicleID(OwnableCarOffer[playerid]) == PlayerInfo[OwnableCarOffer[playerid]][pPcarkey2])
								{
									PlayerInfo[playerid][pPcarkey2] = PlayerInfo[OwnableCarOffer[playerid]][pPcarkey2];
						    		PlayerInfo[OwnableCarOffer[playerid]][pPcarkey2] = -1;
								}
								else if(GetPlayerVehicleID(OwnableCarOffer[playerid]) == PlayerInfo[OwnableCarOffer[playerid]][pPcarkey3])
								{
									PlayerInfo[playerid][pPcarkey2] = PlayerInfo[OwnableCarOffer[playerid]][pPcarkey3];
						    		PlayerInfo[OwnableCarOffer[playerid]][pPcarkey3] = -1;
								}
								else
								{
								    SendClientMessage(playerid, COLOR_GREY, "  Vehicle seller needs to be at his car !");
									return 1;
								}
								format(string, sizeof(string), "* You bought a car for $%d from %s.",OwnableCarPrice[playerid],giveplayer);
								SendClientMessage(playerid, COLOR_WHITE, string);
								format(string, sizeof(string), "* %s has bought your car for $%d.",sendername,OwnableCarPrice[playerid]);
								SendClientMessage(OwnableCarOffer[playerid], COLOR_WHITE, string);
						    	RemovePlayerFromVehicle(OwnableCarOffer[playerid]);
						    	GivePlayerMoney(playerid, - OwnableCarPrice[playerid]);
						    	GivePlayerMoney(OwnableCarOffer[playerid], OwnableCarPrice[playerid]);
						    	strmid(CarInfo[OwnableCarID[playerid]][cOwner], sendername, 0, strlen(sendername), 999);
							}
						    else if(PlayerInfo[playerid][pPcarkey3] == -1)
							{
							    if(GetPlayerVehicleID(OwnableCarOffer[playerid]) == PlayerInfo[OwnableCarOffer[playerid]][pPcarkey])
								{
									PlayerInfo[playerid][pPcarkey3] = PlayerInfo[OwnableCarOffer[playerid]][pPcarkey];
						    		PlayerInfo[OwnableCarOffer[playerid]][pPcarkey] = -1;
								}
								else if(GetPlayerVehicleID(OwnableCarOffer[playerid]) == PlayerInfo[OwnableCarOffer[playerid]][pPcarkey2])
								{
									PlayerInfo[playerid][pPcarkey3] = PlayerInfo[OwnableCarOffer[playerid]][pPcarkey2];
						    		PlayerInfo[OwnableCarOffer[playerid]][pPcarkey2] = -1;
								}
								else if(GetPlayerVehicleID(OwnableCarOffer[playerid]) == PlayerInfo[OwnableCarOffer[playerid]][pPcarkey3])
								{
									PlayerInfo[playerid][pPcarkey3] = PlayerInfo[OwnableCarOffer[playerid]][pPcarkey3];
						    		PlayerInfo[OwnableCarOffer[playerid]][pPcarkey3] = -1;
								}
								else
								{
								    SendClientMessage(playerid, COLOR_GREY, "  Vehicle seller needs to be at his car !");
									return 1;
								}
								format(string, sizeof(string), "* You bought a car for $%d from %s.",OwnableCarPrice[playerid],giveplayer);
								SendClientMessage(playerid, COLOR_WHITE, string);
								format(string, sizeof(string), "* %s has bought your car for $%d.",sendername,OwnableCarPrice[playerid]);
								SendClientMessage(OwnableCarOffer[playerid], COLOR_WHITE, string);
						    	RemovePlayerFromVehicle(OwnableCarOffer[playerid]);
						    	GivePlayerMoney(playerid, - OwnableCarPrice[playerid]);
						    	GivePlayerMoney(OwnableCarOffer[playerid], OwnableCarPrice[playerid]);
						    	strmid(CarInfo[OwnableCarID[playerid]][cOwner], sendername, 0, strlen(sendername), 999);
							}
						    else
						    {
						        SendClientMessage(playerid, COLOR_GREY, "  You already have 3 cars ! ");
						        return 1;
							}
							OnPropUpdate();
							SavePlayerData(playerid);
							SavePlayerData(OwnableCarOffer[playerid]);
						    OwnableCarOffer[playerid] = -1;
							OwnableCarID[playerid] = 0;
							OwnableCarPrice[playerid] = 0;
							GameTextForPlayer(playerid, "~w~Congratulations~n~Don't forget to /v park it!", 5000, 3);
							SendClientMessage(playerid, COLOR_GRAD2, "Congratulations on your new purchase!");
							SendClientMessage(playerid, COLOR_GRAD2, "Type /vehiclemanual to view the vehicle manual!");
							return 1;
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GREY, "   Car seller is Offline !");
			        		return 1;
						}
			        }
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY, "   No-one offerd you any Ownable Car !");
			        return 1;
			    }
			}
			else { return 1; }
		}
		return 1;
	}

	if (strcmp(cmd, "/mycars", true) == 0)
	{
 		if(IsPlayerConnected(playerid))
	    {
            new carkey = PlayerInfo[playerid][pPcarkey];
		    new carkey2 = PlayerInfo[playerid][pPcarkey2];
		    new carkey3 = PlayerInfo[playerid][pPcarkey3];
            if (PlayerInfo[playerid][pPcarkey] != -1)
		    {
		        format(string, sizeof(string), "1| VehModel:[%s] VehValue:[%d] VehColor1:[%d] VehColor2:[%d] VehLocked:[%d]", CarInfo[carkey][cDescription], CarInfo[carkey][cValue], CarInfo[carkey][cColorOne], CarInfo[carkey][cColorTwo], CarInfo[carkey][cLock]);
		        SendClientMessage(playerid, COLOR_GRAD5,string);
		    }
		    if (PlayerInfo[playerid][pPcarkey2] != -1)
		    {
		        format(string, sizeof(string), "2| VehModel:[%s] VehValue:[%d] VehColor1:[%d] VehColor2:[%d] VehLocked:[%d]", CarInfo[carkey2][cDescription], CarInfo[carkey2][cValue], CarInfo[carkey2][cColorOne], CarInfo[carkey2][cColorTwo], CarInfo[carkey2][cLock]);
		        SendClientMessage(playerid, COLOR_GRAD5,string);
		    }
	    	if (PlayerInfo[playerid][pPcarkey3] != -1)
	    	{
		        format(string, sizeof(string), "3| VehModel:[%s] VehValue:[%d] VehColor1:[%d] VehColor2:[%d] VehLocked:[%d]", CarInfo[carkey3][cDescription], CarInfo[carkey3][cValue], CarInfo[carkey3][cColorOne], CarInfo[carkey3][cColorTwo], CarInfo[carkey3][cLock]);
		        SendClientMessage(playerid, COLOR_GRAD5,string);
	    	}
		}
		return 1;
	}

	if(strcmp(cmd, "/apark", true) == 0)
	{
		if(IsPlayerConnected(playerid))
 		{
			new Float:x,Float:y,Float:z;
			new Float:a;
			new carid;
			carid = GetPlayerVehicleID(playerid);
			GetPlayerName(playerid, playername, sizeof(playername));
			GetVehiclePos(carid, x, y, z);
			GetVehicleZAngle(carid, a);
			if(IsPlayerAdmin(playerid))
			{
				CarInfo[carid][cLocationx] = x;
				CarInfo[carid][cLocationy] = y;
				CarInfo[carid][cLocationz] = z;
				CarInfo[carid][cAngle] = a;
				format(string, sizeof(string), "~n~ You have parked your car in this location. ~n~");
				GameTextForPlayer(playerid, "You have parked this car in this position. It will respawn here.", 10000, 3);
				OnPropUpdate(); SavePlayerData(playerid);
	    		DestroyVehicle(carid);
	    		new thiscar = CreateVehicle(CarInfo[carid][cModel],CarInfo[carid][cLocationx],CarInfo[carid][cLocationy],CarInfo[carid][cLocationz]+1.0,CarInfo[carid][cAngle],CarInfo[carid][cColorOne],CarInfo[carid][cColorTwo],60000);
	    		LoadComponents(thiscar);
                return 1;
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "   You are not authorized to use that command !");
			    return 1;
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/adeletecar", true) == 0)
	{
	    if(IsPlayerAdmin(playerid))
	    {
            CarInfo[idcar][cOwned] = 0; CarInfo[idcar][cModel] = 0; CarInfo[idcar][cColorOne] = 0; CarInfo[idcar][cColorTwo] = 0;
			CarInfo[idcar][cLocationx] = 0; CarInfo[idcar][cLocationy] = 0; CarInfo[idcar][cLocationz] = 0; CarInfo[idcar][cAngle] = 0;
			CarInfo[idcar][cValue] = 0; CarInfo[idcar][cLock] = 0; CarInfo[idcar][paintjob] = -1; LoadComponents(idcar);
			strmid(CarInfo[idcar][cOwner], "Dealership", 0, strlen("Dealership"), 999);
			format(CarInfo[idcar][cDescription], 32, "0");
			DestroyVehicle(idcar);
			OnPropUpdate(); SavePlayerData(playerid);
	    }
	}

	if(strcmp(cmd, "/acreatecar", true) == 0)
	{
	    if(IsPlayerAdmin(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /acreatecar [carid] [culoare1] [culoare2] [Pretul]");
				return 1;
			}
			new car;
			car = strval(tmp);
			if(car < 400 || car > 611) { SendClientMessage(playerid, COLOR_WHITE, " Vehicle Number can't be below 400 or above 611 !"); return 1; }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /acreatecar [carid] [culoare1] [culoare2] [Pretul]");
				return 1;
			}
			new color1;
			color1 = strval(tmp);
			if(color1 < 0 || color1 > 126) { SendClientMessage(playerid, COLOR_WHITE, " Color Number can't be below 0 or above 126 !"); return 1; }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /acreatecar [carid] [culoare1] [culoare2] [Pretul]");
				return 1;
			}
			new color2;
			color2 = strval(tmp);
			if(color2 < 0 || color2 > 126) { SendClientMessage(playerid, COLOR_WHITE, " Color Number can't be below 0 or above 126 !"); return 1; }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /acreatecar [carid] [culoare1] [culoare2] [Pretul]");
				return 1;
			}
			new value;
			value = strval(tmp);
			new Float:X,Float:Y,Float:Z; GetPlayerPos(playerid, X,Y,Z);
            new thiscar = CreateVehicle(car,X,Y,Z,1,color1,color2,99999999);
            format(CarInfo[thiscar][cLicense], 32 ,"ForSale");
	        SetVehicleNumberPlate(vehid,CarInfo[thiscar][cLicense]);
			CarInfo[thiscar][cOwned] = 0; CarInfo[thiscar][cModel] = car; CarInfo[thiscar][cColorOne] = color1; CarInfo[thiscar][cColorTwo] = color2;
			CarInfo[thiscar][cLocationx] = X; CarInfo[thiscar][cLocationy] = Y; CarInfo[thiscar][cLocationz] = Z; CarInfo[thiscar][cAngle] = 1;
			CarInfo[thiscar][cValue] = value; CarInfo[thiscar][cLock] = 0; CarInfo[thiscar][paintjob] = -1; LoadComponents(thiscar);
			PutPlayerInVehicle(playerid,thiscar,0);
			strmid(CarInfo[vehid][cOwner], "Dealership", 0, strlen("Dealership"), 999);
			format(CarInfo[thiscar][cDescription], 32, "%s",vehName[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
			format(string, sizeof(string), " Masina %d a fost creata cu succes!.", thiscar);
			SendClientMessage(playerid, COLOR_BLUE, string);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GRAD1, " you are not authorized to use that command!");
			return 1;
		}
	}

    if(!strcmp(cmdtext, "/asellcar", true))
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(!IsAtDealership(playerid))
	        {
	            SendClientMessage(playerid, COLOR_GREY, "   You are not at dealership ! ");
	            return 1;
	        }
	        if(IsPlayerAdmin(playerid))
	        {
	            new Float:x,Float:y,Float:z;
         		new Float:a;
         		CarInfo[vehid][cOwned] = 0;
         		strmid(CarInfo[vehid][cOwner], "Dealership", 0, strlen("Dealership"), 999);
         		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
         		GameTextForPlayer(playerid, "~w~You have admin sold the vehicle", 10000, 3);
         		GetVehiclePos(vehid, x, y, z);
         		GetVehicleZAngle(vehid, a);
         		CarInfo[vehid][cLocationx] = x;
         		CarInfo[vehid][cLocationy] = y;
         		CarInfo[vehid][cLocationz] = z;
         		CarInfo[vehid][cAngle] = a;
         		RemovePlayerFromVehicle(playerid);
         		TogglePlayerControllable(playerid, 1);
         		format(CarInfo[vehid][cLicense], 32 ,"ForSale");
	            SetVehicleNumberPlate(vehid,CarInfo[vehid][cLicense]);
         		OnPropUpdate(); SavePlayerData(playerid);
         		DestroyVehicle(vehid);
				new thiscar = CreateVehicle(CarInfo[vehid][cModel],CarInfo[vehid][cLocationx],CarInfo[vehid][cLocationy],CarInfo[vehid][cLocationz]+1.0,CarInfo[vehid][cAngle],CarInfo[vehid][cColorOne],CarInfo[vehid][cColorTwo],60000);
				LoadComponents(thiscar);
	            return 1;
	        }
	        else
	        {
	            SendClientMessage(playerid, COLOR_GREY, "   You're not authorized to use that command !");
	            return 1;
	        }
	    }
	    return 1;
	}

	if(strcmp(cmd, "/asetkey", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD1, "USAGE: /asetkey [playerid/PartOfName] [carkey] [amount]");
				SendClientMessage(playerid, COLOR_GRAD4, "|1 CarKey |2 CarKey2 |3 CarKey3");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
            if(IsPlayerAdmin(playerid))
	    	{
	    	    if(giveplayerid != INVALID_PLAYER_ID)
	    	    {
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_GRAD1, "USAGE: /asetkey [playerid/PartOfName] [carkey] [amount]");
						SendClientMessage(playerid, COLOR_GRAD4, "|1 CarKey |2 CarKey2 |3 CarKey3");
						return 1;
					}
					new stat;
					stat = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_GRAD1, "USAGE: /asetkey [playerid/PartOfName] [carkey] [amount]");
						SendClientMessage(playerid, COLOR_GRAD4, "|1 CarKey |2 CarKey2 |3 CarKey3");
						return 1;
					}
					new amount;
					amount = strval(tmp);
					switch (stat)
					{
						case 1:
						{
								PlayerInfo[giveplayerid][pPcarkey] = amount;
								format(string, sizeof(string), "   The Player Car Key Was Set To %d", amount);
								SavePlayerData(playerid);
						}
						case 2:
						{
								PlayerInfo[giveplayerid][pPcarkey2] = amount;
								format(string, sizeof(string), "   The Player Car Key 2 Was Set To %d", amount);
								SavePlayerData(playerid);
						}
						case 3:
						{
								PlayerInfo[giveplayerid][pPcarkey3] = amount;
								format(string, sizeof(string), "   The Player Car Key 3 Was Set To %d", amount);
								SavePlayerData(playerid);
						}
						default:
						{
								format(string, sizeof(string), "   Invalid Car Key Code", amount);
						}
					}
					SendClientMessage(playerid, COLOR_GRAD1, string);
				}
			}
			else
			{
                SendClientMessage(playerid, COLOR_GRAD1, "   Doar adminii pot folosi aceasta comanda!");
                return 1;
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/removetuning", true) == 0)
	{
	    if(IsPlayerInVehicle(playerid, vehid))
	    {
	        if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey] || GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey2] || GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey3])
	        {
                ShowPlayerDialog(playerid, DIALOGID+2, DIALOG_STYLE_LIST, "Lista Tuning", "Eleron\nSpoiler Fata\nSpoiler Spate\nLaterale\nRoof\nToba Esapament\nNitro\nHidraulica\nRoti\nTatuaj\nToate Componentele","Scoate", "Cancel");
			}
			else
			{
                SendClientMessage(playerid, COLOR_WHITE, "Nu poti scoate tuningul pentru ca aceasta masina nu iti apartine.");
                return 1;
	        }
	    }
	    else
	    {
            SendClientMessage(playerid, COLOR_WHITE, "Trebuie sa fii in masina pentru a scoate tuningul!!");
            return 1;
	    }
    }

	if(strcmp(cmd, "/v", true) == 0 || strcmp(cmd, "/vehicle", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        new x_nr[64];
	        x_nr = strtok(cmdtext, idx);
	        if(!strlen(x_nr))
	        {
	            SendClientMessage(playerid, COLOR_WHITE, "HINT: (/v)ehicle [name]");
	            SendClientMessage(playerid, COLOR_WHITE, "Available names: park, lock(1-3), sell, sellto, color, setplate, locate(1-3), tow(1-3)");
	            return 1;
	        }
	        if(strcmp(x_nr,"sell",true) == 0)
	        {
	            if(IsAtDealership(playerid))
	            {
	                if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey] || GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey2] || GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey3])
	                {
	                    GetPlayerName(playerid, sendername, sizeof(sendername));
	                    new ownvehkey;
	                    if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey]) { ownvehkey = PlayerInfo[playerid][pPcarkey]; }
	                    else if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey2]) { ownvehkey = PlayerInfo[playerid][pPcarkey2]; }
	                    else if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey3]) { ownvehkey = PlayerInfo[playerid][pPcarkey3]; }
	                    else { return 1; }
	                    if(strcmp(sendername, CarInfo[ownvehkey][cOwner], true) == 0)
	                    {
	                        new carsellprice = CarInfo[ownvehkey][cValue] / 4 * 3;
	                        new Float:x,Float:y,Float:z;
	                        new Float:a;
	                        CarInfo[ownvehkey][cOwned] = 0;
	                        strmid(CarInfo[ownvehkey][cOwner], "Dealership", 0, strlen("Dealership"), 999);
	                        GivePlayerMoney(playerid,carsellprice);
	                        PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	                        format(string, sizeof(string), "~w~You have sold your car for: ~n~~g~$%d", carsellprice);
	                        GameTextForPlayer(playerid, string, 10000, 3);
	                        GetVehiclePos(ownvehkey, x, y, z);
	                        GetVehicleZAngle(ownvehkey, a);
	                        CarInfo[ownvehkey][cLocationx] = x; CarInfo[ownvehkey][cLocationy] = y; CarInfo[ownvehkey][cLocationz] = z; CarInfo[ownvehkey][cAngle] = a;
	                        CarInfo[ownvehkey][mod1] = 0; CarInfo[ownvehkey][mod2] = 0; CarInfo[ownvehkey][mod3] = 0; CarInfo[ownvehkey][mod4] = 0;
	                        CarInfo[ownvehkey][mod5] = 0; CarInfo[ownvehkey][mod6] = 0; CarInfo[ownvehkey][mod7] = 0; CarInfo[ownvehkey][mod8] = 0;
	                        CarInfo[ownvehkey][mod9] = 0; CarInfo[ownvehkey][mod10] = 0; CarInfo[ownvehkey][mod11] = 0; CarInfo[ownvehkey][mod12] = 0;
							CarInfo[ownvehkey][mod13] = 0; CarInfo[ownvehkey][mod14] = 0; CarInfo[ownvehkey][mod15] = 0; CarInfo[ownvehkey][mod16] = 0;
	                        CarInfo[ownvehkey][mod17] = 0; CarInfo[ownvehkey][paintjob] = -1;
	                        if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey]) { PlayerInfo[playerid][pPcarkey] = -1; }
	                        else if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey2]) { PlayerInfo[playerid][pPcarkey2] = -1; }
	                        else if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey3]) { PlayerInfo[playerid][pPcarkey3] = -1; }
	                        RemovePlayerFromVehicle(playerid);
	                        TogglePlayerControllable(playerid, 1);
	                        format(CarInfo[vehid][cLicense], 32 ,"ForSale");
	                        SetVehicleNumberPlate(vehid,CarInfo[vehid][cLicense]);
	                        OnPropUpdate(); SavePlayerData(playerid);
	                        DestroyVehicle(ownvehkey);
							new thiscar = CreateVehicle(CarInfo[ownvehkey][cModel],CarInfo[ownvehkey][cLocationx],CarInfo[ownvehkey][cLocationy],CarInfo[ownvehkey][cLocationz]+1.0,CarInfo[ownvehkey][cAngle],CarInfo[ownvehkey][cColorOne],CarInfo[ownvehkey][cColorTwo],60000);
							LoadComponents(thiscar);
	                        return 1;
	                    }
	                }
	                else
	                {
	                    SendClientMessage(playerid, COLOR_GREY, "  You have to sit at your own car to sell it! ");
	                    return 1;
	                }
	            }
	            else
	            {
	                SendClientMessage(playerid, COLOR_GREY, "You are not at a dealership");
	                return 1;
	            }
	        }
	        else if(strcmp(x_nr,"buy",true) == 0)
	        {
	            if(IsAnOwnableCar(idcar))
	            {
			    	if(PlayerInfo[playerid][pPcarkey] == -1) { }
			    	else if(PlayerInfo[playerid][pPcarkey2] == -1) { }
			    	else if(PlayerInfo[playerid][pPcarkey3] == -1) { }
			    	else { SendClientMessage(playerid, COLOR_GREY, "   Ai deja 3 masini!!"); return 1; }
					if(CarInfo[idcar][cOwned]==1)
					{
				    	SendClientMessage(playerid, COLOR_GREY, "Someone already owns this car");
				    	return 1;
					}
					if(GetPlayerMoney(playerid) >= CarInfo[idcar][cValue])
					{
					    if(PlayerInfo[playerid][pPcarkey] == -1) { PlayerInfo[playerid][pPcarkey] = idcar; }
					    else if(PlayerInfo[playerid][pPcarkey2] == -1) { PlayerInfo[playerid][pPcarkey2] = idcar; }
					    else if(PlayerInfo[playerid][pPcarkey3] == -1) { PlayerInfo[playerid][pPcarkey3] = idcar; }
					    else { return 1; }
						CarInfo[idcar][cOwned] = 1;
						GetPlayerName(playerid, sendername, sizeof(sendername));
						strmid(CarInfo[idcar][cOwner], sendername, 0, strlen(sendername), 999);
						GivePlayerMoney(playerid,-CarInfo[idcar][cValue]);
						PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
						GameTextForPlayer(playerid, "~w~Felicitari~n~Nu uita sa o parchezi cu /v park!", 5000, 3);
				        SendClientMessage(playerid, COLOR_GRAD2, "Felicitari ti-ai cumparat o masina noua!");
				        TogglePlayerControllable(playerid, 1);
						OnPropUpdate(); SavePlayerData(playerid);
						return 1;
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "  You don't have enough cash with you ! ");
					    return 1;
					}
	            }
	        }
	        else if(strcmp(x_nr,"sellto",true) == 0)
	        {
				if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey] || GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey2] || GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey3])
				{
				    GetPlayerName(playerid, sendername, sizeof(sendername));
				    new ownvehkey;
	                if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey]) { ownvehkey = PlayerInfo[playerid][pPcarkey]; }
	                else if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey2]) { ownvehkey = PlayerInfo[playerid][pPcarkey2]; }
	                else if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey3]) { ownvehkey = PlayerInfo[playerid][pPcarkey3]; }
        			else { return 1; }
				    if(strcmp(sendername, CarInfo[ownvehkey][cOwner], true) == 0)
				    {
						tmp = strtok(cmdtext, idx);
						if(!strlen(tmp))
						{
						    SendClientMessage(playerid, COLOR_WHITE, "HINT: /v sellto [playerid/PartOfName] [price]");
						    return 1;
						}
						giveplayerid = ReturnUser(tmp);
						if(IsPlayerConnected(giveplayerid))
						{
							if(giveplayerid != INVALID_PLAYER_ID)
							{
							    if(ProxDetectorS(8.0, playerid, giveplayerid))
       							{
							    	if(PlayerInfo[giveplayerid][pPcarkey] == -1)
							    	{
							            tmp = strtok(cmdtext, idx);
							            if(!strlen(tmp))
							            {
							                SendClientMessage(playerid, COLOR_WHITE, "HINT: /v sellto [playerid/PartOfName] [price]");
							                return 1;
							            }
							            new price;
							            price = strval(tmp);
							            if(price < 1 || price > 1500000)
							            {
							                SendClientMessage(playerid, COLOR_GREY, "  Price not lower then 1 and not higher then 1500000. ");
							                return 1;
							            }
							            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							       		format(string, sizeof(string), "* You offerd %s to buy your car for $%d .", giveplayer, price);
					        			SendClientMessage(playerid, COLOR_WHITE, string);
					        			format(string, sizeof(string), "* Car Owner %s offered you to buy his/her car for $%d (type /accept ownablecar) to buy.", playername, price);
					        			SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        			OwnableCarOffer[giveplayerid] = playerid;
					        			OwnableCarID[giveplayerid] = ownvehkey;
					        			OwnableCarPrice[giveplayerid] = price;
					        			return 1;
							        }
							        else if(PlayerInfo[giveplayerid][pPcarkey2] == -1)
							        {
							            tmp = strtok(cmdtext, idx);
							            if(!strlen(tmp))
							            {
							                SendClientMessage(playerid, COLOR_WHITE, "HINT: /v sellto [playerid/PartOfName] [price]");
							                return 1;
							            }
							            new price;
							            price = strval(tmp);
							            if(price < 1 || price > 1500000)
							            {
							                SendClientMessage(playerid, COLOR_GREY, "  Price not lower then 1 and not higher then 1500000. ");
							                return 1;
							            }
							            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							       		format(string, sizeof(string), "* You offerd %s to buy your car for $%d .", giveplayer, price);
					        			SendClientMessage(playerid, COLOR_WHITE, string);
					        			format(string, sizeof(string), "* Car Owner %s offered you to buy his/her car for $%d (type /accept ownablecar) to buy.", playername, price);
					        			SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        			OwnableCarOffer[giveplayerid] = playerid;
					        			OwnableCarID[giveplayerid] = ownvehkey;
					        			OwnableCarPrice[giveplayerid] = price;
					        			return 1;
							        }
							        else if(PlayerInfo[giveplayerid][pPcarkey3] == -1)
							        {
							            tmp = strtok(cmdtext, idx);
							            if(!strlen(tmp))
							            {
							                SendClientMessage(playerid, COLOR_WHITE, "HINT: /v sellto [playerid/PartOfName] [price]");
							                return 1;
							            }
							            new price;
							            price = strval(tmp);
							            if(price < 1 || price > 1500000)
							            {
							                SendClientMessage(playerid, COLOR_GREY, "  Price not lower then 1 and not higher then 1500000. ");
							                return 1;
							            }
							            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							       		format(string, sizeof(string), "* You offerd %s to buy your car for $%d .", giveplayer, price);
					        			SendClientMessage(playerid, COLOR_WHITE, string);
					        			format(string, sizeof(string), "* Car Owner %s offered you to buy his/her car for $%d (type /accept ownablecar) to buy.", playername, price);
					        			SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        			OwnableCarOffer[giveplayerid] = playerid;
					        			OwnableCarID[giveplayerid] = ownvehkey;
					        			OwnableCarPrice[giveplayerid] = price;
					        			return 1;
							        }
							        else
							        {
							            SendClientMessage(playerid, COLOR_GREY, "   Player has 3 cars already ! ");
							            return 1;
							        }
							    }
							    else
							    {
							        SendClientMessage(playerid, COLOR_GREY, "   Player is not near you ! ");
							        return 1;
							    }
							}
						}
				    }
				    else
				    {
				        SendClientMessage(playerid, COLOR_GREY, "  This is not your car");
				        return 1;
				    }
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "  You have to sit at your own car to sell it");
				    return 1;
				}
	        }
	        else if(strcmp(x_nr,"park",true) == 0)
	        {
	            new Float:x,Float:y,Float:z;
				new Float:a;
				new carid;
				new getcarid;
				if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey]) { carid = PlayerInfo[playerid][pPcarkey]; }
				else if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey2]) { carid = PlayerInfo[playerid][pPcarkey2]; }
				else if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey3]) { carid = PlayerInfo[playerid][pPcarkey3]; }
				else { return 1; }
				getcarid = GetPlayerVehicleID(playerid);
				GetPlayerName(playerid, playername, sizeof(playername));
				GetVehiclePos(carid, x, y, z);
				GetVehicleZAngle(carid, a);
				if(IsPlayerInVehicle(playerid,carid) && CarInfo[carid][cOwned] == 1)
				{
			   		if(PlayerInfo[playerid][pPcarkey] == -1 && PlayerInfo[playerid][pPcarkey2] == -1 && PlayerInfo[playerid][pPcarkey3] == -1)
					{
						SendClientMessage(playerid, COLOR_GREY, "You don't own a car.");
						return 1;
					}
   					if(getcarid == carid)
					{
                        new Float:CarHP, Float:OldCarHP; new panels,doors,lights,tires;
						CarInfo[carid][cLocationx] = x;
						CarInfo[carid][cLocationy] = y;
						CarInfo[carid][cLocationz] = z;
						CarInfo[carid][cAngle] = a;
						GetVehicleDamageStatus(carid,panels,doors,lights,tires);
						GetVehicleHealth(carid, CarHP); OldCarHP = CarHP;
						format(string, sizeof(string), "~n~ You have parked your vehicle in this location. ~n~");
						GameTextForPlayer(playerid, "You have parked your vehicle in this position. It will respawn here.", 10000, 3);
						OnPropUpdate(); SavePlayerData(playerid);  DestroyVehicle(carid);
						CreateVehicle(CarInfo[carid][cModel],CarInfo[carid][cLocationx],CarInfo[carid][cLocationy],CarInfo[carid][cLocationz]+1.0,CarInfo[carid][cAngle],CarInfo[carid][cColorOne],CarInfo[carid][cColorTwo],60000);
						LoadComponents(carid);
						PutPlayerInVehicle(playerid,carid,0); SetVehicleHealth(carid, OldCarHP);
						UpdateVehicleDamageStatus(carid,panels,doors,lights,tires);
						TogglePlayerControllable(playerid, 1);
						return 1;
   					}
				}
	        }
	        else if(strcmp(x_nr,"setplate",true) == 0)
	        {
				if(IsPlayerInVehicle(playerid, vehid) || PlayerInfo[vehid][pPcarkey] != -1 && PlayerInfo[vehid][pPcarkey2] != -1 && PlayerInfo[vehid][pPcarkey3] != -1)
				{
			        if(cmdtext[idx++] != 32 || cmdtext[idx] == EOS)
                    {
                        SendClientMessage(playerid,0xFFFFFFAA,"USAGE: /v setplate [newplate]");
                        return 1;
				    }
				    new Float:XX,Float:YY,Float:ZZ,Float:AA;
                    new Float:CarHP, Float:OldCarHP;
                    new panels,doors,lights,tires;
	                GetVehicleHealth(vehid, CarHP);
	                GetVehicleDamageStatus(vehid,panels,doors,lights,tires);
			        OldCarHP = CarHP;
	                format(CarInfo[vehid][cLicense], 32 ,"%s",cmdtext[idx]);
                    SetVehicleNumberPlate(vehid,CarInfo[vehid][cLicense]);
	                GetVehiclePos(vehid,XX,YY,ZZ);
	                GetVehicleZAngle(vehid, AA);
	                SetVehicleToRespawn(vehid);
	                SetVehiclePos(vehid,XX,YY,ZZ);
	                SetVehicleZAngle(vehid, AA);
	                PutPlayerInVehicle(playerid,vehid,0);
	                SetVehicleHealth(vehid, OldCarHP);
	                UpdateVehicleDamageStatus(vehid,panels,doors,lights,tires);
	                format(string, sizeof(string), "{FFFF00}You have set your vehicle's plate to:{FFFFFF} %s", CarInfo[vehid][cLicense]);
	                SendClientMessage(playerid, 0xFFFFFFFF, string);
	                OnPropUpdate(); SavePlayerData(playerid);
	            }
	            else
	            {
                    SendClientMessage(playerid, 0xFFFFFFAA, "Nu esti in masina ta personala pentru a putea schimba NR de Inmatriculare.");
				    return 1;
			    }
			}

	        else if(strcmp(x_nr,"lock1",true) == 0)
	        {
                new keycar = PlayerInfo[playerid][pPcarkey];
                if(keycar != -1)
                {
                    new locked[256];
                    locked = strtok(cmdtext, idx);
                    if(CarInfo[keycar][cLock] == 1)
                    {
                    	for(new i = 0; i < MAX_PLAYERS; i++)
						{
							if (IsPlayerConnected(i))
							{
								SetVehicleParamsForPlayer(keycar,i,0,0);
							}
						}
						format(string, sizeof(string), "~w~Vehicle~n~~g~Unlocked");
						GameTextForPlayer(playerid, string, 4000, 3);
						CarInfo[keycar][cLock] = 0;
						OnPropUpdate(); SavePlayerData(playerid);
						return 1;
					}
					else if(CarInfo[keycar][cLock] == 0)
					{
					    for(new i = 0; i < MAX_PLAYERS; i++)
						{
							if (IsPlayerConnected(i))
							{
								SetVehicleParamsForPlayer(keycar,i,0,1);
							}
						}
						format(string, sizeof(string), "~w~Vehicle~n~~r~Locked");
						GameTextForPlayer(playerid, string, 4000, 3);
						CarInfo[keycar][cLock] = 1;
						OnPropUpdate(); SavePlayerData(playerid);
						return 1;
					}
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "  You don't have a vehicle at slot 1");
                    return 1;
                }
	        }
	        else if(strcmp(x_nr,"lock2",true) == 0)
	        {
                new keycar = PlayerInfo[playerid][pPcarkey2];
                if(keycar != -1)
                {
                    new locked[256];
                    locked = strtok(cmdtext, idx);
                    if(CarInfo[keycar][cLock] == 1)
                    {
                    	for(new i = 0; i < MAX_PLAYERS; i++)
						{
							if (IsPlayerConnected(i))
							{
								SetVehicleParamsForPlayer(keycar,i,0,0);
							}
						}
						format(string, sizeof(string), "~w~Vehicle~n~~g~Unlocked");
						GameTextForPlayer(playerid, string, 4000, 3);
						CarInfo[keycar][cLock] = 0;
						OnPropUpdate(); SavePlayerData(playerid);
						return 1;
					}
					else if(CarInfo[keycar][cLock] == 0)
					{
					    for(new i = 0; i < MAX_PLAYERS; i++)
						{
							if (IsPlayerConnected(i))
							{
								SetVehicleParamsForPlayer(keycar,i,0,1);
							}
						}
						format(string, sizeof(string), "~w~Vehicle~n~~r~Locked");
						GameTextForPlayer(playerid, string, 4000, 3);
						CarInfo[keycar][cLock] = 1;
						OnPropUpdate(); SavePlayerData(playerid);
						return 1;
					}
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "  You don't have a vehicle at slot 2");
                    return 1;
                }
	        }
	        else if(strcmp(x_nr,"lock3",true) == 0)
	        {
                new keycar = PlayerInfo[playerid][pPcarkey3];
                if(keycar != -1)
                {
                    new locked[256];
                    locked = strtok(cmdtext, idx);
                    if(CarInfo[keycar][cLock] == 1)
                    {
                    	for(new i = 0; i < MAX_PLAYERS; i++)
						{
							if (IsPlayerConnected(i))
							{
								SetVehicleParamsForPlayer(keycar,i,0,0);
							}
						}
						format(string, sizeof(string), "~w~Vehicle~n~~g~Unlocked");
						GameTextForPlayer(playerid, string, 4000, 3);
						CarInfo[keycar][cLock] = 0;
						OnPropUpdate(); SavePlayerData(playerid);
						return 1;
					}
					else if(CarInfo[keycar][cLock] == 0)
					{
					    for(new i = 0; i < MAX_PLAYERS; i++)
						{
							if (IsPlayerConnected(i))
							{
								SetVehicleParamsForPlayer(keycar,i,0,1);
							}
						}
						format(string, sizeof(string), "~w~Vehicle~n~~r~Locked");
						GameTextForPlayer(playerid, string, 4000, 3);
						CarInfo[keycar][cLock] = 1;
						OnPropUpdate(); SavePlayerData(playerid);
						return 1;
					}
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "  You don't have a vehicle at slot 3");
                    return 1;
                }
	        }
	        else if(strcmp(x_nr,"color",true) == 0)
	        {
	            if(PlayerInfo[playerid][pPcarkey] == -1 && PlayerInfo[playerid][pPcarkey2] == -1 && PlayerInfo[playerid][pPcarkey3] == -1)
	        	{
	            	SendClientMessage(playerid, COLOR_GREY,"   You don't have a vehicle to respray.");
	            	return 1;
	        	}
	        	if(GetPlayerMoney(playerid) < 1000)
	        	{
	            	SendClientMessage(playerid, COLOR_GREY,"   You don't have enough money for vehicle respray.");
	            	return 1;
	        	}
	        	tmp = strtok(cmdtext, idx);
	        	if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "USAGE: /v color [ColorOneID] [ColorTwoID]");
					return 1;
				}
				new color1;
				color1 = strval(tmp);
				if(color1 < 0 && color1 > 126)
				{
			    	SendClientMessage(playerid, COLOR_GREY, "   Wrong color id!");
			    	return 1;
				}
				tmp = strtok(cmdtext, idx);
	        	if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "USAGE: /v color [ColorOneID] [ColorTwoID]");
					return 1;
				}
				new color2;
				color2 = strval(tmp);
				if(color2 < 0 && color2 > 126)
				{
			    	SendClientMessage(playerid, COLOR_GREY, "   Wrong color id!");
			    	return 1;
				}

				if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey]) { vehid = PlayerInfo[playerid][pPcarkey]; }
				else if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey2]) { vehid = PlayerInfo[playerid][pPcarkey2]; }
				else if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pPcarkey3]) { vehid = PlayerInfo[playerid][pPcarkey3]; }
				else { return 1; }

	        	if(IsPlayerInVehicle(playerid, vehid))
	        	{
         			CarInfo[vehid][cColorOne] = color1;
	                CarInfo[vehid][cColorTwo] = color2;
	                GivePlayerMoney(playerid, -1000);
	                GameTextForPlayer(playerid, "~w~Bill for a Paint Respray~n~~r~-$1000", 5000, 1);
	                ChangeVehicleColor(vehid, color1, color2);
	                OnPropUpdate(); SavePlayerData(playerid);
					return 1;
    			}
	        	else
	        	{
	            	SendClientMessage(playerid, COLOR_GREY,"   You are not in your vehicle.");
	            	return 1;
	        	}
	        }
	        else if(strcmp(x_nr,"locate1",true) == 0)
	        {
	 		    if(!IsPlayerConnected(playerid)) { return 1; }
			    new Float:x,Float:y,Float:z;
			    new car = PlayerInfo[playerid][pPcarkey];
			    if(PlayerInfo[playerid][pPcarkey]==-1) { GameTextForPlayer(playerid, "~w~Nu ai o masina pentru a putea fi localizata", 2500, 3); return 1; }
				SendClientMessage(playerid,COLOR_WHITE,"Locatia masinii a fost gasita.");
				GetVehiclePos(car, x, y, z);
			    SetPlayerCheckpoint(playerid, x, y, z, 6);
			    return 1;
	        }
	        else if(strcmp(x_nr,"locate2",true) == 0)
	        {
	 		    if(!IsPlayerConnected(playerid)) { return 1; }
			    new Float:x,Float:y,Float:z;
			    new car = PlayerInfo[playerid][pPcarkey2];
			    if(PlayerInfo[playerid][pPcarkey]==-1) { GameTextForPlayer(playerid, "~w~Nu ai o masina pentru a putea fi localizata", 2500, 3); return 1; }
				SendClientMessage(playerid,COLOR_WHITE,"Locatia masinii a fost gasita.");
				GetVehiclePos(car, x, y, z);
			    SetPlayerCheckpoint(playerid, x, y, z, 6);
			    return 1;
	        }
	        else if(strcmp(x_nr,"locate3",true) == 0)
	        {
	 		    if(!IsPlayerConnected(playerid)) { return 1; }
			    new Float:x,Float:y,Float:z;
			    new car = PlayerInfo[playerid][pPcarkey3];
			    if(PlayerInfo[playerid][pPcarkey]==-1) { GameTextForPlayer(playerid, "~w~Nu ai o masina pentru a putea fi localizata", 2500, 3); return 1; }
				SendClientMessage(playerid,COLOR_WHITE,"Locatia masinii a fost gasita.");
				GetVehiclePos(car, x, y, z);
			    SetPlayerCheckpoint(playerid, x, y, z, 6);
			    return 1;
	        }
	        else if(strcmp(x_nr,"tow1",true) == 0)
	        {
	 		   if(IsPlayerConnected(playerid))
				{
					new car = PlayerInfo[playerid][pPcarkey];
					GetPlayerName(playerid, playername, sizeof(playername));
					if (car != -1 && strcmp(playername, CarInfo[PlayerInfo[playerid][pPcarkey]][cOwner], true) == 0)
					{
						GameTextForPlayer(playerid, "~w~Masina a fost~n~~g~Tractata cu succes~n~~r~$-1500", 5000, 1);
						GivePlayerMoney(playerid,-1500);
						SetVehicleToRespawn(car);
						PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					}
					else
					{
						GameTextForPlayer(playerid, "~w~Nu detii o masina personala.", 5000, 1);
					}
				}
	        }
	        else if(strcmp(x_nr,"tow2",true) == 0)
	        {
	 		   if(IsPlayerConnected(playerid))
				{
					new car = PlayerInfo[playerid][pPcarkey2];
					GetPlayerName(playerid, playername, sizeof(playername));
					if (car != -1 && strcmp(playername, CarInfo[PlayerInfo[playerid][pPcarkey2]][cOwner], true) == 0)
					{
					    GameTextForPlayer(playerid, "~w~Masina a fost~n~~g~Tractata cu succes~n~~r~$-1500", 5000, 1);
						GivePlayerMoney(playerid,-1500);
						SetVehicleToRespawn(car);
						PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					}
					else
					{
						GameTextForPlayer(playerid, "~w~Nu detii o masina personala.", 5000, 1);
					}
				}
	        }
	        else if(strcmp(x_nr,"tow3",true) == 0)
	        {
	 		   if(IsPlayerConnected(playerid))
				{
					new car = PlayerInfo[playerid][pPcarkey3];
					GetPlayerName(playerid, playername, sizeof(playername));
					if (car != -1 && strcmp(playername, CarInfo[PlayerInfo[playerid][pPcarkey3]][cOwner], true) == 0)
					{
					    GameTextForPlayer(playerid, "~w~Masina a fost~n~~g~Tractata cu succes~n~~r~$-1500", 5000, 1);
						GivePlayerMoney(playerid,-1500);
						SetVehicleToRespawn(car);
						PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					}
					else
					{
						GameTextForPlayer(playerid, "~w~Nu detii o masina personala.", 5000, 1);
					}
				}
	        }
	        else
	        {
	            SendClientMessage(playerid, COLOR_WHITE, "HINT: (/v)ehicle [name]");
	            SendClientMessage(playerid, COLOR_WHITE, "Available names: park, lock(1-3), sell, sellto, color, setplate, locate(1-3), tow(1-3)");
	            return 1;
	        }
	    }
	    return 1;
	}
	return 0;
}

public OnPlayerEnterCheckpoint(playerid)
{
	DisablePlayerCheckpoint(playerid);
	return 1;
}
/*----------Car Save Functions----------*/

public LoadCar()
{
	new arrCoords[31][64];
	new strFromFile2[256];
	new File: file = fopen("masini.cfg", io_read);
	if (file)
	{
		new idx = carsonserver;
		while (idx < sizeof(CarInfo))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, ',');
			CarInfo[idx][cModel] = strval(arrCoords[0]);
			CarInfo[idx][cLocationx] = floatstr(arrCoords[1]);
			CarInfo[idx][cLocationy] = floatstr(arrCoords[2]);
			CarInfo[idx][cLocationz] = floatstr(arrCoords[3]);
			CarInfo[idx][cAngle] = floatstr(arrCoords[4]);
			CarInfo[idx][cColorOne] = strval(arrCoords[5]);
			CarInfo[idx][cColorTwo] = strval(arrCoords[6]);
			strmid(CarInfo[idx][cOwner], arrCoords[7], 0, strlen(arrCoords[7]), 255);
			strmid(CarInfo[idx][cDescription], arrCoords[8], 0, strlen(arrCoords[8]), 255);
			CarInfo[idx][cValue] = strval(arrCoords[9]);
			strmid(CarInfo[idx][cLicense], arrCoords[10], 0, strlen(arrCoords[10]), 255);
			CarInfo[idx][cOwned] = strval(arrCoords[11]);
			CarInfo[idx][cLock] = strval(arrCoords[12]);
			CarInfo[idx][mod1] = strval(arrCoords[13]);
			CarInfo[idx][mod2] = strval(arrCoords[14]);
			CarInfo[idx][mod3] = strval(arrCoords[15]);
			CarInfo[idx][mod4] = strval(arrCoords[16]);
			CarInfo[idx][mod5] = strval(arrCoords[17]);
			CarInfo[idx][mod6] = strval(arrCoords[18]);
			CarInfo[idx][mod7] = strval(arrCoords[19]);
			CarInfo[idx][mod8] = strval(arrCoords[20]);
			CarInfo[idx][mod9] = strval(arrCoords[21]);
			CarInfo[idx][mod10] = strval(arrCoords[22]);
			CarInfo[idx][mod11] = strval(arrCoords[23]);
			CarInfo[idx][mod12] = strval(arrCoords[24]);
			CarInfo[idx][mod13] = strval(arrCoords[25]);
			CarInfo[idx][mod14] = strval(arrCoords[26]);
			CarInfo[idx][mod15] = strval(arrCoords[27]);
			CarInfo[idx][mod16] = strval(arrCoords[28]);
			CarInfo[idx][mod17] = strval(arrCoords[29]);
			CarInfo[idx][paintjob] = strval(arrCoords[30]);
			printf("CarInfo: %d Owner:%s LicensePlate %s",idx,CarInfo[idx][cOwner],CarInfo[idx][cLicense]);
			idx++;
		}
	}
	return 1;
}

public SaveCarCoords()
{
	new idx;
	new File: file2;
	while (idx < sizeof(CarInfo))
	{
	    new coordsstring[256];
	    format(coordsstring, sizeof(coordsstring), "%d|%f|%f|%f|%f|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d\n",
		CarInfo[idx][cModel],
		CarInfo[idx][cLocationx],
		CarInfo[idx][cLocationy],
		CarInfo[idx][cLocationz],
		CarInfo[idx][cAngle],
		CarInfo[idx][cColorOne],
		CarInfo[idx][cColorTwo],
		CarInfo[idx][mod1],
		CarInfo[idx][mod2],
		CarInfo[idx][mod3],
		CarInfo[idx][mod4],
		CarInfo[idx][mod5],
		CarInfo[idx][mod6],
		CarInfo[idx][mod7],
		CarInfo[idx][mod8],
		CarInfo[idx][mod9],
		CarInfo[idx][mod10],
		CarInfo[idx][mod11],
		CarInfo[idx][mod12],
		CarInfo[idx][mod13],
		CarInfo[idx][mod14],
		CarInfo[idx][mod15],
		CarInfo[idx][mod16],
		CarInfo[idx][mod17],
		CarInfo[idx][paintjob]);
		if(idx == carsonserver)
		{
			file2 = fopen("masini.cfg", io_write);
		}
		else
		{
			file2 = fopen("masini.cfg", io_append);
		}
		fwrite(file2, coordsstring);
		idx++;
		fclose(file2);
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new string[128];
	new vehicle = GetPlayerVehicleID(playerid);
	new newcar = GetPlayerVehicleID(playerid);
	if(newstate == PLAYER_STATE_DRIVER)
	{
		if(IsAnOwnableCar(newcar))
		{
		    if(CarInfo[newcar][cOwned]==0)
		    {
		        TogglePlayerControllable(playerid, 0);
		        format(string,sizeof(string),"%s Price: %d /v buy to buy this vehicle",CarInfo[newcar][cDescription],CarInfo[newcar][cValue]);
		        SendClientMessage(playerid, COLOR_BLUE, string);
		        SendClientMessage(playerid, COLOR_BLUE, "or press Enter to exit this vehicle");
		    }
		    if(CarInfo[newcar][cOwned]==1)
		    {
		        format(string,sizeof(string),"Vehicle registered to %s",CarInfo[newcar][cOwner]);
				SendClientMessage(playerid, COLOR_BLUE, string);
				if(PlayerInfo[playerid][pPcarkey] == vehicle) { }
				else if(PlayerInfo[playerid][pPcarkey2] == vehicle) { }
				else if(PlayerInfo[playerid][pPcarkey3] == vehicle) { }
				else
				{
					if(IsPlayerAdmin(playerid))
					{
					    SendClientMessage(playerid, COLOR_GREY, "  You can drive this car because you are admin");
					}
                    else
				    {
				    	RemovePlayerFromVehicle(playerid);
				    	SendClientMessage(playerid, COLOR_GREY, "You don't have a key of this vehicle");
					}
				}
		    }
		}
	}
	return 1;
}

stock ini_GetKey( line[] )
{
	new keyRes[256];
	keyRes[0] = 0;
    if ( strfind( line , "=" , true ) == -1 ) return keyRes;
    strmid( keyRes , line , 0 , strfind( line , "=" , true ) , sizeof( keyRes) );
    return keyRes;
}

stock ini_GetValue( line[] )
{
	new valRes[256];
	valRes[0]=0;
	if ( strfind( line , "=" , true ) == -1 ) return valRes;
	strmid( valRes , line , strfind( line , "=" , true )+1 , strlen( line ) , sizeof( valRes ) );
	return valRes;
}
