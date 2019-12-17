#include <a_samp>
#define Speedgun 23 //pistol
#define COLOR_LIGHTGREEN 	0x00FF7FFF
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))


public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Victious' speedgun!");
	print("--------------------------------------\n");
	return 1;
}


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (PRESSED(KEY_HANDBRAKE))
	{
		if(GetPlayerWeapon(playerid) == Speedgun)
		{
		    GetPlayerSpeed(playerid);
      	}
	}
	return 1;
}

Float:DistanceCameraTargetToLocation(Float:CamX, Float:CamY, Float:CamZ,  Float:ObjX, Float:ObjY, Float:ObjZ,  Float:FrX, Float:FrY, Float:FrZ)
{

    new Float:TGTDistance;

    // get distance from camera to target
    TGTDistance = floatsqroot((CamX - ObjX) * (CamX - ObjX) + (CamY - ObjY) * (CamY - ObjY) + (CamZ - ObjZ) * (CamZ - ObjZ));

    new Float:tmpX, Float:tmpY, Float:tmpZ;

    tmpX = FrX * TGTDistance + CamX;
    tmpY = FrY * TGTDistance + CamY;
    tmpZ = FrZ * TGTDistance + CamZ;

    return floatsqroot((tmpX - ObjX) * (tmpX - ObjX) + (tmpY - ObjY) * (tmpY - ObjY) + (tmpZ - ObjZ) * (tmpZ - ObjZ));
}

stock IsPlayerAimingAt(playerid, Float:x, Float:y, Float:z, Float:radius)
{
    new Float:cx,Float:cy,Float:cz,Float:fx,Float:fy,Float:fz;
    GetPlayerCameraPos(playerid, cx, cy, cz);
    GetPlayerCameraFrontVector(playerid, fx, fy, fz);
    return (radius >= DistanceCameraTargetToLocation(cx, cy, cz, x, y, z, fx, fy, fz));
}

stock GetDistanceToCar(playerid,carid)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2,Float:dis;
	if (!IsPlayerConnected(playerid))return -1;
	GetPlayerPos(playerid,x1,y1,z1);GetVehiclePos(carid,x2,y2,z2);
	dis = floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
	return floatround(dis);
}

stock GetClosestVehicle(playerid, &Float:dis = (Float:0x7F800000))
{
  dis = (Float:0x7F800000);
  new Float:X, Float:Y, Float:Z;
  if(GetPlayerPos(playerid, X, Y, Z)) {
    new vehicleid = INVALID_VEHICLE_ID;
    for(new v, Float:temp, Float:VX, Float:VY, Float:VZ; v != MAX_VEHICLES; v++) {
      if(GetVehiclePos(v, VX, VY, VZ)) {
        VX -= X, VY -= Y, VZ -= Z;
        temp = VX * VX + VY * VY + VZ * VZ;
        if(temp < dis) dis = temp, vehicleid = v;
      }
    }
    dis = floatpower(dis, 0.5);
    return vehicleid;
  }
  return INVALID_VEHICLE_ID;
}

stock GetPlayerSpeed(playerid) //MPH
{
    new veh = GetClosestVehicle(playerid);
    if (veh)
    {
        new Float:x,Float:y,Float:z,string[128];
        GetVehiclePos(veh,x,y,z);
        IsPlayerAimingAt(veh,x,y,z,25);
        new Float:speed_x,Float:speed_y,Float:speed_z,Float:final_speed,final_speed_int;
        GetVehicleVelocity(veh, speed_x, speed_y, speed_z);
        final_speed = floatsqroot(((speed_x*speed_x)+(speed_y*speed_y))+(speed_z*speed_z))*85.4166672; // 136.666667 = kmph  // 85.4166672= mph
        final_speed_int = floatround(final_speed,floatround_round);
        format(string,sizeof(string),"Speed: %i MPH",final_speed_int,2000);
        SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
    }
    return 1;
}