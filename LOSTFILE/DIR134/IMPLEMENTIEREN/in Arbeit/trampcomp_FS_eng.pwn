#include <a_samp>

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA

#define MAX_TRAMPOBJECTS 36
new TrampObj[MAX_TRAMPOBJECTS];

new Text:event;
new Text:stats;

new Aktuell[MAX_PLAYER_NAME] = "-----";
new AktuellID = -1;
new Best[MAX_PLAYER_NAME] = "-----";
new BestID = -1;
new Float:BestZ;

new RestVersuche;

new IsInTramp[MAX_PLAYERS];

stock SendClientMessageToAllTramp(color, const message[])
{
	for (new i=0; i<MAX_PLAYERS; i++)
	{
	    if (IsPlayerConnected(i) && IsInTramp[i] == 1) SendClientMessage(i, color, message);
	}
}

public OnFilterScriptInit()
{
	print("\n----------------------------------");
	print("  Trampoline-Competition    [FS VERSION]\n");
	print("   coded by");
	print("   Streetplaya");
	print("----------------------------------\n");
	
	SetTimer("CheckZ", 400, 1);
	SetTimer("Cargod", 2000, 1);
	
	CreateObject(18450, 4215.187500, -4447.947266, 3844.465088, 0.0000, 90.0000, 90.0000);
	CreateObject(18450, 4223.734863, -4439.187012, 3844.310547, 0.0000, 90.0000, 180.0000);
	CreateObject(18450, 4215.116211, -4430.625488, 3844.329346, 0.0000, 90.0000, 270.0000);
	CreateObject(18450, 4207.543945, -4439.146484, 3833.475830, 0.0000, 90.0000, 0.0001);
	CreateObject(18450, 4207.514160, -4439.163086, 3753.627197, 0.0000, 90.0000, 0.0001);
	CreateObject(18450, 4215.178711, -4447.902344, 3764.840820, 0.0000, 90.0000, 90.0000);
	CreateObject(18450, 4223.714844, -4439.193359, 3764.477783, 0.0000, 90.0000, 180.0000);
	CreateObject(18450, 4215.121094, -4430.645508, 3764.473389, 0.0000, 90.0000, 270.0000);
	CreateObject(18450, 4214.293457, -4439.244141, 3724.272217, 0.0000, 0.0000, 0.0000);
	CreateObject(8357, 4100.770508, -4467.158691, 3873.519531, 0.0000, 0.0000, 270.0000);
	CreateObject(8357, 4101.487305, -4439.925781, 3873.491943, 0.0000, 0.0000, 270.0000);
	CreateObject(8357, 4100.825195, -4400.589844, 3873.371094, 0.0000, 0.0000, 270.0000);
	CreateObject(982, 4207.124512, -4459.489746, 3874.209717, 0.0000, 0.0000, 0.0000);
	CreateObject(982, 4207.130371, -4474.220703, 3874.187500, 0.0000, 0.0000, 0.0000);
	CreateObject(982, 4194.310059, -4487.025391, 3874.187500, 0.0000, 0.0000, 270.0000);
	CreateObject(982, 4168.707031, -4487.017578, 3874.187500, 0.0000, 0.0000, 270.0000);
	CreateObject(982, 4145.221680, -4479.913574, 3874.187500, 0.0000, 0.0000, 236.2501);
	CreateObject(982, 4134.497559, -4459.960938, 3874.187500, 0.0000, 0.0000, 180.0000);
	CreateObject(982, 4134.583984, -4434.401367, 3874.209717, 0.0000, 0.0000, 180.0000);
	CreateObject(982, 4134.468262, -4408.733887, 3874.039063, 0.0000, 0.0000, 180.0000);
	CreateObject(982, 4134.491211, -4393.614258, 3874.039063, 0.0000, 0.0000, 180.0000);
	CreateObject(982, 4147.253906, -4380.710449, 3874.039063, 0.0000, 0.0000, 90.0000);
	CreateObject(982, 4172.881836, -4380.690918, 3874.039063, 0.0000, 0.0000, 90.0000);
	CreateObject(982, 4194.216797, -4380.679688, 3874.039063, 0.0000, 0.0000, 90.0000);
	CreateObject(982, 4207.113770, -4393.473633, 3874.039063, 0.0000, 0.0000, 180.0000);
	CreateObject(982, 4207.011230, -4419.150879, 3874.209717, 0.0000, 0.0000, 180.0000);
	CreateObject(982, 4194.180176, -4431.906738, 3874.209717, 0.0000, 0.0000, 270.0000);
	CreateObject(982, 4194.372559, -4446.796875, 3874.209717, 0.0000, 0.0000, 270.0000);
	CreateObject(9241, 4224.379883, -4403.632813, 3887.250244, 0.0000, 0.0000, 0.0000);
	CreateObject(972, 4242.000000, -4409.609863, 3899.708252, 0.0000, 270.0000, 0.0000);
	CreateObject(972, 4235.013672, -4409.613281, 3899.721191, 0.0000, 270.0000, 0.0000);
	CreateObject(972, 4227.775391, -4409.602539, 3899.734131, 0.0000, 270.0000, 0.0000);
	CreateObject(972, 4220.529297, -4409.656738, 3899.701172, 0.0000, 270.0000, 0.0000);
	CreateObject(972, 4213.395996, -4409.629883, 3899.743896, 0.0000, 270.0000, 0.0000);
	CreateObject(972, 4231.673828, -4388.061523, 3899.697266, 0.0000, 270.0000, 90.0000);
	CreateObject(972, 4220.821289, -4388.081055, 3899.691162, 0.0000, 270.0000, 90.0000);
	CreateObject(975, 4208.468750, -4392.068848, 3887.190674, 0.0000, 0.0000, 90.0000);
	CreateObject(975, 4208.463867, -4400.845703, 3887.190674, 0.0000, 0.0000, 90.0000);
	CreateObject(975, 4208.495605, -4409.641602, 3887.190674, 0.0000, 0.0000, 90.0000);
	CreateObject(975, 4208.507813, -4414.914551, 3887.190674, 0.0000, 0.0000, 90.0000);
	CreateObject(975, 4212.948242, -4419.363281, 3887.190674, 0.0000, 0.0000, 180.0000);
	CreateObject(975, 4221.708496, -4419.387695, 3887.190674, 0.0000, 0.0000, 180.0000);
	CreateObject(975, 4230.534668, -4419.383301, 3887.190674, 0.0000, 0.0000, 180.0000);
	CreateObject(975, 4235.647461, -4419.393555, 3887.190674, 0.0000, 0.0000, 180.0000);
	CreateObject(975, 4239.917480, -4415.079590, 3887.197998, 0.0000, 0.0000, 270.0000);
	CreateObject(975, 4239.890137, -4406.276367, 3887.197998, 0.0000, 0.0000, 270.0000);
	CreateObject(975, 4239.834961, -4397.548340, 3887.197998, 0.0000, 0.0000, 270.0000);
	CreateObject(975, 4239.841309, -4392.265137, 3887.197998, 0.0000, 0.0000, 270.0000);
	CreateObject(975, 4235.592285, -4387.835938, 3887.190674, 0.0000, 0.0000, 0.0000);
	CreateObject(975, 4226.980469, -4387.868164, 3887.190674, 0.0000, 0.0000, 0.0000);
	CreateObject(975, 4218.212891, -4387.856445, 3887.190674, 0.0000, 0.0000, 0.0000);
	CreateObject(975, 4212.864258, -4387.820313, 3887.190674, 0.0000, 0.0000, 0.0000);
	CreateObject(8483, 4006.938477, -4460.760742, 3879.262695, 0.0000, 0.0000, 0.0000);
	CreateObject(3524, 4013.708740, -4468.456055, 3876.389160, 0.0000, 0.0000, 90.0000);
	CreateObject(3524, 4013.318359, -4454.845703, 3876.389160, 0.0000, 0.0000, 90.0000);
	CreateObject(14608, 4015.619141, -4472.825684, 3875.102539, 0.0000, 0.0000, 270.0000);
	CreateObject(14608, 4014.813965, -4451.106934, 3875.077637, 0.0000, 0.0000, 180.0000);

	TrampObj[0] = CreateObject(2918, 4209.619141, -4445.415527, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[1] = CreateObject(2918, 4209.592773, -4442.790527, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[2] = CreateObject(2918, 4209.575195, -4440.233398, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[3] = CreateObject(2918, 4209.572754, -4437.665527, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[4] = CreateObject(2918, 4209.582520, -4435.061523, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[5] = CreateObject(2918, 4209.650391, -4432.553223, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[6] = CreateObject(2918, 4212.293457, -4445.439941, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[7] = CreateObject(2918, 4212.156738, -4442.785156, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[8] = CreateObject(2918, 4212.151855, -4440.295898, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[9] = CreateObject(2918, 4212.104004, -4437.639648, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[10] = CreateObject(2918, 4212.104492, -4435.038086, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[11] = CreateObject(2918, 4212.163574, -4432.553711, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[12] = CreateObject(2918, 4214.957520, -4445.426758, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[13] = CreateObject(2918, 4214.770996, -4442.789063, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[14] = CreateObject(2918, 4214.765137, -4440.182129, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[15] = CreateObject(2918, 4214.773926, -4437.664551, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[16] = CreateObject(2918, 4214.776855, -4435.030273, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[17] = CreateObject(2918, 4214.839355, -4432.479980, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[18] = CreateObject(2918, 4217.555664, -4445.409668, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[19] = CreateObject(2918, 4217.464844, -4442.952148, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[20] = CreateObject(2918, 4217.467773, -4440.334473, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[21] = CreateObject(2918, 4217.464844, -4437.730957, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[22] = CreateObject(2918, 4217.459473, -4435.082520, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[23] = CreateObject(2918, 4217.476074, -4432.460449, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[24] = CreateObject(2918, 4220.080078, -4445.288574, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[25] = CreateObject(2918, 4220.070801, -4442.980469, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[26] = CreateObject(2918, 4220.074219, -4440.384766, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[27] = CreateObject(2918, 4220.063965, -4437.750488, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[28] = CreateObject(2918, 4220.056152, -4435.130371, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[29] = CreateObject(2918, 4220.079102, -4432.562012, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[30] = CreateObject(2918, 4222.311523, -4445.277832, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[31] = CreateObject(2918, 4222.276855, -4442.981934, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[32] = CreateObject(2918, 4222.447266, -4440.392090, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[33] = CreateObject(2918, 4222.353516, -4437.750977, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[34] = CreateObject(2918, 4222.226563, -4435.124023, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[35] = CreateObject(2918, 4222.225098, -4432.553223, 3726.707031, 0.0000, 0.0000, 0.0000);

	event = TextDrawCreate(7.0, 425.0, "TrampCompetition by ~r~Streetplaya");
	TextDrawUseBox(event, 0);
	TextDrawFont(event, 3);
	TextDrawSetShadow(event, 0);
	TextDrawSetOutline(event, 1);
	TextDrawBackgroundColor(event, 0x000000FF);
	TextDrawColor(event, 0xFFFFFFFF);

	stats = TextDrawCreate(400.0, 400.0, "Now: -----~n~Best: -----~n~         (0 ft)");
	TextDrawUseBox(stats, 0);
	TextDrawFont(stats, 3);
	TextDrawSetShadow(stats, 0);
	TextDrawSetOutline(stats, 1);
	TextDrawBackgroundColor(stats, 0x000000FF);
	TextDrawColor(stats, 0xFFFFFFFF);
}

//------------------------------------------------------------------------------------------------------

stock RefreshStats()
{
	new tmp[256];
	format(tmp, sizeof(tmp), "Now: %s~n~Best: %s~n~         (%d ft)", Aktuell, Best, floatround(BestZ));
	TextDrawSetString(stats, tmp);
}

forward CheckZ();
public CheckZ()
{
	new Float:Pos[3];
	for (new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i) && AktuellID == i && IsInTramp[i] == 1)
		{
			GetPlayerPos(i, Pos[0], Pos[1], Pos[2]);
			if (Pos[2] - 3725.6160 > BestZ && Pos[2] > 3877.0)
			{
			    BestID = i;
				GetPlayerName(i, Best, sizeof(Best));
				BestZ = Pos[2] - 3725.6160;
				RefreshStats();
			}
		}
	}
	
	return 1;
}

forward Cargod();
public Cargod()
{
	new Float:vhealth;
	for (new i=0; i<MAX_PLAYERS; i++)
	{
	    GetVehicleHealth(GetPlayerVehicleID(i), vhealth);
	    if (IsPlayerConnected(i) && IsPlayerInAnyVehicle(i) && vhealth < 1000.0 && IsInTramp[i] == 1)
	    {
	        SetVehicleHealth(GetPlayerVehicleID(i), 1000.0);
	    }
	}
	return 1;
}
																																																								public OnPlayerConnect(playerid)return SendClientMessage(playerid,COLOR_GREEN,"* Auf diesem Server läuft der Trampolinwettbewerb by Streetplaya. Tippe /tramp um teilzunehmen.");
public OnPlayerDisconnect(playerid, reason)
{
	TextDrawHideForPlayer(playerid, event);
	TextDrawShowForPlayer(playerid, stats);
	
	if (AktuellID == playerid)
	{
	    AktuellID = -1;
	    Aktuell = "-----";
	    RestVersuche = 0;
	}
	
	if (BestID == playerid)
	{
	    BestID = -1;
	    Best = "-----";
	    BestZ = 0.0;
	}
	
	if (IsInTramp[playerid] == 1) IsInTramp[playerid] = 0;

	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp(cmdtext, "/tramp", true) == 0)
	{
	    if (IsInTramp[playerid] == 0)
	    {
	        IsInTramp[playerid] = 1;
	        TextDrawShowForPlayer(playerid, event);
			TextDrawShowForPlayer(playerid, stats);
	    }
	    SetPlayerPos(playerid, 4171.8179,-4439.1172,3874.5261);
	    SetPlayerFacingAngle(playerid, 270.0);
	    SetCameraBehindPlayer(playerid);
	    return 1;
	}
	
	if (strcmp(cmdtext, "/trampexit", true) == 0 && IsInTramp[playerid] == 1)
	{
	    IsInTramp[playerid] = 0;
		TextDrawHideForPlayer(playerid, event);
		TextDrawHideForPlayer(playerid, stats);
		SetPlayerHealth(playerid, 0.0);
		SendClientMessage(playerid, COLOR_YELLOW, "*** You have left the Trampoline Competition.");
	    return 1;
	}
	
	new cmd[256], idx;
	cmd = strtok(cmdtext, idx);
	
	if (strcmp(cmd, "/setnow", true) == 0 && IsPlayerAdmin(playerid) && IsInTramp[playerid] == 1)
	{
		new tmp[256];
		tmp = strtok(cmdtext, idx);

		if (!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "* Syntax: /setnow [playerid]");

		new giveplayerid = strval(tmp);
		if (!IsPlayerConnected(giveplayerid) || IsInTramp[giveplayerid] == 0) return SendClientMessage(playerid, COLOR_RED, "*** Invalid player!");
		if (AktuellID == giveplayerid) return SendClientMessage(playerid, COLOR_RED, "*** This player is already on.");

		new giveplayer[MAX_PLAYER_NAME];
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));

		AktuellID = giveplayerid;
		Aktuell = giveplayer;
		RestVersuche = 5;
		
		CleanTramp();

		new str[256];
		format(str, sizeof(str), "*** %s, you are on now. You have 5 tries.", Aktuell);
		SendClientMessageToAll(COLOR_YELLOW, str);
		
		RefreshStats();

		return 1;
	}
	
	if (strcmp(cmd, "/resetnow", true) == 0 && IsPlayerAdmin(playerid) && IsInTramp[playerid] == 1)
	{
	    if (AktuellID != -1)
	    {
		    AktuellID = -1;
		    Aktuell = "-----";
		    RestVersuche = 0;
		    RefreshStats();
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, "*** There is no player on!");
		}
	    return 1;
	}
	
	if (strcmp(cmd, "/gettries", true) == 0)
	{
	    if (AktuellID != -1)
	    {
		    new str[256];
		    format(str, sizeof(str), "*** %s has %d tries left.", Aktuell, RestVersuche);
		    SendClientMessage(playerid, COLOR_YELLOW, str);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, "*** There is no player on!");
		}
	    return 1;
	}
	
	if (strcmp(cmd, "/settries", true) == 0 && IsPlayerAdmin(playerid) && IsInTramp[playerid] == 1)
	{
	    new tmp[256];
	    tmp = strtok(cmdtext, idx);
	    
	    if (!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "* Syntax: /settries [difference (+/-)]");
	    if (AktuellID == -1) return SendClientMessage(playerid, COLOR_RED, "*** There is no player on!");
	    
	    new differenz = strval(tmp);
	    if (differenz < 0 || differenz > 0)
	    {
	        RestVersuche += differenz;
	        new str[256];
	        format(str, sizeof(str), "*** %s has %d tries left.", Aktuell, RestVersuche);
	        SendClientMessageToAll(COLOR_YELLOW, str);
	    }
	    else
	    {
	        SendClientMessage(playerid, COLOR_RED, "*** Invalid difference!");
	    }
	    
	    return 1;
	}
	
	if (strcmp(cmd, "/resetbest", true) == 0 && IsPlayerAdmin(playerid) && IsInTramp[playerid] == 1)
	{
	    if (BestID != -1)
	    {
	        BestID = -1;
	        Best = "-----";
	        BestZ = 0.0;
	        RefreshStats();
	    }
	    else
	    {
	        SendClientMessage(playerid, COLOR_RED, "*** There is no best player!");
	    }
	    
	    return 1;
	}
	
	if (strcmp(cmd, "/nexttry", true) == 0 && IsPlayerAdmin(playerid) && IsInTramp[playerid] == 1)
	{
	    if (AktuellID == -1) return SendClientMessage(playerid, COLOR_RED, "*** There is no player on!");
	    
	    RestVersuche--;

	    if (RestVersuche > 0)
	    {
			SetPlayerPos(AktuellID, 4171.8179,-4439.1172,3874.5261);
			SetPlayerFacingAngle(AktuellID, 270.0);
	    	SetCameraBehindPlayer(AktuellID);
	    	
		    new str[256];
		    format(str, sizeof(str), "*** %s has %d tries left.", Aktuell, RestVersuche);
		    SendClientMessageToAll(COLOR_YELLOW, str);
		}
		else
		{
		    new str[256];
		    format(str, sizeof(str), "*** %s has no more tries.", Aktuell);

			AktuellID = -1;
		    Aktuell = "-----";
		    RestVersuche = 0;
		    RefreshStats();
		    
		    SendClientMessageToAll(COLOR_YELLOW, str);
		}
		
		CleanTramp();
		
	    return 1;
	}
	
	if (strcmp(cmd, "/invalid", true) == 0 && IsPlayerAdmin(playerid) && IsInTramp[playerid] == 1)
	{
	    if (AktuellID == -1) return SendClientMessage(playerid, COLOR_RED, "*** There is no player on!");
	    
	    SetPlayerPos(AktuellID, 4171.8179,-4439.1172,3874.5261);
	    SetPlayerFacingAngle(AktuellID, 270.0);
	    SetCameraBehindPlayer(AktuellID);
	    
	    new str[256];
	    format(str, sizeof(str), "*** %s's try was invalid. Repeat.", Aktuell);
	    SendClientMessageToAll(COLOR_YELLOW, str);
	    
	    CleanTramp();
	    
	    return 1;
	}
	
	if (strcmp(cmd, "/cleantramp", true) == 0 && IsPlayerAdmin(playerid) && IsInTramp[playerid] == 1)
	{
		CleanTramp();
	    return 1;
	}
	
	/*  (!!!) dont use this - i picked the wrong coordinates from mta
	if (strcmp(cmd, "/specplace", true) == 0 && IsPlayerAdmin(playerid) && IsInTramp[playerid] == 1)
	{
	    SetPlayerPos(playerid, 4220.295410, -4419.451172, 3889.328369);
	    SetPlayerFacingAngle(playerid, 133.0);
	    SetCameraBehindPlayer(playerid);
	    return 1;
	}
	*/
	
	return 0;
}

stock CleanTramp()
{
    for (new i=0; i<MAX_TRAMPOBJECTS; i++)
    {
        DestroyObject(TrampObj[i]);
    }
    TrampObj[0] = CreateObject(2918, 4209.619141, -4445.415527, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[1] = CreateObject(2918, 4209.592773, -4442.790527, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[2] = CreateObject(2918, 4209.575195, -4440.233398, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[3] = CreateObject(2918, 4209.572754, -4437.665527, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[4] = CreateObject(2918, 4209.582520, -4435.061523, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[5] = CreateObject(2918, 4209.650391, -4432.553223, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[6] = CreateObject(2918, 4212.293457, -4445.439941, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[7] = CreateObject(2918, 4212.156738, -4442.785156, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[8] = CreateObject(2918, 4212.151855, -4440.295898, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[9] = CreateObject(2918, 4212.104004, -4437.639648, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[10] = CreateObject(2918, 4212.104492, -4435.038086, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[11] = CreateObject(2918, 4212.163574, -4432.553711, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[12] = CreateObject(2918, 4214.957520, -4445.426758, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[13] = CreateObject(2918, 4214.770996, -4442.789063, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[14] = CreateObject(2918, 4214.765137, -4440.182129, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[15] = CreateObject(2918, 4214.773926, -4437.664551, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[16] = CreateObject(2918, 4214.776855, -4435.030273, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[17] = CreateObject(2918, 4214.839355, -4432.479980, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[18] = CreateObject(2918, 4217.555664, -4445.409668, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[19] = CreateObject(2918, 4217.464844, -4442.952148, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[20] = CreateObject(2918, 4217.467773, -4440.334473, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[21] = CreateObject(2918, 4217.464844, -4437.730957, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[22] = CreateObject(2918, 4217.459473, -4435.082520, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[23] = CreateObject(2918, 4217.476074, -4432.460449, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[24] = CreateObject(2918, 4220.080078, -4445.288574, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[25] = CreateObject(2918, 4220.070801, -4442.980469, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[26] = CreateObject(2918, 4220.074219, -4440.384766, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[27] = CreateObject(2918, 4220.063965, -4437.750488, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[28] = CreateObject(2918, 4220.056152, -4435.130371, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[29] = CreateObject(2918, 4220.079102, -4432.562012, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[30] = CreateObject(2918, 4222.311523, -4445.277832, 3726.707031, 0.0000, 0.0000, 0.0000);
	TrampObj[31] = CreateObject(2918, 4222.276855, -4442.981934, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[32] = CreateObject(2918, 4222.447266, -4440.392090, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[33] = CreateObject(2918, 4222.353516, -4437.750977, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[34] = CreateObject(2918, 4222.226563, -4435.124023, 3726.505127, 0.0000, 0.0000, 0.0000);
	TrampObj[35] = CreateObject(2918, 4222.225098, -4432.553223, 3726.707031, 0.0000, 0.0000, 0.0000);
	new Float:vPos[3];
	for (new i=0; i<MAX_VEHICLES; i++)
	{
	    GetVehiclePos(i, vPos[0], vPos[1], vPos[2]);
	    if (vPos[2] <= 3735.0)
	    {
		    for (new j=0; j<MAX_PLAYERS; j++)
		    {
		        if (IsPlayerConnected(j) && IsPlayerInVehicle(j, i))
		        {
					SetPlayerPos(j, 4171.8179,-4439.1172,3874.5261);
		        }
		    }
		    SetTimerEx("InitDestroyVehicle", 1500, 0, "i", i);
		}
	}
	SendClientMessageToAllTramp(COLOR_WHITE, "*** The Trampoline has been cleaned.");
}

public OnPlayerSpawn(playerid)
{
	if (IsInTramp[playerid] == 1)
	{
		SetPlayerPos(playerid, 4171.8179,-4439.1172,3874.5261);
		SetPlayerFacingAngle(playerid, 270.0);
		SetCameraBehindPlayer(playerid);
	}
	return 1;
}

public OnVehicleDeath(vehicleid)
{
	new destroy = 0;
	for (new i=0; i<MAX_PLAYERS; i++)
	{
	    if (IsPlayerConnected(i) && IsPlayerInVehicle(i, vehicleid) && IsInTramp[i] == 1)
	    {
	        destroy = 1;
	    	SetPlayerPos(i, 4171.8179,-4439.1172,3874.5261);
		    SetPlayerFacingAngle(i, 270.0);
		    SetCameraBehindPlayer(i);
	    }
	}
	if (destroy == 1) SetTimerEx("InitDestroyVehicle", 2000, 0, "i", vehicleid);
	return 1;
}

forward InitDestroyVehicle(vehicleid);
public InitDestroyVehicle(vehicleid)
{
	DestroyVehicle(vehicleid);
	return 1;
}

strtok (const string[], &index, const seperator[] = " ")
{
	new	index2,	result[30];
	index2 =  strfind(string, seperator, false, index);
	if(index2 == -1)
	{
		if(strlen(string) > index)
		{
			strmid(result, string, index, strlen(string), 30);
			index = strlen(string);
		}
		return result;
	}
	if(index2 > (index + 29))
	{
		index2 = index + 29;
		strmid(result, string, index, index2, 30);
		index = index2;
		return result;
	}
	strmid(result, string, index, index2, 30);
	index = index2 + 1;
	return result;
}

