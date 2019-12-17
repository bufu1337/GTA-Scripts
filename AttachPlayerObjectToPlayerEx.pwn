forward AttachPlayerObjectToPlayerEx(objectplayer, objectid, attachplayer, Float:OffsetX, Float:OffsetY, Float:OffsetZ, Float:rX, Float:rY, Float:rZ);
public AttachPlayerObjectToPlayerEx(objectplayer, objectid, attachplayer, Float:OffsetX, Float:OffsetY, Float:OffsetZ, Float:rX, Float:rY, Float:rZ)
{
SetTimerEx("MoveAttachPlayerObject",30,true,"iiiffffff",objectplayer,objectid,attachplayer,OffsetX,OffsetY,OffsetZ,rX,rY,rZ);
return 1;
}

forward MoveAttachPlayerObject(objectplayer, objectid, attachplayer, Float:OffsetX, Float:OffsetY, Float:OffsetZ, Float:rX, Float:rY, Float:rZ);
public MoveAttachPlayerObject(objectplayer, objectid, attachplayer, Float:OffsetX, Float:OffsetY, Float:OffsetZ, Float:rX, Float:rY, Float:rZ)
{
new Float:x,Float:y,Float:z;
GetPlayerPos(attachplayer,x,y,z);
MovePlayerObject(objectplayer, objectid, x + OffsetX, y + OffsetY, z + OffsetZ, 10);
SetPlayerObjectRot(objectplayer, objectid, rX, rY, rZ);
return 1;
}