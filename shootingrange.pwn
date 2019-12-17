//Include
#include <a_samp>

//Definicje kolorow
#define RED 0xFF0000AA
#define GREEN 0x33AA33AA
#define WHITE 0xFFFFFFFF

//Enum'y
enum GraczeInfo
{
	Float:MiejsceXYZ[3],
	IDButelek[10],
	Punkty,
	TimerCzas,
	TimerWynik,
	TimerSprawdz[2],
	TimerDelay[9],
	bool:NaStrzelnicy,
	bool:ZaladowaneAnimacje
}

//Tablice
new Rangi[11][30] =
{
	"pussy", "lame", "newbie", "low", "average", "med", "good", "high", "phat", "pro", "cheater"
};

new GraczInfo[MAX_PLAYERS][GraczeInfo];

//Zmienne
new TimerSprawdzPozycje;

//Forward'y (Timer'y)
forward SprawdzPozycje();

//Forward'y (Timer'y Ex)
forward KoniecCzasu(playerid);
forward WyswietlWynik(playerid);
forward Sprawdz(playerid);
forward Delay(playerid, Numer);
forward Sprawdz2(playerid, Float:X, Float:Y, Float:Z);

//Callback'i
public OnFilterScriptInit()
{
	AllowInteriorWeapons(1);
	TimerSprawdzPozycje = SetTimer("SprawdzPozycje", 1000, 1);
	print("\n----------------------------------\n     Rifle Range by Przemcio\n--------------Loaded--------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	KillTimer(TimerSprawdzPozycje);
	print("\n----------------------------------\n     Rifle Range by Przemcio\n-------------Unloaded-------------\n");
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(GraczInfo[playerid][ZaladowaneAnimacje] == false)
	{
	    PreloadAnimLib(playerid, "COP_AMBIENT");
	    GraczInfo[playerid][ZaladowaneAnimacje] = true;
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if(strcmp(cmdtext, "/riflerange", true) == 0)
	{
	    SetPlayerPos(playerid, 297.0035, -64.6454, 1001.5156);
	    SetPlayerFacingAngle(playerid, 267.8259);
	    SetPlayerInterior(playerid, 4);
	    GameTextForPlayer(playerid,"~b~Welcome ~y~to ~r~Rifle Range.", 3000, 5);
		return 1;
	}
	if(strcmp(cmdtext, "/start range", true) == 0)
	{
	    if(NaMiejscu(playerid))
	    {
	        if(GraczInfo[playerid][NaStrzelnicy] == false)
	        {
	        	GraczInfo[playerid][NaStrzelnicy] = true;
	        	GetPlayerPos(playerid, GraczInfo[playerid][MiejsceXYZ][0], GraczInfo[playerid][MiejsceXYZ][1], GraczInfo[playerid][MiejsceXYZ][2]);
	        	GraczInfo[playerid][IDButelek][0] = CreatePlayerObject(playerid, 1543, 316.22, -68.37, 1002.01, 0.0, 0.0, 0.0);
	        	GraczInfo[playerid][IDButelek][1] = CreatePlayerObject(playerid, 1543, 316.21, -62.79, 1002.01, 0.0, 0.0, 0.0);
	        	GraczInfo[playerid][IDButelek][2] = CreatePlayerObject(playerid, 1543, 316.23, -61.17, 1002.00, 0.0, 0.0, 0.0);
	        	GraczInfo[playerid][IDButelek][3] = CreatePlayerObject(playerid, 1543, 316.20, -63.37, 1002.01, 0.0, 0.0, 0.0);
	        	GraczInfo[playerid][IDButelek][4] = CreatePlayerObject(playerid, 1543, 316.24, -62.04, 1002.01, 0.0, 0.0, 0.0);
	        	GraczInfo[playerid][IDButelek][5] = CreatePlayerObject(playerid, 1543, 316.27, -64.73, 1002.01, 0.0, 0.0, 0.0);
	        	GraczInfo[playerid][IDButelek][6] = CreatePlayerObject(playerid, 1543, 316.23, -60.27, 1002.01, 0.0, 0.0, 0.0);
	        	GraczInfo[playerid][IDButelek][7] = CreatePlayerObject(playerid, 1543, 316.20, -65.54, 1002.01, 0.0, 0.0, 0.0);
	        	GraczInfo[playerid][IDButelek][8] = CreatePlayerObject(playerid, 1543, 316.21, -66.46, 1002.01, 0.0, 0.0, 0.0);
	        	GraczInfo[playerid][IDButelek][9] = CreatePlayerObject(playerid, 1543, 316.08, -67.37, 1002.01, 0.0, 0.0, 0.0);
	        	GivePlayerWeapon(playerid, 24, 35);
	        	GameTextForPlayer(playerid,"~b~You have 10 ~y~seconds ~w~to ~r~destroy all ~b~bottles.", 3000, 5);
	        	GraczInfo[playerid][TimerCzas] = SetTimerEx("KoniecCzasu", 10000, 0, "d", playerid);
			}
			else
			    SendClientMessage(playerid, RED, "You already are in Rifle Range!");
	    }
	    else
	        SendClientMessage(playerid, RED, "You are not in Rifle Range!");
		return 1;
	}
	return 0;
}

//Timer'y
public SprawdzPozycje()
{
	for(new i, Max = GetMaxPlayers(); i < Max; i++)
		if(IsPlayerConnected(i) && GraczInfo[i][NaStrzelnicy] == true)
		{
		    new Float:Koordy[3];
		    GetPlayerPos(i, Koordy[0], Koordy[1], Koordy[2]);
			if(!PlayerToPoint(1.0, Koordy[0], Koordy[1], Koordy[2], GraczInfo[i][MiejsceXYZ][0], GraczInfo[i][MiejsceXYZ][1], GraczInfo[i][MiejsceXYZ][2]))
			{
			    GraczInfo[i][NaStrzelnicy] = false;
			    KillTimer(GraczInfo[i][TimerCzas]);
			    SendClientMessage(i, RED, "You abondoned Rifle Range.");
			    for(new g; g < 10; g++)
					DestroyPlayerObject(i, GraczInfo[i][IDButelek][g]);
			}
		}
	return 1;
}

//Timer'y Ex
public KoniecCzasu(playerid)
{
    SendClientMessage(playerid, WHITE, "Checking how many bottles you destroyed...");
    GraczInfo[playerid][NaStrzelnicy] = false;
	IsDestroyed(playerid, GraczInfo[playerid][IDButelek][0]);
    GraczInfo[playerid][TimerDelay][0] = SetTimerEx("Delay", 1000, 0, "di", playerid, 0);
    GraczInfo[playerid][TimerDelay][1] = SetTimerEx("Delay", 2000, 0, "di", playerid, 1);
    GraczInfo[playerid][TimerDelay][2] = SetTimerEx("Delay", 3000, 0, "di", playerid, 2);
    GraczInfo[playerid][TimerDelay][3] = SetTimerEx("Delay", 4000, 0, "di", playerid, 3);
    GraczInfo[playerid][TimerDelay][4] = SetTimerEx("Delay", 5000, 0, "di", playerid, 4);
    GraczInfo[playerid][TimerDelay][5] = SetTimerEx("Delay", 6000, 0, "di", playerid, 5);
    GraczInfo[playerid][TimerDelay][6] = SetTimerEx("Delay", 7000, 0, "di", playerid, 6);
    GraczInfo[playerid][TimerDelay][7] = SetTimerEx("Delay", 8000, 0, "di", playerid, 7);
    GraczInfo[playerid][TimerDelay][8] = SetTimerEx("Delay", 9000, 0, "di", playerid, 8);
    GraczInfo[playerid][TimerWynik] = SetTimerEx("WyswietlWynik", 9500, 0, "di", playerid);
	KillTimer(GraczInfo[playerid][TimerCzas]);
	return 1;
}

public WyswietlWynik(playerid)
{
	new str[80];
	format(str, sizeof(str), "You destroyed %i bottle(s). You are %s.", GraczInfo[playerid][Punkty], Rangi[GraczInfo[playerid][Punkty]]);
	SendClientMessage(playerid, GREEN, str);
	GraczInfo[playerid][Punkty] = 0;
	for(new g; g < 10; g++)
		DestroyPlayerObject(playerid, GraczInfo[playerid][IDButelek][g]);
    SetPlayerPos(playerid, 297.0035, -64.6454, 1001.5156);
    SetPlayerFacingAngle(playerid, 267.8259);
    ClearAnimations(playerid);
	KillTimer(GraczInfo[playerid][TimerWynik]);
	return 1;
}

public Sprawdz(playerid)
{
	new Float:Koordy[3];
	GetPlayerPos(playerid, Koordy[0], Koordy[1], Koordy[2]);
	GraczInfo[playerid][TimerSprawdz][1] = SetTimerEx("Sprawdz2", 300, 0, "dfff", playerid, Koordy[0], Koordy[1], Koordy[2]);
	KillTimer(GraczInfo[playerid][TimerSprawdz][0]);
	return 1;
}

public Delay(playerid, Numer)
{
	IsDestroyed(playerid, GraczInfo[playerid][IDButelek][Numer + 1]);
	KillTimer(GraczInfo[playerid][TimerDelay][Numer]);
	return 1;
}

public Sprawdz2(playerid, Float:X, Float:Y, Float:Z)
{
	new Float:Koordy[3];
	GetPlayerPos(playerid, Koordy[0], Koordy[1], Koordy[2]);
	if(Koordy[2] != Z)
	    GraczInfo[playerid][Punkty]++;
    KillTimer(GraczInfo[playerid][TimerSprawdz][1]);
	return 1;
}

//Funkcje
IsDestroyed(playerid, objectid) //By Przemcio
{
	new Float:Koordy[3];
	GetPlayerObjectPos(playerid, objectid, Koordy[0], Koordy[1], Koordy[2]);
	SetPlayerPos(playerid, Koordy[0], Koordy[1], Koordy[2] + 1.0);
	ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 1, 0, 0, 0, 0);
	GraczInfo[playerid][TimerSprawdz][0] = SetTimerEx("Sprawdz", 200, 0, "d", playerid);
}

NaMiejscu(playerid) //By Przemcio
{
	new Float:Koordy[3];
	GetPlayerPos(playerid, Koordy[0], Koordy[1], Koordy[2]);
	if(PlayerToPoint(1.0, Koordy[0], Koordy[1], Koordy[2], 303.0314, -59.5103, 1001.5156))
	    return 1;
	if(PlayerToPoint(1.0, Koordy[0], Koordy[1], Koordy[2], 303.0366, -61.0927, 1001.5156))
	    return 1;
	if(PlayerToPoint(1.0, Koordy[0], Koordy[1], Koordy[2], 303.0366, -62.6974, 1001.5156))
	    return 1;
	if(PlayerToPoint(1.0, Koordy[0], Koordy[1], Koordy[2], 303.0355, -64.1932, 1001.5156))
	    return 1;
	if(PlayerToPoint(1.0, Koordy[0], Koordy[1], Koordy[2], 303.0366, -65.7419, 1001.5156))
	    return 1;
	if(PlayerToPoint(1.0, Koordy[0], Koordy[1], Koordy[2], 303.0360, -67.2593, 1001.5156))
	    return 1;
	if(PlayerToPoint(1.0, Koordy[0], Koordy[1], Koordy[2], 303.0310, -68.7007, 1001.5156))
	    return 1;
	if(PlayerToPoint(1.0, Koordy[0], Koordy[1], Koordy[2], 303.0313, -70.0897, 1001.5156))
	    return 1;
	return 0;
}

PreloadAnimLib(playerid, animlib[]) //Stolen from vactions.pwn
	ApplyAnimation(playerid, animlib, "null", 0.0, 0, 0, 0, 0, 0);

PlayerToPoint(Float:radi, Float:PlayerPosX, Float:PlayerPosY, Float:PlayerPosZ, Float:x, Float:y, Float:z) //Optimized by Przemcio
{
	new Float:tempposx, Float:tempposy, Float:tempposz;
	tempposx = (PlayerPosX - x);
	tempposy = (PlayerPosY - y);
	tempposz = (PlayerPosZ - z);
	if(((tempposx < radi) && (tempposx > - radi)) && ((tempposy < radi) && (tempposy > - radi)) && ((tempposz < radi) && (tempposz > - radi)))
		return 1;
	return 0;
}