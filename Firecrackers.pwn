//-------------------- ~! Firecrackers System By BlueGey !~ --------------------

#include a_samp
#include zcmd

new Float:X, Float:Y, Float:Z;
new Ramdan[MAX_PLAYERS][5];
new Star[MAX_PLAYERS][9];
new Smoke[MAX_PLAYERS][5];
new Firework[MAX_PLAYERS][5];
new Dynamite[MAX_PLAYERS][5];

public OnFilterScriptInit()
{
	print("Firecrackers By BlueGey: Runuing !!!");
	print("____________________________________");
	return 1;
}

COMMAND:ramdan(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) return SendClientMessage(playerid, -1, "You can not turn explosive in vehicle");
	if(Ramdan[playerid][0] == 1) return SendClientMessage(playerid, -1, "Lighting has been such explosive Please wait explode");
    GetPlayerPos(playerid, X, Y, Z);
    Ramdan[playerid][1] = CreateObject(SwitchID(14393), X, Y, Z-1.0, 0.0, 0.0, 0.0);
    Ramdan[playerid][2] = CreateObject(SwitchID(14469), X, Y, Z-2.5, 0.0, 0.0, 0.0);
    SetTimerEx("UpRamdan", 5000, false, "%d", playerid);
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
    Ramdan[playerid][0] = 1;
	return 1;
}

COMMAND:star1(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) return SendClientMessage(playerid, -1, "You can not turn explosive in vehicle");
	if(Star[playerid][0] == 1) return SendClientMessage(playerid, -1, "Lighting has been such explosive Please wait explode");
    GetPlayerPos(playerid, X, Y, Z);
    Star[playerid][1] = CreateObject(SwitchID(14393), X, Y, Z-1.0, 0.0, 0.0, 0.0);
    Star[playerid][2] = CreateObject(SwitchID(14469), X, Y, Z-2.5, 0.0, 0.0, 0.0);
    SetTimerEx("UpStar1", 5000, false, "%d", playerid);
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
    Star[playerid][0] = 1;
	return 1;
}

COMMAND:star2(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) return SendClientMessage(playerid, -1, "You can not turn explosive in vehicle");
	if(Star[playerid][0] == 1) return SendClientMessage(playerid, -1, "Lighting has been such explosive Please wait explode");
    GetPlayerPos(playerid, X, Y, Z);
    Star[playerid][1] = CreateObject(SwitchID(14393), X, Y, Z-1.0, 0.0, 0.0, 0.0);
    Star[playerid][2] = CreateObject(SwitchID(14469), X, Y, Z-2.5, 0.0, 0.0, 0.0);
    SetTimerEx("UpStar2", 5000, false, "%d", playerid);
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
    Star[playerid][0] = 1;
	return 1;
}

COMMAND:smoke(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) return SendClientMessage(playerid, -1, "You can not turn explosive in vehicle");
	if(Smoke[playerid][0] == 1) return SendClientMessage(playerid, -1, "Lighting has been such explosive Please wait explode");
    GetPlayerPos(playerid, X, Y, Z);
    Smoke[playerid][1] = CreateObject(SwitchID(12844), X, Y, Z-0.5, 0.0, 0.0, 0.0);
    Smoke[playerid][2] = CreateObject(SwitchID(14469), X, Y, Z-1.7, 0.0, 0.0, 0.0);
    SetTimerEx("UpSmoke", 5000, false, "%d", playerid);
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
    Smoke[playerid][0] = 1;
	return 1;
}

COMMAND:fireworks(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) return SendClientMessage(playerid, -1, "You can not turn explosive in vehicle");
	if(Firework[playerid][0] == 1) return SendClientMessage(playerid, -1, "Lighting has been such explosive Please wait explode");
    GetPlayerPos(playerid, X, Y, Z);
    Firework[playerid][1] = CreateObject(SwitchID(14393), X, Y, Z-1.0, 0.0, 0.0, 0.0);
    Firework[playerid][2] = CreateObject(SwitchID(14469), X, Y, Z-2.5, 0.0, 0.0, 0.0);
    SetTimerEx("UpFirework1", 5000, false, "%d", playerid);
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
    Firework[playerid][0] = 1;
	return 1;
}

COMMAND:dynamite(playerid, params[])
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) return SendClientMessage(playerid, -1, "You can not turn explosive in vehicle");
	if(Dynamite[playerid][0] == 1) return SendClientMessage(playerid, -1, "Lighting has been such explosive Please wait explode");
    GetPlayerPos(playerid, X, Y, Z);
    Dynamite[playerid][1] = CreateObject(SwitchID(14393), X, Y, Z-1.0, 0.0, 0.0, 0.0);
    Dynamite[playerid][2] = CreateObject(SwitchID(14469), X, Y, Z-2.5, 0.0, 0.0, 0.0);
    SetTimerEx("UpDynamite1", 5000, false, "%d", playerid);
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
    Dynamite[playerid][0] = 1;
	return 1;
}

forward UpRamdan(playerid);
public UpRamdan(playerid)
{
    GetObjectPos(Ramdan[playerid][1], X, Y, Z);
    Ramdan[playerid][3] = CreateObject(SwitchID(16132), X, Y, Z, 0.0, 0.0, 0.0);
    Ramdan[playerid][4] = CreateObject(SwitchID(16126), X, Y, Z, 0.0, 0.0, 0.0);
    MoveObject(Ramdan[playerid][3], X, Y, Z+35, 30.0);
    MoveObject(Ramdan[playerid][4], X, Y, Z+35, 30.0);
    DestroyObject(Ramdan[playerid][1]);
    DestroyObject(Ramdan[playerid][2]);
	SetTimerEx("BoomRamdan", 1000, false, "%d", playerid);
	Ramdan[playerid][0] = 0;
	return 1;
}

forward BoomRamdan(playerid);
public BoomRamdan(playerid)
{
    GetObjectPos(Ramdan[playerid][3], X, Y, Z);
    CreateExplosion(X, Y, Z, 7, 10);
    DestroyObject(Ramdan[playerid][3]);
    DestroyObject(Ramdan[playerid][4]);
	return 1;
}

forward UpStar1(playerid);
public UpStar1(playerid)
{
    GetObjectPos(Star[playerid][1], X, Y, Z);
    Star[playerid][3] = CreateObject(SwitchID(16132), X, Y, Z, 0.0, 0.0, 0.0);
    Star[playerid][4] = CreateObject(SwitchID(16126), X, Y, Z, 0.0, 0.0, 0.0);
    MoveObject(Star[playerid][3], X, Y, Z+35, 30.0);
    MoveObject(Star[playerid][4], X, Y, Z+35, 30.0);
    DestroyObject(Star[playerid][1]);
    DestroyObject(Star[playerid][2]);
	SetTimerEx("BoomStar1", 1000, false, "%d", playerid);
	return 1;
}

forward BoomStar1(playerid);
public BoomStar1(playerid)
{
    GetObjectPos(Star[playerid][3], X, Y, Z);
    CreateExplosion(X+10, Y, Z, 7, 10);
    CreateExplosion(X, Y-10, Z, 7, 10);
    CreateExplosion(X, Y, Z, 7, 10);
    CreateExplosion(X, Y+10, Z, 7, 10);
    CreateExplosion(X-10, Y, Z, 7, 10);
    DestroyObject(Star[playerid][3]);
    DestroyObject(Star[playerid][4]);
    Star[playerid][0] = 0;
	return 1;
}

forward UpStar2(playerid);
public UpStar2(playerid)
{
    GetObjectPos(Star[playerid][1], X, Y, Z);
    Star[playerid][3] = CreateObject(SwitchID(16132), X, Y, Z, 0.0, 0.0, 0.0);
    MoveObject(Star[playerid][3], X, Y, Z+35, 30.0);
    DestroyObject(Star[playerid][1]);
    DestroyObject(Star[playerid][2]);
	SetTimerEx("BoomStar2", 1000, false, "%d", playerid);
	return 1;
}

forward BoomStar2(playerid);
public BoomStar2(playerid)
{
    GetObjectPos(Star[playerid][3], X, Y, Z);
    CreateExplosion(X, Y, Z, 7, 10);
    Star[playerid][4] = CreateObject(SwitchID(16131), X, Y, Z, 0.0, 0.0, 0.0);
    Star[playerid][5] = CreateObject(SwitchID(16132), X, Y, Z, 0.0, 0.0, 0.0);
    Star[playerid][6] = CreateObject(SwitchID(16133), X, Y, Z, 0.0, 0.0, 0.0);
    Star[playerid][7] = CreateObject(SwitchID(16134), X, Y, Z, 0.0, 0.0, 0.0);
    Star[playerid][8] = CreateObject(SwitchID(16131), X, Y, Z, 0.0, 0.0, 0.0);
    MoveObject(Star[playerid][4], X+10, Y, Z-15, 2.5);
    MoveObject(Star[playerid][5], X, Y-10, Z-15, 2.5);
    MoveObject(Star[playerid][6], X, Y, Z-15, 2.5);
    MoveObject(Star[playerid][7], X, Y+10, Z-15, 2.5);
    MoveObject(Star[playerid][8], X-10, Y, Z-15, 2.5);
    DestroyObject(Star[playerid][3]);
    SetTimerEx("BoomStar3", 5000, false, "%d", playerid);
    Star[playerid][0] = 0;
	return 1;
}

forward BoomStar3(playerid);
public BoomStar3(playerid)
{
    GetObjectPos(Star[playerid][4], X, Y, Z);
    CreateExplosion(X, Y, Z, 7, 10);
    DestroyObject(Star[playerid][4]);
    GetObjectPos(Star[playerid][5], X, Y, Z);
    CreateExplosion(X, Y, Z, 7, 10);
    DestroyObject(Star[playerid][5]);
    GetObjectPos(Star[playerid][6], X, Y, Z);
    CreateExplosion(X, Y, Z, 7, 10);
    DestroyObject(Star[playerid][6]);
    GetObjectPos(Star[playerid][7], X, Y, Z);
    CreateExplosion(X, Y, Z, 7, 10);
    DestroyObject(Star[playerid][7]);
    GetObjectPos(Star[playerid][8], X, Y, Z);
    CreateExplosion(X, Y, Z, 7, 10);
    DestroyObject(Star[playerid][8]);
	return 1;
}

forward UpSmoke(playerid);
public UpSmoke(playerid)
{
    GetObjectPos(Smoke[playerid][1], X, Y, Z);
    Smoke[playerid][3] = CreateObject(SwitchID(14465), X, Y, Z, 0.0, 0.0, 0.0);
	SetTimerEx("BoomSmoke", 10000, false, "%d", playerid);
	return 1;
}

forward BoomSmoke(playerid);
public BoomSmoke(playerid)
{
    GetObjectPos(Smoke[playerid][1], X, Y, Z);
    Smoke[playerid][4] = CreateObject(SwitchID(16132), X, Y, Z, 0.0, 0.0, 0.0);
    MoveObject(Smoke[playerid][4], X, Y, Z+35, 30.0);
    SetTimerEx("BoomSmokeUp", 1000, false, "%d", playerid);
	return 1;
}

forward BoomSmokeUp(playerid);
public BoomSmokeUp(playerid)
{
    GetObjectPos(Smoke[playerid][4], X, Y, Z);
    CreateExplosion(X+5, Y, Z, 7, 10);
    CreateExplosion(X, Y-5, Z, 7, 10);
    CreateExplosion(X, Y, Z, 7, 10);
    CreateExplosion(X, Y+5, Z, 7, 10);
    CreateExplosion(X-5, Y, Z, 7, 10);
    DestroyObject(Smoke[playerid][1]);
    DestroyObject(Smoke[playerid][2]);
    DestroyObject(Smoke[playerid][3]);
    DestroyObject(Smoke[playerid][4]);
    Smoke[playerid][0] = 0;
	return 1;
}

forward UpFirework1(playerid);
public UpFirework1(playerid)
{
    GetObjectPos(Firework[playerid][1], X, Y, Z);
    DestroyObject(Firework[playerid][2]);
    Firework[playerid][3] = CreateObject(SwitchID(16131), X, Y, Z, 0.0, 0.0, 0.0);
    MoveObject(Firework[playerid][3], X, Y, Z+50, 30.0);
    SetTimerEx("UpFirework2", 1500, false, "%d", playerid);
	return 1;
}

forward UpFirework2(playerid);
public UpFirework2(playerid)
{
    GetObjectPos(Firework[playerid][3], X, Y, Z);
    CreateExplosion(X, Y, Z, 7, 10);
    DestroyObject(Firework[playerid][3]);
    GetObjectPos(Firework[playerid][1], X, Y, Z);
    Firework[playerid][3] = CreateObject(SwitchID(16132), X, Y, Z, 0.0, 0.0, 0.0);
    MoveObject(Firework[playerid][3], X, Y, Z+50, 30.0);
    SetTimerEx("UpFirework3", 1500, false, "%d", playerid);
	return 1;
}

forward UpFirework3(playerid);
public UpFirework3(playerid)
{
    GetObjectPos(Firework[playerid][3], X, Y, Z);
    CreateExplosion(X, Y, Z, 7, 10);
    DestroyObject(Firework[playerid][3]);
    GetObjectPos(Firework[playerid][1], X, Y, Z);
    Firework[playerid][3] = CreateObject(SwitchID(16133), X, Y, Z, 0.0, 0.0, 0.0);
    MoveObject(Firework[playerid][3], X, Y, Z+50, 30.0);
    SetTimerEx("UpFirework4", 1500, false, "%d", playerid);
	return 1;
}

forward UpFirework4(playerid);
public UpFirework4(playerid)
{
    GetObjectPos(Firework[playerid][3], X, Y, Z);
    CreateExplosion(X, Y, Z, 7, 10);
    DestroyObject(Firework[playerid][3]);
    GetObjectPos(Firework[playerid][1], X, Y, Z);
    Firework[playerid][3] = CreateObject(SwitchID(16134), X, Y, Z, 0.0, 0.0, 0.0);
    MoveObject(Firework[playerid][3], X, Y, Z+50, 30.0);
    SetTimerEx("UpFirework5", 1500, false, "%d", playerid);
	return 1;
}

forward UpFirework5(playerid);
public UpFirework5(playerid)
{
    GetObjectPos(Firework[playerid][3], X, Y, Z);
    CreateExplosion(X, Y, Z, 7, 10);
    DestroyObject(Firework[playerid][3]);
    GetObjectPos(Firework[playerid][1], X, Y, Z);
    Firework[playerid][3] = CreateObject(SwitchID(16131), X, Y, Z, 0.0, 0.0, 0.0);
    MoveObject(Firework[playerid][3], X, Y, Z+50, 30.0);
    SetTimerEx("UpFirework6", 1500, false, "%d", playerid);
	return 1;
}

forward UpFirework6(playerid);
public UpFirework6(playerid)
{
    GetObjectPos(Firework[playerid][3], X, Y, Z);
    CreateExplosion(X, Y, Z, 7, 10);
    DestroyObject(Firework[playerid][3]);
    GetObjectPos(Firework[playerid][1], X, Y, Z);
    Firework[playerid][3] = CreateObject(SwitchID(16132), X, Y, Z, 0.0, 0.0, 0.0);
    MoveObject(Firework[playerid][3], X, Y, Z+50, 30.0);
    SetTimerEx("UpFirework7", 1500, false, "%d", playerid);
	return 1;
}

forward UpFirework7(playerid);
public UpFirework7(playerid)
{
    GetObjectPos(Firework[playerid][3], X, Y, Z);
    CreateExplosion(X, Y, Z, 7, 10);
    DestroyObject(Firework[playerid][3]);
    GetObjectPos(Firework[playerid][1], X, Y, Z);
    Firework[playerid][3] = CreateObject(SwitchID(16133), X, Y, Z, 0.0, 0.0, 0.0);
    MoveObject(Firework[playerid][3], X, Y, Z+50, 30.0);
    SetTimerEx("UpFirework8", 1500, false, "%d", playerid);
	return 1;
}

forward UpFirework8(playerid);
public UpFirework8(playerid)
{
    GetObjectPos(Firework[playerid][3], X, Y, Z);
    CreateExplosion(X, Y, Z, 7, 10);
    DestroyObject(Firework[playerid][3]);
    GetObjectPos(Firework[playerid][1], X, Y, Z);
    Firework[playerid][3] = CreateObject(SwitchID(16134), X, Y, Z, 0.0, 0.0, 0.0);
    MoveObject(Firework[playerid][3], X, Y, Z+50, 30.0);
    SetTimerEx("UpFirework9", 1500, false, "%d", playerid);
	return 1;
}

forward UpFirework9(playerid);
public UpFirework9(playerid)
{
    GetObjectPos(Firework[playerid][3], X, Y, Z);
    CreateExplosion(X, Y, Z, 7, 10);
    DestroyObject(Firework[playerid][3]);
    GetObjectPos(Firework[playerid][1], X, Y, Z);
    Firework[playerid][3] = CreateObject(SwitchID(16131), X, Y, Z, 0.0, 0.0, 0.0);
    MoveObject(Firework[playerid][3], X, Y, Z+50, 30.0);
    SetTimerEx("UpFirework10", 1500, false, "%d", playerid);
	return 1;
}

forward UpFirework10(playerid);
public UpFirework10(playerid)
{
    GetObjectPos(Firework[playerid][3], X, Y, Z);
    CreateExplosion(X, Y, Z, 7, 10);
    DestroyObject(Firework[playerid][3]);
    GetObjectPos(Firework[playerid][1], X, Y, Z);
    Firework[playerid][3] = CreateObject(SwitchID(16132), X, Y, Z, 0.0, 0.0, 0.0);
    MoveObject(Firework[playerid][3], X, Y, Z+50, 30.0);
    SetTimerEx("UpFirework11", 1500, false, "%d", playerid);
	return 1;
}

forward UpFirework11(playerid);
public UpFirework11(playerid)
{
    GetObjectPos(Firework[playerid][3], X, Y, Z);
    CreateExplosion(X+10, Y, Z, 7, 10);
    CreateExplosion(X, Y-10, Z, 7, 10);
    CreateExplosion(X, Y, Z, 7, 10);
    CreateExplosion(X, Y+10, Z, 7, 10);
    CreateExplosion(X-10, Y, Z, 7, 10);
    DestroyObject(Firework[playerid][1]);
    DestroyObject(Firework[playerid][3]);
    Firework[playerid][0] = 0;
	return 1;
}

forward UpDynamite1(playerid);
public UpDynamite1(playerid)
{
    GetObjectPos(Dynamite[playerid][1], X, Y, Z);
    DestroyObject(Dynamite[playerid][1]);
    DestroyObject(Dynamite[playerid][2]);
    Dynamite[playerid][3] = CreateObject(SwitchID(16132), X, Y, Z, 0.0, 0.0, 0.0);
    MoveObject(Dynamite[playerid][3], X, Y, Z+30, 30.0);
    SetTimerEx("UpDynamite2", 800, false, "%d", playerid);
	return 1;
}

forward UpDynamite2(playerid);
public UpDynamite2(playerid)
{
	GetObjectPos(Dynamite[playerid][3], X, Y, Z);
	CreateExplosion(X, Y, Z, 7, 10);
	DestroyObject(Dynamite[playerid][3]);
	Dynamite[playerid][4] = CreateObject(SwitchID(16133), X, Y, Z, 0.0, 0.0, 0.0);
	MoveObject(Dynamite[playerid][4], X, Y, Z+30, 30.0);
	SetTimerEx("UpDynamite3", 800, false, "%d", playerid);
	return 1;
}

forward UpDynamite3(playerid);
public UpDynamite3(playerid)
{
	GetObjectPos(Dynamite[playerid][4], X, Y, Z);
	CreateExplosion(X, Y, Z, 7, 10);
	DestroyObject(Dynamite[playerid][4]);
	Dynamite[playerid][4] = CreateObject(SwitchID(16134), X, Y, Z, 0.0, 0.0, 0.0);
	MoveObject(Dynamite[playerid][4], X, Y, Z+30, 30.0);
	SetTimerEx("DynamiteEnd", 800, false, "%d", playerid);
	return 1;
}

forward DynamiteEnd(playerid);
public DynamiteEnd(playerid)
{
	GetObjectPos(Dynamite[playerid][4], X, Y, Z);
    CreateExplosion(X+10, Y, Z, 7, 10);
    CreateExplosion(X, Y-10, Z, 7, 10);
    CreateExplosion(X, Y, Z, 7, 10);
    CreateExplosion(X, Y+10, Z, 7, 10);
    CreateExplosion(X-10, Y, Z, 7, 10);
	DestroyObject(Dynamite[playerid][4]);
	Dynamite[playerid][0] = 0;
	return 1;
}

stock SwitchID(id)
{
    switch(id)
    {
      case 12835 .. 12944: id+=6219;
      case 13590 .. 13667: id+=5142;
      case 14383 .. 14483: id+=4248;
      case 14500 .. 14522: id+=4310;
      case 14770 .. 14856: id+=4063;
      case 14858 .. 14871: id+=4062;
      case 14872 .. 14883: id+=4163;
      case 14885 .. 14891: id+=4162;
      case 14892:id+=5009;
      case 16000 .. 16143: id+=3164;
      case 18000 .. 18036: id+=934;
      case 18038 .. 18101: id+=933;
    }
    return id;
}

//------------------------------------------------------------------------------