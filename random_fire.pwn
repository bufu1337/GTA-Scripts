#include <a_samp>
#include zcmd
#include sscanf2
// BETA RELEASE
/* --------------------------------------------------
    _______ __  __ _____  _____   _______ _______
   [ __   ][ ] [ ][ ___] [ __ ]  [ _____][__  __]
  [ [ ]  ][ ] [ ][ [    [ [_] ] [___  ]    [ ]
 [ [_]  ][ ]_[ ][ [___ [ ____ ] ___[ ]    [ ]
[______][_____][_____][_]   [_][____]    [_]

   --------------------------------------------------
> COMMANDS LIST:
 - /putoutfire - Extingush the fire (on foot - 5 points, in firetruck - 15 points)
 - NOTE: The fire has in total of 100 points, that are substracted by each /putoutfire
*/

// New global variables
new bool:FireInProgress = false;
new FireStatus = 0;
new o1, o2, o3, o4, o5;
new bool:Reload[MAX_PLAYERS] = false;
new timer;

forward CreateFire(Float:X1, Float:Y1, Float:Z1, Float:R1, Float:X2, Float:Y2, Float:Z2, Float:R2, Float:X3, Float:Y3, Float:Z3, Float:R3, Float:X4, Float:Y4, Float:Z4, Float:R4, Float:X5, Float:Y5, Float:Z5, Float:R5);
forward KillFire();
forward ActivateFire();
forward ReloadFun(playerid);

public OnFilterScriptInit()
{
	print("\n--------------------------------------------------");
	print(" Random fire around Red Couty - Coded by: Outcast");
	print(" 		Build [BETA] 0.9 - 1st May, 2011        ");
	print("--------------------------------------------------\n");
	FireInProgress = false;
	FireStatus = 0;
	timer = SetTimer("ActivateFire", 1800000, true);
	return 1;
}

public OnFilterScriptExit()
{
	FireInProgress = false;
	FireStatus = 0;
	KillTimer(timer);
	return 1;
}

public OnPlayerConnect(playerid)
{
	Reload[playerid] = false;
	return ;
}

public OnPlayerDisconnect(playerid)
{
	Reload[playerid] = false;
	return ;
}

public OnPlayerUpdate(playerid)
{
	if(FireInProgress == true)
	{
		new Float:X1, Float:Y1, Float:Z1, Float:X2, Float:Y2, Float:Z2, Float:X3, Float:Y3, Float:Z3, Float:X4, Float:Y4, Float:Z4, Float:X5, Float:Y5, Float:Z5;
 		GetObjectPos(o1, X1, Y1, Z1);
		GetObjectPos(o2, X2, Y2, Z2);
		GetObjectPos(o3, X3, Y3, Z3);
		GetObjectPos(o4, X4, Y4, Z4);
		GetObjectPos(o5, X5, Y5, Z5);
		
  		if(IsPlayerInRangeOfPoint(playerid, 7.0, X1, Y1, Z1) == 1 || IsPlayerInRangeOfPoint(playerid, 7.0, X2, Y2, Z2) == 1 || IsPlayerInRangeOfPoint(playerid, 7.0, X3, Y3, Z3) == 1 || IsPlayerInRangeOfPoint(playerid, 7.0, X4, Y4, Z4) == 1 || IsPlayerInRangeOfPoint(playerid, 7.0, X5, Y5, Z5) == 1)
    	{
     		new Float:health;
       		if(GetPlayerSkin(playerid) != 277 || GetPlayerSkin(playerid) != 278 || GetPlayerSkin(playerid) != 279)
         	{
         		GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health - 0.0001);
				return 1;
			}
		}

	}
	return 1;

}

public ActivateFire()
{
	new selectfire[3] = { 0, 1 };
	if(FireInProgress == true)
	{
	    KillFire();
	    return 1;
	}
	if(selectfire[random(sizeof(selectfire))] == 0) return 1;
	else if(selectfire[random(sizeof(selectfire))] == 1)
	{
		new selectfirecase[21] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 };
		if(selectfirecase[random(sizeof(selectfirecase))] == 0) return CreateFire(2305.8672,-12.8470,32.5313,173.1649, 2311.2644,-7.9838,32.5313,348.7090, 2315.2664,1.2615,26.7422,338.6833, 2303.7551,-16.6112,26.4844,321.5001, 2308.1768,-18.6557,26.4844,315.0435);
        if(selectfirecase[random(sizeof(selectfirecase))] == 1) return CreateFire(2303.6191,13.9957,26.4844,104.5141, 2312.1672,7.4123,26.4844,191.8325, 2309.5088,13.1499,29.9834,60.8651, 2317.6348,19.0230,27.4834,52.2013, 2317.7917,13.2727,26.4844,149.7716);
        if(selectfirecase[random(sizeof(selectfirecase))] == 2) return CreateFire(2303.6235,55.5856,26.4844,290.2547, 2315.5981,61.0427,26.4818,158.0293, 2315.2756,50.8728,26.4816,145.0337, 2311.4617,62.3472,30.4834,68.7102, 2307.5498,56.8012,31.4834,112.6478);
        if(selectfirecase[random(sizeof(selectfirecase))] == 3) return CreateFire(2333.8665,72.5293,26.6210,112.5246, 2326.5156,64.3879,26.4922,351.6028, 2324.6738,59.3322,26.9301,193.5926, 2331.8062,65.0270,32.0074,183.4847, 2327.9871,78.6072,30.6418,91.9167);
        if(selectfirecase[random(sizeof(selectfirecase))] == 4) return CreateFire(2334.2742,63.0227,26.4844,174.3308, 2330.4460,63.5395,32.0074,256.7312, 2325.4417,64.3952,26.7076,84.3434, 2332.8826,57.7974,33.9884,270.0000, 2334.4741,56.7100,26.4841,111.5521);
        if(selectfirecase[random(sizeof(selectfirecase))] == 5) return CreateFire(2331.3503,1.7968,26.5156,195.3794, 2333.4312,-2.5570,26.5496,349.9869, 2333.2959,7.8001,26.4933,279.5416, 2329.6760,5.2253,31.1564,67.2798, 2329.2844,-2.2991,31.4688,24.3939);
        if(selectfirecase[random(sizeof(selectfirecase))] == 6) return CreateFire(2319.5981,-88.6590,26.4844,351.6839, 2329.0974,-88.8026,26.4844,357.0471, 2309.5088,-88.7701,26.4844,73.9894, 2309.8723,-77.6576,26.4844,217.6020, 2309.1914,-85.7336,31.4834,133.6461);
        if(selectfirecase[random(sizeof(selectfirecase))] == 7) return CreateFire(2269.6729,-74.1601,26.7724,352.7500, 2247.6731,-65.2927,26.7834,5.5394, 2273.7444,-68.9904,26.5877,215.5739, 2269.8896,-69.9353,31.6016,350.1102, 2257.6848,-71.3736,31.6016,86.4428);
        if(selectfirecase[random(sizeof(selectfirecase))] == 8) return CreateFire(2279.0769,-50.7967,27.0491,94.5296, 2256.7402,-46.2407,31.2349,126.0904, 2256.7122,-50.8579,33.0643,61.9374, 2249.8359,-40.5784,26.4888,336.5794, 2273.3730,-59.4744,26.5081,294.2921);
        if(selectfirecase[random(sizeof(selectfirecase))] == 9) return CreateFire(2277.7046,51.1585,26.4844,11.0673, 2282.6982,51.3422,26.4844,24.8880, 2269.5417,53.8479,29.9834,228.0735, 2281.5286,61.0434,26.4844,120.6018, 2271.2512,64.3423,26.4844,343.0132);
        if(selectfirecase[random(sizeof(selectfirecase))] == 10) return CreateFire(2243.0515,52.7220,26.6671,20.3751, 2250.0491,52.7044,26.6671,273.1096, 2246.5872,53.3376,26.6671,345.5138, 2233.5754,54.3922,26.4844,327.1549, 2234.5391,51.3408,26.4844,335.6124);
        if(selectfirecase[random(sizeof(selectfirecase))] == 11) return CreateFire(2159.5886,-92.6547,2.8970,210.7870, 2159.6858,-102.1245,2.7500,39.5473, 2162.2551,-104.7475,2.7500,127.5667, 2164.7563,-102.1117,2.7818,161.6650, 2163.2925,-99.6979,2.7879,71.6649);
        if(selectfirecase[random(sizeof(selectfirecase))] == 12) return CreateFire(1927.8009,167.7428,40.1172,158.7802, 1926.3099,163.9029,40.1172,158.7802, 1934.3849,157.5145,45.4420,293.8453, 1939.1359,162.7939,45.0172,323.3915, 1918.5959,165.7364,44.2596,78.7019);
        if(selectfirecase[random(sizeof(selectfirecase))] == 13) return CreateFire(1371.5958,261.5177,19.5669,267.1393, 1368.0972,250.3842,19.5669,248.3678, 1365.0632,243.6012,19.5669,192.2598, 1360.8563,234.0650,19.5669,278.0721, 1372.3347,228.4660,19.5669,284.0543);
        if(selectfirecase[random(sizeof(selectfirecase))] == 14) return CreateFire(1327.3011,373.7613,19.5625,324.8867, 1332.0199,371.7545,19.5547,234.8866, 1334.3848,374.3924,19.5625,24.7078, 1335.5630,376.9636,19.5625,24.7078, 1330.3170,372.6546,19.5547,23.6764);
        if(selectfirecase[random(sizeof(selectfirecase))] == 15) return CreateFire(1294.5996,235.3567,19.5547,193.3266, 1302.0605,232.9995,19.5547,196.3183, 1299.2863,222.4200,19.5547,317.6526, 1291.3942,229.6080,19.5547,306.3072, 1294.4485,232.8622,23.7565,245.7352);
        if(selectfirecase[random(sizeof(selectfirecase))] == 16) return CreateFire(1289.5024,272.9789,19.5547,95.3034, 1285.5286,263.7269,19.5547,125.8450, 1277.3622,264.9852,19.5547,25.3949, 1273.9438,280.9924,19.5547,173.5456, 1264.1870,285.3069,19.5547,157.2496);
        if(selectfirecase[random(sizeof(selectfirecase))] == 17) return CreateFire(701.9962,-518.6238,16.3256,342.8880, 710.1671,-520.4788,16.3359,323.4718, 694.5263,-520.9291,16.3359,64.9615, 693.2647,-517.9764,19.8363,262.4130, 710.4537,-518.0443,19.8363,271.6956);
        if(selectfirecase[random(sizeof(selectfirecase))] == 18) return CreateFire(675.1579,-472.1711,16.5363,313.1751, 682.5494,-473.3684,16.5363,323.4891, 687.3076,-472.1709,16.5363,10.3146, 689.4939,-464.8133,16.5363,54.0459, 689.2467,-470.7032,16.5363,148.1095);
        if(selectfirecase[random(sizeof(selectfirecase))] == 19) return CreateFire(654.9684,-559.7468,16.5015,236.8698, 654.8904,-570.1920,16.5015,208.0363, 661.3583,-573.5266,16.3359,276.3149, 661.3620,-570.8621,16.3359,276.3149, 661.3588,-568.1699,16.3359,276.3149);
        if(selectfirecase[random(sizeof(selectfirecase))] == 20) return CreateFire(850.0212,-598.5781,18.4219,49.5991, 859.7880,-597.9085,18.4219,229.5991, 864.7535,-597.1085,18.3860,245.5447, 868.1580,-597.1082,18.3860,220.5228, 867.7120,-590.1864,17.9536,14.6138);
	}
	return 1;
}

public CreateFire(Float:X1, Float:Y1, Float:Z1, Float:R1, Float:X2, Float:Y2, Float:Z2, Float:R2, Float:X3, Float:Y3, Float:Z3, Float:R3, Float:X4, Float:Y4, Float:Z4, Float:R4, Float:X5, Float:Y5, Float:Z5, Float:R5)
{
	o1 = CreateObject(18691, X1, Y1, Z1 - 1, 0, 0, R1, 1000.00);
	o2 = CreateObject(18691, X2, Y2, Z2 - 1, 0, 0, R2, 1000.00);
	o3 = CreateObject(18691, X3, Y3, Z3 - 1, 0, 0, R3, 1000.00);
	o4 = CreateObject(18691, X4, Y4, Z4 - 1, 0, 0, R4, 1000.00);
	o5 = CreateObject(18691, X5, Y5, Z5 - 1, 0, 0, R5, 1000.00);

	
	FireInProgress = true;
	FireStatus = 100;
	return 1;
}

public KillFire()
{
	DestroyObject(o1), DestroyObject(o2), DestroyObject(o3), DestroyObject(o4), DestroyObject(o5);
	o1 = -50;
	o2 = -50;
	o3 = -50;
	o4 = -50;
	o5 = -50;
	FireInProgress = false;
	FireStatus = 0;
}

public ReloadFun(playerid)
{
	Reload[playerid] = false;
	return 1;
}

CMD:putoutfire(playerid)
{
	new Float:X1, Float:Y1, Float:Z1, Float:X2, Float:Y2, Float:Z2, Float:X3, Float:Y3, Float:Z3, Float:X4, Float:Y4, Float:Z4, Float:X5, Float:Y5, Float:Z5;
	
	GetObjectPos(o1, X1, Y1, Z1);
	GetObjectPos(o2, X2, Y2, Z2);
	GetObjectPos(o3, X3, Y3, Z3);
	GetObjectPos(o4, X4, Y4, Z4);
	GetObjectPos(o5, X5, Y5, Z5);
	
	if(FireInProgress == false) return SendClientMessage(playerid, 0xFFFFFF, "ERROR: There are no fires in progress");

	if(IsPlayerInRangeOfPoint(playerid, 20.0, X1, Y1, Z1) == 0 || IsPlayerInRangeOfPoint(playerid, 20.0, X2, Y2, Z2) == 0 || IsPlayerInRangeOfPoint(playerid, 20.0, X3, Y3, Z3) == 0 || IsPlayerInRangeOfPoint(playerid, 20.0, X4, Y4, Z4) == 0 || IsPlayerInRangeOfPoint(playerid, 20.0, X5, Y5, Z5) == 0) return SendClientMessage(playerid, 0xFFFFFF, "ERROR: You are not near the fire");

	if(Reload[playerid] != false) return SendClientMessage(playerid, 0xFFFFFF, "ERROR: You need to wait before putting the fire again");
	if(GetPlayerSkin(playerid) == 277 || GetPlayerSkin(playerid) == 278 || GetPlayerSkin(playerid) == 279)
	{
		if(FireStatus < 0)
		{
	    	KillFire();
	    	return 1;
		}
		if(FireStatus < 80)
		{
	    	DestroyObject(o1);
	    	return 1;
		}
		if(FireStatus < 60)
		{
	    	DestroyObject(o1);
	    	return 1;
		}
		if(FireStatus < 40)
		{
	    	DestroyObject(o1);
	    	return 1;
		}
		if(FireStatus < 20)
		{
	    	DestroyObject(o1);
	    	return 1;
		}
		
 		if(IsPlayerInAnyVehicle(playerid) == 1)
		{
			if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 407)
			{
				FireStatus = FireStatus - 15;
		    	SetTimerEx("ReloadFun", 30000, false, "i", playerid);
		    	Reload[playerid] = true;
		    	SendClientMessage(playerid, 0xFFFFFF, "You managed to put out some of the fire ((reload 30 seconds))");
			}
		}
		else if(GetPlayerWeapon(playerid) == 42)
		{
	    	FireStatus = FireStatus - 5;
	    	SetTimerEx("ReloadFun", 15000, false, "i", playerid);
	    	Reload[playerid] = true;
	    	SendClientMessage(playerid, 0xFFFFFF, "You managed to put out some of the fire ((reload 15 seconds))");
		}
		else return SendClientMessage(playerid, 0xFFFFFF, "ERROR: You must be in a Firetruck or using a fire extingusher");
	}
    else return SendClientMessage(playerid, 0xFFFFFF, "You are not in a fireman suit");
	return 1;

}
