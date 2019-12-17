#define FILTERSCRIPT

// remove bullets after __ seconds
#define REMOVE_BULLET_TIME 	(30)
// use streamer (unlimited number of objects, bullets appear after about one second delay)
// remove line to disable
#define USE_STREAMER

// max number of bullets (will throw an error if there are too many bullets creaded)
#define MAX_BULLETS			(500)

// object used for bullets. some people use 327. by default, a red pool ball is used. you can find some other small objects here: http://gta-sa-mp.de/forum/index.php?page=Objects&objPage=searchName&objSearch=ball
#define OBJECT_BULLET		(3101)

#include <a_samp>

#if defined USE_STREAMER
	#tryinclude <streamer>
#endif

new bullets_pending;

public OnFilterScriptInit()
{
	printf("bullets filterscript loaded..");
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(floatround(fX) == 0 && floatround(fY) == 0) return 1;

	#if !defined STREAMER_TYPE_OBJECT
		if(bullets_pending > MAX_BULLETS) return SendClientMessage(playerid, -1, "Error! Too many bullets... or whatever.");
	#endif

	bullets_pending++;
	new bullet;

	#if defined STREAMER_TYPE_OBJECT
		bullet = CreateDynamicObject(OBJECT_BULLET, fX, fY, fZ, 0.0, 0.0, 0.0);
	#else
		bullet = CreateObject(OBJECT_BULLET, fX, fY, fZ, 0.0, 0.0, 0.0);
	#endif
	SetTimerEx("RemoveBullet", REMOVE_BULLET_TIME * 1000, false, "i", bullet);
	return 1;
}

forward RemoveBullet(objectid);
public RemoveBullet(objectid)
{
	bullets_pending--;
	#if defined STREAMER_TYPE_OBJECT
		DestroyDynamicObject(objectid);
	#else
		DestroyObject(objectid);
	#endif
}

public OnFilterScriptExit()
{
	printf("bullets filterscript unloaded..");
	return 1;
}