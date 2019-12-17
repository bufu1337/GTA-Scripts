//••••••••••••••••••••••••••••••••••••••••••••••••••••
//••
#include <a_samp>
#define MEUS_SLOTS 20
//************ Cores **************************
#define AMARELO          0xFFFF00AA
#define VERDE        0x33AA33A
//********** Arrays ***************************
new CintoPlayer[MEUS_SLOTS];
//***************** CallBakcs (Detectar Batida *****************
public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	if(CintoPlayer[playerid] == 0)
	{
	new Float:Px = 0.000000, Float:Py = 0.000000, Float:Pz = 0.000000, Float:Pa = 0.000000, Float:HV ;
	GetPlayerPos(playerid, Px, Py, Pz);//PEGA POS
	GetPlayerFacingAngle(playerid, Pa);//PEGA ANGULO
	GetVehicleHealth(vehicleid,HV);
	SetPlayerHealth(playerid,HV/10);
	SetPlayerPos(playerid,Px+2,Py+2,Pz+1);
	RemovePlayerFromVehicle(playerid);//REMOVE VEICULO
    ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
    ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
    SendClientMessage(playerid,AMARELO,"[WARNING]: Not That You Care Belt, Can Die");
    SetTimer("ANIM",5000,0);
    SetPlayerWantedLevel(playerid, 1);
    }
    return 1;
}
//************ CallBacks Para Anims **************************
forward ANIM(playerid);
public ANIM(playerid)
{
	ClearAnimations(playerid);
	return 1;
}
//*************** Call Backs Entra Veiculos ******************
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    CintoPlayer[playerid] = 0;
    GameTextForPlayer(playerid, "~r~/Belt or ~n~dethas in crashs cars", 3000, 4);
    return 1;
}
//******** Call Backs Comandos *******************************
public OnPlayerCommandText(playerid, cmdtext[])
{
    if(!strcmp(cmdtext, "/belt", true))
    {
    CintoPlayer[playerid] = 1;
    SendClientMessage(playerid,VERDE,"[WARNING]: Congratulations You're Belt, is now protected (/takebelt)");
    SetPlayerWantedLevel(playerid, 0);
    return 1;
    }
    if(!strcmp(cmdtext, "/takebelt", true))
    {
    CintoPlayer[playerid] = 0;
    SendClientMessage(playerid,AMARELO,"[WARNING]: Not That You Care Belt, Can Die");
    SetPlayerWantedLevel(playerid, 0);
    return 1;
    }
    return 0;
}
//*************** The End *************************************