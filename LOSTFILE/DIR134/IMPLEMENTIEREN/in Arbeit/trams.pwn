#include <a_samp>
#define SLOTS 4

forward keys();

public OnFilterScriptInit() {
	print(" ");
	print("    0.2 TRAM SCRIPT");
	print("    thanks to Cam!");
	print(" ");
	SetTimer("keys",200,1);
}

public keys() {
	new lKeys, Mike1, Mike2;
	new Float:px,Float:py,Float:pz;
	new Float:cx,Float:cy,Float:cz;
	
	for(new i = 0; i < SLOTS; i++) {
	    if(IsPlayerConnected(i)) {
			GetPlayerPos(i,px,py,pz);
			for(new j = 0; j < MAX_VEHICLES; j++) {
				if(GetVehicleModel(j) == 449) {
					GetVehiclePos(j,cx,cy,cz);
					if( floatsqroot(  floatpower(px-cx,2.0) + floatpower(py-cy,2.0) + floatpower(pz-cz,2.0)) < 3.0) {
						GetPlayerKeys(i, lKeys, Mike1, Mike2);

						if (lKeys & KEY_SECONDARY_ATTACK) {
							PutPlayerInVehicle(i, j, 0);
						}
					}
				}
			}
		}
	}
}
