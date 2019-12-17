/*------------------------------------------------------------------------------
=-------------------|===-- de_island v0.0.2 by C0met --===|--------------------=

=---------------------|===-- http://thesinclan.net --===|----------------------=

=---------------------|===-- Please report any bugs --===|---------------------=
------------------------------------------------------------------------------*/
// Thanks to Jamgla, [Fackin']Luke, Sarge, and the [SiN] Clan who helped with testing.
//Thanks to TheAlpha and [Fackin']Luke and Damospiderman for scripting assistance.

#include <a_samp>
#include <core>
#include <float>

static gTeam[MAX_PLAYERS];
new gPlayerClass[MAX_PLAYERS];

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_BLUE 0x95DFECFF
#define COLOR_RED 0xFF6A6AFF
#define COLOR_DIS_RED 0xFF0000FF
#define COLOR_CON_GREEN 0x00FF00FF
#define COLOR_WHITE 0xFFFFFFFF
#define TEAM_TERRORIST 0
#define TEAM_COUNTER-TERRORIST 1

new Text:Time;
new Text:C;
new Menu:menu;
new DMTime;
new Count;
new IsBombPlanted = 0;
new DefuseCode = 0;
new Defused = 0;
new TeamKill[MAX_PLAYERS];

forward DMTimer(playerid);
forward Counter(playerid);
forward Exiter(playerid);
forward ExitTheGameMode(playerid);
forward OnPlayerSelectedMenuRow(playerid, row);
forward WeaponBuyArmour(playerid);
forward WeaponBuyDeagle(playerid);
forward WeaponBuyGrenade(playerid);
forward WeaponBuyShotgun(playerid);
forward WeaponBuyAK(playerid);
forward WeaponBuySniper(playerid);
forward WeaponBuyRPG(playerid);
forward ExitMenu(playerid);
forward SendPlayerFormattedText(playerid, const string[], define);
forward OnPlayerEnterCheckpoint(playerid);
//------------------------------------------------------------------------------
main()
{
	print("\n----------------------------------");
	print("           de_island v0.0.2         ");
	print("              by C0met            ");
	print("----------------------------------\n");
}
//------------------------------------------------------------------------------
public OnGameModeInit()
{
 	SetGameModeText("de_island v0.0.2");
	SetTeamCount(2);
 	ShowNameTags(1);
	ShowPlayerMarkers(1);
	SetWorldTime(12);
    SetWeather(9);
    UsePlayerPedAnims();
   	DMTime = 900;
	SetTimer("DMTimer", 1000, 1);

	menu = CreateMenu("Weapons Menu", 2, 200.0, 150.0, 120.0, 50.0);
    SetMenuColumnHeader(menu, 0, "Weapon");
	SetMenuColumnHeader(menu, 1, "Cost");
	AddMenuItem(menu, 0, "Armour");
	AddMenuItem(menu, 0, "Deagle");
	AddMenuItem(menu, 0, "Granade");
	AddMenuItem(menu, 0, "Shotgun");
	AddMenuItem(menu, 0, "AK-47");
	AddMenuItem(menu, 0, "Sniper");
	AddMenuItem(menu, 0, "RPG");
	AddMenuItem(menu, 1, "$200");
	AddMenuItem(menu, 1, "$200");
	AddMenuItem(menu, 1, "$300");
	AddMenuItem(menu, 1, "$500");
	AddMenuItem(menu, 1, "$2000");
	AddMenuItem(menu, 1, "$3000");
	AddMenuItem(menu, 1, "$4000");
	
	AddPlayerClass(29, 3841.220703, -1936.072998, 3.049613, 360, 4, 0, 23, 100, 0, 0); //T
	AddPlayerClass(121, 3841.220703, -1936.072998, 3.049613, 360, 4, 0, 23, 100, 0, 0); //T
	AddPlayerClass(222, 3841.220703, -1936.072998, 3.049613, 360, 4, 0, 23, 100, 0, 0); //T
	AddPlayerClass(181, 3841.220703, -1936.072998, 3.049613, 360, 4, 0, 23, 100, 0, 0); //T
	AddPlayerClass(284, 3742.5508, -1650.1516, 8.9869, 270.0665, 4, 0, 23, 100, 0, 0); //CT
	AddPlayerClass(285, 3742.5508, -1650.1516, 8.9869, 270.0665, 4, 0, 23, 100, 0, 0); //CT
	AddPlayerClass(163, 3742.5508, -1650.1516, 8.9869, 270.0665, 4, 0, 23, 100, 0, 0); //CT
	AddPlayerClass(164, 3742.5508, -1650.1516, 8.9869, 270.0665, 4, 0, 23, 100, 0, 0); //CT

	CreateObject(3985, 3778.121338, -1808.915039, 1.468603, 0, 0, 0);
	CreateObject(3997, 3777.374756, -1899.268677, 2.389236, 0, 0, 0);
	CreateObject(617, 3744.373291, -1797.065430, 2.431187, 0, 0, 0);
	CreateObject(617, 3743.844971, -1788.524780, 2.431187, 0, 0, 0);
	CreateObject(617, 3748.913574, -1781.673828, 2.431187, 0, 0, 0);
	CreateObject(617, 3749.797607, -1786.721802, 2.431187, 0, 0, 0);
	CreateObject(617, 3749.647705, -1790.921021, 2.431187, 0, 0, 0);
	CreateObject(617, 3748.439453, -1799.815186, 2.423609, 0, 0, 0);
	CreateObject(617, 3811.598633, -1785.623901, 2.431187, 0, 0, 0);
	CreateObject(617, 3810.450684, -1788.636353, 2.431185, 0, 0, 0);
	CreateObject(617, 3811.688965, -1796.372803, 2.431187, 0, 0, 0);
	CreateObject(617, 3811.265381, -1801.104736, 2.431187, 0, 0, 0);
	CreateObject(617, 3810.335449, -1809.212891, 2.431187, 0, 0, 0);
	CreateObject(617, 3811.055664, -1815.238770, 2.356187, 0, 0, 0);
	CreateObject(617, 3804.288330, -1811.292358, 2.431189, 0, 0, 0);
	CreateObject(617, 3811.687988, -1804.140015, 2.431187, 0, 0, 0);
	CreateObject(617, 3804.456299, -1785.385986, 2.431187, 0, 0, 0);
	CreateObject(617, 3778.611084, -1810.204590, 2.056185, 0, 0, 0);
	CreateObject(617, 3745.088135, -1845.649658, 2.883070, 0, 0, 0);
	CreateObject(617, 3727.938477, -1845.650269, 2.758070, 0, 0, 0);
	CreateObject(617, 3711.161377, -1844.939087, 2.883070, 0, 0, 0);
	CreateObject(617, 3704.008301, -1849.765259, 2.883071, 0, 0, 0);
	CreateObject(617, 3704.548340, -1859.262817, 2.883071, 0, 0, 0);
	CreateObject(617, 3813.052734, -1844.985229, 2.883070, 0, 0, 0);
	CreateObject(617, 3826.631836, -1845.149292, 2.783070, 0, 0, 0);
	CreateObject(617, 3844.761475, -1845.744873, 2.883070, 0, 0, 0);
	CreateObject(617, 3851.853027, -1850.503662, 2.883070, 0, 0, 0);
	CreateObject(617, 3851.792969, -1861.712158, 2.883070, 0, 0, 0);
	CreateObject(617, 3851.195801, -1910.569580, 2.883070, 0, 0, 0);
	CreateObject(617, 3851.031738, -1917.827759, 2.875378, 0, 0, 0);
	CreateObject(617, 3852.940674, -1927.231567, 2.875378, 0, 0, 0);
	CreateObject(617, 3848.707520, -1929.324951, 2.883070, 0, 0, 0);
	CreateObject(617, 3841.517334, -1928.339844, 2.883070, 0, 0, 0);
	CreateObject(617, 3812.888672, -1928.995239, 2.875378, 0, 0, 0);
	CreateObject(617, 3808.085449, -1928.412231, 2.875379, 0, 0, 0);
	CreateObject(617, 3802.198242, -1928.728027, 2.875378, 0, 0, 0);
	CreateObject(617, 3796.244385, -1929.663086, 2.783070, 0, 0, 0);
	CreateObject(617, 3790.354492, -1929.193726, 2.883070, 0, 0, 0);
	CreateObject(617, 3764.543457, -1929.785034, 2.883070, 0, 0, 0);
	CreateObject(617, 3759.313721, -1929.996216, 2.883070, 0, 0, 0);
	CreateObject(617, 3752.641113, -1929.585571, 2.333068, 0, 0, 0);
	CreateObject(617, 3743.572754, -1929.649658, 0.498078, 0, 0, 0);
	CreateObject(617, 3717.822266, -1927.416382, 2.875378, 0, 0, 0);
	CreateObject(617, 3710.672852, -1928.509644, 2.875378, 0, 0, 0);
	CreateObject(617, 3703.468994, -1927.080566, 2.883070, 0, 0, 0);
	CreateObject(617, 3702.872070, -1921.720581, 2.875377, 0, 0, 0);
	CreateObject(617, 3705.318604, -1913.712524, 2.875378, 0, 0, 0);
	CreateObject(617, 3735.297607, -1845.358643, 2.883070, 0, 0, 0);
	CreateObject(746, 3751.690674, -1845.448486, 2.066913, 0, 0, 0);
	CreateObject(746, 3800.030762, -1845.162842, 1.491919, 0, 0, 0);
	CreateObject(746, 3777.259521, -1824.866943, 2.240030, 0, 0, 0);
	CreateObject(746, 3786.019287, -1818.591553, 2.265030, 0, 0, 0);
	CreateObject(746, 3782.597168, -1823.750977, 1.615030, 0, 0, 0);
	CreateObject(746, 3775.522949, -1815.494507, 2.090029, 0, 0, 0);
	CreateObject(746, 3771.311279, -1809.976685, 1.765029, 0, 0, 0);
	CreateObject(746, 3771.247559, -1816.608521, 2.040029, 0, 0, 0);
	CreateObject(746, 3784.468262, -1812.824219, 2.390030, 0, 0, 0);
	CreateObject(10984, 3738.215332, -1867.405151, 3.072792, 0, 0, 0);
	CreateObject(10984, 3752.136719, -1892.332520, 3.172792, 0, 0, 0);
	CreateObject(10984, 3780.390137, -1876.061157, 3.047792, 0, 0, 0);
	CreateObject(10984, 3800.839355, -1897.550903, 3.147792, 0, 0, 0);
	CreateObject(16113, 3746.531006, -1966.120972, -2.452772, 0, 0, 34.3775);
	CreateObject(16113, 3795.840576, -1960.762085, -1.079789, 0, 0, 34.3775);
	CreateObject(16114, 3703.600830, -1955.722412, -3.206566, 0, 0, 68.7549);
	CreateObject(16116, 3848.479004, -1966.087891, -0.925477, 0, 0, 85.9437);
	CreateObject(16118, 3693.187256, -1924.443604, -2.049375, 0, 0, 0);
	CreateObject(16118, 3692.460205, -1873.314819, -0.625003, 0, 0, 0);
	CreateObject(16120, 3869.513428, -1924.708374, -1.811163, 0, 0, 136.5463);
	CreateObject(16133, 3832.373291, -1797.435059, -1.569727, 0, 0, 0);
	CreateObject(16121, 3695.347412, -1834.550659, -2.710145, 0, 0, 282.6507);
	CreateObject(746, 3805.085449, -1868.801025, 1.716919, 0, 0, 0);
	CreateObject(746, 3829.375488, -1903.649902, 1.266919, 0, 0, 0);
	CreateObject(746, 3716.799072, -1891.052002, 1.591919, 0, 0, 0);
	CreateObject(2048, 3746.742676, -1817.410767, 7.066750, 0, 0, 126.3372);
	CreateObject(3359, 3846.489990, -1885.939331, 2.115768, 0, 0, 261.1648);
	CreateObject(3331, 3772.725342, -1734.797485, 10.583057, 0, 0, 358.2811);
	CreateObject(18449, 3780.829346, -1735.518677, 1.545389, 0, 0, 88.522);
	CreateObject(16250, 3801.727783, -1629.549805, 3.359890, 2.5783, 0, 359.1406);
	CreateObject(3866, 3820.597656, -1684.277832, 10.198692, 0, 0, 0);
	CreateObject(3887, 3737.653076, -1665.995483, 9.670225, 0, 0, 180.4818);
	CreateObject(11088, 3803.726563, -1608.180176, 8.152270, 0, 0, 0);
	CreateObject(16122, 3749.488281, -1559.893066, -1.625032, 0, 0, 299.8394);
	CreateObject(16122, 3831.522949, -1556.255493, -2.315955, 0, 0, 299.8394);
	CreateObject(16113, 3807.672363, -1719.624512, 0.594743, 0, 0, 50.6294);
	CreateObject(16113, 3853.361816, -1705.937866, 0.664739, 0, 0, 60.1606);
	CreateObject(16113, 3889.707275, -1674.153564, 0.605174, 0, 0, 135.8683);
	CreateObject(16113, 3891.683350, -1628.159668, -2.279987, 0, 0, 124.6183);
	CreateObject(16113, 3901.031738, -1589.815186, 1.310414, 0, 0, 141.8071);
	CreateObject(16113, 3900.045166, -1551.855835, -0.733480, 0, 0, 167.5902);
	CreateObject(16121, 3721.550049, -1812.392822, 0.601681, 0, 0, 334.2169);
	CreateObject(16121, 3754.285889, -1766.122559, -3.165267, 0, 0, 269.7591);
	CreateObject(16121, 3725.343262, -1784.240723, -4.050146, 0, 0, 317.0282);
	CreateObject(16133, 3847.399658, -1834.821655, -11.214055, 0, 0, 78.2087);
	CreateObject(16133, 3863.967041, -1883.009277, -8.849899, 0, 0, 348.8273);
	CreateObject(16133, 3816.631104, -1769.311768, 0.759719, 0, 0, 64.4578);
	CreateObject(16122, 3716.698975, -1602.093994, -3.595140, 0, 0, 12.8916);
	CreateObject(16113, 3704.864502, -1660.468018, -4.946049, 0, 0, 124.6183);
	CreateObject(16113, 3705.154785, -1690.169922, -4.051329, 0, 0, 124.6183);
	CreateObject(16113, 3722.283203, -1711.643677, -2.978183, 0, 0, 18.1519);
	CreateObject(16113, 3748.208984, -1711.566040, -4.522522, 0, 0, 22.4491);
	CreateObject(6925, 3732.034424, -1902.202515, 5.098267, 0, 0, 178.763);
	CreateObject(3287, 3769.027588, -1635.702881, 4.327255, 0, 0, 90.2409);
	CreateObject(3638, 3771.218750, -1618.775391, 4.424909, 0, 0, 0);
	CreateObject(3643, 3778.964355, -1593.466431, 7.693014, 0, 0, 0);
	CreateObject(1486, 3815.942627, -1622.164551, 5.178471, 0, 0, 0);
	CreateObject(16133, 3863.146484, -1854.229858, -9.058247, 0, 0, 19.767);
	CreateObject(16133, 3829.255371, -1822.618774, -10.779113, 0, 0, 356.5623);
	CreateObject(1457, 3761.042480, -1687.234985, 3.907187, 0, 0, 158.9958);
	CreateObject(3403, 3770.570068, -1635.897583, 4.568488, 0, 0, 0);
	CreateObject(13367, 3853.456299, -1681.294189, 17.057756, 0, 0, 0);
	CreateObject(3364, 3856.212158, -1645.033569, 6.782847, 0, 0, 0);
	CreateObject(16317, 3850.387939, -1585.649170, 3.233510, 0, 0, 0);
	CreateObject(16317, 3779.715820, -1662.482178, 0.426743, 0, 0, 0);
	CreateObject(16317, 3757.392090, -1584.578857, 1.772752, 0, 0, 0);
	CreateObject(16641, 3818.465820, -1636.444092, 4.569885, 0, 0, 0);
	CreateObject(3794, 3829.120850, -1625.689331, 3.407922, 0, 0, 0);
	CreateObject(3393, 3830.858154, -1615.566162, 2.806302, 0, 0, 0);
	CreateObject(3279, 3868.000977, -1650.742798, 8.353441, 0, 0, 0);
	CreateObject(3279, 3868.520020, -1577.123169, 3.925404, 0, 0, 0);
	CreateObject(3279, 3813.819336, -1573.558716, 2.956886, 0, 0, 91.1003);
	CreateObject(3279, 3750.750488, -1604.249390, 1.871831, 0, 0, 185.6384);
	CreateObject(1226, 3785.661133, -1752.163208, 5.788559, 0, 0, 0);
	CreateObject(1226, 3787.456787, -1700.563110, 5.690557, 0, 0, 0);
	CreateObject(1226, 3774.239990, -1767.376709, 5.715558, 0, 0, 171.8874);
	CreateObject(1226, 3776.130371, -1718.501709, 5.840558, 0, 0, 171.8874);
	CreateObject(1340, 3749.228027, -1812.694336, 3.557362, 0, 0, 312.731);
	CreateObject(1346, 3846.875977, -1893.877319, 3.740242, 0, 0, 353.1245);
	CreateObject(2600, 3813.981934, -1575.621094, 19.807283, 0, 0, 0);
	CreateObject(18248, 3825.377441, -1593.027954, 10.821529, 3.4377, 359.1406, 322.1848);
	CreateObject(972, 3785.309326, -1735.030884, 1.886021, 0, 0, 0);
	CreateObject(972, 3785.263916, -1752.345337, 1.945079, 0, 0, 0);
	CreateObject(972, 3770.069336, -1730.167603, 2.521740, 0, 0, 0);
	CreateObject(972, 3770.095215, -1752.466431, 2.688019, 0, 0, 0);
	CreateObject(746, 3829.696777, -1864.711914, 2.041917, 0, 0, 0);
	CreateObject(746, 3772.834961, -1955.565674, 1.816913, 0, 0, 0);
	CreateObject(16317, 3753.422852, -1624.493652, 0.469286, 0, 0, 0);
	CreateObject(16317, 3809.119629, -1653.587036, 2.215257, 0, 0, 0);
	CreateObject(16317, 3851.186035, -1624.065674, 4.829964, 0, 0, 0);
	CreateObject(16317, 3771.600586, -1679.193604, -0.255691, 0, 0, 0);
	CreateObject(5005, 3803.924072, -1553.578125, 14.777943, 0, 0, 0);
	CreateObject(5005, 3803.778320, -1553.969360, 21.382862, 0, 0, 0);
	CreateObject(5005, 3881.338867, -1632.727661, 14.881422, 0, 0, 265.462);
	CreateObject(5005, 3880.453369, -1633.617920, 21.416866, 0, 0, 265.462);
	CreateObject(5005, 3882.955078, -1622.336548, 8.310261, 0, 0, 265.462);
	CreateObject(5005, 3833.176025, -1553.716553, 9.064018, 0, 0, 0);
	CreateObject(5005, 3708.000977, -1631.697021, 8.069273, 0, 0, 258.5865);
	CreateObject(5005, 3707.569580, -1631.473267, 14.637733, 0, 0, 258.5865);
	CreateObject(5005, 3707.219971, -1631.169556, 21.453526, 0, 0, 258.5865);
	CreateObject(5005, 3873.745117, -1718.870728, 14.844450, 0, 0, 0);
	CreateObject(5005, 3873.562988, -1719.338745, 21.666723, 0, 0, 0);
	CreateObject(5005, 3689.349854, -1712.956665, 8.434191, 0, 0, 0);
	CreateObject(5005, 3689.424316, -1713.504150, 15.415840, 0, 0, 0);
	CreateObject(5005, 3689.103760, -1713.954590, 21.851450, 0, 0, 0);
	CreateObject(5005, 3789.302246, -1966.343384, 7.499390, 0, 0, 0);
	CreateObject(5005, 3775.989502, -1966.770752, 14.092350, 0, 0, 0);
	CreateObject(5005, 3776.361328, -1967.271973, 20.714647, 0, 0, 0);
	CreateObject(5005, 3691.835938, -1884.907349, 7.028073, 0, 0, 273.1969);
	CreateObject(5005, 3692.077148, -1884.918091, 13.567445, 0, 0, 273.1969);
	CreateObject(5005, 3691.713623, -1885.082764, 20.269812, 0, 0, 273.1969);
	CreateObject(5005, 3863.000244, -1885.494995, 7.132356, 0, 0, 273.1969);
	CreateObject(5005, 3862.603760, -1884.007446, 13.119943, 0, 0, 273.1969);
	CreateObject(5005, 3861.999512, -1884.217041, 20.043493, 0, 0, 273.1969);
	CreateObject(16121, 3742.542480, -1761.955566, 5.392645, 0, 12.8916, 278.3535);
	CreateObject(16121, 3823.560791, -1774.394165, 12.135601, 0, 12.8916, 17.1887);
	CreateObject(16121, 3836.728760, -1813.656372, 2.196160, 0, 12.8916, 12.8916);
	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerSpawn(playerid)
{
    SetPlayerCheckpoint(playerid,3812.7559,-1632.6198,1.5150,5.0);
	SetPlayerInterior(playerid,0);

	if(gTeam[playerid] == TEAM_TERRORIST) {
	SetPlayerColor(playerid,COLOR_RED); 
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, 1000);
		}
	else if(gTeam[playerid] == TEAM_COUNTER-TERRORIST) {
	SetPlayerColor(playerid,COLOR_BLUE); 
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, 3000);
	}
	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerDeath(playerid, killerid, reason)
{
		if(killerid == INVALID_PLAYER_ID)
		{
        SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
		}
		else if(gTeam[killerid] != gTeam[playerid]) {
	    	// Valid kill
	    	SendDeathMessage(killerid,playerid,reason);
			SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
			GivePlayerMoney(killerid, 1000);
		}
		else {
			//Team Killer!
		new warning[256];
		format(warning, sizeof(warning), "<> Be careful! You have been punished for teamkilling.");
		SendClientMessage(killerid, 0xFFFF00AA, warning);
		SendDeathMessage(killerid,playerid,reason);
		GivePlayerMoney(killerid, -1000);
		SetPlayerScore(killerid, GetPlayerScore(killerid) - 1);
		TeamKill[killerid]++;
		}
		if(TeamKill[killerid] == 3) { // 3 teamkills is a kick
        SendClientMessage(killerid, COLOR_RED, "You have been kicked for continous teamkilling!");
		Kick(killerid);
		}
		return 1;
}
//------------------------------------------------------------------------------
public OnPlayerRequestClass(playerid, classid)
{
    SetPlayerColor(playerid, COLOR_GREY);
	SetPlayerClass(playerid, classid);
	gPlayerClass[playerid] = classid;
	ResetPlayerMoney(playerid);

	switch (classid) {
	    case 0:
	        {
				GameTextForPlayer(playerid, "~n~~n~~n~~r~TERRORIST", 500, 3);
                
				SetPlayerPos(playerid,3841.220703, -1936.072998, 3.049613);
				SetPlayerFacingAngle(playerid, 20.0);
				SetPlayerCameraPos(playerid,3840.8694,-1927.6399,6.8892);
				SetPlayerCameraLookAt(playerid,3841.220703, -1936.072998, 3.049613);
			}
		case 1:
		    {
				GameTextForPlayer(playerid, "~n~~n~~n~~r~TERRORIST", 500, 3);
				
				SetPlayerPos(playerid,3841.220703, -1936.072998, 3.049613);
				SetPlayerFacingAngle(playerid, 20.0);
				SetPlayerCameraPos(playerid,3840.8694,-1927.6399,6.8892);
				SetPlayerCameraLookAt(playerid,3841.220703, -1936.072998, 3.049613);
			}
        case 2:
	        {
				GameTextForPlayer(playerid, "~n~~n~~n~~r~TERRORIST", 500, 3);
				
				SetPlayerPos(playerid,3841.220703, -1936.072998, 3.049613);
				SetPlayerFacingAngle(playerid, 20.0);
				SetPlayerCameraPos(playerid,3840.8694,-1927.6399,6.8892);
				SetPlayerCameraLookAt(playerid,3841.220703, -1936.072998, 3.049613);
			}
        case 3:
	        {
				GameTextForPlayer(playerid, "~n~~n~~n~~r~TERRORIST", 500, 3);
				
				SetPlayerPos(playerid,3841.220703, -1936.072998, 3.049613);
				SetPlayerFacingAngle(playerid, 20.0);
				SetPlayerCameraPos(playerid,3840.8694,-1927.6399,6.8892);
				SetPlayerCameraLookAt(playerid,3841.220703, -1936.072998, 3.049613);
			}
        case 4:
	        {
				GameTextForPlayer(playerid, "~n~~n~~n~~b~COUNTER-TERRORIST", 500, 3);
				
				SetPlayerPos(playerid,3742.5508, -1650.1516, 8.9869);
				SetPlayerFacingAngle(playerid, 0.0);
				SetPlayerCameraPos(playerid,3743.0801,-1640.6072,10.5810);
				SetPlayerCameraLookAt(playerid,3742.5508, -1650.1516, 8.9869);
			}
        case 5:
	        {
				GameTextForPlayer(playerid, "~n~~n~~n~~b~COUNTER-TERRORIST", 500, 3);
				
				SetPlayerPos(playerid,3742.5508, -1650.1516, 8.9869);
				SetPlayerFacingAngle(playerid, 0.0);
				SetPlayerCameraPos(playerid,3743.0801,-1640.6072,10.5810);
				SetPlayerCameraLookAt(playerid,3742.5508, -1650.1516, 8.9869);
			}
        case 6:
	        {
				GameTextForPlayer(playerid, "~n~~n~~n~~b~COUNTER-TERRORIST", 500, 3);
                
				SetPlayerPos(playerid,3742.5508, -1650.1516, 8.9869);
				SetPlayerFacingAngle(playerid, 0.0);
				SetPlayerCameraPos(playerid,3743.0801,-1640.6072,10.5810);
				SetPlayerCameraLookAt(playerid,3742.5508, -1650.1516, 8.9869);
			}
        case 7:
	        {
				GameTextForPlayer(playerid, "~n~~n~~n~~b~COUNTER-TERRORIST", 500, 3);
				
				SetPlayerPos(playerid,3742.5508, -1650.1516, 8.9869);
				SetPlayerFacingAngle(playerid, 0.0);
				SetPlayerCameraPos(playerid,3743.0801,-1640.6072,10.5810);
				SetPlayerCameraLookAt(playerid,3742.5508, -1650.1516, 8.9869);
			}
}
	return 1;
}
//------------------------------------------------------------------------------
SetPlayerClass(playerid, classid) {
	if(classid == 0 || classid == 1  || classid == 2  || classid == 3) {
	gTeam[playerid] = TEAM_TERRORIST;
	} else if(classid == 4 || classid == 5  || classid == 6  || classid == 7) {
	gTeam[playerid] = TEAM_COUNTER-TERRORIST;
	}
}
//------------------------------------------------------------------------------
public OnPlayerText(playerid,text[])
{
  if(text[0] == '!') {
    new name[24], string[256];
    GetPlayerName(playerid, name, 24);
    format(string, sizeof(string), "%s (TEAM): %s", name, text[1]);

    for(new i = 0; i < MAX_PLAYERS; i++) {
          if(IsPlayerConnected(i)) {
                if(gTeam[i] == gTeam[playerid])
                SendClientMessage(i, GetPlayerColor(playerid), string);
                }
          }
	return 0;
	}
  return 1;
}
//------------------------------------------------------------------------------
public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new idx;
	cmd = strtok(cmdtext, idx);

	if(strcmp(cmd, "/help", true, 5) == 0) {
	SendPlayerFormattedText(playerid,"<> Help: The two teams are Terrorists (red blimp) and Counter-Terrorists (blue blimp).",0);
    SendPlayerFormattedText(playerid,"<> Help: Type /commands for all the commands available.",0);
	return 1;
	}

	if(strcmp(cmd, "/commands", true, 9) == 0) {
	SendPlayerFormattedText(playerid,"<> Commands: Type /b to buy weapons & armour. /me command.",0);
	SendPlayerFormattedText(playerid,"<> Commands: Type '!' followed by your message for team chat.",0);
	SendPlayerFormattedText(playerid,"<> Commands: Terrorists type /plant to plant the bomb.",0);
	SendPlayerFormattedText(playerid,"<> Commands: Counter-Terrorists use /defuse to defuse the bomb.",0);
	SendPlayerFormattedText(playerid,"<> Commands: Type /objective-t for all Terrorists objectives.",0);
	SendPlayerFormattedText(playerid,"<> Commands: Type /objective-ct for all Counter Terrorists objectives.",0);
	return 1;
	}

	if(strcmp(cmd, "/objective-t", true, 12) == 0) {
	SendPlayerFormattedText(playerid,"<> Terrorists objective is to plant the bomb or kill all Counter terrorists within the time limit.",0);
 	SendPlayerFormattedText(playerid,"<> Don't allow Counter terrorists to defuse the bomb.",0);
	return 1;
	}

	if(strcmp(cmd, "/objective-ct", true, 13) == 0) {
	SendPlayerFormattedText(playerid,"<> Counter Terrorists objective is to kill all Terrorists and if they plant the bomb, defuse the bomb before it blows up.",0);
	return 1;
	}

	if(strcmp(cmd, "/b", true, 2) == 0) {
	ShowMenuForPlayer(menu, playerid);
    TogglePlayerControllable(playerid, 0);
	return 1;
	}

	if (strcmp("/kill", cmdtext, true, 5) == 0)
    {
    SetPlayerHealth(playerid, 0.0);
    return 1;
	}

	if (strcmp("/plant", cmdtext, true, 6) == 0 && gTeam[playerid] == TEAM_TERRORIST)
    {
        if(IsPlayerInCheckpoint(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "You planted the bomb!");
            GameTextForAll("~r~ The bomb has been planted!", 3000, 5);
            DisablePlayerCheckpoint(playerid);
            IsBombPlanted = 1;
			SetTimer("Counter", 1000, 1);
            Count = 30;
            return 1;
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "You can only plant the bomb in the checkpoint!");
            return 1;
        }
 		}

	if (strcmp("/defuse", cmdtext, true, 7) == 0 && gTeam[playerid] == TEAM_COUNTER-TERRORIST)
    {
        if(IsPlayerInCheckpoint(playerid) && IsBombPlanted)
        {
            SendClientMessage(playerid, COLOR_BLUE, "You must type '/27379384' to defuse the bomb quickly!");
			DefuseCode = 1;
            return 1;
        }
        else if(IsPlayerInCheckpoint(playerid))
        {
            SendClientMessage(playerid, COLOR_GREY, "The bomb hasn't been planted yet!");
            return 1;
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "You can only defuse the bomb in the checkpoint!");
            return 1;
		}
		}

	if (strcmp("/27379384", cmdtext, true, 9) == 0 && gTeam[playerid] == TEAM_COUNTER-TERRORIST)
    {
        if(IsPlayerInCheckpoint(playerid) && IsBombPlanted && DefuseCode)
        {
            Defused = 1;
            TogglePlayerControllable(playerid, 0);
            SendClientMessage(playerid, COLOR_BLUE, "You defused the bomb!");
 		 	DisablePlayerCheckpoint(playerid);
            SetTimer("ExitTheGameMode", 8000, 0);
            return 1;
        }
        else if(IsPlayerInCheckpoint(playerid))
        {
            SendClientMessage(playerid, COLOR_GREY, "The bomb isn't planted!");
            return 1;
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "You can only defuse the bomb in the checkpoint!");
            return 1;
			}
  		}

	if(strcmp(cmdtext, "/me", true, 3) == 0)
	{ 
		new str[256], pname[256];
		GetPlayerName(playerid, pname, 256);
		format(str, 256, "%s %s", pname, cmdtext[4]);
		SendClientMessageToAll(COLOR_WHITE, str);
		return 1;
}
	return 0;
}
//------------------------------------------------------------------------------
public WeaponBuyArmour(playerid)
{
if(GetPlayerMoney(playerid)>=200){
GivePlayerMoney(playerid, -200);
SetPlayerArmour(playerid, 100);
}
else if(GetPlayerMoney(playerid)<200){
SendClientMessage(playerid, COLOR_RED, "You can't afford that!");
}
return 1;
}

public WeaponBuyDeagle(playerid)
{
if(GetPlayerMoney(playerid)>=200){
GivePlayerMoney(playerid, -200);
GivePlayerWeapon(playerid,24,100);
}
else if(GetPlayerMoney(playerid)<200){
SendClientMessage(playerid, COLOR_RED, "You can't afford that!");
}
return 1;
}

public WeaponBuyGrenade(playerid)
{
if(GetPlayerMoney(playerid)>=300){
GivePlayerMoney(playerid, -300);
GivePlayerWeapon(playerid,16,10);
}
else if(GetPlayerMoney(playerid)<300){
SendClientMessage(playerid, COLOR_RED, "You can't afford that!");
}
return 1;
}

public WeaponBuyShotgun(playerid)
{
if(GetPlayerMoney(playerid)>=500){
GivePlayerMoney(playerid, -500);
GivePlayerWeapon(playerid,25,30);
}
else if(GetPlayerMoney(playerid)<500){
SendClientMessage(playerid, COLOR_RED, "You can't afford that!");
}
return 1;
}

public WeaponBuyAK(playerid)
{
if(GetPlayerMoney(playerid)>=2000){
GivePlayerMoney(playerid, -2000);
GivePlayerWeapon(playerid,30,150);
}
else if(GetPlayerMoney(playerid)<2000){
SendClientMessage(playerid, COLOR_RED, "You can't afford that!");
}
return 1;
}

public WeaponBuySniper(playerid)
{
if(GetPlayerMoney(playerid)>=3000){
GivePlayerMoney(playerid, -3000);
GivePlayerWeapon(playerid,34,20);
}
else if(GetPlayerMoney(playerid)<3000){
SendClientMessage(playerid, COLOR_RED, "You can't afford that!");
}
return 1;
}

public WeaponBuyRPG(playerid)
{
if(GetPlayerMoney(playerid)>=4000){
GivePlayerMoney(playerid, -4000);
GivePlayerWeapon(playerid,35,10);
}
else if(GetPlayerMoney(playerid)<4000){
SendClientMessage(playerid, COLOR_RED, "You can't afford that!");
}
return 1;
}
//------------------------------------------------------------------------------
public OnPlayerSelectedMenuRow(playerid, row)
	{
    new Menu:Current = GetPlayerMenu(playerid);
  	if(Current == menu) {
	new Float:x;
	new Float:y;
	new Float:z;
	GetPlayerPos(playerid, x, y, z);
	TogglePlayerControllable(playerid, 1);
    switch(row)
	{
	case 0: WeaponBuyArmour(playerid);
	}
    switch(row)
	{
	case 1: WeaponBuyDeagle(playerid);
	}
    switch(row)
	{
	case 2: WeaponBuyGrenade(playerid);
	}
    switch(row)
	{
    case 3: WeaponBuyShotgun(playerid);
	}
	switch(row)
	{
    case 4: WeaponBuyAK(playerid);
	}
	switch(row)
	{
    case 5: WeaponBuySniper(playerid);
	}
	switch(row)
	{
	case 6: WeaponBuyRPG(playerid);
	}
	}
	}
//------------------------------------------------------------------------------
public OnPlayerExitedMenu(playerid)
{
TogglePlayerControllable(playerid,1);
}
//------------------------------------------------------------------------------
public SendPlayerFormattedText(playerid, const string[], define)

{
	new tmpbuf[256];
	format(tmpbuf, sizeof(tmpbuf), string, define);
	SendClientMessage(playerid, 0x8CFFA9FF, tmpbuf);
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
//------------------------------------------------------------------------------
public DMTimer()
{
    DMTime --;
    new tmp[256];
    TextDrawDestroy(Text:Time);
    format(tmp, sizeof tmp, "%s", TimeConvert(DMTime));
    
	Time = TextDrawCreate(300.0, 10.0, tmp);
	TextDrawUseBox(Text:Time, 1);
	TextDrawTextSize(Text:Time, 350.0, 30.0);
	TextDrawSetShadow(Text:Time, 0);
	TextDrawSetOutline(Text:Time, 1);
	TextDrawShowForAll(Text:Time);
	

    if (DMTime < 0.1)
    {
        for( new playerid = 0; playerid < MAX_PLAYERS; playerid ++ )
 	{
     	TogglePlayerControllable(playerid, 0);
 	}
        GameTextForAll("~w~ The round is over, ~b~Counter Terrorists ~w~win!", 3000, 5);
        SetTimer("ExitTheGameMode", 8000, 0);
   		return 1;
 	}
 	return 0;
}
//------------------------------------------------------------------------------
public Counter()
{
    Count --;
    new tmp[256];
    TextDrawHideForAll(Text:C);
    format(tmp, sizeof tmp, "Bomb will blow in : %s", TimeConvert(Count));

	C = TextDrawCreate(220.0, 310.0, tmp);
	TextDrawSetOutline(Text:C, 1);
	TextDrawShowForAll(Text:C);

	if	(Defused)
		{
        GameTextForAll("~w~ The round is over, ~b~Counter Terrorists ~w~win!", 3000, 5);
        TextDrawHideForAll(Text:C);
        return 1;
 	}
        
	else if (Count < 0.1)
    {
        for( new playerid = 0; playerid < MAX_PLAYERS; playerid ++ )
 	{
     	TogglePlayerControllable(playerid, 0);

 	}
        CreateExplosion(3812.4802,-1632.6268,3.8150,10,200000000.0);
        CreateExplosion(3812.4804,-1632.6268,3.8150,10,200000000.0);
        CreateExplosion(3812.4806,-1632.6268,3.8150,10,200000000.0);
        CreateExplosion(3812.4808,-1632.6268,3.8150,10,200000000.0);
        CreateExplosion(3812.4810,-1632.6268,3.8150,10,200000000.0);
        TextDrawHideForAll(Text:C);
        GameTextForAll("~w~ The round is over, ~r~Terrorists ~w~win!", 3000, 5);
        SetTimer("ExitTheGameMode", 8000, 0);
		}
	return 1;
		}

 
//------------------------------------------------------------------------------
TimeConvert(seconds) {
	new tmp[256];
 	new minutes = floatround(seconds/60);
	seconds -= minutes*60;
	format(tmp, sizeof(tmp), "%d:%02d", minutes, seconds);
	return tmp;
}
//------------------------------------------------------------------------------
public OnPlayerDisconnect(playerid, reason)
{
        new string[85],pname[24];
		switch (reason)
{
    case 0:
    {
        GetPlayerName(playerid,pname,24);
        format(string,sizeof(string), "*** %s left the server. (Timeout) (ID:%d)",pname,playerid);
        SendClientMessageToAll(COLOR_DIS_RED,string);
    }
    case 1:
    {
        GetPlayerName(playerid,pname,24);
        format(string,sizeof(string), "*** %s left the server. (Leaving) (ID:%d)",pname,playerid);
        SendClientMessageToAll(COLOR_DIS_RED,string);
    }
    case 2:
    {
        GetPlayerName(playerid,pname,24);
        format(string,sizeof(string), "*** %s left the server. (Kicked) (ID:%d)",pname,playerid);
        SendClientMessageToAll(COLOR_DIS_RED,string);
    }
}
    	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerConnect(playerid)
{
	new string[85],pname[24];
	GetPlayerName(playerid,pname,24);
	format(string,sizeof(string),"*** %s has joined the server. (ID:%d)",pname,playerid);
	SendClientMessageToAll(COLOR_CON_GREEN,string);
	SendPlayerFormattedText(playerid,"<> Welcome to de_island by C0met. This gamemode is currently v0.0.2",0);
	SendPlayerFormattedText(playerid,"<> Type /help before you play if you're unsure about the gamemode.",0);
	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerEnterCheckpoint(playerid)
{
    if(IsPlayerInCheckpoint(playerid) && gTeam[playerid] == TEAM_TERRORIST)
    {
    SendClientMessage(playerid, COLOR_RED, "Type /plant to plant the bomb!");
	}
	else if(IsPlayerInCheckpoint(playerid) && gTeam[playerid] == TEAM_COUNTER-TERRORIST)
	{
    SendClientMessage(playerid, COLOR_BLUE, "Type /defuse to defuse the bomb!");
    }
    return 1;
 }
//------------------------------------------------------------------------------
public ExitTheGameMode(playerid)
{
	GameModeExit();
}
//------------------------------------------------------------------------------
