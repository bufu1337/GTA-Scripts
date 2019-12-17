#include <a_samp>
#include <dini>
#include <dutils>
#include <dudb>
#pragma unused ret_memcpy

/*===========================================================
PromotionMode:
There are 5 different ways to promote:
0 = The player can't promote (only if you use SetPlayerRank(playerid, rankID);
1 = If the player has played a given number of hours on the server
2 = If the player has killed a given number of other players
3 = If the player has a given amount of money
4 = If the player has a given number of visits
5 = If the player has a given score
*/
#define DEFAULT_PROMOTION_MODE 1
//===========================================================

#define MAX_RANKS 100
new UseIpCheck = 0;
new PromotionMode = DEFAULT_PROMOTION_MODE;
#define PLAYERFILE "PlayerFiles/%s.txt"

/*
native AddRank(rankID, const Name[], Requirement, Startmoney, Float:SpawnHealth, Float:SpawnArmour, SpawnWeapon, SpawnAmmo);
native SetPromotionMode(mode);
native S_OnPlayerConnect(playerid);
native S_OnPlayerSpawn(playerid);
native S_OnPlayerDisconnect(playerid);
native S_OnPlayerDeath(killerid);
native GetPlayerRank(playerid);
native GetRankInfo(playerid);
native GetPlayerStats(playerid)
native ResetPlayerStats(playerid);
native ToggleIpCheck(toggle);
native SetPlayerRank(playerid, rankID);
*/

enum rinfo
{
	RName[64],
	RRequirement,
	RStartMoney,
	Float:RSpawnHealth,
	Float:RSpawnArmour,
	RSpawnWeapon,
	RSpawnAmmo,
};

new RankInfo[MAX_RANKS][rinfo];
new OnlineTimer[MAX_PLAYERS];
new TotalRanks;

enum pinfo
{
	MinutesPlayed,
	HoursPlayed,
	Kills,
	Visits,
	Rank,
	SaveStats,
}
new PInfo[MAX_PLAYERS][pinfo];

stock SetPromotionMode(mode)
{
	PromotionMode = mode;
}

stock S_OnPlayerConnect(playerid)
{
	new PName[MAX_PLAYER_NAME];
	new file[128];
	new Ip[20];
	if(UseIpCheck == 1)
	{
 		GetPlayerIp(playerid, Ip, 20);
	}
	GetPlayerName(playerid, PName, MAX_PLAYER_NAME);
	format(file, sizeof(file), PLAYERFILE, udb_encode(PName));
	if(!dini_Exists(file))
	{
	    dini_Create(file);
		if(UseIpCheck == 1)
		{
	    	dini_Set(file, "IP", Ip);
		}
	    dini_IntSet(file, "Visits", PInfo[playerid][Visits]);
	    dini_IntSet(file, "HoursPlayed", 0);
	    dini_IntSet(file, "MinutesPlayed", 0);
		dini_IntSet(file, "Kills", 0);
		dini_IntSet(file, "Rank", 0);
		PInfo[playerid][SaveStats] = 1;
	}
	else
	{
	    if(UseIpCheck == 1)
		{
			new FileIp[20];
			format(FileIp, 20, "%s", dini_Get(file, "IP"));
			if(strcmp(Ip, FileIp, true)==0)
			{
			    PInfo[playerid][Visits] = dini_Int(file, "Visits");
		    	PInfo[playerid][HoursPlayed] = dini_Int(file, "HoursPlayed");
		    	PInfo[playerid][MinutesPlayed] = dini_Int(file, "MinutesPlayed");
		    	PInfo[playerid][Kills] = dini_Int(file, "Kills");
		    	PInfo[playerid][Rank] = dini_Int(file, "Rank");
		    	PInfo[playerid][SaveStats] = 1;
			}
			else
			{
				PInfo[playerid][SaveStats] = 0;
			}
		}
		else
		{
			PInfo[playerid][Visits] = dini_Int(file, "Visits");
		   	PInfo[playerid][HoursPlayed] = dini_Int(file, "HoursPlayed");
		   	PInfo[playerid][MinutesPlayed] = dini_Int(file, "MinutesPlayed");
		   	PInfo[playerid][Kills] = dini_Int(file, "Kills");
		   	PInfo[playerid][Rank] = dini_Int(file, "Rank");
		   	PInfo[playerid][SaveStats] = 1;
		}
	}
	new PR = PInfo[playerid][Rank];
	if(RankInfo[PR][RStartMoney] > -1)
	{
		GivePlayerMoney(playerid, RankInfo[PR][RStartMoney]);
	}
	PInfo[playerid][Visits]++;
	OnlineTimer[playerid] = SetTimerEx("OnlineTimeUpdate", 60000, 1, "i", playerid);
}

stock S_OnPlayerDisconnect(playerid)
{
	if(PInfo[playerid][SaveStats] == 1)
	{
	    new PName[MAX_PLAYER_NAME], file[128];
	    GetPlayerName(playerid, PName, MAX_PLAYER_NAME);
		format(file, sizeof(file), PLAYERFILE, udb_encode(PName));
		dini_IntSet(file, "Visits", PInfo[playerid][Visits]);
	    dini_IntSet(file, "HoursPlayed", PInfo[playerid][HoursPlayed]);
	    dini_IntSet(file, "MinutesPlayed", PInfo[playerid][MinutesPlayed] );
		dini_IntSet(file, "Kills", PInfo[playerid][Kills]);
		dini_IntSet(file, "Rank", PInfo[playerid][Rank]);
	}
	PInfo[playerid][Rank] = 0;
	PInfo[playerid][Kills] = 0;
	PInfo[playerid][MinutesPlayed] = 0;
	PInfo[playerid][HoursPlayed] = 0;
	PInfo[playerid][Visits] = 0;
	PInfo[playerid][SaveStats] = 0;
	KillTimer(OnlineTimer[playerid]);
}

stock S_OnPlayerSpawn(playerid)
{
    new PR = PInfo[playerid][Rank];
	if(RankInfo[PR][RSpawnHealth] > 0)
	{
		SetPlayerHealth(playerid, RankInfo[PR][RSpawnHealth]);
	}
	if(RankInfo[PR][RSpawnArmour] > -1)
	{
		SetPlayerArmour(playerid, RankInfo[PR][RSpawnArmour]);
	}
	if(RankInfo[PR][RSpawnWeapon] > -1)
	{
	    ResetPlayerWeapons(playerid);
	    GivePlayerWeapon(playerid, RankInfo[PR][RSpawnWeapon], RankInfo[PR][RSpawnAmmo]);
	}
	
}

stock S_OnPlayerDeath(killerid)
{
	if(killerid != INVALID_PLAYER_ID)
	{
	    PInfo[killerid][Kills]++;
	}
}

stock AddRank(rankID, const Name[], Requirement, StartMoney, Float:SpawnHealth, Float:SpawnArmour, SpawnWeapon, SpawnAmmo)
{
    TotalRanks++;
	format(RankInfo[rankID][RName], 64, "%s", Name);
	RankInfo[rankID][RRequirement] = Requirement;
	RankInfo[rankID][RStartMoney] = StartMoney;
	RankInfo[rankID][RSpawnHealth] = SpawnHealth;
	RankInfo[rankID][RSpawnArmour] = SpawnArmour;
	RankInfo[rankID][RSpawnWeapon] = SpawnWeapon;
	RankInfo[rankID][RSpawnAmmo] = SpawnAmmo;
}

stock GetPlayerRank(playerid)
{
	return PInfo[playerid][Rank];
}

stock ToggleIpCheck(toggle)
{
    UseIpCheck = toggle;
}

stock SetPlayerRank(playerid, rankID)
{
    PInfo[playerid][Rank] = rankID;
}

stock GetRankInfo(playerid)
{
	new str[128];
	new PR = PInfo[playerid][Rank];
	new weap[32];
	GetWeaponName(RankInfo[PR][RSpawnWeapon], weap, 32);
	format(str, 128, "============================RankInfo===============================");
	SendClientMessage(playerid, 0x7CFC00AA, str);
	format(str, 128, "Your Rank: %d: \"%s\"", PR, RankInfo[PR][RName]);
	SendClientMessage(playerid, 0x7CFC00AA, str);
	format(str, 128, "StartMoney: $%d ** SpawnHealth: %.1f \% ** SpawnArmour: %.1f \%", RankInfo[PR][RStartMoney], RankInfo[PR][RSpawnHealth], RankInfo[PR][RSpawnArmour]);
    SendClientMessage(playerid, 0xADFF2FAA, str);
    format(str, 128, "SpawnWeapon: %s (%d bullets)", weap, RankInfo[PR][RSpawnAmmo]);
	SendClientMessage(playerid, 0xADFF2FAA, str);
	PR++;
	if(PromotionMode > 0)
	{
		if(PR < TotalRanks)
		{
			switch(PromotionMode)
			{
			    case 1: {format(str, 128, "Requirement to promote to next rank: %d online hours. Current you have played %d hours and %d minutes", RankInfo[PR][RRequirement], PInfo[playerid][HoursPlayed], PInfo[playerid][MinutesPlayed]);}
				case 2: {format(str, 128, "Requirement to promote to next rank: %d kills. Current you have %d kills", RankInfo[PR][RRequirement], PInfo[playerid][Kills]);}
		        case 3: {format(str, 128, "Requirement to promote to next rank: %d dollar cash. Current you have %d dollar", RankInfo[PR][RRequirement], GetPlayerMoney(playerid));}
		        case 4: {format(str, 128, "Requirement to promote to next rank: %d visits to this server. Current you have %d visits", RankInfo[PR][RRequirement], PInfo[playerid][Visits]);}
		        case 5: {format(str, 128, "Requirement to promote to next rank: A score of %d. Current your score is: %d", RankInfo[PR][RRequirement], GetPlayerScore(playerid));}
		  	}
		}
		else
		{
		    format(str, 128, "You reached the highest level!");
		}
  		SendClientMessage(playerid, 0xADFF2FAA, str);
	}
  	format(str, 128, "======================================================================");
  	SendClientMessage(playerid, 0xADFF2FAA, str);
}

stock GetPlayerStats(playerid)
{
	new str[128];
	new PName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, PName, MAX_PLAYER_NAME);
    new PR = PInfo[playerid][Rank];
    SendClientMessage(playerid, 0xADFF2FAA, "==============PlayerInfo=================");
	format(str, 128, "Statistics of %s (ID: %d):", PName, playerid);
	SendClientMessage(playerid, 0x7CFC00AA, str);
	format(str, 128, "Current Rank: %d: \"%s\"", PInfo[playerid][Rank], RankInfo[PR][RName]);
	SendClientMessage(playerid, 0xADFF2FAA, str);
	format(str, 128, "Time Played: %d hours and %02d minutes", PInfo[playerid][HoursPlayed], PInfo[playerid][MinutesPlayed]);
	SendClientMessage(playerid, 0xADFF2FAA, str);
	format(str, 128, "Visits: %d ** Kills: %d", PInfo[playerid][Visits], PInfo[playerid][Kills]);
	SendClientMessage(playerid, 0xADFF2FAA, str);
	SendClientMessage(playerid, 0xADFF2FAA, "========================================");
}

stock ResetPlayerStats(playerid)
{
	new PName[MAX_PLAYER_NAME], file[128];
    GetPlayerName(playerid, PName, MAX_PLAYER_NAME);
	format(file, sizeof(file), PLAYERFILE, udb_encode(PName));
	dini_IntSet(file, "Visits", 0);
    dini_IntSet(file, "HoursPlayed", 0);
    dini_IntSet(file, "MinutesPlayed", 0 );
	dini_IntSet(file, "Kills", 0);
	dini_IntSet(file, "Rank", 0);
	PInfo[playerid][Rank] = 0;
	PInfo[playerid][Kills] = 0;
	PInfo[playerid][MinutesPlayed] = 0;
	PInfo[playerid][HoursPlayed] = 0;
	PInfo[playerid][Visits] = 0;
}

forward OnlineTimeUpdate(playerid);
public OnlineTimeUpdate(playerid)
{
    PInfo[playerid][MinutesPlayed] ++;
    if(PInfo[playerid][MinutesPlayed] == 60)
    {
        PInfo[playerid][HoursPlayed] ++;
        PInfo[playerid][MinutesPlayed] = 0;
	}
	CheckForPromotion(playerid);
}

CheckForPromotion(playerid)
{
	new NewRank = (PInfo[playerid][Rank] + 1);
	if(NewRank < TotalRanks)
	{
	    if(PromotionMode == 1)
	    {
			if(
		    PInfo[playerid][HoursPlayed] == RankInfo[NewRank][RRequirement] &&
     		 PInfo[playerid][MinutesPlayed] == 0
			)
			{
			    PInfo[playerid][Rank]++;
			    new string[128];
			    format(string, 128,"Congratulations! You promoted to Rank %d \"%s\"!!! If you want to see your new spawnInfo, type: /rankinfo", NewRank, RankInfo[NewRank][RName]);
			    SendClientMessage(playerid, 0x00FF00AA, string);
			}
		}
		else if(PromotionMode == 2)
		{
		    if(PInfo[playerid][Kills] >= RankInfo[NewRank][RRequirement])
		    {
		    	PInfo[playerid][Rank]++;
			    new string[128];
			    format(string, 128,"Congratulations! You promoted to Rank %d \"%s\"!!! If you want to see your new spawnInfo, type: /rankinfo", NewRank, RankInfo[NewRank][RName]);
			    SendClientMessage(playerid, 0x00FF00AA, string);
			}
		}
		else if(PromotionMode == 3)
		{
		    if(GetPlayerMoney(playerid) >= RankInfo[NewRank][RRequirement])
		    {
		    	PInfo[playerid][Rank]++;
			    new string[128];
			    format(string, 128,"Congratulations! You promoted to Rank %d \"%s\"!!! If you want to see your new spawnInfo, type: /rankinfo", NewRank, RankInfo[NewRank][RName]);
			    SendClientMessage(playerid, 0x00FF00AA, string);
			}
		}
		else if(PromotionMode == 4)
		{
		    if(PInfo[playerid][Visits] >= RankInfo[NewRank][RRequirement])
		    {
		    	PInfo[playerid][Rank]++;
			    new string[128];
			    format(string, 128,"Congratulations! You promoted to Rank %d \"%s\"!!! If you want to see your new spawnInfo, type: /rankinfo", NewRank, RankInfo[NewRank][RName]);
			    SendClientMessage(playerid, 0x00FF00AA, string);
			}
		}
		else if(PromotionMode == 5)
		{
		    if(GetPlayerScore(playerid) >= RankInfo[NewRank][RRequirement])
		    {
		    	PInfo[playerid][Rank]++;
			    new string[128];
			    format(string, 128,"Congratulations! You promoted to Rank %d \"%s\"!!! If you want to see your new spawnInfo, type: /rankinfo", NewRank, RankInfo[NewRank][RName]);
			    SendClientMessage(playerid, 0x00FF00AA, string);
			}
		}
	}
}