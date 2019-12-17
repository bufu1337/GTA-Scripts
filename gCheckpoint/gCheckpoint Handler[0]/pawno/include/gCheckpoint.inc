/*
Easy checkoints by Grove/Jay - with an optional id parameter in checkpoints!
Report any bugs @ the topic. I have not tested this to my liking, so sorry if its bugged :p
Copyright (c) Jay/Grove 2008
*/

#define MAX_CHECKPOINTS 20 //Checkpoint handler: Increase when adding more checkpoints!
new gCheckpoint[MAX_PLAYERS][MAX_CHECKPOINTS]; //is the checkpoint enabled for the player?
new gCheckid; // - the actual checkpoint id!
new gIsPlayerInsideCheckpoint[MAX_PLAYERS][MAX_CHECKPOINTS]; //if the player inside the checkpoint?
//Was going to make an enum, but only three variables, meh




//The actual function to make a checkpoint, and show it for a player!
stock CreatePlayerCheckpoint(playerid,Float:cx,Float:cy,Float:cz,Float:csize)
{
	gCheckid++;
	if(gCheckid > MAX_CHECKPOINTS) return printf("ERROR MAKING CHECKPOINT %d",gcheckid);
	for(new i=0; i<MAX_CHECKPOINTS; i++) //Ok, first, since SA:MP only supports 1 CP at a time,
	{
		gCheckpoint[playerid][i] = false; //we need to disable every other checkpoint for the player.
	}

	gCheckpoint[playerid][gCheckid] = true; //Now, set the varible for the current checkpoint to true,
	SetPlayerCheckpoint(playerid,cx,cy,cz,csize); //Now, show the checkpoint for the player.
	return gCheckid; //And return the id, so we can assign variables to checkpoints for ease!
}

stock RemovePlayerCheckpoint(playerid) //Disables the players checkpoint of the map.
{
	for(new i =0; i<MAX_CHECKPOINTS; i++)
	{
	    gCheckpoint[playerid][i] = false; //disable all the checkpoint variables for the player,
		gIsPlayerInsideCheckpoint[playerid][i] = false;
	}
	DisablePlayerCheckpoint(playerid); //and finally remove the checkpoint.
	return true;
}

stock IsPlayerInCp(playerid,checkpointid)
{
	if(gIsPlayerInsideCheckpoint[playerid][checkpointid]) return true; //if the variable for the player being in a checkpoint is true, return 1,
	return -1; //otherwise return -1!
}



