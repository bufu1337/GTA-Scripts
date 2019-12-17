#include <a_samp>


new Text:Textdraw13[MAX_PLAYERS];
new Text:Textdraw14[MAX_PLAYERS];
new Text:Textdraw15[MAX_PLAYERS];
new Text:Textdraw16[MAX_PLAYERS];
new IsCheckingSpeed[MAX_PLAYERS];

forward Float:GetDistanceBetweenPlayers(p1,p2);

new VehNames[212][] =
{
   "Landstalker", "Bravura",   "Buffalo",   "Linerunner",   "Pereniel",   "Sentinel",   "Dumper",   "Firetruck",   "Trashmaster",   "Stretch",
   "Manana",   "Infernus",   "Voodoo",   "Pony",   "Mule",   "Cheetah",   "Ambulance",   "Leviathan",   "Moonbeam",   "Esperanto",   "Taxi",
   "Washington",   "Bobcat",   "Mr Whoopee",   "BF Injection",   "Hunter",   "Premier",   "Enforcer",   "Securicar",   "Banshee",   "Predator",
   "Bus",   "Rhino",   "Barracks",   "Hotknife",   "Trailer",   "Previon",   "Coach",   "Cabbie",   "Stallion",   "Rumpo",   "RC Bandit",  "Romero",
   "Packer",   "Monster",   "Admiral",   "Squalo",   "Seasparrow",   "Pizzaboy",   "Tram",   "Trailer",   "Turismo",   "Speeder",   "Reefer",   "Tropic",   "Flatbed",
   "Yankee",   "Caddy",   "Solair",   "Berkley's RC Van",   "Skimmer",   "PCJ-600",   "Faggio",   "Freeway",   "RC Baron",   "RC Raider",
   "Glendale",   "Oceanic",   "Sanchez",   "Sparrow",   "Patriot",   "Quad",   "Coastguard",   "Dinghy",   "Hermes",   "Sabre",   "Rustler",
   "ZR3 50",   "Walton",   "Regina",   "Comet",   "BMX",   "Burrito",   "Camper",   "Marquis",   "Baggage",   "Dozer",   "Maverick",   "News Chopper",
   "Rancher",   "FBI Rancher",   "Virgo",   "Greenwood",   "Jetmax",   "Hotring",   "Sandking",   "Blista Compact",   "Police Maverick",
   "Boxville",   "Benson",   "Mesa",   "RC Goblin",   "Hotring Racer",   "Hotring Racer",   "Bloodring Banger",   "Rancher",   "Super GT",
   "Elegant",   "Journey",   "Bike",   "Mountain Bike",   "Beagle",   "Cropdust",   "Stunt",   "Tanker",   "RoadTrain",   "Nebula",   "Majestic",
   "Buccaneer",   "Shamal",   "Hydra",   "FCR-900",   "NRG-500",   "HPV1000",   "Cement Truck",   "Tow Truck",   "Fortune",   "Cadrona",   "FBI Truck",
   "Willard",   "Forklift",   "Tractor",   "Combine",   "Feltzer",   "Remington",   "Slamvan",   "Blade",   "Freight",   "Streak",   "Vortex",   "Vincent",
   "Bullet",   "Clover",   "Sadler",   "Firetruck",   "Hustler",   "Intruder",   "Primo",   "Cargobob",   "Tampa",   "Sunrise",   "Merit",   "Utility",
   "Nevada",   "Yosemite",   "Windsor",   "Monster",   "Monster",   "Uranus",   "Jester",   "Sultan",   "Stratum",   "Elegy",   "Raindance",   "RC Tiger",
   "Flash",   "Tahoma",   "Savanna",   "Bandito",   "Freight",   "Trailer",   "Kart",   "Mower",   "Duneride",   "Sweeper",   "Broadway",
   "Tornado",   "AT-400",   "DFT-30",   "Huntley",   "Stafford",   "BF-400",   "Newsvan",   "Tug",   "Trailer",   "Emperor",   "Wayfarer",
   "Euros",   "Hotdog",   "Club",   "Trailer",   "Trailer",   "Andromada",   "Dodo",   "RC Cam",   "Launch",   "Police Car (LSPD)",   "Police Car (SFPD)",
   "Police Car (LVPD)",   "Police Ranger",   "Picador",   "S.W.A.T. Van",   "Alpha",   "Phoenix",   "Glendale",   "Sadler",   "Luggage Trailer",
   "Luggage Trailer",   "Stair Trailer",   "Boxville",   "Farm Plow",   "Utility Trailer"
};

public OnFilterScriptInit()
{

	return 1;
}

public OnFilterScriptExit()
{

	return 1;
}

public OnPlayerConnect(playerid)
{
	//PD Camera
Textdraw13[playerid] = TextDrawCreate(18.000000, 109.000000, "~n~~n~~n~~n~");
TextDrawBackgroundColor(Textdraw13[playerid], -16711681);
TextDrawFont(Textdraw13[playerid], 1);
TextDrawLetterSize(Textdraw13[playerid], 0.500000, 1.000000);
TextDrawColor(Textdraw13[playerid], -1);
TextDrawSetOutline(Textdraw13[playerid], 1);
TextDrawSetProportional(Textdraw13[playerid], 1);
TextDrawUseBox(Textdraw13[playerid], 1);
TextDrawBoxColor(Textdraw13[playerid], 255);
TextDrawTextSize(Textdraw13[playerid], 171.000000, -10.000000);

Textdraw14[playerid] = TextDrawCreate(19.000000, 108.000000, "Police Speed Camera");
TextDrawBackgroundColor(Textdraw14[playerid], 65535);
TextDrawFont(Textdraw14[playerid], 1);
TextDrawLetterSize(Textdraw14[playerid], 0.420000, 1.000000);
TextDrawColor(Textdraw14[playerid], 16777215);
TextDrawSetOutline(Textdraw14[playerid], 1);
TextDrawSetProportional(Textdraw14[playerid], 1);

Textdraw15[playerid] = TextDrawCreate(18.000000, 119.000000, "Speed: 0km/h");
TextDrawBackgroundColor(Textdraw15[playerid], 255);
TextDrawFont(Textdraw15[playerid], 1);
TextDrawLetterSize(Textdraw15[playerid], 0.500000, 1.000000);
TextDrawColor(Textdraw15[playerid], -1);
TextDrawSetOutline(Textdraw15[playerid], 0);
TextDrawSetProportional(Textdraw15[playerid], 1);
TextDrawSetShadow(Textdraw15[playerid], 1);

Textdraw16[playerid] = TextDrawCreate(18.000000, 130.000000, "Vehicle: Unknown");
TextDrawBackgroundColor(Textdraw16[playerid], 255);
TextDrawFont(Textdraw16[playerid], 1);
TextDrawLetterSize(Textdraw16[playerid], 0.500000, 1.000000);
TextDrawColor(Textdraw16[playerid], -1);
TextDrawSetOutline(Textdraw16[playerid], 0);
TextDrawSetProportional(Textdraw16[playerid], 1);
TextDrawSetShadow(Textdraw16[playerid], 1);
return 1;
}

public OnPlayerDisconnect(playerid)
{

	return 1;
}

public OnPlayerDeath(playerid)
{

	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp(cmdtext, "/speedcamera", true) == 0)
	{
	    if(IsCheckingSpeed[playerid] == 0) {
	        GivePlayerWeapon(playerid, 43, 100);
    	    IsCheckingSpeed[playerid] = 1;
    	    TextDrawShowForPlayer(playerid, Textdraw13[playerid]);
        	TextDrawShowForPlayer(playerid, Textdraw14[playerid]);
        	TextDrawShowForPlayer(playerid, Textdraw15[playerid]);
        	TextDrawShowForPlayer(playerid, Textdraw16[playerid]);
        	} else {
	        IsCheckingSpeed[playerid] = 0;
	        RemovePlayerWeapon(playerid, 43);
        	TextDrawHideForPlayer(playerid, Textdraw13[playerid]);
        	TextDrawHideForPlayer(playerid, Textdraw14[playerid]);
        	TextDrawHideForPlayer(playerid, Textdraw15[playerid]);
    	    TextDrawHideForPlayer(playerid, Textdraw16[playerid]);
	    }
    	return 1;
	}
    return 0;
}

public OnPlayerSpawn(playerid)
{

	return 1;
}

forward GetClosestPlayer(p1);
public GetClosestPlayer(p1)
{
	new x,Float:dis,Float:dis2,player;
	player = -1;
	dis = 99999.99;
	for (x=0;x<MAX_PLAYERS;x++)
	{
		if(IsPlayerConnected(x))
		{
			if(x != p1)
			{
				dis2 = GetDistanceBetweenPlayers(x,p1);
				if(dis2 < dis && dis2 != -1.00)
				{
					dis = dis2;
					player = x;
				}
			}
		}
	}
	return player;
}
stock RemovePlayerWeapon(playerid, weaponid)
{
  new plyWeapons[12];
  new plyAmmo[12];
  for(new slot = 0; slot != 12; slot++)
  {
    new wep, ammos;
    GetPlayerWeaponData(playerid, slot, wep, ammos);
    if(wep != weaponid)
    {
      GetPlayerWeaponData(playerid, slot, plyWeapons[slot], plyAmmo[slot]);
    }
  }
  ResetPlayerWeapons(playerid);
  for(new slot = 0; slot != 12; slot++)
  {
    GivePlayerWeapon(playerid, plyWeapons[slot], plyAmmo[slot]);
  }
}
public Float:GetDistanceBetweenPlayers(p1,p2)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	if(!IsPlayerConnected(p1) || !IsPlayerConnected(p2))
	{
		return -1.00;
	}
	GetPlayerPos(p1,x1,y1,z1);
	GetPlayerPos(p2,x2,y2,z2);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}
stock IsPlayerAiming(playerid, aimid)
{
    // Not my function, can't remember who made it though.
    new Float:X1, Float:Y1, Float:Z1, Float:X2, Float:Y2, Float:Z2;
    GetPlayerPos(playerid, X1, Y1, Z1);
    GetPlayerPos(aimid, X2, Y2, Z2);
    new Float:Distance = floatsqroot(floatpower(floatabs(X1-X2), 2) + floatpower(floatabs(Y1-Y2), 2));
    if(Distance < 100)
    {
        new Float:A;
        GetPlayerFacingAngle(playerid, A);
        X1 += (Distance * floatsin(-A, degrees));
        Y1 += (Distance * floatcos(-A, degrees));
        Distance = floatsqroot(floatpower(floatabs(X1-X2), 2) + floatpower(floatabs(Y1-Y2), 2));
        if(Distance < 0.5)
        {
          return true;
        }
    }
    return false;
}
public OnPlayerUpdate(playerid)
{
  	if(IsCheckingSpeed[playerid] == 1  && GetPlayerWeapon(playerid) == 43)
  	{
    for(new i = 0; i < GetMaxPlayers(); i++)
    {
  		    new id = GetClosestPlayer(playerid);
  		    new v = GetPlayerVehicleID(id);
			new
		    Float: vPos[3],
		    Float: Speed,
		    string[128];
     	    if(GetDistanceBetweenPlayers(playerid, id) < 40) {
     	    if(IsPlayerAiming(playerid, id)) {
			GetVehicleVelocity(GetPlayerVehicleID(id), vPos[0], vPos[1], vPos[2]);
			Speed = floatmul(floatsqroot(floatadd(floatpower(vPos[0], 2), floatadd(floatpower(vPos[1], 2), floatpower(vPos[2], 2)))), 200);
			format(string, sizeof(string), "Speed: %0.0fkm/h", Speed), TextDrawSetString(Textdraw15[playerid], string);
			format(string, sizeof(string), "Vehicle: %s", VehNames[GetVehicleModel(v)-400]), TextDrawSetString(Textdraw16[playerid], string);
			}
		}
    }
	}
	return 1;
}