/*
Pure RPG Gamemode by M1k3
*/

#include <a_players>
#include <a_samp>
#include <dini>
#include <dudb>
#include <core> 
#include <float>
#include <string>

#pragma tabsize 0

static gTeam[MAX_PLAYERS]; // Tracks the team assignment for each player

static currentlyCuffed[MAX_PLAYERS]; //Stores the Timer ID for each player in case KillTimer is neccessary
static CurrentCase;//stores the ID of the current suspect at court
static CurrentJudge;//stores the ID of the current judge at court
static CurrentLawyer;//stores the ID of the current lawyer at court
static LSPilot;//stores the ID of the current pilot in LS
static SFPilot;//stores the ID of the current pilot in SF
static LVPilot;//stores the ID of the current pilot in LV
static LSTaxidrvr;//stores the ID of the current taxidriver in LS
static SFTaxidrvr;//stores the ID of the current taxidriver in SF
static LVTaxidrvr;//stores the ID of the current taxidriver in LS
static LSTaxicust;//stores the ID of the current taxicustomer in LS
static SFTaxicust;//stores the ID of the current taxicustomer in SF
static LVTaxicust;//stores the ID of the current taxicustomer in LV
static Servertime;
static ServerMinute;
static ServerSecond;
static AdID;
static LastGame;//Stores the Timer ID of the last game to be killed when game ends
static isTimer; // By Tratulla
static TimerID; // By Tratulla
static Registered[MAX_PLAYERS];//xadmin
static PinLogged[MAX_PLAYERS];//xadmin
static Away[MAX_PLAYERS];//xadmin
static xWanted[MAX_PLAYERS];//xadmin
static Stfu[MAX_PLAYERS];//xadmin
static xJailed[MAX_PLAYERS];//xadmin
static LoggedIn[MAX_PLAYERS];//xadmin
static Passworded[MAX_PLAYERS];//xadmin
static Frozen[MAX_PLAYERS];//xadmin
static Pin[MAX_PLAYERS];//xadmin
static Kills[MAX_PLAYERS];//xadmin
static Deaths[MAX_PLAYERS];//xadmin
static xBank[MAX_PLAYERS];//xadmin
static Cash[MAX_PLAYERS];//xadmin
static StfuW[MAX_PLAYERS];//xadmin
static JailT[MAX_PLAYERS];//xadmin
static Level[MAX_PLAYERS];//xadmin
static LogTry[MAX_PLAYERS];//xadmin
static Inj[MAX_PLAYERS];//xadmin
static FTActive;//xadmin
static FTV;//xadmin
static FreezeTimer;//xadmin

#define dcmd(%1,%2,%3) if ((strcmp(%3, "/%1", true, %2+1) == 0)&&(((%3[%2+1]==0)&&(dcmd_%1(playerid,"")))||((%3[%2+1]==32)&&(dcmd_%1(playerid,%3[%2+2]))))) return 1
#define Level(%1) dini_Get(udb_encode(%1),"Level")
#define banportal "bans.txt"
#define VTYPE_CAR 1
#define VTYPE_HEAVY 2
#define VTYPE_BIKE 3
#define VTYPE_AIR 4
#define VTYPE_SEA 5
#define VTYPE_GOV 6
#define CAM_REFRESH_RATE 200
#define CAM_ZOOM1 6
#define CAM_ZOOM2 9
#define CAM_ZOOM3 15

#define FILE_INPUT	"echo/irc.txt" // By Tratulla
#define FILE_OUTPUT	"echo/echo.txt" // By Tratulla


#define TEAM_CIVS 1
#define TEAM_SENIORS 2
#define TEAM_WAITERS 3
#define TEAM_CRIMINALS 4
#define TEAM_SECURITIES 5
#define TEAM_PILOTS 6
#define TEAM_ENTERTAINERS 7
#define TEAM_MEDICS 8
#define TEAM_FIREMEN 9
#define TEAM_COPS 10

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x007700AA
#define COLOR_LIGHTGREEN 0x00FF00AA
#define COLOR_DARKGREEN 0x004400AA
#define COLOR_RED 0xFF0000AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define BBLUE 0x00BFFFAA
#define COLOR_LIGHTBLUE 0x1C86EEAA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BRIGHTRED 0xB22222
#define yellow 0xFFFF00AA//xadmin
#define green 0x33FF33AA//xadmin
#define red 0xFF0000AA//xadmin
#define white 0xFFFFFFAA//xadmin
#define cyan 0x00FFFFAA//xadmin

// forward declarations for the PAWN compiler

forward strtok(const string[], &index);
forward WriteEcho(msg[]);
forward CheckInput();
forward NameLookup(playerid,playername[],&lookupid,showerror);
forward strrest(const string[],index);
forward PlayerName(playerid);
forward IsNumeric(const string[]);
forward public left(source[], len);
forward AutoReminder();
forward SetPlayerToTeamColor(playerid);
forward SetPlayerToSpawn(playerid);
forward SetupPlayerForClassSelection(playerid);
forward GivePlayerBankMoney(playerid,amount);
forward CheckAutoKick();
forward CheckSOS();
forward CheckSOS2();
forward TimerUncuff();
forward GTATimer();
forward TimerCheck();
forward TimerJail();
forward Payday();
forward RemoveTimer();
forward BuyTimer();
forward WantedTimer();
forward JoinBurn();
forward JoinDerby();
forward JoinBurnTimeout();
forward JoinDerbyTimeout();
forward BurnEnd();
forward DoBurnRespawn(br);
forward DerbyEnd();
forward FuelTimer();
forward AdTimer();
forward Sec();
forward CHack();
forward Injector(playerid);//xadmin
forward SendMessageToAdmins(text[]);//xadmin
forward SendMessageToAdminEx(playerid,text[]);//xadmin
forward NullS(file[256],key[256]);//xadmin
forward NullI(file[256],key[256]);//xadmin
forward MatchID(xstring[]);//xadmin
forward IfPlayerHasTag(playerid,xstring[]);//xadmin
forward IfWeaponExists(const weaponname[]);//xadmin
forward IsPlayerLowerLevel(playerid,refid);//xadmin
forward ReturnPlayers();//xadmin
forward IsPlayerLevel(playerid,level);//xadmin
forward IsWeaponValid(weaponid);//xadmin
forward AdminError(playerid,level);//xadmin
forward FreezeCount();//xadmin
//---------------------------------------------------------

enum Info
{
	Logged,
	OOC,
	Skin, 
	Admin, 
	Bank,
	Banned,
	AutoKick, 
	Spawned,
	JoinTeam,
	CopBlock,
	GetSkin, 
	vehicle,
	GTA,
	FindX,
	FindY, 
	FindZ, 
	buytimer,
	invehicle,
	driver,
	fuel, 
	City, 
	isPassenger, 
	paradrop,
	Boarded,
	Remove,
	Wanted,
	WantedLevel,
	AddWanted,
	Rob,
	Jailable,
	Jailed,
	OldX,
	OldY,
	OldZ,
	OldA,
	OldInt,
	Cuffed,
	SOS,
    blink1,
    PlayBurn,
    BurnRespawn,
    PlayDerby,
    isPreparing,
    DrugsAmount,
    WantDrugs,
    UsedDrugs,
    Ad,
    Alarm,
	Mute, 
	SAPD,
	Int,
	c
}

enum Minigame
{
BurnPrepare,
BurnRunning,
DerbyPrepare,
DerbyRunning
}

enum Flight
{
OnBlocks,
Flying,
GreenLight,
}

enum Pos
{
	Float:xL,
	Float:yL,
	Float:zL
}
enum SavePlayerPosEnum
{
    Float:LastX,
    Float:LastY,
    Float:LastZ
}

new hack;
new Minigames[Minigame];
new LSFlight[Flight],SFFlight[Flight],LVFlight[Flight];
new pInfo[MAX_PLAYERS][Info];

//---------------------------------------------------------

main()
{
	print("\n----------------------------------");
	print("Pure RPG by M1k3");
	print("----------------------------------\n");
	if(!dini_Exists(banportal))
	{
	    dini_Create(banportal);
	    print("\n-------------------------------------");
	    print("Banportal not found. Banportal created.");
	    print("-------------------------------------\n");
	}
}

//Function
public GivePlayerBankMoney(playerid,amount)
{
new gpbm[24];
GetPlayerName(playerid,gpbm,sizeof(gpbm));
new balance = strval(dini_Get(udb_encode(gpbm),"Bank")) + amount;
dini_IntSet(udb_encode(gpbm),"Bank",balance);
}

//****************TRATULLA'S IRC ECHO SCRIPT*****************************

public WriteEcho( msg[] )
{
	new File:log = fopen(FILE_OUTPUT, io_append);
	new save_strstr[256];
	format(save_strstr, sizeof(save_strstr), "%s\r\n", msg);
	fwrite(log, save_strstr);
	fclose(log);
}

public CheckInput()
{
    if (!fexist("echo/irc.txt")) return 1;

    enum IRCCheckEnum
    {
        idx,
        echochan[256],
        string[1024],
        command[256],
        temp[256],
        temp2[512],
        File:irc,
    }

    static IRCCheck[IRCCheckEnum];

    IRCCheck[irc] = fopen( FILE_INPUT , io_read );

	while(fread(IRCCheck[irc], IRCCheck[string], sizeof(IRCCheck[string]), false))
	{
	    IRCCheck[idx] = 0;
		set(IRCCheck[echochan],strtok(IRCCheck[string], IRCCheck[idx]));
	    set(IRCCheck[command],strtok(IRCCheck[string], IRCCheck[idx]));

		if(strcmp(IRCCheck[command], "/say", true) == 0)
		{
		    set(IRCCheck[temp],strtok(IRCCheck[string], IRCCheck[idx]));
		    set(IRCCheck[temp2],strrest(IRCCheck[string], IRCCheck[idx]));
		    format(IRCCheck[string], sizeof(IRCCheck[string]), "* Admin %s: %s", IRCCheck[temp], IRCCheck[temp2]);
			SendClientMessageToAll(0x0080C0FF, IRCCheck[string]);
			format(IRCCheck[string], sizeof(IRCCheck[string]), "%s [say] -- %s %s", IRCCheck[echochan], IRCCheck[temp], IRCCheck[temp2]);
			WriteEcho(IRCCheck[string]);
		} else if(strcmp(IRCCheck[command], "/msg", true) == 0)
		{
		    set(IRCCheck[temp],strtok(IRCCheck[string], IRCCheck[idx]));
		    set(IRCCheck[temp2],strrest(IRCCheck[string], IRCCheck[idx]));
		    format(IRCCheck[string], sizeof(IRCCheck[string]), "* %s: %s", IRCCheck[temp], IRCCheck[temp2]);
			SendClientMessageToAll(0xFFFFFFFF, IRCCheck[string]);
			format(IRCCheck[string], sizeof(IRCCheck[string]), "%s [chat] -- %s %s", IRCCheck[echochan], IRCCheck[temp], IRCCheck[temp2]);
			WriteEcho(IRCCheck[string]);
		}
		else if(strcmp(IRCCheck[command], "/kick", true) == 0)
		{
		    set(IRCCheck[temp],strtok(IRCCheck[string], IRCCheck[idx]));
		    new kickid = strval(strtok(IRCCheck[string], IRCCheck[idx]));
		    set(IRCCheck[temp2],strrest(IRCCheck[string], IRCCheck[idx]));
		    if (IsPlayerConnected(kickid))
		    {
		        format(IRCCheck[string], sizeof(IRCCheck[string]), "%s [kick] -- %s %d %s %s", IRCCheck[echochan] , IRCCheck[temp], kickid, PlayerName(kickid), IRCCheck[temp2]);
				WriteEcho(IRCCheck[string]);
				Kick(kickid);
		    }
		}
		// Ban a person
		else if(strcmp(IRCCheck[command], "/ban", true) == 0)
		{
		    set(IRCCheck[temp],strtok(IRCCheck[string], IRCCheck[idx]));
		    new banid = strval(strtok(IRCCheck[string], IRCCheck[idx]));
		    set(IRCCheck[temp2],strrest(IRCCheck[string], IRCCheck[idx]));
		    if (IsPlayerConnected(banid))
		    {
			format(IRCCheck[string], sizeof(IRCCheck[string]), "%s [ban] -- %s %d %s %s", IRCCheck[echochan] , IRCCheck[temp], banid, PlayerName(banid), IRCCheck[temp2]);
			WriteEcho(IRCCheck[string]);
			BanEx(banid,"IRC Ban");
		    }
		}
		// Get the ID of a person
		else if(strcmp(IRCCheck[command], "/getid", true) == 0)
		{
		    set(IRCCheck[temp],strtok(IRCCheck[string], IRCCheck[idx]));
		    new lookupid;
			if(NameLookup(-1,IRCCheck[temp],lookupid,0) != 1)
			{
			    format(IRCCheck[string], sizeof(IRCCheck[string]), "%s [error] Player %s could not be found", IRCCheck[echochan] , IRCCheck[temp]);
			    WriteEcho(IRCCheck[string]);
			} else
		    {
				format(IRCCheck[string], sizeof(IRCCheck[string]), "%s [getid] %s %d", IRCCheck[echochan] , PlayerName(lookupid), lookupid);
				WriteEcho(IRCCheck[string]);
		    }
		} else if ( strcmp( IRCCheck[command] , "/restart" , true ) == 0 )
		{
				set(IRCCheck[temp],strtok(IRCCheck[string], IRCCheck[idx]));
                format(IRCCheck[string], sizeof(IRCCheck[string]), "%s [restart] %s has send a game reload", IRCCheck[echochan] , IRCCheck[temp] );
				WriteEcho(IRCCheck[string]);
				GameModeExit( );
		}
	}
	fclose(IRCCheck[irc]);
	fremove( FILE_INPUT );
	return 1;
}

stock NameLookup( playerid, playername[], &lookupid, showerror)
{
	if ( IsNumeric( playername ) == 1 )
	{
		lookupid = strval( playername );
		return 1;
	}

	new namesmatch = 0;

	for ( new i=0; i<MAX_PLAYERS; i++ )
	{
		if ( IsPlayerConnected( i ) )
		{
			new pname[24],pname2[24];
			GetPlayerName( i, pname, sizeof( pname ) );

			strmid(pname2,pname,0,strlen(playername),255);

			if ( strcmp( pname, playername, true ) == 0 )
			{
				lookupid = i; return 1;
			} else if ( strcmp( pname2, playername, true ) == 0 )
			{
				lookupid = i; namesmatch++;
			}
		}
	}
	if ( namesmatch > 1 && showerror == 1 )
	{
		new strstr[256];
		format ( strstr, sizeof( strstr ), "Mutiple names match for %s", playername );

		if ( playerid != -1 )
		{
			SendClientMessage(playerid, 0xAA3333AA, strstr);
		}
	} else if ( namesmatch == 0 && showerror == 1 )
	{
		new strstr[256];
		format( strstr, sizeof( strstr ), "No names match for %s", playername );
		if (playerid != -1)
		{
		    SendClientMessage(playerid, 0xAA3333AA, strstr);
		}
	}
	return namesmatch;
}

stock strrest(const string[], index)
{
	new length = strlen(string);

	new offset = index;
	new result[256];
	while ((index < length) && ((index - offset) < (sizeof(result) - 1)) && (string[index] > '\r'))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

stock PlayerName( playerid )
{
	new plname[MAX_PLAYER_NAME];
	GetPlayerName( playerid, plname, sizeof( plname ) );
	return plname;
}

stock IsNumeric( const string[] )
{
	for ( new i, j = strlen( string ); i < j; i++ )
	{
		if ( string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

//***************************************************************************

//FUNCTIONS BY XADMIN
//==============================================================================
//Custom Injector Function
public Injector(playerid) {
	new name[MAX_PLAYER_NAME]; GetPlayerName(playerid,name,sizeof(name));
    new file[256]; format(file,sizeof(file),"/xadmin/%s.ini",udb_encode(name));
	dini_Create(file);
	if(!dini_Int(file,"passworded")) { NullI(file,"passworded"); NullS(file,"password"); }
	if(!dini_Int(file,"registered")) NullI(file,"registered");
	if(!dini_Int(file,"pinlogged")) NullI(file,"pinlogged");
	if(!dini_Int(file,"away")) NullI(file,"wanted");
	if(!dini_Int(file,"stfu")) NullI(file,"jailed");
	if(!dini_Int(file,"loggedin")) NullI(file,"loggedin");
	if(!dini_Int(file,"pincode")) NullI(file,"pincode");
	if(!dini_Int(file,"kills")) NullI(file,"kill");
	if(!dini_Int(file,"deaths")) NullI(file,"deaths");
	if(!dini_Int(file,"bank")) NullI(file,"bank");
	if(!dini_Int(file,"cash")) dini_IntSet(file,"cash",500);
	if(!dini_Int(file,"stfuwarnings")) NullI(file,"stfuwarnings");
	if(!dini_Int(file,"jailtime")) NullI(file,"jailtime");
	if(!dini_Int(file,"level")) NullI(file,"level");
	if(!dini_Int(file,"logintry")) NullI(file,"logintry");
	dini_IntSet(file,"injector",dini_Int("xadmin/config/utilities.ini","Injector"));
return 1;
}
//==============================================================================
public SendMessageToAdmins(text[]) {
	for(new i = 0; i < MAX_PLAYERS; i++) {
 		if(IsPlayerConnected(i)) {
			new name[MAX_PLAYER_NAME]; GetPlayerName(i,name,sizeof(name));
			new file[256]; format(file,sizeof(file),"/xadmin/%s.ini",udb_encode(name));
	    	if (IsPlayerConnected(i) && LoggedIn[i] == 1 && Registered[i] == 1 && Level[i] >= 1) SendClientMessage(i,cyan,text);
		}
	}
	printf("Admin Message Send >> %s",text);
return 1;
}
//==============================================================================
public SendMessageToAdminEx(playerid,text[]) {
	for(new i = 0; i < MAX_PLAYERS; i++) {
	    if(IsPlayerConnected(i)) {
			new name[MAX_PLAYER_NAME]; GetPlayerName(i,name,sizeof(name));
			new file[256]; format(file,sizeof(file),"/xadmin/%s.ini",udb_encode(name));
	    	if (LoggedIn[i] == 1 && Registered[i] == 1 && Level[i] >= 1 && playerid != i) SendClientMessage(i,cyan,text);
		}
	}
		printf("Admin Message Send >> %s",text);
return 1;
}

//==============================================================================
//Nullifying Callbacks
public NullS(file[256],key[256]) dini_Set(file,key,"Null");
public NullI(file[256],key[256]) dini_IntSet(file,key,0);

//==============================================================================
public MatchID(xstring[]) {
	new name[MAX_PLAYER_NAME], id;
    for(new i = 0; i < MAX_PLAYERS; i++) {
        if(IsPlayerConnected(i)) {
        	GetPlayerName(i,name,sizeof(name));
        	if(strfind(name,xstring,true) != -1) { id = i; break; }
		}
	}
	return id;
}
//==============================================================================
public IfPlayerHasTag(playerid,xstring[]) {
	new name[MAX_PLAYER_NAME]; GetPlayerName(playerid,name,sizeof(name));
	return (strfind(name,xstring,true) != -1) ? 1 : 0;
}
//==============================================================================
public IfWeaponExists(const weaponname[]) {
	new weapon[256], id;
    for(new i = 0; i <= 46; i++) {
        if(IsWeaponValid(i)) {
        	GetWeaponName(i,weapon,sizeof(weapon));
        	if(strfind(weapon,weaponname,true) != -1) {
			id = i;
			break;
			}
		}
	}
	return id;
}
//==============================================================================
public IsPlayerLowerLevel(playerid,refid) return Level[playerid] >= Level[refid] ? 1 : 0;
public ReturnPlayers() { new Players; for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) Players++; return Players; }
public IsPlayerLevel(playerid,level) return (LoggedIn[playerid] == 1 && Level[playerid] >= level) ? 1 : 0;
public IsWeaponValid(weaponid) return (weaponid > 0 && weaponid <= 46 && !(weaponid >= 16 && weaponid <= 21) && weaponid != 35 && weaponid != 36 && weaponid != 40 && !(weaponid >= 44 && weaponid <= 45)) ? 1 : 0;
//==============================================================================
public AdminError(playerid,level) {
	new xstring[256];
	if(level < 10) format(xstring,sizeof(xstring),"Sorry, but you must be logged in as admin level %d+.",level);
	if(level == 10) format(xstring,sizeof(xstring),"Sorry, but you must be logged in as admin level 10.");
	SendClientMessage(playerid,red,xstring);
}
//=============================================================================]
public FreezeCount() {
	FTV--;
	new xstring[256];
	if(FTV >= 10) format(xstring,sizeof(xstring),"~b~Time Remaining: ~r~00:%d",FTV);
	if(FTV > 5 && FTV < 10) format(xstring,sizeof(xstring),"~b~Time Remaining: ~r~00:0%d",FTV);
	if(FTV > 0 && FTV <= 5) format(xstring,sizeof(xstring),"~b~Time Remaining: ~y~00:0%d",FTV);
	if(FTV == 0) { format(xstring,sizeof(xstring),"~b~All players are ~g~FREE~b~!"); for(new i = 0; i < MAX_PLAYERS; i++) TogglePlayerControllable(i,1); FTActive = 0; KillTimer(FreezeTimer); }
	GameTextForAll(xstring,1000,3);
}
//==============================================================================
//***************************************************************************

//*****************************************************************************************************************************
//*****************************************************************************************************************************
//*****************************************************************************************************************************
//*************************************************PURE-RPG GAMEMODE BY M1k3***************************************************
//*****************************************************************************************************************************
//*****************************************************************************************************************************
//*****************************************************************************************************************************

stock Float:GetDistanceBetweenPlayers(p1,p2)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	if (!IsPlayerConnected(p1) || !IsPlayerConnected(p2))
	{
		return -1.00;
	}
	GetPlayerPos(p1,x1,y1,z1);
	GetPlayerPos(p2,x2,y2,z2);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

stock GetClosestPlayer(playerid) {
	new x,Float:dis,Float:dis2,player;
	new pteam[MAX_PLAYERS];
	player = -1;
	dis = 99999.99;
	for (x=0;x<MAX_PLAYERS;x++) {
		if (x != playerid) {
			dis2 = GetDistanceBetweenPlayers(x,playerid);
			if (dis2 < dis && dis2 != -1.00 && pteam[x] == pteam[playerid]) {
				dis = dis2;
				player = x;
			}
		}
	}
	return player;
}

public Sec()
{

   		if (ServerSecond < 60) ServerSecond = ServerSecond + 1;
		if (ServerSecond == 60) {
		    ServerSecond = 0;
			ServerMinute = ServerMinute + 1;
			}
		if (ServerMinute == 60) {
		ServerMinute = 0;
		Payday();
		}

//		printf("Time Check: %d - %d - %d",Servertime,ServerMinute,ServerSecond);


    for(new i=0;i<MAX_PLAYERS;i++) if(IsPlayerConnected(i)){
        SetPlayerScore(i, GetPlayerMoney(i));
        SetPlayerTime(i,Servertime,ServerMinute);
	}
return 1;
}


//---------------------------------------------------------
//Function

public AutoReminder()
{
GameTextForAll("Remember to ALWAYS ~r~/register ~w~ and ~r~/login",3333,5);
}
//---------------------------------------------------------
//Function

public TimerUncuff()
{
for(new a=0; a<MAX_PLAYERS; a++){
if(IsPlayerConnected(a)){
	if (pInfo[a][Cuffed] == 1){
		pInfo[a][Cuffed] = 0;
		TogglePlayerControllable(a,true);
		SendClientMessage(a,COLOR_LIGHTGREEN, "You managed to uncuff yourself and are free to move again.");
		new uncuffname[24],uncuffmsg[120];
		GetPlayerName(a,uncuffname,sizeof(uncuffname));
		format(uncuffmsg,sizeof(uncuffmsg),"Suspect %s managed to uncuff himself and is on the run.",uncuffname);
		SendClientMessageToAll(BBLUE,uncuffmsg);
		return 1;
		}
}
}
return 1;
}

//---------------------------------------------------------
//Function

public GTATimer()
{
for(new gta=0; gta<MAX_PLAYERS; gta++){
if(IsPlayerConnected(gta) && pInfo[gta][GTA] != 0){
	
		SetVehicleParamsForPlayer(pInfo[gta][GTA],gta,0,0);
		pInfo[gta][GTA] = 0;
		TogglePlayerControllable(gta,true);
		SendClientMessage(gta,COLOR_LIGHTGREEN, "You managed to picklock the car.");
		SendClientMessage(gta,COLOR_RED, "You have been seen and therefore got 2 wanted levels. The cops may be informed.");
		pInfo[gta][AddWanted] = 1;
		new uncuffname[24],uncuffmsg[120];
		GetPlayerName(gta,uncuffname,sizeof(uncuffname));
		format(uncuffmsg,sizeof(uncuffmsg),"[server] Criminal %s managed to picklock the car",uncuffname);
		WriteEcho(uncuffmsg);
		return 1;
		
}
}
return 1;
}


//---------------------------------------------------------
//Function

public TimerCheck()
{
for(new b=0; b<MAX_PLAYERS; b++){
if(IsPlayerConnected(b)){

	if (pInfo[b][WantedLevel] >= 1){

	    	if (pInfo[b][Cuffed] == 1){
				pInfo[b][Jailable] = 1;
				SendClientMessage(b,BBLUE, "The cop nods his head.");
				SendClientMessage(b,COLOR_RED, "Point of no return!");
 				SendClientMessage(b,COLOR_LIGHTGREEN, "Last chance: Your are uncuffed in about 10 seconds. RUN!");
				}
    	else pInfo[b][Jailable] = 0;
		}
else pInfo[b][Jailable] = 0;
}
}
SendClientMessageToAll(BBLUE, "***The cop HQ processed a wanted check as requested***");
SendClientMessageToAll(COLOR_RED, "***Cops try to /sue a cuffed person near you!***");
return 1;
}

//---------------------------------------------------------
//Function

public CheckAutoKick()
{
new autokickmsg[120];

for(new d=0; d<MAX_PLAYERS; d++){
if(IsPlayerConnected(d)){
	if (pInfo[d][Banned]){
	pInfo[d][Banned] = 0;
	Kick (d);
	format(autokickmsg,sizeof(autokickmsg),"ID %d auto-kicked. Reason: Banned",d);
	print(autokickmsg);
 	}
	if (pInfo[d][AutoKick]){
    pInfo[d][AutoKick] = 0;
	Kick (d);
 	format(autokickmsg,sizeof(autokickmsg),"ID %d auto-kicked. Reason: Requested",d);
	print(autokickmsg);
	}
}
}
return 1;
}

//---------------------------------------------------------
//Function
public CheckSOS()
{
for(new s=0; s<MAX_PLAYERS; s++){
	if(IsPlayerConnected(s)){
 		if (pInfo[s][SOS] && !pInfo[s][blink1]){
        pInfo[s][blink1] = 1;
		SetPlayerToTeamColor(s);
 		}
	}
}
return 1;
}

//---------------------------------------------------------
//Function
public CheckSOS2()
{
for(new s=0; s<MAX_PLAYERS; s++){
	if(IsPlayerConnected(s)){
 		if (pInfo[s][SOS] && pInfo[s][blink1]){
		pInfo[s][blink1] = 0;
        SetPlayerColor(s,COLOR_GREY);
		}
	}
}
return 1;
}



//---------------------------------------------------------
//Function

public TimerJail()
{
for(new e=0; e<MAX_PLAYERS; e++){
if(IsPlayerConnected(e)){
	if (pInfo[e][Jailed] == 1){
		pInfo[e][Jailed] = 0;
		pInfo[e][WantedLevel] = 0;
		TogglePlayerControllable(e,true);
		GameTextForPlayer(e,"You paid your debt to society.",3333,5);
		SetPlayerInterior(e,0);
		SetPlayerPos(e,1551.0000,-1676.0000,16.0000);
		SetPlayerFacingAngle(e,87.0);
		PlayerPlaySound(e,1069,1551.0000,-1676.0000,16.0000);
		}
}
}
return 1;
}

//---------------------------------------------------------
//Function
public Payday()
{
new newstr[225],player[24],interest,bank[255],balance,bg,bizgain,amount;
new Float:fbalance;
Servertime = Servertime + 1;

if (Servertime==24) Servertime=0;
	if (Servertime<10) format(newstr,sizeof(newstr),"The time is now 0%d:00h",Servertime);
	else format(newstr,sizeof(newstr),"The time is now %d:00h",Servertime);
SetWorldTime(Servertime);
dini_IntSet("Servertime","Time",Servertime);
for(new p=0; p<MAX_PLAYERS; p++){
if(IsPlayerConnected(p)){
pInfo[p][UsedDrugs] = 0;
pInfo[p][Ad] = 0;
pInfo[p][Rob] = 0;
GetPlayerName(p,player,sizeof(player));
format(bank,sizeof(bank),"%s",dini_Get(udb_encode(player),"Bank"));
bg = strval(dini_Get(udb_encode(player),"BizGain"));
fbalance = floatstr(bank);
interest = floatround(fbalance * 0.04,floatround_round);
balance = floatround(fbalance,floatround_round);
bizgain = 0;
if (bg!=0) bizgain = balance / (balance / random(bg));
switch (gTeam[p]){
	case TEAM_CIVS:{
	SendClientMessage(p,COLOR_WHITE,"********* Payday *********");
	SendClientMessage(p,COLOR_WHITE,newstr);
	SendClientMessage(p,COLOR_WHITE,"**************************");
	SendClientMessage(p,COLOR_WHITE,"* Your employer grants ... *");
	SendClientMessage(p,COLOR_ORANGE,"*         2000$         *");
	format(newstr,sizeof(newstr),"* Interest Gain: %d$ *",interest);
	SendClientMessage(p,COLOR_WHITE,newstr);
	format(newstr,sizeof(newstr),"* Business Gain: %d$ *",bizgain);
	SendClientMessage(p,COLOR_WHITE,newstr);
	amount = 2000 + interest + bizgain;
    SendClientMessage(p,COLOR_WHITE,"**************************");
   	format(newstr,sizeof(newstr),"* Overall Banked Payday Gain: %d$ *",amount);
	SendClientMessage(p,COLOR_ORANGE,newstr);
	format(newstr,sizeof(newstr),"~b~ %d$",amount);
	GameTextForPlayer(p,newstr,3999,1);
	GivePlayerBankMoney(p,amount);
 	}
	case TEAM_SENIORS:{
	SendClientMessage(p,COLOR_WHITE,"********* Payday *********");
	SendClientMessage(p,COLOR_WHITE,newstr);
	SendClientMessage(p,COLOR_WHITE,"**************************");
	SendClientMessage(p,COLOR_WHITE,"Your pension is...........");
	SendClientMessage(p,COLOR_ORANGE,"          1000$          ");
	format(newstr,sizeof(newstr),"* Interest Gain: %d$ *",interest);
	SendClientMessage(p,COLOR_WHITE,newstr);
	format(newstr,sizeof(newstr),"* Business Gain: %d$ *",bizgain);
	SendClientMessage(p,COLOR_WHITE,newstr);
	amount = 1000 + interest + bizgain;
    SendClientMessage(p,COLOR_WHITE,"**************************");
   	format(newstr,sizeof(newstr),"* Overall Banked Payday Gain: %d$ *",amount);
	SendClientMessage(p,COLOR_ORANGE,newstr);
	format(newstr,sizeof(newstr),"~b~ %d$",amount);
	GameTextForPlayer(p,newstr,3999,1);
	GivePlayerBankMoney(p,amount);
 	}
	case TEAM_WAITERS:{
	SendClientMessage(p,COLOR_WHITE,"********* Payday *********");
	SendClientMessage(p,COLOR_WHITE,newstr);
	SendClientMessage(p,COLOR_WHITE,"**************************");
	SendClientMessage(p,COLOR_WHITE,"Your employer grants you..");
	SendClientMessage(p,COLOR_ORANGE,"          3000$          ");
	format(newstr,sizeof(newstr),"* Interest Gain: %d$ *",interest);
	SendClientMessage(p,COLOR_WHITE,newstr);
	format(newstr,sizeof(newstr),"* Business Gain: %d$ *",bizgain);
	SendClientMessage(p,COLOR_WHITE,newstr);
	amount = 3000 + interest + bizgain;
    SendClientMessage(p,COLOR_WHITE,"**************************");
   	format(newstr,sizeof(newstr),"* Overall Banked Payday Gain: %d$ *",amount);
	SendClientMessage(p,COLOR_ORANGE,newstr);
	format(newstr,sizeof(newstr),"~b~ %d$",amount);
	GameTextForPlayer(p,newstr,3999,1);
	GivePlayerBankMoney(p,amount);
 	}
	case TEAM_CRIMINALS:{
	SendClientMessage(p,COLOR_WHITE,"********* Payday *********");
	SendClientMessage(p,COLOR_WHITE,newstr);
	SendClientMessage(p,COLOR_WHITE,"**************************");
	SendClientMessage(p,COLOR_WHITE,"Your gang leader grants...");
	SendClientMessage(p,COLOR_ORANGE,"          4000$          ");
	format(newstr,sizeof(newstr),"* Interest Gain: %d$ *",interest);
	SendClientMessage(p,COLOR_WHITE,newstr);
	format(newstr,sizeof(newstr),"* Business Gain: %d$ *",bizgain);
	SendClientMessage(p,COLOR_WHITE,newstr);
	amount = 4000 + interest + bizgain;
    SendClientMessage(p,COLOR_WHITE,"**************************");
   	format(newstr,sizeof(newstr),"* Overall Banked Payday Gain: %d$ *",amount);
	SendClientMessage(p,COLOR_ORANGE,newstr);
	format(newstr,sizeof(newstr),"~b~ %d$",amount);
	GameTextForPlayer(p,newstr,3999,1);
	GivePlayerBankMoney(p,amount);
 	}
	case TEAM_SECURITIES:{
	SendClientMessage(p,COLOR_WHITE,"********* Payday *********");
	SendClientMessage(p,COLOR_WHITE,newstr);
	SendClientMessage(p,COLOR_WHITE,"**************************");
	SendClientMessage(p,COLOR_WHITE,"Your employer grants you..");
	SendClientMessage(p,COLOR_ORANGE,"          5000$          ");
	format(newstr,sizeof(newstr),"* Interest Gain: %d$ *",interest);
	SendClientMessage(p,COLOR_WHITE,newstr);
	format(newstr,sizeof(newstr),"* Business Gain: %d$ *",bizgain);
	SendClientMessage(p,COLOR_WHITE,newstr);
	amount = 5000 + interest + bizgain;
    SendClientMessage(p,COLOR_WHITE,"**************************");
   	format(newstr,sizeof(newstr),"* Overall Banked Payday Gain: %d$ *",amount);
	SendClientMessage(p,COLOR_ORANGE,newstr);
	format(newstr,sizeof(newstr),"~b~ %d$",amount);
	GameTextForPlayer(p,newstr,3999,1);
	GivePlayerBankMoney(p,amount);
 	}
	case TEAM_PILOTS:{
	SendClientMessage(p,COLOR_WHITE,"********* Payday *********");
	SendClientMessage(p,COLOR_WHITE,newstr);
	SendClientMessage(p,COLOR_WHITE,"**************************");
	SendClientMessage(p,COLOR_WHITE,"The airline pays..........");
	SendClientMessage(p,COLOR_ORANGE,"          8000$          ");
	format(newstr,sizeof(newstr),"* Interest Gain: %d$ *",interest);
	SendClientMessage(p,COLOR_WHITE,newstr);
	format(newstr,sizeof(newstr),"* Business Gain: %d$ *",bizgain);
	SendClientMessage(p,COLOR_WHITE,newstr);
	amount = 8000 + interest + bizgain;
    SendClientMessage(p,COLOR_WHITE,"**************************");
   	format(newstr,sizeof(newstr),"* Overall Banked Payday Gain: %d$ *",amount);
	SendClientMessage(p,COLOR_ORANGE,newstr);
	format(newstr,sizeof(newstr),"~b~ %d$",amount);
	GameTextForPlayer(p,newstr,3999,1);
	GivePlayerBankMoney(p,amount);
 	}
	case TEAM_ENTERTAINERS:{
	SendClientMessage(p,COLOR_WHITE,"********* Payday *********");
	SendClientMessage(p,COLOR_WHITE,newstr);
	SendClientMessage(p,COLOR_WHITE,"**************************");
	SendClientMessage(p,COLOR_WHITE,"Your employer grants you..");
	SendClientMessage(p,COLOR_ORANGE,"          1000$          ");
	format(newstr,sizeof(newstr),"* Interest Gain: %d$ *",interest);
	SendClientMessage(p,COLOR_WHITE,newstr);
	format(newstr,sizeof(newstr),"* Business Gain: %d$ *",bizgain);
	SendClientMessage(p,COLOR_WHITE,newstr);
	amount = 1000 + interest + bizgain;
    SendClientMessage(p,COLOR_WHITE,"**************************");
   	format(newstr,sizeof(newstr),"* Overall Banked Payday Gain: %d$ *",amount);
	SendClientMessage(p,COLOR_ORANGE,newstr);
	format(newstr,sizeof(newstr),"~b~ %d$",amount);
	GameTextForPlayer(p,newstr,3999,1);
	GivePlayerBankMoney(p,amount);
 	}
	case TEAM_MEDICS:{
	SendClientMessage(p,COLOR_WHITE,"********* Payday *********");
	SendClientMessage(p,COLOR_WHITE,newstr);
	SendClientMessage(p,COLOR_WHITE,"**************************");
	SendClientMessage(p,COLOR_WHITE,"The hospital pays you.....");
	SendClientMessage(p,COLOR_ORANGE,"         10000$          ");
	format(newstr,sizeof(newstr),"* Interest Gain: %d$ *",interest);
	SendClientMessage(p,COLOR_WHITE,newstr);
	format(newstr,sizeof(newstr),"* Business Gain: %d$ *",bizgain);
	SendClientMessage(p,COLOR_WHITE,newstr);
	amount = 10000 + interest + bizgain;
    SendClientMessage(p,COLOR_WHITE,"**************************");
   	format(newstr,sizeof(newstr),"* Overall Banked Payday Gain: %d$ *",amount);
	SendClientMessage(p,COLOR_ORANGE,newstr);
	format(newstr,sizeof(newstr),"~b~ %d$",amount);
	GameTextForPlayer(p,newstr,3999,1);
	GivePlayerBankMoney(p,amount);
 	}
	case TEAM_FIREMEN:{
	SendClientMessage(p,COLOR_WHITE,"********* Payday *********");
	SendClientMessage(p,COLOR_WHITE,newstr);
	SendClientMessage(p,COLOR_WHITE,"**************************");
	SendClientMessage(p,COLOR_WHITE,"The department pays you...");
	SendClientMessage(p,COLOR_ORANGE,"         10000$          ");
	format(newstr,sizeof(newstr),"* Interest Gain: %d$ *",interest);
	SendClientMessage(p,COLOR_WHITE,newstr);
	format(newstr,sizeof(newstr),"* Business Gain: %d$ *",bizgain);
	SendClientMessage(p,COLOR_WHITE,newstr);
	amount = 10000 + interest + bizgain;
    SendClientMessage(p,COLOR_WHITE,"**************************");
   	format(newstr,sizeof(newstr),"* Overall Banked Payday Gain: %d$ *",amount);
	SendClientMessage(p,COLOR_ORANGE,newstr);
	format(newstr,sizeof(newstr),"~b~ %d$",amount);
	GameTextForPlayer(p,newstr,3999,1);
	GivePlayerBankMoney(p,amount);
 	}
	case TEAM_COPS:{
	SendClientMessage(p,COLOR_WHITE,"********* Payday *********");
	SendClientMessage(p,COLOR_WHITE,newstr);
	SendClientMessage(p,COLOR_WHITE,"**************************");
	SendClientMessage(p,COLOR_WHITE,"The department pays you...");
	SendClientMessage(p,COLOR_ORANGE,"         10000$          ");
	format(newstr,sizeof(newstr),"* Interest Gain: %d$ *",interest);
	SendClientMessage(p,COLOR_WHITE,newstr);
	format(newstr,sizeof(newstr),"* Business Gain: %d$ *",bizgain);
	SendClientMessage(p,COLOR_WHITE,newstr);
	amount = 10000 + interest + bizgain;
    SendClientMessage(p,COLOR_WHITE,"**************************");
   	format(newstr,sizeof(newstr),"* Overall Banked Payday Gain: %d$ *",amount);
	SendClientMessage(p,COLOR_ORANGE,newstr);
	format(newstr,sizeof(newstr),"~b~ %d$",amount);
	GameTextForPlayer(p,newstr,3999,1);
	GivePlayerBankMoney(p,amount);
 	}
}
}
}
if (Servertime==24) Servertime=0;
	if (Servertime<10) format(newstr,sizeof(newstr),"[server] ***** Payday ***** Worldtime 0%d:00h",Servertime);
	else format(newstr,sizeof(newstr),"[server] ***** Payday ***** Worldtime %d:00h",Servertime);
print (newstr);
WriteEcho(newstr);
return 1;
}

//---------------------------------------------------------
//Function

public RemoveTimer()
{
for(new r=0; r<MAX_PLAYERS; r++){
	if(IsPlayerConnected(r)){
		if (pInfo[r][Remove]){
		RemovePlayerFromVehicle(r);
		pInfo[r][driver] = 0;
		pInfo[r][Remove] = 0;
 		}
	}
}
return 1;
}

//---------------------------------------------------------
//Function

public BuyTimer()
{
for(new bt=0; bt<MAX_PLAYERS; bt++){
	if(IsPlayerConnected(bt)){
		if (pInfo[bt][buytimer]) TogglePlayerControllable(bt,false);
   	}
}
return 1;
}

//---------------------------------------------------------
//Function

public WantedTimer()
{
for(new wt=0; wt<MAX_PLAYERS; wt++){
	if(IsPlayerConnected(wt)){
		if (pInfo[wt][AddWanted]){
		pInfo[wt][AddWanted] = 0;
		pInfo[wt][WantedLevel] = pInfo[wt][WantedLevel] + 1;
		SetPlayerWantedLevel(wt,pInfo[wt][WantedLevel]);
 		}
 	}
}
return 1;
}

//---------------------------------------------------------
//Function

public JoinBurn()
{
for(new jb=0; jb<MAX_PLAYERS; jb++){
	if(IsPlayerConnected(jb) && Minigames[BurnPrepare] && pInfo[jb][PlayBurn]){

if (!pInfo[jb][isPreparing]) pInfo[jb][isPreparing] = 1;


   		switch (gTeam[jb]){
    		case TEAM_CIVS:{
	    	SetPlayerInterior(jb,0);
		    SetPlayerPos(jb,1146.0000,1267.0000,11.0000);
		    GameTextForPlayer(jb,"~w~ Wait here!~r~Dont DM.",10000,5);
		    }
		    case TEAM_SENIORS:{
		    SetPlayerInterior(jb,0);
		    SetPlayerPos(jb,1146.0000,1267.0000,11.0000);
		    GameTextForPlayer(jb,"~w~ Wait here!~r~Dont DM.",10000,5);
		    }
		    case TEAM_WAITERS:{
		    SetPlayerInterior(jb,0);
		    SetPlayerPos(jb,1146.0000,1267.0000,11.0000);
		    GameTextForPlayer(jb,"~w~ Wait here!~r~Dont DM.",10000,5);
		    }
		    case TEAM_CRIMINALS:{
		    SetPlayerInterior(jb,0);
		    SetPlayerPos(jb,1146.0000,1267.0000,11.0000);
		    GameTextForPlayer(jb,"~w~ Wait here!~r~Dont DM.",10000,5);
		    }
		    case TEAM_SECURITIES:{
		    SetPlayerInterior(jb,0);
		    SetPlayerPos(jb,194.0000,1876.0000,18.0000);
		    GameTextForPlayer(jb,"~g~ Get in position~r~ You will get M4 with endless munition. Dont DM.",10000,5);
		    }
		    case TEAM_PILOTS:{
		    SetPlayerInterior(jb,0);
		    SetPlayerPos(jb,194.0000,1876.0000,18.0000);
		    GameTextForPlayer(jb,"~g~ Get in position~r~ You will get a M4 with endless munition. Dont DM.",10000,5);
		    }
		    case TEAM_ENTERTAINERS:{
		    SetPlayerInterior(jb,0);
		    SetPlayerPos(jb,1146.0000,1267.0000,11.0000);
		    GameTextForPlayer(jb,"~w~ Wait here!~r~Dont DM.",10000,5);
		    }
			case TEAM_MEDICS:{
		    SetPlayerInterior(jb,0);
		    SetPlayerPos(jb,194.0000,1876.0000,18.0000);
		    GameTextForPlayer(jb,"~g~ Get in position~r~ You will get a M4 with endless munition. Dont DM.",10000,5);
		    }
		    case TEAM_FIREMEN:{
		    SetPlayerInterior(jb,0);
		    SetPlayerPos(jb,1735.0000,2113.0000,12.0000);
		    GameTextForPlayer(jb,"~g~ Drive to Area 69~r~ You have to prevent fires from spreading. Help the defenders.",10000,5);
		    GivePlayerWeapon(jb,42,100000);
		    }
		    case TEAM_COPS:{
		    SetPlayerInterior(jb,0);
		    SetPlayerPos(jb,194.0000,1876.0000,18.0000);
		    GameTextForPlayer(jb,"~g~ Get in position~r~ You will get a M4 with endless munition. Dont DM.",10000,5);
		    }
		}
	}
}
return 1;
}

//---------------------------------------------------------
//Function

public JoinDerby()
{
for(new jd=0; jd<MAX_PLAYERS; jd++){
	if(IsPlayerConnected(jd) && Minigames[DerbyPrepare] && pInfo[jd][PlayDerby]){

if (!pInfo[jd][isPreparing]) pInfo[jd][isPreparing] = 1;

	SetPlayerInterior(jd,0);
    SetPlayerPos(jd,1544.0000,-1354.0000,329.0000);
        GameTextForPlayer(jd,"~w~ Get in a ~g~Patriot.~r~ /sell before. Dont jump/drive. Dont DM.",10000,5);
	}
}
return 1;
}

//---------------------------------------------------------
//Function

public JoinBurnTimeout()
{
Minigames[BurnPrepare] = 0;
Minigames[BurnRunning] = 1;

for(new jbt=0; jbt<MAX_PLAYERS; jbt++){
	if(IsPlayerConnected(jbt) && pInfo[jbt][PlayBurn]){
	
pInfo[jbt][isPreparing] = 0;

   		switch (gTeam[jbt]){
    		case TEAM_CIVS:{
    		SetPlayerColor(jbt,COLOR_RED);
	    	SetPlayerInterior(jbt,0);
		    SetPlayerPos(jbt,194.0000,1876.0000,1800.0000 + (jbt * 3));
		    GivePlayerWeapon(jbt,46,1);
	    	GameTextForPlayer(jbt,"~g~ Go! Go! Go!",5000,5);
		    }
		    case TEAM_SENIORS:{
       		SetPlayerColor(jbt,COLOR_RED);
		    SetPlayerInterior(jbt,0);
		    SetPlayerPos(jbt,194.0000,1876.0000,1800.0000 + (jbt * 3));
   		    GivePlayerWeapon(jbt,46,1);
		    GameTextForPlayer(jbt,"~g~ Go! Go! Go!",5000,5);
		    }
		    case TEAM_WAITERS:{
		    SetPlayerColor(jbt,COLOR_RED);
		    SetPlayerInterior(jbt,0);
		    SetPlayerPos(jbt,194.0000,1876.0000,1800.0000 + (jbt * 3));
		    GivePlayerWeapon(jbt,46,1);
		    GameTextForPlayer(jbt,"~g~ Go! Go! Go!",5000,5);
		    }
		    case TEAM_CRIMINALS:{
		    SetPlayerColor(jbt,COLOR_RED);
		    SetPlayerInterior(jbt,0);
		    SetPlayerPos(jbt,194.0000,1876.0000,1800.0000 + (jbt * 3));
		    GivePlayerWeapon(jbt,46,1);
		    GameTextForPlayer(jbt,"~g~ Go! Go! Go!",5000,5);
		    }
		    case TEAM_SECURITIES:{
		    SetPlayerColor(jbt,COLOR_LIGHTGREEN);
			GameTextForPlayer(jbt,"~g~ Go! Go! Go!",5000,5);
		    GivePlayerWeapon(jbt,31,100000);
		    }
		    case TEAM_PILOTS:{
		    SetPlayerColor(jbt,COLOR_LIGHTGREEN);
		    GameTextForPlayer(jbt,"~g~ Go! Go! Go!",5000,5);
		    GivePlayerWeapon(jbt,31,100000);
		    }
		    case TEAM_ENTERTAINERS:{
		    SetPlayerColor(jbt,COLOR_RED);
      		SetPlayerInterior(jbt,0);
		    SetPlayerPos(jbt,194.0000,1876.0000,1800.0000 + (jbt * 3));
		    GivePlayerWeapon(jbt,46,1);
		    GameTextForPlayer(jbt,"~g~ Go! Go! Go!",5000,5);
		    }
			case TEAM_MEDICS:{
			SetPlayerColor(jbt,COLOR_LIGHTGREEN);
		    GameTextForPlayer(jbt,"~g~ Go! Go! Go!",5000,5);
		    GivePlayerWeapon(jbt,31,100000);
		    }
		    case TEAM_FIREMEN:{
			SetPlayerColor(jbt,COLOR_LIGHTGREEN);
			GameTextForPlayer(jbt,"~g~ Go! Go! Go!",5000,5);
		    GivePlayerWeapon(jbt,31,100000);
		    }
		    case TEAM_COPS:{
		    SetPlayerColor(jbt,COLOR_LIGHTGREEN);
		    GameTextForPlayer(jbt,"~g~ Go! Go! Go!",5000,5);
		    GivePlayerWeapon(jbt,31,100000);
		    }
		}
	}
}
return 1;
}

//---------------------------------------------------------
//Function

public DoBurnRespawn(br)
{
if(IsPlayerConnected(br) && pInfo[br][BurnRespawn]){

pInfo[br][isPreparing] = 0;
pInfo[br][BurnRespawn] = 0;

   		switch (gTeam[br]){
    		case TEAM_CIVS:{
    		SetPlayerColor(br,COLOR_RED);
	    	SetPlayerInterior(br,0);
		    SetPlayerPos(br,194.0000,1876.0000,1800.0000 + (br * 3));
		    GivePlayerWeapon(br,46,1);
	    	GameTextForPlayer(br,"~g~ Go! Go! Go!",5000,5);
		    }
		    case TEAM_SENIORS:{
       		SetPlayerColor(br,COLOR_RED);
		    SetPlayerInterior(br,0);
		    SetPlayerPos(br,194.0000,1876.0000,1800.0000 + (br * 3));
   		    GivePlayerWeapon(br,46,1);
		    GameTextForPlayer(br,"~g~ Go! Go! Go!",5000,5);
		    }
		    case TEAM_WAITERS:{
		    SetPlayerColor(br,COLOR_RED);
		    SetPlayerInterior(br,0);
		    SetPlayerPos(br,194.0000,1876.0000,1800.0000 + (br * 3));
		    GivePlayerWeapon(br,46,1);
		    GameTextForPlayer(br,"~g~ Go! Go! Go!",5000,5);
		    }
		    case TEAM_CRIMINALS:{
		    SetPlayerColor(br,COLOR_RED);
		    SetPlayerInterior(br,0);
		    SetPlayerPos(br,194.0000,1876.0000,1800.0000 + (br * 3));
		    GivePlayerWeapon(br,46,1);
		    GameTextForPlayer(br,"~g~ Go! Go! Go!",5000,5);
		    }
		    case TEAM_SECURITIES:{
		    SetPlayerColor(br,COLOR_LIGHTGREEN);
		    SetPlayerPos(br,194.0000,1876.0000,18.0000);
			GameTextForPlayer(br,"~g~ Go! Go! Go!",5000,5);
		    GivePlayerWeapon(br,31,100000);
		    }
		    case TEAM_PILOTS:{
		    SetPlayerColor(br,COLOR_LIGHTGREEN);
		    SetPlayerPos(br,194.0000,1876.0000,18.0000);
		    GameTextForPlayer(br,"~g~ Go! Go! Go!",5000,5);
		    GivePlayerWeapon(br,31,100000);
		    }
		    case TEAM_ENTERTAINERS:{
		    SetPlayerColor(br,COLOR_RED);
      		SetPlayerInterior(br,0);
		    SetPlayerPos(br,194.0000,1876.0000,1800.0000 + (br * 3));
		    GivePlayerWeapon(br,46,1);
		    GameTextForPlayer(br,"~g~ Go! Go! Go!",5000,5);
		    }
			case TEAM_MEDICS:{
			SetPlayerColor(br,COLOR_LIGHTGREEN);
			SetPlayerPos(br,194.0000,1876.0000,18.0000);
		    GameTextForPlayer(br,"~g~ Go! Go! Go!",5000,5);
		    GivePlayerWeapon(br,31,100000);
		    }
		    case TEAM_FIREMEN:{
			SetPlayerColor(br,COLOR_LIGHTGREEN);
			SetPlayerPos(br,194.0000,1876.0000,18.0000);
			GameTextForPlayer(br,"~g~ Go! Go! Go!",5000,5);
		    GivePlayerWeapon(br,31,100000);
		    }
		    case TEAM_COPS:{
		    SetPlayerColor(br,COLOR_LIGHTGREEN);
		    SetPlayerPos(br,194.0000,1876.0000,18.0000);
		    GameTextForPlayer(br,"~g~ Go! Go! Go!",5000,5);
		    GivePlayerWeapon(br,31,100000);
		    }
		}
	}

return 1;
}

//---------------------------------------------------------
//Function

public JoinDerbyTimeout()
{
Minigames[DerbyPrepare] = 0;
Minigames[DerbyRunning] = 1;

for(new jdt=0; jdt<MAX_PLAYERS; jdt++){

	if(IsPlayerConnected(jdt) && pInfo[jdt][PlayDerby]){
	pInfo[jdt][isPreparing] = 0;
	GameTextForPlayer(jdt,"~g~ Go! Go! Go!",5000,5);
	TogglePlayerControllable(jdt,true);
	}
}
return 1;
}

//---------------------------------------------------------
//Function

public BurnEnd()
{
Minigames[BurnPrepare] = 0;
Minigames[BurnRunning] = 0;
KillTimer(LastGame);
ShowPlayerMarkers(1);

for(new be=0; be<MAX_PLAYERS; be++){

	if (IsPlayerConnected(be)){
	pInfo[be][PlayBurn] = 0;
	ResetPlayerWeapons(be);
	GameTextForPlayer(be,"~g~Game ~r~ended.",5000,5);
	}

	if(pInfo[be][PlayBurn]){
	SetPlayerToTeamColor(be);
	SetPlayerToSpawn(be);
	}
}
return 1;
}

//---------------------------------------------------------
//Function

public DerbyEnd()
{
Minigames[DerbyPrepare] = 0;
Minigames[DerbyRunning] = 0;
KillTimer(LastGame);

for(new de=0; de<MAX_PLAYERS; de++){
	if(IsPlayerConnected(de)){
	pInfo[de][PlayDerby] = 0;
	GameTextForPlayer(de,"~g~Game ~r~ended.",5000,5);
	}
	
	if(pInfo[de][PlayDerby]){
	SetPlayerToTeamColor(de);
	SetPlayerToSpawn(de);
	}
}
return 1;
}

//---------------------------------------------------------
//Function

public FuelTimer()
{
new str[20];
for(new ft=0; ft<MAX_PLAYERS; ft++){
if(IsPlayerConnected(ft)){

		if (pInfo[ft][BurnRespawn]){
		DoBurnRespawn(ft);
		}

	if (pInfo[ft][driver]){
        pInfo[ft][fuel] = pInfo[ft][fuel] - 1;
		format(str,sizeof(str),"~g~ Fuel: %d%",pInfo[ft][fuel]);
		GameTextForPlayer(ft,str,17000,1);
		
		if (pInfo[ft][fuel]<21) SendClientMessage(ft,COLOR_RED,"*** FUEL WARNING!!! Use /fuel to refill!! ***");
		if (pInfo[ft][fuel]<=0) {
		SendClientMessage(ft,COLOR_RED,"You are out of fuel and stranded.");
		RemovePlayerFromVehicle(ft);
		pInfo[ft][driver] = 0;
		SendClientMessage(ft,COLOR_YELLOW,"/sell OR /find give you a reserve of 10% fuel.");
				}
  		}
  	}
  }
return 1;
}

//---------------------------------------------------------
//Function

public AdTimer()
{
new str[225],player[24];
for(new at=0; at<MAX_PLAYERS; at++){
if(IsPlayerConnected(at)){

	if (AdID == 1){
        pInfo[at][Ad] = 0;
        pInfo[at][Rob] = 0;
	    AdID = 2;
		SendClientMessageToAll(COLOR_WHITE,"Be part of the great Pure RPG player community:");
		SendClientMessageToAll(COLOR_WHITE,"---> --> ---> www.pure-rpg.de.tc <--- <--- <---");
		return 1;
		}

	if (AdID == 2){
        pInfo[at][Ad] = 0;
        pInfo[at][Rob] = 0;
	    AdID = 3;
		SendClientMessageToAll(COLOR_WHITE,"Tired of spawning at the same boring public spot?");
		SendClientMessageToAll(COLOR_WHITE,"www.pure-rpg.de.tc <-- Information on how to get a house");
		return 1;
		}
		
	if (AdID == 3){
	    pInfo[at][Ad] = 0;
	    pInfo[at][Rob] = 0;
	    AdID = 4;
		SendClientMessageToAll(COLOR_WHITE,"Want more money quick, a house, an own vehicle?");
		SendClientMessageToAll(COLOR_WHITE,"www.pure-rpg.de.tc <--- Inform yourself about donations soon");
		return 1;
		}

	if (AdID == 4){
	    pInfo[at][Ad] = 0;
	    pInfo[at][Rob] = 0;
	    AdID = 1;
	    GetPlayerName(at,player,sizeof(player));
	    format (str,sizeof(str),"Want to get an e-mail address? %s@pure-rpg.de.tc",player);
		SendClientMessage(at,COLOR_WHITE,str);
		SendClientMessage(at,COLOR_WHITE,"www.pure-rpg.de.tc <--- Inform yourself about donations soon");
		return 1;
		}

  	}
  }
return 1;
}


//---------------------------------------------------------
//Function

public SetPlayerToTeamColor(playerid)
{
if (!pInfo[playerid][JoinTeam]) gTeam[playerid] = GetPlayerTeam(playerid);

switch (gTeam[playerid]) {
	case TEAM_CIVS: SetPlayerColor(playerid,COLOR_WHITE); 
	case TEAM_SENIORS: SetPlayerColor(playerid,COLOR_WHITE); 
	case TEAM_WAITERS: SetPlayerColor(playerid,COLOR_LIGHTBLUE); 
	case TEAM_CRIMINALS: SetPlayerColor(playerid,COLOR_ORANGE);
	case TEAM_SECURITIES: SetPlayerColor(playerid,COLOR_LIGHTBLUE); 
	case TEAM_PILOTS: SetPlayerColor(playerid,COLOR_YELLOW); 
	case TEAM_ENTERTAINERS: SetPlayerColor(playerid,COLOR_BRIGHTRED);
	case TEAM_MEDICS: SetPlayerColor(playerid,COLOR_PINK);
	case TEAM_FIREMEN: SetPlayerColor(playerid,COLOR_RED);
	case TEAM_COPS: SetPlayerColor(playerid,BBLUE);
	}
}
//---------------------------------------------------------
//Function

public SetupPlayerForClassSelection(playerid)
{
	// Set the player's orientation when they're selecting a class.
	SetPlayerPos(playerid,1685.5280,-2240.3850,13.5469);
	SetPlayerCameraPos(playerid,1685.5280,-2237.3850,13.5469);
	SetPlayerCameraLookAt(playerid,1685.5280,-2240.3850,13.5469);
	SetPlayerFacingAngle(playerid,0.0);
	PlayerPlaySound(playerid, 1062, 1685.5280,-2240.3850,13.5469);
}


//---------------------------------------------------------
//Callback

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
new player[24],vname[24],entermsg[120];
GetPlayerName(playerid,player,sizeof(player));
if (ispassenger!=0){
pInfo[playerid][driver] = 0;
return 1;
}

pInfo[playerid][driver] = 1;

if (Minigames[DerbyPrepare] && pInfo[playerid][PlayDerby]){
	pInfo[playerid][buytimer] = 1;
	SetTimer("BuyTimer",3000,0);
	SendClientMessage(playerid,COLOR_RED,"You cant drive this until the Derby started.");
	return 1;
	}

if (gTeam[playerid] != TEAM_PILOTS && vehicleid == 139){
	SendClientMessage(playerid,COLOR_RED,"(Remove) You are not licensed to control or own this vehicle. Ownership removed.");
	SendClientMessage(playerid,COLOR_YELLOW,"You need to be in the pilot role to become the charter pilot!");
	pInfo[playerid][Remove] = 1;
	return 1;
	}

if (ispassenger == 0){
	for (new v=0;v<MAX_PLAYERS;v++){
		if (IsPlayerConnected(v)){
	    	if (pInfo[v][vehicle] == vehicleid && pInfo[playerid][vehicle]!=vehicleid){
	    	GetPlayerName(v,vname,sizeof(vname));
	    	pInfo[playerid][vehicle] = vehicleid;
			pInfo[v][vehicle] = 0;
	    	SendClientMessage(playerid,COLOR_RED,"You have been jacked. The insurance paid 5000$ rest value for your vehicle");
	    	GivePlayerBankMoney(v,5000);
	   		format(entermsg,sizeof(entermsg),"(Car Theft) This vehicle belongs to %s (ID %d)",vname,v);
	    	SendClientMessage(playerid,COLOR_RED,entermsg);
	    	format(entermsg,sizeof(entermsg),"[Breaking News] GTA!! GTA!! GRAND THEFT AUTO!!! %s got his vehicle stolen!!!",vname);
			SendClientMessageToAll(COLOR_RED,entermsg);
	    	SendClientMessage(playerid,COLOR_RED,"(Wanted) You are now a wanted criminal for vehicle theft.");
	    	format(entermsg,sizeof(entermsg),"~r~(Vehicle) %s (ID %d) entered your vehicle. ~n~ ~w~He is now a wanted criminal for vehicle theft.",player,playerid);
	    	GameTextForPlayer(v,entermsg,3333,5);
	    	}
		}
	}
}

if (ispassenger == 0 && vehicleid!=pInfo[playerid][vehicle]){
      if (vehicleid > 18 && vehicleid < 128){
		SendClientMessage(playerid,COLOR_RED, "This is not your vehicle - /buy this vehicle to be able to drive it.");
		pInfo[playerid][buytimer] = 1;
		SetTimer("BuyTimer",3000,0);
		pInfo[playerid][invehicle] = vehicleid;
		SendClientMessage(playerid,COLOR_YELLOW, "Type /buy or /exit");
		return 1;
		}
		if (vehicleid > 127 || vehicleid < 19) GameTextForPlayer(playerid,"~y~ This is a public vehicle. ~r~ You cannot own it!",3333,5);
}


if (pInfo[playerid][vehicle] == vehicleid){
DisablePlayerCheckpoint(playerid);
GameTextForPlayer(playerid,"~g~This is your vehicle",3333,5);
return 1;
}
return 1;
}

//---------------------------------------------------------
//Callback
public OnPlayerExitVehicle(playerid, vehicleid)
{
    pInfo[playerid][driver] = 0;

	if (playerid == LSPilot && !LSFlight[OnBlocks] && LSFlight[Flying]){
	LSPilot = -1;
	SendClientMessage(playerid,COLOR_RED,"The airline fired you because you left your plane before the flight was complete.");
	SendClientMessageToAll(BBLUE,"The charter pilot position in LS became vacant. Get a jet and enter /charter to be the next one.");
	return 1;
	}
	
	if (playerid == SFPilot && !SFFlight[OnBlocks] && SFFlight[Flying]){
	SFPilot = -1;
	SendClientMessage(playerid,COLOR_RED,"The airline fired you because you left your plane before the flight was complete.");
	SendClientMessageToAll(BBLUE,"The charter pilot position in SF became vacant. Get a jet and enter /charter to be the next one.");
	return 1;
	}
	
	if (playerid == LVPilot && !LVFlight[OnBlocks] && LVFlight[Flying]){
	LVPilot = -1;
	SendClientMessage(playerid,COLOR_RED,"The airline fired you because you left your plane before the flight was complete.");
	SendClientMessageToAll(BBLUE,"The charter pilot position in LV became vacant. Get a jet and enter /charter to be the next one.");
	return 1;
	}

	if (pInfo[playerid][vehicle] == vehicleid){
		new Float:posX;
		new Float:posY;
		new Float:posZ;

		GetPlayerPos(playerid,posX,posY,posZ);


		pInfo[playerid][FindX] = floatround(posX);
		pInfo[playerid][FindY] = floatround(posY);
		pInfo[playerid][FindZ] = floatround(posZ);
		}

return 1;
}
//---------------------------------------------------------
//Callback Edited
public OnGameModeInit()
{
	SetGameModeText("Pure RPG v.1.4"); //
	ShowNameTags(1);
	ShowPlayerMarkers(0);
	EnableTirePopping(1);
	Servertime = strval(dini_Get("Servertime","Time"));
	ServerMinute = 0;
	SetWorldTime(Servertime);
	print(" \n");
	printf("***** SERVER INITIALIZED ***** - Worldtime %d",Servertime);
	
	SetTimer("AC2",1280,1);
	SetTimer("Anticheat",900,1);
 	SetTimer("Sec",999,1);// 1000 ms = 1 sec
	SetTimer("CheckAutoKick",5003,1); //  (5 seconds)
//	SetTimer("Payday",3600000,1);//  (1 hour)
	SetTimer("RemoveTimer",10004,1); //  (10 seconds)
	SetTimer("WantedTimer",505,1); //  (0,5 seconds)
	SetTimer("CheckSOS",1006,1);//  (1 second)
	SetTimer("CheckSOS2",3007,1);//  (3 seconds)
	SetTimer("FuelTimer",18008,1);//  (18 seconds)
	SetTimer("AdTimer",897000,1);//  (14 minutes, 57 seconds)
	
	
//Class re-assignment including teams,co-ordinates and weapons
	
AddPlayerClassEx(1,7,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);//Team 1 (Civilists)
AddPlayerClassEx(1,12,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 0-91
AddPlayerClassEx(1,16,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 2
AddPlayerClassEx(1,17,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 3
AddPlayerClassEx(1,18,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 4
AddPlayerClassEx(1,19,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 5
AddPlayerClassEx(1,20,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 6
AddPlayerClassEx(1,21,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 7
AddPlayerClassEx(1,23,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 8
AddPlayerClassEx(1,26,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 9
AddPlayerClassEx(1,27,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 10
AddPlayerClassEx(1,34,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 11
AddPlayerClassEx(1,35,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 12
AddPlayerClassEx(1,36,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 13
AddPlayerClassEx(1,37,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 14
AddPlayerClassEx(1,40,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 15
AddPlayerClassEx(1,45,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 16
AddPlayerClassEx(1,50,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 17
AddPlayerClassEx(1,51,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 18
AddPlayerClassEx(1,52,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 19
AddPlayerClassEx(1,55,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 20
AddPlayerClassEx(1,56,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 21
AddPlayerClassEx(1,59,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 22
AddPlayerClassEx(1,60,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 23
AddPlayerClassEx(1,67,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 24
AddPlayerClassEx(1,69,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 25
AddPlayerClassEx(1,72,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 26
AddPlayerClassEx(1,73,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 27
AddPlayerClassEx(1,80,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 28
AddPlayerClassEx(1,81,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 29
AddPlayerClassEx(1,91,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 30
AddPlayerClassEx(1,96,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 31
AddPlayerClassEx(1,97,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 32
AddPlayerClassEx(1,99,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 33
AddPlayerClassEx(1,101,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 34
AddPlayerClassEx(1,138,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 35
AddPlayerClassEx(1,139,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 36
AddPlayerClassEx(1,140,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 37
AddPlayerClassEx(1,141,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 38
AddPlayerClassEx(1,142,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 39
AddPlayerClassEx(1,147,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 40
AddPlayerClassEx(1,148,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 41
AddPlayerClassEx(1,151,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 42
AddPlayerClassEx(1,153,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 43
AddPlayerClassEx(1,154,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 44
AddPlayerClassEx(1,157,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 45
AddPlayerClassEx(1,169,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 46
AddPlayerClassEx(1,170,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 47
AddPlayerClassEx(1,176,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 48
AddPlayerClassEx(1,177,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 49
AddPlayerClassEx(1,180,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 50
AddPlayerClassEx(1,185,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 51
AddPlayerClassEx(1,186,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 52
AddPlayerClassEx(1,187,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 53
AddPlayerClassEx(1,188,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 54
AddPlayerClassEx(1,190,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 55
AddPlayerClassEx(1,191,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 56
AddPlayerClassEx(1,192,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 57
AddPlayerClassEx(1,198,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 58
AddPlayerClassEx(1,199,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 59
AddPlayerClassEx(1,201,-1974.0000,128.0000,28.0000,4.0000,14,1,0,0,-1,-1);// Class 60
AddPlayerClassEx(1,202,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 61
AddPlayerClassEx(1,203,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 62
AddPlayerClassEx(1,204,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 63
AddPlayerClassEx(1,206,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 64
AddPlayerClassEx(1,211,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 65
AddPlayerClassEx(1,214,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 66
AddPlayerClassEx(1,215,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 67
AddPlayerClassEx(1,216,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 68
AddPlayerClassEx(1,219,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 69
AddPlayerClassEx(1,221,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 70
AddPlayerClassEx(1,222,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 71
AddPlayerClassEx(1,223,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 72
AddPlayerClassEx(1,226,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 73
AddPlayerClassEx(1,227,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 74
AddPlayerClassEx(1,233,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 75
AddPlayerClassEx(1,240,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 76
AddPlayerClassEx(1,241,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 77
AddPlayerClassEx(1,242,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 78
AddPlayerClassEx(1,250,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 79
AddPlayerClassEx(1,251,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 80
AddPlayerClassEx(1,252,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 81
AddPlayerClassEx(1,258,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 82
AddPlayerClassEx(1,259,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 83
AddPlayerClassEx(1,260,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 84
AddPlayerClassEx(1,261,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 85
AddPlayerClassEx(1,262,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 86
AddPlayerClassEx(1,263,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 87
AddPlayerClassEx(1,290,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 88
AddPlayerClassEx(1,291,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 89
AddPlayerClassEx(1,296,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 90
AddPlayerClassEx(1,297,2124.0000,1146.0000,14.0000,241.0000,14,1,0,0,-1,-1);// Class 91
AddPlayerClassEx(2,9,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);//Team 2 (Seniors)
AddPlayerClassEx(2,10,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);//Class 92 - 156
AddPlayerClassEx(2,14,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);// Class 94
AddPlayerClassEx(2,15,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);// Class 95
AddPlayerClassEx(2,31,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);// Class 96
AddPlayerClassEx(2,32,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);// Class 97
AddPlayerClassEx(2,33,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);// Class 98
AddPlayerClassEx(2,38,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);// Class 99
AddPlayerClassEx(2,39,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);// Class 100
AddPlayerClassEx(2,43,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);// Class 101
AddPlayerClassEx(2,44,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);// Class 102
AddPlayerClassEx(2,49,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);// Class 103
AddPlayerClassEx(2,53,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);// Class 104
AddPlayerClassEx(2,54,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);// Class 105
AddPlayerClassEx(2,57,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);// Class 106
AddPlayerClassEx(2,58,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);// Class 107
AddPlayerClassEx(2,62,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);// Class 108
AddPlayerClassEx(2,68,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);// Class 109
AddPlayerClassEx(2,75,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);// Class 110
AddPlayerClassEx(2,76,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);// Class 111
AddPlayerClassEx(2,77,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);// Class 112
AddPlayerClassEx(2,78,-381.0000,-1439.0000,26.0000,270.0000,15,1,0,0,-1,-1);// Class 113
AddPlayerClassEx(2,79,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 114
AddPlayerClassEx(2,88,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 115
AddPlayerClassEx(2,89,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 116
AddPlayerClassEx(2,93,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 117
AddPlayerClassEx(2,94,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 118
AddPlayerClassEx(2,95,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 119
AddPlayerClassEx(2,128,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 120
AddPlayerClassEx(2,129,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 121
AddPlayerClassEx(2,130,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 122
AddPlayerClassEx(2,132,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 123
AddPlayerClassEx(2,133,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 124
AddPlayerClassEx(2,134,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 125
AddPlayerClassEx(2,135,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 126
AddPlayerClassEx(2,136,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 127
AddPlayerClassEx(2,137,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 128
AddPlayerClassEx(2,150,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 129
AddPlayerClassEx(2,156,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 130
AddPlayerClassEx(2,158,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 131
AddPlayerClassEx(2,159,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 132
AddPlayerClassEx(2,160,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 133
AddPlayerClassEx(2,161,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 134
AddPlayerClassEx(2,162,-26.0000,75.0000,3.0000,73.0000,15,1,0,0,-1,-1);// Class 135
AddPlayerClassEx(2,182,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 136
AddPlayerClassEx(2,183,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 137
AddPlayerClassEx(2,196,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 138
AddPlayerClassEx(2,197,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 139
AddPlayerClassEx(2,200,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 140
AddPlayerClassEx(2,210,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 141
AddPlayerClassEx(2,212,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 142
AddPlayerClassEx(2,213,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 143
AddPlayerClassEx(2,218,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 144
AddPlayerClassEx(2,220,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 145
AddPlayerClassEx(2,224,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 146
AddPlayerClassEx(2,225,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 147
AddPlayerClassEx(2,228,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 148
AddPlayerClassEx(2,229,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 149
AddPlayerClassEx(2,230,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 150
AddPlayerClassEx(2,231,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 151
AddPlayerClassEx(2,232,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 152
AddPlayerClassEx(2,234,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 153
AddPlayerClassEx(2,235,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 154
AddPlayerClassEx(2,236,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 155
AddPlayerClassEx(2,239,-672.0000,2708.0000,71.0000,333.0000,15,1,0,0,-1,-1);// Class 156
AddPlayerClassEx(3,11,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);//Team 3 (Waiters)
AddPlayerClassEx(3,155,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);//Class 157 - 168
AddPlayerClassEx(3,167,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);// Class 159
AddPlayerClassEx(3,168,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);// Class 160
AddPlayerClassEx(3,171,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);// Class 161
AddPlayerClassEx(3,172,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);// Class 162
AddPlayerClassEx(3,179,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);// Class 163
AddPlayerClassEx(3,189,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);// Class 164
AddPlayerClassEx(3,194,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);// Class 165
AddPlayerClassEx(3,205,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);// Class 166
AddPlayerClassEx(3,209,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);// Class 167
AddPlayerClassEx(3,253,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);// Class 168
AddPlayerClassEx(4,13,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);//Team 4 (Criminals)
AddPlayerClassEx(4,22,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);//Class 169 - 221
AddPlayerClassEx(4,28,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 171 LS
AddPlayerClassEx(4,195,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 172 LS
AddPlayerClassEx(4,30,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 173 LS
AddPlayerClassEx(4,292,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 174 LS
AddPlayerClassEx(4,293,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 175 LS
AddPlayerClassEx(4,173,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 176 LS
AddPlayerClassEx(4,174,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 177 LS
AddPlayerClassEx(4,175,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 178 LS
AddPlayerClassEx(4,100,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 179 LS
AddPlayerClassEx(4,102,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 180 LS
AddPlayerClassEx(4,103,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 181 LS
AddPlayerClassEx(4,104,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 182 LS
AddPlayerClassEx(4,105,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 183 LS
AddPlayerClassEx(4,106,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 184 LS
AddPlayerClassEx(4,107,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 185 LS
AddPlayerClassEx(4,108,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 186 LS
AddPlayerClassEx(4,109,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 187 LS
AddPlayerClassEx(4,110,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 188 LS
AddPlayerClassEx(4,111,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 189 LS
AddPlayerClassEx(4,112,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 190 LS
AddPlayerClassEx(4,113,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 191 LS
AddPlayerClassEx(4,114,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 192 LS
AddPlayerClassEx(4,115,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 193 LS
AddPlayerClassEx(4,116,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 194 LS
AddPlayerClassEx(4,0,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 195 LS
AddPlayerClassEx(4,117,-1974.0000,128.0000,28.0000,4.0000,5,1,22,30,-1,-1);// Class 196 SF
AddPlayerClassEx(4,118,-1974.0000,128.0000,28.0000,4.0000,5,1,22,30,-1,-1);// Class 197 SF
AddPlayerClassEx(4,120,-1974.0000,128.0000,28.0000,4.0000,5,1,22,30,-1,-1);// Class 198 SF
AddPlayerClassEx(4,121,-1974.0000,128.0000,28.0000,4.0000,5,1,22,30,-1,-1);// Class 199 SF
AddPlayerClassEx(4,122,-1974.0000,128.0000,28.0000,4.0000,5,1,22,30,-1,-1);// Class 201 SF
AddPlayerClassEx(4,123,-1974.0000,128.0000,28.0000,4.0000,5,1,22,30,-1,-1);// Class 201 SF
AddPlayerClassEx(4,126,-1974.0000,128.0000,28.0000,4.0000,5,1,22,30,-1,-1);// Class 202 SF
AddPlayerClassEx(4,127,-1974.0000,128.0000,28.0000,4.0000,5,1,22,30,-1,-1);// Class 203 SF
AddPlayerClassEx(4,143,-1974.0000,128.0000,28.0000,4.0000,5,1,22,30,-1,-1);// Class 204 SF
AddPlayerClassEx(4,294,-1974.0000,128.0000,28.0000,4.0000,5,1,22,30,-1,-1);// Class 205 SF
AddPlayerClassEx(4,41,-1974.0000,128.0000,28.0000,4.0000,5,1,22,30,-1,-1);// Class 206 SF
AddPlayerClassEx(4,46,-1974.0000,128.0000,28.0000,4.0000,5,1,22,30,-1,-1);// Class 207 SF
AddPlayerClassEx(4,47,-1974.0000,128.0000,28.0000,4.0000,5,1,22,30,-1,-1);// Class 208 SF
AddPlayerClassEx(4,48,-1974.0000,128.0000,28.0000,4.0000,5,1,22,30,-1,-1);// Class 209 SF
AddPlayerClassEx(4,98,-1974.0000,128.0000,28.0000,4.0000,5,1,22,30,-1,-1);// Class 210 SF
AddPlayerClassEx(4,181,2124.0000,1146.0000,14.0000,241.0000,5,1,22,30,-1,-1);// Class 211 LV
AddPlayerClassEx(4,184,2124.0000,1146.0000,14.0000,241.0000,5,1,22,30,-1,-1);// Class 212 LV
AddPlayerClassEx(4,29,2124.0000,1146.0000,14.0000,241.0000,5,1,22,30,-1,-1);// Class 213 LV
AddPlayerClassEx(4,247,2124.0000,1146.0000,14.0000,241.0000,5,1,22,30,-1,-1);// Class 214 LV
AddPlayerClassEx(4,248,2124.0000,1146.0000,14.0000,241.0000,5,1,22,30,-1,-1);// Class 215 LV
AddPlayerClassEx(4,249,2124.0000,1146.0000,14.0000,241.0000,5,1,22,30,-1,-1);// Class 216 LV
AddPlayerClassEx(4,254,2124.0000,1146.0000,14.0000,241.0000,5,1,22,30,-1,-1);// Class 217 LV
AddPlayerClassEx(4,145,2124.0000,1146.0000,14.0000,241.0000,5,1,22,30,-1,-1);// Class 218 LV
AddPlayerClassEx(4,146,2124.0000,1146.0000,14.0000,241.0000,5,1,22,30,-1,-1);// Class 219 LV
AddPlayerClassEx(4,144,2124.0000,1146.0000,14.0000,241.0000,5,1,22,30,-1,-1);// Class 220 LV
AddPlayerClassEx(4,298,2124.0000,1146.0000,14.0000,241.0000,5,1,22,30,-1,-1);// Class 221 LV
AddPlayerClassEx(5,24,1685.5280,-2240.3850,13.5469,179.7263,3,1,23,30,-1,-1);//Team 5 (Securities)
AddPlayerClassEx(5,25,1685.5280,-2240.3850,13.5469,179.7263,3,1,23,30,-1,-1);//Class 222 - 229
AddPlayerClassEx(5,66,-1974.0000,128.0000,28.0000,4.0000,3,1,23,30,-1,-1);// Class 224
AddPlayerClassEx(5,124,-1974.0000,128.0000,28.0000,4.0000,3,1,23,30,-1,-1);// Class 225
AddPlayerClassEx(5,125,-1974.0000,128.0000,28.0000,4.0000,3,1,23,30,-1,-1);// Class 226
AddPlayerClassEx(5,163,2124.0000,1146.0000,14.0000,241.0000,3,1,23,30,-1,-1);// Class 227
AddPlayerClassEx(5,164,2124.0000,1146.0000,14.0000,241.0000,3,1,23,30,-1,-1);// Class 228
AddPlayerClassEx(5,217,2124.0000,1146.0000,14.0000,241.0000,3,1,23,30,-1,-1);// Class 229
AddPlayerClassEx(6,61,1900.1691,-2629.6445,14.4509,359.9915,46,1,39,5,40,5);//Team 6 (Pilots)
AddPlayerClassEx(6,255,1606.0000,1531.0000,11.0000,46.0000,46,1,39,5,40,5);//Class 230 - 231
AddPlayerClassEx(7,63,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);//Team 7 (Entertainers)
AddPlayerClassEx(7,64,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);//Class 232 - 252
AddPlayerClassEx(7,244,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);// Class 234 LS
AddPlayerClassEx(7,245,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);// Class 235 LS
AddPlayerClassEx(7,256,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);// Class 236 LS
AddPlayerClassEx(7,257,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);// Class 237 LS
AddPlayerClassEx(7,243,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);// Class 238 LS
AddPlayerClassEx(7,90,-1974.0000,128.0000,28.0000,4.0000,12,1,0,0,-1,-1);// Class 239 SF
AddPlayerClassEx(7,92,-1974.0000,128.0000,28.0000,4.0000,12,1,0,0,-1,-1);// Class 240 SF
AddPlayerClassEx(7,131,-1974.0000,128.0000,28.0000,4.0000,12,1,0,0,-1,-1);// Class 241 SF
AddPlayerClassEx(7,152,-1974.0000,128.0000,28.0000,4.0000,12,1,0,0,-1,-1);// Class 242 SF
AddPlayerClassEx(7,178,-1974.0000,128.0000,28.0000,4.0000,12,1,0,0,-1,-1);// Class 243 SF
AddPlayerClassEx(7,87,-1974.0000, 128.0000,28.0000,4.0000,12,1,0,0,-1,-1);// Class 244 SF
AddPlayerClassEx(7,237,2124.0000,1146.0000,14.0000,241.0000,12,1,0,0,-1,-1);// Class 245 LV
AddPlayerClassEx(7,238,2124.0000,1146.0000,14.0000,241.0000,12,1,0,0,-1,-1);// Class 246 LV
AddPlayerClassEx(7,207,2124.0000,1146.0000,14.0000,241.0000,12,1,0,0,-1,-1);// Class 247 LV
AddPlayerClassEx(7,82,2124.0000,1146.0000,14.0000,241.0000,12,1,0,0,-1,-1);// Class 248 LV
AddPlayerClassEx(7,83,2124.0000,1146.0000,14.0000,241.0000,12,1,0,0,-1,-1);// Class 249 LV
AddPlayerClassEx(7,84,2124.0000,1146.0000,14.0000,241.0000,12,1,0,0,-1,-1);// Class 250 LV
AddPlayerClassEx(7,85,2124.0000,1146.0000,14.0000,241.0000,12,1,0,0,-1,-1);// Class 251 LV
AddPlayerClassEx(7,264,2124.0000,1146.0000,14.0000,241.0000,12,1,0,0,-1,-1);// Class 252 LV
AddPlayerClassEx(8,70,1173.0000,-1323.0000,15.0000,266.0000,2,1,0,0,-1,-1);//Team 8 (Medics)
AddPlayerClassEx(8,71,1173.0000,-1323.0000,15.0000,266.0000,2,1,0,0,-1,-1);//Class 253 - 258
AddPlayerClassEx(8,193,-2655.0000,636.0000,14.0000,180.0000,2,1,0,0,-1,-1);// Class 255
AddPlayerClassEx(8,274,-2655.0000,636.0000,14.0000,180.0000,2,1,0,0,-1,-1);// Class 256
AddPlayerClassEx(8,275,1631.0000,1793.0000,11.0000,360.0000,2,1,0,0,-1,-1);// Class 257
AddPlayerClassEx(8,276,1631.0000,1793.0000,11.0000,360.0000,2,1,0,0,-1,-1);// Class 258
AddPlayerClassEx(9,277,1154.0000,-1772.0000,17.500,359.7263,42,100000,0,0,-1,-1);//Team 9 (Firemen)
AddPlayerClassEx(9,279,-2024.0000,67.0000,28.0000,270.000,42,100000,0,0,-1,-1);//Class 259 - 261
AddPlayerClassEx(9,278,1735.0000,2113.0000,12.0000,90.0000,42,100000,0,0,-1,-1);// Class 261
AddPlayerClassEx(10,166,1584.4734,-1710.7793,5.6116,358.8000,24,30,3,1,41,5000);//Team 10 (Cops)
AddPlayerClassEx(10,284,1584.4734,-1710.7793,5.6116,358.8000,24,30,3,1,41,5000);//Class 262 - 274
AddPlayerClassEx(10,246,1584.4734,-1710.7793,5.6116,358.8000,24,30,3,1,41,5000);//Class 264 LS
AddPlayerClassEx(10,280,1584.4734,-1710.7793,5.6116,358.8000,24,30,3,1,41,5000);//Class 265 LS
AddPlayerClassEx(10,281,1584.4734,-1710.7793,5.6116,358.8000,24,30,3,1,41,5000);//Class 266 LS
AddPlayerClassEx(10,295,-1616.0000,681.0000,7.0000,182.0000,24,30,3,1,41,5000);//Class 267 Special Agent SF
AddPlayerClassEx(10,283,-1616.0000,681.0000,7.0000,182.0000,24,30,3,1,41,5000);//Class 268 SF
AddPlayerClassEx(10,286,-1616.0000,681.0000,7.0000,182.0000,24,30,3,1,41,5000);//Class 269 SF
AddPlayerClassEx(10,285,-1616.0000,681.0000,7.0000,182.0000,24,30,3,1,41,5000);//Class 270 SF
AddPlayerClassEx(10,165,2340.0000,2455.0000,15.0000,180.0000,24,30,3,1,41,5000);//Class 271 Special Agent LV
AddPlayerClassEx(10,287,2340.0000,2455.0000,15.0000,180.0000,24,30,3,1,41,5000);//Class 272 LV
AddPlayerClassEx(10,288,2340.0000,2455.0000,15.0000,180.0000,24,30,3,1,41,5000);//Class 273 LV
AddPlayerClassEx(10,282,2340.0000,2455.0000,15.0000,180.0000,24,30,3,1,41,5000);//Class 274 LV

AddStaticPickup(343, 2, -1623.0000,684.00000,-5.0000); // Teargas at SFPD SWAT
AddStaticPickup(361, 2, 1690.0000,-2693.0000,14.0000); // Flamethrower at LSAP behind second hangar from the right
AddStaticPickup(371, 2, 1540.0000,-1354.0000,329.0000); // Parachute at skydive centre
AddStaticPickup(371, 2, 1542.0000,-1354.0000,329.0000); // Parachute at skydive centre
AddStaticPickup(1240, 2, 1544.0000,-1354.0000,329.0000); // Health pickup at skydive centre
AddStaticPickup(371, 2, 1546.0000,-1354.0000,329.0000); // Parachute at skydive centre
AddStaticPickup(371, 2, 1548.0000,-1354.0000,329.0000); // Parachute at skydive centre

AddStaticPickup(361, 3, 194.0000,1876.0000,1790.0000);//Flamethrower above Area 69 (minigame
AddStaticPickup(361, 3, 194.0000,1876.0000,1785.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1780.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1775.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1770.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1765.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1760.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1755.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1750.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1745.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1740.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1735.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1730.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1725.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1720.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1715.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1710.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1705.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1700.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1690.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1685.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1680.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1675.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1670.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1665.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1660.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1655.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1650.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1645.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1640.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1635.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1630.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1625.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1620.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1615.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1610.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1605.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1600.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1590.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1585.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1580.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1575.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1570.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1565.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1560.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1555.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1550.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1545.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1540.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1535.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1530.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1525.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1520.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1515.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1510.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1505.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1500.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1490.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1485.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1480.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1475.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1470.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1465.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1460.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1455.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1450.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1445.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1440.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1435.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1430.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1425.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1420.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1415.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1410.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1405.0000);
AddStaticPickup(361, 3, 194.0000,1876.0000,1400.0000);


// LS Spawns (complete new list including additons  )
// stock cars (cannot be owned by players, not wanted, stealable)
AddStaticVehicleEx(416,1177.8671,-1339.0570,14.0500,272.0161,1,3,300000); //1 stock Ambulance
AddStaticVehicleEx(416,1181.0000,-1309.0000,14.0500,272.0161,1,3,300000); //2 stock Ambulance
AddStaticVehicleEx(596,1536.1121,-1675.1315,13.1033,359.7281,0,1,300000); //3 stock Police
AddStaticVehicleEx(596,1595.4734,-1710.7783,5.6116,358.8000,0,1,300000); //4 stock Police
AddStaticVehicleEx(596,1574.4998,-1710.7798,5.6088,358.9738,0,1,300000); //5 stock Police
AddStaticVehicleEx(596,1545.3486,-1671.9728,5.6115,90.2820,0,1,300000); //6 stock Police
AddStaticVehicleEx(420,1698.9376,-2258.4690,11.9893,89.0390,6,1,300000); //7 stock Taxi Spawn row
AddStaticVehicleEx(438,1690.9376,-2258.4690,11.9893,89.0390,6,1,300000); //8 stock Cabbie Spawn row
AddStaticVehicleEx(420,1674.9376,-2258.4690,11.9893,89.0390,6,1,300000); //9 stock Taxi Spawn row
AddStaticVehicleEx(438,1666.9376,-2258.4690,11.9893,89.0390,6,1,300000); //10 stock Cabbie Spawn row
AddStaticVehicleEx(487,1795.8918,-2422.7253,13.6982,254.0377,29,42,300000); //11 stock Maverick
AddStaticVehicleEx(487,1868.4832,-2356.2820,13.6938,174.3298,12,39,300000); //12 stock Maverick
AddStaticVehicleEx(487,1875.3844,-2453.8931,13.6939,38.3979,54,29,300000); //13 stock Maverick
AddStaticVehicleEx(519,1823.1691,-2629.6445,14.4509,359.9915,1,1,300000); //14 stock Shamal Jet
AddStaticVehicleEx(593,1982.8513,-2625.3264,14.2574,0.7603,119,117,300000); //15 stock Dodo
AddStaticVehicleEx(593,2029.2488,-2625.9211,14.2494,0.0132,89,91,300000); //16 stock Dodo
AddStaticVehicleEx(523,1602.2902,-1700.3253,5.4405,89.5781,0,0,300000); //17 stock HPV1000
AddStaticVehicleEx(523,1545.6112,-1684.5996,5.4420,89.7391,0,0,300000); //18 stock HPV1000

//LS Buyable, Non-Stealable cars (Wanted!)
AddStaticVehicleEx(509,2802.9829,-1254.8864,46.4637,130.9589,6,1,3300000); //19 Bicycle East Beach
AddStaticVehicleEx(509,2271.2920,-1647.2200,14.8925,180.2856,86,1,3300000); //20 Bicycle Ganton
AddStaticVehicleEx(509,1980.9343,-1993.6409,13.0650,358.7168,2,1,3300000); //21 Bicycle Willowfield
AddStaticVehicleEx(509,2151.1958,-1422.2174,25.0516,91.6600,20,1,3300000); //22 Bicycle Jefferson
AddStaticVehicleEx(547,2655.4697,-1131.2047,64.9305,89.4236,24,118,3300000); //23 Primo Los Flores
AddStaticVehicleEx(534,1786.6467,-1932.5216,13.0969,0.5401,42,42,3300000); //24 Remington Unity Station
AddStaticVehicleEx(534,2489.3230,-1953.1077,13.1727,357.6439,53,53,3300000); //25 Remington Willowfield
AddStaticVehicleEx(534,2792.3523,-1448.3152,27.9046,270.1395,24,24,3300000); //26 Remington East Beach Parking
AddStaticVehicleEx(521,1080.8081,-1772.7407,12.9032,269.6079,92,3,3300000); //27 FCR900 Conference Center
AddStaticVehicleEx(521,1017.0835,-1352.9435,12.9296,92.4913,6,6,3300000); //28 FCR900 Market
AddStaticVehicleEx(522,2800.6660,-1427.7903,19.7929,179.8456,3,8,3300000); //29 NRG500 East Peach Parking
AddStaticVehicleEx(567,2147.6819,-1161.6801,23.6752,269.9142,97,96,3300000); //30 Savanna Jefferson
AddStaticVehicleEx(547,1560.3119,-2263.4622,11.9896,89.0390,0,0,3300000); //31 Primo LSAP Parking
AddStaticVehicleEx(405,1560.3119,-2260.4622,11.9896,89.0390,1,1,3300000); //32 Sentinel LSAP Parking
AddStaticVehicleEx(534,1560.3119,-2257.4622,11.9896,89.0390,2,2,3300000); //33 Remington "
AddStaticVehicleEx(576,1560.3119,-2254.4622,11.9896,89.0390,3,3,3300000); //34 Tornado "
AddStaticVehicleEx(421,1560.3119,-2250.4622,11.9896,89.0390,4,4,3300000); //35 Washington "
AddStaticVehicleEx(561,1560.3119,-2247.4622,11.9896,90.0390,5,5,3300000); //36 Stratum "
AddStaticVehicleEx(543,1560.3119,-2241.4622,11.9896,90.0390,6,6,3300000); //37 Sadler "
AddStaticVehicleEx(567,1560.3119,-2237.4622,11.9896,90.0390,7,7,3300000); //38 Savanna "
AddStaticVehicleEx(567,1560.3119,-2234.4622,11.9896,90.0390,8,8,3300000); //39 Savanna "
AddStaticVehicleEx(402,1555.7167,-2213.0000,13.3813,179.4172,9,9,3300000); //40 Bufallo LSAP Parking
AddStaticVehicleEx(535,1552.7167,-2213.0000,13.3813,179.4172,10,10,3300000); //41 Slamvan "
AddStaticVehicleEx(559,1549.7167,-2213.0000,13.3813,179.4172,11,11,3300000); //42 Jester "
AddStaticVehicleEx(562,1546.7167,-2213.0000,13.3813,179.4172,12,12,3300000); //43 Elegy "
AddStaticVehicleEx(477,1542.7167,-2213.0000,13.3813,179.4172,13,13,3300000); //44 ZR350 "
AddStaticVehicleEx(587,1539.3000,-2213.0000,13.3813,179.4172,14,14,3300000); //45 Euros "
AddStaticVehicleEx(558,1535.7167,-2213.0000,13.3813,179.4172,15,15,3300000); //46 Uranus "
AddStaticVehicleEx(560,1532.7167,-2213.0000,13.3813,179.4172,0,0,3300000); //47 Sultan "
AddStaticVehicleEx(536,1530.0000,-2213.0000,13.3813,179.4172,16,16,3300000); //48 Blade "
AddStaticVehicleEx(567,1526.7167,-2213.0000,13.3813,179.4172,17,17,3300000); //49 Savanna "
AddStaticVehicleEx(522,421.9913,-1800.7980,5.1195,271.1656,3,3,3300000); //50 NRG500 Santa Maria Beach
AddStaticVehicleEx(576,2480.3967,-1748.0154,13.1587,359.9270,30,30,3300000); //51 Tornado Ganton
AddStaticVehicleEx(576,2676.2271,-1821.7797,8.9741,129.9665,53,53,3300000); //52 Tornado LS Stadium
AddStaticVehicleEx(522,540.3597,-1270.3364,16.8162,218.7203,51,118,3300000); //53 NRG500 Rodeo
AddStaticVehicleEx(405,1746.5309,-1455.8066,13.4025,273.2154,123,1,3300000); //54 Sentinel Commerce
AddStaticVehicleEx(522,733.9633,-1336.9241,13.1237,268.7378,36,105,3300000); //55 NRG500 Vinewood Studios
AddStaticVehicleEx(405,865.0643,-1468.2266,13.4884,178.4556,36,1,3300000); //56 Sentinel Marina
AddStaticVehicleEx(516,2757.7534,-2542.1335,13.4825,357.5735,0,0,3300000); //57 Nebula Ocean Docks
AddStaticVehicleEx(560,2294.8376,-1689.9841,13.2513,90.1564,1,0,3300000); //58 Sultan Ganton
AddStaticVehicleEx(522,1704.7474,-1068.9409,23.4666,179.2237,7,79,3300000); //59 NRG500 Mulholland Int Parking
AddStaticVehicleEx(560,1252.2246,-1834.7697,13.0957,0.2830,17,1,3300000); //60 Sultan Conference Center
AddStaticVehicleEx(522,2055.2537,-1903.8042,13.1264,180.5756,3,8,3300000); //61 NRG500 Idlewood
AddStaticVehicleEx(560,1001.2195,-1299.9288,13.0692,179.4557,37,0,3300000); //62 Sultan Market
AddStaticVehicleEx(415,1696.3761,-1508.5077,13.1471,180.2962,36,1,3300000); //63 Cheetah Commerce
AddStaticVehicleEx(415,1099.1349,-1757.9042,13.1239,90.1904,62,1,3300000); //64 Cheetah Conference Center
AddStaticVehicleEx(415,2401.3848,-1544.4290,23.7448,359.7998,92,1,3300000); //65 Cheetah East Los Santos
AddStaticVehicleEx(561,1051.6565,-923.1634,42.4986,5.2671,8,17,3300000); //66 Stratum Mulholland
AddStaticVehicleEx(451,737.0599,-1433.4712,13.2585,90.1515,3,3,3300000); //67 Tourismo Marina
AddStaticVehicleEx(451,1148.3650,-1297.7496,13.3752,359.7190,125,125,3300000); //68 Tourismo Market
AddStaticVehicleEx(535,1947.2350,-2126.8870,13.3041,269.9420,3,1,3300000); //69 Slamvan El Corona
AddStaticVehicleEx(451,2217.1843,-1166.1111,25.4190,90.4497,16,16,3300000); //70 Tourismo Jefferson Motel
AddStaticVehicleEx(567,2411.1770,-1391.1155,24.1969,83.3589,12,12,3300000); //71 Savanna East Los Santos
AddStaticVehicleEx(579,718.4528,-1437.0775,13.5129,270.5504,3,3,3300000); //72 Huntley Marina
AddStaticVehicleEx(547,1001.9851,-1105.5309,23.5983,89.6592,30,30,3300000); //73 Primo Temple
AddStaticVehicleEx(429,1617.1093,-2249.0054,-3.0870,271.9824,10,10,3300000); //74 Banshee LSAP Terminal
AddStaticVehicleEx(429,543.8020,-1503.2111,14.0175,359.8613,12,12,3300000); //75 Banshee Rodeo
AddStaticVehicleEx(536,2808.5691,-1428.7512,15.9977,178.2877,110,1,3300000); //76 Blade East Beach Parking Lot
AddStaticVehicleEx(558,1732.7289,-1751.9684,13.1406,0.6521,116,1,3300000); //77 Uranus Little Mexico
AddStaticVehicleEx(587,1358.2623,-1751.8116,13.1230,91.4508,53,1,3300000); //78 Euros Commerce
AddStaticVehicleEx(477,1278.1729,-1542.3838,13.2929,270.7140,103,103,3300000); //79 ZR350 Market
AddStaticVehicleEx(411,1645.1721,-1045.9775,23.4882,179.2404,112,1,3300000); //80 Infernus Mulholland Int Parking
AddStaticVehicleEx(562,1616.2500,-1128.2058,23.5967,269.4570,35,1,3300000); //81 Elegy Mulholland Int Parking
AddStaticVehicleEx(402,2767.8623,-1876.3982,9.6116,0.9914,30,30,3300000); //82 Bufallo LS Stadium
AddStaticVehicleEx(402,2102.3748,-1275.4111,25.3430,179.9360,110,110,3300000); //83 Bufallo Jefferson
AddStaticVehicleEx(541,481.8200,-1488.6698,19.6303,188.5278,58,58,3300000); //84 Bullet Rodeo
AddStaticVehicleEx(541,1011.8397,-1083.3861,23.4538,181.7085,51,51,3300000); //85 Bullet Temple
AddStaticVehicleEx(541,1011.8390,-1083.3862,23.4537,181.7100,51,51,3300000); //86 Bullet Temple
AddStaticVehicleEx(541,1651.6531,-1283.7155,14.4219,259.6173,91,91,3300000); //87 Bullet Downtown
AddStaticVehicleEx(535,2230.5579,-1351.4149,23.7544,90.1239,28,1,3300000); //88 Slamvan Jefferson
AddStaticVehicleEx(535,2691.8064,-1671.3386,9.2180,179.4417,55,1,3300000); //89 Slamvan LS Stadium

//LV Spawns
AddStaticVehicleEx(417,2094.0000,2416.0000,75.0000,270.0000,0,0,3300000); //90 Leviathan
AddStaticVehicleEx(477,2096.0000,2419.3000,50.0000,90.0000,92,1,3300000); //91 ZR-350
AddStaticVehicleEx(451,2069.0000,2414.0000,50.0000,270.0000,6,25,3300000); //92 Tourismo
AddStaticVehicleEx(507,1464.0000,2773.0000,11.0000,180.0000,0,0,3300000); //93 Elegant
AddStaticVehicleEx(587,1275.0000,2529.0000,10.5000,270.0000,6,25,3300000); //94 Euros House
AddStaticVehicleEx(576,2797.0000,2423.0000,11.0000,133.0000,92,1,3300000); //95 Tornado
AddStaticVehicleEx(536,2785.0000,2436.0000,11.0000,133.0000,116,1,3300000); //96 Blade
AddStaticVehicleEx(558,2522.0000,2112.0000,11.0000,180.0000,40,1,3300000); //97 Uranus
AddStaticVehicleEx(507,2159.0000,1678.0000,11.0000,360.0000,1,1,3300000); //98 Elegant
AddStaticVehicleEx(426,2034.4000,1917.000,12.0000,180.0000,0,0,3300000); //99 Premier
AddStaticVehicleEx(579,2123.0000,1409.0000,11.0000,0.0000,0,0,3300000); //100 Huntley
AddStaticVehicleEx(535,2110.0000,1398.0000,11.0000,180.0000,12,1,3300000); //101 Slamvan
AddStaticVehicleEx(507,2039.0000,1007.0000,11.0000,180.0000,0,0,3300000); //102 Elegant
AddStaticVehicleEx(402,2075.0000,1168.0000,11.0000,360.0000,77,77,3300000); //103 Buffalo
AddStaticVehicleEx(534,2075.0000,1157.0000,11.0000,360.0000,0,0,3300000); //104 Remington
AddStaticVehicleEx(477,2075.0000,1113.0000,11.0000,360.0000,13,13,3300000); //105 ZR-350
AddStaticVehicleEx(451,2075.0000,1124.0000,11.0000,360.0000,14,14,3300000); //106 Tourismo
AddStaticVehicleEx(558,2075.0000,1135.0000,11.0000,360.0000,44,44,3300000); //107 Uranus
AddStaticVehicleEx(587,2075.0000,1146.0000,11.0000,360.0000,123,1,3300000); //108 Euros
AddStaticVehicleEx(559,-1990.0000,269.0000,35.0000,88.0000,113,92,3300000); //109 Jester Wang Cars
AddStaticVehicleEx(560,-1988.0000,304.0000,35.0000,90.0000,119,113,3300000); //110 Sultan Wang Cars

//SF Spawns
AddStaticVehicleEx(576,-1662.0000,1210.0000,21.0000,319.0000,36,36,3300000); //111 Tornado
AddStaticVehicleEx(562,-1659.0000,1213.0000,14.0000,270.0000,102,102,3300000); //112 Elegy
AddStaticVehicleEx(559,-1651.0000,1312.0000,7.0000,132.0000,36,1,3300000); //113 Jester
AddStaticVehicleEx(431,-1757.0000,954.0000,25.0000,90.0000,86,39,3300000); //114 Bus
AddStaticVehicleEx(567,-1703.0000,1033.0000,18.0000,272.0000,6,25,3300000); //115 Savanna
AddStaticVehicleEx(507,-2105.00000,893.5000,76.5000,4.0000,9,39,3300000); //116 Elegant House
AddStaticVehicleEx(477,-2214.0000,725.0000,49.0000,270.0000,40,1,3300000); //117 ZR-350 House
AddStaticVehicleEx(426,-2416.5000,332.0000,35.0000,150.0000,0,0,3300000); //118 Premier House
AddStaticVehicleEx(402,-2745.0000,-305.000,7.0000,48.0000,83,83,3300000); //119 Buffalo House
AddStaticVehicleEx(507,-2734.3000,-281.0000,7.0000,180.0000,3,1,3300000); //120 Elegant House
AddStaticVehicleEx(559,-2084.0000,-83.0000,35.0000,180.0000,8,8,3300000); //121 Jester
AddStaticVehicleEx(576,-2076.0000,-83.0000,35.0000,180.0000,114,1,3300000); //122 Tornado
AddStaticVehicleEx(517,-2068.0000,-83.0000,35.0000,180.0000,3,3,3300000); //123 Majestic
AddStaticVehicleEx(477,-1953.0000,267.0000,41.0000,234.0000,0,0,3300000); //124 ZR-350 Wang Cars
AddStaticVehicleEx(507,-1957.0000,305.0000,35.0000,160.0000,74,74,3300000); //125 Elegant Wang Cars
AddStaticVehicleEx(426,-1957.0000,270.0000,35.0000,88.0000,87,118,3300000); //126 Premier Wang Cars
AddStaticVehicleEx(517,-1957.0000,280.0000,35.0000,88.0000,92,3,3300000); //127 Majestic Wang Cars


//stock cars
AddStaticVehicleEx(420,2159.0000,1113.0000,13.0000,150.0000,6,1,300000); //128 stock Taxi Spawn row LV
AddStaticVehicleEx(438,2172.0000,1140.0000,13.0000,150.0000,6,1,300000); //129 stock Cabbie Spawn row LV
AddStaticVehicleEx(420,-1988.0000,148.0000,28.0000,360.0000,6,1,300000); //130 stock Taxi Spawn row SF
AddStaticVehicleEx(438,-1988.0000,132.0000,28.0000,360.0000,6,1,300000); //131 stock Cabbie Spawn row SF
AddStaticVehicleEx(407,1182.0000,-1792.0000,13.0000,2.0000,3,1,300000);//132 stock Firetruck
AddStaticVehicleEx(407,1173.0000,-1792.0000,13.0000,2.0000,3,1,300000);//133 stock Firetruck
AddStaticVehicleEx(593,2000.2488,-2625.9211,14.2494,0.0132,89,91,300000);//134 stock Dodo
AddStaticVehicleEx(593,1870.3844,-2400.8931,13.6939,38.3979,54,29,300000); //135 stock Dodo
AddStaticVehicleEx(563,1088.0000,-1793.0000,14.0000,306.0000,3,1,300000);//136 stock LSFD Raindance
AddStaticVehicleEx(497,1553.0000,-1610.0000,13.0000,270.0000,0,1,300000); //137 stock Police Helicopter LSPD
AddStaticVehicleEx(487,1177.5000,-1350.0000,19.0000,0.0000,1,3,300000); //138 stock Maverick LSLR
AddStaticVehicleEx(592,2118.0000,-2450.0000,14.0000,180.0000,0,0,300000); //139 stock Andromeda
AddStaticVehicleEx(487,1615.0000,1530.0000,11.0000,16.0000,1,0,300000); //140 stock Maverick LVAP
AddStaticVehicleEx(431,1604.0000,1559.0000,11.0000,8.0000,1,0,300000); //141 stock Bus LVAP
AddStaticVehicleEx(487,-1364.0000,-240.0000,14.0000,333.0000,1,86,300000); //142 stock Maverick SFAP
AddStaticVehicleEx(431,-1372.0000,-199.0000,14.0000,310.0000,1,86,300000); //143 stock Bus SFAP
AddStaticVehicleEx(597,-1612.0000,675.0000,7.0000,184.0000,0,1,300000); //144 stock Police SFPD
AddStaticVehicleEx(597,-1609.0000,749.0000,-5.0000,185.0000,0,1,300000); //145 stock Police SFPD
AddStaticVehicleEx(523,-1592.0000,749.0000,-5.0000,178.0000,0,1,300000); //146 stock HPV-1000 SFPD
AddStaticVehicleEx(523,-1613.0000,733.0000,-5.0000,359.0000,0,1,300000); //147 stock HPV-1000 SFPD
AddStaticVehicleEx(497,-1680.0000,706.0000,31.0000,93.0000,0,1,300000); //148 stock Police Helicopter SFPD
AddStaticVehicleEx(407,-2022.0000,76.0000,28.0000,270.0000,3,1,300000);//149 stock Firetruck SFFD
AddStaticVehicleEx(407,-2022.0000,93.0000,28.0000,270.0000,3,1,300000);//150 stock Firetruck SFFD
AddStaticVehicleEx(563,-2062.0000,76.0000,28.0000,180.0000,3,1,300000);//151 stock LSFD Raindance
AddStaticVehicleEx(416,-2670.0000,608.0000,14.0000,180.0000,1,3,300000); //152 stock Ambulance SFLR
AddStaticVehicleEx(416,-2663.0000,608.0000,14.0000,180.0000,1,3,300000); //153 stock Ambulance SFLR
AddStaticVehicleEx(487,-2599.0000,605.0000,16.0000,180.0000,1,3,300000); //154 stock Maverick SFLR
AddStaticVehicleEx(519,-1340.0000,-255.0000,14.0000,311.0000,1,86,300000); //155 stock Shamal Jet SFAP
AddStaticVehicleEx(598,2306.0000,2446.0000,11.0000,180.0000,0,1,300000); //156 stock Police LVPD
AddStaticVehicleEx(598,2297.0000,2452.0000,3.0000,270.0000,0,1,300000); //157 stock Police LVPD
AddStaticVehicleEx(523,2315.0000,2460.0000,3.0000,90.0000,0,1,300000); //158 stock HPV-1000 LVPD
AddStaticVehicleEx(523,2303.0000,2430.0000,3.0000,360.0000,0,1,300000); //159 stock HPV-1000 LVPD
AddStaticVehicleEx(497,2315.0000,2453.0000,11.0000,90.0000,0,1,300000); //160 stock Police Helicopter LVPD
AddStaticVehicleEx(407,1751.0000,2077.0000,11.0000,180.0000,3,1,300000);//161 stock Firetruck LVFD
AddStaticVehicleEx(407,1763.0000,2077.0000,11.0000,180.0000,3,1,300000);//162 stock Firetruck LVFD
AddStaticVehicleEx(563,1737.0000,2097.0000,16.0000,270.0000,3,1,300000);//163 stock LVFD Raindance
AddStaticVehicleEx(416,1600.0000,1822.0000,9.0000,360.0000,1,3,300000); //164 stock Ambulance LVLR
AddStaticVehicleEx(416,1615.0000,1822.0000,9.0000,360.0000,1,3,300000); //165 stock Ambulance LVLR
AddStaticVehicleEx(487,1630.0000,1849.0000,11.0000,180.0000,1,3,300000); //166 stock Maverick LVLR
AddStaticVehicleEx(519,1572.0000,1537.0000,11.0000,95.0000,1,0,300000); //167 stock Shamal Jet LVAP
AddStaticVehicleEx(431,-384.0000,-1404.0000,25.0000,286.0000,1,0,300000); //168 stock Bus LS Farm
AddStaticVehicleEx(431,-29.0000,155.0000,3.0000,339.0000,1,0,300000); //169 stock Bus SF Farm
AddStaticVehicleEx(431,-637.0000,2691.0000,72.0000,271.0000,1,0,300000); //170 stock Bus LV Farm


AddStaticVehicleEx(470,1561.0000,-1358.0000,329.0000,80.0000,86,86,300000);//171 Derby car Patriot
AddStaticVehicleEx(470,1558.0000,-1349.0000,329.0000,111.0000,86,86,300000);//172 Derby car Patriot
AddStaticVehicleEx(470,1550.0000,-1342.0000,329.0000,153.0000,86,86,300000);//173 Derby car Patriot
AddStaticVehicleEx(470,1539.0000,-1342.0000,329.0000,202.0000,86,86,300000);//174 Derby car Patriot
AddStaticVehicleEx(470,1531.0000,-1348.0000,329.0000,232.0000,86,86,300000);//175 Derby car Patriot

//House cars - ONLY FOR DONATORS
AddStaticVehicleEx(411,-2755.0000,376.0000,4.0000,180.0000,0,0,3300000);//176 HOUSECAR M1k3
AddStaticVehicleEx(522,-1953.0000,296.0000,41.0000,134.0000,19,19,300000);//177 NRG500 Wang Cars
AddStaticVehicleEx(601,-1639.0000,687.0000,-5.0000,264.0000,0,1,300000);//178 SWAT Van SFPD SWAT
AddStaticVehicleEx(601,-1639.0000,678.0000,-5.0000,265.0000,0,1,300000);//179 SWAT Van SFPD SWAT
AddStaticVehicleEx(537,1701.0000,-1954.0000,14.0000,90.0000,0,1,300000);//180 Train Unity Station

AdID = 1;
CurrentJudge = -1;
CurrentLawyer = -1;
CurrentCase = -1;
LSPilot = -1;
SFPilot = -1;
LVPilot = -1;
LSTaxidrvr = -1;
SFTaxidrvr = -1;
LVTaxidrvr = -1;
LSTaxicust = -1;
SFTaxicust = -1;
LVTaxicust = -1;
Minigames[BurnPrepare] = 0;
Minigames[BurnRunning] = 0;
Minigames[DerbyPrepare] = 0;
Minigames[DerbyRunning] = 0;

// PART OF TRATULLA'S IRC ECHO SCRIPT
	if ( fexist( FILE_INPUT ) ) { fremove( FILE_INPUT ); }
	if ( fexist( FILE_OUTPUT ) ) { fremove( FILE_OUTPUT ); }
	WriteEcho("[server] Embedded IRC Echo Script by Tratulla loaded");
// **********************************

	return 1;
}

//Callback edited
public OnPlayerConnect(playerid)
{
new tmp[255],player[24];
GetPlayerName(playerid,player,sizeof(player));

format(tmp,sizeof(tmp),"%s (%d) has joined the server.",player,playerid);SendClientMessageToAll(COLOR_GREY,tmp);

if(dini_Exists(udb_encode(player))){
tmp = dini_Get(udb_encode(player),"Banned");
	if (strval(tmp) == 1){
	SendClientMessage(playerid,COLOR_RED,"(Kick) Your account is blocked, you are banned from this server");
	GameTextForPlayer(playerid,"~r~You are banned from this server!!!",30000,5);
	pInfo[playerid][Banned] = 1;
	return 1;
	}
}
	else
	SetPlayerColor(playerid, COLOR_DARKGREEN);
	GameTextForPlayer(playerid,"~w~Welcome to~g~ Pure RPG by M1k3",3000,1);
	SendClientMessage(playerid,COLOR_RED,"Failure to /login before spawn results in auto-kick!");
	SendClientMessage(playerid,COLOR_RED,"====================================================");
	SendClientMessage(playerid,COLOR_ORANGE,"Type /help for more information. Type /laws to read the server rules.");
	SendClientMessage(playerid,COLOR_ORANGE,"Type /commands to see the server commands.");
	SendClientMessage(playerid,COLOR_RED,"More info on -------> www.pure-rpg.de.tc <-------");

	pInfo[playerid][Spawned] = 0;
	pInfo[playerid][JoinTeam] = 0;
	pInfo[playerid][CopBlock] = 0;
	pInfo[playerid][Logged] = 0;
	pInfo[playerid][GetSkin] = 0;
	pInfo[playerid][Admin] = 0;
	pInfo[playerid][Cuffed] = 0;
	pInfo[playerid][Wanted] = 0;
	pInfo[playerid][invehicle] = 0;
	pInfo[playerid][buytimer] = 0;
	pInfo[playerid][AddWanted] = 0;
	pInfo[playerid][WantedLevel] = 0;
	pInfo[playerid][Jailable] = 0;
	pInfo[playerid][PlayBurn] = 0;
	pInfo[playerid][BurnRespawn] = 0;
	pInfo[playerid][PlayDerby] = 0;
	pInfo[playerid][isPreparing] = 0;
	pInfo[playerid][isPassenger] = 0;
	pInfo[playerid][paradrop] = 0;
	pInfo[playerid][Boarded] = 0;
	pInfo[playerid][Jailed] = 0; //<<< Return this Value to 0 after debug!
	pInfo[playerid][c] = 0;
	pInfo[playerid][driver] = 0;
	pInfo[playerid][fuel] = 100;
	pInfo[playerid][WantDrugs] = 0;
	pInfo[playerid][UsedDrugs] = 0;
	pInfo[playerid][Ad] = 0;
	pInfo[playerid][Rob] = 0;
	pInfo[playerid][GTA] = 0;
	pInfo[playerid][OOC] = 1;
	TogglePlayerClock(playerid,1);

    //PART OF XADMIN
    	new name[MAX_PLAYER_NAME], string[256]; GetPlayerName(playerid,name,sizeof(name));
	format(string,sizeof(string),"Server Message: %s",dini_Get("/xadmin/config/utilities.ini","SM")); SendClientMessage(playerid,green,string);
	new file[256]; format(file,sizeof(file),"xadmin/%s.ini",udb_encode(name));
	if (!dini_Exists(file)) { Injector(playerid); }
 	if (dini_Int(file,"injector") != 1) { Injector(playerid); }
		Registered[playerid]=0; PinLogged[playerid]=0; Away[playerid]=0; xWanted[playerid]=0; Stfu[playerid]=0; xJailed[playerid]=0; LoggedIn[playerid]=0; StfuW[playerid]=3; JailT[playerid]=0; LogTry[playerid]=3;
		dini_IntSet(file,"logintry",3);
		dini_IntSet(file,"loggedin",0);
		dini_IntSet(file,"away",0);
		dini_IntSet(file,"wanted",0);
		dini_IntSet(file,"jail",0);
		dini_IntSet(file,"pinlogged",0);
		dini_IntSet(file,"stfu",0);
		dini_IntSet(file,"stfuwarnings",2);
		dini_Set(file,"awaymessage","None");
		dini_Set(file,"wantedmessage","None");
		Pin[playerid] = dini_Int(file,"pincode");
		Kills[playerid] = dini_Int(file,"kills");
		Deaths[playerid] = dini_Int(file,"deaths");
		xBank[playerid] = dini_Int(file,"bank");
		Cash[playerid] = dini_Int(file,"cash");
		Level[playerid] = dini_Int(file,"level");
		Inj[playerid] = dini_Int(file,"injector");
		Passworded[playerid] = dini_Int(file,"passworded");
		Registered[playerid] = dini_Int(file,"registered");
	if(Registered[playerid] == 1) format(string,sizeof(string),"Welcome, %s. To log back into your Account, please type '/LOGIN <PASSWORD>'.",name);
	if(Registered[playerid] == 0) format(string,sizeof(string),"Welcome, %s. It seems you have not registered to your Account. To create one, type '/REGISTER <PASSWORD>'.",name);
	SendClientMessage(playerid,cyan,string);
    //*******************************************
    
//PART OF TRATULLA'S IRC ECHO SCRIPT
	if ( isTimer == 0 )
	{
	    TimerID = SetTimer( "CheckInput", 1000, 1 );
	    isTimer = 1;
	} else
	{
	    KillTimer(TimerID);
	    TimerID = SetTimer( "CheckInput", 1000, 1 );
	}

	new tstring[256];
	format( tstring, sizeof( tstring ), "[join] %d %s", playerid, PlayerName( playerid ) );
	WriteEcho( tstring );
//**********************************


return 1;
}

//Callback edited
public OnPlayerDisconnect(playerid)
{
	new player[24],tmp[255];
	GetPlayerName(playerid,player,24);
	if(pInfo[playerid][c] < 3) hack++;
	if(pInfo[playerid][Logged]) {
		dini_IntSet(udb_encode(player),"Pocket",GetPlayerMoney(playerid));
	}
	pInfo[playerid][Spawned] = 0;
	pInfo[playerid][Logged] = 0;
	pInfo[playerid][JoinTeam] = 0;
	pInfo[playerid][CopBlock] = 0;
	pInfo[playerid][Banned] = 0;
	pInfo[playerid][GetSkin] = 0;
	pInfo[playerid][Admin] = 0;
	pInfo[playerid][Cuffed] = 0;
	pInfo[playerid][Wanted] = 0;
	pInfo[playerid][AddWanted] = 0;
	pInfo[playerid][WantedLevel] = 0;
	pInfo[playerid][PlayBurn] = 0;
	pInfo[playerid][BurnRespawn] = 0;
	pInfo[playerid][PlayDerby] = 0;
	pInfo[playerid][isPreparing] = 0;
	pInfo[playerid][Jailable] = 0;
	pInfo[playerid][Jailed] = 0;
	pInfo[playerid][isPassenger] = 0;
	pInfo[playerid][paradrop] = 0;
	pInfo[playerid][Boarded] = 0;
	pInfo[playerid][driver] = 0;
	pInfo[playerid][invehicle] = 0;
	pInfo[playerid][buytimer] = 0;
	pInfo[playerid][fuel] = 100;
	pInfo[playerid][WantDrugs] = 0;
	pInfo[playerid][UsedDrugs] = 0;
	pInfo[playerid][Ad] = 0;
	pInfo[playerid][Rob] = 0;
	pInfo[playerid][GTA] = 0;
	pInfo[playerid][OOC] = 1;

format(tmp,sizeof(tmp),"%s (%d) has quit the server.",player,playerid);SendClientMessageToAll(COLOR_GREY,tmp);

if (playerid == LSTaxidrvr){
LSTaxidrvr = -1;
SendClientMessageToAll(BBLUE, "The taxi driver position in LS just became vacant. Type /taxidriver to be the next one");
}

if (playerid == SFTaxidrvr){
SFTaxidrvr = -1;
SendClientMessageToAll(BBLUE, "The taxi driver position in SF just became vacant. Type /taxidriver to be the next one");
}

if (playerid == LVTaxidrvr){
LVTaxidrvr = -1;
SendClientMessageToAll(BBLUE, "The taxi driver position in LV just became vacant. Type /taxidriver to be the next one");
}

if (playerid == LSPilot){
LSPilot = -1;
SendClientMessageToAll(BBLUE, "The charter pilot position in LS just became vacant. Type /charter to be the next one");
}

if (playerid == SFPilot){
SFPilot = -1;
SendClientMessageToAll(BBLUE, "The charter pilot position in SF just became vacant. Type /charter to be the next one");
}

if (playerid == LVPilot){
LVPilot = -1;
SendClientMessageToAll(BBLUE, "The charter pilot position in LV just became vacant. Type /charter to be the next one");
}

// PART OF TRATULLA'S IRC ECHO SCRIPT
    new string[256];
	format( string, sizeof( string ), "[part] %d %s", playerid, PlayerName( playerid ) );
	WriteEcho( string );
//************************************
	return 1;
}

//Callback
public OnPlayerRequestClass(playerid, classid)
{

	SetupPlayerForClassSelection(playerid);
	
gTeam[playerid] = GetPlayerTeam(playerid);
pInfo[playerid][JoinTeam] = 0;

new player[24];
GetPlayerName (playerid,player,sizeof(player));

switch (classid){
case 0: {pInfo[playerid][Skin] = 7;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 1: {pInfo[playerid][Skin] = 12;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 2: {pInfo[playerid][Skin] = 16;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 3: {pInfo[playerid][Skin] = 17;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 4: {pInfo[playerid][Skin] = 18;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 5: {pInfo[playerid][Skin] = 19;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 6: {pInfo[playerid][Skin] = 20;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 7: {pInfo[playerid][Skin] = 21;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 8: {pInfo[playerid][Skin] = 23;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 9: {pInfo[playerid][Skin] = 26;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 10: {pInfo[playerid][Skin] = 27;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 11: {pInfo[playerid][Skin] = 34;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 12: {pInfo[playerid][Skin] = 35;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 13: {pInfo[playerid][Skin] = 36;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 14: {pInfo[playerid][Skin] = 37;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 15: {pInfo[playerid][Skin] = 40;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 16: {pInfo[playerid][Skin] = 45;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 17: {pInfo[playerid][Skin] = 50;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 18: {pInfo[playerid][Skin] = 51;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 19: {pInfo[playerid][Skin] = 52;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 20: {pInfo[playerid][Skin] = 55;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 21: {pInfo[playerid][Skin] = 56;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 22: {pInfo[playerid][Skin] = 59;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 23: {pInfo[playerid][Skin] = 60;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 24: {pInfo[playerid][Skin] = 67;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 25: {pInfo[playerid][Skin] = 69;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 26: {pInfo[playerid][Skin] = 72;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 27: {pInfo[playerid][Skin] = 73;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 28: {pInfo[playerid][Skin] = 80;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 29: {pInfo[playerid][Skin] = 81;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 30: {pInfo[playerid][Skin] = 91;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 31: {pInfo[playerid][Skin] = 96;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 32: {pInfo[playerid][Skin] = 97;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 33: {pInfo[playerid][Skin] = 99;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 34: {pInfo[playerid][Skin] = 101;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 35: {pInfo[playerid][Skin] = 138;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 36: {pInfo[playerid][Skin] = 139;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 37: {pInfo[playerid][Skin] = 140;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 38: {pInfo[playerid][Skin] = 141;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 39: {pInfo[playerid][Skin] = 142;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 40: {pInfo[playerid][Skin] = 147;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 41: {pInfo[playerid][Skin] = 148;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 42: {pInfo[playerid][Skin] = 151;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 43: {pInfo[playerid][Skin] = 153;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 44: {pInfo[playerid][Skin] = 154;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 45: {pInfo[playerid][Skin] = 157;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 46: {pInfo[playerid][Skin] = 169;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 47: {pInfo[playerid][Skin] = 170;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 48: {pInfo[playerid][Skin] = 176;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 49: {pInfo[playerid][Skin] = 177;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 50: {pInfo[playerid][Skin] = 180;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 51: {pInfo[playerid][Skin] = 185;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 52: {pInfo[playerid][Skin] = 186;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 53: {pInfo[playerid][Skin] = 187;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 54: {pInfo[playerid][Skin] = 188;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 55: {pInfo[playerid][Skin] = 190;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 56: {pInfo[playerid][Skin] = 191;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 57: {pInfo[playerid][Skin] = 192;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 58: {pInfo[playerid][Skin] = 198;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 59: {pInfo[playerid][Skin] = 199;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 60: {pInfo[playerid][Skin] = 201;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 61: {pInfo[playerid][Skin] = 202;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 62: {pInfo[playerid][Skin] = 203;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 63: {pInfo[playerid][Skin] = 204;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 64: {pInfo[playerid][Skin] = 206;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 65: {pInfo[playerid][Skin] = 211;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 66: {pInfo[playerid][Skin] = 214;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 67: {pInfo[playerid][Skin] = 215;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 68: {pInfo[playerid][Skin] = 216;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 69: {pInfo[playerid][Skin] = 219;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 70: {pInfo[playerid][Skin] = 221;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 71: {pInfo[playerid][Skin] = 222;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 72: {pInfo[playerid][Skin] = 223;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 73: {pInfo[playerid][Skin] = 226;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 74: {pInfo[playerid][Skin] = 227;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 75: {pInfo[playerid][Skin] = 233;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 76: {pInfo[playerid][Skin] = 240;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 77: {pInfo[playerid][Skin] = 241;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 78: {pInfo[playerid][Skin] = 242;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 79: {pInfo[playerid][Skin] = 250;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 80: {pInfo[playerid][Skin] = 251;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 81: {pInfo[playerid][Skin] = 252;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 82: {pInfo[playerid][Skin] = 258;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 83: {pInfo[playerid][Skin] = 259;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 84: {pInfo[playerid][Skin] = 260;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 85: {pInfo[playerid][Skin] = 261;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 86: {pInfo[playerid][Skin] = 262;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 87: {pInfo[playerid][Skin] = 263;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 88: {pInfo[playerid][Skin] = 290;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 89: {pInfo[playerid][Skin] = 291;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 90: {pInfo[playerid][Skin] = 296;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 91: {pInfo[playerid][Skin] = 297;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 92: {pInfo[playerid][Skin] = 9;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
        }
case 93: {pInfo[playerid][Skin] = 10;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
        }
case 94: {pInfo[playerid][Skin] = 14;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 95: {pInfo[playerid][Skin] = 15;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 96: {pInfo[playerid][Skin] = 31;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
	    }
case 97: {pInfo[playerid][Skin] = 32;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
	    }
case 98: {pInfo[playerid][Skin] = 33;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 99: {pInfo[playerid][Skin] = 38;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 100: {pInfo[playerid][Skin] = 39;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 101: {pInfo[playerid][Skin] = 43;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 102: {pInfo[playerid][Skin] = 44;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 103: {pInfo[playerid][Skin] = 49;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 104: {pInfo[playerid][Skin] = 53;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 105: {pInfo[playerid][Skin] = 54;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 106: {pInfo[playerid][Skin] = 57;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 107: {pInfo[playerid][Skin] = 58;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 108: {pInfo[playerid][Skin] = 62;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 109: {pInfo[playerid][Skin] = 68;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 110: {pInfo[playerid][Skin] = 75;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 111: {pInfo[playerid][Skin] = 76;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 112: {pInfo[playerid][Skin] = 77;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 113: {pInfo[playerid][Skin] = 78;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LS) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 1;
		}
case 114: {pInfo[playerid][Skin] = 79;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 115: {pInfo[playerid][Skin] = 88;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 116: {pInfo[playerid][Skin] = 89;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
        }
case 117: {pInfo[playerid][Skin] = 93;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 118: {pInfo[playerid][Skin] = 94;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 119: {pInfo[playerid][Skin] = 95;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 120: {pInfo[playerid][Skin] = 128;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 121: {pInfo[playerid][Skin] = 129;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 122: {pInfo[playerid][Skin] = 130;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 123: {pInfo[playerid][Skin] = 132;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 124: {pInfo[playerid][Skin] = 133;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 125: {pInfo[playerid][Skin] = 134;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 126: {pInfo[playerid][Skin] = 135;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 127: {pInfo[playerid][Skin] = 136;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
	    }
case 128: {pInfo[playerid][Skin] = 137;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 129: {pInfo[playerid][Skin] = 150;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 130: {pInfo[playerid][Skin] = 156;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 131: {pInfo[playerid][Skin] = 158;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 132: {pInfo[playerid][Skin] = 159;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
	    }
case 133: {pInfo[playerid][Skin] = 160;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 134: {pInfo[playerid][Skin] = 161;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 135: {pInfo[playerid][Skin] = 162;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (SF) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 2;
		}
case 136: {pInfo[playerid][Skin] = 182;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 137: {pInfo[playerid][Skin] = 183;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 138: {pInfo[playerid][Skin] = 196;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 139: {pInfo[playerid][Skin] = 197;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 140: {pInfo[playerid][Skin] = 200;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 141: {pInfo[playerid][Skin] = 210;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 142: {pInfo[playerid][Skin] = 212;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 143: {pInfo[playerid][Skin] = 213;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 144: {pInfo[playerid][Skin] = 218;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 145: {pInfo[playerid][Skin] = 220;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 146: {pInfo[playerid][Skin] = 224;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 147: {pInfo[playerid][Skin] = 225;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 148: {pInfo[playerid][Skin] = 228;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 149: {pInfo[playerid][Skin] = 229;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 150: {pInfo[playerid][Skin] = 230;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 151: {pInfo[playerid][Skin] = 231;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 152: {pInfo[playerid][Skin] = 232;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 153: {pInfo[playerid][Skin] = 234;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
	    }
case 154: {pInfo[playerid][Skin] = 235;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 155: {pInfo[playerid][Skin] = 236;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 156: {pInfo[playerid][Skin] = 239;
        GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior (LV) ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
		pInfo[playerid][City] = 3;
		}
case 157: {pInfo[playerid][Skin] = 11;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Waiter (LS) ~n~~r~OBJECTIVE: ~w~ Serve drinks and food",1000,5);
		pInfo[playerid][City] = 1;
		}
case 158: {pInfo[playerid][Skin] = 155;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Waiter (LS) ~n~~r~OBJECTIVE: ~w~ Serve drinks and food",1000,5);
		pInfo[playerid][City] = 1;
		}
case 159: {pInfo[playerid][Skin] = 167;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Waiter (LS) ~n~~r~OBJECTIVE: ~w~ Serve drinks and food",1000,5);
		pInfo[playerid][City] = 1;
		}
case 160: {pInfo[playerid][Skin] = 168;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Waiter (LS) ~n~~r~OBJECTIVE: ~w~ Serve drinks and food",1000,5);
		pInfo[playerid][City] = 1;
		}
case 161: {pInfo[playerid][Skin] = 171;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Waiter (LS) ~n~~r~OBJECTIVE: ~w~ Serve drinks and food",1000,5);
		pInfo[playerid][City] = 1;
		}
case 162: {pInfo[playerid][Skin] = 172;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Waiter (LS) ~n~~r~OBJECTIVE: ~w~ Serve drinks and food",1000,5);
		pInfo[playerid][City] = 1;
		}
case 163: {pInfo[playerid][Skin] = 179;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Waiter (LS) ~n~~r~OBJECTIVE: ~w~ Serve drinks and food",1000,5);
		pInfo[playerid][City] = 1;
		}
case 164: {pInfo[playerid][Skin] = 189;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Waiter (LS) ~n~~r~OBJECTIVE: ~w~ Serve drinks and food",1000,5);
		pInfo[playerid][City] = 1;
		}
case 165: {pInfo[playerid][Skin] = 194;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Waiter (LS) ~n~~r~OBJECTIVE: ~w~ Serve drinks and food",1000,5);
		pInfo[playerid][City] = 1;
		}
case 166: {pInfo[playerid][Skin] = 205;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Waiter (LS) ~n~~r~OBJECTIVE: ~w~ Serve drinks and food",1000,5);
		pInfo[playerid][City] = 1;
		}
case 167: {pInfo[playerid][Skin] = 209;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Waiter (LS) ~n~~r~OBJECTIVE: ~w~ Serve drinks and food",1000,5);
		pInfo[playerid][City] = 1;
		}
case 168: {pInfo[playerid][Skin] = 253;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Waiter (LS) ~n~~r~OBJECTIVE: ~w~ Serve drinks and food",1000,5);
		pInfo[playerid][City] = 1;
		}
case 169: {pInfo[playerid][Skin] = 13;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 170: {pInfo[playerid][Skin] = 22;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 171: {pInfo[playerid][Skin] = 28;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 172: {pInfo[playerid][Skin] = 195;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 173: {pInfo[playerid][Skin] = 30;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 174: {pInfo[playerid][Skin] = 292;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 175: {pInfo[playerid][Skin] = 293;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 176: {pInfo[playerid][Skin] = 173;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 177: {pInfo[playerid][Skin] = 174;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 178: {pInfo[playerid][Skin] = 175;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 179: {pInfo[playerid][Skin] = 100;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 180: {pInfo[playerid][Skin] = 102;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 181: {pInfo[playerid][Skin] = 103;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 182: {pInfo[playerid][Skin] = 104;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 183: {pInfo[playerid][Skin] = 105;
		pInfo[playerid][City] = 1;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		}
case 184: {pInfo[playerid][Skin] = 106;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 185: {pInfo[playerid][Skin] = 107;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 186: {pInfo[playerid][Skin] = 108;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 187: {pInfo[playerid][Skin] = 109;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 188: {pInfo[playerid][Skin] = 110;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 189: {pInfo[playerid][Skin] = 111;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 190: {pInfo[playerid][Skin] = 112;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 191: {pInfo[playerid][Skin] = 113;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 192: {pInfo[playerid][Skin] = 114;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 193: {pInfo[playerid][Skin] = 115;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 194: {pInfo[playerid][Skin] = 116;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 195: {pInfo[playerid][Skin] = 0;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LS) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 1;
		}
case 196: {pInfo[playerid][Skin] = 117;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (SF) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 2;
		}
case 197: {pInfo[playerid][Skin] = 118;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (SF) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 2;
		}
case 198: {pInfo[playerid][Skin] = 120;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (SF) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 2;
		}
case 199: {pInfo[playerid][Skin] = 121;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (SF) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 2;
		}
case 200: {pInfo[playerid][Skin] = 122;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (SF) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 2;
		}
case 201: {pInfo[playerid][Skin] = 123;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (SF) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 2;
		}
case 202: {pInfo[playerid][Skin] = 126;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (SF) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 2;
		}
case 203: {pInfo[playerid][Skin] = 127;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (SF) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 2;
		}
case 204: {pInfo[playerid][Skin] = 143;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (SF) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 2;
		}
case 205: {pInfo[playerid][Skin] = 294;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (SF) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 2;
		}
case 206: {pInfo[playerid][Skin] = 41;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (SF) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 2;
		}
case 207: {pInfo[playerid][Skin] = 46;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (SF) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 2;
		}
case 208: {pInfo[playerid][Skin] = 47;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (SF) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 2;
		}
case 209: {pInfo[playerid][Skin] = 48;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (SF) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 2;
		}
case 210: {pInfo[playerid][Skin] = 98;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (SF) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 2;
		}
case 211: {pInfo[playerid][Skin] = 181;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LV) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 3;
		}
case 212: {pInfo[playerid][Skin] = 184;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LV) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 3;
		}
case 213: {pInfo[playerid][Skin] = 29;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LV) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 3;
		}
case 214: {pInfo[playerid][Skin] = 247;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LV) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 3;
		}
case 215: {pInfo[playerid][Skin] = 248;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LV) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 3;
		}
case 216: {pInfo[playerid][Skin] = 249;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LV) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 3;
		}
case 217: {pInfo[playerid][Skin] = 254;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LV) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 3;
		}
case 218: {pInfo[playerid][Skin] = 145;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LV) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 3;
		}
case 219: {pInfo[playerid][Skin] = 146;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LV) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 3;
		}
case 220: {pInfo[playerid][Skin] = 144;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LV) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 3;
		}
case 221: {pInfo[playerid][Skin] = 298;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal (LV) ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
		pInfo[playerid][City] = 3;
		}
case 222: {pInfo[playerid][Skin] = 24;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Security (LS) ~n~~r~OBJECTIVE: ~w~ Save lives",1000,5);
		pInfo[playerid][City] = 1;
		}
case 223: {pInfo[playerid][Skin] = 25;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Security (LS) ~n~~r~OBJECTIVE: ~w~ Save lives",1000,5);
		pInfo[playerid][City] = 1;
		}
case 224: {pInfo[playerid][Skin] = 66;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Security (SF) ~n~~r~OBJECTIVE: ~w~ Save lives",1000,5);
		pInfo[playerid][City] = 2;
		}
case 225: {pInfo[playerid][Skin] = 124;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Security (SF) ~n~~r~OBJECTIVE: ~w~ Save lives",1000,5);
		pInfo[playerid][City] = 2;
		}
case 226: {pInfo[playerid][Skin] = 125;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Security (SF) ~n~~r~OBJECTIVE: ~w~ Save lives",1000,5);
		pInfo[playerid][City] = 2;
		}
case 227: {pInfo[playerid][Skin] = 163;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Security (LV) ~n~~r~OBJECTIVE: ~w~ Save lives",1000,5);
		pInfo[playerid][City] = 3;
		}
case 228: {pInfo[playerid][Skin] = 164;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Security (LV) ~n~~r~OBJECTIVE: ~w~ Save lives",1000,5);
		pInfo[playerid][City] = 3;
		}
case 229: {pInfo[playerid][Skin] = 217;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Security (LV) ~n~~r~OBJECTIVE: ~w~ Save lives",1000,5);
		pInfo[playerid][City] = 3;
		}
case 230: {pInfo[playerid][Skin] = 61;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Pilot (LS) ~n~~r~OBJECTIVE: ~w~ Fly safely",1000,5);
		pInfo[playerid][City] = 1;
		}
case 231: {pInfo[playerid][Skin] = 255;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Pilot (LV) ~n~~r~OBJECTIVE: ~w~ Fly safely",1000,5);
		pInfo[playerid][City] = 3;
		}
case 232: {pInfo[playerid][Skin] = 63;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (LS) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 1;
		}
case 233: {pInfo[playerid][Skin] = 64;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (LS) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 1;
		}
case 234: {pInfo[playerid][Skin] = 244;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (LS) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 1;
		}
case 235: {pInfo[playerid][Skin] = 245;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (LS) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 1;
		}
case 236: {pInfo[playerid][Skin] = 256;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (LS) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 1;
		}
case 237: {pInfo[playerid][Skin] = 257;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (LS) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 1;
		}
case 238: {pInfo[playerid][Skin] = 243;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (LS) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 1;
		}
case 239: {pInfo[playerid][Skin] = 90;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (SF) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 2;
		}
case 240: {pInfo[playerid][Skin] = 92;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (SF) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 2;
		}
case 241: {pInfo[playerid][Skin] = 131;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (SF) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 2;
		}
case 242: {pInfo[playerid][Skin] = 152;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (SF) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 2;
		}
case 243: {pInfo[playerid][Skin] = 178;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (SF) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 2;
		}
case 244: {pInfo[playerid][Skin] = 87;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (SF) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 2;
		}
case 245: {pInfo[playerid][Skin] = 237;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (LV) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 3;
		}
case 246: {pInfo[playerid][Skin] = 238;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (LV) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 3;
		}
case 247: {pInfo[playerid][Skin] = 207;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (LV) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 3;
		}
case 248: {pInfo[playerid][Skin] = 82;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (LV) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 3;
		}
case 249: {pInfo[playerid][Skin] = 83;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (LV) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 3;
		}
case 250: {pInfo[playerid][Skin] = 84;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (LV) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 3;
		}
case 251: {pInfo[playerid][Skin] = 85;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (LV) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 3;
		}
case 252: {pInfo[playerid][Skin] = 264;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer (LV) ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
		pInfo[playerid][City] = 3;
		}
case 253: {pInfo[playerid][Skin] = 70;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Medic (LS) ~n~~r~OBJECTIVE: ~w~ Heal people",1000,5);
		pInfo[playerid][City] = 1;
		}
case 254: {pInfo[playerid][Skin] = 71;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Medic (LS) ~n~~r~OBJECTIVE: ~w~ Heal people",1000,5);
		pInfo[playerid][City] = 1;
		}
case 255: {pInfo[playerid][Skin] = 193;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Medic (SF) ~n~~r~OBJECTIVE: ~w~ Heal people",1000,5);
		pInfo[playerid][City] = 2;
		}
case 256: {pInfo[playerid][Skin] = 274;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Medic (SF) ~n~~r~OBJECTIVE: ~w~ Heal people",1000,5);
		pInfo[playerid][City] = 2;
		}
case 257: {pInfo[playerid][Skin] = 275;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Medic (LV) ~n~~r~OBJECTIVE: ~w~ Heal people",1000,5);
		pInfo[playerid][City] = 3;
		}
case 258: {pInfo[playerid][Skin] = 276;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Medic (LV) ~n~~r~OBJECTIVE: ~w~ Heal people",1000,5);
		pInfo[playerid][City] = 3;
		}
case 259: {pInfo[playerid][Skin] = 277;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Firefighter (LS) ~n~~r~OBJECTIVE: ~w~ Keep fires under control",1000,5);
		pInfo[playerid][City] = 1;
		}
case 260: {pInfo[playerid][Skin] = 279;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Firefighter (SF) ~n~~r~OBJECTIVE: ~w~ Keep fires under control",1000,5);
		pInfo[playerid][City] = 2;
		}
case 261: {pInfo[playerid][Skin] = 278;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Firefighter (LV) ~n~~r~OBJECTIVE: ~w~ Keep fires under control",1000,5);
		pInfo[playerid][City] = 3;
		}
case 262: {pInfo[playerid][Skin] = 166;
		GameTextForPlayer(playerid,"~g~ROLE: ~w~Special Agent (LS) ~n~~r~OBJECTIVE: ~w~ Prevent crime",1000,5);
		pInfo[playerid][City] = 1;
		}
case 263: {pInfo[playerid][Skin] = 284;

        if(!dini_Exists(udb_encode(player))) pInfo[playerid][CopBlock] = 1;

		GameTextForPlayer(playerid,"~g~ROLE: ~w~Police (LS) ~n~~r~OBJECTIVE: ~w~ Prevent crime",1000,5);
		pInfo[playerid][City] = 1;
		}
case 264: {pInfo[playerid][Skin] = 246;

        if(!dini_Exists(udb_encode(player))) pInfo[playerid][CopBlock] = 1;

		GameTextForPlayer(playerid,"~g~ROLE: ~w~Police (LS) ~n~~r~OBJECTIVE: ~w~ Prevent crime",1000,5);
		pInfo[playerid][City] = 1;
		}
case 265: {pInfo[playerid][Skin] = 280;

        if(!dini_Exists(udb_encode(player))) pInfo[playerid][CopBlock] = 1;

		GameTextForPlayer(playerid,"~g~ROLE: ~w~Police (LS) ~n~~r~OBJECTIVE: ~w~ Prevent crime",1000,5);
		pInfo[playerid][City] = 1;
		}
case 266: {pInfo[playerid][Skin] = 281;

        if(!dini_Exists(udb_encode(player))) pInfo[playerid][CopBlock] = 1;

		GameTextForPlayer(playerid,"~g~ROLE: ~w~Police (LS)~n~~r~OBJECTIVE: ~w~ Prevent crime",1000,5);
		pInfo[playerid][City] = 1;
		}
case 267: {pInfo[playerid][Skin] = 295;

        if(!dini_Exists(udb_encode(player))) pInfo[playerid][CopBlock] = 1;

		GameTextForPlayer(playerid,"~g~ROLE: ~w~Special Agent (SF) ~n~~r~OBJECTIVE: ~w~ Prevent crime",1000,5);
		pInfo[playerid][City] = 2;
		}
case 268: {pInfo[playerid][Skin] = 283;

        if(!dini_Exists(udb_encode(player))) pInfo[playerid][CopBlock] = 1;

		GameTextForPlayer(playerid,"~g~ROLE: ~w~Police (SF) ~n~~r~OBJECTIVE: ~w~ Prevent crime",1000,5);
		pInfo[playerid][City] = 2;
		}
case 269: {pInfo[playerid][Skin] = 286;

        if(!dini_Exists(udb_encode(player))) pInfo[playerid][CopBlock] = 1;

		GameTextForPlayer(playerid,"~g~ROLE: ~w~Police (SF) ~n~~r~OBJECTIVE: ~w~ Prevent crime",1000,5);
		pInfo[playerid][City] = 2;
		}
case 270: {pInfo[playerid][Skin] = 285;

        if(!dini_Exists(udb_encode(player))) pInfo[playerid][CopBlock] = 1;

		GameTextForPlayer(playerid,"~g~ROLE: ~w~Police (SF) ~n~~r~OBJECTIVE: ~w~ Prevent crime",1000,5);
		pInfo[playerid][City] = 2;
		}
case 271: {pInfo[playerid][Skin] = 165;

        if(!dini_Exists(udb_encode(player))) pInfo[playerid][CopBlock] = 1;

		GameTextForPlayer(playerid,"~g~ROLE: ~w~Special Agent (LV) ~n~~r~OBJECTIVE: ~w~ Prevent crime",1000,5);
		pInfo[playerid][City] = 3;
		}
case 272: {pInfo[playerid][Skin] = 287;

        if(!dini_Exists(udb_encode(player))) pInfo[playerid][CopBlock] = 1;

		GameTextForPlayer(playerid,"~g~ROLE: ~w~Police (LV) ~n~~r~OBJECTIVE: ~w~ Prevent crime",1000,5);
		pInfo[playerid][City] = 3;
		}
case 273: {pInfo[playerid][Skin] = 288;

        if(!dini_Exists(udb_encode(player))) pInfo[playerid][CopBlock] = 1;

		GameTextForPlayer(playerid,"~g~ROLE: ~w~Police (LV) ~n~~r~OBJECTIVE: ~w~ Prevent crime",1000,5);
		pInfo[playerid][City] = 3;
		}
case 274: {pInfo[playerid][Skin] = 282;

        if(!dini_Exists(udb_encode(player))) pInfo[playerid][CopBlock] = 1;

		GameTextForPlayer(playerid,"~g~ROLE: ~w~Police (LV) ~n~~r~OBJECTIVE: ~w~ Prevent crime",1000,5);
		pInfo[playerid][City] = 3;
		}
}
return 1;
}

//Callback edited
public OnPlayerSpawn(playerid)
{
new spawner[24],spawnmsg[120];
GetPlayerName(playerid,spawner,24);

if(FTActive == 1) {
new string[256];
format(string,sizeof(string),"A freeze countdown is already in progress! You have %d more seconds.",FTV);
SendClientMessage(playerid,yellow,string);
TogglePlayerControllable(playerid,0);
}

if (pInfo[playerid][Logged]){
	PlayerPlaySound(playerid, 1063, 1685.5280,-2240.3850,13.5469);
	SetPlayerToSpawn(playerid);
	SetPlayerToTeamColor(playerid);
	pInfo[playerid][Spawned] = 1;
	GameTextForPlayer(playerid,"~g~www.pure-rpg.de.tc",3999,1);
	format(spawnmsg,sizeof(spawnmsg),"%s (ID %d) spawned",spawner,playerid);
	print (spawnmsg);
	}
	else{
	if (!pInfo[playerid][Logged] && dini_Exists(udb_encode(spawner))){
		PlayerPlaySound(playerid, 1063, 1685.5280,-2240.3850,13.5469);
		format(spawnmsg,sizeof(spawnmsg),"%s (ID %d) spawned without logging in! - Auto-Kick!",spawner,playerid);
		print (spawnmsg);
		SendClientMessage(playerid,COLOR_RED,"(Kicked) You tried to spawn as a REGISTRED NAME without logging in.");
		GameTextForPlayer(playerid,"~w~Always ~r~/login~w~ before you spawn~r~!!!",30000,5);
    	pInfo[playerid][AutoKick] = 1;
		}
	}

if (pInfo[playerid][Jailed] || pInfo[playerid][Cuffed]){
	SetPlayerInterior(playerid,3);
	SetPlayerPos(playerid,198.5,162.5,1003.0);
	SetPlayerFacingAngle(playerid,180.0);
	SetCameraBehindPlayer(playerid);
	PlayerPlaySound(playerid,1069,198.5,162.5,1003.0);
	PlayerPlaySound(playerid,1068,198.5,162.5,1003.0);
	SendClientMessage(playerid,COLOR_RED,"/kill is disabled while jailed/badge loss or cuffed!");
	return 1;
}

if (pInfo[playerid][CopBlock]==1 && gTeam[playerid] == 10){
    PlayerPlaySound(playerid, 1063, 1685.5280,-2240.3850,13.5469);
	SetPlayerInterior(playerid,3);
	SetPlayerPos(playerid,198.5,162.5,1003.0);
	SetPlayerFacingAngle(playerid,180.0);
	SetCameraBehindPlayer(playerid);
	PlayerPlaySound(playerid,1069,198.5,162.5,1003.0);
	PlayerPlaySound(playerid,1068,198.5,162.5,1003.0);
	SendClientMessage(playerid,COLOR_RED,"Only licensed players are allowed to play a cop.");
	SendClientMessage(playerid,COLOR_RED,"Press F4 then /kill to select another class.");
	return 1;
}
PlayerPlaySound(playerid, 1063, 1685.5280,-2240.3850,13.5469);
return 1;
}

//Function
SetPlayerToSpawn(playerid)
{
new skinID,tmp1[255],tmp2[255],player[24];
new Weap1,Weap2,Weap3,Ammo1,Ammo2,Ammo3;

if (pInfo[playerid][GetSkin]==1 && pInfo[playerid][JoinTeam]==0){
GetPlayerName(playerid,player,24);
tmp1=dini_Get(udb_encode(player),"Skin");
skinID=strval(tmp1);
new tmp3[255];
format(tmp3,sizeof(tmp3),"Skin ID: %d",skinID);

switch (skinID){

//Team 1
	case 7,12,16,17,18,19,20,21,23,26,27,34,35,36,37,40,45,50,51,52,55,56,59,60,67,69,72:{
	gTeam[playerid] = 1;
	pInfo[playerid][Skin] = skinID;
	SetPlayerColor(playerid,COLOR_WHITE);
	Weap1 = 14;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Team: Civilian]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
	case 73,80,81,91,96,97,99,101,138,139,140,141,142,147,148,151,153,154,157,169,170,176:{
	gTeam[playerid] = 1;
	pInfo[playerid][Skin] = skinID;
	SetPlayerColor(playerid,COLOR_WHITE);
	Weap1 = 14;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Team: Civilian]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
	case 177,180,185,186,187,188,190,191,192,198,199,201,202,203,204,206,211,214,215:{
	gTeam[playerid] = 1;
	pInfo[playerid][Skin] = skinID;
	SetPlayerColor(playerid,COLOR_WHITE);
	Weap1 = 14;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Team: Civilian]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
	case 216,219,221,222,223,226,227,233,240,241,242,250,251,252,258,259,260,261,262:{
	gTeam[playerid] = 1;
	pInfo[playerid][Skin] = skinID;
	SetPlayerColor(playerid,COLOR_WHITE);
	Weap1 = 14;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Team: Civilian]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
	case 263,290,291,296,297:{
	gTeam[playerid] = 1;
	pInfo[playerid][Skin] = skinID;
	SetPlayerColor(playerid,COLOR_WHITE);
	Weap1 = 14;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Team: Civilian]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
//Team 2
	case 1,9,10,14,15,31,32,33,38,39,43,44,49,53,54,57,58,62,68,75,76,77,78,79,88,89,93:{
	gTeam[playerid] = 2;
	pInfo[playerid][Skin] = skinID;
	SetPlayerColor(playerid,COLOR_WHITE);
	Weap1 = 15;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Senior]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
	case 94,95,128,129,130,132,133,134,135,136,137,150,156,158,159,160,161,162,182,183:{
	gTeam[playerid] = 2;
	pInfo[playerid][Skin] = skinID;
	SetPlayerColor(playerid,COLOR_WHITE);
	Weap1 = 15;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Senior]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
	case 196,197,200,210,212,213,218,220,224,225,228,229,230,231,232,234,235,236,239:{
	gTeam[playerid] = 2;
	pInfo[playerid][Skin] = skinID;
	SetPlayerColor(playerid,COLOR_WHITE);
	Weap1 = 15;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Senior]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
//Team 3
	case 11,155,167,168,171,172,179,189,194,205,209,253:{
	gTeam[playerid] = 3;
	pInfo[playerid][Skin] = skinID;
	SetPlayerColor(playerid,COLOR_LIGHTBLUE);
	Weap1 = 7;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Waiter]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
//Team 4
	case 13,22,28,29,30,41,46,47,48,98,100,102,103,104,105,106,107,108,109,110,111,112:{
	gTeam[playerid] = 4;
	pInfo[playerid][Skin] = skinID;
	SetPlayerColor(playerid,COLOR_ORANGE);
	Weap1 = 5;
	Ammo1 = 1;
	Weap2 = 22;
	Ammo2 = 30;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Criminal]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
	case 113,114,115,116,117,118,119,120,121,122,123,126,127,143,144,145,146,173:{
	gTeam[playerid] = 4;
	pInfo[playerid][Skin] = skinID;
	SetPlayerColor(playerid,COLOR_ORANGE);
	Weap1 = 5;
	Ammo1 = 1;
	Weap2 = 22;
	Ammo2 = 30;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Criminal]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
	case 0,174,175,181,184,195,247,248,249,254,292,293,294,298,299:{
	gTeam[playerid] = 4;
	pInfo[playerid][Skin] = skinID;
	SetPlayerColor(playerid,COLOR_ORANGE);
	Weap1 = 5;
	Ammo1 = 1;
	Weap2 = 22;
	Ammo2 = 30;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Criminal]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
//Team 5
	case 24,25,66,124,125,163,164,217:{
	gTeam[playerid] = 5;
	pInfo[playerid][Skin] = skinID;
	SetPlayerColor(playerid,COLOR_LIGHTBLUE);
	Weap1 = 3;
	Ammo1 = 1;
	Weap2 = 23;
	Ammo2 = 30;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Security]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
//Team 6
	case 61,255:{
	gTeam[playerid] = 6;
	pInfo[playerid][Skin] = skinID;
	SetPlayerColor(playerid,COLOR_YELLOW);
	Weap1 = 46;
	Ammo1 = 1;
	Weap2 = 39;
	Ammo2 = 5;
	Weap3 = 40;
	Ammo3 = 5;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Pilot]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
//Team 7
	case 63,64,82,83,84,85,87,90,92,131,152,178,207,237,238,243,244,245,256,257,264:{
	gTeam[playerid] = 7;
	pInfo[playerid][Skin] = skinID;
	SetPlayerColor(playerid,COLOR_BRIGHTRED);
	Weap1 = 12;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Entertainer]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
//Team 8
	case 70,71,193,274,275,276:{
	gTeam[playerid] = 8;
	pInfo[playerid][Skin] = skinID;
	SetPlayerColor(playerid,COLOR_PINK);
	Weap1 = 2;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Medic]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
//Team 9
	case 277,278,279:{
	gTeam[playerid] = 9;
	pInfo[playerid][Skin] = skinID;
	SetPlayerColor(playerid,COLOR_RED);
	Weap1 = 42;
	Ammo1 = 100000;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Fireman]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
//Team 10
	case 165,166,246,280,281,282,283,284,285,286,287,288,295:{
	gTeam[playerid] = 10;
	pInfo[playerid][Skin] = skinID;
	SetPlayerColor(playerid,BBLUE);
	Weap1 = 24;
	Ammo1 = 30;
	Weap2 = 3;
	Ammo2 = 1;
	Weap3 = 41;
	Ammo3 = 5000;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Cop]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
}
}
new spawnID;
tmp2 = dini_Get(udb_encode(player),"SpawnX");
spawnID = strval(tmp2);

if (pInfo[playerid][JoinTeam]==1) skinID = pInfo[playerid][Skin];

new Float:SpawnX=floatstr(dini_Get(udb_encode(player),"SpawnX"));
new Float:SpawnY=floatstr(dini_Get(udb_encode(player),"SpawnY"));
new Float:SpawnZ=floatstr(dini_Get(udb_encode(player),"SpawnZ"));
new Float:SpawnA=floatstr(dini_Get(udb_encode(player),"SpawnA"));

switch (gTeam[playerid]){
		case 1:{
		Weap1 = 14;
		Ammo1 = 1;
		Weap2 = 0;
		Ammo2 = 0;
		Weap3 = 0;
		Ammo3 = 0;
		}
		case 2:{
		Weap1 = 15;
		Ammo1 = 1;
		Weap2 = 0;
		Ammo2 = 0;
		Weap3 = 0;
		Ammo3 = 0;
		}
		case 3:{
		Weap1 = 7;
		Ammo1 = 1;
		Weap2 = 0;
		Ammo2 = 0;
		Weap3 = 0;
		Ammo3 = 0;
		}
		case 4:{
		Weap1 = 5;
		Ammo1 = 1;
		Weap2 = 22;
		Ammo2 = 30;
		Weap3 = 0;
		Ammo3 = 0;
		}
		case 5:{
		Weap1 = 3;
		Ammo1 = 1;
		Weap2 = 23;
		Ammo2 = 30;
		Weap3 = 0;
		Ammo3 = 0;
		}
		case 6:{
		Weap1 = 46;
		Ammo1 = 1;
		Weap2 = 39;
		Ammo2 = 5;
		Weap3 = 40;
		Ammo3 = 5;
		}
		case 7:{
		Weap1 = 12;
		Ammo1 = 1;
		Weap2 = 0;
		Ammo2 = 0;
		Weap3 = 0;
		Ammo3 = 0;
		}
		case 8:{
		Weap1 = 2;
		Ammo1 = 1;
		Weap2 = 0;
		Ammo2 = 0;
		Weap3 = 0;
		Ammo3 = 0;
		}
		case 9:{
		Weap1 = 42;
		Ammo1 = 100000;
		Weap2 = 0;
		Ammo2 = 0;
		Weap3 = 0;
		Ammo3 = 0;
		}
		case 10:{
		Weap1 = 24;
		Ammo1 = 30;
		Weap2 = 3;
		Ammo2 = 1;
		Weap3 = 41;
		Ammo3 = 5000;
		}
	}

if (spawnID!=0){
    SetPlayerInterior(playerid,0);
	SetSpawnInfo(playerid,gTeam[playerid],skinID,SpawnX,SpawnY,SpawnZ,SpawnA,Weap1,Ammo1,Weap2,Ammo2,Weap3,Ammo3);
 	return 1;
	}

 	switch (pInfo[playerid][City]){
		case 1:{
		SpawnX = 1685.5280;
		SpawnY = -2240.3850;
		SpawnZ = 13.5469;
		SpawnA = 179.7263;
		}
// SF : -1974.0000, 128.0000,28.0000,4.0000
// LV : 2124.0000,1146.0000,14.0000,241.0000
		case 2:{
		SpawnX = -1974.0000;
		SpawnY = 128.0000;
		SpawnZ = 28.0000;
		SpawnA = 4.0000;
		}
		case 3:{
		SpawnX = 2124.0000;
		SpawnY = 1146.0000;
		SpawnZ = 14.0000;
		SpawnA = 241.0000;
		}
 	}
SetPlayerInterior(playerid,0);
SetSpawnInfo(playerid,gTeam[playerid],skinID,SpawnX,SpawnY,SpawnZ,SpawnA,Weap1,Ammo1,Weap2,Ammo2,Weap3,Ammo3);
return 1;
}

//Callback edited
public OnPlayerDeath(playerid, killerid, reason)
{
if (pInfo[playerid][Jailed] || pInfo[playerid][Cuffed]){
	return 0;
	}
new health2,player[24],deathstr[120];
new Float:health;

GetPlayerName(playerid,player,sizeof(player));
GetPlayerHealth(killerid,health);
health2 = floatround(health,floatround_floor);

if (Minigames[BurnRunning] && pInfo[playerid][PlayBurn]){
format(deathstr,sizeof(deathstr),"%s (ID %d) died in the minigame.",player,playerid);
SendClientMessageToAll(COLOR_GREY,deathstr);
pInfo[playerid][BurnRespawn] = 1;
return 1;
}

if (Minigames[DerbyRunning] && pInfo[playerid][PlayDerby]){
format(deathstr,sizeof(deathstr),"%s (ID %d) died in the minigame.",player,playerid);
SendClientMessageToAll(COLOR_GREY,deathstr);
pInfo[playerid][PlayDerby] = 0;
return 1;
}
if (health2 >=30){
	SendDeathMessage(killerid, playerid,reason);
	pInfo[killerid][AddWanted] = 1;
	SendClientMessage(killerid,COLOR_RED,"You DMed a player. Because you were not in a life endangering situation you are now wanted for murder.");
    SendClientMessage(killerid,COLOR_YELLOW,"Kill only when you are being attacked and low on health.");
	if (gTeam[killerid] == TEAM_COPS){
        pInfo[killerid][Jailed] = 1;
        SetPlayerColor(killerid,COLOR_GREY);
        SendClientMessage(killerid,BBLUE,"You lost your police badge for killing another player.");
        SendClientMessage(killerid,COLOR_YELLOW,"Use /cuff then /check on players instead of killing (kill only when you are low on health!)");
		}
	return 1;
	}
	
//PART OF XADMIN
	if (killerid != INVALID_PLAYER_ID) {
	 	new killer[MAX_PLAYER_NAME]; GetPlayerName(killerid,killer,sizeof(killer));
	 	new victim[MAX_PLAYER_NAME]; GetPlayerName(playerid,victim,sizeof(victim));
		new KillFile[256]; format(KillFile,sizeof(KillFile),"/xadmin/%s.ini",udb_encode(killer));
		new DeathFile[256]; format(DeathFile,sizeof(DeathFile),"/xadmin/%s.ini",udb_encode(victim));
		Kills[killerid] += 1; Deaths[playerid] +=1;
		dini_IntSet(KillFile,"kills",Kills[killerid]); dini_IntSet(DeathFile,"deaths",Deaths[playerid]);
	 }
//****************

if (pInfo[playerid][isPassenger]){
pInfo[playerid][isPassenger] = 0;
return 0;
}
	
if (playerid == LSPilot && LSFlight[Flying]){
SendClientMessage(playerid,COLOR_RED,"You lost the charter pilot job because you died on a flight");
LSPilot = -1;
SendClientMessageToAll(BBLUE,"The LS charter pilot died during a flight. The position is vacant and the passengers survived.");

	for (new su=0;su<MAX_PLAYERS;su++){
	    if (pInfo[su][isPassenger]){
		GivePlayerMoney(su,10000);
		SendClientMessage(su,COLOR_RED,"The pilot died. The plane crashed. Your family got 10000$ by the airline for their pain.");
		SetPlayerToSpawn (su);
	    }
	}

// PART OF TRATULLA'S IRC ECHO SCRIPT
    new string[256];
    new wname[24];
	if (reason == 0)
	{
	    wname = "Unarmed";
	} else
	{
	    GetWeaponName( reason, wname, sizeof( wname ) );
	}

	if( killerid != INVALID_PLAYER_ID )
	{
		format( string, sizeof( string ), "[kill] %d %s %d %s %s", killerid, PlayerName( killerid ), playerid, PlayerName( playerid ), wname );
		WriteEcho( string );
	} else
	{
		format( string, sizeof( string ), "[died] %d %s", playerid, PlayerName( playerid ) );
		WriteEcho( string );
	}
//*************************************

return 1;
}

if (playerid == SFPilot && SFFlight[Flying]){
SendClientMessage(playerid,COLOR_RED,"You lost the charter pilot job because you died on a flight");
SFPilot = -1;
SendClientMessageToAll(BBLUE,"The SF charter pilot died during a flight. The position is vacant and the passengers survived.");

	for (new su=0;su<MAX_PLAYERS;su++){
	    if (pInfo[su][isPassenger]){
		GivePlayerMoney(su,10000);
		SendClientMessage(su,COLOR_RED,"The pilot died. The plane crashed. Your family got 10000$ by the airline for their pain.");
		SetPlayerToSpawn (su);
	    }
	}
return 1;
}

if (playerid == LVPilot && LVFlight[Flying]){
SendClientMessage(playerid,COLOR_RED,"You lost the charter pilot job because you died on a flight");
LVPilot = -1;
SendClientMessageToAll(BBLUE,"The LV charter pilot died during a flight. The position is vacant and the passengers survived.");

	for (new su=0;su<MAX_PLAYERS;su++){
	    if (pInfo[su][isPassenger]){
		GivePlayerMoney(su,10000);
		SendClientMessage(su,COLOR_RED,"The pilot died. The plane crashed. Your family got 10000$ by the airline for their pain.");
		SetPlayerToSpawn (su);
	    }
	}
return 1;
}

if (playerid == LSTaxidrvr){
	SendClientMessage(playerid,COLOR_RED,"You lost the taxidriver job because you died on a transfer");
	LSTaxidrvr = -1;
	LSTaxicust = -1;
	SendClientMessageToAll(BBLUE,"The LS taxidriver died. The position is vacant now.");
	return 1;
	}

if (playerid == SFTaxidrvr){
	SendClientMessage(playerid,COLOR_RED,"You lost the taxidriver job because you died on a transfer");
	SFTaxidrvr = -1;
	SFTaxicust = -1;
	SendClientMessageToAll(BBLUE,"The SF taxidriver died. The position is vacant now.");
	return 1;
	}
	
if (playerid == LVTaxidrvr){
	SendClientMessage(playerid,COLOR_RED,"You lost the taxidriver job because you died on a transfer");
	LVTaxidrvr = -1;
	LVTaxicust = -1;
	SendClientMessageToAll(BBLUE,"The LV taxidriver died. The position is vacant now.");
	return 1;
	}

SendDeathMessage(killerid, playerid,reason);
return 1;
}

//Callback
public OnPlayerText(playerid, text[])
{
new player[24],echostr[256];
	GetPlayerName(playerid,player,24);
	
if (pInfo[playerid][Jailed]){
	SendClientMessage(playerid,COLOR_RED,"You are not allowed to chat in stock while jailed/muted/badge loss!");
 	return 0;
	}
	for (new fil=1;fil<=6;fil++){//fil <= [NUMBER OF ELEMENTS to filter]
	new strresult;
	
	switch (fil){
	case 1: strresult = strfind(text,"Hacks",true,0);
	case 2: strresult = strfind(text,"Hacker",true,0);
	case 3: strresult = strfind(text,"Hacking",true,0);
	case 4: strresult = strfind(text,"Cheats",true,0);
	case 5: strresult = strfind(text,"Cheater",true,0);
	case 6: strresult = strfind(text,"Cheating",true,0);
	}
	
		if (strresult!=-1){
		SendClientMessage(playerid,COLOR_RED,"Do not accuse people of cheating/hacking in stock and without proof!");
		SendClientMessage(playerid,COLOR_YELLOW,"Use /admins, /PM [ID] [TEXT] or /A to contact an admin in private.");
  		print ("(Word filter active - Message not transfered to public)");
		return 0;
		}
		
		if (pInfo[playerid][OOC]){
		format(echostr,256,"[OoC chat] %s: %s",player,text);
		SendClientMessageToAll(COLOR_GREY,echostr);
		format(echostr,256,"[chat] OoC %s %s",player,text);
		WriteEcho(echostr);
		return 0;
		}
	}
	
// PART OF TRATULLA'S IRC ECHO SCRIPT
	new string[256];
	format( string, sizeof( string ), "[chat] %d %s %s", playerid, PlayerName( playerid ), text );
	WriteEcho( string );
//************************************
	
return 1;
}

//Callback edited
public OnPlayerCommandText(playerid,cmdtext[])
{
new idx,cmd[256],size1,size2,size3,dancestyle; cmd = strtok(cmdtext, idx);
new player[24];
GetPlayerName(playerid,player,sizeof(player));


size1=strlen(cmd) + 1;
size2=strlen(cmdtext) + 1;
size3=size2 - size1;

strmid(cmdtext,cmdtext,size1,size2,size3);


// EXTRA ACTIONS SCRIPT BY KYEMAN
// HANDSUP
 	if(strcmp(cmd, "/handsup", true) == 0) {
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
  	  		return 1;
		}
	}

	// Extra anims

 	if(strcmp(cmd, "/drunk", true) == 0) {
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"PED","WALK_DRUNK",4.1,1,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/wave", true) == 0) {
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"KISSING","BD_GF_Wave",4.1,1,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/gift", true) == 0) {
 		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"KISSING","gift_give",4.1,1,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/lap", true) == 0) {
 		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"LAPDAN1","LAPDAN_D",4.1,1,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/bitchslap", true) == 0) {
 		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"MISC","bitchslap",4.1,1,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/seat", true) == 0) {
 		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"MISC","SEAT_LR",4.1,0,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/balls", true) == 0) {
 		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"MISC","Scratchballs_01",4.1,1,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/knife", true) == 0) {
 		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"KNIFE","KILL_Knife_Ped_Die",4.1,0,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/pedal", true) == 0) {
 		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"GYMNASIUM","gym_bike_pedal",4.1,1,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/plunger", true) == 0) {
 		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"MISC","Plunger_01",4.1,1,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/ghand", true) == 0) {
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"GHANDS","gsign1",4.1,1,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/celebrate", true) == 0) {
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"Freeweights","gym_free_celebrate",4.1,1,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/chat", true) == 0) {
 		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"MISC","Idle_Chat_02",4.1,1,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/rope", true) == 0) {
 		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"ped","abseil",4.1,1,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/fucku", true) == 0) {
 		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"ped","fucku",4.1,1,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/drown", true) == 0) {
 		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"ped","drown",4.1,0,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/bomb", true) == 0) {
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"ped","bomber",4.1,0,1,1,1,1);
  	  		return 1;
		    }
		}
	if(strcmp(cmd, "/wall", true) == 0) {
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"ped","HIT_wall",4.1,0,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/laugh", true) == 0) {
 		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"RAPPING","Laugh_01",4.1,1,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/skate", true) == 0) {
	   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"SKATE","skate_sprint",4.1,1,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/sunbath", true) == 0) {
	   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"SUNBATHE","batherdown",4.1,1,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/sword", true) == 0) {
	   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"SWORD","sword_1",4.1,1,1,1,1,1);
  	  		return 1;
		}
	}
	if(strcmp(cmd, "/cpr", true) == 0) {
	   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		    ApplyAnimation(playerid,"MEDIC","CPR",4.1,1,1,1,1,1);
  	  		return 1;
		}
 	}

	// SUICIDE COMMAND
 	if(strcmp(cmd, "/kill", true) == 0) {
	    SetPlayerHealth(playerid,0.0);
  	  	return 1;
	}

	// START DANCING
 	if(strcmp(cmd, "/dance", true) == 0) {
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {

		    // Get the dance style param
      	
			if(!strlen(cmdtext)) {
				SendClientMessage(playerid,0xFF0000FF,"Usage: /dance [style 1-4]");
				return 1;
			}

			dancestyle = strval(cmdtext);
			if(dancestyle < 1 || dancestyle > 4) {
			    SendClientMessage(playerid,0xFF0000FF,"Usage: /dance [style 1-4]");
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
	}
// END OF EXTRA ACTIONS BY KYEMAN

// X admin script by ReGeX & Koolio
	new xstring[256],Float:HP;
	new name[MAX_PLAYER_NAME]; GetPlayerName(playerid,name,sizeof(name));
	new PF[256]; format(PF,sizeof(PF),"xadmin/%s.ini",udb_encode(name));

if (Stfu[playerid]==1) { StfuW[playerid] -= 1;
	if(StfuW[playerid] != 0) { SendClientMessage(playerid,green,"You are currently on the STFU list. Do not further speak or else you will be kicked."); format(xstring,sizeof(xstring),"You have %d warning(s) left.",StfuW[playerid]); SendClientMessage(playerid,green,xstring); dini_IntSet(PF,"stfuwarnings",StfuW[playerid]); return 0; }
	else { SendClientMessage(playerid,green,"You have been warned!"); format(xstring,sizeof(xstring),"%s has been kicked from the game. (Reason: Attempt to Intercept STFU)",name); SendClientMessageToAll(yellow,xstring); dini_IntSet(PF,"stfuwarnings",2); Kick(playerid); return 0; }
	//return 0;
}
//----------------------------------
//Function_detail
if(strcmp(cmd,"/detail",true)==0) { SendClientMessage(playerid,green,"[X-Treme Admin System || By: ReGeX & Koolio || Edit for this server: M1k3");
										SendClientMessage(playerid,green,"|| Version: 1.3 || Patch: SYSTEM (2)]"); return 1; }
//----------------------------------

//Player Statistics System
//Function_stat
if(strcmp(cmd,"/stat",true) == 0) {

new ref[MAX_PLAYER_NAME]; GetPlayerName(strval(cmdtext),ref,sizeof(ref));
new reffile[256]; format(reffile,sizeof(reffile),"/xadmin/%s.ini",udb_encode(ref));
new Float:killz, Float:deathz, Float:ratio;
killz = Kills[strval(cmdtext)]; deathz = Deaths[strval(cmdtext)]; ratio = killz / deathz;
	if (Registered[strval(cmdtext)] == 1) {
		if (!strlen(cmdtext)) { format(xstring,sizeof(xstring),"Your Stats - Kills: %0.0f || Deaths: %0.0f || Ratio: %0.2f",killz,deathz,ratio); SendClientMessage(playerid,green,xstring); return 1; }
		if(IsPlayerConnected(strval(cmdtext))) {
		    if (strval(cmdtext)!=playerid) format(xstring,sizeof(xstring),"%s's Stats - %0.0f || Deaths: %0.0f || Ratio: %0.2f",ref,killz,deathz,ratio);
	    	else format(xstring,sizeof(xstring),"Your Stats - Kills: %0.0f || Deaths: %0.0f || Ratio: %0.2f",killz,deathz,ratio);
            SendClientMessage(playerid,green,xstring);
		} else SendClientMessage(playerid,red,"Error: Invalid ID Number!");
	} else SendClientMessage(playerid,red,"Error: This player must register to the server first!");
return 1;
}
if(strcmp(cmd,"/admins",true)==0) {
new AdminString[300],AdminNum;
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && LoggedIn[i] == 1 && Level[i] > 0) AdminNum += 1;
	if (AdminNum == 0) { SendClientMessage(playerid,green,"No administrators are currently online."); return 1; }
	if (AdminNum == 1) {
	    for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && LoggedIn[i] == 1 && Level[i] > 0) { GetPlayerName(i,name,sizeof(name)); format(AdminString,sizeof(AdminString),"%s",name); }
		}
		format(xstring,sizeof(xstring),"Admins Online: %s",AdminString); SendClientMessage(playerid,green,xstring);
	return 1;
	}
	if (AdminNum >= 1) {
	new Occ = 0;
		for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && LoggedIn[i] == 1 && Level[i] > 0) {
				GetPlayerName(i,name,sizeof(name));
				if (Occ == 0) format(AdminString,sizeof(AdminString),"%s",name);
				if (Occ > 0) format(AdminString,sizeof(AdminString),"%s, %s",AdminString,name);
				Occ++;
			}
		}
	format(xstring,sizeof(xstring),"Admins Online: %s",AdminString);
	SendClientMessage(playerid,green,xstring);
	return 1;
	}
return 1;
}
//----------------------------------
//Player Registration System
//Function_xlogin
if(strcmp(cmd,"/xlogin",true) == 0) {

	if (dini_Exists(PF)) {
		if (!strlen(cmdtext)) { SendClientMessage(playerid,red,"Syntax: /XLOGIN <PASSWORD>"); return 1; }
		if(Registered[playerid] == 1 && LoggedIn[playerid] == 0) {
			if(dini_Int(PF,"password") == udb_hash(cmdtext)) {
				if (dini_Int(PF,"level")==0) { SendClientMessage(playerid,green,"You have logged in as a member."); dini_IntSet(PF,"loggedin",1); LoggedIn[playerid] = 1; }
				else { format(xstring,sizeof(xstring),"You have logged in as an administrator. [Level %d]",dini_Int(PF,"level")); SendClientMessage(playerid,green,xstring); dini_IntSet(PF,"loggedin",1); LoggedIn[playerid] = 1; }
			}
			else {
				LogTry[playerid] -= 1; new tries = LogTry[playerid];
				if (tries > 0) { format(xstring,sizeof(xstring),"Incorrect Password: You have %d try(s) remaining.",tries); SendClientMessage(playerid,red,xstring); }
				else { format(xstring,sizeof(xstring),"%s has been kicked from the game. (Reason: Login Failure)",name); SendClientMessageToAll(yellow,xstring); dini_IntSet(PF,"logintry",3); Kick(playerid); }
			}
		} else SendClientMessage(playerid,red,"Error: Please make sure that you have registered and logged out first.  You might already be logged in.");
	} else SendClientMessage(playerid,red,"Error: You must create a server account first. To register, type '/XREGISTER <PASSWORD>.");
return 1;
}
if(strcmp(cmd,"/xlogout",true)==0) {
	if(Registered[playerid] == 1 && LoggedIn[playerid] == 1) {
		SendClientMessage(playerid,yellow,"You have logged out of your server account.");
		dini_IntSet(PF,"loggedin",0); dini_IntSet(PF,"cash",0); LoggedIn[playerid] = 0;
	} else SendClientMessage(playerid,red,"Error: You have to be registered and logged into the server first.");
return 1;
}
if(strcmp(cmd,"/xregister",true) == 0) {

	if (!strlen(cmdtext)) { SendClientMessage(playerid,red,"Syntax: /XREGISTER <PASSWORD>"); return 1; }
	if (Registered[playerid] == 0) {
		if ((strlen(cmdtext) >= 5) && (strlen(cmdtext) <= 20)) {
		    if (LoggedIn[playerid] == 0) {
				dini_IntSet(PF,"registered",1); dini_IntSet(PF,"loggedin",0); dini_IntSet(PF,"passworded",1); dini_IntSet(PF,"password",udb_hash(cmdtext)); Registered[playerid] = 1; LoggedIn[playerid] = 1; dini_IntSet(PF,"loggedin",1);
				format(xstring,sizeof(xstring),"You have successfully registered User %s. You have automatically been logged in.",name); SendClientMessage(playerid,yellow,xstring);
			} else SendClientMessage(playerid,red,"Error: This account has already been created. To login, type '/XLOGIN <PASSWORD>.");
		} else SendClientMessage(playerid,red,"Error: The password you have entered is too short or too long. (Min: 5, Max: 20)");
    } else SendClientMessage(playerid,red,"Error: This account has already been created. To login, type '/XLOGIN <PASSWORD>.");
return 1;
}
//----------------------------------
//Administration System
//Function_serverinfo
if(strcmp(cmd,"/serverinfo",true)==0) {
	if(IsPlayerLevel(playerid,1)) {
	    format(xstring,sizeof(xstring),"Server Information: %d/%d",ReturnPlayers(),GetMaxPlayers()); SendClientMessage(playerid,yellow,xstring);
	} else SendClientMessage(playerid,red,"Error: You must be logged in as administrator level 1+.");
return 1;
}

//Function_goto
if(strcmp(cmd,"/goto",true)==0 || strcmp(cmd,"/telto",true)==0) {
	if(IsPlayerLevel(playerid,1)) {
	
	new Float:X,Float:Y,Float:Z;
		if (!strlen(cmdtext)) { SendClientMessage(playerid,red,"Syntax: (/GOTO | /TELTO) <NICK OR ID>"); return 1; }
		if(!IsNumeric(cmdtext)) {
			new id = MatchID(cmdtext);
			if(id != -1) format(cmdtext,strlen(cmdtext),"%d",id);
			else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
		}
		if(IsPlayerConnected(strval(cmdtext))) {
		new ref[MAX_PLAYER_NAME]; GetPlayerName(strval(cmdtext),ref,sizeof(ref));
		    if (strval(cmdtext)!=playerid) {
		        format(xstring,sizeof(xstring),"*** %s has used the command '/GOTO'.",name); SendMessageToAdminEx(playerid,xstring);
		        SetPlayerInterior(playerid,GetPlayerInterior(strval(cmdtext)));
		        if (IsPlayerInAnyVehicle(playerid)) { GetPlayerPos(strval(cmdtext),X,Y,Z); SetVehiclePos(GetPlayerVehicleID(playerid),X+5,Y,Z+1); }
				else { GetPlayerPos(strval(cmdtext),X,Y,Z); SetPlayerPos(playerid,X+5,Y,Z+1); }
				format(xstring,sizeof(xstring),"%s has teleported to your location.",name); SendClientMessage(strval(cmdtext),yellow,xstring);
				format(xstring,sizeof(xstring),"You have teleported to %s's location.",ref); SendClientMessage(playerid,yellow,xstring);
			} else SendClientMessage(playerid,red,"Error: You can not use this command on yourself.");
		} else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
	} else AdminError(playerid,1);
return 1;
}

//Function_gethere
if(strcmp(cmd,"/gethere",true)==0 || strcmp(cmd,"/telid",true)==0) {
	if(IsPlayerLevel(playerid,7)) {
	new Float:X,Float:Y,Float:Z;
	
	if (!strlen(cmdtext)) { SendClientMessage(playerid,red,"Syntax: (/GETHERE | /TELID) <NICK OR ID>"); return 1; }
		if(!IsNumeric(cmdtext)) {
			new id = MatchID(cmdtext);
			if(id != -1) format(cmdtext,strlen(cmdtext),"%d",id);
			else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
		}
		if(IsPlayerConnected(strval(cmdtext))) {
		new ref[MAX_PLAYER_NAME]; GetPlayerName(strval(cmdtext),ref,sizeof(ref));
		    if (strval(cmdtext)!=playerid) {
		    	if (IsPlayerLowerLevel(playerid,strval(cmdtext))) {
		    	    format(xstring,sizeof(xstring),"*** %s has used the command '/GETHERE'.",name); SendMessageToAdminEx(playerid,xstring);
			        if (IsPlayerInAnyVehicle(strval(cmdtext))) { GetPlayerPos(playerid,X,Y,Z); SetVehiclePos(GetPlayerVehicleID(strval(cmdtext)),X+5,Y,Z+1); }
					else { SetPlayerInterior(strval(cmdtext),GetPlayerInterior(playerid)); GetPlayerPos(playerid,X,Y,Z); SetPlayerPos(strval(cmdtext),X+5,Y,Z+1); }
	                format(xstring,sizeof(xstring),"You have been teleported to Admin %s.",name); SendClientMessage(strval(cmdtext),yellow,xstring);
					format(xstring,sizeof(xstring),"You have teleported %s to your location.",ref); SendClientMessage(playerid,yellow,xstring);
				} else SendClientMessage(playerid,red,"Error: You can not teleport a player with a higher level than you.");
			} else SendClientMessage(playerid,red,"Error: You can not use this command to teleport yourself.");
		} else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
	} else AdminError(playerid,7);
return 1;
}

//Function_kick
if(strcmp(cmd,"/kick",true)==0) {
	if(IsPlayerLevel(playerid,1)) {
	
	if (!strlen(cmdtext)) { SendClientMessage(playerid,red,"Syntax: /KICK <NICK OR ID> (<REASON>)"); return 1; }
		if(!IsNumeric(cmdtext)) {
			new id = MatchID(cmdtext);
			if(id != -1) format(cmdtext,strlen(cmdtext),"%d",id);
			else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
		}
		if(IsPlayerConnected(strval(cmdtext))) {
  			if (playerid != strval(cmdtext)) {
  			    if (IsPlayerLowerLevel(playerid,strval(cmdtext))) {
  			    new ref[MAX_PLAYER_NAME]; GetPlayerName(strval(cmdtext),ref,sizeof(ref));
				new reffile[256]; format(reffile,sizeof(reffile),"/xadmin/%s.ini",udb_encode(ref));
  			    	format(xstring,sizeof(xstring),"*** %s has used the command '/KICK'.",name); SendMessageToAdminEx(playerid,xstring);
		    		format(xstring,sizeof(xstring),"%s has been kicked by Admin %s.",ref,name);
					
					SendClientMessageToAll(yellow,xstring); dini_IntSet(reffile,"logintry",3); Kick(strval(cmdtext));
				} else SendClientMessage(playerid,red,"Error: You can not kick a player with a higher level than you.");
			} else SendClientMessage(playerid,red,"Error: For security reasons, you can not kick yourself.");
		} else SendClientMessage(playerid,red,"Error: Invalid name or ID.!");
	} else AdminError(playerid,3);
return 1;
}

//Function_ban
if(strcmp(cmd,"/ban",true)==0) {
	if(IsPlayerLevel(playerid,2)) {
	
	if (!strlen(cmdtext)) { SendClientMessage(playerid,red,"Syntax: /BAN <NICK OR ID> (<REASON>)"); return 1; }
		if(!IsNumeric(cmdtext)) {
			new id = MatchID(cmdtext);
			if(id != -1) format(cmdtext,strlen(cmdtext),"%d",id);
			else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
		}
		if(IsPlayerConnected(strval(cmdtext))) {
  			if (playerid != strval(cmdtext)) {
  			    if (IsPlayerLowerLevel(playerid,strval(cmdtext))) {
  			    new ref[MAX_PLAYER_NAME]; GetPlayerName(strval(cmdtext),ref,sizeof(ref));
				new reffile[256]; format(reffile,sizeof(reffile),"/xadmin/%s.ini",udb_encode(ref));
  			        format(xstring,sizeof(xstring),"*** %s has used the command '/BAN'.",name); SendMessageToAdminEx(playerid,xstring);
			    	format(xstring,sizeof(xstring),"%s has been banned by Admin %s.",ref,name);
						SendClientMessageToAll(yellow,xstring); dini_IntSet(reffile,"logintry",3); Ban(strval(cmdtext));
  				} else SendClientMessage(playerid,red,"Error: You can not ban a player with a higher level than you.");
			} else SendClientMessage(playerid,red,"Error: For security reasons, you can not ban yourself.");
		} else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
	} else AdminError(playerid,2);
return 1;
}

//Function_god
if(strcmp(cmd,"/god",true)==0) {
	if(IsPlayerLevel(playerid,10)) { SetPlayerHealth(playerid,1000000000); GivePlayerWeapon(playerid,38,100000); GivePlayerWeapon(playerid,8,1); SendClientMessage(playerid,yellow,"You have given yourself godhealth, minigun, and a katana!"); format(xstring,sizeof(xstring),"*** %s has used the command '/GOD'.",name); SendMessageToAdminEx(playerid,xstring); }
	else AdminError(playerid,10);
return 1;
}

//Function_midnight
if(strcmp(cmd,"/midnight",true)==0) {
	if(IsPlayerLevel(playerid,10)) { SetWorldTime(00); format(xstring,sizeof(xstring),"The world time has been changed to 00:00 by Admin %s.",name); SendClientMessageToAll(yellow,xstring); format(xstring,sizeof(xstring),"*** %s has used the command '/MIDNIGHT'.",name); SendMessageToAdminEx(playerid,xstring);}
	else AdminError(playerid,1);
return 1;
}

//Function_morning
if(strcmp(cmd,"/morning",true)==0) {
	if(IsPlayerLevel(playerid,10)) { SetWorldTime(07); format(xstring,sizeof(xstring),"The world time has been changed to 07:00 by Admin %s.",name); SendClientMessageToAll(yellow,xstring); format(xstring,sizeof(xstring),"*** %s has used the command '/MORNING'.",name); SendMessageToAdminEx(playerid,xstring); }
	else AdminError(playerid,1);
return 1;
}

//Function_noon
if(strcmp(cmd,"/noon",true)==0) {
	if(IsPlayerLevel(playerid,10)) { SetWorldTime(12); format(xstring,sizeof(xstring),"The world time has been changed to 12:00 by Admin %s.",name); SendClientMessageToAll(yellow,xstring); format(xstring,sizeof(xstring),"*** %s has used the command '/NOON'.",name); SendMessageToAdminEx(playerid,xstring); }
	else AdminError(playerid,1);
return 1;
}

//Function_evening
if(strcmp(cmd,"/evening",true)==0) {
	if(IsPlayerLevel(playerid,10)) { SetWorldTime(18); format(xstring,sizeof(xstring),"The world time has been changed to 18:00 by Admin %s.",name); SendClientMessageToAll(yellow,xstring); format(xstring,sizeof(xstring),"*** %s has used the command '/EVENING'.",name); SendMessageToAdminEx(playerid,xstring); }
	else AdminError(playerid,1);
return 1;
}

//Function_settime
if(strcmp(cmd,"/settime",true)==0) {
	if(IsPlayerLevel(playerid,10)) {
	new RecStr[2];
	
	strmid(RecStr,cmdtext,0,3,3);
	strmid(cmdtext,cmdtext,3,11,8);
	
		if (strval(RecStr) <= 24 && strval(RecStr) >= 0) { SetWorldTime(strval(RecStr)); Servertime = strval(RecStr); ServerMinute = strval(cmdtext); ServerSecond = 0; format(xstring,sizeof(xstring),"The world time has been changed to %d (player time %d:%d) by Admin %s.",strval(RecStr),strval(RecStr),strval(cmdtext),name); SendClientMessageToAll(yellow,xstring); }
    	else SendClientMessage(playerid,red,"Syntax: /SETTIME <00-24> <00-60>");
	} else AdminError(playerid,1);
return 1;
}

//Function_freeze
if(strcmp(cmd,"/freeze",true)==0) {
	if(IsPlayerLevel(playerid,2)) {
	
		if (!strlen(cmdtext)) { SendClientMessage(playerid,red,"Syntax: /FREEZE <NICK OR ID>"); return 1; }
		if(!IsNumeric(cmdtext)) {
			new id = MatchID(cmdtext);
			if(id != -1) format(cmdtext,strlen(cmdtext),"%d",id);
			else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
		}
		if(IsPlayerConnected(strval(cmdtext))) {
		    if(playerid != strval(cmdtext)) {
		    	if (IsPlayerLowerLevel(playerid,strval(cmdtext))) {
		    		if(Frozen[strval(cmdtext)] == 0) {
		    		format(xstring,sizeof(xstring),"*** %s has used the command '/FREEZE'.",name); SendMessageToAdminEx(playerid,xstring);
					new ref[MAX_PLAYER_NAME]; GetPlayerName(strval(cmdtext),ref,sizeof(ref));
	 					format(xstring,sizeof(xstring),"You have been frozen by Admin %s.",name); SendClientMessage(strval(cmdtext),yellow,xstring);
						format(xstring,sizeof(xstring),"You have frozen %s, and therefore will not move without cheats.",ref); SendClientMessage(playerid,yellow,xstring);
						TogglePlayerControllable(strval(cmdtext),0); Frozen[strval(cmdtext)] = 1;
					} else SendClientMessage(playerid,red,"Error: This player must NOT be frozen in order for you to execute this command.");
				} else SendClientMessage(playerid,red,"Error: You can not freeze a player with a higher level than you.");
			} else SendClientMessage(playerid,red,"Error: For security reasons, you can not freeze yourself.");
		} else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
	} else AdminError(playerid,2);
return 1;
}

//Function_freezeall
if(strcmp(cmd,"/freezeall",true)==0) {
	if(IsPlayerLevel(playerid,10)) {
		for(new i = 0; i < MAX_PLAYERS; i++) { TogglePlayerControllable(i,0); Frozen[i] = 1; }
		format(xstring,sizeof(xstring),"Everybody in the game has been frozen by Admin %s.",name); SendClientMessageToAll(yellow,xstring);
	} else AdminError(playerid,10);
return 1;
}

//Function_thawall
if(strcmp(cmd,"/thawall",true)==0) {
	if(IsPlayerLevel(playerid,10)) {
		for(new i = 0; i < MAX_PLAYERS; i++) { TogglePlayerControllable(i,1); Frozen[i] = 0; }
		format(xstring,sizeof(xstring),"All players have been unfrozen by Admin %s.",name); SendClientMessageToAll(yellow,xstring);
	} else AdminError(playerid,10);
return 1;
}

//Function_acount
if(strcmp(cmd,"/acount",true)==0) {
	if(IsPlayerLevel(playerid,10)) {
	
		if (!strlen(cmdtext) || !IsNumeric(cmdtext) || strval(cmdtext) < 5 || strval(cmdtext) > 60) { SendClientMessage(playerid,red,"Syntax: /ACOUNT <5-60>"); return 1; }
    	if(FTActive == 0) {
			for(new i = 0; i < MAX_PLAYERS; i++) TogglePlayerControllable(i,0); FreezeTimer=SetTimer("FreezeCount",1000,1); FTV = strval(cmdtext) + 1; FTActive = 1;
			format(xstring,sizeof(xstring),"Everybody in the game has been frozen by Admin %s for %d seconds.",name,strval(cmdtext)); SendClientMessageToAll(yellow,xstring);
		} else SendClientMessage(playerid,red,"Error: This timer is already active.");
	} else AdminError(playerid,10);
return 1;
}

//Function_say
if(strcmp(cmd,"/say",true)==0) {

	if(IsPlayerLevel(playerid,1)) {
		if (!strlen(cmdtext)) { SendClientMessage(playerid,red, "Syntax: /SAY <MESSAGE>"); return 1; }
		if (strlen(cmdtext) >= 2) { format(xstring,sizeof(xstring),"Admin %s: %s",player,cmdtext); SendClientMessageToAll(white,xstring); format(xstring,sizeof(xstring),"[chat] Admin %s: %s",player,cmdtext); WriteEcho(xstring); }
		else SendClientMessage(playerid,red,"Error: The length of your message is too short.");
	} else AdminError(playerid,1);
return 1;
}

//Function_akill _murder
if(strcmp(cmd,"/akill",true)==0||strcmp(cmd,"/murder",true)==0) {
	if(IsPlayerLevel(playerid,5)) {
	
		if (!strlen(cmdtext)) { SendClientMessage(playerid,red,"Syntax: /(AKILL | MURDER) <NICK OR ID>"); return 1; }
		if(!IsNumeric(cmdtext)) {
			new id = MatchID(cmdtext);
			if(id != -1) format(cmdtext,strlen(cmdtext),"%d",id);
			else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
		}
		if(IsPlayerConnected(strval(cmdtext))) {
		    if (IsPlayerLowerLevel(playerid,strval(cmdtext))) {
   				if(playerid != strval(cmdtext)) {
   					format(xstring,sizeof(xstring),"*** %s has used the command '/AKILL'.",name); SendMessageToAdminEx(playerid,xstring);
					new ref[MAX_PLAYER_NAME]; GetPlayerName(strval(cmdtext),ref,sizeof(ref));
		    		format(xstring,sizeof(xstring),"You have been automatically killed by Admin %s.",name); SendClientMessage(strval(cmdtext),yellow,xstring);
					format(xstring,sizeof(xstring),"You have automatically killed %s.",ref); SendClientMessage(playerid,yellow,xstring);
					SetPlayerHealth(strval(cmdtext),0.0);
				} else SendClientMessage(playerid,red,"Error: For security reasons, you can not admin kill yourself.");
			} else SendClientMessage(playerid,red,"Error: You can not kill a player with a higher level than you.");
		} else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
	} else AdminError(playerid,5);
return 1;
}

//Function_slap
if(strcmp(cmd,"/slap",true)==0) {
	if(IsPlayerLevel(playerid,3)) {
	
		if (!strlen(cmdtext)) { SendClientMessage(playerid,red,"Syntax: /SLAP <NICK OR ID>"); return 1; }
		if(!IsNumeric(cmdtext)) {
			new id = MatchID(cmdtext);
			if(id != -1) format(cmdtext,strlen(cmdtext),"%d",id);
			else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
		}
		if(IsPlayerConnected(strval(cmdtext))) {
		    if (IsPlayerLowerLevel(playerid,strval(cmdtext))) {
   				if(playerid != strval(cmdtext)) {
   				    format(xstring,sizeof(xstring),"*** %s has used the command '/SLAP'.",name); SendMessageToAdminEx(playerid,xstring);
					new ref[MAX_PLAYER_NAME]; GetPlayerName(strval(cmdtext),ref,sizeof(ref));
		    		format(xstring,sizeof(xstring),"You have been slapped by Admin %s. (-20 HP)",name); SendClientMessage(strval(cmdtext),yellow,xstring);
					format(xstring,sizeof(xstring),"You have slapped player %s. (-20 HP)",ref); SendClientMessage(playerid,yellow,xstring);
					GetPlayerHealth(strval(cmdtext),HP); SetPlayerHealth(strval(cmdtext),HP-20.0);
				} else SendClientMessage(playerid,red,"Error: For security reasons, you can not slap yourself.");
			} else SendClientMessage(playerid,red,"Error: You can not slap a player with a higher level than you.");
		} else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
	} else AdminError(playerid,2);
return 1;
}

//Function_eject
if(strcmp(cmd,"/eject",true)==0) {
	if(IsPlayerLevel(playerid,3)) {
	
		if (!strlen(cmdtext)) { SendClientMessage(playerid,red,"Syntax: /EJECT <NICK OR ID>"); return 1; }
		if(!IsNumeric(cmdtext)) {
			new id = MatchID(cmdtext);
			if(id != -1) format(cmdtext,strlen(cmdtext),"%d",id);
			else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
		}
		if(IsPlayerConnected(strval(cmdtext))) {
		    if (IsPlayerLowerLevel(playerid,strval(cmdtext))) {
   				if(playerid != strval(cmdtext)) {
					new ref[MAX_PLAYER_NAME]; GetPlayerName(strval(cmdtext),ref,sizeof(ref));
			 		if (IsPlayerInAnyVehicle(strval(cmdtext))) {
			 		    format(xstring,sizeof(xstring),"*** %s has used the command '/EJECT'.",name); SendMessageToAdminEx(playerid,xstring);
					 	format(xstring,sizeof(xstring),"You have ejected %s from their vehicle.",ref); SendClientMessage(playerid,yellow,xstring);
						format(xstring,sizeof(xstring),"You have been ejected from your vehicle by Admin %s.",name); SendClientMessage(strval(cmdtext),yellow,xstring);
						RemovePlayerFromVehicle(strval(cmdtext));
				    }
					else SendClientMessage(playerid,red,"Error: This player must be in a vehicle in order for you to eject them.");
 				} else SendClientMessage(playerid,red,"Error: For security reasons, you can not eject yourself.");
			} else SendClientMessage(playerid,red,"Error: You can not eject a player with a higher level than you.");
		} else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
	} else AdminError(playerid,5);
return 1;
}

//Function_flip
if(strcmp(cmd,"/flip",true)==0) {
	if(IsPlayerLevel(playerid,1)) {
	new Float:X,Float:Y,Float:Z,Float:Angle;
 		if (IsPlayerInAnyVehicle(playerid)) { GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle); SetVehiclePos(GetPlayerVehicleID(playerid),X,Y,Z + 1); SetVehicleZAngle(GetPlayerVehicleID(playerid),Angle); SendClientMessage(playerid,yellow,"You have successfully flipped your vehicle."); format(xstring,sizeof(xstring),"*** %s has used the command '/FLIP'.",name); SendMessageToAdminEx(playerid,xstring); }
		else SendClientMessage(playerid,red,"Error: You must be in a vehicle.");
	} else AdminError(playerid,1);
return 1;
}

//Function_resetcash
if(strcmp(cmd,"/resetcash",true)==0) {
	if(IsPlayerLevel(playerid,10)) {
	
		if(!IsNumeric(cmdtext)) {
			new id = MatchID(cmdtext);
			if(id != -1) format(cmdtext,strlen(cmdtext),"%d",id);
			else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
		}
		if(IsPlayerConnected(strval(cmdtext))) {
		    if (IsPlayerLowerLevel(playerid,strval(cmdtext))) {
		    format(xstring,sizeof(xstring),"*** %s has used the command '/RESETCASH'.",name); SendMessageToAdminEx(playerid,xstring);
				if(playerid != strval(cmdtext)) {
					new ref[MAX_PLAYER_NAME]; GetPlayerName(strval(cmdtext),ref,sizeof(ref));
					format(xstring,sizeof(xstring),"Your cash has been reset by Admin %s.",name); SendClientMessage(strval(cmdtext),yellow,xstring);
					format(xstring,sizeof(xstring),"You have resetted %s's cash.",ref); SendClientMessage(playerid,yellow,xstring);
				}
				else SendClientMessage(strval(cmdtext),yellow,"You have reset your own cash.");
				ResetPlayerMoney(strval(cmdtext));
			} else SendClientMessage(playerid,red,"Error: You can not reset the cash of a player with a higher level than you.");
		} else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
	} else AdminError(playerid,10);
return 1;
}

//Function_resetstat
if(strcmp(cmd,"/resetstat",true)==0) {
	if(IsPlayerLevel(playerid,10)) {
	
		if (!strlen(cmdtext)) { SendClientMessage(playerid,yellow,"You have reset your statistics."); dini_IntSet(PF,"kills",0); dini_IntSet(PF,"deaths",0); format(xstring,sizeof(xstring),"*** %s has used the command '/RESETSTAT'.",name); SendMessageToAdminEx(playerid,xstring); return 1; }
		if(!IsNumeric(cmdtext)) {
			new id = MatchID(cmdtext);
			if(id != -1) format(cmdtext,strlen(cmdtext),"%d",id);
			else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
		}
		if(IsPlayerConnected(strval(cmdtext))) {
		    if (IsPlayerLowerLevel(playerid,strval(cmdtext))) {
			new ref[MAX_PLAYER_NAME]; GetPlayerName(strval(cmdtext),ref,sizeof(ref));
			new reffile[256]; format(reffile,sizeof(reffile),"/xadmin/%s.ini",udb_encode(ref));
			format(xstring,sizeof(xstring),"*** %s has used the command '/RESETSTAT'.",name); SendMessageToAdminEx(playerid,xstring);
		    	if(playerid != strval(cmdtext)) {
		    		format(xstring,sizeof(xstring),"Your statistics have been reset by Admin %s.",name); SendClientMessage(strval(cmdtext),yellow,xstring);
					format(xstring,sizeof(xstring),"You have reset %s's statistics.",ref); SendClientMessage(playerid,yellow,xstring);
				}
				else SendClientMessage(playerid,yellow,"You have reset your statistics.");
				dini_IntSet(reffile,"kills",0); dini_IntSet(reffile,"deaths",0); Kills[strval(cmdtext)] = 0; Deaths[strval(cmdtext)] = 0;
			} else SendClientMessage(playerid,red,"Error: You can not reset the statistics of a player with a higher level than you.");
		} else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
	} else AdminError(playerid,10);
return 1;
}

//Function_resetscores
if(strcmp(cmd,"/resetscores",true)==0) {
	if(IsPlayerLevel(playerid,10)) {
		for(new i = 0; i < MAX_PLAYERS; i++) SetPlayerScore(i,0);
		format(xstring,sizeof(xstring),"The server's scores have been reset by Admin %s.",name); SendClientMessageToAll(yellow,xstring);
	} else AdminError(playerid,10);
return 1;
}

//Function_setmotd
if(strcmp(cmd,"/setmotd",true)==0) {
	if(IsPlayerLevel(playerid,3)) {
		if ((strlen(cmdtext) == 7)||(strlen(cmdtext) == 8)) { SendClientMessage(playerid,red, "Syntax: /SETMOTD <TEXT>"); return 1; }
		if (strlen(cmdtext[9]) >= 5) { format(xstring,sizeof(xstring),"MOTD Changed: %s || By: %s",cmdtext[9],name); SendMessageToAdmins(xstring); dini_Set("xadmin/config/utilities.ini","Memo",cmdtext[9]); dini_Set("xadmin/config/utilities.ini","MemoSender",name); }
		else SendClientMessage(playerid,red,"Error: The length of your message is too short. Please try again.");
	} else AdminError(playerid,1);
return 1;
}

//Function_motd
if(strcmp(cmd,"/motd",true)==0) {
	if(Level[playerid] >= 1 && LoggedIn[playerid] == 1) { format(xstring,sizeof(xstring),"MOTD: %s",dini_Get("/xadmin/config/utilities.ini","Memo")); SendClientMessage(playerid,white,xstring); }
	else AdminError(playerid,1);
return 1;
}

//Function_thaw
if(strcmp(cmd,"/thaw",true)==0) {
	if(IsPlayerLevel(playerid,2)) {

		if (!strlen(cmdtext)) { SendClientMessage(playerid,red,"Syntax: /THAW <NICK OR ID>"); return 1; }
		if(!IsNumeric(cmdtext)) {
			new id = MatchID(cmdtext);
			if(id != -1) format(cmdtext,strlen(cmdtext),"%d",id);
			else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
		}
		if(IsPlayerConnected(strval(cmdtext))) {
			if(playerid != strval(cmdtext)) {
			    if(Frozen[strval(cmdtext)] == 1) {
			    format(xstring,sizeof(xstring),"*** %s has used the command '/UNFREEZE'.",name); SendMessageToAdminEx(playerid,xstring);
				new ref[MAX_PLAYER_NAME]; GetPlayerName(strval(cmdtext),ref,sizeof(ref));
	 				format(xstring,sizeof(xstring),"You have been kindly unfrozen by Admin %s.",name); SendClientMessage(strval(cmdtext),yellow,xstring);
					format(xstring,sizeof(xstring),"You have unfrozen %s, which will enable them to move freely.",ref); SendClientMessage(playerid,yellow,xstring);
					TogglePlayerControllable(strval(cmdtext),1); Frozen[strval(cmdtext)] = 0;
				} else SendClientMessage(playerid,red,"Error: This player must be frozen in order for you to execute this command.");
			} else SendClientMessage(playerid,red,"Error: For security reasons, you can not unfreeze yourself.");
		} else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
	} else AdminError(playerid,2);
return 1;
}

//Function_setsm
if(strcmp(cmd,"/setsm",true)==0) {
 	if(IsPlayerLevel(playerid,10)) {
		if ((strlen(cmdtext) == 5)||(strlen(cmdtext) == 6)) { SendClientMessage(playerid,red, "Syntax: /SETSM <TEXT>"); return 1; }
		if ((strlen(cmdtext[7]) >= 5) && (strlen(cmdtext[7]) <= 100)) { format(xstring,sizeof(xstring),"Server Message Changed: %s || By: %s",cmdtext[7],name); SendMessageToAdmins(xstring); dini_Set("xadmin/config/utilities.ini","SM",cmdtext[7]); }
		else SendClientMessage(playerid,red,"Error: The length of your message is too short. Please try again.");
	} else AdminError(playerid,1);
return 1;
}

//Function_sm
if(strcmp(cmd,"/sm",true)==0) {
	if(IsPlayerLevel(playerid,1)) { format(xstring,sizeof(xstring),"Server Message: %s",dini_Get("/xadmin/config/utilities.ini","SM")); SendClientMessage(playerid,green,xstring); }
	else AdminError(playerid,1);
return 1;
}

//Function_xcommands
if(strcmp(cmd,"/xcommands",true)==0) {
	if(IsPlayerLevel(playerid,1)) {
	    switch(Level[playerid]) {
	        case 1: SendClientMessage(playerid,yellow,"Admin Level 1 Commands: //,announce,cl,flip,(goto|telto),motd,say,serverinfo,sm, kick");
	        case 2: {
				SendClientMessage(playerid,yellow,"Admin Level 2 Commands: //,announce,cl,flip,(goto|telto),motd,say,serverinfo,sm,slap,(unwire|thaw)");
				SendClientMessage(playerid,yellow,"(wire|freeze),kick, ban");
			}
			case 3,4: {
				SendClientMessage(playerid,yellow,"Admin Level 3/4 Commands: //,announce,cl,flip,(goto|telto),motd,say,serverinfo,setmotd,setsm,sm,slap,thaw");
				SendClientMessage(playerid,yellow,"freeze,kick, ban");
				}
	        case 5: {
				SendClientMessage(playerid,yellow,"Admin Level 5 Commands: //,announce,cl,flip,(goto|telto),motd,say,serverinfo,setmotd,setsm,sm,slap,thaw");
				SendClientMessage(playerid,yellow,"freeze,kick, ban,(akill|murder),eject");
			}
			case 6: {
				SendClientMessage(playerid,yellow,"Admin Level 6 Commands: //,announce,cl,flip,(goto|telto),motd,say,serverinfo,setmotd,setsm,sm,slap,thaw");
				SendClientMessage(playerid,yellow,"freeze,kick, ban,(akill|murder),eject,healall,outside");
			}
			case 7: {
				SendClientMessage(playerid,yellow,"Admin Level 7 Commands: //,announce,cl,flip,(goto|telto),motd,say,serverinfo,setmotd,setsm,sm,slap,thaw");
				SendClientMessage(playerid,yellow,"freeze,kick,(akill|murder),eject,healall,outside,ban,namekick");
			}
			case 8: {
				SendClientMessage(playerid,yellow,"Admin Level 8 Commands: //,announce,cl,flip,(goto|telto),motd,say,serverinfo,setmotd,setsm,sm,slap,thaw");
				SendClientMessage(playerid,yellow,"freeze,kick,(akill|murder),eject,healall,outsideban,namekick,resetweapons");
			}
			case 9: {
				SendClientMessage(playerid,yellow,"Admin Level 9 Commands: //,announce,cl,flip,(goto|telto),motd,say,serverinfo,setmotd,setsm,sm,slap,thaw");
				SendClientMessage(playerid,yellow,"freeze,kick,(akill|murder),eject,healall,outside,ban,namekick,resetweapons,nameban");
			}
			case 10: {
				SendClientMessage(playerid,yellow,"Admin Level 10 Commands: //,announce,cl,evening,flip,(goto|telto),midnight,morning,motd,noon,say,serverinfo,setmotd,setsm,settime,sm,slap,thaw");
				SendClientMessage(playerid,yellow,"freeze,kick,(akill|murder),eject,healall,outside,ban,namekick,resetweapons,nameban,acount,ejectall,freezeall,(gethere|telid),god");
				SendClientMessage(playerid,yellow,"resetallcash,resetallweapons,resetscores,resetstat,thawall");
			}
		}
 	} else AdminError(playerid,1);
return 1;
}

//Function_healall
if(strcmp(cmd,"/healall",true)==0) {
	if(IsPlayerLevel(playerid,6)) {
  		format(xstring,sizeof(xstring),"Everyone has been healed by Admin %s.",name); SendClientMessageToAll(yellow,xstring);
		for(new i = 0; i < MAX_PLAYERS; i++) { if(IsPlayerConnected(i)) SetPlayerHealth(i,100.0); }
	} else AdminError(playerid,6);
return 1;
}

//Function_outside
if(strcmp(cmd,"/outside",true)==0) {
	if(Level[playerid] >= 6 && LoggedIn[playerid] == 1) {
  		SendClientMessageToAll(yellow,"Everyone has been transfered outside.");
		for(new i = 0; i < MAX_PLAYERS; i++) { if(IsPlayerConnected(i)) SetPlayerInterior(i,0); }
	} else AdminError(playerid,6);
return 1;
}

//Function_announce
if(strcmp(cmd,"/announce",true)==0) {
	if(IsPlayerLevel(playerid,1)) {
		if (!strlen(cmdtext)) { SendClientMessage(playerid,red, "Syntax: /ANNOUNCE <TEXT>"); return 1; }
		if ((strlen(cmdtext) >= 2) && (strlen(cmdtext) <= 50)) { format(xstring,sizeof(xstring),"~w~%s",cmdtext); GameTextForAll(xstring,5000,3); format(xstring,sizeof(xstring),"*** %s has used the command '/ANNOUNCE'.",name); SendMessageToAdminEx(playerid,xstring);}
		else SendClientMessage(playerid,red,"Error: The length of your message must be between 2 and 50!");
	} else AdminError(playerid,1);
return 1;
}

//Function_cl
if(strcmp(cmd,"/cl",true)==0) {
	if(IsPlayerLevel(playerid,1)) {
		SendClientMessageToAll(red," "); SendClientMessageToAll(red," "); SendClientMessageToAll(red," "); SendClientMessageToAll(red," ");
		SendClientMessageToAll(red,"---- Chat cleared by Admin/Moderator ----"); SendClientMessageToAll(red," "); SendClientMessageToAll(red," "); SendClientMessageToAll(red," ");
		SendClientMessageToAll(red," "); SendClientMessageToAll(red," ");
		} else AdminError(playerid,1);
return 1;
}

//Function_namekick
if(strcmp(cmd,"/namekick",true)==0) {
 	if(IsPlayerLevel(playerid,4)) {
	    if(strlen(cmdtext) >= 3 && strlen(cmdtext) <= 24) {
	    	for(new i = 0;i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && IfPlayerHasTag(i,cmdtext) && playerid != i) Kick(i);
	    	format(xstring,sizeof(xstring),"All players with \"%s\" in their name have been kicked.",cmdtext); SendClientMessageToAll(yellow,xstring);
	   } else SendClientMessage(playerid,red,"Error: The name you are searching for must be between 3 and 24 characters in length.");
	} else AdminError(playerid,7);
return 1;
}

//Function_nameban
if(strcmp(cmd,"/nameban",true)==0) {
	if(IsPlayerLevel(playerid,4)) {
	    
	    if(strlen(cmdtext) >= 3 && strlen(cmdtext) <= 24) {
	    	for(new i = 0;i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && IfPlayerHasTag(i,cmdtext) && playerid != i) Ban(i);
	    	format(xstring,sizeof(xstring),"All players with \"%s\" in their name have been banned.",cmdtext); SendClientMessageToAll(yellow,xstring);
	   } else SendClientMessage(playerid,red,"Error: The name you are searching for must be between 3 and 24 characters in length.");
	} else AdminError(playerid,7);
return 1;
}

//Function_ejectall
if(strcmp(cmd,"/ejectall",true)==0) {
	if(IsPlayerLevel(playerid,10)) {
	    for(new i = 0; i < MAX_PLAYERS; i++) { if(playerid != i && IsPlayerConnected(i) && IsPlayerInAnyVehicle(i)) RemovePlayerFromVehicle(i); }
	    format(xstring,sizeof(xstring),"Everybody in a vehicle has been ejected by Admin %s.",name); SendClientMessageToAll(yellow,xstring);
	} else AdminError(playerid,10);
return 1;
}

//Function_resetallcash
if(strcmp(cmd,"/resetallcash",true)==0) {
	if(IsPlayerLevel(playerid,10)) { for(new i = 0; i < MAX_PLAYERS; i++) ResetPlayerMoney(i); format(xstring,sizeof(xstring),"Everyone's money has been reset by Admin %s.",name); SendClientMessageToAll(yellow,xstring); }
	else AdminError(playerid,10);
return 1;
}

//Function_resetweapons
if(strcmp(cmd,"/resetweapons",true)==0) {
	if(IsPlayerLevel(playerid,8)) {

		if(!IsNumeric(cmdtext)) {
			new id = MatchID(cmdtext);
			if(id != -1) format(cmdtext,strlen(cmdtext),"%d",id);
			else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
		}
		if(IsPlayerConnected(strval(cmdtext))) {
		    if (IsPlayerLowerLevel(playerid,strval(cmdtext))) {
		    format(xstring,sizeof(xstring),"*** %s has used the command '/RESETWEAPONS'.",name); SendMessageToAdminEx(playerid,xstring);
				if(playerid != strval(cmdtext)) {
					new ref[MAX_PLAYER_NAME]; GetPlayerName(strval(cmdtext),ref,sizeof(ref));
					format(xstring,sizeof(xstring),"Your weapons have been reset by Admin %s.",name); SendClientMessage(strval(cmdtext),yellow,xstring);
					format(xstring,sizeof(xstring),"You have resetted %s's weapons.",ref); SendClientMessage(playerid,yellow,xstring);
					ResetPlayerWeapons(strval(cmdtext));
				} else SendClientMessage(playerid,red,"Error: For security reasons you can not reset your own weapons.");
			} else SendClientMessage(playerid,red,"Error: You can not reset the weapons of a player with a higher level than you.");
		} else SendClientMessage(playerid,red,"Error: Invalid name or ID.");
	} else AdminError(playerid,8);
return 1;
}

//Function_resetallweapons
if(strcmp(cmd,"/resetallweapons",true)==0) {
	if(IsPlayerLevel(playerid,10)) { for(new i = 0; i < MAX_PLAYERS; i++) ResetPlayerWeapons(i); format(xstring,sizeof(xstring),"Everyone's weapons have been reset by Admin %s.",name); SendClientMessageToAll(yellow,xstring); }
	else AdminError(playerid,10);
return 1;
}

if(strcmp(cmd,"//",true)==0) {
	if(IsPlayerLevel(playerid,1)) {
	if ((strlen(cmdtext) >= 1)&&(strlen(cmdtext) <= 3)) { SendClientMessage(playerid,red, "Syntax: // <MESSAGE>"); return 1; }
		format(xstring,sizeof(xstring),"(%s) %s",name,cmdtext[3]); SendMessageToAdmins(xstring);
	} else AdminError(playerid,1);
return 1;
}
// END OF XADMIN

//Function_L
if(strcmp(cmd,"/L",true)==0)
	{
	new string[120];
	GetPlayerName(playerid,player,24);
	if(!strlen(cmdtext))
	{
	    SendClientMessage(playerid,COLOR_GREY,"Usage: /L [text]");
		return 1;
	}
	if (pInfo[playerid][Jailed]){
	SetPlayerInterior(playerid,3);
	SetPlayerPos(playerid,198.5,162.5,1003.0);
	PlayerPlaySound(playerid,1069,198.5,162.5,1003.0);
	PlayerPlaySound(playerid,1068,198.5,162.5,1003.0);
	SendClientMessage(playerid,COLOR_RED,"You are not allowed to chat local while jailed!");
	return 1;
	}
    format(string,sizeof(string),"(Local) %s: %s",player,cmdtext[0]);
	for(new l=0; l<MAX_PLAYERS; l++){
		if(IsPlayerConnected(l)){
			if(GetDistanceBetweenPlayers(playerid,l) <= 30 && l!=playerid){
 		    SendClientMessage(l,COLOR_DARKGREEN,string);
		    SendClientMessage(playerid,COLOR_DARKGREEN,string);
	    	}
   		}
	}
	return 1;
	}

//Function_A
if(strcmp(cmd,"/A",true)==0)
	{
	new string[120],tmp1[255],adn[24];
	if(!strlen(cmdtext))
	{
	    SendClientMessage(playerid,COLOR_GREY,"Usage: /A [text]");
		return 1;
	}
	format(string,sizeof(string),"(Report) %s",cmdtext[0]);
	print (string);

	for(new ad=0; ad<MAX_PLAYERS; ad++){
	GetPlayerName(ad,adn,sizeof(adn));
	tmp1 = dini_Get(udb_encode(adn),"Level");
		if(strval(tmp1)>=2){
 	    SendClientMessage(ad,COLOR_DARKGREEN,string);
		}
	}
	SendClientMessage(playerid,BBLUE,"Your report has been logged and sent to all online admins anonymously.");
	return 1;
	}

//Function_actions
if(strcmp(cmd, "/actions", true) == 0) {
		SendClientMessage(playerid,COLOR_YELLOW,"Pure RPG actions (sponsored by kyeman)");
		SendClientMessage(playerid,COLOR_WHITE,"/drunk | /wave | /gift  | /lap | /bitchslap  | /seat");
		SendClientMessage(playerid,COLOR_WHITE,"/balls | /knife | /pedal | /plunger | /ghand | /celebrate");
		SendClientMessage(playerid,COLOR_WHITE,"/chat | /rope | /fucku | /drown | /bomb | /wall");
		SendClientMessage(playerid,COLOR_WHITE,"/laugh | /skate | /sunbath | /sword | /cpr | /dance [1-4]");
		SendClientMessage(playerid,COLOR_RED,"Thanks to 'kyeman' for additional actions");
   		return 1;

	}

//Function_ooc
if(strcmp(cmd,"/ooc",true)==0)
{
	new string[120];
	GetPlayerName(playerid,player,24);

    format(string,sizeof(string),"[server] %s is now out of character ( = NOT role playing) and talking as player",player);
	WriteEcho(string);
	pInfo[playerid][OOC] = 1;
    SetPlayerColor(playerid,COLOR_GREY);
    SendClientMessageToAll(COLOR_YELLOW,string);
	return 1;
}

//Function_rpg
if(strcmp(cmd,"/rpg",true)==0)
{
	new string[120];
	GetPlayerName(playerid,player,24);

    format(string,sizeof(string),"[server] %s is now in game ( = role playing) and talking as his character",player);
	WriteEcho(string);
	pInfo[playerid][OOC] = 0;
    SetPlayerToTeamColor(playerid);
    SendClientMessageToAll(COLOR_YELLOW,string);
	return 1;
}

//Function_R
if(strcmp(cmd,"/R",true)==0)
{
	new string[120],ran[24];
	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"Usage: /R[adio chat] [text]");
		return 1;
	}
	GetPlayerName(playerid,ran,sizeof(ran));

	switch (gTeam[playerid]){
		case TEAM_CIVS: {
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_SENIORS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_WAITERS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_CRIMINALS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_SECURITIES:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_PILOTS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_ENTERTAINERS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_MEDICS:{
		format(string,sizeof(string),"(Radio) Medic %s: %s,over",ran,cmdtext[0]);
			for(new ra=0; ra<MAX_PLAYERS; ra++){
				if(gTeam[ra]==TEAM_MEDICS || gTeam[ra]==TEAM_FIREMEN || gTeam[ra]==TEAM_COPS){
				SendClientMessage(ra,COLOR_WHITE,string);
				}
				if (pInfo[ra][Admin]){
				SendClientMessage(ra,COLOR_PINK,string);
				}
			}
		return 1;
		}
		case TEAM_FIREMEN:{
		format(string,sizeof(string),"(Radio) Fireguard %s: %s,over",ran,cmdtext[0]);
			for(new ra=0; ra<MAX_PLAYERS; ra++){
				if(gTeam[ra]==TEAM_MEDICS || gTeam[ra]==TEAM_FIREMEN || gTeam[ra]==TEAM_COPS){
				SendClientMessage(ra,COLOR_WHITE,string);
				}
				if (pInfo[ra][Admin]){
				SendClientMessage(ra,COLOR_PINK,string);
				}
			}
		return 1;
		}
		case TEAM_COPS:{
		format(string,sizeof(string),"(Radio) Officer %s: %s,over",ran,cmdtext[0]);
			for(new ra=0; ra<MAX_PLAYERS; ra++){
				if(gTeam[ra]==TEAM_MEDICS || gTeam[ra]==TEAM_FIREMEN || gTeam[ra]==TEAM_COPS){
				SendClientMessage(ra,COLOR_WHITE,string);
				}
				if (pInfo[ra][Admin]){
				SendClientMessage(ra,COLOR_PINK,string);
				}
			}
		return 1;
		}
	}
	return 0;
	}

//Function_backup
if(strcmp(cmd,"/backup",true)==0)
{
#pragma unused cmdtext
	new string[120],ran[24];
	new Float:posX;
	new Float:posY;
	new Float:posZ;

	GetPlayerName(playerid,ran,sizeof(ran));
	GetPlayerPos(playerid,posX,posY,posZ);

	switch (gTeam[playerid]){
		case TEAM_CIVS: {
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_SENIORS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_WAITERS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_CRIMINALS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_SECURITIES:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_PILOTS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_ENTERTAINERS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_MEDICS:{
		format(string,sizeof(string),"(Radio) Medic %s: Backup! Backup! Need urgent help!,over",ran);
			for(new ra=0; ra<MAX_PLAYERS; ra++){
				if(gTeam[ra]==TEAM_MEDICS || gTeam[ra]==TEAM_FIREMEN || gTeam[ra]==TEAM_COPS){
				SendClientMessage(ra,COLOR_WHITE,string);
				SetPlayerCheckpoint(ra,posX,posY,posZ,5);
				SendClientMessage(ra,COLOR_YELLOW,"Help your collegue by going rapidly to the red checkpoint on your radar.");
				}
				if (pInfo[ra][Admin]){
				SendClientMessage(ra,COLOR_PINK,string);
				}
			}
		return 1;
		}
		case TEAM_FIREMEN:{
		format(string,sizeof(string),"(Radio) Fireguard %s: Backup! Backup! Need urgent help!,over",ran);
			for(new ra=0; ra<MAX_PLAYERS; ra++){
				if(gTeam[ra]==TEAM_MEDICS || gTeam[ra]==TEAM_FIREMEN || gTeam[ra]==TEAM_COPS){
				SendClientMessage(ra,COLOR_WHITE,string);
				SetPlayerCheckpoint(ra,posX,posY,posZ,5);
				SendClientMessage(ra,COLOR_YELLOW,"Help your collegue by going rapidly to the red checkpoint on your radar.");
				}
				if (pInfo[ra][Admin]){
				SendClientMessage(ra,COLOR_PINK,string);
				}
			}
		return 1;
		}
		case TEAM_COPS:{
		format(string,sizeof(string),"(Radio) Officer %s: Backup! Backup! Need urgent help!,over",ran);
			for(new ra=0; ra<MAX_PLAYERS; ra++){
				if(gTeam[ra]==TEAM_MEDICS || gTeam[ra]==TEAM_FIREMEN || gTeam[ra]==TEAM_COPS){
				SendClientMessage(ra,COLOR_WHITE,string);
				SetPlayerCheckpoint(ra,posX,posY,posZ,5);
				SendClientMessage(ra,COLOR_YELLOW,"Help your collegue by going rapidly to the red checkpoint on your radar.");
				}
				if (pInfo[ra][Admin]){
				SendClientMessage(ra,COLOR_PINK,string);
				}
			}
		return 1;
		}
	}
	return 0;
	}

//Function_ATC
if(strcmp(cmd,"/ATC",true)==0)
{
	new string[120],ran[24];
	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"Usage: /ATC [text]");
		return 1;
	}
	GetPlayerName(playerid,ran,sizeof(ran));

	switch (gTeam[playerid]){
		case TEAM_CIVS: {
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the pilot role to use the Air Traffic Control radio frequecies.");
		return 0;
		}
		case TEAM_SENIORS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the pilot role to use the Air Traffic Control radio frequecies.");
		return 0;
		}
		case TEAM_WAITERS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the pilot role to use the Air Traffic Control radio frequecies.");
		return 0;
		}
		case TEAM_CRIMINALS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the pilot role to use the Air Traffic Control radio frequecies.");
		return 0;
		}
		case TEAM_SECURITIES:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the pilot role to use the Air Traffic Control radio frequecies.");
		return 0;
		}
		case TEAM_PILOTS:{
		format(string,sizeof(string),"(ATC Radio) Captain %s: %s,over",ran,cmdtext[0]);
			for(new ra=0; ra<MAX_PLAYERS; ra++){
				if(gTeam[ra]==TEAM_PILOTS){
				SendClientMessage(ra,COLOR_WHITE,string);
				}
				if (pInfo[ra][Admin]){
				SendClientMessage(ra,COLOR_PINK,string);
				}
			}
		return 1;
		}
		case TEAM_ENTERTAINERS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the pilot role to use the Air Traffic Control radio frequecies.");
		return 0;
		}
		case TEAM_MEDICS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "You cant reach the ATC frequency because of a frequency limit.");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the pilot role to use the Air Traffic Control radio frequecies.");
		return 0;
		}
		case TEAM_FIREMEN:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "You cant reach the ATC frequency because of a frequency limit.");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the pilot role to use the Air Traffic Control radio frequecies.");
		return 0;
		}
		case TEAM_COPS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "You cant reach the ATC frequency because of a frequency limit.");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the pilot role to use the Air Traffic Control radio frequecies.");
		return 0;
		}
	}
return 0;
}

//Function_me
if(strcmp(cmd,"/me",true)==0)
{
	new string[120];
	GetPlayerName(playerid,player,24);
	if(!strlen(cmdtext))
	{
	    SendClientMessage(playerid,COLOR_GREY,"Usage: /me [action]");
		return 1;
	}
    format(string,sizeof(string),"%s %s",player,cmdtext[0]);
	for(new i=0; i<MAX_PLAYERS; i++) if(IsPlayerConnected(i)) if(GetDistanceBetweenPlayers(playerid,i) <= 30 && i!=playerid)
	{
	    SendClientMessage(i,BBLUE,string);
	    SendClientMessage(playerid,BBLUE,string);
	    return 1;
	}
	return 1;
}

//Function_register
if(strcmp(cmd,"/register",true)==0)
{
	new str[86];
	GetPlayerName(playerid,player,24);
	if(!strlen(cmdtext))
	{
	    SendClientMessage(playerid,COLOR_GREY,"Usage: /register [password]");
		return 1;
	}
	if(dini_Exists(udb_encode(player)))
	{
	    SendClientMessage(playerid,COLOR_BRIGHTRED,"This nickname has been already registered.");
		return 1;
	}
	dini_Create(udb_encode(player));
	dini_Set(udb_encode(player),"Password",cmdtext);
	dini_IntSet(udb_encode(player),"Pocket",GetPlayerMoney(playerid));
	if(IsPlayerAdmin(playerid)){
		dini_IntSet(udb_encode(player),"Bank",500);
		dini_IntSet(udb_encode(player),"Drugs",0);
		dini_IntSet(udb_encode(player),"Level",5);
		dini_IntSet(udb_encode(player),"Banned",0);
		dini_IntSet(udb_encode(player),"Vehicle",0);
		dini_IntSet(udb_encode(player),"Skin",1);
		dini_IntSet(udb_encode(player),"House",0);
		dini_IntSet(udb_encode(player),"SpawnX",0);
		dini_IntSet(udb_encode(player),"SpawnY",0);
		dini_IntSet(udb_encode(player),"SpawnZ",0);
		dini_IntSet(udb_encode(player),"SpawnA",0);
		dini_IntSet(udb_encode(player),"Cop",0);
		dini_IntSet(udb_encode(player),"Lawyer",0);
  	}
	else {
		dini_IntSet(udb_encode(player),"Bank",500);
		dini_IntSet(udb_encode(player),"Drugs",0);
		dini_IntSet(udb_encode(player),"Level",1);
		dini_IntSet(udb_encode(player),"Banned",0);
		dini_IntSet(udb_encode(player),"Vehicle",0);
 		dini_IntSet(udb_encode(player),"Skin",1);
 		dini_IntSet(udb_encode(player),"House",0);
		dini_IntSet(udb_encode(player),"SpawnX",0);
		dini_IntSet(udb_encode(player),"SpawnY",0);
		dini_IntSet(udb_encode(player),"SpawnZ",0);
		dini_IntSet(udb_encode(player),"SpawnA",0);
		dini_IntSet(udb_encode(player),"Cop",0);
		dini_IntSet(udb_encode(player),"Lawyer",0);
  	}
	pInfo[playerid][Logged] = 1;
	GivePlayerMoney(playerid,-GetPlayerMoney(playerid));
	GivePlayerMoney(playerid,5000);
	format(str,sizeof(str),"Statistics [Pocket: $%d Password: %s]",GetPlayerMoney(playerid),cmdtext);
	SendClientMessage(playerid,COLOR_GREEN,"Successfully Registered. You are now logged in.");
	SendClientMessage(playerid,COLOR_GREEN,"The server grants you 5000$ as a start. Use it wisely!");
	SendClientMessage(playerid,COLOR_GREEN,str);
	pInfo[playerid][Logged] = 1;
	SpawnPlayer(playerid);
	pInfo[playerid][Spawned] = 1;
	return 1;
}

//Function_login
if(strcmp(cmd,"/login",true)==0)
{
	new str[86],tmp1[255],tmp2[255],tmp3[255],jobcheck;

	GetPlayerName(playerid,player,24);
	if(!strlen(cmdtext))
	{
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /login [password]");
		return 1;
	}
	if(!dini_Exists(udb_encode(player)))
	{
	    SendClientMessage(playerid,COLOR_BRIGHTRED,"Nickname doesn't exist, you can register using /register [password].");
		return 1;
	}
	if(pInfo[playerid][Logged])
	{
	    SendClientMessage(playerid,COLOR_BRIGHTRED,"You are already logged in.");
		return 1;
	}
	tmp1 = dini_Get(udb_encode(player),"Password");
//	print (cmdtext); //This was just for debug reasons since Weed's password control
// 	print (tmp1);//did not even properly work -_-

	if(strcmp(cmdtext,tmp1,true,strlen(tmp1)))
	{
	    SendClientMessage(playerid,COLOR_BRIGHTRED,"Invalid Password.");
		new pwmsg[120];
		format(pwmsg,sizeof(pwmsg),"ID %d entered a wrong password",playerid);
	    print (pwmsg);
		return 1;
	}
	tmp1 = dini_Get(udb_encode(player),"Pocket");
	tmp2 = dini_Get(udb_encode(player),"Vehicle");
	tmp3 = dini_Get(udb_encode(player),"Drugs");
 	GivePlayerMoney(playerid,-GetPlayerMoney(playerid));
	GivePlayerMoney(playerid,strval(tmp1));

	pInfo[playerid][DrugsAmount] = strval(tmp3);
    pInfo[playerid][vehicle] = strval(tmp2);

switch (strval(tmp2)){
case 0: format(tmp2,sizeof(tmp2),"None");
//LS public Cars
case 1: format(tmp2,sizeof(tmp2),"Ambulance (Location: All Saints General Hospital)");
case 2: format(tmp2,sizeof(tmp2),"Ambulance (Location: All Saints General Hospital)");
case 3: format(tmp2,sizeof(tmp2),"Police Car (Location: in front of LSPD)");
case 4: format(tmp2,sizeof(tmp2),"Police Car (Location: LSPD Garage)");
case 5: format(tmp2,sizeof(tmp2),"Police Car (Location: LSPD Garage)");
case 6: format(tmp2,sizeof(tmp2),"Police Car (Location: LSPD Garage)");
case 7: format(tmp2,sizeof(tmp2),"Taxi (Location: LSAP Terminal)");
case 8: format(tmp2,sizeof(tmp2),"Taxi (Location: LSAP Terminal)");
case 9: format(tmp2,sizeof(tmp2),"Taxi (Location: LSAP Terminal)");
case 10: format(tmp2,sizeof(tmp2),"Taxi (Location: LSAP Terminal)");
case 11: format(tmp2,sizeof(tmp2),"Maverick (Location: LSAP Apron)");
case 12: format(tmp2,sizeof(tmp2),"Maverick (Location: LSAP Apron)");
case 13: format(tmp2,sizeof(tmp2),"Maverick (Location: LSAP Apron)");
case 14: format(tmp2,sizeof(tmp2),"Shamal Jet (Location: LSAP Hangar)");
case 15: format(tmp2,sizeof(tmp2),"Dodo (Location: LSAP Apron)");
case 16: format(tmp2,sizeof(tmp2),"Dodo (Location: LSAP Apron)");
case 17: format(tmp2,sizeof(tmp2),"HPV-1000 (Location: LSPD Garage)");
case 18: format(tmp2,sizeof(tmp2),"HPV-1000 (Location: LSPD Garage)");
//LS Stealable Cars
case 19: format(tmp2,sizeof(tmp2),"Bicycle (Location: East Beach)");
case 20: format(tmp2,sizeof(tmp2),"Bicycle (Location: Ganton)");
case 21: format(tmp2,sizeof(tmp2),"Bicycle (Location: Willowfield)");
case 22: format(tmp2,sizeof(tmp2),"Bicycle (Location: Jefferson)");
case 23: format(tmp2,sizeof(tmp2),"Primo (Location: Los Flores)");
case 24: format(tmp2,sizeof(tmp2),"Remington (Location: Unity Station)");
case 25: format(tmp2,sizeof(tmp2),"Remington (Location: Willowfield)");
case 26: format(tmp2,sizeof(tmp2),"Remington (Location: East Beach Parking Lot)");
case 27: format(tmp2,sizeof(tmp2),"FCR-900 (Location: Conference Center Parking)");
case 28: format(tmp2,sizeof(tmp2),"FCR-900 (Location: Market)");
case 29: format(tmp2,sizeof(tmp2),"NRG-500 (Location: East Beach Parking Lot)");
case 30: format(tmp2,sizeof(tmp2),"Savanna (Location: Jefferson)");
case 31: format(tmp2,sizeof(tmp2),"Primo (Location: LSAP Parking)");
case 32: format(tmp2,sizeof(tmp2),"Sentinel (Location: LSAP Parking)");
case 33: format(tmp2,sizeof(tmp2),"Remington (Location: LSAP Parking)");
case 34: format(tmp2,sizeof(tmp2),"Tornado (Location: LSAP Parking)");
case 35: format(tmp2,sizeof(tmp2),"Washington (Location: LSAP Parking)");
case 36: format(tmp2,sizeof(tmp2),"Stratum (Location: LSAP Parking)");
case 37: format(tmp2,sizeof(tmp2),"Sadler (Location: LSAP Parking)");
case 38: format(tmp2,sizeof(tmp2),"Savanna (Location: LSAP Parking)");
case 39: format(tmp2,sizeof(tmp2),"Savanna (Location: LSAP Parking)");
case 40: format(tmp2,sizeof(tmp2),"Bufallo (Location: LSAP Parking)");
case 41: format(tmp2,sizeof(tmp2),"Slamvan (Location: LSAP Parking)");
case 42: format(tmp2,sizeof(tmp2),"Jester (Location: LSAP Parking)");
case 43: format(tmp2,sizeof(tmp2),"Elegy (Location: LSAP Parking)");
case 44: format(tmp2,sizeof(tmp2),"ZR-350 (Location: LSAP Parking)");
case 45: format(tmp2,sizeof(tmp2),"Euros (Location: LSAP Parking)");
case 46: format(tmp2,sizeof(tmp2),"Uranus (Location: LSAP Parking)");
case 47: format(tmp2,sizeof(tmp2),"Sultan (Location: LSAP Parking)");
case 48: format(tmp2,sizeof(tmp2),"Blade (Location: LSAP Parking)");
case 49: format(tmp2,sizeof(tmp2),"Savanna (Location: LSAP Parking)");
case 50: format(tmp2,sizeof(tmp2),"NRG-500 (Location: Santa Maria Beach)");
case 51: format(tmp2,sizeof(tmp2),"Tornado (Location: Ganton)");
case 52: format(tmp2,sizeof(tmp2),"Tornado (Location: LS Stadium)");
case 53: format(tmp2,sizeof(tmp2),"NRG-500 (Location: Rodeo)");
case 54: format(tmp2,sizeof(tmp2),"Sentinel (Location: Commerce)");
case 55: format(tmp2,sizeof(tmp2),"NRG-500 (Location: Vinewood Studios)");
case 56: format(tmp2,sizeof(tmp2),"Sentinel (Location: Marina)");
case 57: format(tmp2,sizeof(tmp2),"Nebula (Location: Ocean Docks)");
case 58: format(tmp2,sizeof(tmp2),"Sultan (Location: Ganton)");
case 59: format(tmp2,sizeof(tmp2),"NRG-500 (Location: Mulholland Intersection Parking)");
case 60: format(tmp2,sizeof(tmp2),"Sultan (Location: Conference Center)");
case 61: format(tmp2,sizeof(tmp2),"NRG-500 (Location: Idlewood)");
case 62: format(tmp2,sizeof(tmp2),"Sultan (Location: Market)");
case 63: format(tmp2,sizeof(tmp2),"Cheetah (Location: Commerce)");
case 64: format(tmp2,sizeof(tmp2),"Cheetah (Location: Conference Center Parking)");
case 65: format(tmp2,sizeof(tmp2),"Cheetah (Location: East Los Santos)");
case 66: format(tmp2,sizeof(tmp2),"Stratum (Location: Mulholland)");
case 67: format(tmp2,sizeof(tmp2),"Tourismo (Location: Marina)");
case 68: format(tmp2,sizeof(tmp2),"Tourismo (Location: Market)");
case 69: format(tmp2,sizeof(tmp2),"Slamvan (Location: El Corona)");
case 70: format(tmp2,sizeof(tmp2),"Tourismo (Location: Jefferson Motel)");
case 71: format(tmp2,sizeof(tmp2),"Savanna (Location: East Los Santos)");
case 72: format(tmp2,sizeof(tmp2),"Huntley (Location: Marina)");
case 73: format(tmp2,sizeof(tmp2),"Primo (Location: Temple)");
case 74: format(tmp2,sizeof(tmp2),"Banshee (Location: LSAP Lower Terminal)");
case 75: format(tmp2,sizeof(tmp2),"Banshee (Location: Rodeo)");
case 76: format(tmp2,sizeof(tmp2),"Blade (Location: East Beach Parking Lot)");
case 77: format(tmp2,sizeof(tmp2),"Uranus (Location: Little Mexico)");
case 78: format(tmp2,sizeof(tmp2),"Euros (Location: Commerce)");
case 79: format(tmp2,sizeof(tmp2),"ZR-350 (Location: Market)");
case 80: format(tmp2,sizeof(tmp2),"Infernus (Location: Mulholland Intersection Parking)");
case 81: format(tmp2,sizeof(tmp2),"Elegy (Location: Mulholland Intersection Parking)");
case 82: format(tmp2,sizeof(tmp2),"Bufallo (Location: LS Stadium)");
case 83: format(tmp2,sizeof(tmp2),"Bufallo (Location: Jefferson)");
case 84: format(tmp2,sizeof(tmp2),"Bullet (Location: Rodeo)");
case 85: format(tmp2,sizeof(tmp2),"Bullet (Location: Temple)");
case 86: format(tmp2,sizeof(tmp2),"Bullet (Location: Temple)");
case 87: format(tmp2,sizeof(tmp2),"Bullet (Location: Downtown)");
case 88: format(tmp2,sizeof(tmp2),"Slamvan (Location: Jefferson)");
case 89: format(tmp2,sizeof(tmp2),"Slamvan (Location: LS Stadium)");
// LV Spawns
case 90: format(tmp2,sizeof(tmp2),"Leviathan (Location: Emerald Casino Helipad)");
case 91: format(tmp2,sizeof(tmp2),"ZR-350 (Location: Emerald Casino Parking Lot)");
case 92: format(tmp2,sizeof(tmp2),"Tourismo (Location: Emerald Casino Parking Lot)");
case 93: format(tmp2,sizeof(tmp2),"Elegant (Location: Golf Club House)");
case 94: format(tmp2,sizeof(tmp2),"Euros (Location: House in Prickle Pine)");
case 95: format(tmp2,sizeof(tmp2),"Tornado (Location: Shopping Mall in LV)");
case 96: format(tmp2,sizeof(tmp2),"Blade (Location: Shopping Mall in LV)");
case 97: format(tmp2,sizeof(tmp2),"Uranus (Location: Strip Club at The Old Strip)");
case 98: format(tmp2,sizeof(tmp2),"Elegant (Location: Calligulas Casino Entrance)");
case 99: format(tmp2,sizeof(tmp2),"Premier (Location: Visage Casino Entrance)");
case 100: format(tmp2,sizeof(tmp2),"Huntley (Location: AUTOBAHN CAr Sales)");
case 101: format(tmp2,sizeof(tmp2),"Slamvan (Location: AUTOBAHN Car Sales)");
case 102: format(tmp2,sizeof(tmp2),"Elegant (Location: Four Dragons Casino Entrance)");
case 103: format(tmp2,sizeof(tmp2),"Buffalo (Location: The Strip)");
case 104: format(tmp2,sizeof(tmp2),"Remington (Location: The Strip)");
case 105: format(tmp2,sizeof(tmp2),"ZR-350 (Location: The Strip)");
case 106: format(tmp2,sizeof(tmp2),"Tourismo (Location: The Strip)");
case 107: format(tmp2,sizeof(tmp2),"Uranus (Location: The Strip)");
case 108: format(tmp2,sizeof(tmp2),"Euros (Location: The Strip)");
case 109: format(tmp2,sizeof(tmp2),"Jester (Location: Wang Cars)");
case 110: format(tmp2,sizeof(tmp2),"Sultan (Location: Wang Cars)");

// SF Spawns
case 111: format(tmp2,sizeof(tmp2),"Tornado (Location: Otto's Autos)");
case 112: format(tmp2,sizeof(tmp2),"Elegy (Location: Otto's Autos)");
case 113: format(tmp2,sizeof(tmp2),"Jester (Location: Pier 69)");
case 114: format(tmp2,sizeof(tmp2),"Bus (Location: Financial Hotel)");
case 115: format(tmp2,sizeof(tmp2),"Savanna (Location: Financial Hotel Parking)");
case 116: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Calton Heights)");
case 117: format(tmp2,sizeof(tmp2),"ZR-350 (Location: House in China Town)");
case 118: format(tmp2,sizeof(tmp2),"Premier (Location: King's Hotel)");
case 119: format(tmp2,sizeof(tmp2),"Buffalo (Location: SF Country Club)");
case 120: format(tmp2,sizeof(tmp2),"Elegant (Location: SF Country Club)");
case 121: format(tmp2,sizeof(tmp2),"Jester (Location: Driver's School)");
case 122: format(tmp2,sizeof(tmp2),"Tornado (Location: Driver's School)");
case 123: format(tmp2,sizeof(tmp2),"Majestic (Location: Driver's School)");
case 124: format(tmp2,sizeof(tmp2),"ZR-350 (Location: Wang Cars)");
case 125: format(tmp2,sizeof(tmp2),"Elegant (Location: Wang Cars)");
case 126: format(tmp2,sizeof(tmp2),"Premier (Location: Wang Cars)");
case 127: format(tmp2,sizeof(tmp2),"Majestic (Location: Wang Cars)");

//Additional public Cars
case 128: format(tmp2,sizeof(tmp2),"Taxi (Location: Come-A-Lot Casino Entrance)");
case 129: format(tmp2,sizeof(tmp2),"Cabbie (Location: Come-A-Lot Casino Entrance)");
case 130: format(tmp2,sizeof(tmp2),"Taxi (Location: SF Train Station)");
case 131: format(tmp2,sizeof(tmp2),"Cabbie (Location: SF Train Station)");
case 132: format(tmp2,sizeof(tmp2),"Firetruck (Location: LSFD)");
case 133: format(tmp2,sizeof(tmp2),"Firetruck (Location: LSFD)");
case 134: format(tmp2,sizeof(tmp2),"Dodo (Location: LSAP Apron)");
case 135: format(tmp2,sizeof(tmp2),"Dodo (Location: LSAP Apron)");
case 136: format(tmp2,sizeof(tmp2),"LSFD Raindance (Location: LSFD)");
case 137: format(tmp2,sizeof(tmp2),"Police Maverick (Location: LSPD)");
case 138: format(tmp2,sizeof(tmp2),"Maverick (Location: LSLR General Hospital)");
case 139: format(tmp2,sizeof(tmp2),"Andromeda (Location: LSAP Big Hangar)");
case 140: format(tmp2,sizeof(tmp2),"Maverick (Location: LVAP Gates)");
case 141: format(tmp2,sizeof(tmp2),"Bus (Location: LVAP Gates)");
case 142: format(tmp2,sizeof(tmp2),"Maverick (Location: SFAP Gates)");
case 143: format(tmp2,sizeof(tmp2),"Bus (Location: SFAP Gates)");
case 144: format(tmp2,sizeof(tmp2),"Police Car (Location: SFPD)");
case 145: format(tmp2,sizeof(tmp2),"Police Car (Location: SFPD Garage)");
case 146: format(tmp2,sizeof(tmp2),"HPV-1000 (Location: SFPD Garage)");
case 147: format(tmp2,sizeof(tmp2),"HPV-1000 (Location: SFPD Garage)");
case 148: format(tmp2,sizeof(tmp2),"Police Maverick (Location: SFPD Helipad)");
case 149: format(tmp2,sizeof(tmp2),"Firetruck (Location: SFFD)");
case 150: format(tmp2,sizeof(tmp2),"Firetruck (Location: SFFD)");
case 151: format(tmp2,sizeof(tmp2),"SFFD Raindance (Location: SFFD)");
case 152: format(tmp2,sizeof(tmp2),"Ambulance (Location: SFLR)");
case 153: format(tmp2,sizeof(tmp2),"Ambulance (Location: SFLR)");
case 154: format(tmp2,sizeof(tmp2),"Maverick (Location: SFLR)");
case 155: format(tmp2,sizeof(tmp2),"Shamal Jet (Location: SFAP)");
case 156: format(tmp2,sizeof(tmp2),"Police Car (Location: LVPD)");
case 157: format(tmp2,sizeof(tmp2),"Police Car (Location: LVPD Garage)");
case 158: format(tmp2,sizeof(tmp2),"HPV-1000 (Location: LVPD Garage)");
case 159: format(tmp2,sizeof(tmp2),"HPV-1000 (Location: LVPD Garage)");
case 160: format(tmp2,sizeof(tmp2),"Police Maverick (Location: LVPD)");
case 161: format(tmp2,sizeof(tmp2),"Firetruck (Location: LVFD)");
case 162: format(tmp2,sizeof(tmp2),"Firetruck (Location: LVFD)");
case 163: format(tmp2,sizeof(tmp2),"LVFD Raindance (Location: LVFD)");
case 164: format(tmp2,sizeof(tmp2),"Ambulance (Location: LVLR)");
case 165: format(tmp2,sizeof(tmp2),"Ambulance (Location: LVLR)");
case 166: format(tmp2,sizeof(tmp2),"Maverick (Location: LVLR)");
case 167: format(tmp2,sizeof(tmp2),"Shamal Jet (Location: LVAP)");
case 168: format(tmp2,sizeof(tmp2),"Bus (Location: Farm near LS)");
case 169: format(tmp2,sizeof(tmp2),"Bus (Location: Farm near SF)");
case 170: format(tmp2,sizeof(tmp2),"Bus (Location: Farm near LV)");
case 171: format(tmp2,sizeof(tmp2),"Derby Patriot (Location: The Skydive centre)");
case 172: format(tmp2,sizeof(tmp2),"Derby Patriot (Location: The Skydive centre)");
case 173: format(tmp2,sizeof(tmp2),"Derby Patriot (Location: The Skydive centre)");
case 174: format(tmp2,sizeof(tmp2),"Derby Patriot (Location: The Skydive centre)");
case 175: format(tmp2,sizeof(tmp2),"Derby Patriot (Location: The Skydive centre)");
//House cars for donators
case 176: format(tmp2,sizeof(tmp2),"Infernus (Location: M1k3's City Hall, SF)");
case 177: format(tmp2,sizeof(tmp2),"NRG-500 (Location: Wang Cars)");
case 178: format(tmp2,sizeof(tmp2),"SWAT Van (Location: SFPD SWAT)");
case 179: format(tmp2,sizeof(tmp2),"SWAT Van (Location: SFPD SWAT)");
case 180: format(tmp2,sizeof(tmp2),"Train (Location: LS Unity Station)");
}

	format(str,sizeof(str),"Logged in: [Pocket: $%d - Vehicle: %s]",GetPlayerMoney(playerid),tmp2);
    pInfo[playerid][Logged] = 1;
	SendClientMessage(playerid,COLOR_GREEN,str);
	tmp1 = dini_Get(udb_encode(player),"Level");
	if (strval(tmp1)>=2){
	format(str,sizeof(str),"You logged in as gamemode admin (Level %d)",strval(tmp1));
	SendClientMessage(playerid,COLOR_GREEN,str);
	pInfo[playerid][Admin] = 1;
	}

jobcheck = strval(dini_Get(udb_encode(player),"Cop"));
if (jobcheck != 1){
	pInfo[playerid][CopBlock] = 1;
	}

if (jobcheck == 1){
	SendClientMessage(playerid,COLOR_GREEN,"You are a licensed cop.");
	pInfo[playerid][CopBlock] = 0;
	}

jobcheck = strval(dini_Get(udb_encode(player),"Lawyer"));

if (jobcheck == 1) SendClientMessage(playerid,COLOR_GREEN,"You are a licensed lawyer.");

SendClientMessage(playerid,COLOR_YELLOW,"/rpg to speak as your character in RPG. /ooc to talk as player!");
pInfo[playerid][Logged] = 1;
SpawnPlayer(playerid);

// This makes house cars locked for all and being shown on the radar as yellow dots
SetVehicleParamsForPlayer(176, playerid,1,1); //M1k3's car
WriteEcho("[server] (Login) 1 house car locked and 1 highlighted on the radar");

return 1;
}

//Function_commands
if(strcmp(cmd,"/commands",true)==0)
{
	#pragma unused cmdtext
    SendClientMessage(playerid,COLOR_YELLOW,"Pure RPG Commands");
    SendClientMessage(playerid,COLOR_ORANGE,"/register | /login | /jointeam | /me  |/laws | /wanted | /setcity");
	SendClientMessage(playerid,COLOR_ORANGE,"/job | /pay | /wiretransfer | /rob | /L[ocal chat] | /saveskin | /(un)lock");
	SendClientMessage(playerid,COLOR_ORANGE,"/getskin | /admins | /heal  | /taxidriver | /atc  | /changename [new name]");
	SendClientMessage(playerid,COLOR_ORANGE,"/changepass [old password] [new password] | /visit | /jail | /back | /A[dmin report] | /911");
	SendClientMessage(playerid,COLOR_ORANGE,"/taxi  | /R | /buy | /exit | /sell | /find | /showhouse | /sue | /ooc | /rpg");
	SendClientMessage(playerid,COLOR_ORANGE,"/bail | /deposit | /balance | /drugs | /buydrugs | /usedrugs | /selldrugs");
	SendClientMessage(playerid,COLOR_RED,"Other: /actions | /fuel | /bizhelp | /flightcommands | /minigames | /cophelp | /courthelp | /ah");
    SendClientMessage(playerid,COLOR_YELLOW,"Please do not abuse any commands.");
	return 1;
}

//Function_flightcommands
if(strcmp(cmd,"/flightcommands",true)==0)
{
	#pragma unused cmdtext
    SendClientMessage(playerid,COLOR_YELLOW,"Pure RPG Flight System Commands");
	SendClientMessage(playerid,COLOR_ORANGE,"/charter | /bookflight [destination] | /bookflight parachute [drop-off point] | /board");
	SendClientMessage(playerid,COLOR_ORANGE,"/bookings | /GL | /RL | /onblocks | /unboard");
    SendClientMessage(playerid,COLOR_YELLOW,"Please do not abuse any commands.");
	return 1;
}

//Function_help
if(strcmp(cmd,"/help",true)==0)
{
	#pragma unused cmdtext
    SendClientMessage(playerid,COLOR_YELLOW,"Pure RPG Help");
    SendClientMessage(playerid,COLOR_ORANGE,"Welcome to Pure RPG - [No DM - gta-host.com]");
    SendClientMessage(playerid,COLOR_ORANGE,"Please read the /laws and check the /commands.");
    SendClientMessage(playerid,COLOR_ORANGE,"/job gives you a detailed explanation of what to do");
    return 1;
}

//Function_laws
if(strcmp(cmd,"/laws",true)==0)
{
	#pragma unused cmdtext
    SendClientMessage(playerid,COLOR_YELLOW,"Pure RPG Law");
    SendClientMessage(playerid,COLOR_ORANGE,"§1 The dignity of the person is untouchable [= Always Role Play].");
    SendClientMessage(playerid,COLOR_ORANGE,"§2 Human Life is the most valuable thing to be protected [= Do not Deathmatch].");
    SendClientMessage(playerid,COLOR_ORANGE,"§3 The one and only final law enforcing instance is the state itself [= Obey all admins].");
    SendClientMessage(playerid,COLOR_ORANGE,"§4 San Andreas's prescribed national language is English [= No flaming, No spamming. English in Mainchat].");
    SendClientMessage(playerid,COLOR_ORANGE,"§5 All mobile vehicles have to follow a right-side traffic logic [= Drive on the right side of the road].");
    SendClientMessage(playerid,COLOR_ORANGE,"§6 Theft of property - be it private or property of the state of San Andreas - is highly prohibited");
    SendClientMessage(playerid,COLOR_ORANGE,"§7 All forms of supernatural forces will not be tolerated [= If you hack, instant ban]!");
    return 1;
}

//Function_job
if(strcmp(cmd,"/job",true)==0)
{
#pragma unused cmdtext
gTeam[playerid] = GetPlayerTeam(playerid);
switch (gTeam[playerid]) {
	case TEAM_CIVS: {
	SendClientMessage(playerid, COLOR_ORANGE, "As a civilian you do not have a clear aim.");
	SendClientMessage(playerid, COLOR_ORANGE, "RP in peace and earn money by dealing or /taxidriver. Payday is every full hour");
	SendClientMessage(playerid, COLOR_ORANGE, "But you can use your money to buy things");
	SendClientMessage(playerid, COLOR_ORANGE, "e.g. weapons at ammunation or food/clothes in stores.");
	SendClientMessage(playerid, COLOR_ORANGE, "Use /pay near a player to pay another player.");
	}
	case TEAM_SENIORS: {
	SendClientMessage(playerid, COLOR_ORANGE, "As a senior you do not have a clear aim.");
	SendClientMessage(playerid, COLOR_ORANGE, "RP in peace and earn money by dealing or /taxidriver. Payday is every full hour");
	SendClientMessage(playerid, COLOR_ORANGE, "But you can use your money to buy things");
	SendClientMessage(playerid, COLOR_ORANGE, "e.g. weapons at ammunation or food/clothes in stores.");
	SendClientMessage(playerid, COLOR_ORANGE, "Use /pay near a player to pay another player.");
	}
	case TEAM_WAITERS: {
	SendClientMessage(playerid, COLOR_ORANGE, "As a waiter your objective is to earn money.");
	SendClientMessage(playerid, COLOR_ORANGE, "RP in peace and earn money by serving or /taxidriver. Payday is every full hour");
	SendClientMessage(playerid, COLOR_ORANGE, "You can then use your earned money to buy things");
	SendClientMessage(playerid, COLOR_ORANGE, "e.g. weapons at ammunation or food/clothes in stores.");
	SendClientMessage(playerid, COLOR_ORANGE, "Let other players pay your service by telling them to use /pay near you");
	}
	case TEAM_CRIMINALS: {
	SendClientMessage(playerid, COLOR_ORANGE, "As a criminal you do not have a clear aim.");
	SendClientMessage(playerid, COLOR_ORANGE, "Try to get money by robbery (/rob [ID]) or RPG.");
   	SendClientMessage(playerid, COLOR_ORANGE, "You can picklock and steal people's cars with /gta [ID].");
	SendClientMessage(playerid, COLOR_ORANGE, "You can use your money to buy things");
	SendClientMessage(playerid, COLOR_ORANGE, "e.g. weapons at ammunation or food/clothes in stores.");
	SendClientMessage(playerid, COLOR_ORANGE, "Cops can arrest you. Cooperate to get a lower penalty.");
	}
	case TEAM_SECURITIES: {
	SendClientMessage(playerid, COLOR_ORANGE, "As a security you must supervise larger group events or protect private persons.");
	SendClientMessage(playerid, COLOR_ORANGE, "You are supposed to prevent people being hurt. Payday is every full hour");
	SendClientMessage(playerid, COLOR_ORANGE, "Let your clients pay you by telling them to use /pay near you.");
	SendClientMessage(playerid, COLOR_ORANGE, "You can then use your money to buy things");
	SendClientMessage(playerid, COLOR_ORANGE, "e.g. weapons at ammunation or food/clothes in stores.");
	SendClientMessage(playerid, COLOR_ORANGE, "Use /pay near a player to pay another player.");
	}
	case TEAM_PILOTS: {
	SendClientMessage(playerid, COLOR_ORANGE, "As a pilot you are the only one being allowed to fly the Andromeda.");
	SendClientMessage(playerid, COLOR_ORANGE, "Use /flightcommands to learn how to become the official charter pilot.");
	SendClientMessage(playerid, COLOR_ORANGE, "When all people who booked boarded enter /takeoff and fly.");
	SendClientMessage(playerid, COLOR_ORANGE, "For a parachute drop off enter /GL when the people should jump out. End the flight with /RL and /onblocks.");
	SendClientMessage(playerid, COLOR_ORANGE, "You can then use your money to buy things. Payday is every full hour");
	SendClientMessage(playerid, COLOR_ORANGE, "e.g. weapons at ammunation or food/clothes in stores.");
	SendClientMessage(playerid, COLOR_ORANGE, "Use /pay near a player to pay another player.");
	}
	case TEAM_ENTERTAINERS: {
	SendClientMessage(playerid, COLOR_ORANGE, "As an entertainer you do not have a clear aim.");
	SendClientMessage(playerid, COLOR_ORANGE, "You are supposed to make people happy. :D Payday is every full hour");
	SendClientMessage(playerid, COLOR_ORANGE, "Let them pay you for your services ( ;) ) by telling them to use /pay near you.");
	SendClientMessage(playerid, COLOR_ORANGE, "You can then use your money to buy things");
	SendClientMessage(playerid, COLOR_ORANGE, "e.g. weapons at ammunation or food/clothes in stores.");
	SendClientMessage(playerid, COLOR_ORANGE, "Cops can arrest you. Cooperate to get a lower penalty.");
	}
	case TEAM_MEDICS: {
	SendClientMessage(playerid, COLOR_ORANGE, "As a medic you must /heal people when they call you.");
	SendClientMessage(playerid, COLOR_ORANGE, "Let them pay your service by telling them to use /pay near you. Payday is every full hour");
	SendClientMessage(playerid, COLOR_ORANGE, "You can then use your money to buy things");
	SendClientMessage(playerid, COLOR_ORANGE, "e.g. weapons at ammunation or food/clothes in stores.");
	SendClientMessage(playerid, COLOR_ORANGE, "Use /pay near a player to pay another player.");
	}
	case TEAM_FIREMEN: {
	SendClientMessage(playerid, COLOR_ORANGE, "As a fireman you must prevent or extinguish fires");
	SendClientMessage(playerid, COLOR_ORANGE, "Payday is every full hour.");
	SendClientMessage(playerid, COLOR_ORANGE, "You can then use your money to buy things");
	SendClientMessage(playerid, COLOR_ORANGE, "e.g. weapons at ammunation or food/clothes in stores.");
	SendClientMessage(playerid, COLOR_ORANGE, "Use /pay near a player to pay another player.");
	}
	case TEAM_COPS: {
	SendClientMessage(playerid, COLOR_ORANGE, "As a good cop you dont DM. Type '/cophelp' to learn how to play a cop.");
	SendClientMessage(playerid, COLOR_ORANGE, "Payday is every full hour.");
	SendClientMessage(playerid, COLOR_ORANGE, "You can then use your money to buy things");
	SendClientMessage(playerid, COLOR_ORANGE, "e.g. weapons at ammunation or food/clothes in stores.");
	SendClientMessage(playerid, COLOR_ORANGE, "Use /pay near a player to pay another player.");
	}

}
    return 1;
}

//Function_pay
if(strcmp(cmd,"/pay",true)==0)
{
#pragma unused cmdtext
	new donator[24],recID,recStr[5],reciever[24],string1[120], string2[120], paylogstr[120];

	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /pay [ID] [amount of $]");
		return 1;
		}
if (strlen(cmdtext)>=9){
SendClientMessage(playerid,COLOR_RED,"You are not allowed to transfer more than 99.999$ at a time");
return 1;
}
else
	strmid(recStr,cmdtext,0,3,3);
	strmid(cmdtext,cmdtext,3,11,8);
	recID = strval(recStr);
	GetPlayerName(recID,reciever,24);
    GetPlayerName(playerid,donator,24);
	new amount=strval(cmdtext);
	new aviablemoney=GetPlayerMoney(playerid);

		if (amount <= 0 || amount >= 100000){
		SendClientMessage(playerid,COLOR_RED,"You can pay amounts between 1$ and 99999$ only.");
		return 0;
		}

		if (recID == playerid){
 	    SendClientMessage(playerid,COLOR_RED,"No point in paying yourself.");
 	    return 1;
 	    }

 		if(amount>aviablemoney){
 	    SendClientMessage(playerid,COLOR_RED,"You do not have that much money. :P");
		return 1;
 		}

   		if (!IsPlayerConnected(recID)){
        SendClientMessage(playerid,COLOR_RED,"ID not found or player not connected anymore :(");
        return 0;
   	    }

	  		if(IsPlayerConnected(recID) && GetDistanceBetweenPlayers(playerid,recID) <= 5){//Set the maximum distance between donator and reciever here as low as possible
			format(paylogstr, sizeof (paylogstr), "%s used /PAY to give %d$ to %s (ID %d)",donator,amount,reciever,recID);
			print(paylogstr);
			format(string2,sizeof(string2),"You give %d$ to %s",amount,reciever);
    		format(string1,sizeof(string1),"You recieved %d$ from %s",amount,donator);
            GivePlayerMoney(playerid,-amount);
			GivePlayerMoney(recID,amount);
	    	SendClientMessage(recID,COLOR_YELLOW,string1);
	    	SendClientMessage(playerid,COLOR_YELLOW,string2);
	    		if (LSTaxicust == playerid){
				LSTaxicust = -1;
				SendClientMessage(playerid,BBLUE,"Taxi transfer completed.");
				WriteEcho("[server] [LS] Taxi transfer completed");
				printf ("*****Taxi tranfer completed (Driver ID %d)*********",LSTaxidrvr);
	    		}
	 	   		if (SFTaxicust == playerid){
				SFTaxicust = -1;
				SendClientMessage(playerid,BBLUE,"Taxi transfer completed.");
				WriteEcho("[server] [SF] Taxi transfer completed");
				printf ("*****Taxi tranfer completed (Driver ID %d)*********",SFTaxidrvr);
	    		}
   		   		if (LVTaxicust == playerid){
				LVTaxicust = -1;
				SendClientMessage(playerid,BBLUE,"Taxi transfer completed.");
				WriteEcho("[server] [LV] Taxi transfer completed");
				printf ("*****Taxi tranfer completed (Driver ID %d)*********",LVTaxidrvr);
	    		}
	    	return 1;
			}
SendClientMessage(playerid,COLOR_RED,"You are too far away from the other player to hand him money. :(");
return 0;
}

//Function_wiretransfer
if(strcmp(cmd,"/wiretransfer",true)==0)
{
#pragma unused cmdtext
	new donator[24],recID,recStr[5],reciever[24],string1[120], string2[120], paylogstr[120];

	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /wiretransfer [ID] [amount of $]");
		return 1;
		}
if (strlen(cmdtext)>=9){
SendClientMessage(playerid,COLOR_RED,"You are not allowed to transfer more than 99.999$ at a time");
return 1;
}
else
	strmid(recStr,cmdtext,0,3,3);
	strmid(cmdtext,cmdtext,3,11,8);
	recID = strval(recStr);
	GetPlayerName(recID,reciever,24);
    GetPlayerName(playerid,donator,24);
	new amount=strval(cmdtext);
	new aviablemoney=strval(dini_Get(udb_encode(donator),"Bank"));

		if (amount <= 0 || amount >= 100000){
		SendClientMessage(playerid,COLOR_RED,"You can transfer amounts between 1$ and 99999$ only.");
		return 0;
		}

		if (recID == playerid){
 	    SendClientMessage(playerid,COLOR_RED,"No point in transfering money to yourself.");
 	    return 1;
 	    }

 		if(amount>aviablemoney){
 	    SendClientMessage(playerid,COLOR_RED,"You do not have that much money. :P");
		return 1;
 		}

   		if (!IsPlayerConnected(recID)){
        SendClientMessage(playerid,COLOR_RED,"ID not found or player not connected anymore :(");
        return 0;
   	    }

	  		if(IsPlayerConnected(recID)){
			format(paylogstr, sizeof (paylogstr), "%s used /WIRETRANSFER to give %d$ to %s (ID %d)",donator,amount,reciever,recID);
			print(paylogstr);
			format(string2,sizeof(string2),"You transfered %d$ to %s bank account",amount,reciever);
    		format(string1,sizeof(string1),"You recieved %d$ from %s into your bank account",amount,donator);
            GivePlayerBankMoney(playerid,-amount);
			GivePlayerBankMoney(recID,amount);
	    	SendClientMessage(recID,COLOR_YELLOW,string1);
	    	SendClientMessage(playerid,COLOR_YELLOW,string2);
          	return 1;
			}
SendClientMessage(playerid,COLOR_RED,"You are too far away from the other player to hand him money. :(");
return 0;
}

//Function_buydrugs
if(strcmp(cmd,"/buydrugs",true)==0)
{
#pragma unused cmdtext
	new donator[24],recID,recStr[5],reciever[24],string1[120], string2[120], paylogstr[120];

	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /buydrugs [ID] [amount of drugs in grams]");
	    SendClientMessage(playerid,COLOR_ORANGE,"Current black market price: 5$ per gram.");
		return 1;
		}
if (strlen(cmdtext)>=7){
SendClientMessage(playerid,COLOR_RED,"You are not allowed to transfer more than 999 grams at a time");
return 1;
}
else
	strmid(recStr,cmdtext,0,3,3);
	strmid(cmdtext,cmdtext,3,11,8);
	recID = strval(recStr);
	GetPlayerName(recID,donator,24);
    GetPlayerName(playerid,reciever,24);
	new amount=strval(cmdtext);
	new aviablemoney=GetPlayerMoney(playerid);

		if (amount <= 0 || amount >= 1000){
		SendClientMessage(playerid,COLOR_RED,"You can buy amounts between 1 gram and 999 grams only.");
		return 0;
		}

		if (recID == playerid){
	    SendClientMessage(playerid,COLOR_RED,"No point in dealing with yourself.");
 	    return 1;
	    }

 		if(amount>aviablemoney){
 	    SendClientMessage(playerid,COLOR_RED,"You do not have that much money. :P");
		return 1;
 		}

   		if (!IsPlayerConnected(recID)){
        SendClientMessage(playerid,COLOR_RED,"ID not found or player not connected anymore :(");
        return 0;
   	    }

	  		if(IsPlayerConnected(recID) && GetDistanceBetweenPlayers(playerid,recID) <= 5){//Set the maximum distance between donator and reciever here as low as possible
			format(paylogstr, sizeof (paylogstr), "%s used /BUYDRUGS to demand %d grams from %s (ID %d)",reciever,amount,donator,recID);
			print(paylogstr);
			format(string2,sizeof(string2),"You demand %d grams from %s. This will cost %d$",amount,donator,amount * 5);
    		format(string1,sizeof(string1),"%s (ID %d) demands you to sell him %d grams of drugs for %d$",reciever,playerid,amount,amount *5);
            SendClientMessage(recID,BBLUE,string1);
            SendClientMessage(recID,COLOR_YELLOW,"Use /selldrugs to fulfil his demand.");
	    	SendClientMessage(playerid,BBLUE,string2);
	    	pInfo[playerid][WantDrugs] = 1;
	    	return 1;
			}
SendClientMessage(playerid,COLOR_RED,"You are too far away from the other player to demand drugs from him. :(");
return 0;
}

//Function_Selldrugs
if(strcmp(cmd,"/selldrugs",true)==0)
{
#pragma unused cmdtext
	new donator[24],recID,recStr[5],reciever[24],string1[120], string2[120], paylogstr[120];

	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /selldrugs [ID] [amount of drugs in grams]");
		return 1;
		}
if (strlen(cmdtext)>=7){
SendClientMessage(playerid,COLOR_RED,"You are not allowed to transfer more than 999 grams at a time");
return 1;
}
else
	strmid(recStr,cmdtext,0,3,3);
	strmid(cmdtext,cmdtext,3,11,8);
	recID = strval(recStr);
	GetPlayerName(recID,reciever,24);
    GetPlayerName(playerid,donator,24);
	new amount=strval(cmdtext);
	new aviablemoney=pInfo[playerid][DrugsAmount];

		if (amount <= 0 || amount >= 1000){
		SendClientMessage(playerid,COLOR_RED,"You can sell amounts between 1 gram and 999 grams only.");
		return 0;
		}

		if (recID == playerid){
	    SendClientMessage(playerid,COLOR_RED,"No point in dealing with yourself.");
 	    return 1;
	    }

 		if(amount>aviablemoney){
 	    SendClientMessage(playerid,COLOR_RED,"You do not have that amount of drugs :(");
 	    SendClientMessage(playerid,COLOR_YELLOW,"Use /drugs to know how much you have");
		return 1;
 		}

   		if (!IsPlayerConnected(recID)){
        SendClientMessage(playerid,COLOR_RED,"ID not found or player not connected anymore :(");
        return 0;
   	    }

		if (!pInfo[recID][WantDrugs]){
        SendClientMessage(playerid,COLOR_RED,"This player is not interested in getting drugs. ;(");
        return 0;
		}
	  		if(IsPlayerConnected(recID) && GetDistanceBetweenPlayers(playerid,recID) <= 5){//Set the maximum distance between donator and reciever here as low as possible
			format(paylogstr, sizeof (paylogstr), "%s used /SELLDRUGS to sell %d grams from %s (ID %d)",reciever,amount,donator,recID);
			print(paylogstr);
			format(string2,sizeof(string2),"You sold %d grams to %s",amount,reciever);
    		format(string1,sizeof(string1),"%s sold you %d grams of drugs for %d$",reciever,amount,amount * 5);
    		pInfo[playerid][DrugsAmount] = pInfo[playerid][DrugsAmount] - amount;
			GivePlayerMoney(playerid,amount * 5);
			dini_IntSet(udb_encode(donator),"Drugs",pInfo[playerid][DrugsAmount]);
			pInfo[recID][DrugsAmount] = pInfo[recID][DrugsAmount] + amount;
			GivePlayerMoney(recID,-amount * 5);
			dini_IntSet(udb_encode(reciever),"Drugs",pInfo[recID][DrugsAmount]);
            SendClientMessage(recID,COLOR_YELLOW,string1);
            pInfo[recID][WantDrugs] = 0;
	    	SendClientMessage(playerid,COLOR_YELLOW,string2);
	    	SendClientMessage(playerid,COLOR_RED,"Remember to tell your buyer to use /pay if you dealt out a higher amount of money");
	    	return 1;
			}
SendClientMessage(playerid,COLOR_RED,"You are too far away from the other player to hand him drugs. :(");
return 0;
}

//Function_drugs
if(strcmp(cmd,"/drugs",true)==0)
{
#pragma unused cmdtext
new string[120],donator[24],balance;

GetPlayerName(playerid,donator,sizeof(donator));
balance = strval(dini_Get(udb_encode(donator),"Drugs"));
format(string, sizeof (string), "You have %d grams currently.",balance);
SendClientMessage(playerid,COLOR_YELLOW,string);
return 1;
}

//Function_usedrugs
if(strcmp(cmd,"/usedrugs",true)==0)
{
new string[120],health2,health3;
new Float:health1;
GetPlayerName(playerid,player,24);
	if(!strlen(cmdtext))
	{
	    SendClientMessage(playerid,COLOR_GREY,"Usage: /usedrugs [amount of grams]");
	    SendClientMessage(playerid,COLOR_GREY,"+ 5% health per gram up to 120%");
		return 1;
	}

	new amount=strval(cmdtext);

   	if (amount==0){
	SendClientMessage(playerid,BBLUE,"You take a look on your drugs. They look nice.");
	return 0;
	}

	if (amount>pInfo[playerid][DrugsAmount]){
	SendClientMessage(playerid,COLOR_RED,"You do not have enough grams of drugs");
	return 0;
	}

GetPlayerHealth(playerid,health1);
health2 = floatround(health1,floatround_floor);
health3 = health2 - 5;

    for(new ud = amount; ud>=0; ud = ud - 1)
	{
		health3 = health3 + 5;
		if (health3<=120) SetPlayerHealth(playerid,health3);
	}
	pInfo[playerid][DrugsAmount] = pInfo[playerid][DrugsAmount] - amount;
	format(string,sizeof(string),"You have used %d grams of drugs (%d grams left).",amount,pInfo[playerid][DrugsAmount]);
	SendClientMessage(playerid,COLOR_YELLOW,string);
	SendClientMessage(playerid,COLOR_RED,"Cops can detect that you have used drugs until the next payday!!");
	pInfo[playerid][UsedDrugs] = 1;
	dini_IntSet(udb_encode(player),"Drugs",pInfo[playerid][DrugsAmount]);
 	return 1;
}

//Function_fine
if(strcmp(cmd,"/fine",true)==0)
{
#pragma unused cmdtext
	new teamcops1,donator[24],recID,recStr[5],reciever[24],string1[120], string2[120], paylogstr[120];

	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /fine [ID] [amount of $]");
		return 1;
		}

	strmid(recStr,cmdtext,0,3,3);
	strmid(cmdtext,cmdtext,3,11,8);
	recID = strval(recStr);
	GetPlayerName(recID,reciever,24);
    GetPlayerName(playerid,donator,24);
	teamcops1=GetPlayerTeam(playerid);
	new amount=strval(cmdtext);

if (teamcops1==TEAM_COPS){
		if (amount <= 0 || amount > 500){
		SendClientMessage(playerid,COLOR_RED,"You can fine amounts between 1$ and 500$ only.");
		return 0;
		}

		if (pInfo[playerid][WantedLevel] > 3){
		SendClientMessage(playerid,COLOR_RED,"The person you tried to fine is too criminal to be fined.");
		SendClientMessage(playerid,COLOR_YELLOW,"Use /cuff [ID] and /check [ID] to bring him/her to jail.");
		return 0;
		}

		if (recID == playerid){
 	    SendClientMessage(playerid,COLOR_RED,"No point in fining yourself.");
 	    return 1;
 	    }

   		if (!IsPlayerConnected(recID)){
        SendClientMessage(playerid,COLOR_RED,"ID not found or player not connected anymore :(");
        return 0;
   	    }

	  		if(IsPlayerConnected(recID) && GetDistanceBetweenPlayers(playerid,recID) <= 5){//Set the maximum distance between donator and reciever here as low as possible
			format(paylogstr, sizeof (paylogstr), "[server] %s used /FINE to get %d$ from %s (ID %d)",donator,amount,reciever,recID);
			print(paylogstr);
			WriteEcho(paylogstr);
			format(string2,sizeof(string2),"You give a %d$ fine to %s",amount,donator);
    		format(string1,sizeof(string1),"You recieved a %d$ fine from %s",amount,reciever);
            GivePlayerMoney(recID,-amount);
			GivePlayerMoney(playerid,amount);
	    	SendClientMessage(recID,COLOR_YELLOW,string2);
	    	SendClientMessage(playerid,COLOR_YELLOW,string1);
  	    	return 1;
			}
SendClientMessage(playerid,COLOR_RED,"You are to far away from the other player to hand him money. :(");
return 0;
}
SendClientMessage(playerid,BBLUE,"A bypassing afro-american civilian says:");
SendClientMessage(playerid,COLOR_WHITE,"Yo aint a cop, foooooool! :P");
return 0;
}

//Function_drugtest
if(strcmp(cmd,"/drugtest",true)==0)
{
#pragma unused cmdtext
new teamcops2,copname2[24],checkstr[120],arrested2,arrestedname2[24];
teamcops2=GetPlayerTeam(playerid);
arrested2=strval(cmdtext);
GetPlayerName(playerid,copname2,sizeof(copname2));
	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /drugtest [ID]");
		return 1;
	}

	if (teamcops2==TEAM_COPS){
	    if(IsPlayerConnected(arrested2) && pInfo[arrested2][UsedDrugs] && GetDistanceBetweenPlayers(playerid,arrested2) <= 5){
		GetPlayerName(arrested2,arrestedname2,sizeof(arrestedname2));
		format(checkstr,sizeof(checkstr),"[server] Officer %s (ID %d) finds out that %s (ID %d) has used drugs",copname2,playerid,arrestedname2,arrested2);
		print(checkstr);
		WriteEcho(checkstr);
        SendClientMessage(arrested2,BBLUE,"The cop found out you used drugs...");
        SendClientMessage(arrested2,COLOR_RED,"Your wanted level has been raised.");
        SendClientMessage(playerid,BBLUE,"You found out that this person used drugs recently");
		pInfo[arrested2][AddWanted] = 1;
		}

   	    if(IsPlayerConnected(arrested2) && pInfo[arrested2][DrugsAmount]>=100  && GetDistanceBetweenPlayers(playerid,arrested2) <= 5){
		GetPlayerName(arrested2,arrestedname2,sizeof(arrestedname2));
		format(checkstr,sizeof(checkstr),"[server] Officer %s (ID %d) finds out that %s (ID %d) posseses an illegal amount of drugs",copname2,playerid,arrestedname2,arrested2);
		print(checkstr);
		WriteEcho(checkstr);
        SendClientMessage(arrested2,BBLUE,"The cop found a few of your drugs... Luckily not all");
        SendClientMessage(arrested2,COLOR_RED,"Your wanted level has been raised and he confiscates what he found.");
        SendClientMessage(playerid,BBLUE,"You found out that this person posseses drugs and confiscate them");
		pInfo[arrested2][AddWanted] = 1;
		new amount=random(pInfo[arrested2][DrugsAmount] / 10);
		pInfo[playerid][DrugsAmount] = pInfo[playerid][DrugsAmount] + amount;
		dini_IntSet(udb_encode(copname2),"Drugs",pInfo[playerid][DrugsAmount]);
		pInfo[arrested2][DrugsAmount] = pInfo[arrested2][DrugsAmount] - amount;
		dini_IntSet(udb_encode(arrestedname2),"Drugs",pInfo[arrested2][DrugsAmount]);
        pInfo[arrested2][WantDrugs] = 0;
        format(checkstr,sizeof(checkstr),"You confiscated %d grams",amount);
        SendClientMessage(playerid,BBLUE,checkstr);
        format(checkstr,sizeof(checkstr),"You lost %d grams to the cop",amount);
        SendClientMessage(arrested2,COLOR_RED,checkstr);
		return 1;
		}
	SendClientMessage(playerid,BBLUE,"You cannot find or detect anything. This person is clean.");
	return 1;
	}
else
SendClientMessage(playerid,COLOR_YELLOW,"Although you would really like to play cop... You must be a cop and standing near a person to use this command!");
return 1;
}

//Function_setcity
if(strcmp(cmd,"/setcity",true)==0)
{
#pragma unused cmdtext
new string[255],pname[24],strresult1,strresult2,strresult3;


if (!strlen(cmdtext)){
	SendClientMessage(playerid,COLOR_GREY,"Usage: /setcity LS - To inform the script that you are playing in Los Santos");
	SendClientMessage(playerid,COLOR_GREY,"Usage: /setcity SF - To inform the script that you are playing in San Fierro");
	SendClientMessage(playerid,COLOR_GREY,"Usage: /setcity LV - To inform the script that you are playing in Las Venturas");
	SendClientMessage(playerid,COLOR_ORANGE,"It is strongly advised that you /Setcity after each city change IMMIDEATELY!");
	return 1;
	}

GetPlayerName(playerid,pname,sizeof(pname));
strmid(cmdtext,cmdtext,0,3,4);

strresult1 = strfind(cmdtext,"LS",true,0);
strresult2 = strfind(cmdtext,"SF",true,0);
strresult3 = strfind(cmdtext,"LV",true,0);

if (strresult1!=-1 && strresult2==-1 && strresult3==-1){
	pInfo[playerid][City] = 1;
	SendClientMessage(playerid,BBLUE,"You have set the city you are playing in to Los Santos.");
	SendClientMessage(playerid,COLOR_YELLOW,"When you want to play in another city /Setcity again.");
	format(string,sizeof(string),"[server] %s (ID %d) moved to %s",pname,playerid,cmdtext);
	printf("**** %s ****",string);
	WriteEcho(string);
	SendClientMessageToAll(BBLUE,string);
    return 1;
	}


if (strresult2!=-1 && strresult1==-1 && strresult3==-1){
	pInfo[playerid][City] = 2;
	SendClientMessage(playerid,BBLUE,"You have set the city you are playing in to San Fierro.");
	SendClientMessage(playerid,COLOR_YELLOW,"When you want to play in another city /Setcity again.");
	format(string,sizeof(string),"[server] %s (ID %d) has moved to %s",pname,playerid,cmdtext);
	printf("**** %s ****",string);
	WriteEcho(string);
	SendClientMessageToAll(BBLUE,string);
	return 1;
	}


if (strresult3!=-1 && strresult2==-1 && strresult1==-1){
	pInfo[playerid][City] = 3;
	SendClientMessage(playerid,BBLUE,"You have set the city you are playing in to Las Venturas.");
	SendClientMessage(playerid,COLOR_YELLOW,"When you want to play in another city /Setcity again.");
	format(string,sizeof(string),"[server] %s (ID %d) has moved to %s",pname,playerid,cmdtext);
	printf("**** %s ****",string);
	WriteEcho(string);
	SendClientMessageToAll(BBLUE,string);
	return 1;
	}

SendClientMessage(playerid,COLOR_RED,"Invalid city name.");
SendClientMessage(playerid,COLOR_YELLOW,"Valid city names: LS, SF, LV");
return 0;
}

//Function_jointeam
if(strcmp(cmd,"/jointeam",true)==0)
{
#pragma unused cmdtext
new string[255],pname[24],strresult,strresult2;


if (!strlen(cmdtext)){
	SendClientMessage(playerid,COLOR_GREY,"Usage: /jointeam [team ID]");
	SendClientMessage(playerid,COLOR_GREY,"Teams: 1 - Civilians | 2 - Seniors | 3 - Waiters | 4 - Criminals | 5 - Securities");
	SendClientMessage(playerid,COLOR_GREY,"6 - Pilots | 7 - Entertainers | 8 - Medics | 9 - Firemen | 10 - Cops");
	return 1;
	}

//if (!pInfo[playerid][GetSkin]){
//SendClientMessage(playerid,COLOR_RED,"/getskin not active. Do not use /jointeam without /getskin activated!");
//return 0;
//}

GetPlayerName(playerid,pname,sizeof(pname));
strmid(cmdtext,cmdtext,0,3,4);

strresult = strfind(cmdtext,"1",true,0);
strresult2 = strfind(cmdtext,"0",true,0);


if (strresult!=-1 && strresult2==-1){
	gTeam[playerid] = 1;
	pInfo[playerid][JoinTeam] = 1;
	SetPlayerToTeamColor(playerid);
	SetPlayerToSpawn(playerid);
	SpawnPlayer(playerid);
	SendClientMessage(playerid,BBLUE,"You have joined the Civilians team");
	SendClientMessage(playerid,COLOR_YELLOW,"When you want to play in another team /jointeam again.");
	format(string,sizeof(string),"[server] %s (ID %d) joined the Civilans Team",pname,playerid);
	printf("**** %s ****",string);
	WriteEcho(string);

    return 1;
	}

if (strresult!=-1 && strresult2!=-1){
	gTeam[playerid] = 10;
	pInfo[playerid][JoinTeam] = 1;
	SetPlayerToTeamColor(playerid);
	SetPlayerToSpawn(playerid);
	SpawnPlayer(playerid);
	SendClientMessage(playerid,BBLUE,"You have joined the Cops team");
	SendClientMessage(playerid,COLOR_YELLOW,"When you want to play in another team /jointeam again.");
	format(string,sizeof(string),"[server] %s (ID %d) joined the Cops Team",pname,playerid);
	printf("**** %s ****",string);
	WriteEcho(string);
    return 1;
	}

strresult = strfind(cmdtext,"2",true,0);

if (strresult!=-1 ){
	gTeam[playerid] = 2;
	pInfo[playerid][JoinTeam] = 1;
	SetPlayerToTeamColor(playerid);
	SetPlayerToSpawn(playerid);
	SpawnPlayer(playerid);
	SendClientMessage(playerid,BBLUE,"You have joined the Seniors team");
	SendClientMessage(playerid,COLOR_YELLOW,"When you want to play in another team /jointeam again.");
	format(string,sizeof(string),"[server] %s (ID %d) joined the Seniors Team",pname,playerid);
	printf("**** %s ****",string);
	WriteEcho(string);
    return 1;
	}

strresult = strfind(cmdtext,"3",true,0);

if (strresult!=-1 ){
	gTeam[playerid] = 3;
	pInfo[playerid][JoinTeam] = 1;
	SetPlayerToTeamColor(playerid);
	SetPlayerToSpawn(playerid);
	SpawnPlayer(playerid);
	SendClientMessage(playerid,BBLUE,"You have joined the Waiters team");
	SendClientMessage(playerid,COLOR_YELLOW,"When you want to play in another team /jointeam again.");
	format(string,sizeof(string),"[server] %s (ID %d) joined the Waiters Team",pname,playerid);
	printf("**** %s ****",string);
	WriteEcho(string);
	SetPlayerToTeamColor(playerid);
	SetPlayerToSpawn(playerid);
    return 1;
	}

strresult = strfind(cmdtext,"4",true,0);

if (strresult!=-1 ){
	gTeam[playerid] = 4;
	pInfo[playerid][JoinTeam] = 1;
	SetPlayerToTeamColor(playerid);
	SetPlayerToSpawn(playerid);
	SpawnPlayer(playerid);
	SendClientMessage(playerid,BBLUE,"You have joined the Criminals team");
	SendClientMessage(playerid,COLOR_YELLOW,"When you want to play in another team /jointeam again.");
	format(string,sizeof(string),"[server] %s (ID %d) joined the Criminals Team",pname,playerid);
	printf("**** %s ****",string);
	WriteEcho(string);
    return 1;
	}

strresult = strfind(cmdtext,"5",true,0);

if (strresult!=-1 ){
	gTeam[playerid] = 5;
	pInfo[playerid][JoinTeam] = 1;
	SetPlayerToTeamColor(playerid);
	SetPlayerToSpawn(playerid);
	SpawnPlayer(playerid);
	SendClientMessage(playerid,BBLUE,"You have joined the Securities team");
	SendClientMessage(playerid,COLOR_YELLOW,"When you want to play in another team /jointeam again.");
	format(string,sizeof(string),"[server] %s (ID %d) joined the Securities Team",pname,playerid);
	printf("**** %s ****",string);
	WriteEcho(string);
    return 1;
	}

strresult = strfind(cmdtext,"6",true,0);

if (strresult!=-1 ){
	gTeam[playerid] = 6;
	pInfo[playerid][JoinTeam] = 1;
	SetPlayerToTeamColor(playerid);
	SetPlayerToSpawn(playerid);
	SpawnPlayer(playerid);
	SendClientMessage(playerid,BBLUE,"You have joined the Pilots team");
	SendClientMessage(playerid,COLOR_YELLOW,"When you want to play in another team /jointeam again.");
	format(string,sizeof(string),"[server] %s (ID %d) joined the Pilots Team",pname,playerid);
	printf("**** %s ****",string);
	WriteEcho(string);
    return 1;
	}

strresult = strfind(cmdtext,"7",true,0);

if (strresult!=-1 ){
	gTeam[playerid] = 7;
	pInfo[playerid][JoinTeam] = 1;
	SetPlayerToTeamColor(playerid);
	SetPlayerToSpawn(playerid);
	SpawnPlayer(playerid);
	SendClientMessage(playerid,BBLUE,"You have joined the Entertainers team");
	SendClientMessage(playerid,COLOR_YELLOW,"When you want to play in another team /jointeam again.");
	format(string,sizeof(string),"[server] %s (ID %d) joined the Entertainers Team",pname,playerid);
	printf("**** %s ****",string);
	WriteEcho(string);
    return 1;
	}

strresult = strfind(cmdtext,"8",true,0);

if (strresult!=-1 ){
	gTeam[playerid] = 8;
	pInfo[playerid][JoinTeam] = 1;
	SetPlayerToTeamColor(playerid);
	SetPlayerToSpawn(playerid);
	SpawnPlayer(playerid);
	SendClientMessage(playerid,BBLUE,"You have joined the Medics team");
	SendClientMessage(playerid,COLOR_YELLOW,"When you want to play in another team /jointeam again.");
	format(string,sizeof(string),"[server] %s (ID %d) joined the Medics Team",pname,playerid);
	printf("**** %s ****",string);
	WriteEcho(string);
    return 1;
	}

strresult = strfind(cmdtext,"9",true,0);

if (strresult!=-1 ){
	gTeam[playerid] = 9;
	pInfo[playerid][JoinTeam] = 1;
	SetPlayerToTeamColor(playerid);
	SetPlayerToSpawn(playerid);
	SpawnPlayer(playerid);
	SendClientMessage(playerid,BBLUE,"You have joined the Firemen team");
	SendClientMessage(playerid,COLOR_YELLOW,"When you want to play in another team /jointeam again.");
	format(string,sizeof(string),"[server] %s (ID %d) joined the Firemen Team",pname,playerid);
	printf("**** %s ****",string);
	WriteEcho(string);
    return 1;
	}


SendClientMessage(playerid,COLOR_RED,"Invalid team ID.");
SendClientMessage(playerid,COLOR_YELLOW,"Valid team IDs: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10");
return 0;
}

//Function_deposit
if(strcmp(cmd,"/deposit",true)==0)
{
#pragma unused cmdtext
	new string[120],donator[24],balance;

	GetPlayerName(playerid,donator,sizeof(donator));

	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /deposit [amount of $]");
	    SendClientMessage(playerid,COLOR_GREY,"E.g. '/deposit 100' puts 100$ form your pocket in your bank account.");
   	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /deposit -[amount of $]");
   	    SendClientMessage(playerid,COLOR_GREY,"E.g. '/deposit -100' puts 100$ from your bank account in your pocket.");
		return 0;
		}

 	new amount=strval(cmdtext);
	new aviablemoney=GetPlayerMoney(playerid);

   	if(amount>aviablemoney){
    SendClientMessage(playerid,COLOR_RED,"You do not have that much money. :P");
	return 1;
 	}
format(string, sizeof (string), "DEBUG: Amount: %d$ - Balance: %d$.",amount,balance);
SendClientMessageToAll(COLOR_WHITE,string);

	if (amount < 0 && -amount > balance){
	SendClientMessage(playerid,COLOR_RED,"You cannot withdraw more than you have!");
	return 1;
	}

format(string, sizeof (string), "%s used /DEPOSIT to bank %d$",donator,amount);
print(string);
GivePlayerMoney(playerid,-amount);
GivePlayerBankMoney(playerid,amount);
balance = strval(dini_Get(udb_encode(donator),"Bank"));

format(string, sizeof (string), "You transfered %d$ to your bank account. Your new balance is %d$.",amount,balance);
SendClientMessage(playerid,COLOR_YELLOW,string);
return 1;
}

//Function_balance
if(strcmp(cmd,"/balance",true)==0)
{
#pragma unused cmdtext
new string[120],donator[24],balance;

GetPlayerName(playerid,donator,sizeof(donator));
balance = strval(dini_Get(udb_encode(donator),"Bank"));
format(string, sizeof (string), "Your bank account balance is %d$.",balance);
SendClientMessage(playerid,COLOR_YELLOW,string);
return 1;
}

//Function_cuff
if(strcmp(cmd,"/cuff",true)==0)
{
#pragma unused cmdtext
new teamcops1,teamarrested1,copname1[24],cuffstr[120],arrested1,arrestedname1[24];
teamcops1=GetPlayerTeam(playerid);
arrested1=strval(cmdtext);
teamarrested1=GetPlayerTeam(arrested1);
GetPlayerName(playerid,copname1,sizeof(copname1));
	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /cuff [ID]");
		return 1;
	}

	if (teamcops1==TEAM_COPS){
	    if(IsPlayerConnected(arrested1) && GetDistanceBetweenPlayers(playerid,arrested1) <= 5){
  		GetPlayerName(arrested1,arrestedname1,sizeof(arrestedname1));
		format(cuffstr,sizeof(cuffstr),"[server] Officer %s (ID %d) cuffed %s (ID %d)",copname1,playerid,arrestedname1,arrested1);
		print(cuffstr);
		WriteEcho(cuffstr);
       	pInfo[arrested1][Cuffed] = 1;
       	    if (teamarrested1==TEAM_COPS){
       	    pInfo[arrested1][Jailed] = 0;
       	    pInfo[arrested1][Jailable] = 1;
       	    SendClientMessage(playerid,BBLUE,"You catched a cop who lost his badge.");
       	    SendClientMessage(playerid,COLOR_RED,"You can /sue him immediately.");
       	    }
       	TogglePlayerControllable(arrested1,false);
       	currentlyCuffed[arrested1] = SetTimer("TimerUncuff",86658,0); // 2 minutes and 10 seconds to uncuff your hands.
       	SendClientMessage(arrested1,COLOR_RED,"A cop cuffed your hands and feet.");
       	SendClientMessage(arrested1,COLOR_LIGHTGREEN,"You try to get your hands free and uncuff yourself...");
       	SendClientMessage(arrested1,COLOR_LIGHTGREEN,"That takes a while [Around 2 minutes]. Dont let the cop see you trying!");
       	SendClientMessage(playerid,COLOR_RED,"You cuffed a criminal. Guard him for 2 minutes and /check his status.");
       	SendClientMessage(playerid,COLOR_LIGHTGREEN,"This old handcuffs are not the best quality...");
       	SendClientMessage(playerid,COLOR_LIGHTGREEN,"Why has the police budget to be so low...!?");
		}
	else
    SendClientMessage(playerid,COLOR_RED,"The person you want to cuff is offline or too far away.");
	return 1;
	}
else
SendClientMessage(playerid,BBLUE,"A bypassing afro-american civilian says:");
SendClientMessage(playerid,COLOR_WHITE,"Yo aint a cop, foooooool! :P");
return 1;
}

//Function_heal
if(strcmp(cmd,"/heal",true)==0)
{
#pragma unused cmdtext
//gTeam[playerid]==TEAM_MEDICS
new teammed,medname[24],healstr[120],healguy,healname[24];
new Float:health,health2,health3;

teammed=GetPlayerTeam(playerid);
healguy=strval(cmdtext);
GetPlayerName(playerid,medname,sizeof(medname));
	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /heal [ID]");
		return 1;
	}

	if (teammed==TEAM_MEDICS){
	    if(IsPlayerConnected(healguy) && GetDistanceBetweenPlayers(playerid,healguy) <= 5){
  		GetPlayerName(healguy,healname,sizeof(healname));
		format(healstr,sizeof(healstr),"[server] Medic %s (ID %d) used /HEAL on %s (ID %d)",medname,playerid,healname,healguy);
		print(healstr);
		WriteEcho(healstr);
       	GetPlayerHealth(healguy,health);
       	health2 = floatround(health,floatround_floor);
       	if (health2>=90){
       		SendClientMessage(playerid,COLOR_RED,"This guy has only a few scratches. No need to /heal");
       		return 1;
       		}
       	health3 = health2 + 10;
       	SetPlayerHealth(healguy,health3);
		format(healstr,sizeof(healstr),"You gave %s + 10 health. His current health is %d%",healname,health3);
       	SendClientMessage(playerid,COLOR_LIGHTGREEN,healstr);
       	format(healstr,sizeof(healstr),"You feel refreshed. Your health went from %d% to %d%.",health2,health3);
       	SendClientMessage(healguy,BBLUE,healstr);
       	SendClientMessage(healguy,COLOR_RED,"Don't forget to /pay the medic!!!");
       	return 1;
        }
	else
    SendClientMessage(playerid,COLOR_RED,"The person you want to heal is offline or too far away.");
	return 1;
	}
else
SendClientMessage(playerid,BBLUE,"You find out you dont have medic's equipment.");
SendClientMessage(playerid,COLOR_YELLOW,"You need to be in the medic role to /heal people");
return 1;
}

//Function_check
if(strcmp(cmd,"/check",true)==0)
{
#pragma unused cmdtext
new teamcops2,copname2[24],checkstr[120],HQstr[120],arrested2,arrestedname2[24];
teamcops2=GetPlayerTeam(playerid);
arrested2=strval(cmdtext);
GetPlayerName(playerid,copname2,sizeof(copname2));
	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /check [ID]");
		return 1;
	}

	if (teamcops2==TEAM_COPS){
	    if(IsPlayerConnected(arrested2) && pInfo[arrested2][Cuffed]){
		GetPlayerName(arrested2,arrestedname2,sizeof(arrestedname2));
		format(checkstr,sizeof(checkstr),"[server] Officer %s (ID %d) checks the status of %s (ID %d)",copname2,playerid,arrestedname2,arrested2);
		print(checkstr);
		WriteEcho(checkstr);
        SendClientMessage(arrested2,COLOR_RED,"The cop gets out his mobile to check your status. Hurry!");
        SendClientMessage(arrested2,COLOR_LIGHTGREEN,"Once he found out you are wanted...");
        SendClientMessage(arrested2,COLOR_LIGHTGREEN,"...you will be going straight to jail...");
        SendClientMessage(playerid,BBLUE,"You get out your mobile radio to contact HQ");
		format(HQstr,sizeof(HQstr),"(Radio) You: This is Unit %d, I need a check on the wanted status of a certain %s",playerid,arrestedname2);
		SendClientMessage(playerid,COLOR_WHITE,HQstr);
        SendClientMessage(playerid,COLOR_WHITE,"(Radio) HQ: This is HQ. We are processing your check. Standby 2 minutes...");
		SetTimer("TimerCheck",79992,0); // 2 minutes for HQ to process a check.
		return 1;
		}
	else
    SendClientMessage(playerid,COLOR_RED,"The ID you want to check is not online or not cuffed.");
	return 1;
	}
else
SendClientMessage(playerid,BBLUE,"You get your mobile radio out to call HQ");
SendClientMessage(playerid,BBLUE,"You find out you dont have such a mobile radio. You are not a cop.");
return 1;
}

//Function_suspect
if(strcmp(cmd,"/suspect",true)==0)
{
#pragma unused cmdtext
new teamcops2,copname2[24],checkstr[120],HQstr[120],arrested2,arrestedname2[24];
teamcops2=GetPlayerTeam(playerid);
arrested2=strval(cmdtext);
GetPlayerName(playerid,copname2,sizeof(copname2));
	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /su [ID]");
		return 1;
	}

	if (teamcops2==TEAM_COPS){
	    if(IsPlayerConnected(arrested2) && pInfo[arrested2][WantedLevel] == 0){
		GetPlayerName(arrested2,arrestedname2,sizeof(arrestedname2));
		format(checkstr,sizeof(checkstr),"[server] Officer %s (ID %d) suspects %s (ID %d) of crime",copname2,playerid,arrestedname2,arrested2);
		print(checkstr);
		WriteEcho(checkstr);
        SendClientMessage(arrested2,COLOR_RED,"An officer suspects you of crime - You are now Wanted Level 1.");
        pInfo[arrested2][WantedLevel] = 1 ;
        SetPlayerWantedLevel(arrested2,1);
		format(HQstr,sizeof(HQstr),"Suspect %s is now wanted",arrestedname2);
		SendClientMessage(playerid,BBLUE,HQstr);
        return 1;
		}
	else
    SendClientMessage(playerid,COLOR_RED,"This player cannot be suspected to be criminal.");
	return 1;
	}
else
SendClientMessage(playerid,BBLUE,"You get your mobile radio out to call HQ");
SendClientMessage(playerid,BBLUE,"You find out you dont have such a mobile radio. You are not a cop.");
return 1;
}

//Function_gta
if(strcmp(cmd,"/gta",true)==0)
{
#pragma unused cmdtext
new teamcops2,copname2[24],checkstr[120],HQstr[120],arrested2,arrestedname2[24];
teamcops2=GetPlayerTeam(playerid);
arrested2=strval(cmdtext);
GetPlayerName(playerid,copname2,sizeof(copname2));
	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /gta [ID]");
		return 1;
	}

	if (teamcops2==TEAM_CRIMINALS){
	    if(IsPlayerConnected(arrested2) && pInfo[arrested2][vehicle] != 0){
		GetPlayerName(arrested2,arrestedname2,sizeof(arrestedname2));
		format(checkstr,sizeof(checkstr),"[server] Criminal %s (ID %d) tries to picklock %s (ID %d) car",copname2,playerid,arrestedname2,arrested2);
		print(checkstr);
		WriteEcho(checkstr);
        SendClientMessage(arrested2,COLOR_RED,"Someone tries to steal your car!!!!!!!");
        SendClientMessage(arrested2,COLOR_RED,"Use '/911 cops car theft [location of your car]' to inform the police");
        pInfo[playerid][AddWanted] = 1 ;
        pInfo[playerid][GTA] = pInfo[arrested2][vehicle];
        TogglePlayerControllable(playerid,false);
		format(HQstr,sizeof(HQstr),"You are picklocking %s car. This requires around 5 minutes.",arrestedname2);
		SendClientMessage(playerid,BBLUE,HQstr);
		SendClientMessage(playerid,COLOR_YELLOW,"During that time, you cannot move because you are busy picklocking. '/exit' to abort.");
		SetTimer("GTATimer",300000,0);
        return 1;
		}
	else
    SendClientMessage(playerid,COLOR_RED,"This player does not own a stealable private car.");
	return 1;
	}
else
SendClientMessage(playerid,COLOR_RED,"You dont have a picklock or picklocking skills. You are not a criminal.");
return 1;
}

//Function_sue
if(strcmp(cmd,"/sue",true)==0)
{
#pragma unused cmdtext
new copname3[24],jailstr[120],HQstr[120],arrested3,arrestedname3[24],Reward;

arrested3=strval(cmdtext);
GetPlayerName(playerid,copname3,sizeof(copname3));
GetPlayerName(arrested3,arrestedname3,sizeof(arrestedname3));
Reward = pInfo[arrested3][WantedLevel] * 1000;

	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /sue [ID]");
		return 1;
	}

	if (pInfo[arrested3][Jailed]){
	SendClientMessage(playerid,COLOR_RED,"This player is already sued or a cop who lost his badge");
	return 1;
	}
		if(IsPlayerConnected(arrested3) && pInfo[arrested3][Jailable] && GetDistanceBetweenPlayers(playerid,arrested3) <= 5){
		format(jailstr,sizeof(jailstr),"[server] Player %s (ID %d) has sued criminal %s (ID %d) (Reward %d$)",copname3,playerid,arrestedname3,arrested3,Reward);
		print(jailstr);
		WriteEcho(jailstr);
        SendClientMessage(arrested3,BBLUE,"The guy sues you and brings you to court.");
		pInfo[arrested3][Cuffed] = 1;
		KillTimer(currentlyCuffed[arrested3]);
		pInfo[arrested3][Jailed] = 0;

		SetPlayerInterior(playerid,10);
  		SetPlayerPos(playerid,264.0,109.0,1009.0);
		SetPlayerFacingAngle(playerid,98.0);
		SetCameraBehindPlayer(playerid);
		SendClientMessage(playerid,BBLUE,"You are the judge, decide '/guilty yes' or '/guilty no' after listening to suspect and lawyer.");
		CurrentJudge = playerid;

		SetPlayerInterior(arrested3,10);
  		SetPlayerPos(arrested3,263.0,111.0,1009.0);
		SetPlayerFacingAngle(arrested3,209.0);
		SetCameraBehindPlayer(arrested3);
  		TogglePlayerControllable(arrested3,false);
		SendClientMessage(arrested3,BBLUE,"You are at the court, a lawyer may come and defend you!");
		CurrentCase = arrested3;
		SendClientMessageToAll(BBLUE,jailstr);
		SendClientMessageToAll(COLOR_ORANGE,"A court session is about to start. Type /visit or /lawyer to attend it!");

        if (arrested3 == playerid){
 	    SendClientMessage(playerid,COLOR_RED,"You do not get paid for sueing yourself.");
 	    SetPlayerToSpawn(playerid);
 	    return 1;
 	    }

		GivePlayerMoney(playerid,Reward);
		format(HQstr,sizeof(HQstr),"(Radio) You: This is Unit %d, I sued the wanted criminal %s and bring him to court",playerid,arrestedname3);
		SendClientMessage(playerid,COLOR_WHITE,HQstr);
		format(jailstr,sizeof(jailstr),"(Radio) HQ: This is HQ. Good work. We transfered a %d$ bonus to your account.",Reward);
        SendClientMessage(playerid,COLOR_WHITE,jailstr);
		return 1;
		}
	else
    SendClientMessage(playerid,COLOR_RED,"The player you want to sue is not online,not wanted, or too far away.");
	SendClientMessage(arrested3,COLOR_LIGHTGREEN,"You are now free to go.");
	if (GetDistanceBetweenPlayers(playerid,arrested3) >5){
  	SendClientMessage(playerid,COLOR_RED,"The player you want to sue is too far away.");
	return 1;
 	}
  	else
pInfo[arrested3][Cuffed] = 0;
KillTimer(currentlyCuffed[arrested3]);
SendClientMessage(arrested3,BBLUE,"The guy lets you go.");
SendClientMessage(arrested3,COLOR_WHITE,"Guy: Sorry sir, my mistake. Take this for the lost time.");
SendClientMessage(arrested3,BBLUE,"The guy hands you 100$ to make you forget what happened");
SendClientMessage(playerid,BBLUE,"Your face becomes all red.");
SendClientMessage(playerid,COLOR_WHITE,"You: Sorry sir, my mistake. Take this for the lost time.");
SendClientMessage(playerid,BBLUE,"You hand him 100$ and ask him not to tell anyone about the mistake you did.");
GivePlayerMoney(playerid,-100);
GivePlayerMoney(arrested3,100);
TogglePlayerControllable(arrested3,true);
return 1;
}

//Function_guilty
if(strcmp(cmd,"/guilty",true)==0)
{
#pragma unused cmdtext
new string[255],judgename[24],lawyername[24],casename[24],strresult1,strresult2;


if (!strlen(cmdtext)){
	SendClientMessage(playerid,COLOR_GREY,"Usage: /guilty no - Everyone is free and goes home.");
	SendClientMessage(playerid,COLOR_GREY,"Usage: /guilty yes - Suspect goes to jail for 3 minutes.");
	return 1;
	}

if (CurrentJudge != playerid) return 0;


GetPlayerName(CurrentJudge,judgename,sizeof(judgename));
GetPlayerName(CurrentCase,casename,sizeof(casename));
GetPlayerName(CurrentLawyer,lawyername,sizeof(lawyername));

strmid(cmdtext,cmdtext,0,2,3);

strresult1 = strfind(cmdtext,"y",true,0);
strresult2 = strfind(cmdtext,"n",true,0);


if (strresult1!=-1){

	SendClientMessage(CurrentJudge,BBLUE,"You have decided GUILTY and sent the suspect to jail.");
	SetPlayerInterior(CurrentJudge,0);
	SetPlayerPos(CurrentJudge,1481.000,-1767.0000,19.0000);
	SetPlayerFacingAngle(CurrentJudge,0.000);
	SetCameraBehindPlayer(CurrentJudge);
	SendClientMessage(CurrentJudge,BBLUE,"You are outside the court house.");
	SendClientMessage(CurrentJudge,BBLUE,"Use /back to get back to where you sued the suspect.");
	CurrentJudge = -1;

	SendClientMessage(CurrentLawyer,BBLUE,"The judge has sent your client to jail and you failed.");
	SetPlayerInterior(CurrentLawyer,0);
	SetPlayerPos(CurrentLawyer,1481.000,-1767.0000,19.0000);
	SetPlayerFacingAngle(CurrentLawyer,0.0000);
	SetCameraBehindPlayer(CurrentLawyer);
	SendClientMessage(CurrentLawyer,BBLUE,"You are outside the court house.");
	SendClientMessage(CurrentLawyer,BBLUE,"Use /jail to get ur client to /pay you, /back and /taxi to get to your office.");


	SendClientMessage(CurrentCase,BBLUE,"The judge has sent you to jail.");
	pInfo[CurrentCase][Cuffed] = 0;
	KillTimer(currentlyCuffed[CurrentCase]);
	pInfo[CurrentCase][Jailed] = 1;
	SetPlayerInterior(CurrentCase,3);
	SetPlayerPos(CurrentCase,198.5,162.5,1003.0);
	SetPlayerFacingAngle(CurrentCase,180.0);
	SetCameraBehindPlayer(CurrentCase);
	PlayerPlaySound(CurrentCase,1068,198.5,162.5,1003.0);
	SetTimer("TimerJail",180000,0); //Jailtime 3 minutes, then: Release.
	TogglePlayerControllable(CurrentCase,true);
	SendClientMessage(CurrentCase,BBLUE,"A short time later, you find yourself in the jail");
	CurrentCase = -1;

	if (CurrentLawyer == -1) format(string,sizeof(string),"[server] COURT SESSION OVER: Judge %s sent suspect %s to jail.",judgename,casename);

	if (CurrentLawyer != -1) format(string,sizeof(string),"[server] COURT SESSION OVER: Judge %s sent suspect %s to jail. Lawyer %s is depressed.",judgename,casename,lawyername);
	print(string);
	CurrentLawyer = -1;
	WriteEcho(string);
	SendClientMessageToAll(COLOR_ORANGE,string);
	return 1;
	}

if (strresult2!=-1){
	SendClientMessage(CurrentJudge,BBLUE,"You have decided NOT GUILTY and sent the suspect to freedom.");
	SetPlayerInterior(CurrentJudge,0);
	SetPlayerPos(CurrentJudge,1481.000,-1767.0000,19.0000);
	SetPlayerFacingAngle(CurrentJudge,0.000);
	SetCameraBehindPlayer(CurrentJudge);
	SendClientMessage(CurrentJudge,BBLUE,"You are outside the court house.");
	SendClientMessage(CurrentJudge,BBLUE,"Use /back to get back to where you sued the suspect.");
	CurrentJudge = -1;

	SendClientMessage(CurrentLawyer,BBLUE,"The judge has decided not guilty - you succeeded.");
	SetPlayerInterior(CurrentLawyer,0);
	SetPlayerPos(CurrentLawyer,1481.000,-1767.0000,19.0000);
	SetPlayerFacingAngle(CurrentLawyer,0.0000);
	SetCameraBehindPlayer(CurrentLawyer);
	SendClientMessage(CurrentLawyer,BBLUE,"You are outside the court house.");
	SendClientMessage(CurrentLawyer,BBLUE,"Use /taxi to get to your office.");


	SendClientMessage(CurrentCase,BBLUE,"The judge grants you your freedom.");
	pInfo[CurrentCase][Cuffed] = 0;
	KillTimer(currentlyCuffed[CurrentCase]);
	pInfo[CurrentCase][Jailed] = 0;
 	SetPlayerInterior(CurrentCase,0);
	SetPlayerPos(CurrentCase,1481.000,-1767.0000,19.0000);
	SetPlayerFacingAngle(CurrentCase,0.000);
	SetCameraBehindPlayer(CurrentCase);
 	TogglePlayerControllable(CurrentCase,true);
	SendClientMessage(CurrentCase,BBLUE,"You are outside the court house.");
	SendClientMessage(CurrentCase,BBLUE,"Use /taxi to get home or wherever. DONT FORGET TO /PAY YOUR LAWYER!");
	CurrentCase = -1;

	if (CurrentLawyer == -1) format(string,sizeof(string),"[server] COURT SESSION OVER: Judge %s decided that %s is not guilty.",judgename,casename);

	if (CurrentLawyer != -1) format(string,sizeof(string),"[server] COURT SESSION OVER: Judge %s decided that %s is not guilty. Lawyer %s is endlessly happy.",judgename,casename,lawyername);
	CurrentLawyer = -1;
	print(string);
	WriteEcho(string);
	SendClientMessageToAll(COLOR_ORANGE,string);
	return 1;
	}

return 1;
}


//Function_bail
if(strcmp(cmd,"/bail",true)==0)
{
#pragma unused cmdtext
new string[255],sub[6],amount,callername[24],strresult,aviablemoney;


if (!strlen(cmdtext)){
	SendClientMessage(playerid,COLOR_GREY,"Usage: /bail yes");
	SendClientMessage(playerid,COLOR_GREY,"The bail height depends on the wanted level you had before.");
	amount = pInfo[playerid][WantedLevel] * 1000;
	format(string,sizeof(string),"Your bail is %d$. Enter '/bail yes' to pay it and be unjailed.",amount);
	SendClientMessage(playerid,COLOR_RED,string);
	return 1;
	}
GetPlayerName(playerid,callername,sizeof(callername));

if (pInfo[playerid][WantedLevel] == 0){
	SendClientMessage(playerid,COLOR_RED,"You did not commit any crimes - no need to go to jail and pay a bail.");
	return 0;
	}

if (!pInfo[playerid][Jailed]){
	SendClientMessage(playerid,COLOR_RED,"No point in paying a bail when you are not jailed!");
	return 0;
	}

strmid(sub,cmdtext,0,5,6);
strmid(cmdtext,cmdtext,5,255,250);
strresult = strfind(sub,"yes",true,0);
if (strresult!=-1){
	amount = pInfo[playerid][WantedLevel] * 1000;

	aviablemoney = GetPlayerMoney(playerid);

 		if(amount>aviablemoney){
 	    SendClientMessage(playerid,COLOR_RED,"You do not have that much money. :P");
		return 1;
 		}

	GivePlayerMoney(playerid, -amount);
	pInfo[playerid][Jailed] = 0;
	pInfo[playerid][WantedLevel] = 0;
	SetPlayerWantedLevel(playerid,0);
	TogglePlayerControllable(playerid,true);
	GameTextForPlayer(playerid,"You paid your bail and are free.",3333,5);
	SetPlayerInterior(playerid,0);
	SetPlayerPos(playerid,1551.0000,-1676.0000,16.0000);
	SetPlayerFacingAngle(playerid,87.0);
	PlayerPlaySound(playerid,1069,1551.0000,-1676.0000,16.0000);
    return 1;
	}
SendClientMessage(playerid,COLOR_GREY,"Usage: /bail yes");
SendClientMessage(playerid,COLOR_GREY,"The bail height depends on the wanted level you had before.");
amount = pInfo[playerid][WantedLevel] * 1000;
format(string,sizeof(string),"Your bail is %d$. Enter '/bail yes' to pay it and be unjailed.",amount);
SendClientMessage(playerid,COLOR_RED,string);
return 0;
}

//Function_buy
if(strcmp(cmd,"/buy",true)==0)
{
#pragma unused cmdtext
new string[120],pname[24],strresult,aviablemoney;


if (!strlen(cmdtext)){
	SendClientMessage(playerid,COLOR_GREY,"Usage: /buy yes");
	SendClientMessage(playerid,COLOR_GREY,"Every car costs 7.500$");
		return 1;
	}


strmid(cmdtext,cmdtext,0,5,6);
strresult = strfind(cmdtext,"yes",true,0);

if (pInfo[playerid][invehicle] < 19 || pInfo[playerid][invehicle] > 127){
	SendClientMessage(playerid,COLOR_RED,"You cannot buy stock cars");
	return 0;
	}

aviablemoney = GetPlayerMoney(playerid);

 		if(7500>aviablemoney){
 	    SendClientMessage(playerid,COLOR_RED,"You do not have that much money. :P");
		return 1;
 		}

if (strresult!=-1){
	GetPlayerName(playerid,pname,sizeof(pname));
	pInfo[playerid][buytimer] = 0;
	TogglePlayerControllable(playerid,true);
	GivePlayerMoney(playerid, -7500);
	pInfo[playerid][vehicle] = pInfo[playerid][invehicle];
	GameTextForPlayer(playerid,"~g~ You have bought this car.",3333,5);
	format(string,sizeof(string),"[server] %s has bought a vehicle (Vehicle ID %d)",pname,pInfo[playerid][invehicle]);
	print (string);
	WriteEcho(string);
	return 1;
	}
return 0;
}

//Function_exit
if(strcmp(cmd,"/exit",true)==0)
{
#pragma unused cmdtext

if (pInfo[playerid][Cuffed]) return 0;

if (IsPlayerInAnyVehicle(playerid)){
RemovePlayerFromVehicle(playerid);
}
pInfo[playerid][buytimer] = 0;
pInfo[playerid][driver] = 0;

if (pInfo[playerid][GTA] != 0){
pInfo[playerid][GTA] = 0;
SendClientMessage(playerid,COLOR_RED,"You aborted your try to picklock the car.");
}

TogglePlayerControllable(playerid,true);
return 1;
}


//Function_wanted
//pInfo[playerid][isPassenger]
if(strcmp(cmd,"/wanted",true)==0)
{
#pragma unused cmdtext
new wantedname[24],wantedstr[120],reqteam;
reqteam = GetPlayerTeam(playerid);
if (reqteam!=TEAM_COPS){
SendClientMessage(playerid,COLOR_ORANGE,"----WANTED LIST----");
for(new f=0; f<MAX_PLAYERS; f++){
if(IsPlayerConnected(f)){
	if (pInfo[f][WantedLevel] >= 1){
		GetPlayerName(f,wantedname,sizeof(wantedname));
		format(wantedstr,sizeof(wantedstr),"%s (ID %d) [Level %d]",wantedname,f,pInfo[f][WantedLevel]);
		SendClientMessage(playerid,COLOR_WHITE,wantedstr);
		}
}
}
SendClientMessage(playerid,COLOR_ORANGE,"----END OF LIST----");
return 1;
}
else
SendClientMessage(playerid,COLOR_RED,"Cops use /check [ID] not /wanted!");
return 1;
}

//Function_bookings
if(strcmp(cmd,"/bookings",true)==0)
{
#pragma unused cmdtext
new wantedname[24],wantedstr[120],reqteam;
reqteam = GetPlayerTeam(playerid);
if (reqteam==TEAM_PILOTS){
SendClientMessage(playerid,COLOR_ORANGE,"----FLIGHT BOOKINGS----");
for(new f=0; f<MAX_PLAYERS; f++){
if(IsPlayerConnected(f)){
	if (pInfo[f][isPassenger] == 1){
		GetPlayerName(f,wantedname,sizeof(wantedname));
		format(wantedstr,sizeof(wantedstr),"%s (ID %d) [City ID %d]",wantedname,f,pInfo[f][City]);
		SendClientMessage(playerid,COLOR_WHITE,wantedstr);
		}
}
}
SendClientMessage(playerid,COLOR_ORANGE,"----END OF LIST----");
return 1;
}
else
SendClientMessage(playerid,COLOR_RED,"Only pilots have insight into the booking list");
return 1;
}

//Function_cophelp
if(strcmp(cmd,"/cophelp",true)==0)
{
	#pragma unused cmdtext
    SendClientMessage(playerid,COLOR_YELLOW,"Pure RPG - Cop Role Help");
    SendClientMessage(playerid,COLOR_ORANGE,"To work as cop properly and not lose your badge, do the following.");
    SendClientMessage(playerid,COLOR_WHITE,"1) Make people stop (RPG or shooting, not killing).");
    SendClientMessage(playerid,COLOR_WHITE,"2) Use /cuff [ID] near them [less than 5 metres].");
    SendClientMessage(playerid,COLOR_WHITE,"3) Use /check [ID] near a cuffed person. WAIT FOR THE CHECK TO BE FINISHED. IT TAKES 2 MINUTES!");
    SendClientMessage(playerid,COLOR_WHITE,"4) Use /sue [ID] near the cuffed person [less than 5 metres].");
    SendClientMessage(playerid,COLOR_WHITE,"/suspect [ID] - Sets a player suspect and wanted level 1");
    SendClientMessage(playerid,COLOR_WHITE,"/fine [ID] [amount] - Force the other player to pay an amount between 1$ and 500$");
    SendClientMessage(playerid,COLOR_WHITE,"/drugtest [ID] - Checks if the person nearby consumed or posseses drugs");
    SendClientMessage(playerid,COLOR_WHITE,"/backup - Requests backup for you and sets a checkpoint at where you are for your collegues");
    return 1;
}

//Function_courthelp
if(strcmp(cmd,"/courthelp",true)==0)
{
	#pragma unused cmdtext
    SendClientMessage(playerid,COLOR_YELLOW,"Pure RPG - Court Help");
    SendClientMessage(playerid,COLOR_RED,"Only cuffed and checked people can be sued to go to jail.");
    SendClientMessage(playerid,COLOR_ORANGE,"This is basically how teh court system works:");
    SendClientMessage(playerid,COLOR_WHITE,"1) /sue [ID] - Brings a sueable person ( = cuffed & checked) and yourself to court");
    SendClientMessage(playerid,COLOR_WHITE,"/lawyer - gets the first licensed lawyer to be the lawyer");
    SendClientMessage(playerid,COLOR_WHITE,"2) Bring forward your case, listen to suspect and lawyer");
    SendClientMessage(playerid,COLOR_WHITE,"3) Use /guilty yes --> The suspect goes to jail, you and the lawyer go home");
    SendClientMessage(playerid,COLOR_WHITE,"4) OR Use /guilty no --> The suspect is free, the lawyer and you go home");
    SendClientMessage(playerid,COLOR_RED,"Always hear the suspect and his/her lawyer. Decide fair and according to the law.");
    SendClientMessage(playerid,COLOR_RED,"Do not abuse your right as judge!!!!!!");
    return 1;
}

//Function_ah
if(strcmp(cmd,"/ah",true)==0)
{
	#pragma unused cmdtext
    SendClientMessage(playerid,COLOR_YELLOW,"Pure RPG - Admin Help");
    SendClientMessage(playerid,COLOR_WHITE,"[2] /stats [ID] - gets info about a player such as amount of money.");
    SendClientMessage(playerid,COLOR_WHITE,"[2] /(un)mute [ID] - allows/disallows a player to speak in stock and local chat.");
    SendClientMessage(playerid,COLOR_WHITE,"[5] /(un)block ([Account Name])[ID] - (un)blocks an account (CASE SENSITIVE!) so it cannot be used no more (NOT an IP ban)");
    SendClientMessage(playerid,COLOR_WHITE,"[5] /setpocket(/setbank) [ID] [amount of $$$] - sets and saves the pocket money (or bank account balance) of a player.");
    SendClientMessage(playerid,COLOR_WHITE,"[5] /respawnall - Respawns all (!) vehicles on the server.");
    SendClientMessage(playerid,COLOR_WHITE,"[10] /unwanted [ID] - sets the player's wanted level to 0.");
    SendClientMessage(playerid,COLOR_WHITE,"[10] /savespawn [ID] - Save the position the player is currently at as his spawn location");
    SendClientMessage(playerid,COLOR_WHITE,"[10] /setcar(/setweather) [ID] - sets and saves the car the player currently is in as his car constantly. (Sets the server weather)");
    SendClientMessage(playerid,COLOR_ORANGE,"More commands at /xcommands. Work responsibly as admin. Abuse gets you your rights taken away.");
    return 1;
}

//Function_sell
if(strcmp(cmd,"/sell",true)==0)
{
#pragma unused cmdtext
new string[129],pname[24];

if (pInfo[playerid][fuel] <= 10) pInfo[playerid][fuel] = 10;

if (pInfo[playerid][vehicle]!=0){
GetPlayerName(playerid,pname,sizeof(pname));
GivePlayerMoney(playerid,5000);
format(string,sizeof(string),"[server] %s has sold a vehicle (Vehicle ID %d)",pname,pInfo[playerid][vehicle]);
pInfo[playerid][vehicle] = 0;
print (string);
WriteEcho(string);
SendClientMessage(playerid,BBLUE,"You have sold your vehicle for 5.000. Anyone can aquire it now.");
SendClientMessage(playerid,COLOR_RED,"You can get additional money for your vehicle asking a buyer to /pay you.");
return 1;
}
SendClientMessage(playerid,COLOR_RED,"You dont own a vehicle. :( Nothing to sell.");
return 1;
}

//Function_find
if(strcmp(cmd,"/find",true)==0)
{
#pragma unused cmdtext
if (pInfo[playerid][vehicle]!=0){
new Float:coorX;
new Float:coorY;
new Float:coorZ;

if (pInfo[playerid][fuel] <= 10) pInfo[playerid][fuel] = 10;

coorX = pInfo[playerid][FindX];
coorY = pInfo[playerid][FindY];
coorZ = pInfo[playerid][FindZ];
SetPlayerCheckpoint(playerid,coorX,coorY,coorZ,2.0);
SendClientMessage(playerid,BBLUE,"A checkpoint is on your radar where you parked your car.");
SendClientMessage(playerid,COLOR_RED,"Go to the red checkpoint, your vehicle will be there.");
SendClientMessage(playerid,COLOR_YELLOW,"It may have respawned meanwhile though. Order a /taxi to where you bought it.");
return 1;
}
SendClientMessage(playerid,COLOR_RED,"You dont own a vehicle. :( Nothing to find.");
return 1;
}

//Function_saveskin
if(strcmp(cmd,"/saveskin",true)==0)
{
#pragma unused cmdtext

GetPlayerName(playerid,player,sizeof(player));

if(!pInfo[playerid][Logged]){
	SendClientMessage(playerid,COLOR_RED,"You must be logged in to use this command!!!");
	return 0;
	}
dini_IntSet(udb_encode(player),"City",pInfo[playerid][City]);
dini_IntSet(udb_encode(player),"Skin",pInfo[playerid][Skin]);
SendClientMessage(playerid,COLOR_YELLOW, "You current skin has been saved. You can access it with /getskin.");
return 1;
}

//Function_getskin
if(strcmp(cmd,"/getskin",true)==0)
{
#pragma unused cmdtext
if (pInfo[playerid][GetSkin]==0){
	pInfo[playerid][JoinTeam] = 0;
	pInfo[playerid][GetSkin] = 1;
	SendClientMessage(playerid,COLOR_YELLOW,"Your saved skin/spawn position is loaded. Type /getskin again to deactivate.");
	SendClientMessage(playerid,COLOR_YELLOW,"USE /setcity TO SET THE CITY YOU ARE PLAYING IN!!!");
	SetPlayerToSpawn (playerid);
	SpawnPlayer (playerid);
	return 1;
	}
else
pInfo[playerid][GetSkin] = 0;
SendClientMessage(playerid,COLOR_YELLOW,"Your saved skin/spawn position will be ignored. Type /getskin again to activate again.");
return 1;
}

//Function_visit
if(strcmp(cmd,"/visit",true)==0)
{
#pragma unused cmdtext

if (pInfo[playerid][WantedLevel] >= 1){
	SendClientMessage(playerid,COLOR_RED,"/visit is disabled while wanted!");
	return 0;
}

if (pInfo[playerid][CopBlock]==1 && gTeam[playerid] == 10){
    PlayerPlaySound(playerid, 1063, 1685.5280,-2240.3850,13.5469);
	SetPlayerInterior(playerid,3);
	SetPlayerPos(playerid,198.5,162.5,1003.0);
	SetPlayerFacingAngle(playerid,180.0);
	SetCameraBehindPlayer(playerid);
	PlayerPlaySound(playerid,1069,198.5,162.5,1003.0);
	PlayerPlaySound(playerid,1068,198.5,162.5,1003.0);
	SendClientMessage(playerid,COLOR_RED,"Only licensed players are allowed to play a cop.");
	SendClientMessage(playerid,COLOR_RED,"Press F4 then /kill to select another class.");
	return 1;
}

if (pInfo[playerid][Jailed] || pInfo[playerid][Cuffed]){
	SetPlayerInterior(playerid,3);
	SetPlayerPos(playerid,198.5,162.5,1003.0);
	SetPlayerFacingAngle(playerid,180.0);
	SetCameraBehindPlayer(playerid);
	PlayerPlaySound(playerid,1069,198.5,162.5,1003.0);
	PlayerPlaySound(playerid,1068,198.5,162.5,1003.0);
	SendClientMessage(playerid,COLOR_RED,"/visit is disabled while jailed/badge loss or cuffed!");
	return 1;
}

if (IsPlayerInAnyVehicle(playerid)){
RemovePlayerFromVehicle(playerid);
pInfo[playerid][driver] = 0;
}
new Float:coorX;
new Float:coorY;
new Float:coorZ;
new Float:coorA;
GetPlayerPos(playerid,coorX,coorY,coorZ);
GetPlayerFacingAngle(playerid,coorA);
pInfo[playerid][OldInt] = GetPlayerInterior(playerid);
pInfo[playerid][OldX] = floatround(coorX);
pInfo[playerid][OldY] = floatround(coorY);
pInfo[playerid][OldZ] = floatround(coorZ);
pInfo[playerid][OldA] = floatround(coorA);
//SetPlayerInterior(playerid,3);
SetPlayerInterior(playerid,10);
SetPlayerFacingAngle(playerid,090.0000);
SetCameraBehindPlayer(playerid);
//SetPlayerPos(playerid,198.0000,159.5000,1003.0000);
SetPlayerPos(playerid,266.00,112.00,1009.00);
//SendClientMessage(playerid,COLOR_YELLOW,"You are visiting the jail. Enter /back to get back to your old position.");
SendClientMessage(playerid,COLOR_YELLOW,"You are visiting the court. Enter /back to get back to your old position.");
return 1;
}

//Function_lawyer
if(strcmp(cmd,"/lawyer",true)==0)
{
#pragma unused cmdtext

new jobcheck;

if (pInfo[playerid][WantedLevel] >= 1){
	SendClientMessage(playerid,COLOR_RED,"/lawyer is disabled while wanted!");
	return 0;
}

if (pInfo[playerid][Jailed] || pInfo[playerid][Cuffed]){
	SetPlayerInterior(playerid,3);
	SetPlayerPos(playerid,198.5,162.5,1003.0);
	SetPlayerFacingAngle(playerid,180.0);
	SetCameraBehindPlayer(playerid);
	PlayerPlaySound(playerid,1069,198.5,162.5,1003.0);
	PlayerPlaySound(playerid,1068,198.5,162.5,1003.0);
	SendClientMessage(playerid,COLOR_RED,"/lawyer is disabled while jailed/badge loss or cuffed!");
	return 1;
}

GetPlayerName(playerid,player,sizeof(player));
jobcheck = strval(dini_Get(udb_encode(player),"Lawyer"));

if (jobcheck != 1){
SendClientMessage(playerid,COLOR_GREEN,"You are not a licensed lawyer.");
return 0;
}

if (CurrentJudge == -1){
SendClientMessage(playerid,COLOR_GREEN,"There is no court session right now.");
return 0;
}

if (IsPlayerInAnyVehicle(playerid)){
RemovePlayerFromVehicle(playerid);
pInfo[playerid][driver] = 0;
}
new Float:coorX;
new Float:coorY;
new Float:coorZ;
new Float:coorA;
GetPlayerPos(playerid,coorX,coorY,coorZ);
GetPlayerFacingAngle(playerid,coorA);
pInfo[playerid][OldInt] = GetPlayerInterior(playerid);
pInfo[playerid][OldX] = floatround(coorX);
pInfo[playerid][OldY] = floatround(coorY);
pInfo[playerid][OldZ] = floatround(coorZ);
pInfo[playerid][OldA] = floatround(coorA);
SetPlayerInterior(playerid,10);
SetPlayerFacingAngle(playerid,090.0000);
SetCameraBehindPlayer(playerid);
SetPlayerPos(playerid,266.00,112.00,1009.00);
CurrentLawyer = playerid;
SendClientMessage(playerid,COLOR_YELLOW,"You are now the official lawyer for that case.");
return 1;
}

//Function_jail
if(strcmp(cmd,"/jail",true)==0)
{
#pragma unused cmdtext

if (pInfo[playerid][WantedLevel] >= 1){
	SendClientMessage(playerid,COLOR_RED,"/jail is disabled while wanted!");
	return 0;
}

if (pInfo[playerid][CopBlock]==1 && gTeam[playerid] == 10){
    PlayerPlaySound(playerid, 1063, 1685.5280,-2240.3850,13.5469);
	SetPlayerInterior(playerid,3);
	SetPlayerPos(playerid,198.5,162.5,1003.0);
	SetPlayerFacingAngle(playerid,180.0);
	SetCameraBehindPlayer(playerid);
	PlayerPlaySound(playerid,1069,198.5,162.5,1003.0);
	PlayerPlaySound(playerid,1068,198.5,162.5,1003.0);
	SendClientMessage(playerid,COLOR_RED,"Only licensed players are allowed to play a cop.");
	SendClientMessage(playerid,COLOR_RED,"Press F4 then /kill to select another class.");
	return 1;
}

if (pInfo[playerid][Jailed] || pInfo[playerid][Cuffed]){
	SetPlayerInterior(playerid,3);
	SetPlayerPos(playerid,198.5,162.5,1003.0);
	SetPlayerFacingAngle(playerid,180.0);
	SetCameraBehindPlayer(playerid);
	PlayerPlaySound(playerid,1069,198.5,162.5,1003.0);
	PlayerPlaySound(playerid,1068,198.5,162.5,1003.0);
	SendClientMessage(playerid,COLOR_RED,"/jail is disabled while jailed/badge loss or cuffed!");
	return 1;
}

if (IsPlayerInAnyVehicle(playerid)){
RemovePlayerFromVehicle(playerid);
pInfo[playerid][driver] = 0;
}
new Float:coorX;
new Float:coorY;
new Float:coorZ;
new Float:coorA;
GetPlayerPos(playerid,coorX,coorY,coorZ);
GetPlayerFacingAngle(playerid,coorA);
pInfo[playerid][OldInt] = GetPlayerInterior(playerid);
pInfo[playerid][OldX] = floatround(coorX);
pInfo[playerid][OldY] = floatround(coorY);
pInfo[playerid][OldZ] = floatround(coorZ);
pInfo[playerid][OldA] = floatround(coorA);
SetPlayerInterior(playerid,3);
SetPlayerFacingAngle(playerid,090.0000);
SetCameraBehindPlayer(playerid);
SetPlayerPos(playerid,198.0000,159.5000,1003.0000);
SendClientMessage(playerid,COLOR_YELLOW,"You are visiting the jail. Enter /back to get back to your old position.");
return 1;
}

//Function_back
if(strcmp(cmd,"/back",true)==0)
{
#pragma unused cmdtext

if (pInfo[playerid][OldX]==0){
SendClientMessage(playerid,COLOR_RED,"You did not teleport away. No need to get you back.");
return 0;
}

new Float:coorX;
new Float:coorY;
new Float:coorZ;
new Float:coorA;
coorX = pInfo[playerid][OldX];
coorY = pInfo[playerid][OldY];
coorZ = pInfo[playerid][OldZ];
coorA = pInfo[playerid][OldA];
SetPlayerInterior(playerid,pInfo[playerid][OldInt]);
SetPlayerFacingAngle(playerid,coorA);
SetCameraBehindPlayer(playerid);
SetPlayerPos(playerid,coorX,coorY,coorZ);
SendClientMessage(playerid,COLOR_YELLOW,"You have been brought back to your old position.");
return 1;
}

//Function_taxidriver
if(strcmp(cmd,"/taxidriver",true)==0)
{
#pragma unused cmdtext
new string[120],drivername[24],taxi;


GetPlayerName(playerid,drivername,sizeof(drivername));

if (!IsPlayerInAnyVehicle(playerid) && pInfo[playerid][City] == 1){
	format(string,sizeof(string),"%s requests a taxidriver in the area of LS. Grab a taxi and become one.",drivername);
	SendClientMessageToAll(BBLUE,string);
	return 1;
	}

if (!IsPlayerInAnyVehicle(playerid) && pInfo[playerid][City] == 2){
	format(string,sizeof(string),"%s requests a taxidriver in the area of SF. Grab a taxi and become one.",drivername);
	SendClientMessageToAll(BBLUE,string);
	return 1;
	}

if (!IsPlayerInAnyVehicle(playerid) && pInfo[playerid][City] == 3){
	format(string,sizeof(string),"%s requests a taxidriver in the area of LV. Grab a taxi and become one.",drivername);
	SendClientMessageToAll(BBLUE,string);
	return 1;
	}

if (LSTaxidrvr == playerid){
	SendClientMessage(playerid,BBLUE,"You have quit the taxidriver job. It is vacant now.");
	SendClientMessageToAll(BBLUE,"The taxidriver position in LS just became vacant. Use /taxidriver to become the next one.");
	LSTaxidrvr = -1;
	return 1;
	}
if (SFTaxidrvr == playerid){
	SendClientMessage(playerid,BBLUE,"You have quit the taxidriver job. It is vacant now.");
	SendClientMessageToAll(BBLUE,"The taxidriver position in SF just became vacant. Use /taxidriver to become the next one.");
	SFTaxidrvr = -1;
	return 1;
	}

if (LVTaxidrvr == playerid){
	SendClientMessage(playerid,BBLUE,"You have quit the taxidriver job. It is vacant now.");
	SendClientMessageToAll(BBLUE,"The taxidriver position in LV just became vacant. Use /taxidriver to become the next one.");
	LVTaxidrvr = -1;
	return 1;
	}

if (LSTaxidrvr!=-1 && pInfo[playerid][City] == 1){
    GetPlayerName(LSTaxidrvr,drivername,sizeof(drivername));
	format(string,sizeof(string),"There already is a taxidriver in LS: (%s - ID %d)",drivername,LSTaxidrvr);
	SendClientMessage(playerid,COLOR_RED,string);
	return 1;
	}
if (SFTaxidrvr!=-1 && pInfo[playerid][City] == 2){
    GetPlayerName(SFTaxidrvr,drivername,sizeof(drivername));
	format(string,sizeof(string),"There already is a taxidriver in SF: (%s - ID %d)",drivername,SFTaxidrvr);
	SendClientMessage(playerid,COLOR_RED,string);
	return 1;
	}

if (LVTaxidrvr!=-1 && pInfo[playerid][City] == 3){
    GetPlayerName(LVTaxidrvr,drivername,sizeof(drivername));
	format(string,sizeof(string),"There already is a taxidriver in LV: (%s - ID %d)",drivername,LVTaxidrvr);
	SendClientMessage(playerid,COLOR_RED,string);
	return 1;
	}


taxi = GetPlayerVehicleID(playerid);

if (pInfo[playerid][City] == 1){

		if (taxi<7 || taxi>10){
			SendClientMessage(playerid,COLOR_RED,"You must be driving a taxi to be the taxidriver. Taxis are at the Airport Terminal.");
			return 1;
			}

LSTaxidrvr = playerid;
format(string,sizeof(string),"[server] %s (ID %d) is now the official taxi driver in LS.",drivername,LSTaxidrvr);
print (string);
WriteEcho(string);
SendClientMessage(playerid,COLOR_LIGHTGREEN,"You are now the offical taxidriver!");
SendClientMessageToAll(BBLUE,string);
SendClientMessageToAll(COLOR_YELLOW,"You can order a taxi with /taxi. Write a short description for the driver from where to where you want to drive.");
return 1;
}

if (pInfo[playerid][City] == 2){

		if (taxi!=130 && taxi!=131){
			SendClientMessage(playerid,COLOR_RED,"You must be driving a taxi to be the taxidriver. Taxis are at the Airport Terminal.");
			return 1;
			}

SFTaxidrvr = playerid;
format(string,sizeof(string),"[server] %s (ID %d) is now the official taxi driver in SF.",drivername,SFTaxidrvr);
print (string);
WriteEcho(string);
SendClientMessage(playerid,COLOR_LIGHTGREEN,"You are now the offical taxidriver!");
SendClientMessageToAll(BBLUE,string);
SendClientMessageToAll(COLOR_YELLOW,"You can order a taxi with /taxi. Write a short description for the driver from where to where you want to drive.");
return 1;
}

if (pInfo[playerid][City] == 3){

		if (taxi!=128 && taxi!=129){
			SendClientMessage(playerid,COLOR_RED,"You must be driving a taxi to be the taxidriver. Taxis are at the Airport Terminal.");
			return 1;
			}

LVTaxidrvr = playerid;
format(string,sizeof(string),"[server] %s (ID %d) is now the official taxi driver in LV.",drivername,LVTaxidrvr);
print (string);
WriteEcho(string);
SendClientMessage(playerid,COLOR_LIGHTGREEN,"You are now the offical taxidriver!");
SendClientMessageToAll(BBLUE,string);
SendClientMessageToAll(COLOR_YELLOW,"You can order a taxi with /taxi. Write a short description for the driver from where to where you want to drive.");
return 1;
}

return 1;
}

//Function_taxi
if(strcmp(cmd,"/taxi",true)==0)
{
#pragma unused cmdtext
new string[120],drivername[24],cityname[2],customername[24];

switch(pInfo[playerid][City]){
case 1: format(cityname,2,"LS");
case 2: format(cityname,2,"SF");
case 3: format(cityname,2,"LV");
}

if (!strlen(cmdtext)){
	SendClientMessage(playerid,COLOR_GREY,"Usage: /taxi [info for the driver]");
	SendClientMessage(playerid,COLOR_RED,"No info - no transfer ;(");
	return 1;
	}

if (LSTaxidrvr == -1 && pInfo[playerid][City] == 1){
	SendClientMessage(playerid,COLOR_RED,"Unfortunately there is no taxi driver in LS at the moment.");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /taxidriver to request someone to drive a taxi.");
	return 1;
	}

if (SFTaxidrvr == -1 && pInfo[playerid][City] == 2){
	SendClientMessage(playerid,COLOR_RED,"Unfortunately there is no taxi driver in SF at the moment.");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /taxidriver to request someone to drive a taxi.");
	return 1;
	}

if (LVTaxidrvr == -1 && pInfo[playerid][City] == 3){
	SendClientMessage(playerid,COLOR_RED,"Unfortunately there is no taxi driver in LV at the moment.");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /taxidriver to request someone to drive a taxi.");
	return 1;
	}

if (pInfo[playerid][City] == 1){
	GetPlayerName(LSTaxidrvr,drivername,sizeof(drivername));
	GetPlayerName(playerid,customername,sizeof(customername));

	if (!IsPlayerInAnyVehicle(playerid)){
		format(string,sizeof(string),"[server] [LS] (Taxi Request) %s (ID %d). Information: %s",customername,playerid,cmdtext[0]);
		SendClientMessage(LSTaxidrvr,COLOR_LIGHTGREEN,string);
		SendClientMessage(LSTaxidrvr,COLOR_YELLOW,"Type /accept [price for the ride] or /reject [reason]");
		print(string);
		WriteEcho(string);
		format(string,sizeof(string),"You requested a taxi");
		LSTaxicust = playerid;
		SendClientMessage(playerid,BBLUE,string);
		format(string,sizeof(string),"Your information for the driver: %s",cmdtext[0]);
		SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
		return 1;
		}
SendClientMessage(playerid,COLOR_RED,"No point in requesting a taxi while you are already in a vehicle. >:|");
return 0;
	}

if (pInfo[playerid][City] == 2){
	GetPlayerName(SFTaxidrvr,drivername,sizeof(drivername));
	GetPlayerName(playerid,customername,sizeof(customername));

	if (!IsPlayerInAnyVehicle(playerid)){
		format(string,sizeof(string),"[server] [LS] (Taxi Request) %s (ID %d). Information: %s",customername,playerid,cmdtext[0]);
		SendClientMessage(SFTaxidrvr,COLOR_LIGHTGREEN,string);
		SendClientMessage(SFTaxidrvr,COLOR_YELLOW,"Type /accept [price for the ride] or /reject [reason]");
		print(string);
		WriteEcho(string);
		format(string,sizeof(string),"You requested a taxi");
		SFTaxicust = playerid;
		SendClientMessage(playerid,BBLUE,string);
		format(string,sizeof(string),"Your information for the driver: %s",cmdtext[0]);
		SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
		return 1;
		}
SendClientMessage(playerid,COLOR_RED,"No point in requesting a taxi while you are already in a vehicle. >:|");
return 1;
	}

if (pInfo[playerid][City] == 3){
	GetPlayerName(LVTaxidrvr,drivername,sizeof(drivername));
	GetPlayerName(playerid,customername,sizeof(customername));

	if (!IsPlayerInAnyVehicle(playerid)){
		format(string,sizeof(string),"[server] [LV] (Taxi Request) %s (ID %d). Information: %s",customername,playerid,cmdtext[0]);
		SendClientMessage(LVTaxidrvr,COLOR_LIGHTGREEN,string);
		SendClientMessage(LVTaxidrvr,COLOR_YELLOW,"Type /accept [price for the ride] or /reject [reason]");
		print(string);
		WriteEcho(string);
		format(string,sizeof(string),"You requested a taxi");
		LVTaxicust = playerid;
		SendClientMessage(playerid,BBLUE,string);
		format(string,sizeof(string),"Your information for the driver: %s",cmdtext[0]);
		SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
		return 1;
		}
SendClientMessage(playerid,COLOR_RED,"No point in requesting a taxi while you are already in a vehicle. >:|");
return 1;
	}

return 1;
}

//Function_accept
if(strcmp(cmd,"/accept",true)==0)
{
#pragma unused cmdtext
new string[255],drivername[24],customername[24];
new Float:posX;
new Float:posY;
new Float:posZ;


if (playerid != LSTaxidrvr && playerid != SFTaxidrvr && playerid != LVTaxidrvr){
	SendClientMessage(playerid,COLOR_RED,"This command is for the taxidriver only.");
	SendClientMessage(playerid,COLOR_YELLOW,"Try to become the taxi driver by getting a taxi and type /taxidriver.");
	return 1;
	}

if (!strlen(cmdtext)){
	SendClientMessage(playerid,COLOR_GREY,"Usage: /accept [price for the ride in $$]");
	return 1;
	}

if (pInfo[playerid][City] == 1){
	if (LSTaxicust==-1){
   		SendClientMessage(playerid,COLOR_RED,"Unfortunately there is no customer in LS at the moment.");
		return 1;
		}
		GetPlayerName(LSTaxidrvr,drivername,sizeof(drivername));
		GetPlayerName(LSTaxicust,customername,sizeof(customername));

			if (IsPlayerInAnyVehicle(playerid)){
			format(string,sizeof(string),"(Accepted Taxi Transfer) Customer %s (ID %d). Price: %s$",customername,LSTaxicust,cmdtext[0]);
			SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
			SendClientMessage(playerid,COLOR_LIGHTGREEN,"Go to the red checkpoint on your radar and pick up your customer!");
			printf ("[LS] %s",string);

			GetPlayerPos(LSTaxicust,posX,posY,posZ);
			SetPlayerCheckpoint(LSTaxidrvr,posX,posY,posZ,5);
			
			format(string,sizeof(string),"Taxidriver %s accepted your transfer request and is on his way to you.",drivername);
			SendClientMessage(LSTaxicust,BBLUE,string);
			format(string,sizeof(string),"Price for the transfer: %s$",cmdtext[0]);
			SendClientMessage(LSTaxicust,COLOR_LIGHTGREEN,string);
			return 1;
			}
		LSTaxidrvr = -1;
		SendClientMessage(playerid,COLOR_RED,"You have been suspended because you were not in your taxi! >:(");
		SendClientMessageToAll(BBLUE,"The taxi driver position in LS just became vacant. Enter /taxidriver to become the next one");
		return 1;
}

if (pInfo[playerid][City] == 2){
	if (SFTaxicust==-1){
   		SendClientMessage(playerid,COLOR_RED,"Unfortunately there is no customer in SF at the moment.");
		return 1;
		}
		GetPlayerName(SFTaxidrvr,drivername,sizeof(drivername));
		GetPlayerName(SFTaxicust,customername,sizeof(customername));

			if (IsPlayerInAnyVehicle(playerid)){
			format(string,sizeof(string),"(Accepted Taxi Transfer) Customer %s (ID %d). Price: %s$",customername,SFTaxicust,cmdtext[0]);
			SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
			SendClientMessage(playerid,COLOR_LIGHTGREEN,"Go to the red checkpoint on your radar and pick up your customer!");
			printf ("[SF] %s",string);
			
			GetPlayerPos(SFTaxicust,posX,posY,posZ);
			SetPlayerCheckpoint(SFTaxidrvr,posX,posY,posZ,5);
			
			format(string,sizeof(string),"Taxidriver %s accepted your transfer request and is on his way to you.",drivername);
			SendClientMessage(SFTaxicust,BBLUE,string);
			format(string,sizeof(string),"Price for the transfer: %s$",cmdtext[0]);
			SendClientMessage(SFTaxicust,COLOR_LIGHTGREEN,string);
			return 1;
			}
		SFTaxidrvr = -1;
		SendClientMessage(playerid,COLOR_RED,"You have been suspended because you were not in your taxi! >:(");
		SendClientMessageToAll(BBLUE,"The taxi driver position in SF just became vacant. Enter /taxidriver to become the next one");
		return 1;
}

if (pInfo[playerid][City] == 3){
	if (LVTaxicust==-1){
   		SendClientMessage(playerid,COLOR_RED,"Unfortunately there is no customer in LV at the moment.");
		return 1;
		}
		GetPlayerName(LVTaxidrvr,drivername,sizeof(drivername));
		GetPlayerName(LVTaxicust,customername,sizeof(customername));

			if (IsPlayerInAnyVehicle(playerid)){
			format(string,sizeof(string),"(Accepted Taxi Transfer) Customer %s (ID %d). Price: %s$",customername,LVTaxicust,cmdtext[0]);
			SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
			SendClientMessage(playerid,COLOR_LIGHTGREEN,"Go to the red checkpoint on your radar and pick up your customer!");
			printf ("[LV] %s",string);
			
			GetPlayerPos(LVTaxicust,posX,posY,posZ);
			SetPlayerCheckpoint(LVTaxidrvr,posX,posY,posZ,5);
			
			format(string,sizeof(string),"Taxidriver %s accepted your transfer request and is on his way to you.",drivername);
			SendClientMessage(LVTaxicust,BBLUE,string);
			format(string,sizeof(string),"Price for the transfer: %s$",cmdtext[0]);
			SendClientMessage(LVTaxicust,COLOR_LIGHTGREEN,string);
			return 1;
			}
		LVTaxidrvr = -1;
		SendClientMessage(playerid,COLOR_RED,"You have been suspended because you were not in your taxi! >:(");
		SendClientMessageToAll(BBLUE,"The taxi driver position in LV just became vacant. Enter /taxidriver to become the next one");
		return 1;
}

return 1;
}

//Function_reject
if(strcmp(cmd,"/reject",true)==0)
{
#pragma unused cmdtext
new string[255],drivername[24],customername[24];

if (playerid != LSTaxidrvr && playerid != SFTaxidrvr && playerid != LVTaxidrvr){
	SendClientMessage(playerid,COLOR_RED,"This command is for the taxidriver only.");
	SendClientMessage(playerid,COLOR_YELLOW,"Try to become the taxi driver by getting a taxi and type /taxidriver.");
	return 1;
	}

if (!strlen(cmdtext)){
	SendClientMessage(playerid,COLOR_GREY,"Usage: /reject [reason]");
	return 1;
	}

if (pInfo[playerid][City] == 1){
	if (LSTaxicust==-1){
   		SendClientMessage(playerid,COLOR_RED,"Unfortunately there is no customer in LS at the moment.");
		return 1;
		}
		GetPlayerName(LSTaxidrvr,drivername,sizeof(drivername));
		GetPlayerName(LSTaxicust,customername,sizeof(customername));

			if (IsPlayerInAnyVehicle(playerid)){
			format(string,sizeof(string),"(Rejected Taxi Transfer) Customer %s (ID %d). Reason: %s",customername,LSTaxicust,cmdtext[0]);
			SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
			printf ("[LS] %s",string);
			format(string,sizeof(string),"Taxidriver %s rejected your transfer request.",drivername);
			SendClientMessage(LSTaxicust,BBLUE,string);
			format(string,sizeof(string),"Reason: %s",cmdtext[0]);
			SendClientMessage(LSTaxicust,COLOR_LIGHTGREEN,string);
			return 1;
			}
		LSTaxidrvr = -1;
		SendClientMessage(playerid,COLOR_RED,"You have been suspended because you were not in your taxi! >:(");
		SendClientMessageToAll(BBLUE,"The taxi driver position in LS just became vacant. Enter /taxidriver to become the next one");
		return 1;
}

if (pInfo[playerid][City] == 2){
	if (SFTaxicust==-1){
   		SendClientMessage(playerid,COLOR_RED,"Unfortunately there is no customer in SF at the moment.");
		return 1;
		}
		GetPlayerName(SFTaxidrvr,drivername,sizeof(drivername));
		GetPlayerName(SFTaxicust,customername,sizeof(customername));

			if (IsPlayerInAnyVehicle(playerid)){
			format(string,sizeof(string),"(Rejected Taxi Transfer) Customer %s (ID %d). Reason: %s",customername,SFTaxicust,cmdtext[0]);
			SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
			printf ("[SF] %s",string);
			format(string,sizeof(string),"Taxidriver %s rejected your transfer request.",drivername);
			SendClientMessage(SFTaxicust,BBLUE,string);
			format(string,sizeof(string),"Reason: %s",cmdtext[0]);
			SendClientMessage(SFTaxicust,COLOR_LIGHTGREEN,string);
			return 1;
			}
		SFTaxidrvr = -1;
		SendClientMessage(playerid,COLOR_RED,"You have been suspended because you were not in your taxi! >:(");
		SendClientMessageToAll(BBLUE,"The taxi driver position in SF just became vacant. Enter /taxidriver to become the next one");
		return 1;
}

if (pInfo[playerid][City] == 3){
	if (LVTaxicust==-1){
   		SendClientMessage(playerid,COLOR_RED,"Unfortunately there is no customer in LV at the moment.");
		return 1;
		}
		GetPlayerName(LVTaxidrvr,drivername,sizeof(drivername));
		GetPlayerName(LVTaxicust,customername,sizeof(customername));

			if (IsPlayerInAnyVehicle(playerid)){
			format(string,sizeof(string),"(Rejected Taxi Transfer) Customer %s (ID %d). Reason: %s",customername,LVTaxicust,cmdtext[0]);
			SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
			printf ("[LV] %s",string);
			format(string,sizeof(string),"Taxidriver %s rejected your transfer request.",drivername);
			SendClientMessage(LVTaxicust,BBLUE,string);
			format(string,sizeof(string),"Reason: %s",cmdtext[0]);
			SendClientMessage(LVTaxicust,COLOR_LIGHTGREEN,string);
			return 1;
			}
		LVTaxidrvr = -1;
		SendClientMessage(playerid,COLOR_RED,"You have been suspended because you were not in your taxi! >:(");
		SendClientMessageToAll(BBLUE,"The taxi driver position in LV just became vacant. Enter /taxidriver to become the next one");
		return 1;
}

return 1;
}

//Function_911
if(strcmp(cmd,"/911",true)==0)
{
#pragma unused cmdtext
new string[255],sub[6],callername[24],strresult,alarmteam;
new Float:posX;
new Float:posY;
new Float:posZ;




if (!strlen(cmdtext)){
	SendClientMessage(playerid,COLOR_GREY,"Usage: /911 c OR /911 cops - Gets the cops to come to you and help");
	SendClientMessage(playerid,COLOR_GREY,"Usage: /911 f OR /911 fire - Gets the firemen to come to you and help");
	SendClientMessage(playerid,COLOR_GREY,"Usage: /911 m OR /911 meds - Gets the medics to come to you and help");
	SendClientMessage(playerid,COLOR_GREY,"Usage: /911 n OR /911 none - stops your SOS signal");
	SendClientMessage(playerid,COLOR_ORANGE,"It is strongly advised that u give aditional info after the signal word!");
	return 1;
	}
GetPlayerName(playerid,callername,sizeof(callername));
GetPlayerPos(playerid,posX,posY,posZ);

strmid(sub,cmdtext,0,5,6);
strmid(cmdtext,cmdtext,5,255,250);
strresult = strfind(sub,"c",true,0);
if (strresult!=-1){
	pInfo[playerid][SOS] = 1;
	alarmteam = TEAM_COPS;
	SendClientMessage(playerid,BBLUE,"The SAPD is informed.");
	SendClientMessage(playerid,COLOR_YELLOW,"You can stop your SOS signal using /911 n or /911 none.");
	}

strresult = strfind(sub,"f",true,0);
if (strresult!=-1){
	pInfo[playerid][SOS] = 1;
	alarmteam = TEAM_FIREMEN;
	SendClientMessage(playerid,BBLUE,"The SAFD is informed.");
	SendClientMessage(playerid,COLOR_YELLOW,"You can stop your SOS signal using /911 n or /911 none.");
	}

strresult = strfind(sub,"m",true,0);
if (strresult!=-1){
	pInfo[playerid][SOS] = 1;
	alarmteam = TEAM_MEDICS;
	SendClientMessage(playerid,BBLUE,"The SALR is informed.");
	SendClientMessage(playerid,COLOR_YELLOW,"You can stop your SOS signal using /911 n or /911 none.");
	}

strresult = strfind(sub,"n",true,0);
if (strresult!=-1){
	if (!pInfo[playerid][SOS]){
		SendClientMessage(playerid,COLOR_RED,"You did not set a SOS signal before.");
		return 1;
		}
	pInfo[playerid][SOS] = 0;
	SendClientMessage(playerid,BBLUE,"Your SOS signal has been stopped.");
	}

for (new al=0;al<MAX_PLAYERS;al++){
	if (gTeam[al] == alarmteam){
	format(string,sizeof(string),"(HQ) Caller %s (ID %d) needs urgent help.",callername,playerid);
	SendClientMessage(al,COLOR_RED,string);
	SetPlayerCheckpoint(al,posX,posY,posZ,5);
	SendClientMessage(al,COLOR_RED,"A red icon on your map leads the way.");
	format(string,sizeof(string),"Other information given: %s",cmdtext[0]);
	SendClientMessage(al,COLOR_RED,string);
	}
}
return 1;
}

//Function_changename
if(strcmp(cmd,"/changename",true)==0)
{
#pragma unused cmdtext
new string[255],oldname[25],newname[25];
new Password[255],Pocket,pCity,pBank,pDrugs,pLevel,pVehicle,pSkin;
new pBiz,pBizName[255],pBizGain,pHouse,pBizX,pBizY,pBizZ,pCop,pLawyer;
new SpawnX,SpawnY,SpawnZ,SpawnA;

GetPlayerName(playerid,oldname,sizeof(oldname));

if(!strlen(cmdtext)){
	SendClientMessage(playerid,COLOR_GREY,"USAGE: /changename [new name]");
	return 0;
	}

if(!pInfo[playerid][Logged]){
	SendClientMessage(playerid,COLOR_RED,"You must be logged in to use this command!!!");
	return 0;
	}

format(newname,sizeof(newname),"%s",cmdtext[0]);

if(!dini_Exists(udb_encode(newname))){
Password = dini_Get(udb_encode(oldname),"Password");
Pocket = GetPlayerMoney(playerid);
pBank = strval(dini_Get(udb_encode(oldname),"Bank"));
pDrugs = strval(dini_Get(udb_encode(oldname),"Drugs"));
pLevel = strval(dini_Get(udb_encode(oldname),"Level"));
pVehicle = strval(dini_Get(udb_encode(oldname),"Vehicle"));
pSkin = strval(dini_Get(udb_encode(oldname),"Skin"));
pCity = strval(dini_Get(udb_encode(oldname),"City"));
pHouse = strval(dini_Get(udb_encode(oldname),"House"));
SpawnX = strval(dini_Get(udb_encode(oldname),"SpawnX"));
SpawnY = strval(dini_Get(udb_encode(oldname),"SpawnY"));
SpawnZ = strval(dini_Get(udb_encode(oldname),"SpawnZ"));
SpawnA = strval(dini_Get(udb_encode(oldname),"SpawnA"));
pBiz = strval(dini_Get(udb_encode(oldname),"Biz"));
pBizName = dini_Get(udb_encode(oldname),"BizName");
pBizGain = strval(dini_Get(udb_encode(oldname),"BizGain"));
pBizX = strval(dini_Get(udb_encode(oldname),"BizX"));
pBizY = strval(dini_Get(udb_encode(oldname),"BizY"));
pBizZ = strval(dini_Get(udb_encode(oldname),"BizZ"));
pCop = strval(dini_Get(udb_encode(oldname),"Cop"));
pLawyer = strval(dini_Get(udb_encode(oldname),"Lawyer"));

dini_IntSet("DeleteAccounts",oldname,1);

dini_Create(udb_encode(newname));
dini_Set(udb_encode(newname),"Password",Password);
dini_IntSet(udb_encode(newname),"Pocket",Pocket);
dini_IntSet(udb_encode(newname),"Bank",pBank);
dini_IntSet(udb_encode(newname),"Drugs",pDrugs);
dini_IntSet(udb_encode(newname),"Level",pLevel);
dini_IntSet(udb_encode(newname),"Vehicle",pVehicle);
dini_IntSet(udb_encode(newname),"Skin",pSkin);
dini_IntSet(udb_encode(newname),"City",pCity);
dini_IntSet(udb_encode(newname),"House",pHouse);
dini_IntSet(udb_encode(newname),"SpawnX",SpawnX);
dini_IntSet(udb_encode(newname),"SpawnY",SpawnY);
dini_IntSet(udb_encode(newname),"SpawnZ",SpawnZ);
dini_IntSet(udb_encode(newname),"SpawnA",SpawnA);
dini_IntSet(udb_encode(newname),"Biz",pBiz);
dini_Set(udb_encode(newname),"BizName",pBizName);
dini_IntSet(udb_encode(newname),"BizX",pBizX);
dini_IntSet(udb_encode(newname),"BizY",pBizY);
dini_IntSet(udb_encode(newname),"BizZ",pBizZ);
dini_IntSet(udb_encode(newname),"BizGain",pBizGain);
dini_IntSet(udb_encode(newname),"Cop",pCop);
dini_IntSet(udb_encode(newname),"CLawyer",pLawyer);

format(string,sizeof(string),"[server] ***** %s renamed to %s *****",oldname,newname);
SendClientMessageToAll(COLOR_PINK,string);
print (string);
WriteEcho(string);
return 1;
}
SendClientMessage(playerid,COLOR_RED,"(Error) This username already exists!");
return 1;
}

//Function_changepass
if(strcmp(cmd,"/changepass",true)==0)
{
#pragma unused cmdtext
new string[255],start,passctrl,oldpass[255],newpass[255];

GetPlayerName(playerid,player,sizeof(player));

if(!strlen(cmdtext)){
	SendClientMessage(playerid,COLOR_GREY,"USAGE: /changepass [old password] [new password]");
	return 0;
	}

if(!pInfo[playerid][Logged]){
	SendClientMessage(playerid,COLOR_RED,"You must be logged in to use this command!!!");
	return 0;
	}

oldpass = dini_Get(udb_encode(player),"Password");

passctrl = strfind(cmdtext,oldpass,true,0);

	if (passctrl==-1){
	SendClientMessage(playerid,COLOR_RED,"Wrong password!!!");
	return 0;
	}

start = strlen(oldpass) + 1;
strmid(newpass,cmdtext,start,255,255);
dini_Set(udb_encode(player),"Password",newpass);
format(string,sizeof(string),"You changed your password from %s to %s",oldpass,newpass);
SendClientMessage(playerid,COLOR_PINK,string);
return 1;
}

//Function_charter
if(strcmp(cmd,"/charter",true)==0)
{
#pragma unused cmdtext
new string[120],drivername[24],taxi;

GetPlayerName(playerid,drivername,sizeof(drivername));

if (!IsPlayerInAnyVehicle(playerid) && pInfo[playerid][City] == 1){
	format(string,sizeof(string),"%s requests a charter pilot in the area of LS. Grab a jet and become one.",drivername);
	SendClientMessageToAll(BBLUE,string);
	return 1;
	}
if (!IsPlayerInAnyVehicle(playerid) && pInfo[playerid][City] == 2){
	format(string,sizeof(string),"%s requests a charter pilot in the area of SF. Grab a jet and become one.",drivername);
	SendClientMessageToAll(BBLUE,string);
	return 1;
	}

if (!IsPlayerInAnyVehicle(playerid) && pInfo[playerid][City] == 3){
	format(string,sizeof(string),"%s requests a charter pilot in the area of LV. Grab a jet and become one.",drivername);
	SendClientMessageToAll(BBLUE,string);
	return 1;
	}

if (LSPilot == playerid){
	SendClientMessage(playerid,BBLUE,"You have quit the charter pilot job. It is vacant now.");
	SendClientMessageToAll(BBLUE,"The charter pilot position in LS just became vacant. Use /charter to become the next one.");
	WriteEcho("[server] The charter pilot position in LS just became vacant.");
	LSPilot = -1;
	return 1;
	}
if (SFPilot == playerid){
	SendClientMessage(playerid,BBLUE,"You have quit the charter pilot job. It is vacant now.");
	SendClientMessageToAll(BBLUE,"The charter pilot position in SF just became vacant. Use /charter to become the next one.");
	WriteEcho("[server] The charter pilot position in SF just became vacant.");
	SFPilot = -1;
	return 1;
	}

if (LVPilot == playerid){
	SendClientMessage(playerid,BBLUE,"You have quit the charter pilot job. It is vacant now.");
	SendClientMessageToAll(BBLUE,"The charetr pilot position in LV just became vacant. Use /charter to become the next one.");
	WriteEcho("[server] The charter pilot position in LV just became vacant.");
	LVPilot = -1;
	return 1;
	}

if (LSPilot!=-1 && pInfo[playerid][City] == 1){
    GetPlayerName(LSPilot,drivername,sizeof(drivername));
	format(string,sizeof(string),"There already is a charter pilot in LS: (%s - ID %d)",drivername,LSTaxidrvr);
	SendClientMessage(playerid,COLOR_RED,string);
	return 1;
	}
if (SFPilot!=-1 && pInfo[playerid][City] == 2){
    GetPlayerName(SFPilot,drivername,sizeof(drivername));
	format(string,sizeof(string),"There already is a charter pilot in SF: (%s - ID %d)",drivername,SFTaxidrvr);
	SendClientMessage(playerid,COLOR_RED,string);
	return 1;
	}

if (LVPilot!=-1 && pInfo[playerid][City] == 3){
    GetPlayerName(LVPilot,drivername,sizeof(drivername));
	format(string,sizeof(string),"There already is a charter pilot in LV: (%s - ID %d)",drivername,LVTaxidrvr);
	SendClientMessage(playerid,COLOR_RED,string);
	return 1;
	}


taxi = GetPlayerVehicleID(playerid);

if (pInfo[playerid][City] == 1){

		if (taxi!=14 && taxi!=139){
			SendClientMessage(playerid,COLOR_RED,"You must be controlling a jet to be the charter pilot. Jets are at the Airport at the (big) hangars.");
			return 1;
			}

LSPilot = playerid;
format(string,sizeof(string),"[server] %s (ID %d) is now the official charter pilot in LS.",drivername,LSPilot);
print (string);
WriteEcho(string);
SendClientMessage(playerid,COLOR_LIGHTGREEN,"You are now the offical charter pilot!");
SendClientMessageToAll(BBLUE,string);
SendClientMessageToAll(COLOR_YELLOW,"You can book a flight with /bookflight.");
return 1;
}

if (pInfo[playerid][City] == 2){

		if (taxi!=155){
			SendClientMessage(playerid,COLOR_RED,"You must be controlling a jet to be the charter pilot. Jets are at the Airport at the terminal.");
			return 1;
			}


SFPilot = playerid;
format(string,sizeof(string),"[server] %s (ID %d) is now the official charter pilot in SF.",drivername,SFPilot);
print (string);
WriteEcho(string);
SendClientMessage(playerid,COLOR_LIGHTGREEN,"You are now the offical charter pilot!");
SendClientMessageToAll(BBLUE,string);
SendClientMessageToAll(COLOR_YELLOW,"You can book a flight with /bookflight.");
return 1;
}

if (pInfo[playerid][City] == 3){

		if (taxi!=167){
			SendClientMessage(playerid,COLOR_RED,"You must be controlling a jet to be the charter pilot. Jets are at the Airport at the terminal.");
			return 1;
			}

LVPilot = playerid;
format(string,sizeof(string),"[server] %s (ID %d) is now the official charter pilot in LV.",drivername,LVPilot);
print (string);
WriteEcho(string);
SendClientMessage(playerid,COLOR_LIGHTGREEN,"You are now the offical charter pilot!");
SendClientMessageToAll(BBLUE,string);
SendClientMessageToAll(COLOR_YELLOW,"You can book a flight with /bookflight.");
return 1;
}



return 1;
}

//Function_bookflight
if(strcmp(cmd,"/bookflight",true)==0)
{
#pragma unused cmdtext
new string[120],pilotname[24],pasname[24],chute,aviablemoney;

if (!strlen(cmdtext)){
	SendClientMessage(playerid,COLOR_GREY,"Usage: /bookflight [destination]");
	SendClientMessage(playerid,COLOR_GREY,"Price 500$");
	SendClientMessage(playerid,COLOR_GREY,"Usage: /bookflight parachute [drop-off point]");
	SendClientMessage(playerid,COLOR_GREY,"Price 200$");
	SendClientMessage(playerid,COLOR_RED,"No info no flight ;(");
	return 1;
	}

if (LSPilot == -1 && pInfo[playerid][City] == 1){
	SendClientMessage(playerid,COLOR_RED,"Unfortunately there is no charter pilot in LS at the moment.");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /charter to request someone to fly a jet.");
	return 1;
	}

if (SFPilot == -1 && pInfo[playerid][City] == 2){
	SendClientMessage(playerid,COLOR_RED,"Unfortunately there is no charter pilot in SF at the moment.");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /charter to request someone to fly a jet.");
	return 1;
	}

if (LVPilot == -1 && pInfo[playerid][City] == 3){
	SendClientMessage(playerid,COLOR_RED,"Unfortunately there is no charter pilot in LV at the moment.");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /charter to request someone to fly a jet.");
	return 1;
	}

if (pInfo[playerid][City] == 1){
GetPlayerName(LSPilot,pilotname,sizeof(pilotname));
GetPlayerName(playerid,pasname,sizeof(pasname));

if (LSFlight[Flying]){
SendClientMessage(playerid,COLOR_RED,"The flight cannot accept bookings right now because it is in process");
return 0;
}

chute = strfind(cmdtext,"parachut",true,0);

	if (chute == -1){
	format(string,sizeof(string),"[server] [LS] (Flight Booked) %s (ID %d). 500$ gained. Information: %s",pasname,playerid,cmdtext[0]);
	SendClientMessage(LSPilot,COLOR_LIGHTGREEN,string);
	print(string);
	WriteEcho(string);
	pInfo[playerid][paradrop] = 0;

	aviablemoney = GetPlayerMoney(playerid);

 		if(500>aviablemoney){
 	    SendClientMessage(playerid,COLOR_RED,"You do not have that much money. :P");
		return 1;
 		}

	GivePlayerMoney(playerid,-500);
	GivePlayerMoney(LSPilot,500);
	format(string,sizeof(string),"You booked a flight for 500$. Move to the red checkpoint on your radar and use /board");

	SetPlayerCheckpoint(playerid,1820.0000,-2626.0000,14.0000,2.0);
	pInfo[playerid][isPassenger] = 1;
	SendClientMessage(playerid,BBLUE,string);
	format(string,sizeof(string),"Your destination as sent to the pilot: %s",cmdtext[0]);
	SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
	return 1;
	}

format(string,sizeof(string),"[server] [LS] (Dropoff Booked) %s (ID %d). 200$ gained. Information: %s",pasname,playerid,cmdtext[0]);
SendClientMessage(LSPilot,COLOR_LIGHTGREEN,string);
print (string);
WriteEcho(string);
pInfo[playerid][paradrop] = 1;

aviablemoney = GetPlayerMoney(playerid);

 		if(200>aviablemoney){
 	    SendClientMessage(playerid,COLOR_RED,"You do not have that much money. :P");
		return 1;
 		}

GivePlayerMoney(playerid,-200);
GivePlayerMoney(LSPilot,200);
format(string,sizeof(string),"You booked a parachute dropoff for 200$. Move to the red checkpoint on your radar and use /board");

SetPlayerCheckpoint(playerid,2118.0000,-2428.0000,14.0000,2.0);
pInfo[playerid][isPassenger] = 1;
SendClientMessage(playerid,BBLUE,string);
format(string,sizeof(string),"Your dropoff point as sent to the pilot: %s",cmdtext[0]);
SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
return 1;
}

if (pInfo[playerid][City] == 2){
GetPlayerName(SFPilot,pilotname,sizeof(pilotname));
GetPlayerName(playerid,pasname,sizeof(pasname));

if (SFFlight[Flying]){
SendClientMessage(playerid,COLOR_RED,"The flight cannot accept bookings right now because it is in process");
return 0;
}

chute = strfind(cmdtext,"parachut",true,0);

	if (chute == -1){
	format(string,sizeof(string),"[server] [SF](Flight Booked) %s (ID %d). 500$ gained. Information: %s",pasname,playerid,cmdtext[0]);
	SendClientMessage(SFPilot,COLOR_LIGHTGREEN,string);
	print (string);
	WriteEcho(string);
	pInfo[playerid][paradrop] = 0;

aviablemoney = GetPlayerMoney(playerid);

 		if(500>aviablemoney){
 	    SendClientMessage(playerid,COLOR_RED,"You do not have that much money. :P");
		return 1;
 		}

	GivePlayerMoney(playerid,-500);
	GivePlayerMoney(SFPilot,500);
	format(string,sizeof(string),"You booked a flight for 500$. Move to the red checkpoint on your radar and use /board");

	SetPlayerCheckpoint(playerid,-1341.0000,-249.0000,14.0000,2.0);
	pInfo[playerid][isPassenger] = 1;
	SendClientMessage(playerid,BBLUE,string);
	format(string,sizeof(string),"Your destination as sent to the pilot: %s",cmdtext[0]);
	SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
	return 1;
	}

format(string,sizeof(string),"[server] [SF] (Dropoff Booked) %s (ID %d). 200$ gained. Information: %s",pasname,playerid,cmdtext[0]);
SendClientMessage(SFPilot,COLOR_LIGHTGREEN,string);
print(string);
WriteEcho(string);
pInfo[playerid][paradrop] = 1;

aviablemoney = GetPlayerMoney(playerid);

 		if(200>aviablemoney){
 	    SendClientMessage(playerid,COLOR_RED,"You do not have that much money. :P");
		return 1;
 		}

GivePlayerMoney(playerid,-200);
GivePlayerMoney(SFPilot,200);
format(string,sizeof(string),"You booked a parachute dropoff for 200$. Move to the red checkpoint on your radar and use /board");

SetPlayerCheckpoint(playerid,2118.0000,-2428.0000,14.0000,2.0);
pInfo[playerid][isPassenger] = 1;
SendClientMessage(playerid,BBLUE,string);
format(string,sizeof(string),"Your dropoff point as sent to the pilot: %s",cmdtext[0]);
SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
return 1;
}

if (pInfo[playerid][City] == 3){
GetPlayerName(LVPilot,pilotname,sizeof(pilotname));
GetPlayerName(playerid,pasname,sizeof(pasname));

if (LVFlight[Flying]){
SendClientMessage(playerid,COLOR_RED,"The flight cannot accept bookings right now because it is in process");
return 0;
}

chute = strfind(cmdtext,"parachut",true,0);

	if (chute == -1){
	format(string,sizeof(string),"[server] [LV] (Flight Booked) %s (ID %d). 500$ gained. Information: %s",pasname,playerid,cmdtext[0]);
	SendClientMessage(LVPilot,COLOR_LIGHTGREEN,string);
	print(string);
	WriteEcho(string);
	pInfo[playerid][paradrop] = 0;

aviablemoney = GetPlayerMoney(playerid);

 		if(500>aviablemoney){
 	    SendClientMessage(playerid,COLOR_RED,"You do not have that much money. :P");
		return 1;
 		}


	GivePlayerMoney(playerid,-500);
	GivePlayerMoney(LVPilot,500);
	format(string,sizeof(string),"You booked a flight for 500$. Move to the red checkpoint on your radar and use /board");

	SetPlayerCheckpoint(playerid,1569.0000,1533.0000,11.0000,2.0);
	pInfo[playerid][isPassenger] = 1;
	SendClientMessage(playerid,BBLUE,string);
	format(string,sizeof(string),"Your destination as sent to the pilot: %s",cmdtext[0]);
	SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
	return 1;
	}

format(string,sizeof(string),"[server] [LV] (Dropoff Booked) %s (ID %d). 200$ gained. Information: %s",pasname,playerid,cmdtext[0]);
SendClientMessage(LVPilot,COLOR_LIGHTGREEN,string);
print(string);
WriteEcho(string);
pInfo[playerid][paradrop] = 1;

aviablemoney = GetPlayerMoney(playerid);

 		if(200>aviablemoney){
 	    SendClientMessage(playerid,COLOR_RED,"You do not have that much money. :P");
		return 1;
 		}


GivePlayerMoney(playerid,-200);
GivePlayerMoney(LVPilot,200);
format(string,sizeof(string),"You booked a parachute dropoff for 200$. Move to the red checkpoint on your radar and use /board");

SetPlayerCheckpoint(playerid,2118.0000,-2428.0000,14.0000,2.0);
pInfo[playerid][isPassenger] = 1;
SendClientMessage(playerid,BBLUE,string);
format(string,sizeof(string),"Your dropoff point as sent to the pilot: %s",cmdtext[0]);
SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
return 1;
}

return 1;
}

//Function_board
if(strcmp(cmd,"/board",true)==0)
{
#pragma unused cmdtext
new string[120],pilotname[24],pasname[24];

if (pInfo[playerid][isPassenger] == 0){
	SendClientMessage(playerid,COLOR_RED,"You did not book a flight.");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /bookflight [your destination].");
	return 1;
	}

GetPlayerName(playerid,pasname,sizeof(pasname));

if (IsPlayerInCheckpoint(playerid) && pInfo[playerid][City] == 1){
GetPlayerName(LSPilot,pilotname,sizeof(pilotname));
DisablePlayerCheckpoint(playerid);

	if (pInfo[playerid][paradrop] == 0){
		SetPlayerInterior(playerid,1);
		SetPlayerPos(playerid,2.384830,33.103397,1199.849976);
		SetCameraBehindPlayer(playerid);
		}
	if (pInfo[playerid][paradrop] == 1){
		SetPlayerInterior(playerid,9);
		SetPlayerPos(playerid,315.856170,1024.496459,1949.797363);
		SetCameraBehindPlayer(playerid);
		GivePlayerWeapon(playerid,46,1);
	 	}

SendClientMessage(playerid,BBLUE,"You boarded the plane. Enjoy your flight.");
format(string,sizeof(string),"%s (ID %d) boarded your plane",pasname,playerid);
SendClientMessage(LSPilot,BBLUE,string);
pInfo[playerid][Boarded] = 1;
pInfo[playerid][paradrop] = 0;
return 1;
}

if (IsPlayerInCheckpoint(playerid) && pInfo[playerid][City] == 2){
GetPlayerName(SFPilot,pilotname,sizeof(pilotname));
DisablePlayerCheckpoint(playerid);


		SetPlayerInterior(playerid,1);
		SetPlayerPos(playerid,2.384830,33.103397,1199.849976);
		SetCameraBehindPlayer(playerid);


SendClientMessage(playerid,BBLUE,"You boarded the plane. Enjoy your flight.");
format(string,sizeof(string),"%s (ID %d) boarded your plane",pasname,playerid);
SendClientMessage(SFPilot,BBLUE,string);
pInfo[playerid][Boarded] = 1;
pInfo[playerid][paradrop] = 0;
return 1;
}

if (IsPlayerInCheckpoint(playerid) && pInfo[playerid][City] == 3){
GetPlayerName(LVPilot,pilotname,sizeof(pilotname));
DisablePlayerCheckpoint(playerid);


		SetPlayerInterior(playerid,1);
		SetPlayerPos(playerid,2.384830,33.103397,1199.849976);
		SetCameraBehindPlayer(playerid);


SendClientMessage(playerid,BBLUE,"You boarded the plane. Enjoy your flight.");
format(string,sizeof(string),"%s (ID %d) boarded your plane",pasname,playerid);
SendClientMessage(LVPilot,BBLUE,string);
pInfo[playerid][Boarded] = 1;
pInfo[playerid][paradrop] = 0;
return 1;
}

SendClientMessage(playerid,COLOR_RED,"You need to be in the red checkpoint to board the plane");
return 0;
}

//Function_takeoff
if(strcmp(cmd,"/takeoff",true)==0)
{
#pragma unused cmdtext

if(pInfo[playerid][City] == 1){
	if (LSPilot != playerid && !IsPlayerInVehicle(playerid,14) && !IsPlayerInVehicle(playerid,139)){
		SendClientMessage(playerid,COLOR_RED,"You are not the charter pilot or not in a jet");
		SendClientMessage(playerid,COLOR_YELLOW,"Use /charter and get in the Shamal or Andromeda.");
		return 0;
		}

LSFlight[Flying] = 1;
LSFlight[OnBlocks] = 0;
LSFlight[GreenLight] = 0;
GameTextForPlayer(LSPilot,"~y~ LSAP Tower ~w~:~n~ Cleared for takeoff",5000,0);
SendClientMessageToAll(BBLUE,"A charter flight is taking off at LSAP...");
WriteEcho("[server] A charter flight is taking off at LSAP");
return 1;
}

if(pInfo[playerid][City] == 2){
	if (SFPilot != playerid && !IsPlayerInVehicle(playerid,155)){
		SendClientMessage(playerid,COLOR_RED,"You are not the charter pilot or not in a jet");
		SendClientMessage(playerid,COLOR_YELLOW,"Use /charter and get in the Shamal.");
		return 0;
		}

SFFlight[Flying] = 1;
SFFlight[OnBlocks] = 0;
SFFlight[GreenLight] = 0;
GameTextForPlayer(SFPilot,"~y~ SFAP Tower ~w~:~n~ Cleared for takeoff",5000,0);
SendClientMessageToAll(BBLUE,"A charter flight is taking off at SFAP...");
WriteEcho("[server] A charter flight is taking off at SFAP");
return 1;
}

if(pInfo[playerid][City] == 3){
	if (LVPilot != playerid && !IsPlayerInVehicle(playerid,167)){
		SendClientMessage(playerid,COLOR_RED,"You are not the charter pilot or not in a jet");
		SendClientMessage(playerid,COLOR_YELLOW,"Use /charter and get in the Shamal.");
		return 0;
		}

LVFlight[Flying] = 1;
LVFlight[OnBlocks] = 0;
LVFlight[GreenLight] = 0;
GameTextForPlayer(LVPilot,"~y~ LVAP Tower ~w~:~n~ Cleared for takeoff",5000,0);
SendClientMessageToAll(BBLUE,"A charter flight is taking off at LVAP...");
WriteEcho("[server] A charter flight is taking off at LVAP");
return 1;
}

return 0;
}

//Function_onblocks
if(strcmp(cmd,"/onblocks",true)==0)
{
#pragma unused cmdtext

if(pInfo[playerid][City] == 1){
	if (LSPilot != playerid && !IsPlayerInVehicle(playerid,14) && !IsPlayerInVehicle(playerid,139)){
	SendClientMessage(playerid,COLOR_RED,"You are not the charter pilot or not in a jet");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /charter and get in the Shamal or Andromeda.");
	return 1;
	}

	if (LSFlight[Flying] == 0){
	SendClientMessage(playerid,COLOR_RED,"You did not even takeoff - No point in 'on the blocks'.");
	return 0;
	}

LSFlight[Flying] = 0;
LSFlight[OnBlocks] = 1;
LSFlight[GreenLight] = 0;
GameTextForPlayer(LSPilot,"~y~ Apron Control ~w~:~n~ Flight Plan cancelled. Welcome at our airport.",5000,0);
SendClientMessageToAll(BBLUE,"LS Charter Flight landed and on the blocks.");
SendClientMessageToAll(COLOR_YELLOW,"Type /unboard to leave the plane");
WriteEcho("[server] LS Charter Flight landed and on the blocks");
return 1;
}

if(pInfo[playerid][City] == 2){
	if (SFPilot != playerid && !IsPlayerInVehicle(playerid,155)){
	SendClientMessage(playerid,COLOR_RED,"You are not the charter pilot or not in a jet");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /charter and get in the Shamal.");
	return 1;
	}

	if (SFFlight[Flying] == 0){
	SendClientMessage(playerid,COLOR_RED,"You did not even takeoff - No point in 'on the blocks'.");
	return 0;
	}

SFFlight[Flying] = 0;
SFFlight[OnBlocks] = 1;
SFFlight[GreenLight] = 0;
GameTextForPlayer(SFPilot,"~y~ Apron Control ~w~:~n~ Flight Plan cancelled. Welcome at our airport.",5000,0);
SendClientMessageToAll(BBLUE,"SF Charter Flight landed and on the blocks.");
SendClientMessageToAll(COLOR_YELLOW,"Type /unboard to leave the plane");
WriteEcho("[server] SF Charter Flight landed and on the blocks");
return 1;
}

if(pInfo[playerid][City] == 3){
	if (LVPilot != playerid && !IsPlayerInVehicle(playerid,167)){
	SendClientMessage(playerid,COLOR_RED,"You are not the charter pilot or not in a jet");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /charter and get in the Shamal.");
	return 1;
	}

	if (LVFlight[Flying] == 0){
	SendClientMessage(playerid,COLOR_RED,"You did not even takeoff - No point in 'on the blocks'.");
	return 0;
	}

LVFlight[Flying] = 0;
LVFlight[OnBlocks] = 1;
LVFlight[GreenLight] = 0;
GameTextForPlayer(LVPilot,"~y~ Apron Control ~w~:~n~ Flight Plan cancelled. Welcome at our airport.",5000,0);
SendClientMessageToAll(BBLUE,"LV Charter Flight landed and on the blocks.");
SendClientMessageToAll(COLOR_YELLOW,"Type /unboard to leave the plane");
WriteEcho("[server] LV Charter Flight landed and on the blocks");
return 1;
}

return 0;
}

//Function_GL
if(strcmp(cmd,"/GL",true)==0)
{
#pragma unused cmdtext

if(pInfo[playerid][City] == 1){
	if (LSPilot != playerid && !IsPlayerInVehicle(playerid,14) && !IsPlayerInVehicle(playerid,139)){
	SendClientMessage(playerid,COLOR_RED,"You are not the charter pilot or not in a jet");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /charter and get in the Shamal or Andromeda.");
	return 1;
	}

	if (LSFlight[Flying] == 0){
	SendClientMessage(playerid,COLOR_RED,"You did not even takeoff - No point in giving green light for chuters.");
	return 0;
	}

LSFlight[GreenLight] = 1;
LSFlight[OnBlocks] = 0;

GameTextForAll("~g~ GREEN LIGHT! ~n~ ~n~ ~g~GREEN LIGHT! ~n~ ~n~ ~w~ GO GO GO!",5000,0);
SendClientMessageToAll(COLOR_YELLOW,"LS PARACHUTERS type /unboard now!!!");
SendClientMessage(LSPilot,COLOR_YELLOW,"Type /rl after all chuters unboarded!");
WriteEcho("[server] [LS charter flight] GREEN LIGHT!");
return 1;
}

if(pInfo[playerid][City] == 2){
	if (SFPilot != playerid && !IsPlayerInVehicle(playerid,155)){
	SendClientMessage(playerid,COLOR_RED,"You are not the charter pilot or not in a jet");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /charter and get in the Shamal.");
	return 1;
	}

	if (SFFlight[Flying] == 0){
	SendClientMessage(playerid,COLOR_RED,"You did not even takeoff - No point in giving green light for chuters.");
	return 0;
	}

SFFlight[GreenLight] = 1;
SFFlight[OnBlocks] = 0;

GameTextForAll("~g~ GREEN LIGHT! ~n~ ~n~ ~g~GREEN LIGHT! ~n~ ~n~ ~w~ GO GO GO!",5000,0);
SendClientMessageToAll(COLOR_YELLOW,"SF PARACHUTERS type /unboard now!!!");
SendClientMessage(LSPilot,COLOR_YELLOW,"Type /rl after all chuters unboarded!");
WriteEcho("[server] [SF] GREEN LIGHT!");
return 1;
}

if(pInfo[playerid][City] == 3){
	if (LVPilot != playerid && !IsPlayerInVehicle(playerid,167)){
	SendClientMessage(playerid,COLOR_RED,"You are not the charter pilot or not in a jet");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /charter and get in the Shamal.");
	return 1;
	}

	if (LVFlight[Flying] == 0){
	SendClientMessage(playerid,COLOR_RED,"You did not even takeoff - No point in giving green light for chuters.");
	return 0;
	}

LVFlight[GreenLight] = 1;
LVFlight[OnBlocks] = 0;

GameTextForAll("~g~ GREEN LIGHT! ~n~ ~n~ ~g~GREEN LIGHT! ~n~ ~n~ ~w~ GO GO GO!",5000,0);
SendClientMessageToAll(COLOR_YELLOW,"LV PARACHUTERS type /unboard now!!!");
SendClientMessage(LSPilot,COLOR_YELLOW,"Type /rl after all chuters unboarded!");
WriteEcho("[server] [LV] GREEN LIGHT!");
return 1;
}

return 0;
}

//Function_RL
if(strcmp(cmd,"/RL",true)==0)
{
#pragma unused cmdtext

if(pInfo[playerid][City] == 1){
	if (LSPilot != playerid && !IsPlayerInVehicle(playerid,14) && !IsPlayerInVehicle(playerid,139)){
	SendClientMessage(playerid,COLOR_RED,"You are not the charter pilot or not in a jet");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /charter and get in the Shamal or Andromeda.");
	return 1;
	}

	if (LSFlight[Flying] == 0){
	SendClientMessage(playerid,COLOR_RED,"You did not even takeoff - No point in giving green light for chuters.");
	return 0;
	}

LSFlight[GreenLight] = 0;
LSFlight[OnBlocks] = 0;

GameTextForAll("~r~ RED LIGHT! ~n~ ~n~ ~r~RED LIGHT! ~n~ ~n~ ~w~ Door Locked!",5000,0);
return 1;
}

if(pInfo[playerid][City] == 2){
	if (SFPilot != playerid && !IsPlayerInVehicle(playerid,155)){
	SendClientMessage(playerid,COLOR_RED,"You are not the charter pilot or not in a jet");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /charter and get in the Shamal.");
	return 1;
	}

	if (SFFlight[Flying] == 0){
	SendClientMessage(playerid,COLOR_RED,"You did not even takeoff - No point in giving green light for chuters.");
	return 0;
	}

SFFlight[GreenLight] = 0;
SFFlight[OnBlocks] = 0;

GameTextForAll("~r~ RED LIGHT! ~n~ ~n~ ~r~RED LIGHT! ~n~ ~n~ ~w~ Door Locked!",5000,0);
return 1;
}

if(pInfo[playerid][City] == 3){
	if (LVPilot != playerid && !IsPlayerInVehicle(playerid,167)){
	SendClientMessage(playerid,COLOR_RED,"You are not the charter pilot or not in a jet");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /charter and get in the Shamal.");
	return 1;
	}

	if (LVFlight[Flying] == 0){
	SendClientMessage(playerid,COLOR_RED,"You did not even takeoff - No point in giving green light for chuters.");
	return 0;
	}

LVFlight[GreenLight] = 0;
LVFlight[OnBlocks] = 0;

GameTextForAll("~r~ RED LIGHT! ~n~ ~n~ ~r~RED LIGHT! ~n~ ~n~ ~w~ Door Locked!",5000,0);
return 1;
}

return 0;
}

//Function_unboard
if(strcmp(cmd,"/unboard",true)==0)
{
#pragma unused cmdtext
new string[120];

GetPlayerName(playerid,player,sizeof(player));

if(pInfo[playerid][City] == 1){

if (!LSFlight[GreenLight] && !LSFlight[OnBlocks]){
	SendClientMessage(playerid,COLOR_RED,"The exits are still blocked!");
	SendClientMessage(playerid,COLOR_YELLOW,"Wait for the pilot to enter /GL or /onblocks");
	return 1;
	}

new Float:coorX;
new Float:coorY;
new Float:coorZ;

GetPlayerPos(LSPilot,coorX,coorY,coorZ);
SetPlayerInterior(playerid,0);
coorX = coorX - 5.0000;
coorY = coorY - 5.0000;
SetPlayerPos(playerid,coorX,coorY,coorZ);

pInfo[playerid][isPassenger] = 0;
format(string,sizeof(string),"[server] %s unboarded the plane",player);
SendClientMessageToAll(COLOR_YELLOW,string);
WriteEcho(string);
pInfo[playerid][paradrop] = 0;
pInfo[playerid][Boarded] = 0;
return 1;
}

if(pInfo[playerid][City] == 2){

if (!SFFlight[OnBlocks]){
	SendClientMessage(playerid,COLOR_RED,"The exits are still blocked!");
	SendClientMessage(playerid,COLOR_YELLOW,"Wait for the pilot to enter /onblocks");
	return 1;
	}

new Float:coorX;
new Float:coorY;
new Float:coorZ;

GetPlayerPos(SFPilot,coorX,coorY,coorZ);
SetPlayerInterior(playerid,0);
coorX = coorX - 5.0000;
coorY = coorY - 5.0000;
SetPlayerPos(playerid,coorX,coorY,coorZ);

pInfo[playerid][isPassenger] = 0;
format(string,sizeof(string),"[server] %s unboarded the plane",player);
SendClientMessageToAll(COLOR_YELLOW,string);
WriteEcho(string);
pInfo[playerid][Boarded] = 0;
pInfo[playerid][paradrop] = 0;
return 1;
}

if(pInfo[playerid][City] == 3){

if (!LVFlight[OnBlocks]){
	SendClientMessage(playerid,COLOR_RED,"The exits are still blocked!");
	SendClientMessage(playerid,COLOR_YELLOW,"Wait for the pilot to enter /onblocks");
	return 1;
	}
new Float:coorX;
new Float:coorY;
new Float:coorZ;

GetPlayerPos(LVPilot,coorX,coorY,coorZ);
SetPlayerInterior(playerid,0);
coorX = coorX - 5.0000;
coorY = coorY - 5.0000;
SetPlayerPos(playerid,coorX,coorY,coorZ);

pInfo[playerid][isPassenger] = 0;
format(string,sizeof(string),"[server] %s unboarded the plane",player);
SendClientMessageToAll(COLOR_YELLOW,string);
WriteEcho(string);
pInfo[playerid][Boarded] = 0;
pInfo[playerid][paradrop] = 0;
return 1;
}

return 0;
}

//Function_rob
if(strcmp(cmd,"/rob",true)==0)
{
	new victimname[24],victim,vicmax,string[120],gain,robmax;
	GetPlayerName(playerid,player,24);
	victim = strval(cmdtext);
	GetPlayerName(victim,victimname,24);
	if(!strlen(cmdtext))
	{
	    SendClientMessage(playerid,COLOR_GREY,"Usage: /rob [ID]");
	    if (pInfo[playerid][Rob] == 0){
	    new amount;
	    amount = random(1000);
	    pInfo[playerid][Rob] = 1;
	    GivePlayerMoney(playerid,amount);
	    format(string,sizeof(string),"You robbed a nearby store and got %d$.",amount);
	    SendClientMessage(playerid,BBLUE,string);
	    }
		return 1;
	}

	if (pInfo[playerid][Jailed]){
	SendClientMessage(playerid,COLOR_RED,"/rob is disabled in jail.");
	return 0;
	}

	vicmax = GetPlayerMoney(victim);

 	if (vicmax <= 1000) {
 	SendClientMessage(playerid,COLOR_RED,"Your victim's purse is empty. Nothing to rob.");
 	return 0;
 	}

 	robmax = vicmax / 10; // Maximum = 10% of the other player's money
 	gain = random(robmax);


	if(IsPlayerConnected(victim) && GetDistanceBetweenPlayers(playerid,victim) <= 5 && victim!=playerid)
	{
	format(string,sizeof(string),"You robbed %s (ID %d) %d$ out of his purse.",victimname,victim,gain);
		if (gain >= 100){
		SendClientMessage(playerid,COLOR_RED, "The victim reported the theft to the police. You are now wanted.");
		pInfo[playerid][AddWanted] = 1;
		}
	SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
	format(string,sizeof(string),"%s (ID %d) robbed %d$ out of your purse.",player,playerid,gain);
	SendClientMessage(victim,COLOR_RED,string);
	format(string,sizeof(string),"[server] %s (ID %d) robbed %d$ out of %s purse (ID %d).",player,playerid,gain,victimname,victim);
	print(string);
	WriteEcho(string);
	GivePlayerMoney(playerid,gain);
	GivePlayerMoney(victim,-gain);
    return 1;
	}
	SendClientMessage(playerid,COLOR_RED, "The player you tried to rob out is too far away, offline or yourself.");
	return 0;
}

//Function_minigames
if(strcmp(cmd,"/minigames",true)==0)
{
	#pragma unused cmdtext
    SendClientMessage(playerid,COLOR_YELLOW,"Pure RPG - Minigames");
    SendClientMessage(playerid,COLOR_RED,"Minigames can only be started by staff members (Moderators, Admins, Server Owner)");
    SendClientMessage(playerid,COLOR_RED,"Minigames are just a part of the gamemmode and not the gamemmode itself...");
    SendClientMessage(playerid,COLOR_ORANGE,"Taking part in a minigame is voluntary.");
    SendClientMessage(playerid,COLOR_WHITE,"[Staff] /start burn - Starts 'Burn Down Area 69'");
    SendClientMessage(playerid,COLOR_WHITE,"/burn - For players to join 'Burn Down Area 69'");
    SendClientMessage(playerid,COLOR_WHITE,"[Staff] /start derby - Starts 'Destruction derby on the skydive centre'");
    SendClientMessage(playerid,COLOR_WHITE,"/derby - For players to join 'Destruction derby on the skydive centre'");
    return 1;
}

//Function
if(strcmp(cmd,"/burn",true)==0)
{
#pragma unused cmdtext
new gamestr[120];

GetPlayerName(playerid,player,sizeof(player));

	if (!Minigames[BurnPrepare]){
	SendClientMessage(playerid,COLOR_RED,"This minigame is not open to be joined.");
	return 0;
	}

	if (pInfo[playerid][isPassenger] || pInfo[playerid][Cuffed] || pInfo[playerid][Jailed]){
	SendClientMessage(playerid,COLOR_RED,"You are not allowed to join the minigame because you are either handcuffed, jailed or you have booked a flight.");
	return 0;
	}

	if (pInfo[playerid][PlayBurn]){
	pInfo[playerid][PlayBurn] = 0;
	SendClientMessage(playerid,COLOR_YELLOW,"You have quit the minigame 'Burn down Area 69'");
	format(gamestr,sizeof(gamestr),"%s (ID %d) has quit the minigame",player,playerid);
	print(gamestr);
	SendClientMessageToAll(COLOR_GREY,gamestr);
	return 1;
	}

	if (!pInfo[playerid][PlayBurn]){
	SendClientMessage(playerid,COLOR_YELLOW,"You have joined the minigame 'Burn down Area 69'");
	pInfo[playerid][PlayBurn] = 1;
	format(gamestr,sizeof(gamestr),"%s (ID %d) has joined the minigame",player,playerid);
	print(gamestr);
	SendClientMessageToAll(COLOR_GREY,gamestr);
    return 1;
	}
return 1;
}

//Function_derby
if(strcmp(cmd,"/derby",true)==0)
{
#pragma unused cmdtext
new gamestr[120];

GetPlayerName(playerid,player,sizeof(player));

	if (!Minigames[DerbyPrepare]){
	SendClientMessage(playerid,COLOR_RED,"This minigame is not open to be joined.");
	return 0;
	}

	if (pInfo[playerid][isPassenger] || pInfo[playerid][Cuffed] || pInfo[playerid][Jailed]){
	SendClientMessage(playerid,COLOR_RED,"You are not allowed to join the minigame because you are either handcuffed, jailed or you have booked a flight.");
	return 0;
	}

	if (pInfo[playerid][PlayDerby]){
	pInfo[playerid][PlayDerby] = 0;
	SendClientMessage(playerid,COLOR_YELLOW,"You have quit the minigame 'Destruction derby on the skydive centre'");
	format(gamestr,sizeof(gamestr),"%s (ID %d) has quit the minigame",player,playerid);
	print(gamestr);
	SendClientMessageToAll(COLOR_GREY,gamestr);
	return 1;
	}

	if (!pInfo[playerid][PlayDerby]){
	SendClientMessage(playerid,COLOR_YELLOW,"You have joined the minigame 'Destruction derby on the skydive centre'");
	pInfo[playerid][PlayDerby] = 1;
	format(gamestr,sizeof(gamestr),"%s (ID %d) has joined the minigame",player,playerid);
	print(gamestr);
	SendClientMessageToAll(COLOR_GREY,gamestr);
    return 1;
	}
return 1;
}

//Function_fuel
if(strcmp(cmd,"/fuel",true)==0)
{
#pragma unused cmdtext
new amount,callername[24],string[120],strresult1,strresult2,strresult3,aviablemoney;


if (!strlen(cmdtext)){
	SendClientMessage(playerid,COLOR_GREY,"Usage: /fuel - Gives you the percentage of fuel you have left");
	SendClientMessage(playerid,COLOR_GREY,"Usage: /fuel 1 - Set a checkpoint on your radar to find fuel station #1");
	SendClientMessage(playerid,COLOR_GREY,"Usage: /fuel 2 - Set a checkpoint on your radar to find fuel station #2");
	SendClientMessage(playerid,COLOR_GREY,"Usage: /fuel yes - Refuels your car to 100 (cost depending on how much you have left)");
	format(string,sizeof(string),"Fuel left: %d%",pInfo[playerid][fuel]);
	SendClientMessage(playerid,COLOR_ORANGE,string);
	return 1;
	}
GetPlayerName(playerid,callername,sizeof(callername));

strmid(cmdtext,cmdtext,0,2,3);

strresult1 = strfind(cmdtext,"1",true,0);
strresult2 = strfind(cmdtext,"2",true,0);
strresult3 = strfind(cmdtext,"y",true,0);

if (strresult1!=-1 && pInfo[playerid][City] == 1){
	SetPlayerCheckpoint(playerid,-91.000,-1169.0000,2.0000,10);
	SendClientMessage(playerid,COLOR_ORANGE,"Waypoint set. Go to the red checkpoint on your radar.");
	return 1;
	}

if (strresult1!=-1 && pInfo[playerid][City] == 2){
	SetPlayerCheckpoint(playerid,-1676.0000,413.0000,7.0000,10);
	SendClientMessage(playerid,COLOR_ORANGE,"Waypoint set. Go to the red checkpoint on your radar.");
	return 1;
	}

if (strresult1!=-1 && pInfo[playerid][City] == 3){

	SetPlayerCheckpoint(playerid,2115.0000,920.0000,11.0000,10);
	SendClientMessage(playerid,COLOR_ORANGE,"Waypoint set. Go to the red checkpoint on your radar.");
	return 1;
	}

if (strresult2!=-1 && pInfo[playerid][City] == 1){
	SetPlayerCheckpoint(playerid,1941.0000,-1773.0000,12.0000,10);
	SendClientMessage(playerid,COLOR_ORANGE,"Waypoint set. Go to the red checkpoint on your radar.");
	return 1;
	}

if (strresult2!=-1 && pInfo[playerid][City] == 2){
	SetPlayerCheckpoint(playerid,-2409.0000,977.0000,45.0000,10);
	SendClientMessage(playerid,COLOR_ORANGE,"Waypoint set. Go to the red checkpoint on your radar.");
	return 1;
	}

if (strresult2!=-1 && pInfo[playerid][City] == 3){
	SetPlayerCheckpoint(playerid,2203.0000,2474.0000,11.0000,10);
	SendClientMessage(playerid,COLOR_ORANGE,"Waypoint set. Go to the red checkpoint on your radar.");
	return 1;
	}

if (strresult3!=-1 && IsPlayerInCheckpoint(playerid)){

	amount = 100 - pInfo[playerid][fuel];
	amount = amount * 2;

	DisablePlayerCheckpoint(playerid);

aviablemoney = GetPlayerMoney(playerid);

 		if(amount>aviablemoney){
 	    SendClientMessage(playerid,COLOR_RED,"You do not have that much money. :P");
		return 1;
 		}

	pInfo[playerid][fuel] = 100;
	GivePlayerMoney(playerid,-amount);
	format(string,sizeof(string),"2$ per unit. Price paid: %d$",amount);
	SendClientMessage(playerid,COLOR_ORANGE,string);
	return 1;
	}
SendClientMessage(playerid,COLOR_RED,"You can refuel only at a fuel station!");
SendClientMessage(playerid,COLOR_RED,"Use /fuel 1. Or use the alternative /fuel 2.");
return 1;
}

//Function_showhouse
if(strcmp(cmd,"/showhouse",true)==0)
{
#pragma unused cmdtext
	new donator[24],recID,reciever[24],string1[120], string2[120];
	new tmp1[255],ho;

	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /showhouse [ID]");
	    DisablePlayerCheckpoint(playerid);
	    SendClientMessage(playerid,COLOR_YELLOW,"House Checkpoint disabled");
		return 1;
		}

	recID = strval(cmdtext);
	GetPlayerName(recID,reciever,24);
    GetPlayerName(playerid,donator,24);

   		if (!IsPlayerConnected(recID)){
        SendClientMessage(playerid,COLOR_RED,"ID not found or player not connected anymore :(");
        return 0;
   	    }

tmp1 = dini_Get(udb_encode(reciever),"House");
ho = strval(tmp1);

if (ho == 0){
SendClientMessage(playerid,COLOR_RED,"This player does not own a house");
return 0;
}

new Float:posX=floatstr(dini_Get(udb_encode(reciever),"SpawnX"));
new Float:posY=floatstr(dini_Get(udb_encode(reciever),"SpawnY"));
new Float:posZ=floatstr(dini_Get(udb_encode(reciever),"SpawnZ"));

SetPlayerCheckpoint(playerid,posX,posY,posZ,5);
format(string2,sizeof(string2),"%s House is on your radar as red icon",reciever);
format(string1,sizeof(string1),"%s (ID %d) is on his way to your house",donator,playerid);
SendClientMessage(recID,COLOR_YELLOW,string1);
SendClientMessage(playerid,COLOR_YELLOW,string2);
SendClientMessage(playerid,COLOR_YELLOW,"Type '/showhouse' to disable the checkpoint again.");
return 1;
}

//Function_bizhelp
if(strcmp(cmd,"/bizhelp",true)==0)
{
	#pragma unused cmdtext
    SendClientMessage(playerid,COLOR_YELLOW,"Pure RPG - Business Help");
    SendClientMessage(playerid,COLOR_RED,"Every player can create a biz. The business tax is estaminated at biz creation.");
    SendClientMessage(playerid,COLOR_RED,"The higher the start capital is, the more biz tax you need to pay (is removed from the payday biz gain)");
    SendClientMessage(playerid,COLOR_RED,"Every Payday the business gain is different depending on the biz tax and the current biz capital (= bank account balance)");
    SendClientMessage(playerid,COLOR_ORANGE,"Business commands:");
    SendClientMessage(playerid,COLOR_WHITE,"/createbiz [name] - Creates a biz at WHERE YOU STAND with the given name. COSTS 100.000$");
    SendClientMessage(playerid,COLOR_WHITE,"/bizrename [new name] - Change's your biz name for free");
    SendClientMessage(playerid,COLOR_WHITE,"/ad [text] - Displays an advert for your biz with either your given text or a standard text");
    SendClientMessage(playerid,COLOR_WHITE,"/showbiz [ID] - Shows whether and where a player has a business");
    SendClientMessage(playerid,COLOR_WHITE,"/retire - Deletes your business. NO REFUND other then the biz gain you earned as long as you had it.");
    return 1;
}

//Function_createbiz
if(strcmp(cmd,"/createbiz",true)==0)
{
new spawnstr[120];

GetPlayerName(playerid,player,sizeof(player));


	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /createbiz [business name]");
   	    SendClientMessage(playerid,COLOR_ORANGE,"Biz creation investment: 100.000$");
   	    SendClientMessage(playerid,COLOR_YELLOW,"ATTENTION: A checkpoint for other players to see where your biz is...");
   	    SendClientMessage(playerid,COLOR_YELLOW,"... will be created at where you stand when you enter the command!!!!");
   	    SendClientMessage(playerid,COLOR_YELLOW,"WHEN YOU WANT TO CHANGE THIS POSITION LATER YOU NEED TO PAY 100000$ again!");
		return 1;
	}

new aviablemoney=GetPlayerMoney(playerid);

	if (aviablemoney<100000){
	SendClientMessage(playerid,COLOR_RED,"You do not have enough money :(");
	return 0;
	}

GivePlayerMoney(playerid,-100000);

new Float:posX;
new Float:posY;
new Float:posZ;


GetPlayerPos(playerid,posX,posY,posZ);

new balance=strval(dini_Get(udb_encode(player),"Bank"));
new bg=random(balance / 5);

dini_IntSet(udb_encode(player),"Biz",1);
dini_Set(udb_encode(player),"BizName",cmdtext[0]);
dini_IntSet(udb_encode(player),"BizX",floatround(posX));
dini_IntSet(udb_encode(player),"BizY",floatround(posY));
dini_IntSet(udb_encode(player),"BizZ",floatround(posZ));
dini_IntSet(udb_encode(player),"BizGain",bg);


format(spawnstr,sizeof(spawnstr),"[server] %s opened a business: %s",player,cmdtext[0]);
print(spawnstr);
WriteEcho(spawnstr);
SendClientMessageToAll(COLOR_ORANGE,spawnstr);

return 1;
}

//Function_retire
if(strcmp(cmd,"/retire",true)==0)
{
#pragma unused cmdtext
new spawnstr[255],strresult;


if (!strlen(cmdtext)){
	SendClientMessage(playerid,COLOR_GREY,"Usage: /retire yes");
	SendClientMessage(playerid,COLOR_ORANGE,"ATTENTION: This command deletes your business without any refund!");
	return 1;
	}
GetPlayerName(playerid,player,sizeof(player));

strmid(cmdtext,cmdtext,0,4,5);

strresult = strfind(cmdtext,"yes",true,0);

if (strresult!=-1){

	dini_IntSet(udb_encode(player),"Biz",0);
	dini_IntSet(udb_encode(player),"BizName",0);
	dini_IntSet(udb_encode(player),"BizX",0);
	dini_IntSet(udb_encode(player),"BizY",0);
	dini_IntSet(udb_encode(player),"BizZ",0);
	dini_IntSet(udb_encode(player),"BizGain",0);
	format(spawnstr,sizeof(spawnstr),"[server] %s RETIRED from the business world",player);
	print(spawnstr);
	WriteEcho(spawnstr);
	SendClientMessageToAll(COLOR_ORANGE,spawnstr);
	return 1;
	}

return 1;
}

//Function_bizrename
if(strcmp(cmd,"/bizrename",true)==0)
{
#pragma unused cmdtext
new spawnstr[225];

	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /bizrename [new name]");
	    return 1;
		}
GetPlayerName(playerid,player,sizeof(player));
dini_Set(udb_encode(player),"BizName",cmdtext[0]);

format(spawnstr,sizeof(spawnstr),"[server] %s renamed his business: %s",player,cmdtext[0]);
print(spawnstr);
WriteEcho(spawnstr);
SendClientMessageToAll(COLOR_ORANGE,spawnstr);

return 1;
}

//Function_showbiz
if(strcmp(cmd,"/showbiz",true)==0)
{
#pragma unused cmdtext
	new donator[24],recID,reciever[225],string1[120], string2[120];
	new tmp1[255],ho;

	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /showbiz [ID]");
	    DisablePlayerCheckpoint(playerid);
	    SendClientMessage(playerid,COLOR_YELLOW,"Biz Checkpoint disabled");
		return 1;
		}

	recID = strval(cmdtext);
	GetPlayerName(recID,reciever,225);
    GetPlayerName(playerid,donator,24);

   		if (!IsPlayerConnected(recID)){
        SendClientMessage(playerid,COLOR_RED,"ID not found or player not connected anymore :(");
        return 0;
   	    }

tmp1 = dini_Get(udb_encode(reciever),"Biz");
ho = strval(tmp1);

	if (ho == 0){
	SendClientMessage(playerid,COLOR_RED,"This player does not own a business");
	return 0;
	}

new Float:posX=floatstr(dini_Get(udb_encode(reciever),"BizX"));
new Float:posY=floatstr(dini_Get(udb_encode(reciever),"BizY"));
new Float:posZ=floatstr(dini_Get(udb_encode(reciever),"BizZ"));

SetPlayerCheckpoint(playerid,posX,posY,posZ,5);
format(reciever,sizeof(reciever),"%s",dini_Get(udb_encode(reciever),"BizName"));
format(string2,sizeof(string2),"'%s' is on your radar as red icon",reciever);
format(string1,sizeof(string1),"%s (ID %d) is on his way to your business",donator,playerid);
SendClientMessage(recID,COLOR_YELLOW,string1);
SendClientMessage(playerid,COLOR_YELLOW,string2);
SendClientMessage(playerid,COLOR_YELLOW,"Type '/showbiz' to disable the checkpoint again.");
return 1;
}

//Function_ad
if(strcmp(cmd,"/ad",true)==0)
{
#pragma unused cmdtext
new tmp1[255],string1[120],ho;

GetPlayerName(playerid,player,sizeof(player));
tmp1 = dini_Get(udb_encode(player),"Biz");
ho = strval(tmp1);

	if (ho == 0){
	SendClientMessage(playerid,COLOR_RED,"Only business owners can advertise.");
	SendClientMessage(playerid,COLOR_YELLOW,"Type /bizhelp");
	return 0;
	}

	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /ad [text]");
	    SendClientMessage(playerid,COLOR_RED,"No text results in a standard message displaying your business name and ID.");
	    SendClientMessage(playerid,COLOR_RED,"You can advertise every 15 minutes.");

			if (pInfo[playerid][Ad] == 0){
			tmp1 = dini_Get(udb_encode(player),"BizName");
		    format(string1,sizeof(string1),"[server] (Ad) %s - /showbiz %d",tmp1,playerid);
			print(string1);
			WriteEcho(string1);
			SendClientMessageToAll(COLOR_ORANGE,string1);
		    pInfo[playerid][Ad] = 1;
		    }
		return 1;
		}
if (pInfo[playerid][Ad] == 0){
	format(string1,sizeof(string1),"[server] (Ad) %s - /showbiz %d",cmdtext[0],playerid);
    print(string1);
	WriteEcho(string1);
	SendClientMessageToAll(COLOR_ORANGE,string1);
	pInfo[playerid][Ad] = 1;
	return 1;
	}
SendClientMessage(playerid,COLOR_RED,"You have already placed an ad in the last 15 minutes.");
return 1;
}

//Function_lock
if(strcmp(cmd,"/lock",true)==0)
{
#pragma unused cmdtext
new vID;

	if (IsPlayerInAnyVehicle(playerid)){
	vID = GetPlayerVehicleID(playerid);

		for (new l;l<MAX_PLAYERS;l++){
			if (IsPlayerConnected(l)){
 	 	  SetVehicleParamsForPlayer(vID, l,0,1);
			}
		}
	SendClientMessage(playerid,BBLUE,"You have locked your vehicle for all players (including yourself)");
	return 1;
	}

vID = pInfo[playerid][vehicle];

if (vID == 0) return 0;

for (new l;l<MAX_PLAYERS;l++){
	if (IsPlayerConnected(l)){
    SetVehicleParamsForPlayer(vID, l,0,1);
	}
}
SendClientMessage(playerid,BBLUE,"You have locked your vehicle for all players (including yourself)");

return 1;
}

//Function_unlock
if(strcmp(cmd,"/unlock",true)==0)
{
#pragma unused cmdtext
new vID;

if (!strlen(cmdtext) && IsPlayerInAnyVehicle(playerid)){
vID = GetPlayerVehicleID(playerid);

for (new l;l<MAX_PLAYERS;l++){
	if (IsPlayerConnected(l)){
    SetVehicleParamsForPlayer(vID, l,0,0);
	}
}
SendClientMessage(playerid,BBLUE,"You have unlocked your vehicle for all players (including yourself)");
return 1;
}

if (pInfo[playerid][vehicle]!=0){
    SetVehicleParamsForPlayer(pInfo[playerid][vehicle], playerid,0,0);
    SendClientMessage(playerid,BBLUE,"You have unlocked your private car only for you.");
    return 1;
    }

SendClientMessage(playerid,COLOR_RED,"You dont own a vehicle to be unlocked only for you.");
return 0;
}

// ******************* ADMIN FUNCTIONS **************************

//Function_start
if(strcmp(cmd,"/start",true)==0)
{
#pragma unused cmdtext
new control1,control2,tmp[255],gamestr[120];

GetPlayerName(playerid,player,sizeof(player));

tmp = dini_Get(udb_encode(player),"Level");

if(strval(tmp)>=2 && pInfo[playerid][Admin]) {
	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /start burn");
	    SendClientMessage(playerid,COLOR_GREY,"Starts 'Burn Down Area 69'");
 	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /start derby");
   	    SendClientMessage(playerid,COLOR_GREY,"Starts 'Destruction derby on the skydive centre'");
		return 1;
	}
// BURNING DOWN AREA 69
control1 = strfind(cmdtext,"burn",true,0);
control2 = strfind(cmdtext,"derby",true,0);
	if(control1==-1 && control2==-1){
	SendClientMessage(playerid,COLOR_RED,"Invalid game name.");
	SendClientMessage(playerid,COLOR_YELLOW,"Games: burn, derby");
	return 0;
	}

	if (Minigames[BurnPrepare] || Minigames[BurnRunning]){
	SendClientMessage(playerid,COLOR_RED,"This minigame has already been started or is running.");
	return 0;
	}

	if (Minigames[DerbyPrepare] || Minigames[DerbyRunning]){
	SendClientMessage(playerid,COLOR_RED,"Another minigame has already been started or is running.");
	return 0;
	}
if (control1 != -1 && control2 == -1){
Minigames[BurnPrepare] = 1;
LastGame = SetTimer("JoinBurn",3000,1);
SetTimer("JoinBurnTimeout",60000,0);
SetTimer("BurnEnd",600000,0);
format(gamestr,sizeof(gamestr),"[server] Staff Member %s started the minigame 'Burn down Area 69'",player);
print(gamestr);
WriteEcho(gamestr);
SendClientMessageToAll(COLOR_PINK,gamestr);
SendClientMessageToAll(COLOR_YELLOW,"Type '/burn' to join within 1 minute!");
return 1;
}

// DESTRUCTION DERBY ON THE SKYDIVE CENTRE
if (control2 != -1 && control1 == -1){
	if (Minigames[DerbyPrepare] || Minigames[DerbyRunning]){
	SendClientMessage(playerid,COLOR_RED,"This minigame has already been started or is running.");
	return 0;
	}

	if (Minigames[BurnPrepare] || Minigames[BurnRunning]){
	SendClientMessage(playerid,COLOR_RED,"Another minigame has already been started or is running.");
	return 0;
	}

Minigames[DerbyPrepare] = 1;
LastGame = SetTimer("JoinDerby",3000,1);
SetTimer("JoinDerbyTimeout",60000,0);
SetTimer("DerbyEnd",600000,0);
format(gamestr,sizeof(gamestr),"[erver] Staff Member %s started the minigame 'Destruction derby at the skydive centre'",player);
print(gamestr);
WriteEcho(gamestr);
SendClientMessageToAll(COLOR_PINK,gamestr);
SendClientMessageToAll(COLOR_YELLOW,"Type '/derby' to join within 1 minute!");
return 1;
}
}
else
SendClientMessage(playerid,COLOR_RED,"You are not logged in as admin  or your level is to low!");
return 1;
}

//Function_stats
if(strcmp(cmd,"/stats",true)==0)
{
#pragma unused cmdtext
new statsID,statsname[24],tmp[255],statsstr[120];
new vehicleID,dollars,ishe[20];
statsID=strval(cmdtext);
GetPlayerName(playerid,player,sizeof(player));
GetPlayerName(statsID,statsname,sizeof(statsname));

tmp = dini_Get(udb_encode(player),"Level");

if(strval(tmp)>=2 && pInfo[playerid][Admin]) {
	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /stats [ID]");
		return 1;
	}
	format(statsstr,sizeof(statsstr),"----Player statistics for %s----",statsname);
	SendClientMessage(playerid,COLOR_YELLOW,statsstr);

	if(dini_Exists(udb_encode(player)))
	{
	    SendClientMessage(playerid,COLOR_ORANGE,"Registred: Yes");
	}

	if(!dini_Exists(udb_encode(player)))
	{
	    SendClientMessage(playerid,COLOR_ORANGE,"Registred: No");
	}

	vehicleID = pInfo[statsID][vehicle];
	format(statsstr,sizeof(statsstr),"Vehicle ID: %d",vehicleID);
	SendClientMessage(playerid,COLOR_ORANGE,statsstr);

	dollars = strval(dini_Get(udb_encode(statsname),"Bank"));
	format(statsstr,sizeof(statsstr),"Bank Account: %d$",dollars);
	SendClientMessage(playerid,COLOR_ORANGE,statsstr);

	dollars = strval(dini_Get(udb_encode(statsname),"Drugs"));
	format(statsstr,sizeof(statsstr),"Drugs: %d grams",dollars);
	SendClientMessage(playerid,COLOR_ORANGE,statsstr);

	if (pInfo[statsID][WantedLevel] >= 1) format(ishe,20,"Yes [Level %d]",pInfo[statsID][WantedLevel]);
	else format(ishe,2,"No");
	format(statsstr,sizeof(statsstr),"Wanted: %s",ishe);
	SendClientMessage(playerid,COLOR_ORANGE,statsstr);

	if (pInfo[statsID][Cuffed]) format(ishe,3,"Yes");
	else format(ishe,2,"No");
	format(statsstr,sizeof(statsstr),"Cuffed: %s",ishe);
	SendClientMessage(playerid,COLOR_ORANGE,statsstr);

	if (pInfo[statsID][Jailed]) format(ishe,3,"Yes");
	else format(ishe,2,"No");
	format(statsstr,sizeof(statsstr),"Jailed: %s",ishe);
	SendClientMessage(playerid,COLOR_ORANGE,statsstr);

	SendClientMessage(playerid,COLOR_YELLOW,"----End of list----");
	return 1;
}
else
SendClientMessage(playerid,COLOR_RED,"You are not logged in as admin  or your level is to low!");
return 1;
}

//Function_block
if(strcmp(cmd,"/block",true)==0)
{
#pragma unused cmdtext
new blockID,blockname[24],tmp[255],blockstr[120];

blockID=strval(cmdtext);
GetPlayerName(playerid,player,sizeof(player));
GetPlayerName(blockID,blockname,sizeof(blockname));

tmp = dini_Get(udb_encode(player),"Level");

if(strval(tmp)>=5 && pInfo[playerid][Admin]) {
	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /block [ID]");
		return 1;
	}
	dini_IntSet(udb_encode(blockname),"Banned",1);
//  Remove these comments (//) when you want an account block ot be public
//  and immediate (THIS FUNCTION DOES NOT PLACE ANY IP BAN.
//  THE BLOCKED PERSON CAN RETURN AND PLAY WITH ANOTHER NAME)
//	format(blockstr,sizeof(blockstr),"(Ban) Your account got blocked by admin %s",player);
//	SendClientMessage(blockID,COLOR_RED,blockstr);
	format(blockstr,sizeof(blockstr),"You blocked %s's account succesfully",blockname);
	SendClientMessage(playerid,COLOR_RED,blockstr);
	format(blockstr,sizeof(blockstr),"%s's account was blocked by Admin %s",blockname,player);
	print (blockstr);
//	SendClientMessageToAll(COLOR_RED,blockstr);
// 	pInfo[blockID][Banned] = 1;
	return 1;
}
else
SendClientMessage(playerid,COLOR_RED,"You are not logged in as admin  or your level is to low!");
return 1;
}

//Function_mute
if(strcmp(cmd,"/mute",true)==0)
{
#pragma unused cmdtext
new blockID,blockname[24],tmp[255],blockstr[120];

blockID=strval(cmdtext);
GetPlayerName(playerid,player,sizeof(player));
GetPlayerName(blockID,blockname,sizeof(blockname));

tmp = dini_Get(udb_encode(player),"Level");

if(strval(tmp)>=2 && pInfo[playerid][Admin]) {
	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /mute [ID]");
		return 1;
	}
	pInfo[blockID][Jailed] = 1;
	format(blockstr,sizeof(blockstr),"[server] Admin %s muted %s",player,blockname);
	print (blockstr);
	WriteEcho(blockstr);
	SendClientMessageToAll(COLOR_RED,blockstr);
	return 1;
}
else
SendClientMessage(playerid,COLOR_RED,"You are not logged in as admin  or your level is to low!");
return 1;
}

//Function_unmute
if(strcmp(cmd,"/unmute",true)==0)
{
#pragma unused cmdtext
new blockID,blockname[24],tmp[255],blockstr[120];

blockID=strval(cmdtext);
GetPlayerName(playerid,player,sizeof(player));
GetPlayerName(blockID,blockname,sizeof(blockname));

tmp = dini_Get(udb_encode(player),"Level");

if(strval(tmp)>=2 && pInfo[playerid][Admin]) {
	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /unmute [ID]");
		return 1;
	}
	pInfo[blockID][Jailed] = 0;
	format(blockstr,sizeof(blockstr),"[server] Admin %s unmuted %s",player,blockname);
	print (blockstr);
	WriteEcho(blockstr);
	SendClientMessageToAll(COLOR_RED,blockstr);
	return 1;
}
else
SendClientMessage(playerid,COLOR_RED,"You are not logged in as admin  or your level is to low!");
return 1;
}

//Function_unwanted
if(strcmp(cmd,"/unwanted",true)==0)
{
#pragma unused cmdtext
new blockID,blockname[24],tmp[255],blockstr[120];

blockID=strval(cmdtext);
GetPlayerName(playerid,player,sizeof(player));
GetPlayerName(blockID,blockname,sizeof(blockname));

tmp = dini_Get(udb_encode(player),"Level");

if(strval(tmp)==10 && pInfo[playerid][Admin]) {
	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /unwanted [ID]");
		return 1;
	}
	pInfo[blockID][WantedLevel] = 0;
	SetPlayerWantedLevel(blockID,0);
	format(blockstr,sizeof(blockstr),"[server] Admin %s set %s wanted level to 0",player,blockname);
	print (blockstr);
	WriteEcho(blockstr);
	SendClientMessageToAll(COLOR_LIGHTGREEN,blockstr);
	return 1;
}
else
SendClientMessage(playerid,COLOR_RED,"You are not logged in as admin  or your level is to low!");
return 1;
}

//Function_setweather
if(strcmp(cmd,"/setweather",true)==0)
{
#pragma unused cmdtext
new blockID,tmp[255],blockstr[120];

blockID=strval(cmdtext);
GetPlayerName(playerid,player,sizeof(player));

tmp = dini_Get(udb_encode(player),"Level");

if(strval(tmp)>=5 && pInfo[playerid][Admin]) {
	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /weather [ID]");
   	    SendClientMessage(playerid,COLOR_GREY,"Normal weather: ID 10");
		return 1;
	}

for(new wt=0; wt<MAX_PLAYERS; wt++){
	if(IsPlayerConnected(wt)){
		SetPlayerWeather(wt,blockID);
 			}
}



	format(blockstr,sizeof(blockstr),"[server] Admin %s has set the server weather to %d",player,blockID);
	print (blockstr);
	WriteEcho(blockstr);
	SendClientMessageToAll(COLOR_LIGHTGREEN,blockstr);
	return 1;
}
else
SendClientMessage(playerid,COLOR_RED,"You are not logged in as admin  or your level is to low!");
return 1;
}

//Function_unblock
if(strcmp(cmd,"/unblock",true)==0)
{
#pragma unused cmdtext
new tmp[255],unblockstr[120];

GetPlayerName(playerid,player,sizeof(player));

tmp = dini_Get(udb_encode(player),"Level");

if(strval(tmp)>=5 && pInfo[playerid][Admin]) {
	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /unblock [ID]");
		return 1;
	}
	if(dini_Exists(udb_encode(cmdtext))){
	dini_IntSet(udb_encode(cmdtext),"Banned",0);
	SendClientMessage(playerid,COLOR_YELLOW,"****Account Loaded****");
	format(unblockstr,sizeof(unblockstr),"You unblocked %s's account succesfully",cmdtext);
	SendClientMessage(playerid,COLOR_RED,unblockstr);
	format(unblockstr,sizeof(unblockstr),"%s was unbanned by Admin %s",cmdtext,player);
	print (unblockstr);
	SendClientMessageToAll(COLOR_RED,unblockstr);
 }
 else
 SendClientMessage(playerid,COLOR_RED,"Account Name not found!");
 return 1;
 }
else
SendClientMessage(playerid,COLOR_RED,"You are not logged in as admin or your level is to low!");
return 1;
}

//Function_setpocket
if(strcmp(cmd,"/setpocket",true)==0)
{
#pragma unused cmdtext
new recID,recStr[5],setcashname[24],tmp[255],setcashstr[120];

GetPlayerName(playerid,player,sizeof(player));
tmp = dini_Get(udb_encode(player),"Level");


strmid(recStr,cmdtext,0,3,3);
recID = strval(recStr);
strmid(cmdtext,cmdtext,3,255,252);

if(strval(tmp)>=5 && pInfo[playerid][Admin]) {
	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /setpocket [ID] [amount of $$$]");
		return 1;
	}

   if(IsPlayerConnected(recID)){
	GetPlayerName(recID,setcashname,24);
	format(setcashstr,sizeof(setcashstr),"You set the pocket money to %d$ for %s",strval(cmdtext),setcashname);
    SendClientMessage(playerid,COLOR_YELLOW,setcashstr);
	GivePlayerMoney(recID,-GetPlayerMoney(recID));
	GivePlayerMoney(recID,strval(cmdtext));
	dini_IntSet(udb_encode(setcashname),"Pocket",strval(cmdtext));
   	format(setcashstr,sizeof(setcashstr),"Your pocket money was set to %d$ by %s",strval(cmdtext),player);
   	SendClientMessage(recID,COLOR_YELLOW,setcashstr);
   	format(setcashstr, sizeof (setcashstr), "%s used /SETPOCKET to set %d$ as pocket money for %s (ID %d)",player,strval(cmdtext),setcashname,recID);
	print(setcashstr);
	}

return 1;
}
else
SendClientMessage(playerid,COLOR_RED,"You are not logged in as admin  or your level is to low!");
return 1;
}

//Function_setbank
if(strcmp(cmd,"/setbank",true)==0)
{
#pragma unused cmdtext
new recID,recStr[5],setcashname[24],tmp[255],setcashstr[120];

GetPlayerName(playerid,player,sizeof(player));
tmp = dini_Get(udb_encode(player),"Level");

strmid(recStr,cmdtext,0,3,3);
recID = strval(recStr);
strmid(cmdtext,cmdtext,3,255,252);

if(strval(tmp)>=5 && pInfo[playerid][Admin]) {
	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /setbank [ID] [amount of $$$]");
		return 1;
	}

   if(IsPlayerConnected(recID)){
	GetPlayerName(recID,setcashname,24);
	format(setcashstr,sizeof(setcashstr),"You set the bank account balance to %d$ for %s",strval(cmdtext),setcashname);
    SendClientMessage(playerid,COLOR_YELLOW,setcashstr);
	dini_IntSet(udb_encode(setcashname),"Bank",strval(cmdtext));
   	format(setcashstr,sizeof(setcashstr),"Your bank account balance was set to %d$ by %s",strval(cmdtext),player);
   	SendClientMessage(recID,COLOR_YELLOW,setcashstr);
   	format(setcashstr, sizeof (setcashstr), "%s used /SETBANK to set %d$ as bank account balance for %s (ID %d)",player,strval(cmdtext),setcashname,recID);
	print(setcashstr);
	}

return 1;
}
else
SendClientMessage(playerid,COLOR_RED,"You are not logged in as admin  or your level is to low!");
return 1;
}

//Function_respawnall
if(strcmp(cmd,"/respawnall",true)==0)
{
#pragma unused cmdtext
new tmp[255],string[120];

GetPlayerName(playerid,player,sizeof(player));
tmp = dini_Get(udb_encode(player),"Level");

if(strval(tmp)>=5 && pInfo[playerid][Admin]) {

for (new vID;vID<=182;vID++){
SetVehicleToRespawn(vID);
for (new l;l<MAX_PLAYERS;l++){
	if (IsPlayerConnected(l)){
    SetVehicleParamsForPlayer(vID, l,0,0);
	}
}
}
format(string,sizeof(string),"[server] Admin %s respawned & unlocked all 182 vehicles.",player);
print (string);
WriteEcho(string);
SendClientMessageToAll(COLOR_YELLOW,string);
SendClientMessageToAll(COLOR_YELLOW,"If you were using a vehicle while it respawned you will find it at where you got it.");
return 1;
}
else
SendClientMessage(playerid,COLOR_RED,"You are not logged in as admin  or your level is to low!");
return 1;
}

//Function_setcar
if(strcmp(cmd,"/setcar",true)==0)
{
new carguy,carID,carname[24],carstr[120],tmp[255];
carguy = strval(cmdtext);
carID = pInfo[carguy][vehicle];
GetPlayerName(playerid,player,sizeof(player));
GetPlayerName(carguy,carname,sizeof(carname));
tmp = dini_Get(udb_encode(player),"Level");
if(strval(tmp)==10 && pInfo[playerid][Admin]) {
	if(!strlen(cmdtext)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /setcar [ID]");
		return 1;
	}
dini_IntSet(udb_encode(carname),"Vehicle",carID);
format(carstr,sizeof(carstr),"%s's car ID saved as %d",carname,carID);
SendClientMessage(playerid,COLOR_ORANGE,carstr);
format(carstr,sizeof(carstr),"Admin %s saved the car you are currently owning as your car constantly.",player);
SendClientMessage(carguy,COLOR_ORANGE,carstr);
return 1;
}
else
SendClientMessage(playerid,COLOR_RED, "You are not logged in as admin  or your level is to low!");
return 0;
}

//Function_savespawn
if(strcmp(cmd,"/savespawn",true)==0)
{
new spawnguy,spawnname[24],spawnstr[120],tmp[255];
spawnguy = strval(cmdtext);
GetPlayerName(playerid,player,sizeof(player));
GetPlayerName(spawnguy,spawnname,sizeof(spawnname));
tmp = dini_Get(udb_encode(player),"Level");
	if(strval(tmp)==10 && pInfo[playerid][Admin]) {
		if(!strlen(cmdtext)){
		    SendClientMessage(playerid,COLOR_GREY,"USAGE: /savespawn [ID]");
			return 1;
		}

	new Float:posX;
	new Float:posY;
	new Float:posZ;
	new Float:posA;

	GetPlayerPos(spawnguy,posX,posY,posZ);
	GetPlayerFacingAngle(spawnguy,posA);

	dini_IntSet(udb_encode(spawnname),"House",1);
	dini_IntSet(udb_encode(spawnname),"SpawnX",floatround(posX));
	dini_IntSet(udb_encode(spawnname),"SpawnY",floatround(posY));
	dini_IntSet(udb_encode(spawnname),"SpawnZ",floatround(posZ));
	dini_IntSet(udb_encode(spawnname),"SpawnA",floatround(posA));

	format(spawnstr,sizeof(spawnstr),"%s's position saved as spawnposition.",spawnname);
	SendClientMessage(playerid,COLOR_ORANGE,spawnstr);
	format(spawnstr,sizeof(spawnstr),"Admin %s saved your current position as your future spawn position.",player);
	SendClientMessage(spawnguy,COLOR_ORANGE,spawnstr);
	return 1;
	}
else
SendClientMessage(playerid,COLOR_RED, "You are not logged in as admin or your level is to low!");
return 0;
}
	return 1;
}



public OnGameModeExit()
{
new pexit[24];

for (new z=0;z<MAX_PLAYERS;z++){
	GetPlayerName(z,pexit,24);
	dini_IntSet(udb_encode(pexit),"Pocket",GetPlayerMoney(z));
 	pInfo[z][Spawned] = 0;
	pInfo[z][Logged] = 0;
	pInfo[z][Admin] = 0;
	pInfo[z][Cuffed] = 0;
	pInfo[z][Wanted] = 0;
	pInfo[z][AddWanted] = 0;
	pInfo[z][WantedLevel] = 0;
	pInfo[z][Jailable] = 0;
	pInfo[z][Jailed] = 0;
}

dini_IntSet("Servertime","Time",Servertime);
SendClientMessageToAll(COLOR_RED,"****GAME MODE EXIT****");
	return 1;
}
