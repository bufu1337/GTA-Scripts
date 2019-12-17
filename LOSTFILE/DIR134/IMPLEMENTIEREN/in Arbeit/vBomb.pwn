//------------------------------------------------------------------------------
//	Vehicle Bomb FilterScript v2.0 by Simon Campbell (2008)
//------------------------------------------------------------------------------

#include <a_samp>

//------------------------------------------------------------------------------
//  Forwards
//------------------------------------------------------------------------------

forward BombSync		( );
forward BombDetonate	( vehicleid, explosions );

forward UnfreezePlayer	( playerid );

//------------------------------------------------------------------------------
//	Generic Redefines
//------------------------------------------------------------------------------

#undef	MAX_VEHICLES
#define MAX_VEHICLES    700

#undef  MAX_PLAYERS
#define MAX_PLAYERS     200

//------------------------------------------------------------------------------
//  Script Defines
//------------------------------------------------------------------------------

#define BOMB_EXPLOSION_TYPE		10      // The bomb explosion type
#define BOMB_EXPLOSION_AMOUNT   3       // The amount of explosions a vehicle bomb has
#define BOMB_EXPLOSION_RADIUS   7.5     // The explosion radius of the bomb
#define BOMB_EXPLOSION_TIME     1000	// The difference between explosion times.
#define BOMB_EXPLOSION_START    3000	// The time it takes for a bomb to start.

//------------------------------------------------------------------------------
//	Enumerators
//------------------------------------------------------------------------------

enum
{
	V_STAGE_NONE,
	V_STAGE_RIGGED,
	V_STAGE_EXPLODING
};

enum e_VEHICLE_DATA
{
	V_STAGE		// The vehicles current stage - V_STAGE_NONE, V_STAGE_RIGGED, V_STAGE_EXPLODING
};

//------------------------------------------------------------------------------
//	Variables
//------------------------------------------------------------------------------

static
	g_iMaxPlayers	= MAX_PLAYERS,
	g_iBombSyncTmr  = -1,
	g_aPlayerBombShop	[ MAX_PLAYERS ]	= { -1, ... },
	g_aVehicleBombData	[ MAX_VEHICLES ][ e_VEHICLE_DATA ];
	
static const Float:g_fBombAreas[ ][ ] =
{
	{ 2003.4459,	2307.2195,	10.0,	2008.4232,	2315.4070,	13.75 },
	{ 1846.6150,	-1857.9579,	13.0,	1855.5764,	-1854.6993,	16.75 }
};

//------------------------------------------------------------------------------
//  Callbacks
//------------------------------------------------------------------------------

public OnFilterScriptInit( )
{
	print( "Standard BombShop Activation FilterScript loaded ... by Simon Campbell (2008)" );
	
	g_iMaxPlayers = GetMaxPlayers( );
	g_iBombSyncTmr= SetTimer( "BombSync", 750, 1 );
	
	return 1;
}

public OnFilterScriptExit( )
{
	print( "Standard BombShop Activation FilterScript unloaded ... by Simon Campbell (2008)" );
	
	if ( g_iBombSyncTmr != -1 )
	    KillTimer( g_iBombSyncTmr );

	return 1;
}

public OnVehicleDeath( vehicleid, killerid )
{
	g_aVehicleBombData[ vehicleid ][ V_STAGE ] = V_STAGE_NONE;
    
	return 1;
}

public OnPlayerKeyStateChange( playerid, newkeys, oldkeys )
{
	if	(
			( ( newkeys & KEY_FIRE )	== KEY_FIRE		&& ( oldkeys & KEY_FIRE )	!= KEY_FIRE		) ||
			( ( newkeys & KEY_ACTION )	== KEY_ACTION	&& ( oldkeys & KEY_ACTION )	!= KEY_ACTION	)
		)
	{
		if ( GetPlayerState( playerid ) == PLAYER_STATE_DRIVER && SetVehicleToDetonate( GetPlayerVehicleID( playerid ), BOMB_EXPLOSION_AMOUNT ) )
			return 1;
	}

	return 1;
}

//------------------------------------------------------------------------------
//	Stock Functions
//------------------------------------------------------------------------------

stock SetVehicleToDetonate( vehicleid, explosions )
{
	// Sets a rigged vehicle to detonate.
	
	if ( g_aVehicleBombData[ vehicleid ][ V_STAGE ] == V_STAGE_RIGGED && vehicleid )
	{
	    switch ( GetVehicleModel( vehicleid ) )
	    {
	        case	581, 509, 481, 462, 521, 463, 510,
					522, 461, 448, 471, 468, 586, 472,
					473, 493, 595, 484, 430, 453, 452,
					446, 454, 592, 577, 511, 512, 593,
					520, 553, 476, 519, 460, 513, 441,
					464, 465, 501, 564, 594: return 0;
					
			default:
			{
				g_aVehicleBombData[ vehicleid ][ V_STAGE ]
					= V_STAGE_EXPLODING;
					
				SetVehicleHealth( vehicleid, 100.0 );
				SetTimerEx		( "BombDetonate", BOMB_EXPLOSION_START, 0, "ii", vehicleid, explosions );
			}
		}
	    
	    return 1;
	}
	
	return 0;
}

stock IsPointInArea( Float:fX, Float:fY, Float:fZ, Float:fMinX, Float:fMaxX, Float:fMinY, Float:fMaxY, Float:fMinZ=-99999.0, Float:fMaxZ=99999.9 )
{
	// Checks if a point is inside the area specified.

	if ( fX > fMinX && fX < fMaxX && fY > fMinY && fY < fMaxY && fZ > fMinZ && fZ < fMaxZ )
		return 1;
		
	else
		return 0;
}

//------------------------------------------------------------------------------
//  Public Functions (for Timers)
//------------------------------------------------------------------------------

public BombSync( )
{
	for ( new playerid = 0; playerid < g_iMaxPlayers; playerid++ )
	{
	    if ( IsPlayerConnected( playerid ) )
	    {
	        new
	            Float:fX,
				Float:fY,
				Float:fZ,

				iInterior
				    = GetPlayerInterior	( playerid ),
				    
				iVehicleID
					= GetPlayerVehicleID( playerid );

			GetPlayerPos( playerid, fX, fY, fZ );
	        
			if ( !g_aVehicleBombData[ iVehicleID ][ V_STAGE ] && iVehicleID && !iInterior && GetPlayerMoney( playerid ) >= 500 )
	        {
	            if ( g_aPlayerBombShop[ playerid ] == -1 )
	            {
	            	for ( new i = 0; i < sizeof( g_fBombAreas ); i++ )
		            {
						if ( IsPointInArea( fX, fY, fZ, g_fBombAreas[ i ][ 0 ], g_fBombAreas[ i ][ 3 ], g_fBombAreas[ i ][ 1 ], g_fBombAreas[ i ][ 4 ], g_fBombAreas[ i ][ 2 ], g_fBombAreas[ i ][ 5 ] ) )
						{
							g_aPlayerBombShop[ playerid ] = i;
							
							break;
						}
					}
				}
				
				else if ( IsPointInArea( fX, fY, fZ, g_fBombAreas[ g_aPlayerBombShop[ playerid ] ][ 0 ], g_fBombAreas[ g_aPlayerBombShop[ playerid ] ][ 3 ], g_fBombAreas[ g_aPlayerBombShop[ playerid ] ][ 1 ], g_fBombAreas[ g_aPlayerBombShop[ playerid ] ][ 4 ], g_fBombAreas[ g_aPlayerBombShop[ playerid ] ][ 2 ], g_fBombAreas[ g_aPlayerBombShop[ playerid ] ][ 5 ] ) )
				{
					g_aVehicleBombData[ iVehicleID ][ V_STAGE ] = V_STAGE_RIGGED;
				    
					TogglePlayerControllable( playerid, 0 );
					SetTimerEx( "UnfreezePlayer", 2000, 0, "i", playerid );
				}
				
				else
					g_aPlayerBombShop[ playerid ] = -1;
			}
	    }
	}
}

public BombDetonate( vehicleid, explosions )
{
	if ( explosions > 0 )
	{
	    g_aVehicleBombData[ vehicleid ][ V_STAGE ]
			= V_STAGE_EXPLODING;
	    
		new
			Float: fX,
			Float: fY,
			Float: fZ;

		GetVehiclePos( vehicleid, fX, fY, fZ );
		CreateExplosion( fX, fY, fZ,	BOMB_EXPLOSION_TYPE, BOMB_EXPLOSION_RADIUS );
		SetTimerEx( "BombDetonate",		BOMB_EXPLOSION_TIME, 0, "ii", vehicleid, ( explosions - 1 ) );
	}
	else
	{
	    g_aVehicleBombData[ vehicleid ][ V_STAGE ]
			= V_STAGE_NONE;
	    
		for ( new i = 0; i < g_iMaxPlayers; i++ )
	        if ( IsPlayerConnected( i ) && GetPlayerVehicleID( i ) == vehicleid )
				SetPlayerHealth( i, random( 256 ) ? 0.0 : 1.0 );

		SetVehicleToRespawn( vehicleid );
	}
}

public UnfreezePlayer( playerid )
	return TogglePlayerControllable( playerid, 1 );
