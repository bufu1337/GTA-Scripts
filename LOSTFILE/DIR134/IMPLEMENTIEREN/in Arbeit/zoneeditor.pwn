#include <a_samp>
// -----------------------------------------------------------------------------
// ~ ZEN ~ The Road to Enlightment ~
//     ZEN is an InGame GangZone-Editor, completely written from Scratch.
//     Copyright (c) 2007 mabako network. All Rights Reserved.
/* -----------------------------------------------------------------------------
Changelog
	Legend:
	    # fixed
	    + added
	    @ comment
	1.2 - 01.08.2007
		# added Valid Chars check in OnPlayerCommandText
		# HEX number saving
		+ /zen admin load implented
	1.1 - 30.07.2007
		+ Config Option ADMIN_ONLY
		# fixed save-layout
		# fixed color-selection
		# /zen admin is now really for admins only
	1.0
		@ inital Version
*/// ---------------------------------------------------------------------------

#define ZEN_VERSION					"1.2"

// -----------------------------------------------------------------------------
// Config Options
#define ADMIN_ONLY					0
// -----------------------------------------------------------------------------
// defines for Colors
#define NEW_ZONE_COLOR_R			0xFF
#define NEW_ZONE_COLOR_G			0xE4
#define NEW_ZONE_COLOR_B			0xB5
#define NEW_ZONE_COLOR_A			0x80

#define GetColor(%1)				(%1[0]<<24)+(%1[1]<<16)+(%1[2]<<8)+%1[3]


#define MESSAGECOLOR				0xFFE4B580
#define ERRORCOLOR					0xFF8000FF

// -----------------------------------------------------------------------------
// Glue Directions
#define DIRECTION_NORTH				0
#define DIRECTION_EAST				1
#define DIRECTION_SOUTH				2
#define DIRECTION_WEST				3

// -----------------------------------------------------------------------------
// Zone states
#define STATUS_NO_ZONE				0
#define STATUS_CREATED				1

// -----------------------------------------------------------------------------
// Keys
#undef KEY_UP
#undef KEY_DOWN
#undef KEY_LEFT
#undef KEY_RIGHT
#define KEY_UP                  65408
#define KEY_DOWN				128
#define KEY_LEFT				65408
#define KEY_RIGHT				128
// -----------------------------------------------------------------------------
// Forwards

forward DragAndDropUpdate( );

// -----------------------------------------------------------------------------
// player info
enum player
{
	       pGangZone,
	bool:  pDrag,
	bool:  pColorSelect,
		   pColorSelected,
	bool:  pMenu,
	bool:  pDirectionMenu,
	Float: pPosX,
	Float: pPosY,
	Float: pPosZ
}
new players[ MAX_PLAYERS ][ player ];
new emptyplayer[ player ];

// -----------------------------------------------------------------------------
// zone info
enum gangzone
{
	       gID,
	       gStatus,
	Float: gMinX,
	Float: gMinY,
	Float: gMaxX,
	Float: gMaxY,
		   gColors[ 4 ]
}
new gangzones[ MAX_GANG_ZONES ][ gangzone ];

// -----------------------------------------------------------------------------

new Menu:zenMenu;
new Menu:zenDirection;


// -----------------------------------------------------------------------------
// Useful Function Section                                                      [UF]

// same as max( val1, val2 ) for integers
Float: fmax( Float: val1, Float: val2 )
{
	if( val1 > val2 ) return val1;
	return val2;
}

// same as min( val1, val2 ) for integers
Float: fmin( Float: val1, Float: val2 )
{
	if( val1 < val2 ) return val1;
	return val2;
}


strtok( const string[],&index, const seperator[] = " " )
{
	new index2,
	    result[30];

	index2 =  strfind(string, seperator, false, index);


	if(index2 == -1)
	{
		if(strlen(string) > index)
		{
			strmid(result, string, index, strlen(string), 30);
			index = strlen(string);
		}
		return result; // This string is empty, probably, if index came to an end
	}
	if(index2 > (index + 29))
	{
		index2 = index + 29;
		strmid(result, string, index, index2, 30);
		index = index2;
		return result;
	}
	strmid(result, string, index, index2, 30);
	index = index2 + 1;
	return result;
}

IntToHex(number)
{
	new str[9];
	for (new i = 7; i >= 0; i--)
	{
		str[i] = (number & 0x0F) + 0x30;
		str[i] += (str[i] > '9') ? 0x07 : 0x00;
		number >>= 4;
	}
	str[8] = '\0';
	return str;
}

HexToInt(string[]) {
	if (string[0]==0) return 0;
	new i;
	new cur=1;
	new res=0;
	for (i=strlen(string);i>0;i--) {
		if (string[i-1]<58) res=res+cur*(string[i-1]-48); else res=res+cur*(string[i-1]-65+10);
		cur=cur*16;
	}
	return res;
}

// -----------------------------------------------------------------------------

public OnFilterScriptInit( )
{
	print(" ");
	print("    ~ ZEN ~ The Road to Enlightenment ~");
	print("    Inline GangZone-Editor");
	print("    by mabako");
	print(" ");
	
	// Initalizing Variables
	emptyplayer[ pGangZone ] = -1;

	OnGameModeInit();

	for( new playerid = 0; playerid < GetMaxPlayers(); playerid ++ )
	{
	    if( IsPlayerConnected( playerid ) )
	    {
	        OnPlayerConnect( playerid );
	    }
	}

	SetTimer("DragAndDropUpdate", 500, 1);
	return 1;
}

// -----------------------------------------------------------------------------

public OnFilterScriptExit( )
{
	for( new zoneID = 0; zoneID < MAX_GANG_ZONES; zoneID ++ )
	{
	    if( gangzones[ zoneID ][ gID ] != -1 )
	    {
	        GangZoneHideForAll( gangzones[ zoneID ][ gID ] );
	        GangZoneDestroy( gangzones[ zoneID ][ gID ] );
	    }
	}
	for( new playerid = 0; playerid < GetMaxPlayers(); playerid ++ )
	{
		if( players[ playerid ][ pColorSelect ] == true )
		{
			GameTextForPlayer( playerid, " ", 5000, 3 );
			TogglePlayerControllable( playerid, 1 );
		}
	}
	
	return 1;
}

// -----------------------------------------------------------------------------

public OnGameModeExit( )
{
	OnFilterScriptExit( );
	
	return 1;
}

// -----------------------------------------------------------------------------

public OnGameModeInit( )
{
	for( new zoneID = 0; zoneID < MAX_GANG_ZONES; zoneID ++ )
	{
		gangzones[ zoneID ][ gID ] = -1;
	}

	return 1;
}

// -----------------------------------------------------------------------------

public OnPlayerConnect( playerid )
{
	SendClientMessage( playerid, MESSAGECOLOR, "This Server uses ZEN Version " ZEN_VERSION ".");
	players[ playerid ] = emptyplayer;
	
	return 1;
}

// -----------------------------------------------------------------------------
public OnPlayerSpawn( playerid )
{
	for( new zoneID = 0; zoneID < MAX_GANG_ZONES; zoneID ++ )
	{
	    if( gangzones[ zoneID ][ gStatus ] == STATUS_CREATED )
	    {
	        GangZoneShowForPlayer( playerid, gangzones[ zoneID ][ gID ], GetColor( gangzones[ zoneID ][ gColors ] ));
	    }
	}
	return 1;
}

// -----------------------------------------------------------------------------

public OnPlayerDeath( playerid, killerid, reason )
{
	#pragma unused killerid,reason
	if( players[ playerid ][ pDrag ] == true )
	{
		players[ playerid ][ pMenu ] = true;
		OnPlayerSelectedMenuRow(playerid, 4); // call the DROP function
	}
	return 1;
}

// -----------------------------------------------------------------------------

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	#if ADMIN_ONLY == 1
	if(!IsPlayerAdmin(playerid)) return 1;
	#endif
	if( players[ playerid ][ pColorSelect ] == true )
	{
		if( KEY_SECONDARY_ATTACK & newkeys && !(KEY_SECONDARY_ATTACK & oldkeys ))
		{
		    players[ playerid ][ pColorSelect ] = false;
		    players[ playerid ][ pGangZone ] = INVALID_GANG_ZONE;
		    TogglePlayerControllable( playerid, 1 );
		    GameTextForPlayer( playerid, " ", 5000, 3 );
		}
	}
	else if( KEY_CROUCH & newkeys && KEY_SPRINT & newkeys )
	{
	    if( players[ playerid ][ pMenu ] == false )
	    {
			if( !IsValidMenu( zenMenu ) )
			{
				zenMenu = CreateMenu("GangZone Editor", 1, 10.0, 100.0, 200.0, 0.0);
				if( _:zenMenu == INVALID_MENU )
				{
				    return 1;
				}
				AddMenuItem( zenMenu, 0, "Create Zone"); // 0
				AddMenuItem( zenMenu, 0, "Pick a Zone-Color"); // 1
				AddMenuItem( zenMenu, 0, "Destroy Zone"); // 2
				AddMenuItem( zenMenu, 0, "Drag (nearest edge)"); // 3
				AddMenuItem( zenMenu, 0, "Drop (current pos)"); // 4
				AddMenuItem( zenMenu, 0, "Glue Edge to next zones"); // 5
				AddMenuItem( zenMenu, 0, "Exit"); // 6
			}
			if( _:zenMenu != INVALID_MENU )
			{
				ShowMenuForPlayer( zenMenu, playerid );
				players[ playerid ][ pMenu ] = true;
			}
		}
	}
	return 1;
}

// -----------------------------------------------------------------------------

public OnPlayerCommandText( playerid, cmdtext[] )
{
	#if ADMIN_ONLY == 1
	if(!IsPlayerAdmin(playerid)) return 0;
	#endif

	new b, c;
	while ((c = cmdtext[b++])) if (c < 0x20 || c > 0x7E) return 0; // Fix by Y_Less

	if( !strcmp(cmdtext, "/zen", true, 4 ) )
	{
		switch( strlen( cmdtext ))
		{
		    case 4:
		    {
		        SendClientMessage( playerid, MESSAGECOLOR, " " );
		        SendClientMessage( playerid, MESSAGECOLOR, "Use '/zen help' to get a list of commands");
		        SendClientMessage( playerid, MESSAGECOLOR, "'/zen basics' will show you some basics for ZEN");
		        SendClientMessage( playerid, MESSAGECOLOR, "CROUCH + SPRINT keys will open the ZEN menu");
		        return 1;
		    }
		    case 5:
		    {
		        if( cmdtext[4] == ' ' )
		        {
		            return OnPlayerCommandText( playerid, "/zen" );
		        }
		        return 0;
		    }
		    default:
		    {
				new cmd[ 30 ], index = strfind(cmdtext," ") + 1;
				cmd = strtok( cmdtext, index );
				
				if(!strcmp(cmd,"help",true))
				{
					SendClientMessage( playerid, MESSAGECOLOR, " " );
					SendClientMessage( playerid, MESSAGECOLOR, "ZEN ~ The Road to Enlightenment" );
					if( players[ playerid ][ pGangZone ] == INVALID_GANG_ZONE )
					{
						SendClientMessage( playerid, MESSAGECOLOR, "  /zen create - Create a zone | /zen drag - Drags zone" );
					}
					else
					{
						SendClientMessage( playerid, MESSAGECOLOR, "  /zen destroy - Destroys current Zone. | /zen color - chooses color" );
						SendClientMessage( playerid, MESSAGECOLOR, "  /zen drop - Saves Zone Positions");
					}
					SendClientMessage( playerid, MESSAGECOLOR, "  /zen glue - will Glue the zone you're in to NORTH/EAST/SOUTH/WEST zones" );
					SendClientMessage( playerid, MESSAGECOLOR, "  /zen basics - shows some intro to ZEN | /zen about - will show some credit" );
					SendClientMessage( playerid, MESSAGECOLOR, "  /zen cset [R] [G] [B] [A] - sets a RGBA color for your current zone" );
					if( IsPlayerAdmin( playerid ))
					{
					    SendClientMessage( playerid, MESSAGECOLOR, "  To view all Admin functions, type /zen admin help" );
					}
					return 1;
				}
				
				if(!strcmp(cmd,"admin",true) && IsPlayerAdmin(playerid))
				{
					cmd = strtok( cmdtext, index );
					if( strlen( cmd ) == 0 || !strcmp(cmd,"help",true) )
					{
					    SendClientMessage( playerid, MESSAGECOLOR, " " );
					    SendClientMessage( playerid, MESSAGECOLOR, "ZEN ~ Admin" );
					    SendClientMessage( playerid, MESSAGECOLOR, "/zen admin su [playerid] [command] - executes the command as another user" );
					    SendClientMessage( playerid, MESSAGECOLOR, "/zen admin clear - deletes all Gang Zones" );
					    SendClientMessage( playerid, MESSAGECOLOR, "/zen admin save - output a file with GangZoneCreate() stuff" );
					    return 1;
					}
					if( !strcmp(cmd,"su",true) )
					{
					    new temp[30];

					    temp = strtok( cmdtext, index );
					    if( strlen( temp ) == 0 )
					    {
					        SendClientMessage( playerid, ERRORCOLOR, "Syntax: /zen admin su [playerid] [command]" );
					        return 1;
					    }
					    
					    new targetid = strval( temp );
					    if( !IsPlayerConnected( targetid ))
					    {
					        SendClientMessage( playerid, ERRORCOLOR, "No Player with that ID connected" );
					        return 1;
					    }
					    if( strlen( cmdtext ) <= index )
					    {
					        SendClientMessage( playerid, ERRORCOLOR, "Syntax: /zen admin su [playerid] [command]" );
					        return 1;
					    }
					    
					    new command[ 128 ];
					    format( command, 128, "/zen %s", cmdtext[ index ]);
					    OnPlayerCommandText( targetid, command );


					    SendClientMessage( playerid, MESSAGECOLOR, "[ZEN ADMIN] SU Command Executed" );
					    return 1;
					}
					if( !strcmp(cmd,"clear",true) )
					{
					    SendClientMessage( playerid, MESSAGECOLOR, "[ZEN ADMIN] Map Cleared from all Gang Zones" );
					    OnGameModeExit();
					    
					    for( new i = 0; i < MAX_GANG_ZONES; i ++ )
					    {
					    
					    }
					    
					    return 1;
					}
					if( !strcmp(cmd,"save",true))
					{
						new File:fhandle;
						fhandle = fopen("zen.pwn", io_write);
						if(!fhandle) return 0;

						fwrite( fhandle, "#include <a_samp>\r\n\r\n// ZEN Output File\r\n// This File has been created by ZEN - InGame GangZone Editor by mabako\r\n\r\nenum GangZone\r\n{\r\n\009gzID,\r\n\009Float: gzPos[4],\r\n\009gzColor\r\n}\r\n");

						new gangzone_count;
						for( new zoneID = 0; zoneID < MAX_GANG_ZONES; zoneID ++ )
						{
						    if( gangzones[ zoneID ][ gStatus ] == STATUS_CREATED )
						    {
						        gangzone_count++;
							}
						}
						fwrite( fhandle, "new GangZones[][ GangZone ] = {\r\n");


						for( new zoneID = 0; zoneID < MAX_GANG_ZONES; zoneID ++ )
						{
						    if( gangzones[ zoneID ][ gStatus ] == STATUS_CREATED )
						    {
								gangzone_count--;
								new line[ 300 ];
								format( line, 300, "\009{ INVALID_GANG_ZONE, {%.1f, %.1f, %.1f, %.1f}, 0x%s }", gangzones[ zoneID ][ gMinX ], gangzones[ zoneID ][ gMinY ], gangzones[ zoneID ][ gMaxX ], gangzones[ zoneID ][ gMaxY ], IntToHex(GetColor(gangzones[ zoneID ][ gColors ])) );
								fwrite( fhandle, line );
								if( gangzone_count != 0 ) fwrite( fhandle, ",");
								fwrite( fhandle, "\r\n");
							}
						}
						fwrite( fhandle,"};\r\n\r\npublic OnGameModeInit( )\r\n{\r\n");
						fwrite( fhandle,"\009for( new gz = 0; gz < sizeof( GangZones ); gz ++ )\r\n\009{\r\n");
						fwrite( fhandle,"\009\009GangZones[ gz ][ gzID ] = GangZoneCreate( GangZones[ gz ][ gzPos ][ 0 ], GangZones[ gz ][ gzPos ][ 1 ], GangZones[ gz ][ gzPos ][ 2 ], GangZones[ gz ][ gzPos ][ 3 ]);" );
						fwrite( fhandle,"\r\n\009}\r\n}" );
						fwrite( fhandle,"\r\n\r\npublic OnPlayerSpawn( playerid )\r\n{\r\n");
						fwrite( fhandle,"\009for( new gz = 0; gz < sizeof( GangZones ); gz ++ )\r\n\009{\r\n");
						fwrite( fhandle,"\009\009GangZoneShowForPlayer( playerid, GangZones[ gz ][ gzID ], GangZones[ gz ][ gzColor ]);" );
						fwrite( fhandle,"\r\n\009}\r\n}" );
						fclose(fhandle);
						SendClientMessage( playerid, MESSAGECOLOR, "[ZEN ADMIN] Map has been saved!");
						return 1;
					}
					if(!strcmp(cmd,"load",true))
					{
					    LoadZENFile();
					    return 1;
					}
					return 0;
				}
				
				if(!strcmp(cmd,"basics",true) || !strcmp(cmd,"basic",true))
				{
				    SendClientMessage( playerid, MESSAGECOLOR, "ZEN: Inline GangZone Editor" );
				    SendClientMessage( playerid, MESSAGECOLOR, "  With ZEN, you can live CREATE, DESTROY and DRAG & DROP Gang zones,");
				    SendClientMessage( playerid, MESSAGECOLOR, "  It's also possible to change their COLOR or GLUE two GangZones together");
				    SendClientMessage( playerid, MESSAGECOLOR, "  means there will be no gap between those both.");
				    return 1;
				}
				if(!strcmp(cmd,"create",true))
				{
					players[ playerid ][ pMenu ] = true;
					OnPlayerSelectedMenuRow(playerid, 0);
					return 1;
				}
				if(!strcmp(cmd,"color",true))
				{
					players[ playerid ][ pMenu ] = true;
					OnPlayerSelectedMenuRow(playerid, 1);
					return 1;
				}
				if(!strcmp(cmd,"cset",true))
				{ // COLOR SET, a useful function to just set the color instead of having GameText stuff
					new zoneID = GetPlayerGangZone( playerid );
					if( zoneID < 0 )
					{
						return 1;
					}

					for( new i = 0; i < 4; i ++ )
					{
					    gangzones[ zoneID ][ gColors ][ i ] = strval( strtok(cmdtext, index) );
					}
					
					// re-draw the gangzone
					Zen_ReDraw( zoneID );
					
					return 1;
				}
				if(!strcmp(cmd,"destroy",true))
				{
					players[ playerid ][ pMenu ] = true;
					OnPlayerSelectedMenuRow(playerid, 2);
					return 1;
				}
				if(!strcmp(cmd,"drag",true))
				{
					players[ playerid ][ pMenu ] = true;
					OnPlayerSelectedMenuRow(playerid, 3);
					return 1;
				}
				if(!strcmp(cmd,"drop",true))
				{
					players[ playerid ][ pMenu ] = true;
					OnPlayerSelectedMenuRow(playerid, 4);
					return 1;
				}
				if(!strcmp(cmd,"glue",true))
				{
					new direction[ 30 ];
					direction = strtok( cmdtext, index );

					if( strlen( direction ) > 0 )
					{
						new zoneID = GetPlayerGangZone( playerid );
						
						if( zoneID < 0 )
						{
							return 1;
						}

						if(!strcmp(direction,"n",true)||!strcmp(direction,"north",true))
						{
						    Zen_Glue( zoneID, DIRECTION_NORTH );
						    return 1;
						}
						if(!strcmp(direction,"e",true)||!strcmp(direction,"east",true))
						{
						    Zen_Glue( zoneID, DIRECTION_EAST );
						    return 1;
						}
						if(!strcmp(direction,"s",true)||!strcmp(direction,"south",true))
						{
						    Zen_Glue( zoneID, DIRECTION_SOUTH );
						    return 1;
						}
						if(!strcmp(direction,"w",true)||!strcmp(direction,"west",true))
						{
						    Zen_Glue( zoneID, DIRECTION_WEST );
						    return 1;
						}
					}

					// no direction given, open Menu
					players[ playerid ][ pMenu ] = true;
					OnPlayerSelectedMenuRow(playerid, 5);
					return 1;
				}
				if(!strcmp(cmd,"about",true))
				{
				    SendClientMessage( playerid, MESSAGECOLOR, "ZEN ~ The Road to Enlightenment");
				    SendClientMessage( playerid, MESSAGECOLOR, "  ZEN is an InGame GangZone-Editor, completely written from Scratch.");
				    SendClientMessage( playerid, MESSAGECOLOR, "  Copyright (c) 2007 mabako network. All Rights Reserved.");
				    SendClientMessage( playerid, MESSAGECOLOR, "  This Server uses ZEN Version " ZEN_VERSION ".");
				    return 1;
				}
				return 0;
		    }
		}
	}
	return 0;
}

// -----------------------------------------------------------------------------

public OnPlayerSelectedMenuRow(playerid, row)
{
	#if ADMIN_ONLY == 1
	if(!IsPlayerAdmin(playerid)) return 1;
	#endif
	if( players[ playerid ][ pMenu ] == true )
	{
	    players[ playerid ][ pMenu ] = false;
	    switch( row )
	    {
	        case 0:
	        {
	            // Create a Zone
	            new Float:x, Float:y, Float:z;
	            GetPlayerPos( playerid, x, y, z );
	            new zoneID = Zen_CreateZone( x, y, floatround( x + 0.1 ), floatround( y + 0.1 ) );
	            Zen_Drag( playerid, zoneID, x, y ); // tell the script where we start dragging stuff
	            SendClientMessage( playerid, MESSAGECOLOR, "You can now drag this Zone around!");
	        }
	        case 1:
	        {
				// color-picker
				new zoneID = GetPlayerGangZone( playerid );
				if( zoneID < 0 )
				{
					return 1;
				}

				players[ playerid ][ pColorSelect ] = true;
				players[ playerid ][ pColorSelected ] = 2;

				TogglePlayerControllable( playerid, 0 );
	        }
	        case 2:
	        {
	            // destroy the zone
				new zoneID = GetPlayerGangZone( playerid );
				if( zoneID < 0 )
				{
				    return 1;
				}
				
				Zen_Destroy( zoneID );
	        }
	        case 3:
	        {
				// drag the zone
				if( players[ playerid ][ pDrag ] == true )
				{
				    return 1;
				}

				new zoneID = GetPlayerGangZone( playerid );
				if( zoneID < 0 )
				{
				    return 1;
				}

				new Float: px, Float: py, Float: pz;
				GetPlayerPos( playerid, px, py, pz );
				// ---
				// nearest x-point
				if( floatabs( px - gangzones[ zoneID ][ gMinX ] ) < floatabs( px - gangzones[ zoneID ][ gMaxX ] ) )
				{
					// nearer to point MinX
					gangzones[ zoneID ][ gMinX ] = px;
				}
				else
				{
				    gangzones[ zoneID ][ gMaxX ] = px;
				}

				// nearest y-point
				if( floatabs( py - gangzones[ zoneID ][ gMinY ] ) < floatabs( py - gangzones[ zoneID ][ gMaxY ] ) )
				{
				    // nearer to point MinX
				    gangzones[ zoneID ][ gMinY ] = py;
				}
				else
				{
				    gangzones[ zoneID ][ gMaxY ] = py;
				}

				players[ playerid ][ pDrag ] = true;
				players[ playerid ][ pGangZone ] = zoneID;

				players[ playerid ][ pPosX ] = px;
				players[ playerid ][ pPosY ] = py;
				players[ playerid ][ pPosZ ] = pz;

				Zen_Drag( playerid, zoneID, px, py );

	        }
			case 4:
	        {
				// drop the zone
				if( players[ playerid ][ pDrag ] == false )
				{
				    return 1;
				}

				new zoneID = players[ playerid ][ pGangZone ];

				players[ playerid ][ pGangZone ] = INVALID_GANG_ZONE;
				players[ playerid ][ pDrag ] = false;

				// Round positions, there isn't that much high-precision there
				gangzones[ zoneID ][ gMinX ] = floatround( gangzones[ zoneID ][ gMinX ] );
				gangzones[ zoneID ][ gMinY ] = floatround( gangzones[ zoneID ][ gMinY ] );
				gangzones[ zoneID ][ gMaxX ] = floatround( gangzones[ zoneID ][ gMaxX ] );
				gangzones[ zoneID ][ gMaxY ] = floatround( gangzones[ zoneID ][ gMaxY ] );
				
				// Fix that'll show some odd zone
				new zone[ gangzone ];
				zone = gangzones[ zoneID ];
				zone[ gMinX ] = fmin( gangzones[ zoneID ][ gMinX ], gangzones[ zoneID ][ gMaxX ] );
				zone[ gMaxX ] = fmax( gangzones[ zoneID ][ gMinX ], gangzones[ zoneID ][ gMaxX ] );
				zone[ gMinY ] = fmin( gangzones[ zoneID ][ gMinY ], gangzones[ zoneID ][ gMaxY ] );
				zone[ gMaxY ] = fmax( gangzones[ zoneID ][ gMinY ], gangzones[ zoneID ][ gMaxY ] );
				gangzones[ zoneID ] = zone;
				
				Zen_ReCreate( zoneID );
	        }
			case 5:
	        {
				// Glue Edge to next zones
				if( !IsValidMenu( zenDirection ))
				{
					zenDirection = CreateMenu("Glue to ...", 1, 10.0, 100.0, 100.0, 0.0);
					if( _:zenDirection == INVALID_MENU )
					{
					    return 1;
					}
					AddMenuItem( zenDirection, 0, "North"); // 0
					AddMenuItem( zenDirection, 0, "East"); // 1
					AddMenuItem( zenDirection, 0, "South"); // 2
					AddMenuItem( zenDirection, 0, "West"); // 3
					AddMenuItem( zenDirection, 0, "Exit"); // 4
				}
				if( _:zenDirection != INVALID_MENU )
				{
					ShowMenuForPlayer( zenDirection, playerid );
					players[ playerid ][ pDirectionMenu ] = true;
					return 1;
				}
	        }
	        case 6:
	        {
	            // We went to EXIT MENU... which's pretty no function
	            return 1;
	        }
	    }
	    return 1;
	}
	
	if( players[ playerid ][ pDirectionMenu ] == true )
	{
	    players[ playerid ][ pDirectionMenu ] = false;
	    switch(row)
	    {
	        case DIRECTION_NORTH .. DIRECTION_WEST:
	        {
	            new zoneID = GetPlayerGangZone( playerid );
	            if( zoneID < 0 )
	            {
	                return 1;
	            }
	            Zen_Glue( zoneID, row );
	        }
	        case 4:
	        {
	            // Exit... nothing
	            return 1;
	        }
	    }
	    return 1;
	}
	return 1;
}

// -----------------------------------------------------------------------------
public OnPlayerExitedMenu(playerid)
{
	#if ADMIN_ONLY == 1
	if(!IsPlayerAdmin(playerid)) return 1;
	#endif
	players[ playerid ][ pMenu ] = false;
	players[ playerid ][ pDirectionMenu ] = false;
	return 1;
}


// -----------------------------------------------------------------------------
// Our ZEN functions                                                            [ZEN]

// Zen_CreateZone
// Creates a Zone
Zen_CreateZone( Float: minx, Float: miny, Float: maxx, Float: maxy )
{
	for( new i = 0; i < MAX_GANG_ZONES; i ++ )
	{
	    if( gangzones[ i ][ gStatus ] == STATUS_NO_ZONE )
	    {
	        gangzones[ i ][ gStatus ] = STATUS_CREATED;
	        gangzones[ i ][ gMinX ] = fmin( minx, maxx );
	        gangzones[ i ][ gMinY ] = fmin( miny, maxy );
	        gangzones[ i ][ gMaxX ] = fmax( minx, maxx );
	        gangzones[ i ][ gMaxY ] = fmax( miny, maxy );
	        gangzones[ i ][ gColors ] = { NEW_ZONE_COLOR_R, NEW_ZONE_COLOR_G, NEW_ZONE_COLOR_B, NEW_ZONE_COLOR_A };

	        gangzones[ i ][ gID ] = GangZoneCreate( gangzones[ i ][ gMinX ], gangzones[ i ][ gMinY ], gangzones[ i ][ gMaxX ], gangzones[ i ][ gMaxY ] );
	        
	        GangZoneShowForAll( gangzones[ i ][ gID ], GetColor( gangzones[ i ][ gColors ] ));
	        
	        return i;
	    }
	}
	return INVALID_GANG_ZONE;
}

// -----------------------------------------------------------------------------

Zen_Destroy( zoneID )
{
	GangZoneHideForAll( gangzones[ zoneID ][ gID ] );
	GangZoneDestroy( gangzones[ zoneID ][ gID ] );

	new no_zone[ gangzone ];
	gangzones[ zoneID ] = no_zone;
	
	for( new playerid = 0; playerid < GetMaxPlayers(); playerid ++ )
	{
	    if( players[ playerid ][ pGangZone ] == zoneID )
	    {
	        players[ playerid ][ pGangZone ] = INVALID_GANG_ZONE;
	        players[ playerid ][ pDrag ] = false;
	    }
	}
}

// -----------------------------------------------------------------------------

Zen_Drag( playerid, zoneID, Float: start_x, Float: start_y )
{
	players[ playerid ][ pDrag ] = true;
	players[ playerid ][ pGangZone ] = zoneID;
	
	
	if( floatabs(  start_x - gangzones[ zoneID ][ gMinX ]  ) < floatabs(  start_x - gangzones[ zoneID ][ gMaxX ]  ) )
	{
	    gangzones[ zoneID ][ gMinX ] = start_x;
	}
	else
	{
	    gangzones[ zoneID ][ gMaxX ] = start_x;
	}


	if( floatabs(  start_y - gangzones[ zoneID ][ gMinY ]  ) < floatabs(  start_y - gangzones[ zoneID ][ gMaxY ]  ) )
	{
	    gangzones[ zoneID ][ gMinY ] = start_y;
	}
	else
	{
	    gangzones[ zoneID ][ gMaxY ] = start_y;
	}
	
	Zen_ReCreate( zoneID );
	
	players[ playerid ][ pPosX ] = start_x;
	players[ playerid ][ pPosY ] = start_y;
}

// -----------------------------------------------------------------------------

public DragAndDropUpdate( )
{
	for( new playerid = 0; playerid < GetMaxPlayers(); playerid ++ )
	{
		if( players[ playerid ][ pDrag ] == true && players[ playerid ][ pColorSelect ] == false)
		{
			// Player is dragging a gang Zone...
			new zoneID = players[ playerid ][ pGangZone ];
			
			// get new coords of the player
			new Float: px, Float: py, Float: pz;
			GetPlayerPos( playerid, px, py, pz );

			// let's see what coords are changed
			if( players[ playerid ][ pPosX ] == gangzones[ zoneID ][ gMaxX ] )
			{
			    // Max X was it before, now see how it changed
			    if( px < gangzones[ zoneID ][ gMinX ] )
			    {
			        // it is smaller than previous gMinX was...
			        gangzones[ zoneID ][ gMaxX ] = gangzones[ zoneID ][ gMinX ];
			        gangzones[ zoneID ][ gMinX ] = px;
			    }
			    else
			    {
			        // larger as gMinX
			        gangzones[ zoneID ][ gMaxX ] = px;
			    }
			}
			else
			{
			    // Min X was it before, now see how it changed
			    if( px > gangzones[ zoneID ][ gMaxX ] )
			    {
			        // it is smaller than previous gMinX was...
			        gangzones[ zoneID ][ gMinX ] = gangzones[ zoneID ][ gMaxX ];
			        gangzones[ zoneID ][ gMaxX ] = px;
			    }
			    else
			    {
			        // smaller than gMaxX
			        gangzones[ zoneID ][ gMinX ] = px;
			    }
			}
			

			if( players[ playerid ][ pPosY ] == gangzones[ zoneID ][ gMaxY ] )
			{
			    // Max Y was it before, now see how it changed
			    if( py < gangzones[ zoneID ][ gMinY ] )
			    {
			        // it is smaller than previous gMinY was...
			        gangzones[ zoneID ][ gMaxY ] = gangzones[ zoneID ][ gMinY ];
			        gangzones[ zoneID ][ gMinY ] = py;
			    }
			    else
			    {
			        // larger as gMinY
			        gangzones[ zoneID ][ gMaxY ] = py;
			    }
			}
			else
			{
			    // Min Y was it before, now see how it changed
			    if( px > gangzones[ zoneID ][ gMaxY ] )
			    {
			        // it is smaller than previous gMinY was...
			        gangzones[ zoneID ][ gMinY ] = gangzones[ zoneID ][ gMaxY ];
			        gangzones[ zoneID ][ gMaxY ] = py;
			    }
			    else
			    {
			        // smaller than gMaxY
			        gangzones[ zoneID ][ gMinY ] = py;
			    }
			}
			
			players[ playerid ][ pPosX ] = px;
			players[ playerid ][ pPosY ] = py;

			new zone[ gangzone ];
			zone = gangzones[ zoneID ];
			zone[ gMinX ] = fmin( gangzones[ zoneID ][ gMinX ], gangzones[ zoneID ][ gMaxX ] );
			zone[ gMaxX ] = fmax( gangzones[ zoneID ][ gMinX ], gangzones[ zoneID ][ gMaxX ] );
			zone[ gMinY ] = fmin( gangzones[ zoneID ][ gMinY ], gangzones[ zoneID ][ gMaxY ] );
			zone[ gMaxY ] = fmax( gangzones[ zoneID ][ gMinY ], gangzones[ zoneID ][ gMaxY ] );
			gangzones[ zoneID ] = zone;
			
			Zen_ReCreate( zoneID );
		}
		
		else if( players[ playerid ][ pColorSelect ] == true )
		{
			new zoneID = players[ playerid ][ pGangZone ];
			
			
			// Let's see which keys are pressed
			new keys, updown, leftright;
			GetPlayerKeys( playerid, keys, updown, leftright );
			
			if( updown == KEY_DOWN )
			{
				gangzones[ zoneID ][ gColors ][ players[ playerid ][ pColorSelected ] ] -= 5;
				if( gangzones[ zoneID ][ gColors ][ players[ playerid ][ pColorSelected ] ] < 0 ) gangzones[ zoneID ][ gColors ][ players[ playerid ][ pColorSelected ] ] = 0;

				// re-draw the gangzone
				Zen_ReDraw( zoneID );
			}
			else if( updown == KEY_UP )
			{
				gangzones[ zoneID ][ gColors ][ players[ playerid ][ pColorSelected ] ] += 5;
				if( gangzones[ zoneID ][ gColors ][ players[ playerid ][ pColorSelected ] ] > 0xFF ) gangzones[ zoneID ][ gColors ][ players[ playerid ][ pColorSelected ] ] = 0xFF;

				// re-draw the gangzone
				Zen_ReDraw( zoneID );
			}
			
			
			
			if( leftright == KEY_LEFT )
			{
				players[ playerid ][ pColorSelected ] = (players[ playerid ][ pColorSelected ] - 1) % 4;
			}
			else if( leftright == KEY_RIGHT )
			{
				players[ playerid ][ pColorSelected ] = (players[ playerid ][ pColorSelected ] + 1) % 4;
			}


			new ctext[128];
			new colors[ 4 ][ 4 ] = {"~r~","~g~","~b~","~w~"};
			for( new i = 0; i < 4; i ++)
			{
			    if( players[ playerid ][ pColorSelected ] == i )
			    {
					format( ctext, sizeof(ctext), "%s ~u~%s%d~d~", ctext, colors[ i ], gangzones[ zoneID ][ gColors ][ i ]);
			    }
			    else
			    {
					format( ctext, sizeof(ctext), "%s %s%d", ctext, colors[ i ], gangzones[ zoneID ][ gColors ][ i ]);
			    }
			}
			format(ctext, sizeof(ctext), "%s~n~~w~Use ~y~~k~~VEHICLE_ENTER_EXIT~~w~ to save this color.", ctext);
			GameTextForPlayer( playerid, ctext, 5000, 3 );
		}
	}
}

// -----------------------------------------------------------------------------

Zen_Glue( zoneID, direction )
{
	// this is the hard part... GLUE the zone to the next north/east/south/west ones.
	new Float:distance;
	new Float:minDist = 9999.0;
	new minZone = INVALID_GANG_ZONE;
	switch( direction )
	{
	    case DIRECTION_NORTH:
	    {
	        for( new i = 0; i < MAX_GANG_ZONES; i ++ )
	        {
	            if( gangzones[ i ][ gStatus ] == STATUS_CREATED )
	            {
					distance = gangzones[ i ][ gMinY ] - gangzones[ zoneID ][ gMaxY ];
					if( distance > 0 && distance < minDist )
					{
					/* is above the zone, see if it's just Y above the zone or in the zone corridor */
					    if(gangzones[ i ][ gMaxX ] > gangzones[ zoneID ][ gMinX ] && gangzones[ i ][ gMinX ] < gangzones[ zoneID ][ gMaxX ] )
					    {
					    	minDist = distance;
					    	minZone = i;
						}
					}
				}
	        }
	        
	        if( minZone != INVALID_GANG_ZONE )
	        {
	            gangzones[ zoneID ][ gMaxY ] += minDist;
	            Zen_ReCreate( zoneID );
	            return;
	        }
	    }
	    case DIRECTION_EAST:
	    {
	        for( new i = 0; i < MAX_GANG_ZONES; i ++ )
	        {
	            if( gangzones[ i ][ gStatus ] == STATUS_CREATED )
	            {
					distance = gangzones[ i ][ gMinX ] - gangzones[ zoneID ][ gMaxX ];
					if( distance > 0 && distance < minDist )
					{
					/* is above the zone, see if it's just Y above the zone or in the zone corridor */
					    if(gangzones[ i ][ gMaxY ] > gangzones[ zoneID ][ gMinY ] && gangzones[ i ][ gMinY ] < gangzones[ zoneID ][ gMaxY ] )
					    {
					    	minDist = distance;
					    	minZone = i;
						}
					}
				}
	        }

	        if( minZone != INVALID_GANG_ZONE )
	        {
	            gangzones[ zoneID ][ gMaxX ] += minDist;
	            Zen_ReCreate( zoneID );
	            return;
	        }
	    }
	    case DIRECTION_SOUTH:
	    {
	        for( new i = 0; i < MAX_GANG_ZONES; i ++ )
	        {
	            if( gangzones[ i ][ gStatus ] == STATUS_CREATED )
	            {
					distance = gangzones[ zoneID ][ gMinY ] - gangzones[ i ][ gMaxY ];
					if( distance > 0 && distance < minDist )
					{
					/* is above the zone, see if it's just Y above the zone or in the zone corridor */
					    if(gangzones[ i ][ gMaxX ] > gangzones[ zoneID ][ gMinX ] && gangzones[ i ][ gMinX ] < gangzones[ zoneID ][ gMaxX ] )
					    {
					    	minDist = distance;
					    	minZone = i;
						}
					}
				}
	        }

	        if( minZone != INVALID_GANG_ZONE )
	        {
	            gangzones[ zoneID ][ gMinY ] -= minDist;
	            Zen_ReCreate( zoneID );
	            return;
	        }
	    }
	    case DIRECTION_WEST:
	    {
	        for( new i = 0; i < MAX_GANG_ZONES; i ++ )
	        {
	            if( gangzones[ i ][ gStatus ] == STATUS_CREATED )
	            {
					distance = gangzones[ zoneID ][ gMinX ] - gangzones[ i ][ gMaxX ];
					if( distance > 0 && distance < minDist )
					{
					/* is above the zone, see if it's just Y above the zone or in the zone corridor */
					    if(gangzones[ i ][ gMaxY ] > gangzones[ zoneID ][ gMinY ] && gangzones[ i ][ gMinY ] < gangzones[ zoneID ][ gMaxY ] )
					    {
					    	minDist = distance;
					    	minZone = i;
						}
					}
				}
	        }

	        if( minZone != INVALID_GANG_ZONE )
	        {
	            gangzones[ zoneID ][ gMinX ] -= minDist;
	            Zen_ReCreate( zoneID );
	            return;
	        }
	    }
	}
}

// -----------------------------------------------------------------------------

GetPlayerGangZone( playerid )
{
	new zoneID = INVALID_GANG_ZONE;
	if( players[ playerid ][ pGangZone ] >= 0 )
	{
	    zoneID = players[ playerid ][ pGangZone ];
	}
	else
	{
		new Float:px, Float:py, Float:pz;
		GetPlayerPos( playerid, px, py, pz );
		for( new j = 0; j < MAX_GANG_ZONES; j ++ )
		{
		    if( gangzones[ j ][ gStatus ] == STATUS_CREATED )
		    {
				if( px > gangzones[ j ][ gMinX ] && px < gangzones[ j ][ gMaxX ]
				    && py > gangzones[ j ][ gMinY ] && py < gangzones[ j ][ gMaxY ] )
				{
					// First find out if another user edits this Gang Zone

					for( new i = 0; i < GetMaxPlayers(); i ++ )
					{
					    if( players[ i ][ pGangZone ] == j && players[ i ][ pDrag ] == true )
					    {
					        SendClientMessage( playerid, ERRORCOLOR, "This Zone is edited by another user");
					        return -2;
					    }
					}
					zoneID = j;
					break;
				}
			}
		}
	}

	if( zoneID == INVALID_GANG_ZONE )
	{
		SendClientMessage( playerid, ERRORCOLOR, "You're not in a zone");
		return -2;
	}
	return zoneID;
}

// -----------------------------------------------------------------------------

Zen_ReCreate( zoneID )
{
	GangZoneHideForAll( gangzones[ zoneID ][ gID ] );
	GangZoneDestroy( gangzones[ zoneID ][ gID ] );

	Zen_Create( zoneID );
}

// -----------------------------------------------------------------------------

Zen_Create( zoneID )
{
	gangzones[ zoneID ][ gID ] = GangZoneCreate( gangzones[ zoneID ][ gMinX ], gangzones[ zoneID ][ gMinY ], gangzones[ zoneID ][ gMaxX ], gangzones[ zoneID ][ gMaxY ] );
	GangZoneShowForAll( gangzones[ zoneID ][ gID ], GetColor( gangzones[ zoneID ][ gColors ] ));
}

// -----------------------------------------------------------------------------

Zen_ReDraw( zoneID )
{
	GangZoneHideForAll( gangzones[ zoneID ][ gID ] );
	GangZoneShowForAll( gangzones[ zoneID ][ gID ], GetColor( gangzones[ zoneID ][ gColors ] ));
}

// -----------------------------------------------------------------------------

LoadZENFile( )
{
	if(!fexist("zen.pwn")) return 0;
	new File: fhandle = fopen("zen.pwn", io_read );
	if( !fhandle ) return 0;
	
	new templine[ 200 ], bool:block = false;
	while( fread( fhandle, templine ))
	{
		if( strlen( templine ) > 0 )
		{
			if(!strcmp( "new GangZones[][ GangZone ] = {", templine, true, strlen("new GangZones[][ GangZone ] = {") ))
			{
			    block = true;
			}
			else if( block == true )
			{
				if(!strcmp("};", templine, true, 2 ))
				{
					block = false;
					fclose( fhandle );
					return 1;
				}
				else
				{
					strdel( templine, 0, strfind( templine, ", {" )+3);
					while( strfind( templine, " ", true, 0 ) != -1 )
					{
					    // now we need to delete all spaces
					    new position = strfind( templine, " ", true, 0 );
					    strdel( templine, position, position + 1 );
					}
					// now let's get the coords
					new index, Float: c[4];
					c[ 0 ] = floatstr( strtok( templine, index,"," ));
					c[ 1 ] = floatstr( strtok( templine, index,"," ));
					c[ 2 ] = floatstr( strtok( templine, index,"," ));
					c[ 3 ] = floatstr( strtok( templine, index,"}" ));
					strdel( templine, 0, index + 3 );

					// colorz
					new colors[ 4 ], temp[3];
					for( new i = 0; i < 4; i ++ )
					{
					    strmid( temp, templine, (2 * i), 2 * (i + 1) );
					    colors[ i ] = HexToInt( temp );
					}
					new zoneID = Zen_CreateZone( c[0], c[1], c[2], c[3] );
					if(zoneID != INVALID_GANG_ZONE )
					{
						gangzones[ zoneID ][ gColors ] = colors;
						Zen_ReDraw( zoneID );
					}
				}
			}
		}
	    
	}
	fclose( fhandle );
	return 1;
}

