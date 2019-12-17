#include <a_samp>

// This is a comment
// uncomment the line below if you want to write a filterscript
#define FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Maps FilterScript By JohnnyBoy");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}


public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
    new alkatrazmap;
    new carriermap;
    new carrierlift;
    alkatrazmap = GangZoneCreate(3539.1328, 382.3327, 4085.4063, 560.8972);
    carriermap = GangZoneCreate(2782.5579, 441.7090, 3166.1729, 520.0420);
    AddStaticVehicle(460,3870.3757,521.3595,1.5988,265.3323,-1,-1); // seaplane at alcatraz
    AddStaticVehicle(460,3976.7407,515.1458,2.3438,262.1897,-1,-1); // seaplane at alcatraz
    CreateObject(10610,3818.9189,462.4248,44.9047, 0,0,0); //alkatraz building
    CreateObject(9241, 3747.5049,462.7799,35.9160, 0, 0, 0); // Helipad
    CreateObject(16684,3843.6028,466.0061,35.0500, 0,0,0); //runway alkatraz TEMPHEIGHT
    CreateObject(16684,3800.6028,466.0061,35.1500, 0,0,0); //runway alkatraz TEMPHEIGHT
    CreateObject(7020,3903.8245,439.2713,0.1845, 90.0,0,0); //temp rock south side
    CreateObject(7020,3847.9900,439.2713,0.1845, 90.0,0,0); //temp rock south side
    CreateObject(7020,3792.3772,439.2713,0.1845, 90.0,0,0); //temp rock south side
    CreateObject(7020,3736.7644,439.2713,0.1845, 90.0,0,0); //temp rock south side
    CreateObject(7020,3681.1516,439.2713,0.1845, 90.0,0,0); //temp rock south side
    CreateObject(7020,3925.3245,490.3089,0.1845, 90.0,180.0,0); //temp rock north side
    CreateObject(7020,3869.7117,490.3089,0.1845, 90.0,180.0,0); //temp rock north side
    CreateObject(7020,3814.0989,490.3089,0.1845, 90.0,180.0,0); //temp rock north side
    CreateObject(7020,3758.4861,490.3089,0.1845, 90.0,180.0,0); //temp rock north side
    CreateObject(7020,3702.8733,490.3089,0.1845, 90.0,180.0,0); //temp rock north side
    CreateObject(7020,3661.5684,475.2261,0.1845, 90.0,-90.0,0); //temp rock west side
    CreateObject(7020,3946.0205,454.2261,0.1845, 90.0,-270.0,0); //temp rock east side
    CreateObject(9829,3653.1909,469.4975,-60.0422, 0,0,0); //temp jetty
    CreateObject(1696,3719.6230,440.2697,36.1664, 0,0,0); //temp fucking graphic coverup
    CreateObject(3361,3662.1975,434.8389,7.2625, 0,0,180.0); //alkatraz jetty stairs 1
    CreateObject(3361,3670.5000,434.8389,11.2625, 0,0,180.0); //alkatraz jetty stairs 2
    CreateObject(3361,3678.8025,434.8389,15.2625, 0,0,180.0); //alkatraz jetty stairs 3
    CreateObject(3361,3687.1050,434.8389,19.2625, 0,0,180.0); //alkatraz jetty stairs 4
    CreateObject(3361,3695.4075,434.8389,23.2625, 0,0,180.0); //alkatraz jetty stairs 5
    CreateObject(3361,3703.7100,434.8389,27.2625, 0,0,180.0); //alkatraz jetty stairs 6
    CreateObject(3361,3712.0125,434.8389,31.2625, 0,0,180.0); //alkatraz jetty stairs 7
    CreateObject(3361,3720.3150,434.8389,35.2625, 0,0,180.0); //alkatraz jetty stairs 7
    CreateObject(3361,3724.0175,440.9389,35.2625, 0,0,90.0); //alkatraz jetty stairs 7
    CreateObject(16133,3949.3660,436.9482,-3.0720, 0,0,0);  // rear rocks
	CreateObject(16133,3949.5146,443.9666,-3.0720, 0,0,0);  // rear rocks
	CreateObject(16133,3949.5020,456.9551,-3.0720, 0,0,0);  // rear rocks
	CreateObject(16133,3950.1038,469.2790,-3.0720, 0,0,0);  // rear rocks
	CreateObject(16133,3950.0002,480.4923,-3.0720, 0,0,0);  // rear rocks
	CreateObject(16133,3949.7227,491.7022,-3.0720, 0,0,-260.0); //south rocks
	CreateObject(16133,3939.9426,434.4523,-3.0720, 0,0,-260.0); //south rocks
	CreateObject(16133,3931.4194,435.1336,-3.0720, 0,0,-260.0); //south rocks
	CreateObject(16133,3915.6609,434.1054,-3.0720, 0,0,-260.0); //south rocks
	CreateObject(16133,3900.5269,434.9130,-3.0720, 0,0,-260.0); //south rocks
	CreateObject(16133,3877.0825,434.7708,-3.0720, 0,0,-260.0); //south rocks
	CreateObject(16133,3861.7368,434.8331,-3.0720, 0,0,-260.0); //south rocks
	CreateObject(16133,3842.6758,434.4243,-3.0720, 0,0,-260.0); //south rocks
	CreateObject(16133,3824.8665,434.0956,-3.0720, 0,0,-260.0); //south rocks
	CreateObject(16133,3804.7859,434.6244,-3.0720, 0,0,-260.0); //south rocks
	CreateObject(16133,3789.3418,434.9493,-3.0720, 0,0,-260.0); //south rocks
	CreateObject(16133,3772.1704,435.3078,-3.0720, 0,0,-260.0); //south rocks
	CreateObject(16133,3755.1541,434.6487,-3.0720, 0,0,-260.0); //south rocks
	CreateObject(16133,3736.2070,434.6945,-3.0720, 0,0,-260.0); //south rocks
	CreateObject(16133,3715.8875,434.3674,-3.0720, 0,0,-260.0); //south rocks
	CreateObject(16133,3704.3535,425.3149,-3.0720, 0,0,-260.0); //south rocksv
	CreateObject(16133,3694.1118,423.1894,-3.0720, 0,0,-260.0); //south rocks
	CreateObject(16133,3924.9871,494.2710,-3.0720, 0,0,260.0); //north rocks
	CreateObject(16133,3909.9592,494.3855,-3.0720, 0,0,260.0); //north rocks
	CreateObject(16133,3887.1895,495.0713,-3.0720, 0,0,260.0); //north rocks
	CreateObject(16133,3868.9417,495.3724,-3.0720, 0,0,260.0); //north rocks
	CreateObject(16133,3852.3093,494.3452,-3.0720, 0,0,260.0); //north rocks
	CreateObject(16133,3833.7080,494.7250,-3.0720, 0,0,260.0); //north rocks
	CreateObject(16133,3815.5708,494.6730,-3.0720, 0,0,260.0); //north rocks
	CreateObject(16133,3798.0154,494.6982,-3.0720, 0,0,260.0); //north rocks
	CreateObject(16133,3782.4626,494.5486,-3.0720, 0,0,260.0); //north rocks
	CreateObject(16133,3768.0962,494.8924,-3.0720, 0,0,260.0); //north rocks
	CreateObject(16133,3750.6816,496.3246,-3.0720, 0,0,260.0); //north rocks
	CreateObject(16133,3736.1655,495.4835,-3.0720, 0,0,260.0); //north rocks
	CreateObject(16133,3719.0859,495.2566,-3.0720, 0,0,260.0); //north rocks
	CreateObject(16133,3712.8257,502.3133,-3.0720, 0,0,260.0); //north rocks
	CreateObject(16133,3722.2229,515.6876,-3.0720, 0,0,260.0); //north rocks
    CreateObject(3279,3919.0789,446.4962,34.9047, 0,0,180.0); //alkatraz a69 tower
    CreateObject(3279,3917.3616,480.4556,34.9047, 0,0,180.0); //alkatraz a69 tower
    CreateObject(3279,3667.6270,444.2554,34.9047, 0,0,0); //alkatraz a69 tower
    CreateObject(3279,3666.9414,483.3572,34.9047, 0,0,0); //alkatraz a69 tower
    CreateObject(3877,3577.4614,493.6883,6.2625, 0,0,0); //alkatraz red light jetty
    CreateObject(3877,3577.3799,463.3489,6.2625, 0,0,0); //alkatraz red light jetty
    CreateObject(3876,3808.4646,464.9513,55.4060, 0,0,0); //// long ariel
    CreateObject(1695,3828.4995,460.1334,55.4060, 0,0,0); //vent
    CreateObject(1694,3813.6328,454.2547,60.4060, 0,0,0); // ariel stack
	CreateObject(3502,3785.1304,504.2955,7.8628, 0,0,0); // sewer pipe
	// AIRCRAFT CARRIER
	CreateObject(10771,2969.0896,472.0975,5.8692, 0,0,0.0); // hull
	CreateObject(11145,2906.0896,472.0975,4.8692, 0,0,0.0); // lower deck
	CreateObject(11149,2963.0000,466.9000,12.4000, 0,0,0.0); // corridors
	CreateObject(11146,2960.2000,472.6000,12.7392, 0,0,0.0); // hanger
	CreateObject(10770,2972.2000,464.5000,39.0692, 0,0,0.0); // bridge
	CreateObject(10772,2970.3500,472.0975,17.6666, 0,0,0.0); // lines
	carrierlift = CreateObject(3115,2870.2490,472.1000,17.3583, 0,0,0.0); // lift
	CreateObject(11237,2976.3320,464.2060,31.5689, 0,0,0.0); // bits
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

