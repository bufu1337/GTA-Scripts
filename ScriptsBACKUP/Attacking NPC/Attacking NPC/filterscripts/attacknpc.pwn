#include <a_samp>
#include <a_angles>

#define FILTERSCRIPT

new Float:NPCHealth;
new NPCShotTimer[MAX_PLAYERS];
new bool:IsNPCDead;

public OnFilterScriptInit()
{
    ConnectNPC("Guard_NPC","1");
    SetTimer("SetFacing", 100, 1);
    NPCHealth = 200.0;
    IsNPCDead = false;
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp(cmdtext, "/getnpc", true)==0)
	{
	    new Float:x, Float:y, Float:z;
	    GetPlayerPos(playerid, x, y, z);
	    SetPlayerPos(0, x, y, z);
	    IsNPCDead = false;
	    NPCHealth = 200.0;
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys & KEY_FIRE) == (KEY_FIRE))
	{
	    NPCShotTimer[playerid] = SetTimerEx("ShootNPC", 500, 1, "i", playerid);
	}
	else KillTimer(NPCShotTimer[playerid]);
	
	return 1;
}

forward ShootNPC(playerid);
public ShootNPC(playerid)
{
	new Float:plyx, Float:plyy, Float:plyz;
	new npcid = GetPlayerID("Guard_NPC");
	
	GetPlayerPos(playerid, plyx, plyy, plyz);
	if(IsPlayerInRangeOfPoint(npcid, 30.0, plyx, plyy, plyz))
	{
	    if(IsPlayerFacingPlayer(playerid, npcid, 10.0))
	    {
	        NPCHealth -= 1.0;
	        if(NPCHealth <= 0.0)
	        {
	            ClearAnimations(npcid);
		    	ApplyAnimation(npcid, "KNIFE", "KILL_Knife_Ped_Die", 4.1,0,1,1,1,1);
		    	SetTimer("NPCIsDead", 1000, 0);
		    	IsNPCDead = true;
	        }
	    }
	}
	return 1;
}

forward NPCIsDead();
public NPCIsDead()
{
	new npcid = GetPlayerID("Guard_NPC");
	SetPlayerPos(npcid, 0.0, 0.0, 0.0);
	return 1;
}

forward SetFacing();
public SetFacing()
{
	new Float:npcx, Float:npcy, Float:npcz;
	new npcid = GetPlayerID("Guard_NPC");
	if(!IsNPCDead)
	{
	    ApplyAnimation(0,"COLT45","2guns_crouchfire", 4.1,1,1,1,1,1);
		GetPlayerPos(npcid, npcx, npcy, npcz);

		new i = GetClosestPlayer(npcid);
		if(IsPlayerInRangeOfPoint(i, 30.0, npcx, npcy, npcz))
		{
			SetPlayerToFacePlayer(npcid, i);
			if(IsPlayerFacingPlayer(npcid, i, 1.0))
			{
			    new Float:health;
			    GetPlayerHealth(i, health);
			    health -= 1.0;
			    if(health <= 0.0) health = 0.0;
			    SetPlayerHealth(i, health);
				PlayerPlaySound(i, 1131, npcx, npcy, npcz);
			}
		}
	}
	return 1;
}

stock GetPlayerID(const playername[], partofname=0)
{
	new i;
	new playername1[64];
	for (i=0;i<MAX_PLAYERS;i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i,playername1,sizeof(playername1));
			if (strcmp(playername1,playername,true)==0)
			{
				return i;
			}
		}
	}
	new correctsigns_userid=-1;
	new tmpuname[128];
	new hasmultiple=-1;
	if(partofname)
	{
		for (i=0;i<MAX_PLAYERS;i++)
		{
			if (IsPlayerConnected(i))
			{
				GetPlayerName(i,tmpuname,sizeof(tmpuname));

				if(!strfind(tmpuname,playername1[partofname],true, 0))
				{
					hasmultiple++;
					correctsigns_userid=i;
				}
				if (hasmultiple>0)
				{
					return -2;
				}
			}
		}
	}
	return correctsigns_userid;
}

forward GetClosestPlayer(playerid);
public GetClosestPlayer(playerid)
{

	new Float:dis,Float:dis2,player;
	player = -1;
	dis = 99999.99;

	for( new i = 0; i < MAX_PLAYERS; i++ )
	{

		if(IsPlayerConnected(i))
		{

			if(i != playerid)
			{

				dis2 = GetDistanceBetweenPlayers(playerid, i);

				if(dis2 < dis && dis2 != 10000.0)
				{

					dis = dis2;
					player = i;

				}

			}

		}

	}
	return player;

}

forward Float:GetDistanceBetweenPlayers(playerid, targetid);
public Float:GetDistanceBetweenPlayers(playerid, targetid)
{

	new
		Float:x1,
		Float:y1,
		Float:z1,
		Float:x2,
		Float:y2,
		Float:z2;

    if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)) return 10000.0;

	GetPlayerPos(playerid,x1,y1,z1);
	GetPlayerPos(targetid,x2,y2,z2);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));

}
