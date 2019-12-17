/*                                           ________________________________
                      __,__                 (								)
             .--.  .-"     "-.  .--.        ( Monky fix, good now, happy be!)
            / .. \/  .-. .-.  \/ .. \       (       Keep the credits! 		)
           | |  '|  /   Y   \  |'  | |    /	(      							)
           | \   \  \ 0 | 0 /  /   / |   /   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
            \ '- ,\.-"`` ``"-./, -' /   /
             `'-' /_   ^ ^   _\ '-'`   /
             .--'|  \._ _ _./  |'--.
           /`    \   \.-.  /   /    `\
          /       '._/  |-' _.'       \
         /          ;  /--~'   |       \
        /        .'\|.-\--.     \       \
       /   .'-. /.-.;\  |\|'~'-.|\       \
       \       `-./`|_\_/ `     `\'.      \
        '.      ;     ___)        '.`;    /
          '-.,_ ;     ___)          \/   /
           \   ``'------'\       \   `  /
            '.    \       '.      |   ;/_
          ___>     '.       \_ _ _/   ,  '--.
        .'   '.   .-~~~~~-. /     |--'`~~-.  \
       // / .---'/  .-~~-._/ / / /---..__.'  /
 jgs  ((_(_/    /  /      (_(_(_(---.__    .'
                | |     _              `~~`
                | |     \'.
                 \ '....' |
                  '.,___.'

		#Name: [FilterScript]Snake Multiplayer
    	#Author: iMonk3y
    	#Release Date: 04/08/2011
    	#Credits:
			¤ zcmd 			- Zeex
			¤ foreach       - Y_Less
			¤ sscanf       	- Y_Less
			
			¤ best beta-release testers
  			  - Geryy & YJIET
*/

#define FILTERSCRIPT

#include <a_samp>
#include <zcmd>
#include <foreach>
#include <sscanf>

#define MAX_SNAKES      		( 4 ) 		// Maximum players in a snake game, don't touch this...
#define SNAKE_LENGTH 	        ( 3 ) 		// Everyone starts with one unit
#define MAX_SCORE               ( 10 ) 		// Max score to obtain to win the game - also meaning snake length can grow up to 15
#define UNIT_ONE 				( 19144 ) 	// Modelid of first unit, which is red in color
#define ITEM_MODEL 				( 19143 ) 	// Modelid of collectible item
#define GAME_AREA_POS           ( 3000.0 ) 	// Game area is located at 3000.0 x-coordinate and 3000.0 y-coordinate
#define DISTANCE 				( 0.93 ) 	// Distance which snakes move
#define GAME_AREA_SIZE          ( 27 ) 		// 27 x 27 squares ... Game area has only borders, no obstacles ( yet )
#define GAME_STARTS_IN          ( 15 ) 		// Seconds...
#define HEIGHT					( 20.0 ) 	// Height of the game platform

#define SNAKE_RED 		( 0 )
#define SNAKE_GREEN 	( 1 )
#define SNAKE_BLUE 		( 2 )
#define SNAKE_YELLOW  	( 3 )

#define FOR(%0=%1,inRange(%2)) \
	for(new %0=%1; %0<%2; %0++)

#define PUBLIC:%0(%1) \
	forward %0(%1); \
	public %0(%1)

#define COL_LIME    \
	"{88AA62}"
#define COL_WHITE 	\
	"{FFFFFF}"
#define COL_RULE   	\
	"{FBDF89}"
#define COL_ORANGE	\
	"{F69521}"
#define COL_GREY	\
	"{AFAFAF}"
#define COL_BLUE    \
	"{0000FF}"
#define COL_GREEN	\
 	"{33AA33}"
#define COL_YELLOW 	\
	"{FFFF00}"
#define COL_TOMATO 	\
	"{FF6347}"
#define COL_PURPLE 	\
	 "{9900FF}"

new
    winnerid = -1,
    snakeid[ MAX_PLAYERS ],
	snakeUnits[ MAX_SCORE ][ MAX_SNAKES ],
	Float:snakeUnit_x[ MAX_SCORE ][ MAX_SNAKES ],
	Float:snakeUnit_y[ MAX_SCORE ][ MAX_SNAKES ],
	computerUnits[ MAX_SCORE ],
	Float:computerUnit_x[ MAX_SCORE ],
	Float:computerUnit_y[ MAX_SCORE ],
	Float:ITEM_x, Float:ITEM_y, Float:ITEM_z,
	Float:snakeDirection_x[ MAX_SNAKES ],
	Float:snakeDirection_y[ MAX_SNAKES ],
	Float:computerDirection_x,
	Float:computerDirection_y,
	snakeTotalUnits[ MAX_SNAKES ],
	computerTotalUnits,
	bool:minigamer[ MAX_PLAYERS ],
	bool:playing[ MAX_SNAKES ],
	bool:computerJoin = false,
	Float:gameAreaCoordinates[ GAME_AREA_SIZE ],
	playerWorld[ MAX_PLAYERS ],
	Float:gameSpeed,
	countdownTimer,
	gameScore,
	gameStarted,
	objectProgress,
	objectPlatform,
	greenThing[ 4 ],
	objectItem;

new Iterator:Snake<MAX_SNAKES>;

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Snake multiplayer 1.0");
	print("--------------------------------------\n");

	FOR( i = 0,inRange(GAME_AREA_SIZE))
 	gameAreaCoordinates[ i ] = GAME_AREA_POS + DISTANCE * i;
	return 1;
}

public OnFilterScriptExit()
{
    if( gameStarted > 0 ) ResetGame( );
    return 1;
}

public OnPlayerDisconnect( playerid )
{
    if( minigamer[ playerid ] )
 	playing[ sgetSnakeID( playerid ) ] = false;
 	return 1;
}

public OnPlayerCommandReceived( playerid, cmdtext[] )
{
	if( minigamer[ playerid ] )
	{
		SendClientMessage( playerid, 0x88AA62FF, "Commands are disabled since you are signed up for Snake multiplayer.");
		return 0;
	}
	return 1;
}

CMD:cc( playerid, params[] )
{
	FOR( i = 0,inRange(10))
	{
	    SendClientMessage( playerid, 0x88AA63FF, " ");
	}
	return 1;
}

CMD:snake( playerid, params[] )
{
	if( gameStarted < 1 )
	{
	    new
	        str[ 128 ];
																									
		if(sscanf(params, "fi", gameSpeed, gameScore )) return SendClientMessage( playerid, 0xAFAFAFAA, "Use: /snake "COL_LIME"« snake speed » « game score »");
		{
	        if( gameSpeed < 1 || gameSpeed > 5 ) return SendClientMessage( playerid, 0x88AA62FF, "Choose speed between 1 - 5."); //Speed 1 is sluggish :S

			if( gameScore < SNAKE_LENGTH +2 || gameScore > MAX_SCORE )
			{
				format( str, sizeof str, "Choose score between %i - %i.", SNAKE_LENGTH +2, MAX_SCORE );
				return SendClientMessage( playerid, 0x88AA62FF, str );
			}
			computerJoin = true;
		}

		snakeid[ playerid ] = SNAKE_RED;
		minigamer[ playerid ] = true;
		Iter_Add(Snake, playerid );

		countdownTimer = SetTimer("StartSnakeMultiplayer", GAME_STARTS_IN*1000, 0 );

		format( str, sizeof str, "Snake multiplayer is starting in %i seconds, type "COL_ORANGE"'/snake'"COL_RULE" to join!", GAME_STARTS_IN );
		SendClientMessageToAll( 0xFBDF89AA, str );
		SendClientMessageToAll( 0xFBDF89AA, "* Your task is to obtain highest score first by collecting items, defeating opponents");
		format( str, sizeof str, "  and staying alive as long as possible. Snake speed "COL_TOMATO"« %i/5 » "COL_RULE"Gain "COL_TOMATO"« %i » "COL_RULE"score to win.", floatround( gameSpeed ), gameScore );
		SendClientMessageToAll( 0xFBDF89AA, str );
		gameStarted = 1;
	}
	else
	{
	    if( gameStarted > 1 ) return SendClientMessage( playerid, 0xAFAFAFAA, "Snake multiplayer is currently in progress, sorry.");

	    SendClientMessage( playerid, 0xF69521AA, "You have signed up for Snake multiplayer.");

	    snakeid[ playerid ] = Iter_Count(Snake);
	    Iter_Add(Snake, playerid );
		minigamer[ playerid ] = true;

		if( Iter_Count(Snake) >= MAX_SNAKES-1 )
		{
			computerJoin = false;
			KillTimer( countdownTimer );
			StartSnakeMultiplayer( ); //Start game immediately once max signups are reached
		}
	}
	return 1;
}

PUBLIC:StartSnakeMultiplayer( )
{
	if( Iter_Count(Snake) < 1 )
	return ResetGame( );

    objectPlatform = CreateObject( 18981, GAME_AREA_POS + ( DISTANCE * ( GAME_AREA_SIZE / 2 ) ), GAME_AREA_POS + ( DISTANCE * ( GAME_AREA_SIZE / 2 ) ), HEIGHT - 0.2, 0.0, 90.0 ,0.0 );

	greenThing[ 0 ] = CreateObject( 19134, gameAreaCoordinates[ 0 ] + 8.0, gameAreaCoordinates[ 0 ] + 11.4, 48.0, 180.0, 90.0, 225.0 );
	greenThing[ 1 ] = CreateObject( 19134, gameAreaCoordinates[ 0 ] + 8.0, gameAreaCoordinates[ GAME_AREA_SIZE -1  ] - 4.58, 48.0, 180.0, 90.0, 135.0 );
	greenThing[ 2 ] = CreateObject( 19134, gameAreaCoordinates[ GAME_AREA_SIZE -1 ] - 8.0, gameAreaCoordinates[ GAME_AREA_SIZE -1 ] - 4.58, 48.0, 180.0, 90.0, 45.0 );
	greenThing[ 3 ] = CreateObject( 19134, gameAreaCoordinates[ GAME_AREA_SIZE -1 ] - 8.0, gameAreaCoordinates[ 0 ] + 11.4, 48.0, 180.0, 90.0, -45.0 );

	objectItem = CreateObject( ITEM_MODEL, gameAreaCoordinates[ random(  GAME_AREA_SIZE - 3 ) + 2 ], gameAreaCoordinates[ random(  GAME_AREA_SIZE - 3 ) + 2 ], HEIGHT + 0.2, 0.0, 0.0, 0.0 );
	GetObjectPos( objectItem, ITEM_x, ITEM_y, ITEM_z );

	objectProgress = CreateObject( ITEM_MODEL, 0.0, 0.0, -10.0, 0.0, 0.0, 0.0 );
   	MoveObject( objectProgress, DISTANCE, DISTANCE, -10.0, 0.4 );

	gameStarted = 2;

	new
		Float:z;

 	foreach(Snake, i )
	{
	    SetPlayerTime( i, 0, 0 );
	    SetPlayerCameraPos( i,  GAME_AREA_POS + ( DISTANCE * ( GAME_AREA_SIZE / 2 ) ), GAME_AREA_POS + ( DISTANCE * ( GAME_AREA_SIZE / 2 ) ) + 5.0 -0.02, 60.0 );
		SetPlayerCameraLookAt( i,  GAME_AREA_POS + ( DISTANCE * ( GAME_AREA_SIZE / 2 ) ), GAME_AREA_POS + ( DISTANCE * ( GAME_AREA_SIZE / 2 ) ) + 5.0, HEIGHT );

		snakeTotalUnits[ snakeid[ i ] ] = SNAKE_LENGTH;

		FOR( x = 0,inRange(SNAKE_LENGTH))
	 	{
	 	    if( snakeid[ i ] == SNAKE_RED )
		 	{
                snakeUnits[ x ][ snakeid[ i ] ] = CreateObject( UNIT_ONE + snakeid[ i ], gameAreaCoordinates[ GAME_AREA_SIZE -1 ], gameAreaCoordinates[ GAME_AREA_SIZE -1 ], HEIGHT, 0.0, 0.0, 0.0 );
                GetObjectPos( snakeUnits[ x ][ snakeid[ i ] ], snakeUnit_x[ x ][ snakeid[ i ] ], snakeUnit_y[ x ][ snakeid[ i ] ], z );
				MoveObject( snakeUnits[ 0 ][ snakeid[ i ] ], snakeUnit_x[ 0 ][ snakeid[ i ] ] - DISTANCE, snakeUnit_y[ 0 ][ snakeid[ i ] ] - DISTANCE, HEIGHT, 1000.0 );
                snakeDirection_x[ snakeid[ i ] ] = 0.000000;
				snakeDirection_y[ snakeid[ i ] ] = -DISTANCE;
			}
			else if( snakeid[ i ] == SNAKE_GREEN )
		 	{
                snakeUnits[ x ][ snakeid[ i ] ] = CreateObject( UNIT_ONE + snakeid[ i ], gameAreaCoordinates[ GAME_AREA_SIZE -1 ], gameAreaCoordinates[ 0 ], HEIGHT, 0.0, 0.0, 0.0 );
                GetObjectPos( snakeUnits[ x ][ snakeid[ i ] ], snakeUnit_x[ x ][ snakeid[ i ] ], snakeUnit_y[ x ][ snakeid[ i ] ], z );
				MoveObject( snakeUnits[ 0 ][ snakeid[ i ] ], snakeUnit_x[ 0 ][ snakeid[ i ] ] - DISTANCE, snakeUnit_y[ 0 ][ snakeid[ i ] ] + DISTANCE, HEIGHT, 1000.0 );
                snakeDirection_x[ snakeid[ i ] ] = -DISTANCE;
				snakeDirection_y[ snakeid[ i ] ] = 0.000000;
			}
			else if( snakeid[ i ] == SNAKE_BLUE )
		 	{
                snakeUnits[ x ][ snakeid[ i ] ] = CreateObject( UNIT_ONE + snakeid[ i ], gameAreaCoordinates[ 0 ], gameAreaCoordinates[ 0 ], HEIGHT, 0.0, 0.0, 0.0 );
				GetObjectPos( snakeUnits[ x ][ snakeid[ i ] ], snakeUnit_x[ x ][ snakeid[ i ] ], snakeUnit_y[ x ][ snakeid[ i ] ], z );
				MoveObject( snakeUnits[ 0 ][ snakeid[ i ] ], snakeUnit_x[ 0 ][ snakeid[ i ] ] + DISTANCE, snakeUnit_y[ 0 ][ snakeid[ i ] ] + DISTANCE, HEIGHT, 1000.0 );
                snakeDirection_x[ snakeid[ i ] ] = 0.000000;
				snakeDirection_y[ snakeid[ i ] ] = DISTANCE;
			}
			else if( snakeid[ i ] == SNAKE_YELLOW )
		 	{
                snakeUnits[ x ][ snakeid[ i ] ] = CreateObject( UNIT_ONE + snakeid[ i ],  gameAreaCoordinates[ 0 ], gameAreaCoordinates[ GAME_AREA_SIZE -1 ], HEIGHT, 0.0, 0.0, 0.0 );
                GetObjectPos( snakeUnits[ x ][ snakeid[ i ] ], snakeUnit_x[ x ][ snakeid[ i ] ], snakeUnit_y[ x ][ snakeid[ i ] ], z );
                MoveObject( snakeUnits[ 0 ][ snakeid[ i ] ], snakeUnit_x[ 0 ][ snakeid[ i ] ] + DISTANCE, snakeUnit_y[ 0 ][ snakeid[ i ] ] - DISTANCE, HEIGHT, 1000.0 );
                snakeDirection_x[ snakeid[ i ] ] = DISTANCE;
				snakeDirection_y[ snakeid[ i ] ] = 0.000000;
			}
		}
		
		switch( snakeid[ i ] )
        {
            case SNAKE_RED: 
			{
				GameTextForPlayer( i, "~n~~n~~w~You are ~r~red", 2300, 5 );
            }
			case SNAKE_GREEN:
			{
				GameTextForPlayer( i, "~n~~n~~w~You are ~g~green", 2300, 5 );
            }
			case SNAKE_BLUE:
			{
				GameTextForPlayer( i, "~n~~n~~w~You are ~b~blue", 2300, 5 );
            }
			case SNAKE_YELLOW:
			{
				GameTextForPlayer( i,  "~n~~n~~w~You are ~y~yellow", 2300, 5 );
            }
		}

        playerWorld[ i ] = GetPlayerVirtualWorld( i );
		SetPlayerVirtualWorld( i, i + 1 );
        PlayerPlaySound( i, 1057, 0.0, 0.0, 0.0 );
        TogglePlayerControllable( i, false );
        playing[ snakeid[ i ] ] = true;
	}
	
	if( computerJoin )
	{
	    computerTotalUnits = SNAKE_LENGTH;
        FOR( x = 0,inRange(SNAKE_LENGTH))
	 	{
	 	    computerUnits[ x ] = CreateObject( 19148, gameAreaCoordinates[ 0 ], gameAreaCoordinates[ GAME_AREA_SIZE -1 ], HEIGHT, 0.0, 0.0, 0.0 );
			GetObjectPos( computerUnits[ x ], computerUnit_x[ x ], computerUnit_y[ x ], z );
		}
	 	MoveObject( computerUnits[ 0 ], computerUnit_x[ 0 ] + DISTANCE, computerUnit_y[ 0 ] - DISTANCE, HEIGHT, 1000.0 );
   	}
   	return 1;
}

public OnPlayerUpdate(playerid)
{
	if( minigamer[ playerid ] && gameStarted > 1 )
	{
	    new
			Keys, ud, lr;

    	GetPlayerKeys( playerid, Keys, ud, lr);
	    if( ud < 0 && snakeDirection_y[ snakeid[ playerid ] ] != -DISTANCE )
		{
		    snakeDirection_y[ snakeid[ playerid ] ] = DISTANCE;
    		snakeDirection_x[ snakeid[ playerid ] ] = 0.0;
		}

	    else if( ud > 0 && snakeDirection_y[ snakeid[ playerid ] ] != DISTANCE )
		{
		    snakeDirection_y[ snakeid[ playerid ] ] = -DISTANCE;
    		snakeDirection_x[ snakeid[ playerid ] ] = 0.0;
		}

	    else if( lr > 0 && snakeDirection_x[ snakeid[ playerid ] ] != -DISTANCE )
		{
		    snakeDirection_y[ snakeid[ playerid ] ] = 0.000000;
    		snakeDirection_x[ snakeid[ playerid ] ] = DISTANCE;
		}

	    else if( lr < 0  && snakeDirection_x[ snakeid[ playerid ] ] != DISTANCE )
		{
		    snakeDirection_y[ snakeid[ playerid ] ] = 0.000000;
    		snakeDirection_x[ snakeid[ playerid ] ] = -DISTANCE;
		}
 	}
    return 1;
}


public OnObjectMoved(objectid)
{
	if( objectid == objectProgress )
 	{
 	    new
 	        Float:xs,
		 	Float:ys,
	 		Float:zs;

		GetObjectPos( objectProgress, xs, ys, zs );
		MoveObject( objectProgress, xs, ys + DISTANCE, zs, gameSpeed );
		GetObjectPos( objectItem, ITEM_x, ITEM_y, ITEM_z );

		if( IsValidObject( computerUnits[ 0 ] ) )
		{
		    new
				Float:dir_x = computerUnit_x[ 0 ],
				Float:dir_y = computerUnit_y[ 0 ];

			GetObjectPos( computerUnits[ 0 ], computerUnit_x[ 0 ], computerUnit_y[ 0 ], zs );

			if( random ( 20 ) > 17 )
			{
				if( ITEM_x < computerUnit_x[ 0 ] - ( DISTANCE / 2 ) && computerDirection_x != DISTANCE )
			  	{
	            	computerDirection_y = 0.000000;
		    		computerDirection_x = -DISTANCE;
				}
				else if( ITEM_x > computerUnit_x[ 0 ] + ( DISTANCE / 2 ) && computerDirection_x != -DISTANCE )
				{
	    			computerDirection_y = 0.000000;
		    		computerDirection_x = DISTANCE;
				}
				else if( ITEM_y < computerUnit_y[ 0 ] - ( DISTANCE / 2 ) && computerDirection_y != DISTANCE )
			  	{
	          		computerDirection_y = -DISTANCE;
		    		computerDirection_x = 0.0;
				}
				else if( ITEM_y > computerUnit_y[ 0 ] + ( DISTANCE / 2 ) && computerDirection_y != -DISTANCE )
				{
	    			computerDirection_y = DISTANCE;
		    		computerDirection_x = 0.0;
				}
			}
			else
			{
				if( ITEM_y < computerUnit_y[ 0 ] - ( DISTANCE / 2 ) && computerDirection_y != DISTANCE )
			  	{
	          		computerDirection_y = -DISTANCE;
		    		computerDirection_x = 0.0;
				}
				else if( ITEM_y > computerUnit_y[ 0 ] + ( DISTANCE / 2 ) && computerDirection_y != -DISTANCE )
				{
	    			computerDirection_y = DISTANCE;
		    		computerDirection_x = 0.0;
				}
				else if( ITEM_x < computerUnit_x[ 0 ] - ( DISTANCE / 2 ) && computerDirection_x != DISTANCE )
			  	{
	            	computerDirection_y = 0.000000;
		    		computerDirection_x = -DISTANCE;
				}
				else if( ITEM_x > computerUnit_x[ 0 ] + ( DISTANCE / 2 ) && computerDirection_x != -DISTANCE )
				{
	    			computerDirection_y = 0.000000;
		    		computerDirection_x = DISTANCE;
				}
			}

		    new
        		Float:tmp_x = computerDirection_x,
				Float:tmp_y = computerDirection_y;

			if( !isNextPositionValid( computerUnits[ 0 ], computerDirection_x, computerDirection_y ) )
			{
			    //With code below computer will analyze it's next possible move
				if( dir_y < computerUnit_y[ 0 ] - ( DISTANCE / 2 ) )
				{
				    if( computerDirection_x == DISTANCE || computerDirection_x == -DISTANCE )
   	    			{
   			        	computerDirection_y = DISTANCE;
        			    computerDirection_x = 0.0;

        			    if( !isNextPositionValid( computerUnits[ 0 ], computerDirection_x, computerDirection_y ) )
						{
    						computerDirection_y = 0.0;
				 			computerDirection_x = tmp_x*-1;
						}
					}
					else if( computerDirection_y == DISTANCE )
					{
					    computerDirection_x = -DISTANCE;
					    computerDirection_y = 0.0;

				    	if( computerTotalUnits > 4 )
					    {
		    			    if( computerUnit_x[ 0 ] + computerDirection_x < computerUnit_x[ computerTotalUnits -1 ] )
							computerDirection_x = computerDirection_x*-1;
						}

                        if( !isNextPositionValid( computerUnits[ 0 ], computerDirection_x, computerDirection_y ) )
						computerDirection_x = computerDirection_x*-1;
					}
				}
				else if( dir_y > computerUnit_y[ 0 ] + ( DISTANCE / 2 ) )
				{
				    if( computerDirection_x == DISTANCE || computerDirection_x == -DISTANCE )
   	    			{
               			computerDirection_y = -DISTANCE;
        			    computerDirection_x = 0.0;

        			    if( !isNextPositionValid( computerUnits[ 0 ], computerDirection_x, computerDirection_y ) )
						{
    						computerDirection_y = 0.0;
				 			computerDirection_x = tmp_x*-1;
				 		}
					}
					else if( computerDirection_y == -DISTANCE )
					{
					    computerDirection_x = -DISTANCE;
			    	 	computerDirection_y = 0.0;

       			    	if( computerTotalUnits > 4 )
					    {
		    			    if( computerUnit_x[ 0 ] + computerDirection_x < computerUnit_x[ computerTotalUnits -1 ] )
							computerDirection_x = computerDirection_x*-1;
						}

        			    if( !isNextPositionValid( computerUnits[ 0 ], computerDirection_x, computerDirection_y ) )
						computerDirection_x = computerDirection_x*-1;
					}
				}
				else if( dir_x < computerUnit_x[ 0 ] - ( DISTANCE / 2 ) )
				{
				    if( computerDirection_y == DISTANCE || computerDirection_y == -DISTANCE )
   	    			{
   	    			    computerDirection_x = DISTANCE;
        			    computerDirection_y = 0.0;

        			    if( !isNextPositionValid( computerUnits[ 0 ], computerDirection_x, computerDirection_y ) )
						{
    						computerDirection_x = 0.0;
				 			computerDirection_y = tmp_y*-1;
				 		}
					}
					else if( computerDirection_x == DISTANCE )
					{
          				computerDirection_y = -DISTANCE;
     					computerDirection_x = 0.0;

        			    if( computerTotalUnits > 4 )
					    {
		    			    if( computerUnit_y[ 0 ] + computerDirection_y < computerUnit_y[ computerTotalUnits -1 ] )
							computerDirection_y = computerDirection_y*-1;
						}

        			    if( !isNextPositionValid( computerUnits[ 0 ], computerDirection_x, computerDirection_y ) )
						computerDirection_y = computerDirection_y*-1;
					}
				}
				else if( dir_x > computerUnit_x[ 0 ] + ( DISTANCE / 2 ) )
				{
				    if( computerDirection_y == DISTANCE || computerDirection_y == -DISTANCE )
   	    			{
   	    			    computerDirection_x = -DISTANCE;
        			    computerDirection_y = 0.0;

        			    if( !isNextPositionValid( computerUnits[ 0 ], computerDirection_x, computerDirection_y ) )
						{
    						computerDirection_x = 0.0;
				 			computerDirection_y = tmp_y*-1;
				 		}
					}
					else if( computerDirection_x == -DISTANCE )
					{
					    computerDirection_y = -DISTANCE;
        			    computerDirection_x = 0.0;

       			    	if( computerTotalUnits > 4 )
					    {
		    			    if( computerUnit_y[ 0 ] + computerDirection_y < computerUnit_y[ computerTotalUnits -1 ] )
							computerDirection_y = computerDirection_y*-1;
						}

        			    if( !isNextPositionValid( computerUnits[ 0 ], computerDirection_x, computerDirection_y ) )
						computerDirection_y = computerDirection_y*-1;
					}
				}
			}

			MoveObject( computerUnits[ 0 ], computerUnit_x[ 0 ] + computerDirection_x, computerUnit_y[ 0 ] + computerDirection_y, HEIGHT, gameSpeed );

      		FOR( x = 1,inRange(computerTotalUnits))
		 	{
		 	    GetObjectPos( computerUnits[ x ], computerUnit_x[ x ], computerUnit_y[ x ], zs );
		 	    MoveObject( computerUnits[ x ], computerUnit_x[ x-1 ], computerUnit_y[ x-1 ], HEIGHT, gameSpeed/1.02 );
		 	}

		 	if( !isSnakePositionValid( computerUnits[ 0 ] ) )
			{
	  			FOR(x = 0,inRange(computerTotalUnits))
				DestroyObject( computerUnits[ x ] );
				computerUnits[ 0 ] = -1;
			}
			else if( computerUnit_x[ 0 ] <= ITEM_x + ( DISTANCE / 2 ) && computerUnit_y[ 0 ] <= ITEM_y + ( DISTANCE / 2 ) && computerUnit_x[ 0 ] >= ITEM_x - ( DISTANCE / 2 ) && computerUnit_y[ 0 ] >= ITEM_y - ( DISTANCE / 2 ) )
			{
				DestroyObject( objectItem );
		        objectItem = CreateObject( ITEM_MODEL, gameAreaCoordinates[ random(  GAME_AREA_SIZE - 3 ) + 2 ], gameAreaCoordinates[ random(  GAME_AREA_SIZE - 3 ) + 2 ], HEIGHT, 0.0, 0.0, 0.0 );
		        if( computerTotalUnits <= gameScore )
		        {
					GetObjectPos( computerUnits[ computerTotalUnits-1 ], computerUnit_x[ computerTotalUnits-1 ], computerUnit_y[ computerTotalUnits-1 ], zs );
					computerUnits[ computerTotalUnits ] = CreateObject( 19148, computerUnit_x[ computerTotalUnits-1 ], computerUnit_y[ computerTotalUnits-1 ], HEIGHT, 0.0, 0.0, 0.0 );
					computerTotalUnits++;
					if( computerTotalUnits == gameScore )
					winnerid = 'c';
				}
			}
  		}

     	foreach(Snake, i)
     	{
		    if( IsValidObject(  snakeUnits[ 0 ][ snakeid[ i ] ] ) )
		    {
	      		GetObjectPos( snakeUnits[ 0 ][ snakeid[ i ] ], snakeUnit_x[ 0 ][ snakeid[ i ] ], snakeUnit_y[ 0 ][ snakeid[ i ] ], zs );
			   	MoveObject( snakeUnits[ 0 ][ snakeid[ i ] ], snakeUnit_x[ 0 ][ snakeid[ i ] ] + snakeDirection_x[ snakeid[ i ] ], snakeUnit_y[ 0 ][ snakeid[ i ] ] + snakeDirection_y[ snakeid[ i ] ], HEIGHT, gameSpeed );

	      		FOR( x = 1,inRange(snakeTotalUnits[ snakeid[ i ] ]))
			 	{
			 	    GetObjectPos( snakeUnits[ x ][ snakeid[ i ] ], snakeUnit_x[ x ][ snakeid[ i ] ], snakeUnit_y[ x ][ snakeid[ i ] ], zs );
			 	    MoveObject( snakeUnits[ x ][ snakeid[ i ] ], snakeUnit_x[ x-1 ][ snakeid[ i ] ], snakeUnit_y[ x-1 ][ snakeid[ i ] ], zs, gameSpeed/1.02 );
				}

		 	 	if( !isSnakePositionValid( snakeUnits[ 0 ][ snakeid[ i ] ] ) )
		 	 	playing[ snakeid[ i ] ] = false; //if players snake position is invalid, he's out of the game

				//Check if player is playing
				if( !playing[ snakeid[ i ] ] )
				{
				    Iter_Remove(Snake, i );
				    if( snakeTotalUnits[ snakeid[ i ] ] < SNAKE_LENGTH + 1 )
				    ShowPlayerDialog( i, 1000 + snakeid[ i ] ,DIALOG_STYLE_MSGBOX,"Ups!","     You really screwed up this time.","I know", "");
				    //This dialog will pop up if you fail completely :)
					FOR(x = 0,inRange(snakeTotalUnits[ snakeid[ i ] ] ))
					DestroyObject( snakeUnits[ x ][ snakeid[ i ] ] );
					snakeUnits[ 0 ][ snakeid[ i ] ] = -1;
					SetTimerEx("ResetPlayerView", 2700, 0, "i", i );
					PlayerPlaySound( i, 1009, GAME_AREA_POS + ( DISTANCE * ( GAME_AREA_SIZE / 2 ) ), GAME_AREA_POS + ( DISTANCE * ( GAME_AREA_SIZE / 2 ) ), 60.0);
				}
				
				else if( snakeUnit_x[ 0 ][ snakeid[ i ] ] <= ITEM_x + ( DISTANCE / 2 ) && snakeUnit_y[ 0 ][ snakeid[ i ] ] <= ITEM_y + ( DISTANCE / 2 ) && snakeUnit_x[ 0 ][  snakeid[ i ] ] >= ITEM_x - ( DISTANCE / 2 ) && snakeUnit_y[ 0 ][ snakeid[ i ] ] >= ITEM_y - ( DISTANCE / 2 ) )
				{
					PlayerPlaySound( i, 1138, GAME_AREA_POS + ( DISTANCE * ( GAME_AREA_SIZE / 2 ) ), GAME_AREA_POS + ( DISTANCE * ( GAME_AREA_SIZE / 2 ) ), 65.0);
			  		DestroyObject( objectItem );
			        objectItem = CreateObject( ITEM_MODEL, gameAreaCoordinates[ random(  GAME_AREA_SIZE - 3 ) + 2 ] , gameAreaCoordinates[ random(  GAME_AREA_SIZE - 3 ) + 2 ], HEIGHT,  0.0, 0.0, 0.0 );
			        if( snakeTotalUnits[ snakeid[ i ] ] <= gameScore )
		        	{
						GetObjectPos( snakeUnits[ snakeTotalUnits[ snakeid[ i ] ]-1 ][ snakeid[ i ] ], snakeUnit_x[ snakeTotalUnits[ snakeid[ i ] ]-1 ][ snakeid[ i ] ], snakeUnit_y[ snakeTotalUnits[ snakeid[ i ] ]-1 ][ snakeid[ i ] ], zs );
						snakeUnits[ snakeTotalUnits[ snakeid[ i ] ] ][ snakeid[ i ] ] = CreateObject( UNIT_ONE + snakeid[ i ], snakeUnit_x[ snakeTotalUnits[ snakeid[ i ] ]-1 ][ snakeid[ i ] ], snakeUnit_y[ snakeTotalUnits[ snakeid[ i ] ]-1 ][ snakeid[ i ] ], HEIGHT, 0.0, 0.0, 0.0 );
	     				snakeTotalUnits[ snakeid[ i ] ]++;
						if( snakeTotalUnits[ snakeid[ i ] ] == gameScore )
						//When player obtains highest score, he's declared as winner, game will finish in 3 seconds
						winnerid = i;
					}
				}
			}
		}
		
		//================================================//
		if( Iter_Count(Snake) < 2 )
		{//less than 2 players left & no computer
		    if( Iter_Count(Snake) == 1 && !IsValidObject( computerUnits[ 0 ] ) )
		    {
				foreach(Snake, i )
				winnerid = i; //Last survival is winner
			}
			else if( Iter_Count(Snake) < 1 && IsValidObject( computerUnits[ 0 ] ) ) //if no-one else left but computer
			winnerid = 'c';
			
			else if( Iter_Count(Snake) < 1 && !IsValidObject( computerUnits[ 0 ] ) ) //if there are no-one left
			winnerid = ' '; //winner -none
     	}
		
		new
			str[ 64 ];
						//Gametext...
		//================================================//
		if( !computerJoin ) format( str, sizeof str, "~y~%i/%i ~r~%i/%i ~b~%i/%i ~g~%i/%i", snakeTotalUnits[ SNAKE_YELLOW ], gameScore, snakeTotalUnits[ SNAKE_RED ], gameScore, snakeTotalUnits[ SNAKE_BLUE ], gameScore, snakeTotalUnits[ SNAKE_GREEN ], gameScore );
		else format( str, sizeof str, "~p~%i/%i ~r~%i/%i ~b~%i/%i ~g~%i/%i", computerTotalUnits, gameScore, snakeTotalUnits[ SNAKE_RED ], gameScore, snakeTotalUnits[ SNAKE_BLUE ], gameScore, snakeTotalUnits[ SNAKE_GREEN ], gameScore );
		foreach(Snake, i ) GameTextForPlayer( i, str, 2999, 4 );
		
		if( winnerid != -1 )
	    {
	        if( winnerid == 'c' ) //computer/purple snake wins
	        {
	            foreach(Player, i )
				{
					if( minigamer[ i ] ) GameTextForPlayer( i, "~n~~n~~n~~n~~n~~p~Purple ~w~has won!", 2899, 3 );
				}
			}
			else if( winnerid != ' ' )
			{
			    new
			        pName[ MAX_PLAYER_NAME ];
					
			    GetPlayerName( winnerid, pName, MAX_PLAYER_NAME );
		        switch( snakeid[ winnerid ] )
		        {
		            case SNAKE_RED: 	//Red snake wins..
					{
						foreach(Player, i )
						{
							if( minigamer[ i ] ) GameTextForPlayer( i, "~n~~n~~n~~n~~n~~r~Red ~w~has won!", 2899, 3 );
						}
		            }
					case SNAKE_GREEN: 	//Green snake wins..
					{
						foreach(Player, i )
						{
							if( minigamer[ i ] ) GameTextForPlayer( i, "~n~~n~~n~~n~~n~~g~Green ~w~has won!", 2899, 3 );
						}
		            }
					case SNAKE_BLUE: 	//Blue snake wins..
					{
						foreach(Player, i )
						{
							if( minigamer[ i ] ) GameTextForPlayer( i, "~n~~n~~n~~n~~n~~b~Blue ~w~has won!", 2899, 3 );
						}
		            }
					case SNAKE_YELLOW: 	//Yellow snake wins..
					{
						foreach(Player, i )
						{
							if( minigamer[ i ] ) GameTextForPlayer( i, "~n~~n~~n~~n~~n~~y~Yellow ~w~has won!", 2899, 3 );
						}
		            }
				}
				format( str, sizeof str, "* %s has won Snake multiplayer game! Congratulations!", pName );
				SendClientMessageToAll( 0xF69521AA, str );
			}
            DestroyObject( objectProgress );
            DestroyObject( objectItem );
			//End game progress by destroying the main object
			SetTimer("ResetGame", 2800, 0 );
			winnerid = -1;
		}
	}
    return 1;
}

PUBLIC:ResetGame( )
{
    FOR( x = 0,inRange(MAX_SNAKES))
    {
        FOR( i = 0,inRange(MAX_SCORE))
       	{
       	    if( IsValidObject( snakeUnits[ i ][ x ] ) )
			DestroyObject( snakeUnits[ i ][ x ] );
			if( IsValidObject( computerUnits[ i ] ) )
			DestroyObject( computerUnits[ i ] );
		}
		snakeUnits[ 0 ][ x ] = -1;
		snakeTotalUnits[ x ] = 0;
		playing[ x ] = false;
	}
	computerUnits[ 0 ] = -1;

	DestroyObject( objectPlatform );

    FOR( i = 0,inRange(sizeof greenThing))
	DestroyObject( greenThing[ i ] );
	
	computerJoin = false;
	gameStarted = 0;
 	
 	//SendClientMessageToAll( 0xF69521AA, "* Snake multiplayer has ended." );
	//Reset camera views...
	foreach(Snake, i)
	ResetPlayerView( i );

	Iter_Clear(Snake);
	return 1;
}

PUBLIC:ResetPlayerView( playerid )
{
    minigamer[ playerid ] = false;
	snakeid[ playerid ] = -1;
    SetPlayerVirtualWorld( playerid, playerWorld[ playerid ] );
	SetCameraBehindPlayer( playerid );
	GameTextForPlayer( playerid, " ", 1000, 4 );
	TogglePlayerControllable( playerid, true );
	SetPlayerTime( playerid, 13, 37 );
}

stock sgetSnakeID( player )
{
    FOR( i = 0,inRange(MAX_SNAKES))
	if( snakeid[ player ] == i ) return i;

	return -1;
}

stock sgetPlayerID( snake )
{
    foreach(Snake, i)
	if( snakeid[ i ] == snake ) return i;

	return -1;
}

stock isNextPositionValid( snake, Float:dx, Float:dy )
{
    new
		Float:x,
		Float:y,
		Float:x2,
		Float:y2,
		Float:z;

    GetObjectPos( snake, x, y, z );
    FOR( i = 0,inRange(computerTotalUnits))
	{
	    if( computerUnits[ i ] != snake )
	    {
			GetObjectPos( computerUnits[ i ], x2, y2, z );
			if( ( x + dx <= x2 + ( DISTANCE / 2 ) && y + dy <= y2 + ( DISTANCE / 2 ) ) && ( x + dx >= x2 - ( DISTANCE / 2 ) && y + dy >= y2 - ( DISTANCE / 2 ) ) )
            return 0;
		}
	}
	if( x + dx <= ( gameAreaCoordinates[ 0 ] - 1.0 ) + ( DISTANCE / 2 ) || y + dy >= ( gameAreaCoordinates[ GAME_AREA_SIZE -1 ] + 1.0 ) - ( DISTANCE / 2 ) || y + dy <= ( gameAreaCoordinates[ 0 ] - 1.0 ) + ( DISTANCE / 2 ) || x + dx >= ( gameAreaCoordinates[ GAME_AREA_SIZE -1 ] + 1.0 ) - ( DISTANCE / 2 ) )
	return 0;
	

  	foreach(Snake, a )
 	{
 	    if( IsValidObject( snakeTotalUnits[ snakeid[ a ] ] ) )
 	    {
		    FOR( i = 0,inRange(snakeTotalUnits[ snakeid[ a ] ]))
			{
				GetObjectPos( snakeUnits[ i ][ snakeid[ a ] ], x2, y2, z );
				if( i < 1 )
				{
					if ( ( x + dx <= x2 + snakeDirection_x[ snakeid[ a ] ] + ( DISTANCE / 2 ) && y + dy <= y2 + snakeDirection_y[ snakeid[ a ] ] + ( DISTANCE / 2 ) ) && ( x + dx >= x2 + snakeDirection_x[ snakeid[ a ] ] - ( DISTANCE / 2 ) && y + dy >= y2 + snakeDirection_y[ snakeid[ a ] ] - ( DISTANCE / 2 ) ) )
					return 0;
				}
				else
				{
					if ( ( x + dx <= x2 + ( DISTANCE / 2 ) && y + dy <= y2 + ( DISTANCE / 2 ) ) && ( x + dx >= x2 - ( DISTANCE / 2 ) && y + dy >= y2 - ( DISTANCE / 2 ) ) )
					return 0;
				}
			}
		}
	}
	return 1;
}


stock isSnakePositionValid( snake )
{
    new
		Float:x,
		Float:y,
		Float:x2,
		Float:y2,
		Float:z;

    GetObjectPos( snake, x, y, z );
   	FOR( i = 0,inRange(computerTotalUnits))
	{
	    if( computerUnits[ i ] != snake )
	    {
			GetObjectPos( computerUnits[ i ], x2, y2, z );
			if ( x <= x2 + ( DISTANCE / 2 ) && y <= y2 + ( DISTANCE / 2 ) && x >= x2 - ( DISTANCE / 2 ) && y >= y2 - ( DISTANCE / 2 ) )
            return 0;
		}
	}
	if( x <= ( gameAreaCoordinates[ 0 ] - 1.0 ) + ( DISTANCE / 2 ) || y >= ( gameAreaCoordinates[ GAME_AREA_SIZE -1 ] + 1.0 ) - ( DISTANCE / 2 ) || y <= ( gameAreaCoordinates[ 0 ] - 1.0 ) + ( DISTANCE / 2 ) || x >= ( gameAreaCoordinates[ GAME_AREA_SIZE -1 ] + 1.0 ) - ( DISTANCE / 2 ) )
	return 0;

 	foreach(Snake, a)
 	{
 	    if( IsValidObject( snakeTotalUnits[ snakeid[ a ] ] ) )
 	    {
		    FOR( i = 0,inRange(snakeTotalUnits[ snakeid[ a ] ]))
			{
			    if( snakeUnits[ i ][ snakeid[ a ] ] != snake )
			    {
					GetObjectPos( snakeUnits[ i ][ snakeid[ a ] ], x2, y2, z );
					if ( ( x <= x2 + ( DISTANCE / 2 ) && y <= y2 + ( DISTANCE / 2 ) ) && ( x >= x2 - ( DISTANCE / 2 ) && y >= y2 - ( DISTANCE / 2 ) ) )
					{
					    if( i < 1 ) playing[ snakeid[ a ] ] = false;
		                return 0;
					}
				}
			}
		}
	}
	return 1;
}
