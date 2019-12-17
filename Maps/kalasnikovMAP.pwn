#include <a_samp>

// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Kalasnikov WAR by Hor1z0n");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Kalasnikov WAR by Hor1z0n");
	print("----------------------------------\n");
}

#endif

public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	CreateObject(628, 88.503487, 94.216965, 3.423596, 0.0000, 0.0000, 0.0000);
	CreateObject(628, 99.199524, 89.695274, 3.423596, 0.0000, 1.7189, 354.8434);
	CreateObject(628, 103.601044, 88.037476, 3.306101, 0.0000, 0.0000, 0.0000);
	CreateObject(640, 70.829697, -3.203079, 0.491041, 0.0000, 0.0000, 337.5000);
	CreateObject(803, 73.391869, -4.791374, 1.063719, 0.0000, 0.0000, 0.0000);
	CreateObject(803, 75.186470, 4.652321, 1.028681, 0.0000, 0.0000, 0.0000);
	CreateObject(803, 77.357040, 13.771435, 1.028681, 0.0000, 0.0000, 0.0000);
	CreateObject(803, 82.187889, 20.928112, 1.036158, 0.0000, 0.0000, 0.0000);
	CreateObject(803, 51.174263, 35.418243, 1.962618, 0.0000, 0.0000, 0.0000);
	CreateObject(803, 50.506546, 27.443230, 2.102915, 0.0000, 0.0000, 0.0000);
	CreateObject(803, 48.482224, 22.722992, 2.370077, 0.0000, 0.0000, 0.0000);
	CreateObject(803, 44.834549, 15.256363, 2.843042, 0.0000, 0.0000, 0.0000);
	CreateObject(803, 42.844131, 9.403931, 3.115572, 0.0000, 0.0000, 0.0000);
	CreateObject(803, 41.158646, 3.683174, 3.324312, 0.0000, 0.0000, 0.0000);
	CreateObject(8868, 162.151382, 218.051453, 202.756226, 0.0000, 0.0000, 0.0000);
	CreateObject(8868, 201.506119, 219.895676, 204.864258, 0.0000, 0.0000, 0.0000);
	CreateObject(898, 217.625565, 248.638794, 209.300003, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 217.770645, 237.978882, 209.284531, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 218.160721, 227.056793, 209.324982, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 219.480225, 209.571991, 209.319656, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 216.852936, 191.777679, 208.880569, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 209.563797, 191.551483, 208.295120, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 201.070129, 191.925369, 207.295013, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 191.288925, 189.421448, 207.278320, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 183.035873, 190.271942, 208.741714, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 174.325195, 186.776016, 207.687027, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 164.267395, 185.906525, 206.773605, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 157.476593, 188.639359, 206.903580, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 151.340622, 188.768921, 206.685837, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 147.849731, 196.306793, 208.036469, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 146.901764, 205.329376, 208.307602, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 144.638977, 212.588455, 208.125961, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 148.083817, 215.175888, 209.906738, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 147.393829, 222.247421, 207.774368, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 143.772385, 227.472473, 206.623520, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 144.522583, 233.430679, 207.308029, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 145.778244, 243.021179, 208.106812, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 148.401672, 252.661606, 208.601730, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 159.996841, 253.263672, 208.630142, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 165.980011, 253.574219, 208.642288, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 173.306580, 253.336365, 208.632980, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 179.174286, 253.208130, 208.741714, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 187.131561, 253.352554, 209.158218, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 207.645264, 253.914825, 209.191589, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 218.590927, 202.247894, 209.054367, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 219.427292, 221.582657, 209.349808, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 219.457840, 217.189011, 209.352020, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 218.132248, 237.296555, 209.281693, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 218.026428, 235.187469, 209.228363, 0.0000, 0.0000, 135.0000);
	CreateObject(898, 197.916916, 253.381958, 209.167206, 0.0000, 0.0000, 135.0000);
	CreateObject(880, 180.919769, 215.409195, 205.207840, 0.0000, 0.0000, 0.0000);
	CreateObject(880, 181.062408, 210.916901, 205.257294, 0.0000, 0.0000, 0.0000);
	CreateObject(880, 180.243683, 210.448395, 205.507294, 0.0000, 0.0000, 0.0000);
	CreateObject(880, 181.809036, 200.079132, 205.757294, 0.0000, 0.0000, 0.0000);
	CreateObject(880, 179.672272, 200.538757, 205.287888, 0.0000, 0.0000, 0.0000);
	CreateObject(880, 181.671661, 234.465958, 204.749817, 0.0000, 0.0000, 0.0000);
	CreateObject(880, 178.669495, 234.207184, 205.406036, 0.0000, 0.0000, 0.0000);
	CreateObject(880, 179.690079, 240.107407, 204.945999, 0.0000, 0.0000, 0.0000);
	CreateObject(880, 178.626358, 245.351471, 205.216080, 0.0000, 0.0000, 0.0000);
	CreateObject(880, 178.897583, 208.464783, 205.481262, 0.0000, 0.0000, 0.0000);
	CreateObject(880, 179.066620, 205.806137, 205.105270, 0.0000, 0.0000, 0.0000);
	CreateObject(880, 181.423874, 220.660049, 205.257294, 0.0000, 0.0000, 0.0000);
	CreateObject(3866, 200.477844, 243.498062, 213.565353, 0.0000, 0.0000, 45.0000);
	CreateObject(968, 184.106674, 225.216385, 204.507385, 0.0000, 0.0000, 90.0000);
	CreateObject(17059, 188.221741, 204.451981, 205.601532, 0.0000, 0.0000, 67.5000);
	CreateObject(1458, 198.592209, 219.439346, 205.983948, 0.0000, 0.0000, 0.0000);
	CreateObject(1458, 205.121399, 220.057022, 206.020859, 0.0000, 0.0000, 0.0000);
	CreateObject(1458, 192.226181, 217.855011, 205.438156, 0.0000, 0.0000, 0.0000);
	CreateObject(1479, 179.614899, 228.623016, 205.411926, 0.0000, 0.0000, 90.0000);
	CreateObject(1431, 197.974396, 227.918671, 214.338181, 0.0000, 0.0000, 281.2500);
	CreateObject(1431, 195.261063, 231.145203, 214.338181, 0.0000, 0.0000, 270.0000);
	CreateObject(3865, 188.637192, 222.610840, 205.819519, 0.0000, 0.0000, 315.0000);
	CreateObject(1384, 174.169006, 249.212341, 209.265717, 0.0000, 0.0000, 112.5000);
	CreateObject(3866, 169.127518, 201.010239, 210.990082, 0.0000, 0.0000, 225.0000);
	CreateObject(11428, 166.507095, 240.189972, 208.412460, 0.0000, 0.0000, 146.2500);
	CreateObject(1437, 202.089355, 233.310989, 206.653839, 336.7952, 0.0000, 124.6867);
	CreateObject(1342, 195.253845, 231.644455, 210.724289, 0.0000, 0.0000, 45.0000);
	CreateObject(975, 192.307159, 244.533020, 213.130447, 86.8030, 0.0000, 45.0000);
	CreateObject(975, 191.836884, 239.578781, 213.227783, 47.2690, 6.0161, 59.6104);
	CreateObject(3361, 197.085098, 244.438248, 210.805222, 0.0000, 0.0000, 270.0000);
	CreateObject(1698, 197.085617, 239.199356, 206.878113, 30.0803, 0.0000, 0.0000);
	CreateObject(1477, 167.592590, 237.255707, 204.260300, 0.0000, 0.0000, 236.2501);
	CreateObject(1417, 174.396591, 212.443405, 207.902390, 0.0000, 0.0000, 315.0000);
	CreateObject(1417, 182.764755, 206.839844, 207.902390, 0.0000, 0.0000, 315.0000);
	CreateObject(1771, 174.234009, 213.883179, 207.674011, 0.0000, 0.0000, 78.7500);
	CreateObject(1771, 176.595474, 213.963165, 211.773987, 0.0000, 0.0000, 78.7500);
	CreateObject(1771, 177.288147, 206.671585, 204.030991, 0.0000, 0.0000, 78.7500);
	CreateObject(3399, 177.546021, 204.013885, 208.420578, 0.0000, 0.0000, 58.9918);
	CreateObject(1477, 174.493515, 199.239380, 204.542969, 0.0000, 0.0000, 326.2500);
	CreateObject(3399, 167.638168, 209.309296, 204.524200, 0.0000, 0.0000, 45.0000);
	CreateObject(3399, 166.746521, 197.514832, 205.670578, 0.0000, 0.0000, 247.5000);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerPrivmsg(playerid, recieverid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/kalasnikov", cmdtext, true, 10) == 0)
	{
		SetPlayerPos(playerid, 182.835266, 228.019073, 204.775574);
		SetPlayerHealth(playerid, 100);
		SetPlayerArmour(playerid, 100);
		GivePlayerWeapon(playerid, 30, 9999);
		return 1;
	}
	return 0;
}

public OnPlayerInfoChange(playerid)
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

