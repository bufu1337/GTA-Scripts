#include <a_samp>
#define dcmd(%1,%2,%3) if((strcmp((%3)[1],#%1,true,(%2))==0)&&((((%3)[(%2)+1]==0)&&(dcmd_%1(playerid,"")))||(((%3)[(%2)+1]==32)&&(dcmd_%1(playerid,(%3)[(%2)+2]))))) return 1
#pragma tabsize 0
#define FILTERSCRIPT
#if defined FILTERSCRIPT
#endif
 
forward Tip();

ChangeWeather();
LoadScript();

new PlayerText3D:CarLabel[MAX_PLAYERS];
new bool:LabelActive[MAX_PLAYERS];
new Float:OldHealth[MAX_PLAYERS];
new Float:OldDamage[MAX_PLAYERS];
new Float:CDamage[MAX_PLAYERS];
new timercar[MAX_PLAYERS];

//--------BARVY---------------------------------------------------------------//
#define COLOR_RED  	0xE10000AA
#define B_REDD   0xFF0000AA
#define B_GREE   0x33AA33AA
#define B_BILA	 0xFFFFFFAA
#define B_ORAN   0xFF8C00AA
#define B_SVIT   0x7FFF00AA
#define B_MODR   0x4169FFAA
#define B_ZLUT   0xFFFF00AA
#define B_SEDA 	 0x808080AA
#define BARVA_SZELENÁ 0xB50000
#define BARVA_TZELENÁ 0xFF0000
#define BARVA_MODRA 0x4169FFAA
#define BARVA_CERVENA 0xFF0000FF
#define BARVA_HMODRA 0x00FFEEFF
#define BARVA_ZLUTA 0xFFEE00FF
#define FARBA_BILA 0xFFFFFFFF
#define B_CERV  0xE80580AA
#define B_BILA  0xFFFFFFAA
//-------PUJCKA--------------------------------------------------------------//
public OnPlayerCommandText(playerid, cmdtext[])
{
if(!strcmp(cmdtext, "/fix", true))
{
    new Float:vh;
    GetVehicleHealth(GetPlayerVehicleID(playerid),vh);
    if(GetPlayerMoney(playerid) < 500) return SendClientMessage(playerid, 0xFF0000FF, "Nemáš $500 na opravu");
    else if(vh > 990) return SendClientMessage(playerid, 0xFF0000FF, "Nesimuluj!");
    else
    {
        RepairVehicle(GetPlayerVehicleID(playerid));
        GivePlayerMoney(playerid, 0-500);
        SendClientMessage(playerid, 0xFF6000FF, "A nerozbi ho hned !");
    }
    return 1;
}
if(strcmp(cmdtext, "/ls", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,1774.2448,-1696.0951,13.4658);
            }else{
                  SetVehiclePos(car,1774.2448,-1696.0951,13.4658);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan do LS."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/sf", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,-1945.4613,585.1636,35.1279);
            }else{
                  SetVehiclePos(car,-1945.4613,585.1636,35.1279);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan do SF."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/lv", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,2092.8855,1400.9065,10.8203);
            }else{
                  SetVehiclePos(car,2092.8855,1400.9065,10.8203);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan do LV."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/show", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,-1978.8470,262.2692,35.1719);
            }else{
                  SetVehiclePos(car,-1978.8470,262.2692,35.1719);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na Tuning Show."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/driftLV", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,2320.3948,1448.6752,42.8203);
            }else{
                  SetVehiclePos(car,2320.3948,1448.6752,42.8203);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na DriftLV."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/driftSF", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,-2407.1277,-597.5767,132.6484);
            }else{
                  SetVehiclePos(car,-2407.1277,-597.5767,132.6484);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na DriftSF."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/driftPoust", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,-307.5260,1514.7635,75.3594);
            }else{
                  SetVehiclePos(car,-307.5260,1514.7635,75.3594);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na DriftPoust."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/WangCars", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,-1981.9688,273.5180,35.1794);
            }else{
                  SetVehiclePos(car,-1981.9688,273.5180,35.1794);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na WangCars."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/TuningSF", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,-1937.4980,226.6587,34.1563);
            }else{
                  SetVehiclePos(car,-1937.4980,226.6587,34.1563);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na TuningSF."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/TuningSF2", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,-2703.1865,217.3787,4.1797);
            }else{
                  SetVehiclePos(car,-2703.1865,217.3787,4.1797);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na TuningSF2."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/TuningLS", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,2645.1973,-2026.6907,13.5469);
            }else{
                  SetVehiclePos(car,2645.1973,-2026.6907,13.5469);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na TuningLS."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/TuningLS2", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,1041.2594,-1038.0901,31.7554);
            }else{
                  SetVehiclePos(car,1041.2594,-1038.0901,31.7554);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na TuningLS2."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/TuningLV", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,2386.8589,1030.3953,10.8203);
            }else{
                  SetVehiclePos(car,2386.8589,1030.3953,10.8203);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na TuningLV."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/Stunt1", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,2090.2327,1351.7263,10.8203);
            }else{
                  SetVehiclePos(car,2090.2327,1351.7263,10.8203);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na Stunt1."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/Stunt2", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,1941.8737,2197.4387,10.8203);
            }else{
                  SetVehiclePos(car,1941.8737,2197.4387,10.8203);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na Stunt2."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/Stunt3", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,1970.5416,-1423.2784,13.5554);
            }else{
                  SetVehiclePos(car,1970.5416,-1423.2784,13.5554);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na Stunt3."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/Stunt4", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,-1658.7474,532.9061,38.4308);
            }else{
                  SetVehiclePos(car,-1658.7474,532.9061,38.4308);
            }
            SendClientMessage(playerid, B_MODR, "Stutn4."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/Stunt5", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,-2816.7729,-6.5871,7.1797);
            }else{
                  SetVehiclePos(car,-2816.7729,-6.5871,7.1797);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na Stunt5."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/Stunt6", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,-2139.3652,-215.2812,35.3203);
            }else{
                  SetVehiclePos(car,-2139.3652,-215.2812,35.3203);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na Stunt6."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/Trajekt", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,2965.2517,465.5919,-1.0416);
            }else{
                  SetVehiclePos(car,2965.2517,465.5919,-1.0416);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na Trajekt."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/Chiliad", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,-2332.1970,-1628.7844,483.7032);
            }else{
                  SetVehiclePos(car,-2332.1970,-1628.7844,483.7032);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na Chiliad."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/DragLS", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,1409.1532,-2493.1233,13.2120);
            }else{
                  SetVehiclePos(car,1409.1532,-2493.1233,13.2120);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na DragLS."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/DragSF", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,-1670.1959,-180.8488,13.8081);
            }else{
                  SetVehiclePos(car,-1670.1959,-180.8488,13.8081);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na DragSF."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/DragLV", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,1477.77,1827.54,10.31);
            }else{
                  SetVehiclePos(car,1477.77,1827.54,10.31);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na DragLV."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/motokary", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,1929.8016,1773.2926,18.1884);
            }else{
                  SetVehiclePos(car,1929.8016,1773.2926,18.1884);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na Motokary."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/superdrift", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,-255.1299,1452.3647,119.9606);
            }else{
                  SetVehiclePos(car,-255.1299,1452.3647,119.9606);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na SuperDrift."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
if(strcmp(cmdtext, "/skok", true) == 0) // Pøíkaz
{
      if(IsPlayerConnected(playerid)) // pokud je hráè pøipojen
      {
            new car = GetPlayerVehicleID(playerid); // vytvoøí promìnu pro hráèovo auto
            if(!IsPlayerInAnyVehicle(playerid))
            {
                  SetPlayerPos(playerid,1646.0741,1634.6726,865.3206);
            }else{
                  SetVehiclePos(car,1646.0741,1634.6726,865.3206);
            }
            SendClientMessage(playerid, B_MODR, "Teleportovan na Skok."); // zpráva s autem
            SetPlayerInterior(playerid, 0);
      }
      return 1;
}
    if(!strcmp(cmdtext, "/pujcka 1-999999999", true))
    {
        SendClientMessage(playerid, 0xff0000, "{FF0000}SERVER{FFFFFF}Na našem serveru je tento pøíkaz zakázán!");
        return 1;
            }

         if( strcmp( cmdtext, "/pujcka 1-999999999", false ) == 0 )
    {
        SendClientMessage(playerid, 0xff0000, "{FF0000}SERVER{FFFFFF}Na našem serveru je tento pøíkaz zakázán!");
        return 1;
   }
    return 0;
    }
//------------KONEC /PUJCKA---------------------------------------------------//
//------------3DTEXT NAD AUTEM------------------------------------------------//
public OnPlayerConnect(playerid)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	LabelActive[playerid] = false;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
		CarLabel[playerid] = CreatePlayer3DTextLabel(playerid," ",-1,0,0,0.9,10.0,INVALID_PLAYER_ID,GetPlayerVehicleID(playerid),1);
		UpdateBar(playerid);
	}
	else
	{
		DeletePlayer3DTextLabel(playerid,CarLabel[playerid]);
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{
	UpdateHP(playerid);
	return 1;
}

stock UpdateHP(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
	new Float:HP,veh;
 	veh = GetPlayerVehicleID(playerid);
	GetVehicleHealth(veh, HP);
	if(HP != OldHealth[playerid])
	{
		OldDamage[playerid]=OldHealth[playerid]-HP;
		OldHealth[playerid] = HP;
		if(OldDamage[playerid] > 0)
		{

			new texts[128];
			if(LabelActive[playerid])
			{
				CDamage[playerid]+=OldDamage[playerid];
				format(texts,sizeof(texts),"{ffd800}-%.0f\n%s",CDamage[playerid],UpdateString(HP));
				KillTimer(timercar[playerid]);
				timercar[playerid] = SetTimerEx("DeleteText", 2000, 0, "i", playerid);
			}
			else
			{
				LabelActive[playerid] = true;
				format(texts,sizeof(texts),"{ffd800}-%.0f\n%s",OldDamage[playerid],UpdateString(HP));
				timercar[playerid] = SetTimerEx("DeleteText", 2000, 0, "i", playerid);
			}
			UpdatePlayer3DTextLabelText(playerid, CarLabel[playerid], -1, texts);
		}
	}
	return 1;
}

stock UpdateBar(playerid)
{
	new Float:HP,veh;
 	veh = GetPlayerVehicleID(playerid);
	GetVehicleHealth(veh, HP);
	UpdateString(HP);
	UpdatePlayer3DTextLabelText(playerid, CarLabel[playerid], -1, UpdateString(HP));
	return 1;
}

stock UpdateString(Float:HP)
{
	new str[30];
	if(HP == 1000)          format(str,sizeof(str),"{00ff00}---Výborný Stav---");
	else if(HP >= 900)  	format(str,sizeof(str),"{66ff00}+++++++++{ffffff}+");
	else if(HP >= 800) 		format(str,sizeof(str),"{7fff00}++++++++{ffffff}++");
	else if(HP >= 700)		format(str,sizeof(str),"{ccff00}+++++++{ffffff}+++");
	else if(HP >= 600)		format(str,sizeof(str),"{f7f21a}++++++{ffffff}++++");
	else if(HP >= 500)		format(str,sizeof(str),"{f4c430}+++++{ffffff}+++++");
	else if(HP >= 400)		format(str,sizeof(str),"{e49b0f}++++{ffffff}++++++");
	else if(HP >= 300)		format(str,sizeof(str),"{e4650e}+++{ffffff}+++++++");
	else if(HP >= 250)		format(str,sizeof(str),"{ff2400}++{ffffff}++++++++");
	else 					format(str,sizeof(str),"{ff2400}!!POZOR BOUCHNE!!");
	return str;
}


forward DeleteText(playerid);
public DeleteText(playerid)
{
	KillTimer(timercar[playerid]);
	LabelActive[playerid] = false;
	UpdateBar(playerid);
	CDamage[playerid]=0;
	return 1;
}
//--------------KONEC 3D TEXTU------------------------------------------------//
public OnFilterScriptExit()
{
	return 1;
}

public OnFilterScriptInit()
{
//------------TYP-------------------------------------------------------------//
SetTimer("Tip",65000,1);

{
	switch(random(15))
	{
		case 0:
	{
		SendClientMessageToAll(B_CERV, "(T-I-P) Doporuète náš herní server pøátelúm a získejte odmenu!");
	}
		case 1: {
		SendClientMessageToAll(B_CERV, "(T-I-P) Náš web : www.wix.com/gtasniper22/ceskazemecz.");
	}
	 	case 2: {
		SendClientMessageToAll(B_BILA, "(T-I-P) Chcete si vydelat? zamestnejte se v gangu nebo v klasickém povolaní");
	}
 		case 3: {
		SendClientMessageToAll(B_BILA, "(T-I-P) Potøebuješ poradit??neva zeptej se online adminu!!");
	}
	    case 4: {
		SendClientMessageToAll(B_CERV, "(T-I-P) Na našem serveru také mùžete najít BONUS!!");
	}
	 	case 5: {
		SendClientMessageToAll(B_CERV, "(T-I-P) Mužete se také proletet v (npc)letadle z mesta do mesta viz. na mape ikonkou (letadlo)");
	}
        case 6: {
        SendClientMessageToAll(B_BILA, "(T-I-P) Navštivte náš web - www.wix.com/gtasniper22/ceskazemecz");
	}
	    case 7: {
		SendClientMessageToAll(B_BILA, "(T-I-P) Navstivte nekterý z baru v Los Santos i jimem meste, ve kterych se mužete opít");
	}
	    case 8: {
		SendClientMessageToAll(B_CERV, "(T-I-P) V arénì na východì Los Santos i jiném meste, mùžete závodit ve (4) rùzných závodech");
	}
        case 9: {
        SendClientMessageToAll(B_CERV, "(T-I-P) Usnadneni: /info /help /zavody /cheat ID duvod /admins /animace");
	}
        case 10: {
		SendClientMessageToAll(B_BILA, "(T-I-P) Chcete se pobavit s kamarady? Akce je pro vás to nejlepší!!:D");
	}
        case 11: {
        SendClientMessageToAll(B_BILA, "(T-I-P) Prosím dodržujte stanovená pravidla! viz. /pravidla");
	}
        case 12: {
		SendClientMessageToAll(B_CERV, "(T-I-P) Pokud jste èlenem gangu, mùžete zabírat území");
	}
	    case 13: {

	}
        case 14: {
        SendClientMessageToAll(B_BILA, "(T-I-P) Mužete také vyzkoušet zábavnou minihry,(v kasinech)");
	}
}
}
//------------KONEC TYP-------------------------------------------------------//
//------------3DTEXT----------------------------------------------------------//
Create3DTextLabel("WEB: www.wix.com/gtasniper22/ceskazemecz", 0x00FFEEFF, 1608.8473,1817.7090,10.8203, 80.0, 0);
Create3DTextLabel("Vítejte na tomto serveru který upravoval _.:By Sniper22 a By Pitbul23:._", 0xFFEE00FF, 1605.7615,1824.0448,10.8203, 80.0, 0);
Create3DTextLabel("Pro pomoc dej : /help /Info /admins /warpy", 0x00FFEEFF, 1611.2529,1823.6189,10.8203, 80.0, 0);
Create3DTextLabel("_.:Užite si to :D:._", 0xFFFFFFFF, 1608.2207,1829.1938,10.8203, 80.0, 0);
//-----------KONEC 3DTEXTU----------------------------------------------------//
//------------SFAIPORT--------------------------------------------------------//
CreateObject(18749, -1393.177734, -281.599609, 25.105672, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18750, -1398.376220, -281.462493, 43.450809, 83.999969, 179.999572, 308.999725, 300);
CreateObject(18728, -1359.218627, -312.983215, 24.487499, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18728, -1368.676513, -303.334716, 24.487499, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18728, -1388.868286, -272.747833, 26.845722, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18728, -1403.241821, -257.978607, 24.487499, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18728, -1420.650512, -241.724166, 24.487499, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18653, -1344.904296, -303.332427, 24.437500, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18655, -1418.382690, -230.866882, 24.437500, 0.000000, 0.000000, 278.000000, 300);
CreateObject(18657, -1343.916503, -303.613708, 26.378097, 14.000000, 0.000000, 66.000000, 300);
CreateObject(1337, -1415.887695, -231.909179, 31.934453, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18658, -1418.845214, -229.588256, 26.626541, 14.000000, 0.000000, 202.000000, 300);
CreateObject(18655, -1404.366210, -240.200195, 18.627620, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18655, -1398.407714, -232.268417, 13.148437, 0.000000, 0.000000, 170.000000, 300);
CreateObject(18653, -1391.612915, -238.862747, 13.148437, 0.000000, 0.000000, 313.250000, 300);
CreateObject(18648, -1394.097778, -236.174438, 13.171875, 0.000000, 0.000000, 42.000000, 300);
CreateObject(18649, -1395.981201, -234.029235, 13.171875, 0.000000, 0.000000, 38.000000, 300);
CreateObject(18651, -1391.238037, -236.193054, 13.171875, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18652, -1395.249023, -232.056762, 13.171875, 0.000000, 0.000000, 272.000000, 300);
CreateObject(18647, -1391.283691, -232.576812, 13.171875, 0.000000, 0.000000, 40.000000, 300);
CreateObject(18650, -1393.593383, -233.794998, 13.171875, 0.000000, 0.000000, 302.000000, 300);
CreateObject(18728, -1388.582031, -234.944671, 13.198437, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18728, -1395.221801, -227.581390, 13.198437, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18739, -1395.442749, -237.822250, 13.198437, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18739, -1398.273681, -234.711242, 13.198437, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18786, -1275.074829, -171.644805, 15.648437, 0.000000, 0.000000, 316.000000, 300);
CreateObject(18786, -1311.809082, -135.503982, 15.648437, 0.000000, 0.000000, 133.999755, 300);
CreateObject(18777, -1313.372314, -83.086128, 15.648445, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18777, -1313.784057, -84.953613, 41.619697, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18777, -1313.860839, -86.471084, 67.593139, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18788, -1293.859741, -66.971740, 90.058761, 0.000000, 0.000000, 269.250000, 300);
CreateObject(18778, -1293.529418, -43.335971, 92.433746, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18846, -1377.756835, -235.678817, 18.103054, 0.000000, 0.000000, 226.000000, 300);
CreateObject(1634, -1180.946289, -219.267578, 14.445755, 0.000000, 0.000000, 275.998535, 300);
CreateObject(1337, -1131.075195, -221.202148, 25.568042, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18843, -1182.942016, -217.702346, 64.515235, 0.000000, 0.000000, 38.000000, 300);
CreateObject(1337, -1356.634765, 103.869140, 32.008483, 0.000000, 0.000000, 0.000000, 300);
CreateObject(1634, -1715.296020, -243.733093, 14.445755, 0.000000, 0.000000, 190.000000, 300);
CreateObject(18844, -1715.579467, -241.797439, 64.813636, 0.000000, 0.000000, 0.000000, 300);
CreateObject(1634, -1618.111328, -633.331054, 14.445755, 0.000000, 0.000000, 147.996826, 300);
CreateObject(18845, -1619.822875, -636.277404, 54.689823, 0.000000, 0.000000, 60.000000, 300);
CreateObject(18858, -1293.387695, -154.273696, 24.684835, 0.000000, 0.000000, 40.000000, 300);
CreateObject(18859, -1450.523437, 34.486816, 24.516786, 0.000000, 0.000000, 316.000000, 300);
CreateObject(18859, -1487.282836, -3.427585, 24.706010, 0.000000, 0.000000, 136.000000, 300);
CreateObject(18834, -1579.568115, -54.053909, 33.939945, 0.000000, 0.000000, 320.000000, 300);
CreateObject(18834, -1567.868164, -39.056640, 33.825237, 0.000000, 0.000000, 345.995727, 300);
CreateObject(18809, -1519.048828, -161.500976, 28.976997, 294.060058, 154.791870, 112.741699, 300);
CreateObject(1632, -1503.711181, -142.132049, 14.448549, 0.000000, 0.000000, 140.000000, 300);
CreateObject(18809, -1548.970092, -196.198089, 47.962547, 295.882751, 156.560974, 112.692962, 300);
CreateObject(18822, -1578.349121, -227.275283, 70.953132, 0.000000, 310.000000, 46.000000, 300);
CreateObject(18788, -1601.573608, -261.385650, 85.144607, 0.000000, 0.000000, 62.000000, 300);
CreateObject(18788, -1615.907592, -296.909149, 85.135078, 0.000000, 0.000000, 73.995849, 300);
CreateObject(18779, -1621.422363, -336.356445, 95.983543, 0.000000, 0.000000, 74.000000, 300);
CreateObject(18801, -1411.909179, -87.944335, 35.886016, 0.000000, 0.000000, 333.995361, 300);
CreateObject(18801, -1401.296386, -71.419654, 35.778121, 0.000000, 0.000000, 335.995361, 300);
CreateObject(18801, -1389.754516, -55.890937, 35.828125, 0.000000, 0.000000, 335.994873, 300);
CreateObject(18813, -1266.609130, -213.011535, 35.745326, 358.382080, 36.016601, 21.175903, 300);
CreateObject(18780, -1281.710693, -367.670532, 24.832670, 0.000000, 0.000000, 106.000000, 300);
CreateObject(7073, -1291.743164, -335.307617, 71.612419, 0.000000, 0.000000, 285.748901, 300);
CreateObject(18779, -1248.345092, -31.668457, 23.140625, 0.000000, 0.000000, 136.000000, 300);
CreateObject(1632, -1206.887695, -88.459960, 25.048822, 0.000000, 0.000000, 225.999755, 300);
CreateObject(18778, -1236.575073, 13.341864, 15.892198, 20.500000, 0.000000, 130.000000, 300);
CreateObject(18778, -1240.245849, 10.337312, 22.366447, 44.494995, 0.000000, 129.995727, 300);
CreateObject(18778, -1242.132080, 8.307238, 30.110340, 52.994628, 0.000000, 129.995727, 300);
CreateObject(18781, -1093.594360, 394.573944, 23.900342, 0.000000, 0.000000, 316.000000, 300);
CreateObject(18841, -1283.460815, 247.444244, 60.123664, 0.000000, 0.000000, 319.994750, 300);
CreateObject(18862, -1357.810791, -233.320983, 18.324865, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18820, -1308.156250, 43.524414, 18.765724, 358.342590, 277.822692, 306.358276, 300);
CreateObject(18825, -1389.086914, 135.673828, 33.751209, 0.000000, 0.000000, 317.746582, 300);
CreateObject(18850, -1224.492797, 181.035720, 24.944551, 0.000000, 0.000000, 44.000000, 300);
CreateObject(18780, -1262.190429, 146.634445, 9.074712, 0.000000, 0.000000, 44.000000, 300);
CreateObject(18782, -1360.935180, 10.338317, 14.384368, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18782, -1365.607543, 25.056770, 14.484375, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18779, -1439.540161, 81.143684, 23.321830, 0.000000, 0.000000, 346.000000, 300);
CreateObject(18829, -1287.962402, 193.665130, 27.123464, 293.999969, 0.000000, 315.500000, 300);
CreateObject(18820, -1258.229980, 225.302764, 45.191772, 292.000000, 0.000000, 318.500000, 300);
CreateObject(2940, -1236.108886, 204.869674, 43.278720, 12.000000, 0.000000, 222.000000, 300);
CreateObject(18836, -1549.545776, -80.311225, 49.429328, 0.000000, 0.000000, 228.000000, 300);
CreateObject(18841, -1547.189575, -130.820312, 48.950050, 270.000000, 180.000000, 322.000000, 300);
CreateObject(18801, -1540.336669, -103.174194, 67.136016, 0.000000, 0.000000, 327.995361, 300);
CreateObject(18808, -1586.503906, -125.328536, 48.793991, 270.000000, 180.000000, 62.000000, 300);
CreateObject(1632, -1612.431884, -111.159210, 44.873527, 0.000000, 0.000000, 64.000000, 300);
CreateObject(18825, -1329.188720, 71.220329, 37.882732, 0.000000, 0.000000, 310.496582, 300);
CreateObject(717, -1401.936645, -227.014923, 13.373445, 0.000000, 0.000000, 316.000000, 300);
CreateObject(717, -1387.998291, -241.379074, 13.373453, 0.000000, 0.000000, 315.999755, 300);
CreateObject(18829, -1530.637695, -46.197578, 49.953525, 0.000000, 268.000000, 350.000000, 300);
CreateObject(1632, -1502.551391, -51.350444, 46.852077, 0.000000, 0.000000, 262.000000, 300);
CreateObject(7073, -1504.844116, -3.012939, 54.700851, 0.000000, 0.000000, 225.748901, 300);
CreateObject(7073, -1430.746582, 30.166261, 54.410530, 0.000000, 0.000000, 225.747070, 300);
CreateObject(1632, -1164.499877, -124.300483, 25.661853, 0.000000, 0.000000, 225.999755, 300);
CreateObject(18788, -1045.906860, 438.085998, 30.045169, 0.000000, 0.000000, 46.000000, 300);
CreateObject(18800, -996.399291, 456.868804, 41.920509, 0.000000, 0.000000, 47.500000, 300);
CreateObject(18800, -943.980773, 394.966003, 62.097305, 0.000000, 0.000000, 37.499389, 300);
CreateObject(18841, -996.617370, 403.326385, 57.510688, 84.931213, 180.000366, 223.328002, 300);
CreateObject(1632, -957.053710, 356.799591, 75.477073, 0.000000, 0.000000, 124.000000, 300);
CreateObject(18858, -983.109985, 340.027038, 87.191009, 347.383178, 179.999938, 307.383178, 300);
CreateObject(18860, -1661.371459, -131.870117, 79.384696, 0.000000, 0.000000, 52.000000, 300);
CreateObject(18831, -1720.589721, -416.389129, 24.676616, 0.000000, 328.000000, 56.000000, 300);
CreateObject(18831, -1717.940063, -413.525573, 46.244865, 3.690063, 52.149414, 57.263000, 300);
CreateObject(18842, -1698.574707, -383.819427, 49.368949, 270.000000, 180.000000, 327.999877, 300);
CreateObject(18841, -1681.563476, -353.967254, 65.074317, 6.000000, 0.000000, 236.500000, 300);
CreateObject(18801, -1698.103027, -356.380554, 98.563423, 0.000000, 0.000000, 57.991333, 300);
CreateObject(18809, -1721.960937, -368.765625, 85.055839, 281.999969, 180.000000, 139.750000, 300);
CreateObject(1632, -1741.362060, -391.167419, 86.235969, 0.000000, 0.000000, 140.000000, 300);
CreateObject(18779, -1524.741455, -355.807434, 10.367187, 0.000000, 0.000000, 182.000000, 300);
CreateObject(18779, -1474.866333, -407.371734, 8.695353, 0.000000, 0.000000, 267.999511, 300);
CreateObject(18779, -1461.582031, -339.109039, 23.693283, 0.000000, 0.000000, 224.000000, 300);
CreateObject(18779, -1626.870971, -160.873443, 23.484916, 0.000000, 0.000000, 328.000000, 300);
CreateObject(1632, -1595.279785, -481.663330, 22.562915, 0.000000, 0.000000, 301.998779, 300);
CreateObject(1632, -1628.250488, -502.022369, 22.453098, 0.000000, 0.000000, 155.997680, 300);
CreateObject(1634, -1551.549804, -623.913085, 14.441273, 0.000000, 0.000000, 209.996826, 300);
CreateObject(1634, -1548.961914, -628.447692, 18.541755, 28.000000, 0.000000, 210.492675, 300);
CreateObject(1634, -1547.159790, -631.585998, 24.872453, 41.998657, 0.000000, 210.492553, 300);
CreateObject(1634, -1537.872558, -656.794555, 37.110862, 0.000000, 0.000000, 179.992675, 300);
CreateObject(1634, -1529.330322, -676.172485, 39.437126, 0.000000, 0.000000, 271.989013, 300);
CreateObject(1634, -1502.014282, -668.913208, 39.497642, 0.000000, 0.000000, 353.988525, 300);
CreateObject(1634, -1510.185180, -645.732910, 40.074188, 0.000000, 0.000000, 91.984985, 300);
CreateObject(4585, -1212.274536, -410.717254, 22.303009, 62.000000, 0.000000, 0.000000, 300);
CreateObject(18826, -1291.216674, -496.185729, 33.522033, 0.000000, 0.000000, 92.000000, 300);
CreateObject(18811, -1294.999145, -460.772827, 51.036117, 274.000000, 0.000000, 8.500000, 300);
CreateObject(18841, -1316.208251, -428.559570, 52.597068, 270.000000, 179.994506, 100.248291, 300);
CreateObject(18841, -1342.502563, -455.896911, 52.326522, 270.000000, 179.994506, 287.994750, 300);
CreateObject(18841, -1366.838134, -443.531036, 67.876289, 1.998535, 0.000000, 303.747192, 300);
CreateObject(18836, -1345.816894, -471.684204, 83.657844, 0.000000, 0.000000, 219.499267, 300);
CreateObject(1634, -1252.326660, -610.424743, 14.445755, 0.000000, 0.000000, 165.998535, 300);
CreateObject(1634, -1296.830322, -653.228149, 24.073963, 0.000000, 0.000000, 89.997924, 300);
CreateObject(1634, -1360.671875, -656.707885, 23.654634, 0.000000, 0.000000, 89.994506, 300);
CreateObject(1634, -1422.830566, -657.010131, 23.658210, 0.000000, 0.000000, 89.994506, 300);
CreateObject(1634, -1462.555419, -639.393981, 27.556884, 0.000000, 0.000000, 359.994506, 300);
CreateObject(18788, -1461.186401, -597.784667, 30.659307, 0.000000, 0.000000, 266.000000, 300);
CreateObject(1634, -1457.265991, -579.349548, 32.862876, 0.000000, 0.000000, 343.989013, 300);
CreateObject(1634, -1409.450317, -514.113342, 25.687171, 0.000000, 0.000000, 303.987426, 300);
CreateObject(18631, -1344.707641, -564.560363, 13.308028, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18759, -1288.105468, -571.579833, 13.148437, 0.000000, 0.000000, 0.000000, 300);
CreateObject(1634, -1271.861572, -521.595886, 14.441283, 0.000000, 0.000000, 159.997924, 300);
CreateObject(18786, -1317.913330, -574.167846, 25.398441, 0.000000, 0.000000, 16.000000, 300);
CreateObject(18769, -1358.815429, -582.881835, 28.463832, 0.000000, 0.000000, 13.250000, 300);
CreateObject(18768, -1401.238281, -586.372985, 29.073381, 0.000000, 0.000000, 12.500000, 300);
CreateObject(1634, -1370.575927, -592.772521, 29.881460, 0.000000, 0.000000, 101.997924, 300);
CreateObject(18761, -1463.011718, -620.532226, 18.004234, 0.000000, 0.000000, 0.000000, 300);
CreateObject(18761, -1414.929687, -588.788085, 34.353927, 0.000000, 0.000000, 281.500000, 300);
CreateObject(1632, -1660.844482, -617.108215, 14.448549, 0.000000, 0.000000, 108.000000, 300);


//-----------oldaiport--------------------------------------------------------//
CreateObject(13641, 273.1865234375, 2483.9990234375, 16.984375, 0, 0, 0);
CreateObject(3569, 297.740234375, 2484.8759765625, 18.097993850708, 0, 0, 0);
CreateObject(3569, 301.4303894043, 2484.8471679688, 18.097993850708, 0, 0, 0);
CreateObject(3569, 305.13720703125, 2484.88671875, 18.097993850708, 0, 0, 0);
CreateObject(8620, 272.89834594727, 2483.7561035156, 38.617221832275, 0, 0, 90);
CreateObject(7073, 378.0283203125, 2474.5473632813, 33.751125335693, 0, 0, 0);
CreateObject(8356, 284.91165161133, 2459.7341308594, 23.046035766602, 0, 23, 89);
CreateObject(8356, 113.34375, 2462.88671875, 23.005348205566,0,22.999877929688, 88.994750976563);
CreateObject(8355, 308.81436157227, 2421.0017089844, 30.861448287964, 0, 0, 89);
CreateObject(8355, 180.93505859375, 2423.232421875, 30.643814086914, 0, 0, 89);
CreateObject(8357, 270.4216003418, 2382.2312011719, 30.690284729004, 0, 0, 89);
CreateObject(8357, 269.14511108398, 2342.7592773438, 30.525417327881, 0, 0, 89);
CreateObject(8357, 268.49359130859, 2303.1740722656, 30.466239929199, 0, 0, 89);
CreateObject(8357, 228.57894897461, 2264.2766113281, 30.225536346436, 0, 0, 89);
CreateObject(8357, 228.578125, 2264.2763671875, 30.225536346436, 0, 0, 88.9892578125);
CreateObject(8357, 57.256858825684, 2280.8803710938, 30.229515075684, 0, 0, 88.994750976563);
CreateObject(8357, 59.490642547607, 2318.3466796875, 30.583158493042, 0, 0, 88.994750976563);
CreateObject(8357, 61.591693878174, 2358.1379394531, 30.664112091064, 0, 0, 88.994750976563);
CreateObject(8357, 62.259147644043, 2397.4797363281, 30.696872711182, 0, 0, 89);
CreateObject(8357, 63.23046875, 2425.3974609375, 30.48356628418, 0, 0, 88.9892578125);
CreateObject(8357, -62.174808502197, 2340.8684082031, 30.377925872803, 0, 0, 0);
CreateObject(8355, -12.284235954285, 2465.0185546875, 23.038265228271, 0, 23, 89);
CreateObject(13590, 113.85931396484, 2523.0302734375, 16.833190917969, 0, 0, 89);
CreateObject(13592, 264.90856933594, 2519.4052734375, 25.201225280762, 0, 0, 0);
CreateObject(13592, 257.47180175781, 2512.0085449219, 25.351198196411, 0, 0, 0);
CreateObject(13641, 67.303802490234, 2523.2197265625, 16.484375, 0, 0, 0);
CreateObject(13648, 164.77336120605, 2536.5288085938, 15.682998657227, 0, 0, 89);
CreateObject(13647, 126.05488586426, 2536.841796875, 15.690427780151, 0, 0, 0);
CreateObject(18609, 24.502944946289, 2530.0786132813, 16.664567947388, 0, 0, 0);
CreateObject(18609, 19.940208435059, 2529.9538574219, 16.664567947388, 0, 0, 0);
CreateObject(18609, 13.351203918457, 2530.4189453125, 16.656862258911, 0, 0, 0);
CreateObject(3665, 251.82131958008, 2341.2736816406, 32.491386413574, 0, 0, 89);
CreateObject(12956, 175.5158996582, 2393.6701660156, 33.752899169922, 0, 0, 0);
CreateObject(13636, 329.26382446289, 2318.2893066406, 32.731006622314, 0, 0, 0);
CreateObject(13640, 36.776844024658, 2533.8361816406, 16.512350082397, 0, 0, 0);
CreateObject(3364, -8.8160400390625, 2521.7373046875, 15.492184638977, 0, 0, 0);
CreateObject(3625, 152.25238037109, 2309.4396972656, 33.402709960938, 0, 0, 0);
CreateObject(13592, 356.52099609375, 2381.1169433594, 39.745265960693, 0, 0, 0);
CreateObject(1632, 371.39413452148, 2384.0014648438, 31.974771499634, 0, 0, 268);
CreateObject(7371, 378.74041748047, 2421.58203125, 15.484374046326, 0, 0, 0);
CreateObject(7371, 378.57611083984, 2437.6379394531, 23.652591705322, 0, 0, 0);
CreateObject(7371, -81.52075958252, 2469.958984375, 15.484375, 0, 0, 0);
CreateObject(13604, 251.15002441406, 2416.8959960938, 32.319465637207, 0, 0, 0);
CreateObject(13638, 367.84588623047, 2517.376953125, 17.760898590088, 0, 0, 0);
CreateObject(16304, -66.578308105469, 2525.7736816406, 20.669654846191, 0, 0, 0);
CreateObject(16367, 178.6828918457, 2306.2885742188, 32.217311859131, 0, 0, 0);
CreateObject(16771, -13.6259765625, 2331.990234375, 36.896839141846, 0, 0, 0);
CreateObject(9193, -40.045330047607, 2359.2829589844, 35.516540527344, 0, 0, 0);
CreateObject(1632, 220.41055297852, 2288.9353027344, 31.750726699829, 0, 0, 89);
CreateObject(1632, 215.60618591309, 2289.158203125, 34.75072479248, 33, 0, 89);
CreateObject(13636, 57.339450836182, 2327.1750488281, 32.855735778809, 0, 0, 0);
CreateObject(18451, 88.608322143555, 2440.0732421875, 30.980367660522, 0, 0, 0);
CreateObject(13592, 78.248146057129, 2368.7568359375, 40.219093322754, 0, 0, 0);
CreateObject(13642, 311.01812744141, 2414.8920898438, 32.53959274292, 0, 0, 0);
CreateObject(6052, -54.777111053467, 2415.1057128906, 33.109939575195, 0, 0, 0);
CreateObject(13641, 25.04955291748, 2427.2348632813, 32.21794128418, 0, 0, 0);
CreateObject(17565, 258.28842163086, 2264.8732910156, 31.968616485596, 0, 0, 0);
CreateObject(3524, 1.193995475769, 2353.8041992188, 33.541637420654, 0, 0, 188.99987792969);
CreateObject(3524, -28.047267913818, 2353.8041992188, 33.533828735352, 0, 0, 188.99780273438);
CreateObject(3528, -13.503337860107, 2356.29296875, 40.939125061035, 0, 0, 93.999084472656);
CreateObject(3528, 404.95596313477, 2477.8681640625, 25.927518844604, 0, 0, 93.9990234375);
CreateObject(9833, 417.29696655273, 2479.5227050781, 12.186918258667, 0, 0, 0);
CreateObject(9833, 390.36083984375, 2479.4370117188, 12.186918258667, 0, 0, 0);
CreateObject(16776, -30.535911560059, 2502.4826660156, 13.734375, 0, 0, 0);
CreateObject(1632, -9.5123481750488, 2502.2856445313, 16.78448677063, 0, 0, 89);
CreateObject(8357, 527.14447021484, 2499.8669433594, 56.752124786377, 23, 0, 268);
CreateObject(8357, 719.73004150391, 2493.205078125, 138.5751953125, 22.999877929688, 0, 267.99499511719);
CreateObject(8357, 895.13116455078, 2487.013671875, 213.04916381836, 22.999877929688, 0, 267.99499511719);
CreateObject(16771, 1014.4150390625, 2484.1943359375, 260.99237060547, 0, 0, 88);
CreateObject(1632, 208.45608520508, 2511.3989257813, 16.858583450317, 0, 0, 89);
CreateObject(1632, 203.04092407227, 2511.5478515625, 19.603549957275, 9, 0, 89);
CreateObject(1632, 197.91665649414, 2511.6311035156, 23.477600097656, 20, 0, 88.994750976563);
CreateObject(7371, 542.25299072266, 2479.3666992188, 63.183242797852, 22.999877929688, 0, 267.99499511719);
CreateObject(7371, 663.99468994141, 2475.3083496094, 114.827293396, 22.994384765625, 0, 267.99499511719);
CreateObject(7371, 785.82110595703, 2471.1401367188, 166.53315734863, 22.994384765625, 0, 267.99499511719);
CreateObject(7371, 907.50653076172, 2466.9794921875, 218.33444213867, 22.994384765625, 0, 267.99499511719);
CreateObject(7371, 982.72204589844, 2464.3552246094, 250.48963928223, 22.994384765625, 0, 267.99499511719);
CreateObject(7371, 545.23870849609, 2518.1760253906, 64.274459838867, 22.994384765625, 0, 267.99499511719);
CreateObject(7371, 665.34771728516, 2513.7561035156, 115.15214538574, 22.994384765625, 0, 267.99499511719);
CreateObject(7371, 786.91571044922, 2509.625, 166.5838470459, 22.994384765625, 0, 267.99499511719);
CreateObject(7371, 908.28283691406, 2505.3334960938, 218.23249816895, 22.994384765625, 0, 267.99499511719);
CreateObject(7371, 982.9482421875, 2502.6208496094, 250.02806091309, 22.994384765625, 0, 267.99499511719);
CreateObject(1632, 697.03594970703, 2482.8935546875, 130.45561218262, 339, 0, 89);
CreateObject(1632, 690.38891601563, 2483.0158691406, 131.89984130859, 2, 0, 88.994750976563);
CreateObject(1632, 588.69036865234, 2507.0378417969, 84.037788391113, 338, 0, 89);
CreateObject(1632, 581.96850585938, 2507.3015136719, 85.840591430664, 2, 0, 88.994750976563);
CreateObject(1634, 464.53909301758, 2491.0378417969, 31.281532287598, 338, 0, 85);
CreateObject(1634, 457.19445800781, 2491.6865234375, 33.58500289917, 3, 0, 84.995727539063);
CreateObject(1634, 464.23596191406, 2511.8735351563, 31.167778015137, 337.99987792969, 0, 84.995727539063);
CreateObject(1634, 456.99719238281, 2512.4655761719, 33.186573028564, 2.999267578125, 0, 84.990234375);
CreateObject(1634, 450.32434082031, 2513.0197753906, 37.403644561768, 11, 0, 84.990234375);
CreateObject(1632, 62.518775939941, 2497.4189453125, 16.78448677063, 0, 0, 234);
CreateObject(1634, 140.37857055664, 2494.7937011719, 16.781692504883, 0, 0, 234);
//----------VSE---------------------------------------------------------------//
CreateObject(1641, 1465.5999755859, 1761.9000244141, 9.8000001907349, 0, 0, 0);
CreateObject(11547, 1470.4000244141, 1758.3000488281, 12.800000190735, 0, 0, 272);
CreateObject(11547, 1486.9000244141, 1758.8000488281, 12.800000190735, 0, 0, 271.99951171875);
CreateObject(11393, 1502, 1773, 11.300000190735, 0, 0, 0);
CreateObject(11393, 1453.6999511719, 1773, 11.300000190735, 0, 0, 178);
CreateObject(1422, 2112.5556640625, 857.4912109375, 126.17520141602, 0, 0, 0);
CreateObject(1422, 2022.4000244141, 834.40002441406, 6.0999999046326, 0, 0, 0);
CreateObject(1422, 2020.0999755859, 834.40002441406, 6.0999999046326, 0, 0, 0);
CreateObject(1422, 2017.5, 834.40002441406, 6.0999999046326, 0, 0, 0);
CreateObject(1422, 2014.8000488281, 834.40002441406, 6.1999998092651, 0, 0, 0);
CreateObject(1422, 2012.5, 835, 6.1999998092651, 0, 0, 328);
CreateObject(1422, 2010.4000244141, 836.29998779297, 6.1999998092651, 0, 0, 327.99682617188);
CreateObject(1422, 2008.4000244141, 837.59997558594, 6.1999998092651, 0, 0, 327.99682617188);
CreateObject(1422, 2006.4000244141, 838.90002441406, 6.1999998092651, 0, 0, 327.99682617188);
CreateObject(1422, 2004.0999755859, 840.40002441406, 6.0999999046326, 0, 0, 327.99682617188);
CreateObject(1422, 2002.0999755859, 841.59997558594, 6.0999999046326, 0, 0, 327.99682617188);
CreateObject(1427, 1997.8000488281, 838.90002441406, 6.3000001907349, 0, 0, 268);
CreateObject(1427, 2001.5, 837, 6.3000001907349, 0, 0, 267.99499511719);
CreateObject(1425, 2008.0999755859, 834.90002441406, 6.1999998092651, 0, 0, 292);
CreateObject(1422, 2024.8000488281, 834.40002441406, 6.0999999046326, 0, 0, 0);
CreateObject(1422, 2027.0999755859, 833.90002441406, 6.0999999046326, 0, 0, 334);
CreateObject(1422, 2029.3000488281, 832.79998779297, 6.0999999046326, 0, 0, 333.99536132813);
CreateObject(1422, 2031.6999511719, 832.20001220703, 6.0999999046326, 0, 0, 357.99536132813);
CreateObject(1422, 2033.9000244141, 832.90002441406, 6.0999999046326, 0, 0, 39.994995117188);
CreateObject(1422, 2035.6999511719, 834.40002441406, 6.0999999046326, 0, 0, 39.990234375);
CreateObject(1422, 2037, 836.29998779297, 6.0999999046326, 0, 0, 69.990234375);
CreateObject(1422, 2037.9000244141, 838.70001220703, 6.1999998092651, 0, 0, 69.988403320313);
CreateObject(1422, 2038.1999511719, 841.09997558594, 6.0999999046326, 0, 0, 93.988403320313);
CreateObject(981, 1987.8000488281, 827.09997558594, 5.8000001907349, 0, 0, 180);
CreateObject(8615, 1595.0999755859, 1823.3000488281, 12.5, 0, 0, 268);
CreateObject(12958, 1606.3000488281, 1824.3000488281, 17.89999961853, 0, 0, 92);
CreateObject(12958, 1609.0999755859, 1819.0999755859, 21.39999961853, 0, 0, 270);
CreateObject(12950, 1609.5999755859, 1822.0999755859, 26.60000038147, 0, 0, 182);
//-----------AUTA-------------------------------------------------------------//
AddStaticVehicle(563,1606.7208,1798.3646,31.1742,359.3459,1,6);
AddStaticVehicle(563,1761.0792,2091.3730,21.6673,181.2233,3,0);
return 1;
}
