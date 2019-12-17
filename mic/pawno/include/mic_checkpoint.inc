// Multiple Checkpoint System [ mic_checkpoint ]

/*
native CreateCheckpoint(Float:x,Float:y,Float:z,Float:size);
native DestroyCheckpoint(cpid);
native ShowCheckpoint(playerid,cpid);
native HideCheckpoint(playerid,cpid);
native ShowCheckpointForAll(cpid);
native HideCheckpointForAll(cpid);
*/

public CreateCheckpoint(Float:x,Float:y,Float:z,Float:size)
{
	checkpointid++;
	CheckpointX[checkpointid] = x;
	CheckpointY[checkpointid] = y;
	CheckpointZ[checkpointid] = z;
	CheckpointS[checkpointid] = size;
	return checkpointid;
}

public DestroyCheckpoint(cpid)
{
	CheckpointX[cpid] = 0.0;
	CheckpointY[cpid] = 0.0;
	CheckpointZ[cpid] = 0.0;
	CheckpointS[cpid] = 0.0;

}

public ShowCheckpoint(playerid,cpid)
{
	MapIconID++;
	IsCheckpointVisible[cpid][playerid] = 1;
	//SetPlayerMapIcon( playerid, MapIconID, CheckpointX[cpid], CheckpointY[cpid],CheckpointZ[cpid], 1, 0xAA3333AA );
}

public HideCheckpoint(playerid,cpid)
{
	IsCheckpointVisible[cpid][playerid] = 0;
}

public ShowCheckpointForAll(cpid)
{
 	new i;
	for(i=0;i<=MAX_PLAYERS;i++)
	{
	ShowCheckpoint(i,cpid);
	}
}

public HideCheckpointForAll(cpid)
{
 	new i;
	for(i=0;i<=MAX_PLAYERS;i++)
	{
	IsCheckpointVisible[i][cpid] = 0;
	}
}

Float:CheckpointToPlayerDistance(cpid,playerid)
{
	new Float:x1,Float:y1,Float:z1;
	new Float:x2,Float:y2,Float:z2;
	GetPlayerPos(playerid,x1,y1,z1);
	x2 = CheckpointX[cpid];
	y2 = CheckpointY[cpid];
	z2 = CheckpointZ[cpid];
	//printf("cpid: %d playerid: %d dis: %d",cpid,playerid,floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2)));
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

public GetPlayerClosestCheckpoint(playerid)
{
	new i,j = -1,Float:Handle,Float:Closest = 999999.999;
	for(i=0;i<=checkpointid;i++)
	{
	if (IsCheckpointVisible[i][playerid] == 1){
	Handle = CheckpointToPlayerDistance(i,playerid);
	if(Handle <= Closest)
	{
	Closest = Handle;
	j = i;
	
	}
	}
	}
	return j;
}


public CheckpointHandler()
{
	new i;
	new checkpoint;
	for(i=0;i<=MAX_PLAYERS;i++)
	{
	//printf("i = %d",i);
	checkpoint = GetPlayerClosestCheckpoint(i);
	//printf("checkpoint = %d",checkpoint);
	if(CheckpointS[checkpoint] != 0)
	{
	SetPlayerCheckpoint(i,CheckpointX[checkpoint],CheckpointY[checkpoint],CheckpointZ[checkpoint],CheckpointS[checkpoint]);
	}
	}
}
