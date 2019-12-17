#include <a_samp>
#include <dini>
#include <dudb>
#include <dutils>
#define MAX_GTASAVEHICLES   212
new gPlayerClass[MAX_PLAYERS];
new gTeam[MAX_PLAYERS];
new PLAYERLIST_authed[MAX_PLAYERS];
new IsSpawned[MAX_PLAYERS];
new shotgun[MAX_PLAYERS];
new mitra[MAX_PLAYERS];
new pistole[MAX_PLAYERS];
new bank[MAX_PLAYERS];
new taxi[MAX_VEHICLES]; //conserva l'id del driver
new taxiplayer[MAX_PLAYERS]; //conserve l'id del veicolo taxi
new Filling[MAX_PLAYERS];
new checkpoint[MAX_PLAYERS];
new wantedlevel[MAX_PLAYERS];
new missionvehicle[MAX_PLAYERS];
new wantedforhim[MAX_PLAYERS] = 255;
new max_cars_selected = 79;
new playerspawned;
new gMissioni[] =
{
1,
2,
3,
4,
};
enum SavePlayerPosEnum
{
    Float:LastX,
    Float:LastY,
    Float:LastZ
}
new SavePlayerPos[MAX_PLAYERS][SavePlayerPosEnum];

#define GasMax 100
#define RunOutTime 20000
#define RefuelWait 5000

#define a 255 //Change to Your Vehicle Amount
new Gas[MAX_VEHICLES];
#define gGameTime1 = 60000
#define dcmd(%1,%2,%3) if ((strcmp(%3, "/%1", true, %2+1) == 0)&&(((%3[%2+1]==0)&&(dcmd_%1(playerid,"")))||((%3[%2+1]==32)&&(dcmd_%1(playerid,%3[%2+2]))))) return 1
#define COLOR_SYSTEM 0xEFEFF7AA
#define COLOR_RED 0xAA3333AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_YELLOW 0xFFFF00AA
#define TEAM_GANGSTER 0
#define TEAM_CIV 1
#define TEAM_POL 2
#define MAX_POINTS 17
//--------------
#define FUEL 1
#define ESCAPE 2
#define AUTOLOCO 3
#define BANK 4
#define MISSION1 5


main()
{
	print("\n----------------------------------");
	print("  RPG MODE by TOMMYLR               ");
	print("----------------------------------\n");
}

 
public OnPlayerDisconnect(playerid) {
  if (PLAYERLIST_authed[playerid]) {
  //---

    dUserSetINT(PlayerName(playerid)).("money",GetPlayerMoney(playerid));
    dUserSetINT(PlayerName(playerid)).("shotgun",shotgun[playerid]);
    dUserSetINT(PlayerName(playerid)).("mitra",mitra[playerid]);
    dUserSetINT(PlayerName(playerid)).("pistole",pistole[playerid]);
    dUserSetINT(PlayerName(playerid)).("bank",bank[playerid]);
  }
  PLAYERLIST_authed[playerid]=false;
  return false;
}

public PlayerName(playerid) {
  new name[MAX_PLAYER_NAME];
  GetPlayerName(playerid, name, MAX_PLAYER_NAME);
  return name;
}


public OnGameModeInit(i)
{

	for(i=0;i<MAX_VEHICLES;i++) {
	taxi[i] = 255;
	Gas[i] = GasMax;
	}
SetTimer("FuelDown", RunOutTime, 1);
SetTimer("CheckGas", 900, 1);
SetGameModeText("RPG MODE");
AddPlayerClass(105,2495.2942,-1686.7410,13.5146,345.1787,0,0,0,0,0,0); // GROVE
AddPlayerClass(106,2495.2942,-1686.7410,13.5146,345.1787,0,0,0,0,0,0); // GROVE
AddPlayerClass(107,2495.2942,-1686.7410,13.5146,345.1787,0,0,0,0,0,0); // GROVE
AddPlayerClass(102,2040.8317,-1636.4535,13.5469,282.3436,0,0,0,0,0,0); // BALLAS
AddPlayerClass(103,2045.2512,-1670.7961,13.3828,254.1668,0,0,0,0,0,0); // BALLAS
AddPlayerClass(104,2034.1675,-1665.8888,13.5469,265.4936,0,0,0,0,0,0); // BALLAS
AddPlayerClass(174,1787.3534,-1925.0656,13.3901,307.9801,0,0,0,0,0,0); // OG
AddPlayerClass(115,1801.7134,-1912.9382,13.3960,340.8804,0,0,0,0,0,0); // OG
AddPlayerClass(116,1792.5392,-1911.3932,13.3968,287.8483,0,0,0,0,0,0); // OG
AddPlayerClass(108,2059.0715,-1007.3425,47.9766,1.1025,0,0,0,0,0,0); // VAGOS
AddPlayerClass(109,2127.3621,-971.9185,58.6448,169.0507,0,0,0,0,0,0); // VAGOS
AddPlayerClass(110,2186.0625,-998.1495,66.4688,78.2629,0,0,0,0,0,0); // VAGOS
AddPlayerClass(217,1868.5045,-1384.3711,13.5127,79.3041,0,0,0,0,0,0); // BMX
AddPlayerClass(250,1868.6322,-1383.8907,13.5134,79.3041,0,0,0,0,0,0); // BMX
AddPlayerClass(293,1868.6322,-1383.8907,13.5134,79.3041,0,0,0,0,0,0); //BMX
AddPlayerClass(98,1497.1262,-690.2004,94.7500,190.8699,0,0,0,0,0,0); // Rich
AddPlayerClass(147,1497.1384,-688.9389,95.1966,184.3909,0,0,0,0,0,0); // Rich
AddPlayerClass(156,2014.4757,-1732.6592,14.2392,91.7454,0,0,0,0,0,0); // Old
AddPlayerClass(61,1788.0491,-2643.1636,13.5469,356.0182,0,0,0,0,0,0); // Pilot
AddPlayerClass(287,2734.2253,-2450.5940,17.5937,336.5316,0,0,0,0,0,0); //Military
AddPlayerClass(280,1576.8402,-1631.2933,13.3828,59.6309,0,0,0,0,0,0); // Police
AddPlayerClass(280,1569.3383,-1619.6395,13.5469,148.4500,0,0,0,0,0,0); // Police
AddPlayerClass(280,1556.2813,-1620.5048,13.5469,62.5959,0,0,0,0,0,0); // Police
AddStaticVehicle(415,1516.8281,-695.1577,94.5216,91.3814,40,1); // 1
AddStaticVehicle(415,1077.5444,-1769.5822,13.1297,91.0972,40,1); // 1
AddStaticVehicle(415,1516.5952,-689.9932,94.5206,104.3300,75,1); //  1
AddStaticVehicle(545,2013.8855,-1737.5476,13.3636,90.6475,47,1); // 2
AddStaticVehicle(545,2296.9910,-1911.0227,13.3964,359.1314,47,1); // 2
AddStaticVehicle(555,2017.4421,-1707.8888,13.2305,90.4968,58,1); // 3
AddStaticVehicle(555,1025.6150,-1347.4120,13.4110,187.3968,58,1); // 3
AddStaticVehicle(555,1192.2280,-930.7302,42.6619,99.2581,58,1); // 3
AddStaticVehicle(411,1908.4694,-1617.0334,13.1889,268.0933,75,1); // 4
AddStaticVehicle(411,1524.1042,-2031.9858,29.7607,176.1785,75,1); // 4
AddStaticVehicle(419,1684.6279,-1798.0016,13.2582,177.8067,13,76); // 5
AddStaticVehicle(419,2427.8228,-2060.9153,13.3434,86.9529,69,76); // 5
AddStaticVehicle(419,2103.3279,-1782.5146,13.1877,88.4673,69,76); // 5
AddStaticVehicle(419,2785.0015,-2001.5225,13.3444,269.6910,69,76); // 5
AddStaticVehicle(422,2118.9958,-1937.2438,13.3735,270.5156,111,31); // 6
AddStaticVehicle(422,2500.4392,-1953.7130,13.4082,180.9028,83,57); // 6
AddStaticVehicle(426,2708.7305,-1592.9318,13.4399,268.5297,62,62); // 7
AddStaticVehicle(426,2800.3459,-1466.3076,15.9714,89.3311,10,10); // 7
AddStaticVehicle(426,2414.8850,-1481.7814,23.5711,272.8170,15,15); // 7
AddStaticVehicle(426,2194.4792,-1105.8967,24.7891,150.3861,62,62); // 7
AddStaticVehicle(439,2503.8201,-1023.8798,69.9815,176.7344,54,38); // 8
AddStaticVehicle(439,1993.4954,-1274.6578,23.7160,88.2314,37,78); // 8
AddStaticVehicle(445,2270.8176,-1434.5363,23.7070,174.5089,39,39); // 9
AddStaticVehicle(474,2518.5151,-1145.4005,39.4336,88.4605,110,1); // 10
AddStaticVehicle(474,2598.6135,-1058.4115,68.3370,359.4023,74,1); // 10
AddStaticVehicle(474,2105.7539,-996.8011,53.7867,350.8125,74,1); // 10
AddStaticVehicle(474,2325.2969,-1255.1389,21.2636,182.4543,81,1); // 10
AddStaticVehicle(474,2480.0383,-1748.0162,12.3053,356.4037,74,1); // 10
AddStaticVehicle(474,1290.3909,-1864.9756,12.3085,358.8169,74,1); // 10
AddStaticVehicle(481,1948.5321,-1448.6473,12.9918,274.8890,46,46); // 11
AddStaticVehicle(481,2060.7148,-989.3069,46.6708,174.8062,14,1); // 11
AddStaticVehicle(481,1894.8732,-1358.8103,13.0173,192.6004,46,46); // 11
AddStaticVehicle(481,1865.0472,-1370.3292,13.0091,23.9020,14,1); // 11
AddStaticVehicle(481,1885.0437,-1404.0820,13.0596,288.8610,26,1); // 11
AddStaticVehicle(481,1894.1560,-1385.7649,13.0782,74.7934,14,1); // 11
AddStaticVehicle(481,1748.0647,-1690.1420,12.8927,264.0595,14,1); // 11
AddStaticVehicle(597,1557.8738,-1607.0880,13.1099,183.3189,75,1); // 12
AddStaticVehicle(597,1566.7491,-1606.8892,13.1099,183.5950,75,1); // 12
AddStaticVehicle(523,1573.6183,-1606.5999,13.1099,180.7231,75,1); // 13
AddStaticVehicle(567,1862.0016,-2150.9546,13.2740,270.8565,75,1); // 14
AddStaticVehicle(567,2471.0039,-1670.5972,13.1886,194.3570,93,64); // 14
AddStaticVehicle(567,2490.1648,-1682.3918,13.2049,272.7294,99,81); // 14
AddStaticVehicle(421,1337.2310,-1337.1707,13.2321,176.7410,75,1); // 15
AddStaticVehicle(421,1435.9034,-1446.0341,13.2381,269.9120,75,1); // 15
AddStaticVehicle(421,1663.7740,-1285.7140,14.3610,60.1920,75,1); // 15
AddStaticVehicle(444,223.4262,-1834.7122,3.4382,136.1490,40,1); // 16
AddStaticVehicle(444,1656.2778,-1017.3718,24.2697,10.0604,40,1); // 16
AddStaticVehicle(470,2744.7300,-2393.1223,13.6240,178.1630,43,0); // 17
AddStaticVehicle(470,2741.2458,-2413.3887,13.6268,359.1074,43,0); // 17
AddStaticVehicle(470,2778.7688,-2436.9121,13.6263,85.7537,43,0); // 17
AddStaticVehicle(433,2746.1873,-2443.4722,14.0813,269.9339,43,0); // 18
AddStaticVehicle(482,2505.2759,-1693.9926,13.0,181.5107,71,71); // 19
AddStaticVehicle(536,1790.3696,-1927.0061,13.1268,319.8231,37,1); // 20
AddStaticVehicle(536,1781.5269,-1923.5131,13.1280,360.0000,71,96); // 20
AddStaticVehicle(536,1804.7351,-1906.2670,13.1366,0.1970,12,1); // 20
AddStaticVehicle(536,1804.8450,-1917.4004,13.1313,359.4407,30,96); // 20
AddStaticVehicle(536,1793.7478,-1912.8623,13.1335,287.7688,12,1); // 20
AddStaticVehicle(517,2041.3704,-1626.3527,13.4015,327.9268,51,72); // 21
AddStaticVehicle(517,2043.5887,-1649.5028,13.4017,23.1639,37,36); // 21
AddStaticVehicle(566,2049.6787,-1676.7920,13.2437,270.1977,84,8); // 22
AddStaticVehicle(566,2057.5874,-1676.9272,13.2422,269.8828,72,8); // 22
AddStaticVehicle(566,2035.5452,-1670.9872,13.1678,325.4215,52,8); // 22
AddStaticVehicle(576,2152.3337,-1007.3912,62.3116,253.1516,76,8); // 23
AddStaticVehicle(576,2149.7852,-996.8450,61.8950,75.2828,84,96); // 23
AddStaticVehicle(576,2077.1506,-977.3018,49.3026,201.6328,68,96); // 23
AddStaticVehicle(469,1811.5077,-2618.8997,13.5585,359.1305,1,3); //
AddStaticVehicle(469,1841.7794,-2622.3411,13.5593,16.3964,1,3); //
AddStaticVehicle(487,1845.8049,-2547.9709,15.9677,0.0010,26,3); //
AddStaticVehicle(519,1788.8909,-2538.4536,14.4688,317.6421,1,1); //
AddStaticVehicle(519,1739.8304,-2529.1294,14.4695,319.4979,1,1); //
AddStaticVehicle(553,1998.4952,-2551.7158,14.8786,37.0780,98,114); //
AddStaticVehicle(583,1782.7113,-2661.0447,13.0874,359.9985,1,1); //
AddStaticVehicle(583,1790.7087,-2659.6375,13.0872,345.6030,1,1); //
AddStaticVehicle(427,1545.5994,-1614.1542,13.5146,270.8292,0,1); //
AddStaticVehicle(427,1545.8588,-1607.6014,13.5146,271.0493,0,1); //
AddStaticVehicle(497,1520.7769,-1659.1677,13.7169,182.7776,0,1); //
AddStaticVehicle(523,1558.5808,-1605.0671,12.9507,183.5399,0,0); //
AddStaticVehicle(523,1561.6140,-1604.9899,12.9522,180.3834,0,0); //
AddStaticVehicle(523,1564.8252,-1605.0389,12.9487,182.9432,0,0); //
AddStaticVehicle(596,1565.0233,-1614.5806,13.1047,359.3401,0,1); //
AddStaticVehicle(596,1569.6088,-1614.6841,13.1038,358.8651,0,1); //
AddStaticPickup(1242,2,1627.6586,-2286.1543,94.1270);
AddStaticPickup(1242,2,1627.6586,-2286.1543,94.1270);
AddStaticPickup(1242,2,1627.6586,-2286.1543,94.1270);
AddStaticPickup(1242,2,1627.6586,-2286.1543,94.1270);
AddStaticPickup(1242,2,1627.6586,-2286.1543,94.1270);
AddStaticPickup(1242,2,1627.6586,-2286.1543,94.1270);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	gPlayerClass[playerid] = classid;
	switch (classid) {
		case 0, 1, 2:
		    {GameTextForPlayer(playerid, "~g~Grove Street Families~n~~r~[Evil]", 1000, 3);
	            SetPlayerInterior(playerid,0);
	            SetPlayerFacingAngle(playerid,66.1411);
	            SetPlayerPos(playerid,2442.3628,-1653.0162,28.1999);
	            SetPlayerCameraPos(playerid,2432.3040,-1647.3948,31.1869);
	            SetPlayerCameraLookAt(playerid,2442.3628,-1653.0162,28.1999);
	            gTeam[playerid] = TEAM_GANGSTER;
	            }
	    case 3, 4, 5:
	        {GameTextForPlayer(playerid, "~r~Ballas Gang~n~~r~[Evil]", 1000, 3);
		        SetPlayerInterior(playerid,0);
	            SetPlayerFacingAngle(playerid,336.0849);
	            SetPlayerPos(playerid,1447.0795,-1754.3590,13.5469);
	            SetPlayerCameraPos(playerid,1449.0688,-1752.1442,14.0469);
	            SetPlayerCameraLookAt(playerid,1447.0795,-1754.3590,13.5469);
	            gTeam[playerid] = TEAM_GANGSTER;
				}
        case 6,7,8:
	        {GameTextForPlayer(playerid, "~b~Og Los Santos~n~~r~[Evil]", 1000, 3);
                SetPlayerInterior(playerid,0);
	            SetPlayerFacingAngle(playerid,23.1364);
	            SetPlayerPos(playerid,1787.8250,-1898.4103,13.3950);
	            SetPlayerCameraPos(playerid,1785.5365,-1895.8412,13.3919);
	            SetPlayerCameraLookAt(playerid,1787.8250,-1898.4103,13.3950);
				gTeam[playerid] = TEAM_GANGSTER;}
        case 9,10,11:
	        {GameTextForPlayer(playerid, "~g~Vagos Clan~n~~r~[Evil]", 1000, 3);
 				SetPlayerInterior(playerid,0);
	            SetPlayerFacingAngle(playerid,223.7380);
	            SetPlayerPos(playerid,2107.4009,-988.5048,54.6893);
	            SetPlayerCameraPos(playerid,2110.6919,-992.4883,55.4531);
	            SetPlayerCameraLookAt(playerid,2107.4009,-988.5048,54.6893);
	            gTeam[playerid] = TEAM_GANGSTER;
				}
		case 12,13,14:
	        {GameTextForPlayer(playerid, "~g~Bmx Boyz~n~~w~[Civilian]", 1000, 3);
				SetPlayerInterior(playerid,0);
	            SetPlayerFacingAngle(playerid,39.0287);
	            SetPlayerPos(playerid,1887.5188,-1366.8828,19.1406);
	            SetPlayerCameraPos(playerid,1885.9391,-1364.5735,19.1406);
	            SetPlayerCameraLookAt(playerid,1887.5188,-1366.8828,19.1406);
				gTeam[playerid] = TEAM_CIV;}
        case 15,16:
	        {GameTextForPlayer(playerid, "~g~Rich~n~~w~[Civilian]", 1000, 3);
				SetPlayerInterior(playerid,0);
	            SetPlayerFacingAngle(playerid,182.7026);
	            SetPlayerPos(playerid,1497.0049,-689.3864,94.9996);
	            SetPlayerCameraPos(playerid,1500.4456,-694.4907,94.7500);
	            SetPlayerCameraLookAt(playerid,1497.0049,-689.3864,94.9996);
				gTeam[playerid] = TEAM_CIV;}
        case 17:
	        {GameTextForPlayer(playerid, "~g~Old~n~~w~[Civilian]", 1000, 3);
				SetPlayerPos(playerid, 1000.0198,-1022.3301,42.7101);
				SetPlayerFacingAngle(playerid,179.0234);
				SetPlayerCameraPos(playerid, 999.9587,-1025.9143,42.7101);
				SetPlayerCameraLookAt(playerid, 1000.0198,-1022.3301,42.7101);
				gTeam[playerid] = TEAM_CIV;
				}
	    case 18:
	        {
			    GameTextForPlayer(playerid, "~g~Pilot~n~~w~[Civilian]", 1000, 3);
			    SetPlayerInterior(playerid,0);
	            SetPlayerFacingAngle(playerid,298.8459);
	            SetPlayerPos(playerid,1911.0302,-2574.2783,13.5469);
	            SetPlayerCameraPos(playerid,1922.0354,-2570.4106,15.6021);
	            SetPlayerCameraLookAt(playerid,1911.0302,-2574.2783,13.5469);
	            gTeam[playerid] = TEAM_CIV;
				}
         case 19:
	        {
			    GameTextForPlayer(playerid, "~g~Military~n~~g~[Law]", 1000, 3);
				SetPlayerPos(playerid, 2406.4287,-2266.3171,61.9073);
				SetPlayerFacingAngle(playerid,40.3585);
				SetPlayerCameraPos(playerid, 2399.1299,-2256.8811,66.1072);
				SetPlayerCameraLookAt(playerid, 2406.4287,-2266.3171,61.9073);
	            gTeam[playerid] = TEAM_POL;
				}
         case 20, 21, 22:
	        {
			    GameTextForPlayer(playerid, "~g~Police Dept~n~~g~[Law]", 1000, 3);
			    SetPlayerInterior(playerid,0);
	            SetPlayerFacingAngle(playerid,92.3628);
	            SetPlayerPos(playerid,1544.2264,-1631.9332,13.3828);
	            SetPlayerCameraPos(playerid,1539.9740,-1632.0128,13.3828);
	            SetPlayerCameraLookAt(playerid,1544.2264,-1631.9332,13.3828);
	            gTeam[playerid] = TEAM_POL;
				}
}
	return 1;
}


public OnPlayerConnect(playerid)
{
	GameTextForPlayer(playerid,"Welcome into ~r~ RPG gamemode!",2000,1);
SendClientMessage(playerid, COLOR_RED, "*** Welcome into RPG mode by TommyLR");
SendClientMessage(playerid, COLOR_GREEN, "*** Register or login now.");
SendClientMessage(playerid, COLOR_GREEN, "*** type /help for more infos");
	return 1;
}

  dcmd_register(playerid,params[]) {

    // The command shouldn't work if we already are authed
    if (PLAYERLIST_authed[playerid]) return SystemMsg(playerid,"*** Already authed.");

    // The command shouldn't work if an account with this
    // nick already exists
    if (udb_Exists(PlayerName(playerid))) return SystemMsg(playerid,"*** Account already exists, please use '/login password'.");

    // Did he forgot the password?
    if (strlen(params)==0) return SystemMsg(playerid,"Correct usage: '*** /register password'");

    // We save the money to the accstate
    if (udb_Create(PlayerName(playerid),params)) return SystemMsg(playerid,"*** Account successfully created. Login with '/login password' now.");
    return true;

 }

  dcmd_login(playerid,params[]) {
if(IsSpawned[playerid] == 1){
    // The command shouldn't work if we already are authed
    if (PLAYERLIST_authed[playerid]) return SystemMsg(playerid,"*** Already authed.");

    // The command shouldn't work if an account with this
    // nick does not exists
    if (!udb_Exists(PlayerName(playerid))) return SystemMsg(playerid,"*** Account doesn't exist, please use '/register password'.");

    // Did he forgot the password?
    if (strlen(params)==0) return SystemMsg(playerid,"*** Correct usage: '/login password'");

    if (udb_CheckLogin(PlayerName(playerid),params)) {
       // Login was correct

       // Following thing is the same like the missing SetPlayerCommand
       GivePlayerMoney(playerid,dUserINT(PlayerName(playerid)).("money")-GetPlayerMoney(playerid));
       GivePlayerWeapon(playerid,dUserINT(PlayerName(playerid)).("shotgun"),99999);
       GivePlayerWeapon(playerid,dUserINT(PlayerName(playerid)).("pistole"),99999);
       GivePlayerWeapon(playerid,dUserINT(PlayerName(playerid)).("mitra"),99999);
	   shotgun[playerid] = dUserINT(PlayerName(playerid)).("shotgun");
	   pistole[playerid] = dUserINT(PlayerName(playerid)).("pistole");
	   mitra[playerid] = dUserINT(PlayerName(playerid)).("mitra");
	   bank[playerid] = dUserINT(PlayerName(playerid)).("bank");
       PLAYERLIST_authed[playerid]=true;
       return SystemMsg(playerid,"*** Successfully authed!");
    } else {
       // Login was incorrect
       return SystemMsg(playerid,"*** Login failed!");
    }
}else{SystemMsg(playerid,"*** Spawn before logging!"); }
    return true;
 }
 

 
public OnPlayerCommandText(playerid, cmdtext[], i)
{
new cmd[256];
new idx;
new victim;
new say[256];
cmd = strtok(cmdtext, idx);
   dcmd(login,5,cmdtext); // because login has 5 characters
   dcmd(register,8,cmdtext); // because register has 8 characters

if (PLAYERLIST_authed[playerid]) {

 if(strcmp(cmd, "/lookarsenal", true) == 0) {
   new mitrastring[256], shotgunstring[256], pistolestring[256], string[256], name[256];
   
	    new tmp[256];
		tmp = strtok(cmdtext, idx);
        victim = strval(tmp);
		GetPlayerName(victim, name, 256);
            format(shotgunstring, 256, "%s's weapons:", name);
            SendClientMessage(playerid, COLOR_RED, string);
 	switch (pistole[victim]) {
	    case 0:
	        {
            format(pistolestring, 256, "Pistol: Desert.");
            SendClientMessage(playerid, COLOR_RED, pistolestring);
	        }
	    case 22:
	        {
            format(pistolestring, 256, "Pistol: Double Pistols.");
            SendClientMessage(playerid, COLOR_RED, pistolestring);
	        }
}
	switch (shotgun[victim]) {
	    case 0:
	        {
            format(shotgunstring, 256, "Shotgun: None.");
            SendClientMessage(playerid, COLOR_RED, shotgunstring);
	        }
	    case 25:
	        {
            format(shotgunstring, 256, "Shotgun: Shotgun.");
            SendClientMessage(playerid, COLOR_RED, shotgunstring);
	        }
	    case 27:
	        {
            format(shotgunstring, 256, "Shotgun: Spaz 12.");
            SendClientMessage(playerid, COLOR_RED, shotgunstring);
	        }
}
	switch (mitra[victim]) {
        case 0:
	        {
            format(mitrastring, 256, "Rifle: None.");
            SendClientMessage(playerid, COLOR_RED, mitrastring);
	        }
	    case 30:
	        {
            format(mitrastring, 256, "Rifle: AK-47.");
            SendClientMessage(playerid, COLOR_RED, mitrastring);
	        }
	    case 29:
	        {
            format(mitrastring, 256, "Rifle: Mp5.");
            SendClientMessage(playerid, COLOR_RED, mitrastring);
	        }
}
    return true;

 }
   
      if(strcmp(cmd, "/help", true) == 0) {
SendClientMessage(playerid, COLOR_RED, "*** Welcome into RPG mode by TommyLR");
SendClientMessage(playerid, COLOR_GREEN, "*** Command list:");
SendClientMessage(playerid, COLOR_GREEN, "*** /help /login /register");
SendClientMessage(playerid, COLOR_GREEN, "*** /taxi /arsenal /myarsenal /location ");
SendClientMessage(playerid, COLOR_GREEN, "*** /money /deposit /get");
    return 1;
   }
      if(strcmp(cmd, "/arsenal", true) == 0) {
SendClientMessage(playerid, COLOR_RED, "*** Welcome into RPG mode by TommyLR");
SendClientMessage(playerid, COLOR_GREEN, "*** Weapon list:");
SendClientMessage(playerid, COLOR_GREEN, "*** /shotgun - $10000");
SendClientMessage(playerid, COLOR_GREEN, "*** /pistols - $20000");
SendClientMessage(playerid, COLOR_GREEN, "*** /spaz - $30000");
SendClientMessage(playerid, COLOR_GREEN, "*** /ak47 - $40000");
SendClientMessage(playerid, COLOR_GREEN, "*** /mp5 - $40000");
    return 1;
   }
      if(strcmp(cmd, "/location", true) == 0) {
SendClientMessage(playerid, COLOR_RED, "*** Welcome into RPG mode by TommyLR");
SendClientMessage(playerid, COLOR_GREEN, "*** Location list:");
SendClientMessage(playerid, COLOR_GREEN, "*** /refuel - ReFueling point");
SendClientMessage(playerid, COLOR_GREEN, "*** /escape - Escape point");
SendClientMessage(playerid, COLOR_GREEN, "*** /bank - National Bank");
    return 1;
   }

      if(strcmp(cmd, "/shotgun", true) == 0) {
		 if(GetPlayerMoney(playerid) >= 10000){
			SendClientMessage(playerid, COLOR_GREEN, "*** Shotgun stored in your arsenal.");
			GivePlayerWeapon(playerid, 25, 99999);
			shotgun[playerid] = 25;
			GivePlayerMoney(playerid, - 10000);
			GameTextForPlayer(playerid, "~r~-10000~g~$", 2000, 1);
		  }else{
		    SendClientMessage(playerid, COLOR_GREEN, "*** Not enought money.");
        }
   		 return 1;
   }
       if(strcmp(cmd, "/pistols", true) == 0) {
		 if(GetPlayerMoney(playerid) >= 20000){
			SendClientMessage(playerid, COLOR_GREEN, "*** Pistols stored in your arsenal.");
			GivePlayerWeapon(playerid, 22, 99999);
			pistole[playerid] = 22;
			GivePlayerMoney(playerid,- 20000);
			GameTextForPlayer(playerid, "~r~-20000~g~$", 2000, 1);
		  }else{
		    SendClientMessage(playerid, COLOR_GREEN, "*** Not enought money.");
        }
   		 return 1;
   }
       if(strcmp(cmd, "/spaz", true) == 0) {
		 if(GetPlayerMoney(playerid) >= 30000){
			SendClientMessage(playerid, COLOR_GREEN, "*** Spaz Shotgun stored in your arsenal.");
			GivePlayerWeapon(playerid, 27, 99999);
			shotgun[playerid] = 27;
			GivePlayerMoney(playerid,- 30000);
			GameTextForPlayer(playerid, "~r~-30000~g~$", 2000, 1);
		  }else{
		    SendClientMessage(playerid, COLOR_GREEN, "*** Not enought money.");
        }
   		 return 1;
    }
       if(strcmp(cmd, "/ak47", true) == 0) {
		 if(GetPlayerMoney(playerid) >= 40000){
			SendClientMessage(playerid, COLOR_GREEN, "*** Automat Kalashnikov stored in your arsenal.");
			GivePlayerWeapon(playerid, 30, 99999);
			mitra[playerid] = 30;
			GivePlayerMoney(playerid,- 40000);
			GameTextForPlayer(playerid, "~r~-40000~g~$", 2000, 1);
		  }else{
		    SendClientMessage(playerid, COLOR_GREEN, "*** Not enought money.");
        }
   		 return 1;
    }
       if(strcmp(cmd, "/mp5", true) == 0) {
		 if(GetPlayerMoney(playerid) >= 50000){
			SendClientMessage(playerid, COLOR_GREEN, "*** Mp5 stored in your arsenal.");
			GivePlayerWeapon(playerid, 29, 99999);
			mitra[playerid] = 29;
			GivePlayerMoney(playerid,- 50000);
			GameTextForPlayer(playerid, "~r~-50000~g~$", 2000, 1);
		  }else{
		    SendClientMessage(playerid, COLOR_GREEN, "*** Not enought money.");
        }
   		 return 1;
    }
           if(strcmp(cmd, "/myarsenal", true) == 0) {
new mitrastring[256], shotgunstring[256], pistolestring[256];
	switch (pistole[playerid]) {
	    case 0:
	        {
            format(pistolestring, 256, "Pistol: Desert.");
            SendClientMessage(playerid, COLOR_RED, pistolestring);
	        }
	    case 22:
	        {
            format(pistolestring, 256, "Pistol: Double Pistols.");
            SendClientMessage(playerid, COLOR_RED, pistolestring);
	        }
}
	switch (shotgun[playerid]) {
	    case 0:
	        {
            format(shotgunstring, 256, "Shotgun: None.");
            SendClientMessage(playerid, COLOR_RED, shotgunstring);
	        }
	    case 25:
	        {
            format(shotgunstring, 256, "Shotgun: Shotgun.");
            SendClientMessage(playerid, COLOR_RED, shotgunstring);
	        }
	    case 27:
	        {
            format(shotgunstring, 256, "Shotgun: Spaz 12.");
            SendClientMessage(playerid, COLOR_RED, shotgunstring);
	        }
}
	switch (mitra[playerid]) {
        case 0:
	        {
            format(mitrastring, 256, "Rifle: None.");
            SendClientMessage(playerid, COLOR_RED, mitrastring);
	        }
	    case 30:
	        {
            format(mitrastring, 256, "Rifle: AK-47.");
            SendClientMessage(playerid, COLOR_RED, mitrastring);
	        }
	    case 29:
	        {
            format(mitrastring, 256, "Rifle: Mp5.");
            SendClientMessage(playerid, COLOR_RED, mitrastring);
	        }
}
   		 return 1;
}
       if(strcmp(cmd, "/taxi", true) == 0) {
	    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && gTeam[playerid] == TEAM_CIV){
		  SendClientMessage(playerid, COLOR_GREEN, "*** You're a taxidriver now.");
		  SetPlayerColor(playerid, COLOR_YELLOW);
		  taxi[GetPlayerVehicleID(playerid)] = playerid;
		  taxiplayer[playerid] = GetPlayerVehicleID(playerid);
         }else{
           SendClientMessage(playerid, COLOR_GREEN, "*** You must be in a vehicle and a civilian.");
           }
   		 return 1;
    }
     if(strcmp(cmd, "/refuel", true) == 0) {
     if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
		  SendClientMessage(playerid, COLOR_GREEN, "*** Checkpoint set to ReFueling point.");
		  checkpoint[playerid] = FUEL;
		  SetPlayerCheckpoint(playerid,1938.7604,-1772.1154,13.2579,4);
         }else{
           SendClientMessage(playerid, COLOR_GREEN, "*** You must be in a vehicle.");
           }
   		 return 1;
    }
    if(strcmp(cmd, "/escape", true) == 0) {
		  SendClientMessage(playerid, COLOR_GREEN, "*** Checkpoint set to escape point.");
		  checkpoint[playerid] = ESCAPE;
		  SetPlayerCheckpoint(playerid,2455.5593,-1968.9193,13.4064,4);
   		 return 1;
    }
	if(strcmp(cmd, "/bank", true) == 0) {
		  SendClientMessage(playerid, COLOR_GREEN, "*** Checkpoint set to bank.");
		  checkpoint[playerid] = BANK;
		  SetPlayerCheckpoint(playerid,1481.1293,-1750.2679,15.4453,4);
   		 return 1;
    }
    
    if(strcmp(cmd, "/calltaxi", true) == 0) {
         new taxicall[256];
         new name[MAX_PLAYER_NAME];
		 GetPlayerName(playerid, name, MAX_PLAYER_NAME);
         format(taxicall,256,"*** %s is calling for a taxi", name);
		 SendClientMessageToAll(COLOR_YELLOW, taxicall);
   		 return 1;
    }
            if(strcmp(cmd, "/autoloco", true) == 0) {
		  SendClientMessage(playerid, COLOR_GREEN, "*** Checkpoint set to AutoLoco Garage.");
		  checkpoint[playerid] = AUTOLOCO;
		  SetPlayerCheckpoint(playerid,2644.6550,-2003.5380,13.1840,4);
   		 return 1;
    }
    
            if(strcmp(cmd, "/add", true) == 0) {
bank[playerid]++;
   		 return 1;
    }
          if(strcmp(cmd, "/money", true) == 0) {
		   if(gTeam[playerid] == TEAM_CIV){
			format(say,256,"*** Your current money: %d",bank[playerid]);
			SendClientMessage(playerid, COLOR_GREEN, say);
            }else{
			format(say,256,"*** You must be a civilian for use the bank.",bank[playerid]);
			SendClientMessage(playerid, COLOR_RED, say);
            }
   		 return 1;
    }
          if(strcmp(cmd, "/deposit", true) == 0) {
		   if(gTeam[playerid] == TEAM_CIV){
	        new tmp[256];
	        new money;
		    tmp = strtok(cmdtext, idx);
            money = strval(tmp);
            if(money <= GetPlayerMoney(playerid) && money > 0) {
            bank[playerid] = bank[playerid] + money;
            GivePlayerMoney(playerid,-money);
            SendClientMessage(playerid, COLOR_GREEN, "*** Successfully deposited.");
            }else{
            SendClientMessage(playerid, COLOR_RED, "*** What do you wanna deposit?.");
			}
           }else{SendClientMessage(playerid, COLOR_RED, "*** You must be a civilian for use the bank.");}
   		 return 1;
    }
          if(strcmp(cmd, "/get", true) == 0) {
		   if(gTeam[playerid] == TEAM_CIV){
	        new tmp[256];
	        new saymoney[256];
	        new money;
		    tmp = strtok(cmdtext, idx);
            money = strval(tmp);
            if(money <= bank[playerid] && money > 0) {
            bank[playerid] = bank[playerid] - money;
            GivePlayerMoney(playerid,money);
            SendClientMessage(playerid, COLOR_GREEN, "*** Here's your money.");
            format(saymoney,256,"~g~%d~y~$",money);
 	        GameTextForPlayer(playerid, saymoney, 2000, 1);
            }else{
            SendClientMessage(playerid, COLOR_RED, "*** What do you wanna take?.");
			}
           }else{SendClientMessage(playerid, COLOR_RED, "*** You must be a civilian for use the bank.");}
   		 return 1;
    }
            if(strcmp(cmd, "/mission", true) == 0) {
new mission = gMissioni[random(sizeof(gMissioni))];
missionvehicle[playerid] = random(max_cars_selected) +1;
if(mission == 1){
GameTextForPlayer(playerid,"Mission: Steal The vehicle!",1000,3);
SendClientMessage(playerid, COLOR_GREEN, "*** Steal this vehicle and take it back to the checkpoint.");
SetVehicleParamsForPlayer(missionvehicle[playerid],playerid,1,0);
checkpoint[playerid] = MISSION1;
SetPlayerCheckpoint(playerid,2032.3915,-1296.0597,20.9270,4);
   }
if(mission == 2){
new objectivevictim = random(sizeof(playerspawned));
new strings[256];
new name[256];
GetPlayerName(objectivevictim, name, 256);
GameTextForPlayer(playerid,"Mission 2: KILL HIM!",1000,3);
format(strings, 256, "Kill %s!!!!", name);
SendClientMessage(playerid, COLOR_GREEN, strings);
wantedforhim[playerid] = objectivevictim;
   }
if(mission == 3){
GameTextForPlayer(playerid,"Mission 3:",1000,3);

   }
if(mission == 4){
GameTextForPlayer(playerid,"Mission 4:",1000,3);

   }
   		 return 1;
    }
}else{
SendClientMessage(playerid, COLOR_GREEN, "*** Login or register now.");
}
return false;
}

public SystemMsg(playerid,msg[]) {
   if ((IsPlayerConnected(playerid))&&(strlen(msg)>0)) {
       SendClientMessage(playerid,COLOR_SYSTEM,msg);
   }
   return 1;
}

public OnPlayerDeath(playerid, killerid, reason, i){
playerspawned--;
ResetPlayerMoney(playerid);
wantedlevel[playerid] = 0;
	for(i=0;i<MAX_PLAYERS;i++) {
	 if(playerid == wantedforhim[i]) {
        GivePlayerMoney(i, 3000);
        GameTextForPlayer(i, "3000~g~$", 2000, 1);
 		SendClientMessage(i, COLOR_GREEN, "*** Thanks a lot!");
 		wantedforhim[i] = 255;
      }
	}

if(killerid == INVALID_PLAYER_ID) {
  SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
}else{
// GANGSTER KILLER
 if(gTeam[killerid] == TEAM_GANGSTER){
  if(gTeam[playerid] == TEAM_GANGSTER){
  SendDeathMessage(killerid,playerid,reason);
  GivePlayerMoney(killerid, 1000);
  GameTextForPlayer(killerid, "1000~g~$", 2000, 1);
  }
  if(gTeam[playerid] == TEAM_CIV){
  SendDeathMessage(killerid,playerid,reason);
  GivePlayerMoney(killerid, 1000);
  GameTextForPlayer(killerid, "1000~g~$", 2000, 1);
  wantedlevel[killerid]++;
  }
  if(gTeam[playerid] == TEAM_POL){
  SendDeathMessage(killerid,playerid,reason);
  GivePlayerMoney(killerid, 1000);
  GameTextForPlayer(killerid, "1000~g~$", 2000, 1);
  wantedlevel[killerid] = wantedlevel[killerid] +2;
  }
 }
  if(gTeam[killerid] == TEAM_CIV){
  	if(gTeam[playerid] == TEAM_GANGSTER){
 	 SendDeathMessage(killerid,playerid,reason);
 	 GivePlayerMoney(killerid, 1000);
  	GameTextForPlayer(killerid, "1000~g~$", 2000, 1);
  	}
  	if(gTeam[playerid] == TEAM_CIV){
  	SendDeathMessage(killerid,playerid,reason);
  	GivePlayerMoney(killerid, 1000);
  	GameTextForPlayer(killerid, "1000~g~$", 2000, 1);
  	wantedlevel[killerid]++;
 	 }
  	if(gTeam[playerid] == TEAM_POL){
  	SendDeathMessage(killerid,playerid,reason);
  	GivePlayerMoney(killerid, 1000);
  	GameTextForPlayer(killerid, "1000~g~$", 2000, 1);
  	wantedlevel[killerid] = wantedlevel[killerid] +2;
  	}
  }
 // POLICE KILLER
   if(gTeam[killerid] == TEAM_POL){
  	if(gTeam[playerid] == TEAM_GANGSTER){
     if(wantedlevel[playerid] == 0){
 	 SendDeathMessage(killerid,playerid,reason);}
	 if(wantedlevel[playerid] == 1){
	 SendDeathMessage(killerid,playerid,reason);
     GivePlayerMoney(killerid, 2000);
  	 GameTextForPlayer(killerid, "2000~g~$", 2000, 1);}
	 if(wantedlevel[playerid] == 2){
	 SendDeathMessage(killerid,playerid,reason);
     GivePlayerMoney(killerid, 4000);
  	 GameTextForPlayer(killerid, "4000~g~$", 2000, 1);}
 	 if(wantedlevel[playerid] == 3){
	 SendDeathMessage(killerid,playerid,reason);
     GivePlayerMoney(killerid, 6000);
  	 GameTextForPlayer(killerid, "6000~g~$", 2000, 1);}
   	 if(wantedlevel[playerid] == 4){
	 SendDeathMessage(killerid,playerid,reason);
     GivePlayerMoney(killerid, 8000);
  	 GameTextForPlayer(killerid, "8000~g~$", 2000, 1);}
   	 if(wantedlevel[playerid] == 5){
	 SendDeathMessage(killerid,playerid,reason);
     GivePlayerMoney(killerid, 10000);
  	 GameTextForPlayer(killerid, "10000~g~$", 2000, 1);}
  	}
  	if(gTeam[playerid] == TEAM_CIV){
  
     if(wantedlevel[playerid] == 0){
     SendDeathMessage(killerid,playerid,reason);
	 GameTextForPlayer(killerid, "~r~-1000~g~ $", 2000, 1);}
	 if(wantedlevel[playerid] == 1){
	 SendDeathMessage(killerid,playerid,reason);
     GivePlayerMoney(killerid, 2000);
  	 GameTextForPlayer(killerid, "2000~g~$", 2000, 1);}
	 if(wantedlevel[playerid] == 2){
	 SendDeathMessage(killerid,playerid,reason);
     GivePlayerMoney(killerid, 4000);
  	 GameTextForPlayer(killerid, "4000~g~$", 2000, 1);}
 	 if(wantedlevel[playerid] == 3){
	 SendDeathMessage(killerid,playerid,reason);
     GivePlayerMoney(killerid, 6000);
  	 GameTextForPlayer(killerid, "6000~g~$", 2000, 1);}
   	 if(wantedlevel[playerid] == 4){
	 SendDeathMessage(killerid,playerid,reason);
     GivePlayerMoney(killerid, 8000);
  	 GameTextForPlayer(killerid, "8000~g~$", 2000, 1);}
   	 if(wantedlevel[playerid] == 5){
	 SendDeathMessage(killerid,playerid,reason);
     GivePlayerMoney(killerid, 10000);
  	 GameTextForPlayer(killerid, "10000~g~$", 2000, 1);}
 	 }
  	if(gTeam[playerid] == TEAM_POL){
  	SendDeathMessage(killerid,playerid,reason);
  	}
  }
 }
}

public OnPlayerSpawn(playerid){
playerspawned++;
IsSpawned[playerid] = 1;
GivePlayerWeapon(playerid, 24, 100000);
GivePlayerWeapon(playerid, shotgun[playerid], 100000);
GivePlayerWeapon(playerid, mitra[playerid], 100000);
GivePlayerWeapon(playerid, pistole[playerid], 100000);
SetPlayerColor(playerid, COLOR_GREEN);
 if(bank[playerid] >= 5000){
 GivePlayerMoney(playerid, 5000);
 bank[playerid] = bank[playerid] - 5000;
 }else{
 GivePlayerMoney(playerid, 5000);
 }
}
public OnPlayerStateChange(playerid, newstate, oldstate, i){
 if(newstate == PLAYER_STATE_PASSENGER && taxi[GetPlayerVehicleID(playerid)] != 255){
 GivePlayerMoney(taxi[GetPlayerVehicleID(playerid)],1000);
 GivePlayerMoney(playerid,-1000);
 GameTextForPlayer(taxi[GetPlayerVehicleID(playerid)], "1000~g~$", 2000, 1);
 GameTextForPlayer(playerid, "~r~ -1000 ~g~$", 2000, 1);
 }
  if(newstate == PLAYER_STATE_ONFOOT && taxiplayer[playerid] != 0){
  SendClientMessage(playerid, COLOR_RED, "*** You no longer are a taxidriver.");
  taxi[taxiplayer[playerid]] = 255;
  taxiplayer[playerid] = 0;
  SetPlayerColor(playerid, COLOR_GREEN);
  }
}

public OnPlayerEnterCheckpoint(playerid){
switch (checkpoint[playerid]) {
case FUEL:
	 if(GetPlayerMoney(playerid) >= 500){
 		Gas[GetPlayerVehicleID(playerid)] = 120;
 		SendClientMessage(playerid, COLOR_GREEN, "*** Car full of fuel.");
 		GivePlayerMoney(playerid, -500);
 		GameTextForPlayer(playerid, "~r~-500 ~g~$", 2000, 1);
 		DisablePlayerCheckpoint(playerid);
 		}else{
 		SendClientMessage(playerid, COLOR_GREEN, "*** Not enough money.");
		}
case ESCAPE:
 	    if(wantedlevel[playerid] >= 1){
 		SendClientMessage(playerid, COLOR_GREEN, "*** You escaped the police.");
 		GivePlayerMoney(playerid, 500);
 		GameTextForPlayer(playerid, "~g~+500 ~g~$", 2000, 1);
 		DisablePlayerCheckpoint(playerid);
 		wantedlevel[playerid] = 0;
 		}else{
 		SendClientMessage(playerid, COLOR_RED, "*** No wanted level.");
		}
case AUTOLOCO:
        if(wantedlevel[playerid] >= 0){
        DisablePlayerCheckpoint(playerid);
 		SendClientMessage(playerid, COLOR_RED, "*** Welcome into AutoLoco Lowrider.");
		}
case BANK:
        if(wantedlevel[playerid] >= 0){
        DisablePlayerCheckpoint(playerid);
 		SendClientMessage(playerid, COLOR_RED, "*** Welcome into the National Bank.");
		}
case MISSION1:
        if(wantedlevel[playerid] >= 0){
		 if(GetPlayerVehicleID(playerid) == missionvehicle[playerid]){
        GivePlayerMoney(playerid, 5000);
        GameTextForPlayer(playerid, "5000~g~$", 2000, 1);
 		SendClientMessage(playerid, COLOR_GREEN, "*** Thanks a lot!");
 		SetVehicleToRespawn(missionvehicle[playerid]);
 		DisablePlayerCheckpoint(playerid);
 		missionvehicle[playerid] = 0;
		 }
		}
	}
}
//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------------------------------------------------
public FuelDown()
 {
  for(new i=0;i<MAX_PLAYERS;i++)
   {
    Gas[GetPlayerVehicleID(i)]--;
   }
  return 1;
 }

public FuelRefill(playerid)
  {
   new VID;
   new FillUp;
   VID = GetPlayerVehicleID(playerid);
   if(Gas[VID] < GasMax)
     {
      if(GetPlayerMoney(playerid) >= FillUp)
        {
          new mess[64];
          format(mess, sizeof(mess), "* Type /refuel To Re-Fuel Your Car");
          SendClientMessage(playerid, COLOR_GREY, mess);
        }
     }
     return 1;
  }

public CheckGas()
 {
 new speed;
  new string[256];
  for(new i=0;i<MAX_PLAYERS;i++)
   {
      if(IsPlayerConnected(i))
       {
       if(GetPlayerState(i) == PLAYER_STATE_DRIVER)
        {
           	if(Gas[GetPlayerVehicleID(i)] >= 1)
	       	 {
	      	  new Float:x,Float:y,Float:z;
          	  new Float:distance,value;
            	GetPlayerPos(i, x, y, z);
         	   //curtime++;
           		 distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
            	value = floatround(distance * 5600);
				format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~KpH:~h~~y~%d ~n~~w~Fuel:~h~~y~%d~b~% ~w~",floatround(value/2200),Gas[GetPlayerVehicleID(i)]);
	        	GameTextForPlayer(i,string,1000,3);
          	   SavePlayerPos[i][LastX] = x;
          	   SavePlayerPos[i][LastY] = y;
         	   SavePlayerPos[i][LastZ] = z;
   	           }
	           else
               {
			  //new string[256];
				  new Float:x,Float:y,Float:z;
          	    SavePlayerPos[i][LastX] = x;
       	       SavePlayerPos[i][LastY] = y;
      	        SavePlayerPos[i][LastZ] = z;
      	        new Float:distance,value;
      	        GetPlayerPos(i, x, y, z);
      	        distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
      	        value = floatround(distance * 5600);
      	        speed = floatround(value/2200);
                RemovePlayerFromVehicle(i);
       	        format(string,sizeof(string),"~n~~n~~n~~n~~n~~n~~n~~n~~n~~b~MpH:~h~~w~%d~n~~r~Fuel:~h~~w~%d~b~% ",speed,Gas[GetPlayerVehicleID(i)]);
	  	        GameTextForPlayer(i,string,1000,3);
	            }
                if(Gas[GetPlayerVehicleID(i)] >= 100)
		        {
		    	 Filling[i] = 0;
		        }
		 }else{
		    	if(wantedlevel[i] == 0){}
		    	if(wantedlevel[i] == 1){GameTextForPlayer(i,"~n~~n~~n~~n~~n~~n~~n~~n~~n~[]",1000,3); SetPlayerColor(i, COLOR_YELLOW);GivePlayerMoney(i,1);}
		    	if(wantedlevel[i] == 2){GameTextForPlayer(i,"~n~~n~~n~~n~~n~~n~~n~~n~~n~[][]",1000,3); SetPlayerColor(i, COLOR_YELLOW);GivePlayerMoney(i,2);}
		    	if(wantedlevel[i] == 3){GameTextForPlayer(i,"~n~~n~~n~~n~~n~~n~~n~~n~~n~[][][]",1000,3); SetPlayerColor(i, COLOR_YELLOW);GivePlayerMoney(i,5);}
		    	if(wantedlevel[i] == 4){GameTextForPlayer(i,"~n~~n~~n~~n~~n~~n~~n~~n~~n~[][][][]",1000,3); SetPlayerColor(i, COLOR_RED);GivePlayerMoney(i,10);}
		    	if(wantedlevel[i] == 5){GameTextForPlayer(i,"~n~~n~~n~~n~~n~~n~~n~~n~~n~[][][][][]",1000,3); SetPlayerColor(i, COLOR_RED);GivePlayerMoney(i,50);}
		    	if(wantedlevel[i] == 6){wantedlevel[i] = 5;}
               }
	   }
   }
  return 1;
 }

