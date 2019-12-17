/*******************************************************/
/* Experimental Cursor FilterScript for SA-MP          */
/* Made by iPLEOMAX ©.                                 */
/* > Works well when player is aiming wtih a           */
/*   Sniper Rifle/HeatSeeker/RPG.                      */
/* > I gave sniper so that they can't                  */
/*   boom themselves.. xD                              */
/* WARNING! You are not allowed to remove any credits! */
/*******************************************************/

#include < a_samp >
#define frc(%0) floatround(%0*100, floatround_ceil)
forward EnableCursor( playerid );
forward DisableCursor( playerid );
forward CursorCheck( playerid );
new Text:CursorBG;
enum iM_Configs{
	bool:Enabled,
	Timer,
	CX, CY,
	Text:PointerP1,
	Text:PointerP2
};
new iM[MAX_PLAYERS][iM_Configs];
public OnFilterScriptInit(){
	print("\n * On-Screen Cursor FS Loaded! - iPLEOMAX \n");

	CursorBG = TextDrawCreate(665.000000, 0.000000, "ScreenB");
	TextDrawBackgroundColor(CursorBG, 255);
	TextDrawFont(CursorBG, 1);
	TextDrawLetterSize(CursorBG, 0.000000, 50.800003);
	TextDrawColor(CursorBG, -1);
	TextDrawSetOutline(CursorBG, 0);
	TextDrawSetProportional(CursorBG, 1);
	TextDrawSetShadow(CursorBG, 1);
	TextDrawUseBox(CursorBG, 1);
	TextDrawBoxColor(CursorBG, 255);
	TextDrawTextSize(CursorBG, -65.000000, 0.000000);

	return true;
}
public OnFilterScriptExit(){
	print(" * On-Screen Cursor FS exited."); return true;
}
public OnPlayerDisconnect( playerid, reason ){
	return DisableCursor( playerid );
}
public OnPlayerCommandText( playerid, cmdtext[] ){
	if (!strcmp("/cursor", cmdtext, true))	{
		if(!iM[playerid][Enabled]) { EnableCursor( playerid ); }
		else { DisableCursor( playerid ); }
		return true;
	}
	if (!strcmp("/backgr", cmdtext, true)){
		TextDrawShowForPlayer( playerid, CursorBG );
		return true;
	}
	return false;
}
public OnPlayerKeyStateChange( playerid, newkeys, oldkeys ){
	if(newkeys & KEY_FIRE && iM[playerid][Enabled]){
		new str[64];
		format(str, sizeof(str), "Mouse Location - X: %i, Y: %i", iM[playerid][CX], iM[playerid][CY]);
		SendClientMessage(playerid, -1, str);
	}
}
public EnableCursor( playerid ){
    if(GetPlayerState(playerid) != 1) return SendClientMessage(playerid, -1, "You need to be on-foot to use this command.");

	TextDrawShowForPlayer( playerid, CursorBG );
	GivePlayerWeapon( playerid, 34, -1 );
	//SetPlayerInterior(playerid, 1);
	SetPlayerVirtualWorld( playerid, playerid+MAX_PLAYERS );
	//iM[playerid][CX] = 320; iM[playerid][CY] = 240;
    iM[playerid][Timer] = SetTimerEx( "CursorCheck", 100, true, "d", playerid );
	iM[playerid][Enabled] = true;
	return true;
}
public DisableCursor( playerid ){
	KillTimer( iM[playerid][Timer] );
    TextDrawDestroy( iM[playerid][PointerP1] );
	TextDrawDestroy( iM[playerid][PointerP2] );
    TextDrawHideForPlayer( playerid, CursorBG );
	//SpawnPlayer( playerid );
	SetPlayerInterior( playerid, 0 );
	SetPlayerVirtualWorld( playerid, 0 );
	iM[playerid][Enabled] = false;
	return true;
}
public CursorCheck( playerid ){
	if(!iM[playerid][Enabled]) return true;
	if(GetPlayerState(playerid) != 1) return true;

	//SetPlayerFacingAngle(playerid, 0);
	//SetCameraBehindPlayer(playerid);
	new Float:P[3];
	GetPlayerCameraFrontVector( playerid, P[0], P[1], P[2] );
	Cursor( playerid, 320+frc(P[0])-1, 240+(frc(P[2])+4)*-1 );

	return true;
}
stock Cursor( playerid, X, Y ){
	if(X>640) X=640; if(Y>480) Y=480;
	if(X<0) X=0; if(Y<0) Y=0;

	//iM[playerid][CX]=X;
	//iM[playerid][CY]=Y;

	TextDrawDestroy( iM[playerid][PointerP1] );
	TextDrawDestroy( iM[playerid][PointerP2] );

    iM[playerid][PointerP1] = TextDrawCreate(X, Y, "\\_");
	TextDrawBackgroundColor(iM[playerid][PointerP1], 255);
	TextDrawFont(iM[playerid][PointerP1], 1);
	TextDrawLetterSize(iM[playerid][PointerP1], 0.670000, 1.200000);
	TextDrawColor(iM[playerid][PointerP1], -1);
	TextDrawSetOutline(iM[playerid][PointerP1], 0);
	TextDrawSetProportional(iM[playerid][PointerP1], 1);
	TextDrawSetShadow(iM[playerid][PointerP1], 0);

	iM[playerid][PointerP2] = TextDrawCreate(X-2.000000, Y-1.000000, "\\_");
	TextDrawBackgroundColor(iM[playerid][PointerP2], 255);
	TextDrawFont(iM[playerid][PointerP2], 2);
	TextDrawLetterSize(iM[playerid][PointerP2], 1.120000, 1.200000);
	TextDrawColor(iM[playerid][PointerP2], -1);
	TextDrawSetOutline(iM[playerid][PointerP2], 0);
	TextDrawSetProportional(iM[playerid][PointerP2], 1);
	TextDrawSetShadow(iM[playerid][PointerP2], 0);

	TextDrawShowForPlayer( playerid, iM[playerid][PointerP1] );
	TextDrawShowForPlayer( playerid, iM[playerid][PointerP2] );
}