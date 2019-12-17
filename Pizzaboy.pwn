#include <a_samp>

#define COLOR_DARKGOLD 0x808000AA
#define COLOR_RED 0xFF0000AA
#define COLOR_YELLOW 0xFFFF00AA

new PizzaJob[256];

public OnFilterScriptInit()
{
    
    AddStaticVehicle(448,2122.1677,-1784.2250,12.9837,180.4585,0,0); // Pizza 1
    AddStaticVehicle(448,2121.9895,-1784.7623,12.9867,181.5936,0,0); // Pizza 1
    AddStaticVehicle(448,2118.8469,-1784.5692,12.9880,181.5090,0,0); // Pizza 2
    AddStaticVehicle(448,2115.7837,-1784.6464,12.9860,181.6605,0,0); // Pizza 3
    
}
public OnPlayerCommandText(playerid, cmdtext[])
{
    if (strcmp("/pizza", cmdtext, true, 10) == 0)
    {
        if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 448)
        {
            PizzaJob[playerid] = 1;
            new name[MAX_PLAYER_NAME], string[48];
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "* %s is now a Pizzaboy.", name );
            SendClientMessageToAll(COLOR_YELLOW, string);
            SetPlayerCheckpoint(playerid,2012.6134,-1729.3796,13.1536,10);
            SendClientMessage(playerid,COLOR_YELLOW,"* Follow the red markers and you'll recieve money!");
            return 1;
        }
        SendClientMessage(playerid, COLOR_RED,"You have to be on a pizza bike to start the job!");
    }
    return 0;
}
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
     if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 448)
     {
         SendClientMessage(playerid, COLOR_RED, "* You can start the pizza courier by using /pizza");
     }
     return 0;
}
public OnPlayerEnterCheckpoint(playerid)
{
     if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 448)
     {
        if(PizzaJob[playerid] == 1){
            PizzaJob[playerid] = 2;
            SetPlayerCheckpoint(playerid,2012.4771,-1640.1229,13.1431,10);
            SendClientMessage(playerid,COLOR_YELLOW,"* Please go to the next mark, and you'll be payed!");
            return 1;
         }
        if(PizzaJob[playerid] == 2){
            PizzaJob[playerid] = 3;
            SetPlayerCheckpoint(playerid,2387.0063,-1667.1498,13.1249,10);
            return 1;
         }
        if(PizzaJob[playerid] == 3){
            PizzaJob[playerid] = 4;
            SetPlayerCheckpoint(playerid,2414.9255,-1649.6678,13.1305,10);
            return 1;
         }
        if(PizzaJob[playerid] == 4){
            PizzaJob[playerid] = 5;
            SetPlayerCheckpoint(playerid,2517.6394,-1678.3141,13.9862,10);
            return 1;
         }
        if(PizzaJob[playerid] == 5){
            PizzaJob[playerid] = 6;
            SetPlayerCheckpoint(playerid,2441.1526,-2017.4093,13.1231,10);
            return 1;
         }
        if(PizzaJob[playerid] == 6){
            PizzaJob[playerid] = 7;
            SetPlayerCheckpoint(playerid,2486.2058,-2017.6384,13.1309,10);
            return 1;
         }
        if(PizzaJob[playerid] == 7){
            PizzaJob[playerid] = 8;
            SetPlayerCheckpoint(playerid,2520.9238,-2016.4714,13.1395,10);
            return 1;
         }
        if(PizzaJob[playerid] == 8){
            PizzaJob[playerid] = 9;
            SetPlayerCheckpoint(playerid,2464.7258,-2000.3944,13.1430,10);
            return 1;
         }
        if(PizzaJob[playerid] == 9){
            PizzaJob[playerid] = 10;
            SetPlayerCheckpoint(playerid,2240.8374,-1886.9504,13.1486,10);
            return 1;
         }
        if(PizzaJob[playerid] == 10){
            PizzaJob[playerid] = 11;
            SetPlayerCheckpoint(playerid,2095.5488,-1815.7517,12.9792,10);
            return 1;
         }
        if(PizzaJob[playerid] == 11){
            PizzaJob[playerid] = 0;
            DisablePlayerCheckpoint(playerid);
            SendClientMessage(playerid,COLOR_YELLOW,"* You have recieved $400 for delivering the pizzas.");
            GivePlayerMoney(playerid,400);
         }
     }
     return 1;
}
public OnPlayerExitVehicle(playerid, vehicleid)
{
    if(PizzaJob[playerid] > 0)
    {
        PizzaJob[playerid] = 0;
        SendClientMessage(playerid, COLOR_RED, "* You have left your job, you won't be payed.");
        DisablePlayerCheckpoint(playerid);
    }
}