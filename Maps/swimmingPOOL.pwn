#include <a_samp>

main()
{
	print("\n--------------------------------------");
	print(" Swimming Pool by [Ask]Terminator ");
	print("--------------------------------------\n");
}

new enterb;
new exitb;
new entersp;
new exitsp;
new entersauna;
new exitsauna;
new bigjump;
new anim;
public OnFilterScriptInit()
{

	CreateObject(7488,530.544,-2182.358,-5.427,0.0,0.0,90.000);
	CreateObject(7488,586.857,-2231.216,-5.421,0.0,0.0,180.000);
	CreateObject(7488,625.804,-2179.683,-5.416,0.0,0.0,270.000);
	CreateObject(7488,609.018,-2110.053,-5.438,0.0,0.0,-90.241);
	CreateObject(7488,540.848,-2121.652,-5.431,0.0,0.0,0.0);
	CreateObject(10789,552.882,-2193.363,-1.971,0.0,0.0,0.0);
	CreateObject(10789,552.801,-2166.741,-1.958,0.0,0.0,0.0);
	CreateObject(10789,602.964,-2193.119,-1.806,0.0,0.0,0.0);
	CreateObject(10789,602.918,-2165.713,-1.809,0.0,0.0,0.0);
	CreateObject(10789,579.769,-2208.510,-1.989,0.0,0.0,-90.000);
	CreateObject(10789,563.120,-2138.514,-1.958,0.0,0.0,-90.000);
	CreateObject(10789,588.935,-2138.411,-1.709,0.0,0.859,-90.000);
	CreateObject(7488,580.116,-2220.007,-18.956,0.0,0.0,180.000);
	CreateObject(7488,541.308,-2181.601,-18.929,0.0,0.0,90.000);
	CreateObject(7488,614.347,-2178.431,-19.205,0.0,0.0,270.000);
	CreateObject(7488,575.592,-2127.046,-19.064,0.0,0.0,0.0);
	CreateObject(7488,581.498,-2181.194,-32.516,-90.241,18.048,106.329);
	CreateObject(7488,589.088,-2164.366,-32.465,-90.241,18.048,106.329);
	CreateObject(1472,573.286,-2194.908,1.044,0.0,0.0,0.0);
	CreateObject(1472,573.277,-2193.849,1.799,0.0,0.0,0.0);
	CreateObject(1473,573.269,-2191.742,2.131,-24.924,0.0,0.0);
	CreateObject(7922,578.300,-2195.205,2.027,0.0,0.0,0.0);
	CreateObject(7922,579.305,-2195.346,2.027,0.0,0.0,-90.000);
	CreateObject(7922,579.320,-2195.344,4.731,0.0,0.0,-90.000);
	CreateObject(7922,578.306,-2195.198,4.731,0.0,0.0,0.0);
	CreateObject(5153,578.734,-2192.186,6.011,0.0,24.064,90.000);
	CreateObject(5153,578.747,-2188.851,5.969,0.0,24.064,90.000);
	CreateObject(13634,583.150,-2169.534,-8.485,0.0,0.0,90.000);
	CreateObject(10789,580.498,-2112.731,-1.286,0.0,0.859,-90.000);
	CreateObject(10789,580.508,-2084.587,-0.849,0.0,0.859,-90.000);
	CreateObject(7488,583.216,-2048.744,1.937,0.0,0.0,-0.241);
	CreateObject(7488,541.814,-2122.071,1.609,0.0,0.0,179.759);
	CreateObject(10789,552.016,-2084.651,-0.832,0.0,0.859,-90.000);
	CreateObject(643,595.301,-2193.400,1.289,0.0,0.0,0.0);
	CreateObject(643,597.401,-2190.010,1.289,0.0,0.0,-56.250);
	CreateObject(643,594.665,-2186.864,1.289,0.0,0.0,56.250);
	CreateObject(643,598.000,-2183.015,1.282,0.0,0.0,11.250);
	CreateObject(18090,598.211,-2200.703,3.382,0.0,0.0,0.0);
	CreateObject(1486,599.491,-2199.775,2.144,0.0,0.0,0.0);
	CreateObject(1486,597.249,-2196.844,2.003,0.0,0.0,0.0);
	CreateObject(1488,599.892,-2196.393,2.734,0.0,0.0,-91.873);
	CreateObject(1517,597.013,-2197.393,2.058,0.0,0.0,0.0);
	CreateObject(1517,596.976,-2203.031,2.066,0.0,0.0,0.0);
	CreateObject(2800,599.561,-2200.743,1.814,0.0,0.0,0.0);
	CreateObject(2350,596.070,-2204.317,1.191,0.0,0.0,0.0);
	CreateObject(2350,596.039,-2203.337,1.191,0.0,0.0,0.0);
	CreateObject(2350,596.063,-2202.154,1.191,0.0,0.0,0.0);
	CreateObject(2350,596.102,-2201.037,1.191,0.0,0.0,0.0);
	CreateObject(2350,596.080,-2199.403,1.191,0.0,0.0,0.0);
	CreateObject(2350,595.985,-2198.089,1.191,0.0,0.0,0.0);
	CreateObject(2350,596.398,-2196.438,1.191,0.0,0.0,0.0);
	CreateObject(1437,578.739,-2195.154,1.141,9.454,0.0,0.0);
	CreateObject(2212,596.769,-2202.386,1.919,-27.502,24.924,0.0);
	CreateObject(2212,596.876,-2198.838,1.894,-27.502,24.924,0.0);
	CreateObject(4724,562.378,-2153.235,2.694,0.0,0.0,90.000);
	CreateObject(1646,564.300,-2166.192,1.005,0.0,0.0,90.000);
	CreateObject(1646,564.326,-2174.443,1.005,0.0,0.0,90.000);
	CreateObject(1646,564.872,-2182.397,0.991,0.0,0.0,90.000);
	CreateObject(1645,564.494,-2171.075,0.999,0.0,0.0,90.000);
	CreateObject(1645,564.656,-2178.865,0.999,0.0,0.0,90.000);
	CreateObject(1533,599.381,-2205.260,0.813,0.0,0.0,-180.000);
	CreateObject(18027,578.306,-2050.813,2.376,0.0,0.0,0.0);
	CreateObject(14672,568.140,-2038.455,17.167,0.0,0.0,0.0);
	CreateObject(1514,569.725,-2032.004,16.534,0.0,0.0,0.0);
	CreateObject(16779,572.265,-2035.525,19.175,0.0,0.0,0.0);
	CreateObject(1775,576.882,-2033.357,16.264,0.0,0.0,-90.000);
	CreateObject(1776,577.018,-2034.913,16.267,0.0,0.0,-90.000);
	CreateObject(2425,598.393,-2196.676,1.856,0.0,0.0,0.0);
	CreateObject(2429,598.968,-2196.760,1.858,0.0,0.0,0.0);
	CreateObject(2453,599.713,-2196.898,2.237,0.0,0.0,0.0);
	CreateObject(1641,565.906,-2172.862,0.687,0.0,0.0,90.000);
	CreateObject(1723,568.046,-2038.504,15.165,0.0,0.0,90.000);
	CreateObject(1723,568.030,-2041.680,15.165,0.0,0.0,90.000);
	CreateObject(1663,569.756,-2030.671,15.628,0.0,0.0,11.250);
	CreateObject(1671,571.494,-2030.657,15.628,0.0,0.0,-11.250);
	CreateObject(2647,570.948,-2031.983,16.425,0.0,0.0,45.000);
	CreateObject(1736,570.029,-2029.816,17.960,0.0,0.0,0.0);
	CreateObject(1738,575.137,-2032.652,15.822,0.0,0.0,0.0);
	CreateObject(2226,567.708,-2031.966,16.267,0.0,0.0,90.000);
	CreateObject(2520,556.246,-2075.927,1.906,0.0,0.0,0.0);
	CreateObject(2520,558.648,-2075.923,1.913,0.0,0.0,0.0);
	CreateObject(2520,561.095,-2075.973,1.918,0.0,0.0,0.0);
	CreateObject(2520,563.245,-2075.971,1.918,0.0,0.0,0.0);
	CreateObject(2520,565.349,-2075.963,1.913,0.0,0.0,0.0);
	CreateObject(2525,576.543,-2075.015,1.921,0.0,0.0,0.0);
	CreateObject(2525,581.338,-2074.996,1.914,0.0,0.0,0.0);
	CreateObject(2525,579.741,-2075.021,1.915,0.0,0.0,0.0);
	CreateObject(2525,578.281,-2075.063,1.911,0.0,0.0,0.0);
	CreateObject(2596,567.429,-2032.163,18.573,19.767,0.0,123.750);
	CreateObject(2602,583.373,-2076.127,2.600,0.0,0.0,-45.000);
	CreateObject(2602,583.395,-2076.785,2.585,0.0,0.0,-45.000);
	CreateObject(2602,583.341,-2077.417,2.616,0.0,0.0,-45.000);
	CreateObject(2631,598.060,-2148.382,0.814,0.0,0.0,0.0);
	CreateObject(2631,598.055,-2150.275,0.813,0.0,0.0,0.0);
	CreateObject(2631,598.049,-2152.189,0.831,0.0,0.0,0.0);
	CreateObject(2718,596.695,-2205.329,3.155,0.0,0.0,-180.077);
	CreateObject(2718,574.218,-2031.253,17.840,0.0,0.0,-89.836);
	CreateObject(2818,570.597,-2033.889,15.160,0.0,0.0,0.0);
	CreateObject(2831,598.025,-2183.071,1.683,0.0,0.0,0.0);
	CreateObject(2832,594.678,-2186.934,1.689,0.0,0.0,0.0);
	CreateObject(2841,571.574,-2041.012,15.167,0.0,0.0,0.0);
	CreateObject(2847,575.347,-2047.525,15.164,0.0,0.0,0.0);
	CreateObject(2828,572.643,-2032.146,16.270,0.0,0.0,0.0);
	CreateObject(1533,559.099,-2034.749,15.169,0.0,0.0,90.000);
	CreateObject(1533,560.290,-2096.255,1.593,0.0,0.0,181.960);
	CreateObject(7488,517.080,-2084.448,1.592,0.0,0.0,-0.241);
	CreateObject(993,559.244,-2079.644,3.474,0.0,0.0,0.0);
	CreateObject(993,562.583,-2079.581,3.484,0.0,0.0,0.0);
	CreateObject(993,578.417,-2079.605,3.470,0.0,0.0,0.0);
	CreateObject(16770,558.100,-2074.574,3.466,0.0,0.0,269.622);
	CreateObject(18009,526.662,-2078.167,19.069,0.0,0.0,0.0);
	CreateObject(2395,530.119,-2087.730,16.937,0.0,0.0,-180.000);
	CreateObject(2395,530.587,-2085.214,17.171,0.0,0.0,-90.000);
	CreateObject(2395,518.599,-2087.808,17.338,0.0,0.0,-180.000);
	CreateObject(2395,526.230,-2086.738,16.150,0.0,0.0,-180.000);
	CreateObject(2395,522.741,-2086.692,16.175,0.0,0.0,-180.000);
	CreateObject(2395,526.290,-2086.706,18.880,-38.675,0.0,-180.000);
	CreateObject(2395,522.828,-2086.912,-0.035,-38.675,0.0,-180.000);
	CreateObject(2395,522.774,-2086.737,18.901,-38.675,0.0,-180.000);
	CreateObject(2395,522.903,-2075.039,15.826,0.0,0.0,0.0);
	CreateObject(2395,520.426,-2075.028,15.826,0.0,0.0,0.0);
	CreateObject(2395,520.257,-2075.078,18.550,0.0,0.0,0.0);
	CreateObject(2395,523.923,-2074.491,0.293,0.0,0.0,0.0);
	CreateObject(2395,523.771,-2075.064,18.535,0.0,0.0,0.0);
	CreateObject(1569,530.825,-2081.726,16.221,0.0,0.0,-90.000);
	CreateObject(2395,530.758,-2081.998,16.232,0.0,0.0,-90.000);
	CreateObject(2395,530.777,-2081.807,18.643,0.0,0.0,-90.000);
	CreateObject(2780,524.547,-2079.741,8.598,0.0,0.0,0.0);
	CreateObject(2780,529.373,-2088.144,0.016,0.0,0.0,0.0);
	CreateObject(2780,519.173,-2083.985,8.951,0.0,0.0,0.0);
	CreateObject(2780,531.119,-2075.728,8.551,0.0,0.0,0.0);
	CreateObject(2780,522.136,-2076.463,20.076,0.0,0.0,0.0);
	CreateObject(2780,520.322,-2083.611,20.126,0.0,0.0,0.0);
	CreateObject(1368,525.208,-2081.842,16.915,0.0,0.0,0.0);
	CreateObject(1368,522.027,-2081.879,16.915,0.0,0.0,0.0);
	CreateObject(1368,515.772,-2077.939,16.516,0.0,0.0,90.000);
	CreateObject(1368,516.327,-2084.602,16.915,0.0,0.0,90.000);
	CreateObject(1368,522.078,-2079.880,16.516,0.0,0.0,180.000);
	CreateObject(1368,525.200,-2079.816,16.516,0.0,0.0,180.000);
	CreateObject(2526,532.174,-2077.855,15.827,0.0,0.0,270.000);
	CreateObject(1569,569.876,-2096.405,1.545,0.0,0.0,1.100);
	CreateObject(2395,571.933,-2096.299,1.573,0.0,0.0,-178.522);
	CreateObject(2395,570.063,-2096.318,1.565,0.0,0.0,-179.381);
	CreateObject(1523,580.438,-2076.095,1.891,0.0,0.0,0.0);
	CreateObject(1523,578.905,-2076.128,1.898,0.0,0.0,0.0);
	CreateObject(1523,577.426,-2076.121,1.895,0.0,0.0,0.0);
	CreateObject(1523,575.933,-2076.096,1.894,0.0,0.0,0.0);
	CreateObject(974,581.894,-2072.776,1.634,0.0,0.0,-90.000);
	CreateObject(974,580.517,-2072.776,1.598,0.0,0.0,-90.000);
	CreateObject(974,579.018,-2072.762,1.622,0.0,0.0,-90.000);
	CreateObject(974,577.509,-2072.774,1.498,0.0,0.0,-90.000);
	CreateObject(974,576.014,-2072.759,1.566,0.0,0.0,-90.000);
	CreateObject(7494,589.376,-2177.761,-7.065,0.0,-6.875,90.000);
	CreateObject(7494,589.326,-2193.328,-9.176,0.0,1.719,90.000);
	CreateObject(1437,588.410,-2154.402,-3.836,9.454,0.0,-89.063);
	CreateObject(1437,588.484,-2190.484,-3.891,9.454,0.0,-89.063);





	enterb = CreatePickup(1318,1,2481.2170,1524.9906,11.7737);
	exitb = CreatePickup(1318,1,575.5093,-2050.3943,16.1670);
	entersp = CreatePickup(1318,1,559.5461,-2033.9458,16.1743);
	exitsp =  CreatePickup(1318,1,559.5261,-2095.8760,2.6254);
	entersauna = CreatePickup(1318,1,570.5856,-2095.8291,2.6077);
	exitsauna = CreatePickup(1318,1,530.4130,-2082.5781,17.2253);
	bigjump = CreatePickup(1318,1,578.6855,-2195.5337,1.6288);
	anim = CreatePickup(1318,1,578.6855,-2195.5337,1.6288);



	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SendClientMessage(playerid,0xFFFF00AA,"Type /SP to go to Swimming Pool ! ");
	return 1;
}


public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp(cmdtext, "/SP", true))
	{
	    SetPlayerPos(playerid,2494.2261,1540.4420,10.8203);
		return 1;
	}
	return 0;
}



public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(pickupid == enterb)
		{
		SetPlayerPos(playerid,575.7503,-2046.9207,16.1670);
		}
	if(pickupid == exitb)
	    {
	    SetPlayerPos(playerid,2483.1611,1526.7001,11.3387);
	    }
	if(pickupid == entersp)
	    {
	    SetPlayerPos(playerid,559.4380,-2092.8203,2.67120);
		 }
	if(pickupid == exitsp)
	    {
	    SetPlayerPos(playerid,561.7214,-2033.8285,16.1670);
	    }
	if(pickupid == entersauna)
	    {
	    SetPlayerPos(playerid,527.8544,-2082.4460,17.2253);
	    }
	if(pickupid == exitsauna)
	    {
	    SetPlayerPos(playerid,570.3227,-2093.3599,2.6448);
	    }
	if(pickupid == bigjump)
	    {
		SetPlayerPos(playerid,578.5896,-2194.7065,7.1380);
		}
	if(pickupid == anim)
	    {
		ApplyAnimation(playerid,"DAM_JUMP","DAM_LAUNCH",2,0,1,1,0,0);
		}
	return 1;
}

