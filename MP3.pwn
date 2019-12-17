// This is a comment
// uncomment the line below if you want to write a filterscript
#define FILTERSCRIPT

#include <a_samp>
#include <dudb>
#define light_red 0xFF6A6AFF
#define light_green 0x96BD6AFF
#define MP3_PRICE 100
#define ANTIVIRUS_PRICE 250
enum Info
{
	MP3,
	MP3On,
	BatteryLow,
	AntiVirus,
	MP3Price,
	MP3Offer,
	GoGoMonkey,
	Bee,
	Dual,
	Award,
	AwardDriving,
	AwardBike,
	AwardPilot,
};
new PlayerInfo[MAX_PLAYERS][Info];
new WebSearching[MAX_PLAYERS];
new VirusTaked[MAX_PLAYERS];
new charge;
forward WebMusic(playerid);
forward VirusDeleted(playerid);
forward Randomise(playerid);
forward RandomiseB(playerid);
forward RandomiseC(playerid);
forward RandomiseD(playerid);
forward RandomiseE(playerid);
forward RandomiseF(playerid);
forward RandomiseG(playerid);
forward VirusCheck(playerid);
forward MP3Destroyed(playerid);
forward NeedCharge(playerid);
forward ChargeOff(playerid);
// This makes sure that the virus can be downloaded harder
new MonkeyDownload = 15;
new BeeDownload = 15;
new DualDownload = 15;
new AwardDownload = 15;
new AwardDDownload = 15;
new AwardBDownload = 15;
new AwardPDownload = 15;
#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Mp3 System By [Neil] Loaded");
	print("--------------------------------------\n");
	SetTimer("VirusCheck",1000,1);
	return 1;
}

public OnFilterScriptExit()
{
    print("\n--------------------------------------");
	print(" Mp3 System By [Neil] UnLoaded");
	print("--------------------------------------\n");
	return 1;
}

#endif
public OnPlayerConnect(playerid)
{
    new formatZ[256];
 	format(formatZ,sizeof(formatZ),"%s'MP3.txt",PlayerName(playerid));
    if(!udb_Exists(formatZ))
    {
    	udb_Create(formatZ,"209010");
    }
    PlayerInfo[playerid][MP3] = dUserINT(formatZ).("MP3 ");
    PlayerInfo[playerid][AntiVirus] = dUserINT(formatZ).("AntiVirus");
    PlayerInfo[playerid][GoGoMonkey] = dUserINT(formatZ).("GoGoMonkey");
    PlayerInfo[playerid][Bee] = dUserINT(formatZ).("Bee");
    PlayerInfo[playerid][Dual] = dUserINT(formatZ).("Dual");
    PlayerInfo[playerid][Award] = dUserINT(formatZ).("Award");
    PlayerInfo[playerid][AwardDriving] = dUserINT(formatZ).("AwardDriving");
    PlayerInfo[playerid][AwardBike] = dUserINT(formatZ).("AwardBike");
    PlayerInfo[playerid][AwardPilot] = dUserINT(formatZ).("AwardPilot");
    VirusTaked[playerid] = dUserINT(formatZ).("Virus");
    WebSearching[playerid] = 0;
	return 1;
}
stock PlayerName(playerid)
{
 	new name[255];
	GetPlayerName(playerid, name, 255);
	return name;
}
public OnPlayerDisconnect(playerid, reason)
{
    new formatZ2[256];
 	format(formatZ2,sizeof(formatZ2),"%s'sAccount.txt",PlayerName(playerid));
    dUserSetINT(formatZ2).("MP3",PlayerInfo[playerid][MP3]);
    dUserSetINT(formatZ2).("AntiVirus",PlayerInfo[playerid][AntiVirus]);
    dUserSetINT(formatZ2).("GoGoMonkey",PlayerInfo[playerid][GoGoMonkey]);
    dUserSetINT(formatZ2).("Bee",PlayerInfo[playerid][Bee]);
    dUserSetINT(formatZ2).("Dual",PlayerInfo[playerid][Dual]);
    dUserSetINT(formatZ2).("Award",PlayerInfo[playerid][Award]);
    dUserSetINT(formatZ2).("AwardDriving",PlayerInfo[playerid][AwardDriving]);
    dUserSetINT(formatZ2).("AwardBike",PlayerInfo[playerid][AwardBike]);
    dUserSetINT(formatZ2).("AwardPilot",PlayerInfo[playerid][AwardPilot]);
    dUserSetINT(formatZ2).("Virus",VirusTaked[playerid]);
    WebSearching[playerid] = 0;
	return 1;
}

public OnPlayerSpawn(playerid)
{
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
	return 1;
}
stock IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	if (string[i] > '9' || string[i] < '0')
    return 0;
	return 1;
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
				userid = INVALID_PLAYER_ID;
			else return userid;
		}
	}
	new len = (text[pos]);
	new count = 0;
	new pname[MAX_PLAYER_NAME];
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i, pname, sizeof (pname));
			if (strcmp(pname, text[pos], true, len) == 0)
			{
				if (len == strlen(pname)) return i;
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
			if (count) SendClientMessage(playerid, light_red, "There are multiple users, enter full playername.");
			else SendClientMessage(playerid, light_red, "Playername not found.");
		}
		userid = INVALID_PLAYER_ID;
	}
	return userid;
}
public VirusCheck(playerid)
{
	if(VirusTaked[playerid] == 1)
	{
	    SendClientMessage(playerid,light_green," AntiVirus: Virus Detected.Deleting the Virus...");
		SetTimerEx("VirusDeleted",10000,0,"%d",playerid);
	}
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
    new string[248];
	new cmd[256];
	new idx;
	new tmp[256];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];
	cmd = strtok(cmdtext, idx);
	if (strcmp("/buymp3", cmdtext, true, 10) == 0)
	{
	    if(PlayerInfo[playerid][MP3] == 0)
	    {
	        if(GetPlayerMoney(playerid) >= MP3_PRICE)
	        {
	    		if(IsPlayerInRangeOfPoint(playerid,4.0,-25.884498,-185.868988,1003.546875) || IsPlayerInRangeOfPoint(playerid,4.0,6.091179,-29.271898,1003.549438))
	    		{
					SendClientMessage(playerid,light_green," You have bought an MP3. Type /mp3help for more info.");
					PlayerInfo[playerid][MP3] = 1;
					GivePlayerMoney(playerid,-MP3_PRICE);
					PlayerPlaySound(playerid,1054,0.0,0.0,0.0);
					return 1;
				}
				else if(IsPlayerInRangeOfPoint(playerid,4.0,-30.946699,-89.609596,1003.546875) || IsPlayerInRangeOfPoint(playerid,4.0,-25.132598,-139.066986,1003.546875))
				{
					SendClientMessage(playerid,light_green," You have bought an MP3. Type /mp3help for more info.");
					PlayerInfo[playerid][MP3] = 1;
					GivePlayerMoney(playerid,-MP3_PRICE);
					PlayerPlaySound(playerid,1054,0.0,0.0,0.0);
					return 1;
				}
				else if(IsPlayerInRangeOfPoint(playerid,4.0,-27.312299,-29.277599,1003.557250) || IsPlayerInRangeOfPoint(playerid,4.0,-26.691598,-55.714897,1003.546875))
				{
					SendClientMessage(playerid,light_green," You have bought an MP3. Type /mp3help for more info.");
					PlayerInfo[playerid][MP3] = 1;
					GivePlayerMoney(playerid,-MP3_PRICE);
					PlayerPlaySound(playerid,1054,0.0,0.0,0.0);
					return 1;
				}
				else
				{
		    		SendClientMessage(playerid,light_red," You must be at an 24/7 to buy an MP3!");
				}
			}
		}
		else if(PlayerInfo[playerid][MP3] == 1)
		{
		    SendClientMessage(playerid,light_red," You aleardy own an MP3!");
		}
		return 1;
	}
	if (strcmp("/mp3help", cmdtext, true, 10) == 0)
	{
	    SendClientMessage(playerid,light_red," MP3 Help: If you bought an MP3, this tutorial will help you.");
	    SendClientMessage(playerid,light_red," MP3 Help: Your MP3 Battery will not be active very long time.");
	    SendClientMessage(playerid,light_red," MP3 Help: As an normal MP3, you need to charge it.");
	    SendClientMessage(playerid,light_red," MP3 Help: You can download your favorite songs by web.");
	    SendClientMessage(playerid,light_red," MP3 Help: Keep your MP3 good, so it will not be attacked by viruses.");
	    SendClientMessage(playerid,light_red," MP3 Help: If your MP3 is virused, you must buy an anti-virus.");
	    
	    SendClientMessage(playerid,light_green," MP3 Commands: tacks, /charge, /mp3on,");
	    SendClientMessage(playerid,light_green," MP3 Commands: /mp3off, /stoptrack, /sellmp3tp,");
	    SendClientMessage(playerid,light_green," MP3 Commands: /sellmp3ts, /buyantivirus, /lisentracks.");
	    return 1;
	}
	if(strcmp(cmd, "/mp3on", true) == 0)
	{
	    if(PlayerInfo[playerid][MP3] == 0)
	    {
	        SendClientMessage(playerid,light_red," You don't have an MP3 to turn it on.");
	        return 1;
		}
		else if(PlayerInfo[playerid][MP3] == 1)
		{
		    if(PlayerInfo[playerid][MP3On] == 1)
		    {
		        SendClientMessage(playerid,light_red," Your MP3 is aleady turned On.");
		        return 1;
			}
			else if(PlayerInfo[playerid][MP3On] == 0)
			{
			    if(PlayerInfo[playerid][BatteryLow] == 1)
			    {
			        SendClientMessage(playerid,light_red," Your MP3 battery is to low to be turned on.");
			        SendClientMessage(playerid,light_red," Charge it by using /charge.");
			        return 1;
				}
				else if(PlayerInfo[playerid][BatteryLow] == 0)
			    {
			    	SendClientMessage(playerid,light_green," Turning the MP3 On...Complete...");
			    	PlayerInfo[playerid][MP3On] = 1;
					charge = SetTimerEx("NeedCharge",1200000,0,"%d",playerid);//
					PlayerPlaySound(playerid,1054,0.0,0.0,0.0);
				}
			}
			return 1;
		}
		return 1;
	}
	if(strcmp(cmd, "/mp3off", true) == 0)
	{
	    if(PlayerInfo[playerid][MP3] == 0)
	    {
	        SendClientMessage(playerid,light_red," You don't have an MP3 to turn it off.");
	        return 1;
		}
		else if(PlayerInfo[playerid][MP3] == 1)
		{
		    if(PlayerInfo[playerid][MP3On] == 0)
		    {
		        SendClientMessage(playerid,light_red," Your MP3 is aleady turned Off.");
		        return 1;
			}
			else if(PlayerInfo[playerid][MP3On] == 1)
			{
			    SendClientMessage(playerid,light_green," Turning the MP3 Off...Complete...");
			    PlayerInfo[playerid][MP3On] = 0;
			    KillTimer(charge);
			    PlayerPlaySound(playerid,1054,0.0,0.0,0.0);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/charge", true) == 0)
	{
	    if(PlayerInfo[playerid][MP3] == 0)
	    {
	        SendClientMessage(playerid,light_red," You don't have an MP3 to charge it.");
	        return 1;
		}
		else if(PlayerInfo[playerid][MP3] == 1)
		{
		    if(PlayerInfo[playerid][MP3On] == 1)
		    {
		        SendClientMessage(playerid,light_red," MP3 must be turned off while charging.");
		        return 1;
			}
			else if(PlayerInfo[playerid][MP3On] == 0)
			{
			    SendClientMessage(playerid,light_green," Charge...In 1 minute, MP3 is charged.");
			    PlayerInfo[playerid][MP3On] = 0;
			    KillTimer(charge);
				SetTimerEx("ChargeOff",60000,0,"%d",playerid);
				PlayerPlaySound(playerid,1054,0.0,0.0,0.0);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/lisentracks", true) == 0)
	{
	    if(PlayerInfo[playerid][MP3] == 0)
	    {
	         SendClientMessage(playerid,light_red," Your don't have an MP3.");
	         return 1;
		}
		else if(PlayerInfo[playerid][MP3] == 1)
		{
		    if(PlayerInfo[playerid][MP3On] == 0)
		    {
		        SendClientMessage(playerid,light_red," You must turn your MP3 On.");
		        return 1;
			}
			else if(PlayerInfo[playerid][MP3On] == 1)
			{
	    		new Tracks[] = "1\tGoGo Space Monkey Track\n2\tBee Track\n3\tDual Track\n4\tAward Track\n5\tDriving Award\n6\tBike Award\n6\tPilot Award";
 				ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST,"Tracks",Tracks,"Play","Cancel");
 				return 1;
			}
			else if(VirusTaked[playerid] == 1)
			{
			    SendClientMessage(playerid,light_red," Your MP3 is virused. Buy an Anti-Virus.");
			}
			return 1;
		}
 		return 1;
	}
	if(strcmp(cmd, "/stoptrack", true) == 0)
	{
	    if(VirusTaked[playerid] == 0)
	    {
			if(PlayerInfo[playerid][MP3] == 0)
	    	{
	         	SendClientMessage(playerid,light_red," Your don't have an MP3.");
	         	return 1;
			}
			else if(PlayerInfo[playerid][MP3] == 1)
			{
		    	if(PlayerInfo[playerid][MP3On] == 0)
		    	{
		        	SendClientMessage(playerid,light_red," You must turn your MP3 On.");
		        	return 1;
				}
				else if(PlayerInfo[playerid][MP3On] == 1)
				{
			    	if(PlayerInfo[playerid][GoGoMonkey] == 1)
			    	{
			        	PlayerPlaySound(playerid,1063,0.0,0.0,0.0);
			        	SendClientMessage(playerid,light_green," Track Stoped.");
			        	new Tracks[] = "1\tGoGo Space Monkey Track\n2\tBee Track\n3\tDual Track\n4\tAward Track\n5\tDriving Award\n6\tBike Award\n6\tPilot Award";
 						ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST,"Tracks",Tracks,"Play","Cancel");
					}
					else if(PlayerInfo[playerid][Bee] == 1)
			    	{
			        	PlayerPlaySound(playerid,1077,0.0,0.0,0.0);
			        	SendClientMessage(playerid,light_green," Track Stoped.");
			        	new Tracks[] = "1\tGoGo Space Monkey Track\n2\tBee Track\n3\tDual Track\n4\tAward Track\n5\tDriving Award\n6\tBike Award\n6\tPilot Award";
 						ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST,"Tracks",Tracks,"Play","Cancel");
					}
					else if(PlayerInfo[playerid][Dual] == 1)
			    	{
			        	PlayerPlaySound(playerid,1069,0.0,0.0,0.0);
			        	SendClientMessage(playerid,light_green," Track Stoped.");
			        	new Tracks[] = "1\tGoGo Space Monkey Track\n2\tBee Track\n3\tDual Track\n4\tAward Track\n5\tDriving Award\n6\tBike Award\n6\tPilot Award";
 						ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST,"Tracks",Tracks,"Play","Cancel");
					}
					else if(PlayerInfo[playerid][Award] == 1)
			    	{
			      	  	PlayerPlaySound(playerid,1098,0.0,0.0,0.0);
			       	 	SendClientMessage(playerid,light_green," Track Stoped.");
			       	 	new Tracks[] = "1\tGoGo Space Monkey Track\n2\tBee Track\n3\tDual Track\n4\tAward Track\n5\tDriving Award\n6\tBike Award\n6\tPilot Award";
 						ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST,"Tracks",Tracks,"Play","Cancel");
					}
					else if(PlayerInfo[playerid][AwardDriving] == 1)
			    	{
			        	PlayerPlaySound(playerid,1184,0.0,0.0,0.0);
			        	SendClientMessage(playerid,light_green," Track Stoped.");
			        	new Tracks[] = "1\tGoGo Space Monkey Track\n2\tBee Track\n3\tDual Track\n4\tAward Track\n5\tDriving Award\n6\tBike Award\n6\tPilot Award";
 						ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST,"Tracks",Tracks,"Play","Cancel");
					}
					else if(PlayerInfo[playerid][AwardBike] == 1)
			    	{
			        	PlayerPlaySound(playerid,1186,0.0,0.0,0.0);
			        	SendClientMessage(playerid,light_green," Track Stoped.");
			        	new Tracks[] = "1\tGoGo Space Monkey Track\n2\tBee Track\n3\tDual Track\n4\tAward Track\n5\tDriving Award\n6\tBike Award\n6\tPilot Award";
 						ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST,"Tracks",Tracks,"Play","Cancel");
					}
					else if(PlayerInfo[playerid][AwardPilot] == 1)
			    	{
			        	PlayerPlaySound(playerid,1188,0.0,0.0,0.0);
			        	SendClientMessage(playerid,light_green," Track Stoped.");
			        	new Tracks[] = "1\tGoGo Space Monkey Track\n2\tBee Track\n3\tDual Track\n4\tAward Track\n5\tDriving Award\n6\tBike Award\n6\tPilot Award";
 						ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST,"Tracks",Tracks,"Play","Cancel");
					}
				}
 				return 1;
			}
			else if(VirusTaked[playerid] == 1)
			{
			    SendClientMessage(playerid,light_red," Your MP3 is virused. Buy an Anti-Virus.");
			}
			return 1;
		}
 		return 1;
	}
	if(strcmp(cmd, "/sellmp3tp", true) == 0)
	{
	    if (PlayerInfo[playerid][MP3] == 1)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, light_red, "Use: /sellmp3tp [playername/id]");
				return 1;
			}

			new giveplayerid = ReturnUser(tmp);
			if(giveplayerid != INVALID_PLAYER_ID)
			{
			    if(PlayerInfo[giveplayerid][MP3] == 0)
			    {
			    	GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string,sizeof(string)," You have sell %s an MP3 for 100$.",giveplayer);
					SendClientMessage(playerid,light_red,string);
					format(string,sizeof(string)," You have recive an MP3 from %s. Cost: 100$",sendername);
					SendClientMessage(playerid,light_red,string);
					PlayerPlaySound(playerid,1054,0.0,0.0,0.0);
					PlayerPlaySound(giveplayerid,1054,0.0,0.0,0.0);
					PlayerInfo[playerid][MP3] = 0;
					PlayerInfo[giveplayerid][MP3] = 1;
					GivePlayerMoney(playerid,MP3_PRICE);
					GivePlayerMoney(giveplayerid,-MP3_PRICE);
					return 1;
				}
				else if(PlayerInfo[giveplayerid][MP3] == 0)
			    {
			        SendClientMessage(playerid, light_red, "That Player gots an MP3.");
			        return 1;
				}
			}
			else if(giveplayerid == INVALID_PLAYER_ID)
			{
				format(string, sizeof(string), "%d is not an active player...", giveplayerid);
				SendClientMessage(playerid, light_red, string);
				return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, light_red, "You don't have an MP3 to sell it...");
		}
		return 1;
	}
	if (strcmp("/sellmp3ts", cmdtext, true, 10) == 0)
	{
	    if(PlayerInfo[playerid][MP3] == 1)
	    {
   			if(IsPlayerInRangeOfPoint(playerid,4.0,-25.884498,-185.868988,1003.546875) || IsPlayerInRangeOfPoint(playerid,4.0,6.091179,-29.271898,1003.549438))
	    	{
				SendClientMessage(playerid,light_green," You have sell your MP3 for 100$.");
				PlayerInfo[playerid][MP3] = 0;
				GivePlayerMoney(playerid,MP3_PRICE);
				PlayerPlaySound(playerid,1054,0.0,0.0,0.0);
				return 1;
			}
			else if(IsPlayerInRangeOfPoint(playerid,4.0,-30.946699,-89.609596,1003.546875) || IsPlayerInRangeOfPoint(playerid,4.0,-25.132598,-139.066986,1003.546875))
			{
				SendClientMessage(playerid,light_green," You have sell your MP3 for 100$.");
				PlayerInfo[playerid][MP3] = 0;
				GivePlayerMoney(playerid,MP3_PRICE);
				PlayerPlaySound(playerid,1054,0.0,0.0,0.0);
				return 1;
			}
			else if(IsPlayerInRangeOfPoint(playerid,4.0,-27.312299,-29.277599,1003.557250) || IsPlayerInRangeOfPoint(playerid,4.0,-26.691598,-55.714897,1003.546875))
			{
				SendClientMessage(playerid,light_green," You have sell your MP3 for 100$.");
				PlayerInfo[playerid][MP3] = 0;
				GivePlayerMoney(playerid,MP3_PRICE);
				PlayerPlaySound(playerid,1054,0.0,0.0,0.0);
				return 1;
			}
			else
			{
		    	SendClientMessage(playerid,light_red," You must be at an 24/7 to buy an MP3!");
			}
		}
		else if(PlayerInfo[playerid][MP3] == 0)
		{
		    SendClientMessage(playerid,light_red," You don't have an MP3 to sell it!");
		}
	}
	if (strcmp("/buyantivirus", cmdtext, true, 10) == 0)
	{
	    if(PlayerInfo[playerid][AntiVirus] == 0)
	    {
	        if(GetPlayerMoney(playerid) >= ANTIVIRUS_PRICE)
	        {
	    		if(IsPlayerInRangeOfPoint(playerid,4.0,-25.884498,-185.868988,1003.546875) || IsPlayerInRangeOfPoint(playerid,4.0,6.091179,-29.271898,1003.549438))
	    		{
					SendClientMessage(playerid,light_green," You have bought an Anti-Virus. Type /mp3help for more info.");
					PlayerInfo[playerid][AntiVirus] = 1;
					GivePlayerMoney(playerid,-ANTIVIRUS_PRICE);
					PlayerPlaySound(playerid,1054,0.0,0.0,0.0);
					return 1;
				}
				else if(IsPlayerInRangeOfPoint(playerid,4.0,-30.946699,-89.609596,1003.546875) || IsPlayerInRangeOfPoint(playerid,4.0,-25.132598,-139.066986,1003.546875))
				{
					SendClientMessage(playerid,light_green," You have bought an Anti-Virus. Type /mp3help for more info.");
					PlayerInfo[playerid][AntiVirus] = 1;
					GivePlayerMoney(playerid,-ANTIVIRUS_PRICE);
					PlayerPlaySound(playerid,1054,0.0,0.0,0.0);
					return 1;
				}
				else if(IsPlayerInRangeOfPoint(playerid,4.0,-27.312299,-29.277599,1003.557250) || IsPlayerInRangeOfPoint(playerid,4.0,-26.691598,-55.714897,1003.546875))
				{
					SendClientMessage(playerid,light_green," You have bought an Anti-Virus. Type /mp3help for more info.");
					PlayerInfo[playerid][AntiVirus] = 1;
					GivePlayerMoney(playerid,-ANTIVIRUS_PRICE);
					PlayerPlaySound(playerid,1054,0.0,0.0,0.0);
					return 1;
				}
				else
				{
		    		SendClientMessage(playerid,light_red," You must be at an 24/7 to buy an MP3!");
				}
				return 1;
			}
			else if(GetPlayerMoney(playerid) < ANTIVIRUS_PRICE)
			{
			    SendClientMessage(playerid,light_red," You don't have the money...");
			}
			return 1;
		}
		else if(PlayerInfo[playerid][AntiVirus] == 1)
		{
		    SendClientMessage(playerid,light_red," You aleardy have an AntiVirus!");
		}
	}
	if (strcmp("/downloadtracks", cmdtext, true, 10) == 0)
	{
		if(VirusTaked[playerid] == 0)
		{
	    	SendClientMessage(playerid,light_green," Searching On Web...Please Wait...");
	    	SetTimerEx("WebMusic",6000,0,"%d",playerid);
	    	WebSearching[playerid] = 1;
	    	return 1;
		}
		else if(VirusTaked[playerid] == 1)
		{
		    SendClientMessage(playerid,light_green," You can't search on web due from a virus.");
		}
		return 1;
	}
	return 0;
}
public ChargeOff(playerid)
{
	SendClientMessage(playerid,light_green," Charge Completed. You may turn on your MP3.");
	charge = SetTimerEx("NeedCharge",1200000,0,"%d",playerid);
	PlayerInfo[playerid][BatteryLow] = 0;
	return 1;
}
public NeedCharge(playerid)
{
	SendClientMessage(playerid,light_red," Your MP3 battery is low. Charge it by using /charge.");
	PlayerInfo[playerid][MP3On] = 0;
	PlayerInfo[playerid][BatteryLow] = 1;
	return 1;
}
public WebMusic(playerid)
{
	new tracks[] = "1\tGoGo Space Monkey Track\n2\tBee Track\n3\tDual Track\n4\tAward Track\n5\tDriving Award\n6\tBike Award\n6\tPilot Award";
 	ShowPlayerDialog(playerid,1,DIALOG_STYLE_LIST,"8 Results was found",tracks,"Download","Cancel");
 	return 1;
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

public OnPlayerRequestSpawn(playerid)
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

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
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

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
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
	new string[248];
    if(dialogid == 1)
	{
	    if(response)
		{
		    if(listitem == 0)
		    {
		        if(PlayerInfo[playerid][GoGoMonkey] == 0)
		        {
		        	format(string,sizeof(string)," Download 'GoGo Space Monkey Track' is in progres...");
		        	SendClientMessage(playerid,light_green,string);
		        	SetTimerEx("RandomiseF",6000,0,"%d",playerid);
		        	return 1;
				}
				else if(PlayerInfo[playerid][GoGoMonkey] == 1)
				{
				    format(string,sizeof(string)," You aleady have this track...");
		        	SendClientMessage(playerid,light_green,string);
		        	WebSearching[playerid] = 0;
				}
				return 1;
			}
			else if(listitem == 1)
		    {
		        if(PlayerInfo[playerid][Bee] == 0)
		        {
		        	format(string,sizeof(string)," Download 'Bee Track' is in progres...");
		        	SendClientMessage(playerid,light_green,string);
		        	SetTimerEx("RandomiseB",6000,0,"%d",playerid);
		        	return 1;
				}
				else if(PlayerInfo[playerid][Bee] == 1)
				{
				    format(string,sizeof(string)," You aleady have this track...");
		        	SendClientMessage(playerid,light_green,string);
		        	WebSearching[playerid] = 0;
				}
				return 1;
			}
			else if(listitem == 2)
		    {
		        if(PlayerInfo[playerid][Dual] == 0)
		        {
		        	format(string,sizeof(string)," Download 'Dual Track' is in progres...");
		        	SendClientMessage(playerid,light_green,string);
		        	SetTimerEx("RandomiseC",6000,0,"%d",playerid);
		        	return 1;
				}
				else if(PlayerInfo[playerid][Dual] == 1)
				{
				    format(string,sizeof(string)," You aleady have this track...");
		        	SendClientMessage(playerid,light_green,string);
		        	WebSearching[playerid] = 0;
				}
			}
			else if(listitem == 3)
		    {
		        if(PlayerInfo[playerid][Award] == 0)
		        {
		        	format(string,sizeof(string)," Download 'Award Track' is in progres...");
		        	SendClientMessage(playerid,light_green,string);
		        	SetTimerEx("RandomiseD",6000,0,"%d",playerid);
		        	return 1;
				}
				else if(PlayerInfo[playerid][Award] == 1)
				{
				    format(string,sizeof(string)," You aleady have this track...");
		        	SendClientMessage(playerid,light_green,string);
		        	WebSearching[playerid] = 0;
				}
				return 1;
			}
			else if(listitem == 4)
		    {
		        if(PlayerInfo[playerid][AwardDriving] == 0)
		        {
		        	format(string,sizeof(string)," Download 'Driving Award' is in progres...");
		        	SendClientMessage(playerid,light_green,string);
		        	SetTimerEx("RandomiseE",6000,0,"%d",playerid);
		        	return 1;
				}
				else if(PlayerInfo[playerid][AwardDriving] == 1)
				{
				    format(string,sizeof(string)," You aleady have this track...");
		        	SendClientMessage(playerid,light_green,string);
		        	WebSearching[playerid] = 0;
				}
				return 1;
			}
			else if(listitem == 5)
		    {
		        if(PlayerInfo[playerid][AwardBike] == 0)
		        {
		        	format(string,sizeof(string)," Download 'Bike Award' is in progres...");
		        	SendClientMessage(playerid,light_green,string);
		        	SetTimerEx("RandomiseF",6000,0,"%d",playerid);
		        	return 1;
				}
				else if(PlayerInfo[playerid][AwardBike] == 1)
				{
				    format(string,sizeof(string)," You aleady have this track...");
		        	SendClientMessage(playerid,light_green,string);
		        	WebSearching[playerid] = 0;
				}
				return 1;
			}
			else if(listitem == 6)
		    {
		        if(PlayerInfo[playerid][AwardPilot] == 0)
		        {
		        	format(string,sizeof(string)," Download 'Pilot Award' is in progres...");
		        	SendClientMessage(playerid,light_green,string);
		        	SetTimerEx("RandomiseG",6000,0,"%d",playerid);
		        	return 1;
				}
				else if(PlayerInfo[playerid][AwardPilot] == 1)
				{
				    format(string,sizeof(string)," You aleady have this track...");
		        	SendClientMessage(playerid,light_green,string);
		        	WebSearching[playerid] = 0;
				}
				return 1;
			}
		}
	}
	if(dialogid == 2)
	{
	    if(response)
		{
		    if(listitem == 0)
		    {
		        if(PlayerInfo[playerid][GoGoMonkey] == 0)
		        {
		            SendClientMessage(playerid,light_red," You don't have this Track...");
		            SendClientMessage(playerid,light_green," You can download it by /downloadtracks.");
		            return 1;
				}
				else if(PlayerInfo[playerid][GoGoMonkey] == 1)
				{
				    PlayerPlaySound(playerid,1062,0.0,0.0,0.0);
				    SendClientMessage(playerid,light_green," Type /stoptrack to stop the current track.");
				}
				return 1;
			}
			else if(listitem == 1)
		    {
		        if(PlayerInfo[playerid][Bee] == 0)
		        {
		            SendClientMessage(playerid,light_red," You don't have this Track...");
		            SendClientMessage(playerid,light_green," You can download it by /downloadtracks.");
		            return 1;
				}
				else if(PlayerInfo[playerid][Bee] == 1)
				{
				    PlayerPlaySound(playerid,1076,0.0,0.0,0.0);
				    SendClientMessage(playerid,light_green," Type /stoptrack to stop the current track.");
				}
				return 1;
			}
			else if(listitem == 2)
		    {
		        if(PlayerInfo[playerid][Dual] == 0)
		        {
		            SendClientMessage(playerid,light_red," You don't have this Track...");
		            SendClientMessage(playerid,light_green," You can download it by /downloadtracks.");
		            return 1;
				}
				else if(PlayerInfo[playerid][Dual] == 1)
				{
				    PlayerPlaySound(playerid,1068,0.0,0.0,0.0);
				    SendClientMessage(playerid,light_green," Type /stoptrack to stop the current track.");
				}
				return 1;
			}
			else if(listitem == 3)
		    {
		        if(PlayerInfo[playerid][Award] == 0)
		        {
		            SendClientMessage(playerid,light_red," You don't have this Track...");
		            SendClientMessage(playerid,light_green," You can download it by /downloadtracks.");
		            return 1;
				}
				else if(PlayerInfo[playerid][Award] == 1)
				{
				    PlayerPlaySound(playerid,1097,0.0,0.0,0.0);
				    SendClientMessage(playerid,light_green," Type /stoptrack to stop the current track.");
				}
				return 1;
			}
			else if(listitem == 4)
		    {
		        if(PlayerInfo[playerid][AwardDriving] == 0)
		        {
		            SendClientMessage(playerid,light_red," You don't have this Track...");
		            SendClientMessage(playerid,light_green," You can download it by /downloadtracks.");
		            return 1;
				}
				else if(PlayerInfo[playerid][AwardDriving] == 1)
				{
				    PlayerPlaySound(playerid,1183,0.0,0.0,0.0);
				    SendClientMessage(playerid,light_green," Type /stoptrack to stop the current track.");
				}
				return 1;
			}
			else if(listitem == 5)
		    {
		        if(PlayerInfo[playerid][AwardBike] == 0)
		        {
		            SendClientMessage(playerid,light_red," You don't have this Track...");
		            SendClientMessage(playerid,light_green," You can download it by /downloadtracks.");
		            return 1;
				}
				else if(PlayerInfo[playerid][AwardBike] == 1)
				{
				    PlayerPlaySound(playerid,1185,0.0,0.0,0.0);
				    SendClientMessage(playerid,light_green," Type /stoptrack to stop the current track.");
				}
				return 1;
			}
			else if(listitem == 6)
		    {
		        if(PlayerInfo[playerid][AwardPilot] == 0)
		        {
		            SendClientMessage(playerid,light_red," You don't have this Track...");
		            SendClientMessage(playerid,light_green," You can download it by /downloadtracks.");
		            return 1;
				}
				else if(PlayerInfo[playerid][AwardPilot] == 1)
				{
				    PlayerPlaySound(playerid,1187,0.0,0.0,0.0);
				    SendClientMessage(playerid,light_green," Type /stoptrack to stop the current track.");
				}
				return 1;
			}
		}
		return 1;
	}
	return 1;
}
public Randomise(playerid)
{
	new rand = random(MonkeyDownload);
	if(rand == 15)
	{
		if(PlayerInfo[playerid][AntiVirus] == 0)
		{
			VirusTaked[playerid] = 1;
			WebSearching[playerid] = 0;
		}
		else if(PlayerInfo[playerid][AntiVirus] == 1)
		{
		    SendClientMessage(playerid,light_green," AntiVirus: Virus Detected.Deleting the Virus...");
			SetTimerEx("VirusDeleted",10000,0,"%d",playerid);
			VirusTaked[playerid] = 1;
			WebSearching[playerid] = 0;
		}
	}
	else
	{
	    PlayerInfo[playerid][GoGoMonkey] = 1;
	    SendClientMessage(playerid,light_green," Track Successfully Downloaded.");
	    WebSearching[playerid] = 0;
	}
	return 1;
}
public RandomiseB(playerid)
{
	new rand = random(BeeDownload);
	if(rand == 15)
	{
		if(PlayerInfo[playerid][AntiVirus] == 0)
		{
			VirusTaked[playerid] = 1;
			WebSearching[playerid] = 0;
		}
		else if(PlayerInfo[playerid][AntiVirus] == 1)
		{
		    SendClientMessage(playerid,light_green," AntiVirus: Virus Detected.Deleting the Virus...");
			SetTimerEx("VirusDeleted",10000,0,"%d",playerid);
			VirusTaked[playerid] = 1;
			WebSearching[playerid] = 0;
		}
	}
	else
	{
	    PlayerInfo[playerid][Bee] = 1;
	    SendClientMessage(playerid,light_green," Track Successfully Downloaded.");
	    WebSearching[playerid] = 0;
	}
	return 1;
}
public RandomiseC(playerid)
{
	new rand = random(DualDownload);
	if(rand == 15)
	{
		if(PlayerInfo[playerid][AntiVirus] == 0)
		{
			VirusTaked[playerid] = 1;
			WebSearching[playerid] = 0;
		}
		else if(PlayerInfo[playerid][AntiVirus] == 1)
		{
		    SendClientMessage(playerid,light_green," AntiVirus: Virus Detected.Deleting the Virus...");
			SetTimerEx("VirusDeleted",10000,0,"%d",playerid);
			VirusTaked[playerid] = 1;
			WebSearching[playerid] = 0;
		}
	}
	else
	{
	    PlayerInfo[playerid][Dual] = 1;
	    SendClientMessage(playerid,light_green," Track Successfully Downloaded.");
	    WebSearching[playerid] = 0;
	}
	return 1;
}
public RandomiseD(playerid)
{
	new rand = random(AwardDownload);
	if(rand == 15)
	{
		if(PlayerInfo[playerid][AntiVirus] == 0)
		{
			VirusTaked[playerid] = 1;
			WebSearching[playerid] = 0;
		}
		else if(PlayerInfo[playerid][AntiVirus] == 1)
		{
		    SendClientMessage(playerid,light_green," AntiVirus: Virus Detected.Deleting the Virus...");
			SetTimerEx("VirusDeleted",10000,0,"%d",playerid);
			VirusTaked[playerid] = 1;
			WebSearching[playerid] = 0;
		}
	}
	else
	{
	    PlayerInfo[playerid][Award] = 1;
	    SendClientMessage(playerid,light_green," Track Successfully Downloaded.");
	    WebSearching[playerid] = 0;
	}
	return 1;
}
public RandomiseE(playerid)
{
	new rand = random(AwardDDownload);
	if(rand == 15)
	{
		if(PlayerInfo[playerid][AntiVirus] == 0)
		{
			VirusTaked[playerid] = 1;
			WebSearching[playerid] = 0;
		}
		else if(PlayerInfo[playerid][AntiVirus] == 1)
		{
		    SendClientMessage(playerid,light_green," AntiVirus: Virus Detected.Deleting the Virus...");
			SetTimerEx("VirusDeleted",10000,0,"%d",playerid);
			VirusTaked[playerid] = 1;
			WebSearching[playerid] = 0;
		}
	}
	else
	{
	    PlayerInfo[playerid][AwardDriving] = 1;
	    SendClientMessage(playerid,light_green," Track Successfully Downloaded.");
	    WebSearching[playerid] = 0;
	}
	return 1;
}
public RandomiseF(playerid)
{
	new rand = random(AwardBDownload);
	if(rand == 15)
	{
		if(PlayerInfo[playerid][AntiVirus] == 0)
		{
			VirusTaked[playerid] = 1;
			WebSearching[playerid] = 0;
		}
		else if(PlayerInfo[playerid][AntiVirus] == 1)
		{
		    SendClientMessage(playerid,light_green," AntiVirus: Virus Detected.Deleting the Virus...");
			SetTimerEx("VirusDeleted",10000,0,"%d",playerid);
			VirusTaked[playerid] = 1;
			WebSearching[playerid] = 0;
		}
	}
	else
	{
	    PlayerInfo[playerid][AwardBike] = 1;
	    SendClientMessage(playerid,light_green," Track Successfully Downloaded.");
	    WebSearching[playerid] = 0;
	}
	return 1;
}
public RandomiseG(playerid)
{
	new rand = random(AwardPDownload);
	if(rand == 15)
	{
		if(PlayerInfo[playerid][AntiVirus] == 0)
		{
			VirusTaked[playerid] = 1;
			WebSearching[playerid] = 0;
		}
		else if(PlayerInfo[playerid][AntiVirus] == 1)
		{
		    SendClientMessage(playerid,light_green," AntiVirus: Virus Detected.Deleting the Virus...");
			SetTimerEx("VirusDeleted",10000,0,"%d",playerid);
			VirusTaked[playerid] = 1;
			WebSearching[playerid] = 0;
		}
	}
	else
	{
	    PlayerInfo[playerid][AwardPilot] = 1;
	    SendClientMessage(playerid,light_green," Track Successfully Downloaded.");
	    WebSearching[playerid] = 0;
	}
	return 1;
}
public VirusDeleted(playerid)
{
    SendClientMessage(playerid,light_green," AntiVirus: Virus Deleted...");
    VirusTaked[playerid] = 0;
    return 1;
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
