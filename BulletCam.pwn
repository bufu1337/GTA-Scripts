/*
Bullet cam by kadaradam
Feel free to edit the script, just please keep the credits.

Video:
https://www.youtube.com/watch?v=5x7flKNjCRQ

2014. 02. 11.
*/

#include <a_samp>
#define CAMERA_MOVE_TIME 5000

public OnFilterScriptInit()
{
	print(">> Filterscript loaded: Bullet cam by kadaradam");
	return 1;
}
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(hittype == 0 || hittype == 3 || hittype == 4)
	{
		if(weaponid == 34)
		{
		    SetPlayerArmedWeapon(playerid, 0);
		    TogglePlayerControllable(playerid, 0);

			new
				Float:fOPos[3],
				Float:fHPos[3],
				Float:Angle,
				Float:Speed,
				object,
				time
			;

		    GetPlayerLastShotVectors(playerid, fOPos[0], fOPos[1], fOPos[2], fHPos[0], fHPos[1], fHPos[2]);
		    GetPlayerFacingAngle(playerid, Angle);

			Speed = VectorSize(fOPos[0]-fHPos[0], fOPos[1]-fHPos[1], fOPos[2]-fHPos[2]) / ( CAMERA_MOVE_TIME / 1000 );

		    object = CreatePlayerObject(playerid, 1636, fOPos[0], fOPos[1], fOPos[2], 0.0, 0.0, 0.0);
		    SetObjectFacePoint(playerid, object, fHPos[0], fHPos[1]);
		    MovePlayerObject(playerid, object, fHPos[0], fHPos[1], fHPos[2], Speed);

		    SetTimerEx("CameraEnd", CAMERA_MOVE_TIME, false, "i", playerid);
		    SetTimerEx("SparkCreate", CAMERA_MOVE_TIME-500, false, "ifffi",  playerid, fHPos[0], fHPos[1], fHPos[2], object);

	    	fHPos[0] -= (1 * floatsin(-Angle, degrees));
	    	fHPos[1] -= (1 * floatcos(-Angle, degrees));
	    	fOPos[0] += (1 * floatsin(-Angle, degrees));
	    	fOPos[1] += (1 * floatcos(-Angle, degrees));

			time = CAMERA_MOVE_TIME + floatround(CAMERA_MOVE_TIME * 0.15, floatround_round);

		    InterpolateCameraPos(playerid, fOPos[0], fOPos[1], fOPos[2], fHPos[0], fHPos[1], fHPos[2], time, CAMERA_MOVE);
	    }
    }
	return 1;
}

forward CameraEnd(playerid);
public CameraEnd(playerid)
{
    SetPlayerArmedWeapon(playerid, 34);
    TogglePlayerControllable(playerid, 1);
    SetCameraBehindPlayer(playerid);
}
forward SparkCreate(playerid, Float:X, Float:Y, Float:Z, objectid);
public SparkCreate(playerid, Float:X, Float:Y, Float:Z, objectid)
{
	SetTimerEx("Spark", 100, false, "i", CreateObject(18717, X, Y, Z - 1.6, 0.0, 0.0, 0.0) );
	DestroyPlayerObject(playerid, objectid);
}
forward Spark(objectid);
public Spark(objectid) DestroyObject(objectid);

stock SetObjectFacePoint(playerid, objectid, Float: X, Float: Y) // By Lorenc_ | http://forum.sa-mp.com/showpost.php?p=1456045&postcount=2563
{
    static
        Float: pX,      Float: oX,
        Float: pY,      Float: oY,
        Float: oZ
    ;
    GetPlayerObjectRot(playerid, objectid, oX, oY, oZ);
    GetPlayerObjectPos(playerid, objectid, pX, pY, oZ);

    oZ = ( floatadd(atan2(floatsub(Y, pY), floatsub(X, pX)), 270.0) );

    SetPlayerObjectRot(playerid, objectid, oX, oY, oZ);
}