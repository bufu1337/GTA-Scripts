#include <a_samp>

// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else
new margate;
main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

#endif

public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("Blank Script");
	AddPlayerClass(0,149.3208,-1903.6128,3.7734,88.1219,0,0,0,0,0,0); // spawn
	CreateObject(3406,146.067,-1893.939,-0.335,0.0,0.0,-90.000); // piers
	CreateObject(3406,146.074,-1901.354,-0.335,0.0,0.0,90.000); // piers
	CreateObject(16502,142.728,-1883.895,-2.578,0.0,0.0,270.000);
	CreateObject(3578,154.481,-1936.653,3.476,0.0,0.0,0.0);
	CreateObject(1461,82.010,-1892.940,1.696,0.0,0.0,180.000); // 1461 all life rings
	CreateObject(1461,146.920,-1890.031,2.537,0.0,0.0,-90.000);
	CreateObject(1461,125.439,-1870.322,1.702,0.0,0.0,90.000);
	CreateObject(1461,102.303,-1824.274,1.693,0.0,0.0,0.0);
	CreateObject(1472,146.976,-1903.682,2.989,0.0,0.0,90.000); // 1472 all stairs
	CreateObject(1472,146.523,-1902.916,2.977,0.0,0.0,-180.000);
	CreateObject(1472,146.551,-1901.875,2.306,0.0,0.0,-180.000);
	CreateObject(1472,146.567,-1900.951,1.831,0.0,0.0,-180.000);
	CreateObject(1472,144.272,-1894.305,1.305,0.0,0.0,0.0);
	CreateObject(1472,143.972,-1892.415,1.318,0.0,0.0,-90.000);
	CreateObject(11495,134.022,-1892.289,0.692,0.0,0.0,-90.000); // pontoons? all of below
	CreateObject(11495,112.092,-1892.291,0.692,0.0,0.0,90.000);
	CreateObject(17068,90.137,-1892.273,0.692,0.0,0.0,270.000);
	CreateObject(17068,126.038,-1880.423,0.692,0.0,0.0,180.000);
	CreateObject(11495,119.675,-1904.130,0.692,0.0,0.0,0.0);
	CreateObject(11495,119.634,-1926.151,0.692,0.0,0.0,0.0);
	CreateObject(11495,107.871,-1904.771,0.692,0.0,0.0,90.000);
	CreateObject(11495,107.868,-1914.885,0.703,0.0,0.0,90.000);
	CreateObject(11495,107.811,-1924.691,0.692,0.0,0.0,90.000);
	CreateObject(11495,107.724,-1936.278,0.692,0.0,0.0,90.000);
	CreateObject(11495,82.819,-1880.379,0.692,0.0,0.0,0.0);
	CreateObject(11495,82.826,-1858.527,0.692,0.0,0.0,0.0);
	CreateObject(11495,82.834,-1836.709,0.692,0.0,0.0,0.0);
	CreateObject(17068,92.950,-1824.895,0.692,0.0,0.0,90.000);
	CreateObject(11495,94.518,-1836.801,0.692,0.0,0.0,0.0);
	CreateObject(11495,111.176,-1824.897,0.692,0.0,0.0,90.000);
	CreateObject(11495,105.625,-1836.618,0.692,0.0,0.0,0.0);
	CreateObject(11495,93.287,-1880.530,0.692,0.0,0.0,0.0);
	CreateObject(17068,114.211,-1884.918,0.692,0.0,0.0,-90.000);
	CreateObject(11495,107.264,-1873.088,0.692,0.0,0.0,0.0);
	CreateObject(11495,143.896,-1904.136,0.692,0.0,0.0,0.0);
	CreateObject(11495,143.877,-1926.034,0.692,0.0,0.0,0.0);
	CreateObject(11495,137.899,-1945.617,0.692,0.0,0.0,-33.750);
	CreateObject(11495,121.609,-1954.396,0.692,0.0,0.0,-90.000);
	CreateObject(11495,145.759,-1824.872,0.692,0.0,0.0,90.000);
	CreateObject(11495,80.031,-1904.020,0.692,0.0,0.0,-180.000);
	CreateObject(11495,80.051,-1925.960,0.692,0.0,0.0,-180.000);
	CreateObject(11495,103.481,-1954.401,0.692,0.0,0.0,-90.000);
	CreateObject(17068,80.033,-1938.058,0.692,0.0,0.0,-180.000);
	CreateObject(11495,135.684,-1834.934,0.692,0.0,0.0,-180.000);
	CreateObject(11495,82.599,-1733.661,0.692,0.0,0.0,-270.000); // cop section
	CreateObject(11495,72.519,-1743.771,0.692,0.0,0.0,180.000);
	CreateObject(11495,100.727,-1741.143,0.692,0.0,0.0,45.000);
	CreateObject(11495,82.600,-1753.839,0.692,0.0,0.0,-90.000);
	CreateObject(11495,112.825,-1758.632,0.752,0.0,0.0,24.219);
	CreateObject(11495,94.387,-1764.024,0.692,0.0,0.0,0.0);
	CreateObject(11495,123.337,-1777.580,0.692,0.0,0.0,-146.250);
	CreateObject(11495,133.535,-1796.687,0.692,0.0,0.0,-157.500);
	CreateObject(11495,147.990,-1806.285,0.692,0.0,0.0,-90.000);
	CreateObject(1472,146.992,-1806.269,2.758,0.0,0.0,-90.000);
	CreateObject(1472,146.183,-1806.304,2.017,0.0,0.0,-90.000);
	CreateObject(1472,145.221,-1806.308,1.344,0.0,0.0,-90.000);
	CreateObject(1472,149.264,-1806.280,2.940,0.0,0.0,90.000);
	CreateObject(3262,143.298,-1807.028,0.679,0.0,0.0,-258.750);
	CreateObject(3264,136.801,-1806.468,0.514,0.0,0.0,112.500);
	CreateObject(967,149.102,-1804.646,2.734,0.0,0.0,270.000);
	CreateObject(985,99.304,-1759.730,-0.533,0.0,0.0,-180.000);
	margate = CreateObject(986,106.933,-1758.250,-0.533,0.0,0.0,-157.500);

	AddStaticVehicle(472,120.2731,-1889.0839,-0.0289,89.5642,56,53); // coastgaurd
	AddStaticVehicle(454,130.6593,-1878.4662,0.1350,1.3995,26,26); // tropic
	AddStaticVehicle(484,103.3518,-1876.5808,0.2692,0.3071,50,32); // marquis
	AddStaticVehicle(452,90.9525,-1831.8628,-0.3588,174.1815,1,5); // speeder
	AddStaticVehicle(473,85.9339,-1829.4386,-0.2673,168.6455,56,53); // dinghy
	AddStaticVehicle(453,101.3219,-1834.2100,-0.2678,4.4305,56,56); // reefer
	AddStaticVehicle(472,116.3050,-1827.4155,0.1234,274.4250,56,15); // coastguard
	AddStaticVehicle(493,140.3188,-1831.5829,-0.1355,179.8757,36,13); // jetmax
	AddStaticVehicle(473,121.5292,-1883.0498,-0.2108,90.7049,56,15); // dinghy
	AddStaticVehicle(446,111.4197,-1877.9087,-0.4723,3.5431,1,5); // squalo
	AddStaticVehicle(454,111.9257,-1930.9924,0.1432,94.6955,26,26); // tropic
	AddStaticVehicle(484,111.6567,-1920.4352,0.2609,90.2641,40,26); // marquis
	AddStaticVehicle(452,111.4530,-1911.7177,-0.3645,91.1173,1,16); // speeder
	AddStaticVehicle(452,112.5211,-1907.8594,-0.4381,89.5268,1,22); // speeder
	AddStaticVehicle(453,140.0219,-1904.0789,-0.2360,179.0705,56,56); // reefer
	AddStaticVehicle(473,140.5520,-1915.4534,-0.3925,182.9954,56,53); // dinghy
	AddStaticVehicle(446,140.0525,-1927.1504,-0.6197,178.3953,3,3); // squalo
	AddStaticVehicle(484,121.3689,-1950.4294,0.1665,89.5688,66,36); // marquis
	AddStaticVehicle(595,84.5222,-1736.6326,0.3381,271.5227,112,20); // launch
	AddStaticVehicle(430,79.6439,-1750.0142,-0.1558,271.8652,46,26); // predator
	AddStaticVehicle(472,78.6178,-1743.8319,0.1716,267.4493,56,53); // coastgaurd
	AddStaticVehicle(460,93.9814,-1778.2070,1.8181,87.5776,-1,-1); // skimmer
	AddStaticVehicle(417,112.8548,-1969.5544,-0.0020,91.9028,0,0); // levitian
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 135.3700,-1842.5581,1.8951);
	SetPlayerFacingAngle(playerid,354.4818);
	SetPlayerCameraPos(playerid, 137.8195,-1779.8810,35.6988);
	SetPlayerCameraLookAt(playerid, 105.5432,-1904.4579,1.8951);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/open", cmdtext, true, 5) == 0)
	{
		MoveObject(margate,106.892,-1758.228,-9.669,5);
		return 1;
	}

	if (strcmp("/close", cmdtext, true, 6) == 0)
	{
		MoveObject(margate,106.933,-1758.250,-0.533,5);
		return 1;
	}

	if (strcmp("/marina", cmdtext, true, 6) == 0)
	{
		SetPlayerPos(playerid,149.3208,-1903.6128,3.7734);
		SetPlayerFacingAngle(playerid,88.1219);
		return 1;
	}
	return 0;
}
