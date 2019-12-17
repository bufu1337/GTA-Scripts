#include <a_samp>
#include <float>

/*
                                   ~~~ Version 1.4 ~~~
Hint: If you want to use the /resetcars function, which resets the demonstration cars' position,
      you have to implement the public function IsAdmin(playerid) in your gamemode.
      It has to return 1 if the player is an admin or 0 if not.
Copyright 2009 by ping (Marcel Kinzel)
Credits to Tratulla for his 2 .ini Functions.
Special Thanks to the Wiki info by Ignas1337 for the Tuning extension
and the SA-MP's strtok() function.
*/

// comment out if you do not want to use the /resetcars function
#define RESETCARS

// comment out if you do not want to use the /pcarsell function
#define CARSELL

#if defined CARSELL
#include <utils>
#endif

#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD6 0xF0F0F0FF
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_LIGHTGREEN 0x9ACD32AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_YELLOW2 0xF5DEB3AA
#define COLOR_WHITE 0xFFFFFFAA

forward SetVehicleParamsForAll(carid,objective,doorslocked);
forward CreateTunedCar(playerid);
forward DelayDestroyCar(playerid);
forward DelaySetVehicleParams(playerid);
forward ResetAutohausSpawns();

enum ahCar
{
	Typ,
	Float:X,
	Float:Y,
	Float:Z,
	Float:Rotation,
	Status,
	Lock,
	Carid,
	Paintjob,
	Color1,
	Color2,
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
};
new Carlist[MAX_PLAYERS][ahCar];

enum ahSpawn
{
	Float:X,
	Float:Y,
	Float:Z,
	Float:Rotation,
};
new Carspawns[2][ahSpawn] = {
	{739.7457,-1343.8668,13.2828,270.2592},
	{-1639.3599,1198.1665,6.9527,269.9673}
};

enum ahModel
{
	Name[128],
	Autohaus,
	Modelid,
	Carid,
	Price,
	Repair,
	Float:X,
	Float:Y,
	Float:Z,
	Float:Rotation,
};
new Buylist[34][ahModel] = {
	{"Stallion",0,439,-1,750000,5000,783.0,-1335.0,13.2,121.1},
	{"Feltzer",0,533,-1,500000,3000,783.0,-1340.0,13.2,121.1},
	{"Windsor",0,555,-1,450000,3400,783.0,-1345.0,13.2,121.1},
	{"Blade",0,536,-1,350000,3000,783.0,-1350.0,13.2,121.1},
	{"Remington",0,534,-1,500000,3000,783.0,-1355.0,13.2,121.1},
	{"Savanna",0,567,-1,350000,3000,783.0,-1360.0,13.2,121.1},
	{"Slamvan",0,535,-1,500000,3000,783.0,-1365.0,13.2,121.1},
	{"Voodoo",0,412,-1,500000,3000,783.0,-1370.0,13.2,121.1},
	{"Huntley",0,579,-1,200000,1000,783.0,-1375.0,13.2,121.1},
	{"Buccaneer",0,518,-1,120000,1000,783.0,-1380.0,13.2,121.1},
	{"Clover",0,542,-1,35000,500,765.0,-1360.0,13.4,301.1},
	{"Elegant",0,507,-1,40000,650,765.0,-1365.0,13.4,301.1},
	{"Elegy",0,562,-1,1500000,10000,765.0,-1370.0,13.4,301.1},
	{"Esperanto",0,419,-1,65000,650,765.0,-1375.0,13.4,301.1},
	{"Fortune",0,526,-1,35000,500,765.0,-1380.0,13.4,301.1},
	{"Sultan",0,560,-1,1500000,10000,766.0,-1333.0,13.3,211.1},
	{"Sunrise",0,550,-1,300000,2000,761.0,-1333.0,13.3,211.1},
	{"Vincent",0,540,-1,280000,2000,756.0,-1333.0,13.3,211.1},
	{"Alpha",0,602,-1,230000,2000,751.0,-1333.0,13.3,211.1},
	{"Banshee",0,429,-1,1000000,5500,746.0,-1333.0,13.3,211.1},
	{"Blista Compact",1,496,-1,350000,2500,-1668.6447,1207.0372,7.0249,309.5959},
	{"Buffalo",1,402,-1,500000,3000,-1663.6709,1215.2883,7.0234,274.9868},
	{"Bullet",1,541,-1,7500000,17500,-1651.3892,1210.3469,7.0208,281.3321},
	{"Cheetah",1,415,-1,4000000,10000,-1677.3560,1207.8099,13.4461,208.2602},
	{"Club",1,589,-1,70000,750,-1665.7789,1222.4406,13.4485,279.6459},
	{"Euros",1,587,-1,650000,7000,-1660.7256,1217.6407,13.4444,283.1553},
	{"Infernus",1,411,-1,1500000,7000,-1653.2462,1210.7842,13.4460,266.7211},
	{"Jester",1,559,-1,1500000,10000,-1676.0128,1207.1641,20.9248,261.5029},
	{"Phoenix",1,603,-1,600000,4000,-1664.4386,1206.8241,20.9289,332.5978},
	{"Super GT",1,506,-1,12500000,20000,-1651.6372,1208.2538,20.9231,305.1015},
	{"Turismo",1,451,-1,13000000,20000,-1665.1248,1222.7113,20.9265,267.4103},
	{"Uranus",1,558,-1,850000,10000,-1661.1943,1217.9629,20.9268,286.1662},
	{"ZR-350",1,477,-1,6500000,7000,-1654.3116,1214.8097,20.9267,173.5712},
	{"Faggio",0,462,-1,10000,500,750.7272,-1358.3872,13.0996,273.7736}
};

new Spectating[MAX_PLAYERS][1];

// begin of tuning component list
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

new lights[2][0] = {
	{1013},
	{1024}
};
// end of tuning component list

#if defined CARSELL
new offerCar[MAX_PLAYERS][2];
#endif

ini_GetKey( line[] )
{
	new keyRes[256];
	keyRes[0] = 0;
    if ( strfind( line , "=" , true ) == -1 ) return keyRes;
    strmid( keyRes , line , 0 , strfind( line , "=" , true ) , sizeof( keyRes) );
    return keyRes;
}

ini_GetValue( line[] )
{
	new valRes[256];
	valRes[0]=0;
	if ( strfind( line , "=" , true ) == -1 ) return valRes;
	strmid( valRes , line , strfind( line , "=" , true )+1 , strlen( line ) , sizeof( valRes ) );
	return valRes;
}

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

IsAutohausCar(carid)
{
	new i;
	for(i=0; i<sizeof(Buylist); i++)
	{
	    if(Buylist[i][Carid]==carid) { return i; }
	}
	return -1;
}

GetPlayerFromCarlistCar(carid)
{
	new i;
	for(i=0; i<sizeof(Carlist); i++)
	{
	    if(Carlist[i][Carid]==carid) { return i; }
	}
	return -1;
}

GetModType(componentid)
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
	    if(lights[i][0]==componentid) { return 17; }
	}
	return 0;
}

public OnFilterScriptInit()
{
	print("----------------------------------");
	print(" ~*~ Mobile Cardealership 1.4 ~*~");
	print(" ~*~     (c) 2009 by ping     ~*~");
	print("----------------------------------\n");
	
	new i;
	for(i=0; i<sizeof(Buylist); i++)
	{
		Buylist[i][Carid]=CreateVehicle(Buylist[i][Modelid],Buylist[i][X],Buylist[i][Y],Buylist[i][Z],Buylist[i][Rotation],-1,-1,-1);
	}
	for(i=0; i<MAX_PLAYERS; i++)
	{
		Spectating[i][0]=-1;
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	new dateiname[MAX_PLAYER_NAME+4];
	new playername[MAX_PLAYER_NAME];
	Carlist[playerid][Typ]=-1; Carlist[playerid][X]=0.0; Carlist[playerid][Y]=0.0; Carlist[playerid][Z]=0.0;
	Carlist[playerid][Rotation]=0.0; Carlist[playerid][Status]=0; Carlist[playerid][Lock]=0; Carlist[playerid][Carid]=-1;
	Carlist[playerid][Color1]=-1; Carlist[playerid][Color2]=-1; Carlist[playerid][mod1]=-1; Carlist[playerid][mod2]=-1;
	Carlist[playerid][mod3]=-1; Carlist[playerid][mod4]=-1; Carlist[playerid][mod5]=-1; Carlist[playerid][mod6]=-1;
	Carlist[playerid][mod7]=-1; Carlist[playerid][mod8]=-1; Carlist[playerid][mod9]=-1; Carlist[playerid][mod10]=-1;
	Carlist[playerid][mod11]=-1; Carlist[playerid][mod12]=-1; Carlist[playerid][mod13]=-1; Carlist[playerid][mod14]=-1;
	Carlist[playerid][mod15]=-1; Carlist[playerid][mod16]=-1; Carlist[playerid][mod17]=-1; Carlist[playerid][Paintjob]=-1;
	Spectating[playerid][0]=-1;
	#if defined CARSELL
	offerCar[playerid]={-1,0};
	#endif
    GetPlayerName(playerid, playername, sizeof(playername));
	format(dateiname, sizeof(dateiname), "%s.car", playername);
	if (fexist(dateiname))
	{
		new File: CarFile = fopen(dateiname, io_read);
		if ( CarFile )
		{
		    new key[ 256 ];
		    new Data[ 256 ];
		    while ( fread( CarFile , Data , sizeof( Data ) ) )
			{
				key = ini_GetKey(Data);
				if(strcmp(key,"AH_Typ",true)==0) { Carlist[playerid][Typ]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_X",true)==0) { Carlist[playerid][X]=floatstr(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_Y",true)==0) { Carlist[playerid][Y]=floatstr(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_Z",true)==0) { Carlist[playerid][Z]=floatstr(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_Rot",true)==0) { Carlist[playerid][Rotation]=floatstr(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_Status",true)==0) { Carlist[playerid][Status]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_Lock",true)==0) { Carlist[playerid][Lock]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_Paintjob",true)==0) { Carlist[playerid][Paintjob]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_Color1",true)==0) { Carlist[playerid][Color1]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_Color2",true)==0) { Carlist[playerid][Color2]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_mod1",true)==0) { Carlist[playerid][mod1]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_mod2",true)==0) { Carlist[playerid][mod2]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_mod3",true)==0) { Carlist[playerid][mod3]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_mod4",true)==0) { Carlist[playerid][mod4]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_mod5",true)==0) { Carlist[playerid][mod5]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_mod6",true)==0) { Carlist[playerid][mod6]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_mod7",true)==0) { Carlist[playerid][mod7]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_mod8",true)==0) { Carlist[playerid][mod8]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_mod9",true)==0) { Carlist[playerid][mod9]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_mod10",true)==0) { Carlist[playerid][mod10]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_mod11",true)==0) { Carlist[playerid][mod11]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_mod12",true)==0) { Carlist[playerid][mod12]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_mod13",true)==0) { Carlist[playerid][mod13]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_mod14",true)==0) { Carlist[playerid][mod14]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_mod15",true)==0) { Carlist[playerid][mod15]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_mod16",true)==0) { Carlist[playerid][mod16]=strval(ini_GetValue(Data)); }
			    else if(strcmp(key,"AH_mod17",true)==0) { Carlist[playerid][mod17]=strval(ini_GetValue(Data)); }
			}
		}
	    fclose(CarFile);
	    if(Carlist[playerid][Typ]!=-1 && Carlist[playerid][Status]==1)
	    {
	        Carlist[playerid][Carid]=CreateTunedCar(playerid);
		}
	}
	SetTimerEx("DelaySetVehicleParams",10000,0,"i",playerid);
	return 1;
}

public OnPlayerDisconnect(playerid)
{
	new dateiname[MAX_PLAYER_NAME+4];
	new playername[MAX_PLAYER_NAME];
	new var[256];
    GetPlayerName(playerid, playername, sizeof(playername));
	format(dateiname, sizeof(dateiname), "%s.car", playername);
	new File: CarFile = fopen(dateiname, io_write);
    format(var, 256, "AH_Typ=%i\n", Carlist[playerid][Typ]); fwrite(CarFile, var);
    format(var, 256, "AH_X=%f\n", Carlist[playerid][X]); fwrite(CarFile, var);
	format(var, 256, "AH_Y=%f\n", Carlist[playerid][Y]); fwrite(CarFile, var);
	format(var, 256, "AH_Z=%f\n", Carlist[playerid][Z]); fwrite(CarFile, var);
	format(var, 256, "AH_Rot=%f\n", Carlist[playerid][Rotation]); fwrite(CarFile, var);
	format(var, 256, "AH_Status=%i\n", Carlist[playerid][Status]); fwrite(CarFile, var);
	format(var, 256, "AH_Lock=%i\n", Carlist[playerid][Lock]); fwrite(CarFile, var);
	format(var, 256, "AH_Paintjob=%i\n", Carlist[playerid][Paintjob]); fwrite(CarFile, var);
	format(var, 256, "AH_Color1=%i\n", Carlist[playerid][Color1]); fwrite(CarFile, var);
	format(var, 256, "AH_Color2=%i\n", Carlist[playerid][Color2]); fwrite(CarFile, var);
	format(var, 256, "AH_mod1=%i\n", Carlist[playerid][mod1]); fwrite(CarFile, var);
	format(var, 256, "AH_mod2=%i\n", Carlist[playerid][mod2]); fwrite(CarFile, var);
	format(var, 256, "AH_mod3=%i\n", Carlist[playerid][mod3]); fwrite(CarFile, var);
	format(var, 256, "AH_mod4=%i\n", Carlist[playerid][mod4]); fwrite(CarFile, var);
	format(var, 256, "AH_mod5=%i\n", Carlist[playerid][mod5]); fwrite(CarFile, var);
	format(var, 256, "AH_mod6=%i\n", Carlist[playerid][mod6]); fwrite(CarFile, var);
	format(var, 256, "AH_mod7=%i\n", Carlist[playerid][mod7]); fwrite(CarFile, var);
	format(var, 256, "AH_mod8=%i\n", Carlist[playerid][mod8]); fwrite(CarFile, var);
	format(var, 256, "AH_mod9=%i\n", Carlist[playerid][mod9]); fwrite(CarFile, var);
	format(var, 256, "AH_mod10=%i\n", Carlist[playerid][mod10]); fwrite(CarFile, var);
	format(var, 256, "AH_mod11=%i\n", Carlist[playerid][mod11]); fwrite(CarFile, var);
	format(var, 256, "AH_mod12=%i\n", Carlist[playerid][mod12]); fwrite(CarFile, var);
	format(var, 256, "AH_mod13=%i\n", Carlist[playerid][mod13]); fwrite(CarFile, var);
	format(var, 256, "AH_mod14=%i\n", Carlist[playerid][mod14]); fwrite(CarFile, var);
	format(var, 256, "AH_mod15=%i\n", Carlist[playerid][mod15]); fwrite(CarFile, var);
	format(var, 256, "AH_mod16=%i\n", Carlist[playerid][mod16]); fwrite(CarFile, var);
	format(var, 256, "AH_mod17=%i\n", Carlist[playerid][mod17]); fwrite(CarFile, var);
    fclose(CarFile);
    if(Carlist[playerid][Carid]!=-1)
	{
		SetVehicleParamsForAll(Carlist[playerid][Carid],0,0);
		DestroyVehicle(Carlist[playerid][Carid]);
		Carlist[playerid][Carid]=-1;
	}
    if (Spectating[playerid][0]!=-1)
    {
        SetVehicleParamsForAll(Buylist[Spectating[playerid][0]][Carid],0,0);
        Spectating[playerid][0]=-1;
	}
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	new i;
	for(i=0; i<MAX_PLAYERS; i++)
	{
 		if(Carlist[i][Carid]==vehicleid)
 		{
		 	SetTimerEx("DelayDestroyCar",3000,0,"i",i);
			return 1;
 		}
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[128], idx, string[128];
	#if defined CARSELL
	new tmp[128];
	#endif
	cmd = strtok(cmdtext, idx);

	if (strcmp("/carhelp", cmd, true, 10) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
			SendClientMessage(playerid, COLOR_WHITE,"*** CAR HELP *** type the command for more help");
			SendClientMessage(playerid, COLOR_GRAD3,"*** CAR *** /park /fixcar /carlock /respraycar");
			SendClientMessage(playerid, COLOR_GRAD3,"*** CAR *** /repaintcar /buycar /carsell /exitcar");
			#if defined CARSELL
			SendClientMessage(playerid, COLOR_GRAD3,"*** CAR *** /pcarsell /cancelsell /acceptsell");
			#endif
		}
		return 1;
	}
	else if (strcmp("/park", cmd, true, 10) == 0)
	{
		if (IsPlayerInVehicle(playerid,Carlist[playerid][Carid]))
		{
		    GetVehiclePos(Carlist[playerid][Carid],Carlist[playerid][X],Carlist[playerid][Y],Carlist[playerid][Z]);
		    GetVehicleZAngle(Carlist[playerid][Carid],Carlist[playerid][Rotation]);
		    SendClientMessage(playerid, COLOR_GREEN, "Saved car position!");
		}
		else { SendClientMessage(playerid, COLOR_GREY, "That is not your car!"); }
		return 1;
	}
	else if (strcmp("/fixcar", cmd, true, 10) == 0)
	{
	    if (Carlist[playerid][Typ]!=-1)
	    {
			if (Carlist[playerid][Status]==0)
			{
			    new reparatur = Buylist[Carlist[playerid][Typ]][Repair];
				if (reparatur <= GetPlayerMoney(playerid))
				{
				    Carlist[playerid][Status]=1;
				    Carlist[playerid][Carid]=CreateTunedCar(playerid);
					GivePlayerMoney(playerid, - reparatur);
					format(string, 128, "You repaired your car for $%i! It is ready where you parked it.", reparatur);
					SendClientMessage(playerid, COLOR_RED, string);
				}
				else { format(string, 128, "Insufficent money for the repair (need: $%i)!", reparatur); SendClientMessage(playerid, COLOR_LIGHTRED, string); }
			}
	        else { SendClientMessage(playerid, COLOR_GREY, "Your car does not need a repair!"); }
		}
		else { SendClientMessage(playerid, COLOR_GREY, "You do not have a car!"); }
		return 1;
	}
	else if (strcmp("/carlock", cmd, true, 10) == 0)
	{
	    if (Carlist[playerid][Typ]!=-1)
	    {
			if (Carlist[playerid][Carid]!=-1)
			{
				if (Carlist[playerid][Lock]==0)
				{
				    Carlist[playerid][Lock]=1;
				    SetVehicleParamsForAll(Carlist[playerid][Carid],0,1);
				    SetVehicleParamsForPlayer(Carlist[playerid][Carid],playerid,0,0);
					SendClientMessage(playerid, COLOR_RED, "You locked your car for other players!");
				}
				else
				{
				    Carlist[playerid][Lock]=0;
				    SetVehicleParamsForAll(Carlist[playerid][Carid],0,0);
				    SendClientMessage(playerid, COLOR_RED, "You unlocked your car for other players!");
				}
			}
			else { SendClientMessage(playerid, COLOR_GREY, "Your car is broken. You have to repair it!"); }
		}
		else { SendClientMessage(playerid, COLOR_GREY, "You do not have a car!"); }
	    return 1;
	}
	else if (strcmp("/respraycar", cmd, true, 10) == 0)
	{
	    if (Carlist[playerid][Typ]!=-1)
	    {
			if (Carlist[playerid][Carid]!=-1)
			{
			    ChangeVehicleColor(Carlist[playerid][Carid],Carlist[playerid][Color1],Carlist[playerid][Color2]);
			    SendClientMessage(playerid, COLOR_RED, "You resprayed your car!");
   			}
			else { SendClientMessage(playerid, COLOR_GREY, "Your car is broken. You have to repair it!"); }
		}
		else { SendClientMessage(playerid, COLOR_GREY, "You do not have a car!"); }
	    return 1;
	}
	else if (strcmp("/repaintcar", cmd, true, 10) == 0)
	{
	    if (Carlist[playerid][Typ]!=-1)
	    {
			if (Carlist[playerid][Carid]!=-1)
			{
			    if (Carlist[playerid][Paintjob]!=-1)
			    {
			    	ChangeVehiclePaintjob(Carlist[playerid][Carid],Carlist[playerid][Paintjob]);
        			SendClientMessage(playerid, COLOR_RED, "You repainted your car!");
				}
				else { SendClientMessage(playerid, COLOR_GREY, "Your car does not have a paintjob yet!"); }
   			}
			else { SendClientMessage(playerid, COLOR_GREY, "Your car is broken. You have to repair it!"); }
		}
		else { SendClientMessage(playerid, COLOR_GREY, "You do not have a car!"); }
	    return 1;
	}
	else if (strcmp("/exitcar", cmd, true, 10) == 0)
	{
	    if (Spectating[playerid][0]!=-1)
	    {
	        TogglePlayerControllable(playerid,1);
	        SetVehicleParamsForAll(Buylist[Spectating[playerid][0]][Carid],0,0);
	        Spectating[playerid][0]=-1;
	        RemovePlayerFromVehicle(playerid);
		}
		else { SendClientMessage(playerid, COLOR_GREY, "You are not visiting a demonstration car!"); }
	    return 1;
	}
	else if (strcmp("/buycar", cmd, true, 10) == 0)
	{
	    if (Spectating[playerid][0]!=-1)
	    {
	        if (Carlist[playerid][Typ]==-1)
	        {
	            new price = Buylist[Spectating[playerid][0]][Price];
	            if (price <= GetPlayerMoney(playerid))
	            {
	                new autohaus=Buylist[Spectating[playerid][0]][Autohaus];
   	        		GivePlayerMoney(playerid, - price);
   	        		Carlist[playerid][Typ]=Spectating[playerid][0]; Carlist[playerid][X]=Carspawns[autohaus][X]; Carlist[playerid][Y]=Carspawns[autohaus][Y];
					Carlist[playerid][Z]=Carspawns[autohaus][Z]; Carlist[playerid][Rotation]=Carspawns[autohaus][Rotation]; Carlist[playerid][Status]=1; Carlist[playerid][Lock]=0;
					Carlist[playerid][Carid]=CreateVehicle(Buylist[Spectating[playerid][0]][Modelid],Carlist[playerid][X],Carlist[playerid][Y],Carlist[playerid][Z],Carlist[playerid][Rotation],-1,-1,-1);
			        SetVehicleParamsForAll(Buylist[Spectating[playerid][0]][Carid],0,0);
			        TogglePlayerControllable(playerid,1);
			        Spectating[playerid][0]=-1;
			        RemovePlayerFromVehicle(playerid);
					format(string,128,"Congratulations! You bought yourself a/an $%s for %i!",Buylist[Carlist[playerid][Typ]][Name],price);
					SendClientMessage(playerid, COLOR_RED, string);
					SendClientMessage(playerid, COLOR_GREEN, "If your car is broken, type /fixcar to fix it.");
					SendClientMessage(playerid, COLOR_GREEN, "You can lock/unlock your car for other players with /lock.");
					SendClientMessage(playerid, COLOR_GREEN, "Look for more commands with /carhelp.");
                    SendClientMessage(playerid, COLOR_YELLOW, "Your car is ready at the release point. Have fun!");
				}
                else { format(string, 128, "Insufficent money to buy the car (need: $%i)!", price); SendClientMessage(playerid, COLOR_LIGHTRED, string); }
			}
			else { SendClientMessage(playerid, COLOR_GREY, "You already have a car!"); }
	    }
	    else { SendClientMessage(playerid, COLOR_GREY, "You are not visiting a demonstration car!"); }
	    return 1;
	}
	else if (strcmp("/carsell", cmd, true, 10) == 0)
	{
	    if (Carlist[playerid][Typ]!=-1)
	    {
	        new price = (Buylist[Carlist[playerid][Typ]][Price]/5)*4;
	        if (IsPlayerInVehicle(playerid,Carlist[playerid][Carid])) { RemovePlayerFromVehicle(playerid); }
	        GivePlayerMoney(playerid, price);
	        DestroyVehicle(Carlist[playerid][Carid]);
			Carlist[playerid][Typ]=-1; Carlist[playerid][X]=0.0; Carlist[playerid][Y]=0.0; Carlist[playerid][Z]=0.0;
			Carlist[playerid][Rotation]=0.0; Carlist[playerid][Status]=0; Carlist[playerid][Lock]=0; Carlist[playerid][Carid]=-1;
			Carlist[playerid][Color1]=-1; Carlist[playerid][Color2]=-1; Carlist[playerid][mod1]=-1; Carlist[playerid][mod2]=-1;
			Carlist[playerid][mod3]=-1; Carlist[playerid][mod4]=-1; Carlist[playerid][mod5]=-1; Carlist[playerid][mod6]=-1;
			Carlist[playerid][mod7]=-1; Carlist[playerid][mod8]=-1; Carlist[playerid][mod9]=-1; Carlist[playerid][mod10]=-1;
			Carlist[playerid][mod11]=-1; Carlist[playerid][mod12]=-1; Carlist[playerid][mod13]=-1; Carlist[playerid][mod14]=-1;
			Carlist[playerid][mod15]=-1; Carlist[playerid][mod16]=-1; Carlist[playerid][mod17]=-1; Carlist[playerid][Paintjob]=-1;
			format(string,128,"You sold successfully your car for $%i!",price);
			SendClientMessage(playerid, COLOR_RED, string);
	    }
	    else { SendClientMessage(playerid, COLOR_GREY, "You do not have a car!"); }
	    return 1;
	}
	#if defined RESETCARS
	else if (strcmp("/resetcars", cmd, true, 10) == 0)
	{
		if(CallRemoteFunction("IsAdmin","i",playerid)) { ResetAutohausSpawns(); }
	    return 1;
	}
	#endif
	#if defined CARSELL
	else if (strcmp("/pcarsell", cmd, true, 10) == 0)
	{
        tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
		    SendClientMessage(playerid, COLOR_GREY, "Usage: /pcarsell [playerid] [price]");
            return 1;
        }
        new sellplayerid = ReturnUser(tmp);
        tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
		    SendClientMessage(playerid, COLOR_GREY, "Usage: /pcarsell [playerid] [price]");
            return 1;
        }
        new price = strval(tmp);
        if (price<0)
        {
		    SendClientMessage(playerid, COLOR_GREY, "The price has to be bigger than $0.");
            return 1;
        }
	    if (Carlist[playerid][Typ]==-1)
	    {
	        SendClientMessage(playerid, COLOR_GREY, "You do not have a car!");
	        return 1;
	    }
        if (!IsPlayerConnected(sellplayerid))
        {
		    SendClientMessage(playerid, COLOR_GREY, "This player is offline.");
            return 1;
        }
        offerCar[sellplayerid][0]=playerid;
		offerCar[sellplayerid][1]=price;
		new playername[MAX_PLAYER_NAME];
		new sellplayername[MAX_PLAYER_NAME];
		GetPlayerName(playerid,playername,sizeof(playername));
		GetPlayerName(sellplayerid,sellplayername,sizeof(sellplayername));
		format(string,128,"You are offering %s your car for $%i!",sellplayername,price);
		SendClientMessage(playerid, COLOR_RED, string);
		SendClientMessage(playerid, COLOR_YELLOW, "Cancel the deal with /cancelsell.");
        format(string,128,"%s offers his %s for $%i.",playername,Buylist[Carlist[playerid][Typ]][Name],price);
        SendClientMessage(sellplayerid, COLOR_RED, string);
        SendClientMessage(sellplayerid, COLOR_YELLOW, "Accept the deal with /acceptsell.");
	    return 1;
	}
	else if (strcmp("/cancelsell", cmd, true, 10) == 0)
	{
	    for (new i=0; i<MAX_PLAYERS; i++)
	    {
	        if (offerCar[i][0]==playerid)
	        {
	            offerCar[i]={-1,0};
	            SendClientMessage(playerid, COLOR_RED, "You cancelled the deal.");
	            if (IsPlayerConnected(i))
	            {
					new playername[MAX_PLAYER_NAME];
					GetPlayerName(playerid,playername,sizeof(playername));
	                format(string,128,"%s cancelled the deal.",playername);
                    SendClientMessage(i, COLOR_GREEN, string);
	            }
	            return 1;
	        }
	    }
	    SendClientMessage(playerid, COLOR_GREY, "You are not offering your car!");
	    return 1;
	}
	else if (strcmp("/acceptsell", cmd, true, 10) == 0)
	{
	    if (offerCar[playerid][0]!=-1)
	    {
	        if (IsPlayerConnected(offerCar[playerid][0]))
	        {
	            if (Carlist[playerid][Typ]==-1)
	            {
	                if (Carlist[offerCar[playerid][0]][Typ]!=-1)
	                {
	                    if (GetPlayerMoney(playerid)>=offerCar[playerid][1])
	                    {
	                        new sellerid=offerCar[playerid][0];
	                        new price=offerCar[playerid][1];
	                        offerCar[playerid]={-1,0};
           	        		GivePlayerMoney(playerid, - price);
           	        		GivePlayerMoney(sellerid, price);
           	        		Carlist[playerid][Typ]=Carlist[sellerid][Typ];
           	        		Carlist[playerid][X]=Carlist[sellerid][X];
           	        		Carlist[playerid][Y]=Carlist[sellerid][Y];
					        Carlist[playerid][Z]=Carlist[sellerid][Z];
					        Carlist[playerid][Rotation]=Carlist[sellerid][Rotation];
					        Carlist[playerid][Status]=Carlist[sellerid][Status];
					        Carlist[playerid][Lock]=Carlist[sellerid][Lock];
					        Carlist[playerid][Carid]=Carlist[sellerid][Carid];
			                Carlist[playerid][Color1]=Carlist[sellerid][Color1];
			                Carlist[playerid][Color2]=Carlist[sellerid][Color2];
			                Carlist[playerid][mod1]=Carlist[sellerid][mod1];
			                Carlist[playerid][mod2]=Carlist[sellerid][mod2];
			                Carlist[playerid][mod3]=Carlist[sellerid][mod3];
			                Carlist[playerid][mod4]=Carlist[sellerid][mod4];
			                Carlist[playerid][mod5]=Carlist[sellerid][mod5];
			                Carlist[playerid][mod6]=Carlist[sellerid][mod6];
			                Carlist[playerid][mod7]=Carlist[sellerid][mod7];
			                Carlist[playerid][mod8]=Carlist[sellerid][mod8];
			                Carlist[playerid][mod9]=Carlist[sellerid][mod9];
			                Carlist[playerid][mod10]=Carlist[sellerid][mod10];
			                Carlist[playerid][mod11]=Carlist[sellerid][mod11];
			                Carlist[playerid][mod12]=Carlist[sellerid][mod12];
			                Carlist[playerid][mod13]=Carlist[sellerid][mod13];
			                Carlist[playerid][mod14]=Carlist[sellerid][mod14];
			                Carlist[playerid][mod15]=Carlist[sellerid][mod15];
			                Carlist[playerid][mod16]=Carlist[sellerid][mod16];
			                Carlist[playerid][mod17]=Carlist[sellerid][mod17];
			                Carlist[playerid][Paintjob]=Carlist[sellerid][Paintjob];
			                Carlist[sellerid][Typ]=-1; Carlist[sellerid][X]=0.0; Carlist[sellerid][Y]=0.0; Carlist[sellerid][Z]=0.0;
			                Carlist[sellerid][Rotation]=0.0; Carlist[sellerid][Status]=0; Carlist[sellerid][Lock]=0; Carlist[sellerid][Carid]=-1;
			                Carlist[sellerid][Color1]=-1; Carlist[sellerid][Color2]=-1; Carlist[sellerid][mod1]=-1; Carlist[sellerid][mod2]=-1;
			                Carlist[sellerid][mod3]=-1; Carlist[sellerid][mod4]=-1; Carlist[sellerid][mod5]=-1; Carlist[sellerid][mod6]=-1;
			                Carlist[sellerid][mod7]=-1; Carlist[sellerid][mod8]=-1; Carlist[sellerid][mod9]=-1; Carlist[sellerid][mod10]=-1;
			                Carlist[sellerid][mod11]=-1; Carlist[sellerid][mod12]=-1; Carlist[sellerid][mod13]=-1; Carlist[sellerid][mod14]=-1;
			                Carlist[sellerid][mod15]=-1; Carlist[sellerid][mod16]=-1; Carlist[sellerid][mod17]=-1; Carlist[sellerid][Paintjob]=-1;
					        if (Carlist[playerid][Status]==1)
					        {
			                    SetVehicleParamsForAll(Carlist[playerid][Carid],0,Carlist[playerid][Lock]);
			                    SetVehicleParamsForPlayer(Carlist[playerid][Carid],playerid,0,0);
			                }
                            format(string,128,"Congratulations! You bought yourself a/an $%s for %i!",Buylist[Carlist[playerid][Typ]][Name],price);
							SendClientMessage(playerid, COLOR_RED, string);
							SendClientMessage(playerid, COLOR_GREEN, "If your car is broken, type /fixcar to fix it.");
							SendClientMessage(playerid, COLOR_GREEN, "You can lock/unlock your car for other players with /lock.");
							SendClientMessage(playerid, COLOR_GREEN, "Look for more commands with /carhelp.");
							SendClientMessage(playerid, COLOR_YELLOW, "The car is now yours. Have fun with it!");
		 					new playername[MAX_PLAYER_NAME];
							GetPlayerName(playerid,playername,sizeof(playername));
			                format(string,128,"You sold %s your car for $%i!",playername, price);
			                SendClientMessage(sellerid, COLOR_RED, string);
	                    }
	                    else
	                    {
	                        format(string, 128, "Insufficent money to buy the car (need: $%i)!", offerCar[playerid][1]);
	                        SendClientMessage(playerid, COLOR_GREY, string);
	                    }
                    }
                    else
                    {
                        offerCar[playerid]={-1,0};
                        SendClientMessage(playerid, COLOR_GREY, "The seller does not have a car!.");
                    }
	            }
	            else
	            {
			        SendClientMessage(playerid, COLOR_GREY, "You already have a car!");
	            }
			}
            else
            {
                offerCar[playerid]={-1,0};
                SendClientMessage(playerid, COLOR_GREY, "The seller is offline.");
            }
	    }
	    else
	    {
	        SendClientMessage(playerid, COLOR_GREY, "There is no car on offer.");
	    }
	    return 1;
	}
	#endif
	return 0;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
		new typ;
		typ=IsAutohausCar(vehicleid);
		if(typ!=-1)
		{
		    new string[128];
		    TogglePlayerControllable(playerid,0);
		    Spectating[playerid][0]=typ;
		    SetVehicleParamsForAll(vehicleid,0,1);
			SendClientMessage(playerid, COLOR_YELLOW, "~*~ Car Dealership ~*~");
			format(string,128,"Name: %s",Buylist[typ][Name]);
			SendClientMessage(playerid, COLOR_YELLOW, string);
			format(string,128,"Price: $%i",Buylist[typ][Price]);
			SendClientMessage(playerid, COLOR_YELLOW, string);
			format(string,128,"Cost of repair: $%i",Buylist[typ][Repair]);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		    SendClientMessage(playerid, COLOR_GREEN, "This car is for sell. To buy it, type: /buycar");
		    SendClientMessage(playerid, COLOR_GREEN, "If you want to leave the car, type: /exitcar");
		}
	}
	return 1;
}

public OnVehicleMod(playerid,vehicleid,componentid)
{
	if (playerid!=GetPlayerFromCarlistCar(vehicleid)) {return 1;}
	if(playerid!=-1)
	{
		new mod=GetModType(componentid);
		switch (mod)
		{
		    case 1: { Carlist[playerid][mod1]=componentid; }
		    case 2: { Carlist[playerid][mod2]=componentid; }
		    case 3: { Carlist[playerid][mod3]=componentid; }
		    case 4: { Carlist[playerid][mod4]=componentid; }
		    case 5: { Carlist[playerid][mod5]=componentid; }
		    case 6: { Carlist[playerid][mod6]=componentid; }
		    case 7: { Carlist[playerid][mod7]=componentid; }
		    case 8: { Carlist[playerid][mod8]=componentid; }
		    case 9: { Carlist[playerid][mod9]=componentid; }
		    case 10: { Carlist[playerid][mod10]=componentid; }
		    case 11: { Carlist[playerid][mod11]=componentid; }
		    case 12: { Carlist[playerid][mod12]=componentid; }
		    case 13: { Carlist[playerid][mod13]=componentid; }
		    case 14: { Carlist[playerid][mod14]=componentid; }
		    case 15: { Carlist[playerid][mod15]=componentid; }
		    case 16: { Carlist[playerid][mod16]=componentid; }
		    case 17: { Carlist[playerid][mod17]=componentid; }
		    default: { new string[128]; format(string,128,"Unknown component id: %i",componentid); print(string); }
		}
	}
	return 1;
}

public OnVehiclePaintjob(playerid,vehicleid, paintjobid)
{
	if (playerid!=GetPlayerFromCarlistCar(vehicleid)) {return 1;}
	if(playerid!=-1)
	{
	    Carlist[playerid][Paintjob]=paintjobid;
	}
	return 1;
}

public OnVehicleRespray(playerid,vehicleid, color1, color2)
{
	if (playerid!=GetPlayerFromCarlistCar(vehicleid)) {return 1;}
	if(playerid!=-1)
	{
	    Carlist[playerid][Color1]=color1;
	    Carlist[playerid][Color2]=color2;
	}
	return 1;
}

public SetVehicleParamsForAll(carid,objective,doorslocked)
{
	new i;
	for(i=0; i<MAX_PLAYERS; i++) { SetVehicleParamsForPlayer(carid,i,objective,doorslocked); }
}

public CreateTunedCar(playerid)
{
	if(IsPlayerConnected(playerid) && Carlist[playerid][Typ]!=-1)
	{
	    new carid=CreateVehicle(Buylist[Carlist[playerid][Typ]][Modelid],Carlist[playerid][X],Carlist[playerid][Y],Carlist[playerid][Z],Carlist[playerid][Rotation],-1,-1,-1);
	    if(Carlist[playerid][Lock]==1)
	    {
	        SetVehicleParamsForAll(carid,0,1);
	        SetVehicleParamsForPlayer(carid,playerid,0,0);
		}
		if(Carlist[playerid][mod1]!=-1) { AddVehicleComponent(carid,Carlist[playerid][mod1]); }
		if(Carlist[playerid][mod2]!=-1) { AddVehicleComponent(carid,Carlist[playerid][mod2]); }
		if(Carlist[playerid][mod3]!=-1) { AddVehicleComponent(carid,Carlist[playerid][mod3]); }
		if(Carlist[playerid][mod4]!=-1) { AddVehicleComponent(carid,Carlist[playerid][mod4]); }
		if(Carlist[playerid][mod5]!=-1) { AddVehicleComponent(carid,Carlist[playerid][mod5]); }
		if(Carlist[playerid][mod6]!=-1) { AddVehicleComponent(carid,Carlist[playerid][mod6]); }
		if(Carlist[playerid][mod7]!=-1) { AddVehicleComponent(carid,Carlist[playerid][mod7]); }
		if(Carlist[playerid][mod8]!=-1) { AddVehicleComponent(carid,Carlist[playerid][mod8]); }
		if(Carlist[playerid][mod9]!=-1) { AddVehicleComponent(carid,Carlist[playerid][mod9]); }
		if(Carlist[playerid][mod10]!=-1) { AddVehicleComponent(carid,Carlist[playerid][mod10]); }
		if(Carlist[playerid][mod11]!=-1) { AddVehicleComponent(carid,Carlist[playerid][mod11]); }
		if(Carlist[playerid][mod12]!=-1) { AddVehicleComponent(carid,Carlist[playerid][mod12]); }
		if(Carlist[playerid][mod13]!=-1) { AddVehicleComponent(carid,Carlist[playerid][mod13]); }
		if(Carlist[playerid][mod14]!=-1) { AddVehicleComponent(carid,Carlist[playerid][mod14]); }
		if(Carlist[playerid][mod15]!=-1) { AddVehicleComponent(carid,Carlist[playerid][mod15]); }
		if(Carlist[playerid][mod16]!=-1) { AddVehicleComponent(carid,Carlist[playerid][mod16]); }
		if(Carlist[playerid][mod17]!=-1) { AddVehicleComponent(carid,Carlist[playerid][mod17]); }
		if(Carlist[playerid][Paintjob]!=-1) { ChangeVehiclePaintjob(carid,Carlist[playerid][Paintjob]); }
		if(Carlist[playerid][Color1]!=-1) { ChangeVehicleColor(carid,Carlist[playerid][Color1],Carlist[playerid][Color2]); }
	    return carid;
	}
	return -1;
}

public DelayDestroyCar(playerid)
{
	SetVehicleParamsForAll(Carlist[playerid][Carid],0,0);
	DestroyVehicle(Carlist[playerid][Carid]);
	Carlist[playerid][Status]=0;
	Carlist[playerid][Carid]=-1;
	return 1;
}

public DelaySetVehicleParams(playerid)
{
	if(!IsPlayerConnected(playerid)) { return 0; }
	new i;
	for(i=0; i<MAX_PLAYERS; i++)
	
	{
	    if(Carlist[i][Carid]!=-1 && Carlist[i][Lock]==1) { SetVehicleParamsForPlayer(Carlist[i][Carid],playerid,0,1); }
	    if(Spectating[i][0]!=-1) { SetVehicleParamsForPlayer(Buylist[Spectating[i][0]][Carid],playerid,0,1); }
	}
	return 1;
}

public ResetAutohausSpawns()
{
	new i;
	for(i=0; i<sizeof(Buylist); i++) { SetVehicleToRespawn(Buylist[i][Carid]); }
}
