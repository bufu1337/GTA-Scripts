//Attacking NPCs
//Created by:
//Tannz0rz of Infinite Gaming
//http://www.infinite-gaming.com/forum

#if defined _attacking_npc_included
  #endinput
#endif
#define _attacking_npc_included

#include <a_samp>
#include <a_angles>

//Create an attacking npc at a specific location.
//Parameters-
// npcid, the NPC you wish to make an attacking NPC
// Float:x, the NPC's X position
// Float:y, the NPC's Y position
// Float:z, the NPC's Z position
// Float:AttackRadius (default: 60 units), the npc's firing distance
// Float:Accuracy (default: 10 degrees), the npc's firing accuracy
stock CreateAttackingNPC(npcname[], Float:x, Float:y, Float:z, Float:AttackRadius=60.0, Float:Accuracy=10.0)
{
	new npcid=GetPlayerID(npcname);
	if(npcid != INVALID_PLAYER_ID && IsPlayerConnected(npcid))
	{
		if(IsPlayerNPC(npcid))
		{
			SetPlayerPos(npcid, x, y, z);
			SetTimerEx("SetFacing", 100, 1, "iff", npcid, AttackRadius, Accuracy);
			return 1;
		}
	}
	return 0;
}

forward SetFacing(npcid, Float:AttackRadius, Float:accuracy);
public SetFacing(npcid, Float:AttackRadius, Float:accuracy)
{
	new Float:npcx, Float:npcy, Float:npcz;
	ApplyAnimation(npcid,"COLT45","2guns_crouchfire", 4.1,1,1,1,1,1);
	GetPlayerPos(npcid, npcx, npcy, npcz);

	new i = GetClosestPlayer(npcid);
	if(IsPlayerInRangeOfPoint(i, AttackRadius, npcx, npcy, npcz))
	{
		SetPlayerToFacePlayer(npcid, i);
		if(IsPlayerFacingPlayer(npcid, i, accuracy))
		{
			new Float:health;
			GetPlayerHealth(i, health);
			health -= 1.0;
			if(health <= 0.0) health = 0.0;
			SetPlayerHealth(i, health);
			PlayerPlaySound(i, 1131, npcx, npcy, npcz);
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