/*
 *$*$*$*$*$*$*$*$*$*$*$* New York Roleplay *$*$*$*$*$*$*$*$*$*$*$*
 * ------------------------------------------------------------- *
 * ------------------------------------------------------------- *
 ************ Original script (Carlito's Roleplay) by Norn *******
 ************** CR edit (Vortex Roleplay) by Calgon **************
 ***************** Vortex edit (S.A.G.C) by euRo *****************
 **************** New York Roleplay ( EDIT) by Julien209 *****************
 * ------------------------------------------------------------- *
 * ------------------------------------------------------------- *
 *$*$*$*$*$*$*$*$*$*$*$* New York Roleplay *$*$*$*$*$*$*$*$*$*$*$*
*/
//==============================================================================
#include <a_samp>
#include <core>
#include <seif_walk>
#include <float>
#include <time>
#include <file>
#include <Dini>
//==============================================================================
#define GAMEMODE	"TGF 1.0.6"
#define GAMEMODE_USE_VERSION	"No"
#define MAP_NAME	"New York"
#define SERVER_NAME	"The Godfather [the-god-father.com]"
#define WEBSITE	"www.the-god-father.com"
#define VERSION	""
#define LAST_UPDATE	"30/11/09"
#define DEVELOPER	"Julien209"
#define PASSWORD	""
#define SCRIPT_LINES 	24180
//==============================================================================
#define PICKUP_RANGE 50
#define MAX_S_PICKUPS 400
#define MAX_ZONE_NAME 28
#define MAX_SPAWN_ATTEMPTS 4
#define txtcost 15
#define PRODUCT_PRICE 10
//==============================================================================
#define BUSINESS_TYPES "1: Restaurant - 2: Phone - 3: 24-7 - 4: Ammunation - 5: Advertising - 6: Clothes Store - 7. Bar/Club"
#define BUSINESS_TYPES2 " "
//==============================================================================
#define MAX_CCTVS 100
#define MAX_CCTVMENUS 10
#define DISTANCE_BETWEEN_PLAYERS 5 //The minimum distance between players to be able to rob                     |
#define COLOR_ROB 0x00FFFFFF //The color of the text send to the players when made a successfull rob             |
#define COLOR_FAIL 0x00FFFFFF //Color of the text displayed to the players when a rob has failed                        |
#define COLOR_ERROR 0xFF0000FF //Color of the text when there is an error                                                                 |
#define ROB_TIME 7000 //Time between rob commands to prevent spam (in milliseconds)
//==============================================================================
#define COLOR_MAFIA 0x212121AA
#define COLOR_LSPD 0x0000FFAA
#define COLOR_CIVILIAN 0xFFFFFFFF
#define COLOR_LOCALMSG 0xEC5413AA
#define COLOR_ADMINCMD 0x007E96F6
#define COLOR_ADMINDUTY 0x007E96F6
#define COLOR_NOTLOGGED 0x00000000
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_RED 0xA10000AA
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_GREEN1 0x008000FF
#define COLOR_LIGHTGREEN 0x9ACD32AA
#define COLOR_NEWS 0xFFA500AA
#define COLOR_NEWOOC 0x0080FFAA
//==============================================================================
#define ResetMoneyBar ResetPlayerMoney
#define UpdateMoneyBar GivePlayerMoney
#define GasMax 100
//==============================================================================
new TotalCCTVS;
new CameraName[MAX_CCTVS][32];
new Float:CCTVLA[MAX_PLAYERS][3];
new Float:CCTVLAO[MAX_CCTVS][3];
new Float:CCTVRadius[MAX_PLAYERS];
new Float:CCTVDegree[MAX_PLAYERS] = 0.0;
new Float:CCTVCP[MAX_CCTVS][4];
new CurrentCCTV[MAX_PLAYERS] = -1;

new Text:TD;

new Menu:CCTVMenu[MAX_CCTVMENUS];
new MenuType[MAX_CCTVMENUS];
new TotalMenus;
new PlayerMenu[MAX_PLAYERS];

enum LP
{
	Float:LX,
	Float:LY,
	Float:LZ,
	Float:LA,
	LInterior
}

new LastPos[MAX_PLAYERS][LP];
new KeyTimer[MAX_PLAYERS];
//==============================================================================
forward CheckKeyPress(playerid);
public CheckKeyPress(playerid)
{
    new keys, updown, leftright;
    GetPlayerKeys(playerid, keys, updown, leftright);
	if(CurrentCCTV[playerid] > -1 && PlayerMenu[playerid] == -1)
	{
	    if(leftright == KEY_RIGHT)
	  	{
	  	    if(keys == KEY_SPRINT)
			{
	 	    	CCTVDegree[playerid] = (CCTVDegree[playerid] - 2.0);
			}
			else
			{
			    CCTVDegree[playerid] = (CCTVDegree[playerid] - 0.5);
			}
	  	    if(CCTVDegree[playerid] < 0)
	  	    {
	  	        CCTVDegree[playerid] = 359;
			}
	  	    MovePlayerCCTV(playerid);

		}
	    if(leftright == KEY_LEFT)
	    {
	        if(keys == KEY_SPRINT)
			{
	 	    	CCTVDegree[playerid] = (CCTVDegree[playerid] + 2.0);
			}
			else
			{
			    CCTVDegree[playerid] = (CCTVDegree[playerid] + 0.5);
			}
			if(CCTVDegree[playerid] >= 360)
	  	    {
	  	        CCTVDegree[playerid] = 0;
			}
	        MovePlayerCCTV(playerid);

	    }
	    if(updown == KEY_UP)
	    {
	        if(CCTVRadius[playerid] < 25)
	        {
		        if(keys == KEY_SPRINT)
				{
				    CCTVRadius[playerid] =  (CCTVRadius[playerid] + 0.5);
		        	MovePlayerCCTV(playerid);
				}
				else
				{
				    CCTVRadius[playerid] =  (CCTVRadius[playerid] + 0.1);
		        	MovePlayerCCTV(playerid);
				}
			}
		}
		if(updown == KEY_DOWN)
	    {
			if(keys == KEY_SPRINT)
			{
			    if(CCTVRadius[playerid] >= 0.6)
	        	{
				    CCTVRadius[playerid] =  (CCTVRadius[playerid] - 0.5);
			       	MovePlayerCCTV(playerid);
				}
			}
			else
			{
			    if(CCTVRadius[playerid] >= 0.2)
	        	{
				    CCTVRadius[playerid] =  (CCTVRadius[playerid] - 0.1);
			       	MovePlayerCCTV(playerid);
				}
			}
		}
		if(keys == KEY_CROUCH)
		{
		    OnPlayerCommandText(playerid, "/exitcctv");
		}
	}
	MovePlayerCCTV(playerid);
}
stock Float:GetDistanceBetweenPlayers(p1,p2){
	new Float:x1,Float:y1,Float:z1,Float:x3,Float:y3,Float:z3;
	if (!IsPlayerConnected(p1) || !IsPlayerConnected(p2)){
		return -1.00;
	}
	GetPlayerPos(p1,x1,y1,z1);
	GetPlayerPos(p2,x3,y3,z3);
	return floatsqroot(floatpower(floatabs(floatsub(x3,x1)),2)+floatpower(floatabs(floatsub(y3,y1)),2)+floatpower(floatabs(floatsub(z3,z1)),2));
}

stock MovePlayerCCTV(playerid)
{
	CCTVLA[playerid][0] = CCTVLAO[CurrentCCTV[playerid]][0] + (floatmul(CCTVRadius[playerid], floatsin(-CCTVDegree[playerid], degrees)));
	CCTVLA[playerid][1] = CCTVLAO[CurrentCCTV[playerid]][1] + (floatmul(CCTVRadius[playerid], floatcos(-CCTVDegree[playerid], degrees)));
	SetPlayerCameraLookAt(playerid, CCTVLA[playerid][0], CCTVLA[playerid][1], CCTVLA[playerid][2]);
}


stock AddCCTV(name[], Float:X, Float:Y, Float:Z, Float:Angle)
{
	if(TotalCCTVS >= MAX_CCTVS) return 0;
	format(CameraName[TotalCCTVS], 32, "%s", name);
	CCTVCP[TotalCCTVS][0] = X;
	CCTVCP[TotalCCTVS][1] = Y;
	CCTVCP[TotalCCTVS][2] = Z;
	CCTVCP[TotalCCTVS][3] = Angle;
	CCTVLAO[TotalCCTVS][0] = X;
	CCTVLAO[TotalCCTVS][1] = Y;
	CCTVLAO[TotalCCTVS][2] = Z-10;
	TotalCCTVS++;
	return TotalCCTVS-1;
}

SetPlayerToCCTVCamera(playerid, CCTV)
{
	if(CCTV >= TotalCCTVS)
	{
	    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid CCTV");
	    return 1;
	}
	if(CurrentCCTV[playerid] == -1)
    {
	    GetPlayerPos(playerid, LastPos[playerid][LX], LastPos[playerid][LY], LastPos[playerid][LZ]);
		GetPlayerFacingAngle(playerid, LastPos[playerid][LA]);
        LastPos[playerid][LInterior] = GetPlayerInterior(playerid);
	}
	else
	{
		KillTimer(KeyTimer[playerid]);
	}
	CurrentCCTV[playerid] = CCTV;
    TogglePlayerControllable(playerid, 0);
	SetPlayerPos(playerid, CCTVCP[CCTV][0], CCTVCP[CCTV][1], -100.0);
	SetPlayerCameraPos(playerid, CCTVCP[CCTV][0], CCTVCP[CCTV][1], CCTVCP[CCTV][2]);
	SetPlayerCameraLookAt(playerid, CCTVLAO[CCTV][0], (CCTVLAO[CCTV][1]+0.2), CCTVLAO[CCTV][2]);
	CCTVLA[playerid][0] = CCTVLAO[CCTV][0];
	CCTVLA[playerid][1] = CCTVLAO[CCTV][1]+0.2;
	CCTVLA[playerid][2] = CCTVLAO[CCTV][2];
	CCTVRadius[playerid] = 12.5;
	CCTVDegree[playerid] = CCTVCP[CCTV][3];
	MovePlayerCCTV(playerid);
    KeyTimer[playerid] = SetTimerEx("CheckKeyPress", 75, 1, "i", playerid);
    TextDrawShowForPlayer(playerid, TD);
	return 1;
}
//==============================================================================
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

#define MAX_RACECHECKPOINTS 64
#define MAX_BUILDERS 4
#define RACEFILE_VERSION 2

new MajorityDelay = 120;
new RRotation = -1;
new RRotationDelay = 300000;
new BuildAdmin = 1;
new RaceAdmin = 1;
new PrizeMode=0;
new Prize=30000;
new DynaMP=1;
new JoinFee=1000;

forward RefreshMenuHeader(playerid,Menu:menu,text[]);
new Menu:MAdmin, Menu:MPMode, Menu:MPrize, Menu:MDyna, Menu:MBuild, Menu:MLaps;
new Menu:MRace, Menu:MRacemode, Menu:MFee, Menu:MCPsize, Menu:MDelay;

forward RaceRotation();
forward LockRacers();
forward UnlockRacers();
forward SaveScores();
forward GetRaceTick(playerid);
forward GetLapTick(playerid);
forward ReadyRefresh();
forward robtimer(playerid);
forward RaceSound(playerid,sound);
forward BActiveCP(playerid,sele);
forward endrace();
forward countdown();
forward mscountdown();
forward otherstrtok(const string[],&index);
forward SetNextCheckpoint(playerid);
forward CheckBestLap(playerid, laptime);
forward CheckBestRace(playerid,racetime);
forward ChangeLap(playerid);
forward SetRaceCheckpoint(playerid,target,next);
forward SetBRaceCheckpoint(playerid,target,next);
forward LoadTimes(playerid,timemode,tmp[]);
forward IsNotAdmin(playerid);
forward GetBuilderSlot(playerid);
forward b(playerid);
forward Float:Distance(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2);
forward clearrace(playerid);
forward startrace();
forward LoadRace(tmp[]);
forward CreateRaceMenus();

new RotationTimer;
new ystring[128];
new CBuilder[MAX_PLAYER_NAME], CFile[64], CRaceName[128];
new Pot=0;
new Ranking;
new PrizeMP;
new Countdown;
new cd;
new MajStart=0;
new MajStartTimer;
new mscd;
new RaceActive;
new RaceStart;
new Float:RaceCheckpoints[MAX_RACECHECKPOINTS][3];
new LCurrentCheckpoint;
new robtime[MAX_PLAYERS];
new CurrentCheckpoint[MAX_PLAYERS];
new CurrentLap[MAX_PLAYERS];
new RaceParticipant[MAX_PLAYERS];
new Participants;
new Text:Textdraw0;
new PlayerVehicles[MAX_PLAYERS];
new ORacelaps, ORacemode;
new OAirrace, Float:OCPsize;
new Racelaps, Racemode;
new ScoreChange;
new RaceTick;
new LastLapTick[MAX_PLAYERS];
new TopRacers[6][MAX_PLAYER_NAME];
new TopRacerTimes[6];
new TopLappers[6][MAX_PLAYER_NAME];
new TopLapTimes[6];
new Float:CPsize;
new Airrace;
new Float:RLenght, Float:LLenght;

new BCurrentCheckpoints[MAX_BUILDERS];
new BSelectedCheckpoint[MAX_BUILDERS];
new RaceBuilders[MAX_PLAYERS];
new BuilderSlots[MAX_BUILDERS];
new Float:BRaceCheckpoints[MAX_BUILDERS][MAX_RACECHECKPOINTS][3];
new Bracemode[MAX_BUILDERS];
new Blaps[MAX_BUILDERS];
new Float:BCPsize[MAX_BUILDERS];
new BAirrace[MAX_BUILDERS];
//==============================================================================
forward Explode(playerid);
forward UpdateMeter(playerid);

new ExplosionRadius = 15;
new C4[MAX_PLAYERS];
new Bomb[MAX_PLAYERS];
new Planted[MAX_PLAYERS];
new Text:Meter1[MAX_PLAYERS];
new Text:Meter2[MAX_PLAYERS];
new Text:Meter3[MAX_PLAYERS];
new UpdateMeterTimer[MAX_PLAYERS];

RemovePlayerWeapon(playerid, weaponid)
{
	if(!IsPlayerConnected(playerid) || weaponid < 0 || weaponid > 50)
	    return;

	new
	    saveweapon[13],
	    saveammo[13];

	for(new slot = 0; slot < 13; slot++)
	    GetPlayerWeaponData(playerid, slot, saveweapon[slot], saveammo[slot]);

	ResetPlayerWeapons(playerid);

	for(new slot; slot < 13; slot++)
	{
		if(saveweapon[slot] == weaponid || saveammo[slot] == 0)
			continue;

		GivePlayerWeapon(playerid, saveweapon[slot], saveammo[slot]);
	}

	GivePlayerWeapon(playerid, 0, 1);

}
public Explode(playerid)
{
    new Float:bx[MAX_PLAYERS], Float:by[MAX_PLAYERS], Float:bz[MAX_PLAYERS];

    GetObjectPos(C4[playerid], bx[playerid], by[playerid], bz[playerid]);
    DestroyObject(C4[playerid]);
    CreateExplosion(bx[playerid], by[playerid], bz[playerid], 6, ExplosionRadius);
    SendClientMessage(playerid, COLOR_WHITE, "(INFO) Bomb detonated");
    Bomb[playerid] = 0;
    Planted[playerid] = 0;
    RemovePlayerWeapon(playerid, 40);
    return 1;
}

public UpdateMeter(playerid)
{
    new Float:bx[MAX_PLAYERS], Float:by[MAX_PLAYERS], Float:bz[MAX_PLAYERS];

    GetObjectPos(C4[playerid], bx[playerid], by[playerid], bz[playerid]);
    if(PlayerToPoint(10, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(20, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], " i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(30, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "  i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(40, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "   i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(50, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "    i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(60, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "     i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(70, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "      i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(80, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "       i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(90, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "        i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(100, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "         i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(110, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "          i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(120, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "           i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(130, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "            i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(140, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "             i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(150, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "              i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(160, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "               i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(170, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "                i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(180, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "                 i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(190, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "                  i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(200, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "                   i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(210, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "                    i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(220, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "                     i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(230, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "                      i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(240, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "                       i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(250, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "                        i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(260, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "                         i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(270, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "                          i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(280, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "                           i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(290, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "                            i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(300, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "                             i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(310, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "                              i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(320, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "                               i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(330, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "                                i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(340, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "                                 i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(350, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "                                  i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else if(PlayerToPoint(360, playerid, bx[playerid], by[playerid], bz[playerid])){ TextDrawSetString(Meter1[playerid], "                                   i"); TextDrawSetString(Meter3[playerid], "      Range");}
	else
	{
	    TextDrawSetString(Meter3[playerid], "~R~Out Of Range");
	    TextDrawSetString(Meter1[playerid], "~R~                                    i");
	}
	return 1;
}
//==============================================================================
new InAndrom[MAX_PLAYERS];
new InShamal[MAX_PLAYERS];
new Float:ShamalPos[MAX_VEHICLES][3];
new sExplode[MAX_VEHICLES];
new tCount[MAX_VEHICLES];

new Float:difc[][] =
{
	{1.13, 0.05, 1.10, 0.0},
	{1.13, 2.35, 1.10, 180.0},
	{1.13, 4.65, 1.10, 180.0},
	{1.13, 1.05, 1.10, 0.0},
	{1.13, 3.45, 1.10, 180.0},
	{1.13, 5.85, 1.10, 180.0},
	{1.13, 0.39, 0.56, 0.0},
	{1.13, 2.69, 0.56, 180.0},
	{1.13, 4.99, 0.56, 180.0},
	{1.13, 0.71, 0.56, 0.0},
	{1.13, 3.79, 0.56, 180.0},
	{1.13, 6.19, 0.56, 180.0},
	{0.00, 0.30, 1.10, 0.0}
};

#define objects_per_shamal 14

#define SETY_DE 5.87
#define SETZ_DE 0.75

stock CreateShamalInt(vehicleid, Float:X, Float:Y, Float:Z)
{
	CreateObject(14404, X, Y, Z, 0.0, 0.0, 0.0);
	CreateObject(1562, X+difc[0][0], Y+difc[0][1], Z-difc[0][2], 0.0, 0.0, difc[0][3]);
	CreateObject(1562, X+difc[1][0], Y-difc[1][1], Z-difc[1][2], 0.0, 0.0, difc[1][3]);
	CreateObject(1562, X+difc[2][0], Y-difc[2][1], Z-difc[2][2], 0.0, 0.0, difc[2][3]);
	CreateObject(1562, X-difc[3][0], Y-difc[3][1], Z-difc[3][2], 0.0, 0.0, difc[3][3]);
	CreateObject(1562, X-difc[4][0], Y-difc[4][1], Z-difc[4][2], 0.0, 0.0, difc[4][3]);
	CreateObject(1562, X-difc[5][0], Y-difc[5][1], Z-difc[5][2], 0.0, 0.0, difc[5][3]);
	CreateObject(1563, X+difc[6][0], Y+difc[6][1], Z-difc[6][2], 0.0, 0.0, difc[6][3]);
	CreateObject(1563, X+difc[7][0], Y-difc[7][1], Z-difc[7][2], 0.0, 0.0, difc[7][3]);
	CreateObject(1563, X+difc[8][0], Y-difc[8][1], Z-difc[8][2], 0.0, 0.0, difc[8][3]);
	CreateObject(1563, X-difc[9][0], Y-difc[9][1], Z-difc[9][2], 0.0, 0.0, difc[9][3]);
	CreateObject(1563, X-difc[10][0], Y-difc[10][1], Z-difc[10][2], 0.0, 0.0, difc[10][3]);
	CreateObject(1563, X-difc[11][0], Y-difc[11][1], Z-difc[11][2], 0.0, 0.0, difc[11][3]);
	CreateObject(14405, X, Y-difc[12][1], Z-difc[12][2], 0.0, 0.0, difc[12][3]);
	ShamalPos[vehicleid][0] = X, ShamalPos[vehicleid][1] = Y, ShamalPos[vehicleid][2] = Z;
}

stock SetPlayerPosInShamal(playerid, shamalid)
{
	SetPlayerPos(playerid, ShamalPos[shamalid][0], ShamalPos[shamalid][1]-SETY_DE, ShamalPos[shamalid][2]-SETZ_DE);
	SetPlayerFacingAngle(playerid, 0.0);
	SetCameraBehindPlayer(playerid);
	InShamal[playerid] = shamalid;
}

stock ShamalExists(vehicleid)
{
	if (floatsqroot(ShamalPos[vehicleid][0] + ShamalPos[vehicleid][1] + ShamalPos[vehicleid][2]))
	{
		return 1;
	}
	return 0;
}

Float:randomEx(randval)
{
	new rand1 = random(2), rand2;
	return float(rand1 == 0 ? rand2 - random(randval) : rand2 + random(randval));
}

stock get_available_objects()
{
	new objects = 0;
	for (new i = 1; i <= MAX_OBJECTS; i++) {
		if (IsValidObject(i)) objects ++;
	}
	return MAX_OBJECTS-objects;
}

forward ExplodeShamal(vehicleid);
public ExplodeShamal(vehicleid)
{
	KillTimer(sExplode[vehicleid]);
	if (tCount[vehicleid])
	{
		CreateExplosion(ShamalPos[vehicleid][0], ShamalPos[vehicleid][1], ShamalPos[vehicleid][2], 2, 15.0);
		sExplode[vehicleid] = SetTimerEx("ExplodeShamal", random(1300) + 100, 0, "d", vehicleid);
	}
}
//==============================================================================
forward OnPlayerRegister(playerid, password[]);
forward OnPlayerLogin(playerid,password[]);
forward OnPlayerDataSave(playerid);
forward SetPlayerSpawn(playerid);
forward GameModeRestart();
forward GameModeRestartFunction();
forward ShowTut(playerid);
forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward GetClosestPlayer(p1);
forward ClearCheckpointsForPlayer(playerid);
forward Float:GetDistanceBetweenPlayers(p1,p2);
forward FixHour(hour);
forward SyncTime();
forward UpdateData();
forward UpdateScore();
forward SaveAccounts();
forward Update();
forward PayDay();
forward UpdateMoney();
forward ResetStats(playerid);
forward LoadScript();
forward SaveDynamicCars();
forward LoadDynamicCars();
forward LoadDynamicFactions();
forward SaveDynamicFactions();
forward LoadCivilianSpawn();
forward SaveCivilianSpawn();
forward LoadBuildings();
forward SaveBuildings();
forward SaveBusinesses();
forward LoadBusinesses();
forward LoadHouses();
forward SaveHouses();
forward LoadFactionMaterialsStorage();
forward SaveFactionMaterialsStorage();
forward LoadFactionDrugsStorage();
forward SaveFactionDrugsStorage();
forward LoadDrivingTestPosition();
forward SaveDrivingTestPosition();
forward LoadFlyingTestPosition();
forward SaveFlyingTestPosition();
forward LoadBankPosition();
forward SaveBankPosition();
forward LoadDetectiveJob();
forward SaveDetectiveJob();
forward SaveMechanicJob();
forward LoadMechanicJob();
forward LoadLawyerJob();
forward SaveLawyerJob();
forward LoadProductsSellerJob();
forward SaveProductsSellerJob();
forward LoadGunJob();
forward SaveGunJob();
forward LoadDrugJob();
forward SaveDrugJob();
forward LoadPoliceDutyPosition();
forward SavePoliceDutyPosition();
forward LoadGovernmentDutyPosition();
forward SaveGovernmentDutyPosition();
forward AddsOn();
forward LoadWeaponLicensePosition();
forward SaveWeaponLicensePosition();
forward LoadPoliceArrestPosition();
forward SavePoliceArrestPosition();
forward LoadGovernmentArrestPosition();
forward SaveGovernmentArrestPosition();
forward ProxDetectorS(Float:radi, playerid, targetid);
forward split(const strsrc[], strdest[][], delimiter);
forward AdministratorMessage(color,const string[],level);
forward BanPlayer(playerid,bannedby[MAX_PLAYER_NAME],reason[]);
forward LockPlayerAccount(playerid,bannedby[MAX_PLAYER_NAME],reason[]);
forward KickPlayer(playerid,kickedby[MAX_PLAYER_NAME],reason[]);
forward BanLog(string[]);
forward BanLog(string[]);
forward AccountLockLog(string[]);
forward KickLog(string[]);
forward KickLog(string[]);
forward PayLog(string[]);
forward HackLog(string[]);
forward SMSLog(string[]);
forward DonatorLog(string[]);
forward PMLog(string[]);
forward ReportLog(string[]);
forward OOCLog(string[]);
forward PlayerActionLog(string[]);
forward PlayerLocalLog(string[]);
forward TalkLog(string[]);
forward FactionChatLog(string[]);
forward PickupGametexts();
forward SetPlayerSkinEx(playerid, skinid);
forward ShowStats(playerid,targetid);
forward ShowScriptStats(playerid);
forward SendFactionMessage(faction, color, string[]);
forward SendFactionTypeMessage(factiontype, color, string[]);
forward SetPlayerToFactionSkin(playerid);
forward SetPlayerToFactionColor(playerid);
forward SetPlayerToTeamColor(playerid);
forward PlayerActionMessage(playerid,Float:radius,message[]);
forward PlayerDoMessage(playerid,Float:radius,message[]);
forward PlayerLocalMessage(playerid,Float:radius,message[]);
forward PlayerPlayerActionMessage(playerid,targetid,Float:radius,message[]);
forward IsATowTruck(vehicleid);
forward IsAPlane(vehicleid);
forward IsAHelicopter(vehicleid);
forward IsABike(vehicleid);
forward IsAtGasStation(playerid);
forward IsVehicleOccupied(vehicleid);
forward RemoveDriverFromVehicle(playerid);
forward FuelTimer();
forward SickTimer();
forward HangupTimer(playerid);
forward JailTimer();
forward UntazePlayer(playerid);
forward IdleKick();
forward PhoneAnimation(playerid);
forward IsACopSkin(skinid);
forward IsAGovSkin(skinid);
forward IsANewsSkin(skinid);
forward IsAMafiaSkin(skinid);
forward IsATransportSkin(skinid);
forward IsABallaSkin(skinid);
forward IsAGroveSkin(skinid);
forward IsAAztecaSkin(skinid);
forward IsABikerSkin(skinid);
forward IsATriadSkin(skinid);
forward SetPlayerWeapons(playerid);
forward SafeGivePlayerWeapon(playerid, weaponid, ammo);
forward SafeResetPlayerWeapons(playerid);
forward SetPlayerWantedLevelEx(playerid,level);
forward GetPlayerWantedLevelEx(playerid);
forward ResetPlayerWantedLevelEx(playerid);
forward IsAtBar(playerid);
forward ReleaseFromHospital(playerid);
forward DoHospital(playerid);
forward DrugEffect(playerid);
forward UndrugEffect(playerid);
forward BlindfoldTimer(playerid);
forward Lotto(number);
forward OOCNews(color,const string[]);
forward BackupClear(playerid, calledbytimer);
forward ResetRoadblockTimer();
forward RemoveRoadblock(playerid);
//==============================================================================
forward CreateStreamPickup(model,type,Float:x,Float:y,Float:z,range);
forward StreamPickups();
forward Pickup_AnyPlayerToPoint(Float:radi, Float:x, Float:y, Float:z);
forward DestroyStreamPickup(ID);
forward CountStreamPickups();
forward ChangeStreamPickupModel(ID,newmodel);
forward ChangeStreamPickupType(ID,newtype);
forward MoveStreamPickup(ID,Float:x,Float:y,Float:z);
//==============================================================================
enum pickupINFO
{
	pickupCreated,
	pickupVisible,
	pickupID,
	pickupRange,
	Float:pickupX,
	Float:pickupY,
	Float:pickupZ,
 	pickupType,
	pickupModel
}
new Pickup[MAX_S_PICKUPS+1][pickupINFO];
//==============================================================================
new JoinCounter;
new gPlayerLogged[MAX_PLAYERS];
new TutorialStage[MAX_PLAYERS];
new TutTimer;
new realchat = 1;
new ghour = 0;
new shifthour;
new timeshift = 0;
new realtime = 1;
new intrate = 1;
new levelexp = 3;
new Jackpot = 0;
new RegistrationStep[MAX_PLAYERS];
new TakingDrivingTest[MAX_PLAYERS];
new DrivingTestStep[MAX_PLAYERS];
new SpawnAttempts[MAX_PLAYERS];
new FactionRequest[MAX_PLAYERS];
new Fuel[MAX_VEHICLES];
new EngineStatus[MAX_VEHICLES];
new ShowFuel[MAX_PLAYERS];
new OutOfFuel[MAX_PLAYERS];
new CarWindowStatus[MAX_VEHICLES];
new gLastCar[MAX_PLAYERS];
new MapIconsShown[MAX_PLAYERS];
new Mobile[MAX_PLAYERS];
new PhoneOnline[MAX_PLAYERS];
new Muted[MAX_PLAYERS];
new StartedCall[MAX_PLAYERS];
new adds = 1;
new addtimer = 60000;
new OOCStatus = 0;
new Dice[MAX_PLAYERS];
new AdminDuty[MAX_PLAYERS];
new BigEar[MAX_PLAYERS];
new PMsEnabled[MAX_PLAYERS];
new TalkingLive[MAX_PLAYERS];
new LiveOffer[MAX_PLAYERS];
new CarOffer[MAX_PLAYERS];
new CarPrice[MAX_PLAYERS];
new CarID[MAX_PLAYERS];
new CarCalls[MAX_PLAYERS];
new BegOffer[MAX_PLAYERS];
new BegPrice[MAX_PLAYERS];
new RepairOffer[MAX_PLAYERS];
new RepairPrice[MAX_PLAYERS];
new RepairCar[MAX_PLAYERS];
new RefillOffer[MAX_PLAYERS];
new RefillPrice[MAX_PLAYERS];
new Blindfold[MAX_PLAYERS];
new VehicleLocked[MAX_VEHICLES];
new VehicleLockedPlayer[MAX_PLAYERS];
new WantedPoints[MAX_PLAYERS];
new WantedLevel[MAX_PLAYERS];
new CopOnDuty[MAX_PLAYERS];
new JailPrice[MAX_PLAYERS];
new PlayerCuffed[MAX_PLAYERS];
new PlayerTazed[MAX_PLAYERS];
new PlayerTied[MAX_PLAYERS];
new roadblocktimer = 0;
new Float:PlayerPos[MAX_PLAYERS][6];
new TicketOffer[MAX_PLAYERS];
new TicketMoney[MAX_PLAYERS];
new MatsHolding[MAX_PLAYERS];
new DrugsHolding[MAX_PLAYERS];
new DrugsIntake[MAX_PLAYERS];
new TrackingPlayer[MAX_PLAYERS];
new ProductsOffer[MAX_PLAYERS];
new ProductsAmount[MAX_PLAYERS];
new ProductsCost[MAX_PLAYERS];
//==============================================================================
enum pInfo
{
	pKey[128],
	pLevel,
	pAdmin,
	pDonateRank,
	pRegistered,
	pTut,
	pSex,
	pAge,
	pExp,
	pCash,
	pGun1,
	pGun2,
	pGun3,
	pGun4,
	pAmmo1,
	pAmmo2,
	pAmmo3,
	pAmmo4,
	pCarKey,
	pCarKey2,
	pCarKey3,
    pUnableToDropCar,
	Float:pCarX,
	Float:pCarY,
	Float:pCarZ,
	pCarNos,
	pCarColor1,
	pCarColor2,
	pCarModel,
	pBank,
	pDeathFreeze,
	pFlop1,
	pFlop2,
	pFlop3,
	pTurn,
	pRiver,
	pDealer,
	pSkin,
	pDrugs,
	pMaterials,
	pProducts,
	pJob,
	pCards,
	pCard1,
	pCard2,
	pContractTime,
	pPlayingHours,
	pAllowedPayday,
	pPayCheck,
	pFaction,
	pRank,
	pHouseKey,
	pBizKey,
	pSpawnPoint,
	pWarnings,
	pCarLic,
	pFlyLic,
	pWepLic,
	pVisitPass,
	pPhoneNumber,
	pPhoneC,
	pPhoneBook,
	pLottoNr,
	pListNumber,
	pDonator,
	pJailed,
	pJailTime,
	pHospital,
	pRequestingBackup,
	pRoadblock,
	pNote1[128],
	pNote1s,
	pNote2[128],
	pNote2s,
	pNote3[128],
	pNote3s,
	pNote4[128],
	pNote4s,
	pNote5[128],
	pNote5s,
	Float:pLoadPosX,
	Float:pLoadPosY,
	Float:pLoadPosZ,
	pLoadPosInt,
	pLoadPosW,
	pLoadPos,
	pLocked,
};
new PlayerInfo[MAX_PLAYERS][pInfo];

enum Cars
{
	CarModel,
	Float:CarX,
	Float:CarY,
	Float:CarZ,
	Float:CarAngle,
	CarColor1,
	CarColor2,
	FactionCar,
	CarType,
};
new DynamicCars[300][Cars];

enum Factions
{
	fName[50],
	Float:fX,
	Float:fY,
	Float:fZ,
	fMaterials,
	fDrugs,
	fBank,
	fRank1[35],
	fRank2[35],
	fRank3[35],
	fRank4[35],
	fRank5[35],
	fRank6[35],
	fRank7[35],
	fRank8[35],
	fRank9[35],
	fRank10[35],
	fSkin1,
	fSkin2,
	fSkin3,
	fSkin4,
	fSkin5,
	fSkin6,
	fSkin7,
	fSkin8,
	fSkin9,
	fSkin10,
	fJoinRank,
	fUseSkins,
	fType,
	fRankAmount,
	fColor[128],
	fUseColor,
};

new DynamicFactions[12][Factions];

enum CivilianSpawns
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
};
new CivilianSpawn[CivilianSpawns];

enum FactionMaterials
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
	PickupID,
};
new FactionMaterialsStorage[FactionMaterials];

enum FactionDrugs
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
	PickupID,
};
new FactionDrugsStorage[FactionDrugs];

enum DrivingTestLocation
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
	PickupID,
};
new DrivingTestPosition[DrivingTestLocation];

enum BankLocation
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
	PickupID,
};
new BankPosition[BankLocation];

enum ProductsSellerJobInfo
{
	Float:TakeJobX,
	Float:TakeJobY,
	Float:TakeJobZ,
	TakeJobWorld,
	TakeJobInterior,
	Float:TakeJobAngle,
	TakeJobPickupID,
 	Float:BuyProductsX,
	Float:BuyProductsY,
	Float:BuyProductsZ,
	BuyProductsWorld,
	BuyProductsInterior,
	Float:BuyProductsAngle,
	BuyProductsPickupID,
};
new ProductsSellerJob[ProductsSellerJobInfo];

enum GunJobInfo
{
	Float:TakeJobX,
	Float:TakeJobY,
	Float:TakeJobZ,
	TakeJobWorld,
	TakeJobInterior,
	Float:TakeJobAngle,
	TakeJobPickupID,
 	Float:BuyPackagesX,
	Float:BuyPackagesY,
	Float:BuyPackagesZ,
	BuyPackagesWorld,
	BuyPackagesInterior,
	Float:BuyPackagesAngle,
	BuyPackagesPickupID,
  	Float:DeliverX,
	Float:DeliverY,
	Float:DeliverZ,
	DeliverWorld,
	DeliverInterior,
	Float:DeliverAngle,
	DeliverPickupID,
};
new GunJob[GunJobInfo];

enum DrugJobInfo
{
	Float:TakeJobX,
	Float:TakeJobY,
	Float:TakeJobZ,
	TakeJobWorld,
	TakeJobInterior,
	Float:TakeJobAngle,
	TakeJobPickupID,
 	Float:BuyDrugsX,
	Float:BuyDrugsY,
	Float:BuyDrugsZ,
	BuyDrugsWorld,
	BuyDrugsInterior,
	Float:BuyDrugsAngle,
	BuyDrugsPickupID,
  	Float:DeliverX,
	Float:DeliverY,
	Float:DeliverZ,
	DeliverWorld,
	DeliverInterior,
	Float:DeliverAngle,
	DeliverPickupID,
};
new DrugJob[DrugJobInfo];

enum FlyingTestLocation
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
	PickupID,
};
new FlyingTestPosition[FlyingTestLocation];

enum WeaponLicenseLocation
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
	PickupID,
};
new WeaponLicensePosition[WeaponLicenseLocation];

enum PoliceArrestLocation
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
};
new PoliceArrestPosition[PoliceArrestLocation];

enum GovernmentArrestLocation
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
};
new GovernmentArrestPosition[GovernmentArrestLocation];

enum PoliceDutyLocation
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
};
new PoliceDutyPosition[PoliceDutyLocation];

enum GovernmentDutyLocation
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
};
new GovernmentDutyPosition[GovernmentDutyLocation];

enum DetectiveJobLocation
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
	PickupID,
};
new DetectiveJobPosition[DetectiveJobLocation];

enum MechanicJobLocation
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
	PickupID,
};
new MechanicJobPosition[MechanicJobLocation];

enum LawyerJobLocation
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
	PickupID,
};
new LawyerJobPosition[LawyerJobLocation];

enum BuildingSystem
{
	BuildingName[128],
	Float:EnterX,
	Float:EnterY,
	Float:EnterZ,
	EntranceFee,
	EnterWorld,
	EnterInterior,
	Float:EnterAngle,
	Float:ExitX,
	Float:ExitY,
	Float:ExitZ,
	ExitInterior,
	Float:ExitAngle,
	Locked,
	PickupID,
};
new Building[25][BuildingSystem];

enum BusinessSystem
{
	BusinessName[128],
	Owner[MAX_PLAYER_NAME],
	Float:EnterX,
	Float:EnterY,
	Float:EnterZ,
	EnterWorld,
	EnterInterior,
	Float:EnterAngle,
	Float:ExitX,
	Float:ExitY,
	Float:ExitZ,
	ExitInterior,
	Float:ExitAngle,
	Owned,
	Enterable,
	BizPrice,
	EntranceCost,
	Till,
	Locked,
	BizType,
	Products,
	PickupID,
}

new Businesses[200][BusinessSystem];

enum HouseSystem
{
	Description[128],
	Owner[MAX_PLAYER_NAME],
	Float:EnterX,
	Float:EnterY,
	Float:EnterZ,
	EnterWorld,
	EnterInterior,
	Float:EnterAngle,
	Float:ExitX,
	Float:ExitY,
	Float:ExitZ,
	ExitInterior,
	Float:ExitAngle,
	Owned,
	Rentable,
	RentCost,
	HousePrice,
	Materials,
	Drugs,
	Money,
	Locked,
	PickupID,
};
new Houses[200][HouseSystem];

new VehicleNames[212][] =
{
	"400 - Landstalker",   "401 - Bravura",   "402 - Buffalo",   "403 - Linerunner",   "404 - Pereniel",   "405 - Sentinel",   "406 - Dumper",   "407 - Firetruck",   "408 - Trashmaster",   "409 - Stretch",
	"410 - Manana",   "411 - Infernus",   "412 - Voodoo",   "413 - Pony",   "414 - Mule",   "415 - Cheetah",   "416 - Ambulance",   "417 - Leviathan",   "418 - Moonbeam",   "419 - Esperanto",   "420 - Taxi",
	"421 - Washington",   "422 - Bobcat",   "423 - Mr Whoopee",   "424 - BF Injection",   "425 - Hunter",   "426 - Premier",   "427 - Enforcer",   "428 - Securicar",   "429 - Banshee",   "430 - Predator",
	"431 - Bus",   "432 - Rhino",   "433 - Barracks",   "434 - Hotknife",   "435 - Trailer",   "436 - Previon",   "437 - Coach",   "438 - Cabbie",   "439 - Stallion",   "440 - Rumpo",   "441 - RC Bandit",	"442 - Romero",
	"443 - Packer",   "444 - Monster",   "445- Admiral",   "446 - Squalo",   "447 - Seasparrow",   "448 - Pizzaboy",   "449 - Tram",   "450 - Trailer",   "451 - Turismo",   "452 - Speeder",   "453 - Reefer",   "454 - Tropic",   "455 - Flatbed",
	"456 - Yankee",   "457 - Caddy",   "458 - Solair",   "459 - Berkley's RC Van",   "460 - Skimmer",   "461 - PCJ-600",   "462 - Faggio",   "463 - Freeway",   "464 - RC Baron",   "465 - RC Raider",
	"466 - Glendale",   "467 - Oceanic",   "468 - Sanchez",   "469 - Sparrow",   "470 - Patriot",   "471 - Quad",   "472 - Coastguard",   "473 - Dinghy",   "474 - Hermes",   "475 - Sabre",   "476 - Rustler",
	"477 - ZR350",   "478 - Walton",   "479 - Regina",   "480 - Comet",   "481 - BMX",   "482 - Burrito",   "483 - Camper",   "484 - Marquis",   "485 - Baggage",   "486 - Dozer",   "487 - Maverick",   "488 - News Chopper",
	"489 - Rancher",   "490 - FBI Rancher",   "491 - Virgo",   "492 - Greenwood",   "493 - Jetmax",   "494 - Hotring",   "495 - Sandking",   "496 - Blista Compact",   "497 - Police Maverick",
	"498 - Boxville",   "499 - Benson",   "500 - Mesa",   "501 - RC Goblin",   "502 - Hotring Racer",   "503 - Hotring Racer",   "504 - Bloodring Banger",   "505 - Rancher",   "506 - Super GT",
	"507 - Elegant",   "508 - Journey",   "509 - Bike",   "510 - Mountain Bike",   "511 - Beagle",   "512 - Cropdust",   "513 - Stunt",   "514 - Tanker",   "515 - RoadTrain",   "516 - Nebula",   "517 - Majestic",
	"518 - Buccaneer",   "519 - Shamal",   "520 - Hydra",   "521 - FCR-900",   "522 - NRG-500",   "523 - HPV1000",   "524 - Cement Truck",   "525 - Tow Truck",   "526 - Fortune",   "527 - Cadrona",   "528 - FBI Truck",
	"529 - Willard",   "530 - Forklift",   "531 - Tractor",   "532 - Combine",   "533 - Feltzer",   "534 - Remington",   "535 - Slamvan",   "536 - Blade",   "537 - Freight",   "538 - Streak",   "539 - Vortex",   "540 - Vincent",
	"541 - Bullet",   "542 - Clover",   "543 - Sadler",   "544 - Firetruck",   "545 - Hustler",   "546 - Intruder",   "547 - Primo",   "548 - Cargobob",   "549 - Tampa",   "550 - Sunrise",   "551 - Merit",   "552 - Utility",
	"553 - Nevada",   "554 - Yosemite",   "555 - Windsor",   "556 - Monster",   "557 - Monster",   "558 - Uranus",   "559 - Jester",   "560 - Sultan",   "561 - Stratum",   "562 - Elegy",   "563 - Raindance",   "564 - RC Tiger",
	"565 - Flash",   "566 - Tahoma",   "567 - Savanna",   "568 - Bandito",   "569 - Freight",   "570 - Trailer",   "571 - Kart",   "572 - Mower",   "573 - Duneride",   "574 - Sweeper",   "575 - Broadway",
	"576 - Tornado",   "577 - AT-400",   "578 - DFT-30",   "579 - Huntley",   "580 - Stafford",   "581 - BF-400",   "582 - Newsvan",   "583 - Tug",   "584 - Trailer",   "585 - Emperor",   "586 - Wayfarer",
	"587 - Euros",   "588 - Hotdog",   "589 - Club",   "590 - Trailer",   "591 - Trailer",   "592 - Andromada",   "593 - Dodo",   "594 - RC Cam",   "595 - Launch",   "596 - Police Car (LSPD)",   "597 - Police Car (SFPD)",
	"598 - Police Car (LVPD)",   "599 - Police Ranger",   "600 - Picador",   "601 - S.W.A.T. Van",   "602 - Alpha",   "603 - Phoenix",   "604 - Glendale",   "605 - Sadler",   "606 - Luggage Trailer A",
	"607 - Luggage Trailer B",   "608 - Stair Trailer",   "609 - Boxville",   "610 - Farm Plow",   "611 - Utility Trailer"
};

enum SAZONE_MAIN {
		SAZONE_NAME[28],
		Float:SAZONE_AREA[6]
};

static const gSAZones[][SAZONE_MAIN] = {
	//	NAME                            AREA (Xmin,Ymin,Zmin,Xmax,Ymax,Zmax)
	{"The Big Ear",	                {-410.00,1403.30,-3.00,-137.90,1681.20,200.00}},
	{"Aldea Malvada",               {-1372.10,2498.50,0.00,-1277.50,2615.30,200.00}},
	{"Angel Pine",                  {-2324.90,-2584.20,-6.10,-1964.20,-2212.10,200.00}},
	{"Arco del Oeste",              {-901.10,2221.80,0.00,-592.00,2571.90,200.00}},
	{"Avispa Country Club",         {-2646.40,-355.40,0.00,-2270.00,-222.50,200.00}},
	{"Avispa Country Club",         {-2831.80,-430.20,-6.10,-2646.40,-222.50,200.00}},
	{"Avispa Country Club",         {-2361.50,-417.10,0.00,-2270.00,-355.40,200.00}},
	{"Avispa Country Club",         {-2667.80,-302.10,-28.80,-2646.40,-262.30,71.10}},
	{"Avispa Country Club",         {-2470.00,-355.40,0.00,-2270.00,-318.40,46.10}},
	{"Avispa Country Club",         {-2550.00,-355.40,0.00,-2470.00,-318.40,39.70}},
	{"Back o Beyond",               {-1166.90,-2641.10,0.00,-321.70,-1856.00,200.00}},
	{"Battery Point",               {-2741.00,1268.40,-4.50,-2533.00,1490.40,200.00}},
	{"Bayside",                     {-2741.00,2175.10,0.00,-2353.10,2722.70,200.00}},
	{"Bayside Marina",              {-2353.10,2275.70,0.00,-2153.10,2475.70,200.00}},
	{"Beacon Hill",                 {-399.60,-1075.50,-1.40,-319.00,-977.50,198.50}},
	{"Blackfield",                  {964.30,1203.20,-89.00,1197.30,1403.20,110.90}},
	{"Blackfield",                  {964.30,1403.20,-89.00,1197.30,1726.20,110.90}},
	{"Blackfield Chapel",           {1375.60,596.30,-89.00,1558.00,823.20,110.90}},
	{"Blackfield Chapel",           {1325.60,596.30,-89.00,1375.60,795.00,110.90}},
	{"Blackfield Intersection",     {1197.30,1044.60,-89.00,1277.00,1163.30,110.90}},
	{"Blackfield Intersection",     {1166.50,795.00,-89.00,1375.60,1044.60,110.90}},
	{"Blackfield Intersection",     {1277.00,1044.60,-89.00,1315.30,1087.60,110.90}},
	{"Blackfield Intersection",     {1375.60,823.20,-89.00,1457.30,919.40,110.90}},
	{"Blueberry",                   {104.50,-220.10,2.30,349.60,152.20,200.00}},
	{"Blueberry",                   {19.60,-404.10,3.80,349.60,-220.10,200.00}},
	{"Blueberry Acres",             {-319.60,-220.10,0.00,104.50,293.30,200.00}},
	{"Caligula's Palace",           {2087.30,1543.20,-89.00,2437.30,1703.20,110.90}},
	{"Caligula's Palace",           {2137.40,1703.20,-89.00,2437.30,1783.20,110.90}},
	{"Calton Heights",              {-2274.10,744.10,-6.10,-1982.30,1358.90,200.00}},
	{"Chinatown",                   {-2274.10,578.30,-7.60,-2078.60,744.10,200.00}},
	{"City Hall",                   {-2867.80,277.40,-9.10,-2593.40,458.40,200.00}},
	{"Come-A-Lot",                  {2087.30,943.20,-89.00,2623.10,1203.20,110.90}},
	{"Commerce",                    {1323.90,-1842.20,-89.00,1701.90,-1722.20,110.90}},
	{"Commerce",                    {1323.90,-1722.20,-89.00,1440.90,-1577.50,110.90}},
	{"Commerce",                    {1370.80,-1577.50,-89.00,1463.90,-1384.90,110.90}},
	{"Commerce",                    {1463.90,-1577.50,-89.00,1667.90,-1430.80,110.90}},
	{"Commerce",                    {1583.50,-1722.20,-89.00,1758.90,-1577.50,110.90}},
	{"Commerce",                    {1667.90,-1577.50,-89.00,1812.60,-1430.80,110.90}},
	{"Conference Center",           {1046.10,-1804.20,-89.00,1323.90,-1722.20,110.90}},
	{"Conference Center",           {1073.20,-1842.20,-89.00,1323.90,-1804.20,110.90}},
	{"Cranberry Station",           {-2007.80,56.30,0.00,-1922.00,224.70,100.00}},
	{"Creek",                       {2749.90,1937.20,-89.00,2921.60,2669.70,110.90}},
	{"Dillimore",                   {580.70,-674.80,-9.50,861.00,-404.70,200.00}},
	{"Doherty",                     {-2270.00,-324.10,-0.00,-1794.90,-222.50,200.00}},
	{"Doherty",                     {-2173.00,-222.50,-0.00,-1794.90,265.20,200.00}},
	{"Downtown",                    {-1982.30,744.10,-6.10,-1871.70,1274.20,200.00}},
	{"Downtown",                    {-1871.70,1176.40,-4.50,-1620.30,1274.20,200.00}},
	{"Downtown",                    {-1700.00,744.20,-6.10,-1580.00,1176.50,200.00}},
	{"Downtown",                    {-1580.00,744.20,-6.10,-1499.80,1025.90,200.00}},
	{"Downtown",                    {-2078.60,578.30,-7.60,-1499.80,744.20,200.00}},
	{"Downtown",                    {-1993.20,265.20,-9.10,-1794.90,578.30,200.00}},
	{"Downtown Los Santos",         {1463.90,-1430.80,-89.00,1724.70,-1290.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1430.80,-89.00,1812.60,-1250.90,110.90}},
	{"Downtown Los Santos",         {1463.90,-1290.80,-89.00,1724.70,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1384.90,-89.00,1463.90,-1170.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1250.90,-89.00,1812.60,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1170.80,-89.00,1463.90,-1130.80,110.90}},
	{"Downtown Los Santos",         {1378.30,-1130.80,-89.00,1463.90,-1026.30,110.90}},
	{"Downtown Los Santos",         {1391.00,-1026.30,-89.00,1463.90,-926.90,110.90}},
	{"Downtown Los Santos",         {1507.50,-1385.20,110.90,1582.50,-1325.30,335.90}},
	{"East Beach",                  {2632.80,-1852.80,-89.00,2959.30,-1668.10,110.90}},
	{"East Beach",                  {2632.80,-1668.10,-89.00,2747.70,-1393.40,110.90}},
	{"East Beach",                  {2747.70,-1668.10,-89.00,2959.30,-1498.60,110.90}},
	{"East Beach",                  {2747.70,-1498.60,-89.00,2959.30,-1120.00,110.90}},
	{"East Los Santos",             {2421.00,-1628.50,-89.00,2632.80,-1454.30,110.90}},
	{"East Los Santos",             {2222.50,-1628.50,-89.00,2421.00,-1494.00,110.90}},
	{"East Los Santos",             {2266.20,-1494.00,-89.00,2381.60,-1372.00,110.90}},
	{"East Los Santos",             {2381.60,-1494.00,-89.00,2421.00,-1454.30,110.90}},
	{"East Los Santos",             {2281.40,-1372.00,-89.00,2381.60,-1135.00,110.90}},
	{"East Los Santos",             {2381.60,-1454.30,-89.00,2462.10,-1135.00,110.90}},
	{"East Los Santos",             {2462.10,-1454.30,-89.00,2581.70,-1135.00,110.90}},
	{"Easter Basin",                {-1794.90,249.90,-9.10,-1242.90,578.30,200.00}},
	{"Easter Basin",                {-1794.90,-50.00,-0.00,-1499.80,249.90,200.00}},
	{"Easter Bay Airport",          {-1499.80,-50.00,-0.00,-1242.90,249.90,200.00}},
	{"Easter Bay Airport",          {-1794.90,-730.10,-3.00,-1213.90,-50.00,200.00}},
	{"Easter Bay Airport",          {-1213.90,-730.10,0.00,-1132.80,-50.00,200.00}},
	{"Easter Bay Airport",          {-1242.90,-50.00,0.00,-1213.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1213.90,-50.00,-4.50,-947.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1315.40,-405.30,15.40,-1264.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1354.30,-287.30,15.40,-1315.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1490.30,-209.50,15.40,-1264.40,-148.30,25.40}},
	{"Easter Bay Chemicals",        {-1132.80,-768.00,0.00,-956.40,-578.10,200.00}},
	{"Easter Bay Chemicals",        {-1132.80,-787.30,0.00,-956.40,-768.00,200.00}},
	{"El Castillo del Diablo",      {-464.50,2217.60,0.00,-208.50,2580.30,200.00}},
	{"El Castillo del Diablo",      {-208.50,2123.00,-7.60,114.00,2337.10,200.00}},
	{"El Castillo del Diablo",      {-208.50,2337.10,0.00,8.40,2487.10,200.00}},
	{"El Corona",                   {1812.60,-2179.20,-89.00,1970.60,-1852.80,110.90}},
	{"El Corona",                   {1692.60,-2179.20,-89.00,1812.60,-1842.20,110.90}},
	{"El Quebrados",                {-1645.20,2498.50,0.00,-1372.10,2777.80,200.00}},
	{"Esplanade East",              {-1620.30,1176.50,-4.50,-1580.00,1274.20,200.00}},
	{"Esplanade East",              {-1580.00,1025.90,-6.10,-1499.80,1274.20,200.00}},
	{"Esplanade East",              {-1499.80,578.30,-79.60,-1339.80,1274.20,20.30}},
	{"Esplanade North",             {-2533.00,1358.90,-4.50,-1996.60,1501.20,200.00}},
	{"Esplanade North",             {-1996.60,1358.90,-4.50,-1524.20,1592.50,200.00}},
	{"Esplanade North",             {-1982.30,1274.20,-4.50,-1524.20,1358.90,200.00}},
	{"Fallen Tree",                 {-792.20,-698.50,-5.30,-452.40,-380.00,200.00}},
	{"Fallow Bridge",               {434.30,366.50,0.00,603.00,555.60,200.00}},
	{"Fern Ridge",                  {508.10,-139.20,0.00,1306.60,119.50,200.00}},
	{"Financial",                   {-1871.70,744.10,-6.10,-1701.30,1176.40,300.00}},
	{"Fisher's Lagoon",             {1916.90,-233.30,-100.00,2131.70,13.80,200.00}},
	{"Flint Intersection",          {-187.70,-1596.70,-89.00,17.00,-1276.60,110.90}},
	{"Flint Range",                 {-594.10,-1648.50,0.00,-187.70,-1276.60,200.00}},
	{"Fort Carson",                 {-376.20,826.30,-3.00,123.70,1220.40,200.00}},
	{"Foster Valley",               {-2270.00,-430.20,-0.00,-2178.60,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-599.80,-0.00,-1794.90,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-1115.50,0.00,-1794.90,-599.80,200.00}},
	{"Foster Valley",               {-2178.60,-1250.90,0.00,-1794.90,-1115.50,200.00}},
	{"Frederick Bridge",            {2759.20,296.50,0.00,2774.20,594.70,200.00}},
	{"Gant Bridge",                 {-2741.40,1659.60,-6.10,-2616.40,2175.10,200.00}},
	{"Gant Bridge",                 {-2741.00,1490.40,-6.10,-2616.40,1659.60,200.00}},
	{"Ganton",                      {2222.50,-1852.80,-89.00,2632.80,-1722.30,110.90}},
	{"Ganton",                      {2222.50,-1722.30,-89.00,2632.80,-1628.50,110.90}},
	{"Garcia",                      {-2411.20,-222.50,-0.00,-2173.00,265.20,200.00}},
	{"Garcia",                      {-2395.10,-222.50,-5.30,-2354.00,-204.70,200.00}},
	{"Garver Bridge",               {-1339.80,828.10,-89.00,-1213.90,1057.00,110.90}},
	{"Garver Bridge",               {-1213.90,950.00,-89.00,-1087.90,1178.90,110.90}},
	{"Garver Bridge",               {-1499.80,696.40,-179.60,-1339.80,925.30,20.30}},
	{"Glen Park",                   {1812.60,-1449.60,-89.00,1996.90,-1350.70,110.90}},
	{"Glen Park",                   {1812.60,-1100.80,-89.00,1994.30,-973.30,110.90}},
	{"Glen Park",                   {1812.60,-1350.70,-89.00,2056.80,-1100.80,110.90}},
	{"Green Palms",                 {176.50,1305.40,-3.00,338.60,1520.70,200.00}},
	{"Greenglass College",          {964.30,1044.60,-89.00,1197.30,1203.20,110.90}},
	{"Greenglass College",          {964.30,930.80,-89.00,1166.50,1044.60,110.90}},
	{"Hampton Barns",               {603.00,264.30,0.00,761.90,366.50,200.00}},
	{"Hankypanky Point",            {2576.90,62.10,0.00,2759.20,385.50,200.00}},
	{"Harry Gold Parkway",          {1777.30,863.20,-89.00,1817.30,2342.80,110.90}},
	{"Hashbury",                    {-2593.40,-222.50,-0.00,-2411.20,54.70,200.00}},
	{"Hilltop Farm",                {967.30,-450.30,-3.00,1176.70,-217.90,200.00}},
	{"Hunter Quarry",               {337.20,710.80,-115.20,860.50,1031.70,203.70}},
	{"Idlewood",                    {1812.60,-1852.80,-89.00,1971.60,-1742.30,110.90}},
	{"Idlewood",                    {1812.60,-1742.30,-89.00,1951.60,-1602.30,110.90}},
	{"Idlewood",                    {1951.60,-1742.30,-89.00,2124.60,-1602.30,110.90}},
	{"Idlewood",                    {1812.60,-1602.30,-89.00,2124.60,-1449.60,110.90}},
	{"Idlewood",                    {2124.60,-1742.30,-89.00,2222.50,-1494.00,110.90}},
	{"Idlewood",                    {1971.60,-1852.80,-89.00,2222.50,-1742.30,110.90}},
	{"Jefferson",                   {1996.90,-1449.60,-89.00,2056.80,-1350.70,110.90}},
	{"Jefferson",                   {2124.60,-1494.00,-89.00,2266.20,-1449.60,110.90}},
	{"Jefferson",                   {2056.80,-1372.00,-89.00,2281.40,-1210.70,110.90}},
	{"Jefferson",                   {2056.80,-1210.70,-89.00,2185.30,-1126.30,110.90}},
	{"Jefferson",                   {2185.30,-1210.70,-89.00,2281.40,-1154.50,110.90}},
	{"Jefferson",                   {2056.80,-1449.60,-89.00,2266.20,-1372.00,110.90}},
	{"Julius Thruway East",         {2623.10,943.20,-89.00,2749.90,1055.90,110.90}},
	{"Julius Thruway East",         {2685.10,1055.90,-89.00,2749.90,2626.50,110.90}},
	{"Julius Thruway East",         {2536.40,2442.50,-89.00,2685.10,2542.50,110.90}},
	{"Julius Thruway East",         {2625.10,2202.70,-89.00,2685.10,2442.50,110.90}},
	{"Julius Thruway North",        {2498.20,2542.50,-89.00,2685.10,2626.50,110.90}},
	{"Julius Thruway North",        {2237.40,2542.50,-89.00,2498.20,2663.10,110.90}},
	{"Julius Thruway North",        {2121.40,2508.20,-89.00,2237.40,2663.10,110.90}},
	{"Julius Thruway North",        {1938.80,2508.20,-89.00,2121.40,2624.20,110.90}},
	{"Julius Thruway North",        {1534.50,2433.20,-89.00,1848.40,2583.20,110.90}},
	{"Julius Thruway North",        {1848.40,2478.40,-89.00,1938.80,2553.40,110.90}},
	{"Julius Thruway North",        {1704.50,2342.80,-89.00,1848.40,2433.20,110.90}},
	{"Julius Thruway North",        {1377.30,2433.20,-89.00,1534.50,2507.20,110.90}},
	{"Julius Thruway South",        {1457.30,823.20,-89.00,2377.30,863.20,110.90}},
	{"Julius Thruway South",        {2377.30,788.80,-89.00,2537.30,897.90,110.90}},
	{"Julius Thruway West",         {1197.30,1163.30,-89.00,1236.60,2243.20,110.90}},
	{"Julius Thruway West",         {1236.60,2142.80,-89.00,1297.40,2243.20,110.90}},
	{"Juniper Hill",                {-2533.00,578.30,-7.60,-2274.10,968.30,200.00}},
	{"Juniper Hollow",              {-2533.00,968.30,-6.10,-2274.10,1358.90,200.00}},
	{"K.A.C.C. Military Fuels",     {2498.20,2626.50,-89.00,2749.90,2861.50,110.90}},
	{"Kincaid Bridge",              {-1339.80,599.20,-89.00,-1213.90,828.10,110.90}},
	{"Kincaid Bridge",              {-1213.90,721.10,-89.00,-1087.90,950.00,110.90}},
	{"Kincaid Bridge",              {-1087.90,855.30,-89.00,-961.90,986.20,110.90}},
	{"King's",                      {-2329.30,458.40,-7.60,-1993.20,578.30,200.00}},
	{"King's",                      {-2411.20,265.20,-9.10,-1993.20,373.50,200.00}},
	{"King's",                      {-2253.50,373.50,-9.10,-1993.20,458.40,200.00}},
	{"LVA Freight Depot",           {1457.30,863.20,-89.00,1777.40,1143.20,110.90}},
	{"LVA Freight Depot",           {1375.60,919.40,-89.00,1457.30,1203.20,110.90}},
	{"LVA Freight Depot",           {1277.00,1087.60,-89.00,1375.60,1203.20,110.90}},
	{"LVA Freight Depot",           {1315.30,1044.60,-89.00,1375.60,1087.60,110.90}},
	{"LVA Freight Depot",           {1236.60,1163.40,-89.00,1277.00,1203.20,110.90}},
	{"Las Barrancas",               {-926.10,1398.70,-3.00,-719.20,1634.60,200.00}},
	{"Las Brujas",                  {-365.10,2123.00,-3.00,-208.50,2217.60,200.00}},
	{"Las Colinas",                 {1994.30,-1100.80,-89.00,2056.80,-920.80,110.90}},
	{"Las Colinas",                 {2056.80,-1126.30,-89.00,2126.80,-920.80,110.90}},
	{"Las Colinas",                 {2185.30,-1154.50,-89.00,2281.40,-934.40,110.90}},
	{"Las Colinas",                 {2126.80,-1126.30,-89.00,2185.30,-934.40,110.90}},
	{"Las Colinas",                 {2747.70,-1120.00,-89.00,2959.30,-945.00,110.90}},
	{"Las Colinas",                 {2632.70,-1135.00,-89.00,2747.70,-945.00,110.90}},
	{"Las Colinas",                 {2281.40,-1135.00,-89.00,2632.70,-945.00,110.90}},
	{"Las Payasadas",               {-354.30,2580.30,2.00,-133.60,2816.80,200.00}},
	{"Las Venturas Airport",        {1236.60,1203.20,-89.00,1457.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1203.20,-89.00,1777.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1143.20,-89.00,1777.40,1203.20,110.90}},
	{"Las Venturas Airport",        {1515.80,1586.40,-12.50,1729.90,1714.50,87.50}},
	{"Last Dime Motel",             {1823.00,596.30,-89.00,1997.20,823.20,110.90}},
	{"Leafy Hollow",                {-1166.90,-1856.00,0.00,-815.60,-1602.00,200.00}},
	{"Liberty City",                {-1000.00,400.00,1300.00,-700.00,600.00,1400.00}},
	{"Lil' Probe Inn",              {-90.20,1286.80,-3.00,153.80,1554.10,200.00}},
	{"Linden Side",                 {2749.90,943.20,-89.00,2923.30,1198.90,110.90}},
	{"Linden Station",              {2749.90,1198.90,-89.00,2923.30,1548.90,110.90}},
	{"Linden Station",              {2811.20,1229.50,-39.50,2861.20,1407.50,60.40}},
	{"Little Mexico",               {1701.90,-1842.20,-89.00,1812.60,-1722.20,110.90}},
	{"Little Mexico",               {1758.90,-1722.20,-89.00,1812.60,-1577.50,110.90}},
	{"Los Flores",                  {2581.70,-1454.30,-89.00,2632.80,-1393.40,110.90}},
	{"Los Flores",                  {2581.70,-1393.40,-89.00,2747.70,-1135.00,110.90}},
	{"Los Santos International",    {1249.60,-2394.30,-89.00,1852.00,-2179.20,110.90}},
	{"Los Santos International",    {1852.00,-2394.30,-89.00,2089.00,-2179.20,110.90}},
	{"Los Santos International",    {1382.70,-2730.80,-89.00,2201.80,-2394.30,110.90}},
	{"Los Santos International",    {1974.60,-2394.30,-39.00,2089.00,-2256.50,60.90}},
	{"Los Santos International",    {1400.90,-2669.20,-39.00,2189.80,-2597.20,60.90}},
	{"Los Santos International",    {2051.60,-2597.20,-39.00,2152.40,-2394.30,60.90}},
	{"Marina",                      {647.70,-1804.20,-89.00,851.40,-1577.50,110.90}},
	{"Marina",                      {647.70,-1577.50,-89.00,807.90,-1416.20,110.90}},
	{"Marina",                      {807.90,-1577.50,-89.00,926.90,-1416.20,110.90}},
	{"Market",                      {787.40,-1416.20,-89.00,1072.60,-1310.20,110.90}},
	{"Market",                      {952.60,-1310.20,-89.00,1072.60,-1130.80,110.90}},
	{"Market",                      {1072.60,-1416.20,-89.00,1370.80,-1130.80,110.90}},
	{"Market",                      {926.90,-1577.50,-89.00,1370.80,-1416.20,110.90}},
	{"Market Station",              {787.40,-1410.90,-34.10,866.00,-1310.20,65.80}},
	{"Martin Bridge",               {-222.10,293.30,0.00,-122.10,476.40,200.00}},
	{"Missionary Hill",             {-2994.40,-811.20,0.00,-2178.60,-430.20,200.00}},
	{"Montgomery",                  {1119.50,119.50,-3.00,1451.40,493.30,200.00}},
	{"Montgomery",                  {1451.40,347.40,-6.10,1582.40,420.80,200.00}},
	{"Montgomery Intersection",     {1546.60,208.10,0.00,1745.80,347.40,200.00}},
	{"Montgomery Intersection",     {1582.40,347.40,0.00,1664.60,401.70,200.00}},
	{"Mulholland",                  {1414.00,-768.00,-89.00,1667.60,-452.40,110.90}},
	{"Mulholland",                  {1281.10,-452.40,-89.00,1641.10,-290.90,110.90}},
	{"Mulholland",                  {1269.10,-768.00,-89.00,1414.00,-452.40,110.90}},
	{"Mulholland",                  {1357.00,-926.90,-89.00,1463.90,-768.00,110.90}},
	{"Mulholland",                  {1318.10,-910.10,-89.00,1357.00,-768.00,110.90}},
	{"Mulholland",                  {1169.10,-910.10,-89.00,1318.10,-768.00,110.90}},
	{"Mulholland",                  {768.60,-954.60,-89.00,952.60,-860.60,110.90}},
	{"Mulholland",                  {687.80,-860.60,-89.00,911.80,-768.00,110.90}},
	{"Mulholland",                  {737.50,-768.00,-89.00,1142.20,-674.80,110.90}},
	{"Mulholland",                  {1096.40,-910.10,-89.00,1169.10,-768.00,110.90}},
	{"Mulholland",                  {952.60,-937.10,-89.00,1096.40,-860.60,110.90}},
	{"Mulholland",                  {911.80,-860.60,-89.00,1096.40,-768.00,110.90}},
	{"Mulholland",                  {861.00,-674.80,-89.00,1156.50,-600.80,110.90}},
	{"Mulholland Intersection",     {1463.90,-1150.80,-89.00,1812.60,-768.00,110.90}},
	{"North Rock",                  {2285.30,-768.00,0.00,2770.50,-269.70,200.00}},
	{"Ocean Docks",                 {2373.70,-2697.00,-89.00,2809.20,-2330.40,110.90}},
	{"Ocean Docks",                 {2201.80,-2418.30,-89.00,2324.00,-2095.00,110.90}},
	{"Ocean Docks",                 {2324.00,-2302.30,-89.00,2703.50,-2145.10,110.90}},
	{"Ocean Docks",                 {2089.00,-2394.30,-89.00,2201.80,-2235.80,110.90}},
	{"Ocean Docks",                 {2201.80,-2730.80,-89.00,2324.00,-2418.30,110.90}},
	{"Ocean Docks",                 {2703.50,-2302.30,-89.00,2959.30,-2126.90,110.90}},
	{"Ocean Docks",                 {2324.00,-2145.10,-89.00,2703.50,-2059.20,110.90}},
	{"Ocean Flats",                 {-2994.40,277.40,-9.10,-2867.80,458.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-222.50,-0.00,-2593.40,277.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-430.20,-0.00,-2831.80,-222.50,200.00}},
	{"Octane Springs",              {338.60,1228.50,0.00,664.30,1655.00,200.00}},
	{"Old Venturas Strip",          {2162.30,2012.10,-89.00,2685.10,2202.70,110.90}},
	{"Palisades",                   {-2994.40,458.40,-6.10,-2741.00,1339.60,200.00}},
	{"Palomino Creek",              {2160.20,-149.00,0.00,2576.90,228.30,200.00}},
	{"Paradiso",                    {-2741.00,793.40,-6.10,-2533.00,1268.40,200.00}},
	{"Pershing Square",             {1440.90,-1722.20,-89.00,1583.50,-1577.50,110.90}},
	{"Pilgrim",                     {2437.30,1383.20,-89.00,2624.40,1783.20,110.90}},
	{"Pilgrim",                     {2624.40,1383.20,-89.00,2685.10,1783.20,110.90}},
	{"Pilson Intersection",         {1098.30,2243.20,-89.00,1377.30,2507.20,110.90}},
	{"Pirates in Men's Pants",      {1817.30,1469.20,-89.00,2027.40,1703.20,110.90}},
	{"Playa del Seville",           {2703.50,-2126.90,-89.00,2959.30,-1852.80,110.90}},
	{"Prickle Pine",                {1534.50,2583.20,-89.00,1848.40,2863.20,110.90}},
	{"Prickle Pine",                {1117.40,2507.20,-89.00,1534.50,2723.20,110.90}},
	{"Prickle Pine",                {1848.40,2553.40,-89.00,1938.80,2863.20,110.90}},
	{"Prickle Pine",                {1938.80,2624.20,-89.00,2121.40,2861.50,110.90}},
	{"Queens",                      {-2533.00,458.40,0.00,-2329.30,578.30,200.00}},
	{"Queens",                      {-2593.40,54.70,0.00,-2411.20,458.40,200.00}},
	{"Queens",                      {-2411.20,373.50,0.00,-2253.50,458.40,200.00}},
	{"Randolph Industrial Estate",  {1558.00,596.30,-89.00,1823.00,823.20,110.90}},
	{"Redsands East",               {1817.30,2011.80,-89.00,2106.70,2202.70,110.90}},
	{"Redsands East",               {1817.30,2202.70,-89.00,2011.90,2342.80,110.90}},
	{"Redsands East",               {1848.40,2342.80,-89.00,2011.90,2478.40,110.90}},
	{"Redsands West",               {1236.60,1883.10,-89.00,1777.30,2142.80,110.90}},
	{"Redsands West",               {1297.40,2142.80,-89.00,1777.30,2243.20,110.90}},
	{"Redsands West",               {1377.30,2243.20,-89.00,1704.50,2433.20,110.90}},
	{"Redsands West",               {1704.50,2243.20,-89.00,1777.30,2342.80,110.90}},
	{"Regular Tom",                 {-405.70,1712.80,-3.00,-276.70,1892.70,200.00}},
	{"Richman",                     {647.50,-1118.20,-89.00,787.40,-954.60,110.90}},
	{"Richman",                     {647.50,-954.60,-89.00,768.60,-860.60,110.90}},
	{"Richman",                     {225.10,-1369.60,-89.00,334.50,-1292.00,110.90}},
	{"Richman",                     {225.10,-1292.00,-89.00,466.20,-1235.00,110.90}},
	{"Richman",                     {72.60,-1404.90,-89.00,225.10,-1235.00,110.90}},
	{"Richman",                     {72.60,-1235.00,-89.00,321.30,-1008.10,110.90}},
	{"Richman",                     {321.30,-1235.00,-89.00,647.50,-1044.00,110.90}},
	{"Richman",                     {321.30,-1044.00,-89.00,647.50,-860.60,110.90}},
	{"Richman",                     {321.30,-860.60,-89.00,687.80,-768.00,110.90}},
	{"Richman",                     {321.30,-768.00,-89.00,700.70,-674.80,110.90}},
	{"Robada Intersection",         {-1119.00,1178.90,-89.00,-862.00,1351.40,110.90}},
	{"Roca Escalante",              {2237.40,2202.70,-89.00,2536.40,2542.50,110.90}},
	{"Roca Escalante",              {2536.40,2202.70,-89.00,2625.10,2442.50,110.90}},
	{"Rockshore East",              {2537.30,676.50,-89.00,2902.30,943.20,110.90}},
	{"Rockshore West",              {1997.20,596.30,-89.00,2377.30,823.20,110.90}},
	{"Rockshore West",              {2377.30,596.30,-89.00,2537.30,788.80,110.90}},
	{"Rodeo",                       {72.60,-1684.60,-89.00,225.10,-1544.10,110.90}},
	{"Rodeo",                       {72.60,-1544.10,-89.00,225.10,-1404.90,110.90}},
	{"Rodeo",                       {225.10,-1684.60,-89.00,312.80,-1501.90,110.90}},
	{"Rodeo",                       {225.10,-1501.90,-89.00,334.50,-1369.60,110.90}},
	{"Rodeo",                       {334.50,-1501.90,-89.00,422.60,-1406.00,110.90}},
	{"Rodeo",                       {312.80,-1684.60,-89.00,422.60,-1501.90,110.90}},
	{"Rodeo",                       {422.60,-1684.60,-89.00,558.00,-1570.20,110.90}},
	{"Rodeo",                       {558.00,-1684.60,-89.00,647.50,-1384.90,110.90}},
	{"Rodeo",                       {466.20,-1570.20,-89.00,558.00,-1385.00,110.90}},
	{"Rodeo",                       {422.60,-1570.20,-89.00,466.20,-1406.00,110.90}},
	{"Rodeo",                       {466.20,-1385.00,-89.00,647.50,-1235.00,110.90}},
	{"Rodeo",                       {334.50,-1406.00,-89.00,466.20,-1292.00,110.90}},
	{"Royal Casino",                {2087.30,1383.20,-89.00,2437.30,1543.20,110.90}},
	{"San Andreas Sound",           {2450.30,385.50,-100.00,2759.20,562.30,200.00}},
	{"Santa Flora",                 {-2741.00,458.40,-7.60,-2533.00,793.40,200.00}},
	{"Santa Maria Beach",           {342.60,-2173.20,-89.00,647.70,-1684.60,110.90}},
	{"Santa Maria Beach",           {72.60,-2173.20,-89.00,342.60,-1684.60,110.90}},
	{"Shady Cabin",                 {-1632.80,-2263.40,-3.00,-1601.30,-2231.70,200.00}},
	{"Shady Creeks",                {-1820.60,-2643.60,-8.00,-1226.70,-1771.60,200.00}},
	{"Shady Creeks",                {-2030.10,-2174.80,-6.10,-1820.60,-1771.60,200.00}},
	{"Sobell Rail Yards",           {2749.90,1548.90,-89.00,2923.30,1937.20,110.90}},
	{"Spinybed",                    {2121.40,2663.10,-89.00,2498.20,2861.50,110.90}},
	{"Starfish Casino",             {2437.30,1783.20,-89.00,2685.10,2012.10,110.90}},
	{"Starfish Casino",             {2437.30,1858.10,-39.00,2495.00,1970.80,60.90}},
	{"Starfish Casino",             {2162.30,1883.20,-89.00,2437.30,2012.10,110.90}},
	{"Temple",                      {1252.30,-1130.80,-89.00,1378.30,-1026.30,110.90}},
	{"Temple",                      {1252.30,-1026.30,-89.00,1391.00,-926.90,110.90}},
	{"Temple",                      {1252.30,-926.90,-89.00,1357.00,-910.10,110.90}},
	{"Temple",                      {952.60,-1130.80,-89.00,1096.40,-937.10,110.90}},
	{"Temple",                      {1096.40,-1130.80,-89.00,1252.30,-1026.30,110.90}},
	{"Temple",                      {1096.40,-1026.30,-89.00,1252.30,-910.10,110.90}},
	{"The Camel's Toe",             {2087.30,1203.20,-89.00,2640.40,1383.20,110.90}},
	{"The Clown's Pocket",          {2162.30,1783.20,-89.00,2437.30,1883.20,110.90}},
	{"The Emerald Isle",            {2011.90,2202.70,-89.00,2237.40,2508.20,110.90}},
	{"The Farm",                    {-1209.60,-1317.10,114.90,-908.10,-787.30,251.90}},
	{"The Four Dragons Casino",     {1817.30,863.20,-89.00,2027.30,1083.20,110.90}},
	{"The High Roller",             {1817.30,1283.20,-89.00,2027.30,1469.20,110.90}},
	{"The Mako Span",               {1664.60,401.70,0.00,1785.10,567.20,200.00}},
	{"The Panopticon",              {-947.90,-304.30,-1.10,-319.60,327.00,200.00}},
	{"The Pink Swan",               {1817.30,1083.20,-89.00,2027.30,1283.20,110.90}},
	{"The Sherman Dam",             {-968.70,1929.40,-3.00,-481.10,2155.20,200.00}},
	{"The Strip",                   {2027.40,863.20,-89.00,2087.30,1703.20,110.90}},
	{"The Strip",                   {2106.70,1863.20,-89.00,2162.30,2202.70,110.90}},
	{"The Strip",                   {2027.40,1783.20,-89.00,2162.30,1863.20,110.90}},
	{"The Strip",                   {2027.40,1703.20,-89.00,2137.40,1783.20,110.90}},
	{"The Visage",                  {1817.30,1863.20,-89.00,2106.70,2011.80,110.90}},
	{"The Visage",                  {1817.30,1703.20,-89.00,2027.40,1863.20,110.90}},
	{"Unity Station",               {1692.60,-1971.80,-20.40,1812.60,-1932.80,79.50}},
	{"Valle Ocultado",              {-936.60,2611.40,2.00,-715.90,2847.90,200.00}},
	{"Verdant Bluffs",              {930.20,-2488.40,-89.00,1249.60,-2006.70,110.90}},
	{"Verdant Bluffs",              {1073.20,-2006.70,-89.00,1249.60,-1842.20,110.90}},
	{"Verdant Bluffs",              {1249.60,-2179.20,-89.00,1692.60,-1842.20,110.90}},
	{"Verdant Meadows",             {37.00,2337.10,-3.00,435.90,2677.90,200.00}},
	{"Verona Beach",                {647.70,-2173.20,-89.00,930.20,-1804.20,110.90}},
	{"Verona Beach",                {930.20,-2006.70,-89.00,1073.20,-1804.20,110.90}},
	{"Verona Beach",                {851.40,-1804.20,-89.00,1046.10,-1577.50,110.90}},
	{"Verona Beach",                {1161.50,-1722.20,-89.00,1323.90,-1577.50,110.90}},
	{"Verona Beach",                {1046.10,-1722.20,-89.00,1161.50,-1577.50,110.90}},
	{"Vinewood",                    {787.40,-1310.20,-89.00,952.60,-1130.80,110.90}},
	{"Vinewood",                    {787.40,-1130.80,-89.00,952.60,-954.60,110.90}},
	{"Vinewood",                    {647.50,-1227.20,-89.00,787.40,-1118.20,110.90}},
	{"Vinewood",                    {647.70,-1416.20,-89.00,787.40,-1227.20,110.90}},
	{"Whitewood Estates",           {883.30,1726.20,-89.00,1098.30,2507.20,110.90}},
	{"Whitewood Estates",           {1098.30,1726.20,-89.00,1197.30,2243.20,110.90}},
	{"Willowfield",                 {1970.60,-2179.20,-89.00,2089.00,-1852.80,110.90}},
	{"Willowfield",                 {2089.00,-2235.80,-89.00,2201.80,-1989.90,110.90}},
	{"Willowfield",                 {2089.00,-1989.90,-89.00,2324.00,-1852.80,110.90}},
	{"Willowfield",                 {2201.80,-2095.00,-89.00,2324.00,-1989.90,110.90}},
	{"Willowfield",                 {2541.70,-1941.40,-89.00,2703.50,-1852.80,110.90}},
	{"Willowfield",                 {2324.00,-2059.20,-89.00,2541.70,-1852.80,110.90}},
	{"Willowfield",                 {2541.70,-2059.20,-89.00,2703.50,-1941.40,110.90}},
	{"Yellow Bell Station",         {1377.40,2600.40,-21.90,1492.40,2687.30,78.00}},
	// Main Zones
	{"Los Santos",                  {44.60,-2892.90,-242.90,2997.00,-768.00,900.00}},
	{"Las Venturas",                {869.40,596.30,-242.90,2997.00,2993.80,900.00}},
	{"Bone County",                 {-480.50,596.30,-242.90,869.40,2993.80,900.00}},
	{"Tierra Robada",               {-2997.40,1659.60,-242.90,-480.50,2993.80,900.00}},
	{"Tierra Robada",               {-1213.90,596.30,-242.90,-480.50,1659.60,900.00}},
	{"San Fierro",                  {-2997.40,-1115.50,-242.90,-1213.90,1659.60,900.00}},
	{"Red County",                  {-1213.90,-768.00,-242.90,2997.00,596.30,900.00}},
	{"Flint County",                {-1213.90,-2892.90,-242.90,44.60,-768.00,900.00}},
	{"Whetstone",                   {-2997.40,-2892.90,-242.90,-1213.90,-1115.50,900.00}}
};
//==============================================================================

main()
{   print("NEWYORKROLEPLAYNEWYORKROLEPLAYNEWYORKROLEPLAYNEWYORKROLEPLAYNEWYORKROLEPLAY");
    print("NEWYORKROLEPLAYNEWYORKROLEPLAYNEWYORKROLEPLAYNEWYORKROLEPLAYNEWYORKROLEPLAY");
    print("NEWYORKROLEPLAYNEWYORKROLEPLAYNEWYORKROLEPLAYNEWYORKROLEPLAYNEWYORKROLEPLAY");
    print("NEWYORKROLEPLAYNEWYORKROLEPLAYNEWYORKROLEPLAYNEWYORKROLEPLAYNEWYORKROLEPLAY");
    print("NEWYORKROLEPLAYNEWYORKROLEPLAYNEWYORKROLEPLAYNEWYORKROLEPLAYNEWYORKROLEPLAY");
    print("NEWYORKROLEPLAYNEWYORKROLEPLAYNEWYORKROLEPLAYNEWYORKROLEPLAYNEWYORKROLEPLAY");
	print("<|> The Godfather <|>");
	printf("> %s - %s by %s loaded", GAMEMODE,MAP_NAME,DEVELOPER);
	printf("> Server Name: %s", SERVER_NAME);
	if (!strcmp("Yes", GAMEMODE_USE_VERSION, true)) { printf("> Gamemode: %s - %s", GAMEMODE,VERSION); } else { printf("> Gamemode: %s", GAMEMODE); }
	printf("> Version: %s", VERSION);
	printf("> Map: %s", MAP_NAME);
	printf("> Website: %s", WEBSITE);
	printf("> Developer: %s", DEVELOPER);
	printf("> Last Update: %s", LAST_UPDATE);
	printf("> Current Script Lines: %d", SCRIPT_LINES);
 	printf("> Password: %s", ShowServerPassword());
	print("<|> The Godfather <|>");
}

public OnGameModeInit()
{
    Textdraw0 = TextDrawCreate(187.000000,427.500000,"forum.the-god-father.com");
    TextDrawAlignment(Textdraw0,0);
    TextDrawBackgroundColor(Textdraw0,0x000000ff);
    TextDrawFont(Textdraw0,1);
    TextDrawLetterSize(Textdraw0,0.999998,2.000000);
    TextDrawColor(Textdraw0,COLOR_NEWOOC);
    TextDrawSetOutline(Textdraw0,1);
    TextDrawSetProportional(Textdraw0,1);
    TextDrawSetShadow(Textdraw0,1);
	if(fexist("New York Roleplay/Other/JoinCounter.cfg"))
	{
	    JoinCounter = dini_Int("New York Roleplay/Other/JoinCounter.cfg", "Connections");
	    printf("file \"JoinCounter.txt\" located, variable JoinCounter loaded (%d visitors)", JoinCounter);
	}
	else
	{
	    dini_Create("New York Roleplay/Other/JoinCounter.cfg");
	    dini_IntSet("New York Roleplay/Other/JoinCounter.cfg", "Connections", 0);
	    print("file \"New York Roleplay/Other/JoinCounter.cfg\" created with JoinCounter variable (0 visitors)");
	}
	//==========================================================================
	for(new c=0;c<MAX_VEHICLES;c++)
	{
		Fuel[c] = GasMax;
		EngineStatus[c] = 0;
		VehicleLocked[c] = 0;
		CarWindowStatus[c] = 1;
	}
	//==========================================================================
	RaceActive=0;
	Ranking=1;
	LCurrentCheckpoint=0;
	Participants=0;
	for(new i;i<MAX_BUILDERS;i++)
	{
	    BuilderSlots[i]=MAX_PLAYERS+1;
	}
	if(RRotation != -1) SetTimer("RaceRotation",RRotationDelay,1);
	CreateRaceMenus();
	//==========================================================================
	ShowPlayerMarkers(0);
	ShowNameTags(1);
	SetNameTagDrawDistance(40.0);
	EnableStuntBonusForAll(0);
    DisableInteriorEnterExits();
    AllowInteriorWeapons(1);
	AllowAdminTeleport(1);
	//==========================================================================
	new sendcmd[128];
	if (!strcmp("Yes", GAMEMODE_USE_VERSION, true)) { format(sendcmd, sizeof(sendcmd), "%s - %s", GAMEMODE,VERSION); SetGameModeText(sendcmd); }
	else { SetGameModeText(GAMEMODE); }
	format(sendcmd, sizeof(sendcmd), "hostname %s", SERVER_NAME);
	SendRconCommand(sendcmd);
	format(sendcmd, sizeof(sendcmd), "mapname %s", MAP_NAME);
	SendRconCommand(sendcmd);
	format(sendcmd, sizeof(sendcmd), "weburl %s", WEBSITE);
	SendRconCommand(sendcmd);
	if (strlen(PASSWORD) != 0) { format(sendcmd, sizeof(sendcmd), "password %s", PASSWORD); SendRconCommand(sendcmd); }
	//==========================================================================
	CreateObject(18449, 2907.836426, -1963.764160, 9.668781, 0.0000, 0.0000, 0.0000);
	CreateObject(18449, 2987.578125, -1963.795288, 9.663846, 0.0000, 0.0000, 0.0000);
	CreateObject(18449, 3067.286377, -1963.795410, 9.620049, 0.0000, 0.0000, 0.0000);
	CreateObject(18449, 3146.558105, -1963.794067, 9.646683, 0.0000, 0.0000, 0.0000);
	CreateObject(18449, 3226.355469, -1963.788086, 9.646422, 0.0000, 0.0000, 0.0000);
	CreateObject(8168, 3076.252441, -1958.798096, 11.911773, 0.0000, 0.8594, 17.2923);
	CreateObject(991, 3072.275635, -1959.316284, 11.179040, 0.0000, 0.0000, 269.6564);
	CreateObject(991, 3072.283936, -1959.313110, 13.509651, 0.0000, 0.0000, 269.6564);
	CreateObject(991, 3072.205811, -1969.328857, 11.179040, 0.0000, 90.2408, 270.6186);
	CreateObject(991, 3072.229004, -1970.444580, 11.176836, 0.0000, 90.2408, 270.6186);
	CreateObject(1226, 3069.204834, -1957.246460, 14.202172, 0.0000, 0.0000, 78.2087);
	CreateObject(1226, 3044.626709, -1957.117188, 14.040219, 0.0000, 0.0000, 78.2087);
	CreateObject(1226, 3019.096924, -1957.229614, 14.084016, 0.0000, 0.0000, 78.2087);
	CreateObject(1226, 2994.542480, -1957.184814, 14.084016, 0.0000, 0.0000, 78.2087);
	CreateObject(1226, 2967.908447, -1957.348999, 14.084016, 0.0000, 0.0000, 78.2087);
	CreateObject(1226, 2881.743896, -1957.256470, 14.088951, 0.0000, 0.0000, 78.2087);
	CreateObject(1226, 2905.563721, -1957.167358, 14.088951, 0.0000, 0.0000, 78.2087);
	CreateObject(1226, 2921.950928, -1957.246338, 14.088951, 0.0000, 0.0000, 78.2087);
	CreateObject(1226, 2938.324463, -1957.227661, 14.088951, 0.0000, 0.0000, 78.2087);
	CreateObject(1226, 3068.556152, -1970.334351, 14.065228, 0.0000, 0.0000, 270.6186);
	CreateObject(1226, 3046.487549, -1970.362915, 14.040219, 0.0000, 0.0000, 270.6186);
	CreateObject(1226, 3017.889893, -1970.400879, 14.084016, 0.0000, 0.0000, 270.6186);
	CreateObject(1226, 2994.214111, -1970.322266, 14.014044, 0.0000, 0.0000, 270.6186);
	CreateObject(1226, 2969.445068, -1970.372070, 14.084016, 0.0000, 0.0000, 270.6186);
	CreateObject(1226, 2938.769043, -1970.331543, 14.088951, 0.0000, 0.0000, 270.6186);
	CreateObject(1226, 2922.063721, -1970.389771, 14.183601, 0.0000, 0.0000, 270.6186);
	CreateObject(1226, 2905.452393, -1970.339722, 14.196678, 0.0000, 0.0000, 270.6186);
	CreateObject(1226, 2881.879150, -1970.395142, 14.088951, 0.0000, 0.0000, 270.6186);
	CreateObject(2047, 3078.302734, -1961.323242, 13.205395, 0.0000, 0.0000, 0.0000);
	CreateObject(1226, 3088.234863, -1957.196411, 14.121389, 0.0000, 0.0000, 91.8554);
	CreateObject(1226, 3109.334473, -1957.109863, 14.066853, 0.0000, 0.0000, 91.8554);
	CreateObject(1226, 3134.524902, -1957.266968, 14.066853, 0.0000, 0.0000, 91.8554);
	CreateObject(1226, 3161.928711, -1957.015991, 14.066853, 0.0000, 0.0000, 91.8554);
	CreateObject(1226, 3189.941406, -1957.253296, 14.066592, 0.0000, 0.0000, 91.8554);
	CreateObject(1226, 3219.637939, -1957.046387, 14.066592, 0.0000, 0.0000, 91.8554);
	CreateObject(1226, 3252.392334, -1957.259521, 14.066592, 0.0000, 0.0000, 91.8554);
	CreateObject(1226, 3088.165039, -1970.386353, 14.040219, 0.0000, 0.0000, 269.7592);
	CreateObject(1226, 3109.641602, -1970.369629, 14.220545, 0.0000, 0.0000, 269.7592);
	CreateObject(1226, 3134.641602, -1970.344604, 14.247122, 0.0000, 0.0000, 269.7592);
	CreateObject(1226, 3160.975830, -1970.369629, 14.464777, 0.0000, 0.0000, 269.7592);
	CreateObject(1226, 3190.075928, -1970.340576, 14.066592, 0.0000, 0.0000, 269.7592);
	CreateObject(1226, 3219.847900, -1970.338623, 14.118501, 0.0000, 0.0000, 269.7592);
	CreateObject(1226, 3252.143311, -1970.313599, 14.212169, 0.0000, 0.0000, 269.7592);
	CreateObject(3330, 2938.059082, -1963.330811, -0.886378, 0.0000, 0.0000, 271.4781);
	CreateObject(3330, 3046.517334, -1963.600220, -0.814816, 0.0000, 0.0000, 270.6186);
	CreateObject(3330, 3147.119873, -1963.271362, -0.925523, 0.0000, 0.0000, 270.6186);
	CreateObject(17472, 3266.388672, -1935.389648, -1.004108, 0.0000, 0.0000, 272.9890);
	CreateObject(17472, 3270.316650, -1999.943481, -0.024645, 0.0000, 0.0000, 272.3375);
	CreateObject(3997, 3345.981201, -1969.354126, 9.968218, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 3278.069824, -1971.308716, 9.992108, 0.0000, 0.0000, 180.4818);
	CreateObject(987, 3266.332031, -1956.208618, 10.403436, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 3266.622070, -1944.286011, 10.434824, 0.0000, 0.0000, 269.0037);
	CreateObject(987, 3266.214844, -1971.366211, 9.992108, 0.0000, 0.0000, 269.7591);
	CreateObject(3279, 3272.757324, -1949.631592, 10.067725, 0.0000, 0.0000, 0.0000);
	CreateObject(3279, 3272.867920, -1976.874146, 10.067725, 0.0000, 0.0000, 89.2774);
	CreateObject(987, 3266.566895, -1932.359497, 10.392102, 0.0000, 0.0000, 269.8631);
	CreateObject(987, 3266.479248, -1920.377075, 10.367103, 0.0000, 0.0000, 270.6186);
	CreateObject(987, 3266.559814, -1910.250488, 10.342103, 0.0000, 0.0000, 269.8632);
	CreateObject(987, 3266.074219, -1983.304565, 10.017108, 0.0000, 0.0000, 269.8631);
	CreateObject(987, 3266.186035, -1995.222778, 9.809797, 0.0000, 0.0000, 268.1442);
	CreateObject(987, 3266.490967, -2016.814575, 9.992108, 0.0000, 0.0000, 269.0036);
	CreateObject(4199, 3292.233643, -1925.606812, 12.104586, 0.0000, 0.0000, 269.8631);
	CreateObject(8147, 3339.545654, -1910.392212, 12.944246, 0.0000, 0.0000, 90.1369);
	CreateObject(8148, 3347.528564, -2028.567261, 13.069244, 0.0000, 0.0000, 269.8631);
	CreateObject(8369, 3410.410156, -1949.775391, 14.434867, 0.0000, 0.0000, 179.5182);
	CreateObject(3279, 3421.070068, -1914.859009, 10.543835, 0.0000, 0.0000, 269.8631);
	CreateObject(3279, 3271.844482, -1914.693359, 10.543835, 0.0000, 0.0000, 0.0000);
	CreateObject(3279, 3271.113037, -2022.604736, 10.043835, 0.0000, 0.0000, 0.0000);
	CreateObject(3279, 3422.075684, -2024.302979, 10.043835, 0.0000, 0.0000, 180.3776);
	CreateObject(18228, 3276.378418, -2038.438599, -1.078128, 0.0000, 0.0000, 122.0401);
	CreateObject(744, 3264.485840, -2021.126465, 7.131925, 0.0000, 0.0000, 0.0000);
	CreateObject(744, 3268.405762, -2024.953491, 4.093338, 0.0000, 0.0000, 0.0000);
	CreateObject(896, 3262.557617, -1962.902344, 1.916824, 0.0000, 0.0000, 0.0000);
	CreateObject(896, 3255.254150, -1953.560425, 2.332781, 0.0000, 0.0000, 0.0000);
	CreateObject(896, 3263.504639, -1920.827393, 2.833552, 0.0000, 0.0000, 0.0000);
	CreateObject(18228, 3307.145264, -2037.187622, -4.489964, 0.0000, 0.0000, 328.3047);
	CreateObject(18228, 3339.849854, -2032.735229, -8.097666, 0.0000, 0.0000, 322.2886);
	CreateObject(18228, 3386.544189, -2036.593018, -5.730728, 0.0000, 0.0000, 322.2886);
	CreateObject(18228, 3279.878662, -1902.591309, -6.899596, 0.0000, 0.0000, 141.8071);
	CreateObject(18228, 3328.121094, -1903.827759, -5.731975, 0.0000, 0.0000, 330.8830);
	CreateObject(17071, 3347.094971, -1908.170898, 3.089947, 0.0000, 0.0000, 71.3332);
	CreateObject(18228, 3378.312012, -1903.568481, -8.563671, 0.0000, 0.0000, 149.4379);
	CreateObject(18228, 3418.737549, -1901.368164, -5.163309, 0.0000, 1.7189, 141.7030);
	CreateObject(18228, 3437.007080, -1929.899414, -1.857214, 0.0000, 0.0000, 63.4944);
	CreateObject(18228, 3437.515869, -1961.718140, -3.052888, 1.7189, 0.0000, 46.4096);
	CreateObject(5184, 3360.360352, -2006.611694, 28.638647, 0.0000, 0.0000, 0.0000);
	CreateObject(3753, 3433.792969, -1999.228882, 3.128635, 0.0000, 1.7189, 269.8631);
	CreateObject(7191, 3426.267578, -1978.369507, 10.851191, 0.0000, 0.0000, 359.0368);
	CreateObject(982, 3426.201660, -2017.243164, 10.651772, 0.0000, 0.0000, 0.0000);
	CreateObject(4079, 3397.444336, -1957.409790, 22.756901, 0.0000, 0.0000, 223.4537);
	CreateObject(7538, 3339.866699, -1942.345337, 12.303072, 0.0000, 0.0000, 0.0000);
	CreateObject(8342, 3308.612793, -1955.185791, 13.069242, 0.0000, 0.0000, 89.2774);
	CreateObject(971, 3368.843262, -1978.138306, 11.088188, 0.0000, 0.0000, 269.7591);
	CreateObject(971, 3376.674072, -1992.915894, 11.163130, 0.0000, 0.0000, 323.9037);
	CreateObject(971, 3384.708496, -1995.415894, 11.163115, 0.0000, 0.0000, 0.0000);
	CreateObject(971, 3393.526611, -1994.839111, 11.169912, 0.0000, 0.0000, 7.7349);
	CreateObject(5309, 3314.105713, -2018.189087, 13.386634, 0.0000, 0.0000, 0.0000);
	CreateObject(3819, 3314.496338, -1922.043701, 10.965976, 0.0000, 0.0000, 88.4181);
	CreateObject(3819, 3319.669434, -1935.072266, 10.965976, 0.0000, 0.0000, 302.4178);
	CreateObject(14780, 3314.433838, -1928.942261, 10.835016, 0.0000, 0.0000, 0.0000);
	CreateObject(3597, 3391.712891, -2018.669678, 13.215475, 0.0000, 0.0000, 270.6186);
	CreateObject(615, 3420.249268, -1999.128052, 10.454359, 0.0000, 0.0000, 0.0000);
	CreateObject(615, 3379.463379, -1999.474487, 10.454357, 0.0000, 0.0000, 0.0000);
	CreateObject(615, 3361.562256, -1999.405396, 10.462051, 0.0000, 0.0000, 0.0000);
	CreateObject(616, 3330.542725, -1999.264648, 10.462053, 0.0000, 0.0000, 0.0000);
	CreateObject(616, 3313.455566, -1999.836914, 10.462049, 0.0000, 0.0000, 0.0000);
	CreateObject(616, 3282.856201, -1999.853760, 4.704359, 0.0000, 0.0000, 0.0000);
	CreateObject(1290, 3321.893066, -1998.562500, 16.491638, 0.0000, 0.0000, 90.2409);
	CreateObject(1290, 3370.197021, -1999.395508, 16.491638, 0.0000, 0.0000, 94.5380);
	CreateObject(1278, 3308.941406, -1973.033813, 24.157694, 0.0000, 0.0000, 136.5463);
	CreateObject(1278, 3367.870605, -1973.401733, 24.157692, 0.0000, 0.0000, 243.0132);
	CreateObject(1278, 3308.873047, -1911.433716, 24.157692, 0.0000, 0.0000, 59.1972);
	CreateObject(1278, 3367.982666, -1910.262085, 24.157692, 0.0000, 0.0000, 311.7679);
	CreateObject(4106, 3337.915527, -1976.336426, 16.136578, 0.0000, 0.0000, 269.8631);
	CreateObject(3361, 3317.609863, -1977.221069, 12.067094, 0.0000, 0.0000, 0.0000);
	CreateObject(5822, 3354.789551, -2024.772583, 13.367779, 0.0000, 0.0000, 183.9194);
	CreateObject(670, 3390.36, -1994.62, 10.97, 0.00, 0.00, 0.00);
	CreateObject(985, 3374.12, -1939.64, 8.96, 0.00, 0.00, 0.00);
	CreateObject(14815, 1751.258179, -3553.791016, 394.178497, 0.0000, 0.0000, 0.0000);
    CreateObject(1508, 1762.729736, -3556.698975, 394.012939, 0.0000, 0.0000, 0.0000);
    CreateObject(1508, 1762.756714, -3556.655762, 396.673370, 0.0000, 0.0000, 0.0000);
    CreateObject(1836, 1757.228027, -3564.159424, 393.288483, 0.0000, 0.0000, 179.5181);
    CreateObject(1836, 1752.167236, -3564.155518, 393.270294, 0.0000, 0.0000, 179.5181);
    CreateObject(1838, 1754.644287, -3564.104980, 393.269653, 0.0000, 0.0000, 179.6226);
    CreateObject(1895, 1750.411133, -3561.551514, 394.161011, 0.0000, 0.0000, 90.2408);
    CreateObject(2188, 1751.161133, -3557.611084, 393.382751, 0.0000, 0.0000, 91.1002);
    CreateObject(2785, 1752.384766, -3544.776611, 393.158997, 0.0000, 0.0000, 0.0000);
    CreateObject(2785, 1756.650879, -3544.783691, 393.166748, 0.0000, 0.0000, 0.0000);
    CreateObject(1978, 1756.798584, -3558.423584, 393.447876, 0.0000, 0.0000, 340.3364);
    CreateObject(1502, 1738.821411, -3554.534180, 392.369598, 0.0000, 0.0000, 117.7428);
    CreateObject(1502, 1745.412720, -3554.585205, 392.413177, 0.0000, 0.0000, 108.2889);
    CreateObject(16151, 1765.815430, -3548.207764, 392.689026, 0.0000, 0.0000, 0.0000);
    CreateObject(1665, 1764.923584, -3547.088867, 393.333344, 0.0000, 0.0000, 0.0000);
    CreateObject(1951, 1765.014038, -3550.745605, 393.482605, 0.0000, 0.0000, 0.0000);
    CreateObject(1950, 1764.976318, -3545.289795, 393.482605, 0.0000, 0.0000, 0.0000);
    CreateObject(2291, 1747.921997, -3555.525146, 392.403198, 0.0000, 0.0000, 0.0000);
    CreateObject(2025, 1749.802368, -3557.556641, 392.401428, 0.0000, 0.0000, 269.7592);
    CreateObject(1701, 1748.643921, -3559.291016, 392.323364, 0.0000, 0.0000, 180.4820);
    CreateObject(16377, 1749.401367, -3559.740234, 393.384979, 0.0000, 0.0000, 152.0159);
    CreateObject(1828, 1746.907104, -3558.897705, 392.394958, 0.0000, 0.0000, 0.0000);
    CreateObject(2099, 1746.415283, -3562.875977, 392.395660, 0.0000, 0.0000, 181.2372);
    CreateObject(2132, 1743.875122, -3560.696777, 392.396210, 0.0000, 0.0000, 92.7152);
    CreateObject(2344, 1748.712524, -3561.591064, 393.094086, 0.0000, 0.0000, 169.3092);
    CreateObject(2514, 1743.945068, -3556.007568, 392.396454, 0.0000, 0.0000, 92.7152);
    CreateObject(646, 1760.852417, -3544.964111, 393.813782, 0.0000, 0.0000, 0.0000);
    CreateObject(640, 1761.717041, -3551.244141, 393.094269, 0.0000, 0.0000, 91.1003);
    CreateObject(14391, 1746.873169, -3544.450684, 393.357330, 0.0000, 0.0000, 269.0035);
    CreateObject(2852, 1747.996094, -3561.054199, 393.084137, 0.0000, 0.0000, 0.0000);
    CreateObject(2848, 1743.800415, -3560.567871, 393.462982, 0.0000, 0.0000, 262.1282);
    CreateObject(2628, 1737.792358, -3543.093750, 392.390778, 0.0000, 0.0000, 0.0000);
    CreateObject(2628, 1738.825317, -3543.085205, 392.390778, 0.0000, 0.0000, 0.0000);
    CreateObject(2628, 1739.914429, -3543.072998, 392.390778, 0.0000, 0.0000, 0.0000);
    CreateObject(2630, 1741.135132, -3543.721436, 392.391418, 0.0000, 0.0000, 180.4818);
    CreateObject(2630, 1742.161377, -3543.796143, 392.391418, 0.0000, 0.0000, 181.3413);
    CreateObject(2627, 1738.245972, -3546.682861, 392.397552, 0.0000, 0.0000, 90.1368);
    CreateObject(2627, 1738.243164, -3548.262451, 392.397552, 0.0000, 0.0000, 90.1366);
    CreateObject(2519, 1741.307007, -3550.468262, 392.795685, 0.0000, 0.0000, 89.3814);
    CreateObject(2519, 1742.089844, -3550.465820, 392.793335, 0.0000, 0.0000, 90.2409);
    CreateObject(2322, 1741.263062, -3542.509766, 394.300507, 0.0000, 0.0000, 0.0000);
    CreateObject(2322, 1742.174805, -3542.514893, 394.283936, 0.0000, 0.0000, 0.0000);
    CreateObject(2322, 1737.173340, -3548.396240, 394.646057, 0.0000, 0.0000, 91.1002);
    CreateObject(2322, 1737.199219, -3546.857666, 394.646057, 0.0000, 0.0000, 91.1003);
    CreateObject(1663, 1748.446289, -3546.694092, 392.864838, 0.0000, 0.0000, 208.8433);
    CreateObject(1663, 1745.542725, -3546.338623, 392.857452, 0.0000, 0.0000, 159.7514);
    CreateObject(1824, 1754.863281, -3550.264648, 392.908234, 0.0000, 0.0000, 320.5698);
    CreateObject(1896, 1758.454712, -3548.109863, 393.229980, 0.0000, 0.0000, 256.1122);
    CreateObject(2009, 1749.584595, -3549.489746, 392.215332, 0.0000, 0.0000, 179.6222);
    CreateObject(1723, 1743.931274, -3550.009033, 392.395294, 0.0000, 0.0000, 90.1367);
    CreateObject(1714, 1748.710571, -3549.344238, 392.395813, 0.0000, 0.0000, 0.0000);
    CreateObject(646, 1742.170410, -3563.703369, 393.821167, 0.0000, 0.0000, 0.0000);
    CreateObject(646, 1742.138550, -3555.236572, 393.821167, 0.0000, 0.0000, 0.0000);
    CreateObject(646, 1737.083008, -3555.533447, 393.813782, 0.0000, 0.0000, 0.0000);
    CreateObject(646, 1744.424561, -3561.881592, 393.813782, 0.0000, 0.0000, 0.0000);
    CreateObject(14594, 4080.4721679688, -208.1710357666, 58.229988098145, 0, 0, 0);
    CreateObject(5066, 4059.0007324219, -197.34440612793, 59.857975006104, 0, 0, 0);
    CreateObject(3034, 4059.0961914063, -195.83660888672, 62.290416717529, 0, 0, 90.045043945313);
    CreateObject(3922, 4046.6953125, -214.1363067627, 58.245613098145, 0, 359.5, 357.5);
    CreateObject(3922, 4043.923828125, -214.48542785645, 58.245613098145, 0, 359.49462890625, 357.4951171875);
    CreateObject(3922, 4043.9951171875, -222.60987854004, 58.245613098145, 0, 359.49462890625, 357.4951171875);
    CreateObject(2026, 4048.6354980469, -225.49131774902, 62.864559173584, 0, 0, 0);
    CreateObject(2572, 4057.5544433594, -220.24462890625, 58.245613098145, 0, 0, 267.97497558594);
    CreateObject(1789, 4050.4821777344, -230.3229675293, 58.80179977417, 0, 0, 181.34996032715);
    CreateObject(2099, 4058.8269042969, -226.9634552002, 58.245613098145, 0, 0, 269.39495849609);
    CreateObject(2131, 4054.6306152344, -233.3002166748, 58.237804412842, 0, 0, 179.36492919922);
    CreateObject(2132, 4056.6018066406, -233.28608703613, 58.237800598145, 0, 0, 180.59996032715);
    CreateObject(2131, 4058.5798339844, -233.29042053223, 58.237804412842, 0, 0, 179.36279296875);
    CreateObject(2147, 4059.5529785156, -233.29629516602, 58.237800598145, 0, 0, 180.5849609375);
    CreateObject(2232, 4058.4345703125, -214.02922058105, 58.843490600586, 0, 0, 0);
    CreateObject(2232, 4060.0512695313, -230.56239318848, 58.843490600586, 0, 0, 312.35998535156);
    CreateObject(2344, 4076.4792480469, -194.21398925781, 59.680229187012, 260.75, 3.9700012207031, 267.18994140625);
    CreateObject(2344, 4076.4873046875, -196.64836120605, 59.680229187012, 260.74951171875, 3.966064453125, 267.1875);
    CreateObject(2344, 4076.4660644531, -199.47735595703, 59.680229187012, 260.74951171875, 3.966064453125, 267.1875);
    CreateObject(2564, 4078.9208984375, -196.96781921387, 58.245613098145, 0, 0, 89.325012207031);
    CreateObject(2564, 4078.8977050781, -201.6619720459, 58.245613098145, 0, 0, 89.324340820313);
    CreateObject(2596, 4082.5207519531, -200.78521728516, 61.281921386719, 0, 0, 231.77502441406);
    CreateObject(2828, 4076.8029785156, -192.0191192627, 58.702159881592, 0, 0, 228.27502441406);
    CreateObject(2564, 4095.6376953125, -185.2103729248, 58.245613098145, 0, 0, 359.99932861328);
    CreateObject(14806, 4097.9453125, -191.9757232666, 59.331634521484, 0, 0, 178.65002441406);
    CreateObject(1771, 4100.1059570313, -201.18411254883, 58.879280090332, 0, 0, 0);
    CreateObject(1771, 4105.35546875, -201.12174987793, 58.879280090332, 0, 0, 0);
    CreateObject(1771, 4102.8598632813, -201.19386291504, 58.879280090332, 0, 0, 0);
    CreateObject(1771, 4096.8549804688, -201.07974243164, 58.879280090332, 0, 0, 0);
    CreateObject(1771, 4098.4379882813, -194.5563659668, 58.879280090332, 0, 0, 0);
    CreateObject(1771, 4101.439453125, -194.42791748047, 58.879280090332, 0, 0, 0);
    CreateObject(1771, 4104.1875, -194.40509033203, 58.879280090332, 0, 0, 0);
    CreateObject(1771, 4107.234375, -194.45928955078, 58.879280090332, 0, 0, 0);
    CreateObject(1808, 4094.6752929688, -221.07516479492, 58.245613098145, 0, 0, 92.545013427734);
    CreateObject(2100, 4094.58984375, -223.80686950684, 58.245613098145, 0, 0, 89.525024414063);
    CreateObject(2186, 4098.2724609375, -215.54257202148, 58.245613098145, 0, 0, 0);
    CreateObject(2297, 4107.083984375, -215.20422363281, 58.245613098145, 0, 0, 266.43566894531);
    CreateObject(2630, 4097.26171875, -226.8779296875, 58.245613098145, 0, 0, 178.69036865234);
    CreateObject(2631, 4098.2514648438, -226.84799194336, 58.19193649292, 0, 0, 0);
    CreateObject(2630, 4099.162109375, -226.79997253418, 58.245613098145, 0, 0, 178.68713378906);
    CreateObject(2632, 4101.5078125, -226.52931213379, 58.291942596436, 0, 0, 90.060028076172);
    CreateObject(1709, 4107.5668945313, -220.78649902344, 58.245613098145, 0, 0, 182.62005615234);
    CreateObject(1710, 4101.685546875, -219.1343536377, 58.245613098145, 0, 0, 89.324981689453);
    CreateObject(1742, 4108.4926757813, -225.48719787598, 58.245613098145, 0, 0, 270.64562988281);
    CreateObject(16378, 4062.8662109375, -192.66554260254, 58.999740600586, 0, 0, 359.21569824219);
    CreateObject(2564, 4064.1005859375, -224.14543151855, 58.245613098145, 0, 0, 359.99450683594);
    CreateObject(2564, 4069.5874023438, -224.14515686035, 58.245613098145, 0, 0, 359.99450683594);
    CreateObject(2564, 4075.1149902344, -224.11814880371, 58.245613098145, 0, 0, 359.99450683594);
    CreateObject(2146, 4068.3103027344, -203.58563232422, 58.731163024902, 0, 0, 270.67498779297);
    CreateObject(2146, 4073.8225097656, -203.59141540527, 58.731163024902, 0, 0, 270.67016601563);
    CreateObject(2146, 4080.8212890625, -203.56219482422, 58.731163024902, 0, 0, 270.67016601563);
    CreateObject(2146, 4089.1538085938, -225.7571105957, 58.723350524902, 0, 0, 89.325012207031);
    CreateObject(2146, 4088.9338378906, -230.33435058594, 58.723350524902, 0, 0, 89.324340820313);
    CreateObject(958, 4092.9204101563, -227.59875488281, 59.114639282227, 0, 0, 89.310028076172);
    CreateObject(959, 4092.9782714844, -227.57978820801, 59.178760528564, 0, 0, 90.545013427734);
    CreateObject(2685, 4088.8203125, -221.73150634766, 59.869815826416, 0, 0, 0);
    CreateObject(932, 4070.2097167969, -212.61862182617, 58.245613098145, 0, 0, 178.69030761719);
    CreateObject(932, 4072.203125, -212.46520996094, 58.245613098145, 0, 0, 178.68713378906);
    CreateObject(932, 4071.2060546875, -212.54132080078, 58.245613098145, 0, 0, 178.68713378906);
    CreateObject(3390, 4088.7412109375, -233.09620666504, 58.245613098145, 0, 0, 270.40539550781);
    CreateObject(3391, 4089.5229492188, -222.44650268555, 58.245613098145, 0, 0, 91.309326171875);
    CreateObject(3393, 4093.0251464844, -231.4849395752, 58.245613098145, 0, 0, 0);
    CreateObject(3395, 4092.6962890625, -224.18630981445, 58.237800598145, 0, 0, 0);
    CreateObject(1210, 4062.5622558594, -192.50407409668, 58.394050598145, 0, 0, 91.310028076172);
    CreateObject(2198, 4094.361328125, -204.80435180664, 58.245613098145, 0, 0, 90.810546875);
    CreateObject(2181, 4094.3798828125, -206.64500427246, 58.245613098145, 0, 0, 89.684936523438);
    CreateObject(2182, 4095.4169921875, -208.55786132813, 58.245613098145, 0, 0, 91.310028076172);
    CreateObject(2198, 4097.23828125, -208.54252624512, 58.245613098145, 0, 0, 180.63061523438);
    CreateObject(2309, 4095.0891113281, -204.24151611328, 58.245613098145, 0, 0, 101.23452758789);
    CreateObject(2309, 4095.0922851563, -206.11569213867, 58.245613098145, 0, 0, 101.23352050781);
    CreateObject(2309, 4096.4809570313, -207.86976623535, 58.245613098145, 0, 0, 168.72351074219);
    CreateObject(11665, 2287.833008, -3496.457275, 470.864838, 0.0000, 0.0000, 0.0000);
//--------------------------------------------[VACARELLI HQ]--------------------------------------------------------------------//
CreateObject(966, 661.03747558594, -1219.6787109375, 15.5, 0.000000, 359.30004882813, 61.984954833984); //
CreateObject(966, 654.27624511719, -1232.5172119141, 15.619999885559, 0.000000, 358, 242.61993408203); //
CreateObject(967, 665.88757324219, -1222.76171875, 14.89999961853, 0.000000, 0.000000, 240); //
CreateObject(968, 661.05731201172, -1219.6431884766, 16.200000762939, 0.000000, 325, 60); //
CreateObject(968, 654.30877685547, -1232.4633789063, 16.200000762939, 0.000000, 324.99755859375, 242); //
CreateObject(966, 672.17395019531, -1312.3000488281, 12.5, 0.000000, 0.000000, 0.000000); //
CreateObject(966, 657.91650390625, -1312.3000488281, 12.5, 0.000000, 0.000000, 180); //
CreateObject(968, 657.88690185547, -1312.3165283203, 13.199999809265, 0.000000, 45, 0.000000); //
CreateObject(968, 672.19000244141, -1312.3165283203, 13.199999809265, 0.000000, 45, 180); //
CreateObject(967, 657.310546875, -1305.4959716797, 12.60000038147, 0.000000, 0.000000, 270); //
CreateObject(967, 672.29223632813, -1305.4959716797, 12.60000038147, 0.000000, 0.000000, 90); //
CreateObject(966, 788.24694824219, -1159.8000488281, 22.609519958496, 0.000000, 0.000000, 270); //
CreateObject(966, 788.24694824219, -1145.0090332031, 22.609519958496, 0.000000, 0.000000, 90); //
CreateObject(968, 788.25, -1159.8000488281, 23.35000038147, 0.000000, 45, 90); //
CreateObject(968, 788.25, -1144.91796875, 23.35000038147, 0.000000, 45, 270); //
CreateObject(967, 781.54382324219, -1145.1085205078, 22.609371185303, 0.000000, 0.000000, 90); //
CreateObject(3928, 756.12322998047, -1259.6175537109, 12.564829826355, 0.000000, 0.000000, 0.000000); //
CreateObject(16151, 718.65002441406, -1291, 16.89999961853, 0.000000, 0.000000, 180); //
CreateObject(16152, 718.45001220703, -1271.3000488281, 16.6484375, 0.000000, 0.000000, 0.000000); //
CreateObject(16152, 718.44921875, -1261.9794921875, 16.6484375, 0.000000, 0.000000, 0.000000); //
CreateObject(12958, 721.27508544922, -1255.0916748047, 14.199999809265, 0.000000, 0.000000, 180); //
CreateObject(14781, 729.17694091797, -1233.4011230469, 13.643751144409, 0.000000, 0.000000, 0.000000); //
CreateObject(3265, 656.52093505859, -1311.9951171875, 12.625026702881, 0.000000, 0.000000, 0.000000); //
CreateObject(3265, 673.58935546875, -1311.8070068359, 12.625026702881, 0.000000, 0.000000, 0.000000); //
CreateObject(3265, 661.15209960938, -1218.3073730469, 15.569086074829, 0.000000, 0.000000, 240); //
CreateObject(3265, 653.49377441406, -1233.619140625, 15.878106117249, 0.000000, 0.000000, 240); //
CreateObject(3265, 787.85223388672, -1161.2767333984, 22.584602355957, 0.000000, 0.000000, 90); //
CreateObject(3265, 788.07116699219, -1143.6418457031, 22.828125, 0.000000, 0.000000, 90); //
//------------------------------------[END VACARELLI HQ]-------------------------------------------------------------------------//
	//==========================================================================
	CreateObject(1663, 1580.24, -1634.85, 13.0, 0.00, 0.00, 180.00);
	CreateObject(1518, 1580.24, -1633.35, 13.93, 0.00, 0.00, 0.00);
	CreateObject(1566, 1582.545532, -1637.891357, 13.580875, 0.0000, 0.0000, 0.0000);
	//==========================================================================
	AddCCTV("Airport", 1775, -2440, 34, 180.0);
	AddCCTV("Pershing Square", 1429, -1581, 63, 220.0);
	AddCCTV("License Centre", 1311, -1421, 27, 0.0);
	AddCCTV("Bank", 1590, -1332, 24, 0.0);
	AddCCTV("News Building", 1018, -930, 56, 95.0);
	AddCCTV("Transport Building", 361, -1494, 46, 115.0);
	AddCCTV("Government Prison", 3251, -1956, 23, 95.0);
	AddCCTV("Grove Street", 2317, -1665, 28, 0.0);
    AddCCTV("Glen Park", 1858, -1160, 37, 270.0);
	AddCCTV("Mulholland Intersection", 1653, -1076, 28, 180.0);
	AddCCTV("Los Santos Beach", 325, -1811, 12, 0.0);
    //==========================================================================
	TD = TextDrawCreate(160, 400, "~y~Keys:~n~Arrow-Keys: ~w~Move The Camera~n~~y~Sprint-Key: ~w~Speed Up~n~~y~Crouch-Key: ~w~Exit Camera");
    TextDrawLetterSize(TD, 0.4, 0.9);
    TextDrawSetShadow(TD, 0);
    TextDrawUseBox(TD,1);
	TextDrawBoxColor(TD,0x00000055);
	TextDrawTextSize(TD, 380, 400);

	new Count, Left = TotalCCTVS;
	for(new menu; menu<MAX_CCTVMENUS; menu++)
	{
	    if(Left > 12)
	    {
	        CCTVMenu[menu] = CreateMenu("Choose Camera:", 1, 200, 100, 220);
	        TotalMenus++;
	        MenuType[menu] = 1;
	        for(new i; i<11; i++)
	        {
	        	AddMenuItem(CCTVMenu[menu], 0, CameraName[Count]);
	        	Count++;
	        	Left--;
			}
			AddMenuItem(CCTVMenu[menu], 0, "Next");
		}
		else if(Left<13 && Left > 0)
		{
		    CCTVMenu[menu] = CreateMenu("Choose Camera:", 1, 200, 100, 220);
		    TotalMenus++;
		    MenuType[menu] = 2;
		    new tmp = Left;
	        for(new i; i<tmp; i++)
	        {
	        	AddMenuItem(CCTVMenu[menu], 0, CameraName[Count]);
	        	Count++;
	        	Left--;
			}
		}
	}
	//==========================================================================
	LoadScript();
//==============================================================================
	if (realtime)
	{
		new tmphour;
		new tmpminute;
		new tmpsecond;
		gettime(tmphour, tmpminute, tmpsecond);
		FixHour(tmphour);
		tmphour = shifthour;
		SetWorldTime(tmphour);
	}
//==============================================================================
	SetTimer("UpdateData", 5000, 1); 									  //5sec
	SetTimer("SaveAccounts", 1800000, 1); 	 						    //30 min
	SetTimer("Update", 300000, 1); 										 //5 min
	SetTimer("UpdateMoney", 1000, 1);   						    	 //1 sec
	SetTimer("PickupGametexts", 1000, 1);  			 				     //1 sec
	SetTimer("FuelTimer", 30000, 1);                                     //30sec
	SetTimer("SickTimer", 30000, 1);                                     //30sec
	SetTimer("JailTimer", 1000, 1); 									 //1 sec
	SetTimer("StreamPickups",1000,1);                                    //1 sec
	SetTimer("IdleKick", 1200000, 1);		                             //20min                    //1.5sec
	return 1;
}
//==============================================================================
public LoadScript()
{
	LoadDynamicFactions();
	LoadDynamicCars();
	LoadCivilianSpawn();
	LoadBuildings();
	LoadHouses();
	LoadBusinesses();
	LoadFactionMaterialsStorage();
	LoadFactionDrugsStorage();
	LoadDrivingTestPosition();
	LoadFlyingTestPosition();
	LoadBankPosition();
	LoadWeaponLicensePosition();
	LoadPoliceArrestPosition();
	LoadGovernmentArrestPosition();
	LoadPoliceDutyPosition();
	LoadGovernmentDutyPosition();
	LoadGunJob();
	LoadDrugJob();
	LoadDetectiveJob();
	LoadLawyerJob();
	LoadProductsSellerJob();
	LoadMechanicJob();
	return 1;
}
//==============================================================================
public OnPlayerConnect(playerid)
{
    TextDrawShowForPlayer(playerid, Textdraw0);
    if(IsPlayerNPC(playerid)) return 1;
	//==========================================================================
	JoinCounter = JoinCounter + 1;
	dini_IntSet("New York Roleplay/Other/JoinCounter.cfg", "Connections", JoinCounter);
	//==========================================================================
	GameTextForPlayer(playerid,"~g~The ~w~God~r~father",4500,4);
 	Meter1[playerid] = TextDrawCreate(526.000000,408.000000,"I");
	Meter2[playerid] = TextDrawCreate(622.000000,421.000000," ");
	Meter3[playerid] = TextDrawCreate(529.000000,428.000000,"      Range");
	TextDrawUseBox(Meter2[playerid],1);
	TextDrawBoxColor(Meter2[playerid],0x000000ff);
	TextDrawTextSize(Meter2[playerid],524.000000,171.000000);
	TextDrawAlignment(Meter1[playerid],0);
	TextDrawAlignment(Meter2[playerid],0);
	TextDrawAlignment(Meter3[playerid],0);
	TextDrawFont(Meter1[playerid],2);
	TextDrawFont(Meter2[playerid],3);
	TextDrawFont(Meter3[playerid],2);
	TextDrawLetterSize(Meter1[playerid],0.199999,2.400000);
	TextDrawLetterSize(Meter2[playerid],2.199999,0.000000);
	TextDrawLetterSize(Meter3[playerid],0.300000,1.000000);
	TextDrawSetOutline(Meter1[playerid],1);
	TextDrawSetOutline(Meter2[playerid],1);
	TextDrawSetOutline(Meter3[playerid],1);
	TextDrawSetShadow(Meter1[playerid],0);
	TextDrawSetShadow(Meter2[playerid],0);
	TextDrawSetShadow(Meter3[playerid],0);
	ResetStats(playerid);
	SetPlayerScore(playerid, 0);
	ClearScreen(playerid);
 	new first[MAX_PLAYER_NAME], last[MAX_PLAYER_NAME];
	if(RPName(PlayerName(playerid),first,last))
	{
		new sendername[MAX_PLAYER_NAME];
		new accstring[128];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(accstring, sizeof(accstring), "New York Roleplay/Accounts/%s.ini", sendername);
		new File: hFile = fopen(accstring, io_read);
		if (hFile)
		{
		new loginstring[128];
		new loginname[64];
		loginname = GetPlayerNameEx(playerid);
		format(loginstring,sizeof(loginstring),"Welcome back, %s!\nType in your password below to sign in:",loginname);
		ShowPlayerDialog(playerid,12,DIALOG_STYLE_INPUT,"Login",loginstring,"Login","Cancel");
		fclose(hFile);
		}
		else
		{
		new loginstring[128];
		new loginname[64];
		loginname = GetPlayerNameEx(playerid);
		format(loginstring,sizeof(loginstring),"You are a new user %s, welcome.\nYou may register your account.\nType your desired pass below to register:",loginname);
		ShowPlayerDialog(playerid,13,DIALOG_STYLE_INPUT,"Register",loginstring,"Register","Cancel");
		}
	}
	else
	{
	    KickPlayer(playerid,"the server","NON-RP Name. Get a name in the format: Firstname_Lastname");
	}
	return 1;
}
//==============================================================================
public ResetStats(playerid)
{
	ProductsOffer[playerid] = 999;
	ProductsCost[playerid] = 0;
	ProductsAmount[playerid] = 0;
	TrackingPlayer[playerid] = 0;
	DrugsIntake[playerid] = 0;
	DrugsHolding[playerid] = 0;
	ResetPlayerWantedLevelEx(playerid);
	VehicleLockedPlayer[playerid] = 999;
	MatsHolding[playerid] = 0;
	TicketOffer[playerid] = 999;
	TicketMoney[playerid] = 0;
	PlayerTazed[playerid] = 0;
	PlayerCuffed[playerid] = 0;
	PlayerTied[playerid] = 0;
	TalkingLive[playerid] = 255;
	LiveOffer[playerid] = 999;
	BegOffer[playerid] = 999;
 	BegPrice[playerid] = 0;
  	RefillOffer[playerid] = 999;
  	RefillPrice[playerid] = 0;
  	RepairOffer[playerid] = 999;
 	RepairPrice[playerid] = 0;
 	RepairCar[playerid] = 0;
 	CarOffer[playerid] = 999;
 	CarPrice[playerid] = 0;
 	CarID[playerid] = 0;
 	CarCalls[playerid] = 0;
	CopOnDuty[playerid] = 0;
	WantedLevel[playerid] = 0;
	WantedPoints[playerid] = 0;
	CurrentCCTV[playerid] = -1;
	InShamal[playerid] = 0;
	InAndrom[playerid] = 0;
	Bomb[playerid] = 0;
	PlayerInfo[playerid][pHospital] = 0;
	PMsEnabled[playerid] = 1;
	AdminDuty[playerid] = 0;
	StartedCall[playerid] = 0;
	Muted[playerid] = 0;
	PhoneOnline[playerid] = 0;
	ShowFuel[playerid] = 1;
	TakingDrivingTest[playerid] = 0;
	DrivingTestStep[playerid] = 0;
	MapIconsShown[playerid] = 0;
	SetPlayerColor(playerid,COLOR_NOTLOGGED);
	SpawnAttempts[playerid] = 0;
	PlayerInfo[playerid][pFaction] = 255;
	FactionRequest[playerid] = 255;
	PlayerInfo[playerid][pRank] = 0;
	PlayerInfo[playerid][pBizKey] = 255;
	PlayerInfo[playerid][pSpawnPoint] = 0;
	PlayerInfo[playerid][pLocked] = 0;
	PlayerInfo[playerid][pWarnings] = 0;
	PlayerInfo[playerid][pHouseKey] = 255;
	gPlayerLogged[playerid] = 0;
	RegistrationStep[playerid] = 0;
	PlayerInfo[playerid][pLevel] = 0;
	PlayerInfo[playerid][pAdmin] = 0;
	PlayerInfo[playerid][pDonateRank] = 0;
	PlayerInfo[playerid][pRegistered] = 0;
	PlayerInfo[playerid][pTut] = 0;
	PlayerInfo[playerid][pSex] = 0;
	PlayerInfo[playerid][pAge] = 0;
	PlayerInfo[playerid][pExp] = 0;
	PlayerInfo[playerid][pCash] = 0;
	PlayerInfo[playerid][pGun1] = 0;
	PlayerInfo[playerid][pGun2] = 0;
	PlayerInfo[playerid][pGun3] = 0;
	PlayerInfo[playerid][pGun4] = 0;
	PlayerInfo[playerid][pAmmo1] = 0;
	PlayerInfo[playerid][pAmmo2] = 0;
	PlayerInfo[playerid][pAmmo3] = 0;
	PlayerInfo[playerid][pAmmo4] = 0;
	PlayerInfo[playerid][pBank] = 0;
	PlayerInfo[playerid][pDeathFreeze] = 0;
	PlayerInfo[playerid][pFlop1] = 0;
	PlayerInfo[playerid][pFlop2] = 0;
	PlayerInfo[playerid][pFlop3] = 0;
	PlayerInfo[playerid][pRiver] = 0;
	PlayerInfo[playerid][pTurn] = 0;
	PlayerInfo[playerid][pDealer] = 0;
	PlayerInfo[playerid][pSkin] = 0;
	PlayerInfo[playerid][pDrugs] = 0;
	PlayerInfo[playerid][pMaterials] = 0;
	PlayerInfo[playerid][pProducts] = 0;
	PlayerInfo[playerid][pJob] = 0;
	PlayerInfo[playerid][pCards] = 0;
	PlayerInfo[playerid][pCard1] = 0;
	PlayerInfo[playerid][pCard2] = 0;
	PlayerInfo[playerid][pContractTime] = 0;
	PlayerInfo[playerid][pPlayingHours] = 0;
	PlayerInfo[playerid][pAllowedPayday] = 0;
	PlayerInfo[playerid][pPayCheck] = 0;
	PlayerInfo[playerid][pCarLic] = 0;
	PlayerInfo[playerid][pWepLic] = 0;
	PlayerInfo[playerid][pFlyLic] = 0;
	PlayerInfo[playerid][pVisitPass] = 0;
	PlayerInfo[playerid][pPhoneNumber] = 0;
	PlayerInfo[playerid][pPhoneC] = 255;
	PlayerInfo[playerid][pPhoneBook] = 0;
	PlayerInfo[playerid][pLottoNr] = 0;
	PlayerInfo[playerid][pListNumber] = 1;
	Mobile[playerid] = 255;
	PlayerInfo[playerid][pDonator] = 0;
	PlayerInfo[playerid][pJailed] = 0;
	PlayerInfo[playerid][pJailTime] = 0;
	JailPrice[playerid] = 0;
	PlayerInfo[playerid][pRequestingBackup] = 0;
	PlayerInfo[playerid][pRoadblock] = 0;
	strmid(PlayerInfo[playerid][pNote1], "None", 0, strlen("None"), 255);
	PlayerInfo[playerid][pNote1s] = 0;
	strmid(PlayerInfo[playerid][pNote2], "None", 0, strlen("None"), 255);
	PlayerInfo[playerid][pNote2s] = 0;
	strmid(PlayerInfo[playerid][pNote3], "None", 0, strlen("None"), 255);
	PlayerInfo[playerid][pNote3s] = 0;
	strmid(PlayerInfo[playerid][pNote4], "None", 0, strlen("None"), 255);
	PlayerInfo[playerid][pNote4s] = 0;
	strmid(PlayerInfo[playerid][pNote5], "None", 0, strlen("None"), 255);
	PlayerInfo[playerid][pNote5s] = 0;
	PlayerInfo[playerid][pLoadPosX] = 0.0000;
	PlayerInfo[playerid][pLoadPosY] = 0.0000;
	PlayerInfo[playerid][pLoadPosZ] = 0.0000;
	PlayerInfo[playerid][pLoadPosInt] = 0;
	PlayerInfo[playerid][pLoadPosW] = 0;
	PlayerInfo[playerid][pLoadPos] = 0;
	//================================================
	return 0;
}
//==============================================================================
public OnPlayerLogin(playerid,password[])
{
    new string2[128];
	format(string2, sizeof(string2), "New York Roleplay/Accounts/%s.ini", PlayerName(playerid));
	new File: UserFile = fopen(string2, io_read);
	if ( UserFile )
	{
	    new PassData[256];
	    new keytmp[256], valtmp[256];
	    fread( UserFile , PassData , sizeof( PassData ) );
	    keytmp = ini_GetKey( PassData );
	    if( strcmp( keytmp , "Key" , true ) == 0 )
		{
			valtmp = ini_GetValue( PassData );
			strmid(PlayerInfo[playerid][pKey], valtmp, 0, strlen(valtmp)-1, 255);
		}
		if(strcmp(PlayerInfo[playerid][pKey],password, true ) == 0 )
		{
			    new key[ 256 ] , val[ 256 ];
			    new Data[ 256 ];
			    while ( fread( UserFile , Data , sizeof( Data ) ) )
				{
					key = ini_GetKey( Data );
					if( strcmp( key , "Level" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pLevel] = strval( val ); }
			    	if( strcmp( key , "AdminLevel" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pAdmin] = strval( val ); }
			        if( strcmp( key , "DonateRank" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pDonateRank] = strval( val ); }
			        if( strcmp( key , "Registered" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pRegistered] = strval( val ); }
			        if( strcmp( key , "Tutorial" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pTut] = strval( val ); }
					if( strcmp( key , "Sex" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pSex] = strval( val ); }
					if( strcmp( key , "Age" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pAge] = strval( val ); }
					if( strcmp( key , "Cards" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pCards] = strval( val ); }
					if( strcmp( key , "Card1" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pCard1] = strval( val ); }
					if( strcmp( key , "Card2" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pCard2] = strval( val ); }
					if( strcmp( key , "Experience" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pExp] = strval( val ); }
					if( strcmp( key , "Money" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pCash] = strval( val ); }
					if( strcmp( key , "Gun1" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pGun1] = strval( val ); }
					if( strcmp( key , "Gun2" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pGun2] = strval( val ); }
					if( strcmp( key , "Gun3" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pGun3] = strval( val ); }
					if( strcmp( key , "Gun4" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pGun4] = strval( val ); }
					if( strcmp( key , "Ammo1" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pAmmo1] = strval( val ); }
					if( strcmp( key , "Ammo2" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pAmmo2] = strval( val ); }
					if( strcmp( key , "Ammo3" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pAmmo3] = strval( val ); }
					if( strcmp( key , "Ammo4" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pAmmo4] = strval( val ); }
					if( strcmp( key , "Bank" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pBank] = strval( val ); }
					if( strcmp( key , "DeathFreeze" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pDeathFreeze] = strval( val ); }
					if( strcmp( key , "Flop1" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pFlop1] = strval( val ); }
					if( strcmp( key , "Flop2" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pFlop2] = strval( val ); }
					if( strcmp( key , "Flop3" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pFlop3] = strval( val ); }
					if( strcmp( key , "River" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pRiver] = strval( val ); }
					if( strcmp( key , "Turn" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pTurn] = strval( val ); }
					if( strcmp( key , "Dealer" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pDealer] = strval( val ); }
					if( strcmp( key , "Skin" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pSkin] = strval( val ); }
					if( strcmp( key , "Drugs" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pDrugs] = strval( val ); }
					if( strcmp( key , "Materials" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pMaterials] = strval( val ); }
					if( strcmp( key , "Products" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pProducts] = strval( val ); }
					if( strcmp( key , "Job" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pJob] = strval( val ); }
					if( strcmp( key , "ContractTime" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pContractTime] = strval( val ); }
					if( strcmp( key , "PlayingHours" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pPlayingHours] = strval( val ); }
					if( strcmp( key , "AllowedPayday" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pAllowedPayday] = strval( val ); }
					if( strcmp( key , "PayCheck" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pPayCheck] = strval( val ); }
					if( strcmp( key , "Faction" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pFaction] = strval( val ); }
					if( strcmp( key , "Rank" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pRank] = strval( val ); }
					if( strcmp( key , "HouseKey" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pHouseKey] = strval( val ); }
					if( strcmp( key , "BizKey" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pBizKey] = strval( val ); }
					if( strcmp( key , "SpawnPoint" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pSpawnPoint] = strval( val ); }
					if( strcmp( key , "Warnings" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pWarnings] = strval( val ); }
					if( strcmp( key , "CarLic" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pCarLic] = strval( val ); }
					if( strcmp( key , "FlyLic" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pFlyLic] = strval( val ); }
					if( strcmp( key , "WepLic" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pWepLic] = strval( val ); }
					if( strcmp( key , "VisitPass" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pVisitPass] = strval( val ); }
					if( strcmp( key , "PhoneNumber" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pPhoneNumber] = strval( val ); }
					if( strcmp( key , "PhoneC" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pPhoneC] = strval( val ); }
					if( strcmp( key , "PhoneBook" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pPhoneBook] = strval( val ); }
					if( strcmp( key , "LottoNr" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pLottoNr] = strval( val ); }
					if( strcmp( key , "ListNumber" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pListNumber] = strval( val ); }
					if( strcmp( key , "Donator" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pDonator] = strval( val ); }
					if( strcmp( key , "Jailed" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pJailed] = strval( val ); }
					if( strcmp( key , "JailTime" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pJailTime] = strval( val ); }
					if( strcmp( key , "Hospital" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pHospital] = strval( val ); }
     				if( strcmp( key , "Note1" , true ) == 0 ) { val = ini_GetValue( Data ); strmid(PlayerInfo[playerid][pNote1], val, 0, strlen(val)-1, 255); }
			        if( strcmp( key , "Note1s" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pNote1s] = strval( val ); }
			        if( strcmp( key , "Note2" , true ) == 0 ) { val = ini_GetValue( Data ); strmid(PlayerInfo[playerid][pNote2], val, 0, strlen(val)-1, 255); }
			        if( strcmp( key , "Note2s" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pNote2s] = strval( val ); }
			        if( strcmp( key , "Note3" , true ) == 0 ) { val = ini_GetValue( Data ); strmid(PlayerInfo[playerid][pNote3], val, 0, strlen(val)-1, 255); }
			        if( strcmp( key , "Note3s" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pNote3s] = strval( val ); }
			        if( strcmp( key , "Note4" , true ) == 0 ) { val = ini_GetValue( Data ); strmid(PlayerInfo[playerid][pNote4], val, 0, strlen(val)-1, 255); }
			        if( strcmp( key , "Note4s" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pNote4s] = strval( val ); }
			        if( strcmp( key , "Note5" , true ) == 0 ) { val = ini_GetValue( Data ); strmid(PlayerInfo[playerid][pNote5], val, 0, strlen(val)-1, 255); }
			        if( strcmp( key , "Note5s" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pNote5s] = strval( val ); }
					if( strcmp( key , "LoadPosX" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pLoadPosX] = floatstr( val ); }
					if( strcmp( key , "LoadPosY" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pLoadPosY] = floatstr( val ); }
					if( strcmp( key , "LoadPosZ" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pLoadPosZ] = floatstr( val ); }
					if( strcmp( key , "LoadPosInt" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pLoadPosInt] = strval( val ); }
					if( strcmp( key , "LoadPosW" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pLoadPosW] = strval( val ); }
					if( strcmp( key , "LoadPos" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pLoadPos] = strval( val ); }
					if( strcmp( key , "AccountLocked" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pLocked] = strval( val ); }
                }
                fclose(UserFile);
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) Incorrect password");
			new loginstring[128];
		    new loginname[64];
            loginname = GetPlayerNameEx(playerid);
		    format(loginstring,sizeof(loginstring),"Wrong password!\nYou may re-try, %s.\nType in your password below to re-try:",loginname);
		    ShowPlayerDialog(playerid,12,DIALOG_STYLE_INPUT,"Login",loginstring,"Login","Cancel");
	        fclose(UserFile);
	        return 1;
		}
	    if(PlayerInfo[playerid][pFaction] != 255)
	    {
    		if(DynamicFactions[PlayerInfo[playerid][pFaction]][fUseColor])
    		{
    			SetPlayerToFactionColor(playerid);
    		}
     	}
     	else
     	{
			SetPlayerColor(playerid,COLOR_CIVILIAN);
		}
		if(PlayerInfo[playerid][pLocked])
		{
		    KickPlayer(playerid,"the server","Account Locked");
  		}
		if(PlayerInfo[playerid][pAdmin] > 0)
		{
			format(string2, sizeof(string2), "(SERVER) You are logged in as a level %d admin",PlayerInfo[playerid][pAdmin]);
			SendClientMessage(playerid, COLOR_WHITE,string2);
		}
		if(PlayerInfo[playerid][pDonateRank] > 0)
		{
			SendClientMessage(playerid, COLOR_WHITE, "(SERVER) You are logged in as a donator");
		}
		if(PlayerInfo[playerid][pRegistered] == 0)
		{
			PlayerInfo[playerid][pLevel] = 1;
			PlayerInfo[playerid][pCash] = 2500;
			PlayerInfo[playerid][pBank] = 7500;
			PlayerInfo[playerid][pSkin] = 60;
			SetPlayerCash(playerid,PlayerInfo[playerid][pCash]);
			SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
			PlayerInfo[playerid][pTut] = 1;
			RegistrationStep[playerid] = 1;
			SendClientMessage(playerid,COLOR_YELLOW,"(INFO) Welcome to The Godfather, answer the following questions to proceed.");
			SendClientMessage(playerid,COLOR_RED,"<|> Step One <|>");
			SendClientMessage(playerid, COLOR_WHITE, "(INFO) State your age. (From 16-100).");
		}
		SetPlayerCash(playerid,PlayerInfo[playerid][pCash]);
		gPlayerLogged[playerid] = 1;
		SetSpawnInfo(playerid, PlayerInfo[playerid][pFaction], PlayerInfo[playerid][pSkin],CivilianSpawn[X],CivilianSpawn[Y],CivilianSpawn[Z],0,0,0,0,0,0,0);
	    SpawnPlayer(playerid);
	}
	return 1;
}
//==============================================================================
public OnPlayerRegister(playerid, password[])
{
	if(IsPlayerConnected(playerid))
	{
			new string3[128];
			format(string3, sizeof(string3), "New York Roleplay/Accounts/%s.ini", PlayerName(playerid));
			new File: hFile = fopen(string3, io_write);
			if (hFile)
			{
			    strmid(PlayerInfo[playerid][pKey], password, 0, strlen(password), 255);
			    new var[32];
				format(var, 32, "Key=%s\n", PlayerInfo[playerid][pKey]);fwrite(hFile, var);
				PlayerInfo[playerid][pCash] = GetPlayerCash(playerid);
				format(var, 32, "Level=%d\n",PlayerInfo[playerid][pLevel]);fwrite(hFile, var);
				format(var, 32, "AdminLevel=%d\n",PlayerInfo[playerid][pAdmin]);fwrite(hFile, var);
				format(var, 32, "DonateRank=%d\n",PlayerInfo[playerid][pDonateRank]);fwrite(hFile, var);
				format(var, 32, "Registered=%d\n",PlayerInfo[playerid][pRegistered]);fwrite(hFile, var);
				format(var, 32, "Tutorial=%d\n",PlayerInfo[playerid][pTut]);fwrite(hFile, var);
				format(var, 32, "Cards=%d\n",PlayerInfo[playerid][pCards]);fwrite(hFile, var);
				format(var, 32, "Card1=%d\n",PlayerInfo[playerid][pCard1]);fwrite(hFile, var);
				format(var, 32, "Card2=%d\n",PlayerInfo[playerid][pCard2]);fwrite(hFile, var);
				format(var, 32, "Sex=%d\n",PlayerInfo[playerid][pSex]);fwrite(hFile, var);
				format(var, 32, "Age=%d\n",PlayerInfo[playerid][pAge]);fwrite(hFile, var);
				format(var, 32, "Experience=%d\n",PlayerInfo[playerid][pExp]);fwrite(hFile, var);
				format(var, 32, "Money=%d\n",PlayerInfo[playerid][pCash]);fwrite(hFile, var);
				format(var, 32, "Gun1=%d\n",PlayerInfo[playerid][pGun1]);fwrite(hFile, var);
				format(var, 32, "Gun2=%d\n",PlayerInfo[playerid][pGun2]);fwrite(hFile, var);
				format(var, 32, "Gun3=%d\n",PlayerInfo[playerid][pGun3]);fwrite(hFile, var);
				format(var, 32, "Gun4=%d\n",PlayerInfo[playerid][pGun4]);fwrite(hFile, var);
 				format(var, 32, "Ammo1=%d\n",PlayerInfo[playerid][pAmmo1]);fwrite(hFile, var);
				format(var, 32, "Ammo2=%d\n",PlayerInfo[playerid][pAmmo2]);fwrite(hFile, var);
				format(var, 32, "Ammo3=%d\n",PlayerInfo[playerid][pAmmo3]);fwrite(hFile, var);
				format(var, 32, "Ammo4=%d\n",PlayerInfo[playerid][pAmmo4]);fwrite(hFile, var);
				format(var, 32, "Bank=%d\n",PlayerInfo[playerid][pBank]);fwrite(hFile, var);
				format(var, 32, "DeathFreeze=%d\n",PlayerInfo[playerid][pDeathFreeze]);fwrite(hFile, var);
				format(var, 32, "Flop1=%d\n",PlayerInfo[playerid][pFlop1]);fwrite(hFile, var);
				format(var, 32, "Flop2=%d\n",PlayerInfo[playerid][pFlop2]);fwrite(hFile, var);
				format(var, 32, "Flop3=%d\n",PlayerInfo[playerid][pFlop3]);fwrite(hFile, var);
				format(var, 32, "River=%d\n",PlayerInfo[playerid][pRiver]);fwrite(hFile, var);
				format(var, 32, "Turn=%d\n",PlayerInfo[playerid][pTurn]);fwrite(hFile, var);
				format(var, 32, "Dealer=%d\n",PlayerInfo[playerid][pDealer]);fwrite(hFile, var);
				format(var, 32, "Skin=%d\n",PlayerInfo[playerid][pSkin]);fwrite(hFile, var);
				format(var, 32, "Drugs=%d\n",PlayerInfo[playerid][pDrugs]);fwrite(hFile, var);
				format(var, 32, "Materials=%d\n",PlayerInfo[playerid][pMaterials]);fwrite(hFile, var);
				format(var, 32, "Products=%d\n",PlayerInfo[playerid][pProducts]);fwrite(hFile, var);
				format(var, 32, "Job=%d\n",PlayerInfo[playerid][pJob]);fwrite(hFile, var);
				format(var, 32, "ContractTime=%d\n",PlayerInfo[playerid][pContractTime]);fwrite(hFile, var);
				format(var, 32, "PlayingHours=%d\n",PlayerInfo[playerid][pPlayingHours]);fwrite(hFile, var);
				format(var, 32, "AllowedPayday=%d\n",PlayerInfo[playerid][pAllowedPayday]);fwrite(hFile, var);
				format(var, 32, "PayCheck=%d\n",PlayerInfo[playerid][pPayCheck]);fwrite(hFile, var);
				format(var, 32, "Faction=%d\n",PlayerInfo[playerid][pFaction]);fwrite(hFile, var);
				format(var, 32, "Rank=%d\n",PlayerInfo[playerid][pRank]);fwrite(hFile, var);
				format(var, 32, "HouseKey=%d\n",PlayerInfo[playerid][pHouseKey]);fwrite(hFile, var);
				format(var, 32, "BizKey=%d\n",PlayerInfo[playerid][pBizKey]);fwrite(hFile, var);
				format(var, 32, "SpawnPoint=%d\n",PlayerInfo[playerid][pSpawnPoint]);fwrite(hFile, var);
				format(var, 32, "Warnings=%d\n",PlayerInfo[playerid][pWarnings]);fwrite(hFile, var);
				format(var, 32, "CarLic=%d\n",PlayerInfo[playerid][pCarLic]);fwrite(hFile, var);
				format(var, 32, "FlyLic=%d\n",PlayerInfo[playerid][pFlyLic]);fwrite(hFile, var);
				format(var, 32, "WepLic=%d\n",PlayerInfo[playerid][pWepLic]);fwrite(hFile, var);
				format(var, 32, "VisitPass=%d\n",PlayerInfo[playerid][pVisitPass]);fwrite(hFile, var);
				format(var, 32, "PhoneNumber=%d\n",PlayerInfo[playerid][pPhoneNumber]);fwrite(hFile, var);
				format(var, 32, "PhoneC=%d\n",PlayerInfo[playerid][pPhoneC]);fwrite(hFile, var);
				format(var, 32, "PhoneBook=%d\n",PlayerInfo[playerid][pPhoneBook]);fwrite(hFile, var);
				format(var, 32, "LottoNr=%d\n",PlayerInfo[playerid][pLottoNr]);fwrite(hFile, var);
				format(var, 32, "ListNumber=%d\n",PlayerInfo[playerid][pListNumber]);fwrite(hFile, var);
				format(var, 32, "Donator=%d\n",PlayerInfo[playerid][pDonator]);fwrite(hFile, var);
				format(var, 32, "Jailed=%d\n",PlayerInfo[playerid][pJailed]);fwrite(hFile, var);
				format(var, 32, "JailTime=%d\n",PlayerInfo[playerid][pJailTime]);fwrite(hFile, var);
				format(var, 32, "Hospital=%d\n",PlayerInfo[playerid][pHospital]);fwrite(hFile, var);
 				format(var, 32, "Note1=%s\n",PlayerInfo[playerid][pNote1]);fwrite(hFile, var);
				format(var, 32, "Note1s=%d\n",PlayerInfo[playerid][pNote1s]);fwrite(hFile, var);
				format(var, 32, "Note2=%s\n",PlayerInfo[playerid][pNote2]);fwrite(hFile, var);
				format(var, 32, "Note2s=%d\n",PlayerInfo[playerid][pNote2s]);fwrite(hFile, var);
				format(var, 32, "Note3=%s\n",PlayerInfo[playerid][pNote3]);fwrite(hFile, var);
				format(var, 32, "Note3s=%d\n",PlayerInfo[playerid][pNote3s]);fwrite(hFile, var);
				format(var, 32, "Note4=%s\n",PlayerInfo[playerid][pNote4]);fwrite(hFile, var);
				format(var, 32, "Note4s=%d\n",PlayerInfo[playerid][pNote4s]);fwrite(hFile, var);
				format(var, 32, "Note5=%s\n",PlayerInfo[playerid][pNote5]);fwrite(hFile, var);
				format(var, 32, "Note5s=%d\n",PlayerInfo[playerid][pNote5s]);fwrite(hFile, var);
				format(var, 32, "LoadPosX=%f\n",PlayerInfo[playerid][pLoadPosX]);fwrite(hFile, var);
				format(var, 32, "LoadPosY=%f\n",PlayerInfo[playerid][pLoadPosY]);fwrite(hFile, var);
				format(var, 32, "LoadPosZ=%f\n",PlayerInfo[playerid][pLoadPosZ]);fwrite(hFile, var);
				format(var, 32, "LoadPosInt=%d\n",PlayerInfo[playerid][pLoadPosInt]);fwrite(hFile, var);
				format(var, 32, "LoadPosW=%d\n",PlayerInfo[playerid][pLoadPosW]);fwrite(hFile, var);
				format(var, 32, "LoadPos=%d\n",PlayerInfo[playerid][pLoadPos]);fwrite(hFile, var);
				format(var, 32, "AccountLocked=%d\n",PlayerInfo[playerid][pLocked]);fwrite(hFile, var);
				fclose(hFile);
				SendClientMessage(playerid, COLOR_WHITE, "Account registered");
				TogglePlayerControllable(playerid, 0);
			}
	}
	return 1;
}
//==============================================================================
public OnPlayerRequestSpawn(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;
	if(gPlayerLogged[playerid] == 1)
	{
		return 1;
	}
	else
	{
	    if(SpawnAttempts[playerid] >= MAX_SPAWN_ATTEMPTS)
	    {
	        KickPlayer(playerid,"the server","Repeated attempts to spawn without logging in");
			return 1;
	    }
		SendClientMessage(playerid, COLOR_GREY, "(INFO) You must login before you can spawn");
		SpawnAttempts[playerid] ++;
		return 0;
	}
}
//==============================================================================
public OnPlayerRequestClass(playerid, classid)
{
	if(IsPlayerNPC(playerid)) return 1;
	if(gPlayerLogged[playerid])
	{
		return 1;
	}
	SetPlayerCameraPos(playerid, 1481.5609, -1735.0886, 13.3828);
    SetPlayerCameraLookAt(playerid, 1481.5609, -1735.0886, 13.3828);
   	return 0;
}
//==============================================================================
public OnPlayerSpawn(playerid)
{
   	if(PlayerInfo[playerid][pTut] == 0)
	{
		SetPlayerCameraPos(playerid, 1481.5609, -1735.0886, 13.3828);
        SetPlayerCameraLookAt(playerid, 1481.5609, -1735.0886, 13.3828);
	    TogglePlayerControllable(playerid, 0);
   		GameTextForPlayer(playerid, "~g~The ~w~God~r~father~n~~w~Tutorial", 10000, 3);
   		SendClientMessage(playerid, COLOR_YELLOW, "To avoid admin intervention during your gameplay, please pay attention.");
		TutTimer = SetTimerEx("ShowTut", 20000, true, "i", playerid);
		TutorialStage[playerid] = 1;
	}
	if(gPlayerLogged[playerid])
	{
		PlayerInfo[playerid][pSpawnPoint] = 1;
		new house = PlayerInfo[playerid][pHouseKey];
   		if(house != 255)
		{
		    if(PlayerInfo[playerid][pSpawnPoint])
		    {
				SetPlayerInterior(playerid,Houses[house][ExitInterior]);
				SetPlayerPos(playerid, Houses[house][ExitX], Houses[house][ExitY],Houses[house][ExitZ]);
				SetPlayerVirtualWorld(playerid,house);
    			return 1;
			}
		}
		else if (PlayerInfo[playerid][pFaction] != 255)
		{
		    if(PlayerInfo[playerid][pSpawnPoint] == 0)
		    {
				SetPlayerPos(playerid,DynamicFactions[PlayerInfo[playerid][pFaction]][fX],DynamicFactions[PlayerInfo[playerid][pFaction]][fY],DynamicFactions[PlayerInfo[playerid][pFaction]][fZ]);
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
				return 1;
			}
		}
	    else
	    {
   			SetPlayerPos(playerid,CivilianSpawn[X],CivilianSpawn[Y],CivilianSpawn[Z]);
			SetPlayerVirtualWorld(playerid, CivilianSpawn[World]);
			SetPlayerInterior(playerid, CivilianSpawn[Interior]);
			SetPlayerFacingAngle(playerid,CivilianSpawn[Angle]);
			return 1;
		}
        SetPlayerWeapons(playerid);
       	SetPlayerMapIcon(playerid, 0, 1310.1991,-1366.7968,13.5065, 55, COLOR_YELLOW);	// DMV
		SetPlayerMapIcon(playerid, 4, 1544.4790,-1673.6595,13.5585, 30, COLOR_YELLOW);	// LSPD
		SetPlayerMapIcon(playerid, 5, 1571.1887,-1336.7534,16.4844, 52, COLOR_YELLOW);	// Bank
		SetPlayerMapIcon(playerid, 6, 1480.9323,-1767.7324,18.7958, 56, COLOR_YELLOW);	// City Hall
	}
	return 1;
}
//==============================================================================
public SetPlayerSpawn(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	    
	    if(PlayerInfo[playerid][pLoadPos])
		{
		    SetPlayerPos(playerid,PlayerInfo[playerid][pLoadPosX],PlayerInfo[playerid][pLoadPosY],PlayerInfo[playerid][pLoadPosZ]);
		    SetPlayerInterior(playerid,PlayerInfo[playerid][pLoadPosInt]);
			SetPlayerVirtualWorld(playerid,PlayerInfo[playerid][pLoadPosW]);
			PlayerInfo[playerid][pLoadPos] = 0;
			return 1;
		}
		if(PlayerInfo[playerid][pRegistered] == 0)
		{
			TogglePlayerControllable(playerid, 0);
		}
		if(PlayerCuffed[playerid] == 1)
		{
			PlayerInfo[playerid][pJailed] = 1;
			PlayerInfo[playerid][pJailTime] = 15;
		}
		if(PlayerInfo[playerid][pHospital] > 0)
	    {
	        DoHospital(playerid);
	        return 1;
	    }
	    if(AdminDuty[playerid])
	    {
	    	SetPlayerColor(playerid,COLOR_ADMINDUTY);
			SetPlayerHealth(playerid,999);
			SetPlayerArmour(playerid,999);
	    }
	    if(PlayerInfo[playerid][pFaction] != 255)
	    {
			SetPlayerToFactionColor(playerid);
			SetPlayerToFactionSkin(playerid);
     	}
   		if(PlayerInfo[playerid][pJailed] > 0)
	    {
   			if(PlayerInfo[playerid][pJailed] == 1)
			{
		    	SetPlayerVirtualWorld(playerid,2);
		    	SetPlayerInterior(playerid,6);
				SetPlayerPos(playerid,264.5743,77.5118,1001.0391);
				SendClientMessage(playerid, COLOR_WHITE, "(INFO) You have not finished your jail time");
				return 1;
			}
			else if(PlayerInfo[playerid][pJailed] == 2)
			{
			    SetPlayerVirtualWorld(playerid,0);
		    	SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,3312.4163,-1935.4459,10.9682);
				SendClientMessage(playerid, COLOR_WHITE, "(INFO) You have not finished your jail time");
				return 1;
			}
		}
  		new house = PlayerInfo[playerid][pHouseKey];
   		if(house != 255)
		{
		    if(PlayerInfo[playerid][pSpawnPoint])
		    {
				SetPlayerInterior(playerid,Houses[house][ExitInterior]);
				SetPlayerPos(playerid, Houses[house][ExitX], Houses[house][ExitY],Houses[house][ExitZ]);
				SetPlayerVirtualWorld(playerid,house);
    			return 1;
			}
		}
  		if(PlayerInfo[playerid][pFaction] != 255)
		{
		    if(PlayerInfo[playerid][pSpawnPoint] == 0)
		    {
				SetPlayerPos(playerid,DynamicFactions[PlayerInfo[playerid][pFaction]][fX],DynamicFactions[PlayerInfo[playerid][pFaction]][fY],DynamicFactions[PlayerInfo[playerid][pFaction]][fZ]);
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
				return 1;
			}
		}
	    else
	    {
   			SetPlayerPos(playerid,CivilianSpawn[X],CivilianSpawn[Y],CivilianSpawn[Z]);
			SetPlayerVirtualWorld(playerid, CivilianSpawn[World]);
			SetPlayerInterior(playerid, CivilianSpawn[Interior]);
			SetPlayerFacingAngle(playerid,CivilianSpawn[Angle]);
			return 1;
		}
	}
	return 1;
}
//==============================================================================
public SetPlayerWeapons(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pJailed] == 0)
	    {
			if (PlayerInfo[playerid][pGun1] > 0)
			{
				SafeGivePlayerWeapon(playerid, PlayerInfo[playerid][pGun1], PlayerInfo[playerid][pAmmo1]);
				//PlayerInfo[playerid][pGun1] = 0; PlayerInfo[playerid][pAmmo1] = 0;
			}
			if (PlayerInfo[playerid][pGun2] > 0)
			{
				SafeGivePlayerWeapon(playerid, PlayerInfo[playerid][pGun2], PlayerInfo[playerid][pAmmo2]);
				//PlayerInfo[playerid][pGun2] = 0; PlayerInfo[playerid][pAmmo2] = 0;
			}
			if (PlayerInfo[playerid][pGun3] > 0)
			{
				SafeGivePlayerWeapon(playerid, PlayerInfo[playerid][pGun3], PlayerInfo[playerid][pAmmo3]);
				//PlayerInfo[playerid][pGun3] = 0; PlayerInfo[playerid][pAmmo3] = 0;
			}
			if (PlayerInfo[playerid][pGun4] > 0)
			{
				SafeGivePlayerWeapon(playerid, PlayerInfo[playerid][pGun4], PlayerInfo[playerid][pAmmo4]);
				//PlayerInfo[playerid][pGun4] = 0; PlayerInfo[playerid][pAmmo4] = 0;
			}
		}
	}
}
//==============================================================================
public OnPlayerDisconnect(playerid, reason)
{
	KillTimer(TutTimer);
    if(gPlayerLogged[playerid])
	{
 		new Float:x,Float:y,Float:z;
   		GetPlayerPos(playerid,x,y,z);
   		PlayerInfo[playerid][pLoadPosX] = x;
		PlayerInfo[playerid][pLoadPosY] = y;
		PlayerInfo[playerid][pLoadPosZ] = z;
		PlayerInfo[playerid][pLoadPosInt] = GetPlayerInterior(playerid);
		PlayerInfo[playerid][pLoadPosW] = GetPlayerVirtualWorld(playerid);
		PlayerInfo[playerid][pLoadPos] = 1;
	    PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
		VehicleLocked[VehicleLockedPlayer[playerid]] = 0;
		VehicleLockedPlayer[playerid] = 999;
		PlayerInfo[playerid][pHospital] = 0;
	    for(new slot = 0; slot < 12; slot++)
	    {
	        new wep, ammo;
	        GetPlayerWeaponData(playerid, slot, wep, ammo);

	        if(wep != 0 && ammo != 0)
	        {
	            if(PlayerInfo[playerid][pGun1] != 0) { PlayerInfo[playerid][pGun1] = wep; PlayerInfo[playerid][pAmmo1] = ammo; }
	            else if(PlayerInfo[playerid][pGun2] != 0) { PlayerInfo[playerid][pGun2] = wep; PlayerInfo[playerid][pAmmo2] = ammo; }
	            else if(PlayerInfo[playerid][pGun3] != 0) { PlayerInfo[playerid][pGun3] = wep; PlayerInfo[playerid][pAmmo3] = ammo; }
	            else if(PlayerInfo[playerid][pGun4] != 0) { PlayerInfo[playerid][pGun4] = wep; PlayerInfo[playerid][pAmmo4] = ammo; }
	        }
	    }
		if(RaceParticipant[playerid]>=1)
		{
			if(Participants==1)
			{
				endrace();
			}
			if(RaceParticipant[playerid] < 3 && RaceStart == 0 && !(RaceParticipant[playerid]==3 && RaceStart == 1))
			{
		    	ReadyRefresh();
			}
	    	Participants--;
	    	RaceParticipant[playerid]=0;
	    	DisablePlayerRaceCheckpoint(playerid);
		}
		if(RaceBuilders[playerid] != 0)
		{
   	    	DisablePlayerRaceCheckpoint(playerid);
	    	for(new i;i<BCurrentCheckpoints[b(playerid)];i++)
	    	{
    	 		BRaceCheckpoints[b(playerid)][i][0]=0.0;
   	        	BRaceCheckpoints[b(playerid)][i][1]=0.0;
	        	BRaceCheckpoints[b(playerid)][i][2]=0.0;
			}
			BuilderSlots[b(playerid)] = MAX_PLAYERS+1;
			RaceBuilders[playerid] = 0;
		}
		if(CurrentCCTV[playerid] > -1)
		{
	    	KillTimer(KeyTimer[playerid]);
	    	TextDrawHideForPlayer(playerid, TD);
		}
		CurrentCCTV[playerid] = -1;
		if(PlayerInfo[playerid][pRoadblock] != 0)
		{
			RemoveRoadblock(playerid);
		}
  		if(Planted[playerid] == 1)
		{
	    	DestroyObject(C4[playerid]);
	    	TextDrawDestroy(Meter1[playerid]);
	    	TextDrawDestroy(Meter2[playerid]);
	    	TextDrawDestroy(Meter3[playerid]);
	    	Bomb[playerid] = 0;
	    	Planted[playerid] = 0;
		}
		new playername4[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playername4, sizeof(playername4));
	    new string64[64];
        switch (reason)
	    {
 	    case 0:
	    {
		    format(string64, sizeof(string64), "%s has left the server (crashed).", playername4);
		    SendClientMessageToAll(COLOR_GREEN, string64);
	    }
	    case 1:
 	    {
		    format(string64, sizeof(string64), "%s has left the server (leaving).", playername4);
		    SendClientMessageToAll(COLOR_GREEN, string64);
	    }
        }
		OnPlayerDataSave(playerid);
	}
	return 1;
}
//==============================================================================
public OnPlayerDeath(playerid, killerid, reason)
{
  	PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
    SafeResetPlayerWeapons(playerid);
    PlayerInfo[playerid][pCards] = 0;
    PlayerInfo[playerid][pCard1] = 0;
    PlayerInfo[playerid][pCard2] = 0;
    ResetPlayerWantedLevelEx(playerid);
   	InShamal[playerid] = 0;
    InAndrom[playerid] = 0;
    CopOnDuty[playerid] = 0;
   	if(Planted[playerid] == 1)
	{
	    DestroyObject(C4[playerid]);
	    Bomb[playerid] = 0;
	    Planted[playerid] = 0;
	}
	return 1;
}
//==============================================================================
public OnVehicleDeath(vehicleid, killerid)
{
	if (GetVehicleModel(vehicleid) == 519 && ShamalExists(vehicleid) != 0)
	{
		CreateExplosion(ShamalPos[vehicleid][0], ShamalPos[vehicleid][1], ShamalPos[vehicleid][2], 2, 15.0);
		sExplode[vehicleid] = SetTimerEx("ExplodeShamal", 700, 0, "d", vehicleid);
		tCount[vehicleid] = true;
	}
    EngineStatus[vehicleid] = 0;
    Fuel[vehicleid] = GasMax;
    VehicleLocked[vehicleid] = 0;
    CarWindowStatus[vehicleid] = 1;
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	tCount[vehicleid] = false;
	for (new i = 0; i != MAX_PLAYERS; i++)
	{
		if (InShamal[i] == vehicleid) SetPlayerHealth(i, 0.0);
	}
	return 1;
}

public OnVehicleMod(playerid,vehicleid,componentid)
{
    GivePlayerCash(playerid,-1000);
	return 1;
}

public OnVehiclePaintjob(playerid,vehicleid,paintjobid)
{
    GivePlayerCash(playerid,-500);
	return 1;
}
forward OnVehicleRespray(playerid, vehicleid, color1, color2);
public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	GivePlayerCash(playerid,-100);
	return 1;
}
//==============================================================================
public OnPlayerText(playerid, text[])
{
	new string[256];
	new tmp[256];

	if(Muted[playerid])
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are muted");
		return 0;
	}
	if(RegistrationStep[playerid] > 0)
	{
 		if(RegistrationStep[playerid] == 1)
	    {
			new age = strval(text);
	    	if (age >= 16 && age <= 100)
	 		{
		 		new wstring[128];
		    	format(wstring, sizeof(wstring),"(INFO) So, you are %d years old.", age);
		    	SendClientMessage(playerid,COLOR_WHITE, wstring);
	    		PlayerInfo[playerid][pAge] = age;
	    		RegistrationStep[playerid] = 2;
	    		SendClientMessage(playerid,COLOR_RED,"<|> Step Two <|>");
	 	    	SendClientMessage(playerid, COLOR_WHITE, "(INFO) State your sex. (Male or Female)");
	 		}
	 		else
	 		{
	 		    SendClientMessage(playerid, COLOR_GREY, "(INFO) That age is not valid. (Valid ones are 16-100)");
	 		}
	 		return 0;
		}
 		else if(RegistrationStep[playerid] == 2)
  		{
	  	    new idx2;
	    	tmp = strtok(text, idx2);
		    if((strcmp("male", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("male")))
			{
	  			PlayerInfo[playerid][pSex] = 1;
	   			SendClientMessage(playerid, COLOR_WHITE, "(INFO) So, you are a man.");
	   			SendClientMessage(playerid,COLOR_RED,"(INFO) Registration completed.");
		    	RegistrationStep[playerid] = 0;
		    	PlayerInfo[playerid][pTut] = 0;
		    	PlayerInfo[playerid][pRegistered] = 1;
                SpawnPlayer(playerid);
			    return 0;
			}
			else if((strcmp("female", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("female")))
			{
  				PlayerInfo[playerid][pSex] = 2;
  				SendClientMessage(playerid, COLOR_WHITE, "(INFO) So, you are a woman.");
  				SendClientMessage(playerid,COLOR_RED,"(INFO) Registration completed.");
				RegistrationStep[playerid] = 0;
				PlayerInfo[playerid][pTut] = 0;
				PlayerInfo[playerid][pRegistered] = 1;
				SpawnPlayer(playerid);
   				return 0;
			}
			else
			{
  				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid sex, type male/female");
	 		}
			return 0;
		}
	}
	if(TalkingLive[playerid] != 255)
	{
	    new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(PlayerInfo[playerid][pFaction] == 3)
		{
		    format(string, sizeof(string), "Host %s: %s", sendername, text);
			OOCNews(COLOR_RED, string);
		}
		else
		{
		    format(string, sizeof(string), "Guest %s: %s", sendername, text);
			OOCNews(COLOR_RED, string);
		}
		return 0;
	}
	if(Mobile[playerid] == 911)
	{
		format(string, sizeof(string), "(911 CALL) %s(ID:%d) says: %s",GetPlayerNameEx(playerid),playerid,text);
		SendFactionMessage(0, COLOR_LSPD, string);
		SendClientMessage(playerid,COLOR_LSPD,"(DISPATCH) We have alerted all units in the area");
		SendClientMessage(playerid,COLOR_LSPD,"(DISPATCH) Thank you for reporting this incident");
		SendClientMessage(playerid, COLOR_WHITE, "(INFO) They Hung Up...");
		Mobile[playerid] = 255;
		format(string, sizeof(string), "(INFO) Reported Incident - %s says: %s", GetPlayerNameEx(playerid), text);
		ProxDetector(3.0, playerid, string,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE);
		TalkLog(string);
		return 0;
	}
	if(Mobile[playerid] == 411)
	{
		format(string, sizeof(string), "(TAXI) %s(ID:%d) says: %s",GetPlayerNameEx(playerid),playerid,text);
		SendFactionMessage(4, COLOR_YELLOW, string);
		SendClientMessage(playerid,COLOR_YELLOW,"(OPERATOR) Taxi drivers notified, please standby");
		SendClientMessage(playerid, COLOR_WHITE, "(INFO) They Hung Up...");
		Mobile[playerid] = 255;
		new location[MAX_ZONE_NAME];
		GetPlayer2DZone(playerid, location, MAX_ZONE_NAME);
		format(string, sizeof(string), "(OPERATOR) All taxi drivers be on the lookout for %s - Location: %s", GetPlayerNameEx(playerid),location);
     	SendFactionMessage(4, COLOR_YELLOW, string);
		TalkLog(string);
		return 0;
	}
	if(Mobile[playerid] == 123)
	{
		format(string, sizeof(string), "(SAN MESSAGE) %s(ID:%d) says: %s",GetPlayerNameEx(playerid),playerid,text);
		SendFactionMessage(3, COLOR_LIGHTBLUE, string);
		SendClientMessage(playerid,COLOR_YELLOW,"(OPERATOR) Thank you, your message was sent to S.A.N.");
		SendClientMessage(playerid, COLOR_WHITE, "(INFO) They hung up. (( Use /hangup to hang up. ))");
		Mobile[playerid] = 255;
		TalkLog(string);
		return 0;
	}
	if(Mobile[playerid] != 255)
	{
		format(string, sizeof(string), "%s says (cellphone): %s", GetPlayerNameEx(playerid), text);
		ProxDetector(5.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        TalkLog(string);
		if(IsPlayerConnected(Mobile[playerid]))
		{
		    if(Mobile[Mobile[playerid]] == playerid)
		    {
				SendClientMessage(Mobile[playerid], COLOR_WHITE,string);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) Theres nobody on the line");
		}
		return 0;
	}
	if (realchat)
	{
	    if(gPlayerLogged[playerid] == 0)
	    {
	        return 0;
      	}
      	if(!IsPlayerInAnyVehicle(playerid) || IsABike(GetPlayerVehicleID(playerid)))
      	{
			format(string, sizeof(string), "%s says: %s", GetPlayerNameEx(playerid), text);
			ProxDetector(20.0, playerid, string,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE);
			TalkLog(string);
		}
		else
		{
		    if(CarWindowStatus[GetPlayerVehicleID(playerid)] == 1)
		    {
				format(string, sizeof(string), "(WINDOWS CLOSED) %s says: %s", GetPlayerNameEx(playerid), text);
				ProxDetector(10.0, playerid, string,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE);
				TalkLog(string);
			}
			else
			{
				format(string, sizeof(string), "(WINDOWS OPEN) %s says: %s", GetPlayerNameEx(playerid), text);
				ProxDetector(20.0, playerid, string,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE);
				TalkLog(string);
			}
		}
		return 0;
	}
	return 1;
}
//==============================================================================
public OnPlayerCommandText(playerid, cmdtext[])
{
	dcmd(rob,3,cmdtext);
   	dcmd(racehelp,8,cmdtext);
   	dcmd(racelist,8,cmdtext);
	dcmd(buildhelp,9,cmdtext);
	dcmd(buildrace,9,cmdtext);
	dcmd(cp,2,cmdtext);
	dcmd(scp,3,cmdtext);
	dcmd(rcp,3,cmdtext);
	dcmd(mcp,3,cmdtext);
	dcmd(dcp,3,cmdtext);
	dcmd(clearrace,9,cmdtext);
	dcmd(editrace,8,cmdtext);
	dcmd(saverace,8,cmdtext);
	dcmd(setlaps,7,cmdtext);
	dcmd(racemode,8,cmdtext);
	dcmd(loadrace,8,cmdtext);
	dcmd(startrace,9,cmdtext);
	dcmd(join,4,cmdtext);
	dcmd(leave,5,cmdtext);
	dcmd(endrace,7,cmdtext);
	dcmd(ready,5,cmdtext);
	dcmd(bestlap,7,cmdtext);
	dcmd(bestrace,8,cmdtext);
	dcmd(deleterace,10,cmdtext);
	dcmd(airrace,7,cmdtext);
	dcmd(cpsize,6,cmdtext);
	dcmd(prizemode,9,cmdtext);
	dcmd(setprize,8,cmdtext);
	dcmd(raceadmin,9,cmdtext);
	dcmd(buildmenu,9,cmdtext);
	new string[256];
	new cmd[256];
	new idx;
	cmd = strtok(cmdtext, idx);
	new tmp[256];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new giveplayerid;

	if(gPlayerLogged[playerid] == 1)
	{
	if(PlayerInfo[playerid][pHospital] >= 1 && AdminDuty[playerid] != 1)
	{
	    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are in hospital, wait until you are released");
	    return 1;
	}
	if(strcmp(cmd, "/acommands", true) == 0 || strcmp(cmd, "/ahelp", true) == 0 || strcmp(cmd,"/acmds", true) == 0 || strcmp(cmd,"/ah", true) == 0)
	{
 		if(IsPlayerConnected(playerid))
	    {
	        SendClientMessage(playerid,COLOR_RED,"<|> Admin Commands <|>");
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				SendClientMessage(playerid, COLOR_WHITE, "(MODERATOR) (/a)dmin - /adminduty - /ban - /unbanip - /kick - /lockaccount - /warn - /mute - /skydive");
				SendClientMessage(playerid, COLOR_WHITE, "(MODERATOR) /goto - /gethere - /oocstatus - /listenchat - /freeze - /unfreeze - /check - /setvw - /fourdive");
				SendClientMessage(playerid, COLOR_WHITE, "(MODERATOR) /ajail - /agovjail - /gotolv - /gotosf - /gotols - /getcar - /fixcar - /destroycar - /learn");
				SendClientMessage(playerid, COLOR_WHITE, "(MODERATOR) /aunjail - /agovunjail - /getip - /apositionhelp - /serverinfo - /racehelp - /buildhelp");
	   		}
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
				SendClientMessage(playerid, COLOR_WHITE, "(SENIOR) /agivedrugs - /asetdrugs - /agivemats - /asetmats - /agiveproducts - /asetproducts");
				SendClientMessage(playerid, COLOR_WHITE, "(SENIOR) /adonator - /asetmoney - /agivemoney - /agivegun - /asethp - /asetarmour - /startlotto");
				SendClientMessage(playerid, COLOR_WHITE, "(SENIOR) /alistfaction - /broadcast - /logoutall - /respawnvehicles - /fuelcars - /unlockcars");
				SendClientMessage(playerid, COLOR_WHITE, "(SENIOR) /agivelicense - /carid - /searchcar - /update - /lottomessage - /spectateusername35");
			}
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				SendClientMessage(playerid, COLOR_WHITE, "(OWNER) /gmx - /setadmin - /asetleader - /aresetfaction - /acivilianspawn - /rconpass - /addveh");
				SendClientMessage(playerid, COLOR_WHITE, "(OWNER) /abuildinghelp - /afactionhelp - /apositionhelp - /acarhelp - /ahousehelp - /ajobhelp - /abusinesshelp");
			}
			SendClientMessage(playerid,COLOR_RED,"<|> Admin Commands <|>");
		}
		return 1;
	}
	if(strcmp(cmd, "/afactionhelp", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
			    SendClientMessage(playerid,COLOR_RED,"<|> Admin Faction Commands <|>");
				SendClientMessage(playerid, COLOR_WHITE, "(OWNER) /afactionkick");
				SendClientMessage(playerid, COLOR_WHITE, "(OWNER) /afactioncolor - /afactionspawn - /afactionname - /afactionuseskins - /afactionrankamount - /afactiontype");
				SendClientMessage(playerid, COLOR_WHITE, "(OWNER) /afactionjoinrank - /afactiondrugs - /afactionbank - /afactionmats - /afactionskin");
				SendClientMessage(playerid, COLOR_WHITE, "(OWNER) /afactionrankname - /agotofaction - /afactionusecolor - /afactiondrugsstorage - /afactionmatsstorage");
				SendClientMessage(playerid,COLOR_RED,"<|> Admin Faction Commands <|>");
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
			return 1;
		}
	}
 	if(strcmp(cmd, "/abusinesshelp", true) == 0)
	{
		if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
		    	SendClientMessage(playerid,COLOR_RED,"<|> Admin Business Commands <|>");
				SendClientMessage(playerid, COLOR_WHITE, "(OWNER) /abusinessentrance - /abusinessexit - /abusinessprice - /agotobusiness - /abusinessproducts - /abusinesssell");
				SendClientMessage(playerid, COLOR_WHITE, "(OWNER) /abusinessint - /abusinessname");
				SendClientMessage(playerid,COLOR_RED,"<|> Admin Business Commands <|>");
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
			return 1;
		}
	}
	if(strcmp(cmd, "/abuildinghelp", true) == 0)
	{
		if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
		    	SendClientMessage(playerid,COLOR_RED,"<|> Admin Building Commands <|>");
				SendClientMessage(playerid, COLOR_WHITE, "(OWNER) /abuildingname - /abuildingentrance - /abuildingexit - /abuildingfee - /abuildinglock");
				SendClientMessage(playerid, COLOR_WHITE, "(OWNER) /abuildingint - /agotobuilding");
				SendClientMessage(playerid,COLOR_RED,"<|> Admin Building Commands <|>");
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
			return 1;
		}
	}
 	if(strcmp(cmd, "/ajobhelp", true) == 0)
	{
		if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
		    	SendClientMessage(playerid,COLOR_RED,"<|> Admin Job Commands <|>");
				SendClientMessage(playerid, COLOR_WHITE, "(GUN JOB) /agunjobpos (/takejob) - /agunjobpos2 (/materials buy) - /agunjobpos3 (/materials dropoff) ");
				SendClientMessage(playerid, COLOR_WHITE, "(DRUG JOB) /adrugjobpos (/takejob) - /adrugjobpos2 (/drugs buy) - /adrugjobpos3 (/drugs dropoff) ");
				SendClientMessage(playerid, COLOR_WHITE, "(DETECTIVE JOB) /adetectivejobpos (/takejob) ");
				SendClientMessage(playerid, COLOR_WHITE, "(LAWYER JOB) /alawyerjobpos (/takejob");
				SendClientMessage(playerid, COLOR_WHITE, "(PRODUCTS SELLER JOB) /aproductjobpos (/takejob) - /aproductjobpos2 (/products buy)");
				SendClientMessage(playerid, COLOR_WHITE, "(MECHANIC JOB) /amechanicjobpos (/takejob) ");
				SendClientMessage(playerid,COLOR_RED,"<|> Admin Job Commands <|>");
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
			return 1;
		}
	}
	if(strcmp(cmd, "/heal", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    if(PlayerInfo[playerid][pFaction] == 10)
	    {
	            tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /heal [playerid/partofname]");
					return 1;
				}
	            giveplayerid = ReturnUser(tmp);
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
				    if(ProxDetectorS(10.0,playerid,giveplayerid))
				    {
				    SetPlayerHealth(giveplayerid, 100);
				    SendClientMessage(giveplayerid, COLOR_WHITE, "You have been healed to 100 hp.");
				    new heal1[128];
				    format(heal1, sizeof(heal1), "You have healed %s.",GetPlayerNameEx(giveplayerid));
				    SendClientMessage(playerid, COLOR_WHITE, heal1);
					}
					else
					{
					SendClientMessage(playerid, COLOR_WHITE, "(ERROR) You are not close to that player.");
					}
					}
				}
				else
				{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
				}
				}
				else
				{
					SendClientMessage(playerid, COLOR_WHITE, "(ERROR) You are not a medic!");
				}
		}
		return 1;
		}
    if(strcmp(cmd, "/giveweaponlicense", true) == 0)
		{
	    if(IsPlayerConnected(playerid))
	    {
	    if(PlayerInfo[playerid][pFaction] == 0)
	    {
	            tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /giveweaponlicense [playerid/partofname]");
					return 1;
				}
	            giveplayerid = ReturnUser(tmp);
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
				    new wep1[128];
				    PlayerInfo[giveplayerid][pWepLic] = 1;
				    format(wep1, sizeof(wep1), "gives %s a weapon license.",GetPlayerNameEx(giveplayerid));
				    PlayerActionMessage(playerid,15.0,wep1);
				    SendClientMessage(giveplayerid, COLOR_WHITE, "You have recieved a weapon license!");
				    new give1[128];
				    format(give1, sizeof(give1), "You have given %s a weapon license.", GetPlayerNameEx(giveplayerid));
				    SendClientMessage(playerid, COLOR_WHITE, give1);
					}
				}
				else
				{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
				}
				}
				else
				{
					SendClientMessage(playerid, COLOR_WHITE, "(ERROR) You are not a police officer!");
				}
		}
		return 1;
		}
    if(strcmp(cmd, "/medichelp", true) == 0)
		{
		if(PlayerInfo[playerid][pFaction] == 10)
		{
		SendClientMessage(playerid, COLOR_RED, "<|> Medic Commands <|>");
		SendClientMessage(playerid, COLOR_WHITE, "/heal - Heals a person to 100 HP.");
		SendClientMessage(playerid, COLOR_RED, "<|> Medic Commands <|>");
		}
    }
	if(strcmp(cmd, "/gotonewvehicle", true) == 0)
	{
	if(PlayerInfo[playerid][pAdmin] >= 20)
	{
	SetPlayerPos(playerid,2119.0, -1166.5, 24.0);
	}
	}
	if(strcmp(cmd, "/addnewvehicle", true) == 0)
	{
	if(PlayerInfo[playerid][pAdmin] >= 20)
	{
    SendClientMessage(playerid, COLOR_LIGHTGREEN, "Disabled - they always spawn there, so no need. Do /gotonewvehicle.");
    SendClientMessage(playerid, COLOR_YELLOW, "RECOMMENDED NOT TO USE, EXTREMELY BUGGY *|* CAN CAUSE MAJOR PROBELMS *|*");
    }
	}
	if(strcmp(cmd, "/help", true) == 0 || strcmp(cmd, "/commands", true) == 0 || strcmp(cmd, "/cmds", true) == 0)
	{
 		if(IsPlayerConnected(playerid))
	    {
		    SendClientMessage(playerid,COLOR_RED,"<|> Commands <|>");
			SendClientMessage(playerid, COLOR_WHITE, "(GENERAL) /stats - /time - /admins - /changepass - /spawnpoint - /donate - /anim - /stopanim");
			SendClientMessage(playerid, COLOR_WHITE, "(GENERAL) /advertise - /licenses - /showid - /id - /help - /accept - /cancel - /pay - /report - /toggle");
			SendClientMessage(playerid, COLOR_WHITE, "(GENERAL) /engine - /lock - /refuel - /eject - /carwindows - /tie - /untie - /frisk - /searchwallet");
			SendClientMessage(playerid, COLOR_WHITE, "(GENERAL) /sellcar - /beg - /bail - /dice - /coin - /lotto - /kill - /plantbomb - /detonatebomb");
			SendClientMessage(playerid, COLOR_WHITE, "(GENERAL) /blindfold - /unblindfold - /skinlist - /askq - /rules - /updates - /laws");
			SendClientMessage(playerid, COLOR_WHITE, "(GENERAL) /buy - /buyweapon - /buydrink - /buyclothes - /eat - /usedrugs - /takejob - /quitjob");
			SendClientMessage(playerid, COLOR_WHITE, "(GENERAL) /househelp - /businesshelp - /jobhelp - /chathelp - /notehelp - /phonehelp - /bankhelp - /racehelp");
			SendClientMessage(playerid, COLOR_WHITE, "(GENERAL) /seatbelt - /walk - /poker - /cards");
	        if (PlayerInfo[playerid][pFaction] != 255)
			{
			if(DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
	  			SendClientMessage(playerid, COLOR_WHITE, "(POLICE) /policehelp");
			}
			if(DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 2)
			{
			    SendClientMessage(playerid, COLOR_WHITE, "(GANG) /ganghelp");
			}
			if(PlayerInfo[playerid][pFaction] == 10)
			{
			SendClientMessage(playerid, COLOR_WHITE, "(MEDIC) /medichelp");
			}
			if(PlayerInfo[playerid][pFaction] == 3)
			{
			    SendClientMessage(playerid, COLOR_WHITE, "(NEWS REPORTER) /newshelp");
			}
			if(PlayerInfo[playerid][pRank] == 1)
			{
				SendClientMessage(playerid, COLOR_WHITE, "(LEADER) /leaderhelp");
			}
			SendClientMessage(playerid, COLOR_WHITE, "(FACTION) /factionhelp");
			}
			if(PlayerInfo[playerid][pAdmin] >= 1)
			{
		    		SendClientMessage(playerid, COLOR_WHITE, "(ADMIN) /(ah)elp");
			}
			SendClientMessage(playerid,COLOR_RED,"<|> Commands <|>");
	    }
	    return 1;
	}
	if(strcmp(cmd, "/rules", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			SendClientMessage(playerid,COLOR_RED,"<|> Rules <|>");
			SendClientMessage(playerid, COLOR_WHITE, "(INFO) The following is not allowed:");
			SendClientMessage(playerid, COLOR_WHITE,"									                           ");
			SendClientMessage(playerid, COLOR_WHITE, "(METAGAMING) Using OOC knowledge IC");
			SendClientMessage(playerid, COLOR_WHITE, "(POWERGAMING) Forcing another player in an incorrect RP manner");
			SendClientMessage(playerid, COLOR_WHITE, "(REVENGE-KILLING) Killing people after they already killed you");
			SendClientMessage(playerid, COLOR_WHITE, "(DEATHMATCH a.k.a DM) Killing people for no reason");
			SendClientMessage(playerid, COLOR_WHITE, "(BUG ABUSING) Abusing a bug continuously");
			SendClientMessage(playerid, COLOR_YELLOW, "See more of these rules at the-god-father.com");
			SendClientMessage(playerid,COLOR_RED,"<|> Rules <|>");
		}
		return 1;
	}
	if(strcmp(cmd, "/poker", true) == 0)
	{
	   new x_info[256];
       x_info = strtok(cmdtext, idx);
       if(!strlen(x_info))
	   {
       SendClientMessage(playerid, COLOR_RED, "<|> Poker Commands <|>");
       SendClientMessage(playerid, COLOR_WHITE, "________________ Dealer ________________");
       SendClientMessage(playerid, COLOR_WHITE, "Use /poker dealerhelp to see ALL dealer commands.");
       SendClientMessage(playerid, COLOR_WHITE, "_______________ Player ________________");
       SendClientMessage(playerid, COLOR_WHITE, "Use /poker playerhelp to see ALL player commands.");
       SendClientMessage(playerid, COLOR_WHITE, "_______________________________________");
       SendClientMessage(playerid, COLOR_YELLOW, "0 - Joker, 1 - Ace, 11 - Jack, 12 - Queen, 13 - King (All others normal)");
       return 1;
       }
       if(strcmp(x_info, "dealerjob", true) == 0)
       {
	   if(PlayerInfo[playerid][pDealer] >= 1)
	   {
	   SendClientMessage(playerid, COLOR_WHITE, "You are already a dealer! Do /poker stopdeal if you want to stop being one!");
	   }
	   else if(PlayerInfo[playerid][pCash] < 1000)
	   {
	   SendClientMessage(playerid, COLOR_WHITE, "You need $1000 to be a poker dealer!");
	   }
	   else if(PlayerInfo[playerid][pCards] >= 1)
	   {
       GivePlayerCash(playerid,-1000);
	   PlayerInfo[playerid][pDealer] = 1;
	   SendClientMessage(playerid, COLOR_WHITE, "You have paid $1000, and are now a dealer.");
       PlayerActionMessage(playerid,15.0,"becomes a dealer.");
	   }
	   else
	   {
	   SendClientMessage(playerid, COLOR_WHITE, "You don't have a deck of cards! Go buy one at any 24/7!");
	   }
	   }
	   if(strcmp(x_info, "leavejob", true) == 0)
	   {
	   if(PlayerInfo[playerid][pDealer] >= 1)
	   {
	   PlayerInfo[playerid][pDealer] = 0;
	   SendClientMessage(playerid, COLOR_WHITE, "You have stopped being a dealer.");
       PlayerActionMessage(playerid,15.0,"stops being a dealer.");
       PlayerInfo[playerid][pFlop1] = 0;
       PlayerInfo[playerid][pFlop2] = 0;
       PlayerInfo[playerid][pFlop3] = 0;
       PlayerInfo[playerid][pRiver] = 0;
       PlayerInfo[playerid][pTurn] = 0;
       }
	   else
	   {
	   SendClientMessage(playerid, COLOR_WHITE, "You are not a dealer!");
	   }
	   }
	   if(strcmp(x_info, "playerhelp", true) == 0)
	   {
	   	SendClientMessage(playerid, COLOR_RED, "<|> Poker Player Commands <|>");
        SendClientMessage(playerid, COLOR_WHITE, "/poker fold - Folds your cards, you will be out.");
        SendClientMessage(playerid, COLOR_WHITE, "/poker see - See your cards, if you forgot them.");
        SendClientMessage(playerid, COLOR_WHITE, "/poker checkcards [id] - Put your dealer's ID in to see the opened cards.");
        SendClientMessage(playerid, COLOR_WHITE, "/poker learntoplay - Learn to play poker, the TGF way.");
        SendClientMessage(playerid, COLOR_WHITE, "/poker reveal - Reveals your cards to the public.");
        SendClientMessage(playerid, COLOR_YELLOW, "0 - Joker, 1 - Ace, 11 - Jack, 12 - Queen, 13 - King (All others normal)");
        }
       if(strcmp(x_info, "dealerhelp", true) == 0)
	   {
   	   SendClientMessage(playerid, COLOR_RED, "<|> Poker Dealer Commands <|>");
       SendClientMessage(playerid, COLOR_WHITE, "/poker dealerjob - Become a dealer.");
       SendClientMessage(playerid, COLOR_WHITE, "/poker flop - Deals the flop. (First 3 cards).");
       SendClientMessage(playerid, COLOR_WHITE, "/poker river - Deals the river. (4th card).");
       SendClientMessage(playerid, COLOR_WHITE, "/poker turn - Deals the turn. (5th card.");
       SendClientMessage(playerid, COLOR_WHITE, "/poker distribute [id] - Distributes 2 cards to the player.");
       SendClientMessage(playerid, COLOR_WHITE, "/poker delete - Removes all the cards from the table.");
       SendClientMessage(playerid, COLOR_WHITE, "/poker removecards [id] - Removes the cards of the person of that ID (end of round).");
       SendClientMessage(playerid, COLOR_WHITE, "/poker leavejob - Stop being a dealer.");
       SendClientMessage(playerid, COLOR_YELLOW, "0 - Joker, 1 - Ace, 11 - Jack, 12 - Queen, 13 - King (All others normal)");
       }
	   if(strcmp(x_info, "flop", true) == 0)
	   {
	   if(PlayerInfo[playerid][pDealer] >= 1)
	   {
	   new flop[128];
	   PlayerInfo[playerid][pFlop1] = random(13);
	   PlayerInfo[playerid][pFlop2] = random(13);
	   PlayerInfo[playerid][pFlop3] = random(13);
	   format(flop, sizeof(flop), "deals the flop: %d, %d, %d. (( /poker checkcards to see all the opened cards. ))",PlayerInfo[playerid][pFlop1],PlayerInfo[playerid][pFlop2],PlayerInfo[playerid][pFlop3]);
       PlayerActionMessage(playerid,15.0,flop);
       return 1;
       }
       else
       {
       SendClientMessage(playerid, COLOR_WHITE, "You are not a dealer!");
       }
       }
   	   if(strcmp(x_info, "river", true) == 0)
	   {
	   if(PlayerInfo[playerid][pDealer] >= 1)
	   {
	   new river[128];
	   PlayerInfo[playerid][pRiver] = random(13);
	   format(river, sizeof(river), "opens the river: %d. (( /poker checkcards to see all the opened cards. ))",PlayerInfo[playerid][pRiver]);
       PlayerActionMessage(playerid,15.0,river);
       }
       else
       {
       SendClientMessage(playerid, COLOR_WHITE, "You are not a dealer!");
       }
       }
   	   if(strcmp(x_info, "turn", true) == 0)
	   {
	   if(PlayerInfo[playerid][pDealer] >= 1)
	   {
	   new turn[128];
	   PlayerInfo[playerid][pTurn] = random(13);
	   format(turn, sizeof(turn), "opens the turn: %d. (( /poker checkcards to see all the opened cards. ))",PlayerInfo[playerid][pTurn]);
       PlayerActionMessage(playerid,15.0,turn);
       }
       else
       {
       SendClientMessage(playerid, COLOR_WHITE, "You are not a dealer!");
       }
       }
       if(strcmp(x_info, "learntoplay", true) == 0)
       {
       	SendClientMessage(playerid, COLOR_RED, "<|> Learn to play Poker <|>");
	    SendClientMessage(playerid, COLOR_WHITE, "Alright, first, you might have noticed we are number-based, meaning no Spades etc.");
	    SendClientMessage(playerid, COLOR_WHITE, "So, it's basically the same as Texas Hold'em, except no signs.");
        SendClientMessage(playerid, COLOR_WHITE, "You can still have full houses, straights, etc.");
        SendClientMessage(playerid, COLOR_WHITE, "As you read before, this is TEXAS HOLD'EM, just without the signs.");
	    SendClientMessage(playerid, COLOR_WHITE, "Have fun guys, and donate for a better server! :D");
	   }
       if(strcmp(x_info, "distribute", true) == 0)
      {
	    if(IsPlayerConnected(playerid))
	    {
	    if(PlayerInfo[playerid][pDealer] >= 1)
	    {
	            tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /poker distribute [playerid/partofname]");
					return 1;
				}
	            giveplayerid = ReturnUser(tmp);
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
				    if(ProxDetectorS(8.0, playerid, giveplayerid))
				    {
				    new distribute[128];
				    format(distribute, sizeof(distribute), "distributes two random cards to %s.",GetPlayerNameEx(giveplayerid));
				    PlayerActionMessage(playerid,15.0,distribute);
				    PlayerInfo[giveplayerid][pCard1] = random(13);
				    PlayerInfo[giveplayerid][pCard2] = random(13);
				    }
				    else
				    {
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You're not near that player.");
				    }
					}
				}
				else
				{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
				}
				}
				else
				{
					SendClientMessage(playerid, COLOR_WHITE, "You are not a dealer!");
				}
		}
		return 1;
		}
       if(strcmp(x_info, "removecards", true) == 0)
       {
	    if(IsPlayerConnected(playerid))
	    {
	    if(PlayerInfo[playerid][pDealer] >= 1)
	    {
	            tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /poker removecards [playerid/partofname]");
					return 1;
				}
	            giveplayerid = ReturnUser(tmp);
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
				    if(ProxDetectorS(8.0,playerid,giveplayerid))
				    {
				    if(PlayerInfo[playerid][pCard1] >= 1)
				    {
				    new remove[128];
				    format(remove, sizeof(remove), "takes the cards from %s.",GetPlayerNameEx(giveplayerid));
				    PlayerActionMessage(playerid,15.0,remove);
				    PlayerInfo[giveplayerid][pCard1] = 0;
				    PlayerInfo[giveplayerid][pCard2] = 0;
					}
					else
					{
					SendClientMessage(playerid, COLOR_WHITE, "That player does not have any cards for you to take!");
					}
					}
					else
					{
					SendClientMessage(playerid, COLOR_WHITE, "(ERROR) You're not close to that player.");
					}
					}
				}
				else
				{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
				}
				}
				else
				{
					SendClientMessage(playerid, COLOR_WHITE, "You are not a dealer!");
				}
		}
		return 1;
		}
        if(strcmp(x_info, "reveal", true) == 0)
	    {
		if(PlayerInfo[playerid][pCard1] >= 1)
		{
		new show1[128];
	    format(show1, sizeof(show1), "reveals his two cards: %d and %d.",PlayerInfo[playerid][pCard1],PlayerInfo[playerid][pCard2]);
	    PlayerActionMessage(playerid,15.0,show1);
	    }
	    else
	    {
	    SendClientMessage(playerid, COLOR_WHITE, "You don't have any cards to reveal!");
	    }
     }
	    if(strcmp(x_info, "see", true) == 0)
	   {
	   if(PlayerInfo[playerid][pCard1] >= 1)
	   {
	   new see1[128];
	   format(see1, sizeof(see1), "Your cards are: %d and %d.",PlayerInfo[playerid][pCard1], PlayerInfo[playerid][pCard2]);
	   SendClientMessage(playerid, COLOR_WHITE, see1);
	   PlayerActionMessage(playerid, 15.0, "takes a look at his cards.");
	   }
	   else
	   {
	   SendClientMessage(playerid, COLOR_WHITE, "You don't have any cards to see!");
	   }
	   }
	   if(strcmp(x_info, "fold", true) == 0)
	   {
	   if(PlayerInfo[playerid][pCard1] >= 1)
	   {
	   PlayerInfo[playerid][pCard1] = 0;
	   PlayerInfo[playerid][pCard2] = 0;
	   SendClientMessage(playerid, COLOR_WHITE, "You successfully folded your cards.");
	   PlayerActionMessage(playerid,15.0,"folds his cards, he is out.");
	   }
	   else
	   {
	   SendClientMessage(playerid, COLOR_WHITE, "You don't have any cards to fold!");
	   }
	   }
       if(strcmp(x_info, "checkcards", true) == 0)
      {
	    if(IsPlayerConnected(playerid))
	    {
	            tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /poker checkcards [playerid/partofname]");
					return 1;
				}
	            giveplayerid = ReturnUser(tmp);
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
				    if(ProxDetectorS(10.0,playerid,giveplayerid))
				    {
				    if(PlayerInfo[giveplayerid][pDealer] >= 1)
				    {
				    new string2[128];
				    new Flop1 = PlayerInfo[giveplayerid][pFlop1];
				    new Flop2 = PlayerInfo[giveplayerid][pFlop2];
				    new Flop3 = PlayerInfo[giveplayerid][pFlop3];
				    new Flop4 = PlayerInfo[giveplayerid][pRiver];
				    new Flop5 = PlayerInfo[giveplayerid][pTurn];
				    format(string2, sizeof(string2), "You check the dealer's cards: %d, %d, %d, %d, %d.",Flop1,Flop2,Flop3,Flop4,Flop5);
				    SendClientMessage(playerid, COLOR_YELLOW, string2);
				    SendClientMessage(playerid, COLOR_YELLOW, "Remember, any card that is 0 means it has not been opened.");
				    new name[128];
	                format(name, sizeof(name), "checks the cards of the dealer. (%s)",GetPlayerNameEx(giveplayerid));
				    PlayerActionMessage(playerid,15.0,name);
					}
					else
					{
					SendClientMessage(playerid, COLOR_WHITE, "That person is not a dealer!");
					}
					}
					else
					{
					SendClientMessage(playerid, COLOR_WHITE, "(ERROR) You are not close to that player.");
					}
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
				}
		}
		return 1;
		}
   	   if(strcmp(x_info, "delete", true) == 0)
	   {
	   if(PlayerInfo[playerid][pDealer] >= 1)
	   {
	   new delete1[128];
	   PlayerInfo[playerid][pTurn] = 0;
	   PlayerInfo[playerid][pFlop1] = 0;
	   PlayerInfo[playerid][pFlop2] = 0;
	   PlayerInfo[playerid][pFlop3] = 0;
	   PlayerInfo[playerid][pRiver] = 0;
	   format(delete1, sizeof(delete1), "removes all the cards from the table. (Flop, River, Turn)");
       PlayerActionMessage(playerid,15.0,delete1);
       }
       else
       {
       SendClientMessage(playerid, COLOR_WHITE, "You are not a dealer!");
       }
       }
	}

	if(strcmp(cmd, "/cards", true) == 0)
	{
       SendClientMessage(playerid, COLOR_RED, "<|> Deck of Cards <|>");
       if(PlayerInfo[playerid][pCards] >= 1)
       {
       SendClientMessage(playerid, COLOR_YELLOW, "(*) You have a deck of cards.");
       }
       else
       {
       SendClientMessage(playerid, COLOR_WHITE, "(*) You don't have a deck of cards.");
       }
       SendClientMessage(playerid, COLOR_WHITE, "When you bought them, use /poker to play with them.");
       SendClientMessage(playerid, COLOR_YELLOW, "Numbers you can get are 0-13. Here's a short description of them:");
       SendClientMessage(playerid, COLOR_YELLOW, "0 - Joker, 1 - Ace, 11 - Jack, 12 - Queen, 13 - King");
       return 1;
	}
       
 	if(strcmp(cmd, "/househelp", true) == 0)
	{
 		if(IsPlayerConnected(playerid))
	    {
	    	SendClientMessage(playerid,COLOR_RED,"<|> House Commands <|>");
			SendClientMessage(playerid, COLOR_WHITE, "(HOUSE) /enter - /exit - /buyhouse - /sellhouse - /openhouse");
			SendClientMessage(playerid, COLOR_WHITE, "(HOUSE) /editrenting - /rentfee - /renthouse - /housewithdraw - /housedeposit");
			SendClientMessage(playerid, COLOR_WHITE, "(HOUSE) /housematsput - /housematstake - /housedrugsput - /housedrugstake");
			SendClientMessage(playerid,COLOR_RED,"<|> House Commands <|>");
	    }
	    return 1;
	}
	if(strcmp(cmd, "/skinlist", true) == 0)
	{
 		if(IsPlayerConnected(playerid))
	    {
		    SendClientMessage(playerid,COLOR_RED,"<|> Skin List <|>");
			SendClientMessage(playerid, COLOR_WHITE, "(SKIN ID) |1|2|7|9|11|12|13|14|15|16|17|18|19|20|22|23|24|25|26|27|29|30|31|32|33|34|35|36|37|38|39|40|41|");
			SendClientMessage(playerid, COLOR_WHITE, "(SKIN ID) |43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|60|62|63|64|66|67|68|69|70|72|73|75|76|77|78|");
			SendClientMessage(playerid, COLOR_WHITE, "(SKIN ID) |79|80|81|82|83|84|85|87|88|89|90|91|93|94|95|96|97|98|100|101|106|108|109|110|113|120|121|122|");
			SendClientMessage(playerid, COLOR_WHITE, "(SKIN ID) |125|128|129|130|131|132|133|134|135|136|137|138|139|140|141|142|148|150|151|152|153|154|155|156|");
			SendClientMessage(playerid, COLOR_WHITE, "(SKIN ID) |157|158|159|160|161|162|163|164|166|167|168|169|170|172|176|177|179|180|182|183|184|185|187|");
			SendClientMessage(playerid, COLOR_WHITE, "(SKIN ID) |190|191|192|193|194|195|196|197|198|199|200|201|202|203|204|205|206|207|209|210|211|212|213|214|");
			SendClientMessage(playerid, COLOR_WHITE, "(SKIN ID) |215|216|218|219|220|221|223|224|225|226|227|228|229|230|231|232|233|234|235|236|237|238|239|241|");
			SendClientMessage(playerid, COLOR_WHITE, "(SKIN ID) |242|243|244|245|246|249|250|253|256|257|258|259|260|261|262|263|268|272|291|292|296|298|299|");
			SendClientMessage(playerid,COLOR_RED,"<|> Skin List <|>");
	    }
	    return 1;
	}
	if(strcmp(cmd, "/servicelist", true) == 0)
	{
 		if(IsPlayerConnected(playerid))
	    {
	    	SendClientMessage(playerid,COLOR_RED,"<|> Services List Number <|>");
			SendClientMessage(playerid, COLOR_WHITE, "(SERVICES) 911 - Los Santos Police Department  |  411 - Los Santos Transport Company | 123 - S.A.N. News");
			SendClientMessage(playerid,COLOR_RED,"<|> Services List Number <|>");
	    }
	    return 1;
	}
	if(strcmp(cmd, "/notehelp", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			SendClientMessage(playerid,COLOR_RED,"<|> Note Commands <|>");
			SendClientMessage(playerid, COLOR_WHITE, "(NOTES) /shownotes - /createnote - /deletenote - /givenote");
			SendClientMessage(playerid,COLOR_RED,"<|> Note Commands <|>");
		}
		return 1;
	}
	if(strcmp(cmd, "/newshelp", true) == 0)
	{
		if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pFaction] == 3)
			{
				SendClientMessage(playerid,COLOR_RED,"<|> News Reporter Commands <|>");
				SendClientMessage(playerid, COLOR_WHITE, "(NEWS REPORTER) /news - /live");
				SendClientMessage(playerid,COLOR_RED,"<|> News Reporter Commands <|>");
 			}
 			else
 			{
 	    		SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
 			}
			return 1;
		}
	}
	if(strcmp(cmd, "/ganghelp", true) == 0)
	{
		if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 2)
			{
				SendClientMessage(playerid,COLOR_RED,"<|> Gang Commands <|>");
				SendClientMessage(playerid, COLOR_WHITE, "(GANG) /steal");
				SendClientMessage(playerid,COLOR_RED,"<|> Gang Commands <|>");
 			}
 			else
 			{
 	    		SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
 			}
			return 1;
		}
	}
	if(strcmp(cmd, "/donatorcmds", true) == 0)
	{
		if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pDonator] >= 1)
			{
				SendClientMessage(playerid,COLOR_RED,"<|> Donator Commands <|>");
				SendClientMessage(playerid, COLOR_WHITE, "(DONATOR)");
		 		SendClientMessage(playerid,COLOR_RED,"<|> Donator Commands <|>");
			}
			else
			{
		    	SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not a donator");
			}
			return 1;
		}
	}
	if(strcmp(cmd, "/policehelp", true) == 0)
	{
		if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
	    		SendClientMessage(playerid,COLOR_RED,"<|> Police Commands <|>");
	    		SendClientMessage(playerid, COLOR_WHITE, "(LSPD) /policeduty");
				SendClientMessage(playerid, COLOR_WHITE, "(LSPD) (/f)action - /suspect - (/r)adio - (/m)egaphone - /arrest - /wanted - /cuff - /uncuff");
	 			SendClientMessage(playerid, COLOR_WHITE, "(LSPD) /tazer - /revoke - /ticket - (/gov)ernment - /backup (/bk) - /clearbackup (/bck) - /codes");
	 			SendClientMessage(playerid, COLOR_WHITE, "(LSPD) /frisk - /detain - /undetain - /roadblock (/rb) - /roadunblock (/rrb) - /cctv - /exitcctv - /giveweaponlicense");
				if(PlayerInfo[playerid][pFaction] == 6)
				{
					SendClientMessage(playerid, COLOR_WHITE, "(GOVERNMENT) /govduty");
					SendClientMessage(playerid, COLOR_WHITE, "(GOVERNMENT) /allowcitizen - /blockcitizen - /govarrest");
				}
	 			SendClientMessage(playerid,COLOR_RED,"<|> Police Commands <|>");
 			}
 			else
 			{
 	    		SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
 			}
			return 1;
		}
	}
	if(strcmp(cmd, "/jobhelp", true) == 0)
	{
		if(IsPlayerConnected(playerid))
	    {
	    	if(PlayerInfo[playerid][pJob] != 0)
	    	{
	   			if(PlayerInfo[playerid][pJob] == 1)
				{
					SendClientMessage(playerid, COLOR_WHITE, "(JOB) - [Arms Dealer] /materials - /sellweapon");
				}
				else if(PlayerInfo[playerid][pJob] == 2)
				{
					SendClientMessage(playerid, COLOR_WHITE, "(JOB) - [Drug Dealer] /drugs - /selldrugs");
				}
				else if(PlayerInfo[playerid][pJob] == 3)
				{
					SendClientMessage(playerid, COLOR_WHITE, "(JOB) - [Detective] /find");
				}
				else if(PlayerInfo[playerid][pJob] == 4)
				{
					SendClientMessage(playerid, COLOR_WHITE, "(JOB) - [Lawyer] /free");
				}
				else if(PlayerInfo[playerid][pJob] == 5)
				{
					SendClientMessage(playerid, COLOR_WHITE, "(JOB) - [Products Seller] /products");
				}
				else if(PlayerInfo[playerid][pJob] == 6)
				{
					SendClientMessage(playerid, COLOR_WHITE, "(JOB) - [Mechanic] /repair - /refill - /tow");
				}
	    	}
	    	else
	    	{
	    		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a job");
	    	}
			return 1;
		}
	}
	if(strcmp(cmd, "/laws", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
		    SendClientMessage(playerid,COLOR_RED,"<|> Laws <|>");
		    SendClientMessage(playerid, COLOR_WHITE, "(1) The dignity of the person is untouchable [Always Roleplay]");
		    SendClientMessage(playerid, COLOR_WHITE, "(2) Human Life is the most valuable thing to be protected [Do not Deathmatch]");
		    SendClientMessage(playerid, COLOR_WHITE, "(3) The one and only final law enforcing instance is the state itself [Obey all admins]");
		    SendClientMessage(playerid, COLOR_WHITE, "(4) San Andreas's prescribed national language is English [No flaming, No spamming. English in main chat]");
		    SendClientMessage(playerid, COLOR_WHITE, "(5) All mobile vehicles have to follow a right-side traffic logic [Drive on the right side of the road]");
		    SendClientMessage(playerid, COLOR_WHITE, "(6) All forms of supernatural forces will not be tolerated [No hacking]");
		    SendClientMessage(playerid, COLOR_WHITE, "(7) Theft of property, be it private or property of the state of San Andreas is highly prohibited");
			SendClientMessage(playerid,COLOR_RED,"<|> Laws <|>");
		}
		return 1;
	}
	if(strcmp(cmd, "/chathelp", true) == 0)
	{
		if(IsPlayerConnected(playerid))
	    {
	    	SendClientMessage(playerid,COLOR_RED,"<|> Chat Commands <|>");
	    	SendClientMessage(playerid, COLOR_WHITE, "(CHAT) /low - /local - /shout - /pm - /whisper - /me - /attempt - /ooc - /b - /do");
			SendClientMessage(playerid,COLOR_RED,"<|> Chat Commands <|>");
		}
		return 1;
	}
	if(strcmp(cmd, "/bankhelp", true) == 0)
	{
		if(IsPlayerConnected(playerid))
	    {
	    	SendClientMessage(playerid,COLOR_RED,"<|> Bank Commands <|>");
	    	SendClientMessage(playerid, COLOR_WHITE, "(BANK) /withdraw - /wiretransfer - /deposit - /balance");
			SendClientMessage(playerid,COLOR_RED,"<|> Bank Commands <|>");
		}
		return 1;
	}
	if(strcmp(cmd, "/factionhelp", true) == 0)
	{
		if(IsPlayerConnected(playerid))
	    {
	    	if(PlayerInfo[playerid][pFaction] != 255)
	    	{
    	 		SendClientMessage(playerid,COLOR_RED,"<|> Faction Commands <|>");
				SendClientMessage(playerid, COLOR_WHITE, "(FACTION) /f(action) - /fcheckmats - /fcheckdrugs - /factionmatsput - /factionmatstake - /factiondrugsput - /factiondrugstake");
				SendClientMessage(playerid, COLOR_WHITE, "(FACTION) /fwithdraw - /fdeposit - /fbalance - /f(action)list");
				SendClientMessage(playerid,COLOR_RED,"<|> Faction Commands <|>");
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			}
			return 1;
		}
	}
 	if(strcmp(cmd, "/leaderhelp", true) == 0)
	{
		if(IsPlayerConnected(playerid))
	    {
	    	if(PlayerInfo[playerid][pFaction] != 255 && PlayerInfo[playerid][pRank] == 1)
	    	{
  		 		SendClientMessage(playerid,COLOR_RED,"<|> Leader Commands <|>");
				SendClientMessage(playerid, COLOR_WHITE, "(LEADER) /invite - /uninvite - /setrank");
				if (PlayerInfo[playerid][pFaction] == 0 || PlayerInfo[playerid][pFaction] == 6)
				{
					SendClientMessage(playerid, COLOR_WHITE, "(LEADER) /roadunblockall (/allrrb)");
				}
				SendClientMessage(playerid,COLOR_RED,"<|> Leader Commands <|>");
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not a leader");
			}
			return 1;
		}
	}
	if(strcmp(cmd, "/phonehelp", true) == 0)
	{
		if(IsPlayerConnected(playerid))
	    {
			SendClientMessage(playerid,COLOR_RED,"<|> Phone Commands <|>");
			SendClientMessage(playerid, COLOR_WHITE, "(PHONE) /buyphone - /call - /answer - /hangup - /txt - /phonebook - /listnumber - /servicelist");
			SendClientMessage(playerid,COLOR_RED,"<|> Phone Commands <|>");
		}
		return 1;
	}
	if(strcmp(cmd, "/businesshelp", true) == 0)
	{
		if(IsPlayerConnected(playerid))
	    {
	    	SendClientMessage(playerid,COLOR_RED,"<|> Business Commands <|>");
			SendClientMessage(playerid, COLOR_WHITE, "(BUSINESS) /buybusiness - /sellbusiness - /businessinfo - /businessfee - /businessname - /openbusiness");
			SendClientMessage(playerid, COLOR_WHITE, "(BUSINESS) /businessdeposit - /businesswithdraw");
			SendClientMessage(playerid,COLOR_RED,"<|> Business Commands <|>");
		}
		return 1;
	}
	if(strcmp(cmd, "/acarhelp", true) == 0)
	{
	   	if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
		    	SendClientMessage(playerid,COLOR_RED,"<|> Admin Car Commands <|>");
				SendClientMessage(playerid, COLOR_WHITE, "(OWNER) /acarpark - /acarmodel - /acarcolor - /acarfaction - /acarenter - /acartype - /acarsetpos");
				SendClientMessage(playerid,COLOR_RED,"<|> Admin Car Commands <|>");
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
			return 1;
		}
	}
 	if(strcmp(cmd, "/ahousehelp", true) == 0)
	{
		if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
		    	SendClientMessage(playerid,COLOR_RED,"<|> Admin House Commands <|>");
				SendClientMessage(playerid, COLOR_WHITE, "(OWNER) /ahouseentrance - /ahouseexit - /ahousedescription - /agotohouse - /ahouseprice - /ahousesell - /ahouseint");
				SendClientMessage(playerid,COLOR_RED,"<|> Admin House Commands <|>");
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
			return 1;
		}
	}
	if(strcmp(cmd, "/apositionhelp", true) == 0)
	{
		if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
		    	SendClientMessage(playerid,COLOR_RED,"<|> Admin Position Commands <|>");
				SendClientMessage(playerid, COLOR_WHITE, "(MODERATOR) - [Teleports] /agotobuilding - /agotohouse - /agotobusiness - /agotofmatsstorage - /agotofdrugsstorage");
				SendClientMessage(playerid, COLOR_WHITE, "(MODERATOR) - [Teleports] /agotodrivingtestpos - /agotoflyingtestpos - /agotobank - /agotoweaponlicpos");
				SendClientMessage(playerid, COLOR_WHITE, "(MODERATOR) - [Teleports] /agotopolicedutypos - /agotogovdutypos - /agotopolicearrestpos - /agotogovarrestpos");
				if (PlayerInfo[playerid][pAdmin] >= 20)
				{
				SendClientMessage(playerid, COLOR_WHITE, "(OWNER) /adrivingtestpos - /aflyingtestpos - /abankpos - /aweaponlicensepos");
				SendClientMessage(playerid, COLOR_WHITE, "(OWNER) /apolicearrestpos - /agovarrestpos - /apolicedutypos - /agovdutypos");
				}
				SendClientMessage(playerid,COLOR_RED,"<|> Admin Position Commands <|>");
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
			return 1;
		}
	}
	//==========================================================================
	if(strcmp(cmd, "/adminduty", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			new faction = PlayerInfo[playerid][pFaction];
		    if(AdminDuty[playerid] == 1)
		    {
			    format(string, sizeof(string), "(ADMIN) %s (ID:%d) is now off duty", GetPlayerNameEx(playerid),playerid);
				SendClientMessageToAll(COLOR_ADMINDUTY,string);
				AdminDuty[playerid] = 0;
				SetPlayerHealth(playerid,100);
				SetPlayerArmour(playerid,0);

			    if(PlayerInfo[playerid][pFaction] != 255)
			    {
		    		if(DynamicFactions[faction][fUseColor])
		    		{
		    			SetPlayerToFactionColor(playerid);
		    		}
        			else
			     	{
			     	    SetPlayerColor(playerid,COLOR_CIVILIAN);
			     	}
		     	}
		     	else
		     	{
		     	    SetPlayerColor(playerid,COLOR_CIVILIAN);
		     	}
		    }
		    else
		    {
		    	format(string, sizeof(string), "(ADMIN) %s (ID:%d) is now an on duty administrator", GetPlayerNameEx(playerid),playerid);
				SendClientMessageToAll(COLOR_ADMINDUTY,string);
				AdminDuty[playerid] = 1;
				SetPlayerColor(playerid,COLOR_ADMINDUTY);
				SetPlayerHealth(playerid,999);
				SetPlayerArmour(playerid,999);
		    }
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
		}
		return 1;
	}
	if(strcmp(cmd, "/admin", true) == 0 || strcmp(cmd, "/a", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
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
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) (/a)dmin [message]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				format(string, sizeof(string), "(ADMIN CHAT) (%d) %s: %s", PlayerInfo[playerid][pAdmin], GetPlayerNameEx(playerid), result);
				AdministratorMessage(COLOR_ADMINCMD, string,1);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/getip", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			tmp = strtok(cmdtext, idx);
			new playersip[256];
			if(!strlen(tmp))
			{
  				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /getip [playerid/partofname]");
		        return 1;
			}
 			giveplayerid = ReturnUser(tmp);
 			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerIp(giveplayerid,playersip,sizeof(playersip));
 			format(string, sizeof(string), "(INFO) %s's IP: %s",giveplayer,playersip);
			SendClientMessage(playerid,COLOR_ADMINCMD,string);
		}
		return 1;
	}
	if(strcmp(cmd, "/unbanip", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 1)
		{
		    tmp = strtok(cmdtext, idx);
		    if(!strlen(tmp))
		    {
		        SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /unbanip [players ip]");
		        return 1;
   			}

			format(string,sizeof(string),"unbanip %s",tmp);
			SendRconCommand(string);
			SendRconCommand("reloadbans");
   			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, 256, "(INFO) %s has unbanned IP %s", sendername,tmp);
			AdministratorMessage(COLOR_ADMINCMD,string,1);
		}
		return 1;
	}
	if(strcmp(cmd, "/lockaccount", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /lockaccount [playerid/partofname] [reason]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						new length = strlen(cmdtext);
						while ((idx < length) && (cmdtext[idx] <= ' '))
						{
							idx++;
						}
						new offset = idx;
						new result[128];
						while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
						{
							result[idx - offset] = cmdtext[idx];
							idx++;
						}
						result[idx - offset] = EOS;
						if(!strlen(result))
						{
							SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /lockaccount [playerid/partofname] [reason]");
							return 1;
						}
						LockPlayerAccount(giveplayerid,GetPlayerNameEx(playerid),(result));
						return 1;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
			}
		}
		return 1;
	}
    if(strcmp(cmd, "/ban", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /ban [playerid/partofname] [reason]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						new length = strlen(cmdtext);
						while ((idx < length) && (cmdtext[idx] <= ' '))
						{
							idx++;
						}
						new offset = idx;
						new result[128];
						while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
						{
							result[idx - offset] = cmdtext[idx];
							idx++;
						}
						result[idx - offset] = EOS;
						if(!strlen(result))
						{
							SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /ban [playerid/partofname] [reason]");
							return 1;
						}
						BanPlayer(giveplayerid,GetPlayerNameEx(playerid),(result));
						return 1;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/listenchat", true) == 0 && PlayerInfo[playerid][pAdmin] >= 1)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (!BigEar[playerid])
			{
				BigEar[playerid] = 1;
			}
			else if (BigEar[playerid])
			{
				(BigEar[playerid] = 0);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/oocstatus", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
			    if(OOCStatus)
			    {
			        OOCStatus = 0;
			        format(string, sizeof(string), "(GLOBAL OOC) Disabled by %s", GetPlayerNameEx(playerid));
					SendClientMessageToAll(COLOR_NEWOOC, string);
				}
				else
				{
					OOCStatus = 1;
					format(string, sizeof(string), "(GLOBAL OOC) Enabled by %s", GetPlayerNameEx(playerid));
					SendClientMessageToAll(COLOR_NEWOOC, string);
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/mute", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /mute [playerid/partofname]");
				return 1;
			}
			new playa;
			playa = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						if(Muted[playa] == 0)
						{
							Muted[playa] = 1;
							format(string, sizeof(string), "(INFO) You muted %s",GetPlayerNameEx(playa));
							SendClientMessage(playerid,COLOR_ADMINCMD,string);
							format(string, sizeof(string), "(INFO) You have been muted by %s",GetPlayerNameEx(playerid));
							SendClientMessage(playa,COLOR_WHITE,string);
						}
						else
						{
							Muted[playa] = 0;
							format(string, sizeof(string), "(INFO) You unmuted %s",GetPlayerNameEx(playa));
							SendClientMessage(playerid,COLOR_ADMINCMD,string);
							format(string, sizeof(string), "(INFO) You have been unmuted by %s",GetPlayerNameEx(playerid));
							SendClientMessage(playa,COLOR_WHITE,string);
						}
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/warn", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /warn [playerid/partofname] [reason]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
			    if(IsPlayerConnected(giveplayerid))
			    {
			        if(giveplayerid != INVALID_PLAYER_ID)
			        {
						new length = strlen(cmdtext);
						while ((idx < length) && (cmdtext[idx] <= ' '))
						{
							idx++;
						}
						new offset = idx;
						new result[128];
						while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
						{
							result[idx - offset] = cmdtext[idx];
							idx++;
						}
						result[idx - offset] = EOS;
						if(!strlen(result))
						{
							SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /warn [playerid/partofname] [reason]");
							return 1;
						}
						PlayerInfo[giveplayerid][pWarnings] += 1;
						if(PlayerInfo[giveplayerid][pWarnings] >= 5)
						{
							format(string, sizeof(string), "(INFO) %s has been banned, had 5+ warnings", GetPlayerNameEx(giveplayerid));
							BanLog(string);
							LockPlayerAccount(giveplayerid,GetPlayerNameEx(playerid),(result));
							return 1;
						}
						format(string, sizeof(string), "(INFO) You warned %s - Reason: %s", GetPlayerNameEx(giveplayerid), (result));
						SendClientMessage(playerid, COLOR_ADMINCMD, string);
						format(string, sizeof(string), "(INFO) You have been warned by %s - Reason: %s", GetPlayerNameEx(playerid), (result));
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						return 1;
					}
				}//not connected
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/goto", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /goto [playerid/partofname]");
				return 1;
			}
			new Float:plocx,Float:plocy,Float:plocz;
			new plo;
			plo = ReturnUser(tmp);
			if (IsPlayerConnected(plo))
			{
			    if(plo != INVALID_PLAYER_ID)
			    {
					if (PlayerInfo[playerid][pAdmin] >= 1)
					{
						GetPlayerPos(plo, plocx, plocy, plocz);
						new interior = GetPlayerInterior(plo);
						new world = GetPlayerVirtualWorld(plo);

						if (GetPlayerState(playerid) == 2)
						{
							new tmpcar = GetPlayerVehicleID(playerid);
							SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
							SetPlayerVirtualWorld(playerid,world);
							SetPlayerInterior(playerid,interior);
						}
						else
						{
							SetPlayerPos(playerid,plocx,plocy+2, plocz);
							SetPlayerVirtualWorld(playerid,world);
							SetPlayerInterior(playerid,interior);
						}
						format(string, sizeof(string), "(INFO) You teleported to %s", GetPlayerNameEx(plo));
						SendClientMessage(playerid, COLOR_WHITE, string);
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/gotols", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pAdmin] >= 1)
			{
				if (GetPlayerState(playerid) == 2)
				{
					new tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, 1529.6,-1691.2,13.3);
				}
				else
				{
					SetPlayerPos(playerid, 1529.6,-1691.2,13.3);
				}
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/gotolv", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				if (GetPlayerState(playerid) == 2)
				{
					new tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, 1699.2, 1435.1, 10.7);
				}
				else
				{
					SetPlayerPos(playerid, 1699.2,1435.1, 10.7);
				}
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/gotosf", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				if (GetPlayerState(playerid) == 2)
				{
					new tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, -1417.0,-295.8,14.1);
				}
				else
				{
					SetPlayerPos(playerid, -1417.0,-295.8,14.1);
				}
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
  	if(strcmp(cmd, "/gethere", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /gethere [playerid/partofname]");
				return 1;
			}
			new Float:plocx,Float:plocy,Float:plocz;
			new plo;
			plo = ReturnUser(tmp);
			if (IsPlayerConnected(plo))
			{
			    if(plo != INVALID_PLAYER_ID)
			    {
					if (PlayerInfo[playerid][pAdmin] >= 1)
					{
						GetPlayerPos(playerid, plocx, plocy, plocz);
						new interior = GetPlayerInterior(playerid);
						new world = GetPlayerVirtualWorld(playerid);

						if (GetPlayerState(playerid) == 2)
						{
							new tmpcar = GetPlayerVehicleID(plo);
							SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
							SetPlayerVirtualWorld(plo,world);
							SetPlayerInterior(plo,interior);
						}
						else
						{
							SetPlayerPos(plo,plocx,plocy+2, plocz);
							SetPlayerVirtualWorld(plo,world);
							SetPlayerInterior(plo,interior);
						}
						format(string, sizeof(string), "(INFO) You teleported %s to you", GetPlayerNameEx(plo));
						SendClientMessage(playerid, COLOR_WHITE, string);
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
					}
				}
			}
			else
			{
				format(string, sizeof(string), "(ERROR) %d is not connected", plo);
				SendClientMessage(playerid, COLOR_GREY, string);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/setvw", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /setvw [playerid/partofname] [virworldid]");
				return 1;
			}
			new playa;
			playa = ReturnUser(tmp);
			new virid;
			tmp = strtok(cmdtext, idx);
			virid = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
			    		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						SetPlayerVirtualWorld(playa, virid);
						format(string, sizeof(string), "(INFO) You have set %s virtual world to %d", giveplayer, virid);
						SendClientMessage(playerid, COLOR_ADMINCMD, string);
						format(string, sizeof(string), "(INFO) %s have set your virtual world to %d", sendername, virid);
						SendClientMessage(playa, COLOR_WHITE, string);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/freeze", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /freeze [playerid/partofname]");
				return 1;
			}
			new playa;
			playa = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						TogglePlayerControllable(playa, 0);
						format(string, sizeof(string), "(INFO) You have been froze by %s",GetPlayerNameEx(playerid));
						SendClientMessage(playa,COLOR_WHITE,string);
						format(string, sizeof(string), "(INFO) You froze %s",GetPlayerNameEx(playa));
						SendClientMessage(playerid,COLOR_ADMINCMD,string);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/unfreeze", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /unfreeze [playerid/partofname]");
				return 1;
			}
			new playa;
			playa = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						TogglePlayerControllable(playa, 1);
						format(string, sizeof(string), "(INFO) You have been unfroze by %s",GetPlayerNameEx(playerid));
						SendClientMessage(playa,COLOR_WHITE,string);
						format(string, sizeof(string), "(INFO) You unfroze %s",GetPlayerNameEx(playa));
						SendClientMessage(playerid,COLOR_ADMINCMD,string);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/skydive", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
			    new Float:rx, Float:ry, Float:rz;
				GetPlayerPos(playerid, rx, ry, rz);
				if (IsPlayerConnected(playerid))
				{
					SafeGivePlayerWeapon(playerid, 46, 0);
					SetPlayerPos(playerid,rx, ry, rz+1500);
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/fourdive", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /fourdive [playerid1] [playerid2] [playerid3] [playerid4]");
				return 1;
			}
			new para1;
			new para2;
			new para3;
			new para4;
			para1 = strval(tmp);
			tmp = strtok(cmdtext, idx);
			para2 = strval(tmp);
			tmp = strtok(cmdtext, idx);
			para3 = strval(tmp);
			tmp = strtok(cmdtext, idx);
			para4 = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 2)
			{
				if (IsPlayerConnected(para1)){ SafeGivePlayerWeapon(para1, 46, 0); SetPlayerPos(para1,1536.0, -1360.0, 1350.0);SetPlayerInterior(para1,0);SendClientMessage(para1, COLOR_WHITE, "GO!! GO!! GO!!");}
				if ((IsPlayerConnected(para2)) && (para2>0)) { SafeGivePlayerWeapon(para2, 46, 0); SetPlayerPos(para2,1536.0, -1345.0, 1350.0);SetPlayerInterior(para2,0);SendClientMessage(para2, COLOR_RED, "GO!! GO!! GO!!");}
				if ((IsPlayerConnected(para3)) && (para3>0)) { SafeGivePlayerWeapon(para3, 46, 0); SetPlayerPos(para3,1552.0, -1345.0, 1350.0);SetPlayerInterior(para3,0);SendClientMessage(para3, COLOR_RED, "GO!! GO!! GO!!");}
				if ((IsPlayerConnected(para4)) && (para4>0)) { SafeGivePlayerWeapon(para4, 46, 0); SetPlayerPos(para4,1552.0, -1360.0, 1350.0);SetPlayerInterior(para4,0);SendClientMessage(para4, COLOR_RED, "GO!! GO!! GO!!");}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/fixcar", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        new tmpcar = GetPlayerVehicleID(playerid);
	        if(PlayerInfo[playerid][pAdmin] < 1)
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			    return 1;
			}
			if(IsPlayerInAnyVehicle(playerid))
			{
   				RepairVehicle(tmpcar);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/destroycar", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pAdmin] < 1)
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			    return 1;
			}
			if(IsPlayerInAnyVehicle(playerid))
			{
   				SetVehicleHealth(GetPlayerVehicleID(playerid), 0);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/kick", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /kick [playerid/partofname] [reason]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						new length = strlen(cmdtext);
						while ((idx < length) && (cmdtext[idx] <= ' '))
						{
							idx++;
						}
						new offset = idx;
						new result[128];
						while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
						{
							result[idx - offset] = cmdtext[idx];
							idx++;
						}
						result[idx - offset] = EOS;
						if(!strlen(result))
						{
							SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /kick [playerid/partofname] [reason]");
							return 1;
						}
						KickPlayer(giveplayerid,GetPlayerNameEx(playerid),(result));
						return 1;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/learn", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /learn [playerid/partofname]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
					    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						new year, month,day;
						getdate(year, month, day);
						format(string, sizeof(string), "%s was learned by %s (%d-%d-%d)", sendername,giveplayer,month,day,year);
      					KickLog(string);
      					PlayerInfo[giveplayerid][pTut] = 0;
						format(string, sizeof(string), "(INFO) You have been deported from the state. You will need to retake the tutorial");
						SendClientMessage(giveplayerid,COLOR_WHITE,string);
						Kick(giveplayerid);
					    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, sizeof(string), "%s has kicked %s and forced them to retake the tutorial", sendername,giveplayer);
						SendClientMessageToAll(COLOR_ADMINCMD, string);
						return 1;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not connected");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/serverinfo", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			new form[128];
			SendClientMessage(playerid,COLOR_RED,"<|> Server Statistics <|>");
			format(form, sizeof form, "(INFO) Total Static Objects: %d", GetObjectCount());
			SendClientMessage(playerid, COLOR_WHITE,form);
			format(form, sizeof form, "(INFO) Total Dynamic Vehicles: %d", GetVehicleCount());
			SendClientMessage(playerid, COLOR_WHITE,form);
			format(form, sizeof form, "(INFO) Total Stream Pickups: %d", CountStreamPickups());
			SendClientMessage(playerid, COLOR_WHITE,form);
			SendClientMessage(playerid,COLOR_RED,"<|> Server Statistics <|>");
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
		}
		return 1;
	}
	if(strcmp(cmd, "/check", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /check [playerid/partofname]");
					return 1;
				}
	            giveplayerid = ReturnUser(tmp);
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						ShowStats(playerid,giveplayerid);
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/ajail", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /ajail [playerid/partofname] [minutes]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						format(string, sizeof(string), "(INFO) You jailed %s", GetPlayerNameEx(playa));
						SendClientMessage(playerid, COLOR_ADMINCMD, string);
						format(string, sizeof(string), "(INFO) You have been jailed by %s for %d minutes", GetPlayerNameEx(playerid),money);
						SendClientMessage(playa, COLOR_WHITE, string);
						SetPlayerVirtualWorld(playa,2);
						SetPlayerInterior(playa,6);
						SetPlayerPos(playa, 264.5743,77.5118,1001.0391);
						SafeResetPlayerWeapons(playa);
						WantedPoints[playa] = 0;
						ResetPlayerWantedLevelEx(playa);
						PlayerInfo[playa][pJailed] = 1;
						PlayerInfo[playa][pJailTime] = money*60;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/agovjail", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /agovjail [playerid/partofname] [minutes]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						format(string, sizeof(string), "(INFO) You jailed %s", GetPlayerNameEx(playa));
						SendClientMessage(playerid, COLOR_ADMINCMD, string);
						format(string, sizeof(string), "(INFO) You have been jailed by %s for %d minutes", GetPlayerNameEx(playerid),money);
						SendClientMessage(playa, COLOR_WHITE, string);
						SetPlayerVirtualWorld(playa,0);
						SetPlayerInterior(playa,0);
						SetPlayerPos(playa, 3312.4163,-1935.4459,10.9682);
						SafeResetPlayerWeapons(playa);
						WantedPoints[playa] = 0;
						ResetPlayerWantedLevelEx(playa);
						PlayerInfo[playa][pJailed] = 2;
						PlayerInfo[playa][pJailTime] = money*60;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/aunjail", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pAdmin] < 1)
	        {
	            SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	            return 1;
	        }
	        tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /aunjail [playerid/partofname]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			    	if(PlayerInfo[giveplayerid][pJailed] == 1)
			    	{
			        	GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, sizeof(string), "(INFO) You set %s free", giveplayer);
						SendClientMessage(playerid, COLOR_ADMINCMD, string);
						format(string, sizeof(string), "(INFO) You have been set free by %s", sendername);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						SetPlayerVirtualWorld(giveplayerid,2);
						SetPlayerInterior(giveplayerid,6);
						SetPlayerPos(giveplayerid, 268.0903,77.6489,1001.0391);
						PlayerInfo[giveplayerid][pJailTime] = 0;
						PlayerInfo[giveplayerid][pJailed] = 0;
					}
				}
			}
	    }
	    return 1;
	}
	if(strcmp(cmd, "/agovunjail", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pAdmin] < 1)
	        {
	            SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	            return 1;
	        }
	        tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /agovunjail [playerid/partofname]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			        if(PlayerInfo[giveplayerid][pJailed] == 2)
			        {
			        	GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, sizeof(string), "(INFO) You set %s free", giveplayer);
						SendClientMessage(playerid, COLOR_ADMINCMD, string);
						format(string, sizeof(string), "(INFO) You have been set free by %s", sendername);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						SetPlayerVirtualWorld(giveplayerid,0);
						SetPlayerInterior(giveplayerid,0);
						SetPlayerPos(giveplayerid, 3043.7874,-1964.9265,10.9638);
						PlayerInfo[giveplayerid][pJailTime] = 0;
						PlayerInfo[giveplayerid][pJailed] = 0;
					}
				}
			}
	    }
	    return 1;
	}
	//==========================================================================
 	if(strcmp(cmd, "/broadcast", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
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
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /broadcast [textformat ~n~=Newline ~r~=Red ~g~=Green ~b~=Blue ~w~=White ~y~=Yellow]");
					return 1;
				}
				format(string, sizeof(string), "~b~%s: ~w~%s",GetPlayerNameEx(playerid),result);
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
						GameTextForPlayer(i, string, 5000, 6);
					}
				}
				return 1;
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
				return 1;
			}
		}
		return 1;
	}
 	if (strcmp(cmd, "/logoutall", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
						OnPlayerDataSave(i);
						gPlayerLogged[i] = 0;
					}
				}
				SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) All players logged out");
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/asetmoney", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /asetmoney [playerid/partofname] [money]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						SetPlayerCash(playa, money);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/agiveproducts", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /agiveproducts [playerid/partofname] [products]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						PlayerInfo[playa][pProducts] += money;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/asetproducts", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /asetproducts [playerid/partofname] [products]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						PlayerInfo[playerid][pProducts] = money;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/agivemats", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /agivemats [playerid/partofname] [mats]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						PlayerInfo[playa][pMaterials] += money;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/asetmats", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /asetmats [playerid/partofname] [mats]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						PlayerInfo[playa][pMaterials] = money;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/asetdrugs", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /asetdrugs [playerid/partofname] [drugs]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						PlayerInfo[playa][pDrugs] = money;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/agivedrugs", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /agivedrugs [playerid/partofname] [drugs]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						PlayerInfo[playa][pDrugs] += money;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/agivemoney", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /agivemoney [playerid/partofname] [money]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						GivePlayerCash(playa, money);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/asethp", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /asethp [playerid/partofname] [health]");
				return 1;
			}
			new playa;
			new health;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			health = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						SetPlayerHealth(playa, health);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/asetarmour", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /asetarmour [playerid/partofname] [armour]");
				return 1;
			}
			new playa;
			new health;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			health = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						SetPlayerArmour(playa, health);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/agivegun", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /agivegun [playerid/partofname] [weaponid] [ammo]");
				return 1;
			}
			new playa;
			new gun;
			new ammo;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			gun = strval(tmp);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /agivegun [playerid/partofname] [weaponid] [ammo]");
				SendClientMessage(playerid, COLOR_WHITE, "3(Club) | 4(knife) | 5(bat) | 6(Shovel) | 7(Cue) | 8(Katana) | 10-13(Dildo) | 14(Flowers)");
				SendClientMessage(playerid, COLOR_WHITE, "16(Grenades) | 18(Molotovs) | 22(Pistol) | 23(SPistol) 24(Eagle) | 25(Shotgun) | 27(SPAS12)");
				SendClientMessage(playerid, COLOR_WHITE, "29(MP5) | 30(AK47) | 31(M4) | 33(Rifle) | 34(Sniper) | 35(Bazooka) | 37(Flamethrower)");
				SendClientMessage(playerid, COLOR_WHITE, "41(Spray) | 42(Fire Extinguisher) | 43(Camera) | 46(Parachute)");
				return 1;
			}
			if(gun > 1 || gun < 47)
			{
			tmp = strtok(cmdtext, idx);
			ammo = strval(tmp);
			if(ammo <1 || ammo > 999)
			{ SendClientMessage(playerid, COLOR_GREY, "(ERROR) Ammo must be , 1-999"); return 1; }
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						SafeGivePlayerWeapon(playa, gun, ammo);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		}
		return 1;
	}
	if(strcmp(cmd, "/agivelicense", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if (PlayerInfo[playerid][pAdmin] >= 10)
	        {
	            new x_nr[256];
				x_nr = strtok(cmdtext, idx);
				if(!strlen(x_nr)) {
				    SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /agivelicense [item] [playerid/partofname]");
				    SendClientMessage(playerid, COLOR_WHITE, "(ITEM) driverslicense | flyinglicense | weaponlicense");
					return 1;
				}
			    if(strcmp(x_nr, "driverslicense", true) == 0)
				{
		            tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
					    SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /agivelicense driverslicense [playerid/partofname]");
					    return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        GetPlayerName(playerid, sendername, sizeof(sendername));
					        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				            format(string, sizeof(string), "(INFO) You have given a drivers license to %s",giveplayer);
					        SendClientMessage(playerid, COLOR_ADMINCMD, string);
					        format(string, sizeof(string), "(INFO) %s has given you a drivers license",sendername);
					        SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        PlayerInfo[giveplayerid][pCarLic] = 1;
					        return 1;
				        }
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not connected");
					    return 1;
					}
				}
				else if(strcmp(x_nr, "flyinglicense", true) == 0)
				{
		            tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
					    SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /agivelicense flyinglicense [playerid/partofname]");
					    return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        GetPlayerName(playerid, sendername, sizeof(sendername));
					        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				            format(string, sizeof(string), "(INFO) You have given a flying license to %s",giveplayer);
					        SendClientMessage(playerid, COLOR_ADMINCMD, string);
					        format(string, sizeof(string), "(INFO) %s gave you a flying license",sendername);
					        SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        PlayerInfo[giveplayerid][pFlyLic] = 1;
					        return 1;
						}
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not connected");
					    return 1;
					}
				}
				else if(strcmp(x_nr, "weaponlicense", true) == 0)
				{
		            tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
					    SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /agivelicense weaponlicense [playerid/partofname]");
					    return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        GetPlayerName(playerid, sendername, sizeof(sendername));
					        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				            format(string, sizeof(string), "(INFO) You have given a weapon license to %s",giveplayer);
					        SendClientMessage(playerid, COLOR_ADMINCMD, string);
					        format(string, sizeof(string), "(INFO) %s gave you a weapon license",sendername);
					        SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        PlayerInfo[giveplayerid][pWepLic] = 1;
					        return 1;
						}
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not connected");
					    return 1;
					}
				}
	        }
	        else
	        {
	            SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorised to use that command");
	            return 1;
	        }
	    }
	    return 1;
 	}
	if(strcmp(cmd, "/fuelcars", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pAdmin] >= 10)
	        {
	            for(new c=0;c<MAX_VEHICLES;c++)
				{
					Fuel[c] = GasMax;
				}
				SendClientMessageToAll(COLOR_ADMINCMD, "(INFO) All cars refueled by an administrator");
	        }
	        else
	        {
	            SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	            return 1;
	        }
	    }
	    return 1;
	}
 	if(strcmp(cmd, "/unlockcars", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pAdmin] >= 10)
	        {
	            for(new c=0;c<MAX_VEHICLES;c++)
				{
					VehicleLocked[c] = 0;
				}
				for(new i=0;i<MAX_PLAYERS;i++)
				{
				    if(IsPlayerConnected(i))
				    {
						VehicleLockedPlayer[i] = 999;
					}
				}
				SendClientMessageToAll(COLOR_ADMINCMD, "(INFO) All cars unlocked by an administrator");
	        }
	        else
	        {
	            SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	            return 1;
	        }
	    }
	    return 1;
	}
	if(strcmp(cmd, "/adonator", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /adonator [playerid/partofname]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
			    if(IsPlayerConnected(id))
			    {
				    if(id != INVALID_PLAYER_ID)
				    {
						if(PlayerInfo[id][pDonator] == 1)
						{
							format(string, sizeof(string), "(INFO) Your donator status has been revoked by %s", GetPlayerNameEx(playerid));
							SendClientMessage(id, COLOR_WHITE, string);
							DonatorLog(string);
							format(string, sizeof(string), "(INFO) You have removed %s's donator status", GetPlayerNameEx(id));
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							PlayerInfo[id][pDonator] = 0;
						}
						else
						{
							format(string, sizeof(string), "(INFO) You have been made a donator by %s", GetPlayerNameEx(playerid));
							SendClientMessage(id, COLOR_WHITE, string);
							DonatorLog(string);
							format(string, sizeof(string), "(INFO) You have made %s a donator", GetPlayerNameEx(id));
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							PlayerInfo[id][pDonator] = 1;
						}
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/alistfaction", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /alistfaction [id]");
				return 1;
			}
			new text = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
			 	new wstring[128];
			    format(wstring, sizeof(wstring), "[ID:%d] Faction Name: %s - Materials: %d - Drugs: %d - Money: $%d - Join Rank: %d - Use Skins: %d - Type: %d",text, DynamicFactions[text][fName],DynamicFactions[text][fMaterials],DynamicFactions[text][fDrugs],DynamicFactions[text][fBank],DynamicFactions[text][fJoinRank],DynamicFactions[text][fUseSkins],DynamicFactions[text][fType]);
			    SendClientMessage(playerid,COLOR_ADMINCMD, wstring);
			    format(wstring, sizeof(wstring), "[ID:%d] Skins: %d|%d|%d|%d|%d|%d|%d|%d|%d|%d - Rank Amount: %d - Use Color: %d", text,DynamicFactions[text][fSkin1],DynamicFactions[text][fSkin2],DynamicFactions[text][fSkin3],DynamicFactions[text][fSkin4],DynamicFactions[text][fSkin5],DynamicFactions[text][fSkin6],DynamicFactions[text][fSkin7],DynamicFactions[text][fSkin8],DynamicFactions[text][fSkin9],DynamicFactions[text][fSkin10],DynamicFactions[text][fRankAmount],DynamicFactions[text][fUseColor]);
			    SendClientMessage(playerid,COLOR_ADMINCMD, wstring);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/startlotto", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pAdmin] >= 10)
	        {
	            format(string, sizeof(string), "(LOTTERY NEWS) The Lottery Election has started");
	            OOCNews(COLOR_RED, string);
	            new rand = random(80);
	            if(rand < 77) { rand += 3; }
	            Lotto(rand);
	        }
	        else
	        {
	            SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	            return 1;
	        }
	    }
		return 1;
	}
	if(strcmp(cmd, "/update", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 10)
		{
			SaveAccounts();
			SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) All player accounts updated successfully");
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
		}
		return 1;
	}
	//==========================================================================
	if(strcmp(cmd, "/gmx", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				GameModeRestart();
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/asetleader", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /asetleader [playerid/partofname] [FactionID]");
				return 1;
			}
			new para1;
			new level;
			para1 = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			level = strval(tmp);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /asetleader [playerid/partofname] [FactionID]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
			    if(IsPlayerConnected(para1))
			    {
			        if(para1 != INVALID_PLAYER_ID)
			        {
						PlayerInfo[para1][pFaction] = level;
						PlayerInfo[para1][pRank] = 1;
						SetPlayerSpawn(para1);

						format(string, sizeof(string), "(INFO) You have made %s leader of faction ID: %d (%s)", GetPlayerNameEx(para1),level,DynamicFactions[level][fName]);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);

						format(string, sizeof(string), "(INFO) You have been made leader of %s by %s", DynamicFactions[level][fName],GetPlayerNameEx(playerid));
						SendClientMessage(para1, COLOR_LIGHTBLUE, string);

						if(DynamicFactions[level][fUseSkins] == 1)
						{
							SetPlayerSkin(para1,DynamicFactions[level][fSkin1]);
						}
					}
				}//not connected
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/setadmin", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /setadmin [playerid/partofname] [adminlevel]");
				return 1;
			}
			new para1;
			new level;
			para1 = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			level = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
			    if(IsPlayerConnected(para1))
			    {
			        if(para1 != INVALID_PLAYER_ID)
			        {
						PlayerInfo[para1][pAdmin] = level;
						format(string, sizeof(string), "(INFO) %s made you an administrator - Level: %d", GetPlayerNameEx(playerid),level);
						SendClientMessage(para1, COLOR_WHITE, string);
						format(string, sizeof(string), "(INFO) You have made %s an administrator - Level: %d", GetPlayerNameEx(para1),level);
						SendClientMessage(playerid, COLOR_ADMINCMD, string);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/afactionkick", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionkick [playerid/partofname] [reason]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						new length = strlen(cmdtext);
						while ((idx < length) && (cmdtext[idx] <= ' '))
						{
							idx++;
						}
						new offset = idx;
						new result[128];
						while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
						{
							result[idx - offset] = cmdtext[idx];
							idx++;
						}
						result[idx - offset] = EOS;
						if(!strlen(result))
						{
							SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionkick [playerid/partofname] [reason]");
							return 1;
						}
						new form[128];
						format(form,sizeof(form),"(INFO) %s has been faction-kicked by %s - Reason: %s ",GetPlayerNameEx(giveplayerid),GetPlayerNameEx(playerid),(result));
						SendClientMessageToAll(COLOR_ADMINCMD,form);
						PlayerInfo[giveplayerid][pFaction] = 255;
						SetPlayerSpawn(giveplayerid);
						return 1;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
			}
		}
		return 1;
	}
	//==========================================================================
	if(strcmp(cmd, "/acarsetpos", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /acarsetpos [carid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
			    if(id != INVALID_VEHICLE_ID)
			    {
					new Float:x,Float:y,Float:z;
					new Float:a;
					GetPlayerPos(playerid, x, y, z);
					if(IsPlayerInAnyVehicle(playerid))
					{
						GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
					}
					else
					{
					    GetPlayerFacingAngle(playerid, a);
					}
					DynamicCars[id-1][CarX] = x;
					DynamicCars[id-1][CarY] = y;
					DynamicCars[id-1][CarZ] = z;
					DynamicCars[id-1][CarAngle] = a;
					DestroyVehicle(id);
					CreateVehicle(DynamicCars[id-1][CarModel],DynamicCars[id-1][CarX],DynamicCars[id-1][CarY],DynamicCars[id-1][CarZ],DynamicCars[id-1][CarAngle],DynamicCars[id-1][CarColor1],DynamicCars[id-1][CarColor2], -1);
					SaveDynamicCars();
				 	new wstring[128];
				    format(wstring, sizeof(wstring), "(INFO) You have set Vehicle ID: %d's position", id);
				    SendClientMessage(playerid,COLOR_ADMINCMD, wstring);
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid vehicle ID");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/respawnvehicles", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 10)
		{
			for(new i=0;i<MAX_VEHICLES;i++)
			{
			    if(IsVehicleOccupied(i) == 0)
			    {
			        SetVehicleToRespawn(i);
           			EngineStatus[i] = 0;
  					Fuel[i] = GasMax;
  					VehicleLocked[i] = 0;
    				CarWindowStatus[i] = 1;
			    }
			}
			format(string, sizeof(string), "(INFO) Vehicles respawned by %s", GetPlayerNameEx(playerid));
   			SendClientMessageToAll(COLOR_ADMINCMD, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
		}
		return 1;
	}
	if(strcmp(cmd, "/carid", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
     		if(PlayerInfo[playerid][pAdmin] >= 10)
	        {
	        	if(IsPlayerInAnyVehicle(playerid))
	        	{
        	 		format(string, sizeof(string), "(INFO) Vehicle ID: %d", GetPlayerVehicleID(playerid));
	            	SendClientMessage(playerid, COLOR_ADMINCMD, string);
	            	return 1;
				}
	        }
	    }
	    return 1;
	}
	if(strcmp(cmd, "/searchcar", true) == 0)
	{
  		if(PlayerInfo[playerid][pAdmin] < 10)
		{
  			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
  			return 1;
		}
		new index;
	    cmd = strtok(cmdtext, index);
	    new results, strings[128];
		tmp = strtok(cmdtext, index);
		if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /searchcar [part of name]");
		format(strings, sizeof(strings), "Searching for vehicles containing \"%s\"....", tmp);
		SendClientMessage(playerid, COLOR_RED, "=================================================");
		SendClientMessage(playerid, COLOR_WHITE, strings);
		for(new q; q<212; q++)
		{
			if(strfind(VehicleNames[q], tmp, true) != -1)
			{
			    if(results == 0)
			    {
                    format(strings, sizeof(strings), "%s", VehicleNames[q]);
				}
				else
				{
				    format(strings, sizeof(strings), "%s, %s", strings, VehicleNames[q]);
				}
			    results++;
   				if(strlen(strings) > 118)
	   			{
				   SendClientMessage(playerid, COLOR_GREY, "Too many results found, please narrow search ");
				   SendClientMessage(playerid, COLOR_RED, "=================================================");
				   return 1;
				}
			}
		}
		if(results == 0)
		{
		    SendClientMessage(playerid, COLOR_GREY, "No vehicles found");
		    SendClientMessage(playerid, COLOR_RED, "=================================================");
		    return 1;
		}
		SendClientMessage(playerid, COLOR_WHITE, "Results:");
		SendClientMessage(playerid, COLOR_WHITE, strings);
		SendClientMessage(playerid, COLOR_RED, "=================================================");
		return 1;
	}
	if(strcmp(cmd, "/getcar", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /getcar [carid]");
				return 1;
			}
			new Float:plocx,Float:plocy,Float:plocz;
			new plo;
			plo = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				GetPlayerPos(playerid, plocx, plocy, plocz);
				SetVehiclePos(plo,plocx,plocy+4, plocz);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/acarenter", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /acarenter [carid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
			    if(id != INVALID_VEHICLE_ID)
			    {
					PutPlayerInVehicle(playerid,id,0);
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid vehicle ID");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/acarpark", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
			    if(IsPlayerInAnyVehicle(playerid))
			    {
				    new vehicleid = GetPlayerVehicleID(playerid);
				    new car = GetPlayerVehicleID(playerid) - 1;
					new Float:x,Float:y,Float:z;
					new Float:a;
					GetVehiclePos(vehicleid, x, y, z);
					GetVehicleZAngle(vehicleid, a);
					DynamicCars[car][CarX] = x;
					DynamicCars[car][CarY] = y;
					DynamicCars[car][CarZ] = z;
					DynamicCars[car][CarAngle] = a;
					DestroyVehicle(vehicleid);
					CreateVehicle(DynamicCars[car][CarModel],DynamicCars[car][CarX],DynamicCars[car][CarY],DynamicCars[car][CarZ],DynamicCars[car][CarAngle],DynamicCars[car][CarColor1],DynamicCars[car][CarColor2], -1);
					PutPlayerInVehicle(playerid,vehicleid,0);
					SaveDynamicCars();
				 	new wstring[128];
				    format(wstring, sizeof(wstring), "(INFO) You have parked Vehicle ID: %d", vehicleid);
				    SendClientMessage(playerid,COLOR_ADMINCMD, wstring);
	    		}
    			else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in a vehicle");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/acarfaction", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /acarfaction [faction]");
				return 1;
			}
			new thecar = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
 					if(thecar < 11 || 255)
 					{
						new car = GetPlayerVehicleID(playerid) - 1;
						new vehicleid = GetPlayerVehicleID(playerid);
						DynamicCars[car][FactionCar] = thecar;
			 			new wstring[128];
					    format(wstring, sizeof(wstring), "(INFO) You have set Vehicle ID %d's faction to: %d", vehicleid,thecar);
					    SendClientMessage(playerid,COLOR_ADMINCMD, wstring);
					    SaveDynamicCars();
				    }
		   			else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) Incorrect Faction ID, Correct Faction ID's: 1-10");
					}
				}
 				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in a vehicle");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/acartype", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /acartype [type]");
				return 1;
			}
			new thecar = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
					new car = GetPlayerVehicleID(playerid) - 1;
					new vehicleid = GetPlayerVehicleID(playerid);
					DynamicCars[car][CarType] = thecar;
		 			new wstring[128];
				    format(wstring, sizeof(wstring), "(INFO) You have set Vehicle ID %d's type to: %d", vehicleid,thecar);
				    SendClientMessage(playerid,COLOR_ADMINCMD, wstring);
		    		SaveDynamicCars();
				}
 				else
				{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in a vehicle");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/acarmodel", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /acarmodel [modelid]");
				return 1;
			}
			new thecar = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
 					if(thecar > 399 && thecar < 612)
 					{
					new car = GetPlayerVehicleID(playerid) - 1;
					new vehicleid = GetPlayerVehicleID(playerid);
					DynamicCars[car][CarModel] = thecar;
		 			new wstring[128];
				    format(wstring, sizeof(wstring), "(INFO) You have set Vehicle ID %d's model to: %d", vehicleid,thecar);
				    SendClientMessage(playerid,COLOR_ADMINCMD, wstring);
   					new Float:cx,Float:cy,Float:cz;
   					GetVehiclePos(vehicleid,cx,cy,cz);
   					new Float:angle;
   					GetVehicleZAngle(vehicleid, angle);
					DestroyVehicle(vehicleid);
					CreateVehicle(DynamicCars[car][CarModel],DynamicCars[car][CarX],DynamicCars[car][CarY],DynamicCars[car][CarZ],DynamicCars[car][CarAngle],DynamicCars[car][CarColor1],DynamicCars[car][CarColor2], -1);
					PutPlayerInVehicle(playerid,vehicleid,0);
					SetVehiclePos(vehicleid, cx, cy, cz);
     				SetVehicleZAngle(vehicleid, angle);
				    SaveDynamicCars();
				    }
		   			else
					{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) Incorrect Model ID, Correct Model ID's: 400-611");
					}
				}
 				else
				{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in a vehicle");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/acarcolor", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /acarcolor [colorid] [colorid]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
					new color1;
					color1 = strval(tmp);
					if(color1 < 0 || color1 > 126) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) 0-126 = Valid Colors"); return 1; }
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /acarcolor [colorid] [colorid]");
						return 1;
					}
					new color2;
					color2 = strval(tmp);
					if(color2 < 0 || color2 > 126) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) 0-126 = Valid Colors"); return 1; }

					new car = GetPlayerVehicleID(playerid) - 1;
					new vehicleid = GetPlayerVehicleID(playerid);
					DynamicCars[car][CarColor1] = color1;
					DynamicCars[car][CarColor2] = color2;
					new wstring[128];
		   			format(wstring, sizeof(wstring), "(INFO) You have set Vehicle ID %d's colors to: %d-%d", vehicleid,color1,color2);
				    SendClientMessage(playerid,COLOR_ADMINCMD, wstring);
   					new Float:cx,Float:cy,Float:cz;
   					GetVehiclePos(vehicleid,cx,cy,cz);
   					new Float:angle;
   					GetVehicleZAngle(vehicleid, angle);
        			DestroyVehicle(vehicleid);
					CreateVehicle(DynamicCars[car][CarModel],DynamicCars[car][CarX],DynamicCars[car][CarY],DynamicCars[car][CarZ],DynamicCars[car][CarAngle],DynamicCars[car][CarColor1],DynamicCars[car][CarColor2], -1);
					PutPlayerInVehicle(playerid,vehicleid,0);
					SetVehiclePos(vehicleid, cx, cy, cz);
     				SetVehicleZAngle(vehicleid, angle);
				    SaveDynamicCars();
				}
 				else
				{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in a vehicle");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	//==========================================================================
	if(strcmp(cmd, "/agotobusiness", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /agotobusiness [id]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				SetPlayerPos(playerid,Businesses[id][EnterX],Businesses[id][EnterY],Businesses[id][EnterZ]);
				SetPlayerInterior(playerid,Businesses[id][EnterInterior]);
				SetPlayerVirtualWorld(playerid,Businesses[id][EnterWorld]);
				new form[128];
				format(form, sizeof(form), "(INFO) You teleported to business ID: %d", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
   	if(strcmp(cmd, "/abusinessproducts", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /abusinessproducts [businessid] [amount]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /abusinessproducts [businessid] [amount]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					Businesses[id][Products] = id2;
					new form[128];
					format(form, sizeof form, "(INFO) You have set Businesses ID: %d's products to %d", id,id2);
					SendClientMessage(playerid, COLOR_ADMINCMD,form);
					SaveBusinesses();
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
  	if(strcmp(cmd, "/abusinessprice", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /abusinessprice [businessid] [price]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /abusinessprice [businessid] [price]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					Businesses[id][BizPrice] = id2;
					new form[128];
					format(form, sizeof form, "(INFO) You have set Businesses ID: %d's price to %d", id,id2);
					SendClientMessage(playerid, COLOR_ADMINCMD,form);
					SaveBusinesses();
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/abusinesstype", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE,"[BUSINESS TYPES]");
			    SendClientMessage(playerid, COLOR_ADMINCMD,BUSINESS_TYPES);
				SendClientMessage(playerid, COLOR_ADMINCMD,BUSINESS_TYPES2);
				SendClientMessage(playerid, COLOR_WHITE, "SYNTAX - /abusinesstype [businessid] [type]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 4)
			{
					new id;
					new form[128];
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
					    SendClientMessage(playerid, COLOR_WHITE,"[BUSINESS TYPES]");
						SendClientMessage(playerid, COLOR_ADMINCMD,BUSINESS_TYPES);
						SendClientMessage(playerid, COLOR_ADMINCMD,BUSINESS_TYPES2);
						SendClientMessage(playerid, COLOR_WHITE, "SYNTAX - /abusinesstype [businessid] [type]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					Businesses[id][BizType] = id2;
					format(form, sizeof form, "You've set Businesses ID: %d's type to %d.", id,id2);
					SendClientMessage(playerid, COLOR_ADMINCMD,form);
					SaveBusinesses();
			}
			else
			{
				SendClientMessage(playerid, COLOR_WHITE, "You're not authorized to use that command!");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/abusinessentrance", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /abusinessentrance [bizid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
			    new pmodel;
				new Float:x,Float:y,Float:z;
				GetPlayerPos(playerid, x, y, z);
				Businesses[id][EnterX] = x;
				Businesses[id][EnterY] = y;
				Businesses[id][EnterZ] = z;
				Businesses[id][EnterWorld] = GetPlayerVirtualWorld(playerid);
				Businesses[id][EnterInterior] = GetPlayerInterior(playerid);
  				new Float:angle;
				GetPlayerFacingAngle(playerid, angle);
				Businesses[id][EnterAngle] = angle;
				switch(Businesses[id][Owned])
				{
				    case 0: pmodel = 1272;
				    case 1: pmodel = 1239;
				}
				ChangeStreamPickupModel(Businesses[id][PickupID],pmodel);
    			MoveStreamPickup(Businesses[id][PickupID],Businesses[id][EnterX], Businesses[id][EnterY], Businesses[id][EnterZ]);

				SaveBusinesses();
				new form[128];
				format(form, sizeof(form), "(INFO) You have set business ID: %d's location", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/abusinessexit", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /abusinessexit [bizid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				new Float:x,Float:y,Float:z;
				GetPlayerPos(playerid, x, y, z);
				Businesses[id][ExitX] = x;
				Businesses[id][ExitY] = y;
				Businesses[id][ExitZ] = z;
				Businesses[id][ExitInterior] = GetPlayerInterior(playerid);
  				new Float:angle;
				GetPlayerFacingAngle(playerid, angle);
				Businesses[id][ExitAngle] = angle;
				SaveBusinesses();
				new form[128];
				format(form, sizeof(form), "(INFO) You have set business ID: %d's exit location", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	//==========================================================================
 	if(strcmp(cmd, "/agotohouse", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /agotohouse [id]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				SetPlayerPos(playerid,Houses[id][EnterX],Houses[id][EnterY],Houses[id][EnterZ]);
				SetPlayerInterior(playerid,Houses[id][EnterInterior]);
				SetPlayerVirtualWorld(playerid,Houses[id][EnterWorld]);
				new form[128];
				format(form, sizeof(form), "(INFO) You teleported to house ID: %d", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/ahouseint", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /ahouseint [houseid] [id (1-42)]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /ahouseint [houseid] [id (1-42)]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);
					if(id2 < 1 || id2 > 42) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) Interior ID's 1-42"); return 1; }

					if(id2 == 1)
					{
						Houses[id][ExitX] = 235.508994;
						Houses[id][ExitY] = 1189.169897;
						Houses[id][ExitZ] = 1080.339966;
						Houses[id][ExitInterior] = 3;
						format(string, sizeof string, "House ID: %d - Description: Large/2 story/3 bedrooms/clone of House 9", id,id2);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 2)
					{
						Houses[id][ExitX] = 225.756989;
						Houses[id][ExitY] = 1240.000000;
						Houses[id][ExitZ] = 1082.149902;
						Houses[id][ExitInterior] = 2;
						format(string, sizeof string, "House ID: %d - Description: Medium/1 story/1 bedroom", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
					else if(id2 == 3)
					{
						Houses[id][ExitX] = 223.043991;
						Houses[id][ExitY] = 1289.259888;
						Houses[id][ExitZ] = 1082.199951;
						Houses[id][ExitInterior] = 1;
						format(string, sizeof string, "House ID: %d - Description: Small/1 story/1 bedroom", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 4)
					{
						Houses[id][ExitX] = 225.630997;
						Houses[id][ExitY] = 1022.479980;
						Houses[id][ExitZ] = 1084.069946;
						Houses[id][ExitInterior] = 7;
						format(string, sizeof string, "House ID: %d - Description: VERY Large/2 story/4 bedrooms", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 5)
					{
						Houses[id][ExitX] = 295.138977;
						Houses[id][ExitY] = 1474.469971;
						Houses[id][ExitZ] = 1080.519897;
						Houses[id][ExitInterior] = 15;
						format(string, sizeof string, "House ID: %d - Description: Small/1 story/2 bedrooms", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 6)
					{
						Houses[id][ExitX] = 328.493988;
						Houses[id][ExitY] = 1480.589966;
						Houses[id][ExitZ] = 1084.449951;
						Houses[id][ExitInterior] = 15;
						format(string, sizeof string, "House ID: %d - Description: Small/1 story/2 bedrooms", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 7)
					{
						Houses[id][ExitX] = 385.803986;
						Houses[id][ExitY] = 1471.769897;
						Houses[id][ExitZ] = 1080.209961;
						Houses[id][ExitInterior] = 15;
						format(string, sizeof string, "House ID: %d - Description: Small/1 story/1 bedroom/NO BATHROOM", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 8)
					{
						Houses[id][ExitX] = 375.971985;
						Houses[id][ExitY] = 1417.269897;
						Houses[id][ExitZ] = 1081.409912;
						Houses[id][ExitInterior] = 15;
						format(string, sizeof string, "House ID: %d - Description: Small/1 story/1 bedroom", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 9)
					{
						Houses[id][ExitX] = 490.810974;
						Houses[id][ExitY] = 1401.489990;
						Houses[id][ExitZ] = 1080.339966;
						Houses[id][ExitInterior] = 2;
						format(string, sizeof string, "House ID: %d - Description: Large/2 story/3 bedrooms", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     			 	else if(id2 == 10)
					{
						Houses[id][ExitX] = 447.734985;
						Houses[id][ExitY] = 1400.439941;
						Houses[id][ExitZ] = 1084.339966;
						Houses[id][ExitInterior] = 2;
						format(string, sizeof string, "House ID: %d - Description: Medium/1 story/2 bedrooms", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 11)
					{
						Houses[id][ExitX] = 227.722992;
						Houses[id][ExitY] = 1114.389893;
						Houses[id][ExitZ] = 1081.189941;
						Houses[id][ExitInterior] = 5;
						format(string, sizeof string, "House ID: %d - Description: Large/2 story/4 bedrooms", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 12)
					{
						Houses[id][ExitX] = 260.983978;
						Houses[id][ExitY] = 1286.549927;
						Houses[id][ExitZ] = 1080.299927;
						Houses[id][ExitInterior] = 4;
						format(string, sizeof string, "House ID: %d - Description: Small/1 story/1 bedroom", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 13)
					{
						Houses[id][ExitX] = 221.666992;
						Houses[id][ExitY] = 1143.389893;
						Houses[id][ExitZ] = 1082.679932;
						Houses[id][ExitInterior] = 4;
						format(string, sizeof string, "House ID: %d - Description: Small/1 story/1 bedroom/NO BATHROOM", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 14)
					{
						Houses[id][ExitX] = 27.132700;
						Houses[id][ExitY] = 1341.149902;
						Houses[id][ExitZ] = 1084.449951;
						Houses[id][ExitInterior] = 10;
						format(string, sizeof string, "House ID: %d - Description: Medium/2 story/1 bedroom", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 15)
					{
						Houses[id][ExitX] = -262.601990;
						Houses[id][ExitY] = 1456.619995;
						Houses[id][ExitZ] = 1084.449951;
						Houses[id][ExitInterior] = 4;
						format(string, sizeof string, "House ID: %d - Description: Large/2 story/1 bedroom/NO BATHROOM", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 16)
					{
						Houses[id][ExitX] = 22.778299;
						Houses[id][ExitY] = 1404.959961;
			 			Houses[id][ExitZ] = 1084.449951;
						Houses[id][ExitInterior] = 5;
						format(string, sizeof string, "House ID: %d - Description: Medium/1 story/2 bedrooms/NO BATHROOM or DOORS", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 17)
					{
						Houses[id][ExitX] = 140.278000;
						Houses[id][ExitY] = 1368.979980;
						Houses[id][ExitZ] = 1083.969971;
						Houses[id][ExitInterior] = 5;
						format(string, sizeof string, "House ID: %d - Description: Large/2 story/4 bedrooms/NO BATHROOM", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 18)
					{
						Houses[id][ExitX] = 234.045990;
						Houses[id][ExitY] = 1064.879883;
						Houses[id][ExitZ] = 1084.309937;
						Houses[id][ExitInterior] = 6;
						format(string, sizeof string, "House ID: %d - Description: Large/2 story/3 bedrooms", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 19)
					{
						Houses[id][ExitX] = -68.294098;
						Houses[id][ExitY] = 1353.469971;
						Houses[id][ExitZ] = 1080.279907;
						Houses[id][ExitInterior] = 6;
						format(string, sizeof string, "House ID: %d - Description: Small/1 story/NO BEDROOM", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 20)
					{
						Houses[id][ExitX] = -285.548981;
						Houses[id][ExitY] = 1470.979980;
						Houses[id][ExitZ] = 1084.449951;
						Houses[id][ExitInterior] = 15;
						format(string, sizeof string, "House ID: %d - Description: 1 bedroom/living room/kitchen/NO BATHROOM", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 21)
					{
						Houses[id][ExitX] = -42.581997;
						Houses[id][ExitY] = 1408.109985;
						Houses[id][ExitZ] = 1084.449951;
						Houses[id][ExitInterior] = 8;
						format(string, sizeof string, "House ID: %d - Description: Small/1 story/NO BEDROOM", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 22)
					{
						Houses[id][ExitX] = 83.345093;
						Houses[id][ExitY] = 1324.439941;
						Houses[id][ExitZ] = 1083.889893;
						Houses[id][ExitInterior] = 9;
						format(string, sizeof string, "House ID: %d - Description: Medium/2 story/2 bedrooms", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 23)
					{
						Houses[id][ExitX] = 260.941986;
						Houses[id][ExitY] = 1238.509888;
						Houses[id][ExitZ] = 1084.259888;
						Houses[id][ExitInterior] = 9;
						format(string, sizeof string, "House ID: %d - Description: Small/1 story/1 bedroom", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 24)
					{
						Houses[id][ExitX] = 244.411987;
						Houses[id][ExitY] = 305.032990;
						Houses[id][ExitZ] = 999.231995;
						Houses[id][ExitInterior] = 1;
						format(string, sizeof string, "House ID: %d - Description: Denise's Bedroom", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 25)
					{
						Houses[id][ExitX] = 271.884979;
						Houses[id][ExitY] = 306.631989;
						Houses[id][ExitZ] = 999.325989;
						Houses[id][ExitInterior] = 2;
						format(string, sizeof string, "House ID: %d - Description: Katie's Bedroom", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
      		 		else if(id2 == 26)
					{
						Houses[id][ExitX] = 291.282990;
						Houses[id][ExitY] = 310.031982;
						Houses[id][ExitZ] = 999.154968;
						Houses[id][ExitInterior] = 3;
						format(string, sizeof string, "House ID: %d - Description: Helena's Bedroom (barn) - limited movement", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 27)
					{
						Houses[id][ExitX] = 302.181000;
						Houses[id][ExitY] = 300.722992;
						Houses[id][ExitZ] = 999.231995;
						Houses[id][ExitInterior] = 4;
						format(string, sizeof string, "House ID: %d - Description: Michelle's Bedroom", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 28)
					{
						Houses[id][ExitX] = 322.197998;
						Houses[id][ExitY] = 302.497986;
						Houses[id][ExitZ] = 999.231995;
						Houses[id][ExitInterior] = 5;
						format(string, sizeof string, "House ID: %d - Description: Barbara's Bedroom", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 29)
					{
						Houses[id][ExitX] = 346.870025;
						Houses[id][ExitY] = 309.259033;
						Houses[id][ExitZ] = 999.155700;
						Houses[id][ExitInterior] = 6;
						format(string, sizeof string, "House ID: %d - Description: Millie's Bedroom", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 30)
					{
						Houses[id][ExitX] = 2496.049805;
						Houses[id][ExitY] = -1693.929932;
						Houses[id][ExitZ] = 1014.750000;
						Houses[id][ExitInterior] = 3;
						format(string, sizeof string, "House ID: %d - Description: CJ's Mom's House", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 31)
					{
						Houses[id][ExitX] = 1263.079956;
						Houses[id][ExitY] = -785.308960;
						Houses[id][ExitZ] = 1091.959961;
						Houses[id][ExitInterior] = 5;
						format(string, sizeof string, "House ID: %d - Description: Madd Dogg's Mansion (West door)", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 32)
					{
						Houses[id][ExitX] = 2464.109863;
						Houses[id][ExitY] = -1698.659912;
						Houses[id][ExitZ] = 1013.509949;
						Houses[id][ExitInterior] = 2;
						format(string, sizeof string, "House ID: %d - Description: Ryder's house", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 33)
					{
						Houses[id][ExitX] = 2526.459961;
						Houses[id][ExitY] = -1679.089966;
						Houses[id][ExitZ] = 1015.500000;
						Houses[id][ExitInterior] = 1;
						format(string, sizeof string, "House ID: %d - Description: Sweet's House (South side of house is fucked)", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 34)
					{
						Houses[id][ExitX] = 2543.659912;
						Houses[id][ExitY] = -1303.629883;
						Houses[id][ExitZ] = 1025.069946;
						Houses[id][ExitInterior] = 2;
						format(string, sizeof string, "House ID: %d - Description: Big Smoke's Crack Factory (Ground Floor)", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 35)
					{
						Houses[id][ExitX] = 744.542969;
						Houses[id][ExitY] = 1437.669922;
						Houses[id][ExitZ] = 1102.739990;
						Houses[id][ExitInterior] = 6;
						format(string, sizeof string, "House ID: %d - Description: Fanny Batter's Whore House", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 36)
					{
						Houses[id][ExitX] = 964.106995;
						Houses[id][ExitY] = -53.205498;
						Houses[id][ExitZ] = 1001.179993;
						Houses[id][ExitInterior] = 3;
						format(string, sizeof string, "House ID: %d - Description: Tiger Skin Rug Brothel", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 37)
					{
						Houses[id][ExitX] = 2350.339844;
						Houses[id][ExitY] = -1181.649902;
						Houses[id][ExitZ] = 1028.000000;
						Houses[id][ExitInterior] = 5;
						format(string, sizeof string, "House ID: %d - Description: Burning Desire Gang House", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 38)
					{
						Houses[id][ExitX] = 2807.619873;
						Houses[id][ExitY] = -1171.899902;
						Houses[id][ExitZ] = 1025.579956;
						Houses[id][ExitInterior] = 8;
						format(string, sizeof string, "House ID: %d - Description: Colonel Furhberger's House", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 39)
					{
						Houses[id][ExitX] = 318.564972;
						Houses[id][ExitY] = 1118.209961;
						Houses[id][ExitZ] = 1083.979980;
						Houses[id][ExitInterior] = 5;
						format(string, sizeof string, "House ID: %d - Description: Crack Den", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 40)
					{
						Houses[id][ExitX] = 446.622986;
						Houses[id][ExitY] = 509.318970;
						Houses[id][ExitZ] = 1001.419983;
						Houses[id][ExitInterior] = 12;
						format(string, sizeof string, "House ID: %d - Description: Budget Inn Motel Room", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 41)
					{
						Houses[id][ExitX] = 2216.339844;
						Houses[id][ExitY] = -1150.509888;
						Houses[id][ExitZ] = 1025.799927;
						Houses[id][ExitInterior] = 15;
						format(string, sizeof string, "House ID: %d - Description: Jefferson Motel. (REALLY EXPENSIVE)", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
  					}
         			else if(id2 == 42)
					{
						Houses[id][ExitX] = -2169.845947;
						Houses[id][ExitY] = 642.366027;
						Houses[id][ExitZ] = 1057.586059;
						Houses[id][ExitInterior] = 1;
						format(string, sizeof string, "House ID: %d - Description: Woozi's Casino", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
					SaveHouses();
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	//==========================================================================
  	if(strcmp(cmd, "/abuildingint", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /abuildingint [buildingid] [id (1-24)]");
				SendClientMessage(playerid, COLOR_WHITE, "(INTS) 1: Sherman Dam - 2: City Hall - 3: Ganton Gym - 4: Cobra Gym - 5: Below The Belt Gym");
				SendClientMessage(playerid, COLOR_WHITE, "(INTS) 6: RC Battlefield - 7-9: Police Departments - 10-12: Schools - 13: 8 Track Stadium");
				SendClientMessage(playerid, COLOR_WHITE, "(INTS) 14: Bloodbowl Stadium - 15: Dirtbike Stadium - 16: Kickstart Stadium - 17: Vice Stadium");
				SendClientMessage(playerid, COLOR_WHITE, "(INTS) 18: Government Building - 19: Police Department (small) - 20: Presidents Quarters");
				SendClientMessage(playerid, COLOR_WHITE, "(INTS) 21: Caligula's Rooftop - 22: Bank - 23: Hangout - 24: License Centre Sidedoor");
				return 1;
			}
   			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /abuildingint [buildingid] [id (1-25)]");
						SendClientMessage(playerid, COLOR_WHITE, "(INTS) 1: Sherman Dam - 2: City Hall - 3: Ganton Gym - 4: Cobra Gym - 5: Below The Belt Gym");
						SendClientMessage(playerid, COLOR_WHITE, "(INTS) 6: RC Battlefield - 7-9: Police Departments - 10-12: Schools - 13: 8 Track Stadium");
						SendClientMessage(playerid, COLOR_WHITE, "(INTS) 14: Bloodbowl Stadium - 15: Dirtbike Stadium - 16: Kickstart Stadium - 17: Vice Stadium");
						SendClientMessage(playerid, COLOR_WHITE, "(INTS) 18: Government Building - 19: Police Department (small) - 20: Presidents Quarters");
						SendClientMessage(playerid, COLOR_WHITE, "(INTS) 21: Caligula's Rooftop - 22: Bank - 23: Hangout - 24: License Centre Sidedoor - 25: Hospital");
						SendClientMessage(playerid, COLOR_WHITE, "(INTS) 26: Jefferson Motel - 27: Airport");
						return 1;
					}
					new id2;
					id2 = strval(tmp);
					if(id2 < 1 || id2 > 25) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) Interior ID's 1-25"); return 1; }

					if(id2 == 1)
					{
						Building[id][ExitX] = -959.873962;
						Building[id][ExitY] = 1952.000000;
						Building[id][ExitZ] = 9.044310;
						Building[id][ExitInterior] = 17;
						format(string, sizeof string, "Building ID: %d - Description: Sherman Dam", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 2)
					{
						Building[id][ExitX] = 388.871979;
						Building[id][ExitY] = 173.804993;
						Building[id][ExitZ] = 1008.389954;
						Building[id][ExitInterior] = 3;
						format(string, sizeof string, "Building ID: %d - Description: City Hall", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 3)
					{
						Building[id][ExitX] = 772.112000;
						Building[id][ExitY] = -3.898650;
						Building[id][ExitZ] = 1000.687988;
						Building[id][ExitInterior] = 5;
						format(string, sizeof string, "Building ID: %d - Description: Ganton Gym", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 4)
					{
						Building[id][ExitX] = 774.213989;
						Building[id][ExitY] = -48.924297;
						Building[id][ExitZ] = 1000.687988;
						Building[id][ExitInterior] = 6;
						format(string, sizeof string, "Building ID: %d - Description: Cobra Gym", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 5)
					{
						Building[id][ExitX] = 773.579956;
						Building[id][ExitY] = -77.096695;
						Building[id][ExitZ] = 1000.687988;
						Building[id][ExitInterior] = 7;
						format(string, sizeof string, "Building ID: %d - Description: Below The Belt Gym", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 6)
					{
						Building[id][ExitX] = -972.4957;
						Building[id][ExitY] = 1060.983;
						Building[id][ExitZ] = 1345.669;
						Building[id][ExitInterior] = 10;
						format(string, sizeof string, "Building ID: %d - Description: RC Battlefield", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 7)
					{
						Building[id][ExitX] = 246.783997;
						Building[id][ExitY] = 63.900200;
						Building[id][ExitZ] = 1003.639954;
						Building[id][ExitInterior] = 6;
						format(string, sizeof string, "Building ID: %d - Description: LSPD", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 8)
					{
						Building[id][ExitX] = 246.375992;
						Building[id][ExitY] = 109.245995;
						Building[id][ExitZ] = 1003.279968;
						Building[id][ExitInterior] = 10;
						format(string, sizeof string, "Building ID: %d - Description: SFPD", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 9)
					{
						Building[id][ExitX] = 238.661987;
						Building[id][ExitY] = 141.051987;
						Building[id][ExitZ] = 1003.049988;
						Building[id][ExitInterior] = 3;
						format(string, sizeof string, "Building ID: %d - Description: LVPD", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 10)
					{
						Building[id][ExitX] = 1494.429932;
						Building[id][ExitY] = 1305.629883;
						Building[id][ExitZ] = 1093.289917;
						Building[id][ExitInterior] = 3;
						format(string, sizeof string, "Building ID: %d - Description: Bike School", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 11)
					{
						Building[id][ExitX] = -2029.719971;
						Building[id][ExitY] = -115.067993;
						Building[id][ExitZ] = 1035.169922;
						Building[id][ExitInterior] = 3;
						format(string, sizeof string, "Building ID: %d - Description: Driving School", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 12)
					{
						Building[id][ExitX] = 420.484985;
						Building[id][ExitY] = 2535.589844;
						Building[id][ExitZ] = 10.020289;
						Building[id][ExitInterior] = 10;
						format(string, sizeof string, "Building ID: %d - Description: School (None)", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 13)
					{
						Building[id][ExitX] = -1397.782470;
						Building[id][ExitY] = -203.723114;
						Building[id][ExitZ] = 1051.346801;
						Building[id][ExitInterior] = 7;
						format(string, sizeof string, "Building ID: %d - Description: 8 Track Stadium", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 14)
					{
						Building[id][ExitX] = -1398.103515;
						Building[id][ExitY] = 933.445434;
						Building[id][ExitZ] = 1041.531250;
						Building[id][ExitInterior] = 15;
						format(string, sizeof string, "Building ID: %d - Description: Bloodbowl Stadium", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 15)
					{
						Building[id][ExitX] = -1428.809448;
						Building[id][ExitY] = -663.595886;
						Building[id][ExitZ] = 1060.219848;
						Building[id][ExitInterior] = 4;
						format(string, sizeof string, "Building ID: %d - Description: Dirtbike Stadium", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 16)
					{
						Building[id][ExitX] = -1486.861816;
						Building[id][ExitY] = 1642.145996;
						Building[id][ExitZ] = 1060.671875;
						Building[id][ExitInterior] = 14;
						format(string, sizeof string, "Building ID: %d - Description: Kickstart Stadium", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 17)
					{
						Building[id][ExitX] = -1401.830000;
						Building[id][ExitY] = 107.051300;
						Building[id][ExitZ] = 1032.273000;
						Building[id][ExitInterior] = 1;
						format(string, sizeof string, "Building ID: %d - Description: Vice Stadium (Only center is solid)", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
					}
         			else if(id2 == 18)
					{
						Building[id][ExitX] = 1721.964965;
						Building[id][ExitY] = -1647.560058;
						Building[id][ExitZ] = 20.226999;
						Building[id][ExitInterior] = 18;
						format(string, sizeof string, "Building ID: %d - Description: Government Building", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
       				}
         			else if(id2 == 19)
					{
						Building[id][ExitX] = 322.197998;
						Building[id][ExitY] = 302.497985;
						Building[id][ExitZ] = 999.231994;
						Building[id][ExitInterior] = 5;
						format(string, sizeof string, "Building ID: %d - Description: Police Department (small)", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
					}
         			else if(id2 == 20)
					{
						Building[id][ExitX] = 2324.419922;
						Building[id][ExitY] = -1147.539917;
						Building[id][ExitZ] = 1050.719971;
						Building[id][ExitInterior] = 12;
						format(string, sizeof string, "Building ID: %d - Description: Presidents Quarters", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
                   	}
         			else if(id2 == 21)
					{
						Building[id][ExitX] = 2266.7432;
						Building[id][ExitY] = 1647.4900;
						Building[id][ExitZ] = 1084.2344;
						Building[id][ExitInterior] = 1;
						format(string, sizeof string, "Building ID: %d - Description: Caligula's Rooftop", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
                   	}
         			else if(id2 == 22)
					{
						Building[id][ExitX] = 2306.3030;
						Building[id][ExitY] = -16.1460;
						Building[id][ExitZ] = 26.7496;
						Building[id][ExitInterior] = 0;
						format(string, sizeof string, "Building ID: %d - Description: Bank", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 23)
					{
						Building[id][ExitX] = 1489.5071;
						Building[id][ExitY] = -1895.2460;
						Building[id][ExitZ] = 22.2177;
						Building[id][ExitInterior] = 0;
						format(string, sizeof string, "Building ID: %d - Description: Hangout", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 24)
					{
						Building[id][ExitX] = -2027.0676;
						Building[id][ExitY] = -104.8886;
						Building[id][ExitZ] = 1035.1719;
						Building[id][ExitInterior] = 3;
						format(string, sizeof string, "Building ID: %d - Description: License Centre Side Door", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
      				}
      				else if(id2 == 25)
      				{
						Building[id][ExitX] = 4060.2734;
						Building[id][ExitY] = -196.4038;
						Building[id][ExitZ] = 59.2456;
						Building[id][ExitInterior] = 0;
						format(string, sizeof string, "Building ID: %d - Description: Hospital", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
					}
					else if(id2 == 26)
					{
                        Building[id][ExitX] = 2220.26;
						Building[id][ExitY] = -1148.01;
						Building[id][ExitZ] = 1025.80;
						Building[id][ExitInterior] = 15;
						format(string, sizeof string, "Building ID: %d - Jefferson Motel (Add lots of houses in here)", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
					}
					else if(id2 == 27)
					{
                        Building[id][ExitX] = -1830.81;
						Building[id][ExitY] = 16.83;
						Building[id][ExitZ] = 1061.14;
						Building[id][ExitInterior] = 14;
						format(string, sizeof string, "Building ID: %d - Airport", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
					}
					SaveBuildings();
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/abusinessint", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /abusinessint [bizid] [id (1-35)]");
				SendClientMessage(playerid, COLOR_WHITE, "(INTS) 1: Marcos Bistro (Eat) - 2: Big Spread Ranch (Bar) - 3: Burger Shot (Eat) - 4: Cluckin Bell (Eat)");
				SendClientMessage(playerid, COLOR_WHITE, "(INTS) 5: Well Stacked Pizza (Eat) - 6: Rusty Browns Dohnuts (Eat) - 7: Jays Diner (Eat) - 8: Pump Truck Stop Diner (Eat)");
				SendClientMessage(playerid, COLOR_WHITE, "(INTS) 9: Alhambra (Drink) - 10: Mistys (Drink) - 11: Lil' Probe Inn (Drink) - 12: Exclusive (Clothes) - 13: Binco (Clothes)");
				SendClientMessage(playerid, COLOR_WHITE, "(INTS) 14: ProLaps (Clothes) - 15: SubUrban (Clothes) - 16: Victim (Clothes) - 17: Zip (Clothes) - 18: Redsands Casino");
				SendClientMessage(playerid, COLOR_WHITE, "(INTS) 19: Off Track Betting - 20: Sex Shop - 21: Zeros RC Shop - 22-25: Ammunations (Gun) - 26: Jizzy's (Drink)");
				SendClientMessage(playerid, COLOR_WHITE, "(INTS) 27-32: 24-7's (Buy) - 33: Advertising/Phone Network - 34: Caligula's Palace - 35: The Four Dragons Casino");
				return 1;
			}
   			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /abusinessint [bizid] [id (1-33)]");
						SendClientMessage(playerid, COLOR_WHITE, "(INTS) 1: Marcos Bistro (Eat) - 2: Big Spread Ranch (Bar) - 3: Burger Shot (Eat) - 4: Cluckin Bell (EAT)");
						SendClientMessage(playerid, COLOR_WHITE, "(INTS) 5: Well Stacked Pizza (Eat) - 6: Rusty Browns Dohnuts (Eat) - 7: Jays Diner (Eat) - 8: Pump Truck Stop Diner (Eat)");
						SendClientMessage(playerid, COLOR_WHITE, "(INTS) 9: Alhambra (Drink) - 10: Mistys (Drink) - 11: Lil' Probe Inn (Drink) - 12: Exclusive (Clothes) - 13: Binco (Clothes)");
						SendClientMessage(playerid, COLOR_WHITE, "(INTS) 14: ProLaps (Clothes) - 15: SubUrban (Clothes) - 16: Victim (Clothes) - 17: Zip (Clothes) - 18: Redsands Casino");
						SendClientMessage(playerid, COLOR_WHITE, "(INTS) 19: Off Track Betting - 20: Sex Shop - 21: Zeros RC Shop - 22-25: Ammunations (Gun) - 26: Jizzy's (Drink)");
						SendClientMessage(playerid, COLOR_WHITE, "(INTS) 27-32: 24-7's (Buy) - 33: Advertising/Phone Network");
						return 1;
					}
					new id2;
					id2 = strval(tmp);
					if(id2 < 1 || id2 > 35) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) Interior ID's 1-35"); return 1; }

					if(id2 == 1)
					{
						Businesses[id][ExitX] = -794.806030;
						Businesses[id][ExitY] = 491.686004;
						Businesses[id][ExitZ] = 1376.194946;
						Businesses[id][ExitInterior] = 1;
						format(string, sizeof string, "Business ID: %d - Description: Marcos Bistro", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
					else if(id2 == 2)
					{
						Businesses[id][ExitX] = 1212.019897;
						Businesses[id][ExitY] = -28.663099;
						Businesses[id][ExitZ] = 1001.089966;
						Businesses[id][ExitInterior] = 3;
						format(string, sizeof string, "Business ID: %d - Description: Big Spread Ranch Strip Club", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 3)
					{
						Businesses[id][ExitX] = 366.923980;
						Businesses[id][ExitY] = -72.929359;
						Businesses[id][ExitZ] = 1001.507812;
						Businesses[id][ExitInterior] = 10;
						format(string, sizeof string, "Business ID: %d - Description: Burger Shot", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 4)
					{
						Businesses[id][ExitX] = 365.672974;
						Businesses[id][ExitY] = -10.713200;
						Businesses[id][ExitZ] = 1001.869995;
						Businesses[id][ExitInterior] = 9;
						format(string, sizeof string, "Business ID: %d - Description: Cluckin Bell", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 5)
					{
						Businesses[id][ExitX] = 372.351990;
						Businesses[id][ExitY] = -131.650986;
						Businesses[id][ExitZ] = 1001.449951;
						Businesses[id][ExitInterior] = 5;
						format(string, sizeof string, "Business ID: %d - Description: Well Stacked Pizza", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 6)
					{
						Businesses[id][ExitX] = 377.098999;
						Businesses[id][ExitY] = -192.439987;
						Businesses[id][ExitZ] = 1000.643982;
						Businesses[id][ExitInterior] = 17;
						format(string, sizeof string, "Business ID: %d - Description: Rusty Brown Dohnuts", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 7)
					{
						Businesses[id][ExitX] = 460.099976;
						Businesses[id][ExitY] = -88.428497;
						Businesses[id][ExitZ] = 999.621948;
						Businesses[id][ExitInterior] = 4;
						format(string, sizeof string, "Business ID: %d - Description: Jays Diner", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 8)
					{
						Businesses[id][ExitX] = 681.474976;
						Businesses[id][ExitY] = -451.150970;
						Businesses[id][ExitZ] = -25.616798;
						Businesses[id][ExitInterior] = 1;
						format(string, sizeof string, "Business ID: %d - Description: Pump Truck Stop Diner", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 9)
					{
						Businesses[id][ExitX] = 476.068328;
						Businesses[id][ExitY] = -14.893922;
						Businesses[id][ExitZ] = 1003.695312;
						Businesses[id][ExitInterior] = 17;
						format(string, sizeof string, "Business ID: %d - Description: Alhambra", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 10)
					{
						Businesses[id][ExitX] = 501.980988;
						Businesses[id][ExitY] = -69.150200;
						Businesses[id][ExitZ] = 998.834961;
						Businesses[id][ExitInterior] = 11;
						format(string, sizeof string, "Business ID: %d - Description: Mistys", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 11)
					{
						Businesses[id][ExitX] = -227.028000;
						Businesses[id][ExitY] = 1401.229980;
						Businesses[id][ExitZ] = 27.769798;
						Businesses[id][ExitInterior] = 18;
						format(string, sizeof string, "Business ID: %d - Description: Lil' Probe Inn", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 12)
					{
						Businesses[id][ExitX] = 204.332993;
						Businesses[id][ExitY] = -166.694992;
						Businesses[id][ExitZ] = 1000.578979;
						Businesses[id][ExitInterior] = 14;
						format(string, sizeof string, "Business ID: %d - Description: EXcLusive", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 13)
					{
						Businesses[id][ExitX] = 207.737991;
						Businesses[id][ExitY] = -109.019997;
						Businesses[id][ExitZ] = 1005.269958;
						Businesses[id][ExitInterior] = 15;
						format(string, sizeof string, "Business ID: %d - Description: Binco", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 14)
					{
						Businesses[id][ExitX] = 207.054993;
						Businesses[id][ExitY] = -138.804993;
						Businesses[id][ExitZ] = 1003.519958;
						Businesses[id][ExitInterior] = 3;
						format(string, sizeof string, "Business ID: %d - Description: ProLaps", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 15)
					{
						Businesses[id][ExitX] = 203.778000;
						Businesses[id][ExitY] = -48.492397;
						Businesses[id][ExitZ] = 1001.799988;
						Businesses[id][ExitInterior] = 1;
						format(string, sizeof string, "Business ID: %d - Description: SubUrban", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 16)
					{
						Businesses[id][ExitX] = 226.293991;
						Businesses[id][ExitY] = -7.431530;
						Businesses[id][ExitZ] = 1002.259949;
						Businesses[id][ExitInterior] = 5;
						format(string, sizeof string, "Business ID: %d - Description: Victim", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 17)
					{
						Businesses[id][ExitX] = 161.391006;
						Businesses[id][ExitY] = -93.159156;
						Businesses[id][ExitZ] = 1001.804687;
						Businesses[id][ExitInterior] = 18;
						format(string, sizeof string, "Business ID: %d - Description: Zip", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 18)
					{
						Businesses[id][ExitX] = 1133.069946;
						Businesses[id][ExitY] = -9.573059;
						Businesses[id][ExitZ] = 1000.750000;
						Businesses[id][ExitInterior] = 12;
						format(string, sizeof string, "Business ID: %d - Description: Small Casino in Redsands West", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 19)
					{
						Businesses[id][ExitX] = 833.818970;
						Businesses[id][ExitY] = 7.418000;
						Businesses[id][ExitZ] = 1004.179993;
						Businesses[id][ExitInterior] = 3;
						format(string, sizeof string, "Business ID: %d - Description: Off Track Betting", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 20)
					{
						Businesses[id][ExitX] = -100.325996;
						Businesses[id][ExitY] = -22.816500;
						Businesses[id][ExitZ] = 1000.741943;
						Businesses[id][ExitInterior] = 3;
						format(string, sizeof string, "Business ID: %d - Description: Sex Shop", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 21)
					{
						Businesses[id][ExitX] = -2239.569824;
						Businesses[id][ExitY] = 130.020996;
						Businesses[id][ExitZ] = 1035.419922;
						Businesses[id][ExitInterior] = 6;
						format(string, sizeof string, "Business ID: %d - Description: Zero's RC Shop", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 22)
					{
						Businesses[id][ExitX] = 286.148987;
						Businesses[id][ExitY] = -40.644398;
						Businesses[id][ExitZ] = 1001.569946;
						Businesses[id][ExitInterior] = 1;
						format(string, sizeof string, "Business ID: %d - Description: Ammunation 1", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 23)
					{
						Businesses[id][ExitX] = 286.800995;
						Businesses[id][ExitY] = -82.547600;
						Businesses[id][ExitZ] = 1001.539978;
						Businesses[id][ExitInterior] = 4;
						format(string, sizeof string, "Business ID: %d - Description: Ammunation 2", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
	 				else if(id2 == 24)
					{
						Businesses[id][ExitX] = 296.919983;
						Businesses[id][ExitY] = -108.071999;
						Businesses[id][ExitZ] = 1001.569946;
						Businesses[id][ExitInterior] = 6;
						format(string, sizeof string, "Business ID: %d - Description: Ammunation 3", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 25)
					{
						Businesses[id][ExitX] = 316.524994;
						Businesses[id][ExitY] = -167.706985;
						Businesses[id][ExitZ] = 999.661987;
						Businesses[id][ExitInterior] = 6;
						format(string, sizeof string, "Business ID: %d - Description: Ammunation 4", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 26)
					{
						Businesses[id][ExitX] = -2637.449951;
						Businesses[id][ExitY] = 1404.629883;
						Businesses[id][ExitZ] = 906.457947;
						Businesses[id][ExitInterior] = 3;
						format(string, sizeof string, "Business ID: %d - Description: Jizzys", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 27)
					{
						Businesses[id][ExitX] = -25.884499;
						Businesses[id][ExitY] = -185.868988;
						Businesses[id][ExitZ] = 1003.549988;
						Businesses[id][ExitInterior] = 17;
						format(string, sizeof string, "Business ID: %d - Description: 24-7 1", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 28)
					{
						Businesses[id][ExitX] = 6.091180;
						Businesses[id][ExitY] = -29.271898;
						Businesses[id][ExitZ] = 1003.549988;
						Businesses[id][ExitInterior] = 10;
						format(string, sizeof string, "Business ID: %d - Description: 24-7 2", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 29)
					{
						Businesses[id][ExitX] = -30.946699;
						Businesses[id][ExitY] = -89.609596;
						Businesses[id][ExitZ] = 1003.549988;
						Businesses[id][ExitInterior] = 18;
						format(string, sizeof string, "Business ID: %d - Description: 24-7 3", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 30)
					{
						Businesses[id][ExitX] = -25.132599;
						Businesses[id][ExitY] = -139.066986;
						Businesses[id][ExitZ] = 1003.549988;
						Businesses[id][ExitInterior] = 16;
						format(string, sizeof string, "Business ID: %d - Description: 24-7 4", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 31)
					{
						Businesses[id][ExitX] = -27.312300;
						Businesses[id][ExitY] = -29.277599;
						Businesses[id][ExitZ] = 1003.549988;
						Businesses[id][ExitInterior] = 4;
						format(string, sizeof string, "Business ID: %d - Description: 24-7 5", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 32)
					{
						Businesses[id][ExitX] = -26.691599;
						Businesses[id][ExitY] = -55.714897;
						Businesses[id][ExitZ] = 1003.549988;
						Businesses[id][ExitInterior] = 6;
						format(string, sizeof string, "Business ID: %d - Description: 24-7 6", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
  					}
         			else if(id2 == 33)
					{
						Businesses[id][ExitX] = 1494.430053;
						Businesses[id][ExitY] = 1305.63004;
						Businesses[id][ExitZ] = 1093.290039;
						Businesses[id][ExitInterior] = 3;
						format(string, sizeof string, "Business ID: %d - Description: Advertising/Phone Network", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
      			    else if(id2 == 34)
					{
						Businesses[id][ExitX] = 2016.2699;
						Businesses[id][ExitY] = 1017.7790;
						Businesses[id][ExitZ] = 996.8750;
						Businesses[id][ExitInterior] = 10;
						format(string, sizeof string, "Business ID: %d - Four Dragons Casino", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
  			        else if(id2 == 35)
					{
						Businesses[id][ExitX] = 2233.8032;
						Businesses[id][ExitY] = 1712.2303;
						Businesses[id][ExitZ] = 1011.7632;
						Businesses[id][ExitInterior] = 1;
						format(string, sizeof string, "Business ID: %d - Caligula's", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
					SaveBusinesses();
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/ahouseprice", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /ahouseprice [houseid] [price]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /ahouseprice [houseid] [price]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					Houses[id][HousePrice] = id2;
					new form[128];
					format(form, sizeof form, "(INFO) You have set House ID: %d's price to %d", id,id2);
					SendClientMessage(playerid, COLOR_ADMINCMD,form);
					SaveHouses();
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/abusinessname", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /abusinessname [bizid] [name]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
					idx++;
				}
				new offset = idx;
				new result[128];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
					result[idx - offset] = cmdtext[idx];
					idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /abusinessname [bizid] [name]");
					return 1;
				}
				if(strfind( result , "|" , true ) == -1)
    			{
		   			strmid(Businesses[id][BusinessName], (result), 0, strlen((result)), 128);
					format(string, sizeof(string), "(INFO) You have set Business ID's: %d's name to %s", id,(result));
					SendClientMessage(playerid, COLOR_ADMINCMD, string);
					SaveBusinesses();
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid symbol, | is not allowed");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/abusinesssell", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /abusinesssell [businessid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				Businesses[id][Locked] = 1;
				Businesses[id][Owned] = 0;
				strmid(Businesses[id][Owner], "None", 0, strlen("None"), 255);
				ChangeStreamPickupModel(Businesses[id][PickupID],1272);
    			MoveStreamPickup(Businesses[id][PickupID],Businesses[id][EnterX], Businesses[id][EnterY], Businesses[id][EnterZ]);
				SaveBusinesses();
				new form[128];
				format(form, sizeof(form), "(INFO) You have sold business ID: %d", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/ahousesell", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /ahousesell [houseid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				Houses[id][Locked] = 1;
				Houses[id][Owned] = 0;
				strmid(Houses[id][Owner], "None", 0, strlen("None"), 255);
				ChangeStreamPickupModel(Houses[id][PickupID],1273);
    			MoveStreamPickup(Houses[id][PickupID],Houses[id][EnterX], Houses[id][EnterY], Houses[id][EnterZ]);
				SaveHouses();
				new form[128];
				format(form, sizeof(form), "(INFO) You have sold house ID: %d", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/ahouseentrance", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /ahouseentrance [houseid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
			    new pmodel;
				new Float:x,Float:y,Float:z;
				GetPlayerPos(playerid, x, y, z);
				Houses[id][EnterX] = x;
				Houses[id][EnterY] = y;
				Houses[id][EnterZ] = z;
				Houses[id][EnterWorld] = GetPlayerVirtualWorld(playerid);
				Houses[id][EnterInterior] = GetPlayerInterior(playerid);
  				new Float:angle;
				GetPlayerFacingAngle(playerid, angle);
				Houses[id][EnterAngle] = angle;

				switch(Houses[id][Owned])
				{
				    case 0: pmodel = 1273;
				    case 1: pmodel = 1239;
				}
				ChangeStreamPickupModel(Houses[id][PickupID],pmodel);
    			MoveStreamPickup(Houses[id][PickupID],Houses[id][EnterX], Houses[id][EnterY], Houses[id][EnterZ]);
				SaveHouses();
				new form[128];
				format(form, sizeof(form), "(INFO) You have set house ID: %d's location", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/ahouseexit", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /ahouseexit [houseid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				new Float:x,Float:y,Float:z;
				GetPlayerPos(playerid, x, y, z);
				Houses[id][ExitX] = x;
				Houses[id][ExitY] = y;
				Houses[id][ExitZ] = z;
				Houses[id][ExitInterior] = GetPlayerInterior(playerid);
  				new Float:angle;
				GetPlayerFacingAngle(playerid, angle);
				Houses[id][ExitAngle] = angle;
				SaveHouses();
				new form[128];
				format(form, sizeof(form), "(INFO) You have set house ID: %d's exit location", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/ahousedescription", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /ahousedescription [houseid] [discription]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
					idx++;
				}
				new offset = idx;
				new result[128];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
					result[idx - offset] = cmdtext[idx];
					idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /ahousedescription [houseid] [discription]");
					return 1;
				}
				if(strfind( result , "|" , true ) == -1)
    			{
		   			strmid(Houses[id][Description], (result), 0, strlen((result)), 128);
					format(string, sizeof(string), "(INFO) You have set house ID: %d's description to %s", id,(result));
					SendClientMessage(playerid, COLOR_ADMINCMD, string);
					SaveHouses();
				}
 				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid symbol, | is not allowed");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	//==========================================================================
	if(strcmp(cmd, "/abuildingentrance", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /abuildingentrance [buildingid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				new Float:x,Float:y,Float:z;
				GetPlayerPos(playerid, x, y, z);
				Building[id][EnterX] = x;
				Building[id][EnterY] = y;
				Building[id][EnterZ] = z;
				Building[id][EnterWorld] = GetPlayerVirtualWorld(playerid);
				Building[id][EnterInterior] = GetPlayerInterior(playerid);
  				new Float:angle;
				GetPlayerFacingAngle(playerid, angle);
				Building[id][EnterAngle] = angle;
				MoveStreamPickup(Building[id][PickupID],Building[id][EnterX], Building[id][EnterY], Building[id][EnterZ]);
				SaveBuildings();
				new form[128];
				format(form, sizeof(form), "(INFO) You have set building ID: %d's location", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/agotobuilding", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /agotobuilding [buildingid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				SetPlayerPos(playerid,Building[id][EnterX],Building[id][EnterY],Building[id][EnterZ]);
				SetPlayerInterior(playerid,Building[id][EnterInterior]);
				SetPlayerVirtualWorld(playerid,Building[id][EnterWorld]);
				new form[128];
				format(form, sizeof(form), "(INFO) You teleported to building ID: %d", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/abuildinglock", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /abuildinglock [buildingid]");
				return 1;
			}
			new id = strval(tmp);
			new form[128];
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
			    if(Building[id][Locked] == 0)
			    {
			    	Building[id][Locked] = 1;
   					format(form, sizeof(form), "(INFO) You have locked building ID: %d", id);
					SendClientMessage(playerid, COLOR_ADMINCMD, form);
			    }
			    else
			    {
			    	Building[id][Locked] = 0;
   					format(form, sizeof(form), "(INFO) You have unlocked building ID: %d", id);
					SendClientMessage(playerid, COLOR_ADMINCMD, form);
			    }
				SaveBuildings();
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/abuildingexit", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /abuildingexit [buildingid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				new Float:x,Float:y,Float:z;
				GetPlayerPos(playerid, x, y, z);
				Building[id][ExitX] = x;
				Building[id][ExitY] = y;
				Building[id][ExitZ] = z;
				Building[id][ExitInterior] = GetPlayerInterior(playerid);
  				new Float:angle;
				GetPlayerFacingAngle(playerid, angle);
				Building[id][ExitAngle] = angle;
				SaveBuildings();
				new form[128];
				format(form, sizeof(form), "(INFO) You have set building ID: %d's exit location", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/abuildingname", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /abuildingname [buildingid] [name]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
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
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /abuildingname [buildingid] [name]");
					return 1;
				}
				if(strfind( result , "|" , true ) == -1)
    			{
		   			strmid(Building[id][BuildingName], (result), 0, strlen((result)), 128);
					format(string, sizeof(string), "(INFO) You have set Building ID: %d's name to %s", id,(result));
					SendClientMessage(playerid, COLOR_ADMINCMD, string);
					SaveBuildings();
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid symbol, | is not allowed");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/abuildingfee", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /abuildingfee [buildingid] [amount]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /abuildingfee [buildingid] [amount]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					Building[id][EntranceFee] = id2;
					new form[128];
					format(form, sizeof form, "(INFO) You have set Building ID: %d's Entrance Fee to %d", id,id2);
					SendClientMessage(playerid, COLOR_ADMINCMD,form);
					SaveBuildings();
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	//==========================================================================
	if(strcmp(cmd, "/agotobank", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SetPlayerPos(playerid,BankPosition[X],BankPosition[Y],BankPosition[Z]);
			SetPlayerInterior(playerid,BankPosition[Interior]);
			SetPlayerVirtualWorld(playerid,BankPosition[World]);
			SetPlayerFacingAngle(playerid,BankPosition[Angle]);
			SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You teleported to the Bank Position");
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
		}
		return 1;
	}
   	if(strcmp(cmd, "/agotodrivingtestpos", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SetPlayerPos(playerid,DrivingTestPosition[X],DrivingTestPosition[Y],DrivingTestPosition[Z]);
			SetPlayerInterior(playerid,DrivingTestPosition[Interior]);
			SetPlayerVirtualWorld(playerid,DrivingTestPosition[World]);
			SetPlayerFacingAngle(playerid,DrivingTestPosition[Angle]);
			SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You teleported to the driving test position");
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
		}
		return 1;
	}
	if(strcmp(cmd, "/agotoflyingtestpos", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SetPlayerPos(playerid,FlyingTestPosition[X],FlyingTestPosition[Y],FlyingTestPosition[Z]);
			SetPlayerInterior(playerid,FlyingTestPosition[Interior]);
			SetPlayerVirtualWorld(playerid,FlyingTestPosition[World]);
			SetPlayerFacingAngle(playerid,FlyingTestPosition[Angle]);
			SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You teleported to the flying test position");
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
		}
		return 1;
	}
 	if(strcmp(cmd, "/agotopolicearrestpos", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SetPlayerPos(playerid,PoliceArrestPosition[X],PoliceArrestPosition[Y],PoliceArrestPosition[Z]);
			SetPlayerInterior(playerid,PoliceArrestPosition[Interior]);
			SetPlayerVirtualWorld(playerid,PoliceArrestPosition[World]);
			SetPlayerFacingAngle(playerid,PoliceArrestPosition[Angle]);
			SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You teleported to the police arrest position");
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
		}
		return 1;
	}
	if(strcmp(cmd, "/agotogovarrestpos", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SetPlayerPos(playerid,GovernmentArrestPosition[X],GovernmentArrestPosition[Y],GovernmentArrestPosition[Z]);
			SetPlayerInterior(playerid,GovernmentArrestPosition[Interior]);
			SetPlayerVirtualWorld(playerid,GovernmentArrestPosition[World]);
			SetPlayerFacingAngle(playerid,GovernmentArrestPosition[Angle]);
			SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You teleported to the government arrest position");
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
		}
		return 1;
	}
  	if(strcmp(cmd, "/agotopolicedutypos", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SetPlayerPos(playerid,PoliceDutyPosition[X],PoliceDutyPosition[Y],PoliceDutyPosition[Z]);
			SetPlayerInterior(playerid,PoliceDutyPosition[Interior]);
			SetPlayerVirtualWorld(playerid,PoliceDutyPosition[World]);
			SetPlayerFacingAngle(playerid,PoliceDutyPosition[Angle]);
			SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You teleported to the police duty position");
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
		}
		return 1;
	}
	if(strcmp(cmd, "/agotogovdutypos", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SetPlayerPos(playerid,GovernmentDutyPosition[X],GovernmentDutyPosition[Y],GovernmentDutyPosition[Z]);
			SetPlayerInterior(playerid,GovernmentDutyPosition[Interior]);
			SetPlayerVirtualWorld(playerid,GovernmentDutyPosition[World]);
			SetPlayerFacingAngle(playerid,GovernmentDutyPosition[Angle]);
			SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You teleported to the government duty position");
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
		}
		return 1;
	}
  	if(strcmp(cmd, "/agotofmatsstorage", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SetPlayerPos(playerid,FactionMaterialsStorage[X],FactionMaterialsStorage[Y],FactionMaterialsStorage[Z]);
			SetPlayerInterior(playerid,FactionMaterialsStorage[Interior]);
			SetPlayerVirtualWorld(playerid,FactionMaterialsStorage[World]);
			SetPlayerFacingAngle(playerid,FactionMaterialsStorage[Angle]);
			SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You teleported to the faction materials storage location");
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
		}
		return 1;
	}
	if(strcmp(cmd, "/afactionmatsstorage", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		FactionMaterialsStorage[X] = x;
		FactionMaterialsStorage[Y] = y;
		FactionMaterialsStorage[Z] = z;
		FactionMaterialsStorage[World] = GetPlayerVirtualWorld(playerid);
		FactionMaterialsStorage[Interior] = GetPlayerInterior(playerid);
		FactionMaterialsStorage[Angle] = angle;
  		MoveStreamPickup(FactionMaterialsStorage[PickupID],FactionMaterialsStorage[X],FactionMaterialsStorage[Y],FactionMaterialsStorage[Z]);
		SaveFactionMaterialsStorage();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Faction Materials Storage");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
 	if(strcmp(cmd, "/agotofdrugsstorage", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SetPlayerPos(playerid,FactionDrugsStorage[X],FactionDrugsStorage[Y],FactionDrugsStorage[Z]);
			SetPlayerInterior(playerid,FactionDrugsStorage[Interior]);
			SetPlayerVirtualWorld(playerid,FactionDrugsStorage[World]);
			SetPlayerFacingAngle(playerid,FactionDrugsStorage[Angle]);
			SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You teleported to the faction drugs storage location");
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
		}
		return 1;
	}
 	if(strcmp(cmd, "/afactiondrugsstorage", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		FactionDrugsStorage[X] = x;
		FactionDrugsStorage[Y] = y;
		FactionDrugsStorage[Z] = z;
		FactionDrugsStorage[World] = GetPlayerVirtualWorld(playerid);
		FactionDrugsStorage[Interior] = GetPlayerInterior(playerid);
		FactionDrugsStorage[Angle] = angle;
  		MoveStreamPickup(FactionDrugsStorage[PickupID],FactionDrugsStorage[X],FactionDrugsStorage[Y],FactionDrugsStorage[Z]);
		SaveFactionDrugsStorage();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Faction Drugs Storage");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
	if(strcmp(cmd, "/abankpos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		BankPosition[X] = x;
		BankPosition[Y] = y;
		BankPosition[Z] = z;
		BankPosition[World] = GetPlayerVirtualWorld(playerid);
		BankPosition[Interior] = GetPlayerInterior(playerid);
		BankPosition[Angle] = angle;
  		MoveStreamPickup(BankPosition[PickupID],BankPosition[X],BankPosition[Y],BankPosition[Z]);
		SaveBankPosition();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Bank Position");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
 	if(strcmp(cmd, "/adetectivejobpos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		DetectiveJobPosition[X] = x;
		DetectiveJobPosition[Y] = y;
		DetectiveJobPosition[Z] = z;
		DetectiveJobPosition[World] = GetPlayerVirtualWorld(playerid);
		DetectiveJobPosition[Interior] = GetPlayerInterior(playerid);
		DetectiveJobPosition[Angle] = angle;
  		MoveStreamPickup(DetectiveJobPosition[PickupID],DetectiveJobPosition[X],DetectiveJobPosition[Y],DetectiveJobPosition[Z]);
		SaveDetectiveJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Detective Job Position");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
  	if(strcmp(cmd, "/alawyerjobpos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		LawyerJobPosition[X] = x;
		LawyerJobPosition[Y] = y;
		LawyerJobPosition[Z] = z;
		LawyerJobPosition[World] = GetPlayerVirtualWorld(playerid);
		LawyerJobPosition[Interior] = GetPlayerInterior(playerid);
		LawyerJobPosition[Angle] = angle;
  		MoveStreamPickup(LawyerJobPosition[PickupID],LawyerJobPosition[X],LawyerJobPosition[Y],LawyerJobPosition[Z]);
		SaveLawyerJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Lawyer Job Position");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
	if(strcmp(cmd, "/amechanicjobpos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		MechanicJobPosition[X] = x;
		MechanicJobPosition[Y] = y;
		MechanicJobPosition[Z] = z;
		MechanicJobPosition[World] = GetPlayerVirtualWorld(playerid);
		MechanicJobPosition[Interior] = GetPlayerInterior(playerid);
		MechanicJobPosition[Angle] = angle;
  		MoveStreamPickup(MechanicJobPosition[PickupID], MechanicJobPosition[X], MechanicJobPosition[Y], MechanicJobPosition[Z]);
		SaveMechanicJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Mechanic Job Position");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
	if(strcmp(cmd, "/adrugjobpos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		DrugJob[TakeJobX] = x;
		DrugJob[TakeJobY] = y;
		DrugJob[TakeJobZ] = z;
		DrugJob[TakeJobWorld] = GetPlayerVirtualWorld(playerid);
		DrugJob[TakeJobInterior] = GetPlayerInterior(playerid);
		DrugJob[TakeJobAngle] = angle;
  		MoveStreamPickup(DrugJob[TakeJobPickupID],DrugJob[TakeJobX],DrugJob[TakeJobY],DrugJob[TakeJobZ]);
		SaveDrugJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Drug Job Position");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
   	if(strcmp(cmd, "/adrugjobpos2", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		DrugJob[BuyDrugsX] = x;
		DrugJob[BuyDrugsY] = y;
		DrugJob[BuyDrugsZ] = z;
		DrugJob[BuyDrugsWorld] = GetPlayerVirtualWorld(playerid);
		DrugJob[BuyDrugsInterior] = GetPlayerInterior(playerid);
		DrugJob[BuyDrugsAngle] = angle;
  		MoveStreamPickup(DrugJob[BuyDrugsPickupID],DrugJob[BuyDrugsX],DrugJob[BuyDrugsY],DrugJob[BuyDrugsZ]);
		SaveDrugJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Drug Job Buy Position");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
   	if(strcmp(cmd, "/adrugjobpos3", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		DrugJob[DeliverX] = x;
		DrugJob[DeliverY] = y;
		DrugJob[DeliverZ] = z;
		DrugJob[DeliverWorld] = GetPlayerVirtualWorld(playerid);
		DrugJob[DeliverInterior] = GetPlayerInterior(playerid);
		DrugJob[DeliverAngle] = angle;
  		MoveStreamPickup(DrugJob[DeliverPickupID],DrugJob[DeliverX],DrugJob[DeliverY],DrugJob[DeliverZ]);
		SaveDrugJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Drug Job Deliver Position");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
  	if(strcmp(cmd, "/aproductjobpos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		ProductsSellerJob[TakeJobX] = x;
		ProductsSellerJob[TakeJobY] = y;
		ProductsSellerJob[TakeJobZ] = z;
		ProductsSellerJob[TakeJobWorld] = GetPlayerVirtualWorld(playerid);
		ProductsSellerJob[TakeJobInterior] = GetPlayerInterior(playerid);
		ProductsSellerJob[TakeJobAngle] = angle;
  		MoveStreamPickup(ProductsSellerJob[TakeJobPickupID],ProductsSellerJob[TakeJobX],ProductsSellerJob[TakeJobY],ProductsSellerJob[TakeJobZ]);
		SaveProductsSellerJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Products Seller Job Position");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
   	if(strcmp(cmd, "/aproductjobpos2", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		ProductsSellerJob[BuyProductsX] = x;
		ProductsSellerJob[BuyProductsY] = y;
		ProductsSellerJob[BuyProductsZ] = z;
		ProductsSellerJob[BuyProductsWorld] = GetPlayerVirtualWorld(playerid);
		ProductsSellerJob[BuyProductsInterior] = GetPlayerInterior(playerid);
		ProductsSellerJob[BuyProductsAngle] = angle;
    	MoveStreamPickup(ProductsSellerJob[BuyProductsPickupID],ProductsSellerJob[BuyProductsX],ProductsSellerJob[BuyProductsY],ProductsSellerJob[BuyProductsZ]);
		SaveProductsSellerJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Products Seller Job. (buy products place)");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
 	if(strcmp(cmd, "/agunjobpos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		GunJob[TakeJobX] = x;
		GunJob[TakeJobY] = y;
		GunJob[TakeJobZ] = z;
		GunJob[TakeJobWorld] = GetPlayerVirtualWorld(playerid);
		GunJob[TakeJobInterior] = GetPlayerInterior(playerid);
		GunJob[TakeJobAngle] = angle;
  		MoveStreamPickup(GunJob[TakeJobPickupID],GunJob[TakeJobX],GunJob[TakeJobY],GunJob[TakeJobZ]);
		SaveGunJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Gun Job Position");
 	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
  	if(strcmp(cmd, "/agunjobpos2", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		GunJob[BuyPackagesX] = x;
		GunJob[BuyPackagesY] = y;
		GunJob[BuyPackagesZ] = z;
		GunJob[BuyPackagesWorld] = GetPlayerVirtualWorld(playerid);
		GunJob[BuyPackagesInterior] = GetPlayerInterior(playerid);
		GunJob[BuyPackagesAngle] = angle;
  		MoveStreamPickup(GunJob[BuyPackagesPickupID],GunJob[BuyPackagesX],GunJob[BuyPackagesY],GunJob[BuyPackagesZ]);
		SaveGunJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Gun Job Materials Packages Buy Position");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
  	if(strcmp(cmd, "/agunjobpos3", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		GunJob[DeliverX] = x;
		GunJob[DeliverY] = y;
		GunJob[DeliverZ] = z;
		GunJob[DeliverWorld] = GetPlayerVirtualWorld(playerid);
		GunJob[DeliverInterior] = GetPlayerInterior(playerid);
		GunJob[DeliverAngle] = angle;
  		MoveStreamPickup(GunJob[DeliverPickupID],GunJob[DeliverX],GunJob[DeliverY],GunJob[DeliverZ]);
		SaveGunJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Gun Job Materials Deliver Position");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
	if(strcmp(cmd, "/agotoweaponlicpos", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SetPlayerPos(playerid,WeaponLicensePosition[X],WeaponLicensePosition[Y],WeaponLicensePosition[Z]);
			SetPlayerInterior(playerid,WeaponLicensePosition[Interior]);
			SetPlayerVirtualWorld(playerid,WeaponLicensePosition[World]);
			SetPlayerFacingAngle(playerid,WeaponLicensePosition[Angle]);
			SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You teleported to the weapon license position");
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
		}
		return 1;
	}
	if(strcmp(cmd, "/aweaponlicensepos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		WeaponLicensePosition[X] = x;
		WeaponLicensePosition[Y] = y;
		WeaponLicensePosition[Z] = z;
		WeaponLicensePosition[World] = GetPlayerVirtualWorld(playerid);
		WeaponLicensePosition[Interior] = GetPlayerInterior(playerid);
		WeaponLicensePosition[Angle] = angle;
  		MoveStreamPickup(WeaponLicensePosition[PickupID],WeaponLicensePosition[X],WeaponLicensePosition[Y],WeaponLicensePosition[Z]);
		SaveWeaponLicensePosition();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Weapon License Position");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
   	if(strcmp(cmd, "/aflyingtestpos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		FlyingTestPosition[X] = x;
		FlyingTestPosition[Y] = y;
		FlyingTestPosition[Z] = z;
		FlyingTestPosition[World] = GetPlayerVirtualWorld(playerid);
		FlyingTestPosition[Interior] = GetPlayerInterior(playerid);
		FlyingTestPosition[Angle] = angle;
  		MoveStreamPickup(FlyingTestPosition[PickupID],FlyingTestPosition[X],FlyingTestPosition[Y],FlyingTestPosition[Z]);
		SaveFlyingTestPosition();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Flying Test Position");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
  	if(strcmp(cmd, "/adrivingtestpos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		DrivingTestPosition[X] = x;
		DrivingTestPosition[Y] = y;
		DrivingTestPosition[Z] = z;
		DrivingTestPosition[World] = GetPlayerVirtualWorld(playerid);
		DrivingTestPosition[Interior] = GetPlayerInterior(playerid);
		DrivingTestPosition[Angle] = angle;
		MoveStreamPickup(DrivingTestPosition[PickupID],DrivingTestPosition[X],DrivingTestPosition[Y],DrivingTestPosition[Z]);
		SaveDrivingTestPosition();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Driving Test Position");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
 	if(strcmp(cmd, "/apolicearrestpos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		PoliceArrestPosition[X] = x;
		PoliceArrestPosition[Y] = y;
		PoliceArrestPosition[Z] = z;
		PoliceArrestPosition[World] = GetPlayerVirtualWorld(playerid);
		PoliceArrestPosition[Interior] = GetPlayerInterior(playerid);
		PoliceArrestPosition[Angle] = angle;
		SavePoliceArrestPosition();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Police Arrest Position");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
	if(strcmp(cmd, "/agovarrestpos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		GovernmentArrestPosition[X] = x;
		GovernmentArrestPosition[Y] = y;
		GovernmentArrestPosition[Z] = z;
		GovernmentArrestPosition[World] = GetPlayerVirtualWorld(playerid);
		GovernmentArrestPosition[Interior] = GetPlayerInterior(playerid);
		GovernmentArrestPosition[Angle] = angle;
		SaveGovernmentArrestPosition();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Government Arrest Position");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
  	if(strcmp(cmd, "/apolicedutypos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		PoliceDutyPosition[X] = x;
		PoliceDutyPosition[Y] = y;
		PoliceDutyPosition[Z] = z;
		PoliceDutyPosition[World] = GetPlayerVirtualWorld(playerid);
		PoliceDutyPosition[Interior] = GetPlayerInterior(playerid);
		PoliceDutyPosition[Angle] = angle;
		SavePoliceDutyPosition();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Police Duty Position");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
	if(strcmp(cmd, "/agovdutypos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		GovernmentDutyPosition[X] = x;
		GovernmentDutyPosition[Y] = y;
		GovernmentDutyPosition[Z] = z;
		GovernmentDutyPosition[World] = GetPlayerVirtualWorld(playerid);
		GovernmentDutyPosition[Interior] = GetPlayerInterior(playerid);
		GovernmentDutyPosition[Angle] = angle;
		SaveGovernmentDutyPosition();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Government Duty Position");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
	if(strcmp(cmd, "/acivilianspawn", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		CivilianSpawn[X] = x;
		CivilianSpawn[Y] = y;
		CivilianSpawn[Z] = z;
		CivilianSpawn[World] = GetPlayerVirtualWorld(playerid);
		CivilianSpawn[Interior] = GetPlayerInterior(playerid);
		CivilianSpawn[Angle] = angle;
		SaveCivilianSpawn();
		SendClientMessage(playerid, COLOR_ADMINCMD, "(INFO) You have successfully set the Civilian Spawnpoint");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	}
	return 1;
	}
	//==========================================================================
 	if(strcmp(cmd, "/afactionspawn", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionspawn [factionid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				new Float:x,Float:y,Float:z;
				GetPlayerPos(playerid, x, y, z);
				DynamicFactions[id][fX] = x;
				DynamicFactions[id][fY] = y;
				DynamicFactions[id][fZ] = z;
				SaveDynamicFactions();
				format(string, sizeof(string), "(INFO) You have set faction ID: %d's spawnpoint", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/aresetfaction", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /aresetfaction [factionid]");
				return 1;
			}
			new factionid = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				new rank;
				format(string, sizeof(string), "Faction%d",factionid);
				strmid(DynamicFactions[factionid][fName], string, 0, strlen(string), 255);
				DynamicFactions[factionid][fX] = 0.0;
				DynamicFactions[factionid][fY] = 0.0;
				DynamicFactions[factionid][fZ] = 0.0;
				DynamicFactions[factionid][fMaterials] = 0;
				DynamicFactions[factionid][fDrugs] = 0;
				DynamicFactions[factionid][fBank] = 0;
				rank = 1; format(string, sizeof(string), "Rank%d",rank); strmid(DynamicFactions[factionid][fRank1], string, 0, strlen(string), 255);
				rank ++; format(string, sizeof(string), "Rank%d",rank); strmid(DynamicFactions[factionid][fRank2], string, 0, strlen(string), 255);
				rank ++; format(string, sizeof(string), "Rank%d",rank); strmid(DynamicFactions[factionid][fRank3], string, 0, strlen(string), 255);
				rank ++; format(string, sizeof(string), "Rank%d",rank); strmid(DynamicFactions[factionid][fRank4], string, 0, strlen(string), 255);
				rank ++; format(string, sizeof(string), "Rank%d",rank); strmid(DynamicFactions[factionid][fRank5], string, 0, strlen(string), 255);
				rank ++; format(string, sizeof(string), "Rank%d",rank); strmid(DynamicFactions[factionid][fRank6], string, 0, strlen(string), 255);
				rank ++; format(string, sizeof(string), "Rank%d",rank); strmid(DynamicFactions[factionid][fRank7], string, 0, strlen(string), 255);
				rank ++; format(string, sizeof(string), "Rank%d",rank); strmid(DynamicFactions[factionid][fRank8], string, 0, strlen(string), 255);
				rank ++; format(string, sizeof(string), "Rank%d",rank); strmid(DynamicFactions[factionid][fRank9], string, 0, strlen(string), 255);
				rank ++; format(string, sizeof(string), "Rank%d",rank); strmid(DynamicFactions[factionid][fRank10], string, 0, strlen(string), 255);
				DynamicFactions[factionid][fSkin1] = 0;
				DynamicFactions[factionid][fSkin2] = 0;
				DynamicFactions[factionid][fSkin3] = 0;
				DynamicFactions[factionid][fSkin4] = 0;
				DynamicFactions[factionid][fSkin5] = 0;
				DynamicFactions[factionid][fSkin6] = 0;
				DynamicFactions[factionid][fSkin7] = 0;
				DynamicFactions[factionid][fSkin8] = 0;
				DynamicFactions[factionid][fSkin9] = 0;
				DynamicFactions[factionid][fSkin10] = 0;
				DynamicFactions[factionid][fJoinRank] = 0;
				DynamicFactions[factionid][fUseSkins] = 0;
				DynamicFactions[factionid][fType] = 0;
				DynamicFactions[factionid][fRankAmount] = 0;
				DynamicFactions[factionid][fUseColor] = 0;
				format(string, sizeof(string), "0xFFFFFFFF");
				strmid(DynamicFactions[factionid][fColor], string, 0, strlen(string), 255);
				format(string, sizeof(string), "(INFO) You have reset Faction ID: %d", factionid);
				SendClientMessage(playerid, COLOR_ADMINCMD, string);
				SaveDynamicFactions();
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactioncolor", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactioncolor [factionid] [hex]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
					idx++;
				}
				new offset = idx;
				new result[128];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
					result[idx - offset] = cmdtext[idx];
					idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactioncolour [factionid] [hex]");
					return 1;
				}
				if(strfind( result , "|" , true ) == -1)
    			{
		   			strmid(DynamicFactions[id][fColor], (result), 0, strlen((result)), 128);
					format(string, sizeof(string), "(INFO) You have set faction ID: %d's colour to %s", id,(result));
					SendClientMessage(playerid, COLOR_ADMINCMD, string);
					SaveDynamicFactions();
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid symbol, | is not allowed");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactionname", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionname [factionid] [name]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
					idx++;
				}
				new offset = idx;
				new result[128];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
					result[idx - offset] = cmdtext[idx];
					idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionname [factionid] [name]");
					return 1;
				}
				if(strfind( result , "|" , true ) == -1)
    			{
		   			strmid(DynamicFactions[id][fName], (result), 0, strlen((result)), 128);
					format(string, sizeof(string), "(INFO) You have set faction ID: %d's name to %s", id,(result));
					SendClientMessage(playerid, COLOR_ADMINCMD, string);
					SaveDynamicFactions();
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid symbol, | is not allowed");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
  	if(strcmp(cmd, "/agotofaction", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /agotofaction [id]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				SetPlayerPos(playerid,DynamicFactions[id][fX],DynamicFactions[id][fY],DynamicFactions[id][fZ]);
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
				new form[128];
				format(form, sizeof(form), "(INFO) You teleported to faction ID: %d", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactiontype", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactiontype [factionid] [type (Numeric)]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactiontype [factionid] [type (Numeric)]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					DynamicFactions[id][fType] = id2;
					new form[128];
					format(form, sizeof form, "(INFO) You have set Faction ID: %d's Type to %d", id,id2);
					SendClientMessage(playerid, COLOR_ADMINCMD,form);
					SaveDynamicFactions();
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactionjoinrank", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionjoinrank [factionid] [2-10]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionjoinrank [factionid] [2-10]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					if(id2 >= 2 && id2 <= 10)
					{
	  					DynamicFactions[id][fJoinRank] = id2;
						new form[128];
						format(form, sizeof form, "(INFO) You have set Faction ID: %d's JoinRank to %d", id,id2);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactionbank", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionbank [factionid] [amount]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionbank [factionid] [amount]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					DynamicFactions[id][fBank] = id2;
					new form[128];
					format(form, sizeof form, "(INFO) You have set Faction ID: %d's Bank to %d", id,id2);
					SendClientMessage(playerid, COLOR_ADMINCMD,form);
					SaveDynamicFactions();
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactiondrugs", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactiondrugs [factionid] [amount]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactiondrugs [factionid] [amount]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					DynamicFactions[id][fDrugs] = id2;
					new form[128];
					format(form, sizeof form, "(INFO) You have set Faction ID: %d's Drugs to %d", id,id2);
					SendClientMessage(playerid, COLOR_ADMINCMD,form);
					SaveDynamicFactions();
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactionmats", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionmats [factionid] [amount]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionmats [factionid] [amount]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					DynamicFactions[id][fMaterials] = id2;
					new form[128];
					format(form, sizeof form, "(INFO) You have set Faction ID: %d's Materials to %d", id,id2);
					SendClientMessage(playerid, COLOR_ADMINCMD,form);
					SaveDynamicFactions();
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactionrankamount", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionrankamount [factionid] [2-10]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionrankamount [factionid] [2-10]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					if(id2 >= 2 && id2 <= 10)
					{
	  					DynamicFactions[id][fRankAmount] = id2;
						new form[128];
						format(form, sizeof form, "(INFO) You have set Faction ID: %d's RankAmount to %d", id,id2);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactionrankname", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionrankname [factionid] [Rank ID - 1-10] [Name]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionrankname [factionid] [Rank ID - 1-10] [Name]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

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
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionrankname [factionid] [Rank ID - 1-10] [Name]");
						return 1;
					}
  					if(strfind( result , "|" , true ) == -1)
    				{
						if(id2 == 1)
						{
				   			strmid(DynamicFactions[id][fRank1], (result), 0, strlen((result)), 128);
							format(string, sizeof(string), "(INFO) You have set faction ID: %d's Rank: %d's name to: %s", id,id2,result);
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							SaveDynamicFactions();
						}
						else if(id2 == 2)
						{
				   			strmid(DynamicFactions[id][fRank2], (result), 0, strlen((result)), 128);
							format(string, sizeof(string), "(INFO) You have set faction ID: %d's Rank: %d's name to: %s", id,id2,result);
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							SaveDynamicFactions();
						}
						else if(id2 == 3)
						{
				   			strmid(DynamicFactions[id][fRank3], (result), 0, strlen((result)), 128);
							format(string, sizeof(string), "(INFO) You have set faction ID: %d's Rank: %d's name to: %s", id,id2,result);
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							SaveDynamicFactions();
						}
						else if(id2 == 4)
						{
				   			strmid(DynamicFactions[id][fRank4], (result), 0, strlen((result)), 128);
							format(string, sizeof(string), "(INFO) You have set faction ID: %d's Rank: %d's name to: %s", id,id2,result);
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							SaveDynamicFactions();
						}
						else if(id2 == 5)
						{
				   			strmid(DynamicFactions[id][fRank5], (result), 0, strlen((result)), 128);
							format(string, sizeof(string), "(INFO) You have set faction ID: %d's Rank: %d's name to: %s", id,id2,result);
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							SaveDynamicFactions();
						}
						else if(id2 == 6)
						{
				   			strmid(DynamicFactions[id][fRank6], (result), 0, strlen((result)), 128);
							format(string, sizeof(string), "(INFO) You have set faction ID: %d's Rank: %d's name to: %s", id,id2,result);
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							SaveDynamicFactions();
						}
						else if(id2 == 7)
						{
				   			strmid(DynamicFactions[id][fRank7], (result), 0, strlen((result)), 128);
							format(string, sizeof(string), "(INFO) You have set faction ID: %d's Rank: %d's name to: %s", id,id2,result);
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							SaveDynamicFactions();
						}
						else if(id2 == 8)
						{
				   			strmid(DynamicFactions[id][fRank8], (result), 0, strlen((result)), 128);
							format(string, sizeof(string), "(INFO) You have set faction ID: %d's Rank: %d's name to: %s", id,id2,result);
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							SaveDynamicFactions();
						}
						else if(id2 == 9)
						{
				   			strmid(DynamicFactions[id][fRank9], (result), 0, strlen((result)), 128);
							format(string, sizeof(string), "(INFO) You have set faction ID: %d's Rank: %d's name to: %s", id,id2,result);
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							SaveDynamicFactions();
						}
						else if(id2 == 10)
						{
				   			strmid(DynamicFactions[id][fRank10], (result), 0, strlen((result)), 128);
							format(string, sizeof(string), "(INFO) You have set faction ID: %d's Rank: %d's name to: %s", id,id2,result);
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							SaveDynamicFactions();
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid symbol, | is not allowed");
					}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactionskin", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionskin [factionid] [Rank ID - 1-10] [Skinid]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionskin [factionid] [Rank ID - 1-10] [Skinid]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionskin [factionid] [Rank ID - 1-10] [Skinid]");
						return 1;
					}
					new id3;
					id3 = strval(tmp);

					if(id2 == 1)
					{
	  					DynamicFactions[id][fSkin1] = id3;
						new form[128];
						format(form, sizeof form, "(INFO) You have set Faction ID: %d's Rank %d Skin to %d", id,id2,id3);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
					else if(id2 == 2)
					{
	  					DynamicFactions[id][fSkin2] = id3;
						new form[128];
						format(form, sizeof form, "(INFO) You have set Faction ID: %d's Rank %d Skin to %d", id,id2,id3);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
					else if(id2 == 3)
					{
	  					DynamicFactions[id][fSkin3] = id3;
						new form[128];
						format(form, sizeof form, "(INFO) You have set Faction ID: %d's Rank %d Skin to %d", id,id2,id3);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
					else if(id2 == 4)
					{
	  					DynamicFactions[id][fSkin4] = id3;
						new form[128];
						format(form, sizeof form, "(INFO) You have set Faction ID: %d's Rank %d Skin to %d", id,id2,id3);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
					else if(id2 == 5)
					{
	  					DynamicFactions[id][fSkin5] = id3;
						new form[128];
						format(form, sizeof form, "(INFO) You have set Faction ID: %d's Rank %d Skin to %d", id,id2,id3);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
					else if(id2 == 6)
					{
	  					DynamicFactions[id][fSkin6] = id3;
						new form[128];
						format(form, sizeof form, "(INFO) You have set Faction ID: %d's Rank %d Skin to %d", id,id2,id3);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
					else if(id2 == 7)
					{
	  					DynamicFactions[id][fSkin7] = id3;
						new form[128];
						format(form, sizeof form, "(INFO) You have set Faction ID: %d's Rank %d Skin to %d", id,id2,id3);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
					else if(id2 == 8)
					{
	  					DynamicFactions[id][fSkin8] = id3;
						new form[128];
						format(form, sizeof form, "(INFO) You have set Faction ID: %d's Rank %d Skin to %d", id,id2,id3);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
					else if(id2 == 9)
					{
	  					DynamicFactions[id][fSkin9] = id3;
						new form[128];
						format(form, sizeof form, "(INFO) You have set Faction ID: %d's Rank %d Skin to %d", id,id2,id3);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
					else if(id2 == 10)
					{
	  					DynamicFactions[id][fSkin10] = id3;
						new form[128];
						format(form, sizeof form, "(INFO) You have set Faction ID: %d's Rank %d Skin to %d", id,id2,id3);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/afactionusecolor", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionusecolor [factionid]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
					new id;
					id = strval(tmp);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionusecolor [factionid]");
						return 1;
					}
					if(DynamicFactions[id][fUseColor])
					{
	  					DynamicFactions[id][fUseColor] = 0;
						new form[128];
						format(form, sizeof form, "(INFO) Faction ID: %d's color disabled", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
				    	SendFactionMessage(id, COLOR_LIGHTBLUE, "(FACTION) Faction color's disabled by an administrator");
						SaveDynamicFactions();

						for(new i=0;i<MAX_PLAYERS;i++)
						{
					    	if(IsPlayerConnected(i))
					       	{
								if(PlayerInfo[i][pFaction] == id)
								{
									SetPlayerColor(i,COLOR_CIVILIAN);
								}
					       	}
				       	}
					}
					else
					{
	  					DynamicFactions[id][fUseColor] = 1;
						new form[128];
						format(form, sizeof form, "(INFO) Faction ID: %d's color enabled", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SendFactionMessage(id, COLOR_LIGHTBLUE, "(FACTION) Faction color's enabled by an administrator");
						SaveDynamicFactions();

  						for(new i=0;i<MAX_PLAYERS;i++)
						{
					    	if(IsPlayerConnected(i))
					       	{
								if(PlayerInfo[i][pFaction] == id)
								{
         							SetPlayerToFactionColor(i);
								}
					       	}
				       	}
					}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactionuseskins", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionuseskins [factionid]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
					new id;
					id = strval(tmp);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /afactionuseskins [factionid]");
						return 1;
					}

					if(DynamicFactions[id][fUseSkins])
					{
	  					DynamicFactions[id][fUseSkins] = 0;
						new form[128];
						format(form, sizeof form, "(INFO) Faction ID: %d's skin's disabled", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
				    	SendFactionMessage(id, COLOR_LIGHTBLUE, "(FACTION) Faction skin's disabled by an administrator");
						SaveDynamicFactions();

					}
					else
					{
	  					DynamicFactions[id][fUseSkins] = 1;
						new form[128];
						format(form, sizeof form, "(INFO) Faction ID: %d's skin's enabled", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SendFactionMessage(id, COLOR_LIGHTBLUE, "(FACTION) Faction skin's enabled by an administrator");
						SaveDynamicFactions();

						for(new i=0;i<MAX_PLAYERS;i++)
						{
					    	if(IsPlayerConnected(i))
					       	{
								if(PlayerInfo[i][pFaction] == id)
								{
									SetPlayerToFactionSkin(i);
								}
					       	}
				       	}
					}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
			}
		}
		return 1;
	}
	//==========================================================================
   	if(strcmp(cmd, "/radio", true) == 0 || strcmp(cmd, "/r", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new wstring[128];
			new faction = PlayerInfo[playerid][pFaction];
			new rank = PlayerInfo[playerid][pRank];
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) (/r)adio");
				return 1;
			}
			if(Muted[playerid])
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not use the radio, You are muted");
				return 1;
			}
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
					if(CopOnDuty[playerid])
					{
				 		if(rank == 1)
						{
						    format(wstring, sizeof(wstring), "(RADIO) %s %s: %s, over",DynamicFactions[faction][fRank1],GetPlayerNameEx(playerid),result);
						    SendFactionTypeMessage(1, COLOR_LSPD, wstring);
						    FactionChatLog(wstring);
						}
				 		else if(rank == 2)
						{
						    format(wstring, sizeof(wstring), "(RADIO) %s %s: %s, over",DynamicFactions[faction][fRank2],GetPlayerNameEx(playerid),result);
						    SendFactionTypeMessage(1, COLOR_LSPD, wstring);
						    FactionChatLog(wstring);
						}
				 		else if(rank == 3)
						{
						    format(wstring, sizeof(wstring), "(RADIO) %s %s: %s, over",DynamicFactions[faction][fRank3],GetPlayerNameEx(playerid),result);
						    SendFactionTypeMessage(1, COLOR_LSPD, wstring);
						    FactionChatLog(wstring);
						}
				 		else if(rank == 4)
						{
							format(wstring, sizeof(wstring), "(RADIO) %s %s: %s, over",DynamicFactions[faction][fRank4],GetPlayerNameEx(playerid),result);
						    SendFactionTypeMessage(1, COLOR_LSPD, wstring);
						    FactionChatLog(wstring);
						}
				 		else if(rank == 5)
						{
						    format(wstring, sizeof(wstring), "(RADIO) %s %s: %s, over",DynamicFactions[faction][fRank5],GetPlayerNameEx(playerid),result);
						    SendFactionTypeMessage(1, COLOR_LSPD, wstring);
						    FactionChatLog(wstring);
						}
				 		else if(rank == 6)
						{
						    format(wstring, sizeof(wstring), "(RADIO) %s %s: %s, over",DynamicFactions[faction][fRank6],GetPlayerNameEx(playerid),result);
						    SendFactionTypeMessage(1, COLOR_LSPD, wstring);
						    FactionChatLog(wstring);
						}
				 		else if(rank == 7)
						{
						    format(wstring, sizeof(wstring), "(RADIO) %s %s: %s, over",DynamicFactions[faction][fRank7],GetPlayerNameEx(playerid),result);
						    SendFactionTypeMessage(1, COLOR_LSPD, wstring);
						    FactionChatLog(wstring);
						}
				 		else if(rank == 8)
						{
						    format(wstring, sizeof(wstring), "(RADIO) %s %s: %s, over",DynamicFactions[faction][fRank8],GetPlayerNameEx(playerid),result);
						    SendFactionTypeMessage(1, COLOR_LSPD, wstring);
						    FactionChatLog(wstring);
						}
				 		else if(rank == 9)
						{
						    format(wstring, sizeof(wstring), "(RADIO) %s %s: %s, over",DynamicFactions[faction][fRank9],GetPlayerNameEx(playerid),result);
						    SendFactionTypeMessage(1, COLOR_LSPD, wstring);
						    FactionChatLog(wstring);
						}
				 		else if(rank == 10)
						{
						    format(wstring, sizeof(wstring), "(RADIO) %s %s: %s, over",DynamicFactions[faction][fRank10],GetPlayerNameEx(playerid),result);
						    SendFactionTypeMessage(1, COLOR_LSPD, wstring);
						    FactionChatLog(wstring);
						}
					}
		     		else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not on duty");
     				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/policeduty", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
				if (PlayerToPoint(5.0,playerid,PoliceDutyPosition[X],PoliceDutyPosition[Y],PoliceDutyPosition[Z]))
				{
				    if(GetPlayerVirtualWorld(playerid) == PoliceDutyPosition[World])
				    {
						if(CopOnDuty[playerid] == 0)
				        {
				            if(PlayerInfo[playerid][pSex] == 1)
				            {
								PlayerActionMessage(playerid,15.0,"clocks in as a police officer, and takes his equipment from the locker");
							}
							else
							{
							    PlayerActionMessage(playerid,15.0,"clocks in as a police officer, and takes her equipment from the locker");
							}
							SetPlayerArmour(playerid,100);
							SafeGivePlayerWeapon(playerid, 3, 0);
							SafeGivePlayerWeapon(playerid, 24, 70);
							SafeGivePlayerWeapon(playerid, 41, 700);
							SafeGivePlayerWeapon(playerid, 29, 400);
							SafeGivePlayerWeapon(playerid, 25, 50);
							CopOnDuty[playerid] = 1;
							SetPlayerToFactionSkin(playerid);
							SetPlayerToFactionColor(playerid);
							format(string, sizeof(string), "(LSPD) %s is now an on duty police officer",GetPlayerNameEx(playerid));
		    				SendFactionTypeMessage(1, COLOR_LSPD, string);
							return 1;
						}
						else
						{
      						if(PlayerInfo[playerid][pSex] == 1)
				            {
								PlayerActionMessage(playerid,15.0,"clocks out as a police officer, and puts his equipment in the locker");
							}
							else
							{
							    PlayerActionMessage(playerid,15.0,"clocks out as a police officer, and puts her equipment in the locker");
							}
							CopOnDuty[playerid] = 0;
							SetPlayerToFactionSkin(playerid);
							SafeResetPlayerWeapons(playerid);
							SetPlayerColor(playerid,COLOR_CIVILIAN);
							return 1;
						}
					}
				}
    			else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the duty position");
					return 1;
				}
			}
   			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
				return 1;
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/govduty", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pFaction] == 6)
			{
				if (PlayerToPoint(5.0,playerid,GovernmentDutyPosition[X],GovernmentDutyPosition[Y],GovernmentDutyPosition[Z]))
				{
				    if(GetPlayerVirtualWorld(playerid) == GovernmentDutyPosition[World])
				    {
						if(CopOnDuty[playerid] == 0)
				        {
				            if(PlayerInfo[playerid][pSex] == 1)
				            {
								PlayerActionMessage(playerid,15.0,"clocks in, and takes his equipment from the locker");
							}
							else
							{
							    PlayerActionMessage(playerid,15.0,"clocks in, and takes her equipment from the locker");
							}
							SafeGivePlayerWeapon(playerid, 17, 10);
							SafeGivePlayerWeapon(playerid, 29, 280);
							SafeGivePlayerWeapon(playerid, 31, 400);
							SafeGivePlayerWeapon(playerid, 34, 50);
							SafeGivePlayerWeapon(playerid, 35, 20);
							CopOnDuty[playerid] = 1;
							SetPlayerToFactionSkin(playerid);
							SetPlayerToFactionColor(playerid);
							format(string, sizeof(string), "(GOVERNMENT) %s is now on duty",GetPlayerNameEx(playerid));
		    				SendFactionTypeMessage(1, COLOR_LSPD, string);
							return 1;
						}
						else
						{
      						if(PlayerInfo[playerid][pSex] == 1)
				            {
								PlayerActionMessage(playerid,15.0,"clocks out, and puts his equipment in the locker");
							}
							else
							{
							    PlayerActionMessage(playerid,15.0,"clocks out, and puts her equipment in the locker");
							}
							CopOnDuty[playerid] = 0;
							SetPlayerToFactionSkin(playerid);
							SafeResetPlayerWeapons(playerid);
							return 1;
						}
					}
				}
    			else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the duty position");
					return 1;
				}
			}
   			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
				return 1;
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/backup", true) == 0 || strcmp(cmd, "/bk", true) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
   			{
				if(CopOnDuty[playerid] == 0)
				{
 					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not on duty");
   					return 1;
  				}
				if (PlayerInfo[playerid][pRequestingBackup] != 1)
				{
					GetPlayerName(playerid, sendername, sizeof(sendername));
					new Float:L, Float:R, Float:E;
					GetPlayerPos(playerid, L, R, E);
					format(string, sizeof(string), "(RADIO) All units, %s is requesting immediate assistance, location marked on the map (red)", sendername);
					PlayerInfo[playerid][pRequestingBackup] = 1;
					for(new i = 0; i < MAX_PLAYERS; i++)
					{
						if(IsPlayerConnected(i))
						{
							if(PlayerInfo[i][pFaction] == 0 || PlayerInfo[i][pFaction] == 6)
							{
								SetPlayerCheckpoint(playerid, L, R, E-10, 1.0);
								SendClientMessage(i, COLOR_LSPD, string);
							}
						}
					}
					SendClientMessage(playerid, COLOR_WHITE, "(INFO) Type /backupclear or /bkc to clear your backup request");
					SetTimerEx("BackupClear", 180000, false, "ii", playerid, 1);
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You already have an active backup request");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/backupclear", true) == 0 || strcmp(cmd, "/bkc", true) == 0)
	{
		BackupClear(playerid, 0);
		return 1;
	}
	if(strcmp(cmd, "/detain", true) ==0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
   			{
				if(CopOnDuty[playerid] == 0)
				{
 					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not on duty");
   					return 1;
  				}
			    if(IsPlayerInAnyVehicle(playerid))
			    {
			        SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not use this whilst in a car");
			        return 1;
			    }
		   		tmp = strtok(cmdtext, idx);
				if (!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /detain [playerid/partofname] [seatid]");
					return 1;
				}
				new carid = gLastCar[playerid];
			    giveplayerid = ReturnUser(tmp);
			    if(IsPlayerConnected(giveplayerid))
				{
					if(giveplayerid != INVALID_PLAYER_ID)
					{
	    				/*if(giveplayerid == playerid)
						{
							SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not detain yourself");
							return 1;
						}*/
                        tmp = strtok(cmdtext, idx);
						new seat = strval(tmp);
						if(seat < 1 || seat > 3) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) The seat ID can not be above 3 or below 1"); return 1; }
						if (!strlen(tmp))
						{
							SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /detain [playerid/partofname] [seatid]");
							return 1;
						}
						if(!ProxDetectorS(8.0, playerid, giveplayerid))
						{
							SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
							return 1;
						}
						if(PlayerCuffed[giveplayerid] > 0)
						{
		 					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							GetPlayerName(playerid, sendername, sizeof(sendername));
							format(string, sizeof(string), "(INFO) You were detained by %s", sendername);
							SendClientMessage(giveplayerid, COLOR_WHITE, string);
							format(string, sizeof(string), "(INFO) You detained %s", giveplayer);
							SendClientMessage(playerid, COLOR_WHITE, string);
							format(string, sizeof(string), "%s grabs %s and throws him in the car", sendername ,giveplayer);
							ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							GameTextForPlayer(giveplayerid, "~r~BUSTED", 2500, 3);
							ClearAnimations(giveplayerid);
							TogglePlayerControllable(giveplayerid, 0);
							PutPlayerInVehicle(giveplayerid,carid,seat);
							PlayerCuffed[giveplayerid] = 1;
		            	}
						else
						{
					    	SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not cuffed");
					    	return 1;
						}
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			}
		}//not connected
	    return 1;
    }
   	if(strcmp(cmd, "/undetain", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
   			{
				if(CopOnDuty[playerid] == 0)
				{
 					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not on duty");
   					return 1;
  				}
			    tmp = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /undetain [playerid/partofname]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
				if(IsPlayerConnected(giveplayerid))
				{
					if(giveplayerid != INVALID_PLAYER_ID)
					{
					    if(giveplayerid == playerid)
						{
							SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not undetain yourself");
							return 1;
						}
					    if (ProxDetectorS(8.0, playerid, giveplayerid))
						{
							if(PlayerCuffed[giveplayerid] == 1)
							{
							    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
							    format(string, sizeof(string), "(INFO) You were undetained by %s", sendername);
								SendClientMessage(giveplayerid, COLOR_WHITE, string);
								format(string, sizeof(string), "(INFO) You undetained %s", giveplayer);
								SendClientMessage(playerid, COLOR_WHITE, string);
								TogglePlayerControllable(giveplayerid, 1);
								RemovePlayerFromVehicle(giveplayerid);
								TogglePlayerControllable(playerid, 1);
								PlayerCuffed[giveplayerid] = 0;
							}
							else
							{
							    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not detained");
							    return 1;
							}
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
						    return 1;
						}
					}
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not connected");
				    return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			}
		}//not connected
		return 1;
	}
	if(strcmp(cmdtext, "/roadblock", true) == 0 || strcmp(cmdtext, "/rb", true) == 0)
	{
  		if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] != 1)
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			return 1;
		}
		if(CopOnDuty[playerid] == 0)
		{
 			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not on duty");
			return 1;
		}
		if (PlayerInfo[playerid][pRoadblock] != 0) return SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can only deploy 1 roadblock at a time");
		if (roadblocktimer != 0) return SendClientMessage(playerid, COLOR_GREY, "(ERROR) Please wait before trying to spawn another roadblock");
		new Float:P, Float:B, Float:K, Float:F;
		GetPlayerPos(playerid, P, B, K);
		GetPlayerFacingAngle(playerid, F);
		PlayerInfo[playerid][pRoadblock] = CreateObject(981, P, B, K, 0.0, 0.0, F+180);
		SetPlayerPos(playerid, P, B, K+4);
		SendClientMessage(playerid, COLOR_WHITE, "(INFO) Roadblock deployed");
		roadblocktimer = 1;
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "(HQ) A roadblock has been deployed by %s, location marked on the map", sendername);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
				{
					SetPlayerCheckpoint(playerid, P, B, K-10, 1.0);
					SendClientMessage(i, COLOR_LSPD, string);
				}
			}
		}
		SetTimer("ResetRoadblockTimer", 60000, false);
		return 1;
	}
	if(strcmp(cmd, "/roadunblock", true) == 0 || strcmp(cmd, "/rrb", true) == 0)
	{
		if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] != 1)
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			return 1;
		}
		if (PlayerInfo[playerid][pRoadblock] == 0)
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You have not deployed a roadblock");
			return 1;
		}
		RemoveRoadblock(playerid);
		SendClientMessage(playerid, COLOR_WHITE, "(INFO) Roadblock removed");
		return 1;
	}
	if(strcmp(cmd, "/roadunblockall", true) == 0 || strcmp(cmd, "/allrrb", true) == 0)
	{
		if(PlayerInfo[playerid][pFaction] == 0 && PlayerInfo[playerid][pRank] == 1)
		{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(PlayerInfo[i][pRoadblock] != 0)
				{
					RemoveRoadblock(i);
				}
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "(HQ) All roadblocks in the area are to be disbanded immediately by order of %s", sendername);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
					{
						SendClientMessage(i, COLOR_LSPD, string);
					}
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not a leader");
		}
		return 1;
	}
	if(strcmp(cmd, "/allowcitizen", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pFaction] == 6)
	        {
		            tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
					    SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /allowcitizen [playerid/partofname]");
					    return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        GetPlayerName(playerid, sendername, sizeof(sendername));
					        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				            format(string, sizeof(string), "(INFO) You have given a Visitors Pass to %s",giveplayer);
					        SendClientMessage(playerid, COLOR_WHITE, string);
					        format(string, sizeof(string), "(INFO) %s has given you a Visitors Pass",sendername);
					        SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        PlayerInfo[giveplayerid][pVisitPass] = 1;
					        return 1;
						}
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not connected");
					    return 1;
					}

	        }
	        else
	        {
	            SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
	            return 1;
	        }
	    }
	    return 1;
	}
	if(strcmp(cmd, "/blockcitizen", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pFaction] == 6)
	        {
		            tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
					    SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /blockcitizen [playerid/partofname]");
					    return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        GetPlayerName(playerid, sendername, sizeof(sendername));
					        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				            format(string, sizeof(string), "(INFO) You have given a Visitors Pass to %s",giveplayer);
					        SendClientMessage(playerid, COLOR_WHITE, string);
					        format(string, sizeof(string), "(INFO) %s has taken away your Visitors Pass",sendername);
					        SendClientMessage(giveplayerid, COLOR_WHITE, string);
							SendClientMessage(playerid, COLOR_WHITE, "(INFO) You must leave the vicinity immediately");
					        PlayerInfo[giveplayerid][pVisitPass] = 0;
					        return 1;
						}
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not connected");
					    return 1;
					}

	        }
	        else
	        {
	            SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
	            return 1;
	        }
	    }
	    return 1;
	}
	if(strcmp(cmd, "/cctv", true) == 0)
	{
		if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
		{
			if(CopOnDuty[playerid] == 0)
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not on duty");
				return 1;
			}
   			if(!PlayerToPoint(3.0,playerid,1579.9551,-1634.8647,13.5616))
			{
   				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not near the cctv control booth");
   				return 1;
			}
		    PlayerMenu[playerid] = 0;
		    TogglePlayerControllable(playerid, 0);
			ShowMenuForPlayer(CCTVMenu[0], playerid);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
		}
		return 1;
	}
	if(strcmp(cmd, "/exitcctv", true) == 0)
	{
	    if(CurrentCCTV[playerid] > -1)
	    {
		    SetPlayerPos(playerid, LastPos[playerid][LX], LastPos[playerid][LY], LastPos[playerid][LZ]);
			SetPlayerFacingAngle(playerid, LastPos[playerid][LA]);
	        SetPlayerInterior(playerid, LastPos[playerid][LInterior]);
		    TogglePlayerControllable(playerid, 1);
		    KillTimer(KeyTimer[playerid]);
		    SetCameraBehindPlayer(playerid);
		    TextDrawHideForPlayer(playerid, TD);
            CurrentCCTV[playerid] = -1;
            return 1;
		}
	}
	if(strcmp(cmd, "/suspect", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /suspect [playerid/partofname] [crime]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						new length = strlen(cmdtext);
						while ((idx < length) && (cmdtext[idx] <= ' '))
						{
							idx++;
						}
						new offset = idx;
						new result[128];
						while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
						{
							result[idx - offset] = cmdtext[idx];
							idx++;
						}
						result[idx - offset] = EOS;
						if(!strlen(result))
						{
							SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /suspect [playerid/partofname] [crime]");
							return 1;
						}
      					if(CopOnDuty[playerid])
						{
							if(giveplayerid != playerid)
							{
								format(string, sizeof(string), "(INFO) You have been suspected by %s - Reason: %s", GetPlayerNameEx(playerid),result);
								SendClientMessage(giveplayerid, COLOR_WHITE, string);
								format(string, sizeof(string), "(INFO) You have suspected %s - Reason: %s", GetPlayerNameEx(giveplayerid),result);
								SendClientMessage(playerid, COLOR_WHITE, string);
								format(string, sizeof(string), "(HQ) %s has suspected %s - Reason: %s", GetPlayerNameEx(playerid),GetPlayerNameEx(giveplayerid),result);
								SendFactionTypeMessage(1,COLOR_LSPD,string);
								new location[MAX_ZONE_NAME];
								GetPlayer2DZone(giveplayerid, location, MAX_ZONE_NAME);
								format(string, sizeof(string), "(HQ) All units be on the lookout for %s - Person Last Seen: %s", GetPlayerNameEx(giveplayerid),location);
								SendFactionTypeMessage(1,COLOR_LSPD,string);
								SetPlayerWantedLevelEx(giveplayerid,GetPlayerWantedLevel(playerid)+1);
							}
							else
							{
       							SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not suspect yourself");
							}
						}
      					else
						{
      						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not on duty");
						}
						return 1;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
				return 1;
			}
		}
  		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
			return 1;
		}
		return 1;
	}
 	if(strcmp(cmd, "/wanted", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	   	{
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
			    if(CopOnDuty[playerid])
			    {
			        new count = 0;
					SendClientMessage(playerid, COLOR_RED, "<|> Wanted Suspects <|>");
				    for(new i=0; i < MAX_PLAYERS; i++)
					{
						if(IsPlayerConnected(i))
						{
						    if(WantedLevel[i] >= 1)
						    {
						        format(string, sizeof(string), "(WANTED) %s (ID:%d) - Wanted Level: %d",GetPlayerNameEx(i),i,WantedLevel[i]);
								SendClientMessage(playerid,COLOR_WHITE,string);
								count++;
							}
						}
					}
					if(count == 0)
					{
			    		SendClientMessage(playerid, COLOR_WHITE, "(INFO) Currently no criminals wanted");
					}
					SendClientMessage(playerid, COLOR_RED, "<|> Wanted Suspects <|>");
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not on duty");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			}
		}//not connected
		return 1;
	}
	if(strcmp(cmd, "/cuff", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
   				if(CopOnDuty[playerid] == 0)
			    {
			    	SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not on duty");
			        return 1;
			    }
			    tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /cuff [playerid]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
			    if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
					    if(PlayerCuffed[giveplayerid] == 1)
					    {
					        SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is already cuffed");
					        return 1;
					    }
		    			/*if(giveplayerid == playerid)
				    	{
        					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not cuff yourself");
        					return 1;
				    	}*/
						if (ProxDetectorS(8.0, playerid, giveplayerid))
						{
        					format(string, sizeof(string), "(INFO) You have been cuffed by %s", GetPlayerNameEx(playerid));
							SendClientMessage(giveplayerid, COLOR_WHITE, string);
							format(string, sizeof(string), "(INFO) %s cuffed", GetPlayerNameEx(giveplayerid));
							SendClientMessage(playerid, COLOR_WHITE, string);
							PlayerPlayerActionMessage(playerid,giveplayerid,15.0,"handcuffed");
							TogglePlayerControllable(giveplayerid, 0);
							PlayerCuffed[giveplayerid] = 1;
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
						    return 1;
						}
					}
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
				    return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/uncuff", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
   				if(CopOnDuty[playerid] == 0)
			    {
			    	SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not on duty");
			        return 1;
			    }
			    tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /uncuff [playerid]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
			    if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
					    if(PlayerCuffed[giveplayerid] == 0)
					    {
					        SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not cuffed");
					        return 1;
					    }
 			    		if(giveplayerid == playerid)
				    	{
        					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not uncuff yourself");
        					return 1;
				    	}
						if (ProxDetectorS(8.0, playerid, giveplayerid))
						{
        					format(string, sizeof(string), "(INFO) You have been uncuffed by %s", GetPlayerNameEx(playerid));
							SendClientMessage(giveplayerid, COLOR_WHITE, string);
							format(string, sizeof(string), "(INFO) %s uncuffed", GetPlayerNameEx(giveplayerid));
							SendClientMessage(playerid, COLOR_WHITE, string);
							PlayerPlayerActionMessage(playerid,giveplayerid,15.0,"uncuffed");
							TogglePlayerControllable(giveplayerid, 1);
							PlayerCuffed[giveplayerid] = 0;
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
						    return 1;
						}
					}
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
				    return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/revoke", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
	        {
  			    if(CopOnDuty[playerid] == 0)
			    {
			    	SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not on duty");
			        return 1;
			    }
	            new x_nr[256];
				x_nr = strtok(cmdtext, idx);
				if(!strlen(x_nr)) {
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /revoke [item] [playerid/partofname]");
			  		SendClientMessage(playerid, COLOR_WHITE, "(ITEM) driverslicense | flyinglicense | weaponlicense | drugs | materials | weapons");
					return 1;
				}
			    if(strcmp(x_nr, "driverslicense", true) == 0)
				{
				    tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /revoke driverslicense [playerid/partofname]");
						return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        if (ProxDetectorS(8.0, playerid, giveplayerid))
							{
						        format(string, sizeof(string), "(INFO) %s's drivers license successfully revoked", GetPlayerNameEx(giveplayerid));
						        SendClientMessage(playerid, COLOR_WHITE, string);
						        format(string, sizeof(string), "(INFO) %s revoked your drivers license", GetPlayerNameEx(playerid));
						        SendClientMessage(giveplayerid, COLOR_WHITE, string);
						        PlayerInfo[giveplayerid][pCarLic] = 0;
							}
							else
							{
							    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
							    return 1;
							}
					    }
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
					    return 1;
					}
				}
				else if(strcmp(x_nr, "flyinglicense", true) == 0)
				{
				    tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /revoke flyinglicense [playerid/partofname]");
						return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        if (ProxDetectorS(8.0, playerid, giveplayerid))
							{
              					format(string, sizeof(string), "(INFO) %s's flying license successfully revoked", GetPlayerNameEx(giveplayerid));
						        SendClientMessage(playerid, COLOR_WHITE, string);
						        format(string, sizeof(string), "(INFO) %s revoked your flying license", GetPlayerNameEx(playerid));
						        SendClientMessage(giveplayerid, COLOR_WHITE, string);
						        PlayerInfo[giveplayerid][pFlyLic] = 0;
							}
							else
							{
							    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
							    return 1;
							}
					    }
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
					    return 1;
					}
				}
				else if(strcmp(x_nr, "weaponlicense", true) == 0)
				{
				    tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /revoke weaponlicense [playerid/partofname]");
						return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        if (ProxDetectorS(8.0, playerid, giveplayerid))
							{
						        format(string, sizeof(string), "(INFO) %s's weapon license successfully revoked", GetPlayerNameEx(giveplayerid));
						        SendClientMessage(playerid, COLOR_WHITE, string);
						        format(string, sizeof(string), "(INFO) %s revoked your weapon license", GetPlayerNameEx(playerid));
						        SendClientMessage(giveplayerid, COLOR_WHITE, string);
						        PlayerInfo[giveplayerid][pWepLic] = 0;
					        }
					        else
							{
							    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
							    return 1;
							}
					    }
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
					    return 1;
					}
				}
				else if(strcmp(x_nr, "drugs", true) == 0)
				{
				    tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /revoke drugs [playerid/partofname]");
						return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        if (ProxDetectorS(8.0, playerid, giveplayerid))
							{
							    format(string, sizeof(string), "(INFO) %s's drugs successfully revoked", GetPlayerNameEx(giveplayerid));
						        SendClientMessage(playerid, COLOR_WHITE, string);
						        format(string, sizeof(string), "(INFO) %s revoked your drugs", GetPlayerNameEx(playerid));
						        SendClientMessage(giveplayerid, COLOR_WHITE, string);
						        PlayerInfo[giveplayerid][pDrugs] = 0;
							}
					        else
							{
							    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
							    return 1;
							}
					    }
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
					    return 1;
					}
				}
				else if(strcmp(x_nr, "materials", true) == 0)
				{
				    tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /revoke materials [playerid/partofname]");
						return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        if (ProxDetectorS(8.0, playerid, giveplayerid))
							{
							    format(string, sizeof(string), "(INFO) %s's materials successfully revoked", GetPlayerNameEx(giveplayerid));
						        SendClientMessage(playerid, COLOR_WHITE, string);
						        format(string, sizeof(string), "(INFO) %s revoked your materials", GetPlayerNameEx(playerid));
						        SendClientMessage(giveplayerid, COLOR_WHITE, string);
						        PlayerInfo[giveplayerid][pMaterials] = 0;
							}
					        else
							{
							    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
							    return 1;
							}
					    }
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
					    return 1;
					}
				}
				else if(strcmp(x_nr, "weapons", true) == 0)
				{
				    tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /revoke weapons [playerid/partofname]");
						return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        if (ProxDetectorS(8.0, playerid, giveplayerid))
							{
							    format(string, sizeof(string), "(INFO) %s's weapons successfully revoked", GetPlayerNameEx(giveplayerid));
						        SendClientMessage(playerid, COLOR_WHITE, string);
						        format(string, sizeof(string), "(INFO) %s revoked your weapons", GetPlayerNameEx(playerid));
						        SendClientMessage(giveplayerid, COLOR_WHITE, string);
						        SafeResetPlayerWeapons(giveplayerid);
					        	PlayerInfo[giveplayerid][pGun1] = 0; PlayerInfo[giveplayerid][pAmmo1] = 0;
						        PlayerInfo[giveplayerid][pGun2] = 0; PlayerInfo[giveplayerid][pAmmo2] = 0;
						        PlayerInfo[giveplayerid][pGun3] = 0; PlayerInfo[giveplayerid][pAmmo3] = 0;
						        PlayerInfo[giveplayerid][pGun4] = 0; PlayerInfo[giveplayerid][pAmmo4] = 0;
							}
					        else
							{
							    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
							    return 1;
							}
					    }
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID");
					    return 1;
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid name");
					return 1;
				}
	        }
	        else
	        {
	            SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
	            return 1;
	        }
	    }
	    return 1;
	}
	if(strcmp(cmd, "/tazer", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
			    if(CopOnDuty[playerid] == 0)
			    {
			    	SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not on duty");
			        return 1;
			    }
			    if(IsPlayerInAnyVehicle(playerid))
			    {
			        SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not use this whilst in a car");
			        return 1;
			    }
			    new suspect = GetClosestPlayer(playerid);
			    if(IsPlayerConnected(suspect))
				{
				    if(PlayerCuffed[suspect] == 1)
				    {
				        SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is cuffed");
				        return 1;
				    }
				    if(PlayerTazed[suspect] == 1)
				    {
				        SendClientMessage(playerid, COLOR_WHITE, "(INFO) That player is tazed");
				        return 1;
				    }
				    if(GetDistanceBetweenPlayers(playerid,suspect) < 5)
					{
					    if(IsPlayerInAnyVehicle(suspect))
					    {
					        SendClientMessage(playerid, COLOR_GREY, "(ERROR) Get the suspect out of the vehicle");
					        return 1;
					    }
						format(string, sizeof(string), "(INFO) Tazed by %s for 7 seconds", GetPlayerNameEx(playerid));
						SendClientMessage(suspect, COLOR_WHITE, string);
						format(string, sizeof(string), "(INFO) You tazed %s 7 seconds", GetPlayerNameEx(suspect));
						SendClientMessage(playerid, COLOR_WHITE, string);
						TogglePlayerControllable(suspect, 0);
						PlayerTazed[suspect] = 1;
						SetTimerEx("UntazePlayer", 7000, false, "i", suspect);
						PlayerPlayerActionMessage(playerid,suspect,15.0,"tazed");
		            }
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) No player is in range");
					    return 1;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			}
		}//not connected
	    return 1;
	}
	if(strcmp(cmd, "/ticket", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
		        if(CopOnDuty[playerid] == 0)
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not on duty");
				    return 1;
				}
		    	tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /ticket [playerid] [cost] [reason]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
	            tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /ticket [playerid] [cost] [reason]");
					return 1;
				}
				new moneys;
				moneys = strval(tmp);
				if(moneys < 1 || moneys > 99999) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid amount"); return 1; }
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
				        if (ProxDetectorS(8.0, playerid, giveplayerid))
						{
							new length = strlen(cmdtext);
							while ((idx < length) && (cmdtext[idx] <= ' '))
							{
								idx++;
							}
							new offset = idx;
							new result[128];
							while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
							{
								result[idx - offset] = cmdtext[idx];
								idx++;
							}
							result[idx - offset] = EOS;
							if(!strlen(result))
							{
								SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /ticket [playerid/partofname] [cost] [reason]");
								return 1;
							}
							format(string, sizeof(string), "(INFO) You have given %s a ticket for $%d - Reason: %s", GetPlayerNameEx(giveplayerid), moneys, (result));
							SendClientMessage(playerid, COLOR_WHITE, string);
							format(string, sizeof(string), "(INFO) %s gave you a ticket for $%d - Reason: %s", GetPlayerNameEx(playerid), moneys, (result));
							SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
							SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "(INFO) Type /accept ticket, to pay it");
							TicketOffer[giveplayerid] = playerid;
							TicketMoney[giveplayerid] = moneys;
							return 1;
						}
						else
						{
							SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
							return 1;
						}
					}
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
				    return 1;
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/codes", true) == 0)
	{
 		if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
				if(CopOnDuty[playerid] == 0)
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not on duty");
					return 1;
    			}
		    	SendClientMessage(playerid,COLOR_RED,"<|> Police Codes <|>");
				SendClientMessage(playerid,COLOR_WHITE,"10-4 = Message received");
				SendClientMessage(playerid,COLOR_WHITE,"10-8 = Need backup (Location)");
				SendClientMessage(playerid,COLOR_WHITE,"10-10 = In a pull over");
				SendClientMessage(playerid,COLOR_WHITE,"10-22 = Officer in pursuit");
		    	SendClientMessage(playerid,COLOR_WHITE,"10-30 = Being followed by suspicious vehicle (Location)");
		    	SendClientMessage(playerid,COLOR_WHITE,"10-44 = Suspect in custody");
		    	SendClientMessage(playerid,COLOR_WHITE,"22-10 = Requesting all units (Location)");
				SendClientMessage(playerid,COLOR_RED,"<|> Police Codes <|>");
			}
 			else
 			{
   				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
 			}
 		}
 		else
 		{
   			SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
 		}
		return 1;
	}
 	if(strcmp(cmd, "/government", true) == 0 || strcmp(cmd, "/gov", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    	if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
				if(PlayerInfo[playerid][pRank] != 1)
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Only the leader can use this");
				    return 1;
				}
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
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) [/gov]ernment [text]");
					return 1;
				}
				if(CopOnDuty[playerid])
				{
					new faction = PlayerInfo[playerid][pFaction];
					SendClientMessageToAll(COLOR_RED, "<|> Government Announcement <|>");
					format(string, sizeof(string), "%s %s: %s", DynamicFactions[faction][fRank1],GetPlayerNameEx(playerid), result);
					SendClientMessageToAll(COLOR_LSPD, string);
					SendClientMessageToAll(COLOR_RED, "<|> Government Announcement <|>");
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not on duty");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/arrest", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	   	{
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
				if(CopOnDuty[playerid] == 0)
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not on duty");
				    return 1;
				}
		        if(!PlayerToPoint(15.0,playerid,PoliceArrestPosition[X],PoliceArrestPosition[Y],PoliceArrestPosition[Z]) || GetPlayerVirtualWorld(playerid) != PoliceArrestPosition[World])
				{// Jail spot
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the arrest location");
				    return 1;
				}
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /arrest [price] [time (minutes)] [bail (0=no 1=yes)] [bailprice]");
					return 1;
				}
				new moneys;
				moneys = strval(tmp);
				if(moneys < 1 || moneys > 30000) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) Jail price can not be below $1 or above $30000"); return 1; }
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /arrest [price] [time (minutes)] [bail (0=no 1=yes)] [bailprice]");
					return 1;
				}
				new time = strval(tmp);
				if(time < 1 || time > 30) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) Jail time minutes can not be below 1 or above 30"); return 1; }
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /arrest [price] [time (minutes)] [bail (0=no 1=yes)] [bailprice]");
					return 1;
				}
				new bail = strval(tmp);
				if(bail < 0 || bail > 1) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) Jail bailing can not be below 0 or above 1"); return 1; }
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /arrest [price] [time (minutes)] [bail (0=no 1=yes)] [bailprice]");
					return 1;
				}
				new bailprice = strval(tmp);
				if(bailprice < 0 || bailprice > 10000) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) Jail bail price can not be below $0 or above $10000"); return 1; }
				new suspect = GetClosestPlayer(playerid);
				if(IsPlayerConnected(suspect))
				{
					if(GetDistanceBetweenPlayers(playerid,suspect) < 5)
					{
						if(WantedLevel[suspect] < 1)
						{
						    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not wanted");
						    return 1;
						}
						format(string, sizeof(string), "(INFO) %s successfully arrested", GetPlayerNameEx(suspect));
						SendClientMessage(playerid, COLOR_WHITE, string);
						GivePlayerCash(suspect, -moneys);
						GivePlayerCash(playerid, moneys);
						SafeResetPlayerWeapons(suspect);
					    SetPlayerVirtualWorld(suspect,2);
					    SetPlayerInterior(suspect,6);
						SetPlayerPos(suspect,264.5743,77.5118,1001.0391);
						PlayerInfo[suspect][pJailTime] = time * 60;
						if(bail == 1)
						{
							JailPrice[suspect] = bailprice;
							format(string, sizeof(string), "(INFO) Arrested - Jail Time: %d seconds | Price: $%d | Bail: $%d", PlayerInfo[suspect][pJailTime], moneys, JailPrice[suspect]);
							SendClientMessage(suspect, COLOR_WHITE, string);
						}
						else
						{
		    				JailPrice[suspect] = 0;
							format(string, sizeof(string), "(INFO) Arrested - Jail Time: %d seconds | Price: $%d | Bail: n/a", PlayerInfo[suspect][pJailTime], moneys);
							SendClientMessage(suspect, COLOR_WHITE, string);
						}
						format(string, sizeof(string), "(HQ) %s arrested criminal %s",GetPlayerNameEx(playerid), GetPlayerNameEx(suspect));
  						SendFactionTypeMessage(1, COLOR_LSPD, string);
						PlayerInfo[suspect][pJailed] = 1;
						WantedPoints[suspect] = 0;
						ResetPlayerWantedLevelEx(suspect);
					}//distance
				}//not connected
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) No-one close enough to arrest");
				    return 1;
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			    return 1;
			}
		}//not connected
		return 1;
	}
	if(strcmp(cmd, "/govarrest", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	   	{
			if(PlayerInfo[playerid][pFaction] == 6)
			{
				if(CopOnDuty[playerid] == 0)
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not on duty");
				    return 1;
				}
		        if(!PlayerToPoint(15.0,playerid,GovernmentArrestPosition[X],GovernmentArrestPosition[Y],GovernmentArrestPosition[Z]) || GetPlayerVirtualWorld(playerid) != GovernmentArrestPosition[World])
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You must be at arrest location");
				    return 1;
				}
				tmp = strtok(cmdtext, idx);
				new time = strval(tmp);
				if(time < 1 || time > 60) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) Jail time can not be below 1 minute or above 60 minutes (/govarrest [time] [playerid])"); return 1; }
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /govarrest [time] [playerid]");
					return 1;
				}
				new suspect = GetClosestPlayer(playerid);
				if(IsPlayerConnected(suspect))
				{
					if(GetDistanceBetweenPlayers(playerid,suspect) < 5)
					{
						if(WantedLevel[suspect] < 1)
						{
						    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not wanted");
						    return 1;
						}
						format(string, sizeof(string), "(INFO) %s successfully arrested", GetPlayerNameEx(suspect));
						SendClientMessage(playerid, COLOR_WHITE, string);
						SetPlayerInterior(suspect, 0);
						SafeResetPlayerWeapons(suspect);
					    SetPlayerVirtualWorld(suspect,2);
					    SetPlayerInterior(suspect,6);
						SetPlayerPos(suspect,264.5743,77.5118,1001.0391);
						GivePlayerCash(suspect, -5000);
						GivePlayerCash(playerid, 5000);
						PlayerInfo[suspect][pJailTime] = time * 60;
						format(string, sizeof(string), "(INFO) Arrested! - Jail Time: %d seconds", PlayerInfo[suspect][pJailTime]);
						SendClientMessage(suspect, COLOR_WHITE, string);
						format(string, sizeof(string), "(GOVERNMENT) %s arrested criminal %s",GetPlayerNameEx(playerid), GetPlayerNameEx(suspect));
		    			SendFactionTypeMessage(1, COLOR_LSPD, string);
						PlayerInfo[suspect][pJailed] = 2;
						WantedPoints[suspect] = 0;
						ResetPlayerWantedLevelEx(suspect);
					}//distance
				}//not connected
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not near a criminal");
				    return 1;
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			    return 1;
			}
		}//not connected
		return 1;
	}
	if(strcmp(cmd, "/megaphone", true) == 0 || strcmp(cmd, "/m", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new tmpcar = GetPlayerVehicleID(playerid) - 1;
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) [/m]egaphone [message]");
				return 1;
			}
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
			    if(!IsPlayerInAnyVehicle(playerid))
			    {
			    	SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in a law enforcement vehicle");
					return 1;
			    }
		    	if(!CopOnDuty[playerid])
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not on duty");
					return 1;
				}
				if(DynamicCars[tmpcar][FactionCar] != PlayerInfo[playerid][pFaction])
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in a law enforcement vehicle");
					return 1;
				}
				new rank = PlayerInfo[playerid][pRank];
				if(rank == 1)
				{
					format(string, sizeof(string), "(MEGAPHONE) %s %s: %s!", DynamicFactions[PlayerInfo[playerid][pFaction]][fRank1],GetPlayerNameEx(playerid), result);
					ProxDetector(60.0, playerid, string,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD);
					return 1;
				}
				else if(rank == 2)
				{
					format(string, sizeof(string), "(MEGAPHONE) %s %s: %s!", DynamicFactions[PlayerInfo[playerid][pFaction]][fRank2],GetPlayerNameEx(playerid), result);
					ProxDetector(60.0, playerid, string,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD);
					return 1;
				}
				else if(rank == 3)
				{
					format(string, sizeof(string), "(MEGAPHONE) %s %s: %s!", DynamicFactions[PlayerInfo[playerid][pFaction]][fRank3],GetPlayerNameEx(playerid), result);
					ProxDetector(60.0, playerid, string,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD);
					return 1;
				}
    			else if(rank == 4)
				{
					format(string, sizeof(string), "(MEGAPHONE) %s %s: %s!", DynamicFactions[PlayerInfo[playerid][pFaction]][fRank4],GetPlayerNameEx(playerid), result);
					ProxDetector(60.0, playerid, string,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD);
					return 1;
				}
				else if(rank == 5)
				{
					format(string, sizeof(string), "(MEGAPHONE) %s %s: %s!", DynamicFactions[PlayerInfo[playerid][pFaction]][fRank5],GetPlayerNameEx(playerid), result);
					ProxDetector(60.0, playerid, string,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD);
					return 1;
				}
    			else if(rank == 6)
				{
					format(string, sizeof(string), "(MEGAPHONE) %s %s: %s!", DynamicFactions[PlayerInfo[playerid][pFaction]][fRank6],GetPlayerNameEx(playerid), result);
					ProxDetector(60.0, playerid, string,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD);
					return 1;
				}
    			else if(rank == 7)
				{
					format(string, sizeof(string), "(MEGAPHONE) %s %s: %s!", DynamicFactions[PlayerInfo[playerid][pFaction]][fRank7],GetPlayerNameEx(playerid), result);
					ProxDetector(60.0, playerid, string,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD);
					return 1;
				}
    			else if(rank == 8)
				{
					format(string, sizeof(string), "(MEGAPHONE) %s %s: %s!", DynamicFactions[PlayerInfo[playerid][pFaction]][fRank8],GetPlayerNameEx(playerid), result);
					ProxDetector(60.0, playerid, string,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD);
					return 1;
				}
    			else if(rank == 9)
				{
					format(string, sizeof(string), "(MEGAPHONE) %s %s: %s!", DynamicFactions[PlayerInfo[playerid][pFaction]][fRank9],GetPlayerNameEx(playerid), result);
					ProxDetector(60.0, playerid, string,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD);
					return 1;
				}
    			else if(rank == 10)
				{
					format(string, sizeof(string), "(MEGAPHONE) %s %s: %s!", DynamicFactions[PlayerInfo[playerid][pFaction]][fRank10],GetPlayerNameEx(playerid), result);
					ProxDetector(60.0, playerid, string,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD);
					return 1;
				}
				return 1;
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
				return 1;
			}
		}
		return 1;
	}
	//==========================================================================
	if(strcmp(cmd, "/news", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pFaction] == 3)
			{
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
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /news [newstext]");
					return 1;
				}
				format(string, sizeof(string), "(LIVE) News Reporter %s: %s", sendername, result);
				OOCNews(COLOR_NEWS,string);
			}
			else
			{
  				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			}
		}//not connected
		return 1;
	}
	if(strcmp(cmd, "/live", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pFaction] == 3)
			{
			    if(TalkingLive[playerid] != 255)
			    {
			        SendClientMessage(playerid, COLOR_WHITE, "(INFO) Live Conversation ended");
			        SendClientMessage(TalkingLive[playerid], COLOR_WHITE, "(INFO) Live Conversation ended");
			        TogglePlayerControllable(playerid, 1);
			        TogglePlayerControllable(TalkingLive[playerid], 1);
		            TalkingLive[TalkingLive[playerid]] = 255;
			        TalkingLive[playerid] = 255;
			        return 1;
			    }
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /live [playerid/partofname]");
					return 1;
				}
		        giveplayerid = ReturnUser(tmp);
				if (IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
			    		if(giveplayerid == playerid)
				    	{
        					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not talk live with yourself");
        					return 1;
				    	}
						if (ProxDetectorS(5.0, playerid, giveplayerid))
						{
						    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							GetPlayerName(playerid, sendername, sizeof(sendername));
							format(string, sizeof(string), "(INFO) You offered %s to have a Live Conversation", giveplayer);
							SendClientMessage(playerid, COLOR_WHITE, string);
							format(string, sizeof(string), "(INFO) %s offered you to have a Live Conversation, (type /accept live) to accept", sendername);
							SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
							LiveOffer[giveplayerid] = playerid;
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
						    return 1;
						}
					}
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
				    return 1;
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			}
		}//not connected
		return 1;
	}
	if(strcmp(cmd, "/steal", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 2)
	        {
	            new x_nr[256];
				x_nr = strtok(cmdtext, idx);
				if(!strlen(x_nr)) {
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /steal [itemname] [playerid/partofname]");
			  		SendClientMessage(playerid, COLOR_WHITE, "(ITEMS) phone | weapons");
					return 1;
				}
			    if(strcmp(x_nr, "phone", true) == 0)
				{
				    tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /steal phone [playerid/partofname]");
						return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
 			    			if(giveplayerid == playerid)
				    		{
        						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not steal from yourself");
        						return 1;
				    		}
					        if(ProxDetectorS(3.0, playerid, giveplayerid))
							{
      							GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
						        format(string, sizeof(string), "(INFO) You have taken away %s's phone", giveplayer);
						        SendClientMessage(playerid, COLOR_WHITE, string);
						        format(string, sizeof(string), "(INFO) %s has taken away your phone", sendername);
						        SendClientMessage(giveplayerid, COLOR_WHITE, string);
						        PlayerInfo[giveplayerid][pPhoneNumber] = 0;
						        PlayerInfo[giveplayerid][pPhoneC] = 255;
						        
							}
							else
							{
							    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
							    return 1;
							}
					    }
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not connected");
					    return 1;
					}
				}
				else if(strcmp(x_nr, "weapons", true) == 0)
				{
				    tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /steal weapons [playerid/partofname]");
						return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
 			    			if(giveplayerid == playerid)
				    		{
        						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not steal from yourself");
        						return 1;
				    		}
					        if (ProxDetectorS(3.0, playerid, giveplayerid))
							{
							    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
						        format(string, sizeof(string), "(INFO) You have stolen %s's weapons", giveplayer);
						        SendClientMessage(playerid, COLOR_WHITE, string);
						        format(string, sizeof(string), "(INFO) %s has stolen your weapons", sendername);
						        SendClientMessage(giveplayerid, COLOR_WHITE, string);
						        SafeResetPlayerWeapons(giveplayerid);
						        PlayerInfo[giveplayerid][pGun1] = 0; PlayerInfo[giveplayerid][pAmmo1] = 0;
						        PlayerInfo[giveplayerid][pGun2] = 0; PlayerInfo[giveplayerid][pAmmo2] = 0;
						        PlayerInfo[giveplayerid][pGun3] = 0; PlayerInfo[giveplayerid][pAmmo3] = 0;
						        PlayerInfo[giveplayerid][pGun4] = 0; PlayerInfo[giveplayerid][pAmmo4] = 0;
					        }
					        else
							{
							    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
							    return 1;
							}
					    }
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not connected");
					    return 1;
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid item");
					return 1;
				}
	        }
	        else
	        {
	            SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
	            return 1;
	        }
	    }
	    return 1;
	}
	//==========================================================================
	if(strcmp(cmd, "/flist", true) == 0 || strcmp(cmd, "/factionlist", true) == 0)
	{
        if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pFaction] == 0)
	        {
				SendClientMessage(playerid, COLOR_RED, "<|> LSPD Members Online <|>");
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
				    	if(PlayerInfo[i][pFaction] == 0)
				    	{
				    	    GetPlayerName(i, sendername, sizeof(sendername));
				    	    if(PlayerInfo[i][pRank] == 1)
							{
				    	        format(string, 256, "Chief %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 2)
							{
				    	        format(string, 256, "Sergeant %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
                            }
							else if(PlayerInfo[i][pRank] == 3)
							{
				    	        format(string, 256, "SWAT Officer %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
			                }
							else if(PlayerInfo[i][pRank] == 4)
							{
				    	        format(string, 256, "Officer %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 5)
							{
				    	        format(string, 256, "Cadet %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else
							{
				    	        format(string, 256, "Cadet %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
						}
					}
				}
			}
			else if(PlayerInfo[playerid][pFaction] == 1)
	        {
				SendClientMessage(playerid, COLOR_RED, "<|> Grove Street Members Online <|>");
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
                        if(PlayerInfo[i][pFaction] == 1)
				    	{
				    	    GetPlayerName(i, sendername, sizeof(sendername));
				    	    if(PlayerInfo[i][pRank] == 1)
							{
				    	        format(string, 256, "OG %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 2)
							{
				    	        format(string, 256, "Gangster %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 3)
							{
				    	        format(string, 256, "Hustler %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 4)
							{
				    	        format(string, 256, "Thug %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 5)
							{
				    	        format(string, 256, "Muscle %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 6)
							{
				    	        format(string, 256, "Punk %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else
							{
				    	        format(string, 256, "Punk %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
						}
					}
				}
			}
			else if(PlayerInfo[playerid][pFaction] == 2)
	        {
				SendClientMessage(playerid, COLOR_RED, "<|> Mafia Members Online <|>");
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
				    	if(PlayerInfo[i][pFaction] == 2)
				    	{
				    	    GetPlayerName(i, sendername, sizeof(sendername));
				    	    if(PlayerInfo[i][pRank] == 1)
							{
				    	        format(string, 256, "Godfather %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 2)
							{
				    	        format(string, 256, "Underboss %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 3)
							{
				    	        format(string, 256, "Capo %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 4)
							{
				    	        format(string, 256, "Soldier %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 5)
							{
				    	        format(string, 256, "Associate %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 6)
							{
				    	        format(string, 256, "Outsider %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else
							{
				    	        format(string, 256, "Outsider %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
						}
					}
				}
			}
	        else if(PlayerInfo[playerid][pFaction] == 3)
	        {
				SendClientMessage(playerid, COLOR_RED, "<|> News Network Members Online <|>");
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
				    	if(PlayerInfo[i][pFaction] == 3)
				    	{
				    	    GetPlayerName(i, sendername, sizeof(sendername));
				    	    if(PlayerInfo[i][pRank] == 1)
							{
				    	        format(string, 256, "Network Producer %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 2)
							{
				    	        format(string, 256, "Network Reporter %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 3)
							{
				    	        format(string, 256, "Intern %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else
							{
				    	        format(string, 256, "Intern %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
						}
					}
				}
			}
			else if(PlayerInfo[playerid][pFaction] == 4)
	        {
				SendClientMessage(playerid, COLOR_RED, "<|> Transport Company Members Online <|>");
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
        	 			if(PlayerInfo[i][pFaction] == 4)
				    	{
				    	    GetPlayerName(i, sendername, sizeof(sendername));
				    	    if(PlayerInfo[i][pRank] == 1)
							{
				    	        format(string, 256, "Manager %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 2)
							{
				    	        format(string, 256, "Shift Supervisor %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 3)
							{
				    	        format(string, 256, "Taxi Driver %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
			                }
							else if(PlayerInfo[i][pRank] == 4)
							{
				    	        format(string, 256, "Trainee %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else
							{
				    	        format(string, 256, "Trainee %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
						}
					}
				}
			}
			else if(PlayerInfo[playerid][pFaction] == 5)
			{
			    SendClientMessage(playerid, COLOR_RED, "<|> Balla Members Online <|>");
			    for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
				    	if(PlayerInfo[i][pFaction] == 5)
				    	{
				    	    GetPlayerName(i, sendername, sizeof(sendername));
				    	    if(PlayerInfo[i][pRank] == 1)
							{
				    	        format(string, 256, "OG %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 2)
							{
				    	        format(string, 256, "Gangster %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 3)
							{
				    	        format(string, 256, "Hustler %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 4)
							{
				    	        format(string, 256, "Thug %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 5)
							{
				    	        format(string, 256, "Muscle %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 6)
							{
				    	        format(string, 256, "Punk %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else
							{
				    	        format(string, 256, "Punk %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
				    	    }
				    	}
					}
				}
			}
			else if(PlayerInfo[playerid][pFaction] == 6)
	        {
				SendClientMessage(playerid, COLOR_RED, "<|> Government Members Online <|>");
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
				    	if(PlayerInfo[i][pFaction] == 6)
				    	{
				    	    GetPlayerName(i, sendername, sizeof(sendername));
				    	    if(PlayerInfo[i][pRank] == 1)
							{
				    	        format(string, 256, "President %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 2)
							{
				    	        format(string, 256, "General %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 3)
							{
				    	        format(string, 256, "Army Personnel %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 4)
							{
				    	        format(string, 256, "Special Agent %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 5)
							{
				    	        format(string, 256, "FBI Agent %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 6)
							{
				    	        format(string, 256, "Internal Affairs %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else
							{
				    	        format(string, 256, "Internal Affairs %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
						}
					}
				}
			}
			else if(PlayerInfo[playerid][pFaction] == 7)
			{
			    SendClientMessage(playerid, COLOR_RED, "<|> Aztecaz Members Online <|>");
			    for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
				    	if(PlayerInfo[i][pFaction] == 7)
				    	{
				    	    GetPlayerName(i, sendername, sizeof(sendername));
				    	    if(PlayerInfo[i][pRank] == 1)
							{
				    	        format(string, 256, "Jefe %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 2)
							{
				    	        format(string, 256, "Underboss %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 3)
							{
				    	        format(string, 256, "Hermano %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 4)
							{
				    	        format(string, 256, "Musculo %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 5)
							{
				    	        format(string, 256, "Miembro %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 6)
							{
				    	        format(string, 256, "Puto %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else
							{
				    	        format(string, 256, "Puto %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
				    	    }
				    	}
					}
				}
			}
			else if(PlayerInfo[playerid][pFaction] == 8)
			{
			    SendClientMessage(playerid, COLOR_RED, "<|> Bikers Members Online <|>");
			    for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
				    	if(PlayerInfo[i][pFaction] == 8)
				    	{
				    	    GetPlayerName(i, sendername, sizeof(sendername));
				    	    if(PlayerInfo[i][pRank] == 1)
							{
				    	        format(string, 256, "Bull %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 2)
							{
				    	        format(string, 256, "Biker %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 3)
							{
				    	        format(string, 256, "Bully %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 4)
							{
				    	        format(string, 256, "Recruit %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else
							{
				    	        format(string, 256, "Recruit %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
				    	    }
				    	}
					}
				}
			}
			else if(PlayerInfo[playerid][pFaction] == 9)
			{
			    SendClientMessage(playerid, COLOR_RED, "<|> Triads Members Online <|>");
			    for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
				    	if(PlayerInfo[i][pFaction] == 9)
				    	{
				    	    GetPlayerName(i, sendername, sizeof(sendername));
				    	    if(PlayerInfo[i][pRank] == 1)
							{
				    	        format(string, 256, "Di-Di-Lo %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 2)
							{
				    	        format(string, 256, "Ran-Fa-Li %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 3)
							{
				    	        format(string, 256, "Assassin %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else if(PlayerInfo[i][pRank] == 4)
							{
				    	        format(string, 256, "Guppy %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else
							{
				    	        format(string, 256, "Guppy %s", sendername);
							    SendClientMessage(playerid, COLOR_WHITE, string);
				    	    }
				    	}
					}
				}
			}
			else { SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in a organisation/family"); }
		}
		return 1;
	}
	if(strcmp(cmd, "/faction", true) == 0 || strcmp(cmd, "/f", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new wstring[128];
			new faction = PlayerInfo[playerid][pFaction];
			new rank = PlayerInfo[playerid][pRank];
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) (/f)action");
				return 1;
			}
			if(Muted[playerid])
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not use faction chat, you are muted");
				return 1;
			}
			if(PlayerInfo[playerid][pFaction] != 255)
			{
			 		if(rank == 1)
					{
					    format(wstring, sizeof(wstring), "(( %s %s: %s ))",DynamicFactions[faction][fRank1],GetPlayerNameEx(playerid),result);
					    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_LIGHTBLUE, wstring);
					    FactionChatLog(wstring);
					}
			 		else if(rank == 2)
					{
					    format(wstring, sizeof(wstring), "(( %s %s: %s ))",DynamicFactions[faction][fRank2],GetPlayerNameEx(playerid),result);
					    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_LIGHTBLUE, wstring);
					    FactionChatLog(wstring);
					}
			 		else if(rank == 3)
					{
					    format(wstring, sizeof(wstring), "(( %s %s: %s ))",DynamicFactions[faction][fRank3],GetPlayerNameEx(playerid),result);
					    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_LIGHTBLUE, wstring);
					    FactionChatLog(wstring);
					}
			 		else if(rank == 4)
					{
					    format(wstring, sizeof(wstring), "(( %s %s: %s ))",DynamicFactions[faction][fRank4],GetPlayerNameEx(playerid),result);
					    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_LIGHTBLUE, wstring);
					    FactionChatLog(wstring);
					}
			 		else if(rank == 5)
					{
					    format(wstring, sizeof(wstring), "(( %s %s: %s ))",DynamicFactions[faction][fRank5],GetPlayerNameEx(playerid),result);
					    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_LIGHTBLUE, wstring);
					    FactionChatLog(wstring);
					}
			 		else if(rank == 6)
					{
					    format(wstring, sizeof(wstring), "(( %s %s: %s ))",DynamicFactions[faction][fRank6],GetPlayerNameEx(playerid),result);
					    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_LIGHTBLUE, wstring);
					    FactionChatLog(wstring);
					}
			 		else if(rank == 7)
					{
					    format(wstring, sizeof(wstring), "(( %s %s: %s ))",DynamicFactions[faction][fRank7],GetPlayerNameEx(playerid),result);
					    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_LIGHTBLUE, wstring);
					    FactionChatLog(wstring);
					}
			 		else if(rank == 8)
					{
					    format(wstring, sizeof(wstring), "(( %s %s: %s ))",DynamicFactions[faction][fRank8],GetPlayerNameEx(playerid),result);
					    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_LIGHTBLUE, wstring);
					    FactionChatLog(wstring);
					}
			 		else if(rank == 9)
					{
					    format(wstring, sizeof(wstring), "(( %s %s: %s ))",DynamicFactions[faction][fRank9],GetPlayerNameEx(playerid),result);
					    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_LIGHTBLUE, wstring);
					    FactionChatLog(wstring);
					}
			 		else if(rank == 10)
					{
					    format(wstring, sizeof(wstring), "(( %s %s: %s ))",DynamicFactions[faction][fRank10],GetPlayerNameEx(playerid),result);
					    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_LIGHTBLUE, wstring);
					    FactionChatLog(wstring);
					}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			}
		}
		return 1;
	}
    if(strcmp(cmd, "/invite", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /invite [playerid/partofname]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pRank] == 1 && PlayerInfo[playerid][pFaction] != 255)
			{
			    if(PlayerInfo[giveplayerid][pFaction] == 255)
			    {
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        new form[128];
					        new faction = PlayerInfo[playerid][pFaction];
							if(gPlayerLogged[giveplayerid])
							{
						        if(DynamicFactions[faction][fJoinRank] == 0)
						        {
						            SendClientMessage(playerid, COLOR_GREY, "(ERROR) Please set your factions joinrank/rankamount before inviting people");
						        }
						        else
						        {
									FactionRequest[giveplayerid] = faction;
									format(form,sizeof(form),"You have been invited to %s by %s (type /accept faction - to join.)",DynamicFactions[faction][fName],GetPlayerNameEx(playerid));
									SendClientMessage(giveplayerid,COLOR_LIGHTBLUE,form);
									format(form,sizeof(form),"You have invited %s to join %s",GetPlayerNameEx(giveplayerid),DynamicFactions[faction][fName]);
									SendClientMessage(playerid,COLOR_LIGHTBLUE,form);
								}
								return 1;
							}
							else
							{
							    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not connected");
							}
						}
					}
		 			else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID");
					}
				}
 				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is already in a faction");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not a leader");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/uninvite", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /uninvite [playerid/partofname]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pRank] == 1 && PlayerInfo[playerid][pFaction] != 255)
			{
			    if(PlayerInfo[giveplayerid][pFaction] == PlayerInfo[playerid][pFaction])
				{
					if(IsPlayerConnected(giveplayerid))
					{
     					if(gPlayerLogged[giveplayerid])
     					{
						    if(giveplayerid != INVALID_PLAYER_ID)
						    {
						        new form[128];
						        new faction = PlayerInfo[playerid][pFaction];
								format(form,sizeof(form),"(INFO) You have been uninvited from %s by %s",DynamicFactions[faction][fName],GetPlayerNameEx(playerid));
								SendClientMessage(giveplayerid,COLOR_LIGHTBLUE,form);
								format(form,sizeof(form),"(INFO) You have uninvited %s from %s",GetPlayerNameEx(giveplayerid),DynamicFactions[faction][fName]);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,form);
								PlayerInfo[giveplayerid][pFaction] = 255;
								PlayerInfo[giveplayerid][pRank] = 0;
								SetPlayerSkin(giveplayerid, 299);
								PlayerInfo[giveplayerid][pSkin] = 299;
								format(form, sizeof(form), "(FACTION) %s has been uninvited from the faction by %s",GetPlayerNameEx(giveplayerid),GetPlayerNameEx(playerid));
								SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_LIGHTBLUE, form);
								return 1;
							}
						}
	      				else
						{
							SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not connected");
						}
					}
		 			else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
					}
				}
 				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in the faction");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not a leader");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/setrank", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /setrank [playerid/partofname] [newrank]");
				return 1;
			}
			new para1;
			new level;
			para1 = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			level = strval(tmp);
			if (PlayerInfo[playerid][pRank] == 1 && PlayerInfo[playerid][pFaction] != 255)
			{
				if (PlayerInfo[para1][pFaction] == PlayerInfo[playerid][pFaction])
				{
					new faction = PlayerInfo[playerid][pFaction];
					if (level)
					{
		   				if(level > 1 && level <= DynamicFactions[faction][fRankAmount])
					    {
		  					if(IsPlayerConnected(para1))
			    			{
								if(gPlayerLogged[para1])
								{
									if(para1 != INVALID_PLAYER_ID)
									{
										PlayerInfo[para1][pRank] = level;
										format(string, sizeof(string), "(INFO) You rank has been changed by %s, you are now rank: %d", GetPlayerNameEx(playerid),level);
										SendClientMessage(para1, COLOR_LIGHTBLUE, string);
										format(string, sizeof(string), "(INFO) You have changed %s's rank to: %d", GetPlayerNameEx(para1),level);
										SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
										SetPlayerToFactionSkin(para1);

										if(PlayerInfo[para1][pSex] == 1)
										{
											format(string, sizeof(string), "(FACTION) %s's rank has been changed, he is now rank: %d",GetPlayerNameEx(para1), level);
											SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_LIGHTBLUE, string);
										}
										else
										{
											format(string, sizeof(string), "(FACTION) %s's rank has been changed, she is now rank: %d",GetPlayerNameEx(para1), level);
											SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_LIGHTBLUE, string);
										}
									}
								}
								else
								{
									SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not connected");
								}
							}
							else
							{
								SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
							}
						}
						else
						{
							SendClientMessage(playerid, COLOR_GREY, "(ERROR) Rank must be below or equal to the factions rank amount");
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You must enter an amount");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) The player who's rank you tried to edit is not a member of your faction");
				}
			}
			else
   			{

				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not a leader");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/factiondrugstake", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pFaction];
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] != 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /factiondrugstake [amount]");
					return 1;
				}
				new materialsdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /factiondrugstake [amount]");
					return 1;
				}
				if(PlayerInfo[playerid][pRank] == 1)
				{
					if (PlayerToPoint(1.0,playerid,FactionDrugsStorage[X],FactionDrugsStorage[Y],FactionDrugsStorage[Z]))
					{
					    if(DynamicFactions[bouse][fDrugs] >= materialsdeposit)
					    {
							PlayerInfo[playerid][pDrugs] += materialsdeposit;
							DynamicFactions[bouse][fDrugs]=DynamicFactions[bouse][fDrugs]-materialsdeposit;
							format(string, sizeof(string), "(INFO) You have taken %d materials from the storage facility, Materials Total: %d ", materialsdeposit,DynamicFactions[bouse][fDrugs]);
							SendClientMessage(playerid, COLOR_WHITE, string);
   							PlayerActionMessage(playerid,15.0,"takes out drugs from storage");
							format(string, sizeof(string), "(FACTION) %s took %d drugs from the faction storage facility",GetPlayerNameEx(playerid),materialsdeposit);
							SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_WHITE, string);
							SaveDynamicFactions();
							return 1;
						}
	 					else
						{
							SendClientMessage(playerid, COLOR_GREY, "(ERROR) There is not that much drugs in storage");
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the faction storage facility");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not the leader of the faction");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in a faction");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/factiondrugsput", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pFaction];
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] != 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /factiondrugsput [amount]");
					return 1;
				}
				new materialsdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /factiondrugsput [amount]");
					return 1;
				}
				if (PlayerToPoint(1.0,playerid,FactionDrugsStorage[X],FactionDrugsStorage[Y],FactionDrugsStorage[Z]))
				{
				    if(PlayerInfo[playerid][pDrugs] >= materialsdeposit)
				    {
						PlayerInfo[playerid][pDrugs] -= materialsdeposit;
						DynamicFactions[bouse][fDrugs]=DynamicFactions[bouse][fDrugs]+materialsdeposit;
						format(string, sizeof(string), "(INFO) You have put %d drugs into your faction storage, Materials Total: %d ", materialsdeposit,DynamicFactions[bouse][fDrugs]);
						SendClientMessage(playerid, COLOR_WHITE, string);
        				PlayerActionMessage(playerid,15.0,"puts drugs into storage");
						format(string, sizeof(string), "(FACTION) %s put %d drugs in the faction storage facility",GetPlayerNameEx(playerid),materialsdeposit);
						SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_WHITE, string);
						SaveDynamicFactions();
						return 1;
					}
 					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have that much drugs");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the faction storage facility");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/factionmatstake", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pFaction];
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] != 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /factionmatstake [amount]");
					return 1;
				}
				new materialsdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /factionmatstake [amount]");
					return 1;
				}
				if(PlayerInfo[playerid][pRank] == 1)
				{
					if (PlayerToPoint(1.0,playerid,FactionMaterialsStorage[X],FactionMaterialsStorage[Y],FactionMaterialsStorage[Z]))
					{
					    if(DynamicFactions[bouse][fMaterials] >= materialsdeposit)
					    {
							PlayerInfo[playerid][pMaterials] += materialsdeposit;
							DynamicFactions[bouse][fMaterials]=DynamicFactions[bouse][fMaterials]-materialsdeposit;
							format(string, sizeof(string), "(INFO) You have taken %d materials from the storage facility, Materials Total: %d ", materialsdeposit,DynamicFactions[bouse][fMaterials]);
							SendClientMessage(playerid, COLOR_WHITE, string);
   							PlayerActionMessage(playerid,15.0,"takes out some weapon materials from the boxes");
							format(string, sizeof(string), "(FACTION) %s took %d weapon materials from the faction storage facility",GetPlayerNameEx(playerid),materialsdeposit);
							SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_WHITE, string);
							SaveDynamicFactions();
							return 1;
						}
	 					else
						{
							SendClientMessage(playerid, COLOR_GREY, "(ERROR) There is not that much materials in storage");
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the faction storage facility");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not the leader of the faction");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in a faction");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/factionmatsput", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pFaction];
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] != 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /factionmatsput [amount]");
					return 1;
				}
				new materialsdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /factionmatsput [amount]");
					return 1;
				}
				if (PlayerToPoint(1.0,playerid,FactionMaterialsStorage[X],FactionMaterialsStorage[Y],FactionMaterialsStorage[Z]))
				{
				    if(PlayerInfo[playerid][pMaterials] >= materialsdeposit)
				    {
						PlayerInfo[playerid][pMaterials] -= materialsdeposit;
						DynamicFactions[bouse][fMaterials]=DynamicFactions[bouse][fMaterials]+materialsdeposit;
						format(string, sizeof(string), "(INFO) You have put %d materials into your faction storage, Materials Total: %d ", materialsdeposit,DynamicFactions[bouse][fMaterials]);
						SendClientMessage(playerid, COLOR_WHITE, string);
        				PlayerActionMessage(playerid,15.0,"puts weapon materials into the boxes");
						format(string, sizeof(string), "(FACTION) %s put %d weapon materials in the faction storage facility",GetPlayerNameEx(playerid),materialsdeposit);
						SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_WHITE, string);
						SaveDynamicFactions();
						return 1;
					}
 					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have that much materials");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the faction storage facility");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/fbalance", true) == 0)
	{
		if(PlayerInfo[playerid][pFaction] != 255)
	    {
	 		if(PlayerToPoint(5.0,playerid,BankPosition[X],BankPosition[Y],BankPosition[Z]))
			{
				format(string, sizeof(string), "(INFO) Faction Balance: $%d", DynamicFactions[PlayerInfo[playerid][pFaction]][fBank]);
				SendClientMessage(playerid, COLOR_WHITE, string);
	   			PlayerActionMessage(playerid,15.0,"receives a mini-bank statement from the bank");
			}
			else
			{
	  			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the bank");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
		}
		return 1;
	}
	if(strcmp(cmd, "/fcheckmats", true) == 0)
	{
	    if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] != 1)
	    {
	 		if(PlayerToPoint(5.0,playerid,FactionMaterialsStorage[X],FactionMaterialsStorage[Y],FactionMaterialsStorage[Z]))
			{
				format(string, sizeof(string), "(INFO) Materials Total: %d", DynamicFactions[PlayerInfo[playerid][pFaction]][fMaterials]);
				SendClientMessage(playerid, COLOR_WHITE, string);
	   			PlayerActionMessage(playerid,15.0,"starts counting the weapon materials inside the boxes");
			}
			else
			{
	  			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the faction materials storage");
			}
		}
		else
		{
  			SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
		}
		return 1;
	}
 	if(strcmp(cmd, "/fcheckdrugs", true) == 0)
	{
	    if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] != 1)
	    {
	 		if(PlayerToPoint(5.0,playerid,FactionDrugsStorage[X],FactionDrugsStorage[Y],FactionDrugsStorage[Z]))
			{
				format(string, sizeof(string), "(INFO) Drugs Total: %d", DynamicFactions[PlayerInfo[playerid][pFaction]][fDrugs]);
				SendClientMessage(playerid, COLOR_WHITE, string);
	   			PlayerActionMessage(playerid,15.0,"starts counting the drugs inside storage");
			}
			else
			{
	  			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the faction materials storage");
			}
		}
  		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
		}
		return 1;
	}
	if(strcmp(cmd, "/fwithdraw", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pFaction] != 255)
	        {
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /fwithdraw [amount]");
					return 1;
				}
				new cashdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /fwithdraw [amount]");
					return 1;
				}
				if(PlayerToPoint(5.0,playerid,BankPosition[X],BankPosition[Y],BankPosition[Z]))
				{
				    if(PlayerInfo[playerid][pRank] == 1)
				    {
						if(DynamicFactions[PlayerInfo[playerid][pFaction]][fBank] >= cashdeposit)
						{
							GivePlayerCash(playerid,cashdeposit);
							DynamicFactions[PlayerInfo[playerid][pFaction]][fBank]=DynamicFactions[PlayerInfo[playerid][pFaction]][fBank]-cashdeposit;
							format(string, sizeof(string), "(INFO) You have withdrawn $%d from the faction bank, new balance: $%d", cashdeposit,DynamicFactions[PlayerInfo[playerid][pFaction]][fBank]);
							SendClientMessage(playerid, COLOR_WHITE, string);
		                    PlayerActionMessage(playerid,15.0,"receives a package full of money from the bank");
 							format(string, sizeof(string), "(FACTION) %s withdrew $%d from the faction bank",GetPlayerNameEx(playerid),cashdeposit);
							SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_WHITE, string);
		                    SaveDynamicFactions();
							return 1;
						}
	 					else
						{
							SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have that much in your faction bank");
						}
					}
 					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not the leader of this faction");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the bank");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/fdeposit", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pFaction] != 255)
	        {
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /fdeposit [amount]");
					return 1;
				}
				new cashdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /fdeposit [amount]");
					return 1;
				}
				if(PlayerToPoint(5.0,playerid,BankPosition[X],BankPosition[Y],BankPosition[Z]))
				{
					if(GetPlayerCash(playerid) >= cashdeposit)
					{
						GivePlayerCash(playerid,-cashdeposit);
						DynamicFactions[PlayerInfo[playerid][pFaction]][fBank]=cashdeposit+DynamicFactions[PlayerInfo[playerid][pFaction]][fBank];
						format(string, sizeof(string), "(INFO) You have deposited $%d into the faction bank, new balance: $%d", cashdeposit,DynamicFactions[PlayerInfo[playerid][pFaction]][fBank]);
						SendClientMessage(playerid, COLOR_WHITE, string);
	                    PlayerActionMessage(playerid,15.0,"takes out some money and hands it to the bank");
						format(string, sizeof(string), "(FACTION) %s deposited $%d into the faction bank",GetPlayerNameEx(playerid),cashdeposit);
						SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_WHITE, string);
	                    SaveDynamicFactions();
						return 1;
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have that amount of money");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the bank");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in a faction");
			}
		}
		return 1;
	}
	//==========================================================================
	if(strcmp(cmd, "/enter", true) == 0)
	{
		for(new i = 0; i < sizeof(Houses); i++)
		{
				if (PlayerToPoint(1.0,playerid,Houses[i][EnterX], Houses[i][EnterY], Houses[i][EnterZ]))
				{
				if(GetPlayerVirtualWorld(playerid) == Houses[i][EnterWorld])
			    {
					if(PlayerInfo[playerid][pHouseKey] == i || Houses[i][Locked] == 0 || PlayerInfo[playerid][pAdmin] >= 1)
					{
						SetPlayerInterior(playerid,Houses[i][ExitInterior]);
						SetPlayerPos(playerid,Houses[i][ExitX],Houses[i][ExitY],Houses[i][ExitZ]);
						SetPlayerVirtualWorld(playerid,i);
						SetPlayerFacingAngle(playerid,Houses[i][ExitAngle]);
					}
 					else
					{
						GameTextForPlayer(playerid, "~r~Locked", 5000, 1);
					}
				}
			}
		}
		for(new i = 0; i < sizeof(Building); i++)
		{
			if (PlayerToPoint(1.0,playerid,Building[i][EnterX], Building[i][EnterY], Building[i][EnterZ]))
			{
			    if(GetPlayerVirtualWorld(playerid) == Building[i][EnterWorld])
			    {
					if(Building[i][Locked] == 0 || PlayerInfo[playerid][pAdmin] >=  1)
					{
						SetPlayerInterior(playerid,Building[i][ExitInterior]);
						SetPlayerVirtualWorld(playerid,i);
						SetPlayerPos(playerid,Building[i][ExitX],Building[i][ExitY],Building[i][ExitZ]);
						SetPlayerFacingAngle(playerid,Building[i][ExitAngle]);
						GivePlayerCash(playerid,-Building[i][EntranceFee]);
					}
					else
					{
					GameTextForPlayer(playerid, "~r~Locked", 5000, 1);
					}
				}
			}
		}
		for(new i = 0; i < sizeof(Businesses); i++)
			{
				if (PlayerToPoint(1.0,playerid,Businesses[i][EnterX], Businesses[i][EnterY], Businesses[i][EnterZ]))
				{
				 	if(GetPlayerVirtualWorld(playerid) == Businesses[i][EnterWorld])
				    {
						if(PlayerInfo[playerid][pBizKey] == i || GetPlayerCash(playerid) >= Businesses[i][EntranceCost])
						{
							if(PlayerInfo[playerid][pBizKey] != i)
							{
								if(Businesses[i][Locked] == 1 && PlayerInfo[playerid][pAdmin] == 0)
								{
									GameTextForPlayer(playerid, "~r~Business Locked", 5000, 1);
									return 1;
								}
								if(Businesses[i][Products] == 0)
								{
									GameTextForPlayer(playerid, "~r~No Products", 5000, 1);
									return 1;
								}
								GivePlayerCash(playerid,-Businesses[i][EntranceCost]);
								format(string, sizeof(string), "(INFO) You have been charged $%d to enter %s", Businesses[i][EntranceCost],Businesses[i][BusinessName]);
								SendClientMessage(playerid,COLOR_WHITE,string);
								Businesses[i][Till] += Businesses[i][EntranceCost];
								Businesses[i][Products]--;
								SetPlayerInterior(playerid,Businesses[i][ExitInterior]);
								SetPlayerPos(playerid,Businesses[i][ExitX],Businesses[i][ExitY],Businesses[i][ExitZ]);
								SetPlayerVirtualWorld(playerid,i);
								SetPlayerFacingAngle(playerid,Businesses[i][ExitAngle]);
								SaveBusinesses();
							}
							else
							{
								SendClientMessage(playerid, COLOR_WHITE, "(INFO) Free entrance for the boss");
								SetPlayerInterior(playerid,Businesses[i][ExitInterior]);
								SetPlayerPos(playerid,Businesses[i][ExitX],Businesses[i][ExitY],Businesses[i][ExitZ]);
								SetPlayerVirtualWorld(playerid,i);
								SetPlayerFacingAngle(playerid,Businesses[i][ExitAngle]);
							}
						}
						else
						{
							SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
						}
					}
				}
			}
		return 1;
	}
	if(strcmp(cmd, "/exit", true) == 0)
	{
 		for(new i = 0; i < sizeof(Houses); i++)
		{
			if (PlayerToPoint(3.0,playerid,Houses[i][ExitX], Houses[i][ExitY], Houses[i][ExitZ]))
			{
   				if(GetPlayerVirtualWorld(playerid) == i)
			    {
			        if(Houses[i][Locked] == 0 || PlayerInfo[playerid][pAdmin] >=  1)
					{
						SetPlayerInterior(playerid,Houses[i][EnterInterior]);
						SetPlayerPos(playerid,Houses[i][EnterX],Houses[i][EnterY],Houses[i][EnterZ]);
						SetPlayerVirtualWorld(playerid,Houses[i][EnterWorld]);
						SetPlayerFacingAngle(playerid,Houses[i][EnterAngle]);
					}
					else
					{
						GameTextForPlayer(playerid, "~r~Door Locked", 5000, 1);
					}
				}
			}
		}
		for(new i = 0; i < sizeof(Building); i++)
		{
			if (PlayerToPoint(3,playerid,Building[i][ExitX], Building[i][ExitY], Building[i][ExitZ]))
			{
			    if(GetPlayerVirtualWorld(playerid) == i)
			    {
					if(Building[i][Locked] == 0 || PlayerInfo[playerid][pAdmin] >=  1)
					{
						SetPlayerInterior(playerid,Building[i][EnterInterior]);
						SetPlayerVirtualWorld(playerid,Building[i][EnterWorld]);
						SetPlayerPos(playerid,Building[i][EnterX],Building[i][EnterY],Building[i][EnterZ]);
						SetPlayerFacingAngle(playerid,Building[i][EnterAngle]);
					}
					else
					{
						GameTextForPlayer(playerid, "~r~Door Locked", 5000, 1);
					}
				}
			}
		}
  		for(new i = 0; i < sizeof(Businesses); i++)
		{
			if (PlayerToPoint(3,playerid,Businesses[i][ExitX], Businesses[i][ExitY], Businesses[i][ExitZ]))
			{
			    if(GetPlayerVirtualWorld(playerid) == i)
			    {
					if(Businesses[i][Locked] == 0 || PlayerInfo[playerid][pAdmin] >=  1)
					{
						SetPlayerInterior(playerid,Businesses[i][EnterInterior]);
						SetPlayerVirtualWorld(playerid,Businesses[i][EnterWorld]);
						SetPlayerPos(playerid,Businesses[i][EnterX],Businesses[i][EnterY],Businesses[i][EnterZ]);
						SetPlayerFacingAngle(playerid,Businesses[i][EnterAngle]);
					}
					else
					{
						GameTextForPlayer(playerid, "~r~Door Locked", 5000, 1);
					}
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/sellhouse", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			if(PlayerInfo[playerid][pHouseKey] != 255 && strcmp(playername, Houses[PlayerInfo[playerid][pHouseKey]][Owner], true) == 0)
			{
			    new house = PlayerInfo[playerid][pHouseKey];
				if(PlayerToPoint(1.0,playerid,Houses[house][EnterX],Houses[house][EnterY],Houses[house][EnterZ]))
				{
					Houses[house][Locked] = 1;
					Houses[house][Owned] = 0;
					strmid(Houses[house][Owner], "None", 0, strlen("None"), 255);
					GivePlayerCash(playerid,Houses[house][HousePrice]);
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					format(string, sizeof(string), "(INFO) You have sold your house for $%d", Houses[house][HousePrice]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					ChangeStreamPickupModel(Houses[house][PickupID],1273);
					PlayerInfo[playerid][pHouseKey] = 255;
					OnPlayerDataSave(playerid);
       				PlayerActionMessage(playerid,15.0,"takes out his house key and hands it to the real estate agent");
					SaveHouses();
					return 1;
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You must be at your house entrance to sell it");
				}
			}
			else
			{
    			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not own a house");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/openhouse", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        for(new i = 0; i < sizeof(Houses); i++)
			{
				if (PlayerToPoint(3.0,playerid,Houses[i][EnterX], Houses[i][EnterY], Houses[i][EnterZ]) || PlayerToPoint(3.0, playerid,Houses[i][ExitX], Houses[i][ExitY], Houses[i][ExitZ]))
				{
					if(PlayerInfo[playerid][pHouseKey] == i)
					{
						if(Houses[i][Locked] == 1)
						{
							Houses[i][Locked] = 0;
							SendClientMessage(playerid, COLOR_WHITE, "(INFO) Door Unlocked");
		                    PlayerActionMessage(playerid,15.0,"puts in there key and opens the door");
		                    SaveHouses();
							return 1;
						}
						if(Houses[i][Locked] == 0)
						{
							Houses[i][Locked] = 1;
							SendClientMessage(playerid, COLOR_WHITE, "(INFO) Door Locked");
		                    PlayerActionMessage(playerid,15.0,"puts in there key and locks the door");
		                    SaveHouses();
							return 1;
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a key for this house");
						return 1;
					}
				}
			}
	    }
	    return 1;
	}
 	if(strcmp(cmd, "/openbusiness", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        for(new i = 0; i < sizeof(Businesses); i++)
			{
				if (PlayerToPoint(3.0,playerid,Businesses[i][EnterX], Businesses[i][EnterY], Businesses[i][EnterZ]) || PlayerToPoint(3.0,playerid,Businesses[i][ExitX], Businesses[i][ExitY], Businesses[i][ExitZ]))
				{
					new playername[MAX_PLAYER_NAME];
					GetPlayerName(playerid,playername,sizeof(playername));
					if(PlayerInfo[playerid][pBizKey] == i && strcmp(playername, Businesses[PlayerInfo[playerid][pBizKey]][Owner], true) == 0)
					{
						if(Businesses[i][Locked] == 1)
						{
			    			if(PlayerInfo[playerid][pSex] == 1)
						    {
								Businesses[i][Locked] = 0;
								SendClientMessage(playerid, COLOR_WHITE, "(INFO) Door Unlocked");
			                    PlayerActionMessage(playerid,15.0,"puts in his key and opens the door");
			                    SaveBusinesses();
		                    }
		                    else
						    {
								Businesses[i][Locked] = 0;
								SendClientMessage(playerid, COLOR_WHITE, "(INFO) Door Unlocked");
			                    PlayerActionMessage(playerid,15.0,"puts in her key and opens the door");
			                    SaveBusinesses();
		                    }
							return 1;
						}
						if(Businesses[i][Locked] == 0)
						{
						    if(PlayerInfo[playerid][pSex] == 1)
						    {
								Businesses[i][Locked] = 1;
								SendClientMessage(playerid, COLOR_WHITE, "(INFO) Door Locked");
			                    PlayerActionMessage(playerid,15.0,"puts in his key and locks the door");
			                    SaveBusinesses();
		                    }
		                    else
						    {
								Businesses[i][Locked] = 1;
								SendClientMessage(playerid, COLOR_WHITE, "(INFO) Door Locked");
			                    PlayerActionMessage(playerid,15.0,"puts in her key and locks the door");
			                    SaveBusinesses();
		                    }
							return 1;
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a key for this business");
						return 1;
					}
				}
			}
	    }
	    return 1;
	}
 	if(strcmp(cmd, "/renthouse", true) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
			new Float:oldposx, Float:oldposy, Float:oldposz;
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			GetPlayerPos(playerid, oldposx, oldposy, oldposz);
			for(new h = 0; h < sizeof(Houses); h++)
			{
				if(PlayerToPoint(2.0,playerid, Houses[h][EnterX], Houses[h][EnterY], Houses[h][EnterZ]) && Houses[h][Owned] == 1 &&  Houses[h][Rentable] == 1)
				{
					if(PlayerInfo[playerid][pHouseKey] != 255 && strcmp(playername, Houses[PlayerInfo[playerid][pHouseKey]][Owner], true) == 0)
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You already own a house");
						return 1;
					}
					if(GetPlayerCash(playerid) >= Houses[h][RentCost])
					{
						PlayerInfo[playerid][pHouseKey] = h;
						GivePlayerCash(playerid,-Houses[h][RentCost]);
						Houses[h][Money] = Houses[h][Money]+Houses[h][RentCost];
						SetPlayerInterior(playerid,Houses[h][ExitInterior]);
						SetPlayerPos(playerid,Houses[h][ExitX],Houses[h][ExitY],Houses[h][ExitZ]);
						SetPlayerVirtualWorld(playerid,h);
						SendClientMessage(playerid, COLOR_WHITE, "(INFO) House successfully rented, the money you paid is a one time fee");
						OnPlayerDataSave(playerid);
						return 1;
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not afford it");
						return 1;
					}
				}
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/rentfee", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			new bouse = PlayerInfo[playerid][pHouseKey];
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			if (bouse != 255 && strcmp(playername, Houses[PlayerInfo[playerid][pHouseKey]][Owner], true) == 0)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /rentfee [amount]");
					return 1;
				}
				if(strval(tmp) < 1 || strval(tmp) > 99999)
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) Please enter an amount between $1-99999");
					return 1;
				}
				Houses[bouse][RentCost] = strval(tmp);
				SaveHouses();
				format(string, sizeof(string), "(INFO) You have set the rent fee to: $%d", Houses[bouse][RentCost]);
				SendClientMessage(playerid, COLOR_WHITE, string);
				return 1;
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not own a house");
				return 1;
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/editrenting", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			if (PlayerInfo[playerid][pHouseKey] != 255 && strcmp(playername, Houses[PlayerInfo[playerid][pHouseKey]][Owner], true) == 0)
			{
				if(Houses[PlayerInfo[playerid][pHouseKey]][Rentable] == 0)
				{
    				SendClientMessage(playerid, COLOR_WHITE, "(INFO) Renting enabled");
				    Houses[PlayerInfo[playerid][pHouseKey]][Rentable] = 1;
				    SaveHouses();
				}
				else if(Houses[PlayerInfo[playerid][pHouseKey]][Rentable] == 1)
				{
    				SendClientMessage(playerid, COLOR_WHITE, "(INFO) Renting disabled");
				    Houses[PlayerInfo[playerid][pHouseKey]][Rentable] = 0;
				    SaveHouses();
				}
				return 1;
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not own a house ");
				return 1;
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/buyhouse", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new Float:oldposx, Float:oldposy, Float:oldposz;
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			GetPlayerPos(playerid, oldposx, oldposy, oldposz);
			for(new h = 0; h < sizeof(Houses); h++)
			{
				if(PlayerToPoint(2.0,playerid, Houses[h][EnterX], Houses[h][EnterY], Houses[h][EnterZ]) && Houses[h][Owned] == 0)
				{
				    if(Houses[h][HousePrice] == 0)
				    {
				        SendClientMessage(playerid, COLOR_GREY, "(ERROR) A price is not set for this house, it's possibly not meant to be used");
						return 1;
				    }
					if(PlayerInfo[playerid][pHouseKey] != 255 && strcmp(playername, Houses[PlayerInfo[playerid][pHouseKey]][Owner], true) == 0)
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can only own one house, please sell your original house first");
						return 1;
					}
					if(GetPlayerCash(playerid) > Houses[h][HousePrice])
					{
      					PlayerInfo[playerid][pHouseKey] = h;
						Houses[h][Owned] = 1;
						strmid(Houses[h][Owner], playername, 0, strlen(playername), 255);
						GivePlayerCash(playerid,-Houses[h][HousePrice]);
						SetPlayerInterior(playerid,Houses[h][ExitInterior]);
						SetPlayerVirtualWorld(playerid,h);
						SetPlayerPos(playerid,Houses[h][ExitX],Houses[h][ExitY],Houses[h][ExitZ]);
						SendClientMessage(playerid, COLOR_WHITE, "(INFO) You have successfully purchased this property");
	       				PlayerActionMessage(playerid,15.0,"signs the contract and looks at the house");
						ChangeStreamPickupModel(Houses[h][PickupID],1239);
						SaveHouses();
						OnPlayerDataSave(playerid);
						return 1;
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
						return 1;
					}
				}
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/businessfee", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			new bouse = PlayerInfo[playerid][pBizKey];
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid,playername,sizeof(playername));
			if (bouse != 255 && strcmp(playername, Businesses[PlayerInfo[playerid][pBizKey]][Owner], true) == 0)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /businessfee [amount]");
				}
				if(strval(tmp) < 0 || strval(tmp) > 99999)
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) Minimum entrance is fee $0, Maximum entrance is fee $99999");
					return 1;
				}
				Businesses[bouse][EntranceCost] = strval(tmp);
				format(string, sizeof(string), "(INFO) Business Entrance fee set to $%d", Businesses[bouse][EntranceCost]);
				SendClientMessage(playerid, COLOR_WHITE, string);
				SaveBusinesses();
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not own a business");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/businessname", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			new bouse = PlayerInfo[playerid][pBizKey];
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid,playername,sizeof(playername));
			if (bouse != 255 && strcmp(playername, Businesses[PlayerInfo[playerid][pBizKey]][Owner], true) == 0)
			{
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
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /businessname [name]");
				}
				if(PlayerToPoint(1.0,playerid,Businesses[bouse][EnterX],Businesses[bouse][EnterY],Businesses[bouse][EnterZ]) || PlayerToPoint(25.0,playerid,Businesses[bouse][ExitX],Businesses[bouse][ExitY],Businesses[bouse][ExitZ]))
				{
				    if(strfind( result , "|" , true ) == -1)
				    {
						strmid(Businesses[bouse][BusinessName], result, 0, 64, 255);
						format(string, sizeof(string), "[INFO:} You have set your business name to: %s",Businesses[bouse][BusinessName]);
						SendClientMessage(playerid, COLOR_WHITE, string);
						SaveBusinesses();
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid symbol, the symbol | is not allowed");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You must be at your business entrance/inside your business to change it's name");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not own a business");
			}
		}
		return 1;
	}
 	if (strcmp(cmd, "/businessinfo", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			new bouse = PlayerInfo[playerid][pBizKey];
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid,playername,sizeof(playername));
			if(bouse != 255 && strcmp(playername, Businesses[PlayerInfo[playerid][pBizKey]][Owner], true) == 0)
			{
 				if(PlayerToPoint(1.0,playerid,Businesses[bouse][EnterX],Businesses[bouse][EnterY],Businesses[bouse][EnterZ]) || PlayerToPoint(20.0,playerid,Businesses[bouse][ExitX],Businesses[bouse][ExitY],Businesses[bouse][ExitZ]))
				{
					format(string, sizeof(string), "(INFO) Business Name: %s - Till: $%d - Locked: %d - Products: %d - Entrance Fee: $%d", Businesses[bouse][BusinessName],Businesses[bouse][Till],Businesses[bouse][Locked],Businesses[bouse][Products],Businesses[bouse][EntranceCost]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					return 1;
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in your business");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not own a business");
			}
		}
		return 1;
	}
  	if(strcmp(cmd, "/sellbusiness", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			if(PlayerInfo[playerid][pBizKey] != 255 && strcmp(playername, Businesses[PlayerInfo[playerid][pBizKey]][Owner], true) == 0)
			{
			    new biz = PlayerInfo[playerid][pBizKey];
				if(PlayerToPoint(1.0,playerid,Businesses[biz][EnterX],Businesses[biz][EnterY],Businesses[biz][EnterZ]))
				{
					Businesses[biz][Locked] = 1;
					Businesses[biz][Owned] = 0;
					strmid(Businesses[biz][Owner], "None", 0, strlen("None"), 255);
					GivePlayerCash(playerid,Businesses[biz][BizPrice]);
					format(string, sizeof(string), "(INFO) You have sold your business for $%d", Businesses[biz][BizPrice]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					ChangeStreamPickupModel(Businesses[biz][PickupID],1272);
					PlayerInfo[playerid][pBizKey] = 255;
					OnPlayerDataSave(playerid);
  					PlayerActionMessage(playerid,15.0,"tears up the business contract, and then gives away the key");
					SaveBusinesses();
					return 1;
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You must be at your business entrance to sell it");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not own a business");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/buybusiness", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new Float:oldposx, Float:oldposy, Float:oldposz;
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			GetPlayerPos(playerid, oldposx, oldposy, oldposz);
			for(new h = 0; h < sizeof(Businesses); h++)
			{
				if(PlayerToPoint(2.0,playerid, Businesses[h][EnterX], Businesses[h][EnterY], Businesses[h][EnterZ]) && Businesses[h][Owned] == 0)
				{
				    if(Businesses[h][BizPrice] == 0)
				    {
				        SendClientMessage(playerid, COLOR_GREY, "(ERROR) A price is not set for this business");
						return 1;
				    }
					if(PlayerInfo[playerid][pBizKey] != 255 && strcmp(playername, Businesses[PlayerInfo[playerid][pBizKey]][Owner], true) == 0)
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can only own one business, sell your original business first");
						return 1;
					}
					if(GetPlayerCash(playerid) > Businesses[h][BizPrice])
					{
						PlayerInfo[playerid][pBizKey] = h;
						Businesses[h][Owned] = 1;
						strmid(Businesses[h][Owner], playername, 0, strlen(playername), 255);
						GivePlayerCash(playerid,-Businesses[h][BizPrice]);
						SetPlayerInterior(playerid,Businesses[h][ExitInterior]);
						SetPlayerVirtualWorld(playerid,h);
						SetPlayerPos(playerid,Businesses[h][ExitX],Businesses[h][ExitY],Businesses[h][ExitZ]);
						SendClientMessage(playerid, COLOR_WHITE, "(INFO) You have successfully purchased this business");
	       				PlayerActionMessage(playerid,15.0,"signs a contract and receives a key to the business");
						ChangeStreamPickupModel(Businesses[h][PickupID],1239);
						SaveBusinesses();
						OnPlayerDataSave(playerid);
						return 1;
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/housedrugstake", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pHouseKey];
			if(PlayerInfo[playerid][pHouseKey] != 255 && strcmp(playername, Houses[PlayerInfo[playerid][pHouseKey]][Owner], true) == 0)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /housematstake [amount]");
					return 1;
				}
				new materialsdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /housematstake [amount]");
					return 1;
				}
				if (PlayerToPoint(100.0,playerid,Houses[bouse][ExitX],Houses[bouse][ExitY],Houses[bouse][ExitZ]))
				{
				    if(Houses[bouse][Drugs] >= materialsdeposit)
				    {
					    if(GetPlayerVirtualWorld(playerid) == bouse)
					    {
							PlayerInfo[playerid][pDrugs] += materialsdeposit;
							Houses[bouse][Drugs]=Houses[bouse][Drugs]-materialsdeposit;
							format(string, sizeof(string), "(INFO) You have taken %d drugs from your safe, Drugs Total: %d ", materialsdeposit,Houses[bouse][Materials]);
							SendClientMessage(playerid, COLOR_WHITE, string);
	       					PlayerActionMessage(playerid,15.0,"twists the combination on the safe and takes out some drugs");
							SaveHouses();
							return 1;
						}
					}
 					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have that much drugs in your safe");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in your house");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not own a house");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/housedrugsput", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pHouseKey];
			if(PlayerInfo[playerid][pHouseKey] != 255 && strcmp(playername, Houses[PlayerInfo[playerid][pHouseKey]][Owner], true) == 0)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /housedrugsput [amount]");
					return 1;
				}
				new materialsdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /housedrugsput [amount]");
					return 1;
				}
				if (PlayerToPoint(100.0,playerid,Houses[bouse][ExitX],Houses[bouse][ExitY],Houses[bouse][ExitZ]))
				{
				    if(PlayerInfo[playerid][pDrugs] >= materialsdeposit)
				    {
					    if(GetPlayerVirtualWorld(playerid) == bouse)
					    {
					        if(Houses[bouse][Drugs] < 500)
					        {
					            if(materialsdeposit < 501)
					            {
									PlayerInfo[playerid][pDrugs] -= materialsdeposit;
									Houses[bouse][Drugs]=Houses[bouse][Drugs]+materialsdeposit;
									format(string, sizeof(string), "(INFO) You have put %d drugs into your safe, Drugs Total: %d ", materialsdeposit,Houses[bouse][Materials]);
									SendClientMessage(playerid, COLOR_WHITE, string);
			                    	PlayerActionMessage(playerid,15.0,"twists the combination on the safe and puts in some drugs");
									SaveHouses();
								}
								else
								{
	                                SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not enter more than 500");
								}
							}
							else
							{
                                SendClientMessage(playerid, COLOR_GREY, "(ERROR) You have exceeded the maximum amount of drugs allowed in a house. (500)");
							}
							return 1;
						}
					}
 					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have that much drugs");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in your house");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not own a house");
			}
		}
		return 1;
	}
   	if(strcmp(cmd, "/housematsput", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pHouseKey];
			if(PlayerInfo[playerid][pHouseKey] != 255 && strcmp(playername, Houses[PlayerInfo[playerid][pHouseKey]][Owner], true) == 0)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /housematsput [amount]");
					return 1;
				}
				new materialsdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /housematsput [amount]");
					return 1;
				}
				if (PlayerToPoint(100.0,playerid,Houses[bouse][ExitX],Houses[bouse][ExitY],Houses[bouse][ExitZ]))
				{
				    if(PlayerInfo[playerid][pMaterials] >= materialsdeposit)
				    {
					    if(GetPlayerVirtualWorld(playerid) == bouse)
					    {
					        if(Houses[bouse][Materials] < 2000)
					        {
					            if(materialsdeposit < 2001)
					            {
									PlayerInfo[playerid][pMaterials] -= materialsdeposit;
									Houses[bouse][Materials]=Houses[bouse][Materials]+materialsdeposit;
									format(string, sizeof(string), "(INFO) You have put %d materials into your safe, Materials Total: %d ", materialsdeposit,Houses[bouse][Materials]);
									SendClientMessage(playerid, COLOR_WHITE, string);
			                    	PlayerActionMessage(playerid,15.0,"twists the combination on the safe and puts in some weapon materials");
									SaveHouses();
								}
								else
								{
	                                SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not enter more than 2000");
								}
							}
							else
							{
                                SendClientMessage(playerid, COLOR_GREY, "(ERROR) You have exceeded the maximum amount of materials allowed in a house. (2000)");
							}
							return 1;
						}
					}
 					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have that much materials");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in your house");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not own a house");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/housematstake", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pHouseKey];
			if(PlayerInfo[playerid][pHouseKey] != 255 && strcmp(playername, Houses[PlayerInfo[playerid][pHouseKey]][Owner], true) == 0)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /housematstake [amount]");
					return 1;
				}
				new materialsdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /housematstake [amount]");
					return 1;
				}
				if (PlayerToPoint(100.0,playerid,Houses[bouse][ExitX],Houses[bouse][ExitY],Houses[bouse][ExitZ]))
				{
				    if(Houses[bouse][Materials] >= materialsdeposit)
				    {
					    if(GetPlayerVirtualWorld(playerid) == bouse)
					    {
							PlayerInfo[playerid][pMaterials] += materialsdeposit;
							Houses[bouse][Materials]=Houses[bouse][Materials]-materialsdeposit;
							format(string, sizeof(string), "(INFO) You have taken %d materials from your safe, Materials Total: %d ", materialsdeposit,Houses[bouse][Materials]);
							SendClientMessage(playerid, COLOR_WHITE, string);
	       					PlayerActionMessage(playerid,15.0,"twists the combination on the safe and takes out some weapon materials");
							SaveHouses();
							return 1;
						}
					}
 					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have that much materials in your safe");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in your house");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not own a house");
			}
		}
		return 1;
	}
	//==========================================================================
	if(strcmp(cmd, "/engine", true) == 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
		    if(EngineStatus[GetPlayerVehicleID(playerid)] == 0)
			{
				TogglePlayerControllable(playerid,1);
				EngineStatus[GetPlayerVehicleID(playerid)] = 1;
				PlayerActionMessage(playerid,15.0,"turns on the engine of the vehicle");
			}
			else
			{
				TogglePlayerControllable(playerid,0);
				EngineStatus[GetPlayerVehicleID(playerid)] = 0;
				PlayerActionMessage(playerid,15.0,"turns off the engine of the vehicle he is in");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in a car");
		}
		return 1;
	}
	if (strcmp(cmdtext, "/rconpass", true)==0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
	SendClientMessage(playerid, COLOR_LSPD, "RCON PASSWORD: AK3H4NJ9");
	}
	}
	if (strcmp(cmdtext, "/lock", true)==0)
	{
		if(IsPlayerInAnyVehicle(playerid))
  {
            new State=GetPlayerState(playerid);
			if(State!=PLAYER_STATE_DRIVER)
			{
				SendClientMessage(playerid,COLOR_GREY,"You can only lock the doors as the driver.");
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
			SendClientMessage(playerid, COLOR_GREY, "Vehicle locked!");
			PlayerActionMessage(playerid,15.0,"presses a button that locks his vehicle");
		}
		else
		{
		SendClientMessage(playerid, COLOR_GREY, "You're not in a vehicle.");
		}
	    return 1;
	}
	if (strcmp(cmdtext, "/unlock", true)==0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new State = GetPlayerState(playerid);
			if(State!=PLAYER_STATE_DRIVER)
			{
				SendClientMessage(playerid,COLOR_GREY,"You can only unlock the doors as the driver.");
				return 1;
			}
			new i;
			for(i=0;i<MAX_PLAYERS;i++)
			{
				SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
			}
			SendClientMessage(playerid, COLOR_GREY, "Vehicle unlocked!");
			PlayerActionMessage(playerid,15.0,"presses a button that unlocks his vehicle");
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "You're not in a vehicle!");
		}
	    return 1;
	}
	if(strcmp(cmd, "/admins", true) == 0)
	{
        if(IsPlayerConnected(playerid))
	    {
	        new count = 0;
			SendClientMessage(playerid, COLOR_RED, "<|> Admins Online <|>");
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
				    if(PlayerInfo[i][pAdmin] >= 1)
				    {
						format(string, 256, "Administrator: %s - [Administrator Level: %d]", GetPlayerNameEx(i),PlayerInfo[i][pAdmin]);
						SendClientMessage(playerid, COLOR_WHITE, string);
						count++;
					}
				}
			}
			if(count == 0)
			{
				SendClientMessage(playerid, COLOR_WHITE, "(INFO) Currently no administrators");
			}
			SendClientMessage(playerid, COLOR_RED, "<|> Admins Online <|>");
		}
		return 1;
	}
 	if(strcmp(cmd, "/changepass", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (gPlayerLogged[playerid])
			{
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
					idx++;
				}
				new offset = idx;
				new result[128];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
					result[idx - offset] = cmdtext[idx];
					idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /changepass [newpass]");
					return 1;
				}
				if(strfind( result , "," , true ) == -1)
    			{
		   			strmid(PlayerInfo[playerid][pKey], (result), 0, strlen((result)), 128);
					format(string, sizeof(string), "(INFO) You have set your password to: %s", (result));
					SendClientMessage(playerid, COLOR_WHITE, string);
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid symbol , is not allowed");
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/accept", true) == 0)
	{
 	if(IsPlayerConnected(playerid))
 	{
		new x_info[256];
		x_info = strtok(cmdtext, idx);
	    new wstring[128];

		if(!strlen(x_info)) {
			SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /accept [usage]");
			SendClientMessage(playerid, COLOR_WHITE, "(USAGES) faction | ticket | car | beg | live | products");
			SendClientMessage(playerid, COLOR_WHITE, "(USAGES) refill  | repair");
			
			return 1;
		}
		if(strcmp(x_info, "faction", true) == 0)
		{
		    new faction = FactionRequest[playerid];
			if (FactionRequest[playerid] != 255)
			{
				if(PlayerInfo[playerid][pFaction] == 255)
				{
	   				format(wstring, sizeof(wstring), "(INFO) Congratulations! You are now a member of: %s",DynamicFactions[faction][fName]);
				    SendClientMessage(playerid,COLOR_LIGHTBLUE, wstring);
					PlayerInfo[playerid][pFaction] = FactionRequest[playerid];
					PlayerInfo[playerid][pRank] = DynamicFactions[faction][fJoinRank];
					SetPlayerSpawn(playerid);
					FactionRequest[playerid] = 255;
					format(wstring, sizeof(wstring), "(FACTION) %s joined the faction",GetPlayerNameEx(playerid));
					SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_LIGHTBLUE, wstring);
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are already in a faction, leave that first");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You have not been offered to join a faction");
			}
		}
  		else if(strcmp(x_info, "ticket", true) == 0)
		{
			    if(TicketOffer[playerid] < 999)
			    {
			        if(IsPlayerConnected(TicketOffer[playerid]))
			        {
			            if (ProxDetectorS(3.0, playerid, TicketOffer[playerid]))
						{
							if(GetPlayerCash(playerid) >= TicketMoney[playerid])
						    {
								format(string, sizeof(string), "(INFO) Ticket Paid - Cost: $%d", TicketMoney[playerid]);
								SendClientMessage(playerid, COLOR_WHITE, string);
								format(string, sizeof(string), "(INFO) %s paid your ticket - Cost: $%d", GetPlayerNameEx(playerid), TicketMoney[playerid]);
								SendClientMessage(TicketOffer[playerid], COLOR_WHITE, string);
								GivePlayerCash(playerid, - TicketMoney[playerid]);
								GivePlayerCash(TicketOffer[playerid], TicketMoney[playerid]);
								TicketOffer[playerid] = 999;
								TicketMoney[playerid] = 0;
								return 1;
							}
							else
							{
							    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
							    return 1;
							}
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You must be near the officer that gave you the ticket");
						    return 1;
						}
			        }
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a ticket");
				    return 1;
				}
			}
			else if(strcmp(x_info, "live", true) == 0)
			{
			    if(LiveOffer[playerid] < 999)
			    {
			        if(IsPlayerConnected(LiveOffer[playerid]))
			        {
				        if (ProxDetectorS(5.0, playerid, LiveOffer[playerid]))
						{
						    SendClientMessage(playerid, COLOR_WHITE, "(INFO) You are frozen till the Live Conversation ends");
							SendClientMessage(LiveOffer[playerid], COLOR_WHITE, "(INFO) You are frozen till the Live Conversation ends (use /live again)");
							TogglePlayerControllable(playerid, 0);
							TogglePlayerControllable(LiveOffer[playerid], 0);
							TalkingLive[playerid] = LiveOffer[playerid];
							TalkingLive[LiveOffer[playerid]] = playerid;
							LiveOffer[playerid] = 999;
							return 1;
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are to far away from the News Reporter");
							return 1;
						}
					}
					return 1;
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) No-one gave you a Live Conversation offer");
				    return 1;
				}
			}
   			else if(strcmp(x_info, "car", true) == 0)
			{
			    if(CarOffer[playerid] < 999)
			    {
			        if(IsPlayerConnected(CarOffer[playerid]))
			        {
			            if(GetPlayerMoney(playerid) > CarPrice[playerid])
			            {
			                if(IsPlayerInVehicle(CarOffer[playerid], CarID[playerid]))
			                {
				                GetPlayerName(CarOffer[playerid], giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
								new points;
								points = 4;
				                format(string, sizeof(string), "(INFO) You bought a car for $%d from %s",CarPrice[playerid],giveplayer);
								SendClientMessage(playerid, COLOR_WHITE, string);
								format(string, sizeof(string), "(INFO) You sold your car to %s for $%d",sendername,CarPrice[playerid]);
								SendClientMessage(CarOffer[playerid], COLOR_WHITE, string);
								GivePlayerCash(playerid, -CarPrice[playerid]);
								GivePlayerCash(CarOffer[playerid], CarPrice[playerid]);
								RemovePlayerFromVehicle(CarOffer[playerid]);
								CarCalls[playerid] = points;
						        CarOffer[playerid] = 999;
								CarPrice[playerid] = 0;
								return 1;
							}
							else
							{
							    SendClientMessage(playerid, COLOR_GREY, "(ERROR) The player is not in the offered car");
						    	return 1;
							}
			            }
						else
						{
						    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not afford the car");
						    return 1;
						}
			        }
			        return 1;
			    }
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You have not been offered to buy a car");
				    return 1;
				}
			}
			else if(strcmp(x_info, "beg" ,true) == 0)
			{
			    if(BegOffer[playerid] < 999)
			    {
			        if(IsPlayerConnected(BegOffer[playerid]))
			        {
			            if(GetPlayerMoney(playerid) > BegPrice[playerid])
			            {
               				GetPlayerName(BegOffer[playerid], giveplayer, sizeof(giveplayer));
							GetPlayerName(playerid, sendername, sizeof(sendername));
       						format(string, sizeof(string), "(INFO) You gave $%d to %s",BegPrice[playerid],giveplayer);
							SendClientMessage(playerid, COLOR_WHITE, string);
							format(string, sizeof(string), "(INFO) You recieved $%d from %s",BegPrice[playerid],sendername);
							SendClientMessage(BegOffer[playerid], COLOR_WHITE, string);
							GivePlayerCash(playerid, -BegPrice[playerid]);
							GivePlayerCash(BegOffer[playerid], BegPrice[playerid]);
       						BegOffer[playerid] = 999;
							BegPrice[playerid] = 0;
							return 1;
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
						    return 1;
						}
			        }
		        	return 1;
			    }
    			else
				{
    				return 1;
				}
			}
			else if(strcmp(x_info,"repair",true) == 0)
			{
			    if(RepairOffer[playerid] < 999)
			    {
			        if(GetPlayerMoney(playerid) > RepairPrice[playerid])
				    {
					    if(IsPlayerInAnyVehicle(playerid))
					    {
					        if(IsPlayerConnected(RepairOffer[playerid]))
					        {
						        GetPlayerName(RepairOffer[playerid], giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
						        RepairCar[playerid] = GetPlayerVehicleID(playerid);
						        RepairVehicle(RepairCar[playerid]);
								format(string, sizeof(string), "(INFO) Your vehicle has been repaired for $%d by mechanic %s",RepairPrice[playerid],giveplayer);
								SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
								format(string, sizeof(string), "(INFO) You fixed %s's vehicle for $%d",sendername,RepairPrice[playerid]);
								SendClientMessage(RepairOffer[playerid], COLOR_WHITE, string);
								GivePlayerCash(playerid, -RepairPrice[playerid]);
								GivePlayerCash(RepairOffer[playerid], RepairPrice[playerid]);
						        RepairOffer[playerid] = 999;
								RepairPrice[playerid] = 0;
								return 1;
							}
							return 1;
						}
						return 1;
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not afford the repair");
					    return 1;
					}
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY, "(ERROR) No-one offered you to repair your vehicle");
			        return 1;
			    }
			}
			else if(strcmp(x_info,"refill",true) == 0)
			{
			    if(RefillOffer[playerid] < 999)
			    {
			        if(IsPlayerConnected(RefillOffer[playerid]))
			        {
			            if(GetPlayerMoney(playerid) > RefillPrice[playerid])
			            {
			                GetPlayerName(RefillOffer[playerid], giveplayer, sizeof(giveplayer));
							GetPlayerName(playerid, sendername, sizeof(sendername));
			                new car = gLastCar[playerid];
			                new fuel;
			                fuel = 100;
			                format(string, sizeof(string), "(INFO) Your vehicle has been refueled with %d% for $%d by mechanic %s",fuel,RefillPrice[playerid],giveplayer);
							SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "(INFO) You refilled %s's vehicle with %d% for $%d",sendername,fuel,RefillPrice[playerid]);
							SendClientMessage(RefillOffer[playerid], COLOR_WHITE, string);
							GivePlayerCash(RefillOffer[playerid], RefillPrice[playerid]);
							GivePlayerCash(playerid, -RefillPrice[playerid]);
							if(Fuel[car] < GasMax) { Fuel[car] += fuel; }
					        RefillOffer[playerid] = 999;
							RefillPrice[playerid] = 0;
							return 1;
			            }
						else
						{
						    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You cant afford the refill");
						    return 1;
						}
			        }
			        return 1;
			    }
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) No-one offered to refill your vehicle");
				    return 1;
				}
			}
     		else if(strcmp(x_info, "products", true) == 0)
			{
			    if(ProductsOffer[playerid] < 999)
			    {
			        if(IsPlayerConnected(ProductsOffer[playerid]))
			        {
			            if (ProxDetectorS(5.0, playerid, ProductsOffer[playerid]))
						{
						    if(GetPlayerCash(playerid) >= ProductsCost[playerid])
						    {
								if(PlayerInfo[playerid][pBizKey] != 255)
								{
									format(string, sizeof(string), "(INFO) Products Purchased - Cost: $%d", ProductsCost[playerid]);
									SendClientMessage(playerid, COLOR_WHITE, string);
									format(string, sizeof(string), "(INFO) %s bought products from you - Cost: $%d", GetPlayerNameEx(playerid), ProductsCost[playerid]);
									SendClientMessage(ProductsOffer[playerid], COLOR_WHITE, string);
									new bizkey = PlayerInfo[playerid][pBizKey];
									Businesses[bizkey][Products] += ProductsAmount[playerid];
									GivePlayerCash(playerid, -ProductsCost[playerid]);
									GivePlayerCash(ProductsOffer[playerid], ProductsCost[playerid]);
									PlayerInfo[ProductsOffer[playerid]][pProducts] -= ProductsAmount[playerid];
									ProductsOffer[playerid] = 999;
									ProductsCost[playerid] = 0;
									ProductsAmount[playerid] = 0;
									SaveBusinesses();
									return 1;
								}
							}
							else
							{
							    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
							    return 1;
							}
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not near the player that offered you products");
						    return 1;
						}
			        }
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You have not been offered products");
				    return 1;
				}
			}
	}
	return 1;
	}
	if(strcmp(cmd, "/cancel", true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
			new x_info[256];
			x_info = strtok(cmdtext, idx);
			if(!strlen(x_info)) {
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /cancel [usage]");
				SendClientMessage(playerid, COLOR_WHITE, "(USAGES) faction | ticket | car | beg | live | products");
				SendClientMessage(playerid, COLOR_WHITE, "(USAGES) refill  | repair");
				return 1;
			}
			if(strcmp(x_info,"faction",true) == 0) { FactionRequest[playerid] = 255; }
			else if(strcmp(x_info,"ticket",true) == 0) { TicketOffer[playerid] = 999; TicketMoney[playerid] = 0; }
			else if(strcmp(x_info,"car",true) == 0) { CarOffer[playerid] = 999; CarPrice[playerid] = 0; CarID[playerid] = 0; }
			else if(strcmp(x_info,"beg",true) == 0) { BegOffer[playerid] = 999; BegPrice[playerid] = 0; }
			else if(strcmp(x_info,"refill",true) == 0) { RefillOffer[playerid] = 999; RefillPrice[playerid] = 0; }
			else if(strcmp(x_info,"repair",true) == 0) { RepairOffer[playerid] = 999; RepairPrice[playerid] = 0; RepairCar[playerid] = 0; }
			else if(strcmp(x_info,"live",true) == 0) { LiveOffer[playerid] = 999; }
			else if(strcmp(x_info,"products",true) == 0) { ProductsOffer[playerid] = 999; ProductsCost[playerid] = 0; ProductsAmount[playerid] = 0; }
			else { return 1; }
			format(string, sizeof(string), "(INFO) You have canceled %s", x_info);
			SendClientMessage(playerid, COLOR_WHITE, string);
		}//not connected
		return 1;
	}
	if(strcmp(cmd, "/licenses", true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        new text1[20];
	        new text2[20];
	        new text3[20];
	        new text4[20];
	        if(PlayerInfo[playerid][pCarLic]) { text1 = "Yes"; } else { text1 = "No"; }
            if(PlayerInfo[playerid][pFlyLic]) { text2 = "Yes"; } else { text2 = "No"; }
			if(PlayerInfo[playerid][pWepLic]) { text3 = "Yes"; } else { text3 = "No"; }
			if(PlayerInfo[playerid][pVisitPass]) { text4 = "Yes"; } else { text4 = "No"; }

		 	SendClientMessage(playerid, COLOR_RED, "<|> Licenses <|>");
	        format(string, sizeof(string), "** Drivers License: %s - Flying License: %s - Weapon License: %s - Visitors Pass: %s", text1,text2,text3,text4);
			SendClientMessage(playerid, COLOR_WHITE, string);
			SendClientMessage(playerid, COLOR_RED, "<|> Licenses <|>");
		}
	    return 1;
 	}
 	if(strcmp(cmd, "/id", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /id [playerid/partofname]");
				return 1;
			}
			new target;
			target = ReturnUser(tmp);
			new sstring[256];
			if(IsPlayerConnected(target))
			{
			    if(target != INVALID_PLAYER_ID)
			    {
					format(sstring, sizeof(sstring), "(ID: %d) %s - Level: %s",target,GetPlayerNameEx(target),PlayerInfo[target][pLevel]);
					SendClientMessage(playerid, COLOR_WHITE, sstring);
				}
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/showid", true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /showid [playerid/partofname]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if(IsPlayerConnected(giveplayerid))
			{
				if(giveplayerid != INVALID_PLAYER_ID)
				{
				    if (ProxDetectorS(8.0, playerid, giveplayerid))
					{
					    new text1[20];
				        new text2[20];
				        new text3[20];
				        new text4[20];
						if(PlayerInfo[playerid][pCarLic]) { text1 = "Yes"; } else { text1 = "No"; }
                        if(PlayerInfo[playerid][pFlyLic]) { text2 = "Yes"; } else { text2 = "No"; }
						if(PlayerInfo[playerid][pWepLic]) { text3 = "Yes"; } else { text3 = "No"; }
						if(PlayerInfo[playerid][pVisitPass]) { text4 = "Yes"; } else { text4 = "No"; }
						SendClientMessage(giveplayerid,COLOR_RED,"<|> Identification: <|>");
				        format(string, sizeof(string), "Name: %s", GetPlayerNameEx(playerid));
				        SendClientMessage(giveplayerid, COLOR_WHITE, string);
				        format(string, sizeof(string), "Drivers License: %s - Flying License: %s - Weapon License: %s - Visitors Pass: %s", text1,text2,text3,text4);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						if(PlayerInfo[playerid][pHouseKey] != 255)
						{
						    new houselocation[MAX_ZONE_NAME];
							GetCoords2DZone(Houses[PlayerInfo[playerid][pHouseKey]][EnterX],Houses[PlayerInfo[playerid][pHouseKey]][EnterY], houselocation, MAX_ZONE_NAME);
	      					format(string, sizeof(string), "Home Address: %d %s", PlayerInfo[playerid][pHouseKey], houselocation);
							SendClientMessage(giveplayerid, COLOR_WHITE, string);
						}
						else
						{
							SendClientMessage(giveplayerid, COLOR_WHITE, "Home Address: None");
						}
						if(PlayerInfo[playerid][pBizKey] != 255 && strcmp(PlayerName(playerid), Businesses[PlayerInfo[playerid][pBizKey]][Owner], true) == 0)
						{
	      					format(string, sizeof(string), "Business: %s", Businesses[PlayerInfo[playerid][pBizKey]][BusinessName]);
							SendClientMessage(giveplayerid, COLOR_WHITE, string);
						}
						else
						{
							SendClientMessage(giveplayerid, COLOR_WHITE, "Business: None");
						}
						SendClientMessage(giveplayerid, COLOR_RED, "______________________________________________________________________________________");
						format(string, sizeof(string), "(INFO) You have shown your indentification to: %s", GetPlayerNameEx(giveplayerid));
						SendClientMessage(playerid, COLOR_WHITE, string);

						if(PlayerInfo[playerid][pSex] == 1)
						{
							PlayerPlayerActionMessage(playerid,giveplayerid,10.0,"takes out his ID from his pocket and shows it to");
						}
						else
						{
						    PlayerPlayerActionMessage(playerid,giveplayerid,10.0,"takes out her ID from her pocket and shows it to");
						}
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
					    return 1;
					}
				}
			}
	        else
	        {
	            SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
	            return 1;
	        }
		}
	    return 1;
 	}
	if(strcmp(cmd, "/refuel", true) == 0)
	{
		if(IsAtGasStation(playerid))
		{
			new vehicle = GetPlayerVehicleID(playerid);
			new refillprice;
			if(Fuel[vehicle] <= 30)
			{
				refillprice = random(100);
			}
			else if(Fuel[vehicle] >= 40)
			{
				refillprice = random(70);
			}
			else if(Fuel[vehicle] >= 55)
			{
				refillprice = random(40);
			}
   			if(GetPlayerCash(playerid) >= refillprice)
   			{
   			    if(Fuel[vehicle] <= 99)
   			    {
	      			new form[128];
		        	format(form, sizeof(form), "(INFO) Your car has been refueled for $%d",refillprice);
		        	SendClientMessage(playerid,COLOR_WHITE,form);
			        GivePlayerCash(playerid,-refillprice);
			        Fuel[vehicle] = 100;
		        }
		        else
		        {
		        	SendClientMessage(playerid, COLOR_GREY, "(ERROR) Your fuel tank is full");
		        }
		    }
      		else
      		{
       			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
      		}
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at a Gas Station");
		}
 		return 1;
	}
	if(strcmp(cmd, "/stats", true) == 0)
	{
		ShowStats(playerid,playerid);
		return 1;
	}
	if(strcmp(cmd, "/eject", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	   	{
	        new State;
	        if(IsPlayerInAnyVehicle(playerid))
	        {
         		State=GetPlayerState(playerid);
		        if(State!=PLAYER_STATE_DRIVER)
		        {
		        	SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can only eject as the driver");
		            return 1;
		        }
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /eject [playerid/partofname]");
					return 1;
				}
				new playa;
				playa = ReturnUser(tmp);
				new test;
				test = GetPlayerVehicleID(playerid);
				if(IsPlayerConnected(playa))
				{
				    if(playa != INVALID_PLAYER_ID)
				    {
			    		if(playa == playerid)
				    	{
        					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not eject yourself");
        					return 1;
				    	}
				        if(IsPlayerInVehicle(playa,test))
				        {
							format(string, sizeof(string), "(INFO) You have thrown out %s", GetPlayerNameEx(playa));
							SendClientMessage(playerid, COLOR_WHITE, string);
							format(string, sizeof(string), "(INFO) You have been thrown out of the car by %s", GetPlayerNameEx(playerid));
							SendClientMessage(playa, COLOR_WHITE, string);
							RemovePlayerFromVehicle(playa);
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in your car");
						    return 1;
						}
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in a vehicle");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/donate", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /donate [amount]");
				return 1;
			}
			new moneys;
			moneys = strval(tmp);
			if(moneys < 0)
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid amount");
				return 1;
			}
			if(GetPlayerCash(playerid) < moneys)
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have that much money");
				return 1;
			}
			GivePlayerCash(playerid, -moneys);
			format(string, sizeof(string), "(INFO) %s donated $%d",GetPlayerNameEx(playerid), moneys);
			SendClientMessage(playerid, COLOR_WHITE, string);
			PayLog(string);
		}
		return 1;
	}
	if(strcmp(cmd, "/lotto", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pLottoNr] > 0)
	        {
	            SendClientMessage(playerid, COLOR_GREY, "(ERROR) You already have a lottery ticket");
	            return 1;
	        }
	        if(GetPlayerMoney(playerid) < 10)
	        {
	            SendClientMessage(playerid, COLOR_GREY, "(ERROR) You need $500 for a lottery ticket");
	            return 1;
	        }
	        tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /lotto [number]");
				return 1;
			}
			new lottonr = strval(tmp);
			if(lottonr < 1 || lottonr > 80) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) Lottery Number not below 1 or above 80"); return 1; }
			format(string, sizeof(string), "(INFO) You bought a Lottery Ticket with number: %d", lottonr);
			SendClientMessage(playerid, COLOR_WHITE, string);
   			PlayerInfo[playerid][pLottoNr] = lottonr;
   			GivePlayerCash(playerid,-500);
	    }
	    return 1;
	}
	if(strcmp(cmd, "/report", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /report [playerid] [reason]");
				return 1;
			}
			new id = strval(tmp);
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /report [playerid] [reason]");
				return 1;
			}
			if(IsPlayerConnected(id))
	    	{
	    		if(id != INVALID_PLAYER_ID)
			    {
					format(string, sizeof(string), "(REPORT) %s reported %s (ID:%d) - Reason: %s",GetPlayerNameEx(playerid),GetPlayerNameEx(id),id,result);
					AdministratorMessage(COLOR_ADMINCMD, string,1);
					format(string, sizeof(string), "(INFO) You have reported %s (ID:%d) - Reason: %s",GetPlayerNameEx(id),id,result);
					SendClientMessage(playerid, COLOR_WHITE, string);
					SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) Report sent");
					ReportLog(string);
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not connected");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/askq", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
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
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /askq [text]");
				return 1;
			}
			format(string, sizeof(string), "(QUESTION) %s: %s", sendername, (result));
			AdministratorMessage(COLOR_ADMINCMD,string,1);
			SendClientMessage(playerid, COLOR_WHITE, "(INFO) Your question message was sent to the Admins");
	    }
	    return 1;
	}
	if(strcmp(cmd, "/kill", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        ClearAnimations(playerid);
	        SetPlayerHealth(playerid, 0.0);
	        PlayerInfo[playerid][pHospital] = 1;
			return 1;
     	}
	}
	if(strcmp(cmd, "/clearanims", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
		 	if(GetPlayerState(playerid) != 2)
	        {
	            return 1;
			}
  			ClearAnimations(playerid);
	    }
	    return 1;
	}
	if(strcmp(cmd, "/coin", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
     		GivePlayerCash(playerid,-1);
			new coin = random(2)+1;
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new coinname[20];
			if(coin == 1) { coinname = "heads"; }
			else { coinname = "tails"; }
			format(string, sizeof(string), "%s flips a coin, it lands on %s", sendername,coinname);
			ProxDetector(5.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
		return 1;
	}
	if(strcmp(cmd, "/dice", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new dice = random(6)+1;
			if (Dice[playerid] == 1)
			{
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "%s throws a dice, it lands on %d", sendername,dice);
				ProxDetector(5.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a dice");
				return 1;
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/frisk", true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /frisk [playerid/partofname]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if(IsPlayerConnected(giveplayerid))
			{
				if(giveplayerid != INVALID_PLAYER_ID)
				{
   					if(giveplayerid == playerid)
				    {
        				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not frisk yourself");
        				return 1;
				    }
				    if (ProxDetectorS(8.0, playerid, giveplayerid))
					{
					    if(CopOnDuty[playerid] == 0) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not on duty"); return 1; }
					    new text1[128], text2[128];
					    if(PlayerInfo[giveplayerid][pDrugs] > 0) { text1 = "(FRISK) Drugs found"; } else { text1 = "(FRISK) No drugs found"; }
					    if(PlayerInfo[giveplayerid][pMaterials] > 0) { text2 = "(FRISK) Weapon materials found"; } else { text2 = "(FRISK) No materials found"; }
					    format(string, sizeof(string), "<|> %s <|>", GetPlayerNameEx(giveplayerid));
				        SendClientMessage(playerid, COLOR_RED, string);
				        format(string, sizeof(string), "%s", text1);
						SendClientMessage(playerid, COLOR_WHITE, string);
						format(string, sizeof(string), "%s", text2);
						SendClientMessage(playerid, COLOR_WHITE, string);
						new Player_Weapons[13];
						new Player_Ammos[13];
						new i;

						for(i = 1;i <= 12;i++)
						{
							GetPlayerWeaponData(giveplayerid,i,Player_Weapons[i],Player_Ammos[i]);
							if(Player_Weapons[i] != 0)
							{
								new weaponName[128];
								GetWeaponName(Player_Weapons[i],weaponName,255);
								format(string,255,"(FRISK) Weapon found: %s",weaponName);
								SendClientMessage(playerid,COLOR_WHITE,string);
							}
						}
						SendClientMessage(playerid, COLOR_RED, "<|> Frisk <|>");
						PlayerPlayerActionMessage(playerid,giveplayerid,15.0,"frisked");
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
					    return 1;
					}
				}
			}
	        else
	        {
	            SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
	            return 1;
	        }
		}
	    return 1;
 	}
 	if(strcmp(cmd, "/bail", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	   	{
			if(PlayerInfo[playerid][pJailed] == 1)
			{
			    if(JailPrice[playerid] > 0)
			    {
			        if(GetPlayerMoney(playerid) > JailPrice[playerid])
			        {
			            format(string, sizeof(string), "(INFO) You bailed yourself out for $%d", JailPrice[playerid]);
						SendClientMessage(playerid, COLOR_WHITE, string);
						GivePlayerCash(playerid, -JailPrice[playerid]);
						JailPrice[playerid] = 0;
						PlayerInfo[playerid][pJailTime] = 1;
			        }
			        else
			        {
			            SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not afford the bail price");
			        }
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a bail price");
			    }
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in jail");
			}
		}//not connected
		return 1;
	}
	if(strcmp(cmd, "/tie", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pLevel] >= 3)
			{
			    tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /tie [playerid/partofname]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
			    if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
					    if(PlayerTied[giveplayerid] == 1)
					    {
					        SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is already tied");
					        return 1;
					    }
	        			if(PlayerCuffed[giveplayerid] == 1)
			        	{
			            	SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is cuffed");
			            	return 1;
			        	}
   				    	if(giveplayerid == playerid)
				    	{
        					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not tie yourself");
        					return 1;
				    	}
						if (ProxDetectorS(8.0, playerid, giveplayerid))
						{
						    new car = GetPlayerVehicleID(playerid);
						    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == 2 && IsPlayerInVehicle(giveplayerid, car))
						    {
						        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
						        format(string, sizeof(string), "(INFO) You have been tied up by %s", sendername);
								SendClientMessage(giveplayerid, COLOR_WHITE, string);
								format(string, sizeof(string), "(INFO) You tied %s up", giveplayer);
								SendClientMessage(playerid, COLOR_WHITE, string);
								format(string, sizeof(string), "%s ties %s up", sendername ,giveplayer);
								ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
								TogglePlayerControllable(giveplayerid, 0);
								PlayerTied[giveplayerid] = 1;
						    }
						    else
						    {
						        SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in your car or you are not the driver");
						        return 1;
						    }
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
						    return 1;
						}
					}
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not connected");
				    return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the required level to use this command");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/untie", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pLevel] >= 3)
			{
			    tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /untie [playerid/partofname]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
				if(IsPlayerConnected(giveplayerid))
				{
					if(giveplayerid != INVALID_PLAYER_ID)
					{
    					if(giveplayerid == playerid)
				    	{
        					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not untie yourself");
        					return 1;
				    	}
					    if (ProxDetectorS(8.0, playerid, giveplayerid))
						{
							if(PlayerTied[giveplayerid])
							{
							    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
							    format(string, sizeof(string), "(INFO) You have been untied by %s", sendername);
								SendClientMessage(giveplayerid, COLOR_WHITE, string);
								format(string, sizeof(string), "(INFO) You untied %s", giveplayer);
								SendClientMessage(playerid, COLOR_WHITE, string);
								TogglePlayerControllable(giveplayerid, 1);
								PlayerTied[giveplayerid] = 0;
								format(string, sizeof(string), "%s unties %s", sendername, giveplayer);
      							ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							}
							else
							{
							    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not tied up");
							    return 1;
							}
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
						    return 1;
						}
					}
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not connected");
				    return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the required level to use this command");
			}
		}//not connected
		return 1;
	}
	if(strcmp(cmd, "/searchwallet", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
     		if(PlayerInfo[playerid][pLevel] < 3)
	        {
	            SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the required level to use this command");
	            return 1;
	        }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
			    SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /searchwallet [playerid/partofname]");
			    return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			        if(PlayerTied[giveplayerid] != 1)
			        {
			            SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player must be tied");
			            return 1;
			        }
			        if(ProxDetectorS(5.0, playerid, giveplayerid))
			        {
			            GetPlayerName(playerid, sendername, sizeof(sendername));
			            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			            format(string, sizeof(string), "%s has %d$ at his wallet", giveplayer, GetPlayerMoney(giveplayerid));
			            SendClientMessage(playerid, COLOR_WHITE, string);
			            return 1;
			        }
			        else
			        {
			            SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
			            return 1;
			        }
			    }
			}
	    }
	    return 1;
	}
 	if(strcmp(cmd, "/shownotes", true) == 0)
    {
        if(IsPlayerConnected(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "<|> Note Book <|>");
            format(string, sizeof(string), "1| %s", PlayerInfo[playerid][pNote1]);
            SendClientMessage(playerid, COLOR_WHITE, string);
            format(string, sizeof(string), "2| %s", PlayerInfo[playerid][pNote2]);
            SendClientMessage(playerid, COLOR_WHITE, string);
            format(string, sizeof(string), "3| %s", PlayerInfo[playerid][pNote3]);
            SendClientMessage(playerid, COLOR_WHITE, string);
            format(string, sizeof(string), "4| %s", PlayerInfo[playerid][pNote4]);
            SendClientMessage(playerid, COLOR_WHITE, string);
            format(string, sizeof(string), "5| %s", PlayerInfo[playerid][pNote5]);
            SendClientMessage(playerid, COLOR_WHITE, string);
            SendClientMessage(playerid, COLOR_RED, "<|> Note Book <|>");
            GetPlayerName(playerid, sendername, sizeof(sendername));
            format(string, sizeof(string), "%s takes out his notebook", sendername);
      		ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        }
        return 1;
    }
    if(strcmp(cmd, "/deletenote", true) == 0)
    {
        if(IsPlayerConnected(playerid))
        {
            new x_nr[256];
            x_nr = strtok(cmdtext, idx);
			if(!strlen(x_nr))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /deletenote [slot(1-5)]");
				return 1;
			}
			if(strcmp(x_nr, "1", true) == 0)
			{
			    if(PlayerInfo[playerid][pNote1s] == 1)
			    {
			    	strmid(PlayerInfo[playerid][pNote1], "None", 0, strlen("None"), 255);
			    	PlayerInfo[playerid][pNote1s] = 0;
			    	SendClientMessage(playerid, COLOR_WHITE, "(INFO) Note (slot 1) has been successfully deleted");
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a note at slot 1");
				}
			}
			else if(strcmp(x_nr, "2", true) == 0)
			{
			    if(PlayerInfo[playerid][pNote2s] == 1)
			    {
			    	strmid(PlayerInfo[playerid][pNote2], "None", 0, strlen("None"), 255);
			    	PlayerInfo[playerid][pNote2s] = 0;
			    	SendClientMessage(playerid, COLOR_WHITE, "(INFO) Note (slot 2) has been successfully deleted");
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a note at slot 2");
				}
			}
			else if(strcmp(x_nr, "3", true) == 0)
			{
			    if(PlayerInfo[playerid][pNote3s] == 1)
			    {
			    	strmid(PlayerInfo[playerid][pNote3], "None", 0, strlen("None"), 255);
			    	PlayerInfo[playerid][pNote3s] = 0;
			    	SendClientMessage(playerid, COLOR_WHITE, "(INFO) Note (slot 3) has been successfully deleted");
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a note at slot 3");
				}
			}
			else if(strcmp(x_nr, "4", true) == 0)
			{
			    if(PlayerInfo[playerid][pNote4s] == 1)
			    {
			    	strmid(PlayerInfo[playerid][pNote4], "None", 0, strlen("None"), 255);
			    	PlayerInfo[playerid][pNote4s] = 0;
			    	SendClientMessage(playerid, COLOR_WHITE, "(INFO) Note (slot 4) has been successfully deleted");
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a note at slot 4");
				}
			}
			else if(strcmp(x_nr, "5", true) == 0)
			{
			    if(PlayerInfo[playerid][pNote5s] == 1)
			    {
			    	strmid(PlayerInfo[playerid][pNote5], "None", 0, strlen("None"), 255);
			    	PlayerInfo[playerid][pNote5s] = 0;
			    	SendClientMessage(playerid, COLOR_WHITE, "(INFO) Note (slot 5) has been successfully deleted");
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a note at slot 5");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Wrong slot ID");
			    return 1;
			}
        }
        return 1;
    }
    if(strcmp(cmd, "/createnote", true) == 0)
    {
        if(IsPlayerConnected(playerid))
        {
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
			if(length > 60)
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Note is too long");
			    return 1;
			}
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /createnote [text]");
				return 1;
			}
			if(PlayerInfo[playerid][pNote1s] == 0)
			{
			    strmid(PlayerInfo[playerid][pNote1], result, 0, strlen(result), 255);
			    PlayerInfo[playerid][pNote1s] = 1;
			    SendClientMessage(playerid, COLOR_WHITE, "(INFO) Note successfully created");
			    return 1;
			}
			else if(PlayerInfo[playerid][pNote2s] == 0)
			{
			    strmid(PlayerInfo[playerid][pNote2], result, 0, strlen(result), 255);
			    PlayerInfo[playerid][pNote2s] = 1;
			    SendClientMessage(playerid, COLOR_WHITE, "(INFO) Note successfully created");
			    return 1;
			}
			else if(PlayerInfo[playerid][pNote3s] == 0)
			{
			    strmid(PlayerInfo[playerid][pNote3], result, 0, strlen(result), 255);
			    PlayerInfo[playerid][pNote3s] = 1;
			    SendClientMessage(playerid, COLOR_WHITE, "(INFO) Note successfully created");
			    return 1;
			}
			else if(PlayerInfo[playerid][pNote4s] == 0)
			{
			    strmid(PlayerInfo[playerid][pNote4], result, 0, strlen(result), 255);
			    PlayerInfo[playerid][pNote4s] = 1;
			    SendClientMessage(playerid, COLOR_WHITE, "(INFO) Note successfully created");
			    return 1;
			}
			else if(PlayerInfo[playerid][pNote5s] == 0)
			{
			    strmid(PlayerInfo[playerid][pNote5], result, 0, strlen(result), 255);
			    PlayerInfo[playerid][pNote5s] = 1;
			    SendClientMessage(playerid, COLOR_WHITE, "(INFO) Note successfully created");
			    return 1;
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You have no free pages left in your notebook");
			    return 1;
			}
        }
        return 1;
    }
    if(strcmp(cmd, "/givenote", true) == 0)
    {
        if(IsPlayerConnected(playerid))
        {
            tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /givenote [playerid/partofname] [note id]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			        new Float:x, Float:y, Float:z;
           			GetPlayerPos(giveplayerid,x,y,z);
			        if(!PlayerToPoint(5,playerid, x, y, z))
			        {
			            SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
			            return 1;
			        }
			        new x_nr[256];
			        x_nr = strtok(cmdtext, idx);
					if(!strlen(x_nr))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /givenote [playerid/partofname] [note id]");
						return 1;
					}
					if(strcmp(x_nr ,"1", true) == 0)
					{
					    if(PlayerInfo[playerid][pNote1s] == 1)
					    {
					        if(PlayerInfo[giveplayerid][pNote1s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote1], PlayerInfo[playerid][pNote1], 0, strlen(PlayerInfo[playerid][pNote1]), 255);
					            PlayerInfo[giveplayerid][pNote1s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else if(PlayerInfo[giveplayerid][pNote2s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote2], PlayerInfo[playerid][pNote1], 0, strlen(PlayerInfo[playerid][pNote1]), 255);
					            PlayerInfo[giveplayerid][pNote2s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else if(PlayerInfo[giveplayerid][pNote3s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote3], PlayerInfo[playerid][pNote1], 0, strlen(PlayerInfo[playerid][pNote1]), 255);
					            PlayerInfo[giveplayerid][pNote3s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else if(PlayerInfo[giveplayerid][pNote4s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote4], PlayerInfo[playerid][pNote1], 0, strlen(PlayerInfo[playerid][pNote1]), 255);
					            PlayerInfo[giveplayerid][pNote4s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else if(PlayerInfo[giveplayerid][pNote5s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote5], PlayerInfo[playerid][pNote1], 0, strlen(PlayerInfo[playerid][pNote1]), 255);
					            PlayerInfo[giveplayerid][pNote5s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else
					        {
					            SendClientMessage(playerid, COLOR_GREY, "(ERROR) That players notebook is full");
					            return 1;
					        }
					    }
					    else
					    {
					        SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a note at slot 1");
					        return 1;
					    }
					}
					else if(strcmp(x_nr, "2", true) == 0)
					{
					    if(PlayerInfo[playerid][pNote2s] == 1)
					    {
					        if(PlayerInfo[giveplayerid][pNote1s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote1], PlayerInfo[playerid][pNote2], 0, strlen(PlayerInfo[playerid][pNote2]), 255);
					            PlayerInfo[giveplayerid][pNote1s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else if(PlayerInfo[giveplayerid][pNote2s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote2], PlayerInfo[playerid][pNote2], 0, strlen(PlayerInfo[playerid][pNote2]), 255);
					            PlayerInfo[giveplayerid][pNote2s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else if(PlayerInfo[giveplayerid][pNote3s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote3], PlayerInfo[playerid][pNote2], 0, strlen(PlayerInfo[playerid][pNote2]), 255);
					            PlayerInfo[giveplayerid][pNote3s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else if(PlayerInfo[giveplayerid][pNote4s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote4], PlayerInfo[playerid][pNote2], 0, strlen(PlayerInfo[playerid][pNote2]), 255);
					            PlayerInfo[giveplayerid][pNote4s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else if(PlayerInfo[giveplayerid][pNote5s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote5], PlayerInfo[playerid][pNote2], 0, strlen(PlayerInfo[playerid][pNote2]), 255);
					            PlayerInfo[giveplayerid][pNote5s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else
					        {
					            SendClientMessage(playerid, COLOR_GREY, "(ERROR) That players notebook is full");
					            return 1;
					        }
					    }
					    else
					    {
					        SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a note at slot 2");
					        return 1;
					    }
					}
					else if(strcmp(x_nr, "3", true) == 0)
					{
					    if(PlayerInfo[playerid][pNote3s] == 1)
					    {
					        if(PlayerInfo[giveplayerid][pNote1s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote1], PlayerInfo[playerid][pNote3], 0, strlen(PlayerInfo[playerid][pNote3]), 255);
					            PlayerInfo[giveplayerid][pNote1s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else if(PlayerInfo[giveplayerid][pNote2s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote2], PlayerInfo[playerid][pNote3], 0, strlen(PlayerInfo[playerid][pNote3]), 255);
					            PlayerInfo[giveplayerid][pNote2s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else if(PlayerInfo[giveplayerid][pNote3s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote3], PlayerInfo[playerid][pNote3], 0, strlen(PlayerInfo[playerid][pNote3]), 255);
					            PlayerInfo[giveplayerid][pNote3s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else if(PlayerInfo[giveplayerid][pNote4s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote4], PlayerInfo[playerid][pNote4], 0, strlen(PlayerInfo[playerid][pNote4]), 255);
					            PlayerInfo[giveplayerid][pNote4s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else if(PlayerInfo[giveplayerid][pNote5s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote5], PlayerInfo[playerid][pNote5], 0, strlen(PlayerInfo[playerid][pNote5]), 255);
					            PlayerInfo[giveplayerid][pNote5s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else
					        {
					            SendClientMessage(playerid, COLOR_GREY, "(ERROR) That players notebook is full");
					            return 1;
					        }
					    }
					    else
					    {
					        SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a note at slot 3");
					        return 1;
					    }
					}
					else if(strcmp(x_nr, "4", true) == 0)
					{
					    if(PlayerInfo[playerid][pNote4s] == 1)
					    {
					        if(PlayerInfo[giveplayerid][pNote1s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote1], PlayerInfo[playerid][pNote4], 0, strlen(PlayerInfo[playerid][pNote4]), 255);
					            PlayerInfo[giveplayerid][pNote1s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else if(PlayerInfo[giveplayerid][pNote2s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote2], PlayerInfo[playerid][pNote4], 0, strlen(PlayerInfo[playerid][pNote4]), 255);
					            PlayerInfo[giveplayerid][pNote2s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else if(PlayerInfo[giveplayerid][pNote3s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote3], PlayerInfo[playerid][pNote4], 0, strlen(PlayerInfo[playerid][pNote4]), 255);
					            PlayerInfo[giveplayerid][pNote3s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else if(PlayerInfo[giveplayerid][pNote4s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote4], PlayerInfo[playerid][pNote4], 0, strlen(PlayerInfo[playerid][pNote4]), 255);
					            PlayerInfo[giveplayerid][pNote4s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else if(PlayerInfo[giveplayerid][pNote5s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote5], PlayerInfo[playerid][pNote4], 0, strlen(PlayerInfo[playerid][pNote4]), 255);
					            PlayerInfo[giveplayerid][pNote5s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else
					        {
					            SendClientMessage(playerid, COLOR_GREY, "(ERROR) That players notebook is full");
					            return 1;
					        }
					    }
					    else
					    {
					        SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a note at slot 4");
					        return 1;
					    }
					}
					else if(strcmp(x_nr, "5", true) == 0)
					{
					    if(PlayerInfo[playerid][pNote5s] == 1)
					    {
					        if(PlayerInfo[giveplayerid][pNote1s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote1], PlayerInfo[playerid][pNote5], 0, strlen(PlayerInfo[playerid][pNote5]), 255);
					            PlayerInfo[giveplayerid][pNote1s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else if(PlayerInfo[giveplayerid][pNote2s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote2], PlayerInfo[playerid][pNote5], 0, strlen(PlayerInfo[playerid][pNote5]), 255);
					            PlayerInfo[giveplayerid][pNote2s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else if(PlayerInfo[giveplayerid][pNote3s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote3], PlayerInfo[playerid][pNote5], 0, strlen(PlayerInfo[playerid][pNote5]), 255);
					            PlayerInfo[giveplayerid][pNote3s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else if(PlayerInfo[giveplayerid][pNote4s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote4], PlayerInfo[playerid][pNote5], 0, strlen(PlayerInfo[playerid][pNote5]), 255);
					            PlayerInfo[giveplayerid][pNote4s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else if(PlayerInfo[giveplayerid][pNote5s] == 0)
					        {
					            strmid(PlayerInfo[giveplayerid][pNote5], PlayerInfo[playerid][pNote5], 0, strlen(PlayerInfo[playerid][pNote5]), 255);
					            PlayerInfo[giveplayerid][pNote5s] = 1;
					            GetPlayerName(playerid, sendername, sizeof(sendername));
					            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					            format(string, sizeof(string), "(INFO) You have sent a note to [ID:%d] %s", giveplayerid, giveplayer);
					            SendClientMessage(playerid, COLOR_WHITE, string);
					            format(string, sizeof(string), "(INFO) You have received a note from [ID:%d] %s", playerid, sendername);
					            SendClientMessage(giveplayerid, COLOR_WHITE, string);
					        }
					        else
					        {
					            SendClientMessage(playerid, COLOR_GREY, "(ERROR) That players notebook is full");
					            return 1;
					        }
					    }
					    else
					    {
					        SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a note at slot 5");
					        return 1;
					    }
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Wrong note ID");
					    return 1;
					}
			    }
			}
        }
        return 1;
    }
    if(strcmp(cmd, "/plantbomb", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(Bomb[playerid] == 1)
	        {
		        if(GetPlayerState(playerid) != 2)
		        {
		            new Float:bx[MAX_PLAYERS], Float:by[MAX_PLAYERS], Float:bz[MAX_PLAYERS];

					TextDrawShowForPlayer(playerid, Meter1[playerid]);
					TextDrawShowForPlayer(playerid, Meter2[playerid]);
					TextDrawShowForPlayer(playerid, Meter3[playerid]);
					UpdateMeterTimer[playerid] = SetTimerEx("UpdateMeter", 500, 1, "i", playerid);

				    GetPlayerPos(playerid, bx[playerid], by[playerid], bz[playerid]);
					C4[playerid] = CreateObject(1252, bx[playerid], by[playerid], bz[playerid]-1, -87.6624853592, 0.000000, 0.000000);
					Planted[playerid] = 1;
					ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.0,0,0,0,0,1000);
					Bomb[playerid] = 0;
					SendClientMessage(playerid, COLOR_WHITE, "(INFO) Bomb planted");
					return 1;
				} else SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are unable to plant the bomb");
			} else SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a bomb");
		}
		return 1;
	}
 	if(strcmp(cmd, "/detonatebomb", true) == 0)
    {
    	if(IsPlayerConnected(playerid))
	    {
        	if(Planted[playerid] == 1)
        	{
            	if(!IsPlayerInAnyVehicle(playerid))
            	{
                	new Float:bx[MAX_PLAYERS], Float:by[MAX_PLAYERS], Float:bz[MAX_PLAYERS];

					GetObjectPos(C4[playerid], bx[playerid], by[playerid], bz[playerid]);
                	if(PlayerToPoint(360, playerid, bx[playerid], by[playerid], bz[playerid]))
                	{
		            	GivePlayerWeapon(playerid, 40, 1);
		            	ClearAnimations(playerid);
		            	ApplyAnimation(playerid,"PED","bomber",4.0,0,0,0,0,1000);
		            	SetTimerEx("Explode", 1200, 0, "i", playerid);
						TextDrawHideForPlayer(playerid, Meter1[playerid]);
						TextDrawHideForPlayer(playerid, Meter2[playerid]);
						TextDrawHideForPlayer(playerid, Meter3[playerid]);
						KillTimer(UpdateMeterTimer[playerid]);
		            	return 1;
					}
					else
					{
						GameTextForPlayer(playerid, "~r~Out Of Range", 2000, 3);
						ClearAnimations(playerid);
		            	ApplyAnimation(playerid,"PED","bomber",4.0,0,0,0,0,1000);
					}
				}
			}
		}
		return 1;
	}
   	if(strcmp(cmd, "/sellcar", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(!IsPlayerInAnyVehicle(playerid))
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in a car");
			    return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /sellcar [playerid/partofname] [price]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /sellcar [playerid/partofname] [price]");
				return 1;
			}
			new money = strval(tmp);
			if(money < 1 || money > 99999) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) Sell price not below $1 or above $99999"); return 1; }
			if (IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			    	if(giveplayerid == playerid)
				    {
        				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not sell a car to yourself");
        				return 1;
				    }
			     	if(CarCalls[giveplayerid] > 0)
				    {
        				SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player has already bought a car, has to use /callcar");
        				return 1;
				    }
			        if (ProxDetectorS(8.0, playerid, giveplayerid))
					{
					    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
					    format(string, sizeof(string), "(INFO) You offered %s to buy your car for $%d", giveplayer, money);
						SendClientMessage(playerid, COLOR_WHITE, string);
						format(string, sizeof(string), "(INFO) %s offered to sell you his car for $%d, (type /accept car) to buy", sendername, money);
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
						CarOffer[giveplayerid] = playerid;
						CarPrice[giveplayerid] = money;
						CarID[giveplayerid] = GetPlayerVehicleID(playerid);
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
					}
			    }
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
			    return 1;
			}
	    }
		return 1;
	}
	if(strcmp(cmd, "/callcar", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
		    if(CarCalls[playerid] > 0)
		    {
		        new Float:plocx,Float:plocy,Float:plocz;
	            GetPlayerPos(playerid, plocx, plocy, plocz);
				SetVehiclePos(CarID[playerid],plocx,plocy+4, plocz);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "(INFO) Your vehicle has arrived at your location");
				CarCalls[playerid] -= 1;
				format(string, sizeof(string), "(INFO) You can call your vehicle for %d more times", CarCalls[playerid]);
				SendClientMessage(playerid, COLOR_WHITE, string);
		    }
      		else
		    {
		        SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid action");
		    }
		}
	    return 1;
	}
   	if(strcmp(cmd, "/beg", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /beg [playerid/partofname] [amount]");
				return 1;
			}
			giveplayerid = strval(tmp);
			giveplayerid = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /beg [playerid/partofname] [amount]");
				return 1;
			}
			new money = strval(tmp);
			if(money < 1 || money > 2000) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) Beg price not below $1 or above $2000"); return 1; }
			if (IsPlayerConnected(giveplayerid))
			{
   				if(giveplayerid != INVALID_PLAYER_ID)
			    {
  					if(giveplayerid == playerid)
			    	{
       					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not beg from yourself");
       					return 1;
			    	}
					if (ProxDetectorS(8.0, playerid, giveplayerid))
				   	{
	       				GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					   	GetPlayerName(playerid, sendername, sizeof(sendername));
		       			format(string, sizeof(string), "(INFO) You asked %s for $%d to buy some food and clothes", giveplayer, money);
					   	SendClientMessage(playerid, COLOR_WHITE, string);
					   	format(string, sizeof(string), "(INFO) %s is asking you for $%d to get some food and clothes, (type /accept beg)", sendername, money);
					   	SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
					   	BegOffer[giveplayerid] = playerid;
					   	BegPrice[giveplayerid] = money;
			    	}
				    else
				    {
        				SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
				    }
		 		}
			}
			else
			{
  				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
    			return 1;
			}
  		}
		return 1;
	}
	if(strcmp(cmd, "/blindfold", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /blindfold [playerid/partofname]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if(giveplayerid != INVALID_PLAYER_ID)
   			{
		    	if(giveplayerid == playerid)
   			    {
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not blind yourself");
					return 1;
				}
				if(PlayerCuffed[playerid] == 1)
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not do this while cuffed");
				    return 1;
				}
				if(PlayerTazed[playerid] == 1)
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not do this while tazed");
				    return 1;
				}
				if(PlayerTied[playerid] == 1)
				{
				    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not do this while tied");
				    return 1;
				}
				if(PlayerTied[giveplayerid] == 1)
				{
 					if(GetDistanceBetweenPlayers(playerid,giveplayerid) < 5)
					{
 						GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
	       				SetPlayerCameraPos(giveplayerid, -833.5241,-1358.8575,86.9054);
						format(string, sizeof(string), "(INFO) You were blindfolded by %s", sendername);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						format(string, sizeof(string), "(INFO) You blindfolded %s", giveplayer);
						SendClientMessage(playerid, COLOR_WHITE, string);
						format(string, sizeof(string), "%s takes out a rag and blindfolds %s", sendername ,giveplayer);
						ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
      					Blindfold[giveplayerid] = SetTimerEx("BlindfoldTimer", 300000, 0, "i", giveplayerid);
	   		    		return SetPlayerCameraLookAt(giveplayerid, -830.8118,-1360.3612,87.0289);
					}
					else
					{
					    return SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
					}
				}
				else if(PlayerCuffed[giveplayerid] == 1)
				{
 					if(GetDistanceBetweenPlayers(playerid,giveplayerid) < 5)
					{
 						GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
	       				SetPlayerCameraPos(giveplayerid, -833.5241,-1358.8575,86.9054);
						format(string, sizeof(string), "(INFO) You were blindfolded by %s", sendername);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						format(string, sizeof(string), "(INFO) You blindfolded %s", giveplayer);
						SendClientMessage(playerid, COLOR_WHITE, string);
						format(string, sizeof(string), "%s takes out a rag and blindfolds %s", sendername ,giveplayer);
						ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
      					Blindfold[giveplayerid] = SetTimerEx("BlindfoldTimer", 300000, 0, "i", giveplayerid);
	   		    		return SetPlayerCameraLookAt(giveplayerid, 2000,-2000,2000);
					}
					else
					{
					    return SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
					}
				}
			}
			else
			{
			    return SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/unblindfold", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(INFO) /unblindfold [playerid]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if(giveplayerid != INVALID_PLAYER_ID)
   			{
    			if(GetDistanceBetweenPlayers(playerid,giveplayerid) < 5)
				{
    				GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "(INFO) Your blindfolds were removed by %s", sendername);
					SendClientMessage(giveplayerid, COLOR_WHITE, string);
					format(string, sizeof(string), "(INFO) You removed %s's blindfolds", giveplayer);
					SendClientMessage(playerid, COLOR_WHITE, string);
					format(string, sizeof(string), "%s unwraps %s's blindfolds", sendername ,giveplayer);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
 					KillTimer(Blindfold[giveplayerid]);
   					return SetCameraBehindPlayer(giveplayerid);
				}
			}
			else
   			{
			    return SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
			}
		}
		return 1;
	}
	//==========================================================================
	if(strcmp(cmd, "/ooc", true) == 0 || strcmp(cmd, "/o", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if ((OOCStatus) == 0 && PlayerInfo[playerid][pAdmin] < 1)
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Global OOC is currently disabled");
				return 1;
			}
			if(Muted[playerid])
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are muted");
				return 1;
			}
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) [/ooc] or [/o] [message]");
				return 1;
			}
			if(PlayerInfo[playerid][pAdmin] >= 1 && AdminDuty[playerid] == 1)
			{
				format(string, sizeof(string), "(( Admin %s: %s ))", GetPlayerNameEx(playerid), result);
				SendClientMessageToAll(COLOR_ADMINDUTY,string);
				OOCLog(string);
				return 1;
			}
			else if(PlayerInfo[playerid][pDonator] == 1)
			{
				format(string, sizeof(string), "(( Donator %s: %s ))", GetPlayerNameEx(playerid), result);
				SendClientMessageToAll(COLOR_NEWOOC,string);
				OOCLog(string);
			}
			else
			{
				format(string, sizeof(string), "(( %s: %s ))", GetPlayerNameEx(playerid), result);
				SendClientMessageToAll(COLOR_NEWOOC,string);
				OOCLog(string);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/b", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
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
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /b [local ooc chat]");
				return 1;
			}
			format(string, sizeof(string), "(( %s says: %s ))", GetPlayerNameEx(playerid), result);
			ProxDetector(20.0, playerid, string,COLOR_GREY,COLOR_GREY,COLOR_GREY,COLOR_GREY,COLOR_GREY);
			OOCLog(string);
		}
		return 1;
	}
	if(strcmp(cmd, "/pm", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /pm [playerid/partofname] [text]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			        if(!PMsEnabled[giveplayerid])
			        {
			            SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is blocking messages");
			            return 1;
			        }
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					if(giveplayerid == playerid)
					{
						format(string, sizeof(string), "%s mutters something to himself", sendername);
						ProxDetector(5.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					}
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
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /pm [playerid/partofname] [text]");
						return 1;
					}
					format(string, sizeof(string), "(( PM from %s (ID:%d): %s ))", sendername, playerid, (result));
					SendClientMessage(giveplayerid, COLOR_YELLOW, string);
					format(string, sizeof(string), "(( PM sent to %s (ID: %d): %s ))", giveplayer, giveplayerid, (result));
					SendClientMessage(playerid, COLOR_YELLOW, string);
					PMLog(string);
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not connected");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/low", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /low [message]");
				return 1;
			}
			format(string, sizeof(string), "%s says [low]: %s", GetPlayerNameEx(playerid), result);
			ProxDetector(3.0, playerid, string,COLOR_GREY,COLOR_GREY,COLOR_GREY,COLOR_GREY,COLOR_GREY);
		}
		return 1;
	}
  	if(strcmp(cmd, "/local", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /local [message]");
				return 1;
			}
			format(string, sizeof(string), "%s says: %s", GetPlayerNameEx(playerid), result);
			ProxDetector(5.0, playerid, string,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE);
		}
		return 1;
	}
   	if(strcmp(cmd, "/shout", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /shout [message]");
				return 1;
			}
			format(string, sizeof(string), "%s shouts: %s!!", GetPlayerNameEx(playerid), result);
			ProxDetector(10.0, playerid, string,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE);
		}
		return 1;
	}
	if(strcmp(cmd, "/s", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /s [message]");
				return 1;
			}
			format(string, sizeof(string), "%s shouts: %s!", GetPlayerNameEx(playerid), result);
			ProxDetector(10.0, playerid, string,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE);
		}
		return 1;
	}
	if(strcmp(cmd, "/attempt", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
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
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /attempt [action]");
				return 1;
			}
			new succeed = 1 + random(2);
			if(succeed == 1)
			{
				format(string, sizeof(string), "%s attempted to %s and succeeded", GetPlayerNameEx(playerid), result);
				ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else if(succeed == 2)
			{
				format(string, sizeof(string), "%s attempted to %s and failed", GetPlayerNameEx(playerid), result);
				ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/lottomessage", true) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
		   if (PlayerInfo[playerid][pAdmin] >= 10)
		   {
		   SendClientMessageToAll(COLOR_ADMINCMD, "(LOTTERY NEWS) The lottery will start in a few moments. Do /lotto now. It costs $500.");
		   }
		 }
	}
	if(strcmp(cmd, "/credits", true) == 0)
	{
		 if(IsPlayerConnected(playerid))
		 {
		 SendClientMessage(playerid, COLOR_RED, "<|> Server Credits <|>");
		 SendClientMessage(playerid, COLOR_WHITE, "- The Godfather by Julien209");
		 SendClientMessage(playerid, COLOR_WHITE, "- Original script by euRo` from SA-MP forums");
		 SendClientMessage(playerid, COLOR_WHITE, "- Forums: http://forum.the-god-father.com");
		 }
	}
	if(strcmp(cmd, "/updates", true) == 0)
	{
 		if(IsPlayerConnected(playerid))
		{
		SendClientMessage(playerid, COLOR_RED, "<|> Player Updates <|>");
		SendClientMessage(playerid, COLOR_YELLOW, "All 'cmds' were changed to 'help' (Example: /businesshelp, /policehelp, /househelp)");
		SendClientMessage(playerid, COLOR_YELLOW, "A /seatbelt system was added. When you enter a car you can now do /seatbelt.");
		SendClientMessage(playerid, COLOR_YELLOW, "You can now change your WALK STYLE (FINALLY!). Use /walk to change it.");
		SendClientMessage(playerid, COLOR_YELLOW, "Woo! Anims are now working! Do /animlist to see them!");
		SendClientMessage(playerid, COLOR_YELLOW, "POKERRRRRR! You can now play poker! Use /poker and /cards to learn how!");
		}
	}
 	if(strcmp(cmd, "/me", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
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
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /me [action]");
				return 1;
			}
			new form[128];
			format(form, sizeof(form), "%s",result);
			PlayerActionMessage(playerid,15.0,form);
		}
		return 1;
	}
    if(strcmp(cmd, "/do", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
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
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /do [message]");
				return 1;
			}
			new form[128];
			format(form, sizeof(form), "(( %s ))", result);
			PlayerDoMessage(playerid,15.0,form);
		}
		return 1;
	}
	if(strcmp(cmd, "/whisper", true) == 0 || strcmp(cmd, "/w", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /whisper [playerid/partofname] [message]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
					new length = strlen(cmdtext);
					while ((idx < length) && (cmdtext[idx] <= ' '))
					{
						idx++;
					}
					new offset = idx;
					new result[128];
					while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
					{
						result[idx - offset] = cmdtext[idx];
						idx++;
					}
					result[idx - offset] = EOS;
					if(!strlen(result))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /whisper [playerid/partofname] [message]");
						return 1;
					}
					if (ProxDetectorS(3.0, playerid, giveplayerid))
					{
						if(giveplayerid != playerid)
						{
							format(string, sizeof(string), "%s whispers: %s", GetPlayerNameEx(playerid), result);
							SendClientMessage(giveplayerid, COLOR_YELLOW, string);
							SendClientMessage(playerid, COLOR_YELLOW, string);
							PlayerActionMessage(playerid,5.0,"whispers something.");
						}
						else
						{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You cant whisper yourself");
						}

					}
					else
					{
							SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not close enough");
					}
					return 1;
				}
			}
			else
			{
					format(string, sizeof(string), "(ERROR) No player with the ID %d is connected", strval(tmp));
					SendClientMessage(playerid, COLOR_GREY, string);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/carwindows", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			if(IsABike(GetPlayerVehicleID(playerid)))
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Bikes do not have windows");
			    return 1;
			}
		    if(CarWindowStatus[GetPlayerVehicleID(playerid)] == 1)
		    {
				PlayerActionMessage(playerid,15.0,"rolled the windows down");
				CarWindowStatus[GetPlayerVehicleID(playerid)] = 0;
		    }
		    else if(CarWindowStatus[GetPlayerVehicleID(playerid)] == 0)
		    {
				PlayerActionMessage(playerid,15.0,"rolled up the windows");
				CarWindowStatus[GetPlayerVehicleID(playerid)] = 1;
		    }
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in a vehicle");
		}
		return 1;
	}
	//==========================================================================
	if(strcmp(cmd, "/pay", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /pay [playerid/partofname] [amount]");
				return 1;
			}
	        giveplayerid = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /pay [playerid/partofname] [amount]");
				return 1;
			}
			new moneys,playermoney;
			moneys = strval(tmp);
			if(PlayerInfo[playerid][pAdmin] < 1)
			{
				if(moneys > 1000 && PlayerInfo[playerid][pLevel] < 3)
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the required level for transactions greater than $1000");
					return 1;
				}
			}
			if(moneys < 1 || moneys > 99999)
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid amount");
			    return 1;
			}
			if (IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
					if (ProxDetectorS(5.0, playerid, giveplayerid))
					{
					    if(giveplayerid != playerid)
					    {
							playermoney = GetPlayerCash(playerid);
							if (moneys > 0 && playermoney >= moneys)
							{
	       						GivePlayerCash(playerid, (0 - moneys));
								GivePlayerCash(giveplayerid, moneys);
								format(string, sizeof(string), "(INFO) $%d successfully sent to %s (ID:%d)", moneys, GetPlayerNameEx(giveplayerid),giveplayerid);
								PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
								SendClientMessage(playerid, COLOR_WHITE, string);
								format(string, sizeof(string), "(INFO) %s (ID:%d) sent you $%d",GetPlayerNameEx(playerid), playerid,moneys);
								SendClientMessage(giveplayerid, COLOR_WHITE, string);
								format(string, sizeof(string), "(INFO) %s paid $%d to %s", GetPlayerNameEx(playerid), moneys, GetPlayerNameEx(giveplayerid));
								PayLog(string);
								PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
								PlayerPlayerActionMessage(playerid,giveplayerid,5.0,"takes out cash and hands it to");
							}
							else
							{
								SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid amount");
							}
						}
      					else
						{
							SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not pay yourself");
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player not in range");
					}
				}//invalid id
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
			}
		}
		return 1;
	}
  	if(strcmp(cmd, "/businesswithdraw", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pBizKey];
			if(bouse != 255 && strcmp(playername, Businesses[bouse][Owner], true) == 0)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /businesswithdraw [amount]");
					return 1;
				}
				new cashdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /businesswithdraw [amount]");
					return 1;
				}
				if (PlayerToPoint(20.0,playerid,Businesses[bouse][ExitX],Businesses[bouse][ExitY],Businesses[bouse][ExitZ]))
				{
				    if(Businesses[bouse][Till] >= cashdeposit)
				    {
					    if(GetPlayerVirtualWorld(playerid) == bouse)
					    {
							GivePlayerCash(playerid,cashdeposit);
							Businesses[bouse][Till]=Businesses[bouse][Till]-cashdeposit;
							format(string, sizeof(string), "(INFO) You have withdrawn $%d from your business till, New Total: $%d ", cashdeposit,Businesses[bouse][Till]);
							SendClientMessage(playerid, COLOR_WHITE, string);
	                    	PlayerActionMessage(playerid,15.0,"opens the till and takes out some money");
							SaveBusinesses();
							return 1;
						}
					}
 					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have that much in your till");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in your business");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not own a business");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/businessdeposit", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    	new bizkey = PlayerInfo[playerid][pBizKey];
	    	new playername[MAX_PLAYER_NAME];
	    	GetPlayerName(playerid,playername,sizeof(playername));
	        if(bizkey != 255 && strcmp(playername, Businesses[bizkey][Owner], true) == 0)
	        {
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /businessdeposit [amount]");
					return 1;
				}
				new cashdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /businessdeposit [amount]");
					return 1;
				}
				if(PlayerToPoint(5.0,playerid,Businesses[bizkey][ExitX],Businesses[bizkey][ExitY],Businesses[bizkey][ExitZ]))
				{
						if(GetPlayerCash(playerid) >= cashdeposit)
						{
					        if(Businesses[bizkey][Till] < 500000)
					        {
					            if(cashdeposit < 500001)
					            {
									GivePlayerCash(playerid,-cashdeposit);
									Businesses[bizkey][Till]=cashdeposit+Businesses[bizkey][Till];
									format(string, sizeof(string), "(INFO) You have put $%d into your business till, Total: $%d", cashdeposit,Businesses[bizkey][Till]);
									SendClientMessage(playerid, COLOR_WHITE, string);
				                    PlayerActionMessage(playerid,15.0,"opens the till and puts some money in it");
				                    SaveBusinesses();
									return 1;
								}
								else
								{
									SendClientMessage(playerid, COLOR_GREY, "(ERROR) You may not deposit more than $500,000");
								}
							}
							else
							{
								SendClientMessage(playerid, COLOR_GREY, "(ERROR) The amount you entered exceeds the $500,000 business limit");
							}
						}
						else
						{
							SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have that amount of money");
						}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not inside your business");
				}
   			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not own a business");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/deposit", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerToPoint(5.0,playerid,BankPosition[X],BankPosition[Y],BankPosition[Z]))
	        {
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /deposit [amount]");
					return 1;
				}
				new cashdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /deposit [amount]");
					return 1;
				}
				if(GetPlayerCash(playerid) >= cashdeposit)
				{
					GivePlayerCash(playerid,-cashdeposit);
					PlayerInfo[playerid][pBank]=cashdeposit+PlayerInfo[playerid][pBank];
					format(string, sizeof(string), "(INFO) You have deposited $%d, new balance: $%d", cashdeposit,PlayerInfo[playerid][pBank]);
					SendClientMessage(playerid, COLOR_WHITE, string);
                    PlayerActionMessage(playerid,15.0,"takes out some money and hands it to the bank");
                    OnPlayerDataSave(playerid);
					return 1;
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have that amount of money");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the bank");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/withdraw", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerToPoint(5.0,playerid,BankPosition[X],BankPosition[Y],BankPosition[Z]))
	        {
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /withdraw [amount]");
					return 1;
				}
				new cashdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /withdraw [amount]");
					return 1;
				}
				if(PlayerInfo[playerid][pBank] >= cashdeposit)
				{
					GivePlayerCash(playerid,cashdeposit);
					PlayerInfo[playerid][pBank]=PlayerInfo[playerid][pBank]-cashdeposit;
					format(string, sizeof(string), "(INFO) You have withdrawn $%d, new balance: $%d", cashdeposit,PlayerInfo[playerid][pBank]);
					SendClientMessage(playerid, COLOR_WHITE, string);
                    PlayerActionMessage(playerid,15.0,"receives a package full of money from the bank");
                    OnPlayerDataSave(playerid);
					return 1;
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have that much in your bank");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the bank");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/wiretransfer", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /wiretransfer [playerid/partofname] [amount]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /wiretransfer [playerid/partofname] [amount]");
				return 1;
			}
   			if(PlayerToPoint(5.0,playerid,BankPosition[X],BankPosition[Y],BankPosition[Z]))
   			{
				new moneys = strval(tmp);
				if (IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						new playermoney = PlayerInfo[playerid][pBank] ;
						if (moneys > 0 && playermoney >= moneys)
						{
						    if(giveplayerid != playerid)
						    {
								PlayerInfo[playerid][pBank] -= moneys;
								PlayerInfo[giveplayerid][pBank] += moneys;
								format(string, sizeof(string), "(INFO) You have wired $%d to %s's bank-account", moneys, GetPlayerNameEx(giveplayerid),giveplayerid);
								SendClientMessage(playerid, COLOR_WHITE, string);
								format(string, sizeof(string), "(INFO) You have been wired $%d from %s", moneys, GetPlayerNameEx(playerid), playerid);
								SendClientMessage(giveplayerid, COLOR_WHITE, string);
			                    PlayerActionMessage(playerid,15.0,"types some buttons into the bank-machine and hits enter");
							}
							else
							{
							    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not wiretransfer to yourself");
							}
						}
						else
						{
							SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid amount");
						}
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the bank");
			}
		}
		return 1;
	}
  	if(strcmp(cmd, "/balance", true) == 0)
	{
 		if(PlayerToPoint(5.0,playerid,BankPosition[X],BankPosition[Y],BankPosition[Z]))
		{
			format(string, sizeof(string), "(INFO) Balance: $%d", PlayerInfo[playerid][pBank]);
			SendClientMessage(playerid, COLOR_WHITE, string);
   			PlayerActionMessage(playerid,15.0,"receives a mini-bank statement from the bank");
		}
		else
		{
  			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the bank");
		}
		return 1;
	}
	if(strcmp(cmd, "/housewithdraw", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pHouseKey];
			if(PlayerInfo[playerid][pHouseKey] != 255 && strcmp(playername, Houses[PlayerInfo[playerid][pHouseKey]][Owner], true) == 0)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /housewithdraw [amount]");
					return 1;
				}
				new cashdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /housewithdraw [amount]");
					return 1;
				}
				if (PlayerToPoint(20.0,playerid,Houses[bouse][ExitX],Houses[bouse][ExitY],Houses[bouse][ExitZ]))
				{
				    if(Houses[bouse][Money] >= cashdeposit)
				    {
					    if(GetPlayerVirtualWorld(playerid) == bouse)
					    {
							GivePlayerCash(playerid,cashdeposit);
							Houses[bouse][Money]=Houses[bouse][Money]-cashdeposit;
							format(string, sizeof(string), "(INFO) You have withdrawn $%d from your safe, New Total: $%d ", cashdeposit,Houses[bouse][Money]);
							SendClientMessage(playerid, COLOR_WHITE, string);
	                    	PlayerActionMessage(playerid,15.0,"twists the combination on the safe and takes out some money");
							SaveHouses();
							return 1;
						}
					}
 					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have that much in your safe");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in your house");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not own a house");
			}
		}
		return 1;
	}
  	if(strcmp(cmd, "/housedeposit", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pHouseKey];
			if(bouse != 255 && strcmp(playername, Houses[bouse][Owner], true) == 0)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /housedeposit [amount]");
					return 1;
				}
				new cashdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /housedeposit [amount]");
					return 1;
				}
				if (PlayerToPoint(20.0,playerid,Houses[bouse][ExitX],Houses[bouse][ExitY],Houses[bouse][ExitZ]))
				{
				    if(GetPlayerCash(playerid) >= cashdeposit)
				    {
					    if(GetPlayerVirtualWorld(playerid) == bouse)
					    {
					        if(Houses[bouse][Money] < 150000)
					        {
					            if(cashdeposit < 150001)
					            {
									GivePlayerCash(playerid,-cashdeposit);
									Houses[bouse][Money]=Houses[bouse][Money]+cashdeposit;
									format(string, sizeof(string), "(INFO) You have deposited $%d into your safe, New Total: $%d ", cashdeposit,Houses[bouse][Money]);
									SendClientMessage(playerid, COLOR_WHITE, string);
			                    	PlayerActionMessage(playerid,15.0,"twists the combination on the safe and puts in some money");
									SaveHouses();
								}
 								else
								{
	                                SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not enter more than $150000");
								}
							}
							else
							{
                                SendClientMessage(playerid, COLOR_GREY, "(ERROR) You have exceeded the maximum amount allowed to be stored in a house ($150000)");
							}
							return 1;
						}
					}
 					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have that much money");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in your house");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not own a house");
			}
		}
		return 1;
	}
	//==========================================================================
	if(strcmp(cmd, "/takejob", true) == 0)
	{
	    if(PlayerInfo[playerid][pJob] == 0)
	    {
     		if(PlayerToPoint(1.0,playerid,GunJob[TakeJobX],GunJob[TakeJobY],GunJob[TakeJobZ]))
			{
   				if(GetPlayerVirtualWorld(playerid) == GunJob[TakeJobWorld])
			    {
					SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You are now an arms dealer, type /jobhelp");
					PlayerInfo[playerid][pJob] = 1;
				}
			}
 			else if(PlayerToPoint(1.0,playerid,DrugJob[TakeJobX],DrugJob[TakeJobY],DrugJob[TakeJobZ]))
			{
   				if(GetPlayerVirtualWorld(playerid) == DrugJob[TakeJobWorld])
			    {
					SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You are now a drug dealer, type /jobcmds");
					PlayerInfo[playerid][pJob] = 2;
				}
			}
			else if(PlayerToPoint(1.0,playerid,DetectiveJobPosition[X],DetectiveJobPosition[Y],DetectiveJobPosition[Z]))
			{
   				if(GetPlayerVirtualWorld(playerid) == DetectiveJobPosition[World])
			    {
					SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You are now a Detective, type /jobhelp");
					PlayerInfo[playerid][pJob] = 3;
				}
			}
			else if(PlayerToPoint(1.0,playerid,LawyerJobPosition[X],LawyerJobPosition[Y],LawyerJobPosition[Z]))
			{
   				if(GetPlayerVirtualWorld(playerid) == LawyerJobPosition[World])
			    {
					SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You are now a Lawyer, type /jobhelp");
					PlayerInfo[playerid][pJob] = 4;
				}
			}
			else if(PlayerToPoint(1.0,playerid,ProductsSellerJob[TakeJobX],ProductsSellerJob[TakeJobY],ProductsSellerJob[TakeJobZ]))
			{
   				if(GetPlayerVirtualWorld(playerid) == ProductsSellerJob[TakeJobWorld])
			    {
					SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You are now a Products Seller, type /jobhelp");
					PlayerInfo[playerid][pJob] = 5;
				}
			}
			else if(PlayerToPoint(1.0, playerid, MechanicJobPosition[X], MechanicJobPosition[Y], MechanicJobPosition[Z]))
			{
   				if(GetPlayerVirtualWorld(playerid) == MechanicJobPosition[World])
			    {
					SendClientMessage(playerid,COLOR_WHITE,"(SUCCESS) You are now a Mechanic, type /jobhelp");
					PlayerInfo[playerid][pJob] = 6;
				}
			}
	    }
	    else
	    {
	    	SendClientMessage(playerid, COLOR_GREY, "(ERROR) You already have a job");
	    }
		return 1;
	}
 	if(strcmp(cmd, "/quitjob", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	   	{
		    if(PlayerInfo[playerid][pJob] > 0)
		    {
		        if(PlayerInfo[playerid][pDonateRank] > 0)
		        {
		            if(PlayerInfo[playerid][pContractTime] >= 2)
					{
					    SendClientMessage(playerid, COLOR_WHITE, "(INFO) You already forfilled your 1 hour contract and quit your job");
					    PlayerInfo[playerid][pJob] = 0;
					    PlayerInfo[playerid][pContractTime] = 0;
					}
					else
					{
					    new chours = 2 - PlayerInfo[playerid][pContractTime];
					    format(string, sizeof(string), "(INFO) You still have %d hours left to forfill on your contract", chours / 2);
						SendClientMessage(playerid, COLOR_WHITE, string);
					}
		        }
		        else
		        {
					if(PlayerInfo[playerid][pContractTime] >= 10)
					{
					    SendClientMessage(playerid, COLOR_WHITE, "(INFO) You already forfilled your 5 hour contract and quit your job");
					    PlayerInfo[playerid][pJob] = 0;
					    PlayerInfo[playerid][pContractTime] = 0;
					}
					else
					{
					    new chours = 10 - PlayerInfo[playerid][pContractTime];
					    format(string, sizeof(string), "(INFO) You still have %d hours left to forfill on your contract", chours / 2);
						SendClientMessage(playerid, COLOR_WHITE, string);
					}
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a job");
			}
		}//not connected
		return 1;
	}
	if(strcmp(cmd, "/find", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /find [playerid/partofname]");
				return 1;
			}
			if(TrackingPlayer[playerid] == 1)
			{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are already finding someone");
			return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pJob] == 3)
			{
			    if(IsPlayerConnected(id))
			    {
			        if(playerid != id)
			        {
					    if(id != INVALID_PLAYER_ID)
					    {
							if(PhoneOnline[id] == 0)
							{
								SendClientMessage(id, COLOR_WHITE, "(INFO) Someone is tracking you");
								format(string, sizeof(string), "(INFO) You are tracking %s, checkpoint removed in 60 seconds", GetPlayerNameEx(id));
								SendClientMessage(playerid, COLOR_WHITE, string);
								new Float:x,Float:y,Float:z;
								GetPlayerPos(id,x,y,z);
								SetPlayerCheckpoint(playerid,x,y,z,10.0);
								SetTimerEx("ClearCheckpointsForPlayer", 60000, false, "i", playerid);
								TrackingPlayer[playerid] = 1;

							}
							else
							{
								SendClientMessage(id, COLOR_GREY, "(ERROR) That players phone is off, You are unable to track this person");
							}
						}
					}
					else
					{
						SendClientMessage(id, COLOR_GREY, "(ERROR) You can not track yourself");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not a detective");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/free", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
		    if(PlayerInfo[playerid][pJob] != 4)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not a lawyer");
		        return 1;
		    }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /free [playerid/partofname]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
            if(IsPlayerConnected(giveplayerid))
            {
                if(giveplayerid != INVALID_PLAYER_ID)
                {
  					if(giveplayerid == playerid)
				    {
        				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not free yourself");
        				return 1;
				    }
					if(PlayerInfo[giveplayerid][pJailed] == 1)
					{
							if(GetDistanceBetweenPlayers(playerid,giveplayerid) < 5)
							{
								new jailtime = PlayerInfo[giveplayerid][pJailTime] / 60;
			    				if(jailtime < 15)
								{
									PlayerInfo[giveplayerid][pJailed] = 0;
									JailPrice[giveplayerid] = 0;
									format(string, sizeof(string), "(INFO) You have been set free by lawyer %s", GetPlayerNameEx(playerid));
									SendClientMessage(giveplayerid,COLOR_WHITE, string);
									format(string, sizeof(string), "(INFO) You have set free %s", GetPlayerNameEx(giveplayerid));
									SendClientMessage(playerid,COLOR_WHITE, string);
									SetPlayerVirtualWorld(giveplayerid,2);
								    SetPlayerInterior(giveplayerid, 6);
									SetPlayerPos(giveplayerid,268.0903,77.6489,1001.0391);
								}
								else
								{
									SendClientMessage(playerid, COLOR_GREY, "(ERROR) Jail time must be 15 minutes or below");
								}
							}
							else
							{
								SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
							}
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not jailed");
					}
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/selldrugs", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
		    if(PlayerInfo[playerid][pJob] != 2)
		    {
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not a drugs dealer");
				return 1;
		    }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /selldrugs [playerid/partofname] [amount]");
				return 1;
			}
			new playa;
			new needed;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) { return 1; }
			needed = strval(tmp);
			if(needed < 1 || needed > 50) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) 1-50 only"); return 1; }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) { return 1; }
			if(needed > PlayerInfo[playerid][pDrugs]) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have that much drugs"); return 1; }
			if(IsPlayerConnected(playa))
			{
			    if(playa != INVALID_PLAYER_ID)
			    {
					if (ProxDetectorS(8.0, playerid, playa))
					{
					    if(playa != playerid)
					    {
						    format(string, sizeof(string), "(INFO) You have gave %s %d grams of drugs", GetPlayerNameEx(playa), needed);
							SendClientMessage(playerid, COLOR_WHITE, string);
							format(string, sizeof(string), "(INFO) %s gave you %d grams of drugs", GetPlayerNameEx(playerid), needed);
							SendClientMessage(playa, COLOR_WHITE, string);
							PlayerInfo[playa][pDrugs] += needed;
							PlayerInfo[playerid][pDrugs] -= needed;
							PlayerPlayerActionMessage(playerid,playa,15.0,"gave some drugs to");
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not sell yourself drugs");
						}
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
					}
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/sellweapon", true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
		    if(PlayerInfo[playerid][pJob] != 1)
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not an arms dealer");
			    return 1;
			}
			new x_weapon[256],weapon[MAX_PLAYERS],ammo[MAX_PLAYERS],price[MAX_PLAYERS];
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /sellweapon [playerid/partofname] [weapon]");
				SendClientMessage(playerid, COLOR_WHITE, "(WEAPONS) baseballbat(25) | sdpistol(100) | eagle(200) | mp5(200)");
				SendClientMessage(playerid, COLOR_WHITE, "(WEAPONS) shotgun(200) | ak47(600) | m4(600) | rifle(600)");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
    				if(giveplayerid == playerid)
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not sell weapons to yourself");
						return 1;
					}
					x_weapon = strtok(cmdtext, idx);
					if(!strlen(x_weapon))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /sellweapon [playerid/partofname] [weapon]");
						SendClientMessage(playerid, COLOR_WHITE, "(WEAPONS) baseball bat(25) | sdpistol(100) | deagle(200) | mp5(200)");
						SendClientMessage(playerid, COLOR_WHITE, "(WEAPONS) shotgun(200) | ak47(600) | m4(600) | rifle(600)");
						return 1;
					}
				}
				if(strcmp(x_weapon,"baseballbat",true) == 0) { if(PlayerInfo[playerid][pMaterials] > 24) { weapon[playerid] = 5; price[playerid] = 25; ammo[playerid] = 1; PlayerInfo[giveplayerid][pGun1] = 14; PlayerInfo[giveplayerid][pAmmo1] = 1; } else { SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough materials"); return 1; } }
				else if(strcmp(x_weapon,"sdpistol",true) == 0) { if(PlayerInfo[playerid][pMaterials] > 99) { weapon[playerid] = 23; price[playerid] = 100; ammo[playerid] = 50; PlayerInfo[giveplayerid][pGun2] = 23; PlayerInfo[giveplayerid][pAmmo2] = 50; } else { SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough materials"); return 1; } }
				else if(strcmp(x_weapon,"deagle",true) == 0) { if(PlayerInfo[playerid][pMaterials] > 199) { weapon[playerid] = 24; price[playerid] = 150; ammo[playerid] = 50; PlayerInfo[giveplayerid][pGun2] = 24; PlayerInfo[giveplayerid][pAmmo2] = 50; } else { SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough materials"); return 1; } }
				else if(strcmp(x_weapon,"mp5",true) == 0) {	if(PlayerInfo[playerid][pMaterials] > 199) { weapon[playerid] = 29; price[playerid] = 200; ammo[playerid] = 200; PlayerInfo[giveplayerid][pGun3] = 29; PlayerInfo[giveplayerid][pAmmo3] = 200; } else { SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough materials"); return 1; } }
				else if(strcmp(x_weapon,"shotgun",true) == 0) {	if(PlayerInfo[playerid][pMaterials] > 199) { weapon[playerid] = 25; price[playerid] = 200; ammo[playerid] = 50; PlayerInfo[giveplayerid][pGun4] = 25; PlayerInfo[giveplayerid][pAmmo4] = 50; } else { SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough materials"); return 1; } }
				else if(strcmp(x_weapon,"ak47",true) == 0) { if(PlayerInfo[playerid][pMaterials] > 599) { weapon[playerid] = 30; price[playerid] = 600; ammo[playerid] = 250; PlayerInfo[giveplayerid][pGun4] = 30; PlayerInfo[giveplayerid][pAmmo4] = 250; } else { SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough materials"); return 1; } }
				else if(strcmp(x_weapon,"m4",true) == 0) { if(PlayerInfo[playerid][pMaterials] > 599) { weapon[playerid] = 31; price[playerid] = 600; ammo[playerid] = 250; PlayerInfo[giveplayerid][pGun4] = 31; PlayerInfo[giveplayerid][pAmmo4] = 250; } else { SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough materials"); return 1; } }
				else if(strcmp(x_weapon,"rifle",true) == 0) { if(PlayerInfo[playerid][pMaterials] > 599) { weapon[playerid] = 33; price[playerid] = 600; ammo[playerid] = 50; PlayerInfo[giveplayerid][pGun4] = 33; PlayerInfo[giveplayerid][pAmmo4] = 50; } else { SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough materials"); return 1; } }
				else { SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid weapon name"); return 1; }
				if(ProxDetectorS(5.0, playerid, giveplayerid))
				{
					format(string, sizeof(string), "(INFO) You gave %s, a %s with %d ammo, for %d materials", GetPlayerNameEx(giveplayerid),x_weapon, ammo[playerid], price[playerid]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					format(string, sizeof(string), "(INFO) %s received - Ammo: %d - From %s", x_weapon, ammo[playerid], GetPlayerNameEx(playerid));
					SendClientMessage(giveplayerid, COLOR_WHITE, string);
					PlayerPlayerActionMessage(playerid,giveplayerid,15.0,"takes out a weapon and hands it to");
     				SafeGivePlayerWeapon(giveplayerid,weapon[playerid],ammo[playerid]);
					PlayerInfo[playerid][pMaterials] -= price[playerid];
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/products", true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
		    if (PlayerInfo[playerid][pJob] != 5)
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not a products seller");
			    return 1;
			}
			new x_nr[256];
			x_nr = strtok(cmdtext, idx);
			if(!strlen(x_nr)) {
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /products [usage]");
				SendClientMessage(playerid, COLOR_WHITE, "(USAGES) buy | sell");
				return 1;
			}
			if(strcmp(x_nr, "buy", true) == 0)
			{
			    if(PlayerToPoint(3.0,playerid,ProductsSellerJob[BuyProductsX],ProductsSellerJob[BuyProductsY],ProductsSellerJob[BuyProductsZ]))
			    {
			        if(PlayerInfo[playerid][pProducts] >= 500)
			        {
			            SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not hold more than 500 products");
				        return 1;
			        }
			        tmp = strtok(cmdtext, idx);
			        if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /products [buy] [amount]");
						return 1;
					}
					new moneys;
					moneys = strval(tmp);
					if(moneys < 1 || moneys > 500) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) Maximum number of products is 500"); return 1; }
					new price = moneys * PRODUCT_PRICE;
					if(GetPlayerCash(playerid) > price)
					{
					    format(string, sizeof(string), "(INFO) You bought %d products - Cost: $%d", moneys, price);
					    SendClientMessage(playerid, COLOR_WHITE, string);
					    SendClientMessage(playerid, COLOR_WHITE, "(INFO) You must sell products to business owners");
					    GivePlayerCash(playerid, - price);
					    PlayerInfo[playerid][pProducts] = moneys;
					}
					else
					{
					    format(string, sizeof(string), "(ERROR) You do not have $%d", price);
					    SendClientMessage(playerid, COLOR_GREY, string);
					}
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the products purchase place");
			        return 1;
			    }
			}
			else if(strcmp(x_nr, "sell", true) == 0)
			{
			    tmp = strtok(cmdtext, idx);
       			if(!strlen(tmp))
   				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /products [sell] [playerid/partofname] [amount] [cost]");
					return 1;
				}
				new id;
				id = ReturnUser(tmp);
				if(id == playerid) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not sell yourself products"); return 1;}

                tmp = strtok(cmdtext, idx);
				new amount;
				amount = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /products [sell] [playerid/partofname] [amount] [cost]");
					return 1;
				}
				tmp = strtok(cmdtext, idx);
				new cost;
				cost = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /products [sell] [playerid/partofname] [amount] [cost]");
					return 1;
				}
				if(cost < 1 || cost > 99999) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) Products must be above 1 and below 99999"); return 1; }

				if(IsPlayerConnected(id))
				{
					if(id != INVALID_PLAYER_ID)
					{
						if(GetDistanceBetweenPlayers(playerid,id) < 5)
						{
							ProductsOffer[id] = playerid;
							ProductsAmount[id] = amount;
							ProductsCost[id] = cost;
							format(string, sizeof(string), "(INFO) You have been offered %d products for $%d by %s, (type /accept products)", ProductsAmount[id], ProductsCost[id], GetPlayerNameEx(playerid));
						    SendClientMessage(id, COLOR_LIGHTBLUE, string);
						    format(string, sizeof(string), "(INFO) You offered %s, %d products for $%d", GetPlayerNameEx(id), amount, cost);
						    SendClientMessage(playerid, COLOR_WHITE, string);
							return 1;
						}
						else
						{
							SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range");
						}
	    			}
    			}
    			else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid usage");
			    return 1;
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/drugs", true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
		    if (PlayerInfo[playerid][pJob] != 2)
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not a drug dealer");
			    return 1;
			}
			new x_nr[256];
			x_nr = strtok(cmdtext, idx);
			if(!strlen(x_nr)) {
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /drugs [usage]");
				SendClientMessage(playerid, COLOR_WHITE, "(USAGES) buy | dropoff");
				return 1;
			}
			if(strcmp(x_nr, "buy", true) == 0)
			{
			    if(PlayerToPoint(3.0,playerid,DrugJob[BuyDrugsX],DrugJob[BuyDrugsY],DrugJob[BuyDrugsZ]))
			    {
			        if(DrugsHolding[playerid] >= 50)
			        {
			            SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not hold any more packages");
				        return 1;
			        }
			        tmp = strtok(cmdtext, idx);
			        if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /drugs [buy] [amount]");
						return 1;
					}
					new moneys;
					moneys = strval(tmp);
					if(moneys < 1 || moneys > 50) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) Maximum number of grams is 50"); return 1; }
					new price = moneys * 50;
					if(GetPlayerCash(playerid) > price)
					{
					    format(string, sizeof(string), "(INFO) You got %d grams - Cost: $%d", moneys, price);
					    SendClientMessage(playerid, COLOR_WHITE, string);
					    SendClientMessage(playerid, COLOR_WHITE, "(INFO) You must now deliver the grams");
					    GivePlayerCash(playerid, - price);
					    DrugsHolding[playerid] = moneys;
					}
					else
					{
					    format(string, sizeof(string), "(ERROR) You do not have $%d", price);
					    SendClientMessage(playerid, COLOR_GREY, string);
					}
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the drugs purchase place");
			        return 1;
			    }
			}
			else if(strcmp(x_nr, "dropoff", true) == 0)
			{
			    if(PlayerToPoint(3.0,playerid,DrugJob[DeliverX],DrugJob[DeliverY],DrugJob[DeliverZ]))
			    {
			        if(DrugsHolding[playerid] > 0)
			        {
			            new payout = DrugsHolding[playerid];
			            format(string, sizeof(string), "(INFO) %d drugs delivered, they are now sellable", payout);
					    SendClientMessage(playerid, COLOR_WHITE, string);
			            PlayerInfo[playerid][pDrugs] += payout;
			            DrugsHolding[playerid] = 0;
			        }
			        else
			        {
			            SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have any drugs");
				        return 1;
			        }
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the drugs dropoff place");
			        return 1;
			    }
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid usage");
			    return 1;
			}
		}
		return 1;
	}
	if(strcmp(cmdtext, "/usedrugs", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	   	{
			if(PlayerInfo[playerid][pDrugs] > 1)
			{
			    SendClientMessage(playerid, COLOR_WHITE, "(INFO) 2 grams used");
			    PlayerInfo[playerid][pDrugs] -= 2;
			    PlayerActionMessage(playerid,15.0,"took some drugs");
			    DrugsIntake[playerid] += 2;
			    if(DrugsIntake[playerid] >= 8)
			    {
			    	SetTimerEx("DrugEffect", 1000, false, "i", playerid);
			    }
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have any drugs");
			}
		}//not connected
		return 1;
	}
	if(strcmp(cmd, "/materials", true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
		    if (PlayerInfo[playerid][pJob] != 1)
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not an arms dealer");
			    return 1;
			}
			new x_nr[256];
			x_nr = strtok(cmdtext, idx);
			if(!strlen(x_nr))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /materials [usage]");
				SendClientMessage(playerid, COLOR_WHITE, "(USAGES) buy | dropoff");
				return 1;
			}
			if(strcmp(x_nr, "buy", true) == 0)
			{
			    if(PlayerToPoint(3.0,playerid,GunJob[BuyPackagesX],GunJob[BuyPackagesY],GunJob[BuyPackagesZ]))
			    {
			        if(MatsHolding[playerid] >= 10)
			        {
			            SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not hold any more packages");
				        return 1;
			        }
					new moneys;
					moneys = strval(tmp);
                    if(moneys < 1 || moneys > 10) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) Maximum number of packages is 10"); return 1; }
					new price = moneys * 100;
					if(GetPlayerCash(playerid) > price)
					{
					    format(string, sizeof(string), "(INFO) You got %d materials packages - Cost: $%d", moneys, price);
					    SendClientMessage(playerid, COLOR_WHITE, string);
					    GivePlayerCash(playerid, - price);
					    MatsHolding[playerid] = moneys;
					}
					else
					{
					    format(string, sizeof(string), "(ERROR) You do not have $%d", price);
					    SendClientMessage(playerid, COLOR_GREY, string);
					}
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the materials package place");
			        return 1;
			    }
			}
			else if(strcmp(x_nr, "dropoff", true) == 0)
			{
			    if(PlayerToPoint(3.0,playerid,GunJob[DeliverX],GunJob[DeliverY],GunJob[DeliverZ]))
			    {
			        if(MatsHolding[playerid] > 0)
			        {
			            new payout = (50)*(MatsHolding[playerid]);
			            format(string, sizeof(string), "(INFO) Materials packages delivered, you got %d materials", payout);
					    SendClientMessage(playerid, COLOR_WHITE, string);
			            PlayerInfo[playerid][pMaterials] += payout;
			            MatsHolding[playerid] = 0;
			        }
			        else
			        {
			            SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have any packages");
				        return 1;
			        }
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the materials dropoff place");
			        return 1;
			    }
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid usage");
			    return 1;
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/repair", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
		    if(PlayerInfo[playerid][pJob] != 6)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not a mechanic");
		        return 1;
		    }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /repair [playerid/partofname] [price]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if(money < 1 || money > 10000) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) Price can not be lower then 1, or above 10000"); return 1; }
			if(IsPlayerConnected(playa))
			{
			    if(playa != INVALID_PLAYER_ID)
			    {
			        if(ProxDetectorS(8.0, playerid, playa)&& IsPlayerInAnyVehicle(playa))
					{
					    if(playa == playerid) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not repair your own vehicles"); return 1; }
				    	GetPlayerName(playa, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
					    format(string, sizeof(string), "(INFO) You offered %s to fix his car for $%d",giveplayer,money);
						SendClientMessage(playerid, COLOR_WHITE, string);
						format(string, sizeof(string), "(INFO) Mechanic %s wants to repair your car for $%d, (type /accept repair) to accept",sendername,money);
						SendClientMessage(playa, COLOR_LIGHTBLUE, string);
						RepairOffer[playa] = playerid;
						RepairPrice[playa] = money;
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range / not in a car");
					}
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not connected");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/refill", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
		    if(PlayerInfo[playerid][pJob] != 6)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not a mechanic");
		        return 1;
		    }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /refill [playerid/partofname] [price]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if(money < 1 || money > 200) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) Price can not be lower then 1, or above 200"); return 1; }
			if(IsPlayerConnected(playa))
			{
			    if(playa != INVALID_PLAYER_ID)
			    {
			        if(ProxDetectorS(8.0, playerid, playa)&& IsPlayerInAnyVehicle(playa))
					{
					    if(playa == playerid) { SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not refuel your own vehicles"); return 1; }
					    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
					    format(string, sizeof(string), "(INFO) You offerd %s to refill his car for $%d",giveplayer,money);
						SendClientMessage(playerid, COLOR_WHITE, string);
						format(string, sizeof(string), "(INFO) Mechanic %s wants to refill your car for $%d, (type /accept refill) to accept",sendername,money);
						SendClientMessage(playa, COLOR_LIGHTBLUE, string);
						RefillOffer[playa] = playerid;
						RefillPrice[playa] = money;
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not in range / not in a car");
					}
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not connected");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/tow", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    if(PlayerInfo[playerid][pJob] == 6)
		    {
		        if(IsPlayerInAnyVehicle(playerid))
		        {
			    	if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 525)
		     	   	{
		     	   	    if(GetPlayerState(playerid)==2)
		     	   	    {
							new Float:pX,Float:pY,Float:pZ;
							GetPlayerPos(playerid,pX,pY,pZ);
							new Float:vX,Float:vY,Float:vZ;
							new Found=0;
							new vid=0;
							while((vid<MAX_VEHICLES)&&(!Found))
							{
			   					vid++;
			   					GetVehiclePos(vid,vX,vY,vZ);
			   					if ((floatabs(pX-vX)<7.0)&&(floatabs(pY-vY)<7.0)&&(floatabs(pZ-vZ)<7.0)&&(vid!=GetPlayerVehicleID(playerid)))
								{
			   				    	Found=1;
			   				    	if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			           				{
			   				        	DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
						           	}
						           	else
						           	{
			    						AttachTrailerToVehicle(vid,GetPlayerVehicleID(playerid));
									}
			 					}
			     			}
							if(!Found)
				 			{
			   					SendClientMessage(playerid, COLOR_GREY, "(ERROR) There is no car in range");
			   				}
						}
						else
						{
							SendClientMessage(playerid, COLOR_GREY, "(ERROR) You must be the driver to use the tow");
							return 1;
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You must be in a tow truck");
						return 1;
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You must be be in a vehicle");
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not a mechanic");
				return 1;
			}
		}
		return 1;
	}
	//==========================================================================
	if(strcmp(cmd, "/buy", true) == 0)
	{
 	if(IsPlayerConnected(playerid))
 	{
  		for(new i = 0; i < sizeof(Businesses); i++)
		{
			if (PlayerToPoint(25.0,playerid,Businesses[i][ExitX], Businesses[i][ExitY], Businesses[i][ExitZ]))
			{
				if(GetPlayerVirtualWorld(playerid) == i)
	   			{
				    if(Businesses[i][BizType] == 3) //24-7
			    	{
		        		if(Businesses[i][Products] != 0)
		        		{
							new x_info[256];
							x_info = strtok(cmdtext, idx);
						    new wstring[128];

							if(!strlen(x_info)) {
								format(wstring, sizeof(wstring), "<|> %s <|>", Businesses[i][BusinessName]);
								SendClientMessage(playerid, COLOR_RED, wstring);
								SendClientMessage(playerid, COLOR_WHITE, "(Type /buy [item] Example: /buy baseballbat)");
								SendClientMessage(playerid, COLOR_WHITE, "* Baseball Bat - Price: $20");
								SendClientMessage(playerid, COLOR_WHITE, "* Dice - Price: $1");
								SendClientMessage(playerid, COLOR_WHITE, "* Shovel - Price: $5");
								SendClientMessage(playerid, COLOR_WHITE, "* Parachute - Price: $150");
								SendClientMessage(playerid, COLOR_WHITE, "* Phone Book - Price: $10 (/phonebook)");
								SendClientMessage(playerid, COLOR_WHITE, "* Flowers - Price: $25");
								SendClientMessage(playerid, COLOR_WHITE, "* Cards - Price: $500");
								SendClientMessage(playerid, COLOR_RED, "<|> Business <|>");
								return 1;
							}
							if(strcmp(x_info, "baseballbat", true) == 0)
							{
								if(GetPlayerCash(playerid) >= 20)
								{
								    SafeGivePlayerWeapon(playerid,5,1);
								    GivePlayerCash(playerid,-20);
								    SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You bought a baseball bat");
								    Businesses[i][Products]--;
								    Businesses[i][Till]+=20;
								    SaveBusinesses();
								    PlayerActionMessage(playerid,15.0,"gives the business some money and gets an item back in return");
								    return 1;

								}
								else
								{
								    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
								}
							}
							else if(strcmp(x_info, "cards", true) == 0)
							{
								if(GetPlayerCash(playerid) >= 500)
								{
									PlayerInfo[playerid][pCards] = 1;
								    GivePlayerCash(playerid,-500);
								    SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You bought a deck of cards. (( /cards for info. ))");
								    Businesses[i][Products]--;
								    Businesses[i][Till]+=500;
								    SaveBusinesses();
								    PlayerActionMessage(playerid,15.0,"gives the business some money and gets an item back in return");
								    return 1;

								}
								else
								{
								    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
								}
							}
							else if(strcmp(x_info, "shovel", true) == 0)
							{
								if(GetPlayerCash(playerid) >= 5)
								{
								    SafeGivePlayerWeapon(playerid,6,1);
								    GivePlayerCash(playerid,-5);
								    SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You bought a shovel");
								    Businesses[i][Products]--;
								    Businesses[i][Till]+=5;
								    SaveBusinesses();
								    PlayerActionMessage(playerid,15.0,"gives the business some money and gets an item back in return");
								    return 1;

								}
								else
								{
								    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
								}
							}
							else if(strcmp(x_info, "parachute", true) == 0)
							{
								if(GetPlayerCash(playerid) >= 150)
								{
								    SafeGivePlayerWeapon(playerid,46,0);
								    GivePlayerCash(playerid,-150);
								    SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You bought a parachute");
								    Businesses[i][Products]--;
								    Businesses[i][Till]+=150;
								    SaveBusinesses();
								    PlayerActionMessage(playerid,15.0,"gives the business some money and gets an item back in return");
								    return 1;

								}
								else
								{
								    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
								}
							}
       						else if(strcmp(x_info, "phonebook", true) == 0)
							{
								if(GetPlayerCash(playerid) >= 10)
								{
								    GivePlayerCash(playerid,-10);
								    SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You bought a phone book (/phonebook)");
								    Businesses[i][Products]--;
								    Businesses[i][Till]+=10;
								    PlayerInfo[playerid][pPhoneBook] = 1;
								    SaveBusinesses();
								    PlayerActionMessage(playerid,15.0,"gives the business some money and gets an item back in return");
								    return 1;

								}
								else
								{
								    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
								}
							}
							else if(strcmp(x_info, "dice", true) == 0)
							{
								if(GetPlayerCash(playerid) >= 1)
								{
								    GivePlayerCash(playerid,-1);
								    SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You have bought a dice (/dice)");
								    Businesses[i][Products]--;
								    Businesses[i][Till]+=1;
								    Dice[playerid] = 1;
								    SaveBusinesses();
								    PlayerActionMessage(playerid,15.0,"gives the business some money and gets an item back in return");
								    return 1;

								}
								else
								{
								    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
								}
							}
							else if(strcmp(x_info, "flowers", true) == 0)
							{
								if(GetPlayerCash(playerid) >= 25)
								{
								    SafeGivePlayerWeapon(playerid,14,1);
								    GivePlayerCash(playerid,-25);
								    SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You bought flowers");
								    Businesses[i][Products]--;
								    Businesses[i][Till]+=25;
								    SaveBusinesses();
								    PlayerActionMessage(playerid,15.0,"gives the business some money and gets an item back in return");
                                    return 1;
								}
							}
						}
					}
				}
			}
		}
	}
	return 1;
	}
 	if(strcmp(cmd, "/buyweapon", true) == 0)
	{
 	if(IsPlayerConnected(playerid))
 	{
  		for(new i = 0; i < sizeof(Businesses); i++)
		{
			if (PlayerToPoint(25.0,playerid,Businesses[i][ExitX], Businesses[i][ExitY], Businesses[i][ExitZ]))
			{
				if(GetPlayerVirtualWorld(playerid) == i)
	   			{
				    if(Businesses[i][BizType] == 4)
			    	{
		        		if(Businesses[i][Products] != 0)
		        		{
							new x_info[256];
							x_info = strtok(cmdtext, idx);
						    new wstring[128];

							if(!strlen(x_info)) {
								format(wstring, sizeof(wstring), "<|> %s <|>", Businesses[i][BusinessName]);
								SendClientMessage(playerid, COLOR_RED, wstring);
								SendClientMessage(playerid, COLOR_WHITE, "(Type name, no spaces, no capitals. Example. deagle)");
								SendClientMessage(playerid, COLOR_WHITE, "* Deagle - Price: $500 - 30 Ammo");
								SendClientMessage(playerid, COLOR_WHITE, "* MP5 - Price: $1000 - 100 Ammo");
								SendClientMessage(playerid, COLOR_WHITE, "* M4 - Price: $1500 - 100 Ammo");
								SendClientMessage(playerid, COLOR_WHITE, "* AK47 - Price: $1500 - 100 Ammo");
								SendClientMessage(playerid, COLOR_WHITE, "* Country Rifle - Price: $1200 - 25 Ammo");
								SendClientMessage(playerid, COLOR_WHITE, "* Sniper Rifle - Price: $4000 - 50 Ammo");
								SendClientMessage(playerid, COLOR_WHITE, "* Silenced Pistol - Price: $1250 - 100 Ammo");
								SendClientMessage(playerid, COLOR_WHITE, "* Shotgun - Price: $1500 - 50 Ammo");
								SendClientMessage(playerid, COLOR_WHITE, "* Pepperspray - Price: $1000 - 500 Ammo");
								SendClientMessage(playerid, COLOR_WHITE, "* Body Armour - Price: $1500");
  								SendClientMessage(playerid, COLOR_WHITE, "* Bomb - Price: $30000 - 1 Bomb Max");
								SendClientMessage(playerid, COLOR_RED, "<|> Business <|>");
								return 1;
							}
							if(PlayerInfo[playerid][pWepLic])
							{
								if(strcmp(x_info, "deagle", true) == 0)
								{
									if(GetPlayerCash(playerid) >= 500)
									{
									    SafeGivePlayerWeapon(playerid,24,30);
									    GivePlayerCash(playerid,-500);
                                        PlayerInfo[playerid][pGun2] = 24; PlayerInfo[playerid][pAmmo2] = 30;
									    SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You bought a desert eagle");
									    Businesses[i][Products]--;
									    Businesses[i][Till]+=500;
									    SaveBusinesses();
									    PlayerActionMessage(playerid,15.0,"gives the business some money and gets a weapon back in return");
									    return 1;

									}
									else
									{
									    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
									    return 1;
									}
								}
								else if(strcmp(x_info, "mp5", true) == 0)
								{
									if(GetPlayerCash(playerid) >= 1000)
									{
									    SafeGivePlayerWeapon(playerid,29,100);
									    GivePlayerCash(playerid,-1000);
                                        PlayerInfo[playerid][pGun3] = 29; PlayerInfo[playerid][pAmmo3] = 100;
									    SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You bought a MP5");
									    Businesses[i][Products]--;
									    Businesses[i][Till]+=1000;
									    SaveBusinesses();
									    PlayerActionMessage(playerid,15.0,"gives the business some money and gets a weapon back in return");
									    return 1;

									}
									else
									{
									    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
									    return 1;
									}
								}
	       						else if(strcmp(x_info, "m4", true) == 0)
								{
									if(GetPlayerCash(playerid) >= 1500)
									{
									    SafeGivePlayerWeapon(playerid,31,100);
									    GivePlayerCash(playerid,-1500);
									    PlayerInfo[playerid][pGun4] = 31; PlayerInfo[playerid][pAmmo4] = 100;
									    SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You bought a M4");
									    Businesses[i][Products]--;
									    Businesses[i][Till]+=1500;
									    SaveBusinesses();
									    PlayerActionMessage(playerid,15.0,"gives the business some money and gets a weapon back in return");
									    return 1;

									}
									else
									{
									    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
									    return 1;
									}
								}
  								else if(strcmp(x_info, "ak47", true) == 0)
								{
									if(GetPlayerCash(playerid) >= 1500)
									{
									    SafeGivePlayerWeapon(playerid,30,100);
									    GivePlayerCash(playerid,-1500);
									    PlayerInfo[playerid][pGun4] = 30; PlayerInfo[playerid][pAmmo4] = 100;
									    SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You bought a AK47");
									    Businesses[i][Products]--;
									    Businesses[i][Till]+=1500;
									    SaveBusinesses();
									    PlayerActionMessage(playerid,15.0,"gives the business some money and gets a weapon back in return");
									    return 1;

									}
									else
									{
									    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
									    return 1;
									}
								}
	 							else if(strcmp(x_info, "countryrifle", true) == 0)
								{
									if(GetPlayerCash(playerid) >= 1200)
									{
									    SafeGivePlayerWeapon(playerid,33,25);
									    GivePlayerCash(playerid,-1200);
									    PlayerInfo[playerid][pGun4] = 33; PlayerInfo[playerid][pAmmo4] = 25;
									    SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You bought a country rifle");
									    Businesses[i][Products]--;
									    Businesses[i][Till]+=1200;
									    SaveBusinesses();
									    PlayerActionMessage(playerid,15.0,"gives the business some money and gets a weapon back in return");
									    return 1;

									}
									else
									{
									    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
									    return 1;
									}
								}
								else if(strcmp(x_info, "sniperrifle", true) == 0)
								{
									if(GetPlayerCash(playerid) >= 4000)
									{
									    SafeGivePlayerWeapon(playerid,34,50);
									    GivePlayerCash(playerid,-4000);
									    SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You bought a sniper rifle");
									    Businesses[i][Products]--;
									    Businesses[i][Till]+=4000;
									    SaveBusinesses();
									    PlayerActionMessage(playerid,15.0,"gives the business some money and gets a weapon back in return");
									    return 1;

									}
									else
									{
									    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
									    return 1;
									}
								}
								else if(strcmp(x_info, "silencedpistol", true) == 0)
								{
									if(GetPlayerCash(playerid) >= 1250)
									{
									    SafeGivePlayerWeapon(playerid,23,100);
									    GivePlayerCash(playerid,-1250);
									    PlayerInfo[playerid][pGun2] = 23; PlayerInfo[playerid][pAmmo2] = 100;
									    SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You bought a 9MM silenced pistol");
									    Businesses[i][Products]--;
									    Businesses[i][Till]+=1250;
									    SaveBusinesses();
									    PlayerActionMessage(playerid,15.0,"gives the business some money and gets a weapon back in return");
									    return 1;

									}
									else
									{
									    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
									    return 1;
									}
								}
								else if(strcmp(x_info, "shotgun", true) == 0)
								{
									if(GetPlayerCash(playerid) >= 1500)
									{
									    SafeGivePlayerWeapon(playerid,25,50);
									    GivePlayerCash(playerid,-1500);
									    PlayerInfo[playerid][pGun4] = 25; PlayerInfo[playerid][pAmmo4] = 50;
									    SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You bought a shotgun");
									    Businesses[i][Products]--;
									    Businesses[i][Till]+=1500;
									    SaveBusinesses();
									    PlayerActionMessage(playerid,15.0,"gives the business some money and gets a weapon back in return");
									    return 1;

									}
									else
									{
									    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
									    return 1;
									}
								}
							}
							else
							{
								SendClientMessage(playerid, COLOR_WHITE, "(INFO) You do not have a weapon license, you can only buy:");
								SendClientMessage(playerid, COLOR_WHITE, "(Type name, no spaces, no capitals. Example. deagle)");
								SendClientMessage(playerid, COLOR_WHITE, "* Pepperspray - Price: $1000 - 500 Ammo");
								SendClientMessage(playerid, COLOR_WHITE, "* Body Armour - Price: $1500");
  								SendClientMessage(playerid, COLOR_WHITE, "* Bomb - Price: $30000 - 1 Bomb Max");
							}
							if(strcmp(x_info, "pepperspray", true) == 0)
							{
								if(GetPlayerCash(playerid) >= 1000)
								{
								    SafeGivePlayerWeapon(playerid,41,500);
								    GivePlayerCash(playerid,-1000);
								    SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You bought pepperspray");
								    Businesses[i][Products]--;
								    Businesses[i][Till]+=1000;
								    SaveBusinesses();
								    PlayerActionMessage(playerid,15.0,"gives the business some money and gets pepperspray back in return");
								    return 1;

								}
								else
								{
								    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
								    return 1;
								}
							}
							else if(strcmp(x_info, "bomb", true) == 0)
							{
   								if(Bomb[playerid] == 1)
								{
								    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can only carry 1 bomb");
								    return 1;
								}
								if(GetPlayerCash(playerid) >= 30000)
								{
								   	Bomb[playerid] = 1;
								    GivePlayerCash(playerid,-30000);
								    SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You bought a bomb");
								    Businesses[i][Products]--;
								    Businesses[i][Till]+=30000;
								    SaveBusinesses();
								    PlayerActionMessage(playerid,15.0,"gives the business some money and gets a bomb back in return");
								    return 1;

								}
								else
								{
								    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
								    return 1;
								}
							}
							else if(strcmp(x_info, "bodyarmour", true) == 0)
							{
								if(GetPlayerCash(playerid) >= 1500)
								{
								    new Float:armour;
								    GetPlayerArmour(playerid,armour);
								    if(armour != 100.0)
								    {
									    GivePlayerCash(playerid,-1500);
									    SetPlayerArmour(playerid,100);
									    SendClientMessage(playerid, COLOR_WHITE, "(SUCCESS) You bought body armour");
									    Businesses[i][Products]--;
									    Businesses[i][Till]+=1500;
									    SaveBusinesses();
									    PlayerActionMessage(playerid,15.0,"gives the business some money and gets body armour in return");
									    return 1;
								    }
								    else
								    {
								    	SendClientMessage(playerid, COLOR_GREY, "(ERROR) Your armour's full");
								    	return 1;
								    }
								}
							}
						}
					}
				}
			}
		}
	}
	return 1;
	}
	if(strcmp(cmd, "/buyclothes", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /buyclothes [skinid]");
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) A list of skin id's can be found at skins.ca.tf");
				return 1;
			}
			new id = strval(tmp);
		    for(new i = 0; i < sizeof(Businesses); i++)
			{
				if (PlayerToPoint(25.0,playerid,Businesses[i][ExitX], Businesses[i][ExitY], Businesses[i][ExitZ]))
				{
					if(GetPlayerVirtualWorld(playerid) == i)
		   			{
					    if(Businesses[i][BizType] == 6)
					    {
					        if(Businesses[i][Products] != 0)
					        {
					            if(GetPlayerCash(playerid) >= 100)
					            {
					                if(IsACopSkin(id) == 0)
									{
									    if(IsAGovSkin(id) == 0)
										{
									    	if(IsANewsSkin(id) == 0)
											{
										    	if(IsAMafiaSkin(id) == 0)
												{
											    	if(IsATransportSkin(id) == 0)
													{
												    	if(IsABallaSkin(id) == 0)
														{
													    	if(IsAGroveSkin(id) == 0)
															{
																if(IsAAztecaSkin(id) == 0)
																{
																	if(IsABikerSkin(id) == 0)
																	{
																	    if(IsATriadSkin(id) == 0)
																		{
																			if(IsValidSkin(id))
																			{
																				SetPlayerSkin(playerid,id);
																				PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
																				GivePlayerCash(playerid,-100);
																				Businesses[i][Products]--;
																				Businesses[i][Till]+=100;
																				SendClientMessage(playerid, COLOR_WHITE, "(INFO) Clothes purchased, $-100");
																				SaveBusinesses();
																				return 1;
																			}
																		}
																	}
																}
															}
														}
			        								}
												}
					        				}
					    				}
					   				}
								}
					   		}
						}
					}
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/buyphone", true) == 0)
	{
	    for(new i = 0; i < sizeof(Businesses); i++)
		{
			if (PlayerToPoint(25.0,playerid,Businesses[i][ExitX], Businesses[i][ExitY], Businesses[i][ExitZ]))
			{
				if(GetPlayerVirtualWorld(playerid) == i)
	   			{
				    if(Businesses[i][BizType] == 2)
				    {
				        if(Businesses[i][Products] != 0)
				        {
					        if(GetPlayerCash(playerid) >= 500)
					        {
				    			SendClientMessage(playerid,COLOR_RED,"____________________________________________________");
           						SendClientMessage(playerid, COLOR_WHITE, "(PRODUCT) You have purchased a phone! $-500");
                 				GivePlayerCash(playerid,-500);
                     			Businesses[i][Till] += 500;
                        		Businesses[i][Products]--;
                          		SendClientMessage(playerid,COLOR_RED,"____________________________________________________");
 								PlayerActionMessage(playerid,15.0,"gave the business $500 and gets a phone in return");
 								new randphone = 9999 + random(999999);
								PlayerInfo[playerid][pPhoneNumber] = randphone;
								PlayerInfo[playerid][pPhoneC] = i;
 								SaveBusinesses();
 								return 1;
							}
						}
					}
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/buydrink", true) == 0)
	{
	 	if(IsPlayerConnected(playerid))
	 	{
   			for(new i = 0; i < sizeof(Businesses); i++)
			{
				if (PlayerToPoint(25.0,playerid,Businesses[i][ExitX], Businesses[i][ExitY], Businesses[i][ExitZ]))
				{
					if(GetPlayerVirtualWorld(playerid) == i)
					{
			    		if(Businesses[i][BizType] == 7)
			    		{
			    			new x_info[256];
							x_info = strtok(cmdtext, idx);

							if(!strlen(x_info)) {
								SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /buydrink [item]");
								SendClientMessage(playerid, COLOR_WHITE, "(ITEM) Beer - Price: $7");
								SendClientMessage(playerid, COLOR_WHITE, "(ITEM) Vodka - Price: $10");
								SendClientMessage(playerid, COLOR_WHITE, "(ITEM) Coke - Price: $3");
								SendClientMessage(playerid, COLOR_WHITE, "(ITEM) Water - Price: $3");
								SendClientMessage(playerid, COLOR_WHITE, "(ITEM) Whiskey - Price: $10");
								SendClientMessage(playerid, COLOR_WHITE, "(ITEM) Brandy - Price: $15");
								SendClientMessage(playerid, COLOR_WHITE, "(ITEM) Soda - Price: $3");
								return 1;
							}
				        	if(Businesses[i][Products] != 0)
				        	{
				        	    new Float:HP;
				        	    GetPlayerHealth(playerid,HP);
								if(strcmp(x_info, "beer", true) == 0)
								{
									if(GetPlayerCash(playerid) >= 7)
									{
	           						GivePlayerCash(playerid,-7);
                     		       	Businesses[i][Till] += 7;
                        		    Businesses[i][Products]--;
                              		if(HP < 100)
                        		    {
                          		  		SetPlayerHealth(playerid,HP+15.0);
                          		  	}
							  		PlayerActionMessage(playerid,15.0,"bought a beer, then drinks it");
							  		SaveBusinesses();
							  		return 1;
									}
									else
									{
									    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
									    return 1;
									}
								}
        						if(strcmp(x_info, "vodka", true) == 0)
								{
									if(GetPlayerCash(playerid) >= 10)
									{
	           						GivePlayerCash(playerid,-10);
                     		       	Businesses[i][Till] += 10;
                        		    Businesses[i][Products]--;
                              		if(HP < 100)
                        		    {
                          		  		SetPlayerHealth(playerid,HP+20.0);
                          		  	}
							  		PlayerActionMessage(playerid,15.0,"bought a shot of vodka, then drinks it");
							  		SaveBusinesses();
							  		return 1;
									}
									else
									{
									    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
									    return 1;
									}
								}
        						if(strcmp(x_info, "coke", true) == 0)
								{
									if(GetPlayerCash(playerid) >= 3)
									{
	           						GivePlayerCash(playerid,-3);
                     		       	Businesses[i][Till] += 3;
                        		    Businesses[i][Products]--;
                              		if(HP < 100)
                        		    {
                          		  		SetPlayerHealth(playerid,HP+2.0);
                          		  	}
							  		PlayerActionMessage(playerid,15.0,"bought a coke, then drinks it");
							  		SaveBusinesses();
							  		return 1;
									}
									else
									{
									    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
									    return 1;
									}
								}
       	 						if(strcmp(x_info, "water", true) == 0)
								{
									if(GetPlayerCash(playerid) >= 1)
									{
	           						GivePlayerCash(playerid,-1);
                     		       	Businesses[i][Till] += 1;
                        		    Businesses[i][Products]--;
                              		if(HP < 100)
                        		    {
                          		  		SetPlayerHealth(playerid,HP+1.0);
                          		  	}
							  		PlayerActionMessage(playerid,15.0,"bought a glass of water, then drinks it");
							  		SaveBusinesses();
							  		return 1;
									}
									else
									{
									    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
									    return 1;
									}
								}
        						if(strcmp(x_info, "whiskey", true) == 0)
								{
									if(GetPlayerCash(playerid) >= 10)
									{
	           						GivePlayerCash(playerid,-10);
                     		       	Businesses[i][Till] += 10;
                        		    Businesses[i][Products]--;
                              		if(HP < 100)
                        		    {
                          		  		SetPlayerHealth(playerid,HP+20.0);
                          		  	}
							  		PlayerActionMessage(playerid,15.0,"bought a glass of whiskey, then drinks it");
							  		SaveBusinesses();
							  		return 1;
									}
									else
									{
									    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
									    return 1;
									}
								}
								if(strcmp(x_info, "brandy", true) == 0)
								{
									if(GetPlayerCash(playerid) >= 15)
									{
	           						GivePlayerCash(playerid,-15);
                     		       	Businesses[i][Till] += 15;
                        		    Businesses[i][Products]--;
                              		if(HP < 100)
                        		    {
                          		  		SetPlayerHealth(playerid,HP+25.0);
                          		  	}
							  		PlayerActionMessage(playerid,15.0,"bought a glass of brandy, then drinks it");
							  		SaveBusinesses();
							  		return 1;
									}
									else
									{
									    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
									    return 1;
									}
								}
        						if(strcmp(x_info, "soda", true) == 0)
								{
									if(GetPlayerCash(playerid) >= 3)
									{
	           						GivePlayerCash(playerid,-3);
                     		       	Businesses[i][Till] += 3;
                        		    Businesses[i][Products]--;
                              		if(HP < 100)
                        		    {
                          		  		SetPlayerHealth(playerid,HP+2.0);
                          		  	}
							  		PlayerActionMessage(playerid,15.0,"bought a soda, then drinks it");
							  		SaveBusinesses();
							  		return 1;
									}
									else
									{
									    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
									    return 1;
									}
								}
							}
						}
					}
				}
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/eat", true) == 0)
	{
	    for(new i = 0; i < sizeof(Businesses); i++)
		{
			if (PlayerToPoint(25.0,playerid,Businesses[i][ExitX], Businesses[i][ExitY], Businesses[i][ExitZ]))
			{
				if(GetPlayerVirtualWorld(playerid) == i)
	   			{
				    if(Businesses[i][BizType] == 1)
				    {
				        if(Businesses[i][Products] != 0)
				        {
					        if(GetPlayerCash(playerid) >= 15)
					        {
						        if(PlayerToPoint(25.0,playerid,377.0869,-68.1940,1001.5151))
						        {
				    				SendClientMessage(playerid,COLOR_RED,"____________________________________________________");
           		                 	SendClientMessage(playerid, COLOR_WHITE, "(FOOD) You have eaten a hamburger and fries. -$15");
	           						GivePlayerCash(playerid,-15);
                     		       	Businesses[i][Till] += 15;
                        		    Businesses[i][Products]--;
                          		  	SetPlayerHealth(playerid,100);
        							SendClientMessage(playerid,COLOR_RED,"____________________________________________________");
							  		PlayerActionMessage(playerid,15.0,"ate a hamburger and fries");
							  		SaveBusinesses();
									return 1;
        						}
		      					else if(PlayerToPoint(25.0,playerid,369.6264,-6.5964,1001.8589))
						        {
								    SendClientMessage(playerid,COLOR_RED,"____________________________________________________");
		          					SendClientMessage(playerid, COLOR_WHITE, "(FOOD) You have eaten a chickenburger and fries. -$15");
		          					GivePlayerCash(playerid,-15);
		          					Businesses[i][Till] += 15;
		          					Businesses[i][Products]--;
		          					SetPlayerHealth(playerid,100);
		          					SendClientMessage(playerid,COLOR_RED,"____________________________________________________");
	   								PlayerActionMessage(playerid,15.0,"ate a chickenburger and fries");
	   								SaveBusinesses();
									return 1;
								}
	  							else if(PlayerToPoint(25.0,playerid,375.7379,-119.1621,1001.4995))
						        {
								    SendClientMessage(playerid,COLOR_RED,"____________________________________________________");
		          					SendClientMessage(playerid, COLOR_WHITE, "(FOOD) You have eaten a large pizza and drunk a large drink. -$15");
		          					GivePlayerCash(playerid,-15);
		          					Businesses[i][Till] += 15;
		          					Businesses[i][Products]--;
		          					SetPlayerHealth(playerid,100);
		          					SendClientMessage(playerid,COLOR_RED,"____________________________________________________");
	   								PlayerActionMessage(playerid,15.0,"ate a large pizza and drunk a large drink");
	   								SaveBusinesses();
									return 1;
								}
								else if(PlayerToPoint(25.0,playerid,378.7731,-186.7205,1000.6328))
						        {
								    SendClientMessage(playerid,COLOR_RED,"____________________________________________________");
		          					SendClientMessage(playerid, COLOR_WHITE, "(FOOD) You have eaten two donuts and had a large drink. -$15");
		          					GivePlayerCash(playerid,-15);
		          					Businesses[i][Till] += 15;
		          					Businesses[i][Products]--;
		          					SetPlayerHealth(playerid,100);
		          					SendClientMessage(playerid,COLOR_RED,"____________________________________________________");
	   								PlayerActionMessage(playerid,15.0,"ate two donuts and had a large drink");
	   								SaveBusinesses();
									return 1;
								}
								else
								{
								    SendClientMessage(playerid,COLOR_RED,"____________________________________________________");
		          					SendClientMessage(playerid, COLOR_WHITE, "(FOOD) You have eaten some food. -$15");
		          					GivePlayerCash(playerid,-15);
		          					Businesses[i][Till] += 15;
		          					Businesses[i][Products]--;
		          					SetPlayerHealth(playerid,100);
		          					SendClientMessage(playerid,COLOR_RED,"____________________________________________________");
	   								PlayerActionMessage(playerid,15.0,"ate some food");
	   								SaveBusinesses();
									return 1;
        						}
							}
						}
					}
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/advertise", true) == 0 || strcmp(cmd, "/ad", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
   			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) (/ad)vertise [advert text]");
				return 1;
			}
   	    	for(new i = 0; i < sizeof(Businesses); i++)
			{
				if (PlayerToPoint(1.0,playerid,Businesses[i][EnterX], Businesses[i][EnterY], Businesses[i][EnterZ]) || PlayerToPoint(25.0,playerid,Businesses[i][ExitX], Businesses[i][ExitY], Businesses[i][ExitZ]))
				{
					if(GetPlayerVirtualWorld(playerid) == i)
					{
			    		if(Businesses[i][BizType] == 5)
			    		{
				        	if(Businesses[i][Products] != 0)
				        	{
								if ((!adds) && (PlayerInfo[playerid][pAdmin] < 1))
								{
									format(string, sizeof(string), "(ERROR) You must wait %d seconds before making another advertisement",  (addtimer/1000));
									SendClientMessage(playerid, COLOR_GREY, string);
									return 1;

								}
								new payout = 1000;
								if(GetPlayerCash(playerid) < payout)
						        {
						            SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money, 1 advertisement costs 1000$.");
						            return 1;
						        }
						        GivePlayerCash(playerid, - payout);
								Businesses[i][Till] += payout;
								Businesses[i][Products] --;
								format(string, sizeof(string), "(ADVERTISEMENT) %s",  result);
								SendClientMessageToAll(COLOR_GREEN,string);
								format(string, sizeof(string), "Advertisement By: %s - Phone Number: %d",  GetPlayerNameEx(playerid),PlayerInfo[playerid][pPhoneNumber],Businesses[i][BusinessName]);
								SendClientMessageToAll(COLOR_GREEN,string);
						        if (PlayerInfo[playerid][pAdmin] < 1){SetTimer("AddsOn", addtimer, 0);adds = 0;}
						        SendClientMessage(playerid, COLOR_WHITE, "Advertisement costed 1000$.");
								PlayerActionMessage(playerid,15.0,"gives the business some money and gets his advertisement posted in return");
								SaveBusinesses();
								return 1;
							}
							else
							{
								SendClientMessage(playerid, COLOR_GREY, "(ERROR) The business is out of products");
							}
						}
						else
						{
							SendClientMessage(playerid, COLOR_GREY, "(ERROR) This business is not an advertising company");
						}
					}
	   			}
	   			else
				{
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/pad", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
   			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) (/pad)vertise [advert text]");
				return 1;
			}
   	    	for(new i = 0; i < sizeof(Businesses); i++)
			{
				if (PlayerToPoint(1.0,playerid,Businesses[i][EnterX], Businesses[i][EnterY], Businesses[i][EnterZ]) || PlayerToPoint(25.0,playerid,Businesses[i][ExitX], Businesses[i][ExitY], Businesses[i][ExitZ]))
				{
					if(GetPlayerVirtualWorld(playerid) == i)
					{
			    		if(Businesses[i][BizType] == 5)
			    		{
				        	if(Businesses[i][Products] != 0)
				        	{
								if ((!adds) && (PlayerInfo[playerid][pAdmin] < 1))
								{
									format(string, sizeof(string), "(ERROR) You must wait %d seconds before making another advertisement",  (addtimer/1000));
									SendClientMessage(playerid, COLOR_GREY, string);
									return 1;

								}
								new payout = 1000;
								if(GetPlayerCash(playerid) < payout)
						        {
						            SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money, 1 advertisement costs 1000$.");
						            return 1;
						        }
						        GivePlayerCash(playerid, - payout);
								Businesses[i][Till] += payout;
								Businesses[i][Products] --;
								format(string, sizeof(string), "(PRIVATE ADVERTISEMENT) %s",  result);
								SendClientMessageToAll(COLOR_GREEN1,string);
						        if (PlayerInfo[playerid][pAdmin] < 1){SetTimer("AddsOn", addtimer, 0);adds = 0;}
						        SendClientMessage(playerid, COLOR_WHITE, "Advertisement costed 1000$.");
								PlayerActionMessage(playerid,15.0,"gives the business some money and gets his advertisement posted in return");
								SaveBusinesses();
								return 1;
							}
							else
							{
								SendClientMessage(playerid, COLOR_GREY, "(ERROR) The business is out of products");
							}
						}
						else
						{
							SendClientMessage(playerid, COLOR_GREY, "(ERROR) This business is not an advertising company");
						}
					}
	   			}
	   			else
				{
				}
			}
		}
		return 1;
	}
	//==========================================================================
	if(strcmp(cmd, "/phonebook", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[giveplayerid][pPhoneBook])
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /phonebook [playerid/partofname]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
				        if(gPlayerLogged[giveplayerid])
						{
					        if(PlayerInfo[giveplayerid][pListNumber])
					        {
								format(string, 128, "(PHONE) Name: %s, Phone Number: %d",GetPlayerNameEx(giveplayerid),PlayerInfo[giveplayerid][pPhoneNumber]);
								SendClientMessage(playerid, COLOR_WHITE, string);
							}
							else
							{
							    SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player's number is not publicly listed");
							}
						}
      					else
						{
    						SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is not connected");
						}
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid ID/Name");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a phonebook");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/answer", true) == 0)
	{
        if(IsPlayerConnected(playerid))
		{
			if(Mobile[playerid] != 255)
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are already on a phone call (/hangup)");
				return 1;
			}
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(Mobile[i] == playerid)
					{
						Mobile[playerid] = i;
						SendClientMessage(i,  COLOR_WHITE, "(INFO) The person answered your phone call");
						SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
						if(PlayerInfo[playerid][pSex] == 1)
						{
							PlayerActionMessage(playerid,15.0,"answered his mobile phone");
						}
						else
						{
							PlayerActionMessage(playerid,15.0,"answered her mobile phone");
						}
					}

				}
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/txt", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /txt [phonenumber] [txt message]");
				return 1;
			}
			if(PlayerInfo[playerid][pPhoneNumber] == 0)
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a mobile phone, you can buy one from a phone shop/network");
				return 1;
			}
			if(PlayerInfo[playerid][pSex] == 1)
			{
				PlayerActionMessage(playerid,15.0,"takes out his mobile phone and starts txting");
			}
			else
			{
				PlayerActionMessage(playerid,15.0,"takes out her mobile phone and starts txting");
			}
			new phonenumb = strval(tmp);
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /txt [phonenumber] [txt message]");
				return 1;
			}
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(PlayerInfo[i][pPhoneNumber] == phonenumb && phonenumb != 0)
					{
						giveplayerid = i;
						if(IsPlayerConnected(giveplayerid))
						{
						    if(giveplayerid != INVALID_PLAYER_ID)
						    {
						        if(PhoneOnline[giveplayerid])
						        {
						            SendClientMessage(playerid, COLOR_GREY, "(ERROR) That players phone is turned off");
						            return 1;
						        }
								format(string, sizeof(string), "(TXT) From: %s (%d), Message: %s", GetPlayerNameEx(playerid),PlayerInfo[playerid][pPhoneNumber],result);
								SendClientMessage(playerid, COLOR_WHITE, "(INFO) Text message sent");
								SendClientMessage(giveplayerid, COLOR_WHITE, string);
								format(string, sizeof(string), "(TXT) Sent To: %s (%d), Message: %s", GetPlayerNameEx(giveplayerid),PlayerInfo[giveplayerid][pPhoneNumber],result);
								SendClientMessage(playerid,  COLOR_WHITE, string);
								PhoneAnimation(playerid);
								SMSLog(string);
								GivePlayerCash(playerid,-txtcost);
								Businesses[PlayerInfo[playerid][pPhoneC]][Till] += txtcost;
								return 1;
							}
						}
					}
				}
			}
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) Message not sent");
		}
		return 1;
	}
 	if(strcmp(cmd, "/listnumber", true) == 0 )
	{
	if(PlayerInfo[playerid][pPhoneNumber] != 0)
	{
		if(PlayerInfo[playerid][pListNumber])
		{
		    SendClientMessage(playerid,  COLOR_WHITE, "(PHONE) Your number will no longer be shown publicly");
		    PlayerInfo[playerid][pListNumber] = 0;
		}
		else
		{
			SendClientMessage(playerid,  COLOR_WHITE, "(PHONE) Your number will now be shown publicly");
		 	PlayerInfo[playerid][pListNumber] = 1;
		}
	}
	else
	{
		SendClientMessage(playerid,  COLOR_GREY, "(ERROR) You do not have a phone, how could you have a number?");
	}
	return 1;
	}
 	if(strcmp(cmd, "/hangup", true) == 0 )
	{
	    if(IsPlayerConnected(playerid))
		{
			new caller = Mobile[playerid];
			if(IsPlayerConnected(caller))
			{
			    if(caller != INVALID_PLAYER_ID)
			    {
					if(caller != 255)
					{
						if(caller < 255)
						{
							SendClientMessage(caller,  COLOR_WHITE, "(INFO) They hung up");
							SendClientMessage(playerid,  COLOR_WHITE, "(INFO) You hung up");
							if(PlayerInfo[playerid][pSex] == 1)
							{
								PlayerActionMessage(playerid,15.0,"put his phone in his pocket");
							}
							else
							{
								PlayerActionMessage(playerid,15.0,"put her phone in her pocket");
							}
							Mobile[caller] = 255;
							if(StartedCall[playerid])
							{
								new callcost = random(100);
								GivePlayerCash(playerid,-callcost);
								Businesses[PlayerInfo[playerid][pPhoneC]][Till] += callcost;
								StartedCall[playerid] = 0;
							}
							else if(StartedCall[caller])
							{
								new callcost = random(100);
								GivePlayerCash(caller,-callcost);
								Businesses[PlayerInfo[caller][pPhoneC]][Till] += callcost;
								StartedCall[caller] = 0;
							}
						}
						Mobile[playerid] = 255;
						return 1;
					}
				}
			}
			SetPlayerSpecialAction(caller,SPECIAL_ACTION_STOPUSECELLPHONE);
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
			SendClientMessage(playerid, COLOR_WHITE, "(INFO) Your phone is in your pocket");
		}	
		return 1;
	}
 	if(strcmp(cmd, "/call", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /call [phonenumber]");
				return 1;
			}
			if(PlayerInfo[playerid][pPhoneNumber] == 0)
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have a phone");
				return 1;
			}
			if(PlayerInfo[playerid][pSex] == 1)
			{
				PlayerActionMessage(playerid,15.0,"takes a cell phone from his pocket and dials a number");
			}
			else
			{
				PlayerActionMessage(playerid,15.0,"takes a cell phone from her pocket and dials a number");
			}
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
			new phonenumb = strval(tmp);
			if(phonenumb == 911)
			{
				SendClientMessage(playerid, COLOR_LSPD, "(DISPATCH) Hello, LSPD, how may i be of assistance?");
				SendClientMessage(playerid, COLOR_WHITE, "(INFO) Please keep your call brief and all in one sentence");
				Mobile[playerid] = 911;
				return 1;
			}
			if(phonenumb == 123)
			{
				SendClientMessage(playerid, COLOR_YELLOW,"(OPERATOR) Hello, San Andreas News Network, please leave a message.");
				SendClientMessage(playerid, COLOR_WHITE,"(INFO) Please keep your call brief and all in one sentence.");
				Mobile[playerid] = 123;
				return 1;
			}
			if(phonenumb == 411)
			{
				SendClientMessage(playerid, COLOR_YELLOW, "(OPERATOR) Hello, Los Santos Transport Company, how may I be of assistance?");
				SendClientMessage(playerid, COLOR_WHITE, "(INFO) Please keep your call brief and all in one sentence.");
				Mobile[playerid] = 411;
				return 1;
			}
			if(phonenumb == PlayerInfo[playerid][pPhoneNumber])
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) That line is being used");
				return 1;
			}
			if(Mobile[playerid] != 255)
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are already on a call");
				return 1;
			}
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(PlayerInfo[i][pPhoneNumber] == phonenumb && phonenumb != 0)
					{
						giveplayerid = i;
						Mobile[playerid] = giveplayerid;
						if(IsPlayerConnected(giveplayerid))
						{
						    if(giveplayerid != INVALID_PLAYER_ID)
						    {
						        if(PhoneOnline[giveplayerid])
						        {
						            SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player's phone is turned off");
						            return 1;
						        }
								if (Mobile[giveplayerid] == 255)
								{
									format(string, sizeof(string), "(PHONE) Dialing... - ContactID: %s (%d)", GetPlayerNameEx(playerid),PlayerInfo[playerid][pPhoneNumber]);
									SendClientMessage(giveplayerid, COLOR_WHITE, string);
									PlayerActionMessage(giveplayerid,15.0,"'s phone starts ringing");
                                    StartedCall[playerid] = 1;
                                    StartedCall[giveplayerid] = 0;
									return 1;
								}
							}
						}
						else
						{
							SendClientMessage(playerid, COLOR_GREY, "(ERROR) That player is on another phone call");
						}
					}
				}
			}
		}
		return 1;
	}
	//==========================================================================
	if(strcmp(cmd, "/takedrivingtest", true) == 0)
	{
		if(PlayerToPoint(1.0,playerid,DrivingTestPosition[X],DrivingTestPosition[Y],DrivingTestPosition[Z]))
		{
		    if(PlayerInfo[playerid][pCarLic] == 0)
		    {
				if(GetPlayerCash(playerid) >= 3500)
				{
					GivePlayerCash(playerid,-3500);
					SendClientMessage(playerid, COLOR_WHITE, "(INFO) The driving test has started, go outside and get in a license test car");
					TakingDrivingTest[playerid] = 1;
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You already have a license");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the driving school");
		}
		return 1;
	}
 	if(strcmp(cmd, "/buyflyinglicense", true) == 0)
	{
		if(PlayerToPoint(1.0,playerid,FlyingTestPosition[X],FlyingTestPosition[Y],FlyingTestPosition[Z]))
		{
		    if(GetPlayerVirtualWorld(playerid) == FlyingTestPosition[World])
		    {
		        if(PlayerInfo[playerid][pFlyLic] == 0)
		        {
					if(GetPlayerCash(playerid) >= 10000)
					{
						GivePlayerCash(playerid,-10000);
						SendClientMessage(playerid, COLOR_WHITE, "(INFO) You bought a flying license");
						PlayerInfo[playerid][pFlyLic] = 1;
						OnPlayerDataSave(playerid);
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You already have a license");
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the license location");
		}
		return 1;
	}
  	if(strcmp(cmd, "/buyweaponlicense", true) == 0)
	{
		if(PlayerToPoint(1.0,playerid,WeaponLicensePosition[X],WeaponLicensePosition[Y],WeaponLicensePosition[Z]))
		{
		    if(GetPlayerVirtualWorld(playerid) == WeaponLicensePosition[World])
		    {
		        if(PlayerInfo[playerid][pWepLic] == 0)
		        {
					if(GetPlayerCash(playerid) >= 5000)
					{
						GivePlayerCash(playerid,-5000);
						SendClientMessage(playerid, COLOR_WHITE, "(INFO) You bought a weapon license");
						PlayerInfo[playerid][pWepLic] = 1;
						OnPlayerDataSave(playerid);
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have enough money");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You already have a license");
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not at the license location");
		}
		return 1;
	}
	//==========================================================================
	if(strcmp(cmd, "/toggle", true) == 0)
	{
 	if(IsPlayerConnected(playerid))
 	{
		new x_info[256];
		x_info = strtok(cmdtext, idx);

		if(!strlen(x_info)) {
			SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /toggle [item]");
   			SendClientMessage(playerid, COLOR_WHITE, "(ITEM) fuel | pm | phone");
			return 1;
		}
		if(strcmp(x_info, "fuel", true) == 0)
		{
			if(ShowFuel[playerid] == 1)
			{
				SendClientMessage(playerid, COLOR_WHITE, "(INFO) You will no longer see fuel information");
				ShowFuel[playerid] = 0;
			}
			else
			{
			    SendClientMessage(playerid, COLOR_WHITE, "(INFO) You will now see fuel information");
			    ShowFuel[playerid] = 1;
			}
		}
  		else if(strcmp(x_info, "pm", true) == 0)
		{
		    if(PlayerInfo[playerid][pDonator] || PlayerInfo[playerid][pAdmin] >= 1)
		    {
				if(PMsEnabled[playerid])
				{
				    SendClientMessage(playerid, COLOR_WHITE, "(INFO) You will no longer receive PM's");
				    PMsEnabled[playerid] = 0;
				}
				else
				{
					SendClientMessage(playerid, COLOR_WHITE, "(INFO) You will now receive PM's");
				    PMsEnabled[playerid] = 1;
				}
			}
		}
  		else if(strcmp(x_info, "phone", true) == 0)
		{
		    if(PlayerInfo[playerid][pDonator] || PlayerInfo[playerid][pAdmin] >= 1)
		    {
				if(PhoneOnline[playerid])
				{
				    SendClientMessage(playerid, COLOR_WHITE, "(INFO) You have turned your phone on");
                    PhoneOnline[playerid] = 0;
				}
				else
				{
					SendClientMessage(playerid, COLOR_WHITE, "(INFO) You have turned your phone off");
				    PhoneOnline[playerid] = 1;
				}
			}
		}
	}
	return 1;
	}
	if(strcmp(cmd, "/time", true) == 0)
		{
		    if(IsPlayerConnected(playerid))
			{
			    new mtext[20];
				new year, month,day;
				getdate(year, month, day);
				if(month == 1) { mtext = "January"; }
				else if(month == 2) { mtext = "February"; }
				else if(month == 3) { mtext = "March"; }
				else if(month == 4) { mtext = "April"; }
				else if(month == 5) { mtext = "May"; }
				else if(month == 6) { mtext = "June"; }
				else if(month == 7) { mtext = "July"; }
				else if(month == 8) { mtext = "August"; }
				else if(month == 9) { mtext = "September"; }
				else if(month == 10) { mtext = "October"; }
				else if(month == 11) { mtext = "November"; }
				else if(month == 12) { mtext = "December"; }
			    new hour,minuite,second;
				gettime(hour,minuite,second);
				FixHour(hour);
				hour = shifthour;

				format(string, sizeof(string), "~y~%d %s~n~~g~|~w~%d:%d:%d~g~|", day, mtext, hour, minuite,second);
				GameTextForPlayer(playerid, string, 5000, 1);
			}
			return 1;
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_WHITE, "(INFO) You are not logged in");
		SendClientMessage(playerid, COLOR_WHITE, "(INFO) Type your password to register/login");
		return 1;
		}
	return 1;
}
//==============================================================================
dcmd_racehelp(playerid, params[])
{
    #pragma unused params
	SendClientMessage(playerid, COLOR_RED, "<|> Racing Commands <|>");
	SendClientMessage(playerid, COLOR_WHITE, "(GENERAL) /join - /ready - /leave");
	SendClientMessage(playerid, COLOR_WHITE, "(GENERAL) /endrace - /bestlap - /bestrace");
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		SendClientMessage(playerid, COLOR_WHITE, "(ADMIN) /racelist - /loadrace - /startrace - /endrace - /raceadmin");
		SendClientMessage(playerid, COLOR_WHITE, "(ADMIN) /racemode - /setprize - /prizemode - /setlaps - /airrace - /cpsize");
	}
	SendClientMessage(playerid, COLOR_RED, "<|> Racing Commands <|>");
	return 1;
}

dcmd_racelist(playerid, params[])
{
    #pragma unused params
	if (PlayerInfo[playerid][pAdmin] >= 1)
	{
		SendClientMessage(playerid, COLOR_RED, "<|> Race List <|>");
		SendClientMessage(playerid, COLOR_WHITE, "(RACES) annoying - backstreetbang - countrycruise - chilliad - fastlane - fleethecity");
		SendClientMessage(playerid, COLOR_WHITE, "(RACES) flyingfree - lostinsmoke - monstertruck - mullholland - murderhorn");
		SendClientMessage(playerid, COLOR_WHITE, "(RACES) riversiderun - roundwego - striptease - thegrove - thestrip");
		SendClientMessage(playerid, COLOR_RED, "<|> Race List <|>");
	}
	return 1;
}

dcmd_buildhelp(playerid, params[])
{
    #pragma unused params
	if (PlayerInfo[playerid][pAdmin] >= 1)
	{
		SendClientMessage(playerid, COLOR_RED, "<|> Building Commands <|>");
		SendClientMessage(playerid, COLOR_WHITE, "(ADMIN) /buildrace - /cp - /scp - /dcp - /mcp - /rcp");
		SendClientMessage(playerid, COLOR_WHITE, "(ADMIN) /deleterace - /clearrace - /editrace - /saverace");
		SendClientMessage(playerid, COLOR_WHITE, "(ADMIN) /buildmenu - /raceadmin");
		SendClientMessage(playerid, COLOR_RED, "<|> Building Commands <|>");
	}
	return 1;
}

dcmd_buildrace(playerid, params[])
{
    #pragma unused params
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		if(RaceBuilders[playerid] != 0)
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are already building a race");
		}
		else if(RaceParticipant[playerid]>0)
		{
	    	SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are participating in a race, can not build a race");
		}
		else
		{
			new slot;
			slot=GetBuilderSlot(playerid);
			if(slot == 0)
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) No builderslots available");
				return 1;
			}
			format(ystring,sizeof(ystring),"(INFO) You are now building a race (Slot: %d)",slot);
			SendClientMessage(playerid, COLOR_WHITE, ystring);
			RaceBuilders[playerid]=slot;
			BCurrentCheckpoints[b(playerid)]=0;
			Bracemode[b(playerid)]=0;
			Blaps[b(playerid)]=0;
			BAirrace[b(playerid)] = 0;
			BCPsize[b(playerid)] = 8.0;
		}
		return 1;
	}
	return 1;
}

dcmd_cp(playerid, params[])
{
	#pragma unused params
	if(RaceBuilders[playerid] != 0 && BCurrentCheckpoints[b(playerid)] < MAX_RACECHECKPOINTS)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid,x,y,z);
		format(ystring,sizeof(ystring),"(INFO) Checkpoint %d created: %f,%f,%f",BCurrentCheckpoints[b(playerid)],x,y,z);
		SendClientMessage(playerid, COLOR_WHITE, ystring);
		BRaceCheckpoints[b(playerid)][BCurrentCheckpoints[b(playerid)]][0]=x;
		BRaceCheckpoints[b(playerid)][BCurrentCheckpoints[b(playerid)]][1]=y;
		BRaceCheckpoints[b(playerid)][BCurrentCheckpoints[b(playerid)]][2]=z;
		BSelectedCheckpoint[b(playerid)]=BCurrentCheckpoints[b(playerid)];
		SetBRaceCheckpoint(playerid,BCurrentCheckpoints[b(playerid)],-1);
		BCurrentCheckpoints[b(playerid)]++;
	}
	else if(RaceBuilders[playerid] != 0 && BCurrentCheckpoints[b(playerid)] == MAX_RACECHECKPOINTS)
	{
		format(ystring,sizeof(ystring),"(ERROR) Maximum amount of checkpoints reached (%d)",MAX_RACECHECKPOINTS);
		SendClientMessage(playerid, COLOR_GREY, ystring);
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not building a race");
	}
	return 1;
}

dcmd_scp(playerid, params[])
{
	new sele, tmp[256], idx;
    tmp = otherstrtok(params, idx);
    if(!strlen(tmp))
	{
		SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /scp [checkpoint]");
		return 1;
    }
    sele = strval(tmp);
	if(RaceBuilders[playerid] != 0)
	{
		if(sele>BCurrentCheckpoints[b(playerid)]-1 || BCurrentCheckpoints[b(playerid)] < 1 || sele < 0)
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid checkpoint");
			return 1;
		}
		format(ystring,sizeof(ystring),"(INFO) Selected checkpoint %d",sele);
		SendClientMessage(playerid, COLOR_WHITE, ystring);
		BActiveCP(playerid,sele);
		BSelectedCheckpoint[b(playerid)]=sele;
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not building a race");
	}
	return 1;
}
dcmd_rob(playerid, params[])
	{
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, pname, sizeof(pname));
		if(!strlen(params))
		{
			SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /rob [playerid/PartOfName]");
		}
		else
		{
			playerid = strval(params);
			if(robtime[playerid] == 0)
			{
				if(playerid != playerid)
				{
					if(IsPlayerConnected(playerid))
					{
						new oname[MAX_PLAYER_NAME];
						GetPlayerName(playerid, oname, sizeof(oname));
						if(GetDistanceBetweenPlayers(playerid, playerid) <= DISTANCE_BETWEEN_PLAYERS)
						{
							if(!GetPlayerVehicleID(playerid) || GetPlayerVehicleID(playerid) == GetPlayerVehicleID(playerid))
							{
								if(GetPlayerMoney(playerid) > 0)
								{
									new rob = random(11);
									if(rob == 1 || rob == 2 || rob == 10 || rob == 11)
									{
										new string[256];
										format(string, sizeof(string), "%s (%i) noticed you trying to rob him. Attempt failed!",oname, playerid);
										SendClientMessage(playerid, COLOR_ROB, string);
										format(string, sizeof(string), "~w~%s Noticed you trying to rob him.~n~Attempt failed!.",oname, playerid);
										GameTextForPlayer(playerid, string, 5000, 4);
										GetPlayerName(playerid,pname,sizeof(pname));
										format(string, sizeof(string), "You noticed %s (%i) trying to rob you. His attempt has failed!", pname, playerid);
										SendClientMessage(playerid, COLOR_ROB, string);
										format(string, sizeof(string), "~w~You noticed %s trying to rob you.~n~His attempt has failed!", pname, playerid);
										GameTextForPlayer(playerid, string, 5000, 4);
									}
									else if(rob == 3)
									{
										new pcash = GetPlayerMoney(playerid);
										new robcash = random(pcash);
    									GivePlayerMoney(playerid, -robcash);
										GivePlayerMoney(playerid, robcash);
										GetPlayerName(playerid, pname, sizeof(pname));
										new string[256];
										format(string, sizeof(string), "You have robbed $%i from %s (%i).", robcash, oname, playerid);
										SendClientMessage(playerid, COLOR_RED, string);
										format(string, sizeof(string), "~r~You have robbed %i from %s! Run!", robcash, oname);
										GameTextForPlayer(playerid, string, 5000, 4);
										format(string, sizeof(string), "%s (%i) has robbed $%i from you.", pname, playerid, robcash);
										SendClientMessage(playerid, COLOR_RED, string);
										format(string, sizeof(string), "~r~You have been robbed of $%i by %s!", robcash, pname);
										GameTextForPlayer(playerid, string, 5000, 4);
									}
									else if(rob == 4 || rob == 5 || rob == 8)
									{
										new pcash = GetPlayerMoney(playerid);
										new robcash = random(pcash);
										new robcash2 = robcash-random(robcash);
    									GivePlayerMoney(playerid, -robcash2);
										GivePlayerMoney(playerid, robcash2);
										new string[256];
										GetPlayerName(playerid, pname, sizeof(pname));
										format(string, sizeof(string), "You have robbed $%i from %s (%i).", robcash2, oname, playerid);
										SendClientMessage(playerid, COLOR_RED, string);
										format(string, sizeof(string), "~r~You have robbed $%i from %s! Run!", robcash2, oname);
										GameTextForPlayer(playerid, string, 5000, 4);
										format(string, sizeof(string), "%s (%i) has robbed $%i from you.", pname, playerid, robcash2);
										SendClientMessage(playerid, COLOR_RED, string);
										format(string, sizeof(string), "~r~You have been robbed of $%i by %s!", robcash2, pname);
										GameTextForPlayer(playerid, string, 5000, 4);
									}
									else if(rob == 6 || rob == 7)
									{
										new pcash = GetPlayerMoney(playerid);
										new robcash = random(pcash);
										new robcash2 = robcash-random(robcash);
										new robcash3 = robcash2-random(robcash2);
    									GivePlayerMoney(playerid, -robcash3);
										GivePlayerMoney(playerid, robcash3);
										new string[256];
										GetPlayerName(playerid, pname, sizeof(pname));
										format(string, sizeof(string), "You have robbed $%i from %s (%i).", robcash3, oname, playerid);
										SendClientMessage(playerid, COLOR_RED, string);
										format(string, sizeof(string), "%s (%i) has robbed $%i from you.", pname, playerid, robcash3);
										SendClientMessage(playerid, COLOR_RED, string);
										format(string, sizeof(string), "~r~You have robbed $%i from %s! Run!", robcash3, oname);
										GameTextForPlayer(playerid, string, 5000, 4);
										format(string, sizeof(string), "~r~You have been robbed of $%i by %s!.", robcash3, pname);
										GameTextForPlayer(playerid, string, 5000, 4);
									}
									else
									{
										SetPlayerHealth(playerid, -69);
										new string[256];
										GetPlayerName(playerid, pname, sizeof(pname));
										format(string, sizeof(string), "Your hand has stuck to %s (%i)'s pocket. ", oname, playerid);
										SendClientMessage(playerid, COLOR_FAIL, string);
										SendClientMessage(playerid, COLOR_FAIL, "He noticed it and ripped your arms off.");
										format(string, sizeof(string), "%s (%i)'s hand has stuck to your pocket while trying to rob you.", pname, playerid);
										SendClientMessage(playerid, COLOR_FAIL, string);
										SendClientMessage(playerid, COLOR_FAIL, "You noticed it and ripped his arms off.");
										format(string, sizeof(string), "*** %s (%i) has bled to death.", pname, playerid);
										SendClientMessageToAll(0x880000FF, string);
										format(string, sizeof(string), "~w~%s has ripped your arms off.", oname, playerid);
										GameTextForPlayer(playerid, string, 5000, 4);
										format(string, sizeof(string), "~w~Ripped %s's arms off.", oname, playerid);
										GameTextForPlayer(playerid, string, 5000, 4);
									}
									robtime[playerid] = 1;
									SetTimerEx("robtimer", ROB_TIME, false, "i", playerid);
								}
								else
								{
									new string[256];
									format(string, sizeof(string), "%s (%i) has no money to rob!", oname, playerid);
									SendClientMessage(playerid, COLOR_ERROR, string);
								}
							}
							else
							{
								new string[256];
								format(string, sizeof(string), "%s (%i) has to be in the same vehicle as you to be able to rob!", oname, playerid);
								SendClientMessage(playerid, COLOR_ERROR, string);
							}
						}
						else
						{
							new string[256];
							format(string, sizeof(string), "%s (%i) is not close enough to rob.", oname, playerid);
							SendClientMessage(playerid, COLOR_ERROR, string);
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_ERROR, "That player is not connected!");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_ERROR, "You cannot rob yourself!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_ERROR, "Please wait before robbing someone again.");
			}
		}
	return 1;
}

dcmd_rcp(playerid, params[])
{
	#pragma unused params
	if(RaceBuilders[playerid] == 0)
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not building a race");
		return 1;
	}
	else if(BCurrentCheckpoints[b(playerid)] < 1)
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) No checkpoint to replace");
		return 1;
	}
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	format(ystring,sizeof(ystring),"(INFO) Checkpoint %d replaced: %f,%f,%f",BSelectedCheckpoint[b(playerid)],x,y,z);
	SendClientMessage(playerid, COLOR_WHITE, ystring);
	BRaceCheckpoints[b(playerid)][BSelectedCheckpoint[b(playerid)]][0]=x;
	BRaceCheckpoints[b(playerid)][BSelectedCheckpoint[b(playerid)]][1]=y;
	BRaceCheckpoints[b(playerid)][BSelectedCheckpoint[b(playerid)]][2]=z;
	BActiveCP(playerid,BSelectedCheckpoint[b(playerid)]);
    return 1;
}

dcmd_mcp(playerid, params[])
{
	if(RaceBuilders[playerid] == 0)
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not building a race");
		return 1;
	}
	else if(BCurrentCheckpoints[b(playerid)] < 1)
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) No checkpoint to move");
		return 1;
	}
	new idx, direction, dir[32];
	dir=otherstrtok(params, idx);
	new Float:amount=floatstr(otherstrtok(params,idx));
	if(amount == 0.0 || (dir[0] != 'x' && dir[0]!='y' && dir[0]!='z'))
	{
		SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /mcp [x,y or z] [amount]");
		return 1;
	}
    if(dir[0] == 'x') direction=0;
    else if (dir[0] == 'y') direction=1;
    else if (dir[0] == 'z') direction=2;
    BRaceCheckpoints[b(playerid)][BSelectedCheckpoint[b(playerid)]][direction]=BRaceCheckpoints[b(playerid)][BSelectedCheckpoint[b(playerid)]][direction]+amount;
	BActiveCP(playerid,BSelectedCheckpoint[b(playerid)]);
	return 1;
}

dcmd_dcp(playerid, params[])
{
	#pragma unused params
	if(RaceBuilders[playerid] == 0)
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not building a race");
		return 1;
	}
	else if(BCurrentCheckpoints[b(playerid)] < 1)
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) No checkpoint to delete");
		return 1;
	}
	for(new i=BSelectedCheckpoint[b(playerid)];i<BCurrentCheckpoints[b(playerid)];i++)
	{
		BRaceCheckpoints[b(playerid)][i][0]=BRaceCheckpoints[b(playerid)][i+1][0];
		BRaceCheckpoints[b(playerid)][i][1]=BRaceCheckpoints[b(playerid)][i+1][1];
		BRaceCheckpoints[b(playerid)][i][2]=BRaceCheckpoints[b(playerid)][i+1][2];
	}
	BCurrentCheckpoints[b(playerid)]--;
	BSelectedCheckpoint[b(playerid)]--;
	if(BCurrentCheckpoints[b(playerid)] < 1)
	{
	    DisablePlayerRaceCheckpoint(playerid);
	    BSelectedCheckpoint[b(playerid)]=0;
		return 1;
	}
	else if(BSelectedCheckpoint[b(playerid)] < 0)
	{
	    BSelectedCheckpoint[b(playerid)]=0;
	}
	BActiveCP(playerid,BSelectedCheckpoint[b(playerid)]);
	SendClientMessage(playerid, COLOR_WHITE, "(INFO) Checkpoint deleted");
	return 1;
}

dcmd_clearrace(playerid,params[])
{
	#pragma unused params
	if(RaceBuilders[playerid] != 0) clearrace(playerid);
	else SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not building a race");
	return 1;
}

dcmd_editrace(playerid,params[])
{
	if(RaceBuilders[playerid] == 0)
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not building a race");
		return 1;
	}
	if(BCurrentCheckpoints[b(playerid)]>0)
	{
		for(new i=0;i<BCurrentCheckpoints[b(playerid)];i++)
		{
			BRaceCheckpoints[b(playerid)][i][0]=0.0;
			BRaceCheckpoints[b(playerid)][i][1]=0.0;
			BRaceCheckpoints[b(playerid)][i][2]=0.0;
		}
		BCurrentCheckpoints[b(playerid)]=0;
	}
	new tmp[256],idx;
    tmp = otherstrtok(params, idx);
    if(!strlen(tmp))
	{
		SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /editrace [name]");
		return 1;
    }
	new race_name[32],templine[42];
 	format(race_name,sizeof(race_name), "New York Roleplay/Race/%s.yr",tmp);
	if(!fexist(race_name))
	{
		format(ystring,sizeof(ystring), "(ERROR) Race \"%s\" does not exist",tmp);
		SendClientMessage(playerid, COLOR_GREY, ystring);
		return 1;
	}
    BCurrentCheckpoints[b(playerid)]=-1;
	new File:f, i;
	f = fopen(race_name, io_read);
	fread(f,templine,sizeof(templine));
	if(templine[0] == 'Y')
	{
		new fileversion;
	    otherstrtok(templine,i);
		fileversion = strval(otherstrtok(templine,i));
		if(fileversion > RACEFILE_VERSION)
		{
		    format(ystring,128,"(ERROR) Race \"%s\" is created with a newer version, unable to load",tmp);
		    SendClientMessage(playerid,COLOR_GREY,ystring);
		    return 1;
		}
		otherstrtok(templine,i);
		Bracemode[b(playerid)] = strval(otherstrtok(templine,i));
		Blaps[b(playerid)] = strval(otherstrtok(templine,i));
		if(fileversion >= 2)
		{
		    BAirrace[b(playerid)] = strval(otherstrtok(templine,i));
		    BCPsize[b(playerid)] = floatstr(otherstrtok(templine,i));
		}
		else
		{
			BAirrace[b(playerid)] = 0;
			BCPsize[b(playerid)] = 8.0;
		}
		fread(f,templine,sizeof(templine));
		fread(f,templine,sizeof(templine));
	}
	else
	{
		BCurrentCheckpoints[b(playerid)]++;
		BRaceCheckpoints[b(playerid)][BCurrentCheckpoints[b(playerid)]][0] = floatstr(otherstrtok(templine,i));
		BRaceCheckpoints[b(playerid)][BCurrentCheckpoints[b(playerid)]][1] = floatstr(otherstrtok(templine,i));
		BRaceCheckpoints[b(playerid)][BCurrentCheckpoints[b(playerid)]][2] = floatstr(otherstrtok(templine,i));
	}
	while(fread(f,templine,sizeof(templine),false))
	{
		BCurrentCheckpoints[b(playerid)]++;
		i=0;
		BRaceCheckpoints[b(playerid)][BCurrentCheckpoints[b(playerid)]][0] = floatstr(otherstrtok(templine,i));
		BRaceCheckpoints[b(playerid)][BCurrentCheckpoints[b(playerid)]][1] = floatstr(otherstrtok(templine,i));
		BRaceCheckpoints[b(playerid)][BCurrentCheckpoints[b(playerid)]][2] = floatstr(otherstrtok(templine,i));
	}
	fclose(f);
	BCurrentCheckpoints[b(playerid)]++;
	format(ystring,sizeof(ystring),"(INFO) Race \"%s\" has been loaded for editing. (%d checkpoints)",tmp,BCurrentCheckpoints[b(playerid)]);
	SendClientMessage(playerid, COLOR_WHITE,ystring);
    return 1;
}

dcmd_saverace(playerid, params[])
{
	if(RaceBuilders[playerid] != 0)
	{
		new tmp[256], idx;
	    tmp = otherstrtok(params, idx);
	    if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /saverace [name]");
			return 1;
	    }
	    if(BCurrentCheckpoints[b(playerid)] < 2)
	    {
	        SendClientMessage(playerid, COLOR_GREY, "(ERROR) You need atleast 2 checkpoints to save");
	        return 1;
	    }
		new race_name[32],templine[42];
		format(race_name, 32, "New York Roleplay/Race/%s.yr",tmp);
		if(fexist(race_name))
		{
			format(ystring,sizeof(ystring), "(ERROR) Race \"%s\" already exists",tmp);
			SendClientMessage(playerid, COLOR_GREY, ystring);
			return 1;
		}
		new File:f,Float:x,Float:y,Float:z, Bcreator[MAX_PLAYER_NAME];
		GetPlayerName(playerid, Bcreator, MAX_PLAYER_NAME);
		f = fopen(race_name,io_write);
		format(templine,sizeof(templine),"YRACE %d %s %d %d %d %f\n", RACEFILE_VERSION, Bcreator, Bracemode[b(playerid)], Blaps[b(playerid)], BAirrace[b(playerid)], BCPsize[b(playerid)]);
		fwrite(f,templine);
		format(templine,sizeof(templine),"A 0 A 0 A 0 A 0 A 0\n");
		fwrite(f,templine);
		format(templine,sizeof(templine),"A 0 A 0 A 0 A 0 A 0\n");
		fwrite(f,templine);
		for(new i = 0; i < BCurrentCheckpoints[b(playerid)];i++)
		{
			x=BRaceCheckpoints[b(playerid)][i][0];
			y=BRaceCheckpoints[b(playerid)][i][1];
			z=BRaceCheckpoints[b(playerid)][i][2];
			format(templine,sizeof(templine),"%f %f %f\n",x,y,z);
			fwrite(f,templine);
		}
		fclose(f);
		format(ystring,sizeof(ystring),"(INFO) Race \"%s\" has been saved",tmp);
   		SendClientMessage(playerid, COLOR_WHITE, ystring);
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not building a race");
	}
	return 1;
}

dcmd_setlaps(playerid,params[])
{
	new tmp[256], idx;
    tmp = otherstrtok(params, idx);
    if(!strlen(tmp) || strval(tmp) <= 0)
	{
		SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /setlaps [amount of laps (min: 1)]");
		return 1;
   	}
	if(RaceBuilders[playerid] != 0)
    {
		Blaps[b(playerid)] = strval(tmp);
		format(tmp,sizeof(tmp),"(INFO) Amount of laps set to %d", Blaps[b(playerid)]);
		SendClientMessage(playerid, COLOR_WHITE, tmp);
        return 1;
    }
	if(RaceAdmin == 1 && IsNotAdmin(playerid)) return 1;
	if(RaceActive == 1 || RaceStart == 1) SendClientMessage(playerid, COLOR_GREY, "(ERROR) Race already in progress");
	else if(LCurrentCheckpoint == 0) SendClientMessage(playerid, COLOR_GREY, "(ERROR) No race loaded");
	else
	{
	    Racelaps=strval(tmp);
		format(tmp,sizeof(tmp),"(INFO) Amount of laps set to %d for current race", Racelaps);
		SendClientMessage(playerid, COLOR_WHITE, tmp);
	}
	return 1;
}

dcmd_racemode(playerid,params[])
{
	new tmp[256], idx, tempmode;
    tmp = otherstrtok(params, idx);
    if(!strlen(tmp))
	{
		SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /racemode [0/1/2/3]");
		return 1;
   	}
	if(tmp[0] == 'd') tempmode=0;
	else if(tmp[0] == 'r') tempmode=1;
	else if(tmp[0] == 'y') tempmode=2;
	else if(tmp[0] == 'm') tempmode=3;
	else tempmode=strval(tmp);

	if (0 > tempmode || tempmode > 3)
   	{
   	    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid racemode");
		return 1;
   	}
	if(RaceBuilders[playerid] != 0)
    {
		if(tempmode == 2 && BCurrentCheckpoints[b(playerid)] < 3)
		{
		    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not set racemode 2 on races with only 2 CPs. Changing to mode 1");
		    Bracemode[b(playerid)] = 1;
		    return 1;
		}
		Bracemode[b(playerid)] = tempmode;
		format(tmp,sizeof(tmp),"(INFO) Racemode set to %d", Bracemode[b(playerid)]);
		SendClientMessage(playerid, COLOR_WHITE, tmp);
        return 1;
    }
	if(RaceAdmin == 1 && IsNotAdmin(playerid)) return 1;
	if(RaceActive == 1 || RaceStart == 1) SendClientMessage(playerid, COLOR_GREY, "(ERROR) Race already in progress");
	else if(LCurrentCheckpoint == 0) SendClientMessage(playerid, COLOR_GREY, "(ERROR) No race loaded");
	else
	{
		if(tempmode == 2 && LCurrentCheckpoint < 2)
		{
		    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not set racemode 2 on races with only 2 CPs. Changing to mode 1");
		    Racemode = 1;
		    return 1;
		}
	    Racemode=tempmode;
		format(tmp,sizeof(tmp),"(INFO) Racemode set to %d", Racemode);
		SendClientMessage(playerid, COLOR_WHITE, tmp);
	}
	return 1;
}

dcmd_loadrace(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		Racemode = 0; Racelaps = 1;
		new tmp[128], idx, fback;
    	tmp = otherstrtok(params, idx);
    	if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /loadrace [name]");
			return 1;
    	}
    	if(RaceActive == 1)
    	{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) A race is already active");
			return 1;
    	}
		fback=LoadRace(tmp);
		if(fback == -1) format(ystring,sizeof(ystring),"(ERROR) Race \"%s\" does not exist",tmp);
		else if (fback == -2) format(ystring,sizeof(ystring),"(ERROR) Race \"%s\" is created with a newer version, unable to load",tmp);
		if(fback < 0)
		{
	    	SendClientMessage(playerid,COLOR_GREY,ystring);
	    	return 1;
		}
		format(ystring,sizeof(ystring),"(INFO) Race \"%s\" loaded",CRaceName);
		SendClientMessage(playerid,COLOR_WHITE,ystring);
		if(LCurrentCheckpoint<2 && Racemode == 2)
		{
	    	Racemode = 1;
		}
		if(!IsValidMenu(MRace)) CreateRaceMenus();
		if(Airrace == 0) SetMenuColumnHeader(MRace,0,"Air race: Off");
		else SetMenuColumnHeader(MRace,0,"Air race: On");
		TogglePlayerControllable(playerid,0);
		ShowMenuForPlayer(MRace,playerid);
		return 1;
	}
	return 1;
}

dcmd_startrace(playerid, params[])
{
	#pragma unused params
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
		if(LCurrentCheckpoint == 0) SendClientMessage(playerid, COLOR_GREY, "(ERROR) No race loaded");
		else if (RaceActive == 1) SendClientMessage(playerid, COLOR_GREY, "(ERROR) Race is already active");
		else startrace();
		return 1;
	}
	return 1;
}


dcmd_deleterace(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		new filename[128], idx;
		filename = otherstrtok(params,idx);
		if(!(strlen(filename)))
		{
	    	SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /deleterace [race]");
	    	return 1;
		}
		format(filename,sizeof(filename),"New York Roleplay/Race/%s.yr",filename);
		if(!fexist(filename))
		{
			format(ystring,sizeof(ystring), "(ERROR) Race \"%s\" does not exist",filename);
			SendClientMessage(playerid, COLOR_GREY, ystring);
			return 1;
		}
		fremove(filename);
		format(ystring,sizeof(ystring), "(INFO) Race \"%s\" has been deleted",filename);
		SendClientMessage(playerid, COLOR_WHITE, ystring);
		return 1;
	}
	return 1;
}

dcmd_join(playerid,params[])
{
	#pragma unused params
	if(RaceBuilders[playerid] != 0)
	{
	    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are currently building a race, use /clearrace to exit build mode");
	    return 1;
	}
	if(RaceParticipant[playerid]>0)
	{
	    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You have already joined the race");
	}
	else if(RaceActive==1 && RaceStart==0)
	{
		if(PrizeMode >= 2 && GetPlayerMoney(playerid) < JoinFee)
		{
			format(ystring,sizeof(ystring),"(ERROR) You do not have enough money to join the race (Join fee: %d$)",JoinFee);
			SendClientMessage(playerid, COLOR_GREY, ystring);
			return 1;
		}
		else if (PrizeMode >= 2)
		{
			new tempval;
			tempval=(-1)*JoinFee;
		    GivePlayerCash(playerid,tempval);
		    Pot+=JoinFee;
		}
		CurrentCheckpoint[playerid]=0;
		if(Racemode == 3)
		{
			SetRaceCheckpoint(playerid,LCurrentCheckpoint,LCurrentCheckpoint-1);
			CurrentCheckpoint[playerid]=LCurrentCheckpoint;
		}
		else SetRaceCheckpoint(playerid,0,1);
		RaceParticipant[playerid]=1;
		CurrentLap[playerid]=0;
		SendClientMessage(playerid, COLOR_WHITE, "(INFO) You have joined the race, go to the start");
		Participants++;
	}
	else if(RaceActive==1 && RaceStart==1)
	{
	    SendClientMessage(playerid, COLOR_GREY, "(ERROR) The race has already started, can not join");
	}
	else
	{
	    SendClientMessage(playerid, COLOR_GREY, "(ERROR) There is no race you can join");
	}
	return 1;
}

dcmd_leave(playerid,params[])
{
	#pragma unused params
	if(RaceParticipant[playerid] > 0)
	{
       	if(RaceParticipant[playerid]==3 && RaceStart == 1)
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) Unable to leave at this time, countdown in progress");
			return 1;
		}
		DisablePlayerRaceCheckpoint(playerid);
		RaceParticipant[playerid]=0;
		Participants--;
		SendClientMessage(playerid, COLOR_WHITE, "(INFO) You have left the race");
		if(PrizeMode >= 2 && RaceStart == 0)
		{
		    GivePlayerCash(playerid,JoinFee/2);
		    Pot-=JoinFee/2;
		}
        if(Participants == 0) endrace();
		else if(RaceStart == 0)ReadyRefresh();
	}
	else SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not in a race");
    return 1;
}

dcmd_endrace(playerid, params[])
{
	#pragma unused params
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
    	if(RaceActive==0)
    	{
        	SendClientMessage(playerid, COLOR_GREY, "(ERROR) There is no race active");
			return 1;
    	}
    	endrace();
		return 1;
	}
	return 1;
}

dcmd_ready(playerid, params[])
{
	#pragma unused params
	new PState=GetPlayerState(playerid);
	if(RaceParticipant[playerid]==2 && PState != PLAYER_STATE_PASSENGER)
	{
		SendClientMessage(playerid, COLOR_WHITE, "(INFO) You are now ready, type /ready again to cancel");
		RaceParticipant[playerid]=3;
		ReadyRefresh();
	}
	else if (RaceParticipant[playerid]==3 && RaceStart==0)
	{
	    SendClientMessage(playerid, COLOR_WHITE, "(INFO) You are not ready, type /ready and get into position");
	    RaceParticipant[playerid]=2;
	}
	else if (PState == PLAYER_STATE_PASSENGER) SendClientMessage(playerid, COLOR_GREY, "(ERROR) You must be driving for yourself");
	else if(RaceParticipant[playerid] == 1) SendClientMessage(playerid, COLOR_GREY, "(ERROR) You must have visited the starting CP to /ready");
	else SendClientMessage(playerid, COLOR_GREY, "(ERROR) You have not participated in a race");
    return 1;
}

dcmd_bestlap(playerid,params[])
{
	new tmp[64], idx;
    tmp = otherstrtok(params, idx);
	if(LoadTimes(playerid,1,tmp)) return 1;
	if(TopLapTimes[0] == 0)
	{
	    SendClientMessage(playerid, COLOR_WHITE, "(INFO) No scores available");
		return 1;
	}
	else if(ORacemode == 0)
	{
	    SendClientMessage(playerid, COLOR_GREY, "(ERROR) This race does not have any laps");
		return 1;
	}
	format(ystring,sizeof(ystring),"(INFO) %s by %s - Best Laps:",CRaceName,CBuilder);
	SendClientMessage(playerid,COLOR_WHITE,ystring);
	for(new i;i<5;i++)
	{
		if(TopLapTimes[i] == 0)
		{
		    format(ystring,sizeof(ystring),"%d. None yet",i+1);
			i=6;
		}
		else
		{
	 	   format(ystring,sizeof(ystring),"%d. %s - %s",i+1,BeHuman(TopLapTimes[i]),TopLappers[i]);
	    }
	    SendClientMessage(playerid,COLOR_WHITE,ystring);
	}
    return 1;
}

dcmd_bestrace(playerid,params[])
{
	new tmp[64], idx;
    tmp = otherstrtok(params, idx);
	if(LoadTimes(playerid,0,tmp)) return 1;
	if(TopRacerTimes[0] == 0)
	{
	    SendClientMessage(playerid, COLOR_WHITE, "(INFO) No scores available");
		return 1;
	}
	format(ystring,sizeof(ystring),"(INFO) %s by %s - Best Race times:",CRaceName,CBuilder);
	SendClientMessage(playerid,COLOR_WHITE,ystring);
	for(new i;i<5;i++)
	{
		if(TopRacerTimes[i] == 0)
		{
		    format(ystring,sizeof(ystring),"(INFO) %d. None yet",i+1);
			i=6;
		}
		else
		{
	 	   format(ystring,sizeof(ystring),"(INFO) %d. %s - %s",i+1,BeHuman(TopRacerTimes[i]),TopRacers[i]);
	    }
	    SendClientMessage(playerid,COLOR_WHITE,ystring);
	}
    return 1;
}

dcmd_airrace(playerid,params[])
{
	#pragma unused params
	if(RaceBuilders[playerid] != 0)
	{
	    if(BAirrace[b(playerid)] == 0)
	    {
	        SendClientMessage(playerid, COLOR_WHITE, "(INFO) Air race enabled");
			BAirrace[b(playerid)]=1;
	    }
	    else
	    {
	        SendClientMessage(playerid, COLOR_WHITE, "(INFO) Air race disabled");
			BAirrace[b(playerid)]=0;
	    }
		return 1;
	}
	if(RaceAdmin == 1 && IsNotAdmin(playerid)) return 1;
	if(RaceActive == 1 || RaceStart == 1) SendClientMessage(playerid, COLOR_GREY, "(ERROR) Race is already in progress");
	else if(LCurrentCheckpoint == 0) SendClientMessage(playerid, COLOR_GREY, "(ERROR) No race loaded");
	else if(Airrace == 0)
    {
        SendClientMessage(playerid, COLOR_WHITE, "(INFO) Air race enabled");
		Airrace = 1;
    }
    else if(Airrace == 1)
    {
        SendClientMessage(playerid, COLOR_WHITE, "(INFO) Air race disabled");
		Airrace = 0;
    }
    else printf("Error in /airrace detected. RaceActive: %d, RaceStart: %d LCurrentCheckpoint: %d, Airrace: %d", RaceActive,RaceStart,LCurrentCheckpoint,Airrace);
	return 1;
}

dcmd_cpsize(playerid,params[])
{
	new idx, tmp[32];
	tmp = otherstrtok(params,idx);
	if(!(strlen(tmp)) || floatstr(tmp) <= 0.0)
	{
	    SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /cpsize [size]");
	    return 1;
	}
	if(RaceBuilders[playerid] != 0)
	{
	    BCPsize[b(playerid)] = floatstr(tmp);
	    format(ystring,sizeof(ystring),"(INFO) Checkpoint size set to %f",floatstr(tmp));
		SendClientMessage(playerid,COLOR_WHITE,ystring);
	    return 1;
	}
	if(RaceAdmin == 1 && IsNotAdmin(playerid)) return 1;
	if(RaceActive == 1) SendClientMessage(playerid, COLOR_GREY, "(ERROR) Race has already been activated");
	else if(LCurrentCheckpoint == 0) SendClientMessage(playerid, COLOR_GREY, "(ERROR) No race loaded");
	else
	{
	    CPsize = floatstr(tmp);
	    format(ystring,sizeof(ystring),"(INFO) Checkpoint size set to %f",floatstr(tmp));
		SendClientMessage(playerid,COLOR_WHITE,ystring);
	}
	return 1;
}

dcmd_prizemode(playerid,params[])
{
	if(IsNotAdmin(playerid)) return 1;
	new idx, tmp;
	tmp=strval(otherstrtok(params,idx));
    if(tmp < 0 || tmp > 4) SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /prizemode [0-4]");
	else if(RaceActive == 1) SendClientMessage(playerid, COLOR_GREY, "(ERROR) Race is already active");
    else
    {
        PrizeMode = tmp;
        format(ystring,sizeof(ystring),"(INFO) Prizemode set to %d",PrizeMode);
		SendClientMessage(playerid,COLOR_WHITE,ystring);
    }
	return 1;
}

dcmd_setprize(playerid,params[])
{
	if(IsNotAdmin(playerid)) return 1;
	new idx, tmp;
    tmp = strval(otherstrtok(params, idx));
    if(0 >= tmp) SendClientMessage(playerid, COLOR_WHITE, "(USAGE) /setprize [amount]");
	else if(RaceActive == 1) SendClientMessage(playerid, COLOR_GREY, "(ERROR) Race is already active");
    else
    {
        Prize = tmp;
        format(ystring,sizeof(ystring),"(INFO) Prize set to %d",Prize);
		SendClientMessage(playerid,COLOR_WHITE,ystring);
    }
	return 1;
}

dcmd_raceadmin(playerid,params[])
{
	#pragma unused params
 	if(PlayerInfo[playerid][pAdmin] >= 1)
    {
		if(!IsValidMenu(MAdmin)) CreateRaceMenus();
		TogglePlayerControllable(playerid,0);
		ShowMenuForPlayer(MAdmin,playerid);
		return 1;
	}
	return 1;
}

dcmd_buildmenu(playerid,params[])
{
	#pragma unused params
	if(PlayerInfo[playerid][pAdmin] >= 1)
 	{
		if(RaceBuilders[playerid] == 0)
		{
			SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not building a race");
			return 1;
		}
		if(BAirrace[b(playerid)] == 0) SetMenuColumnHeader(MBuild,0,"Air race: Off");
		else SetMenuColumnHeader(MBuild,0,"Air race: On");
		if(!IsValidMenu(MBuild)) CreateRaceMenus();
		TogglePlayerControllable(playerid,0);
		ShowMenuForPlayer(MBuild,playerid);
		return 1;
	}
	return 1;
}
//==============================================================================
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	new string[128];
	if(ispassenger != 0)
	{
		if(GetVehicleModel(vehicleid) == 519)
		{
			if (ShamalExists(vehicleid) == 0)
			{
				if (get_available_objects() > (MAX_OBJECTS-objects_per_shamal)) return 1;
				CreateShamalInt(vehicleid, randomEx(3000), randomEx(3000), float(random(100)+800));
			}
			SetPlayerPosInShamal(playerid, vehicleid);
		}
	}
	if(GetVehicleModel(vehicleid) == 592 && ispassenger == 1)
	{
		SetPlayerInterior(playerid,9);
		SetPlayerFacingAngle(playerid,0.0);
		SetPlayerPos(playerid, 315.856170,1024.496459,1949.797363);
		SetCameraBehindPlayer(playerid);
		InAndrom[playerid] = vehicleid;
	}
	if(VehicleLocked[vehicleid])
	{
		new Float:playerposx, Float:playerposy, Float:playerposz;
		GetPlayerPos(playerid, playerposx, playerposy, playerposz);
		if(PlayerInfo[playerid][pAdmin] == 0)
		{
			SetPlayerPos(playerid,playerposx, playerposy, playerposz);
		}
		SendClientMessage(playerid, COLOR_WHITE, "(INFO) Vehicle Locked");
	}
	if(DynamicCars[vehicleid-1][CarType] == 1)
	{
		if(TakingDrivingTest[playerid] != 1)
		{
			new Float:playerposx, Float:playerposy, Float:playerposz;
			GetPlayerPos(playerid, playerposx, playerposy, playerposz);
			if(PlayerInfo[playerid][pAdmin] == 0)
			{
   				SetPlayerPos(playerid,playerposx, playerposy, playerposz);
			}
			SendClientMessage(playerid, COLOR_GREY, "(INFO) You are not taking the driving test");
		}
	}
    if(DynamicCars[vehicleid-1][FactionCar] != 255 && !ispassenger)
	{
	    if(DynamicFactions[DynamicCars[vehicleid-1][FactionCar]][fType] == 1)
	    {
	        if(PlayerInfo[playerid][pFaction] != DynamicCars[vehicleid-1][FactionCar])
	        {
	            new Float:playerposx, Float:playerposy, Float:playerposz;
				GetPlayerPos(playerid, playerposx, playerposy, playerposz);
	  			if(PlayerInfo[playerid][pAdmin] == 0)
				{
					SetPlayerPos(playerid,playerposx, playerposy, playerposz);
				}
				format(string, sizeof(string), "(HQ) %s has been spotted attempting to steal a law enforcement vehicle", GetPlayerNameEx(playerid));
				SendFactionTypeMessage(1,COLOR_LSPD,string);
				new location[MAX_ZONE_NAME];
				GetPlayer2DZone(playerid, location, MAX_ZONE_NAME);
				format(string, sizeof(string), "(HQ) All units be on the lookout for %s - Person Last Seen: %s", GetPlayerNameEx(playerid),location);
				SendClientMessage(playerid, COLOR_WHITE, "(INFO) You have been spotted attempting to steal a law enforcement vehicle");
				SetPlayerWantedLevelEx(playerid,GetPlayerWantedLevel(playerid)+1);
	        }
	    }
		format(string, sizeof(string), "(INFO) This vehicle belongs to the %s",DynamicFactions[DynamicCars[vehicleid-1][FactionCar]][fName]);
		SendClientMessage(playerid,COLOR_WHITE, string);
	}
	if(IsAPlane(vehicleid) || IsAHelicopter(vehicleid) && !ispassenger)
 	{
		new Float:playerposx, Float:playerposy, Float:playerposz;
		GetPlayerPos(playerid, playerposx, playerposy, playerposz);
  		if(PlayerInfo[playerid][pFlyLic] == 0)
		{
  			SendClientMessage(playerid, COLOR_GREY, "(INFO) You do not have a flying license");
			if(PlayerInfo[playerid][pAdmin] == 0)
			{
   				SetPlayerPos(playerid,playerposx, playerposy, playerposz);
			}
		}
   	}
	return 1;
}
//==============================================================================
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    gLastCar[playerid] = GetPlayerVehicleID(playerid);
	    if(DynamicCars[GetPlayerVehicleID(playerid)-1][CarType] != 1)
		{
		    if(EngineStatus[GetPlayerVehicleID(playerid)] == 0)
			{
				SendClientMessage(playerid, COLOR_WHITE, "(INFO) Vehicle engine is not started (/engine)");
				TogglePlayerControllable(playerid,0);
			}
		}
	    if(DynamicCars[GetPlayerVehicleID(playerid)-1][FactionCar] != 255)
		{
		    if(DynamicFactions[DynamicCars[GetPlayerVehicleID(playerid)-1][FactionCar]][fType] == 1)
		    {
		        if(PlayerInfo[playerid][pFaction] != DynamicCars[GetPlayerVehicleID(playerid)-1][FactionCar])
		        {
					RemoveDriverFromVehicle(playerid);
		        }
		    }
		}
  		if(DynamicCars[GetPlayerVehicleID(playerid)-1][FactionCar] != 255)
		{
		    if(DynamicFactions[DynamicCars[GetPlayerVehicleID(playerid)-1][FactionCar]][fType] == 0)
		    {
		        if(PlayerInfo[playerid][pFaction] != DynamicCars[GetPlayerVehicleID(playerid)-1][FactionCar])
		        {
					RemoveDriverFromVehicle(playerid);
		        }
		    }
		}
  		if(DynamicCars[GetPlayerVehicleID(playerid)-1][FactionCar] != 255)
		{
		    if(DynamicFactions[DynamicCars[GetPlayerVehicleID(playerid)-1][FactionCar]][fType] == 2)
		    {
		        if(PlayerInfo[playerid][pFaction] != DynamicCars[GetPlayerVehicleID(playerid)-1][FactionCar])
		        {
					RemoveDriverFromVehicle(playerid);
		        }
		    }
		}
	    if(PlayerInfo[playerid][pCarLic] == 0 && IsAPlane(GetPlayerVehicleID(playerid))==0 && IsAHelicopter(GetPlayerVehicleID(playerid))==0)
	    {
	    	SendClientMessage(playerid, COLOR_WHITE, "(INFO) You are driving without a license");
	    }
		new updatedvehicleid = GetPlayerVehicleID(playerid) - 1;
		if(DynamicCars[updatedvehicleid][CarType] == 1)
		{
			if(TakingDrivingTest[playerid] == 1)
			{
				SendClientMessage(playerid, COLOR_WHITE, "(INFO) Complete your test by going through each checkpoint");

				if(DrivingTestStep[playerid] == 0)
				{
			 		SetPlayerCheckpoint(playerid, 1328.8065,-1403.0996,13.2369, 5.0);
					DrivingTestStep[playerid] = 1;
				}
	   		}
			else
			{
				RemoveDriverFromVehicle(playerid);
			}
		}
		if(IsATowTruck(GetPlayerVehicleID(playerid)))
		{
		    if(PlayerInfo[playerid][pJob] != 6)
			{
     			SendClientMessage(playerid,COLOR_GREY,"(ERROR) You are not a mechanic");
     			RemovePlayerFromVehicle(playerid);
			}
		}
	  	if(IsAPlane(GetPlayerVehicleID(playerid)) || IsAHelicopter(GetPlayerVehicleID(playerid)))
	 	{
	  		if(PlayerInfo[playerid][pFlyLic] == 0)
			{
				if(PlayerInfo[playerid][pAdmin] == 0)
				{
				   	RemoveDriverFromVehicle(playerid);
    			}
			}
	   	}
	}
	return 1;
}
public robtimer(playerid)
{
	robtime[playerid] = 0;
}
//==============================================================================
public OnPlayerEnterCheckpoint(playerid)
{
	for(new h = 0; h < sizeof(DynamicCars); h++)
	{
			new updatedvehicleid = GetPlayerVehicleID(playerid) - 1;
			if(DynamicCars[updatedvehicleid][CarType] == 1)
			{
			if(TakingDrivingTest[playerid] == 1)
			{
				if(PlayerToPoint(5.0,playerid,1328.8065,-1403.0996,13.2369) && DrivingTestStep[playerid] == 1)
				{
	                DrivingTestStep[playerid] = 2;
	                SetPlayerCheckpoint(playerid, 1441.4253,-1443.6260,13.2652, 5.0);
				}
				else if(PlayerToPoint(5.0,playerid,1441.4253,-1443.6260,13.2652) && DrivingTestStep[playerid] == 2)
				{
	                DrivingTestStep[playerid] = 3;
	                SetPlayerCheckpoint(playerid, 1427.0172,-1578.5571,13.2460, 5.0);
				}
				else if(PlayerToPoint(5.0,playerid,1427.0172,-1578.5571,13.2460) && DrivingTestStep[playerid] == 3)
				{
	                DrivingTestStep[playerid] = 4;
	                SetPlayerCheckpoint(playerid, 1325.4891,-1570.3796,13.2504, 5.0);
				}
				else if(PlayerToPoint(5.0,playerid,1325.4891,-1570.3796,13.2504) && DrivingTestStep[playerid] == 4)
				{
	                DrivingTestStep[playerid] = 5;
	                SetPlayerCheckpoint(playerid, 1321.9575,-1392.0773,13.2449, 5.0);
				}
				else if(PlayerToPoint(5.0,playerid,1321.9575,-1392.0773,13.2449) && DrivingTestStep[playerid] == 5)
				{
				    new Float:health;
				    new veh;
				    veh = GetPlayerVehicleID(playerid);
				    GetVehicleHealth(veh, health);

				    if(health >= 900.0)
				    {
				    	SendClientMessage(playerid, COLOR_WHITE, "(INFO) You passed the drivers license test");
				    	PlayerInfo[playerid][pCarLic] = 1;
				    	OnPlayerDataSave(playerid);
				    	SetVehicleToRespawn(veh);
				    	TakingDrivingTest[playerid] = 0;
			    	 	DisablePlayerCheckpoint(playerid);
				    }
				    else
				    {
						SendClientMessage(playerid, COLOR_GREY, "(INFO) You failed the drivers license test");
						SetVehicleToRespawn(veh);
						TakingDrivingTest[playerid] = 0;
						DisablePlayerCheckpoint(playerid);
				    }
	                DrivingTestStep[playerid] = 0;
				}
				return 1;
			}
		}
	}
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(RaceParticipant[playerid]>=1)
	{
		if(RaceParticipant[playerid] == 6)
	    {
			new name[MAX_PLAYER_NAME], LapTime, RaceTime;
			LapTime=GetLapTick(playerid);
			RaceTime=GetRaceTick(playerid);
			GetPlayerName(playerid, name, MAX_PLAYER_NAME);
			RaceParticipant[playerid]=0;
			RaceSound(playerid,1139);
			format(ystring,sizeof(ystring),"(INFO) %s has finished the race, position: %d",name,Ranking);
			if (Ranking < 4) SendClientMessageToAll(COLOR_RED,ystring);
			else SendClientMessage(playerid,COLOR_WHITE,ystring);
			if(Racemode == ORacemode && ORacelaps == Racelaps)
			{
				new	LapString[10],RaceString[10], laprank, racerank;
				LapString=BeHuman(LapTime);
				RaceString=BeHuman(RaceTime);
				format(ystring,sizeof(ystring),"~w~Racetime: %s",RaceString);
				if(ORacemode!=0) format(ystring,sizeof(ystring),"%s~n~Laptime: %s",ystring,LapString);
				laprank=CheckBestLap(playerid,LapTime);
				if(laprank == 1)
				{
				    format(ystring,sizeof(ystring),"%s~n~~y~LAP RECORD",ystring);
				}
				racerank=CheckBestRace(playerid,RaceTime);
				if(racerank == 1)
				{
				    format(ystring,sizeof(ystring),"%s~n~~y~TRACK RECORD",ystring);
				}
			    GameTextForPlayer(playerid,ystring,5000,3);
		    }
			if(Ranking<4)
			{
				new winrar;
				if(Ranking == 1 && Participants == 1) winrar=Pot;
				else if(Ranking == 1 && Participants == 2) winrar=Pot/6*4;
				else winrar=Pot/6*PrizeMP;
				GivePlayerCash(playerid,winrar);
				format(ystring,sizeof(ystring),"(INFO) You have earned $%d from the race",winrar);
				PrizeMP--;
				SendClientMessage(playerid,COLOR_WHITE,ystring);
			}
			Ranking++;
			Participants--;
	        DisablePlayerRaceCheckpoint(playerid);
	        if(Participants == 0)
	        {
	            endrace();
	        }
	    }
	    else if (RaceStart == 0 && RaceParticipant[playerid]==1)
	    {
			SendClientMessage(playerid, COLOR_WHITE, "(INFO) Type /ready when you are ready to start");
			RaceParticipant[playerid]=2;
	    }
	    else if (RaceStart==1)
	    {
			RaceSound(playerid,1138);
			SetNextCheckpoint(playerid);
	    }
	}
	return 1;
}
//==============================================================================
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys == 16 && InShamal[playerid] != 0)
	{
		new Float:S, Float:H, Float:M, Float:L;
		GetVehiclePos(InShamal[playerid], S, H, M);
		GetVehicleZAngle(InShamal[playerid], L);
		S += (5.0*floatsin(-(L-45.0), degrees)), H += (5.0*floatcos(-(L-45.0), degrees));
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid, S, H, M-0.94);
		SetPlayerFacingAngle(playerid, L);
		InShamal[playerid] = 0;
	}
	if (newkeys & 16 && InAndrom[playerid] != 0)
	{
		new Float:N,Float:D,Float:R,Float:M;
		GetVehiclePos(InAndrom[playerid],N,D,R);
		GetVehicleZAngle(InAndrom[playerid],M);
		N+=(5*floatsin(-floatsub(M,45.0),degrees)),
		D+=(5*floatcos(-floatsub(M,45.0),degrees));
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,N,D,floatsub(R,0.94));
		SetPlayerFacingAngle(playerid,M);
		SetCameraBehindPlayer(playerid);
		InAndrom[playerid] = 0;
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if (newkeys & KEY_SECONDARY_ATTACK)
		{
	        if(EngineStatus[GetPlayerVehicleID(playerid)] == 0)
			{
				RemoveDriverFromVehicle(playerid);
			}
			if(OutOfFuel[playerid])
			{
				RemoveDriverFromVehicle(playerid);
				OutOfFuel[playerid] = 0;
			}
		}
	}
	return 1;
}
//==============================================================================
public OnPlayerExitedMenu(playerid)
{
	TogglePlayerControllable(playerid, 1);
	PlayerMenu[playerid] = -1;
	if(!IsValidMenu(GetPlayerMenu(playerid))) return 1;
	ShowMenuForPlayer(GetPlayerMenu(playerid), playerid);
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	new Menu:Current = GetPlayerMenu(playerid);
	if(Current == MAdmin)
	{
		if(row <=4 && RaceActive == 1)
		{
		    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Race active, can not change this setting");
			ShowMenuForPlayer(MAdmin,playerid);
		    return 1;
		}
		if(row == 0) ShowMenuForPlayer(MPMode,playerid);
		else if (row == 1) ShowMenuForPlayer(MPrize,playerid);
		else if (row == 2) ShowMenuForPlayer(MDyna,playerid);
		else if (row == 3) ShowMenuForPlayer(MFee,playerid);
		else if (row == 4) ShowMenuForPlayer(MDelay,playerid);
		else if (row == 5)
		{
		    if(RaceActive == 1) endrace();
		    else SendClientMessage(playerid, COLOR_GREY, "(ERROR) No race active");
		    ShowMenuForPlayer(MAdmin,playerid);
		}
		else if (row == 9)
		{
			TogglePlayerControllable(playerid,1);
			HideMenuForPlayer(MAdmin,playerid);
		}
		else
		{
			if(row == 6 && RaceAdmin == 1) RaceAdmin=0;
			else if(row == 6 && RaceAdmin == 0) RaceAdmin=1;
			else if(row == 7 && BuildAdmin == 1) BuildAdmin=0;
			else if(row == 7 && BuildAdmin == 0) BuildAdmin=1;
			else if(row == 8 && RRotation >= 0) RRotation = -1;
			else RRotation = 0;
			if(RaceAdmin == 1) format(ystring,sizeof(ystring),"RA: On");
			else format(ystring,sizeof(ystring),"RA: Off");
			if(BuildAdmin == 1) format(ystring,sizeof(ystring),"%s BA: On",ystring);
			else format(ystring,sizeof(ystring),"%s BA: Off",ystring);
			if(RRotation >= 0) format(ystring,sizeof(ystring),"%s RR: On",ystring);
			else format(ystring,sizeof(ystring),"%s RR: Off",ystring);
			if(RRotation >= 0 && row == 8)  RotationTimer = SetTimer("RaceRotation",RRotationDelay,1);
			else if(RRotation -1 && row == 8) KillTimer(RotationTimer);
			RefreshMenuHeader(playerid,MAdmin,ystring);
		}
	}
	else if(Current == MPMode)
	{
		if(row == 5)
		{
			 ShowMenuForPlayer(MAdmin,playerid);
			 return 1;
		}
		PrizeMode = row;
		if     (PrizeMode == 0) ystring = "Fixed";
		else if(PrizeMode == 1) ystring = "Dynamic";
		else if(PrizeMode == 2) ystring = "Join Fee";
		else if(PrizeMode == 3) ystring = "Join Fee + Fixed";
		else if(PrizeMode == 4) ystring = "Join Fee + Dynamic";
		format(ystring,sizeof(ystring),"Mode: %s",ystring);
		RefreshMenuHeader(playerid,MPMode,ystring);
	}
	else if(Current == MPrize)
	{
	    if(row == 6)
	    {
	        ShowMenuForPlayer(MAdmin,playerid);
	        return 1;
	    }
	    if     (row == 0) Prize += 100;
	    else if(row == 1) Prize += 1000;
	    else if(row == 2) Prize += 10000;
	    else if(row == 3) Prize -= 100;
	    else if(row == 4) Prize -= 1000;
	    else if(row == 5) Prize -= 10000;
	    if(Prize < 0) Prize = 0;
		format(ystring,sizeof(ystring),"Amount: %d",Prize);
		RefreshMenuHeader(playerid,MPrize,ystring);
	}
	else if(Current == MDyna)
	{
		if(row == 4)
		{
		    ShowMenuForPlayer(MAdmin,playerid);
		    return 1;
		}
		if     (row == 0) DynaMP++;
		else if(row == 1) DynaMP+=5;
		else if(row == 2) DynaMP--;
		else if(row == 3) DynaMP-=5;
		else if(DynaMP < 1) DynaMP = 1;
		format(ystring,sizeof(ystring),"Multiplier: %dx",DynaMP);
		RefreshMenuHeader(playerid,MDyna,ystring);
	}
	else if(Current == MBuild)
	{

	    if (row == 0)
		{
			format(ystring,sizeof(ystring),"Laps: %d",Blaps[b(playerid)]);
			SetMenuColumnHeader(MLaps,0,ystring);
			ShowMenuForPlayer(MLaps,playerid);
		}
	    else if (row == 1)
		{
			format(ystring,sizeof(ystring),"Mode: %s",ReturnModeName(Bracemode[b(playerid)]));
			SetMenuColumnHeader(MRacemode,0,ystring);
			ShowMenuForPlayer(MRacemode,playerid);
		}
		else if (row == 2)
		{
		    format(ystring,sizeof(ystring),"Size: %0.2f",BCPsize[b(playerid)]);
		    SetMenuColumnHeader(MCPsize,0,ystring);
		    ShowMenuForPlayer(MCPsize,playerid);
		}
	    else if (row == 3)
	    {
	        if(BAirrace[b(playerid)] == 0)
			{
				BAirrace[b(playerid)] = 1;
				format(ystring,sizeof(ystring),"Air race: On");
			}
   	        else if(BAirrace[b(playerid)] == 1)
			{
				BAirrace[b(playerid)] = 0;
				format(ystring,sizeof(ystring),"Air race: Off");
			}
   	        RefreshMenuHeader(playerid,MBuild,ystring);
	    }
	    else if(row == 4)
	    {
	        clearrace(playerid);
	        HideMenuForPlayer(MBuild,playerid);
	        TogglePlayerControllable(playerid,1);
			return 1;
	    }
	    else if(row == 5)
	    {
	        HideMenuForPlayer(MBuild,playerid);
			TogglePlayerControllable(playerid,1);
	    }
	}
	else if(Current == MLaps)
	{

	    if(row == 6)
	    {
	        if(RaceBuilders[playerid] != 0) ShowMenuForPlayer(MBuild,playerid);
	        else ShowMenuForPlayer(MRace,playerid);
	        return 1;
		}
		new change=0;
	    if     (row == 0) change++;
		else if(row == 1) change+=5;
		else if(row == 2) change+=10;
		else if(row == 3) change--;
		else if(row == 4) change-=5;
		else if(row == 5) change-=10;
		if(RaceBuilders[playerid] != 0)
		{
		    Blaps[b(playerid)] += change;
			if(Blaps[b(playerid)] < 1) Blaps[b(playerid)] = 1;
			format(ystring,sizeof(ystring),"Laps: %d",Blaps[b(playerid)]);
			RefreshMenuHeader(playerid,MLaps,ystring);
		}
		else
		{
			Racelaps += change;
			if(Racelaps < 1) Racelaps = 1;
			format(ystring,sizeof(ystring),"Laps: %d",Racelaps);
			RefreshMenuHeader(playerid,MLaps,ystring);
		}

	}
	else if(Current == MRacemode)
	{
		if(row == 4)
		{
		    if(RaceBuilders[playerid] != 0) ShowMenuForPlayer(MBuild,playerid);
		    else ShowMenuForPlayer(MRace,playerid);
		    return 1;
		}
		if(RaceBuilders[playerid] != 0)
		{
		    Bracemode[b(playerid)]=row;
			if(Bracemode[b(playerid)] == 2 && BCurrentCheckpoints[b(playerid)] < 3)
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not set racemode 2 with only 2 CPs");
				Bracemode[b(playerid)] = 1;
			}
			format(ystring,sizeof(ystring),"Mode: %s",ReturnModeName(Bracemode[b(playerid)]));
			RefreshMenuHeader(playerid,MRacemode,ystring);
			return 1;
		}
		else
		{
		    Racemode = row;
			if(Racemode == 2 && LCurrentCheckpoint < 2)
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) You can not set racemode 2 with only 2 CPs");
				Racemode = 1;
			}
			format(ystring,sizeof(ystring),"Mode: %s",ReturnModeName(Racemode));
			RefreshMenuHeader(playerid,MRacemode,ystring);
			return 1;
		}
	}
	else if(Current == MRace)
	{
	    if(row == 0)
		{
			format(ystring,sizeof(ystring),"Laps: %d",Racelaps);
			SetMenuColumnHeader(MLaps,0,ystring);
			ShowMenuForPlayer(MLaps,playerid);
		}
	    else if(row == 1)
		{
			format(ystring,sizeof(ystring),"Mode: %s",ReturnModeName(Racemode));
			SetMenuColumnHeader(MRacemode,0,ystring);
            ShowMenuForPlayer(MRacemode,playerid);
		}
		else if(row == 2)
		{
		    format(ystring,sizeof(ystring),"Size: %0.2f",CPsize);
		    SetMenuColumnHeader(MCPsize,0,ystring);
		    ShowMenuForPlayer(MCPsize,playerid);
		}
	    else if(row == 3)
	    {
	        if(Airrace == 0)
			{
				Airrace = 1;
				format(ystring,sizeof(ystring),"Air race: On");
			}
			else if(Airrace == 1)
			{
				Airrace = 0;
				format(ystring,sizeof(ystring),"Air race: Off");
			}
			RefreshMenuHeader(playerid,MRace,ystring);
	    }
		else if(row == 4)
		{
			if(RaceActive == 0)
			{
				startrace();
		        HideMenuForPlayer(MRace,playerid);
				TogglePlayerControllable(playerid,1);
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "(ERROR) Race is already active");

			}
		}
		else if(row == 5)
		{
	        HideMenuForPlayer(MRace,playerid);
			TogglePlayerControllable(playerid,1);
		}
	}
	else if(Current == MFee)
	{
	    if(row == 6)
	    {
	        ShowMenuForPlayer(MAdmin,playerid);
	        return 1;
	    }
	    if(row == 0) JoinFee +=100;
	    if(row == 1) JoinFee +=1000;
	    if(row == 2) JoinFee +=10000;
	    if(row == 3) JoinFee -=100;
	    if(row == 4) JoinFee -=1000;
	    if(row == 5) JoinFee -=10000;
	    if(JoinFee < 0) JoinFee = 0;
		format(ystring,sizeof(ystring),"Fee: %d$",JoinFee);
	    RefreshMenuHeader(playerid,MFee,ystring);
	}
	else if(Current == MCPsize)
	{
	    if(row == 6)
	    {
			if(RaceBuilders[playerid] != 0) ShowMenuForPlayer(MBuild,playerid);
			else ShowMenuForPlayer(MRace,playerid);
	        return 1;
	    }
		new Float:change;
	    if(row == 0) change +=0.1;
	    if(row == 1) change +=1.0;
	    if(row == 2) change +=10.0;
		if(row == 3) change -=0.1;
		if(row == 4) change -=1.0;
		if(row == 5) change -=10.0;
		if(RaceBuilders[playerid] != 0)
		{
		    BCPsize[b(playerid)] += change;
			if(BCPsize[b(playerid)] < 1.0) BCPsize[b(playerid)] = 1.0;
			if(BCPsize[b(playerid)] > 32.0) BCPsize[b(playerid)] = 32.0;
			format(ystring,sizeof(ystring),"Size %0.2f",BCPsize[b(playerid)]);
			RefreshMenuHeader(playerid,MCPsize,ystring);
		}
		else
		{
		    CPsize += change;
		    if(CPsize < 1.0) CPsize = 1.0;
		    if(CPsize > 32.0) CPsize = 32.0;
		    format(ystring,sizeof(ystring),"Size %0.2f",CPsize);
		    RefreshMenuHeader(playerid,MCPsize,ystring);
		}
	}
	else if(Current == MDelay)
	{
	    if(row == 4)
	    {
	        ShowMenuForPlayer(MAdmin,playerid);
	        return 1;
	    }
		if      (row == 0) MajorityDelay+=10;
		else if (row == 1) MajorityDelay+=60;
		else if (row == 2) MajorityDelay-=10;
		else if (row == 3) MajorityDelay-=60;
		if(MajorityDelay <= 0)
		{
			MajorityDelay=0;
			format(ystring,sizeof(ystring),"Delay: disabled");
		}
		else format(ystring,sizeof(ystring),"Delay: %ds",MajorityDelay);
		RefreshMenuHeader(playerid,MDelay,ystring);
	}
	for(new menu; menu<TotalMenus; menu++)
	{
		if(Current == CCTVMenu[menu])
		{
		    if(MenuType[PlayerMenu[playerid]] == 1)
		    {
		        if(row == 11)
		        {
		            ShowMenuForPlayer(CCTVMenu[menu+1], playerid);
		            TogglePlayerControllable(playerid, 0);
		            PlayerMenu[playerid] = (menu+1);
				}
				else
				{
				    if(PlayerMenu[playerid] == 0)
				    {
				    	SetPlayerToCCTVCamera(playerid, row);
				    	PlayerMenu[playerid] = -1;
					}
					else
					{
					    SetPlayerToCCTVCamera(playerid, ((PlayerMenu[playerid]*11)+row));
					    PlayerMenu[playerid] = -1;
					}
				}
			}
			else
			{
			    if(PlayerMenu[playerid] == 0)
			    {
			    	SetPlayerToCCTVCamera(playerid, row);
			    	PlayerMenu[playerid] = -1;
				}
				else
				{
				    SetPlayerToCCTVCamera(playerid, ((PlayerMenu[playerid]*11)+row));
				    PlayerMenu[playerid] = -1;
				}
			}
		}
	}
	return 1;
}
//==============================================================================
public OnGameModeExit()
{
	TextDrawHideForAll(TD);
	TextDrawDestroy(TD);
	DestroyMenu(MAdmin);
	DestroyMenu(MPMode);
	DestroyMenu(MPrize);
	DestroyMenu(MDyna);
	DestroyMenu(MBuild);
	DestroyMenu(MLaps);
	DestroyMenu(MRace);
	DestroyMenu(MRacemode);
	DestroyMenu(MFee);
	DestroyMenu(MCPsize);
	DestroyMenu(MDelay);
	for(new i; i<TotalMenus; i++)
	{
		DestroyMenu(CCTVMenu[i]);
	}
}
//==============================================================================
public OnPlayerDataSave(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(gPlayerLogged[playerid])
		{
			new string3[128];
			format(string3, sizeof(string3), "New York Roleplay/Accounts/%s.ini", PlayerName(playerid));
			new File: hFile = fopen(string3, io_write);
			if (hFile)
			{
				new var[32];
				PlayerInfo[playerid][pCash] = GetPlayerCash(playerid);
				PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
				PlayerInfo[playerid][pCards] = 0;
				PlayerInfo[playerid][pCard1] = 0;
				PlayerInfo[playerid][pCard2] = 0;
				PlayerInfo[playerid][pDealer] = 0;
				PlayerInfo[playerid][pFlop1] = 0;
				PlayerInfo[playerid][pFlop2] = 0;
				PlayerInfo[playerid][pFlop3] = 0;
				PlayerInfo[playerid][pRiver] = 0;
				PlayerInfo[playerid][pTurn] = 0;
				format(var, 32, "Key=%s\n", PlayerInfo[playerid][pKey]);fwrite(hFile, var);
				format(var, 32, "Level=%d\n",PlayerInfo[playerid][pLevel]);fwrite(hFile, var);
				format(var, 32, "AdminLevel=%d\n",PlayerInfo[playerid][pAdmin]);fwrite(hFile, var);
				format(var, 32, "DonateRank=%d\n",PlayerInfo[playerid][pDonateRank]);fwrite(hFile, var);
				format(var, 32, "Registered=%d\n",PlayerInfo[playerid][pRegistered]);fwrite(hFile, var);
				format(var, 32, "Tutorial=%d\n",PlayerInfo[playerid][pTut]);fwrite(hFile, var);
				format(var, 32, "Sex=%d\n",PlayerInfo[playerid][pSex]);fwrite(hFile, var);
				format(var, 32, "Age=%d\n",PlayerInfo[playerid][pAge]);fwrite(hFile, var);
				format(var, 32, "Experience=%d\n",PlayerInfo[playerid][pExp]);fwrite(hFile, var);
				format(var, 32, "Money=%d\n",PlayerInfo[playerid][pCash]);fwrite(hFile, var);
				format(var, 32, "Gun1=%d\n",PlayerInfo[playerid][pGun1]);fwrite(hFile, var);
				format(var, 32, "Gun2=%d\n",PlayerInfo[playerid][pGun2]);fwrite(hFile, var);
				format(var, 32, "Gun3=%d\n",PlayerInfo[playerid][pGun3]);fwrite(hFile, var);
				format(var, 32, "Gun4=%d\n",PlayerInfo[playerid][pGun4]);fwrite(hFile, var);
   				format(var, 32, "Ammo1=%d\n",PlayerInfo[playerid][pAmmo1]);fwrite(hFile, var);
				format(var, 32, "Ammo2=%d\n",PlayerInfo[playerid][pAmmo2]);fwrite(hFile, var);
				format(var, 32, "Ammo3=%d\n",PlayerInfo[playerid][pAmmo3]);fwrite(hFile, var);
				format(var, 32, "Ammo4=%d\n",PlayerInfo[playerid][pAmmo4]);fwrite(hFile, var);
				format(var, 32, "Bank=%d\n",PlayerInfo[playerid][pBank]);fwrite(hFile, var);
				format(var, 32, "DeathFreeze=%d\n",PlayerInfo[playerid][pDeathFreeze]);fwrite(hFile, var);
				format(var, 32, "Flop1=%d\n",PlayerInfo[playerid][pFlop1]);fwrite(hFile, var);
				format(var, 32, "Flop2=%d\n",PlayerInfo[playerid][pFlop2]);fwrite(hFile, var);
				format(var, 32, "Flop3=%d\n",PlayerInfo[playerid][pFlop3]);fwrite(hFile, var);
				format(var, 32, "River=%d\n",PlayerInfo[playerid][pRiver]);fwrite(hFile, var);
				format(var, 32, "Turn=%d\n",PlayerInfo[playerid][pTurn]);fwrite(hFile, var);
				format(var, 32, "Dealer=%d\n",PlayerInfo[playerid][pDealer]);fwrite(hFile, var);
				format(var, 32, "Cards=%d\n",PlayerInfo[playerid][pCards]);fwrite(hFile, var);
				format(var, 32, "Card1=%d\n",PlayerInfo[playerid][pCard1]);fwrite(hFile, var);
				format(var, 32, "Card2=%d\n",PlayerInfo[playerid][pCard2]);fwrite(hFile, var);
				format(var, 32, "Skin=%d\n",PlayerInfo[playerid][pSkin]);fwrite(hFile, var);
				format(var, 32, "Drugs=%d\n",PlayerInfo[playerid][pDrugs]);fwrite(hFile, var);
				format(var, 32, "Materials=%d\n",PlayerInfo[playerid][pMaterials]);fwrite(hFile, var);
				format(var, 32, "Products=%d\n",PlayerInfo[playerid][pProducts]);fwrite(hFile, var);
				format(var, 32, "Job=%d\n",PlayerInfo[playerid][pJob]);fwrite(hFile, var);
				format(var, 32, "ContractTime=%d\n",PlayerInfo[playerid][pContractTime]);fwrite(hFile, var);
				format(var, 32, "PlayingHours=%d\n",PlayerInfo[playerid][pPlayingHours]);fwrite(hFile, var);
				format(var, 32, "AllowedPayday=%d\n",PlayerInfo[playerid][pAllowedPayday]);fwrite(hFile, var);
				format(var, 32, "PayCheck=%d\n",PlayerInfo[playerid][pPayCheck]);fwrite(hFile, var);
				format(var, 32, "Faction=%d\n",PlayerInfo[playerid][pFaction]);fwrite(hFile, var);
				format(var, 32, "Rank=%d\n",PlayerInfo[playerid][pRank]);fwrite(hFile, var);
				format(var, 32, "HouseKey=%d\n",PlayerInfo[playerid][pHouseKey]);fwrite(hFile, var);
				format(var, 32, "BizKey=%d\n",PlayerInfo[playerid][pBizKey]);fwrite(hFile, var);
				format(var, 32, "SpawnPoint=%d\n",PlayerInfo[playerid][pSpawnPoint]);fwrite(hFile, var);
				format(var, 32, "Warnings=%d\n",PlayerInfo[playerid][pWarnings]);fwrite(hFile, var);
				format(var, 32, "CarLic=%d\n",PlayerInfo[playerid][pCarLic]);fwrite(hFile, var);
				format(var, 32, "FlyLic=%d\n",PlayerInfo[playerid][pFlyLic]);fwrite(hFile, var);
				format(var, 32, "WepLic=%d\n",PlayerInfo[playerid][pWepLic]);fwrite(hFile, var);
				format(var, 32, "VisitPass=%d\n",PlayerInfo[playerid][pVisitPass]);fwrite(hFile, var);
				format(var, 32, "PhoneNumber=%d\n",PlayerInfo[playerid][pPhoneNumber]);fwrite(hFile, var);
				format(var, 32, "PhoneC=%d\n",PlayerInfo[playerid][pPhoneC]);fwrite(hFile, var);
				format(var, 32, "PhoneBook=%d\n",PlayerInfo[playerid][pPhoneBook]);fwrite(hFile, var);
				format(var, 32, "LottoNr=%d\n",PlayerInfo[playerid][pLottoNr]);fwrite(hFile, var);
				format(var, 32, "ListNumber=%d\n",PlayerInfo[playerid][pListNumber]);fwrite(hFile, var);
				format(var, 32, "Donator=%d\n",PlayerInfo[playerid][pDonator]);fwrite(hFile, var);
				format(var, 32, "Jailed=%d\n",PlayerInfo[playerid][pJailed]);fwrite(hFile, var);
				format(var, 32, "JailTime=%d\n",PlayerInfo[playerid][pJailTime]);fwrite(hFile, var);
				format(var, 32, "Hospital=%d\n",PlayerInfo[playerid][pHospital]);fwrite(hFile, var);
 				format(var, 32, "Note1=%s\n",PlayerInfo[playerid][pNote1]);fwrite(hFile, var);
				format(var, 32, "Note1s=%d\n",PlayerInfo[playerid][pNote1s]);fwrite(hFile, var);
				format(var, 32, "Note2=%s\n",PlayerInfo[playerid][pNote2]);fwrite(hFile, var);
				format(var, 32, "Note2s=%d\n",PlayerInfo[playerid][pNote2s]);fwrite(hFile, var);
				format(var, 32, "Note3=%s\n",PlayerInfo[playerid][pNote3]);fwrite(hFile, var);
				format(var, 32, "Note3s=%d\n",PlayerInfo[playerid][pNote3s]);fwrite(hFile, var);
				format(var, 32, "Note4=%s\n",PlayerInfo[playerid][pNote4]);fwrite(hFile, var);
				format(var, 32, "Note4s=%d\n",PlayerInfo[playerid][pNote4s]);fwrite(hFile, var);
				format(var, 32, "Note5=%s\n",PlayerInfo[playerid][pNote5]);fwrite(hFile, var);
				format(var, 32, "Note5s=%d\n",PlayerInfo[playerid][pNote5s]);fwrite(hFile, var);
				format(var, 32, "LoadPosX=%.1f\n",PlayerInfo[playerid][pLoadPosX]);fwrite(hFile, var);
				format(var, 32, "LoadPosY=%.1f\n",PlayerInfo[playerid][pLoadPosY]);fwrite(hFile, var);
				format(var, 32, "LoadPosZ=%.1f\n",PlayerInfo[playerid][pLoadPosZ]);fwrite(hFile, var);
				format(var, 32, "LoadPosInt=%d\n",PlayerInfo[playerid][pLoadPosInt]);fwrite(hFile, var);
				format(var, 32, "LoadPosW=%d\n",PlayerInfo[playerid][pLoadPosW]);fwrite(hFile, var);
				format(var, 32, "LoadPos=%d\n",PlayerInfo[playerid][pLoadPos]);fwrite(hFile, var);
				format(var, 32, "AccountLocked=%d\n",PlayerInfo[playerid][pLocked]);fwrite(hFile, var);
				fclose(hFile);
			}
		}
	}
	return 1;
}
//==============================================================================
public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
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

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
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
	if(dialogid == 12)
	{
	if(strlen(inputtext))
	{
        new accstring[128];
		format(accstring, sizeof(accstring), "New York Roleplay/Accounts/%s.ini", PlayerName(playerid));
		new File: hFile = fopen(accstring, io_read);
		if (hFile)
		{
			OnPlayerLogin(playerid,inputtext);
			fclose(hFile);
			return 0;
		}
	}
	}
	if(dialogid == 13)
	{
	if(strlen(inputtext))
	{
        new accstring[128];
		format(accstring, sizeof(accstring), "New York Roleplay/Accounts/%s.ini", PlayerName(playerid));
		new File: hFile = fopen(accstring, io_read);
		if (!hFile)
		{
			OnPlayerRegister(playerid,inputtext);
			OnPlayerLogin(playerid,inputtext);
			return 0;
		}
	}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
//==============================================================================
public ShowScriptStats(playerid)
{
	new form[128];
	format(form, sizeof form, "%s [%s] | Developed by %s | Script Lines: %d | Last Updated: %s", GAMEMODE,VERSION,DEVELOPER,SCRIPT_LINES,LAST_UPDATE);
	SendClientMessage(playerid, COLOR_WHITE,form);

 	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		format(form, sizeof form, "Website: %s | Map: %s | Server Password: %s | User Connections: %d", WEBSITE,MAP_NAME,ShowServerPassword(),JoinCounter);
		SendClientMessage(playerid, COLOR_WHITE,form);
	}
	else
	{
		format(form, sizeof form, "Website: %s | Map: %s | User Connections: %d",WEBSITE,MAP_NAME,JoinCounter);
		SendClientMessage(playerid, COLOR_WHITE,form);
	}
}

public Update()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(gPlayerLogged[i] == 1)
		    {
				if(PlayerInfo[i][pAllowedPayday] < 6)
				{
					PlayerInfo[i][pAllowedPayday] ++;
				}
			}
		}
	}
}

public SaveAccounts()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(gPlayerLogged[i])
		    {
				OnPlayerDataSave(i);
				if(PlayerInfo[i][pJob] > 0)
	    		{
	    	    	if(PlayerInfo[i][pContractTime] < 25)
	    	    	{
						PlayerInfo[i][pContractTime] ++;
					}
				}
			}
		}
	}
}

public UpdateData()
{
	UpdateScore();
	SyncTime();
	return 1;
}

public UpdateMoney()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(gPlayerLogged[i])
		    {
			 	if(GetPlayerCash(i) != GetPlayerMoney(i))
			 	{
 	 				new hack = GetPlayerMoney(i) - GetPlayerCash(i);
			  		if(hack >= 20000)
			  		{
					  	new string[128];
					    format(string, sizeof(string), "(WARNING) %s (ID:%d) tried to spawn $%d - This could be a money cheat",GetPlayerNameEx(i),i, hack);
					    HackLog(string);
			  		}
			 		ResetMoneyBar(i);
					UpdateMoneyBar(i,PlayerInfo[i][pCash]);
				}
			}
		}
	}
	return 1;
}

public UpdateScore()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			SetPlayerScore(i, PlayerInfo[i][pLevel]);
		}
	}
	return 1;
}

public SyncTime()
{
	new tmphour;
	new tmpminute;
	new tmpsecond;
	gettime(tmphour, tmpminute, tmpsecond);
	FixHour(tmphour);
	tmphour = shifthour;
	if ((tmphour > ghour) || (tmphour == 0 && ghour == 23))
	{
		ghour = tmphour;
		PayDay();
		if (realtime)
		{
			SetWorldTime(tmphour);
		}
	}
}

public FixHour(hour)
{
	hour = timeshift+hour;
	if (hour < 0)
	{
		hour = hour+24;
	}
	else if (hour > 23)
	{
		hour = hour-24;
	}
	shifthour = hour;
	return 1;
}
//==============================================================================
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
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

public GetClosestPlayer(p1)
{
	new x,Float:dis,Float:dis2,player;
	player = -1;
	dis = 99999.99;
	for (x=0;x<MAX_PLAYERS;x++)
	{
		if(IsPlayerConnected(x))
		{
			if(x != p1)
			{
				dis2 = GetDistanceBetweenPlayers(x,p1);
				if(dis2 < dis && dis2 != -1.00)
				{
					dis = dis2;
					player = x;
				}
			}
		}
	}
	return player;
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
					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
					    if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
					    {
							SendClientMessage(i, col1, string);
						}
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
                        if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
                        {
							SendClientMessage(i, col2, string);
						}
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
					    if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
					    {
							SendClientMessage(i, col3, string);
						}
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
					    if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
					    {
							SendClientMessage(i, col4, string);
						}
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
                        if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
                        {
							SendClientMessage(i, col5, string);
						}
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

public ProxDetectorS(Float:radi, playerid, targetid)
{
    if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		GetPlayerPos(targetid, posx, posy, posz);
		tempposx = (oldposx -posx);
		tempposy = (oldposy -posy);
		tempposz = (oldposz -posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
		    if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid))
		    {
				return 1;
			}
		}
	}
	return 0;
}
//==============================================================================
public ResetPlayerWantedLevelEx(playerid)
{
  	SetPlayerWantedLevel(playerid, 0);
	WantedLevel[playerid] = 0;
	return 1;
}

public SetPlayerWantedLevelEx(playerid,level)
{
  	SetPlayerWantedLevel(playerid, level);
	WantedLevel[playerid] = level;
	return 1;
}

public GetPlayerWantedLevelEx(playerid)
{
	return WantedLevel[playerid];
}

public SafeGivePlayerWeapon(playerid, weaponid, ammo)
{
	GivePlayerWeapon(playerid, weaponid, ammo);
	return 1;
}

public SafeResetPlayerWeapons(playerid)
{
	ResetPlayerWeapons(playerid);
	PlayerInfo[playerid][pGun1] = 0; PlayerInfo[playerid][pAmmo1] = 0;
 	PlayerInfo[playerid][pGun2] = 0; PlayerInfo[playerid][pAmmo2] = 0;
 	PlayerInfo[playerid][pGun3] = 0; PlayerInfo[playerid][pAmmo3] = 0;
 	PlayerInfo[playerid][pGun4] = 0; PlayerInfo[playerid][pAmmo4] = 0;
	return 1;
}
//==============================================================================
public ShowTut(playerid)
{
    if(TutorialStage[playerid] == 1)
    {
	   	ClearScreen(playerid);
		SendClientMessage(playerid, COLOR_RED, "<|> Introduction <|>");
		SendClientMessage(playerid, COLOR_WHITE, "Welcome to The Godfather");
		SendClientMessage(playerid, COLOR_WHITE, "Since you are new, you will need to take a quick tutorial.");
		SendClientMessage(playerid, COLOR_WHITE, "It will teach you the basics of roleplay if you don't know them already.");
		SendClientMessage(playerid, COLOR_WHITE, "To avoid getting kicked/banned, we recommend you pay attention.");
		SendClientMessage(playerid, COLOR_WHITE, "During your roleplay you will encounter alot of things.");
		SendClientMessage(playerid, COLOR_WHITE, "All the information here can be also found on the forums.");
		SendClientMessage(playerid, COLOR_YELLOW, "Each tutorial stage is 20 seconds long, so read fast.");
		SendClientMessage(playerid, COLOR_YELLOW, "Forums: http://forum.the-god-father.com");
		TutorialStage[playerid] = 2;
	}
	else if(TutorialStage[playerid] == 2)
	{
		ClearScreen(playerid);
		SendClientMessage(playerid, COLOR_RED, "<|> Naming your character <|>");
		SendClientMessage(playerid, COLOR_WHITE, "This server is a high-leveled STRICT roleplaying community.");
		SendClientMessage(playerid, COLOR_WHITE, "All players are required to use appropriate First_Last names.");
		SendClientMessage(playerid, COLOR_WHITE, "If we find you with a name like Bob_Underwear, you will get banned.");
		SendClientMessage(playerid, COLOR_WHITE, "An example of a good name is John_Smith, any other type will get punished.");
		SendClientMessage(playerid, COLOR_WHITE, "If you are clueless and don't know what name to pick, go to:");
		SendClientMessage(playerid, COLOR_WHITE, "www.behindthename.com It's a great way to find a good name.");
		TutorialStage[playerid] = 3;
	}
	else if(TutorialStage[playerid] == 3)
	{
	    ClearScreen(playerid);
		SendClientMessage(playerid, COLOR_RED, "<|> Requesting Help <|>");
		SendClientMessage(playerid, COLOR_WHITE, "You can ask help from anyone, they are all friendly.");
		SendClientMessage(playerid, COLOR_WHITE, "But there are also in-game admins that can help you with anything.");
		SendClientMessage(playerid, COLOR_WHITE, "You can contact these administrators by /pm, just check /admins to see");
		SendClientMessage(playerid, COLOR_WHITE, "which one is on duty and which one isn't.");
		SendClientMessage(playerid, COLOR_WHITE, "Contacting an off-duty admin can result in a kick.");
		TutorialStage[playerid] = 4;
	}
	else if(TutorialStage[playerid] == 4)
	{
	    ClearScreen(playerid);
		SendClientMessage(playerid, COLOR_RED, "<|> Cheating & Abusing <|>");
		SendClientMessage(playerid, COLOR_WHITE, "Using in-game hacks or cheats is extremely bannable.");
		SendClientMessage(playerid, COLOR_WHITE, "Abusing a bug that you found is even worse, and is IP-bannable.");
		SendClientMessage(playerid, COLOR_WHITE, "If you see/heard about someone who is cheating/hacking/abusing, /report it.");
		SendClientMessage(playerid, COLOR_WHITE, "If we find out about it, and find out you knew and didn't tell us, you get banned too.");
		TutorialStage[playerid] = 5;
	}
	else if(TutorialStage[playerid] == 5)
	{
	    ClearScreen(playerid);
		SendClientMessage(playerid, COLOR_RED, "<|> Respect <|>");
		SendClientMessage(playerid, COLOR_WHITE, "Administrators are hard workers, and run the server, treat them with respect.");
		SendClientMessage(playerid, COLOR_WHITE, "Shouting/cursing/spamming other users will get you muted but most of the time banned.");
		SendClientMessage(playerid, COLOR_WHITE, "Any form of spam will get you in admin jail for a MINIMUM of 40 minutes.");
		SendClientMessage(playerid, COLOR_WHITE, "Even worse would be to spam /report which will get you an automatic IP-ban.");
		SendClientMessage(playerid, COLOR_WHITE, "If an admin doesn't respond it means they are busy. Don't spam their /pm.");
		TutorialStage[playerid] = 6;
	}
	else if(TutorialStage[playerid] == 6)
	{
	    ClearScreen(playerid);
		SendClientMessage(playerid, COLOR_RED, "<|> Language & Advertising <|>");
		SendClientMessage(playerid, COLOR_WHITE, "English is the language of the server, use it in EVERY *IC* chat.");
		SendClientMessage(playerid, COLOR_WHITE, "You can use other languages in *OOC* chat such as: /b /o /pm. No where else!");
		SendClientMessage(playerid, COLOR_WHITE, "Advertising another server is STRICTLY forbidden and will get you IP-banned.");
		SendClientMessage(playerid, COLOR_WHITE, "Follow this to avoid administrator intervention.");
	   	TutorialStage[playerid] = 7;
	}
	else if(TutorialStage[playerid] == 7)
	{
	    ClearScreen(playerid);
	   	SendClientMessage(playerid, COLOR_RED, "<|> Death Matching <|>");
		SendClientMessage(playerid, COLOR_WHITE, "First, Death matching means killing someone without a roleplay reason.");
		SendClientMessage(playerid, COLOR_WHITE, "A reason like 'My character is mad, hotheaded' or any of the sort is not valable.");
		SendClientMessage(playerid, COLOR_WHITE, "If you suffer any form of DM'ing, take a picture of it and post on the forums.");
		SendClientMessage(playerid, COLOR_WHITE, "Any player caught DM'ing will get banned, and his reporter will get $50,000 IC.");
		TutorialStage[playerid] = 8;
	}
	else if(TutorialStage[playerid] == 8)
	{
	    ClearScreen(playerid);
	   	SendClientMessage(playerid, COLOR_RED, "<|> Sexual Harrassment <|>");
		SendClientMessage(playerid, COLOR_WHITE, "Sexual harrassment/raping is only allowed in one way:");
		SendClientMessage(playerid, COLOR_WHITE, "If there is an OOC agreement from both people involved.");
		SendClientMessage(playerid, COLOR_WHITE, "Any other form of sexual harrassment is IP-bannable.");
		SendClientMessage(playerid, COLOR_WHITE, "Follow this to avoid administrator intervention.");
		TutorialStage[playerid] = 9;
	}
	else if(TutorialStage[playerid] == 9)
	{
	    ClearScreen(playerid);
	   	SendClientMessage(playerid, COLOR_RED, "<|> Basic IC/OOC Information <|>");
		SendClientMessage(playerid, COLOR_WHITE, "IC: In Character OOC: Out of Character");
		SendClientMessage(playerid, COLOR_WHITE, "Talking without anything in the beginning is IN CHARACTER.");
		SendClientMessage(playerid, COLOR_WHITE, "Talking with either: /b /o or /pm at the beginnig is OUT OF CHARACTER.");
		SendClientMessage(playerid, COLOR_WHITE, "Any text wrapped with (( )) is OUT OF CHARACTER.");
		SendClientMessage(playerid, COLOR_WHITE, "If you speak OUT OF CHARACTER without any /b or /o or /pm you will get muted/kicked.");
		TutorialStage[playerid] = 10;
	}
	else if(TutorialStage[playerid] == 10)
	{
	    ClearScreen(playerid);
	   	SendClientMessage(playerid, COLOR_RED, "<|> Metagaming & Powergaming <|>");
		SendClientMessage(playerid, COLOR_WHITE, "Meta gaming: Using out of character information in character.");
		SendClientMessage(playerid, COLOR_WHITE, "Example: John tells Joe on MSN that Andrew is going to kill him. Joe goes and kills Andrew.");
		SendClientMessage(playerid, COLOR_WHITE, "He just meta-gamed. He used the info that John told him on MSN, on our game.");
		SendClientMessage(playerid, COLOR_WHITE, "Power gaming: Roleplaying unrealisticly.");
		SendClientMessage(playerid, COLOR_WHITE, "Example: Having super powers, using objects you don't have, not letting your opponent roleplay.");
		SendClientMessage(playerid, COLOR_WHITE, "For that last example it's for example /me knocks John out.");
		SendClientMessage(playerid, COLOR_WHITE, "If you do any of these, you will get banned.");
		TutorialStage[playerid] = 11;
	}
	else if(TutorialStage[playerid] == 11)
	{
	    ClearScreen(playerid);
		SendClientMessage(playerid, COLOR_RED, "<|> The End <|>");
		SendClientMessage(playerid, COLOR_WHITE, "Don't forget to register on the forums!");
		SendClientMessage(playerid, COLOR_YELLOW, "Forums: www.the-god-father.com");
 		SendClientMessage(playerid, COLOR_WHITE, "Have fun roleplaying, we hope to see you around New York!");
		SendClientMessage(playerid, COLOR_WHITE, "Regards,");
		SendClientMessage(playerid, COLOR_WHITE, "Julien209 and the GF staff team.");
		TogglePlayerControllable(playerid, 1);
		PlayerInfo[playerid][pTut] = 1;
		TutorialStage[playerid] = 0;
		KillTimer(TutTimer);
		SetCameraBehindPlayer(playerid);
	}
}
//==============================================================================
public SendFactionMessage(faction, color, string[])
{
for(new i = 0; i < MAX_PLAYERS; i++)
{
	if(IsPlayerConnected(i))
		{
			if(PlayerInfo[i][pFaction] != 255)
		    {
			 	if(PlayerInfo[i][pFaction] == faction)
			  	{
 	 				SendClientMessage(i, color, string);
				}
			}
		}
	}
}

public SendFactionTypeMessage(factiontype, color, string[])
{
for(new i = 0; i < MAX_PLAYERS; i++)
{
	if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pFaction] != 255)
		    {
			 	if(DynamicFactions[PlayerInfo[i][pFaction]][fType] == factiontype)
			  	{
				 	if(DynamicFactions[PlayerInfo[i][pFaction]][fType] == 1)
			  	    {
			  	        if(CopOnDuty[i])
			  	        {
			  	            SendClientMessage(i, color, string);
			  	        }
			  	    }
			  	    else
			  	    {
						SendClientMessage(i, color, string);
					}
				}
			}
		}
	}
}

public AdministratorMessage(color,const string[],level)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (PlayerInfo[i][pAdmin] >= level)
			{
				SendClientMessage(i, color, string);
			}
		}
	}
	return 1;
}

public OOCNews(color,const string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			SendClientMessage(i, color, string);
		}
	}
}

public PlayerLocalMessage(playerid,Float:radius,message[])
{
	new string[128];
	format(string, sizeof(string), "(LOCAL) %s %s", GetPlayerNameEx(playerid), message);
	ProxDetector(20.0, playerid, string, COLOR_LOCALMSG,COLOR_LOCALMSG,COLOR_LOCALMSG,COLOR_LOCALMSG,COLOR_LOCALMSG);
	PlayerLocalLog(string);
	return 1;
}

public PlayerActionMessage(playerid,Float:radius,message[])
{
	new string[128];
	format(string, sizeof(string), "* %s %s", GetPlayerNameEx(playerid), message);
	ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	PlayerActionLog(string);
	return 1;
}
public PlayerDoMessage(playerid,Float:radius,message[])
{
	new string[128];
	format(string, sizeof(string), "* %s ((%s))", message, GetPlayerNameEx(playerid));
	ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	PlayerActionLog(string);
	return 1;
}
public PlayerPlayerActionMessage(playerid,targetid,Float:radius,message[])
{
	new string[128];
	format(string, sizeof(string), "%s %s %s", GetPlayerNameEx(playerid), message,GetPlayerNameEx(targetid));
	ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	PlayerActionLog(string);
	return 1;
}
//==============================================================================
public SetPlayerToFactionSkin(playerid)
{
  		new faction = PlayerInfo[playerid][pFaction];
		new rank = PlayerInfo[playerid][pRank];
		new rankamount = DynamicFactions[faction][fRankAmount];
		if(faction != 255)
		{
			if(DynamicFactions[faction][fUseSkins])
			{
				if(rank == 1 && rankamount >= 1)
				{
	   				if(DynamicFactions[faction][fType] == 1)
	    		    {
	    		        if(CopOnDuty[playerid])
	    		        {
	    		            SetPlayerSkin(playerid,DynamicFactions[faction][fSkin1]);
	    		        }
					}
					else
					{
						SetPlayerSkin(playerid,DynamicFactions[faction][fSkin1]);
					}
				}
				else if(rank == 2 && rankamount >= 2)
				{
	    			if(DynamicFactions[faction][fType] == 1)
	    		    {
	    		        if(CopOnDuty[playerid])
	    		        {
	    		            SetPlayerSkin(playerid,DynamicFactions[faction][fSkin2]);
	    		        }
					}
					else
					{
						SetPlayerSkin(playerid,DynamicFactions[faction][fSkin2]);
					}
				}
				else if(rank == 3 && rankamount >= 3)
				{
	    			if(DynamicFactions[faction][fType] == 1)
	    		    {
	    		        if(CopOnDuty[playerid])
	    		        {
	    		            SetPlayerSkin(playerid,DynamicFactions[faction][fSkin3]);
	    		        }
					}
					else
					{
						SetPlayerSkin(playerid,DynamicFactions[faction][fSkin3]);
					}
				}
				else if(rank == 4 && rankamount >= 4)
				{
					if(DynamicFactions[faction][fType] == 1)
	    		    {
	    		        if(CopOnDuty[playerid])
	    		        {
	    		            SetPlayerSkin(playerid,DynamicFactions[faction][fSkin4]);
	    		        }
					}
					else
					{
						SetPlayerSkin(playerid,DynamicFactions[faction][fSkin4]);
					}
				}
				else if(rank == 5 && rankamount >= 5)
				{
					if(DynamicFactions[faction][fType] == 1)
	    		    {
	    		        if(CopOnDuty[playerid])
	    		        {
	    		            SetPlayerSkin(playerid,DynamicFactions[faction][fSkin5]);
	    		        }
					}
					else
					{
						SetPlayerSkin(playerid,DynamicFactions[faction][fSkin5]);
					}
				}
				else if(rank == 6 && rankamount >= 6)
				{
					if(DynamicFactions[faction][fType] == 1)
	    		    {
	    		        if(CopOnDuty[playerid])
	    		        {
	    		            SetPlayerSkin(playerid,DynamicFactions[faction][fSkin6]);
	    		        }
					}
					else
					{
						SetPlayerSkin(playerid,DynamicFactions[faction][fSkin6]);
					}
				}
				else if(rank == 7 && rankamount >= 7)
				{
					if(DynamicFactions[faction][fType] == 1)
	    		    {
	    		        if(CopOnDuty[playerid])
	    		        {
	    		            SetPlayerSkin(playerid,DynamicFactions[faction][fSkin7]);
	    		        }
					}
					else
					{
						SetPlayerSkin(playerid,DynamicFactions[faction][fSkin7]);
					}
				}
				else if(rank == 8 && rankamount >= 8)
				{
					if(DynamicFactions[faction][fType] == 1)
	    		    {
	    		        if(CopOnDuty[playerid])
	    		        {
	    		            SetPlayerSkin(playerid,DynamicFactions[faction][fSkin8]);
	    		        }
					}
					else
					{
						SetPlayerSkin(playerid,DynamicFactions[faction][fSkin8]);
					}
				}
				else if(rank == 9 && rankamount >= 9)
				{
					if(DynamicFactions[faction][fType] == 1)
	    		    {
	    		        if(CopOnDuty[playerid])
	    		        {
	    		            SetPlayerSkin(playerid,DynamicFactions[faction][fSkin9]);
	    		        }
					}
					else
					{
						SetPlayerSkin(playerid,DynamicFactions[faction][fSkin9]);
					}
				}
				else if(rank == 10 && rankamount >= 10)
				{
					if(DynamicFactions[faction][fType] == 1)
	    		    {
	    		        if(CopOnDuty[playerid])
	    		        {
	    		            SetPlayerSkin(playerid,DynamicFactions[faction][fSkin10]);
	    		        }
					}
					else
					{
						SetPlayerSkin(playerid,DynamicFactions[faction][fSkin10]);
					}
				}
			}
		}
		return 1;
}

public SetPlayerToFactionColor(playerid)
{
	if(PlayerInfo[playerid][pFaction] != 255)
	{
		if(DynamicFactions[PlayerInfo[playerid][pFaction]][fUseColor])
		{
		    if(DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
		    {
      			if(CopOnDuty[playerid] == 1)
	        	{
	        	    SetPlayerColor(playerid,HexToInt(DynamicFactions[PlayerInfo[playerid][pFaction]][fColor]));
   		        }
   		        else
   		        {
	            	SetPlayerColor(playerid,COLOR_CIVILIAN);
   		        }
			}
			else
			{
				SetPlayerColor(playerid,HexToInt(DynamicFactions[PlayerInfo[playerid][pFaction]][fColor]));
			}
		}
	}
	return 0;
}
//==============================================================================
public IsACopSkin(skinid)
{
	if(skinid == 266 || skinid == 281 || skinid == 285 || skinid == 280 || skinid == 288 || skinid == 282 || skinid == 283 || skinid == 284 || skinid == 71)
	{
		return 1;
	}
	return 0;
}

public IsAGovSkin(skinid)
{
	if(skinid == 147 || skinid == 295 || skinid == 287 || skinid == 165 || skinid == 286 || skinid == 240)
	{
		return 1;
	}
	return 0;
}

public IsANewsSkin(skinid)
{
	if(skinid == 290 || skinid == 188 || skinid == 217)
	{
		return 1;
	}
	return 0;
}

public IsAMafiaSkin(skinid)
{
	if(skinid == 111 || skinid == 112 || skinid == 59 || skinid == 124 || skinid == 126 || skinid == 127)
	{
		return 1;
	}
	return 0;
}

public IsATransportSkin(skinid)
{
	if(skinid == 171 || skinid == 186 || skinid == 61 || skinid == 255 || skinid == 189)
	{
		return 1;
	}
	return 0;
}

public IsABallaSkin(skinid)
{
	if(skinid == 104 || skinid == 102 || skinid == 103 || skinid == 28 || skinid == 21 || skinid == 297)
	{
		return 1;
	}
	return 0;
}

public IsAGroveSkin(skinid)
{
	if(skinid == 270 || skinid == 269 || skinid == 271 || skinid == 107 || skinid == 105 || skinid == 293)
	{
		return 1;
	}
	return 0;
}

public IsAAztecaSkin(skinid)
{
	if(skinid == 115 || skinid == 116 || skinid == 114 || skinid == 174 || skinid == 175 || skinid == 173)
	{
		return 1;
	}
	return 0;
}

public IsABikerSkin(skinid)
{
	if(skinid == 181 || skinid == 248 || skinid == 247 || skinid == 73)
	{
		return 1;
	}
	return 0;
}

public IsATriadSkin(skinid)
{
	if(skinid == 294 || skinid == 123 || skinid == 118 || skinid == 117)
	{
		return 1;
	}
	return 0;
}
//==============================================================================
public ShowStats(playerid,targetid)
{
    if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid))
	{
		if(gPlayerLogged[targetid])
		{
			SendClientMessage(playerid,COLOR_RED,"<|> Stats <|>");

			new wstring[128];
			new level = PlayerInfo[targetid][pLevel];
			new exp = PlayerInfo[targetid][pExp];
			new nxtlevel = PlayerInfo[targetid][pLevel]+1;
			new expamount = nxtlevel*levelexp;
			new drugs = PlayerInfo[targetid][pDrugs];
			new mats = PlayerInfo[targetid][pMaterials];
			new housekey = PlayerInfo[targetid][pHouseKey];
			new bizkey = PlayerInfo[targetid][pBizKey];
		    new playinghours = PlayerInfo[targetid][pPlayingHours];
		    new bank = PlayerInfo[targetid][pBank];
		   	new lotto = PlayerInfo[targetid][pLottoNr];
		    new warnings = PlayerInfo[targetid][pWarnings];
		    new Float:hp;
			GetPlayerHealth(targetid,hp);
 			new age = PlayerInfo[targetid][pAge];
 			new products = PlayerInfo[targetid][pProducts];
 			new donatortext[128];
 			new phonenumbertext[128];
			new location[MAX_ZONE_NAME];
			GetPlayer2DZone(playerid, location, MAX_ZONE_NAME);
			new phonenetwork[128];
			new jobtext[128];
			new weplicense[128];
			new flylicense[128];
			new carlicense[128];
			new ranktext[256];

			switch(PlayerInfo[targetid][pJob])
			{
			    case 0: jobtext = "None";
			    case 1: jobtext = "Arms Dealer";
			    case 2: jobtext = "Drug Dealer";
			    case 3: jobtext = "Detective";
			    case 4: jobtext = "Lawyer";
			    case 5: jobtext = "Products Seller";
			    case 6: jobtext = "Mechanic";
			}
			switch(PlayerInfo[targetid][pDonator])
			{
			    case 0: donatortext = "No";
			    case 1: donatortext = "Yes";
			}
			switch(PlayerInfo[targetid][pCarLic])
			{
			    case 0: carlicense = "No";
			    case 1: carlicense = "Yes";
			}
			switch(PlayerInfo[targetid][pFlyLic])
			{
			    case 0: flylicense = "No";
			    case 1: flylicense = "Yes";
			}
			switch(PlayerInfo[targetid][pWepLic])
			{
			    case 0: weplicense = "No";
			    case 1: weplicense = "Yes";
			}

			if(PlayerInfo[targetid][pPhoneC] == 255) { phonenetwork = "None"; } else { format(phonenetwork, sizeof(phonenetwork), "%s",Businesses[PlayerInfo[targetid][pPhoneC]][BusinessName]); }
			if(PlayerInfo[targetid][pPhoneNumber] == 0) { phonenumbertext = "None"; } else { format(phonenumbertext, sizeof(phonenumbertext), "%d",PlayerInfo[targetid][pPhoneNumber]); }
   			format(wstring, sizeof(wstring), "Name: %s - Age: %d - Health: %.1f - Level: %d - Experience: %d/%d - Playing Hours: %d",GetPlayerNameEx(targetid),age,hp,level,exp,expamount,playinghours);
		    SendClientMessage(playerid,COLOR_WHITE, wstring);
   			format(wstring, sizeof(wstring), "Cash: $%d - Bank: $%d - Job: %s - LottoNr: %d - Location: %s",GetPlayerCash(targetid),bank,jobtext,lotto,location);
		    SendClientMessage(playerid,COLOR_WHITE, wstring);
   			format(wstring, sizeof(wstring), "House Key: %d - Business Key: %d - Phone Number: %s - Phone Network: %s",housekey,bizkey,phonenumbertext,phonenetwork);
		    SendClientMessage(playerid,COLOR_WHITE, wstring);
   			format(wstring, sizeof(wstring), "Donator: %s - Warnings: %d - Products: %d - Materials: %d - Drugs: %d",donatortext,warnings,products,mats,drugs);
		    SendClientMessage(playerid,COLOR_WHITE, wstring);
   			format(wstring, sizeof(wstring), "Driving License: %s - Flying License: %s - Weapon License: %s",carlicense,flylicense,weplicense);
		    SendClientMessage(playerid,COLOR_WHITE, wstring);

		    if(PlayerInfo[targetid][pFaction] != 255)
			{
	      		switch(PlayerInfo[targetid][pRank])
			    {
			        case 1: format(ranktext, sizeof(ranktext), "%s", DynamicFactions[PlayerInfo[targetid][pFaction]][fRank1]);
			        case 2: format(ranktext, sizeof(ranktext), "%s", DynamicFactions[PlayerInfo[targetid][pFaction]][fRank2]);
			        case 3: format(ranktext, sizeof(ranktext), "%s", DynamicFactions[PlayerInfo[targetid][pFaction]][fRank3]);
			        case 4: format(ranktext, sizeof(ranktext), "%s", DynamicFactions[PlayerInfo[targetid][pFaction]][fRank4]);
			        case 5: format(ranktext, sizeof(ranktext), "%s", DynamicFactions[PlayerInfo[targetid][pFaction]][fRank5]);
			        case 6: format(ranktext, sizeof(ranktext), "%s", DynamicFactions[PlayerInfo[targetid][pFaction]][fRank6]);
			        case 7: format(ranktext, sizeof(ranktext), "%s", DynamicFactions[PlayerInfo[targetid][pFaction]][fRank7]);
			        case 8: format(ranktext, sizeof(ranktext), "%s", DynamicFactions[PlayerInfo[targetid][pFaction]][fRank8]);
			        case 9: format(ranktext, sizeof(ranktext), "%s", DynamicFactions[PlayerInfo[targetid][pFaction]][fRank9]);
			        case 10: format(ranktext, sizeof(ranktext), "%s", DynamicFactions[PlayerInfo[targetid][pFaction]][fRank10]);
			    }
		 		format(wstring, sizeof(wstring), "Faction: %s - Rank: %s",DynamicFactions[PlayerInfo[targetid][pFaction]][fName],ranktext);
  				SendClientMessage(playerid,COLOR_WHITE, wstring);
			}
			else
			{
				SendClientMessage(playerid,COLOR_WHITE, "Faction: None - Rank: None");
			}

			SendClientMessage(playerid,COLOR_RED, "<|> Stats <|>");
		}
	}
}

public PayDay()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(gPlayerLogged[i] == 1)
		    {
				if(PlayerInfo[i][pAllowedPayday] >= 5)
				{
				 		new wstring[256];
						new randcheck = 999 + random(4999);
						new interest = (PlayerInfo[i][pBank]/1000)*(intrate);
						new bonus = PlayerInfo[i][pPayCheck];
					    new newbank = PlayerInfo[i][pBank] + interest;
    					new randtax = 20 + random(50);
    					new biztax;
    					if(PlayerInfo[i][pBizKey] != 255)
    					{
    					biztax = PlayerInfo[i][pBizKey]*2;
    					}
    					else
    					{
    					biztax = 0;
    					}
						SendClientMessage(i,COLOR_RED,"<|> Paycheck <|>");
						format(wstring, sizeof(wstring), "~y~New York Bank~n~~w~Paycheck: ~g~%d",randcheck + bonus);
						GameTextForPlayer(i, wstring, 5000, 1);
					    format(wstring, sizeof(wstring), "Paycheck: $%d, Bonus: $%d", randcheck, bonus);
					    SendClientMessage(i,COLOR_WHITE, wstring);
					    format(wstring, sizeof(wstring), "Balance: $%d, Interest Gained: $%d, New Balance: $%d, Interest Rate: 0.%d percent", PlayerInfo[i][pBank], interest, newbank, intrate);
					    SendClientMessage(i,COLOR_WHITE, wstring);
					    format(wstring, sizeof(wstring), "Government Taxes: $%d, Business Taxes: $%d", randtax,biztax);
					    SendClientMessage(i,COLOR_WHITE, wstring);
					    PlayerInfo[i][pBank] += interest;
					    PlayerInfo[i][pBank] -= randtax;
					    PlayerInfo[i][pBank] += randcheck + bonus;
					    PlayerInfo[i][pBank] -= biztax;
			    		PlayerInfo[i][pPayCheck] = 0;
						PlayerInfo[i][pAllowedPayday] = 0;
						PlayerInfo[i][pExp]++;
						PlayerInfo[i][pPlayingHours] += 1;
						SendClientMessage(i,COLOR_RED,"<|> Paycheck <|>");

						new nxtlevel = PlayerInfo[i][pLevel]+1;
						new expamount = nxtlevel*levelexp;
						if(PlayerInfo[i][pExp] < expamount)
						{
	   						format(wstring, sizeof(wstring), "%d/%d experience needed to level up, you currently have %d", expamount,expamount,PlayerInfo[i][pExp]);
						    SendClientMessage(i,COLOR_WHITE, wstring);
						}
						else
						{
	   						format(wstring, sizeof(wstring), "Level up! - New Level: %d", nxtlevel);
						    SendClientMessage(i,COLOR_WHITE, wstring);
							PlayerInfo[i][pLevel]++;
						    PlayerInfo[i][pExp] = 0;
						}
				}
				else
				{
					SendClientMessage(i,COLOR_WHITE,"(INFO) Payday not received, not played long enough");
				}
			}
			else
			{
				SendClientMessage(i,COLOR_WHITE,"(INFO) You are not logged in, payday not received");
			}
		}
	}
}
//==============================================================================
public IsAtGasStation(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		if(PlayerToPoint(6.0,playerid,1004.0070,-939.3102,42.1797) || PlayerToPoint(6.0,playerid,1944.3260,-1772.9254,13.3906))
		{//LS
		    return 1;
		}
		else if(PlayerToPoint(6.0,playerid,-90.5515,-1169.4578,2.4079) || PlayerToPoint(6.0,playerid,-1609.7958,-2718.2048,48.5391))
		{//LS
		    return 1;
		}
		else if(PlayerToPoint(6.0,playerid,-2029.4968,156.4366,28.9498) || PlayerToPoint(8.0,playerid,-2408.7590,976.0934,45.4175))
		{//SF
		    return 1;
		}
		else if(PlayerToPoint(5.0,playerid,-2243.9629,-2560.6477,31.8841) || PlayerToPoint(8.0,playerid,-1676.6323,414.0262,6.9484))
		{//Between LS and SF
		    return 1;
		}
		else if(PlayerToPoint(6.0,playerid,2202.2349,2474.3494,10.5258) || PlayerToPoint(10.0,playerid,614.9333,1689.7418,6.6968))
		{//LV
		    return 1;
		}
		else if(PlayerToPoint(8.0,playerid,-1328.8250,2677.2173,49.7665) || PlayerToPoint(6.0,playerid,70.3882,1218.6783,18.5165))
		{//LV
		    return 1;
		}
		else if(PlayerToPoint(8.0,playerid,2113.7390,920.1079,10.5255) || PlayerToPoint(6.0,playerid,-1327.7218,2678.8723,50.0625))
		{//LV
		    return 1;
		}
	}
	return 0;
}

public IsAtBar(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		if(PlayerToPoint(4.0,playerid,495.7801,-76.0305,998.7578) || PlayerToPoint(4.0,playerid,499.9654,-20.2515,1000.6797))
		{//Ten Green Bottles, Havanna
		    return 1;
		}
		else if(PlayerToPoint(4.0,playerid,1215.9480,-13.3519,1000.9219) || PlayerToPoint(10.0,playerid,-2658.9749,1407.4136,906.2734))
		{//Pig Pen
		    return 1;
		}
	}
	return 0;
}
//==============================================================================
public IsVehicleOccupied(vehicleid)
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerInVehicle(i,vehicleid)) return 1;
	}
	return 0;
}

public IsAPlane(vehicleid)
{   new model = GetVehicleModel(vehicleid);
	if(model == 592 || model == 577 || model == 511 || model == 512 || model == 593 || model == 520 || model == 553 || model == 476 || model == 519 || model == 460 || model == 513)
	{
		return 1;
	}
	return 0;
}

public IsAHelicopter(vehicleid)
{   new model = GetVehicleModel(vehicleid);
	if(model == 548 || model == 425 || model == 417 || model == 487 || model == 488 || model == 497 || model == 563 || model == 447 || model == 469)
	{
		return 1;
	}
	return 0;
}

public IsATowTruck(vehicleid)
{   new model = GetVehicleModel(vehicleid);
 	if(model == 525)
	{
		return 1;
	}
	return 0;
}

public IsABike(vehicleid)
{   new model = GetVehicleModel(vehicleid);
	if(model == 581 || model == 509 || model == 481 || model == 462 || model == 521 || model == 463 || model == 510 || model == 522 || model == 461 || model == 448 || model == 471 || model == 468 || model == 586)
	{
		return 1;
	}
	return 0;
}
public FuelTimer()
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
    	if(IsPlayerConnected(i))
       	{
       	    if(GetPlayerState(i) == PLAYER_STATE_DRIVER)
       	    {
	       		new vehicle = GetPlayerVehicleID(i);
	        	if(Fuel[vehicle] >= 1)
		   		{
		   		    if(EngineStatus[vehicle])
		   		    {
	              		Fuel[vehicle]--;
	              		if(IsAPlane(vehicle)) { Fuel[vehicle]++; }
	              	}
		   		}
	   			else
	           	{
					OutOfFuel[i] = 1;
		        	GameTextForPlayer(i,"~r~Fuel Depleted",1500,3);
		        	TogglePlayerControllable(i,0);
				}
			}
		}
     }
 	for(new c=0;c<MAX_VEHICLES;c++)
	{
	    if(EngineStatus[c])
	    {
	        if(IsVehicleOccupied(c) == 0)
	        {
		        if(Fuel[c] >= 1)
		        {
		        	Fuel[c]--;
		        }
	        }
	    }
	}
	return 1;
}

public RemoveDriverFromVehicle(playerid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		RemovePlayerFromVehicle(playerid);
		TogglePlayerControllable(playerid,1);
		return 1;
	}
	return 0;
}
//==============================================================================
public JailTimer()
{
	new string[128];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(PlayerInfo[i][pJailed] >= 1)
	    {
	    	if(PlayerInfo[i][pJailTime] != 0)
	    	{
				PlayerInfo[i][pJailTime]--;
				format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~w~Time Left: ~g~%d seconds",PlayerInfo[i][pJailTime]);
   				GameTextForPlayer(i, string, 999, 3);
			}
			if(PlayerInfo[i][pJailTime] == 0)
			{
			    PlayerInfo[i][pJailed] = 0;
				SendClientMessage(i, COLOR_WHITE, "(INFO) You have served your sentence, your now free to go");
				SetPlayerVirtualWorld(i,2);
			    SetPlayerInterior(i,6);
				SetPlayerPos(i,268.0903,77.6489,1001.0391);
				PlayerCuffed[i] = 0;
			}
		}
	}
	return 1;
}

public BackupClear(playerid, calledbytimer)
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
		{
			if (PlayerInfo[playerid][pRequestingBackup] == 1)
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(PlayerInfo[i][pFaction] == 0 || PlayerInfo[i][pFaction] == 6)
						{
							DisablePlayerCheckpoint(i);
						}
					}
				}
				if (calledbytimer != 1)
				{
					SendClientMessage(playerid, COLOR_WHITE, "(INFO) Your backup request has been cleared");
				}
				else
				{
					SendClientMessage(playerid, COLOR_WHITE, "(INFO) Your backup request has been cleared automatically");
				}
				PlayerInfo[playerid][pRequestingBackup] = 0;
			}
			else
			{
				if (calledbytimer != 1)
				{
					SendClientMessage(playerid, COLOR_GREY, "(ERROR) You do not have an active backup request");
				}
			}
		}
		else
		{
			if (calledbytimer != 1)
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Invalid faction");
			}
		}
	}
	return 1;
}

public UntazePlayer(playerid)
{
	if(PlayerTazed[playerid] == 1)
	{
	    if(PlayerCuffed[playerid] == 1)
	    {
	        PlayerTazed[playerid] = 0;
	        TogglePlayerControllable(playerid, false);
	    }
	    else
	    {
	    	SendClientMessage(playerid, COLOR_WHITE, "(INFO) You are now untazed");
	    	TogglePlayerControllable(playerid, true);
	    	PlayerTazed[playerid] = 0;
	    	PlayerActionMessage(playerid,15.0,"has been untazed");
	    }
	}
	return 1;
}

public ResetRoadblockTimer()
{
	roadblocktimer = 0;
	return 1;
}

public RemoveRoadblock(playerid)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
   			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
				DisablePlayerCheckpoint(i);
			}
		}
	}
	DestroyObject(PlayerInfo[playerid][pRoadblock]);
	PlayerInfo[playerid][pRoadblock] = 0;
	return 1;
}

public IdleKick()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pAdmin] < 1)
		    {
				GetPlayerPos(i, PlayerPos[i][0], PlayerPos[i][1], PlayerPos[i][2]);
				if(PlayerPos[i][0] == PlayerPos[i][3] && PlayerPos[i][1] == PlayerPos[i][4] && PlayerPos[i][2] == PlayerPos[i][5])
				{
				    if(gPlayerLogged[i] == 1)
				    {
				    	SendClientMessage(i, COLOR_GREY, "(INFO) You have been logged out - Reason: Excessive Inactivity");
						gPlayerLogged[i] = 0;
					}
				}
				PlayerPos[i][3] = PlayerPos[i][0];
				PlayerPos[i][4] = PlayerPos[i][1];
				PlayerPos[i][5] = PlayerPos[i][2];
			}
		}
	}
}

public BlindfoldTimer(playerid)
{
	SendClientMessage(playerid, COLOR_WHITE, "(INFO) The blindfold over your eyes slowly slips off");
    return SetCameraBehindPlayer(playerid);
}

public ReleaseFromHospital(playerid)
{
	SendClientMessage(playerid, COLOR_WHITE, "(INFO) You have been released from Los Santos Hospital");
	SendClientMessage(playerid, COLOR_WHITE, "(DOCTOR) Your medical bill comes to $500");
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	TogglePlayerControllable(playerid, 1);
	SetCameraBehindPlayer(playerid);
	GivePlayerCash(playerid, -500);
	SetPlayerHealth(playerid, 70);
	PlayerInfo[playerid][pHospital] = 0;
	StopMusic(playerid);
	SetPlayerPos(playerid, 1177.4866,-1323.9749,14.0731);
	SetPlayerFacingAngle(playerid, 270.0);
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);
	SafeResetPlayerWeapons(playerid);
	if(PlayerInfo[playerid][pJailed] > 0)
	{
	   	if(PlayerInfo[playerid][pJailed] == 1)
		{
		    SetPlayerVirtualWorld(playerid,2);
		    SetPlayerInterior(playerid,6);
			SetPlayerPos(playerid,264.5743,77.5118,1001.0391);
			SendClientMessage(playerid, COLOR_WHITE, "(INFO) You have not finished your jail time");
			SafeResetPlayerWeapons(playerid);
			return 1;
		}
   		if(PlayerInfo[playerid][pJailed] == 2)
		{
		    SetPlayerVirtualWorld(playerid,0);
		    SetPlayerInterior(playerid,0);
		    SetPlayerPos(playerid,3312.4163,-1935.4459,10.9682);
			SendClientMessage(playerid, COLOR_WHITE, "(INFO) You have not finished your prison time");
			SafeResetPlayerWeapons(playerid);
			return 1;
		}
	}
	return 1;
}

public DoHospital(playerid)
{
    PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
	SetPlayerCameraPos(playerid, -833.5241,-1358.8575,86.9054);
	SetPlayerCameraLookAt(playerid, -830.8118,-1360.3612,87.0289);
	SetPlayerPos(playerid, 1177.4866,-1323.9749,14.0731);
	GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~y~You are recovering from your ~r~wounds~y~...", 30000, 3);
	TogglePlayerControllable(playerid, 0);
	PlayerPlaySound(playerid, 1062, 0.0, 0.0, 0.0);
	SetTimerEx("ReleaseFromHospital", 30000, 0, "d", playerid);
	SetPlayerInterior(playerid,0);
	return 1;
}

public Lotto(number)
{
	new JackpotFallen = 0;
	new string[256];
	new winner[MAX_PLAYER_NAME];
	format(string, sizeof(string), "(LOTTERY NEWS) Today the Winning Number has fallen on: %d", number);
    OOCNews(COLOR_RED, string);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pLottoNr] > 0)
		    {
			    if(PlayerInfo[i][pLottoNr] == number)
			    {
			        JackpotFallen = 1;
			        GetPlayerName(i, winner, sizeof(winner));
					format(string, sizeof(string), "(LOTTERY NEWS) %s won the Jackpot of $%d with his Lottery Ticket", winner, Jackpot);
					OOCNews(COLOR_RED, string);
					format(string, sizeof(string), "(INFO) You have won $%d with your Lottery Ticket", Jackpot);
					SendClientMessage(i, COLOR_RED, string);
					GivePlayerCash(i, Jackpot);
			    }
			    else
			    {
			        SendClientMessage(i, COLOR_WHITE, "(INFO) You have not won with your Lottery Ticket this time");
			    }
			}
			PlayerInfo[i][pLottoNr] = 0;
		}
	}
	if(JackpotFallen)
	{
	    new rand = random(125000); rand += 15789;
	    Jackpot = rand;
	    format(string, sizeof(string), "(LOTTERY NEWS) The new Jackpot has been started with $%d", Jackpot);
		OOCNews(COLOR_RED, string);
	}
	else
	{
	    new rand = random(15000); rand += 2158;
	    Jackpot += rand;
	    format(string, sizeof(string), "(LOTTERY NEWS) The Jackpot has been raised to $%d", Jackpot);
		OOCNews(COLOR_RED, string);
	}
	return 1;
}

public ClearCheckpointsForPlayer(playerid)
{
	DisablePlayerCheckpoint(playerid);
	if(PlayerInfo[playerid][pJob] == 3)
	{
		if(TrackingPlayer[playerid])
		{
		    SendClientMessage(playerid, COLOR_WHITE, "(INFO) You are no longer tracking a player");
			TrackingPlayer[playerid] = 0;
		}
	}
	return 1;
}

public DrugEffect(playerid)
{
	SendClientMessage(playerid, COLOR_WHITE, "(INFO) You are stoned");
 	ApplyAnimation(playerid,"RAPPING","Laugh_01",4.1,1,1,1,1,1);
    SetTimerEx("UndrugEffect", 30000, false, "i", playerid);
	return 1;
}

public UndrugEffect(playerid)
{
	ClearAnimations(playerid);
	SendClientMessage(playerid, COLOR_WHITE, "(INFO) You are not stoned anymore");
	DrugsIntake[playerid] = 0;
	return 1;
}
//==============================================================================
public HangupTimer(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid))
	{
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE)
		{
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
			return 1;
		}
	}
	return 0;
}

public PhoneAnimation(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid))
	{
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
		SetTimerEx("HangupTimer", 1000, false, "i", playerid);
		return 1;
	}
	return 0;
}
//==============================================================================
public LockRacers()
{
	for(new i;i<MAX_PLAYERS;i++)
	{
		if(RaceParticipant[i] != 0)
		{
			TogglePlayerControllable(i,0);
			if(IsPlayerInAnyVehicle(i)) PlayerVehicles[i]=GetPlayerVehicleID(i);
			else PlayerVehicles[i]=0;
		}
	}
}

public UnlockRacers()
{
	for(new i;i<MAX_PLAYERS;i++)
	{
		if(RaceParticipant[i]>0)
		{
			TogglePlayerControllable(i,1);
			if(PlayerVehicles[i] != 0)
			{
				PutPlayerInVehicle(i,PlayerVehicles[i],0);
				PlayerVehicles[i]=0;
			}
		}
	}
}

public countdown() {
	if(RaceStart == 0)
	{
		RaceStart=1;
		LockRacers();
		new tmpprize, OPot;
		OPot=Pot;
		if(PrizeMode == 1 || PrizeMode == 4)
		{
			if(Racemode == 0 || Racemode == 3) tmpprize = floatround(RLenght);
			else if(Racemode == 1) tmpprize = floatround(LLenght * Racelaps);
			else if(Racemode == 2) tmpprize = floatround(RLenght * 2 * Racelaps);
		}
		tmpprize *= DynaMP;
		if(PrizeMode == 0 || PrizeMode == 3) Pot += Prize;
		else if(PrizeMode == 1 || PrizeMode == 4) Pot += tmpprize;
		if(Participants == 1) Pot=OPot;
	}
	if(cd>0)
	{
		format(ystring, sizeof(ystring), "%d...",cd);
		for(new i=0;i<MAX_PLAYERS;i++)
		{
			if(RaceParticipant[i]>1)
			{
				RaceSound(i,1056);
			    GameTextForPlayer(i,ystring,1000,3);
		    }
	    }
	}
	else if(cd == 0)
	{
		format(ystring, sizeof(ystring), "~g~GO",cd);
	    KillTimer(Countdown);
		for(new i=0;i<MAX_PLAYERS;i++)
		{
			if(RaceParticipant[i]>1)
			{
				RaceSound(i,1057);
			    GameTextForPlayer(i,ystring,3000,3);
				RaceParticipant[i]=4;
				CurrentLap[i]=1;
				if(Racemode == 3) SetRaceCheckpoint(i,LCurrentCheckpoint,LCurrentCheckpoint-1);
				else SetRaceCheckpoint(i,0,1);
		    }
	    }
		UnlockRacers();
		RaceTick=tickcount();
	}
	cd--;
}

public SetNextCheckpoint(playerid)
{
	if(Racemode == 0)
	{
		CurrentCheckpoint[playerid]++;
		if(CurrentCheckpoint[playerid] == LCurrentCheckpoint)
		{
			SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],-1);
			RaceParticipant[playerid]=6;
		}
		else SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],CurrentCheckpoint[playerid]+1);
	}
	else if(Racemode == 1)
	{
		CurrentCheckpoint[playerid]++;
		if(CurrentCheckpoint[playerid] == LCurrentCheckpoint+1 && CurrentLap[playerid] == Racelaps)
		{
			SetRaceCheckpoint(playerid,0,-1);
			RaceParticipant[playerid]=6;
		}
		else if (CurrentCheckpoint[playerid] == LCurrentCheckpoint+1 && CurrentLap[playerid] != Racelaps)
		{
			CurrentCheckpoint[playerid]=0;
			SetRaceCheckpoint(playerid,0,1);
			RaceParticipant[playerid]=5;
		}
		else if(CurrentCheckpoint[playerid] == 1 && RaceParticipant[playerid]==5)
		{
			ChangeLap(playerid);
			if(LCurrentCheckpoint==1)
			{
				SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],0);
			}
			else
			{
				SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],2);
            }
  		    RaceParticipant[playerid]=4;
		}
		else
		{
			if(LCurrentCheckpoint==1 || CurrentCheckpoint[playerid] == LCurrentCheckpoint) SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],0);
			else SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],CurrentCheckpoint[playerid]+1);
		}
	}
	else if(Racemode == 2)
	{
		if(RaceParticipant[playerid]==4)
		{
			if(CurrentCheckpoint[playerid] == LCurrentCheckpoint)
			{
			    RaceParticipant[playerid]=5;
				CurrentCheckpoint[playerid]=LCurrentCheckpoint-1;
				SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],CurrentCheckpoint[playerid]-1);
			}
			else if(CurrentCheckpoint[playerid] == LCurrentCheckpoint-1)
			{
				CurrentCheckpoint[playerid]++;
				SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],CurrentCheckpoint[playerid]-1);
			}
			else
			{
				CurrentCheckpoint[playerid]++;
				SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],CurrentCheckpoint[playerid]+1);
			}
		}
		else if(RaceParticipant[playerid]==5)
		{
			if(CurrentCheckpoint[playerid] == 1 && CurrentLap[playerid] == Racelaps)
			{
				SetRaceCheckpoint(playerid,0,-1);
				RaceParticipant[playerid]=6;
			}
			else if(CurrentCheckpoint[playerid] == 0)
			{
				ChangeLap(playerid);
				if(LCurrentCheckpoint==1)
				{
					SetRaceCheckpoint(playerid,1,0);
				}
				else
				{
					SetRaceCheckpoint(playerid,1,2);
	            }
	  		    RaceParticipant[playerid]=4;
			}
			else if(CurrentCheckpoint[playerid] == 1)
			{
				CurrentCheckpoint[playerid]--;
				SetRaceCheckpoint(playerid,0,1);
			}
			else
			{
				CurrentCheckpoint[playerid]--;
				SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],CurrentCheckpoint[playerid]-1);
			}
		}
	}
	else if(Racemode == 3)
	{
		CurrentCheckpoint[playerid]--;
		if(CurrentCheckpoint[playerid] == 0)
		{
			SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],-1);
			RaceParticipant[playerid]=6;
		}
		else
		{
			 SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],CurrentCheckpoint[playerid]-1);
	    }
	}
}

public SetRaceCheckpoint(playerid,target,next)
{
	if(next == -1 && Airrace == 0) SetPlayerRaceCheckpoint(playerid,1,RaceCheckpoints[target][0],RaceCheckpoints[target][1],RaceCheckpoints[target][2],0.0,0.0,0.0,CPsize);
	else if(next == -1 && Airrace == 1) SetPlayerRaceCheckpoint(playerid,4,RaceCheckpoints[target][0],RaceCheckpoints[target][1],RaceCheckpoints[target][2],0.0,0.0,0.0,CPsize);
	else if(Airrace == 1) SetPlayerRaceCheckpoint(playerid,3,RaceCheckpoints[target][0],RaceCheckpoints[target][1],RaceCheckpoints[target][2],RaceCheckpoints[next][0],
							RaceCheckpoints[next][1],RaceCheckpoints[next][2],CPsize);
	else SetPlayerRaceCheckpoint(playerid,0,RaceCheckpoints[target][0],RaceCheckpoints[target][1],RaceCheckpoints[target][2],RaceCheckpoints[next][0],RaceCheckpoints[next][1],
							RaceCheckpoints[next][2],CPsize);
}
public SetBRaceCheckpoint(playerid,target,next)
{
	new ar = BAirrace[b(playerid)];
	if(next == -1 && ar == 0) SetPlayerRaceCheckpoint(playerid,1,BRaceCheckpoints[b(playerid)][target][0],BRaceCheckpoints[b(playerid)][target][1],
								BRaceCheckpoints[b(playerid)][target][2],0.0,0.0,0.0,BCPsize[b(playerid)]);
	else if(next == -1 && ar == 1) SetPlayerRaceCheckpoint(playerid,4,BRaceCheckpoints[b(playerid)][target][0],
				BRaceCheckpoints[b(playerid)][target][1],BRaceCheckpoints[b(playerid)][target][2],0.0,0.0,0.0,
				BCPsize[b(playerid)]);
	else if(ar == 1) SetPlayerRaceCheckpoint(playerid,3,BRaceCheckpoints[b(playerid)][target][0],BRaceCheckpoints[b(playerid)][target][1],BRaceCheckpoints[b(playerid)][target][2],
						BRaceCheckpoints[b(playerid)][next][0],BRaceCheckpoints[b(playerid)][next][1],BRaceCheckpoints[b(playerid)][next][2],BCPsize[b(playerid)]);
	else SetPlayerRaceCheckpoint(playerid,0,BRaceCheckpoints[b(playerid)][target][0],BRaceCheckpoints[b(playerid)][target][1],BRaceCheckpoints[b(playerid)][target][2],
			BRaceCheckpoints[b(playerid)][next][0],BRaceCheckpoints[b(playerid)][next][1],BRaceCheckpoints[b(playerid)][next][2],BCPsize[b(playerid)]);
}

public GetLapTick(playerid)
{
	new tick, lap;
	tick=tickcount();
	if(CurrentLap[playerid]==1)
	{
		lap=tick-RaceTick;
		LastLapTick[playerid]=tick;
	}
	else
	{
		lap=tick-LastLapTick[playerid];
		LastLapTick[playerid]=tick;
	}
	return lap;
}

public GetRaceTick(playerid)
{
	new tick, race;
	tick=tickcount();
	race=tick-RaceTick;
	return race;
}

public endrace()
{
    SaveScores();
	for(new i=0;i<LCurrentCheckpoint;i++)
	{
	    RaceCheckpoints[i][0]=0.0;
	    RaceCheckpoints[i][1]=0.0;
	    RaceCheckpoints[i][2]=0.0;
	}
	LCurrentCheckpoint=0;
    for(new i=0;i<MAX_PLAYERS;i++)
    {
		LastLapTick[i]=0;
        DisablePlayerRaceCheckpoint(i);
		if(RaceParticipant[i]==3)
		{
				TogglePlayerControllable(i,1);
		        if(PlayerVehicles[i] != 0)
		        {
		            PutPlayerInVehicle(i,PlayerVehicles[i],0);
		            PlayerVehicles[i]=0;
		        }
		}
        RaceParticipant[i]=0;
    }
	RaceActive=0;
	RaceStart=0;
	Participants=0;
	Pot = 0;
	PrizeMP = 3;
    SendClientMessageToAll(COLOR_RED, "(INFO) The current race has finished");
}

public BActiveCP(playerid,sele)
{
	if(BCurrentCheckpoints[b(playerid)]-1 == sele) SetBRaceCheckpoint(playerid,sele,-1);
	else SetBRaceCheckpoint(playerid,sele,sele+1);
}

public RaceSound(playerid,sound)
{
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	PlayerPlaySound(playerid,sound,x,y,z);
}

public ReadyRefresh()
{
	if(RaceActive==1)
	{
		new Waiting=0, Ready=0;
		for(new i=0;i<MAX_PLAYERS;i++)
		{
			if(RaceParticipant[i] == 1 || RaceParticipant[i] == 2) Waiting++;
			else if(RaceParticipant[i] == 3) Ready++;
		}
		if(Waiting==0)
		{
			SendClientMessageToAll(COLOR_RED,"(INFO) Everyone is ready, the race will begin shortly");
			cd=5;
			Countdown = SetTimer("countdown",1000,1);
		}
		else if(Ready >= Waiting && MajorityDelay > 0 && MajStart == 0)
		{
			MajStart=1;
			format(ystring,sizeof(ystring),"(INFO) Half of the racers are ready, race starts in %d seconds", MajorityDelay);
			SendClientMessageToAll(COLOR_RED,ystring);
			MajStartTimer = SetTimer("mscountdown",10000,1);
			mscd= MajorityDelay;
		}
	}
}

public mscountdown()
{
	if(RaceStart == 1 || MajStart == 0)
	{
		MajStart=0;
		KillTimer(MajStartTimer);
	}
	else
	{
		mscd-=10;
		if(mscd <= 0)
		{
			for(new i;i<MAX_PLAYERS;i++)
			{
				if(RaceParticipant[i] != 3 && RaceParticipant[i] != 0)
				{
					GameTextForPlayer(i,"~r~You did not make it in time",6000,3);
					DisablePlayerRaceCheckpoint(i);
					RaceParticipant[i]=0;
					Participants--;
				}
				else if (RaceParticipant[i]!=0) SendClientMessage(i,COLOR_WHITE,"(INFO) Pre-race countdown done, the race begins");
			}
			KillTimer(MajStartTimer);
			cd=5;
			Countdown = SetTimer("countdown",1000,1);
		}
		else
		{

			new hurry_string[64];
			format(ystring,sizeof(ystring),"~y~Race starting in ~w~%d~y~ seconds",mscd);
			format(hurry_string,sizeof(hurry_string),"%s~n~~r~HURRY UP AND /READY",ystring);
			for(new i;i<MAX_PLAYERS;i++)
			{
				if(RaceParticipant[i] < 3 && mscd < 31) GameTextForPlayer(i,hurry_string,6000,3);
				else if(RaceParticipant[i] > 0) GameTextForPlayer(i,ystring,6000,3);
			}
		}
	}
}

public CheckBestLap(playerid,laptime)
{
	if(TopLapTimes[4]<laptime && TopLapTimes[4] != 0 || Racemode == 0)
	{
		return 0;
	}
	for(new i;i<5;i++)
	{
	    if(TopLapTimes[i] == 0)
	    {
			new playername[MAX_PLAYER_NAME];
	        GetPlayerName(playerid,playername,MAX_PLAYER_NAME);
	        TopLappers[i]=playername;
	        TopLapTimes[i]=laptime;
			ScoreChange=1;
			return i+1;
	    }
		else if(TopLapTimes[i] > laptime)
		{
		    for(new j=4;j>=i;j--)
		    {
		        TopLapTimes[j+1]=TopLapTimes[j];
		        TopLappers[j+1]=TopLappers[j];
		    }
			new playername[MAX_PLAYER_NAME];
	        GetPlayerName(playerid,playername,MAX_PLAYER_NAME);
		    TopLapTimes[i]=laptime;
			TopLappers[i]=playername;
			ScoreChange=1;
			return i+1;
		}
	}
	return -1;
}

public CheckBestRace(playerid,racetime)
{
	if(TopRacerTimes[4]<racetime && TopRacerTimes[4] != 0) return 0;
	for(new i;i<5;i++)
	{
	    if(TopRacerTimes[i] == 0)
	    {
			new playername[MAX_PLAYER_NAME];
	        GetPlayerName(playerid,playername,MAX_PLAYER_NAME);
	        TopRacers[i]=playername;
	        TopRacerTimes[i]=racetime;
			ScoreChange=1;
			return i+1;
	    }
		else if(TopRacerTimes[i] > racetime)
		{
		    for(new j=4;j>=i;j--)
		    {
		        TopRacerTimes[j+1]=TopRacerTimes[j];
		        TopRacers[j+1]=TopRacers[j];
		    }
			new playername[MAX_PLAYER_NAME];
	        GetPlayerName(playerid,playername,MAX_PLAYER_NAME);
		    TopRacerTimes[i]=racetime;
			TopRacers[i]=playername;
			ScoreChange=1;
			return i+1;
		}
	}
	return -1;
}

public SaveScores()
{
	if(ScoreChange == 1)
	{
		fremove(CFile);
		new File:f,Float:x,Float:y,Float:z, templine[512];
		f = fopen(CFile,io_write);
		format(templine,sizeof(templine),"YRACE %d %s %d %d %d %f\n", RACEFILE_VERSION, CBuilder, ORacemode, ORacelaps, OAirrace, OCPsize);
		fwrite(f,templine);
		format(templine,sizeof(templine),"%s %d %s %d %s %d %s %d %s %d\n",
				TopRacers[0],TopRacerTimes[0],TopRacers[1], TopRacerTimes[1], TopRacers[2],TopRacerTimes[2],
	 			TopRacers[3],TopRacerTimes[3],TopRacers[4], TopRacerTimes[4]);
		fwrite(f,templine);
		format(templine,sizeof(templine),"%s %d %s %d %s %d %s %d %s %d\n",
				TopLappers[0],TopLapTimes[0],TopLappers[1], TopLapTimes[1], TopLappers[2],TopLapTimes[2],
	 			TopLappers[3],TopLapTimes[3],TopLappers[4], TopLapTimes[4]);
		fwrite(f,templine);
		for(new i = 0; i < LCurrentCheckpoint+1;i++)
		{
			x=RaceCheckpoints[i][0];
			y=RaceCheckpoints[i][1];
			z=RaceCheckpoints[i][2];
			format(templine,sizeof(templine),"%f %f %f\n",x,y,z);
			fwrite(f,templine);
		}
		fclose(f);
	}
	ScoreChange=0;
}

public ChangeLap(playerid)
{
	new LapTime, TimeString[10], checklap;
	LapTime=GetLapTick(playerid);
	TimeString=BeHuman(LapTime);
	format(ystring,sizeof(ystring),"~w~Lap %d/%d - time: %s", CurrentLap[playerid], Racelaps, TimeString);
	if(Racemode == ORacemode && ORacelaps == Racelaps)
	{
		checklap=CheckBestLap(playerid,LapTime);
		if(checklap==1) format(ystring,sizeof(ystring),"%s~n~~y~LAP RECORD",ystring);
	}
	CurrentLap[playerid]++;
	if(CurrentLap[playerid] == Racelaps) format(ystring,sizeof(ystring),"%s~n~~g~Final lap",ystring);
	GameTextForPlayer(playerid,ystring,5000,3);
}

BeHuman(ticks)
{
	new HumanTime[10], minutes, seconds, secstring[2], msecstring[3];
	minutes=ticks/60000;
	ticks=ticks-(minutes*60000);
	seconds=ticks/1000;
	ticks=ticks-(seconds*1000);
	if(seconds <10) format(secstring,sizeof(secstring),"0%d",seconds);
	else format(secstring,sizeof(secstring),"%d",seconds);
	format(HumanTime,sizeof(HumanTime),"%d:%s",minutes,secstring);
	if(ticks < 10) format(msecstring,sizeof(msecstring),"00%d", ticks);
	else if(ticks < 100) format(msecstring,sizeof(msecstring),"0%d",ticks);
	else format(msecstring,sizeof(msecstring),"%d",ticks);
	format(HumanTime,sizeof(HumanTime),"%s.%s",HumanTime,msecstring);
	return HumanTime;
}

public LoadTimes(playerid,timemode,tmp[])
{
	new temprace[67], idx;
	format(temprace,sizeof(temprace),"New York Roleplay/Race/%s.yr",tmp);
    if(strlen(tmp))
    {
		if(!fexist(temprace))
		{
			format(ystring,sizeof(ystring),"(ERROR) Race \"%s\" does not exist",tmp);
			SendClientMessage(playerid,COLOR_GREY,ystring);
			return 1;
		}
		else
		{
			new File:f, templine[256], TBuilder[MAX_PLAYER_NAME], TempLapper[MAX_PLAYER_NAME], TempLap;
			idx=0;
			f = fopen(temprace, io_read);
			fread(f,templine,sizeof(templine));
			if(templine[0] == 'Y')
			{
				new fileversion;
			    otherstrtok(templine,idx);
				fileversion = strval(otherstrtok(templine,idx));
				if(fileversion > RACEFILE_VERSION)
				{
				    format(ystring,sizeof(ystring),"(ERROR) Race \"%s\" is created with a newer version, unable to load",tmp);
				    SendClientMessage(playerid,COLOR_GREY,ystring);
				    return 1;
				}
				TBuilder=otherstrtok(templine,idx);
				fread(f,templine,sizeof(templine));
				if(timemode ==1) fread(f,templine,sizeof(templine));
				idx=0;
				if(timemode == 0) format(ystring,sizeof(ystring),"(INFO) %s by %s - Best Race Times:",tmp,TBuilder);
				else if(timemode == 1) format(ystring,sizeof(ystring),"(INFO) %s by %s - Best Laps:",tmp,TBuilder);
				else return 1;
				SendClientMessage(playerid,COLOR_WHITE,ystring);
				for(new i=0;i<5;i++)
				{
				    TempLapper=otherstrtok(templine,idx);
				    TempLap=strval(otherstrtok(templine,idx));
					if(TempLap == 0)
					{
					    format(ystring,sizeof(ystring),"%d. None yet",i+1);
						i=6;
					}
					else format(ystring,sizeof(ystring),"%d. %s - %s",i+1,BeHuman(TempLap),TempLapper);
					SendClientMessage(playerid,COLOR_WHITE,ystring);
				}
				return 1;
			}
			else
			{
				format(ystring,sizeof(ystring),"(ERROR) Race \"%s\" does not contain any time data",tmp);
				SendClientMessage(playerid,COLOR_GREY,ystring);
				return 1;
			}
		}
    }
	return 0;
}

public IsNotAdmin(playerid)
{
    if (PlayerInfo[playerid][pAdmin] < 1)
	{
	    SendClientMessage(playerid, COLOR_GREY, "(ERROR) You are not authorized to use that command");
	    return 1;
    }
    return 0;
}

public GetBuilderSlot(playerid)
{
	for(new i;i < MAX_BUILDERS; i++)
	{
	    if(!(BuilderSlots[i] < MAX_PLAYERS+1))
	    {
	        BuilderSlots[i] = playerid;
	        RaceBuilders[playerid] = i+1;
			return i+1;
	    }
	}
	return 0;
}

public b(playerid) return RaceBuilders[playerid]-1;

public Float:Distance(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2)
{
	new Float:temp=floatsqroot((x1-x2) * (x1-x2) + (y1-y2) * (y1-y2) + (z1-z2) * (z1-z2));
	if(temp < 0) temp=temp*(-1);
	return temp;
}

public clearrace(playerid)
{
	for(new i=0;i<BCurrentCheckpoints[b(playerid)];i++)
	{
		BRaceCheckpoints[b(playerid)][i][0]=0.0;
		BRaceCheckpoints[b(playerid)][i][1]=0.0;
		BRaceCheckpoints[b(playerid)][i][2]=0.0;
	}
	BCurrentCheckpoints[b(playerid)]=0;
	DisablePlayerRaceCheckpoint(playerid);
	SendClientMessage(playerid, COLOR_WHITE, "(INFO) Your race has been cleared");
	BuilderSlots[b(playerid)] = MAX_PLAYERS+1;
	RaceBuilders[playerid]=0;
}

public startrace()
{
	format(ystring,128,"(INFO) The race \"%s\" has started, type /join to participate in the race",CRaceName);
	SendClientMessageToAll(COLOR_RED,ystring);
	if(Racemode == 0) format(ystring,sizeof(ystring),"Default");
	else if(Racemode == 1) format(ystring,sizeof(ystring),"Ring");
	else if(Racemode == 2) format(ystring,sizeof(ystring),"Yoyo");
	else if(Racemode == 3) format(ystring,sizeof(ystring),"Mirror");
	format(ystring,sizeof(ystring),"(INFO) Racemode: %s Laps: %d",ystring,Racelaps);
	if(PrizeMode >= 2) format(ystring,sizeof(ystring),"%s Join fee: %d",ystring,JoinFee);
	if(Airrace == 1) format(ystring,sizeof(ystring),"%s Air Race",ystring);
	if(Racemode == 0 || Racemode == 3) format(ystring,sizeof(ystring),"%s Track lenght: %0.2fkm", ystring, RLenght/1000);
	else if(Racemode == 1) format(ystring,sizeof(ystring),"%s Lap lenght: %.2fkm, Total: %.2fkm", ystring, LLenght/1000, LLenght * Racelaps / 1000);
	SendClientMessageToAll(COLOR_RED,ystring);
	RaceStart=0;
	RaceActive=1;
	ScoreChange=0;
	Ranking=1;
	PrizeMP=3;
}

ReturnModeName(mode)
{
	new modename[8];
	if(mode == 0) modename="Default";
	else if(mode == 1) modename="Ring";
	else if(mode == 2) modename="Yoyo";
	else if(mode == 3) modename="Mirror";
	return modename;
}

public LoadRace(tmp[])
{
	new race_name[32],templine[512];
	format(CRaceName,sizeof(CRaceName), "%s",tmp);
	format(race_name,sizeof(race_name), "New York Roleplay/Race/%s.yr",tmp);
	if(!fexist(race_name)) return -1;
	CFile=race_name;
    LCurrentCheckpoint=-1; RLenght=0; RLenght=0;
	new File:f, i;
	f = fopen(race_name, io_read);
	fread(f,templine,sizeof(templine));
	if(templine[0] == 'Y')
	{
		new fileversion;
	    otherstrtok(templine,i);
		fileversion = strval(otherstrtok(templine,i));
		if(fileversion > RACEFILE_VERSION) return -2;
		CBuilder=otherstrtok(templine,i);
		ORacemode = strval(otherstrtok(templine,i));
		ORacelaps = strval(otherstrtok(templine,i));
		if(fileversion > 1)
		{
			Airrace = strval(otherstrtok(templine,i));
			CPsize = floatstr(otherstrtok(templine,i));
		}
		else
		{
			Airrace = 0;
			CPsize = 8.0;
		}
		OAirrace = Airrace;
		OCPsize = CPsize;
		Racemode=ORacemode; Racelaps=ORacelaps;
		fread(f,templine,sizeof(templine));
		i=0;
		for(new j=0;j<5;j++)
		{
		    TopRacers[j]=otherstrtok(templine,i);
		    TopRacerTimes[j]=strval(otherstrtok(templine,i));
		}
		fread(f,templine,sizeof(templine));
		i=0;
		for(new j=0;j<5;j++)
		{
		    TopLappers[j]=otherstrtok(templine,i);
		    TopLapTimes[j]=strval(otherstrtok(templine,i));
		}
	}
	else
	{
		LCurrentCheckpoint++;
		RaceCheckpoints[LCurrentCheckpoint][0] = floatstr(otherstrtok(templine,i));
		RaceCheckpoints[LCurrentCheckpoint][1] = floatstr(otherstrtok(templine,i));
		RaceCheckpoints[LCurrentCheckpoint][2] = floatstr(otherstrtok(templine,i));
		Racemode=0; ORacemode=0; Racelaps=0; ORacelaps=0;
		CPsize = 8.0; Airrace = 0;
		OCPsize = CPsize; OAirrace = Airrace;
		CBuilder="UNKNOWN";
		for(new j;j<5;j++)
		{
		    TopLappers[j]="A"; TopLapTimes[j]=0; TopRacers[j]="A"; TopRacerTimes[j]=0;
		}
	}
	while(fread(f,templine,sizeof(templine),false))
	{
		LCurrentCheckpoint++;
		i=0;
		RaceCheckpoints[LCurrentCheckpoint][0] = floatstr(otherstrtok(templine,i));
		RaceCheckpoints[LCurrentCheckpoint][1] = floatstr(otherstrtok(templine,i));
		RaceCheckpoints[LCurrentCheckpoint][2] = floatstr(otherstrtok(templine,i));
		if(LCurrentCheckpoint >= 1)
		{
		    RLenght+=Distance(RaceCheckpoints[LCurrentCheckpoint][0],RaceCheckpoints[LCurrentCheckpoint][1],
								RaceCheckpoints[LCurrentCheckpoint][2],RaceCheckpoints[LCurrentCheckpoint-1][0],
								RaceCheckpoints[LCurrentCheckpoint-1][1],RaceCheckpoints[LCurrentCheckpoint-1][2]);
		}
	}
	LLenght = RLenght + Distance(RaceCheckpoints[LCurrentCheckpoint][0],RaceCheckpoints[LCurrentCheckpoint][1],
								RaceCheckpoints[LCurrentCheckpoint][2],RaceCheckpoints[0][0],RaceCheckpoints[0][1],
								RaceCheckpoints[0][2]);
	fclose(f);
	return 1;
}

public RaceRotation()
{
	if(!fexist("yrace.rr"))
	{
	    printf("Error in Race Rotation (yrace.rr): yrace.rr does not exist");
	    return -1;
	}

	if(RRotation == -1)
	{
		KillTimer(RotationTimer);
		return -1;
	}
	if(Participants > 0) return 1;

	new File:f, templine[32], rotfile[]="yrace.rr", rraces=-1, rracenames[32][32], idx, fback;
	f = fopen(rotfile, io_read);
	while(fread(f,templine,sizeof(templine),false))
	{
		idx = 0;
		rraces++;
		rracenames[rraces]=otherstrtok(templine,idx);
	}
	fclose(f);
	RRotation++;
	if(RRotation > rraces) RRotation = 0;
	fback = LoadRace(rracenames[RRotation]);
	if(fback == -1) printf("Error in Race Rotation (yrace.rr): Race \"%s\" does not exist",rracenames[RRotation]);
	else if (fback == -2) printf("Error in Race Rotation (yrace.rr): Race \"%s\" is created with a newer version",rracenames[RRotation]);
	else startrace();
	return 1;
}

public RefreshMenuHeader(playerid,Menu:menu,text[])
{
	SetMenuColumnHeader(menu,0,text);
	ShowMenuForPlayer(menu,playerid);
}

public CreateRaceMenus()
{
	MAdmin = CreateMenu("Admin menu", 1, 25, 170, 220, 25);
	AddMenuItem(MAdmin,0,"Set prizemode...");
	AddMenuItem(MAdmin,0,"Set fixed prize...");
	AddMenuItem(MAdmin,0,"Set dynamic prize...");
	AddMenuItem(MAdmin,0,"Set entry fees...");
	AddMenuItem(MAdmin,0,"Majority delay...");
	AddMenuItem(MAdmin,0,"End current race");
	AddMenuItem(MAdmin,0,"Toggle Race Admin [RA]");
	AddMenuItem(MAdmin,0,"Toggle Build Admin [BA]");
	AddMenuItem(MAdmin,0,"Toggle Race Rotation [RR]");
	AddMenuItem(MAdmin,0,"Exit");
	if(RaceAdmin == 1) format(ystring,sizeof(ystring),"RA: On");
	else format(ystring,sizeof(ystring),"RA: Off");
	if(BuildAdmin == 1) format(ystring,sizeof(ystring),"%s BA: On",ystring);
	else format(ystring,sizeof(ystring),"%s BA: Off",ystring);
	if(RRotation >= 0) format(ystring,sizeof(ystring),"%s RR: On",ystring);
	else format(ystring,sizeof(ystring),"%s RR: Off",ystring);
	SetMenuColumnHeader(MAdmin,0,ystring);

	MPMode = CreateMenu("Set prizemode:", 1, 25, 170, 220, 25);
	AddMenuItem(MPMode,0,"Fixed");
	AddMenuItem(MPMode,0,"Dynamic");
	AddMenuItem(MPMode,0,"Entry Fee");
	AddMenuItem(MPMode,0,"Entry Fee + Fixed");
	AddMenuItem(MPMode,0,"Entry Fee + Dynamic");
	AddMenuItem(MPMode,0,"Back");
	SetMenuColumnHeader(MPMode,0,"Mode: Fixed");

	MPrize = CreateMenu("Fixed prize:", 1, 25, 170, 220, 25);
	AddMenuItem(MPrize,0,"+100$");
	AddMenuItem(MPrize,0,"+1000$");
	AddMenuItem(MPrize,0,"+10000$");
	AddMenuItem(MPrize,0,"-100$");
	AddMenuItem(MPrize,0,"-1000$");
	AddMenuItem(MPrize,0,"-10000$");
	AddMenuItem(MPrize,0,"Back");
	format(ystring,sizeof(ystring),"Amount: %d",Prize);
	SetMenuColumnHeader(MPrize,0,ystring);

	MDyna = CreateMenu("Dynamic Prize:", 1, 25, 170, 220, 25);
	AddMenuItem(MDyna,0,"+1x");
	AddMenuItem(MDyna,0,"+5x");
	AddMenuItem(MDyna,0,"-1x");
	AddMenuItem(MDyna,0,"-5x");
	AddMenuItem(MDyna,0,"Leave");
	format(ystring,sizeof(ystring),"Multiplier: %dx",DynaMP);
	SetMenuColumnHeader(MDyna,0,ystring);

	MBuild = CreateMenu("Build Menu", 1, 25, 170, 220, 25);
	AddMenuItem(MBuild,0,"Set laps...");
	AddMenuItem(MBuild,0,"Set racemode...");
	AddMenuItem(MBuild,0,"Checkpoint size...");
	AddMenuItem(MBuild,0,"Toggle air race");
	AddMenuItem(MBuild,0,"Clear the race and exit");
	AddMenuItem(MBuild,0,"Leave");
	SetMenuColumnHeader(MBuild,0,"Air race: Off");

	MLaps = CreateMenu("Set laps", 1, 25, 170, 220, 25);
	AddMenuItem(MLaps,0,"+1");
	AddMenuItem(MLaps,0,"+5");
	AddMenuItem(MLaps,0,"+10");
	AddMenuItem(MLaps,0,"-1");
	AddMenuItem(MLaps,0,"-5");
	AddMenuItem(MLaps,0,"-10");
	AddMenuItem(MLaps,0,"Back");

	MRacemode = CreateMenu("Racemode", 1, 25, 170, 220, 25);
	AddMenuItem(MRacemode,0,"Default");
	AddMenuItem(MRacemode,0,"Ring");
	AddMenuItem(MRacemode,0,"Yoyo");
	AddMenuItem(MRacemode,0,"Mirror");
	AddMenuItem(MRacemode,0,"Back");

	MRace = CreateMenu("Race Menu", 1, 25, 170, 220, 25);
	AddMenuItem(MRace,0,"Set laps...");
	AddMenuItem(MRace,0,"Set racemode...");
	AddMenuItem(MRace,0,"Set checkpoint size...");
	AddMenuItem(MRace,0,"Toggle air race");
	AddMenuItem(MRace,0,"Start race");
	AddMenuItem(MRace,0,"Exit");

	MFee = CreateMenu("Entry fees", 1, 25, 170, 220, 25);
	AddMenuItem(MFee,0,"+100");
	AddMenuItem(MFee,0,"+1000");
	AddMenuItem(MFee,0,"+10000");
	AddMenuItem(MFee,0,"-100");
	AddMenuItem(MFee,0,"-1000");
	AddMenuItem(MFee,0,"-10000");
	AddMenuItem(MFee,0,"Back");
	format(ystring,sizeof(ystring),"Fee: %d$",JoinFee);
	SetMenuColumnHeader(MFee,0,ystring);

	MCPsize = CreateMenu("CP size", 1, 25, 170, 220, 25);
	AddMenuItem(MCPsize,0,"+0.1");
	AddMenuItem(MCPsize,0,"+1");
	AddMenuItem(MCPsize,0,"+10");
	AddMenuItem(MCPsize,0,"-0.1");
	AddMenuItem(MCPsize,0,"-1");
	AddMenuItem(MCPsize,0,"-10");
	AddMenuItem(MCPsize,0,"Back");

	MDelay = CreateMenu("Majority Delay", 1, 25, 170, 220, 25);
	AddMenuItem(MDelay,0,"+10s");
	AddMenuItem(MDelay,0,"+60s");
	AddMenuItem(MDelay,0,"-10s");
	AddMenuItem(MDelay,0,"-60s");
	AddMenuItem(MDelay,0,"Back");
	if(MajorityDelay == 0) format(ystring,sizeof(ystring),"Delay: disabled");
	else format(ystring,sizeof(ystring),"Delay: %ds",MajorityDelay);
	SetMenuColumnHeader(MDelay,0,ystring);
}
//==============================================================================
public CreateStreamPickup(model,type,Float:x,Float:y,Float:z,range)
{
	new FoundID = 0;
	new ID;

	for ( new i = 0; FoundID <= 0 ; i++)
	{
	    if( Pickup[i][pickupCreated] == 0 )
	    {
	        if( FoundID == 0 )
	        {
	     	   ID = i;
	     	   FoundID = 1;
	        }
	    }
	    if( i > MAX_S_PICKUPS )
	    {
		    FoundID = 2;
		}
	}
	if( FoundID == 2 )
	{
	    print("(ERROR) Pickup limit reached. Pickup not created");
	    return -1;
	}
	Pickup[ID][pickupCreated] = 1;
	Pickup[ID][pickupVisible] = 0;
	Pickup[ID][pickupModel] = model;
	Pickup[ID][pickupType] = type;
	Pickup[ID][pickupX] = x;
	Pickup[ID][pickupY] = y;
	Pickup[ID][pickupZ] = z;
	Pickup[ID][pickupRange] = range;
	return ID;

}

public DestroyStreamPickup(ID)
{
	if(Pickup[ID][pickupCreated])
	{
		DestroyPickup(Pickup[ID][pickupID]);
		Pickup[ID][pickupCreated] = 0;
		return 1;
	}
	return 0;
}

public CountStreamPickups()
{
	new count = 0;
	for(new i = 0; i < MAX_S_PICKUPS; i++)
	{
	    if(Pickup[i][pickupCreated] == 1)
	    {
			count++;
	    }
	}
	return count;
}

public StreamPickups()
{
	for(new i = 0; i < MAX_S_PICKUPS; i++)
	{
	    if(Pickup[i][pickupCreated] == 1)
	    {
			if(Pickup_AnyPlayerToPoint(Pickup[i][pickupRange],Pickup[i][pickupX],Pickup[i][pickupY],Pickup[i][pickupZ]))
			{
			    if(Pickup[i][pickupVisible] == 0)
			    {
			        Pickup[i][pickupID] = CreatePickup(Pickup[i][pickupModel],Pickup[i][pickupType],Pickup[i][pickupX],Pickup[i][pickupY],Pickup[i][pickupZ]);
			        Pickup[i][pickupVisible] = 1;
				}
			}
			else
			{
			    if(Pickup[i][pickupVisible] == 1)
			    {
			        DestroyPickup(Pickup[i][pickupID]);
					Pickup[i][pickupVisible] = 0;
			    }
			}
	    }
	}
}

public MoveStreamPickup(ID,Float:x,Float:y,Float:z)
{
	if(Pickup[ID][pickupCreated])
	{
	    DestroyPickup(Pickup[ID][pickupID]);
	    Pickup[ID][pickupVisible] = 0;
		Pickup[ID][pickupX] = x;
		Pickup[ID][pickupY] = y;
		Pickup[ID][pickupZ] = z;
		return 1;
	}
	return 0;
}

public ChangeStreamPickupModel(ID,newmodel)
{
    if(Pickup[ID][pickupCreated])
	{
	    DestroyPickup(Pickup[ID][pickupID]);
	    Pickup[ID][pickupVisible] = 0;
		Pickup[ID][pickupModel] = newmodel;
		return 1;
	}
	return 0;
}

public ChangeStreamPickupType(ID,newtype)
{
    if(Pickup[ID][pickupCreated])
	{
	    DestroyPickup(Pickup[ID][pickupID]);
	    Pickup[ID][pickupVisible] = 0;
		Pickup[ID][pickupType] = newtype;
		return 1;
	}
	return 0;
}

public Pickup_AnyPlayerToPoint(Float:radi, Float:x, Float:y, Float:z)
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
		{
			new Float:oldposx, Float:oldposy, Float:oldposz;
			new Float:tempposx, Float:tempposy, Float:tempposz;
			GetPlayerPos(i, oldposx, oldposy, oldposz);
			tempposx = (oldposx -x);
			tempposy = (oldposy -y);
			tempposz = (oldposz -z);
			if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
			{
				return 1;
			}
		}
	}
    return 0;
}

public PickupGametexts()
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new string[128];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			GetPlayerPos(i, oldposx, oldposy, oldposz);
			if(oldposx!=0.0 && oldposy!=0.0 && oldposz!=0.0)
			{
				for(new h = 0; h < sizeof(Building); h++)
				{
					if (PlayerToPoint(1.0,i,Building[h][EnterX], Building[h][EnterY], Building[h][EnterZ]))
					{
					if(GetPlayerCash(i) >= Building[h][EntranceFee])
					{
					    if(Building[h][EntranceFee] > 1)
					    {
					    	format(string, sizeof(string), "%s~n~~w~Entrance Fee: ~g~$%d",Building[h][BuildingName],Building[h][EntranceFee]);
					    	GameTextForPlayer(i, string, 3500, 3);
						}
						else
						{
							format(string, sizeof(string), "%s",Building[h][BuildingName]);
							GameTextForPlayer(i, string, 3500, 3);
						}
					}
					else
					{
         				if(Building[h][EntranceFee] > 1)
         				{
         					format(string, sizeof(string), "%s~n~~w~Entrance Fee: ~r~$%d",Building[h][BuildingName],Building[h][EntranceFee]);
         					GameTextForPlayer(i, string, 3500, 3);
         				}
         				else
         				{
         					format(string, sizeof(string), "%s",Building[h][BuildingName]);
         					GameTextForPlayer(i, string, 3500, 3);
         				}
			  		}
					}
				}
				for(new n = 0; n < sizeof(Houses); n++)
				{
					if (PlayerToPoint(1.0,i,Houses[n][EnterX], Houses[n][EnterY], Houses[n][EnterZ]))
					{
					    if(Houses[n][HousePrice] != 0)
					    {
						    if(Houses[n][Owned] == 0)
						    {
			    				new houselocation[MAX_ZONE_NAME];
								GetCoords2DZone(Houses[n][EnterX],Houses[n][EnterY], houselocation, MAX_ZONE_NAME);
								format(string, sizeof(string), "~g~This house is for sale!~n~~w~Address: ~y~ %d %s~n~~w~Description: ~y~%s ~n~~w~Price: ~y~$%d~n~%s",n,houselocation,Houses[n][Description],Houses[n][HousePrice]);
						    	GameTextForPlayer(i, string, 3500, 3);
							}
							else
							{
							    if(Houses[n][Rentable] == 1)
							    {
		   							new houselocation[MAX_ZONE_NAME];
									GetCoords2DZone(Houses[n][EnterX],Houses[n][EnterY], houselocation, MAX_ZONE_NAME);
			    					format(string, sizeof(string), "~w~Address: ~y~%d %s~n~~w~Owner: ~y~%s ~n~~w~Description: ~y~%s~n~~w~Rent Price: ~y~$%d",n,houselocation,Houses[n][Owner],Houses[n][Description],Houses[n][RentCost]);
							    	GameTextForPlayer(i, string, 3500, 3);
							    }
							    else
							    {
		  							new houselocation[MAX_ZONE_NAME];
									GetCoords2DZone(Houses[n][EnterX],Houses[n][EnterY], houselocation, MAX_ZONE_NAME);
			    					format(string, sizeof(string), "~w~Address: ~y~%d %s~n~~w~Owner: ~y~%s ~n~~w~Description: ~y~%s",n,houselocation,Houses[n][Owner],Houses[n][Description]);
							    	GameTextForPlayer(i, string, 3500, 3);
						    	}
							}
						}
					}
				}
				for(new n = 0; n < sizeof(Businesses); n++)
				{
					if (PlayerToPoint(1.0,i,Businesses[n][EnterX], Businesses[n][EnterY], Businesses[n][EnterZ]))
					{
					    new businesstype[128];
					    if(Businesses[n][BizType] != 0)
					    {
	    					if(Businesses[n][BizType] == 1) { businesstype = "Restaurant"; }
						    else if(Businesses[n][BizType] == 2) { businesstype = "Phone Company"; }
						    else if(Businesses[n][BizType] == 3) { businesstype = "24-7 Store"; }
						    else if(Businesses[n][BizType] == 4) { businesstype = "Ammunation"; }
						    else if(Businesses[n][BizType] == 5) { businesstype = "Advertising"; }
						    else if(Businesses[n][BizType] == 6) { businesstype = "Clothes Store"; }
						    else if(Businesses[n][BizType] == 7) { businesstype = "Bar/Club"; }
					    }
					    else { businesstype = "None Set"; }

					    if(Businesses[n][BizPrice] != 0)
					    {
						    if(Businesses[n][Owned] == 0)
						    {
								format(string, sizeof(string), "~g~This business is for sale!~n~~w~Business Name: ~y~%s ~n~~w~Business Type: ~y~%s ~n~~w~Price: ~y~$%d",Businesses[n][BusinessName],businesstype,Businesses[n][BizPrice]);
						    	GameTextForPlayer(i, string, 3500, 3);
							}
							else
							{
	  							format(string, sizeof(string), "~w~Business Name: ~y~%s ~n~~w~Business Type: ~y~%s ~n~~w~Owner: ~y~%s~n~~w~Entrance Fee: ~y~$%d",Businesses[n][BusinessName],businesstype,Businesses[n][Owner],Businesses[n][EntranceCost]);
					    		GameTextForPlayer(i, string, 3500, 3);
							}
						}
					}
				}
    			if(ShowFuel[i] && GetPlayerState(i) == PLAYER_STATE_DRIVER)
    			{
    			    new form[128];
    				new vehicle = GetPlayerVehicleID(i);
    				if(!OutOfFuel[i])
    				{
	    				if(Fuel[vehicle] <= 10)
	    				{
	    				    if(EngineStatus[vehicle])
	    				    {
	   	    					format(form, sizeof(form), "~w~~n~~n~~n~~n~~n~~n~~y~Engine running~n~~w~Fuel:~g~ %d%~n~~r~Low Fuel",Fuel[vehicle]);
		    					GameTextForPlayer(i,form,1000,5);
	    				    }
	    				    else
	    				    {
	   	    					format(form, sizeof(form), "~w~~n~~n~~n~~n~~n~~n~~y~Engine not running~n~~w~Fuel:~g~ %d%~n~~r~Low Fuel",Fuel[vehicle]);
		    					GameTextForPlayer(i,form,1000,5);
	    				    }
	    				}
	  					else
	  					{
	  					    if(EngineStatus[vehicle])
	  					    {
		  						format(form, sizeof(form), "~w~~n~~n~~n~~n~~n~~n~~y~Engine running~n~~w~Fuel:~g~ %d%",Fuel[vehicle]);
		  						GameTextForPlayer(i,form,1000,5);
	  						}
	  						else
	  						{
	  							format(form, sizeof(form), "~w~~n~~n~~n~~n~~n~~n~~y~Engine not running~n~~w~Fuel:~g~ %d%",Fuel[vehicle]);
		  						GameTextForPlayer(i,form,1000,5);
	  						}
	  					}
  					}
  				}
				if (PlayerToPoint(1.0,i,DrivingTestPosition[X],DrivingTestPosition[Y],DrivingTestPosition[Z]))
				{
				    if(GetPlayerVirtualWorld(i) == DrivingTestPosition[World])
				    {
						GameTextForPlayer(i, "~w~Driving Test~n~Price: ~g~$3500~n~~w~Type /takedrivingtest now", 3500, 3);
					}
				}
				else if(PlayerToPoint(1.0,i,FlyingTestPosition[X],FlyingTestPosition[Y],FlyingTestPosition[Z]))
				{
    				if(GetPlayerVirtualWorld(i) == FlyingTestPosition[World])
	     			{
						GameTextForPlayer(i, "~w~Flying License~n~Price: ~g~$10000~n~~w~Type /buyflyinglicense now", 3500, 3);
					}
				}
				else if(PlayerToPoint(1.0,i,WeaponLicensePosition[X],WeaponLicensePosition[Y],WeaponLicensePosition[Z]))
				{
    				if(GetPlayerVirtualWorld(i) == WeaponLicensePosition[World])
	     			{
						GameTextForPlayer(i, "~w~Weapon License~n~Price: ~g~$5000~n~~w~Type /buyweaponlicense now", 3500, 3);
					}
				}
				else if(PlayerToPoint(1.0,i,BankPosition[X],BankPosition[Y],BankPosition[Z]))
				{
    				if(GetPlayerVirtualWorld(i) == BankPosition[World])
	     			{
						GameTextForPlayer(i, "~w~The Bank", 3500, 3);
					}
				}
				else if(PlayerToPoint(1.0,i,FactionMaterialsStorage[X],FactionMaterialsStorage[Y],FactionMaterialsStorage[Z]))
				{
				    if(PlayerInfo[i][pFaction] != 255 && DynamicFactions[PlayerInfo[i][pFaction]][fType] != 1)
				    {
				    	GameTextForPlayer(i, "~w~Faction Materials Storage", 3500, 3);
				    }
				    else
				    {
				    	GameTextForPlayer(i, "~r~Unknown", 3500, 3);
				    }
				}
				else if(PlayerToPoint(1.0,i,FactionDrugsStorage[X],FactionDrugsStorage[Y],FactionDrugsStorage[Z]))
				{
				    if(PlayerInfo[i][pFaction] != 255 && DynamicFactions[PlayerInfo[i][pFaction]][fType] != 1)
				    {
   						GameTextForPlayer(i, "~w~Faction Drugs Storage", 3500, 3);
				    }
				    else
				    {
				    	GameTextForPlayer(i, "~r~Unknown", 3500, 3);
				    }
				}
    			else if(PlayerToPoint(1.0,i,GunJob[TakeJobX],GunJob[TakeJobY],GunJob[TakeJobZ]))
				{
				    if(GetPlayerVirtualWorld(i) == GunJob[TakeJobWorld])
				    {
   						GameTextForPlayer(i, "~n~~r~Arms Dealer Job~n~~w~/takejob", 3500, 3);
   					}
				}
				else if(PlayerToPoint(1.0,i,GunJob[BuyPackagesX],GunJob[BuyPackagesY],GunJob[BuyPackagesZ]))
				{
				    if(GetPlayerVirtualWorld(i) == GunJob[BuyPackagesWorld])
				    {
   						GameTextForPlayer(i, "~n~~r~Arms Dealer Job~n~~w~/materials buy", 3500, 3);
   					}
				}
    			else if(PlayerToPoint(1.0,i,GunJob[DeliverX],GunJob[DeliverY],GunJob[DeliverZ]))
				{
				    if(GetPlayerVirtualWorld(i) == GunJob[DeliverWorld])
				    {
   						GameTextForPlayer(i, "~n~~r~Arms Dealer Job~n~~w~/materials dropoff", 3500, 3);
   					}
				}
 				else if(PlayerToPoint(1.0,i,DrugJob[TakeJobX],DrugJob[TakeJobY],DrugJob[TakeJobZ]))
				{
				    if(GetPlayerVirtualWorld(i) == DrugJob[TakeJobWorld])
				    {
   						GameTextForPlayer(i, "~n~~r~Drug Dealer Job~n~~w~/takejob", 3500, 3);
   					}
				}
				else if(PlayerToPoint(1.0,i,DrugJob[BuyDrugsX],DrugJob[BuyDrugsY],DrugJob[BuyDrugsZ]))
				{
				    if(GetPlayerVirtualWorld(i) == DrugJob[BuyDrugsWorld])
				    {
   						GameTextForPlayer(i, "~n~~r~Drug Dealer Job~n~~w~/drugs buy", 3500, 3);
   					}
				}
    			else if(PlayerToPoint(1.0,i,DrugJob[DeliverX],DrugJob[DeliverY],DrugJob[DeliverZ]))
				{
				    if(GetPlayerVirtualWorld(i) == DrugJob[DeliverWorld])
				    {
   						GameTextForPlayer(i, "~n~~r~Drug Dealer Job~n~~w~/drugs dropoff", 3500, 3);
   					}
				}
				else if(PlayerToPoint(1.0,i,DetectiveJobPosition[X],DetectiveJobPosition[Y],DetectiveJobPosition[Z]))
				{
				    if(GetPlayerVirtualWorld(i) == DetectiveJobPosition[World])
				    {
   						GameTextForPlayer(i, "~n~~r~Detective Job~n~~w~/takejob", 3500, 3);
   					}
				}
    			else if(PlayerToPoint(1.0,i,LawyerJobPosition[X],LawyerJobPosition[Y],LawyerJobPosition[Z]))
				{
				    if(GetPlayerVirtualWorld(i) == LawyerJobPosition[World])
				    {
   						GameTextForPlayer(i, "~n~~r~Lawyer Job~n~~w~/takejob", 3500, 3);
   					}
				}
				else if(PlayerToPoint(1.0,i,ProductsSellerJob[TakeJobX],ProductsSellerJob[TakeJobY],ProductsSellerJob[TakeJobZ]))
				{
				    if(GetPlayerVirtualWorld(i) == ProductsSellerJob[TakeJobWorld])
				    {
   						GameTextForPlayer(i, "~n~~r~Products Seller Job~n~~w~/takejob", 3500, 3);
   					}
				}
    			else if(PlayerToPoint(1.0, i, MechanicJobPosition[X], MechanicJobPosition[Y], MechanicJobPosition[Z]))
				{
				    if(GetPlayerVirtualWorld(i) == MechanicJobPosition[World])
				    {
   						GameTextForPlayer(i, "~n~~r~Mechanic Job~n~~w~/takejob", 3500, 3);
   					}
				}
				else if(PlayerToPoint(1.0,i,ProductsSellerJob[BuyProductsX],ProductsSellerJob[BuyProductsY],ProductsSellerJob[BuyProductsZ]))
				{
				    if(GetPlayerVirtualWorld(i) == ProductsSellerJob[BuyProductsWorld])
				    {
   						GameTextForPlayer(i, "~n~~r~Products Seller Job~n~~w~/products buy", 3500, 3);
   					}
				}

			}
		}
	}
	return 1;
}
//==============================================================================
public AddsOn()
{
	adds=1;
	return 1;
}
//==============================================================================

otherstrtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

public split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
	    if(strsrc[i]==delimiter || i==strlen(strsrc)){
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}
//==============================================================================
stock GetCoords2DZone(Float:x, Float:y, zone[], len)
{
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}

stock GetPlayer2DZone(playerid, zone[], len)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}

stock GetPlayer3DZone(playerid, zone[], len)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4] && z >= gSAZones[i][SAZONE_AREA][2] && z <= gSAZones[i][SAZONE_AREA][5])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}

stock IsPlayerInZone(playerid, zone[])
{
	new TmpZone[MAX_ZONE_NAME];
	GetPlayer3DZone(playerid, TmpZone, sizeof(TmpZone));
	for(new i = 0; i != sizeof(gSAZones); i++)
	{
		if(strfind(TmpZone, zone, true) != -1)
			return 1;
	}
	return 0;
}

stock ini_GetKey( line[] )
{
	new keyRes[256];
	keyRes[0] = 0;
    if ( strfind( line , "=" , true ) == -1 ) return keyRes;
    strmid( keyRes , line , 0 , strfind( line , "=" , true ) , sizeof( keyRes) );
    return keyRes;
}

stock ini_GetValue( line[] )
{
	new valRes[256];
	valRes[0]=0;
	if ( strfind( line , "=" , true ) == -1 ) return valRes;
	strmid( valRes , line , strfind( line , "=" , true )+1 , strlen( line ) , sizeof( valRes ) );
	return valRes;
}

stock PlayerName(playerid) {
  new name[255];
  GetPlayerName(playerid, name, 255);
  return name;
}

stock IsValidSkin(skinid)
{
    #define	MAX_BAD_SKINS 35
    new badSkins[MAX_BAD_SKINS] =
    {
        0, 3, 4, 5, 6, 8, 10, 42, 65, 74,
		86, 92, 99, 119, 143, 144, 145, 146,
	 	149, 178, 208, 251, 252, 254, 264,
	 	265, 267, 273, 279, 277, 276, 274, 275,
	 	278, 289
    };
    if (skinid < 0 || skinid > 299) return false;
    for (new i = 0; i < MAX_BAD_SKINS; i++)
    {
        if (skinid == badSkins[i]) return false;
    }
    #undef MAX_BAD_SKINS
    return 1;
}

stock IsSkinValid(SkinID) return ((SkinID >= 0 && SkinID <= 1)||(SkinID == 2)||(SkinID == 7)||(SkinID >= 9 && SkinID <= 41)||(SkinID >= 43 && SkinID <= 85)||(SkinID >=87 && SkinID <= 118)||(SkinID >= 120 && SkinID <= 148)||(SkinID >= 150 && SkinID <= 207)||(SkinID >= 209 && SkinID <= 272)||(SkinID >= 274 && SkinID <= 288)||(SkinID >= 290 && SkinID <= 299)) ? true:false;

stock ClearScreen(playerid)
{
	for(new i = 0; i < 50; i++)
	{
	    SendClientMessage(playerid, COLOR_WHITE, " ");
	}
	return 0;
}

stock GetPlayerFirstName(playerid)
{
	new namestring[2][MAX_PLAYER_NAME];
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	split(name, namestring, '_');
	return namestring[0];
}

stock GetPlayerLastName(playerid)
{
	new namestring[2][MAX_PLAYER_NAME];
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	split(name, namestring, '_');
	return namestring[1];
}

stock GetVehicleCount()
{
	new count;
	for(new v = 1; v < MAX_VEHICLES; v++)
	{
		if (IsVehicleSpawned(v)) count++;
	}
	return count;
}

stock IsVehicleSpawned(vehicleid)
{
	new Float:VX,Float:VY,Float:VZ;
	GetVehiclePos(vehicleid,VX,VY,VZ);
	if (VX == 0.0 && VY == 0.0 && VZ == 0.0) return 0;
	return 1;
}

stock GetPlayerIpAddress(playerid)
{
	new IP[16];
	GetPlayerIp(playerid, IP, sizeof(IP));
	return IP;
}

RPName(name[],ret_first[],ret_last[])
{
	new len = strlen(name),
		point = -1,
		bool:done = false;
	for(new i = 0; i < len; i++)
	{
	    if(name[i] == '_')
	    {
	        if(point != -1) return 0;
	        else {
				if(i == 0) return 0;
				point = i + 1;
			}
	    } else if(point == -1) ret_first[i] = name[i];
	    else {
			ret_last[i - point] = name[i];
			done = true;
		}
	}
	if(!done) return 0;
	return 1;
}

stock GetPlayerNameEx(playerid)
{
    new string[24];
    GetPlayerName(playerid,string,24);
    new str[24];
    strmid(str,string,0,strlen(string),24);
    for(new i = 0; i < MAX_PLAYER_NAME; i++)
    {
        if (str[i] == '_') str[i] = ' ';
    }
    return str;
}

stock GetObjectCount()
{
	new count;
	for(new o; o < MAX_OBJECTS; o++)
	{
		if (IsValidObject(o)) count++;
	}
	return count;
}

ReturnUser(text[], playerid = INVALID_PLAYER_ID)
{
	new pos = 0;
	while (text[pos] < 0x21)
	{
		if (text[pos] == 0) return INVALID_PLAYER_ID;
		pos++;
	}
	new userid = INVALID_PLAYER_ID;
	if (IsNumeric(text[pos]))
	{
		userid = strval(text[pos]);
		if (userid >=0 && userid < MAX_PLAYERS)
		{
			if(!IsPlayerConnected(userid))
			{
				userid = INVALID_PLAYER_ID;
			}
			else
			{
				return userid;
			}
		}
	}
	new len = strlen(text[pos]);
	new count = 0;
	new name[MAX_PLAYER_NAME];
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i, name, sizeof (name));
			if (strcmp(name, text[pos], true, len) == 0)
			{
				if (len == strlen(name))
				{
					return i;
				}
				else
				{
					count++;
					userid = i;
				}
			}
		}
	}
	if (count != 1)
	{
		if (playerid != INVALID_PLAYER_ID)
		{
			if (count)
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) Multiple players found, please narrow search");
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "(ERROR) No matching player found");
			}
		}
		userid = INVALID_PLAYER_ID;
	}
	return userid;
}

IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

stock ShowServerPassword()
{
	new pass[128];
	if (strlen(PASSWORD) != 0)
	{
		format(pass, sizeof pass, "%s", PASSWORD);
	}
	else
	{
	    pass = "None";
	}
	return pass;
}
//==============================================================================
stock GivePlayerCash(playerid, money)
{
	PlayerInfo[playerid][pCash] += money;
	ResetMoneyBar(playerid);
	UpdateMoneyBar(playerid,PlayerInfo[playerid][pCash]);
	return PlayerInfo[playerid][pCash];
}

stock SetPlayerCash(playerid, money)
{
	PlayerInfo[playerid][pCash] = money;
	ResetMoneyBar(playerid);
	UpdateMoneyBar(playerid,PlayerInfo[playerid][pCash]);
	return PlayerInfo[playerid][pCash];
}

stock ResetPlayerCash(playerid)
{
	PlayerInfo[playerid][pCash] = 0;
	ResetMoneyBar(playerid);
	UpdateMoneyBar(playerid,PlayerInfo[playerid][pCash]);
	return PlayerInfo[playerid][pCash];
}

stock GetPlayerCash(playerid)
{
	return PlayerInfo[playerid][pCash];
}
//==============================================================================
stock StopMusic(playerid)
{
	PlayerPlaySound(playerid, 1069, 0.0, 0.0, 0.0);
}
//==============================================================================
public LoadProductsSellerJob()
{
	new arrCoords[14][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Jobs/productsellersjob.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		ProductsSellerJob[TakeJobX] = floatstr(arrCoords[0]);
		ProductsSellerJob[TakeJobY] = floatstr(arrCoords[1]);
		ProductsSellerJob[TakeJobZ] = floatstr(arrCoords[2]);
		ProductsSellerJob[TakeJobWorld] = strval(arrCoords[3]);
		ProductsSellerJob[TakeJobInterior] = strval(arrCoords[4]);
		ProductsSellerJob[TakeJobAngle] = floatstr(arrCoords[5]);
		ProductsSellerJob[TakeJobPickupID] = strval(arrCoords[6]);
        ProductsSellerJob[TakeJobPickupID] = CreateStreamPickup(1239,1,ProductsSellerJob[TakeJobX],ProductsSellerJob[TakeJobY],ProductsSellerJob[TakeJobZ],PICKUP_RANGE);
		ProductsSellerJob[BuyProductsX] = floatstr(arrCoords[7]);
		ProductsSellerJob[BuyProductsY] = floatstr(arrCoords[8]);
		ProductsSellerJob[BuyProductsZ] = floatstr(arrCoords[9]);
		ProductsSellerJob[BuyProductsWorld] = strval(arrCoords[10]);
		ProductsSellerJob[BuyProductsInterior] = strval(arrCoords[11]);
		ProductsSellerJob[BuyProductsAngle] = floatstr(arrCoords[12]);
		ProductsSellerJob[BuyProductsPickupID] = strval(arrCoords[13]);
        ProductsSellerJob[BuyProductsPickupID] = CreateStreamPickup(1239,1,ProductsSellerJob[BuyProductsX],ProductsSellerJob[BuyProductsY],ProductsSellerJob[BuyProductsZ],PICKUP_RANGE);
        print("(INFO) Products seller job loaded");
	}
	fclose(file);
	return 1;
}

public SaveProductsSellerJob()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d|%f|%f|%f|%d|%d|%f|%d\n",
	ProductsSellerJob[TakeJobX],
	ProductsSellerJob[TakeJobY],
	ProductsSellerJob[TakeJobZ],
	ProductsSellerJob[TakeJobWorld],
	ProductsSellerJob[TakeJobInterior],
	ProductsSellerJob[TakeJobAngle],
	ProductsSellerJob[TakeJobPickupID],
	ProductsSellerJob[BuyProductsX],
	ProductsSellerJob[BuyProductsY],
	ProductsSellerJob[BuyProductsZ],
	ProductsSellerJob[BuyProductsWorld],
	ProductsSellerJob[BuyProductsInterior],
	ProductsSellerJob[BuyProductsAngle],
	ProductsSellerJob[BuyProductsPickupID]);

	file2 = fopen("New York Roleplay/Jobs/productsellersjob.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}

public LoadGunJob()
{
	new arrCoords[21][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Jobs/gunjob.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		GunJob[TakeJobX] = floatstr(arrCoords[0]);
		GunJob[TakeJobY] = floatstr(arrCoords[1]);
		GunJob[TakeJobZ] = floatstr(arrCoords[2]);
		GunJob[TakeJobWorld] = strval(arrCoords[3]);
		GunJob[TakeJobInterior] = strval(arrCoords[4]);
		GunJob[TakeJobAngle] = floatstr(arrCoords[5]);
		GunJob[TakeJobPickupID] = strval(arrCoords[6]);
        GunJob[TakeJobPickupID] = CreateStreamPickup(1239,1,GunJob[TakeJobX],GunJob[TakeJobY],GunJob[TakeJobZ],PICKUP_RANGE);
		GunJob[BuyPackagesX] = floatstr(arrCoords[7]);
		GunJob[BuyPackagesY] = floatstr(arrCoords[8]);
		GunJob[BuyPackagesZ] = floatstr(arrCoords[9]);
		GunJob[BuyPackagesWorld] = strval(arrCoords[10]);
		GunJob[BuyPackagesInterior] = strval(arrCoords[11]);
		GunJob[BuyPackagesAngle] = floatstr(arrCoords[12]);
		GunJob[BuyPackagesPickupID] = strval(arrCoords[13]);
        GunJob[BuyPackagesPickupID] = CreateStreamPickup(1239,1,GunJob[BuyPackagesX],GunJob[BuyPackagesY],GunJob[BuyPackagesZ],PICKUP_RANGE);
        GunJob[DeliverX] = floatstr(arrCoords[14]);
		GunJob[DeliverY] = floatstr(arrCoords[15]);
		GunJob[DeliverZ] = floatstr(arrCoords[16]);
		GunJob[DeliverWorld] = strval(arrCoords[17]);
		GunJob[DeliverInterior] = strval(arrCoords[18]);
		GunJob[DeliverAngle] = floatstr(arrCoords[19]);
		GunJob[DeliverPickupID] = strval(arrCoords[20]);
        GunJob[DeliverPickupID] = CreateStreamPickup(1239,1,GunJob[DeliverX],GunJob[DeliverY],GunJob[DeliverZ],PICKUP_RANGE);
        print("(INFO) Gun job loaded");
	}
	fclose(file);
	return 1;
}

public SaveGunJob()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d|%f|%f|%f|%d|%d|%f|%d|%f|%f|%f|%d|%d|%f|%d\n",
	GunJob[TakeJobX],
	GunJob[TakeJobY],
	GunJob[TakeJobZ],
	GunJob[TakeJobWorld],
	GunJob[TakeJobInterior],
	GunJob[TakeJobAngle],
	GunJob[TakeJobPickupID],
	GunJob[BuyPackagesX],
	GunJob[BuyPackagesY],
	GunJob[BuyPackagesZ],
	GunJob[BuyPackagesWorld],
	GunJob[BuyPackagesInterior],
	GunJob[BuyPackagesAngle],
	GunJob[BuyPackagesPickupID],
	GunJob[DeliverX],
	GunJob[DeliverY],
	GunJob[DeliverZ],
	GunJob[DeliverWorld],
	GunJob[DeliverInterior],
	GunJob[DeliverAngle],
	GunJob[DeliverPickupID]);

	file2 = fopen("New York Roleplay/Jobs/gunjob.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}

public LoadDrugJob()
{
	new arrCoords[21][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Jobs/drugjob.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		DrugJob[TakeJobX] = floatstr(arrCoords[0]);
		DrugJob[TakeJobY] = floatstr(arrCoords[1]);
		DrugJob[TakeJobZ] = floatstr(arrCoords[2]);
		DrugJob[TakeJobWorld] = strval(arrCoords[3]);
		DrugJob[TakeJobInterior] = strval(arrCoords[4]);
		DrugJob[TakeJobAngle] = floatstr(arrCoords[5]);
		DrugJob[TakeJobPickupID] = strval(arrCoords[6]);
        DrugJob[TakeJobPickupID] = CreateStreamPickup(1239,1,DrugJob[TakeJobX],DrugJob[TakeJobY],DrugJob[TakeJobZ],PICKUP_RANGE);
		DrugJob[BuyDrugsX] = floatstr(arrCoords[7]);
		DrugJob[BuyDrugsY] = floatstr(arrCoords[8]);
		DrugJob[BuyDrugsZ] = floatstr(arrCoords[9]);
		DrugJob[BuyDrugsWorld] = strval(arrCoords[10]);
		DrugJob[BuyDrugsInterior] = strval(arrCoords[11]);
		DrugJob[BuyDrugsAngle] = floatstr(arrCoords[12]);
		DrugJob[BuyDrugsPickupID] = strval(arrCoords[13]);
        DrugJob[BuyDrugsPickupID] = CreateStreamPickup(1239,1,DrugJob[BuyDrugsX],DrugJob[BuyDrugsY],DrugJob[BuyDrugsZ],PICKUP_RANGE);
        DrugJob[DeliverX] = floatstr(arrCoords[14]);
		DrugJob[DeliverY] = floatstr(arrCoords[15]);
		DrugJob[DeliverZ] = floatstr(arrCoords[16]);
		DrugJob[DeliverWorld] = strval(arrCoords[17]);
		DrugJob[DeliverInterior] = strval(arrCoords[18]);
		DrugJob[DeliverAngle] = floatstr(arrCoords[19]);
		DrugJob[DeliverPickupID] = strval(arrCoords[20]);
        DrugJob[DeliverPickupID] = CreateStreamPickup(1239,1,DrugJob[DeliverX],DrugJob[DeliverY],DrugJob[DeliverZ],PICKUP_RANGE);
        print("(INFO) Drug job loaded");
	}
	fclose(file);
	return 1;
}

public SaveDrugJob()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d|%f|%f|%f|%d|%d|%f|%d|%f|%f|%f|%d|%d|%f|%d\n",
	DrugJob[TakeJobX],
	DrugJob[TakeJobY],
	DrugJob[TakeJobZ],
	DrugJob[TakeJobWorld],
	DrugJob[TakeJobInterior],
	DrugJob[TakeJobAngle],
	DrugJob[TakeJobPickupID],
	DrugJob[BuyDrugsX],
	DrugJob[BuyDrugsY],
	DrugJob[BuyDrugsZ],
	DrugJob[BuyDrugsWorld],
	DrugJob[BuyDrugsInterior],
	DrugJob[BuyDrugsAngle],
	DrugJob[BuyDrugsPickupID],
	DrugJob[DeliverX],
	DrugJob[DeliverY],
	DrugJob[DeliverZ],
	DrugJob[DeliverWorld],
	DrugJob[DeliverInterior],
	DrugJob[DeliverAngle],
	DrugJob[DeliverPickupID]);

	file2 = fopen("New York Roleplay/Jobs/drugjob.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}

public LoadDetectiveJob()
{
	new arrCoords[7][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Jobs/detectivejob.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		DetectiveJobPosition[X] = floatstr(arrCoords[0]);
		DetectiveJobPosition[Y] = floatstr(arrCoords[1]);
		DetectiveJobPosition[Z] = floatstr(arrCoords[2]);
		DetectiveJobPosition[World] = strval(arrCoords[3]);
		DetectiveJobPosition[Interior] = strval(arrCoords[4]);
		DetectiveJobPosition[Angle] = floatstr(arrCoords[5]);
		DetectiveJobPosition[PickupID] = strval(arrCoords[6]);
		DetectiveJobPosition[PickupID] = CreateStreamPickup(1239,1,DetectiveJobPosition[X],DetectiveJobPosition[Y],DetectiveJobPosition[Z],PICKUP_RANGE);
        print("(INFO) Detective job loaded");
	}
	fclose(file);
	return 1;
}

public SaveDetectiveJob()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d\n",
	DetectiveJobPosition[X],
	DetectiveJobPosition[Y],
	DetectiveJobPosition[Z],
	DetectiveJobPosition[World],
	DetectiveJobPosition[Interior],
	DetectiveJobPosition[Angle],
	DetectiveJobPosition[PickupID]);
	file2 = fopen("New York Roleplay/Jobs/detectivejob.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}

public LoadLawyerJob()
{
	new arrCoords[7][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Jobs/lawyerjob.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		LawyerJobPosition[X] = floatstr(arrCoords[0]);
		LawyerJobPosition[Y] = floatstr(arrCoords[1]);
		LawyerJobPosition[Z] = floatstr(arrCoords[2]);
		LawyerJobPosition[World] = strval(arrCoords[3]);
		LawyerJobPosition[Interior] = strval(arrCoords[4]);
		LawyerJobPosition[Angle] = floatstr(arrCoords[5]);
		LawyerJobPosition[PickupID] = strval(arrCoords[6]);
		LawyerJobPosition[PickupID] = CreateStreamPickup(1239,1,LawyerJobPosition[X],LawyerJobPosition[Y],LawyerJobPosition[Z],PICKUP_RANGE);
        print("(INFO) Lawyer job loaded");
	}
	fclose(file);
	return 1;
}

public SaveLawyerJob()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d\n",
	LawyerJobPosition[X],
	LawyerJobPosition[Y],
	LawyerJobPosition[Z],
	LawyerJobPosition[World],
	LawyerJobPosition[Interior],
	LawyerJobPosition[Angle],
	LawyerJobPosition[PickupID]);
	file2 = fopen("New York Roleplay/Jobs/lawyerjob.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}

public LoadMechanicJob()
{
	new arrCoords[7][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Jobs/mechanicjob.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		MechanicJobPosition[X] = floatstr(arrCoords[0]);
		MechanicJobPosition[Y] = floatstr(arrCoords[1]);
		MechanicJobPosition[Z] = floatstr(arrCoords[2]);
		MechanicJobPosition[World] = strval(arrCoords[3]);
		MechanicJobPosition[Interior] = strval(arrCoords[4]);
		MechanicJobPosition[Angle] = floatstr(arrCoords[5]);
		MechanicJobPosition[PickupID] = strval(arrCoords[6]);
		//Creating Pickup
		MechanicJobPosition[PickupID] = CreateStreamPickup(1239,1,MechanicJobPosition[X],MechanicJobPosition[Y],MechanicJobPosition[Z],PICKUP_RANGE);
        print("(INFO) Mechanic job loaded");
	}
	fclose(file);
	return 1;
}

public SaveMechanicJob()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d\n",
	MechanicJobPosition[X],
	MechanicJobPosition[Y],
	MechanicJobPosition[Z],
	MechanicJobPosition[World],
	MechanicJobPosition[Interior],
	MechanicJobPosition[Angle],
	MechanicJobPosition[PickupID]);
	file2 = fopen("New York Roleplay/Jobs/mechanicjob.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}
//==============================================================================
public LoadBankPosition()
{
	new arrCoords[7][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Locations/banklocation.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		BankPosition[X] = floatstr(arrCoords[0]);
		BankPosition[Y] = floatstr(arrCoords[1]);
		BankPosition[Z] = floatstr(arrCoords[2]);
		BankPosition[World] = strval(arrCoords[3]);
		BankPosition[Interior] = strval(arrCoords[4]);
		BankPosition[Angle] = floatstr(arrCoords[5]);
		BankPosition[PickupID] = strval(arrCoords[6]);
		//Creating Pickup
        BankPosition[PickupID] = CreateStreamPickup(1239,1,BankPosition[X],BankPosition[Y],BankPosition[Z],PICKUP_RANGE);
        print("(INFO) Bank location loaded");
	}
	fclose(file);
	return 1;
}

public SaveBankPosition()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d\n",
	BankPosition[X],
	BankPosition[Y],
	BankPosition[Z],
	BankPosition[World],
	BankPosition[Interior],
	BankPosition[Angle],
	BankPosition[PickupID]);
	file2 = fopen("New York Roleplay/Locations/banklocation.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}

public LoadDrivingTestPosition()
{
	new arrCoords[7][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Locations/drivingtestlocation.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		DrivingTestPosition[X] = floatstr(arrCoords[0]);
		DrivingTestPosition[Y] = floatstr(arrCoords[1]);
		DrivingTestPosition[Z] = floatstr(arrCoords[2]);
		DrivingTestPosition[World] = strval(arrCoords[3]);
		DrivingTestPosition[Interior] = strval(arrCoords[4]);
		DrivingTestPosition[Angle] = floatstr(arrCoords[5]);
		DrivingTestPosition[PickupID] = strval(arrCoords[6]);
		//Creating Pickup
        DrivingTestPosition[PickupID] = CreateStreamPickup(1239,1,DrivingTestPosition[X],DrivingTestPosition[Y],DrivingTestPosition[Z],PICKUP_RANGE);
        print("(INFO) Driving test location loaded");
	}
	fclose(file);
	return 1;
}

public SaveDrivingTestPosition()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d\n",
	DrivingTestPosition[X],
	DrivingTestPosition[Y],
	DrivingTestPosition[Z],
	DrivingTestPosition[World],
	DrivingTestPosition[Interior],
	DrivingTestPosition[Angle],
	DrivingTestPosition[PickupID]);
	file2 = fopen("New York Roleplay/Locations/drivingtestlocation.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}

public LoadFlyingTestPosition()
{
	new arrCoords[7][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Locations/flyingtestlocation.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		FlyingTestPosition[X] = floatstr(arrCoords[0]);
		FlyingTestPosition[Y] = floatstr(arrCoords[1]);
		FlyingTestPosition[Z] = floatstr(arrCoords[2]);
		FlyingTestPosition[World] = strval(arrCoords[3]);
		FlyingTestPosition[Interior] = strval(arrCoords[4]);
		FlyingTestPosition[Angle] = floatstr(arrCoords[5]);
		FlyingTestPosition[PickupID] = strval(arrCoords[6]);
		//Creating Pickup
        FlyingTestPosition[PickupID] = CreateStreamPickup(1239,1,FlyingTestPosition[X],FlyingTestPosition[Y],FlyingTestPosition[Z],PICKUP_RANGE);
        print("(INFO) Flying test location loaded");
	}
	fclose(file);
	return 1;
}

public SaveFlyingTestPosition()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d\n",
	FlyingTestPosition[X],
	FlyingTestPosition[Y],
	FlyingTestPosition[Z],
	FlyingTestPosition[World],
	FlyingTestPosition[Interior],
	FlyingTestPosition[Angle],
	FlyingTestPosition[PickupID]);
	file2 = fopen("New York Roleplay/Locations/flyingtestlocation.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}

public LoadWeaponLicensePosition()
{
	new arrCoords[7][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Locations/weaponlicenselocation.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		WeaponLicensePosition[X] = floatstr(arrCoords[0]);
		WeaponLicensePosition[Y] = floatstr(arrCoords[1]);
		WeaponLicensePosition[Z] = floatstr(arrCoords[2]);
		WeaponLicensePosition[World] = strval(arrCoords[3]);
		WeaponLicensePosition[Interior] = strval(arrCoords[4]);
		WeaponLicensePosition[Angle] = floatstr(arrCoords[5]);
		WeaponLicensePosition[PickupID] = strval(arrCoords[6]);
		//Creating Pickup
        WeaponLicensePosition[PickupID] = CreateStreamPickup(1239,1,WeaponLicensePosition[X],WeaponLicensePosition[Y],WeaponLicensePosition[Z],PICKUP_RANGE);
        print("(INFO) Weapon License location loaded");
	}
	fclose(file);
	return 1;
}

public SaveWeaponLicensePosition()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d\n",
	WeaponLicensePosition[X],
	WeaponLicensePosition[Y],
	WeaponLicensePosition[Z],
	WeaponLicensePosition[World],
	WeaponLicensePosition[Interior],
	WeaponLicensePosition[Angle],
	WeaponLicensePosition[PickupID]);
	file2 = fopen("New York Roleplay/Locations/weaponlicenselocation.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}

public LoadPoliceArrestPosition()
{
	new arrCoords[6][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Locations/policearrestposition.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		PoliceArrestPosition[X] = floatstr(arrCoords[0]);
		PoliceArrestPosition[Y] = floatstr(arrCoords[1]);
		PoliceArrestPosition[Z] = floatstr(arrCoords[2]);
		PoliceArrestPosition[World] = strval(arrCoords[3]);
		PoliceArrestPosition[Interior] = strval(arrCoords[4]);
		PoliceArrestPosition[Angle] = floatstr(arrCoords[5]);
        print("(INFO) Police Arrest location loaded");
	}
	fclose(file);
	return 1;
}

public SavePoliceArrestPosition()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f\n",
	PoliceArrestPosition[X],
	PoliceArrestPosition[Y],
	PoliceArrestPosition[Z],
	PoliceArrestPosition[World],
	PoliceArrestPosition[Interior],
	PoliceArrestPosition[Angle]);
	file2 = fopen("New York Roleplay/Locations/policearrestposition.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}

public LoadGovernmentArrestPosition()
{
	new arrCoords[6][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Locations/governmentarrestposition.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		GovernmentArrestPosition[X] = floatstr(arrCoords[0]);
		GovernmentArrestPosition[Y] = floatstr(arrCoords[1]);
		GovernmentArrestPosition[Z] = floatstr(arrCoords[2]);
		GovernmentArrestPosition[World] = strval(arrCoords[3]);
		GovernmentArrestPosition[Interior] = strval(arrCoords[4]);
		GovernmentArrestPosition[Angle] = floatstr(arrCoords[5]);
        print("(INFO) Government Arrest location loaded");
	}
	fclose(file);
	return 1;
}

public SaveGovernmentArrestPosition()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f\n",
	GovernmentArrestPosition[X],
	GovernmentArrestPosition[Y],
	GovernmentArrestPosition[Z],
	GovernmentArrestPosition[World],
	GovernmentArrestPosition[Interior],
	GovernmentArrestPosition[Angle]);
	file2 = fopen("New York Roleplay/Locations/governmentarrestposition.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}

public LoadPoliceDutyPosition()
{
	new arrCoords[6][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Locations/policedutyposition.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		PoliceDutyPosition[X] = floatstr(arrCoords[0]);
		PoliceDutyPosition[Y] = floatstr(arrCoords[1]);
		PoliceDutyPosition[Z] = floatstr(arrCoords[2]);
		PoliceDutyPosition[World] = strval(arrCoords[3]);
		PoliceDutyPosition[Interior] = strval(arrCoords[4]);
		PoliceDutyPosition[Angle] = floatstr(arrCoords[5]);
        print("(INFO) Police Duty location loaded");
	}
	fclose(file);
	return 1;
}

public SavePoliceDutyPosition()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f\n",
	PoliceDutyPosition[X],
	PoliceDutyPosition[Y],
	PoliceDutyPosition[Z],
	PoliceDutyPosition[World],
	PoliceDutyPosition[Interior],
	PoliceDutyPosition[Angle]);
	file2 = fopen("New York Roleplay/Locations/policedutyposition.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}

public LoadGovernmentDutyPosition()
{
	new arrCoords[6][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Locations/governmentdutyposition.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		GovernmentDutyPosition[X] = floatstr(arrCoords[0]);
		GovernmentDutyPosition[Y] = floatstr(arrCoords[1]);
		GovernmentDutyPosition[Z] = floatstr(arrCoords[2]);
		GovernmentDutyPosition[World] = strval(arrCoords[3]);
		GovernmentDutyPosition[Interior] = strval(arrCoords[4]);
		GovernmentDutyPosition[Angle] = floatstr(arrCoords[5]);
        print("(INFO) Government Duty location loaded");
	}
	fclose(file);
	return 1;
}

public SaveGovernmentDutyPosition()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f\n",
	GovernmentDutyPosition[X],
	GovernmentDutyPosition[Y],
	GovernmentDutyPosition[Z],
	GovernmentDutyPosition[World],
	GovernmentDutyPosition[Interior],
	GovernmentDutyPosition[Angle]);
	file2 = fopen("New York Roleplay/Locations/governmentdutyposition.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}
//==============================================================================
public LoadFactionMaterialsStorage()
{
	new arrCoords[7][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Locations/factionmatsstorage.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		FactionMaterialsStorage[X] = floatstr(arrCoords[0]);
		FactionMaterialsStorage[Y] = floatstr(arrCoords[1]);
		FactionMaterialsStorage[Z] = floatstr(arrCoords[2]);
		FactionMaterialsStorage[World] = strval(arrCoords[3]);
		FactionMaterialsStorage[Interior] = strval(arrCoords[4]);
		FactionMaterialsStorage[Angle] = floatstr(arrCoords[5]);
		FactionMaterialsStorage[PickupID] = strval(arrCoords[6]);
		//Creating Pickup
        FactionMaterialsStorage[PickupID] = CreateStreamPickup(1254,1,FactionMaterialsStorage[X],FactionMaterialsStorage[Y],FactionMaterialsStorage[Z],PICKUP_RANGE);
        print("(INFO) Faction materials storage location loaded");
	}
	fclose(file);
	return 1;
}

public SaveFactionMaterialsStorage()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d\n",
	FactionMaterialsStorage[X],
	FactionMaterialsStorage[Y],
	FactionMaterialsStorage[Z],
	FactionMaterialsStorage[World],
	FactionMaterialsStorage[Interior],
	FactionMaterialsStorage[Angle],
	FactionMaterialsStorage[PickupID]);
	file2 = fopen("New York Roleplay/Locations/factionmatsstorage.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}

public LoadFactionDrugsStorage()
{
	new arrCoords[7][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Locations/factiondrugsstorage.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		FactionDrugsStorage[X] = floatstr(arrCoords[0]);
		FactionDrugsStorage[Y] = floatstr(arrCoords[1]);
		FactionDrugsStorage[Z] = floatstr(arrCoords[2]);
		FactionDrugsStorage[World] = strval(arrCoords[3]);
		FactionDrugsStorage[Interior] = strval(arrCoords[4]);
		FactionDrugsStorage[Angle] = floatstr(arrCoords[5]);
		FactionDrugsStorage[PickupID] = strval(arrCoords[6]);
		//Creating Pickup
        FactionDrugsStorage[PickupID] = CreateStreamPickup(1279,1,FactionDrugsStorage[X],FactionDrugsStorage[Y],FactionDrugsStorage[Z],PICKUP_RANGE);
        print("(INFO) Faction drugs storage location loaded");
	}
	fclose(file);
	return 1;
}

public SaveFactionDrugsStorage()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d\n",
	FactionDrugsStorage[X],
	FactionDrugsStorage[Y],
	FactionDrugsStorage[Z],
	FactionDrugsStorage[World],
	FactionDrugsStorage[Interior],
	FactionDrugsStorage[Angle],
	FactionDrugsStorage[PickupID]);
	file2 = fopen("New York Roleplay/Locations/factiondrugsstorage.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}
//==============================================================================
public LoadCivilianSpawn()
{
	new arrCoords[6][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Locations/civilianspawn.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		CivilianSpawn[X] = floatstr(arrCoords[0]);
		CivilianSpawn[Y] = floatstr(arrCoords[1]);
		CivilianSpawn[Z] = floatstr(arrCoords[2]);
		CivilianSpawn[World] = strval(arrCoords[3]);
		CivilianSpawn[Interior] = strval(arrCoords[4]);
		CivilianSpawn[Angle] = floatstr(arrCoords[5]);
	}
	fclose(file);
	return 1;
}

public SaveCivilianSpawn()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f\n",
	CivilianSpawn[X],
	CivilianSpawn[Y],
	CivilianSpawn[Z],
	CivilianSpawn[World],
	CivilianSpawn[Interior],
	CivilianSpawn[Angle]);
	file2 = fopen("New York Roleplay/Locations/civilianspawn.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}
//==============================================================================
public SaveBusinesses()
{
	new idx;
	new File: file2;
	while (idx < sizeof(Businesses))
	{
		new coordsstring[256];
		format(coordsstring, sizeof(coordsstring), "%s|%s|%f|%f|%f|%d|%d|%f|%f|%f|%f|%d|%f|%d|%d|%d|%d|%d|%d|%d|%d|%d\n",
		Businesses[idx][BusinessName],
		Businesses[idx][Owner],
		Businesses[idx][EnterX],
		Businesses[idx][EnterY],
		Businesses[idx][EnterZ],
		Businesses[idx][EnterWorld],
		Businesses[idx][EnterInterior],
		Businesses[idx][EnterAngle],
		Businesses[idx][ExitX],
		Businesses[idx][ExitY],
		Businesses[idx][ExitZ],
		Businesses[idx][ExitInterior],
		Businesses[idx][ExitAngle],
		Businesses[idx][Owned],
		Businesses[idx][Enterable],
		Businesses[idx][BizPrice],
		Businesses[idx][EntranceCost],
		Businesses[idx][Till],
		Businesses[idx][Locked],
		Businesses[idx][BizType],
		Businesses[idx][Products],
		Businesses[idx][PickupID]);

		if(idx == 0)
		{
			file2 = fopen("New York Roleplay/Businesses/businesses.cfg", io_write);
		}
		else
		{
			file2 = fopen("New York Roleplay/Businesses/businesses.cfg", io_append);
		}
		fwrite(file2, coordsstring);
		idx++;
		fclose(file2);
	}
	return 1;
}

public LoadBusinesses()
{
	new arrCoords[22][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Businesses/businesses.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(Businesses))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, '|');
			strmid(Businesses[idx][BusinessName], arrCoords[0], 0, strlen(arrCoords[0]), 255);
			strmid(Businesses[idx][Owner], arrCoords[1], 0, strlen(arrCoords[1]), 255);
			Businesses[idx][EnterX] = floatstr(arrCoords[2]);
			Businesses[idx][EnterY] = floatstr(arrCoords[3]);
			Businesses[idx][EnterZ] = floatstr(arrCoords[4]);
			Businesses[idx][EnterWorld] = strval(arrCoords[5]);
			Businesses[idx][EnterInterior] = strval(arrCoords[6]);
			Businesses[idx][EnterAngle] = floatstr(arrCoords[7]);
			Businesses[idx][ExitX] = floatstr(arrCoords[8]);
			Businesses[idx][ExitY] = floatstr(arrCoords[9]);
			Businesses[idx][ExitZ] = floatstr(arrCoords[10]);
			Businesses[idx][ExitInterior] = strval(arrCoords[11]);
			Businesses[idx][ExitAngle] = floatstr(arrCoords[12]);
			Businesses[idx][Owned] = strval(arrCoords[13]);
			Businesses[idx][Enterable] = strval(arrCoords[14]);
			Businesses[idx][BizPrice] = strval(arrCoords[15]);
			Businesses[idx][EntranceCost] = strval(arrCoords[16]);
			Businesses[idx][Till] = strval(arrCoords[17]);
			Businesses[idx][Locked] = strval(arrCoords[18]);
			Businesses[idx][BizType] = strval(arrCoords[19]);
			Businesses[idx][Products] = strval(arrCoords[20]);
			Businesses[idx][PickupID] = strval(arrCoords[21]);

			if(Businesses[idx][BizPrice] != 0)
			{
				if(Businesses[idx][Owned] == 0)
				{
					Businesses[idx][PickupID]=CreateStreamPickup(1272, 1, Businesses[idx][EnterX], Businesses[idx][EnterY], Businesses[idx][EnterZ],PICKUP_RANGE);
				}
				else if(Businesses[idx][Owned] == 1)
				{
				    Businesses[idx][PickupID]=CreateStreamPickup(1239, 1, Businesses[idx][EnterX], Businesses[idx][EnterY], Businesses[idx][EnterZ],PICKUP_RANGE);
				}
			}
			idx++;
		}
		fclose(file);
	}
	return 1;
}
//==============================================================================
public SaveHouses()
{
	new idx;
	new File: file2;
	while (idx < sizeof(Houses))
	{
		new coordsstring[256];
		format(coordsstring, sizeof(coordsstring), "%s|%s|%f|%f|%f|%d|%d|%f|%f|%f|%f|%d|%f|%d|%d|%d|%d|%d|%d|%d|%d|%d\n",
		Houses[idx][Description],
		Houses[idx][Owner],
		Houses[idx][EnterX],
		Houses[idx][EnterY],
		Houses[idx][EnterZ],
		Houses[idx][EnterWorld],
		Houses[idx][EnterInterior],
		Houses[idx][EnterAngle],
		Houses[idx][ExitX],
		Houses[idx][ExitY],
		Houses[idx][ExitZ],
		Houses[idx][ExitInterior],
		Houses[idx][ExitAngle],
		Houses[idx][Owned],
		Houses[idx][Rentable],
		Houses[idx][RentCost],
		Houses[idx][HousePrice],
		Houses[idx][Materials],
		Houses[idx][Drugs],
		Houses[idx][Money],
		Houses[idx][Locked],
		Houses[idx][PickupID]);

		if(idx == 0)
		{
			file2 = fopen("New York Roleplay/Houses/houses.cfg", io_write);
		}
		else
		{
			file2 = fopen("New York Roleplay/Houses/houses.cfg", io_append);
		}
		fwrite(file2, coordsstring);
		idx++;
		fclose(file2);
	}
	return 1;
}

public LoadHouses()
{
	new arrCoords[22][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Houses/houses.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(Houses))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, '|');
			strmid(Houses[idx][Description], arrCoords[0], 0, strlen(arrCoords[0]), 255);
			strmid(Houses[idx][Owner], arrCoords[1], 0, strlen(arrCoords[1]), 255);
			Houses[idx][EnterX] = floatstr(arrCoords[2]);
			Houses[idx][EnterY] = floatstr(arrCoords[3]);
			Houses[idx][EnterZ] = floatstr(arrCoords[4]);
			Houses[idx][EnterWorld] = strval(arrCoords[5]);
			Houses[idx][EnterInterior] = strval(arrCoords[6]);
			Houses[idx][EnterAngle] = floatstr(arrCoords[7]);
			Houses[idx][ExitX] = floatstr(arrCoords[8]);
			Houses[idx][ExitY] = floatstr(arrCoords[9]);
			Houses[idx][ExitZ] = floatstr(arrCoords[10]);
			Houses[idx][ExitInterior] = strval(arrCoords[11]);
			Houses[idx][ExitAngle] = floatstr(arrCoords[12]);
			Houses[idx][Owned] = strval(arrCoords[13]);
			Houses[idx][Rentable] = strval(arrCoords[14]);
			Houses[idx][RentCost] = strval(arrCoords[15]);
			Houses[idx][HousePrice] = strval(arrCoords[16]);
			Houses[idx][Materials] = strval(arrCoords[17]);
			Houses[idx][Drugs] = strval(arrCoords[18]);
			Houses[idx][Money] = strval(arrCoords[19]);
			Houses[idx][Locked] = strval(arrCoords[20]);
			Houses[idx][PickupID] = strval(arrCoords[21]);

			if(Houses[idx][HousePrice] != 0)
			{
				if(Houses[idx][Owned] == 0)
				{
					Houses[idx][PickupID] = CreateStreamPickup(1273, 1, Houses[idx][EnterX], Houses[idx][EnterY], Houses[idx][EnterZ],PICKUP_RANGE);
				}
				else if(Houses[idx][Owned] == 1)
				{
					Houses[idx][PickupID] = CreateStreamPickup(1239, 1, Houses[idx][EnterX], Houses[idx][EnterY], Houses[idx][EnterZ],PICKUP_RANGE);
				}
			}
			idx++;
		}
		fclose(file);
	}
	return 1;
}
//==============================================================================
public LoadBuildings()
{
	new arrCoords[15][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Buildings/buildings.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(Building))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, '|');
			strmid(Building[idx][BuildingName], arrCoords[0], 0, strlen(arrCoords[0]), 255);
			Building[idx][EnterX] = floatstr(arrCoords[1]);
			Building[idx][EnterY] = floatstr(arrCoords[2]);
			Building[idx][EnterZ] = floatstr(arrCoords[3]);
			Building[idx][EntranceFee] = strval(arrCoords[4]);
			Building[idx][EnterWorld] = strval(arrCoords[5]);
			Building[idx][EnterInterior] = strval(arrCoords[6]);
			Building[idx][EnterAngle] = floatstr(arrCoords[7]);
			Building[idx][ExitX] = floatstr(arrCoords[8]);
			Building[idx][ExitY] = floatstr(arrCoords[9]);
			Building[idx][ExitZ] = floatstr(arrCoords[10]);
			Building[idx][ExitInterior] = strval(arrCoords[11]);
			Building[idx][ExitAngle] = floatstr(arrCoords[12]);
			Building[idx][Locked] = strval(arrCoords[13]);
			Building[idx][PickupID] = strval(arrCoords[14]);

			Building[idx][PickupID] = CreateStreamPickup(1239, 1, Building[idx][EnterX], Building[idx][EnterY], Building[idx][EnterZ],PICKUP_RANGE);

			printf("(BUILDING SYST.) Building Name: %s - Loaded. (%d)",Building[idx][BuildingName],idx);
			idx++;
		}
		fclose(file);
	}
	return 1;
}

public SaveBuildings()
{
	new idx;
	new File: file2;
	while (idx < sizeof(Building))
	{

		new coordsstring[512];
		format(coordsstring, sizeof(coordsstring), "%s|%f|%f|%f|%d|%d|%d|%f|%f|%f|%f|%d|%f|%d|%d\n",
		Building[idx][BuildingName],
		Building[idx][EnterX],
		Building[idx][EnterY],
		Building[idx][EnterZ],
		Building[idx][EntranceFee],
		Building[idx][EnterWorld],
		Building[idx][EnterInterior],
		Building[idx][EnterAngle],
		Building[idx][ExitX],
		Building[idx][ExitY],
		Building[idx][ExitZ],
		Building[idx][ExitInterior],
		Building[idx][ExitAngle],
		Building[idx][Locked],
		Building[idx][PickupID]);

		if(idx == 0)
		{
			file2 = fopen("New York Roleplay/Buildings/buildings.cfg", io_write);
		}
		else
		{
			file2 = fopen("New York Roleplay/Buildings/buildings.cfg", io_append);
		}
		fwrite(file2, coordsstring);
		idx++;
		fclose(file2);
	}
	return 1;
}
//==============================================================================
public LoadDynamicFactions()
{
	new arrCoords[33][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Factions/factions.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(DynamicFactions))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, '|');
			strmid(DynamicFactions[idx][fName], arrCoords[0], 0, strlen(arrCoords[0]), 255);
			DynamicFactions[idx][fX] = floatstr(arrCoords[1]);
			DynamicFactions[idx][fY] = floatstr(arrCoords[2]);
			DynamicFactions[idx][fZ] = floatstr(arrCoords[3]);
			DynamicFactions[idx][fMaterials] = strval(arrCoords[4]);
			DynamicFactions[idx][fDrugs] = strval(arrCoords[5]);
			DynamicFactions[idx][fBank] = strval(arrCoords[6]);
			strmid(DynamicFactions[idx][fRank1], arrCoords[7], 0, strlen(arrCoords[7]), 255);
			strmid(DynamicFactions[idx][fRank2], arrCoords[8], 0, strlen(arrCoords[8]), 255);
            strmid(DynamicFactions[idx][fRank3], arrCoords[9], 0, strlen(arrCoords[9]), 255);
            strmid(DynamicFactions[idx][fRank4], arrCoords[10], 0, strlen(arrCoords[10]), 255);
            strmid(DynamicFactions[idx][fRank5], arrCoords[11], 0, strlen(arrCoords[11]), 255);
            strmid(DynamicFactions[idx][fRank6], arrCoords[12], 0, strlen(arrCoords[12]), 255);
            strmid(DynamicFactions[idx][fRank7], arrCoords[13], 0, strlen(arrCoords[13]), 255);
            strmid(DynamicFactions[idx][fRank8], arrCoords[14], 0, strlen(arrCoords[14]), 255);
            strmid(DynamicFactions[idx][fRank9], arrCoords[15], 0, strlen(arrCoords[15]), 255);
            strmid(DynamicFactions[idx][fRank10], arrCoords[16], 0, strlen(arrCoords[16]), 255);
			DynamicFactions[idx][fSkin1] = strval(arrCoords[17]);
			DynamicFactions[idx][fSkin2] = strval(arrCoords[18]);
			DynamicFactions[idx][fSkin3] = strval(arrCoords[19]);
			DynamicFactions[idx][fSkin4] = strval(arrCoords[20]);
			DynamicFactions[idx][fSkin5] = strval(arrCoords[21]);
			DynamicFactions[idx][fSkin6] = strval(arrCoords[22]);
			DynamicFactions[idx][fSkin7] = strval(arrCoords[23]);
			DynamicFactions[idx][fSkin8] = strval(arrCoords[24]);
			DynamicFactions[idx][fSkin9] = strval(arrCoords[25]);
			DynamicFactions[idx][fSkin10] = strval(arrCoords[26]);
			DynamicFactions[idx][fJoinRank] = strval(arrCoords[27]);
			DynamicFactions[idx][fUseSkins] = strval(arrCoords[28]);
			DynamicFactions[idx][fType] = strval(arrCoords[29]);
			DynamicFactions[idx][fRankAmount] = strval(arrCoords[30]);
			strmid(DynamicFactions[idx][fColor], arrCoords[31], 0, strlen(arrCoords[31]), 255);
			DynamicFactions[idx][fUseColor] = strval(arrCoords[32]);
			printf("[Dynamic Factions] Faction Name: %s, Type: %d, ID: %d",DynamicFactions[idx][fName],DynamicFactions[idx][fType],idx);
			idx++;
		}
		fclose(file);
	}
	return 1;
}

public SaveDynamicFactions()
{
	new idx;
	new File: file2;
	while (idx < sizeof(DynamicFactions))
	{

		new coordsstring[512];
		format(coordsstring, sizeof(coordsstring), "%s|%f|%f|%f|%d|%d|%d|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%s|%d\n",
		DynamicFactions[idx][fName],
		DynamicFactions[idx][fX],
		DynamicFactions[idx][fY],
		DynamicFactions[idx][fZ],
		DynamicFactions[idx][fMaterials],
		DynamicFactions[idx][fDrugs],
		DynamicFactions[idx][fBank],
		DynamicFactions[idx][fRank1],
		DynamicFactions[idx][fRank2],
		DynamicFactions[idx][fRank3],
		DynamicFactions[idx][fRank4],
		DynamicFactions[idx][fRank5],
		DynamicFactions[idx][fRank6],
		DynamicFactions[idx][fRank7],
		DynamicFactions[idx][fRank8],
		DynamicFactions[idx][fRank9],
		DynamicFactions[idx][fRank10],
		DynamicFactions[idx][fSkin1],
		DynamicFactions[idx][fSkin2],
		DynamicFactions[idx][fSkin3],
		DynamicFactions[idx][fSkin4],
		DynamicFactions[idx][fSkin5],
		DynamicFactions[idx][fSkin6],
		DynamicFactions[idx][fSkin7],
		DynamicFactions[idx][fSkin8],
		DynamicFactions[idx][fSkin9],
		DynamicFactions[idx][fSkin10],
		DynamicFactions[idx][fJoinRank],
		DynamicFactions[idx][fUseSkins],
		DynamicFactions[idx][fType],
		DynamicFactions[idx][fRankAmount],
		DynamicFactions[idx][fColor],
		DynamicFactions[idx][fUseColor]);

		if(idx == 0)
		{
			file2 = fopen("New York Roleplay/Factions/factions.cfg", io_write);
		}
		else
		{
			file2 = fopen("New York Roleplay/Factions/factions.cfg", io_append);
		}
		fwrite(file2, coordsstring);
		idx++;
		fclose(file2);
	}
	return 1;
}
//==============================================================================
public LoadDynamicCars()
{
	new arrCoords[9][64];
	new strFromFile2[256];
	new File: file = fopen("New York Roleplay/Cars/carspawns.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(DynamicCars))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, '|');
			DynamicCars[idx][CarModel] = strval(arrCoords[0]);
			DynamicCars[idx][CarX] = floatstr(arrCoords[1]);
			DynamicCars[idx][CarY] = floatstr(arrCoords[2]);
			DynamicCars[idx][CarZ] = floatstr(arrCoords[3]);
			DynamicCars[idx][CarAngle] = floatstr(arrCoords[4]);
			DynamicCars[idx][CarColor1] = strval(arrCoords[5]);
			DynamicCars[idx][CarColor2] = strval(arrCoords[6]);
			DynamicCars[idx][FactionCar] = strval(arrCoords[7]);
			DynamicCars[idx][CarType] = strval(arrCoords[8]);

			new vehicleid = CreateVehicle(DynamicCars[idx][CarModel],DynamicCars[idx][CarX],DynamicCars[idx][CarY],DynamicCars[idx][CarZ],DynamicCars[idx][CarAngle],DynamicCars[idx][CarColor1],DynamicCars[idx][CarColor2], -1);

			if(DynamicCars[idx][FactionCar] != 255)
			{
				SetVehicleNumberPlate(vehicleid, DynamicFactions[DynamicCars[idx][FactionCar]][fName]);
				SetVehicleToRespawn(vehicleid);
			}
			idx++;
		}
		fclose(file);
	}
	return 1;
}

public SaveDynamicCars()
{
	new idx;
	new File: file2;
	while (idx < sizeof(DynamicCars))
	{
		new coordsstring[512];
		format(coordsstring, sizeof(coordsstring), "%d|%f|%f|%f|%f|%d|%d|%d|%d\n",
		DynamicCars[idx][CarModel],
		DynamicCars[idx][CarX],
		DynamicCars[idx][CarY],
		DynamicCars[idx][CarZ],
		DynamicCars[idx][CarAngle],
		DynamicCars[idx][CarColor1],
		DynamicCars[idx][CarColor2],
		DynamicCars[idx][FactionCar],
		DynamicCars[idx][CarType]);

		if(idx == 0)
		{
			file2 = fopen("New York Roleplay/Cars/carspawns.cfg", io_write);
		}
		else
		{
			file2 = fopen("New York Roleplay/Cars/carspawns.cfg", io_append);
		}
		fwrite(file2, coordsstring);
		idx++;
		fclose(file2);
	}
	return 1;
}
//==============================================================================
public KickPlayer(playerid,kickedby[MAX_PLAYER_NAME],reason[])
{
	new string[128];
	format(string,sizeof(string),"(INFO) %s has been kicked by %s - Reason: %s ",GetPlayerNameEx(playerid),kickedby,reason);
	SendClientMessageToAll(COLOR_ADMINCMD,string);
	KickLog(string);
	return Kick(playerid);
}

public LockPlayerAccount(playerid,bannedby[MAX_PLAYER_NAME],reason[])
{
	new string[128];
	format(string,sizeof(string),"(INFO) %s's account has been locked by %s - Reason: %s ",GetPlayerNameEx(playerid),bannedby,reason);
	SendClientMessageToAll(COLOR_ADMINCMD,string);
	AccountLockLog(string);
	PlayerInfo[playerid][pLocked] = 1;
	OnPlayerDataSave(playerid);
	return Kick(playerid);
}

public BanPlayer(playerid,bannedby[MAX_PLAYER_NAME],reason[])
{
	new string[128];
	format(string,sizeof(string),"(INFO) %s has been banned by %s - Reason: %s ",GetPlayerNameEx(playerid),bannedby,reason);
	SendClientMessageToAll(COLOR_ADMINCMD,string);
	BanLog(string);
	return Ban(playerid);
}

public PayLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("New York Roleplay/Logs/pay.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

public HackLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("New York Roleplay/Logs/hack.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

public KickLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("New York Roleplay/Logs/kick.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

public AccountLockLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("New York Roleplay/Logs/accountlock.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

public BanLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("New York Roleplay/Logs/ban.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

public PlayerActionLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("New York Roleplay/Logs/playeraction.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

public PlayerLocalLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("New York Roleplay/Logs/playerlocal.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

public TalkLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("New York Roleplay/Logs/talk.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

public FactionChatLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("New York Roleplay/Logs/factionchat.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

public SMSLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("New York Roleplay/Logs/sms.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

public PMLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("New York Roleplay/Logs/pm.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

public DonatorLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("New York Roleplay/Logs/donator.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

public ReportLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("New York Roleplay/Logs/report.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

public OOCLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("New York Roleplay/Logs/ooc.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}
//==============================================================================
public GameModeRestart()
{
	new string[128];
	format(string, sizeof(string), "Game Mode Restarting");
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			DisablePlayerCheckpoint(i);
			GameTextForPlayer(i, string, 4000, 5);
			SetPlayerCameraPos(i, 1481.5609, -1735.0886, 13.3828);
			SetPlayerCameraLookAt(i,1481.5609, -1735.0886, 13.3828);
			OnPlayerDataSave(i);
			gPlayerLogged[i] = 0;
		}
	}
	SetTimer("GameModeRestartFunction", 4000, 0);
 	SaveDynamicFactions();
	SaveDynamicCars();
	SaveCivilianSpawn();
	SaveBuildings();
	SaveHouses();
	SaveBusinesses();
	SaveFactionMaterialsStorage();
	SaveFactionDrugsStorage();
	SaveDrivingTestPosition();
	SaveFlyingTestPosition();
	SaveBankPosition();
	SaveWeaponLicensePosition();
	SavePoliceArrestPosition();
	SaveGovernmentArrestPosition();
	SavePoliceDutyPosition();
	SaveGovernmentDutyPosition();
	SaveGunJob();
	SaveDrugJob();
	SaveDetectiveJob();
	SaveLawyerJob();
	SaveMechanicJob();
	SaveProductsSellerJob();
	return 1;
}

public GameModeRestartFunction()
{
	GameModeExit();
}


/*
================================================================================
									End Of File
================================================================================
*/
