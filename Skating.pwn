/*
    * ## LEASE ATENTAMENTE PARA NO CONVERTIRSE EN LAMMER!!.: :D ##
    *
    * Estè Simple FILTERSCRIPT esta hecho especialmente para www.forum.sa-mp.com
    * NO Publicar estè FILTERSCRIPT en Otros foros de SA-MP y hacerse pasar por el creador del CODE.
    *
    * Codigo Creado Por OTACON
    *
    * CREDITOS:
    *     OTACON: Realizacion y Idea de creacion del code.
    *     TÙ: Modificacion libremente respetando lo mencionado ;).
    *
    *    NOTA: Menos Creditos para los que me los critican.. JO'PUTAS! :D xD ;)
    *
    *                Prohibido TOTALMENTE el Robo de Créditos o la
    *                  Publicación de este FILTERSCRIPT sin Mi Permiso.
*/
/*
    * ## READ CAREFULLY TO AVOID BECOMING LAMMER!.: :D ##
    *
    * This simple FILTERSCRIPT is made especially for www.forum.sa-mp.com
    * DO NOT Post the FILTERSCRIPT in Other SAMP forums and impersonating the creator of the CODE.
    *
    * Code Created By OTACON
    *
    * CREDITS:
    *     OTACON: Idea Making and code creation.
    *     YOUR: Modification freely respecting the above ;).
    *
    *    NOTE: Less Credits for those who criticize me.. JO'PUTAS! :D xD ;)
    *
    *                        FULLY spaces Theft Credit or
    *                 Publication of this FILTERSCRIPT without my permission.
*/


#include <a_samp>
#include <zcmd>

#define MODE_SKATE (0)        // 0 - medium speed | 1 - fast speed
#define TYPE_SKATE (0)        // 0 - the skate is placed on the right arm | 1 - the skate is placed in the back
#define INDEX_SKATE (0)       //is the slot that used SetPlayerAttachedObject
enum skate{
	bool:sActive,
	sSkate,
};
new InfoSkate[MAX_PLAYERS][skate];

COMMAND:skate(playerid,params[]){
	if(!IsPlayerInAnyVehicle(playerid)){
		ApplyAnimation(playerid, "CARRY","null",0,0,0,0,0,0,0);
	    ApplyAnimation(playerid, "SKATE","null",0,0,0,0,0,0,0);
	    ApplyAnimation(playerid, "CARRY","crry_prtial",4.0,0,0,0,0,0);
	    SetPlayerArmedWeapon(playerid,0);
		if(!InfoSkate[playerid][sActive]){
			InfoSkate[playerid][sActive] = true;
			DestroyObject(InfoSkate[playerid][sSkate]);
			RemovePlayerAttachedObject(playerid,INDEX_SKATE);
			#if TYPE_SKATE == 0
			// the skate is placed on the right arm
			SetPlayerAttachedObject(playerid,INDEX_SKATE,19878,6,-0.055999,0.013000,0.000000,-84.099983,0.000000,-106.099998,1.000000,1.000000,1.000000);
			#else
			// the skate is placed in the back
			SetPlayerAttachedObject(playerid,INDEX_SKATE,19878,1,0.055999,-0.173999,-0.007000,-95.999893,-1.600010,24.099992,1.000000,1.000000,1.000000);
			#endif
			PlayerPlaySound(playerid,21000,0,0,0);
			SendClientMessage(playerid,-1,"{FFFFFF}INFO: {00B100}modo skate encendido{FFFFFF}!.");
		}else{
			InfoSkate[playerid][sActive] = false;
			DestroyObject(InfoSkate[playerid][sSkate]);
			RemovePlayerAttachedObject(playerid,INDEX_SKATE);
			PlayerPlaySound(playerid,21000,0,0,0);
			SendClientMessage(playerid,-1,"{FFFFFF}INFO: {B00000}modo skate apagado{FFFFFF}!.");
		}
	}else SendClientMessage(playerid,-1,"{FFFFFF}INFO: {00B7FF}no puedes usar el skate desde un vehiculo{FFFFFF}!.");
	return true;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
	if(InfoSkate[playerid][sActive] && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT){
		static bool:act;
		SetPlayerArmedWeapon(playerid,0);
		if(newkeys & KEY_HANDBRAKE){
			#if MODE_SKATE == 0
			// medium speed
			ApplyAnimation(playerid, "SKATE","skate_run",4.1,1,1,1,1,1,1);
			#else
			// fast speed
			ApplyAnimation(playerid, "SKATE","skate_sprint",4.1,1,1,1,1,1,1);
			#endif
			if(!act){
				act = true;
				RemovePlayerAttachedObject(playerid,INDEX_SKATE);
				DestroyObject(InfoSkate[playerid][sSkate]);
				InfoSkate[playerid][sSkate] = CreateObject(19878,0,0,0,0,0,0);
				AttachObjectToPlayer(InfoSkate[playerid][sSkate],playerid, -0.2,0,-0.9,0,0,90);
			}
		}
		if(oldkeys & KEY_HANDBRAKE){
			ApplyAnimation(playerid, "CARRY","crry_prtial",4.0,0,0,0,0,0);
			if(act){
				act = false;
				DestroyObject(InfoSkate[playerid][sSkate]);
				RemovePlayerAttachedObject(playerid,INDEX_SKATE);
				#if TYPE_SKATE == 0
				// the skate is placed on the right arm
				SetPlayerAttachedObject(playerid,INDEX_SKATE,19878,6,-0.055999,0.013000,0.000000,-84.099983,0.000000,-106.099998,1.000000,1.000000,1.000000);
				#else
				// the skate is placed in the back
				SetPlayerAttachedObject(playerid,INDEX_SKATE,19878,1,0.055999,-0.173999,-0.007000,-95.999893,-1.600010,24.099992,1.000000,1.000000,1.000000);
				#endif
			}
		}
	}
	return true;
}

public OnFilterScriptInit(){
	AddPlayerClass(23,1916.1304,-1367.8215,13.6492,99.3507,0,0,0,0,0,0); //
	return true;
}