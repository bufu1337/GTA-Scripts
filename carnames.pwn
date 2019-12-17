#include <a_samp>

#define VEHNAME_OFF 0
#define VEHNAME_REAL 2
#define VEHNAME_GAME 3

#define VEHNAME_STATECHANGE 6
#define VEHNAME_ENTERVEHICLE 7

#define VERSION 2.6

new Creds=0;
new NameValue[MAX_PLAYERS];
new NameDisplayType[MAX_PLAYERS];

stock ShowCredits(bool:toggle)
{
        if(toggle == true)
        {
            Creds=1;
        }
        else if(toggle == false)
        {
            Creds=0;
        }
}

stock ToggleVehicleNames(playerid, bool:toggle)
{
        if(toggle == true) NameValue[playerid] = GAME;
        if(toggle == false) NameValue[playerid] = OFF;
}

stock SetPlayerVehicleNamesType(playerid, type)
{
        NameValue[playerid] = type;
}

stock SetPlayerTextDisplay(playerid, onenter)
{
        NameDisplayType[playerid][playerid] = onenter;
}

stock ToggleVehicleNamesForAll(bool:toggle)
{
        if(toggle == true)
        {
            for(new playerid = 0; playerid < GetMaxPlayers(); playerid++)
            {
                        NameValue[playerid] = GAME;
                }
        }
        if(toggle == false)
        {
            for(new playerid = 0; playerid < GetMaxPlayers(); playerid++)
            {
                        NameValue[playerid] = VEHNAME_OFF;
                }
        }
}

public OnFilterScriptInit()
{
        if(Creds == 1)
        {
                print("‡~~~~~~~~~~~~[FS]~~~~~~~~~~~~‡");
                print(" Real Vehicle Names By Leopard");
                printf(" %d                    LOADED", VERSION);
                print("‡~~~~~~~~~~~~[FS]~~~~~~~~~~~~‡");
                return 1;
        }
        return 0;
}

public OnFilterScriptExit()
{
        if(Creds == 1)
        {
                print("‡~~~~~~~~~~~~[FS]~~~~~~~~~~~~‡");
                print(" Real Vehicle Names By Leopard");
                printf(" %d                  UNLOADED", VERSION);
                print("‡~~~~~~~~~~~~[FS]~~~~~~~~~~~~‡");
                return 1;
        }
        return 0;
}

new RealName[][] =
{
   "Jeep Wagoneer","Mercury Cougar","Camaro with Scoop","Big Rig","Jeep Grand Wagoneer",
   "BMW 7-Series","Dumptruck","SA Firetruck","Peterbuilt","Lincoln Towncar","Dodge Aries",
   "Acura NSX '05","Chevy Biscayne","Ford Aerostar","Ford Box Van","Ferrari Testarosso",
   "Ford Econoline","Emergency Helicopter","Chevrolet Astrovan","Cadillac Eldorado",
   "Chevy Caprice","Lincoln Mark 7","Chevrolet S10","Chevy Ice Cream Truck",
   "Volkswagen Beach Buggy","AH-64A","Chevrolet Caprice", "International SWAT Van",
   "Securita Van","Dodge Viper","Preditor","Volvo Bus","M1A1 Abrams","Barracks",
   "Ford Hot Rod","Trailer","Nissan Pulsar","Old Coach","Caprice Classic Cab",
   "Ford Mustang Mach 1","Mercedes Van","RC Bandit","Cadillac Hearse","Packer/Stunt Helper",
   "Chevy S-10 Monster Truck","Mercedes-Benz S-Class","Chris Craft Stinger","Bell 47G",
   "Piaggio Vespa PX 200","Tram","Trailer","Ferrari F40", "Go-Fast Boat","Orca",
   "Sea Ray 270 Sedan Bridge","Flatbed","1992 Ford F800","Golf Car","Ford Taurus Wagon",
   "Honda Life '74","Cessna 150 With Floats","Honda CBR 600 '92", "Piaggio Vespa PX 200 '86",
   "Harley Davidson Soft Tail", "RC Red Baron", "RC Raider","Dodge Dart","Plymouth Belverdere",
   "Yamaha DT 200 Dirt Bike","Bell 47G","Hummer H-1","Honda TRX250x '92","Coastguard Boat",
   "Rescue Boat","Mercury '51","Chevy Chevelle","Curtiss P-40D Warhawk","Mazda RX-7",
   "Chevy Farm Truck","Chevy Caprice Estate","Porsche 911","Schwinn BMX","Dodge Ramvan",
   "Volkswagen Bus","Endeavour 42","Equitech M40 '85","Bulldozer","Bell 206L-4",
   "Bell 206B-3","Ford Bronco","Chevrolet Suburban '92","Lincoln Mark 7",
   "Dodge Diplomat","CMN Interceptor DV-15","Ford Mustang LX","Ford Bronco",
   "Honda CRX","Bell 206L-4","Chevy Cargo Van","Ford Moving Van","Jeep Wrangler",
   "RC Heli","Ford Mustang LX '86","Ford Mustang LX '86","Customised Glendale",
   "Ford Bronco '80","Mitsubishi 3000 GT","Buick Roadmaster","GMC R.V.","Old Bike",
   "Schwinn Mesa Mountain Hardtail","C-2 Greyhound","Grumman G-164 AgCat",
   "Pitt's Special","Gas Tanker","International 9370 Truck","Lincoln Towncar",
   "Chevy Monte Carlo","Chevrolet Monte Carlo","Bombardier Learjet 55",
   "AV-8 Harrier Jump-Jet","Honda CBR 900 RR Fireblade","Honda NSR 500 '01",
   "Kawasaki KZ1000-P21","Chevrolet Cement Truck","Tow Truck '91","Ford Thunderbird",
   "Ford Escort","CSI/FBI Investigation Truck","Dodge Dynasty","Forklift '89","Old Tractor",
   "Combine Harvester","Mercedes-Benz SL-Class","Lincoln Mark 5","Chevy CST '68",
   "Chevrolet Caprice Droptop","1972 EMD SD40","Amtrak F40PH","Hovercraft","Mercedes Benz E120",
   "Ford GT-40","Dodge Challenger '70","Dodge 100 Series","SA Firetruck","Ford Hotrod",
   "Chevrolet Lumina","Oldsmobile Cutlass Ciera","Sikorsky CH-53","Dodge Roadrunner",
   "Late 80's Honda Sedan","Mercury Grand Marquis","Chevy 2500","Douglas C-47",
   "GMC Sierra","Jaguar XKE '66","Chevy S-10 Monster Truck","Chevy S-10 Monster Truck",
   "Eagle Talon","Toyota Supra","Impreza 2.5RS '95","Honda Accord Wagon","Nissan R34 Skyline",
   "Sikorsky UH-60 Black Hawk","RC Tiger","Honda Civic","Oldsmobile Cutlass","Chevy Impala",
   "Half Life 2 Sand Rail","EMD SD40", "Trailer","Go Kart","Ride-On Lawn Mower",
   "Mercedes-Benz AK 4x4 '91","Elgin Pelican","Caddilac '54","Chevy Bel Air '57",
   "Boeing 737","Flatbed","Range Rover","Rolls Royce","Honda VFR 400","Dodge Ramvan Newsvan",
   "Baggage Tow Tractor HTAG-30/40","Trailer","Infinity J30 '92","Honda Goldwing GL1500 '04",
   "Nissan 350Z/240SX","Hotdog Van","Volkswagen Golf","Trailer","Trailer","Lockheed C-5 Galaxy",
   "Cessna 150", "Unknown","CMN Interceptor DV-15","Chevy Caprice LA", "Chevy Caprice SF",
   "Chevy Caprice LV","Chevy Blazer Desert","Chevrolet El Camino '68","S.W.A.T. Van",
   "Dodge Stealth '91","Pontiac Trans AM", "Dodge Dart", "Dodge 100 Series", "Luggage Trailer",
   "Luggage Trailer", "Stair Trailer", "Chevy Cargo Van","Farm Plow", "Chevy 2500 Trailer"

};

new GameName[][] =
{
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
   "Monster Truck",
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
   "ZR-350",
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
   "Monster Truck", //monstera
   "Monster Truck", //monsterb
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

public OnPlayerCommandText(playerid, cmdtext[])
{
        if(strcmp(cmdtext, "/realname", true) == 0)
        {
                NameValue[playerid] = VEHNAME_REAL;
                GameTextForPlayer(playerid, "~g~Realnames successfully ~n~~g~turned on.", 4000, 4); //1 = Realname
                return 1;
        }
        if(strcmp(cmdtext, "/gamename", true) == 0)
        {
                NameValue[playerid] = VEHNAME_GAME;
                GameTextForPlayer(playerid, "~g~Gamenames successfully ~n~~g~turned on.", 4000, 4); //0 = Gamename
                return 1;
        }
        if(strcmp(cmdtext, "/nameoff", true) == 0)
        {
            NameValue[playerid] = VEHNAME_OFF;
            GameTextForPlayer(playerid, "~r~Names successfully turned off!", 4000, 4); //Its off
            return 1;
        }
        if(strcmp(cmdtext, "/nameon", true) == 0)
        {
            if(NameValue[playerid] == VEHNAME_OFF)
            {
                NameValue[playerid] = VEHNAME_GAME;
                GameTextForPlayer(playerid, "~g~Gamename's successfully turned on. To change type \"/realname\"", 4000, 4);
                return 1;
                }
                else if(NameValue[playerid] == VEHNAME_GAME || NameValue[playerid] == VEHNAME_REAL)
                {
                    GameTextForPlayer(playerid, "~r~You can't turn on something that is already turned on.", 4000, 4);
                    return 1;
                }
        }
        if(strcmp(cmdtext, "/namehelp", true) == 0)
        {
            SendClientMessage(playerid, 0xAA3333AA, "]=-=[ Leopard's Real Vehicle Name's Script]=-=[");
            SendClientMessage(playerid, 0xFFFF00AA, "=================={ COMMANDS }=================");
            SendClientMessage(playerid, 0xFFFF00AA, "|>> \"/realname\" - turn on real names");
            SendClientMessage(playerid, 0xFFFF00AA, "|>> \"/gamename\" - turn on game naems");
            SendClientMessage(playerid, 0xFFFF00AA, "|>> \"/nameoff\" - turn off the name's");
            SendClientMessage(playerid, 0xFFFF00AA, "|>> \"/nameon\" - turn on the name's*");
            SendClientMessage(playerid, 0xAA3333AA, "|>>*only works if \"/nameoff\" has been activated.");
            return 1;
        }
        return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
        if(NameDisplayType[playerid] == VEHNAME_ENTERVEHICLE)
        {
                if(NameValue[playerid] == VEHNAME_OFF)
             {
                        return 1;
                }
             else if(NameValue[playerid] == VEHNAME_GAME)
        {
                new str[80];
            format(str, sizeof(str), "%s", GameName[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
            GameTextForPlayer(playerid, str, 6000, 1);
                }
              else if(NameValue[playerid] == VEHNAME_REAL)
              {
            new str[80];
                        format(str, sizeof(str), "%s", RealName[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
            GameTextForPlayer(playerid, str, 1000, 1);
                }
                return 1;
        }
        else return 0;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
        if(NameDisplayType[playerid] == VEHNAME_STATECHANGE)
        {
                if(NameValue[playerid] == VEHNAME_GAME)
                {
                    new tmp[256];
                    format(tmp, 256, "%s", GameName[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
                    GameTextForPlayer(playerid, tmp, 4000, 1);
                    return 1;
                }
                else if(NameValue[playerid] == VEHNAME_REAL)
                {
                    new tmp[256];
                    format(tmp, 256, "%s", RealName[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
                    GameTextForPlayer(playerid, tmp, 4000, 1);
                    return 1;
                }
                else if(NameValue[playerid] == VEHNAME_OFF)
                {
                    return 0;
                }
                return 1;
        }
        else return 0;
}

public OnPlayerConnect(playerid)
{
        SendClientMessage(playerid, 0xFFFF00AA, "SERVER: Vehicle Name has been set to standard. Type /namehelp for help.");
        NameValue[playerid] = VEHNAME_GAME;
        return 1;
}
