/*
    Timers per player: 1*
	Timer per Zombie: 3*

	*Playing constantly.
=====================================================================================================
	This is the Zombie Filterscript by Wafffllesss ( Henrique Pauli ). This is my first Filterscript
	And My first npc work. I hope you enjoy this filterscript and make much fun in your server.
	Please do not remove the credits.

	*You can mod this filterscript as you wish.
	*You can use this filterscript in anywhere you want to.
=====================================================================================================
*/

// The Zombie Skin.
// -1: Will random by the skins defined below.
// -2: Will random by any valid game skin.
// Any other number will set the skin as you defined ( if valid ).
#define Zombie_Skin -2

//The zombies name. Eg.: If the npc have Zombie in the name, then he'll be a zombie ( Change as you wish ).
#define ZOMBIE_NAME "Zombie"

#include <a_samp>
#include <foreach> // By Y_less
Itter_Create(Vehicle, MAX_VEHICLES);


#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA


forward CheckCloserPlayers(playerid);
forward NewPos(playerid);
forward CheckHP(playerid);
forward KilledBy(playerid,killer);
forward KickZombie(playerid);
forward Firing(playerid);

// If Zombie_Skin is equal to -1 then will random this skins:
new ZombieSkins[]={
	1,
	7,
	9,
	10,
	45
	// Atention, the last skin doesn't have comma.
};


enum ZombieEnum{
	ZombieSpawned,
	ZombieTarget,
	ZombieRunning,
	ZombieKilling,
	NPTIMER,
	Ztimers,
	Float:LastZombieHealth,
	Dying,
	HPtimer
}
new Zombies[200][ZombieEnum];

new FiringTimer[200];
new FiringClick[200];

new ZombieKill[200];

new Caller;
new LastAdded = 0;

new WeaponDamage[] = {
	1,
	2,
	4,
	4,
	5,
	4,
	4,
	4,
	6,
	15,
	-5,
	-5,
	-5,
	-5,
	-100,
	4,
	13,
	2,
	13,
	0,
	0,
	0,
	8,
	9,
	11,
	15,
	17,
	15,
	8,
	9,
	13,
	13,
	6,
	45,
 	55,
 	40,
 	40,
 	27,
 	35,
 	0,
 	0,
 	0,
 	0,
 	0,
 	0,
 	0
};
new Float:WeaponRanges[] = {
	1.0,
	1.0,
	1.2,
	1.2,
	1.1,
	1.2,
	1.2,
	1.3,
	1.2,
	1.3,
	0.5,
	0.5,
	0.5,
	0.5,
	0.5,
	1.4,
	12.0,
	12.0,
	12.0,
	0.0,
	0.0,
	0.0,
	28.0,
	29.0,
	30.0,
	26.0,
	25.0,
	27.0,
 	28.0,
 	31.0,
 	35.0,
 	35.0,
 	26.0,
 	38.0,
 	65.0,
 	40.0,
 	40.0,
 	23.0,
 	37.0,
 	0.0,
 	0.0,
 	0.0,
 	0.0,
 	0.0,
 	0.0,
 	0.0
};
public OnFilterScriptInit()
{
	// If there is players / Npcs / Vehicles online, it'll create the Itter.
	for(new i =0; i<= MAX_PLAYERS;i++){
	    if(IsPlayerConnected(i) && !IsPlayerNPC(i)){
			Itter_Add(Player,i);
			FiringTimer[i] = SetTimerEx("Firing",250,1,"i",i);
			ZombieKill[i] = -1;
		}
		else if(IsPlayerConnected(i) && IsPlayerNPC(i)){
     	    Itter_Add(Bot,i);

     	    //If he's a zombie. Activate him.
		    if(!strfind(PlayerName(i),ZOMBIE_NAME,true)){
			    SetupZombie(i);
		    }
		}
	}
	new Float:h;
	for(new v=0;v<MAX_VEHICLES;v++){
	    GetVehicleHealth(v,h);
	    if(h)Itter_Add(Vehicle,v);
	}
	print("\n=====================================");
	print(" Zombie Filterscript By Wafffllesss    ");
	print("=====================================\n");
	return 1;
}

//=======================================[ Timers ]=========================================//
public Firing(playerid){
	new up_dw,lf_rg,o_keys,weapon;
	new Float:x,Float:y,Float:z;

	weapon = GetPlayerWeapon(playerid);
	GetPlayerKeys(playerid,o_keys,up_dw,lf_rg);
	if(o_keys == KEY_FIRE || o_keys == (KEY_FIRE+128) ){
	    if(!FiringClick[playerid] || Automatic(weapon))
	    {
		    FiringClick[playerid] = true;
		    GetPlayerPos(playerid,x,y,z);
		    foreach(Bot,b){
				if(IsPlayerFacingPlayer(playerid,b,5.0)){
			        if(IsPlayerInRangeOfPoint(b,WeaponRanges[weapon],x,y,z)){
			            Zombies[b][LastZombieHealth] -= float(WeaponDamage[weapon]);
			            //printf("%f",Zombies[b][LastZombieHealth]);
			            if(Zombies[b][LastZombieHealth] <= 0.0 && !Zombies[b][Dying]){
			                SendDeathMessage(playerid,b,weapon);
			                Zombies[b][Dying] = true;
			            }
			        }
		        }
		    }
	    }
	}else{
	    FiringClick[playerid] = false;
	}
}
public KickZombie(playerid){
	Kick(playerid);
	Zombies[playerid][Dying]=false;
	KillTimer(Zombies[playerid][HPtimer]); Zombies[playerid][HPtimer] = false;
	KillTimer(Zombies[playerid][Ztimers]); Zombies[playerid][Ztimers] = false;
	if(Zombies[playerid][NPTIMER]){
	    KillTimer(Zombies[playerid][NPTIMER]);
	    Zombies[playerid][NPTIMER] = false;
	}
}
public CheckHP(playerid){ // Check the Zombie HP.
	new Float:x,Float:y,Float:z;
	new cp = GetClosestPlayer(playerid);

	if(IsPlayerInAnyVehicle(cp)){
		new cpc = GetPlayerVehicleID(cp);
		GetVehiclePos(cpc,x,y,z);
		GetXYInFrontOfVehicle(cpc,x,y,1.5);
		if(IsPlayerInRangeOfPoint(playerid,2.0,x,y,z) && GetPlayerSpeed(cp) > 10.0){
			Zombies[playerid][LastZombieHealth] -= (GetPlayerSpeed(cp)*2);
		}
	}
	if(	Zombies[playerid][LastZombieHealth] <= 0.0 && Zombies[playerid][ZombieSpawned]){
        ApplyAnimation(playerid,"Knife","KILL_Knife_Ped_Die",1,0,1,0,0,0);
		SetTimerEx("KickZombie",1500,0,"i",playerid);
		Zombies[playerid][Dying] = true;
	}
}

public NewPos(playerid){ // Make the zombie Run / Sprint
	if(	Zombies[playerid][LastZombieHealth] > 0.0 ){
		new Float:x,Float:y,Float:z;
		new Float:ax,Float:ay,Float:az,Float:dif;
		GetPlayerPos(Zombies[playerid][ZombieTarget],ax,ay,az);
		GetPlayerPos(playerid,x,y,z);
		if( az <= (z+3.0) && az >= (z-3.0)){
			if(Zombies[playerid][ZombieRunning] == 1){
				ApplyAnimation(playerid,"Muscular","MuscleRun",1,1,1,0,0,0);
				GetXYInFrontOfPlayer(playerid,x,y,2.0);
		 	}
			else if(Zombies[playerid][ZombieRunning] == 2){
				ApplyAnimation(playerid,"Muscular","MuscleSprint",1,1,1,0,0,0);
				GetXYInFrontOfPlayer(playerid,x,y,2.8);
		 	}

			dif = az;
	      	SetPlayerPos(playerid,x,y,dif);
	    }else{
			if(Zombies[playerid][ZombieRunning]) Parar(playerid);
			GetPlayerPos(playerid,x,y,z);
	        SetPlayerPosFindZ(playerid,x,y,z);
	    }
    }
}
public CheckCloserPlayers(playerid){ // Detect the closest player and chase him
    if(	Zombies[playerid][LastZombieHealth] > 0.0 ){
		new cp = GetClosestPlayer(playerid);
		new Float:MinDistance = 3.0;
		if(IsPlayerInAnyVehicle(cp)){ MinDistance = 5.0; }
		Zombies[playerid][ZombieTarget] = cp;
		if(GetDistanceToPlayer(playerid,cp) <= 70.0 && GetDistanceToPlayer(playerid,cp) > 15.0){
	        IrParaPlayer(1,playerid,cp);
		}else if(GetDistanceToPlayer(playerid,cp) <= 15.0 && GetDistanceToPlayer(playerid,cp) > MinDistance){
	        IrParaPlayer(0,playerid,cp);
		}else if(GetDistanceToPlayer(playerid,cp) <= MinDistance){
		    Parar(playerid);
		}
		if(GetDistanceToPlayer(playerid,cp) <= MinDistance){
	    	new Float:h;
	    	if(IsPlayerInAnyVehicle(cp)){
				new cpc = GetPlayerVehicleID(cp);
				GetVehicleHealth(cpc,h);
				if(GetDistanceToPlayer(playerid,cp) < MinDistance){
				    SetVehicleHealth(cpc,h-80.0);
				    ApplyAnimation(playerid,"Gangs","shake_carSH",1,1,1,0,0,0);
				}

	    	}else{
		    	GetPlayerHealth(cp,h);
		    	if(GetDistanceToPlayer(playerid,cp) > 1.5){
					SetPlayerHealth(cp,h-5.0);
				}else{
				    if(!Zombies[playerid][ZombieKilling]){
				    	if(!IsDying(cp)){
							FinishHim(playerid,cp);
						}
				    }
				}
	    	}
	    }
    }
}
public KilledBy(playerid,killer){ // Apply 'dying' animation and kill the player.
	if(Zombies[killer][ZombieKilling] == playerid){
	    ApplyAnimation(playerid,"Knife","KILL_Knife_Ped_Die",1,0,1,0,0,0);
	    TogglePlayerControllable(playerid,true);
	    SetPlayerHealth(playerid,0.0);
	    ClearAnimations(killer);
	    ZombieKill[playerid] = killer;
    }
}
//=======================================[ Functions ]=========================================//
stock Automatic(weaponid){
	switch(weaponid){
	    case 9,22,23,24,27,28,29,30,31,32,37,38: return true;
	}
	return false;
}
stock IsDying(playerid){ // Verify if a zombie is killing the player
	foreach(Bot,b){
	    if(Zombies[b][ZombieKilling] == playerid) return true;
	}
	return false;
}
stock SetupZombie(playerid){ // Activate the zombie.
    new Float:px,Float:py,Float:pz;
	Zombies[playerid][HPtimer] = SetTimerEx("CheckHP",100,1,"i",playerid);
    Zombies[playerid][Ztimers] = SetTimerEx("CheckCloserPlayers",1000,1,"i",playerid);
    GetPlayerPos(Caller,px,py,pz);
    SetPlayerPos(playerid,px,py,pz);
    Zombies[playerid][ZombieRunning] = false;
    SendClientMessageToAll(COLOR_RED,"A Zombie Connected!");

    new Zskin=1;
    if(Zombie_Skin == -1){
        new rd = random(sizeof(ZombieSkins));
        if(IsValidSkin(ZombieSkins[rd])){
			Zskin = ZombieSkins[rd];
        }
    }else if(Zombie_Skin == -2){
        new rd = random(299);
        if(IsValidSkin(rd)){
            Zskin = rd;
        }
	}else if(IsValidSkin(Zombie_Skin)){
		Zskin = Zombie_Skin;
    }
    SetPlayerSkin(playerid,Zskin);

    Zombies[playerid][ZombieSpawned] = true;
    Zombies[playerid][LastZombieHealth] = 100.0;
}

stock FinishHim(playerid,target){ // Do i need to explain that?
    Zombies[playerid][ZombieKilling] = target;
	TogglePlayerControllable(target,false);
	SetPlayerToFacePlayer(playerid,target);
	SetPlayerToFacePlayer(target,playerid);

	ApplyAnimation(target,"Knife","KILL_Knife_Ped_Damage",1,0,1,0,0,0);
	ApplyAnimation(playerid,"Knife","KILL_Knife_Player",1,0,1,0,0,0);
	SetTimerEx("KilledBy",1500,0,"ii",target,playerid);
}

stock Parar(playerid){ // Makes the zombie stop walking.
	if(Zombies[playerid][ZombieRunning]){
		if(Zombies[playerid][NPTIMER]){
		    KillTimer(Zombies[playerid][NPTIMER]);
		    Zombies[playerid][NPTIMER] = false;
	    }
	    Zombies[playerid][ZombieRunning] = false;
	    ClearAnimations(playerid);
	}
}

stock IrParaPlayer(modo,playerid,paraid){ //Make the zombie chase the targeted player. Mode: 1- Run | 2- Sprint
    SetPlayerToFacePlayer(playerid,paraid);
    if(modo == 0 && Zombies[playerid][ZombieRunning] != 1) Caminhar(playerid);
    else if(modo == 1 && Zombies[playerid][ZombieRunning] != 2) Correr(playerid);
}

stock Caminhar(playerid){ //Run forward.
	Zombies[playerid][ZombieRunning] = 1;
	Zombies[playerid][NPTIMER] = SetTimerEx("NewPos",400,1,"i",playerid);
}

stock Correr(playerid){ //Sprint forward.
	Zombies[playerid][ZombieRunning] = 2;
	Zombies[playerid][NPTIMER] = SetTimerEx("NewPos",300,1,"i",playerid);
}

stock AlvoDeAlguem(alvoid){ // Check if the player is target from any zombie.
	foreach(Bot,b){
	    if(Zombies[b][ZombieTarget] == alvoid) return b;
	}
	return false;
}

stock KickZombies(){ //Kick All Zombies.
	foreach(Bot,b){
		if(!strfind(PlayerName(b),ZOMBIE_NAME,true)){
			SetTimerEx("KickZombie",1,0,"i",b);
		}
	}
}
stock SetPlayerToFacePlayer(playerid, targetid) // From a_angles.inc ( Tannz0rz )
{

	new
		Float:pX,
		Float:pY,
		Float:pZ,
		Float:X,
		Float:Y,
		Float:Z,
		Float:ang;

	if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)) return 0;

	GetPlayerPos(targetid, X, Y, Z);
	GetPlayerPos(playerid, pX, pY, pZ);

	if( Y > pY ) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	else if( Y < pY && X < pX ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	else if( Y < pY ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);

	if(X > pX) ang = (floatabs(floatabs(ang) + 180.0));
	else ang = (floatabs(ang) - 180.0);

	SetPlayerFacingAngle(playerid, ang);

 	return 0;

}

stock PlayerName(playerid){
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid,pname,MAX_PLAYER_NAME);
	return pname;
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

stock GetClosestPlayer(p1){
	new Float:dis,Float:dis2,playerid;
	playerid = -1;
	dis = 99999.99;
	foreach(Player,x){
		if(x != 0)
		{
			dis2 = GetDistanceToPlayer(p1,x);
			if (dis2 < dis && dis2 != -1.00)
			{
				dis = dis2;
				playerid = x;
			}
		}
	}
	//printf("[%d]%s",playerid,PlayerName(playerid));
	return playerid;
}
stock Float:GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	if (IsPlayerInAnyVehicle(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	else GetPlayerFacingAngle(playerid, a);
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
	return a;
}

stock IsValidSkin(skinid) // Not mine. Do not remmeber who did it.
{
    #define	MAX_BAD_SKINS 22
    new badSkins[MAX_BAD_SKINS] =
    { 3, 4, 5, 6, 8, 42, 65, 74, 86, 119, 149, 208, 268, 273, 289 };
    if (skinid < 0 || skinid > 299) return false;
    for (new i = 0; i < MAX_BAD_SKINS; i++) { if (skinid == badSkins[i]) return false; }
    #undef MAX_BAD_SKINS
    return 1;
}

stock Float:GetPlayerSpeed(playerid) // Not mine. Do not remmember who did it. (It dosn't return the right speed, but works for what I need.)
{
	new Float:vX, Float:vY, Float:vZ;
	if (!IsPlayerInAnyVehicle(playerid))
	{
	    GetPlayerVelocity(playerid, vX, vY, vZ);
	}
	else
	{
	    GetVehicleVelocity(GetPlayerVehicleID(playerid), vX, vY, vZ);
	}
	return floatsqroot(vX*vX + vY*vY + vZ*vZ)*100;
}
stock Float:GetXYInFrontOfVehicle(vehicleid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetVehiclePos(vehicleid, x, y, a);
	GetVehicleZAngle(vehicleid, a);
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
	return a;
}
stock IsPlayerFacingPlayer(playerid, playerid2, Float:dOffset) // From a_angles.inc ( Tannz0rz )
{

	new
		Float:X,
		Float:Y,
		Float:Z,
		Float:pX,
		Float:pY,
		Float:pZ,
		Float:pA,
		Float:ang;

	if(!IsPlayerConnected(playerid)) return 0;

    GetPlayerPos(playerid2, pX, pY, pZ);
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, pA);

	if( Y > pY ) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	else if( Y < pY && X < pX ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	else if( Y < pY ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);

	if(AngleInRangeOfAngle(-ang, pA, dOffset)) return true;

	return false;
}

stock AngleInRangeOfAngle(Float:a1, Float:a2, Float:range) // From a_angles.inc ( Tannz0rz )
{

	a1 -= a2;
	if((a1 < range) && (a1 > -range)) return true;

	return false;

}
//=======================================[ Callbacks ]=========================================//

public OnFilterScriptExit()
{
    KickZombies();
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(IsPlayerNPC(playerid)){ SpawnPlayer(playerid); }
	else{ FiringTimer[playerid] = SetTimerEx("Firing",250,1,"i",playerid);}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(!IsPlayerNPC(playerid)){
		KillTimer(FiringTimer[playerid]);
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid)){
	    if(!strfind(PlayerName(playerid),ZOMBIE_NAME,true)){
		    SetupZombie(playerid);
	    }
	}
	if(ZombieKill[playerid] != -1){
	    Zombies[ZombieKill[playerid]][ZombieKilling] = false;
	    ZombieKill[playerid] = -1;
		return 1;
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(ZombieKill[playerid] != -1){
	    SendDeathMessage(ZombieKill[playerid],playerid,reason);
		return 1;
	}
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
    if(strcmp(cmdtext, "/zombie", true) == 0) {
        if(!IsPlayerAdmin(playerid)) return false;
        Caller = playerid;
        new newname[64];
        format(newname,sizeof(newname),"%s_%d",ZOMBIE_NAME,LastAdded);
	    ConnectNPC(newname,"zombie");
	    LastAdded++;
		return 1;
	}
	return 0;
}