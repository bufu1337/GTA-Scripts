#include <a_samp>
#include <Dini>
#include <dutils>
#include <DUDB>

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_LIGHTGREEN 0x9ACD32AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_YELLOW2 0xF5DEB3AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_DBLUE 0x2641FEAA
#define COLOR_ALLDEPT 0xFF8282AA
#define COLOR_NEWS 0xFFA500AA
#define COLOR_OOC 0xE0FFFFAA

static gTeam[MAX_PLAYERS];
#define TEAM_BLUE 1
#define TEAM_RED 2

#pragma tabsize 0

new Text:Textdraw0;
new Text:Textdraw1;

new Text:Textdraw3;
new Text:Textdraw4;

forward SendClientMessageToAdmins(color,const string[],alevel);
forward KeyChanges();
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward ObjectToPoint(Float:radi, objectid, Float:x, Float:y, Float:z);
forward IsAGoal();
forward restart(playerid);

new football;
new playingfootball[MAX_PLAYERS];
new matchstarted[MAX_PLAYERS];
new teamselected[MAX_PLAYERS];
new logged[MAX_PLAYERS];
new spectator[MAX_PLAYERS];

new lastentered[128];

new bluescore = 0;
new redscore = 0;

main()
{
	print("* Championship Football by RuNix.");
}

public OnGameModeInit()
{
ShowPlayerMarkers(0);

new wstring[128];
format(wstring, sizeof(wstring), "Steaua: %d.", redscore);
Textdraw3 = TextDrawCreate(447.000000,389.000000,wstring);
	
new pstring[128];
format(pstring, sizeof(pstring), "Rapid: %d.", bluescore);
Textdraw4 = TextDrawCreate(448.000000,409.000000,pstring);
	
TextDrawAlignment(Textdraw3,0);
TextDrawAlignment(Textdraw4,0);
TextDrawBackgroundColor(Textdraw3,0x000000ff);
TextDrawBackgroundColor(Textdraw4,0x000000ff);
TextDrawFont(Textdraw3,3);
TextDrawLetterSize(Textdraw3,0.799999,1.700000);
TextDrawFont(Textdraw4,3);
TextDrawLetterSize(Textdraw4,0.699999,1.900000);
TextDrawColor(Textdraw3,0xff000099);
TextDrawColor(Textdraw4,0x0000ff99);
TextDrawSetOutline(Textdraw3,1);
TextDrawSetOutline(Textdraw4,1);
TextDrawSetProportional(Textdraw3,1);
TextDrawSetProportional(Textdraw4,1);
TextDrawSetShadow(Textdraw3,1);
TextDrawSetShadow(Textdraw4,1);

SetTimer("IsAGoal", 100, true);
SetGameModeText("Romanian Soccer [RTCG]");
AddPlayerClass(81,3190.718,-1862.207,118.159,298.3470,0,0,0,0,0,0);
AddPlayerClass(80,3190.718,-1862.207,118.159,298.3470,0,0,0,0,0,0);
CreateObject(13650, 3177.898682, -1853.351318, 122.521393, 0.0000, 0.0000, 0.0000);
CreateObject(7379, 3242.087158, -1904.596436, 118.177612, 0.0000, 0.0000, 270.0000);
CreateObject(7379, 3254.220459, -1903.083618, 118.177612, 0.0000, 0.0000, 180.0000);
CreateObject(7379, 3134.254395, -1803.616455, 118.177612, 0.0000, 0.0000, 90.0000);
CreateObject(7379, 3122.343994, -1908.847290, 118.177612, 0.0000, 0.0000, 180.0001);
CreateObject(974, 3250.948486, -1847.978394, 120.955528, 0.0000, 0.0000, 348.7500);
CreateObject(974, 3254.122559, -1852.057739, 120.955528, 0.0000, 0.0000, 270.0000);
CreateObject(974, 3254.123291, -1858.686890, 120.955528, 0.0000, 0.0000, 270.0000);
CreateObject(974, 3250.936523, -1862.565186, 120.955528, 0.0000, 0.0000, 190.4678);
CreateObject(993, 3249.123047, -1852.468262, 123.266586, 95.3975, 359.1406, 90.0000);
CreateObject(993, 3249.022949, -1858.050537, 123.316574, 95.3975, 359.1406, 90.0000);
CreateObject(991, 3252.705078, -1849.381714, 123.573128, 91.1003, 0.0000, 349.6868);
CreateObject(991, 3252.757813, -1860.973267, 123.543037, 91.1003, 0.0000, 12.1868);
CreateObject(991, 3250.998779, -1853.188110, 123.518036, 91.1003, 0.0000, 90.9368);
CreateObject(991, 3251.047852, -1858.663452, 123.518112, 91.1003, 0.0000, 90.9368);
CreateObject(991, 3253.210205, -1856.853394, 123.511429, 91.1003, 0.0000, 90.9368);
CreateObject(991, 3252.990723, -1853.713135, 123.562637, 91.1003, 0.0000, 90.9368);
CreateObject(974, 3125.654053, -1849.198730, 120.955528, 0.0000, 0.0000, 191.2500);
CreateObject(974, 3125.879395, -1862.447144, 120.955528, 0.0000, 0.0000, 167.9678);
CreateObject(974, 3122.683350, -1858.472046, 120.955528, 0.0000, 0.0000, 269.2178);
CreateObject(974, 3122.745117, -1852.988403, 120.955528, 0.0000, 0.0000, 89.2178);
CreateObject(974, 3125.462158, -1857.223511, 123.855492, 87.6625, 0.0000, 89.2178);
CreateObject(974, 3125.553955, -1853.632568, 123.819046, 87.6625, 0.0000, 89.2178);
CreateObject(991, 3126.058594, -1861.298584, 123.613052, 91.1003, 0.0000, 348.0452);
CreateObject(991, 3128.479736, -1857.455078, 123.968033, 91.1003, 0.0000, 269.2179);
CreateObject(991, 3126.199219, -1850.280029, 123.861031, 91.1003, 0.0000, 190.4679);
CreateObject(991, 3128.382324, -1852.673218, 123.918030, 91.1003, 0.0000, 91.7962);
CreateObject(1251, 3190.699707, -1848.598389, 118.182465, 0.0000, 357.4217, 0.0000);
CreateObject(4867, 3180.212646, -1862.409180, 118.204475, 0.0000, 0.0000, 0.0000);
CreateObject(1251, 3190.694092, -1841.727051, 118.184151, 0.0000, 357.4217, 0.0000);
CreateObject(1251, 3190.703857, -1834.868164, 118.184151, 0.0000, 357.4217, 0.0000);
CreateObject(1251, 3190.711426, -1828.009277, 118.184151, 0.0000, 357.4217, 0.0000);
CreateObject(1251, 3190.714111, -1821.144409, 118.184151, 0.0000, 357.4217, 0.0000);
CreateObject(1251, 3190.715088, -1814.400635, 118.184151, 0.0000, 357.4217, 0.0000);
CreateObject(1251, 3189.947510, -1808.328369, 118.309158, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3190.725098, -1855.359619, 118.159149, 0.0000, 357.4217, 0.0000);
CreateObject(1251, 3190.717529, -1862.206665, 118.159149, 0.0000, 357.4217, 0.0000);
CreateObject(1251, 3190.720703, -1869.047363, 118.159149, 0.0000, 357.4217, 0.0000);
CreateObject(1251, 3190.706787, -1875.901245, 118.159149, 0.0000, 357.4217, 0.0000);
CreateObject(1251, 3190.681396, -1882.650879, 118.184151, 0.0000, 357.4217, 0.0000);
CreateObject(1251, 3190.679443, -1889.541870, 118.184151, 0.0000, 357.4217, 0.0000);
CreateObject(1251, 3190.662598, -1896.406372, 118.184151, 0.0000, 357.4217, 0.0000);
CreateObject(1251, 3187.234375, -1899.755371, 118.309158, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3180.435059, -1899.740601, 118.309158, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3173.624512, -1899.726929, 118.309158, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3166.935059, -1899.725830, 118.309158, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3160.108154, -1899.719360, 118.309158, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3153.295898, -1899.729858, 118.309158, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3146.481201, -1899.724976, 118.309158, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3139.761719, -1899.723633, 118.309158, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3132.929932, -1899.732666, 118.309158, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3128.913818, -1899.765259, 118.309158, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3125.586426, -1896.376099, 118.309158, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3125.587158, -1889.566772, 118.309158, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3125.618164, -1882.913696, 118.309158, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3125.620850, -1876.338257, 118.309158, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3125.632813, -1869.625244, 118.309158, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3125.616211, -1865.932617, 118.309158, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3125.606689, -1845.785645, 118.293358, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3125.623535, -1838.970947, 118.309158, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3125.618164, -1832.119263, 118.309158, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3125.618896, -1825.343994, 118.309158, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3125.613037, -1818.529541, 118.309158, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3125.601563, -1811.759521, 118.309158, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3129.065674, -1808.383301, 118.309158, 0.0000, 357.4217, 89.9999);
CreateObject(1251, 3135.846680, -1808.377930, 118.309158, 0.0000, 357.4217, 89.9999);
CreateObject(1251, 3142.641113, -1808.371826, 118.309158, 0.0000, 357.4217, 89.9999);
CreateObject(1251, 3149.421387, -1808.379150, 118.309158, 0.0000, 357.4217, 89.9999);
CreateObject(1251, 3156.148926, -1808.374756, 118.309158, 0.0000, 357.4217, 89.9999);
CreateObject(1251, 3162.686523, -1808.375366, 118.309158, 0.0000, 357.4217, 89.9999);
CreateObject(1251, 3169.375977, -1808.367310, 118.309158, 0.0000, 357.4217, 89.9999);
CreateObject(1251, 3176.244385, -1808.357788, 118.309158, 0.0000, 357.4217, 89.9999);
CreateObject(1251, 3183.126221, -1808.332886, 118.309158, 0.0000, 357.4217, 89.9999);
CreateObject(1251, 3190.688721, -1811.644409, 118.194351, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3196.718506, -1808.327637, 118.309158, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3203.532715, -1808.327637, 118.309158, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3210.300293, -1808.327026, 118.309158, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3217.144287, -1808.340942, 118.309158, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3224.015381, -1808.335938, 118.309158, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3230.833008, -1808.318726, 118.309158, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3237.701660, -1808.323120, 118.309158, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3244.533447, -1808.322632, 118.309158, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3247.882813, -1811.651001, 118.309158, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3247.882324, -1818.347412, 118.309158, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3247.876465, -1825.206543, 118.309158, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3247.874023, -1832.025024, 118.309158, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3247.866455, -1838.838745, 118.309158, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3247.858643, -1843.830322, 118.309158, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3247.701904, -1866.666748, 118.346725, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3247.742676, -1873.482910, 118.309158, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3247.758789, -1880.275024, 118.309158, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3194.067627, -1899.726807, 118.309158, 0.0000, 357.4217, 90.0000);
CreateObject(1251, 3200.790283, -1899.741089, 118.309158, 0.0000, 357.4217, 90.0000);
CreateObject(1251, 3207.534180, -1899.751587, 118.309158, 0.0000, 357.4217, 90.0000);
CreateObject(1251, 3214.395264, -1899.727417, 118.309158, 0.0000, 357.4217, 90.0000);
CreateObject(1251, 3221.148193, -1899.699707, 118.309158, 0.0000, 357.4217, 90.0000);
CreateObject(1251, 3227.943604, -1899.708496, 118.309158, 0.0000, 357.4217, 90.0000);
CreateObject(1251, 3234.827881, -1899.718506, 118.309158, 0.0000, 357.4217, 90.0000);
CreateObject(1251, 3241.607910, -1899.722900, 118.309158, 0.0000, 357.4217, 90.0000);
CreateObject(1251, 3247.775879, -1886.908447, 118.309158, 0.0000, 357.4217, 360.0000);
CreateObject(1251, 3247.761230, -1893.744873, 118.309158, 0.0000, 357.4217, 360.0000);
CreateObject(1251, 3244.237793, -1899.668823, 118.370743, 0.0000, 357.4217, 269.9999);
CreateObject(1251, 3247.718506, -1896.387451, 118.294739, 0.0000, 357.4217, 180.0001);
CreateObject(1251, 3129.304443, -1869.253418, 118.184151, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3135.572266, -1869.236816, 118.184151, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3138.945557, -1865.794434, 118.184151, 0.0000, 357.4217, 359.9999);
CreateObject(1251, 3129.063477, -1842.066406, 118.209152, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3135.552002, -1842.070679, 118.184151, 0.0000, 357.4217, 270.0000);
CreateObject(1251, 3138.805420, -1845.405151, 118.184151, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3138.835693, -1852.274658, 118.159149, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3138.848145, -1859.082031, 118.184151, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3244.699463, -1842.846191, 118.184151, 0.0000, 357.4217, 89.9999);
CreateObject(1251, 3238.019287, -1842.817627, 118.184151, 0.0000, 357.4217, 90.0000);
CreateObject(1251, 3234.661377, -1846.229858, 118.184151, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3234.672607, -1852.878052, 118.159149, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3234.687744, -1859.698364, 118.184151, 0.0000, 357.4217, 180.0000);
CreateObject(1251, 3244.463135, -1869.969238, 118.159149, 0.0000, 357.4217, 90.0000);
CreateObject(1251, 3238.023438, -1869.955688, 118.159149, 0.0000, 357.4217, 90.0000);
CreateObject(1251, 3234.704590, -1866.553955, 118.159149, 0.0000, 357.4217, 360.0000);
CreateObject(8356, 3254.320313, -1871.574097, 118.225449, 0.0000, 88.5220, 0.0000);
CreateObject(8356, 3199.266113, -1803.528687, 118.225449, 0.0000, 88.5220, 90.0000);
CreateObject(8356, 3122.300781, -1834.751465, 118.225449, 0.0000, 88.5220, 180.0000);
CreateObject(8356, 3192.014160, -1904.683228, 118.225449, 0.0000, 88.5220, 270.0000);
football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);

Textdraw0 = TextDrawCreate(107.000000,161.000000,"> Steaua (/steaua)");
Textdraw1 = TextDrawCreate(105.000000,240.000000,"> Rapid (/rapid)");
TextDrawAlignment(Textdraw0,0);
TextDrawAlignment(Textdraw1,0);
TextDrawBackgroundColor(Textdraw0,0x000000ff);
TextDrawBackgroundColor(Textdraw1,0x000000ff);
TextDrawFont(Textdraw0,3);
TextDrawLetterSize(Textdraw0,1.000000,2.799999);
TextDrawFont(Textdraw1,3);
TextDrawLetterSize(Textdraw1,1.000000,3.099998);
TextDrawColor(Textdraw0,0x0000ffff);
TextDrawColor(Textdraw1,0xff0000ff);
TextDrawSetOutline(Textdraw0,1);
TextDrawSetOutline(Textdraw1,1);
TextDrawSetProportional(Textdraw0,1);
TextDrawSetProportional(Textdraw1,1);
TextDrawSetShadow(Textdraw0,1);
TextDrawSetShadow(Textdraw1,1);
return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if(teamselected[playerid] == 1)
	{
	SpawnPlayer(playerid);
	SetCameraBehindPlayer(playerid);
	}
	if(spectator[playerid] == 1)
	{
	SpawnPlayer(playerid);
	SetCameraBehindPlayer(playerid);
	}
	return 0;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
	//player connected message
	new pName[MAX_PLAYER_NAME];
 	new wstring[128];
    GetPlayerName(playerid, pName, sizeof(pName));
    format(wstring, sizeof(wstring), "%s has joined the server.", pName);
    SendClientMessageToAll(COLOR_WHITE, wstring);
    
	SendClientMessage(playerid,COLOR_YELLOW,"** Welcome");
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"* /steaua or /rapid for team");
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"* or /spectator");
	
	spectator[playerid]=0;
	playingfootball[playerid]=0;
	matchstarted[playerid]=0;
	teamselected[playerid]=0;
	logged[playerid]=0;
	TextDrawShowForPlayer(playerid,Text:Textdraw0);//Rapid textdraw
	TextDrawShowForPlayer(playerid,Text:Textdraw1);//STEAUA textdraw
	TextDrawShowForPlayer(playerid,Text:Textdraw3);//Rapid textdraw
	TextDrawShowForPlayer(playerid,Text:Textdraw4);//STEAUA textdraw
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(logged[playerid] == 1)
	{
	dUserSetINT(PlayerName(playerid)).("goalsscored", GetPlayerScore(playerid));
	}
    new pName[MAX_PLAYER_NAME];
    new string[56];
    GetPlayerName(playerid, pName, sizeof(pName));
	logged[playerid]=0;
	
    switch(reason)
    {
        case 0: format(string, sizeof(string), "%s has left the server. (Timeout)", pName);
        case 1: format(string, sizeof(string), "%s has left the server. (Leaving)", pName);
        case 2: format(string, sizeof(string), "%s has left the server. (Kicked)", pName);
    }

    SendClientMessageToAll(COLOR_WHITE, string);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	TextDrawHideForPlayer(playerid,Text:Textdraw0);//Rapid Textdraw
	TextDrawHideForPlayer(playerid,Text:Textdraw1);//STEAUA Textdraw
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
if(text[0] == '!') {
new name[24], string[256];
GetPlayerName(playerid, name, 24);
format(string, sizeof(string), "%s (TEAM): %s", name, text[1]);

for(new i = 0; i < MAX_PLAYERS; i++) {
if(IsPlayerConnected(i)) {
if(gTeam[i] == gTeam[playerid])
SendClientMessage(i, GetPlayerColor(playerid), string);
}
}
return 0;
}
return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new idx;
	
	cmd = strtok(cmdtext, idx);
//-------------------------------------------------("DUDB")-------------------------------------------------
	if (strcmp(cmdtext, "/spectator", true)==0)
	{
		if(teamselected[playerid] == 0)
		{
	    SetSpawnInfo( playerid, 0, 124,3129.4707,-1874.5061,119.2040, 0.0, 0, 0, 0, 0, 0, 0 );
	    SetPlayerSkin(playerid,124);
		SetPlayerColor(playerid,COLOR_WHITE);
		SpawnPlayer(playerid);
		teamselected[playerid]=0;
		playingfootball[playerid]=0;
		return 1;
  		}
		SendClientMessage(playerid,COLOR_YELLOW,"Ai ales deja o echipa.");
  		return 1;
	}
	if (strcmp(cmdtext, "/resetball", true)==0)
	{
		DestroyObject(football);
		football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
  		return 1;
	}
	if (strcmp(cmdtext, "/rapid", true)==0)
	{
		if(teamselected[playerid] == 0)
		{
	    SetSpawnInfo( playerid, 0, 80, 3129.4629,-1854.7981,119.2040, 0.0, 0, 0, 0, 0, 0, 0 );
	    SetPlayerSkin(playerid,80);
		SetPlayerColor(playerid,COLOR_RED);
		SpawnPlayer(playerid);
		teamselected[playerid]=1;
		playingfootball[playerid]=1;
		SetTimerEx("KeyChanges", 100, 1, "i", playerid);
		gTeam[playerid] = TEAM_RED;
		return 1;
  		}
		SendClientMessage(playerid,COLOR_YELLOW,"Ai ales deja o echipa.");
  		return 1;
	}
	if (strcmp(cmdtext, "/steaua", true)==0)
	{
		if(teamselected[playerid] == 0)
		{
	    SetSpawnInfo( playerid, 0, 81, 3242.9375,-1855.6689,119.2040, 0.0, 0, 0, 0, 0, 0, 0 );
	    SetPlayerSkin(playerid,81);
		SpawnPlayer(playerid);
		SetPlayerColor(playerid,COLOR_LIGHTBLUE);
		teamselected[playerid]=1;
		playingfootball[playerid]=1;
		SetTimerEx("KeyChanges", 100, 1, "i", playerid);
		gTeam[playerid] = TEAM_BLUE;
		return 1;
		}
		SendClientMessage(playerid,COLOR_YELLOW,"Ai ales deja o echipa.");
		return 1;
	}
	if (strcmp(cmdtext, "/commands", true)==0)
	{
    SendClientMessage(playerid,COLOR_YELLOW,"* [ C O M M A N D S ] *");
    SendClientMessage(playerid,COLOR_OOC,"Basic: /scores - /stopplaying - /objective - /admins -/spectator");
    SendClientMessage(playerid,COLOR_OOC,"Register: /register - /login");
	return 1;
	}
	if (strcmp(cmdtext, "/scores", true)==0)
	{
 	new wstring[128];
    format(wstring, sizeof(wstring), "[SCORES] Rapid: %d - STEAUA: %d.", redscore,bluescore);
    SendClientMessage(playerid,COLOR_OOC, wstring);
	return 1;
	}
	if (strcmp(cmdtext, "/stopplaying", true)==0)
	{
		playingfootball[playerid]=0;
		teamselected[playerid]=0;
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"You stopped playing football.");
		SetPlayerHealth(playerid,-1);
		ForceClassSelection(playerid);
		TextDrawShowForPlayer(playerid,Text:Textdraw0);//Rapid textdraw
		TextDrawShowForPlayer(playerid,Text:Textdraw1);//STEAUA textdraw
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
GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	if (GetPlayerVehicleID(playerid))
	{
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}
public KeyChanges()
{
    new keys, updown, leftright;
    for(new playerid = 0; playerid < MAX_PLAYERS; playerid++)
    {
        if(IsPlayerConnected(playerid))
        {
	GetPlayerKeys(playerid, keys, updown, leftright);

	new Float:ox, Float:oy, Float:oz;
	GetObjectPos(football, ox, oy, oz);

	new Float:px, Float:py, Float:pz;

	new Float:angle;
	GetPlayerFacingAngle(playerid, angle);
	

			if(keys == KEY_HANDBRAKE && playingfootball[playerid] == 1)
			{
			
				if(PlayerToPoint(1.7,playerid,ox,oy,oz))
				{
				new pName[MAX_PLAYER_NAME];
		    	GetPlayerName(playerid, pName, sizeof(pName));
		    	format(lastentered, sizeof(lastentered), "%s", pName);
		    	
				GetPlayerPos(playerid, px, py, pz);
				GetXYInFrontOfPlayer(playerid, px, py, 7.0);
				MoveObject(football,px,py,118.7040,10.0);
				PlayerPlaySound(playerid,1130,0.0,0.0,0.0);
				ApplyAnimation(playerid,"FIGHT_D","FightD_1",4.1,0,1,1,0,0);
				}
			}
  			else if(keys == KEY_HANDBRAKE + KEY_SPRINT && playingfootball[playerid] == 1)
			{

				if(PlayerToPoint(1.7,playerid,ox,oy,oz))
				{
				new pName[MAX_PLAYER_NAME];
		    	GetPlayerName(playerid, pName, sizeof(pName));
		    	format(lastentered, sizeof(lastentered), "%s", pName);

				GetPlayerPos(playerid, px, py, pz);
				GetXYInFrontOfPlayer(playerid, px, py, 7.0);
				MoveObject(football,px,py,118.7040,10.0);
				PlayerPlaySound(playerid,1130,0.0,0.0,0.0);
				ApplyAnimation(playerid,"FIGHT_D","FightD_1",4.1,0,1,1,0,0);
				}
			}
		}
	}
}

public IsAGoal()
{
    for(new playerid = 0; playerid < MAX_PLAYERS; playerid++)
    {
    if(IsPlayerConnected(playerid))
    {
	new string1[128];
	format(string1, sizeof(string1), "Rapid: %d", redscore);
	TextDrawSetString(Text:Textdraw3,string1);

  	new string2[128];
	format(string2, sizeof(string2), "Steaua: %d", bluescore);
	TextDrawSetString(Text:Textdraw4,string2);
	
    new Float:fx, Float:fy, Float:fz;
	GetObjectPos(football, fx, fy, fz);
	new enteredid = GetLastEnteredID(lastentered);

	SetPlayerMapIcon( playerid, 0, fx, fy, fz, 56, 0 );//ball icon


			if(bluescore >= 50)
			{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
			SendClientMessageToAll(COLOR_GREEN,"[VICTORY] Steaua won!");
			bluescore = 0;
			redscore = 0;
			SetTimerEx("restart", 15000, 0, "i", i);
			SendClientMessageToAll(COLOR_WHITE,"[SERVER] Jocul se va reincepe in 15 secunde.");
   			ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
			TogglePlayerControllable(i,0);
			
			if(gTeam[i] == TEAM_BLUE)
			{
			SetPlayerSpecialAction(i,SPECIAL_ACTION_DANCE3);
			}
			return 1;
			}
			}
			if(redscore >= 50)
			{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
			SendClientMessageToAll(COLOR_GREEN,"[VICTORY] Steaua won!");
			SetTimerEx("restart", 15000, 0, "i", i);
			SendClientMessageToAll(COLOR_WHITE,"[SERVER] Jocul se va reincepe in 15 secunde.");
			bluescore = 0;
			redscore = 0;
			TogglePlayerControllable(i,0);
			ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
			
			if(gTeam[i] == TEAM_RED)
			{
			SetPlayerSpecialAction(i,SPECIAL_ACTION_DANCE3);
			}
			return 1;
			}
			}
			if(ObjectToPoint(2.0,football,3247.8789,-1855.3406,119.2040) && gTeam[enteredid] == TEAM_BLUE)//Net right hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[STEAUA] %s a dat auto gol.-1! ", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);
   			
			new score = GetPlayerScore(enteredid);
   			SetPlayerScore(enteredid, score-1);
   			
   			bluescore -= 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			if(ObjectToPoint(2.0,football,3129.2944,-1856.2637,119.2040) && gTeam[enteredid] == TEAM_BLUE)//Net left hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[STEAUA] %s a dat un gol in poarta rapidului!", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
            SetPlayerScore(enteredid, score+1);
            GameTextForPlayer(playerid,"~y~GOL !!!",5000,5);

            bluescore += 1;
            
			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			
			
			if(ObjectToPoint(2.0,football,3248.0239,-1850.7186,119.2040) && gTeam[enteredid] == TEAM_BLUE)//Net right hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[STEAUA] %s a dat auto gol.-1! ", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
   			SetPlayerScore(enteredid, score-1);

   			bluescore -= 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			if(ObjectToPoint(2.0,football,3128.7542,-1861.8433,119.2040) && gTeam[enteredid] == TEAM_BLUE)//Net left hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[STEAUA] %s a dat un gol in poarta rapidului!", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
            SetPlayerScore(enteredid, score+1);
            GameTextForPlayer(playerid,"~y~GOL !!!",5000,5);

            bluescore += 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			
			if(ObjectToPoint(2.0,football,3247.8335,-1859.5492,119.2040) && gTeam[enteredid] == TEAM_BLUE)//Net right hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[STEAUA] %s a dat auto gol.-1! ", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
   			SetPlayerScore(enteredid, score-1);

   			bluescore -= 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			if(ObjectToPoint(2.0,football,3128.9373,-1859.9648,119.2040) && gTeam[enteredid] == TEAM_BLUE)//Net left hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[STEAUA] %s a dat un gol in poarta rapidului!", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
            SetPlayerScore(enteredid, score+1);
            GameTextForPlayer(playerid,"~y~GOL !!!",5000,5);

            bluescore += 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			
			if(ObjectToPoint(2.0,football,3247.9705,-1862.0924,119.2040) && gTeam[enteredid] == TEAM_BLUE)//Net right hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[STEAUA] %s a dat auto gol.-1! ", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
   			SetPlayerScore(enteredid, score-1);

   			bluescore -= 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			if(ObjectToPoint(2.0,football,3128.9167,-1858.5360,119.2040) && gTeam[enteredid] == TEAM_BLUE)//Net left hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[STEAUA] %s a dat un gol in poarta rapidului!", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
            SetPlayerScore(enteredid, score+1);
            GameTextForPlayer(playerid,"~y~GOL !!!",5000,5);

            bluescore += 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			
			
			
			//aa
			if(ObjectToPoint(2.0,football,3247.8789,-1855.3406,119.2040) && gTeam[enteredid] == TEAM_BLUE)//Net right hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[STEAUA] %s a dat auto gol.-1! ", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
   			SetPlayerScore(enteredid, score-1);

   			bluescore -= 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			if(ObjectToPoint(2.0,football,3128.8784,-1855.8451,119.2040) && gTeam[enteredid] == TEAM_BLUE)//Net left hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[STEAUA] %s a dat un gol in poarta rapidului!", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
            SetPlayerScore(enteredid, score+1);
            GameTextForPlayer(playerid,"~y~GOL !!!",5000,5);

            bluescore += 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			//2
			if(ObjectToPoint(2.0,football,3247.8789,-1855.3406,119.2040) && gTeam[enteredid] == TEAM_BLUE)//Net right hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[STEAUA] %s a dat auto gol.-1! ", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
   			SetPlayerScore(enteredid, score-1);

   			bluescore -= 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			if(ObjectToPoint(2.0,football,3128.8521,-1853.9934,119.2040) && gTeam[enteredid] == TEAM_BLUE)//Net left hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[STEAUA] %s a dat un gol in poarta rapidului!", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
            SetPlayerScore(enteredid, score+1);
            GameTextForPlayer(playerid,"~y~GOL !!!",5000,5);

            bluescore += 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			//3
			if(ObjectToPoint(2.0,football,3247.8789,-1855.3406,119.2040) && gTeam[enteredid] == TEAM_BLUE)//Net right hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[STEAUA] %s a dat auto gol.-1! ", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
   			SetPlayerScore(enteredid, score-1);

   			bluescore -= 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			if(ObjectToPoint(2.0,football,3128.8257,-1852.1575,119.2040) && gTeam[enteredid] == TEAM_BLUE)//Net left hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[STEAUA] %s a dat un gol in poarta rapidului!", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
            SetPlayerScore(enteredid, score+1);
            GameTextForPlayer(playerid,"~y~GOL !!!",5000,5);

            bluescore += 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			//4
			if(ObjectToPoint(2.0,football,3247.8789,-1855.3406,119.2040) && gTeam[enteredid] == TEAM_BLUE)//Net right hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[STEAUA] %s a dat auto gol.-1! ", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
   			SetPlayerScore(enteredid, score-1);

   			bluescore -= 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			if(ObjectToPoint(2.0,football,3128.8003,-1850.4103,119.2040) && gTeam[enteredid] == TEAM_BLUE)//Net left hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[STEAUA] %s a dat un gol in poarta rapidului!", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
            SetPlayerScore(enteredid, score+1);
            GameTextForPlayer(playerid,"~y~GOL !!!",5000,5);

            bluescore += 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			
			//Rapid STUFF
			if(ObjectToPoint(2.0,football,3247.8789,-1855.3406,119) && gTeam[enteredid] == TEAM_RED)//Net right hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[Rapid] %s a dat un gol in poarta stelei!", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
            SetPlayerScore(enteredid, score+1);
            GameTextForPlayer(playerid,"~y~GOL !!!",5000,5);

            redscore += 1;
            
			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			if(ObjectToPoint(2.0,football,3128.7542,-1861.8433,119.2040) && gTeam[enteredid] == TEAM_RED)//Net left hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[Rapid] %s a dat auto gol.-1! ", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
   			SetPlayerScore(enteredid, score-1);

            redscore -= 1;
            
			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			
			if(ObjectToPoint(2.0,football,3248.0239,-1850.7186,119.2040) && gTeam[enteredid] == TEAM_RED)//Net right hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[Rapid] %s a dat un gol in poarta stelei!", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
            SetPlayerScore(enteredid, score+1);
            GameTextForPlayer(playerid,"~y~GOL !!!",5000,5);

            redscore += 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			if(ObjectToPoint(2.0,football,3128.8784,-1855.8451,119.2040) && gTeam[enteredid] == TEAM_RED)//Net left hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[Rapid] %s a dat auto gol.-1! ", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
   			SetPlayerScore(enteredid, score-1);

            redscore -= 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			
			if(ObjectToPoint(2.0,football,3247.8335,-1859.5492,119.2040) && gTeam[enteredid] == TEAM_RED)//Net right hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[Rapid] %s a dat un gol in poarta stelei!", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
            SetPlayerScore(enteredid, score+1);
            GameTextForPlayer(playerid,"~y~GOL !!!",5000,5);

            redscore += 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			if(ObjectToPoint(2.0,football,3129.2944,-1856.2637,119.2040) && gTeam[enteredid] == TEAM_RED)//Net left hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[Rapid] %s a dat auto gol.-1! ", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
   			SetPlayerScore(enteredid, score-1);

            redscore -= 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			
			if(ObjectToPoint(2.0,football,3247.9705,-1862.0924,119.2040) && gTeam[enteredid] == TEAM_RED)//Net right hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[Rapid] %s a dat un gol in poarta stelei!", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
            SetPlayerScore(enteredid, score+1);
            GameTextForPlayer(playerid,"~y~GOL !!!",5000,5);

            redscore += 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
			if(ObjectToPoint(2.0,football,3128.8257,-1852.1575,119.2040) && gTeam[enteredid] == TEAM_RED)//Net left hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[Rapid] %s a dat auto gol.-1! ", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
   			SetPlayerScore(enteredid, score-1);

            redscore -= 1;

			DestroyObject(football);
			football=CreateObject(1598, 3190.7278,-1854.3197,119.2636, 0.0000, 0.0000, 0.0000);
			}
  		}
	}
	return 1;
}
public restart(playerid)
{
		SendRconCommand("gmx");
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
public ObjectToPoint(Float:radi, objectid, Float:x, Float:y, Float:z)
{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetObjectPos(objectid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	return 0;
}
stock PlayerName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	return name;
}
stock GetLastEnteredID(lastentered[])
{
    new name[MAX_PLAYER_NAME];
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i ))
        {
            GetPlayerName(i, name, sizeof(name));
            if (!strcmp(lastentered, name)) return i;
        }
    }
    return INVALID_PLAYER_ID;
}
stock IsInvalidSkin(skinid)
{
	new InSkin[] = {0, 3, 4, 5, 6, 8, 42, 65, 74, 86, 119, 149, 208,  273, 289};
	for (new i=0; i<sizeof(InSkin); i++) if(skinid == InSkin[i]) return 1;
	return 0;
}
