#include <a_samp>

new ls;
new sf;
new lv;
new desert;
new Menu:airport;
new lsg;
new lvg;
new oldg;
new sfg;
new Menu:air2;
new endflight;
new Text:planedesert;
new Text:planelv;
new Text:planels;
new Text:planesf;

//-----------------------------------------
//|                                        |
//|                                        |
//|                                        |
//|                S                       |
//|                1                       |
//|                k                       |
//|                                        |
//|                                        |
//|                                        |
//|                                        |
//|                                        |
//-----------------------------------------
//This Filterscript took time to do so dont delete credits.
//This Filterscript was made by me and only me. So beware.
//This Filterscript is very useful to many people.
//THis Filterscript Is Useful For RP's servers.
//THIS IS A HARD SCRIPT SO DONT STEAL IT!
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//|||||||THIS SCRIPT WAS CREATED BY S1K AND ONLY S1K||||||||
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
             print("---Loaded City To City Airlines---");
                   print("---Made By s1k---");
             print("---Filterscript Lines 265---");
	return 1;
}

public OnFilterScriptExit()
{
	          print("---City To City Airlines By S1k Unloaded---");
	return 1;
}

#else

main()
{

}

#endif

#pragma tabsize 0

public OnGameModeInit()
{
ls = CreatePickup(1239, 23, 1686.2490,-2335.3774,13.5469);
sf = CreatePickup(1239, 23, -1421.1450,-287.0187,14.1484);
lv = CreatePickup(1239, 23, 1672.7314,1447.6901,10.7875);
desert = CreatePickup(1239, 23, 390.0043,2501.9929,19.9594);
endflight = CreatePickup(1239, 23, 4.1931,22.7549,1199.6012);

CreateObject(1683, 409.751801, 2502.472412, 21.387001, 0.0000, 0.0000, 180.0000);
CreateObject(3361, 390.211212, 2499.067139, 16.883245, 0.0000, 0.0000, 270.0000);
CreateObject(1682, 383.747284, 2473.215088, 30.692871, 0.0000, 0.0000, 270.0000);

airport = CreateMenu("Airport List", 2, 50.0, 180.0, 200.0, 200.0);

AddMenuItem(airport, 0, "Abandoned Desert Airport");
AddMenuItem(airport, 1, "$80 Plane Ticket");
AddMenuItem(airport, 0, "Las Ventures");
AddMenuItem(airport, 1, "$95 Plane Ticket");
AddMenuItem(airport, 0, "Los Santos");
AddMenuItem(airport, 1, "$100 Plane Ticket");
AddMenuItem(airport, 0, "San Fierro");
AddMenuItem(airport, 1, "$105 Plane Ticket");
AddMenuItem(airport, 0, "Close Menu");

air2 = CreateMenu("Flight Ending", 1, 50.0, 180.0, 200.0, 200.0);

AddMenuItem(air2, 0, "Abandoned Desert Airport");
AddMenuItem(air2, 0, "Las Ventures Airport");
AddMenuItem(air2, 0, "Los Santos Airport");
AddMenuItem(air2, 0, "San Fierro Airport");
AddMenuItem(air2, 0, "Close Menu");

lsg = GangZoneCreate(1539.302, -2388.508, 1813.106, -2321.396);
lvg = GangZoneCreate(1654.115, 1318.531, 1720.497, 1581.56);
oldg = GangZoneCreate(245.2354, 2440.676, 455.4371, 2534.099);
sfg = GangZoneCreate(-1521.716, -435.5739, -1386.522, -218.6009);

planedesert = TextDrawCreate(0.0, 434.0,"Going To Desert Airstrip");
TextDrawFont(planedesert,3);
TextDrawLetterSize(planedesert,1,1);
TextDrawColor(planedesert,0xF600FF);
TextDrawSetShadow(planedesert,1);
TextDrawSetOutline(planedesert,1);
TextDrawBackgroundColor(planedesert,0x000FF);
TextDrawUseBox(planedesert,0);

planelv = TextDrawCreate(0.0, 434.0,"Going To Las Ventures Airport");
TextDrawFont(planelv,3);
TextDrawLetterSize(planelv,1,1);
TextDrawColor(planelv,0xF600FF);
TextDrawSetShadow(planelv,1);
TextDrawSetOutline(planelv,1);
TextDrawBackgroundColor(planelv,0x000FF);
TextDrawUseBox(planelv,0);

planels = TextDrawCreate(0.0, 434.0,"Going To Los Santos Airport");
TextDrawFont(planels,3);
TextDrawLetterSize(planels,1,1);
TextDrawColor(planels,0xF600FF);
TextDrawSetShadow(planels,1);
TextDrawSetOutline(planels,1);
TextDrawBackgroundColor(planels,0x000FF);
TextDrawUseBox(planels,0);

planesf = TextDrawCreate(0.0, 434.0,"Going To San Fierro Airport");
TextDrawFont(planesf,3);
TextDrawLetterSize(planesf,1,1);
TextDrawColor(planesf,0xF600FF);
TextDrawSetShadow(planesf,1);
TextDrawSetOutline(planesf,1);
TextDrawBackgroundColor(planesf,0x000FF);
TextDrawUseBox(planesf,0);
return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
       if(pickupid == ls || pickupid == sf || pickupid == lv || pickupid == desert) ShowMenuForPlayer(airport, playerid);
       if(pickupid == endflight) ShowMenuForPlayer(air2, playerid);
       return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:current;
    current = GetPlayerMenu(playerid);
    if(current == airport)
    {
        switch(row)
        {
            case 0:{
SetPlayerPos(playerid,390.0043,2501.9929,19.9594);
SetPlayerInterior(playerid,0);
GivePlayerMoney(playerid,-80);
SendClientMessage(playerid,0x81CFAB00,"You Are Now On The Plane");
TextDrawShowForPlayer(playerid, Text:planedesert);

SetPlayerPos(playerid,2.384830,33.103397,1199.849976);
SetPlayerInterior(playerid,1);
            }
            case 1:{
SetPlayerPos(playerid,1672.7314,1447.6901,10.7875);
SetPlayerInterior(playerid,0);
GivePlayerMoney(playerid,-95);
SendClientMessage(playerid,0x81CFAB00,"You Are Now On The Plane");
TextDrawShowForPlayer(playerid, Text:planelv);

SetPlayerPos(playerid,2.384830,33.103397,1199.849976);
SetPlayerInterior(playerid,1);
            }
            case 2:{
SetPlayerPos(playerid,1686.2490,-2335.3774,13.5469);
SetPlayerInterior(playerid,0);
GivePlayerMoney(playerid,-100);
SendClientMessage(playerid,0x81CFAB00,"You Are Now On The Plane");
TextDrawShowForPlayer(playerid, Text:planels);

SetPlayerPos(playerid,2.384830,33.103397,1199.849976);
SetPlayerInterior(playerid,1);
            }
            case 3:{
SetPlayerPos(playerid,-1421.1450,-287.0187,14.1484);
SetPlayerInterior(playerid,0);
GivePlayerMoney(playerid,-105);
SendClientMessage(playerid,0x81CFAB00,"You Are Now On The Plane");
TextDrawShowForPlayer(playerid, Text:planesf);

SetPlayerPos(playerid,2.384830,33.103397,1199.849976);
SetPlayerInterior(playerid,1);
            }
			case 4:{
HideMenuForPlayer(Menu:airport, playerid);
			}
		}
    }

{
    current = GetPlayerMenu(playerid);
    if(current == air2)
    {
        switch(row)
        {
            case 0:{
SetPlayerPos(playerid,390.0043,2501.9929,19.9594);
SetPlayerInterior(playerid,0);
SendClientMessage(playerid,0x81CFAB00,"You Left The Airplane And Got Off At The Desert Airport");
TextDrawHideForPlayer(playerid, Text:planedesert);
            }
            case 1:{
SetPlayerPos(playerid,1672.7314,1447.6901,10.7875);
SetPlayerInterior(playerid,0);
SendClientMessage(playerid,0x81CFAB00,"You Left The Airplane And Got Off At The Las Ventures Airport");
TextDrawHideForPlayer(playerid, Text:planelv);
            }
            case 2:{
SetPlayerPos(playerid,1686.2490,-2335.3774,13.5469);
SetPlayerInterior(playerid,0);
SendClientMessage(playerid,0x81CFAB00,"You Left The Airplane And Got Off At The Los Santos Airport");
TextDrawHideForPlayer(playerid, Text:planels);
            }
            case 3:{
SetPlayerPos(playerid,-1421.1450,-287.0187,14.1484);
SetPlayerInterior(playerid,0);
SendClientMessage(playerid,0x81CFAB00,"You Left The Airplane And Got Off At The San Fierro Airport");
TextDrawHideForPlayer(playerid, Text:planesf);
			}
			case 4:{
HideMenuForPlayer(Menu:air2, playerid);
			}
		}
    }
    return 1;
}
}

public OnPlayerConnect(playerid)
{
SendClientMessage(playerid,0x81CFAB00,"This Server Uses City To City Airlines.");
SendClientMessage(playerid,0x81CFAB00,"Go To Any Airport To Travel!");
SendClientMessage(playerid,0x81CFAB00,"Have Fun!");
return 1;
}

public OnPlayerSpawn(playerid)
{
GangZoneShowForPlayer(playerid, lsg, 0xC0C0C096);
GangZoneShowForPlayer(playerid, lvg, 0xC0C0C096);
GangZoneShowForPlayer(playerid, oldg, 0xC0C0C096);
GangZoneShowForPlayer(playerid, sfg, 0xC0C0C096);
return 1;
}