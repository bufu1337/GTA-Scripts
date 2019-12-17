#include <a_samp>
#include <a_angles>
#define DeathMessage // Comment to remove death message.
forward NpcKiller(playerid,bool:KickAfter);
forward Float:GetDistanceToPlayer(playerid,playerid2);
enum enum_pInfo{
    lastAmmo
}
new pFiringInfo[MAX_PLAYERS][enum_pInfo];
new Float:MyNpcHealth[MAX_PLAYERS]=100.0;
new WeaponDamage[] = {
	6,     // Unarmed
	8,     //Brass Knuckles
	13,    //Golf Club
	13,    //Nite Stick
	14,    //Knife
	12,    //Baseball Bat
	11,    //Shovel
	11,    //Pool Cue
	18,    //Katana
	26,    //ChainSaw
	-5,    //Purple Dildo
	-5,    //Small White Vibrator
	-5,    //Large White Vibrator
	-5,    //Silver Vibrator
	-100,  //Flowers
	10,    //Cane
	20,    //Grenade (Dano Baixo pq n funciona direito.)
	2,     //Teargas
	20,    //Molotov (Dano Baixo pq n funciona direito.)
	0,     // null
	0,     // null
	0,     // null
	20,    // 9mm
	20,    //Silenced 9mm
	25,    //Desert Eagle
	32,    //Shotgun
	38,    //Sawn-off Shotgun
	30,    //Combat Shotgun
	18,    //Micro SMG
	24,    //SMG
	31,    //AK47
	28,    //M4
	16,    //Tec 9
	55,    //Country Rifle
 	95,    //Sniper Rifle
 	80,    //Rocket Launcher
 	80,    //Heat Seeker
 	75,    //Flamethrower
 	65,    //Minigun
 	0,
 	0,
 	0,
 	0,
 	0,
 	0,
 	0
};
new Float:WeaponRanges[] = {
	1.0,      // Unarmed
	1.0,      //Brass Knuckles
	1.2,      //Golf Club
	1.2,      //Nite Stick
	1.1,      //Knife
	1.2,      //Baseball Bat
	1.2,      //Shovel
	1.3,      //Pool Cue
	1.2,      //Katana
	1.3,      //ChainSaw
	0.5,      //Purple Dildo
	0.5,      //Small White Vibrator
	0.5,      //Large White Vibrator
	0.5,      //Silver Vibrator
	0.5,      //Flowers
	1.4,      //Cane
	22.0,     //Grenade (Dano Baixo pq n funciona direito.)
	22.0,     //Teargas
	22.0,     //Molotov (Dano Baixo pq n funciona direito.)
	0.0,      // null
	0.0,      // null
	0.0,      // null
	38.0,     // 9mm
	39.0,     //Silenced 9mm
	40.0,     //Desert Eagle
	36.0,     //Shotgun
	35.0,     //Sawn-off Shotgun
	37.0,     //Combat Shotgun
 	38.0,    //Micro SMG
 	41.0,    //SMG
 	45.0,    //AK47
 	55.0,    //M4
 	36.0,    //Tec 9
 	78.0,    //Country Rifle
 	95.0,    //Sniper Rifle
 	40.0,    //Rocket Launcher
 	40.0,    //Heat Seeker
 	23.0,    //Flamethrower
 	47.0,    //Minigun
 	0.0,
 	0.0,
 	0.0,
 	0.0,
 	0.0,
 	0.0,
 	0.0
};
new Float:WeaponPrecision[] = {
	2.0,      // Unarmed
	2.0,      //Brass Knuckles
	2.2,      //Golf Club
	2.2,      //Nite Stick
	2.1,      //Knife
	2.2,      //Baseball Bat
	2.2,      //Shovel
	2.3,      //Pool Cue
	2.2,      //Katana
	2.0,      //ChainSaw
	1.5,      //Purple Dildo
	1.5,      //Small White Vibrator
	1.5,      //Large White Vibrator
	1.5,      //Silver Vibrator
	1.5,      //Flowers
	2.0,      //Cane
	5.0,     //Grenade (Dano Baixo pq n funciona direito.)
	5.0,     //Teargas
	5.0,     //Molotov (Dano Baixo pq n funciona direito.)
	0.0,      // null
	0.0,      // null
	0.0,      // null
	5.0,     // 9mm
	4.5,     //Silenced 9mm
	5.0,     //Desert Eagle
	8.0,     //Shotgun
	10.0,     //Sawn-off Shotgun
	9.0,     //Combat Shotgun
 	7.0,    //Micro SMG
 	4.0,    //SMG
 	6.0,    //AK47
 	3.0,    //M4
 	8.0,    //Tec 9
 	2.0,    //Country Rifle
 	1.0,    //Sniper Rifle
 	3.0,    //Rocket Launcher
 	3.0,    //Heat Seeker
 	10.0,    //Flamethrower
 	8.0,    //Minigun
 	0.0,
 	0.0,
 	0.0,
 	0.0,
 	0.0,
 	0.0,
 	0.0
};
public OnFilterScriptInit(){
	for(new i =0;i<MAX_PLAYERS;i++){
	    if(IsPlayerNPC(i)){
	        MyNpcHealth[i] = 100.0;
	    }
	}
	print("\n--------------------------------------");
	print(" Kill NPCS by Wafffllesss");
	print("--------------------------------------\n");
	return 1;
}
public OnPlayerSpawn(playerid){
    if(IsPlayerNPC(playerid)){
        MyNpcHealth[playerid] = 100.0;
    }
}
stock NoAmmo(weaponid){
    switch(weaponid){
        case 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14: return true;
    }
    return false;
}
public OnPlayerUpdate(playerid){
	if(!IsPlayerNPC(playerid)){
	    new key_lr,key_ud,key_sp;
	    GetPlayerKeys(playerid,key_sp,key_ud,key_lr);
	    if( (key_sp == KEY_FIRE || key_sp == (KEY_FIRE+128)) && (GetPlayerAmmo(playerid) < pFiringInfo[playerid][lastAmmo] || NoAmmo(GetPlayerWeapon(playerid))) ){
	        OnPlayerShootNpc(playerid);
	    }
	    pFiringInfo[playerid][lastAmmo] = GetPlayerAmmo(playerid);
 	}
    return true;
}
stock Float:GetDistanceToPlayer(playerid,playerid2) {
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	if (!IsPlayerConnected(playerid) || !IsPlayerConnected(playerid2)) {
		return -1.00;
	}
	GetPlayerPos(playerid,x1,y1,z1);
	GetPlayerPos(playerid2,x2,y2,z2);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}
stock OnPlayerShootNpc(playerid){
	new Float:x,Float:y,Float:z,Float:ax,Float:ay,Float:az;
	new wp = GetPlayerWeapon(playerid);
	new Damage = WeaponDamage[wp];
	GetPlayerPos(playerid,x,y,z);
	for(new i=0;i<MAX_PLAYERS;i++){
	    if(IsPlayerNPC(i)){
			GetPlayerPos(i,ax,ay,az);
			printf("Good? [ %b ]",(IsPlayerFacingPlayer(playerid,i,WeaponPrecision[wp]) && z >= (az-10.0) && z <= (az+10.0) && GetDistanceToPlayer(playerid,i) <= WeaponRanges[wp]) );
		    if(IsPlayerFacingPlayer(playerid,i,WeaponPrecision[wp]) && z >= (az-10.0) && z <= (az+10.0) && GetDistanceToPlayer(playerid,i) <= WeaponRanges[wp]){
		        MyNpcHealth[i] -= float(Damage);
		        if(MyNpcHealth[i] <= 0.0){
		            KillNpc(i,true);
    				OnPlayerDeath(i, playerid, GetPlayerWeapon(playerid));
		        }
		    }
	    }
	}
}
stock KillNpc(playerid,bool:KickAfter){
	TogglePlayerControllable(playerid,false);
	ApplyAnimation(playerid,"Knife","KILL_Knife_Ped_Die",1,0,1,0,0,0);
	SetTimerEx("NpcKiller",1400,0,"ib",playerid,KickAfter);
}
public NpcKiller(playerid,bool:KickAfter){
	if(KickAfter){
	    Kick(playerid);
	}else{
	    TogglePlayerControllable(playerid,true);
	    SetPlayerHealth(playerid,0.0);
	}
}
public OnPlayerDeath(playerid, killerid, reason){
	if(IsPlayerNPC(playerid)){
	    #if defined DeathMessage
		    if(killerid != 255){
        		SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
			}else{
        		SendDeathMessage(killerid,playerid,reason);
			}
	    #endif
    }
	return 1;
}
