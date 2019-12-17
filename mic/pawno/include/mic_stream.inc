
// Pickup For Fun [ mic_stream ]

/*
native CreateObject(model,Float:x,Float:y,Float:z,Float:rx,Float:ry,Flat:rz);
native DestroyObject(Objectid);
native SetObjectStreaming(Distance);
*/
new ObjectID;
new ObjectM[MAX_OBJECTS];
new ObjectO[MAX_OBJECTS];
new Float:ObjectX[MAX_OBJECTS];
new Float:ObjectY[MAX_OBJECTS];
new Float:ObjectZ[MAX_OBJECTS];
new Float:ObjectrX[MAX_OBJECTS];
new Float:ObjectrY[MAX_OBJECTS];
new Float:ObjectrZ[MAX_OBJECTS];
new OBJECT_STREAM = 999999;

stock SetObjectStreaming(Distance)
{
OBJECT_STREAM = Distance;
}

Float:ObjectToPlayerDistance(Objectid,playerid){
	new Float:x1,Float:y1,Float:z1;
	new Float:x2,Float:y2,Float:z2;
	GetPlayerPos(playerid,x1,y1,z1);
	x2 = ObjectX[Objectid];
	y2 = ObjectY[Objectid];
	z2 = ObjectZ[Objectid];

	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

GetClosestPlayerToObject(Objectid){
	new Float:closest = 999999.999,Float:handle;
	new closestid = -1;
	new i;
	for(i=0;i<=MAX_PLAYERS;i++){
	handle = ObjectToPlayerDistance(Objectid,i);	
	if((handle < closest) && IsPlayerConnected(i)){
	closest = handle;
	closestid = i;
	}}
	return closestid;
}
public MakeObject(model,Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz)
{
	ObjectID++;
	ObjectX[ObjectID] = x;
	ObjectY[ObjectID] = y;
	ObjectZ[ObjectID] = z;
	ObjectrX[ObjectID] = rx;
	ObjectrY[ObjectID] = ry;
	ObjectrZ[ObjectID] = rz;
	ObjectM[ObjectID] = model;
	ObjectO[ObjectID] = CreateObject(model,x,y,z,rx,ry,rz);
	IsObjectVisible[ObjectID] = 1;
	return ObjectID;
}

public KillObject(objectid)
{
	DestroyObject(ObjectO[objectid]);
	ObjectX[objectid] = 0;
	ObjectY[objectid] = 0;
	ObjectZ[objectid] = 0;
	ObjectM[objectid] = 0;
}

IsPlayerCloserToObject(playerid,Objectid)
{
	new ret = IsPlayerInSphere2(playerid,ObjectX[Objectid],ObjectY[Objectid],ObjectZ[Objectid],OBJECT_STREAM);
	if (!IsPlayerConnected(playerid)) ret = -1;
	return ret;
}

IsPlayerInSphere2(playerid,Float:x,Float:y,Float:z,radius)
{
	new Float:x1,Float:y1,Float:z1;
	new Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	tmpdis = floatsqroot(floatpower(floatabs(floatsub(x,x1)),2)+floatpower(floatabs(floatsub(y,y1)),2)+floatpower(floatabs(floatsub(z,z1)),2));
	if(floatround(tmpdis) < radius){
	return 1;
	}
	return 0;
}

public ObjectsHandler()
{
	new i,j;
	for(i = 0;i <= ObjectID;i++)
	{
		j = GetClosestPlayerToObject(i);
		{
			if((IsPlayerCloserToObject(j,i)==1) && (IsObjectVisible[i] == 0))
			{				
			ObjectO[i] = CreateObject(ObjectM[i],ObjectX[i],ObjectY[i],ObjectZ[i],ObjectrX[i],ObjectrY[i],ObjectrZ[i]);
			IsObjectVisible[i] = 1;
			}
			if((IsPlayerCloserToObject(j,i)==0) && (IsObjectVisible[i] == 1))
			{
			DestroyObject(ObjectO[i]);
			IsObjectVisible[i] = 0;
			}
		}
	}
}


