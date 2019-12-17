#include <a_samp>


new
	pTick[MAX_PLAYERS];
public OnFilterScriptInit(){
	printf("=====================================================================");
	printf("This is a part of a OpenGTA subject, visit opengta.org for more info.");
	printf("FilterScript Name: Armed body");
	printf("Description:Attatch weapond to player's body");
	printf("Author:yezizhu");
	printf("Special thanks:Double-O-Seven, Brian.");
	printf("Contact author: imyezizhu@gmail.com");
	printf("=====================================================================");
	return true;
}
public OnFilterScriptExit(){
	return true;
}
public OnPlayerUpdate(playerid){
	if(GetTickCount() - pTick[playerid] > 100){ //prefix check itter
		new
			weaponid[13],weaponammo[13],pArmedWeapon;
		pArmedWeapon = GetPlayerWeapon(playerid);
		for(new i;i < 13;i++){
			GetPlayerWeaponData(playerid,i,weaponid[i],weaponammo[i]);
		}
		if(weaponid[1] && weaponammo[1] > 0){
			if(pArmedWeapon != weaponid[1]){
				SetPlayerAttachedObject(playerid,0,GetWeaponModel(weaponid[1]),1, 0.199999, -0.139999, 0.030000, 0.500007, -115.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			}
			else {
				if(IsPlayerAttachedObjectSlotUsed(playerid,0)){
					RemovePlayerAttachedObject(playerid,0);
				}
			}
		}
		else if(IsPlayerAttachedObjectSlotUsed(playerid,0)){
			RemovePlayerAttachedObject(playerid,0);
		}
		if(weaponid[2] && weaponammo[2] > 0){
			if(pArmedWeapon != weaponid[2]){
				SetPlayerAttachedObject(playerid,1,GetWeaponModel(weaponid[2]),8, -0.079999, -0.039999, 0.109999, -90.100006, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			}
			else {
				if(IsPlayerAttachedObjectSlotUsed(playerid,1)){
					RemovePlayerAttachedObject(playerid,1);
				}
			}
		}
		else if(IsPlayerAttachedObjectSlotUsed(playerid,1)){
			RemovePlayerAttachedObject(playerid,1);
		}
		if(weaponid[4] && weaponammo[4] > 0){
			if(pArmedWeapon != weaponid[4]){
				SetPlayerAttachedObject(playerid,2,GetWeaponModel(weaponid[4]),7, 0.000000, -0.100000, -0.080000, -95.000000, -10.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			}
			else {
				if(IsPlayerAttachedObjectSlotUsed(playerid,2)){
					RemovePlayerAttachedObject(playerid,2);
				}
			}
		}
		else if(IsPlayerAttachedObjectSlotUsed(playerid,2)){
			RemovePlayerAttachedObject(playerid,2);
		}
		if(weaponid[5] && weaponammo[5] > 0){
			if(pArmedWeapon != weaponid[5]){
				SetPlayerAttachedObject(playerid,3,GetWeaponModel(weaponid[5]),1, 0.200000, -0.119999, -0.059999, 0.000000, 206.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			}
			else {
				if(IsPlayerAttachedObjectSlotUsed(playerid,3)){
					RemovePlayerAttachedObject(playerid,3);
				}
			}
		}
		else if(IsPlayerAttachedObjectSlotUsed(playerid,3)){
			RemovePlayerAttachedObject(playerid,3);
		}
		if(weaponid[7] && weaponammo[7] > 0){
			if(pArmedWeapon != weaponid[7]){
				SetPlayerAttachedObject(playerid,4,GetWeaponModel(weaponid[7]),1,-0.100000, 0.000000, -0.100000, 84.399932, 112.000000, 10.000000, 1.099999, 1.000000, 1.000000);
			}
			else {
				if(IsPlayerAttachedObjectSlotUsed(playerid,4)){
					RemovePlayerAttachedObject(playerid,4);
				}
			}
		}
		else if(IsPlayerAttachedObjectSlotUsed(playerid,4)){
			RemovePlayerAttachedObject(playerid,4);
		}
		pTick[playerid] = GetTickCount();
	}
	return true;
}



//by Double-O-Seven
stock GetWeaponModel(weaponid)
{
	switch(weaponid)
	{
	    case 1:
	        return 331;

		case 2..8:
		    return weaponid+331;

        case 9:
		    return 341;

		case 10..15:
			return weaponid+311;

		case 16..18:
		    return weaponid+326;

		case 22..29:
		    return weaponid+324;

		case 30,31:
		    return weaponid+325;

		case 32:
		    return 372;

		case 33..45:
		    return weaponid+324;

		case 46:
		    return 371;
	}
	return 0;
}