/*
arc.pwn
Textdraw Arcanoid by OFFREAL
22.08.2011
NOT Commercial - OpenSource

// WARNING !!!
Irrational use of server resources !

Textdraws: 67
Timers: 1 ( 50 ms )
*/

#include <a_samp>

#define VERSION "1.0 beta"
#define MAX_BLOCKS 60		// maximum blocks
#define MAX_LVL 3       	// maximum levels

forward UpdateBall();

// basic variables
new
    Arcanoid,	// basic timer

	Float: ball_a = 8.0,                            // vector step
	Float: ball_vector[2],                          // ball vector
	Float: ball_coord[2],                           // ball coordinates
	Float: ball_td_offset[2] = { -6.00, -9.00 },    // offset of textdraw centre
	Float: bar_Y = 440.00,                          // surface of the reflector
	Float: bar_X,                                   // reflector coordinates
	Float: BarSize = 80.00,                         // reflector size
	Float: K,                                       // square factor

	Text: ball_td,              // textdraw ball
	Text: bar_td,               // textdraw reflector
	Text: ScoreTD,              // textdraw score
	Text: BKG,                  // textdraw background
	Text: InfoTD,               // textdraw info
	Text: block_td[MAX_BLOCKS], // textdraws blocks

	Score,              // score
	CurLVL,             // current level
	WaitTime = -1,      // pause of basic timer
	arc_player = -1,    // ID of player
	ball_speed = 50,    // timer frequency

	killed, // var for count of "dead blocks"
	time;   // unix_time
enum b_info {
Float:maxX, Float:maxY, Float:minX, Float:minY,
Float:bc, stat, bool:active
}
new block[MAX_BLOCKS][b_info];
new ColorBlock[] = { 0, 0xFF000044, 0xFF800044, 0xFFFF0044, 0x00FF0044, 0x00FFFF44 };
new block_stat[MAX_LVL][MAX_BLOCKS] = {
{
1,2,3,3,4,5,5,4,3,3,2,1,
1,2,3,4,5,4,4,5,4,3,2,1,
1,2,3,4,5,5,5,5,4,3,2,1,
1,2,3,4,5,4,4,5,4,3,2,1,
1,2,3,4,3,4,4,3,4,3,2,1
},
{
4,3,4,0,0,1,1,0,0,4,3,4,
4,4,3,4,0,1,1,0,4,3,4,4,
4,2,4,3,4,1,1,4,3,4,2,4,
0,4,2,4,4,1,1,4,4,2,4,0,
4,0,4,2,0,4,4,0,2,4,0,4
},
{
3,2,1,0,0,5,5,0,0,1,2,3,
4,3,2,1,0,0,0,0,1,2,3,4,
0,4,3,2,1,0,0,1,2,3,4,0,
0,0,4,3,2,1,1,2,3,4,0,0,
0,0,0,4,3,2,2,3,4,0,0,0
}
};
stock minrand(min, max){
   return random(max - min) + min;
}
stock Float:floatrand(Float:min, Float:max){
	new imin;
	imin = floatround(min);
	return float(random((floatround(max) - imin) * 100) + (imin * 100)) / 100.0;
}
stock DrawBoll(Float: X, Float: Y){
	TextDrawDestroy( ball_td );
	ball_td = TextDrawCreate(X + ball_td_offset[0], Y + ball_td_offset[1], "o");
	TextDrawSetShadow(ball_td, 0);
	TextDrawFont(ball_td, 1);
	TextDrawLetterSize(ball_td,0.4, 1.3 );
	ball_coord[0] = X; ball_coord[1] = Y;
	TextDrawShowForPlayer(arc_player, ball_td);
}
stock DrawBKG(){
	TextDrawDestroy( BKG );
    BKG = TextDrawCreate( 0.00, 0.00, "_");
    TextDrawUseBox(BKG ,1);
    TextDrawBoxColor(BKG, 0x00000080 );
    TextDrawTextSize(BKG, 640.00,0.00);
    TextDrawLetterSize(BKG, 0.00, 480.00*0.135 );
    TextDrawShowForPlayer(arc_player, BKG);
}
stock DrawBlock( bid, st ){
	if( block[bid][active] ){
	    TextDrawDestroy( block_td[ bid ] );
	}
    block_td[ bid ] = TextDrawCreate(block[bid][minX], block[bid][minY], "_");
    TextDrawUseBox(block_td[ bid ],1);
    TextDrawBoxColor(block_td[ bid ], ColorBlock[st] );
    TextDrawTextSize(block_td[ bid ],block[bid][maxX],0.00);
    TextDrawLetterSize(block_td[ bid ],0.00, (block[bid][maxY] - block[bid][minY])*0.102 );
    TextDrawShowForPlayer(arc_player, block_td[ bid ]);
    block[bid][active] = true;
    block[bid][ stat ] = st;
    block[bid][bc] = ( block[bid][maxY] - block[bid][minY] )/( block[bid][maxX] - block[bid][minX] );
}
stock MoveBar( Float:step ){
    bar_X += step;
    if(bar_X > 580.00){
		bar_X = 580.00;
	}
    else if( bar_X < -20.00 ){
		bar_X = -20.00;
	}
    TextDrawDestroy( bar_td );
    bar_td = TextDrawCreate( bar_X, bar_Y, "_");
    TextDrawUseBox(bar_td, 1);
    TextDrawBoxColor(bar_td, -1 );
    TextDrawTextSize(bar_td, bar_X + BarSize, 0.00);
    TextDrawLetterSize(bar_td, 0.00, 10.00 );
    TextDrawShowForPlayer(arc_player, bar_td);
}
stock IsBallInBlock( Float:X, Float:Y, Float:mxX, Float:mxY, Float:mnX, Float:mnY ){
	if( X > mxX ) {return false;}
	if( Y > mxY ) {return false;}
	if( X < mnX ) {return false;}
	if( Y < mnY ) {return false;}
	return true;
}
stock LoadLevel( lvl ){
    if( arc_player == -1 ) { return; }
    new str[64]; format(str, 64, "~r~Level ~w~%d", lvl);
    SendInfo( str );
    WaitTime = 50;
    CurLVL = lvl;
 	DrawBKG();
	bar_X = 0.00;
	MoveBar( 280.00 );
	ball_coord[0] = bar_X + 40.00;
    ball_coord[1] = bar_Y + ball_td_offset[1];
    ball_vector[0] = 0.25 - float(random(50))/100; ball_vector[1] = -0.75;
    for(new i=0;i<MAX_BLOCKS;i++){
        DrawBlock( i , block_stat[lvl][ i ]);
	}
}
stock SendInfo( text[] ){
	TextDrawSetString(InfoTD, text);
	TextDrawShowForPlayer(arc_player, InfoTD);
}
stock SetScore( toscore ){
	Score += toscore;
	new str[64];
	if(Score < 0){ format(str, sizeof(str),"~r~%d",Score); }
	else if( Score < 3000 ){ format(str, sizeof(str),"~w~%d",Score); }
	else if( Score < 6000 ){ format(str, sizeof(str),"~y~~h~%d",Score); }
	else if( Score < 9000 ){ format(str, sizeof(str),"~g~~h~%d",Score); }
	else if( Score < 12000 ){ format(str, sizeof(str),"~b~~h~%d",Score); }
	else{ format(str, sizeof(str),"~p~~h~%d",Score); }
    TextDrawSetString(ScoreTD, str);
    TextDrawShowForPlayer(arc_player, ScoreTD);
}
public UpdateBall(){
	if( WaitTime > 0){
		WaitTime--;
		return;
	}
	else if( WaitTime == 0 ){
	    ball_coord[0] = bar_X + 40.00;
        ball_coord[1] = bar_Y + ball_td_offset[1] ;
        ball_vector[0] = 0.25 - float(random(50))/100; ball_vector[1] = -0.75;
        TextDrawHideForPlayer(arc_player, InfoTD);
	    WaitTime = -1;
	}

	if(arc_player != -1){
		if( time && time < gettime() ){
			SetScore( -10 );
		}
		time = gettime();
		new lr;
		GetPlayerKeys(arc_player, lr, lr, lr);
		// move reflector
    	if(lr > 0) { MoveBar( 10.00 ); }
    	else if(lr < 0) { MoveBar( -10.00 ); }
	    // contacl left-right borders
		if( ball_coord[0] > 640.00+ball_td_offset[0] || ball_coord[0] < - ball_td_offset[0] ){
	 	   ball_vector[0] *= -1;
	 	   //ball_vector[0] += float(minrand( -150, 150 ))/1000;
		}
		// contact up border
		if( ball_coord[1] < - ball_td_offset[1] ){
	 	   ball_vector[1] *= -1;
	 	   //ball_vector[1] += float(minrand( -150, 150 ))/1000;
		}
		// contact down border - check reflector
		if( ball_coord[1] > bar_Y + ball_td_offset[1] ){
		    if( bar_X - 5.00 < ball_coord[0] < bar_X + BarSize + 5.00 ){
		        ball_vector[1] *= -1;
		        if(lr > 0){
					ball_vector[0] += 0.20;
				}
    			else if(lr < 0){
					ball_vector[0] -= 0.20;
				}
			 	if( ball_vector[0] > 1.00 ) { ball_vector[0] = 1.00; }
     			else if( ball_vector[0] < -1.00 ) { ball_vector[0] = -1.00; }

			}
			else{
			    SetScore( -5000 );
			    SendInfo( "~r~LOOSER !!!" );
			    WaitTime = 60;
			}
		}
		// auto increase speed
		if( -0.75 < ball_vector[1] < 0.75 ){
		    if(ball_vector[1] < 0) { ball_vector[1] -= 0.01; }
		    else {ball_vector[1] += 0.01;}
		}
   		// contact blocks
        for(new i=0;i<MAX_BLOCKS;i++){
    	    if( !block[i][stat] ) { killed++; continue; }
			if(	IsBallInBlock(	ball_coord[0] + ball_vector[0]*ball_a, ball_coord[1] + ball_vector[1]*ball_a,
				block[i][maxX], block[i][maxY], block[i][minX], block[i][minY] )){
				K = ( ball_coord[1] - (block[i][maxY]+block[i][minY])*0.5 ) /
					( ball_coord[0] - (block[i][maxX]+block[i][minX])*0.5 );
                block[i][ stat ] --;
                DrawBlock(i, block[i][ stat ]);
				PlayerPlaySound(arc_player,1056, 0.00, 0.00, 0.00);
				SetScore( 100 );
                if( floatabs( K ) > block[i][ bc ] ){
                    ball_vector[1] *= -1;
                    ball_vector[0] += float(minrand( -150, 150 ))/1000;
                    if( ball_vector[0] > 1.00 ) { ball_vector[0] = 1.00; }
                    else if( ball_vector[0] < -1.00 ) { ball_vector[0] = -1.00; }
				}
				else{
				    ball_vector[0] *= -1;
				    ball_vector[1] += float(minrand( -150, 150 ))/1000;
        			if( ball_vector[1] > 1.00 ) { ball_vector[1] = 1.00; }
                    else if( ball_vector[1] < -1.00 ) { ball_vector[1] = -1.00; }
				}
			    break;
			}
		}
		killed = 0;
		// "death blocks" count
		for(new i=0;i<MAX_BLOCKS;i++){
    	    if( !block[i][stat] ) { killed++; }
			if( killed == MAX_BLOCKS ) { LoadLevel( ( CurLVL+1 )%MAX_LVL ); WaitTime = 60; }
		}
		// redraw ball
        DrawBoll( ball_coord[0] + ball_vector[0]*ball_a, ball_coord[1] + ball_vector[1]*ball_a );

	}
}
public OnFilterScriptInit(){
	TextDrawCreate(640.00, 480.00, "BuggedTD");
	for(new i =0; i<MAX_BLOCKS; i++){
    	block[i][minX] = 30.00 + ( i%12 )*50;
    	block[i][maxX] = block[i][minX] + 30.00;

    	block[i][minY] = 20.00 + (i/12)*50;
    	block[i][maxY] = block[i][minY] + 30.00;
    }
    ball_td = TextDrawCreate(0.00, 0.00, "o");
    BKG = TextDrawCreate( 0.00, 0.00, "_");
	InfoTD = TextDrawCreate(320.00, 360.00, "_" );
	TextDrawLetterSize(InfoTD, 1.25, 3.00 );
	TextDrawAlignment(InfoTD, 0);
	ScoreTD = TextDrawCreate(85.00, 370.00, "_" );
	TextDrawLetterSize(ScoreTD, 0.80, 2.00 );
	TextDrawAlignment(ScoreTD, 2);
    DrawBoll( 40.00, 40.00 );
    Arcanoid = SetTimer("UpdateBall",ball_speed, true);
	return 1;
}
public OnFilterScriptExit(){
	KillTimer( Arcanoid );
    TextDrawDestroy( ball_td );
    for(new i=0;i<MAX_BLOCKS;i++){
		TextDrawDestroy( block_td[ i ] );
	}
	TextDrawDestroy( bar_td );
	TextDrawDestroy( BKG );
	TextDrawDestroy( InfoTD );
	TextDrawDestroy( ScoreTD );
	TogglePlayerControllable(arc_player,1);
	return 1;
}
main(){
	print("\n----------------------------------");
	print("FS Arconoid by OFFREAL");
	print("----------------------------------\n");
}
public OnPlayerCommandText(playerid, cmdtext[]){
	if (strcmp("/arc", cmdtext, true, 10) == 0){
		if( arc_player != -1 ){
		    SendClientMessage(playerid, -1, "Accanoid now in use =(");
			return 1;
		}
		Score = 0;
		TogglePlayerControllable(playerid,0);
	    arc_player = playerid;
		LoadLevel( 0 );
		return 1;
	}
	if (strcmp("/arc_stop", cmdtext, true, 10) == 0){
	    if( playerid != arc_player ){
		    SendClientMessage(playerid, -1, "You do not play to Arcanoid");
			return 1;
		}
	    TogglePlayerControllable(arc_player,1);
	    TextDrawHideForPlayer(arc_player, bar_td);
	    TextDrawHideForPlayer(arc_player, BKG);
	    TextDrawHideForPlayer(arc_player, ball_td);
	    TextDrawHideForPlayer(arc_player, InfoTD);
	    TextDrawHideForPlayer(arc_player, ScoreTD);
		for(new i=0;i<MAX_BLOCKS;i++){
        	TextDrawHideForPlayer(arc_player, block_td[ i ]);
		}
 		arc_player = -1;
	}
	return 0;
}