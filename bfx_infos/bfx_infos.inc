/*
 INFO CREATOR .inc By BlackFoX
*/
#include <a_samp>
#if defined _bfx_infos_included
	#endinput
#endif
#define _bfx_infos_included
#define MAX_INFOS 500
#define MAX_AINFOS 500
#pragma library bfx_infos
new nID;
new aID;
/*
native bCreateInfo(Modelr,Float:x, Float:y, Float:z, const Text[256]);
native bAutoTeleport(Modelp,Float:x, Float:y, Float:z, const Stringz[256], Float:ax, Float:ay, Float:az, v_i_d, interior)
native bOnPlayerPickup(pickupid,playerid);
native bOnPlayerEnterAIcon(pickupid,playerid);
native IsPlayerNearIcon(playerid,iID);
native bDestroyATeleport(t_id);
native bDestroyIcon(icon_id);
native bSetInfoPos(b_id,Float:x,Float:y,Float:z);
native bSetAutoTeleport(c_id,Float:x,Float:y,Float:z);
*/
#pragma tabsize 4
forward PTP (Float:radi, playerid, Float:x, Float:y, Float:z);
enum PickupDetails
{
	p_text[256],
	p_id,
	Float:p_x,
	Float:p_y,
	Float:p_z,
	Modelp2,
}
new PickupInfos[MAX_INFOS][PickupDetails];

enum AutoPicks
{
	ptext[256],
	pid,
	Float:px,
	Float:py,
	Float:pz,
	Float:t_x,
	Float:t_y,
	Float:t_z,
	virtualworldx,
	interiorx,
	Modelr2,
}
new AutoPickups[MAX_AINFOS][AutoPicks];
stock bCreateInfo(Modelp, Float:x, Float:y, Float:z, const Text[256])
{
nID++;
PickupInfos[nID][p_id] = CreatePickup(Modelp, 23, x, y, z);
PickupInfos[nID][Modelp2] = Modelp;
PickupInfos[nID][p_x] = x;
PickupInfos[nID][p_y] = y;
PickupInfos[nID][p_z] = z;
strmid(PickupInfos[nID][p_text],Text,0,256,256);
return nID;
}
// AUTO TELEPORTS
stock bAutoTeleport(Modelr, Float:x, Float:y, Float:z, const Stringz[256], Float:ax, Float:ay, Float:az, v_i_d, interior)
{
aID++;
AutoPickups[aID][pid] = CreatePickup(Modelr, 23, x, y, z);
AutoPickups[aID][Modelr2] = Modelr;
AutoPickups[aID][px] = x;
AutoPickups[aID][py] = y;
AutoPickups[aID][pz] = z;
AutoPickups[aID][t_x] = ax;
AutoPickups[aID][t_y] = ay;
AutoPickups[aID][t_z] = az;
AutoPickups[aID][virtualworldx] = v_i_d;
AutoPickups[aID][interiorx] = interior;
strmid(AutoPickups[aID][ptext],Stringz,0,256,256);
return aID;
}
//
stock bOnPlayerPickup(pickupid,playerid)
{
for(new i = 0; i <= nID; i++)
{
if(IsPlayerConnected(playerid))
{
if(pickupid == PickupInfos[i][p_id])
{
new formato[256];
format(formato,sizeof(formato),"~w~%s",PickupInfos[i][p_text]);
GameTextForPlayer(playerid,formato,2000,3);
}
}
}
return 0;
}
stock bOnPlayerEnterAIcon(pickupid,playerid) // Bei OnPlayerPickup Hin
{
for(new i = 0; i <= aID; i++)
{
if(IsPlayerConnected(playerid))
{
if(pickupid == AutoPickups[i][pid])
{
new formato[256];
format(formato,sizeof(formato),"~w~%s",AutoPickups[i][ptext]);
GameTextForPlayer(playerid,formato,2000,3);
if(AutoPickups[i][virtualworldx]!=-1) { SetPlayerVirtualWorld(playerid,AutoPickups[i][virtualworldx]); }
if(AutoPickups[i][interiorx]!=-1) { SetPlayerInterior(playerid,AutoPickups[i][interiorx]); }
SetPlayerPos(playerid,AutoPickups[i][t_x] + (2.0),AutoPickups[i][t_y],AutoPickups[i][t_z]);
}
}
}
return 0;
}
stock bSetInfoPos(b_id,Float:x,Float:y,Float:z)
{
DestroyPickup(PickupInfos[b_id][p_id]);
PickupInfos[b_id][p_x] = x;
PickupInfos[b_id][p_y] = y;
PickupInfos[b_id][p_z] = z;
PickupInfos[b_id][p_id] = CreatePickup(PickupInfos[icon_id][Modelp2],PickupInfos[icon_id][p_x],PickupInfos[icon_id][p_y],PickupInfos[icon_id][p_z]);
}
stock bSetAutoTeleport(c_id,Float:x,Float:y,Float:z)
{
DestroyPickup(PickupInfos[c_id][pid]);
AutoPickups[c_id][px] = x;
AutoPickups[c_id][py] = y;
AutoPickups[c_id][pz] = z;
PickupInfos[c_id][pid] = CreatePickup(AutoPickups[c_id][Modelr2],AutoPickups[c_id][px],AutoPickups[c_id][py],AutoPickups[c_id][pz]);
}
stock bDestroyIcon(icon_id)
{
DestroyPickup(PickupInfos[icon_id][p_id]);
}
stock bDestroyATeleport(t_id)
{
DestroyPickup(AutoPickups[t_id][pid]);
}
stock IsPlayerNearIcon(playerid,iID)
{
if(PTP(1.0,playerid,PickupInfos[iID][p_x],PickupInfos[iID][p_y],PickupInfos[iID][p_z])) { return 1; } else { return 0; }
}
public PTP(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		return 1;
	}
	return 0;
}
