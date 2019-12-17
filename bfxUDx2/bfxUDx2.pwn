/*
                         ;             +
       ~.     :o:        o++           oo ~o                   .                  +
    +ooooo+   `oo        +oo         .+oo +o;     +o.          o+           .o:  +oo
   :o.  +oo    oo        ~oo     +ooooooo +o+    oo  ++ooooooooo`     `.~o;  .oo.oo~
    oo +ooo    oo        ooo+    ooo~ +oo.+o+  `oo.   ;ooo+;~.oo   :ooo+  o   ;oooo
    oo+oo+     oo       ~oo:o   +oo~  +o+ +oo `oo      :oo    oo  +ooo.   o+   ooo;
   .oooo+      oo       ooo o;  oo`   +o  +oo~oo ::    :oo    o   oo~     oo   ooo
  .OOOOOOOo   .Oj      `OO: jO  OO    oO  ;OOOOOOOO:   oOO        OO      Oo   OOO:
   `OO   :Oj  jO:      OO+  ~OO jO        ~OOO:  OOo  OOOOOj:     ;O     oO   oOOOO
    OO    jO  OO     ~jOO;ojOOO :O        `OO    OO    jOo`;;      Oo   +Oj   OO  OO
    OO   ;OO. OO   Oo OOOOOOoOO  O;     `  OO    OO    oO;         ~Oo ~OO   .OO   Oo
   ;OOjOOOO   OOOOOo :O     .OO   OO   +O   O+   Oj    :O            oOO:    `O;    O;
    ~ojOo.   .OOO+          ;O.    jOOOO    +O   O.     O                     O     oj
                            j                    O
                                                .
    .....     ~~.           ~.     .~~~     .~  .~      .                      .
   .~~~~~~`  `~~~~~. ``     `~.   ~~. .~.   ~.  .~.    `~             ``.     ~~    ~~
   .~~ .~~~~  ~...~~. ~~~....~~  ~~     ~  `~    ~~    ~~           `~`~~`    ~~   .~.
    ~~    ~~  ~~   `..~~~~~~~~~  ~        .~~    ~~    ~~.         .~.  ~~.   ~~   ~.
   .~~   .~`  `~.      ~~.  .~~ `~        .~~`.  ~~.  `~~~~`.     .~     .~   .~``~.
   ```````.   .`.      .``. ``  ``    .`  .````````.   ```        ``      `.   ```.
    .....      ..       ... ..  ..    ..  ...... ..    ...    .   ...     ..   ...
    ......     ..       .....   ...   ... ... ...      ...    ..  ....    ..   ....
    .. ....    ..        ....    ...  ... ...  ...    ......  ..   .....  .    ....
   ..   ...    ..        ...     ........ ...    ..  ...........         ..   .. ..
   ........    ..         ..       ...... ...     ..   ..     ...      .     ..  ...
      ....    ...        ...           .. ..                   .                  ..
	   ________________________________________________
	  / BlackFoX's Ultimate Car Owner ship Version 7.2 \
      \________________________________________________/ */
      
/*
This is a Simple Vehicle Owner Ship, that Save all Vehicles in dini and Load it again

---------------[COMMANDS]----------------

/newbuycar [carid] [color1] [color2] [Price]
/sellveh [Price] - sell Your vehicles
/buyveh - to Buy the Specific Vehicle
/removeveh - Delete Vehicle (You must sit in the Specific Vehicle)
/exits - to Exit Buy Vehicle
*/
#include <a_samp>
#include <dini>
#define ORANGE 0xF67900F6
#define WHITE 0xF6F6F6F6
#define GREEN 0x00D400F6
#define YELLOW 0xECD400F6
#define MAX_BUY_V 200
enum Auto
{
	model,
	Float:x,Float:y,Float:z,
	Farbe1,Farbe2,Float:a,owner[128],preis,paintjob,mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10,
	mod11,mod12,mod13,mod14,mod15,mod16,mod17,
}
new VehicleSystem[MAX_BUY_V][Auto];
new IDIS[MAX_VEHICLES];
new created;
/* WICHTIG FUERS SAVEN */
forward SaveTool();
/* TUNING PARTS */
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
forward Tunen(vehicleid);
/**/
#define FILTERSCRIPT

#if defined FILTERSCRIPT
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" -= BlackFoX's Vehicle Owner Ship v7 =- ");
	print("--------------------------------------\n");
	print("Loading...\n");
	if(!dini_Exists("cars.cfg")){
	dini_Create("cars.cfg");}
	new loader[128];
	for(new i = 0;i<MAX_BUY_V;i++)
	{
	format(loader,sizeof(loader),"veh_model_%d",i);
	VehicleSystem[i][model] = dini_Int("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_x_%d",i);
	VehicleSystem[i][x] = dini_Float("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_y_%d",i);
	VehicleSystem[i][y] = dini_Float("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_z_%d",i);
	VehicleSystem[i][z] = dini_Float("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_Farbe1_%d",i);
	VehicleSystem[i][Farbe1] = dini_Int("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_Farbe2_%d",i);
	VehicleSystem[i][Farbe2] = dini_Int("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_a_%d",i);
	VehicleSystem[i][a] = dini_Float("cars.cfg",loader);
 	format(loader,sizeof(loader),"veh_owner_%d",i);
 	strmid(VehicleSystem[i][owner],dini_Get("cars.cfg",loader),0,128,128);
	format(loader,sizeof(loader),"veh_preis_%d",i);
	VehicleSystem[i][preis] = dini_Int("cars.cfg",loader);
	//
	format(loader,sizeof(loader),"veh_mod1_%d",i);
	VehicleSystem[i][mod1] = dini_Int("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_mod2_%d",i);
	VehicleSystem[i][mod2] = dini_Int("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_mod3_%d",i);
	VehicleSystem[i][mod3] = dini_Int("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_mod4_%d",i);
	VehicleSystem[i][mod4] = dini_Int("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_mod5_%d",i);
	VehicleSystem[i][mod5] = dini_Int("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_mod6_%d",i);
	VehicleSystem[i][mod6] = dini_Int("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_mod7_%d",i);
	VehicleSystem[i][mod7] = dini_Int("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_mod8_%d",i);
	VehicleSystem[i][mod8] = dini_Int("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_mod9_%d",i);
	VehicleSystem[i][mod9] = dini_Int("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_mod10_%d",i);
	VehicleSystem[i][mod10] = dini_Int("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_mod11_%d",i);
	VehicleSystem[i][mod11] = dini_Int("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_mod12_%d",i);
	VehicleSystem[i][mod12] = dini_Int("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_mod13_%d",i);
	VehicleSystem[i][mod13] = dini_Int("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_mod14_%d",i);
	VehicleSystem[i][mod14] = dini_Int("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_mod15_%d",i);
	VehicleSystem[i][mod15] = dini_Int("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_mod16_%d",i);
	VehicleSystem[i][mod16] = dini_Int("cars.cfg",loader);
	format(loader,sizeof(loader),"veh_mod17_%d",i);
	VehicleSystem[i][mod17] = dini_Int("cars.cfg",loader);
	//
	format(loader,sizeof(loader),"veh_paint_%d",i);
	VehicleSystem[i][paintjob] = dini_Int("cars.cfg",loader);
	//
 	if(VehicleSystem[i][model]!=0){
 	created++;
 	new car = CreateVehicle(VehicleSystem[i][model],VehicleSystem[i][x],VehicleSystem[i][y],VehicleSystem[i][z],VehicleSystem[i][a],VehicleSystem[i][Farbe1],VehicleSystem[i][Farbe2],600000);
 	Tunen(car);
 	IDIS[car] = created;
 	}
	}
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
}

#endif

public OnGameModeInit()
{
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	if(GetCreatorID(vehicleid)!=0)
	{
	new create = GetCreatorID(vehicleid);
	DestroyVehicle(vehicleid);
	new CAR = CreateVehicle(VehicleSystem[create][model],VehicleSystem[create][x],VehicleSystem[create][y],VehicleSystem[create][z],VehicleSystem[create][a],VehicleSystem[create][Farbe1],VehicleSystem[create][Farbe2],600000);
	Tunen(CAR);
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerPrivmsg(playerid, recieverid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[128],tmp[128],idx;
	cmd = strtok(cmdtext,idx);
	new vehicleid = GetPlayerVehicleID(playerid);
	if (strcmp(cmd, "/removeveh", true) ==0 )
	{
	if(!IsPlayerInAnyVehicle(playerid)){return 1;}
	if(!IsPlayerAdmin(playerid)){return 1;}
	VehicleSystem[GetCreatorID(vehicleid)][model]=0;
	VehicleSystem[GetCreatorID(vehicleid)][x]=(0.0);
	VehicleSystem[GetCreatorID(vehicleid)][y]=(0.0);
	VehicleSystem[GetCreatorID(vehicleid)][z]=(0.0);
	VehicleSystem[GetCreatorID(vehicleid)][Farbe1]=0;
	VehicleSystem[GetCreatorID(vehicleid)][Farbe2]=0;
	VehicleSystem[GetCreatorID(vehicleid)][preis]=0;
	VehicleSystem[GetCreatorID(vehicleid)][mod1]=0;
	VehicleSystem[GetCreatorID(vehicleid)][mod2]=0;
	VehicleSystem[GetCreatorID(vehicleid)][mod3]=0;
	VehicleSystem[GetCreatorID(vehicleid)][mod4]=0;
	VehicleSystem[GetCreatorID(vehicleid)][mod5]=0;
	VehicleSystem[GetCreatorID(vehicleid)][mod6]=0;
	VehicleSystem[GetCreatorID(vehicleid)][mod7]=0;
	VehicleSystem[GetCreatorID(vehicleid)][mod8]=0;
	VehicleSystem[GetCreatorID(vehicleid)][mod9]=0;
	VehicleSystem[GetCreatorID(vehicleid)][mod10]=0;
	VehicleSystem[GetCreatorID(vehicleid)][mod11]=0;
	VehicleSystem[GetCreatorID(vehicleid)][mod12]=0;
	VehicleSystem[GetCreatorID(vehicleid)][mod13]=0;
	VehicleSystem[GetCreatorID(vehicleid)][mod14]=0;
	VehicleSystem[GetCreatorID(vehicleid)][mod15]=0;
	VehicleSystem[GetCreatorID(vehicleid)][mod16]=0;
	VehicleSystem[GetCreatorID(vehicleid)][mod17]=0;
	VehicleSystem[GetCreatorID(vehicleid)][paintjob]=0;
	strmid(VehicleSystem[GetCreatorID(vehicleid)][owner],"",0,128,128);
	IDIS[vehicleid]=0;
	DestroyVehicle(vehicleid);
	SaveTool();
	return 1;
	}
	if (strcmp(cmd, "/newbuycar", true) ==0 )
	{
	if(!IsPlayerAdmin(playerid)){return 1;}
	tmp = strtok(cmdtext,idx);
	if(!strlen(tmp)){return 1;}
	new vehiclemodel = strval(tmp);
	tmp = strtok(cmdtext,idx);
	if(!strlen(tmp)){return 1;}
	new color1 = strval(tmp);
	tmp = strtok(cmdtext,idx);
	if(!strlen(tmp)){return 1;}
	new color2 = strval(tmp);
	tmp = strtok(cmdtext,idx);
	if(!strlen(tmp)){return 1;}
	new price = strval(tmp);
	new Float:px,Float:py,Float:pz,Float:pa;
	GetPlayerPos(playerid,px,py,pz);
	GetPlayerFacingAngle(playerid,pa);
	created++;
	VehicleSystem[created][model]=vehiclemodel;
	VehicleSystem[created][x]=px;
	VehicleSystem[created][y]=py;
	VehicleSystem[created][z]=pz;
	VehicleSystem[created][a]=pa;
	VehicleSystem[created][Farbe1]=color1;
	VehicleSystem[created][Farbe2]=color2;
	VehicleSystem[created][preis]=price;
	strmid(VehicleSystem[created][owner],"dealercar",0,128,128);
	new ccar = CreateVehicle(VehicleSystem[created][model],VehicleSystem[created][x],VehicleSystem[created][y],VehicleSystem[created][z],VehicleSystem[created][a],VehicleSystem[created][Farbe1],VehicleSystem[created][Farbe2],600000);
	IDIS[ccar]=created;
	SaveTool();
	return 1;
	}
	if (strcmp(cmd, "/buyveh", true) ==0 )
	{
	if(!IsPlayerInAnyVehicle(playerid)){return 1;}
	if(GetCreatorID(vehicleid)!=0)
	{
	if (strmatch(VehicleSystem[GetCreatorID(vehicleid)][owner],Spielername(playerid))){SendClientMessage(playerid,WHITE," Dieses Auto gehoert dir schon!");return 1;}
	if (strmatch(VehicleSystem[GetCreatorID(vehicleid)][owner],"dealercar"))
	{
	if(VehicleSystem[GetCreatorID(vehicleid)][preis] < GetPlayerMoney(playerid))
	{
	strmid(VehicleSystem[GetCreatorID(vehicleid)][owner],Spielername(playerid),0,128,128);
	GivePlayerMoney(playerid,-VehicleSystem[GetCreatorID(vehicleid)][preis]);
	SendClientMessage(playerid,YELLOW," Have Fun with your New Car!");
	TogglePlayerControllable(playerid,1);
	SaveTool();
	}
	else
	{
	SendClientMessage(playerid,WHITE,"You need more Cash!");
	}
	}
	else
	{
	SendClientMessage(playerid,WHITE,"This Vehicle isnt For Sale!");
	}
	}
	else
	{
	SendClientMessage(playerid,WHITE,"Isnt a Buy Vehicle!");
	}
	return 1;
	}
	if (strcmp(cmd, "/sellveh", true) ==0 )
	{
	if(!IsPlayerInAnyVehicle(playerid)){return 1;}
	if(GetCreatorID(vehicleid)!=0)
	{
	if (strmatch(VehicleSystem[GetCreatorID(vehicleid)][owner],Spielername(playerid)))
	{
	tmp = strtok(cmdtext,idx);
	if(!strlen(tmp)){SendClientMessage(playerid,WHITE,"INFO: /sellveh [Price]");return 1;}
	new Float:vx,Float:vy,Float:vz,Float:va;
	GetVehiclePos(GetPlayerVehicleID(playerid),vx,vy,vz);
	GetVehicleZAngle(GetPlayerVehicleID(playerid),va);
	VehicleSystem[GetCreatorID(vehicleid)][x]=vx;
	VehicleSystem[GetCreatorID(vehicleid)][y]=vy;
	VehicleSystem[GetCreatorID(vehicleid)][z]=vz;
	VehicleSystem[GetCreatorID(vehicleid)][a]=va;
	VehicleSystem[GetCreatorID(vehicleid)][preis]=strval(tmp);
	strmid(VehicleSystem[GetCreatorID(vehicleid)][owner],"dealercar",0,128,128);
	SendClientMessage(playerid,WHITE,"This vehicle is now for Sale!");
	GivePlayerMoney(playerid,strval(tmp));
	SaveTool();
	}
	else
	{
	SendClientMessage(playerid,WHITE,"This Vehicle isnt yours!");
	}
	}
	return 1;
	}
	if (strcmp(cmd, "/park", true) ==0 )
	{
	if(!IsPlayerInAnyVehicle(playerid)){return 1;}
	if(GetCreatorID(vehicleid)!=0)
	{
	if (strmatch(VehicleSystem[GetCreatorID(vehicleid)][owner],Spielername(playerid)))
	{
	new Float:vx,Float:vy,Float:vz,Float:va;
	GetVehiclePos(GetPlayerVehicleID(playerid),vx,vy,vz);
	GetVehicleZAngle(GetPlayerVehicleID(playerid),va);
	VehicleSystem[GetCreatorID(vehicleid)][x]=vx;
	VehicleSystem[GetCreatorID(vehicleid)][y]=vy;
	VehicleSystem[GetCreatorID(vehicleid)][z]=vz;
	VehicleSystem[GetCreatorID(vehicleid)][a]=va;
	SendClientMessage(playerid,WHITE,"Your Vehicle was Parked here!");
	SendClientMessage(playerid,YELLOW,"Vehicle will Respawn here!");
	SaveTool();
	}
	}
	return 1;
	}
	if (strcmp(cmd, "/apark", true) ==0 )
	{
	if(!IsPlayerInAnyVehicle(playerid)){return 1;}
	if(GetCreatorID(vehicleid)!=0)
	{
	new Float:vx,Float:vy,Float:vz,Float:va;
	GetVehiclePos(GetPlayerVehicleID(playerid),vx,vy,vz);
	GetVehicleZAngle(GetPlayerVehicleID(playerid),va);
	VehicleSystem[GetCreatorID(vehicleid)][x]=vx;
	VehicleSystem[GetCreatorID(vehicleid)][y]=vy;
	VehicleSystem[GetCreatorID(vehicleid)][z]=vz;
	VehicleSystem[GetCreatorID(vehicleid)][a]=va;
	SendClientMessage(playerid,WHITE,"Admin Park!");
	SaveTool();
	}
	else
	{
	SendClientMessage(playerid,WHITE," You cant Park this Vehicle!");
	}
	return 1;
	}
	if (strcmp(cmd, "/exits", true) ==0 )
	{
	if(!IsPlayerInAnyVehicle(playerid)){return 1;}
	if(GetCreatorID(vehicleid)!=0)
	{
	RemovePlayerFromVehicle(playerid);
	}
	return 1;
	}
	return 0;
}

public OnPlayerInfoChange(playerid)
{
	return 1;
}
stock Spielername(playerid)
{
new spname[128];
GetPlayerName(playerid,spname,sizeof(spname));
return spname;
}
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{

	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == 2)
	{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(GetCreatorID(vehicleid)!=0)
	{
	Tunen(vehicleid);
    if (strmatch(VehicleSystem[GetCreatorID(vehicleid)][owner],Spielername(playerid)))
    {
	SendClientMessage(playerid,GREEN," Wellcome Back...");
    }
    else if(strmatch(VehicleSystem[GetCreatorID(vehicleid)][owner],"dealercar"))
    {
    if(!IsPlayerAdmin(playerid)){
    TogglePlayerControllable(playerid,0);}
    new fffx[128];
    format(fffx,sizeof(fffx),"This Vehicle is for Sale. Price %d$",VehicleSystem[GetCreatorID(vehicleid)][preis]);
    SendClientMessage(playerid,WHITE,fffx);
    SendClientMessage(playerid,YELLOW,"Use /buyveh to Buy it.");
    }
    else
    {
    TogglePlayerControllable(playerid,0);
    TogglePlayerControllable(playerid,1);
    new ex[128];
    format(ex,sizeof(ex),"This Vehicle have a Owner: %s",VehicleSystem[GetCreatorID(vehicleid)][owner]);
    SendClientMessage(playerid,YELLOW,ex);
    RemovePlayerFromVehicle(playerid);
    }
    }
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}
stock GetCreatorID(vehicleid)
{
return IDIS[vehicleid];
}
stock strmatch(const String1[], const String2[])
{
	if ((strcmp(String1, String2, true, strlen(String2)) == 0) && (strlen(String2) == strlen(String1)))
	{
	return true;
	}
	else
	{
	return false;
	}
}
/* TUNING */
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
	    if(lights[i][0]==componentid) { return 17; }
	}
	return 0;
}
public OnVehiclePaintjob(playerid,vehicleid, paintjobid)
{
if(GetCreatorID(vehicleid)!=0)
{
VehicleSystem[GetCreatorID(vehicleid)][paintjob] =paintjobid;
}
return 1;
}
public OnVehicleRespray(playerid,vehicleid, color1, color2)
{
if(GetCreatorID(vehicleid)!=0)
{
VehicleSystem[GetCreatorID(vehicleid)][Farbe1] =color1;
VehicleSystem[GetCreatorID(vehicleid)][Farbe2] =color2;
}
return 1;
}
public OnVehicleMod(playerid,vehicleid,componentid)
{
if(GetCreatorID(vehicleid)!=0)
{
new Varz=InitComponents(componentid);
switch (Varz)
{
case 1: { VehicleSystem[GetCreatorID(vehicleid)][mod1] = componentid;}
case 2: { VehicleSystem[GetCreatorID(vehicleid)][mod2] = componentid; }
case 3: { VehicleSystem[GetCreatorID(vehicleid)][mod3] = componentid; }
case 4: { VehicleSystem[GetCreatorID(vehicleid)][mod4] = componentid; }
case 5: { VehicleSystem[GetCreatorID(vehicleid)][mod5] = componentid; }
case 6: { VehicleSystem[GetCreatorID(vehicleid)][mod6] = componentid; }
case 7: { VehicleSystem[GetCreatorID(vehicleid)][mod7] = componentid; }
case 8: { VehicleSystem[GetCreatorID(vehicleid)][mod8] = componentid;}
case 9: { VehicleSystem[GetCreatorID(vehicleid)][mod9] = componentid; }
case 10: { VehicleSystem[GetCreatorID(vehicleid)][mod10] = componentid; }
case 11: { VehicleSystem[GetCreatorID(vehicleid)][mod11] = componentid; }
case 12: { VehicleSystem[GetCreatorID(vehicleid)][mod12] = componentid; }
case 13: { VehicleSystem[GetCreatorID(vehicleid)][mod13] = componentid; }
case 14: { VehicleSystem[GetCreatorID(vehicleid)][mod14] = componentid; }
case 15: { VehicleSystem[GetCreatorID(vehicleid)][mod15] = componentid; }
case 16: { VehicleSystem[GetCreatorID(vehicleid)][mod16] = componentid; }
case 17: { VehicleSystem[GetCreatorID(vehicleid)][mod17] = componentid; }
}
}
printf("componentid Added: %d",componentid);
return 1;
}
public Tunen(vehicleid)
{
if(GetCreatorID(vehicleid)!=0)
{
        new tempmod;
        tempmod = VehicleSystem[GetCreatorID(vehicleid)][mod1];
		if(tempmod!=0) { AddVehicleComponent(vehicleid,tempmod); }
		tempmod = VehicleSystem[GetCreatorID(vehicleid)][mod2];
		if(tempmod!=0) { AddVehicleComponent(vehicleid,tempmod); }
		tempmod = VehicleSystem[GetCreatorID(vehicleid)][mod3];
		if(tempmod!=0) { AddVehicleComponent(vehicleid,tempmod); }
		tempmod = VehicleSystem[GetCreatorID(vehicleid)][mod4];
		if(tempmod!=0) { AddVehicleComponent(vehicleid,tempmod); }
		tempmod = VehicleSystem[GetCreatorID(vehicleid)][mod5];
		if(tempmod!=0) { AddVehicleComponent(vehicleid,tempmod); }
		tempmod = VehicleSystem[GetCreatorID(vehicleid)][mod6];
		if(tempmod!=0) { AddVehicleComponent(vehicleid,tempmod); }
		tempmod = VehicleSystem[GetCreatorID(vehicleid)][mod7];
		if(tempmod!=0) { AddVehicleComponent(vehicleid,tempmod); }
		tempmod = VehicleSystem[GetCreatorID(vehicleid)][mod8];
		if(tempmod!=0) { AddVehicleComponent(vehicleid,tempmod); }
		tempmod = VehicleSystem[GetCreatorID(vehicleid)][mod9];
		if(tempmod!=0) { AddVehicleComponent(vehicleid,tempmod); }
		tempmod = VehicleSystem[GetCreatorID(vehicleid)][mod10];
		if(tempmod!=0) { AddVehicleComponent(vehicleid,tempmod); }
		tempmod = VehicleSystem[GetCreatorID(vehicleid)][mod11];
		if(tempmod!=0) { AddVehicleComponent(vehicleid,tempmod); }
		tempmod = VehicleSystem[GetCreatorID(vehicleid)][mod12];
		if(tempmod!=0) { AddVehicleComponent(vehicleid,tempmod); }
		tempmod = VehicleSystem[GetCreatorID(vehicleid)][mod13];
		if(tempmod!=0) { AddVehicleComponent(vehicleid,tempmod); }
		tempmod = VehicleSystem[GetCreatorID(vehicleid)][mod14];
		if(tempmod!=0) { AddVehicleComponent(vehicleid,tempmod); }
		tempmod = VehicleSystem[GetCreatorID(vehicleid)][mod15];
		if(tempmod!=0) { AddVehicleComponent(vehicleid,tempmod); }
		tempmod = VehicleSystem[GetCreatorID(vehicleid)][mod16];
		if(tempmod!=0) { AddVehicleComponent(vehicleid,tempmod); }
		tempmod = VehicleSystem[GetCreatorID(vehicleid)][mod17];
		if(tempmod!=0) { AddVehicleComponent(vehicleid,tempmod); }
		tempmod = VehicleSystem[GetCreatorID(vehicleid)][paintjob];
		if(tempmod!=0) { ChangeVehiclePaintjob(vehicleid,tempmod); }
}
return 1;
}
/* STRTOK

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
*/
public SaveTool()
{
	new count;
	new saver[128];
	fremove("cars.cfg");
	dini_Create("cars.cfg");
	for(new i = 0;i<MAX_BUY_V;i++)
	{
	if(VehicleSystem[i][model]!=0)
	{
	count++;
    format(saver,sizeof(saver),"veh_model_%d",count);
    dini_IntSet("cars.cfg",saver,VehicleSystem[i][model]);
    format(saver,sizeof(saver),"veh_x_%d",count);
    dini_FloatSet("cars.cfg",saver,VehicleSystem[i][x]);
    format(saver,sizeof(saver),"veh_y_%d",count);
    dini_FloatSet("cars.cfg",saver,VehicleSystem[i][y]);
    format(saver,sizeof(saver),"veh_z_%d",count);
    dini_FloatSet("cars.cfg",saver,VehicleSystem[i][z]);
    format(saver,sizeof(saver),"veh_a_%d",count);
    dini_FloatSet("cars.cfg",saver,VehicleSystem[i][a]);
    format(saver,sizeof(saver),"veh_Farbe1_%d",count);
    dini_IntSet("cars.cfg",saver,VehicleSystem[i][Farbe1]);
    format(saver,sizeof(saver),"veh_Farbe2_%d",count);
    dini_IntSet("cars.cfg",saver,VehicleSystem[i][Farbe2]);
    format(saver,sizeof(saver),"veh_owner_%d",count);
    dini_Set("cars.cfg",saver,VehicleSystem[i][owner]);
    format(saver,sizeof(saver),"veh_preis_%d",count);
    dini_IntSet("cars.cfg",saver,VehicleSystem[i][preis]);
    //
	format(saver,sizeof(saver),"veh_mod1_%d",count);
	dini_IntSet("cars.cfg",saver,VehicleSystem[i][mod1]);
	format(saver,sizeof(saver),"veh_mod2_%d",count);
	dini_IntSet("cars.cfg",saver,VehicleSystem[i][mod2]);
	format(saver,sizeof(saver),"veh_mod3_%d",count);
	dini_IntSet("cars.cfg",saver,VehicleSystem[i][mod3]);
	format(saver,sizeof(saver),"veh_mod4_%d",count);
	dini_IntSet("cars.cfg",saver,VehicleSystem[i][mod4]);
	format(saver,sizeof(saver),"veh_mod5_%d",count);
	dini_IntSet("cars.cfg",saver,VehicleSystem[i][mod5]);
	format(saver,sizeof(saver),"veh_mod6_%d",count);
	dini_IntSet("cars.cfg",saver,VehicleSystem[i][mod6]);
	format(saver,sizeof(saver),"veh_mod7_%d",count);
	dini_IntSet("cars.cfg",saver,VehicleSystem[i][mod7]);
	format(saver,sizeof(saver),"veh_mod8_%d",count);
	dini_IntSet("cars.cfg",saver,VehicleSystem[i][mod8]);
	format(saver,sizeof(saver),"veh_mod9_%d",count);
	dini_IntSet("cars.cfg",saver,VehicleSystem[i][mod9]);
	format(saver,sizeof(saver),"veh_mod10_%d",count);
	dini_IntSet("cars.cfg",saver,VehicleSystem[i][mod10]);
	format(saver,sizeof(saver),"veh_mod11_%d",count);
	dini_IntSet("cars.cfg",saver,VehicleSystem[i][mod11]);
	format(saver,sizeof(saver),"veh_mod12_%d",count);
	dini_IntSet("cars.cfg",saver,VehicleSystem[i][mod12]);
	format(saver,sizeof(saver),"veh_mod13_%d",count);
	dini_IntSet("cars.cfg",saver,VehicleSystem[i][mod13]);
	format(saver,sizeof(saver),"veh_mod14_%d",count);
	dini_IntSet("cars.cfg",saver,VehicleSystem[i][mod14]);
	format(saver,sizeof(saver),"veh_mod15_%d",count);
	dini_IntSet("cars.cfg",saver,VehicleSystem[i][mod15]);
	format(saver,sizeof(saver),"veh_mod16_%d",count);
	dini_IntSet("cars.cfg",saver,VehicleSystem[i][mod16]);
	format(saver,sizeof(saver),"veh_mod17_%d",count);
	dini_IntSet("cars.cfg",saver,VehicleSystem[i][mod17]);
	//
	format(saver,sizeof(saver),"veh_paint_%d",count);
	dini_IntSet("cars.cfg",saver,VehicleSystem[i][paintjob]);
	}
	}
	return 1;
}
