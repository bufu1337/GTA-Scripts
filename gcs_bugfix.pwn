/**====================================================================================
								Bug Fix	
								


Description:
	Fix some PAWN-SAMP bugs.
	
Legal:
	Copyright (C) 2009 ,GCS Team
	
	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
	MA 02110-1301, USA.
	
	
Version:
	0.2.0
Changelog:
	08/07/26:
		Update to 0.2.0
		Remove some useless info in source code.
		Bug fix:
			A new bug on GetPlayerMenu 
			A new bug on SpawnPlayer
			GetPlayerAmmo marked as fix, but it haven't been fixed.
			GetPlayerWeapon is a bug fix for GetPlayerWeaponData.
		Add bugfix:
			AttachTrailerToVehicle
			GetVehicleTrailer
			SetPlayerName
			GetWeaponName
	08/06/06:
		First version.
		Fixed:
			Fire death bug - (Fixed)
			GetPlayerMenu - (Error)
			IsPlayerInCheckpoint - (Fixed)
			IsPlayerInRaceCheckpoint - (Fixed)
			SetPlayerRaceCheckpoint - (Fixed)
			SetPlayerCheckpoint - (Fixed)
			GetPlayerColor - (Fixed)
			GetPlayerTeam - (Fixed)
			GivePlayerWeapon - (Fixed)
			GetPlayerAmmo - (Fixed)
			GetPlayerInterior - (Fixed)
			SpawnPlayer - (Fixed)
			floatstr - (Fixed)
			strval - (Fixed)
			strcmp - (Fixed)
			PlayerPlaySound - (Fixed)			

Note:	
	More bug info in http://forum.sa-mp.com/index.php?topic=82288.0
	And you can report sa-mp bug here:http://www.sa-mpbugs.com
	If you find any bug, Send to e-mail:imyezizhu@gmail.com

*/

/**===================================Bug fix list======================================================
Note:
	You can (en/dis)able the bug fix by change false|true.
*/	


/**
	Fire death bug 
		Still "alive" if someone dies in fire.
*/
#define GCS_BF_FIREDEATH				(true)

/**
	GetPlayerMenu
		If a player has closed a menu or it has been hidden for them
		it will return the old menu id instead of INVALID_MENU
*/
#define GCS_BF_GETPLAYERMENU			(true)

/**
	GetPlayerTeam - (Fixed)
		Always returns NO_TEAM (255)
*/
#define GCS_BF_GETPLAYERTEAM			(true)

/**
	IsPlayerInRaceCheckpoint
		Variable isn't initiated until a checkpoint has been set 
		so it returns a undetermined value
*/
#define GCS_BF_ISPLAYERINRACECHECKPOINT	(true)

/**
	IsPlayerInCheckpoint 
		Variable isn't initiated until a checkpoint has been set 
		so it returns a undetermined value
*/
#define GCS_BF_ISPLAYERINCHECKPOINT		(true)

/**
	SetPlayerRaceCheckpoint
		If a checkpoint is already set 
		it will use the size of that checkpoint instead of the new one
		Note:
			Doesn't fix:If the checkpoint is set on a custom object or a non-solid surface it will show floating above the surface
*/
#define GCS_BF_SETPLAYERRACECHEKCPOINT	(true)

/**
	SetPlayerCheckpoint
		If a checkpoint is already set 
		it will use the size of that checkpoint instead of the new one
		Note:
			Doesn't fix:If the checkpoint is set on a custom object or a non-solid surface it will show floating above the surface

*/
#define GCS_BF_SETPLAYERCHEKCPOINT		(true)

/**
	GetPlayerColor
		Returns 0 unless SetPlayerColor has been used
*/
#define GCS_BF_GETPLAYERCOLOR			(true)

/**
	GetPlayerWeaponData
		If ammo bigger than 65534 or smalled than 0 will cause some problems
*/
#define GCS_BF_GETPLAYERWEAPONDATA		(true)

/**
	SetPlayerAmmo
		Doesn't work
		Note:
			Use GetPlayerWeaponData to fix
*/
#define GCS_BF_SETPLAYERAMMO			(true)

/**
	GetPlayerAmmo
		Doesn't work.
		Note:
			Use GetPlayerWeaponData to fix
*/
#define GCS_BF_GETPLAYERAMMO			(true)

/**
	GetWeaponName
		Return null for ids 18, 44 and 45
		Note:
			Named to:
			18 - Molotovs
			44 - Nightvision_Goggles
			45 - Thermal_Goggles
*/
#define GCS_BF_GETWEAPONNAME			(true)

/**
	GetPlayerInterior 
		When "gmx" is used and the player is reconnected it still gives the old interior id
*/
#define GCS_BF_GETPLAYERINTERIOR		(true)	

/**
	SpawnPlayer
		Doesn't work if the player is in a vehicle
*/
#define GCS_BF_SPAWNPLAYER				(true)

/**
	floatstr
		If you use a string longer than 50 (0-49) it crashes the pawn run-time
*/
#define GCS_BF_FLOATSTR					(true)

/**
	strval 
		If you use a string longer than 50 (0-49) it crashes the pawn run-time
*/
#define GCS_BF_STRVAL					(true)

/**
	strcmp
		If one of the strings is empty but the other isn't, 
		it will return 0 (recognising them as being the same)
*/
#define GCS_BF_STRCMP					(true)

/**
	PlayerPlaySound
		Useless of x,y,z
*/
#define GCS_BF_PLAYERPLAYSOUND			(true)

/**
	SetPlayerName
		If you set to the same name but some letters are in a different case it doesn't work (eg "heLLO" to "hello")
*/
#define GCS_BF_SETPLAYERNAME			(true)

/**
	GetVehicleTrailer
		If the trailer becomes detached it still returns the trailer id instead of INVALID_VEHICLE_ID
*/
#define GCS_BF_GETVEHICLETRAILER		(true)

/**
	AttachTrailerToVehicle
		If the trailer is in a different virtual world to the vehicle all players will crash. (like when Gravity is set too high)
		Note:
			It just prevent them from attaching when they're in different virtual world.
*/
#define GCS_BF_ATTACHTRAILERTOVEHICLE	(true)



//===============================================================================================================



#if GCS_BF_FIREDEATH
stock gcs_bf_FireDeath_PlayerDeath(playerid){
	TogglePlayerControllable(playerid,false);
	TogglePlayerControllable(playerid,true);
}
#endif



#if GCS_BF_GETPLAYERMENU
static stock
	bool:gcs_s_bf_getPlayerMenu[MAX_PLAYERS];
/*
stock gcs_bf_getPlayerMenu_Disconnect(playerid){
	gcs_s_bf_getPlayerMenu[playerid] = true;
}
*/
stock gcs_bf_getPlayerMenu_Selected(playerid){
	gcs_s_bf_getPlayerMenu[playerid] = false;
}
stock gcs_bf_getPlayerMenu_ExitedMenu(playerid){
	gcs_s_bf_getPlayerMenu[playerid] = true;
}
stock Menu:gcs_bf_getPlayerMenu(playerid){
	if(gcs_s_bf_getPlayerMenu[playerid])
		return Menu:INVALID_MENU;
	return GetPlayerMenu(playerid);
	//return gcs_s_bf_getPlayerMenu[playerid]?Menu:INVALID_MENU:Menu:GetPlayerMenu(playerid);
}
#define GetPlayerMenu(%1) gcs_bf_getPlayerMenu(%1)
#endif



#if GCS_BF_GETPLAYERTEAM
static stock
	gcs_bf_getPlayerTeam_pTeam[MAX_PLAYERS];
	
stock gcs_bf_setPlayerTeam(playerid,teamid){
	gcs_bf_getPlayerTeam_pTeam[playerid] = teamid;
	return SetPlayerTeam(playerid,teamid);
}
#define SetPlayerTeam(%1) gcs_bf_setPlayerTeam(%1)

stock gcs_bf_getPlayerTeam(playerid){
	return IsPlayerConnected(playerid)?gcs_bf_getPlayerTeam_pTeam[playerid]:NO_TEAM;
}
#define GetPlayerTeam(%1) gcs_bf_getPlayerTeam(%1)
#endif



#if GCS_BF_ISPLAYERINRACECHECKPOINT
stock gcs_bf_isinRaceCheckpoint_Init(){
	for(new i;i<MAX_PLAYERS;i++)
		SetPlayerRaceCheckpoint(i,0,0,0,0,0,0,0,1);
	for(new i;i<MAX_PLAYERS;i++)
		DisablePlayerRaceCheckpoint(i);
}
#endif



#if GCS_BF_ISPLAYERINCHECKPOINT
stock gcs_bf_isinCheckpoint_Init(){
	for(new i;i<MAX_PLAYERS;i++)
		SetPlayerCheckpoint(i,0,0,0,1);
	for(new i;i<MAX_PLAYERS;i++)
		DisablePlayerCheckpoint(i);
}
#endif



#if GCS_BF_SETPLAYERRACECHEKCPOINT
static stock 
	gcs_s_bf_RaceCheckpoint_type[MAX_PLAYERS],
	Float:gcs_s_bf_RaceCheckpoint_cx[MAX_PLAYERS],
	Float:gcs_s_bf_RaceCheckpoint_cy[MAX_PLAYERS],
	Float:gcs_s_bf_RaceCheckpoint_cz[MAX_PLAYERS],
	Float:gcs_s_bf_RaceCheckpoint_nx[MAX_PLAYERS],
	Float:gcs_s_bf_RaceCheckpoint_ny[MAX_PLAYERS],
	Float:gcs_s_bf_RaceCheckpoint_nz[MAX_PLAYERS],
	Float:gcs_s_bf_RaceCheckpoint_size[MAX_PLAYERS];

forward gcs_bf_setRaceCheckpoint_1(playerid);
public gcs_bf_setRaceCheckpoint_1(playerid){
	SetPlayerRaceCheckpoint(playerid,gcs_s_bf_RaceCheckpoint_type[playerid],gcs_s_bf_RaceCheckpoint_cx[playerid], gcs_s_bf_RaceCheckpoint_cy[playerid], gcs_s_bf_RaceCheckpoint_cz[playerid], gcs_s_bf_RaceCheckpoint_nx[playerid], gcs_s_bf_RaceCheckpoint_ny[playerid],gcs_s_bf_RaceCheckpoint_nz[playerid], gcs_s_bf_RaceCheckpoint_size[playerid]);
}

stock gcs_bf_setPlayerRaceCheckpoint(playerid, type, Float:x, Float:y, Float:z, Float:nextx, Float:nexty, Float:nextz, Float:size){
	DisablePlayerRaceCheckpoint(playerid);
	gcs_s_bf_RaceCheckpoint_type[playerid] = type;
	gcs_s_bf_RaceCheckpoint_cx[playerid] = x;
	gcs_s_bf_RaceCheckpoint_cy[playerid] = y;
	gcs_s_bf_RaceCheckpoint_cz[playerid] = z;
	gcs_s_bf_RaceCheckpoint_nx[playerid] = nextx;
	gcs_s_bf_RaceCheckpoint_ny[playerid] = nexty;
	gcs_s_bf_RaceCheckpoint_nz[playerid] = nextz;
	gcs_s_bf_RaceCheckpoint_size[playerid] = size;
	SetTimerEx("gcs_bf_setRaceCheckpoint_1",GetPlayerPing(playerid)/5+50,false,"i",playerid);
	return true;
}
#define SetPlayerRaceCheckpoint(%1) gcs_bf_setPlayerRaceCheckpoint(%1)
#endif



#if GCS_BF_SETPLAYERCHEKCPOINT
static stock
	Float:gcs_s_bf_Checkpoint_x[MAX_PLAYERS],
	Float:gcs_s_bf_Checkpoint_y[MAX_PLAYERS],
	Float:gcs_s_bf_Checkpoint_z[MAX_PLAYERS],
	Float:gcs_s_bf_Checkpoint_size[MAX_PLAYERS];
forward gcs_bf_setPlayerCheckpoint_1(playerid);
public gcs_bf_setPlayerCheckpoint_1(playerid){
	SetPlayerCheckpoint(playerid,gcs_s_bf_Checkpoint_x[playerid],gcs_s_bf_Checkpoint_y[playerid],gcs_s_bf_Checkpoint_z[playerid],gcs_s_bf_Checkpoint_size[playerid]);
}
stock gcs_bf_setPlayerCheckpoint(playerid, Float:x, Float:y, Float:z, Float:size){
	DisablePlayerCheckpoint(playerid);
	gcs_s_bf_Checkpoint_x[playerid] = x;
	gcs_s_bf_Checkpoint_y[playerid] = y;
	gcs_s_bf_Checkpoint_z[playerid] = z;
	gcs_s_bf_Checkpoint_size[playerid] = size;
	SetTimerEx("gcs_bf_setPlayerCheckpoint_1",GetPlayerPing(playerid)/5+25,false,"i",playerid);
	return true;
}
#define SetPlayerCheckpoint(%1) gcs_bf_setPlayerCheckpoint(%1)
#endif



#if GCS_BF_GETPLAYERCOLOR
static const stock 
	gcs_bf_pColor[200] = {
0xFF8080FF,0xFFFF80FF,0x80FF80FF,0x00FF80FF,0x80FFFFFF,0xFF0080FF,0xFF80C0FF,0xFF80FFFF,0x80FF00FF,0x00FF40FF,0x00FFFFFF,
0x8080C0FF,0xFF00FFFF,0xFF8040FF,0x8080FFFF,0xC0C0C0FF,0x55D1EFFF,0x9AE12EFF,0x78BA91FF,0xE79D35FF,0xC17878FF,0xA87AADFF,
0xFF8080FF,0xFFFF80FF,0x80FF80FF,0x00FF80FF,0x80FFFFFF,0xFF0080FF,0xFF80C0FF,0xFF80FFFF,0x80FF00FF,0x00FF40FF,0x00FFFFFF,
0x8080C0FF,0xFF00FFFF,0xFF8040FF,0x8080FFFF,0xC0C0C0FF,0x55D1EFFF,0x9AE12EFF,0x78BA91FF,0xE79D35FF,0xC17878FF,0xA87AADFF,
0x057F94FF,0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,0x18F71FFF,0x4B8987FF,
0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,0x12D6D4FF,0x48C000FF,0x2A51E2FF,0xE3AC12FF,
0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,0x2FD9DEFF,0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,
0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,0x3214AAFF,0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,
0x9F945CFF,0xDCDE3DFF,0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,0xD8C762FF,
0x3FE65CFF,0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,0xF4A460FF,0xEE82EEFF,0xFFD720FF,
0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,
0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,0x65ADEBFF,0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,
0x275222FF,0xF09F5BFF,0x3D0A4FFF,0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,
0x057F94FF,0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,0x18F71FFF,0x4B8987FF,
0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,0x12D6D4FF,0x48C000FF,0x2A51E2FF,0xE3AC12FF,
0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,0x2FD9DEFF,0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,
0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,0x3214AAFF,0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,
0x9F945CFF,0xDCDE3DFF,0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,0xD8C762FF,
0x3FE65CFF
};
stock gcs_bf_getPlayerColor_Connect(playerid){
	SetPlayerColor(playerid,gcs_bf_pColor[playerid]);
}
#endif



#if GCS_BF_GETPLAYERWEAPONDATA || GCS_BF_SETPLAYERAMMO || GCS_BF_GETPLAYERAMMO
stock gcs_bf_getWeaponSlot(weaponid){ 
	switch(weaponid){ 
		case WEAPON_GOLFCLUB,WEAPON_NITESTICK,WEAPON_KNIFE,WEAPON_BAT,WEAPON_SHOVEL,WEAPON_POOLSTICK,WEAPON_KATANA,WEAPON_CHAINSAW: return 1;
		case WEAPON_COLT45,WEAPON_SILENCED,WEAPON_DEAGLE: return 2; 
		case WEAPON_SHOTGUN,WEAPON_SAWEDOFF,WEAPON_SHOTGSPA: return 3; 
		case WEAPON_UZI,WEAPON_MP5,WEAPON_TEC9: return 4; 
		case WEAPON_AK47,WEAPON_M4: return 5; 
		case WEAPON_RIFLE,WEAPON_SNIPER: return 6;
		case WEAPON_ROCKETLAUNCHER,WEAPON_HEATSEEKER,WEAPON_FLAMETHROWER,WEAPON_MINIGUN: return 7;
		case WEAPON_GRENADE,WEAPON_TEARGAS,WEAPON_MOLTOV,WEAPON_SATCHEL: return 8;
		case WEAPON_SPRAYCAN,WEAPON_FIREEXTINGUISHER,WEAPON_CAMERA: return 9;  
		case WEAPON_DILDO,WEAPON_DILDO2,WEAPON_VIBRATOR,WEAPON_VIBRATOR2,WEAPON_FLOWER,WEAPON_CANE: return 10;
		case 44,45,WEAPON_PARACHUTE:return 11;//WEAPON_NIGHTVISION,WEAPON_INFRARED: return 11;
		case WEAPON_BOMB: return 12; 
	}
	return 0; 
}
#endif



#if GCS_BF_GETPLAYERWEAPONDATA
stock gcs_bf_givePlayerWeapon(playerid,weaponid,ammo){
	new 
		ammo2;
	GetPlayerWeaponData(playerid,gcs_bf_getWeaponSlot(weaponid),ammo2,ammo2);
	if(ammo2+ammo > 65532){
		return GivePlayerWeapon(playerid,weaponid,65532-ammo2);
	}else if(ammo2+ammo < 0){
		return GivePlayerWeapon(playerid,weaponid,0-ammo2);
	}
	return GivePlayerWeapon(playerid,weaponid,ammo);
	//return GivePlayerWeapon(playerid,weaponid, ((ammo2+ammo > 65532)?(65532-ammo2):((ammo > 0)?ammo:0)));
}
#define GivePlayerWeapon(%1) gcs_bf_givePlayerWeapon(%1)
#endif



#if GCS_BF_SETPLAYERAMMO
stock gcs_bf_setPlayerAmmo(playerid,ammo){
	return GivePlayerWeapon(playerid,GetPlayerWeapon(playerid),ammo);
}
#define SetPlayerAmmo(%1) gcs_bf_setPlayerAmmo(%1)
#endif



#if GCS_BF_GETPLAYERAMMO
stock gcs_bf_getPlayerAmmo(playerid){
	new
		slot = gcs_bf_getWeaponSlot(GetPlayerWeapon(playerid));
	if(slot == 0 || slot == 1 || slot == 9 || slot == 10 || slot == 11) return 0;
	new ammo;
	GetPlayerWeaponData(playerid,slot,ammo,ammo);
	return ammo;
}
#define GetPlayerAmmo(%1) gcs_bf_getPlayerAmmo(%1)
#endif



#if GCS_BF_GETWEAPONNAME
stock gcs_bf_getWeaponName(weaponid,weapon[], len){
	switch(weaponid){
		case 18:{
			format(weapon,len,"Molotovs");
			return true;
		}
		case 44:{
			format(weapon,len,"Nightvision_Goggles");
			return true;
		}
		case 45:{
			format(weapon,len,"Thermal_Goggles");
			return true;
		}
	}
	return GetWeaponName(weaponid,weapon,len);
}
#define GetWeaponName(%1) gcs_bf_getWeaponName(%1)
#endif



#if GCS_BF_GETPLAYERINTERIOR
stock gcs_bf_getPlayerInterior_Init(){
	for(new i;i<MAX_PLAYERS;i++)
		SetPlayerInterior(i,0);
}
#endif



#if GCS_BF_SPAWNPLAYER
forward gcs_bf_spawnPlayer_1(playerid);
public gcs_bf_spawnPlayer_1(playerid){
	SpawnPlayer(playerid);
}
stock gcs_bf_spawnPlayer(playerid){
	if(IsPlayerInAnyVehicle(playerid)){
		new
			Float:ppos[3];
		GetPlayerPos(playerid,ppos[0],ppos[1],ppos[2]);
		SetPlayerPos(playerid,ppos[0],ppos[1],ppos[2]+1);
		SetTimerEx("gcs_bf_spawnPlayer_1",GetPlayerPing(playerid)/5+25,false,"i",playerid);
		return true;
	}
	return SpawnPlayer(playerid);
}
#define SpawnPlayer(%1) gcs_bf_spawnPlayer(%1)
#endif



#if GCS_BF_SETPLAYERNAME
stock gcs_bf_setPlayerName(playerid,name[]){
	new
		oname[MAX_PLAYER_NAME];
	GetPlayerName(playerid,oname,MAX_PLAYER_NAME);
	if(!strcmp(oname,name,true))
		SetPlayerName(playerid,"UMKMOW_MANE");
	return SetPlayerName(playerid,name);
}
#define SetPlayerName(%1) gcs_bf_setPlayerName(%1)
#endif



#if GCS_BF_GETVEHICLETRAILER
stock gcs_bf_getVehicleTrailer(vehicleid){
	new
		trailerid = GetVehicleTrailer(vehicleid);
	return ((trailerid != INVALID_VEHICLE_ID)?(IsTrailerAttachedToVehicle(vehicleid)?trailerid:INVALID_VEHICLE_ID):INVALID_VEHICLE_ID);
}
#define GetVehicleTrailer(%1) gcs_bf_getVehicleTrailer(%1)
#endif



#if GCS_BF_ATTACHTRAILERTOVEHICLE
stock gcs_bf_attachTrailertoVehicle(trailerid,vehicleid){
	return (GetVehicleVirtualWorld(trailerid) == GetVehicleVirtualWorld(vehicleid))?AttachTrailerToVehicle(vehicleid,trailerid):0;
}
#define AttachTrailerToVehicle(%1) gcs_bf_attachTrailertoVehicle(%1)
#endif



#if GCS_BF_FLOATSTR
stock Float:gcs_bf_floatstr(const str[]){
	new
		lenth;
	while(str[lenth])lenth++;
	if(lenth > 49)return (0.0);
	return floatstr(str);
}
#define floatstr(%1) gcs_bf_floatstr(%1)
#endif


#if GCS_BF_STRVAL
stock gcs_bf_strval(const str[]){
	new
		lenth;
	while(str[lenth])lenth++;
	if(lenth > 49)return (0);
	return strval(str);
}
#define strval(%1) gcs_bf_strval(%1)
#endif



#if GCS_BF_STRCMP
stock gcs_bf_strcmp(const str1[],const str2[],bool:ignorecase = false,length = cellmax){
	if(!str1[0] && !str2[0])return 0;
	if(!str1[0])return 0-strlen(str2);
	if(!str2[0])return strlen(str1);
	return strcmp(str1,str2,ignorecase,length);
}
#define strcmp(%1) gcs_bf_strcmp(%1)
#endif



#if GCS_BF_PLAYERPLAYSOUND
stock gcs_bf_PlayerplaySound(playerid,soundid,const Float:playeridx=0.0,const Float:playeridy=0.0,const Float:playeridz=0.0){
	#pragma unused playeridx,playeridy,playeridz
	new
		Float:tmppos[3];
	GetPlayerPos(playerid,tmppos[0],tmppos[1],tmppos[2]);
	return PlayerPlaySound(playerid,soundid,tmppos[0],tmppos[1],tmppos[2]);
}
#define PlayerPlaySound(%1) gcs_bf_PlayerplaySound(%1)
#endif





#if (GCS_BF_FIREDEATH)
gcs_bf_OnPlayerDeath(playerid){
	#if GCS_BF_FIREDEATH
		gcs_bf_FireDeath_PlayerDeath(playerid);
	#endif
}
#endif



#if (GCS_BF_GETPLAYERMENU)

gcs_bf_OnPlayerSelectedMenuRow(playerid){
	#if GCS_BF_GETPLAYERMENU
		gcs_bf_getPlayerMenu_Selected(playerid);
	#endif
}

gcs_bf_OnPlayerExitedMenu(playerid){

	#if GCS_BF_GETPLAYERMENU
		gcs_bf_getPlayerMenu_ExitedMenu(playerid);
	#endif
	
}

#endif



#if (GCS_BF_GETPLAYERCOLOR)

gcs_bf_OnPlayerConnect(playerid){

	#if GCS_BF_GETPLAYERCOLOR
		gcs_bf_getPlayerColor_Connect(playerid);
	#endif	
	
}

#endif



#if (GCS_BF_ISPLAYERINRACECHECKPOINT || GCS_BF_ISPLAYERINCHECKPOINT || GCS_BF_GETPLAYERINTERIOR)

gcs_bf_OnGameModeInit(){

	#if GCS_BF_ISPLAYERINRACECHECKPOINT
		gcs_bf_isinRaceCheckpoint_Init();
	#endif
	
	#if GCS_BF_ISPLAYERINCHECKPOINT
		gcs_bf_isinCheckpoint_Init();
	#endif
	
	#if GCS_BF_GETPLAYERINTERIOR
		gcs_bf_getPlayerInterior_Init();
	#endif
	
}

#endif


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               