//--------------------------------ESC Time Counter FilterScript by [_FFG_]BuLLeT----------------------------------------------------
#include <a_samp>
#define MAX_ESC_TIME 60 //1 minute
#define COLOR_WHITE 0xFFFFFFAA
new UpdateCount[MAX_PLAYERS], OldUpdateCount[MAX_PLAYERS], Spawned[MAX_PLAYERS],ESCWarns[MAX_PLAYERS];
new PlayerUpTimer[MAX_PLAYERS],IsPaused[MAX_PLAYERS],ESCSeconds[MAX_PLAYERS],ESCMinutes[MAX_PLAYERS];
new ESCTime[MAX_PLAYERS];
new Text3D:ESCLabel[MAX_PLAYERS];
forward UpdatePlayer(playerid);
public OnFilterScriptInit()
{
	print("\n|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
	print("      ESC Time Counter [FS] by [_FFG_]BuLLeT");
	print("|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
    ESCTime[playerid] = 0;
    UpdateCount[playerid] = 0;
    OldUpdateCount[playerid] = 0;
    ESCSeconds[playerid] = 0;
	ESCMinutes[playerid] = 0;
	IsPaused[playerid] = 0;
	ESCWarns[playerid] = 0;
    PlayerUpTimer[playerid] = SetTimerEx("UpdatePlayer",1000,1,"d",playerid);
    Spawned[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    Spawned[playerid] = 0;
    ESCTime[playerid] = 0;
    UpdateCount[playerid] = 0;
    OldUpdateCount[playerid] = 0;
    ESCWarns[playerid] = 0;
    KillTimer(PlayerUpTimer[playerid]);
    if(IsPaused[playerid] == 1)
	{
	    IsPaused[playerid] = 0;
	    Delete3DTextLabel(ESCLabel[playerid]);
	    ESCSeconds[playerid] = 0;
		ESCMinutes[playerid] = 0;
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
    Spawned[playerid] = 1;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    Spawned[playerid] = 0;
	return 1;
}

public OnPlayerUpdate(playerid)
{
    UpdateCount[playerid] ++;
	if(UpdateCount[playerid] >= 999999)
	{
	    UpdateCount[playerid] = 0;
	}
	if(IsPaused[playerid] == 1)
	{
		IsPaused[playerid] = 0;
	    Delete3DTextLabel(ESCLabel[playerid]);
	    ESCSeconds[playerid] = 0;
		ESCMinutes[playerid] = 0;
		ESCTime[playerid] = 0;
	}
	return 1;
}

public UpdatePlayer(playerid)
{
	if(IsPlayerConnected(playerid) && Spawned[playerid] == 1)
	{
	    if(IsPaused[playerid] == 0)
		{
		    if(UpdateCount[playerid] == OldUpdateCount[playerid])
		    {
		        ESCWarns[playerid]++;
		        switch (ESCWarns[playerid])
		        {
		            case 10:
		            {
						IsPaused[playerid] = 1;
						ESCSeconds[playerid] = 10;
						ESCLabel[playerid] = Create3DTextLabel("ESC    0:10",0xFF0000AA,0.0,0.0,0.6,30,0,0);
						Attach3DTextLabelToPlayer(ESCLabel[playerid],playerid,0.0,0.0,0.0);
		            }
		        }
		    }
		    else
		    {
		        ESCTime[playerid] = 0;
		    	IsPaused[playerid] = 0;
		        ESCWarns[playerid] = 0;
		        OldUpdateCount[playerid] = UpdateCount[playerid];
		    }
		}
		else
		{
		    ESCSeconds[playerid]++;
		    if(ESCSeconds[playerid] >= 60)
		    {
			    ESCSeconds[playerid] = 0;
			    ESCMinutes[playerid] ++;
		    }
		    new str[30];
		    format(str,sizeof(str),"ESC    %d:%02d",ESCMinutes[playerid],ESCSeconds[playerid]);
			Update3DTextLabelText(ESCLabel[playerid],COLOR_WHITE,str);
			ESCTime[playerid] ++;
			if(ESCTime[playerid] >= MAX_ESC_TIME)
			{
			    Kick(playerid);//kick for ESC
			}
		}
	}
	return 1;
}