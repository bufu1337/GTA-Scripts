/*
 * Map System by Luby & Gamer_Z
 * saved 11 March 2009, 12:09
 */

#include <a_samp>

new PlrObj[200];
new Lampy[8];
new Datas[3];
new Mury[6];

public OnFilterScriptInit(){
	print("\nMap System by Luby and Gamer_Z - Loaded");
	Datas[0] = CreateObject(16662, 1932.2740,-2409.6987,1200.6908, 0.0, 0.0, -27.0);
	Mury[0] = CreateObject(3983, 1930.715088, -2417.489990, 1201.556519, 0.0000, 0.0000, 0.0000);
	Mury[1] = CreateObject(3983, 1938.750122, -2419.424561, 1201.557129, 0.0000, 268.0403, 0.0000);
	Mury[2] = CreateObject(3983, 1922.684082, -2417.233643, 1201.763428, 0.0000, 96.1526, 9.4538);
	Mury[3] = CreateObject(3983, 1932.634888, -2426.096436, 1201.592285, 0.0000, 96.1526, 98.8352);
	Mury[4] = CreateObject(3983, 1934.155273, -2406.747803, 1201.625122, 0.0000, 254.1853, 98.8352);
	Mury[5] = CreateObject(3983, 1938.325562, -2415.805176, 1216.350342, 359.1406, 179.4143, 95.3974);
	Lampy[0] = CreateObject(1232, 1934.736694, -2413.839844, 1202.169678, 0.0000, 0.0000, 0.0000);
	Lampy[1] = CreateObject(1232, 1935.306519, -2421.486816, 1202.169678, 0.0000, 0.0000, 0.0000);
	Lampy[2] = CreateObject(1232, 1928.441406, -2421.002441, 1202.218506, 0.0000, 0.0000, 0.0000);
	Lampy[3] = CreateObject(1232, 1927.940186, -2413.950928, 1202.244629, 0.0000, 0.0000, 0.0000);
	Lampy[4] = CreateObject(1232, 1922.012695, -2430.574951, 1202.355225, 0.0000, 53.2850, 55.8633);
	Lampy[5] = CreateObject(1232, 1942.271362, -2427.741211, 1201.987061, 0.0000, 53.2850, 138.3693);
	Lampy[6] = CreateObject(1232, 1941.111938, -2403.214844, 1201.988281, 0.0000, 53.2850, 237.2046);
	Lampy[7] = CreateObject(1232, 1918.437500, -2406.737793, 1201.562622, 0.0000, 53.2850, 321.4290);
	Datas[1] = SetTimer("UpdateMap", 100, true);
	Datas[2] = SetTimer("Refresh", 2000, true);
	for(new g=0;g<200;g++)if(IsPlayerConnected(g))PlrObj[g] = CreateObject(1234, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	return true;
}

public OnFilterScriptExit(){
	print("\nMap System by Luby and Gamer_Z - Unloaded");
	KillTimer(Datas[1]);
	KillTimer(Datas[2]);
	DestroyObject(Datas[0]);
	DestroyObject(Lampy[0]);
	DestroyObject(Lampy[1]);
	DestroyObject(Lampy[2]);
	DestroyObject(Lampy[3]);
	DestroyObject(Lampy[4]);
	DestroyObject(Lampy[5]);
	DestroyObject(Lampy[6]);
	DestroyObject(Lampy[7]);
	DestroyObject(Mury[0]);
	DestroyObject(Mury[1]);
	DestroyObject(Mury[2]);
	DestroyObject(Mury[3]);
	DestroyObject(Mury[4]);
	DestroyObject(Mury[5]);
	for(new g=0;g<200;g++)if(PlrObj[g])DestroyObject(PlrObj[g]);
	return true;
}

forward Refresh();
public Refresh(){
	new id;
	new Float:X, Float:Y, Float:Z, Float:R1, Float:R2, Float:R3;
	for(new g=0;g<GetMaxPlayers();g++)if(IsPlayerConnected(g)){
	    GetObjectPos(PlrObj[g], X, Y, Z);
	    GetObjectRot(PlrObj[g], R1, R2, R3);
	    id = CreateObject(1234, X, Y, Z, R1, R2, R3);
	    DestroyObject(PlrObj[g]);
	 	PlrObj[g] = id;
	}
	id = CreateObject(1232, 1934.736694, -2413.839844, 1202.169678, 0.0000, 0.0000, 0.0000);
 	DestroyObject(Lampy[0]);
 	Lampy[0] = id;
	id = CreateObject(1232, 1935.306519, -2421.486816, 1202.169678, 0.0000, 0.0000, 0.0000); //
 	DestroyObject(Lampy[1]);
 	Lampy[1] = id;
	id = CreateObject(1232, 1928.441406, -2421.002441, 1202.218506, 0.0000, 0.0000, 0.0000); //
 	DestroyObject(Lampy[2]);
 	Lampy[2] = id;
	id = CreateObject(1232, 1927.940186, -2413.950928, 1202.244629, 0.0000, 0.0000, 0.0000); //
 	DestroyObject(Lampy[3]);
 	Lampy[3] = id;
	id = CreateObject(1232, 1922.012695, -2430.574951, 1202.355225, 0.0000, 53.2850, 55.8633); //
 	DestroyObject(Lampy[4]);
 	Lampy[4] = id;
	id = CreateObject(1232, 1942.271362, -2427.741211, 1201.987061, 0.0000, 53.2850, 138.3693); //
 	DestroyObject(Lampy[5]);
 	Lampy[5] = id;
	id = CreateObject(1232, 1941.111938, -2403.214844, 1201.988281, 0.0000, 53.2850, 237.2046); //
 	DestroyObject(Lampy[6]);
 	Lampy[6] = id;
	id = CreateObject(1232, 1918.437500, -2406.737793, 1201.562622, 0.0000, 53.2850, 321.4290); //
 	DestroyObject(Lampy[7]);
 	Lampy[7] = id;
}

forward UpdateMap();
public UpdateMap(){
	new Float:X, Float:Y, Float:Z, Float:R1, Float:R2, Float:R3;
	new Float:DirX, Float:DirY, Float:DirZ;
	new Float:Distance, Float:Angle;
	for(new g=0;g<GetMaxPlayers();g++)if(IsPlayerConnected(g)){
		GetPlayerPos(g, X, Y, Z);
		DirX = 1931.7674;
		DirY = -2417.5302;
	    DirZ = 1200.0000;
		DirX = floatadd(DirX, floatmul(floatdiv(X, 3000.0), 1.7062));
    	DirY = floatadd(DirY, floatmul(floatdiv(Y, 3000.0), 1.7577));
    	DirZ = floatadd(DirZ, floatmul(Z, 0.001));
		GetObjectPos(PlrObj[g], X, Y, Z);
		Distance = floatsqroot(floatadd(floatadd(floatpower(floatabs(floatsub(X,DirX)),2),floatpower(floatabs(floatsub(Y,DirY)),2)),floatpower(floatabs(floatsub(Z,DirZ)),2)));
		if(IsPlayerInAnyVehicle(g)){
			GetVehicleZAngle(GetPlayerVehicleID(g), Angle);
		} else GetPlayerFacingAngle(g, Angle);
		GetObjectRot(PlrObj[g], R1, R2, R3);
		SetObjectRot(PlrObj[g], 0.0, 0.0, floatdiv(R3 + ((Angle+180.0)*50),51));
		MoveObject(PlrObj[g], DirX, DirY, DirZ, Distance);
	}
}

public OnPlayerConnect(playerid)
{
	PlrObj[playerid] = CreateObject(1234, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	return true;
}

public OnPlayerDisconnect(playerid) {
	DestroyObject(PlrObj[playerid]);
	return true;
}

public OnPlayerCommandText(playerid, cmdtext[]){
	if (!strcmp(cmdtext, "/map", true))
	{
		SetPlayerPos(playerid, 1932.2740,-2409.6987,1202.6908);
		return true;
	}
	if (!strcmp(cmdtext, "/mapon", true))
	{
		SetPlayerCameraPos(playerid, 1931.7674, -2417.5302, 1205.6908);
		TogglePlayerControllable(playerid, false);
		SetPlayerPos(playerid, 1931.7674, -2417.5302, 1207.6908);
		SetPlayerCameraLookAt(playerid, 1931.7674, -2417.5202, 1200.6908);
		return true;
	}
	if (!strcmp(cmdtext, "/mapoff", true))
 	{
		TogglePlayerControllable(playerid, true);
		SpawnPlayer(playerid);
		return true;
	}
	return false;
}