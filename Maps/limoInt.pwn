#include <a_samp>

new Inlimo[MAX_PLAYERS];
new Watching[MAX_PLAYERS];
new Float:Pos[MAX_PLAYERS][3];
new Float:Angle[MAX_PLAYERS];
new Interior[MAX_PLAYERS];
new Goto[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("  limo Interior Loaded!");
    CreateObject(2395, 2145.890137, -1517.171265, 419.587189, 272.3375, 0.0000, 0.0000);
    CreateObject(2395, 2149.413086, -1517.156372, 419.571808, 272.3375, 0.0000, 0.0000);
    CreateObject(2395, 2153.059082, -1517.159058, 419.590912, 272.3375, 0.0000, 0.0000);
    CreateObject(2395, 2145.888672, -1514.539307, 419.225555, 0.0000, 0.0000, 0.0000);
    CreateObject(2395, 2149.549805, -1514.546631, 419.236420, 0.0000, 0.0000, 0.0000);
    CreateObject(2395, 2153.248535, -1514.553955, 419.244934, 0.0000, 0.0000, 0.0000);
    CreateObject(2395, 2145.715332, -1517.124146, 419.215027, 0.0000, 0.0000, 90.0000);
    CreateObject(1754, 2145.940918, -1514.847900, 419.632782, 0.0000, 0.0000, 90.0000);
    CreateObject(1754, 2145.936523, -1515.645386, 419.625244, 0.0000, 0.0000, 90.0000);
    CreateObject(1754, 2145.959473, -1516.579468, 419.638123, 0.0000, 0.0000, 90.0000);
    CreateObject(1569, 2145.892578, -1514.445068, 419.000397, 0.0000, 0.0000, 0.0000);
    CreateObject(1754, 2145.965332, -1514.795776, 419.635406, 0.0000, 0.0000, 0.0000);
    CreateObject(1754, 2145.962402, -1516.606689, 419.632782, 0.0000, 0.0000, 180.0000);
    CreateObject(1416, 2148.802734, -1516.633179, 419.756653, 0.0000, 0.0000, 180.0000);
    CreateObject(1416, 2150.091797, -1516.629883, 419.753265, 0.0000, 0.0000, 180.0000);
    CreateObject(1416, 2151.499512, -1516.641602, 419.749878, 0.0000, 0.0000, 180.0000);
    CreateObject(1416, 2152.864746, -1516.651001, 419.746490, 0.0000, 0.0000, 180.0000);
    CreateObject(1416, 2154.228027, -1516.659058, 419.743103, 0.0000, 0.0000, 180.0000);
    CreateObject(1416, 2155.649414, -1516.653320, 419.731781, 0.0000, 0.0000, 180.0000);
    CreateObject(1754, 2148.604492, -1514.787598, 419.825623, 0.0000, 0.0000, 0.0000);
    CreateObject(1754, 2148.558594, -1514.785522, 419.839111, 0.0000, 0.0000, 90.0000);
    CreateObject(1754, 2149.501465, -1514.779175, 419.838776, 0.0000, 0.0000, 0.0000);
    CreateObject(1754, 2150.378906, -1514.782227, 419.826508, 0.0000, 0.0000, 0.0000);
    CreateObject(1754, 2151.237305, -1514.785278, 419.824463, 0.0000, 0.0000, 0.0000);
    CreateObject(1754, 2152.103027, -1514.783447, 419.812958, 0.0000, 0.0000, 0.0000);
    CreateObject(1754, 2152.990723, -1514.785156, 419.826447, 0.0000, 0.0000, 0.0000);
    CreateObject(1754, 2153.910156, -1514.782349, 419.814941, 0.0000, 0.0000, 0.0000);
    CreateObject(1754, 2154.816406, -1514.781738, 419.803436, 0.0000, 0.0000, 0.0000);
    CreateObject(1416, 2155.953125, -1515.729614, 419.728394, 0.0000, 0.0000, 269.9999);
    CreateObject(1416, 2155.939453, -1514.421997, 419.738190, 0.0000, 0.0000, 269.9999);
    CreateObject(1754, 2155.099121, -1514.787720, 419.791931, 0.0000, 0.0000, 270.0000);
    CreateObject(2190, 2155.866211, -1516.119263, 420.303680, 0.0000, 0.0000, 225.0000);
    CreateObject(2232, 2155.986328, -1514.911133, 420.915802, 0.0000, 0.0000, 270.0000);
    CreateObject(2232, 2155.964844, -1516.622314, 420.909393, 0.0000, 0.0000, 270.0000);
    CreateObject(2232, 2155.995605, -1515.727661, 421.227722, 0.0000, 90.2408, 270.8595);
    CreateObject(2842, 2154.029785, -1516.296631, 419.640350, 0.0000, 0.0000, 0.0000);
    CreateObject(2842, 2152.360840, -1516.288574, 419.630890, 0.0000, 0.0000, 0.0000);
    CreateObject(2606, 2149.632813, -1516.671753, 420.558319, 0.0000, 0.0000, 180.0000);
    CreateObject(2606, 2151.593750, -1516.683228, 420.554932, 0.0000, 0.0000, 180.0000);
    CreateObject(2606, 2153.555176, -1516.687866, 420.551544, 0.0000, 0.0000, 180.0000);
    CreateObject(1520, 2148.518066, -1516.435791, 420.395538, 0.0000, 0.0000, 0.0000);
    CreateObject(1520, 2148.514648, -1516.545776, 420.395538, 0.0000, 0.0000, 0.0000);
    CreateObject(1520, 2148.518066, -1516.661133, 420.395538, 0.0000, 0.0000, 0.0000);
    CreateObject(1543, 2148.342773, -1516.489014, 420.331879, 0.0000, 0.0000, 0.0000);
    CreateObject(1543, 2148.247070, -1516.674316, 420.331879, 0.0000, 0.0000, 0.0000);
    CreateObject(1544, 2148.166992, -1516.859619, 420.332214, 0.0000, 0.0000, 0.0000);
    CreateObject(1546, 2148.151367, -1516.447754, 420.425537, 0.0000, 0.0000, 0.0000);
    CreateObject(1664, 2148.477051, -1516.916260, 420.503113, 0.0000, 0.0000, 0.0000);
    CreateObject(1665, 2146.195313, -1516.928345, 420.576599, 0.0000, 0.0000, 337.5000);
    CreateObject(1666, 2146.345215, -1514.550415, 420.624542, 0.0000, 0.0000, 0.0000);
    CreateObject(1667, 2148.879395, -1516.321533, 420.424988, 0.0000, 0.0000, 0.0000);
    CreateObject(1667, 2148.983887, -1516.314575, 420.424988, 0.0000, 0.0000, 0.0000);
    CreateObject(1667, 2151.096191, -1516.366943, 420.418213, 0.0000, 0.0000, 0.0000);
    CreateObject(1667, 2150.071777, -1516.354370, 420.421600, 0.0000, 0.0000, 0.0000);
    CreateObject(1667, 2151.992188, -1516.383789, 420.418213, 0.0000, 0.0000, 0.0000);
    CreateObject(1667, 2151.605957, -1516.347046, 420.418213, 0.0000, 0.0000, 0.0000);
    CreateObject(1667, 2153.077637, -1516.389404, 420.414825, 0.0000, 0.0000, 0.0000);
    CreateObject(1667, 2148.314941, -1516.399780, 420.424988, 0.0000, 0.0000, 0.0000);
    CreateObject(1668, 2154.656738, -1516.517578, 420.489563, 0.0000, 0.0000, 0.0000);
    CreateObject(1669, 2154.833008, -1516.509644, 420.489563, 0.0000, 0.0000, 0.0000);
    CreateObject(1950, 2155.040039, -1516.524536, 420.499695, 0.0000, 0.0000, 0.0000);
    CreateObject(1951, 2155.169922, -1516.697876, 420.499695, 0.0000, 0.0000, 0.0000);
    CreateObject(1455, 2155.357910, -1516.498901, 420.383209, 0.0000, 0.0000, 0.0000);
    CreateObject(1455, 2155.692871, -1515.459717, 420.379822, 0.0000, 0.0000, 0.0000);
    CreateObject(1455, 2154.761719, -1516.770508, 420.394531, 0.0000, 0.0000, 0.0000);
    CreateObject(1487, 2153.038086, -1516.498535, 420.982635, 0.0000, 0.0000, 0.0000);
    CreateObject(2395, 2148.833984, -1516.916382, 419.187775, 0.0000, 0.0000, 180.0000);
    CreateObject(2395, 2152.527832, -1516.911987, 419.184692, 0.0000, 0.0000, 180.0000);
    CreateObject(2395, 2156.197754, -1516.907593, 419.184113, 0.0000, 0.0000, 180.0000);
    CreateObject(2395, 2156.461914, -1514.625977, 419.194885, 0.0000, 0.0000, 270.0000);
    CreateObject(2395, 2154.986328, -1514.378784, 421.887939, 90.2408, 0.0000, 357.4217);
    CreateObject(2395, 2151.400391, -1514.215332, 421.877197, 90.2408, 0.0000, 357.4217);
    CreateObject(2395, 2148.178711, -1514.288330, 421.878632, 90.2408, 0.0000, 357.4217);
    CreateObject(2395, 2145.612793, -1514.400391, 421.892365, 90.2408, 0.0000, 357.4217);
    CreateObject(1569, 2145.892090, -1517.006226, 419.032440, 0.0000, 0.0000, 0.0000);
}

public OnFilterScriptExit()
{
	print("  limo Interior Unloaded...");
	DestroyObject(1);
	DestroyObject(2);
	DestroyObject(3);
	DestroyObject(4);
	DestroyObject(5);
	DestroyObject(6);
	DestroyObject(7);
	DestroyObject(8);
	DestroyObject(9);
	DestroyObject(10);
	DestroyObject(11);
	DestroyObject(12);
	DestroyObject(13);
	DestroyObject(14);
	DestroyObject(15);
	DestroyObject(16);
	DestroyObject(17);
	DestroyObject(18);
	DestroyObject(19);
	DestroyObject(20);
	DestroyObject(21);
	DestroyObject(22);
	DestroyObject(23);
	DestroyObject(24);
	DestroyObject(25);
	DestroyObject(26);
	DestroyObject(27);
	DestroyObject(28);
	DestroyObject(29);
	DestroyObject(30);
	DestroyObject(31);
	DestroyObject(32);
	DestroyObject(33);
	DestroyObject(34);
	DestroyObject(35);
	DestroyObject(36);
	DestroyObject(37);
	DestroyObject(38);
	DestroyObject(39);
	DestroyObject(40);
	DestroyObject(41);
	DestroyObject(42);
	DestroyObject(43);
	DestroyObject(44);
	DestroyObject(45);
	DestroyObject(46);
	DestroyObject(47);
	DestroyObject(48);
	DestroyObject(49);
	DestroyObject(50);
	DestroyObject(51);
	DestroyObject(52);
	DestroyObject(53);
	DestroyObject(54);
	DestroyObject(55);
	DestroyObject(56);
	DestroyObject(57);
	DestroyObject(58);
	DestroyObject(59);
	DestroyObject(60);
	DestroyObject(61);
	DestroyObject(62);
	DestroyObject(63);
	DestroyObject(64);
	DestroyObject(65);
	DestroyObject(66);
	DestroyObject(67);
	DestroyObject(68);
	DestroyObject(69);
	DestroyObject(70);
	DestroyObject(71);
	DestroyObject(72);
	DestroyObject(73);
	DestroyObject(74);
												
}

public OnPlayerConnect(playerid)
{
	Inlimo[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	Inlimo[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	Inlimo[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_PASSENGER && GetVehicleModel(GetPlayerVehicleID(playerid)) == 409)
	{
     	SetPlayerPos(playerid, 2147.000977, -1515.681519, 420.972992);
     	SetPlayerFacingAngle(playerid, 0);
        SetCameraBehindPlayer(playerid);
        SetPlayerInterior(playerid, 1);
		Inlimo[playerid] = GetPlayerVehicleID(playerid);
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == 16 && Inlimo[playerid])
	{
		new Float:X, Float:Y, Float:Z;
		GetVehiclePos(Inlimo[playerid], X, Y, Z);
		SetPlayerPos(playerid, X+4, Y, Z);
		SetPlayerInterior(playerid, 0);
		Inlimo[playerid] = 0;
	}
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
    for(new i = 0; i <= MAX_PLAYERS; i++)
    {
        if(vehicleid == Inlimo[i])
        {
			SetPlayerHealth(i, 0);
			Inlimo[i] = 0;
			Watching[i] = 0;
			Goto[i] = 0;
        }
    }
    return 1;
}

#pragma unused Angle
#pragma unused Pos
#pragma unused Interior


