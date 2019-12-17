//#include <a_samp>
#include <yom_inc/functions.pwn>
#include <dudb>
#include <yom_inc/dini.pwn>
#include <dutils>
//#include <dini>
#include <dcallbacks>
#include <danticheat>
//#include <core>
//#include <float>

forward Speedometer();
forward ClearPlayerChatBox(playerid);
#define dcmd(%1,%2,%3) if ((strcmp(%3, "/%1", true, %2+1) == 0)&&(((%3[%2+1]==0)&&(dcmd_%1(playerid,"")))||((%3[%2+1]==32)&&(dcmd_%1(playerid,%3[%2+2]))))) return 1
#define COLOR_SYSTEM 0xEFEFF7AA
#define COLOR_RED 0xAA3333AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_ORANGE 0xFF9900AA
#define C 0xFFFFFFFF
#define MAX_VEHICLE 255
#define VTYPE_CAR 1
#define VTYPE_HEAVY 2
#define VTYPE_BIKE 3
#define VTYPE_AIR 4
#define VTYPE_SEA 5
// ----- Paintshopareas ----- ----- Paintshopareas ----- ----- Paintshopareas -----
new PSvegas;
new TSvegas;
new PSdesertSouth;
new PSdesertNorth;
new PSsanfranNorth;
new PSsanfranSouth;
new TSsanfran;
new TSSpecialSF;
new PSlaCountry;
new TSLosAngeles;
new PSlaNorth;
new PSlaWest;
new PSlaEast;
new TSlaSpecial;
// --------- SODA's ------------------ SODA's ------------------ SODA's ---------
new Soda1;
new Soda2;
new Soda3;
new Soda4;
new Soda5;
new Soda6;
new Soda7;
new Soda8;
new Soda9;
new Soda10;
new Soda11;
new Soda12;
new Soda13;
new Soda14;
new Soda15;
new Soda16;
new Soda17;
new Soda18;
new Soda19;
new Soda20;
new Soda21;
new Soda22;
new Soda23;
new Soda24;
new Soda25;
new Soda26;
new Soda27;
new Soda28;
new Soda29;
new Soda30;
new Soda31;
new Soda32;
new Soda33;
new Soda34;
new Soda35;
new Soda36;
new Soda37;
new Soda38;
new Soda39;
new Soda40;
new Snack1;
new Snack2;
new Snack3;
new Snack4;
new Snack5;
new Snack6;
new Snack7;
new Snack8;
new Snack9;
new Snack10;
new Snack11;
new Snack12;
new Snack13;
new Snack14;
new Snack15;
new Snack16;
new Snack17;
new Snack18;
new Snack19;
new Snack20;
new Snack21;
new Snack22;
new Snack23;
new Snack24;
new Snack25;
new Snack26;
new fastfood1;
new fastfood2;
new fastfood3;
new	timer1;
new	timer2;
new	timer3;
new Float:oldhealth;
new Sodamoney;
new newSodamoney;
new Snackmoney;
new newSnackmoney;
new foodmoney;
new newfoodmoney;
new SEXY[MAX_PLAYERS];
new HUNGRY[MAX_PLAYERS];
new THIRSTY[MAX_PLAYERS];
new bufu[MAX_PLAYERS];
new Skin[MAX_PLAYERS];
new VehicleModels[260];
new msv[256];
new hvn=0;

new PLAYERLIST_authed[MAX_PLAYERS];

main()
{
	print("\n----------------------------------");
	print("  Carlito's Way");
	print("----------------------------------\n");
}
// ################################ Speedometer ##################################

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

// ##################### THIRST & HUNGER & Sex #####################
public Thirst(){
		for(new i = 0; i < MAX_PLAYERS; i++)
	{
	if (IsPlayerConnected(i) && THIRSTY[i] <100) {
	  THIRSTY[i] = THIRSTY[i] + 1;}}
}
public Thirsthealth(){
new Float:v;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
   if (THIRSTY[i] >=25 && THIRSTY[i] <=50){
   GetPlayerHealth(i, v);
   SetPlayerHealth(i, v-1);}
   else if (THIRSTY[i] >50 && THIRSTY[i] <=75){
   GetPlayerHealth(i, v);
   SetPlayerHealth(i, v-2);}
   else if (THIRSTY[i] >75 && THIRSTY[i] <=100){
   GetPlayerHealth(i, v);
   SetPlayerHealth(i, v-3);}}
}
public Hunger(){
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	  if (IsPlayerConnected(i) && HUNGRY[i] <100) {
	  HUNGRY[i] = HUNGRY[i] + 1;}}
}
public Hungerhealth(){
new Float:v;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	if (HUNGRY[i] >=25 && HUNGRY[i] <=50){
   GetPlayerHealth(i, v);
   SetPlayerHealth(i, v-1);}
   else if (HUNGRY[i] >50 && HUNGRY[i] <=75){
   GetPlayerHealth(i, v);
   SetPlayerHealth(i, v-2);}
   else if (HUNGRY[i] >75 && HUNGRY[i] <=100){
   GetPlayerHealth(i, v);
   SetPlayerHealth(i, v-3);}}
}
public SEX(){
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	  if (IsPlayerConnected(i) && SEXY[i] <100) {
	  SEXY[i] = SEXY[i] + 1;}}
}
public SEXhealth(){
new Float:v;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	if (SEXY[i] >=25 && SEXY[i] <=50){
   GetPlayerHealth(i, v);
   SetPlayerHealth(i, v-1);}
   else if (SEXY[i] >50 && SEXY[i] <=75){
   GetPlayerHealth(i, v);
   SetPlayerHealth(i, v-2);}
   else if (SEXY[i] >75 && SEXY[i] <=100){
   GetPlayerHealth(i, v);
   SetPlayerHealth(i, v-3);}}
}

public SODA(playerid){
	newSodamoney = GetPlayerMoney(playerid);
	if (newSodamoney==Sodamoney-1){
	THIRSTY[playerid]= THIRSTY[playerid]-2;
	Sodamoney=newSodamoney;}
	if (THIRSTY[playerid]< 0){
	THIRSTY[playerid]=0;}
	}
public SNACK(playerid){
	newSnackmoney = GetPlayerMoney(playerid);
	if (newSnackmoney==Snackmoney-1){
	HUNGRY[playerid]= HUNGRY[playerid]-1;
	Snackmoney=newSnackmoney;}
	if (HUNGRY[playerid]< 0){
	HUNGRY[playerid]=0;}
	}
public FASTFOOD(playerid){
	newfoodmoney = GetPlayerMoney(playerid);
	if (newfoodmoney==foodmoney-2){
	HUNGRY[playerid]= HUNGRY[playerid]-2;
	SendClientMessage(playerid, COLOR_YELLOW, "eat for 2$");
	foodmoney=newfoodmoney;}
	else if (newfoodmoney==foodmoney-5){
	HUNGRY[playerid]= HUNGRY[playerid]-4;
	SendClientMessage(playerid, COLOR_YELLOW, "eat for 5$");
	foodmoney=newfoodmoney;}
	else if (newfoodmoney==foodmoney-6){
	HUNGRY[playerid]= HUNGRY[playerid]-5;
	SendClientMessage(playerid, COLOR_YELLOW, "eat for 6$");
	foodmoney=newfoodmoney;}
	else if (newfoodmoney==foodmoney-10){
	HUNGRY[playerid]= HUNGRY[playerid]-7;
	SendClientMessage(playerid, COLOR_YELLOW, "eat for 10$");
	foodmoney=newfoodmoney;}
	else if (newfoodmoney==foodmoney-12){
	HUNGRY[playerid]= HUNGRY[playerid]-8;
	SendClientMessage(playerid, COLOR_YELLOW, "eat for 12$");
	foodmoney=newfoodmoney;}
	if (HUNGRY[playerid]< 0){
	HUNGRY[playerid]=0;}
	}

public ClearPlayerChatBox(playerid)
{
	SendClientMessage(playerid, COLOR_YELLOW, " ");
 	SendClientMessage(playerid, COLOR_YELLOW, " ");
  	SendClientMessage(playerid, COLOR_YELLOW, " ");
   	SendClientMessage(playerid, COLOR_YELLOW, " ");
   	SendClientMessage(playerid, COLOR_YELLOW, " ");
    SendClientMessage(playerid, COLOR_YELLOW, " ");
    SendClientMessage(playerid, COLOR_YELLOW, " ");
    SendClientMessage(playerid, COLOR_YELLOW, " ");
    SendClientMessage(playerid, COLOR_YELLOW, " ");
    SendClientMessage(playerid, COLOR_YELLOW, " ");
}

showinfo(playerid,s[],t[],u[],v,w,Float:x,Float:y,Float:z){
GameTextForPlayer(playerid,t,6000,6);hvn=v;
format(msv,sizeof(msv),"Angle: %d",w);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"Interior: %d",hvn);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"X: %f",x);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"Y: %f",y);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"Z: %f",z);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"Title: %s",t);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"Scm/User name: %s",u);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"Comments: %s",s);SendClientMessage(playerid,C,msv);
SetCameraBehindPlayer(playerid);SetPlayerInterior(playerid,hvn);
SetPlayerFacingAngle(playerid,w);SetPlayerPos(playerid,x,y,z);return 1;}
// ----- Usefull Commands ----- ----- Usefull Commands ----- ----- Usefull Commands -----
public GetVehicleType(vid) {
	new type;
// ================== CARS =======
	switch(VehicleModels[vid]) {
	case
	416,   //ambulan  -  car
	445,   //admiral  -  car
	602,   //alpha  -  car
	485,   //baggage  -  car
	568,   //bandito  -  car
	429,   //banshee  -  car
	499,   //benson  -  car
	424,   //bfinject,   //car
	536,   //blade  -  car
	496,   //blistac  -  car
	504,   //bloodra  -  car
	422,   //bobcat  -  car
	609,   //boxburg  -  car
	498,   //boxville,   //car
	401,   //bravura  -  car
	575,   //broadway,   //car
	518,   //buccanee,   //car
	402,   //buffalo  -  car
	541,   //bullet  -  car
	482,   //burrito  -  car
	431,   //bus  -  car
	438,   //cabbie  -  car
	457,   //caddy  -  car
	527,   //cadrona  -  car
	483,   //camper  -  car
	524,   //cement  -  car
	415,   //cheetah  -  car
	542,   //clover  -  car
	589,   //club  -  car
	480,   //comet  -  car
	596,   //copcarla,   //car
	599,   //copcarru,   //car
	597,   //copcarsf,   //car
	598,   //copcarvg,   //car
	578,   //dft30  -  car
	486,   //dozer  -  car
	507,   //elegant  -  car
	562,   //elegy  -  car
	585,   //emperor  -  car
	427,   //enforcer,   //car
	419,   //esperant,   //car
	587,   //euros  -  car
	490,   //fbiranch,   //car
	528,   //fbitruck,   //car
	533,   //feltzer  -  car
	544,   //firela  -  car
	407,   //firetruk,   //car
	565,   //flash  -  car
	455,   //flatbed  -  car
	530,   //forklift,   //car
	526,   //fortune  -  car
	466,   //glendale,   //car
	604,   //glenshit,   //car
	492,   //greenwoo,   //car
	474,   //hermes  -  car
	434,   //hotknife,   //car
	502,   //hotrina  -  car
	503,   //hotrinb  -  car
	494,   //hotring  -  car
	579,   //huntley  -  car
	545,   //hustler  -  car
	411,   //infernus,   //car
	546,   //intruder,   //car
	559,   //jester  -  car
	508,   //journey  -  car
	571,   //kart  -  car
	400,   //landstal,   //car
	403,   //linerun  -  car
	517,   //majestic,   //car
	410,   //manana  -  car
	551,   //merit  -  car
	500,   //mesa  -  car
	418,   //moonbeam,   //car
	572,   //mower  -  car
	423,   //mrwhoop  -  car
	516,   //nebula  -  car
	582,   //newsvan  -  car
	467,   //oceanic  -  car
	404,   //peren  -  car
	514,   //petro  -  car
	603,   //phoenix  -  car
	600,   //picador  -  car
	413,   //pony  -  car
	426,   //premier  -  car
	436,   //previon  -  car
	547,   //primo  -  car
	489,   //rancher  -  car
	441,   //rcbandit,   //car
	594,   //rccam  -  car
	564,   //rctiger  -  car
	515,   //rdtrain  -  car
	479,   //regina  -  car
	534,   //remingtn,   //car
	505,   //rnchlure,   //car
	442,   //romero  -  car
	440,   //rumpo  -  car
	475,   //sabre  -  car
	543,   //sadler  -  car
	605,   //sadlshit,   //car
	495,   //sandking,   //car
	567,   //savanna  -  car
	428,   //securica,   //car
	405,   //sentinel,   //car
	535,   //slamvan  -  car
	458,   //solair  -  car
	580,   //stafford,   //car
	439,   //stallion,   //car
	561,   //stratum  -  car
	409,   //stretch  -  car
	560,   //sultan  -  car
	550,   //sunrise  -  car
	506,   //supergt  -  car
	601,   //swatvan  -  car
	574,   //sweeper  -  car
	566,   //tahoma  -  car
	549,   //tampa  -  car
	420,   //taxi  -  car
	459,   //topfun  -  car
	576,   //tornado  -  car
	583,   //tug  -  car
	451,   //turismo  -  car
	558,   //uranus  -  car
	552,   //utility  -  car
	540,   //vincent  -  car
	491,   //virgo  -  car
	412,   //voodoo  -  car
	478,   //walton  -  car
	421,   //washing  -  car
	529,   //willard  -  car
	555,   //windsor  -  car
	456,   //yankee  -  car
	554,   //yosemite,   //car
	477   //zr3	50  -  car
	: type = VTYPE_CAR;

// ================== BIKES =======
	case
	581,   //bf400  -  bike
	523,   //copbike  -  bike
	462,   //faggio  -  bike
	521,   //fcr900  -  bike
	463,   //freeway  -  bike
	522,   //nrg500  -  bike
	461,   //pcj600  -  bike
	448,   //pizzaboy,   //bike
	468,   //sanchez  -  bike
	586,   //wayfarer,   //bike
	509,   //bike  -  bmx
	481,   //bmx  -  bmx
	510,   //mtbike  -  bmx
	471   //quad  -  quad
	: type = VTYPE_BIKE;

// ================== SEA =======
	case
	472,   //coastg  -  boat
	473,   //dinghy  -  boat
	493,   //jetmax  -  boat
	595,   //launch  -  boat
	484,   //marquis  -  boat
	430,   //predator,   //boat
	453,   //reefer  -  boat
	452,   //speeder  -  boat
	446,   //squalo  -  boat
	454   //tropic  -  boat
	: type = VTYPE_SEA;

// ================== AIR =======
	case
	548,   //cargobob,   //heli
	425,   //hunter  -  heli
	417,   //leviathn,   //heli
	487,   //maverick,   //heli
	497,   //polmav  -  heli
	563,   //raindanc,   //heli
	501,   //rcgoblin,   //heli
	465,   //rcraider,   //heli
	447,   //seaspar  -  heli
	469,   //sparrow  -  heli
	488,   //vcnmav  -  heli
	592,   //androm  -  plane
	577,   //at	400  -  plane
	511,   //beagle  -  plane
	512,   //cropdust,   //plane
	593,   //dodo  -  plane
	520,   //hydra  -  plane
	553,   //nevada  -  plane
	464,   //rcbaron  -  plane
	476,   //rustler  -  plane
	519,   //shamal  -  plane
	460,   //skimmer  -  plane
	513,   //stunt  -  plane
	539   //vortex  -  plane
	: type = VTYPE_AIR;

// ================== HEAVY =======
	case
	588,   //hotdog  -  car
	437,   //coach  -  car
	532,   //combine  -  car
	433,   //barracks,   //car
	414,   //mule  -  car
	443,   //packer  -  car
	470,   //patriot  -  car
	432,   //rhino  -  car
	525,   //towtruck,   //car
	531,   //tractor  -  car
	408,   //trash  -  car
	406,   //dumper  -  mtruck
	573,   //duneride,   //mtruck
	444,   //monster  -  mtruck
	556,   //monstera,   //mtruck
	557,   //monsterb,   //mtruck
	435,   //artict1  -  trailer
	450,   //artict2  -  trailer
	591,   //artict3  -  trailer
	606,   //bagboxa  -  trailer
	607,   //bagboxb  -  trailer
	610,   //farmtr1  -  trailer
	584,   //petrotr  -  trailer
	608,   //tugstair,   //trailer
	611,   //utiltr1  -  trailer
	590,   //freibox  -  train
	569,   //freiflat,   //train
	537,   //freight  -  train
	538,   //streak  -  train
	570,   //streakc  -  train
	449   //tram  -  train
	: type = VTYPE_HEAVY;
	}
	return type;
}

public IsPlayerInArea(playerid, Float:minx, Float:maxx, Float:miny, Float:maxy, Float:minz, Float:maxz){
new Float:x, Float:y, Float:z;
GetPlayerPos(playerid, x, y, z);
if (x > minx && x < maxx && y > miny && y < maxy && z > minz && z < maxz) return 1;
return 1;}

stock PlayerName(playerid) {
  new name[MAX_PLAYER_NAME];
  GetPlayerName(playerid, name, MAX_PLAYER_NAME);
  return name;}
PName(playerid){
	new Name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,Name,sizeof(Name));
	return Name;}
#pragma unused PName

public PutAtPos(playerid) {
  if (dUserINT(PlayerName(playerid)).("oldvehicle")!=0) {
	PutPlayerInVehicle(playerid,(dUserINT(PlayerName(playerid)).("oldvehicle")),0);
  }
  if (dUserINT(PlayerName(playerid)).("x")!=0) {
      SendClientMessage(playerid,COLOR_GREEN,"Setting you to your last position. Welcome back!");
      SetPlayerPos(playerid,
                   float(dUserINT(PlayerName(playerid)).("x")),
                   float(dUserINT(PlayerName(playerid)).("y")),
                   float(dUserINT(PlayerName(playerid)).("z")));}
  if (dUserINT(PlayerName(playerid)).("a")!=0) {
	SetPlayerFacingAngle(playerid,float(dUserINT(PlayerName(playerid)).("a")));
  }

  }
public SetSkin(playerid) {
      SetPlayerSkin(playerid,(dUserINT(PlayerName(playerid)).("Skin")));
  return 1;}

// ----- Forward-Commands ----- ----- Forward-Commands ----- ----- Forward-Commands -----

public OnGameModeInit()
{

	print("Carlito's Way");
	SetGameModeText("Carlito's Way");
	SetTimer("TIMER_DCallbacks",1,1);
	PSvegas=AddAreaCheck(1967.0, 1968.0, 2158.74, 2166.1, 10.0, 13.0);
	TSvegas=AddAreaCheck(2382.9, 2390.35, 1041.8, 1042.8, 10.0, 13.0);
	PSdesertSouth=AddAreaCheck(-103.73, -96.16, 1109.95, 1110.95, 19.2, 23.0);
	PSdesertNorth=AddAreaCheck(-1424.25, -1416.7, 2591.6, 2592.6, 55.3, 59.0);
	PSsanfranNorth=AddAreaCheck(-2429.4, -2421.86, 1028.69, 1029.69, 50.0, 53.0);
	PSsanfranSouth=AddAreaCheck(-1908.25, -1900.8, 276.22, 277.22, 40.5, 44.0);
	TSsanfran=AddAreaCheck(-1939.44, -1932.3, 237.05, 238.05, 33.9, 36.0);
	TSSpecialSF=AddAreaCheck(-2716.56, -2715.56, 213.9, 221.05, 4.0, 7.0);
	PSlaCountry=AddAreaCheck(717.5, 722.4, -463.05, -462.05, 16.0, 19.0);
	TSLosAngeles=AddAreaCheck(1038.35, 1044.1, -1026.43, -1025.43, 31.8, 35.0);
	PSlaNorth=AddAreaCheck(1022.78, 1027.23, -1029.9, -1028.9, 31.8, 35.0);
	PSlaWest=AddAreaCheck(485.92, 490.7, -1735.0, -1734.0, 10.8, 14.0);
	PSlaEast=AddAreaCheck(2071.0, 2072.0, -1833.72, -1829.15, 13.0, 16.0);
	TSlaSpecial=AddAreaCheck(2641.21, 2648.82, -2039.74, -2038.74, 13.0, 16.0);
	Soda1=AddAreaCheck(2086.0, 2087.0, 2071.0, 2072.0, 11.0, 12.0);
	Soda2=AddAreaCheck(2325.5,2326.5,-1646.5,-1645.5,14.0,16.0);
	Soda3=AddAreaCheck(1929.0,1930.0,-1773.0,-1772.0,13.0,15.0);
	Soda4=AddAreaCheck(1729.3,1730.3,-1944.4,-1943.4,13.0,15.0);
	Soda5=AddAreaCheck(2352.6,2353.6,-1357.6,-1356.6,24.0,26.0);
	Soda6=AddAreaCheck(2059.6,2060.6,-1899.0,-1898.0,13.0,15.0);
	Soda7=AddAreaCheck(1787.8,1788.8,-1369.8,-1368.8,15.0,17.0);
	Soda8=AddAreaCheck(1153.3,1154.3,-1461.4,-1460.4,15.0,17.0);
	Soda9=AddAreaCheck(1278.0,1279.1,371.7,372.7,19.0,21.0);
	Soda10=AddAreaCheck(199.6,200.6,-108.1,-107.1,1.0,3.0);
	Soda11=AddAreaCheck(-2120.1,-2118.8,-424.0,-421.6,35.0,37.0);
	Soda12=AddAreaCheck(-19.8,-18.4,-57.8,-56.4,1003.0,1005.0);
	Soda13=AddAreaCheck(-1982.1,-1981.1,142.1,143.1,27.0,29.0);
	Soda14=AddAreaCheck(-2420.0,-2419.0,984.0,986.5,44.5,46.5);
	Soda15=AddAreaCheck(-16.8,-15.5,-91.5,-90.0,1003.0,1005.0);
	Soda16=AddAreaCheck(-863.3,-862.3,1537.0,1538.0,22.0,24.0);
	Soda17=AddAreaCheck(-1349.8,-1348.8,491.5,493.0,10.0,13.0);
	Soda18=AddAreaCheck(-253.5,-252.5,2597.5,2599.0,62.0,64.0);
	Soda19=AddAreaCheck(-2063.7,-2062.7,-491.5,-490.0,35.0,37.0);
	Soda20=AddAreaCheck(-2035.0,-2034.0,-491.5,-490.0,35.0,37.0);
	Soda21=AddAreaCheck(-2092.7,-2091.2,-491.5,-490.0,35.0,37.0);
	Soda22=AddAreaCheck(-2006.5,-2005.0,-491.5,-490.0,35.0,37.0);
	Soda23=AddAreaCheck(-2011.8,-2010.5,-398.0,-397.0,35.0,37.0);
	Soda24=AddAreaCheck(-2040.5,-2039.0,-398.0,-397.0,35.0,37.0);
	Soda25=AddAreaCheck(-2069.3,-2068.0,-398.0,-397.0,35.0,37.0);
	Soda26=AddAreaCheck(-2098.0,-2096.5,-398.0,-397.0,35.0,37.0);
	Soda27=AddAreaCheck(2319.3,2320.8,2531.5,2532.5,10.0,12.0);
	Soda28=AddAreaCheck(1518.5,1519.8,1054.5,1056.0,10.0,12.0);
	Soda29=AddAreaCheck(2502.5,2503.8,1244.0,1245.0,10.0,12.0);
	Soda30=AddAreaCheck(-33.0,-32.0,-186.6,-185.4,1003.0,1005.0);
	Soda31=AddAreaCheck(501.3,502.4,-2.9,-1.6,1000.0,1002.0);
	Soda32=AddAreaCheck(495.3,496.4,-24.1,-22.8,1000.0,1002.0);
	Soda33=AddAreaCheck(373.3,374.4,-179.5,-178.3,1000.0,1002.0);
	Soda34=AddAreaCheck(2223.8,2225.0,-1154.0,-1152.8,1025.0,1027.0);
	Soda35=AddAreaCheck(2575.3,2576.5,-1285.1,-1283.8,1060.0,1062.0);
	Soda36=AddAreaCheck(-36.4,-35.0,-140.1,-138.8,1003.0,1005.0);
	Soda37=AddAreaCheck(-15.7,-14.4,-140.1,-138.8,1003.0,1005.0);
	Soda38=AddAreaCheck(2156.0,2157.3,1606.2,1607.4,999.0,1001.0);
	Soda39=AddAreaCheck(2222.3,2223.7,1606.1,1607.4,999.0,1001.0);
	Soda40=AddAreaCheck(2208.4,2209.8,1606.4,1607.7,999.0,1001.0);
    Snack1=AddAreaCheck(2480.2,2481.5,-1959.2,-1957.8,13.0,15.0);
    Snack2=AddAreaCheck(2139.6,2140.9,-1162.1,-1160.8,23.0,25.0);
    Snack3=AddAreaCheck(1633.5,1634.7,-2239.0,-2237.6,13.0,15.0);
    Snack4=AddAreaCheck(2153.2,2154.5,-1016.4,-1015.0,62.0,64.0);
    Snack5=AddAreaCheck(661.8,663.0,-552.0,-550.8,16.0,18.0);
    Snack6=AddAreaCheck(-2229.9,-2228.5,286.5,287.8,35.0,37.0);
    Snack7=AddAreaCheck(-76.0,-74.6,1227.2,1228.6,19.0,21.0);
    Snack8=AddAreaCheck(-1350.0,-1348.6,493.2,494.5,10.5,12.5);
    Snack9=AddAreaCheck(-253.6,-252.3,2599.0,2600.3,62.0,64.0);
    Snack10=AddAreaCheck(1398.0,1399.3,2222.7,2224.0,10.5,12.5);
    Snack11=AddAreaCheck(2845.0,2846.4,1293.7,1295.0,10.5,12.5);
    Snack12=AddAreaCheck(2647.0,2648.4,1128.2,1129.6,10.5,12.5);
    Snack13=AddAreaCheck(-34.6,-33.2,-186.7,-185.3,1003.0,1005.0);
    Snack14=AddAreaCheck(499.8,501.2,-2.8,-1.4,1000.0,1002.0);
    Snack15=AddAreaCheck(377.6,379.0,-179.5,-178.1,1000.0,1002.0);
    Snack16=AddAreaCheck(-17.3,-15.9,-140.2,-138.8,1003.0,1005.0);
    Snack17=AddAreaCheck(374.3,375.7,187.5,188.9,1007.5,1009.5);
    Snack18=AddAreaCheck(360.8,362.2,158.6,160.0,1007.5,1009.5);
    Snack19=AddAreaCheck(350.9,352.3,205.4,206.8,1007.5,1009.5);
    Snack20=AddAreaCheck(371.0,372.3,176.8,178.2,1019.0,1021.0);
	Snack21=AddAreaCheck(330.0,332.7,177.0,178.4,1019.0,1021.0);
    Snack22=AddAreaCheck(2156.0,2157.3,1607.41,1608.7,999.0,1001.0);
    Snack23=AddAreaCheck(315.1,316.5,-141.2,-139.8,999.0,1001.0);
    Snack24=AddAreaCheck(2201.7,2203.1,1617.0,1618.4,999.0,1001.0);
    Snack25=AddAreaCheck(2208.6,2210.0,1619.8,1621.2,999.0,1001.0);
    Snack26=AddAreaCheck(2222.4,2223.8,1602.0,1603.4,999.0,1001.0);
    fastfood1=AddAreaCheck(372.0,379.0,-71.7,-64.7,1001.0,1003.0);
    fastfood2=AddAreaCheck(365.3,372.3,-10.3,-3.3,1001.0,1003.0);
    fastfood3=AddAreaCheck(370.5,377.5,-123.0,-116.0,1001.0,1003.0);
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(1, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(2, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(7, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(9, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(10, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(11, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(12, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(13, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(14, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(15, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(16, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(17, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(18, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(19, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(20, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(21, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(22, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(23, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(24, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(25, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(26, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(27, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(28, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(29, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(30, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(31, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(32, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(33, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(34, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(35, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(36, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(37, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(38, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(39, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(40, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(41, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(43, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(44, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(45, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(46, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(47, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(48, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(49, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(50, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(51, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(52, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(53, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(54, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(55, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(56, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(57, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(58, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(59, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(60, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(61, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(62, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(63, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(64, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(66, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(67, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(68, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(69, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(70, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(71, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(72, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(73, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(76, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(77, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(78, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(79, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(80, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(81, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(82, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(83, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(84, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(85, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(87, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(88, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(89, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(90, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(91, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(92, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(93, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(94, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(95, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(96, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(97, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(98, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(99, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(100, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(101, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(102, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(103, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(104, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(105, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(106, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(107, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(108, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(109, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(110, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(111, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(112, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(113, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(114, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(115, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(116, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(117, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(118, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(120, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(121, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(122, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(123, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(124, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(125, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(126, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(127, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(128, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(129, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(130, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(131, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(132, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(133, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(134, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(135, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(136, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(137, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(138, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(139, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(140, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(141, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(142, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(143, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(144, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(145, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(146, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(147, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(148, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(150, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(151, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(152, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(153, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(155, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(156, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(157, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(158, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(159, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(160, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(161, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(162, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(163, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(164, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(165, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(166, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(167, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(168, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(169, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(170, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(171, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(172, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(173, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(174, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(175, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(176, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(177, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(178, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(179, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(180, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(181, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(182, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(183, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(184, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(185, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(186, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(187, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(188, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(189, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(190, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(191, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(192, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(193, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(194, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(195, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(196, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(197, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(198, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(199, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(200, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(201, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(202, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(203, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(204, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(205, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(206, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(207, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(209, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(210, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(211, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(212, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(213, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(214, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(215, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(216, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(217, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(218, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(219, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(220, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(221, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(222, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(223, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(224, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(225, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(226, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(227, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(228, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(229, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(230, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(231, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(232, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(233, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(234, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(235, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(236, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(237, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(238, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(239, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(240, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(241, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(242, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(243, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(244, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(245, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(246, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(247, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(248, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(249, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(250, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(251, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(252, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(253, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddStaticVehicle(415, 2040.02, 1321.375, 10.672, 0.0, 2, 1);
	AddStaticVehicle(487, 2040.02, 1330.375, 10.672, 0.0, 2, 1);
	AddStaticVehicle(487, 2040.02, 1350.375, 10.672, 0.0, 2, 1);

return 1;}
	
public OnPlayerRequestClass(playerid, classid)
{
	if (bufu[playerid]==1){	Skin[playerid] = classid;}
	if (!udb_Exists(PlayerName(playerid))){
	SetPlayerPos(playerid, 1174.8, -1182.6, 91.41113);
	SetWorldTime(1);
	SetPlayerFacingAngle(playerid, 90);
	SetPlayerCameraPos(playerid, 1173.0, -1182.8, 90.8);
	SetPlayerCameraLookAt(playerid, 1175.0, -1183.0, 92.0);
	}
	return 1;
}
public OnGameModeExit()
{
	print("GameModeExit()");
	return 1;
}
public OnPlayerDisconnect(playerid) {
	new oldvehicle;
	if(Cfg_SaveSets==false) {SavePlayerConfig(playerid);return 1;}
		if(Skin[playerid]<=2){}
	else if(Skin[playerid]==3) {
		Skin[playerid] = Skin[playerid] + 4;}
	else if(Skin[playerid]>=4 && Skin[playerid]<=36) {
		Skin[playerid] = Skin[playerid] + 5; }
	else if(Skin[playerid]>=37 && Skin[playerid]<=58) {
		Skin[playerid] = Skin[playerid] + 6; }
	else if(Skin[playerid]>=59 && Skin[playerid]<=66) {
		Skin[playerid] = Skin[playerid] + 7; }
	else if(Skin[playerid]>=67 && Skin[playerid]<=76) {
		Skin[playerid] = Skin[playerid] + 9; }
	else if(Skin[playerid]>=77 && Skin[playerid]<=108) {
		Skin[playerid] = Skin[playerid] + 10; }
	else if(Skin[playerid]>=109 && Skin[playerid]<=137) {
		Skin[playerid] = Skin[playerid] + 11; }
	else if(Skin[playerid]>=138 && Skin[playerid]<=141) {
		Skin[playerid] = Skin[playerid] + 12; }
	else if(Skin[playerid]>=142 && Skin[playerid]<=194) {
		Skin[playerid] = Skin[playerid] + 13; }
	else if(Skin[playerid]>=195) {
		Skin[playerid] = Skin[playerid] + 14; }
	if (PLAYERLIST_authed[playerid]) {

     dUserSetINT(PlayerName(playerid)).("money",GetPlayerMoney(playerid));
     new Float:x,Float:y,Float:z,Float:a;
     GetPlayerPos(playerid,x,y,z);
     GetPlayerFacingAngle(playerid,a);
	 
     dUserSetINT(PlayerName(playerid)).("x",floatround(x));
     dUserSetINT(PlayerName(playerid)).("y",floatround(y));
     dUserSetINT(PlayerName(playerid)).("z",floatround(z));
     dUserSetINT(PlayerName(playerid)).("a",floatround(a));
     dUserSetINT(PlayerName(playerid)).("thirsty",THIRSTY[playerid]);
     dUserSetINT(PlayerName(playerid)).("hungry",HUNGRY[playerid]);
     dUserSetINT(PlayerName(playerid)).("sexy",SEXY[playerid]);
     if (IsPlayerInAnyVehicle(playerid)){
	 oldvehicle = GetPlayerVehicleID(playerid);
	 dUserSetINT(PlayerName(playerid)).("oldvehicle",oldvehicle);}
	 }return false;}
public fick(playerid){Kick(playerid);}
public OnPlayerSpawn(playerid)
{
	if (bufu[playerid]==1){
	 dUserSetINT(PlayerName(playerid)).("skin",Skin[playerid]);}
	if (!PLAYERLIST_authed[playerid])
	{SendClientMessage(playerid,COLOR_RED,"U have left the Server !!! ");
    SetTimer("fick",1000,0);
	}
	SetSkin(playerid);
	return 1;
}
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
	SetTimer("Speedometer",200,true);
	SetTimer("Thirst",45000,true);
	SetTimer("Hunger",20000,true);
	SetTimer("SEX",36000,true);
	SetTimer("Thirsthealth",50000,true);
	SetTimer("Hungerhealth",60000,true);
	SetTimer("SEXhealth",55000,true);
	GameTextForPlayer(playerid,"Carlito's Way",8000,1);
	SetPlayerCameraPos(playerid, 1948.0, -1606.0, 150.0);
	SetPlayerCameraLookAt(playerid, 1560.0, -1380.0, 220.0);
    PLAYERLIST_authed[playerid]=false;
	if (udb_Exists(PlayerName(playerid))){
	SendClientMessage(playerid, COLOR_GREEN, "Account found. Login now.");}
	else {
	SendClientMessage(playerid, COLOR_GREEN, "Please /register first !!!");}
	if(!ExistProp(1,1))
	{
		SetProp(1,1,1);
		SetTimer("Speedometer",Cfg_Refresh_Time,true);
	}
	SetPlayerProp(playerid,1,0,1);
	SetPlayerConfig(playerid);}

	
dcmd_register(playerid,params[]) {

    if (PLAYERLIST_authed[playerid])
	 SendClientMessage(playerid,COLOR_GREEN,"Already logged in.");


    if (udb_Exists(PlayerName(playerid)))
	 SendClientMessage(playerid,COLOR_GREEN,"Account already exists, please use /login password'.");


    if (strlen(params)==0)
	 SendClientMessage(playerid,COLOR_GREEN,"Usage: /register password'");

    if (udb_Create(PlayerName(playerid),params)){
	PLAYERLIST_authed[playerid]=true;
	bufu[playerid] = 1;
	SendClientMessage(playerid,COLOR_RED,"Account successfully created. Choose your permanent skin!");}
    return true; }

dcmd_login(playerid,params[]) {

    if (PLAYERLIST_authed[playerid])
	 SendClientMessage(playerid,COLOR_GREEN,"Already logged in.");


    if (!udb_Exists(PlayerName(playerid)))
	 SendClientMessage(playerid,COLOR_GREEN,"Account doesn't exist, please use '/register password'.");

    if (strlen(params)==0)
	 SendClientMessage(playerid,COLOR_GREEN,"Usage: /login password'");

    if (udb_CheckLogin(PlayerName(playerid),params)) {
       GivePlayerMoney(playerid,dUserINT(PlayerName(playerid)).("money")-GetPlayerMoney(playerid));
	   PLAYERLIST_authed[playerid]=true;
	bufu[playerid] = 0;
	SpawnPlayer(playerid);
	SetSkin(playerid);
	THIRSTY[playerid] = (dUserINT(PlayerName(playerid)).("thirsty"));
	HUNGRY[playerid] = (dUserINT(PlayerName(playerid)).("hungry"));
	SEXY[playerid] = (dUserINT(PlayerName(playerid)).("sexy"));
	PutAtPos(playerid);
		return true;
    } else {
        SendClientMessage(playerid,COLOR_GREEN,"Login failed!");
    }
	return false;}
public OnPlayerDeath(playerid, killerid, reason)
{
	printf("OnPlayerDeath(%d, %d, %d)", playerid, killerid, reason);
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	printf("OnVehicleSpawn(%d)", vehicleid);
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	printf("OnVehicleDeath(%d, %d)", vehicleid, killerid);
	return 1;
}

public OnPlayerText(playerid)
{
	printf("OnPlayerText(%d)", playerid);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new idx;
	new s[256];
	new t[256];
	new u[256];
	new v;
	new w;
	new Float:x,Float:y,Float:z;
	dcmd(login,5,cmdtext); // because login has 5 characters
	dcmd(register,8,cmdtext); // because register has 8 charactersnew string[76];
	cmd = strtok(cmdtext, idx);
	cmd(cmd_speedo);


///////////////////////// 24/7 /////////////////////////
if(strcmp(cmd,"/247",true)==0){
SendClientMessage(playerid,C,"=== 24/7 Stores ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/2471 - Version 1 - Big - L-shaped - NO EXIT");
SendClientMessage(playerid,C,"/2472 - Version 2 - Big - Oblong   - NO EXIT");
SendClientMessage(playerid,C,"/2473 - Version 3 - Med - Square   - Creek, LV");
SendClientMessage(playerid,C,"/2474 - Version 4 - Med - Square   - NO EXIT");
SendClientMessage(playerid,C,"/2475 - Version 5 - Sml - Long     - Mulholland");
SendClientMessage(playerid,C,"/2476 - Version 6 - Sml - Square   - Whetstone");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/2471",true)==0){s="Large - Lshaped";t="24/7 (V1)";u="X7_11D";
v=17;w=0;x=-25.884499;y=-185.868988;z=1003.549988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/2472",true)==0){s="Large - Oblong";t="24/7 (V2) - (large)";u="X711S3";
v=10;w=0;x=6.091180;y=-29.271898;z=1003.549988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/2473",true)==0){s="Medium - Square";t="24/7 (V3)";u="X7_11B";
v=18;w=0;x=-30.946699;y=-89.609596;z=1003.549988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/2474",true)==0){s="Medium - Square";t="24/7 (V4)";u="X7_11C";
v=16;w=0;x=-25.132599;y=-139.066986;z=1003.549988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/2475",true)==0){s="Small - Long";t="24/7 (V5)";u="X711S2";
v=4;w=0;x=-27.312300;y=-29.277599;z=1003.549988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/2476",true)==0){s="Small - Square";t="24/7 (V6)";u="X7_11S";
v=6;w=0;x=-26.691599;y=-55.714897;z=1003.549988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// AERODYNAMICS /////////////////////////
if(strcmp(cmd,"/AIR",true)==0){
SendClientMessage(playerid,C,"=== ALL THINGS AERODYNAMIC ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/AIR1 - Francis Intn'l Airport - Ticket sales");
SendClientMessage(playerid,C,"/AIR2 - Francis Intn'l Airport - Baggage claim");
SendClientMessage(playerid,C,"/AIR3 - Shamal cabin (good jump spot)");
SendClientMessage(playerid,C,"/AIR4 - Andromada cargo hold");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/AIR1",true)==0){s="Remove your shoes please...";
t="Francis Int. Airport (Front Exterior & Ticket Sales)";u="AIRPORT";
v=14;w=0;x=-1827.147338;y=7.207418;z=1061.143554;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/AIR2",true)==0){s="Why is your bag ticking sir?";
t="Francis Int. Airport (Baggage Claim)";u="AIRPOR2";
v=14;w=0;x=-1855.568725;y=41.263156;z=1061.143554;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/AIR3",true)==0){s="Nice jump area in back";t="Shamal Interior";u="JETINT";
v=1;w=0;x=2.384830;y=33.103397;z=1199.849976;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/AIR4",true)==0){s="Cargo Hold";t="Andromada";u="Spectre";
v=9;w=0;x=315.856170;y=1024.496459;z=1949.797363;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// AMMUNATION /////////////////////////
if(strcmp(cmd,"/AMU",true)==0){
SendClientMessage(playerid,C,"=== Ammunations ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/AMU1 - Ocean Flats, SF");
SendClientMessage(playerid,C,"/AMU2 - Palomino Creek, LV");
SendClientMessage(playerid,C,"/AMU3 - Angel Pine, SF");
SendClientMessage(playerid,C,"/AMU4 - (2 story)");
SendClientMessage(playerid,C,"/AMU5 - El Quebrados, LV");
SendClientMessage(playerid,C,"/AMU6 - Inside the booths");
SendClientMessage(playerid,C,"/AMU7 - Inside the range");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/AMU1",true)==0){s="NONE";t="Ammunation (V2)";u="AMMUN1";
v=1;w=315;x=286.148987;y=-40.644398;z=1001.569946;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/AMU2",true)==0){s="NONE";t="Ammunation (V3)";u="AMMUN2";
v=4;w=315;x=286.800995;y=-82.547600;z=1001.539978;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/AMU3",true)==0){s="NONE";t="Ammunation (V4)";u="AMMUN3";
v=6;w=90;x=296.919983;y=-108.071999;z=1001.569946;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/AMU4",true)==0){s="Check the machine to your right";t="Ammunation (V1)(2 floors)";u="AMMUN4";
v=7;w=45;x=314.820984;y=-141.431992;z=999.661987;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/AMU5",true)==0){s="NONE";t="Ammunation (V5)";u="AMMUN5";
v=6;w=45;x=316.524994;y=-167.706985;z=999.661987;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/AMU6",true)==0){s="Lock and Load";t="Ammunation Booths";u="Spectre";
v=7;w=0;x=302.292877;y=-143.139099;z=1004.062500;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/AMU7",true)==0){s="Now you know what a target sees";t="Ammunation Range";u="Spectre";
v=7;w=270;x=280.795104;y=-135.203353;z=1004.062500;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// BURGLARY HOUSES /////////////////////////
if(strcmp(cmd,"/X",true)==0){
SendClientMessage(playerid,C,"=== BURGLARY HOUSES ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"I've counted 23 burglary houses and will call them X1 thru X23...");
SendClientMessage(playerid,C,"Some of these were obviously tests that R* never removed (they do that");
SendClientMessage(playerid,C,"a lot). A lot of them have bad textures, doors that go nowhere, etc..");
SendClientMessage(playerid,C,"Some are clearly early models of later and better designed safe houses");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"Clan folk - You'll probably find some of these perfect for home bases.");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/X1",true)==0){s="Large/2 story/3 bedrooms/clone of X9";t="X1";u="LAHSB4";
v=3;w=0;x=235.508994;y=1189.169897;z=1080.339966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X2",true)==0){s="Medium/1 story/1 bedroom";t="X2";u="LAHS1A";
v=2;w=90;x=225.756989;y=1240.000000;z=1082.149902;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X3",true)==0){s="Small/1 story/1 bedroom";t="X3";u="LAHS1B";
v=1;w=0;x=223.043991;y=1289.259888;z=1082.199951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X4",true)==0){s="VERY Large/2 story/4 bedrooms";t="X4";u="LAHSB2";
v=7;w=0;x=225.630997;y=1022.479980;z=1084.069946;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X5",true)==0){s="Small/1 story/2 bedrooms";t="X5";u="VGHSS1";
v=15;w=0;x=295.138977;y=1474.469971;z=1080.519897;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X6",true)==0){s="Small/1 story/2 bedrooms";t="X6";u="VGSHS2";
v=15;w=0;x=328.493988;y=1480.589966;z=1084.449951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X7",true)==0){s="Small/1 story/1 bedroom/NO BATHROOM!";t="X7";u="VGSHM2";
v=15;w=90;x=385.803986;y=1471.769897;z=1080.209961;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X8",true)==0){s="Small/1 story/1 bedroom";t="X8";u="VGSHM3";
v=15;w=90;x=375.971985;y=1417.269897;z=1081.409912;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X9",true)==0){s="Large/2 story/3 bedrooms/clone of X1";t="X9";u="VGHSB3";
v=2;w=0;x=490.810974;y=1401.489990;z=1080.339966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X10",true)==0){s="Medium/1 story/2 bedrooms";t="X10";u="VGHSB1";
v=2;w=0;x=447.734985;y=1400.439941;z=1084.339966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X11",true)==0){s="Large/2 story/4 bedrooms";t="X11";u="LAHSB3";
v=5;w=270;x=227.722992;y=1114.389893;z=1081.189941;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X12",true)==0){s="Small/1 story/1 bedroom";t="X12";u="LAHS2A";
v=4;w=0;x=260.983978;y=1286.549927;z=1080.299927;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X13",true)==0){s="Small/1 story/1 bedroom/NO BATHROOM!";t="X13";u="LAHSS6";
v=4;w=0;x=221.666992;y=1143.389893;z=1082.679932;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X14",true)==0){s="Medium/2 story/1 bedroom";t="X14";u="VGHSM3";
v=10;w=0;x=27.132700;y=1341.149902;z=1084.449951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X15",true)==0){s="Large/2 story/1 bedroom/NO BATHROOM!";t="X15";u="SFHSM2";
v=4;w=90;x=-262.601990;y=1456.619995;z=1084.449951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X16",true)==0){s="Medium/1 story/2 bedrooms/NO BATHROOM or DOORS!";t="X16";u="VGHSM2";
v=5;w=0;x=22.778299;y=1404.959961;z=1084.449951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X17",true)==0){s="Large/2 story/4 bedrooms/NO BATHROOM!";t="X17";u="SFHSB1";
v=5;w=0;x=140.278000;y=1368.979980;z=1083.969971;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X18",true)==0){s="Large/2 story/3 bedrooms";t="X18";u="LAHSB1";
v=6;w=0;x=234.045990;y=1064.879883;z=1084.309937;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X19",true)==0){s="Small/1 story/NO BEDROOM!";t="X19";u="SFHSS2";
v=6;w=0;x=-68.294098;y=1353.469971;z=1080.279907;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X20",true)==0){s="Something is SERIOUSLY wrong with this model";t="X20";u="SFHSM1";
v=15;w=0;x=-285.548981;y=1470.979980;z=1084.449951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X21",true)==0){s="Small/1 story/NO BEDROOM!";t="X21";u="SFHSS1";
v=8;w=0;x=-42.581997;y=1408.109985;z=1084.449951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X22",true)==0){s="Medium/2 story/2 bedrooms";t="X22";u="SFHSB3";
v=9;w=0;x=83.345093;y=1324.439941;z=1083.889893;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X23",true)==0){s="Small/1 story/1 bedroom";t="X23";u="LAHS2B";
v=9;w=0;x=260.941986;y=1238.509888;z=1084.259888;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// BUSINESSES /////////////////////////
if(strcmp(cmd,"/BUS",true)==0){
SendClientMessage(playerid,C,"=== BLANK ===");
SendClientMessage(playerid,C,"/BUS1 - Blastin' Fools Records hallway");
SendClientMessage(playerid,C,"/BUS2 - Budget Inn Motel room");
SendClientMessage(playerid,C,"/BUS3 - Jefferson Motel");
SendClientMessage(playerid,C,"/BUS4 - Off Track Betting");
SendClientMessage(playerid,C,"/BUS5 - Sex Shop");
SendClientMessage(playerid,C,"/BUS6 - Sindacco Meat Processing Plant");
SendClientMessage(playerid,C,"/BUS7 - Zero's RC Shop");
SendClientMessage(playerid,C,"/BUS8 - Gasso gas station in Dillimore");
SendClientMessage(playerid,C,"type /Menu to return to the full category list");return 1;}
if(strcmp(cmd,"/BUS1",true)==0){s="ONLY THE FLOOR IS SOLID!";t="Blastin' Fools Records corridor";u="STUDIO";
v=3;w=0;x=1038.509888;y=-0.663752;z=1001.089966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/BUS2",true)==0){s="MOtel ROOM";t="Budget Inn Motel Room";u="MOROOM";
v=12;w=0;x=446.622986;y=509.318970;z=1001.419983;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/BUS3",true)==0){s="NONE";t="Jefferson Motel";u="MOTEL1";
v=15;w=0;x=2216.339844;y=-1150.509888;z=1025.799927;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/BUS4",true)==0){s="GENeric Off Track Betting";t="Off Track Betting";u="GENOTB";
v=3;w=90;x=833.818970;y=7.418000;z=1004.179993;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/BUS5",true)==0){s="Uh, because they sell sex stuff?";t="Sex Shop";u="SEXSHOP";
v=3;w=45;x=-100.325996;y=-22.816500;z=1000.741943;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/BUS6",true)==0){s="We've found Jimmy Hoffa!";t="Sindacco Meat Processing Plant";u="ABATOIR";
v=1;w=180;x=964.376953;y=2157.329834;z=1011.019958;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/BUS7",true)==0){s="NONE";t="Zero's RC Shop";u="RCPLAY";
v=6;w=0;x=-2239.569824;y=130.020996;z=1035.419922; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/BUS8", true)==0){s="Northern wall and shelves are non-solid";t="Gasso gas station in Dillimore";u="Spectre";
v=0;w=90;x=662.641601;y=-571.398803;z=16.343263;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// CAR MOD SHOPS /////////////////////////
if(strcmp(cmd,"/CAR",true)==0){
SendClientMessage(playerid,C,"=== CAR MOD SHOPS ===");
SendClientMessage(playerid,C,"YOU ARE NOT SUPPOSED TO BE IN A MOD SHOP WHILE NOT IN A VEHICLE!");
SendClientMessage(playerid,C,"These coordinates are safe but MOVE AND YOU RISK A MAJOR CRASH!");
SendClientMessage(playerid,C,"/CAR1 - Transfenders - safely on the roof.../CAR1X - inside - DANGER!");
SendClientMessage(playerid,C,"/CAR2 - Loco Low Co - safely on the roof.../CAR2X - inside - DANGER!");
SendClientMessage(playerid,C,"/CAR3 - Wheels Arch Angels - safely on the roof.../CAR3Xx - inside - DANGER!");
SendClientMessage(playerid,C,"/CAR4 - Michelle's Garage - safely on the roof - camera goes funny if inside");
SendClientMessage(playerid,C,"/CAR5 - CJ's Garage in SF - camera acts funny*");
SendClientMessage(playerid,C,"* If you believe the calendar, the game is set in 1998 as that's the only year Jan starts on a Thursday");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/CAR1x",true)==0){s="YOU HAVE BEEN WARNED!";t="Transfenders - inside";u="CARDMOD1";
v=1;w=0;x=614.581420;y=-23.066856;z=1004.781250;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAR2x",true)==0){s="YOU HAVE BEEN WARNED!";t="Loco Low Co - inside";u="CARMOD2";
v=2;w=180;x=620.420410;y=-72.015701;z=997.992187;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAR3x",true)==0){s="YOU HAVE BEEN WARNED!";t="Wheels Arch Angels - inside";u="CARMOD3";
v=3;w=315;x=612.508605;y=-129.236114;z=997.992187;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAR1",true)==0){s="You're safe up here";t="Transfenders";u="CARMOD1 - on the roof";
v=1;w=0;x=614.581420;y=-23.066856;z=1009.781250;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAR2",true)==0){s="You're safe up here";t="Loco Low Co";u="CARMOD2 - on the roof";
v=2;w=180;x=620.420410;y=-72.015701;z=1001.992187;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAR3",true)==0){s="You're safe up here";t="Wheels Arch Angels";u="CARMOD3 - on the roof";
v=3;w=315;x=612.508605;y=-129.236114;z=1001.992187;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAR4",true)==0){s="You're safe up here";t="Michelle's Garage";u="Spectre";
v=0;w=0;x=-1786.603759;y=1215.553466;z=28.531250;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAR5",true)==0){s="Go in the oil pits";t="CJ's Garage in SF";u="Spectre";
v=1;w=0;x=-2048.605957;y=162.093444;z=28.835937;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

////////////////// CASINO ODDITIES /////////////////////////
if(strcmp(cmd,"/CAS",true)==0){
SendClientMessage(playerid,C,"=== CASINO ODDITIES ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/CAS1 - Caligula's locked basement");
SendClientMessage(playerid,C,"/CAS2 - FDC Janitor's office");
SendClientMessage(playerid,C,"/CAS3 - FDC Woozie's office (downstairs");
SendClientMessage(playerid,C,"/CAS4 - FDC Woozie's office (upstairs)");
SendClientMessage(playerid,C,"/CAS5 - Redsands West Casino");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /Menu to return to the full category list");return 1;}
if(strcmp(cmd,"/CAS1",true)==0){s="Only open during one mission";t="Caligulas locked basement";u="Spectre";
v=1;w=0;x=2170.284;y=1618.629;z=999.9766;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAS2",true)==0){s="Small, ain't it? DON'T LEAVE THE ROOM!";t="Four Dragons Casino Janitor's office";u="FDJANITOR";
v=10;w=270;x=1889.975;y=1018.055;z=31.88281;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAS3",true)==0){s="Woozie's office - (teller area)";
t="Woozie's Office in the FDC - TRY LEAVING THROUGH DOOR!";u="WUZIBET";
v=1;w=90;x=-2158.719971;y=641.287964;z=1052.369995;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAS4",true)==0){s="Woozie's office - wish he could see it!";
t="Woozie's Office in the FDC";u="Spectre";
v=1;w=270;x=-2169.846435;y=642.365905;z=1057.586059;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAS5",true)==0){s="Don't remember seeing it playing the game!";
t="Small Casino in Redsands West";u="CASINO2";
v=12;w=0;x=1133.069946;y=-9.573059;z=1000.750000;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// CLOTHING STORES /////////////////////////
if(strcmp(cmd,"/CLO",true)==0){
SendClientMessage(playerid,C,"=== Clothing Stores ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/CLO1 - Binco");
SendClientMessage(playerid,C,"/CLO2 - Didier Sachs");
SendClientMessage(playerid,C,"/CLO3 - ProLaps");
SendClientMessage(playerid,C,"/CLO4 - SubUrban");
SendClientMessage(playerid,C,"/CLO5 - Victim");
SendClientMessage(playerid,C,"/CLO6 - Zip");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/CLO1",true)==0){s="Clothing Store/CHeaP";t="Binco (cheap)";u="CSCHP";
v=15;w=0;x=207.737991;y=-109.019997;z=1005.269958;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CLO2",true)==0){s="Clothing Store EXcLusive";t="Didier Sachs (exclusive)";u="CSEXL";
v=14;w=0;x=204.332993;y=-166.694992;z=1000.578979;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CLO3",true)==0){s="Clothing Store/SPoRT";t="ProLaps (sport)";u="CSSPRT";
v=3;w=0;x=207.054993;y=-138.804993;z=1003.519958;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CLO4",true)==0){s="Rockstar refers to Los Santos as Los Angeles a lot --- LA Clothing Store?";t="SubUrban";u="LACS1";
v=1;w=0;x=203.778000;y=-48.492397;z=1001.799988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CLO5",true)==0){s="Clothing Store/DESiGNer";t="Victim (designer)";u="CSDESGN";
v=5;w=90;x=226.293991;y=-7.431530;z=1002.259949; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CLO6",true)==0){s="Clothing Store like the GaP? General Purpose?";t="Zip (general purpose)";u="CLOTHGP";
v=18;w=0;x=161.391006;y=-93.159156;z=1001.804687; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// BARS & CLUBS /////////////////////////
if(strcmp(cmd,"/CLU",true)==0){
SendClientMessage(playerid,C,"=== BARS & CLUBS ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/CLU1 - Dance Club template");
SendClientMessage(playerid,C,"/CLU2 - Dance Club DJ room");
SendClientMessage(playerid,C,"/CLU3 - 'Pool Table' Bar template");
SendClientMessage(playerid,C,"/CLU4 - Lil' Probe Inn");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/CLU1",true)==0){s="Alhambra, Gaydar Station, The 'Artwork' Club east of the Camel's Toe";t="Dance Club template";u="BAR1";
v=17;w=0;x=493.390991;y=-22.722799;z=1000.686951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CLU2",true)==0){s="Alhambra, Gaydar Station, The 'Artwork' Club east of the Camel's Toe";t="Dance Club DJ room";u="Spectre";
v=17;w=270;x=476.068328;y=-14.893922;z=1003.695312;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CLU3",true)==0){s="Misty's, the Craw Bar, 10 Green bottles";t="'Pool table' Bar template";u="BAR2";
v=11;w=180;x=501.980988;y=-69.150200;z=998.834961;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CLU4",true)==0){s="based on the real life Little A'le'Inn near Area 51";t="Lil' Probe Inn";u="UFOBAR";
v=18;w=315;x=-227.028000;y=1401.229980;z=27.769798;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// EATERIES /////////////////////////
if(strcmp(cmd,"/EAT",true)==0){
SendClientMessage(playerid,C,"=== Diners & Restaurants ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/EAT1 - Jay's Diner");
SendClientMessage(playerid,C,"/EAT2 - Diner near Gant Bridge");
SendClientMessage(playerid,C,"/EAT3 - Secret Valley Diner (no solid surfaces)");
SendClientMessage(playerid,C,"/EAT4 - World of Coq");
SendClientMessage(playerid,C,"/EAT5 - Welcome Pump Truck Stop Diner*");
SendClientMessage(playerid,C,"* complete but unused in game - DON'T GO OUT DOOR!");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/EAT1",true)==0){s="I don't remember this being used";t="Jay's Diner";u="DINER1";
v=4;w=90;x=460.099976;y=-88.428497;z=999.621948; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/EAT2",true)==0){s="Only booth seats are solid!";t="Unnamed Diner (near Gant Bridge)";u="DINER2";
v=5;w=90;x=454.973950;y=-110.104996;z=999.717957; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/EAT3",true)==0){s="View from Jay's Diner thanx to -[HTB]-Kfgus3";t="Secret Valley Diner (No solid surfaces)";u="REST2";
v=6;w=337;x=435.271331;y=-80.958938;z=999.554687;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/EAT4",true)==0){s="FooD RESTaurant - DON'T FALL OFF!";t="World of Coq";u="FDREST1";
v=1;w=45;x=452.489990;y=-18.179699;z=1001.179993; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/EAT5",true)==0){s="Complete but unused in game";t="Welcome Pump Truck Stop Diner";u="TSDINER";
v=1;w=180;x=681.474976;y=-451.150970;z=-25.616798; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// FAST FOOD /////////////////////////
if(strcmp(cmd,"/FST",true)==0){
SendClientMessage(playerid,C,"=== Fast Food ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/FST1 - Burger Shot");
SendClientMessage(playerid,C,"/FST2 - Cluckin' Bell");
SendClientMessage(playerid,C,"/FST3 - Well Stacked Pizza");
SendClientMessage(playerid,C,"/FST4 - Rusty Brown's Donuts*");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"* complete but unused in game");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/FST1",true)==0){s="FooD/BURGers";t="Burger Shot";u="FDBURG";
v=10;w=315;x=366.923980;y=-72.929359;z=1001.507812; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/FST2",true)==0){s="FooD CHICKen";t="Cluckin' Bell";u="FDCHICK";
v=9;w=315;x=365.672974;y=-10.713200;z=1001.869995; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/FST3",true)==0){s="FooD PIZzA";t="Well Stacked Pizza";u="FDPIZA";
v=5;w=0;x=372.351990;y=-131.650986;z=1001.449951; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/FST4",true)==0){s="FooD/DONUTs - complete but unused in game";
t="Rusty Brown's Donuts";u="FDDONUT";v=17;w=0;x=377.098999;y=-192.439987;z=1000.643982;
showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// GIRLFRIENDS /////////////////////////
if(strcmp(cmd,"/GRL",true)==0){
SendClientMessage(playerid,C,"=== Girlfriend Bedrooms ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/GRL1 - Denise Robinson (Home Girl/Violent tendencies)");
SendClientMessage(playerid,C,"/GRL2 - Katie Zhan (Nurse/Neurotic)");
SendClientMessage(playerid,C,"/GRL3 - Helena Wankstein (Lawyer/Gun Nut)");
SendClientMessage(playerid,C,"/GRL4 - Michelle Cannes (Mechanic/Speed Freak)");
SendClientMessage(playerid,C,"/GRL5 - Barbara Schternvart (Cop/Control Freak)");
SendClientMessage(playerid,C,"/GRL6 - Millie Perkins (Croupier/Sex Fiend)");
SendClientMessage(playerid,C,"   --- THERE ARE NO EXITS FROM THESE ROOMS! ---");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/GRL1",true)==0){s="Rewards: Pimp suit & Green Hustler";t="Denise's Bedroom";u="GF1";
v=1;w=235;x=244.411987;y=305.032990;z=999.231995;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GRL2",true)==0){s="Rewards: Medic outfit & White Romero";t="Katie's Bedroom";u="GF2";
v=2;w=90;x=271.884979;y=306.631989;z=999.325989;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GRL3",true)==0){s="Rewards: Coveralls & Bandito";t="Helena's Bedroom (barn) - limited movement";
u="GF3";v=3;w=90;x=291.282990;y=310.031982;z=999.154968;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GRL4",true)==0){s="Rewards: Racing outfit & Monster Truck";t="Michelle's Bedroom";u="GF4";
v=4;w=0;x=302.181000;y=300.722992;z=999.231995;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GRL5",true)==0){s="Rewards: Police uniform & Ranger";t="Barbara's Bedroom";u="GF5";
v=5;w=0;x=322.197998;y=302.497986;z=999.231995;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GRL6",true)==0){s="Rewards: Gimp suit & Pink Club";t="Millie's Bedroom";u="GF6";
v=6;w=180;x=346.870025;y=309.259033;z=999.155700;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// GOVERNMENT /////////////////////////
if(strcmp(cmd,"/GOV",true)==0){
SendClientMessage(playerid,C,"=== GOVERNMENT BUILDINGS ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/GOV1 - Sherman Dam");
SendClientMessage(playerid,C,"/GOV2 - Planning Department");
SendClientMessage(playerid,C,"/GOV3 - Area 69 - Upper level entrance");
SendClientMessage(playerid,C,"/GOV4 - Area 69 - Middle level - Map room");
SendClientMessage(playerid,C,"/GOV5 - Area 69 - Lowest level - Jetpack room");
SendClientMessage(playerid,C,"/GOV6 - Area 69 - Secret Vent entrance");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/GOV1",true)==0){s="sherman DAM INside";t="Sherman Dam";u="DAMIN";
v=17;w=180;x=-959.873962;y=1952.000000;z=9.044310;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GOV2",true)==0){s="This place is HUGE!  Make your own spawn points!";t="Planning Department";u="PAPER";
v=3;w=90;x=388.871979;y=173.804993;z=1008.389954;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GOV3",true)==0){s="Wasn't this easy during the game...";t="AREA 69 entrance";u="Spectre";
v=0;w=90;x=220.4109;y=1862.277;z=13.147;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GOV4",true)==0){s="Great spawn screen possibilities!";t="AREA 69 Map room";u="Spectre";
v=0;w=90;x=226.853637;y=1822.760498;z=7.414062;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GOV5",true)==0){s="Lowest point in game not underwater?";t="AREA 69 Jetpack room";u="Spectre";
v=0;w=180;x=268.725585;y=1883.816406;z=-30.093750;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GOV6",true)==0){s="Now what are you gonna do?";t="AREA 69 Vent entrance";u="Spectre";
v=0;w=120;x=245.696197;y=1862.490844;z=18.070953;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// GYMS /////////////////////////
if(strcmp(cmd,"/GYM",true)==0){
SendClientMessage(playerid,C,"=== GYMS ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/GYM1 - Ganton, LS");
SendClientMessage(playerid,C,"/GYM2 - Cobra Gym in Garcia, SF");
SendClientMessage(playerid,C,"/GYM3 - Below the Belt Gym in Redsands East, LV");
SendClientMessage(playerid,C,"/GYM4 - Verona Beach Gym in LS*");
SendClientMessage(playerid,C,"/GYM5 - Madd Dogg's in Mulholland, LS*");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"* I threw these in because they ARE Gyms, Interior or not");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/GYM1",true)==0){s="Instrumental in initially reaching the Interiors";t="Ganton Gym in Ganton, LS";u="GYM1";
v=5;w=0;x=772.112000;y=-3.898650;z=1000.687988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GYM2",true)==0){s="Sign outside misspells MarTIal as MarITal";t="Cobra Gym in Garcia, SF";u="GYM2";
v=6;w=0;x=774.213989;y=-48.924297;z=1000.687988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GYM3",true)==0){s="The graffiti to your left is backwards";t="Below The Belt Gym in Redsands East, LV";u="GYM3";
v=7;w=0;x=773.579956;y=-77.096695;z=1000.687988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GYM4",true)==0){s="I know it's not an Interior but it IS a Gym";t="Verona Beach Gym";u="Spectre";
v=0;w=90;x=668.393188;y=-1867.325439;z=5.453720;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GYM5",true)==0){s="Mentioned for continuity purposes only";t="Madd Dogg's Gym in Mulholland, LS";u="Spectre";
v=5;w=0;x=1234.144409;y=-764.087158;z=1084.007202; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// HOMIES ////////////////////////
if(strcmp(cmd,"/HOM",true)==0){
SendClientMessage(playerid,C,"=== HOME BOYS ===");
SendClientMessage(playerid,C,"/HOM1 & /HOM2 - B Dup's Apt. & Crack pad");
SendClientMessage(playerid,C,"/HOM3 - Carl's Mom's House");
SendClientMessage(playerid,C,"/HOM4 thru /HOM6 - Madd Dogg's Mansion");
SendClientMessage(playerid,C,"/HOM7 - OG Loc's");
SendClientMessage(playerid,C,"/HOM8 - Ryder's House");
SendClientMessage(playerid,C,"/HOM9 - Sweet's House");
SendClientMessage(playerid,C,"/HOM10 thru /HOM17 - Big Smoke's Palace*");
SendClientMessage(playerid,C,"* The Crack Factory from the ground floor up");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/HOM1",true)==0){s="ONLY THE FLOOR IS SOLID!";t="B Dup's Apartment";u="BDUPS";
v=3;w=0;x=1527.229980;y=-11.574499;z=1002.269958;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM2",true)==0){s="ONLY THE FLOOR IS SOLID!";t="B Dup's Crack Pad";u="BDUPS1";
v=2;w=0;x=1523.509888;y=-47.821198;z=1002.269958;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM3",true)==0){s="There's no place like home";t="CJ's Mom's House in Ganton, LS";u="CARLS";
v=3;w=180;x=2496.049805;y=-1693.929932;z=1014.750000; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM4",true)==0){s="Upper (West) Entrance";t="Madd Dogg's Mansion (West door)";u="MADDOGS";
v=5;w=0;x=1263.079956;y=-785.308960;z=1091.959961;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM5",true)==0){s="Lower (East) Entrance";t="Madd Dogg's Mansion (East door)";u="MDDOGS";
v=5;w=0;x=1299.079956;y=-795.226990;z=1084.029907;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM6",true)==0){s="Helipad";t="Madd Dogg's Mansion Helipad";u="Spectre";
v=0;w=90;x=1291.725341;y=-788.319885;z=96.460937;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM7",true)==0){s="ONLY FLOOR IS SOLID! (Check front door)";t="OG Loc's House";u="OGLOCS";
v=3;w=0;x=516.650;y=-18.611898;z=1001.459961;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM8",true)==0){s="Funky lighting in the kitchen";t="Ryder's house";u="RYDERS";
v=2;w=90;x=2464.109863;y=-1698.659912;z=1013.509949;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM9",true)==0){s="DON'T GO ON SOUTH SIDE OF HOUSE!";t="Sweet's House";u="SWEETS";
v=1;w=270;x=2526.459961;y=-1679.089966;z=1015.500000;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM10",true)==0){s="Ground floor";t="Big Smoke's Crack Factory";u="Spectre";
v=2;w=180;x=2543.659912;y=-1303.629883;z=1025.069946;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM11",true)==0){s="Warehouse floor";t="Big Smoke's Crack Factory";u="Spectre";
v=2;w=270;x=2530.980468;y=-1294.163085;z=1031.421875;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM12",true)==0){s="Warehouse office";t="Big Smoke's Crack Factory";u="Spectre";
v=2;w=180;x=2569.185058;y=-1281.929809;z=1037.773437;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM13",true)==0){s="Factory floor";t="Big Smoke's Crack Factory";u="Spectre";
v=2;w=90;x=2564.201171;y=-1297.117797;z=1044.125000;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM14",true)==0){s="Factory office";t="Big Smoke's Crack Factory";u="Spectre";
v=2;w=180;x=2526.605468;y=-1281.239259;z=1048.289062;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM15",true)==0){s="Waiting Room";t="Big Smoke's Crack Factory";u="Spectre";
v=2;w=180;x=2535.017822;y=-1281.242553;z=1054.640625;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM16",true)==0){s="Statue Hallway (Check out side rooms)";t="Big Smoke's Crack Factory";u="Spectre";
v=2;w=0;x=2547.268310;y=-1295.931762;z=1054.640625;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM17",true)==0){s="Outside the Living Area (Check the doormat!)";t="Big Smoke's Crack Factory";u="Spectre";
v=2;w=90;x=2580.114501;y=-1300.392944;z=1060.992187;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// PLACES OF ILL REPUTE /////////////////////////
if(strcmp(cmd,"/ILL",true)==0)	{
SendClientMessage(playerid,C,"=== PLACES OF ILL REPUTE ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/ILL1 - Big Spread Ranch");
SendClientMessage(playerid,C,"/ILL2 - Fanny Batter's Whore House");
SendClientMessage(playerid,C,"/ILL3 & /ILL4- World Class Topless Girls Strip Club & Private room");
SendClientMessage(playerid,C,"/ILL5 - Unnamed Brothel");
SendClientMessage(playerid,C,"/ILL6 - 'Tiger Skin Rug' Brothel");
SendClientMessage(playerid,C,"/ILL7 & /ILL8 - Jizzy's Pleasure Domes");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/ILL1",true)==0){s="NONE";t="Big Spread Ranch Strip Club";u="STRIP2";
v=3;w=180;x=1212.019897;y=-28.663099;z=1001.089966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/ILL2",true)==0){s="Check out the artwork";t="Fanny Batter's Whore House*";u="BROTHEL";
v=6;w=290;x=744.542969;y=1437.669922;z=1102.739990;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/ILL3",true)==0){s="This is also the Pig Pen Interior";t="World Class Topless Girls Strip Club in Old Venturas Strip, LV";u="LASTRIP";
v=2;w=0;x=1204.809937;y=-11.586800;z=1001.089966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/ILL4",true)==0){s="ONLY THE FLOOR IS SOLID!";
t="World Class Topless Girls Strip Club Private Dance Room";u="Spectre";
v=2;w=0;x=1204.809937;y=13.586800;z=1001.089966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/ILL5",true)==0){s="Furniture not solid";t="Unnamed Brothel";u="BROTHL1";
v=3;w=0;x=940.921997;y=-17.007000;z=1001.179993;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/ILL6",true)==0){s="VERY Elaborate and NO, you can't ride the horsey!";
t="Tiger Skin Rug Brothel";u="BROTHL2";
v=3;w=90;x=964.106995;y=-53.205498;z=1001.179993;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/ILL7",true)==0){s="Pleasure DOMES (roof scaffolding)";t="Jizzy's Pleasure Domes";u="PDOMES";
v=3;w=180;x=-2661.009766;y=1415.739990;z=923.305969;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/ILL8",true)==0){s="Pleasure DOMES (front entrance)";t="Jizzy's Pleasure Domes";u="PDOMES2";
v=3;w=90;x=-2637.449951;y=1404.629883;z=906.457947;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// LIBERTY CITY /////////////////////////
if(strcmp(cmd,"/LIB",true)==0){
SendClientMessage(playerid,C,"=== Liberty City ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/LIB1 - Marco's Bistro (from the street)");
SendClientMessage(playerid,C,"/LIB2 - Marco's Bistro Front Patio");
SendClientMessage(playerid,C,"/LIB3 - Marco's Bistro Inside/Upstairs");
SendClientMessage(playerid,C,"/LIB4 - Marco's Bistro Back yard");
SendClientMessage(playerid,C,"/LIB5 - Marco's Bistro Roof (Photo Op)");
SendClientMessage(playerid,C,"/LIB6 - Marco's Bistro Kitchen");
SendClientMessage(playerid,C,"There's not much up here but everybody wants to get here!");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/LIB1",true)==0){s="Positioning is mine";t="Marco's Bistro (from the street)";u="Spectre";
v=1;w=40;x=-735.5619504;y=484.351318;z=1371.952270;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/LIB2",true)==0){s="Positioning is mine";t="Marco's Bistro Front Patio";u="Spectre";
v=1;w=90;x=-777.7556764;y=500.178070;z=1376.600463;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/LIB3",true)==0){s="Positioning is mine";t="Marco's Bistro Inside/Upstairs";u="Spectre";
v=1;w=0;x=-794.8064;y=491.6866;z=1376.195;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/LIB4",true)==0){s="Positioning is mine";t="Marco's Bistro Back Yard";u="Spectre";
v=1;w=0;x=-835.2504;y=500.9161;z=1358.305;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/LIB5",true)==0){s="Positioning is mine (good photo op)";t="Marco's Bistro Rooftop";u="Spectre";
v=1;w=90;x=-813.431518;y=533.231079;z=1390.782958;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/LIB6",true)==0){s="Positioning is mine";t="Marco's Bistro Kitchen";u="Spectre";
v=1;w=180;x=-789.432800;y=509.146972;z=1367.374511;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// MISCELLANEOUS /////////////////////////
if(strcmp(cmd,"/MSC",true)==0){
SendClientMessage(playerid,C,"=== MISCELLANEOUS STUFF === ");
SendClientMessage(playerid,C,"/MSC1 - Burning Desire Gang House");
SendClientMessage(playerid,C,"/MSC2 - Colonel Furburgher's House");
SendClientMessage(playerid,C,"/MSC3 - Crack Den");
SendClientMessage(playerid,C,"/MSC4 & /MSC5 -  2 Warehouses (4-empty/5-pillars)");
SendClientMessage(playerid,C,"/MSC6 - Sweet's Garage");
SendClientMessage(playerid,C,"/MSC7 - Lil' Probe Inn bathroom");
SendClientMessage(playerid,C,"/MSC8 - Unused Safe House");
SendClientMessage(playerid,C,"/MSC9 & /MSC10 - RC Battlefield (roof & inside)");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/MSC1",true)==0){s="Where you 1st meet Denise";t="Burning Desire Gang House";u="GANG";
v=5;w=90;x=2350.339844;y=-1181.649902;z=1028.000000; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/MSC2",true)==0){s="Built a lot like CJ's house";t="Colonel Furhberger's";u="BURHOUS";
v=8;w=0;x=2807.619873;y=-1171.899902;z=1025.579956;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/MSC3",true)==0){s="Notorious for the back room couch bj";t="Crack House";u="LACRAK";
v=5;w=0;x=318.564972;y=1118.209961;z=1083.979980; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/MSC4",true)==0){s="Big & empty with no roof";t="Warehouse";u="SMASHTV";
v=1;w=135;x=1412.639893;y=-1.787510;z=1000.931946;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/MSC5",true)==0){s="GENeric WaReHouSe - Lots of pillars";t="Warehouse";u="GENWRHS";
v=18;w=135;x=1302.519897;y=-1.787510;z=1000.931946;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/MSC6",true)==0){s="Would make a good jail cell";t="Inside Sweet's Garage";u="Spectre";
v=0;w=90;x=2522.0;y=-1673.383911;z=14.8;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/MSC7",true)==0){s="Would make a good jail cell";t="Lil' Probe Inn bathroom";u="Spectre";
v=18;w=90;x=-219.322601;y=1410.444824;z=27.773437;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/MSC8",true)==0){s="Pretty nice place...BUT NO BATHROOM!",t="Unused Safe House";u="SVLABIG";
v=12;w=0;x=2324.419922;y=-1147.539917;z=1050.719971;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/MSC9",true)==0){s="On the roof";t="RC Battlefield (on the roof)";u="Spectre";
v=10;w=90;x=-972.4957;y=1060.983;z=1358.914;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/MSC10",true)==0){s="On the Battlefield";t="RC Battlefield (on the field)";u="Spectre";
v=10;w=90;x=-972.4957;y=1060.983;z=1345.669;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// PERSONAL GROOMING /////////////////////////
if(strcmp(cmd,"/PER",true)==0){
SendClientMessage(playerid,C,"=== Barber Shops & Tattoo Parlors ===");
SendClientMessage(playerid,C,"/PER1 - Old Reece's Hair Facial Studio in Idlewood, LS");
SendClientMessage(playerid,C,"/PER2 - Gay Gordo's Barber Shop in Dillimore, the");
SendClientMessage(playerid,C,"               Barber's Pole in Queens, SF and");
SendClientMessage(playerid,C,"               Gay Gordo's Boufon Boutique in Redsands East, LV");
SendClientMessage(playerid,C,"/PER3 - Macisla's Unisex Hair Salon in Playa Del Seville, LS");
SendClientMessage(playerid,C,"/PER4 - Unnamed Tattoo Parlor in Idlewood, LS");
SendClientMessage(playerid,C,"/PER5 - Hemlock Tattoo parlor in Hashbury, SF");
SendClientMessage(playerid,C,"/PER6 - Unnamed Tattoo parlor in Redsands East, LV");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/PER1",true)==0){s="Check out the Jackson 5 pix on the wall!";
t="Old Reece's Hair Facial Studio in Idlewood,LS";u="BARBERS";
v=2;w=315;x=411.625977;y=-21.433298;z=1001.799988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/PER2",true)==0){s="Gay Gordo's got a shop in 'Queens'? Go figure.";
t="Gay Gordo's Barber Shop in Dillimore, The Barber's Pole in Queens and Gay Gordo's Boufon Boutique in Redsands East"
;u="BARBER2";v=3;w=0;x=418.652985;y=-82.639793;z=1001.959961;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/PER3",true)==0){s="The writing on the windows isn't visible from the outside!";
t="Macisla's Unisex Hair Salon";u="BARBER3";
v=12;w=270;x=412.021973;y=-52.649899;z=1001.959961;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/PER4",true)==0){s="NONE";t="Unnamed Tattoo Parlor Idlewood & Willowfield";u="TATTOO";
v=16;w=315;x=-204.439987;y=-26.453999;z=1002.299988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/PER5",true)==0){s="TATTOo Parlor on Island 2";t="Hemlock Tattoo parlor in Hashbury, SF";u="TATTO2";
v=17;w=315;x=-204.439987;y=-8.469600;z=1002.299988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/PER6",true)==0){s="TATTOo Parlor on Island 3";t="Unnamed Tattoo parlor in Redsands East, LV";u="TATTO3";
v=3;w=315;x=-204.439987;y=-43.652496;z=1002.299988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// POLICE DEPARTMENTS /////////////////////////
if(strcmp(cmd,"/POL",true)==0){
SendClientMessage(playerid,C,"=== POLICE DEPARTMENTS ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/POL1 - Los Santos");
SendClientMessage(playerid,C,"/POL2 - San Fierro");
SendClientMessage(playerid,C,"/POL3 - Las Venturas (upper entrance)");
SendClientMessage(playerid,C,"/POL4 - Las Venturas (street entrance)");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/POL1",true)==0){s="NONE";t="Los Santos PD";u="POLICE1";
v=6;w=0;x=246.783997;y=63.900200;z=1003.639954; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/POL2",true)==0){s="NONE";t="San Fierro PD";u="POLICE2";
v=10;w=0;x=246.375992;y=109.245995;z=1003.279968; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/POL3",true)==0){s="NONE";t="Las Venturas PD (upper entrance)";u="POLICE3";
v=3;w=0;x=288.745972;y=169.350998;z=1007.179993; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/POL4",true)==0){s="NONE";t="Las Venturas PD (street entrance)";u="POLICE4";
v=3;w=0;x=238.661987;y=141.051987;z=1003.049988; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// SCHOOLS /////////////////////////
if(strcmp(cmd,"/SCH",true)==0){
SendClientMessage(playerid,C,"=== SCHOOLS ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/SCH1 - Cycle School");
SendClientMessage(playerid,C,"/SCH2 - Automobile School");
SendClientMessage(playerid,C,"/SCH3 - Plane School");
SendClientMessage(playerid,C,"/SCH4 - Boat School*");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"* added for continuity purposes");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/SCH1",true)==0){s="BIKe SCHool";t="Bike School";u="BIKESCH";
v=3;w=90;x=1494.429932;y=1305.629883;z=1093.289917;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/SCH2",true)==0){s="DRIVE School";t="Driving School";u="DRIVES";
v=3;w=90;x=-2029.719971;y=-115.067993;z=1035.169922;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/SCH3",true)==0){s="DESerted HOUSe? DESert HOUSE?";t="Abandoned AC tower";u="DESHOUS";
v=10;w=45;x=420.484985;y=2535.589844;z=10.020289;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/SCH4",true)==0){s="Mentioned for continuity purposes only";t="Boat School";u="Spectre";
v=0;w=45;x=-2184.751464;y=2413.111816;z=5.156250;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// STADIUMS /////////////////////////
if(strcmp(cmd,"/STA",true)==0){
SendClientMessage(playerid,C,"=== STADIUMS ===");
SendClientMessage(playerid,C,"/STA1 - 8Track");
SendClientMessage(playerid,C,"/STA2 & /STA3 - Bloodbowl - lowel/upper levels");
SendClientMessage(playerid,C,"/STA4 - DirtBike");
SendClientMessage(playerid,C,"/STA5 - Kickstart");
SendClientMessage(playerid,C,"/STA6 - Vice Street Racers");
SendClientMessage(playerid,C,"/STA7 - Bandits Baseball Field");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"(all the coordinates are of my choosing)");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/STA1",true)==0){s="Um, 'cause it's shaped like an eight?";t="8-Track Stadium";u="8TRACK";
v=7;w=90;x=-1397.782470;y=-203.723114;z=1051.346801;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/STA2",true)==0){s="On the garage roof";t="Bloodbowl Stadium (in the bowl)";u="Spectre";
v=15;w=0;x=-1398.103515;y=933.445434;z=1041.531250;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/STA3",true)==0){s="Lighting is strange";t="Bloodbowl Stadium (upper loop)";u="Spectre";
v=15;w=315;x=-1396.110351;y=903.513671;z=1041.525390;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/STA4",true)==0){s="DIRt BIKE";t="Dirtbike Stadium";u="DIRBIKE";
v=4;w=45;x=-1428.809448;y=-663.595886;z=1060.219848;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/STA5",true)==0){s="This is just TOO cool!";t="Kickstart Stadium";u="Spectre";
v=14;w=225;x=-1486.861816;y=1642.145996;z=1060.671875;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/STA6",true)==0){s="Only center area is solid";t="Vice Stadium";u="Spectre";
v=1;w=90;x=-1401.830000;y=107.051300;z=1032.273000;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/STA7",true)==0){s="Included for continuity purposes";t="Bandits Baseball field";u="Spectre";
v=0;w=135;x=1382.615600;y=2184.345703;z=11.023437;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///// ///// ///// ///// ///// ///// ///// FUNCTIONAL OPTIONS ///// ///// ///// ///// ///// /////



if(strcmp(cmd,"/MENU",true)==0){
SendClientMessage(playerid,C," --- Main Menu  --- to see the submenus type /code (ex: /MENU1)");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/MENU1 - 24/7s thru Car Mod shops");
SendClientMessage(playerid,C,"/MENU2 - Casino Oddities thru Girlfriends");
SendClientMessage(playerid,C,"/MENU3 - Government thru Miscellaneous");
SendClientMessage(playerid,C,"/MENU4 - Personal Grooming thru Stadiums");
SendClientMessage(playerid,C,"/MENU5 - other");
SendClientMessage(playerid,C,"/MENU6 - other");
SendClientMessage(playerid,C,"type /MENU to return to this screen...");return 1;}

if(strcmp(cmd,"/MENU1",true)==0){
SendClientMessage(playerid,C," --- Menu 1 --- to see the submenus type /code (ex: /AIR)");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/247 - 24/7s (6)");
SendClientMessage(playerid,C,"/AIR - All things aerodynamic (4)");
SendClientMessage(playerid,C,"/AMU - Ammunations (6)");
SendClientMessage(playerid,C,"/X - Burglary Houses (23)");
SendClientMessage(playerid,C,"/BUS - Businesses (8)");
SendClientMessage(playerid,C,"/CAR - Car Mod shops (5) (DANGER!...CRASH HAZARD!)");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU1 to return to this screen...");return 1;}

if(strcmp(cmd,"/MENU2",true)==0){
SendClientMessage(playerid,C," --- Menu 2 --- to see the submenus type /code (ex: /CAS)");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/CAS - Casino oddities (5)");
SendClientMessage(playerid,C,"/CLO - Clothing shops (6)");
SendClientMessage(playerid,C,"/CLU - Bars & Clubs (4)");
SendClientMessage(playerid,C,"/EAT - Diners & Eateries (5)");
SendClientMessage(playerid,C,"/FST - Fast Food joints (4)");
SendClientMessage(playerid,C,"/GRL - Girlfriend Bedrooms (6)");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU2 to return to this screen...");return 1;}

if(strcmp(cmd,"/MENU3",true)==0){
SendClientMessage(playerid,C," --- Menu 3 --- to see the submenus type /code (ex: /GOV)");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/GOV - Government related businesses (6)");
SendClientMessage(playerid,C,"/GYM - Gyms (5)");
SendClientMessage(playerid,C,"/HOM - Homies (17)");
SendClientMessage(playerid,C,"/ILL - Places of Ill Repute (8)");
SendClientMessage(playerid,C,"/LIB - Liberty City (6) (pretty boring actually)");
SendClientMessage(playerid,C,"/MSC - Miscellaneous stuff (8)");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU3 to return to this screen...");return 1;}

if(strcmp(cmd,"/MENU4",true)==0){
SendClientMessage(playerid,C," --- Menu 4 --- to see the submenus type /code (ex: /PER)");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/PER - Personal Grooming (6) (Barbershops & Tattoo parlors)");
SendClientMessage(playerid,C,"/POL - Police Departments (4)");
SendClientMessage(playerid,C,"/SCH - Vehicle Schools (4)");
SendClientMessage(playerid,C,"/STA - Stadiums (8)");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU4 to return to this screen...");return 1;}
	if(strcmp(cmd, "/menu5", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Menu 5 (1st list of interior catagories)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/aira - for all things aerodynamic (6)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/stra - strip club interiors (3)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gara - garage interiors (3)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Type /menu6 to see the 2nd list of catagories");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

	if(strcmp(cmd, "/menu6", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Menu 6 (2nd list of interior catagories)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/wara - warehouse interiors (3)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/casa - casino oddities (3)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/busa - businesses (6)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gova - government run organizations (6)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Type /menu5 to go to the 1st list of catagories");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

	if(strcmp(cmd, "/aira", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Aerodynamic Interiors");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/aira1 - LS Int Airport (baggage reclaim)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/aira2 - Verdant Meadow AC Tower");
		    SendClientMessage(playerid, COLOR_YELLOW, "/aira3 - LS Customs Cabin");
		    SendClientMessage(playerid, COLOR_YELLOW, "/aira4 - SF Customs Cabin (main gates)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/aira5 - SF Customs Cabin (rear gates)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/aira6 - LV Customs Cabin");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

	if(strcmp(cmd, "/aira1", true)==0)
		{
			SetPlayerInterior(playerid, 14);
      		SetPlayerFacingAngle(playerid, 125);
	        SetPlayerPos(playerid, -1856.061401,59.451751,1056.354492);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: -1856.061401");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 59.451751");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1056.354492");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 125");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 14");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Los Santos International Airport (baggage reclaim)");
		    SendClientMessage(playerid, COLOR_RED, "DO NOT MOVE, ROOM ISN'T SOLID!");
		    return 1;
		}

	if(strcmp(cmd, "/aira2", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 180);
	        SetPlayerPos(playerid, 412.940093,2543.499267,26.582641);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 412.940093");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 2543.499267");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 26.582641");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 180");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Verdant Meadow Abandoned AC Tower");
		    SendClientMessage(playerid, COLOR_YELLOW, "Nice view =)");
		    return 1;
		}


	if(strcmp(cmd, "/aira3", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 270);
	        SetPlayerPos(playerid, 1955.634033,-2181.589355,13.586477);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1955.634033");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -2181.589355");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 13.586477");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 270");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Los Santos Customs Cabin");
		    SendClientMessage(playerid, COLOR_YELLOW, "It's empty, no furniture =O");
		    return 1;
		}


	if(strcmp(cmd, "/aira4", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 45);
	        SetPlayerPos(playerid, -1544.394897,-443.713562,6.100000);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: -1544.394897");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -443.713562");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 6.100000");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 45");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "San Fiero Customs Cabin (main gates)");
		    SendClientMessage(playerid, COLOR_YELLOW, "Furniture isn't solid");
		    return 1;
		}

	if(strcmp(cmd, "/aira5", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 320);
	        SetPlayerPos(playerid, -1229.471191,55.351161,14.232812);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: -1229.471191");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 55.351161");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 14.232812");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 320");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "San Fiero Customs Cabin (rear gates)");
		    SendClientMessage(playerid, COLOR_YELLOW, "Furniture isn't solid");
		    return 1;
		}

	if(strcmp(cmd, "/aira6", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 160);
	        SetPlayerPos(playerid, 1717.427612,1617.371337,10.117187);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1717.427612");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 1617.371337");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 10.117187");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 160");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Las Venturas Customs Cabin");
		    SendClientMessage(playerid, COLOR_YELLOW, "All complete (would be good for roleplay)");
		    return 1;
		}

	if(strcmp(cmd, "/stra", true) == 0)
		{
	        SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Strip Club Interiors");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/stra1 - Big Spread Ranch");
		    SendClientMessage(playerid, COLOR_YELLOW, "/stra2 - Big Spread Ranch (private dance room)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/stra3 - Big Spread Ranch (behind bar)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

	if(strcmp(cmd, "/stra1", true)==0)
		{
			SetPlayerInterior(playerid, 3);
      		SetPlayerFacingAngle(playerid, 90);
	        SetPlayerPos(playerid, 1215.219726,-30.991367,1000.960571);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1215.219726");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -30.991367");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1000.960571");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 90");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 3");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Big Spread Ranch");
		    SendClientMessage(playerid, COLOR_YELLOW, "Also same interior as 'Nude Strippers Daily'");
		    return 1;
		}

	if(strcmp(cmd, "/stra2", true)==0)
		{
			SetPlayerInterior(playerid, 3);
      		SetPlayerFacingAngle(playerid, 180);
	        SetPlayerPos(playerid, 1207.651123,-42.554019,1000.953125);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1207.651123");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -42.554019");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1000.953125");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 180");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 3");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Big Spread Ranch (private dance room)");
		    SendClientMessage(playerid, COLOR_RED, "ONLY THE FLOOR IS SOLID!");
		    return 1;
		}

	if(strcmp(cmd, "/stra3", true)==0)
		{
			SetPlayerInterior(playerid, 3);
      		SetPlayerFacingAngle(playerid, 270);
	        SetPlayerPos(playerid, 1206.233398,-29.270675,1000.953125);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1206.233398");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -29.270675");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1000.953125");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 270");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 3");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Big Spread Ranch (behind bar)");
		    SendClientMessage(playerid, COLOR_YELLOW, "You've never been here, roof is too low to jump ;)");
		    return 1;
		}

	if(strcmp(cmd, "/gara", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Garage Interiors");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gara1 - Garage in Esplanade North, SF");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gara2 - Garage in Commerce, LS");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gara3 - SF Bomb Shop");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

	if(strcmp(cmd, "/gara1", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 0);
	        SetPlayerPos(playerid, -1790.264160,1432.254638,7.187500);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: -1790.264160");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 1432.254638");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 7.187500");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 0");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Garage in Esplanade North, at the docks");
		    SendClientMessage(playerid, COLOR_YELLOW, "Used in a mission cut scene for storage");
		    return 1;
		}

	if(strcmp(cmd, "/gara2", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 0);
	        SetPlayerPos(playerid, 1644.026489,-1518.588500,13.567542);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1644.026489");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -1518.588500");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 13.567542");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 0");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Garage in Commerce, Los Santos");
		    SendClientMessage(playerid, COLOR_YELLOW, "Used in mission 'Life's a Beach' for OG Loc");
		    return 1;
		}


	if(strcmp(cmd, "/gara3", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 90);
	        SetPlayerPos(playerid, -1684.447631,1035.754516,45.210937);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: -1684.447631");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 1035.754516");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 45.210937");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 90");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "San Fiero Bomb Shop");
		    SendClientMessage(playerid, COLOR_YELLOW, "Remember this?");
		    return 1;
		}


	if(strcmp(cmd, "/wara", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Warehouse Interiors");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/wara1 - Warehouse in Blueberry, RC");
		    SendClientMessage(playerid, COLOR_YELLOW, "/wara2 - Warehouse in Whitewood Estates, LV (part 1)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/wara3 - Warehouse in Whitewood Estates, LV (part 2)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

	if(strcmp(cmd, "/wara1", true)==0)
		{
	    	SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 180);
	        SetPlayerPos(playerid, 52.093002,-302.419616,1.700098);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 52.093002");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -302.419616");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1.700098");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 180");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Warehouse in Blueberry, Red County");
		    SendClientMessage(playerid, COLOR_YELLOW, "Good for a hideout, can't remember it ever being used");
		    return 1;
		}

	if(strcmp(cmd, "/wara2", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 270);
	        SetPlayerPos(playerid, 1058.787353,2087.521240,10.820312);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1058.787353");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 2087.521240");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 10.820312");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 270");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Warehouse in Whitewood Estates, Las Venturas");
		    SendClientMessage(playerid, COLOR_YELLOW, "Used in mission 'You've Had Your Chips' for Woozie");
		    return 1;
		}
	if(strcmp(cmd, "/wara3", true)==0)
		{
  			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 270);
	        SetPlayerPos(playerid, 1057.757446,2148.187988,10.820312);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1057.757446");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 2148.187988");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 10.820312");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 270");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Warehouse in Whitewood Estates, Las Venturas");
		    SendClientMessage(playerid, COLOR_YELLOW, "This is a hidden part of the warehouse never seen in San Andreas");
		    return 1;
		}
	if(strcmp(cmd, "/casa", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Caligula's >VS< Four Dragons");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/casa1 - Caligula's Casino (hidden room)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/casa2 - Caligula's Casino (office) - Don't get excited!");
		    SendClientMessage(playerid, COLOR_YELLOW, "/casa3 - Four Dragons Casino (garage)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/casa4 - Four Dragons Casino (management room)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

	if(strcmp(cmd, "/casa1", true)==0)
		{
			SetPlayerInterior(playerid, 1);
      		SetPlayerFacingAngle(playerid, 90);
	        SetPlayerPos(playerid, 2133.730712,1599.510375,1008.359375);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 2133.730712");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 1599.510375");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1008.359375");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 90");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 1");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Caligula's Casino Hidden Room");
		    SendClientMessage(playerid, COLOR_YELLOW, "Just an empty room hidden behind a door in Caligula's");
		    return 1;
		}

	if(strcmp(cmd, "/casa3", true)==0)
		{
  			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 0);
	        SetPlayerPos(playerid, 1903.478149,970.919982,10.820312);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1903.478149");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 970.919982");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 10.820312");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 0");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "The Four Dragons Casino Garage");
		    SendClientMessage(playerid, COLOR_YELLOW, "Has been seen in end of mission cut scenes");
		    return 1;
		}


	if(strcmp(cmd, "/casa4", true)==0)
		{
			SetPlayerInterior(playerid, 11);
      		SetPlayerFacingAngle(playerid, 0);
	        SetPlayerPos(playerid, 2013.760986,1016.695556,39.091094);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 2013.760986");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 1016.695556");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 39.091094");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 0   Interior: 11");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "The Four Dragons Casino Management Room");
		    SendClientMessage(playerid, COLOR_YELLOW, "An all time favourite interior, you are safe up on the roof =)");
		    SendClientMessage(playerid, COLOR_RED, "Room isn't solid, DO NOT cross onto the north side of the roof!");
		    return 1;
		}

	if(strcmp(cmd, "/busa", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Interiors of Commerce");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/bus1 - Liquor Store, Blueberry");
		    SendClientMessage(playerid, COLOR_YELLOW, "/bus2 - unused Motel room 1");
		    SendClientMessage(playerid, COLOR_YELLOW, "/bus3 - unused Motel room 2");
		    SendClientMessage(playerid, COLOR_YELLOW, "/bus4 - Bank, Palomino Creek");
		    SendClientMessage(playerid, COLOR_YELLOW, "/bus5 - Bank, Palomino Creek (behind counter)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/bus6 - Atrium, LS");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}


	if(strcmp(cmd, "/busa1", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 180);
	        SetPlayerPos(playerid, 252.107192,-54.828540,1.577644);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 252.107192");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -54.828540");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1.577644");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 180");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Liquor Store in Blueberry, Red County");
		    SendClientMessage(playerid, COLOR_YELLOW, "Nice place, once seen in a mission with Catalina");
		    return 1;
		}

	if(strcmp(cmd, "/busa2", true)==0)
		{
			SetPlayerInterior(playerid, 10);
      		SetPlayerFacingAngle(playerid, 270);
	        SetPlayerPos(playerid, 2261.401123,-1135.940551,1050.632812);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 2261.401123");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -1135.940551");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1050.632812");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 270");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 10");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "An unused Motel room");
		    SendClientMessage(playerid, COLOR_YELLOW, "Even got a wardrobe =D");
		    return 1;
		}

	if(strcmp(cmd, "/busa3", true)==0)
		{
			SetPlayerInterior(playerid, 9);
      		SetPlayerFacingAngle(playerid, 90);
	        SetPlayerPos(playerid, 2253.139892,-1140.089965,1050.632812);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 2253.139892");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -1140.089965");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1050.632812");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 90");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 9");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Another unused Motel room");
		    SendClientMessage(playerid, COLOR_YELLOW, "Also got a wardrobe =D");
		    return 1;
		}


	if(strcmp(cmd, "/busa4", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 270);
	        SetPlayerPos(playerid, 2306.387695,-16.136718,26.749565);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 2306.387695");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -16.136718");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 26.749565");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 270");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Bank in Palomino Creek, Red County");
		    SendClientMessage(playerid, COLOR_YELLOW, "Once seen in a mission with Catalina, would be great for Roleplay!");
		    return 1;
		}

	if(strcmp(cmd, "/busa5", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 90);
	        SetPlayerPos(playerid, 2318.324951,-7.291463,26.749565);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 2318.324951");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -7.291463");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 26.749565");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 90");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Bank in Palomino Creek, Red County (behind counter)");
		    SendClientMessage(playerid, COLOR_YELLOW, "'There is your change, and here is your receipt. Have a good day sir'");
		    return 1;
		}


	if(strcmp(cmd, "/busa6", true)==0)
		{
     		SetPlayerInterior(playerid, 18);
      		SetPlayerFacingAngle(playerid, 40);
	        SetPlayerPos(playerid, 1728.494995,-1668.352294,22.609375);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1728.494995");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -1668.352294");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 22.609375");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 40");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 18");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Atrium Hotel in Commerce, Los Santos");
		    SendClientMessage(playerid, COLOR_YELLOW, "Used in mission 'Just Business' for Big Smoke");
		    return 1;
		}


	if(strcmp(cmd, "/gova", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Government Interiors");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gova4 - Dillimore PD");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gova5 - Dillimore PD (jail cell)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gova6 - Dillimore PD (private room)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;}

	if(strcmp(cmd, "/gova4", true)==0)
		{
			SetPlayerInterior(playerid, 6);
      		SetPlayerFacingAngle(playerid, 0);
	        SetPlayerPos(playerid, 246.682373,65.300575,1003.640625);
			
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 246.682373");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 65.300575");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1003.640625");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 0");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 6");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Dillimore Police Dept");
		    SendClientMessage(playerid, COLOR_YELLOW, "Same interior as Los Santos PD");
		    return 1;
		}

	if(strcmp(cmd, "/gova5", true)==0)
		{
	    	SetPlayerInterior(playerid, 6);
      		SetPlayerFacingAngle(playerid, 270);
	        SetPlayerPos(playerid, 264.250000,77.507400,1001.039062);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 264.250000");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 77.507400");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1001.039062");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 270");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 6");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Dillimore Police Dept (jail cell)");
		    SendClientMessage(playerid, COLOR_YELLOW, "Very useful for RPG gamemodes =)");
		    return 1;
		}

	if(strcmp(cmd, "/gova6", true)==0)
		{
			SetPlayerInterior(playerid, 6);
      		SetPlayerFacingAngle(playerid, 0);
	        SetPlayerPos(playerid, 232.118377,66.382949,1005.039062);
  		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 232.118377");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 66.382949");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1005.039062");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 0");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 6");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Dillimore Police Dept (private room)");
		    SendClientMessage(playerid, COLOR_RED, "Walls are NON-solid!");
		    return 1;
		}


	if(strcmp(cmd, "/clear", true) == 0)
		{	ClearPlayerChatBox(playerid);
		    return 1;}

	if(strcmp(cmdtext, "/?", true) == 0)
  	{
     		new Float:xa,Float:ya,Float:za,Float:a;
    		new string1[256],string2[256],string3[256],string4[256];
     		GetPlayerPos(playerid,xa,ya,za);
     		GetPlayerFacingAngle(playerid,a);
     		format(string1,sizeof(string1),"X: %f",xa);
     		format(string2,sizeof(string2),"Y: %f",ya);
     		format(string3,sizeof(string3),"Z: %f",za);
     		format(string4,sizeof(string4),"A: %f",a);
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Current Position");
			SendClientMessage(playerid, COLOR_WHITE, " ");
     		SendClientMessage(playerid, COLOR_WHITE, string1);
     		SendClientMessage(playerid, COLOR_WHITE, string2);
     		SendClientMessage(playerid, COLOR_WHITE, string3);
     		SendClientMessage(playerid, COLOR_WHITE, string4);
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, " ");
     		return 1;}

	if(strcmp(cmd,"/thirst", true) == 0) {
	    new thirststring[256];
		format(thirststring,256,"THIRST: %d %",THIRSTY[playerid]);
		SendClientMessage(playerid, COLOR_GREEN, thirststring);
		return 1;}
    if(strcmp(cmd,"/hunger", true) == 0) {
        new hungerstring[256];
		format(hungerstring,256,"HUNGER: %d %",HUNGRY[playerid]);
		SendClientMessage(playerid, COLOR_GREEN, hungerstring);
		return 1;}
	if(strcmp(cmd,"/sex", true) == 0) {
 		new sexstring[256];
		format(sexstring,256,"SEX: %d %",SEXY[playerid]);
		SendClientMessage(playerid, COLOR_GREEN, sexstring);
		return 1;}
 	if(strcmp(cmd,"/getmoney", true) == 0) {
		GivePlayerMoney(playerid,1000);
		return 1;}
	return 0;
}

public OnPlayerInfoChange(playerid)
{
	printf("OnPlayerInfoChange(%d)");
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	printf("OnPlayerEnterVehicle(%d, %d, %d)", playerid, vehicleid, ispassenger);
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
	printf("OnPlayerLeaveCheckpoint(%d)", playerid);
	return 1;
}


stock PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tmpposx, Float:tmpposy, Float:tmpposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	tmpposx = (oldposx -x);
	tmpposy = (oldposy -y);
	tmpposz = (oldposz -z);
	if (((tmpposx < radi) && (tmpposx > -radi)) && ((tmpposy < radi) && (tmpposy > -radi)) && ((tmpposz < radi) && (tmpposz > -radi)))
	{
		return 1;
	}
	return 0;
}

OnPlayerEnterArea(playerid,areaid) {
	new Float:x, Float:y, Float:z;
	new vehicle = GetPlayerVehicleID(playerid);
if (areaid==PSvegas) {
	SendClientMessage(playerid, 0xFF7B7BAA, "U Are NOT a Carmechanic");
	if (IsPlayerInAnyVehicle(playerid)){
	GetPlayerPos(playerid,x,y,z);
	SetVehicleZAngle(vehicle,90.0);
	SetVehiclePos(vehicle,x-1,y,z);
	}
	else {
	GetPlayerPos(playerid,x,y,z);
	SetPlayerFacingAngle(playerid,90.0);
   SetPlayerPos(playerid,x-1,y,z);}
   }
if (areaid==PSlaEast || areaid==TSSpecialSF) {
   	SendClientMessage(playerid, 0xFF7B7BAA, "U Are NOT a Carmechanic");
	if (IsPlayerInAnyVehicle(playerid)){
	GetPlayerPos(playerid,x,y,z);
	SetVehicleZAngle(vehicle,270.0);
	SetVehiclePos(vehicle,x+1,y,z);
	}
	else {
	GetPlayerPos(playerid,x,y,z);
	SetPlayerFacingAngle(playerid,270.0);
   SetPlayerPos(playerid,x+1,y,z);}}
if (areaid==PSdesertNorth || areaid==PSsanfranNorth || areaid==PSlaWest || areaid==TSlaSpecial) {
   	SendClientMessage(playerid, 0xFF7B7BAA, "U Are NOT a Carmechanic");
	if (IsPlayerInAnyVehicle(playerid)){
	GetPlayerPos(playerid,x,y,z);
	SetVehicleZAngle(vehicle,0.0);
	SetVehiclePos(vehicle,x,y+1,z);
	}
	else {
	GetPlayerPos(playerid,x,y,z);
	SetPlayerFacingAngle(playerid,0.0);
   SetPlayerPos(playerid,x,y+1,z);}}
if (areaid==TSvegas || areaid==PSdesertSouth || areaid==PSsanfranSouth || areaid==TSsanfran || areaid==PSlaNorth || areaid==PSlaCountry || areaid==TSLosAngeles ) {
   	SendClientMessage(playerid, 0xFF7B7BAA, "U Are NOT a Carmechanic");
	if (IsPlayerInAnyVehicle(playerid)){
	GetPlayerPos(playerid,x,y,z);
	SetVehicleZAngle(vehicle,180.0);
	SetVehiclePos(vehicle,x,y-1,z);
	}
	else {
	GetPlayerPos(playerid,x,y,z);
	SetPlayerFacingAngle(playerid,180.0);
   SetPlayerPos(playerid,x,y-1,z);}}
if (areaid==Soda1 || areaid==Soda2 || areaid==Soda3 || areaid==Soda4 || areaid==Soda5 || areaid==Soda6 || areaid==Soda7 || areaid==Soda8|| areaid==Soda9 || areaid==Soda10 || areaid==Soda11 || areaid==Soda12 || areaid==Soda13 || areaid==Soda14 ||
areaid==Soda15 || areaid==Soda16 || areaid==Soda17 || areaid==Soda18 || areaid==Soda19 || areaid==Soda20 || areaid==Soda21 || areaid==Soda22 || areaid==Soda23 || areaid==Soda24 || areaid==Soda25 || areaid==Soda26 || areaid==Soda27 || areaid==Soda28 || areaid==Soda29 ||
areaid==Soda30 || areaid==Soda31 || areaid==Soda32 || areaid==Soda33 || areaid==Soda34 || areaid==Soda35 || areaid==Soda36 || areaid==Soda37 || areaid==Soda38 || areaid==Soda39 || areaid==Soda40) {
	SendClientMessage(playerid, 0xFF7B7BAA, "Entered Soda");
    GetPlayerHealth(playerid,oldhealth);
    Sodamoney = GetPlayerMoney(playerid);
	timer1 = SetTimer("SODA",1,1);
}
if (areaid==Snack1 || areaid==Snack2 || areaid==Snack3 || areaid==Snack4 || areaid==Snack5 || areaid==Snack6 || areaid==Snack7 || areaid==Snack8|| areaid==Snack9 || areaid==Snack10 || areaid==Snack11 || areaid==Snack12 || areaid==Snack13 || areaid==Snack14 ||
areaid==Snack15 || areaid==Snack16 || areaid==Snack17 || areaid==Snack18 || areaid==Snack19 || areaid==Snack20 || areaid==Snack21 || areaid==Snack22 || areaid==Snack23 || areaid==Snack24 || areaid==Snack25 || areaid==Snack26) {
	SendClientMessage(playerid, 0xFF7B7BAA, "Entered Snack");
    GetPlayerHealth(playerid,oldhealth);
    Snackmoney = GetPlayerMoney(playerid);
	timer2 = SetTimer("SNACK",1,1);}
if (areaid==fastfood1 || areaid==fastfood2 || areaid==fastfood3) {
	SendClientMessage(playerid, 0xFF7B7BAA, "Entered Fastfood");
    GetPlayerHealth(playerid,oldhealth);
    foodmoney = GetPlayerMoney(playerid);
	timer3 = SetTimer("FASTFOOD",1,1);}
	}

OnPlayerLeaveArea(playerid,areaid) {
if (areaid==Soda1 || areaid==Soda2 || areaid==Soda3 || areaid==Soda4 || areaid==Soda5 || areaid==Soda6 || areaid==Soda7 || areaid==Soda8 || areaid==Soda9 || areaid==Soda10 || areaid==Soda11 || areaid==Soda12 || areaid==Soda13 || areaid==Soda14 ||
areaid==Soda15 || areaid==Soda16 || areaid==Soda17 || areaid==Soda18 || areaid==Soda19 || areaid==Soda20 || areaid==Soda21 || areaid==Soda22 || areaid==Soda23 || areaid==Soda24 || areaid==Soda25 || areaid==Soda26 || areaid==Soda27 || areaid==Soda28 || areaid==Soda29 ||
areaid==Soda30 || areaid==Soda31 || areaid==Soda32 || areaid==Soda33 || areaid==Soda34 || areaid==Soda35 || areaid==Soda36 || areaid==Soda37 || areaid==Soda38 || areaid==Soda39 || areaid==Soda40) {
	KillTimer(timer1);
    SendClientMessage(playerid, 0xFF7B7BAA, "Exit Soda");
	SetPlayerHealth(playerid,oldhealth);}
if (areaid==Snack1 || areaid==Snack2 || areaid==Snack3 || areaid==Snack4 || areaid==Snack5 || areaid==Snack6 || areaid==Snack7 || areaid==Snack8 || areaid==Snack9 || areaid==Snack10 || areaid==Snack11 || areaid==Snack12 || areaid==Snack13 || areaid==Snack14 ||
areaid==Snack15 || areaid==Snack16 || areaid==Snack17 || areaid==Snack18 || areaid==Snack19 || areaid==Snack20 || areaid==Snack21 || areaid==Snack22 || areaid==Snack23 || areaid==Snack24 || areaid==Snack25 || areaid==Snack26) {
	KillTimer(timer2);
    SendClientMessage(playerid, 0xFF7B7BAA, "Exit Snack");
	SetPlayerHealth(playerid,oldhealth);}
if (areaid==fastfood1 || areaid==fastfood2 || areaid==fastfood3) {
	KillTimer(timer3);
    SendClientMessage(playerid, 0xFF7B7BAA, "Exit Fastfood");
	SetPlayerHealth(playerid,oldhealth);}
  printf("OnPlayerLeaveArea(%d,%d)",playerid,areaid);}
  

