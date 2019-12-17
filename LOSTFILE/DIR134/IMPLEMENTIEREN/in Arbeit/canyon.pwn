#include <a_samp>

enum oInfo
{
	ModelID,
	Float:X,
	Float:Y,
	Float:Z,
	Float:XR,
	Float:YR,
	Float:ZR
}

new CanyonObj[][oInfo] = {
{16260,-3621.31,586.45,10.47,0.00,0.00,0.00},
{16194,-3707.33,625.34,10.46,0.00,0.00,1800.00},
{16198,-3634.87,630.78,8.97,0.00,0.00,90.00},
{16133,-3637.12,581.32,8.72,0.00,0.00,0.00},
{16113,-3664.95,580.32,13.81,0.00,0.00,216.00},
{16113,-3699.97,602.82,11.02,0.00,0.00,297.00},
{16121,-3702.35,654.09,15.10,5.00,0.00,360.00},
{16121,-3704.28,688.96,15.85,0.00,0.00,522.00},
{16118,-3706.54,745.70,18.79,0.00,0.00,180.00},
{16195,-3640.01,719.67,15.84,0.00,0.00,270.00},
{16118,-3688.28,626.40,6.23,0.00,0.00,540.00},
{16192,-3519.01,673.90,15.18,0.00,0.00,0.00},
{16127,-3576.25,555.11,19.10,0.00,0.00,0.00},
{16127,-3530.00,555.89,23.77,0.00,0.00,9.00},
{16123,-3627.96,545.60,15.89,0.00,0.00,0.00},
{16123,-3687.09,737.28,17.89,0.00,0.00,-18.00},
{16121,-3646.35,753.46,11.64,0.00,0.00,90.00},
{16121,-3597.41,763.09,17.55,0.00,0.00,212.00},
{16127,-3569.12,756.77,19.38,0.00,0.00,540.00},
{16118,-3536.62,752.86,7.09,0.00,0.00,36.00},
{16123,-3512.64,761.73,-0.02,0.00,0.00,270.00},
{16121,-3479.68,751.04,4.78,0.00,0.00,180.00},
{16121,-3495.60,720.44,2.85,0.00,0.00,135.00},
{16253,-3602.82,793.24,-4.45,0.00,0.00,0.00},
{16406,-3601.00,579.41,16.28,0.00,0.00,153.00},
{864,-3582.93,565.67,19.32,0.00,0.00,0.00},
{3276,-3583.84,565.67,20.12,0.00,0.00,126.00},
{3276,-3587.15,577.00,18.86,-4.00,10.50,95.00},
{3276,-3587.33,587.81,16.55,0.00,14.00,450.00},
{3276,-3606.80,578.94,14.36,0.00,0.00,-18.00},
{3286,-3615.34,577.26,18.83,0.00,0.00,0.00},
{16105,-3612.63,586.65,16.93,0.00,0.00,570.00},
{11497,-3577.84,567.22,18.94,0.00,0.00,90.00},
{3287,-3571.68,569.06,22.76,0.00,0.00,0.00},
{3285,-3558.60,571.28,21.36,0.00,0.00,270.00},
{3594,-3555.05,579.84,20.37,-5.00,-9.00,360.00},
{3594,-3555.20,579.84,20.97,18.00,-3.90,270.00},
{16105,-3576.83,590.48,18.32,4.00,-7.00,270.00},
{3285,-3564.12,586.40,20.00,5.00,0.00,576.00},
{3276,-3635.90,692.43,20.37,5.00,-10.00,100.00},
{3276,-3635.19,704.47,20.84,0.00,7.79,75.00},
{3276,-3630.93,715.07,19.39,0.00,-4.00,245.00},
{3276,-3624.67,725.59,18.76,0.00,3.00,57.00},
{3364,-3630.81,703.07,19.61,-5.00,5.00,0.00},
{11497,-3612.02,684.36,19.43,2.00,-3.00,50.00},
{3252,-3605.89,704.65,20.28,0.00,0.00,0.00},
{16051,-3522.39,726.45,9.48,0.00,0.00,0.00},
{3275,-3522.06,723.34,7.83,0.00,0.00,90.00},
{16406,-3542.61,713.98,10.94,0.00,0.00,270.00},
{3276,-3542.56,731.80,8.44,0.00,0.00,90.00},
{3276,-3535.86,720.90,6.95,0.00,6.00,12.00},
{4206,-3601.86,618.46,7.55,0.00,0.00,0.00},
{1308,-3539.63,726.77,7.21,10.00,15.00,0.00},
{1308,-3525.57,723.32,1.23,0.00,1.00,0.00},
{1308,-3554.39,714.91,8.38,-10.00,10.00,0.00},
{1308,-3601.57,701.88,20.55,0.00,12.00,0.00},
{1308,-3617.81,691.10,15.21,2.00,0.00,0.00},
{1308,-3676.53,648.89,15.74,0.00,25.00,0.00},
{848,-3674.86,648.68,16.25,0.00,0.00,0.00},
{1308,-3635.98,611.89,17.87,15.00,0.00,0.00},
{1308,-3616.75,595.76,15.79,-10.00,-5.00,0.00},
{1308,-3584.41,589.13,11.83,0.00,6.00,0.00},
{1308,-3566.83,582.20,13.47,7.00,0.00,0.00},
{4206,-3597.71,629.61,7.54,0.00,0.00,0.00},
{1308,-3593.74,651.57,8.96,0.00,4.00,0.00},
{846,-3611.57,678.15,19.19,-9.00,0.00,140.00},
{650,-3622.56,697.87,20.63,0.00,0.00,0.00},
{651,-3612.73,699.91,20.21,0.00,0.00,0.00},
{651,-3604.14,693.58,20.39,0.00,0.00,90.00},
{650,-3594.32,709.34,19.26,0.00,0.00,0.00},
{653,-3575.32,700.56,14.17,0.00,0.00,0.00},
{653,-3565.60,721.33,12.64,0.00,0.00,0.00},
{651,-3530.44,723.09,5.72,0.00,0.00,90.00},
{650,-3543.60,728.47,8.06,0.00,0.00,0.00},
{650,-3597.39,669.98,17.48,0.00,0.00,0.00},
{650,-3592.68,643.96,9.46,0.00,0.00,0.00},
{682,-3568.69,592.69,17.13,0.00,0.00,0.00},
{682,-3571.16,575.67,18.83,0.00,0.00,0.00},
{682,-3565.07,581.05,18.77,0.00,0.00,0.00},
{682,-3558.69,586.76,18.93,0.00,0.00,0.00},
{682,-3563.75,575.14,19.43,0.00,0.00,0.00},
{754,-3580.25,575.75,18.49,0.00,0.00,0.00},
{754,-3580.63,585.93,16.55,0.00,0.00,0.00},
{754,-3562.48,594.35,18.41,0.00,0.00,180.00},
{653,-3571.93,599.53,14.48,0.00,0.00,0.00},
{653,-3585.80,595.00,14.02,0.00,0.00,0.00},
{650,-3571.55,579.04,18.19,0.00,0.00,0.00},
{650,-3597.80,585.30,13.50,0.00,0.00,0.00},
{682,-3608.70,592.28,15.06,0.00,0.00,0.00},
{894,-3616.46,595.79,15.78,0.00,0.00,0.00},
{894,-3609.47,609.80,7.77,0.00,0.00,0.00},
{894,-3584.83,617.28,10.10,0.00,0.00,0.00},
{894,-3547.22,580.09,21.69,0.00,0.00,0.00},
{894,-3583.82,567.20,19.36,0.00,0.00,0.00},
{855,-3606.51,566.79,14.76,0.00,0.00,0.00},
{855,-3610.47,563.98,15.28,0.00,0.00,0.00},
{855,-3613.48,562.66,15.65,0.00,0.00,0.00},
{855,-3617.16,561.06,16.10,0.00,0.00,0.00},
{855,-3618.42,566.37,15.76,0.00,0.00,0.00},
{855,-3613.56,569.07,15.17,0.00,0.00,0.00},
{855,-3609.84,570.78,14.74,0.00,0.00,0.00},
{855,-3604.92,572.10,14.28,0.00,0.00,0.00},
{855,-3600.08,570.23,13.95,0.00,0.00,0.00},
{855,-3601.10,566.68,14.18,0.00,0.00,0.00},
{855,-3616.40,557.27,15.86,0.00,0.00,0.00},
{855,-3622.35,568.64,15.61,0.00,0.00,0.00},
{855,-3621.13,575.02,15.02,0.00,0.00,0.00},
{855,-3624.69,582.22,14.22,0.00,0.00,0.00},
{753,-3628.24,608.45,17.68,0.00,0.00,0.00},
{815,-3638.24,612.26,17.72,0.00,0.00,0.00},
{653,-3657.81,599.06,16.93,0.00,0.00,0.00},
{650,-3667.72,596.56,17.32,0.00,0.00,0.00},
{650,-3677.12,595.79,17.45,0.00,0.00,9.00},
{753,-3670.03,606.23,15.97,0.00,0.00,0.00},
{893,-3666.36,604.40,16.26,0.00,0.00,0.00},
{893,-3661.52,592.26,17.46,0.00,0.00,0.00},
{893,-3672.70,595.39,17.43,0.00,0.00,0.00},
{682,-3665.98,634.41,13.17,0.00,0.00,0.00},
{679,-3667.31,639.58,14.12,0.00,0.00,0.00},
{893,-3667.49,640.80,14.35,0.00,0.00,0.00},
{651,-3676.16,671.87,18.06,0.00,0.00,0.00},
{651,-3656.82,675.67,17.97,0.00,0.00,0.00},
{650,-3662.46,686.45,17.65,0.00,0.00,0.00},
{653,-3644.76,694.09,16.65,0.00,0.00,0.00},
{894,-3637.30,716.62,15.57,0.00,0.00,0.00},
{893,-3634.61,721.63,15.28,0.00,0.00,0.00},
{893,-3616.86,733.81,17.94,0.00,0.00,0.00},
{893,-3608.01,710.33,20.21,0.00,0.00,0.00},
{893,-3552.76,714.39,7.73,0.00,0.00,0.00},
{806,-3536.78,717.77,5.77,0.00,0.00,0.00},
{806,-3537.13,715.97,5.54,0.00,0.00,0.00},
{855,-3533.82,715.82,5.16,0.00,0.00,0.00},
{855,-3534.58,719.31,5.72,0.00,0.00,0.00},
{855,-3537.46,717.27,5.77,0.00,0.00,0.00},
{855,-3536.84,714.20,5.24,0.00,0.00,0.00},
{855,-3528.47,715.39,4.89,0.00,0.00,0.00},
{855,-3519.63,723.17,7.05,0.00,0.00,0.00},
{855,-3516.62,723.61,6.89,0.00,0.00,0.00},
{653,-3517.12,714.85,7.20,0.00,0.00,0.00},
{893,-3529.42,731.42,6.58,0.00,0.00,0.00},
{855,-3576.57,740.97,18.15,0.00,0.00,0.00},
{855,-3572.21,742.48,17.32,0.00,0.00,0.00},
{855,-3567.62,744.07,16.44,0.00,0.00,0.00},
{855,-3569.67,745.53,17.14,0.00,0.00,0.00},
{855,-3572.98,746.82,18.12,0.00,0.00,0.00},
{855,-3576.40,746.84,18.95,0.00,0.00,0.00},
{855,-3579.80,746.20,19.67,0.00,0.00,0.00},
{855,-3580.72,742.92,19.43,0.00,0.00,0.00},
{855,-3584.00,742.08,20.01,0.00,0.00,0.00},
{855,-3589.46,742.47,20.74,0.00,0.00,0.00},
{855,-3581.46,731.42,17.98,0.00,0.00,0.00},
{855,-3575.43,742.88,18.15,0.00,0.00,0.00},
{855,-3574.55,746.37,18.44,0.00,0.00,0.00},
{855,-3569.98,745.97,17.28,0.00,0.00,0.00},
{855,-3566.21,741.84,15.79,0.00,0.00,0.00},
{855,-3562.95,743.71,15.16,0.00,0.00,0.00},
{855,-3564.82,747.62,16.26,0.00,0.00,0.00},
{855,-3567.48,750.36,15.70,0.00,0.00,0.00},
{855,-3583.90,737.21,19.31,0.00,0.00,0.00},
{846,-3588.00,736.81,20.52,12.00,1.00,54.00},
{893,-3660.62,720.74,18.21,0.00,0.00,0.00},
{893,-3680.42,684.74,18.25,0.00,0.00,0.00}
};

new Float:NorthwoodSpawns[8][4] = {
{-3605.5710,589.2153,15.5479,36.750},
{-3582.2661,584.2823,17.6050,37.168},
{-3569.5542,581.7020,19.2289,26.434},
{-3569.3577,599.4588,17.2160,38.549},
{-3526.0474,728.8414,7.4106,98.7494},
{-3525.5789,718.2654,7.1687,59.4779},
{-3530.7007,720.5005,6.3598,322.857},
{-3541.6758,725.7909,8.4617,156.884}
};

public OnFilterScriptInit()
{
	print("\n-----------------------------------------------------");
	print(" Northwood Canyon, Copyright 2007-2008 by [FFC]MaCcA");
	print("-----------------------------------------------------\n");
	for(new i = 0; i < sizeof(CanyonObj); i++)
 	{
		CreateObject(CanyonObj[i][ModelID], CanyonObj[i][X], CanyonObj[i][Y], CanyonObj[i][Z], CanyonObj[i][XR], CanyonObj[i][YR], CanyonObj[i][ZR]);
 	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	SendClientMessage(playerid, 0xFF8300C8, "To visit Northwood Canyon� by [FFC]MaCcA, type '/canyon'");
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/canyon", cmdtext, true, 10) == 0)
	{
	    SendClientMessage(playerid, 0xFF8300C8, "Welcome to Northwood Canyon�, type '/exitcanyon' to exit");
	    new rand = random(sizeof(NorthwoodSpawns));
		SetPlayerPos(playerid, NorthwoodSpawns[rand][0], NorthwoodSpawns[rand][1], NorthwoodSpawns[rand][2]);
		GivePlayerWeapon(playerid, 26, 999999); GivePlayerWeapon(playerid, 33, 999999); GivePlayerWeapon(playerid, 30, 999999);
	   	SetPlayerInterior(playerid, 0);
		return 1;
	}
	if (strcmp("/exitcanyon", cmdtext, true, 10) == 0)
	{
	    SpawnPlayer(playerid);
	}
	return 0;
}