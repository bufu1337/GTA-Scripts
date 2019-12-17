
// Pickup For Fun [ mic_piks ]

/*
native CreatePik(model,Float:x,Float:y,Float:z);
native DestroyPik(pikid);
native GetClosestPlayerToPik(pikid)
*/

Float:PikToPlayerDistance(pikid,playerid){
	new Float:x1,Float:y1,Float:z1;
	new Float:x2,Float:y2,Float:z2;
	GetPlayerPos(playerid,x1,y1,z1);
	x2 = PikX[pikid];
	y2 = PikY[pikid];
	z2 = PikZ[pikid];
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

GetClosestPlayerToPik(pikid){
	new Float:closest = 999999.999,Float:handle;
	new closestid = -1;
	new i;
	for(i=0;i<=MAX_PLAYERS;i++){
	handle = PikToPlayerDistance(pikid,i);	
	if((handle < closest) && IsPlayerConnected(i)){
	closest = handle;
	closestid = i;
	}}
	return closestid;
}
public CreatePik(model,Float:x,Float:y,Float:z)
{
	PikID++;
	PikX[PikID] = x;
	PikY[PikID] = y;
	PikZ[PikID] = z;
	PikM[PikID] = model;
	PikO[PikID] = CreateObject(model,x,y,z,0,0,0);
	IsPikVisible[PikID] = 1;
	return PikID;
}

public DestroyPik(pikid)
{
	DestroyObject(PikO[pikid]);
	PikX[PikID] = 0;
	PikY[PikID] = 0;
	PikZ[PikID] = 0;
	PikM[PikID] = 0;
}

IsPlayerCloserToPik(playerid,pikid)
{
	new ret = IsPlayerInSphere1(playerid,PikX[pikid],PikY[pikid],PikZ[pikid],2);
	if (!IsPlayerConnected(playerid)) ret = -1;
	return ret;
}

IsPlayerInSphere1(playerid,Float:x,Float:y,Float:z,radius)
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

public PiksHandler()
{
	new i,j;
	for(i = 0;i <= PikID;i++)
	{
		j = GetClosestPlayerToPik(i);
		{
			if((IsPlayerCloserToPik(j,i)==1) && (IsPikVisible[i] == 1))
			{				
			DestroyObject(PikO[i]);
			IsPikVisible[i] = 0;
			}
			if((IsPlayerCloserToPik(j,i)==0) && (IsPikVisible[i] == 0))
			{
			PikO[i] = CreateObject(PikM[i],PikX[i],PikY[i],PikZ[i],0,0,0);
			IsPikVisible[i] = 1;
			}
		}
	}
}


