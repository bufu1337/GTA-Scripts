#include <a_samp>
#include <zcmd>
#include <sscanf2>
new bool:EvenTStats;
new bool:TheEvenT[ MAX_PLAYERS ];
new Float:EventoPos [ 4 ];
new EventoInt;
new EventoVW;
new bool:EventoRecarregarLife = false;
new iString2[130];
new ColorsNicks [ 51 ] ={
	0xFF8C13AA,0xC715FFAA,0x20B2AAAA,0xDC143CAA,0x6495EDAA,
	0xf0e68cAA,0x778899AA,0xFF1493AA,0xF4A460AA,0xEE82EEAA,
	0xFFD720AA,0x8b4513AA,0x4949A0AA,0x148b8bAA,0x14ff7fAA,
	0x556b2fAA,0x0FD9FAAA,0x10DC29AA,0x534081AA,0x0495CDAA,
	0xEF6CE8AA,0xBD34DAAA,0x247C1BAA,0x0C8E5DAA,0x635B03AA,
	0xCB7ED3AA,0x65ADEBAA,0x5C1ACCAA,0xF2F853AA,0x11F891AA,
	0x7B39AAAA,0x53EB10AA,0x54137DAA,0x275222AA,0xF09F5BAA,
	0x3D0A4FAA,0x22F767AA,0xD63034AA,0x9A6980AA,0xDFB935AA,
	0x3793FAAA,0x90239DAA,0xE9AB2FAA,0xAF2FF3AA,0x057F94AA,
	0xB98519AA,0x388EEAAA,0x028151AA,0xA55043AA,0x1A30BFAA
};
new VehicleNames [ 212 ] [ ] ={
	"Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus" , "Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat","Mr Whoopee","BF Injection",
	"Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie" , "Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
	"Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider" , "Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3 50","Walton","Regina",
	"Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo","Greenwood" , "Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa","RC Goblin","Hotring Racer A","Hotring Racer B",
	"Bloodring Banger","Rancher","Super GT","Elegant","Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain" , "Nebula","Majestic","Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover" , "Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A",
	"Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight","Trailer" , "Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer A","Emperor",
	"Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)" , "Police Car (LVPD)","Police Ranger","Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
	"Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};
#define version                                                                 "0.4"
forward Count(Contagem);
public OnPlayerConnect(playerid){
	return TheEvenT [ playerid ] = false ;
}
public OnPlayerDisconnect(playerid, reason){
	return TheEvenT [ playerid ] = false ;
}
public OnPlayerSpawn(playerid){
	return TheEvenT [ playerid ] = false ;
}
public OnPlayerStateChange(playerid, newstate, oldstate){
	if ( newstate == PLAYER_STATE_DRIVER && oldstate != PLAYER_STATE_DRIVER )	{
		new str [ 50 ] ;
		format ( str , sizeof ( str ) , "~r~%s" , VehicleNames [ GetVehicleModel ( GetPlayerVehicleID ( playerid ) ) -400 ] ) ;
		GameTextForPlayer ( playerid , str , 6000 , 1 ) ;
	}
	return 1;
}
public OnPlayerDeath(playerid, killerid, reason){
    TheEvenT [ playerid ] = false ;
    for ( new v , b = GetMaxPlayers(); v != b; v++ ){
    	if ( TheEvenT [ v ] ){
    		format ( iString2 , sizeof ( iString2 ) , "{FFFFFF}The Player {FF230A}%s{FFFFFF}({FF230A}ID:%d{FFFFFF}) Died in the event.", GetPName ( playerid ) , playerid ) ;
    		SendClientMessageToAll ( -1 , iString2 ) ;
    		SendDeathMessage ( killerid , playerid , reason ) ;
		}
	}
    return 1;
}
CMD:openevent(playerid){
    if ( EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "The event is already open." ) ;

    if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;

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
CMD:eclose(playerid){
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "The event is already closed." ) ;

    if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;

    for ( new v , b = GetMaxPlayers(); v != b; v++ ){
    	if ( TheEvenT [ v ] ){
			TheEvenT [ v ] = true ;
			EvenTStats = false ;
		}
	}
    return 1;
}
CMD:frist(playerid,params[]){
    new ID;
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "The event is already closed." ) ;

   	if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;

    if ( sscanf ( params , "i", ID ) )
		return SendClientMessage ( playerid , -1 ,"{F81414}/Frist [ ID ]" ) ;

    if ( !IsPlayerConnected ( ID ) )
		return SendClientMessage ( playerid , -1 , "{F81414}Player is not connected" ) ;

    if ( !TheEvenT [ ID ] )
        return SendClientMessage ( playerid , 0x00C0FFFF , "This player is not in the event." ) ;

    format ( iString2 , sizeof ( iString2 ) , "{FFFFFF}The first was placed {FF230A} %s ({FF230A}ID:%d{FFFFFF})!!!", GetPName ( playerid ) , playerid ) ;
    SendClientMessageToAll ( -1 , iString2 ) ;

    SendClientMessage ( ID , -1 , "You took first place and received R$ 5.000!" ) ;
    GivePlayerMoney ( ID , 5000 ) ;
    return 1;
}
CMD:second(playerid,params[]){
    new ID;
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "The event is already closed." ) ;
   	if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    if ( sscanf ( params , "i", ID ) )
		return SendClientMessage ( playerid , -1 ,"{F81414}/Frist [ ID ]" ) ;
    if ( !IsPlayerConnected ( ID ) )
		return SendClientMessage ( playerid , -1 , "{F81414}Player is not connected" ) ;
    if ( !TheEvenT [ ID ] )
        return SendClientMessage ( playerid , 0x00C0FFFF , "This player is not in the event." ) ;
    format ( iString2 , sizeof ( iString2 ) , "{FFFFFF}The second was placed {FF230A} %s ({FF230A}ID:%d{FFFFFF})!!!", GetPName ( playerid ) , playerid ) ;
    SendClientMessageToAll ( -1 , iString2 ) ;
    SendClientMessage (ID , -1 , "You took second place and received R$ 2.500!" ) ;
    GivePlayerMoney ( ID , 2500 ) ;
    return 1;
}
CMD:third(playerid,params[]){
    new ID;
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "The event is already closed." ) ;
   	if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    if ( sscanf ( params , "i", ID ) )
		return SendClientMessage ( playerid , -1 ,"{F81414}/Frist [ ID ]" ) ;
    if ( !IsPlayerConnected ( ID ) )
		return SendClientMessage ( playerid , -1 , "{F81414}Player is not connected" ) ;
    if ( !TheEvenT [ ID ] )
        return SendClientMessage ( playerid , 0x00C0FFFF , "This player is not in the event." ) ;
    format ( iString2 , sizeof ( iString2 ) , "{FFFFFF}The third was placed {FF230A} %s ({FF230A}ID:%d{FFFFFF})!!!", GetPName ( playerid ) , playerid ) ;
    SendClientMessageToAll ( -1 , iString2 ) ;
    SendClientMessage ( ID , -1 , "You came in third place and received R$ 1.000!" ) ;
    GivePlayerMoney ( ID , 1000 ) ;
    return 1;
}
CMD:espawn(playerid){
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "The event is already closed." ) ;

    if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;

    for ( new v , b = GetMaxPlayers(); v != b; v++ ){
    	if ( TheEvenT [ v ] ){
			SpawnPlayer ( v ) ;
       		ResetPlayerWeapons ( v ) ;
       		format ( iString2 , sizeof ( iString2 ) , "The Admin {FF230A}%s{FFFFFF} ({FF230A}ID:%d{FFFFFF}) Gave spawn in every event {FF230A}Event", GetPName ( playerid ) , playerid ) ;
      		SendClientMessageToAll ( -1 , iString2 ) ;
		}
	}
    return 1;
}
CMD:exitevent(playerid){
	if ( TheEvenT [ playerid ] == true ){
	    new Float:Health;
    	GetPlayerHealth ( playerid , Health ) ;
    	if ( Health < 30.0 )
        	return SendClientMessage ( playerid, 0xFF0000FF, "{F81414}[ERROR] Your life is too low." ) ;

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
CMD:esetweather(playerid,params[]){
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "The event is already closed." ) ;
    if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
	new	weather;
	if ( sscanf ( params ,"i" , weather ) )
		return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}/Esetweather (weather)" ) ;
    for ( new v, b = GetMaxPlayers(); v != b; v++ ){
        if ( TheEvenT [ v ] ){
			SetPlayerWeather ( v , weather ) ;
		}
	}
	return 1;
}
CMD:event(playerid){
	if ( TheEvenT [ playerid ] == true )
		return SendClientMessage ( playerid , 0x9FFF00FF , "{F81414}[ERROR]: You can not enter commands in event, type /ExitEvent out!" ) ;
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;
    new Float:Health;
    GetPlayerHealth ( playerid , Health ) ;
    if ( Health < 30.0 )
        return SendClientMessage ( playerid, 0xFF0000FF, "{F81414}[ERROR] You can not teleport with little life." ) ;
    TheEvenT [ playerid ] = true ;
    ResetPlayerWeapons ( playerid ) ;
    format ( iString2 , sizeof ( iString2 ) , "{FFFFFF}' %s ' {F81414}It was for the event {FFFFFF}( /EVENT )", GetPName ( playerid ) ) ;
    SendClientMessageToAll ( 0x88FF9FFF , iString2 ) ;
    SetPlayerPos ( playerid , EventoPos [ 0 ] , EventoPos [ 1 ] , EventoPos [ 2 ] ) ;
    SetPlayerFacingAngle ( playerid , EventoPos [ 3 ] ) ;
    SetPlayerInterior ( playerid , EventoInt ) ;
    SetPlayerVirtualWorld ( playerid , EventoVW ) ;
    SetPlayerColor ( playerid , ColorsNicks [ playerid ] ) ;
    return 1;
}
CMD:ecar(playerid, params[]){
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;
    if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    new
        Modelo,
        Cor1,
        Cor2;

    if ( sscanf ( params , "ddd" , Modelo , Cor1 , Cor2 ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}/Ecar [ ID ] [ IDCOLOR1 ] [ IRCOLOR2 ]" ) ;
    new Float:CarPos[4], CarID;
    for ( new v, b = GetMaxPlayers(); v != b; v++ ){
        if ( TheEvenT [ v ] ){
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
CMD:eweapon(playerid, params[]){
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;
    if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    new
        Arma,
        Municao
    ;
    if ( sscanf ( params , "dd" , Arma , Municao ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}/Eweapon [ WEAPON ID ] [ AMMUNITION ]" ) ;
    for ( new v, b = GetMaxPlayers(); v != b; v++ ){
        if ( TheEvenT [ v ] ){
            GivePlayerWeapon ( v , Arma , Municao ) ;
        }
    }
    return 1;
}
CMD:earmour(playerid, params[]){
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;

    if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;

    new Float:Colete;
    if ( sscanf ( params , "f", Colete ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}/Earmor [ 0 - 100 ]" ) ;

    for ( new v, b = GetMaxPlayers(); v != b; v++ ){
        if ( TheEvenT [ v ] ){
            SetPlayerArmour ( v , Colete ) ;
        }
    }
    return 1;
}
CMD:ekitrun(playerid, params[]){
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;

    if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;

    for ( new v, b = GetMaxPlayers(); v != b; v++ ){
        if ( TheEvenT [ v ] ){
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
CMD:ereclife(playerid, params[]){
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;

    if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;

    if(EventoRecarregarLife == false){
        EventoRecarregarLife = true;
        SendClientMessage(playerid, -1, "The players who kill in the event will have the life vest or restored");
    }
	else {
        EventoRecarregarLife = false;
        SendClientMessage(playerid,-1, "The players who kill in the event does not have the life vest or restored");
    }
    for ( new i, b = GetMaxPlayers(); i != b; i++ ){
        if ( TheEvenT [ i ] ){
            GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~r~TO KILL ALL RECHARGE LIFE AND ARMOUR!", 5000, 5);
        }
    }
    return 1;
}
CMD:ekitwalk(playerid, params[]){
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;

    if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;

    for ( new v, b = GetMaxPlayers(); v != b; v++ ){
        if ( TheEvenT [ v ] ){
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
CMD:ekitgrenades(playerid, params[]){
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;

    if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;

    for ( new v, b = GetMaxPlayers(); v != b; v++ ){
        if ( TheEvenT [ v ] ){
            GivePlayerWeapon( v , 16 , 250);
            ResetPlayerWeapons( v );
            GivePlayerWeapon( v , 16 , 250);
        }
    }
    return 1;
}
CMD:evw(playerid, params[]){
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;

    if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;

    new world;
    if ( sscanf ( params , "i" , world ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}/Evw [ World ]" ) ;

    for ( new v, b = GetMaxPlayers(); v != b; v++ ){
        if ( TheEvenT [ v ] ){
            SetPlayerVirtualWorld ( v , world ) ;
        }
    }
    return 1;
}
CMD:elife(playerid, params[]){
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;

    if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;

    new Float:Vida;
    if ( sscanf ( params , "f" , Vida ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}/Elife [ 0 - 100 ]" ) ;

    for ( new v, b = GetMaxPlayers(); v != b; v++ ){
        if ( TheEvenT [ v ] ){
            SetPlayerHealth ( v , Vida ) ;
        }
    }
    return 1;
}
CMD:count(playerid){
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;

    if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;

    Count ( 5 ) ;
    return 1;
}
CMD:ekick(playerid, params[]){
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;

    if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;

    new ID;
    if ( sscanf ( params , "r" , ID ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}/Ekick [ ID ]" ) ;

    if ( !TheEvenT [ ID ] )
        return SendClientMessage ( playerid , 0x00C0FFFF , "This player is not in the event." ) ;

    SpawnPlayer ( ID ) ;
    SendClientMessage ( ID , 0x00C0FFFF , "[INFO]: You have been kicked from the event." ) ;
    TheEvenT [ ID ] = false ;
    return 1;
}
CMD:efreeze(playerid){
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;

    if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;

    for ( new v, b = GetMaxPlayers(); v != b; v++ ){
        if ( TheEvenT [ v ] ){
            TogglePlayerControllable ( v , false ) ;
        }
    }
    return 1;
}
CMD:edefrost(playerid){
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;

    if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;

    for ( new v, b = GetMaxPlayers(); v != b; v++ ){
        if ( TheEvenT [ v ] ){
            TogglePlayerControllable ( v , true ) ;
        }
    }
    return 1;
}
CMD:edisarm(playerid){
    if ( !EvenTStats )
		return SendClientMessage ( playerid , 0x00C0FFFF , "[ERROR]: The event is not open." ) ;

    if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;

    for ( new v, b = GetMaxPlayers(); v != b; v++ ){
        if ( TheEvenT [ v ] ){
            ResetPlayerWeapons ( v ) ;
        }
    }
    return 1;
}
CMD:eskin(playerid, params[]){
    if ( !EvenTStats )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}[ERROR]: The event is not open." ) ;

    if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;

    new Skin;
    if ( sscanf ( params , "d" , Skin ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "{F81414}/Eskin [ ID Skin ]" ) ;

    for ( new v, b = GetMaxPlayers(); v != b; v++ ){
        if ( TheEvenT [ v ] ){
            SetPlayerSkin ( v , Skin ) ;
        }
    }
    return 1;
}
CMD:ecmd(playerid, params[]){
    if ( !IsPlayerAdmin ( playerid ) )
        return SendClientMessage ( playerid , 0x00C0FFFF , "You can not use this command..") ;
    new EvenTHelP[1450];
    strcat(EvenTHelP,"{FFFFFF}======================================================================\n");
	strcat(EvenTHelP,"{c6a65a}Commands Event\n");
	strcat(EvenTHelP,"{c6a65a}/evw {FFFFFF}Arrow In the Virtual World All In Event.\n");
	strcat(EvenTHelP,"{c6a65a}/openevent {FFFFFF}Opens the Event.\n");
	strcat(EvenTHelP,"{c6a65a}/event {FFFFFF}Going To The Event\n");
	strcat(EvenTHelP,"{c6a65a}/frist /second /third {FFFFFF}To give the reward to the first second and third place\n");
	strcat(EvenTHelP,"{c6a65a}/Esetweather {FFFFFF}To set the mood of everyone at the event.\n");
	strcat(EvenTHelP,"{c6a65a}/ecar {FFFFFF}Create a Car For Every Event.\n");
	strcat(EvenTHelP,"{c6a65a}/espawn {FFFFFF}To be reborn every event.\n");
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
public Count(Contagem){
    format ( iString2 , 3 , "%d" , Contagem ) ;
    if ( Contagem > 0 ){
        GameTextForAll ( iString2 , 700 , 5 ) ;
        SetTimerEx ( "Count" , 1000 , false , "i" , Contagem-1 ) ;
    }
    else GameTextForAll ( "~r~Go Go Go!" , 1000 , 5 ) ;
}
stock GetPName ( playerid ){
	new gName [ MAX_PLAYER_NAME ] ;
	GetPlayerName ( playerid , gName , sizeof gName ) ;
	return gName;
}