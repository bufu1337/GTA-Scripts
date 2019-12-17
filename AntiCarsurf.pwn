//AntiCarSurf by Randy_Saputra a.k.a Sratter
#define FILTERSCRIPT

#include <a_samp>
#define MAX_SPEED_ANTICS 45
new PlayerSurfing[MAX_PLAYERS];

public OnFilterScriptInit()
{
	SetTimer("AntiCarSurf", 3000, 1);
	return 1;
}
stock IsABoat(carid)
{
	new Boats[] = { 472, 473, 493, 484, 430, 454, 453, 452, 446 };
	for(new i = 0; i < sizeof(Boats); i++)
	{
		if(GetVehicleModel(carid) == Boats[i]) return 1;
	}
	return 0;
}
forward AntiCarSurf();
public AntiCarSurf()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i)) //Maybe you can add a log in checker
		{
			if(GetPlayerSurfingVehicleID(i) != INVALID_VEHICLE_ID) //You can also add something like if player is not admin duty
			{
				new Float:Vx,Float:Vy,Float:Vz,Float:rtn;
				GetVehicleVelocity(GetPlayerSurfingVehicleID(i),Vx,Vy,Vz);
				rtn = floatsqroot(floatabs(floatpower(Vx + Vy + Vz,2)));
				if(floatround(rtn*100*1.61,floatround_round) > MAX_SPEED_ANTICS && ! (IsABoat(GetPlayerSurfingVehicleID(i))) && GetVehicleModel(GetPlayerSurfingVehicleID(i)) != 406 && GetVehicleModel(GetPlayerSurfingVehicleID(i)) != 422 && GetVehicleModel(GetPlayerSurfingVehicleID(i)) != 433)
				{
						new string[128];
						if(PlayerSurfing[i] == 0)
						{
						    new sz_playerName[MAX_PLAYER_NAME], i_pos;
							GetPlayerName(i, sz_playerName, MAX_PLAYER_NAME);
							while ((i_pos = strfind(sz_playerName, "_", false, i_pos)) != -1) sz_playerName[i_pos] = ' ';
							format(string, sizeof(string), "* %s falls down from the moving car.", sz_playerName);
							ProxDetector(30.0, i, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
							new Float:slx, Float:sly, Float:slz;
							GetPlayerPos(i, slx, sly, slz);
							SetPlayerPos(i, slx, sly, slz+5);
							PlayerSurfing[i]++;
						}
						else if(PlayerSurfing[i] == 5)
						{
  							new Float:slx, Float:sly, Float:slz;
							GetPlayerPos(i, slx, sly, slz);
							SetPlayerPos(i, slx, sly, slz+10);
							PlayerSurfing[i]++;
						}
			   			else if(PlayerSurfing[i] == 7)
			   			{
							new Float:slx, Float:sly, Float:slz;
							GetPlayerPos(i, slx, sly, slz);
							SetPlayerPos(i, slx, sly, slz+15);
							PlayerSurfing[i]++;
						}
						else
						{
							new Float:slx, Float:sly, Float:slz;
							GetPlayerPos(i, slx, sly, slz);
							SetPlayerPos(i, slx, sly, slz+5);
							if(PlayerSurfing[i] == 10)
							{
								SendClientMessage(i, 0xAA3333AA, "Sorry, we have to kick you for possible NOP SetPlayerPos/desync.");
								Kick(i);
							}
							PlayerSurfing[i]++;
						}
					}
				}
				else {PlayerSurfing[i] = 0;}
			}
		}
	}
public OnPlayerConnect(playerid)
{
	PlayerSurfing[playerid] = 0;
	return 1;
}
ProxDetector(Float: f_Radius, playerid, string[],col1,col2,col3,col4,col5)
{
		new Float: f_playerPos[3];
		GetPlayerPos(playerid, f_playerPos[0], f_playerPos[1], f_playerPos[2]);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid) && IsPlayerConnected(i))
			{
					if(IsPlayerInRangeOfPoint(i, f_Radius / 16, f_playerPos[0], f_playerPos[1], f_playerPos[2])) {
						SendClientMessage(i, col1, string);
					}
					else if(IsPlayerInRangeOfPoint(i, f_Radius / 8, f_playerPos[0], f_playerPos[1], f_playerPos[2])) {
						SendClientMessage(i, col2, string);
					}
					else if(IsPlayerInRangeOfPoint(i, f_Radius / 4, f_playerPos[0], f_playerPos[1], f_playerPos[2])) {
						SendClientMessage(i, col3, string);
					}
					else if(IsPlayerInRangeOfPoint(i, f_Radius / 2, f_playerPos[0], f_playerPos[1], f_playerPos[2])) {
						SendClientMessage(i, col4, string);
					}
					else if(IsPlayerInRangeOfPoint(i, f_Radius, f_playerPos[0], f_playerPos[1], f_playerPos[2])) {
						SendClientMessage(i, col5, string);
					}
			}
			else SendClientMessage(i, col1, string);
		}
		return 1;
}