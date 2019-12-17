#include <a_samp>

#define COLOR_RED 0xFF6A6AFF

new IsInTrainInt[MAX_PLAYERS];
new Timer1[MAX_PLAYERS];
new Timer2[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("  ===== New Train Interior By S1k Loaded Sucessfully! =======");

CreateObject(3983, 3109.629639, -2019.341675, 4.505384, 0.0000, 0.0000, 78.7500);
CreateObject(14405, 3112.863770, -2023.186279, 3.242663, 0.0000, 0.0000, 90.0000);
CreateObject(14405, 3111.047607, -2023.115479, 3.253142, 0.0000, 0.0000, 90.0000);
CreateObject(14405, 3108.852295, -2023.156128, 3.260407, 0.0000, 0.0000, 90.0000);
CreateObject(14405, 3107.039551, -2023.224609, 3.272244, 0.0000, 0.0000, 90.0000);
CreateObject(1562, 3101.630127, -2026.624268, 3.356740, 0.0000, 0.0000, 270.0000);
CreateObject(1562, 3103.455566, -2026.557617, 3.339848, 0.0000, 0.0000, 270.0000);
CreateObject(1562, 3105.686768, -2026.437988, 3.328056, 0.0000, 0.0000, 270.0000);
CreateObject(1562, 3107.368896, -2026.365967, 3.318470, 0.0000, 0.0000, 270.0000);
CreateObject(1502, 3107.643311, -2024.426270, 2.580908, 0.0000, 0.0000, 270.0001);
CreateObject(12842, 3111.558105, -2025.020874, 3.025931, 0.0000, 0.0000, 270.0000);
CreateObject(1502, 3115.119385, -2023.954712, 2.539207, 0.0000, 0.0000, 270.0001);
CreateObject(16151, 3119.345947, -2027.347656, 2.955072, 0.0000, 0.0000, 270.0000);
CreateObject(2746, 3121.189941, -2022.397949, 3.079691, 0.0000, 0.0000, 270.0000);
CreateObject(2746, 3117.794434, -2022.378296, 3.103113, 0.0000, 0.0000, 90.0000);
CreateObject(2747, 3119.400635, -2022.009888, 2.903426, 0.0000, 0.0000, 90.0000);
CreateObject(2748, 3115.296387, -2022.408936, 3.118325, 0.0000, 0.0000, 90.0000);
CreateObject(2747, 3116.264160, -2022.014282, 2.922068, 0.0000, 0.0000, 90.0000);
CreateObject(2748, 3124.007324, -2022.301636, 3.079691, 0.0000, 0.0000, 270.0000);
CreateObject(2747, 3122.741943, -2022.037476, 2.894500, 0.0000, 0.0000, 270.0000);
CreateObject(18095, 3106.871582, -2020.862793, 5.084706, 0.0000, 0.0000, 180.0000);
CreateObject(18095, 3114.076904, -2028.809570, 5.385204, 0.0000, 0.0000, 0.0000);
CreateObject(16773, 3106.661621, -2020.937012, 3.526744, 0.0000, 0.0000, 0.0000);
CreateObject(16775, 3121.161133, -2020.929199, 3.531167, 0.0000, 0.0000, 180.0000);
CreateObject(16775, 3128.414551, -2028.389771, 3.536241, 0.0000, 0.0000, 90.0000);
CreateObject(16775, 3121.247314, -2028.720947, 3.525239, 0.0000, 0.0000, 0.0000);
CreateObject(16775, 3106.585449, -2028.734741, 3.534204, 0.0000, 0.0000, 0.0000);
CreateObject(16775, 3115.140625, -2032.819702, 2.384316, 0.0000, 0.0000, 90.0000);
CreateObject(16775, 3115.243408, -2016.681030, 2.281161, 0.0000, 0.0000, 90.0000);
CreateObject(16775, 3115.292969, -2025.480835, 9.059042, 0.0000, 0.0000, 90.0000);
CreateObject(16775, 3107.885986, -2017.183350, 1.919064, 0.0000, 0.0000, 90.0000);
CreateObject(16775, 3107.754150, -2033.243408, 2.310782, 0.0000, 0.0000, 90.0000);
CreateObject(16775, 3107.734863, -2024.729492, 9.050252, 0.0000, 0.0000, 90.0000);
CreateObject(16775, 3099.229736, -2024.518311, 6.646741, 0.0000, 0.0000, 270.0000);
CreateObject(2775, 3099.329590, -2026.125977, 6.229951, 0.0000, 0.0000, 90.0000);
CreateObject(2775, 3099.329590, -2022.894653, 6.226449, 0.0000, 0.0000, 90.0000);
CreateObject(16775, 3103.003418, -2025.929565, 7.473158, 268.8997, 0.0000, 270.0000);
CreateObject(16775, 3110.805420, -2025.866699, 7.332901, 268.8997, 0.0000, 270.0000);
CreateObject(16775, 3118.661865, -2025.807007, 7.259706, 268.8997, 0.0000, 270.0000);
CreateObject(16775, 3126.406250, -2025.770874, 7.285888, 270.6186, 0.0000, 90.0000);
CreateObject(630, 3099.999756, -2025.256348, 3.676764, 0.0000, 0.0000, 0.0000);
CreateObject(630, 3099.994141, -2028.194092, 3.724263, 0.0000, 0.0000, 0.0000);
CreateObject(630, 3099.739746, -2021.442871, 3.624852, 0.0000, 0.0000, 0.0000);
CreateObject(630, 3103.612305, -2028.318115, 3.694804, 0.0000, 0.0000, 0.0000);
CreateObject(630, 3107.269775, -2028.212524, 3.671710, 0.0000, 0.0000, 0.0000);
CreateObject(630, 3104.694092, -2021.359863, 3.594378, 0.0000, 0.0000, 0.0000);
CreateObject(630, 3107.724854, -2021.406860, 3.577057, 0.0000, 0.0000, 0.0000);
CreateObject(1723, 3126.884521, -2024.029175, 2.479994, 0.0000, 0.0000, 270.0000);
	return 1;
}

public OnFilterScriptExit()
{
	print("  ===== New Train Interior By S1k Unloaded Sucessfully! ======");
	
	return 1;
}

public OnPlayerConnect(playerid)
{
	IsInTrainInt[playerid] = 0;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new vehicleid = GetPlayerVehicleID(playerid);
	if(newstate == PLAYER_STATE_PASSENGER)
	{
	    if (GetVehicleModel(vehicleid) == 538 || GetVehicleModel(vehicleid) == 537)
	    {
            SetPlayerPos(playerid, 3126.884521, -2024.029175, 2.479994);
            SetPlayerFacingAngle(playerid, 0);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 1);
            Timer1[playerid] = SetTimerEx("HornA", 60000, 1, "i", playerid);
            Timer2[playerid] = SetTimerEx("HornB", 60500, 1, "i", playerid);
	        IsInTrainInt[playerid] = vehicleid;
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
	if (newkeys == 16 && IsInTrainInt[playerid] > 0)
	{
		new Float:X,Float:Y,Float:Z;
		GetVehiclePos(IsInTrainInt[playerid], X, Y, Z);
		SetPlayerPos(playerid, X+4, Y, Z);
		SetPlayerInterior(playerid, 0);
		KillTimer(Timer1[playerid]);
		KillTimer(Timer2[playerid]);
		IsInTrainInt[playerid] = 0;
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	IsInTrainInt[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	IsInTrainInt[playerid] = 0;
	return 1;
}
