//Useful Functions:

#define MAX_STRING 255
#define MAX_GTASAVEHICLES   212
#define VTYPE_CAR 1
#define VTYPE_HEAVY 2
#define VTYPE_BIKE 3
#define VTYPE_AIR 4
#define VTYPE_SEA 5
#define MAX_PICKUPS 999

new vehicleNames[MAX_GTASAVEHICLES][] = {
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
   "Utility Trailer" //utiltr1
};
#if defined OnPlayerBuyWeapon
new Float:lvammu[3][3] = {
(295.7932,-80.8074,1001.5156),
(295.5800,-80.4444,1001.5156),
(290.1626,-109.7770,1001.5156)
};
new Float:ammu[7][3] = {
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
new Float:gamble1[12][3] = {
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
new Float:gamble2[3][3] = {
(2230.3799,1604.6863,1006.1860),
(2241.3516,1604.2601,1006.1797),
(1126.4874,-1.4898,1000.6797)
};
new Float:gamble3[20][3] = {
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
new Float:gamble4[18][3] = {
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
new Float:gamble5[2][3] = {
(1961.4709,1020.2551,992.4688),
(1961.5642,1015.8394,992.4688),
};
new Float:gamble6[5][3] = {
(2271.6360,1586.1650,1006.1797),
(2261.5183,1586.4304,1006.1797),
(2251.8772,1586.5632,1006.1860),
(1946.5306,986.7844,992.4688),
(1120.0988,-1.3969,1000.6908)
};
new Float:gamble7[1][3] = {
(1136.3954,-1.6494,1000.6797)
};
#endif

new Float:pi=3.14159265;
new VehicleModels[MAX_VEHICLES];
new VehicleAngles[MAX_VEHICLES];
new Skin[MAX_PLAYERS];
new VC;
new PC;
new pickupmodel[MAX_PICKUPS];
new pickuptype[MAX_PICKUPS];
new Float:pickupx[MAX_PICKUPS];
new Float:pickupy[MAX_PICKUPS];
new Float:pickupz[MAX_PICKUPS];
enum SavePlayerPosEnum
{
    Float:LastX,
    Float:LastY,
    Float:LastZ
}
new SavePlayerPos[MAX_PLAYERS][SavePlayerPosEnum];
new acc[MAX_PLAYERS];
new kmph[MAX_PLAYERS];
new preh[MAX_PLAYERS];
new moneyss[MAX_PLAYERS];
#if defined OnPlayerGamble
new bet[MAX_PLAYERS];
new betting[MAX_PLAYERS];
#endif
new pickuprespawn[MAX_PICKUPS];
new Float:vehiclex[MAX_VEHICLES];
new Float:vehicley[MAX_VEHICLES];
new Float:vehiclez[MAX_VEHICLES];
new Float:vehiclea[MAX_VEHICLES];
new dynamicv[MAX_VEHICLES];

forward Float:itan(Float:opp,Float:adj);

public encrypt(string[]) //By Alex "Y_Less" Cole (Based on code from Jeremy Cole)
{
	static key[] = "1345767";
	static size = sizeof(key) - 1;
	new retval[64];
	new j, k, sum, tmp[] = {0, 0};
	j = strlen(string);
	sum = j;
	k = ((j >> 4) + 1) << 4;
	for (new i = 0; i < k; i++)
	{
		if (i < j)
		{
			tmp[0] = string[i];
		}
		else
		{
			tmp[0] = ' ';
		}
		sum = ((sum + strfind(key, tmp) + 1) % size);
		retval[i] = key[sum];
	}
	return retval;
}

public left(source[], len) //By Alex "Y_Less" Cole (Edited by Sacky)
{
	new retval[MAX_STRING];
	strmid(retval, source, 0, len, MAX_STRING);
	return retval;
}

public right(source[], len) //By Alex "Y_Less" Cole
{
	new retval[MAX_STRING], srclen;
	srclen = strlen(source);
	strmid(retval, source, srclen - len, srclen, MAX_STRING);
	return retval;
}

public GetPlayerId(playername[]) //By Alex "Y_Less" Cole (Edited by Sacky)
{
new playername2[MAX_PLAYER_NAME];
for (new i = 0; i < MAX_PLAYERS; i++)
{
if (IsPlayerConnected(i))
{
GetPlayerName(i,playername2,sizeof(playername2));
if(strcmp(playername,playername2,true)==0){
return i;
}
}
}
return  INVALID_PLAYER_ID;
}

public parsecommand(cmdtext[], cmd[], text[], parcount) //By Alex "Y_Less" Cole
{
	new index = 0, length;
	length = strlen(cmdtext);
	while ((index < length) && (cmdtext[index] != ' '))
	{
		index++;
	}
	if (index == length)
	{
		strcat(cmd, cmdtext, 256);
		text[0] = EOS;
		return 0;
	}
	else
	{
	    strmid(cmd, cmdtext, 0, index, 256);
	    cmd[index] = EOS;
	    strmid(text, cmdtext, index + 1, length, 256);
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

public ReturnPlayerName(playerid) //By Alex "Y_Less" Cole
{
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pname, sizeof (pname));
	return pname;
}

public minrand(min, max) //By Alex "Y_Less" Cole
{
	return random(max - min) + min;
}

public Float:floatrand(Float:min, Float:max) //By Alex "Y_Less" Cole
{
	new imin;
	imin = floatround(min);
	return float(random((floatround(max) - imin) * 100) + (imin * 100)) / 100.0;
}

public IsPlayerInArea(playerid, Float:minx, Float:maxx, Float:miny, Float:maxy) //By Alex "Y_Less" Cole
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if (x > minx && x < maxx && y > miny && y < maxy) return 1;
	return 0;
}

#if defined gTeam
public GameTextForTeam(team, text[], time, style) //By Alex "Y_Less" Cole
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (gTeam[i] == team && IsPlayerConnected(i)) GameTextForPlayer(i, text, time, style);
	}
}

public SendClientMessageToTeam(team, color, text[]) //By Alex "Y_Less" Cole
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (gTeam[i] == team && IsPlayerConnected(i)) SendClientMessage(i, color, text);
	}
}
#endif

public RetStr(num) //By Alex "Y_Less" Cole
{
	new str[11];
	valstr(str, num);
	return str;
}

#if !defined SetPlayerMoney
public SetPlayerMoney(playerid,money) //By Jan "DracoBlue" Schütze (Edited by Sacky)
{
GivePlayerMoney(playerid,money-GetPlayerMoney(playerid));
}
#endif

public PlayerID(partofname[]) //By Jan "DracoBlue" Schütze
{
   new i;
   new playername[MAX_STRING];
   for (i=0;i<MAX_PLAYERS;i++) {
     if (IsPlayerConnected(i)) {
       GetPlayerName(i,playername,MAX_STRING);
       if (strcmp(playername,partofname,true)==0) {
         return i;
       }
     }
   }
    new correctsigns_userid=-1;
    new tmpuname[MAX_STRING];
    new hasmultiple=-1;
    for (i=0;i<MAX_PLAYERS;i++) {
        if (IsPlayerConnected(i)) {
          GetPlayerName(i,tmpuname,MAX_STRING);
	  if (strfind(tmpuname,partofname,true)==0) {
	    hasmultiple++;
	    correctsigns_userid=i;
          }
	  if (hasmultiple>0) {
            return -2;
          }
       }
    }
  return correctsigns_userid;
}

public ValidEmail(email[]) //By Jan "DracoBlue" Schütze
{
  new len=strlen(email);
  new cstate=0;
  new i;
  for(i=0;i<len;i++) {
    if ((cstate==0 || cstate==1) && (email[i]>='A' && email[i]<='Z') || (email[i]>='a' && email[i]<='z')  || (email[i]=='.')  || (email[i]=='-')  || (email[i]=='_'))
    {
    } else {
       if ((cstate==0) &&(email[i]=='@')) {
          cstate=1;
       } else {
          return false;
       }
    }
  }
  if (cstate<1) return false;
  if (len<6) return false;
  if ((email[len-3]=='.') || (email[len-4]=='.') || (email[len-5]=='.')) return true;
  return false;
}

public VehicleDriverID(vehicleid) //By Jan "DracoBlue" Schütze
{
  new i;
  for (i=0;i<MAX_PLAYERS;i++) {
     if ((IsPlayerConnected(i))&&(GetPlayerVehicleID(i)==vehicleid)&&(GetPlayerState(i)==2))  return i;
  }
  return -1;
}

public IsNumeric(const string[]) //By Mike
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
	    if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

public SendClientMessageToAdmins(colour,const str[]) //By Mike (Edited by Sacky)
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
	    if (IsPlayerConnected(i)) {
	        if (IsPlayerAdmin(i)) {
	            SendClientMessage(i, colour, str);
	        }
	    }
	}
}

public GetDistanceBetweenPlayers(playerid,playerid2) //By Slick (Edited by Sacky)
{
new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
new Float:tmpdis;
GetPlayerPos(playerid,x1,y1,z1);
GetPlayerPos(playerid2,x2,y2,z2);
tmpdis = floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
return floatround(tmpdis);
}

public GetClosestPlayer(playerid) //By Slick
{
new x,Float:dis,Float:dis2,player;
new pteam[MAX_PLAYERS];
player = -1;
dis = 99999.99;
for (x=0;x<MAX_PLAYERS;x++){
if (x != playerid){
dis2 = GetDistanceBetweenPlayers(x,playerid);
if (dis2 < dis && dis2 != -1.00 && pteam[x] == pteam[playerid]){
dis = dis2;
player = x;
}
}
}
return player;
}

#if !defined strtok
public strtok(const string[], &index) //By Slick
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
#endif

public Float:lengthdir_x(Float:length,Float:angle) //By Slick
{
return floatmul(floatcos(floatdiv(floatmul(angle,pi),180.00)),length);
}

public Float:lengthdir_y(Float:length,Float:angle) //By Slick
{
return floatmul(-floatsin(floatdiv(floatmul(angle,pi),180.00)),length);
}

public TwoWayRand(value) //By Allan
{
value=(random(value*2+1)-value);
return value;
}

public QuadraticRootCalc(Float:Xsq,Float:X,Float:num) //By Allan
{
new Float:Val1;
new Float:Val2;
Val1=floatsqroot(floatpower(X,2)*4*Xsq*num)/2*Xsq+X;
Val2=floatsqroot(floatpower(X,2)*4*Xsq*num)/2*Xsq-X;
return floatround(Val1*Val2);
}

public SendFormattedGameTextToPlayer(playerid, const msg[], time, style, define) //By Allan
{
	new wrap[256];
	format(wrap, sizeof(wrap), msg, define);
	GameTextForPlayer(playerid,wrap,time,style);
}

public SendFormattedGameTextToAll(const msg[], time, style, define) //By Allan
{
	new wrap[256];
	format(wrap, sizeof(wrap), msg, define);
	GameTextForAll(wrap,time,style);
}

public GivePlayerWeaponAlt(playerid, weaponid, ammo) //By Allan (Edited by Y_Less)
{
	if ((weaponid > 15 && weaponid < 22) || (weaponid > 32 && weaponid < 37) || (weaponid > 38 && weaponid < 41) || (weaponid > 42 && weaponid != 46))
	{
		weaponid = 0;
		print("Non-Working weapon class specified");
		SendClientMessage(playerid, 0x0000FFAA, "Non-Working weapon class specified");
	}
	GivePlayerWeapon(playerid, weaponid, ammo);
}

public GetDistanceToCar(playerid,carid) //By Darkrealm (Edited by Sacky)
{
	new Float:dis;
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	if (!IsPlayerConnected(playerid)) {
	return -1;
	}
	GetPlayerPos(playerid,x1,y1,z1);
	GetVehiclePos(carid,x2,y2,z2);
	dis = floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
	return floatround(dis);
}

public GetClosestCar(playerid) //By Darkrealm
{
	if (!IsPlayerConnected(playerid)) {
	    return -1;
	}
	new Float:prevdist = 100000.000;
	new prevcar;
	for (new carid = 0; carid < MAX_VEHICLES; carid++) {
                 new Float:dist = GetDistanceToCar(playerid,carid);
	    if ((dist < prevdist)) {
	         prevdist = dist;
	         prevcar = carid;
                 }
	}
	return prevcar;
}

public ConvertSeconds(time) //By El Presy
{
	new string[40];
	if(time < 60)
	    format(string, sizeof(string), "%d seconds", time);
 	else if(time == 60)
 	    string = "1 minute";
	else if(time > 60 && time < 3600){
	    new Float: minutes;
	    new seconds;
	    minutes = time / 60;
	    seconds = time % 60;
	    format(string, sizeof(string), "%.0f minutes and %d seconds", minutes, seconds);
	}else if(time == 3600)
	    string = "1 hour";
	else if(time > 3600){
	    new Float: hours;
	    new minutes_int;
	    new Float: minutes;
	    new seconds;
	    hours = time / 3600;
	    minutes_int = time % 3600;
	    minutes = minutes_int / 60;
	    seconds = minutes_int % 60;
	    format(string, sizeof(string), "%.0f hours, %.0f minutes and %d seconds", hours, minutes, seconds);
	}
	return string;
}

public wiper(playerid) //By Spectre
{
for (new a=1;a<=10;a++)
{
SendClientMessage(playerid,0xFFFFFFFF,"\n");
}
return 1;
}

#if !defined mktime
public mktime(hour,minute,second,day,month,year) //By mabako
{
 new timestamp;
 timestamp = second;
 timestamp += minute * 60;
 timestamp += hour * 3600;
 new days_of_month[12];
 if(((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) {
  days_of_month = {31,29,31,30,31,30,31,31,30,31,30,31};
 } else {
  days_of_month = {31,28,31,30,31,30,31,31,30,31,30,31};
 }
 new days_this_year = 0;
 days_this_year = day;
 if(month > 1) {
  for(new i=0; i<month-1;i++) {
   days_this_year += days_of_month[i];
  }
 }
 timestamp += days_this_year * 86400;
 for(new j=1970;j<year;j++) {
  timestamp += 31536000;
   if(((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) timestamp += 86400;
 }
 return timestamp;
}
#endif

public GetCurrentPosition(playerid) //By Sacky
{
new Float:x;
new Float:y;
new Float:z;
new Float:a;
new string[256];
if(IsPlayerConnected(playerid)){
GetPlayerPos(playerid,x,y,z);
GetPlayerFacingAngle(playerid,a);
format(string,sizeof(string),"x: %d, y: %d, z: %d, angle: %d",floatround(x),floatround(y),floatround(z),floatround(a));
return string;
}
return string;
}

public GetVehicleClass(vehicleid) //By Sacky
{
return VehicleModels[vehicleid];
}

public GetVehicles() //By Sacky
{
new Float:x;
new Float:y;
new Float:z;
new maxv;
for(new i=0;i<MAX_VEHICLES;i++){
GetVehiclePos(i,x,y,z);
if(z != 0 && x!= 0 && y != 0){
maxv++;
}
}
return maxv;
}

public VehicleDriverName(vehicleid) //By Sacky
{
new playername[MAX_PLAYER_NAME];
for(new i=0;i<MAX_PLAYERS;i++){
if(IsPlayerConnected(i)){
if(IsPlayerInVehicle(i,vehicleid)){
GetPlayerName(i,playername,sizeof(playername));
return playername;
}
}
}
return playername;
}

public timeconvert_seconds(time) //By Sacky
{
new minutes;
new seconds;
new string[256];
if(time > 60){
minutes = floatround(time/60);
seconds = floatround(time - minutes*60);
format(string,sizeof(string),"~b~%d:%d",minutes,seconds);
}
else{
seconds = floatround(time);
format(string,sizeof(string),"~b~%d",seconds);
}
return string;
}


public IsPlayerInAnyInterior(playerid) //By Sacky
{
new Float:x;
new Float:y;
new Float:z;
if(IsPlayerConnected(playerid)){
GetPlayerPos(playerid,x,y,z);
if(z > 900 && !IsPlayerInAnyVehicle(playerid)){
return 1;
}
}
return 0;
}

public IsPlayerPassenger(playerid) //By Sacky
{
new playerstate;
playerstate = GetPlayerState(playerid);
if(playerstate == PLAYER_STATE_PASSENGER){
return 1;
}
return 0;
}

public IsPlayerDriver(playerid) //By Sacky
{
new playerstate;
playerstate = GetPlayerState(playerid);
if(playerstate == PLAYER_STATE_DRIVER){
return 1;
}
return 0;
}

public IsPlayerOnFoot(playerid) //By Sacky
{
new playerstate;
playerstate = GetPlayerState(playerid);
if(playerstate == PLAYER_STATE_ONFOOT){
return 1;
}
return 0;
}


public IsPlayerOnBike(playerid) //By Sacky
{
if(IsPlayerInAnyVehicle(playerid)){
new vehicleid = GetPlayerVehicleID(playerid);
new vehicleclass = GetVehicleClass(vehicleid);
switch(vehicleclass)
{
case 448:return 1;
case 461:return 1;
case 462:return 1;
case 463:return 1;
case 468:return 1;
case 521:return 1;
case 522:return 1;
case 523:return 1;
case 581:return 1;
case 586:return 1;
}
}
return 0;
}

public IsPlayerOnBicycle(playerid) //By Sacky
{
if(IsPlayerInAnyVehicle(playerid)){
new vehicleid = GetPlayerVehicleID(playerid);
new vehicleclass = GetVehicleClass(vehicleid);
switch(vehicleclass)
{
case 481:return 1;
case 509:return 1;
case 510:return 1;
}
}
return 0;
}

public IsPlayerInBoat(playerid) //By Sacky
{
if(IsPlayerInAnyVehicle(playerid)){
new vehicleid = GetPlayerVehicleID(playerid);
new vehicleclass = GetVehicleClass(vehicleid);
switch(vehicleclass)
{
case 430:return 1;
case 446:return 1;
case 452:return 1;
case 453:return 1;
case 454:return 1;
case 472:return 1;
case 473:return 1;
case 484:return 1;
case 493:return 1;
case 595:return 1;
}
}
return 0;
}

public IsPlayerInHelicopter(playerid) //By Sacky
{
if(IsPlayerInAnyVehicle(playerid)){
new vehicleid = GetPlayerVehicleID(playerid);
new vehicleclass = GetVehicleClass(vehicleid);
switch(vehicleclass)
{
case 417:return 1;
case 425:return 1;
case 447:return 1;
case 465:return 1;
case 469:return 1;
case 487:return 1;
case 488:return 1;
case 497:return 1;
case 501:return 1;
case 548:return 1;
case 563:return 1;
}
}
return 0;
}

public IsPlayerInMonsterTruck(playerid) //By Sacky
{
if(IsPlayerInAnyVehicle(playerid)){
new vehicleid = GetPlayerVehicleID(playerid);
new vehicleclass = GetVehicleClass(vehicleid);
switch(vehicleclass)
{
case 406:return 1;
case 444:return 1;
case 556:return 1;
case 557:return 1;
case 573:return 1;
}
}
return 0;
}

public IsPlayerInPlane(playerid) //By Sacky
{
if(IsPlayerInAnyVehicle(playerid)){
new vehicleid = GetPlayerVehicleID(playerid);
new vehicleclass = GetVehicleClass(vehicleid);
switch(vehicleclass)
{
case 460:return 1;
case 464:return 1;
case 476:return 1;
case 511:return 1;
case 512:return 1;
case 513:return 1;
case 519:return 1;
case 520:return 1;
case 539:return 1;
case 553:return 1;
case 577:return 1;
case 592:return 1;
case 593:return 1;
}
}
return 0;
}

public IsPlayerInQuad(playerid) //By Sacky
{
if(IsPlayerInAnyVehicle(playerid)){
new vehicleid = GetPlayerVehicleID(playerid);
new vehicleclass = GetVehicleClass(vehicleid);
switch(vehicleclass)
{
case 471:return 1;
}
}
return 0;
}

public IsPlayerInCar(playerid) //By Sacky
{
if(IsPlayerInAnyVehicle(playerid)){
new vehicleid = GetPlayerVehicleID(playerid);
new vehicleclass = GetVehicleClass(vehicleid);
switch(vehicleclass)
{
case 448:return 0;
case 461:return 0;
case 462:return 0;
case 463:return 0;
case 468:return 0;
case 521:return 0;
case 522:return 0;
case 523:return 0;
case 581:return 0;
case 586:return 0;
case 481:return 0;
case 509:return 0;
case 510:return 0;
case 430:return 0;
case 446:return 0;
case 452:return 0;
case 453:return 0;
case 454:return 0;
case 472:return 0;
case 473:return 0;
case 484:return 0;
case 493:return 0;
case 595:return 0;
case 417:return 0;
case 425:return 0;
case 447:return 0;
case 465:return 0;
case 469:return 0;
case 487:return 0;
case 488:return 0;
case 497:return 0;
case 501:return 0;
case 548:return 0;
case 563:return 0;
case 406:return 0;
case 444:return 0;
case 556:return 0;
case 557:return 0;
case 573:return 0;
case 460:return 0;
case 464:return 0;
case 476:return 0;
case 511:return 0;
case 512:return 0;
case 513:return 0;
case 519:return 0;
case 520:return 0;
case 539:return 0;
case 553:return 0;
case 577:return 0;
case 592:return 0;
case 593:return 0;
case 471:return 0;
}
return 1;
}
return 0;
}

public GetVehicleName(vehicleid) //By Sacky
{
new vehicleclass = GetVehicleClass(vehicleid);
new tmp = vehicleclass - 400;
return vehicleNames[tmp];
}

#if defined Skin
public GetPlayerSkin(playerid) //By Sacky
{
if(IsPlayerConnected(playerid)){
return Skin[playerid];
}
return -1;
}
#endif

public IsPlayerInCircle(playerid,Float:x,Float:y,radius) //By Sacky
{
if(GetPlayerDistanceToPoint(playerid,x,y) < radius){
return 1;
}
return 0;
}

public GetPlayerDistanceToPoint(playerid,Float:x,Float:y) //By Sacky
{
new Float:x1,Float:y1,Float:z1;
new Float:tmpdis;
GetPlayerPos(playerid,x1,y1,z1);
tmpdis = floatsqroot(floatpower(floatabs(floatsub(x,x1)),2)+floatpower(floatabs(floatsub(y,y1)),2));
return floatround(tmpdis);
}

public IsPlayerInSphere(playerid,Float:x,Float:y,Float:z,radius) //By Sacky
{
if(GetPlayerDistanceToPointEx(playerid,x,y,z) < radius){
return 1;
}
return 0;
}

public GetPlayerDistanceToPointEx(playerid,Float:x,Float:y,Float:z) //By Sacky
{
new Float:x1,Float:y1,Float:z1;
new Float:tmpdis;
GetPlayerPos(playerid,x1,y1,z1);
tmpdis = floatsqroot(floatpower(floatabs(floatsub(x,x1)),2)+floatpower(floatabs(floatsub(y,y1)),2)+floatpower(floatabs(floatsub(z,z1)),2));
return floatround(tmpdis);
}

public TakePlayerMoney(playerid,money) //By Sacky
{
GivePlayerMoney(playerid,0-money);
}

public AddStaticPickup2(model,type,Float:X,Float:Y,Float:Z) //By Sacky
{
PC++;
pickupmodel[PC] = model;
pickuptype[PC] = type;
pickupx[PC] = X;
pickupy[PC] = Y;
pickupz[PC] = Z;
AddStaticPickup(model,type,Float:X,Float:Y,Float:Z);
}

public AddStaticVehicleEx2(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2,respawn_delay) //By Sacky
{
if(VC<MAX_VEHICLES){
VC++;
VehicleModels[VC] = modelid;
VehicleAngles[VC] = floatround(z_angle);
AddStaticVehicleEx(modelid, spawn_x, spawn_y, spawn_z, z_angle, color1, color2,respawn_delay);
}
}

public GetPlayerSpeed(playerid) //By Sacky
{
return kmph[playerid];
}

public GetPlayerAcceleration(playerid) //By Sacky
{
return acc[playerid];
}

public IsVehicleConnected(vehicleid) //By Sacky
{
if(vehicleid < GetVehicles()){
return 1;
}
return 0;
}

public IsPickupConnected(pickupid) //By Sacky
{
if(pickupid < PC){
return 1;
}
return 0;
}

public GetPickups() //By Sacky
{
return PC;
}

public GetPointDistanceToPoint(Float:x,Float:y,Float:x2,Float:y2) //By Sacky
{
new Float:tmpdis;
tmpdis = floatsqroot(floatpower(floatabs(floatsub(x,x2)),2)+floatpower(floatabs(floatsub(y,y2)),2));
return floatround(tmpdis);
}

public GetPointDistanceToPointEx(Float:x,Float:y,Float:z,Float:x2,Float:y2,Float:z2) //By Sacky
{
new Float:tmpdis;
tmpdis = floatsqroot(floatpower(floatabs(floatsub(x,x2)),2)+floatpower(floatabs(floatsub(y,y2)),2)+floatpower(floatabs(floatsub(z,z2)),2));
return floatround(tmpdis);
}

public GetVehicleZAngle(vehicleid) //By Sacky
{
new Float:x;
new Float:y;
new Float:z;
if(IsVehicleInUse(vehicleid)){
new vdid = VehicleDriverID(vehicleid);
GetPlayerPos(vdid,x,y,z);
new Float:cx = SavePlayerPos[vdid][LastX];
new Float:cy = y;
new adj = GetPointDistanceToPoint(SavePlayerPos[vdid][LastX],SavePlayerPos[vdid][LastY],cx,cy);
new opp = GetPointDistanceToPoint(x,y,cx,cy);
new Float:rad = itan(opp,adj);
new ang = RadiansToDegrees(rad);
return ang;
}
return VehicleAngles[vehicleid];
}

public Float:isin(Float:opp,Float:hyp) //By Sacky
{
new Float:x = opp/hyp;
if(x < 1 && x > -1){
new Float:ret = x+(1.0/2.0)*(floatpower(x,3)/3.0)+((1.0*3.0)/(2.0*4.0))*(floatpower(x,5)/5.0)+((1.0*3.0*5.0)/(2.0*4.0*6.0))*(floatpower(x,7)/7.0)+((1.0*3.0*5.0*7.0)/(2.0*4.0*6.0*8.0))*(floatpower(x,9)/9.0)+((1.0*3.0*5.0*7.0*9.0)/(2.0*4.0*6.0*8.0*10.0))*(floatpower(x,11)/11.0);
return ret;
}
return -1.00;
}

public Float:icos(Float:adj,Float:hyp) //By Sacky
{
new Float:x = adj/hyp;
if(x < 1 && x > -1){
new Float:ret = (pi/2.0)-isin(adj,hyp);
return ret;
}
return -1.00;
}

public Float:itan(Float:opp,Float:adj) //By Sacky
{
new Float:x = opp/adj;
if(x < 1 && x > -1){
new Float:ret = x-(1.0/3.0)*floatpower(x,3)+(1.0/5.0)*floatpower(x,5)-(1.0/7.0)*floatpower(x,7)+(1.0/9.0)*floatpower(x,9)-(1.0/11.0)*floatpower(x,11)+(1.0/13.0)*floatpower(x,13)-(1.0/15.0)*floatpower(x,15)+(1.0/17.0)*floatpower(x,17)-(1.0/19.0)*floatpower(x,19)+(1.0/21.0)*floatpower(x,21)-(1.0/23.0)*floatpower(x,23)+(1.0/25.0)*floatpower(x,25);
return ret;
}
return -1.00;
}

public RadiansToDegrees(Float:radian) //By Sacky
{
new Float:tmp = floatdiv(floatmul(float(radian),pi),float(180));
return floatround(tmp);
}

public Float:DegreesToRadians(Float:degrees) //By Sacky
{
new Float:multiply = floatmul(float(degrees),float(180));
new Float:tmp = floatdiv(multiply,pi);
return tmp;
}

public IsVehicleInUse(vehicleid) //By Sacky
{
new vdid = VehicleDriverID(vehicleid);
if(vdid != -1){
return 1;
}
return 0;
}

public PlayerPlaySoundEx(playerid,soundid) //By Sacky
{
new Float:x;
new Float:y;
new Float:z;
GetPlayerPos(playerid,x,y,z);
PlayerPlaySound(playerid,soundid,x,y,z);
}

public SetVehicleRespawnPos(vehicleid,Float:x,Float:y,Float:z,Float:angle)
{
vehiclex[vehicleid] = x;
vehicley[vehicleid] = y;
vehiclez[vehicleid] = z;
vehiclea[vehicleid] = angle;
dynamicv[vehicleid] = 1;
}

public ResetVehicleSpawnPos(vehicleid)
{
dynamicv[vehicleid] = 0;
}

public AddStaticVehicle2(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2) //By Boss
{
if(VC<MAX_VEHICLES){
VC++;
VehicleModels[VC] = modelid;
VehicleAngles[VC] = floatround(z_angle);
AddStaticVehicle(modelid, spawn_x, spawn_y, spawn_z, z_angle, color1, color2);
}
}

public AddStaticVehicleLine(Modelid, Float:Start[2], Float:Rate[2], Float:Z, Float:Z_Angle, MaxAmount) //Toxic
{
	new Float:x = Start[0], Float:y = Start[1];
	new Float:xRate = Start[0] - Rate[0];
	new Float:yRate = Start[1] - Rate[1];
	for(new Amount = 0;Amount < MaxAmount;Amount++){
	AddStaticVehicle2(Modelid, x, y, Z, Z_Angle, -1, -1);
	x -= xRate;
	y -= yRate;
	}
	return 1;
}

#if defined gTeam
public SetTeamPos(team, x, y, z) //dyraXon
{
for (new i = 0; i < MAX_PLAYERS; i++)
{
if (gTeam[i] == team && IsPlayerConnected(i)) 
{
SetPlayerPos(i, x, y, z);
}
}
}

public IsTeamInArea(team, Float:minx, Float:maxx, Float:miny, Float:maxy) //dyraXon
{
for (new i = 0; i < MAX_PLAYERS; i++)
{
if (gTeam[i] == team && IsPlayerConnected(i)) 
{
new Float:x, Float:y, Float:z;
GetPlayerPos(i, x, y, z);
if (x > minx && x < maxx && y > miny && y < maxy) return 1;
}
}
return 0;
}

public KickTeam(team) //dyraXon
{
for (new i = 0; i < MAX_PLAYERS; i++)
{
if (gTeam[i] == team && IsPlayerConnected(i)) 
{
Kick(i);
}
}
}

public BanTeam(team) //dyraXon
{
for (new i = 0; i < MAX_PLAYERS; i++)
{
if (gTeam[i] == team && IsPlayerConnected(i)) 
{
Ban(i);
}
}
}
#endif

public GetVehicleType(vid) //By YellowBlood
{
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

public IsPlayerInCube(playerid, xmin, ymin, zmin, xmax, ymax, zmax) //By 50p
{
   new Float:x, Float:y, Float:z;
   GetPlayerPos(playerid, x, y, z);
   if( x > xmin && y > ymin && z > zmin && x < xmax && y < ymax && z < zmax) return 1;
   return 0;
}

public GetPlayers() //By rapidZ
{
new i;
new player;
player = 0;
for (i=0;i<MAX_PLAYERS;i++){
if(IsPlayerConnected(i)){
player++;
}
}
return player;
}

public str_replace(search[], replace[], source[]) //By Tratulla
{
	new newnick[256];
	new newlen;
	for (new i; i < strlen(source); i++)
	{
	    if (strlen(search) > 1 && i != (strlen(source) - 1))
	    {
	        new matched = 1;
	        new start = i;
	        for (new s; s < strlen(search) && matched == 1; s++)
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
	            for (;start <= i; start++)
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

public GameTextCheck(const string[]) //By Kamazy
{
for (new i = 0; i < strlen(string); i++)
	{
    if ((string[i] == 126) && (string[i-1] == 126)
	|| (string[i] == ' ') && (string[i-1] == '~') && (string[i-2] == ' ')
	|| (string[i] == '~') && (string[i+2] != '~') && (string[i-2] != '~')
	|| (string[i] == '~') && (string[i+2] == '~') && (string[i-2] == '~')) return 1;
    }
return 0;
}

public SetPlayerPosEx(playerid,Float:X,Float:Y,Float:Z,Float:Ang,Int) //By Kamazy
{
SetPlayerInterior(playerid,Int);
SetPlayerFacingAngle(playerid,Ang);
SetPlayerPos(playerid,X,Y,Z);
SetCameraBehindPlayer(playerid);
}

public IsPlayerInRange(playerid, Float: Range, Float: Z_Range, Float:tar_x, Float:tar_y, Float:tar_z) //By Simon
{
new Float:player_x, Float:player_y, Float:player_z;
GetPlayerPos(playerid, player_x, player_y, player_z);
if(player_x - tar_x <= Range && player_x - tar_x >= (0.0 - Range) && player_y - tar_y <= Range && player_y - tar_y >= (0.0 - Range) && player_z - tar_z <= Z_Range && player_z - tar_z >= (0.0 - Z_Range))
{ 
return 1;
}
return 0;
}

public GivePlayerWeaponEx( playerid, ... ) //By Peter
{
    new Count = numargs();
    for( new i = 1; i < Count; i += 2 )
    {
        new WeaponID = getarg( i );
        new Ammo = getarg( ( i + 1 ) );
        if( WeaponID > 0 && WeaponID < 47 )
        {
            GivePlayerWeaponAlt( playerid, WeaponID, Ammo );
        }
    }
}

public SendClientMessageToAllOthers(playerid, color, const message[]) //By yom
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if ((IsPlayerConnected(i)) && (i != playerid))
        {
            SendClientMessage(i, color, message);
        }
    }
}

public GameTextForAllOthers(playerid, const string[], time, style) //By yom
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if ((IsPlayerConnected(i)) && (i != playerid))
        {
            GameTextForPlayer(i, string, time, style);
        }
    }
}

public SetPlayerColourAlpha(playerid, alpha) //By Betamaster
{
	new r, g, b, a;
	HexToRGBA(GetPlayerColor(playerid), r, g, b, a);
	SetPlayerColor(playerid, RGBAToHex(r, g, b, alpha));
}

public RGBAToHex(r, g, b, a) //By Betamaster
{
	return (r<<24 | g<<16 | b<<8 | a);
}

public HexToRGBA(colour, &r, &g, &b, &a) //By Betamaster
{
	r = (colour >> 24) & 0xFF;
	g = (colour >> 16) & 0xFF;
	b = (colour >> 8) & 0xFF;
	a = colour & 0xFF;
}

public IsPlayerInAreaEx(playerid, Float:...) //By kool
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
                        Lines++;
        }
        if(Lines%2 == 1)
                return 1;
        return 0;
}

#if defined gTeam
public SetTeamScore(team, score) //By Hellomy
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (gTeam[i] == team && IsPlayerConnected(i)) SetPlayerScore(i, score);
	}
}

public GiveTeamMoney(team, amount) //By Hellomy
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (gTeam[i] == team && IsPlayerConnected(i)) GivePlayerMoney(i, amount);
	}
}
#endif

//>>By Unknown

public Wait(time)
{
	new stamp = tickcount();
    while (tickcount() - stamp < time){}
    return 1;
}

public strrest(const string[], index)
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

/*Credits
Alex "Y_Less" Cole
Jan "DracoBlue" Schütze
Mike
Slick
Allan
SidViciousII
Darkrealm
El Presy
Spectre
mabako
Sacky
Boss
Toxic
dyraXon
yellowblood
50p
rapidZ
Tratulla
Kamazy
Simon
yom
Betamaster
Peter
kool
Hellomy
*/

//Useful Callbacks:

public ufctimer()
{
PickupTimer();
ShotTimer();
SpeedTimer();
VehicleSpawn();
}

public PickupTimer()
{
for(new i=0;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i)){
CheckPickup(i);
}
}
}

public CheckPickup(playerid)
{
for(new i=0;i<PC;i++){
if(IsPlayerInSphere(playerid,pickupx[i],pickupy[i],pickupz[i],1)){
#if defined OnPlayerPickupItem
OnPlayerPickupItem(playerid,i,pickupmodel[i],pickuptype[i]);
if(pickuptype[i] == 2){
pickuprespawn[i] = 180;
}
#endif
}
if(pickuprespawn[i] == 0){
#if defined OnPlayerGetShot
OnPickupRespawn(i,pickupmodel[i]);
#endif
pickuprespawn[i] = 999;
}
if(pickuprespawn[i] != 999){
new tmp;
tmp = pickuprespawn[i];
pickuprespawn[i] = tmp-1;
}
}
}

public ShotTimer()
{
if(GetPlayers() != 1 || GetPlayers() != 0){
for(new i=0;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i)){
CheckShot(i);
}
}
}
}

public CheckShot(playerid)
{
new Float:x;
new Float:y;
new Float:z;
new cid;
new dis;
new Float:h;
new rh;
GetPlayerPos(playerid,x,y,z);
GetPlayerHealth(playerid,h);
rh = floatround(h);
if(preh[playerid]-rh > 5){
cid = GetClosestPlayer(playerid);
dis = GetDistanceBetweenPlayers(playerid,cid);
if(dis < 100 && z >= floatround(SavePlayerPos[playerid][LastZ])){
if(IsPlayerInAnyVehicle(cid)){
if(GetPlayerSpeed(cid) < 75){
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

public SpeedTimer()
{
    new Float:x,Float:y,Float:z;
    new Float:distance,value;
    for(new i=0; i<GetMaxPlayers(); i++)
    {
        if(IsPlayerConnected(i))
        {
            GetPlayerPos(i, x, y, z);
            distance=floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)
            +floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)
            +floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
            value = floatround(distance * 3600);
            acc[i] = kmph[i]*1000 - floatround(value);
            SavePlayerPos[i][LastX] = x;
            SavePlayerPos[i][LastY] = y;
            SavePlayerPos[i][LastZ] = z;
            kmph[i] = floatround(value/1000);
        }
    }
}

public AreaTimer()
{
for(new i=0;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i)){
CheckArea(i);
}
}
}

public CheckArea(playerid)
{
new moneys = GetPlayerMoney(playerid);
new tmpmon = moneyss[playerid] - moneys;
new tmpmon2 = moneys - moneyss[playerid];
#if defined OnPlayerGamble
new nb;
#endif
if(tmpmon > 0){
#if defined OnPlayerBuyWeapon
for(new i=0;i<sizeof(lvammu);i++){
if(IsPlayerInSphere(playerid,lvammu[i][1],lvammu[i][2],lvammu[i][3],1)){
switch (tmpmon)
{
case 200:OnPlayerBuyWeapon(playerid,22,200);
case 240:OnPlayerBuyWeapon(playerid,0,240);
case 300:OnPlayerBuyWeapon(playerid,32,300);
case 500:OnPlayerBuyWeapon(playerid,28,500);
case 600:{OnPlayerBuyWeapon(playerid,23,600);
OnPlayerBuyWeapon(playerid,25,0);}
case 800:OnPlayerBuyWeapon(playerid,26,800);
case 1200:{OnPlayerBuyWeapon(playerid,24,1200);
OnPlayerBuyWeapon(playerid,27,1200);}
case 2000:OnPlayerBuyWeapon(playerid,29,2000);
case 3500:OnPlayerBuyWeapon(playerid,30,3500);
case 4500:OnPlayerBuyWeapon(playerid,31,4500);
}
}
}
for(new i=0;i<sizeof(ammu);i++){
if(IsPlayerInSphere(playerid,ammu[i][1],ammu[i][2],ammu[i][3],1)){
switch (tmpmon)
{
case 200:{OnPlayerBuyWeapon(playerid,22,200);
OnPlayerBuyWeapoon(playerid,0,0);}
case 300:OnPlayerBuyWeapon(playerid,32,300);
case 500:OnPlayerBuyWeapon(playerid,28,500);
case 600:{OnPlayerBuyWeapon(playerid,23,600);
OnPlayerBuyWeapon(playerid,25,0);}
case 800:OnPlayerBuyWeapon(playerid,26,800);
case 1200:{OnPlayerBuyWeapon(playerid,24,1200);
OnPlayerBuyWeapon(playerid,27,1200);}
case 2000:OnPlayerBuyWeapon(playerid,29,2000);
case 3500:OnPlayerBuyWeapon(playerid,30,3500);
case 4500:OnPlayerBuyWeapon(playerid,31,4500);
}
}
}
#endif
#if defined OnPlayerBuyPizza
if(IsPlayerInSphere(playerid,374.0000,374.0000,374.0000,1)){
switch (tmpmon)
{
case 2:OnPlayerBuyPizza(playerid,2);
}
}
#endif
#if defined OnPlayerBuyChicken
if(IsPlayerInSphere(playerid,368.7890,-6.8570,1001.8516,1)){
switch (tmpmon)
{
case 2:OnPlayerBuyChicken(playerid,2);
}
}
#endif
#if defined OnPlayerBuyBurger
if(IsPlayerInSphere(playerid,375.5660,-68.2220,1001.5151,1)){
switch (tmpmon)
{
case 2:OnPlayerBuyChicken(playerid,2);
}
}
#endif
#if defined OnPlayerBuyDrink
if(tmpmon == 5){
OnPlayerBuyDrink(playerid,5);
}
#endif
#if defined OnPlayerGamble
if(betting[playerid] != 0){
if(bet[playerid] == 0){
bet[playerid] = tmpmon;
}
else{
OnPlayerGamble(playerid,betting[playerid],bet[playerid],0);
betting[playerid] = 0;
bet[playerid] = 0;
}
}
#endif
#if defined OnPlayerModCar
if(IsPlayerInSphere(playerid,617.5360,-1.9889,1000.6190,4) && IsPlayerInAnyVehicle(playerid)){
new vehicleid = GetPlayerVehicleID(playerid);
switch (tmpmon)
{
case 150:OnPlayerModCar(playerid,vehicleid,1,150);
case 200:OnPlayerModCar(playerid,vehicleid,2,200);
case 250:OnPlayerModCar(playerid,vehicleid,3,250);
case 300:OnPlayerModCar(playerid,vehicleid,4,300);
case 350:{OnPlayerModCar(playerid,vehicleid,5,350);
OnPlayerModCar(playerid,vehicleid,6,0);}
case 500:{OnPlayerModCar(playerid,vehicleid,7,500);
OnPlayerModCar(playerid,vehicleid,8,0);}
case 550:OnPlayerModCar(playerid,vehicleid,9,550);
case 620:OnPlayerModCar(playerid,vehicleid,10,620);
case 770:OnPlayerModCar(playerid,vehicleid,11,770);
case 820:OnPlayerModCar(playerid,vehicleid,12,820);
case 1000:{OnPlayerModCar(playerid,vehicleid,13,1000);
OnPlayerModCar(playerid,vehicleid,14,0);
OnPlayerModCar(playerid,vehicleid,15,0);}
case 1030:OnPlayerModCar(playerid,vehicleid,16,1030);
case 1140:OnPlayerModCar(playerid,vehicleid,17,1140);
case 1200:OnPlayerModCar(playerid,vehicleid,18,1200);
case 1230:OnPlayerModCar(playerid,vehicleid,19,1230);
case 1500:OnPlayerModCar(playerid,vehicleid,20,1500);
case 1560:OnPlayerModCar(playerid,vehicleid,21,1560);
}
}
#endif
}
if(tmpmon2 > 0){
#if defined OnPlayerGamble
if(betting != 0){
OnPlayerGamble(playerid,betting[playerid],bet[playerid],1);
betting[playerid] = 0;
bet[playerid] = 0;
}
#endif
}
#if defined OnPlayerGamble
for(new i=0;i<sizeof(gamble1);i++){
if(IsPlayerInSphere(playerid,gamble1[i][1],gamble1[i][2],gamble1[i][3],1){
betting[playerid] = 1;
nb++;
}
}
for(new i=0;i<sizeof(gamble2);i++){
if(IsPlayerInSphere(playerid,gamble2[i][1],gamble2[i][2],gamble2[i][3],1){
betting[playerid] = 2;
nb++;
}
}
for(new i=0;i<sizeof(gamble3);i++){
if(IsPlayerInSphere(playerid,gamble3[i][1],gamble3[i][2],gamble3[i][3],1){
betting[playerid] = 3;
nb++;
}
}
for(new i=0;i<sizeof(gamble4);i++){
if(IsPlayerInSphere(playerid,gamble4[i][1],gamble4[i][2],gamble4[i][3],1){
betting[playerid] = 4;
nb++;
}
}
for(new i=0;i<sizeof(gamble5);i++){
if(IsPlayerInSphere(playerid,gamble5[i][1],gamble5[i][2],gamble5[i][3],1){
betting[playerid] = 2;
nb++;
}
}
for(new i=0;i<sizeof(gamble6);i++){
if(IsPlayerInSphere(playerid,gamble6[i][1],gamble6[i][2],gamble6[i][3],1){
betting[playerid] = 5;
nb++;
}
}
for(new i=0;i<sizeof(gamble7);i++){
if(IsPlayerInSphere(playerid,gamble7[i][1],gamble7[i][2],gamble7[i][3],1){
betting[playerid] = 3;
nb++;
}
}
if(nb == 0){
betting[playerid] = 0;
bet[playerid] = 0;
}
#endif
moneyss[playerid] = moneys;
}

public VehicleSpawn()
{
#if defined OnVehicleSpawnEx
for(new i=0;i<GetVehicles();i++){
if(vehiclespawn[i] != 999){
if(vehiclespawn[i] == 0){
OnVehicleSpawnEx(vehicleid);
if(dynamicv[i] == 1){
DynamicSpawn(i);
}
}
else{
new tmp = vehiclespawn[i];
vehiclespawn[i] = tmp-1;
}
}
}
#endif
}

public DynamicSpawn(vehicleid)
{
new Float:x;
new Float:y;
new Float:z;
GetPlayerPos(0,x,y,z);
PutPlayerInVehicle(0,vehicleid,0);
SetVehiclePos(vehicleid,vehiclex[vehicleid],vehicley[vehicleid],vehiclez[vehicleid]);
SetVehicleZAngle(vehicleid,vehiclea[vehicleid]);
SetPlayerPos(0,x,y,z);
}