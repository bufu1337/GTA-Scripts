#pragma tabsize 0
#include <a_samp>
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_ORANGE 0xFF9900AA
new version[] = "1.5 alpha";
new VehNames[212][] = {
"Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster",
"Stretch","Manana","Infernus","Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto",
"Taxi","Washington","Bobcat","Mr Whoopee","BF Injection","Hunter","Premier","Enforcer","Securicar","Banshee",
"Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie","Stallion","Rumpo",
"RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer",
"Turismo","Speeder","Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer",
"PCJ-600","Faggio","Freeway","RC Baron","RC Raider","Glendale","Oceanic","Sanchez","Sparrow","Patriot",
"Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3 50","Walton","Regina","Comet","BMX",
"Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo",
"Greenwood","Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa",
"RC Goblin","Hotring Racer A","Hotring Racer B","Bloodring Banger","Rancher","Super GT","Elegant",
"Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain","Nebula","Majestic",
"Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona",
"FBI Truck","Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight",
"Streak","Vortex","Vincent","Bullet","Clover","Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob",
"Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A","Monster B","Uranus",
"Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight",
"Trailer","Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford",
"BF-400","Newsvan","Tug","Trailer A","Emperor","Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C",
"Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)","Police Car (LVPD)","Police Ranger",
"Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
"Stair Trailer","Boxville","Farm Plow","Utility Trailer" };
//max values
new MVC=700, MVM=127, MOC=250, MPC=400, MOP=200, MP=200, MTDC=1024, MGZC=1024, MMC=128;
//recommended values
new RVC=700, RVM=60, ROC=150, RPC=250, ROP=200, RP=200, RTDC=100, RGZC=100, RMC=50;
new acm,acmf[50],as;
new gamemodes[16][64];
new ctc;
public OnFilterScriptInit() {
printstart();
return 1;
}
public OnRconCommand(cmd[]) {
if (acm == 1) {
as=0;
if (IsPlayerConnected(strval(cmd)) == 0) {
printf("Player %s isn't connected",cmd);
acm=0;
return 1;
} else {
format(acmf,sizeof(acmf),"kick %s",cmd);
SendRconCommand(acmf);
acm=0;
print(" \n Done!\n");
print(" Press '0' for returning to the start \n \n");
return 1;
}}
else if (acm == 2) {
as=0;
if (IsPlayerConnected(strval(cmd)) == 0) {
printf("Player %s isn't connected",cmd);
acm=0;
return 1;
} else {
format(acmf,sizeof(acmf),"ban %s",cmd);
SendRconCommand(acmf);
acm=0;
print(" \n Done!\n");
print(" Press '0' for returning to the start \n \n");
return 1;
}}
else if (acm == 3) {
as=0;
if (IsPlayerConnected(strval(cmd)) == 0) {
printf("Player %s isn't connected",cmd);
acm=0;
return 1;
} else {
SetPlayerHealth(strval(cmd),100);
acm=0;
print(" \n Done!\n");
print(" Press '0' for returning to the start \n \n");
return 1;
}}
else if (acm == 4) {
as=0;
if (IsPlayerConnected(strval(cmd)) == 0) {
printf("Player %s isn't connected",cmd);
acm=0;
return 1;
} else {
SetPlayerArmour(strval(cmd),100);
acm=0;
print(" \n Done!\n");
print(" Press '0' for returning to the start \n \n");
return 1;
}}
else if (acm == 5) {
as=0;
if (ctc == 0 || strval(cmd)>ctc+2) {
printf("%s isn't available",cmd);
acm=0;
ctc=0;
return 1;
}
else if (strval(cmd) == ctc+1) {
acm=6;
ctc=0;
print("Type the name of the gamemode");
return 1;
} else {
SendRconCommand(gamemodes[strval(cmd)]);
acm=0;
ctc=0;
print(" \n Done!\n");
print(" Press '0' for returning to the start \n \n");
return 1;
}}
else if (acm == 6) {
as=0;
acm=0;
format(acmf,sizeof(acmf),"changemode %s",cmd);
SendRconCommand(acmf);
print(" \n Done!\n");
print(" Press '0' for returning to the start \n \n");
return 1;
} else {
if(strcmp(cmd, "1", true)==0) {
printmain();
return 1;
}
if(strcmp(cmd, "2", true)==0) {
printst3();
return 1;
}
if(strcmp(cmd, "3", true)==0) {
printvl();
return 1;
}
if(strcmp(cmd, "4", true)==0) {
printpls();
return 1;
}
if(strcmp(cmd, "5", true)==0) {
print("\n Good-bye! (c) TYS 1.5 \n");
SendRconCommand("unloadfs tys15");
return 1;
}
if(strcmp(cmd, "0", true)==0) {
printstart();
return 1;
}
if (as == 1) {
if(strcmp(cmd, "A", true)==0) {
print("\n Type the id of the player:");
acm=1;
return 1;
}
if(strcmp(cmd, "B", true)==0) {
print("\n Type the id of the player:");
acm=2;
return 1;
}
if(strcmp(cmd, "C", true)==0) {
print("\n Type the id of the player:");
acm=3;
return 1;
}
if(strcmp(cmd, "D", true)==0) {
print("\n Type the id of the player:");
acm=4;
return 1;
}
if(strcmp(cmd, "E", true)==0) {
printE();
acm=5;
return 1;
}}}
return 0;
}
stock VehicleModel() {
new model[250], nummodel;
for (new i=1;i<VehicleCount()+1;i++) {
model[GetVehicleModel(i)-400]++;
}
for (new iv=0;iv<250;iv++) {
if (model[iv]!=0) {
nummodel++;
}}
return nummodel;
}
stock VehicleCountOld() {
new numcar=CreateVehicle(490,0,0,0,0,0,0,3000);
DestroyVehicle(numcar);
return numcar-1;
}
stock VehicleCount() {
new iVehicleCnt;
for(new i = 1; i < MAX_VEHICLES; i++)
if (GetVehicleModel(i))
iVehicleCnt++;
return iVehicleCnt;
}
stock ObjectCount() {
new numo = CreateObject(1245,0,0,1000,0,0,0);
DestroyObject(numo);
return numo-1;
}
stock PickupCount() {
new nump = CreatePickup(371,2,0,0,1000);
DestroyPickup(nump);
return nump;
}
stock TextDrawCount() {
new Text:TT = TextDrawCreate(1,1,"Test");
TextDrawDestroy(TT);
return _:TT;
}
stock GangZoneCount() {
new cz = GangZoneCreate(3,3,5,5);
GangZoneDestroy(cz);
return cz;
}
stock MenuCount() {
new cm;
for (new _:menx=1;_:menx<128;_:menx++) {
if (IsValidMenu(Menu:menx)) {
cm++;
}}
return cm;
}
stock OnlinePlayers() {
new ol;
for(new i=0; i < MAX_PLAYERS; i++) {
if (IsPlayerConnected(i)) {
ol++;
}}
return ol;
}
stock ReturnServerStringVar(const varname[]){
    new str[64];
    GetServerVarAsString(varname, str, sizeof(str));
    return str;
}
stock duplicatesymbol(symbol,count) {
new tempst[2],string[256];
format(tempst,128,"%c",symbol);
for (new i=0;i<count;i++) {
strins(string,tempst,strlen(string),strlen(string)+1+strlen(tempst));
}
return string;
}
stock printmain() {
new warnings, errors;
new VehCount = VehicleCount();
new VehModel = VehicleModel();
new ObjCount = ObjectCount();
new PickCount = PickupCount();
new OnlPl = OnlinePlayers();
new MaxPl = GetMaxPlayers();
new TextDrCount = TextDrawCount();
new GZCount = GangZoneCount();
new MenCount = MenuCount();
print(" Test Your Server Filterscript loaded!");
printf(" Version: %s",version);
print(" Testing started...");
printf("%c%s%c",218,duplicatesymbol(196,64),191);
printf("%c Title                  Count      Max   Recomended       *TYS* %c",179,179);
printf("%c%s%c",195,duplicatesymbol(196,64),180);
printf("%cModename:              %40s %c",179,ReturnServerStringVar("gamemodetext"),179);
printf("%cVehicles:              [%4d]    [%4d]    [%3d]       *        %c",179,VehCount,MVC,RVC,179);
printf("%cTypes of vehicles:     [%4d]    [%4d]    [%3d]      TTT       %c",179,VehModel,MVM,RVM,179);
printf("%cObjects:               [%4d]    [%4d]    [%3d]     **T**      %c",179,ObjCount,MOC,ROC,179);
printf("%cPickups:               [%4d]    [%4d]    [%3d]    **Y*Y**     %c",179,PickCount,MPC,RPC,179);
printf("%cOnline players:        [%4d]    [%4d]    [%3d]   ****Y****    %c",179,OnlPl,MOP,ROP,179);
printf("%cMax players:           [%4d]    [%4d]    [%3d]    ***SS**     %c",179,MaxPl,MP,RP,179);
printf("%cTextDraw:              [%4d]    [%4d]    [%3d]     **S**      %c",179,TextDrCount,MTDC,RTDC,179);
printf("%cGangZone:              [%4d]    [%4d]    [%3d]      SS*       %c",179,GZCount,MGZC,RGZC,179);
printf("%cMenu:                  [%4d]    [%4d]    [%3d]       *        %c",179,MenCount,MMC,RMC,179);
printf("%c%s%c \n%c                                                                %c",195,duplicatesymbol(196,64),180,179,179);
printf("%c              Errors and Warnings:                              %c",179,179);
printf("%c%s%c",195,duplicatesymbol(196,64),180);
if (VehCount > MVC) {
errors++;
printf("%c Error: Count of vehicles must be not more than          %5d  %c",179,MVC,179); }
if (VehicleModel() > MVM) {
errors++;
printf("%c Error: Count of types of vehicles must be not more than %5d  %c",179,MVM,179); }
else if (VehicleModel() > RVM) {
warnings++;
printf("%c Warning: Recomended count of types of vehicles is       %5d  %c",179,RVM,179); }
if (ObjectCount() > MOC) {
errors++;
printf("%c Error: Count of objects must be not more than           %5d  %c",179,MOC,179); }
else if (ObjectCount() > ROC) {
warnings++;
printf("%c Warning: Recomended count of objects is                 %5d  %c",179,ROC,179); }
if (PickupCount() > MPC) {
errors++;
printf("%c Error: Count of pickups must be not more than           %5d  %c",179,MPC,179); }
else if (PickupCount() > RPC) {
warnings++;
printf("%c Warning: Recomended count of pickups is                 %5d  %c",179,RPC,179); }
if (TextDrawCount() > MTDC) {
errors++;
printf("%c Error: Count of TextDraw must be not more than          %5d  %c",179,MTDC,179); }
else if (TextDrawCount() > RTDC) {
warnings++;
printf("%c Warning: Recomended count of TextDraw is                %5d  %c",179,RTDC,179); }
if (GangZoneCount() > MGZC) {
errors++;
printf("%c Error: Count of GangZone must be not more than          %5d  %c",179,MGZC,179); }
else if (GangZoneCount() > RGZC) {
warnings++;
printf("%c Warning: Recomended count of GangZone is                %5d  %c",179,RGZC,179); }
if (MenuCount() > MMC) {
errors++;
printf("%c Error: Count of Menu must be not more than              %5d  %c",179,MMC,179); }
else if (MenuCount() > RMC) {
warnings++;
printf("%c Warning: Recomended count of Menu is                    %5d  %c",179,RMC,179); }
printf("%c%s%c",195,duplicatesymbol(196,64),180);
printf("%c                         Errors: %3d Warnings: %3d              %c",179,errors,warnings,179);
printf("%c                                                                %c",179,179);
printf("%c The end of testing                                             %c",179,179);
printf("%c%s%c \n \n",192,duplicatesymbol(196,64),217);
print(" Done!\n");
print(" Press '0' for returning to the start \n \n");
return 1;
}
stock printstart() {
printf("%c%s%c",218,duplicatesymbol(196,58),191);
printf("%c Hello! It's TYS 1.5. What are you looking for?           %c",179,179);
printf("%c                                                          %c",179,179);
printf("%c 1. Main statistic                                        %c",179,179);
printf("%c 2. Rcon administration                                   %c",179,179);
printf("%c 3. Vehicle types list                                    %c",179,179);
printf("%c 4. Player list                                           %c",179,179);
printf("%c 5. Close filterscript                                    %c",179,179);
printf("%c                                                          %c",179,179);
printf("%c Press reques number                                      %c",179,179);
printf("%c                                  made by [LDT]LuxurY     %c",179,179);
printf("%c%s%c \n \n",192,duplicatesymbol(196,58),217);
return 1;
}
stock printvl() {
new model[250],VehCount;
printf(" %c%s%c",201,duplicatesymbol(205,28),187);
printf(" %c   CAR              COUNT   %c",186,186);
printf(" %c%s%c",204,duplicatesymbol(205,28),185);
VehCount = VehicleCount();
for (new i=1;i<VehCount+1;i++) {
model[GetVehicleModel(i)-400]++;
}
for (new v=0;v<250;v++) {
if (model[v]!=0) {
printf(" %c %20s %-5d %c",186,VehNames[v],model[v],186);
}}
if (VehCount == 0) {
printf(" %c            none            %c",186,186);
}
printf(" %c%s%c",204,duplicatesymbol(205,28),185);
printf(" %c           Total:           %c",186,186);
printf(" %c              Count: %5d  %c",186,VehicleCount(),186);
printf(" %c              Types: %5d  %c",186,VehicleModel(),186);
printf(" %c%s%c",200,duplicatesymbol(205,28),188);
print(" Done!\n");
print(" Press '0' for returning to the start \n \n");
return 1;
}
stock printpls() {
new plstat[12],pln[15],Float:hp,Float:arm,ip[16];
printf("%c%s%c",218,duplicatesymbol(196,76),191);
printf("%c ID  Name            HP  ARM  Money     Ping  Status       IP               %c",179,179);
printf("%c%s%c",195,duplicatesymbol(196,76),180);
if (OnlinePlayers() == 0) {
printf("%c                             No active players                              %c",179,179);
}
for(new i=0;i<MAX_PLAYERS;i++) {
if (IsPlayerConnected(i)==1) {
GetPlayerName(i,pln,sizeof(pln));
if (IsPlayerAdmin(i) == 1) {
plstat = "Rcon Admin";
}
else if (GetPlayerPing(i) == 0) {
plstat = "Bot";
}
else {
plstat = "Player";
}
GetPlayerHealth(i,hp);
GetPlayerArmour(i,arm);
GetPlayerIp(i,ip,16);
printf("%c %-3d %15s %-3d  %-3d %-10d %-4d %12s %16s %c",179,i,pln,floatround(hp),floatround(arm),GetPlayerMoney(i),GetPlayerPing(i),plstat,ip,179);
}}
printf("%c%s%c",192,duplicatesymbol(196,76),217);
print(" \n Done!\n");
print(" Press '0' for returning to the start \n \n");
return 1;
}
stock printst3() {
printf("%c%s%c",218,duplicatesymbol(196,58),191);
printf("%c Hello! It's TYS 1.5 administration section               %c",179,179);
printf("%c                                                          %c",179,179);
printf("%c Choose the command:                                      %c",179,179);
printf("%c                                                          %c",179,179);
printf("%c A. Kick Player                                           %c",179,179);
printf("%c B. Ban Player                                            %c",179,179);
printf("%c C. Heal player                                           %c",179,179);
printf("%c D. Armour player                                         %c",179,179);
printf("%c E. Change Gamemode                                       %c",179,179);
printf("%c                                                          %c",179,179);
printf("%c Press reques letter                                      %c",179,179);
printf("%c                                  made by [LDT]LuxurY     %c",179,179);
printf("%c%s%c \n \n",192,duplicatesymbol(196,58),217);
as=1;
return 1;
}
printE() {
printf("%c%s%c",218,duplicatesymbol(196,58),191);
printf("%c Hello! It's TYS 1.5 changemode section                   %c",179,179);
printf("%c                                                          %c",179,179);
printf("%c Choose the gamemode or type the other:                   %c",179,179);
printf("%c                                                          %c",179,179);
for (new i=0;i<16;i++) {
new gst[64];
format(gst,sizeof(gst),"gamemode%d",i);
new str[64];
GetServerVarAsString(gst, str, sizeof(str));
if (str[1] != 0) {
ctc++;
format(gamemodes[ctc],64,"changemode %s",str);
printf("%c %2d. %15s                                      %c",179,ctc,str,179);
}}
printf("%c %2d. Other mode                                           %c",179,ctc+1,179);
printf("%c                                                          %c",179,179);
printf("%c Press reques number                                      %c",179,179);
printf("%c                                  made by [LDT]LuxurY     %c",179,179);
printf("%c%s%c \n \n",192,duplicatesymbol(196,58),217);
return 1;
}
public OnPlayerConnect(playerid) {
SendClientMessage(playerid,0xFF9900AA,"Server uses TYS 1.5 stats by [LDT]LuxurY");
return 1;
}
