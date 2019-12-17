//
//  PowerSprunk FS by dock (aliases: Tika Spic, xdrive)
//

#include <a_samp>
#include <zcmd>
#include <streamer>
#include <dini>

#define SPRUNK_LOCATION    "PowerSprunk/%d.ini"
#define DISABLED_SPRUNK_MESSAGE     "Damn, the machine ate my dolar, looks like it's broken..."
#define SPRUNK_DEF  100 // DISABLED SPRUNKS + DYNAMIC SPRUNKS
#define OLD_SPRUNK_MODEL  	955
#define NEW_SPRUNK_MODEL  	1775
#define USED_SPRUNK_MODEL   NEW_SPRUNK_MODEL //Will use a new sprunk model (redifine as you see fit)
#define DIALOG_SPRUNK_ID    7899 //Redifine if it matches a dialog id in your script
#define DYNAMIC_SPRUNK_COST		10 // Cost of using a dynamic sprunk
#define DISABLED_SPRUNK_HP   	35.0 // How much a regular sprunk heals (if disabled how much to remove hp after using)
#define DYNAMIC_SPRUNK_HP    	35.0 // How much the dynamic sprunks are gonna heal

#define COLOR_RED   	0xff0000ff
#define COLOR_YELLOW    0xffff00ff
#define COLOR_WHITE     0xffffffff
#define COLOR_GREEN     0x00ff00ff

forward LoadSprunks();
forward SaveSprunks();
forward Sprunk_AntiFlood( playerid );
forward Dyn_Sprunk_AntiFlood( playerid );
forward Vending( playerid, count );

enum sprunkInfo {
	sUsed,
	sDisabled,
	sDynamic,
	Float:sX,
	Float:sY,
	Float:sZ,
	Float:sModelx,
	Float:sModely,
	Float:sModelz,
	Float:sRotx,
	Float:sRoty,
	Float:sRotz,
	sCID
}; new SI[ SPRUNK_DEF ][ sprunkInfo ];

new sprunk[MAX_PLAYERS];
new dynspid[MAX_PLAYERS];
new Float:primarypos[MAX_PLAYERS][6];
new bool:DYNAMIC_SPRUNK_HEAL = true; // Set to false if you don't want the dynamic sprunks to heal!

public LoadSprunks() {
	new file[ 32 ];
	for( new s = 0; s < SPRUNK_DEF; s++ ) {
		format( file, sizeof( file ), SPRUNK_LOCATION, s );
		if( fexist( file ) ) {
		    SI[ s ][ sUsed ] = 1;
		    SI[ s ][ sDisabled ] = dini_Int( file, "sDisabled" );
		    SI[ s ][ sDynamic ] = dini_Int( file, "sDynamic" );
		    SI[ s ][ sX ] = dini_Float( file, "sX" );
		    SI[ s ][ sY ] = dini_Float( file, "sY" );
		    SI[ s ][ sZ ] = dini_Float( file, "sZ" );
		    SI[ s ][ sModelx ] = dini_Float( file, "sModelx" );
		    SI[ s ][ sModely ] = dini_Float( file, "sModely" );
		    SI[ s ][ sModelz ] = dini_Float( file, "sModelz" );
		    SI[ s ][ sRotx ] = dini_Float( file, "sRotx" );
		    SI[ s ][ sRoty ] = dini_Float( file, "sRoty" );
		    SI[ s ][ sRotz ] = dini_Float( file, "sRotz" );
		    if( SI[ s ][ sDisabled ] == 0 && SI[ s ][ sDynamic ] == 1 ) {
		        SI[ s ][ sCID ] = CreateDynamicObject( USED_SPRUNK_MODEL, SI[ s ][ sModelx ], SI[ s ][ sModely ], SI[ s ][ sModelz ], SI[ s ][ sRotx ], SI[ s ][ sRoty ], SI[ s ][ sRotz ] );
		    }
		}
	}
	return 1;
}
public SaveSprunks() {
	new file[ 32 ];
	for( new s = 0; s < SPRUNK_DEF; s++ ) {
	    if( SI[ s ][ sUsed ] == 1 ) {
	        format( file, sizeof( file ), SPRUNK_LOCATION, s );
	        if( !fexist( file ) ) dini_Create( file );
	        dini_IntSet( file, "sDisabled", SI[ s ][ sDisabled ] );
	        dini_IntSet( file, "sDynamic", SI[ s ][ sDynamic ] );
	        dini_FloatSet( file, "sX", SI[ s ][ sX ] );
	        dini_FloatSet( file, "sY", SI[ s ][ sY ] );
	        dini_FloatSet( file, "sZ", SI[ s ][ sZ ] );
	        dini_FloatSet( file, "sModelx", SI[ s ][ sModelx ] );
	        dini_FloatSet( file, "sModely", SI[ s ][ sModely ] );
	        dini_FloatSet( file, "sModelz", SI[ s ][ sModelz ] );
	        dini_FloatSet( file, "sRotx", SI[ s ][ sRotx ] );
	        dini_FloatSet( file, "sRoty", SI[ s ][ sRoty ] );
	        dini_FloatSet( file, "sRotz", SI[ s ][ sRotz ] );
	    }
	    else {
	        format( file, sizeof( file ), SPRUNK_LOCATION, s );
	        if( fexist( file ) ) fremove( file );
	    }
	}
	return 1;
}
public Vending( playerid, count ) {
	if( count == 1 ) {
	    ApplyAnimation( playerid, "VENDING", "VEND_Use_pt2", 4.1, 0, 0, 0, 1, 1 );
	    SetTimerEx( "Vending", 300, false, "dd", playerid, 2 );
	}
	else if( count == 2 ) {
	    ApplyAnimation( playerid, "VENDING", "VEND_Drink_P", 4.1, 0, 0, 0, 1, 1 );
	    SetTimerEx( "Vending", 1250, false, "dd", playerid, 3 );
	}
	else if( count == 3 ) {
	    ApplyAnimation( playerid, "PED", "endchat_01", 4.1, 0, 0, 0, 0, 1, 1 );
	    if( DYNAMIC_SPRUNK_HEAL ) {
			new Float:hp;
			GetPlayerHealth( playerid, hp );
			SetPlayerHealth( playerid, hp + DYNAMIC_SPRUNK_HP );
		}
	}
	return 1;
}
public Sprunk_AntiFlood( playerid ) {
	SetPVarInt( playerid, "SPRUNK_FLOOD", 0 );
	return 1;
}
public Dyn_Sprunk_AntiFlood( playerid ) {
	SetPVarInt( playerid, "DYN_SPRUNK_FLOOD", 0 );
	return 1;
}

public OnFilterScriptInit(){
	print("PowerSprunk by dock v0.1 - Filterscript loaded");
	LoadSprunks();
	return 1;
}
public OnFilterScriptExit(){
	SaveSprunks();
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
	if( GetPlayerState( playerid ) == PLAYER_STATE_ONFOOT ) {
		if( newkeys & KEY_SECONDARY_ATTACK ) {
		    for( new s = 0; s < SPRUNK_DEF; s++ ) {
		        if( SI[ s ][ sUsed ] == 1 && SI[ s ][ sDynamic ] == 1) {
		            if( IsPlayerInRangeOfPoint( playerid, 1.0, SI[ s ][ sX ], SI[ s ][ sY ], SI[ s ][ sZ ] ) ) {
						if( GetPVarInt( playerid, "DYN_SPRUNK_FLOOD" ) == 0 ){
				            playPlayerSprunkAnim( playerid );
				            GivePlayerMoney( playerid, -DYNAMIC_SPRUNK_COST );
				            SetPVarInt( playerid, "DYN_SPRUNK_FLOOD", 1 );
				            SetTimerEx( "Dyn_Sprunk_AntiFlood", 5000, false, "d", playerid ); // To avoid spamming at the machine
			            	return 1;
						}
					}
		        }
		    }
		}
	}
	if( GetPVarInt( playerid, "USED_SPRUNK" ) == 0 ) {
        new Float:curhp; GetPlayerHealth( playerid, curhp );
		SetPVarFloat( playerid, "SPRUNK_HP", curhp );
		if( GetPlayerState( playerid ) == PLAYER_STATE_ONFOOT ) { // Checks if the player is on foot (in order to use a sprunk)
			if( newkeys & KEY_SECONDARY_ATTACK ) { // Checks if the player used the key for the sprunk
				if( GetPlayerAnimationIndex( playerid ) != 0 ) { // They don't match (he started using a sprunk)
					for( new s = 0; s < SPRUNK_DEF; s++ ) {
					    if( IsPlayerInRangeOfPoint( playerid, 1.0, SI[ s ][ sX ], SI[ s ][ sY ], SI[ s ][ sZ ] ) ) {
						    if( SI[ s ][ sDisabled ] == 1 ) {
						        TogglePlayerControllable( playerid, true ); //Freezes him..
						        SetPVarInt( playerid, "USED_SPRUNK", 1 );
						        if( GetPVarInt( playerid, "SPRUNK_FLOOD" ) == 0 ) {
									new string[ 128 ];
									format(string, sizeof( string ), "%s: "DISABLED_SPRUNK_MESSAGE"", getName( playerid ) );
									SendClientMessage( playerid, COLOR_WHITE, string );
									SetPVarInt( playerid, "SPRUNK_FLOOD", 1 );
									SetTimerEx( "Sprunk_AntiFlood", 3000, false, "d", playerid ); // To avoid spamming at the machine
								}
						    }
						}
					}
				}
			}
		}
	}
	else if( GetPVarInt( playerid, "USED_SPRUNK") == 1 ) {
	    if( GetPlayerState( playerid ) == PLAYER_STATE_ONFOOT ) { // Checks if the player is on foot (in order to use a sprunk)
	        if( oldkeys & KEY_SECONDARY_ATTACK ) {
	            SetPVarInt( playerid, "USED_SPRUNK", 0 );
	            SetPlayerHealth( playerid, GetPVarFloat( playerid, "SPRUNK_HP" ) );
	        }
	    }
	}
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]){
	if( dialogid == DIALOG_SPRUNK_ID ) {
	    if( response ) {
	        new idx = strval( inputtext );
	        if( SI[ idx ][ sUsed ] == 1 && SI[ idx ][ sDynamic ] == 1 ) {
	            new Float:x, Float:y, Float:z;
	            GetPlayerPos( playerid, x, y, z );
	            SI[ idx ][ sX ] = x;
	            SI[ idx ][ sY ] = y;
	            SI[ idx ][ sZ ] = z;
	            new string[ 128 ];
			    format( string, sizeof( string ), " > You have set the dynamic sprunk drink location to: [ %.4f ][ %.4f ][ %.4f ]! Sprunk ID:[ %d ]", x, y, z, idx );
			    SendClientMessage( playerid, COLOR_YELLOW, string );
	        }
	        else SendClientMessage( playerid, COLOR_RED, " > Invalid dynamic sprunk id! Use /checksprunk for the correct id!" );
	    }
	}
	return 1;
}
public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) {
	new idx = dynspid[ playerid ];
	if(objectid == SI[ idx ][ sCID ]) {
	    if( response ) {
			SI[ idx ][ sModelx ] = x;
			SI[ idx ][ sModely ] = y;
			SI[ idx ][ sModelz ] = z;
			SI[ idx ][ sRotx ] = rx;
			SI[ idx ][ sRoty ] = ry;
			SI[ idx ][ sRotz ] = rz;
	    }
	    else if( !response ) {
	        SendClientMessage( playerid, COLOR_RED, " > You canceled the sprunk edit!" );
	        MoveDynamicObject( SI[ idx ][ sCID ], primarypos[ playerid ][ 0 ], primarypos[ playerid ][ 1 ], primarypos[ playerid ][ 2 ], 20,  primarypos[ playerid ][ 3 ],  primarypos[ playerid ][ 4 ],  primarypos[ playerid ][ 5 ] );
	    }
	}
	return 1;
}

stock getName( playerid ) {
	new name[ MAX_PLAYER_NAME ];
	GetPlayerName( playerid, name, sizeof( name ) );
	return name;
}
stock playPlayerSprunkAnim( playerid ) {
    ApplyAnimation( playerid, "VENDING", "VEND_Use", 4.1, 0, 1, 0, 1, 1 );
	SetTimerEx( "Vending", 2300, false, "dd", playerid, 1 );
	return 1;
}

CMD:disablesprunk( playerid, params[] ) { //Use for ingame sprunks
	if( !IsPlayerAdmin( playerid ) ) return SendClientMessage( playerid, COLOR_RED, " > You are not allowed to use this command!" );
	new Float:x, Float:y, Float:z;
	GetPlayerPos( playerid, x, y, z );
	new idx = -1;
	for( new i = 0; i < SPRUNK_DEF; i++ ) {
	    if( SI[ i ][ sUsed ] == 0 ) {
	        idx = i;
	        break;
	    }
	}
	if( idx == -1 ) return SendClientMessage( playerid, COLOR_RED, " > Maximum amount of sprunk disables/dynamic creations has been made!" );
	else {
	    SI[ idx ][ sUsed ] = 1;
	    SI[ idx ][ sDisabled ] = 1;
	    SI[ idx ][ sX ] = x;
	    SI[ idx ][ sY ] = y;
	    SI[ idx ][ sZ ] = z;
	    new string[ 128 ];
	    format( string, sizeof( string ), " > You have disabled the stock sprunk at the position: [ %.4f ][ %.4f ][ %.4f ]!", x, y, z );
	    SendClientMessage( playerid, COLOR_YELLOW, string );
	}
	return 1;
}
CMD:createsprunk( playerid, params[] ) {
    if( !IsPlayerAdmin( playerid ) ) return SendClientMessage( playerid, COLOR_RED, " > You are not allowed to use this command!" );
    new idx = -1;
	for( new i = 0; i < SPRUNK_DEF; i++ ) {
	    if( SI[ i ][ sUsed ] == 0 ) {
	        idx = i;
	        break;
	    }
	}
	new Float:x, Float:y, Float:z;
	GetPlayerPos( playerid, x, y, z );
	sprunk[ playerid ] = CreateDynamicObject( USED_SPRUNK_MODEL, x, y+2, z, 0, 0, 0 );
	SI[ idx ][ sUsed ] = 1;
	SI[ idx ][ sDynamic ] = 1;
	SI[ idx ][ sModelx ] = x;
	SI[ idx ][ sModely ] = y+2;
	SI[ idx ][ sModelz ] = z;
	SI[ idx ][ sRotx ] = 0;
	SI[ idx ][ sRoty ] = 0;
	SI[ idx ][ sRotz ] = 0;
	SI[ idx ][ sCID ] = sprunk[ playerid ];
	new string[ 128 ];
    format( string, sizeof( string ), " > You have created a sprunk at the position: [ %.4f ][ %.4f ][ %.4f ]! Sprunk id: [ %d ]", x, y+2, z, idx );
    SendClientMessage( playerid, COLOR_YELLOW, string );
    SendClientMessage( playerid, COLOR_YELLOW, " > Use /setsprunk to set the drinking location for the new sprunk after you finish repositioning!" );
	dynspid[ playerid ] = idx;
	primarypos[ playerid ][ 0 ] = x;
	primarypos[ playerid ][ 1 ] = y+2;
	primarypos[ playerid ][ 2 ] = z;
	primarypos[ playerid ][ 3 ] = 0;
	primarypos[ playerid ][ 4 ] = 0;
	primarypos[ playerid ][ 5 ] = 0;
	EditDynamicObject( playerid, sprunk[ playerid ] );
	return 1;
}
CMD:setsprunk( playerid, params[] ) {
    if( !IsPlayerAdmin( playerid ) ) return SendClientMessage( playerid, COLOR_RED, " > You are not allowed to use this command!" );
    ShowPlayerDialog( playerid, DIALOG_SPRUNK_ID, DIALOG_STYLE_INPUT, "Sprunk ID", "Input the sprunk id for the dynamic sprunk you want to use here!", "Done", "Cancel" );
    return 1;
}
CMD:editsprunk( playerid, params[] ) {
    if( !IsPlayerAdmin( playerid ) ) return SendClientMessage( playerid, COLOR_RED, " > You are not allowed to use this command!" );
	new string[ 128 ];
	for( new i = 0; i < SPRUNK_DEF; i++ ) {
	    if( IsPlayerInRangeOfPoint( playerid, 2.0, SI[ i ][ sModelx ], SI[ i ][ sModely ], SI[ i ][ sModelz ] ) ) {
	        format( string, sizeof( string ), " > You are editing a dynamic sprunk! Sprunk ID: [ %d ]", i );
	        SendClientMessage( playerid, COLOR_YELLOW, string );
	        SendClientMessage( playerid, COLOR_YELLOW, " > Don't forget to use /setsprunk when you are done!" );
	        dynspid[ playerid ] = i;
	        primarypos[ playerid ][ 0 ] = SI[ i ][ sModelx ];
	        primarypos[ playerid ][ 1 ] = SI[ i ][ sModely ];
	        primarypos[ playerid ][ 2 ] = SI[ i ][ sModelz ];
	        primarypos[ playerid ][ 3 ] = SI[ i ][ sRotx ];
	        primarypos[ playerid ][ 4 ] = SI[ i ][ sRoty ];
	        primarypos[ playerid ][ 5 ] = SI[ i ][ sRotz ];
	        EditDynamicObject( playerid, SI[ i ][ sCID ] );
		}
	}
	return 1;
}
CMD:checksprunk( playerid, params[] ) {
    if( !IsPlayerAdmin( playerid ) ) return SendClientMessage( playerid, COLOR_RED, " > You are not allowed to use this command!" );
	new string[ 128 ];
	for( new i = 0; i < SPRUNK_DEF; i++ ) {
	    if( IsPlayerInRangeOfPoint( playerid, 2.0, SI[ i ][ sModelx ], SI[ i ][ sModely ], SI[ i ][ sModelz ] ) ) {
	        format( string, sizeof( string ), " > Dynamic sprunk found! Sprunk ID: [ %d ]", i );
	        SendClientMessage( playerid, COLOR_YELLOW, string );
		}
	}
	return 1;
}
CMD:removesprunk( playerid, params[] ) {
    if( !IsPlayerAdmin( playerid ) ) return SendClientMessage( playerid, COLOR_RED, " > You are not allowed to use this command!" );
	new string[ 128 ];
	for( new i = 0; i < SPRUNK_DEF; i++ ) {
	    if( IsPlayerInRangeOfPoint( playerid, 2.0, SI[ i ][ sModelx ], SI[ i ][ sModely ], SI[ i ][ sModelz ] ) ) {
	        format( string, sizeof( string ), " > You deleted a dynamic sprunk! Sprunk ID: [ %d ]", i );
	        SendClientMessage( playerid, COLOR_GREEN, string );
	        DestroyDynamicObject( SI[ i ][ sCID ] );
	        SI[ i ][ sUsed ] = 0;
	        SI[ i ][ sDynamic ] = 0;

		}
	}
	return 1;
}