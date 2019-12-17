/*---------------------------------------------------------

fy_poolday - SA-MP Funmap

-----------------------------------------------------------

° by Eightball
° thx to Mike for Minigun Madness Code

*/


#include <a_samp>
#include <danticheat>

new gRoundTime = 900000;        // Roundtime 15 minutes


enum PlayerSpawnInfo {

	Float:PlayerX,

	Float:PlayerY,

	Float:PlayerZ,

	Float:PlayerAngle

}

new Float:gRandomSpawns[][PlayerSpawnInfo] =

{
	{1740.5600, 2860.7915, 10.9963, 214.0},
	{1750.7561, 2866.1342, 10.9963, 203.0},
	{1761.8535, 2869.1555, 10.9963, 180.0},
	{1773.4731, 2868.8784, 10.9963, 168.0},
	{1784.3555, 2865.9855, 10.9963, 157.0},
	{1794.2564, 2860.8962, 10.9963, 134.0},
	{1732.0480, 2825.3142, 11.0041, 282.0},
	{1735.7374, 2813.7873, 11.0041, 282.0},
	{1738.4523, 2802.6345, 11.0041, 282.0},
	{1747.1044, 2769.0388, 11.0041, 282.0},
	{1750.8385, 2757.8474, 11.0041, 282.0},
	{1753.4259, 2746.1997, 11.0041, 282.0},
	{1800.3695, 2825.2910, 11.0041, 78.0},
 	{1797.4038, 2814.0288, 11.0041, 78.0},
 	{1794.6258, 2802.5900, 11.0041, 78.0},
 	{1785.2344, 2768.9804, 11.0041, 78.0},
 	{1782.2141, 2758.0842, 11.0041, 78.0},
 	{1779.2082, 2746.6228, 11.0041, 78.0},
 	{1740.5166, 2861.2485, 13.9182, 214.0},
 	{1750.7810, 2866.2897, 13.9260, 203.0},
 	{1761.7546, 2869.4426, 13.9260, 180.0},
 	{1773.2669, 2869.0788, 13.9260, 168.0},
 	{1784.4595, 2866.7666, 13.9260, 157.0},
 	{1794.5084, 2861.1193, 13.9260, 145.0},
 	{1732.7912, 2825.1804, 13.9338, 282.0},
 	{1735.4036, 2814.0646, 13.9338, 282.0},
 	{1738.7144, 2802.7004, 13.9338, 282.0},
 	{1800.6782, 2825.3464, 13.9338, 78.0},
 	{1797.4616, 2814.1069, 13.9338, 78.0},
 	{1794.1234, 2802.7185, 13.9338, 78.0},
 	{1747.6691, 2769.2741, 13.9338, 282.0},
 	{1785.4217, 2769.1027, 13.9338, 78.0},
 	{1750.9248, 2757.8723, 13.9338, 282.0},
 	{1753.9598, 2746.6228, 13.9338, 282.0},
 	{1782.3212, 2757.6796, 13.9338, 66.0},
 	{1779.3874, 2746.4521, 13.9338, 78.0}
};
	

main()
{
	print("\n----------------------------------");
	print("      fy_poolday - SA-MP Funmap     ");
	print("             by Eightball           ");
	print("----------------------------------\n");
}


public OnGameModeInit()
{
	SetGameModeText("fy_poolday");
	
	ShowNameTags(1);
	
	ShowPlayerMarkers(1);
	
	SetWorldTime(15);
	
	DAntiCheat_Gamemode("poolday");
	
	AddPlayerClass(0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
	
	AddStaticPickup(1241, 2, 1767.9564, 2813.3257, 80.3359);

	AddStaticPickup(1242,2,1767.9564,2813.3257,8.3359);
	AddStaticPickup(356,2,1754.6144,2801.6487,10.8359);
	AddStaticPickup(355,2,1748.8909,2820.2146,10.8359);
	AddStaticPickup(356,2,1783.4956,2821.5217,10.8359);
	AddStaticPickup(355,2,1777.9030,2802.4851,10.8359);
	AddStaticPickup(321,2,1766.5497,2754.3923,10.8359);
	AddStaticPickup(346,2,1763.3517,2764.5896,10.8359);
	AddStaticPickup(334,2,1771.6721,2770.5549,10.8359);
	AddStaticPickup(341,2,1761.6141,2775.2773,10.8359);
	AddStaticPickup(348,2,1774.2267,2782.5974,10.8359);
	AddStaticPickup(372,2,1754.8176,2791.2146,10.8359);
	AddStaticPickup(325,2,1778.9570,2792.6790,10.8359);
	AddStaticPickup(347,2,1783.6287,2810.1621,10.8283);
	AddStaticPickup(337,2,1749.0828,2811.1997,10.8283);
	AddStaticPickup(352,2,1743.6475,2833.4922,10.8283);
	AddStaticPickup(336,2,1748.2202,2844.8533,10.8359);
	AddStaticPickup(347,2,1758.6912,2852.8252,10.8359);
	AddStaticPickup(372,2,1772.9595,2852.7388,10.8359);
	AddStaticPickup(333,2,1784.0842,2848.1592,10.8359);
	AddStaticPickup(348,2,1789.7164,2834.9524,10.8359);
	
	SetTimer("AnnounceWinner", gRoundTime, 0);
	
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1731.0278, 2671.7969, 10.8203);
	
	SetPlayerCameraPos(playerid, 1766.7356, 2736.0525, 66.2205);
	
	SetPlayerCameraLookAt(playerid, 1766.6105, 2793.7532, 8.3359);
	
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	ResetSpawnInfo(playerid);
	
	return 1;
}

public OnPlayerConnect(playerid)
{
	SendClientMessage(playerid, 0xFFFF00AA, "Welcome to: fy_poolday - an SA-MP Funmap by Eightball");
	SendClientMessage(playerid, 0xFFFF00AA, "Just kill as many people as possible.");
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerWorldBounds(playerid, 1830.3374, 1698.2655, 2882.4065, 2724.4895);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp(cmdtext, "/bt", true)==0)
	{
	    if(IsPlayerAdmin(playerid) == 1) {
	        BulletTime();
     	}
	    return 1;
	}
	return 0;
}

// Nearly 1:1 copied from Minigun Madness by Mike

public OnPlayerDeath(playerid, killerid, reason)
{
	SendDeathMessage(killerid, playerid, reason);
	
	DAntiCheat_SetPlayerScore(killerid, GetPlayerScore(killerid) + 1);
	
	ResetSpawnInfo(playerid);
	
	return 1;
}

ResetSpawnInfo(playerid)
{
	new rand = random(sizeof(gRandomSpawns));

	SetSpawnInfo(playerid, 255, 0,

					gRandomSpawns[rand][PlayerX],

					gRandomSpawns[rand][PlayerY],

					gRandomSpawns[rand][PlayerZ],

					gRandomSpawns[rand][PlayerAngle],

					4, 0, 0, 0, 0, 0);

}

public AnnounceWinner() {
	new playerscore, max_score;
	new playername[MAX_PLAYER_NAME], max_name[MAX_PLAYER_NAME];
	new string[128];
	for(new i=0; i<MAX_PLAYERS; i++) {
	    playerscore = GetPlayerScore(i);
		if (playerscore > max_score) {
		    GetPlayerName(i, playername, sizeof(playername));
			max_score = playerscore;
			max_name = playername;
		}
	}
	if (max_score < 1) format(string, sizeof(string), "~w~Don't you want to kill each other??");
	else format(string, sizeof(string), "~r~%s ~w~is crazy!~n~ He killed ~r~%d ~w~people!", max_name, max_score);
	GameTextForAll(string, 5000, 3);
	SetTimer("GameModeExitFunc", 8000, 0);
}

new Float:oldx[MAX_PLAYERS];
new Float:oldy[MAX_PLAYERS];
new Float:oldz[MAX_PLAYERS];

public BulletTime() {
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerPos(i, oldx[i], oldy[i], oldz[i]);
			SetPlayerPos(i, 1767.9564, 2813.3257, 80.3359);
			SetTimer("BackFunc", 200, 0);
		}
	}
}

public BackFunc() {
    for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			SetPlayerPos(i, oldx[i], oldy[i], oldz[i]);
		}
	}
	GameTextForAll("~r~Bullet-Time!!!", 3000, 3);
}

public GameModeExitFunc() { GameModeExit(); }
