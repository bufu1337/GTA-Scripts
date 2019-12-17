/*
					-----------------------------------------------------
					|///////////////////////////////////////////////////|
					|///////////////////////////////////////////////////|
					|////                                           ////|
					|////          tAxI's ADVANCED HOUSING          ////|
                    |////                  SYSTEM                   ////|
					|////                                           ////|
					|////     COPYRIGHT: RELEASED UNDER the GNU     ////|
					|////                 LICENCE                   ////|
					|////                                           ////|
					|///////////////////////////////////////////////////|
					|///////////////////////////////////////////////////|
                    -----------------------------------------------------


    tAxI's Advanced House system - INC Package for SA-MP Multiplayer Modification
    of Grand Theft Auto - San Andreas.

    Copyright (C) 2008  Chris Johnstone (tAxI/Necrioss)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <http://www.gnu.org/licenses/>.

	-=============================================================================================-
	|=============================================================================================|
	|-----------------------------------------DESCRIPTION-----------------------------------------|
	|=============================================================================================|
	|THIS SYSTEM WILL ADD A HOUSING SYSTEM SIMILAR TO THAT OF PEN1 ONTO ANY SA-MP SERVER. IT      |
	|FEATURES HOUSE VEHICLES WITH PERMANENT MODSAVING, PERMANENT BUYING AND                       |
	|SELLING OF HOUSES, UP TO 250 HOUSES PER SERVER, HOUSE INTERIORS WITH INTERIOR SHARING VIA THE|
	|WORLD ID MANAGEMENT SYSTEM INCORPORATED, HOUSE LOCKING ETC, THINK OF IT AS PEN1 ONLY BETTER  |
 	|=============================================================================================|
	|NOTES:                                                                                       |
	|=============================================================================================|
	|THIS SYSTEM REQUIRES A SETUP FILE TO BE ENCORPORATED INTO YOUR SCRIPTFILES WITH APPROPRIATE  |
	|HOUSING INFORMATION CONTAINED WITHIN IT - WITHOUT THIS FILE THE SYSTEM WILL AUTOMATICALLY    |
	|THE LOADING PROCESS TO PREVENT GAMEMODE CRASHES. SEE THE README FILE INCLUDED IN THE DOWNLOAD|
	|FOR DETAILS ON HOW TO SET UP THIS FILE CORRECTLY WITH ALL OF THE APPROPRIATE INFORMATION     |
	|                                                                                             |
	|IT IS WORTH NOTING THAT THIS SYSTEM USES A STREAMER TO MANAGE EACH PLAYER'S INDIVIDUAL MAP   |
	|ICON USAGE AND ALLOWS UP TO 250 HOUSES TO BE INSTALLED ONTO THE CURRENT SYSTEM. EACH HOUSE IS|
	|REPRESENTED ON THE MINIMAP BY A GREEN HOUSE SYMBOL IF IT IS UNSOLD OR A RED HOUSE SYMBOL IF  |
	|IT IS SOLD                                                                                   |
	|=============================================================================================|
	|NATIVE AND AVAILLABLE COMMAND FUNCTIONS:                                                     |
	|=============================================================================================|

native tAxI_OnPlayerStateChange(playerid, newstate)
native tAxI_OnVehicleDeath(vehicleid)
native tAxI_OnPlayerSpawn(playerid)
native tAxI_OnGameModeInit()
native tAxI_OnGameModeExit()
native tAxI_OnPlayerPickUpPickup(playerid,pickupid)
native tAxI_OnVehicleMod(vehicleid,componentid)
native tAxI_OnVehiclePaintjob(vehicleid,paintjobid)
native tAxI_OnVehicleRespray(vehicleid,color1,color2)
native tAxI_OnPlayerConnect(playerid)
native tAxI_OnPlayerDisconnect(playerid)
native tAxI_OnPlayerEnterVehicle(playerid,vehicleid)
native IsPlayerLoggedInHouseSystem(playerid)
native IsVehicleLinkedToAnyHouse(vehicleid)
native IsVehicleLinkedToHouse(vehicleid,houseid)
native IsPlayerHouseOwner(playerid,houseid)
native IsPlayerVehicleHouseOwner(playerid,vehicleid)
native IsHouseLocked(houseid)
native IsHouseVehicleLocked(houseid)
native GetPlayerClosestHouse(playerid)
native IsPlayerInRangeOfHouse(playerid,houseid,Float:max_range)
native SetSpawnAtHome(bool:toggle)
native PutPlayerInHouse(playerid,houseid)
native RemovePlayerFromHouse(playerid)
native SetHouseLocked(houseid,bool:toggle)
native SetHouseVehicleLocked(houseid,bool:toggle)
native SetHouseVehicleAutoModForPlayer(playerid,bool:toggle)

	|=============================================================================================|
	-=============================================================================================-
	
*/

//=================SYSTEM REQUIRED DEFINES===================//

#define MAX_STRING_SIZE 256
#define DEFAULT_HOUSE_OWNER "[null]"
#define HOUSE_FILE "tAxI_houses.cfg"
#define PLAYER_FILE_TEMPLATE "%s.tpf"
#define MAX_HOUSE_VARIABLES 42
#define MAX_HOUSES 250
#define MAX_ACTIVE_HOUSE_ICONS 32
#define MAX_SECTORS 256
#define MAX_SECTOR_HOUSES 250
#define HOUSE_SOLD_ICON 32
#define HOUSE_UNSOLD_ICON 31
#define HOUSE_ICON_TYPE 2
#define HOUSE_PICKUP 1272
#define RED 0xFF0000AA
#define BLUE 0x0000BBAA
#define GREEN 0x0AFF0AAA

//===============SYSTEM VARIABLES **DO NOT TOUCH!!!!**==========================//

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

new bass[1][0] = {
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
new allowhousespawn = 0;
new housecount = 0;
new streamcount[MAX_PLAYERS];
new MMactive[MAX_PLAYERS][MAX_HOUSES];
new HouseIcon[MAX_PLAYERS][MAX_HOUSES];
new SectorHouses[MAX_SECTORS][MAX_SECTOR_HOUSES];
new SectorHouseCount[MAX_SECTORS];
new vSecActive[MAX_SECTORS];
new lastd[700];

enum TPinfo
{
	name[MAX_STRING_SIZE],
	howner,
	howned,
	logged,
	inhouse,
	currenthouse,
	amodv,
}
new PlInfo[MAX_PLAYERS][TPinfo];

enum THInfo
{
	//======Core House Variables======//
    hcost,
	howned,
	password[MAX_STRING_SIZE],
	description[MAX_STRING_SIZE],
  	howner[MAX_STRING_SIZE],
	Float:x_ent,
	Float:y_ent,
	Float:z_ent,
	Float:x_int,
	Float:y_int,
	Float:z_int,
	intworldid,
 	intid,
	mmid,
	puid,
	hsecure,
	hsafe,
	//======House Car Variables======//
	Float:vposx,
	Float:vposy,
	Float:vposz,
	Float:vposza,
	vid,
	vmodel,
	vsecure,
	vvalue,
	//======House Car Mod Information======//
	vmod1,
	vmod2,
	vmod3,
	vmod4,
	vmod5,
	vmod6,
	vmod7,
	vmod8,
	vmod9,
	vmod10,
	vmod11,
	vmod12,
	vmod13,
	vmod14,
	vmod15,
	vmod16,
	vmod17,
	vcolor_1,
	vcolor_2,
	vpaintjob,
};
new HouseVar[MAX_HOUSES][THInfo];

//========SYSTEM FORWARDS========//

forward SectorScan();
forward ModHouseVehicle(houseid);
forward SpawnPlayerAtHouse(playerid);
forward BackupFiles();
forward SafeRespawnHouseVehicle(houseid);
forward InitiateMinimapStreamer();
forward Float:PlayerDistanceToHouse(playerid,houseid);

//============SYSTEM CORE PROCESSES ** NO FIDDLING WITH THESE!!! **==========//

//-------Credits to Dracoblue for these particular string based functions-------//
stock Set_Dest(dest[],source[]) {
	new count = strlen(source);
	new i=0;
	for (i=0;i<count;i++) {
		dest[i]=source[i];
	}
	dest[count]=0;
}

stock Memcpy_Ret(source[],index=0,numbytes) {
	new tmp[MAX_STRING_SIZE];
	new i=0;
	tmp[0]=0;
	if (index>=strlen(source)) return tmp;
	if (numbytes+index>=strlen(source)) numbytes=strlen(source)-index;
	if (numbytes<=0) return tmp;
	for (i=index;i<numbytes+index;i++) {
		tmp[i-index]=source[i];
		if (source[i]==0) return tmp;
	}
	tmp[numbytes]=0;
	return tmp;
}

stock String_Replace(trg[],newstr[],src[]) {
    new f=0;
    new s1[MAX_STRING_SIZE];
    new tmp[MAX_STRING_SIZE];
    format(s1,sizeof(s1),"%s",src);
    f = strfind(s1,trg);
    tmp[0]=0;
    while (f>=0) {
        strcat(tmp,Memcpy_Ret(s1, 0, f));
        strcat(tmp,newstr);
        format(s1,sizeof(s1),"%s",Memcpy_Ret(s1, f+strlen(trg), strlen(s1)-f));
        f = strfind(s1,trg);
    }
    strcat(tmp,s1);
    return tmp;
}

stock Encode_String(nickname[]) {
  new tmp[MAX_STRING_SIZE];
  Set_Dest(tmp,nickname);
  tmp=String_Replace("_","_00",tmp);
  tmp=String_Replace(";","_01",tmp);
  tmp=String_Replace("!","_02",tmp);
  tmp=String_Replace("/","_03",tmp);
  tmp=String_Replace("\\","_04",tmp);
  tmp=String_Replace("[","_05",tmp);
  tmp=String_Replace("]","_06",tmp);
  tmp=String_Replace("?","_07",tmp);
  tmp=String_Replace(".","_08",tmp);
  tmp=String_Replace("*","_09",tmp);
  tmp=String_Replace("<","_10",tmp);
  tmp=String_Replace(">","_11",tmp);
  tmp=String_Replace("{","_12",tmp);
  tmp=String_Replace("}","_13",tmp);
  tmp=String_Replace(" ","_14",tmp);
  tmp=String_Replace("\"","_15",tmp);
  tmp=String_Replace(":","_16",tmp);
  tmp=String_Replace("|","_17",tmp);
  tmp=String_Replace("=","_18",tmp);
  return tmp;
}
//-------End of Draco's Stuff-------//

//--------I think this was boylett that gave me this ages ago (if im wrong pm me on forums :P)--------//
stock CountHouses() {
    new File:HouseFile;
    new blank[MAX_STRING_SIZE];
    new count = 0;
    if (fexist(HOUSE_FILE)) {
        HouseFile = fopen(HOUSE_FILE);
        while(fread(HouseFile, blank, sizeof blank)) {
            count++;
        }
        fclose(HouseFile);
    }
    return count;
}

//--------Credits to Denver for this String_Split function--------//
stock String_Split(const strsrc[], strdest[][], delimiter)
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

stock GetPlayerSector(playerid)
{
	new Float:pos[3];
	if(IsPlayerConnected(playerid)) {
		GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
		new xsec = floatround(((pos[0] +4000) / 500), floatround_floor);
		new ysec = floatround(((pos[1] +4000) / 500), floatround_floor);
		return (xsec * 16) + ysec;
	}
	return 999;
}

public Float:PlayerDistanceToHouse(playerid,houseid)
{
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	return floatsqroot(floatpower(HouseVar[houseid][x_ent] - x, 2) + floatpower(HouseVar[houseid][y_ent] - y, 2) + floatpower(HouseVar[houseid][z_ent] - z, 2));
}

public SectorScan()
{
    new psec[MAX_PLAYERS];
    for(new i = 0;i<MAX_SECTORS;i++) {
		vSecActive[i] = 0;
	}
    for(new i = 0;i<MAX_PLAYERS;i++) {
        if(IsPlayerConnected(i)) {
			psec[i] = GetPlayerSector(i);
   			if(vSecActive[psec[i]] == 0) {
			    vSecActive[psec[i]] = 1;
			}
			if(vSecActive[psec[i]+1] == 0) {
	    		vSecActive[psec[i]+1] = 1;
			}
			if(vSecActive[psec[i]-1] == 0) {
			    vSecActive[psec[i]-1] = 1;
			}
			if(vSecActive[psec[i]-15] == 0) {
			    vSecActive[psec[i]-15] = 1;
			}
			if(vSecActive[psec[i]-16] == 0) {
			    vSecActive[psec[i]-16] = 1;
			}
			if(vSecActive[psec[i]-17] == 0) {
	    		vSecActive[psec[i]-17] = 1;
			}
			if(vSecActive[psec[i]+15] == 0) {
			    vSecActive[psec[i]+15] = 1;
			}
			if(vSecActive[psec[i]+16] == 0) {
			    vSecActive[psec[i]+16] = 1;
			}
			if(vSecActive[psec[i]+17] == 0) {
			    vSecActive[psec[i]+17] = 1;
			}
    		StreamProcess(i,psec[i],psec[i]+1,psec[i]-1,psec[i]+15,psec[i]-15,psec[i]+16,psec[i]-16,psec[i]+17,psec[i]-17);
		}
	}
}

stock StreamProcess(playerid,v1,v2,v3,v4,v5,v6,v7,v8,v9)
{
    new p,i;
    new sec[9];
    sec[0] = v1;
    sec[1] = v2;
    sec[2] = v3;
    sec[3] = v4;
    sec[4] = v5;
    sec[5] = v6;
    sec[6] = v7;
    sec[7] = v8;
    sec[8] = v9;
    for(new k = 0;k<7;k++) {
        i = sec[k];
        if(vSecActive[i] == 1) {
    		for(new j = 1;j<=SectorHouseCount[i];j++) {
        		p = SectorHouses[i][j];
				if(MMactive[playerid][p] == 0 && PlayerClose(playerid,HouseVar[p][x_ent],HouseVar[p][y_ent],HouseVar[p][z_ent],300) == 1) {
					if(streamcount[playerid] < MAX_ACTIVE_HOUSE_ICONS) { 
						if(HouseVar[p][howned] == 1) {
						    streamcount[playerid]++;
						    HouseIcon[playerid][p] = p;
						    SetPlayerMapIcon(playerid,HouseIcon[playerid][p],HouseVar[p][x_ent],HouseVar[p][y_ent],HouseVar[p][z_ent],HOUSE_SOLD_ICON,1);
							MMactive[playerid][p] = 1;
						}
						else {
						    streamcount[playerid]++;
						    HouseIcon[playerid][p] = p;
						    SetPlayerMapIcon(playerid,HouseIcon[playerid][p],HouseVar[p][x_ent],HouseVar[p][y_ent],HouseVar[p][z_ent],HOUSE_UNSOLD_ICON,1);
							MMactive[playerid][p] = 1;
						}
					}
				}
			}
    	}
 	}
 	for(new n = 0;n<MAX_HOUSES;n++) {
        if(MMactive[playerid][n] == 1 && PlayerClose(playerid,HouseVar[n][x_ent],HouseVar[n][y_ent],HouseVar[n][z_ent],300) == 0) {
		   	RemovePlayerMapIcon(playerid,HouseIcon[playerid][n]);
		   	streamcount[playerid]--;
		   	MMactive[playerid][n] = 0;
		}
    }
}

stock GetPointSector(Float:x,Float:y)
{
	new xsec = floatround(((x +4000) / 500), floatround_floor);
	new ysec = floatround(((y +4000) / 500), floatround_floor);
	return (xsec * 16) + ysec;
}

stock PlayerClose(playerid,Float:x,Float:y,Float:z,Float:MAX)
{
	new Float:PPos[3];
	if(IsPlayerConnected(playerid)) {
			GetPlayerPos(playerid, PPos[0], PPos[1], PPos[2]);
			if (PPos[0] >= floatsub(x, MAX) && PPos[0] <= floatadd(x, MAX)
			&& PPos[1] >= floatsub(y, MAX) && PPos[1] <= floatadd(y, MAX)
			&& PPos[2] >= floatsub(z, MAX) && PPos[2] <= floatadd(z, MAX))
			{
				return 1;
			}
	}
	return 0;
}

stock PlayersClose(Float:x,Float:y,Float:z,Float:MAX)
{
	new Float:PPos[3];
	for(new i = 0;i<MAX_PLAYERS;i++) {
		if(IsPlayerConnected(i)) {
			GetPlayerPos(i, PPos[0], PPos[1], PPos[2]);
			if (PPos[0] >= floatsub(x, MAX) && PPos[0] <= floatadd(x, MAX)
			&& PPos[1] >= floatsub(y, MAX) && PPos[1] <= floatadd(y, MAX)
			&& PPos[2] >= floatsub(z, MAX) && PPos[2] <= floatadd(z, MAX))
			{
				return 1;
			}
		}
	}
	return 0;
}

stock UpdateHouseSectorInfo()
{
    new secnum;
	for(new i = 0;i<MAX_SECTORS;i++) {
	    SectorHouseCount[i] = 0;
	}
   	for(new j = 0;j<MAX_HOUSES;j++) {
		secnum = GetPointSector(HouseVar[j][x_ent],HouseVar[j][y_ent]);
		SectorHouseCount[secnum]++;
		SectorHouses[secnum][SectorHouseCount[secnum]] = j;
	}
	return 1;
}

stock GetHouseVehicleValue(houseid)
{
	new vehprice = 1500;
	new finalprice;
	if(HouseVar[houseid][vmod1] != 0) {finalprice = vehprice+100; vehprice = finalprice;}
	if(HouseVar[houseid][vmod2] != 0) {finalprice = vehprice+100; vehprice = finalprice;}
	if(HouseVar[houseid][vmod3] != 0) {finalprice = vehprice+100; vehprice = finalprice;}
	if(HouseVar[houseid][vmod4] != 0) {finalprice = vehprice+100; vehprice = finalprice;}
	if(HouseVar[houseid][vmod5] != 0) {finalprice = vehprice+100; vehprice = finalprice;}
	if(HouseVar[houseid][vmod6] != 0) {finalprice = vehprice+100; vehprice = finalprice;}
	if(HouseVar[houseid][vmod7] != 0) {finalprice = vehprice+100; vehprice = finalprice;}
	if(HouseVar[houseid][vmod8] != 0) {finalprice = vehprice+100; vehprice = finalprice;}
	if(HouseVar[houseid][vmod9] != 0) {finalprice = vehprice+100; vehprice = finalprice;}
	if(HouseVar[houseid][vmod10] != 0) {finalprice = vehprice+100; vehprice = finalprice;}
	if(HouseVar[houseid][vmod11] != 0) {finalprice = vehprice+100; vehprice = finalprice;}
	if(HouseVar[houseid][vmod12] != 0) {finalprice = vehprice+100; vehprice = finalprice;}
	if(HouseVar[houseid][vmod13] != 0) {finalprice = vehprice+100; vehprice = finalprice;}
	if(HouseVar[houseid][vmod14] != 0) {finalprice = vehprice+100; vehprice = finalprice;}
	if(HouseVar[houseid][vmod15] != 0) {finalprice = vehprice+100; vehprice = finalprice;}
	if(HouseVar[houseid][vmod16] != 0) {finalprice = vehprice+100; vehprice = finalprice;}
	if(HouseVar[houseid][vmod17] != 0) {finalprice = vehprice+100; vehprice = finalprice;}
	if(HouseVar[houseid][vcolor_1] > -1 || HouseVar[houseid][vcolor_2] > -1) {finalprice = vehprice+100; vehprice = finalprice;}
	if(HouseVar[houseid][vpaintjob] > -1) {finalprice = vehprice+100; vehprice = finalprice;}
	return finalprice;
}

LoadHouseFile()
{
    print("    ");
    print("    ");
	print("----====<< tAxI's Housing System Loadup >>====----");
	print("    ");
    if(fexist(HOUSE_FILE)) {
        new SplitVar[MAX_HOUSE_VARIABLES][MAX_STRING_SIZE];
		new filestring[MAX_STRING_SIZE];
		new File: file = fopen(HOUSE_FILE, io_read);
		if (file) {
	    	for(new houseid = 0;houseid<housecount;houseid++)
			{
		    	fread(file, filestring);
				String_Split(filestring, SplitVar, ',');
				HouseVar[houseid][hcost] = strval(SplitVar[0]);
				HouseVar[houseid][howned] = strval(SplitVar[1]);
				strmid(HouseVar[houseid][password], SplitVar[2], 0, strlen(SplitVar[2]), 256);
				strmid(HouseVar[houseid][description], SplitVar[3], 0, strlen(SplitVar[3]), 256);
				strmid(HouseVar[houseid][howner], SplitVar[4], 0, strlen(SplitVar[4]), 256);
				HouseVar[houseid][x_ent] = floatstr(SplitVar[5]);
				HouseVar[houseid][y_ent] = floatstr(SplitVar[6]);
				HouseVar[houseid][z_ent] = floatstr(SplitVar[7]);
				HouseVar[houseid][x_int] = floatstr(SplitVar[8]);
				HouseVar[houseid][y_int] = floatstr(SplitVar[9]);
				HouseVar[houseid][z_int] = floatstr(SplitVar[10]);
				HouseVar[houseid][intworldid] = strval(SplitVar[11]);
 				HouseVar[houseid][intid] = strval(SplitVar[12]);
				HouseVar[houseid][hsecure] = strval(SplitVar[13]);
				HouseVar[houseid][vposx] = floatstr(SplitVar[14]);
				HouseVar[houseid][vposy] = floatstr(SplitVar[15]);
				HouseVar[houseid][vposz] = floatstr(SplitVar[16]);
				HouseVar[houseid][vposza] = floatstr(SplitVar[17]);
				HouseVar[houseid][vid] = strval(SplitVar[18]);
				HouseVar[houseid][vmodel] = strval(SplitVar[19]);
				HouseVar[houseid][vsecure] = strval(SplitVar[20]);
				HouseVar[houseid][vmod1] = strval(SplitVar[21]);
				HouseVar[houseid][vmod2] = strval(SplitVar[22]);
				HouseVar[houseid][vmod3] = strval(SplitVar[23]);
				HouseVar[houseid][vmod4] = strval(SplitVar[24]);
				HouseVar[houseid][vmod5] = strval(SplitVar[25]);
				HouseVar[houseid][vmod6] = strval(SplitVar[26]);
				HouseVar[houseid][vmod7] = strval(SplitVar[27]);
				HouseVar[houseid][vmod8] = strval(SplitVar[28]);
				HouseVar[houseid][vmod9] = strval(SplitVar[29]);
				HouseVar[houseid][vmod10] = strval(SplitVar[30]);
				HouseVar[houseid][vmod11] = strval(SplitVar[31]);
				HouseVar[houseid][vmod12] = strval(SplitVar[32]);
				HouseVar[houseid][vmod13] = strval(SplitVar[33]);
				HouseVar[houseid][vmod14] = strval(SplitVar[34]);
				HouseVar[houseid][vmod15] = strval(SplitVar[35]);
				HouseVar[houseid][vmod16] = strval(SplitVar[36]);
				HouseVar[houseid][vmod17] = strval(SplitVar[37]);
				HouseVar[houseid][vcolor_1] = strval(SplitVar[38]);
				HouseVar[houseid][vcolor_2] = strval(SplitVar[39]);
				HouseVar[houseid][vpaintjob] = strval(SplitVar[40]);
				HouseVar[houseid][hsafe] = strval(SplitVar[41]);
				HouseVar[houseid][vvalue] = GetHouseVehicleValue(houseid);
				new addmess[MAX_STRING_SIZE];
				HouseVar[houseid][puid] = CreatePickup(HOUSE_PICKUP,HOUSE_ICON_TYPE,HouseVar[houseid][x_ent],HouseVar[houseid][y_ent],HouseVar[houseid][z_ent]);
				HouseVar[houseid][vid] = CreateVehicle(HouseVar[houseid][vmodel],HouseVar[houseid][vposx],HouseVar[houseid][vposy],HouseVar[houseid][vposz],HouseVar[houseid][vposza],HouseVar[houseid][vcolor_1],HouseVar[houseid][vcolor_2],30000);
                //SetTimerEx("ModHouseVehicle",100,0,"i",houseid);
                ModHouseVehicle(houseid);
				format(addmess,sizeof(addmess),"--:: House <ID:%d - %s> successfully loaded - owner: <%s> ::--",houseid,HouseVar[houseid][description],HouseVar[houseid][howner]);
				printf(addmess);
			}
		}
		fclose(file);
		print("    ");
		print("----====<< tAxI's Housing System Fully Loaded >>====----");
		print("    ");
		print("    ");
		print("    ");
	}
	else {
		print("DEBUG :: tAxI HOUSING SYSTEM ERROR! - HOUSE FILE ('tAxI_houses.cfg') NOT FOUND IN '/scriptfiles'. HOUSE SYSTEM DEACTIVATED ON SERVER LOADUP.");
        print("    ");
		print("----====<< tAxI's Housing System Shut Down >>====----");
		print("    ");
		print("    ");
		print("    ");
	}
}

stock SaveHouseFile()
{
	new filestring[MAX_STRING_SIZE];
	new File: hfile = fopen(HOUSE_FILE, io_write);
	for(new houseid = 0;houseid<housecount;houseid++)
 	{
		format(filestring, sizeof(filestring), "%d,%d,%s,%s,%s,%f,%f,%f,%f,%f,%f,%d,%d,%d,%f,%f,%f,%f,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n",
		HouseVar[houseid][hcost],
		HouseVar[houseid][howned],
		HouseVar[houseid][password],
		HouseVar[houseid][description],
		HouseVar[houseid][howner],
		HouseVar[houseid][x_ent],
		HouseVar[houseid][y_ent],
		HouseVar[houseid][z_ent],
		HouseVar[houseid][x_int],
		HouseVar[houseid][y_int],
		HouseVar[houseid][z_int],
		HouseVar[houseid][intworldid],
		HouseVar[houseid][intid],
		HouseVar[houseid][hsecure],
		HouseVar[houseid][vposx],
		HouseVar[houseid][vposy],
		HouseVar[houseid][vposz],
		HouseVar[houseid][vposza],
		HouseVar[houseid][vid],
		HouseVar[houseid][vmodel],
		HouseVar[houseid][vsecure],
		HouseVar[houseid][vmod1],
		HouseVar[houseid][vmod2],
		HouseVar[houseid][vmod3],
		HouseVar[houseid][vmod4],
		HouseVar[houseid][vmod5],
		HouseVar[houseid][vmod6],
		HouseVar[houseid][vmod7],
		HouseVar[houseid][vmod8],
		HouseVar[houseid][vmod9],
		HouseVar[houseid][vmod10],
		HouseVar[houseid][vmod11],
		HouseVar[houseid][vmod12],
		HouseVar[houseid][vmod13],
		HouseVar[houseid][vmod14],
		HouseVar[houseid][vmod15],
		HouseVar[houseid][vmod16],
		HouseVar[houseid][vmod17],
		HouseVar[houseid][vcolor_1],
		HouseVar[houseid][vcolor_2],
		HouseVar[houseid][vpaintjob],
		HouseVar[houseid][hsafe]
		);
		fwrite(hfile, filestring);
	}
	fclose(hfile);
}

stock ModHouseVehicle(houseid)
{
	new tmp1 = HouseVar[houseid][vid];
	new tmp2 = HouseVar[houseid][vmod1];
	new tmp3 = HouseVar[houseid][vmod2];
	new tmp4 = HouseVar[houseid][vmod3];
	new tmp5 = HouseVar[houseid][vmod4];
	new tmp6 = HouseVar[houseid][vmod5];
	new tmp7 = HouseVar[houseid][vmod6];
	new tmp8 = HouseVar[houseid][vmod7];
	new tmp9 = HouseVar[houseid][vmod8];
	new tmp10 = HouseVar[houseid][vmod9];
	new tmp11 = HouseVar[houseid][vmod10];
	new tmp12 = HouseVar[houseid][vmod11];
	new tmp13 = HouseVar[houseid][vmod12];
	new tmp14 = HouseVar[houseid][vmod13];
	new tmp15 = HouseVar[houseid][vmod14];
	new tmp16 = HouseVar[houseid][vmod15];
	new tmp17 = HouseVar[houseid][vmod16];
	new tmp18 = HouseVar[houseid][vmod17];
	new tmp19 = HouseVar[houseid][vpaintjob];
	if(tmp2 > 0) {AddVehicleComponent(tmp1,tmp2);}
	if(tmp3 > 0) {AddVehicleComponent(tmp1,tmp3);}
	if(tmp4 > 0) {AddVehicleComponent(tmp1,tmp4);}
	if(tmp5 > 0) {AddVehicleComponent(tmp1,tmp5);}
	if(tmp6 > 0) {AddVehicleComponent(tmp1,tmp6);}
	if(tmp7 > 0) {AddVehicleComponent(tmp1,tmp7);}
	if(tmp8 > 0) {AddVehicleComponent(tmp1,tmp8);}
	if(tmp9 > 0) {AddVehicleComponent(tmp1,tmp9);}
	if(tmp10 > 0) {AddVehicleComponent(tmp1,tmp10);}
	if(tmp11 > 0) {AddVehicleComponent(tmp1,tmp11);}
	if(tmp12 > 0) {AddVehicleComponent(tmp1,tmp12);}
	if(tmp13 > 0) {AddVehicleComponent(tmp1,tmp13);}
	if(tmp14 > 0) {AddVehicleComponent(tmp1,tmp14);}
	if(tmp15 > 0) {AddVehicleComponent(tmp1,tmp15);}
	if(tmp16 > 0) {AddVehicleComponent(tmp1,tmp16);}
	if(tmp17 > 0) {AddVehicleComponent(tmp1,tmp17);}
	if(tmp18 > 0) {AddVehicleComponent(tmp1,tmp18);}
	if(tmp19 > -1) {ChangeVehiclePaintjob(tmp1,tmp19);}
}

stock GetDriverID(vehicleid)
{
    for(new i=0; i<700; i++) {
        if(IsPlayerConnected(i)) {
            if(IsPlayerInAnyVehicle(i)) {
                if(GetPlayerVehicleID(i) == vehicleid) {
					return i;
                }
            }
        }
    }
    return -1;
}

stock LoadPlayerFile(playerid)
{
    new fname[MAX_STRING_SIZE],playername[MAX_STRING_SIZE],filestring[MAX_STRING_SIZE];
    GetPlayerName(playerid,playername,sizeof(playername));
 	new SplitDiv[2][MAX_STRING_SIZE];
	new File: file;
 	format(fname,sizeof(fname),PLAYER_FILE_TEMPLATE,Encode_String(playername));
 	if(fexist(fname)) {
 	    file = fopen(fname, io_read);
		if (file) {
 			fread(file, filestring);
			String_Split(filestring, SplitDiv, ',');
			PlInfo[playerid][howner] = strval(SplitDiv[0]);
			PlInfo[playerid][howned] = strval(SplitDiv[1]);
			fclose(file);
		}
 	}
 	else {
 	    CreatePlayerFile(playerid);
 	}
}

stock SavePlayerFile(playerid)
{
    new fname[MAX_STRING_SIZE],playername[MAX_STRING_SIZE],filestring[MAX_STRING_SIZE];
	new File: file;
	GetPlayerName(playerid, playername, sizeof(playername));
 	format(fname,sizeof(fname),PLAYER_FILE_TEMPLATE,Encode_String(playername));
 	if(!fexist(fname)) {}
 	else {
	    file = fopen(fname, io_write);
	    if(file) {
  			format(filestring,sizeof(filestring),"%d,%d",PlInfo[playerid][howner],PlInfo[playerid][howned]);
   			fwrite(file,filestring);
	   		fclose(file);
		}
	}
}

stock CreatePlayerFile(playerid)
{
	new fname[MAX_STRING_SIZE],playername[MAX_STRING_SIZE];
	new File: file;
	GetPlayerName(playerid, playername, sizeof(playername));
 	format(fname,sizeof(fname),PLAYER_FILE_TEMPLATE,Encode_String(playername));
  	file = fopen(fname, io_write);
  	if(file) {
		fwrite(file,"0,0");
		fclose(file);
	}
	LoadPlayerFile(playerid);
}

public SpawnPlayerAtHouse(playerid)
{
	new houseid = PlInfo[playerid][howned];
	SetPlayerPos(playerid,HouseVar[houseid][x_int],HouseVar[houseid][y_int],HouseVar[houseid][z_int]);
	SetPlayerInterior(playerid,HouseVar[houseid][intid]);
	SetPlayerVirtualWorld(playerid,HouseVar[houseid][intworldid]);
	PlInfo[playerid][currenthouse] = houseid;
	PlInfo[playerid][inhouse] = 1;
	SendClientMessage(playerid, GREEN, "Welcome back to your home.");
	return 1;
}

public BackupFiles()
{
	SaveHouseFile();
	for(new s=0; s<MAX_PLAYERS; s++) {
	    if(IsPlayerConnected(s) && PlInfo[s][logged]) {
	        SavePlayerFile(s);
	    }
	}
}

public SafeRespawnHouseVehicle(houseid)
{
	DestroyVehicle(HouseVar[houseid][vid]);
	HouseVar[houseid][vid] = CreateVehicle(HouseVar[houseid][vmodel],HouseVar[houseid][vposx],HouseVar[houseid][vposy],HouseVar[houseid][vposz],HouseVar[houseid][vposza],HouseVar[houseid][vcolor_1],HouseVar[houseid][vcolor_2],30000);
	//SetTimerEx("ModHouseVehicle",100,0,"i",houseid);
	ModHouseVehicle(houseid);
}

stock GetVehiclehouseid(vehicleid)
{
    for(new s=0; s<MAX_HOUSES; s++) {
        if(HouseVar[s][vid] == vehicleid) {
            return s;
        }
    }
    return 999;
}

public InitiateMinimapStreamer()
{
    UpdateHouseSectorInfo();
	SetTimer("SectorScan",1000,1);
}

//====================NATIVES REQUIRED FOR SYSTEM TO START PROPERLY===================================

stock tAxI_OnPlayerStateChange(playerid, newstate)
{
	if(newstate == PLAYER_STATE_DRIVER) {
	    new string[MAX_STRING_SIZE];
		new houseid = GetVehiclehouseid(GetPlayerVehicleID(playerid));
		if (strcmp(HouseVar[houseid][howner],DEFAULT_HOUSE_OWNER,false) == 0) {
			if(HouseVar[houseid][vsecure] == 0) {
				SendClientMessage(playerid, BLUE, "This house vehicle is not currently owned by anyone.");
		    	return 1;
			}
		}
        if (strcmp(HouseVar[houseid][howner],PlInfo[playerid][name],false) == 0) {
			if(HouseVar[houseid][vsecure] == 0) {
				SendClientMessage(playerid, GREEN, "Your house vehicle security system is currently deactivated.");
		    	return 1;
			}
	 		if(HouseVar[houseid][vsecure] == 1) {
				SendClientMessage(playerid, GREEN, "Your house vehicle security system is currently set to eject any intruders.");
		    	return 1;
			}
		}
		else {
		    if(HouseVar[houseid][vsecure] == 0) {
				format(string, sizeof(string), "%s has set their vehicle to allow anyone to use it. If you wreck it, you pay for repairs ($%d)",HouseVar[houseid][howner],HouseVar[houseid][vvalue]);
			}
	 		if(HouseVar[houseid][vsecure] == 1) {
				format(string, sizeof(string), "The owner of this vehicle (%s), has set the vehicle to eject intruders. Enjoy the walk!",HouseVar[houseid][howner]);
			}
			SendClientMessage(playerid,RED,string);
		}
	}
	return 1;
}

stock tAxI_OnVehicleDeath(vehicleid)
{
	new houseid = GetVehiclehouseid(vehicleid);
	SetTimerEx("SafeRespawnHouseVehicle",5000,0,"i",houseid);
   	new pmon = GetPlayerMoney(lastd[vehicleid])-HouseVar[houseid][vvalue];
   	new hmon = HouseVar[houseid][hsafe]+HouseVar[houseid][vvalue];
   	if(strcmp(HouseVar[houseid][howner],DEFAULT_HOUSE_OWNER,false) == 0) {
   	    SendClientMessage(lastd[vehicleid],RED,"Your lucky nobody owned that vehicle you just destroyed. No charge Hot Rod!");
   	    return 1;
	}
   	if(strcmp(HouseVar[houseid][howner],PlInfo[lastd[vehicleid]][name],false) == 0) {
   	    SendClientMessage(lastd[vehicleid],GREEN,"Your house vehicle will be returned to it's parking spot at your property and repaired");
   	    return 1;
   	}
   	new string[MAX_STRING_SIZE];
   	format(string,sizeof(string),"You have been billed for the destruction of %s's house vehicle ($%d).",HouseVar[houseid][howner],HouseVar[houseid][vvalue]);
   	ResetPlayerMoney(lastd[vehicleid]);
   	GivePlayerMoney(lastd[vehicleid],pmon);
   	HouseVar[houseid][hsafe] = hmon;
   	SendClientMessage(lastd[vehicleid],RED,string);
   	return 1;
}

stock tAxI_OnPlayerSpawn(playerid)
{
	if(allowhousespawn == 1 && PlInfo[playerid][howner] == 1) {
	    SetTimerEx("SpawnPlayerAtHouse",750,0,"i",playerid);
	}
}

stock tAxI_OnGameModeInit()
{
	housecount = CountHouses();
    LoadHouseFile();
    SetTimer("InitiateMinimapStreamer",3000,0);
    SetTimer("BackupFiles",120000,1);
	return 1;
}

stock tAxI_OnGameModeExit()
{
    SaveHouseFile();
	return 1;
}

stock tAxI_OnPlayerPickUpPickup(playerid,pickupid)
{
    for(new s=0; s<MAX_HOUSES; s++) {
        if(HouseVar[s][puid] == pickupid) {
            new houseowner[MAX_STRING_SIZE],lockmes[MAX_STRING_SIZE];
            format(lockmes,256,"Unlocked");
            if(HouseVar[s][hsecure] == 1) {
                format(lockmes,256,"Locked");
            }
			format(houseowner,256,"%s",HouseVar[s][howner]);
			if(strcmp(HouseVar[s][howner],DEFAULT_HOUSE_OWNER,false) == 0) {
	    		format(houseowner,256,"<Still For Sale>");
			}
			new housemes[MAX_STRING_SIZE];
			format(housemes,256,"~n~~n~~r~Description: ~g~%s~n~~r~Price: ~g~$%d ~r~~n~~r~Owner: ~g~%s~n~~r~Security: ~g~%s",HouseVar[s][description],HouseVar[s][hcost],houseowner,lockmes);
    		GameTextForPlayer(playerid,housemes,5000,3);
			return 1;
        }
    }
    return 0;
}

stock tAxI_OnVehicleMod(vehicleid,componentid)
{
    new playerid = GetDriverID(vehicleid);
    new houseid = PlInfo[playerid][howned];
    if(PlInfo[playerid][amodv] == 1) {
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
    	    if (IsPlayerVehicleHouseOwner(playerid,vehicleid) == 1) {
				for(new s=0; s<20; s++) {
     				if(componentid == spoiler[s][0]) {
       					HouseVar[houseid][vmod1] = componentid;
   	        		}
				}
				for(new s=0; s<3; s++) {
     				if(componentid == nitro[s][0]) {
       					HouseVar[houseid][vmod2] = componentid;
   	        		}
				}
				for(new s=0; s<23; s++) {
     				if(componentid == fbumper[s][0]) {
       					HouseVar[houseid][vmod3] = componentid;
   	        		}
				}
				for(new s=0; s<22; s++) {
     				if(componentid == rbumper[s][0]) {
       					HouseVar[houseid][vmod4] = componentid;
   	        		}
				}
				for(new s=0; s<28; s++) {
     				if(componentid == exhaust[s][0]) {
       					HouseVar[houseid][vmod5] = componentid;
   	        		}
				}
				for(new s=0; s<2; s++) {
     				if(componentid == bventr[s][0]) {
       					HouseVar[houseid][vmod6] = componentid;
   	        		}
				}
				for(new s=0; s<2; s++) {
     				if(componentid == bventl[s][0]) {
       					HouseVar[houseid][vmod7] = componentid;
   	        		}
				}
				for(new s=0; s<4; s++) {
     				if(componentid == bscoop[s][0]) {
       					HouseVar[houseid][vmod8] = componentid;
   	        		}
				}
				for(new s=0; s<13; s++) {
     				if(componentid == rscoop[s][0]) {
       					HouseVar[houseid][vmod9] = componentid;
   	        		}
				}
				for(new s=0; s<21; s++) {
     				if(componentid == lskirt[s][0]) {
       					HouseVar[houseid][vmod10] = componentid;
   	        		}
				}
				for(new s=0; s<21; s++) {
     				if(componentid == rskirt[s][0]) {
       					HouseVar[houseid][vmod11] = componentid;
   	        		}
				}
				for(new s=0; s<1; s++) {
     				if(componentid == hydraulics[s][0]) {
       					HouseVar[houseid][vmod12] = componentid;
   	        		}
				}
				for(new s=0; s<1; s++) {
     				if(componentid == bass[s][0]) {
       					HouseVar[houseid][vmod13] = componentid;
   	        		}
				}
				for(new s=0; s<2; s++) {
     				if(componentid == rbbars[s][0]) {
       					HouseVar[houseid][vmod14] = componentid;
   	        		}
				}
				for(new s=0; s<2; s++) {
     				if(componentid == fbbars[s][0]) {
       					HouseVar[houseid][vmod15] = componentid;
   	        		}
				}
				for(new s=0; s<17; s++) {
     				if(componentid == wheels[s][0]) {
       					HouseVar[houseid][vmod16] = componentid;
   	        		}
				}
				for(new s=0; s<2; s++) {
     				if(componentid == lights[s][0]) {
       					HouseVar[houseid][vmod17] = componentid;
   	        		}
				}
				HouseVar[houseid][vvalue] = GetHouseVehicleValue(houseid);
			}
		}
	}
}

stock tAxI_OnVehiclePaintjob(vehicleid,paintjobid)
{
    new playerid = GetDriverID(vehicleid);
    if(PlInfo[playerid][amodv] == 1) {
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
    	    if (IsPlayerVehicleHouseOwner(playerid,vehicleid) == 1) {
				HouseVar[PlInfo[playerid][howned]][vpaintjob] = paintjobid;
				HouseVar[PlInfo[playerid][howned]][vvalue] = GetHouseVehicleValue(PlInfo[playerid][howned]);
			}
		}
	}
}

stock tAxI_OnVehicleRespray(vehicleid,color1,color2)
{
    new playerid = GetDriverID(vehicleid);
    if(PlInfo[playerid][amodv] == 1) {
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
    	    if (IsPlayerVehicleHouseOwner(playerid,vehicleid) == 1) {
				HouseVar[PlInfo[playerid][howned]][vcolor_1] = color1;
    	        HouseVar[PlInfo[playerid][howned]][vcolor_2] = color2;
    	        HouseVar[PlInfo[playerid][howned]][vvalue] = GetHouseVehicleValue(PlInfo[playerid][howned]);
			}
		}
	}
}

stock tAxI_OnPlayerConnect(playerid)
{
	GetPlayerName(playerid, PlInfo[playerid][name],256);
	LoadPlayerFile(playerid);
	PlInfo[playerid][amodv] = 0;
	PlInfo[playerid][logged] = 0;
	PlInfo[playerid][inhouse] = 0;
	PlInfo[playerid][currenthouse] = 0;
}

stock tAxI_OnPlayerDisconnect(playerid)
{
	if(PlInfo[playerid][logged] == 1) {
		SavePlayerFile(playerid);
		SaveHouseFile();
	}
}

stock tAxI_OnPlayerEnterVehicle(playerid,vehicleid)
{
	lastd[vehicleid] = playerid;
}

//==================AVAILLABLE COMMAND FUNCTIONS FOR THE HOUSES================//

stock IsPlayerLoggedInHouseSystem(playerid)
{
	return PlInfo[playerid][logged];
}

stock IsVehicleLinkedToAnyHouse(vehicleid)
{
    for(new i = 0;i<MAX_HOUSES;i++) {
        if(vehicleid == HouseVar[i][vid]) {
            return 1;
        }
    }
    return 0;
}

stock IsVehicleLinkedToHouse(vehicleid,houseid)
{
	if(vehicleid == HouseVar[houseid][vid]) {
	    return 1;
	}
	return 0;
}

stock IsPlayerHouseOwner(playerid,houseid)
{
	if(strcmp(HouseVar[houseid][howner],PlInfo[playerid][name],false) == 0) {
	    return 1;
	}
	return 0;
}

stock IsPlayerVehicleHouseOwner(playerid,vehicleid)
{
	if(PlInfo[playerid][howner] == 1 && HouseVar[PlInfo[playerid][howned]][vid] == vehicleid) {
	    return 1;
	}
	return 0;
}

stock IsHouseLocked(houseid)
{
	if(HouseVar[houseid][hsecure] == 1) {
	    return 1;
	}
	return 0;
}

stock IsHouseVehicleLocked(houseid)
{
	return HouseVar[houseid][vsecure];
}

stock GetPlayerClosestHouse(playerid)
{
	new Float:dist,Float:tmp;
	new lowesthouse;
	dist = 9999.0;
    for(new i = 0;i<housecount;i++) {
        tmp = PlayerDistanceToHouse(playerid,i);
        if(tmp < dist) {
            dist = tmp;
            lowesthouse = i;
        }
	}
	return lowesthouse;
}

stock IsPlayerInRangeOfHouse(playerid,houseid,Float:max_range)
{
    new Float:ppos[3];
    GetPlayerPos(playerid, ppos[0], ppos[1], ppos[2]);
   	if (ppos[0] >= floatsub(HouseVar[houseid][x_ent], max_range) && ppos[0] <= floatadd(HouseVar[houseid][x_ent], max_range)
   	&& ppos[1] >= floatsub(HouseVar[houseid][y_ent], max_range) && ppos[1] <= floatadd(HouseVar[houseid][y_ent], max_range)
   	&& ppos[2] >= floatsub(HouseVar[houseid][z_ent], max_range) && ppos[2] <= floatadd(HouseVar[houseid][z_ent], max_range))
   	{
       	return 1;
   	}
	return 0;
}

stock IsPlayerInAnyHouse(playerid)
{
	return PlInfo[playerid][inhouse];
}

stock GetPlayerCurrentHouse(playerid)
{
	return PlInfo[playerid][currenthouse];
}

stock LogPlayerIntoHouseSystem(playerid)
{
	PlInfo[playerid][logged] = 1;
	return 1;
}

stock SetSpawnAtHome(bool:toggle)
{
	if(toggle == true) {
	    allowhousespawn = 1;
	}
	else {
	    allowhousespawn = 0;
	}
}

stock PutPlayerInHouse(playerid,houseid)
{
    SetPlayerPos(playerid,HouseVar[houseid][x_int],HouseVar[houseid][y_int],HouseVar[houseid][z_int]);
	SetPlayerInterior(playerid,HouseVar[houseid][intid]);
	SetPlayerVirtualWorld(playerid,HouseVar[houseid][intworldid]);
	PlInfo[playerid][currenthouse] = houseid;
	PlInfo[playerid][inhouse] = 1;
	if(IsPlayerHouseOwner(playerid,houseid) == 1) {
		return SendClientMessage(playerid, GREEN, "Welcome back to your home.");
	}
	return SendClientMessage(playerid, GREEN, "Welcome visitor.");
}

stock RemovePlayerFromHouse(playerid)
{
	if(IsPlayerInAnyHouse(playerid) == 1) {
		new houseid = GetPlayerCurrentHouse(playerid);
		SetPlayerPos(playerid,HouseVar[houseid][x_ent],HouseVar[houseid][y_ent],HouseVar[houseid][z_ent]);
	    SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,0);
		PlInfo[playerid][inhouse] = 0;
	}
	return 1;
}

stock SetHouseLocked(houseid,bool:toggle)
{
	if(toggle == true) {
		HouseVar[houseid][hsecure] = 1;
	}
	else {
	    HouseVar[houseid][hsecure] = 0;
	}
}

stock SetHouseVehicleLocked(houseid,bool:toggle)
{
	if(toggle == true) {
		HouseVar[houseid][vsecure] = 1;
	}
	else {
	    HouseVar[houseid][vsecure] = 0;
	}
}

stock SetHouseVehicleAutoModForPlayer(playerid,bool:toggle)
{
	if(toggle == true) {
		PlInfo[playerid][amodv] = 1;
	}
	else {
	    PlInfo[playerid][amodv] = 0;
	}
}
