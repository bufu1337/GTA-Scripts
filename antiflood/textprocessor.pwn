//*******************************************************************
//
//      Antiswear, antispam, antiadvertise script
//      By rmf aka Osama bin Laden
//
//*******************************************************************
//
//  in your /scriptfiles directory create a new directory: configfiles
//  here you have to place a text file: "UndecentWords.cfg" having
//  an undecent word on each line
//
//*******************************************************************

#include <a_samp>

#define white 0xFFFFFFFF
#define yellow 0xFFAA00FF
#define pink 0xFF00FFFF
#define red 0xFF1100FF
#define grey 0x908080FF

#define SPAM_MAX_MSGS 4
#define SPAM_TIMELIMIT 8 // SECONDS
#define SWEAR_MAX_MSGS 3
#define ADVERTISE_MAX_MSGS 2
#define CONFIGDIR "configfiles/"

forward FindIpPattern(playerid,const string[]);
forward FindStringWithOffset(buffer[],pattern[],offset);
forward IsSeparator(testCharacter);

new SUPRESS_PM_SWEARING_MESSAGE = true;
new UndecentWords[500][64];
new UndecentWordCount = 0;
new preWarning=false;
enum PlayerData
{
	SpamCount,
	SpamTime,
	SwearCount,
	AdvertiseCount
};
new PlayerInfo[MAX_PLAYERS][PlayerData];

public OnFilterScriptInit()
{
	print("\n--------------------------------------------------------------------------");
	print("     AntiAdvertise, antiswear, antispam script by rmf aka Osama bin Laden");
	//undecent words
	new File:uwfile;
	new string[64];
	if((uwfile = fopen(CONFIGDIR"UndecentWords.cfg",io_read)))
	{
		while(fread(uwfile,string))
		{
		    for(new i = 0, j = strlen(string); i < j; i++)
				if(string[i] == '\n' || string[i] == '\r')
					string[i] = '\0';
  			UndecentWords[UndecentWordCount] = string;
            UndecentWordCount++;
		}
		fclose(uwfile);
		printf("     %d Undecent Words Loaded", UndecentWordCount);
	}
	print("\n--------------------------------------------------------------------------");
	return 1;
}

public OnPlayerConnect(playerid)
{
	PlayerInfo[playerid][SpamCount] = 0;
	PlayerInfo[playerid][SpamTime] = 0;
	PlayerInfo[playerid][SwearCount] = 0;
	PlayerInfo[playerid][AdvertiseCount] = 0;
	return 1;
}

stock TimeStamp()
{
	new time = GetTickCount() / 1000;
	return time;
}

public OnPlayerText(playerid,text[])
{
	if(!IsPlayerConnected(playerid))
		return 0;
	new ver_string[256];
	strmid(ver_string, text, 0, strlen(text));
	if(FindIpPattern(playerid,ver_string))
	{
		new playerName[24];
		GetPlayerName(playerid,playerName,24);
		SendPlayerMessageToPlayer(playerid,playerid,text);
		PlayerInfo[playerid][AdvertiseCount]++;
		if(PlayerInfo[playerid][AdvertiseCount] > ADVERTISE_MAX_MSGS)
			Kick(playerid);
  		return 0;
	}

	if(PlayerInfo[playerid][SpamCount] == 0)
		PlayerInfo[playerid][SpamTime] = TimeStamp();

    PlayerInfo[playerid][SpamCount]++;
	if(TimeStamp() - PlayerInfo[playerid][SpamTime] > SPAM_TIMELIMIT)
	{ // Its OK your messages were far enough apart
		PlayerInfo[playerid][SpamCount] = 0;
		PlayerInfo[playerid][SpamTime] = TimeStamp();
	}
	else
		if(PlayerInfo[playerid][SpamCount] > SPAM_MAX_MSGS)
		{
			new playername[128];
 			GetPlayerName(playerid, playername, sizeof(playername));
			new string[64]; format(string,sizeof(string),"%s has been kicked (Flood/Spam Protection)", playername);
			SendClientMessageToAll(grey,string);
			print(string);
			Kick(playerid);
		}
		else
			if(PlayerInfo[playerid][SpamCount] == SPAM_MAX_MSGS)
			{
				if(preWarning)
					SendClientMessage(playerid,red,"Anti Spam Warning! DO NOT FLOOD! Next is a kick.");
			}
	new actualSwearCount=PlayerInfo[playerid][SwearCount];
	new playerSweared=false;
    new origString[512];
    new k;
    for(k=0; k<strlen(text); k++)
		origString[k]=text[k];
	origString[k]=0;
 	for(new s = 0; s < UndecentWordCount; s++)
    {
		new pos=-1;
		while((pos = FindStringWithOffset(text,UndecentWords[s],pos+1)) != -1)
		{
		    new goAhead=false;
		    if(pos==0) // beginning of text
		    {
		        if(strlen(text)==strlen(UndecentWords[s])) // it's the only word typed
		            goAhead=true;
				else // text has something else too
				{
				    if(IsSeparator(text[strlen(UndecentWords[s])])) // it's the thing we are looking for
						goAhead=true;
				}
		    }
		    else
		    {
		        if(pos==strlen(text)-strlen(UndecentWords[s])) // word is at the end f the text
		        {
		            if(IsSeparator(text[pos-1])) // it's the thing we are looking for
						goAhead=true;
		        }
		        else // word is included in the text
		        {
		            if( IsSeparator(text[pos-1]) && IsSeparator(text[pos+strlen(UndecentWords[s])]) ) // it's the thing we are looking for
		                goAhead=true;
		        }
		    }
			if(goAhead)
			{
			    playerSweared=true;
				for(new i = pos, j = pos + strlen(UndecentWords[s]); i < j; i++) text[i] = ' ';
				PlayerInfo[playerid][SwearCount]++;
			}
		}
	}
	if(PlayerInfo[playerid][SwearCount] > SWEAR_MAX_MSGS)
	{
		new playername[128];
		GetPlayerName(playerid, playername, sizeof(playername));
		new string[256];
		format(string,sizeof(string),"%s has been kicked for undecent language (Antiswear Protection)", playername);
		SendClientMessageToAll(red,string);
		print(string);
	    Kick(playerid);
		return 0;
	}
	if(actualSwearCount<PlayerInfo[playerid][SwearCount])
	{
			new string[256];
			new warningsLeft = SWEAR_MAX_MSGS-PlayerInfo[playerid][SwearCount];
			if(preWarning)
			{
				format(string,sizeof(string),"Anti Swear Warning! DO NOT USE UNDECENT LANGUAGE! You will be kicked. Warnings left: %d.",warningsLeft);
				SendClientMessage(playerid,red,string);
			}
	}
	if(playerSweared)
	{
		for(k=0;k<MAX_PLAYERS;k++)
		    if(IsPlayerConnected(k))
		        if(k==playerid)
		        		SendPlayerMessageToPlayer(k,playerid,origString);
				else
		        		SendPlayerMessageToPlayer(k,playerid,text);
		return 0;
	}
	else
		return 1;
}

public OnPlayerPrivmsg(playerid, recieverid, text[])
{
	new ver_string[256];
	strmid(ver_string, text, 0, strlen(text));
	if(FindIpPattern(playerid,ver_string))
	{
		new playerName[24], outputString[256];
		GetPlayerName(recieverid,playerName,24);
		format(outputString, 256, "PM sent to %s: %s",playerName,ver_string);
		SendClientMessage(playerid,yellow,outputString);
		SendClientMessage(playerid,pink," ");
		SendClientMessage(playerid,pink," ");
		SendClientMessage(playerid,pink," ");
		SendClientMessage(playerid,pink," ");
		SendClientMessage(playerid,pink," ");
		SendClientMessage(playerid,pink," ");
		SendClientMessage(playerid,pink," ");
		SendClientMessage(playerid,pink," ");
		SendClientMessage(playerid,pink," ");
		SendClientMessage(playerid,pink," ");
		text[0]=0;
		PlayerInfo[playerid][AdvertiseCount]++;
		if(PlayerInfo[playerid][AdvertiseCount] > ADVERTISE_MAX_MSGS)
			Kick(playerid);
		return 0;
	}
	if(PlayerInfo[playerid][SpamCount] == 0)
		PlayerInfo[playerid][SpamTime] = TimeStamp();

    PlayerInfo[playerid][SpamCount]++;
	if(TimeStamp() - PlayerInfo[playerid][SpamTime] > SPAM_TIMELIMIT)
	{ // Its OK your messages were far enough apart
		PlayerInfo[playerid][SpamCount] = 0;
		PlayerInfo[playerid][SpamTime] = TimeStamp();
	}
	else
		if(PlayerInfo[playerid][SpamCount] > SPAM_MAX_MSGS)
		{
			new playername[128];
 			GetPlayerName(playerid, playername, sizeof(playername));
			new string[64]; format(string,sizeof(string),"%s has been kicked (Flood/Spam Protection)", playername);
			SendClientMessageToAll(grey,string);
			print(string);
			Kick(playerid);
		}
		else
			if(PlayerInfo[playerid][SpamCount] == SPAM_MAX_MSGS)
				if(preWarning)
					SendClientMessage(playerid,red,"Anti Spam Warning! DO NOT FLOOD! Next is a kick.");
	new actualSwearCount=PlayerInfo[playerid][SwearCount];
	new playerSweared=false;
    new origString[512];
    new k;
    for(k=0; k<strlen(text); k++)
		origString[k]=text[k];
	origString[k]=0;
	for(new s = 0; s < UndecentWordCount; s++)
    {
		new pos=-1;
		while((pos = FindStringWithOffset(text,UndecentWords[s],pos+1)) != -1)
		{
			new goAhead=false;
		    if(pos==0) // beginning of text
		    {
		        if(strlen(text)==strlen(UndecentWords[s])) // it's the only word typed
		            goAhead=true;
				else // text has something else too
				{
				    if(IsSeparator(text[strlen(UndecentWords[s])])) // it's the thing we are looking for
						goAhead=true;
				}
		    }
		    else
		    {
		        if(pos==strlen(text)-strlen(UndecentWords[s])) // word is at the end f the text
		        {
		            if(IsSeparator(text[pos-1])) // it's the thing we are looking for
						goAhead=true;
		        }
		        else // word is included in the text
		        {
		            if( IsSeparator(text[pos-1]) && IsSeparator(text[pos+strlen(UndecentWords[s])]) ) // it's the thing we are looking for
		                goAhead=true;
		        }
		    }
			if(goAhead)
			{
			    playerSweared=true;
				for(new i = pos, j = pos + strlen(UndecentWords[s]); i < j; i++) text[i] = ' ';
				PlayerInfo[playerid][SwearCount]++;
			}
		}
	}
	if(PlayerInfo[playerid][SwearCount] > SWEAR_MAX_MSGS)
	{
		new playername[128];
		GetPlayerName(playerid, playername, sizeof(playername));
		new string[256];
		format(string,sizeof(string),"%s has been kicked for undecent language (Antiswear Protection)", playername);
		SendClientMessageToAll(red,string);
		print(string);
	    Kick(playerid);
	}
	if(actualSwearCount<PlayerInfo[playerid][SwearCount])
	{
			new string[256];
			new warningsLeft = SWEAR_MAX_MSGS-PlayerInfo[playerid][SwearCount];
			if(preWarning)
			{
				format(string,sizeof(string),"Anti Swear Warning! DO NOT USE UNDECENT LANGUAGE! You will be kicked. Warnings left: %d.",warningsLeft);
				SendClientMessage(playerid,red,string);
			}
	}
	if(playerSweared)
	{
	    if(SUPRESS_PM_SWEARING_MESSAGE)
	        text[0]=0;
		return 0;
	}
	else
		return 1;
}

public IsSeparator(testCharacter)
{
	new retval=false;
	new i;
	for(i=32;i<48;i++)
	    if(i==testCharacter)
	        retval=true;
	for(i=58;i<65;i++)
	    if(i==testCharacter)
	        retval=true;
	for(i=91;i<97;i++)
	    if(i==testCharacter)
	        retval=true;
	for(i=123;i<127;i++)
	    if(i==testCharacter)
	        retval=true;
 	return retval;
}

public FindStringWithOffset(buffer[],pattern[],offset)
{
	new retval=-1;
	if(strlen(buffer)<(strlen(pattern)+offset) || strlen(pattern)==0)
		return -1;
	for(new i=offset; i<(strlen(buffer)-strlen(pattern)+1);i++)
	{
	    if( buffer[i]==pattern[0] || buffer[i]==pattern[0]-32 )
	    {
			new foundPattern=true;
			for(new j=0; j<strlen(pattern); j++)
			{
			    if(buffer[i+j]!=pattern[j]&& buffer[i+j]!= pattern[j]-32)
			        foundPattern=false;
			}
			if(foundPattern)
			{
			    retval=i;
			    i=strlen(buffer);
			}
	    }
   	}
	return retval;
}

public FindIpPattern(playerid,const string[])
{
	new stringNumeric=false;
	new stringBegin;
	new ipDigits=0;
	for(new i=0; i<strlen(string); i++)
	{
	    if(string[i]<='9' && string[i]>='0')
	    {
	        if(!stringNumeric) // first digit
	        {
	            stringNumeric=true;
	            stringBegin=i;
		 	    if(i==strlen(string)-1) // string ends with one digit number
		 	    {
			        ipDigits++;
			        if(ipDigits>3) // 4 digits
			            return 1;
		 	    }
	        }
	        else
		 	{
		 	    if(i==strlen(string)-1) // string ends with the last digit
		 	    {
	           		new stringn[256];
    	       		new number;
					for(new j=stringBegin; j<i+1; j++)
					    stringn[j-stringBegin]=string[j];
			        stringn[i-stringBegin+1]=0;
			        number=strval(stringn);
				    if(number>=0 && number<256) // our case
				    {
				        ipDigits++;
				        if(ipDigits>3) // 4 digits
				            return 1;
				    }
		 	    }
		 	}
	    }
	    else
	    {
	        if(stringNumeric) // last digit+1
	        {
	            stringNumeric=false;
           		new stringn[256];
           		new number;
				for(new j=stringBegin; j<i; j++)
				    stringn[j-stringBegin]=string[j];
		        stringn[i-stringBegin]=0;
		        number=strval(stringn);
			    if(number>=0 && number<256) // our case
			    {
			        ipDigits++;
			        if(ipDigits>3) // 4 digits
			            return 1;
			    }
			    else // not in ip-group range
			        ipDigits=0; // reset ip digit counter;
	        }
	    }
	}
	return 0;
}

