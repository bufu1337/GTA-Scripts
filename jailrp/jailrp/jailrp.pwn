#include <a_samp>
#include <dudb>
#include <Dini>
#include <dutils>
#include <core>
#include <utils>
#include <float>
#pragma tabsize 0

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_PURPLE 0x9900FFAA
#define COLOR_TAN 0xFFFFCCAA
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_PINK 0xFF66FFAA
#define COLOR_FADE1 0xE6E6E6E6
#define COLOR_FADE2 0xC8C8C8C8
#define COLOR_FADE3 0xAAAAAAAA
#define COLOR_FADE4 0x8C8C8C8C
#define COLOR_FADE5 0x6E6E6E6E
#define COLOR_KHAKI 0x999900AA
#define COLOR_LIME 0x99FF00AA
#define COLOR_BLACK 0x000000AA
#define COLOR_TURQ 0x00A3C0AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_BROWN 0x993300AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_CYAN 0x00BFF3AA
#define COLOR_BLACK 0x000000AA
#define COLOR_GOLD 0xB8860BAA
#define COLOR_INDIGO 0x4B00B0AA
#define COLOR_OOC 0xE0FFFFAA
#define COLOR_LAWNGREEN 0x7CFC00AA
#define COLOR_LIMEGREEN 0x32CD32AA
#define COLOR_OLIVE 0x808000AA
#define COLOR_SEAGREEN 0x2E8B57AA
#define COLOR_TOMATO 0xFF6347AA
#define COLOR_YELLOWGREEN 0x9ACD32AA
#define COLOR_MEDIUMAQUA 0x83BFBFAA
#define COLOR_FLBLUE 0x6495EDAA
#define COLOR_MAGENTA 0xFF00FFFF

//other
new logged[MAX_PLAYERS];

//gates
new startpointgate1;
new startpointgate2;
new prisongate1;
new entranceliftup;

new player[MAX_PLAYER_NAME];
new mute[MAX_PLAYERS];
new noooc = 0;
new sendername[MAX_PLAYER_NAME];
forward BroadCast(color,const string[]);
forward OOCOff(color,const string[]);
new gOoc[MAX_PLAYERS];

new realchat = 1;
new BigEar[MAX_PLAYERS];

forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);

forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward custompickups();
forward busarrived();
forward finishlogin(playerid);

main()
{
	print("Jail Roleplay");
}

public OnGameModeInit()
{
	// Gamemode
	SetGameModeText("Jail Roleplay v0.1");
	
	SetTimer("custompickups", 1000, 1);
		
	//player classes
	AddPlayerClass(0,2854.2229,1088.7697,10.8984,160.1107,0,0,0,0,0,0);
	AddStaticPickup(1239,23,2850.6309,1086.3667,10.8984);//info icon 1
	AddStaticPickup(1239,23,2848.5449,1091.0938,10.8984);//info icon 2
	AddStaticPickup(1239,23,2856.7773,1080.0518,10.8984);//info icon 3
	
	AddStaticPickup(1239,23,339.6304,2469.3435,17.4853);//resturaunt
	AddStaticPickup(1239,23,252.0558,2476.9355,16.4844);//bar
	AddStaticPickup(1239,23,240.5882,2477.4216,16.4844);//house
	//vehicles
	
	//startpoint vehicles
	AddStaticVehicle(548,2899.9568,1087.4479,12.5187,172.2297,-1,-1); // cargobob behind entry point
	AddStaticVehicle(431,2880.8972,1083.8818,10.9958,87.7443,-1,-1); // bus1
	AddStaticVehicle(431,2882.3157,1091.3177,10.9997,89.0461,-1,-1); // bus2
	AddStaticVehicle(523,2883.2263,1103.0258,10.4729,88.5709,-1,-1); // policebike 1
	AddStaticVehicle(523,2882.4431,1104.8931,10.4702,92.6182,-1,-1); // policebike 2
	AddStaticVehicle(523,2877.3752,1103.5404,10.4706,176.4809,-1,-1); // policebike 3
	AddStaticVehicle(523,2880.3772,1104.5618,10.4704,173.2657,-1,-1); // policebike 4
	AddStaticVehicle(599,2879.4612,1099.6624,11.0955,87.0622,0,1); // copcar
	AddStaticVehicle(598,2865.8896,1095.6450,10.4693,174.0219,-1,-1); // copcar2

	//vehicles at prison
	AddStaticVehicle(431,373.6865,2548.6482,16.1048,90.1005,-1,-1); // bus1
	AddStaticVehicle(497,366.4313,2536.6653,18.2937,92.0010,-1,-1); // cop heli
	//objects
	startpointgate1=CreateObject(971, 2836.476807, 1095.697388, 13.421704, 0.0000, 0.0000, 287.9112);
	CreateObject(5837, 2839.612305, 1103.398315, 11.613008, 0.0000, 0.0000, 188.2166);
	CreateObject(966, 2852.939941, 1106.835571, 9.898438, 0.0000, 0.0000, 90.2409);
	entranceliftup=CreateObject(968, 2852.927246, 1106.827637, 10.957687, 0.0000, 268.0403, 90.2408);
	CreateObject(979, 2833.103271, 1090.475464, 10.723414, 0.0000, 0.0000, 194.2328);
	CreateObject(979, 2830.502441, 1099.226929, 10.705480, 0.0000, 0.0000, 7.7349);
	CreateObject(987, 2853.043213, 1100.138794, 9.864212, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 2853.359131, 1106.539673, 9.895482, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 2865.473389, 1106.563354, 9.898438, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 2864.110596, 1088.022339, 10.098434, 0.0000, 0.0000, 86.8031);
	CreateObject(987, 2877.392822, 1106.293213, 9.898438, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 2889.368652, 1106.202881, 9.898438, 0.0000, 0.0000, 268.8997);
	CreateObject(987, 2864.038574, 1081.205078, 9.898438, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 2876.045410, 1080.911255, 9.898438, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 2888.152832, 1080.711548, 9.898436, 0.0000, 0.0000, 87.6625);
	CreateObject(987, 2888.560303, 1089.383301, 9.898438, 0.0000, 0.0000, 87.6625);
	CreateObject(987, 2863.890625, 1081.442139, 9.898438, 0.0000, 0.0000, 275.7753);
	CreateObject(987, 2853.200195, 1069.457153, 9.898439, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 2842.823730, 1080.764404, 9.898438, 0.0000, 0.0000, 302.4177);
	CreateObject(987, 2848.982422, 1071.144409, 9.898438, 0.0000, 0.0000, 351.4056);
	startpointgate2=CreateObject(971, 2864.148193, 1085.352661, 13.493370, 0.0000, 0.0000, 268.0403);
	CreateObject(3167, 2886.986816, 1099.656738, 9.907223, 0.0000, 0.8594, 177.0440);
	CreateObject(967, 2864.864014, 1088.781128, 9.898438, 0.0000, 0.0000, 0.0000);
	CreateObject(3504, 2862.268799, 1077.079956, 11.240801, 0.0000, 0.0000, 0.0000);
	CreateObject(16105, 2855.470703, 1075.889648, 12.500778, 0.0000, 0.0000, 265.5660);
	CreateObject(16105, 2844.318359, 1090.128052, 12.500778, 0.0000, 0.0000, 204.5459);
	CreateObject(16105, 2846.339111, 1085.543213, 12.500779, 0.0000, 0.0000, 204.5460);
	CreateObject(3819, 2857.982910, 1097.171631, 10.896195, 0.0000, 0.8594, 87.6625);
	CreateObject(987, 2835.497803, 1105.909912, 9.884045, 0.0000, 0.0000, 3.4377);
	CreateObject(987, 2845.366211, 1106.355469, 9.886873, 0.0000, 0.0000, 0.0000);
	CreateObject(986, 2835.181152, 1103.757080, 11.584371, 0.0000, 0.0000, 269.7591);
	CreateObject(987, 2837.122559, 1091.993042, 10.270479, 0.0000, 0.0000, 18.0482);
	CreateObject(986, 2850.135254, 1097.364502, 11.609105, 0.0000, 0.0000, 44.6907);
	CreateObject(987, 2837.942627, 1091.563599, 9.898438, 0.0000, 0.0000, 294.6828);
	CreateObject(987, 2853.281982, 1069.915771, 15.138479, 0.0000, 0.0000, 358.2811);
	CreateObject(987, 2849.129883, 1071.019653, 14.898384, 0.0000, 0.0000, 352.2651);
	CreateObject(987, 2842.703857, 1080.915405, 14.773443, 0.0000, 0.0000, 302.4177);
	CreateObject(987, 2838.084961, 1091.209839, 14.883463, 0.0000, 0.0000, 294.6828);
	CreateObject(987, 2865.101807, 1069.534668, 14.498436, 0.0000, 0.0000, 94.5380);
	CreateObject(987, 2838.357422, 1091.635986, 14.892730, 0.0000, 0.0000, 22.3454);
	CreateObject(988, 2851.064941, 1097.815063, 16.873190, 0.0000, 0.0000, 48.1285);
	CreateObject(987, 2853.200439, 1100.029785, 15.267821, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 2864.130859, 1099.918945, 15.048435, 0.0000, 358.2811, 268.0403);

//the prison
prisongate1=CreateObject(971, -77.759476, 2500.834717, 19.079308, 0.0000, 0.0000, 269.8632);
CreateObject(987, -77.812683, 2496.289795, 15.943626, 0.0000, 0.0000, 270.6185);
CreateObject(987, -77.565079, 2505.451416, 16.192776, 0.0000, 0.0000, 91.1003);
CreateObject(987, -78.261414, 2496.300781, 20.861795, 0.0000, 0.0000, 270.6186);
CreateObject(987, -78.191315, 2505.321045, 22.530203, 0.0000, 0.0000, 268.8997);
CreateObject(987, -77.952179, 2517.491943, 20.959370, 0.0000, 0.0000, 270.6185);
CreateObject(987, -78.139099, 2517.031006, 15.484375, 0.0000, 0.0000, 70.4738);
CreateObject(987, -78.294014, 2517.046143, 20.209524, 0.0000, 0.0000, 70.4738);
CreateObject(987, -78.905235, 2484.039307, 15.484375, 0.0000, 0.0000, 317.0282);
CreateObject(987, -79.017799, 2483.866699, 20.459375, 0.0000, 0.0000, 315.3093);
CreateObject(5005, 5.390651, 2528.547852, 19.035892, 0.0000, 0.0000, 0.0000);
CreateObject(5005, 5.358701, 2528.507080, 25.108919, 0.0000, 0.0000, 0.0000);
CreateObject(5005, 9.549757, 2476.052734, 19.035892, 0.0000, 0.0000, 0.0000);
CreateObject(5005, 9.085743, 2476.609619, 24.856987, 0.0000, 0.0000, 0.0000);
CreateObject(5005, 164.526520, 2552.001465, 19.140167, 0.0000, 0.0000, 17.1887);
CreateObject(5005, 164.456894, 2552.328125, 24.976515, 0.0000, 0.0000, 17.1887);
CreateObject(5005, 171.811096, 2467.682129, 19.035892, 0.0000, 0.0000, 353.9839);
CreateObject(5005, 171.385239, 2468.238037, 24.903280, 0.0000, 0.0000, 353.9839);
CreateObject(5005, 300.552277, 2632.603271, 18.968704, 0.0000, 0.0000, 44.6907);
CreateObject(5005, 300.460632, 2632.710693, 24.990816, 0.0000, 0.0000, 44.6907);
CreateObject(5005, 250.837708, 2553.884521, 19.130211, 0.0000, 0.0000, 0.0000);
CreateObject(5005, 249.941040, 2554.185791, 24.973259, 0.0000, 0.0000, 0.0000);
CreateObject(987, 334.315186, 2553.783936, 15.803297, 0.0000, 0.0000, 0.0000);
CreateObject(987, 346.405365, 2553.656006, 15.722023, 0.0000, 0.0000, 0.0000);
CreateObject(987, 358.327728, 2553.415039, 15.623138, 0.0000, 0.0000, 0.0000);
CreateObject(987, 370.426971, 2552.952148, 15.611137, 0.0000, 0.0000, 359.1406);
CreateObject(987, 382.616974, 2552.471924, 15.539063, 0.0000, 0.0000, 0.0000);
CreateObject(987, 403.481659, 2552.210449, 15.457554, 0.0000, 0.0000, 0.0000);
CreateObject(971, 398.926117, 2552.461426, 19.140503, 0.0000, 0.0000, 180.4819);
CreateObject(987, 415.580841, 2552.176758, 15.417488, 0.0000, 0.0000, 0.0000);
CreateObject(987, 427.557617, 2551.902832, 15.211029, 0.0000, 0.0000, 0.0000);
CreateObject(987, 359.171661, 2552.468994, 15.577930, 0.0000, 0.0000, 270.6186);
CreateObject(987, 359.019196, 2540.593750, 15.469629, 0.0000, 0.0000, 271.4780);
CreateObject(987, 359.119629, 2552.446045, 20.492149, 0.0000, 0.0000, 268.8997);
CreateObject(987, 359.246307, 2540.641846, 20.696434, 0.0000, 0.0000, 268.8997);
CreateObject(987, 348.187500, 2553.212402, 19.937210, 0.0000, 0.0000, 0.0000);
CreateObject(987, 336.040314, 2553.277344, 20.009813, 0.0000, 0.0000, 0.0000);
CreateObject(987, 327.220245, 2553.328369, 20.864656, 0.0000, 0.0000, 0.0000);
CreateObject(5005, 295.339203, 2458.936768, 19.028080, 0.0000, 0.0000, 357.4217);
CreateObject(5005, 298.427002, 2458.303223, 24.778080, 0.0000, 0.0000, 357.4217);
CreateObject(5005, 443.502991, 2471.146484, 19.230297, 0.0000, 0.0000, 89.3814);
CreateObject(5005, 443.908325, 2471.022705, 25.371784, 0.0000, 0.0000, 89.3814);
CreateObject(987, 431.470184, 2475.573730, 15.506495, 0.0000, 0.0000, 0.0000);
CreateObject(987, 431.542450, 2475.017334, 20.440044, 0.0000, 0.0000, 0.0000);
CreateObject(987, 359.606140, 2529.643799, 15.692863, 0.0000, 0.0000, 0.0000);
CreateObject(987, 359.559570, 2529.359375, 20.816692, 0.0000, 0.0000, 0.0000);
CreateObject(987, 371.639709, 2529.680664, 15.634094, 0.0000, 0.0000, 0.0000);
CreateObject(987, 371.687775, 2529.674072, 20.709030, 0.0000, 0.0000, 0.0000);
CreateObject(987, 383.717163, 2529.784912, 15.575104, 0.0000, 0.0000, 0.0000);
CreateObject(987, 383.781982, 2529.805176, 20.543217, 0.0000, 0.0000, 0.0000);
CreateObject(971, 399.985352, 2529.597900, 19.171181, 0.0000, 0.0000, 0.0000);
CreateObject(987, 404.530914, 2529.675293, 15.557144, 0.0000, 0.0000, 0.0000);
CreateObject(987, 404.613953, 2529.517822, 20.554884, 0.0000, 0.0000, 0.0000);
CreateObject(987, 416.461365, 2529.670410, 15.589952, 0.0000, 0.0000, 0.0000);
CreateObject(987, 416.452942, 2529.772705, 20.606482, 0.0000, 0.0000, 0.0000);
CreateObject(987, 428.748199, 2529.653320, 15.648422, 0.0000, 0.0000, 0.0000);
CreateObject(987, 428.805573, 2529.528320, 20.315588, 0.0000, 0.0000, 0.0000);
CreateObject(987, 431.777802, 2529.923584, 15.573433, 0.0000, 0.0000, 0.0000);
CreateObject(987, 434.784393, 2529.519287, 20.002573, 0.0000, 0.0000, 0.0000);
CreateObject(986, -73.704781, 2496.514404, 17.195042, 0.0000, 0.0000, 2.5783);
CreateObject(986, -73.594498, 2505.487793, 17.195042, 0.0000, 0.0000, 0.0000);
CreateObject(971, -69.551216, 2501.022949, 19.029308, 0.0000, 0.0000, 90.2409);
CreateObject(987, 380.597900, 2476.532715, 15.303448, 0.0000, 0.0000, 0.0000);
CreateObject(987, 389.821350, 2476.536133, 15.312654, 0.0000, 0.0000, 0.0000);
CreateObject(987, 407.664032, 2476.730225, 15.492167, 0.0000, 0.0000, 0.0000);
CreateObject(971, 403.244293, 2476.729004, 19.037079, 0.0000, 0.0000, 0.0000);
CreateObject(987, 419.717010, 2476.615479, 15.467169, 0.0000, 0.0000, 0.0000);
CreateObject(987, 360.305939, 2543.758545, 15.627155, 0.0000, 0.0000, 0.0000);
CreateObject(987, 372.253632, 2543.870850, 15.539063, 0.0000, 0.0000, 0.0000);
CreateObject(976, 383.685516, 2552.337891, 15.506778, 0.0000, 0.0000, 272.3374);
CreateObject(983, 373.417114, 2532.787109, 16.308968, 0.0000, 0.0000, 0.0000);
CreateObject(983, 373.423859, 2540.575684, 16.222618, 0.0000, 0.0000, 0.0000);
CreateObject(986, 355.528564, 2553.086182, 17.299450, 0.0000, 0.0000, 172.6427);
CreateObject(16021, 345.795502, 2468.212158, 15.282158, 0.0000, 0.0000, 270.7227);
CreateObject(16051, 249.425598, 2475.835693, 18.634590, 0.0000, 0.0000, 268.1442);
CreateObject(1499, 286.493896, 2548.081787, 15.814369, 0.0000, 0.0000, 269.7591);
CreateObject(991, 283.226196, 2546.549316, 17.035505, 0.0000, 0.0000, 0.0000);
CreateObject(991, 286.450714, 2551.364990, 17.035210, 0.0000, 0.0000, 91.1003);
CreateObject(991, 283.210236, 2546.557129, 19.435215, 0.0000, 0.0000, 0.0000);
CreateObject(991, 286.486053, 2549.930420, 19.435076, 0.0000, 0.0000, 90.2409);
CreateObject(991, 283.139587, 2553.299072, 19.475445, 0.0000, 0.0000, 359.1406);
CreateObject(1755, 283.140228, 2552.691650, 15.816888, 0.0000, 0.0000, 0.0000);
CreateObject(2606, 291.587738, 2553.552734, 17.804031, 0.0000, 0.0000, 0.0000);
CreateObject(2604, 291.693787, 2552.701172, 16.618139, 0.0000, 0.0000, 0.0000);
CreateObject(1771, 283.801941, 2549.245605, 16.452410, 0.0000, 0.0000, 0.0000);
CreateObject(1562, 291.125732, 2551.614258, 16.476049, 0.0000, 0.0000, 184.7790);
CreateObject(1670, 281.723602, 2549.539307, 15.828691, 0.0000, 0.0000, 0.0000);
CreateObject(1499, 286.484375, 2538.488281, 15.814150, 0.0000, 0.0000, 90.2409);
CreateObject(991, 286.538330, 2543.298584, 17.035477, 0.0000, 0.0000, 89.2774);
CreateObject(991, 283.174194, 2538.478516, 17.033867, 0.0000, 0.0000, 0.0000);
CreateObject(991, 283.150269, 2538.486328, 19.393007, 0.0000, 0.0000, 0.0000);
CreateObject(991, 286.526398, 2541.844238, 19.426355, 0.0000, 0.0000, 89.3814);
CreateObject(991, 283.253876, 2545.090576, 17.092480, 0.0000, 0.0000, 0.0000);
CreateObject(991, 283.259064, 2545.123291, 19.417591, 0.0000, 0.0000, 0.0000);
CreateObject(1771, 280.422638, 2540.149414, 16.451593, 0.0000, 0.0000, 0.0000);
CreateObject(1800, 283.260925, 2544.002686, 15.771409, 0.0000, 0.0000, 88.5219);
CreateObject(1841, 286.352844, 2538.677979, 20.603914, 0.0000, 0.0000, 183.0601);
CreateObject(643, 283.518402, 2541.854736, 16.289145, 0.0000, 0.0000, 0.0000);
CreateObject(991, 295.430176, 2549.916992, 17.035492, 0.0000, 359.1406, 267.2848);
CreateObject(991, 298.535675, 2544.837891, 17.036144, 0.0000, 0.0000, 355.7028);
CreateObject(1499, 295.323517, 2545.101807, 15.815321, 0.0000, 0.0000, 87.6625);
CreateObject(991, 298.554321, 2544.849365, 19.399136, 0.0000, 0.0000, 355.7028);
CreateObject(991, 295.360046, 2548.434082, 19.436049, 0.0000, 0.0000, 267.1808);
CreateObject(991, 298.827423, 2551.726563, 17.025568, 0.0000, 0.0000, 0.0000);
CreateObject(991, 298.853851, 2551.760498, 19.452461, 0.0000, 0.0000, 0.0000);
CreateObject(1771, 301.090637, 2550.018799, 16.453190, 0.0000, 0.0000, 0.0000);
CreateObject(1771, 300.998444, 2546.829590, 16.428234, 0.0000, 0.0000, 0.0000);
CreateObject(1781, 297.910706, 2544.989014, 15.815859, 0.0000, 0.0000, 149.5420);
CreateObject(1785, 297.601990, 2545.248291, 15.922196, 0.0000, 0.0000, 0.0000);
CreateObject(643, 297.794067, 2548.888184, 16.291601, 0.0000, 0.0000, 0.0000);
CreateObject(991, 295.192535, 2541.770264, 17.036983, 0.0000, 0.0000, 269.0036);
CreateObject(1499, 295.134796, 2536.949219, 15.815323, 0.0000, 0.0000, 88.5220);
CreateObject(991, 298.369354, 2536.864746, 17.055265, 0.0000, 0.0000, 358.2811);
CreateObject(991, 298.376678, 2536.846191, 19.441088, 0.0000, 0.0000, 358.2811);
CreateObject(991, 295.173157, 2540.327881, 19.410887, 0.0000, 0.0000, 268.8997);
CreateObject(991, 298.609772, 2543.676270, 16.954479, 0.0000, 0.0000, 0.0000);
CreateObject(991, 298.580933, 2543.659180, 19.375154, 0.0000, 0.0000, 0.0000);
CreateObject(976, 294.841583, 2533.118408, 15.931403, 0.0000, 0.0000, 180.4819);
CreateObject(979, 281.409271, 2532.726563, 16.658379, 0.0000, 0.0000, 184.7789);
CreateObject(979, 299.649078, 2532.832031, 16.660460, 0.0000, 0.0000, 176.1845);






	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
    new pName[MAX_PLAYER_NAME];
    new string[48];
    GetPlayerName(playerid, pName, sizeof(pName));
    format(string, sizeof(string), "%s has joined the server.", pName);
    SendClientMessageToAll(COLOR_WHITE, string);
    SendClientMessage(playerid, COLOR_YELLOW, "-----------------[Prison Roleplay]------------------");
   	SendClientMessage(playerid, COLOR_WHITE, "Welcome to Prison Roleplay V0.1, Type /help for a basic idea of the server.");
	SendClientMessage(playerid, COLOR_RED, "YOU MUST LOGIN BEFORE YOU SPAWN OR AUTOKICK!");
	mute[playerid] = 0;
	if (udb_Exists(PlayerName(playerid)) == 0)
	{
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "Your account doesn't exists in the database, Type /register password.");
	}
	if (udb_Exists(PlayerName(playerid)) == 1)
	{
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "Your account exists in the database, Type /login password.");
	}
	SendClientMessage(playerid, COLOR_YELLOW, "-------------------------------------------------------");
	logged[playerid] = 0;
	GameTextForPlayer(playerid,"Welcome to ~r~Prison~w~ Roleplay V0.1",2500,5);
	SetPlayerColor(playerid, COLOR_GREY); // Set the player's color to inactive
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{

	if (logged[playerid] == 1) dUserSetINT(PlayerName(playerid)).("money", GetPlayerMoney(playerid));
	logged[playerid] = 0;

    new pName[MAX_PLAYER_NAME];
    new string[56];
    GetPlayerName(playerid, pName, sizeof(pName));

    switch(reason)
    {
        case 0: format(string, sizeof(string), "%s has left the server. (Timeout)", pName);
        case 1: format(string, sizeof(string), "%s has left the server. (Leaving)", pName);
        case 2: format(string, sizeof(string), "%s has left the server. (Kicked)", pName);
    }

    SendClientMessageToAll(COLOR_WHITE, string);
    return 1;


}
public busarrived()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
	if (PlayerToPoint(500.0, i, 236.5530,2504.7466,16.0612) && dUserINT(PlayerName(i)).("prison") == 1 && dUserINT(PlayerName(i)).("prisonguard") == 0 && dUserINT(PlayerName(i)).("warden") == 0)
	{//first information icon startup area
	GameTextForPlayer(i, "~r~Welcome to paradise", 5000, 5);
	dUserSet(PlayerName(i)).("prison", "2");
	SpawnPlayer(i);
}
}
}
return 1;
}
public custompickups()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
	if (PlayerToPoint(1.0, i, 2850.6309,1086.3667,10.8984))
	{//first information icon startup area
	GameTextForPlayer(i, "~w~/enter", 5000, 5);
	}
	else if (PlayerToPoint(1.0, i, 339.6304,2469.3435,17.4853))
	{//reaturaunt
	GameTextForPlayer(i, "~r~The Food Court~n~~w~/enter", 5000, 5);
	}
	else if (PlayerToPoint(1.0, i, 252.0558,2476.9355,16.4844))
	{//bar
	GameTextForPlayer(i, "~r~The Old Tavern~n~~w~/enter", 5000, 5);
	}
	else if (PlayerToPoint(1.0, i, 240.5882,2477.4216,16.4844))
	{//tv hall
	GameTextForPlayer(i, "~r~Television Hall~n~~w~/enter", 5000, 5);
	}
	else if (PlayerToPoint(1.0, i, 2848.5449,1091.0938,10.8984))
	{//second information icon startup area
	GameTextForPlayer(i, "~w~/enter", 5000, 5);
	}
	else if (PlayerToPoint(1.0, i, 2856.7773,1080.0518,10.8984))
	{//third information icon startup area
	GameTextForPlayer(i, "~w~/enter", 5000, 5);
	}
}
}
return 1;
}
public OnPlayerSpawn(playerid)
{
	if (dUserINT(PlayerName(playerid)).("prison") == 1)
	{
	SendClientMessage(playerid,COLOR_YELLOW,"You are waiting for a bus to the prison.");
	SetPlayerPos(playerid,2854.2229,1088.7697,10.8984);
	}
	if (dUserINT(PlayerName(playerid)).("prisonguard") == 1 && dUserINT(PlayerName(playerid)).("staffskin") == 1)//spawn and skin
	{
	SetPlayerPos(playerid,2883.9705,1096.9034,10.8984);
	SetPlayerSkin(playerid,283);
	GivePlayerWeapon(playerid, 23, 150);
	GivePlayerWeapon(playerid, 5, 0);
	SetPlayerColor(playerid,COLOR_BLUE);
	}
	if (dUserINT(PlayerName(playerid)).("prisonguard") == 1 && dUserINT(PlayerName(playerid)).("staffskin") == 2)//spawn and skin
	{
	SetPlayerPos(playerid,2883.9705,1096.9034,10.8984);
	SetPlayerSkin(playerid,281);
	GivePlayerWeapon(playerid, 23, 150);
	GivePlayerWeapon(playerid, 5, 0);
	SetPlayerColor(playerid,COLOR_BLUE);
	}
	if (dUserINT(PlayerName(playerid)).("prisonguard") == 1 && dUserINT(PlayerName(playerid)).("staffskin") == 3)//spawn and skin
	{
	SetPlayerPos(playerid,2883.9705,1096.9034,10.8984);
	SetPlayerSkin(playerid,280);
	GivePlayerWeapon(playerid, 23, 150);
	GivePlayerWeapon(playerid, 5, 0);
	SetPlayerColor(playerid,COLOR_BLUE);
	}
	if (dUserINT(PlayerName(playerid)).("prisonguard") == 2 && dUserINT(PlayerName(playerid)).("staffskin") == 1)//prison spawn and skin
	{
	SetPlayerSkin(playerid,283);
	SetPlayerPos(playerid,413.9608,2534.6587,19.1484);
	GivePlayerWeapon(playerid, 23, 150);
	GivePlayerWeapon(playerid, 5, 0);
	SetPlayerColor(playerid,COLOR_BLUE);
	}
	if (dUserINT(PlayerName(playerid)).("prisonguard") == 2 && dUserINT(PlayerName(playerid)).("staffskin") == 2)//prison spawn and skin
	{
	SetPlayerSkin(playerid,281);
	SetPlayerPos(playerid,413.9608,2534.6587,19.1484);
	GivePlayerWeapon(playerid, 23, 150);
	GivePlayerWeapon(playerid, 5, 0);
	SetPlayerColor(playerid,COLOR_BLUE);
	}
	if (dUserINT(PlayerName(playerid)).("prisonguard") == 2 && dUserINT(PlayerName(playerid)).("staffskin") == 3)//prison spawn and skin
	{
	SetPlayerSkin(playerid,280);
	SetPlayerPos(playerid,413.9608,2534.6587,19.1484);
	GivePlayerWeapon(playerid, 23, 150);
	GivePlayerWeapon(playerid, 5, 0);
	SetPlayerColor(playerid,COLOR_BLUE);
	}
	if (dUserINT(PlayerName(playerid)).("prison") == 2)
	{
	SetPlayerPos(playerid,298.6311,2540.0984,16.8207);
	}
	if (logged[playerid] == 0)
	{
    	new pName[MAX_PLAYER_NAME];
    	new string1[128];
    	GetPlayerName(playerid, pName, sizeof(pName));
    	format(string1, sizeof(string1), "%s has been kicked from the server, Reason: Spawning before login.", pName);
    	SendClientMessageToAll(COLOR_RED, string1);
		Kick(playerid);
	}
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
	return 1;
}

public OnPlayerText(playerid, text[])
{
	new giver[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new tmp[256];
	new string[256];
	new giveplayerid;

	if (realchat)
	{
	    if(logged[playerid] == 0)
	    {
	        return 0;
      	}
	    if(mute[playerid] == 1)
	    {
	    SendClientMessage(playerid,COLOR_YELLOW,"You can't speak your muted");
	        return 0;
      	}
      	new string[256];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s Says: %s", sendername, text);
		ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		return 0;
	}
	return 1;
}

public OnPlayerPrivmsg(playerid, recieverid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new string[256];
	new playermoney;
	new giveplayer[MAX_PLAYER_NAME];
	new cmd[256];
	new tmp[256];
	new giveplayerid, moneys, idx;

	cmd = strtok(cmdtext, idx);
	
	if (strcmp(cmd, "/login", true) == 0)
	{
	   	if (dUserINT(PlayerName(playerid)).("banned") == 1)
		{
    	new pName[MAX_PLAYER_NAME];
    	new string1[128];
    	GetPlayerName(playerid, pName, sizeof(pName));
    	format(string1, sizeof(string1), "%s has been kicked from the server, Reason: ACCOUNT BANNED.", pName);
    	SendClientMessageToAll(COLOR_RED, string1);
		Kick(playerid);
  		}
		else if (logged[playerid] != 1 && udb_Exists(PlayerName(playerid)))
		{
			new dir[256];
			dir = strtok(cmdtext, idx);
			if (strlen(dir) && strcmp(dir, dUser(PlayerName(playerid)).("password"), true) == 0)
		{
			logged[playerid] = 1;
			SendClientMessage(playerid, COLOR_RED, "Successfully Logged in!");
			GivePlayerMoney(playerid, dUserINT(PlayerName(playerid)).("money"));
    		SpawnPlayer(playerid);
   			SetTimer("finishlogin", 1000, 0);
		}
	}
		else SendClientMessage(playerid, COLOR_RED, "Login error!");
		return 1;
	}


	if (strcmp(cmd, "/register", true) == 0)
	{
	if (logged[playerid] != 1 && !udb_Exists(PlayerName(playerid)))
			{
			new dir[256];
			dir = strtok(cmdtext, idx);
			if (strlen(dir))
		{
			new fname[MAX_STRING];
			format(fname,sizeof(fname),"%s.ini",udb_encode(PlayerName(playerid)));
			dini_Create(fname);
			dUserSet(PlayerName(playerid)).("password", dir);
			dUserSet(PlayerName(playerid)).("admin", "0");
			dUserSet(PlayerName(playerid)).("vip", "0");
			dUserSet(PlayerName(playerid)).("prisonguard", "0");
			dUserSet(PlayerName(playerid)).("warden", "0");
			dUserSet(PlayerName(playerid)).("prisoner", "1");
			dUserSet(PlayerName(playerid)).("banned", "0");
			dUserSet(PlayerName(playerid)).("money", "10000");
			dUserSet(PlayerName(playerid)).("prison", "1");
			dUserSet(PlayerName(playerid)).("staffskin", "1");
			SendClientMessage(playerid, COLOR_RED, "Registered! Please login with /login [password]");
		}
	}
	else SendClientMessage(playerid, COLOR_RED, "Register error!");
	return 1;
}
	if (logged[playerid] == 0) {
	SendClientMessage(playerid, COLOR_YELLOW, "{SERVER] You must be logged in to use commands!");
 	return 0;
	}
		if(strcmp(cmd, "/makeguard", true) == 0)
{
if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	{
 			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "Administrator %s has made %s a start area prison guard.", sendername,giveplayer);
			dUserSet(PlayerName(giveplayerid)).("prisonguard", "1");
			dUserSet(PlayerName(giveplayerid)).("prison", "0");
			SendClientMessageToAll(COLOR_LIGHTBLUE, string);
			SpawnPlayer(giveplayerid);
	}
	else
 	{
 	SendClientMessage(playerid, COLOR_YELLOW, "You are not an administrator or an administrator with the required level.");
  	}
return 1;
}
		if(strcmp(cmd, "/makeguard1", true) == 0)
{
if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	{
 			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "Administrator %s has made %s a prison guard.", sendername,giveplayer);
			dUserSet(PlayerName(giveplayerid)).("prisonguard", "2");
			dUserSet(PlayerName(giveplayerid)).("prison", "0");
			SendClientMessageToAll(COLOR_LIGHTBLUE, string);
			SpawnPlayer(giveplayerid);
	}
	else
 	{
 	SendClientMessage(playerid, COLOR_YELLOW, "You are not an administrator or an administrator with the required level.");
  	}
return 1;
}
	if (strcmp("/kill", cmdtext, true, 4) == 0)
	{
	SetPlayerHealth(playerid,0.0);
		return 1;
	}
	if (strcmp("/nrg", cmdtext, true, 4) == 0)
	{
		new Float:X, Float:Y, Float:Z, Float:R;
        GetPlayerPos(playerid, X, Y, Z);
        GetPlayerFacingAngle(playerid, R);
        new vehicle = CreateVehicle(522, X, Y, Z, R, 1, 1, 10000);
        PutPlayerInVehicle(playerid, vehicle, 0);
		return 1;
	}
 	if (strcmp(cmdtext, "/lock", true)==0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new State=GetPlayerState(playerid);
			if(State!=PLAYER_STATE_DRIVER)
			{
				SendClientMessage(playerid,COLOR_RED,"You can lock only as drivers!.");
				return 1;
			}
			new i;
			for(i=0;i<MAX_PLAYERS;i++)
			{
				if(i != playerid)
				{
					SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 1);
				}
			}
			SendClientMessage(playerid, COLOR_GREEN, "***Vehicle locked!");
		    new Float:pX, Float:pY, Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			PlayerPlaySound(playerid,1056,pX,pY,pZ);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "You are in no vehicle!");
		}
		return 1;
}

    if (strcmp(cmdtext, "/unlock", true)==0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new State=GetPlayerState(playerid);
			if(State!=PLAYER_STATE_DRIVER)
			{
				SendClientMessage(playerid,COLOR_RED,"You can unlock only as drivers!");
				return 1;
			}
			new i;
			for(i=0;i<MAX_PLAYERS;i++)
			{
				SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
			}
			SendClientMessage(playerid, COLOR_GREEN, "***Vehicle unlocked!");
			new Float:pX, Float:pY, Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			PlayerPlaySound(playerid,1057,pX,pY,pZ);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "You are in no vehicle!");
		}
		return 1;
	}
  	if (strcmp(cmdtext, "/ah", true)==0)
	{
	if(dUserINT(PlayerName(playerid)).("admin") >= 1)
	{
	SendClientMessage(playerid, COLOR_YELLOW, "* 1: /ban /kick /mute /unmute /noooc");
	SendClientMessage(playerid, COLOR_YELLOW, "* 5: /makeguard /removeguard, /makevip /removevip)");
	}
	else
	{
	SendClientMessage(playerid, COLOR_YELLOW, "Your not an administrator.");
	return 1;
	}
	}
	if (strcmp("/commands", cmdtext, true, 4) == 0)
	{
	SendClientMessage(playerid,COLOR_YELLOW,"[Commands List]");
	SendClientMessage(playerid,COLOR_YELLOW,"General: /ooc /me /status /ah /admins /prisonguards");
	if (dUserINT(PlayerName(playerid)).("prisonguard") == 1 || dUserINT(PlayerName(playerid)).("prisonguard") == 2)
	{
	SendClientMessage(playerid,COLOR_YELLOW,"Prison Guard: /busarrived /staffskin /prisonlocation ");
	}
	return 1;
	}
	
 		if(strcmp(cmdtext, "/dive", true) == 0){
		new Float:x;
		new Float:y;
		new Float:z;
		GivePlayerWeapon(playerid,46,1);
		GetPlayerPos(playerid,x,y,z);
		SetPlayerPos(playerid,x,y,z+500);
		GameTextForPlayer(playerid,"ESCAPE!",2000,5);
		return 1;}
		
 	if (strcmp(cmdtext, "/status", true)==0)
	{
	if(dUserINT(PlayerName(playerid)).("admin") >= 1)
	{
	SendClientMessage(playerid, COLOR_YELLOW, "* You are an administrator");
	}
	else
	{
	SendClientMessage(playerid, COLOR_YELLOW, "Your not an administrator.");
	return 1;
	}
	if(dUserINT(PlayerName(playerid)).("prisonguard") == 1 || dUserINT(PlayerName(playerid)).("prisonguard") == 2)
	{
	SendClientMessage(playerid, COLOR_YELLOW, "* You are a prison guard.");
	}
	else
	{
	SendClientMessage(playerid, COLOR_YELLOW, "* Your not a prison guard.");
	return 1;
	}
 	if(dUserINT(PlayerName(playerid)).("vip") == 1)
	{
	SendClientMessage(playerid, COLOR_YELLOW, "* Your a VIP member.");
	}
	else
	{
	SendClientMessage(playerid, COLOR_YELLOW, "* Your not vip.");
	return 1;
	}
	}
  	if(strcmp(cmd, "/staffskin", true) == 0)
	{
	        if(dUserINT(PlayerName(playerid)).("prisonguard") == 1 || dUserINT(PlayerName(playerid)).("prisonguard") == 2)
	        {
	            if(dUserINT(PlayerName(playerid)).("prisonguard") == 0)
	            {
	                SendClientMessage(playerid, COLOR_GREY, "You are not a prison guard!");
	                return 1;
	            }
	            new x_nr[256];
				x_nr = strtok(cmdtext, idx);
				if(!strlen(x_nr)) {
					SendClientMessage(playerid, COLOR_WHITE, "|__________________ Staff SKins __________________|");
					SendClientMessage(playerid, COLOR_WHITE, "USAGE: /staffskin 1-3");
					SendClientMessage(playerid, COLOR_WHITE, "|___________________________________________________|");
					return 1;
				}
			    if(strcmp(x_nr,"1",true) == 0)
				{
				SetPlayerSkin(playerid,283);
				dUserSet(PlayerName(playerid)).("staffskin", "1");
				SendClientMessage(playerid,COLOR_YELLOW,"From now on you will spawn with skin 1.");
				}
			    if(strcmp(x_nr,"2",true) == 0)
				{
				SetPlayerSkin(playerid,281);
				dUserSet(PlayerName(playerid)).("staffskin", "2");
				SendClientMessage(playerid,COLOR_YELLOW,"From now on you will spawn with skin 2.");
				}
			    if(strcmp(x_nr,"3",true) == 0)
				{
				SetPlayerSkin(playerid,280);
				dUserSet(PlayerName(playerid)).("staffskin", "3");
				SendClientMessage(playerid,COLOR_YELLOW,"From now on you will spawn with skin 3.");
				}
	    }
	    return 1;
	}
	if(strcmp(cmd, "/busarrived", true) == 0)
	{
	if (((PlayerToPoint(500.0, playerid, 236.5530,2504.7466,16.0612)) && dUserINT(PlayerName(playerid)).("prisonguard") >= 1 || dUserINT(PlayerName(playerid)).("warden") == 1))
	{
		SetTimer("busarrived", 1000, 0);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Conficts are being unloaded from the bus and put into the prison.");
		SendClientMessage(playerid,COLOR_ORANGE,"Done!");
		
  	} else {
 	SendClientMessage(playerid,COLOR_YELLOW,"You are not at the prison entrance or are a prison guard/warden.");
 	}
	return 1;
	}
	if(strcmp(cmd, "/prisonlocation", true) == 0)
	{
	if (dUserINT(PlayerName(playerid)).("prisonguard") >= 1 || dUserINT(PlayerName(playerid)).("warden") == 1)
	{
		SetPlayerCheckpoint(playerid, 395.6659,2556.6609,16.1122, 25.0);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Marker Set!");

  	} else {
 	SendClientMessage(playerid,COLOR_YELLOW,"You are not a prison guard/warden.");
 	}
	return 1;
	}
	if (strcmp("/heli", cmdtext, true, 4) == 0)
	{
		new Float:X, Float:Y, Float:Z, Float:R;
        GetPlayerPos(playerid, X, Y, Z);
        GetPlayerFacingAngle(playerid, R);
        new vehicle = CreateVehicle(548, X, Y, Z, R, 1, 1, 10000);
        PutPlayerInVehicle(playerid, vehicle, 0);
		return 1;
	}
 	if (strcmp("/bus", cmdtext, true, 4) == 0)
	{
		new Float:X, Float:Y, Float:Z, Float:R;
        GetPlayerPos(playerid, X, Y, Z);
        GetPlayerFacingAngle(playerid, R);
        new vehicle = CreateVehicle(431, X, Y, Z, R, 1, 1, 10000);
        PutPlayerInVehicle(playerid, vehicle, 0);
		return 1;
	}
	if (strcmp("/opengate", cmdtext, true, 10) == 0)
	{
		MoveObject( startpointgate1, 2836.476807, 1095.697388, 0.421704, 2.00 );
		return 1;
	}
	if (strcmp("/opengate2", cmdtext, true, 10) == 0)
	{
		MoveObject( startpointgate2, 2864.148193, 1085.352661, 0.493370, 2.00 );
		return 1;
	}
	if (strcmp("/opengate3", cmdtext, true, 10) == 0)
	{
		SetObjectRot( entranceliftup, 0.000000, 0.000000, 0.000000);
		return 1;
	}
	//----------------------------------[ooc]-----------------------------------------------
	if(strcmp(cmd, "/ooc", true) == 0 || strcmp(cmd, "/o", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(logged[playerid] == 0)
	        {
	            SendClientMessage(playerid, COLOR_GREY, "You are not logged in.");
	            return 1;
	        }
			if ((noooc) && dUserINT(PlayerName(playerid)).("admin") >= 1)
			{
				SendClientMessage(playerid, COLOR_GRAD2, "Global chat is disabled!");
				return 1;
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: (/o)oc [ooc chat]");
				return 1;
			}
			format(string, sizeof(string), "(( %s: %s ))", sendername, result);
			OOCOff(COLOR_OOC,string);
			printf("%s", string);
		}
		return 1;
	}
	if(strcmp(cmd, "/noooc", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (dUserINT(PlayerName(playerid)).("admin") >= 1 && (!noooc))
			{
				noooc = 1;
				BroadCast(COLOR_YELLOW, "Out Of Character chat has been disabled by an administrator!");
			}
			else if (dUserINT(PlayerName(playerid)).("admin") >= 1 && (noooc))
			{
				noooc = 0;
				BroadCast(COLOR_GRAD2, "Out Of Character chat has been enabled by an administrator!");
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "You are not an administrator!");
			}
		}
		return 1;
	}
		if(strcmp(cmd, "/removeguard", true) == 0)
{
new reason[256];
if (dUserINT(PlayerName(playerid)).("admin") >= 5)
	{
	tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /removeguard [playerid] [reason]");
			SendClientMessage(playerid, COLOR_WHITE, "FUNCTION: Will remove the specified account a member of the clan.");
			return 1;
  }

		giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
		    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			while ((idx < length) && ((idx - offset) < (sizeof(reason) - 1)))
			{
				reason[idx - offset] = cmdtext[idx];
				idx++;
			}
			reason[idx - offset] = EOS;
			if(!strlen(reason))
				{
					SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /removeguard [playerid] [reason]");
					return 1;
				}
			else
			{
			format(string, sizeof(string), "Administrator %s has set %s back to a prisoner. - Reason: %s", sendername,giveplayer,reason);
			dUserSet(PlayerName(giveplayerid)).("prisonguard", "0");
			SendClientMessageToAll(COLOR_LIGHTBLUE, string);
			SpawnPlayer( giveplayerid );

			}
		}
		else if(giveplayerid == INVALID_PLAYER_ID)
		{
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
	}
	else
 	{
 	SendClientMessage(playerid, COLOR_YELLOW, "You are not an administrator or an administrator with the required level.");
  	}
return 1;
}
	if(strcmp(cmd, "/removevip", true) == 0)
{
new reason[256];
if (dUserINT(PlayerName(playerid)).("admin") >= 5)
	{
	tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /removemember [playerid] [reason]");
			SendClientMessage(playerid, COLOR_WHITE, "FUNCTION: Will remove the specified account a member of the clan.");
			return 1;
  }

		giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
		    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			while ((idx < length) && ((idx - offset) < (sizeof(reason) - 1)))
			{
				reason[idx - offset] = cmdtext[idx];
				idx++;
			}
			reason[idx - offset] = EOS;
			if(!strlen(reason))
				{
					SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /removemember [playerid] [reason]");
					return 1;
				}
			else
			{
			format(string, sizeof(string), "Administrator %s has removed %s's VIP Rank. - Reason: %s", sendername,giveplayer,reason);
			dUserSet(PlayerName(giveplayerid)).("clanmember", "0");
			SendClientMessageToAll(COLOR_LIGHTBLUE, string);
			}
		}
		else if(giveplayerid == INVALID_PLAYER_ID)
		{
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
	}
	else
 	{
 	SendClientMessage(playerid, COLOR_YELLOW, "You are not an administrator or an administrator with the required level.");
  	}
return 1;
}
//----------------------------------[Emote]-----------------------------------------------
	if(strcmp(cmd, "/me", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(logged[playerid] == 0)
	        {
	            SendClientMessage(playerid, COLOR_GREY, "You must be logged in!");
	            return 1;
	        }
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /me [action]");
				return 1;
			}
			format(string, sizeof(string), "* %s %s", sendername, result);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			printf("%s", string);
		}
		return 1;
	}
 		if(strcmp(cmd, "/kick", true) == 0)
{
new reason[256];
if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	{
	tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /kick [playerid] [reason]");
			SendClientMessage(playerid, COLOR_WHITE, "FUNCTION: Will kick the specified player.");
			return 1;
  }

		giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
		    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			while ((idx < length) && ((idx - offset) < (sizeof(reason) - 1)))
			{
				reason[idx - offset] = cmdtext[idx];
				idx++;
			}
			reason[idx - offset] = EOS;
			if(!strlen(reason))
				{
					SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /kick [playerid] [reason]");
					return 1;
				}
			else
			{
			format(string, sizeof(string), "Administrator %s has kicked %s - Reason: %s", sendername,giveplayer,reason);
			SendClientMessageToAll(COLOR_YELLOW, string);
			Kick(giveplayerid);
			}
		}
		else if(giveplayerid == INVALID_PLAYER_ID)
		{
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
	}
	else
 	{
 	SendClientMessage(playerid, COLOR_YELLOW, "You are not an administrator or an administrator with the required level.");
  	}
return 1;
}
	if(strcmp(cmd, "/unmute", true) == 0)
{
if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	{
 			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "Administrator %s has unmuted %s", sendername,giveplayer);
			mute[playerid] = 0;
			SendClientMessageToAll(COLOR_YELLOW, string);
	}
	else
 	{
 	SendClientMessage(playerid, COLOR_YELLOW, "You are not an administrator or an administrator with the required level.");
  	}
return 1;
}
	if(strcmp(cmd, "/mute", true) == 0)
{
new reason[256];
if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	{
	tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /mute [playerid] [reason]");
			SendClientMessage(playerid, COLOR_WHITE, "FUNCTION: Will BAN the specified account.");
			return 1;
  }

		giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
		    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			while ((idx < length) && ((idx - offset) < (sizeof(reason) - 1)))
			{
				reason[idx - offset] = cmdtext[idx];
				idx++;
			}
			reason[idx - offset] = EOS;
			if(!strlen(reason))
				{
					SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /mute [playerid] [reason]");
					return 1;
				}
			else
			{
			format(string, sizeof(string), "Administrator %s has muted %s - Reason: %s", sendername,giveplayer,reason);
			mute[playerid] = 1;
			SendClientMessageToAll(COLOR_YELLOW, string);
			}
		}
		else if(giveplayerid == INVALID_PLAYER_ID)
		{
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
	}
	else
 	{
 	SendClientMessage(playerid, COLOR_YELLOW, "You are not an administrator or an administrator with the required level.");
  	}
return 1;
}
 	if(strcmp(cmd, "/ban", true) == 0)
{
new reason[256];
if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	{
	tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /ban [playerid] [reason]");
			SendClientMessage(playerid, COLOR_WHITE, "FUNCTION: Will BAN the specified account.");
			return 1;
  }

		giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
		    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			while ((idx < length) && ((idx - offset) < (sizeof(reason) - 1)))
			{
				reason[idx - offset] = cmdtext[idx];
				idx++;
			}
			reason[idx - offset] = EOS;
			if(!strlen(reason))
				{
					SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /ban [playerid] [reason]");
					return 1;
				}
			else
			{
			format(string, sizeof(string), "Administrator %s has banned %s - Reason: %s", sendername,giveplayer,reason);
			dUserSet(PlayerName(giveplayerid)).("banned", "1");
			SendClientMessageToAll(COLOR_YELLOW, string);
			Kick(giveplayerid);
			}
		}
		else if(giveplayerid == INVALID_PLAYER_ID)
		{
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
	}
	else
 	{
 	SendClientMessage(playerid, COLOR_YELLOW, "You are not an administrator or an administrator with the required level.");
  	}
return 1;
}
	if (strcmp(cmd, "/admins", true) == 0)
	{
		SendClientMessage(playerid, COLOR_GREEN, "|---------------Online Admins---------------|");
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    if (IsPlayerConnected(i))
	  		{
  				if(dUserINT(PlayerName(playerid)).("admin") >= 1 && dUserINT(PlayerName(playerid)).("admin") <= 5)
	    			{
						GetPlayerName(i, player, sizeof(player));
						format(string, 128, "*** Administrator %s", player);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					}
			}
		}
		SendClientMessage(playerid, COLOR_GREEN, "|--------------------------------------------------|");
		return 1;
	}
	if(strcmp(cmd, "/makevip", true) == 0)
{
if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	{
 			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "Administrator %s has made %s VIP.", sendername,giveplayer);
			dUserSet(PlayerName(giveplayerid)).("vip", "1");
			SendClientMessageToAll(COLOR_LIGHTBLUE, string);
	}
	else
 	{
 	SendClientMessage(playerid, COLOR_YELLOW, "You are not an administrator or an administrator with the required level.");
  	}
return 1;
}
 	if (strcmp(cmd, "/prisonguards", true) == 0)
	{
		SendClientMessage(playerid, COLOR_GREEN, "|---------------Online Clan Members---------------|");
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    if (IsPlayerConnected(i))
	  		{
  				if(dUserINT(PlayerName(playerid)).("prisonguard") == 1 || dUserINT(PlayerName(playerid)).("prisonguard") == 2)
	    			{
						GetPlayerName(i, player, sizeof(player));
						format(string, 128, "*** Prison Guard %s", player);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					}
			}
		}
		SendClientMessage(playerid, COLOR_GREEN, "|--------------------------------------------------|");
		return 1;
	}
 	if(strcmp(cmd, "/givecash", true) == 0) {
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /givecash [playerid] [amount]");
			return 1;
		}
		giveplayerid = strval(tmp);

		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /givecash [playerid] [amount]");
			return 1;
		}
 		moneys = strval(tmp);

		//printf("givecash_command: %d %d",giveplayerid,moneys);


		if (IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			playermoney = GetPlayerMoney(playerid);
			if (moneys > 0 && playermoney >= moneys) {
				GivePlayerMoney(playerid, (0 - moneys));
				GivePlayerMoney(giveplayerid, moneys);
				format(string, sizeof(string), "You have sent %s(player: %d), $%d.", giveplayer,giveplayerid, moneys);
				SendClientMessage(playerid, COLOR_YELLOW, string);
				format(string, sizeof(string), "You have recieved $%d from %s(player: %d).", moneys, sendername, playerid);
				SendClientMessage(giveplayerid, COLOR_YELLOW, string);
				printf("%s(playerid:%d) has transfered %d to %s(playerid:%d)",sendername, playerid, moneys, giveplayer, giveplayerid);
			}
			else {
				SendClientMessage(playerid, COLOR_YELLOW, "Invalid transaction amount.");
			}
		}
		else
		{
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
		return 1;
}
	return 1;
}

public OnPlayerInfoChange(playerid)
{
	return 1;
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
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}
public finishlogin(playerid)
{
	if (dUserINT(PlayerName(playerid)).("prison") == 1)
	{
	SetPlayerColor(playerid,COLOR_GOLD);//hasn't left start area
	}
	if (dUserINT(PlayerName(playerid)).("prison") == 2)
	{
	SetPlayerColor(playerid,COLOR_ORANGE);//has been transported to prison
	}
	else if (dUserINT(PlayerName(playerid)).("prisonguard") == 1 || dUserINT(PlayerName(playerid)).("prisonguard") == 2)
	{
	SendClientMessage(playerid,COLOR_ORANGE,"You are an officer of the law, Have a good day at work.");
	SetPlayerColor(playerid,COLOR_BLUE);
	}
 	else if (dUserINT(PlayerName(playerid)).("warden") == 1)
	{
	SendClientMessage(playerid,COLOR_ORANGE,"You are the warden! Enjoy making the prisoners lives hell!");
	SetPlayerColor(playerid,COLOR_LIGHTBLUE);
	}
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
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}
public ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(!BigEar[i])
				{
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);
					//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
						SendClientMessage(i, col1, string);
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
						SendClientMessage(i, col2, string);
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
						SendClientMessage(i, col3, string);
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
						SendClientMessage(i, col4, string);
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
						SendClientMessage(i, col5, string);
					}
				}
				else
				{
					SendClientMessage(i, col1, string);
				}
			}
		}
	}//not connected
	return 1;
}
public OnPlayerExitedMenu(playerid)
{
	return 1;
}
stock PlayerName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	return name;
}
public BroadCast(color,const string[])
{
	SendClientMessageToAll(color, string);
	return 1;
}

public OOCOff(color,const string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(!gOoc[i])
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}
