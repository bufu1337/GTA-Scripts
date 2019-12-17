#include <a_samp>

#define COLOR_RED 0xFF6A6AFF

new IsInAt[MAX_PLAYERS];
new Timer1[MAX_PLAYERS];
new Timer2[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("  ===== New At-400 Interior By S1k Loaded Sucessfully! =======");
CreateObject(3983, 3080.167236, 412.809448, 26.920828, 0.0000, 0.0000, 0.0000);
CreateObject(14405, 3092.130371, 417.937408, 25.537750, 0.0000, 0.0000, 0.0000);
CreateObject(14405, 3092.107178, 415.923859, 25.537750, 0.0000, 0.0000, 0.0000);
CreateObject(14405, 3091.999268, 414.097870, 25.537750, 0.0000, 0.0000, 0.0000);
CreateObject(14405, 3091.913574, 412.592255, 25.537750, 0.0000, 0.0000, 0.0000);
CreateObject(14405, 3091.933350, 411.103485, 25.537750, 0.0000, 0.0000, 0.0000);
CreateObject(14405, 3091.866455, 409.406067, 25.537750, 0.0000, 0.0000, 0.0000);
CreateObject(14405, 3091.696045, 407.846619, 25.537750, 0.0000, 0.0000, 0.0000);
CreateObject(1562, 3092.071289, 423.309082, 25.552582, 0.0000, 0.0000, 180.0000);
CreateObject(1562, 3092.058838, 421.298859, 25.552582, 0.0000, 0.0000, 180.0000);
CreateObject(1562, 3091.968262, 419.365875, 25.552582, 0.0000, 0.0000, 180.0000);
CreateObject(1562, 3091.916016, 417.959869, 25.552582, 0.0000, 0.0000, 180.0000);
CreateObject(1562, 3091.914551, 416.410980, 25.552582, 0.0000, 0.0000, 180.0000);
CreateObject(1562, 3091.831787, 414.732880, 25.552582, 0.0000, 0.0000, 180.0000);
CreateObject(1562, 3091.686523, 413.192413, 25.552582, 0.0000, 0.0000, 180.0000);
CreateObject(14405, 3088.388672, 418.030548, 25.537750, 0.0000, 0.0000, 0.0000);
CreateObject(14405, 3088.338135, 416.240112, 25.537750, 0.0000, 0.0000, 0.0000);
CreateObject(14405, 3088.056152, 414.083557, 25.537750, 0.0000, 0.0000, 0.0000);
CreateObject(14405, 3087.893066, 412.525421, 25.537750, 0.0000, 0.0000, 0.0000);
CreateObject(14405, 3087.954346, 410.982269, 25.537750, 0.0000, 0.0000, 0.0000);
CreateObject(14405, 3088.017334, 409.243744, 25.537750, 0.0000, 0.0000, 0.0000);
CreateObject(14405, 3087.944824, 407.619171, 25.537750, 0.0000, 0.0000, 0.0000);
CreateObject(1562, 3088.389648, 423.375671, 25.552582, 0.0000, 0.0000, 180.0000);
CreateObject(1562, 3088.354736, 421.593140, 25.552582, 0.0000, 0.0000, 180.0000);
CreateObject(1562, 3088.058350, 419.427765, 25.552582, 0.0000, 0.0000, 180.0000);
CreateObject(1562, 3087.850830, 417.861267, 25.552582, 0.0000, 0.0000, 180.0000);
CreateObject(1562, 3087.903564, 416.310974, 25.552582, 0.0000, 0.0000, 180.0000);
CreateObject(1562, 3087.990967, 414.586029, 25.618086, 0.0000, 0.0000, 180.0000);
CreateObject(1562, 3087.906738, 412.923920, 25.606647, 0.0000, 0.0000, 180.0000);
CreateObject(2631, 3090.189941, 421.599945, 24.943718, 0.0000, 0.0000, 270.0000);
CreateObject(2631, 3090.061768, 417.784637, 24.943718, 0.0000, 0.0000, 90.0000);
CreateObject(2631, 3089.946533, 414.246338, 24.943718, 0.0000, 0.0000, 90.0000);
CreateObject(2631, 3088.371582, 424.250946, 24.943718, 0.0000, 0.0000, 0.0000);
CreateObject(2631, 3092.072266, 424.250427, 24.993717, 0.0000, 0.0000, 0.0000);
CreateObject(2631, 3088.366943, 422.288452, 24.893719, 0.0000, 0.0000, 0.0000);
CreateObject(2631, 3092.100830, 422.286194, 24.893719, 0.0000, 0.0000, 0.0000);
CreateObject(2631, 3088.367188, 420.324860, 24.918720, 0.0000, 0.0000, 0.0000);
CreateObject(2631, 3092.086914, 420.337189, 24.893719, 0.0000, 0.0000, 0.0000);
CreateObject(2631, 3088.391113, 418.484680, 24.918718, 0.0000, 0.0000, 0.0000);
CreateObject(2631, 3092.058350, 418.470215, 24.943716, 0.0000, 0.0000, 0.0000);
CreateObject(2631, 3088.403320, 416.548706, 24.918718, 0.0000, 0.0000, 0.0000);
CreateObject(2631, 3092.084717, 416.489838, 24.918718, 0.0000, 0.0000, 0.0000);
CreateObject(2631, 3088.391113, 414.976532, 24.909224, 0.0000, 0.0000, 0.0000);
CreateObject(2631, 3092.084473, 414.566437, 24.893719, 0.0000, 0.0000, 0.0000);
CreateObject(2631, 3092.036377, 412.682617, 24.943718, 0.0000, 0.0000, 0.0000);
CreateObject(2631, 3088.398682, 413.189301, 24.897785, 0.0000, 0.0000, 0.0000);
CreateObject(2631, 3088.404053, 412.683746, 24.893719, 0.0000, 0.0000, 0.0000);
CreateObject(16775, 3094.130371, 417.946472, 23.971601, 0.0000, 0.0000, 90.0000);
CreateObject(10671, 3090.505371, 425.223389, 26.012201, 0.0000, 0.0000, 270.0000);
CreateObject(1569, 3089.477783, 425.184692, 24.965813, 0.0000, 0.0000, 0.0000);
CreateObject(2775, 3086.761719, 425.084717, 27.392216, 0.0000, 0.0000, 0.0000);
CreateObject(2775, 3093.179932, 425.084717, 27.343124, 0.0000, 0.0000, 0.0000);
CreateObject(16775, 3086.511475, 418.817535, 23.896606, 0.0000, 0.0000, 270.0000);
CreateObject(10671, 3090.241943, 411.693939, 26.060461, 0.0000, 0.0000, 90.0000);
CreateObject(10671, 3092.427979, 417.578796, 27.781849, 359.1406, 90.2409, 0.0000);
CreateObject(10671, 3092.461426, 429.526154, 27.737190, 359.1406, 90.2409, 0.0000);
CreateObject(10671, 3088.849365, 417.562775, 27.793383, 359.1406, 90.2409, 0.0000);
CreateObject(10671, 3088.787842, 429.135925, 27.762175, 359.1406, 90.2409, 0.0000);
CreateObject(10671, 3085.243164, 417.293884, 27.787201, 359.1406, 90.2409, 0.0000);
CreateObject(10671, 3085.185303, 428.753815, 27.737206, 359.1406, 90.2409, 0.0000);
CreateObject(1562, 3089.823242, 413.173187, 25.652580, 0.0000, 0.0000, 180.0000);
return 1;
}

public OnFilterScriptExit()
{
	print("  ===== New At-400 Interior By S1k Unloaded Sucessfully! ======");
	
	return 1;
}

public OnPlayerConnect(playerid)
{
	IsInAt[playerid] = 0;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new vehicleid = GetPlayerVehicleID(playerid);
	if(newstate == PLAYER_STATE_PASSENGER)
	{
	    if (GetVehicleModel(vehicleid) == 577)
	  {
            SetPlayerPos(playerid, 3089.823242, 413.173187, 25.652580);
            SetPlayerFacingAngle(playerid, 0);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 1);
            Timer1[playerid] = SetTimerEx("HornA", 60000, 1, "i", playerid);
            Timer2[playerid] = SetTimerEx("HornB", 60500, 1, "i", playerid);
	        IsInAt[playerid] = vehicleid;
	    }
	}
	return 1;
}

forward HornA(playerid);
forward HornB(playerid);

public HornA(playerid)
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	PlayerPlaySound(playerid, 1147, X, Y, Z);
}
public HornB(playerid)
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	PlayerPlaySound(playerid, 1147, X, Y+5, Z);
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys == 16 && IsInAt[playerid] > 0)
	{
		new Float:X,Float:Y,Float:Z;
		GetVehiclePos(IsInAt[playerid], X, Y, Z);
		SetPlayerPos(playerid, X+4, Y, Z);
		SetPlayerInterior(playerid, 0);
		KillTimer(Timer1[playerid]);
		KillTimer(Timer2[playerid]);
		IsInAt[playerid] = 0;
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	IsInAt[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	IsInAt[playerid] = 0;
	return 1;
}
