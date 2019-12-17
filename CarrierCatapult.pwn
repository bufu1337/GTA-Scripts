//this script is by [UG]Mobster property of ultimate-gamers and sa-mp forums please do not remove any credits. thank-you

#include <a_samp>

//ug carrier
new lift11;//elevator varible
new lift22;//sidelift varible
new lift1;//elevator object
new lift2;//sidelift object

#define CarrierCatapultX 2308.7783
#define CarrierCatapultY -3355.8147
#define CarrierCatapultZ 18.5131

#define CatapultSpeed 45
#define EjectHeight 20

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Aircraft Carrier + Catapult By [UG]Mobster");
	print(" Ultiamte-Gamers www.ultimategamers.info");
	print("--------------------------------------\n");

	//lift objects
	lift1 = CreateObject(3115, 2438.869141, -3349.019531, 17.201916, 0.0000, 0.0000, 0.0001);
	lift2 = CreateObject(3114, 2396.578613, -3364.160889, 16.960835, 0.0000, 0.0000, 0.0000);
	//carrier ship
	CreateObject(10771, 2339.821777, -3349.019287, 5.724000, 0.0000, 0.0000, 179.9996);
	CreateObject(11145, 2402.685059, -3348.854004, 4.425000, 0.0000, 0.0000, 179.9996);
	CreateObject(11146, 2348.800293, -3349.596436, 12.555000, 0.0000, 0.0000, 179.9996);
	CreateObject(10770, 2336.546631, -3341.439697, 38.907001, 0.0000, 0.0000, 179.9996);
	CreateObject(11237, 2336.677002, -3341.356934, 38.504002, 0.0000, 0.0000, 179.9996);
	CreateObject(11149, 2345.781006, -3343.639893, 12.114000, 0.0000, 0.0000, 179.9996);
	//vehicles
	AddStaticVehicle(520,2386.0637,-3341.1990,19.2313,149.1671,0,0); // hydra carrier
	AddStaticVehicle(520,2397.9280,-3339.8740,19.2333,154.6306,0,0); // hydra carrier
	AddStaticVehicle(425,2290.6882,-3342.1926,19.0844,95.4291,43,0); // hunter carrier
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_CROUCH  && GetVehicleModel(GetPlayerVehicleID(playerid)) == 520)
	{
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
 	CreateExplosion(x,y,z, 12, 6);
	SetPlayerPos(playerid,x,y,z+EjectHeight);
	GivePlayerWeapon(playerid,46,1);
	}
	if (newkeys & 128)
	{
		if (PlayerToPoint(12.5, playerid,2438.869141, -3349.019531, 10.252022) || PlayerToPoint(12.5, playerid,2438.869141, -3349.019531, 17.201916))
		{
			if(lift11 == 0) {
				MoveObject(lift1,2438.869141, -3349.019531, 10.252022, 1.500000);
				lift11 = 1;
			}
			else
			{
				MoveObject(lift1,2438.869141, -3349.019531, 17.201916, 1.500000);
				lift11 = 0;
			}
		}
	}
	if (newkeys & 128)
	{
		if (PlayerToPoint(11.5, playerid,2396.578613, -3364.160889, 9.910942) || PlayerToPoint(11.5, playerid,2396.578613, -3364.160889, 16.960835))
		{
			if(lift22 == 0) {
				MoveObject(lift2,2396.578613, -3364.160889, 9.910942, 1.500000);
				lift22 = 1;
			}
			else
			{
				MoveObject(lift2,2396.578613, -3364.160889, 16.960835, 1.500000);
				lift22 = 0;
			}
		}
	}
	if (newkeys & 128)
	{
		if (PlayerToPoint(5.5, playerid,CarrierCatapultX,CarrierCatapultY,CarrierCatapultZ) && GetVehicleModel(GetPlayerVehicleID(playerid)) == 520)
		{
			new Float:velocityx, Float:velocityy, Float:velocityz;
			GetVehicleVelocity(GetPlayerVehicleID(playerid), velocityx, velocityy, velocityz);
			SetVehicleVelocity(GetPlayerVehicleID(playerid), velocityx-CatapultSpeed, velocityy, velocityz);
		}
	}

	return 1;
}

forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}