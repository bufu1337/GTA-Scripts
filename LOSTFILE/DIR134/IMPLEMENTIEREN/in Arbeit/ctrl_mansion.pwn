//////////////////////////// CONTROL - Mansion v1.1 (by switch) /////////////////////////////
//-------------------------------------------------------------------------------------//
/////////////////////////////v VARIABLES, DEFINES, FORWARDS v/////////////////////////////
#include <a_samp>
#define CHECKPOINT_TIME 15000
#define TEAM_BLUE 1
#define TEAM_YELLOW 2
#define TEAM_BLUE_COLOR 0xa0d3ffAA // Blue
#define TEAM_YELLOW_COLOR 0xe8ca00AA // Yellow

#define COLOR_BLUE 0x000ecaAA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA

new gTeam[MAX_PLAYERS];
new gProgressBlue;
new gProgressYellow;
new gKillerid[MAX_PLAYERS];
new Text:txtObsHelper;
new Text:txtScore;
new gPickupids[MAX_PLAYERS];//holds the pickupid for a players backpack so it can be refereneced
new gBackpack[MAX_PLAYERS][5];//holds the weapons for each backpack
new gBackpackAmmo[MAX_PLAYERS][5];//holds the weapons for each backpack
new gCountdown[4];
new gCountdown2[4];
new Text:txtCountdown;
new gSpectating[MAX_PLAYERS];
new gCheckpointTimer[MAX_PLAYERS];
new gYellowScore;
new gBlueScore;

#define YELLOWSPAWN 0
#define CPA 1
#define CPB 2
#define BLUESPAWN 3

forward IncCheckpointBlue(playerid,yellow,blue);
forward IncCheckpointYellow(playerid,yellow,blue);
forward resetGame();
forward sendtoSpawn(playerid);
forward updateCountdown(count);
forward endGame();
/////////////////////////////^ VARIABLES, DEFINES, FORWARDS ^/////////////////////////////
//--------------------------------------------------------------------------------------//
///////////////////////////////////v EDITABLE CODE v//////////////////////////////////////
#define BACKPACK_START 16 //amount of addstatickpickups
new gamename[56]="mansion";
new gInterior=5;
new checkpointNames[4][256] = {
	"Yellow Spawn",
	"Yellow Studio",
	"Blue Gym",
	"Blue Spawn"
};

new Float:coords[4][4] = {
	{ 1277.472412 , -831.984497 , 1085.632812, 92.601882 }, // y base
	{ 1245.938598 , -802.839904 , 1084.007812, 245.250915 }, // y cp1
	{ 1234.287841 , -763.404541 , 1084.007446, 5.154187 }, // b cp1
	{ 1284.441894 , -766.509460 , 1084.007812, 176.964706 } // b base

};

new Float:yspawns[4][4] = {
	{ 1276.782958 , -780.648864 , 1089.937500, 261.343811 }, // y spawn
	{ 1226.139160 , -808.570190 , 1084.007812, 253.881439 }, // yellow spawn2
	{ 1270.393188 , -794.763183 , 1084.171875, 9.544271 }, // yellow spawn3
	{ 1299.842163 , -792.572204 , 1084.007812, 342.779846 } // b spawn
};
new Float:bspawns[4][4] = {
	{ 1276.782958 , -780.648864 , 1089.937500, 261.343811 }, // y spawn
	{ 1266.228759 , -795.288940 , 1084.007812, 8.223627 }, // bluespawn3
	{ 1265.938720 , -777.291320 , 1084.007812, 358.131744 }, // bluespawn2
	{ 1299.842163 , -792.572204 , 1084.007812, 342.779846 } // b spawn
};

main()
{
	print("\nRUNNING: Control:Mansion - by switch");
}

public OnGameModeInit()
{
	SetGameModeText("ctrl_mansion");
	AddPlayerClass(110,0,0,0,0,24,300,0,0,0,0);
	AddPlayerClass(109,0,0,0,0,23,300,0,0,0,0);           // YellowSpawn B
	AddPlayerClass(108,0,0,0,0,22,300,0,0,0,0);           // YellowSpawn C

	AddPlayerClass(116,0,0,0,0,24,300,0,0,0,0); // BlueSpawn A
	AddPlayerClass(115,0,0,0,0,23,300,0,0,0,0);          // BlueSpawn B
	AddPlayerClass(114,0,0,0,0,22,300,0,0,0,0);          // BlueSpawn C


	AddStaticPickup(353, 2,1264.043945 , -772.625671 , 1084.007812); // mp5#
	AddStaticPickup(344, 2,2182.989501 , -1158.164184 , 1029.796875); // moltov
	AddStaticPickup(351, 2,1236.194458 , -832.640014 , 1084.007812); // shotty#
	AddStaticPickup(1242, 2,2186.801757 , -1188.245849 , 1033.796875); // armour
	AddStaticPickup(1240, 2,2536.791503 , -1282.616088 , 1044.125000); // health
	AddStaticPickup(355, 2,1236.879394 , -771.627807 , 1084.000000); // ak#
	AddStaticPickup(342, 2,1255.244140 , -804.105346 , 1084.015136); // grens#
	AddStaticPickup(352, 2,1272.760986 , -808.024230 , 1084.014892); // mac10#
	AddStaticPickup(356, 2,1282.693237 , -835.638793 , 1089.937500); // m4#
	AddStaticPickup(352, 2,1253.608642 , -827.880737 , 1084.007812); // mac10#
	AddStaticPickup(1242, 2,1235.610595 , -812.134887 , 1084.007812); // armour#
	AddStaticPickup(1240, 2,1278.536743 , -793.254211 , 1084.171875); // health#

	AddStaticPickup(352, 2,1276.278564 , -789.765686 , 1089.937500); // mac10#
	AddStaticPickup(352, 2,1278.308837 , -823.047546 , 1085.632812); // mac10#
	AddStaticPickup(358, 2,1276.278564 , -789.765686 , 1089.937500); // sniper#
	AddStaticPickup(351, 2,1258.363281 , -794.597229 , 1084.234375); // shotty#
	
	gProgressYellow=CPA;//1
	gProgressBlue=CPB;//2
	updateCountText();
	updateText();
	AllowInteriorWeapons(1);
	UsePlayerPedAnims();
	ShowNameTags(1);
	return 1;
}
////////////////////////////////////^ EDITABLE CODE ^/////////////////////////////////////
//--------------------------------------------------------------------------------------//
////////////////////////////////////v CUSTOM FUNCTIONS v//////////////////////////////////

updateCheckpoint(playerid){

	switch (gTeam[playerid]) {
		case TEAM_BLUE:
			SetPlayerCheckpoint(playerid, coords[gProgressBlue][0],coords[gProgressBlue][1],coords[gProgressBlue][2],3.0);
		case TEAM_YELLOW:
			SetPlayerCheckpoint(playerid, coords[gProgressYellow][0],coords[gProgressYellow][1],coords[gProgressYellow][2],3.0);
	}


}

public sendtoSpawn(playerid){
	TogglePlayerSpectating(playerid, 0);
	gSpectating[playerid]=0;
    updateCheckpoint(playerid);
	switch (gTeam[playerid]) {
		case TEAM_BLUE:{
			SetPlayerPos(playerid, bspawns[gProgressBlue+1][0], bspawns[gProgressBlue+1][1], bspawns[gProgressBlue+1][2]);
			SetPlayerFacingAngle(playerid, bspawns[gProgressBlue+1][3]);
		}
		case TEAM_YELLOW:{
			SetPlayerPos(playerid, yspawns[gProgressYellow-1][0], yspawns[gProgressYellow-1][1], yspawns[gProgressYellow-1][2]);
			SetPlayerFacingAngle(playerid, yspawns[gProgressYellow-1][3]);
		}
	}
	SetCameraBehindPlayer(playerid);
}


SetPlayerTeamFromClass(playerid, classid)
{
	if (classid == 0 || classid == 1 || classid == 2)gTeam[playerid] = TEAM_YELLOW;
	else gTeam[playerid] = TEAM_BLUE;

}

SetPlayerToTeamColor(playerid)
{
	if (gTeam[playerid] == TEAM_BLUE)SetPlayerColor(playerid, TEAM_BLUE_COLOR);
	else if (gTeam[playerid] == TEAM_YELLOW) SetPlayerColor(playerid, TEAM_YELLOW_COLOR);
}


public IncCheckpointBlue(playerid,yellow,blue) {

	new captured[256];
	format(captured, sizeof(captured),"The Blue Team has captured %s.", checkpointNames[blue]);
	SendClientMessageToAll(TEAM_BLUE_COLOR, captured);
	GameTextForAll(captured, 3000, 5);
	SetPlayerScore(playerid,GetPlayerScore(playerid)+5);
	gProgressBlue--;
	if(blue<yellow)gProgressYellow--;
	if (blue<=yellow)//y1b2
	{
		killallTimers(-1);
		if(blue!=YELLOWSPAWN)updateAllCheckpoints(-1);
	} else {
		killallTimers(TEAM_BLUE);
		updateAllCheckpoints(TEAM_BLUE);
	}
	if (blue==0)
	{
  		removeChecks(-1);
		if 	(gYellowScore==3){
			SetTimer("endGame", 5000, 0);
			GameTextForAll("~r~Blue Team won the round!", 4000, 5);
		} else {
			SetTimer("resetGame", 5000, 0);
			GameTextForAll("~r~Blue Team has won the game!", 4000, 5);
		  	gBlueScore++;
		}
		updateScoreText();
		return 1;
	}
	updateText();
	return 1;
}

public IncCheckpointYellow(playerid,yellow,blue) {

	new captured[256];
	format(captured, sizeof(captured),"The Yellow Team has captured %s.", checkpointNames[yellow]);
	SendClientMessageToAll(TEAM_YELLOW_COLOR, captured);
	GameTextForAll(captured, 3000, 5);
	SetPlayerScore(playerid,GetPlayerScore(playerid)+5);
	gProgressYellow++;
	if(yellow>blue)gProgressBlue++;
	if (yellow>=blue)//y1b2
	{
		killallTimers(-1);
		if(yellow!=BLUESPAWN)updateAllCheckpoints(-1);
	} else {
		killallTimers(TEAM_YELLOW);
		updateAllCheckpoints(TEAM_YELLOW);
	}
	if (yellow==3)
	{
  		removeChecks(-1);
  		gYellowScore++;
		if 	(gYellowScore==3){
			GameTextForAll("~r~Yellow Team has won the game!", 4000, 5);
			SetTimer("endGame", 5000, 0);
		} else {
			GameTextForAll("~r~Yellow Team won the round!", 4000, 5);
			SetTimer("resetGame", 5000, 0);
		}
		updateScoreText();
	}
	updateText();
	return 1;
}


updateAllCheckpoints(team){

	for(new i = 0; i < MAX_PLAYERS; i++) {
		if (team==-1 && IsPlayerConnected(i)){updateCheckpoint(i);}
		else if (team==gTeam[i]){updateCheckpoint(i);}

	}
}

killallTimers(team)
{

	for(new i = 0; i < MAX_PLAYERS; i++) {
		if (team==-1 && IsPlayerConnected(i)){
			KillTimer(gCheckpointTimer[i]);
		}
		else if (team==gTeam[i])
		{
			KillTimer(gCheckpointTimer[i]);
		}
	}

}

removeChecks(team){
	for(new i = 0; i < MAX_PLAYERS; i++) {
		if (team==-1 && IsPlayerConnected(i))DisablePlayerCheckpoint(i);
		else if (team==gTeam[i])DisablePlayerCheckpoint(i);
	}
}

public resetGame()
{
	gProgressBlue=CPB;
	gProgressYellow=CPA;
	for(new i = 0; i < MAX_PLAYERS; i++) {
		updateCheckpoint(i);
		sendtoSpawn(i);
	}
	updateText();
}


updateText()
{

	new c[4];
	for(new i = 0; i < 4; i++) {
		if(gProgressYellow>i){c[i]=121;
		}
		else if(gProgressBlue<i){c[i]=98;}
		else {c[i]=119;}
	}
	new msg1[256];
	format(msg1,sizeof(msg1), "~r~~%c~%s~n~~%c~%s~n~~%c~%s~n~~%c~%s", c[0],checkpointNames[0],c[1],checkpointNames[1],c[2],checkpointNames[2],c[3],checkpointNames[3]);
	txtObsHelper = TextDrawCreate(450.0, 400.0,	msg1);
	TextDrawUseBox(txtObsHelper, 0),TextDrawFont(txtObsHelper, 2),TextDrawSetShadow(txtObsHelper,0),TextDrawSetOutline(txtObsHelper,1),TextDrawBackgroundColor(txtObsHelper,0x000000FF),TextDrawColor(txtObsHelper,0xFFFFFFFF);
	for(new i = 0; i < MAX_PLAYERS; i++) {
		if(IsPlayerConnected(i))
		{
			TextDrawShowForPlayer(i, txtObsHelper);
		}

	}
	return 1;
}

updateScoreText()
{

	new msg1[256];
	format(msg1,sizeof(msg1), "~y~Yellow~w~:%d~n~~b~ Blue~w~:%d", gYellowScore, gBlueScore);
	TextDrawDestroy(txtScore);
	txtScore = TextDrawCreate(620.0, 375.0,	msg1);
	TextDrawUseBox(txtScore, 0),TextDrawFont(txtScore, 2),TextDrawSetShadow(txtScore,0),TextDrawSetOutline(txtScore,1),TextDrawBackgroundColor(txtScore,0x000000FF),TextDrawColor(txtScore,0xFFFFFFFF);TextDrawAlignment(txtScore,3);
	for(new i = 0; i < MAX_PLAYERS; i++) {
		if(IsPlayerConnected(i))
		{
			TextDrawShowForPlayer(i, txtScore);
		}

	}
	return 1;
}

public endGame()
{
	GameModeExit();
}
////////////////////////////////////^ CUSTOM FUNCTIONS ^////////////////////////////////////
//---------------------------------------------------------------------------------------//
////////////////////////////////////v SAMP FUNCTIONS v/////////////////////////////////////
public OnGameModeExit()
{
	print("EXIT: Gamemode Exiting..Goodbye!");
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
 	SetPlayerInterior(playerid,0);
	SetPlayerPos(playerid,2198.148193 , -1161.229125 , 35.102226);
	SetPlayerFacingAngle(playerid, 86.530921);
	SetPlayerCameraPos(playerid,2195.503417 , -1161.334350 , 36.102226);
	SetPlayerCameraLookAt(playerid,2199.276123 , -1161.410156 , 34.831250);
	SetWeather(6);
	SetWorldTime(2);

	SetPlayerTeamFromClass(playerid, classid);

 	if (classid == 0 || classid == 1 || classid == 2) GameTextForPlayer(playerid, "~y~Yellow Team", 3000, 3);
	else GameTextForPlayer(playerid, "~b~Blue Team", 3000, 3);

	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	new jmsg[256];
	format (jmsg,256,"Control:%s ~r~by switch",gamename);
	GameTextForPlayer(playerid,jmsg,2500,5);
	gKillerid[playerid]=-1;
	GivePlayerMoney(playerid, 1250);
	gPickupids[playerid]=-1;
	new pname[MAX_PLAYER_NAME],pmsg[256];
	GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
	format(pmsg,256,"%s has joined the server",pname);
	for(new j=0;j<MAX_PLAYERS;j++){
		if(j!=playerid){
			SendClientMessage(j,COLOR_WHITE,pmsg);
		}
	}
	SetPlayerColor(playerid, COLOR_GREY); // Set the player's color to inactive
	new jmsg2[256];
	format (jmsg2,256,"Welcome to Control:%s",gamename);
	SendClientMessage(playerid, COLOR_YELLOW, jmsg2);
	SendClientMessage(playerid, COLOR_YELLOW, "In this game mode teams must capture and defend the four checkpoints. Working your way from your base to your enemies base.");
	SendClientMessage(playerid, COLOR_YELLOW, "A team must hold all four checkpoints to win the game. To Capture a checkpoint simply stay inside it for 15 seconds. Then move on to the next.");
	updateScoreText();
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new pname[MAX_PLAYER_NAME],pmsg[256];
	GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
	format(pmsg,256,"%s has left the server",pname);
	for(new j=0;j<MAX_PLAYERS;j++){
		if(j!=playerid){
			SendClientMessage(j,COLOR_WHITE,pmsg);
		}
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
    SetPlayerInterior(playerid,gInterior);
    SetPlayerToTeamColor(playerid);
	TextDrawShowForPlayer(playerid, txtObsHelper);

    if (IsPlayerConnected(gKillerid[playerid])){
        new pname[MAX_PLAYER_NAME],pmsg[256];
        GetPlayerName(gKillerid[playerid],pname,MAX_PLAYER_NAME);
        format(pmsg,256,"~n~~n~~n~~n~Spectating: %s",pname);
        GameTextForPlayer(playerid, pmsg,7000,3);
    	TogglePlayerSpectating(playerid, 1);
    	gSpectating[playerid]=1;
    	PlayerSpectatePlayer(playerid, gKillerid[playerid]);
		SendClientMessage(playerid,COLOR_YELLOW,"STATUS: Respawning in 7 seconds..");
		SetTimerEx("sendtoSpawn", 7000, 0, "d", playerid);
		gKillerid[playerid]=255;
    } else {
    	sendtoSpawn(playerid);
    }




	printf("OnPlayerSpawn(%d)", playerid);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	new weaponid[13],ammo[13],Float:x,Float:y,Float:z;
	if (gPickupids[playerid]>=0){
		DestroyPickup(gPickupids[playerid]);
	}
	new j;
	for(new i = 0; i < 5; i++)
	{
		gBackpack[playerid][i]=0;
		gBackpackAmmo[playerid][i]=0;
	}
	for(new i = 0; i < 13; i++)
	{
		GetPlayerWeaponData(playerid,i,weaponid[i],ammo[i]);
		if (weaponid[i]>0)
		{
			gBackpack[playerid][j]=weaponid[i];
			gBackpackAmmo[playerid][j]=ammo[i];
			if (ammo[i]==0)gBackpack[playerid][j]=0;
			j++;
		}
	}
	GetPlayerPos(playerid,x,y,z);
	gPickupids[playerid] = CreatePickup(1210,3,x,y,z-0.5);
	KillTimer(gCheckpointTimer[playerid]);
	DisablePlayerCheckpoint(playerid);
	gKillerid[playerid]=killerid;

    if(killerid == INVALID_PLAYER_ID) {
        SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
	} else {
	   	SendDeathMessage(killerid,playerid,reason);
		SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/kill", cmdtext, true, 10) == 0)
	{
		SetPlayerHealth(playerid,0.0);
		return 1;
	}
	return 0;
}

updateCountText(){

	new c[4];
	for(new i = 0; i < 4; i++) {
		if(gCountdown2[i]>=0)
		{
			c[i]=gCountdown2[i];
		}
		else {c[i]=-1;}
	}

	new msg1[256];
	format(msg1,sizeof(msg1), "~r~%d~n~%d~n~%d~n~%d", c[0],c[1],c[2],c[3]);
	txtCountdown = TextDrawCreate(150.0, 400.0,	msg1);
	TextDrawUseBox(txtCountdown, 0),TextDrawFont(txtCountdown, 2),TextDrawSetShadow(txtCountdown,0),TextDrawSetOutline(txtCountdown,1),TextDrawBackgroundColor(txtCountdown,0x000000FF),TextDrawColor(txtCountdown,0xFFFFFFFF);

	return 1;
}
public updateCountdown(count)
{
	if (gCountdown2[count]<0)
	{
		KillTimer(gCountdown[count]);
		return 1;
	}
	gCountdown2[count]--;
	updateCountText();
	return 1;
}


public OnPlayerEnterCheckpoint(playerid)
{
	if(gSpectating[playerid]==1)return 1;
	new string[255];
	new playername[MAX_PLAYER_NAME];

	switch (gTeam[playerid]) {
		case TEAM_BLUE:
		{
			GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
			format(string, sizeof(string),"%s is capturing the %s.", playername, checkpointNames[gProgressBlue]);
			SendClientMessageToAll(TEAM_BLUE_COLOR, string);
			gCheckpointTimer[playerid] = SetTimerEx("IncCheckpointBlue", CHECKPOINT_TIME, 0,"ddd",playerid,gProgressYellow,gProgressBlue);
		}
	 	case TEAM_YELLOW:
	  	{
			GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
			format(string, sizeof(string),"%s is capturing the %s.", playername, checkpointNames[gProgressYellow]);
			SendClientMessageToAll(TEAM_YELLOW_COLOR, string);
			gCheckpointTimer[playerid] = SetTimerEx("IncCheckpointYellow", CHECKPOINT_TIME, 0,"ddd",playerid,gProgressYellow,gProgressBlue);
	  	}
	   }
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	printf("OnPlayerLeaveCheckpoint(%d)", playerid);
	new string[256];
	new playername[256];
	switch (gTeam[playerid]) {
		case TEAM_BLUE:
		{
			GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
			format(string, sizeof(string),"%s failed to capture the %s.", playername, checkpointNames[gProgressBlue]);
			SendClientMessageToAll(TEAM_BLUE_COLOR, string);
			SendClientMessage(playerid, TEAM_BLUE_COLOR, "Stay inside the checkpoint to capture!");
		}
	 	case TEAM_YELLOW:
	  	{
			GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
			format(string, sizeof(string),"%s failed to capture the %s.", playername, checkpointNames[gProgressYellow]);
			SendClientMessageToAll(TEAM_YELLOW_COLOR, string);
			SendClientMessage(playerid, TEAM_YELLOW_COLOR, "Stay inside the checkpoint to capture!");
	  	}
	}
	KillTimer(gCheckpointTimer[playerid]);
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if (pickupid>=BACKPACK_START)
	{
		new l;

		for(new i = 0; i < MAX_PLAYERS; i++) {
			if (gPickupids[i]==pickupid) l=i;
		}
		new j;
		while(gBackpack[l][j]>0){
			GivePlayerWeapon(playerid,gBackpack[l][j],gBackpackAmmo[l][j]/2);
			print("hi");
			j++;
		}
	}
	DestroyPickup(pickupid);
	return 1;
}




