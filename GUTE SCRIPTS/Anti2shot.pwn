#include <a_samp>
#include <YSI/y_bit.inc>

#define FREEZE_TIME (650)

#define iPlayer  playerid

#pragma tabsize 0

new
    BitArray:g_abIsSawnoffClipUsed< MAX_PLAYERS >,
             g_iSawnoffAmmo[ MAX_PLAYERS ],
             g_cFiredShots[ MAX_PLAYERS char ],
             g_cPreviousWeapon[ MAX_PLAYERS char ]
;

public OnPlayerSpawn( iPlayer )
{
    g_iSawnoffAmmo[ iPlayer ] = -1;
    g_cFiredShots{ iPlayer } = 0;
    g_cPreviousWeapon{ iPlayer } = 0;

    Bit_Vet( g_abIsSawnoffClipUsed, iPlayer );
}

public OnPlayerUpdate( iPlayer )
{
    static
        s_iState,
        s_iSpecialAction
    ;

    s_iState = GetPlayerState( iPlayer );
    s_iSpecialAction = GetPlayerSpecialAction( iPlayer );

    if ( s_iState == PLAYER_STATE_ONFOOT && ( s_iSpecialAction == SPECIAL_ACTION_NONE || s_iSpecialAction == SPECIAL_ACTION_DUCK ) )
    {
        static
            s_iWeapon,
            s_iAmmo
        ;

        s_iWeapon = GetPlayerWeapon( iPlayer );
        s_iAmmo = GetPlayerAmmo( iPlayer );

        if ( g_cPreviousWeapon{ iPlayer } != s_iWeapon )
        {
            if ( g_cPreviousWeapon{ iPlayer } == WEAPON_SAWEDOFF )
            {
                if ( Bit_Get( g_abIsSawnoffClipUsed, iPlayer ) )
                {
                    static
                        s_iWeaponState
                    ;

                    s_iWeaponState = GetPlayerWeaponState( iPlayer );

                    if ( ( s_iWeaponState == WEAPONSTATE_MORE_BULLETS || s_iWeaponState == WEAPONSTATE_LAST_BULLET ) && g_cFiredShots{ iPlayer } != 4 )
                    {
                        new
                            Float:fVX,
                            Float:fVY,
                            Float:fVZ
                        ;

                        GetPlayerVelocity( iPlayer, fVX, fVY, fVZ );

                        if ( floatabs( fVZ ) < 0.15 )
                        {
                            ClearAnimations( iPlayer, 1 );

                            ApplyAnimation( playerid, "PED", "XPRESSscratch", 0.0, 1, 0, 0, 0, FREEZE_TIME, 1 );
                        }
                    }
                }

                g_cFiredShots{ iPlayer } = 0;
            }


            g_cPreviousWeapon{ iPlayer } = s_iWeapon;
        }

        if ( s_iWeapon == WEAPON_SAWEDOFF )
        {
            if ( g_iSawnoffAmmo[ iPlayer ] == -1 )
                g_iSawnoffAmmo[ iPlayer ] = GetPlayerAmmo( iPlayer );
            else
            {
                if ( GetPlayerWeaponState( iPlayer ) == WEAPONSTATE_RELOADING )
                {
                    if ( Bit_Get( g_abIsSawnoffClipUsed, iPlayer ) )
                        Bit_Vet( g_abIsSawnoffClipUsed, iPlayer );
                }
                else
                {
                    if ( g_iSawnoffAmmo[ iPlayer ] != s_iAmmo )
                    {
                        if ( s_iAmmo < g_iSawnoffAmmo[ iPlayer ] )
                        {
                            Bit_Let( g_abIsSawnoffClipUsed, iPlayer );

                            g_cFiredShots{ iPlayer } += g_iSawnoffAmmo[ iPlayer ] - s_iAmmo;
                        }
                        else
                        {
                            g_cFiredShots{ iPlayer } = 0;

                            Bit_Vet( g_abIsSawnoffClipUsed, iPlayer );
                        }

                        g_iSawnoffAmmo[ iPlayer ] = s_iAmmo;
                    }
                }
            }
        }
        else if ( g_iSawnoffAmmo[ iPlayer ] != -1 || Bit_Get( g_abIsSawnoffClipUsed, iPlayer ) )
        {
            g_iSawnoffAmmo[ iPlayer ] = -1;

            Bit_Vet( g_abIsSawnoffClipUsed, iPlayer );

            g_cFiredShots{ iPlayer } = 0;
        }
    }
    else if ( g_iSawnoffAmmo[ iPlayer ] != -1 || Bit_Get( g_abIsSawnoffClipUsed, iPlayer ) )
    {
        g_iSawnoffAmmo[ iPlayer ] = -1;

        Bit_Vet( g_abIsSawnoffClipUsed, iPlayer );

        g_cFiredShots{ iPlayer } = 0;
    }

    return 1;
}