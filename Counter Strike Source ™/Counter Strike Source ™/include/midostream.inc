//========================================================//
//=============[MidoStream - Object Streamer]=============//
//=====================[by MidoBan]=======================//

/*
	functions:
		CreateStreamObject(modelid,Float:xpos,Float:ypos,Float:zpos,Float:xrot,Float:yrot,Float:zrot,Float:viewdist) - Create a streamed object
		DestroyStreamObject(id) - Destroy a streamed object
		GetStreamObjectPos(id,&Float:xpos,&Float:ypos,&Float:zpos) - Get the position of a streamed object
		GetStreamObjectRot(id,&Float:xrot,&Float:yrot,&Float:zrot) - Get the rotation of a streamed object
		SetStreamObjectPos(id,Float:xpos,Float:ypos,Float:zpos) - Set the position of a streamed object
		SetStreamObjectRot(id,Float:xrot,Float:yrot,Float:zrot) - Set the rotation of a streamed object
                AttachStreamObjectToPlayer(id,playerid,Float:xoff,Float:yoff,Float:zoff,Float:xrot,Float:yrot,Float:zrot) - Attach a streamed object to a player
                MoveStreamObject(id2,Float:movx,Float:movy,Float:movz,Float:speed) - Move a streamed object
                MidoStreamDisconnect(playerid) - Goes under OnPlayerDisconnect
*/

#include <a_samp>

//----------------------------------------------------------
stock CreateStreamObject(modelid,Float:xpos,Float:ypos,Float:zpos,Float:xrot,Float:yrot,Float:zrot,Float:viewdist)
{
	return CallRemoteFunction("Core_CreateStreamObject","ifffffff",modelid,xpos,ypos,zpos,xrot,yrot,zrot,viewdist);
}

//----------------------------------------------------------
stock DestroyStreamObject(id)
{
    CallRemoteFunction("Core_DestroyStreamObject","i",id);
}

//----------------------------------------------------------
stock GetStreamObjectPos(id,&Float:xpos,&Float:ypos,&Float:zpos)
{
    xpos = Float:CallRemoteFunction("Core_GetXPos","i",id);
    ypos = Float:CallRemoteFunction("Core_GetYPos","i",id);
    zpos = Float:CallRemoteFunction("Core_GetZPos","i",id);
}

//----------------------------------------------------------
stock GetStreamObjectRot(id,&Float:xrot,&Float:yrot,&Float:zrot)
{
    xrot = Float:CallRemoteFunction("Core_GetXRot","i",id);
    yrot = Float:CallRemoteFunction("Core_GetYRot","i",id);
    zrot = Float:CallRemoteFunction("Core_GetZRot","i",id);
}

//----------------------------------------------------------
stock SetStreamObjectPos(id,Float:xpos,Float:ypos,Float:zpos)
{
    CallRemoteFunction("Core_SetStreamObjectPos","ifff",id,xpos,ypos,zpos);
}

//----------------------------------------------------------
stock SetStreamObjectRot(id,Float:xrot,Float:yrot,Float:zrot)
{
    CallRemoteFunction("Core_SetStreamObjectRot","ifff",id,xrot,yrot,zrot);
}

//----------------------------------------------------------
stock AttachStreamObjectToPlayer(id,playerid,Float:xoff,Float:yoff,Float:zoff,Float:xrot,Float:yrot,Float:zrot)
{
    CallRemoteFunction("Core_AttachStreamObjectToPlayer","iiffffff",id,playerid,xoff,yoff,zoff,xrot,yrot,zrot);
}

//----------------------------------------------------------
stock MoveStreamObject(id,Float:movx,Float:movy,Float:movz,Float:speed)
{
    CallRemoteFunction("Core_MoveStreamObject","iffff",id,movx,movy,movz,speed);
}


//----------------------------------------------------------
stock MidoStreamDisconnect(playerid)
{
    CallRemoteFunction("Core_MidoStreamDisconnect","i",playerid);
}