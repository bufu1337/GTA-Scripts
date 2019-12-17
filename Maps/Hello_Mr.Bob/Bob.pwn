/*
================================================================================
 (C) 28-12-07                                                                 ==
      Hello Mr.Bob is scripted by Tr1viUm.                                    ==
																			  ==
Thanks: Y_Less & Simon for GetXYinFrontOfPlayer      -                        ==
        Anyone that helped setting SA-MP up          -                        ==
																			  ==
================================================================================*/

#include <a_samp>

/*----------------------------------------------------------------------------*/

new InCargoBob[MAX_PLAYERS],CargoHours[MAX_PLAYERS],CargoMinutes[MAX_PLAYERS],bool:ObjectsAdded[MAX_PLAYERS];

/*----------------------------------------------------------------------------*/

#define NOT_IN_CARGO "You need to be in a cargobob."
#define ENTERED_CARGO "You entered the cargobob's back."
#define TO_FAROF_CARGO "You need to be at a cargobob's back."

#if !defined COLOR_NEUTRALGREEN
#define COLOR_NEUTRALGREEN 0x81CFAB00

#endif

#if !defined dcmd
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

#endif

/*----------------------------------------------------------------------------*/

#if defined FILTERSCRIPT

public OnFilterScriptInit(){
    print("\n Hello Mr.Bob succesfully loaded \n");
	return true;
}

public OnFilterScriptExit(){
    print("\n Hello Mr.Bob succesfully unloaded \n");
	return true;
}

#endif

/*----------------------------------------------------------------------------*/

AddCargoObjects(playerid)
{
	CreatePlayerObject(playerid,5152, 226.368317, 80.976151, 10640.210938, 0.0000, 304.9961, 270.0000);
    CreatePlayerObject(playerid,5152, 224.218292, 81.001152, 10640.185547, 0.0000, 304.9961, 270.0000);
    CreatePlayerObject(playerid,5152, 222.118256, 81.001152, 10640.160156, 0.0000, 304.9961, 270.0000);
    CreatePlayerObject(playerid,5152, 219.968353, 81.001152, 10640.134766, 0.0000, 304.9961, 270.0000);
    CreatePlayerObject(playerid,17950, 222.161911, 85.046188, 10641.463867, 0.0000, 0.0000, 180.0000);
    CreatePlayerObject(playerid,16644, 225.152069, 82.224739, 10639.169922, 0.0000, 0.0000, 180.0000);
    CreatePlayerObject(playerid,16644, 225.152069, 84.824745, 10639.169922, 0.0000, 0.0000, 180.0000);
    CreatePlayerObject(playerid,16644, 225.152069, 87.424706, 10639.169922, 0.0000, 0.0000, 180.0000);
    CreatePlayerObject(playerid,1801, 223.812393, 84.994156, 10639.186523, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1801, 223.812393, 84.994156, 10640.249023, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1801, 219.312515, 84.994156, 10640.249023, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1801, 219.312515, 84.994156, 10639.194336, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,936, 224.351379, 85.508743, 10639.678711, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,936, 219.851501, 85.508743, 10639.678711, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,937, 224.319031, 85.485367, 10640.628906, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,2063, 219.275833, 82.755394, 10640.115234, 0.0000, 0.0000, 270.0000);
    CreatePlayerObject(playerid,2737, 225.210800, 83.374687, 10640.906250, 0.0000, 0.0000, 270.0000);
    CreatePlayerObject(playerid,14532, 222.043198, 88.440086, 10640.145508, 0.0000, 0.0000, 180.0000);
    CreatePlayerObject(playerid,16779, 221.681305, 83.962280, 10643.164063, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1215, 225.351257, 87.852737, 10641.887695, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1215, 218.826202, 87.852737, 10641.887695, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1485, 220.475174, 85.166641, 10640.143555, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1487, 220.133194, 85.811607, 10640.351563, 0.0000, 0.0000, 315.0000);
    CreatePlayerObject(playerid,1487, 219.850510, 85.519630, 10640.351563, 0.0000, 0.0000, 202.5000);
    CreatePlayerObject(playerid,1520, 220.168503, 85.400864, 10640.213867, 0.0000, 0.0000, 236.2501);
    CreatePlayerObject(playerid,1543, 219.897476, 85.657196, 10640.149414, 0.0000, 0.0000, 281.2500);
    CreatePlayerObject(playerid,1546, 219.513016, 85.285851, 10640.192383, 0.0000, 92.8191, 87.6625);
    CreatePlayerObject(playerid,2690, 223.368210, 85.511871, 10640.409180, 0.0000, 0.0000, 281.2500);
    CreatePlayerObject(playerid,2068, 222.325272, 85.086929, 10642.511719, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,2058, 224.326752, 85.524803, 10640.370117, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,2044, 219.295761, 83.865089, 10640.487305, 0.0000, 0.0000, 146.7229);
    CreatePlayerObject(playerid,2044, 219.295761, 83.565086, 10640.487305, 0.0000, 0.0000, 146.7229);
    CreatePlayerObject(playerid,2044, 219.295761, 83.290085, 10640.487305, 0.0000, 0.0000, 146.7229);
    CreatePlayerObject(playerid,2036, 219.279907, 82.316414, 10640.906250, 0.0000, 0.0000, 90.0000);
    CreatePlayerObject(playerid,2035, 219.220779, 82.025429, 10640.055664, 0.0000, 0.0000, 236.2501);
    CreatePlayerObject(playerid,2035, 219.220779, 82.775429, 10640.055664, 0.0000, 0.0000, 236.2501);
    CreatePlayerObject(playerid,2035, 219.220779, 83.525429, 10640.055664, 0.0000, 0.0000, 236.2501);
    CreatePlayerObject(playerid,1672, 219.095810, 83.898651, 10639.670898, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1672, 219.220779, 83.898651, 10639.670898, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1672, 219.095871, 83.648651, 10639.670898, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1672, 219.120865, 83.798660, 10639.670898, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1654, 219.320755, 83.319298, 10639.650391, 272.4414, 0.0000, 326.2500);
    CreatePlayerObject(playerid,1654, 219.320755, 82.994293, 10639.650391, 272.4414, 0.0000, 326.2500);
    CreatePlayerObject(playerid,2037, 219.195786, 81.650864, 10639.649414, 0.0000, 0.0000, 123.7499);
    CreatePlayerObject(playerid,2037, 219.195786, 82.150864, 10639.649414, 0.0000, 0.0000, 67.5000);
    CreatePlayerObject(playerid,2037, 219.420731, 81.850876, 10639.649414, 0.0000, 0.0000, 101.2500);
}

Float:GetXYOfVehicle(vehicleid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(vehicleid, x, y, a);
	GetVehicleZAngle(vehicleid, a);
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
	return a;
}

GetPlayerPosPower(playerid,Float: X,Float: Y,Float: Z,Float:PowX,Float:PowY,Float:PowZ,Float: PowXYZ)
{
	new Float: CtX,Float:CtY,Float:CtZ;
	new Float: DtX,Float: DtY,Float:DtZ;
	GetPlayerPos(playerid,CtX,CtY,CtZ);
	DtX = (CtX -X); DtY = (CtY -Y); DtZ = (CtZ -Z);

	if(DtX< PowXYZ+PowX && DtX> -PowXYZ+PowX && DtY < PowXYZ+PowY  && DtY > -PowXYZ+PowY && DtZ < PowXYZ+PowZ && DtZ > -PowXYZ+PowZ)
		return true;

	return false;
}

/*----------------------------------------------------------------------------*/

public OnPlayerConnect(playerid)
{
    AddCargoObjects(playerid);
	ObjectsAdded[playerid] = true;
    return true;
}

/*----------------------------------------------------------------------------*/

public OnPlayerDisconnect(playerid,reason)
{
	if(InCargoBob[playerid] != 0)
    InCargoBob[playerid] = 0;
    ObjectsAdded[playerid] = false;
	return true;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(InCargoBob[playerid] != 0)
	InCargoBob[playerid] = 0;
	SetPlayerVirtualWorld(playerid,0);
	return true;
}

/*----------------------------------------------------------------------------*/

public OnVehicleDeath(vehicleid, killerid)
{
	if(GetVehicleModel(vehicleid) == 548)
	{
		for(new i = 0;i < MAX_PLAYERS;i++)
  		{
  			if(InCargoBob[i] == vehicleid)
  			{
				new Float:X,Float:Y,Float:Z;
				GetPlayerPos(i,X,Y,Z);
				CreateExplosion(X,Y,Z,3,10);
				SetPlayerHealth(i,0.0);
				InCargoBob[i] = 0;
			}
  		}
	}
	return true;
}

/*----------------------------------------------------------------------------*/

public OnPlayerCommandText(playerid, cmdtext[])
{
	dcmd(cargo,5,cmdtext);
	dcmd(cargoout,8,cmdtext);
	return false;
}

dcmd_cargo(playerid,params[])
{
  	for(new i = 0;i < MAX_VEHICLES;i++)
  	{
  	  	if(GetVehicleModel(i) == 548)
		{
  	      	new Float:vX,Float:vY,Float:vZ;
  	      	GetVehiclePos(i,vX,vY,vZ);
  	      	GetXYOfVehicle(i,vX,vY,-5.5);
  	      	vZ -= 1.932519;
  	  	    if (GetPlayerPosPower(playerid,vX,vY,vZ,0,0,0,2.5))
		    {
				if (ObjectsAdded[playerid] == false)
				{
					AddCargoObjects(playerid);
					ObjectsAdded[playerid] = true;
				}
                InCargoBob[playerid] = i;
  	  	        SendClientMessage(playerid,COLOR_NEUTRALGREEN,ENTERED_CARGO);
				GetPlayerTime(playerid,CargoHours[playerid],CargoMinutes[playerid]);
				SetPlayerTime(playerid,0,0);
				SetPlayerPos(playerid,222.251160, 82.851181, 10639.714844);
				SetPlayerVirtualWorld(playerid,i);
                return true;
  	  	    }
  	  	}
  	}
  	SendClientMessage(playerid,COLOR_NEUTRALGREEN,TO_FAROF_CARGO);
    #pragma unused params
	return true;
}

dcmd_cargoout(playerid,params[])
{
	if(InCargoBob[playerid] == 0)
		return SendClientMessage(playerid,COLOR_NEUTRALGREEN,NOT_IN_CARGO);
    new Float:vX,Float:vY,Float:vZ;
    GetVehiclePos(InCargoBob[playerid],vX,vY,vZ);
    vZ -= 1.932519;
    new Float:a = GetXYOfVehicle(InCargoBob[playerid],vX,vY,-5.5);
    SetPlayerInterior(playerid,0);
    SetPlayerPos(playerid,vX,vY,vZ);
    SetPlayerFacingAngle(playerid,a-180);
    SetPlayerVirtualWorld(playerid,0);
    SetPlayerTime(playerid,CargoHours[playerid],CargoMinutes[playerid]);
    InCargoBob[playerid] = 0;
    #pragma unused params
	return true;
}

/*----------------------------------------------------------------------------*/
