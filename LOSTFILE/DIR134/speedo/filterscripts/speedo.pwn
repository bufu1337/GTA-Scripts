/*##############################################################################

					########################################
					#                                      #
					#   SPEEDOMETER FILTERSCRIPT BY YOM    #
					#      STEAL MY WORK AND DIE >:D	   #
					#                                      #
					########################################


- Credits to Mabako, as i stole his speed tracker :) Thanks Mabako.
- Copyright © Yom Productions® - Do not sell or i'll kill you.


- Versions changes:

	- 1.0 :	Initial release.
	
	- 1.1 : Corrected crashes.
	        Improved writing.
	        Changed default multiplicator to 1.0.
	        Added 5 others colors.
	        
	- 1.2 : GameTexts in your gamemodes are no longer overwritted
	
	
################################### INDEX ######################################

DEFINES, ETC...		Line 46
THE SPEEDOMETER		Line 97
THE COMMAND         Line 180
THE CONFIGURATION   Line 383
MISCANELLOUS        Line 508

##############################################################################*/

#include <yom_inc/functions.pwn>
#include <yom_inc/dini.pwn>

forward Speedometer();

/*########################## DEFINES, NEWS, ENUM... ##########################*/

#define RED		0xFF0000AA
#define GREEN	0x33AA33FF
#define ORANGE	0xFF9900AA

new str[255],msg[255],msg2[255],xmax;

#define line(%1,%2) for(new i=0; i<86; i++) msg[i] = ' '; msg[2] = %1; msg[xmax] = %2; for(new i=3; i<xmax; i++) msg[i] = 196; print(msg)
#define Frame(%1)   xmax = strlen(%1)+3; line(218,191); msg = %1; strins(msg,"   ",0); msg[2] = 179; msg[xmax] = 179; print(msg); line(192,217)

#define line2(%1,%2) for(new i=0; i<86; i++) msg[i] = ' '; msg[2] = %1; msg[xmax] = %2; for(new i=3; i<xmax; i++) msg[i] = 205; print(msg)
#define Frame2(%1)   xmax = strlen(%1)+3; line2(201,187); msg = %1; strins(msg,"   ",0); msg[2] = 186; msg[xmax] = 186; print(msg); line2(200,188)

#define cmd(%1) if((strcmp(cmdtext,%1,true,strlen(%1))==0)&&(((cmdtext[strlen(%1)]==0)&&(d%1(playerid,"")))||((cmdtext[strlen(%1)]==32)&&(d%1(playerid,cmdtext[strlen(%1)+1]))))) return 1

#define MAX_POS 16

new Version[]               =   "1.1";
new cmd_speedo[]			=	"/speedo";

new Speedo_SaveFile[25]		=	"speedo/users_prefs.cfg";
new Speedo_ConfigFile[25]	=	"speedo/configuration.cfg";

new Option_Enabled[]		=	"Default--Enabled",     bool:Cfg_Enabled  = true;
new Option_Metric[]			=	"Default---Metric",     bool:Cfg_Metric   = true;
new Option_Color[]			=	"Default----Color",     Cfg_Color    	  = 0;
new Option_Position[]		=	"Default-Position", 	Cfg_Position 	  = 2;
new Option_Save_Settings[]	=	"Save-Configurations",  bool:Cfg_SaveSets = true;
new Option_Multiplicator[]	=	"Speed-Multiplicator",  Float:Cfg_Multi   = 1.0;
new Option_Refresh_Time[]	=	"Speed-Refresh--Time",  Cfg_Refresh_Time  = 200;
new Option_How_Many_Pos[]	=	"Speed--How-Many-Pos",  Cfg_How_Many_Pos  = 10;

enum SPEEDO_PREF
{
	bool:enabled,
	bool:metric,
	Float:speed,
	position,
	color,
}
new SpeedoInfo[MAX_PLAYERS][SPEEDO_PREF];

new Float:Pos[MAX_PLAYERS][MAX_POS][3];



/*####################### END OF DEFINES, NEWS, ENUM... ######################*/



/*############################# THE SPEEDOMETER ##############################*/

CalculateSpeed(playerid)
{
	GetPlayerPos(playerid,  Pos[playerid][Cfg_How_Many_Pos][0],
							Pos[playerid][Cfg_How_Many_Pos][1],
							Pos[playerid][Cfg_How_Many_Pos][2]);

	for(new j = 0; j < Cfg_How_Many_Pos; j ++)
	{
		for(new k = 0; k < 3; k ++) Pos[playerid][j][k] = Pos[playerid][j+1][k];
	}

	for(new l = 0; l < Cfg_How_Many_Pos; l ++)
	{
        SpeedoInfo[playerid][speed]  +=
		floatpower( floatpower(Pos[playerid][l][0]-Pos[playerid][l+1][0],2)+
					floatpower(Pos[playerid][l][1]-Pos[playerid][l+1][1],2)+
					floatpower(Pos[playerid][l][2]-Pos[playerid][l+1][2],2),
					0.62) * Cfg_Multi; // speed of the player, in kmh
	}
}


public Speedometer()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			CalculateSpeed(i);

			if(GetPlayerState(i) == PLAYER_STATE_DRIVER && SpeedoInfo[i][enabled])
			{
				DisplaySpeedMessage(i);
			}

			SpeedoInfo[i][speed] = 0.0;
		}
	}
}


DisplaySpeedMessage(playerid)
{
	new style,col[10],pos[40];

	switch(SpeedoInfo[playerid][position])
	{
		case 0:{style = 4;}                                         // top
		case 1:{style = 3; pos = "~n~~n~~n~~n~";}                   // middle
		case 2:{style = 3; pos = "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~";} // bottom
	}

	switch(SpeedoInfo[playerid][color])
	{
		case 1 :col = "~r~";    // red
		case 2 :col = "~r~~h~"; // light red
		case 3 :col = "~g~";    // green
		case 4 :col = "~g~~h~"; // light green
		case 5 :col = "~b~";    // blue
		case 6 :col = "~b~~h~"; // light blue
		case 7 :col = "~p~";    // purple
		case 8 :col = "~p~~h~"; // pink
		case 9 :col = "~y~";    // yellow
		default:col = "~w~";    // white
	}
	
	switch(SpeedoInfo[playerid][metric])
	{
		case true :format(str,sizeof(str),"%s%s%03d kph",pos,col,floatround(SpeedoInfo[playerid][speed]));      // kmh
		case false:format(str,sizeof(str),"%s%s%03d mph",pos,col,floatround(SpeedoInfo[playerid][speed]/1.6));  // mph
	}

	if (GetPlayerProp(playerid,1,1) == 0) yom_GameTextForPlayer(playerid,str,Cfg_Refresh_Time+50,style);
}



/*##################### END OF THE SPEEDOMETER FUNCTION ########################



################################# THE COMMAND ################################*/

dcmd_speedo(playerid, param[])
{
// HELP ------------------------------------------------------------------------

	if (!strcmp(param,"help",true,4) || !param[0])
	{
		SendClientMessage(playerid,ORANGE,"Type '/speedo state' to view your current settings");
		SendClientMessage(playerid,ORANGE,"Type '/speedo on|off' to enable or disable the speedo.");
		SendClientMessage(playerid,ORANGE,"Type '/speedo kph|mph' to switch between Kph and Mph.");
		SendClientMessage(playerid,ORANGE,"Type '/speedo top|middle|bottom' to change the position.");
		SendClientMessage(playerid,ORANGE,"Type '/speedo red|lightred|green|lightgreen|blue|lightblue");
		SendClientMessage(playerid,ORANGE,"                       purple|pink|yellow|white' to change the color.");
		return 1;
	}
	
// CURRENT STATE ---------------------------------------------------------------

	else if (!strcmp(param,"state",true,5))
	{
		switch(SpeedoInfo[playerid][enabled])
		{
        	case true : str = "Speedometer: Enabled";
		    case false: str = "Speedometer: Disabled";
		}

		switch(SpeedoInfo[playerid][metric])
		{
			case true : format(str,sizeof(str),"%s | Units: Kph",str);
			case false: format(str,sizeof(str),"%s | Units: Mph",str);
		}

		switch(SpeedoInfo[playerid][position])
		{
			case 0 : format(str,sizeof(str),"%s | Position: Top",str);
			case 1 : format(str,sizeof(str),"%s | Position: Middle",str);
			case 2 : format(str,sizeof(str),"%s | Position: Bottom",str);
		}
		
		switch(SpeedoInfo[playerid][color])
		{
			case 1 : format(str,sizeof(str),"%s | Color: Red",str);
			case 2 : format(str,sizeof(str),"%s | Color: Light Red",str);
			case 3 : format(str,sizeof(str),"%s | Color: Green",str);
			case 4 : format(str,sizeof(str),"%s | Color: Light Green",str);
			case 5 : format(str,sizeof(str),"%s | Color: Blue",str);
			case 6 : format(str,sizeof(str),"%s | Color: Light Blue",str);
			case 7 : format(str,sizeof(str),"%s | Color: Purple",str);
			case 8 : format(str,sizeof(str),"%s | Color: Pink",str);
			case 9 : format(str,sizeof(str),"%s | Color: Yellow",str);
			default: format(str,sizeof(str),"%s | Color: White",str);
		}

		SendClientMessage(playerid,GREEN,str);
		return 1;
	}

// TOGGLE ON/OFF ---------------------------------------------------------------

	else if (!strcmp(param,"on",true,2))
	{
		SpeedoInfo[playerid][enabled] = true;
		SendClientMessage(playerid,GREEN,"Speedometer: Enabled.");
		return 1;
	}
	
	else if (!strcmp(param,"off",true,3))
	{
		SpeedoInfo[playerid][enabled] = false;
		SendClientMessage(playerid,GREEN,"Speedometer: Disabled.");
		return 1;
	}

// UNITS -----------------------------------------------------------------------

	else if (!strcmp(param,"kph",true,3))
	{
		SpeedoInfo[playerid][metric] = true;
		SendClientMessage(playerid,GREEN,"Speedometer Units: Kph");
		return 1;
	}
	
	else if (!strcmp(param,"mph",true,3))
	{
		SpeedoInfo[playerid][metric] = false;
		SendClientMessage(playerid,GREEN,"Speedometer Units: Mph");
		return 1;
	}
	

// POSITIONS -------------------------------------------------------------------

	else if (!strcmp(param,"top",true,3))
	{
		SpeedoInfo[playerid][position] = 0;
		SendClientMessage(playerid,GREEN,"Speedometer Position: Top");
		return 1;
	}

	else if (!strcmp(param,"middle",true,6))
	{
		SpeedoInfo[playerid][position] = 1;
		SendClientMessage(playerid,GREEN,"Speedometer Position: Middle");
		return 1;
	}

	else if (!strcmp(param,"bottom",true,6))
	{
		SpeedoInfo[playerid][position] = 2;
		SendClientMessage(playerid,GREEN,"Speedometer Position: Bottom");
		return 1;
	}
	

// COLORS ----------------------------------------------------------------------

	else if (!strcmp(param,"white",true,5))
	{
		SpeedoInfo[playerid][color] = 0;
		SendClientMessage(playerid,GREEN,"Speedometer Color: White");
		return 1;
	}
	
	else if (!strcmp(param,"red",true,3))
	{
		SpeedoInfo[playerid][color] = 1;
		SendClientMessage(playerid,GREEN,"Speedometer Color: Red");
		return 1;
	}
	
	else if (!strcmp(param,"lightred",true,8))
	{
		SpeedoInfo[playerid][color] = 2;
		SendClientMessage(playerid,GREEN,"Speedometer Color: Light Red");
		return 1;
	}
	
	else if (!strcmp(param,"green",true,5))
	{
		SpeedoInfo[playerid][color] = 3;
		SendClientMessage(playerid,GREEN,"Speedometer Color: Green");
		return 1;
	}
	
	else if (!strcmp(param,"lightgreen",true,10))
	{
		SpeedoInfo[playerid][color] = 4;
		SendClientMessage(playerid,GREEN,"Speedometer Color: Light Green");
		return 1;
	}
	
	else if (!strcmp(param,"blue",true,4))
	{
		SpeedoInfo[playerid][color] = 5;
		SendClientMessage(playerid,GREEN,"Speedometer Color: Blue");
		return 1;
	}
	
	else if (!strcmp(param,"lightblue",true,9))
	{
		SpeedoInfo[playerid][color] = 6;
		SendClientMessage(playerid,GREEN,"Speedometer Color: Light Blue");
		return 1;
	}
	
	else if (!strcmp(param,"purple",true,6))
	{
		SpeedoInfo[playerid][color] = 7;
		SendClientMessage(playerid,GREEN,"Speedometer Color: Purple");
		return 1;
	}

	else if (!strcmp(param,"pink",true,4))
	{
		SpeedoInfo[playerid][color] = 8;
		SendClientMessage(playerid,GREEN,"Speedometer Color: Pink");
		return 1;
	}
	
	else if (!strcmp(param,"yellow",true,6))
	{
		SpeedoInfo[playerid][color] = 9;
		SendClientMessage(playerid,GREEN,"Speedometer Color: Yellow");
		return 1;
	}

// END -------------------------------------------------------------------------

	return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	cmd(cmd_speedo);
	return 0;
}

/*########################### END OF THE COMMAND ###############################



######################### THE CONFIGURATION HANDLING #########################*/

ReadConfig()
{
	new File:fhandle = fopen(Speedo_ConfigFile,io_readwrite);
	new line[255],option[255],value[5];
	while(fread(fhandle,line,sizeof(line),false))
	{
		new separator = strfind(line,"=",true,0);
		strmid(option,line,0,separator,sizeof(option));
		strmid(value,line,separator+1,strlen(line)-2,sizeof(value));

		if 		(strcmp(option,Option_Enabled,true) == 0)		Cfg_Enabled		 = bool:strval(value);
		else if (strcmp(option,Option_Metric,true) == 0)		Cfg_Metric		 = bool:strval(value);
		else if (strcmp(option,Option_Color,true) == 0)			Cfg_Color		 = strval(value);
		else if (strcmp(option,Option_Position,true) == 0)		Cfg_Position 	 = strval(value);
		else if (strcmp(option,Option_Save_Settings,true) == 0) Cfg_SaveSets	 = bool:strval(value);
		else if (strcmp(option,Option_Multiplicator,true) == 0) Cfg_Multi		 = floatstr(value);
		else if (strcmp(option,Option_Refresh_Time,true) == 0)	Cfg_Refresh_Time = strval(value);
		else if (strcmp(option,Option_How_Many_Pos,true) == 0)	Cfg_How_Many_Pos = strval(value);
	}
	fclose(fhandle);
	return 1;
}


SetPlayerConfig(playerid)
{
	new line[255],idx = 0;
	if(dini_Isset(Speedo_SaveFile,PName(playerid)))
	{
		format(line,sizeof(line),"%s",dini_Get(Speedo_SaveFile,PName(playerid)));
		SpeedoInfo[playerid][enabled] 	= bool:strval(strtok(line,idx,','));
		SpeedoInfo[playerid][metric] 	= bool:strval(strtok(line,idx,','));
		SpeedoInfo[playerid][color] 	= strval(strtok(line,idx,','));
		SpeedoInfo[playerid][position]	= strval(strtok(line,idx,','));
	}
	else
	{
		SpeedoInfo[playerid][enabled] 	= bool:Cfg_Enabled;
		SpeedoInfo[playerid][metric] 	= bool:Cfg_Metric;
		SpeedoInfo[playerid][color] 	= Cfg_Color;
		SpeedoInfo[playerid][position] 	= Cfg_Position;
	}
	return 1;
}


SavePlayerConfig(playerid)
{
	new param1[50];
	if(dini_Isset(Speedo_SaveFile,PName(playerid))) dini_Unset(Speedo_SaveFile,PName(playerid));
	format(param1,sizeof(param1),"%s=%d,%d,%d,%d\r\n",PName(playerid),SpeedoInfo[playerid][enabled],SpeedoInfo[playerid][metric],SpeedoInfo[playerid][color],SpeedoInfo[playerid][position]);
	new File:fhandle = fopen(Speedo_SaveFile,io_append);
	fwrite(fhandle,param1);
	fclose(fhandle);
	return 1;
}


OptionsDisplay()
{
	Frame("Players's default settings:");

	switch(Cfg_Enabled)
	{
	    case false:	print ("   - SPEEDOMETER     : Disabled");
		default   :{print ("   - SPEEDOMETER     : Enabled");Cfg_Enabled = true;}
	}

	switch(Cfg_Metric)
	{
		case false:	print ("   - SPEEDO UNITS    : MPH");
		default   :{print ("   - SPEEDO UNITS    : KPH");Cfg_Metric = true;}
	}

	switch(Cfg_Color)
	{
		case 1 :	print ("   - MESSAGE COLOR   : Red");
		case 2 : 	print ("   - MESSAGE COLOR   : Light Red");
		case 3 : 	print ("   - MESSAGE COLOR   : Green");
		case 4 : 	print ("   - MESSAGE COLOR   : Light Green");
		case 5 : 	print ("   - MESSAGE COLOR   : Blue");
		case 6 : 	print ("   - MESSAGE COLOR   : Light Blue");
		case 7 : 	print ("   - MESSAGE COLOR   : Purple");
		case 8 : 	print ("   - MESSAGE COLOR   : Pink");
		case 9 : 	print ("   - MESSAGE COLOR   : Yellow");
		default:   {print ("   - MESSAGE COLOR   : White");Cfg_Color = 0;}
	}

	switch(Cfg_Position)
	{
	    case 0 :	print ("   - POSITION        : Top\n");
	    case 1 :	print ("   - POSITION        : Middle\n");
	    default:   {print ("   - POSITION        : Bottom\n");Cfg_Position = 2;}
	}

	Frame("Script configuration:");

	switch(Cfg_SaveSets)
	{
	    case false: print ("   - SAVE SETTINGS   : Disabled");
		default   :{print ("   - SAVE SETTINGS   : Enabled");Cfg_SaveSets = true;}
	}

	if (Cfg_Multi > 0.6 && Cfg_Multi < 1.6) printf("   - MULTIPLICATOR   : %.2f",Cfg_Multi);
	else {print ("   - MULTIPLICATOR   : 1.0");Cfg_Multi = 1.0;}

	switch(Cfg_Refresh_Time)
	{
	    case 100..1000: printf("   - REFRESH TIME    : %d",Cfg_Refresh_Time);
	    default       :{print ("   - REFRESH TIME    : 200");Cfg_Refresh_Time = 200;}
	}

	switch(Cfg_How_Many_Pos)
	{
		case 4..15:printf("   - SAVED POSITIONS : %d\n",Cfg_How_Many_Pos);
		default  :{print ("   - SAVED POSITIONS : 10\n");Cfg_How_Many_Pos = 10;}
	}
}

/*#################### END OF THE CONFIGURATION HANDLING #######################



############################# MISCANELLOUS THINGS ############################*/

public OnFilterScriptInit()
{
	print("\n");
	format(msg2,sizeof(msg2),"SPEEDOMETER FILTERSCRIPT - v%s - Coded by Yom",Version);
	Frame2(msg2);

	if(!fexist(Speedo_ConfigFile))
	{
		format(msg2,sizeof(msg2),"WARNING: The file '%s' can not be found!",Speedo_ConfigFile);
		Frame(msg2);
	}
	else ReadConfig();

	OptionsDisplay();
	print("\n");
	return 1;
}


public OnPlayerConnect(playerid)
{
	if(!ExistProp(1,1))
	{
		SetProp(1,1,1);
		SetTimer("Speedometer",Cfg_Refresh_Time,true);
	}
	
	SendClientMessage(playerid,ORANGE,"This server runs the speedometer filterscript, coded by Yom.");
	SetPlayerProp(playerid,1,0,1);
	SetPlayerConfig(playerid);
	return 1;
}


public OnPlayerDisconnect(playerid)
{
	if(Cfg_SaveSets) SavePlayerConfig(playerid);
	return 1;
}


PName(playerid)
{
	new Name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,Name,sizeof(Name));
	return Name;
}
#pragma unused PName

/*######################## END OF MISCANELLOUS THINGS ##########################



############################## END OF THE SCRIPT #############################*/
