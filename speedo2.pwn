//-----0000----0----0--------00000---------0-------000000-----------------------
//-----0---0----0--0---------0----0-------0-0------0----------------------------
//-----0000------0-----------00000-------0---0-----00000------------------------
//-----0---0----0------------0-00-------0000000----0----------------------------
//-----0000----0-------------0---00----0-------0---0-----------------by R@f ©---
#include <a_samp>

#define SLOTS 200

enum SavePlayerPosEnum {
Float:LastX,
Float:LastY,
Float:LastZ
}

new SavePlayerPos[SLOTS][SavePlayerPosEnum];
new Text:Speedo[SLOTS];
new UpdateSeconds;

new CarName[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel",
	"Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
	"Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection",
	"Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
	"Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie",
	"Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral",
	"Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder",
	"Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van",
	"Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale",
	"Oceanic","Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy",
	"Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX",
	"Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper",
	"Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking",
	"Blista Compact", "Police Maverick", "Boxvillde", "Benson", "Mesa", "RC Goblin",
	"Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT",
	"Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt",
 	"Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra",
 	"FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune",
 	"Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer",
 	"Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent",
    "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo",
	"Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
	"Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratium",
	"Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper",
	"Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400",
	"News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
	"Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car",
 	"Police Car", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha",
 	"Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville",
 	"Tiller", "Utility Trailer"
};

forward UpdateSpeed();

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("----------R@f's speedo script---------");
	print("--------------------------------------\n");
	SetTimer("UpdateSpeed",1000, 1);
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

main()
{
}

public OnPlayerConnect(playerid)
{
	SendClientMessage(playerid,0x00FF00FF,"This server is running whit R@f's Speedo FilterScript");
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_ONFOOT)
	{
    TextDrawHideForPlayer(playerid, Speedo[playerid]);
	}
	return 1;
}

public UpdateSpeed()
{
	new Float:x,Float:y,Float:z;
	new Float:distance,value,string[256];
	new Float:health;
	for(new i=0; i<SLOTS; i++)
	{
		if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i))
		{
			TextDrawDestroy(Speedo[i]);
		}
	}

	for(new i=0; i<SLOTS; i++)
	{
		if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i))
		{
			GetPlayerPos(i, x, y, z);
			GetVehicleHealth(GetPlayerVehicleID(i), health);
			distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
			value = floatround(distance * 5000);
			if(UpdateSeconds > 1)
			{
				value = floatround(value / UpdateSeconds);
			}
			format(string,sizeof(string),"~g~Vehicle : ~w~%s ~n~~b~MPH : ~w~%d / ~b~KM/H : ~w~%d~n~~y~Altitude:~w~ %.1f ~n~~r~Vehicle Health:~w~ %.2f",CarName[GetVehicleModel(GetPlayerVehicleID(i))-400],floatround(value/1600),floatround(value/1000),z,health);
			Speedo[i] = TextDrawCreate(320.00, 380.00, string);
			TextDrawSetOutline(Speedo[i], 0);
			TextDrawFont(Speedo[i], 3);
			TextDrawSetProportional(Speedo[i], 2);
			TextDrawAlignment(Speedo[i], 2);
			TextDrawShowForPlayer (i, Speedo[i]);
		}
		SavePlayerPos[i][LastX] = x;
		SavePlayerPos[i][LastY] = y;
		SavePlayerPos[i][LastZ] = z;
	}
}
