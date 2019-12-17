// Tank minigun script by Mean.
// I don't care about the credits much, but don't
// be self-ish.


#include < a_samp >
#include < a_npc >

#define MAX_MINIGUNS 5
#undef MAX_PLAYERS
#define MAX_PLAYERS 100
new
	mgun[ MAX_MINIGUNS ]
	,minigunnum = 0
	,vehhasminigun[ MAX_VEHICLES ]
	,laser[ MAX_PLAYERS ]
;

#define PUB:%1(%2) forward %1(%2); public %1(%2)

GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	if (GetPlayerVehicleID(playerid))
	{
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

public OnFilterScriptInit( ) {
	for( new i = 0; i < MAX_VEHICLES; ++i )
	    vehhasminigun[ i ] = 0;
	SetTimer( "check", 5000, 1 );
	SetTimer( "loop", 500, 1 );
	print( "Miniguns on tanks by Mean loaded." );
	return 1;
}

PUB:check( ) {
	for( new i = 0; i < MAX_VEHICLES; ++i ) {
		new model = GetVehicleModel( i );
		if( model == 432 ) {
		    if( vehhasminigun[ i ] == 0 ) {
		        vehhasminigun[ i ] = 1;
		        mgun[ minigunnum ] = CreateObject( 2985, 0, 0, 0, 0, 0, 0 );
				AttachObjectToVehicle( mgun[ minigunnum ], i, 0.74, 3.37, -0.25, 0.00, 0.00, 89.47 );
				minigunnum ++;
			}
		}
	}
	return 1;
}

PUB:loop( ) {
	for( new i = 0; i < MAX_PLAYERS; ++i ) {
	    if( IsPlayerConnected( i ) ) {
			new vehicleid = GetPlayerVehicleID( i );
			new model = GetVehicleModel( vehicleid );
			if( model == 432 ) {
                new
					keys
					,ud
					,lr
				;
    			GetPlayerKeys( i, keys, ud, lr );
    			if( keys & 128 ) {
    			    SetPlayerAttachedObject( i, 0, 18695, 1, 0.379999, 1.799999, -2.700000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
    			    laser[ i ] = CreateObject( 19084, 0.75, 3.84, 0.86, 0.00, 0.00, 92.61 );
    			    AttachObjectToVehicle( laser[ i ], vehicleid, 0.73, 4.18, 0.86, 0.00, 0.00, 88.03 );
    			    PlayerPlaySound( i, 1135, 0.0, 0.0, 0.0 );
    			    SetTimerEx( "destroy", 250, 0, "i", i );

    			    new
						Float:x
						,Float:y
						,Float:z
						,Float:x2
						,Float:y2
					;
					GetPlayerPos( i, x2, y2, z );
					#pragma unused x2
					#pragma unused y2
					GetXYInFrontOfPlayer( i, x, y, 5.0 );
					for( new u = 0; u < MAX_PLAYERS; ++u ) {
						if( IsPlayerInRangeOfPoint( u, 6.0, x, y, z ) && u != i ) {
						    new Float:hp;
						    GetPlayerHealth( u, hp );
						    SetPlayerHealth( u, hp - 5 );
						    PlayerPlaySound( u, 1135, 0.0, 0.0, 0.0 );

						    if( hp < 1 )
						        CallLocalFunction( "OnPlayerDeath", "ddd", u, i, 38 );
						}
					}
				}
			}
		}
	}
	return 1;
}

PUB:destroy( i ) {
	RemovePlayerAttachedObject( i, 0 );
	DestroyObject( laser[ i ] );
	return 1;
}

public OnPlayerDeath( playerid, killerid, reason ) {
	// Paste your OnPlayerDeath here!
	return 1;
}