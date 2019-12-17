//============================================================================//
//              Anti-NoReload & Anti-RapidFire - SA:MP 0.3z
//                         Creator: JR_Junior
//                        Date: March, 9, 2014
//           Beta-Testers: Marcelo_Widmore / Vitor_Dexter / Eduardo_Barcelos
//============================================================================//
#include <a_samp>
new NoReloading[MAX_PLAYERS];
new CurrentWeapon[MAX_PLAYERS];
new CurrentAmmo[MAX_PLAYERS];
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ){
	if(IsWeaponWithAmmo(weaponid)){
		new count = 0;
		if(weaponid != CurrentWeapon[playerid]){
			CurrentWeapon[playerid] = weaponid;
			CurrentAmmo[playerid] = GetPlayerWeaponAmmo(playerid,weaponid);
 			count++;
		}
		if(GetPlayerWeaponAmmo(playerid,weaponid) > CurrentAmmo[playerid] || GetPlayerWeaponAmmo(playerid,weaponid) < CurrentAmmo[playerid]){
			CurrentAmmo[playerid] = GetPlayerWeaponAmmo(playerid,weaponid);
			NoReloading[playerid] = 0;
			count++;
		}
		if(GetPlayerWeaponAmmo(playerid,weaponid) != 0 && GetPlayerWeaponAmmo(playerid,weaponid) == CurrentAmmo[playerid] && count == 0){
			NoReloading[playerid]++;
			if(NoReloading[playerid] >= 5){
				NoReloading[playerid] = 0;
				CurrentWeapon[playerid] = 0;
				CurrentAmmo[playerid] = 0;
				Kick(playerid);
				//Ban(playerid);
				return 0; //Returning 0 so that the damage doesn't occur and also the rest codes under OnPlayerWeaponShot won't get called.
			}
		}
	}
	return 1;
}
stock IsWeaponWithAmmo(weaponid){
	//JR_Junior
	switch(weaponid){
		case 16..18, 22..39, 41..42: return 1;
		default: return 0;
	}
	return 0;
}
stock GetPlayerWeaponAmmo(playerid,weaponid){
	new wd[2][13];
	for(new i; i<13; i++){
		GetPlayerWeaponData(playerid,i,wd[0][i],wd[1][i]);
	} 
	for(new i; i<13; i++){
		if(weaponid == wd[0][i]) return wd[1][i];
	}
	return 0;
}