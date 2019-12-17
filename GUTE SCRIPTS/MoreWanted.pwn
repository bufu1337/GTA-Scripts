#include <a_samp>
#pragma tabsize 4
// ----------------------------------------
//  Extended wanted level FS, by [Nx]Slice
// ----------------------------------------
new bool:gme;
public OnGameModeInit(){
	if ( gme )
		DoInit();

	gme = false;
	new playerid;
	for ( playerid = 0; playerid < GetMaxPlayers(); playerid++ ){
		SetPlayerWantedLevel( playerid, 0 );
	}
	return 1;
}
public OnGameModeExit    () { gme =  true; DoExit(); return 1; }
public OnFilterScriptInit() {              DoInit(); return 1; }
public OnFilterScriptExit() {              DoExit(); return 1; }
#define WLCheck(%1) if ( GetPlayerWantedLevel( playerid ) >= %1 ) TextDrawShowForPlayer( playerid, tStar%1 ); else TextDrawHideForPlayer( playerid, tStar%1 )
new Text:tStar7, Text:tStar8, Text:tStar9, Text:tStar10, Text:tStar11, Text:tStar12, UPDTimer;
Text:CreateStarTD( starnum ){
	new Text:tStar = TextDrawCreate( 503.5 - ( 18 * ( starnum - 7 ) ), 102.1, "]" );
	TextDrawColor          ( tStar, 0x906210FF );
	TextDrawBackgroundColor( tStar, 0x000000AA );
	TextDrawFont           ( tStar,          2 );
	TextDrawSetShadow      ( tStar,          0 );
	TextDrawSetProportional( tStar,       true );
	TextDrawLetterSize     ( tStar,  0.6,  2.4 );
	TextDrawAlignment      ( tStar,          3 );
	TextDrawSetOutline     ( tStar,          1 );
	return tStar;
}
DoInit(){
	tStar7  = CreateStarTD(  7 );
	tStar8  = CreateStarTD(  8 );
	tStar9  = CreateStarTD(  9 );
	tStar10 = CreateStarTD( 10 );
	tStar11 = CreateStarTD( 11 );
	tStar12 = CreateStarTD( 12 );
	UPDTimer = SetTimer( "Wlevel_UPD", 250, 1 );
}
DoExit(){
	TextDrawDestroy( tStar7 );
	TextDrawDestroy( tStar8 );
	TextDrawDestroy( tStar9 );
	TextDrawDestroy( tStar10 );
	TextDrawDestroy( tStar11 );
	TextDrawDestroy( tStar12 );
	KillTimer( UPDTimer );
}
forward Wlevel_UPD();
public  Wlevel_UPD(){
	new playerid;
	for ( playerid = 0; playerid < GetMaxPlayers(); playerid++ )
	{
		WLCheck(7);
		WLCheck(8);
		WLCheck(9);
		WLCheck(10);
		WLCheck(11);
		WLCheck(12);
	}
}
