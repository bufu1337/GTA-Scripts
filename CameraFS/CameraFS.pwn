#include <a_samp>
new bool:PlayerFilm[MAX_PLAYERS];
new cameraid[MAX_PLAYERS];
new Float:TempCoo[MAX_PLAYERS][4];
new Weaps[MAX_PLAYERS][13];
new Ammo[MAX_PLAYERS][13];

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("   Camera Mode Filterscript by KANiS");
	print("--------------------------------------\n");
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp(cmdtext, "/cam", true))
    {
    if (PlayerFilm[playerid]){
	DestroyVehicle(cameraid[playerid]);
	TogglePlayerSpectating(playerid, 0);
	SetPlayerPos(playerid,TempCoo[playerid][0],TempCoo[playerid][1],TempCoo[playerid][2]);
	SetPlayerFacingAngle(playerid,TempCoo[playerid][3]);
	ResetPlayerWeapons(playerid);
	for(new w = 0; w <13; w++){ if (Weaps[playerid][w] != 0) GivePlayerWeapon(playerid,Weaps[playerid][w],Ammo[playerid][w]);}
	PlayerFilm[playerid]=false; return 1;}
    for(new w = 0; w <13; w++){GetPlayerWeaponData(playerid,w,Weaps[playerid][w],Ammo[playerid][w]);}
   	GetPlayerPos(playerid,TempCoo[playerid][0],TempCoo[playerid][1],TempCoo[playerid][2]);
	GetPlayerFacingAngle(playerid,TempCoo[playerid][3]);
    TogglePlayerSpectating(playerid, 1);
	new id = CreateVehicle(594,TempCoo[playerid][0],TempCoo[playerid][1],TempCoo[playerid][2],0,-1,-1,-1);
	SetVehicleVirtualWorld(id,GetPlayerVirtualWorld(playerid)+1);
	PlayerSpectateVehicle(playerid,id);
	cameraid[playerid]=id;
	PlayerFilm[playerid]=true;
	return 1;}
	
	return 0;
}
