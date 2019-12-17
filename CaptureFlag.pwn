// This script was created by DArren Reeder(mowgli) which is me. I have decided to release it so everyone can enjoy
//it so please dont remove these commented lines just so everyone who edits my script knows i made it...thanks alot..
//add mowgli2k8@live.com if you need any help or anything at all from me..

#include <a_samp>

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" CTF By Darren Reeder (Mowgli)");
	print("----------------------------------\n");
}

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
#define COLOR_MAGENTA 0xFF00FFFF
#define COLOR_FADE1 0xE6E6E6E6
#define COLOR_FADE2 0xC8C8C8C8
#define COLOR_FADE3 0xAAAAAAAA
#define COLOR_FADE4 0x8C8C8C8C
#define COLOR_FADE5 0x6E6E6E6E
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_DBLUE 0x2641FEAA
#define COLOR_ALLDEPT 0xFF8282AA
#define COLOR_NEWS 0xFFA500AA
#define COLOR_OOC 0xE0FFFFAA
#define OBJECTIVE_COLOR 0x64000064
#define TEAM_GREEN_COLOR 0xFFFFFFAA
#define TEAM_JOB_COLOR 0xFFB6C1AA
#define TEAM_HIT_COLOR 0xFFFFFF00
#define TEAM_BLUE_COLOR 0x8D8DFF00
#define COLOR_ADD 0x63FF60AA
#define TEAM_GROVE_COLOR 0x00D900C8
#define TEAM_VAGOS_COLOR 0xFFC801C8
#define TEAM_BALLAS_COLOR 0xD900D3C8
#define TEAM_AZTECAS_COLOR 0x01FCFFC8
#define TEAM_CYAN_COLOR 0xFF8282AA
#define TEAM_ORANGE_COLOR 0xFF830000
#define TEAM_COR_COLOR 0x39393900
#define TEAM_BAR_COLOR 0x00D90000
#define TEAM_TAT_COLOR 0xBDCB9200
#define TEAM_CUN_COLOR 0xD900D300
#define TEAM_STR_COLOR 0x01FCFF00
#define TEAM_ADMIN_COLOR 0x00808000
#define COLOR_INVIS 0xAFAFAF00
#define COLOR_SPEC 0xBFC0C200

new Text:Textdraw0;
new Text:Textdraw2;

new gangscore;
new mafiascore;

new gangflag;
new mafiaflag;

new GangTeam;
new MafiaTeam;

new GangTeamPlayer[MAX_PLAYERS];
new MafiaTeamPlayer[MAX_PLAYERS];

new GangFlagHeld[MAX_PLAYERS];
new MafiaFlagHeld[MAX_PLAYERS];

new Float:gRandomLsGangSniper[2][3] = {
{1467.8101,-1773.6311,33.4297},
{1494.6393,-1773.9219,33.4243}
};

new Float:gRandomLsGang[4][3] = {
{1505.2998,-1754.5624,13.5469},
{1493.9961,-1771.7921,18.7958},
{1468.0769,-1771.7216,18.7958},
{1457.6835,-1754.7289,13.5469}
};

new Float:gRandomLsMafiaSniper[2][3] = {
{1467.8981,-1554.0146,23.5481},
{1486.8073,-1553.9187,23.5469}
};

new Float:gRandomLsMafia[2][3] = {
{1454.6406,-1626.1051,14.7891},
{1504.0363,-1626.4407,14.7891}
};

public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("CTF By Darren");
	
	Textdraw0 = TextDrawCreate(361.000000,433.000000,"Mowgli's CTF");
	Textdraw2 = TextDrawCreate(394.000000,1.000000,"Gang Team: [%s] Mafia Team: [%s]");
	new string[128];
	format(string, sizeof(string), "Mafia Score: %d | Gang Score: %d", mafiascore, gangscore);
	TextDrawSetString(Textdraw2, string);
	TextDrawAlignment(Textdraw0,0);
	TextDrawAlignment(Textdraw2,0);
	TextDrawBackgroundColor(Textdraw0,0xff0000cc);
	TextDrawBackgroundColor(Textdraw2,0x0000ffcc);
	TextDrawFont(Textdraw0,3);
	TextDrawLetterSize(Textdraw0,1.000000,1.700000);
	TextDrawFont(Textdraw2,3);
	TextDrawLetterSize(Textdraw2,0.399999,1.100000);
	TextDrawColor(Textdraw0,0xffffffff);
	TextDrawColor(Textdraw2,0xffffffff);
	TextDrawSetOutline(Textdraw0,1);
	TextDrawSetOutline(Textdraw2,1);
	TextDrawSetProportional(Textdraw2,1);
	TextDrawSetShadow(Textdraw0,5);
	TextDrawSetShadow(Textdraw2,1);
	
    gangflag = CreatePickup(2914, 23, 1481.7789,-1766.5944,18.7958,0); // LS gang flag
    mafiaflag = CreatePickup(2993, 23, 1475.5999,-1586.0874,13.5469,0); // LS Mafia flag

	AddPlayerClass(108,1958.3783,1343.1572,15.3746,270.1425,34,200,29,100,0,0); // LS Gang Sniper 1
    AddPlayerClass(173,1958.3783,1343.1572,15.3746,270.1425,34,200,24,300,0,0); // LS Gang Sniper 2
	AddPlayerClass(115,1958.3783,1343.1572,15.3746,270.1425,31,300,24,300,0,0); // LS Gang Assult Member 1
    AddPlayerClass(271,1958.3783,1343.1572,15.3746,270.1425,30,600,24,300,0,0); // LS Gang Assult Member 2
    AddPlayerClass(116,1958.3783,1343.1572,15.3746,270.1425,39,20,24,300,-1,-1); // LS Gang Bomber Member 1
    AddPlayerClass(102,1958.3783,1343.1572,15.3746,270.1425,39,5,29,300,-1,-1); // LS Gang Bomber Member 2

	AddPlayerClass(122,1958.3783,1343.1572,15.3746,270.1425,34,200,29,100,0,0); // LS Mafia Sniper 1
    AddPlayerClass(121,1958.3783,1343.1572,15.3746,270.1425,34,200,24,100,0,0); // LS Mafia Sniper 2
	AddPlayerClass(124,1958.3783,1343.1572,15.3746,270.1425,31,300,24,300,0,0); // LS Mafia Assult Member 1
    AddPlayerClass(113,1958.3783,1343.1572,15.3746,270.1425,30,600,24,300,0,0); // LS Mafia Assult Member 2
    AddPlayerClass(123,1958.3783,1343.1572,15.3746,270.1425,39,20,24,300,-1,-1); // LS Mafia Bomber Member 1
    AddPlayerClass(127,1958.3783,1343.1572,15.3746,270.1425,39,5,29,300,-1,-1); // LS Mafia Bomber Member 2
    
    AddPlayerClass(167,1958.3783,1343.1572,15.3746,270.1425,0,0,0,0,0,0); // Admin
    
	CreateObject(5135, 1551.325317, -1703.996094, 12.635761, 0.0000, 90.2409, 179.5182);
	CreateObject(5135, 1550.752808, -1683.747192, 27.756157, 0.0000, 91.1003, 180.4820);
	CreateObject(5135, 1553.227539, -1653.312256, 27.737404, 0.0000, 90.9963, 176.1846);
	CreateObject(5135, 1552.883545, -1629.994263, 27.652809, 0.0000, 91.1003, 179.6224);
	CreateObject(5135, 1548.241943, -1599.958618, 12.860754, 0.0000, 91.1002, 187.3577);
	CreateObject(5135, 1516.822876, -1583.266479, 12.746714, 0.0000, 89.3814, 232.8035);
	CreateObject(5135, 1500.002075, -1571.076660, 12.471687, 0.0000, 91.1003, 233.7671);
	CreateObject(5135, 1412.027344, -1596.188599, 12.568409, 0.0000, 90.2408, 299.8394);
	CreateObject(5135, 1407.435303, -1613.240479, 12.121666, 0.0000, 89.3814, 318.7470);
	CreateObject(5135, 1409.815308, -1669.653198, 12.646694, 0.0000, 89.3814, 0.0000);
	CreateObject(5135, 1422.269043, -1737.748657, 12.046705, 0.0000, 90.2409, 17.1887);
	CreateObject(5135, 1438.378052, -1766.123047, 11.196684, 0.0000, 90.2409, 27.5020);
	CreateObject(5135, 1450.801025, -1788.885132, 29.168556, 0.0000, 90.2409, 27.5020);
	CreateObject(5135, 1547.023315, -1749.440918, 31.743561, 0.0000, 88.5220, 141.8071);
	CreateObject(5135, 1554.418213, -1733.402100, 12.178864, 0.0000, 90.2409, 149.5420);
	CreateObject(5309, 1542.277588, -1760.184448, 63.306152, 0.0000, 90.2408, 148.6827);
	CreateObject(5309, 1549.944702, -1742.922485, 63.046066, 0.0000, 269.7592, 336.7952);
	CreateObject(5309, 1553.745972, -1725.637329, 63.070992, 0.0000, 268.8997, 0.9367);
	CreateObject(5309, 1553.341553, -1695.743408, 64.939850, 0.0000, 268.8997, 0.0000);
	CreateObject(5309, 1553.279785, -1712.114868, 64.432816, 0.0000, 268.8998, 0.0000);
	CreateObject(5309, 1553.219604, -1668.642944, 65.558380, 0.0000, 268.8998, 355.7028);
	CreateObject(5309, 1555.268188, -1639.542114, 59.830978, 0.0000, 267.1808, 4.2972);
	CreateObject(5309, 1551.448120, -1613.808594, 45.114235, 0.0000, 268.8997, 6.8755);
	CreateObject(5309, 1516.771973, -1582.076904, 43.940201, 0.0000, 269.7592, 54.1445);
	CreateObject(5309, 1413.444092, -1601.690796, 44.519379, 0.0000, 268.8997, 141.8071);
	CreateObject(5309, 1405.972412, -1620.733154, 44.193115, 0.0000, 92.8192, 0.0000);
	CreateObject(5309, 1406.848633, -1654.576782, 44.547211, 0.0000, 266.3214, 183.0601);
	CreateObject(5309, 1416.355469, -1725.644287, 43.971825, 0.0000, 91.1003, 19.7670);
	CreateObject(5309, 1427.649536, -1750.623291, 43.280502, 0.8594, 91.1003, 25.7831);
	CreateObject(5309, 1442.182983, -1774.919800, 60.964905, 359.1406, 90.2409, 23.2048);
	CreateObject(944, 1465.135254, -1752.940186, 33.314476, 0.0000, 0.0000, 0.0000);
	CreateObject(944, 1465.136963, -1752.934814, 34.760361, 0.0000, 0.0000, 0.0000);
	CreateObject(944, 1468.076416, -1752.933350, 33.314476, 0.0000, 0.0000, 0.0000);
	CreateObject(3630, 1482.040161, -1753.515869, 33.922310, 0.0000, 0.0000, 181.3411);
	CreateObject(18257, 1495.142700, -1751.859863, 32.429688, 0.0000, 0.8594, 162.4335);
	CreateObject(3798, 1452.956787, -1759.030640, 32.426231, 0.0000, 0.0000, 348.8273);
	CreateObject(3799, 1450.340576, -1758.895752, 32.311493, 0.0000, 0.0000, 347.1084);
	CreateObject(3798, 1455.140381, -1759.311523, 32.426231, 0.0000, 0.0000, 0.0000);
	CreateObject(3798, 1509.802612, -1760.974365, 32.426231, 0.0000, 0.0000, 2.5783);
	CreateObject(3798, 1511.922241, -1760.696777, 32.426231, 0.0000, 0.0000, 8.5944);
	CreateObject(3799, 1514.664673, -1760.352539, 32.311493, 0.0000, 0.0000, 18.0482);
	CreateObject(3865, 1529.599121, -1710.002686, 14.316734, 0.0000, 0.0000, 54.1445);
	CreateObject(12930, 1528.353027, -1728.652222, 13.195859, 0.0000, 0.0000, 106.5702);
	CreateObject(7040, 1527.257446, -1674.677124, 15.810593, 0.0000, 358.2811, 65.3172);
	CreateObject(5269, 1535.031860, -1695.766357, 14.855923, 0.0000, 0.0000, 125.4778);
	CreateObject(3577, 1473.054443, -1580.545410, 23.329382, 0.0000, 0.0000, 0.0000);
	CreateObject(3576, 1483.840088, -1580.999268, 24.039547, 0.0000, 0.0000, 0.0000);
	CreateObject(2567, 1463.168945, -1581.561279, 24.474476, 0.0000, 0.0000, 353.9839);
	CreateObject(1685, 1492.581787, -1581.387085, 23.296875, 0.0000, 0.0000, 15.4699);
	CreateObject(1685, 1494.691772, -1581.200073, 23.296875, 0.0000, 0.0000, 0.0000);
	CreateObject(1685, 1496.784790, -1581.286011, 23.296875, 0.0000, 0.0000, 18.0482);
	CreateObject(1685, 1496.722290, -1581.343384, 24.796875, 0.0000, 0.0000, 21.4859);
	CreateObject(1362, 1526.097168, -1606.902222, 12.981296, 0.0000, 0.0000, 0.0000);
	CreateObject(1362, 1525.026855, -1607.226440, 12.981296, 0.0000, 0.0000, 0.0000);
	CreateObject(1362, 1526.438477, -1606.320679, 12.981296, 0.0000, 0.0000, 0.0000);
	CreateObject(1348, 1528.537476, -1609.736816, 13.085339, 0.0000, 0.0000, 21.4859);
	CreateObject(16337, 1519.823730, -1608.229126, 13.431591, 0.0000, 0.0000, 0.0000);
	CreateObject(3256, 1481.738892, -1638.533936, 13.411148, 0.0000, 0.0000, 0.0000);
	CreateObject(925, 1467.452759, -1600.809082, 13.608780, 0.0000, 0.0000, 336.7952);
	CreateObject(925, 1483.353516, -1600.919922, 13.608780, 0.0000, 0.0000, 0.0000);
	CreateObject(925, 1500.641846, -1601.117676, 13.608780, 0.0000, 0.0000, 30.0803);
	CreateObject(18257, 1490.310303, -1613.954224, 13.039299, 0.0000, 0.0000, 0.0000);
	CreateObject(18257, 1450.653687, -1613.140137, 13.046875, 0.0000, 0.0000, 335.0763);
	CreateObject(12861, 1431.985107, -1624.739258, 12.378241, 0.0000, 0.0000, 0.0000);
	CreateObject(10811, 1426.902466, -1669.323364, 8.906950, 0.0000, 0.0000, 0.0000);
	CreateObject(10773, 1445.142212, -1727.211304, 15.279127, 0.0000, 0.0000, 207.8797);
	CreateObject(3643, 1474.307495, -1724.393677, 17.901663, 0.0000, 0.0000, 91.9597);
	CreateObject(3631, 1509.440063, -1723.559937, 13.125172, 0.0000, 0.0000, 347.1084);
	CreateObject(18609, 1524.278320, -1616.326050, 13.555301, 0.0000, 0.0000, 111.7268);
	CreateObject(13590, 1528.293945, -1647.481201, 13.608673, 0.0000, 0.0000, 0.0000);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
 	SetPlayerCameraPos(playerid, 1961.1343,1342.7173,15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	
	new string[128];
  	if (classid == 0)
	{
			format(string, sizeof(string), "~y~> ~p~LS Gang Sniper(1) ~y~<!");
			GameTextForPlayer(playerid,string,3500,6);
	}
  	if (classid == 1)
	{
			format(string, sizeof(string), "~y~> ~p~LS Gang Sniper(2) ~y~<!");
			GameTextForPlayer(playerid,string,3500,6);
	}
  	if (classid == 2)
	{
			format(string, sizeof(string), "~y~> ~p~LS Gang Assult Member(1) ~y~<!");
			GameTextForPlayer(playerid,string,3500,6);
	}
  	if (classid == 3)
	{
			format(string, sizeof(string), "~y~> ~p~LS Gang Assult Member(2) ~y~<!");
			GameTextForPlayer(playerid,string,3500,6);
	}
  	if (classid == 4)
	{
			format(string, sizeof(string), "~y~> ~p~LS Gang Bomber(1) ~y~<!");
			GameTextForPlayer(playerid,string,3500,6);
	}
  	if (classid == 5)
	{
			format(string, sizeof(string), "~y~> ~p~LS Gang Bomber(2) ~y~<!");
			GameTextForPlayer(playerid,string,3500,6);
	}
  	if (classid == 6)
	{
			format(string, sizeof(string), "~y~> ~p~LS Mafia Sniper(1) ~y~<!");
			GameTextForPlayer(playerid,string,3500,6);
	}
  	if (classid == 7)
	{
			format(string, sizeof(string), "~y~> ~p~LS Mafia Sniper(2) ~y~<!");
			GameTextForPlayer(playerid,string,3500,6);
	}
  	if (classid == 8)
	{
			format(string, sizeof(string), "~y~> ~p~LS Mafia Assult Member(1) ~y~<!");
			GameTextForPlayer(playerid,string,3500,6);
	}
  	if (classid == 9)
	{
			format(string, sizeof(string), "~y~> ~p~LS Mafia Assult Member(2) ~y~<!");
			GameTextForPlayer(playerid,string,3500,6);
	}
  	if (classid == 10)
	{
			format(string, sizeof(string), "~y~> ~p~LS Mafia Bomber(1) ~y~<!");
			GameTextForPlayer(playerid,string,3500,6);
	}
  	if (classid == 11)
	{
			format(string, sizeof(string), "~y~> ~p~LS Mafia Bomber(2) ~y~<!");
			GameTextForPlayer(playerid,string,3500,6);
	}
  	if (classid == 12)
	{
			format(string, sizeof(string), "~y~> ~p~Admin Only ~y~<!");
			GameTextForPlayer(playerid,string,3500,6);
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
    TextDrawShowForPlayer(playerid,Textdraw0);
    TextDrawShowForPlayer(playerid,Textdraw2);
	SendClientMessage(playerid,TEAM_BALLAS_COLOR,"Welcome to CTF by Darren Reeder(Mowgli)");
	GangTeamPlayer[playerid] = 0;
	MafiaTeamPlayer[playerid] = 0;
	GangFlagHeld[playerid] = 0;
	MafiaFlagHeld[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(GangTeamPlayer[playerid] == 1 && MafiaTeamPlayer[playerid] == 0) // Gang team death
	{
	    GangTeam --;
		GangTeamPlayer[playerid] = 0;
		MafiaTeamPlayer[playerid] = 0;
	}
	if(GangTeamPlayer[playerid] == 0 && MafiaTeamPlayer[playerid] == 1) // Mafia team death
	{
	    MafiaTeam --;
		GangTeamPlayer[playerid] = 0;
		MafiaTeamPlayer[playerid] = 0;
	}
	if(GangFlagHeld[playerid] == 1)
	{
	    GangFlagHeld[playerid] = 0;
	    MafiaFlagHeld[playerid] = 0;
	    mafiaflag = CreatePickup(2993, 23, 1475.5999,-1586.0874,13.5469,0); // LS Mafia flag
	    SendClientMessageToAll(COLOR_LIGHTRED,"The LS Mafia flag was returned by Disconnection of the holder!");
	}
	if(MafiaFlagHeld[playerid] == 1)
	{
	    GangFlagHeld[playerid] = 0;
	    MafiaFlagHeld[playerid] = 0;
	    mafiaflag = CreatePickup(2993, 23, 1475.5999,-1586.0874,13.5469,0); // LS Mafia flag
	    SendClientMessageToAll(COLOR_LIGHTRED,"The LS Gang flag was returned by Disconnection of the holder!");
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(GetPlayerSkin(playerid) == 108 || GetPlayerSkin(playerid) == 173)
	{
	    new rand = random(sizeof(gRandomLsGangSniper));
		SetPlayerPos(playerid, gRandomLsGangSniper[rand][0], gRandomLsGangSniper[rand][1], gRandomLsGangSniper[rand][2]); // Warp the player
		GangTeam ++;
		GangTeamPlayer[playerid] = 1;
		MafiaTeamPlayer[playerid] = 0;
		return 1;
	}
	else if(GetPlayerSkin(playerid) == 115 || GetPlayerSkin(playerid) == 271 || GetPlayerSkin(playerid) == 116 || GetPlayerSkin(playerid) == 102)
	{
		new rand = random(sizeof(gRandomLsGang));
		SetPlayerPos(playerid, gRandomLsGang[rand][0], gRandomLsGang[rand][1], gRandomLsGang[rand][2]); // Warp the player
        GangTeam ++;
		GangTeamPlayer[playerid] = 1;
		MafiaTeamPlayer[playerid] = 0;
		return 1;
	}
	else if(GetPlayerSkin(playerid) == 122 || GetPlayerSkin(playerid) == 121)
	{
		new rand = random(sizeof(gRandomLsMafiaSniper));
		SetPlayerPos(playerid, gRandomLsMafiaSniper[rand][0], gRandomLsMafiaSniper[rand][1], gRandomLsMafiaSniper[rand][2]); // Warp the player
        MafiaTeam ++;
		GangTeamPlayer[playerid] = 0;
		MafiaTeamPlayer[playerid] = 1;
		return 1;
	}
	else if(GetPlayerSkin(playerid) == 123 || GetPlayerSkin(playerid) == 124 || GetPlayerSkin(playerid) == 127 || GetPlayerSkin(playerid) == 113)
	{
		new rand = random(sizeof(gRandomLsMafia));
		SetPlayerPos(playerid, gRandomLsMafia[rand][0], gRandomLsMafia[rand][1], gRandomLsMafia[rand][2]); // Warp the player
        MafiaTeam ++;
		GangTeamPlayer[playerid] = 0;
		MafiaTeamPlayer[playerid] = 1;
		return 1;
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(GangTeamPlayer[playerid] == 1 && MafiaTeamPlayer[playerid] == 0) // Gang team death
	{
	    GangTeam --;
		GangTeamPlayer[playerid] = 0;
		MafiaTeamPlayer[playerid] = 0;
	}
	if(GangTeamPlayer[playerid] == 0 && MafiaTeamPlayer[playerid] == 1) // Mafia team death
	{
	    MafiaTeam --;
		GangTeamPlayer[playerid] = 0;
		MafiaTeamPlayer[playerid] = 0;
	}
	if(GangFlagHeld[playerid] == 1)
	{
	    GangFlagHeld[playerid] = 0;
	    MafiaFlagHeld[playerid] = 0;
	    mafiaflag = CreatePickup(2993, 23, 1475.5999,-1586.0874,13.5469,0); // LS Mafia flag
	    SendClientMessage(playerid,COLOR_LIGHTBLUE,"You died and lost the LS Gang Flag!");
	    SendClientMessageToAll(COLOR_LIGHTRED,"The LS Mafia flag was returned by Death of the holder!");
	}
	if(MafiaFlagHeld[playerid] == 1)
	{
	    GangFlagHeld[playerid] = 0;
	    MafiaFlagHeld[playerid] = 0;
	    mafiaflag = CreatePickup(2993, 23, 1475.5999,-1586.0874,13.5469,0); // LS Mafia flag
	    SendClientMessage(playerid,COLOR_LIGHTBLUE,"You died and lost the LS Mafia Flag!");
	    SendClientMessageToAll(COLOR_LIGHTRED,"The LS Gang flag was returned by Death of the holder!");
	}
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
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/help", cmdtext, true, 5) == 0)
	{
	    SendClientMessage(playerid,COLOR_YELLOW,"-----------------Help-----------------");
	    SendClientMessage(playerid,COLOR_YELLOW,"This is Darren's CTF.");
	    SendClientMessage(playerid,COLOR_YELLOW,"The objective of the server is fight the oposite");
	    SendClientMessage(playerid,COLOR_YELLOW,"team and try to capture the flag of the oposite");
	    SendClientMessage(playerid,COLOR_YELLOW,"team then bring it back to your flag. Once your");
	    SendClientMessage(playerid,COLOR_YELLOW,"team has captured the flag 3 times, the gamemode");
	    SendClientMessage(playerid,COLOR_YELLOW,"restarts.");
	    SendClientMessage(playerid,COLOR_YELLOW,"-----------------Help-----------------");
		return 1;
	}
	return 0;
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

public OnPlayerRequestSpawn(playerid)
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
	if(pickupid == gangflag && MafiaTeamPlayer[playerid] == 1 && GangFlagHeld[playerid] == 0 && MafiaFlagHeld[playerid] == 0)
	{
	    DestroyPickup(gangflag);
	    GangFlagHeld[playerid] = 1; //A Mafia member has took GAng Flag
	    MafiaFlagHeld[playerid] = 0;
	    SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have got the LS Gang's Flag - Get back to your Flag!");
	    SendClientMessageToAll(COLOR_RED,"The LS Gang Flag has been stolen!");
	}
	if(pickupid == mafiaflag && GangTeamPlayer[playerid] == 1 && GangFlagHeld[playerid] == 0 && MafiaFlagHeld[playerid] == 0)
	{
	    DestroyPickup(mafiaflag);
	    GangFlagHeld[playerid] = 0; // A Gang member has took the Mafia Flag.
	    MafiaFlagHeld[playerid] = 1;
	    SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have got the LS Mafia's Flag - Get back to your Flag!");
	    SendClientMessageToAll(COLOR_RED,"The LS Mafia Flag has been stolen!");
	}
	if(pickupid == gangflag && GangTeamPlayer[playerid] == 1 && MafiaFlagHeld[playerid] == 1)
	{ // A Gang Member returns Mafia Flag
	    GangFlagHeld[playerid] = 0; 
	    MafiaFlagHeld[playerid] = 0;
	    mafiaflag = CreatePickup(2993, 23, 1475.5999,-1586.0874,13.5469,0); // LS Mafia flag
	    SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have succesfully took the LS Mafia flag!");
	    SendClientMessageToAll(COLOR_LIGHTRED,"The LS Gang Got a Point!");
	    gangscore++;
		new string[128];
		format(string, sizeof(string), "Mafia Score: %d | Gang Score: %d", mafiascore, gangscore);
		TextDrawSetString(Textdraw2, string);
  		for(new i=0; i<MAX_PLAYERS; i++)
		{
			TextDrawShowForPlayer(i,Textdraw2);
		}
	}
	if(pickupid == mafiaflag && MafiaTeamPlayer[playerid] == 1 && GangFlagHeld[playerid] == 1)
	{ // A Mafia MEmbers returns Gang Flag
	    GangFlagHeld[playerid] = 0;
	    MafiaFlagHeld[playerid] = 0;
    	gangflag = CreatePickup(2914, 23, 1481.7789,-1766.5944,18.7958,0); // LS gang flag
 	    SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have succesfully took the LS Gang flag!");
	    SendClientMessageToAll(COLOR_LIGHTRED,"The LS Mafia Got a Point!");
	    mafiascore++;
		new string[128];
		format(string, sizeof(string), "Mafia Score: %d | Gang Score: %d", mafiascore, gangscore);
		TextDrawSetString(Textdraw2, string);
  		for(new i=0; i<MAX_PLAYERS; i++)
		{
			TextDrawShowForPlayer(i,Textdraw2);
		}
	}
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
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

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
// This script was created by DArren Reeder(mowgli) which is me. I have decided to release it so everyone can enjoy
//it so please dont remove these commented lines just so everyone who edits my script knows i made it...thanks alot..
//add mowgli2k8@live.com if you need any help or anything at all from me..
