/*
					///////////////////////////////////////////////////
					////                                           ////
					////        tAxI's COMPLETE ALL-IN-ONE         ////
					////            STREAMER TOOLKIT V2            ////
					////                                           ////
					////     COPYRIGHT: RELEASED UNDER the GNU     ////
					////                 LICENCE                   ////
					////                                           ////
					///////////////////////////////////////////////////


    tAxI's Advanced Streamer Toolkit - INC Package for SA-MP Multiplayer Modification 
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

=============================================================================================

native tAxI_OnGameModeInit()
native tAxI_OnVehicleDeath(vehicleid)
native tAxI_OnPlayerEnterVehicle(vehicleid)
native tAxI_OnVehicleMod(vehicleid,componentid)
native tAxI_OnVehicleRespray(vehicleid,color1,color2)
native tAxI_OnVehiclePaintjob(vehicleid,paintjobid)
native ToggleAutoModSave(bool:toggle)
native CreateStreamVehicle(modelid,Float:x,Float:y,Float:z,Float:a,col1,col2)
native CreateTempStreamVehicle(modelid,Float:x,Float:y,Float:z,Float:a,col1,col2)
native GetPlayerVehicleStreamID(playerid)
native GetVehicleStreamID(vehicleid)
native SetVehicleStreamPos(vstreamid,Float:x,Float:y,Float:z,Float:a)
native SetVehicleStreamModel(vstreamid,model)
native ChangeStreamVehiclePaintjob(vstreamid,paintjobid)
native ChangeStreamVehicleColor(vstreamid,col1,col2)
native AddStreamVehicleMod(vstreamid,componentid)
native SetStreamVehicleParamsForPlayer(vstreamid,playerid,objective,doorslocked);
native LinkStreamVehicleToInterior(vstreamid,interiorid)
native SetStreamVehicleVirtualWorld(vstreamid,world)

=============================================================================================
*/

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

#define MAX_MODEL_NUMBER 211
#define MAX_STREAM_VEHICLES 3000
#define MAX_ACTIVE_VEHICLES 695
#define MAX_ACTIVE_PICKUPS 250
#define MAX_ACTIVE_MODELS 68
#define MAX_ACTIVE_MM_ICONS 32
#define P_LIMIT 2500
#define MM_LIMIT 2500
#define MAX_SECTORS 256
#define MAX_SECTOR_VEHICLES 75
#define RED 0xFF0000AA
#define BLUE 0x0000BBAA

new vehcount = 0;
new Vstreamcount = 0;
new vehused[MAX_ACTIVE_VEHICLES];
new avstream[MAX_ACTIVE_VEHICLES];
new SectorVehicles[MAX_SECTORS][MAX_SECTOR_VEHICLES];
new SectorVehicleCount[MAX_SECTORS];
new vSecActive[MAX_SECTORS];
new SystemSafe = 0;
new AdminPanel[MAX_PLAYERS];
new Text:vehicletext;
new Vtext[256];
new bool:Automodsave;

enum vInfo
{
	limbo,
	model,
	Float:x_spawn,
	Float:y_spawn,
	Float:z_spawn,
 	Float:za_spawn,
 	color_1,
 	color_2,
	spawned,
	idnum,
 	valid,
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
 	temporary,
 	worldid,
 	intid,
};

new VehicleInfo[MAX_STREAM_VEHICLES][vInfo];


enum pI
{
	obj,
	dlock
};

new PlI[MAX_PLAYERS][MAX_STREAM_VEHICLES][pI];

forward InitiateSectorSystem();
forward SectorScan();
forward ModVehicle(streamid);
forward DeathProcess(vehicleid);
forward RemoveTempVehicle(vehicleid);

stock UpdateVehicleParams(vstreamid)
{
    for(new i = 0;i<MAX_PLAYERS;i++) {
		SetVehicleParamsForPlayer(VehicleInfo[vstreamid][idnum],i,PlI[i][vstreamid][obj],PlI[i][vstreamid][dlock]);
	}
	return 1;
}

stock LinkStreamVehicleToInterior(vstreamid,interiorid)
{
    VehicleInfo[vstreamid][intid] = interiorid;
	if(VehicleInfo[vstreamid][spawned] == 1) {
	    LinkVehicleToInterior(VehicleInfo[vstreamid][idnum],interiorid);
	}
	return 1;
}

stock SetStreamVehicleParamsForPlayer(vstreamid,playerid,objective,doorslocked)
{
	PlI[i][vstreamid][obj] = objective;
	PlI[i][vstreamid][dlock] = doorslocked;
	if(VehicleInfo[vstreamid][spawned] == 1) {
	    UpdateVehicleParams(vstreamid);
	}
	return 1;
}

stock SetStreamVehicleVirtualWorld(vstreamid,world)
{
	VehicleInfo[vstreamid][worldid] = world;
	if(VehicleInfo[vstreamid][spawned] == 1) {
	    SetVehicleVirtualWorld(VehicleInfo[vstreamid][idnum],world);
	}
	return 1;
}

stock GetVehicleSpawnSector(streamid)
{
    new xsec = floatround(((VehicleInfo[streamid][x_spawn] +4000) / 500), floatround_floor);
	new ysec = floatround(((VehicleInfo[streamid][y_spawn] +4000) / 500), floatround_floor);
	return (xsec * 16) + ysec;
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
	CleanupVehicles();
}

stock CleanupVehicles()
{
	new i;
	for(new j = 1;j<Vstreamcount;j++) {
		i = GetVehicleStreamID(j-1);
		if(VehicleInfo[i][spawned] == 1 && vehused[VehicleInfo[i][idnum]] == 0 && PlayersClose(VehicleInfo[i][x_spawn],VehicleInfo[i][y_spawn],VehicleInfo[i][z_spawn],300) == 0) {
			VehicleInfo[i][spawned] = 0;
			DestroyVehicle(VehicleInfo[i][idnum]);
			vehused[VehicleInfo[i][idnum]] = 0;
			Vstreamcount--;
			VehicleInfo[i][idnum] = 0;
    	}
	}
	AdminPanelUpdate();
}

stock AdminPanelUpdate()
{
    format(Vtext,sizeof(Vtext),"Vehicles = %d / Models = %d",Vstreamcount,CountModels());
    for(new i = 0;i<MAX_PLAYERS;i++) {
        if(IsPlayerConnected(i) && IsPlayerAdmin(i)) {
            if(AdminPanel[i] == 0) {
                AdminPanel[i] = 1;
				TextDrawShowForPlayer(i,vehicletext);
            }
			else {
				TextDrawSetString(vehicletext,Vtext);
			}
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
    		for(new j = 1;j<=SectorVehicleCount[i];j++) {
        		p = SectorVehicles[i][j];
        		if(VehicleInfo[p][limbo] == 0 && VehicleInfo[p][valid] == 1 && VehicleInfo[p][spawned] == 0 && PlayerClose(playerid,VehicleInfo[p][x_spawn],VehicleInfo[p][y_spawn],VehicleInfo[p][z_spawn],300) == 1) {
						if(Vstreamcount < MAX_ACTIVE_VEHICLES) {
			        		if(IsModelActive(VehicleInfo[p][model]) == 0) {
			           		 	if(CountModels() < MAX_ACTIVE_MODELS) {
			           		 	    VehicleInfo[p][spawned] = 1;
									VehicleInfo[p][idnum] = CreateVehicle(VehicleInfo[p][model], VehicleInfo[p][x_spawn], VehicleInfo[p][y_spawn], VehicleInfo[p][z_spawn], VehicleInfo[p][za_spawn], VehicleInfo[p][color_1], VehicleInfo[p][color_2],20000);
									avstream[VehicleInfo[p][idnum]] = p;
									SetTimerEx("ModVehicle",100,0,"i",p);
									if(VehicleInfo[p][worldid] > 0) {
									    SetVehicleVirtualWorld(VehicleInfo[p][idnum],VehicleInfo[p][worldid]);
									}
									if(VehicleInfo[p][intid] > 0) {
									    LinkVehicleToInterior(VehicleInfo[p][idnum],VehicleInfo[p][intid]);
									}
									UpdateVehicleParams(p);
									Vstreamcount++;
								}
							}
							else {
							    VehicleInfo[p][spawned] = 1;
					 	   		VehicleInfo[p][idnum] = CreateVehicle(VehicleInfo[p][model], VehicleInfo[p][x_spawn], VehicleInfo[p][y_spawn], VehicleInfo[p][z_spawn], VehicleInfo[p][za_spawn], VehicleInfo[p][color_1], VehicleInfo[p][color_2],20000);
								avstream[VehicleInfo[p][idnum]] = p;
								SetTimerEx("ModVehicle",100,0,"i",p);
								if(VehicleInfo[p][worldid] > 0) {
				    				SetVehicleVirtualWorld(VehicleInfo[p][idnum],VehicleInfo[p][worldid]);
								}
								if(VehicleInfo[p][intid] > 0) {
				    				LinkVehicleToInterior(VehicleInfo[p][idnum],VehicleInfo[p][intid]);
								}
								UpdateVehicleParams(p);
								Vstreamcount++;
							}
						}
				}
			}
    	}
	}
}

stock GetPointSector(Float:x,Float:y)
{
	new xsec = floatround(((x +4000) / 500), floatround_floor);
	new ysec = floatround(((y +4000) / 500), floatround_floor);
	return (xsec * 16) + ysec;
}

public ModVehicle(streamid)
{
	if(VehicleInfo[streamid][mod1] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod1]);}
	}
	if(VehicleInfo[streamid][mod2] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod2]);}
	}
	if(VehicleInfo[streamid][mod3] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod3]);}
	}
	if(VehicleInfo[streamid][mod4] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod4]);}
	}
	if(VehicleInfo[streamid][mod5] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod5]);}
	}
	if(VehicleInfo[streamid][mod6] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod6]);}
	}
	if(VehicleInfo[streamid][mod7] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod7]);}
	}
	if(VehicleInfo[streamid][mod8] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod8]);}
	}
	if(VehicleInfo[streamid][mod9] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod9]);}
	}
	if(VehicleInfo[streamid][mod10] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod10]);}
	}
	if(VehicleInfo[streamid][mod11] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod11]);}
	}
	if(VehicleInfo[streamid][mod12] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod12]);}
	}
	if(VehicleInfo[streamid][mod13] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod13]);}
	}
	if(VehicleInfo[streamid][mod14] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod14]);}
	}
	if(VehicleInfo[streamid][mod15] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod15]);}
	}
	if(VehicleInfo[streamid][mod16] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod16]);}
	}
	if(VehicleInfo[streamid][mod17] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod17]);}
	}
	if(VehicleInfo[streamid][color_1] > -1 || VehicleInfo[streamid][color_2] > -1) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {ChangeVehicleColor(VehicleInfo[streamid][idnum],VehicleInfo[streamid][color_1],VehicleInfo[streamid][color_2]);}
 	}
	if(VehicleInfo[streamid][paintjob] > -1) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {ChangeVehiclePaintjob(VehicleInfo[streamid][idnum],VehicleInfo[streamid][paintjob]);}
 	}
}

public RemoveTempVehicle(vehicleid)
{
	new i = GetVehicleStreamID(vehicleid);
	DestroyVehicle(vehicleid);
	vehused[vehicleid] = 0;
	VehicleInfo[i][limbo] = 0;
	VehicleInfo[i][valid] = 0;
	return 1;
}

public DeathProcess(vehicleid)
{
	new i = GetVehicleStreamID(vehicleid);
	DestroyVehicle(vehicleid);
	VehicleInfo[i][idnum] = CreateVehicle(VehicleInfo[i][model], VehicleInfo[i][x_spawn], VehicleInfo[i][y_spawn], VehicleInfo[i][z_spawn], VehicleInfo[i][za_spawn], VehicleInfo[i][color_1], VehicleInfo[i][color_2],20000);
    avstream[VehicleInfo[i][idnum]] = i;
 	SetTimerEx("ModVehicle",100,0,"i",i);
	vehused[vehicleid] = 0;
	VehicleInfo[i][limbo] = 0;
	return 1;
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

public InitiateSectorSystem()
{
	SetTimer("SectorScan",1000,1);
	SystemSafe = 1;
	return 1;
}

stock UpdateVehicleSectorInfo()
{
    new secnum;
	if(SystemSafe == 1) {
		for(new i = 0;i<MAX_SECTORS;i++) {
		    SectorVehicleCount[i] = 0;
		}
    	for(new i = 1;i<MAX_STREAM_VEHICLES;i++) {
		    if(VehicleInfo[i][valid] == 1) {
				secnum = GetVehicleSpawnSector(i);
				SectorVehicleCount[secnum]++;
				SectorVehicles[secnum][SectorVehicleCount[secnum]] = i;
			}
		}
		return 1;
	}
	return 0;
}

stock CreateStreamVehicle(modelid,Float:x,Float:y,Float:z,Float:a,col1,col2)
{
	for(new i = 1;i<MAX_STREAM_VEHICLES;i++) {
	    if(VehicleInfo[i][valid] == 0) {
			VehicleInfo[i][model] = modelid;
			VehicleInfo[i][x_spawn] = x;
			VehicleInfo[i][y_spawn] = y;
			VehicleInfo[i][z_spawn] = z;
			VehicleInfo[i][za_spawn] = a;
			VehicleInfo[i][color_1] = col1;
			VehicleInfo[i][color_2] = col2;
			VehicleInfo[i][valid] = 1;
			VehicleInfo[i][idnum] = 0;
			VehicleInfo[i][paintjob] = -1;
			VehicleInfo[i][temporary] = 0;
			SectorVehicleCount[GetVehicleSpawnSector(i)]++;
			SectorVehicles[GetVehicleSpawnSector(i)][SectorVehicleCount[GetVehicleSpawnSector(i)]] = i;
			vehcount++;
			return i;
		}
	}
	return 0;
}

stock CreateTempStreamVehicle(modelid,Float:x,Float:y,Float:z,Float:a,col1,col2)
{
	for(new i = 1;i<MAX_STREAM_VEHICLES;i++) {
	    if(VehicleInfo[i][valid] == 0) {
			VehicleInfo[i][model] = modelid;
			VehicleInfo[i][x_spawn] = x;
			VehicleInfo[i][y_spawn] = y;
			VehicleInfo[i][z_spawn] = z;
			VehicleInfo[i][za_spawn] = a;
			VehicleInfo[i][color_1] = col1;
			VehicleInfo[i][color_2] = col2;
			VehicleInfo[i][valid] = 1;
			VehicleInfo[i][idnum] = 0;
			VehicleInfo[i][paintjob] = -1;
			VehicleInfo[i][temporary] = 1;
			SectorVehicleCount[GetVehicleSpawnSector(i)]++;
			SectorVehicles[GetVehicleSpawnSector(i)][SectorVehicleCount[GetVehicleSpawnSector(i)]] = i;
			vehcount++;
			return i;
		}
	}
	return 0;
}

stock SetVehicleStreamPos(vstreamid,Float:x,Float:y,Float:z,Float:a)
{
	if(VehicleInfo[vstreamid][valid] == 1) {
	    VehicleInfo[vstreamid][x_spawn] = x;
	    VehicleInfo[vstreamid][y_spawn] = y;
	    VehicleInfo[vstreamid][z_spawn] = z;
	    VehicleInfo[vstreamid][za_spawn] = a;
	    UpdateVehicleSectorInfo();
	    if(VehicleInfo[vstreamid][spawned] == 1) {
	        SetVehiclePos(VehicleInfo[vstreamid][idnum],x,y,z);
	        SetVehicleZAngle(VehicleInfo[vstreamid][idnum],a);
	    }
	    return 1;
	}
	return 0;
}

stock SetVehicleStreamModel(vstreamid,smodel)
{
	if(VehicleInfo[vstreamid][valid] == 1) {
	    VehicleInfo[vstreamid][model] = smodel;
	    return 1;
	}
	return 0;
}

stock ChangeStreamVehiclePaintjob(vstreamid,paintjobid)
{
    if(VehicleInfo[vstreamid][valid] == 1) {
        VehicleInfo[vstreamid][paintjob] = paintjobid;
        if(VehicleInfo[vstreamid][spawned] == 1) {
            ChangeVehiclePaintjob(VehicleInfo[vstreamid][idnum],paintjobid);
        }
        return 1;
    }
    return 0;
}

stock ChangeStreamVehicleColor(vstreamid,col1,col2)
{
    if(VehicleInfo[vstreamid][valid] == 1) {
        VehicleInfo[vstreamid][color_1] = col1;
        VehicleInfo[vstreamid][color_2] = col2;
        if(VehicleInfo[vstreamid][spawned] == 1) {
            ChangeVehicleColor(VehicleInfo[vstreamid][idnum],col1,col2);
        }
        return 1;
    }
    return 0;
}

stock AddStreamVehicleMod(vstreamid,componentid)
{
	if(VehicleInfo[vstreamid][valid] == 1) {
	    for(new s=0; s<20; s++) {
   			if(componentid == spoiler[s][0]) {
   				VehicleInfo[vstreamid][mod1] = componentid;
   	   		}
		}
		for(new s=0; s<3; s++) {
			if(componentid == nitro[s][0]) {
				VehicleInfo[vstreamid][mod2] = componentid;
    		}
		}
		for(new s=0; s<23; s++) {
			if(componentid == fbumper[s][0]) {
					VehicleInfo[vstreamid][mod3] = componentid;
    		}
		}
		for(new s=0; s<22; s++) {
			if(componentid == rbumper[s][0]) {
				VehicleInfo[vstreamid][mod4] = componentid;
	  		}
		}
		for(new s=0; s<28; s++) {
			if(componentid == exhaust[s][0]) {
				VehicleInfo[vstreamid][mod5] = componentid;
     		}
		}
		for(new s=0; s<2; s++) {
			if(componentid == bventr[s][0]) {
				VehicleInfo[vstreamid][mod6] = componentid;
	   		}
		}
		for(new s=0; s<2; s++) {
			if(componentid == bventl[s][0]) {
				VehicleInfo[vstreamid][mod7] = componentid;
   			}
		}
		for(new s=0; s<4; s++) {
			if(componentid == bscoop[s][0]) {
				VehicleInfo[vstreamid][mod8] = componentid;
			}
		}
		for(new s=0; s<13; s++) {
			if(componentid == rscoop[s][0]) {
				VehicleInfo[vstreamid][mod9] = componentid;
   			}
		}
		for(new s=0; s<21; s++) {
			if(componentid == lskirt[s][0]) {
				VehicleInfo[vstreamid][mod10] = componentid;
    		}
		}
		for(new s=0; s<21; s++) {
			if(componentid == rskirt[s][0]) {
				VehicleInfo[vstreamid][mod11] = componentid;
   			}
		}
		for(new s=0; s<1; s++) {
			if(componentid == hydraulics[s][0]) {
				VehicleInfo[vstreamid][mod12] = componentid;
    		}
		}
		for(new s=0; s<1; s++) {
			if(componentid == base[s][0]) {
				VehicleInfo[vstreamid][mod13] = componentid;
    		}
		}
		for(new s=0; s<2; s++) {
			if(componentid == rbbars[s][0]) {
				VehicleInfo[vstreamid][mod14] = componentid;
     		}
		}
		for(new s=0; s<2; s++) {
			if(componentid == fbbars[s][0]) {
				VehicleInfo[vstreamid][mod15] = componentid;
     		}
		}
		for(new s=0; s<17; s++) {
			if(componentid == wheels[s][0]) {
				VehicleInfo[vstreamid][mod16] = componentid;
    		}
		}
		for(new s=0; s<2; s++) {
			if(componentid == lights[s][0]) {
				VehicleInfo[vstreamid][mod17] = componentid;
	  		}
		}
	    if(VehicleInfo[vstreamid][spawned] == 1) {
	        AddVehicleComponent(VehicleInfo[vstreamid][idnum],componentid);
	    }
	    return 1;
	}
	return 0;
}

stock GetPlayerVehicleStreamID(playerid)
{
	return avstream[GetPlayerVehicleID(playerid)];
}

stock GetVehicleStreamID(vehicleid)
{
	return avstream[vehicleid];
}

stock SetVehicleUsed(vehicleid,bool:toggle)
{
	vehused[vehicleid] = toggle;
	return 1;
}

stock tAxI_OnVehicleDeath(vehicleid)
{
	VehicleInfo[GetVehicleStreamID(vehicleid)][limbo] = 1;
	if(VehicleInfo[GetVehicleStreamID(vehicleid)][temporary] == 1) {
	    SetTimerEx("RemoveTempVehicle",10000,0,"x",vehicleid);
	}
	else {
		SetTimerEx("DeathProcess",10000,0,"x",vehicleid);
	}
}

stock tAxI_OnGameModeInit()
{
    format(Vtext,sizeof(Vtext),"Vehicles = %d / Models = %d",Vstreamcount,CountModels());
    vehicletext = TextDrawCreate(400.0,425,Vtext);
    TextDrawColor(vehicletext,RED);
    TextDrawUseBox(vehicletext, true);
    TextDrawBoxColor(vehicletext, BLUE);
	TextDrawSetShadow(vehicletext, 2);
    SetTimer("InitiateSectorSystem",5000,0);
	return 1;
}

stock tAxI_OnPlayerEnterVehicle(vehicleid)
{
    SetVehicleUsed(vehicleid,true);
	return 1;
}

stock CountModels()
{
	new modelcount = 0;
	new modelcounted[700];
    for(new i = 1;i<MAX_STREAM_VEHICLES;i++) {
        if(VehicleInfo[i][spawned] == 1) {
            if(modelcounted[VehicleInfo[i][model]] == 0) {
                modelcount++;
                modelcounted[VehicleInfo[i][model]] = 1;
            }
        }
    }
    return modelcount;
}

stock IsModelActive(vmodel)
{
    for(new i = 1;i<vehcount;i++) {
        if(VehicleInfo[i][spawned] == 1) {
            if(VehicleInfo[i][model] == vmodel) {
                return 1;
            }
        }
    }
    return 0;
}

stock tAxI_OnVehicleMod(vehicleid,componentid)
{
	if(Automodsave == true) {
	    AddStreamVehicleMod(GetVehicleStreamID(vehicleid),componentid);
	}
	return 1;
}

stock tAxI_OnVehiclePaintjob(vehicleid,paintjobid)
{
	if(Automodsave == true) {
	    ChangeStreamVehiclePaintjob(GetVehicleStreamID(vehicleid),paintjobid);
	}
	return 1;
}

stock tAxI_OnVehicleRespray(vehicleid,color1,color2)
{
	if(Automodsave == true) {
	    ChangeStreamVehicleColor(GetVehicleStreamID(vehicleid),color1,color2);
	}
	return 1;
}

stock ToggleAutoModSave(bool:toggle)
{
    Automodsave = toggle;
}
