//#include <a_samp>
#include <yom_inc/functions.pwn>
#include <dudb>
#include <yom_inc/dini.pwn>
#include <dutils>
//#include <dini>
#include <dcallbacks>
#include <danticheat>
forward Speedometer();
#define dcmd(%1,%2,%3) if ((strcmp(%3, "/%1", true, %2+1) == 0)&&(((%3[%2+1]==0)&&(dcmd_%1(playerid,"")))||((%3[%2+1]==32)&&(dcmd_%1(playerid,%3[%2+2]))))) return 1
#define COLOR_SYSTEM 0xEFEFF7AA
#define COLOR_RED 0xAA3333AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_YELLOW 0xFFFF00AA
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
new Soda1;
//new Soda2;
new	timer1;
new Float:oldhealth;
new Sodamoney;
new newSodamoney;
new SEXY[MAX_PLAYERS];
new HUNGRY[MAX_PLAYERS];
new THIRSTY[MAX_PLAYERS];
new bufu[MAX_PLAYERS];
new Skin[MAX_PLAYERS];
new VehicleModels[260];

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

public Thirst(playerid){
	  if (IsPlayerConnected(playerid) && THIRSTY[playerid] <=100) {
	  THIRSTY[playerid] = THIRSTY[playerid] + 1;}
}
public Thirsthealth(playerid){
new Float:v;
	if (THIRSTY[playerid] >=25 && THIRSTY[playerid] <=50){
   GetPlayerHealth(playerid, v);
   SetPlayerHealth(playerid, v-1);}
   else if (THIRSTY[playerid] >50 && THIRSTY[playerid] <=75){
   GetPlayerHealth(playerid, v);
   SetPlayerHealth(playerid, v-2);}
   else if (THIRSTY[playerid] >75 && THIRSTY[playerid] <=100){
   GetPlayerHealth(playerid, v);
   SetPlayerHealth(playerid, v-3);}
}
public Hunger(playerid){
	  if (IsPlayerConnected(playerid) && HUNGRY[playerid] <=100) {
	  HUNGRY[playerid] = HUNGRY[playerid] + 1;}
}
public Hungerhealth(playerid){
new Float:v;
	if (HUNGRY[playerid] >=25 && HUNGRY[playerid] <=50){
   GetPlayerHealth(playerid, v);
   SetPlayerHealth(playerid, v-1);}
   else if (HUNGRY[playerid] >50 && HUNGRY[playerid] <=75){
   GetPlayerHealth(playerid, v);
   SetPlayerHealth(playerid, v-2);}
   else if (HUNGRY[playerid] >75 && HUNGRY[playerid] <=100){
   GetPlayerHealth(playerid, v);
   SetPlayerHealth(playerid, v-3);}
}
public SEX(playerid){
	  if (IsPlayerConnected(playerid) && SEXY[playerid] <=100) {
	  SEXY[playerid] = SEXY[playerid] + 1;}
}
public SEXhealth(playerid){
new Float:v;
	if (SEXY[playerid] >=25 && SEXY[playerid] <=50){
   GetPlayerHealth(playerid, v);
   SetPlayerHealth(playerid, v-1);}
   else if (SEXY[playerid] >50 && SEXY[playerid] <=75){
   GetPlayerHealth(playerid, v);
   SetPlayerHealth(playerid, v-2);}
   else if (SEXY[playerid] >75 && SEXY[playerid] <=100){
   GetPlayerHealth(playerid, v);
   SetPlayerHealth(playerid, v-3);}
}
public SODA(playerid){
	newSodamoney = GetPlayerMoney(playerid);
	if (newSodamoney==Sodamoney-1){
	THIRSTY[playerid]= THIRSTY[playerid]-2;
	Sodamoney=newSodamoney;}
	if (THIRSTY[playerid]< 0){
	THIRSTY[playerid]=0;}
	}
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

public PlayerName(playerid) {
  new name[MAX_PLAYER_NAME];
  GetPlayerName(playerid, name, MAX_PLAYER_NAME);
  return name;}
PName(playerid){
	new Name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,Name,sizeof(Name));
	return Name;}
#pragma unused PName

public PutAtPos(playerid) {
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
//	Soda2=AddAreaCheck(2086.0, 2088.0, 2070.5, 2072.5, 11.0, 12.0);
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
	if (bufu[playerid]==1){
	 dUserSetINT(PlayerName(playerid)).("skin",Skin[playerid]);}
	 }return false;}

public OnPlayerSpawn(playerid)
{
	if (!PLAYERLIST_authed[playerid])
	{SendClientMessage(playerid,COLOR_RED,"U have left the Server !!! ");
    Kick(playerid);
	}

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
	SetTimer("Thirst",30000,1);
	SetTimer("Hunger",60000,1);
	SetTimer("SEX",36000,1);
	SetTimer("Thirsthealth",50000,1);
	SetTimer("Hungerhealth",60000,1);
	SetTimer("SEXhealth",55000,1);
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
	dcmd(login,5,cmdtext); // because login has 5 characters
	dcmd(register,8,cmdtext); // because register has 8 charactersnew string[76];
	cmd = strtok(cmdtext, idx);
	cmd(cmd_speedo);
	
	if(strcmp(cmd,"/thirst", true) == 0) {
	    new thirststring[256];
		format(thirststring,256,"THIRST: %d %",THIRSTY[playerid]);
		GameTextForPlayer(playerid, thirststring, 1000, 1);
		return 1;}
    if(strcmp(cmd,"/hunger", true) == 0) {
        new hungerstring[256];
		format(hungerstring,256,"HUNGER: %d %",HUNGRY[playerid]);
		GameTextForPlayer(playerid, hungerstring, 1000, 1);
		return 1;}
	if(strcmp(cmd,"/sex", true) == 0) {
 		new sexstring[256];
		format(sexstring,256,"SEX: %d %",SEXY[playerid]);
		GameTextForPlayer(playerid, sexstring, 1000, 1);
		return 1;}
 	if(strcmp(cmd,"/getmoney", true) == 0) {
		GivePlayerMoney(playerid,1000);
		return 1;}
 	if(strcmp(cmd,"/oldhealth", true) == 0) {
 		new oldhstr[256];
		format(oldhstr,256,"OLDHEALTH: %d hp",Float:oldhealth);
		SendClientMessage(playerid, COLOR_GREEN, oldhstr);
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
if (areaid==Soda1) {
//	SendClientMessage(playerid, 0xFF7B7BAA, "Entered Soda");
    GetPlayerHealth(playerid,oldhealth);
    Sodamoney = GetPlayerMoney(playerid);
	timer1 = SetTimer("SODA",1,1);
}}

OnPlayerLeaveArea(playerid,areaid) {
if (areaid==Soda1) {
	KillTimer(timer1);
    SendClientMessage(playerid, 0xFF7B7BAA, "Exit Soda");
	SetPlayerHealth(playerid,oldhealth);}
  printf("OnPlayerLeaveArea(%d,%d)",playerid,areaid);}
  

