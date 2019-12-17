/*
 * Stealth DeathMatch (Started scripting on, Tuesday, August 4th, 2009)
 * 
 * Credits:
 * LemoX / [RP]Shogun - Head Scripter (Came up with this GM).
 * [RP]Imago - Helping get spawn co-ords.
 * Kayne_Franklin / cPT. cAPSLOCK - Helping with Testing.
 * [RP]Kane_Brook - Helping with Testing.
 * Nos - Helping with Testing.
 * 
 * CHANGELOG:
 * - 0.0.4
 *   - Tweaked the "Server IP:" textdraw.
 *   - Added a 10 minute round.
 *   - Added a 10 Minute countdown in a textdraw.
 *   - Changed the amount of money you get for a kill. (From $2500 to $1000).
 *   - Fixed the countdown bug. (Round ending with 1 minute left in countdown).
 *
 * - 0.0.3
 *   - Added Knife.
 *   - Added "Winning Score" function.
 *   - Added gates blocking the entry's & exit's to the quarry.
 *   - Tweaked the script for easier customisation.
 *   - Added an ASCII load print in the samp-server console.
 *   - Added /gminfo.
 *   - Added /gmhelp.
 *   - Added /gmrules.
 * 
 * - 0.0.2
 *   - Added Silenced pistol.
 *   - Removed player name tags.
 *   - Removed player radar blips.
 *   - Added a "Server IP:" textdraw.
 *
 * - 0.0.1
 *   - Main Scripting, Making the whole Gamemode.
 *
 *
 * ||=============== DONT REMOVE ANYTHING ABOVE THIS LINE ===============||
 *
 */
//**************************************************************************************************************
#include <a_samp>
#include <LemoXfunc>
#include <MidoStream>
//**************************************************************************************************************
#define COLOUR_GREY						0xC8C8C8FF
#define COLOUR_BRIGHTGREEN				0x00FF00FF
//**************************************************************************************************************
#define SetPlayerPosXYZ 				822.4383, 866.9180, 12.0469
#define SetPlayerCameraPosXYZ			821.1745, 869.1998, 11.3468
#define SetPlayerCameraLookAtXYZ		825.5861, 860.9028, 14.7670
#define SetPlayerCameraLookAngleXYZ		23.3086
//**************************************************************************************************************
#define GMNAME							"sDM " GMVERSION
#define GMHOSTNAME						"hostname Stealth DM | Hunt or be Hunted " 
#define GMMAPNAME						"mapname Quarry"
#define GMVERSION						"0.0.4"
#define GMLASTUPDATE					"8th of August, 2009"
#define GMSCRIPTER						"LemoX / [RP]Shogun"
#define GMHOSTER						"N/A"
#define GMURL							"N/A"
#define GMPASSWORD						"password scripting"
#define GMIP							"121.0.0.1:7777"
#define GMSCOREWIN						5 // How many kills someone needs to win.
#define GMSCOREWINTEXT					"5" // Displays how many kills someone needs, this is used for textdraw, gametext etc.
//**************************************************************************************************************
forward NoWinner();
forward OneSecondTimer();
forward EndGM();
//**************************************************************************************************************
enum PlayerInfo
{
    Score
}

enum TENUM
{
T_Minutes,
T_Seconds,
Text:T_Text,
T_String[6]
}
//**************************************************************************************************************
new LemoXtime[TENUM];
new Text:Textdraw1;
new Text:Textdraw2;
new PlayerData[MAX_PLAYERS][PlayerInfo];
new Float:h[MAX_PLAYERS];
new Float:gRandomSpawns[][4] =
{
	{643.4718,730.8591,-2.0277,88.8862},
	{696.5527,731.9156,-6.9509,281.4512},
	{747.3386,779.2655,-7.4529,358.8137},
	{764.3687,856.9335,-6.0341,75.2927},
	{754.7884,950.8799,5.8370,113.6880},
	{707.4874,1000.0842,5.8190,143.7339},
	{582.5472,1001.1076,0.4296,192.1406},
	{519.6251,999.3489,-9.6611,218.4321},
	{596.3675,984.2631,-7.3475,186.4645},
	{696.9241,964.7396,-14.9611,145.4881},
	{712.0444,919.3539,-18.6644,192.6999},
	{673.2604,1006.2178,5.8341,86.8376},
	{503.8419,971.3711,-24.5407,159.4465},
	{595.3903,831.7995,-42.9520,228.3347},
	{539.2756,829.8855,-39.4312,138.7452},
	{579.5394,816.6293,-29.4880,180.6386},
	{680.4321,836.7469,-42.9609,5.4926},
	{465.6477,875.7324,-28.3962,302.7093},
	{778.1262,833.9561,5.8622,0.0332},
	{648.1068,726.6118,-2.3976,102.5565}

};
//**************************************************************************************************************
main()
{
	print(" ");
	print("============================================");
	print(" ");
	print(" _____ _           _ _   _      ____  _____ ");
	print("|   __| |_ ___ ___| | |_| |_   |    \\|     |");
	print("|__   |  _| -_| .'| |  _|   |  |  |  | | | |");
	print("|_____|_| |___|__,|_|_| |_|_|  |____/|_|_|_|");
	print(" ");
	print("============================================");
	print(" ");
	print(" Created by LemoX / [RP]Shogun");
	print(" ");
	print("============================================");
	print(" ");
}
//**************************************************************************************************************
public OnGameModeInit()
{
	SendRconCommand(GMHOSTNAME);
	SendRconCommand(GMMAPNAME);
	//SendRconCommand(GMPASSWORD);
	SetGameModeText(GMNAME);
	UsePlayerPedAnims();
	DisableInteriorEnterExits();
	AddPlayerClass(285,0.0,0.0,0.0,0.0,0,0,0,0,0,0); // 
	EnableStuntBonusForAll(0);
	SetWorldTime(0);
	SetWeather(8);
	ShowPlayerMarkers(0);
	ShowNameTags(false);
	SetDisabledWeapons(1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 21, 22, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 35, 36, 37 , 38, 39, 40, 41, 42, 43, 44, 45, 46);
	LemoXtime[T_Minutes] = 10;
	SetTimer("OneSecondTimer", 1000, true);
	LemoXtime[T_Text] = TextDrawCreate(548.000000,36.000000,"-");
	Textdraw1 = TextDrawCreate(546.000000,26.000000,"Time Left");
	TextDrawAlignment(LemoXtime[T_Text],0);
	TextDrawAlignment(Textdraw1,0);
	TextDrawBackgroundColor(LemoXtime[T_Text],0x000000ff);
	TextDrawBackgroundColor(Textdraw1,0x000000ff);
	TextDrawFont(LemoXtime[T_Text],3);
	TextDrawLetterSize(LemoXtime[T_Text],0.599999,1.800000);
	TextDrawFont(Textdraw1,1);
	TextDrawLetterSize(Textdraw1,0.399999,1.300000);
	TextDrawColor(LemoXtime[T_Text],0xffffffff);
	TextDrawColor(Textdraw1,0xffffffff);
	TextDrawSetOutline(LemoXtime[T_Text],1);
	TextDrawSetOutline(Textdraw1,1);
	TextDrawSetProportional(LemoXtime[T_Text],1);
	TextDrawSetProportional(Textdraw1,1);
	TextDrawSetShadow(LemoXtime[T_Text],1);
	TextDrawSetShadow(Textdraw1,1);
	Textdraw2 = TextDrawCreate(3.000000,435.000000,"Server IP: " GMIP);
	TextDrawUseBox(Textdraw2,1);
	TextDrawBoxColor(Textdraw2,0x000000ff);
	TextDrawTextSize(Textdraw2,650.000000,58.000000);
	TextDrawAlignment(Textdraw2,0);
	TextDrawBackgroundColor(Textdraw2,0x000000ff);
	TextDrawFont(Textdraw2,1);
	TextDrawLetterSize(Textdraw2,0.400000,1.099999);
	TextDrawLetterSize(Textdraw1,0.400000,1.099999);
	TextDrawLetterSize(Textdraw2,0.400000,1.099999);
	TextDrawColor(Textdraw2,0xffffffff);
	TextDrawSetOutline(Textdraw2,1);
	TextDrawSetProportional(Textdraw2,1);
	TextDrawSetShadow(Textdraw2,1);
	CreateStreamObject(971, 808.358032, 842.753479, 9.141752, 0.0000, 0.0000, 115.3125, 500);
	CreateStreamObject(971, 362.605957, 979.938965, 29.340956, 0.0000, 0.0000, 2.8124, 500);
	CreateStreamObject(971, 371.455566, 981.290283, 29.340956, 0.0000, 0.0000, 14.0625, 500);
	CreateStreamObject(971, 379.980499, 983.467407, 29.340956, 0.0000, 0.0000, 14.0625, 500);
	CreateStreamObject(967, 384.252167, 985.260742, 27.710930, 0.0000, 0.0000, 337.5000, 500);
	return 1;
}
//**************************************************************************************************************
public OneSecondTimer()
{
	if(LemoXtime[T_Seconds] == 0)
	LemoXtime[T_Minutes]--,
	LemoXtime[T_Seconds] = 60;
	LemoXtime[T_Seconds]--;
	if(LemoXtime[T_Minutes] == 0 && LemoXtime[T_Seconds] == 0)
	NoWinner();
	format(LemoXtime[T_String], 6, "%02d:%02d", LemoXtime[T_Minutes], LemoXtime[T_Seconds]);
	TextDrawSetString(LemoXtime[T_Text], LemoXtime[T_String]);
}
//**************************************************************************************************************
public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, SetPlayerPosXYZ);
	SetPlayerFacingAngle(playerid, SetPlayerCameraLookAngleXYZ);
	SetPlayerCameraPos(playerid, SetPlayerCameraPosXYZ);
	SetPlayerCameraLookAt(playerid, SetPlayerCameraLookAtXYZ);
	return 1;
}
//**************************************************************************************************************
public OnPlayerConnect(playerid)
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		SetPlayerColor(playerid,COLOUR_GREY);
	}
	return 1;
}
//**************************************************************************************************************
public OnPlayerDisconnect(playerid, reason)
{
	TextDrawHideForPlayer(playerid, Text:LemoXtime[T_Text]);
	TextDrawHideForPlayer(playerid, Text:Textdraw1);
	TextDrawHideForPlayer(playerid, Text:Textdraw2);
	return 1;
}
//**************************************************************************************************************
public OnPlayerSpawn(playerid)
{
	TextDrawShowForPlayer(playerid, Text:LemoXtime[T_Text]);
	TextDrawShowForPlayer(playerid, Text:Textdraw1);
	TextDrawShowForPlayer(playerid, Text:Textdraw2);
	GetPlayerHealth(playerid, h[playerid]);
	new rpos = random(20);
	GivePlayerWeapon(playerid,4,1);
	GivePlayerWeapon(playerid,23,50000);
	GivePlayerWeapon(playerid,34,50000);
	SetPlayerPos(playerid, gRandomSpawns[rpos][0], gRandomSpawns[rpos][1], gRandomSpawns[rpos][2]);
	SetPlayerFacingAngle(playerid, gRandomSpawns[rpos][3]);
	return 1;
}
//**************************************************************************************************************
public OnPlayerUpdate(playerid)
{
	new Float:Health;
	GetPlayerHealth(playerid, Health);
	if((Health-h[playerid])<-40.0)
	SetPlayerHealth(playerid,0.0);
	h[playerid]=Health;
	return 1;
}
//**************************************************************************************************************
public OnPlayerDeath(playerid, killerid, reason)
{
	SendDeathMessage(killerid, playerid, reason);
	GivePlayerMoney(killerid, 1000);
	GivePlayerMoney(playerid, -100);
	GivePlayerScore(killerid, 1);
	PlayerData[killerid][Score]++;
	if (PlayerData[playerid][Score] == GMSCOREWIN)
	{
		new string[256];
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, pname, sizeof(pname));
		format(string, sizeof(string), "~w~ %s has won the match!", pname);
		GameTextForAll(string, 5000, 2);
		SetTimer("EndGM", 5000, 1);
	}
	return 1;
}
//**************************************************************************************************************
public NoWinner()
{
	GameTextForAll("Time is up. No-one got " GMSCOREWINTEXT " kills!", 5000, 1);
	SetTimer("EndGM", 5000, 1);
}
//**************************************************************************************************************
public EndGM()
{
	SendRconCommand("gmx");
}
//**************************************************************************************************************
public OnPlayerText(playerid, text[])
{
	return 1;
}
//**************************************************************************************************************
public OnPlayerPrivmsg(playerid, recieverid, text[])
{
	return 1;
}
//**************************************************************************************************************
public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/gminfo", cmdtext, true) == 0)
	{
		SendClientMessage(playerid, COLOUR_BRIGHTGREEN, ">>==== Stealth DM ====<<");
		SendClientMessage(playerid, COLOUR_BRIGHTGREEN, "- Scripter: " GMSCRIPTER);
		SendClientMessage(playerid, COLOUR_BRIGHTGREEN, "- Hoster: " GMHOSTER);
		SendClientMessage(playerid, COLOUR_BRIGHTGREEN, "- Version: " GMVERSION);
		SendClientMessage(playerid, COLOUR_BRIGHTGREEN, "- URL: " GMURL);
		SendClientMessage(playerid, COLOUR_BRIGHTGREEN, "- Last Update: " GMLASTUPDATE); 
		return 1;
	}
	
	if (strcmp("/gmhelp", cmdtext, true) == 0)
	{
		SendClientMessage(playerid, COLOUR_BRIGHTGREEN, ">>==== Stealth DM Help ====<<");
		SendClientMessage(playerid, COLOUR_BRIGHTGREEN, "This is a pretty addictive game mode, here is what you need to know.");
		SendClientMessage(playerid, COLOUR_BRIGHTGREEN, "This is a Free-For-All Deathmatch. You cannot see player blips or name tags.");
		SendClientMessage(playerid, COLOUR_BRIGHTGREEN, "The sniper, is a 1 hit kill weapon, the silenced pistol and knife remains how they should be.");
		SendClientMessage(playerid, COLOUR_BRIGHTGREEN, "You need to get a certain amount of kills (1 score per kill) to win this match.");
		SendClientMessage(playerid, COLOUR_BRIGHTGREEN, "That is all you need to know about the gameplay, read /gmrules for the rules.");
		return 1;
	}
	
	if (strcmp("/gmrules", cmdtext, true) == 0)
	{
		SendClientMessage(playerid, COLOUR_BRIGHTGREEN, ">>==== Stealth DM Rules ====<<");
		SendClientMessage(playerid, COLOUR_BRIGHTGREEN, "No hacking of any sort. (INSTANT BAN)");
		SendClientMessage(playerid, COLOUR_BRIGHTGREEN, "No advertising of other servers. (1st TIME = KICK, 2nd TIME = BAN)");
		SendClientMessage(playerid, COLOUR_BRIGHTGREEN, "No rascism at all. (INSTANT BAN)");
		SendClientMessage(playerid, COLOUR_BRIGHTGREEN, "You must speak English, this is a English ONLY speaking server");
		SendClientMessage(playerid, COLOUR_BRIGHTGREEN, "Do not ask to be an admin, you will never be considered to be an admin if you ask.");
		SendClientMessage(playerid, COLOUR_BRIGHTGREEN, "Do not abuse bugs. PM them to a scripter and/or admin (INSTANT BAN IF ABUSED)");
		return 1;
	}
	return 0;
}
//**************************************************************************************************************