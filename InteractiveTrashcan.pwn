/*
Trashcan System (2014)
(c) by Manyula

Feel free to edit this filterscript.
*/

#include <a_samp>

#define C_RED 0xFF0000FF
#define C_PINK 0xFF00FFFF

#define MINUTES 30 //Edit this define to determine the time in minutes a trashcan can be plundered again

#define MAX_TRASH_CANS 89

new Float:TrashCans[][] =
{
	{2442.1006000, -1759.0000000, 13.4000000, 0.0000000, 0.0000000, 0.0000000}, //object(cj_dumpster) (1)
	{2384.4004000, -1941.0996000, 13.3000000, 0.0000000, 0.0000000, 0.0000000}, //object(cj_dumpster) (2)
	{2439.3999000, -1901.4000000, 13.3000000, 0.0000000, 0.0000000, 0.0000000}, //object(cj_dumpster) (3)
	{2418.3999000, -1577.3000000, 23.5000000, 0.0000000, 0.0000000, 270.0000000}, //object(cj_dumpster) (4)
	{2803.5000000, -1195.7000000, 25.3000000, 0.0000000, 0.0000000, 270.0000000}, //object(cj_dumpster) (5)
	{2615.3999000, -1391.7000000, 34.5000000, 0.0000000, 0.0000000, 0.0000000}, //object(cj_dumpster) (6)
	{2546.6001000, -1289.9000000, 40.9000000, 0.0000000, 0.0000000, 270.0000000}, //object(cj_dumpster) (7)
	{2793.1001000, -1626.7000000, 10.7000000, 0.0000000, 0.0000000, 0.0000000}, //object(cj_dumpster) (8)
	{2787.2000000, -1427.8000000, 30.2000000, 0.0000000, 0.0000000, 90.0000000}, //object(cj_dumpster) (9)
	{2771.0000000, -1374.7000000, 39.4000000, 0.0000000, 0.0000000, 90.0000000}, //object(cj_dumpster) (10)
	{2700.8999000, -1107.0000000, 69.3000000, 0.0000000, 0.0000000, 90.0000000}, //object(cj_dumpster) (11)
	{2543.8999000, -1120.1000000, 61.7000000, 0.0000000, 0.0000000, 268.0000000}, //object(cj_dumpster) (12)
	{2790.7000000, -1095.3000000, 30.5000000, 0.0000000, 0.0000000, 178.0000000}, //object(cj_dumpster) (13)
	{2440.9004000, -1963.2002000, 13.3000000, 0.0000000, 0.0000000, 0.0000000}, //object(cj_dumpster) (1)
	{2344.8999000, -1949.8000000, 13.3000000, 0.0000000, 0.0000000, 180.0000000}, //object(cj_dumpster) (1)
	{2281.2000000, -2047.7000000, 13.3000000, 0.0000000, 0.0000000, 134.9940000}, //object(cj_dumpster) (1)
	{2201.2000000, -1967.5000000, 13.8000000, 0.0000000, 0.0000000, 180.4890000}, //object(cj_dumpster) (1)
	{1990.2000000, -2013.7000000, 13.3000000, 0.0000000, 0.0000000, 0.4890000}, //object(cj_dumpster) (1)
	{2052.3000000, -2145.8000000, 13.4000000, 0.0000000, 0.0000000, 0.4890000}, //object(cj_dumpster) (1)
	{2181.8000000, -2250.3000000, 13.1000000, 0.0000000, 0.0000000, 134.4890000}, //object(cj_dumpster) (1)
	{2733.8999000, -2446.2000000, 13.4000000, 0.0000000, 0.0000000, 90.4840000}, //object(cj_dumpster) (1)
	{2757.0000000, -2020.6000000, 13.3000000, 0.0000000, 0.0000000, 89.9830000}, //object(cj_dumpster) (1)
	{2627.7000000, -1985.9000000, 13.3000000, 0.0000000, 0.0000000, 224.2280000}, //object(cj_dumpster) (1)
	{2369.3000000, -2032.8000000, 13.3000000, 0.0000000, 0.0000000, 270.2250000}, //object(cj_dumpster) (1)
	{2341.6001000, -2153.8000000, 13.3000000, 0.0000000, 0.0000000, 314.9750000}, //object(cj_dumpster) (1)
	{2124.0000000, -2281.8000000, 13.2000000, 0.0000000, 0.0000000, 314.9730000}, //object(cj_dumpster) (1)
	{2200.1001000, -2631.1001000, 13.3000000, 0.0000000, 0.0000000, 0.4730000}, //object(cj_dumpster) (1)
	{2512.6001000, -2640.5000000, 13.4000000, 0.0000000, 0.0000000, 90.4720000}, //object(cj_dumpster) (1)
	{2546.1001000, -2355.3000000, 13.4000000, 0.0000000, 0.0000000, 224.4670000}, //object(cj_dumpster) (1)
	{1998.7000000, -2135.3999000, 13.3000000, 0.0000000, 0.0000000, 0.4620000}, //object(cj_dumpster) (1)
	{1731.2000000, -2054.3000000, 13.3000000, 0.0000000, 0.0000000, 0.4610000}, //object(cj_dumpster) (1)
	{1809.6000000, -1687.9000000, 13.3000000, 0.0000000, 0.0000000, 0.4610000}, //object(cj_dumpster) (1)
	{1614.6000000, -1842.6000000, 13.3000000, 0.0000000, 0.0000000, 180.0000000}, //object(cj_dumpster) (1)
	{1593.4000000, -1785.6000000, 13.1000000, 0.0000000, 0.0000000, 179.9950000}, //object(cj_dumpster) (1)
	{1641.3000000, -1678.3000000, 13.3000000, 0.0000000, 0.0000000, 1.0000000}, //object(cj_dumpster) (1)
	{1535.0000000, -1849.8000000, 13.3000000, 0.0000000, 0.0000000, 179.9950000}, //object(cj_dumpster) (1)
	{1438.0000000, -1847.4000000, 13.3000000, 0.0000000, 0.0000000, 179.9950000}, //object(cj_dumpster) (1)
	{1396.8000000, -1893.1000000, 13.3000000, 0.0000000, 0.0000000, 0.0000000}, //object(cj_dumpster) (1)
	{1210.9000000, -1877.5000000, 13.3000000, 0.0000000, 0.0000000, 270.0000000}, //object(cj_dumpster) (1)
	{1118.8000000, -1780.7000000, 13.4000000, 0.0000000, 0.0000000, 270.0000000}, //object(cj_dumpster) (1)
	{1229.1000000, -1608.4000000, 13.3000000, 0.0000000, 0.0000000, 0.0000000}, //object(cj_dumpster) (1)
	{1083.8000000, -1668.1000000, 13.4000000, 0.0000000, 0.0000000, 180.0000000}, //object(cj_dumpster) (1)
	{963.0999800, -1727.8000000, 13.3000000, 0.0000000, 0.0000000, 179.9950000}, //object(cj_dumpster) (1)
	{953.0999800, -1605.8000000, 13.3000000, 0.0000000, 0.0000000, 0.0000000}, //object(cj_dumpster) (1)
	{858.0000000, -1553.8000000, 13.3000000, 0.0000000, 0.0000000, 180.0000000}, //object(cj_dumpster) (1)
	{706.9000200, -1473.2000000, 5.2000000, 0.0000000, 0.0000000, 0.0000000}, //object(cj_dumpster) (1)
	{587.5999800, -1555.9000000, 15.4000000, 0.0000000, 0.0000000, 180.0000000}, //object(cj_dumpster) (1)
	{2383.8999000, -1486.1000000, 23.8000000, 0.0000000, 0.0000000, 90.0000000}, //object(cj_dumpster) (1)
	{2246.5000000, -1155.0000000, 25.6000000, 0.0000000, 0.0000000, 180.0000000}, //object(cj_dumpster) (1)
	{2123.5000000, -1196.0000000, 23.7000000, 0.0000000, 0.0000000, 179.9950000}, //object(cj_dumpster) (1)
	{2209.3000000, -1345.0000000, 23.8000000, 0.0000000, 0.0000000, 179.9950000}, //object(cj_dumpster) (1)
	{2004.2000000, -1550.7000000, 13.4000000, 0.0000000, 0.0000000, 334.7450000}, //object(cj_dumpster) (1)
	{1907.7000000, -1574.0000000, 13.4000000, 0.0000000, 0.0000000, 180.7420000}, //object(cj_dumpster) (1)
	{1611.7000000, -1200.3000000, 19.6000000, 0.0000000, 0.0000000, 0.7360000}, //object(cj_dumpster) (1)
	{1437.5000000, -1323.5000000, 13.3000000, 0.0000000, 0.0000000, 0.7360000}, //object(cj_dumpster) (1)
	{1360.7000000, -1520.3000000, 13.3000000, 0.0000000, 0.0000000, 345.2360000}, //object(cj_dumpster) (1)
	{1341.7000000, -1681.1000000, 13.4000000, 0.0000000, 0.0000000, 89.2340000}, //object(cj_dumpster) (1)
	{1593.3000000, -1559.9000000, 13.9000000, 0.0000000, 0.0000000, 90.7310000}, //object(cj_dumpster) (1)
	{1830.3000000, -1150.5000000, 23.6000000, 0.0000000, 0.0000000, 180.2310000}, //object(cj_dumpster) (1)
	{2059.0000000, -1049.1000000, 26.9000000, 0.0000000, 355.0000000, 338.2250000}, //object(cj_dumpster) (1)
	{2120.8999000, -1062.3000000, 25.0000000, 0.0000000, 0.0000000, 238.2250000}, //object(cj_dumpster) (1)
	{1722.2000000, -1472.5000000, 13.3000000, 0.0000000, 0.0000000, 269.7220000}, //object(cj_dumpster) (1)
	{1628.8000000, -1911.3000000, 13.3000000, 0.0000000, 0.0000000, 89.7200000}, //object(cj_dumpster) (1)
	{1372.4000000, -1721.1000000, 12.9000000, 0.0000000, 0.0000000, 180.2200000}, //object(cj_dumpster) (1)
	{2593.0000000, -1321.3000000, 39.3000000, 0.0000000, 9.0000000, 270.2200000}, //object(cj_dumpster) (1)
	{857.5000000, -975.5000000, 35.3000000, 0.0000000, 3.0000000, 210.0000000}, //object(cj_dumpster) (5)
	{2449.1001000, -2542.8000000, 13.4000000, 0.0000000, 0.0000000, 90.0000000}, //object(cj_dumpster) (14)
	{2199.8999000, -2601.8000000, 13.3000000, 0.0000000, 0.0000000, 180.0000000}, //object(cj_dumpster) (15)
	{1337.1000000, -1819.9000000, 13.3000000, 0.0000000, 0.0000000, 89.9950000}, //object(cj_dumpster) (16)
	{1424.5000000, -1357.0000000, 13.3000000, 0.0000000, 0.0000000, 179.9950000}, //object(cj_dumpster) (17)
	{1284.8000000, -1253.6000000, 13.3000000, 0.0000000, 0.0000000, 179.9950000}, //object(cj_dumpster) (18)
	{1201.9000000, -975.9000200, 43.2000000, 0.0000000, 0.0000000, 359.9950000}, //object(cj_dumpster) (20)
	{1015.8000000, -1004.2000000, 31.9000000, 0.0000000, 0.0000000, 359.9890000}, //object(cj_dumpster) (21)
	{811.7000100, -1268.2000000, 13.4000000, 0.0000000, 0.0000000, 359.9890000}, //object(cj_dumpster) (22)
	{777.4000200, -1120.6000000, 23.6000000, 0.0000000, 0.0000000, 359.9890000}, //object(cj_dumpster) (23)
	{783.7999900, -1012.6000000, 26.1000000, 0.0000000, 0.0000000, 356.4890000}, //object(cj_dumpster) (24)
	{732.7999900, -1337.3000000, 13.3000000, 0.0000000, 0.0000000, 90.4840000}, //object(cj_dumpster) (25)
	{1031.3000000, -1363.8000000, 13.3000000, 0.0000000, 0.0000000, 270.2330000}, //object(cj_dumpster) (27)
	{1011.9000000, -1270.4000000, 15.0000000, 0.0000000, 0.0000000, 270.2310000}, //object(cj_dumpster) (28)
	{876.4000200, -1363.6000000, 13.3000000, 0.0000000, 0.0000000, 90.2310000}, //object(cj_dumpster) (29)
	{996.0000000, -1521.0000000, 13.3000000, 0.0000000, 0.0000000, 270.2250000}, //object(cj_dumpster) (30)
	{410.6000100, -1808.9000000, 5.3000000, 0.0000000, 0.0000000, 90.2200000}, //object(cj_dumpster) (31)
	{1083.9000000, -1223.4000000, 15.6000000, 0.0000000, 0.0000000, 0.2140000}, //object(cj_dumpster) (32)
	{1132.9000000, -1346.2000000, 13.8000000, 0.0000000, 0.0000000, 180.2090000}, //object(cj_dumpster) (33)
	{311.7999900, -1435.7000000, 27.7000000, 0.0000000, 0.0000000, 304.9530000}, //object(cj_dumpster) (34)
	{413.3999900, -1305.4000000, 14.7000000, 0.0000000, 0.0000000, 213.7030000}, //object(cj_dumpster) (35)
	{1297.9000000, -979.0000000, 32.5000000, 0.0000000, 0.0000000, 270.2010000}, //object(cj_dumpster) (36)
	{1615.5000000, -992.5000000, 23.8000000, 0.0000000, 0.0000000, 20.1980000}, //object(cj_dumpster) (37)
	{1964.7000000, -1306.4000000, 23.5000000, 0.0000000, 351.5000000, 0.1930000} //object(cj_dumpster)
};

new TrashCans_ID[MAX_TRASH_CANS] = {-1,...};
new TrashCans_InteractionField[MAX_TRASH_CANS] = {-1,...};
new PlayerText:TrashcanNotification[MAX_PLAYERS][4];
new CurrentTrashcanArea[MAX_PLAYERS] = {-1,...};

public OnFilterScriptInit()
{
	for(new i = 0; i < MAX_TRASH_CANS; i++)
	{
		TrashCans_ID[i] = CreateDynamicObject(1345, TrashCans[i][0], TrashCans[i][1], TrashCans[i][2] , TrashCans[i][3], TrashCans[i][4], TrashCans[i][5], 0, -1);
		TrashCans_InteractionField[i] = CreateDynamicSphere(TrashCans[i][0], TrashCans[i][1], TrashCans[i][2], 4.0, 0, 0, -1);
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	TrashcanNotification[playerid][0] = CreatePlayerTextDraw(playerid, 487.999969, 333.766662, "TrashcanNotificationBigBox");
	PlayerTextDrawLetterSize(playerid, TrashcanNotification[playerid][0], 0.000000, 5.083744);
	PlayerTextDrawTextSize(playerid, TrashcanNotification[playerid][0], 379.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TrashcanNotification[playerid][0], 1);
	PlayerTextDrawColor(playerid, TrashcanNotification[playerid][0], 0);
	PlayerTextDrawUseBox(playerid, TrashcanNotification[playerid][0], true);
	PlayerTextDrawBoxColor(playerid, TrashcanNotification[playerid][0], 102);
	PlayerTextDrawSetShadow(playerid, TrashcanNotification[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TrashcanNotification[playerid][0], 0);
	PlayerTextDrawFont(playerid, TrashcanNotification[playerid][0], 0);

	TrashcanNotification[playerid][1] = CreatePlayerTextDraw(playerid, 487.666625, 333.766632, "TrashcanNotificationSmallBox");
	PlayerTextDrawLetterSize(playerid, TrashcanNotification[playerid][1], 0.000000, 0.945475);
	PlayerTextDrawTextSize(playerid, TrashcanNotification[playerid][1], 379.333312, 0.000000);
	PlayerTextDrawAlignment(playerid, TrashcanNotification[playerid][1], 1);
	PlayerTextDrawColor(playerid, TrashcanNotification[playerid][1], 0);
	PlayerTextDrawUseBox(playerid, TrashcanNotification[playerid][1], true);
	PlayerTextDrawBoxColor(playerid, TrashcanNotification[playerid][1], 102);
	PlayerTextDrawSetShadow(playerid, TrashcanNotification[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, TrashcanNotification[playerid][1], 0);
	PlayerTextDrawFont(playerid, TrashcanNotification[playerid][1], 0);

	TrashcanNotification[playerid][2] = CreatePlayerTextDraw(playerid, 381.999908, 332.266662, "Trashcan");
	PlayerTextDrawLetterSize(playerid, TrashcanNotification[playerid][2], 0.195333, 1.164443);
	PlayerTextDrawAlignment(playerid, TrashcanNotification[playerid][2], 1);
	PlayerTextDrawColor(playerid, TrashcanNotification[playerid][2], -5963521);
	PlayerTextDrawSetShadow(playerid, TrashcanNotification[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, TrashcanNotification[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, TrashcanNotification[playerid][2], 51);
	PlayerTextDrawFont(playerid, TrashcanNotification[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, TrashcanNotification[playerid][2], 1);

	TrashcanNotification[playerid][3] = CreatePlayerTextDraw(playerid, 383.333343, 344.711120, "Press ~r~~k~~SNEAK_ABOUT~ ~w~to~n~interact with~n~a trashcan.");
	PlayerTextDrawLetterSize(playerid, TrashcanNotification[playerid][3], 0.197999, 1.127110);
	PlayerTextDrawAlignment(playerid, TrashcanNotification[playerid][3], 1);
	PlayerTextDrawColor(playerid, TrashcanNotification[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, TrashcanNotification[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, TrashcanNotification[playerid][3], 1);
	PlayerTextDrawBackgroundColor(playerid, TrashcanNotification[playerid][3], 51);
	PlayerTextDrawFont(playerid, TrashcanNotification[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, TrashcanNotification[playerid][3], 1);
	return 1;
}

//==================================================================================================================================================================================================================================

new bool:Searching[MAX_PLAYERS] = false;
new TrashCanLootTimer[MAX_PLAYERS];

new TrashCan_Items[][] =
{
	{"a partially fractured Medikit"},
	{"a partially damaged Armor"},
	{"half a bread"},
	{"a piece of bread"},
	{"a half-full bottle of water"},
	{"a full bottle of water"},
	{"an energy drink"},
	{"a soft drink"},
	{"half a cucumber"},
	{"a cucumber"},
	{"half a carrot"},
	{"a carrot"},
	{"a rat"},
	{"a snake"},
	{"a tarantula"},
	{"a scorpion"},
	{"a grenade"},
	{"a little money"},
	{"very much money"},
	{"a baseball bat"},
	{"a Katana"},
	{"a golf club"},
	{"a slimey dildo"}
};

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_WALK)
	{
		if(CurrentTrashcanArea[playerid] != -1)
		{
			if(IsPlayerInDynamicArea(TrashCans_InteractionField[CurrentTrashcanArea[playerid]]))
			{
				if(!Searching[playerid])
				{
					if(gettime() < TrashCans_ID[CurrentTrashcanArea[playerid]])
					{
  						new stringEN[128];
						format(stringEN, sizeof(stringEN), "»WARNING« This trash can has already been emptied. Try again in %imin.", (TrashCans_ID[CurrentTrashcanArea[playerid]] - gettime())/60);
						return SendClientMessage(playerid, C_RED, stringEN);
					}
					TrashCanLootTimer[playerid] = SetTimerEx("TrashCanLoot", 4000, false, "ii", playerid, CurrentTrashcanArea[playerid]);
					ApplyAnimation(playerid, "BD_FIRE", "BD_Panic_Loop", 4.1, 0, 0, 0, 0, 4000, 1);
					SendClientMessage(playerid, C_PINK, "»PLAYER« You rummage through the trash...");
					Searching[playerid] = true;
				}
				else if(Searching[playerid])
				{
					TrashCans_ID[CurrentTrashcanArea[playerid]] = -1;
					SendClientMessage(playerid, C_RED, "»WARNING« You stopped rummaging through the trash.");
					ClearAnimations(playerid);
					KillTimer(TrashCanLootTimer[playerid]);
					Searching[playerid] = false;
				}
			}
		}
	}
	return 1;
}

//==================================================================================================================================================================================================================================

forward TrashCanLoot(playerid, i);
public TrashCanLoot(playerid, i)
{
	ClearAnimations(playerid);
	Searching[playerid] = false;
	TrashCans_ID[i] = gettime() + MINUTES*60;

	new stringEN[64],
		Random = random(sizeof(TrashCan_Items));
	format(stringEN, sizeof(stringEN), "»PLAYER« You have found %s!", TrashCan_Items[Random][0]);
	SendClientMessage(playerid, C_PINK, stringEN);

	new Float:HP,
		Float:AP,
		rMoney1 = random(499) + 100,
		rMoney2 = random(1999) + 1000;
	GetPlayerHealth(playerid, HP);
	GetPlayerArmour(playerid, AP);

	switch(Random)
	{
		case 0:
		{
			new RandomHP = random(15) + 5;
			if((HP + RandomHP) > 100) return SetPlayerHealth(playerid, 100);
			SetPlayerHealth(playerid, HP + RandomHP); //Medikit
		}
		case 1:
		{
			new RandomAP = random(15) + 5;
			if((AP + RandomAP) > 100) return SetPlayerArmour(playerid, 100);
			SetPlayerArmour(playerid, AP + RandomAP); //Armor
		}
		case 2:
		{
			if((HP + 7) > 100) return SetPlayerHealth(playerid, 100);
			SetPlayerHealth(playerid, HP + 10); //half a bread
		}
		case 3:
		{
			if((HP + 14) > 100) return SetPlayerHealth(playerid, 100);
			SetPlayerHealth(playerid, HP + 20); //piece of bread
		}
		case 4:
		{
			if((HP + 5) > 100) return SetPlayerHealth(playerid, 100);
			SetPlayerHealth(playerid, HP + 9); //half a bottle of water
		}
		case 5:
		{
			if((HP + 10) > 100) return SetPlayerHealth(playerid, 100);
			SetPlayerHealth(playerid, HP + 18); //bottle of water
		}
		case 6:
		{
			if((HP + 13) > 100) return SetPlayerHealth(playerid, 100);
			SetPlayerHealth(playerid, HP + 15); //energy drink
		}
		case 7:
		{
			if((HP + 12) > 100) return SetPlayerHealth(playerid, 100);
			SetPlayerHealth(playerid, HP + 12); //soft drink
		}
		case 8:
		{
			if((HP + 8) > 100) return SetPlayerHealth(playerid, 100);
			SetPlayerHealth(playerid, HP + 8); //half a cucumber
		}
		case 9:
		{
			if((HP + 16) > 100) return SetPlayerHealth(playerid, 100);
			SetPlayerHealth(playerid, HP + 16); //cucumber
		}
		case 10:
		{
			if((HP + 4) > 100) return SetPlayerHealth(playerid, 100);
			SetPlayerHealth(playerid, HP + 6); //half a carrot
		}
		case 11:
		{
			if((HP + 8) > 100) return SetPlayerHealth(playerid, 100);
			SetPlayerHealth(playerid, HP + 11); //carrot
		}
		case 12: SetPlayerHealth(playerid, HP - 12); //rat
		case 13: SetPlayerHealth(playerid, HP - 19); //snake
		case 14: SetPlayerHealth(playerid, HP - 21); //tarantula
		case 15: SetPlayerHealth(playerid, HP - 22); //scorpion
		case 16: CreateExplosion(TrashCans[i][0], TrashCans[i][1], TrashCans[i][2], 0, 2.0); //grenade
		case 17: GivePlayerMoney(playerid, rMoney1); //few money
		case 18: GivePlayerMoney(playerid, rMoney2); //much money
		case 19: GivePlayerWeapon(playerid, 5, 1); //baseball bat
		case 20: GivePlayerWeapon(playerid, 8, 1); //katana
		case 21: GivePlayerWeapon(playerid, 2, 1); //golf club
		case 22: GivePlayerWeapon(playerid, 11, 1); //dildo
	}
	return 1;
}

//==================================================================================================================================================================================================================================

forward OnPlayerEnterDynamicArea(playerid, areaid);
public OnPlayerEnterDynamicArea(playerid, areaid)
{
	for(new i = 0; i < MAX_TRASH_CANS; i++)
	{
		if(areaid == TrashCans_InteractionField[i])
		{
			CurrentTrashcanArea[playerid] = i;
			PlayerTextDrawShow(playerid, TrashcanNotification[playerid][0]);
			PlayerTextDrawShow(playerid, TrashcanNotification[playerid][1]);
			PlayerTextDrawShow(playerid, TrashcanNotification[playerid][2]);
			PlayerTextDrawShow(playerid, TrashcanNotification[playerid][3]);
			PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
		}
	}
	return 1;
}

//==================================================================================================================================================================================================================================

forward OnPlayerLeaveDynamicArea(playerid, areaid);
public OnPlayerLeaveDynamicArea(playerid, areaid)
{
	for(new i = 0; i < MAX_TRASH_CANS; i++)
	{
		if(areaid == TrashCans_InteractionField[i])
		{
	 		CurrentTrashcanArea[playerid] = -1;
			PlayerTextDrawHide(playerid, TrashcanNotification[playerid][0]);
			PlayerTextDrawHide(playerid, TrashcanNotification[playerid][1]);
			PlayerTextDrawHide(playerid, TrashcanNotification[playerid][2]);
			PlayerTextDrawHide(playerid, TrashcanNotification[playerid][3]);
		}
	}
	return 1;
}