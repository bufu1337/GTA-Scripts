/*

-* ChangeLog

-* 0.1 Release

-* 0.2 Nick the player does not appear when you type /Event ( Bug Fixed )
-* 0.2 Small change in the code in itself.


-* 0.3 Added the command /ExitEvent
-* 0.3 Now the player who is not at the event can then use the same command again.

-* 0.4 Updated bug fixed not existent command.


-* 0.5 Added the commands /first [id] /second [id] /third [id] /espawn
-* 0.5 Now players who die in the event will get the message to all
-* 0.5 Colors Random for players entering the event
-* 0.5 Name added to the cars when the player between them
-* 0.5 Added the command /Esetweather [ id ]


-* 0.6 (2014) Add the command /efinish
-* 0.6 (2014) Small change in the code in itself.
-* 0.6 (2014) Added include foreach ( Y_Less ty )

|-------------------------------------|
|--* Last updated in January 2015 --* |
|-------------------------------------|
-* 0.7 (2015) Small change in the code in itself.
-* 0.7 (2015) Removed color random nicks to connect the event
-* 0.7 (2015) Removed the name of the car to connect the event
-* 0.7 (2015) Added kill consecutive awards the killers who are within the event
-* 0.7 (2015) Added the command /Eventhidenick

|------------------------------------|
|Soon version 0.8 will be available  |
|------------------------------------|
*/

#include <a_samp>
#include <zcmd>
#include <sscanf2>
#include <foreach>
// =============================================================================
new bool:EvenTStats , bool:TheEvenT[ MAX_PLAYERS ] , Float:EventoPos [ 4 ] , EventoInt , EventoVW , bool:EventoRecarregarLife = false , iString2[129+1] , KillStreak[100],bool:HideNick = false;
// =============================================================================
#define version                                                                 "0.6"
//==============================================================================
forward Count(Contagem);
// =============================================================================
public OnFilterScriptInit()
{
    print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
    print("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t");
    print("TEventSystem Made By : Tw0.P4c__. Or Diogo123");
    print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
    print("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t");
    print("Load Version : "version"");
    return 1;
}
// =============================================================================
public OnFilterScriptExit() return print("UnLoad");
public OnPlayerConnect(playerid) return KillStreak[playerid] = 0, TheEvenT [ playerid ] = false ;
public OnPlayerDisconnect(playerid, reason) return TheEvenT [ playerid ] = false ;
public OnPlayerSpawn(playerid) return TheEvenT [ playerid ] = false ;
// =============================================================================
public OnPlayerStateChange(playerid, newstate, oldstate)
{
    return 1;
}
// =============================================================================
public OnPlayerDeath(playerid, killerid, reason)
{
    TheEvenT [ playerid ] = false ;
    KillStreak[playerid] = 0;
    foreach(Player, v)
    {
    	if(killerid != INVALID_PLAYER_ID)
		{
        	if ( TheEvenT [ v ] )
        	{
            	format ( iString2 , sizeof ( iString2 ) , "{FFFFFF}The Player {FF230A}%s{FFFFFF}({FF230A}ID:%d{FFFFFF}) Died in the event.", GetPName ( playerid ) , playerid ) ;
            	SendClientMessageToAll ( -1 , iString2 ) ;
            	SendDeathMessage ( killerid , playerid , reason ) ;
            	KillStreak[killerid] ++;
           		if(KillStreak[killerid] == 3)
				{
		    		format(iString2, sizeof(iString2), "{FFFFFF}The Player {FF230A}%s is starting to OWN PEOPLE (3 killing spree)!", GetPName(killerid));
					SendClientMessageToAll(-1, iString2);
			  		SendClientMessage(killerid,-1, "{FFFFFF}- Info -{FF230A} You get $1500 and +2 score! (killing spree bonus)");
			  		GivePlayerMoney(playerid, 1500);
			  		GivePlayerScore(playerid, 2);
				}
				if(KillStreak[killerid] == 5)
				{
				    format(iString2, sizeof(iString2), "{FFFFFF}The Player {FF230A}%s is on a fucking rampage (5 killing spree)!", GetPName(killerid));
					SendClientMessageToAll(-1, iString2);
					SendClientMessage(killerid,-1, "{FFFFFF}- Info -{FF230A} You get $2500 and +3 score! (killing spree bonus)");
					GivePlayerMoney(playerid, 2500);
			  		GivePlayerScore(playerid, 3);
				}
				if(KillStreak[killerid] == 10)
				{
				    format(iString2, sizeof(iString2), "{FFFFFF}The Player {FF230A}%s has mastered the art of killing (10 killing spree)!", GetPName(killerid));
					SendClientMessageToAll(-1, iString2);
					SendClientMessage(killerid,-1, "{FFFFFF}- Info -{FF230A} You get $5000 and +4 score! (killing spree bonus)");
					GivePlayerMoney(playerid, 5000);
			  		GivePlayerScore(playerid, 4);
				}
				if(KillStreak[killerid] == 15)
				{
				    format(iString2, sizeof(iString2), "{FFFFFF}The Player {FF230A}%s can kill the whole world (15 killing spree)!", GetPName(killerid));
					SendClientMessageToAll(-1, iString2);
					SendClientMessage(killerid,-1, "{FFFFFF}- Info -{FF230A} You get $7 500 and +6 score! (killing spree bonus)");
					GivePlayerMoney(playerid, 7500);
			  		GivePlayerScore(playerid, 6);
				}
				if(KillStreak[killerid] == 20)
				{
				    format(iString2, sizeof(iString2), "{FFFFFF}The Player {FF230A}%s is the god of the universe (20 killing spree)!", GetPName(killerid));
					SendClientMessageToAll(-1, iString2);
					SendClientMessage(killerid,-1, "{FFFFFF}- Info -{FF230A} You get $12 500 and +10 score! (killing spree bonus)");
					GivePlayerMoney(playerid, 12500);
			  		GivePlayerScore(playerid, 10);
				}
				if(KillStreak[killerid] == 25)
				{
				    format(iString2, sizeof(iString2), "{FFFFFF}The Player {FF230A}%s - no words.. (25 killing spree)!", GetPName(killerid));
					SendClientMessageToAll(-1, iString2);
					SendClientMessage(killerid,-1, "{FFFFFF}- Info -{FF230A} You get $20 000 and +15 score! (killing spree bonus)");
					GivePlayerMoney(playerid, 20000);
			  		GivePlayerScore(playerid, 15);
				}
        	}
    	}
	}
    if ( TheEvenT [ killerid ] == true )
    {
        if ( EventoRecarregarLife == true )
        {
            SetPlayerHealth ( killerid , 100.0 ) ;
            SetPlayerArmour ( killerid , 100.0 ) ;
        }
    }
    return 1;
}
// ================================= [ EVENT SYSTEM ] ==========================
CMD:openevent(playerid)
{
    if ( EvenTStats ) return SendClientMessage ( playerid , 0x00C0FFFF , "The event is already open." ) ;
    if ( !IsPlayerAdmin ( playerid ) ) return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    EvenTStats = true;
    TheEvenT[playerid] = true;
    GetPlayerPos ( playerid , EventoPos [ 0 ] , EventoPos [ 1 ] , EventoPos [ 2 ] ) ;
    GetPlayerFacingAngle ( playerid , EventoPos [ 3 ] ) ;
    EventoInt = GetPlayerInterior ( playerid ) ;
    EventoVW = GetPlayerVirtualWorld ( playerid ) ;
    SendClientMessageToAll ( 0xFFFFFFFF," " ) ;
    SendClientMessageToAll ( 0xFF00FFFF,"[ EVENT ] : EVENT OPEN BY ADMIN ENTER ' /EVENT ' !" ) ;
    SendClientMessageToAll ( 0xFFFFFFFF," " ) ;
    return 1;
}
// =============================================================================
CMD:efinish(playerid)
{
	if ( EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "The event is already open." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    SendClientMessageToAll( 0x33CCFFFF , "[EVENT]: The Admin just with the event!" ) ;
	foreach(Player, v)
	{
 		if ( TheEvenT [ v ] )
 		{
			TheEvenT [ v ] = false;
			EvenTStats = false;
			SpawnPlayer ( v ) ;
		}
	}
	return 1;
}
// =============================================================================
CMD:eclose(playerid)
{
    if ( !EvenTStats ) return SendClientMessage ( playerid , 0x00C0FFFF , "The event is already closed." ) ;
    if ( !IsPlayerAdmin ( playerid ) ) return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    for ( new v , b = GetMaxPlayers(); v != b; v++ )
    {
        if ( TheEvenT [ v ] )
        {
            TheEvenT [ v ] = true ;
            EvenTStats = false ;
        }
    }
    return 1;
}
// =============================================================================
CMD:frist(playerid,params[])
{
    new ID;
    if ( !EvenTStats ) return SendClientMessage ( playerid , 0x00C0FFFF , "The event is already closed." ) ;
    if ( !IsPlayerAdmin ( playerid ) ) return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    if ( sscanf ( params , "i", ID ) ) return SendClientMessage ( playerid , -1 ,"{F81414}/Frist [ ID ]" ) ;
    if ( !IsPlayerConnected ( ID ) ) return SendClientMessage ( playerid , -1 , "{F81414}Player is not connected" ) ;
    if ( !TheEvenT [ ID ] ) return SendClientMessage ( playerid , 0x00C0FFFF , "This player is not in the event." ) ;
    format ( iString2 , sizeof ( iString2 ) , "{FFFFFF}The first was placed {FF230A} %s ({FF230A}ID:%d{FFFFFF})!!!", GetPName ( playerid ) , playerid ) ;
    SendClientMessageToAll ( -1 , iString2 ) ;
    SendClientMessage ( ID , -1 , "You took first place and received R$ 5.000!" ) ;
    GivePlayerMoney ( ID , 5000 ) ;
    return 1;
}
// =============================================================================
CMD:second(playerid,params[])
{
    new ID;
    if ( !EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "The event is already closed." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    if ( sscanf ( params , "i", ID ) )return SendClientMessage ( playerid , -1 ,"{F81414}/Second [ ID ]" ) ;
    if ( !IsPlayerConnected ( ID ) )return SendClientMessage ( playerid , -1 , "{F81414}Player is not connected" ) ;
    if ( !TheEvenT [ ID ] )return SendClientMessage ( playerid , 0x00C0FFFF , "This player is not in the event." ) ;
    format ( iString2 , sizeof ( iString2 ) , "{FFFFFF}The second was placed {FF230A} %s ({FF230A}ID:%d{FFFFFF})!!!", GetPName ( playerid ) , playerid ) ;
    SendClientMessageToAll ( -1 , iString2 ) ;
    SendClientMessage (ID , -1 , "You took second place and received R$ 2.500!" ) ;
    GivePlayerMoney ( ID , 2500 ) ;
    return 1;
}
// =============================================================================
CMD:third(playerid,params[])
{
    new ID;
    if ( !EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "The event is already closed." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    if ( sscanf ( params , "i", ID ) )return SendClientMessage ( playerid , -1 ,"{F81414}/Third [ ID ]" ) ;
    if ( !IsPlayerConnected ( ID ) )return SendClientMessage ( playerid , -1 , "{F81414}Player is not connected" ) ;
    if ( !TheEvenT [ ID ] )return SendClientMessage ( playerid , 0x00C0FFFF , "This player is not in the event." ) ;
    format ( iString2 , sizeof ( iString2 ) , "{FFFFFF}The third was placed {FF230A} %s ({FF230A}ID:%d{FFFFFF})!!!", GetPName ( playerid ) , playerid ) ;
    SendClientMessageToAll ( -1 , iString2 ) ;
    SendClientMessage ( ID , -1 , "You came in third place and received R$ 1.000!" ) ;
    GivePlayerMoney ( ID , 1000 ) ;
    return 1;
}
// =============================================================================
CMD:espawn(playerid)
{
    if ( !EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "The event is already closed." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    for ( new v , b = GetMaxPlayers(); v != b; v++ )
    {
        if ( TheEvenT [ v ] )
        {
            SpawnPlayer ( v ) ;
            ResetPlayerWeapons ( v ) ;
            format ( iString2 , sizeof ( iString2 ) , "The Admin {FF230A}%s{FFFFFF} ({FF230A}ID:%d{FFFFFF}) Gave spawn in every event {FF230A}Event", GetPName ( playerid ) , playerid ) ;
            SendClientMessageToAll ( -1 , iString2 ) ;
        }
    }
    return 1;
}
// =============================================================================
CMD:exitevent(playerid)
{
    if ( TheEvenT [ playerid ] == true )
    {
        new Float:Health;
        GetPlayerHealth ( playerid , Health ) ;
        if ( Health < 30.0 )return SendClientMessage ( playerid, 0xFF0000FF, "{F81414}[ERROR] Your life is too low." ) ;
        SpawnPlayer ( playerid ) ;
        ResetPlayerWeapons ( playerid ) ;
        TheEvenT [ playerid ] = false ;
        SetPlayerVirtualWorld ( playerid , 0 ) ;
        SetPlayerInterior ( playerid , 0 ) ;
        ResetPlayerWeapons ( playerid ) ;
        PlayerPlaySound ( playerid , 1057 , 0.0 , 0.0 , 0.0 ) ;
    }
    return 1;
}
// =============================================================================
CMD:esetweather(playerid,params[])
{
    if ( !EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "The event is already closed." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    new weather;
    if ( sscanf ( params ,"i" , weather ) ) return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}/Esetweather (weather)" ) ;
    foreach(Player, v)
    {
        if ( TheEvenT [ v ] )
        {
            SetPlayerWeather ( v , weather ) ;
        }
    }
    return 1;
}
// =============================================================================
CMD:event(playerid)
{
    if ( TheEvenT [ playerid ] == true ) return SendClientMessage ( playerid , 0x9FFF00FF , "{F81414}[ERROR]: You can not enter commands in event, type /ExitEvent out!" ) ;
    if ( !EvenTStats ) return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;
    new Float:Health;
    GetPlayerHealth ( playerid , Health ) ;
    if ( Health < 30.0 ) return SendClientMessage ( playerid, 0xFF0000FF, "{F81414}[ERROR] You can not teleport with little life." ) ;
    TheEvenT [ playerid ] = true ;
    ResetPlayerWeapons ( playerid ) ;
    format ( iString2 , sizeof ( iString2 ) , "{FFFFFF}' %s ' {F81414}It was for the event {FFFFFF}( /EVENT )", GetPName ( playerid ) ) ;
    SendClientMessageToAll ( 0x88FF9FFF , iString2 ) ;
    SetPlayerPos ( playerid , EventoPos [ 0 ] , EventoPos [ 1 ] , EventoPos [ 2 ] ) ;
    SetPlayerFacingAngle ( playerid , EventoPos [ 3 ] ) ;
    SetPlayerInterior ( playerid , EventoInt ) ;
    SetPlayerVirtualWorld ( playerid , EventoVW ) ;
    return 1;
}
// =============================================================================
CMD:ecar(playerid, params[])
{
    if ( !EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    new Modelo,Cor1,Cor2;
    if ( sscanf ( params , "ddd" , Modelo , Cor1 , Cor2 ) )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}/Ecar [ ID ] [ IDCOLOR1 ] [ IRCOLOR2 ]" ) ;
    new Float:CarPos[4], CarID;
    foreach(Player, v)
    {
        if ( TheEvenT [ v ] )
        {
            GetPlayerFacingAngle ( v , CarPos [ 3 ] ) ;
            GetPlayerPos ( v , CarPos [ 0 ] , CarPos [ 1 ] , CarPos [ 2 ] ) ;
            CarID = CreateVehicle ( Modelo , CarPos [ 0 ] +2 , CarPos [ 1 ] , CarPos [ 2 ] , CarPos [ 3 ] , Cor1 , Cor2 , 0x00C0FFFF ) ;
            LinkVehicleToInterior ( CarID , EventoInt ) ;
            SetVehicleVirtualWorld ( CarID , EventoVW ) ;
            PutPlayerInVehicle ( v , CarID , 0 ) ;
        }
    }
    return 1;
}
// =============================================================================
CMD:eweapon(playerid, params[])
{
    if ( !EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    new Arma,Municao;
    if ( sscanf ( params , "dd" , Arma , Municao ) )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}/Eweapon [ WEAPON ID ] [ AMMUNITION ]" ) ;
    foreach(Player, v)
    {
        if ( TheEvenT [ v ] )
        {
            GivePlayerWeapon ( v , Arma , Municao ) ;
        }
    }
    return 1;
}
// =============================================================================
CMD:earmour(playerid, params[])
{
    if ( !EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    new Float:Colete;
    if ( sscanf ( params , "f", Colete ) )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}/Earmor [ 0 - 100 ]" ) ;
    foreach(Player, v)
    {
        if ( TheEvenT [ v ] )
        {
            SetPlayerArmour ( v , Colete ) ;
        }
    }
    return 1;
}
// =============================================================================
CMD:ekitrun(playerid, params[])
{
    if ( !EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    foreach(Player, v)
    {
        if ( TheEvenT [ v ] )
        {
            GivePlayerWeapon( v , 22 , 150);
            GivePlayerWeapon( v , 26 , 150);
            GivePlayerWeapon( v , 28 , 150);
            ResetPlayerWeapons( v );
            GivePlayerWeapon( v , 22 , 150);
            GivePlayerWeapon( v , 26 , 150);
            GivePlayerWeapon( v , 28 , 150);
        }
    }
    return 1;
}
// =============================================================================
CMD:ereclife(playerid, params[])
{
    if ( !EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    if(EventoRecarregarLife == false)
    {
        EventoRecarregarLife = true;
        SendClientMessage(playerid, -1, "The players who kill in the event will have the life vest or restored");
    }  else  {
        EventoRecarregarLife = false;
        SendClientMessage(playerid,-1, "The players who kill in the event does not have the life vest or restored");
    }
    for ( new i, b = GetMaxPlayers(); i != b; i++ )
    {
        if ( TheEvenT [ i ] )
        {
            GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~r~TO KILL ALL RECHARGE LIFE AND ARMOUR!", 5000, 5);
        }
    }
    return 1;
}
// =============================================================================
CMD:ekitwalk(playerid, params[])
{
    if ( !EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    foreach(Player, v)
    {
        if ( TheEvenT [ v ] )
        {
            GivePlayerWeapon( v , 24 , 150);
            GivePlayerWeapon( v , 25 , 150);
            GivePlayerWeapon( v , 34 , 150);
            ResetPlayerWeapons( v );
            GivePlayerWeapon( v , 24 , 150);
            GivePlayerWeapon( v , 25 , 150);
            GivePlayerWeapon( v , 34 , 150);
        }
    }
    return 1;
}
// =============================================================================
CMD:ekitgrenades(playerid, params[])
{
    if ( !EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    foreach(Player, v)
    {
        if ( TheEvenT [ v ] )
        {
            GivePlayerWeapon( v , 16 , 250);
            ResetPlayerWeapons( v );
            GivePlayerWeapon( v , 16 , 250);
        }
    }
    return 1;
}
// =============================================================================
CMD:evw(playerid, params[])
{
    if ( !EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    new world;
    if ( sscanf ( params , "i" , world ) )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}/Evw [ World ]" ) ;
    foreach(Player, v)
    {
        if ( TheEvenT [ v ] )
        {
            SetPlayerVirtualWorld ( v , world ) ;
        }
    }
    return 1;
}
// =============================================================================
CMD:elife(playerid, params[])
{
    if ( !EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    new Float:Vida;
    if ( sscanf ( params , "f" , Vida ) )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}/Elife [ 0 - 100 ]" ) ;
    foreach(Player, v)
    {
        if ( TheEvenT [ v ] )
        {
            SetPlayerHealth ( v , Vida ) ;
        }
    }
    return 1;
}
// =============================================================================
CMD:count(playerid)
{
    if ( !EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    Count ( 5 ) ;
    return 1;
}
// =============================================================================
CMD:ekick(playerid, params[])
{
    if ( !EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    new ID;
    if ( sscanf ( params , "r" , ID ) )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}/Ekick [ ID ]" ) ;
    if ( !TheEvenT [ ID ] )return SendClientMessage ( playerid , 0x00C0FFFF , "This player is not in the event." ) ;
    SpawnPlayer ( ID ) ;
    SendClientMessage ( ID , 0x00C0FFFF , "[INFO]: You have been kicked from the event." ) ;
    TheEvenT [ ID ] = false ;
    return 1;
}
// =============================================================================
CMD:efreeze(playerid)
{
    if ( !EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    foreach(Player, v)
    {
        if ( TheEvenT [ v ] )
        {
            TogglePlayerControllable ( v , false ) ;
        }
    }
    return 1;
}
// =============================================================================
CMD:edefrost(playerid)
{
    if ( !EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    foreach(Player, v)
    {
        if ( TheEvenT [ v ] )
        {
            TogglePlayerControllable ( v , true ) ;
        }
    }
    return 1;
}
// =============================================================================
CMD:edisarm(playerid)
{
    if ( !EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "[ERROR]: The event is not open." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    foreach(Player, v)
    {
        if ( TheEvenT [ v ] )
        {
            ResetPlayerWeapons ( v ) ;
        }
    }
    return 1;
}
// =============================================================================
CMD:eventhidenick(playerid)
{
	if ( !EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "[ERROR]: The event is not open." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
	if(HideNick == false)
	{
	    HideNick = true;
	    SendClientMessage(playerid,-1,"{FFFFFF}- Info -{FF230A}The Nick's will be hidden in the event.");
	}
	else
	{
		HideNick = false;
	    SendClientMessage(playerid,-1,"{FFFFFF}- Info -{FF230A}The nick's will be hidden in the event.");
	}
	return 1;
}
// =============================================================================
CMD:eskin(playerid, params[])
{
    if ( !EvenTStats )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;
    if ( !IsPlayerAdmin ( playerid ) )return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    new Skin;
    if ( sscanf ( params , "d" , Skin ) )return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}/Eskin [ ID Skin ]" ) ;
    foreach(Player, v)
    {
        if ( TheEvenT [ v ] )
        {
            SetPlayerSkin ( v , Skin ) ;
        }
    }
    return 1;
}
// =============================================================================
CMD:ecmd(playerid, params[])
{
    if ( !IsPlayerAdmin ( playerid ) ) return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    new EvenTHelP[1450];
    strcat(EvenTHelP,"{FFFFFF}======================================================================\n");
    strcat(EvenTHelP,"{c6a65a}Commands Event\n");
    strcat(EvenTHelP,"{c6a65a}/evw {FFFFFF}Arrow In the Virtual World All In Event.\n");
    strcat(EvenTHelP,"{c6a65a}/openevent {FFFFFF}Opens the Event.\n");
    strcat(EvenTHelP,"{c6a65a}/event {FFFFFF}Going To The Event\n{c6a65a}/Eventhidenick {FFFFFF}The nick's will be hidden in the event");
    strcat(EvenTHelP,"{c6a65a}/frist /second /third {FFFFFF}To give the reward to the first second and third place\n");
    strcat(EvenTHelP,"{c6a65a}/Esetweather {FFFFFF}To set the mood of everyone at the event.\n");
    strcat(EvenTHelP,"{c6a65a}/ecar {FFFFFF}Create a Car For Every Event.\n");
    strcat(EvenTHelP,"{c6a65a}/espawn {FFFFFF}To be reborn every event.\n");
    strcat(EvenTHelP,"{c6a65a}/efinish {FFFFFF}To finalize the ongoing event.\n");
    strcat(EvenTHelP,"{c6a65a}/eweapon {FFFFFF}Of a Weapon For All Event.\n");
    strcat(EvenTHelP,"{c6a65a}/earmour {FFFFFF}The Armour For All Event.\n");
    strcat(EvenTHelP,"{c6a65a}/elife {FFFFFF}The Life For All Event\n");
    strcat(EvenTHelP,"{c6a65a}/Count {FFFFFF}Start a Countdown\n{c6a65a}/ekick {FFFFFF}Kicks a Player Event\n");
    strcat(EvenTHelP,"{c6a65a}/efreeze {FFFFFF}Freezes The Player In The Event\n{c6a65a}/edefrost Unfreeze The Player At The Event\n");
    strcat(EvenTHelP,"{c6a65a}/edisarm {FFFFFF}Disarms All Event\n{c6a65a}/eskin {FFFFFF}Arrow The Skin Of Everyone At The Event\n");
    strcat(EvenTHelP,"{c6a65a}/eclose {FFFFFF}Finalize The Event\n{c6a65a}/ekitrun {FFFFFF}Of One Kit Running (Weapons Id > 22 , 26 , 28 < )\n{c6a65a}/ekitwalk {FFFFFF}Of One Kit Walking (Weapons Id > 24 , 25 , 34 < )\n");
    strcat(EvenTHelP,"{c6a65a}/ekitgrenades {FFFFFF}Of One Grenades\n{c6a65a}/ereclife {FFFFFF}To Kill And Recover Life And Armour\n{c6a65a}/exitevent {FFFFFF}To exit the event");
    strcat(EvenTHelP,"{FFFFFF}======================================================================\n");
    ShowPlayerDialog(playerid,7897,DIALOG_STYLE_MSGBOX,"{FFFF00}Help Event",EvenTHelP,"Fechar","");
    strdel(EvenTHelP,0,sizeof(EvenTHelP));
    return 1;
}
// =============================================================================
public Count(Contagem)
{
    format ( iString2 , 3 , "%d" , Contagem ) ;
    if ( Contagem > 0 )
    {
        GameTextForAll ( iString2 , 700 , 5 ) ;
        SetTimerEx ( "Count" , 1000 , false , "i" , Contagem-1 ) ;
    }
    else GameTextForAll ( "~r~Go Go Go!" , 1000 , 5 ) ;
}
// =============================================================================
stock GetPName ( playerid )
{
    new gName [ MAX_PLAYER_NAME ] ;
    GetPlayerName ( playerid , gName , sizeof gName ) ;
    return gName;
}
// =============================================================================
stock GivePlayerScore(playerid, score)
{
	SetPlayerScore(playerid, GetPlayerScore(playerid)+score);
	return 1;
}