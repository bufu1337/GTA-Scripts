#include <yom_inc/functions.pwn>

main(){print("\n  yom_gametext_test\n");}

#define cmd(%1) if((strcmp(cmdtext,%1,true,strlen(%1))==0)&&(((cmdtext[strlen(%1)]==0)&&(d%1(playerid,"")))||((cmdtext[strlen(%1)]==32)&&(d%1(playerid,cmdtext[strlen(%1)+1]))))) return 1

new cmd_gtfp[] = "/gtfp";
new cmd_gtfa[] = "/gtfa";

dcmd_gtfp(playerid, param[])
{
    #pragma unused param
	GameTextForPlayer(playerid,"~w~gametextfor~r~player",5000,4);
	return 1;
}

dcmd_gtfa(playerid, param[])
{
	#pragma unused param,playerid
	GameTextForAll("~w~gametextfor~r~all",5000,4);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	cmd(cmd_gtfp);
	cmd(cmd_gtfa);
	return 0;
}

public OnGameModeInit()
{
	SetGameModeText("yom_gametext_test");
	AddPlayerClass(0,0.0,0.0,4.0,0.0,0,0,0,0,0,0);
	AddStaticVehicle(522,0.0,4.0,4.0,0.0,0,0);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}
