/*  SA:MP Useful Functions
 *
 *  (c) Copyright 2005-2006, Credits:
 *
 *  Alex "Y_Less" Cole
 *  Jan "DracoBlue" Schütze
 *  Gabriel "Larcius" Cordes
 *  Rafelder
 *  Mike
 *  Slick
 *  Allan
 *  SidViciousII
 *  Darkrealm
 *  El Presy
 *  Spectre
 *  mabako
 *  Sacky
 *  Boss
 *  Toxic
 *  dyraXon
 *  yellowblood
 *  50p
 *  rapidZ
 *  Tratulla
 *  Kamazy
 *  Simon
 *  yom
 *  Betamaster
 *  Peter
 *  kool
 *  Hellomy
 *
 */

#if defined _uf_included
	#endinput
#endif
#define _uf_included
#pragma library uf

#define MAX_STRING 255
#define MAX_VEHICLES_MODELS 212
#define MAX_PICKUPS 999
#define MAX_AREAS 500
#define MAX_FREEZE 100
#define FREEZE_COUNTDOWN MAX_FREEZE
#define FREEZE_COUNTUP MAX_FREEZE+1
#define FREEZE_MENU MAX_FREEZE+2
#define MAX_FREEZE_ALL FREEZE_MENU+1
#define VTYPE_CAR 1
#define VTYPE_HEAVY 2
#define VTYPE_MONSTER 3
#define VTYPE_BIKE 4
#define VTYPE_QUAD 5
#define VTYPE_BMX 6
#define VTYPE_HELI 7
#define VTYPE_PLANE 8
#define VTYPE_SEA 9
#define VTYPE_TRAILER 10
#define VTYPE_TRAIN 11
#define VTYPE_BOAT VTYPE_SEA
#define VTYPE_BICYCLE VTYPE_BMX
#define AREA_RECTANGLE 1
#define AREA_CIRCLE 2
#define AREA_ASHLAR 3
#define AREA_CUBE AREA_ASHLAR
#define AREA_SPHERE 4
#define AREA_CYLINDER 5
#define INF_INT 0x7F800000
const Float:INF_FLOAT=Float:0x7F800000;
const Float:PI=3.14159265;
#define SecToMS(%1) %1*1000
#define MinToMS(%1) %1*1000*60
#define HourToMS(%1) %1*1000*60*60
#define FORWARD 1
#define SIDELONG 2
#define SPEED_MPS 1
#define SPEED_KMPH 2
#define SPEED_MPH 3
#define ACC_MPS2 1
#define ACC_KMPH2 2
#define ACC_G 3

new stock VehicleNames[(MAX_VEHICLES_MODELS+1)][MAX_STRING] = {
   "Landstalker",
   "Bravura",
   "Buffalo",
   "Linerunner",
   "Pereniel",
   "Sentinel",
   "Dumper",
   "Firetruck",
   "Trashmaster",
   "Stretch",
   "Manana",
   "Infernus",
   "Voodoo",
   "Pony",
   "Mule",
   "Cheetah",
   "Ambulance",
   "Leviathan",
   "Moonbeam",
   "Esperanto",
   "Taxi",
   "Washington",
   "Bobcat",
   "Mr Whoopee",
   "BF Injection",
   "Hunter",
   "Premier",
   "Enforcer",
   "Securicar",
   "Banshee",
   "Predator",
   "Bus",
   "Rhino",
   "Barracks",
   "Hotknife",
   "Trailer", //artict1
   "Previon",
   "Coach",
   "Cabbie",
   "Stallion",
   "Rumpo",
   "RC Bandit",
   "Romero",
   "Packer",
   "Monster",
   "Admiral",
   "Squalo",
   "Seasparrow",
   "Pizzaboy",
   "Tram",
   "Trailer", //artict2
   "Turismo",
   "Speeder",
   "Reefer",
   "Tropic",
   "Flatbed",
   "Yankee",
   "Caddy",
   "Solair",
   "Berkley's RC Van",
   "Skimmer",
   "PCJ-600",
   "Faggio",
   "Freeway",
   "RC Baron",
   "RC Raider",
   "Glendale",
   "Oceanic",
   "Sanchez",
   "Sparrow",
   "Patriot",
   "Quad",
   "Coastguard",
   "Dinghy",
   "Hermes",
   "Sabre",
   "Rustler",
   "ZR3 50",
   "Walton",
   "Regina",
   "Comet",
   "BMX",
   "Burrito",
   "Camper",
   "Marquis",
   "Baggage",
   "Dozer",
   "Maverick",
   "News Chopper",
   "Rancher",
   "FBI Rancher",
   "Virgo",
   "Greenwood",
   "Jetmax",
   "Hotring",
   "Sandking",
   "Blista Compact",
   "Police Maverick",
   "Boxville",
   "Benson",
   "Mesa",
   "RC Goblin",
   "Hotring Racer", //hotrina
   "Hotring Racer", //hotrinb
   "Bloodring Banger",
   "Rancher",
   "Super GT",
   "Elegant",
   "Journey",
   "Bike",
   "Mountain Bike",
   "Beagle",
   "Cropdust",
   "Stunt",
   "Tanker", //petro
   "RoadTrain",
   "Nebula",
   "Majestic",
   "Buccaneer",
   "Shamal",
   "Hydra",
   "FCR-900",
   "NRG-500",
   "HPV1000",
   "Cement Truck",
   "Tow Truck",
   "Fortune",
   "Cadrona",
   "FBI Truck",
   "Willard",
   "Forklift",
   "Tractor",
   "Combine",
   "Feltzer",
   "Remington",
   "Slamvan",
   "Blade",
   "Freight",
   "Streak",
   "Vortex",
   "Vincent",
   "Bullet",
   "Clover",
   "Sadler",
   "Firetruck", //firela
   "Hustler",
   "Intruder",
   "Primo",
   "Cargobob",
   "Tampa",
   "Sunrise",
   "Merit",
   "Utility",
   "Nevada",
   "Yosemite",
   "Windsor",
   "Monster", //monstera
   "Monster", //monsterb
   "Uranus",
   "Jester",
   "Sultan",
   "Stratum",
   "Elegy",
   "Raindance",
   "RC Tiger",
   "Flash",
   "Tahoma",
   "Savanna",
   "Bandito",
   "Freight", //freiflat
   "Trailer", //streakc
   "Kart",
   "Mower",
   "Duneride",
   "Sweeper",
   "Broadway",
   "Tornado",
   "AT-400",
   "DFT-30",
   "Huntley",
   "Stafford",
   "BF-400",
   "Newsvan",
   "Tug",
   "Trailer", //petrotr
   "Emperor",
   "Wayfarer",
   "Euros",
   "Hotdog",
   "Club",
   "Trailer", //freibox
   "Trailer", //artict3
   "Andromada",
   "Dodo",
   "RC Cam",
   "Launch",
   "Police Car (LSPD)",
   "Police Car (SFPD)",
   "Police Car (LVPD)",
   "Police Ranger",
   "Picador",
   "S.W.A.T. Van",
   "Alpha",
   "Phoenix",
   "Glendale",
   "Sadler",
   "Luggage Trailer", //bagboxa
   "Luggage Trailer", //bagboxb
   "Stair Trailer", //tugstair
   "Boxville",
   "Farm Plow", //farmtr1
   "Utility Trailer", //utiltr1
   "Invalid Vehicle" //just to return if the modelid is invalid
};
#if defined OnPlayerBuyWeapon
new stock Float:lvammu[3][3] = {
(295.7932,-80.8074,1001.5156),
(295.5800,-80.4444,1001.5156),
(290.1626,-109.7770,1001.5156)
};
new stock Float:ammu[7][3] = {
(296.7232,-38.5011,1001.5156),
(313.0667,-165.7863,999.6010),
(296.5075,-38.5065,1001.5156),
(289.7543,-109.7784,1001.5156),
(296.1650,-80.8099,1001.5156),
(290.6806,-109.7799,1001.5156),
(290.4812,-109.7673,1001.5156)
};
#endif
#if defined OnPlayerGamble
new stock Float:gamble1[12][3] = {
(2230.7319,1589.3613,1007.1223),
(2230.9382,1595.0582,1007.1223),
(2230.7825,1615.1445,1007.1223),
(2230.1284,1619.4703,1007.1223),
(2241.9258,1619.5101,1007.1223),
(2241.4067,1614.7375,1007.1223),
(2242.6226,1595.3263,1007.1223),
(2242.6494,1589.4646,1007.1223),
(1958.8229,1025.9097,993.4035),
(1963.6870,1025.8323,993.4035),
(1959.4716,1010.6929,993.4035),
(1963.4226,1010.7554,993.4035)
};
new stock Float:gamble2[3][3] = {
(2230.3799,1604.6863,1006.1860),
(2241.3516,1604.2601,1006.1797),
(1126.4874,-1.4898,1000.6797)
};
new stock Float:gamble3[20][3] = {
(1969.5471,1029.5972,992.4745),
(1969.5416,1021.4896,992.4688),
(1969.5569,1014.0104,992.4688),
(1969.5547,1006.4145,992.4745),
(1969.7015,1029.5469,992.4745),
(1942.8903,1006.8364,992.4688),
(1941.8312,1013.9740,992.4688),
(1941.8381,1021.5088,992.4688),
(1942.5658,1028.6289,992.4688),
(2275.2219,1596.2104,1006.1797),
(2275.2146,1589.7419,1006.1797),
(2270.4824,1595.9219,1006.1797),
(2265.4377,1596.3553,1006.1797),
(2260.0259,1596.6718,1006.1797),
(2254.9976,1596.3917,1006.1797),
(2252.4050,1590.1534,1006.1797),
(2257.4419,1590.0051,1006.1797),
(2262.8257,1589.6021,1006.1797),
(2267.9023,1589.6578,1006.1797),
(1126.6071,2.9759,1000.6797)
};
new stock Float:gamble4[18][3] = {
(1965.8324,997.9891,992.4688),
(1962.9382,991.2863,992.4688),
(1965.8340,998.0048,992.4688),
(1958.1143,986.5440,992.4688),
(1965.8490,1037.6136,992.4688),
(1963.0631,1044.0096,992.4688),
(1958.1376,1049.0104,992.4688),
(2255.1760,1618.7878,1006.1797),
(2255.2905,1614.8890,1006.1797),
(2255.2170,1610.8423,1006.1797),
(2268.5320,1606.8667,1006.1797),
(2274.5471,1606.8854,1006.1797),
(2218.6533,1619.8169,1006.1794),
(2218.5603,1615.4678,1006.1797),
(2216.3044,1603.6766,1006.1819),
(2219.9624,1603.8689,1006.1797),
(2218.4788,1593.6322,1006.1871),
(2218.6128,1589.3203,1006.1841)
};
new stock Float:gamble5[2][3] = {
(1961.4709,1020.2551,992.4688),
(1961.5642,1015.8394,992.4688)
};
new stock Float:gamble6[5][3] = {
(2271.6360,1586.1650,1006.1797),
(2261.5183,1586.4304,1006.1797),
(2251.8772,1586.5632,1006.1860),
(1946.5306,986.7844,992.4688),
(1120.0988,-1.3969,1000.6908)
};
new stock Float:gamble7[1][3] = {
(1136.3954,-1.6494,1000.6797)
};
#endif
enum SpeedEnum
{
	Show,
	TextID,
	Float:MPS,
	Float:KMPH,
	Float:MPH
}
enum AccelerationEnum
{
	Show,
	TextID,
	Float:MPS2,
	Float:KMPH2,
	Float:G
}
enum PlayersEnum
{
	Float:X,
	Float:Y,
	Float:Z,
	Float:Health,
	Float:Armour,
	Last_Vehicle,
	Cur_Vehicle,
	Last_Team,
	Cur_Team,
	Money,
	State,
	Weapon,
	Score,
	Wanted,
	Freeze[MAX_FREEZE_ALL],
	Speed[SpeedEnum],
	Acceleration[AccelerationEnum]
}
enum VehiclesEnum
{
	Float:X,
	Float:Y,
	Float:Z,
	Float:Angle,
	Float:Health,
	Dynamic,
	Static,
	Last_Trailer,
	Cur_Trailer,
	Respawn,
	Color1,
	Color2,
	Objective[MAX_PLAYERS],
	Locked[MAX_PLAYERS]
}
enum PickupsEnum
{
	Float:X,
	Float:Y,
	Float:Z,
	Model,
	Respawn,
	Type
}
enum CounterDownEnum
{
	Style,
	TextID,
	Time
}
enum CounterUpEnum
{
	Style,
	TextID,
	Time,
	Time2
}
enum CountersEnum
{
	Down[CounterDownEnum],
	Up[CounterUpEnum]
}
enum AreasEnum
{
	Type,
	Float:X,
	Float:Y,
	Float:Z,
	Float:X2,
	Float:Y2,
	Float:Z2,
	Float:Radius,
	PlayerInArea[MAX_PLAYERS]
}
new stock preh[MAX_PLAYERS];
new stock bets[MAX_PLAYERS];
new stock betting[MAX_PLAYERS];
new stock Pickups[MAX_PICKUPS][PickupsEnum];
new stock Vehicles[MAX_VEHICLES][VehiclesEnum];
new stock Players[MAX_PLAYERS][PlayersEnum];
new stock Counters[MAX_PLAYERS][CountersEnum];
new stock Areas[MAX_AREAS][AreasEnum];
new stock SpeederTime=0;
new stock CountersTime=0;

stock GameModeInit()
{
	TextDrawCreate(0.0,0.0," ");
	SetTimer("ufctimer", 100, true);
	SetTimer("Counter", 10, true);
	SetTimerEx("Speeder", 10, true, "i", 1000);
	SetTimer("ClearOutOfRangeVehicles", 2000, true);
}

stock IsVehicleConnected(vehicleid) //By Sacky (edited by Gabriel "Larcius" Cordes)
{
	new Float:x1,Float:y1,Float:z1;
	GetVehiclePos(vehicleid,x1,y1,z1);
	if(x1==0.0 && y1==0.0 && z1==0.0)
	{
		return 0;
	}
	return 1;
}

stock IsPickupConnected(pickupid) //By Gabriel "Larcius" Cordes
{
	if(Pickups[pickupid][X]==0.0 && Pickups[pickupid][Y]==0.0 && Pickups[pickupid][Z]==0.0)
	{
		return 0;
	}
	return 1;
}

stock IsAreaConnected(areaid) //By Gabriel "Larcius" Cordes
{
	if(areaid<MAX_AREAS && Areas[areaid][Type])
	{
		return 1;
	}
	return 0;
}

stock TogglePlayerControllable2(playerid, controllable, freezeid=0) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid))
	{
		new isplfreeze=IsPlayerFreeze(playerid);
		if (controllable==0)
		{
			if(freezeid>=MAX_FREEZE_ALL || freezeid<0)
			{
				for(new i=0; i<MAX_FREEZE_ALL; i++)
				{
					Players[playerid][Freeze][i]=0;
				}
				Players[playerid][Freeze][0]=1;
			}
			else
			{
				Players[playerid][Freeze][freezeid]=1;
			}
			if(!isplfreeze)
			{
				TogglePlayerControllable(playerid, 0);
				#if defined OnPlayerToggleControllable
				OnPlayerToggleControllable(playerid, 0);
				#endif
			}
		}
		else
		{
			if(freezeid>=MAX_FREEZE_ALL || freezeid<0)
			{
				for(new i=0; i<MAX_FREEZE_ALL; i++)
				{
					Players[playerid][Freeze][i]=0;
				}
			}
			else
			{
				Players[playerid][Freeze][freezeid]=0;
			}
			if(isplfreeze && !IsPlayerFreeze(playerid))
			{
				TogglePlayerControllable(playerid, 1);
				#if defined OnPlayerToggleControllable
				OnPlayerToggleControllable(playerid, 1);
				#endif
			}
		}
		return 1;
	}
	return 0;
}

stock Text:TextDrawCreateTimer(Float:x1, Float:y1, text[], ms) //By Gabriel "Larcius" Cordes
{
	new Text:textid=TextDrawCreate(x1, y1, text);
	TextDrawDestroyTimer(textid, ms);
	return textid;
}

stock TextDrawDestroyTimer(Text:textid, ms) //By Gabriel "Larcius" Cordes
{
	SetTimerEx("TextDrawDestroyTimer2",ms,false,"i",_:textid);
	return 1;
}

public TextDrawDestroyTimer2(textid) //By Gabriel "Larcius" Cordes
{
	TextDrawDestroy(Text:textid);
}

stock encrypt(const string[])
{
	return hash(string);
}

stock hash_key(const string[], key[]="", bit=32) //By Gabriel "Larcius" Cordes
{
	new keyp[] = "abcdefghijklmopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ ,;.:-_~!\"§$%&/(){}[]=?`´'#+-*/\\äöü<>|^°µ²³";
	new retval[MAX_STRING],retval2[MAX_STRING],size,sum,j,ksize,hashedkey[MAX_STRING],c=0;
	new kpsize=strfind(keyp," ");
	format(retval, sizeof(retval), "%s",string);
	while(strlen(retval)>bit || c<2)
	{
		format(retval2, sizeof(retval2), "");
		j=strlen(retval);
		if(j<(2*bit))
		{
			j=(2*bit);
			c++;
		}
		j=floatval(floatdiv(j,2.0));
		size=strlen(retval);
		if(strlen(retval)<j)
		{
			size=j;
		}
		if(strlen(key)==0)
		{
			hashedkey=GetSingleChar(keyp,0);
		}
		else
		{
			hashedkey=hash(key,"",j);
		}
		ksize=strlen(hashedkey);
		for (new i=0; i<j; i++)
		{
			sum=((sum + strfind(keyp, GetSingleChar(hashedkey,(i%ksize))) + strfind(keyp, GetSingleChar(retval,(i%size))) + strfind(keyp, GetSingleChar(retval,((j+i)%size)))) % kpsize);
			strcat(retval2,GetSingleChar(keyp,sum));
			retval2=reverse(retval2);
		}
		format(retval, sizeof(retval), "%s",retval2);
	}
	return retval;
}

stock reverse(const source[]) //By Gabriel "Larcius" Cordes
{
	new string[MAX_STRING];
	for(new i=(strlen(source)-1); i>=0; i--)
	{
		strcat(string,GetSingleChar(source,i));
	}
	return string;
}

stock GetSingleChar(const source[], num) //By Gabriel "Larcius" Cordes
{
	new string[MAX_STRING];
	strmid(string,source,num,(num+1));
	return string;
}

stock left(const source[], pos) //By Alex "Y_Less" Cole (Edited by Sacky)
{
	new retval[MAX_STRING];
	strmid(retval, source, 0, pos);
	return retval;
}

stock firstchars(const source[], len=1) //By Gabriel "Larcius" Cordes
{
	new retval[MAX_STRING];
	strmid(retval, source, 0, len);
	return retval;
}

stock right(const source[], pos) //By Gabriel "Larcius" Cordes
{
	new retval[MAX_STRING];
	strmid(retval, source, (pos+1), strlen(source));
	return retval;
}

stock lastchars(const source[], len=1) //By Alex "Y_Less" Cole
{
	new retval[MAX_STRING];
	strmid(retval, source, (strlen(source)-len), strlen(source));
	return retval;
}

stock CountDownForPlayer(playerid, seconds, freeze, style=1) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid))
	{
		if(!Counters[playerid][Down][Style])
		{
			Counters[playerid][Down][TextID]=0;
		}
		else if(Counters[playerid][Down][Style]!=style)
		{
			TextDrawDestroy(Text:Counters[playerid][Down][TextID]);
		}
		if(freeze==0 || style==0)
		{
			TogglePlayerControllable2(playerid, 1, FREEZE_COUNTDOWN);
		}
		else if(freeze)
		{
			TogglePlayerControllable2(playerid, 0, FREEZE_COUNTDOWN);
			SetCameraBehindPlayer(playerid);
		}
		Counters[playerid][Down][Style]=style;
		Counters[playerid][Down][Time]=seconds;
		return 1;
	}
	return 0;
}

stock CountDownForAll(seconds, freeze, style=1) //By Gabriel "Larcius" Cordes
{
	new ret=0;
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(CountDownForPlayer(i, seconds, freeze, style))
		{
			ret++;
		}
	}
	return ret;
}

stock CountUpForPlayer(playerid, seconds, freeze, style=1) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid))
	{
		if(!Counters[playerid][Up][Style])
		{
			Counters[playerid][Up][TextID]=0;
		}
		else if(Counters[playerid][Up][Style]!=style)
		{
			TextDrawDestroy(Text:Counters[playerid][Up][TextID]);
		}
		if(freeze==0 || style==0)
		{
			TogglePlayerControllable2(playerid, 1, FREEZE_COUNTUP);
		}
		else if(freeze)
		{
			TogglePlayerControllable2(playerid, 0, FREEZE_COUNTUP);
			SetCameraBehindPlayer(playerid);
		}
		Counters[playerid][Up][Style]=style;
		Counters[playerid][Up][Time]=seconds;
		Counters[playerid][Up][Time2]=0;
		return 1;
	}
	return 0;
}

stock CountUpForAll(seconds, freeze, style=1) //By Gabriel "Larcius" Cordes
{
	new ret=0;
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(CountUpForPlayer(i, seconds, freeze, style))
		{
			ret++;
		}
	}
	return ret;
}

stock GetPlayerID(const playername[], partofname=0) //By Jan "DracoBlue" Schütze (edited by Gabriel "Larcius" Cordes)
{
	new i;
	new playername1[MAX_STRING];
	for (i=0;i<MAX_PLAYERS;i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i,playername1,sizeof(playername1));
			if (strcmp(playername1,playername,true)==0)
			{
				return i;
			}
		}
	}
	new correctsigns_userid=-1;
	new tmpuname[MAX_STRING];
	new hasmultiple=-1;
	if(partofname)
	{
		for (i=0;i<MAX_PLAYERS;i++)
		{
			if (IsPlayerConnected(i))
			{
				GetPlayerName(i,tmpuname,sizeof(tmpuname));
				if (strfind(tmpuname,partofname,true)==0)
				{
					hasmultiple++;
					correctsigns_userid=i;
				}
				if (hasmultiple>0)
				{
					return -2;
				}
			}
		}
	}
	return correctsigns_userid;
}

stock GetPlayerId(playername[])
{
	return GetPlayerID(partofname[],0);
}

stock PlayerID(playername[])
{
	return GetPlayerID(playername[],1);
}

stock PlayerId(playername[])
{
	return GetPlayerID(playername[],1);
}

stock parsecommand(cmdtext[], cmd[], text[], parcount) //By Alex "Y_Less" Cole
{
	new index = 0, length;
	length = strlen(cmdtext);
	while ((index < length) && (cmdtext[index] != ' '))
	{
		index++;
	}
	if (index == length)
	{
		strcat(cmd, cmdtext, MAX_STRING);
		text[0] = EOS;
		return 0;
	}
	else
	{
	    strmid(cmd, cmdtext, 0, index, MAX_STRING);
	    cmd[index] = EOS;
	    strmid(text, cmdtext, index + 1, length, MAX_STRING);
		text[length] = EOS;
		if (parcount)
		{
		    index = 0;
			new pars = 0;
			length = strlen(text);
			while (index < length)
			{
				if ((text[index] != ' ') && ((index == 0) || ((index > 0) && (text[index - 1] == ' '))))
				{
				    pars++;
				}
				index++;
			}
			return pars;
		}
		else
		{
			return 1;
		}
	}
	return 0;
}

stock ReturnPlayerName(playerid) //By Alex "Y_Less" Cole
{
	new pname[MAX_PLAYER_NAME];
	pname="Invalid PlayerID";
	if(IsPlayerConnected(playerid))
	{
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, pname, sizeof (pname));
	}
	return pname
}

stock minrand(min, max) //By Alex "Y_Less" Cole
{
	return random(max-min)+min;
}

stock Float:floatrand(Float:min, Float:max) //By Alex "Y_Less" Cole
{
	new imin = floatround(min);
	return floatdiv(float(random((floatround(max)-imin)*100)+(imin*100)),100.0);
}

stock IsBetweenFloats(Float:f,Float:f1,Float:f2) //By Gabriel "Larcius" Cordes
{
	switch(floatcmp(f1, f2))
	{
		case 0: if(f==f1){return 1;}
		case 1: if(f<=f1 && f>=f2){return 1;}
		case -1: if(f>=f1 && f<=f2){return 1;}
	}
	return 0;
}

stock GameTextForTeam(team, text[], time, style) //By Alex "Y_Less" Cole (edited by Gabriel "Larcius" Cordes)
{
	ret=0;
	for (new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i) && Players[i][Cur_team]==team)
		{
			GameTextForPlayer(i, text, time, style);
			ret++;
		}
	}
	return ret;
}

stock SendClientMessageToTeam(team, color, text[]) //By Alex "Y_Less" Cole (edited by Gabriel "Larcius" Cordes)
{
	new ret=0;
	for (new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && Players[i][Cur_team]==team)
		{
			SendClientMessage(i, color, text);
			ret++;
		}
	}
	return ret;
}

stock valstr2(num) //By Alex "Y_Less" Cole
{
	new str[MAX_STRING];
	valstr(str, num);
	return str;
}

stock IsValidEmail(const email[]) //By Jan "DracoBlue" Schütze
{
	new len=strlen(email);
	new cstate=0;
	for(new i=0;i<len;i++)
	{
		if ((cstate==0 || cstate==1) && (email[i]>='A' && email[i]<='Z') || (email[i]>='a' && email[i]<='z')  || (email[i]=='.')  || (email[i]=='-')  || (email[i]=='_'))
		{
		}
		else
		{
			if ((cstate==0) &&(email[i]=='@'))
			{
				cstate=1;
			}
			else
			{
				return false;
			}
		}
	}
	if (cstate<1)
	{
		return false;
	}
	if (len<6)
	{
		return false;
	}
	if ((email[len-3]=='.') || (email[len-4]=='.') || (email[len-5]=='.'))
	{
		return true;
	}
	return false;
}

stock GetVehicleSpawnPos(vehicleid,&Float:spawn_x,&Float:spawn_y,&Float:spawn_z,&Float:angle_z) //By Gabriel "Larcius" Cordes
{
	if(IsVehicleConnected(vehicleid))
	{

	}
	return -1,-1,-1,-1;
}

stock GetPlayerLastVehicleID(playerid) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid))
	{
		return Players[playerid][Last_Vehicle];
	}
	return -1;
}

stock GetVehicleLastTrailerID(vehicleid) //By Gabriel "Larcius" Cordes
{
	if(IsVehicleConnected(vehicleid))
	{
		return Vehicles[vehicleid][Last_Trailer];
	}
	return -1;
}

stock GetVehicleLastTrailer(vehicleid)
{
	return GetVehicleLastTrailerID(vehicleid);
}

stock IsPlayerDriver(playerid) //By Sacky
{
	if(IsPlayerConnected(playerid) && GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
	{
		return 1;
	}
	return 0;
}

stock GetVehicleDriverID(vehicleid) //By Jan "DracoBlue" Schütze
{
	if(IsVehicleConnected(vehicleid))
	{
		for (new i=0;i<MAX_PLAYERS;i++)
		{
			if (IsPlayerConnected(i) && GetPlayerVehicleID(i)==vehicleid && IsPlayerDriver(i))
			{
				return i;
			}
		}
	}
	return -1;
}

stock VehicleDriverID(vehicleid)
{
	return GetVehicleDriverID(vehicleid);
}

stock IsNumeric(const string[]) //By Jan "DracoBlue" Schütze (edited by Gabriel "Larcius" Cordes
{
	new length=strlen(string);
	if(length==0)
	{
		return 0;
	}
	for (new i=0; i<length; i++)
	{
		if (!((string[i] <= '9' && string[i] >= '0') || (i==0 && (string[i]=='-' || string[i]=='+'))))
		{
			return false;
		}
	}
	return 0;
}

stock SendClientMessageToAdmins(colour,const str[]) //By Mike (Edited by Sacky)
{
	new ret=0;
	for (new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i) && IsPlayerAdmin(i))
		{
			SendClientMessage(i, colour, str);
			ret++;
		}
	}
	return ret;
}

stock Float:GetDistanceBetweenPoints(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2) //By Gabriel "Larcius" Cordes
{
	return floatadd(floatadd(floatsqroot(floatpower(floatsub(x1,x2),2)),floatsqroot(floatpower(floatsub(y1,y2),2))),floatsqroot(floatpower(floatsub(z1,z2),2)));
}

stock Float:GetDistanceToPoint(playerid,Float:x1,Float:y1,Float:z1) //By Gabriel "Larcius" Cordes
{
	if (IsPlayerConnected(playerid))
	{
		new Float:x2,Float:y2,Float:z2;
		GetPlayerPos(playerid,x2,y2,z2);
		return GetDistanceBetweenPoints(x1,y1,z1,x2,y2,z2);
	}
	return INF_FLOAT;
}

stock Float:GetDistanceToVehicle(playerid,vehicleid) //By Darkrealm (Edited by Sacky and Gabriel "Larcius" Cordes)
{
	if (IsPlayerConnected(playerid) && IsVehicleConnected(vehicleid))
	{
		new Float:x1,Float:y1,Float:z1;
		GetVehiclePos(vehicleid,x1,y1,z1);
		return GetDistanceToPoint(playerid,x1,y1,z1);
	}
	return INF_FLOAT;
}

stock Float:GetDistanceToCar(playerid,vehicleid) //By Darkrealm (Edited by Sacky and Gabriel "Larcius" Cordes)
{
	return GetDistanceToVehicle(playerid,vehicleid);
}

stock GetClosestVehicle(playerid) //By Darkrealm (edited by Gabrie "Larcius" Cordes)
{
	if(IsPlayerConnected(playerid) && IsVehicleConnected(0))
	{
		new closestvehicle=0;
		new Float:closestdist=GetDistanceToVehicle(playerid,0);
		for(new vehicleid=0; vehicleid<MAX_VEHICLES; vehicleid++)
		{
			new Float:dist = GetDistanceToVehicle(playerid,vehicleid);
			if ((dist < closestdist))
			{
				closestdist = dist;
				closestvehicle = vehicleid;
			}
		}
		return closestvehicle;
	}
	return -1;
}

stock GetClosestCar(playerid)
{
	return GetClosestVehicle(playerid);
}

stock Float:GetDistanceBetweenPlayers(playerid,playerid2) //By Slick (Edited by Sacky and Gabriel "Larcius" Cordes)
{
	if(IsPlayerConnected(playerid) && IsPlayerConnected(playerid2))
	{
		new Float:x1,Float:y1,Float:z1;
		GetPlayerPos(playerid2,x1,y1,z1);
		return GetDistanceToPoint(playerid,x1,y1,z1);
	}
	return INF_FLOAT;
}

stock GetClosestPlayer(playerid) //By Slick (edited by Gabriel "Larcius" Cordes)
{
	if(IsPlayerConnected(playerid) && IsPlayerConnected(0))
	{
		new closestplayer=0;
		new Float:closestdist=GetDistanceBetweenPlayers(playerid,0);
		for(new playerid2=0; playerid2<MAX_PLAYERS; playerid2++)
		{
			new Float:dist = GetDistanceBetweenPlayers(playerid,playerid2);
			if ((dist < closestdist))
			{
				closestdist = dist;
				closestplayer = playerid;
			}
		}
		return closestplayer;
	}
	return -1;
}

stock GetClosestTeamPlayer(playerid) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid) && IsPlayerConnected(0))
	{
		new closestplayer=0;
		new Float:closestdist=GetDistanceBetweenPlayers(playerid,0);
		for(new playerid2=0; playerid2<MAX_PLAYERS; playerid2++)
		{
			new Float:dist = GetDistanceBetweenPlayers(playerid,playerid2);
			if (dist<closestdist && Players[playerid2][Cur_team]==Players[playerid][Cur_team])
			{
				closestdist = dist;
				closestplayer = playerid;
			}
		}
		return closestplayer;
	}
	return -1;
}

stock TwoWayRand(value) //By Allan
{
	value = random(value*2+1)-value;
	return value;
}

stock Float:QuadraticRootCalc(Float:Xsq,Float:X1,Float:num) //By Allan (corrected by Gabriel "Larcius" Cordes)
{
	return floatmul(floatadd(floatmul(floatdiv(floatsqroot(floatmul(floatmul(floatmul(floatpower(X1,2),4.0),Xsq),num)),2.0),Xsq),X1),floatsub(floatmul(floatdiv(floatsqroot(floatmul(floatmul(floatmul(floatpower(X1,2),4.0),Xsq),num)),2.0),Xsq),X1));
}

stock SendFormattedGameTextToPlayer(playerid, const msg[], time, style, define) //By Allan
{
	if(IsPlayerConnected(playerid))
	{
		new wrap[256];
		format(wrap, sizeof(wrap), msg, define);
		GameTextForPlayer(playerid,wrap,time,style);
		return 1;
	}
	return 0;
}

stock SendFormattedGameTextToAll(const msg[], time, style, define) //By Allan (edited by Gabriel "Larcius" Cordes)
{
	new ret=0;
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(SendFormattedGameTextToPlayer(playerid, msg, time, style, define))
			{
				ret++;
			}
		}
	}
	return ret;
}

stock GivePlayerWeaponAlt(playerid, weaponid, ammo) //By Allan (Edited by Y_Less)
{
	if ((weaponid > 15 && weaponid < 22) || (weaponid > 32 && weaponid < 37) || (weaponid > 38 && weaponid < 41) || (weaponid > 42 && weaponid != 46))
	{
		weaponid = 0;
		print("Non-Working weapon class specified");
		SendClientMessage(playerid, 0x0000FFAA, "Non-Working weapon class specified");
	}
	GivePlayerWeapon(playerid, weaponid, ammo);
	return 1;
}

stock SecondsToString(time,mode=0) //By Gabriel "Larcius" Cordes
{
	new seconds,minutes,minutes1,hours,string0[MAX_STRING],string1[MAX_STRING],string2[MAX_STRING];
	seconds=time%60;
	minutes=(time-seconds)%3600;
	minutes1=(time-seconds)/60;
	hours=(time-minutes*60-seconds)/3600;
	if(hours<10)
	{
		format(string0, sizeof(string0), "0%d", hours);
	}
	else
	{
		format(string0, sizeof(string0), "%d", hours);
	}
	if(minutes<10)
	{
		format(string0, sizeof(string0), "%s:0%d",string0,minutes);
	}
	else
	{
		format(string0, sizeof(string0), "%s,%d",string0,minutes);
	}
	if(minutes1<10)
	{
		format(string1, sizeof(string1), "0%d",minutes1);
	}
	else
	{
		format(string1, sizeof(string1), "%d",minutes1);
	}
	if(seconds<10)
	{
		format(string0, sizeof(string0), "%s:0%d",string0,seconds);
		format(string1, sizeof(string1), "%s:0%d",string1,seconds);
	}
	else
	{
		format(string0, sizeof(string0), "%s:%d",string0,seconds);
		format(string1, sizeof(string1), "%s:%d",string1,seconds);
	}
	if(hours>0)
	{
		format(string2, sizeof(string2), "%d hours", hours);
	}
	if(minutes>0)
	{
		if(hours>0)
		{
			if(seconds>0)
			{
				format(string2, sizeof(string2), "%s, %d minutes", string2, minutes);
			}
			else
			{
				format(string2, sizeof(string2), "%s and %d minutes", string2, minutes);
			}
		}
	}
	if(seconds>0)
	{
		if(hours>0 || minutes>0)
		{
			format(string2, sizeof(string2), "%s and %d seconds", string2, seconds);
		}
		else
		{
			format(string2, sizeof(string2), "%d seconds", string2, seconds);
		}
	}
	if(hours==0 && minutes==0 && seconds==0)
	{
		format(string2, sizeof(string2), "0 seconds");
	}
	switch(mode)
	{
		case 0: return string0;
		case 1: return string1;
		case 2: return string2;
	}
	return string0;
}

stock ConvertSeconds(time)
{
	return SecondsToString(time,2)
}

stock timeconvert_seconds(time)
{
	return SecondsToString(time,1);
}

stock wiper(playerid) //By Spectre
{
	if(IsPlayerConnected(playerid))
	{
		for (new i=0;i<10;i++)
		{
			SendClientMessage(playerid,0xFFFFFFAA,"\n");
		}
		return 1;
	}
	return 0;
}

stock GetCurrentPosition(playerid) //By Sacky
{
	new Float:x1, Float:y1, Float:z1, Float:a;
	new string[MAX_STRING];
	if(IsPlayerConnected(playerid))
	{
		GetPlayerPos(playerid,x1,y1,z1);
		GetPlayerFacingAngle(playerid,a);
		format(string,sizeof(string),"x: %d, y: %d, z: %d, angle: %d",floatround(x1),floatround(y1),floatround(z1),floatround(a));
		return string;
	}
	return string;
}

stock GetVehicles() //By Gabriel "Larcius" Cordes
{
	new vehicles=0;
	for(new i=0;i<MAX_VEHICLES;i++)
	{
		if(IsVehicleConnected(i))
		{
			vehicles++;
		}
	}
	return vehicles;
}

stock VehicleDriverName(vehicleid) //By Sacky
{
	new playername[MAX_PLAYER_NAME];
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i))
		{
			if(IsPlayerInVehicle(i,vehicleid))
			{
				GetPlayerName(i,playername,sizeof(playername));
				return playername;
			}
		}
	}
	return playername;
}

stock IsPlayerInAnyInterior(playerid) //By Sacky (edited by Gabriel "Larcius" Cordes)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid,x,y,z);
		if(GetPlayerInterior(playerid) > 0 || (z>900 && !IsPlayerInPlane(playerid) && !IsPlayerInHeli(playerid)))
		{
			return 1;
		}
	}
	return 0;
}

stock IsPlayerPassenger(playerid) //By Sacky
{
	if(IsPlayerConnected(playerid) && GetPlayerState(playerid)==PLAYER_STATE_PASSENGER)
	{
		return 1;
	}
	return 0;
}

stock IsPlayerOnFoot(playerid) //By Sacky
{
	if(IsPlayerConnected(playerid) && GetPlayerState(playerid)==PLAYER_STATE_ONFOOT)
	{
		return 1;
	}
	return 0;
}

stock IsPlayerOnBike(playerid) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid) && IsPlayerInAnyVehicle(playerid))
	{
		if(GetVehicleType(GetPlayerVehicleID(playerid))==VTYPE_BIKE)
		{
			return 1;
		}
	}
	return 0;
}

stock IsPlayerOnBicycle(playerid) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid) && IsPlayerInAnyVehicle(playerid))
	{
		if(GetVehicleType(GetPlayerVehicleID(playerid))==VTYPE_BMX)
		{
			return 1;
		}
	}
	return 0;
}

stock IsPlayerOnBMX(playerid)
{
	return IsPlayerOnBicycle(playerid);
}

stock IsPlayerInBoat(playerid) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid) && IsPlayerInAnyVehicle(playerid))
	{
		if(GetVehicleType(GetPlayerVehicleID(playerid))==VTYPE_SEA)
		{
			return 1;
		}
	}
	return 0;
}

stock IsPlayerInHeavy(playerid) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid) && IsPlayerInAnyVehicle(playerid))
	{
		if(GetVehicleType(GetPlayerVehicleID(playerid))==VTYPE_HEAVY)
		{
			return 1;
		}
	}
	return 0;
}

stock IsPlayerInTruck(playerid)
{
	return IsPlayerInHeavy(playerid);
}

stock IsPlayerInTrain(playerid) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid) && IsPlayerInAnyVehicle(playerid))
	{
		if(GetVehicleType(GetPlayerVehicleID(playerid))==VTYPE_TRAIN)
		{
			return 1;
		}
	}
	return 0;
}

stock IsPlayerInHelicopter(playerid) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid) && IsPlayerInAnyVehicle(playerid))
	{
		if(GetVehicleType(GetPlayerVehicleID(playerid))==VTYPE_HELI)
		{
			return 1;
		}
	}
	return 0;
}

stock IsPlayerInHeli(playerid)
{
	return IsPlayerInHelicopter(playerid);
}

stock IsPlayerInPlane(playerid) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid) && IsPlayerInAnyVehicle(playerid))
	{
		if(GetVehicleType(GetPlayerVehicleID(playerid))==VTYPE_PLANE)
		{
			return 1;
		}
	}
	return 0;
}

stock IsPlayerInMonsterTruck(playerid) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid) && IsPlayerInAnyVehicle(playerid))
	{
		if(GetVehicleType(GetPlayerVehicleID(playerid))==VTYPE_MONSTER)
		{
			return 1;
		}
	}
	return 0;
}

stock IsPlayerInCar(playerid) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid) && IsPlayerInAnyVehicle(playerid))
	{
		if(GetVehicleType(GetPlayerVehicleID(playerid))==VTYPE_CAR)
		{
			return 1;
		}
	}
	return 0;
}

stock IsPlayerOnQuad(playerid) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid) && IsPlayerInAnyVehicle(playerid))
	{
		if(GetVehicleType(GetPlayerVehicleID(playerid))==VTYPE_QUAD)
		{
			return 1;
		}
	}
	return 0;
}

stock IsVehicleTrailer(vehicleid) //By Gabriel "Larcius" Cordes
{
	if(GetVehicleType(vehicleid)==VTYPE_TRAILER)
	{
		return 1;
	}
	return 0;
}

stock IsPlayerInQuad(playerid) //By Gabriel "Larcius" Cordes
{
	return IsPlayerOnQuad(playerid);
}

stock ShowSpeedForPlayer(playerid,a=SPEED_KMPH) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid))
	{
		Players[playerid][Speed][Show]=a;
		return 1;
	}
	return 0;
}

stock ShowSpeedForAll(a=SPEED_KMPH) //By Gabriel "Larcius" Cordes
{
	new ret=0;
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(ShowSpeedForPlayer(i,a))
		{
			ret++;
		}
	}
	return ret;
}

stock HideSpeedForPlayer(playerid) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid))
	{
		Players[playerid][Speed][Show]=0;
		return 1;
	}
	return 0;
}

stock HideSpeedForAll() //By Gabriel "Larcius" Cordes
{
	new ret=0;
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(HideSpeedForPlayer(i))
		{
			ret++;
		}
	}
	return ret;
}

stock ShowAccelerationForPlayer(playerid,a=ACC_MPS2) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid))
	{
		Players[playerid][Acceleration][Show]=a;
		return 1;
	}
	return 0;
}

stock ShowAccelerationForAll(a=ACC_MPS2) //By Gabriel "Larcius" Cordes
{
	new ret=0;
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(ShowAccelerationForPlayer(i,a))
		{
			ret++;
		}
	}
	return ret;
}

stock HideAccelerationForPlayer(playerid) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid))
	{
		Players[playerid][Acceleration][Show]=0;
		return 1;
	}
	return 0;
}

stock HideAccelerationForAll() //By Gabriel "Larcius" Cordes
{
	new ret=0;
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(HideAccelerationForPlayer(i))
		{
			ret++;
		}
	}
	return ret;
}

stock GetVehicleName(vehicleid) //By Sacky
{
	new modelid=612;
	if(IsVehicleConnected(vehicleid))
	{
		modelid=GetVehicleModel(vehicleid);
	}
	return VehicleNames[(modelid-400)];
}

stock GetVehicleNameByModel(modelid) //By Gabriel "Larcius" Cordes
{
	if(400<modelid || modelid>611)
	{
		modelid=612;
	}
	return VehicleNames[(modelid-400)];
}

stock Float:GetDistanceToPointXY(playerid,Float:xs,Float:ys) //By Gabriel "Larcius" Cordes
{
	new Float:x1,Float:y1,Float:z1;
	GetPlayerPos(playerid,x1,y1,z1);
	return GetDistanceToPoint(playerid,xs,ys,z1);
}

stock Float:GetDistanceBetweenPointsXY(Float:x1,Float:y1,Float:x2,Float:y2) //By Gabriel "Larcius" Cordes
{
	return GetDistanceBetweenPoints(x1,y1,0.0,x2,y2,0.0);
}

stock Float:GetPlayerDistanceToPointXY(playerid,Float:xs,Float:ys)
{
	return GetDistanceToPointXY(playerid,xs,ys);
}

stock Float:GetPlayerDistanceToPoint(playerid,Float:xs,Float:ys) //By Sacky
{
	return GetDistanceToPointXY(playerid,xs,ys);
}

stock Float:GetPlayerDistanceToPointEx(playerid,Float:xs,Float:ys,Float:zs) //By Sacky
{
	return GetDistanceToPoint(playerid,xs,ys,zs);
}

stock Float:GetPointDistanceToPoint(Float:x1,Float:y1,Float:x2,Float:y2) //By Sacky
{
	return GetDistanceBetweenPoints(x1,y1,0.0,x2,y2,0.0);
}

stock Float:GetPointDistanceToPointEx(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2) //By Sacky
{
	return GetDistanceBetweenPoints(x1,y1,z1,x2,y2,z2);
}

stock IsPlayerInRectangle(playerid, Float:x1, Float:y1, Float:x2, Float:y2)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:xs,Float:ys,Float:zs;
		GetPlayerPos(playerid,xs,ys,zs);
		return IsPointInRectangle(xs,ys,x1,y1,x2,y2);
	}
	return 0;
}

stock IsPointInRectangle(Float:xs, Float:ys, Float:x1, Float:y1, Float:x2, Float:y2) //By Alex "Y_Less" Cole (edited by Gabriel "Larcius" Cordes)
{
	if(IsBetweenFloats(xs,x1,x2) && IsBetweenFloats(ys,y1,y2))
	{
		return 1;
	}
	return 0;
}

stock IsPointInCircle(Float:xs,Float:ys,Float:x1,Float:y1,Float:radius1) //By Sacky
{
	if(GetDistanceBetweenPointsXY(xs,ys,x1,y1)<=radius1)
	{
		return 1;
	}
	return 0;
}

stock IsPlayerInCircle(playerid,Float:x1,Float:y1,Float:radius1)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:xs,Float:ys,Float:zs;
		GetPlayerPos(playerid,xs,ys,zs);
		return IsPointInCircle(xs,ys,x1,y1,radius1);
	}
	return 0;
}

stock IsPlayerInAshlar(playerid,Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:xs,Float:ys,Float:zs;
		GetPlayerPos(playerid,xs,ys,zs);
		return IsPointInAshlar(xs,ys,zs,x1,y1,z1,x2,y2,z2);
	}
	return 0;
}

stock IsPointInAshlar(Float:xs,Float:ys,Float:zs,Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2) //By 50p (edited by Gabriel "Larcius" Cordes)
{
	if(IsBetweenFloats(xs,x1,x2) && IsBetweenFloats(ys,y1,y2) && IsBetweenFloats(zs,z1,z2))
	{
		return 1;
	}
	return 0;
}

stock IsPlayerInCube(Float:xs,Float:ys,Float:zs,Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2)
{
	return IsPlayerInAshlar(xs,ys,zs,x1,y1,z1,x2,y2,z2);
}

stock IsPointInCube(playerid,Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2)
{
	return IsPointInAshlar(playerid,x1,y1,z1,x2,y2,z2);
}

stock IsPlayerInSphere(playerid,Float:x1,Float:y1,Float:z1,Float:radius)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:xs,Float:ys,Float:zs;
		GetPlayerPos(playerid,xs,ys,zs);
		return IsPointInSphere(xs,ys,zs,x1,y1,z1,radius);
	}
	return 0;
}

stock IsPointInSphere(Float:xs,Float:ys,Float:zs,Float:x1,Float:y1,Float:z1,Float:radius) //By Sacky
{
	if(GetDistanceBetweenPoints(xs,ys,zs,x1,y1,z1)<=radius)
	{
		return 1;
	}
	return 0;
}

stock IsPlayerInCylinder(playerid,Float:x1,Float:y1,Float:z1,Float:h1,Float:radius1)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:xs,Float:ys,Float:zs;
		GetPlayerPos(playerid,xs,ys,zs);
		return IsPointInCylinder(xs,ys,zs,x1,y1,z1,h1,radius1);
	}
	return 0;
}

stock IsPointInCylinder(Float:xs,Float:ys,Float:zs,Float:x1,Float:y1,Float:z1,Float:h1,Float:radius1) //By Sacky
{
	if(GetDistanceBetweenPointsXY(xs,ys,x1,y1)<=radius1 && zs>=z1 && zs<=(z1+h1))
	{
		return 1;
	}
	return 0;
}

stock TakePlayerMoney(playerid,money) //By Sacky
{
	if(IsPlayerConnected(playerid))
	{
		GivePlayerMoney(playerid,0-money);
		return 1;
	}
	return 0;
}

stock DestroyPickup2(pickupid) //By Gabriel "Larcius" Cordes
{
	if(IsPickupConnected(pickupid))
	{
		DestroyPickup(pickupid);
		Pickups[pickupid][Model]=0;
		Pickups[pickupid][Type]=0;
		Pickups[pickupid][X]=0;
		Pickups[pickupid][Y]=0;
		Pickups[pickupid][Z]=0;
		return 1;
	}
	return 0;
}

stock CreatePickup2(model,type,Float:x1,Float:y1,Float:z1) //By Gabriel "Larcius" Cordes
{
	if(GetPickups()<MAX_PICKUPS)
	{
		new pickupid=CreatePickup(model,type,x1,y1,z1);
		Pickups[pickupid][Model]=model;
		Pickups[pickupid][Type]=type;
		Pickups[pickupid][X]=x1;
		Pickups[pickupid][Y]=y1;
		Pickups[pickupid][Z]=z1;
		return 1;
	}
	return 0;
}

stock AddStaticPickup2(model,type,Float:x1,Float:y1,Float:z1) //By Sacky (edited by Gabriel "Larcius" Cordes)
{
	if(GetPickups()<MAX_PICKUPS)
	{
		new pickupid=AddStaticPickup(model,type,x1,y1,z1);
		Pickups[pickupid][Model]=model;
		Pickups[pickupid][Type]=type;
		Pickups[pickupid][X]=x1;
		Pickups[pickupid][Y]=y1;
		Pickups[pickupid][Z]=z1;
		return 1;
	}
	return 0;
}

stock SetVehicleParamsForPlayer2(vehicleid, playerid, objective, doorslocked, trailer=0) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid) && IsVehicleConnected(vehicleid))
	{
/*		if(objective==0 && IsVehicleObjectivedForPlayer(vehicleid,playerid))
		{
			new Float:x1,Float:y1,Float:z1,Float:angle_z;
			GetVehiclePos(vehicleid,x1,y1,z1);
			GetVehicleZAngle(vehicleid,angle_z);
			SetVehicleToRespawn(vehicleid);
			if(IsVehicleTrailer(vehicleid))
			{
				AttachTrailerToVehicle(vehicleid,trailer);
			}
			else
			{	
				PutPlayerInVehicle(playerid,vehicleid,0);
				SetVehiclePos(vehicleid,x1,y1,z1);
				SetVehicleZAngle(vehicleid,angle_z);
			}
		}*/
		SetVehicleParamsForPlayer(vehicleid, playerid, objective, doorslocked);
		Vehicles[vehicleid][Objective][playerid]=objective;
		Vehicles[vehicleid][Locked][playerid]=doorslocked;
		if (trailer && IsTrailerAttachedToVehicle(vehicleid))
		{
			SetVehicleParamsForPlayer2(GetVehicleTrailer(vehicleid), playerid, objective, doorslocked, vehicleid);
		}
		return 1;
	}
	return 0;
}

stock SetVehicleParamsForAll(vehicleid, objective, doorslocked, trailer=0) //By Gabriel "Larcius" Cordes
{
	new ret=0;
	for (new i=0; i<MAX_PLAYERS; i++)
	{
		if(SetVehicleParamsForPlayer2(vehicleid, i, objective, doorslocked, trailer))
		{
			ret++;
		}
	}
	return ret;
}

stock DestroyVehicle2(vehicleid)
{
	if(IsVehicleConnected(vehicleid))
	{
		SetVehicleParamsForAll(vehicleid, 0, 0);
		DestroyVehicle(vehicleid);
		Vehicles[vehicleid][X]=0.0;
		Vehicles[vehicleid][Y]=0.0;
		Vehicles[vehicleid][Z]=0.0;
		Vehicles[vehicleid][Angle]=0.0;
		Vehicles[vehicleid][Health]=0.0;
		Vehicles[vehicleid][Dynamic]=0;
		Vehicles[vehicleid][Respawn]=0;
		Vehicles[vehicleid][Color1]=0;
		Vehicles[vehicleid][Color2]=0;
		Vehicles[vehicleid][Locked]=0;
		return 1;
	}
	return 0;
}

stock AddStaticVehicleEx2(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2,respawn_delay) //By Sacky (edited by Gabriel "Larcius" Cordes)
{
	if(GetVehicles()<MAX_VEHICLES)
	{
		new id=AddStaticVehicleEx(modelid, spawn_x, spawn_y, spawn_z, z_angle, color1, color2,respawn_delay), Float:h;
		GetVehicleHealth(id, h);
		Vehicles[id][X]=spawn_x;
		Vehicles[id][Y]=spawn_y;
		Vehicles[id][Z]=spawn_z;
		Vehicles[id][Health]=h;
		Vehicles[id][Color1]=color1;
		Vehicles[id][Color2]=color2;
		Vehicles[id][Respawn]=respawn_delay;
		Vehicles[id][Dynamic]=0;
		Vehicles[id][Last_Trailer]=-1;
		Vehicles[id][Cur_Trailer]=-1;
		Vehicles[id][Static]=1;
		Vehicles[id][Angle]=z_angle;
		return 1;
	}
	return 0;
}

stock substr(const string[], const substr[] )
{
       new found_str = strfind( string, substr );
	      new szRet[ 256 ];
	
	      if( found_str )
	      {
		         strmid( szRet, string, found_str + 1, strlen( string ) );
       }
	      return szRet;
}

stock Float:GetPlayerSpeed(playerid,a=SPEED_KMPH) //By Gabriel "Larcius" Cordes 
{
	if(IsPlayerConnected(playerid))
	{
		switch(a)
		{
			case SPEED_KMPH: return Players[playerid][Speed][KMPH];
			case SPEED_MPH: return Players[playerid][Speed][MPH];
			case SPEED_MPS: return Players[playerid][Speed][MPS];
		}
	}
	return -1.0;
}

stock Float:GetPlayerAcceleration(playerid,a=ACC_MPS2) //By Sacky (basically edited by Gabriel "Larcius" Cordes) 
{
	if(IsPlayerConnected(playerid))
	{
		switch(a)
		{
			case ACC_MPS2: return Players[playerid][Acceleration][MPS2];
			case ACC_KMPH2: return Players[playerid][Acceleration][KMPH2];
			case ACC_G: return Players[playerid][Acceleration][G];
		}
	}
	return 0.0;
}

stock GetAdmins() //By Gabriel "Larcius" Cordes
{
	new admins=0;
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i) && IsPlayerAdmin(i))
		{
			admins++;
		}
	}
	return admins;
}

stock GetPickups() //By Gabriel "Larcius" Cordes
{
	new pickups=0;
	for(new i=0;i<MAX_PICKUPS;i++)
	{
		if(IsPickupConnected(i))
		{
			pickups++;
		}
	}
	return pickups;
}

stock Float:isin(Float:opp,Float:hyp) //By Sacky
{
	new Float:x = floatdiv(opp,hyp);
	if(x < 1.0 && x > -1.0)
	{
		return x+(1.0/2.0)*(floatpower(x,3)/3.0)+((1.0*3.0)/(2.0*4.0))*(floatpower(x,5)/5.0)+((1.0*3.0*5.0)/(2.0*4.0*6.0))*(floatpower(x,7)/7.0)+((1.0*3.0*5.0*7.0)/(2.0*4.0*6.0*8.0))*(floatpower(x,9)/9.0)+((1.0*3.0*5.0*7.0*9.0)/(2.0*4.0*6.0*8.0*10.0))*(floatpower(x,11)/11.0);
	}
	return -1.0;
}

stock Float:icos(Float:adj,Float:hyp) //By Sacky
{
	new Float:x = floatdiv(adj,hyp);
	if(x < 1.0 && x > -1.0)
	{
		return floatsub(floatdiv(PI,2.0),isin(adj,hyp));
	}
	return -1.0;
}

stock Float:itan(Float:opp,Float:adj) //By Sacky
{
	new Float:x = floatdiv(opp,adj);
	if(x < 1.0 && x > -1.0)
	{
		return x-(1.0/3.0)*floatpower(x,3)+(1.0/5.0)*floatpower(x,5)-(1.0/7.0)*floatpower(x,7)+(1.0/9.0)*floatpower(x,9)-(1.0/11.0)*floatpower(x,11)+(1.0/13.0)*floatpower(x,13)-(1.0/15.0)*floatpower(x,15)+(1.0/17.0)*floatpower(x,17)-(1.0/19.0)*floatpower(x,19)+(1.0/21.0)*floatpower(x,21)-(1.0/23.0)*floatpower(x,23)+(1.0/25.0)*floatpower(x,25);
	}
	return -1.0;
}

stock Float:RadiansToDegrees(Float:radians) //By Sacky
{
	return floatdiv(floatmul(radians,PI),180.0);
}

stock Float:DegreesToRadians(Float:degree) //By Sacky
{
	return floatdiv(floatmul(degree,180.0),PI);
}

stock IsVehicleInUse(vehicleid) //By Sacky
{
	if(IsVehicleConnected(vehicleid) && VehicleDriverID(vehicleid)!=-1)
	{
		return 1;
	}
	return 0;
}

stock PlayerPlaySound2(playerid,soundid) //By Sacky
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid,x,y,z);
	PlayerPlaySound(playerid,soundid,x,y,z);
	return 1;
}

stock PlayerPlaySoundEx(playerid,soundid) //By Sacky
{
	return PlayerPlaySound2(playerid,soundid);
}

stock SetVehicleSpawnPos(vehicleid,Float:x1,Float:y1,Float:z1,Float:angle1)
{
	if(IsVehicleConnected(vehicleid))
	{
		Vehicles[vehicleid][X]=x1;
		Vehicles[vehicleid][Y]=y1;
		Vehicles[vehicleid][Z]=z1;
		Vehicles[vehicleid][Angle]=angle1;
		Vehicles[vehicleid][Dynamic]=1;
		return 1;
	}
	return 0;
}

stock ResetVehicleSpawnPos(vehicleid)
{
	if(IsVehicleConnected(vehicleid))
	{
		Vehicles[vehicleid][Dynamic]=0;
		return 1;
	}
	return 0;
}

stock SetVehicleToRespawn2(vehicleid) //By Gabriel "Larcius" Cordes
{
	if(IsVehicleConnected(vehicleid))
	{
		if(Vehicles[vehicleid][Dynamic])
		{
			SetVehiclePos(vehicleid,Vehicles[vehicleid][X],Vehicles[vehicleid][Y],Vehicles[vehicleid][Z]);
			SetVehicleZAngle(vehicleid,Vehicles[vehicleid][Angle]);
			#if defined OnVehicleRespawn
			OnVehicleSpawn2(vehicleid,1);
			#endif
			return 2;
		}
		else
		{
			SetVehicleToRespawn(vehicleid);
			return 1;
		}
	}
	return 0;
}

stock randomcolor() //By Gabriel "Larcius" Cordes
{
	return random(126);
}

stock AddStaticVehicle2(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2) //By Boss (edited by Gabriel "Larcius" Cordes)
{
	if(GetVehicles()<MAX_VEHICLES)
	{
		if(color1<0)
		{
			color1=randomcolor();
		}
		if(color2<0)
		{
			color2=randomcolor();
		}
		new vehicleid=AddStaticVehicle(modelid, spawn_x, spawn_y, spawn_z, z_angle, color1, color2), Float:h;
		GetVehicleHealth(vehicleid, h);
		Vehicles[vehicleid][X]=spawn_x;
		Vehicles[vehicleid][Y]=spawn_y;
		Vehicles[vehicleid][Z]=spawn_z;
		Vehicles[vehicleid][Health]=h;
		Vehicles[vehicleid][Color1]=color1;
		Vehicles[vehicleid][Color2]=color2;
		Vehicles[vehicleid][Dynamic]=0;
		Vehicles[vehicleid][Last_Trailer]=-1;
		Vehicles[vehicleid][Cur_Trailer]=-1;
		Vehicles[vehicleid][Static]=1;
		Vehicles[vehicleid][Respawn]=0;
		Vehicles[vehicleid][Angle]=z_angle;
		return 1;
	}
	return 0;
}

stock CreateVehicle2(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2, respawn_delay) //By Boss (edited by Gabriel "Larcius" Cordes)
{
	if(GetVehicles()<MAX_VEHICLES)
	{
		if(respawn_delay<0)
		{
			respawn_delay=INF_INT;
		}
		if(color1<0)
		{
			color1=randomcolor();
		}
		if(color2<0)
		{
			color2=randomcolor();
		}
		new id=CreateVehicle(modelid, spawn_x, spawn_y, spawn_z, z_angle, color1, color2, respawn_delay), Float:h;
		GetVehicleHealth(id, h);
		Vehicles[id][X]=spawn_x;
		Vehicles[id][Y]=spawn_y;
		Vehicles[id][Z]=spawn_z;
		Vehicles[id][Health]=h;
		Vehicles[id][Color1]=color1;
		Vehicles[id][Color2]=color2;
		Vehicles[id][Respawn]=respawn_delay;
		Vehicles[id][Dynamic]=0;
		Vehicles[id][Last_Trailer]=-1;
		Vehicles[id][Cur_Trailer]=-1;
		Vehicles[id][Static]=-1;
		Vehicles[id][Angle]=z_angle;
		return 1;
	}
	return 0;
}

stock AddStaticVehicleLine(modelid, Float:x1, Float:y1, Float:z1, Float:Z_Angle, color1, color2, Float:distance, MaxAmount, type) //By Gabriel "Larcius" Cordes
{
	new ret=0, Float:xRate=floatmul(floatsin(Z_Angle,degrees),distance), Float:yRate=floatmul(floatcos(Z_Angle,degrees),distance), Float:tmp;
	if(type==SIDELONG)
	{
		tmp=xRate;
		xRate=yRate;
		yRate=tmp;
	}
	for(new i=0; i<MaxAmount; i++)
	{
		if(AddStaticVehicle2(modelid, x1, y1, z1, Z_Angle, color1, color2))
		{
			x1+=xRate;
			y1+=yRate;
			ret++;
		}
	}
	return ret;
}

stock CreateVehicleLine(modelid, Float:x1, Float:y1, Float:z1, Float:Z_Angle, color1, color2, respawn_delay, Float:distance, MaxAmount, type) //By Gabriel "Larcius" Cordes
{
	new ret=0, Float:xRate=floatmul(floatsin(Z_Angle,degrees),distance), Float:yRate=floatmul(floatcos(Z_Angle,degrees),distance), Float:tmp;
	if(type==SIDELONG)
	{
		tmp=xRate;
		xRate=yRate;
		yRate=tmp;
	}
	for(new i=0; i<MaxAmount; i++)
	{
		if(CreateVehicle2(modelid,x1,y1,z1,Z_Angle,color1,color2,respawn_delay))
		{
			x1+=xRate;
			y1+=yRate;
			ret++;
		}
	}
	return ret;
}

stock DetachTrailerFromVehicle2(vehicleid) //By Gabriel "Larcius" Cordes
{
	if(IsVehicleConnected(vehicleid) && IsTrailerAttachedToVehicle(vehicleid))
	{
		new trailerid=GetVehicleTrailer(vehicleid);
		AttachTrailerToVehicle(trailerid, vehicleid);
		DetachTrailerFromVehicle(vehicleid);
		return trailerid;
	}
	return -1;
}

stock SetVehicleParamsForAllOthers(vehicleid, playerid, objective, doorslocked, trailer=0) //By Gabriel "Larcius" Cordes
{
	new ret=0;
	if(IsVehicleConnected(vehicleid))
	{
		for (new i=0; i<MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && i!=playerid)
			{
				SetVehicleParamsForPlayer2(vehicleid, i, objective, doorslocked, trailer);
				ret++;
			}
		}
	}
	return ret;
}

stock GetVehicleParamsOfPlayer(vehicleid, playerid, &objective, &doorslocked) //By Gabriel "Larcius" Cordes
{
	objective=-1, doorslocked=-1;
	if(IsPlayerConnected(playerid) && IsVehicleConnected(vehicleid))
	{
		objective=Vehicles[vehicleid][Objective][playerid];
		doorslocked=Vehicles[vehicleid][Locked][playerid];
	}
	return objective,doorslocked;
}

stock GetVehicleParamsForPlayer(vehicleid, playerid, &objective, &doorslocked)
{
	GetVehicleParamsOfPlayer(vehicleid, playerid, objective, doorslocked);
	return objective, doorslocked;
}

stock IsPlayerFreeze(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		for(new i=0; i<MAX_FREEZE_ALL; i++)
		{
			if(Players[playerid][Freeze][i]==1)
			{
				return 1;
			}
		}
	}
	return 0;
}

stock IsVehicleLockedForPlayer(vehicleid, playerid) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid) && IsVehicleConnected(vehicleid))
	{
		new objective, doorslocked;
		GetVehicleParamsOfPlayer(vehicleid, playerid, objective, doorslocked);
		if(doorslocked==1)
		{
			return 1;
		}
	}
	return 0;
}

stock IsVehicleLockedForAnyPlayer(vehicleid) //By Gabriel "Larcius" Cordes
{
	if(IsVehicleConnected(vehicleid))
	{
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && IsVehicleLockedForPlayer(vehicleid, i))
			{
				return 1;
			}
		}
	}
	return 0;
}

stock IsVehicleLockedForAll(vehicleid) //By Gabriel "Larcius" Cordes
{
	if(IsVehicleConnected(vehicleid))
	{
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && !IsVehicleLockedForPlayer(vehicleid, i))
			{
				return 0;
			}
		}
		return 1;
	}
	return 0;
}

stock IsVehicleObjectivedForPlayer(vehicleid, playerid) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid) && IsVehicleConnected(vehicleid))
	{
		new objective, doorslocked;
		GetVehicleParamsOfPlayer(vehicleid, playerid, objective, doorslocked);
		if(objective==1)
		{
			return 1;
		}
	}
	return 0;
}

stock IsVehicleObjectivedForAnyPlayer(vehicleid) //By Gabriel "Larcius" Cordes
{
	if(IsVehicleConnected(vehicleid))
	{
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && IsVehicleObjectivedForPlayer(vehicleid, i))
			{
				return 1;
			}
		}
	}
	return 0;
}

stock IsVehicleObjectivedForAll(vehicleid) //By Gabriel "Larcius" Cordes
{
	if(IsVehicleConnected(vehicleid))
	{
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && !IsVehicleObjectivedForPlayer(vehicleid, i))
			{
				return 0;
			}
		}
		return 1;
	}
	return 0;
}

stock SetTeamPos(team, x, y, z) //dyraXon
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i) && Players[i][Cur_team]==team) 
		{
			SetPlayerPos(i, x, y, z);
		}
	}
	return 1;
}

stock IsTeamInArea(team, Float:minx, Float:maxx, Float:miny, Float:maxy) //dyraXon
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i) && Players[i][Cur_team]==team) 
		{
			new Float:x, Float:y, Float:z;
			GetPlayerPos(i, x, y, z);
			if (x > minx && x < maxx && y > miny && y < maxy)
			{
				return 1;
			}
		}
	}
	return 0;
}

stock KickTeam(team) //dyraXon
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i) && Players[i][Cur_team]==team) 
		{
			Kick(i);
		}
	}
	return 1;
}

stock BanTeam(team) //dyraXon
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i) && Players[i][Cur_team]==team) 
		{
			Ban(i);
		}
	}
}

stock GetVehicleType(vehicleid) //By YellowBlood (edited by Gabriel "Larcius" Cordes)
{
	new type=0;
	if(IsVehicleConnected(vehicleid))
	{
	switch(GetVehicleModel(vehicleid))
	{
// ================== CARS =======
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
	554,   //yosemite -  car
	477   //zr350  -  car
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
	586   //wayfarer,   //bike
	: type = VTYPE_BIKE;

// =================== BMX =======
	case
	509,   //bike  -  bmx
	481,   //bmx  -  bmx
	510   //mtbike  -  bmx
	: type = VTYPE_BMX;

// ================== QUADS =======
	case
	471   //quad  -  quad
	: type = VTYPE_QUAD;

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

// ================= HELI =======
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
	488   //vcnmav  -  heli
	: type = VTYPE_HELI;

// ================ PLANE =======
	case
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
	: type = VTYPE_PLANE;

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
	408   //trash  -  car
	: type = VTYPE_HEAVY;

// ================ MONSTER =======
	case
	406,   //dumper  -  mtruck
	573,   //duneride,   //mtruck
	444,   //monster  -  mtruck
	556,   //monstera,   //mtruck
	557   //monsterb,   //mtruck
	: type = VTYPE_MONSTER;

// ================ TRAILER =======
	case
	435,   //artict1  -  trailer
	450,   //artict2  -  trailer
	591,   //artict3  -  trailer
	606,   //bagboxa  -  trailer
	607,   //bagboxb  -  trailer
	610,   //farmtr1  -  trailer
	584,   //petrotr  -  trailer
	608,   //tugstair -  trailer
	611   //utiltr1  -  trailer
	: type = VTYPE_TRAILER;

// ================== TRAIN =======
	case
	590,   //freibox  -  train
	569,   //freiflat,   //train
	537,   //freight  -  train
	538,   //streak  -  train
	570,   //streakc  -  train
	449   //tram  -  train
	: type = VTYPE_TRAIN;
	}
	}
	return type;
}

stock GetPlayers() //By rapidZ
{
	new players=0;
	for (new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i))
		{
			players++;
		}
	}
	return players;
}

stock str_replace(search[], replace[], source[]) //By Tratulla
{
	new newnick[256];
	new newlen;
	for (new i; i < strlen(source); i++)
	{
	    if (strlen(search) > 1 && i != (strlen(source) - 1))
	    {
	        new matched = 1;
	        new start = i;
	        for (new s=0; s < strlen(search) && matched == 1; s++)
	        {
	            if (source[i] != search[s] && s == 0)
	            {
	                newnick[newlen] = source[i];
	                matched = 0;
				} else
				{
		            if (source[i] == search[s])
		            {
		                i++;
		            } else
		            {
		                matched = 0;
					}
				}
	        }
	        if (matched == 0)
	        {
	            for (start=start; start <= i; start++)
	            {
	                newnick[newlen] = source[start];
	                newlen++;
	            }
	        } else
	        {
	            for (new r; r < strlen(replace); r++)
	            {
	                newnick[newlen] = replace[r];
	                newlen++;
	            }
				i = (start + (strlen(search) - 1));
	        }
	    } else
	    {
			if (strlen(search) == 1 && source[i] == search[0])
			{
			    for (new r; r < strlen(replace); r++)
			    {
			        newnick[newlen] = replace[r];
			        newlen++;
			    }
			} else
			{
			    newnick[newlen] = source[i];
			    newlen++;
			}
		}
	}
	newnick[newlen] = EOS;
	return newnick;
}

stock GameTextCheck(const string[]) //By Kamazy
{
	for (new i=0; i<strlen(string); i++)
	{
		if ((string[i] == 126) && (string[i-1] == 126) || (string[i] == ' ') && (string[i-1] == '~') && (string[i-2] == ' ') || (string[i] == '~') && (string[i+2] != '~') && (string[i-2] != '~') || (string[i] == '~') && (string[i+2] == '~') && (string[i-2] == '~'))
		{
			return 1;
		}
	}
	return 0;
}

stock SetPlayerPosEx(playerid,Float:x1,Float:y1,Float:z1,Float:Ang,Int) //By Kamazy
{
	SetPlayerInterior(playerid,Int);
	SetPlayerFacingAngle(playerid,Ang);
	SetPlayerPos(playerid,x1,x1,z1);
	SetCameraBehindPlayer(playerid);
	return 1;
}

stock IsPlayerInRange(playerid, Float:Range, Float:Z_Range, Float:tar_x, Float:tar_y, Float:tar_z) //By Gabriel "Larcius" Cordes
{
	new bool:care_z = true, Float:player_x, Float:player_y, Float:player_z, Float:radius_xy, Float:radius_z;
	GetPlayerPos(playerid, player_x, player_y, player_z);
	radius_xy = floatsqroot(floatadd(floatpower(floatsub(player_x,tar_x),2.0),floatpower(floatsub(player_y,tar_y),2.0)));
	radius_z = floatsqroot(floatadd(floatpower(radius_xy,2.0),floatpower(floatsub(player_z,tar_z),2.0)));
	if(radius_z > Z_Range && radius_xy < radius_z)
	{
		care_z = false;
	}
	if(radius_xy <= Range && care_z)
	{
		return 1;
	}
	return 0;
}

stock GivePlayerWeaponEx(playerid, ...) //By Peter
{
	new Count = numargs();
	for(new i = 1; i < Count; i += 2)
	{
		new WeaponID = getarg(i);
		new Ammo = getarg((i+1));
		if(WeaponID > 0 && WeaponID < 47)
		{
			GivePlayerWeaponAlt(playerid, WeaponID, Ammo);
		}
	}
	return 1;
}

stock SendClientMessageToAllOthers(playerid, color, const message[]) //By yom
{
	new ret=0;
	for (new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i) && i!=playerid)
		{
			SendClientMessage(i, color, message);
			ret++;
		}
	}
	return ret;
}

stock GameTextForAllOthers(playerid, const string[], time, style) //By yom
{
	new ret=0;
	for (new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i) && i != playerid)
		{
			GameTextForPlayer(i, string, time, style);
			ret++;
		}
	}
	return ret;
}

stock SetPlayerColourAlpha(playerid, alpha)
{
	return SetPlayerColorAlpha(playerid, alpha);
}

stock SetPlayerColorAlpha(playerid, alpha) //By Betamaster
{
	new r, g, b, a;
	HexToRGBA(GetPlayerColor(playerid), r, g, b, a);
	SetPlayerColor(playerid, RGBAToHex(r, g, b, alpha));
}

stock RGBAToHex(r, g, b, a) //By Betamaster
{
	return (r<<24 | g<<16 | b<<8 | a);
}

stock HexToRGBA(colour, &r, &g, &b, &a) //By Betamaster
{
	r = (colour >> 24) & 0xFF;
	g = (colour >> 16) & 0xFF;
	b = (colour >> 8) & 0xFF;
	a = colour & 0xFF;
}

stock IsPlayerInAreaEx(playerid, Float:...) //By kool
{
	new Count = numargs();
	new Float:xe[255], Float:ye[255];
	new j=0;
	for(new i=1; i<Count; i+=2)
	{
		xe[j] = Float:getarg(i);
		ye[j] = Float:getarg(i+1);
		j++;
	}
	xe[j] = xe[0];
	ye[j] = ye[0];
	new Lines;
	new Float:xcut;
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	for(new i=0; i<j; i++)
	{
		xcut = xe[i]+((y-ye[i])*(xe[i+1]-xe[i])/(ye[i+1]-ye[i]));
		if(((y >= ye[i] && y <= ye[i+1]) || (y >= ye[i+1] && y <= ye[i])) && xcut < x)
		{
			Lines++;
		}
	}
	if(Lines%2 == 1)
	{
		return 1;
	}
	return 0;
}

stock SetTeamScore(team, score) //By Hellomy
{
	for (new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i) && Players[i][Cur_team]==team)
		{
			SetPlayerScore(i, score);
		}
	}
	return 1;
}

stock GiveTeamMoney(team, amount) //By Hellomy
{
	for (new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i) && Players[i][Cur_team]==team)
		{
			GivePlayerMoney(i, amount);
		}
	}
	return 1;
}

stock SetTime(hours,minutes)
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		SetPlayerTime(i, hours, minutes);
	}
}

stock Wait(time)
{
	new stamp = tickcount();
	while (tickcount() - stamp < time)
	{
	}
	return 1;
}

stock strrest(const string[], index)
{
	new length = strlen(string);
	new offset = index;
	new result[256];
	while ((index < length) && ((index - offset) < (sizeof(result) - 1)) && (string[index] > '\r'))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

stock Float:lengthdir_x(Float:len,Float:angles) //By Slick
{
	return floatmul(floatcos(floatdiv(floatmul(angles,PI),180.0)),len);
}

stock Float:lengthdir_y(Float:len,Float:angles) //By Slick
{
	return floatmul(-floatsin(floatdiv(floatmul(angles,PI),180.0)),len);
}

stock FindEmptySlot(const array[], const length) //By Gabriel "Larcius" Cordes
{
	for (new i=0;i<length;i++)
	{
		if(!array[i])
		{
		    return i;
		}
		
	}
	return -1;
}

stock FindEmptySlot2D(const array[], const length, &d1, &d2) //By Gabriel "Larcius" Cordes
{
	for (new i=0; i<length; i++)
	{
	    if (array[i])
	    {
		new d2=FindEmptySlot(array[i][], sizeof(array[i]));
		if (d2!=-1)
		{
			new d1=i;
		        return d1, d2;
		}
	    }
	}
	d1=-1;
	d2=-1;
	return d1,d2;
}

stock FindIntegerInArray(const num, const array[], const length) //By Gabriel "Larcius" Cordes
{
	for (new i=0; i<length; i++)
	{
	    if (array[i] == num)
	    {
	        return i;
	    }
	}
	return -1;
}

stock FindStringInArray(const string[], const array[], const length) //By Gabriel "Larcius" Cordes
{
	for (new i=0; i<length; i++)
	{
	    if (strcmp(string, array[i], true) == 0)
	    {
	        return i;
	    }
	}
	return -1;
}

stock FindFloatInArray(const Float:num, const array[], const length) //By Gabriel "Larcius" Cordes
{
	for (new i=0; i<length; i++)
	{
	    if (array[i] == num)
	    {
	        return i;
	    }
	}
	return -1;
}

stock FindIntegerIn2DArray(const num, const array[], length, &d1, &d2) //By Gabriel "Larcius" Cordes
{
	for (new i=0; i<length; i++)
	{
	    if (array[i])
	    {
		new d2=FindIntegerInArray(num, array[i][], sizeof(array[i]));
		if (d2 != -1)
		{
			new d1=i;
		        return d1, d2;
		}
	    }
	}
	return -1;
}

stock FindStringIn2DArray(const string[], const array[], length, &d1, &d2) //By Gabriel "Larcius" Cordes
{
	for (new i=0; i<length; i++)
	{
	    if (array[i])
	    {
		new d2=FindStringInArray(num, array[i][], sizeof(array[i]));
		if (d2 != -1)
		{
			new d1=i;
		        return d1, d2;
		}
	    }
	}
	return -1;
}

stock FindFloatIn2DArray(const Float:num, const array[], length, &d1, &d2) //By Gabriel "Larcius" Cordes
{
	for (new i=0; i<length; i++)
	{
	    if (array[i])
	    {
		new d2=FindFloatInArray(num, array[i][], sizeof(array[i]));
		if (d2 != -1)
		{
			new d1=i;
		        return d1, d2;
		}
	    }
	}
	return -1;
}

stock AddArea(type,Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2,Float:radius1) //By Gabriel "Larcius" Cordes
{
	new areaid=0;
	while(IsAreaConnected(areaid) && areaid<MAX_AREAS)
	{
		areaid++;
	}
	if(areaid<MAX_AREAS)
	{
		Areas[areaid][Type]=0;
		switch (type)
		{
			case AREA_RECTANGLE:
			{
				if(x1!=x2 && y1!=y2)
				{
					Areas[areaid][Type]=AREA_RECTANGLE;
					Areas[areaid][X]=x1;
					Areas[areaid][Y]=y1;
					Areas[areaid][X2]=x2;
					Areas[areaid][Y2]=y2;
				}
			}
			case AREA_CIRCLE:
			{
				if(radius1!=0.0)
				{
					Areas[areaid][Type]=AREA_CIRCLE;
					Areas[areaid][X]=x1;
					Areas[areaid][Y]=y1;
					Areas[areaid][Radius]=radius1;
				}
			}
			case AREA_ASHLAR:
			{
				if(x1!=x2 && y1!=y2 && z1!=z2)
				{
					Areas[areaid][Type]=AREA_ASHLAR;
					Areas[areaid][X]=x1;
					Areas[areaid][Y]=y1;
					Areas[areaid][Z]=z1;
					Areas[areaid][X2]=x2;
					Areas[areaid][Y2]=y2;
					Areas[areaid][Z2]=z2;
				}
			}
			case AREA_SPHERE:
			{
				if(radius1!=0.0)
				{
					Areas[areaid][Type]=AREA_SPHERE;
					Areas[areaid][X]=x1;
					Areas[areaid][Y]=y1;
					Areas[areaid][Z]=z1;
					Areas[areaid][Radius]=radius1;
				}
			}
			case AREA_CYLINDER:
			{
				if(radius1!=0.0 && z2!=0.0)
				{
					Areas[areaid][Type]=AREA_CYLINDER;
					Areas[areaid][X]=x1;
					Areas[areaid][Y]=y1;
					Areas[areaid][Z]=z1;
					Areas[areaid][Z2]=z2;
					Areas[areaid][Radius]=radius1;
				}
			}
		}
		if(Areas[areaid][Type])
		{
			return areaid;
		}
	}
	return -1;
}

stock AddRectangleArea(Float:x1,Float:y1,Float:x2,Float:y2) //By Gabriel "Larcius" Cordes
{
	return AddArea(AREA_RECTANGLE,x1,y1,0.0,x2,y2,0.0,0.0);
}

stock AddCircleArea(Float:x1,Float:y1,Float:radius1) //By Gabriel "Larcius" Cordes
{
	return AddArea(AREA_CIRCLE,x1,y1,0.0,0.0,0.0,0.0,radius1);
}

stock AddAshlarArea(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2) //By Gabriel "Larcius" Cordes
{
	return AddArea(AREA_ASHLAR,x1,y1,z1,x2,y2,z2,0.0);
}

stock AddCubeArea(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2)
{
	return AddAshlarArea(x1,y1,z1,x2,y2,z2);
}

stock AddSphereArea(Float:x1,Float:y1,Float:z1,Float:radius1) //By Gabriel "Larcius" Cordes
{
	return AddArea(AREA_SPHERE,x1,y1,z1,0.0,0.0,0.0,radius1);
}

stock AddCylinderArea(Float:x1,Float:y1,Float:z1,Float:z2,Float:radius1) //By Gabriel "Larcius" Cordes
{
	return AddArea(AREA_Cylinder,x1,y1,z1,0.0,0.0,z2,radius1);
}

stock GetAreaType(areaid) //By Gabriel "Larcius" Cordes
{
	if(IsAreaConnected(areaid))
	{
		return Areas[areaid][Type];
	}
	return 0;
}

stock GetAreaParams(areaid,&type,&Float:x1,&Float:y1,&Float:z1,&Float:x2,&Float:y2,&Float:z2,&Float:radius1)
{
	if(IsAreaConnected(areaid))
	{
		type=Areas[areaid][Type];x1=Areas[areaid][X];y1=Areas[areaid][Y];z1=Areas[areaid][Z];x2=Areas[areaid][X2];y2=Areas[areaid][Y2];z2=Areas[areaid][Z2];radius1=Areas[areaid][Radius];
	}
	else
	{
		type=0;x1=0.0;y1=0.0;z1=0.0;x2=0.0;y2=0.0;z2=0.0;radius1=0.0;
	}
	return type,x1,y1,z1,x2,y2,z2,radius1;
}

stock IsPointInArea(Float:x1,Float:y1,Float:z1,areaid)
{
	if(IsAreaConnected(areaid))
	{
		switch (Areas[areaid][Type])
		{
			case AREA_RECTANGLE:
			{
				if(IsPointInRectangle(x1,y1,Areas[areaid][X],Areas[areaid][Y],Areas[areaid][X2],Areas[areaid][Y2]))
				{
					return 1;
				}
			}
			case AREA_CIRCLE:
			{
				if(IsPointInCircle(x1,y1,Areas[areaid][X],Areas[areaid][Y],Areas[areaid][Radius]))
				{
					return 1;
				}
			}
			case AREA_ASHLAR:
			{
				if(IsPointInAshlar(x1,y1,z1,Areas[areaid][X],Areas[areaid][Y],Areas[areaid][Z],Areas[areaid][X2],Areas[areaid][Y2],Areas[areaid][Z2]))
				{
					return 1;
				}
			}
			case AREA_SPHERE:
			{
				if(IsPointInSphere(x1,y1,z1,Areas[areaid][X],Areas[areaid][Y],Areas[areaid][Z],Areas[areaid][Radius]))
				{
					return 1;
				}
			}
			case AREA_CYLINDER:
			{
				if(IsPointInCylinder(x1,y1,z1,Areas[areaid][X],Areas[areaid][Y],Areas[areaid][Z],Areas[areaid][Z2],Areas[areaid][Radius]))
				{
					return 1;
				}
			}
		}
	}
	return 0;
}

stock IsPlayerInArea(playerid, areaid) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid))
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		if(IsPointInArea(x,y,z,areaid))
		{
			return 1;
		}
	}
	return 0;
}

stock IsAnyPlayerInArea(areaid) //By Gabriel "Larcius" Cordes
{
	if(IsAreaConnected(areaid))
	{
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(IsPlayerInArea(i, areaid))
			{
				return 1;
			}
		}
	}
	return 0;
}

stock IsPlayerInAnyArea(playerid) //By Gabriel "Larcius" Cordes
{
	if(IsPlayerConnected(playerid))
	{
		for(new i=0; i<MAX_AREAS; i++)
		{
			if(IsPlayerInArea(playerid, i))
			{
				return 1;
			}
		}
	}
	return 0;
}

stock AreaDestroy(areaid)
{
	return DestroyArea(areaid);
}

stock DestroyArea(areaid) //By Gabriel "Larcius" Cordes
{
	if(IsAreaConnected(areaid))
	{
		Areas[areaid][Type]=0;
		Areas[areaid][X]=0.0;
		Areas[areaid][Y]=0.0;
		Areas[areaid][Z]=0.0;
		Areas[areaid][X2]=0.0;
		Areas[areaid][Y2]=0.0;
		Areas[areaid][Z2]=0.0;
		Areas[areaid][Radius]=0.0;
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			Areas[areaid][PlayerInArea][i]=0;
		}
		return 1;
	}
	return 0;
}

stock strfloat(Float:value) //By Gabriel "Larcius" Cordes
{
	new string[MAX_STRING];
	format(string, sizeof(string), "%f", value);
	return string;
}

stock strfromfloat(Float:value)
{
	return strfloat(value);
}

stock floattostr(Float:value)
{
	return strfloat(value);
}

stock floatval(Float:value) //By Gabriel "Larcius" Cordes
{
	new string[MAX_STRING];
	string = strfloat(floatround(value));
	return strval(left(string,strfind(string, ".", true)));
}

stock floatint(Float:value)
{
	return floatval(value);
}

stock IsAnyPlayerInRangeOfVehicle(vehicleid,Float:range)
{
	for (new i=0; i<=MAX_PLAYERS;i++)
	{
		if (IsPlayerInRangeOfVehicle(i,vehicleid,range))
		{
			return 1;
		}
	}
	return 0;
}

public ClearOutOfRangeVehicles()
{
	#if !defined OutOfRange
	new Float:OutOfRange=250.0;
	#endif
	if(OutOfRange<=0)
	{
		OutOfRange=INF_FLOAT;
	}
	new ret=0;
	for (new i=0;i<MAX_VEHICLES;i++)
	{
		if(IsVehicleConnected(i) && Vehicles[i][Static]==-1 && !IsAnyPlayerInRangeOfVehicle(i, OutOfRange) && (!IsVehicleLockedForAnyPlayer(i) || (GetPlayers()==1 && IsVehicleObjectivedForAnyPlayer(i))))
		{
			DestroyVehicle2(i);
			ret++;
		}
	}
	return ret;
}

stock IsPlayerInRangeOfVehicle(playerid, vehicleid, Float:range) //By Gabriel "Larcius" Cordes
{
	if(IsVehicleConnected(vehicleid))
	{
		new Float:x1, Float:y1, Float:z1;
		GetVehiclePos(vehicleid, x1, y1, z1);
		return IsPlayerInSphere(playerid,x1,y1,z1,range);
	}
	return 0;
}

stock IsAnyPlayerInVehicle(vehicleid, status=PLAYER_STATE_NONE) //By Gabriel "Larcius" Cordes
{
// PLAYER_STATE_DRIVER means has to be driver, PLAYER_STATE_PASSENGER means has to be passenger, all other or nothing means don't care if driver or passenger
	for (new i=0; i<=MAX_PLAYERS; i++)
	{
		if (IsVehicleConnected(i) && IsPlayerInVehicle(i, vehicleid))
		{
			if (status==PLAYER_STATE_DRIVER)
			{
				if (IsPlayerDriver(i))
				{
		    			return 1;
				}
			}
			else if (status==PLAYER_STATE_PASSENGER)
			{
				if (IsPlayerPassenger(i))
				{
		    			return 1;
				}
			}
			else
			{
			    return 1;
			}
		}
	}
	return 0;
}



/*---------------------------------------- functions of dutils.inc ----------------------------------------*/

stock mktime(hour,minute,second,day,month,year)
{
	new timestamp2;

	timestamp2 = second + (minute * 60) + (hour * 3600);

	new days_of_month[12];

	if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) ) {
			days_of_month = {31,29,31,30,31,30,31,31,30,31,30,31}; // Schaltjahr
		} else {
			days_of_month = {31,28,31,30,31,30,31,31,30,31,30,31}; // keins
		}
	new days_this_year = 0;
	days_this_year = day;
	if(month > 1) { // No January Calculation, because its always the 0 past months
		for(new i=0; i<month-1;i++) {
			days_this_year += days_of_month[i];
		}
	}
	timestamp2 += days_this_year * 86400;

	for(new j=1970;j<year;j++) {
		timestamp2 += 31536000;
		if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) )  timestamp2 += 86400; // Schaltjahr + 1 Tag
	}

	return timestamp2;
}

stock ValidEmail(email[])
{
	return IsValidEmail(email);
}

stock Now()
{
	new hour,minute,second,year,month,day;
	gettime(hour, minute, second);
	getdate(year, month, day);
	return mktime(hour,minute,second,day,month,year);
}

stock HexToInt(string[])
{
	if (string[0]==0)
	{
		return 0;
	}
	new cur=1;
	new res=0;
	for (new i=strlen(string);i>0;i--)
	{
		if (string[i-1]<58)
		{
			res=res+cur*(string[i-1]-48);
		}
		else
		{
			res=res+cur*(string[i-1]-65+10);
		}
    cur=cur*16;
  }
  return res;
}

stock IntToHex(number)
{
	new m=1;
	new depth=0;
	while (number>=m)
	{
		m = m*16;
		depth++;
	}
	depth--;
	new str[MAX_STRING];
	for (new i = depth; i >= 0; i--)
	{
		str[i] = ( number & 0x0F) + 0x30; // + (tmp > 9 ? 0x07 : 0x00)
		str[i] += (str[i] > '9') ? 0x07 : 0x00;
		number >>= 4;
	}
	str[8] = '\0';
	return str;
}

stock StrToInt(string[])
{
	return strval(string);
}

stock IntToStr(value)
{
	new tmp[MAX_STRING];
	valstr(tmp, value);
	return tmp;
}

stock trunc(Float:value)
{
	return floatround(value,floatround_floor);
}

stock SetPlayerMoney(playerid,howmuch)
{
	PRIVATE_Last_Money[playerid]=howmuch;
	GivePlayerMoney(playerid,(howmuch-GetPlayerMoney(playerid)));
}

stock fcopy(oldname[],newname[])
{
	new File:ohnd,File:nhnd;
	if (!fexist(oldname))
	{
		return 0;
	}
	ohnd=fopen(oldname,io_read);
	nhnd=fopen(newname,io_write);
	new buf2[1];
	for (new i=flength(ohnd);i>0;i--)
	{
		fputchar(nhnd, fgetchar(ohnd, buf2[0],false),false);
	}
	fclose(ohnd);
	fclose(nhnd);
	return 1;
}

stock fcopytextfile(oldname[],newname[])
{
	new File:ohnd,File:nhnd;
	if (!fexist(oldname))
	{
		return 0;
	}
	ohnd=fopen(oldname,io_read);
	nhnd=fopen(newname,io_write);
	new tmpres[MAX_STRING];
	while (fread(ohnd,tmpres))
	{
		StripNewLine(tmpres);
		format(tmpres,sizeof(tmpres),"%s\r\n",tmpres);
		fwrite(nhnd,tmpres);
	}
	fclose(ohnd);
	fclose(nhnd);
	return 1;
}

stock frename(oldname[],newname[])
{
    if (!fexist(oldname))
	{
		return 0;
	}
    fremove(newname);
    if (!fcopy(oldname,newname))
	{
		return 0;
	}
    fremove(oldname);
    return 1;
}

stock frenametextfile(oldname[],newname[]) {
    if (!fexist(oldname))
	{
		return 0;
	}
    fremove(newname);
    if (!fcopytextfile(oldname,newname))
	{
		return 0;
	}
    fremove(oldname);
    return 1;
}

stock StripNewLine(string[])
{
	new len = strlen(string);
	if (string[0]==0)
	{
		return ;
	}
	if (string[(len-1)]=='\n' || string[(len-1)]=='\r')
	{
		string[(len-1)] = 0;
		if (string[0]==0)
		{
			return ;
		}
		if (string[(len-2)]=='\n' || string[(len-2)]=='\r')
		{
			string[(len-2)] = 0;
		}
	}
}

stock ret_memcpy(source[],index=0,numbytes)
{
	new tmp[MAX_STRING];
	tmp[0]=0;
	if (index>=strlen(source))
	{
		return tmp;
	}
	if (numbytes+index>=strlen(source))
	{
		numbytes=strlen(source)-index;
	}
	if (numbytes<=0)
	{
		return tmp;
	}
	for (new i=index;i<numbytes+index;i++)
	{
		tmp[i-index]=source[i];
		if (source[i]==0)
		{
			return tmp;
		}
	}
	tmp[numbytes]=0;
	return tmp;
}

stock copy(dest[],source[],count)
{
	dest[0]=0;
	if (count<0)
	{
		return 0;
	}
	if (count>strlen(source))
	{
		count=strlen(source);
	}
	for (new i=0;i<count;i++) {
		dest[i]=source[i];
		if (source[i]==0)
		{
			return true;
		}
	}
	dest[count]=0;
	return 1;
}

stock delete(string[],count)
{
	new tmp[MAX_STRING];
	tmp[0]=0;
	if (count<=0)
	{
		format(tmp,sizeof(tmp),"%s",string);
		return tmp;
	}
	tmp=ret_memcpy(string,count,strlen(string));
	return tmp;
}

stock set(dest[],source[])
{
	new count = strlen(source);
	new i=0;
	for (i=0;i<count;i++)
	{
		dest[i]=source[i];
	}
	dest[count]=0;
}

stock equal(str1[],str2[],bool:ignorecase)
{
	if (strlen(str1)!=strlen(str2))
	{
		return 0;
	}
	if (strcmp(str1,str2,ignorecase)==0)
	{
		return 1;
	}
	return 0;
}

stock mod(up,down) {
	  return up-(floatround((up/down),floatround_floor))*down;
}

stock div(up,down)
{
	  return (floatround((up/down),floatround_floor));
}

stock num_hash(buf[])
 {
	new length=strlen(buf), s1=1, s2=0;
	for (new n=0; n<length; n++)
	{
		s1 = (s1 + buf[n]) % 65521;
		s2 = (s2 + s1)     % 65521;
	}
	return ((s2 << 16) + s1);
}

stock hash(str2[])
{
	new tmpdasdsa[MAX_STRING];
	tmpdasdsa[0]=0;
	valstr(tmpdasdsa,num_hash(str2));
	return tmpdasdsa;
}

stock strreplace(trg[],newstr[],src[])
{
    new f=0;
    new s1[MAX_STRING];
    new tmp[MAX_STRING];
    format(s1,sizeof(s1),"%s",src);
    f = strfind(s1,trg);
    tmp[0]=0;
    while (f>=0)
	{
        strcat(tmp,ret_memcpy(s1, 0, f));
        strcat(tmp,newstr);
        format(s1,sizeof(s1),"%s",ret_memcpy(s1, f+strlen(trg), strlen(s1)-f));
        f = strfind(s1,trg);
    }
    strcat(tmp,s1);
    return tmp;
}

stock strlower(txt[])
{
	new tmp[MAX_STRING];
	tmp[0]=0;
	if (txt[0]==0)
	{
		return tmp;
	}
	for (new i=0;i<strlen(txt);i++)
	{
		tmp[i]=tolower(txt[i]);
	}
	tmp[strlen(txt)]=0;
	return tmp;
}

stock strupper(txt[])
{
	new tmp[MAX_STRING];
	tmp[0]=0;
	if (txt[0]==0)
	{
		return tmp;
	}
	for (new i=0;i<strlen(txt);i++)
	{
		tmp[i]=toupper(txt[i]);
	}
	tmp[strlen(txt)]=0;
	return tmp;
}


/*---------------------------------------- functions of dutils.inc ----------------------------------------*/





/* Useful Callbacks: */



public ufctimer()
{
	for (new i=0; i<MAX_VEHICLES; i++)
	{
		if(IsVehicleConnected(i))
		{
			CheckVehicle(i);
		}
	}
	for (new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			CheckArea(i);
			CheckPickup(i);
			CheckShot(i);
			CheckPlayer(i);
		}
	}
}

public Speeder(ms) //By Gabriel "Larcius" Cordes
{
	new mspassed=(tickcount()-SpeederTime);
	if(mspassed>=ms)
	{
		SpeederTime=tickcount();
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				UpdateSpeed(i,mspassed);
			}
		}
	}
	return 1;
}

public Counter() //By Gabriel "Larcius" Cordes
{
	if((tickcount()-CountersTime)>=1000)
	{
		CountersTime=tickcount();
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(Counters[i][Down][Style])
				{
					if(Counters[i][Down][Time]>0 && Counters[i][Down][Time]<4)
					{
						PlayerPlaySound2(i, 1056);
					}
					else if(Counters[i][Down][Time]==0)
					{
						PlayerPlaySound2(i, 1057);
					}
					if(Counters[i][Down][Time]<=0)
					{
						TextDrawDestroy(Text:Counters[i][Down][TextID]);
						Counters[i][Down][TextID]=0;
						Counters[i][Down][Style]=0;
						Counters[i][Down][Time]=0;
						TogglePlayerControllable2(i, 1, FREEZE_COUNTDOWN);
					}
					else
					{
						if (Counters[i][Down][Style]==1)
						{
							if(!Counters[i][Down][TextID])
							{
								Counters[i][Down][TextID]=_:TextDrawCreate(300.0, 250.0, SecondsToString(Counters[i][Down][Time],1));
								TextDrawShowForPlayer(i, Text:Counters[i][Down][TextID]);
							}
							else
							{
								 TextDrawSetString(Text:Counters[i][Down][TextID], SecondsToString(Counters[i][Down][Time],1));
							}
							Counters[i][Down][Time]--;
						}
						else if (Counters[i][Down][Style]==2)
						{
							if(!Counters[i][Down][TextID])
							{
								Counters[i][Down][TextID]=_:TextDrawCreate(20.0, 100.0, SecondsToString(Counters[i][Down][Time],1));
								TextDrawShowForPlayer(i, Text:Counters[i][Down][TextID]);
							}
							else
							{
								 TextDrawSetString(Text:Counters[i][Down][TextID], SecondsToString(Counters[i][Down][Time],1));
							}
							Counters[i][Down][Time]--;
						}
					}
				}
				if(Counters[i][Up][Style])
				{
					if((Counters[i][Up][Time]-Counters[i][Up][Time2])>0 && (Counters[i][Up][Time]-Counters[i][Up][Time2])<4)
					{
						PlayerPlaySound2(i, 1056);
					}
					else if((Counters[i][Up][Time]-Counters[i][Up][Time2])==0)
					{
						PlayerPlaySound2(i, 1057);
					}
					if(Counters[i][Up][Time2]>=Counters[i][Up][Time])
					{
						TextDrawDestroy(Text:Counters[i][Up][TextID]);
						Counters[i][Up][TextID]=0;
						Counters[i][Up][Style]=0;
						Counters[i][Up][Time]=0;
						Counters[i][Up][Time2]=0;
						TogglePlayerControllable2(i, 1, FREEZE_COUNTUP);
					}
					else
					{
						if (Counters[i][Up][Style]==1)
						{
							if(!Counters[i][Up][TextID])
							{
								Counters[i][Up][TextID]=_:TextDrawCreate(300.0, 250.0, SecondsToString(Counters[i][Up][Time2],1));
								TextDrawShowForPlayer(i, Text:Counters[i][Up][TextID]);
							}
							else
							{
								 TextDrawSetString(Text:Counters[i][Up][TextID], SecondsToString(Counters[i][Up][Time2],1));
							}
							Counters[i][Up][Time2]++;
						}
						else if (Counters[i][Up][Style]==2)
						{
							if(!Counters[i][Up][TextID])
							{
								Counters[i][Up][TextID]=_:TextDrawCreate(20.0, 100.0, SecondsToString(Counters[i][Up][Time2],1));
								TextDrawShowForPlayer(i, Text:Counters[i][Up][TextID]);
							}
							else
							{
								 TextDrawSetString(Text:Counters[i][Up][TextID], SecondsToString(Counters[i][Up][Time2],1));
							}
							Counters[i][Up][Time2]++;
						}
					}
				}
			}
		}
		return 1;
	}
	return 0;
}


stock CheckPickup(playerid)
{
	for(new i=0; i<MAX_PICKUPS; i++)
	{
		if(IsPickupConnected(i))
		{
			if(IsPlayerInSphere(playerid,Pickups[i][X],Pickups[i][Y],Pickups[i][Z],1.0))
			{
				#if defined OnPlayerPickupItem
				OnPlayerPickupItem(playerid,i,Pickups[i][Model],Pickups[i][Type]);
				if(Pickups[i][Respawn]==2)
				{
					Pickups[i][Respawn]=180;
				}
				#endif
			}
			if(Pickups[i][Respawn]==0)
			{
				#if defined OnPlayerGetShot
				OnPickupRespawn(i,Pickups[i][Model]);
				#endif
				Pickups[i][Respawn]=999;
			}
			if(Pickups[i][Respawn]!=999)
			{
				Pickups[i][Respawn]--;
			}
		}
	}
}

stock CheckShot(playerid)
{
	new Float:x1, Float:y1, Float:z1, Float:h, rh;
	GetPlayerPos(playerid,x1,y1,z1);
	GetPlayerHealth(playerid,h);
	rh = floatround(h);
	if(preh[playerid]-rh > 5)
	{
		new cid = GetClosestPlayer(playerid);
		new Float:dis = GetDistanceBetweenPlayers(playerid, cid);
		if(dis<100.0 && z1>=Players[playerid][Z])
		{
			if(IsPlayerInAnyVehicle(cid))
			{
				if(GetPlayerSpeed(cid,SPEED_KMPH) < 75.0)
				{
				}
				#if defined OnPlayerGetShot
				OnPlayerGetShot(playerid);
				#endif
			}
			#if defined OnPlayerGetShot
			OnPlayerGetShot(playerid);
			#endif
		}
	}
	preh[playerid] = rh;
}

stock UpdateSpeed(playerid,ms) //By Gabriel "Larcius" Cordes
{
	new Float:x1,Float:y1,Float:z1,Float:distance,Float:tmp,Float:speedprev,txt[MAX_STRING];
	GetPlayerPos(playerid,x1,y1,z1);
	distance = GetDistanceToPoint(playerid,Players[playerid][X],Players[playerid][Y],Players[playerid][Z]);
	speedprev = Players[playerid][Speed][MPS];
	tmp = floatdiv(floatmul(distance,1000.0),float(ms));
	Players[playerid][Speed][MPS] = tmp;
	Players[playerid][Speed][KMPH] = floatmul(tmp,3.6);
	Players[playerid][Speed][MPH] = floatmul(tmp,5.76);
	tmp = floatdiv(floatmul(floatsub(tmp,speedprev),1000.0),float(ms));
	Players[playerid][Acceleration][MPS2] = tmp;
	Players[playerid][Acceleration][KMPH2] = floatdiv(tmp,12960.0);
	Players[playerid][Acceleration][G] = floatdiv(tmp,9.81);
	Players[playerid][X] = x1;
	Players[playerid][Y] = y1;
	Players[playerid][Z] = z1;

	if(!Players[playerid][Speed][Show] && Players[playerid][Speed][TextID])
	{
		TextDrawDestroy(Text:Players[playerid][Speed][TextID]);
	}
	else if(Players[playerid][Speed][Show])
	{
		new show_speed=Players[playerid][Speed][Show];
		format(txt, sizeof(txt), "%d km/h", floatval(GetPlayerSpeed(playerid,SPEED_KMPH)));
		switch (show_speed)
		{
			case SPEED_MPS: format(txt, sizeof(txt), "%d m/s", floatval(GetPlayerSpeed(playerid,show_speed)));
			case SPEED_KMPH: format(txt, sizeof(txt), "%d km/h", floatval(GetPlayerSpeed(playerid,show_speed)));
			case SPEED_MPH: format(txt, sizeof(txt), "%d m/h", floatval(GetPlayerSpeed(playerid,show_speed)));
		}
		if(!Players[playerid][Speed][TextID])
		{
			Players[playerid][Speed][TextID]=_:TextDrawCreate(10.0, 100.0, txt);
			TextDrawFont(Text:Players[playerid][Speed][TextID], 3);
			TextDrawShowForPlayer(playerid, Text:Players[playerid][Speed][TextID]);
		}
		else
		{
			TextDrawSetString(Text:Players[playerid][Speed][TextID], txt);
		}
	}

	if(!Players[playerid][Acceleration][Show] && Players[playerid][Acceleration][TextID])
	{
		TextDrawDestroy(Text:Players[playerid][Acceleration][TextID]);
	}
	else if(Players[playerid][Acceleration][Show])
	{
		new show_acc=Players[playerid][Acceleration][Show];
		format(txt, sizeof(txt), "%d km/h", floatval(GetPlayerAcceleration(playerid,ACC_MPS2)));
		switch (show_acc)
		{
			case ACC_MPS2: format(txt, sizeof(txt), "%d m/ss", floatval(GetPlayerAcceleration(playerid,show_acc)));
			case ACC_KMPH2: format(txt, sizeof(txt), "%d km/hh", floatval(GetPlayerAcceleration(playerid,show_acc)));
			case ACC_G: format(txt, sizeof(txt), "%d g", floatval(GetPlayerAcceleration(playerid,show_acc)));
		}
		if(!Players[playerid][Acceleration][TextID])
		{
			Players[playerid][Acceleration][TextID]=_:TextDrawCreate(10.0, 120.0, txt);
			TextDrawFont(Text:Players[playerid][Acceleration][TextID], 3);
			TextDrawShowForPlayer(playerid, Text:Players[playerid][Acceleration][TextID]);
		}
		else
		{
			TextDrawSetString(Text:Players[playerid][Acceleration][TextID], txt);
		}
	}
}

stock CheckArea(playerid)
{
	new Float:x1,Float:y1,Float:z1;
	GetPlayerPos(playerid,x1,y1,z1);
	for(new areaid=0; areaid<MAX_AREAS; areaid++)
	{
		if(IsAreaConnected(areaid))
		{
			if(IsPlayerInArea(playerid,areaid))
			{
				if(!Areas[areaid][PlayerInArea][playerid])
				{
					Areas[areaid][PlayerInArea][playerid]=1;
					#if defined OnPlayerEnterArea
					OnPlayerEnterArea(playerid,areaid);
					#endif
				}
			}
			else if(Areas[areaid][PlayerInArea][playerid])
			{
				Areas[areaid][PlayerInArea][playerid]=0;
				#if defined OnPlayerLeaveArea
				OnPlayerLeaveArea(playerid,areaid);
				#endif
			}
		}
	}
	new moneys = GetPlayerMoney(playerid);
	new tmpmon = Players[playerid][Money]-moneys;
	new tmpmon2 = moneys-Players[playerid][Money];
	#if defined OnPlayerGamble
	new nb;
	#endif
	if(tmpmon > 0)
	{
		#if defined OnPlayerBuyWeapon
		for(new i=0;i<sizeof(lvammu);i++)
		{
			if(IsPlayerInSphere(playerid,lvammu[i][0],lvammu[i][1],lvammu[i][2],1.0))
			{
				switch (tmpmon)
				{
					case 200:OnPlayerBuyWeapon(playerid,22,200);
					case 240:OnPlayerBuyWeapon(playerid,0,240);
					case 300:OnPlayerBuyWeapon(playerid,32,300);
					case 500:OnPlayerBuyWeapon(playerid,28,500);
					case 600:{OnPlayerBuyWeapon(playerid,23,600);OnPlayerBuyWeapon(playerid,25,0);}
					case 800:OnPlayerBuyWeapon(playerid,26,800);
					case 1200:{OnPlayerBuyWeapon(playerid,24,1200);OnPlayerBuyWeapon(playerid,27,1200);}
					case 2000:OnPlayerBuyWeapon(playerid,29,2000);
					case 3500:OnPlayerBuyWeapon(playerid,30,3500);
					case 4500:OnPlayerBuyWeapon(playerid,31,4500);
				}
			}
		}
		for(new i=0;i<sizeof(ammu);i++)
		{
			if(IsPlayerInSphere(playerid,ammu[i][0],ammu[i][1],ammu[i][2],1.0))
			{
				switch (tmpmon)
				{
					case 200:{OnPlayerBuyWeapon(playerid,22,200);OnPlayerBuyWeapoon(playerid,0,0);}
					case 300:OnPlayerBuyWeapon(playerid,32,300);
					case 500:OnPlayerBuyWeapon(playerid,28,500);
					case 600:{OnPlayerBuyWeapon(playerid,23,600);OnPlayerBuyWeapon(playerid,25,0);}
					case 800:OnPlayerBuyWeapon(playerid,26,800);
					case 1200:{OnPlayerBuyWeapon(playerid,24,1200);OnPlayerBuyWeapon(playerid,27,1200);}
					case 2000:OnPlayerBuyWeapon(playerid,29,2000);
					case 3500:OnPlayerBuyWeapon(playerid,30,3500);
					case 4500:OnPlayerBuyWeapon(playerid,31,4500);
				}
			}
		}
		#endif
		#if defined OnPlayerBuyPizza
		if(IsPlayerInSphere(playerid,374.0000,374.0000,374.0000,1.0))
		{
			switch (tmpmon)
			{
				case 2:OnPlayerBuyPizza(playerid,2);
			}
		}
		#endif
		#if defined OnPlayerBuyChicken
		if(IsPlayerInSphere(playerid,368.7890,-6.8570,1001.8516,1.0))
		{
			switch (tmpmon)
			{
				case 2:OnPlayerBuyChicken(playerid,2.0);
			}
		}
		#endif
		#if defined OnPlayerBuyBurger
		if(IsPlayerInSphere(playerid,375.5660,-68.2220,1001.5151,1.0))
		{
			switch (tmpmon)
			{
				case 2:OnPlayerBuyBurger(playerid,2);
			}
		}
		#endif
		#if defined OnPlayerBuyDrink
		if(tmpmon == 5)
		{
			OnPlayerBuyDrink(playerid,5);
		}
		#endif
		#if defined OnPlayerGamble
		if(betting[playerid] != 0)
		{
			if(bets[playerid] == 0)
			{
				bets[playerid] = tmpmon;
			}
			else
			{
				OnPlayerGamble(playerid,betting[playerid],bets[playerid],0);
				betting[playerid] = 0;
				bets[playerid] = 0;
			}
		}
		#endif
		#if defined OnPlayerModVehicle
		if(IsPlayerInSphere(playerid,617.5360,-1.9889,1000.6190,4.0) && IsPlayerInAnyVehicle(playerid))
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			switch (tmpmon)
			{
				case 150:OnPlayerModVehicle(playerid,vehicleid,1,150);
				case 200:OnPlayerModVehicle(playerid,vehicleid,2,200);
				case 250:OnPlayerModVehicle(playerid,vehicleid,3,250);
				case 300:OnPlayerModVehicle(playerid,vehicleid,4,300);
				case 350:{OnPlayerModVehicle(playerid,vehicleid,5,350);OnPlayerModVehicle(playerid,vehicleid,6,0);}
				case 500:{OnPlayerModVehicle(playerid,vehicleid,7,500);OnPlayerModVehicle(playerid,vehicleid,8,0);}
				case 550:OnPlayerModVehicle(playerid,vehicleid,9,550);
				case 620:OnPlayerModVehicle(playerid,vehicleid,10,620);
				case 770:OnPlayerModVehicle(playerid,vehicleid,11,770);
				case 820:OnPlayerModVehicle(playerid,vehicleid,12,820);
				case 1000:{OnPlayerModVehicle(playerid,vehicleid,13,1000);OnPlayerModVehicle(playerid,vehicleid,14,0);OnPlayerModVehicle(playerid,vehicleid,15,0);}
				case 1030:OnPlayerModVehicle(playerid,vehicleid,16,1030);
				case 1140:OnPlayerModVehicle(playerid,vehicleid,17,1140);
				case 1200:OnPlayerModVehicle(playerid,vehicleid,18,1200);
				case 1230:OnPlayerModVehicle(playerid,vehicleid,19,1230);
				case 1500:OnPlayerModVehicle(playerid,vehicleid,20,1500);
				case 1560:OnPlayerModVehicle(playerid,vehicleid,21,1560);
			}
		}
		#endif
	}
	if(tmpmon2 > 0)
	{
		#if defined OnPlayerGamble
		if(betting != 0)
		{
			OnPlayerGamble(playerid,betting[playerid],bets[playerid],1);
			betting[playerid] = 0;
			bets[playerid] = 0;
		}
		#endif
	}
	#if defined OnPlayerGamble
	for(new i=0;i<sizeof(gamble1);i++)
	{
		if(IsPlayerInSphere(playerid,gamble1[i][0],gamble1[i][1],gamble1[i][2],1.0)
		{
			betting[playerid] = 1;
			nb++;
		}
	}
	for(new i=0;i<sizeof(gamble2);i++)
	{
		if(IsPlayerInSphere(playerid,gamble2[i][0],gamble2[i][1],gamble2[i][2],1.0)
		{
			betting[playerid] = 2;
			nb++;
		}
	}
	for(new i=0;i<sizeof(gamble3);i++)
	{
		if(IsPlayerInSphere(playerid,gamble3[i][0],gamble3[i][1],gamble3[i][2],1.0)
		{
			betting[playerid] = 3;
			nb++;
		}
	}
	for(new i=0;i<sizeof(gamble4);i++)
	{
		if(IsPlayerInSphere(playerid,gamble4[i][0],gamble4[i][1],gamble4[i][2],1.0)
		{
			betting[playerid] = 4;
			nb++;
		}
	}
	for(new i=0;i<sizeof(gamble5);i++)
	{
		if(IsPlayerInSphere(playerid,gamble5[i][0],gamble5[i][1],gamble5[i][2],1.0)
		{
			betting[playerid] = 2;
			nb++;
		}
	}
	for(new i=0;i<sizeof(gamble6);i++)
	{
		if(IsPlayerInSphere(playerid,gamble6[i][0],gamble6[i][1],gamble6[i][2],1.0)
		{
			betting[playerid] = 5;
			nb++;
		}
	}
	for(new i=0;i<sizeof(gamble7);i++)
	{
		if(IsPlayerInSphere(playerid,gamble7[i][0],gamble7[i][1],gamble7[i][2],1.0)
		{
			betting[playerid] = 3;
			nb++;
		}
	}
	if(nb == 0)
	{
		betting[playerid] = 0;
		bets[playerid] = 0;
	}
	#endif
}

stock CheckVehicle(vehicleid) //By Gabriel "Larcius" Cordes
{
	new Float:h, trailerid=-1;
	GetVehicleHealth(vehicleid, h);
	if(IsTrailerAttachedToVehicle(vehicleid))
	{
		trailerid=GetVehicleTrailer(vehicleid);
	}
	#if defined OnVehicleGetHealth
	if(h!=Vehicles[vehicleid][Health])
	{
		OnVehicleGetHealth(vehicleid, floatsub(h,Vehicles[vehicleid][Health]));
	}
	#endif
	if(trailerid>0 && Vehicles[vehicleid][Cur_Trailer]<0)
	{
		Vehicles[vehicleid][Cur_Trailer]=trailerid;
		#if defined OnVehicleAttachTrailer
		OnVehicleAttachTrailer(vehicleid, trailerid);
		#endif
	}
	else if(trailerid<0 && Vehicles[vehicleid][Cur_Trailer]>0)
	{
		Vehicles[vehicleid][Last_Trailer]=Vehicles[vehicleid][Cur_Trailer];
		Vehicles[vehicleid][Cur_Trailer]=-1;
		#if defined OnVehicleDetachTrailer
		OnVehicleDetachTrailer(vehicleid, Vehicles[vehicleid][Cur_Trailer]);
		#endif
	}
}

stock CheckPlayer(playerid) //By Rafelder (edited by Gabriel "Larcius" Cordes)
{
	new Float:h, Float:a, m, t, s, w, sc, wl, keys, updown, leftright;
	GetPlayerHealth(playerid, h);
	GetPlayerArmour(playerid, a);
	t=GetPlayerTeam(playerid);
	m=GetPlayerMoney(playerid);
	s=GetPlayerState(playerid);
	w=GetPlayerWeapon(playerid);
	sc=GetPlayerScore(playerid);
	wl=GetPlayerWantedLevel(playerid);
	GetPlayerKeys(playerid, keys, updown, leftright);
	#if defined OnPlayerGetHealth
	if (h!=Players[playerid][Health])
	{
		OnPlayerGetHealth(playerid,floatsub(h,Players[playerid][Health]));
	}
	#endif
	#if defined OnPlayerGetArmour
	if (a!=Players[playerid][Armour])
	{
		OnPlayerGetArmour(playerid,floatsub(a,Players[playerid][Armour]));
	}
	#endif
	#if defined OnPlayerGetMoney
	if (m!=Players[playerid][Money])
	{
		OnPlayerGetMoney(playerid,(m-Players[playerid][Money]));
	}
	#endif
	if (t!=Players[playerid][Cur_Team])
	{
		Players[playerid][Last_Team]=Players[playerid][Cur_Team];
		Players[playerid][Cur_Team]=t;
		#if defined OnPlayerChangeTeam
		OnPlayerChangeTeam(playerid, Players[playerid][Last_Team], t); //By Gabriel "Larcius" Cordes
		#endif
	}
	if (s!=Players[playerid][State])
	{
		if(s==PLAYER_STATE_DRIVER || s==PLAYER_STATE_PASSENGER)
		{
			new vehicleid=GetPlayerVehicleID(playerid);
			if (Vehicles[vehicleid][Locked][playerid])
			{
				new Float:x1, Float:y1, Float:z1;
				GetPlayerPos(playerid, x1, y1, z1);
				GameTextForPlayer(playerid, "~w~This vehicle is locked", 3000, 4);
				RemovePlayerFromVehicle(playerid);
				SetPlayerPos(playerid, x1, y1, z1);
			}
			else if(IsVehicleLockedForAnyPlayer(vehicleid) || (GetPlayers()==1 && IsVehicleObjectivedForPlayer(vehicleid, playerid)))
			{
				SetVehicleParamsForAll(vehicleid, 0, 0, 1);
			}
			new Text:txt=TextDrawCreateTimer(500.0,400.0,GetVehicleName(vehicleid),3000);
			TextDrawFont(txt,3);
			TextDrawShowForPlayer(playerid,txt);
		}
		else
		{
			Players[playerid][Last_Vehicle]=Players[playerid][Cur_Vehicle];
			new vehicleid=Players[playerid][Last_Vehicle];
			if ((Players[playerid][State]==PLAYER_STATE_DRIVER || Players[playerid][State]==PLAYER_STATE_PASSENGER) && IsVehicleLockedForPlayer(vehicleid, playerid))
			{
				new Float:x1, Float:y1, Float:z1;
				GetVehiclePos(vehicleid, x1, y1, z1);
				SetVehicleParamsForPlayer2(vehicleid, playerid, 1, 0, 1);
			}
		}
		#if defined OnPlayerChangeState
		OnPlayerChangeState(playerid, Players[playerid][State], s, Players[playerid][Last_Vehicle]);
		#endif
	}
	#if defined OnPlayerSwitchWeapon
	if (w!=Players[playerid][Weapon])
	{
		OnPlayerSwitchWeapon(playerid, Players[playerid][Weapon], w);
	}
	#endif
	#if defined OnPlayerGetScore
	if (sc!=Players[playerid][Score])
	{
		OnPlayerGetScore(playerid, (sc-Players[playerid][Score]));
	}
	#endif
	#if defined OnPlayerGetWantedLevel
	if (wl!=Players[playerid][Wanted])
	{
		OnPlayerGetWantedLevel(playerid, (wl-Players[playerid][Wanted]));
	}
	#endif
	#if defined OnPlayerPressMoveKey
	if (updown)
	{
		OnPlayerPressMoveKey(playerid, updown);
	}
	else if (updown)
	{
		OnPlayerPressMoveKey(playerid, leftright);
	}
	#endif
	#if defined OnPlayerPressKey
	if(keys && !updown && !leftright)
	{
		OnPlayerPressKey(playerid, keys);
	}
	#endif

	Players[playerid][Health]=h;
	Players[playerid][Armour]=a;
	Players[playerid][Money]=m;
	Players[playerid][State]=s;
	Players[playerid][Weapon]=w;
	Players[playerid][Score]=sc;
	Players[playerid][Wanted]=wl;
	if(IsPlayerInAnyVehicle(playerid))
	{
		Players[playerid][Cur_Vehicle]=GetPlayerVehicleID(playerid);
	}
	else
	{
		Players[playerid][Cur_Vehicle]=-1;
	}
	if (h<0.0)
	{
		Players[playerid][Health]=0.0;
		Players[playerid][Armour]=0.0;
	}
}



forward ufctimer();
forward Counter();
forward Speeder(ms);
forward ClearOutOfRangeVehicles();
forward TextDrawDestroyTimer2(textid);

// --------------------------------------------------
// Forwards (Callback declarations)
// --------------------------------------------------

#if defined OnPlayerPickupItem
forward OnPlayerPickupItem(playerid,pickupid,modelid,type);
#endif
#if defined OnPickupRespawn
forward OnPickupRespawn(pickupid,modelid);
#endif
#if defined OnPlayerGetShot
forward OnPlayerGetShot(playerid);
#endif
#if defined OnPlayerBuyWeapon
forward OnPlayerBuyWeapon(playerid,weaponid,cost);
#endif
#if defined OnPlayerBuyPizza
forward OnPlayerBuyPizza(playerid,cost);
#endif
#if defined OnPlayerBuyChicken
forward OnPlayerBuyChicken(playerid,cost);
#endif
#if defined OnPlayerBuyBurger
forward OnPlayerBuyBurger(playerid,cost);
#endif
#if defined OnPlayerBuyDrink
forward OnPlayerBuyDrink(playerid,cost);
#endif
#if defined OnPlayerGamble
forward OnPlayerGamble(playerid,type,bet,wl);
#endif
#if defined OnPlayerModVehicle
forward OnPlayerModVehicle(playerid,vehicleid,partid,cost);
#endif
#if defined OnVehicleSpawn2
forward OnVehicleSpawn2(vehicleid,dynamic);
#endif

#if defined OnPlayerGetHealth
forward OnPlayerGetHealth(playerid, Float:health);
#endif
#if defined OnPlayerGetArmour
forward OnPlayerGetArmour(playerid, Float:armour);
#endif
#if defined OnPlayerGetMoney
forward OnPlayerGetMoney(playerid, money);
#endif
#if defined OnPlayerGetScore
forward OnPlayerGetScore(playerid, score);
#endif
#if defined OnPlayerGetWantedLevel
forward OnPlayerGetWantedLevel(playerid, wantedlevel);
#endif
#if defined OnPlayerChangeTeam
forward OnPlayerChangeTeam(playerid, prev_team, cur_team);
#endif
#if defined OnPlayerChangeState
forward OnPlayerChangeState(playerid, prev_state, cur_state, last_vehicleid);
#endif
#if defined OnPlayerSwitchWeapon
forward OnPlayerSwitchWeapon(playerid, prev_weapon, cur_weapon);
#endif
#if defined OnPlayerPressKey
forward OnPlayerPressKey(playerid, key);
#endif
#if defined OnPlayerPressMoveKey
forward OnPlayerPressMoveKey(playerid, key);
#endif
#if defined OnVehicleGetHealth
forward OnVehicleGetHealth(vehicleid, Float:health);
#endif
#if defined OnVehicleAttachTrailer
forward OnVehicleAttachTrailer(vehicleid, trailerid);
#endif
#if defined OnVehicleDetachTrailer
forward OnVehicleDetachTrailer(vehicleid, trailerid);
#endif
#if defined OnPlayerToggleControllable
forward OnPlayerToggleControllable(playerid, controllable);
#endif

#if defined OnPlayerEnterArea
forward OnPlayerEnterArea(playerid,areaid);
#endif
#if defined OnPlayerLeaveArea
forward OnPlayerLeaveArea(playerid,areaid);
#endif


public OnVehicleSpawn(vehicleid)
{
	if(Vehicles[vehicleid][Respawn]>=INF_INT && Vehicles[vehicleid][Static]==-1)
	{
		DestroyVehicle2(vehicleid);
	}
	else
	{
		SetVehicleParamsForAll(vehicleid,0,0);
		#if defined OnVehicleSpawn2
		OnVehicleSpawn2(vehicleid,0);
		#endif
	}
	return 1;
}