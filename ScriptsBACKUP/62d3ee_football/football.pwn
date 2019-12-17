#include <a_samp>
#include <Dini>
#include <dutils>
#include <core>
#include <utils>
#include <float>
#include <DUDB>
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_BAD 0xC10000FF
#define COLOR_GOOD 0xFAD029FF
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
#define l_red 0xFF0000AA
#define l_green 0x33FF33AA
#define TEAM_BLUE 1
#define TEAM_RED 2
#pragma tabsize 0
forward SendClientMessageToAdmins(color,const string[],alevel);
forward KeyChanges();
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward ObjectToPoint(Float:radi, objectid, Float:x, Float:y, Float:z);
forward IsAGoal();
forward SpawnMe(playerid);
static gTeam[MAX_PLAYERS];
new Text:Textdraw0;
new Text:Textdraw1;
new Text:Textdraw3;
new Text:Textdraw4;
new sendername[MAX_PLAYER_NAME];
new footballdoor;
new football;
new playingfootball[MAX_PLAYERS];
new matchstarted[MAX_PLAYERS];
new teamselected[MAX_PLAYERS];
new logged[MAX_PLAYERS];
new spectator[MAX_PLAYERS];
new light1;
new light2;
new light3;
new light4;
new light5;
new level;
new lastentered[128];
new bluescore = 0;
new redscore = 0;
new playername[MAX_PLAYER_NAME];
new player[MAX_PLAYER_NAME];
new StrVar[256];
new aVehicleNames[212][] = {
	{"Landstalker"},
	{"Bravura"},
	{"Buffalo"},
	{"Linerunner"},
	{"Perrenial"},
	{"Sentinel"},
	{"Dumper"},
	{"Firetruck"},
	{"Trashmaster"},
	{"Stretch"},
	{"Manana"},
	{"Infernus"},
	{"Voodoo"},
	{"Pony"},
	{"Mule"},
	{"Cheetah"},
	{"Ambulance"},
	{"Leviathan"},
	{"Moonbeam"},
	{"Esperanto"},
	{"Taxi"},
	{"Washington"},
	{"Bobcat"},
	{"Mr Whoopee"},
	{"BF Injection"},
	{"Hunter"},
	{"Premier"},
	{"Enforcer"},
	{"Securicar"},
	{"Banshee"},
	{"Predator"},
	{"Bus"},
	{"Rhino"},
	{"Barracks"},
	{"Hotknife"},
	{"Trailer 1"},
	{"Previon"},
	{"Coach"},
	{"Cabbie"},
	{"Stallion"},
	{"Rumpo"},
	{"RC Bandit"},
	{"Romero"},
	{"Packer"},
	{"Monster"},
	{"Admiral"},
	{"Squalo"},
	{"Seasparrow"},
	{"Pizzaboy"},
	{"Tram"},
	{"Trailer 2"},
	{"Turismo"},
	{"Speeder"},
	{"Reefer"},
	{"Tropic"},
	{"Flatbed"},
	{"Yankee"},
	{"Caddy"},
	{"Solair"},
	{"Berkley's RC Van"},
	{"Skimmer"},
	{"PCJ-600"},
	{"Faggio"},
	{"Freeway"},
	{"RC Baron"},
	{"RC Raider"},
	{"Glendale"},
	{"Oceanic"},
	{"Sanchez"},
	{"Sparrow"},
	{"Patriot"},
	{"Quad"},
	{"Coastguard"},
	{"Dinghy"},
	{"Hermes"},
	{"Sabre"},
	{"Rustler"},
	{"ZR-350"},
	{"Walton"},
	{"Regina"},
	{"Comet"},
	{"BMX"},
	{"Burrito"},
	{"Camper"},
	{"Marquis"},
	{"Baggage"},
	{"Dozer"},
	{"Maverick"},
	{"News Chopper"},
	{"Rancher"},
	{"FBI Rancher"},
	{"Virgo"},
	{"Greenwood"},
	{"Jetmax"},
	{"Hotring"},
	{"Sandking"},
	{"Blista Compact"},
	{"Police Maverick"},
	{"Boxville"},
	{"Benson"},
	{"Mesa"},
	{"RC Goblin"},
	{"Hotring Racer A"},
	{"Hotring Racer B"},
	{"Bloodring Banger"},
	{"Rancher"},
	{"Super GT"},
	{"Elegant"},
	{"Journey"},
	{"Bike"},
	{"Mountain Bike"},
	{"Beagle"},
	{"Cropdust"},
	{"Stunt"},
	{"Tanker"},
	{"Roadtrain"},
	{"Nebula"},
	{"Majestic"},
	{"Buccaneer"},
	{"Shamal"},
	{"Hydra"},
	{"FCR-900"},
	{"NRG-500"},
	{"HPV1000"},
	{"Cement Truck"},
	{"Tow Truck"},
	{"Fortune"},
	{"Cadrona"},
	{"FBI Truck"},
	{"Willard"},
	{"Forklift"},
	{"Tractor"},
	{"Combine"},
	{"Feltzer"},
	{"Remington"},
	{"Slamvan"},
	{"Blade"},
	{"Freight"},
	{"Streak"},
	{"Vortex"},
	{"Vincent"},
	{"Bullet"},
	{"Clover"},
	{"Sadler"},
	{"Firetruck LA"},
	{"Hustler"},
	{"Intruder"},
	{"Primo"},
	{"Cargobob"},
	{"Tampa"},
	{"Sunrise"},
	{"Merit"},
	{"Utility"},
	{"Nevada"},
	{"Yosemite"},
	{"Windsor"},
	{"Monster A"},
	{"Monster B"},
	{"Uranus"},
	{"Jester"},
	{"Sultan"},
	{"Stratum"},
	{"Elegy"},
	{"Raindance"},
	{"RC Tiger"},
	{"Flash"},
	{"Tahoma"},
	{"Savanna"},
	{"Bandito"},
	{"Freight Flat"},
	{"Streak Carriage"},
	{"Kart"},
	{"Mower"},
	{"Duneride"},
	{"Sweeper"},
	{"Broadway"},
	{"Tornado"},
	{"AT-400"},
	{"DFT-30"},
	{"Huntley"},
	{"Stafford"},
	{"BF-400"},
	{"Newsvan"},
	{"Tug"},
	{"Trailer 3"},
	{"Emperor"},
	{"Wayfarer"},
	{"Euros"},
	{"Hotdog"},
	{"Club"},
	{"Freight Carriage"},
	{"Trailer 3"},
	{"Andromada"},
	{"Dodo"},
	{"RC Cam"},
	{"Launch"},
	{"Police Car (LSPD)"},
	{"Police Car (SFPD)"},
	{"Police Car (LVPD)"},
	{"Police Ranger"},
	{"Picador"},
	{"S.W.A.T. Van"},
	{"Alpha"},
	{"Phoenix"},
	{"Glendale"},
	{"Sadler"},
	{"Luggage Trailer A"},
	{"Luggage Trailer B"},
	{"Stair Trailer"},
	{"Boxville"},
	{"Farm Plow"},
	{"Utility Trailer"}
};
main(){
	print("* Championship Football by Norn.");
}
public OnGameModeInit(){
	ShowPlayerMarkers(0);

	new wstring[128];
	format(wstring, sizeof(wstring), "Red Team: %d.", redscore);
	Textdraw3 = TextDrawCreate(447.000000,389.000000,wstring);

  	new pstring[128];
	format(pstring, sizeof(pstring), "Blue Team: %d.", bluescore);
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
	SetGameModeText("Championship Football V0.1");
	AddPlayerClass(80,82.0761,2474.1331,16.4844,298.3470,0,0,0,0,0,0);
	AddPlayerClass(81,82.0761,2474.1331,16.4844,298.3470,0,0,0,0,0,0);

	CreateObject(987, 126.753410, 2476.302246, 15.568080, 0.0000, 0.0000, 87.6625);
	CreateObject(987, 127.431580, 2488.012451, 15.492184, 0.0000, 0.0000, 90.2409);
	CreateObject(987, 127.529396, 2499.968506, 15.424900, 0.0000, 0.0000, 90.2409);
	CreateObject(987, 127.499641, 2511.905762, 15.576437, 0.0000, 0.0000, 103.1324);
	CreateObject(987, 40.457767, 2477.390137, 15.484375, 0.0000, 0.0000, 87.6625);
	CreateObject(987, 40.889481, 2489.362549, 15.484375, 0.0000, 0.0000, 87.6625);
	CreateObject(987, 42.184555, 2513.097656, 15.492184, 0.0000, 0.0000, 91.9597);
	CreateObject(987, 41.426842, 2501.212402, 15.435890, 0.0000, 0.0000, 87.6625);
	CreateObject(991, 123.923195, 2499.773682, 16.699615, 0.0000, 0.0000, 271.4780);
	CreateObject(991, 123.915749, 2499.766846, 17.299606, 0.0000, 0.0000, 271.5818);
	CreateObject(991, 122.619263, 2502.999756, 15.224634, 0.0000, 269.7591, 183.0601);
	CreateObject(991, 122.701576, 2496.440674, 15.232431, 0.0000, 92.8192, 359.1406);
	CreateObject(991, 122.860153, 2499.749756, 18.532404, 270.6186, 0.8594, 91.9597);
	CreateObject(991, 42.785404, 2502.307617, 16.699615, 0.0000, 0.0000, 88.5220);
	CreateObject(991, 42.789219, 2502.316895, 17.324606, 0.0000, 0.0000, 89.3814);
	CreateObject(991, 44.011806, 2499.039551, 15.224638, 0.8594, 268.8997, 0.0000);
	CreateObject(991, 43.965122, 2505.671387, 15.224638, 0.0000, 270.6185, 178.7630);
	CreateObject(991, 43.904266, 2502.328125, 18.474588, 270.6186, 0.0000, 91.1003);
	CreateObject(987, 40.356102, 2477.555176, 15.484375, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 52.347397, 2477.369873, 15.484375, 0.0000, 0.0000, 307.5744);
	CreateObject(987, 60.896790, 2467.505859, 15.484375, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 71.755714, 2467.233643, 15.476620, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 83.599655, 2466.916504, 15.484375, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 95.548233, 2466.622559, 15.484375, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 107.717255, 2466.740479, 15.476620, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 119.643417, 2466.654541, 15.484375, 0.0000, 0.0000, 54.1445);
	CreateObject(3819, 65.469414, 2469.961182, 16.474379, 0.0000, 0.0000, 270.6185);
	CreateObject(3819, 72.679688, 2470.041260, 16.362221, 0.0000, 0.0000, 271.4780);
	CreateObject(3819, 81.249069, 2470.302734, 16.474379, 0.0000, 0.0000, 272.3375);
	CreateObject(3819, 90.062050, 2470.648926, 16.482134, 0.0000, 0.0000, 272.3375);
	CreateObject(3819, 98.845238, 2470.611572, 16.474379, 0.0000, 0.0000, 272.3375);
	CreateObject(3819, 107.795189, 2470.637207, 16.474379, 0.0000, 0.0000, 269.7591);
	CreateObject(3819, 116.599464, 2470.681152, 16.482134, 0.0000, 0.0000, 272.3375);
	CreateObject(982, 113.752930, 2477.199707, 16.175739, 0.0000, 0.0000, 89.3814);
	CreateObject(982, 88.179817, 2477.287109, 16.167931, 0.0000, 0.0000, 90.2409);
	CreateObject(984, 68.976982, 2477.093750, 16.121056, 0.0000, 0.0000, 91.1003);
	CreateObject(983, 59.388790, 2476.917969, 16.167931, 0.0000, 0.0000, 91.1003);
	CreateObject(983, 55.402565, 2476.843262, 16.167931, 0.0000, 0.0000, 91.1003);
	footballdoor=CreateObject(983, 60.101212, 2467.846924, 17.535154, 270.6186, 0.0000, 86.8031);
	CreateObject(987, 41.799297, 2524.785156, 15.492184, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 53.790485, 2524.725098, 15.442184, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 65.739326, 2524.610352, 15.484375, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 77.635735, 2524.633789, 15.484375, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 89.466240, 2524.456787, 15.452545, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 101.331963, 2524.197510, 15.671379, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 113.148247, 2524.337891, 15.758759, 0.0000, 0.0000, 356.5623);


	football=CreateObject(1598, 89.615692, 2500.632324, 15.789375, 0.0000, 0.0000, 0.0000);

	Textdraw0 = TextDrawCreate(107.000000,161.000000,"> blue team (/blueteam)");
	Textdraw1 = TextDrawCreate(105.000000,240.000000,"> red team (/redteam)");
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
public OnPlayerRequestClass(playerid, classid){
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
public OnPlayerConnect(playerid){
	ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
	//player connected message
	new pName[MAX_PLAYER_NAME];
 	new wstring[128];
    GetPlayerName(playerid, pName, sizeof(pName));
    format(wstring, sizeof(wstring), "%s has joined the server.", pName);
    SendClientMessageToAll(COLOR_WHITE, wstring);

	SendClientMessage(playerid,COLOR_YELLOW,"** Welcome to Championship Football, for a list of basic commands type /commands.");
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"* Type /blueteam or /redteam to select your team.");
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"* If you want to just watch the match, type /spectator.");

	spectator[playerid]=0;
	playingfootball[playerid]=0;
	matchstarted[playerid]=0;
	teamselected[playerid]=0;
	logged[playerid]=0;
	TextDrawShowForPlayer(playerid,Text:Textdraw0);//Red team textdraw
	TextDrawShowForPlayer(playerid,Text:Textdraw1);//blue team textdraw
	TextDrawShowForPlayer(playerid,Text:Textdraw3);//Red team textdraw
	TextDrawShowForPlayer(playerid,Text:Textdraw4);//blue team textdraw

 	if (udb_Exists(PlayerName(playerid)) == 0)
	{
	SendClientMessage(playerid, COLOR_GREEN, "Your account does not exist! Your scores won't be saved!");
	}
	if (udb_Exists(PlayerName(playerid)) == 1)
	{
	SendClientMessage(playerid, COLOR_GREEN, "Your account exists, Type /login password.");
	}
	return 1;
}
public OnPlayerDisconnect(playerid, reason){
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
public OnPlayerSpawn(playerid){
	TextDrawHideForPlayer(playerid,Text:Textdraw0);//Red Team Textdraw
	TextDrawHideForPlayer(playerid,Text:Textdraw1);//Blue team Textdraw
	return 1;
}
public OnPlayerText(playerid, text[]){
	if(logged[playerid] == 0)
	{
	SendClientMessage(playerid,COLOR_YELLOW,"You can't speak unless you log in!");
	return 0;
	}
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[]){
	new string[256];
	new giveplayer[MAX_PLAYER_NAME];
	new cmd[256];
	new tmp[256];
	new idx;
	new giveplayerid;

	cmd = strtok(cmdtext, idx);
//-------------------------------------------------("DUDB")-------------------------------------------------
	if (strcmp(cmd, "/login", true) == 0)
	{
	   	if (dUserINT(PlayerName(playerid)).("banned") == 1)
		{
    	new pName[MAX_PLAYER_NAME];
    	new string1[128];
    	GetPlayerName(playerid, pName, sizeof(pName));
    	format(string1, sizeof(string1), "%s has been kicked from the server, Reason: ACCOUNT BANNED.", pName);
    	SendClientMessageToAll(COLOR_RED, string1);
		Kick(playerid);
  		}
		else if (logged[playerid] != 1 && udb_Exists(PlayerName(playerid)))
		{
			new dir[256];
			dir = strtok(cmdtext, idx);
			if (strlen(dir) && strcmp(dir, dUser(PlayerName(playerid)).("password"), true) == 0)
		{
			logged[playerid] = 1;
			new score = dUserINT(PlayerName(playerid)).("goalsscored");
			SetPlayerScore(playerid,score);

			SendClientMessage(playerid, COLOR_RED, "Successfully Logged in!");
		}
	}
		else SendClientMessage(playerid, COLOR_RED, "Login error!");
		return 1;
	}


	if (strcmp(cmd, "/register", true) == 0)
	{
	if (logged[playerid] != 1 && !udb_Exists(PlayerName(playerid)))
			{
			new dir[256];
			dir = strtok(cmdtext, idx);
			if (strlen(dir))
		{
			new fname[MAX_STRING];
			format(fname,sizeof(fname),"%s.ini",udb_encode(PlayerName(playerid)));
			dini_Create(fname);
			dUserSet(PlayerName(playerid)).("password", dir);
			dUserSet(PlayerName(playerid)).("admin", "0");
			dUserSet(PlayerName(playerid)).("banned", "0");
			dUserSet(PlayerName(playerid)).("owngoals", "0");
			dUserSet(PlayerName(playerid)).("goalsscored", "0");
			dUserSet(PlayerName(playerid)).("gamesplayed", "0");
			SendClientMessage(playerid, COLOR_RED, "Registered! Please login with /login [password]");
		}
	}
	else SendClientMessage(playerid, COLOR_RED, "Register error!");
	return 1;
	}
	if (logged[playerid] == 0) {
	SendClientMessage(playerid, COLOR_YELLOW, "{SERVER] You must be logged in to use commands!");
 	return 1;
	}
	if (strcmp(cmdtext, "/lighton", true)==0)
	{
		if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	    {
		light1=CreateObject( 354, 2001.195679, 1547.113892, 14.283400, 0, 0, 96 );
		light2=CreateObject( 354, 2001.195679, 1547.113892, 14.283400, 0, 0, 96 );
		light3=CreateObject( 354, 2001.195679, 1547.113892, 14.283400, 0, 0, 96 );
		light4=CreateObject( 354, 2001.195679, 1547.113892, 14.283400, 0, 0, 96 );
		light5=CreateObject( 354, 2001.195679, 1547.113892, 14.283400, 0, 0, 96 );
		AttachObjectToPlayer( light1, playerid, 0, 0, 0, 0, 0, 0 );
		AttachObjectToPlayer( light2, playerid, 0, 0, 0, 0, 0, 0 );
		AttachObjectToPlayer( light3, playerid, 0, 0, 0, 0, 0, 0 );
		AttachObjectToPlayer( light4, playerid, 0, 0, 0, 0, 0, 0 );
		AttachObjectToPlayer( light5, playerid, 0, 0, 0, 0, 0, 0 );
		}
		return 1;
	}
	if (strcmp(cmdtext, "/lightoff", true)==0)
	{
		if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	    {
		DestroyObject(light1);
		DestroyObject(light2);
		DestroyObject(light3);
		DestroyObject(light4);
		DestroyObject(light5);
		return 1;
		}
	}
	if (strcmp(cmdtext, "/quitteam", true)==0)
	{
		if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	    {
		teamselected[playerid]=0;
		return 1;
		}
	}
	if (strcmp(cmdtext, "/spectator", true)==0)
	{
		if(teamselected[playerid] == 0)
		{
	    SetSpawnInfo( playerid, 0, 124,83.8987,2473.4163,16.4844, 0.0, 0, 0, 0, 0, 0, 0 );
	    SetPlayerSkin(playerid,124);
		SetPlayerColor(playerid,COLOR_WHITE);
		SpawnPlayer(playerid);
		teamselected[playerid]=0;
		playingfootball[playerid]=0;
		return 1;
  		}
		SendClientMessage(playerid,COLOR_YELLOW,"You've already selected a team.");
  		return 1;
	}
	if (strcmp(cmdtext, "/blueteam", true)==0)
	{
		if(teamselected[playerid] == 0)
		{
	    SetSpawnInfo( playerid, 0, 81, 124.6489,2488.8911,16.4922, 0.0, 0, 0, 0, 0, 0, 0 );
	    SetPlayerSkin(playerid,81);
		SetPlayerColor(playerid,COLOR_LIGHTBLUE);
		SpawnPlayer(playerid);
		teamselected[playerid]=1;
		playingfootball[playerid]=1;
		SetTimerEx("KeyChanges", 100, 1, "i", playerid);
		gTeam[playerid] = TEAM_BLUE;
		return 1;
  		}
		SendClientMessage(playerid,COLOR_YELLOW,"You've already selected a team.");
  		return 1;
	}
	if (strcmp(cmdtext, "/redteam", true)==0)
	{
		if(teamselected[playerid] == 0)
		{
	    SetSpawnInfo( playerid, 0, 80, 45.6425,2490.3450,16.4844, 0.0, 0, 0, 0, 0, 0, 0 );
	    SetPlayerSkin(playerid,80);
		SpawnPlayer(playerid);
		SetPlayerColor(playerid,COLOR_RED);
		teamselected[playerid]=1;
		playingfootball[playerid]=1;
		SetTimerEx("KeyChanges", 100, 1, "i", playerid);
		gTeam[playerid] = TEAM_RED;
		return 1;
		}
		SendClientMessage(playerid,COLOR_YELLOW,"You've already selected a team.");
		return 1;
	}
	if (strcmp(cmdtext, "/respawnball", true)==0)
	{
		if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	    {
		DestroyObject(football);
		football=CreateObject(1598, 89.615692, 2500.632324, 15.789375, 0.0000, 0.0000, 0.0000);
		return 1;
		}
	}
	if (strcmp(cmdtext, "/opengate", true)==0)
	{
		if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	    {
		MoveObject(footballdoor,60.101212, 2467.846924, 9.535154, 5.0);
		return 1;
		}
	}
	if (strcmp(cmdtext, "/closegate", true)==0)
	{
		if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	    {
		MoveObject(footballdoor,60.101212, 2467.846924, 17.535154,5.0);
		return 1;
  		}
	}
	if (strcmp(cmdtext, "/commands", true)==0)
	{
    SendClientMessage(playerid,COLOR_YELLOW,"* [ C O M M A N D S ] *");
    SendClientMessage(playerid,COLOR_OOC,"Basic: /scores - /stopplaying - /objective - /admins");
    SendClientMessage(playerid,COLOR_OOC,"Register: /register - /login");
	return 1;
	}
if(strcmp(cmd, "/slap", true) == 0)
{
new Float:pX,Float:pY,Float:pZ;
		if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	{
	tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /slap [playerid]");
			SendClientMessage(playerid, COLOR_YELLOW, "FUNCTION: Will slap the specified player(He will teleport 5 meters higher)");
			return 1;
		}

		giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
		    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
		    GetPlayerPos(giveplayerid,pX,pY,pZ);
		    SetPlayerPos(giveplayerid,pX,pY,pZ+5);
			printf("[ADMIN NEWS]: Admin %s slapped %s.", sendername, giveplayer);
			format(string, sizeof(string), "Administrator %s slapped %s ",sendername, giveplayer);
			SendClientMessageToAdmins(COLOR_RED,string,1);
		}
		else if(giveplayerid == INVALID_PLAYER_ID)
		{
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_RED, string);
		}
	}
	else
 	{
 	SendClientMessage(playerid, COLOR_RED, "You are not an admin with the required level.");
  	}
	return 1;
	}
	if (strcmp(cmd, "/admins", true) == 0)
	{
		SendClientMessage(playerid, COLOR_GREEN, "|---------------Online Admins---------------|");
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    if (IsPlayerConnected(i))
	  		{
  				if(dUserINT(PlayerName(i)).("admin") >= 1 && dUserINT(PlayerName(i)).("admin") <= 6)
	    			{
						GetPlayerName(i, player, sizeof(player));
						format(string, 256, "Name: %s - Level %d [ID:%i]", player,dUserINT(PlayerName(i)).("admin"),i);
						SendClientMessage(playerid, COLOR_YELLOW, string);
					}
			}
		}
		SendClientMessage(playerid, COLOR_GREEN, "|--------------------------------------------------|");
		return 1;
	}
	if (strcmp(cmdtext, "/ah", true)==0)
	{
		if (dUserINT(PlayerName(playerid)).("admin") >= 1)
    	{
        SendClientMessage(playerid,COLOR_YELLOW,"[ A D M I N I S T R A T O R ]");
        SendClientMessage(playerid,COLOR_GREY,"Administrator: /opengate - /closegate - /lighton - /lightoff - /quitteam");
        SendClientMessage(playerid,COLOR_GREY,"Administrator: /ban - /kick - /goto - /gethere - // (ADMIN CHAT)");
        SendClientMessage(playerid,COLOR_GREY,"Administrator: /disarm - /slap - /gmx - /nuke - /freeze - /unfreeze - /makeadmin");
        SendClientMessage(playerid,COLOR_GREY,"Administrator: /v - /skin - /giveweapon - /respawnball");
        return 1;
    	}
	return 1;
	}
	if (strcmp(cmdtext, "/objective", true)==0)
	{
        SendClientMessage(playerid,COLOR_YELLOW,"Objective: The object of this gamemode is to get 12 goals before the opposite team does.");
        return 1;
	}
	if(strcmp(cmd, "/giveweapon", true) == 0)
	{
	if (dUserINT(PlayerName(playerid)).("admin") >= 2)
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /giveweapon [playerid] [weaponid] [ammo]");
				return 1;
			}
			new gun;
			new ammo;
			giveplayerid = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			gun = strval(tmp);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /giveweapon [playerid] [weaponid] [ammo]");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			ammo = strval(tmp);
			if(ammo <1||ammo > 10000)
			{ SendClientMessage(playerid, COLOR_RED, "You can only give a maximum capacity of 10 000 bullets and not less than 1."); return 1; }
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			    	GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GivePlayerWeapon(giveplayerid, gun, ammo);
					format(string, sizeof(string), " Administrator %s gave a weapon to %s ",sendername, giveplayer);
					SendClientMessageToAdmins(COLOR_RED,string,1);
				}
				else if(giveplayerid == INVALID_PLAYER_ID)
			    {
					format(string, sizeof(string), "%d is not an active player.", giveplayerid);
					SendClientMessage(playerid, COLOR_RED, string);
				}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "You are not an admin with the required level!");
		}
		return 1;
	}
    if(!strcmp(cmd, "/skin", true))
	{
	if (dUserINT(PlayerName(playerid)).("admin") >= 1)
		{
		StrVar = strtok(cmdtext, idx);
		if (!strlen(StrVar)) return SendClientMessage(playerid, COLOR_BAD, "[USAGE]: '/skin [Skinid]");
		if ((strval(StrVar) < 0) || (strval(StrVar) > 299) || IsInvalidSkin(strval(StrVar))) return SendClientMessage(playerid, COLOR_BAD, "[ERROR]: Invalid Skinid");
		SetPlayerSkin(playerid, strval(StrVar));
		format(StrVar, sizeof(StrVar), "[SUCCESS]: Skin changed to skindid %d", GetPlayerSkin(playerid));
		SendClientMessage(playerid, COLOR_GOOD, StrVar);
		return 1;
		}
	}
	if(strcmp(cmd, "/v", true) == 0)
	{
		if (dUserINT(PlayerName(playerid)).("admin") == 0) return SendClientMessage(playerid, l_red, "You are not an administrator!");

		new String[200];
		new Float:x, Float:y, Float:z;
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, l_red, "You didn't give a vehicle name");

		new vehicle = GetVehicleModelIDFromName(tmp);

		if(vehicle < 400 || vehicle > 611) return SendClientMessage(playerid, l_red, "That vehicle name was not found");

		new Float:a;
		GetPlayerFacingAngle(playerid, a);
		GetPlayerPos(playerid, x, y, z);

		if(IsPlayerInAnyVehicle(playerid) == 1)
		{
			GetXYInFrontOfPlayer(playerid, x, y, 8);
		}
		else
		{
		    GetXYInFrontOfPlayer(playerid, x, y, 5);
		}

		new PlayersVehicle = CreateVehicle(vehicle, x, y, z, a+90, -1, -1, -1);
		LinkVehicleToInterior(PlayersVehicle, GetPlayerInterior(playerid));

		format(String, sizeof(String), "You have spawned a %s", aVehicleNames[vehicle - 400]);
		SendClientMessage(playerid, l_green, String);
		return 1;
	}
if(strcmp(cmd, "/freeze", true) == 0)
{
new reason[64];
	if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	{
	tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /freeze [playerid] [reason]");
			SendClientMessage(playerid, COLOR_YELLOW, "FUNCTION: Will freeze the specified player. **PLEASE ENTER THE ID ONLY!**");
			return 1;
		}

		giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
		    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			while ((idx < length) && ((idx - offset) < (sizeof(reason) - 1)))
			{
				reason[idx - offset] = cmdtext[idx];
				idx++;
			}
			reason[idx - offset] = EOS;
			if(!strlen(reason))
				{
					SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /freeze [playerid] [reason]");
					return 1;
				}
			else
			{
			printf("[ADMIN NEWS]: Admin %s froze %s. Reason: %s", sendername, giveplayer, reason);
			format(string, sizeof(string), " Administrator %s froze %s. [Reason: %s ]", sendername,giveplayer,reason);
   			SendClientMessageToAdmins(COLOR_RED, string,1);
			TogglePlayerControllable(giveplayerid,0);
			}
		}

		else if(giveplayerid == INVALID_PLAYER_ID)
		{
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_RED, string);
		}
	}
	else
 	{
 	SendClientMessage(playerid, COLOR_RED, "You are not an admin with the required level.");
  	}
	return 1;
}
if(strcmp(cmd, "/unfreeze", true) == 0)
{
	if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	{
	tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /unfreeze [playerid]");
			SendClientMessage(playerid, COLOR_YELLOW, "FUNCTION: Will unfreeze the specified player. **PLEASE ENTER THE ID ONLY!**");
			return 1;
		}

		giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
		    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			printf("Administrator %s unfroze %s.", sendername, giveplayer);
			format(string, sizeof(string), " Administrator %s unfroze %s ", sendername,giveplayer);
			SendClientMessageToAdmins(COLOR_RED, string,1);
			TogglePlayerControllable(giveplayerid,1);
		}

		else if(giveplayerid == INVALID_PLAYER_ID)
		{
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_RED, string);
		}
	}
	else
 	{
 	SendClientMessage(playerid, COLOR_RED, "You are not an admin with the required level.");
  	}
	return 1;
}
if(strcmp(cmd, "/nuke", true) == 0)
{
	if (dUserINT(PlayerName(playerid)).("admin") >= 4)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /nuke [playerid]");
				SendClientMessage(playerid, COLOR_YELLOW, "FUNCTION: Player will explode.");
				return 1;
			}
			new Float:X,Float:Y,Float:Z;
			giveplayerid = ReturnUser(tmp);
			    if(IsPlayerConnected(giveplayerid))
			    {
			    		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			    		GetPlayerName(playerid, player, sizeof(player));
						GetPlayerPos(giveplayerid, X,Y,Z);
			            CreateExplosion(X,Y,Z,2,7.0);
						SetPlayerHealth(giveplayerid, 0.0);
						format(string, sizeof(string), " Administrator %s nuked %s ",player,giveplayer);
						SendClientMessageToAdmins(COLOR_RED, string,1);
				}
				else if (!IsPlayerConnected(giveplayerid))
				{
					format(string, sizeof(string), "%d is not an active player.", giveplayerid);
					SendClientMessage(playerid, COLOR_RED, string);
				}
   }
	else
	{
	SendClientMessage(playerid, COLOR_RED, "You're not an admin with the required level.");
	}
return 1;
}
if(strcmp(cmd, "/gmx", true) == 0)
{
	if (dUserINT(PlayerName(playerid)).("admin") >= 4)
	{
	    GameModeExit();
	}
	else
	{
	SendClientMessage(playerid, COLOR_RED, "You are not a lead admin!");
	}
return 1;
}
if(strcmp(cmd, "//", true) == 0)
{
if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	{
    	GetPlayerName(playerid, playername, sizeof(playername));
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[256];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessage(playerid, COLOR_YELLOW, "USAGE: // <text>");
		}
			format(string, sizeof(string), "Admin [%i]%s: %s" ,playerid,playername, result);
			SendClientMessageToAdmins(COLOR_YELLOW,string,1);
   	}
	else
	{
		SendClientMessage(playerid, COLOR_RED, "You are not an admin.");
	}
  	return 1;
}
if(strcmp(cmd, "/makeadmin", true) == 0)
{
if (dUserINT(PlayerName(playerid)).("admin") >= 4)
	{
	tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /makeadmin [playerid] [level 1-5]");
			SendClientMessage(playerid, COLOR_YELLOW, "FUNCTION: Player will be an admin. **PLEASE ENTER THE ID ONLY!**");
			return 1;
		}
		giveplayerid = ReturnUser(tmp);
		tmp = strtok(cmdtext, idx);
		level = strval(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
				GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
		  		dUserSetINT(PlayerName(playerid)).("admin",level);
				printf("[ADMIN NEWS]: %s made %s a level %d admin.", sendername, giveplayer, level);
				format(string, sizeof(string), "You are now an administrator level %d thanks to %s.", level, sendername);
				SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "You have given %s level %d admin.", giveplayer,dUserINT(PlayerName(playerid)).("admin"));
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		}
		else if(giveplayerid != INVALID_PLAYER_ID)
		{
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_RED, string);
		}
	}
	else
	{
	SendClientMessage(playerid, COLOR_RED, "You are not a high enough leveL!");
	}
return 1;
}
	if (strcmp(cmdtext, "/scores", true)==0)
	{
 	new wstring[128];
    format(wstring, sizeof(wstring), "[SCORES] Red Team: %d - Blue Team: %d.", redscore,bluescore);
    SendClientMessage(playerid,COLOR_OOC, wstring);
	return 1;
	}
 	if(strcmp(cmd, "/ban", true) == 0)
{
new reason[256];
if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	{
	tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /ban [playerid] [reason]");
			SendClientMessage(playerid, COLOR_WHITE, "FUNCTION: Will BAN the specified account.");
			return 1;
  }

		giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
		    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			while ((idx < length) && ((idx - offset) < (sizeof(reason) - 1)))
			{
				reason[idx - offset] = cmdtext[idx];
				idx++;
			}
			reason[idx - offset] = EOS;
			if(!strlen(reason))
				{
					SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /ban [playerid] [reason]");
					return 1;
				}
			else
			{
			format(string, sizeof(string), "Administrator %s has banned %s - Reason: %s", sendername,giveplayer,reason);
			dUserSet(PlayerName(giveplayerid)).("banned", "1");
			SendClientMessageToAll(COLOR_YELLOW, string);
			Kick(giveplayerid);
			}
		}
		else if(giveplayerid == INVALID_PLAYER_ID)
		{
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
	}
	else
 	{
 	SendClientMessage(playerid, COLOR_YELLOW, "You are not an administrator or an administrator with the required level.");
  	}
return 1;
}
if(strcmp(cmd, "/kick", true) == 0)
{
new reason[256];
if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	{
	tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /kick [playerid] [reason]");
			SendClientMessage(playerid, COLOR_WHITE, "FUNCTION: Will kick the specified player.");
			return 1;
  }

		giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
		    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			while ((idx < length) && ((idx - offset) < (sizeof(reason) - 1)))
			{
				reason[idx - offset] = cmdtext[idx];
				idx++;
			}
			reason[idx - offset] = EOS;
			if(!strlen(reason))
				{
					SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /kick [playerid] [reason]");
					return 1;
				}
			else
			{
			format(string, sizeof(string), "Administrator %s has kicked %s - Reason: %s", sendername,giveplayer,reason);
			SendClientMessageToAll(COLOR_YELLOW, string);
			Kick(giveplayerid);
			}
		}
		else if(giveplayerid == INVALID_PLAYER_ID)
		{
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
	}
	else
 	{
 	SendClientMessage(playerid, COLOR_YELLOW, "You are not an administrator or an administrator with the required level.");
  	}
return 1;
}
if(strcmp(cmd, "/disarm", true) == 0)
{
new reason[256];
if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	{
	tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /kick [playerid] [reason]");
			SendClientMessage(playerid, COLOR_WHITE, "FUNCTION: Will kick the specified player.");
			return 1;
  }

		giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
		    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			while ((idx < length) && ((idx - offset) < (sizeof(reason) - 1)))
			{
				reason[idx - offset] = cmdtext[idx];
				idx++;
			}
			reason[idx - offset] = EOS;
			if(!strlen(reason))
				{
					SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /disarm [playerid] [reason]");
					return 1;
				}
			else
			{
			format(string, sizeof(string), "Administrator %s has disarmed %s - Reason: %s", sendername,giveplayer,reason);
			SendClientMessageToAll(COLOR_YELLOW, string);
			ResetPlayerWeapons(giveplayerid);
			}
		}
		else if(giveplayerid == INVALID_PLAYER_ID)
		{
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
	}
	else
 	{
 	SendClientMessage(playerid, COLOR_YELLOW, "You are not an administrator or an administrator with the required level.");
  	}
return 1;
}
	if (strcmp(cmdtext, "/stopplaying", true)==0)
	{
		playingfootball[playerid]=0;
		teamselected[playerid]=0;
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"You stopped playing football.");
		SetPlayerHealth(playerid,-1);
		ForceClassSelection(playerid);
		TextDrawShowForPlayer(playerid,Text:Textdraw0);//Red team textdraw
		TextDrawShowForPlayer(playerid,Text:Textdraw1);//blue team textdraw
		return 1;
	}
if(strcmp(cmd, "/goto", true) == 0)
{
new Float:pX,Float:pY,Float:pZ;
if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	{
	tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /goto [playerid]");
			SendClientMessage(playerid, COLOR_YELLOW, "FUNCTION: Will teleport to the specified player.");
			return 1;
		}

		giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
		    if (GetPlayerState(playerid) == 2)
		    {
		    GetPlayerPos(giveplayerid,pX,pY,pZ);
		    SetVehiclePos(GetPlayerVehicleID(playerid),pX,pY,pZ+2);
	  		}
	  		else
	  		{
		    GetPlayerPos(giveplayerid,pX,pY,pZ);
		    SetPlayerPos(playerid,pX,pY,pZ+2);
		    }
		}
		else if(giveplayerid == INVALID_PLAYER_ID)
		{
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_RED, string);
		}
	}
	else
 	{
 	SendClientMessage(playerid, COLOR_RED, "You are not an admin with the required level.");
  	}
	return 1;
}
if(strcmp(cmd, "/gethere", true) == 0)
{
new Float:pX,Float:pY,Float:pZ;
if (dUserINT(PlayerName(playerid)).("admin") >= 1)
	{
	tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /gethere [playerid]");
			SendClientMessage(playerid, COLOR_YELLOW, "FUNCTION: Will teleport the specified player to you.");
			return 1;
		}
		giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
		    if (GetPlayerState(giveplayerid) == PLAYER_STATE_DRIVER)
		    {
		    GetPlayerPos(playerid,pX,pY,pZ);
		    SetVehiclePos(GetPlayerVehicleID(giveplayerid),pX,pY,pZ+2);
	  		}
	  		else
	  		{
		    GetPlayerPos(playerid,pX,pY,pZ);
		    SetPlayerPos(giveplayerid,pX,pY,pZ+2);
		    }
		}
		else if(giveplayerid == INVALID_PLAYER_ID)
		{
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_RED, string);
		}
	}
	else
 	{
 	SendClientMessage(playerid, COLOR_RED, "You are not an admin with the required level.");
  	}
	return 1;
}
	return 0;
}
GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance){
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
public KeyChanges(){
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
				MoveObject(football,px,py,15.789375,10.0);
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
				MoveObject(football,px,py,15.789375,10.0);
				PlayerPlaySound(playerid,1130,0.0,0.0,0.0);
				ApplyAnimation(playerid,"FIGHT_D","FightD_1",4.1,0,1,1,0,0);
				}
			}
		}
	}
}
public IsAGoal(){
    for(new playerid = 0; playerid < MAX_PLAYERS; playerid++)
    {
    if(IsPlayerConnected(playerid))
    {
	new string1[128];
	format(string1, sizeof(string1), "Red Team: %d", redscore);
	TextDrawSetString(Text:Textdraw3,string1);

  	new string2[128];
	format(string2, sizeof(string2), "Blue Team: %d", bluescore);
	TextDrawSetString(Text:Textdraw4,string2);

    new Float:fx, Float:fy, Float:fz;
	GetObjectPos(football, fx, fy, fz);
	new enteredid = GetLastEnteredID(lastentered);

	SetPlayerMapIcon( playerid, 0, fx, fy, fz, 56, 0 );//ball icon


			if(bluescore >= 12)
			{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
			SendClientMessageToAll(COLOR_GREEN,"[VICTORY] The blue team has won!");
			bluescore = 0;
			redscore = 0;
			SetTimerEx("SpawnMe", 15000, 0, "i", i);
			SendClientMessageToAll(COLOR_WHITE,"[SERVER] New Game Starting In 15 Seconds.");
   			ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
			TogglePlayerControllable(i,0);

			if(gTeam[i] == TEAM_BLUE)
			{
			SetPlayerSpecialAction(i,SPECIAL_ACTION_DANCE3);
			}
			return 1;
			}
			}
			if(redscore >= 12)
			{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
			SendClientMessageToAll(COLOR_GREEN,"[VICTORY] The red team has won!");
			SetTimerEx("SpawnMe", 15000, 0, "i", i);
			SendClientMessageToAll(COLOR_WHITE,"[SERVER] New Game Starting In 15 Seconds.");
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
			if(ObjectToPoint(2.0,football,122.3518,2499.8162,16.4844) && gTeam[enteredid] == TEAM_BLUE)//Net right hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[BLUE TEAM] %s has scored an own goal, -1 Points! ", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
   			SetPlayerScore(enteredid, score-1);

   			bluescore -= 1;

			DestroyObject(football);
			football=CreateObject(1598, 89.615692, 2500.632324, 15.789375, 0.0000, 0.0000, 0.0000);
			}
			if(ObjectToPoint(2.0,football,44.3105,2502.3252,16.4844) && gTeam[enteredid] == TEAM_BLUE)//Net left hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[BLUE TEAM] %s has scored a goal against the red team!", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
   			SetPlayerScore(enteredid, score+1);

            bluescore += 1;

			DestroyObject(football);
			football=CreateObject(1598, 89.615692, 2500.632324, 15.789375, 0.0000, 0.0000, 0.0000);
			}

			//RED TEAM STUFF
			if(ObjectToPoint(2.0,football,122.3518,2499.8162,16.4844) && gTeam[enteredid] == TEAM_RED)//Net right hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[RED TEAM] %s has scored a goal against the blue team!", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
   			SetPlayerScore(enteredid, score+1);

            redscore += 1;

			DestroyObject(football);
			football=CreateObject(1598, 89.615692, 2500.632324, 15.789375, 0.0000, 0.0000, 0.0000);
			}
			if(ObjectToPoint(2.0,football,44.3105,2502.3252,16.4844) && gTeam[enteredid] == TEAM_RED)//Net left hand side
			{
			new wstring[128];
    		format(wstring, sizeof(wstring), "[RED TEAM] %s has scored an own goal, -1 Points! ", lastentered);
   			SendClientMessageToAll(COLOR_LIGHTBLUE, wstring);

			new score = GetPlayerScore(enteredid);
   			SetPlayerScore(enteredid, score-1);

            redscore -= 1;

			DestroyObject(football);
			football=CreateObject(1598, 89.615692, 2500.632324, 15.789375, 0.0000, 0.0000, 0.0000);
			}
  		}
	}
	return 1;
}
public SpawnMe(playerid){
		TogglePlayerControllable(playerid,1);
		SpawnPlayer(playerid);
		ClearAnimations(playerid);
		return 1;
}
public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z){
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
public ObjectToPoint(Float:radi, objectid, Float:x, Float:y, Float:z){
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
stock PlayerName(playerid){
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	return name;
}
stock GetLastEnteredID(lastentered[]){
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
public SendClientMessageToAdmins(color,const string[],alevel){
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (dUserINT(PlayerName(i)).("admin") >= 1)
			{
				SendClientMessage(i, color, string);
				printf("%s", string);
			}
		}
	}
	return 1;
}
GetVehicleModelIDFromName(vname[]){
	for(new i = 0; i < 211; i++)
	{
		if(strfind(aVehicleNames[i], vname, true) != -1)
		return i + 400;
	}
	return -1;
}
stock IsInvalidSkin(skinid){
	new InSkin[] = {0, 3, 4, 5, 6, 8, 42, 65, 74, 86, 119, 149, 208,  273, 289};
	for (new i=0; i<sizeof(InSkin); i++) if(skinid == InSkin[i]) return 1;
	return 0;
}
