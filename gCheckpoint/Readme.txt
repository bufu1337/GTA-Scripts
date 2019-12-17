gCheckpoint 1.0 Copyright (c) Jay/Grove 2008

To get it working:

Put the gCheckpoint.inc file in your pawno/includes directory.

Open your gamemode, and underneath the rest of your server includes, add: #include <gCheckpoint>

under your OnPlayerEnterCheckpoint callback add:

for(new i =0; i<MAX_CHECKPOINTS; i++)
{
    if(gCheckpoint[playerid][i] == 1)
    {
        OnPlayerCheckpoint(playerid,i);
    }
}

Under your OnPlayerLeaveCheckpoint callback add:

for(new i =0; i<MAX_CHECKPOINTS; i++)
{
    if(gCheckpoint[playerid][i] == 1)
    {
        OnPlayerExitCheckpoint(playerid,i);
    }
}

Under OnPlayerConnect add:

for(new i=0; i<MAX_CHECKPOINTS; i++) //Incase the player has disconnected inside a checkpoint,
{
    gCheckpoint[playerid][i] = false; //we need to disable it for the player.
} 

At the bottom of your gamemode, add:

OnPlayerCheckpoint(playerid,checkpointid)
{
    return true;
}

OnPlayerExitCheckpoint(playerid,checkpointid)
{
    return true;
}



Have fun!