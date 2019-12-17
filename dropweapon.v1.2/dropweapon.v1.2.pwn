//------------------------------------------------------------------------------
//
//   Drop Weapon Filter Script v1.2
//   Designed for SA-MP v0.2
//
//   Created by Flyin
//   Modified by uncajesse
//
//   http://forum.sa-mp.com/index.php?topic=19969
//
//------------------------------------------------------------------------------


#include <a_samp>

public OnFilterScriptInit()
{
	print("\n***************************");
	print("* Drop Filter Script v1.2 *");
	print("* original by       Flyin *");
	print("* edited by     uncajesse *");
	print("*          Loaded         *\n***************************\n");
	return 1;
}

public OnFilterScriptExit()
{
    print("\n**********************\n*Drop Script UnLoaded*\n**********************\n");
	return 1;
}

// * main defines *

new weapmod[600] = {1212,331,333,334,335,336,337,338,339,341,321,322,323,324,
325,326,342,343,344,345,345,345,346,347,348,349,350,351,352,353,355,356,372,357,
358,359,360,361,362,363,364,365,366,367,368,369,371};


new PickUpMoney[101] = {false, ...};
new Float:PickUpArmour[101] = {0.0, ...}; // added by uncajesse
new PickUpMoneyAmmount[101] = {0, ...}; // added by uncajesse
new PickUpWeaponSlot[101] = {0, ...}; // added by uncajesse
new PickUpWeaponAmmo[101] = {0, ...}; // added by uncajesse
new DropPick[101] = {false, ...};


forward Float:GetPlayerArmourEx(p);
Float:GetPlayerArmourEx(p)
{
	new Float:a;
	GetPlayerArmour(p, a);
	return a;
}

// * OnPlayerDeath *
public OnPlayerDeath(playerid, killerid, reason)
{
	// defines
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	new weap[200];
	new ammo;
	new temp;
	new s[256];
	new PX;
	new PY;
	new PickUpMoneyBit = false; // added by uncajesse
	// loop through weapon slots
 	for(new i=0;i<15;i++){
		// placing pickups
		if(i<12){
			GetPlayerWeaponData(playerid, i, weap[i], ammo);
			if(weapmod[weap[i]] == 1212){
				PickUpMoneyBit=true; // added by uncajesse
			} else {
			 	// calculating random pos near to player
			    format(s, 256 ,"%.0f", X);
				temp = strval(s);
				PX = random((temp+2)-(temp-2))+(temp-2);
				format(s, 256 ,"%.0f", Y);
				temp = strval(s);
				PY = random((temp+2)-(temp-2))+(temp-2);
				// create pickup
			    new pickid = CreatePickup(weapmod[weap[i]], 4,PX, PY, Z);
			    PickUpWeaponSlot[pickid]=i;
			    PickUpWeaponAmmo[pickid]=ammo;
				DropPick[pickid]=true;
				PickUpArmour[pickid]=0.0;
				PickUpMoney[pickid]=false; // added by uncajesse
			}
	 	}
	 	if(i==13){
			// health drop, removed
			// why drop health when the player is dead?
		}
 		if(i==14){
 		    new Float:playerarmour = GetPlayerArmourEx(playerid);
			if(playerarmour>0.0){
			 	// calculating random pos near to player
			    format(s, 256 ,"%.0f", X);
				temp = strval(s);
				PX = random((temp+2)-(temp-2))+(temp-2);
				format(s, 256 ,"%.0f", Y);
				temp = strval(s);
				PY = random((temp+2)-(temp-2))+(temp-2);
				// create pickup
			    new pickid = CreatePickup(373, 4,PX, PY, Z);
			    PickUpWeaponSlot[pickid]=14;
			    PickUpWeaponAmmo[pickid]=0;
			    PickUpArmour[pickid]=playerarmour; // added by uncajesse
				DropPick[pickid]=true;
				PickUpMoney[pickid]=false; // added by uncajesse
		 	} else {
				PickUpMoneyBit=true; // added by uncajesse
			}
	 	}
		if(i==15){
			PickUpMoneyBit=true; // added by uncajesse
		}
 	}
	// create money pickup
	if(PickUpMoneyBit)
	{ // added by uncajesse
	 	// calculating random pos near to player
	    format(s, 256 ,"%.0f", X);
		temp = strval(s);
		PX = random((temp+2)-(temp-2))+(temp-2);
		format(s, 256 ,"%.0f", Y);
		temp = strval(s);
		PY = random((temp+2)-(temp-2))+(temp-2);
		// placing money pickup
		new pickid = CreatePickup(1212, 4,PX, PY, Z);
		PickUpMoney[pickid]=true;
		PickUpMoneyAmmount[pickid]=GetPlayerMoney(playerid);
		PickUpWeaponAmmo[pickid]=0;
		PickUpArmour[pickid]=0.0;
		DropPick[pickid]=true;
	}
	// end placing pickups
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(PickUpMoney[pickupid]){
		GivePlayerMoney(playerid,PickUpMoneyAmmount[pickupid]); // added by uncajesse
	}
	if(PickUpArmour[pickupid]>0){ // added by uncajesse
		new Float:currentarmour = GetPlayerArmourEx(playerid);
		if(currentarmour<255.0)
		{
			new Float:newarmour = currentarmour + PickUpArmour[pickupid];
			if(newarmour>255.0)
			{
				newarmour = float(255);
			}
			SetTimerEx("PlayerPickUpPickupSetArmour", 500, 0, "df", playerid, newarmour);
		} else {
		    return 0;
		}
	}
	if(PickUpWeaponAmmo[pickupid]>0){
	    new currentslotweapon, currentslotammo;
	    GetPlayerWeaponData(playerid,PickUpWeaponSlot[pickupid],currentslotweapon,currentslotammo);
	    new newslotammo = currentslotammo + PickUpWeaponAmmo[pickupid]; // added by uncajesse
        SetTimerEx("PlayerPickUpPickupSetAmmo", 500, 0, "d", playerid, PickUpWeaponSlot[pickupid], newslotammo);  // added by uncajesse
	}
	if(DropPick[pickupid]){
	    DropPick[pickupid]=false; // added by uncajesse
	    PickUpMoney[pickupid]=false; // added by uncajesse
	    PickUpArmour[pickupid]=0;
		SetTimerEx("PickDestroy", 500, 0, "d", pickupid); // Destroying pickups
	}
	return 1;
}

// set player's ammo, added by uncajesse
forward PlayerPickUpPickupSetAmmo(playerid, slotid, slotammo);
public PlayerPickUpPickupSetAmmo(playerid, slotid, slotammo)
{
	SetPlayerAmmo(playerid,slotid,slotammo);
}

// set player's armour, added by uncajesse
forward PlayerPickUpPickupSetArmour(playerid, Float:playerarmour);
public PlayerPickUpPickupSetArmour(playerid, Float:playerarmour)
{
	SetPlayerArmour(playerid,playerarmour);
}

forward PickDestroy(o);
public PickDestroy(o)DestroyPickup(o); // Destroy pickup ! Muha xD!

// the end

