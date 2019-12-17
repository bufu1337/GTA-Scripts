//------------------------------------------------------------------------------
//                       FilterScript New Year by Eragon
//                        SA-MP .::: Eragon Studio :::.
//                         http://eragon-studio.3dn.ru
//------------------------------------------------------------------------------
#include a_samp.inc
#include <YSI>

#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BLUE 0xFFFF00AA
#define COLOR_SYSTEM 0xBCBCBCAA
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

new alco[MAX_PLAYERS] = 0;
new necost[MAX_PLAYERS] = 0;
new lift;
new TimerLoc;
new Menu:LiftMenu, Menu:DrinkMenu, Menu:RadioMenu;
new Timer1, Timer2[MAX_PLAYERS];
new CountT = 10;
new Year2008[13];
new Year2009[12];
new StatusRadio = 1;
new randpick[10][1] = {
	{1212},
	{1240},
	{322},
	{1242},
	{335},
	{339},
	{346},
	{371},
	{353},
	{372}
	};
new ChannelsStart[7] = {1062, 1068, 1076, 1097, 1183, 1185, 1187};
new ChannelsStop[7]  = {1063, 1069, 1077, 1098, 1184, 1186, 1188};
new Currentplaying = 0;

forward StripDance(playerid);
forward Count();
forward NewYearStart();
forward ResetCam(playerid);
forward GetLocation();
forward NextTrack(playerid);
forward PrevTrack(playerid);

stock IsPlayerInSphere(playerid,Float:x,Float:y,Float:z,radius) //By Sacky
{
	if(GetPlayerDistanceToPointEx(playerid,x,y,z) < radius)
		return 1;
	return 0;
}

stock GetPlayerDistanceToPointEx(playerid,Float:x,Float:y,Float:z) //By Sacky
{
	new Float:x1,Float:y1,Float:z1;
	new Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	tmpdis = floatsqroot(floatpower(floatabs(floatsub(x,x1)),2)+floatpower(floatabs(floatsub(y,y1)),2)+floatpower(floatabs(floatsub(z,z1)),2));
	return floatround(tmpdis);
}
//------------------------------------------------------------------------------
public OnFilterScriptInit()
{
		print("=====================================");
		print("|                                   |");
		print("|         New Year v.2009 M1        |");
		print("|             by Eragon             |");
		print("|           -------------           |");
		print("|    http://eragon-studio.net.ru    |");
		print("|                                   |");
		print("=====================================");
		lift = CreateObject(974,1567.153,-1185.108,45.754,-89.381,0.0,-90.000); // lift-down
        SetWorldTime(0);
        CreateObject(1215,1570.404,-1181.167,280.395,0.0,0.0,0.0); // object (56)
		CreateObject(1215,1570.267,-1186.118,280.395,0.0,0.0,0.0); // object (57)
		CreateObject(1215,1592.486,-1250.745,277.443,0.0,0.0,0.0); // object (58)
		CreateObject(1215,1592.486,-1248.228,277.443,0.0,0.0,0.0); // object (59)
		CreateObject(1215,1553.617,-1257.664,277.145,0.0,0.0,0.0); // object (60)
		CreateObject(1215,1555.168,-1252.907,277.141,0.0,0.0,0.0); // object (61)
		CreateObject(1215,1559.840,-1251.947,277.116,0.0,0.0,0.0); // object (62)
		CreateObject(1215,1561.692,-1255.442,277.142,0.0,0.0,0.0); // object (63)
		CreateObject(1215,1557.875,-1254.962,277.142,0.0,0.0,0.0); // object (64)
		CreateObject(1215,1565.742,-1258.395,277.216,0.0,0.0,0.0); // object (65)
		CreateObject(1215,1570.350,-1259.484,277.216,0.0,0.0,0.0); // object (66)
		CreateObject(1215,1569.737,-1264.102,277.218,0.0,0.0,0.0); // object (67)
		CreateObject(1215,1565.623,-1262.816,277.218,0.0,0.0,0.0); // object (68)
		CreateObject(3472,1549.946,-1249.156,277.202,0.0,0.0,0.0); // object (1)
		CreateObject(3534,1556.192,-1261.065,294.684,0.0,0.0,45.000); // object (2)
		CreateObject(7666,1557.840,-1259.530,297.687,0.0,0.0,33.750); // object (4)
		CreateObject(654,1557.681,-1259.363,276.837,0.0,0.0,0.0); // object (11)
		CreateObject(7666,1557.832,-1259.558,297.657,0.0,0.0,112.500); // object (12)
		CreateObject(4874,1589.691,-1214.666,280.363,0.0,0.0,-90.000); // object (14)
		CreateObject(3399,1571.092,-1177.154,43.571,0.0,0.0,-90.000); // object (17)
		CreateObject(3399,1571.099,-1165.749,39.046,0.0,0.0,-90.000); // object (18)
		CreateObject(3399,1571.105,-1155.795,34.479,0.0,0.0,-90.000); // object (19)
		CreateObject(3399,1571.117,-1146.425,29.921,0.0,0.0,-90.000); // object (20)
		CreateObject(3399,1571.101,-1136.655,25.257,0.0,0.0,-90.000); // object (21)
		CreateObject(1215,1572.489,-1132.229,23.063,0.0,0.0,0.0); // object (22)
		CreateObject(1215,1569.323,-1132.199,23.063,0.0,0.0,0.0); // object (23)
		CreateObject(1215,1569.998,-1170.502,41.771,0.0,0.0,0.0); // object (24)
		CreateObject(1215,1571.907,-1170.497,41.769,0.0,0.0,0.0); // object (25)
		CreateObject(1215,1571.867,-1184.003,46.344,0.0,0.0,0.0); // object (26)
		CreateObject(1215,1569.992,-1184.028,46.319,0.0,0.0,0.0); // object (27)
		CreateObject(1257,1568.209,-1123.497,23.843,0.0,0.0,-168.750); // object (28)
		CreateObject(7388,1564.362,-1153.393,22.997,0.0,0.0,0.0); // object (29)
		CreateObject(7392,1606.584,-1182.111,288.290,0.0,0.0,0.0); // object (30)
		CreateObject(16151,1565.874,-1268.579,277.275,0.0,0.0,-90.000); // object (33)
		CreateObject(14651,1559.448,-1264.027,278.974,0.0,0.0,33.750); // object (36)
		CreateObject(14651,1560.546,-1262.419,278.999,0.0,0.0,-146.250); // object (37)
		CreateObject(643,1565.656,-1262.748,277.353,0.0,0.0,0.0); // object (38)
		CreateObject(643,1569.719,-1264.061,277.353,0.0,0.0,-56.250); // object (39)
		CreateObject(643,1565.749,-1258.334,277.351,0.0,0.0,-56.250); // object (40)
		CreateObject(643,1570.275,-1259.469,277.352,0.0,0.0,-112.500); // object (41)
		CreateObject(1432,1553.628,-1257.686,277.015,0.0,0.0,0.0); // object (42)
		CreateObject(1432,1557.862,-1254.967,277.012,0.0,0.0,0.0); // object (43)
		CreateObject(1432,1561.694,-1255.426,277.012,0.0,0.0,0.0); // object (44)
		CreateObject(1432,1559.882,-1251.985,277.011,0.0,0.0,-33.750); // object (45)
		CreateObject(1432,1555.096,-1252.877,277.011,0.0,0.0,-45.000); // object (46)
		CreateObject(1670,1565.581,-1262.757,277.764,0.0,0.0,0.0); // object (47)
		CreateObject(1670,1557.846,-1255.090,277.638,0.0,0.0,-22.500); // object (48)
		CreateObject(2125,1564.903,-1266.730,277.193,0.0,0.0,0.0); // object (49)
		CreateObject(3472,1571.138,-1269.320,277.227,0.0,0.0,0.0); // object (145)
		CreateObject(3472,1554.219,-1264.965,277.139,0.0,0.0,0.0); // object (146)
		CreateObject(1215,1557.986,-1259.589,277.586,0.0,0.0,0.0); // object (147)
		CreateObject(1215,1557.936,-1259.563,282.298,0.0,0.0,0.0); // object (148)
		CreateObject(354,1557.761,-1259.596,297.833,0.0,0.0,-11.250); // star
		CreateObject(970,1556.834,-1267.413,277.394,0.0,0.0,-22.500); // object (151)
		CreateObject(970,1553.178,-1265.080,277.426,0.0,0.0,-45.000); // object (152)
		CreateObject(970,1550.713,-1261.564,277.426,0.0,0.0,-67.500); // object (153)
		CreateObject(970,1549.013,-1257.314,277.426,0.0,0.0,-78.750); // object (154)
		CreateObject(970,1550.127,-1248.423,277.409,0.0,0.0,22.500); // object (155)
		CreateObject(970,1561.781,-1268.968,277.376,0.0,0.0,-11.250); // object (156)
		CreateObject(970,1571.705,-1268.932,277.434,0.0,0.0,22.500); // object (157)
		CreateObject(3374,1581.531,-1233.547,281.369,0.0,0.0,11.250); // object (205)
		CreateObject(3374,1581.520,-1233.461,284.369,0.0,0.0,11.250); // object (206)
		CreateObject(3374,1581.532,-1233.312,287.369,0.0,0.0,11.250); // object (207)
		CreateObject(3374,1581.480,-1233.407,290.369,0.0,0.0,11.250); // object (208)
		CreateObject(3374,1577.583,-1234.175,290.359,0.0,0.0,11.250); // object (209)
		CreateObject(1215,1584.558,-1235.263,277.440,0.0,0.0,0.0); // object (220)
		CreateObject(1215,1596.888,-1232.714,277.439,0.0,0.0,0.0); // object (221)
		CreateObject(1215,1571.661,-1237.907,277.440,0.0,0.0,0.0); // object (222)
		CreateObject(1215,1558.653,-1240.631,277.445,0.0,0.0,0.0); // object (223)
		CreateObject(1215,1548.852,-1243.337,277.447,0.0,0.0,0.0); // object (224)
		CreateObject(1262,1558.313,-1259.095,283.908,0.0,0.0,-33.750); // object (221)
		CreateObject(1262,1557.944,-1259.095,288.049,0.0,0.0,22.500); // object (222)
		CreateObject(1262,1558.387,-1259.817,289.039,0.0,0.0,-112.500); // object (223)
		CreateObject(654,1557.705,-1259.380,277.084,0.0,0.0,0.0); // object (233)
		CreateObject(3461,1597.370,-1214.217,281.381,0.0,0.0,0.0); // object (234)
		CreateObject(3461,1602.932,-1214.303,281.356,0.0,0.0,0.0); // object (235)
		CreateObject(3461,1597.495,-1223.139,281.365,0.0,0.0,0.0); // object (236)
		CreateObject(3461,1602.870,-1223.207,281.340,0.0,0.0,0.0); // object (237)
		CreateObject(3461,1597.503,-1245.239,281.340,0.0,0.0,0.0); // object (238)
		CreateObject(3461,1602.780,-1245.368,281.390,0.0,0.0,0.0); // object (239)
		CreateObject(3461,1597.505,-1239.716,281.365,0.0,0.0,0.0); // object (240)
		CreateObject(3461,1597.521,-1234.411,281.390,0.0,0.0,0.0); // object (241)
		CreateObject(3461,1597.494,-1229.215,281.390,0.0,0.0,0.0); // object (242)
		CreateObject(3461,1602.872,-1229.033,281.390,0.0,0.0,0.0); // object (243)
		CreateObject(3461,1602.911,-1234.484,281.340,0.0,0.0,0.0); // object (244)
		CreateObject(3461,1602.886,-1239.813,281.365,0.0,0.0,0.0); // object (245)
		CreateObject(3461,1602.893,-1253.542,281.449,0.0,0.0,0.0); // object (246)
		CreateObject(3461,1597.499,-1253.541,281.326,0.0,0.0,0.0); // object (247)
		CreateObject(2780,1594.542,-1235.542,275.151,0.0,0.0,0.0); // object (248)
		CreateObject(2780,1585.221,-1237.750,273.177,0.0,0.0,0.0); // object (249)
		CreateObject(2780,1574.227,-1240.180,273.026,0.0,0.0,0.0); // object (250)
		CreateObject(2780,1550.079,-1244.791,275.708,0.0,0.0,0.0); // object (253)
		CreateObject(2780,1562.288,-1242.863,275.680,0.0,0.0,0.0); // object (254)
		CreateObject(2780,1595.261,-1220.963,276.872,0.0,0.0,0.0); // object (255)
		CreateObject(14608,1578.033,-1263.315,278.453,0.0,0.0,-11.250); // object (258)
		CreateObject(3472,1572.124,-1191.519,276.421,0.0,0.0,0.0); // object (259)
		CreateObject(3472,1572.570,-1177.724,276.613,0.0,0.0,0.0); // object (260)
		CreateObject(3472,1601.851,-1181.564,280.150,0.0,0.0,0.0); // object (261)
		CreateObject(3472,1489.389,-1261.225,273.229,0.0,0.0,0.0); // object (262)
		CreateObject(3472,1572.923,-1214.475,280.066,0.0,0.0,0.0); // object (263)
		CreateObject(3472,1636.343,-1316.113,239.957,0.0,0.0,0.0); // object (264)
		
		Year2008[0] = CreateObject(3374,1586.539,-1232.418,278.369,0.0,0.0,11.250); // 1-8
		Year2008[1] = CreateObject(3374,1590.422,-1231.651,278.369,0.0,0.0,11.250); // 2-8
		Year2008[2] = CreateObject(3374,1594.402,-1230.933,278.369,0.0,0.0,11.250); // 3-8
		Year2008[3] = CreateObject(3374,1594.362,-1230.872,281.369,0.0,0.0,11.250); // 4-8
		Year2008[4] = CreateObject(3374,1594.392,-1230.765,284.369,0.0,0.0,11.250); // 5-8
		Year2008[5] = CreateObject(3374,1594.537,-1230.543,287.369,0.0,0.0,11.250); // 6-8
		Year2008[6] = CreateObject(3374,1594.395,-1230.635,290.369,0.0,0.0,11.250); // 7-8
		Year2008[7] = CreateObject(3374,1590.541,-1231.452,290.341,0.0,0.0,11.250); // 8-8
		Year2008[8] = CreateObject(3374,1586.609,-1232.287,290.369,0.0,0.0,11.250); // 9-8
		Year2008[9] = CreateObject(3374,1586.588,-1232.221,287.369,0.0,0.0,11.250); // 10-8
		Year2008[10] = CreateObject(3374,1586.534,-1232.273,284.369,0.0,0.0,11.250); // 11-8
		Year2008[11] = CreateObject(3374,1586.543,-1232.350,281.369,0.0,0.0,11.250); // 12-8
		Year2008[12] = CreateObject(3374,1590.429,-1231.496,284.315,0.0,0.0,11.250); // 13-8
		
		TimerLoc = SetTimer("GetLocation",500,1);
		
		LiftMenu = CreateMenu("Lift", 1, 30.0, 150.0, 100.0, 140.0);
	    SetMenuColumnHeader(LiftMenu, 0, "Lift Menu:");
	    AddMenuItem(LiftMenu, 0, "Up");
	    AddMenuItem(LiftMenu, 0, "Stop");
	    AddMenuItem(LiftMenu, 0, "Down");
	    AddMenuItem(LiftMenu, 0, "Close");

		DrinkMenu = CreateMenu("Drink", 1, 30.0, 150.0, 100.0, 140.0);
	    SetMenuColumnHeader(DrinkMenu, 0, "Bar Menu:");
	    AddMenuItem(DrinkMenu, 0, "Cola 2$");
	    AddMenuItem(DrinkMenu, 0, "Pivo 7$");
	    AddMenuItem(DrinkMenu, 0, "Vino 20$");
	    AddMenuItem(DrinkMenu, 0, "Coniak 30$");
	    AddMenuItem(DrinkMenu, 0, "Viski 40$");
	    AddMenuItem(DrinkMenu, 0, "Mortini 35$");
	    AddMenuItem(DrinkMenu, 0, "Samogon 25$");
	    AddMenuItem(DrinkMenu, 0, "Vodka 30$");
	    AddMenuItem(DrinkMenu, 0, "Close");
	    RadioMenu = CreateMenu("Radio", 1, 30.0, 150.0, 100.0, 140.0);
	    SetMenuColumnHeader(RadioMenu, 0, "Radio Menu:");
	    AddMenuItem(RadioMenu, 0, "On.Off");
	    AddMenuItem(RadioMenu, 0, "NextTrack");
	    AddMenuItem(RadioMenu, 0, "PrevTrack");
	    AddMenuItem(RadioMenu, 0, "Close");
}
//------------------------------------------------------------------------------
Script_OnGameModeInit()
{
		Object_Object();
		CreateDynamicObject(14637,1555.864,-1262.598,282.751,0.0,0.0,45.000); // object (158)
		CreateDynamicObject(14467,1600.252,-1251.818,282.498,0.0,0.0,-180.000); // object (159)
		CreateDynamicObject(7093,1558.158,-1226.401,286.784,0.0,0.0,45.000); // object (160)
		CreateDynamicObject(3554,1585.633,-1216.754,289.318,0.0,0.0,0.0); // object (161)
		CreateDynamicObject(3462,1571.156,-1267.714,278.397,0.0,0.0,-67.500); // object (162)
		CreateDynamicObject(3462,1553.023,-1263.134,278.384,0.0,0.0,-135.000); // object (163)
		CreateDynamicObject(14537,1588.431,-1262.591,278.878,0.0,0.0,11.250); // object (164)
		CreateDynamicObject(2099,1550.625,-1260.169,276.869,0.0,0.0,112.500); // object (153)
		CreateDynamicObject(2104,1550.135,-1258.956,276.870,0.0,0.0,-247.500); // object (154)
		CreateDynamicObject(2230,1552.123,-1262.454,276.846,0.0,0.0,135.000); // object (155)
		CreateDynamicObject(2230,1549.208,-1255.259,276.858,0.0,0.0,78.750); // object (156)
		CreateDynamicObject(2230,1551.182,-1248.691,276.858,0.0,0.0,33.750); // object (157)
		CreateDynamicObject(2230,1565.043,-1248.529,276.878,0.0,0.0,0.0); // object (158)
		CreateDynamicObject(2230,1562.592,-1248.606,276.878,0.0,0.0,0.0); // object (159)
		CreateDynamicObject(2230,1561.292,-1268.328,276.875,0.0,0.0,-191.250); // object (160)
		CreateDynamicObject(2230,1572.273,-1266.692,276.883,0.0,0.0,-123.750); // object (161)
		CreateDynamicObject(2230,1573.780,-1259.359,276.881,0.0,0.0,-146.250); // object (162)
		CreateDynamicObject(2230,1575.120,-1247.648,276.878,0.0,0.0,-22.500); // object (163)
		CreateDynamicObject(3533,1596.191,-1253.385,281.050,0.0,0.0,0.0); // object (166)
		CreateDynamicObject(3532,1595.297,-1251.722,277.561,0.0,0.0,-78.750); // object (169)
		CreateDynamicObject(3532,1588.149,-1243.626,277.559,0.0,0.0,-78.750); // object (170)
		CreateDynamicObject(3532,1583.982,-1255.603,277.562,0.0,0.0,-78.750); // object (171)
		CreateDynamicObject(3532,1576.224,-1246.443,277.724,0.0,0.0,-78.750); // object (172)
		CreateDynamicObject(3374,1547.915,-1240.163,278.376,0.0,0.0,11.250); // object (173)
		CreateDynamicObject(3374,1551.856,-1239.332,278.375,0.0,0.0,11.250); // object (174)
		CreateDynamicObject(3374,1555.748,-1238.555,278.374,0.0,0.0,11.250); // object (175)
		CreateDynamicObject(3374,1549.862,-1239.635,281.376,0.0,0.0,11.250); // object (176)
		CreateDynamicObject(3374,1553.652,-1238.886,284.099,0.0,0.0,11.250); // object (177)
		CreateDynamicObject(3374,1555.536,-1238.444,287.099,0.0,0.0,11.250); // object (178)
		CreateDynamicObject(3374,1547.596,-1239.963,290.150,0.0,0.0,11.250); // object (179)
		CreateDynamicObject(3374,1555.425,-1238.438,290.112,0.0,0.0,11.250); // object (180)
		CreateDynamicObject(3374,1551.506,-1239.153,290.122,0.0,0.0,11.250); // object (181)
		CreateDynamicObject(3374,1547.587,-1239.987,287.150,0.0,0.0,11.250); // object (182)
		CreateDynamicObject(3374,1560.750,-1237.643,278.373,0.0,0.0,11.250); // object (183)
		CreateDynamicObject(3374,1564.606,-1236.886,278.372,0.0,0.0,11.250); // object (184)
		CreateDynamicObject(3374,1568.564,-1236.156,278.371,0.0,0.0,11.250); // object (185)
		CreateDynamicObject(3374,1568.543,-1236.161,281.371,0.0,0.0,11.250); // object (186)
		CreateDynamicObject(3374,1568.617,-1236.148,284.371,0.0,0.0,11.250); // object (187)
		CreateDynamicObject(3374,1568.643,-1235.962,287.371,0.0,0.0,11.250); // object (188)
		CreateDynamicObject(3374,1568.603,-1236.077,290.371,0.0,0.0,11.250); // object (189)
		CreateDynamicObject(3374,1560.787,-1237.481,281.373,0.0,0.0,11.250); // object (190)
		CreateDynamicObject(3374,1560.760,-1237.517,284.373,0.0,0.0,11.250); // object (191)
		CreateDynamicObject(3374,1560.768,-1237.545,287.373,0.0,0.0,11.250); // object (192)
		CreateDynamicObject(3374,1560.775,-1237.640,290.373,0.0,0.0,11.250); // object (193)
		CreateDynamicObject(3374,1564.690,-1236.826,290.376,0.0,0.0,11.250); // object (194)
		CreateDynamicObject(3374,1581.515,-1233.579,278.369,0.0,0.0,11.250); // object (198)
		CreateDynamicObject(3374,1577.536,-1234.366,278.369,0.0,0.0,11.250); // object (199)
		CreateDynamicObject(3374,1573.611,-1235.131,278.371,0.0,0.0,11.250); // object (200)
		CreateDynamicObject(3374,1573.691,-1235.170,281.371,0.0,0.0,11.250); // object (201)
		CreateDynamicObject(3374,1573.645,-1235.172,284.371,0.0,0.0,11.250); // object (202)
		CreateDynamicObject(3374,1573.704,-1235.023,287.371,0.0,0.0,11.250); // object (203)
		CreateDynamicObject(3374,1573.712,-1234.850,290.371,0.0,0.0,11.250); // object (204)
		CreateDynamicObject(2592,1548.428,-1253.359,277.764,0.0,0.0,90.000); // object (50)
		CreateDynamicObject(3534,1556.461,-1259.174,292.434,0.0,0.0,45.000); // object (51)
		CreateDynamicObject(3534,1555.701,-1257.350,290.684,0.0,0.0,45.000); // object (52)
		CreateDynamicObject(3534,1560.362,-1259.448,285.384,0.0,0.0,45.000); // object (53)
		CreateDynamicObject(3534,1560.887,-1259.220,288.500,0.0,0.0,45.000); // object (54)
		CreateDynamicObject(3534,1557.830,-1257.370,286.082,0.0,0.0,45.000); // object (55)
		CreateDynamicObject(2784,1573.222,-1263.548,278.206,0.0,0.0,-270.000); // object (69)
		CreateDynamicObject(2784,1593.844,-1241.335,278.200,0.0,0.0,-326.250); // object (70)
		CreateDynamicObject(2784,1557.199,-1248.683,278.202,0.0,0.0,-180.000); // object (71)
		CreateDynamicObject(1487,1569.289,-1269.308,278.097,0.0,0.0,0.0); // object (72)
		CreateDynamicObject(1487,1569.117,-1268.867,278.097,0.0,0.0,0.0); // object (73)
		CreateDynamicObject(1487,1568.047,-1267.617,278.077,0.0,0.0,0.0); // object (74)
		CreateDynamicObject(1487,1566.516,-1267.776,278.077,0.0,0.0,0.0); // object (75)
		CreateDynamicObject(1512,1569.299,-1268.471,278.097,0.0,0.0,-33.750); // object (76)
		CreateDynamicObject(1512,1568.356,-1267.632,278.077,0.0,0.0,-45.000); // object (77)
		CreateDynamicObject(1520,1566.130,-1267.541,277.939,0.0,0.0,0.0); // object (78)
		CreateDynamicObject(1520,1567.629,-1267.806,277.939,0.0,0.0,0.0); // object (79)
		CreateDynamicObject(1544,1569.999,-1264.228,277.749,0.0,0.0,0.0); // object (80)
		CreateDynamicObject(1667,1569.772,-1264.307,277.862,0.0,0.0,0.0); // object (81)
		CreateDynamicObject(1978,1549.839,-1253.224,277.855,0.0,0.0,-360.000); // object (83)
		CreateDynamicObject(1979,1549.630,-1251.872,277.779,0.0,0.0,0.0); // object (84)
		CreateDynamicObject(1209,1597.121,-1246.440,276.878,0.0,0.0,-90.000); // object (85)
		CreateDynamicObject(1775,1596.921,-1245.239,277.975,0.0,0.0,-90.000); // object (86)
		CreateDynamicObject(1977,1596.905,-1241.533,276.875,0.0,0.0,-90.000); // object (87)
		CreateDynamicObject(2223,1561.959,-1255.614,277.696,0.0,0.0,-22.500); // object (88)
		CreateDynamicObject(2342,1559.922,-1252.285,277.735,0.0,0.0,0.0); // object (89)
		CreateDynamicObject(2453,1562.506,-1268.363,278.278,0.0,0.0,0.0); // object (90)
		CreateDynamicObject(1240,1558.392,-1260.543,277.079,0.0,0.0,0.0); // object (91)
		CreateDynamicObject(1240,1558.930,-1260.126,277.079,0.0,0.0,-56.250); // object (92)
		CreateDynamicObject(1240,1558.372,-1258.562,277.079,0.0,0.0,-78.750); // object (93)
		CreateDynamicObject(1240,1556.527,-1259.664,277.079,0.0,0.0,-22.500); // object (94)
		CreateDynamicObject(954,1559.120,-1259.445,277.179,0.0,0.0,0.0); // object (95)
		CreateDynamicObject(954,1557.281,-1260.065,277.179,0.0,0.0,-33.750); // object (96)
		CreateDynamicObject(954,1558.113,-1260.871,277.179,0.0,0.0,-78.750); // object (97)
		CreateDynamicObject(954,1557.430,-1258.385,277.179,0.0,0.0,-78.750); // object (98)
		CreateDynamicObject(1210,1557.924,-1258.450,277.031,0.0,0.0,-45.000); // object (99)
		CreateDynamicObject(1210,1558.739,-1259.923,277.031,0.0,0.0,33.750); // object (100)
		CreateDynamicObject(1210,1556.593,-1260.375,277.031,0.0,0.0,0.0); // object (101)
		CreateDynamicObject(1210,1556.838,-1259.190,277.031,0.0,0.0,-33.750); // object (102)
		CreateDynamicObject(1212,1556.844,-1258.502,276.909,0.0,0.0,0.0); // object (103)
		CreateDynamicObject(1212,1558.603,-1259.075,276.909,0.0,0.0,0.0); // object (104)
		CreateDynamicObject(1212,1557.583,-1260.632,276.909,0.0,0.0,0.0); // object (105)
		CreateDynamicObject(1212,1558.780,-1260.465,276.909,0.0,0.0,0.0); // object (106)
		CreateDynamicObject(1239,1559.041,-1259.157,277.077,0.0,0.0,0.0); // object (108)
		CreateDynamicObject(1239,1556.951,-1260.725,277.077,0.0,0.0,0.0); // object (109)
		CreateDynamicObject(1239,1556.545,-1259.855,277.077,0.0,0.0,-90.000); // object (110)
		CreateDynamicObject(1239,1557.191,-1258.987,277.077,0.0,0.0,-90.000); // object (111)
		CreateDynamicObject(1241,1556.836,-1258.916,277.080,0.0,0.0,0.0); // object (112)
		CreateDynamicObject(1241,1558.704,-1258.717,277.080,0.0,0.0,-11.250); // object (113)
		CreateDynamicObject(1241,1557.984,-1260.259,277.080,0.0,0.0,-146.250); // object (114)
		CreateDynamicObject(1242,1557.679,-1258.739,277.110,0.0,0.0,0.0); // object (115)
		CreateDynamicObject(1242,1557.199,-1260.492,277.110,0.0,0.0,0.0); // object (116)
		CreateDynamicObject(1247,1558.412,-1258.881,277.095,0.0,0.0,0.0); // object (117)
		CreateDynamicObject(1247,1556.844,-1259.773,277.095,0.0,0.0,-112.500); // object (118)
		CreateDynamicObject(1247,1558.731,-1260.708,277.095,0.0,0.0,-123.750); // object (119)
		CreateDynamicObject(1253,1557.664,-1261.053,277.182,0.0,0.0,0.0); // object (120)
		CreateDynamicObject(1253,1558.752,-1258.581,277.525,0.0,0.0,-67.500); // object (121)
		CreateDynamicObject(1273,1556.991,-1260.332,277.077,0.0,0.0,0.0); // object (122)
		CreateDynamicObject(1273,1557.259,-1258.528,277.077,0.0,0.0,-67.500); // object (123)
		CreateDynamicObject(1273,1558.309,-1259.095,278.256,0.0,0.0,-67.500); // object (124)
		CreateDynamicObject(1273,1558.342,-1258.793,277.077,0.0,0.0,-112.500); // object (125)
		CreateDynamicObject(1273,1558.183,-1260.646,277.077,0.0,0.0,-157.500); // object (126)
		CreateDynamicObject(1274,1558.959,-1259.809,277.388,0.0,0.0,-67.500); // object (127)
		CreateDynamicObject(1274,1557.595,-1260.603,277.195,0.0,0.0,-123.750); // object (128)
		CreateDynamicObject(1274,1557.420,-1260.045,278.253,0.0,0.0,-180.000); // object (129)
		CreateDynamicObject(1274,1557.119,-1259.752,277.077,0.0,0.0,-180.000); // object (130)
		CreateDynamicObject(1274,1557.825,-1258.492,277.310,0.0,0.0,-180.000); // object (131)
		CreateDynamicObject(1274,1556.995,-1259.096,277.077,0.0,0.0,-213.750); // object (132)
		CreateDynamicObject(1275,1556.854,-1260.175,277.077,0.0,0.0,-33.750); // object (133)
		CreateDynamicObject(1275,1558.906,-1260.374,277.077,0.0,0.0,-112.500); // object (134)
		CreateDynamicObject(1275,1558.313,-1258.395,277.359,0.0,0.0,-168.750); // object (135)
		CreateDynamicObject(2784,1569.621,-1247.984,278.202,0.0,0.0,-348.750); // object (136)
		CreateDynamicObject(2784,1581.865,-1245.200,278.201,0.0,0.0,-348.750); // object (137)
		CreateDynamicObject(2784,1588.851,-1253.709,278.203,0.0,0.0,-337.500); // object (138)
		CreateDynamicObject(2784,1579.611,-1257.670,278.204,0.0,0.0,-337.500); // object (139)
		CreateDynamicObject(3472,1563.671,-1248.808,277.198,0.0,0.0,0.0); // object (140)
		CreateDynamicObject(3472,1574.581,-1259.373,277.225,0.0,0.0,0.0); // object (141)
		CreateDynamicObject(3472,1584.377,-1255.506,277.199,0.0,0.0,0.0); // object (142)
		CreateDynamicObject(3472,1588.046,-1244.366,277.197,0.0,0.0,0.0); // object (143)
		CreateDynamicObject(3472,1575.907,-1246.549,277.197,0.0,0.0,0.0); // object (144)
return 1;
}
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
public NextTrack(playerid)
{
	if ((Currentplaying > 6)||(Currentplaying<2))
		{
		}
	else
		{
		Currentplaying++;
		}
}

public PrevTrack(playerid)
{
	if ((Currentplaying > 6)||(Currentplaying<2))
		{
		}
	else
		{
		Currentplaying=Currentplaying-1;
		}
}
//------------------------------------------------------------------------------
dcmd_dance(playerid, params[])
{
	new DanceID;
	if ((sscanf(params, "d",DanceID))||(DanceID<1)||(DanceID>4)) SendClientMessage(playerid, COLOR_SYSTEM, " Использование: \"/dance [1-4]\"");
	else
		{
		switch(DanceID)
				{
					case 1: SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
					case 2: SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
					case 3: SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
					case 4: SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
				}
        SendClientMessage(playerid, COLOR_SYSTEM, "Танцуем! Чтобы остановиться нажмите левую кнопку мышки :)");
		}
	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerCommandText(playerid, cmdtext[])
{
dcmd(dance, 5, cmdtext);

if (!strcmp("/help-new",cmdtext,true,10))
			{
			SendClientMessage(playerid, COLOR_SYSTEM, "Команды:");
			SendClientMessage(playerid, COLOR_SYSTEM, "/drink, /dance [1-4], /strip, /radio, /lift");
			SendClientMessage(playerid, COLOR_SYSTEM, "Справка:");
			SendClientMessage(playerid, COLOR_SYSTEM, "Танцуем стриптиз на столиках. Бухаем в баре. Катаемся на лифте. Танцуем. Переключаем музон у муз. центра :)");
			SendClientMessage(playerid, COLOR_WHITE, "Script by Eragon (http://eragon-studio.net.ru)");
		    return 1;
			}
if (!strcmp("/drink",cmdtext,true,10))
			{
			if (IsPlayerInSphere(playerid,1565.874,-1268.579,277.275, 3))
			    {
				ShowMenuForPlayer(DrinkMenu,playerid);
				TogglePlayerControllable(playerid, false);
				}
			else
			    {
			    SendClientMessage(playerid, COLOR_SYSTEM, "Вы слишком далеко от бара.");
				}
		    return 1;
			}
if (!strcmp("/radio",cmdtext,true,10))
			{
			if (IsPlayerInSphere(playerid,1550.625,-1260.169,276.869, 3))
			    {
				ShowMenuForPlayer(RadioMenu,playerid);
				TogglePlayerControllable(playerid, false);
				}
			else
			    {
			    SendClientMessage(playerid, COLOR_SYSTEM, "Вы слишком далеко от бара.");
				}
		    return 1;
			}
if (!strcmp("/lift",cmdtext,true,10))
			{
			new Float:X, Float:Y, Float:Z;
			GetObjectPos(lift,X,Y,Z);
			if (IsPlayerInSphere(playerid, X,Y,Z, 3))
			    {
				ShowMenuForPlayer(LiftMenu,playerid);
				}
			else
			    {
			    SendClientMessage(playerid, COLOR_SYSTEM, "Вы слишком далеко от лифта.");
				}
		    return 1;
			}
if (!strcmp("/startnew",cmdtext,true,10))
			{
			if(IsPlayerAdmin(playerid))
				{
				Timer1 = SetTimer("Count",1000,1);
				}
		    return 1;
			}
if (!strcmp("/strip",cmdtext,true,10))
			{
			if (IsPlayerInSphere(playerid, 1570.265,-1259.389,278.126, 3))
			    {
			    SetPlayerPos(playerid,1570.265,-1259.389,278.126);
			    new PlName[20], str[256]; GetPlayerName(playerid,PlName, 20); format (str,256,"%s танцует стриптиз! Это надо видеть!",PlName); SendClientMessageToAll(COLOR_SYSTEM,str);
                Timer2[playerid] = SetTimer("StripDance",500,1);
			    }
            if (IsPlayerInSphere(playerid, 1569.704,-1264.051,278.155, 3))
			    {
			    SetPlayerPos(playerid,1569.704,-1264.051,278.155);
			    new PlName[20], str[256]; GetPlayerName(playerid,PlName, 20); format (str,256,"%s танцует стриптиз! Это надо видеть!",PlName); SendClientMessageToAll(COLOR_SYSTEM,str);
			    Timer2[playerid] = SetTimer("StripDance",500,1);
			    }
            if (IsPlayerInSphere(playerid, 1565.745,-1262.758,278.344, 3))
			    {
			    SetPlayerPos(playerid,1565.745,-1262.758,278.344);
			    new PlName[20], str[256]; GetPlayerName(playerid,PlName, 20); format (str,256,"%s танцует стриптиз! Это надо видеть!",PlName); SendClientMessageToAll(COLOR_SYSTEM,str);
			    Timer2[playerid] = SetTimer("StripDance",500,1);
			    }
            if (IsPlayerInSphere(playerid, 1565.794,-1258.403,278.183, 3))
			    {
			    SetPlayerPos(playerid,1565.794,-1258.403,278.183);
			    new PlName[20], str[256]; GetPlayerName(playerid,PlName, 20); format (str,256,"%s танцует стриптиз! Это надо видеть!",PlName); SendClientMessageToAll(COLOR_SYSTEM,str);
			    Timer2[playerid] = SetTimer("StripDance",500,1);
			    }
            if (IsPlayerInSphere(playerid, 1561.796,-1255.487,278.090, 3))
			    {
			    SetPlayerPos(playerid,1561.796,-1255.487,278.090);
			    new PlName[20], str[256]; GetPlayerName(playerid,PlName, 20); format (str,256,"%s танцует стриптиз! Это надо видеть!",PlName); SendClientMessageToAll(COLOR_SYSTEM,str);
			    Timer2[playerid] = SetTimer("StripDance",500,1);
			    }
            if (IsPlayerInSphere(playerid, 1559.947,-1252.008,278.083, 3))
			    {
			    SetPlayerPos(playerid,1559.947,-1252.008,278.083);
			    new PlName[20], str[256]; GetPlayerName(playerid,PlName, 20); format (str,256,"%s танцует стриптиз! Это надо видеть!",PlName); SendClientMessageToAll(COLOR_SYSTEM,str);
			    Timer2[playerid] = SetTimer("StripDance",500,1);
			    }
            if (IsPlayerInSphere(playerid, 1557.938,-1254.905,278.079, 3))
			    {
			    SetPlayerPos(playerid,1557.938,-1254.905,278.079);
			    new PlName[20], str[256]; GetPlayerName(playerid,PlName, 20); format (str,256,"%s танцует стриптиз! Это надо видеть!",PlName); SendClientMessageToAll(COLOR_SYSTEM,str);
			    Timer2[playerid] = SetTimer("StripDance",500,1);
			    }
            if (IsPlayerInSphere(playerid, 1555.339,-1252.912,277.985, 3))
			    {
			    SetPlayerPos(playerid,1555.339,-1252.912,277.985);
			    new PlName[20], str[256]; GetPlayerName(playerid,PlName, 20); format (str,256,"%s танцует стриптиз! Это надо видеть!",PlName); SendClientMessageToAll(COLOR_SYSTEM,str);
			    Timer2[playerid] = SetTimer("StripDance",500,1);
			    }
            if (IsPlayerInSphere(playerid, 1553.755,-1257.570,278.070, 3))
			    {
			    SetPlayerPos(playerid,1553.755,-1257.570,278.070);
			    new PlName[20], str[256]; GetPlayerName(playerid,PlName, 20); format (str,256,"%s танцует стриптиз! Это надо видеть!",PlName); SendClientMessageToAll(COLOR_SYSTEM,str);
			    Timer2[playerid] = SetTimer("StripDance",500,1);
			    }
		    return 1;
			}
	return 0;
}
//------------------------------------------------------------------------------
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == 4)
		{
		ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
		ClearAnimations(playerid);
		TogglePlayerControllable(playerid, true);
		KillTimer(Timer2[playerid]);
		}
return 1;
}
//------------------------------------------------------------------------------
public GetLocation()
{
	for(new i; i<MAX_PLAYERS; i++)
		{
		if(IsPlayerConnected(i))
	    	{
			SetPlayerTime(i,0,0);
		    }
		}
}
//------------------------------------------------------------------------------
public OnPlayerUpdate(playerid)
{
	if ((IsPlayerInSphere(playerid, 1552.123,-1262.454,276.846, 10))||(IsPlayerInSphere(playerid, 1549.208,-1255.259,276.858, 10))||(IsPlayerInSphere(playerid, 1551.182,-1248.691,276.858, 10))
	||(IsPlayerInSphere(playerid, 1565.043,-1248.529,276.878, 10))||(IsPlayerInSphere(playerid, 1562.592,-1248.606,276.878, 10))||(IsPlayerInSphere(playerid, 1561.292,-1268.328,276.875, 10))||(IsPlayerInSphere(playerid, 1572.273,-1266.692,276.883, 10))||(IsPlayerInSphere(playerid, 1573.780,-1259.359,276.881, 10))||(IsPlayerInSphere(playerid, 1575.120,-1247.648,276.878, 10)))
		{
		if (StatusRadio == 1)
		    {
		    PlayerPlaySound(playerid, ChannelsStart[Currentplaying], 0.0, 0.0, 0.0);
		    }
        else PlayerPlaySound(playerid, ChannelsStop[Currentplaying], 0.0, 0.0, 0.0);
		}
	else PlayerPlaySound(playerid, ChannelsStop[Currentplaying], 0.0, 0.0, 0.0);
}
//------------------------------------------------------------------------------
public StripDance(playerid)
{
ApplyAnimation(playerid,"STRIP","strip_D",4.1,0,1,1,1,1);
}
//------------------------------------------------------------------------------
public Count()
{
new str[256];
format (str,256,"%d",CountT);
GameTextForAll(str,1000,3);
for(new i; i<MAX_PLAYERS; i++)
	{
	PlayerPlaySound(i,1056,0,0,0);
	}
CountT = CountT - 1;
if (CountT == 6)
	{
	for(new i; i<MAX_PLAYERS; i++)
		{
	    if(IsPlayerConnected(i))
	    	{
			SetPlayerCameraPos(i, 1572.889,-1271.309,294.977);
			SetPlayerCameraLookAt(i, 1571.668,-1241.577,277.071);
			}
		}
	}
if (CountT == 0)
	{
	KillTimer(Timer1);
	CountT = 10;
	NewYearStart();
	}
}
//------------------------------------------------------------------------------
public NewYearStart()
{
	CreateExplosion(1586.539,-1232.418,278.369,1,3); // 1-8
	CreateExplosion(1590.422,-1231.651,278.369,1,3); // 2-8
	CreateExplosion(1594.402,-1230.933,278.369,1,3); // 3-8
	CreateExplosion(1594.362,-1230.872,281.369,1,3); // 4-8
	CreateExplosion(1594.392,-1230.765,284.369,1,3); // 5-8
	CreateExplosion(1594.537,-1230.543,287.369,1,3); // 6-8
	CreateExplosion(1594.395,-1230.635,290.369,1,3); // 7-8
	CreateExplosion(1590.541,-1231.452,290.341,1,3); // 8-8
	CreateExplosion(1586.609,-1232.287,290.369,1,3); // 9-8
	CreateExplosion(1586.588,-1232.221,287.369,1,3); // 10-8
	CreateExplosion(1586.534,-1232.273,284.369,1,3); // 11-8
	CreateExplosion(1586.543,-1232.350,281.369,1,3); // 12-8
	CreateExplosion(1590.429,-1231.496,284.315,1,3); // 13-8
	for(new i; i<13; i++)
	    {
	    DestroyObject(Year2008[i]);
	    }
    Year2009[0] = CreateObject(3374,1594.496,-1230.841,278.369,0.0,0.0,11.250); // 1-8
	Year2009[1] = CreateObject(3374,1594.426,-1230.826,281.343,0.0,0.0,11.250); // 2-8
	Year2009[2] = CreateObject(3374,1586.690,-1232.515,278.369,0.0,0.0,11.250); // 3-8
	Year2009[3] = CreateObject(3374,1590.562,-1231.698,278.369,0.0,0.0,11.250); // 4-8
	Year2009[4] = CreateObject(3374,1594.392,-1230.765,284.369,0.0,0.0,11.250); // 5-8
	Year2009[5] = CreateObject(3374,1594.537,-1230.543,287.369,0.0,0.0,11.250); // 6-8
	Year2009[6] = CreateObject(3374,1594.395,-1230.635,290.369,0.0,0.0,11.250); // 7-8
	Year2009[7] = CreateObject(3374,1590.541,-1231.452,290.341,0.0,0.0,11.250); // 8-8
	Year2009[8] = CreateObject(3374,1586.609,-1232.287,290.369,0.0,0.0,11.250); // 9-8
	Year2009[9] = CreateObject(3374,1586.588,-1232.221,287.369,0.0,0.0,11.250); // 10-8
	Year2009[10] = CreateObject(3374,1586.534,-1232.273,284.369,0.0,0.0,11.250); // 11-8
	Year2009[11] = CreateObject(3374,1590.447,-1231.725,284.419,0.0,0.0,11.250); // 12-8
	for(new i; i<MAX_PLAYERS; i++)
		{
		if(IsPlayerConnected(i))
	    	{
			PlayerPlaySound(i,1062,0,0,0);
			SetTimerEx("ResetCam", 3000, 0, "i", i);
			SendClientMessage(i, COLOR_WHITE, "С Новым 2009 годом! На столиках ждут подарки!");
			}
		}
    new randomize=random(sizeof(randpick));
	CreatePickup(randpick[randomize][0],2,1570.265,-1259.389,278.126); // pick1
	randomize=random(sizeof(randpick));
	CreatePickup(randpick[randomize][0],2,1569.704,-1264.051,278.155); // pick2
	randomize=random(sizeof(randpick));
	CreatePickup(randpick[randomize][0],2,1565.745,-1262.758,278.344); // pick3
	randomize=random(sizeof(randpick));
	CreatePickup(randpick[randomize][0],2,1565.794,-1258.403,278.183); // pick4
	randomize=random(sizeof(randpick));
	CreatePickup(randpick[randomize][0],2,1561.796,-1255.487,278.090); // pick5
	randomize=random(sizeof(randpick));
	CreatePickup(randpick[randomize][0],2,1559.947,-1252.008,278.083); // pick6
	randomize=random(sizeof(randpick));
	CreatePickup(randpick[randomize][0],2,1557.938,-1254.905,278.079); // pick7
	randomize=random(sizeof(randpick));
	CreatePickup(randpick[randomize][0],2,1555.339,-1252.912,277.985); // pick8
	randomize=random(sizeof(randpick));
	CreatePickup(randpick[randomize][0],2,1553.755,-1257.570,278.070); // pick9
}
//------------------------------------------------------------------------------
public ResetCam(playerid)
{
	SetCameraBehindPlayer(playerid);
	TogglePlayerControllable(playerid, 1);
	TogglePlayerSpectating(playerid, 0);
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
}
//------------------------------------------------------------------------------
public OnPlayerExitedMenu(playerid)
{
	TogglePlayerControllable(playerid, true);
	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerSelectedMenuRow(playerid,row)
{
    new Menu:Current = GetPlayerMenu(playerid), str[256];
    if(Current == RadioMenu)
		{
        switch(row)
			{
            case 0: {
		            if (StatusRadio == 0)
		                {
		                StatusRadio = 1;
		                SendClientMessage(playerid,COLOR_WHITE,"Вы включили радио.");
		                }
					else
					    {
					    StatusRadio = 0;
					    SendClientMessage(playerid,COLOR_WHITE,"Вы выключили радио.");
					    }
                    ShowMenuForPlayer(RadioMenu,playerid);
            		}
			case 1: {
			        if (Currentplaying > 6)
						{
						}
					else
						{
      					Currentplaying=Currentplaying+1;
						}
			        ShowMenuForPlayer(RadioMenu,playerid);
					}
			case 2: {
			        if (Currentplaying<1)
						{
						}
					else
						{
      					Currentplaying=Currentplaying-1;
						}
			        ShowMenuForPlayer(RadioMenu,playerid);
					}
			case 3: {
					HideMenuForPlayer(Current, playerid);
					TogglePlayerControllable(playerid, true);
					}
        	}
    	}
    if(Current == LiftMenu)
		{
        switch(row)
			{
            case 0: MoveObject(lift,1567.132,-1185.117,279.768,5);
			case 1: StopObject(lift);
			case 2: MoveObject(lift,1567.153,-1185.108,45.754,4);
			case 3: {
					HideMenuForPlayer(Current, playerid);
					TogglePlayerControllable(playerid, true);
					}
        	}
    	}
    if(Current == DrinkMenu)
		{
        switch(row)
			{
            case 0: {
            if (GetPlayerMoney(playerid) > 2) { GivePlayerMoney(playerid,-2);
            ApplyAnimation(playerid,"BAR","dnk_stndF_loop",4.1,0,1,1,1,1);
            alco[playerid] = alco[playerid] + 0;
            necost[playerid] = necost[playerid] + 2;
            format(str,256,"Bы пьете колу. С Вас 2$. Уровень опъянения %d%. Всего потрачено %d$.",alco[playerid],necost[playerid]);
            SendClientMessage(playerid,COLOR_WHITE,str);
            ShowMenuForPlayer(DrinkMenu,playerid); } else SendClientMessage(playerid,COLOR_WHITE,"Недостаточно денег");
            if (alco[playerid] >= 100) { SendClientMessage(playerid,COLOR_WHITE,"Вы пьяны! Вам хватит."); alco[playerid]=0; HideMenuForPlayer(Current, playerid); TogglePlayerControllable(playerid, true); ApplyAnimation(playerid,"PED", "WALK_DRUNK",4.0,0,1,0,0,0);}
            }
			case 1: {
			if (GetPlayerMoney(playerid) > 7) { GivePlayerMoney(playerid,-7);
			ApplyAnimation(playerid,"BAR","dnk_stndF_loop",4.1,0,1,1,1,1);
			alco[playerid] = alco[playerid] + 5;
			necost[playerid] = necost[playerid] + 7;
            format(str,256,"Bы пьете пиво. С Вас 7$. Уровень опъянения %d%. Всего потрачено %d$.",alco[playerid],necost[playerid]);
            SendClientMessage(playerid,COLOR_WHITE,str);
            ShowMenuForPlayer(DrinkMenu,playerid); } else SendClientMessage(playerid,COLOR_WHITE,"Недостаточно денег");
            if (alco[playerid] >= 100) { SendClientMessage(playerid,COLOR_WHITE,"Вы пьяны! Вам хватит."); alco[playerid]=0; HideMenuForPlayer(Current, playerid); TogglePlayerControllable(playerid, true); ApplyAnimation(playerid,"PED", "WALK_DRUNK",4.0,0,1,0,0,0);}
			}
			case 2: {
			if (GetPlayerMoney(playerid) > 20) { GivePlayerMoney(playerid,-20);
			ApplyAnimation(playerid,"BAR","dnk_stndF_loop",4.1,0,1,1,1,1);
			alco[playerid] = alco[playerid] + 10;
			necost[playerid] = necost[playerid] + 20;
            format(str,256,"Bы пьете вино. С Вас 20$. Уровень опъянения %d%. Всего потрачено %d$.",alco[playerid],necost[playerid]);
            SendClientMessage(playerid,COLOR_WHITE,str);
            ShowMenuForPlayer(DrinkMenu,playerid); } else SendClientMessage(playerid,COLOR_WHITE,"Недостаточно денег");
            if (alco[playerid] >= 100) { SendClientMessage(playerid,COLOR_WHITE,"Вы пьяны! Вам хватит."); alco[playerid]=0; HideMenuForPlayer(Current, playerid); TogglePlayerControllable(playerid, true); ApplyAnimation(playerid,"PED", "WALK_DRUNK",4.0,0,1,0,0,0);}
			}
			case 3: {
			if (GetPlayerMoney(playerid) > 30) { GivePlayerMoney(playerid,-30);
			ApplyAnimation(playerid,"BAR","dnk_stndF_loop",4.1,0,1,1,1,1);
			alco[playerid] = alco[playerid] + 15;
			necost[playerid] = necost[playerid] + 30;
            format(str,256,"Bы пьете коньяк. С Вас 30$. Уровень опъянения %d%. Всего потрачено %d$.",alco[playerid],necost[playerid]);
            SendClientMessage(playerid,COLOR_WHITE,str);
            ShowMenuForPlayer(DrinkMenu,playerid); } else SendClientMessage(playerid,COLOR_WHITE,"Недостаточно денег");
            if (alco[playerid] >= 100) { SendClientMessage(playerid,COLOR_WHITE,"Вы пьяны! Вам хватит."); alco[playerid]=0; HideMenuForPlayer(Current, playerid); TogglePlayerControllable(playerid, true); ApplyAnimation(playerid,"PED", "WALK_DRUNK",4.0,0,1,0,0,0);}
			}
            case 4: {
            if (GetPlayerMoney(playerid) > 40) { GivePlayerMoney(playerid,-40);
            ApplyAnimation(playerid,"BAR","dnk_stndF_loop",4.1,0,1,1,1,1);
            alco[playerid] = alco[playerid] + 10;
            necost[playerid] = necost[playerid] + 40;
            format(str,256,"Bы пьете виски. С Вас 40$. Уровень опъянения %d%. Всего потрачено %d$.",alco[playerid],necost[playerid]);
            SendClientMessage(playerid,COLOR_WHITE,str);
            ShowMenuForPlayer(DrinkMenu,playerid); } else SendClientMessage(playerid,COLOR_WHITE,"Недостаточно денег");
            if (alco[playerid] >= 100) { SendClientMessage(playerid,COLOR_WHITE,"Вы пьяны! Вам хватит."); alco[playerid]=0; HideMenuForPlayer(Current, playerid); TogglePlayerControllable(playerid, true); ApplyAnimation(playerid,"PED", "WALK_DRUNK",4.0,0,1,0,0,0);}
			}
			case 5: {
			if (GetPlayerMoney(playerid) > 35) { GivePlayerMoney(playerid,-35);
			ApplyAnimation(playerid,"BAR","dnk_stndF_loop",4.1,0,1,1,1,1);
			alco[playerid] = alco[playerid] + 11;
			necost[playerid] = necost[playerid] + 35;
            format(str,256,"Bы пьете мортини. С Вас 35$. Уровень опъянения %d%. Всего потрачено %d$.",alco[playerid],necost[playerid]);
            SendClientMessage(playerid,COLOR_WHITE,str);
            ShowMenuForPlayer(DrinkMenu,playerid); } else SendClientMessage(playerid,COLOR_WHITE,"Недостаточно денег");
            if (alco[playerid] >= 100) { SendClientMessage(playerid,COLOR_WHITE,"Вы пьяны! Вам хватит."); alco[playerid]=0; HideMenuForPlayer(Current, playerid); TogglePlayerControllable(playerid, true); ApplyAnimation(playerid,"PED", "WALK_DRUNK",4.0,0,1,0,0,0);}
			}
			case 6: {
			if (GetPlayerMoney(playerid) > 25) { GivePlayerMoney(playerid,-25);
			ApplyAnimation(playerid,"BAR","dnk_stndF_loop",4.1,0,1,1,1,1);
			alco[playerid] = alco[playerid] + 33;
			necost[playerid] = necost[playerid] + 25;
            format(str,256,"Bы пьете самогон. С Вас 25$. Уровень опъянения %d%. Всего потрачено %d$.",alco[playerid],necost[playerid]);
            SendClientMessage(playerid,COLOR_WHITE,str);
            ShowMenuForPlayer(DrinkMenu,playerid); } else SendClientMessage(playerid,COLOR_WHITE,"Недостаточно денег");
            if (alco[playerid] >= 100) { SendClientMessage(playerid,COLOR_WHITE,"Вы пьяны! Вам хватит."); alco[playerid]=0; HideMenuForPlayer(Current, playerid); TogglePlayerControllable(playerid, true); ApplyAnimation(playerid,"PED", "WALK_DRUNK",4.0,0,1,0,0,0);}
			}
			case 7: {
			if (GetPlayerMoney(playerid) > 30) { GivePlayerMoney(playerid,-30);
			ApplyAnimation(playerid,"BAR","dnk_stndF_loop",4.1,0,1,1,1,1);
			alco[playerid] = alco[playerid] + 33;
			necost[playerid] = necost[playerid] + 30;
            format(str,256,"Bы пьете водку. С Вас 30$. Уровень опъянения %d%. Всего потрачено %d$.",alco[playerid],necost[playerid]);
            SendClientMessage(playerid,COLOR_WHITE,str);
            ShowMenuForPlayer(DrinkMenu,playerid); } else SendClientMessage(playerid,COLOR_WHITE,"Недостаточно денег");
			if (alco[playerid] >= 100) { SendClientMessage(playerid,COLOR_WHITE,"Вы пьяны! Вам хватит."); alco[playerid]=0; HideMenuForPlayer(Current, playerid); TogglePlayerControllable(playerid, true); ApplyAnimation(playerid,"PED", "WALK_DRUNK",4.0,0,1,0,0,0);}
			}
			case 8: {
			        HideMenuForPlayer(Current, playerid);
			        TogglePlayerControllable(playerid, true);
					}
        	}
    	}
    return 1;
}
//------------------------------------------------------------------------------
public OnFilterScriptExit()
{
KillTimer(TimerLoc);
KillTimer(Timer1);
for(new i; i<MAX_PLAYERS; i++)
	{
	KillTimer(Timer2[i]);
	}

}
//------------------------------------------------------------------------------
stock sscanf(string[], format[], {Float,_}:...)
{
	new
		formatPos = 0,
		stringPos = 0,
		paramPos = 2,
		paramCount = numargs();
	while (paramPos < paramCount && string[stringPos])
	{
		switch (format[formatPos++])
		{
			case '\0':
			{
				return 0;
			}
			case 'i', 'd':
			{
				new
					neg = 1,
					num = 0,
					ch = string[stringPos];
				if (ch == '-')
				{
					neg = -1;
					ch = string[++stringPos];
				}
				do
				{
					stringPos++;
					if (ch >= '0' && ch <= '9')
					{
						num = (num * 10) + (ch - '0');
					}
					else
					{
						return 1;
					}
				}
				while ((ch = string[stringPos]) && ch != ' ');
				setarg(paramPos, 0, num * neg);
			}
			case 'h', 'x':
			{
				new
					ch,
					num = 0;
				while ((ch = string[stringPos++]))
				{
					switch (ch)
					{
						case 'x', 'X':
						{
							num = 0;
							continue;
						}
						case '0' .. '9':
						{
							num = (num << 4) | (ch - '0');
						}
						case 'a' .. 'f':
						{
							num = (num << 4) | (ch - ('a' - 10));
						}
						case 'A' .. 'F':
						{
							num = (num << 4) | (ch - ('A' - 10));
						}
						case ' ':
						{
							break;
						}
						default:
						{
							return 1;
						}
					}
				}
				setarg(paramPos, 0, num);
			}
			case 'c':
			{
				setarg(paramPos, 0, string[stringPos++]);
			}
			case 'f':
			{
				new tmp[25];
				strmid(tmp, string, stringPos, stringPos+sizeof(tmp)-2);
				setarg(paramPos, 0, _:floatstr(tmp));
			}
			case 's', 'z':
			{
				new
					i = 0,
					ch;
				if (format[formatPos])
				{
					while ((ch = string[stringPos++]) && ch != ' ')
					{
						setarg(paramPos, i++, ch);
					}
					if (!i) return 1;
				}
				else
				{
					while ((ch = string[stringPos++]))
					{
						setarg(paramPos, i++, ch);
					}
				}
				stringPos--;
				setarg(paramPos, i, '\0');
			}
			default:
			{
				continue;
			}
		}
		while (string[stringPos] && string[stringPos] != ' ')
		{
			stringPos++;
		}
		while (string[stringPos] == ' ')
		{
			stringPos++;
		}
		paramPos++;
	}
	while (format[formatPos] == 'z') formatPos++;
	return format[formatPos];
}
