// Cali-Cars: by California
// Please do not claim this as your own.
#include <a_samp>
#include <dini>
enum car_info{
	Model,
	Price,
	Float:CarX,
	Float:CarY,
	Float:CarZ,
	Float:CarRot,
	Locked,
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
	colora,
	colorb
};
new VehicleInfo[MAX_PLAYERS][car_info];
new DealerCars[8];
new Text3D:DealerCar[8];
new Vehicle[MAX_PLAYERS];
new OwnerID[MAX_VEHICLES];
new CarPrice[MAX_VEHICLES];
new VehOwned[MAX_VEHICLES];
new ConfirmSale[MAX_PLAYERS];
new gVehLocked[MAX_VEHICLES];
new VehPlate[MAX_VEHICLES][256];
new gPlayerHasCar[MAX_PLAYERS];
new IsADealerCar[MAX_VEHICLES];
new Checkpoint[MAX_PLAYERS];
new bool:Destroyed[MAX_VEHICLES];
enum trunk_info{
	Slot1,
	Slot2,
	Slot3,
	Slot4,
	Slot5,
	Slot6,
	Slot7,
	Slot8,
	Slot9,
	Slot10,
	Ammo1,
	Ammo2,
	Ammo3,
	Ammo4,
	Ammo5,
	Ammo6,
	Ammo7,
	Ammo8,
	Ammo9,
	Ammo10
};
new TrunkInfo[MAX_VEHICLES][trunk_info];
new TrunkOpen[MAX_VEHICLES];
forward RemovePlayerWeapon(playerid, weaponid);
forward ini_GetKey(line[]);
forward ini_GetValue(line[]);
forward SaveTrunk(playerid);
forward LoadTrunk(playerid);
stock ini_GetKey(line[]){
	new keyRes[256];
	keyRes[0] = 0;
    if(strfind(line, "=", true) == -1) return keyRes;
    strmid(keyRes, line, 0, strfind(line, "=", true), sizeof(keyRes));
    return keyRes;
}
stock ini_GetValue(line[]){
	new valRes[256];
	valRes[0] = 0;
	if(strfind(line, "=", true) == -1) return valRes;
	strmid(valRes, line, strfind(line, "=", true) + 1, strlen(line), sizeof(valRes));
	return valRes;
}
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

InitComponents(componentid){
	new i;
	for(i=0; i<20; i++){
	    if(spoiler[i][0]==componentid) { return 1; }
	}
	for(i=0; i<3; i++){
	    if(nitro[i][0]==componentid) { return 2; }
	}
	for(i=0; i<23; i++){
	    if(fbumper[i][0]==componentid) { return 3; }
	}
	for(i=0; i<22; i++){
	    if(rbumper[i][0]==componentid) { return 4; }
	}
	for(i=0; i<28; i++){
	    if(exhaust[i][0]==componentid) { return 5; }
	}
	for(i=0; i<2; i++){
	    if(bventr[i][0]==componentid) { return 6; }
	}
	for(i=0; i<2; i++){
	    if(bventl[i][0]==componentid) { return 7; }
	}
	for(i=0; i<4; i++){
	    if(bscoop[i][0]==componentid) { return 8; }
	}
	for(i=0; i<13; i++){
	    if(rscoop[i][0]==componentid) { return 9; }
	}
	for(i=0; i<21; i++){
	    if(lskirt[i][0]==componentid) { return 10; }
	}
	for(i=0; i<21; i++){
	    if(rskirt[i][0]==componentid) { return 11; }
	}
	if(hydraulics[0][0]==componentid) { return 12; }
	if(base[0][0]==componentid) { return 13; }
	for(i=0; i<2; i++){
	    if(rbbars[i][0]==componentid) { return 14; }
	}
	for(i=0; i<2; i++){
	    if(fbbars[i][0]==componentid) { return 15; }
	}
	for(i=0; i<17; i++){
	    if(wheels[i][0]==componentid) { return 16; }
	}
	for(i=0; i<2; i++){
	    if(light[i][0]==componentid) { return 17; }
	}
	return 0;
}
stock GetVehicleNameFromID(vehicleid){
    static const scVehicleNames[][18] = {
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
        "Mr Whoopee",
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
        "Trailer 1",
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
        "Trailer 2",
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
        "Quad",
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
        "Boxville",
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
        "Cropdust",
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
        "Firetruck LA",
        "Hustler",
        "Intruder",
        "Primo",
        "Cargobob",
        "Tampa",
        "Sunrise",
        "Merit",
        "Utility",
        "Nevada",
        "Yosemite",
        "Windsor",
        "Monster A",
        "Monster B",
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
        "Duneride",
        "Sweeper",
        "Broadway",
        "Tornado",
        "AT-400",
        "DFT-30",
        "Huntley",
        "Stafford",
        "BF-400",
        "Newsvan",
        "Tug",
        "Trailer 3",
        "Emperor",
        "Wayfarer",
        "Euros",
        "Hotdog",
        "Club",
        "Freight Carriage",
        "Trailer 3",
        "Andromada",
        "Dodo",
        "RC Cam",
        "Launch",
        "LS Police Car",
        "SF Police Car",
        "LV Police Car",
        "Police Ranger",
        "Picador",
        "S.W.A.T. Van",
        "Alpha",
        "Phoenix",
        "Glendale",
        "Sadler",
        "Luggage Trailer A",
        "Luggage Trailer B",
        "Stair Trailer",
        "Boxville",
        "Farm Plow",
        "Utility Trailer"
    },
    scOnFoot[18] = "OnFoot";
    if (vehicleid > 0) {
        return scVehicleNames[GetVehicleModel(vehicleid) - 400];
    }
    else {
        return scOnFoot;
    }
}
public OnFilterScriptInit(){
    new string[32], string2[32], string3[32], string4[32], string5[32], string6[32], string7[32], string8[32];
    DealerCars[0] = AddStaticVehicle(546,2135.7805,-1147.6683,24.2358,45.7344,1,1); // Intruder
	DealerCars[1] = AddStaticVehicle(547,2136.1267,-1142.5652,24.8062,48.5747,1,1); // Primo
	DealerCars[2] = AddStaticVehicle(550,2136.2810,-1137.8374,25.3877,49.0252,1,1); // Sunrise
	DealerCars[3] = AddStaticVehicle(551,2136.1887,-1132.9510,25.4904,50.6219,1,1); // Merit
	DealerCars[4] = AddStaticVehicle(554,2120.1875,-1122.7693,25.4782,236.7405,1,1); // Yosemite
	DealerCars[5] = AddStaticVehicle(561,2119.2405,-1127.4752,25.1522,235.1129,1,1); // Stratum
	DealerCars[6] = AddStaticVehicle(585,2119.3145,-1132.3177,24.8819,236.2470,1,1); // Emperor
	DealerCars[7] = AddStaticVehicle(579,2119.3181,-1136.4448,25.1078,231.7601,1,1); // Huntley
	IsADealerCar[DealerCars[0]] = true;
	IsADealerCar[DealerCars[1]] = true;
	IsADealerCar[DealerCars[2]] = true;
	IsADealerCar[DealerCars[3]] = true;
	IsADealerCar[DealerCars[4]] = true;
	IsADealerCar[DealerCars[5]] = true;
	IsADealerCar[DealerCars[6]] = true;
	IsADealerCar[DealerCars[7]] = true;
	CarPrice[DealerCars[0]] = 15000;
	CarPrice[DealerCars[1]] = 20000;
	CarPrice[DealerCars[2]] = 22500;
	CarPrice[DealerCars[3]] = 23500;
	CarPrice[DealerCars[4]] = 10000;
	CarPrice[DealerCars[5]] = 9000;
	CarPrice[DealerCars[6]] = 11500;
	CarPrice[DealerCars[7]] = 26500;
	format(string, sizeof(string), "Name: %s\nPrice: $%i", GetVehicleNameFromID(DealerCars[0]), CarPrice[DealerCars[0]]);
	format(string2, sizeof(string2), "Name: %s\nPrice: $%i", GetVehicleNameFromID(DealerCars[1]), CarPrice[DealerCars[1]]);
	format(string3, sizeof(string3), "Name: %s\nPrice: $%i", GetVehicleNameFromID(DealerCars[2]), CarPrice[DealerCars[2]]);
	format(string4, sizeof(string4), "Name: %s\nPrice: $%i", GetVehicleNameFromID(DealerCars[3]), CarPrice[DealerCars[3]]);
	format(string5, sizeof(string5), "Name: %s\nPrice: $%i", GetVehicleNameFromID(DealerCars[4]), CarPrice[DealerCars[4]]);
	format(string6, sizeof(string6), "Name: %s\nPrice: $%i", GetVehicleNameFromID(DealerCars[5]), CarPrice[DealerCars[5]]);
	format(string7, sizeof(string7), "Name: %s\nPrice: $%i", GetVehicleNameFromID(DealerCars[6]), CarPrice[DealerCars[6]]);
	format(string8, sizeof(string8), "Name: %s\nPrice: $%i", GetVehicleNameFromID(DealerCars[7]), CarPrice[DealerCars[7]]);
	DealerCar[0] = Create3DTextLabel(string, 0x33CCFFAA, 2135.7805,-1147.6683,24.2358, 20.0, 0);
	DealerCar[1] = Create3DTextLabel(string2, 0x33CCFFAA, 2136.1267,-1142.5652,24.8062, 20.0, 0);
	DealerCar[2] = Create3DTextLabel(string3, 0x33CCFFAA, 2136.2810,-1137.8374,25.3877, 20.0, 0);
	DealerCar[3] = Create3DTextLabel(string4, 0x33CCFFAA, 2136.1887,-1132.9510,25.4904, 20.0, 0);
	DealerCar[4] = Create3DTextLabel(string5, 0x33CCFFAA, 2120.1875,-1122.7693,25.4782, 20.0, 0);
	DealerCar[5] = Create3DTextLabel(string6, 0x33CCFFAA, 2119.2405,-1127.4752,25.1522, 20.0, 0);
	DealerCar[6] = Create3DTextLabel(string7, 0x33CCFFAA, 2119.3145,-1132.3177,24.8819, 20.0, 0);
	DealerCar[7] = Create3DTextLabel(string8, 0x33CCFFAA, 2119.3181,-1136.4448,25.1078, 20.0, 0);
	return 1;
}
public OnFilterScriptExit(){
    IsADealerCar[DealerCars[0]] = false;
	IsADealerCar[DealerCars[1]] = false;
	IsADealerCar[DealerCars[2]] = false;
	IsADealerCar[DealerCars[3]] = false;
	IsADealerCar[DealerCars[4]] = false;
	IsADealerCar[DealerCars[5]] = false;
	IsADealerCar[DealerCars[6]] = false;
	IsADealerCar[DealerCars[7]] = false;
	CarPrice[DealerCars[0]] = 0;
	CarPrice[DealerCars[1]] = 0;
	CarPrice[DealerCars[2]] = 0;
	CarPrice[DealerCars[3]] = 0;
	CarPrice[DealerCars[4]] = 0;
	CarPrice[DealerCars[5]] = 0;
	CarPrice[DealerCars[6]] = 0;
	CarPrice[DealerCars[7]] = 0;
	DestroyVehicle(DealerCars[0]);
	DestroyVehicle(DealerCars[1]);
	DestroyVehicle(DealerCars[2]);
	DestroyVehicle(DealerCars[3]);
	DestroyVehicle(DealerCars[4]);
	DestroyVehicle(DealerCars[5]);
	DestroyVehicle(DealerCars[6]);
	DestroyVehicle(DealerCars[7]);
	Delete3DTextLabel(DealerCar[0]);
	Delete3DTextLabel(DealerCar[1]);
	Delete3DTextLabel(DealerCar[2]);
	Delete3DTextLabel(DealerCar[3]);
	Delete3DTextLabel(DealerCar[4]);
	Delete3DTextLabel(DealerCar[5]);
	Delete3DTextLabel(DealerCar[6]);
	Delete3DTextLabel(DealerCar[7]);
	return 1;
}
public OnPlayerConnect(playerid){
	new file[256], name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
	format(file,sizeof(file),"Cars/%s.ini",name);
	if(dini_Exists(file)){
	    VehicleInfo[playerid][Model] = dini_Int(file, "Model");
	    VehicleInfo[playerid][Price] = dini_Int(file, "Price");
	    VehicleInfo[playerid][CarX] = dini_Float(file, "X");
	    VehicleInfo[playerid][CarY] = dini_Float(file, "Y");
	    VehicleInfo[playerid][CarZ] = dini_Float(file, "Z");
	    VehicleInfo[playerid][CarRot] = dini_Float(file, "Rot");
	    VehicleInfo[playerid][Locked] = dini_Int(file, "Locked");
		VehicleInfo[playerid][mod1] = dini_Int(file, "mod1");
		VehicleInfo[playerid][mod2] = dini_Int(file, "mod2");
		VehicleInfo[playerid][mod3] = dini_Int(file, "mod3");
		VehicleInfo[playerid][mod4] = dini_Int(file, "mod4");
		VehicleInfo[playerid][mod5] = dini_Int(file, "mod5");
		VehicleInfo[playerid][mod6] = dini_Int(file, "mod6");
		VehicleInfo[playerid][mod7] = dini_Int(file, "mod7");
		VehicleInfo[playerid][mod8] = dini_Int(file, "mod8");
		VehicleInfo[playerid][mod9] = dini_Int(file, "mod9");
		VehicleInfo[playerid][mod10] = dini_Int(file, "mod10");
		VehicleInfo[playerid][mod11] = dini_Int(file, "mod11");
		VehicleInfo[playerid][mod12] = dini_Int(file, "mod12");
		VehicleInfo[playerid][mod13] = dini_Int(file, "mod13");
		VehicleInfo[playerid][mod14] = dini_Int(file, "mod14");
		VehicleInfo[playerid][mod15] = dini_Int(file, "mod15");
		VehicleInfo[playerid][mod16] = dini_Int(file, "mod16");
		VehicleInfo[playerid][mod17] = dini_Int(file, "mod17");
		VehicleInfo[playerid][paintjob] = dini_Int(file, "paintjob");
		VehicleInfo[playerid][colora] = dini_Int(file, "color1");
		VehicleInfo[playerid][colorb] = dini_Int(file, "color2");
		Vehicle[playerid] = CreateVehicle(VehicleInfo[playerid][Model], VehicleInfo[playerid][CarX], VehicleInfo[playerid][CarY], VehicleInfo[playerid][CarZ], VehicleInfo[playerid][CarRot], -1, -1, 3600000);
    	if(VehicleInfo[playerid][mod1]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod1]); }
		if(VehicleInfo[playerid][mod2]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod2]); }
		if(VehicleInfo[playerid][mod3]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod3]); }
		if(VehicleInfo[playerid][mod4]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod4]); }
		if(VehicleInfo[playerid][mod5]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod5]); }
		if(VehicleInfo[playerid][mod6]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod6]); }
		if(VehicleInfo[playerid][mod7]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod7]); }
		if(VehicleInfo[playerid][mod8]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod8]); }
		if(VehicleInfo[playerid][mod9]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod9]); }
		if(VehicleInfo[playerid][mod10]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod10]); }
		if(VehicleInfo[playerid][mod11]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod11]); }
		if(VehicleInfo[playerid][mod12]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod12]); }
		if(VehicleInfo[playerid][mod13]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod13]); }
		if(VehicleInfo[playerid][mod14]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod14]); }
		if(VehicleInfo[playerid][mod15]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod15]); }
		if(VehicleInfo[playerid][mod16]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod16]); }
		if(VehicleInfo[playerid][mod17]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod17]); }
		if(VehicleInfo[playerid][colora]!=0 || VehicleInfo[playerid][colorb]!=0){
			ChangeVehicleColor(Vehicle[playerid],VehicleInfo[playerid][colora],VehicleInfo[playerid][colorb]);
		}
		if(VehicleInfo[playerid][paintjob]!=0){
		    ChangeVehiclePaintjob(Vehicle[playerid],VehicleInfo[playerid][paintjob]);
  		}
		new tmp[256]; tmp = dini_Get(file, "Plate");
		gPlayerHasCar[playerid] = 1;
		VehOwned[Vehicle[playerid]] = 1;
		OwnerID[Vehicle[playerid]] = playerid;
		SetVehicleParamsForPlayer(Vehicle[playerid], playerid, 0, VehicleInfo[playerid][Locked]);
		gVehLocked[Vehicle[playerid]] = VehicleInfo[playerid][Locked];
		SetVehicleNumberPlate(Vehicle[playerid], tmp);
		VehPlate[Vehicle[playerid]] = tmp;
		LoadTrunk(playerid);
	}
    return 1;
}
public OnPlayerDisconnect(playerid){
	new file[256], name[24];
    GetPlayerName(playerid, name, 24);
	format(file,sizeof(file),"Cars/%s.ini",name);
	if(dini_Exists(file)){
	    dini_IntSet(file, "Model", GetVehicleModel(Vehicle[playerid]));
		dini_IntSet(file, "Price", VehicleInfo[playerid][Price]);
		dini_FloatSet(file, "X", VehicleInfo[playerid][CarX]);
		dini_FloatSet(file, "Y", VehicleInfo[playerid][CarY]);
		dini_FloatSet(file, "Z", VehicleInfo[playerid][CarZ]);
		dini_FloatSet(file, "Rot", VehicleInfo[playerid][CarRot]);
		dini_IntSet(file, "Locked", VehicleInfo[playerid][Locked]);
		dini_Set(file, "Plate", VehPlate[Vehicle[playerid]]);
		dini_IntSet(file, "mod1", VehicleInfo[playerid][mod1]);
		dini_IntSet(file, "mod2", VehicleInfo[playerid][mod2]);
		dini_IntSet(file, "mod3", VehicleInfo[playerid][mod3]);
		dini_IntSet(file, "mod4", VehicleInfo[playerid][mod4]);
		dini_IntSet(file, "mod5", VehicleInfo[playerid][mod5]);
		dini_IntSet(file, "mod6", VehicleInfo[playerid][mod6]);
		dini_IntSet(file, "mod7", VehicleInfo[playerid][mod7]);
		dini_IntSet(file, "mod8", VehicleInfo[playerid][mod8]);
		dini_IntSet(file, "mod9", VehicleInfo[playerid][mod9]);
		dini_IntSet(file, "mod10", VehicleInfo[playerid][mod10]);
		dini_IntSet(file, "mod11", VehicleInfo[playerid][mod11]);
		dini_IntSet(file, "mod12", VehicleInfo[playerid][mod12]);
		dini_IntSet(file, "mod13", VehicleInfo[playerid][mod13]);
		dini_IntSet(file, "mod14", VehicleInfo[playerid][mod14]);
		dini_IntSet(file, "mod15", VehicleInfo[playerid][mod15]);
		dini_IntSet(file, "mod16", VehicleInfo[playerid][mod16]);
		dini_IntSet(file, "mod17", VehicleInfo[playerid][mod17]);
		dini_IntSet(file, "paintjob", VehicleInfo[playerid][paintjob]);
		dini_IntSet(file, "color1", VehicleInfo[playerid][colora]);
		dini_IntSet(file, "color2", VehicleInfo[playerid][colorb]);
		DestroyVehicle(Vehicle[playerid]);
		SaveTrunk(playerid);
	}
	return 1;
}
public OnPlayerStateChange(playerid, newstate, oldstate){
	if(newstate == PLAYER_STATE_DRIVER){
	    new veh = GetPlayerVehicleID(playerid);
		if(VehOwned[veh] == 0){
			if(IsADealerCar[veh] == 1){
				new string[128];
				format(string, sizeof(string), "Are you sure you would like to buy this %s for $%i?", GetVehicleNameFromID(veh), CarPrice[veh]);
			    ShowPlayerDialog(playerid, 669, DIALOG_STYLE_MSGBOX, "Dealership", string, "Yes", "No");
			    return 1;
   			}
		}
		else if(VehOwned[veh] == 1){
		    new owner[24], string[128];
		    GetPlayerName(OwnerID[veh], owner, sizeof(owner));
			format(string, sizeof(string), "Warning: This %s is owned by %s.", GetVehicleNameFromID(veh), owner);
   			SendClientMessage(playerid, 0xFFFFFFAA, string);
			return 1;
		}
	}
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]){
	if(dialogid == 669){
	    if(response){
	        new file[256], name[MAX_PLAYER_NAME];
    		GetPlayerName(playerid, name, sizeof(name));
			format(file,sizeof(file),"Cars/%s.ini",name);
            new veh = GetPlayerVehicleID(playerid);
		    new money = GetPlayerMoney(playerid);
	        if(money >= CarPrice[veh]){
	            if(gPlayerHasCar[playerid] == 1) return SendClientMessage(playerid, 0xFFFFFFFF, "You already own a car.");
	            new string[64];
	            SendClientMessage(playerid, 0xAFAFAFAA, "Thank you for buying at Coutt and Schutz.");
	            PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				dini_Create(file);
				Vehicle[playerid] = CreateVehicle(GetVehicleModel(veh), 2130.1914, -1109.5881, 25.1890, 76.2599, 1, 1, 3600000);
                format(string, sizeof(string), "Creating your vehicle %i.", veh);
	            SendClientMessage(playerid, 0xAFAFAFAA, string);
				VehicleInfo[playerid][Model] = GetVehicleModel(veh);
				VehicleInfo[playerid][Price] = CarPrice[veh];
				VehicleInfo[playerid][CarX] = 2130.1914;
				VehicleInfo[playerid][CarY] = -1109.5881;
				VehicleInfo[playerid][CarZ] = 25.1890;
				VehicleInfo[playerid][CarRot] = 76.2599;
				gPlayerHasCar[playerid] = 1;
				RemovePlayerFromVehicle(playerid);
				OwnerID[Vehicle[playerid]] = playerid;
				VehPlate[Vehicle[playerid]] = "XYZR 000";
				PutPlayerInVehicle(playerid, Vehicle[playerid], 0);
				GivePlayerMoney(playerid, -VehicleInfo[playerid][Price]);
			}
			else{
			    RemovePlayerFromVehicle(playerid);
			    SendClientMessage(playerid, 0xAFAFAFAA, "You cannot afford this vehicle.");
			    return 1;
   			}
		}
		else{
  			RemovePlayerFromVehicle(playerid);
		}
	}
	if(dialogid == 670){
	    if(response){
	        new file[256], name[24], license[10];
    		GetPlayerName(playerid, name, 24);
			format(file,sizeof(file),"Cars/%s.ini",name);
	    	dini_IntSet(file, "Model", VehicleInfo[playerid][Model]);
			dini_IntSet(file, "Price", VehicleInfo[playerid][Price]);
			dini_FloatSet(file, "X", VehicleInfo[playerid][CarX]);
			dini_FloatSet(file, "Y", VehicleInfo[playerid][CarY]);
			dini_FloatSet(file, "Z", VehicleInfo[playerid][CarZ]);
			dini_FloatSet(file, "Rot", VehicleInfo[playerid][CarRot]);
			dini_IntSet(file, "Locked", VehicleInfo[playerid][Locked]);
			dini_IntSet(file, "mod1", VehicleInfo[playerid][mod1]);
			dini_IntSet(file, "mod2", VehicleInfo[playerid][mod2]);
			dini_IntSet(file, "mod3", VehicleInfo[playerid][mod3]);
			dini_IntSet(file, "mod4", VehicleInfo[playerid][mod4]);
			dini_IntSet(file, "mod5", VehicleInfo[playerid][mod5]);
			dini_IntSet(file, "mod6", VehicleInfo[playerid][mod6]);
			dini_IntSet(file, "mod7", VehicleInfo[playerid][mod7]);
			dini_IntSet(file, "mod8", VehicleInfo[playerid][mod8]);
			dini_IntSet(file, "mod9", VehicleInfo[playerid][mod9]);
			dini_IntSet(file, "mod10", VehicleInfo[playerid][mod10]);
			dini_IntSet(file, "mod11", VehicleInfo[playerid][mod11]);
			dini_IntSet(file, "mod12", VehicleInfo[playerid][mod12]);
			dini_IntSet(file, "mod13", VehicleInfo[playerid][mod13]);
			dini_IntSet(file, "mod14", VehicleInfo[playerid][mod14]);
			dini_IntSet(file, "mod15", VehicleInfo[playerid][mod15]);
			dini_IntSet(file, "mod16", VehicleInfo[playerid][mod16]);
			dini_IntSet(file, "mod17", VehicleInfo[playerid][mod17]);
			dini_IntSet(file, "paintjob", VehicleInfo[playerid][paintjob]);
			dini_IntSet(file, "color1", VehicleInfo[playerid][colora]);
			dini_IntSet(file, "color2", VehicleInfo[playerid][colorb]);
	        new string[128], Float:CarHP, Float:OldCarHP, Float:X, Float:Y, Float:Z, Float:Rot;
	        new plate = strlen(inputtext);
	        if(plate < 4) return ShowPlayerDialog(playerid, 670, DIALOG_STYLE_INPUT, "Plate", "Plate must be at least 4 characters.\n\nPlease try again.", "Done", "Cancel");
	        if(plate > 8) return ShowPlayerDialog(playerid, 670, DIALOG_STYLE_INPUT, "Plate", "Plate must be below 8 characters.\n\nPlease try again.", "Done", "Cancel");
	        GetVehicleHealth(Vehicle[playerid], CarHP);
			OldCarHP = CarHP;
			GetVehiclePos(Vehicle[playerid], X, Y, Z);
     		GetVehicleZAngle(Vehicle[playerid], Rot);
	        SetVehicleNumberPlate(Vehicle[playerid], inputtext);
	        SetVehicleToRespawn(Vehicle[playerid]);
	        SetVehiclePos(Vehicle[playerid], X, Y, Z);
	        SetVehicleZAngle(Vehicle[playerid], Rot);
	        PutPlayerInVehicle(playerid, Vehicle[playerid], 0);
	        format(license, sizeof(license), "%s", inputtext);
	        VehPlate[Vehicle[playerid]] = license;
	        dini_Set(file, "Plate", VehPlate[Vehicle[playerid]]);
	        format(string, sizeof(string), "{FFFF00}You have set your vehicle's plate to:{FFFFFF} %s", inputtext);
	        SendClientMessage(playerid, 0xFFFFFFFF, string);
	        SendClientMessage(playerid, 0xFFFFFFFF, "NOTE: Your vehicle's health was restored to the previous amount (to prevent exploitation).");
	        SetVehicleHealth(Vehicle[playerid], OldCarHP);
	        VehicleInfo[playerid][Model] = dini_Int(file, "Model");
	    	VehicleInfo[playerid][Price] = dini_Int(file, "Price");
	    	VehicleInfo[playerid][CarX] = dini_Float(file, "X");
	    	VehicleInfo[playerid][CarY] = dini_Float(file, "Y");
	    	VehicleInfo[playerid][CarZ] = dini_Float(file, "Z");
	    	VehicleInfo[playerid][CarRot] = dini_Float(file, "Rot");
	    	VehicleInfo[playerid][Locked] = dini_Int(file, "Locked");
			VehicleInfo[playerid][mod1] = dini_Int(file, "mod1");
			VehicleInfo[playerid][mod2] = dini_Int(file, "mod2");
			VehicleInfo[playerid][mod3] = dini_Int(file, "mod3");
			VehicleInfo[playerid][mod4] = dini_Int(file, "mod4");
			VehicleInfo[playerid][mod5] = dini_Int(file, "mod5");
			VehicleInfo[playerid][mod6] = dini_Int(file, "mod6");
			VehicleInfo[playerid][mod7] = dini_Int(file, "mod7");
			VehicleInfo[playerid][mod8] = dini_Int(file, "mod8");
			VehicleInfo[playerid][mod9] = dini_Int(file, "mod9");
			VehicleInfo[playerid][mod10] = dini_Int(file, "mod10");
			VehicleInfo[playerid][mod11] = dini_Int(file, "mod11");
			VehicleInfo[playerid][mod12] = dini_Int(file, "mod12");
			VehicleInfo[playerid][mod13] = dini_Int(file, "mod13");
			VehicleInfo[playerid][mod14] = dini_Int(file, "mod14");
			VehicleInfo[playerid][mod15] = dini_Int(file, "mod15");
			VehicleInfo[playerid][mod16] = dini_Int(file, "mod16");
			VehicleInfo[playerid][mod17] = dini_Int(file, "mod17");
			VehicleInfo[playerid][paintjob] = dini_Int(file, "paintjob");
			VehicleInfo[playerid][colora] = dini_Int(file, "color1");
			VehicleInfo[playerid][colorb] = dini_Int(file, "color2");
    		if(VehicleInfo[playerid][mod1]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod1]); }
			if(VehicleInfo[playerid][mod2]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod2]); }
			if(VehicleInfo[playerid][mod3]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod3]); }
			if(VehicleInfo[playerid][mod4]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod4]); }
			if(VehicleInfo[playerid][mod5]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod5]); }
			if(VehicleInfo[playerid][mod6]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod6]); }
			if(VehicleInfo[playerid][mod7]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod7]); }
			if(VehicleInfo[playerid][mod8]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod8]); }
			if(VehicleInfo[playerid][mod9]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod9]); }
			if(VehicleInfo[playerid][mod10]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod10]); }
			if(VehicleInfo[playerid][mod11]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod11]); }
			if(VehicleInfo[playerid][mod12]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod12]); }
			if(VehicleInfo[playerid][mod13]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod13]); }
			if(VehicleInfo[playerid][mod14]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod14]); }
			if(VehicleInfo[playerid][mod15]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod15]); }
			if(VehicleInfo[playerid][mod16]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod16]); }
			if(VehicleInfo[playerid][mod17]!=0) { AddVehicleComponent(Vehicle[playerid],VehicleInfo[playerid][mod17]); }
			if(VehicleInfo[playerid][colora]!=0 || VehicleInfo[playerid][colorb]!=0){
				ChangeVehicleColor(Vehicle[playerid],VehicleInfo[playerid][colora],VehicleInfo[playerid][colorb]);
			}
			if(VehicleInfo[playerid][paintjob]!=0){
		    	ChangeVehiclePaintjob(Vehicle[playerid],VehicleInfo[playerid][paintjob]);
  			}
			SetVehicleParamsForPlayer(Vehicle[playerid], playerid, 0, VehicleInfo[playerid][Locked]);
			gVehLocked[Vehicle[playerid]] = VehicleInfo[playerid][Locked];
			CarHP = 0;
			OldCarHP = 0;
			return 1;
		}
		return 1;
	}
	return 1;
}
public OnVehicleMod(playerid,vehicleid,componentid){
	new mods = InitComponents(componentid);
	if(IsPlayerInVehicle(playerid, Vehicle[playerid])){
		switch(mods){
			case 1: { VehicleInfo[playerid][mod1] = componentid; }
			case 2: { VehicleInfo[playerid][mod2] = componentid; }
			case 3: { VehicleInfo[playerid][mod3] = componentid; }
			case 4: { VehicleInfo[playerid][mod4] = componentid; }
			case 5: { VehicleInfo[playerid][mod5] = componentid; }
			case 6: { VehicleInfo[playerid][mod6] = componentid; }
			case 7: { VehicleInfo[playerid][mod7] = componentid; }
			case 8: { VehicleInfo[playerid][mod8] = componentid; }
			case 9: { VehicleInfo[playerid][mod9] = componentid; }
			case 10: { VehicleInfo[playerid][mod10] = componentid; }
			case 11: { VehicleInfo[playerid][mod11] = componentid; }
			case 12: { VehicleInfo[playerid][mod12] = componentid; }
			case 13: { VehicleInfo[playerid][mod13] = componentid; }
			case 14: { VehicleInfo[playerid][mod14] = componentid; }
			case 15: { VehicleInfo[playerid][mod15] = componentid; }
			case 16: { VehicleInfo[playerid][mod16] = componentid; }
			case 17: { VehicleInfo[playerid][mod17] = componentid; }
		}
	}
	return 1;
}
public OnVehiclePaintjob(playerid, vehicleid, paintjobid){
	if(IsPlayerInVehicle(playerid, Vehicle[playerid])){
	    if(GetVehicleModel(Vehicle[playerid]) == 483){
			switch(paintjobid){
	    		case 0: VehicleInfo[playerid][paintjob] = 0;
	    	}
  		}
  		if(GetVehicleModel(Vehicle[playerid]) == 534){
	   		switch(paintjobid){
	    		case 0: VehicleInfo[playerid][paintjob] = 0;
	    		case 1: VehicleInfo[playerid][paintjob] = 1;
	    		case 2: VehicleInfo[playerid][paintjob] = 2;
	    	}
  		}
  		if(GetVehicleModel(Vehicle[playerid]) == 535){
	   		switch(paintjobid){
	    		case 0: VehicleInfo[playerid][paintjob] = 0;
	    		case 1: VehicleInfo[playerid][paintjob] = 1;
	    		case 2: VehicleInfo[playerid][paintjob] = 2;
	    	}
  		}
  		if(GetVehicleModel(Vehicle[playerid]) == 536){
	   		switch(paintjobid){
	    		case 0: VehicleInfo[playerid][paintjob] = 0;
	    		case 1: VehicleInfo[playerid][paintjob] = 1;
	    		case 2: VehicleInfo[playerid][paintjob] = 2;
	    	}
  		}
  		if(GetVehicleModel(Vehicle[playerid]) == 558){
	   		switch(paintjobid){
	    		case 0: VehicleInfo[playerid][paintjob] = 0;
	    		case 1: VehicleInfo[playerid][paintjob] = 1;
	    		case 2: VehicleInfo[playerid][paintjob] = 2;
	    	}
  		}
  		if(GetVehicleModel(Vehicle[playerid]) == 559){
	   		switch(paintjobid){
	    		case 0: VehicleInfo[playerid][paintjob] = 0;
	    		case 1: VehicleInfo[playerid][paintjob] = 1;
	    		case 2: VehicleInfo[playerid][paintjob] = 2;
	    	}
  		}
  		if(GetVehicleModel(Vehicle[playerid]) == 560){
	   		switch(paintjobid){
	    		case 0: VehicleInfo[playerid][paintjob] = 0;
	    		case 1: VehicleInfo[playerid][paintjob] = 1;
	    		case 2: VehicleInfo[playerid][paintjob] = 2;
	    	}
  		}
  		if(GetVehicleModel(Vehicle[playerid]) == 561){
	   		switch(paintjobid){
	    		case 0: VehicleInfo[playerid][paintjob] = 0;
	    		case 1: VehicleInfo[playerid][paintjob] = 1;
	    		case 2: VehicleInfo[playerid][paintjob] = 2;
	    	}
  		}
  		if(GetVehicleModel(Vehicle[playerid]) == 562){
	   		switch(paintjobid){
	    		case 0: VehicleInfo[playerid][paintjob] = 0;
	    		case 1: VehicleInfo[playerid][paintjob] = 1;
	    		case 2: VehicleInfo[playerid][paintjob] = 2;
	    	}
  		}
  		if(GetVehicleModel(Vehicle[playerid]) == 565){
	   		switch(paintjobid){
	    		case 0: VehicleInfo[playerid][paintjob] = 0;
	    		case 1: VehicleInfo[playerid][paintjob] = 1;
	    		case 2: VehicleInfo[playerid][paintjob] = 2;
	    	}
  		}
  		if(GetVehicleModel(Vehicle[playerid]) == 567){
	   		switch(paintjobid){
	    		case 0: VehicleInfo[playerid][paintjob] = 0;
	    		case 1: VehicleInfo[playerid][paintjob] = 1;
	    		case 2: VehicleInfo[playerid][paintjob] = 2;
	    	}
  		}
  		if(GetVehicleModel(Vehicle[playerid]) == 575){
	   		switch(paintjobid){
	    		case 0: VehicleInfo[playerid][paintjob] = 0;
	    		case 1: VehicleInfo[playerid][paintjob] = 1;
	    	}
  		}
  		if(GetVehicleModel(Vehicle[playerid]) == 576){
	   		switch(paintjobid){
	    		case 0: VehicleInfo[playerid][paintjob] = 0;
	    		case 1: VehicleInfo[playerid][paintjob] = 1;
	    		case 2: VehicleInfo[playerid][paintjob] = 2;
	    	}
  		}
	}
	return 1;
}
public OnVehicleRespray(playerid,vehicleid, color1, color2){
    if(IsPlayerInVehicle(playerid, Vehicle[playerid])){
		VehicleInfo[playerid][colora] = color1;
		VehicleInfo[playerid][colorb] = color2;
	}
	return 1;
}
strtok(const string[], &index){
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' ')){
		index++;
	}
	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1))){
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
public OnPlayerCommandText(playerid, cmdtext[]){
    new idx, tmp[128], cmd[128];
	cmd = strtok(cmdtext, idx);
	if(strcmp(cmd, "/trunk", true) == 0){
	    if(gPlayerHasCar[playerid] == 0) return SendClientMessage(playerid, 0xAFAFAFAA, "  You don't own a car !");
	    new x_nr[256];
		x_nr = strtok(cmdtext, idx);
		if(!strlen(x_nr)){
			SendClientMessage(playerid, 0xFFFFFFFF, "USAGE: /trunk [item]");
			SendClientMessage(playerid, 0xFFFFFFFF, "Available items: open, close, check, putgun, takegun");
			return 1;
  		}
  		if(strcmp(x_nr, "open", true) == 0){
			if(TrunkOpen[Vehicle[playerid]] == 1) return SendClientMessage(playerid, 0xAFAFAFAA, "  The trunk is already open !");
			new engine, lights, alarm, doors, bonnet, boot, objective;
	        GetVehicleParamsEx(Vehicle[playerid], engine, lights, alarm, doors, bonnet, boot, objective);
            SetVehicleParamsEx(Vehicle[playerid], engine, lights, alarm, doors, bonnet, VEHICLE_PARAMS_ON, objective);
            TrunkOpen[Vehicle[playerid]] = 1;
			return 1;
		}
		if(strcmp(x_nr, "close", true) == 0){
  		    if(TrunkOpen[Vehicle[playerid]] == 0) return SendClientMessage(playerid, 0xAFAFAFAA, "  The trunk is already closed !");
			new engine, lights, alarm, doors, bonnet, boot, objective;
	        GetVehicleParamsEx(Vehicle[playerid], engine, lights, alarm, doors, bonnet, boot, objective);
            SetVehicleParamsEx(Vehicle[playerid], engine, lights, alarm, doors, bonnet, VEHICLE_PARAMS_OFF, objective);
            TrunkOpen[Vehicle[playerid]] = 0;
			return 1;
		}
		if(strcmp(x_nr, "putgun", true) == 0){
		    if(TrunkOpen[Vehicle[playerid]] == 0) { SendClientMessage(playerid, 0xAFAFAFAA, "  You must open the trunk first !"); return 1; }
		    tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) { SendClientMessage(playerid, 0xFFFFFFFF, "USAGE: /trunk putgun [slot]"); return 1; }
			new slot = strval(tmp), weapon = GetPlayerWeapon(playerid);
			if(slot < 1 || slot > 10) { SendClientMessage(playerid, 0xAFAFAFAA, "   Slot can't be below 1 or above 10 !"); return 1; }
			if(weapon == 0) return SendClientMessage(playerid, 0xAFAFAFAA, "  You don't have a weapon !");
			if(slot == 1){
			    new string[128], gunname[16];
			    new ammo = GetPlayerAmmo(playerid);
			    new v = Vehicle[playerid];
			    if(TrunkInfo[v][Slot1] > 0) return SendClientMessage(playerid, 0xAFAFAFAA, "  There is already something there !");
			    TrunkInfo[v][Slot1] = weapon;
			    TrunkInfo[v][Ammo1] = ammo;
			    GetWeaponName(weapon, gunname, sizeof(gunname));
			    format(string, sizeof(string), "You have stored your %s into slot 1 of your trunk.",gunname);
			    SendClientMessage(playerid, 0xFFFF00FF, string);
			    RemovePlayerWeapon(playerid, weapon);
			    return 1;
   			}
   			if(slot == 2){
			    new string[128], gunname[16];
			    new ammo = GetPlayerAmmo(playerid);
			    new v = Vehicle[playerid];
			    if(TrunkInfo[v][Slot2] > 0) return SendClientMessage(playerid, 0xAFAFAFAA, "  There is already something there !");
			    TrunkInfo[v][Slot2] = weapon;
			    TrunkInfo[v][Ammo2] = ammo;
			    GetWeaponName(weapon, gunname, sizeof(gunname));
			    format(string, sizeof(string), "You have stored your %s into slot 2 of your trunk.",gunname);
			    SendClientMessage(playerid, 0xFFFF00FF, string);
			    RemovePlayerWeapon(playerid, weapon);
			    return 1;
   			}
   			if(slot == 3){
			    new string[128], gunname[16];
			    new ammo = GetPlayerAmmo(playerid);
			    new v = Vehicle[playerid];
			    if(TrunkInfo[v][Slot3] > 0) return SendClientMessage(playerid, 0xAFAFAFAA, "  There is already something there !");
			    TrunkInfo[v][Slot3] = weapon;
			    TrunkInfo[v][Ammo3] = ammo;
			    GetWeaponName(weapon, gunname, sizeof(gunname));
			    format(string, sizeof(string), "You have stored your %s into slot 3 of your trunk.",gunname);
			    SendClientMessage(playerid, 0xFFFF00FF, string);
			    RemovePlayerWeapon(playerid, weapon);
			    return 1;
   			}
   			if(slot == 4){
			    new string[128], gunname[16];
			    new ammo = GetPlayerAmmo(playerid);
			    new v = Vehicle[playerid];
			    if(TrunkInfo[v][Slot4] > 0) return SendClientMessage(playerid, 0xAFAFAFAA, "  There is already something there !");
			    TrunkInfo[v][Slot4] = weapon;
			    TrunkInfo[v][Ammo4] = ammo;
			    GetWeaponName(weapon, gunname, sizeof(gunname));
			    format(string, sizeof(string), "You have stored your %s into slot 4 of your trunk.",gunname);
			    SendClientMessage(playerid, 0xFFFF00FF, string);
			    RemovePlayerWeapon(playerid, weapon);
			    return 1;
   			}
			if(slot == 5){
			    new string[128], gunname[16];
			    new ammo = GetPlayerAmmo(playerid);
			    new v = Vehicle[playerid];
			    if(TrunkInfo[v][Slot5] > 0) return SendClientMessage(playerid, 0xAFAFAFAA, "  There is already something there !");
			    TrunkInfo[v][Slot5] = weapon;
			    TrunkInfo[v][Ammo5] = ammo;
			    GetWeaponName(weapon, gunname, sizeof(gunname));
			    format(string, sizeof(string), "You have stored your %s into slot 5 of your trunk.",gunname);
			    SendClientMessage(playerid, 0xFFFF00FF, string);
			    RemovePlayerWeapon(playerid, weapon);
			    return 1;
   			}
   			if(slot == 6){
			    new string[128], gunname[16];
			    new ammo = GetPlayerAmmo(playerid);
			    new v = Vehicle[playerid];
			    if(TrunkInfo[v][Slot6] > 0) return SendClientMessage(playerid, 0xAFAFAFAA, "  There is already something there !");
			    TrunkInfo[v][Slot6] = weapon;
			    TrunkInfo[v][Ammo6] = ammo;
			    GetWeaponName(weapon, gunname, sizeof(gunname));
			    format(string, sizeof(string), "You have stored your %s into slot 6 of your trunk.",gunname);
			    SendClientMessage(playerid, 0xFFFF00FF, string);
			    RemovePlayerWeapon(playerid, weapon);
			    return 1;
   			}
			if(slot == 7){
			    new string[128], gunname[16];
			    new ammo = GetPlayerAmmo(playerid);
			    new v = Vehicle[playerid];
			    if(TrunkInfo[v][Slot7] > 0) return SendClientMessage(playerid, 0xAFAFAFAA, "  There is already something there !");
			    TrunkInfo[v][Slot7] = weapon;
			    TrunkInfo[v][Ammo7] = ammo;
			    GetWeaponName(weapon, gunname, sizeof(gunname));
			    format(string, sizeof(string), "You have stored your %s into slot 7 of your trunk.",gunname);
			    SendClientMessage(playerid, 0xFFFF00FF, string);
			    RemovePlayerWeapon(playerid, weapon);
			    return 1;
   			}
   			if(slot == 8){
			    new string[128], gunname[16];
			    new ammo = GetPlayerAmmo(playerid);
			    new v = Vehicle[playerid];
			    if(TrunkInfo[v][Slot8] > 0) return SendClientMessage(playerid, 0xAFAFAFAA, "  There is already something there !");
			    TrunkInfo[v][Slot8] = weapon;
			    TrunkInfo[v][Ammo8] = ammo;
			    GetWeaponName(weapon, gunname, sizeof(gunname));
			    format(string, sizeof(string), "You have stored your %s into slot 8 of your trunk.",gunname);
			    SendClientMessage(playerid, 0xFFFF00FF, string);
			    RemovePlayerWeapon(playerid, weapon);
			    return 1;
   			}
   			if(slot == 9){
			    new string[128], gunname[16];
			    new ammo = GetPlayerAmmo(playerid);
			    new v = Vehicle[playerid];
			    if(TrunkInfo[v][Slot9] > 0) return SendClientMessage(playerid, 0xAFAFAFAA, "  There is already something there !");
			    TrunkInfo[v][Slot9] = weapon;
			    TrunkInfo[v][Ammo9] = ammo;
			    GetWeaponName(weapon, gunname, sizeof(gunname));
			    format(string, sizeof(string), "You have stored your %s into slot 9 of your trunk.",gunname);
			    SendClientMessage(playerid, 0xFFFF00FF, string);
			    RemovePlayerWeapon(playerid, weapon);
			    return 1;
   			}
   			if(slot == 10){
			    new string[128], gunname[16];
			    new ammo = GetPlayerAmmo(playerid);
			    new v = Vehicle[playerid];
			    if(TrunkInfo[v][Slot10] > 0) return SendClientMessage(playerid, 0xAFAFAFAA, "  There is already something there !");
			    TrunkInfo[v][Slot10] = weapon;
			    TrunkInfo[v][Ammo10] = ammo;
			    GetWeaponName(weapon, gunname, sizeof(gunname));
			    format(string, sizeof(string), "You have stored your %s into slot 10 of your trunk.",gunname);
			    SendClientMessage(playerid, 0xFFFF00FF, string);
			    RemovePlayerWeapon(playerid, weapon);
			    return 1;
   			}
		}
		if(strcmp(x_nr, "takegun", true) == 0){
      		if(TrunkOpen[Vehicle[playerid]] == 0) { SendClientMessage(playerid, 0xAFAFAFAA, "  You must open the trunk first !"); return 1; }
		    tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) { SendClientMessage(playerid, 0xFFFFFFFF, "USAGE: /trunk takegun [slot]"); return 1; }
			new slot = strval(tmp);
			if(slot < 1 || slot > 10) { SendClientMessage(playerid, 0xAFAFAFAA, "   Slot can't be below 1 or above 10 !"); return 1; }
			if(slot == 1){
				new string[128], gunname[16];
			    new v = Vehicle[playerid];
			    if(TrunkInfo[v][Slot1] < 1) return SendClientMessage(playerid, 0xAFAFAFAA, "  There is nothing there !");
			    GetWeaponName(TrunkInfo[v][Slot1], gunname, sizeof(gunname));
			    format(string, sizeof(string), "You have taken your %s from slot 1 of your trunk.",gunname);
			    SendClientMessage(playerid, 0xFFFF00FF, string);
			    GivePlayerWeapon(playerid, TrunkInfo[v][Slot1], TrunkInfo[v][Ammo1]);
			    TrunkInfo[v][Slot1] = 0;
			    TrunkInfo[v][Ammo1] = 0;
			    return 1;
    		}
    		if(slot == 2){
				new string[128], gunname[16];
			    new v = Vehicle[playerid];
			    if(TrunkInfo[v][Slot2] < 1) return SendClientMessage(playerid, 0xAFAFAFAA, "  There is nothing there !");
			    GetWeaponName(TrunkInfo[v][Slot2], gunname, sizeof(gunname));
			    format(string, sizeof(string), "You have taken your %s from slot 2 of your trunk.",gunname);
			    SendClientMessage(playerid, 0xFFFF00FF, string);
			    GivePlayerWeapon(playerid, TrunkInfo[v][Slot2], TrunkInfo[v][Ammo2]);
			    TrunkInfo[v][Slot2] = 0;
			    TrunkInfo[v][Ammo2] = 0;
			    return 1;
    		}
    		if(slot == 3){
				new string[128], gunname[16];
			    new v = Vehicle[playerid];
			    if(TrunkInfo[v][Slot3] < 1) return SendClientMessage(playerid, 0xAFAFAFAA, "  There is nothing there !");
			    GetWeaponName(TrunkInfo[v][Slot3], gunname, sizeof(gunname));
			    format(string, sizeof(string), "You have taken your %s from slot 3 of your trunk.",gunname);
			    SendClientMessage(playerid, 0xFFFF00FF, string);
			    GivePlayerWeapon(playerid, TrunkInfo[v][Slot3], TrunkInfo[v][Ammo3]);
			    TrunkInfo[v][Slot3] = 0;
			    TrunkInfo[v][Ammo3] = 0;
			    return 1;
    		}
    		if(slot == 4){
				new string[128], gunname[16];
			    new v = Vehicle[playerid];
			    if(TrunkInfo[v][Slot4] < 1) return SendClientMessage(playerid, 0xAFAFAFAA, "  There is nothing there !");
			    GetWeaponName(TrunkInfo[v][Slot4], gunname, sizeof(gunname));
			    format(string, sizeof(string), "You have taken your %s from slot 4 of your trunk.",gunname);
			    SendClientMessage(playerid, 0xFFFF00FF, string);
			    GivePlayerWeapon(playerid, TrunkInfo[v][Slot4], TrunkInfo[v][Ammo4]);
			    TrunkInfo[v][Slot4] = 0;
			    TrunkInfo[v][Ammo4] = 0;
			    return 1;
    		}
    		if(slot == 5){
				new string[128], gunname[16];
			    new v = Vehicle[playerid];
			    if(TrunkInfo[v][Slot5] < 1) return SendClientMessage(playerid, 0xAFAFAFAA, "  There is nothing there !");
			    GetWeaponName(TrunkInfo[v][Slot5], gunname, sizeof(gunname));
			    format(string, sizeof(string), "You have taken your %s from slot 5 of your trunk.",gunname);
			    SendClientMessage(playerid, 0xFFFF00FF, string);
			    GivePlayerWeapon(playerid, TrunkInfo[v][Slot5], TrunkInfo[v][Ammo5]);
			    TrunkInfo[v][Slot5] = 0;
			    TrunkInfo[v][Ammo5] = 0;
			    return 1;
    		}
    		if(slot == 6){
				new string[128], gunname[16];
			    new v = Vehicle[playerid];
			    if(TrunkInfo[v][Slot6] < 1) return SendClientMessage(playerid, 0xAFAFAFAA, "  There is nothing there !");
			    GetWeaponName(TrunkInfo[v][Slot6], gunname, sizeof(gunname));
			    format(string, sizeof(string), "You have taken your %s from slot 6 of your trunk.",gunname);
			    SendClientMessage(playerid, 0xFFFF00FF, string);
			    GivePlayerWeapon(playerid, TrunkInfo[v][Slot6], TrunkInfo[v][Ammo6]);
			    TrunkInfo[v][Slot6] = 0;
			    TrunkInfo[v][Ammo6] = 0;
			    return 1;
    		}
    		if(slot == 7){
				new string[128], gunname[16];
			    new v = Vehicle[playerid];
			    if(TrunkInfo[v][Slot7] < 1) return SendClientMessage(playerid, 0xAFAFAFAA, "  There is nothing there !");
			    GetWeaponName(TrunkInfo[v][Slot7], gunname, sizeof(gunname));
			    format(string, sizeof(string), "You have taken your %s from slot 7 of your trunk.",gunname);
			    SendClientMessage(playerid, 0xFFFF00FF, string);
			    GivePlayerWeapon(playerid, TrunkInfo[v][Slot7], TrunkInfo[v][Ammo7]);
			    TrunkInfo[v][Slot7] = 0;
			    TrunkInfo[v][Ammo7] = 0;
			    return 1;
    		}
    		if(slot == 8){
				new string[128], gunname[16];
			    new v = Vehicle[playerid];
			    if(TrunkInfo[v][Slot8] < 1) return SendClientMessage(playerid, 0xAFAFAFAA, "  There is nothing there !");
			    GetWeaponName(TrunkInfo[v][Slot8], gunname, sizeof(gunname));
			    format(string, sizeof(string), "You have taken your %s from slot 8 of your trunk.",gunname);
			    SendClientMessage(playerid, 0xFFFF00FF, string);
			    GivePlayerWeapon(playerid, TrunkInfo[v][Slot8], TrunkInfo[v][Ammo8]);
			    TrunkInfo[v][Slot8] = 0;
			    TrunkInfo[v][Ammo8] = 0;
			    return 1;
    		}
    		if(slot == 9){
				new string[128], gunname[16];
			    new v = Vehicle[playerid];
			    if(TrunkInfo[v][Slot9] < 1) return SendClientMessage(playerid, 0xAFAFAFAA, "  There is nothing there !");
			    GetWeaponName(TrunkInfo[v][Slot9], gunname, sizeof(gunname));
			    format(string, sizeof(string), "You have taken your %s from slot 9 of your trunk.",gunname);
			    SendClientMessage(playerid, 0xFFFF00FF, string);
			    GivePlayerWeapon(playerid, TrunkInfo[v][Slot9], TrunkInfo[v][Ammo9]);
			    TrunkInfo[v][Slot9] = 0;
			    TrunkInfo[v][Ammo9] = 0;
			    return 1;
    		}
    		if(slot == 10){
				new string[128], gunname[16];
			    new v = Vehicle[playerid];
			    if(TrunkInfo[v][Slot10] < 1) return SendClientMessage(playerid, 0xAFAFAFAA, "  There is nothing there !");
			    GetWeaponName(TrunkInfo[v][Slot10], gunname, sizeof(gunname));
			    format(string, sizeof(string), "You have taken your %s from slot 10 of your trunk.",gunname);
			    SendClientMessage(playerid, 0xFFFF00FF, string);
			    GivePlayerWeapon(playerid, TrunkInfo[v][Slot10], TrunkInfo[v][Ammo10]);
			    TrunkInfo[v][Slot10] = 0;
			    TrunkInfo[v][Ammo10] = 0;
			    return 1;
			}
    	}
    	if(strcmp(x_nr, "check", true) == 0){
		    new gunname[16], gunname2[16], gunname3[16], gunname4[16], gunname5[16], gunname6[16], gunname7[16], gunname8[16], gunname9[16],
			gunname10[16], string[64], string2[64], string3[64], string4[64], string5[64], string6[64], string7[64], string8[64], string9[64], string10[64];
		    if(TrunkOpen[Vehicle[playerid]] == 0) { SendClientMessage(playerid, 0xAFAFAFAA, "  You must open the trunk first !"); return 1; }
			GetWeaponName(TrunkInfo[Vehicle[playerid]][Slot1], gunname, sizeof(gunname));
			GetWeaponName(TrunkInfo[Vehicle[playerid]][Slot2], gunname2, sizeof(gunname2));
			GetWeaponName(TrunkInfo[Vehicle[playerid]][Slot3], gunname3, sizeof(gunname3));
			GetWeaponName(TrunkInfo[Vehicle[playerid]][Slot4], gunname4, sizeof(gunname4));
			GetWeaponName(TrunkInfo[Vehicle[playerid]][Slot5], gunname5, sizeof(gunname5));
			GetWeaponName(TrunkInfo[Vehicle[playerid]][Slot6], gunname6, sizeof(gunname6));
			GetWeaponName(TrunkInfo[Vehicle[playerid]][Slot7], gunname7, sizeof(gunname7));
			GetWeaponName(TrunkInfo[Vehicle[playerid]][Slot8], gunname8, sizeof(gunname8));
			GetWeaponName(TrunkInfo[Vehicle[playerid]][Slot9], gunname9, sizeof(gunname9));
			GetWeaponName(TrunkInfo[Vehicle[playerid]][Slot10], gunname10, sizeof(gunname10));
			SendClientMessage(playerid, 0x33AA33AA, "___________________________");
			if(TrunkInfo[Vehicle[playerid]][Slot1] != 0) { format(string, sizeof(string), "Slot 1: %s (%i Ammo)", gunname, TrunkInfo[Vehicle[playerid]][Ammo1]); } else { format(string, sizeof(string), "Slot 1: None (0 Ammo)"); }
			if(TrunkInfo[Vehicle[playerid]][Slot2] != 0) { format(string, sizeof(string), "Slot 2: %s (%i Ammo)", gunname, TrunkInfo[Vehicle[playerid]][Ammo2]); } else { format(string, sizeof(string), "Slot 2: None (0 Ammo)"); }
			if(TrunkInfo[Vehicle[playerid]][Slot3] != 0) { format(string, sizeof(string), "Slot 3: %s (%i Ammo)", gunname, TrunkInfo[Vehicle[playerid]][Ammo3]); } else { format(string, sizeof(string), "Slot 3: None (0 Ammo)"); }
			if(TrunkInfo[Vehicle[playerid]][Slot4] != 0) { format(string, sizeof(string), "Slot 4: %s (%i Ammo)", gunname, TrunkInfo[Vehicle[playerid]][Ammo4]); } else { format(string, sizeof(string), "Slot 4: None (0 Ammo)"); }
			if(TrunkInfo[Vehicle[playerid]][Slot5] != 0) { format(string, sizeof(string), "Slot 5: %s (%i Ammo)", gunname, TrunkInfo[Vehicle[playerid]][Ammo5]); } else { format(string, sizeof(string), "Slot 5: None (0 Ammo)"); }
			if(TrunkInfo[Vehicle[playerid]][Slot6] != 0) { format(string, sizeof(string), "Slot 6: %s (%i Ammo)", gunname, TrunkInfo[Vehicle[playerid]][Ammo6]); } else { format(string, sizeof(string), "Slot 6: None (0 Ammo)"); }
			if(TrunkInfo[Vehicle[playerid]][Slot7] != 0) { format(string, sizeof(string), "Slot 7: %s (%i Ammo)", gunname, TrunkInfo[Vehicle[playerid]][Ammo7]); } else { format(string, sizeof(string), "Slot 7: None (0 Ammo)"); }
			if(TrunkInfo[Vehicle[playerid]][Slot8] != 0) { format(string, sizeof(string), "Slot 8: %s (%i Ammo)", gunname, TrunkInfo[Vehicle[playerid]][Ammo8]); } else { format(string, sizeof(string), "Slot 8: None (0 Ammo)"); }
			if(TrunkInfo[Vehicle[playerid]][Slot9] != 0) { format(string, sizeof(string), "Slot 9: %s (%i Ammo)", gunname, TrunkInfo[Vehicle[playerid]][Ammo9]); } else { format(string, sizeof(string), "Slot 9: None (0 Ammo)"); }
			if(TrunkInfo[Vehicle[playerid]][Slot10] != 0) { format(string, sizeof(string), "Slot 10: %s (%i Ammo)", gunname, TrunkInfo[Vehicle[playerid]][Ammo10]); } else { format(string, sizeof(string), "Slot 10: None (0 Ammo)"); }
		    SendClientMessage(playerid, 0xFFFFFFFF, string);
		    SendClientMessage(playerid, 0xFFFFFFFF, string2);
		    SendClientMessage(playerid, 0xFFFFFFFF, string3);
		    SendClientMessage(playerid, 0xFFFFFFFF, string4);
		    SendClientMessage(playerid, 0xFFFFFFFF, string5);
		    SendClientMessage(playerid, 0xFFFFFFFF, string6);
		    SendClientMessage(playerid, 0xFFFFFFFF, string7);
		    SendClientMessage(playerid, 0xFFFFFFFF, string8);
		    SendClientMessage(playerid, 0xFFFFFFFF, string9);
		    SendClientMessage(playerid, 0xFFFFFFFF, string10);
		    SendClientMessage(playerid, 0x33AA33AA, "___________________________");
		    return 1;
		}
	    return 1;
 	}
	if(strcmp(cmd, "/lock", true) == 0){
     	if(gPlayerHasCar[playerid] == 1){
     	    new v, Float:vehx, Float:vehy, Float:vehz;
			v = Vehicle[playerid];
	    	GetVehiclePos(v, vehx, vehy, vehz);
    		if(IsPlayerInRangeOfPoint(playerid, 3.0, vehx, vehy, vehz)){
    		    if(VehicleInfo[playerid][Locked] == 0){
					SetVehicleParamsForPlayer(v, playerid, 0, 1);
			    	PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
					GameTextForPlayer(playerid, "~r~Car locked!", 3000, 6);
 					VehicleInfo[playerid][Locked] = 1;
	 				gVehLocked[v] = 1;
					return 1;
				}
				if(VehicleInfo[playerid][Locked] == 1){
					SetVehicleParamsForPlayer(v, playerid, 0, 0);
			    	PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
					GameTextForPlayer(playerid, "~g~Car unlocked!", 3000, 6);
 					VehicleInfo[playerid][Locked] = 0;
	 				gVehLocked[v] = 0;
					return 1;
				}
			}
			else{
			    SendClientMessage(playerid, 0xAFAFAFAA, "You are too far away from your vehicle.");
			    return 1;
   			}
		}
		else{
		    SendClientMessage(playerid, 0xAFAFAFAA, "You don't own a vehicle.");
		}
		return 1;
	}
	if(strcmp(cmd, "/carhelp", true) == 0){
	    SendClientMessage(playerid, 0x33AA33AA, "_______________________________________");
		SendClientMessage(playerid, 0xFFFFFFAA, "*** HELP *** type a command for more help");
		SendClientMessage(playerid, 0xCBCCCEFF, "*** CAR *** /trunk /park /sellcar /setplate /findcar /lock");
		return 1;
	}
	if(strcmp(cmd, "/setplate", true) == 0){
	    if(IsPlayerConnected(playerid)){
     	    if(!IsPlayerInVehicle(playerid, Vehicle[playerid])){
   		    	SendClientMessage(playerid, 0xFFFFFFAA, "You are not in a car that you own.");
				return 1;
			}
			if(IsACar(Vehicle[playerid])){
				ShowPlayerDialog(playerid, 670, DIALOG_STYLE_INPUT, "Plate", "Please set the vehicle's plate.", "Done", "Cancel");
			    return 1;
    		}
    		else{
    		    SendClientMessage(playerid, 0xAFAFAFAA, "This vehicle does not have a plate.");
    		    return 1;
		    }
    	}
    	return 1;
   	}
	if(strcmp(cmd, "/park", true) == 0){
     	new Float:X, Float:Y, Float:Z, Float:Rot;
   	  	if(!IsPlayerInVehicle(playerid, Vehicle[playerid])){
   			SendClientMessage(playerid, 0xFFFFFFAA, "You are not in a car that you own.");
			return 1;
		}
		new file[256], name[24];
    	GetPlayerName(playerid, name, 24);
		format(file,sizeof(file),"Cars/%s.ini",name);
	    dini_IntSet(file, "Model", VehicleInfo[playerid][Model]);
		dini_IntSet(file, "Price", VehicleInfo[playerid][Price]);
		dini_FloatSet(file, "X", VehicleInfo[playerid][CarX]);
		dini_FloatSet(file, "Y", VehicleInfo[playerid][CarY]);
		dini_FloatSet(file, "Z", VehicleInfo[playerid][CarZ]);
		dini_FloatSet(file, "Rot", VehicleInfo[playerid][CarRot]);
		dini_IntSet(file, "Locked", VehicleInfo[playerid][Locked]);
		dini_Set(file, "Plate", VehPlate[Vehicle[playerid]]);
		dini_IntSet(file, "mod1", VehicleInfo[playerid][mod1]);
		dini_IntSet(file, "mod2", VehicleInfo[playerid][mod2]);
		dini_IntSet(file, "mod3", VehicleInfo[playerid][mod3]);
		dini_IntSet(file, "mod4", VehicleInfo[playerid][mod4]);
		dini_IntSet(file, "mod5", VehicleInfo[playerid][mod5]);
		dini_IntSet(file, "mod6", VehicleInfo[playerid][mod6]);
		dini_IntSet(file, "mod7", VehicleInfo[playerid][mod7]);
		dini_IntSet(file, "mod8", VehicleInfo[playerid][mod8]);
		dini_IntSet(file, "mod9", VehicleInfo[playerid][mod9]);
		dini_IntSet(file, "mod10", VehicleInfo[playerid][mod10]);
		dini_IntSet(file, "mod11", VehicleInfo[playerid][mod11]);
		dini_IntSet(file, "mod12", VehicleInfo[playerid][mod12]);
		dini_IntSet(file, "mod13", VehicleInfo[playerid][mod13]);
		dini_IntSet(file, "mod14", VehicleInfo[playerid][mod14]);
		dini_IntSet(file, "mod15", VehicleInfo[playerid][mod15]);
		dini_IntSet(file, "mod16", VehicleInfo[playerid][mod16]);
		dini_IntSet(file, "mod17", VehicleInfo[playerid][mod17]);
		dini_IntSet(file, "paintjob", VehicleInfo[playerid][paintjob]);
		dini_IntSet(file, "color1", VehicleInfo[playerid][colora]);
		dini_IntSet(file, "color2", VehicleInfo[playerid][colorb]);
  		SendClientMessage(playerid, 0xFFFF00FF, "Car parked successfully, it'll respawn at your parked location.");
     	GetVehiclePos(Vehicle[playerid], X, Y, Z);
     	GetVehicleZAngle(Vehicle[playerid], Rot);
     	VehicleInfo[playerid][Model] = GetVehicleModel(playerid);
     	VehicleInfo[playerid][CarX] = X;
     	VehicleInfo[playerid][CarY] = Y;
     	VehicleInfo[playerid][CarZ] = Z;
     	VehicleInfo[playerid][CarRot] = Rot;
     	return 1;
	}
	if(strcmp(cmd, "/sellcar", true) == 0){
	    if(IsPlayerConnected(playerid)){
     	    if(!IsPlayerInVehicle(playerid, Vehicle[playerid])){
   		    	SendClientMessage(playerid, 0xFFFFFFAA, "You are not in a car that you own.");
				return 1;
			}
			if(ConfirmSale[playerid] == 0){
				SendClientMessage(playerid, 0xFFFF00FF, "Are you sure you want to sell your car? (Type /sellcar again to confirm).");
				ConfirmSale[playerid] = 1;
				return 1;
			}
   			new string[128], file[256], name[MAX_PLAYER_NAME];
    		GetPlayerName(playerid, name, sizeof(name));
			format(file,sizeof(file),"Cars/%s.ini",name);
			format(string, sizeof(string), "You have sold your car for a 50 percent value, for $%i.", VehicleInfo[playerid][Price]/2);
			GivePlayerMoney(playerid, VehicleInfo[playerid][Price]/2);
		 	DestroyVehicle(Vehicle[playerid]);
			dini_Remove(file);
			Vehicle[playerid] = 0;
			gPlayerHasCar[playerid] = 0;
	  		VehicleInfo[playerid][Model] = 0;
			VehicleInfo[playerid][Price] = 0;
			VehicleInfo[playerid][CarX] = 0;
			VehicleInfo[playerid][CarY] = 0;
			VehicleInfo[playerid][CarZ] = 0;
			VehicleInfo[playerid][CarRot] = 0;
			ConfirmSale[playerid] = 0;
		 	SendClientMessage(playerid, 0xFFFF00FF, string);
			return 1;
		}
		return 1;
	}
	if(strcmp(cmd, "/findcar", true) == 0){
	    if(IsPlayerConnected(playerid)){
	        if(gPlayerHasCar[playerid] == 1){
	        	new Float:vx, Float:vy, Float:vz;
	        	GetVehiclePos(Vehicle[playerid], vx, vy, vz);
	        	SetPlayerCheckpoint(playerid, vx, vy, vz, 10.0);
	        	Checkpoint[playerid] = 1;
	        	SendClientMessage(playerid, 0xFFFFFFAA, "Go to the checkpoint to find your car!");
	        	return 1;
     		}
     		else {
     		    SendClientMessage(playerid, 0xAFAFAFAA, "You don't own a vehicle.");
     		    return 1;
    		}
		}
		return 1;
	}
	return 0;
}
public OnPlayerEnterCheckpoint(playerid){
    if(Checkpoint[playerid] == 1){
	    PlayerPlaySound(playerid, 1149, 0.0, 0.0, 0.0);
	    DisablePlayerCheckpoint(playerid);
	    return 1;
	}
	return 1;
}
public OnVehicleStreamIn(vehicleid, forplayerid){
 	if(gVehLocked[vehicleid] == 1){
		SetVehicleParamsForPlayer(vehicleid, forplayerid, 0, 1);
		gVehLocked[vehicleid] = 1;
	}
  	else{
  		SetVehicleParamsForPlayer(vehicleid, forplayerid, 0, 0);
		gVehLocked[vehicleid] = 0;
   	}
	return 1;
}
public OnVehicleSpawn(vehicleid){
	if(Destroyed[vehicleid] == true){
        new file[256], name[MAX_PLAYER_NAME];
    	GetPlayerName(OwnerID[vehicleid], name, sizeof(name));
		format(file,sizeof(file),"Cars/%s.ini",name);
		if(dini_Exists(file)){
	    	VehicleInfo[OwnerID[vehicleid]][Model] = dini_Int(file, "Model");
	    	VehicleInfo[OwnerID[vehicleid]][Price] = dini_Int(file, "Price");
	    	VehicleInfo[OwnerID[vehicleid]][CarX] = dini_Float(file, "X");
	    	VehicleInfo[OwnerID[vehicleid]][CarY] = dini_Float(file, "Y");
	    	VehicleInfo[OwnerID[vehicleid]][CarZ] = dini_Float(file, "Z");
	    	VehicleInfo[OwnerID[vehicleid]][CarRot] = dini_Float(file, "Rot");
	    	VehicleInfo[OwnerID[vehicleid]][Locked] = dini_Int(file, "Locked");
			VehicleInfo[OwnerID[vehicleid]][mod1] = dini_Int(file, "mod1");
			VehicleInfo[OwnerID[vehicleid]][mod2] = dini_Int(file, "mod2");
			VehicleInfo[OwnerID[vehicleid]][mod3] = dini_Int(file, "mod3");
			VehicleInfo[OwnerID[vehicleid]][mod4] = dini_Int(file, "mod4");
			VehicleInfo[OwnerID[vehicleid]][mod5] = dini_Int(file, "mod5");
			VehicleInfo[OwnerID[vehicleid]][mod6] = dini_Int(file, "mod6");
			VehicleInfo[OwnerID[vehicleid]][mod7] = dini_Int(file, "mod7");
			VehicleInfo[OwnerID[vehicleid]][mod8] = dini_Int(file, "mod8");
			VehicleInfo[OwnerID[vehicleid]][mod9] = dini_Int(file, "mod9");
			VehicleInfo[OwnerID[vehicleid]][mod10] = dini_Int(file, "mod10");
			VehicleInfo[OwnerID[vehicleid]][mod11] = dini_Int(file, "mod11");
			VehicleInfo[OwnerID[vehicleid]][mod12] = dini_Int(file, "mod12");
			VehicleInfo[OwnerID[vehicleid]][mod13] = dini_Int(file, "mod13");
			VehicleInfo[OwnerID[vehicleid]][mod14] = dini_Int(file, "mod14");
			VehicleInfo[OwnerID[vehicleid]][mod15] = dini_Int(file, "mod15");
			VehicleInfo[OwnerID[vehicleid]][mod16] = dini_Int(file, "mod16");
			VehicleInfo[OwnerID[vehicleid]][mod17] = dini_Int(file, "mod17");
			VehicleInfo[OwnerID[vehicleid]][paintjob] = dini_Int(file, "paintjob");
			VehicleInfo[OwnerID[vehicleid]][colora] = dini_Int(file, "color1");
			VehicleInfo[OwnerID[vehicleid]][colorb] = dini_Int(file, "color2");
			Vehicle[OwnerID[vehicleid]] = CreateVehicle(VehicleInfo[OwnerID[vehicleid]][Model], VehicleInfo[OwnerID[vehicleid]][CarX], VehicleInfo[OwnerID[vehicleid]][CarY], VehicleInfo[OwnerID[vehicleid]][CarZ], VehicleInfo[OwnerID[vehicleid]][CarRot], -1, -1, 3600000);
    		if(VehicleInfo[OwnerID[vehicleid]][mod1]!=0) { AddVehicleComponent(Vehicle[OwnerID[vehicleid]],VehicleInfo[OwnerID[vehicleid]][mod1]); }
			if(VehicleInfo[OwnerID[vehicleid]][mod2]!=0) { AddVehicleComponent(Vehicle[OwnerID[vehicleid]],VehicleInfo[OwnerID[vehicleid]][mod2]); }
			if(VehicleInfo[OwnerID[vehicleid]][mod3]!=0) { AddVehicleComponent(Vehicle[OwnerID[vehicleid]],VehicleInfo[OwnerID[vehicleid]][mod3]); }
			if(VehicleInfo[OwnerID[vehicleid]][mod4]!=0) { AddVehicleComponent(Vehicle[OwnerID[vehicleid]],VehicleInfo[OwnerID[vehicleid]][mod4]); }
			if(VehicleInfo[OwnerID[vehicleid]][mod5]!=0) { AddVehicleComponent(Vehicle[OwnerID[vehicleid]],VehicleInfo[OwnerID[vehicleid]][mod5]); }
			if(VehicleInfo[OwnerID[vehicleid]][mod6]!=0) { AddVehicleComponent(Vehicle[OwnerID[vehicleid]],VehicleInfo[OwnerID[vehicleid]][mod6]); }
			if(VehicleInfo[OwnerID[vehicleid]][mod7]!=0) { AddVehicleComponent(Vehicle[OwnerID[vehicleid]],VehicleInfo[OwnerID[vehicleid]][mod7]); }
			if(VehicleInfo[OwnerID[vehicleid]][mod8]!=0) { AddVehicleComponent(Vehicle[OwnerID[vehicleid]],VehicleInfo[OwnerID[vehicleid]][mod8]); }
			if(VehicleInfo[OwnerID[vehicleid]][mod9]!=0) { AddVehicleComponent(Vehicle[OwnerID[vehicleid]],VehicleInfo[OwnerID[vehicleid]][mod9]); }
			if(VehicleInfo[OwnerID[vehicleid]][mod10]!=0) { AddVehicleComponent(Vehicle[OwnerID[vehicleid]],VehicleInfo[OwnerID[vehicleid]][mod10]); }
			if(VehicleInfo[OwnerID[vehicleid]][mod11]!=0) { AddVehicleComponent(Vehicle[OwnerID[vehicleid]],VehicleInfo[OwnerID[vehicleid]][mod11]); }
			if(VehicleInfo[OwnerID[vehicleid]][mod12]!=0) { AddVehicleComponent(Vehicle[OwnerID[vehicleid]],VehicleInfo[OwnerID[vehicleid]][mod12]); }
			if(VehicleInfo[OwnerID[vehicleid]][mod13]!=0) { AddVehicleComponent(Vehicle[OwnerID[vehicleid]],VehicleInfo[OwnerID[vehicleid]][mod13]); }
			if(VehicleInfo[OwnerID[vehicleid]][mod14]!=0) { AddVehicleComponent(Vehicle[OwnerID[vehicleid]],VehicleInfo[OwnerID[vehicleid]][mod14]); }
			if(VehicleInfo[OwnerID[vehicleid]][mod15]!=0) { AddVehicleComponent(Vehicle[OwnerID[vehicleid]],VehicleInfo[OwnerID[vehicleid]][mod15]); }
			if(VehicleInfo[OwnerID[vehicleid]][mod16]!=0) { AddVehicleComponent(Vehicle[OwnerID[vehicleid]],VehicleInfo[OwnerID[vehicleid]][mod16]); }
			if(VehicleInfo[OwnerID[vehicleid]][mod17]!=0) { AddVehicleComponent(Vehicle[OwnerID[vehicleid]],VehicleInfo[OwnerID[vehicleid]][mod17]); }
			if(VehicleInfo[OwnerID[vehicleid]][colora]!=0 || VehicleInfo[OwnerID[vehicleid]][colorb]!=0){
				ChangeVehicleColor(Vehicle[OwnerID[vehicleid]],VehicleInfo[OwnerID[vehicleid]][colora],VehicleInfo[OwnerID[vehicleid]][colorb]);
			}
			if(VehicleInfo[OwnerID[vehicleid]][paintjob]!=0){
		    	ChangeVehiclePaintjob(Vehicle[OwnerID[vehicleid]],VehicleInfo[OwnerID[vehicleid]][paintjob]);
  			}
			new tmp[256]; tmp = dini_Get(file, "Plate");
			gPlayerHasCar[OwnerID[vehicleid]] = 1;
			VehOwned[Vehicle[OwnerID[vehicleid]]] = 1;
			SetVehicleParamsForPlayer(Vehicle[OwnerID[vehicleid]], OwnerID[vehicleid], 0, VehicleInfo[OwnerID[vehicleid]][Locked]);
			gVehLocked[Vehicle[OwnerID[vehicleid]]] = VehicleInfo[OwnerID[vehicleid]][Locked];
			SetVehicleNumberPlate(Vehicle[OwnerID[vehicleid]], tmp);
			VehPlate[Vehicle[OwnerID[vehicleid]]] = tmp;
			Destroyed[vehicleid] = false;
		}
	}
	return 1;
}
public OnVehicleDeath(vehicleid, killerid){
    new string[32], playername[MAX_PLAYER_NAME];
	GetPlayerName(killerid, playername, sizeof(playername));
	format(string, sizeof(string), "Trunk/%s.ini", playername);
	new File: hFile = fopen(string, io_write);
	if(hFile){
	    // Vehicle destroyed, too bad...
	    fclose(hFile);
		fremove(string);
	}
	Destroyed[vehicleid] = true;
	new file[256], name[24];
    GetPlayerName(killerid, name, 24);
	format(file,sizeof(file),"Cars/%s.ini",name);
	if(dini_Exists(file)){
	    dini_IntSet(file, "Model", GetVehicleModel(Vehicle[killerid]));
		dini_IntSet(file, "Price", VehicleInfo[killerid][Price]);
		dini_FloatSet(file, "X", VehicleInfo[killerid][CarX]);
		dini_FloatSet(file, "Y", VehicleInfo[killerid][CarY]);
		dini_FloatSet(file, "Z", VehicleInfo[killerid][CarZ]);
		dini_FloatSet(file, "Rot", VehicleInfo[killerid][CarRot]);
		dini_IntSet(file, "Locked", VehicleInfo[killerid][Locked]);
		dini_Set(file, "Plate", VehPlate[Vehicle[killerid]]);
		dini_IntSet(file, "mod1", VehicleInfo[killerid][mod1]);
		dini_IntSet(file, "mod2", VehicleInfo[killerid][mod2]);
		dini_IntSet(file, "mod3", VehicleInfo[killerid][mod3]);
		dini_IntSet(file, "mod4", VehicleInfo[killerid][mod4]);
		dini_IntSet(file, "mod5", VehicleInfo[killerid][mod5]);
		dini_IntSet(file, "mod6", VehicleInfo[killerid][mod6]);
		dini_IntSet(file, "mod7", VehicleInfo[killerid][mod7]);
		dini_IntSet(file, "mod8", VehicleInfo[killerid][mod8]);
		dini_IntSet(file, "mod9", VehicleInfo[killerid][mod9]);
		dini_IntSet(file, "mod10", VehicleInfo[killerid][mod10]);
		dini_IntSet(file, "mod11", VehicleInfo[killerid][mod11]);
		dini_IntSet(file, "mod12", VehicleInfo[killerid][mod12]);
		dini_IntSet(file, "mod13", VehicleInfo[killerid][mod13]);
		dini_IntSet(file, "mod14", VehicleInfo[killerid][mod14]);
		dini_IntSet(file, "mod15", VehicleInfo[killerid][mod15]);
		dini_IntSet(file, "mod16", VehicleInfo[killerid][mod16]);
		dini_IntSet(file, "mod17", VehicleInfo[killerid][mod17]);
		dini_IntSet(file, "paintjob", VehicleInfo[killerid][paintjob]);
		dini_IntSet(file, "color1", VehicleInfo[killerid][colora]);
		dini_IntSet(file, "color2", VehicleInfo[killerid][colorb]);
	}
	SetVehicleToRespawn(vehicleid);
	return 1;
}
stock IsACar(vehicleid){
    switch(GetVehicleModel(vehicleid)){
        case 400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,
		418,419,420,421,422,423,424,426,427,428,429,431,432,433,434,435,436,437,438,
		439,440,442,443,444,445,451,455,456,458,459,466,467,470,474,475,477,478,479,
		480,482,483,486,489,490,491,492,494,495,496,498,499,500,502,503,504,505,506,
		507,508,514,515,516,517,518,524,525,526,527,528,529,533,534,535,536,540,541,
		542,543,544,545,546,547,549,550,551,552,554,555,556,557,558,559,560,561,562,
		565,566,567,568,573,575,576,578,579,580,582,585,587,588, 589,596,597,598,599,
		600,601,602,603,604,605,609: return 1;
    }
    return 1;
}
public SaveTrunk(playerid){
	if(IsPlayerConnected(playerid)){
		if(gPlayerHasCar[playerid] == 1){
			new string[32];
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			format(string, sizeof(string), "Trunk/%s.ini", playername);
			new File: hFile = fopen(string, io_write);
			if(hFile){
                new var[64];
                format(var, 32, "Slot1=%i\n", TrunkInfo[Vehicle[playerid]][Slot1]);
                fwrite(hFile, var);
                format(var, 32, "Slot2=%i\n", TrunkInfo[Vehicle[playerid]][Slot2]);
                fwrite(hFile, var);
                format(var, 32, "Slot3=%i\n", TrunkInfo[Vehicle[playerid]][Slot3]);
                fwrite(hFile, var);
                format(var, 32, "Slot4=%i\n", TrunkInfo[Vehicle[playerid]][Slot4]);
                fwrite(hFile, var);
                format(var, 32, "Slot5=%i\n", TrunkInfo[Vehicle[playerid]][Slot5]);
                fwrite(hFile, var);
                format(var, 32, "Slot6=%i\n", TrunkInfo[Vehicle[playerid]][Slot6]);
                fwrite(hFile, var);
                format(var, 32, "Slot7=%i\n", TrunkInfo[Vehicle[playerid]][Slot7]);
                fwrite(hFile, var);
                format(var, 32, "Slot8=%i\n", TrunkInfo[Vehicle[playerid]][Slot8]);
                fwrite(hFile, var);
                format(var, 32, "Slot9=%i\n", TrunkInfo[Vehicle[playerid]][Slot9]);
                fwrite(hFile, var);
                format(var, 32, "Slot10=%i\n", TrunkInfo[Vehicle[playerid]][Slot10]);
                fwrite(hFile, var);
                format(var, 32, "Ammo1=%i\n", TrunkInfo[Vehicle[playerid]][Ammo1]);
                fwrite(hFile, var);
                format(var, 32, "Ammo2=%i\n", TrunkInfo[Vehicle[playerid]][Ammo2]);
                fwrite(hFile, var);
                format(var, 32, "Ammo3=%i\n", TrunkInfo[Vehicle[playerid]][Ammo3]);
                fwrite(hFile, var);
                format(var, 32, "Ammo4=%i\n", TrunkInfo[Vehicle[playerid]][Ammo4]);
                fwrite(hFile, var);
                format(var, 32, "Ammo5=%i\n", TrunkInfo[Vehicle[playerid]][Ammo5]);
                fwrite(hFile, var);
                format(var, 32, "Ammo6=%i\n", TrunkInfo[Vehicle[playerid]][Ammo6]);
                fwrite(hFile, var);
                format(var, 32, "Ammo7=%i\n", TrunkInfo[Vehicle[playerid]][Ammo7]);
                fwrite(hFile, var);
                format(var, 32, "Ammo8=%i\n", TrunkInfo[Vehicle[playerid]][Ammo8]);
                fwrite(hFile, var);
                format(var, 32, "Ammo9=%i\n", TrunkInfo[Vehicle[playerid]][Ammo9]);
                fwrite(hFile, var);
                format(var, 32, "Ammo10=%i\n", TrunkInfo[Vehicle[playerid]][Ammo10]);
                fwrite(hFile, var);
                fclose(hFile);
			}
		}
	}
	return 1;
}
public LoadTrunk(playerid){
    new string[128], Playername[24];
    GetPlayerName(playerid, Playername, 24);
	format(string, sizeof(string), "Trunk/%s.ini", Playername);
	new File: UserFile = fopen(string, io_read);
	if(UserFile){
	    new key[256], val[256], Data[256];
		while(fread(UserFile, Data, sizeof(Data))){
  			key = ini_GetKey(Data);
	 		if( strcmp( key , "Slot1" , true ) == 0 ){
		 		val = ini_GetValue(Data);
			 	TrunkInfo[Vehicle[playerid]][Slot1] = strval(val);
			}
			if( strcmp( key , "Slot2" , true ) == 0 ){
		 		val = ini_GetValue(Data);
			 	TrunkInfo[Vehicle[playerid]][Slot2] = strval(val);
			}
			if( strcmp( key , "Slot3" , true ) == 0 ){
		 		val = ini_GetValue(Data);
			 	TrunkInfo[Vehicle[playerid]][Slot3] = strval(val);
			}
			if( strcmp( key , "Slot4" , true ) == 0 ){
		 		val = ini_GetValue(Data);
			 	TrunkInfo[Vehicle[playerid]][Slot4] = strval(val);
			}
			if( strcmp( key , "Slot5" , true ) == 0 ){
		 		val = ini_GetValue(Data);
			 	TrunkInfo[Vehicle[playerid]][Slot5] = strval(val);
			}
			if( strcmp( key , "Slot6" , true ) == 0 ){
		 		val = ini_GetValue(Data);
			 	TrunkInfo[Vehicle[playerid]][Slot6] = strval(val);
			}
			if( strcmp( key , "Slot7" , true ) == 0 ){
		 		val = ini_GetValue(Data);
			 	TrunkInfo[Vehicle[playerid]][Slot7] = strval(val);
			}
			if( strcmp( key , "Slot8" , true ) == 0 ){
		 		val = ini_GetValue(Data);
			 	TrunkInfo[Vehicle[playerid]][Slot8] = strval(val);
			}
			if( strcmp( key , "Slot9" , true ) == 0 ){
		 		val = ini_GetValue(Data);
			 	TrunkInfo[Vehicle[playerid]][Slot9] = strval(val);
			}
			if( strcmp( key , "Slot10" , true ) == 0 ){
		 		val = ini_GetValue(Data);
			 	TrunkInfo[Vehicle[playerid]][Slot10] = strval(val);
			}
			if( strcmp( key , "Ammo1" , true ) == 0 ){
		 		val = ini_GetValue(Data);
			 	TrunkInfo[Vehicle[playerid]][Ammo1] = strval(val);
			}
			if( strcmp( key , "Ammo2" , true ) == 0 ){
		 		val = ini_GetValue(Data);
			 	TrunkInfo[Vehicle[playerid]][Ammo2] = strval(val);
			}
			if( strcmp( key , "Ammo3" , true ) == 0 ){
		 		val = ini_GetValue(Data);
			 	TrunkInfo[Vehicle[playerid]][Ammo3] = strval(val);
			}
			if( strcmp( key , "Ammo4" , true ) == 0 ){
		 		val = ini_GetValue(Data);
			 	TrunkInfo[Vehicle[playerid]][Ammo4] = strval(val);
			}
			if( strcmp( key , "Ammo5" , true ) == 0 ){
		 		val = ini_GetValue(Data);
			 	TrunkInfo[Vehicle[playerid]][Ammo5] = strval(val);
			}
			if( strcmp( key , "Ammo6" , true ) == 0 ){
		 		val = ini_GetValue(Data);
			 	TrunkInfo[Vehicle[playerid]][Ammo6] = strval(val);
			}
			if( strcmp( key , "Ammo7" , true ) == 0 ){
		 		val = ini_GetValue(Data);
			 	TrunkInfo[Vehicle[playerid]][Ammo7] = strval(val);
			}
			if( strcmp( key , "Ammo8" , true ) == 0 ){
		 		val = ini_GetValue(Data);
			 	TrunkInfo[Vehicle[playerid]][Ammo8] = strval(val);
			}
			if( strcmp( key , "Ammo9" , true ) == 0 ){
		 		val = ini_GetValue(Data);
			 	TrunkInfo[Vehicle[playerid]][Ammo9] = strval(val);
			}
			if( strcmp( key , "Ammo10" , true ) == 0 ){
		 		val = ini_GetValue(Data);
			 	TrunkInfo[Vehicle[playerid]][Ammo10] = strval(val);
			}
		}
		fclose(UserFile);
	}
	return 1;
}
public RemovePlayerWeapon(playerid, weaponid){
	new plyWeapons[12] = 0;
	new plyAmmo[12] = 0;
	for(new slot = 0; slot != 12; slot++){
		new wep, ammo;
		GetPlayerWeaponData(playerid, slot, wep, ammo);
		if(wep != weaponid && ammo != 0){
			GetPlayerWeaponData(playerid, slot, plyWeapons[slot], plyAmmo[slot]);
		}
	}
	ResetPlayerWeapons(playerid);
	for(new slot = 0; slot != 12; slot++){
	    if(plyAmmo[slot] != 0){
			GivePlayerWeapon(playerid, plyWeapons[slot], plyAmmo[slot]);
		}
	}
	return 1;
}
