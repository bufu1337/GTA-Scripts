/*                                                      Taxi job script by Jari_Johnson
																Keep the credits!
								        						Version 1.0 bèta

When on foot, use /duty to go on duty as a taxi driver, when you have a customer, use /fare to start the fare.
If you need to spawn a taxi, use /spawntaxi (can be disabled).

								                               																				*/


#include <a_samp> //Credits to the SA-MP Team
#include <zcmd> //Credits to Zeex
#include <colors> //Credits to Oxside
#include <getvehicledriver> //Credits to Smeti

#define STARTAMOUNT 2.66 //This is the starting amount for the fare, remember, enter is as a float, ex. 1.23
#define MONEYPER100 1.00 //This is the amount of money the customer has to pay each 100 meters, remember, enter as a float, ex. 1.23
#define ScriptVersion "1.0b"//Do not change, this is for my reference.
#define AllowTaxiSpawn  //Comment this line if you don't want to allow the /spawntaxi command.

//===NEW'S====//
new Text:taxiblackbox[MAX_PLAYERS];
new Text:taxigreendisplay[MAX_PLAYERS];
new Text:taxitimedisplay[MAX_PLAYERS];
new Text:taxi100mfare[MAX_PLAYERS];
new Text:taxithisfare[MAX_PLAYERS];
new Text:taxilstlogo[MAX_PLAYERS];
new Text:taxistatus[MAX_PLAYERS];
new Text:startfare[MAX_PLAYERS];
new IsOnFare[MAX_PLAYERS];
new OnDuty[MAX_PLAYERS];
new clockupdate;
new faretimer[MAX_PLAYERS];

new Float:OldX[MAX_PLAYERS],Float:OldY[MAX_PLAYERS],Float:OldZ[MAX_PLAYERS],Float:NewX[MAX_PLAYERS],Float:NewY[MAX_PLAYERS],Float:NewZ[MAX_PLAYERS];
new Float:TotalFare[MAX_PLAYERS];

//
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	printf(" 	Jari_Johnson's Taxi Script\n  	      Version %s",ScriptVersion);
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}
public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    KillTimer(faretimer[playerid]);
    OnDuty[playerid] = 0;
    IsOnFare[playerid] = 0;

	TotalFare[playerid] = 0.0;

	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{

    new driver = GetVehicleDriver(vehicleid);
	if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER && TotalFare[driver] > 0)
	{
	new money = floatround(TotalFare[driver]);
	new message[128];
    format(message,sizeof(message),"You have paid %d $ to the Taxi driver",money);
	GivePlayerMoney(playerid,-money);
	TotalFare[driver] = 0;
	TextDrawSetString(taxithisfare[driver],"Total Fare: N/A");
	GivePlayerMoney(driver,money);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,message);
	format(message,sizeof(message),"%s has paid you %d $ for the ride.",GetPlayerNameEx(playerid),money);
	SendClientMessage(driver,COLOR_LIGHTBLUE,message);
	TotalFare[driver] = 0.00;


	IsOnFare[driver] = 0;
	KillTimer(faretimer[driver]);
	}





	for(new i=0; i < MAX_PLAYERS; i++)
	{
	TextDrawHideForPlayer(playerid, taxiblackbox[i]);
	TextDrawHideForPlayer(playerid, startfare[i]);
	TextDrawHideForPlayer(playerid, taxigreendisplay[i]);
	TextDrawHideForPlayer(playerid, taxitimedisplay[i]);
	TextDrawHideForPlayer(playerid, taxi100mfare[i]);
	TextDrawHideForPlayer(playerid, taxithisfare[i]);
	TextDrawHideForPlayer(playerid, taxilstlogo[i]);
	TextDrawHideForPlayer(playerid, taxistatus[i]);
	TextDrawHideForPlayer(playerid, startfare[i]);
	}
 	TextDrawSetString(taxistatus[driver],"Taxi Status: Free");

	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new vehicleid = GetPlayerVehicleID(playerid);
    new driver = GetVehicleDriver(vehicleid);
    if(newstate == PLAYER_STATE_DRIVER)
	{

	if(OnDuty[playerid] == 1 && IsATaxi(vehicleid) == 1)
	{

	TextDrawShowForPlayer(playerid, taxiblackbox[playerid]);
	TextDrawShowForPlayer(playerid, taxigreendisplay[playerid]);
	TextDrawShowForPlayer(playerid, taxitimedisplay[playerid]);
	TextDrawShowForPlayer(playerid, taxi100mfare[playerid]);
	TextDrawShowForPlayer(playerid, startfare[playerid]);
	TextDrawShowForPlayer(playerid, taxithisfare[playerid]);
	TextDrawShowForPlayer(playerid, taxilstlogo[playerid]);
	TextDrawShowForPlayer(playerid, taxistatus[playerid]);
	}
	}
	if(newstate == PLAYER_STATE_PASSENGER)
	{
	if(OnDuty[driver] == 1)
	{

	TextDrawShowForPlayer(playerid, taxiblackbox[driver]);
	TextDrawShowForPlayer(playerid, taxigreendisplay[driver]);
	TextDrawShowForPlayer(playerid, taxitimedisplay[driver]);
	TextDrawShowForPlayer(playerid, taxi100mfare[driver]);
	TextDrawShowForPlayer(playerid, taxithisfare[driver]);
	TextDrawShowForPlayer(playerid, taxilstlogo[driver]);
    TextDrawSetString(taxistatus[driver],"Taxi Status: Occupied");
	TextDrawShowForPlayer(playerid, taxistatus[driver]);
	TextDrawShowForPlayer(playerid, startfare[driver]);

	}
	}
 	if(newstate == PLAYER_STATE_ONFOOT)
	{

    TextDrawHideForPlayer(playerid, taxiblackbox[playerid]);
	TextDrawHideForPlayer(playerid, taxigreendisplay[playerid]);
	TextDrawHideForPlayer(playerid, taxitimedisplay[playerid]);
	TextDrawHideForPlayer(playerid, taxi100mfare[playerid]);
	TextDrawHideForPlayer(playerid, taxithisfare[playerid]);
	TextDrawHideForPlayer(playerid, taxilstlogo[playerid]);
	TextDrawHideForPlayer(playerid, taxistatus[playerid]);
	TextDrawHideForPlayer(playerid, startfare[playerid]);

    if(IsOnFare[playerid] == 1)
	{


	SendClientMessage(playerid,COLOR_LIGHTBLUE,"Taxi duty over - You exited the vehicle!");
	OnDuty[playerid] = 0;
	TotalFare[playerid] = 0.00;
 	TextDrawSetString(taxithisfare[playerid],"N/A");
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"Fare stopped");
	IsOnFare[playerid] = 0;
	KillTimer(faretimer[playerid]);
	TextDrawDestroy(taxiblackbox[playerid]);
	TextDrawDestroy(taxigreendisplay[playerid]);
	TextDrawDestroy(taxitimedisplay[playerid]);
	TextDrawDestroy(taxi100mfare[playerid]);
	TextDrawDestroy(taxithisfare[playerid]);
	TextDrawDestroy(taxilstlogo[playerid]);
	TextDrawDestroy(taxistatus[playerid]);
	TextDrawDestroy(startfare[playerid]);
	TextDrawDestroy(taxiblackbox[driver]);
	TextDrawDestroy(taxigreendisplay[driver]);
	TextDrawDestroy(taxitimedisplay[driver]);
	TextDrawDestroy(taxi100mfare[driver]);
	TextDrawDestroy(taxithisfare[driver]);
	TextDrawDestroy(taxilstlogo[driver]);
	TextDrawDestroy(taxistatus[driver]);
	TextDrawDestroy(startfare[driver]);



	}
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
//==COMMANDS==//
CMD:fare(playerid,params[])
{
	if(OnDuty[playerid] == 0) return SendClientMessage(playerid,COLOR_RED,"You are not on duty");
	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsATaxi(vehicleid)) return SendClientMessage(playerid,COLOR_RED,"You need to be in a taxi to do this!");
	if(GetPlayerVehicleSeat(playerid) != 0) return SendClientMessage(playerid,COLOR_RED,"You need to be the driver to do this!");
	if(CheckPassengers(vehicleid) != 1) return SendClientMessage(playerid,COLOR_RED,"DO NOT ABUSE YOUR JOB! Wait for someone to get in the taxi!");
	if(IsOnFare[playerid] == 0)
	{

	if(IsOnFare[playerid] == 1) return SendClientMessage(playerid,COLOR_LIGHTBLUE,"You are already on a fare");
	GetPlayerPos(playerid,Float:OldX[playerid],Float:OldY[playerid],Float:OldZ[playerid]);
	faretimer[playerid] = SetTimerEx("FareUpdate", 1000, true, "i", playerid);
	IsOnFare[playerid] = 1;
	TotalFare[playerid] = STARTAMOUNT;
	new formatted[128];
	format(formatted,128,"Total Fare: %.2f $",STARTAMOUNT);
	TextDrawSetString(taxithisfare[playerid],formatted);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"You are now on a fare, take your customer to his/her desired place!");
	return 1;
	}
	if(IsOnFare[playerid] == 1)
	{
	TotalFare[playerid] = 0.00;
	TextDrawSetString(taxithisfare[playerid],"Total Fare: N/A");
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"Fare stopped");
	IsOnFare[playerid] = 0;
	KillTimer(faretimer[playerid]);
 	return 1;
	}
	return 1;

}
CMD:spawntaxi(playerid,params[])
{
	#if defined AllowTaxiSpawn
	new Float:x,Float:y,Float:z;
 	GetPlayerPos(playerid,x,y,z);
 	CreateVehicle(420,x,y,z,0,0,0,10000);
	return 1;
 	#else
 	return SendClientMessage(playerid,COLOR_RED,"This command is disabled");

	#endif

}
CMD:duty(playerid,params[])
{

	if(IsOnFare[playerid] == 1) return SendClientMessage(playerid,COLOR_LIGHTBLUE,"You are currently on a fare, you cant go off duty now!");
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have to be on foot to do this!");
	if(OnDuty[playerid] == 0)
	{
	OnDuty[playerid] = 1;

	SendClientMessage(playerid,COLOR_LIGHTBLUE,"You are now on duty!");



	taxiblackbox[playerid] = TextDrawCreate(497.000000, 302.000000, "              ");
	TextDrawBackgroundColor(taxiblackbox[playerid], 255);
	TextDrawFont(taxiblackbox[playerid], 1);
	TextDrawLetterSize(taxiblackbox[playerid], 0.500000, 1.000000);
	TextDrawColor(taxiblackbox[playerid], -1);
	TextDrawSetOutline(taxiblackbox[playerid], 0);
	TextDrawSetProportional(taxiblackbox[playerid], 1);
	TextDrawSetShadow(taxiblackbox[playerid], 1);
	TextDrawUseBox(taxiblackbox[playerid], 1);
	TextDrawBoxColor(taxiblackbox[playerid], 255);
	TextDrawTextSize(taxiblackbox[playerid], 140.000000, -1.000000);

	taxigreendisplay[playerid] = TextDrawCreate(484.000000, 318.000000, "          ");
	TextDrawBackgroundColor(taxigreendisplay[playerid], 255);
	TextDrawFont(taxigreendisplay[playerid], 1);
	TextDrawLetterSize(taxigreendisplay[playerid], 0.500000, 1.000000);
	TextDrawColor(taxigreendisplay[playerid], -1);
	TextDrawSetOutline(taxigreendisplay[playerid], 0);
	TextDrawSetProportional(taxigreendisplay[playerid], 1);
	TextDrawSetShadow(taxigreendisplay[playerid], 1);
	TextDrawUseBox(taxigreendisplay[playerid], 1);
	TextDrawBoxColor(taxigreendisplay[playerid], 576786175);
	TextDrawTextSize(taxigreendisplay[playerid], 154.000000, -1.000000);

	taxitimedisplay[playerid] = TextDrawCreate(160.000000, 340.000000, "Time:  Loading..");
	TextDrawBackgroundColor(taxitimedisplay[playerid], 255);
	TextDrawFont(taxitimedisplay[playerid], 2);
	TextDrawLetterSize(taxitimedisplay[playerid], 0.250000, 0.799999);
	TextDrawColor(taxitimedisplay[playerid], 835715327);
	TextDrawSetOutline(taxitimedisplay[playerid], 1);
	TextDrawSetProportional(taxitimedisplay[playerid], 1);
	new format100[128];
	format(format100,128,"Price per 100 meters: %.2f",MONEYPER100);
	taxi100mfare[playerid] = TextDrawCreate(160.000000, 360.000000, format100);
	TextDrawBackgroundColor(taxi100mfare[playerid], 255);
	TextDrawFont(taxi100mfare[playerid], 2);
	TextDrawLetterSize(taxi100mfare[playerid], 0.250000, 0.799999);
	TextDrawColor(taxi100mfare[playerid], 835715327);
	TextDrawSetOutline(taxi100mfare[playerid], 1);
	TextDrawSetProportional(taxi100mfare[playerid], 1);

	taxithisfare[playerid] = TextDrawCreate(160.000000, 380.000000, "This fare: N/A ");
	TextDrawBackgroundColor(taxithisfare[playerid], 255);
	TextDrawFont(taxithisfare[playerid], 2);
	TextDrawLetterSize(taxithisfare[playerid], 0.250000, 0.799999);
	TextDrawColor(taxithisfare[playerid], 835715327);
	TextDrawSetOutline(taxithisfare[playerid], 1);
	TextDrawSetProportional(taxithisfare[playerid], 1);

	taxilstlogo[playerid] = TextDrawCreate(220.000000, 317.000000, "Los Santos Transport");
	TextDrawBackgroundColor(taxilstlogo[playerid], 255);
	TextDrawFont(taxilstlogo[playerid], 3);
	TextDrawLetterSize(taxilstlogo[playerid], 0.550000, 1.799998);
	TextDrawColor(taxilstlogo[playerid], 835715327);
	TextDrawSetOutline(taxilstlogo[playerid], 1);
	TextDrawSetProportional(taxilstlogo[playerid], 1);

	taxistatus[playerid] = TextDrawCreate(320.000000, 390.000000, "Taxi Status: ");
	TextDrawBackgroundColor(taxistatus[playerid], 255);
	TextDrawFont(taxistatus[playerid], 2);
	TextDrawLetterSize(taxistatus[playerid], 0.250000, 0.799998);
	TextDrawColor(taxistatus[playerid], 835715327);
	TextDrawSetOutline(taxistatus[playerid], 1);
	TextDrawSetProportional(taxistatus[playerid], 1);
	new formatted[128];
	format(formatted,128,"Start fare: %.2f",STARTAMOUNT);

	startfare[playerid] = TextDrawCreate(380.000000, 340.000000, formatted);

	TextDrawBackgroundColor(startfare[playerid], 255);

	TextDrawFont(startfare[playerid], 2);

	TextDrawLetterSize(startfare[playerid], 0.250000, 0.799998);

	TextDrawColor(startfare[playerid], 835715327);

	TextDrawSetOutline(startfare[playerid], 1);

	TextDrawSetProportional(startfare[playerid], 1);

	TextDrawSetString(taxistatus[playerid],"Taxi Status: Free");
	Clock();

	return 1;
	}

	if(OnDuty[playerid] == 1)
	{
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"You are now Off-Duty");
	OnDuty[playerid] = 0;
	TextDrawDestroy(taxiblackbox[playerid]);
	TextDrawDestroy(taxigreendisplay[playerid]);
	TextDrawDestroy(taxitimedisplay[playerid]);
	TextDrawDestroy(taxi100mfare[playerid]);
	TextDrawDestroy(taxithisfare[playerid]);
	TextDrawDestroy(taxilstlogo[playerid]);
	TextDrawDestroy(taxistatus[playerid]);
	TextDrawDestroy(startfare[playerid]);

	return 1;
	}


	return 1;
}
//
forward Clock();
public Clock()
{
    new hour,minute;
	gettime(hour,minute);
	new string[128];
	if(minute < 10)
	{
	format(string,sizeof(string),"Time: %d : 0%d",hour,minute);
	}
	else
	{
	format(string,sizeof(string),"Time: %d : %d",hour,minute);
	}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	if(IsPlayerConnected(i))
	{
	if(OnDuty[i] == 1)
	{
	TextDrawSetString(taxitimedisplay[i],string);
	}
	}
	}
	KillTimer(clockupdate);
	clockupdate = SetTimer("Clock",60000,0);
}
forward IsATaxi(vehicleid);
public IsATaxi(vehicleid)
{
	new vmodel = GetVehicleModel(vehicleid);
	if(vmodel == 420 || vmodel == 438)
	{
		return 1;
	}
	return 0;
}
forward FareUpdate(playerid);
public FareUpdate(playerid)
{


	new farestring[128];
	GetPlayerPos(playerid,NewX[playerid],NewY[playerid],NewZ[playerid]);
	new Float:totdistance = GetDistanceBetweenPoints(OldX[playerid],OldY[playerid],OldZ[playerid], NewX[playerid],NewY[playerid],NewZ[playerid]);
    if(totdistance > 100.0)
    {
    TotalFare[playerid] = TotalFare[playerid]+MONEYPER100;
	format(farestring,sizeof(farestring),"Total Fare: %.2f $",TotalFare[playerid]);
	TextDrawSetString(taxithisfare[playerid],farestring);
	GetPlayerPos(playerid,Float:OldX[playerid],Float:OldY[playerid],Float:OldZ[playerid]);
	}


	return 1;

}
forward Float:GetDistanceBetweenPoints(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2);
stock Float:GetDistanceBetweenPoints(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2)
{
    x1 -= x2;
    y1 -= y2;
    z1 -= z2;
    return floatsqroot((x1 * x1) + (y1 * y1) + (z1 * z1));
}
stock CheckPassengers(vehicleid)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	if(IsPlayerInAnyVehicle(i))
	{
	if(GetPlayerVehicleID(i) == vehicleid && i != GetVehicleDriver(vehicleid))
	{

	return 1;

	}
	}
	}
	return 0;
}
stock GetPlayerNameEx(playerid)
{
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid,pname,sizeof(pname));
	return pname;
}