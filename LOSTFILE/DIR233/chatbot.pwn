#include <a_samp>

//CONFIGURATION:
new BotName[30] = "Fluffy"; // The Bots Name
new BotAge[20] = "14"; //the Bots Age
#define BotColour 0xFFD720FF //The bots colour

#define ColourSync //COMMENT This in to DISABLE Colour sync, Colour sync makes GetPlayerColor work, if you have your own player colours, COMENT THIS OUT! Other wiseleave it!

new EmptyQuestionResponces[][] = { //The responses the bot gives if a player types 'Botname:' without a following question.
"Are you genna ask me something or not?",
"Asking something?",
"Comeon! If your genna ask something just ask!"
};


#define AgeQuestion "How Old Are you?" // The question a player needs to ask after 'botname: ' for the bot to tell the player its age.

new Sayings[][] = { // The different sayings the bot says if a user types 'Botname' or 'Botname?'.
"Yes?",
"Go Away...",
"Can i help you?",
"Hello :)",
"Sorry, im busy..."
};

new Answers[][] = { // Answers to questions
"Yes",
"No",
"Maybe",
"I dunno, who do you think i am? jesus?",
"Ask again later, im busy"
};

#define RandomSpeech // COMMENT THIS OUT TO STOP RANDOM SPEECH
#define RandomSayTime 300000 // 5 minutes, change to what you want, 1 minute = 60000 MS

new RandomStuff[][] = { //Things that the bot says every 5 minutes (defualt)
"I Like Cakes",
"Im a BOT! :O",
"Everyone Loves me."
};

new TalkingAboutMe[][] = { //Things that the bot says if it detects its name being said.
"Are you talking about me?",
"Talking about me now are we?",
"Yes i know everyone loves me but you dont have to talk about me all the time!"
};

// END OF CONFIGURATION!!! Only edit below this line if you know what your doing!!

#define COLOR_YELLOW 0x33AA33FF
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_BRIGHTRED 0xFF0000AA
#define COLOR_WHITE 0xFFFFFFAA

new String[MAX_PLAYERS][200];
new BotOn = 1;
forward Send(playerid);
forward Random();
forward ColourSet(playerid);

new PlayerColours[] = {
0xFF8C13FF, // dark orange
0xC715FFFF, // Medium violet red
0x20B2AAFF, // sea green
0xDC143CFF, // crimson
0x6495EDFF, // cornflower blue
0xf0e68cFF, // khaki
0x778899FF, // light slate grey
0xFF1493FF, // deeppink
0xF4A460FF, // sandy
0xEE82EEFF, // violet
0xFFD720FF, // gold
0x8b4513FF, // chocolate
0x4949A0FF, // midnight blue
0x148b8bFF, // dark cyan
0x14ff7fFF, // spring green
0x556b2fFF,  // olive green
0x0FD9FAFF,
0x10DC29FF,
0x534081FF,
0x0495CDFF,
0xEF6CE8FF,
0xBD34DAFF,
0x247C1BFF,
0x0C8E5DFF,
0x635B03FF,
0xCB7ED3FF,
0x65ADEBFF,
0x5C1ACCFF,
0xF2F853FF,
0x11F891FF,
0x7B39AAFF,
0x53EB10FF,
0x54137DFF,
0x275222FF,
0xF09F5BFF,
0x3D0A4FFF,
0x22F767FF,
0xD63034FF,
0x9A6980FF,
0xDFB935FF,
0x3793FAFF,
0x90239DFF,
0xE9AB2FFF,
0xAF2FF3FF,
0x057F94FF,
0xB98519FF,
0x388EEAFF,
0x028151FF,
0xA55043FF,
0x0DE018FF,
0x93AB1CFF,
0x95BAF0FF,
0x369976FF,
0x18F71FFF,
0x4B8987FF,
0x491B9EFF,
0x829DC7FF,
0xBCE635FF,
0xCEA6DFFF,
0x20D4ADFF,
0x2D74FDFF,
0x3C1C0DFF,
0x12D6D4FF,
0x48C000FF,
0x2A51E2FF,
0xE3AC12FF,
0xFC42A8FF,
0x2FC827FF,
0x1A30BFFF,
0xB740C2FF,
0x42ACF5FF,
0x2FD9DEFF,
0xFAFB71FF,
0x05D1CDFF,
0xC471BDFF,
0x94436EFF,
0xC1F7ECFF,
0xCE79EEFF,
0xBD1EF2FF,
0x93B7E4FF,
0x3214AAFF,
0x184D3BFF,
0xAE4B99FF,
0x7E49D7FF,
0x4C436EFF,
0xFA24CCFF,
0xCE76BEFF,
0xA04E0AFF,
0x9F945CFF,
0xDCDE3DFF,
0x10C9C5FF,
0x70524DFF,
0x0BE472FF,
0x8A2CD7FF,
0x6152C2FF,
0xCF72A9FF,
0xE59338FF,
0xEEDC2DFF,
0xD8C762FF,
0x3FE65CFF
};

#define FILTERSCRIPT

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n-----------------------------");
	print("Chat Bot 0.2 Beta by DragSta");
	print("-----------------------------\n");
	print("__ Bot Configuration __");
	print("----------------------------");
	printf("Bot Name: %s", BotName);
	print("----------------------------");
	printf("Bot Age: %s", BotAge);
	print("----------------------------");
	print("Responces to empty questions:");
	for(new resp; resp < sizeof(EmptyQuestionResponces); resp++)
	{
	    printf("%s", EmptyQuestionResponces[resp]);
	}
	print("----------------------------");
	print("Bot Sayings:");
	for(new Say; Say < sizeof(Sayings); Say++)
	{
	    printf("%s", Sayings[Say]);
	}
	print("----------------------------");
	print("Bot Answers:");
	for(new ans; ans < sizeof(Answers); ans++)
	{
	    printf("%s", Answers[ans]);
	}
	print("----------------------------");
	print("'Talking about me' responses:");
	for(new Talking; Talking < sizeof(TalkingAboutMe); Talking++)
	{
	    printf("%s", TalkingAboutMe[Talking]);
	}
	print("----------------------------");
	#if defined RandomSpeech
	print("Random Speech: Enabled");
	print("Random Speech:");
	for(new Ran; Ran < sizeof(RandomStuff); Ran++)
	{
	    printf("%s", RandomStuff[Ran]);
	}
	print("----------------------------\n");
	SetTimer("Random", RandomSayTime, 1);
	#else
	print("Random Speech: Disabled");
	print("----------------------------\n");
	#endif
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

#endif

public OnGameModeInit()
{
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	#if defined ColourSync
	SetTimerEx("ColourSet",1000,0,"i", playerid);
	#endif
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
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
	new BotStr1[200];
	format(BotStr1, sizeof(BotStr1), "%s?", BotName);
	new BotStr2[200];
	format(BotStr2, sizeof(BotStr2), "%s:", BotName);
	new BotStr3[200];
	format(BotStr3, sizeof(BotStr3), "%s: %s", BotName, AgeQuestion);
	
	if(strcmp(BotName, text, true) == 0)
	{
		if(BotOn == 1)
		{
	    	new Name[MAX_PLAYER_NAME];
	    	GetPlayerName(playerid, Name, sizeof(Name));
	    	format(String[playerid], 200, "%s, %s", Name, Sayings[random(sizeof(Sayings))]);
	    	//SetTimerEx("Send",170,0,"i", playerid, String[playerid]);
	    	SetTimerEx("Send",170,0,"i", playerid);
	    	return 1;
		}
	}
	else if(strcmp(BotStr1, text, true) == 0)
	{
		if(BotOn == 1)
		{
			new Name[MAX_PLAYER_NAME];
	    	GetPlayerName(playerid, Name, sizeof(Name));
	    	format(String[playerid], 200, "%s, %s", Name, Sayings[random(sizeof(Sayings))]);
	    	//SetTimerEx("Send",170,0,"i", playerid, String[playerid]);
	    	SetTimerEx("Send",170,0,"i", playerid);
	    	return 1;
		}
	}
	else if(strcmp(BotStr3, text, true) == 0)
	{
		if(BotOn == 1)
		{
			new Name[MAX_PLAYER_NAME];
	    	GetPlayerName(playerid, Name, sizeof(Name));
	    	format(String[playerid], 200, "%s, i am %d years old.", Name, BotAge);
	    	//SetTimerEx("Send",170,0,"i", playerid, String[playerid]);
	    	SetTimerEx("Send",170,0,"i", playerid);
	    	return 1;
		}
	}
	else if(strfind(text, BotStr2, true) != -1 && strfind(text, "?", true, 0) != -1)
	{
		if(BotOn == 1)
		{
			new Name[MAX_PLAYER_NAME];
	    	GetPlayerName(playerid, Name, sizeof(Name));
	    	format(String[playerid], 200, "%s, %s", Name, Answers[random(sizeof(Sayings))]);
	    	//SetTimerEx("Send",170,0,"i", playerid, String[playerid]);
	    	SetTimerEx("Send",170,0,"i", playerid);
	    	return 1;
		}
	}
	else if(strcmp(BotStr2, text, true) == 0)
	{
		if(BotOn == 1)
		{
			new Name[MAX_PLAYER_NAME];
	    	GetPlayerName(playerid, Name, sizeof(Name));
	    	format(String[playerid], 200, "Errrm %s, %s", Name, EmptyQuestionResponces[random(sizeof(EmptyQuestionResponces))]);
	    	//SetTimerEx("Send",170,0,"i", playerid, String[playerid]);
	    	SetTimerEx("Send",170,0,"i", playerid);
	    	return 1;
		}
	}
	else if(strfind(text, BotName, true) != -1)
	{
		if(BotOn == 1)
		{
			new Name[MAX_PLAYER_NAME];
	    	GetPlayerName(playerid, Name, sizeof(Name));
	    	format(String[playerid], 200, "%s, %s", Name, TalkingAboutMe[random(sizeof(TalkingAboutMe))] );
	    	//SetTimerEx("Send",170,0,"i", playerid, String[playerid]);
	    	SetTimerEx("Send",170,0,"i", playerid);
	    	return 1;
		}
	}
	return 1;
}

public OnPlayerPrivmsg(playerid, recieverid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new tmp[256];
 	new idx;
 	new cmd[256];
	cmd = strtok(cmdtext, idx);
	
	if (strcmp("/bothelp", cmdtext, true, 10) == 0)
	{
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "__ Bot Help __");
		SendClientMessage(playerid, COLOR_YELLOW, "This server is equiped with a chat bot.");
		SendClientMessage(playerid, COLOR_YELLOW, "You can ask it questions by saying 'botname: Question?'");
		SendClientMessage(playerid, COLOR_YELLOW, "If you just say the bots name it will respond, and if you talk about it, it will also respond.");
		SendClientMessage(playerid, COLOR_WHITE, "The Bot system was created by DragSta");// do NOT Remove this line!
		return 1;
	}

	if(strcmp(cmd, "/bot", true) == 0)
	{
 		new botcmd;
		tmp = strtok(cmdtext, idx);
		if(!IsPlayerAdmin(playerid))
		{
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Admins Only!");
			return 1;
		}
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /bot [name/age/say/raw/toggle]");
			return 1;
		}

		if(strcmp(tmp, "name", true)==0)
		    botcmd = 1;
		else if(strcmp(tmp, "say", true)==0)
		    botcmd = 2;
		else if(strcmp(tmp, "raw", true)==0)
		    botcmd = 3;
		else if(strcmp(tmp, "toggle", true)==0)
		    botcmd = 4;
		else if(strcmp(tmp, "age", true)==0)
		    botcmd = 5;

		tmp = strtok(cmdtext, idx);
		if(botcmd < 6 && !strlen(tmp)) {
		    if(botcmd==0)
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /bot [name/say/raw/toggle]");
			else if(botcmd==1)
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /bot [name] [name]");
			else if(botcmd==2)
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /bot [say] [msg]");
			else if(botcmd==3)
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /bot [raw] [raw data]");
			else if(botcmd==4)
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /bot [toggle] [on | off]");
			else if(botcmd==5)
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /bot [age] [age]");
			return 1;
		}

		
		if(botcmd==1)//Bot Name
		{
			if(BotOn == 0)
			{
				SendClientMessage(playerid, COLOR_WHITE, "The Bot is turned off so you cannot use this CMD.");
				return 1;
			}
			new Thing[200], Name[MAX_PLAYER_NAME];
			GetPlayerName(playerid, Name, sizeof(Name));
			format(Thing, sizeof(Thing), "%s has changed the servers bot name from %s to %s", Name, BotName, tmp);
			SendClientMessageToAll(COLOR_YELLOW, Thing);
			format(BotName, sizeof(BotName), "%s", tmp);
			return 1;
		} else if (botcmd==2)//Bot say
		{
			if(BotOn == 0)
			{
				SendClientMessage(playerid, COLOR_WHITE, "The Bot is turned off so you cannot use this CMD.");
				return 1;
			}
			SendBotMsg(playerid, cmdtext[9]);
			return 1;
		} else if (botcmd==3)//Bot raw
		{
			if(BotOn == 0)
			{
				SendClientMessage(playerid, COLOR_WHITE, "The Bot is turned off so you cannot use this CMD.");
				return 1;
			}
			SendBotRaw(playerid, cmdtext[9]);
			return 1;
		} else if (botcmd==4)//Bot toggle
		{
		    if(strcmp(tmp, "on", true) == 0)
		    {
		        if(BotOn == 1)
		        {
		        	SendClientMessage(playerid, COLOR_YELLOW, "The Bot is already switched on");
				}
				else
				{
				    BotOn = 1;
				    SendClientMessageToAll(COLOR_YELLOW, "The servers bot has been switched on!");
				}
			} else if(strcmp(tmp, "off", true) == 0)
			{
   				if(BotOn == 0)
		        {
		        	SendClientMessage(playerid, COLOR_YELLOW, "The Bot is already switched off");
				}
				else
				{
				    BotOn = 0;
				    SendClientMessageToAll(COLOR_YELLOW, "The servers bot has been switched Off!");
				}
			}
   		} else if (botcmd==5)//Bot age
		{
			if(BotOn == 0)
			{
				SendClientMessage(playerid, COLOR_WHITE, "The Bot is turned off so you cannot use this CMD.");
				return 1;
			}
			new Thing[200], Name[MAX_PLAYER_NAME];
			new AGE;
			AGE = strval(tmp);
			GetPlayerName(playerid, Name, sizeof(Name));
			format(Thing, sizeof(Thing), "%s has changed the bots age from %s to %d", Name, BotAge, AGE);
			SendClientMessageToAll(COLOR_YELLOW, Thing);
			format(BotAge, sizeof(BotAge), "%d", AGE);
			return 1;
		}
		return 1;
	}
	
	return 0;
}

public OnPlayerInfoChange(playerid)
{
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

public Send(playerid)
{
	SendBotMsg(playerid, String[playerid]);
}

stock SendBotMsg(senderid, const Strr[])
{
	if(BotOn == 0)
	{
		SendClientMessage(senderid, COLOR_WHITE, "The Bot is turned off so you cannot use this CMD.");
	}
	new Name[MAX_PLAYER_NAME];
	new Colour = GetPlayerColor(senderid);
	SetPlayerColor(senderid, BotColour);
	GetPlayerName(senderid, Name, sizeof(Name));
	SetPlayerName(senderid, BotName);
	SendPlayerMessageToAll(senderid, Strr);
	SetPlayerName(senderid, Name);
	SetPlayerColor(senderid, Colour);
}

stock SendBotRaw(senderid, const Strr[])
{
	if(BotOn == 0)
	{
		SendClientMessage(senderid, COLOR_WHITE, "The Bot is turned off so you cannot use this CMD.");
	}
	new Name[MAX_PLAYER_NAME];
	GetPlayerName(senderid, Name, sizeof(Name));
	SetPlayerName(senderid, BotName);
	CallRemoteFunction("OnPlayerCommandText","is",senderid,Strr);
	SetPlayerName(senderid, Name);
}

public Random()
{
	if(IsPlayerConnected(0))
	{
	    SendBotMsg(0,RandomStuff[random(sizeof(RandomStuff))]);
	} else if(IsPlayerConnected(1))
	{
	    SendBotMsg(1,RandomStuff[random(sizeof(RandomStuff))]);
	} else if(IsPlayerConnected(2))
	{
	    SendBotMsg(2,RandomStuff[random(sizeof(RandomStuff))]);
	} else if(IsPlayerConnected(3))
	{
	    SendBotMsg(3,RandomStuff[random(sizeof(RandomStuff))]);
	} else if(IsPlayerConnected(4))
	{
	    SendBotMsg(4,RandomStuff[random(sizeof(RandomStuff))]);
	} else if(IsPlayerConnected(1))
	{
	    SendBotMsg(5,RandomStuff[random(sizeof(RandomStuff))]);
	} else if(IsPlayerConnected(2))
	{
	    SendBotMsg(6,RandomStuff[random(sizeof(RandomStuff))]);
	} else if(IsPlayerConnected(3))
	{
	    SendBotMsg(7,RandomStuff[random(sizeof(RandomStuff))]);
	} else if(IsPlayerConnected(4))
	{
	    SendBotMsg(8,RandomStuff[random(sizeof(RandomStuff))]);
	}
}

public ColourSet(playerid)
{
	SetPlayerColor(playerid, PlayerColours[playerid]);
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


