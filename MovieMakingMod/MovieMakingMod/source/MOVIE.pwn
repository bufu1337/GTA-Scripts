/**
* Lj's Movie Making Gamemode
* For SA-MP 0.2.2 and R3.

====================================
|                                  |
|     Movie Making Gamemode 0.1    |
|     -------------------------    |
|               By Lj              |
|                                  |
|               v0.1               |
====================================

*
* By Lj
* v 0.1 - 2008

* You can edit certain things and indentation or whatever.
* But do not remove credits. You may MOVE them, but not delete them or claim as
* your own.

* Credits to:
* - Seif (animation system)
* - GTA44 (letterbox)
* - Simon (debug)
* - Reaction test creator.*/

#include <a_samp>
#include <dudb>
#include <dutils>
#include <callback>
#include <core>
#include <float>
#pragma tabsize 0 // (Un)Mark this if you want PAWNO to ignore/recognize indentation.

// REACTION TEST
#define time1 240000 //this is the 4 minute minimum gap time
#define time2 180000 // this is the 3 minute max addon time

new reactionstr[9]; // randomly generated string
new reactioninprog; // what status the reactiontest is at
new reactionwinnerid; // id of the current reactiontest winner
new reactiongap; // timer to restart ReactionTest()

forward ReactionTest();
forward ReactionWin(playerid);
forward SetBack();
// END OF REACTION TEST

// ADMINS SPAWN IN CALIGULAS IF TRUE
#define ADMSPAWNCHANGE     false
// END OF ADMIN SPAWN CHANGE OPTION

//====================================[DCMD]====================================
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

stock PlayerName(playerid) {
	new name[255];
	GetPlayerName(playerid, name, 255);
	return name;
}
//===================================[Forwards]=================================
forward IsPlayerxGAdmin(playerid);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward IsTutPasser(playerid);
forward SendClientMessageToAdmins(color,const string[]);
forward STut2(playerid);
forward STut3(playerid);
forward STut4(playerid);
forward STut5(playerid);
forward STut6(playerid);
forward STut7(playerid);
forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);
forward ProxDetectorS(Float:radi, playerid, targetid);
forward VehicleReset();
forward OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid);

#define SPECIAL_ACTION_PISSING      68
new gPlayerUsingLoopingAnim[MAX_PLAYERS];
new gPlayerAnimLibsPreloaded[MAX_PLAYERS];
new animation[200];

new gNameTags[MAX_PLAYERS];

new CanTele[MAX_PLAYERS];

new Text:lbt;
new Text:lbb;
new Text:site;
new Text:txtAnimHelper;

new BigEar[MAX_PLAYERS];
new IsLoggedIn[MAX_PLAYERS];
new Admin[MAX_PLAYERS];
new TutorialPassed[MAX_PLAYERS];
new TunedSultan;

forward SpawnVehicles();

forward TurnOffGod(playerid);

new gClass[MAX_PLAYERS];

forward RandPlayer1();

forward SetRandomWeather();

enum weather_info
{
	wt_id,
	wt_text[255]
};
new gRandomWeatherIDs[][weather_info] =
{
	{0,"Blue Sky"},
	{1,"Blue Sky"},
	{2,"Blue Sky"},
	{3,"Blue Sky"},
	{4,"Blue Sky"},
	{5,"Blue Sky"},
	{6,"Blue Sky"},
	{7,"Blue Sky"},
	{08,"Stormy"},
	{09,"Foggy"},
	{10,"Blue Sky"},
	{11,"Heatwave"},
	{17,"Heatwave"},
	{18,"Heatwave"},
	{12,"Dull"},
	{13,"Dull"},
	{14,"Dull"},
	{15,"Dull"},
	{16,"Dull & Rainy"},
	{19,"Sandstorm"},
	{20,"Smog"},
	{21,"Dark & Purple"},
	{22,"Black & Purple"},
	{23,"Pale Orange"},
	{24,"Pale Orange"},
	{25,"Pale Orange"},
	{26,"Pale Orange"},
	{27,"Fresh Blue"},
	{28,"Fresh Blue"},
	{29,"Fresh Blue"},
	{30,"Smog"},
	{31,"Smog"},
	{32,"Smog"},
	{33,"Dark"},
	{34,"Regular Purple"},
	{35,"Dull Brown"},
	{36,"Bright & Foggy"},
	{37,"Bright & Foggy"},
	{38,"Bright & Foggy"},
	{39,"Very Bright"},
	{40,"Blue & Cloudy"},
	{41,"Blue & Cloudy"},
	{42,"Blue & Cloudy"},
	{43,"Toxic"},
	{44,"Black Sky"},
	{700,"Weed Effect"},
	{150,"Darkest Weather Ever"}
};

new Float:gRandomPlayerSpawns[3][4] = {
	{110.2912,1103.9667,13.6094,178.7433},
	{109.0393,1034.9540,13.6094,3.6117},
	{136.0030,1061.9857,13.6094,84.1391}
};

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
#define COLOR_LIGHTBLUE 0x01FCFFC8
#define COLOR_LIGHTGREEN 0x9ACD32AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_YELLOW2 0xF5DEB3AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_FADE1 0xE6E6E6E6
#define COLOR_FADE2 0xC8C8C8C8
#define COLOR_FADE3 0xAAAAAAAA
#define COLOR_FADE4 0x8C8C8C8C
#define COLOR_FADE5 0x6E6E6E6E
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_INVIS 0xAFAFAF00
#define COLOR_SPEC 0xBFC0C200
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_BRIGHTRED 0xFF0000AA
#define COLOR_INDIGO 0x4B00B0AA
#define COLOR_VIOLET 0x9955DEEE
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_SEAGREEN 0x00EEADDF
#define COLOR_GRAYWHITE 0xEEEEFFC4
#define COLOR_LIGHTNEUTRALBLUE 0xabcdef66
#define COLOR_GREENISHGOLD 0xCCFFDD56
#define COLOR_LIGHTBLUEGREEN 0x0FFDD349
#define COLOR_NEUTRALBLUE 0xABCDEF01
#define COLOR_LIGHTCYAN 0xAAFFCC33
#define COLOR_LEMON 0xDDDD2357
#define COLOR_MEDIUMBLUE 0x63AFF00A
#define COLOR_NEUTRAL 0xABCDEF97
#define COLOR_BLACK 0x00000000
#define COLOR_NEUTRALGREEN 0x81CFAB00
#define COLOR_DARKGREEN 0x12900BBF
#define COLOR_DARKBLUE 0x300FFAAB
#define COLOR_BLUEGREEN 0x46BBAA00
#define COLOR_PINK 0xFF66FFAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_RED1 0xFF0000AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BROWN 0x993300AA
#define COLOR_CYAN 0x99FFFFAA
#define COLOR_TAN 0xFFFFCCAA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_KHAKI 0x999900AA
#define COLOR_LIME 0x99FF00AA
#define COLOR_SYSTEM 0xEFEFF7AA
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD6 0xF0F0F0FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_AQUA 0x33CCFFAA
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD6 0xF0F0F0FF

main()
{
	print("\r\n====================================");
	print("|                                  |");
	print("|     Movie Making Gamemode 0.1    |");
	print("|     -------------------------    |");
	print("|               By Lj              |");
	print("|                                  |");
	print("|               v0.1               |");
	print("====================================\r\n");
}

public OnGameModeInit()
{
	SetGameModeText("XtremeGaming Filming & Movie Making");
	ShowNameTags(0);
	ShowPlayerMarkers(1);
	EnableStuntBonusForAll(0);
	EnableZoneNames(0);
	AllowInteriorWeapons(1);
	EnableTirePopping(1);
	SetTimer("SetRandomWeather",7550000,1);
	SetTimer("RandPlayer1",1500000,1);
	SetTimer("ReactionTest",time1+random(time2),0);
	
	AddPlayerClass(280,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //0 -
	AddPlayerClass(281,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //1 -
	AddPlayerClass(282,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //2 -
	AddPlayerClass(283,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //3 -
	AddPlayerClass(284,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //4 -
	AddPlayerClass(285,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //5 -
	AddPlayerClass(286,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //6 -
	AddPlayerClass(287,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //7 -
	
	AddPlayerClass(254,1958.3783,1343.1572,15.3746,0.0,0,0,24,300,-1,-1);      //8
	AddPlayerClass(255,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //9 -
	AddPlayerClass(256,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //10 -
	AddPlayerClass(257,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //11 -
	AddPlayerClass(258,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //12 -
	AddPlayerClass(259,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //13 -
	AddPlayerClass(260,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //14 -
	AddPlayerClass(261,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //15
	AddPlayerClass(262,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //16
	AddPlayerClass(263,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //17
	AddPlayerClass(264,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //18 -
	AddPlayerClass(274,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //19 -
	AddPlayerClass(275,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //20 -
	AddPlayerClass(276,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //21 -
	
	AddPlayerClass(1,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //22 -
	AddPlayerClass(2,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //23
	AddPlayerClass(290,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //24
	AddPlayerClass(291,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //25
	AddPlayerClass(292,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //26
	AddPlayerClass(293,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //27
	AddPlayerClass(294,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //28
	AddPlayerClass(295,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //29
	AddPlayerClass(296,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //30 -
	AddPlayerClass(297,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //31
	AddPlayerClass(298,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //32
	AddPlayerClass(299,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //33
	
	AddPlayerClass(277,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //34 -
	AddPlayerClass(278,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //35 -
	AddPlayerClass(279,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //36 -
	AddPlayerClass(288,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //37
	AddPlayerClass(47,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //38
	AddPlayerClass(48,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //39
	AddPlayerClass(49,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //40
	AddPlayerClass(50,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //41
	AddPlayerClass(51,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //42
	AddPlayerClass(52,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //43
	AddPlayerClass(53,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //44
	AddPlayerClass(54,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //45
	AddPlayerClass(55,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //46
	AddPlayerClass(56,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //47
	AddPlayerClass(57,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //48
	AddPlayerClass(58,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //49
	AddPlayerClass(59,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //50
	AddPlayerClass(60,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //51
	AddPlayerClass(61,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //52 -
	AddPlayerClass(62,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //53
	AddPlayerClass(63,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //54 -
	AddPlayerClass(64,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //55 -
	AddPlayerClass(66,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //56
	AddPlayerClass(67,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //57
	AddPlayerClass(68,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //58
	AddPlayerClass(69,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //59
	AddPlayerClass(70,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //60
	AddPlayerClass(71,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //61
	AddPlayerClass(72,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //62
	AddPlayerClass(73,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //63
	AddPlayerClass(75,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //64 -
	AddPlayerClass(76,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //65
	AddPlayerClass(78,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //66 -
	AddPlayerClass(79,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //67 -
	AddPlayerClass(80,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //68 -
	AddPlayerClass(81,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //69 -
	AddPlayerClass(82,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //70 -
	AddPlayerClass(83,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //71 -
	AddPlayerClass(84,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //72 -
	AddPlayerClass(85,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //73 -
	AddPlayerClass(87,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //74 -
	AddPlayerClass(88,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //75
	AddPlayerClass(89,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //76
	AddPlayerClass(91,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //77
	AddPlayerClass(92,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //78 -
	AddPlayerClass(93,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //79 -
	AddPlayerClass(95,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //80
	AddPlayerClass(96,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //81
	AddPlayerClass(97,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //82 -
	AddPlayerClass(98,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //83
	AddPlayerClass(99,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //84
	AddPlayerClass(100,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //85
	AddPlayerClass(101,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //86
	AddPlayerClass(102,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //87 -
	AddPlayerClass(103,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //88 -
	AddPlayerClass(104,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //89 -
	AddPlayerClass(105,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //90 -
	AddPlayerClass(106,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //91 -
	AddPlayerClass(107,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //92 -
	AddPlayerClass(108,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //93 -
	AddPlayerClass(109,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //94 -
	AddPlayerClass(110,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //95 -
	AddPlayerClass(111,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //96
	AddPlayerClass(112,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //97
	AddPlayerClass(113,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //98
	AddPlayerClass(114,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //99 -
	AddPlayerClass(115,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //100 -
	AddPlayerClass(116,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //101 -
	AddPlayerClass(117,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //102
	AddPlayerClass(118,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //103
	AddPlayerClass(120,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //104
	AddPlayerClass(121,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //105
	AddPlayerClass(122,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //106 -
	AddPlayerClass(123,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //107
	AddPlayerClass(124,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //108
	AddPlayerClass(125,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //109
	AddPlayerClass(126,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //110
	AddPlayerClass(127,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //111
	AddPlayerClass(128,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //112
	AddPlayerClass(129,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //113
	AddPlayerClass(131,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //114
	AddPlayerClass(133,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //115
	AddPlayerClass(134,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //116
	AddPlayerClass(135,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //117
	AddPlayerClass(136,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //118
	AddPlayerClass(137,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //119 -
	AddPlayerClass(138,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //120 -
	AddPlayerClass(139,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //121 -
	AddPlayerClass(140,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //122 -
	AddPlayerClass(141,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //123
	AddPlayerClass(142,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //124
	AddPlayerClass(143,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //125
	AddPlayerClass(144,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //126 -
	AddPlayerClass(145,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //127 -
	AddPlayerClass(146,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //128 -
	AddPlayerClass(147,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //129
	AddPlayerClass(148,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //130
	AddPlayerClass(150,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //131
	AddPlayerClass(151,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //132
	AddPlayerClass(152,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //133 -
	AddPlayerClass(153,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //134
	AddPlayerClass(154,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //135 -
	AddPlayerClass(155,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //136
	AddPlayerClass(156,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //137
	AddPlayerClass(157,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //138 -
	AddPlayerClass(158,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //139 -
	AddPlayerClass(159,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //140 -
	AddPlayerClass(160,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //141 -
	AddPlayerClass(161,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //142 -
	AddPlayerClass(162,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //143 -
	AddPlayerClass(163,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //144 -
	AddPlayerClass(164,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //145 -
	AddPlayerClass(165,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //146 -
	AddPlayerClass(166,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //147 -
	AddPlayerClass(167,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //148 -
	AddPlayerClass(168,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //149
	AddPlayerClass(169,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //150
	AddPlayerClass(170,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //151
	AddPlayerClass(171,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //152
	AddPlayerClass(172,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //153
	AddPlayerClass(173,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //154 -
	AddPlayerClass(174,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //155 -
	AddPlayerClass(175,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //156 -
	AddPlayerClass(176,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //157
	AddPlayerClass(177,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //158
	AddPlayerClass(178,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //159 -
	AddPlayerClass(179,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //160 -
	AddPlayerClass(180,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //161
	AddPlayerClass(181,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //162
	AddPlayerClass(182,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //163
	AddPlayerClass(183,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //164
	AddPlayerClass(184,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //165
	AddPlayerClass(185,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //166
	AddPlayerClass(186,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //167
	AddPlayerClass(187,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //168
	AddPlayerClass(188,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //169
	AddPlayerClass(189,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //170
	AddPlayerClass(190,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //171
	AddPlayerClass(191,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //172
	AddPlayerClass(192,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //173
	AddPlayerClass(193,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //174
	AddPlayerClass(194,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //175
	AddPlayerClass(195,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //176
	AddPlayerClass(196,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //177
	AddPlayerClass(197,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //178
	AddPlayerClass(198,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //179
	AddPlayerClass(199,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //180
	AddPlayerClass(200,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //181
	AddPlayerClass(201,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //182
	AddPlayerClass(202,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //183
	AddPlayerClass(203,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //184 -
	AddPlayerClass(204,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //185 -
	AddPlayerClass(205,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //186 -
	AddPlayerClass(206,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //187
	AddPlayerClass(207,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //188
	AddPlayerClass(209,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //189
	AddPlayerClass(210,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //190
	AddPlayerClass(211,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //191
	AddPlayerClass(212,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //192
	AddPlayerClass(213,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //193 -
	AddPlayerClass(214,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //194
	AddPlayerClass(215,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //195
	AddPlayerClass(216,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //196
	AddPlayerClass(217,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //197
	AddPlayerClass(218,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //198
	AddPlayerClass(219,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //199
	AddPlayerClass(220,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //200
	AddPlayerClass(221,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //201
	AddPlayerClass(222,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //202
	AddPlayerClass(223,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //203
	AddPlayerClass(224,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //204
	AddPlayerClass(225,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //205
	AddPlayerClass(226,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //206
	AddPlayerClass(227,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //207
	AddPlayerClass(228,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //208
	AddPlayerClass(229,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //209 -
	AddPlayerClass(230,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //210 -
	AddPlayerClass(231,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //211
	AddPlayerClass(232,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //212
	AddPlayerClass(233,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //213
	AddPlayerClass(234,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //214
	AddPlayerClass(235,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //215
	AddPlayerClass(236,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //216
	AddPlayerClass(237,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //217
	AddPlayerClass(238,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //218
	AddPlayerClass(239,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //219
	AddPlayerClass(240,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //220
	AddPlayerClass(241,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //221 -
	AddPlayerClass(242,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //222 -
	AddPlayerClass(243,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //223
	AddPlayerClass(244,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //224
	AddPlayerClass(245,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //225
	AddPlayerClass(246,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //226 -
	AddPlayerClass(247,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //227
	AddPlayerClass(248,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //228
	AddPlayerClass(249,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //229 -
	AddPlayerClass(250,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //230
	AddPlayerClass(251,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //231
	AddPlayerClass(253,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //232 -
	
	SpawnVehicles();
	
	lbt = TextDrawCreate(-1.000000,2.000000,"---");
	lbb = TextDrawCreate(0.000000,337.000000,"---");
	TextDrawUseBox(lbt,1);
	TextDrawBoxColor(lbt,0x000000ff);
	TextDrawTextSize(lbt,640.000000,-69.000000);
	TextDrawUseBox(lbb,1);
	TextDrawBoxColor(lbb,0x000000ff);
	TextDrawTextSize(lbb,638.000000,-60.000000);
	TextDrawAlignment(lbt,0);
	TextDrawAlignment(lbb,0);
	TextDrawBackgroundColor(lbt,0x000000ff);
	TextDrawBackgroundColor(lbb,0x000000ff);
	TextDrawFont(lbt,3);
	TextDrawLetterSize(lbt,1.000000,12.199999);
	TextDrawFont(lbb,3);
	TextDrawLetterSize(lbb,0.899999,15.000000);
	TextDrawColor(lbt,0x000000ff);
	TextDrawColor(lbb,0x000000ff);
	TextDrawSetOutline(lbt,1);
	TextDrawSetOutline(lbb,1);
	TextDrawSetProportional(lbt,1);
	TextDrawSetProportional(lbb,1);
	TextDrawSetShadow(lbt,1);
	TextDrawSetShadow(lbb,1);
	
	/*site = TextDrawCreate(397.000000,433.000000,"...Www.MyUrl.Domain...");
	TextDrawAlignment(site,0);
	TextDrawBackgroundColor(site,0x000000ff);
	TextDrawFont(site,3);
	TextDrawLetterSize(site,0.499999,1.300000);
	TextDrawColor(site,0xff0000ff);
	TextDrawSetOutline(site,1);
	TextDrawSetProportional(site,1);
	TextDrawSetShadow(site,10);*/
	
	txtAnimHelper = TextDrawCreate(610.0, 400.0,"~b~~k~~PED_LOCK_TARGET~ ~w~to stop the animation");
	TextDrawUseBox(txtAnimHelper, 0);
	TextDrawFont(txtAnimHelper, 2);
	TextDrawSetShadow(txtAnimHelper,0);
	TextDrawSetOutline(txtAnimHelper,1);
	TextDrawBackgroundColor(txtAnimHelper,0x000000FF);
	TextDrawColor(txtAnimHelper,0xFFFFFFFF);
	TextDrawAlignment(txtAnimHelper,3);
	return 1;
}

public SpawnVehicles()
{
	CreateVehicle(519,1994.9323,-2382.0054,14.4658,90.0037,1,1,120); // Airport Los Santos Shamal Right Hut
	CreateVehicle(519,1994.9546,-2315.3472,14.4667,88.2649,1,1,120); // Airport Los Santos Shamal Left Hut
	CreateVehicle(593,1889.7015,-2633.9937,14.0048,359.4117,58,8,120); // Airport Los Santos Dodo Hut 1
	CreateVehicle(593,1823.3164,-2633.8579,14.0160,359.6669,60,1,120); // Airport Los Santos Dodo Hut 2
	CreateVehicle(593,1754.7069,-2633.9275,14.0164,359.0330,68,8,120); // Airport Los Santos Dodo Hut 3
	CreateVehicle(593,1683.1578,-2633.8960,14.0153,0.9723,2,1,120); // Airport Los Santos Dodo Hut 5
	CreateVehicle(593,1616.5552,-2633.9609,14.0291,1.2908,13,8,120); // Airport Los Santos Dodo Hut 6
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	gClass[playerid] = classid;
	PlayerPlaySound(playerid,1076,0.0,0.0,0.0);
	SetPlayerInterior(playerid,0);
	SetPlayerPos(playerid,-1657.5282,1216.2549,13.6719);
	SetPlayerFacingAngle(playerid,131.4834);
	SetPlayerCameraPos(playerid,-1658.8103,1214.8969,13.6719);
	SetPlayerCameraLookAt(playerid,-1657.5282,1216.2549,13.6719);
	SetPlayerVirtualWorld(playerid,1);
	/*TextDrawShowForPlayer(playerid,site);*/
	CanTele[playerid] = 0;
	switch(gClass[playerid])
	{
		case 0..232:
		{
			OnePlayAnim(playerid,"GANGS","shake_cara",4.0,0,0,0,0,0);
		}
	}
	return 1;
}

public OnGameModeExit()
{
	TextDrawHideForAll(lbt);
	TextDrawHideForAll(lbb);
	TextDrawDestroy(lbt);
	TextDrawDestroy(lbb);
	/*TextDrawHideForAll(site);
	TextDrawDestroy(site);*/
	TextDrawHideForAll(txtAnimHelper);
	TextDrawDestroy(txtAnimHelper);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		SetPlayerColor(i, COLOR_LIGHTRED);
	}
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(!strcmp(text, reactionstr, false))
	{
		if(reactioninprog == 2) ReactionWin(playerid);
		if(reactioninprog == 1)
		{
			if(reactionwinnerid == playerid)
			{
				SendClientMessage(playerid, COLOR_GRAD2, "You have already Won the Reaction Test.");
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD2, "Too slow! Somebody has already won the Reaction Test.");
			}
		}
		return 1;
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	IsLoggedIn[playerid]=false;
	gPlayerUsingLoopingAnim[playerid] = 0;
	gPlayerAnimLibsPreloaded[playerid] = 0;
	SendDeathMessage(INVALID_PLAYER_ID,playerid,200);
	new Player[24];
	GetPlayerName(playerid, Player, sizeof(Player));
	new string[128];
	format(string, sizeof(string), "xGBot: %s(%d) has joined the server.", Player, playerid);
	SendClientMessageToAll(COLOR_GREY, string);
	SetPlayerColor(playerid, COLOR_SPEC);
	gNameTags[playerid] = 1;
	for(new i; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && gNameTags[i] == 0)
		{
			ShowPlayerNameTagForPlayer(i, playerid, 0);
		}
	}
	if (!udb_Exists(PlayerName(playerid)))
	{
		return SendClientMessage(playerid, COLOR_YELLOW, "You are not registered with the [xG] Filming server. Register first with /register [password]");
	}
	if (udb_Exists(PlayerName(playerid)))
	{
		return SendClientMessage(playerid, COLOR_YELLOW, "Welcome back to the [xG] Filming server, login now with /login [password]");
	}
	return false;
}

public OnPlayerDisconnect(playerid,reason)
{
	TextDrawHideForPlayer(playerid,lbt);
	TextDrawHideForPlayer(playerid,lbb);
	SendDeathMessage(INVALID_PLAYER_ID,playerid,201);
	new PlayerN[24];
	new string[128];
	GetPlayerName(playerid, PlayerN, sizeof(PlayerN));
	gNameTags[playerid] = 0;
	switch (reason)
	{
		case 0:
		{
			format(string, sizeof(string), "xGBot: %s has left the server. (Crashed)", PlayerN);
			SendClientMessageToAll(COLOR_GREY, string);
		}
		case 1:
		{
			format(string, sizeof(string), "xGBot: %s has left the server. (Left)", PlayerN);
			SendClientMessageToAll(COLOR_GREY, string);
		}
		case 2:
		{
			format(string, sizeof(string), "xGBot: %s has left the server. (Owned)", PlayerN);
			SendClientMessageToAll(COLOR_GREY, string);
		}
	}
	if(IsLoggedIn[playerid])
	{
		dUserSetINT(PlayerName(playerid)).("Cash",GetPlayerMoney(playerid));
		dUserSetINT(PlayerName(playerid)).("Admin",IsPlayerxGAdmin(playerid));
		dUserSetINT(PlayerName(playerid)).("Tutorial",IsTutPasser(playerid));
	}
	IsLoggedIn[playerid]=0;
	return false;
}

public OnPlayerSpawn(playerid)
{
	PlayerPlaySound(playerid,1077,0.0,0.0,0.0);
	SetCameraBehindPlayer(playerid);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
	SetPlayerHealth(playerid,99999.0);
	SetTimerEx("TurnOffGod", 5000, false, "i", playerid);
	SetPlayerVirtualWorld(playerid, 0);
	/*TextDrawHideForPlayer(playerid,site);*/
	SetPlayerColor(playerid, COLOR_ORANGE);
	if(!gPlayerAnimLibsPreloaded[playerid])
	{
		PreloadAnimLib(playerid,"BOMBER");
		PreloadAnimLib(playerid,"RAPPING");
		PreloadAnimLib(playerid,"SHOP");
		PreloadAnimLib(playerid,"BEACH");
		PreloadAnimLib(playerid,"SMOKING");
		PreloadAnimLib(playerid,"FOOD");
		PreloadAnimLib(playerid,"ON_LOOKERS");
		PreloadAnimLib(playerid,"DEALER");
		PreloadAnimLib(playerid,"CRACK");
		PreloadAnimLib(playerid,"CARRY");
		PreloadAnimLib(playerid,"COP_AMBIENT");
		PreloadAnimLib(playerid,"PARK");
		PreloadAnimLib(playerid,"INT_HOUSE");
		PreloadAnimLib(playerid,"FOOD");
		PreloadAnimLib(playerid,"PED");
		gPlayerAnimLibsPreloaded[playerid] = 1;
	}
	if(!IsLoggedIn[playerid])
	{
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "** YOU HAVE BEEN AUTOMATICLY KICKED FOR NOT LOGGING IN! **");
		Kick(playerid);
		new PlayerN[24];
		new string[128];
		GetPlayerName(playerid, PlayerN, sizeof(PlayerN));
		format(string, sizeof(string), "xGBot: %s has left the server. (Auto-Kicked)", PlayerN);
		SendClientMessageToAll(COLOR_GREY, string);
		CanTele[playerid] = 0;
	}
	if(IsLoggedIn[playerid])
	{
		new rand = random(sizeof(gRandomPlayerSpawns));
		GivePlayerMoney(playerid,dUserINT(PlayerName(playerid)).("Cash")-GetPlayerMoney(playerid));
		SetPlayerPos(playerid, gRandomPlayerSpawns[rand][0], gRandomPlayerSpawns[rand][1], gRandomPlayerSpawns[rand][2]);
		CanTele[playerid] = 1;
	}
	if(IsLoggedIn[playerid])
	{
		if(Admin[playerid] > 0)
		{
			#if ADMSPAWNCHANGE == true
			SetPlayerInterior(playerid, 1);
			SetPlayerPos(playerid, 2164.8708,1604.9115,999.9767);
			SetPlayerFacingAngle(playerid, 120.1294);
			SetCameraBehindPlayer(playerid);
			#endif
			SetPlayerSkin(playerid, 294);
			SetPlayerColor(playerid, COLOR_YELLOW);
			SetPlayerArmour(playerid, 100);
		}
	}
	if(TutorialPassed[playerid] < 1) // Nope.
	{
		if(IsPlayerConnected(playerid))
		{
			SetPlayerInterior(playerid,3);
			SetPlayerPos(playerid,1496.7031,1306.3666,1093.2891);
			SetPlayerFacingAngle(playerid,270.4583);
			GameTextForPlayer(playerid, "~w~-Guides", 1000, 1);
			PlayerPlaySound(playerid,1052,0,0,0);
			SendClientMessage(playerid, COLOR_YELLOW, "____-Tutorial Part One: The Server-____");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "NOTE: This is not Roleplay or Deathmatch.");
			SendClientMessage(playerid, COLOR_YELLOW2, "Hello and Welcome to [xG] Xtreme Gaming Filming server. Where you can record your favourite");
			SendClientMessage(playerid, COLOR_YELLOW2, "movies without any trouble at all. This tutorial has five parts so don't think this will");
			SendClientMessage(playerid, COLOR_YELLOW2, "go on forever. Because I can assure you. It won't.");
			SetTimerEx("STut2", 11000, 0, "i", playerid);
			TogglePlayerControllable(playerid,0);
			SetCameraBehindPlayer(playerid);
			/*TextDrawShowForPlayer(playerid,site);*/
			CanTele[playerid] = 0;
		}
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	SendDeathMessage(killerid, playerid, reason);
	dUserSetINT(PlayerName(playerid)).("Cash",GetPlayerMoney(playerid));
	SetPlayerColor(playerid, COLOR_RED);
	if(gPlayerUsingLoopingAnim[playerid])
	{
		gPlayerUsingLoopingAnim[playerid] = 0;
		TextDrawHideForPlayer(playerid,txtAnimHelper);
	}
	return 1;
}

dcmd_login(playerid, params[])
{
	#pragma unused params
	if (IsLoggedIn[playerid])
	{
		return SendClientMessage(playerid, COLOR_GRAD2, "You are already logged in.");
	}
	if (!udb_Exists(PlayerName(playerid)))
	{
		return SendClientMessage(playerid, COLOR_GRAD2, "You are not registered with the server. Register first with /register [password]");
	}
	if (strlen(params)==0)
	{
		return SendClientMessage(playerid, COLOR_GRAD1, "Usage: /login [password]");
	}
	if (udb_CheckLogin(PlayerName(playerid),params))
	{
		Admin[playerid]=dUserINT(PlayerName(playerid)).("Admin");
		TutorialPassed[playerid] = dUserINT(PlayerName(playerid)).("Tutorial");
		IsLoggedIn[playerid]=1;
		return SendClientMessage(playerid, COLOR_YELLOW2, "You are now logged in.");
	}
	return SendClientMessage(playerid, COLOR_GRAD2, "That password is incorrect. Please try again.");
}

dcmd_logout(playerid, params[])
{
	#pragma unused params
	if (!IsLoggedIn[playerid])
	{
		return SendClientMessage(playerid, COLOR_GRAD2, "You are already logged out or didn't login in the first place.");
	}
	if (!udb_Exists(PlayerName(playerid)))
	{
		return SendClientMessage(playerid, COLOR_GRAD2, "You cannot logout if you arn't even registered.");
	}
	if (IsLoggedIn[playerid])
	{
		dUserSetINT(PlayerName(playerid)).("Cash",GetPlayerMoney(playerid));
		dUserSetINT(PlayerName(playerid)).("Admin",IsPlayerxGAdmin(playerid));
		dUserSetINT(PlayerName(playerid)).("Tutorial",IsTutPasser(playerid));
		IsLoggedIn[playerid]=0;
		return SendClientMessage(playerid, COLOR_YELLOW2, "You are now logged out. To log back in type /login [password]");
	}
	return 1;
}

dcmd_register(playerid,params[])
{
	#pragma unused params
	if (IsLoggedIn[playerid])
	{
		return SendClientMessage(playerid, COLOR_GRAD2, "You are already registered with the server and logged in.");
	}
	if (udb_Exists(PlayerName(playerid)))
	{
		return SendClientMessage(playerid, COLOR_GRAD2, "You are already registered, login with /login [password]");
	}
	if (strlen(params)==0)
	{
		return SendClientMessage(playerid, COLOR_GRAD1, "Usage: /register [password]");
	}
	if (udb_Create(PlayerName(playerid),params))
	{
		dUserSet(PlayerName(playerid)).("Cash", "1000");
		dUserSet(PlayerName(playerid)).("Admin", "0");
		dUserSet(PlayerName(playerid)).("Tutorial", "0");
		IsLoggedIn[playerid]=1;
		return SendClientMessage(playerid, COLOR_YELLOW2, "You have successfully registered, you are now logged in.");
	}
	return 1;
}

public OnPlayerCommandText(playerid,cmdtext[])
{
	dcmd(login,5,cmdtext);
	dcmd(logout,6,cmdtext);
	dcmd(register,8,cmdtext);
	
	new cmd[256];
	new idx;
	new tmp[256];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];
	new dancestyle;
	cmd = strtok(cmdtext, idx);
	new giveplayerid;
	new string[MAX_STRING];
	
	// === [Kick] ===
    if(strcmp(cmd,"/kick",true) == 0)
    {
		tmp = strtok(cmdtext, idx);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD1, "Usage: /kick [playerid] [reason]");
			return 1;
		}
		giveplayerid = strval(tmp);
		if (IsLoggedIn[playerid])
	    {
			if(Admin[playerid] > 0)
		    {
				if(IsPlayerConnected(giveplayerid))
				{
					new length = strlen(cmdtext);
					while ((idx < length) && (cmdtext[idx] <= ' ')) {
					idx++;
					}
					new offset = idx;
					new result[64];
					while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))) {
					result[idx - offset] = cmdtext[idx];
					idx++;
					}
					result[idx - offset] = EOS;
					if(!strlen(result))
					{
						SendClientMessage(playerid, COLOR_GRAD2, "You must include a reason to kick.");
					}
					else
					{
						GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						format(string, sizeof(string), "AdmCmd: %s has been kicked by %s. [reason: %s]", giveplayer, sendername, result);
						SendClientMessageToAll(COLOR_LIGHTRED, string);
						Kick(giveplayerid);
					}
				}
				else
				{
				    format(string, sizeof(string), "ID: %d does not belong to an active player.", giveplayerid);
					SendClientMessage(playerid, COLOR_GRAD2, string);
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD2, "You do not have permission to use that command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GRAD2, "You must be logged in.");
		}
		return 1;
	}

	// === [Ban] ===
    if(strcmp(cmd,"/ban",true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD1, "Usage: /ban [playerid] [reason]");
			return 1;
		}
		giveplayerid = strval(tmp);
		if (IsLoggedIn[playerid])
	    {
			if(Admin[playerid] > 1)
		    {
				if(IsPlayerConnected(giveplayerid))
				{
					new length = strlen(cmdtext);
					while ((idx < length) && (cmdtext[idx] <= ' ')) {
					idx++;
					}
					new offset = idx;
					new result[64];
					while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))) {
					result[idx - offset] = cmdtext[idx];
					idx++;
					}
					result[idx - offset] = EOS;
					if(!strlen(result))
					{
						SendClientMessage(playerid, COLOR_GRAD2, "You must include a reason to ban.");
					}
					else
					{
						GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						format(string, sizeof(string), "AdmCmd: %s has been banned by %s. [reason: %s]", giveplayer, sendername, result);
						SendClientMessageToAll(COLOR_LIGHTRED, string);
						BanEx(giveplayerid, result);
					}
				}
				else
				{
				    format(string, sizeof(string), "ID: %d does not belong to an active player.", giveplayerid);
					SendClientMessage(playerid, COLOR_GRAD2, string);
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD2, "You do not have permission to use that command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GRAD2, "You must be logged in.");
		}
		return 1;
	 }

	 // === [Back2Tut] ===
    if(strcmp(cmd,"/learn",true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD1, "Usage: /learn [playerid] [reason]");
			return 1;
		}
		giveplayerid = strval(tmp);
		if (IsLoggedIn[playerid])
	    {
			if(Admin[playerid] > 1)
		    {
				if(IsPlayerConnected(giveplayerid))
				{
					new length = strlen(cmdtext);
					while ((idx < length) && (cmdtext[idx] <= ' ')) {
					idx++;
					}
					new offset = idx;
					new result[64];
					while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))) {
					result[idx - offset] = cmdtext[idx];
					idx++;
					}
					result[idx - offset] = EOS;
					if(!strlen(result))
					{
						SendClientMessage(playerid, COLOR_GRAD2, "You must include a reason to send somebody back to the tutorial.");
					}
					else
					{
						GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						format(string, sizeof(string), "AdmCmd: %s has been sent back to the tutorial by %s. [reason: %s]", giveplayer, sendername, result);
						SendClientMessageToAll(COLOR_LIGHTRED, string);
						TutorialPassed[giveplayerid] = 0;
						dUserSet(PlayerName(giveplayerid)).("Tutorial", "0");
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "* YOU HAVE BEEN AUTOMATICLY KICKED BY ''ADMCMD''. PLEASE RECONNECT *");
						Kick(giveplayerid);
					}
				}
				else
				{
				    format(string, sizeof(string), "ID: %d does not belong to an active player.", giveplayerid);
					SendClientMessage(playerid, COLOR_GRAD2, string);
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD2, "You do not have permission to use that command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GRAD2, "You must be logged in.");
		}
		return 1;
	 }

	if(strcmp(cmd,"/goto",true) == 0)
	{
	    if(Admin[playerid] > 0)
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "Usage: /goto [playerid/PartOfName]");
				return 1;
			}
			new Float:plocx,Float:plocy,Float:plocz;
			new plo;
			plo = strval(tmp);
			if (IsPlayerConnected(plo))
			{
			    if(plo != INVALID_PLAYER_ID)
			    {
					if (Admin[playerid] >= 1)
					{
						GetPlayerPos(plo, plocx, plocy, plocz);
						GetPlayerInterior(plo);
						if (GetPlayerState(playerid) == 2)
						{
							new tmpcar = GetPlayerVehicleID(playerid);
							SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
						}
						else
						{
							SetPlayerPos(playerid,plocx,plocy+2, plocz);
							SetPlayerInterior(playerid, GetPlayerInterior(plo));
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_GRAD2, "You do not have permission to use that command.");
					}
				}
			}
			else
			{
				format(string, sizeof(string), "ID: %d does not belong to an active player.", giveplayerid);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
		}
		return 1;
	}

	if(strcmp(cmd,"/gethere",true) == 0)
	{
	    if(Admin[playerid] > 0)
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "Usage: /gethere [playerid/PartOfName]");
				return 1;
			}
			new Float:plocx,Float:plocy,Float:plocz;
			new plo;
			plo = strval(tmp);
			if (IsPlayerConnected(plo))
			{
			    if(plo != INVALID_PLAYER_ID)
			    {
					if (Admin[playerid] >= 1)
					{
						GetPlayerPos(playerid, plocx, plocy, plocz);
						GetPlayerInterior(playerid);
						if (GetPlayerState(plo) == 2)
						{
							SendClientMessage(playerid, COLOR_GRAD2, "You cannot teleport somebody that is in a vehicle.");
						}
						else
						{
							SetPlayerPos(plo,plocx,plocy+2, plocz);
							SetPlayerInterior(plo, GetPlayerInterior(playerid));
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_GRAD2, "You do not have permission to use that command.");
					}
				}
			}
			else
			{
				format(string, sizeof(string), "ID: %d does not belong to an active player.", giveplayerid);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
		}
		return 1;
	}

	// === [Vehicle Clear] ===
	if(strcmp(cmd,"/vclear",true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    tmp = strtok(cmdtext, idx);
		if(IsLoggedIn[playerid] == 1)
		{
			if(Admin[playerid] > 2)
		    {
					format(string, sizeof(string), "AdmCmd: %s has set all previously used vehicles to clear in 10 seconds.", sendername);
					SendClientMessageToAll(COLOR_LIGHTRED, string);
					SetTimer("VehicleReset",10000,0);
					/*TextDrawShowForAll(site);*/
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD2, "You do not have permission to use that command.");
			}
		}
		else
		{
            SendClientMessage(playerid, COLOR_GRAD2, "You must be logged in.");
		}
		return 1;
	}

	// === [ReactionTest] ===
	if(strcmp(cmd,"/reaction",true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    tmp = strtok(cmdtext, idx);
		if(IsLoggedIn[playerid] == 1)
		{
			if(Admin[playerid] > 0)
		    {
					ReactionTest();
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD2, "You do not have permission to use that command.");
			}
		}
		else
		{
            SendClientMessage(playerid, COLOR_GRAD2, "You must be logged in.");
		}
		return 1;
	}
	
	// === [GetHereAll] ===
	if(strcmp(cmd,"/all2me",true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		tmp = strtok(cmdtext, idx);
		new Float:X,Float:Y,Float:Z;
		if(IsLoggedIn[playerid] == 1)
		{
			if(Admin[playerid] > 1)
			{
				format(string, sizeof(string), "AdmCmd: %s has teleported everyone.", sendername);
				SendClientMessageToAll(COLOR_LIGHTRED, string);
				GetPlayerPos(playerid, X, Y, Z);
				GetPlayerInterior(playerid);
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					SetPlayerPos(i, X, Y+1, Z);
					SetPlayerInterior(i, GetPlayerInterior(playerid));
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD2, "You do not have permission to use that command.");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be logged in.");
		}
		return 1;
	}
	
	if(strcmp(cmd,"/gmx",true) == 0)
	{
		if(Admin[playerid] == 5)
		{
			if (IsPlayerConnected(playerid))
			{
				SendRconCommand("gmx");
			}
		}
		return 1;
	}
	
	if(!strcmp("/a", cmd, true))
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD1, "Usage: /a(adminchat) [text]");
			return 1;
		}
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(Admin[i] == 1)
				{
					new pname[26];
					GetPlayerName(playerid, pname, sizeof(pname));
					format(string, 256, "** 1 Admin %s: %s **", pname, cmdtext[3]);
					SendClientMessage(i, COLOR_YELLOW, string);
				}
				else if(Admin[i] == 2)
				{
					new pname[26];
					GetPlayerName(playerid, pname, sizeof(pname));
					format(string, 256, "** 2 Admin %s: %s **", pname, cmdtext[3]);
					SendClientMessage(i, COLOR_YELLOW, string);
				}
				else if(Admin[i] == 3)
				{
					new pname[26];
					GetPlayerName(playerid, pname, sizeof(pname));
					format(string, 256, "** 3 Admin %s: %s **", pname, cmdtext[3]);
					SendClientMessage(i, COLOR_YELLOW, string);
				}
				else if(Admin[i] == 4)
				{
					new pname[26];
					GetPlayerName(playerid, pname, sizeof(pname));
					format(string, 256, "** 4 Admin %s: %s **", pname, cmdtext[3]);
					SendClientMessage(i, COLOR_YELLOW, string);
				}
				else if(Admin[i] == 5)
				{
					new pname[26];
					GetPlayerName(playerid, pname, sizeof(pname));
					format(string, 256, "** Master Admin %s: %s **", pname, cmdtext[3]);
					SendClientMessage(i, COLOR_YELLOW, string);
				}
			}
		}
		return 1;
	}
	
	if(!strcmp("/vc", cmd, true))
	{
		new stringv[256], sendernamev[24];
		GetPlayerName(playerid, sendernamev, sizeof(sendernamev));
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
		if(!strlen(result)) return SendClientMessage(playerid, COLOR_GRAD1, "Usage: /vc(vehicle chat) [text]");
		if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_GRAD2, "You must be in a vehicle.");
		format(stringv, sizeof(stringv), "** Vehicle Chat %s: %s", sendernamev, result);
		for(new i = 0; i < MAX_PLAYERS; i ++)
		{
			if(IsPlayerConnected(i))
			{
				if(IsPlayerInVehicle(i, GetPlayerVehicleID(playerid)))
				{
					SendClientMessage(i,COLOR_YELLOW2,stringv);
				}
			}
		}
		return 1;
	}
	
	if(strcmp(cmd,"/help",true) == 0)
	{
		SendClientMessage(playerid, COLOR_GRAD1,"*** ACCOUNT *** /register || /login || /logout");
		SendClientMessage(playerid, COLOR_GRAD2,"*** GENERAL *** /jetpack || /film || /v(vehicle) || /w2(weapon) || /t(time) || /s(skin)");
		SendClientMessage(playerid, COLOR_GRAD2,"*** GENERAL *** /animhelp || /teles || /kill || /letterbox(on/off) || /names(on/off)");
		SendClientMessage(playerid, COLOR_GRAD2,"*** VEHICLE *** /vc(vehicle chat) || /fix");
		if(Admin[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_GRAD4, "*** LEVEL 1 *** /a(adminchat) || /gethere || /goto || /kick || /reaction");
		}
		if(Admin[playerid] == 2)
		{
			SendClientMessage(playerid, COLOR_GRAD4, "*** LEVEL 2 *** /a(adminchat) || /gethere || /goto || /ban || /kick || /learn || /all2me || /reaction");
		}
		if(Admin[playerid] == 3)
		{
			SendClientMessage(playerid, COLOR_GRAD4, "*** LEVEL 3 *** /a(adminchat) || /gethere || /goto || /ban || /kick || /vclear || /learn || /all2me || /reaction");
		}
		if(Admin[playerid] == 4)
		{
			SendClientMessage(playerid, COLOR_GRAD4, "*** LEVEL 4 *** /a(adminchat) || /gethere || /goto || /ban || /kick || /vclear || /learn || /all2me || /reaction");
		}
		if(Admin[playerid] == 5)
		{
			SendClientMessage(playerid, COLOR_GRAD4, "*** LEVEL 5 *** /a(adminchat) || /gmx || /gethere || /goto || /ban || /kick || /vclear || /learn || /all2me || /reaction");
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/jetpack", true) == 0)
	{
		SetPlayerSpecialAction(playerid, 2);
		return 1;
	}
	
	if (strcmp(cmdtext, "/letterboxon", true) == 0)
	{
		TextDrawShowForPlayer(playerid,lbt);
		TextDrawShowForPlayer(playerid,lbb);
		SendClientMessage(playerid, COLOR_YELLOW, "Letterbox is now on. Type /letterboxoff to turn it off.");
		SendClientMessage(playerid, COLOR_YELLOW2, "Credits to [TS]GTA44.");
		PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
		return 1;
	}
	
	if (strcmp(cmdtext, "/letterboxoff", true) == 0)
	{
		TextDrawHideForPlayer(playerid,lbt);
		TextDrawHideForPlayer(playerid,lbb);
		SendClientMessage(playerid, COLOR_YELLOW, "Letterbox is now off. Type /letterboxon to turn it on.");
		SendClientMessage(playerid, COLOR_YELLOW2, "Credits to [TS]GTA44.");
		PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
		return 1;
	}
	
	if (strcmp(cmdtext, "/nameson", true) == 0)
	{
		for(new i; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				ShowPlayerNameTagForPlayer(playerid, i, 1);
			}
		}
		SendClientMessage(playerid, COLOR_YELLOW, "Nametags are now on. Type /namesoff to turn them off.");
		PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
		gNameTags[playerid] = 1;
		return 1;
	}
	
	if (strcmp(cmdtext, "/namesoff", true) == 0)
	{
		for(new i; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				ShowPlayerNameTagForPlayer(playerid, i, 0);
			}
		}
		SendClientMessage(playerid, COLOR_YELLOW, "Nametags are now off. Type /nameson to turn them on.");
		PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
		gNameTags[playerid] = 0;
		return 1;
	}
	
	if (strcmp(cmdtext, "/film", true) == 0)
	{
		SendClientMessage(playerid, COLOR_YELLOW2,"*** FILMING FUNCTIONS **");
		SendClientMessage(playerid, COLOR_YELLOW,"*** /letterbox(on/off) - Credits to [TS]GTA44 ***");
		SendClientMessage(playerid, COLOR_YELLOW,"*** /names(on/off) ***");
		SendClientMessage(playerid, COLOR_YELLOW,"*** /animhelp - Credits to -Seif- ***");
		return 1;
	}
	
	if (strcmp(cmdtext, "/fix", true)==0)
	{
		new VehicleID;
		VehicleID = GetPlayerVehicleID(playerid);
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SetVehicleHealth(VehicleID, 1000.0 );
		}else{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be in a vehicle.");
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/kill", true) == 0)
	{
		SetPlayerHealth(playerid, 0);
		return 1;
	}
	
	if (strcmp(cmdtext, "/teles", true) == 0)
	{
		SendClientMessage(playerid, COLOR_YELLOW2,"*** TELEPORTS **");
		SendClientMessage(playerid, COLOR_YELLOW,"*** /airportls || /airportlv || /airportsf ***");
		SendClientMessage(playerid, COLOR_YELLOW,"*** /4dragons || /caligulas || /XXX ***");
		SendClientMessage(playerid, COLOR_YELLOW,"*** /burger || /clucking || /pizza ***");
		SendClientMessage(playerid, COLOR_YELLOW,"*** /ammu || /ammu2 || /ammu3 ***");
		SendClientMessage(playerid, COLOR_YELLOW,"*** /smotel || /bmotel || /betshop ***");
		SendClientMessage(playerid, COLOR_YELLOW,"*** /lc1 || /lc2 || /lc3 ***");
		SendClientMessage(playerid, COLOR_YELLOW,"*** /dance || /10gb***");
		SendClientMessage(playerid, COLOR_YELLOW,"*** /caligbase || /woozie || /donut ***");
		SendClientMessage(playerid, COLOR_YELLOW,"*** /cjgarage || /bloodbowl || /bball ***");
		return 1;
	}
	
	if (strcmp(cmdtext, "/airportls", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), 1922.3228, -2250.1079, 13.5469);
			SetCameraBehindPlayer(playerid);
			SetPlayerInterior(playerid, 0);
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, 1967.2161, -2299.3958, 13.5469, 180.4081, 0);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/airportlv", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), 1583.5670, 1425.7695, 10.8368);
			SetCameraBehindPlayer(playerid);
			SetPlayerInterior(playerid, 0);
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, 1586.0363, 1449.5322, 10.8302, 82.5566, 0);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/airportsf", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), -1276.5927, 19.4913, 14.1484);
			SetCameraBehindPlayer(playerid);
			SetPlayerInterior(playerid, 0);
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, -1269.9132, 67.1065, 14.1484, 76.4022, 0);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/4dragons", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, 1991.6395, 1017.6338, 994.8906, 90.3133, 10);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/caligulas", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, 2236.1882, 1677.4907, 1008.3594, 180.0000, 1);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/xxx", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, -100.3260, -21.6871, 1000.7188, 360.0000, 3);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/burger", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, 365.0489, -73.8474, 1001.5078, 292.4531, 10);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/clucking", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, 365.7462, -9.1035, 1001.8516, 298.4861, 9);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/pizza", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, 371.2124, -130.1286, 1001.4922, 359.9000, 5);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/ammu", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, 316.5264, -167.9213, 999.5938, 359.9000, 6);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/ammu2", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, 286.8010, -82.5476, 1001.5156, 315.0000, 4);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/ammu3", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, 286.8517, -39.9301, 1001.5156, 316.8800, 1);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/smotel", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, 446.6230, 509.6538, 1001.4195, 360.0000, 12);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/bmotel", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, 2220.9146, -1148.6919, 1025.7969, 355.3000, 15);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/betshop", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, 832.5676, 7.4180, 1004.1797, 90.0000, 3);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/lc1", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, -794.8064, 491.6866, 1376.1953, 0.0000, 1);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/lc2", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, -735.5620, 484.3513, 1371.9523, 40.0000, 1);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/lc3", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, -838.1101, 499.8046, 1358.2684, 270.0725, 1);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/dance", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, 492.1286, -20.9589, 1000.6797, 38.2270, 17);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/10gb", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, 502.3769, -70.3716, 998.7578, 180.0000, 11);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/caligbase", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, 2171.8213, 1618.8806, 999.9766, 270.3858, 1);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/woozie", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, -2169.8464, 642.3659, 1057.5861, 270.0000, 1);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/donut", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, 378.1614, -191.2004, 1000.6328, 360.0000, 17);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/cjgarage", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, -2051.7554, 156.0314, 28.8429, 345.9002, 1);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/bloodbowl", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), -1400.5020, 988.5403, 1023.9941);
			SetCameraBehindPlayer(playerid);
			SetPlayerInterior(playerid, 15);
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, -1398.1035, 933.4454, 1041.5313, 0.0000, 15);
		}
		return 1;
	}
	
	if (strcmp(cmdtext, "/bball", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You must be on foot.");
		}
		if(CanTele[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
		{
			TelePlayer(playerid, 1382.6156, 2184.3457, 11.0234, 135.0000, 0);
		}
		return 1;
	}
	
	if(strcmp(cmd,"/animhelp",true)==0)
	{
		SendClientMessage(playerid, COLOR_YELLOW,"*** ANIMATONS LIST **");
		SendClientMessage(playerid, COLOR_YELLOW2, "Credits to -Seif-");
		SendClientMessage(playerid, COLOR_YELLOW, "/fall - /fallback - /injured - /akick - /push - /lowbodypush - /handsup - /bomb - /drunk - /getarrested - /laugh - /sup");
		SendClientMessage(playerid, COLOR_YELLOW," /basket - /headbutt - /medic - /spray - /robman - /taichi - /lookout - /kiss - /cellin - /cellout - /crossarms - /lay");
		SendClientMessage(playerid, COLOR_YELLOW,"/deal - /crack - /smoke - /groundsit - /chat - /dance - /fucku - /strip - /hide - /vomit - /eat - /chairsit - /reload");
		SendClientMessage(playerid, COLOR_YELLOW,"/koface - /kostomach - /rollfall - /carjacked1 - /carjacked2 - /rcarjack1 - /rcarjack2 - /lcarjack1 - /lcarjack2 - /bat");
		SendClientMessage(playerid, COLOR_YELLOW,"/lifejump - /exhaust - /leftslap - /carlock - /hoodfrisked - /lightcig - /tapcig - /box - /lay2 - /chant - finger");
		SendClientMessage(playerid, COLOR_YELLOW,"/shouting - /knife - /cop - /elbow - /kneekick - /airkick - /gkick - /gpunch - /fstance - /lowthrow - /highthrow - /aim");
		SendClientMessage(playerid, COLOR_YELLOW,"/piss - /lean - /run");
		return 1;
	}
	
	// carjacked
	if(strcmp(cmd, "/carjacked1", true) == 0) {
		LoopingAnim(playerid,"PED","CAR_jackedLHS",4.0,0,1,1,1,0);
		return 1;
	}
	
	// carjacked
	if(strcmp(cmd, "/carjacked2", true) == 0) {
		LoopingAnim(playerid,"PED","CAR_jackedRHS",4.0,0,1,1,1,0);
		return 1;
	}
	
	// HANDSUP
	if(strcmp(cmd, "/handsup", true) == 0) {
		//SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
		LoopingAnim(playerid, "ROB_BANK","SHP_HandsUp_Scr", 4.0, 0, 1, 1, 1, 0);
		return 1;
	}
	
	// CELLPHONE IN
	if(strcmp(cmd, "/cellin", true) == 0) {
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
		return 1;
	}
	
	// CELLPHONE OUT
	if(strcmp(cmd, "/cellout", true) == 0) {
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
		return 1;
	}
	
	// Drunk
	if(strcmp(cmd, "/drunk", true) == 0) {
		LoopingAnim(playerid,"PED","WALK_DRUNK",4.1,1,1,1,1,1);
		return 1;
	}
	
	// Place a Bomb
	if (strcmp("/bomb", cmdtext, true) == 0) {
		ClearAnimations(playerid);
		LoopingAnim(playerid, "BOMBER","BOM_Plant_Loop",4.0,1,0,0,1,0); // Place Bomb
		return 1;
	}
	
	// Police Arrest
	if (strcmp("/getarrested", cmdtext, true) == 0) {
		LoopingAnim(playerid,"ped", "ARRESTgun", 4.0, 0, 1, 1, 1, -1); // Gun Arrest
		return 1;
	}
	
	// Laugh
	if (strcmp("/laugh", cmdtext, true) == 0) {
		OnePlayAnim(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0, 0); // Laugh
		return 1;
	}
	
	// Rob Lookout
	if (strcmp("/lookout", cmdtext, true) == 0) {
		OnePlayAnim(playerid, "SHOP", "ROB_Shifty", 4.0, 0, 0, 0, 0, 0); // Rob Lookout
		return 1;
	}
	
	// Rob Threat
	if (strcmp("/robman", cmdtext, true) == 0) {
		LoopingAnim(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0); // Rob
		return 1;
	}
	
	// Arms crossed
	if (strcmp("/crossarms", cmdtext, true) == 0) {
		LoopingAnim(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1); // Arms crossed
		return 1;
	}
	
	// Lay Down
	if (strcmp("/lay", cmdtext, true) == 0) {
		LoopingAnim(playerid,"BEACH", "bather", 4.0, 1, 0, 0, 0, 0); // Lay down
		return 1;
	}
	
	// Take Cover
	if (strcmp("/hide", cmdtext, true) == 0) {
		LoopingAnim(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0); // Taking Cover
		return 1;
	}
	
	// Vomit
	if (strcmp("/vomit", cmdtext, true) == 0) {
		OnePlayAnim(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0); // Vomit BAH!
		return 1;
	}
	
	// Eat Burger
	if (strcmp("/eat", cmdtext, true) == 0) {
		OnePlayAnim(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // Eat Burger
		return 1;
	}
	
	// Wave
	if (strcmp("/wave", cmdtext, true) == 0) {
		LoopingAnim(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0); // Wave
		return 1;
	}
	
	// Slap Ass
	if (strcmp("/slapass", cmdtext, true) == 0) {
		OnePlayAnim(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0); // Ass Slapping
		return 1;
	}
	
	// Dealer
	if (strcmp("/deal", cmdtext, true) == 0) {
		OnePlayAnim(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0); // Deal Drugs
		return 1;
	}
	
	// Crack Dieing
	if (strcmp("/crack", cmdtext, true) == 0) {
		LoopingAnim(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0); // Dieing of Crack
		return 1;
	}
	
	// Smoking animations
	if(strcmp(cmd, "/smoke", true) == 0)
	{
		if (!strlen(cmdtext[7])) return SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /smoke [1-4]");
		switch (cmdtext[7])
		{
			case '1': LoopingAnim(playerid,"SMOKING", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0); // male
			case '2': LoopingAnim(playerid,"SMOKING", "F_smklean_loop", 4.0, 1, 0, 0, 0, 0); //female
			case '3': LoopingAnim(playerid,"SMOKING","M_smkstnd_loop", 4.0, 1, 0, 0, 0, 0); // standing-fucked
			case '4': LoopingAnim(playerid,"SMOKING","M_smk_out", 4.0, 1, 0, 0, 0, 0); // standing
			default: SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /smoke [1-4]");
		}
		return 1;
	}
	
	// Sit
	if (strcmp("/groundsit", cmdtext, true) == 0 || strcmp("/gro", cmdtext, true) == 0) {
		LoopingAnim(playerid,"BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0); // Sit
		return 1;
	}
	
	// Idle Chat
	if(strcmp(cmd, "/chat", true) == 0) {
		LoopingAnim(playerid,"PED","IDLE_CHAT",4.0,1,0,0,1,1);
		return 1;
	}
	
	// Fucku
	if(strcmp(cmd, "/fucku", true) == 0) {
		OnePlayAnim(playerid,"PED","fucku",4.0,0,0,0,0,0);
		return 1;
	}
	
	// TaiChi
	if(strcmp(cmd, "/taichi", true) == 0) {
		LoopingAnim(playerid,"PARK","Tai_Chi_Loop",4.0,1,0,0,0,0);
		return 1;
	}
	
	// ChairSit
	if(strcmp(cmd, "/chairsit", true) == 0) {
		LoopingAnim(playerid,"PED","SEAT_down",4.1,0,1,1,1,0);
		return 1;
	}
	
	// Fall on the ground
	if(strcmp(cmd, "/fall", true) == 0) {
		LoopingAnim(playerid,"PED","KO_skid_front",4.1,0,1,1,1,0);
		return 1;
	}
	
	// Fall
	if(strcmp(cmd, "/fallback", true) == 0) {
		LoopingAnim(playerid, "PED","FLOOR_hit_f", 4.0, 1, 0, 0, 0, 0);
		return 1;
	}
	
	// kiss
	if(strcmp(cmd, "/kiss", true) == 0) {
		LoopingAnim(playerid, "KISSING", "Playa_Kiss_02", 3.0, 1, 1, 1, 1, 0);
		return 1;
	}
	
	// Injujred
	if(strcmp(cmd, "/injured", true) == 0) {
		LoopingAnim(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0);
		return 1;
	}
	
	// Homie animations
	if(strcmp(cmd, "/sup", true) == 0)
	{
		if (!strlen(cmdtext[5])) return SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /sup [1-3]");
		switch (cmdtext[5])
		{
			case '1': OnePlayAnim(playerid,"GANGS","hndshkba",4.0,0,0,0,0,0);
			case '2': OnePlayAnim(playerid,"GANGS","hndshkda",4.0,0,0,0,0,0);
			case '3': OnePlayAnim(playerid,"GANGS","hndshkfa_swt",4.0,0,0,0,0,0);
			default: SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /sup [1-3]");
		}
		return 1;
	}
	
	// Rap animations
	if(strcmp(cmd, "/rap", true) == 0)
	{
		if (!strlen(cmdtext[5])) return SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /rap [1-4]");
		switch (cmdtext[5])
		{
			case '1': LoopingAnim(playerid,"RAPPING","RAP_A_Loop",4.0,1,0,0,0,0);
			case '2': LoopingAnim(playerid,"RAPPING","RAP_C_Loop",4.0,1,0,0,0,0);
			case '3': LoopingAnim(playerid,"GANGS","prtial_gngtlkD",4.0,1,0,0,0,0);
			case '4': LoopingAnim(playerid,"GANGS","prtial_gngtlkH",4.0,1,0,0,1,1);
			default: SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /rap [1-4]");
		}
		return 1;
	}
	
	// Violence animations
	if(strcmp(cmd, "/push", true) == 0) {
		OnePlayAnim(playerid,"GANGS","shake_cara",4.0,0,0,0,0,0);
		return 1;
	}
	
	if(strcmp(cmd, "/akick", true) == 0) {
		OnePlayAnim(playerid,"POLICE","Door_Kick",4.0,0,0,0,0,0);
		return 1;
	}
	
	if(strcmp(cmd, "/lowbodypush", true) == 0) {
		OnePlayAnim(playerid,"GANGS","shake_carSH",4.0,0,0,0,0,0);
		return 1;
	}
	
	// Spray
	if(strcmp(cmd, "/spray", true) == 0) {
		OnePlayAnim(playerid,"SPRAYCAN","spraycan_full",4.0,0,0,0,0,0);
		return 1;
	}
	
	// Headbutt
	if(strcmp(cmd, "/headbutt", true) == 0) {
		OnePlayAnim(playerid,"WAYFARER","WF_Fwd",4.0,0,0,0,0,0);
		return 1;
	}
	
	// Medic
	if(strcmp(cmd, "/medic", true) == 0) {
		OnePlayAnim(playerid,"MEDIC","CPR",4.0,0,0,0,0,0);
		return 1;
	}
	
	// KO Face
	if(strcmp(cmd, "/koface", true) == 0) {
		LoopingAnim(playerid,"PED","KO_shot_face",4.0,0,1,1,1,0);
		return 1;
	}
	
	// KO Stomach
	if(strcmp(cmd, "/kostomach", true) == 0) {
		LoopingAnim(playerid,"PED","KO_shot_stom",4.0,0,1,1,1,0);
		return 1;
	}
	
	// Jump for your life!
	if(strcmp(cmd, "/lifejump", true) == 0) {
		LoopingAnim(playerid,"PED","EV_dive",4.0,0,1,1,1,0);
		return 1;
	}
	
	// Exhausted
	if(strcmp(cmd, "/exhaust", true) == 0) {
		LoopingAnim(playerid,"PED","IDLE_tired",3.0,1,0,0,0,0);
		return 1;
	}
	
	// Left big slap
	if(strcmp(cmd, "/leftslap", true) == 0) {
		OnePlayAnim(playerid,"PED","BIKE_elbowL",4.0,0,0,0,0,0);
		return 1;
	}
	
	// Big fall
	if(strcmp(cmd, "/rollfall", true) == 0) {
		LoopingAnim(playerid,"PED","BIKE_fallR",4.0,0,1,1,1,0);
		return 1;
	}
	
	// Locked
	if(strcmp(cmd, "/carlock", true) == 0) {
		OnePlayAnim(playerid,"PED","CAR_doorlocked_LHS",4.0,0,0,0,0,0);
		return 1;
	}
	
	// carjack
	if(strcmp(cmd, "/rcarjack1", true) == 0) {
		OnePlayAnim(playerid,"PED","CAR_pulloutL_LHS",4.0,0,0,0,0,0);
		return 1;
	}
	
	// carjack
	if(strcmp(cmd, "/lcarjack1", true) == 0) {
		OnePlayAnim(playerid,"PED","CAR_pulloutL_RHS",4.0,0,0,0,0,0);
		return 1;
	}
	
	// carjack
	if(strcmp(cmd, "/rcarjack2", true) == 0) {
		OnePlayAnim(playerid,"PED","CAR_pullout_LHS",4.0,0,0,0,0,0);
		return 1;
	}
	
	// carjack
	if(strcmp(cmd, "/lcarjack2", true) == 0) {
		OnePlayAnim(playerid,"PED","CAR_pullout_RHS",4.0,0,0,0,0,0);
		return 1;
	}
	
	// Hood frisked
	if(strcmp(cmd, "/hoodfrisked", true) == 0) {
		LoopingAnim(playerid,"POLICE","crm_drgbst_01",4.0,0,1,1,1,0);
		return 1;
	}
	
	// Lighting cigarette
	if(strcmp(cmd, "/lightcig", true) == 0) {
		OnePlayAnim(playerid,"SMOKING","M_smk_in",3.0,0,0,0,0,0);
		return 1;
	}
	
	// Tap cigarette
	if(strcmp(cmd, "/tapcig", true) == 0) {
		OnePlayAnim(playerid,"SMOKING","M_smk_tap",3.0,0,0,0,0,0);
		return 1;
	}
	
	// Bat stance
	if(strcmp(cmd, "/bat", true) == 0) {
		LoopingAnim(playerid,"BASEBALL","Bat_IDLE",4.0,1,1,1,1,0);
		return 1;
	}
	
	// Boxing
	if(strcmp(cmd, "/box", true) == 0) {
		LoopingAnim(playerid,"GYMNASIUM","GYMshadowbox",4.0,1,1,1,1,0);
		return 1;
	}
	
	// Lay 2
	if(strcmp(cmd, "/lay2", true) == 0) {
		LoopingAnim(playerid,"SUNBATHE","Lay_Bac_in",3.0,0,1,1,1,0);
		return 1;
	}
	
	// Gogogo
	if(strcmp(cmd, "/chant", true) == 0) {
		LoopingAnim(playerid,"RIOT","RIOT_CHANT",4.0,1,1,1,1,0);
		return 1;
	}
	
	// Finger
	if(strcmp(cmd, "/finger", true) == 0) {
		OnePlayAnim(playerid,"RIOT","RIOT_FUKU",2.0,0,0,0,0,0);
		return 1;
	}
	
	// Shouting
	if(strcmp(cmd, "/shouting", true) == 0) {
		LoopingAnim(playerid,"RIOT","RIOT_shout",4.0,1,0,0,0,0);
		return 1;
	}
	
	// Cop stance
	if(strcmp(cmd, "/cop", true) == 0) {
		OnePlayAnim(playerid,"SWORD","sword_block",50.0,0,1,1,1,1);
		return 1;
	}
	
	// Elbow
	if(strcmp(cmd, "/elbow", true) == 0) {
		OnePlayAnim(playerid,"FIGHT_D","FightD_3",4.0,0,1,1,0,0);
		return 1;
	}
	
	// Knee kick
	if(strcmp(cmd, "/kneekick", true) == 0) {
		OnePlayAnim(playerid,"FIGHT_D","FightD_2",4.0,0,1,1,0,0);
		return 1;
	}
	
	// Fight stance
	if(strcmp(cmd, "/fstance", true) == 0) {
		LoopingAnim(playerid,"FIGHT_D","FightD_IDLE",4.0,1,1,1,1,0);
		return 1;
	}
	
	// Ground punch
	if(strcmp(cmd, "/gpunch", true) == 0) {
		OnePlayAnim(playerid,"FIGHT_B","FightB_G",4.0,0,0,0,0,0);
		return 1;
	}
	
	// Air kick
	if(strcmp(cmd, "/airkick", true) == 0) {
		OnePlayAnim(playerid,"FIGHT_C","FightC_M",4.0,0,1,1,0,0);
		return 1;
	}
	
	// Ground kick
	if(strcmp(cmd, "/gkick", true) == 0) {
		OnePlayAnim(playerid,"FIGHT_D","FightD_G",4.0,0,0,0,0,0);
		return 1;
	}
	
	// Low throw
	if(strcmp(cmd, "/lowthrow", true) == 0) {
		OnePlayAnim(playerid,"GRENADE","WEAPON_throwu",3.0,0,0,0,0,0);
		return 1;
	}
	
	// Ground kick
	if(strcmp(cmd, "/highthrow", true) == 0) {
		OnePlayAnim(playerid,"GRENADE","WEAPON_throw",4.0,0,0,0,0,0);
		return 1;
	}
	
	// Deal stance
	if(strcmp(cmd, "/dealstance", true) == 0) {
		LoopingAnim(playerid,"DEALER","DEALER_IDLE",4.0,1,0,0,0,0);
		return 1;
	}
	
	// Deal stance
	if(strcmp(cmd, "/piss", true) == 0) {
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_PISSING);
		return 1;
	}
	
	// Knife animations
	if(strcmp(cmd, "/knife", true) == 0)
	{
		if (!strlen(cmdtext[7])) return SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /knife [1-4]");
		switch (cmdtext[7])
		{
			case '1': LoopingAnim(playerid,"KNIFE","KILL_Knife_Ped_Damage",4.0,0,1,1,1,0);
			case '2': LoopingAnim(playerid,"KNIFE","KILL_Knife_Ped_Die",4.0,0,1,1,1,0);
			case '3': OnePlayAnim(playerid,"KNIFE","KILL_Knife_Player",4.0,0,0,0,0,0);
			case '4': LoopingAnim(playerid,"KNIFE","KILL_Partial",4.0,0,1,1,1,1);
			default: SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /knife [1-4]");
		}
		return 1;
	}
	
	// Basket-ball
	if(strcmp(cmd, "/basket", true) == 0)
	{
		if (!strlen(cmdtext[8])) return SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /basket [1-6]");
		switch (cmdtext[8])
		{
			case '1': LoopingAnim(playerid,"BSKTBALL","BBALL_idleloop",4.0,1,0,0,0,0);
			case '2': OnePlayAnim(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
			case '3': OnePlayAnim(playerid,"BSKTBALL","BBALL_pickup",4.0,0,0,0,0,0);
			case '4': LoopingAnim(playerid,"BSKTBALL","BBALL_run",4.1,1,1,1,1,1);
			case '5': LoopingAnim(playerid,"BSKTBALL","BBALL_def_loop",4.0,1,0,0,0,0);
			case '6': LoopingAnim(playerid,"BSKTBALL","BBALL_Dnk",4.0,1,0,0,0,0);
			default: SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /basket [1-6]");
		}
		return 1;
	}
	
	// Reloading guns
	if(strcmp(cmd, "/reload", true) == 0)
	{
		if (!strlen(cmdtext[8])) return SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /reload [deagle/smg/ak/m4]");
		if (strcmp("deagle",cmdtext[8],true) == 0)
		{
			OnePlayAnim(playerid,"COLT45","colt45_reload",4.0,0,0,0,0,1);
		}
		else if (strcmp("smg",cmdtext[8],true) == 0 || strcmp("ak",cmdtext[8],true) == 0 || strcmp("m4",cmdtext[8],true) == 0)
		{
			OnePlayAnim(playerid,"UZI","UZI_reload",4.0,0,0,0,0,0);
		}
		else SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /reload [deagle/smg/ak/m4]");
		return 1;
	}
	
	if(strcmp(cmd, "/gwalk", true) == 0)
	{
		if (!strlen(cmdtext[6])) return SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /gwalk [1/2]");
		new style = strval(cmdtext[6]);
		if (style == 1)
		{
			LoopingAnim(playerid,"PED","WALK_gang1",4.1,1,1,1,1,1);
		}
		else if (style == 2)
		{
			LoopingAnim(playerid,"PED","WALK_gang2",4.1,1,1,1,1,1);
		}
		else SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /gwalk [1/2]");
		return 1;
	}
	
	//Aiming animation
	if(strcmp(cmd, "/aim", true) == 0)
	{
		if (!strlen(cmdtext[5])) return SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /aim [1-.]");
		switch (cmdtext[5])
		{
			case '1': LoopingAnim(playerid,"PED","gang_gunstand",4.0,1,1,1,1,1);
			case '2': LoopingAnim(playerid,"PED","Driveby_L",4.0,0,1,1,1,1);
			case '3': LoopingAnim(playerid,"PED","Driveby_R",4.0,0,1,1,1,1);
			default: SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /aim [1-3]");
		}
		return 1;
	}
	
	// Leaning animation
	if(strcmp(cmd, "/lean", true) == 0)
	{
		if (!strlen(cmdtext[6])) return SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /lean [1-2]");
		switch (cmdtext[6])
		{
			case '1': LoopingAnim(playerid,"GANGS","leanIDLE",4.0,0,1,1,1,0);
			case '2': LoopingAnim(playerid,"MISC","Plyrlean_loop",4.0,0,1,1,1,0);
			default: SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /lean [1-2]");
		}
		return 1;
	}
	
	if(strcmp(cmd, "/run", true) == 0)
	{
		LoopingAnim(playerid,"PED","sprint_civi",floatstr(cmdtext[5]),1,1,1,1,1);
		printf("%f",floatstr(cmdtext[5]));
		return 1;
	}
	
	// Clear
	if(strcmp(cmd, "/clear", true) == 0) {
		//ClearAnimations(playerid);
		ApplyAnimation(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0);
		return 1;
	}
	
	// Strip
	if(strcmp(cmd, "/strip", true) == 0)
	{
		if (!strlen(cmdtext[7])) return SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /strip [A-G]");
		switch (cmdtext[7])
		{
			case 'a', 'A': LoopingAnim(playerid,"STRIP", "strip_A", 4.1, 1, 1, 1, 1, 1 );
			case 'b', 'B': LoopingAnim(playerid,"STRIP", "strip_B", 4.1, 1, 1, 1, 1, 1 );
			case 'c', 'C': LoopingAnim(playerid,"STRIP", "strip_C", 4.1, 1, 1, 1, 1, 1 );
			case 'd', 'D': LoopingAnim(playerid,"STRIP", "strip_D", 4.1, 1, 1, 1, 1, 1 );
			case 'e', 'E': LoopingAnim(playerid,"STRIP", "strip_E", 4.1, 1, 1, 1, 1, 1 );
			case 'f', 'F': LoopingAnim(playerid,"STRIP", "strip_F", 4.1, 1, 1, 1, 1, 1 );
			case 'g', 'G': LoopingAnim(playerid,"STRIP", "strip_G", 4.1, 1, 1, 1, 1, 1 );
			default: SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /strip [A-G]");
		}
		return 1;
	}
	
	// START DANCING
	if(strcmp(cmd, "/dance", true) == 0) {
		
		// Get the dance style param
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /dance [style 1-4]");
			return 1;
		}
		
		dancestyle = strval(tmp);
		if(dancestyle < 1 || dancestyle > 4) {
			SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /dance [style 1-4]");
			return 1;
		}
		
		if(dancestyle == 1) {
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
		} else if(dancestyle == 2) {
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
		} else if(dancestyle == 3) {
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
		} else if(dancestyle == 4) {
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
		}
		return 1;
	}
	return 0;
}

public OnPlayerHackMoney(playerid,money)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(Admin[i] > 0)
			{
				new string[259];
				new playerName[23];
				GetPlayerName(playerid,playerName,23);
				format(string,sizeof(string),"[AdmWarning: %s spawned with, or spawned $2000 at once.]",playerName);
				SendClientMessage(i, COLOR_YELLOW2, string);
			}
		}
	}
	return 1;
}

public IsPlayerxGAdmin(playerid)
{
	if(Admin[playerid] == 1)
	{
		return 1;
	}
	if(Admin[playerid] == 2)
	{
		return 2;
	}
	if(Admin[playerid] == 3)
	{
		return 3;
	}
	if(Admin[playerid] == 4)
	{
		return 4;
	}
	if(Admin[playerid] == 5)
	{
		return 5;
	}
	else return 0;
}

public IsTutPasser(playerid)
{
	if(TutorialPassed[playerid] == 1)
	{
		return 1;
	}
	else return 0;
}

public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		return 1;
	}
	return 0;
}

stock CheckPlayerDistanceToPlayer(Float:radi, playerid, otherid)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:PX,Float:PY,Float:PZ,Float:X,Float:Y,Float:Z;
		GetPlayerPos(playerid,PX,PY,PZ);
		GetPlayerPos(otherid, X,Y,Z);
		new Float:Distance = (X-PX)*(X-PX)+(Y-PY)*(Y-PY)+(Z-PZ)*(Z-PZ);
		if(Distance <= radi*radi)
		{
			return 1;
		}
	}
	return 0;
}

public STut2(playerid)
{
	GameTextForPlayer(playerid, "~w~-Tutorial ~n~~g~Part 2/5", 1000, 1);
	PlayerPlaySound(playerid,1052,0,0,0);
	SendClientMessage(playerid, COLOR_YELLOW, "____-Tutorial Part Two: How To Film-____");
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "First of all, if you have not got a recorder yet, head on down to www.fraps.com and download it there.");
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "Then come onto this server once installed and hit F9(by default) to record. We have alot of functions");
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "in this server to help you film as well to save you the editing troubles. See /help after the tut.");
	SetTimerEx("STut3", 16500, 0, "j", playerid);
	return 1;
}

public STut3(playerid)
{
	GameTextForPlayer(playerid, "~w~-Tutorial ~n~~g~Part 3/5", 1000, 1);
	PlayerPlaySound(playerid,1052,0,0,0);
	SendClientMessage(playerid, COLOR_YELLOW, "____-Tutorial Part Three: I Don't Really Get This-____");
	SendClientMessage(playerid, COLOR_YELLOW2, "If you are still confused about things, this server is based on recording ingame footage.");
	SendClientMessage(playerid, COLOR_YELLOW2, "Once filmed you can edit it and put it on YouTube or some video streamer site.");
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you need any more help use /report [text] to send a message to online admins.");
	SendClientMessage(playerid, COLOR_YELLOW2, "Don't worry though, we are very nice and will help you whenever you need it.");
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you want to make your filming more professional check /film to see cool commands to save you the");
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "editing troubles.");
	SetTimerEx("STut4", 21500, 0, "j", playerid);
	return 1;
}

public STut4(playerid)
{
	GameTextForPlayer(playerid, "~w~-Tutorial ~n~~g~Part 4/5", 1000, 1);
	PlayerPlaySound(playerid,1052,0,0,0);
	SendClientMessage(playerid, COLOR_YELLOW, "____-Server Tutorial Part Four: Abuse____");
	SendClientMessage(playerid, COLOR_YELLOW2, "If you think you can abuse commands in here think again.");
	SendClientMessage(playerid, COLOR_YELLOW2, "We have flood protection enabled at all times. If you have any reports if it may be bugged use /report.");
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "Some commands are not scripted properly or not tested right. So if you do encounter any bugs please");
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "report it right away, or visit our forum, and post in the Bugs And Reports section.");
	SetTimerEx("STut5", 21000, 0, "j", playerid);
	return 1;
}

public STut5(playerid)
{
	GameTextForPlayer(playerid, "~w~-Tutorial ~n~~g~Part 5/5", 1000, 1);
	PlayerPlaySound(playerid,1052,0,0,0);
	SendClientMessage(playerid, COLOR_YELLOW, "____-Server Tutorial Part Five: Rules____");
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "1. Do not Hack/Cheat. It's lame and will get you banned. (We do have anticheat).");
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "2. Do not use mods which effect the gameplay for you. (Skin mods are ok).");
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "3. Do not use map mods as you could be banned for suspected hacking.");
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "4. Talk properly and none of this gay shit: ''WTF DNT KYLL MEH PLZKTHNXBAI''. Lame, stupid. Will get you temp banned.");
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "5. Respect all players and especially Admins & Moderators.");
	SetTimerEx("STut6", 11500, 0, "j", playerid);
	return 1;
}

public STut6(playerid)
{
	GameTextForPlayer(playerid, "~w~-Tutorial ~n~~g~Part 6/5", 1000, 1);
	PlayerPlaySound(playerid,1052,0,0,0);
	SendClientMessage(playerid, COLOR_YELLOW, "____-Tutorial Part Six: MUHAHA I FOOLED YOU THERE IS SIX PARTS!____");
	SendClientMessage(playerid, COLOR_YELLOW2, "Remember to have fun in this server and obey the rules! Bai! [Lj] - Owner.");
	SetTimerEx("STut7", 5500, 0, "j", playerid);
	return 1;
}

public STut7(playerid)
{
	TutorialPassed[playerid] = 1;
	dUserSet(PlayerName(playerid)).("Tutorial", "1");
	PlayerPlaySound(playerid,1052,0,0,0);
	SpawnPlayer(playerid);
	TogglePlayerControllable(playerid,1);
	TextDrawHideForPlayer(playerid,site);
	CanTele[playerid] = 1;
	return 1;
}

public ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
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
	}
	return 1;
}

public ProxDetectorS(Float:radi, playerid, targetid)
{
	if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		GetPlayerPos(targetid, posx, posy, posz);
		tempposx = (oldposx -posx);
		tempposy = (oldposy -posy);
		tempposz = (oldposz -posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

public SendClientMessageToAdmins(color,const string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(Admin[i] > 0)
			{
				SendClientMessage(i, color, string);
			}
		}
	}
	return 1;
}

public TurnOffGod(playerid)
{
	SetPlayerHealth(playerid,100);
	return 1;
}

public SetRandomWeather()
{
	new rand = random(sizeof(gRandomWeatherIDs));
	new strout[256];
	format(strout, sizeof(strout), "xGBot: Weather Changed To: %s", gRandomWeatherIDs[rand][wt_text]);
	SetWeather(gRandomWeatherIDs[rand][wt_id]);
	SendClientMessageToAll(COLOR_YELLOW2,strout);
	print(strout);
}

stock GetRandomID()
{
	new randn = random(MAX_PLAYERS);
	
	if(IsPlayerConnected(randn)) return randn;
	
	else
	{
		return GetRandomID();
	}
}

public RandPlayer1()
{
	GivePlayerWeapon(GetRandomID(), 16, 5);
	SetPlayerArmour(GetRandomID(), 100);
	SendClientMessageToAll(COLOR_YELLOW2, "[Random: A Random Player has been given ''5 Grenades'' and ''Full Armor'']");
	return 1;
}

stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
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

stock TelePlayer(playerid, Float:x, Float:y, Float:z, Float:angle, interior)
{
	SetPlayerInterior(playerid, interior);
	SetPlayerPos(playerid, x, y, z);
	SetPlayerFacingAngle(playerid, angle);
	SetCameraBehindPlayer(playerid);
	return 1;
}

public VehicleReset(){
	new bool:inVeh;
	SendClientMessageToAll(COLOR_YELLOW2, "All previously used vehicles have been cleared.");
	/*TextDrawHideForAll(site);*/
	SetTimer("SpawnVehicles",2000,0);
	for( new i = 0; i < MAX_VEHICLES; i++ ){
		inVeh = false;
		for( new j = 0; j < MAX_PLAYERS; j++ ){
			if(IsPlayerInVehicle( j, i )){
				inVeh = true;
				break;
			}
		}
		
		if(!inVeh){
			SetVehicleToRespawn(i);
			DestroyVehicle(i);
		}
	}
}

stock IsKeyJustDown(key, newkeys, oldkeys)
{
	if((newkeys & key) && !(oldkeys & key)) return 1;
	return 0;
}

stock OnePlayAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
	if (gPlayerUsingLoopingAnim[playerid] == 1) TextDrawHideForPlayer(playerid,txtAnimHelper);
	ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp);
	animation[playerid]++;
}

stock LoopingAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
	if (gPlayerUsingLoopingAnim[playerid] == 1) TextDrawHideForPlayer(playerid,txtAnimHelper);
	gPlayerUsingLoopingAnim[playerid] = 1;
	ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp);
	TextDrawShowForPlayer(playerid,txtAnimHelper);
	animation[playerid]++;
}

stock StopLoopingAnim(playerid)
{
	gPlayerUsingLoopingAnim[playerid] = 0;
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
}

stock PreloadAnimLib(playerid, animlib[])
{
	ApplyAnimation(playerid,animlib,"null",0.0,0,0,0,0,0);
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(!gPlayerUsingLoopingAnim[playerid]) return;
	if(IsKeyJustDown(KEY_HANDBRAKE,newkeys,oldkeys)) {
		StopLoopingAnim(playerid);
		TextDrawHideForPlayer(playerid,txtAnimHelper);
		animation[playerid] = 0;
	}
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	if (IsPlayerInAnyVehicle(playerid))
	{
		LinkVehicleToInterior(GetPlayerVehicleID(playerid), newinteriorid);
	}
	return 1;
}

public ReactionTest()
{
	reactionstr = "";
	KillTimer(reactiongap);
	new str[256];
	new random_set[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	for (new i = 0; i < 8; i++)
	{
		reactionstr[i] = random_set[random(sizeof(random_set))];
	}
	reactioninprog = 2;
	format(str, sizeof(str), "** First player to type %s wins a Tuned Car! **", reactionstr);
	SendClientMessageToAll(COLOR_YELLOW,str);
}

public ReactionWin(playerid)
{
	new Float:X,Float:Y,Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	TunedSultan = CreateVehicle(560, X, Y+2, Z, 126, 0, 0, -1);
	ChangeVehiclePaintjob(TunedSultan, 2);
	AddVehicleComponent(TunedSultan, 1083); // Dollar Wheels
	AddVehicleComponent(TunedSultan, 1010); // NOS 10x
	AddVehicleComponent(TunedSultan, 1035); // Roof
	AddVehicleComponent(TunedSultan, 1058); // Spoiler
	AddVehicleComponent(TunedSultan, 1166); // Bumper
	SetTimer("SetBack",30,0);
	new reactionwinner[256];
	reactionwinnerid = playerid;
	new tempstring[256];
	GetPlayerName(playerid,reactionwinner,sizeof(reactionwinner));
	format(tempstring, sizeof(tempstring), "** %s has Won the Reaction Test! **", reactionwinner);
	SendClientMessageToAll(COLOR_YELLOW, tempstring);
	OnePlayAnim(playerid,"GRENADE","WEAPON_throw",4.0,0,0,0,0,0);
	reactiongap = SetTimer("ReactionTest",time1+random(time2),0);
	SendPlayerMessageToPlayer(playerid, playerid, "Wow! Look at this beauty!");
}

public SetBack()
{
	reactioninprog = 1;
}
