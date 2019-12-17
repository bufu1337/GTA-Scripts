
// Vehicle System [ mic_vehicle ]

/*
native GivePlayerVehicleKeys(playerid,vehicleid);
native TakePlayerVehicleKeys(playerid,vehicleid);
native IsPlayerHavingKeys(playerid,vehicleid);
native LockVehicle(vehicleid);
native UnLockVehicle(vehicleid);
native IsVehicleLocked(vehicleid);
native StopVehicle(vehicleid);
native UnStopVehicle(vehicleid);
native GetVehicleDriverId(vehicleid);
native GetVehicleFuel(vehicleid);
native EnableFuelSystem(toggle);
native UseFuel(playerid,vehicleid);
native GiveFuel(playerid,vehicleid);
*/

public GivePlayerVehicleKeys(playerid,vehicleid)
{
PlayerKeys[playerid][vehicleid] = 1;
}

public TakePlayerVehicleKeys(playerid,vehicleid)
{
PlayerKeys[playerid][vehicleid] = 0;
}

public IsPlayerHavingKeys(playerid,vehicleid)
{
return PlayerKeys[playerid][vehicleid];
}

public LockVehicle(vehicleid)
{
VehicleLock[vehicleid] = 1;
}

public UnLockVehicle(vehicleid)
{
VehicleLock[vehicleid] = 0;
}

public IsVehicleLocked(vehicleid)
{
return VehicleLock[vehicleid];
}

public StopVehicle(vehicleid)
{
VehicleStop[vehicleid] = 1;
NoFuel(GetVehicleDriverId(vehicleid),vehicleid);
}

public UnStopVehicle(vehicleid)
{
VehicleStop[vehicleid] = 0;
}

public GetVehicleDriverId(vehicleid)
{
new i,id = -1;
for(i=0;i<=MAX_PLAYERS;i++)
{
if(IsPlayerInVehicle(i,vehicleid)==1){
id = i;
}
}
return id;
}

public GetVehicleFuel(vehicleid)
{
return Fuel[vehicleid];
}

public EnableFuelSystem(toggle){
if (toggle == 1){
FuelSys = 1;
}
}

public UseFuel(playerid,vehicleid){

//printf("directed to %d, In %d",vehicleid,vid);
//printf("playerid is %d",playerid);
if (IsPlayerInVehicle(playerid,vehicleid)){
//print("Player is in vehicle");
new lfuel;
lfuel = 100 - Fuel[vehicleid];
Fuel[vehicleid] = Fuel[vehicleid] + 1;
SetTimerEx("UseFuel",10000,0,"ii",playerid,vehicleid);
new string[256];
format(string,255,"~n~~n~~n~~n~~n~~g~Fuel:~w~ %d",lfuel);
if (lfuel <= 0){
TogglePlayerControllable(playerid,0);
NoFuel(playerid,vehicleid);
}
GameTextForPlayer(playerid,string,10000,5);
}}
public NoFuel(playerid,vehicleid){
if (IsPlayerInVehicle(playerid,vehicleid)==1){
SetTimerEx("NoFuel",200,0,"ii",playerid,vehicleid);
new value,ud,lr;
GetPlayerKeys(playerid,value,ud,lr);
if (value == KEY_SECONDARY_ATTACK){
TogglePlayerControllable(playerid,1);
RemovePlayerFromVehicle(playerid);
}}
}

public GiveFuel(playerid,vehicleid){
new lfuel,mon,string[256];
lfuel = 100 - Fuel[vehicleid];
mon = lfuel * 7;
if (mon <= GetPlayerMoney(playerid)){
Fuel[vehicleid] = 0;
GivePlayerMoney(playerid,-mon);
format(string,255,"Vehicle filled up for $%d.",mon);
GameTextForPlayer(playerid,string,3000,5);
}
else{
GameTextForPlayer(playerid,"~r~You dont have enought money.",2000,5);
}}


public InGasStation(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		////printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

