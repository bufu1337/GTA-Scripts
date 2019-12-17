///////////////////////////////////////////////////////////////////////////////
//                    Adrenaline (Racing) - 1.06 - by switch                 //
///////////////////////////////////////////////////////////////////////////////
//                                 Credits                                   //
//                                                                           //
//                                 Coding:                                   //
//                                                                           //
//                 Kynen: Highscore() code he made for me                    //
//          Y_Less: Used GetXYInFrontOfPlayer() as base of Grid function     //
//        Simon: Used ConvertToSafeInput() as base for CheckSafeInput()      //
//                            Dabombber: TimeConvert()                       //
//             Yagu: Referenced his race filterscript early on               //
//             http://forum.sa-mp.com/index.php?topic=20637.0                //
//                                                                           //
//                                                                           //
//                                 Testing:                                  //
//                                                                           //
//                               aerodynamics                                //
//                                [RSD]Potti                                 //
//         any other person who crashed while on my TestServer :)            //
//                                                                           //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////

#include <a_samp>
#define TIME_GIVE_CAR 3000
#define TIME_MOVE_PLAYER 4000
#define TIME_PUT_PLAYER 3000
#define TIME_SHOW_VOTE 4000

#define SPARE_CARS 2 //number of spare cars per race
#define RACES_TILL_MODECHANGE 0 //for use if you just want a few races to play then change to another mode
#define SHOW_JOINS_PARTS //comment out if you don't want hide/parts shown
#define CHECK_SIZE 12.0 //checkpoint size
#define COLOR_TEMP 0xFFFFFFAA

#define MAX_RACES 200
#define MAX_RACECHECKPOINTS 100

#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1  //CREDIT: DracoBlue

new gMaxCheckpoints;
new Float:RaceCheckpoints[MAX_RACECHECKPOINTS][4];
new Float:xRaceCheckpoints[MAX_PLAYERS][MAX_RACECHECKPOINTS][4];
new xWorldTime[MAX_PLAYERS];
new xTrackTime[MAX_PLAYERS];
new xWeatherID[MAX_PLAYERS];
new xRaceType[MAX_PLAYERS];
new xRaceName[MAX_PLAYERS][256];
new Float:xFacing[MAX_PLAYERS];
new xCreatorName[MAX_PLAYERS][MAX_PLAYER_NAME];
new xRaceBuilding[MAX_PLAYERS];
new xCarIds[MAX_PLAYERS][5];
new gPlayerProgress[MAX_PLAYERS];
new xPlayerProgress[MAX_PLAYERS];
new gFinishOrder;
new gRaceNames[MAX_RACES][128];
new gRaceStart;
new gCountdown;
new gRaceStarted;
new gWorldTime;
new gWeather;
new gCountdowntimer;
new gEndRacetimer;
new gTrackTime;
new Float:gGrid[8];
new Float:gGrid2[8];
new vehicles[MAX_PLAYERS];
new gRaces;
new Menu:voteMenu;
new Menu:buildMenu[MAX_PLAYERS];
new gVoteItems[4][256];
new gVotes[4];
new gRacePosition[MAX_PLAYERS];
new gTotalRacers;
new gTrackName[256];
new gGridIndex;
new gGridCount;
new gGrid2Index;
new gGrid2Count;
new gCarModelID;
new gRaceType;
new gRaceMaker[256];
new gFinished;
new spawned[MAX_PLAYERS];
new newcar[MAX_PLAYERS];
new gWorldID;

new showVoteTimer[MAX_PLAYERS];
new gNextTrack[256];
new gVehDestroyTracker[700];
new gGiveCarTimer[MAX_PLAYERS];
new gScores[MAX_PLAYERS][2];
new gScores2[MAX_PLAYERS][2];
new gGrided[MAX_PLAYERS];
new racecount;


new Text:Ttime;
new Text:Ttotalracers;
new Text:Tposition[MAX_PLAYERS];
new Text:Tappend[MAX_PLAYERS];
new gMinutes, gSeconds;
new gindex;
	
	
#define HIGH_SCORE_SIZE 5                   //Max number of ppl on the highscore list

enum rStats {                                               //Highscore enum
     rName[128],
     rTime,
     rRacer[MAX_PLAYER_NAME],
};
new gBestTime[256];



forward Countdowntimer();
forward nextRaceCountdown();
forward countVotes();
forward changetrack();
forward showVote(playerid);
forward RemovePlayersFromVehicles();
forward DestroyAllVehicles();
forward destroyCarSafe(veh);
forward giveCar(playerid, modelid, world);
forward GridSetup(playerid);
forward GridSetupPlayer(playerid);
forward PutPlayerInVehicleTimed(playerid, veh, slot);
forward respawnCar(veh);
forward updateTime();
forward AddRacers(num);


//////////////////////////////////////////////////
//// x.x SA-MP FUNCTIONS (START) /////////////////
//////////////////////////////////////////////////

public OnPlayerSelectedMenuRow(playerid, row)
{
/*	if (row==0)
	{
	    SetTimerEx("showVotes",800,0,"d",playerid);
		return 0;
	}*/
	new Menu:Current = GetPlayerMenu(playerid);
	if (Current == voteMenu)
	{
		new vmsg[256],pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
		format(vmsg,256,"* %s voted for %s",pname,gVoteItems[row]);
		SendClientMessageToAll(COLOR_TEMP,vmsg);
		gVotes[row]++;
		TogglePlayerControllable(playerid,1);
		return 1;
	} else if (Current == buildMenu[xRaceBuilding[playerid]-1])
	{
	    print("Doing something in buildmenu");
	    switch (xRaceBuilding[playerid])
	    {

		    case 1:
		    {
				switch (row)
				{
				    case 0: xWorldTime[playerid] = 0;
				    case 1: xWorldTime[playerid] = 3;
				    case 2: xWorldTime[playerid] = 6;
				    case 3: xWorldTime[playerid] = 9;
				    case 4: xWorldTime[playerid] = 12;
				    case 5: xWorldTime[playerid] = 15;
				    case 6: xWorldTime[playerid] = 18;
				    case 7: xWorldTime[playerid] = 21;
				}
		    }
		    case 2:
		    {
				switch (row)
				{
				    case 0: xWeatherID[playerid] = 0;
				    case 1: xWeatherID[playerid] = 10;
				    case 2: xWeatherID[playerid] = 12;
				    case 3: xWeatherID[playerid] = 16;
				    case 4: xWeatherID[playerid] = 16;
				    case 5: xWeatherID[playerid] = 19;
				}
		    }
		    case 3:
		    {
				switch (row)
				{
				    case 0: xTrackTime[playerid] = 60;
				    case 1: xTrackTime[playerid] = 120;
				    case 2: xTrackTime[playerid] = 180;
				    case 3: xTrackTime[playerid] = 240;
				    case 4: xTrackTime[playerid] = 300;
				    case 5: xTrackTime[playerid] = 360;
				    case 6: xTrackTime[playerid] = 480;
				    case 7: xTrackTime[playerid] = 600;
				    case 8: xTrackTime[playerid] = 900;
				}
		    }

		    case 4:
		    {
				switch (row)
				{
				    case 0: xRaceType[playerid] = 1;
				    case 1: xRaceType[playerid] = 2;
				}
		    }
		    case 5:
		    {
				switch (row)
				{
				    case 0: xCarIds[playerid][0] = 451;
				    case 1: xCarIds[playerid][0] = 565;
				    case 2: xCarIds[playerid][0] = 429;
				    case 3: xCarIds[playerid][0] = 415;
				    case 4: xCarIds[playerid][0] = 558;
				    case 5: xCarIds[playerid][0] = 522;
				    case 6: xCarIds[playerid][0] = 468;
				    case 7: xCarIds[playerid][0] = 513;
				    case 8: xCarIds[playerid][0] = 452;
				    case 9: xCarIds[playerid][0] = 0, print("More..");
				}
				if (xCarIds[playerid][0] > 0)
				{
				    SetPlayerVirtualWorld(playerid, playerid+100);
				    printf("playerVirtual: %d world:%d",playerid, playerid+100);
					newCar(playerid);
				}
		    }
		    case 6:
		    {
				switch (row)
				{
				    case 0: xCarIds[playerid][0] = 560;
				    case 1: xCarIds[playerid][0] = 506;
				    case 2: xCarIds[playerid][0] = 567;
				    case 3: xCarIds[playerid][0] = 424;
				    case 4: xCarIds[playerid][0] = 556;
				    case 5: xCarIds[playerid][0] = 541;
				    case 6: xCarIds[playerid][0] = 494;
				    case 7: xCarIds[playerid][0] = 571;
				    case 8: xCarIds[playerid][0] = 520;
				    case 9: xCarIds[playerid][0] = 0, print("More..");
				}
				if (xCarIds[playerid][0] > 0)
				{
				    SetPlayerVirtualWorld(playerid, playerid+100);
				    printf("playerVirtual: %d world:%d",playerid, playerid+100);
					newCar(playerid);
				}
		    }
	    }
	    
	    printf("DEBUG: xCarIds=%d xracebuilding=%d",xCarIds[playerid][0],xRaceBuilding[playerid]);
	    //HideMenuForPlayer(buildMenu[xRaceBuilding[playerid]-1],playerid);
		xRaceBuilding[playerid]++;
		printf("xRaceBuilding=%d",xRaceBuilding[playerid]);
		if (xCarIds[playerid][0]==0)
		{
		    switch (xRaceBuilding[playerid])
		    {
				case 7:
				{
				    xRaceBuilding[playerid]=xRaceBuilding[playerid]-2;
					ShowMenuForPlayer(buildMenu[xRaceBuilding[playerid]-1],playerid);
				}
		        default:
				{
					ShowMenuForPlayer(buildMenu[xRaceBuilding[playerid]-1],playerid);
				}
		    }
			
			print("Got here");
		}
		else {
		    SendClientMessage(playerid, COLOR_TEMP, "Please Set the Race Name! Eg /set RaceDemon");
			printf("SER RACE NAME; racebuilding %d; pworld:%d",xRaceBuilding[playerid], playerid+100);

		}
		return 1;
	}
	return 1;
}


public OnGameModeInit()
{
	SetGameModeText("Adrenaline (Racing)");
	AddPlayerClass(170,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(299,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(157,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(202,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(154,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(144,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(108,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(107,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(217,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(201,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(281,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(83,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(80,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(193,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(192,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(206,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(124,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(93,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(85,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(115,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(292,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(250,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(186,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(67,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(294,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(223,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(233,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(284,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(240,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(100,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(101,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(195,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(141,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(123,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(296,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(298,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(176,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(0,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(190,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(188,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(293,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(47,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(2,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(249,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(241,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(142,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(184,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(73,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(103,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(101,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(98,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(60,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(59,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(55,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //
	AddPlayerClass(285,1522.2528,-887.0850,61.1224,248.4600,0,0,0,0,0,0); //

	LoadRaceList(); 		//Opens up racenames.txt and reads off the racenames to be used
	LoadRace(gRaceNames[random(gRaces)]); 		//The first race is picked at random and loaded
	createTextDraws();		//Creates all the TextDraws for time, position
	createBuildMenus();     //Creates the menus for building races
	SetTimer("updateTime",1000,1);      //Sets a timer going to update the TextDraw for the displayed racetime
	for (new i=0;i<MAX_PLAYERS;i++)	gScores[i][0]=i;
	return 1;
}


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(IsKeyJustDown(KEY_FIRE,newkeys,oldkeys) && xRaceBuilding[playerid]>=1)//Has the player just pressed mouse1 when they are in buildmode?
	{
	    if(xPlayerProgress[playerid]==MAX_RACECHECKPOINTS)
	    {
	    		SendClientMessage(playerid,COLOR_TEMP,"Max Checkpoints Set!!");
	    		return;
	    }
		GetPlayerPos(playerid, xRaceCheckpoints[playerid][xPlayerProgress[playerid]][0],xRaceCheckpoints[playerid][xPlayerProgress[playerid]][1],xRaceCheckpoints[playerid][xPlayerProgress[playerid]][2]);
		SetPlayerRaceCheckpoint(playerid, 2, xRaceCheckpoints[playerid][xPlayerProgress[playerid]][0],xRaceCheckpoints[playerid][xPlayerProgress[playerid]][1],xRaceCheckpoints[playerid][xPlayerProgress[playerid]][2], xRaceCheckpoints[playerid][xPlayerProgress[playerid]][0],xRaceCheckpoints[playerid][xPlayerProgress[playerid]][1],xRaceCheckpoints[playerid][xPlayerProgress[playerid]][2],CHECK_SIZE);
	    switch (xPlayerProgress[playerid])
	    {
	        case 0:
	        {
				SendClientMessage(playerid,COLOR_TEMP,"[INFO] Starting point 1 Set! Now use FIRE to set Starting point for player2 (2nd Grid position)");
				new veh = GetPlayerVehicleID(playerid);
				GetVehicleZAngle(veh, xFacing[playerid]);
	        }
	        case 1:
	        {
	        	SendClientMessage(playerid,COLOR_TEMP,"[INFO] Starting point 2 Set! Now use FIRE to set the race checkpoints. Type /saverace when complete!");
	        }
	        default:
	        {
	            new msg[256];
	            format(msg,256,"[INFO] Checkpoint %d set! Type /saverace when finished",xPlayerProgress[playerid]-2);
				SendClientMessage(playerid,COLOR_TEMP,msg);
			}
		}
		xPlayerProgress[playerid]++;
		PlaySoundForPlayer(playerid, 1137);
		return;
	}
}

public OnGameModeExit()
{
	return 1;
}


public OnPlayerRequestClass(playerid, classid)
{
 	SetPlayerInterior(playerid,0);
	SetPlayerPos(playerid,2682.7673,-1680.1404,9.4193);
	SetPlayerFacingAngle(playerid, 352.2312);
	SetPlayerCameraPos(playerid,2683.1050,-1674.7749,9.4287);
	SetPlayerCameraLookAt(playerid,2682.0964,-1691.6710,9.4207);
	PlaySoundForPlayer(playerid, 1097);

	return 1;
}

public OnPlayerSpawn(playerid)
{
	if (gTrackTime>10)
	{
		GridSetupPlayer(playerid);
		SetTimerEx("GridSetup", TIME_GIVE_CAR,0,"d", playerid);
	}
	else SendClientMessage(playerid,COLOR_TEMP,"The track is changing, please wait..");
	PlaySoundForPlayer(playerid, 1186);
    spawned[playerid]=1;
    //SetPlayerVirtualWorld(playerid,0);
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	if (xRaceBuilding[playerid]>=1) return 1;
	new State = GetPlayerState(playerid);
	if(State != PLAYER_STATE_DRIVER) //Players need to be in a car and be the driver to progress to the next cp
	{
	    return 1;
	}

	if (gPlayerProgress[playerid]==gMaxCheckpoints-1) //If the player has finished...
	{
		gFinished++;

		if (gFinished == gTotalRacers && gTrackTime>35) gTrackTime=35;
	    new finishmsg[256],pname[MAX_PLAYER_NAME],append[3];
		GetPlayerName(playerid,pname,MAX_PLAYER_NAME);

		new Time, timestamp;
		timestamp = GetTickCount();
		Time = timestamp - gRaceStart;

		new Minutes, Seconds, MSeconds, sMSeconds[5],sSeconds[5];
		timeconvert(Time, Minutes, Seconds, MSeconds);

		if (Seconds < 10)format(sSeconds, sizeof(sSeconds), "0%d", Seconds);
		else format(sSeconds, sizeof(sSeconds), "%d", Seconds);
		if (MSeconds < 100)format(sMSeconds, sizeof(sMSeconds), "0%d", MSeconds);
		else format(sMSeconds, sizeof(sMSeconds), "%d", MSeconds);


	    gFinishOrder++;
	    if (gFinishOrder == 1) GivePlayerMoney(playerid,1);//Credit $1 for every win - AndrsOG
		switch (gFinishOrder)
		{
			case 1,21,31,41,51,61,71,81,91:	format(append, sizeof(append), "st");
			case 2,22,32,42,52,62,72,82,92:	format(append, sizeof(append), "nd");
			case 3,23,33,43,53,63,73,83,93: format(append, sizeof(append), "rd");
			default: format(append, sizeof(append), "th");
		}
		new prize;
		switch (gFinishOrder)
		{
			case 1: prize=10;
			case 2:	prize=8;
			case 3:	prize=6;
			case 4:	prize=4;
			case 5:	prize=3;
  			case 6:	prize=2;
			default: prize=1;
		}
		SetPlayerScore(playerid, GetPlayerScore(playerid)+prize);
		gScores[playerid][1]+=prize;

		format(finishmsg, sizeof(finishmsg),"-> %s finished %d%s in %d:%s.%s", pname,gFinishOrder, append, Minutes, sSeconds, sMSeconds);
		SendClientMessageToAll(COLOR_TEMP,finishmsg);
	    DisablePlayerRaceCheckpoint(playerid);
	    PlaySoundForPlayer(playerid, 1183);
		if (GetPlayerMenu(playerid) != buildMenu[playerid])
		if (gTrackTime>3)showVoteTimer[playerid] = SetTimerEx("showVote", TIME_SHOW_VOTE, 0, "d",playerid);
		CheckAgainstHighScore(playerid, Time);

	} else {    //If they havent finished, set next checkpoint+more
		gPlayerProgress[playerid]++;        //Increase the players progress in the race
		RaceCheckpoints[gPlayerProgress[playerid]][3]++;
		gRacePosition[playerid]=floatround(RaceCheckpoints[gPlayerProgress[playerid]][3],floatround_floor);
		SetRaceText(playerid, gRacePosition[playerid]); //Set the race textdraws
		SetCheckpoint(playerid,gPlayerProgress[playerid],gMaxCheckpoints);  //Sets the next checkpoint in the race
		PlaySoundForPlayer(playerid, 1137);
	}
	return 1;
}




public OnVehicleSpawn(vehicleid)
{
	//Tried many ways to get rid of cars, found this was the least crashy (but still might be causing crashes)
	//If they car is spawning for the first time, nothing happends, if the car spawns for a second time (a respawn) it is destroyed.
	gVehDestroyTracker[vehicleid]++;
	if (gVehDestroyTracker[vehicleid]==1)
	{
		DestroyVehicle(vehicleid);
		gVehDestroyTracker[vehicleid]=0;
	}
}

//////////////////////////////////////////////////
//// x.x SA-MP FUNCTIONS (END) ///////////////////
//////////////////////////////////////////////////




//////////////////////////////////////////////////
//// x.x TEXTDRAW FUNCTIONS (START) //////////////
//////////////////////////////////////////////////
public updateTime()
{

	new Time, timestamp;
	timestamp = GetTickCount();
	if (gRaceStart != 0)
		Time = timestamp - gRaceStart;
	else
		Time=0;

	new MSeconds;
	timeconvert(Time, gMinutes, gSeconds, MSeconds);
	gindex=0;
	while (gSeconds > 9)
	{
		gSeconds-=10;
		gindex++;
	}
	new tmp[10];
	format(tmp,10,"%d:%d%d",gMinutes,gindex,gSeconds);
	TextDrawSetString(Ttime, tmp);


}

createTextDraws()
{
	Ttime = TextDrawCreate(563.0, 376.0, "0");
	TextDrawLetterSize(Ttime, 0.6, 3);
	Ttotalracers = TextDrawCreate(590.0, 355.0, "/0");
	TextDrawLetterSize(Ttotalracers, 0.5, 2.5);
}

//////////////////////////////////////////////////
//// x.x TEXTDRAW FUNCTIONS (END) ////////////////
//////////////////////////////////////////////////


//////////////////////////////////////////////////
//// x.x COMMANDS (START) ////////////////////////
//////////////////////////////////////////////////


public OnPlayerCommandText(playerid, cmdtext[])
{
	dcmd(saverace,8,cmdtext);
	dcmd(set,3,cmdtext);
	dcmd(buildmode,9,cmdtext);
	dcmd(kill,4,cmdtext);
	dcmd(newcar,6,cmdtext);
	dcmd(nc,2,cmdtext);
	dcmd(rescueme,8,cmdtext);
	dcmd(stopsound,9,cmdtext);
	dcmd(moretime,8,cmdtext);
	dcmd(ss,2,cmdtext);
	dcmd(record,7,cmdtext);
	dcmd(top5,4,cmdtext);
	dcmd(track,5,cmdtext);
	dcmd(pause,5,cmdtext);
	dcmd(unpause,7,cmdtext);
	dcmd(addtorotation,13,cmdtext);
	dcmd(help,4,cmdtext);
	dcmd(buildhelp,9,cmdtext);
	return 0;
}

dcmd_track(playerid, params[])  //Admin command to force a change to the specified track Usage: /track TRACKNAME
{
    if(!IsPlayerAdmin(playerid))
	{
		SendClientMessage(playerid,COLOR_TEMP,"[ERROR] Sorry, only admins can change the current track");
		return 1;
	}
    if  (gTrackTime<=10)
    {
		SendClientMessage(playerid,COLOR_TEMP,"Sorry too late, the track change is in motion");
		return 1;
	}
	new trackname[256];
	if (!sscanf(params, "s", trackname)) SendClientMessage(playerid, COLOR_TEMP, "Usage: /track [trackname]");
    new tmp[256],msg[256];
    format(tmp,256,"%s.race",trackname);
	if(!fexist(tmp))
	{
	    SendClientMessage(playerid, COLOR_TEMP,"404: Track does not exist");
	    return 1;
	}
	format(msg,256,"An Admin is changing the track to: %s",trackname);
	printf("Changing track to %s",trackname);
	SendClientMessageToAll(COLOR_TEMP,msg);
	gTrackTime=7;
	gNextTrack = trackname;
	#pragma unused playerid
    return 1;
}

dcmd_addtorotation(playerid, params[]) //Admin command to add a user-made track to the rotation list Usage: /addtorotation TRACKNAME
{
	if(!IsPlayerAdmin(playerid))
	{
		SendClientMessage(playerid,COLOR_TEMP,"[ERROR] Sorry, only admins can save races to the tracklist");
		return 1;
	}
	new trackname[128];
	if (!sscanf(params, "s", trackname)) SendClientMessage(playerid, COLOR_TEMP, "[ERROR] Usage: /track [trackname]");
    new tmp[256];
    format(tmp,256,"%s.race",trackname);
	if(!fexist(tmp))
	{
	    SendClientMessage(playerid, COLOR_TEMP,"[ERROR] 404: Track does not exist");
	    return 1;
	}
	
	new File:f;
	if(fexist("racenames.txt"))
	{
	    new msg[256];
		f = fopen("racenames.txt", io_append);
		format(tmp,256,"\n%s",trackname);
		fwrite(f,tmp);
		fclose(f);
		format(msg,256,"[SUCCESS] Added %s into rotation",trackname);
		SendClientMessage(playerid,COLOR_TEMP,msg);
	}
	
    return 1;
}

dcmd_stopsound(playerid, const params[]) //Stops the annoying music
{
	PlaySoundForPlayer(playerid, 1186);
	#pragma unused params
	return 1;
}

dcmd_ss(playerid, const params[]) //Shortcut for stopping the annoying music
{
	PlaySoundForPlayer(playerid, 1186);
	#pragma unused params
	return 1;
}
dcmd_moretime(playerid, const params[])//Admin command to add 35 seconds onto the current track time
{
	if(!IsPlayerAdmin(playerid))
	{
		SendClientMessage(playerid,COLOR_TEMP,"[ERROR] Sorry, only admins add more time to the race");
		return 1;
	}
    #pragma unused params
    #pragma unused playerid
	gTrackTime+=35;
	return 1;
}
dcmd_top5(playerid, const params[]) //Shows the top5 times for the current track
{
    #pragma unused params
	ReadHighScoreList(gTrackName, 1, playerid, 0);
	return 1;
}
dcmd_record(playerid, const params[])
{
    #pragma unused params
	if (strlen(gBestTime) > 0) SendClientMessage(playerid, COLOR_TEMP, gBestTime);
 	return 1;
}

dcmd_rescueme(playerid, const params[]) //Returns you to the start of the race
{
    #pragma unused params
	new State = GetPlayerState(playerid);
	SendClientMessage(playerid, COLOR_TEMP, "Sending you to the start.");
	if (State!=1)
	{
		RemovePlayerFromVehicle(playerid);
		SetTimerEx("GridSetup",TIME_GIVE_CAR*2,0,"d",playerid);
		SetTimerEx("GridSetupPlayer", TIME_MOVE_PLAYER,0,"d", playerid);
	} else if (State==1) {
		GridSetupPlayer(playerid);
		SetTimerEx("GridSetup", TIME_GIVE_CAR,0,"d", playerid);
	}
	/*while (gPlayerProgress[playerid]>=0)
	{
		RaceCheckpoints[gPlayerProgress[playerid]][3]--;
		gPlayerProgress[playerid]--;
	}*/

 	return 1;
}

dcmd_pause(playerid, const params[])  //Admin command to pause the countdown to the next track (note: does not stop players, simply use if you need to extend the time for the track)
{
	if(!IsPlayerAdmin(playerid))
	{
		SendClientMessage(playerid,COLOR_TEMP,"[ERROR] Sorry, only admins can pause/unpause races");
		return 1;
	}
    #pragma unused params
	KillTimer(gEndRacetimer);
	SendClientMessageToAll(COLOR_TEMP,"[INFO] An admin has paused the current track!");
	SendClientMessage(playerid,COLOR_TEMP,"[INFO] The track has been paused, to resume type /unpause");
 	return 1;
}
dcmd_unpause(playerid, const params[])
{
	if(!IsPlayerAdmin(playerid))
	{
		SendClientMessage(playerid,COLOR_TEMP,"[ERROR] Sorry, only admins can pause/unpause races");
		return 1;
	}
    #pragma unused params
 	KillTimer(gEndRacetimer);
	gEndRacetimer = SetTimer("nextRaceCountdown",1000,1);
	SendClientMessageToAll(COLOR_TEMP,"[INFO] An admin has unpaused the current track!");
	SendClientMessage(playerid,COLOR_TEMP,"[INFO] The track has been unpaused");
 	return 1;
}
dcmd_newcar(playerid, const params[]) //Gives the player a replacement car
{
    #pragma unused params
    if (xRaceBuilding[playerid]==0 && newcar[playerid]==SPARE_CARS)
    {
        SendClientMessage(playerid, COLOR_TEMP, "[ERROR] You have already used up your space vehicles for this race");
        return 1;
    }
	newCar(playerid);
	if (xRaceBuilding[playerid]==0)
	{
		new msg[256];
		format(msg,256,"[INFO] Giving you your spare car. You are only allowed %d spare vehicle(s) per race.",SPARE_CARS);
		SendClientMessage(playerid, COLOR_TEMP, msg);
		newcar[playerid]++;
	}
 	return 1;
}
dcmd_nc(playerid, const params[]) //Gives the player a replacement car
{
    #pragma unused params
    if (xRaceBuilding[playerid]==0 && newcar[playerid]==SPARE_CARS)
    {
        SendClientMessage(playerid, COLOR_TEMP, "[ERROR] You have already used up your space vehicles for this race");
        return 1;
    }
	newCar(playerid);
	if (xRaceBuilding[playerid]==0)
	{
		new msg[256];
		format(msg,256,"[INFO] Giving you your spare car. You are only allowed %d spare vehicle(s) per race.",SPARE_CARS);
		SendClientMessage(playerid, COLOR_TEMP, msg);
		newcar[playerid]++;
	}
 	return 1;
}
dcmd_kill(playerid, const params[]) //Use to kill yourself
{
    #pragma unused params
	SetPlayerHealth(playerid,0.0);
 	return 1;
}
	
dcmd_help(playerid, const params[])
{
    #pragma unused params
    SendClientMessage(playerid,COLOR_TEMP,"Availible Commands: '/newcar' '/rescueme' '/buildmode on' '/buildmode off'");
	if(IsPlayerAdmin(playerid))SendClientMessage(playerid,COLOR_TEMP,"Availible Admin Commands: '/pause' '/resume' '/track [racename]' '/addmodetorotation [racename]'");
 	return 1;
}
dcmd_buildhelp(playerid, const params[])
{
    #pragma unused params
	SendClientMessage(playerid,COLOR_TEMP,"Availible Commands: '/buildmode on' '/buildmode off' '/set [racename]' '/newcar'");
 	return 1;
}


dcmd_buildmode(playerid, params[])
{
	new var1[256];
    if (!sscanf(params, "s", var1))
	{
		SendClientMessage(playerid, COLOR_TEMP, "Usage: /buildmode [on/off]");
		return 1;
	}
	if (strcmp(var1, "on", true)==0)
	{
		xRaceBuilding[playerid]=1;
		RemovePlayerFromVehicle(playerid);
		xPlayerProgress[playerid]=0;
		AllowPlayerTeleport(playerid,true);
		//SetPlayerVirtualWorld(playerid,playerid+1);

		xWorldTime[playerid]=0;
		xTrackTime[playerid]=0;
		xWeatherID[playerid]=0;
		xRaceType[playerid]=0;
		xCarIds[playerid][0]=0;

		SendClientMessage(playerid,COLOR_TEMP,"Entered Build Mode!");
		gPlayerProgress[playerid]=0;

		DisablePlayerRaceCheckpoint(playerid);
		TogglePlayerControllable(playerid, 0);
		xCarIds[playerid][0]=0;
		ShowMenuForPlayer(buildMenu[0],playerid);

		GetPlayerName(playerid, xCreatorName[playerid],MAX_PLAYER_NAME);
		for (new i;i< MAX_RACECHECKPOINTS;i++)
		{
			xRaceCheckpoints[playerid][i][0]=0;
			xRaceCheckpoints[playerid][i][1]=0;
			xRaceCheckpoints[playerid][i][2]=0;
			xRaceCheckpoints[playerid][i][3]=0;
		}
	}
	if (strcmp(var1, "off", true)==0)
	{
		xRaceBuilding[playerid]=0;
		SendClientMessage(playerid,COLOR_TEMP,"Exited Build Mode!");
		TogglePlayerControllable(playerid,1);
		AllowPlayerTeleport(playerid,false);
	    RemovePlayerFromVehicle(playerid);
	    SetPlayerVirtualWorld(playerid,gWorldID);
		SetTimerEx("GridSetup",TIME_GIVE_CAR*2,0,"d",playerid);
		SetTimerEx("GridSetupPlayer", TIME_MOVE_PLAYER,0,"d", playerid);
		DisablePlayerRaceCheckpoint(playerid);
		SetCheckpoint(playerid,gPlayerProgress[playerid],gMaxCheckpoints);
		xCarIds[playerid][0]=0;

		
	}
 	return 1;
}


dcmd_set(playerid, params[])
{
    
	if (xRaceBuilding[playerid]>0)
	{

	        if (!sscanf(params, "s", xRaceName[playerid])) SendClientMessage(playerid, COLOR_TEMP, "[ERROR] Usage: /set [value]");
	        //modename
			new trackname[256];
			format(trackname,256,"%s.race",xRaceName[playerid]);
			if (fexist(trackname))
			{
				SendClientMessage(playerid,COLOR_TEMP,"[ERROR] This track already exists! please pick another.");
				return 1;
			} else if (CheckSafeInput(xRaceName[playerid])==0)
			{
				SendClientMessage(playerid,COLOR_TEMP,"[ERROR] Error: Allowed characters a-z,A-Z,-,_,0-9");
				return 1;
			}
			xRaceBuilding[playerid]++;
			new msg[256];
			format(msg,256,"Modename set to: %s",xRaceName[playerid]);
			SendClientMessage(playerid,COLOR_TEMP,msg);
			TogglePlayerControllable(playerid,1);
			SendClientMessage(playerid,COLOR_TEMP,"[INFO] Use FIRE to set a starting point for player 1 (1st Grid position)");
	}
 	return 1;
}

dcmd_saverace(playerid, const params[])
{
    #pragma unused params
	if(xRaceBuilding[playerid]>0 && xPlayerProgress[playerid]>3)
	{
		if (xCarIds[playerid][0]<300)xCarIds[playerid][0]=565;
		SaveRace(playerid);
		xRaceBuilding[playerid]=0;
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		SendClientMessage(playerid,COLOR_TEMP,"Exited Build Mode!");
		new State = GetPlayerState(playerid);
		if (State>1) RemovePlayerFromVehicle(playerid);
	    SetPlayerVirtualWorld(playerid,gWorldID);
		DisablePlayerRaceCheckpoint(playerid);
		SetTimerEx("GridSetup",TIME_GIVE_CAR*2,0,"d",playerid);
		SetTimerEx("GridSetupPlayer", TIME_MOVE_PLAYER,0,"d", playerid);
		TogglePlayerControllable(playerid,1);
		new msg[256],pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,MAX_PLAYER_NAME);
		format (msg,256,"%s has created race: %s",pname,xRaceName[playerid]);
		SendClientMessageToAll(COLOR_TEMP,msg);
		xCarIds[playerid][0]=0;
	} else {
	    SendClientMessage(playerid,COLOR_TEMP,"[ERROR] Not enough information set!");
	}
 	return 1;
}
//////////////////////////////////////////////////
//// x.x COMMANDS (END) //////////////////////////
//////////////////////////////////////////////////






//////////////////////////////////////////////////
//// x.x CUSTOM FUNCTIONS (START) ////////////////
//////////////////////////////////////////////////
IsKeyJustDown(key, newkeys, oldkeys)
{
	if((newkeys & key) && !(oldkeys & key)) return 1;
	return 0;
}

newCar(playerid)
{
	new State = GetPlayerState(playerid);
	if (State>1) RemovePlayerFromVehicle(playerid);
    if (xRaceBuilding[playerid]<5 && State>1 )SetTimerEx("giveCar",6000,0,"ddd",playerid, gCarModelID,0);
    else if (xRaceBuilding[playerid]<5 && State==1)giveCar(playerid, gCarModelID, 0);
	else if (xCarIds[playerid][0]>300 && State>1)SetTimerEx("giveCar",6000,0,"ddd",playerid, xCarIds[playerid][0],playerid+1);
	else if (xCarIds[playerid][0]>300 && State==1)giveCar(playerid, xCarIds[playerid][0], playerid+1);
 	return 1;

}

public respawnCar(veh)
{
	SetVehicleToRespawn(veh);
}
public giveCar(playerid, modelid, world)
{
	new Float:pos[4];
	GetPlayerPos(playerid, pos[0],pos[1],pos[2]);
	GetPlayerFacingAngle(playerid,pos[3]);
	new State = GetPlayerState(playerid);
	if (State>1)
	{
        RemovePlayerFromVehicle(playerid);
	    gGiveCarTimer[playerid] = SetTimerEx("giveCar",TIME_GIVE_CAR,0,"dd",playerid, modelid);
	} else {

		//vehicles[playerid] =
		new temp = CreateVehicle(modelid,pos[0],pos[1],pos[2],pos[3],-1,-1,10);
		printf("racebuilding %d; pworld:%d",xRaceBuilding[playerid], playerid+100);
		if (xRaceBuilding[playerid]<5)
		{
			SetVehicleVirtualWorld(temp, gWorldID);
		} else {
			SetVehicleVirtualWorld(temp, playerid+100);
			printf("VehicleVirtual: %d world:%d",temp, playerid+100);
		}
		SetTimerEx("PutPlayerInVehicleTimed",TIME_PUT_PLAYER,0,"ddd",playerid, temp,0);
		SetCameraBehindPlayer(playerid);
	}
	return;
	
}

public DestroyAllVehicles()
{
	for(new i=0;i<5;i++)
	{
		destroyCarSafe(i);
	}
}

public destroyCarSafe(veh)
{
	if(veh == -1) return 1;
	for(new i;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerInVehicle(i,veh))
		{
			RemovePlayerFromVehicle(i);
			SetTimerEx("destroyCarSafe",2000,0,"d",veh);
			return 0;
		}
	}
	DestroyVehicle(veh);
	return 1;
}



main()
{
	print("\n----------------------------------");
	print(" Adrenaline 1.06 coded by switch");
	print("----------------------------------\n");
}




CheckSafeInput(input[])//CREDIT: Based off Simon's ConvertToSafeInput
{
	new len = strlen(input), idx = 0;
	while (idx < len)
	{
	    if (!((input[idx] >= 48  && input[idx] <= 57) || (input[idx] >= 65 && input[idx] <= 90)  || (input[idx] >= 97 && input[idx] <= 122)|| input[idx] == 45 || input[idx] == 95|| input[idx] == 91 || input[idx] == 93))
	    {
           return 0;
	    }
	    else idx++;
	}
	return 1;
}

createVote()
{
    for (new i;i<4;i++) gVoteItems[i] = "RESET";
	DestroyMenu(voteMenu);
	voteMenu = CreateMenu("Vote",1, 50.0, 200.0, 120.0, 250.0);
	print("Creating Votemenu");
	for (new i=0;i<4;i++)
	{
	    randomRaceName(i,gRaces);
		AddMenuItem(voteMenu,0,gVoteItems[i]);
		printf("VoteOption%d: %s",i,gVoteItems[i]);
	}
	for (new i=0;i<4;i++)gVotes[i]=0;

}


randomRaceName(index,num)
{
	new length = sizeof(gRaceNames);
	length--;
	new rand = random(num);
	for(new i;i<4;i++)
	{
		if (strcmp(gRaceNames[rand], gVoteItems[i], true)==0)
		{
			randomRaceName(index,num);
			return 1;
		}
	}
	gVoteItems[index] = gRaceNames[rand];
	return 1;
}
/*

randomRaceName(array[],num)
{
	new length = strlen(array);
	new rand = random(num);
	for(new i;i<length;i++)
	{
		if (strcmp(array[rand], array[i], true)==0)
		{
			randomRaceName(array[],num);
			return 1;
		}
	}
	return array[rand];
}
*/

createBuildMenus()
{

	buildMenu[0] = CreateMenu("World Time",1, 200.0, 125.0, 220.0, 50.0);
	SetMenuColumnHeader(buildMenu[0], 0, "Select The Time");
	AddMenuItem(buildMenu[0],0,"0:00");
	AddMenuItem(buildMenu[0],0,"3:00");
	AddMenuItem(buildMenu[0],0,"6:00");
	AddMenuItem(buildMenu[0],0,"9:00");
	AddMenuItem(buildMenu[0],0,"12:00");
	AddMenuItem(buildMenu[0],0,"15:00");
	AddMenuItem(buildMenu[0],0,"18:00");
	AddMenuItem(buildMenu[0],0,"21:00");

	buildMenu[1] = CreateMenu("Weather",1, 200.0, 125.0, 220.0, 50.0);
	SetMenuColumnHeader(buildMenu[1], 0, "Select the Weather");
	AddMenuItem(buildMenu[1],0,"Normal");
	AddMenuItem(buildMenu[1],0,"Sunny");
	AddMenuItem(buildMenu[1],0,"Grey");
	AddMenuItem(buildMenu[1],0,"Rainy");
	AddMenuItem(buildMenu[1],0,"Storm");
	AddMenuItem(buildMenu[1],0,"Foggy");

	buildMenu[2] = CreateMenu("TrackTime",1, 200.0, 125.0, 220.0, 50.0);
	SetMenuColumnHeader(buildMenu[2], 0, "Select the Track Time");
	AddMenuItem(buildMenu[2],0,"1 minute");
	AddMenuItem(buildMenu[2],0,"2 minutes");
	AddMenuItem(buildMenu[2],0,"3 minutes");
	AddMenuItem(buildMenu[2],0,"4 minutes");
	AddMenuItem(buildMenu[2],0,"5 minutes");
	AddMenuItem(buildMenu[2],0,"6 minutes");
	AddMenuItem(buildMenu[2],0,"8 minutes");
	AddMenuItem(buildMenu[2],0,"10 minutes");
	AddMenuItem(buildMenu[2],0,"15 minutes");

	buildMenu[3] = CreateMenu("RaceType",1, 200.0, 125.0, 220.0, 50.0);
	SetMenuColumnHeader(buildMenu[3], 0, "Select the type of race");
	AddMenuItem(buildMenu[3],0,"Normal");
	AddMenuItem(buildMenu[3],0,"Flying");

	buildMenu[4] = CreateMenu("Vehicle",1, 200.0, 125.0, 220.0, 50.0);
	SetMenuColumnHeader(buildMenu[4], 0, "Select the Vehicle");
	AddMenuItem(buildMenu[4],0,"Turismo");
	AddMenuItem(buildMenu[4],0,"Flash");
	AddMenuItem(buildMenu[4],0,"Banshee");
	AddMenuItem(buildMenu[4],0,"Cheetah");
	AddMenuItem(buildMenu[4],0,"Uranus");
	AddMenuItem(buildMenu[4],0,"NRG 500");
	AddMenuItem(buildMenu[4],0,"Sanchez");
	AddMenuItem(buildMenu[4],0,"Stunt Plane");
	AddMenuItem(buildMenu[4],0,"Speeder (Boat)");
	AddMenuItem(buildMenu[4],0,"More...");

	buildMenu[5] = CreateMenu("Vehicle2",1, 200.0, 125.0, 220.0, 50.0);
	SetMenuColumnHeader(buildMenu[5], 0, "Select the Vehicle");
	AddMenuItem(buildMenu[5],0,"Sultan");
	AddMenuItem(buildMenu[5],0,"SuperGT");
	AddMenuItem(buildMenu[5],0,"Savanna");
	AddMenuItem(buildMenu[5],0,"BF Injection");
	AddMenuItem(buildMenu[5],0,"Monster");
	AddMenuItem(buildMenu[5],0,"Bullet");
	AddMenuItem(buildMenu[5],0,"Hotring");
	AddMenuItem(buildMenu[5],0,"Kart");
	AddMenuItem(buildMenu[5],0,"Hydra");//520
	AddMenuItem(buildMenu[5],0,"Back...");//back
}

public showVote(playerid)
{
		TogglePlayerControllable(playerid,0);
		if (racecount+1 != RACES_TILL_MODECHANGE) ShowMenuForPlayer(voteMenu,playerid);
}
public countVotes()
{
	new votes, equalvotes[4],equal, index=-1, vmsg[156];
	for (new i=0;i<4;i++)
	{
		if(gVotes[i]>votes)
		{
			votes=gVotes[i];
			index=i;
			equal=0;
			equalvotes[equal]=i;
		} else if (gVotes[i]==votes && votes!=0)
		{
		    equal++;
		    equalvotes[equal]=i;

		}
		
	}

	if (votes>0)
	{
 		new rand = random(equal+1);
		gNextTrack = gVoteItems[equalvotes[rand]];
		gTrackTime=7;
		format(vmsg,156,"Voting over! %s wins with %d votes. Changing in 10 seconds...",gVoteItems[equalvotes[rand]],gVotes[index]);
		SendClientMessageToAll(COLOR_TEMP, vmsg);
	} else {
	    new rand;
	    rand=random(4);
	    gNextTrack = gVoteItems[rand];
		format(vmsg,156,"Voting over! No votes were made, randomly selected %s. Changing in 10 seconds...",gVoteItems[rand]);
		SendClientMessageToAll(COLOR_TEMP, vmsg);
	}

}


public RemovePlayersFromVehicles()
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    new State = GetPlayerState(i);
		if (xRaceBuilding[i]==0 && State>1)
		{
			RemovePlayerFromVehicle(i);
			new veh = GetPlayerVehicleID(i);
			for(new j=0;j<MAX_PLAYERS;j++)
			{
				SetVehicleParamsForPlayer(veh, j, 0, 1);
			}
		}
	}
}

public changetrack()
{
	printf("Changing Track:%s",gNextTrack);
	if(LoadRace(gNextTrack))
	{
		gGridIndex=0;
		gGrid2Index=0;
		for (new i=0;i<MAX_PLAYERS;i++)
		{
			gScores2[i][0]=gScores[i][0];
			gScores2[i][1]=gScores[i][1];
			gGrided[i]=0;
			newcar[i]=0;
		}
		quickSort(200);
		if(gWorldID==100) gWorldID=1;
		else gWorldID++;
		//CreateVehicles(200);
		AddPlayersToRace(200);
		SetTimerEx("AddRacers",TIME_GIVE_CAR,0,"d", 200);

	}

}

AddPlayersToRace(num)
{
	new pos;
	new Float:distance;
	gGrid2Count=0;
	for(new i=num-1;i>-1;i--)
	{
		new j = gScores2[i][0];
		if(IsPlayerConnected(j) && gGrided[j]==0 && xRaceBuilding[j]==0 && spawned[j]==1)
		{
			if (gGrid2Count>1)
			{
				distance=10.0;
				switch (gGrid2Index)
				{
				    case 0:
				    {
						gGrid2[0] -= (distance * floatsin(-gGrid2[3], degrees));
						gGrid2[1] -= (distance * floatcos(-gGrid2[3], degrees));
						SetPlayerVirtualWorld(j, gWorldID);
						SetPlayerPos(j,gGrid2[0]+2.0,gGrid2[1],gGrid2[2]+2.0);
						gGrid2Index=1;

				    }
				    case 1:
				    {
						gGrid2[4] -= (distance * floatsin(-gGrid2[7], degrees));
						gGrid2[5] -= (distance * floatcos(-gGrid2[7], degrees));
						SetPlayerVirtualWorld(j, gWorldID);
						SetPlayerPos(j,gGrid2[4]+2.0,gGrid2[5],gGrid2[6]+2.0);
						gGrid2Index=0;
				    }
				}
			} else {
				distance=10.0;
				switch (gGrid2Index)
				{
				    case 0:
				    {
				        SetPlayerVirtualWorld(j, gWorldID);
						SetPlayerPos(j,gGrid2[0]+2.0,gGrid2[1],gGrid2[2]+2.0);
						gGrid2Index=1;

				    }
				    case 1:
				    {
				        SetPlayerVirtualWorld(j, gWorldID);
						SetPlayerPos(j,gGrid2[4]+2.0,gGrid2[5],gGrid2[6]+2.0);
						gGrid2Index=0;
				    }
				}
			}
			gGrid2Count++;
			pos++;
			//TogglePlayerControllable(j,0);
		}
	}
}

public AddRacers(num)
{
	new pos;
	new Float:distance;
	gGridCount=0;
	for(new i=num-1;i>-1;i--)
	{
		new j = gScores2[i][0];
		if(IsPlayerConnected(j) && gGrided[j]==0 && xRaceBuilding[j]==0 && spawned[j]==1)
		{
			if (gGridCount>1)
			{
				distance=10.0;
				switch (gGridIndex)
				{
				    case 0:
				    {
						gGrid[0] -= (distance * floatsin(-gGrid[3], degrees));
						gGrid[1] -= (distance * floatcos(-gGrid[3], degrees));
						vehicles[gGridCount] = CreateVehicle(gCarModelID,gGrid[0],gGrid[1],gGrid[2],gGrid[3],-1,-1,10);
						SetVehicleVirtualWorld(vehicles[gGridCount],gWorldID);
						printf("Created car, Count:%d",gGridCount);
						//SetPlayerPos(j,gGrid[0],gGrid[1],gGrid[2]+5.0);
						gGridIndex=1;

				    }
				    case 1:
				    {
						gGrid[4] -= (distance * floatsin(-gGrid[7], degrees));
						gGrid[5] -= (distance * floatcos(-gGrid[7], degrees));
						vehicles[gGridCount] = CreateVehicle(gCarModelID,gGrid[4],gGrid[5],gGrid[6],gGrid[7],-1,-1,10);
						SetVehicleVirtualWorld(vehicles[gGridCount],gWorldID);
						printf("Created car, Count:%d",gGridCount);
						//SetPlayerPos(j,gGrid[4],gGrid[5],gGrid[6]+5.0);
						gGridIndex=0;
				    }
				}
			} else {
				distance=10.0;
				switch (gGridIndex)
				{
				    case 0:
				    {
						vehicles[gGridCount] = CreateVehicle(gCarModelID,gGrid[0],gGrid[1],gGrid[2],gGrid[3],-1,-1,10);
						SetVehicleVirtualWorld(vehicles[gGridCount],gWorldID);
						printf("Created car, Count:%d",gGridCount);
						//SetPlayerPos(j,gGrid[0],gGrid[1],gGrid[2]+5.0);
						gGridIndex=1;

				    }
				    case 1:
				    {
						vehicles[gGridCount] = CreateVehicle(gCarModelID,gGrid[4],gGrid[5],gGrid[6],gGrid[7],-1,-1,10);
						SetVehicleVirtualWorld(vehicles[gGridCount],gWorldID);
						printf("Created car, Count:%d",gGridCount);
						//SetPlayerPos(j,gGrid[4],gGrid[5],gGrid[6]+5.0);
						gGridIndex=0;
				    }
				}
			}
			gGridCount++;
			SetRaceText(j,pos+1);
			SetTimerEx("PutPlayerInVehicleTimed",TIME_PUT_PLAYER,0,"ddd",j, vehicles[pos],0);
			printf("Putting player %d into carid %d in 3 secs..",j,pos);
			SetCheckpoint(j,gPlayerProgress[j],gMaxCheckpoints);
			gGrided[j]=1;
			pos++;
		}
	}
}

SetRaceText(playerid, pos)
{

	//HideAllRaceText(playerid);
	new append[5];
	switch (pos)
	{
		case 1,21,31,41,51,61,71,81,91:	format(append, sizeof(append), "ST");
		case 2,22,32,42,52,62,72,82,92:	format(append, sizeof(append), "ND");
		case 3,23,33,43,53,63,73,83,93: format(append, sizeof(append), "RD");
		default: format(append, sizeof(append), "TH");
	}
	new tmp[5];
	format(tmp,5,"%d", pos);
	TextDrawSetString(Tposition[playerid],tmp);
	TextDrawSetString(Tappend[playerid],append);

	return 1;
}


public GridSetupPlayer(playerid)
{	//Staggered Grid Modified from Y_Less's GetXYInFrontOfPlayer() function

	new State = GetPlayerState(playerid);
	if (State>1)
	{
	    printf("Aborting Grid setup for player:%d Reason: Was in vehicle/alt tabbed/dead",playerid);
	    SendClientMessage(playerid,COLOR_TEMP,"[ERROR] Anti-crash stopped you from being gridded. Type /rescueme to rejoin the race");
	    //Kick(playerid);
	    return 1;
	}

	new Float:distance;
	
	if (gGrid2Count>1)
	{
		distance=10.0;
		switch (gGrid2Index)
		{
		    case 0:
		    {
				gGrid2[0] -= (distance * floatsin(-gGrid2[3], degrees));
				gGrid2[1] -= (distance * floatcos(-gGrid2[3], degrees));

		    }
		    case 1:
		    {
				gGrid2[4] -= (distance * floatsin(-gGrid2[7], degrees));
				gGrid2[5] -= (distance * floatcos(-gGrid2[7], degrees));
		    }
		}
	}

	switch (gGrid2Index)
	{
	    case 0:
	    {
	        SetPlayerVirtualWorld(playerid, gWorldID);
			SetPlayerPos(playerid,gGrid2[0],gGrid2[1],gGrid2[2]+1.0);
			//vehicles[gGridCount] = CreateVehicle(gCarModelID,gGrid[0],gGrid[1],gGrid[2],gGrid[3],-1,-1,10);
			//SetVehiclePos(vehicles[playerid],gGrid[0],gGrid[1],gGrid[2]);
			//SetVehicleZAngle(vehicles[playerid],gGrid[3]);
			gGridIndex=1;
		}
	    case 1:
	    {
	        SetPlayerVirtualWorld(playerid, gWorldID);
			SetPlayerPos(playerid,gGrid2[4],gGrid2[5],gGrid2[6]+1.0);
			//vehicles[gGridCount] = CreateVehicle(gCarModelID,gGrid[4],gGrid[5],gGrid[6],gGrid[7],-1,-1,10);
			//SetVehiclePos(vehicles[playerid],gGrid[4],gGrid[5],gGrid[6]);
			//SetVehicleZAngle(vehicles[playerid],gGrid[7]);
			gGridIndex=0;
	    }


	}
	//SetRaceText(playerid,gGridCount+1);
	//PutPlayerInVehicle(playerid,vehicles[gGridCount],0);
	//SetTimerEx("PutPlayerInVehicleTimed",3000,0,"ddd",playerid, vehicles[gGridCount],0);
	//SetCameraBehindPlayer(playerid);
//	if(gRaceStarted==0)TogglePlayerControllable(playerid,false);
	gGrid2Count++;
	//SetCheckpoint(playerid,gPlayerProgress[playerid],gMaxCheckpoints);
	//printf("GridSetupDebug- time:%d gridpos:%d playerid:%d vehicle:%d",GetTickCount(),gGridCount,playerid,vehicles[gGridCount]);
	return 1;
}

public GridSetup(playerid)
{	//Staggered Grid Modified from Y_Less's GetXYInFrontOfPlayer() function

	new State = GetPlayerState(playerid);
	if (State>1)
	{
	    printf("Aborting Grid setup for player:%d Reason: Was in vehicle/alt tabbed/dead",playerid);
	    SendClientMessage(playerid,COLOR_TEMP,"[ERROR] Anti-crash stopped you from being gridded. Type /rescueme to rejoin the race");
	    //Kick(playerid);
	    return 1;
	}

	//vehicles[playerid]=-1;
	new Float:distance;

	if (gGridCount>1)
	{
		distance=10.0;
		switch (gGridIndex)
		{
		    case 0:
		    {
				gGrid[0] -= (distance * floatsin(-gGrid[3], degrees));
				gGrid[1] -= (distance * floatcos(-gGrid[3], degrees));

		    }
		    case 1:
		    {
				gGrid[4] -= (distance * floatsin(-gGrid[7], degrees));
				gGrid[5] -= (distance * floatcos(-gGrid[7], degrees));
		    }
		}
	}

	switch (gGridIndex)
	{
	    case 0:
	    {
			//SetPlayerPos(playerid,gGrid[0],gGrid[1],gGrid[2]+5.0);
			vehicles[gGridCount] = CreateVehicle(gCarModelID,gGrid[0],gGrid[1],gGrid[2],gGrid[3],-1,-1,10);
			SetVehicleVirtualWorld(vehicles[gGridCount],gWorldID);
			//SetVehiclePos(vehicles[playerid],gGrid[0],gGrid[1],gGrid[2]);
			//SetVehicleZAngle(vehicles[playerid],gGrid[3]);
			gGridIndex=1;
		}
	    case 1:
	    {

			//SetPlayerPos(playerid,gGrid[4],gGrid[5],gGrid[6]+5.0);
			vehicles[gGridCount] = CreateVehicle(gCarModelID,gGrid[4],gGrid[5],gGrid[6],gGrid[7],-1,-1,10);
			SetVehicleVirtualWorld(vehicles[gGridCount],gWorldID);
			//SetVehiclePos(vehicles[playerid],gGrid[4],gGrid[5],gGrid[6]);
			//SetVehicleZAngle(vehicles[playerid],gGrid[7]);
			gGridIndex=0;
	    }


	}
	SetRaceText(playerid,gGridCount+1);
	//PutPlayerInVehicle(playerid,vehicles[gGridCount],0);
	SetTimerEx("PutPlayerInVehicleTimed",TIME_PUT_PLAYER,0,"ddd",playerid, vehicles[gGridCount],0);
	SetCameraBehindPlayer(playerid);
	if(gRaceStarted==0)TogglePlayerControllable(playerid,false);
	gGridCount++;
	SetCheckpoint(playerid,gPlayerProgress[playerid],gMaxCheckpoints);
	printf("GridSetupDebug- time:%d gridpos:%d playerid:%d vehicle:%d",GetTickCount(),gGridCount,playerid,vehicles[gGridCount]);
	return 1;
}

LoadRaceList()
{
	new File:f;
	new line[256];
	if(fexist("racenames.txt"))
	{
		f = fopen("racenames.txt", io_read);
		while(fread(f,line,sizeof(line),false))
		{
     		new iidx;
			gRaceNames[gRaces] = strtok(line,iidx);
			new msg[256];
			format(msg,256,"%s.race",gRaceNames[gRaces]);
            if(fexist(msg))
			{
			} else {
				printf("Line%d - 404 %s",gRaces,gRaceNames[gRaces]);
			}
			gRaces++;
		}
		fclose(f);
	}
}

SaveRace(playerid)
{
	new msg[256];
	new trackname2[256];
	format(trackname2,256,"%s.txt",xRaceName[playerid]);
	new File:f2;
	f2 = fopen(trackname2, io_write);
	fclose(f2);
	
	new File:f3;
	f3 = fopen("buildlog.txt", io_append);
	new hour,mins,year,month,day;
	gettime(hour,mins);
	getdate(year,month,day);
	format(msg,256, "%d/%d/%d %d:%d - %s by %s\n",day,month,year,hour,mins,xRaceName[playerid],xCreatorName[playerid]);
	fwrite(f3,msg);
	fclose(f3);
	new trackname[256];
	format(trackname,256,"%s.race",xRaceName[playerid]);
	new File:f;
	f = fopen(trackname, io_write);
	format(msg,256, "15 %d %d %d %d %s\n",xTrackTime[playerid],xWorldTime[playerid],xWeatherID[playerid],xRaceType[playerid],xCreatorName[playerid]);
	fwrite(f,msg);
	if (xCarIds[playerid][0]<300)xCarIds[playerid][0]=565;
	format(msg,256, "%d\n",xCarIds[playerid][0]);
	fwrite(f,msg);
	format(msg,256, "%f %f %f %f\n",xRaceCheckpoints[playerid][0][0],xRaceCheckpoints[playerid][0][1],xRaceCheckpoints[playerid][0][2], xFacing[playerid]);
	fwrite(f,msg);
	format(msg,256, "%f %f %f %f\n",xRaceCheckpoints[playerid][1][0],xRaceCheckpoints[playerid][1][1],xRaceCheckpoints[playerid][1][2], xFacing[playerid]);
	fwrite(f,msg);
	new i=2;
	while (xRaceCheckpoints[playerid][i][2]>0)
	{
	    new msg2[256];
		format(msg2,256, "%f %f %f\n",xRaceCheckpoints[playerid][i][0],xRaceCheckpoints[playerid][i][1],xRaceCheckpoints[playerid][i][2]);
	    fwrite(f,msg2);
		i++;
	}
	
	fclose(f);
	new msgx[256];
	format(msgx,256,"Sucess! %s Created. Type /track %s to change",xRaceName[playerid], xRaceName[playerid]);
	SendClientMessage(playerid,COLOR_TEMP,msgx);
	printf("SAVED %s",xRaceName[playerid]);
	return 1;
}


LoadRace(racename[])
{
	printf("Loading Race:%s",racename);
	new trackname[256];
	format (trackname,256,"%s.race",racename);
	if(!fexist(trackname))
	{
	    printf("404:race file not found: %s",trackname);
	    LoadRace(gRaceNames[random(gRaces)]);
	    return 0;
	}
	format (gTrackName,256,"%s",racename);
	
	for(new i;i<MAX_RACECHECKPOINTS;i++)
	{
		RaceCheckpoints[i][0]=0.0;
		RaceCheckpoints[i][1]=0.0;
		RaceCheckpoints[i][2]=0.0;
		RaceCheckpoints[i][3]=0.0;
	}
	gMaxCheckpoints=0;
	new File:f;
	new line[256];
	f = fopen(trackname, io_read);
	fread(f,line,sizeof(line),false);
	new idx;
	gCountdown = strval(strtok(line,idx));
	gTrackTime = strval(strtok(line,idx));
	gWorldTime = strval(strtok(line,idx));
	gWeather = strval(strtok(line,idx));
	gRaceType = strval(strtok(line,idx));
	gRaceMaker = strtok(line,idx);

	fread(f,line,sizeof(line),false);
	new iiddxx;
	new gCars[5],j;
	gCars[0]=strval(strtok(line,iiddxx));
	gCars[1]=strval(strtok(line,iiddxx));
	gCars[2]=strval(strtok(line,iiddxx));
	gCars[3]=strval(strtok(line,iiddxx));
	gCars[4]=strval(strtok(line,iiddxx));

	for(new i=0;i<5;i++)
	{
	    if(gCars[i])
		{
			j=i;
		}
	}
	new rand;
	if (j) rand = random(j);
	else rand = j;
	gCarModelID=gCars[rand];

	fread(f,line,sizeof(line),false);
	iiddxx=0;
	gGrid[0]=floatstr(strtok(line,iiddxx));
	gGrid[1]=floatstr(strtok(line,iiddxx));
	gGrid[2]=floatstr(strtok(line,iiddxx));
	gGrid[3]=floatstr(strtok(line,iiddxx));
	gGrid2[0]=gGrid[0];
	gGrid2[1]=gGrid[1];
	gGrid2[2]=gGrid[2];
	gGrid2[3]=gGrid[3];

	fread(f,line,sizeof(line),false);
	iiddxx=0;
	gGrid[4]=floatstr(strtok(line,iiddxx));
	gGrid[5]=floatstr(strtok(line,iiddxx));
	gGrid[6]=floatstr(strtok(line,iiddxx));
	gGrid[7]=floatstr(strtok(line,iiddxx));
	gGrid2[4]=gGrid[4];
	gGrid2[5]=gGrid[5];
	gGrid2[6]=gGrid[6];
	
	while(fread(f,line,sizeof(line),false))
	{
		new idxx;
		RaceCheckpoints[gMaxCheckpoints][0] = floatstr(strtok(line,idxx));
		RaceCheckpoints[gMaxCheckpoints][1] = floatstr(strtok(line,idxx));
		RaceCheckpoints[gMaxCheckpoints][2] = floatstr(strtok(line,idxx));
		gMaxCheckpoints++;
	}
	fclose(f);

	for(new i;i<MAX_PLAYERS;i++)
	{
		gPlayerProgress[i]=0;
		PlaySoundForPlayer(i, 1186);
		if (i<100)RaceCheckpoints[i][3]=0;
		new Menu:Current;
		if (IsPlayerConnected(i) && GetPlayerMenu(i) == Current)
		{
			HideMenuForPlayer(voteMenu,i);
		}
	}
	gFinishOrder=0;
	gGridCount=0;
	gGrid2Count=0;
	KillTimer(gCountdowntimer);
	gCountdowntimer = SetTimer("Countdowntimer",1000,1);
	SetWorldTime(gWorldTime);
	SetWeather(gWeather);
	gRaceStart=0;
	gRaceStarted=0;
	gFinished=0;
	createVote();
	new tempTime[256];
	tempTime = HighScore(0);
	format(gBestTime,sizeof(gBestTime),"<> %s by %s | %s <>\n",gTrackName,gRaceMaker, tempTime);
	SendClientMessageToAll(COLOR_TEMP,gBestTime);
	print("Race Loaded");
	return 1;
}

SetCheckpoint(playerid, progress, totalchecks)
{
	new checktype;
	if(gRaceType==1)checktype=0; else if(gRaceType==2) checktype=4;
	if (progress==totalchecks-1)SetPlayerRaceCheckpoint(playerid,1,RaceCheckpoints[progress][0],RaceCheckpoints[progress][1],RaceCheckpoints[progress][2],RaceCheckpoints[progress][0],RaceCheckpoints[progress][1],RaceCheckpoints[progress][2],CHECK_SIZE);
	else SetPlayerRaceCheckpoint(playerid,checktype,RaceCheckpoints[progress][0],RaceCheckpoints[progress][1],RaceCheckpoints[progress][2],RaceCheckpoints[progress+1][0],RaceCheckpoints[progress+1][1],RaceCheckpoints[progress+1][2],CHECK_SIZE);
}


StartRace()
{


    GameTextForAll("~W~GO", 2000, 5);
	for(new i;i<MAX_PLAYERS;i++)
	{
		if (IsPlayerConnected(i)&&xRaceBuilding[i]==0&&spawned[i]==1)
		{
			TogglePlayerControllable(i, 1);
			PlaySoundForPlayer(i, 1057);
		}
	}
	gRaceStart=GetTickCount();
	KillTimer(gCountdowntimer);
	KillTimer(gEndRacetimer);
	gEndRacetimer = SetTimer("nextRaceCountdown",1000,1);
	gRaceStarted = 1;
}

public nextRaceCountdown()
{
	gTrackTime--;
	switch (gTrackTime)
	{
	    case 6:
	    {
			RemovePlayersFromVehicles();
	    }
	    case 1:
	    {
			racecount++;
			if (racecount == RACES_TILL_MODECHANGE)GameModeExit();
			changetrack();
			
	    }
	    case 20,30:
	    {
	        new msg[128];
	        format(msg,128,"%d seconds till next race.",gTrackTime);
	        SendClientMessageToAll(COLOR_TEMP,msg);
	    }
	    case 10:
	    {
			countVotes();
	    }
	}
}

public Countdowntimer()
{
	gCountdown--;
	switch (gCountdown)
	{
		case 0:
		{
			StartRace();
		}
		case 2,1:
		{
			new message[256];
			format(message, sizeof(message),"%d", gCountdown);

			for(new i;i<MAX_PLAYERS;i++)
			{
				if (IsPlayerConnected(i)&&xRaceBuilding[i]==0&&spawned[i]==1)
				{
					TogglePlayerControllable(i, 0);
					PlaySoundForPlayer(i, 1056);
					GameTextForPlayer(i,message, 750, 5);
				}
			}
		}
	 	case 4,3:
		{
			new message[256];
			format(message, sizeof(message),"%d", gCountdown);
			for(new i;i<MAX_PLAYERS;i++)
			{
				if (IsPlayerConnected(i)&&xRaceBuilding[i]==0&&spawned[i]==1)
				{
					TogglePlayerControllable(i, 0);
					GameTextForPlayer(i,message, 750, 5);
				}
			}
		}
		case 5:
		{
			new message[256];
			format(message, sizeof(message),"%d", gCountdown);
			
			for (new i = 0; i < MAX_PLAYERS; i++)
			{
				if (IsPlayerConnected(i)&&xRaceBuilding[i]==0 &&spawned[i]==1)
				{
					TogglePlayerControllable(i, 0);
					SetCameraBehindPlayer(i);
					GameTextForPlayer(i,message, 750, 5);
				}
			}
		}

		case 10,20,30,40,50,60,70,80,90:
		{
			new tmpmsg[256];
			format(tmpmsg, sizeof(tmpmsg), "~w~RACE STARTING IN ~y~%d ~w~SECONDS", gCountdown);
			GameTextForAll(tmpmsg, 4000, 4);
		}

	}

	return 1;
}



strtok(const string[], &index)
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


// timeconvert code mainly from Dabombber
timeconvert(Time, &Minutes, &Seconds, &MSeconds)
{
	new Float:fTime = floatdiv(Time, 60000);
    Minutes = floatround(fTime, floatround_tozero);
    Seconds = floatround(floatmul(fTime - Minutes, 60), floatround_tozero);
    MSeconds = floatround(floatmul(floatmul(fTime - Minutes, 60) - Seconds, 1000), floatround_tozero);
}


PlaySoundForPlayer(playerid, soundid)
{
	new Float:pX, Float:pY, Float:pZ;
	GetPlayerPos(playerid, pX, pY, pZ);
	PlayerPlaySound(playerid, soundid,pX, pY, pZ);
}





public PutPlayerInVehicleTimed(playerid, veh, slot)
{
	new State = GetPlayerState(playerid);
	if (State!=1)
	{
	    printf("Aborting Grid setup for player:%d Reason: Was in vehicle/alt tabbed/dead",playerid);
	    SendClientMessage(playerid,COLOR_TEMP,"[ERROR] Anti-crash stopped you from being gridded. Type /rescueme to rejoin the race");
	    return 1;
	}
	PutPlayerInVehicle(playerid,veh,slot);
	SetCameraBehindPlayer(playerid);
	if(gRaceStarted==0)TogglePlayerControllable(playerid,false);
	return 1;
}
public OnPlayerExitedMenu(playerid)
{
	TogglePlayerControllable(playerid,1);
	return 1;
}

public OnPlayerConnect(playerid)
{
#if defined SHOW_JOINS_PARTS
 	new pname[MAX_PLAYER_NAME],pmsg[256];
	GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
	format(pmsg,256,"*** %s has joined the server",pname);
	SendClientMessageToAll(COLOR_TEMP,pmsg);
#endif
	if (gTotalRacers==0)LoadRace(gTrackName);
	SendClientMessage(playerid,COLOR_TEMP,"Welcome to Adrenaline 1.06 by switch. The #1 SA-MP Racing mode! NEW: Can now make and save races in-game!");
	SendClientMessage(playerid,COLOR_TEMP,"Availible Commands: '/newcar' '/rescueme' '/buildmode on' '/buildmode off'");

	gTotalRacers++;
	new tmp[5];
	format(tmp,5,"/%d",gTotalRacers);

	Tposition[playerid] = TextDrawCreate(560.0, 330.0, " ");
	TextDrawLetterSize(Tposition[playerid], 1.2, 6.2);
	Tappend[playerid] = TextDrawCreate(590.0, 335.0, " ");
	TextDrawLetterSize(Tappend[playerid], 0.5, 2.5);

	TextDrawSetString(Ttotalracers,tmp);
	TextDrawShowForPlayer(playerid, Ttime);
	TextDrawShowForPlayer(playerid, Tappend[playerid]);
	TextDrawShowForPlayer(playerid, Tposition[playerid]);
	TextDrawShowForPlayer(playerid, Ttotalracers);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    spawned[playerid]=0;
#if defined SHOW_JOINS_PARTS
	new pname[MAX_PLAYER_NAME],pmsg[256];
	GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
	format(pmsg,256,"*** %s has left the server",pname);
	SendClientMessageToAll(COLOR_TEMP,pmsg);
#endif
	//for(new i;i<MAX_PLAYERS;i++)TextDrawHideForPlayer(i,txtVar3[gTotalRacers]);//total racers  LIMITATION atm will only work with 9 people, if more may crash server
	gTotalRacers--;
	new tmp[5];
	format(tmp,5,"/%d",gTotalRacers);
	TextDrawSetString(Ttotalracers,tmp);
	//for(new i;i<MAX_PLAYERS;i++)TextDrawShowForPlayer(i,txtVar3[gTotalRacers]);//total racers  LIMITATION atm will only work with 9 people, if more may crash server
    xRaceBuilding[playerid]=0;
	gScores[playerid][1]=0;
	TextDrawSetString(Tappend[playerid],tmp);
	TextDrawHideForPlayer(playerid, Ttime);
	TextDrawHideForPlayer(playerid, Tappend[playerid]);
	TextDrawHideForPlayer(playerid, Tposition[playerid]);
	TextDrawHideForPlayer(playerid, Ttotalracers);
	TextDrawDestroy(Tappend[playerid]);
	TextDrawDestroy(Tposition[playerid]);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    if(killerid == INVALID_PLAYER_ID) {
        SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
	} else {
	   	SendDeathMessage(killerid,playerid,reason);
	}
	spawned[playerid]=0;
/*	while (gPlayerProgress[playerid]>0)
	{
		RaceCheckpoints[gPlayerProgress[playerid]+1][3] = RaceCheckpoints[gPlayerProgress[playerid]+1][3] - 1.0;
		gPlayerProgress[playerid]--;
	}
*/
	return 1;
}


public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}



public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}












	//redesigned high score handling code done by kynen
ReadHighScoreList(track[256], display, playerid, all)
{       //READ and DISPLAY Highscorelist
	new HSList[HIGH_SCORE_SIZE][rStats];                                //Takes params trackname, if it is to be displayed on screen
	new FiPo[255];                                                      //the player requesting the displaying and if it is to be
	new himsg[255];                                                     //displayed to all clients

	if(strcmp(track, "", true ) )
	{                                     //if a parameter isn't passed
		track = gTrackName;                                               //use current track
	}

	format(FiPo, sizeof(FiPo), "%s.txt", track);
	if(fexist(FiPo))
	{
		new File: hsfile = fopen(FiPo, io_read);
		new line[256];
		new temp[256];
		new idx;
		if (display)
		{
			format(himsg, sizeof(himsg),"Current Highscorelist for %s\n", track);
			if(playerid==-1 || IsPlayerAdmin(playerid) && all)
			{
				SendClientMessageToAll(COLOR_TEMP, himsg);             //Sweet khaki color... :D
			} else {
				SendClientMessage(playerid, COLOR_TEMP, himsg);
			}
		}
		for(new i = 0; i <= sizeof(HSList)-1; i++)
		{
			fread(hsfile, line, sizeof(line));
			temp = strtok(line, idx);
			strmid(HSList[i][rName], temp, 0, strlen(temp), 255);     //read racename (to be compatible
			temp = strtok(line, idx);                                 //
			HSList[i][rTime] = strval(temp);                          //convert record to int
			temp = strtok(line, idx);
			strmid(HSList[i][rRacer], temp, 0, strlen(temp), 255);
			idx = 0;                                                  //reset idx to read more highscores
			if (HSList[i][rTime] == 0)
			{                              //check if record is not set (0) previously
				if(!display)
				{                                         //No need to return if it is being displayed
					fclose(hsfile);
					return (HSList);                                  //if list ends, return what there was
				}
			}
			if (display)
			{
				new Minutes, Seconds, MSeconds, sSeconds[5], sMSeconds[5];
				timeconvert(HSList[i][rTime], Minutes, Seconds, MSeconds);
				if (Seconds < 10)format(sSeconds, sizeof(sSeconds), "0%d", Seconds);
				else format(sSeconds, sizeof(sSeconds), "%d", Seconds);
				if (MSeconds < 100)format(sMSeconds, sizeof(sMSeconds), "0%d", MSeconds);
				else format(sMSeconds, sizeof(sMSeconds), "%d", MSeconds);
				if (Minutes != 50)	format(himsg, sizeof(himsg),"%d - %d:%s.%s by %s\n", i+1, Minutes, sSeconds, sMSeconds, HSList[i][rRacer]);
				else format(himsg, sizeof(himsg),"\n");
				if(playerid==-1 || IsPlayerAdmin(playerid) && all)
				{
					SendClientMessageToAll(COLOR_TEMP, himsg);        //Sweet khaki color... :D
				} else {
					SendClientMessage(playerid, COLOR_TEMP, himsg);
				}
			}
		}
		fclose(hsfile);
	} else {                                                            //if client passed as param a race that doesn't exist
	format(himsg, sizeof(himsg),"The track '%s' doesn't exist.\n", track);
	SendClientMessage(playerid, COLOR_TEMP, himsg);                 //Send errormsg privately even if admin

	}
	if(!display)
	{                                                      //No need to return if it is being displayed
		return (HSList);                                                  //so warning 209 can be ignored.
	}
	return (HSList);
}

	//redesigned high score handling code done by kynen
CheckAgainstHighScore(playerid, time)
{
	new RaceInfo[HIGH_SCORE_SIZE][rStats];
	RaceInfo = ReadHighScoreList(gTrackName, 0, 0, 0);
	//Get current track highscorelist
	new playername2[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername2, MAX_PLAYER_NAME);
	new recordflag=-1;
	//Init to -1 or it will be 0 and fail to work
	new pflag=-1;
	for(new i = 0; i < sizeof(RaceInfo); i++)
	{
	//run through highscorelist to see if new highscore
		if (RaceInfo[i][rTime] == 0)
		{
	//check if record is not set (0) previously
			RaceInfo[i][rTime] = 3000000;
	//if no previous record, set dummy record
		}
		if (strcmp(RaceInfo[i][rRacer], playername2) == 0 && pflag ==-1)
		{ //check for personal best score
			pflag = i;
	      //mark where best personal record is
		}
		if (time < RaceInfo[i][rTime] && recordflag ==-1 && (pflag == -1 || pflag == i) )
		{               //new record
	           //personal flag must always be equal or nonexistant (-1) for a valid (personal) record
			new newrecordmessage[256];
			if (i+1 == 1) printf("NEW FIRST RECORD - %s", playername2);
			format(newrecordmessage, sizeof(newrecordmessage),"New Highscore (%d) on %s by %s\n" , i+1, gTrackName, playername2);
			SendClientMessageToAll(COLOR_TEMP, newrecordmessage);
			recordflag = i;
			//Record number
		}
	}
	if (recordflag>-1)
	{
	//new highscore
		new tmp1[255];
		format(tmp1,sizeof(tmp1),"%s.txt", gTrackName);     //time to update list (file)
		if(fexist(tmp1))
		{
			new File: file2 = fopen(tmp1, io_write);
			new recordmessage[256];
			new recmsg2[256];
			format(recordmessage, sizeof(recordmessage),"%s %d %s\n" , gTrackName, time, playername2);
			for(new i = 0; i < sizeof(RaceInfo); i++)
			{
				if(i == recordflag)
				{
				//record goes to correct place in list
					fwrite(file2,recordmessage);
				}
				if(strcmp(RaceInfo[i][rRacer], playername2)==0)
				{
		//skip all records that matches racername
					continue;
				}
				if(RaceInfo[i][rTime] == 3000000)
				{
		//ignore dummy records
					break;
				}
				format(recmsg2, sizeof(recmsg2), "%s %d %s\n", gTrackName, RaceInfo[i][rTime], RaceInfo[i][rRacer]);
				fwrite(file2,recmsg2);
		//write from old record list
			}
			fclose(file2);
		} else {
			SendClientMessageToAll(COLOR_TEMP, "Error: Track file does not exist");
		}
	}
}

HighScore(Track)
{
	#pragma unused Track
	new recordtimestr[20], recordtime;
	new racer[256];
	new HighScoreString[256];



	new tmp1[255];
	format(tmp1,sizeof(tmp1),"%s.txt", gTrackName);

	if (!fexist(tmp1))
	{
	    new File: file1 = fopen(tmp1, io_write);
	    fclose(file1);
	}
	new File: file = fopen(tmp1, io_read);
	new line[256];
	new track[256];
	new idx;

	fread(file, line, sizeof (line));
	track = strtok(line, idx);
	recordtimestr = strtok(line, idx);
	racer = strtok(line, idx);
	fclose (file);
	recordtime = strval(recordtimestr);


	new Minutes, Seconds, MSeconds, sSeconds[5], sMSeconds[5];
	if (recordtime > 0)
	{
		timeconvert(recordtime, Minutes, Seconds, MSeconds);

		if (Seconds < 10)format(sSeconds, sizeof(sSeconds), "0%d", Seconds);
		else format(sSeconds, sizeof(sSeconds), "%d", Seconds);
		if (MSeconds < 100)format(sMSeconds, sizeof(sMSeconds), "0%d", MSeconds);
		else format(sMSeconds, sizeof(sMSeconds), "%d", MSeconds);

		format(HighScoreString,sizeof(HighScoreString),"Record: %d:%s.%s by %s \n", Minutes, sSeconds, sMSeconds, racer);
	} else {
		format(HighScoreString,sizeof(HighScoreString),"There is currently no track record. \n");
	}

	return HighScoreString;
}

/*
findHighest()
{
	new t = gScores2[0][1];
	new index;
	for(new i = 0; i < 13;i++)
	{

	    if (gScores2[i][1]>t)
	    {
			index=i;
			t = gScores2[i][1];
	    }
	}
	gScores2[index][1]=0;
	return index;
}
*/
sscanf(string[], format[], {Float,_}:...)//sscanf by Y_Less
{
	new
		formatPos,
		stringPos,
		paramPos = 2,
		paramCount = numargs();
	while (paramPos < paramCount && string[stringPos])
	{
		switch (format[formatPos])
		{
			case '\0': break;
			case 'i', 'd': setarg(paramPos, 0, strval(string[stringPos]));
			case 'c': setarg(paramPos, 0, string[stringPos]);
			case 'f': setarg(paramPos, 0, _:floatstr(string[stringPos]));
			case 's':
			{
				new
					end = format[formatPos + 1] == '\0' ? '\0' : ' ',
					i;
				while (string[stringPos] != end) setarg(paramPos, i++, string[stringPos++]);
				setarg(paramPos, i, '\0');
			}
			default: goto skip;
		}
		while (string[stringPos] && string[stringPos] != ' ') stringPos++;
		while (string[stringPos] == ' ') stringPos++;
		paramPos++;
		skip:
		formatPos++;
	}
	return format[formatPos] ? 0 : 1;
}



quickSort(array_size)
{
  print("quickSort()");
  q_sort(0, array_size - 1);
}

q_sort(left, right)
{
  new pivot, l_hold, r_hold;

  l_hold = left;
  r_hold = right;
  pivot = gScores2[left][1];
  new what = gScores2[left][0];
  while (left < right)
  {
    while ((gScores2[right][1] >= pivot) && (left < right))
      right--;
    if (left != right)
    {
      gScores2[left][1] = gScores2[right][1];
      gScores2[left][0] = gScores2[right][0];
      left++;
    }
    while ((gScores2[left][1] <= pivot) && (left < right))
      left++;
    if (left != right)
    {
      gScores2[right][1] = gScores2[left][1];
      gScores2[right][0] = gScores2[left][0];
      right--;
    }
  }
  gScores2[left][1] = pivot;
  gScores2[left][0] = what;
  pivot = left;
  left = l_hold;
  right = r_hold;
  if (left < pivot) q_sort(left, pivot-1);
  if (right > pivot) q_sort(pivot+1, right);
}



//////////////////////////////////////////////////
//// x.x CUSTOM FUNCTIONS (END) ////////////////
//////////////////////////////////////////////////
