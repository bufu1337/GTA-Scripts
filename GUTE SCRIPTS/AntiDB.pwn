#include <a_samp>

//KEYS
#define HOLDING(%0) \
        ((newkeys & (%0)) == (%0))// HOLDING(keys)
#define PRESSED(%0) \
        (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))// PRESSED(keys)
#define RELEASED(%0) \
        (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))// RELEASED(keys)

new PDBTRUE[MAX_PLAYERS];
new Text:Txt;
new timer[MAX_PLAYERS];

forward Quad(playerid);
//NON DDB Vehicles
//Air vehicles
IsAirVehicle(vehicleid)
{
    switch(GetVehicleModel(vehicleid)) {
                case 592,577,511,512,593,520,553,476,519,460,513,548,425,417,487,488,497,563,447,469: return 1;
        }
    return 0;
}
//Trailers
IsTrailer(vehicleid)
{
    switch(GetVehicleModel(vehicleid)) {
                case 435,450,591,606,607,610,584,608,611: return 1;
        }
    return 0;
}
//Trains
IsTrain(vehicleid)
{
    switch(GetVehicleModel(vehicleid)) {
                case 590,569,537,538,570,449: return 1;
        }
    return 0;
}
//DDB Vehicles
//Bikes
IsBike(vehicleid)
{
    switch(GetVehicleModel(vehicleid)) {
                case 581,523,462,521,463,522,461,448,468,586,509,510,481: return 1;
        }
    return 0;
}
//DDB-enabled vehicle checker
IsDDBVehicle(vehicleid)
{
        if(IsAirVehicle(vehicleid)==1)return 0;
        if(IsTrailer(vehicleid)==1)return 0;
        if(IsTrain(vehicleid)==1)return 0;
        if(GetVehicleModel(vehicleid)==471)return 1;
        return 1;
}
//DB (Passenger) enabled vehicles
IsPDBVehicle(vehicleid)
{
    new m=GetVehicleModel(vehicleid);
        if(IsTrailer(vehicleid))return 0;
        if(IsTrain(vehicleid))return 0;
        if(IsAirVehicle(vehicleid))
        {
            if((m==593||m==511))return 1;
                return 0;
        }
        if((m==437||m==431))return 0;
        return 1;
}
//Sends a message to the driver
SendDriverMessage(vehicleID)
{
        for(new i; i<MAX_PLAYERS; i++)
        {
            if(GetPlayerState(i)==2&&GetPlayerVehicleID(i)==vehicleID)
            {
                        TextDrawShowForPlayer(i,Txt);
                        timer[i]=GetTickCount();
            }
        }
        return 1;
}
public Quad(playerid)
{
        new keys,u,d;
        GetPlayerKeys(playerid,keys,u,d);
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid,x,y,z);
        new vehicleid=GetPlayerVehicleID(playerid);
        if(keys&KEY_FIRE){SetPlayerPos(playerid,x,y,z);SetVehiclePos(vehicleid,x,y,z);}
        if(keys&KEY_ACTION){SetPlayerPos(playerid,x,y,z);SetVehiclePos(vehicleid,x,y,z);}
        return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    new vehicleid=GetPlayerVehicleID(playerid);
        if(GetPlayerState(playerid)==2&&IsDDBVehicle(vehicleid))
        {
                new Weapon,ammo;
                GetPlayerWeaponData(playerid,4,Weapon,ammo);
                if(Weapon==0)return 0;
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid,x,y,z);
                if(GetVehicleModel(vehicleid)==471)
                {
                    if(HOLDING(KEY_FIRE)){SetTimerEx("Quad",600,0,"d",playerid);}
                        if(HOLDING(KEY_ACTION)){SetTimerEx("Quad",600,0,"d",playerid);}
                        if(PRESSED(KEY_FIRE)&HOLDING(KEY_LOOK_RIGHT)){SetPlayerPos(playerid,x,y,z);SetVehiclePos(vehicleid,x,y,z);}
                        if(PRESSED(KEY_ACTION)&HOLDING(KEY_LOOK_RIGHT)){SetPlayerPos(playerid,x,y,z);SetVehiclePos(vehicleid,x,y,z);}
                        if(PRESSED(KEY_FIRE)&HOLDING(KEY_LOOK_LEFT)){SetPlayerPos(playerid,x,y,z);SetVehiclePos(vehicleid,x,y,z);}
                        if(PRESSED(KEY_ACTION)&HOLDING(KEY_LOOK_LEFT)){SetPlayerPos(playerid,x,y,z);SetVehiclePos(vehicleid,x,y,z);}
                }
                if(PRESSED(KEY_FIRE)&&IsBike(vehicleid)){SetPlayerPos(playerid,x,y,z);SetVehiclePos(vehicleid,x,y,z);}
                if(PRESSED(KEY_ACTION)&&IsBike(vehicleid)){SetPlayerPos(playerid,x,y,z);SetVehiclePos(vehicleid,x,y,z);}
                if((PRESSED(KEY_FIRE)&HOLDING(KEY_LOOK_RIGHT))&&IsDDBVehicle(vehicleid)){SetPlayerPos(playerid,x,y,z);SetVehiclePos(vehicleid,x,y,z);}
                if((PRESSED(KEY_ACTION)&HOLDING(KEY_LOOK_RIGHT))&&IsDDBVehicle(vehicleid)){SetPlayerPos(playerid,x,y,z);SetVehiclePos(vehicleid,x,y,z);}
                if((PRESSED(KEY_FIRE)&HOLDING(KEY_LOOK_LEFT))&&IsDDBVehicle(vehicleid)){SetPlayerPos(playerid,x,y,z);SetVehiclePos(vehicleid,x,y,z);}
                if((PRESSED(KEY_ACTION)&HOLDING(KEY_LOOK_LEFT))&&IsDDBVehicle(vehicleid)){SetPlayerPos(playerid,x,y,z);SetVehiclePos(vehicleid,x,y,z);}
        }
        if(GetPlayerState(playerid)==PLAYER_STATE_PASSENGER&&IsPDBVehicle(vehicleid))
        {
            new Weapon,ammo;
                GetPlayerWeaponData(playerid,4,Weapon,ammo);
                if(Weapon==0)return 0;
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid,x,y,z);
                if(PRESSED(2)&&PDBTRUE[playerid]==0){PDBTRUE[playerid]=1;return 1;}
                if(PRESSED(KEY_FIRE)&&PDBTRUE[playerid]==1){PDBTRUE[playerid]=0;SetPlayerPos(playerid,x,y,z);SendDriverMessage(vehicleid);}
                if(PRESSED(KEY_ACTION)&&PDBTRUE[playerid]==1){SetPlayerPos(playerid,x,y,z);SendDriverMessage(vehicleid);}
        }
        return 1;
}
public OnPlayerConnect(playerid){PDBTRUE[playerid]=0;timer[playerid]=0;return 1;}
public OnPlayerStateChange(playerid,newstate,oldstate){
        if(oldstate==PLAYER_STATE_PASSENGER)return PDBTRUE[playerid]=0;
        return 1;
}
public OnFilterScriptInit()return Ini_Text();
Ini_Text()
{
        Txt = TextDrawCreate(313.000000,11.000000,"Your passenger has been EJECTED for Drive-By!");
        TextDrawUseBox(Txt,1);
        TextDrawBoxColor(Txt,0xff0000ff);
        TextDrawTextSize(Txt,558.000000,0.000000);
        TextDrawAlignment(Txt,0);
        TextDrawBackgroundColor(Txt,0x000000ff);
        TextDrawFont(Txt,1);
        TextDrawLetterSize(Txt,0.299999,0.899999);
        TextDrawColor(Txt,0xffffffff);
        TextDrawSetOutline(Txt,1);
        TextDrawSetProportional(Txt,1);
        TextDrawSetShadow(Txt,1);
        return 1;
}
public OnPlayerUpdate(playerid)
{
        if(timer[playerid]!=0&&GetTickCount()-timer[playerid]>5000){timer[playerid]=0; TextDrawHideForPlayer(playerid,Txt);}
        return 1;
}