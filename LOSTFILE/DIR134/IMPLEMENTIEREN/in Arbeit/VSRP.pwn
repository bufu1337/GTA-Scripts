#include <a_samp>
#include <core>
#include <float>
#include <Dini>
#include <dudb>
#include <dutils>

// SITEADDRESS - there are a few "bug reporting" places in the script, as there might be some. --------
//               This is the site that the reports can be forwarded to. When you want to use          -
//               your own, please change it and be SURE to also report it to www.virtualscripting.com -
// ----------------------------------------------------------------------------------------------------
#define SITEADDRESS    "www.virtualscripting.com"
#define SERVER_NAME    "[0.2.2] VirtualScripting SF-RPG BETA"
#define MAP_NAME       "BETA BUILD 2"
#define GM_NAME        "San Fierro RP"
#define SCRIPT_VERSION "BETA BUILD 2"
#define DEV_START      "5 March"
#define SCRIPT_DEV     "Andre9977"
#define LAST_UPDATE    "24 May"

#define COLOR_PURPLE    0xC2A2DAAA
#define COLOR_WHITE     0xFFFFFFAA
#define COLOR_DBLUE     0x2641FEAA
#define COLOR_BLUE      0x33AAFFFF
#define COLOR_GREEN     0x33AA33AA
#define COLOR_ORANGE    0xFF9900AA
#define COLOR_PINK      0xFF69B4FF
#define COLOR_GREY      0xAFAFAFAA
#define COLOR_GREEN     0x33AA33AA
#define COLOR_RED       0xFF000055
#define COLOR_BGREEN    0x08FD04FF
#define COLOR_YELLOW    0xFFFF0055
#define COLOR_CYAN      0x00FFFFAA
#define COLOR_SYSTEM    0xEFEFF7AA
#define COLOR_DORANGE   0xE06906FF
#define COLOR_CRIMSON   0xDC143CAA
#define COLOR_CRED      0xFF3366FF
#define COLOR_CYELLOW   0xFFCC33FF
#define COLOR_LIGHTBLUE 0x93AFFFFF

#define TEAM_CIVILIAN  0
#define TEAM_COP       1
#define TEAM_CRIMINAL  2
#define TEAM_TAXI      3
#define TEAM_FBI       4

#define Level1Commands1 ">> /a [text], /clearchat, /kick [id] [reason], /akill [id], /warn [id] [reason], /getid [name], /seepms, /flip [id]" // 9
#define Level1Commands2 ">> /(un)freeze [id], /playerinfo [id], /asay [msg], /ip [id], /mute [id], /ajail [id] [time], /force [id], /flipme" // 9
#define Level2Commands1 ">> /tele [teleportee id] [dest id], /ban [id], /ann [msg], /cnn [msg] /giveweapon [id] [weaponid] [ammo], /fuckup [id]" // 5
#define Level2Commands2 ">> /goto [id], /gethere [id], /eject [id], /sethealth [id] [amt], /setarmour [id] [amt] /healall, /armourall" // 7
#define Level3Commands1 ">> /disarm [id], /disarmall, /explode [id], /time, /weather [weatherid], /getallhere" // 6
#define Level3Commands2 ">> /setmoney [id] [amount], /jetpack, /setname [id] [name], /wantedlevel [id] [lvl]" // 4
#define Level4Commands1 ">> /setlevel [id] [lvl], /restart, /disarmall, /reloadbans, /reloadlogs, /mapname [name], /servername [name]" // 7
#define Level4Commands2 ">> /sexplode [id], /sban [id] [reason], /skick [id] [reason], /setonlinetime [id] [time]" // 3

#define G1    1595.5406, 2198.0520, 10.3863
#define G2    2202.0649, 2472.6697, 10.5677
#define G3    2115.1929, 919.9908, 10.5266
#define G4    2640.7209, 1105.9565, 10.5274
#define G5    608.5971, 1699.6238, 6.9922
#define G6    618.4878, 1684.5792, 6.9922
#define G7    2146.3467, 2748.2893, 10.5245
#define G8   -1679.4595, 412.5129, 6.9973
#define G9   -1327.5607, 2677.4316, 49.8093
#define G10  -1470.0050, 1863.2375, 32.3521
#define G11  -2409.2200, 976.2798, 45.2969
#define G12  -2244.1396, -2560.5833, 31.9219
#define G13  -1606.0544, -2714.3083, 48.5335
#define G14   1937.4293, -1773.1865, 13.3828
#define G15  -91.3854, -1169.9175, 2.4213
#define G16   1383.4221, 462.5385, 20.1506
#define G17   660.4590, -565.0394, 16.3359
#define G18   1381.7206, 459.1907, 20.3452
#define G19  -1605.7156, -2714.4573, 48.5335

#define Bank1Enter     -1808.6747,904.0485,24.8906
#define Bank2Enter     -1942.4457,459.7402,35.1719
#define Bank3Enter     -2651.2212,376.3470,5.8526
#define COCKTAIL       -2522.8748,1216.1233,37.4283
#define JIZZY          -2624.0867,1412.5245,7.0938
#define SFPD           -1605.4637,711.6559,13.8672
#define BankExit       -25.7382,-187.3092,1003.5469
#define SFPDExit        246.6510,109.3008,1003.2188
#define CLUCKINGBELL1  -1816.8688,617.3931,35.1719
#define CLUCKINGBELL2  -2671.4001,259.2047,4.6328
#define STACKEDPIZZA1  -1808.3824,945.2927,24.8906
#define BURGERSHOT1    -1911.9303,828.1928,35.1923
#define BURGERSHOT2    -2357.0266,1008.2144,50.8984
#define BURGERSHOT3    -2335.7549,-166.8701,35.5547
#define DRIVINGSCHOOL  -2026.5909,-101.2296,35.1641

#define MAX_ZONE_NAME 28

/*
	native GetPlayer2DZone(playerid, zone[], len);
	native GetPlayer3DZone(playerid, zone[], len);
	native IsPlayerInZone(playerid, zone[]);
*/

forward IsStringAName(string[]);
forward GetPlayerID(string[]);
forward MoneyGrubScoreUpdate();
forward RefuelVehicle(playerid);
forward LoseFuel();
forward StartRefuel(playerid);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward RealTime(playerid);
forward ShowTut(playerid);
forward TransferDone(playerid);
forward CleanChat(playerid);
forward ShowDrivingCheckpoint(playerid);
forward DriveCount(playerid);
forward InfoShow(playerid);
forward StoreReason(reason);
forward CheckEnter();
forward CheckWeaponHack(playerid);
forward TurnOn(playerid);
forward StopMusic(playerid);
forward CheckLoc();
forward LoadZoneText(playerid);
forward UpdateZone(playerid);
forward UnCall(playerid);
forward SetSkin(playerid);
forward Unjail(giveplayerid, Float:bPosX, Float:bPosY, Float:bPosZ);
forward CUnjail(giveplayerid);
forward GodMode(playerid);
forward HideInfoTextDraw(playerid);
forward CheckPointTimer();
forward HealthCheck(playerid);

static gTeam[MAX_PLAYERS];

enum SAZONE_MAIN
{
	SAZONE_NAME[28],
	Float:SAZONE_AREA[6]
};

static const gSAZones[][SAZONE_MAIN] =
{
	{"The Big Ear",	                {-410.00,1403.30,-3.00,-137.90,1681.20,200.00}},
	{"Aldea Malvada",               {-1372.10,2498.50,0.00,-1277.50,2615.30,200.00}},
	{"Angel Pine",                  {-2324.90,-2584.20,-6.10,-1964.20,-2212.10,200.00}},
	{"Arco del Oeste",              {-901.10,2221.80,0.00,-592.00,2571.90,200.00}},
	{"Avispa Country Club",         {-2646.40,-355.40,0.00,-2270.00,-222.50,200.00}},
	{"Avispa Country Club",         {-2831.80,-430.20,-6.10,-2646.40,-222.50,200.00}},
	{"Avispa Country Club",         {-2361.50,-417.10,0.00,-2270.00,-355.40,200.00}},
	{"Avispa Country Club",         {-2667.80,-302.10,-28.80,-2646.40,-262.30,71.10}},
	{"Avispa Country Club",         {-2470.00,-355.40,0.00,-2270.00,-318.40,46.10}},
	{"Avispa Country Club",         {-2550.00,-355.40,0.00,-2470.00,-318.40,39.70}},
	{"Back o Beyond",               {-1166.90,-2641.10,0.00,-321.70,-1856.00,200.00}},
	{"Battery Point",               {-2741.00,1268.40,-4.50,-2533.00,1490.40,200.00}},
	{"Bayside",                     {-2741.00,2175.10,0.00,-2353.10,2722.70,200.00}},
	{"Bayside Marina",              {-2353.10,2275.70,0.00,-2153.10,2475.70,200.00}},
	{"Beacon Hill",                 {-399.60,-1075.50,-1.40,-319.00,-977.50,198.50}},
	{"Blackfield",                  {964.30,1203.20,-89.00,1197.30,1403.20,110.90}},
	{"Blackfield",                  {964.30,1403.20,-89.00,1197.30,1726.20,110.90}},
	{"Blackfield Chapel",           {1375.60,596.30,-89.00,1558.00,823.20,110.90}},
	{"Blackfield Chapel",           {1325.60,596.30,-89.00,1375.60,795.00,110.90}},
	{"Blackfield Intersection",     {1197.30,1044.60,-89.00,1277.00,1163.30,110.90}},
	{"Blackfield Intersection",     {1166.50,795.00,-89.00,1375.60,1044.60,110.90}},
	{"Blackfield Intersection",     {1277.00,1044.60,-89.00,1315.30,1087.60,110.90}},
	{"Blackfield Intersection",     {1375.60,823.20,-89.00,1457.30,919.40,110.90}},
	{"Blueberry",                   {104.50,-220.10,2.30,349.60,152.20,200.00}},
	{"Blueberry",                   {19.60,-404.10,3.80,349.60,-220.10,200.00}},
	{"Blueberry Acres",             {-319.60,-220.10,0.00,104.50,293.30,200.00}},
	{"Caligula's Palace",           {2087.30,1543.20,-89.00,2437.30,1703.20,110.90}},
	{"Caligula's Palace",           {2137.40,1703.20,-89.00,2437.30,1783.20,110.90}},
	{"Calton Heights",              {-2274.10,744.10,-6.10,-1982.30,1358.90,200.00}},
	{"Chinatown",                   {-2274.10,578.30,-7.60,-2078.60,744.10,200.00}},
	{"City Hall",                   {-2867.80,277.40,-9.10,-2593.40,458.40,200.00}},
	{"Come-A-Lot",                  {2087.30,943.20,-89.00,2623.10,1203.20,110.90}},
	{"Commerce",                    {1323.90,-1842.20,-89.00,1701.90,-1722.20,110.90}},
	{"Commerce",                    {1323.90,-1722.20,-89.00,1440.90,-1577.50,110.90}},
	{"Commerce",                    {1370.80,-1577.50,-89.00,1463.90,-1384.90,110.90}},
	{"Commerce",                    {1463.90,-1577.50,-89.00,1667.90,-1430.80,110.90}},
	{"Commerce",                    {1583.50,-1722.20,-89.00,1758.90,-1577.50,110.90}},
	{"Commerce",                    {1667.90,-1577.50,-89.00,1812.60,-1430.80,110.90}},
	{"Conference Center",           {1046.10,-1804.20,-89.00,1323.90,-1722.20,110.90}},
	{"Conference Center",           {1073.20,-1842.20,-89.00,1323.90,-1804.20,110.90}},
	{"Cranberry Station",           {-2007.80,56.30,0.00,-1922.00,224.70,100.00}},
	{"Creek",                       {2749.90,1937.20,-89.00,2921.60,2669.70,110.90}},
	{"Dillimore",                   {580.70,-674.80,-9.50,861.00,-404.70,200.00}},
	{"Doherty",                     {-2270.00,-324.10,-0.00,-1794.90,-222.50,200.00}},
	{"Doherty",                     {-2173.00,-222.50,-0.00,-1794.90,265.20,200.00}},
	{"Downtown",                    {-1982.30,744.10,-6.10,-1871.70,1274.20,200.00}},
	{"Downtown",                    {-1871.70,1176.40,-4.50,-1620.30,1274.20,200.00}},
	{"Downtown",                    {-1700.00,744.20,-6.10,-1580.00,1176.50,200.00}},
	{"Downtown",                    {-1580.00,744.20,-6.10,-1499.80,1025.90,200.00}},
	{"Downtown",                    {-2078.60,578.30,-7.60,-1499.80,744.20,200.00}},
	{"Downtown",                    {-1993.20,265.20,-9.10,-1794.90,578.30,200.00}},
	{"Downtown Los Santos",         {1463.90,-1430.80,-89.00,1724.70,-1290.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1430.80,-89.00,1812.60,-1250.90,110.90}},
	{"Downtown Los Santos",         {1463.90,-1290.80,-89.00,1724.70,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1384.90,-89.00,1463.90,-1170.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1250.90,-89.00,1812.60,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1170.80,-89.00,1463.90,-1130.80,110.90}},
	{"Downtown Los Santos",         {1378.30,-1130.80,-89.00,1463.90,-1026.30,110.90}},
	{"Downtown Los Santos",         {1391.00,-1026.30,-89.00,1463.90,-926.90,110.90}},
	{"Downtown Los Santos",         {1507.50,-1385.20,110.90,1582.50,-1325.30,335.90}},
	{"East Beach",                  {2632.80,-1852.80,-89.00,2959.30,-1668.10,110.90}},
	{"East Beach",                  {2632.80,-1668.10,-89.00,2747.70,-1393.40,110.90}},
	{"East Beach",                  {2747.70,-1668.10,-89.00,2959.30,-1498.60,110.90}},
	{"East Beach",                  {2747.70,-1498.60,-89.00,2959.30,-1120.00,110.90}},
	{"East Los Santos",             {2421.00,-1628.50,-89.00,2632.80,-1454.30,110.90}},
	{"East Los Santos",             {2222.50,-1628.50,-89.00,2421.00,-1494.00,110.90}},
	{"East Los Santos",             {2266.20,-1494.00,-89.00,2381.60,-1372.00,110.90}},
	{"East Los Santos",             {2381.60,-1494.00,-89.00,2421.00,-1454.30,110.90}},
	{"East Los Santos",             {2281.40,-1372.00,-89.00,2381.60,-1135.00,110.90}},
	{"East Los Santos",             {2381.60,-1454.30,-89.00,2462.10,-1135.00,110.90}},
	{"East Los Santos",             {2462.10,-1454.30,-89.00,2581.70,-1135.00,110.90}},
	{"Easter Basin",                {-1794.90,249.90,-9.10,-1242.90,578.30,200.00}},
	{"Easter Basin",                {-1794.90,-50.00,-0.00,-1499.80,249.90,200.00}},
	{"Easter Bay Airport",          {-1499.80,-50.00,-0.00,-1242.90,249.90,200.00}},
	{"Easter Bay Airport",          {-1794.90,-730.10,-3.00,-1213.90,-50.00,200.00}},
	{"Easter Bay Airport",          {-1213.90,-730.10,0.00,-1132.80,-50.00,200.00}},
	{"Easter Bay Airport",          {-1242.90,-50.00,0.00,-1213.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1213.90,-50.00,-4.50,-947.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1315.40,-405.30,15.40,-1264.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1354.30,-287.30,15.40,-1315.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1490.30,-209.50,15.40,-1264.40,-148.30,25.40}},
	{"Easter Bay Chemicals",        {-1132.80,-768.00,0.00,-956.40,-578.10,200.00}},
	{"Easter Bay Chemicals",        {-1132.80,-787.30,0.00,-956.40,-768.00,200.00}},
	{"El Castillo del Diablo",      {-464.50,2217.60,0.00,-208.50,2580.30,200.00}},
	{"El Castillo del Diablo",      {-208.50,2123.00,-7.60,114.00,2337.10,200.00}},
	{"El Castillo del Diablo",      {-208.50,2337.10,0.00,8.40,2487.10,200.00}},
	{"El Corona",                   {1812.60,-2179.20,-89.00,1970.60,-1852.80,110.90}},
	{"El Corona",                   {1692.60,-2179.20,-89.00,1812.60,-1842.20,110.90}},
	{"El Quebrados",                {-1645.20,2498.50,0.00,-1372.10,2777.80,200.00}},
	{"Esplanade East",              {-1620.30,1176.50,-4.50,-1580.00,1274.20,200.00}},
	{"Esplanade East",              {-1580.00,1025.90,-6.10,-1499.80,1274.20,200.00}},
	{"Esplanade East",              {-1499.80,578.30,-79.60,-1339.80,1274.20,20.30}},
	{"Esplanade North",             {-2533.00,1358.90,-4.50,-1996.60,1501.20,200.00}},
	{"Esplanade North",             {-1996.60,1358.90,-4.50,-1524.20,1592.50,200.00}},
	{"Esplanade North",             {-1982.30,1274.20,-4.50,-1524.20,1358.90,200.00}},
	{"Fallen Tree",                 {-792.20,-698.50,-5.30,-452.40,-380.00,200.00}},
	{"Fallow Bridge",               {434.30,366.50,0.00,603.00,555.60,200.00}},
	{"Fern Ridge",                  {508.10,-139.20,0.00,1306.60,119.50,200.00}},
	{"Financial",                   {-1871.70,744.10,-6.10,-1701.30,1176.40,300.00}},
	{"Fisher's Lagoon",             {1916.90,-233.30,-100.00,2131.70,13.80,200.00}},
	{"Flint Intersection",          {-187.70,-1596.70,-89.00,17.00,-1276.60,110.90}},
	{"Flint Range",                 {-594.10,-1648.50,0.00,-187.70,-1276.60,200.00}},
	{"Fort Carson",                 {-376.20,826.30,-3.00,123.70,1220.40,200.00}},
	{"Foster Valley",               {-2270.00,-430.20,-0.00,-2178.60,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-599.80,-0.00,-1794.90,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-1115.50,0.00,-1794.90,-599.80,200.00}},
	{"Foster Valley",               {-2178.60,-1250.90,0.00,-1794.90,-1115.50,200.00}},
	{"Frederick Bridge",            {2759.20,296.50,0.00,2774.20,594.70,200.00}},
	{"Gant Bridge",                 {-2741.40,1659.60,-6.10,-2616.40,2175.10,200.00}},
	{"Gant Bridge",                 {-2741.00,1490.40,-6.10,-2616.40,1659.60,200.00}},
	{"Ganton",                      {2222.50,-1852.80,-89.00,2632.80,-1722.30,110.90}},
	{"Ganton",                      {2222.50,-1722.30,-89.00,2632.80,-1628.50,110.90}},
	{"Garcia",                      {-2411.20,-222.50,-0.00,-2173.00,265.20,200.00}},
	{"Garcia",                      {-2395.10,-222.50,-5.30,-2354.00,-204.70,200.00}},
	{"Garver Bridge",               {-1339.80,828.10,-89.00,-1213.90,1057.00,110.90}},
	{"Garver Bridge",               {-1213.90,950.00,-89.00,-1087.90,1178.90,110.90}},
	{"Garver Bridge",               {-1499.80,696.40,-179.60,-1339.80,925.30,20.30}},
	{"Glen Park",                   {1812.60,-1449.60,-89.00,1996.90,-1350.70,110.90}},
	{"Glen Park",                   {1812.60,-1100.80,-89.00,1994.30,-973.30,110.90}},
	{"Glen Park",                   {1812.60,-1350.70,-89.00,2056.80,-1100.80,110.90}},
	{"Green Palms",                 {176.50,1305.40,-3.00,338.60,1520.70,200.00}},
	{"Greenglass College",          {964.30,1044.60,-89.00,1197.30,1203.20,110.90}},
	{"Greenglass College",          {964.30,930.80,-89.00,1166.50,1044.60,110.90}},
	{"Hampton Barns",               {603.00,264.30,0.00,761.90,366.50,200.00}},
	{"Hankypanky Point",            {2576.90,62.10,0.00,2759.20,385.50,200.00}},
	{"Harry Gold Parkway",          {1777.30,863.20,-89.00,1817.30,2342.80,110.90}},
	{"Hashbury",                    {-2593.40,-222.50,-0.00,-2411.20,54.70,200.00}},
	{"Hilltop Farm",                {967.30,-450.30,-3.00,1176.70,-217.90,200.00}},
	{"Hunter Quarry",               {337.20,710.80,-115.20,860.50,1031.70,203.70}},
	{"Idlewood",                    {1812.60,-1852.80,-89.00,1971.60,-1742.30,110.90}},
	{"Idlewood",                    {1812.60,-1742.30,-89.00,1951.60,-1602.30,110.90}},
	{"Idlewood",                    {1951.60,-1742.30,-89.00,2124.60,-1602.30,110.90}},
	{"Idlewood",                    {1812.60,-1602.30,-89.00,2124.60,-1449.60,110.90}},
	{"Idlewood",                    {2124.60,-1742.30,-89.00,2222.50,-1494.00,110.90}},
	{"Idlewood",                    {1971.60,-1852.80,-89.00,2222.50,-1742.30,110.90}},
	{"Jefferson",                   {1996.90,-1449.60,-89.00,2056.80,-1350.70,110.90}},
	{"Jefferson",                   {2124.60,-1494.00,-89.00,2266.20,-1449.60,110.90}},
	{"Jefferson",                   {2056.80,-1372.00,-89.00,2281.40,-1210.70,110.90}},
	{"Jefferson",                   {2056.80,-1210.70,-89.00,2185.30,-1126.30,110.90}},
	{"Jefferson",                   {2185.30,-1210.70,-89.00,2281.40,-1154.50,110.90}},
	{"Jefferson",                   {2056.80,-1449.60,-89.00,2266.20,-1372.00,110.90}},
	{"Julius Thruway East",         {2623.10,943.20,-89.00,2749.90,1055.90,110.90}},
	{"Julius Thruway East",         {2685.10,1055.90,-89.00,2749.90,2626.50,110.90}},
	{"Julius Thruway East",         {2536.40,2442.50,-89.00,2685.10,2542.50,110.90}},
	{"Julius Thruway East",         {2625.10,2202.70,-89.00,2685.10,2442.50,110.90}},
	{"Julius Thruway North",        {2498.20,2542.50,-89.00,2685.10,2626.50,110.90}},
	{"Julius Thruway North",        {2237.40,2542.50,-89.00,2498.20,2663.10,110.90}},
	{"Julius Thruway North",        {2121.40,2508.20,-89.00,2237.40,2663.10,110.90}},
	{"Julius Thruway North",        {1938.80,2508.20,-89.00,2121.40,2624.20,110.90}},
	{"Julius Thruway North",        {1534.50,2433.20,-89.00,1848.40,2583.20,110.90}},
	{"Julius Thruway North",        {1848.40,2478.40,-89.00,1938.80,2553.40,110.90}},
	{"Julius Thruway North",        {1704.50,2342.80,-89.00,1848.40,2433.20,110.90}},
	{"Julius Thruway North",        {1377.30,2433.20,-89.00,1534.50,2507.20,110.90}},
	{"Julius Thruway South",        {1457.30,823.20,-89.00,2377.30,863.20,110.90}},
	{"Julius Thruway South",        {2377.30,788.80,-89.00,2537.30,897.90,110.90}},
	{"Julius Thruway West",         {1197.30,1163.30,-89.00,1236.60,2243.20,110.90}},
	{"Julius Thruway West",         {1236.60,2142.80,-89.00,1297.40,2243.20,110.90}},
	{"Juniper Hill",                {-2533.00,578.30,-7.60,-2274.10,968.30,200.00}},
	{"Juniper Hollow",              {-2533.00,968.30,-6.10,-2274.10,1358.90,200.00}},
	{"K.A.C.C. Military Fuels",     {2498.20,2626.50,-89.00,2749.90,2861.50,110.90}},
	{"Kincaid Bridge",              {-1339.80,599.20,-89.00,-1213.90,828.10,110.90}},
	{"Kincaid Bridge",              {-1213.90,721.10,-89.00,-1087.90,950.00,110.90}},
	{"Kincaid Bridge",              {-1087.90,855.30,-89.00,-961.90,986.20,110.90}},
	{"King's",                      {-2329.30,458.40,-7.60,-1993.20,578.30,200.00}},
	{"King's",                      {-2411.20,265.20,-9.10,-1993.20,373.50,200.00}},
	{"King's",                      {-2253.50,373.50,-9.10,-1993.20,458.40,200.00}},
	{"LVA Freight Depot",           {1457.30,863.20,-89.00,1777.40,1143.20,110.90}},
	{"LVA Freight Depot",           {1375.60,919.40,-89.00,1457.30,1203.20,110.90}},
	{"LVA Freight Depot",           {1277.00,1087.60,-89.00,1375.60,1203.20,110.90}},
	{"LVA Freight Depot",           {1315.30,1044.60,-89.00,1375.60,1087.60,110.90}},
	{"LVA Freight Depot",           {1236.60,1163.40,-89.00,1277.00,1203.20,110.90}},
	{"Las Barrancas",               {-926.10,1398.70,-3.00,-719.20,1634.60,200.00}},
	{"Las Brujas",                  {-365.10,2123.00,-3.00,-208.50,2217.60,200.00}},
	{"Las Colinas",                 {1994.30,-1100.80,-89.00,2056.80,-920.80,110.90}},
	{"Las Colinas",                 {2056.80,-1126.30,-89.00,2126.80,-920.80,110.90}},
	{"Las Colinas",                 {2185.30,-1154.50,-89.00,2281.40,-934.40,110.90}},
	{"Las Colinas",                 {2126.80,-1126.30,-89.00,2185.30,-934.40,110.90}},
	{"Las Colinas",                 {2747.70,-1120.00,-89.00,2959.30,-945.00,110.90}},
	{"Las Colinas",                 {2632.70,-1135.00,-89.00,2747.70,-945.00,110.90}},
	{"Las Colinas",                 {2281.40,-1135.00,-89.00,2632.70,-945.00,110.90}},
	{"Las Payasadas",               {-354.30,2580.30,2.00,-133.60,2816.80,200.00}},
	{"Las Venturas Airport",        {1236.60,1203.20,-89.00,1457.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1203.20,-89.00,1777.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1143.20,-89.00,1777.40,1203.20,110.90}},
	{"Las Venturas Airport",        {1515.80,1586.40,-12.50,1729.90,1714.50,87.50}},
	{"Last Dime Motel",             {1823.00,596.30,-89.00,1997.20,823.20,110.90}},
	{"Leafy Hollow",                {-1166.90,-1856.00,0.00,-815.60,-1602.00,200.00}},
	{"Liberty City",                {-1000.00,400.00,1300.00,-700.00,600.00,1400.00}},
	{"Lil' Probe Inn",              {-90.20,1286.80,-3.00,153.80,1554.10,200.00}},
	{"Linden Side",                 {2749.90,943.20,-89.00,2923.30,1198.90,110.90}},
	{"Linden Station",              {2749.90,1198.90,-89.00,2923.30,1548.90,110.90}},
	{"Linden Station",              {2811.20,1229.50,-39.50,2861.20,1407.50,60.40}},
	{"Little Mexico",               {1701.90,-1842.20,-89.00,1812.60,-1722.20,110.90}},
	{"Little Mexico",               {1758.90,-1722.20,-89.00,1812.60,-1577.50,110.90}},
	{"Los Flores",                  {2581.70,-1454.30,-89.00,2632.80,-1393.40,110.90}},
	{"Los Flores",                  {2581.70,-1393.40,-89.00,2747.70,-1135.00,110.90}},
	{"Los Santos International",    {1249.60,-2394.30,-89.00,1852.00,-2179.20,110.90}},
	{"Los Santos International",    {1852.00,-2394.30,-89.00,2089.00,-2179.20,110.90}},
	{"Los Santos International",    {1382.70,-2730.80,-89.00,2201.80,-2394.30,110.90}},
	{"Los Santos International",    {1974.60,-2394.30,-39.00,2089.00,-2256.50,60.90}},
	{"Los Santos International",    {1400.90,-2669.20,-39.00,2189.80,-2597.20,60.90}},
	{"Los Santos International",    {2051.60,-2597.20,-39.00,2152.40,-2394.30,60.90}},
	{"Marina",                      {647.70,-1804.20,-89.00,851.40,-1577.50,110.90}},
	{"Marina",                      {647.70,-1577.50,-89.00,807.90,-1416.20,110.90}},
	{"Marina",                      {807.90,-1577.50,-89.00,926.90,-1416.20,110.90}},
	{"Market",                      {787.40,-1416.20,-89.00,1072.60,-1310.20,110.90}},
	{"Market",                      {952.60,-1310.20,-89.00,1072.60,-1130.80,110.90}},
	{"Market",                      {1072.60,-1416.20,-89.00,1370.80,-1130.80,110.90}},
	{"Market",                      {926.90,-1577.50,-89.00,1370.80,-1416.20,110.90}},
	{"Market Station",              {787.40,-1410.90,-34.10,866.00,-1310.20,65.80}},
	{"Martin Bridge",               {-222.10,293.30,0.00,-122.10,476.40,200.00}},
	{"Missionary Hill",             {-2994.40,-811.20,0.00,-2178.60,-430.20,200.00}},
	{"Montgomery",                  {1119.50,119.50,-3.00,1451.40,493.30,200.00}},
	{"Montgomery",                  {1451.40,347.40,-6.10,1582.40,420.80,200.00}},
	{"Montgomery Intersection",     {1546.60,208.10,0.00,1745.80,347.40,200.00}},
	{"Montgomery Intersection",     {1582.40,347.40,0.00,1664.60,401.70,200.00}},
	{"Mulholland",                  {1414.00,-768.00,-89.00,1667.60,-452.40,110.90}},
	{"Mulholland",                  {1281.10,-452.40,-89.00,1641.10,-290.90,110.90}},
	{"Mulholland",                  {1269.10,-768.00,-89.00,1414.00,-452.40,110.90}},
	{"Mulholland",                  {1357.00,-926.90,-89.00,1463.90,-768.00,110.90}},
	{"Mulholland",                  {1318.10,-910.10,-89.00,1357.00,-768.00,110.90}},
	{"Mulholland",                  {1169.10,-910.10,-89.00,1318.10,-768.00,110.90}},
	{"Mulholland",                  {768.60,-954.60,-89.00,952.60,-860.60,110.90}},
	{"Mulholland",                  {687.80,-860.60,-89.00,911.80,-768.00,110.90}},
	{"Mulholland",                  {737.50,-768.00,-89.00,1142.20,-674.80,110.90}},
	{"Mulholland",                  {1096.40,-910.10,-89.00,1169.10,-768.00,110.90}},
	{"Mulholland",                  {952.60,-937.10,-89.00,1096.40,-860.60,110.90}},
	{"Mulholland",                  {911.80,-860.60,-89.00,1096.40,-768.00,110.90}},
	{"Mulholland",                  {861.00,-674.80,-89.00,1156.50,-600.80,110.90}},
	{"Mulholland Intersection",     {1463.90,-1150.80,-89.00,1812.60,-768.00,110.90}},
	{"North Rock",                  {2285.30,-768.00,0.00,2770.50,-269.70,200.00}},
	{"Ocean Docks",                 {2373.70,-2697.00,-89.00,2809.20,-2330.40,110.90}},
	{"Ocean Docks",                 {2201.80,-2418.30,-89.00,2324.00,-2095.00,110.90}},
	{"Ocean Docks",                 {2324.00,-2302.30,-89.00,2703.50,-2145.10,110.90}},
	{"Ocean Docks",                 {2089.00,-2394.30,-89.00,2201.80,-2235.80,110.90}},
	{"Ocean Docks",                 {2201.80,-2730.80,-89.00,2324.00,-2418.30,110.90}},
	{"Ocean Docks",                 {2703.50,-2302.30,-89.00,2959.30,-2126.90,110.90}},
	{"Ocean Docks",                 {2324.00,-2145.10,-89.00,2703.50,-2059.20,110.90}},
	{"Ocean Flats",                 {-2994.40,277.40,-9.10,-2867.80,458.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-222.50,-0.00,-2593.40,277.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-430.20,-0.00,-2831.80,-222.50,200.00}},
	{"Octane Springs",              {338.60,1228.50,0.00,664.30,1655.00,200.00}},
	{"Old Venturas Strip",          {2162.30,2012.10,-89.00,2685.10,2202.70,110.90}},
	{"Palisades",                   {-2994.40,458.40,-6.10,-2741.00,1339.60,200.00}},
	{"Palomino Creek",              {2160.20,-149.00,0.00,2576.90,228.30,200.00}},
	{"Paradiso",                    {-2741.00,793.40,-6.10,-2533.00,1268.40,200.00}},
	{"Pershing Square",             {1440.90,-1722.20,-89.00,1583.50,-1577.50,110.90}},
	{"Pilgrim",                     {2437.30,1383.20,-89.00,2624.40,1783.20,110.90}},
	{"Pilgrim",                     {2624.40,1383.20,-89.00,2685.10,1783.20,110.90}},
	{"Pilson Intersection",         {1098.30,2243.20,-89.00,1377.30,2507.20,110.90}},
	{"Pirates in Men's Pants",      {1817.30,1469.20,-89.00,2027.40,1703.20,110.90}},
	{"Playa del Seville",           {2703.50,-2126.90,-89.00,2959.30,-1852.80,110.90}},
	{"Prickle Pine",                {1534.50,2583.20,-89.00,1848.40,2863.20,110.90}},
	{"Prickle Pine",                {1117.40,2507.20,-89.00,1534.50,2723.20,110.90}},
	{"Prickle Pine",                {1848.40,2553.40,-89.00,1938.80,2863.20,110.90}},
	{"Prickle Pine",                {1938.80,2624.20,-89.00,2121.40,2861.50,110.90}},
	{"Queens",                      {-2533.00,458.40,0.00,-2329.30,578.30,200.00}},
	{"Queens",                      {-2593.40,54.70,0.00,-2411.20,458.40,200.00}},
	{"Queens",                      {-2411.20,373.50,0.00,-2253.50,458.40,200.00}},
	{"Randolph Industrial Estate",  {1558.00,596.30,-89.00,1823.00,823.20,110.90}},
	{"Redsands East",               {1817.30,2011.80,-89.00,2106.70,2202.70,110.90}},
	{"Redsands East",               {1817.30,2202.70,-89.00,2011.90,2342.80,110.90}},
	{"Redsands East",               {1848.40,2342.80,-89.00,2011.90,2478.40,110.90}},
	{"Redsands West",               {1236.60,1883.10,-89.00,1777.30,2142.80,110.90}},
	{"Redsands West",               {1297.40,2142.80,-89.00,1777.30,2243.20,110.90}},
	{"Redsands West",               {1377.30,2243.20,-89.00,1704.50,2433.20,110.90}},
	{"Redsands West",               {1704.50,2243.20,-89.00,1777.30,2342.80,110.90}},
	{"Regular Tom",                 {-405.70,1712.80,-3.00,-276.70,1892.70,200.00}},
	{"Richman",                     {647.50,-1118.20,-89.00,787.40,-954.60,110.90}},
	{"Richman",                     {647.50,-954.60,-89.00,768.60,-860.60,110.90}},
	{"Richman",                     {225.10,-1369.60,-89.00,334.50,-1292.00,110.90}},
	{"Richman",                     {225.10,-1292.00,-89.00,466.20,-1235.00,110.90}},
	{"Richman",                     {72.60,-1404.90,-89.00,225.10,-1235.00,110.90}},
	{"Richman",                     {72.60,-1235.00,-89.00,321.30,-1008.10,110.90}},
	{"Richman",                     {321.30,-1235.00,-89.00,647.50,-1044.00,110.90}},
	{"Richman",                     {321.30,-1044.00,-89.00,647.50,-860.60,110.90}},
	{"Richman",                     {321.30,-860.60,-89.00,687.80,-768.00,110.90}},
	{"Richman",                     {321.30,-768.00,-89.00,700.70,-674.80,110.90}},
	{"Robada Intersection",         {-1119.00,1178.90,-89.00,-862.00,1351.40,110.90}},
	{"Roca Escalante",              {2237.40,2202.70,-89.00,2536.40,2542.50,110.90}},
	{"Roca Escalante",              {2536.40,2202.70,-89.00,2625.10,2442.50,110.90}},
	{"Rockshore East",              {2537.30,676.50,-89.00,2902.30,943.20,110.90}},
	{"Rockshore West",              {1997.20,596.30,-89.00,2377.30,823.20,110.90}},
	{"Rockshore West",              {2377.30,596.30,-89.00,2537.30,788.80,110.90}},
	{"Rodeo",                       {72.60,-1684.60,-89.00,225.10,-1544.10,110.90}},
	{"Rodeo",                       {72.60,-1544.10,-89.00,225.10,-1404.90,110.90}},
	{"Rodeo",                       {225.10,-1684.60,-89.00,312.80,-1501.90,110.90}},
	{"Rodeo",                       {225.10,-1501.90,-89.00,334.50,-1369.60,110.90}},
	{"Rodeo",                       {334.50,-1501.90,-89.00,422.60,-1406.00,110.90}},
	{"Rodeo",                       {312.80,-1684.60,-89.00,422.60,-1501.90,110.90}},
	{"Rodeo",                       {422.60,-1684.60,-89.00,558.00,-1570.20,110.90}},
	{"Rodeo",                       {558.00,-1684.60,-89.00,647.50,-1384.90,110.90}},
	{"Rodeo",                       {466.20,-1570.20,-89.00,558.00,-1385.00,110.90}},
	{"Rodeo",                       {422.60,-1570.20,-89.00,466.20,-1406.00,110.90}},
	{"Rodeo",                       {466.20,-1385.00,-89.00,647.50,-1235.00,110.90}},
	{"Rodeo",                       {334.50,-1406.00,-89.00,466.20,-1292.00,110.90}},
	{"Royal Casino",                {2087.30,1383.20,-89.00,2437.30,1543.20,110.90}},
	{"San Andreas Sound",           {2450.30,385.50,-100.00,2759.20,562.30,200.00}},
	{"Santa Flora",                 {-2741.00,458.40,-7.60,-2533.00,793.40,200.00}},
	{"Santa Maria Beach",           {342.60,-2173.20,-89.00,647.70,-1684.60,110.90}},
	{"Santa Maria Beach",           {72.60,-2173.20,-89.00,342.60,-1684.60,110.90}},
	{"Shady Cabin",                 {-1632.80,-2263.40,-3.00,-1601.30,-2231.70,200.00}},
	{"Shady Creeks",                {-1820.60,-2643.60,-8.00,-1226.70,-1771.60,200.00}},
	{"Shady Creeks",                {-2030.10,-2174.80,-6.10,-1820.60,-1771.60,200.00}},
	{"Sobell Rail Yards",           {2749.90,1548.90,-89.00,2923.30,1937.20,110.90}},
	{"Spinybed",                    {2121.40,2663.10,-89.00,2498.20,2861.50,110.90}},
	{"Starfish Casino",             {2437.30,1783.20,-89.00,2685.10,2012.10,110.90}},
	{"Starfish Casino",             {2437.30,1858.10,-39.00,2495.00,1970.80,60.90}},
	{"Starfish Casino",             {2162.30,1883.20,-89.00,2437.30,2012.10,110.90}},
	{"Temple",                      {1252.30,-1130.80,-89.00,1378.30,-1026.30,110.90}},
	{"Temple",                      {1252.30,-1026.30,-89.00,1391.00,-926.90,110.90}},
	{"Temple",                      {1252.30,-926.90,-89.00,1357.00,-910.10,110.90}},
	{"Temple",                      {952.60,-1130.80,-89.00,1096.40,-937.10,110.90}},
	{"Temple",                      {1096.40,-1130.80,-89.00,1252.30,-1026.30,110.90}},
	{"Temple",                      {1096.40,-1026.30,-89.00,1252.30,-910.10,110.90}},
	{"The Camel's Toe",             {2087.30,1203.20,-89.00,2640.40,1383.20,110.90}},
	{"The Clown's Pocket",          {2162.30,1783.20,-89.00,2437.30,1883.20,110.90}},
	{"The Emerald Isle",            {2011.90,2202.70,-89.00,2237.40,2508.20,110.90}},
	{"The Farm",                    {-1209.60,-1317.10,114.90,-908.10,-787.30,251.90}},
	{"The Four Dragons Casino",     {1817.30,863.20,-89.00,2027.30,1083.20,110.90}},
	{"The High Roller",             {1817.30,1283.20,-89.00,2027.30,1469.20,110.90}},
	{"The Mako Span",               {1664.60,401.70,0.00,1785.10,567.20,200.00}},
	{"The Panopticon",              {-947.90,-304.30,-1.10,-319.60,327.00,200.00}},
	{"The Pink Swan",               {1817.30,1083.20,-89.00,2027.30,1283.20,110.90}},
	{"The Sherman Dam",             {-968.70,1929.40,-3.00,-481.10,2155.20,200.00}},
	{"The Strip",                   {2027.40,863.20,-89.00,2087.30,1703.20,110.90}},
	{"The Strip",                   {2106.70,1863.20,-89.00,2162.30,2202.70,110.90}},
	{"The Strip",                   {2027.40,1783.20,-89.00,2162.30,1863.20,110.90}},
	{"The Strip",                   {2027.40,1703.20,-89.00,2137.40,1783.20,110.90}},
	{"The Visage",                  {1817.30,1863.20,-89.00,2106.70,2011.80,110.90}},
	{"The Visage",                  {1817.30,1703.20,-89.00,2027.40,1863.20,110.90}},
	{"Unity Station",               {1692.60,-1971.80,-20.40,1812.60,-1932.80,79.50}},
	{"Valle Ocultado",              {-936.60,2611.40,2.00,-715.90,2847.90,200.00}},
	{"Verdant Bluffs",              {930.20,-2488.40,-89.00,1249.60,-2006.70,110.90}},
	{"Verdant Bluffs",              {1073.20,-2006.70,-89.00,1249.60,-1842.20,110.90}},
	{"Verdant Bluffs",              {1249.60,-2179.20,-89.00,1692.60,-1842.20,110.90}},
	{"Verdant Meadows",             {37.00,2337.10,-3.00,435.90,2677.90,200.00}},
	{"Verona Beach",                {647.70,-2173.20,-89.00,930.20,-1804.20,110.90}},
	{"Verona Beach",                {930.20,-2006.70,-89.00,1073.20,-1804.20,110.90}},
	{"Verona Beach",                {851.40,-1804.20,-89.00,1046.10,-1577.50,110.90}},
	{"Verona Beach",                {1161.50,-1722.20,-89.00,1323.90,-1577.50,110.90}},
	{"Verona Beach",                {1046.10,-1722.20,-89.00,1161.50,-1577.50,110.90}},
	{"Vinewood",                    {787.40,-1310.20,-89.00,952.60,-1130.80,110.90}},
	{"Vinewood",                    {787.40,-1130.80,-89.00,952.60,-954.60,110.90}},
	{"Vinewood",                    {647.50,-1227.20,-89.00,787.40,-1118.20,110.90}},
	{"Vinewood",                    {647.70,-1416.20,-89.00,787.40,-1227.20,110.90}},
	{"Whitewood Estates",           {883.30,1726.20,-89.00,1098.30,2507.20,110.90}},
	{"Whitewood Estates",           {1098.30,1726.20,-89.00,1197.30,2243.20,110.90}},
	{"Willowfield",                 {1970.60,-2179.20,-89.00,2089.00,-1852.80,110.90}},
	{"Willowfield",                 {2089.00,-2235.80,-89.00,2201.80,-1989.90,110.90}},
	{"Willowfield",                 {2089.00,-1989.90,-89.00,2324.00,-1852.80,110.90}},
	{"Willowfield",                 {2201.80,-2095.00,-89.00,2324.00,-1989.90,110.90}},
	{"Willowfield",                 {2541.70,-1941.40,-89.00,2703.50,-1852.80,110.90}},
	{"Willowfield",                 {2324.00,-2059.20,-89.00,2541.70,-1852.80,110.90}},
	{"Willowfield",                 {2541.70,-2059.20,-89.00,2703.50,-1941.40,110.90}},
	{"Yellow Bell Station",         {1377.40,2600.40,-21.90,1492.40,2687.30,78.00}},
	{"Los Santos",                  {44.60,-2892.90,-242.90,2997.00,-768.00,900.00}},
	{"Las Venturas",                {869.40,596.30,-242.90,2997.00,2993.80,900.00}},
	{"Bone County",                 {-480.50,596.30,-242.90,869.40,2993.80,900.00}},
	{"Tierra Robada",               {-2997.40,1659.60,-242.90,-480.50,2993.80,900.00}},
	{"Tierra Robada",               {-1213.90,596.30,-242.90,-480.50,1659.60,900.00}},
	{"San Fierro",                  {-2997.40,-1115.50,-242.90,-1213.90,1659.60,900.00}},
	{"Red County",                  {-1213.90,-768.00,-242.90,2997.00,596.30,900.00}},
	{"Flint County",                {-1213.90,-2892.90,-242.90,44.60,-768.00,900.00}},
	{"Whetstone",                   {-2997.40,-2892.90,-242.90,-1213.90,-1115.50,900.00}}
};

new vehName[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxvillde", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Freight", "Streak", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car", "Police Car", "Police Car",
    "Police Ranger", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};


enum pInfo
{
    pAdmin,
    pPolice,
	pRegDate,
	pRegMonth,
	pRegYear,
	pTutorial,
	pLicense,
	pPassport,
	pBankCash,
	pUserID,
	pCop,
	pSkin,
	pCrime,
	Float:pSaveX,
	Float:pSaveY,
	Float:pSaveZ,
	pSaveInt,
	Float:pSaveHealth,
	Float:pSaveArmor,
}
new PlayerInfo[MAX_PLAYERS][pInfo];


new gMute[MAX_PLAYERS],
	gLogged[MAX_PLAYERS],
	gWarned[MAX_PLAYERS],
	gFreeze[MAX_PLAYERS],
	gLevel[MAX_PLAYERS],
	gLoopingAnim[MAX_PLAYERS],
	gPhone[MAX_PLAYERS],
	gTutorial[MAX_PLAYERS],
	gLicenseTest[MAX_PLAYERS],
	gLicenseCount[MAX_PLAYERS],
	Float:gBeforeEnterX[MAX_PLAYERS],
	Float:gBeforeEnterY[MAX_PLAYERS],
	Float:gBeforeEnterZ[MAX_PLAYERS],
	gSuspectReason[MAX_PLAYERS],
	gSentMoney[MAX_PLAYERS],
	gCallTaxi[MAX_PLAYERS],
	gTaxiFee[MAX_PLAYERS],
	//gTaxiCall[MAX_PLAYERS],
	gLastCall[MAX_PLAYERS];
	
new BURGERproduct[MAX_PLAYERS],
	PIZZAproduct[MAX_PLAYERS];
	
new CrimSpawn[MAX_PLAYERS];
	
new FirstTimeSpawn[MAX_PLAYERS];
new SeeCP[MAX_PLAYERS];
new gRepeatHealthTimer[MAX_PLAYERS];


new price;
new HealthCheckTimer;

new VehGas[MAX_VEHICLES];

new Menu:BankMainMenu,
	Menu:BankWithdraw,
	Menu:BankDeposit,
	Menu:DriverLicense,
	Menu:PoliceDuty,
	Menu:Boundaries,
	Menu:BarMenu,
	Menu:CockBar,
	Menu:BurgerShotMenu,
	Menu:StackedPizzaMenu,
	Menu:PaymentMethod;


new Text:ZoneText[MAX_PLAYERS],
	Text:Textie[MAX_PLAYERS];

new RefuelTimer,
	RefuelStart;
	
new ZoneTimer;
	
new Hour,
	Minute,
	Second;
	
new Year,
	Month,
	Day;
	
new TutTimer;
new DriveCountT;

new DrivingInfo,
	DrivingRec;

new Bank1C,
	Bank2C,
	Bank3C;
	
new SFPDC;

new DrivingPasses,
	DrivingFails;

new SuccessCommands,
	UnSuccessCommands;

new SFPDGATE1,
	SFPDGATE2;
	
new SFPDInfo1,
	SFPDInfo2;

new TotalRegs;

new OldFuel;

new BarInfo[2],
	BarEnter[2];

new CluckingBell[2],
	StackedPizza[2],
	BurgerShot[3];
	
new DrivingSchool[1];

new KnuckleKills,
	BrassKnuckleKills,
	GolfClubKills,
	NiteStickKills,
	KnifeKills,
	BatKills,
	ShovelKills,
	PoolCueKills,
	KatanaKills,
	ChainsawKills,
	FlowerKills,
	CaneKills,
	GrenadeKills,
	TearGasKills,
	MolotovKills,
	ninemmKills,
	S9mmKills,
	DeagleKills,
	ShotgunKills,
	SawnoffKills,
	CombatShotgunKills,
	MicroSMGKills,
	MP5Kills,
	AkKills,
	M4Kills,
	Tec9Kills,
	CountryRifleKills,
	SniperKills,
	RocketLauncherKills,
	HeatSeekingRocketLauncherKills,
	FlameThrowerKills,
	MinigunKills,
	SprayKills,
	FireExtKills,
	CameraKills,
	VehicleKills,
	RotorKills,
	ExplosionKills,
	DrownKills;

new PlayerName[24],
	playerip[20];

new RandGas[][] =
{
	70,
	80,
	75,
	85,
	90,
	95
};

#define MAX_ILLEGALNAMES 42

new IllegalNames[MAX_ILLEGALNAMES][] =
{
	"com1",
	"com2",
	"com3",
	"com4",
	"com5",
	"com6",
	"com7",
	"com8",
	"com9",
	"lpt1",
	"lpt2",
	"lpt3",
	"lpt4",
	"lpt5",
	"lpt6",
	"lpt7",
	"lpt8",
	"lpt9",
	"nul",
	"clock$",
	"aux",
	"prn",
	"con",
	"Carl",
	"Rocky",
	"Pepe",
	"Arnoldo",
	"SgtPepper",
	"Pepsi",
	"Pepno",
	"Azucar",
	"Vino_Toro",
	"Zoquete",
	"Pacman",
	"Batman",
	"AquilesBrinco",
	"Manfrey",
	"Sopapeala",
	"Papirola",
	"Sony",
	"[ViP]Labrik",
	"[MT]Lavis"
};

main()
{
	for(new fl00d = 0; fl00d < 10; fl00d++)
	{
	    print(" ");
	}
	new FileMSG[256];
	new File: hFile;
	gettime(Hour, Minute, Second);
	getdate(Year, Month, Day);
	hFile = fopen("/VirtualScriptingRP/Logs/Exists.txt", io_append);
    if(!fexist("/VirtualScriptingRP/Logs/aCheat.txt"))
    {
		print("| LogFile: \"aCheat.txt\" NOT FOUND!");
		format(FileMSG, sizeof(FileMSG), "FileCheck: \"/VirtualScriptingRP/Logs/aCheat.txt\" NOT FOUND.", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
	else
	{
	    print("| LogFile: \"aCheat.txt\" FOUND!");
	    format(FileMSG, sizeof(FileMSG), "FileCheck: \"/VirtualScriptingRP/Logs/aCheat.txt\" FOUND.", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
    if(!fexist("/VirtualScriptingRP/Logs/Kills.txt"))
    {
		print("| LogFile: \"Kills.txt\" NOT FOUND!");
		format(FileMSG, sizeof(FileMSG), "FileCheck: \"/VirtualScriptingRP/Logs/Kills.txt\" NOT FOUND.", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
	else
	{
	    print("| LogFile: \"Kills.txt\" FOUND!");
	    format(FileMSG, sizeof(FileMSG), "FileCheck: \"/VirtualScriptingRP/Logs/Kills.txt\" FOUND.", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
    if(!fexist("/VirtualScriptingRP/Logs/CheckPoint.txt"))
    {
		print("| LogFile: \"CheckPoint.txt\" NOT FOUND!");
		format(FileMSG, sizeof(FileMSG), "FileCheck: \"/VirtualScriptingRP/Logs/CheckPoint.txt\" NOT FOUND.", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
	else
	{
	    print("| LogFile: \"CheckPoint.txt\" FOUND!");
	    format(FileMSG, sizeof(FileMSG), "FileCheck: \"/VirtualScriptingRP/Logs/CheckPoint.txt\" FOUND.", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
	if(!fexist("/VirtualScriptingRP/Logs/PoliceDuty.txt"))
    {
		print("| LogFile: \"PoliceDuty.txt\" NOT FOUND!");
		format(FileMSG, sizeof(FileMSG), "FileCheck: \"/VirtualScriptingRP/Logs/PoliceDuty.txt\" NOT FOUND.", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
	else
	{
	    print("| LogFile: \"PoliceDuty.txt\" FOUND!");
	    format(FileMSG, sizeof(FileMSG), "FileCheck: \"/VirtualScriptingRP/Logs/PoliceDuty.txt\" FOUND.", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
	if(!fexist("/VirtualScriptingRP/Logs/SetPlayerCriminal.txt"))
    {
		print("| LogFile: \"SetPlayerCriminal.txt\" NOT FOUND!");
		format(FileMSG, sizeof(FileMSG), "FileCheck: \"/VirtualScriptingRP/Logs/SetPlayerCriminal.txt\" NOT FOUND.", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
	else
	{
	    print("| LogFile: \"SetPlayerCriminal.txt\" FOUND!");
	    format(FileMSG, sizeof(FileMSG), "FileCheck: \"/VirtualScriptingRP/Logs/SetPlayerCrimial.txt\" FOUND.", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
	if(!fexist("/VirtualScriptingRP/Logs/Connections.txt"))
	{
	    print("| LogFile: \"Connections.txt\" NOT FOUND!");
	    format(FileMSG, sizeof(FileMSG), "FileCheck: \"/VirtualScriptingRP/Logs/Connections.txt\" NOT FOUND.", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
	else
	{
        print("| LogFile: \"Connections.txt\" FOUND!");
        format(FileMSG, sizeof(FileMSG), "FileCheck: \"/VirtualScriptingRP/Logs/Connections.txt\" FOUND.", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
	if(!fexist("/VirtualScriptingRP/Accounts/"))
	{
		print("| Folder: \"/VirtualScriptingRP/Accounts/\"NOT FOUND!");
		print("| Shutdown");
		SetTimer("ShutDown", 3000, true);
		format(FileMSG, sizeof(FileMSG), "FolderCheck: \"/VirtualScriptingRP/Accounts/\" NOT FOUND.\n", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
	else
	{
	    print("| Folder: \"/VirtualScriptingRP/Accounts/\" FOUND!");
	    format(FileMSG, sizeof(FileMSG), "FolderCheck: \"/VirtualScriptingRP/Accounts/\" FOUND.\n", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
	if(!fexist("/VirtualScriptingRP/Stats/"))
	{
	    print("| Folder: \"/VirtualScriptingRP/Stats/\" NOT FOUND.");
	    print("| Shutdown");
	    format(FileMSG, sizeof(FileMSG), "FolderCheck: \"/VirtualScriptingRP/Stats/\" NOT FOUND.\n", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	    SetTimer("ShutDown", 3000, true);
	}
	else
	{
	    print("| Folder: \"/VirtualScriptingRP/Stats/\" FOUND!");
	    format(FileMSG, sizeof(FileMSG), "FolderCheck: \"/VirtualScriptingRP/Stats/\" FOUND.\n", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
	if(!fexist("/VirtualScriptingRP/Stats/drivingschool.cfg"))
	{
	    dini_Create("/VirtualScriptingRP/Stats/drivingschool.cfg");
	    dini_IntSet("/VirtualScriptingRP/Stats/drivingschool.cfg", "Passes", 0);
		dini_IntSet("/VirtualScriptingRP/Stats/drivingschool.cfg", "Fails", 0);
		print("| File: \"drivingschool.cfg\" NOT FOUND, CREATED!");
		format(FileMSG, sizeof(FileMSG), "FileCheck: \"/VirtualScriptingRP/drivingschool.cfg/\" NOT FOUND, Created.\n", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
	else
	{
	    DrivingPasses = dini_Int("/VirtualScriptingRP/Stats/drivingschool.cfg", "Passes");
	    DrivingFails = dini_Int("/VirtualScriptingRP/Stats/drivingschool.cfg", "Fails");
	    print("| File: \"drivingschool.cfg\" FOUND!");
	    format(FileMSG, sizeof(FileMSG), "FileCheck: \"/VirtualScriptingRP/drivingschool.cfg/\" FOUND.\n", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
	if(!fexist("/VirtualScriptingRP/Stats/commands.cfg"))
	{
	    dini_Create("/VirtualScriptingRP/Stats/commands.cfg");
	    dini_IntSet("/VirtualScriptingRP/Stats/commands.cfg", "Successful", 0);
		dini_IntSet("/VirtualScriptingRP/Stats/commands.cfg", "Unsuccessful", 0);
		print("| File: \"commands.cfg\" NOT FOUND, CREATED!");
		format(FileMSG, sizeof(FileMSG), "FileCheck: \"/VirtualScriptingRP/commands.cfg/\" NOT FOUND, Created.\n", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
	else
	{
	    SuccessCommands = dini_Int("/VirtualScriptingRP/Stats/commands.cfg", "Successful");
	    UnSuccessCommands = dini_Int("/VirtualScriptingRP/Stats/commands.cfg", "Unsuccessful");
	    print("| File: \"commands.cfg\" FOUND!");
	    format(FileMSG, sizeof(FileMSG), "FileCheck: \"/VirtualScriptingRP/drivingschool.cfg/\" FOUND.\n", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
	if(!fexist("/VirtualScriptingRP/Stats/registrations.cfg"))
	{
	    dini_Create("/VirtualScriptingRP/Stats/registrations.cfg");
	    dini_IntSet("/VirtualScriptingRP/Stats/registrations.cfg", "TotalREG", 0);
		print("| File: \"registrations.cfg\" NOT FOUND, CREATED!");
		format(FileMSG, sizeof(FileMSG), "FileCheck: \"/VirtualScriptingRP/registrations.cfg/\" NOT FOUND, Created.\n", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
	else
	{
	    TotalRegs = dini_Int("/VirtualScriptingRP/Stats/registrations.cfg", "TotalREG");
	    print("| File: \"registrations.cfg\" FOUND!");
	    format(FileMSG, sizeof(FileMSG), "FileCheck: \"/VirtualScriptingRP/drivingschool.cfg/\" FOUND.\n", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
	if(!fexist("/VirtualScriptingRP/Stats/deaths.cfg"))
	{
		dini_Create("/VirtualScriptingRP/Stats/deaths.cfg");
		print("| File: \"deaths.cfg\" NOT FOUND, CREATED!");
		format(FileMSG, sizeof(FileMSG), "FileCheck: \"/VirtualScriptingRP/deaths.cfg/\" NOT FOUND, Created.\n", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Knuckle", KnuckleKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Brass Knuckle", BrassKnuckleKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Golf Club", GolfClubKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Nite Stick", NiteStickKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Knife", KnifeKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Bat", BatKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Shovel", ShovelKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Pool Cue", PoolCueKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Katana", KatanaKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Chainsaw", ChainsawKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Flowers", FlowerKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Cane", CaneKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Grenade", GrenadeKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Tear Gas", TearGasKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Molotov", MolotovKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "9MM", ninemmKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Silenced 9MM", S9mmKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Desert Eagle", DeagleKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Shotgun", ShotgunKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Sawnoff Shotgun", SawnoffKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Combat Shotgun", CombatShotgunKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Micro SMG", MicroSMGKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "MP5 Kills", MP5Kills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Ak47", AkKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "M4", M4Kills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Tec9", Tec9Kills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Country Rifle", CountryRifleKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Sniper", SniperKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Rocket Launcher", RocketLauncherKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "HS Rocket Launcher", HeatSeekingRocketLauncherKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "FlameThrower", FlameThrowerKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Minigun", MinigunKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Spray Can", SprayKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Fire Ext", FireExtKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Camera", CameraKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Vehicle", VehicleKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Rotors", RotorKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Explosion", ExplosionKills);
		dini_IntSet("/VirtualScriptingRP/Stats/deaths.cfg", "Drowning", DrownKills);
	}
	else
	{
		KnuckleKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Knuckle");
		BrassKnuckleKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Brass Knuckle");
		GolfClubKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Golf Club");
		NiteStickKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Nite Stick");
		KnifeKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Knife");
		BatKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Bat");
		ShovelKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Shovel");
		PoolCueKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Pool Cue");
		KatanaKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Katana");
		ChainsawKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Chainsaw");
		FlowerKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Flowers");
		CaneKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Cane");
		GrenadeKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Grenade");
		TearGasKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Tear Gas");
		MolotovKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Molotov");
		ninemmKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "9MM");
		S9mmKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Silenced 9MM");
		DeagleKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Desert Eagle");
		ShotgunKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Shotgun");
		SawnoffKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Sawnoff Shotgun");
		CombatShotgunKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Combat Shotgun");
		MicroSMGKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Micro SMG");
		MP5Kills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "MP5 Kills");
		AkKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Ak47");
		M4Kills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "M4");
		Tec9Kills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Tec9");
		CountryRifleKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Country Rifle");
		SniperKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Sniper");
		RocketLauncherKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Rocker Launcher");
		HeatSeekingRocketLauncherKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "HS Rocket Launcher");
		FlameThrowerKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "FlameThrower");
		MinigunKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Minigun");
		SprayKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Spray Can");
		FireExtKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Fire Ext");
		CameraKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Camera");
		VehicleKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Vehicle");
		RotorKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Rotors");
		ExplosionKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Explosion");
		DrownKills = dini_Int("/VirtualScriptingRP/Stats/deaths.cfg", "Drowning");
		print("| File: \"deaths.cfg\" FOUND!");
		format(FileMSG, sizeof(FileMSG), "FileCheck: \"/VirtualScriptingRP/drivingschool.cfg/\" FOUND.\n", Day, Month, Hour, Minute);
		aLog("CheckExist.txt", FileMSG);
	}
    fclose(hFile);
	print(" ");
	
	printf("  GAMEMODE NAME: %s", GM_NAME);
	printf("       HOSTNAME: %s ", SERVER_NAME);
	printf("        MAPNAME: %s ", MAP_NAME);
	printf("         WEBURL: %s ", SITEADDRESS);
	printf("    MAX PLAYERS: %d", GetMaxPlayers());
	print(" ");
	printf("  STARTING DATE: %s", DEV_START);
	printf("      DEVELOPER: %s", SCRIPT_DEV);
	printf("    LAST UPDATE: %s", LAST_UPDATE);
	printf(" SCRIPT VERSION: %s", SCRIPT_VERSION);
}

public OnGameModeInit()
{
	new sendcmd[128];
	SetGameModeText(GM_NAME);
	EnableStuntBonusForAll(false);
	DisableInteriorEnterExits();
	
	for(new Vehicles = 0; Vehicles < MAX_VEHICLES; Vehicles++)
 	{
 	    new RandomGas[] =
 	    {
 	        100, 99, 98, 97, 96, 95, 94, 93, 92, 91, 90,
 	        89, 88, 87, 86, 85, 84, 83, 82, 81, 80, 79
		};
 		VehGas[Vehicles] = RandomGas[random(sizeof(RandomGas))];
  	}

    format(sendcmd, sizeof(sendcmd), "hostname %s", SERVER_NAME);
	SendRconCommand(sendcmd);
	format(sendcmd, sizeof(sendcmd), "mapname %s", MAP_NAME);
	SendRconCommand(sendcmd);
	format(sendcmd, sizeof(sendcmd), "weburl %s", SITEADDRESS);
	SendRconCommand(sendcmd);

  	AddStaticVehicle(516, -2425.2878, 741.1858, 34.8493, 0.4955, 122, 1); // Nebula
	AddStaticVehicle(517, -2438.3501, 741.5833, 34.8705, 180.1800, 40, 36); // Majestic
	AddStaticVehicle(518, -2473.1470, 741.2720, 34.6865, 180.4642, 17, 1); // Buccaneer
	AddStaticVehicle(400, -2532.3191, 729.6574, 28.9585, 179.9155, 123, 1); // Landstalker
	AddStaticVehicle(551, -2573.6731, 626.3083, 27.6067, 180.2870, 72, 1); // Merit
	AddStaticVehicle(543, -2670.3623, 632.6180, 14.2709, 89.8208, 32, 8); // Sadler
	AddStaticVehicle(422, -2732.1335, 511.2144, 9.0637, 221.9380, 97, 25); // Bobcart
	AddStaticVehicle(416, -2543.8933, 598.7765, 14.6024, 90.0130, 1, 3); // Ambulance
	AddStaticVehicle(416, -2546.5386, 658.3376, 14.6082, 88.7852, 1, 3); // Ambulance
	AddStaticVehicle(416, -2588.8782, 648.1311, 14.6031, 88.1219, 1, 3); // Ambulance
	AddStaticVehicle(416, -2571.5459, 632.8134, 14.6082, 270.2839, 1, 3); // Ambulance
	AddStaticVehicle(416, -2546.2578, 627.3926, 14.6028, 267.9378, 1, 3); // Ambulance
	AddStaticVehicle(416, -2657.5667, 633.1082, 14.6023, 89.6346, 1, 3); // Ambulance
	AddStaticVehicle(597, -2679.9575, 582.7929, 14.2219, 270.2603, 125, 1); // SFPD Police
	AddStaticVehicle(454, -2940.9353, 494.0267, -0.2058, 359.3485, 26, 26); // Tropic
	AddStaticVehicle(454, -2982.1790, 499.2759, 0.2074, 183.3476, 26, 26); // Tropic
	AddStaticVehicle(445, -2859.6326, 409.8133, 4.3372, 179.2778, 37, 37); // Admiral
	AddStaticVehicle(410, -2681.6401, 268.2309, 3.9906, 359.5614, 9, 1); // Manana
	AddStaticVehicle(559, -2688.4238, 268.2239, 3.9923, 179.7488, 58, 8); // Jester
	AddStaticVehicle(445, -2641.3103, 232.5702, 4.1254, 181.2405, 39, 39); // Admiral
	AddStaticVehicle(551, -2654.2007, 209.5425, 4.1280, 270.0021, 75, 1); // Merit
	AddStaticVehicle(409, -2757.2314, 371.1086, 4.1479, 180.8093, 1, 1); // Stretch
	AddStaticVehicle(597, -2757.3022, 378.9564, 4.1041, 179.7299, 125, 1); // SFPD
	AddStaticVehicle(492, -2655.6165, 350.3810, 4.1645, 180.4903, 77, 26); // Greenwood
	AddStaticVehicle(412, -2723.5005, 76.1278, 4.1740, 269.9083, 10, 8); // Voodoo
	AddStaticVehicle(410, -2654.8689, 61.9926, 3.7952, 181.1738, 10, 1); // Manana
	AddStaticVehicle(521, -2673.0464, -34.2488, 3.9058, 359.8347, 75, 13); // FCR-900
	AddStaticVehicle(419, -2689.6458, -22.6049, 4.1334, 181.1583, 47, 76); // Esperanto
	AddStaticVehicle(492, -2713.0801, -130.9766, 4.1100, 179.5649, 81, 27); // Greenwood
	AddStaticVehicle(466, -2598.3447, -183.9028, 4.0700, 0.2770,68, 76); // Glendale
	AddStaticVehicle(571, -2645.7358, -289.2120, 6.7874, 313.2319, 36, 2); // Kart
	AddStaticVehicle(571, -2660.4893, -290.1765, 6.7217, 135.0981, 51, 53); // Kart
	AddStaticVehicle(571, -2464.9182, -256.2429, 38.8598, 317.2849, 91, 2); // Kart
	AddStaticVehicle(471, -2648.9617, -286.2198, 6.9891, 133.1177, 103, 111); // Quad
	AddStaticVehicle(471, -2573.0232, -290.4423, 22.8898,190.3424, 103, 111); // Quad
	AddStaticVehicle(445,-2315.1189,-125.8396,35.1873,359.6969,41,41); // Admiral
	AddStaticVehicle(498,-2318.9124,-160.0348,35.4976,178.4516,13,120); // Boxville
	AddStaticVehicle(419,-2348.4851,-126.0435,35.1099,359.7693,33,75); // Esperanto
	AddStaticVehicle(556,-2161.1899,-444.0206,35.7183,315.4825,1,1); // Monster A
	AddStaticVehicle(557,-2161.3694,-409.9630,35.7108,43.3412,1,1); // Monster B
	AddStaticVehicle(504,-2185.7124,-375.1693,35.1903,88.7477,57,38); // Bloodring Banger
	AddStaticVehicle(519,-1363.4941,-487.1831,15.0939,204.0229,1,1); // Shamal
	AddStaticVehicle(476,-1434.9257,-507.1026,14.8908,206.2888,7,6); // Rustler
	AddStaticVehicle(476,-1446.3364,-512.6240,14.8996,207.4970,1,6); // Rustler
	AddStaticVehicle(476,-1458.5927,-518.5544,14.8986,207.1131,89,91); // Rustler
	AddStaticVehicle(519,-1337.7004,-277.5450,15.0693,293.8890,1,1); // Shamal
	AddStaticVehicle(511,-1353.2996,-257.5726,15.5209,314.4899,4,90); // Beagle
	AddStaticVehicle(513,-1398.3967,-220.9672,14.6917,156.4105,21,34); // Stunt
	AddStaticVehicle(511,-1622.9580,-130.6864,15.5255,314.2704,7,68); // Beagle
	AddStaticVehicle(498,-1720.5579,-122.2701,3.6177,44.8385,20,117); // Boxville
	AddStaticVehicle(413,-1548.3145,120.0545,3.6234,314.6756,88,1); // Pony
	AddStaticVehicle(487,-1563.6835,62.8217,17.4976,316.5023,29,42); // Maverick
	AddStaticVehicle(430,-1632.1780,161.8904,-0.1242,136.0866,46,26); // Predator
	AddStaticVehicle(413,-1739.4150,170.6010,3.6379,180.2408,91,1); // Pny
	AddStaticVehicle(403,-1825.2046,87.9832,15.7228,179.6118,37,1); // Linerunner
	AddStaticVehicle(533,-1834.0691,-110.9771,5.2761,270.1046,74,1); // Feltzer
	AddStaticVehicle(451,-2081.2783,-85.3058,34.8705,359.4592,36,36); // Turismo
	AddStaticVehicle(533,-2068.3479,-85.0453,34.8731,180.2602,74,1); // Feltzer
	AddStaticVehicle(445,-2025.7653,-92.8102,35.1133,268.9677,45,45); // Admiral
	AddStaticVehicle(407,-2020.6356,84.1991,28.1837,272.0926,3,1); // Firetruck
	AddStaticVehicle(407,-2021.7834,75.9919,28.3028,273.1079,3,1); // Firetruck
	AddStaticVehicle(400,-1985.9426,126.7992,27.6515,359.3065,75,1); // Landstalker
	AddStaticVehicle(475,-2036.0370,135.7078,28.6403,91.2167,9,39); // Sabre
	AddStaticVehicle(533,-1947.1836,272.3094,40.7592,310.9155,75,1); // Feltzer
	AddStaticVehicle(562,-1955.8291,281.8276,40.7060,359.3909,35,1); // Elegy
	AddStaticVehicle(409,-1948.4104,263.1227,40.8484,50.0614,1,1); // Stretch
	AddStaticVehicle(559,-1953.3989,258.4184,40.7031,90.8403,68,8); // Jester
	AddStaticVehicle(475,-1946.1071,274.7504,35.2765,106.3676,17,1); // Sabre
	AddStaticVehicle(451,-1945.6909,267.3374,35.1810,329.5846,18,18); // Turismo
	AddStaticVehicle(507,-1947.5261,256.2991,35.2933,270.3677,42,42); // Elegant
	AddStaticVehicle(524,-2053.6497,218.6199,36.4949,151.8392,61,27); // Cement Truck
	AddStaticVehicle(521,-1989.0588,271.3849,34.7246,90.2340,87,118); // FCR-900
	AddStaticVehicle(445,-2014.3318,440.7968,35.0469,0.4195,47,47); // Admiral
	AddStaticVehicle(521,-1961.5580,465.1934,34.7383,268.2305,87,118); // FCR-900
	AddStaticVehicle(420,-2025.5513,573.6757,34.8651,89.1413,6,1); // Taxi
	AddStaticVehicle(562,-1950.3141,584.5537,34.7931,0.1350,17,1); // Elegy
	AddStaticVehicle(492,-1941.4041,585.4968,34.8969,359.5607,24,55); // Greenwood
	AddStaticVehicle(475,-1806.3191,597.6450,34.8362,270.2541,21,1); // Sabre
	AddStaticVehicle(497,-1679.7410,706.0261,30.7658,268.3249,125,1); // Police Maverick
	AddStaticVehicle(523,-1616.3674,733.0511,-5.6705,359.4854,0,0); // HPV1000
	AddStaticVehicle(523,-1573.8816,742.5757,-5.6754,88.4248,0,0); // HPV1000
	AddStaticVehicle(523,-1589.0773,706.5397,-5.6728,84.6282,0,0); // HPV1000
	AddStaticVehicle(523,-1588.7937,709.6614,-5.6724,86.6815,0,0); // HPV1000
	AddStaticVehicle(597,-1612.5870,748.7038,-5.4731,179.2539,125,1); // SFPD
	AddStaticVehicle(597,-1596.3385,749.6467,-5.4735,0.1312,125,1); // SFPD
	AddStaticVehicle(597,-1573.1725,742.7471,-5.4740,269.2522,125,1); // SFPD
	AddStaticVehicle(597,-1574.9725,710.0151,-5.4734,89.2236,125,1); // SFPD
	AddStaticVehicle(597,-1596.0098,675.2755,-5.4728,178.8288,125,1); // SFPD
	AddStaticVehicle(597,-1637.8308,686.1718,-5.4751,90.2400,125,1); // SFPD
	AddStaticVehicle(427,-1637.6498,653.7021,-5.1104,90.1133,125,1); // Enforcer
	AddStaticVehicle(427,-1623.7285,653.7054,-5.1105,88.6870,125,1); // Enforcer
	AddStaticVehicle(427,-1628.7721,692.9220,-5.1102,358.6445,125,1); // Enforcer
	AddStaticVehicle(597,-1606.1411,673.4214,6.9560,0.8676,125,1); // SFPD
	AddStaticVehicle(597,-1599.0710,652.2718,6.9569,0.7316,125,1); // SFPD
	AddStaticVehicle(597,-1588.2230,673.7241,6.9565,0.2993,125,1); // SFPD
	AddStaticVehicle(597,-1595.1440,723.1218,9.7942,269.9301,125,1); // SFPD
	AddStaticVehicle(597,-1602.0226,723.0130,11.0363,269.7875,125,1); // SFPD
	AddStaticVehicle(523,-1616.8370,652.2477,6.7573,181.2263,125,1); // HPV1000
	AddStaticVehicle(523,-1633.9985,651.2896,6.7593,359.2784,125,1); // HPV1000
	AddStaticVehicle(475,-1869.9020,832.6749,34.8879,88.9975,33,0); // Sabre
	AddStaticVehicle(445,-1886.0194,961.9265,35.0469,349.9827,34,34); // Admiral
	AddStaticVehicle(551,-2066.2305,962.7144,60.1817,58.3322,83,1); // Merit
	AddStaticVehicle(466,-2243.8374,937.1382,66.3905,0.0271,78,76); // Glendale
	AddStaticVehicle(400,-2196.7971,1009.0972,80.0922,182.8483,62,1); // Landstalker
	AddStaticVehicle(438,-1403.4080,-316.3840,14.0698,31.4731,6,76); // Cabbie
	AddStaticVehicle(420,-1408.3999,-309.4926,13.8453,41.7801,6,1); // Taxi
	AddStaticVehicle(420,-1413.3080,-303.8777,13.8433,41.4240,6,1); // Taxi
	AddStaticVehicle(420,-1871.8398,-780.9998,31.8026,269.4949,6,1); // Taxi
	AddStaticVehicle(418,-1897.6689,-827.2172,32.1164,269.2579,117,227); // Moonbeam
	AddStaticVehicle(458,-1897.0961,-890.6368,31.9018,269.8734,101,1); // Solair
	AddStaticVehicle(533,-1981.7480,-784.9205,31.8091,0.3374,84,1); // Feltzer
	AddStaticVehicle(487,-2110.4255,-826.7753,32.3494,0.8889,54,29); // Maverick
	AddStaticVehicle(556,-2164.9761,-440.1664,35.7182,314.7961,1,1); // Monster A
	AddStaticVehicle(556,-2168.5930,-436.7095,35.7146,312.3688,1,1); // Monster A
	AddStaticVehicle(504,-2175.4226,-375.2547,35.1592,87.5755,57,38); // Bloodring Banger
	AddStaticVehicle(458,-2105.8662,-377.4238,35.2052,269.4374,109,1); // Solair
	AddStaticVehicle(413,-2245.9211,-104.6725,35.3959,359.8877,119,1); // Pony
	AddStaticVehicle(522,-2327.8831,-42.7619,34.8790,90.2929,8,82); // NRG
	AddStaticVehicle(533,-2495.2539,-118.3723,25.3269,179.1652,91,1); // Feltzer
	AddStaticVehicle(475,-2551.0791,-124.5544,12.8179,90.1259,9,39); // Sabre
	AddStaticVehicle(475,-2613.5996,202.5997,4.5302,0.1948,9,39); // Sabre
	AddStaticVehicle(438,-2559.8953,234.4364,10.5421,314.5380,6,76); // Cabbie
	AddStaticVehicle(521,-2538.5574,217.6043,10.6625,322.2007,118,118); // FCR
	AddStaticVehicle(420,-2509.6038,386.1562,27.5459,155.0637,6,1); // Taxi
	AddStaticVehicle(418,-2487.1826,421.2964,27.8739,315.3618,114,114); // Moonbeam
	AddStaticVehicle(445,-2486.2153,398.5534,27.6535,141.8650,43,43); // Admiral
	AddStaticVehicle(507,-2555.9421,415.6899,18.8599,91.9090,62,62); // Elegant
	AddStaticVehicle(411,-2671.3101,819.4034,49.7114,88.5313,64,1); // Infernus
	AddStaticVehicle(533,-2718.2004,789.2832,50.0072,176.7814,73,1); // Feltzer
	AddStaticVehicle(529,-2865.4377,816.5403,38.6821,237.6926,62,62); // Willard
	AddStaticVehicle(562,-2856.9109,683.9863,22.6264,294.6224,113,1); // elegy
	AddStaticVehicle(559,-2837.8005,924.2070,43.7128,274.4398,22,1); // jester
	AddStaticVehicle(507,-2894.7910,1033.0004,35.7577,110.2632,7,7); // Elegant
	AddStaticVehicle(445,-2899.2019,1101.2668,27.0900,91.9538,45,45); // Admiral
	AddStaticVehicle(400,-2897.4688,1165.1000,13.1670,93.2332,123,1); // Landstalker
	AddStaticVehicle(409,-2625.2947,1380.0731,6.9571,268.7099,1,1); // Stretch
	AddStaticVehicle(420,-2646.7266,1375.1948,6.9506,181.7506,6,1); // Taxi
	AddStaticVehicle(420,-2646.3792,1364.1155,6.9470,181.8421,6,1); // Taxi
	AddStaticVehicle(420,-2645.9795,1351.9685,6.9473,181.9281,6,1); // Taxi
	AddStaticVehicle(420,-2645.5425,1339.2787,6.9435,181.9873,6,1); // Taxi
	AddStaticVehicle(559,-2623.2964,1336.6392,6.8516,316.8271,36,8); // jester
	AddStaticVehicle(418,-2437.5808,1284.7736,23.4557,268.6882,108,108); // Moonbeam
	AddStaticVehicle(551,-2471.7600,1246.3634,33.5681,178.7907,20,1); // Merit
	AddStaticVehicle(551,-2538.4819,1228.5203,37.2226,32.0035,20,1); // Merit
	AddStaticVehicle(521,-2529.3599,1228.3027,36.9984,34.5332,74,74); // FCR
	AddStaticVehicle(420,-2517.0071,1217.8232,37.2050,271.1257,6,1); // Taxi
	AddStaticVehicle(411,-2510.2012,1138.8628,55.4536,355.8026,123,1); // Infernus
	AddStaticVehicle(533,-2489.7761,1139.0807,55.4356,359.2488,75,1); // Feltzer
	AddStaticVehicle(510,-2424.8582,1135.8804,55.3323,346.3345,46,46); // Mountain Bike
	AddStaticVehicle(507,-2414.4209,1013.5538,50.2153,180.1812,10,10); // Elegant
	AddStaticVehicle(420,-2417.4063,962.9957,45.0758,180.1853,6,1); // Taxi
	AddStaticVehicle(429,-2340.2698,1023.3486,50.3750,270.6475,13,13); // Banshee
	AddStaticVehicle(426,-2133.5261,832.5763,69.2207,357.8203,53,53); // Premier
	AddStaticVehicle(426,-1706.0237,895.5903,24.5564,359.6268,53,53); // Premier
	AddStaticVehicle(409,-1505.6543,919.4507,6.9875,358.3997,1,1); // Stretch
	AddStaticVehicle(429,-1677.9601,1208.7222,13.3514,41.5906,2,1); // Banshee
	AddStaticVehicle(507,-1664.2706,1222.6949,20.9797,14.8489,11,11); // Elegant
	AddStaticVehicle(562,-1677.5103,1208.1477,20.8178,244.6879,101,1); // Elegy
	AddStaticVehicle(426,-1665.0753,1206.0857,20.8994,271.1651,62,62); // Premier
	AddStaticVehicle(560,-1650.6530,1207.5706,13.3773,44.2361,9,39); // Sultan
	AddStaticVehicle(409,-1659.3184,1218.8202,13.4723,225.9087,1,1); // Stretch
	AddStaticVehicle(405,-1661.0079,1211.2034,13.5514,261.3396,24,1); // Sentinel
	AddStaticVehicle(475,-1663.5665,1214.7219,7.0555,64.1392,17,1); // Sabre
	AddStaticVehicle(521,-1661.7126,1216.3907,6.8157,254.3886,75,13); // FCR
	AddStaticVehicle(560,-1791.0344,1310.5157,31.5561,357.8456,17,1); // Sultan
	AddStaticVehicle(405,-1798.5801,1294.1530,31.7266,176.5786,36,1); // Sentinel
	AddStaticVehicle(426,-1792.9783,1293.1337,40.8917,178.1641,7,7); // Premier
	AddStaticVehicle(562,-1821.8967,1309.8783,40.8070,3.2269,92,1); // Elegy
	AddStaticVehicle(411,-1810.6653,1311.5833,50.1723,10.2304,116,1); // Infernus
	AddStaticVehicle(551,-1811.5743,1292.9128,59.5349,187.5152,67,1); // Merit
	AddStaticVehicle(521,-1799.0673,1293.4658,59.3037,358.5936,87,118); // FCR
	AddStaticVehicle(445,-1686.7178,1311.8469,7.0549,226.8243,47,47); // Admiral
	AddStaticVehicle(442,-1981.7015,1131.5591,53.0334,180.4319,25,109); // Romero
	AddStaticVehicle(475,-1816.9491,1093.4229,45.2451,270.0972,21,1); // Sabre
	AddStaticVehicle(429,-1755.8191,956.0815,24.4898,270.5184,1,3); // Banshee
	AddStaticVehicle(429,-2095.1738,703.7852,69.2250,180.2889,1,3); // Banshee
	AddStaticVehicle(422,-2133.5615,767.0017,69.4695,359.3807,111,31); // Bobcat
	AddStaticVehicle(458,-2152.3726,627.0305,52.1936,179.7725,25,1); // Solair
	AddStaticVehicle(405,-2232.2861,526.6542,34.9639,180.0782,91,1); // Sentinel
	AddStaticVehicle(560,-2248.2410,763.7007,49.0735,0.8475,37,0); // Sultan
	AddStaticVehicle(480,-2265.2822,212.3450,34.9356,270.4601,12,12); // Comet
	AddStaticVehicle(429,-2265.9368,192.5364,34.8438,270.2142,12,12); // Banshee
	AddStaticVehicle(426,-2266.7168,141.0711,34.9025,269.7698,42,42); // Premier
	AddStaticVehicle(498,-2235.1926,160.8196,35.3912,268.7639,36,105); // Boxville
	AddStaticVehicle(521,-2176.3284,102.3809,34.8742,270.4383,118,118); // FCR
	AddStaticVehicle(466,-2140.8167,171.3551,34.9860,359.8176,18,76); // Glendale
	AddStaticVehicle(445,-2072.5459,-84.7722,35.0389,0.4048,39,39); // Admiral
	AddStaticVehicle(426,-2039.8297,-84.0452,35.0633,0.7011,53,53); // Premier
	AddStaticVehicle(538,-1942.9214,166.2676,27.0006,356.7974,1,1); // Freight
	AddStaticVehicle(521,-2050.7009,904.5859,53.7016,257.8756,87,118); // FCR
	AddStaticVehicle(426,-2060.3450,1114.2477,53.0321,181.1047,62,62); // Premier
	AddStaticVehicle(466,-2126.7202,1220.4083,47.0153,92.6758,25,76); // Glendale
	AddStaticVehicle(492,-2003.0721,1278.7556,6.9316,270.6895,71,107); // Greenwood
	AddStaticVehicle(454,-1475.7938,698.8898,0.1348,354.5030,26,26); // Tropic
	AddStaticVehicle(521,-2448.7991,504.3274,29.6553,248.0106,87,118); // FCR-900
	AddStaticVehicle(438,-2461.0562,479.6398,29.9299,117.5965,6,76); // Cabbie
	AddStaticVehicle(562,-2481.9031,429.1077,29.1994,228.6289,101,1); // Elegy
	AddStaticVehicle(421,-2430.6938,416.1882,35.0091,316.1420,13,1); // Washington
	AddStaticVehicle(551,-2411.1013,349.9853,34.9715,94.3720,20,1); // Merit
	AddStaticVehicle(421,-2429.0176,305.6406,35.0574,3.0145,25,1); // Washington
	AddStaticVehicle(409,-2405.9883,338.7039,34.7720,326.8205,1,1); // Stretch
	AddStaticVehicle(409,-2411.9031,329.6604,34.7687,326.8094,1,1); // Stretch
	AddStaticVehicle(521,-2199.1475,368.1704,34.8915,270.6112,92,3); // FCR-900
	AddStaticVehicle(470,-1336.2993,479.8390,7.1766,268.8808,43,0); // Patriot
	AddStaticVehicle(425,-1304.6702,494.8425,18.8055,90.3665,43,0); // Hunter
	AddStaticVehicle(520,-1457.4764,495.8416,19.0010,269.0480,0,0); // Hydra
	AddStaticVehicle(520,-1457.3912,507.0220,18.9906,271.1215,0,0); // Hydra
	AddStaticVehicle(520,-1416.5890,515.9076,18.9603,241.8384,0,0); // Hydra
	AddStaticVehicle(425,-1408.1580,494.3694,18.8937,268.5692,43,0); // Hunter
	AddStaticVehicle(470,-1536.9531,479.7007,7.1835,270.0548,43,0); // Patriot
	AddStaticVehicle(487,-2328.6597,-1687.1449,483.7823,182.8829,54,29); // Maverick
	AddStaticVehicle(411,-2343.9705,-1590.9053,483.3036,246.2691,112,1); // Infernus
	AddStaticVehicle(411,-2345.2742,-1593.7367,483.3156,247.0862,106,1); // Infernus
	AddStaticVehicle(411,-2346.5701,-1596.7666,483.3293,247.1088,80,1); // Infernus
	AddStaticVehicle(411,-2347.9080,-1599.8219,483.3428,246.3493,75,1); // Infernus
	AddStaticVehicle(541,-2354.4063,-1625.2379,483.2955,215.6397,58,8); // Bulletr
	AddStaticVehicle(541,-2353.4294,-1620.6281,483.2822,213.5831,60,1); // Bullet
	AddStaticVehicle(541,-2352.9004,-1616.4899,483.2700,212.1971,68,8); // Bullet
	AddStaticVehicle(541,-2352.0439,-1612.0363,483.2569,216.2323,2,1); // Bullet
	AddStaticVehicle(541,-2351.2927,-1607.8047,483.2445,215.8103,13,8); // Bullet
	AddStaticVehicle(560,-2348.4441,-1579.5002,485.4242,215.5274,33,0); // Sultan
	AddStaticVehicle(560,-2350.3411,-1584.3425,485.3729,267.6247,37,0); // Sultan
	AddStaticVehicle(573,-2336.8345,-1578.2188,484.1881,201.7329,115,43); // Duneride
	AddStaticVehicle(573,-2339.1760,-1582.2607,484.1979,204.2313,85,6); // Duneride
	AddStaticVehicle(541,-1772.0862,1204.7153,24.7500,119.1164,58,8); // Bullet
	AddStaticVehicle(492,-1755.2289,1177.5215,24.9066,270.5724,77,26); // Greenwood
	AddStaticVehicle(411,-1715.1366,1204.2119,24.8473,133.2681,75,1); // Infernus
	AddStaticVehicle(551,-1722.2679,1160.4065,29.4713,180.4222,20,1); // Merit
	AddStaticVehicle(451,-1749.8481,1112.1742,45.1523,89.3880,46,46); // Turismo
	AddStaticVehicle(521,-1684.3816,1103.8571,54.2736,356.4370,118,118); // FCR-900
	AddStaticVehicle(560,-1679.3772,1072.4230,54.4084,359.2595,56,29); // Sultan
	AddStaticVehicle(429,-2072.3572,964.2771,60.7199,1.8759,1,3); // Banshee
	AddStaticVehicle(425,-1240.1273,453.6509,7.7596,271.4653,43,0); // Hunter
	AddStaticVehicle(511,-1558.4203,-250.5281,15.5205,31.0275,8,66); // Beagle
	AddStaticVehicle(511,-1576.5905,-264.8432,15.5228,41.8686,12,60); // Beagle
	AddStaticVehicle(511,-1591.9773,-280.6310,15.5237,45.3294,27,97); // Beagle
	AddStaticVehicle(476,-1612.5680,-315.4355,14.8703,70.2653,119,117); // Rustler
	AddStaticVehicle(476,-1617.0444,-329.6920,14.8577,71.2048,103,102); // Rustler
	AddStaticVehicle(487,-1185.8213,26.4887,14.3254,225.5187,26,3); // Maverick
	AddStaticVehicle(563,-1224.1454,-9.8042,14.8563,224.3005,1,6); // Raindance
	AddStaticVehicle(563,-1212.0809,168.4649,14.8563,316.2473,1,6); // Raindance
	AddStaticVehicle(476,-1209.2734,190.2260,14.8630,135.1347,77,87); // Rustler
	AddStaticVehicle(476,-1217.5364,198.8932,14.8412,132.2879,71,77); // Rustler
	AddStaticVehicle(445,-1398.1195,-324.4655,13.7596,30.9051,39,39); // Admiral

	
	SFPDGATE1 = CreateObject(978, -1572.061890, 663.277161, 7.027720, 0.0000, 0.0000, 270.0000); // ClosedGate
	SFPDGATE2 = CreateObject(978, -1701.419800, 684.441223, 24.696056, 0.0000, 0.0000, 90.4817); // ClosedGate
	
	CreateObject(1412, -1701.639160, 692.244141, 25.164585, 0.0000, 0.0000, 270.0000);
	CreateObject(1412, -1701.640747, 697.434814, 25.164585, 0.0000, 0.0000, 270.0000);
	CreateObject(1412, -1701.625366, 702.605103, 25.164585, 0.0000, 0.0000, 270.0000);
	CreateObject(1412, -1701.650391, 707.790588, 25.164585, 0.0000, 0.0000, 270.0000);
	CreateObject(1412, -1701.663330, 712.981262, 25.164585, 0.0000, 0.0000, 270.0000);
	CreateObject(1412, -1701.767334, 716.203613, 25.164585, 0.0000, 0.0000, 270.0000);
	CreateObject(1412, -1699.166016, 718.763306, 25.125891, 0.0000, 0.0000, 359.3814);
	CreateObject(1412, -1693.966797, 718.696167, 25.114586, 0.0000, 0.0000, 359.3814);
	CreateObject(970, -1697.963135, 688.019714, 24.442106, 0.0000, 0.0000, 0.0000);
	CreateObject(970, -1693.855347, 688.004761, 24.442106, 0.0000, 0.0000, 0.0000);
	CreateObject(970, -1689.726563, 688.007202, 24.442106, 0.0000, 0.0000, 0.0000);
	CreateObject(970, -1686.636230, 688.003540, 24.442106, 0.0000, 0.0000, 0.0000);
	CreateObject(970, -1680.849731, 688.026306, 24.442099, 0.0000, 0.0000, 0.0000);
	CreateObject(970, -1676.735596, 688.023804, 24.434467, 0.0000, 0.0000, 0.0000);
	CreateObject(970, -1672.647949, 688.020508, 24.442106, 0.0000, 0.0000, 0.0000);
	CreateObject(970, -1668.535522, 688.027588, 24.442106, 0.0000, 0.0000, 0.0000);
	CreateObject(970, -1664.428223, 688.022339, 24.442106, 0.0000, 0.0000, 0.0000);
	CreateObject(981, -1720.693726, -740.930664, 35.819996, 0.0000, 0.0000, 236.2501);
	CreateObject(979, -1721.055298, -737.395874, 35.328747, 0.0000, 0.0000, 56.2500);
	CreateObject(979, -1724.877319, -742.976135, 35.410843, 0.0000, 0.0000, 56.2500);
	CreateObject(979, -1538.526245, -1591.088867, 37.679298, 0.0000, 0.0000, 90.0000);
	CreateObject(979, -1539.481201, -1600.216064, 37.674603, 0.0000, 0.0000, 77.9679);
	CreateObject(979, -1542.163208, -1608.032471, 37.600788, 0.0000, 0.0000, 63.3574);
	CreateObject(979, -1548.900269, -1611.979736, 37.622864, 0.0000, 0.0000, 358.8997);
	CreateObject(979, -1558.089478, -1611.803223, 36.681004, 358.2811, 347.9679, 358.8997);
	CreateObject(980, -893.798401, -1116.703857, 100.734329, 0.0000, 0.0000, 75.3123);
	CreateObject(980, -892.269714, -1111.143555, 100.720123, 0.0000, 0.0000, 74.4528);
	CreateObject(981, -876.692017, -1108.283569, 98.285828, 0.0000, 0.0000, 348.7500);
	CreateObject(979, -866.936279, -1116.723022, 96.642570, 0.0000, 340.2330, 153.8212);
	CreateObject(979, -877.395569, -1110.052734, 98.449593, 0.0000, 0.0000, 167.5724);
	CreateObject(979, -886.102844, -1108.205811, 98.522530, 0.0000, 0.0000, 167.5724);
	CreateObject(979, -1500.668335, 589.933594, 34.418346, 0.0000, 0.0000, 123.7499);
	CreateObject(979, -1498.166748, 586.170410, 34.418346, 0.0000, 0.0000, 124.6094);
	CreateObject(980, -1496.273926, 591.088013, 36.351517, 0.0000, 0.0000, 303.7500);
	CreateObject(981, -1656.780273, 556.200439, 38.507198, 0.0000, 0.0000, 315.0000);
	CreateObject(980, -1660.441406, 565.260132, 40.638290, 0.0000, 0.0000, 315.0000);
	CreateObject(980, -1652.595581, 557.425354, 40.650223, 0.0000, 0.0000, 315.0000);
	CreateObject(980, -1647.228394, 552.044800, 40.614704, 0.0000, 0.0000, 315.0000);
	CreateObject(980, -2677.122803, 1271.312744, 57.203079, 0.0000, 0.0000, 0.0000);
	CreateObject(980, -2669.048584, 1271.310547, 57.203079, 0.0000, 0.0000, 0.0000);
	CreateObject(980, -2687.007813, 1271.332275, 57.203079, 0.0000, 0.0000, 0.0000);
	CreateObject(980, -2693.890381, 1271.317017, 57.203079, 0.0000, 0.0000, 0.0000);
	CreateObject(981, -2677.423584, 1228.364136, 55.281170, 0.0000, 0.0000, 2.5010);
	CreateObject(981, -2795.200684, -490.083160, 7.138988, 0.0000, 0.0000, 146.2500);
	CreateObject(979, -2798.648682, -509.372253, 6.887996, 0.0000, 0.0000, 324.5312);
	CreateObject(979, -2805.369629, -504.588989, 6.888274, 0.0000, 0.0000, 324.5312);
	CreateObject(979, -2812.249023, -499.661041, 6.897798, 0.0000, 0.0000, 324.5312);
	CreateObject(980, -2810.557373, -501.385986, 8.763330, 0.0000, 0.0000, 146.2500);
	CreateObject(980, -2800.232910, -508.286926, 8.762455, 0.0000, 0.0000, 146.2500);

	AddPlayerClass(24, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(25, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(184, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(67, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(272, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(12, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(13, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(15, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(18, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(20, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(21, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(35, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(45, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(46, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(59, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(60, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(61, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(91, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(93, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(120, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(127, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(169, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(182, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(186, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(223, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(229, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(233, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(250, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(270, -1755.8191, 956.0815, 24.4898, 0, 0, 0, 0, 0, 0, 0);



	DrivingInfo = CreatePickup(1239, 23, -2033.7335, -96.6494, 35.1641);
	DrivingRec = CreatePickup(1239, 23, -2032.3115, -117.8799, 1035.1719);
	Bank1C = CreatePickup(1274, 23, Bank1Enter);
	Bank2C = CreatePickup(1274, 23, Bank2Enter);
	Bank3C = CreatePickup(1274, 23, Bank3Enter);
	SFPDC = CreatePickup(1272, 23, SFPD);
	SFPDInfo1 = CreatePickup(1239, 23, -1612.7908, 715.4841, 13.2943);
	SFPDInfo2 = CreatePickup(1239, 23, 246.5255, 118.2471, 1003.218);
	
	CluckingBell[0] = CreatePickup(1239, 23, CLUCKINGBELL1);
	CluckingBell[1] = CreatePickup(1239, 23, CLUCKINGBELL2);
	
	StackedPizza[0] = CreatePickup(1239, 23, STACKEDPIZZA1);
	
	BurgerShot[0] = CreatePickup(1239, 23, BURGERSHOT1);
	BurgerShot[1] = CreatePickup(1239, 23, BURGERSHOT2);
	BurgerShot[2] = CreatePickup(1239, 23, BURGERSHOT3);
	
	BarInfo[0] = CreatePickup(1239, 23, -2652.0273, 1409.3181, 906.2771);
	BarInfo[1] = CreatePickup(1239, 23, 677.9390, -452.7142, -25.6172);
	
	BarEnter[0] = CreatePickup(1272, 23, JIZZY);
	BarEnter[1] = CreatePickup(1272, 23, COCKTAIL);
	
	DrivingSchool[0] = CreatePickup(1272, 23, DRIVINGSCHOOL);
	
	#pragma unused Bank1C, Bank2C, Bank3C
	#pragma unused SFPDC
	
	DriverLicense = CreateMenu(" ", 1, 20, 120, 150, 40);
	SetMenuColumnHeader(DriverLicense, 0, "Take Test?");
	AddMenuItem(DriverLicense, 0, "Yes");
	AddMenuItem(DriverLicense, 0, "No");
	
	BankMainMenu = CreateMenu("Bank", 1, 20, 200, 200, 200);
	SetMenuColumnHeader(BankMainMenu, 0, "Decide:");
	AddMenuItem(BankMainMenu, 0, "Withdraw");
	AddMenuItem(BankMainMenu, 0, "Deposit");
	
	BankWithdraw = CreateMenu("Bank", 1, 20, 200, 200, 200);
	SetMenuColumnHeader(BankWithdraw, 0, "Withdraw");
	AddMenuItem(BankWithdraw, 0, "$1");
	AddMenuItem(BankWithdraw, 0, "$10");
	AddMenuItem(BankWithdraw, 0, "$100");
	AddMenuItem(BankWithdraw, 0, "$1000");
	AddMenuItem(BankWithdraw, 0, "$10000");
	AddMenuItem(BankWithdraw, 0, "$100000");
	AddMenuItem(BankWithdraw, 0, "Withdraw All");
	
	BankDeposit = CreateMenu("Bank", 1, 20, 200, 200, 200);
	SetMenuColumnHeader(BankDeposit, 0, "Deposit");
	AddMenuItem(BankDeposit, 0, "$1");
	AddMenuItem(BankDeposit, 0, "$10");
	AddMenuItem(BankDeposit, 0, "$100");
	AddMenuItem(BankDeposit, 0, "$1000");
	AddMenuItem(BankDeposit, 0, "$10000");
	AddMenuItem(BankDeposit, 0, "$100000");
	AddMenuItem(BankDeposit, 0, "Deposit All");
	
	PoliceDuty = CreateMenu("SFPD", 1, 20, 200, 200, 200);
	SetMenuColumnHeader(PoliceDuty, 0, "Duty Selection");
	AddMenuItem(PoliceDuty, 0, "On Duty");
	AddMenuItem(PoliceDuty, 0, "Off Duty");
	
	Boundaries = CreateMenu("ADMIN", 1, 20, 200, 200, 200);
	SetMenuColumnHeader(Boundaries, 0, "World Boundaries");
	AddMenuItem(Boundaries, 0, "ON");
	AddMenuItem(Boundaries, 0, "OFF");
	
	BarMenu = CreateMenu("BAR", 2, 20, 200, 200, 200);
	SetMenuColumnHeader(BarMenu, 0, "Item");
	SetMenuColumnHeader(BarMenu, 1, "Cost");
	AddMenuItem(BarMenu, 0, "Beer");
	AddMenuItem(BarMenu, 1, "$5");
	AddMenuItem(BarMenu, 0, "speCial Beer");
	AddMenuItem(BarMenu, 1, "$6");
	AddMenuItem(BarMenu, 0, "Whiskey");
	AddMenuItem(BarMenu, 1, "$12");
	AddMenuItem(BarMenu, 0, "Vodka");
	AddMenuItem(BarMenu, 1, "$14");
	AddMenuItem(BarMenu, 0, "Cooler");
	AddMenuItem(BarMenu, 1, "$10");
	
	CockBar = CreateMenu("BAR", 2, 20, 200, 200, 200);
	SetMenuColumnHeader(CockBar, 0, "Item");
	SetMenuColumnHeader(CockBar, 1, "Cost");
	AddMenuItem(CockBar, 0, "Bloody Mary");
	AddMenuItem(CockBar, 1, "$18");
	AddMenuItem(CockBar, 0, "First Ade");
	AddMenuItem(CockBar, 1, "$14");
	AddMenuItem(CockBar, 0, "Smirnoff Mix");
	AddMenuItem(CockBar, 1, "$15");
	AddMenuItem(CockBar, 0, "Cosmopolitan");
	AddMenuItem(CockBar, 1, "$20");
	AddMenuItem(CockBar, 0, "Vodka Martini");
	AddMenuItem(CockBar, 1, "$18");
	
	BurgerShotMenu = CreateMenu("Burger Shot", 2, 20, 200, 200, 200);
	SetMenuColumnHeader(BurgerShotMenu, 0, "Item");
	SetMenuColumnHeader(BurgerShotMenu, 1, "Cost");
	AddMenuItem(BurgerShotMenu, 0, "Cheese Burger");
	AddMenuItem(BurgerShotMenu, 1, "$3");
	AddMenuItem(BurgerShotMenu, 0, "Regular Burger");
	AddMenuItem(BurgerShotMenu, 1, "$3");
	AddMenuItem(BurgerShotMenu, 0, "Grill Burger");
	AddMenuItem(BurgerShotMenu, 1, "$5");
	AddMenuItem(BurgerShotMenu, 0, "Coca Cola");
	AddMenuItem(BurgerShotMenu, 1, "$4");
	AddMenuItem(BurgerShotMenu, 0, "Sprite");
	AddMenuItem(BurgerShotMenu, 1, "$4");
	
	StackedPizzaMenu = CreateMenu("Well Stacked Pizza", 2, 20, 200, 200, 200);
    SetMenuColumnHeader(StackedPizzaMenu, 0, "Item");
	SetMenuColumnHeader(StackedPizzaMenu, 1, "Cost");
	AddMenuItem(StackedPizzaMenu, 0, "Cheese Pizza");
	AddMenuItem(StackedPizzaMenu, 1, "$5");
	AddMenuItem(StackedPizzaMenu, 0, "Bolognese Pizza");
	AddMenuItem(StackedPizzaMenu, 1, "$6");
	AddMenuItem(StackedPizzaMenu, 0, "Hawaii Pizza");
	AddMenuItem(StackedPizzaMenu, 1, "$8");
	AddMenuItem(StackedPizzaMenu, 0, "Coca Cola");
	AddMenuItem(StackedPizzaMenu, 1, "$4");
	AddMenuItem(StackedPizzaMenu, 0, "Sprite");
	AddMenuItem(StackedPizzaMenu, 1, "$4");
	
	PaymentMethod = CreateMenu("Payment", 2, 20, 200, 200, 200);
	SetMenuColumnHeader(PaymentMethod, 1, "Choose method");
	AddMenuItem(PaymentMethod, 0, "Cash");
	AddMenuItem(PaymentMethod, 0, "Credit Card");
	
  	SetTimer("LoseFuel", 15000, true);
  	SetTimer("RealTime", 900000, true);
  	SetTimer("CheckEnter", 1000, true);
	SetTimer("CheckLoc", 1000, true);
	SetTimer("CheckPointTimer", 1000, true);
	return 1;
}

public CheckPointTimer()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   	if(GetPlayerInterior(i) == 5 && SeeCP[i] == 0)
		{
			SetPlayerCheckpoint(i, 374.7182, -119.1987, 1001.4995, 3.0);
			SeeCP[i] = 1;
		}
		else if(GetPlayerInterior(i) == 0 && gLicenseTest[i] == 0 && SeeCP[i] == 1)
		{
		    DisablePlayerCheckpoint(i);
		    SeeCP[i] = 0;
		}
	}
}

stock IsCopCar(carid)
{
	new M = GetVehicleModel(carid);
	if(M == 523 || M == 427 || M == 490 || M == 528 || M == 596 || M == 597 || M == 598 || M == 599)
	{
	    return 1;
	}
    return 0;
}

public CheckEnter()
{
	for(new playerid = 0; playerid < MAX_PLAYERS; playerid++)
	{
		// GATES
	    if(IsPlayerConnected(playerid) && gTeam[playerid] == TEAM_COP && PlayerToPoint(10.0, playerid, -1572.061890, 663.277161, 7.027720))
		{
			MoveObject(SFPDGATE1, -1572.061523, 670.830688, 7.027720, 2.0);
		}
		else
		{
		    MoveObject(SFPDGATE1, -1572.061890, 663.277161, 7.027720, 2.0);
		}
		if(IsPlayerConnected(playerid) && gTeam[playerid] == TEAM_COP && PlayerToPoint(10.0, playerid, -1701.419800, 684.441223, 24.696056))
		{
			MoveObject(SFPDGATE2, -1701.498047, 693.197876, 24.730844, 2.0);
		}
		else
		{
		    MoveObject(SFPDGATE2, -1701.419800, 684.441223, 24.696056, 2.0);
		}
		
	    // ENTERS
	    if(PlayerToPoint(3.0, playerid, Bank1Enter) || PlayerToPoint(3.0, playerid, Bank2Enter) || PlayerToPoint(3.0, playerid, Bank3Enter))
	    {
	        GameTextForPlayer(playerid, "~y~San Fierro Bank~n~~g~Owner: ~y~State~n~~n~~b~Use /enter to enter", 1000, 3);
		}
		
		if(PlayerToPoint(3.0, playerid, SFPD))
		{
		    GameTextForPlayer(playerid, "~y~San Fierro Police Department~n~~g~Owner: ~y~State~n~~n~~b~Use /enter to enter", 1000, 3);
		}
		
		if(PlayerToPoint(3.0, playerid, COCKTAIL))
		{
			GameTextForPlayer(playerid, "~y~Cocktail Bar~n~~n~~b~Use /enter to enter", 1000, 3);
		}
		
		if(PlayerToPoint(3.0, playerid, JIZZY))
		{
		    GameTextForPlayer(playerid, "~y~Jizzy ClubLounge & Bar~n~~n~~b~Use /enter to enter", 1000, 3);
		}
		
		if(PlayerToPoint(3.0, playerid, CLUCKINGBELL1) || PlayerToPoint(3.0, playerid, CLUCKINGBELL2))
		{
			GameTextForPlayer(playerid, "~y~Clucking Bell ~n~~n~~b~Use /enter to enter", 1000, 3);
		}

		if(PlayerToPoint(3.0, playerid, STACKEDPIZZA1))
		{
		    GameTextForPlayer(playerid, "~y~Well Stacked Pizza ~n~~n~~b~Use /enter to enter", 1000, 3);
		}
		
		if(PlayerToPoint(3.0, playerid, BURGERSHOT1) || PlayerToPoint(3.0, playerid, BURGERSHOT2) || PlayerToPoint(3.0, playerid, BURGERSHOT3))
		{
		    GameTextForPlayer(playerid, "~y~Burger Shot ~n~~n~~b~Use /enter to enter", 1000, 3);
		}
		
		if(PlayerToPoint(3.0, playerid, DRIVINGSCHOOL))
		{
		    GameTextForPlayer(playerid, "~y~Driving School ~n~~n~~b~Use /enter to enter", 1000, 3);
		}
		
		// EXITS
		// "CheckEnter" and "CheckExit" functions were implemented into one, because I used timers which caused lag.
		if(PlayerToPoint(1.5, playerid, BankExit))
	    {
	        GameTextForPlayer(playerid, "~p~Type \"~g~/exit~p~\" to exit", 1000, 3);
		}
		if(PlayerToPoint(2.0, playerid, SFPDExit))
		{
		    GameTextForPlayer(playerid, "~p~Type \"~g~/exit~p~\" to exit", 1000, 3);
		}
		if(PlayerToPoint(2.0, playerid, 372.5517,-132.9657,1001.4922) && GetPlayerInterior(playerid) == 5)
		{
			GameTextForPlayer(playerid, "~p~Type \"~g~/exit~p~\" to exit", 1000, 3);
		}
		if(PlayerToPoint(2.0, playerid, 363.5669,-74.7354,1001.5078) || PlayerToPoint(2.0, playerid, 365.7158, -9.8873, 1001.8516))
		{
		    GameTextForPlayer(playerid, "~p~Type \"~g~/exit~p~\" to exit", 1000, 3);
		}
		if(PlayerToPoint(2.0, playerid, -2028.1779,-105.1037,1035.1719))
		{
		    GameTextForPlayer(playerid, "~p~Type \"~g~/exit~p~\" to exit", 1000, 3);
		}
	}
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	new string[256];
	GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
	if(pickupid == DrivingRec)
	{
	    ShowMenuForPlayer(DriverLicense, playerid);
	    TogglePlayerControllable(playerid, 0);
	}
	if(pickupid == DrivingInfo)
	{
		if(gLicenseTest[playerid] == 1)
		{
		    SendClientMessage(playerid, COLOR_CYELLOW, "* SF Driving School");
	    	SendClientMessage(playerid, COLOR_GREY, "Seems that you already are taking a license test, take a vehicle and drive to the point marked on map!");
	    	format(string, sizeof(string), "SFDrivingSchool: Player %s(%i) entered: Already taking a license test!", PlayerName, playerid);
			aLog("Pickups.txt", string);
		}
		else
		{
		    if(PlayerInfo[playerid][pLicense] == 0)
		    {
		    	SendClientMessage(playerid, COLOR_CYELLOW, "* SF Driving School");
		    	SendClientMessage(playerid, COLOR_GREY, "Seems that you don't have a license. Head inside to apply for one!");
		    	format(string, sizeof(string), "SFDrivingSchool: Player %s(%i) entered: Don't have license", PlayerName, playerid);
				aLog("Pickups.txt", string);
			}
			else
			{
			    SendClientMessage(playerid, COLOR_CYELLOW, "* SF Driving School");
		    	SendClientMessage(playerid, COLOR_GREY, "Seems that you already have a license, You got better things to do!");
		    	format(string, sizeof(string), "SFDrivingSchool: Player %s(%i) entered: You have a license", PlayerName, playerid);
				aLog("Pickups.txt", string);
			}
		}
	}
	if(pickupid == SFPDInfo1)
	{
	    if(gTeam[playerid] == TEAM_CIVILIAN)
	    {
	        SendClientMessage(playerid, COLOR_CYELLOW, "* SFPD");
			SendClientMessage(playerid, COLOR_GREY, "Welcome to San Fierro Police Department, the HQ of police in San Fierro");
			SendClientMessage(playerid, COLOR_GREY, "This is the place where all criminals get their punishment and are kept in.");
			SendClientMessage(playerid, COLOR_GREY, "If you're interested in becoming a police officer, head inside to go on duty.");
		}
		if(gTeam[playerid] == TEAM_COP)
		{
		    SendClientMessage(playerid, COLOR_CYELLOW, "* SFPD");
		    SendClientMessage(playerid, COLOR_GREY, "You're still on duty, officer! So what are you waiting for? Go and bust criminals!");
		    SendClientMessage(playerid, COLOR_GREY, "Oh, you want to go off-duty? No problem, head inside. Hope that you did some good work today.");
		}
		if(gTeam[playerid] == TEAM_CRIMINAL)
		{
		    SendClientMessage(playerid, COLOR_CYELLOW, "* SFPD");
		    SendClientMessage(playerid, COLOR_GREY, "Hmm, as a criminal you shall keep long distance from SFPD, what are you doing here?");
		    SendClientMessage(playerid, COLOR_GREY, "Waiting for a officer to come and bust ya' ass? That's not a soul of true criminal.");
		}
	}
	if(pickupid == SFPDInfo2)
	{
	    if(gTeam[playerid] == TEAM_CIVILIAN)
	    {
	        SendClientMessage(playerid, COLOR_CYELLOW, "* SFPD");
	        SendClientMessage(playerid, COLOR_GREY, "You shouldn't approach any other rooms as a civilian. Though you can, by going on duty.");
	        SendClientMessage(playerid, COLOR_GREY, "Perfect chance - Want to protect the law? Get on duty!");
		}
		if(gTeam[playerid] == TEAM_COP)
		{
		    SendClientMessage(playerid, COLOR_CYELLOW, "* SFPD");
		    SendClientMessage(playerid, COLOR_GREY, "What you're waiting for, officer? Get out there to kick criminals asses!");
		    SendClientMessage(playerid, COLOR_GREY, "Bring 'em in and /jail [id] [time] them.");
		}
		if(gTeam[playerid] == TEAM_CRIMINAL)
		{
		    SendClientMessage(playerid, COLOR_CYELLOW, "* SFPD");
		    SendClientMessage(playerid, COLOR_GREY, "Jeez, what are you doing in SFPD as a criminal? I wouldn't recommend such thing...");
		}
	}
	if(pickupid == BarInfo[0] || pickupid == BarInfo[1])
	{
		InfoTextDraw(playerid, "~w~TIP: ~p~Write /buy to open menu!", 3000);
	}
}

public OnPlayerEnterCheckpoint(playerid)
{
	new string[128];
	new file[128];
	GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
	format(file, sizeof(file), "/VirtualScriptingRP/Accounts/%s.ini", PlayerName);
	if(PlayerToPoint(10.0, playerid, -1885.5433, 832.5999, 35.1641) && gLicenseTest[playerid] == 1)
	{
	    DisablePlayerCheckpoint(playerid);
	    SetPlayerCheckpoint(playerid, -2033.7335, -96.6494, 35.1641, 10.0);
	    new LEFT = 120 - gLicenseCount[playerid];
		format(string, sizeof(string), "Driver Assistant: You're 50% done with %d seconds, what leaves you more %d seconds to drive back!", gLicenseCount[playerid], LEFT);
		SendClientMessage(playerid, COLOR_CRED, string);
		format(string, sizeof(string), "Player %s(%i) entered driving test checkpoint, 50% done with %d seconds.", PlayerName, playerid, gLicenseCount[playerid]);
		aLog("Checkpoints.txt", string);
	}
	if(PlayerToPoint(10.0, playerid, -2033.7335, -96.6494, 35.1641) && gLicenseTest[playerid] == 1)
	{
		DisablePlayerCheckpoint(playerid);
		SendClientMessage(playerid, COLOR_YELLOW, "Driving School: You have received your license, good job!");
		KillTimer(DriveCountT);
		DrivingPasses += 1;
		dini_IntSet("/VirtualScriptingRP/Stats/drivingschool.cfg", "Passes", DrivingPasses);
		format(string, sizeof(string), "Driving School: There are total %d people who have passed the test, %d who haven't.", DrivingPasses, DrivingFails);
		SendClientMessage(playerid, COLOR_CYELLOW, string);
		gLicenseTest[playerid] = 0;
		PlayerInfo[playerid][pLicense] = 1;
		dini_IntSet(file, "License", PlayerInfo[playerid][pLicense]);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    if(IsPlayerConnected(i) && i != playerid)
		    {
		        format(string, sizeof(string), "NEWS: %s(%i) has received a license", PlayerName, playerid);
		        SendClientMessage(i, COLOR_BGREEN, string);
			}
		}
		format(string, sizeof(string), "Player %s(%i) entered driving school checkpoint, got license", PlayerName, playerid);
		aLog("CheckPoint.txt", string);
	}
	if(GetPlayerInterior(playerid) == 17)
	{
	    ShowMenuForPlayer(BankMainMenu, playerid);
	    TogglePlayerControllable(playerid, 0);
	    format(string, sizeof(string), "Player %s(%i) entered Bank main menu", PlayerName, playerid);
		aLog("CheckPoint.txt", string);
	}
	if(GetPlayerInterior(playerid) == 10)
	{
	    ShowMenuForPlayer(PoliceDuty, playerid);
	    TogglePlayerControllable(playerid, 0);
	    format(string, sizeof(string), "Player %s(%i) entered SFPD menu", PlayerName, playerid);
		aLog("CheckPoint.txt", string);
	}
	if(GetPlayerInterior(playerid) == 5)
	{
	    ShowMenuForPlayer(StackedPizzaMenu, playerid);
	    TogglePlayerControllable(playerid, 0);
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	KillTimer(ZoneTimer);
	TextDrawHideForPlayer(playerid, ZoneText[playerid]);
	TextDrawDestroy(ZoneText[playerid]);
	new KillerName[24], string[128];
	GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
	GetPlayerName(killerid, KillerName, sizeof(KillerName));
	StoreReason(reason);
	format(string, sizeof(string), "Player %s(%i) killed %s(%i)", KillerName, killerid, PlayerName, playerid);
	aLog("Kills.txt", string);
	if(gTeam[playerid] == TEAM_CRIMINAL && gTeam[killerid] == TEAM_COP)
	{
		format(string, sizeof(string), "* You were busted by officer %s and fined for $1000", KillerName);
		SendClientMessage(playerid, COLOR_CRED, string);
		GivePlayerMoney(playerid, -1000);
		format(string, sizeof(string), "NEWS: Officer %s busted(kill) Criminal %s", KillerName, PlayerName);
  		SendClientMessageToAll(COLOR_WHITE, string);
		CrimSpawn[playerid] = 1;
	}
	if(gTeam[killerid] == TEAM_CRIMINAL)
	{
	    if(gTeam[playerid] == TEAM_COP)
	    {
	        format(string, sizeof(string), "* You killed officer %s.", PlayerName);
	        SendClientMessage(killerid, COLOR_CRED, string);
	        format(string, sizeof(string), "NEWS: Criminal %s killed officer %s", KillerName, PlayerName);
	        SendClientMessageToAll(COLOR_WHITE, string);
			gTeam[killerid] = TEAM_CRIMINAL;
			SetPlayerColor(killerid, COLOR_ORANGE);
		}
		if(gTeam[playerid] == TEAM_CIVILIAN)
		{
		    format(string, sizeof(string), "* You killed civilian %s.", PlayerName);
	        SendClientMessage(killerid, COLOR_CRED, string);
	        format(string, sizeof(string), "NEWS: Criminal %s killed civilian %s", KillerName, PlayerName);
	        SendClientMessageToAll(COLOR_WHITE, string);
			gTeam[killerid] = TEAM_CRIMINAL;
			SetPlayerColor(killerid, COLOR_ORANGE);
		}
	}
	if(gTeam[killerid] == TEAM_CIVILIAN)
	{
	    if(gTeam[playerid] == TEAM_COP)
	    {
	        format(string, sizeof(string), "NEWS: Civilian %s killed officer %s", KillerName, PlayerName);
	        SendClientMessageToAll(COLOR_WHITE, string);
			gTeam[killerid] = TEAM_CRIMINAL;
			SetPlayerColor(killerid, COLOR_ORANGE);
			SetPlayerCriminal(killerid, "First Degree Murder");
			// Make dead cop spawn @ hospital
		}
		if(gTeam[playerid] == TEAM_CIVILIAN)
		{
		    format(string, sizeof(string), "NEWS: Civilian %s killed Civilian %s", KillerName, PlayerName);
	        SendClientMessageToAll(COLOR_WHITE, string);
			gTeam[killerid] = TEAM_CRIMINAL;
			SetPlayerColor(killerid, COLOR_ORANGE);
			SetPlayerCriminal(killerid, "First Degree Murder");
		}
	}
	if(gTeam[playerid] == TEAM_CIVILIAN && gTeam[killerid] == TEAM_COP)
	{
	    format(string, sizeof(string), "* You killed a innocent civilian %s. You're fined for $1000", PlayerName);
	    SendClientMessage(killerid, COLOR_CRED, string);
	    GivePlayerMoney(killerid, -1000);
	    format(string, sizeof(string), "NEWS: Officer %s killed a innocent civilian %s", KillerName, PlayerName);
     	SendClientMessageToAll(COLOR_WHITE, string);
	}
	if(reason == 38 && PlayerInfo[playerid][pAdmin] == 0)
	{
	    format(string, sizeof(string), "aCheat: %s(%i) has been caught cheating (WeaponCheat) (minigun)", KillerName, killerid);
	    SendClientMessageToAll(COLOR_CRED, string);
		SendClientMessage(killerid, COLOR_RED, "YOU WERE AUTOMATICALLY BANNED FOR WEAPON HACKING.");
		Ban(killerid);
	}
	if(reason == 35 || reason == 36 && PlayerInfo[playerid][pAdmin] == 0)
	{
	    format(string, sizeof(string), "aCheat: %s(%i) has been caught cheating (WeaponCheat) (Rocket Launcher)", KillerName, killerid);
	    SendClientMessageToAll(COLOR_CRED, string);
	    SendClientMessage(killerid, COLOR_RED, "YOU WERE AUTOMATICALLY BANNED FOR WEAPON HACKING.");
	    Ban(killerid);
	}
	return 1;
}

public CheckWeaponHack(playerid)
{
	new string[128];
	GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
	if(GetPlayerWeapon(playerid) == 38 && PlayerInfo[playerid][pAdmin] == 0)
	{
	    format(string, sizeof(string), "aCheat: %s(%i) has been caught cheating (WeaponCheat) (minigun)", PlayerName, playerid);
	    SendClientMessageToAll(COLOR_CRED, string);
		SendClientMessage(playerid, COLOR_RED, "YOU WERE AUTOMATICALLY BANNED FOR WEAPON HACKING.");
		InfoTextDraw(playerid, "~r~Banned for WEAPON HACKING.", 5000);
		BanEx(playerid, "Weapon Hack Detected");
	}
	if(GetPlayerWeapon(playerid) == 35 || GetPlayerWeapon(playerid) == 36 && PlayerInfo[playerid][pAdmin] == 0)
	{
	    format(string, sizeof(string), "aCheat: %s(%i) has been caught cheating (WeaponCheat) (Rocket Launcher)", PlayerName, playerid);
	    SendClientMessageToAll(COLOR_CRED, string);
	    SendClientMessage(playerid, COLOR_RED, "YOU WERE AUTOMATICALLY BANNED FOR WEAPON HACKING.");
	    InfoTextDraw(playerid, "~r~Banned for WEAPON HACKING.", 5000);
	    BanEx(playerid, "Weapon Hack Detected");
	}
}

public StoreReason(reason)
{
    new file[128];
	format(file, sizeof(file), "/VirtualScriptingRP/Stats/deaths.cfg");
	if(reason == 0) KnuckleKills += 1;
	if(reason == 1) BrassKnuckleKills += 1;
	if(reason == 2) GolfClubKills += 1;
	if(reason == 3) NiteStickKills += 1;
	if(reason == 4) KnifeKills += 1;
	if(reason == 5) BatKills += 1;
	if(reason == 6) ShovelKills += 1;
	if(reason == 7) PoolCueKills += 1;
	if(reason == 8) KatanaKills += 1;
	if(reason == 9) ChainsawKills += 1;
	if(reason == 14) FlowerKills += 1;
	if(reason == 15) CaneKills += 1;
	if(reason == 16) GrenadeKills += 1;
	if(reason == 17) TearGasKills += 1;
	if(reason == 18) MolotovKills += 1;
	if(reason == 22) ninemmKills += 1;
	if(reason == 23) S9mmKills += 1;
	if(reason == 24) DeagleKills += 1;
	if(reason == 25) ShotgunKills += 1;
	if(reason == 26) SawnoffKills += 1;
	if(reason == 27) CombatShotgunKills += 1;
	if(reason == 28) MicroSMGKills += 1;
	if(reason == 29) MP5Kills += 1;
	if(reason == 30) AkKills += 1;
	if(reason == 31) M4Kills += 1;
	if(reason == 32) Tec9Kills += 1;
	if(reason == 33) CountryRifleKills += 1;
	if(reason == 34) SniperKills += 1;
	if(reason == 35) RocketLauncherKills += 1;
	if(reason == 36) HeatSeekingRocketLauncherKills += 1;
	if(reason == 37) FlameThrowerKills += 1;
	if(reason == 38) MinigunKills += 1;
	if(reason == 41) SprayKills += 1;
	if(reason == 42) FireExtKills += 1;
	if(reason == 43) CameraKills += 1;
	if(reason == 49) VehicleKills += 1;
	if(reason == 50) RotorKills += 1;
	if(reason == 51) ExplosionKills += 1;
	if(reason == 53) DrownKills += 1;
	
	dini_IntSet(file, "Knuckle", KnuckleKills);
	dini_IntSet(file, "Brass Knuckle", BrassKnuckleKills);
	dini_IntSet(file, "Golf Club", GolfClubKills);
	dini_IntSet(file, "Nite Stick", NiteStickKills);
	dini_IntSet(file, "Knife", KnifeKills);
	dini_IntSet(file, "Bat", BatKills);
	dini_IntSet(file, "Shovel", ShovelKills);
	dini_IntSet(file, "Pool Cue", PoolCueKills);
	dini_IntSet(file, "Katana", KatanaKills);
	dini_IntSet(file, "Chainsaw", ChainsawKills);
	dini_IntSet(file, "Flowers", FlowerKills);
	dini_IntSet(file, "Cane", CaneKills);
	dini_IntSet(file, "Grenade", GrenadeKills);
	dini_IntSet(file, "Tear Gas", TearGasKills);
	dini_IntSet(file, "Molotov", MolotovKills);
	dini_IntSet(file, "9MM", ninemmKills);
	dini_IntSet(file, "Silenced 9MM", S9mmKills);
	dini_IntSet(file, "Desert Eagle", DeagleKills);
	dini_IntSet(file, "Shotgun", ShotgunKills);
	dini_IntSet(file, "Sawnoff Shotgun", SawnoffKills);
	dini_IntSet(file, "Combat Shotgun", CombatShotgunKills);
	dini_IntSet(file, "Micro SMG", MicroSMGKills);
	dini_IntSet(file, "MP5 Kills", MP5Kills);
	dini_IntSet(file, "Ak47", AkKills);
	dini_IntSet(file, "M4", M4Kills);
	dini_IntSet(file, "Tec9", Tec9Kills);
	dini_IntSet(file, "Country Rifle", CountryRifleKills);
	dini_IntSet(file, "Sniper", SniperKills);
	dini_IntSet(file, "Rocket Launcher", RocketLauncherKills);
	dini_IntSet(file, "HS Rocket Launcher", HeatSeekingRocketLauncherKills);
	dini_IntSet(file, "FlameThrower", FlameThrowerKills);
	dini_IntSet(file, "Minigun", MinigunKills);
	dini_IntSet(file, "Spray Can", SprayKills);
	dini_IntSet(file, "Fire Ext", FireExtKills);
	dini_IntSet(file, "Camera", CameraKills);
	dini_IntSet(file, "Vehicle", VehicleKills);
	dini_IntSet(file, "Rotors", RotorKills);
	dini_IntSet(file, "Explosion", ExplosionKills);
	dini_IntSet(file, "Drowning", DrownKills);
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	new Menu:Current = GetPlayerMenu(playerid);
	new Float:x, Float:y, Float:z, Float:a;
	GetPlayerFacingAngle(playerid,a);
	GetPlayerPos(playerid, x, y, z);
	new sendername[24];
	new string[256];
	new file[128];
	format(file, sizeof(file), "/VirtualScriptingRP/Accounts/%s.ini", sendername);
	
	if(Current == BarMenu)
	{
	    switch(row)
	    {
	        case 0:
	        {
				if(GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, COLOR_GREY, "BarTender: Not enough money, pal!");
				aGivePlayerHealth(playerid, 15);
				SendClientMessage(playerid, COLOR_PINK, "BarTender: Enjoy your beer!");
				InfoTextDraw(playerid, "You've bought ~b~beer~w~!", 5000);
				GivePlayerMoney(playerid, -5);
			}
			case 1:
			{
			    if(GetPlayerMoney(playerid) < 6) return SendClientMessage(playerid, COLOR_GREY, "BarTender: Not enough money, pal!");
			    aGivePlayerHealth(playerid, 18);
				SendClientMessage(playerid, COLOR_PINK, "BarTender: Enjoy your speCial beer!");
				InfoTextDraw(playerid, "You've bought ~b~Special beer~w~!", 5000);
				GivePlayerMoney(playerid, -6);
			}
			case 2:
			{
			    if(GetPlayerMoney(playerid) < 12) return SendClientMessage(playerid, COLOR_GREY, "BarTender: Not enough money, pal!");
			    aGivePlayerHealth(playerid, 20);
				SendClientMessage(playerid, COLOR_PINK, "BarTender: Enjoy your whiskey!");
				InfoTextDraw(playerid, "You've bought ~b~Whiskey~w~!", 5000);
				GivePlayerMoney(playerid, -12);
			}
			case 3:
			{
			    if(GetPlayerMoney(playerid) < 14) return SendClientMessage(playerid, COLOR_GREY, "BarTender: Not enough money, pal!");
			    aGivePlayerHealth(playerid, 25);
				SendClientMessage(playerid, COLOR_PINK, "BarTender: Enjoy your Vodka!");
				InfoTextDraw(playerid, "You've bought ~b~Vodka~w~!", 5000);
				GivePlayerMoney(playerid, -14);
			}
			case 4:
			{
			    if(GetPlayerMoney(playerid) < 10) return SendClientMessage(playerid, COLOR_GREY, "BarTender: Not enough money, pal!");
			    aGivePlayerHealth(playerid, 27);
				SendClientMessage(playerid, COLOR_PINK, "BarTender: Enjoy your Cooler!");
				InfoTextDraw(playerid, "You've bought ~b~Cooler~w~!", 5000);
				GivePlayerMoney(playerid, -10);
			}
		}
	}
	
	else if(Current == CockBar)
	{
		switch(row)
		{
		    case 0:
		    {
		        if(GetPlayerMoney(playerid) < 18) return SendClientMessage(playerid, COLOR_GREY, "BarTender: Not enough money, pal!");
		        aGivePlayerHealth(playerid, 27);
				SendClientMessage(playerid, COLOR_PINK, "BarTender: Enjoy your Bloody Mary!");
				InfoTextDraw(playerid, "You've bought ~b~Bloody Mary~w~!", 5000);
				GivePlayerMoney(playerid, -18);
			}
			case 1:
			{
			    if(GetPlayerMoney(playerid) < 14) return SendClientMessage(playerid, COLOR_GREY, "BarTender: Not enough money, pal!");
			    aGivePlayerHealth(playerid, 27);
				SendClientMessage(playerid, COLOR_PINK, "BarTender: Enjoy your First Ade!");
				InfoTextDraw(playerid, "You've bought ~b~First Ade~w~!", 5000);
				GivePlayerMoney(playerid, -14);
			}
			case 2:
			{
			    if(GetPlayerMoney(playerid) < 15) return SendClientMessage(playerid, COLOR_GREY, "BarTender: Not enough money, pal!");
			    aGivePlayerHealth(playerid, 27);
				SendClientMessage(playerid, COLOR_PINK, "BarTender: Enjoy your Smirnoff Mix!");
				InfoTextDraw(playerid, "You've bought ~b~Smirnoff Mix~w~!", 5000);
				GivePlayerMoney(playerid, -15);
			}
			case 3:
			{
			    if(GetPlayerMoney(playerid) < 20) return SendClientMessage(playerid, COLOR_GREY, "BarTender: Not enough money, pal!");
			    aGivePlayerHealth(playerid, 27);
				SendClientMessage(playerid, COLOR_PINK, "BarTender: Enjoy your Cosmopolitan!");
				InfoTextDraw(playerid, "You've bought ~b~Cosmopolitan~w~!", 5000);
				GivePlayerMoney(playerid, -20);
			}
			case 4:
			{
			    if(GetPlayerMoney(playerid) < 18) return SendClientMessage(playerid, COLOR_GREY, "BarTender: Not enough money, pal!");
			    aGivePlayerHealth(playerid, 27);
				SendClientMessage(playerid, COLOR_PINK, "BarTender: Enjoy your Vodka Martini!");
				InfoTextDraw(playerid, "You've bought ~b~Vodka Martini~w~!", 5000);
				GivePlayerMoney(playerid, -18);
			}
		}
	}
	
	else if(Current == PoliceDuty)
	{
	    switch(row)
	    {
	        case 0:
	        {
	            if(gTeam[playerid] == TEAM_CRIMINAL) return SendClientMessage(playerid, COLOR_RED, "SFPD: You're wanted, so you can't take actions here.");
	            if(PlayerInfo[playerid][pCop] == 0)
	            {
					SetOnDuty(playerid);
					format(string, sizeof(string), "%s(%i) got on duty", sendername, playerid);
					aLog("PoliceDuty.txt", string);
				}
				else
				{
				    SendClientMessage(playerid, COLOR_DBLUE, "You already are on duty!");
				    format(string, sizeof(string), "%s(%i) tried to go on duty, while on duty", sendername, playerid);
					aLog("PoliceDuty.txt", string);
				}
			}
			case 1:
			{
			    if(gTeam[playerid] == TEAM_CRIMINAL) return SendClientMessage(playerid, COLOR_RED, "SFPD: You're wanted, so you can't take actions here.");
			    if(gTeam[playerid] == TEAM_COP)
			    {
			        SetOffDuty(playerid);
			        format(string, sizeof(string), "%s(%i) went off duty", sendername, playerid);
					aLog("PoliceDuty.txt", string);
				}
				else
				{
				    SendClientMessage(playerid, COLOR_DBLUE, "SFPD: You aren't on duty!");
				    format(string, sizeof(string), "%s(%i) tried to go off guty, while not on duty!", sendername, playerid);
					aLog("PoliceDuty.txt", string);
				}
			}
		}
		TogglePlayerControllable(playerid, true);
	}
	
	else if(Current == BankMainMenu)
	{
		switch(row)
		{
			case 0:
			{
			    ShowMenuForPlayer(BankWithdraw, playerid);
			    format(string, sizeof(string), "%s(%i) opened withdrawing menu", sendername, playerid);
			    aLog("BankMenu.txt", string);
			}
			case 1:
			{
			    ShowMenuForPlayer(BankDeposit, playerid);
			    format(string, sizeof(string), "%s(%i) opened depositing menu", sendername, playerid);
			    aLog("BankMenu.txt", string);
			}
		}
	}
	
	else if(Current == BankWithdraw)
	{
	    TogglePlayerControllable(playerid, true);
		switch(row)
		{
		    case 0:
		    {
		        if(PlayerInfo[playerid][pBankCash] >= 1)
		        {

		            GivePlayerMoney(playerid, 1);
		            PlayerInfo[playerid][pBankCash] -= 1;
					format(string, sizeof(string), "You withdrawed $1, You have $%d left on your bank account.", PlayerInfo[playerid][pBankCash]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					format(string, sizeof(string), "%s(%i) withdrawed $1", sendername, playerid);
			    	aLog("BankMenu.txt", string);
				}
				else
				{
				    SendClientMessage(playerid, COLOR_WHITE, "You don't have $1 on your account!");
				}
				ShowMenuForPlayer(BankWithdraw, playerid);
			}
			case 1:
			{
			    if(PlayerInfo[playerid][pBankCash] >= 10)
		        {
		            GivePlayerMoney(playerid, 10);
		            PlayerInfo[playerid][pBankCash] -= 10;
		            format(string, sizeof(string), "You withdrawed $10, You have $%d left on your bank account.", PlayerInfo[playerid][pBankCash]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					format(string, sizeof(string), "%s(%i) withdrawed $10", sendername, playerid);
			    	aLog("BankMenu.txt", string);
				}
				else
				{
				    SendClientMessage(playerid, COLOR_WHITE, "You don't have $10 on your account!");
				}
				ShowMenuForPlayer(BankWithdraw, playerid);
			}
			case 2:
			{
			    if(PlayerInfo[playerid][pBankCash] >= 100)
		        {
		            GivePlayerMoney(playerid, 100);
		            PlayerInfo[playerid][pBankCash] -= 100;
		            format(string, sizeof(string), "You withdrawed $100, You have $%d left on your bank account.", PlayerInfo[playerid][pBankCash]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					format(string, sizeof(string), "%s(%i) withdrawed $100", sendername, playerid);
			    	aLog("BankMenu.txt", string);
				}
				else
				{
				    SendClientMessage(playerid, COLOR_WHITE, "You don't have $100 on your account!");
				}
				ShowMenuForPlayer(BankWithdraw, playerid);
			}
			case 3:
			{
			    if(PlayerInfo[playerid][pBankCash] >= 1000)
		        {
		            GivePlayerMoney(playerid, 1000);
		            PlayerInfo[playerid][pBankCash] -= 1000;
		            format(string, sizeof(string), "You withdrawed $1000, You have $%d left on your bank account.", PlayerInfo[playerid][pBankCash]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					format(string, sizeof(string), "%s(%i) withdrawed $1000", sendername, playerid);
			    	aLog("BankMenu.txt", string);
				}
				else
				{
				    SendClientMessage(playerid, COLOR_WHITE, "You don't have $1000 on your account!");
				}
				ShowMenuForPlayer(BankWithdraw, playerid);
			}
			case 4:
			{
			    if(PlayerInfo[playerid][pBankCash] >= 10000)
		        {
		            GivePlayerMoney(playerid, 10000);
		            PlayerInfo[playerid][pBankCash] -= 10000;
		            format(string, sizeof(string), "You withdrawed $10000, You have $%d left on your bank account.", PlayerInfo[playerid][pBankCash]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					format(string, sizeof(string), "%s(%i) withdrawed $10000", sendername, playerid);
			    	aLog("BankMenu.txt", string);
				}
				else
				{
				    SendClientMessage(playerid, COLOR_WHITE, "You don't have $10000 on your account!");
				}
				ShowMenuForPlayer(BankWithdraw, playerid);
			}
			case 5:
			{
			    if(PlayerInfo[playerid][pBankCash] >= 100000)
		        {
		            GivePlayerMoney(playerid, 100000);
		            PlayerInfo[playerid][pBankCash] -= 100000;
		            format(string, sizeof(string), "You withdrawed $100000, You have $%d left on your bank account.", PlayerInfo[playerid][pBankCash]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					format(string, sizeof(string), "%s(%i) withdrawed $100000", sendername, playerid);
			    	aLog("BankMenu.txt", string);
				}
				else
				{
				    SendClientMessage(playerid, COLOR_WHITE, "You don't have $100000 on your account!");
				}
				ShowMenuForPlayer(BankWithdraw, playerid);
			}
			case 6:
			{
			    new OldCash = PlayerInfo[playerid][pBankCash];
			    GivePlayerMoney(playerid, PlayerInfo[playerid][pBankCash]);
				PlayerInfo[playerid][pBankCash] = 0;
				format(string, sizeof(string), "You withdrawed %d, You have nothing left on your account.", OldCash);
				SendClientMessage(playerid, COLOR_WHITE, string);
				format(string, sizeof(string), "%s(%i) withdrawed $%d", sendername, playerid, OldCash);
			    aLog("BankMenu.txt", string);
			}
		}
		dini_IntSet(file, "BankCash", PlayerInfo[playerid][pBankCash]);
	}
	
	else if(Current == BankDeposit)
	{
	    TogglePlayerControllable(playerid, true);
		switch(row)
		{
		    case 0:
		    {
		        if(GetPlayerMoney(playerid) >= 1)
		        {

		            GivePlayerMoney(playerid, -1);
		            PlayerInfo[playerid][pBankCash] += 1;
		            format(string, sizeof(string), "You deposited $1, You have $%d on your bank account.", PlayerInfo[playerid][pBankCash]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					format(string, sizeof(string), "%s(%i) deposited $1", sendername, playerid);
			    	aLog("BankMenu.txt", string);
				}
				else
				{
				    SendClientMessage(playerid, COLOR_WHITE, "You don't have $1 in hand!");
				}
			}
			case 1:
			{
			    if(GetPlayerMoney(playerid) >= 10)
		        {
		            
		            GivePlayerMoney(playerid, -10);
		            PlayerInfo[playerid][pBankCash] += 10;
		            format(string, sizeof(string), "You deposited $10, You have $%d on your bank account.", PlayerInfo[playerid][pBankCash]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					format(string, sizeof(string), "%s(%i) deposited $10", sendername, playerid);
			    	aLog("BankMenu.txt", string);
				}
				else
				{
				    SendClientMessage(playerid, COLOR_WHITE, "You don't have $10 in hand!");
				}
			}
			case 2:
			{
			    if(GetPlayerMoney(playerid) >= 100)
		        {
		            GivePlayerMoney(playerid, -100);
		            PlayerInfo[playerid][pBankCash] += 100;
		            format(string, sizeof(string), "You deposited $100, You have $%d on your bank account.", PlayerInfo[playerid][pBankCash]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					format(string, sizeof(string), "%s(%i) deposited $100", sendername, playerid);
			    	aLog("BankMenu.txt", string);
				}
				else
				{
				    SendClientMessage(playerid, COLOR_WHITE, "You don't have $100 in hand!");
				}
			}
			case 3:
			{
			    if(GetPlayerMoney(playerid) >= 1000)
		        {
		            GivePlayerMoney(playerid, -1000);
		            PlayerInfo[playerid][pBankCash] += 1000;
		            format(string, sizeof(string), "You deposited $1000, You have $%d on your bank account.", PlayerInfo[playerid][pBankCash]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					format(string, sizeof(string), "%s(%i) deposited $1000", sendername, playerid);
			    	aLog("BankMenu.txt", string);
				}
				else
				{
				    SendClientMessage(playerid, COLOR_WHITE, "You don't have $1000 in hand!");
				}
			}
			case 4:
			{
			    if(GetPlayerMoney(playerid) >= 10000)
		        {
		            GivePlayerMoney(playerid, -10000);
		            PlayerInfo[playerid][pBankCash] += 10000;
		            format(string, sizeof(string), "You deposited $10000, You have $%d on your bank account.", PlayerInfo[playerid][pBankCash]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					format(string, sizeof(string), "%s(%i) deposited $10000", sendername, playerid);
			    	aLog("BankMenu.txt", string);
				}
				else
				{
				    SendClientMessage(playerid, COLOR_WHITE, "You don't have $10000 in hand!");
				}
			}
			case 5:
			{
			    if(GetPlayerMoney(playerid) >= 100000)
		        {
		            GivePlayerMoney(playerid, -100000);
		            PlayerInfo[playerid][pBankCash] += 100000;
		            format(string, sizeof(string), "You deposited $100000, You have $%d on your bank account.", PlayerInfo[playerid][pBankCash]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					format(string, sizeof(string), "%s(%i) deposited $100000", sendername, playerid);
			    	aLog("BankMenu.txt", string);
				}
				else
				{
				    SendClientMessage(playerid, COLOR_WHITE, "You don't have $100000 in hand!");
				}
			}
			case 6:
			{
			    new OldCash = GetPlayerMoney(playerid);
				PlayerInfo[playerid][pBankCash] += GetPlayerMoney(playerid);
				ResetPlayerMoney(playerid);
				format(string, sizeof(string), "You deposited %d, You have $%d on your bank account.", OldCash, PlayerInfo[playerid][pBankCash]);
				SendClientMessage(playerid, COLOR_WHITE, string);
				format(string, sizeof(string), "%s(%i) deposited $%d", sendername, playerid, OldCash);
   				aLog("BankMenu.txt", string);
			}
		}
		dini_IntSet(file, "BankCash", PlayerInfo[playerid][pBankCash]);
	}
	
	else if(Current == DriverLicense)
	{
	    switch(row)
	    {
	        case 0:
	        {
	           	GetPlayerName(playerid, sendername, sizeof(sendername));
				format(file, sizeof(file), "/VirtualScriptingRP/Accounts/%s.ini", sendername);
				PlayerInfo[playerid][pLicense] = dini_Int(file, "License");
				if(PlayerInfo[playerid][pLicense] == 0)
				{
		            SendClientMessage(playerid, COLOR_GREY, "Driving School: Ready-To-Go, get a vehicle and go to the red spot marked on map");
		            gLicenseTest[playerid] = 1;
		            gLicenseCount[playerid] = 0;
		            DisablePlayerCheckpoint(playerid);
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "Driving School: Seems that you already have a license on our database.");
				}
			}
			case 1:
			{
			    SendClientMessage(playerid, COLOR_GREY, "Driving School: You can come back, anytime.");
			}
		}
		TogglePlayerControllable(playerid, 1);
	}
	
	else if(Current == Boundaries)
	{
		switch(row)
		{
		    case 0:
		    {
		        SetPlayerWorldBounds(playerid, -1015.975, -3001.214, 1658.258, -1366.311);
			}
			case 1:
			{
			    SetPlayerWorldBounds(playerid, 2977.858, -5371.823, 5243.366, -2931.147);
			}
		}
	}
	
	else if(Current == PaymentMethod)
	{
	    TogglePlayerControllable(playerid, true);
	    new product[30];
		switch(row)
		{
			case 0:
			{
				if(BURGERproduct[playerid] == 0 && PIZZAproduct[playerid] == 0) return Kick(playerid);
				if(BURGERproduct[playerid] == 0)
				{
				    if(PIZZAproduct[playerid] == 1) format(product, sizeof(product), "Cheese Pizza"); price = 5;
				    if(PIZZAproduct[playerid] == 2) format(product, sizeof(product), "Bolognese Pizza"); price = 6;
				    if(PIZZAproduct[playerid] == 3) format(product, sizeof(product), "Hawaii Pizza"); price = 7;
				    if(PIZZAproduct[playerid] == 4) format(product, sizeof(product), "Coca Cola"); price = 4;
				    if(PIZZAproduct[playerid] == 5) format(product, sizeof(product), "Sprite"); price = 4;
				}
				if(PIZZAproduct[playerid] == 0)
				{
				    if(BURGERproduct[playerid] == 1) format(product, sizeof(product), "Cheese Burger"); price = 3;
				    if(BURGERproduct[playerid] == 2) format(product, sizeof(product), "Regular Burger"); price = 3;
				    if(BURGERproduct[playerid] == 3) format(product, sizeof(product), "Grill Burger"); price = 5;
				    if(BURGERproduct[playerid] == 4) format(product, sizeof(product), "Coca Cola"); price = 4;
				    if(BURGERproduct[playerid] == 5) format(product, sizeof(product), "Sprite"); price = 4;
				}
				if(GetPlayerMoney(playerid) < price)
				{
					format(string, sizeof(string), "INVALID PAYMENT.");
					SendClientMessage(playerid, COLOR_GREEN, string);
					format(string, sizeof(string), "COST OF %s: $%d, MONEY LEFT: $%d", product, price, GetPlayerMoney(playerid));
					SendClientMessage(playerid, COLOR_GREEN, string);
					ShowMenuForPlayer(PaymentMethod, playerid);
					if(PlayerInfo[playerid][pBankCash] < price)
					{
					    GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
					    format(string, sizeof(string), "Sorry, %s! You don't have money to buy %s, at all.", PlayerName, product);
					    SendClientMessage(playerid, COLOR_GREEN, string);
					    format(string, sizeof(string), "%s was not bought.");
					    TogglePlayerControllable(playerid, true);
					    HideMenuForPlayer(PaymentMethod, playerid);
					}
					return 1;
				}
				format(string, sizeof(string), "PRODUCT: %s", product);
				SendClientMessage(playerid, COLOR_GREEN, string);
				format(string, sizeof(string), "  PRICE: %d", price);
				SendClientMessage(playerid, COLOR_GREEN, string);
				SendClientMessage(playerid, COLOR_GREEN, "PAYMENT METHOD: cash");
				GivePlayerMoney(playerid, -price);
			}
			case 1:
			{
			    if(BURGERproduct[playerid] == 0 && PIZZAproduct[playerid] == 0) return Kick(playerid);
				if(BURGERproduct[playerid] == 0)
				{
				    if(PIZZAproduct[playerid] == 1) format(product, sizeof(product), "Cheese Pizza"); price = 5;
				    if(PIZZAproduct[playerid] == 2) format(product, sizeof(product), "Bolognese Pizza"); price = 6;
				    if(PIZZAproduct[playerid] == 3) format(product, sizeof(product), "Hawaii Pizza"); price = 7;
				    if(PIZZAproduct[playerid] == 4) format(product, sizeof(product), "Coca Cola"); price = 4;
				    if(PIZZAproduct[playerid] == 5) format(product, sizeof(product), "Sprite"); price = 4;
				}
				if(PIZZAproduct[playerid] == 0)
				{
				    if(BURGERproduct[playerid] == 1) format(product, sizeof(product), "Cheese Burger"); price = 3;
				    if(BURGERproduct[playerid] == 2) format(product, sizeof(product), "Regular Burger"); price = 3;
				    if(BURGERproduct[playerid] == 3) format(product, sizeof(product), "Grill Burger"); price = 5;
				    if(BURGERproduct[playerid] == 4) format(product, sizeof(product), "Coca Cola"); price = 4;
				    if(BURGERproduct[playerid] == 5) format(product, sizeof(product), "Sprite"); price = 4;
				}
				if(PlayerInfo[playerid][pBankCash] < price)
				{
					format(string, sizeof(string), "INVALID PAYMENT.");
					SendClientMessage(playerid, COLOR_GREEN, string);
					format(string, sizeof(string), "COST OF %s: $%d, MONEY LEFT: $%d", product, price, PlayerInfo[playerid][pBankCash]);
					SendClientMessage(playerid, COLOR_GREEN, string);
					ShowMenuForPlayer(PaymentMethod, playerid);
					if(GetPlayerMoney(playerid) < price)
					{
					    GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
					    format(string, sizeof(string), "Sorry, %s! You don't have money to buy %s, at all.", PlayerName, product);
					    SendClientMessage(playerid, COLOR_GREEN, string);
					    format(string, sizeof(string), "%s was not bought.");
					    TogglePlayerControllable(playerid, true);
					    HideMenuForPlayer(PaymentMethod, playerid);
					}
					return 1;
				}
				format(string, sizeof(string), "PRODUCT: %s", product);
				SendClientMessage(playerid, COLOR_GREEN, string);
				format(string, sizeof(string), "  PRICE: %d", price);
				SendClientMessage(playerid, COLOR_GREEN, string);
				SendClientMessage(playerid, COLOR_GREEN, "PAYMENT METHOD: credit card");
				PlayerInfo[playerid][pBankCash] = PlayerInfo[playerid][pBankCash] - price;
				dini_IntSet(file, "BankCash", PlayerInfo[playerid][pBankCash]);
			}
		}
	}
	
	else if(Current == BurgerShotMenu)
	{
	    switch(row)
	    {
	        case 0:
	        {
	            if(GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have enough money!");
	            BURGERproduct[playerid] = 3;
	            ShowMenuForPlayer(PaymentMethod, playerid);
	            SetMenuColumnHeader(PaymentMethod, 0, "Cost: $3");
	        }
	        case 1:
	        {
	            if(GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have enough money!");
	            BURGERproduct[playerid] = 3;
	            ShowMenuForPlayer(PaymentMethod, playerid);
	            SetMenuColumnHeader(PaymentMethod, 0, "Cost: $3");
	        }
	        case 2:
	        {
	            if(GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have enough money!");
	            BURGERproduct[playerid] = 3;
	            ShowMenuForPlayer(PaymentMethod, playerid);
	            SetMenuColumnHeader(PaymentMethod, 0, "Cost: $5");
	        }
	        case 3:
	        {
	            if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have enough money!");
	            BURGERproduct[playerid] = 4;
	            ShowMenuForPlayer(PaymentMethod, playerid);
	            SetMenuColumnHeader(PaymentMethod, 0, "Cost: $4");
	        }
			case 4:
			{
                if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have enough money!");
                BURGERproduct[playerid] = 5;
                ShowMenuForPlayer(PaymentMethod, playerid);
	            SetMenuColumnHeader(PaymentMethod, 0, "Cost: $4");
			}
		}
	}

	else if(Current == StackedPizzaMenu)
	{
	    switch(row)
	    {
	        case 0:
	        {
	            if(GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have enough money!");
	            PIZZAproduct[playerid] = 1;
	            ShowMenuForPlayer(PaymentMethod, playerid);
	            SetMenuColumnHeader(PaymentMethod, 0, "Cost: $5");
	        }
	        case 1:
	        {
	            if(GetPlayerMoney(playerid) < 6) return SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have enough money!");
	            PIZZAproduct[playerid] = 2;
	            ShowMenuForPlayer(PaymentMethod, playerid);
	            SetMenuColumnHeader(PaymentMethod, 0, "Cost: $6");
	        }
	        case 2:
	        {
	            if(GetPlayerMoney(playerid) < 8) return SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have enough money!");
	            PIZZAproduct[playerid] = 3;
	            ShowMenuForPlayer(PaymentMethod, playerid);
	            SetMenuColumnHeader(PaymentMethod, 0, "Cost: $8");
	        }
	        case 3:
	        {
	            if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have enough money!");
	            PIZZAproduct[playerid] = 4;
	            ShowMenuForPlayer(PaymentMethod, playerid);
	            SetMenuColumnHeader(PaymentMethod, 0, "Cost: $4");
	        }
			case 4:
			{
                if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have enough money!");
                PIZZAproduct[playerid] = 5;
                ShowMenuForPlayer(PaymentMethod, playerid);
	            SetMenuColumnHeader(PaymentMethod, 0, "Cost: $4");
			}
		}
	}
 	return 0;
}
	
public DriveCount(playerid)
{
	new string[256];
	if(gLicenseCount[playerid] >= 0 || gLicenseCount[playerid] <= 149)
	{
	    gLicenseCount[playerid] += 1;
	    format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~p~%d~g~/~r~150", gLicenseCount[playerid]);
	    GameTextForPlayer(playerid, string, 1000, 3);
	}
	else if(gLicenseCount[playerid] >= 150)
	{
		GameTextForPlayer(playerid, "~r~You Fail the test, ran out of time.", 3000, 3);
		KillTimer(DriveCountT);
		DisablePlayerCheckpoint(playerid);
		SendClientMessage(playerid, COLOR_GREY, "You ran out of time to fill in the test! Please try again.");
		DrivingFails += 1;
		dini_IntSet("/VirtualScriptingRP/Stats/drivingschool.cfg", "Fails", DrivingFails);
		format(string, sizeof(string), "Driving School: There are total %d people who have passed the test, %d who haven't.", DrivingPasses, DrivingFails);
		SendClientMessage(playerid, COLOR_CYELLOW, string);
		gLicenseTest[playerid] = 0;
	}
}
public OnPlayerConnect(playerid)
{
	new file[256], string[128];
	CheckName(playerid);
    format(file, sizeof(file), "/VirtualScriptingRP/Accounts/%s.ini", PlayerName);
	GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
	GetPlayerIp(playerid, playerip, sizeof(playerip));
	format(string, sizeof(string), "JOIN: %s(%i) connected (IP: %s)", PlayerName, playerid, playerip);
	aLog("Connections.txt", string);
	
	for(new i = 0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] == 0)
	    {
			format(string, sizeof(string), "SERVER: %s(%i) has joined the server", PlayerName, playerid);
			SendClientMessage(i, COLOR_CYELLOW, string);
		}
		if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] >= 1)
		{
		    format(string, sizeof(string), "SERVER: %s(%i) has joined the server (IP: %s)", PlayerName, playerid, playerip);
		    SendClientMessage(i, COLOR_CYELLOW, string);
		}
	}
	CleanChat(playerid);
	
	format(string, sizeof(string), "       SCRIPT VERSION: %s", SCRIPT_VERSION);
	SendClientMessage(playerid, COLOR_GREY, string);
	format(string, sizeof(string), "       DEVELOPMENT START: %s", DEV_START);
	SendClientMessage(playerid, COLOR_GREY, string);
	format(string, sizeof(string), "       SCRIPT DEVELOPER: %s", SCRIPT_DEV);
	SendClientMessage(playerid, COLOR_GREY, string);
	format(string, sizeof(string), "       LAST UPDATE: %s", LAST_UPDATE);
	SendClientMessage(playerid, COLOR_GREY, string);
	format(string, sizeof(string), "       REPORT BUGS: %s", SITEADDRESS);
	SendClientMessage(playerid, COLOR_GREY, string);
	
	if(fexist(file))
	{
	    SendClientMessage(playerid, COLOR_WHITE, "SERVER: Welcome back. </login [password]>");
	}
	else
	{
	    SendClientMessage(playerid, COLOR_WHITE, "SERVER: Welcome. </register [password]>");
	}
	
	SendDeathMessage(playerid, INVALID_PLAYER_ID, 200);
	SendDeathMessage(INVALID_PLAYER_ID, playerid, 200);
	GameTextForPlayer(playerid, "~p~SF-RP", 3000, 6);
	SetTimerEx("CheckWeaponHack", 1000, true, "i", playerid);
	FirstTimeSpawn[playerid] = 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	gLogged[playerid] = 0;
	PlayerInfo[playerid][pAdmin] = 0;
    new string[256], file[128];
	GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
	GetPlayerIp(playerid, playerip, sizeof(playerip));
    format(file, sizeof(file), "/VirtualScriptingRP/Accounts/%s.ini", PlayerName);
    format(string, sizeof(string), "PART: %s(%i) disconnected (IP: %s)", PlayerName, playerid, playerip);
	aLog("Connections.txt", string);
    if(gLogged[playerid] == 1)
	{
		new Skin = GetPlayerSkin(playerid);
	    if(Skin == 280 || Skin == 281 || Skin == 282)
	    {
	        dini_IntSet(file, "Skin", 0);
		}
		else
		{
		    dini_IntSet(file, "Skin", GetPlayerSkin(playerid));
		}
	    GetPlayerIp(playerid, playerip, sizeof(playerip));
		dini_IntSet(file, "HandMoney", GetPlayerMoney(playerid));
		GetPlayerPos(playerid, Float:PlayerInfo[playerid][pSaveX], Float:PlayerInfo[playerid][pSaveY], Float:PlayerInfo[playerid][pSaveZ]);
		PlayerInfo[playerid][pSaveInt] = GetPlayerInterior(playerid);
		dini_FloatSet(file, "X_POS", PlayerInfo[playerid][pSaveX]);
		dini_FloatSet(file, "Y_POS", PlayerInfo[playerid][pSaveY]);
		dini_FloatSet(file, "Z_POS", PlayerInfo[playerid][pSaveZ]);
		dini_IntSet(file, "INT_POS", PlayerInfo[playerid][pSaveInt]);
		GetPlayerHealth(playerid, PlayerInfo[playerid][pSaveHealth]);
		GetPlayerArmour(playerid, PlayerInfo[playerid][pSaveArmor]);
		dini_FloatSet(file, "SAVE_HEALTH", PlayerInfo[playerid][pSaveHealth]);
		dini_FloatSet(file, "SAVE_ARMOR", PlayerInfo[playerid][pSaveArmor]);
	}
    SendDeathMessage(INVALID_PLAYER_ID, playerid, 201);
	switch (reason)
	{
 		case 0:
		{
			format(string, sizeof(string), "SERVER: %s(%i) has left the server (Timeout)", PlayerName, playerid);
			SendClientMessageToAll(COLOR_CYELLOW, string);
		}
		case 1:
 		{
			format(string, sizeof(string), "SERVER: %s(%i) has left the server (Leaving)", PlayerName, playerid);
			SendClientMessageToAll(COLOR_CYELLOW, string);
		}
		case 2:
	 	{
			format(string, sizeof(string), "SERVER: %s(%i) has left the server (Kicked/banned)", PlayerName, playerid);
			SendClientMessageToAll(COLOR_CYELLOW, string);
		}
	}
	TextDrawHideForPlayer(playerid, ZoneText[playerid]);
	TextDrawHideForPlayer(playerid, Textie[playerid]);
	TextDrawDestroy(ZoneText[playerid]);
	TextDrawDestroy(Textie[playerid]);
}

public OnPlayerRequestClass(playerid, classid)
{
    SetPlayerCameraPos(playerid, -1485.5114, 717.0153, 7.092187);
	SetPlayerCameraLookAt(playerid, -15.230957, 724.7045, 6.992187);
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid, -1480.6327,716.6155,6.9922);
	SetPlayerFacingAngle(playerid, 58.1321);
	PlayerPlaySound(playerid, 1185, 0.0, 0.0, 0.0);
	if(gLogged[playerid] == 1)
	{
	    if(classid >= 0)
	    {
	        if(PlayerInfo[playerid][pTutorial] == 0 && PlayerInfo[playerid][pSkin] != 0)
	        {
	        	GameTextForPlayer(playerid, "~w~Civilian ~n~~n~~g~Press ~p~SHIFT~g~ to spawn.", 3000, 3);
			}
			else if(PlayerInfo[playerid][pTutorial] == 1 && PlayerInfo[playerid][pSkin] != 0)
			{
			    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
			}
		}
	}
	if(gLogged[playerid] == 0)
	{
	    if(classid >= 0)
	    {
	        GameTextForPlayer(playerid, "~w~Civilian ~n~~n~~g~~p~Login ~g~to spawn.", 3000, 3);
		}
	}
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	if(gLogged[playerid] == 0)
	{
	    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in before spawning (/login)!");
	    return 0;
	}
	return 1;
}

public SetSkin(playerid)
{
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
}

public UnCall(playerid)
{
	gLastCall[playerid] = 0;
}

public OnPlayerSpawn(playerid)
{
    new file[128];
    GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
    format(file, sizeof(file), "/VirtualScriptingRP/Accounts/%s.ini", PlayerName);
	if(PlayerInfo[playerid][pTutorial] == 0)
	{
	    TogglePlayerControllable(playerid, 0);
	    GameTextForPlayer(playerid, "~y~Welcome to ~b~VirtualScripting RPG~y~~n~Game-play tutorial!", 10000, 3);
		TutTimer = SetTimerEx("ShowTut", 9000, true, "i", playerid);
		SendClientMessage(playerid, COLOR_CYELLOW, " * Before you continue in VirtualScriptinG RPG, you must read the lead-in tutorial.");
		gTutorial[playerid] = 1;
		PlayerPlaySound(playerid, 1185, 0.0, 0.0, 0.0);
		dini_IntSet(file, "Skin", GetPlayerSkin(playerid));
	}
	if(PlayerInfo[playerid][pCop] == 1)
	{
	    SetPlayerSkin(playerid, 281);
	    GivePlayerWeapon(playerid, 24, 70);
	    GivePlayerWeapon(playerid, 25, 20);
	    GivePlayerWeapon(playerid, 3, 1);
	    SetPlayerColor(playerid, COLOR_DBLUE);
	    gTeam[playerid] = TEAM_COP;
	}
	else
	{
	    dini_IntSet(file, "Skin", GetPlayerSkin(playerid));
	    SetPlayerColor(playerid, COLOR_WHITE);
	    gTeam[playerid] = TEAM_CIVILIAN;
	    PlayerInfo[playerid][pSkin] = dini_Int(file, "Skin");
	    SetTimer("SetSkin", 1000, false);
	    if(FirstTimeSpawn[playerid] == 1)
	    {
			PlayerInfo[playerid][pSaveX] = dini_Float(file, "X_POS");
			PlayerInfo[playerid][pSaveY] = dini_Float(file, "Y_POS");
			PlayerInfo[playerid][pSaveZ] = dini_Float(file, "Z_POS");
			PlayerInfo[playerid][pSaveInt] = dini_Int(file, "INT_POS");
			PlayerInfo[playerid][pSaveHealth] = dini_Int(file, "SAVE_HEALTH");
			PlayerInfo[playerid][pSaveArmor] = dini_Int(file, "SAVE_ARMOUR");
		    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
		    SetPlayerPos(playerid, PlayerInfo[playerid][pSaveX], PlayerInfo[playerid][pSaveY], PlayerInfo[playerid][pSaveZ]);
		    SetPlayerInterior(playerid, PlayerInfo[playerid][pSaveInt]);
		    FirstTimeSpawn[playerid] = 0;
		}
	}
	if(CrimSpawn[playerid] == 1)
	{
		if(GetPlayerMoney(playerid) >= 500)
		{
		    GivePlayerMoney(playerid, -500);
		}
		SendClientMessage(playerid, COLOR_CRED, "You got fined for $400 and the hospital took $100 from you.");
	}
	SetPlayerMapIcon(playerid, 0, -1808.6747,904.0485,24.8906, 52, 0);
	SetPlayerMapIcon(playerid, 1, -1942.4457,459.7402,35.1719, 52, 0);
	SetPlayerMapIcon(playerid, 2, -2651.2212,376.3470,5.8526, 52, 0);
	SetPlayerMapIcon(playerid, 3, -2026.5909,-101.2296,35.1641, 36, 0);
	SetPlayerMapIcon(playerid, 3, JIZZY, 49, 0);
	SetPlayerMapIcon(playerid, 4, COCKTAIL, 17, 0);
	LoadZoneText(playerid);
	StopMusic(playerid);
}

SetOnDuty(playerid)
{
	SetPlayerSkin(playerid, 281);
	GivePlayerWeapon(playerid, 24, 70);
	GivePlayerWeapon(playerid, 25, 20);
	GivePlayerWeapon(playerid, 3, 1);
	SetPlayerColor(playerid, COLOR_DBLUE);
	gTeam[playerid] = TEAM_COP;
}

SetOffDuty(playerid)
{
    SetPlayerColor(playerid, COLOR_WHITE);
	gTeam[playerid] = TEAM_CIVILIAN;
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
}

InfoTextDraw(playerid, string[], time)
{
	TextDrawDestroy(Textie[playerid]);
	Textie[playerid] = TextDrawCreate(151.000000, 371.000000, string);
	TextDrawAlignment(Textie[playerid], 0);
	TextDrawBackgroundColor(Textie[playerid], 0x000000ff);
	TextDrawFont(Textie[playerid], 1);
	TextDrawLetterSize(Textie[playerid], 0.399999, 1.300000);
	TextDrawColor(Textie[playerid], 0xffffffff);
	TextDrawSetProportional(Textie[playerid], 1);
	TextDrawSetShadow(Textie[playerid], 1);
	TextDrawShowForPlayer(playerid, Textie[playerid]);
	SetTimerEx("HideInfoTextDraw", time, false, "i", playerid);
}

public HideInfoTextDraw(playerid)
{
    TextDrawHideForPlayer(playerid, Textie[playerid]);
	TextDrawDestroy(Textie[playerid]);
}
public ShowTut(playerid)
{
	new file[128];
    GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
    format(file, sizeof(file), "/VirtualScriptingRP/Accounts/%s.ini", PlayerName);
    if(gTutorial[playerid] == 1)
    {
        SendClientMessage(playerid, COLOR_CYELLOW, "* Chapter 1: Roleplaying");
		SendClientMessage(playerid, COLOR_GREY, "   In a RPG Server, like VirtualScripting one, you must act like you would in real life.");
		SendClientMessage(playerid, COLOR_GREY, "   You will have a character, what you would like to play. But there are some restrictions.");
		SendClientMessage(playerid, COLOR_GREY, "   Any kind of POWER- or METAGaming isn't allowed. Power- and metagaming, what?");
		SendClientMessage(playerid, COLOR_GREY, "   POWERGAMING: You have un-natural powers like some super creatures.");
		SendClientMessage(playerid, COLOR_GREY, "   METAGAMING: Using outgame(OOC) information IC (in character, in game)");
		SendClientMessage(playerid, COLOR_GREY, "   There are some information icons to help you out, anytime you get in trouble.");
		gTutorial[playerid] = 2;
	}
	else if(gTutorial[playerid] == 2)
	{
	    SendClientMessage(playerid, COLOR_CYELLOW, "* Chapter 2: Features");
        SendClientMessage(playerid, COLOR_GREY, "   Basically, you could do a perfect RP with \"/me\" command, right? Yes, but why not more?");
        SendClientMessage(playerid, COLOR_GREY, "   There are some cool features, like: Getting a passport/license, buying a cellphone, banking money, etc.");
        SendClientMessage(playerid, COLOR_GREY, "   The RPG is still in testing mode, so some parts might not work properly,");
        SendClientMessage(playerid, COLOR_GREY, "   Report the bugs @ VirtualScripting.NET");
        gTutorial[playerid] = 3;
	}
	else if(gTutorial[playerid] == 3)
	{
	    SendClientMessage(playerid, COLOR_CYELLOW, "* Chapter 3: Respect");
	    SendClientMessage(playerid, COLOR_GREY, "   You got to learn respect in this RPG world, in OOC and also IC. ");
	    SendClientMessage(playerid, COLOR_GREY, "   NB! Rules are strict about METAGAMING, which can also be the following situation:");
	    SendClientMessage(playerid, COLOR_GREY, "    * X gets insulted by Y in main chat, X goes and kills Y in character - WRONG, METAGAMING");
	    SendClientMessage(playerid, COLOR_GREY, "   When you don't have anything good to say about the players, administration or what ever, don't.");
	    SendClientMessage(playerid, COLOR_GREY, "   VirtualScripting Team strongly suggests that you don't start it off the bad way.");
		gTutorial[playerid] = 4;
	}
	else if(gTutorial[playerid] == 4)
	{
	    SendClientMessage(playerid, COLOR_CYELLOW, "* Chapter 4: Glitches, bugs, hacks, cheats");
	    SendClientMessage(playerid, COLOR_GREY, "   You will be banned for hacking, cheating, abusing glitches/bugs.");
	    SendClientMessage(playerid, COLOR_GREY, "   The rules about this are strict:");
	    SendClientMessage(playerid, COLOR_GREY, "    * Don't use cheats, hacks, don't abuse glitches/bugs.");
	    SendClientMessage(playerid, COLOR_GREY, "    * Report any cheater/hacker/glitch/bug abuser you see - /report ID REASON");
	    SendClientMessage(playerid, COLOR_GREY, "   NB! Don't even \"try hacks\", you'll be banned.");
		gTutorial[playerid] = 5;
	}
	else if(gTutorial[playerid] == 5)
	{
	    SendClientMessage(playerid, COLOR_CYELLOW, "* Chapter 5: Bank");
	    SendClientMessage(playerid, COLOR_GREY, "   There are 3 banks in San Fierro, marked with a dollar icon on map.");
	    SendClientMessage(playerid, COLOR_GREY, "   2 of them are located in DownTown district, one is west San Fierro");
	    SendClientMessage(playerid, COLOR_GREY, "   When you enter a bank, walk to red checkpoint, a menu will open with choices");
	    SendClientMessage(playerid, COLOR_GREY, "   You can withdraw / deposit money from $1 to $100.000 at a time.");
	    gTutorial[playerid] = 6;
	}
	else if(gTutorial[playerid] == 6)
	{
	    SendClientMessage(playerid, COLOR_CYELLOW, "* Chapter 6: SFPD Forces");
	    SendClientMessage(playerid, COLOR_GREY, "   San Fierro has its own Police Department (Shortly: SFPD),");
	    SendClientMessage(playerid, COLOR_GREY, "   Strong men, armed with Desert Eagle, Shotgun and a Nite Stick.");
	    SendClientMessage(playerid, COLOR_GREY, "   We're pretty sure you don't want to get on those guys way, do you?");
	    SendClientMessage(playerid, COLOR_GREY, "   Police officers can suspect you (\"/suspect\"), when you commit a crime, such as:");
	    SendClientMessage(playerid, COLOR_GREY, "   \"First Degree Murder\", \"Hit And Run\", \"Assaulting\", etc.");
	    SendClientMessage(playerid, COLOR_GREY, "   You can see more detailed help for police officers by using \"/cophelp\".");
	    gTutorial[playerid] = 7;
	}
	else if(gTutorial[playerid] == 7)
	{
	    SendClientMessage(playerid, COLOR_CYELLOW, "* Chapter 7: Good luck!");
	    SendClientMessage(playerid, COLOR_GREY, "   The VirtualScripting SA-MP Scripting team wishes you good luck in this RPG mode!");
	    SendClientMessage(playerid, COLOR_GREY, "   We hope you remembered something from the tutorial! - VirtualScripting Team");
	    SendClientMessage(playerid, COLOR_YELLOW, "   * You've received your passport, head to Driving School for a license!");
	    SendClientMessage(playerid, COLOR_CRED, "   The government of VS has just transferred $20.000 to your account, it shall be there soon.");
		gSentMoney[playerid] = 1;
		SetTimer("TransferDone", 20000, false);
	    gTutorial[playerid] = 0;
		KillTimer(TutTimer);
		TogglePlayerControllable(playerid, true);
		PlayerInfo[playerid][pTutorial] = 1;
		PlayerInfo[playerid][pPassport] = 1;
		dini_IntSet(file, "ReadTutorial", PlayerInfo[playerid][pTutorial]);
		dini_IntSet(file, "Passport", PlayerInfo[playerid][pPassport]);
		GivePlayerMoney(playerid, 2400);
		SetCameraBehindPlayer(playerid);
		StopMusic(playerid);
	}
}


public TransferDone(playerid)
{
	if(gSentMoney[playerid] == 1)
	{
	    new file[128];
	    GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
	    format(file, sizeof(file), "/VirtualScriptingRP/Accounts/%s.ini", PlayerName);
	    SendClientMessage(playerid, COLOR_GREY, "BANK: $20.000 has been transfered to your bank account.");
	    PlayerInfo[playerid][pBankCash] += 20000;
	    dini_IntSet(file, "BankCash", PlayerInfo[playerid][pBankCash]);
	}
}

public CleanChat(playerid)
{
   	SendClientMessage(playerid, COLOR_SYSTEM, " ");
	SendClientMessage(playerid, COLOR_SYSTEM, " ");
	SendClientMessage(playerid, COLOR_SYSTEM, " ");
	SendClientMessage(playerid, COLOR_SYSTEM, " ");
	SendClientMessage(playerid, COLOR_SYSTEM, " ");
	SendClientMessage(playerid, COLOR_SYSTEM, " ");
	SendClientMessage(playerid, COLOR_SYSTEM, " ");
	SendClientMessage(playerid, COLOR_SYSTEM, " ");
	SendClientMessage(playerid, COLOR_SYSTEM, " ");
	SendClientMessage(playerid, COLOR_SYSTEM, " ");
}

public RealTime()
{
	gettime(Hour, Minute, Second);
	if(Hour == 0) SetWorldTime(24);
	if(Hour == 1) SetWorldTime(1);
	if(Hour == 2) SetWorldTime(2);
	if(Hour == 3) SetWorldTime(3);
	if(Hour == 4) SetWorldTime(4);
	if(Hour == 5) SetWorldTime(5);
	if(Hour == 6) SetWorldTime(6);
	if(Hour == 7) SetWorldTime(7);
	if(Hour == 8) SetWorldTime(8);
	if(Hour == 9) SetWorldTime(9);
	if(Hour == 10) SetWorldTime(10);
	if(Hour == 11) SetWorldTime(11);
	if(Hour == 12) SetWorldTime(12);
	if(Hour == 13) SetWorldTime(13);
	if(Hour == 14) SetWorldTime(14);
	if(Hour == 15) SetWorldTime(15);
	if(Hour == 16) SetWorldTime(16);
	if(Hour == 17) SetWorldTime(17);
	if(Hour == 18) SetWorldTime(18);
	if(Hour == 19) SetWorldTime(19);
	if(Hour == 20) SetWorldTime(20);
	if(Hour == 21) SetWorldTime(21);
	if(Hour == 22) SetWorldTime(22);
	if(Hour == 23) SetWorldTime(23);
	return 1;
}

public OnPlayerText(playerid,text[])
{
    if(gMute[playerid] == 1)
	{
		SendClientMessage(playerid, COLOR_RED, "You can not talk while muted!");
		return 0;
    }
    if(gMute[playerid] == 0)
    {
		return 1;
	}
	return 0;
}

public MoneyGrubScoreUpdate()
{
	new CashScore, CashScoreOld;
	new name[MAX_PLAYER_NAME];
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i, name, sizeof(name));
   			CashScore = GetPlayerMoney(i);
			SetPlayerScore(i, CashScore);
			if (CashScore > CashScoreOld)
			{
				CashScoreOld = CashScore;
			}
		}
	}
}

public GodMode(playerid)
{
	SetPlayerHealth(playerid, 100000.0);
	SetPlayerArmour(playerid, 100000.0);
	SetVehicleHealth(GetPlayerVehicleID(playerid), 1000000.0);
}

public HealthCheck(playerid)
{
	if(gRepeatHealthTimer[playerid] == 0) return KillTimer(HealthCheckTimer);
 	new Float:pH;
	GetPlayerHealth(playerid, pH);
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	gettime(Hour, Minute, Second);
	GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
	printf("[%d:%d:%d] %s [ID: %d]: Height: %f / Health: %f", Hour, Minute, Second, PlayerName, playerid, Z, pH);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
   	new cmd[256], tmp[256], tmp2[256], file[128], gfile[128], string[128];
	new giveplayer[24], sendername[24], playername[24];
	new giveplayerid, idx;
	SuccessCommands += 1;
	dini_IntSet("/VirtualScriptingRP/Stats/commands.cfg", "Successful", SuccessCommands);
	GetPlayerName(playerid, sendername, sizeof(sendername));
	format(file, sizeof(file), "/VirtualScriptingRP/Accounts/%s.ini", sendername);
	cmd = strtok(cmdtext, idx);
	if(strcmp(cmd, "/myhealth", true) == 0)
	{
	    new Float:pH;
		GetPlayerHealth(playerid, pH);
		new Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		gettime(Hour, Minute, Second);
		if(gRepeatHealthTimer[playerid] == 1)
		{
		    KillTimer(HealthCheckTimer);
		    printf("%s [ID: %d]: Testing END, health %f, time: %d:%d:%d", PlayerName, playerid, pH, Hour, Minute, Second);
			gRepeatHealthTimer[playerid] = 0;
		}
		else
		{
			HealthCheckTimer = SetTimerEx("HealthCheck", 1000, true, "i", playerid);
			SetPlayerHealth(playerid, 1000.0);
			printf("%s [ID: %d]: Testing start, health: %f, time: %d:%d:%d", PlayerName, playerid, pH, Hour, Minute, Second);
			gRepeatHealthTimer[playerid] = 1;
		}
		return 1;
	}
	if(strcmp(cmd, "/wb", true) == 0 || strcmp(cmd, "/worldboundaries", true) == 0)
	{
		if(gLogged[playerid] == 0) return SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
	    if(PlayerInfo[playerid][pAdmin] >= 1)
	    {
			ShowMenuForPlayer(Boundaries, playerid);
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be a admin to use this!");
		}
		return 1;
	}
	if(strcmp(cmd, "/buy", true) == 0)
	{
		if(GetPlayerInterior(playerid) == 1)
		{
		    InfoTextDraw(playerid, "~g~Choose a drink!", 3000);
		    ShowMenuForPlayer(CockBar, playerid);
		}
		else if(GetPlayerInterior(playerid) == 3)
		{
		    InfoTextDraw(playerid, "~g~Choose a drink!", 3000);
		    ShowMenuForPlayer(BarMenu, playerid);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You're not in a bar!");
		}
		return 1;
	}
	if(strcmp(cmd, "/carcolor", true) == 0)
	{
	    new color1, color2;
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /carcolor [color1] [color2]");
	    color1 = strval(tmp);
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /carcolor [color1] [color2]");
	    color2 = strval(tmp);
	    ChangeVehicleColor(GetPlayerVehicleID(playerid), color1, color2);
	    return 1;
	}
	if(strcmp(cmd, "/aSave", true) == 0)
	{
	    tmp = strtok(cmdtext, idx);
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        new Model = GetVehicleModel(GetPlayerVehicleID(playerid));
	        new Float:vX, Float:vY, Float:vZ, Float:vA;
	        GetPlayerPos(playerid, vX, vY, vZ);
	        GetVehicleZAngle(GetPlayerVehicleID(playerid), vA);
	        format(string, sizeof(string), "AddStaticVehicle(%d, %f, %f, %f, %f, 0, 0); // %s", Model, vX, vY, vZ, vA, tmp);
	        aLog("AddStaticVehicle.txt", string);
	    }
	    else
	    {
	        new Skin = GetPlayerSkin(playerid);
	        new Float:pX, Float:pY, Float:pZ, Float:pA;
	        GetPlayerPos(playerid, pX, pY, pZ);
	        GetPlayerFacingAngle(playerid, pA);
	        format(string, sizeof(string), "AddPlayerClass(%d, %f, %f, %f, %f, 0, 0, 0, 0, 0, 0); // %s", Skin, pX, pY, pZ, pA, tmp);
	        aLog("AddPlayerClass.txt", string);
	    }
	    return 1;
	}
	if(strcmp(cmd, "/godmode", true) == 0)
	{
		SetPlayerHealth(playerid, 10000.0);
		SetPlayerArmour(playerid, 10000.0);
		SetTimer("GodMode", 1000, true);
		SetVehicleHealth(GetPlayerVehicleID(playerid), 100000.0);
		return 1;
	}
	if(strcmp(cmd, "/oSave", true) == 0)
	{
	    new Float:X, Float:Y, Float:Z;
	    GetPlayerPos(playerid, X, Y, Z);
	    format(string, sizeof(string), "%s: %f, %f, %f", tmp, X, Y, Z);
	    aLog("Coordinates.txt", string);
	    return 1;
	}
	if(strcmp(cmd, "/kill", true) == 0)
	{
	    if(gFreeze[playerid] == 1) return SendClientMessage(playerid, COLOR_RED, "You can't /kill while frozen by admin!");
	    SetPlayerHealth(playerid, 0.0);
		return 1;
	}
	if(strcmp(cmd, "/givelicense", true) == 0)
	{
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /givelicense [id]");
	    giveplayerid = strval(tmp);
	    if(gLogged[playerid] == 0) return SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in!");
	    if(gLogged[giveplayerid] == 0) return SendClientMessage(playerid, COLOR_GREY, "SERVER: That player must be logged in!");
	    if(PlayerInfo[playerid][pAdmin] >= 3)
	    {
	        if(IsPlayerConnected(giveplayerid))
	        {
	            format(gfile, sizeof(gfile), "/VirtualScriptingRP/Accounts/%s.ini", sendername);
	            PlayerInfo[giveplayerid][pLicense] = 1;
	            dini_IntSet(gfile, "License", PlayerInfo[giveplayerid][pLicense]);
			}
			else
			{
			    format(string, sizeof(string), "SERVER: %d isn't connected ID!", giveplayerid);
			    SendClientMessage(playerid, COLOR_GREY, string);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be admin to use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/takelicense", true) == 0)
	{
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /givelicense [id]");
	    giveplayerid = strval(tmp);
	    if(gLogged[playerid] == 0) return SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in!");
	    if(gLogged[giveplayerid] == 0) return SendClientMessage(playerid, COLOR_GREY, "SERVER: That player must be logged in!");
	    if(PlayerInfo[playerid][pAdmin] >= 3)
	    {
	        if(IsPlayerConnected(giveplayerid))
	        {
	            format(gfile, sizeof(gfile), "/VirtualScriptingRP/Accounts/%s.ini", sendername);
	            PlayerInfo[giveplayerid][pLicense] = 0;
	            dini_IntSet(gfile, "License", PlayerInfo[giveplayerid][pLicense]);
			}
			else
			{
			    format(string, sizeof(string), "SERVER: %d isn't connected ID!", giveplayerid);
			    SendClientMessage(playerid, COLOR_GREY, string);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be admin to use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/stats", true) == 0)
	{
		new PassportText[30], LicenseText[30], BankText[30], AdminText[40];
		if(PlayerInfo[playerid][pPassport] == 1)
		{
		    format(PassportText, sizeof(PassportText), "Yes");
		}
		else
		{
		    format(PassportText, sizeof(PassportText), "No");
		}
		if(PlayerInfo[playerid][pLicense] == 1)
		{
		    format(LicenseText, sizeof(LicenseText), "Yes");
		}
		else
		{
		    format(LicenseText, sizeof(LicenseText), "No");
		}
		if(PlayerInfo[playerid][pBankCash] >= 1)
		{
		    format(BankText, sizeof(BankText), "Yes: $%d", PlayerInfo[playerid][pBankCash]);
		}
		else
		{
		    format(BankText, sizeof(BankText), "No");
		}
		if(PlayerInfo[playerid][pAdmin] >= 1)
		{
			if(PlayerInfo[playerid][pAdmin] == 1) format(AdminText, sizeof(AdminText), "Admin Level 1 (Trial Moderator)");
			if(PlayerInfo[playerid][pAdmin] == 2) format(AdminText, sizeof(AdminText), "Admin Level 2 (Moderator)");
			if(PlayerInfo[playerid][pAdmin] == 3) format(AdminText, sizeof(AdminText), "Admin Level 3 (Administrator)");
			if(PlayerInfo[playerid][pAdmin] == 4) format(AdminText, sizeof(AdminText), "Admin Level 4 (Main Administrator)");
		}
		if(PlayerInfo[playerid][pAdmin] == 0)
		{
		    format(AdminText, sizeof(AdminText), "Regual RPG'er");
		}
		format(string, sizeof(string), "User Statistics: %s (ID: %d)", sendername, playerid);
		SendClientMessage(playerid, COLOR_BGREEN, string);
		format(string, sizeof(string), "Status: %s", AdminText);
		SendClientMessage(playerid, COLOR_CRED, string);
		format(string, sizeof(string), "Passport: %s | License: %s | Bank Money: %s | Hand Money: $%d", PassportText, LicenseText, BankText, GetPlayerMoney(playerid));
		SendClientMessage(playerid, COLOR_CRED, string);
		return 1;
	}
	if(strcmp(cmd, "/taxi", true) == 0)
	{
	    new fee;
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /taxi [fee]");
		fee = strval(tmp);
		if(fee >= 71 || fee <= 5)
		{
		    SendClientMessage(playerid, COLOR_GREY, "FEE has to be higher than $5 and smaller than $70!");
			return 1;
		}
		if(gTeam[playerid] == TEAM_CRIMINAL) return SendClientMessage(playerid, COLOR_GREY, "CabCompany: You can't start duty while wanted!");
		if(gTeam[playerid] == TEAM_COP) return SendClientMessage(playerid, COLOR_GREY, "CabCompany: You can't start duty while on duty as officer!");
		if(PlayerInfo[playerid][pLicense] == 0) return SendClientMessage(playerid, COLOR_GREY, "CabCompany: You need driving license! Get one at driving school!");
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 420 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 438)
		{
			gTaxiFee[playerid] = fee;
			gTeam[playerid] = TEAM_TAXI;
			SetPlayerColor(playerid, COLOR_BGREEN);
			format(string, sizeof(string), "%s(%i) is now working as Taxi Driver. Fee: $%d", sendername, playerid, fee);
			SendClientMessageToAll(COLOR_CRED, string);
			SendClientMessage(playerid, COLOR_CYELLOW, "You can press TAB once in 2 minutes to advertise your service.");
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "Be in a cab!");
		}
		return 1;
	}
	
	if(strcmp(cmd, "/calltaxi", true) == 0)
	{
		if(gLastCall[playerid] == 1) return SendClientMessage(playerid, COLOR_GREY, "ERROR: This command has flood protection enabled. Please wait and try again...");
	    new zone[28];
	    GetPlayer2DZone(playerid, zone, sizeof(zone));
		if(gTeam[playerid] == TEAM_CRIMINAL) return SendClientMessage(playerid, COLOR_GREY, "CabCompany: Sorry, we don't serve criminals!");
		format(string, sizeof(string), "DISPATCH: Attention all drivers! %s(%i) is requesting a taxi at %s district.", sendername, playerid, zone);
		gLastCall[playerid] = 1;
		SetTimer("UnCall", 7000, false);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(gTeam[i] == TEAM_TAXI)
			{
				SendClientMessage(i, COLOR_BGREEN, string);
			}
		}
		gCallTaxi[playerid] = 1;
		/*if(gCallTaxi[playerid] == 1 || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
		{
			if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 420 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 438)
			{
			    for(new i = 0; i < MAX_PLAYERS; i++)
			    {
					if(gTeam[i] == TEAM_TAXI && GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid) && GetPlayerState(i) == PLAYER_STATE_DRIVER)
					{
					    StartPay(playerid, i);
						new iName[24];
						GetPlayerName(i, iName, sizeof(iName));
						format(string, sizeof(string), "DRIVER: Welcome! I'm %s, your driver! Where would you like to go?", iName);
						SendClientMessage(playerid, COLOR_BGREEN, string);
						format(string, sizeof(string), "DISPATCH: That is your costumer, %s.", iName);
						SendClientMessage(i, COLOR_BGREEN, string);
					}
				}
			}
		}
		public StartPay(playerid, i)
		
		public PayDriver(playerid, passenger)
		{
			new passengerName[24];
			GetPlayerName(passenger, passengerName, sizeof(passengerName));
			SetTimerEx("PayDriver", 10000, true, "ii", playerid);
			
			*/
		SendClientMessage(playerid, COLOR_GREY, "CabCompany: We have received your request. When a unit is available, you will be picked up!");
		return 1;
	}
	
	if(strcmp(cmd, "/enter", true) == 0)
	{
     	GetPlayerPos(playerid, gBeforeEnterX[playerid], gBeforeEnterY[playerid], gBeforeEnterZ[playerid]);
	    if(PlayerToPoint(3.0, playerid, Bank1Enter) || PlayerToPoint(3.0, playerid, Bank2Enter) || PlayerToPoint(3.0, playerid, Bank3Enter))
	    {
	        SetPlayerInterior(playerid, 17);
	        SetPlayerPos(playerid, -25.884499, -185.868988, 1003.549988);
	        SendClientMessage(playerid, COLOR_WHITE, "Welcome to the State Bank!");
	        SetPlayerCheckpoint(playerid, -29.2042,-185.1275,1003.5469, 2.0);
	   	    dini_FloatSet(file, "X_ENTER", gBeforeEnterX[playerid]);
			dini_FloatSet(file, "Y_ENTER", gBeforeEnterY[playerid]);
			dini_FloatSet(file, "Z_ENTER", gBeforeEnterZ[playerid]);
		}
		else if(PlayerToPoint(3.0, playerid, SFPD))
		{
		    SetPlayerInterior(playerid, 10);
		    SetPlayerPos(playerid, 246.40, 110.84, 1003.22);
		    SendClientMessage(playerid, COLOR_WHITE, "Welcome to SFPD, behave well!");
		    SetPlayerCheckpoint(playerid, 251.6816,117.3733,1003.2188, 2.0);
		    dini_FloatSet(file, "X_ENTER", gBeforeEnterX[playerid]);
			dini_FloatSet(file, "Y_ENTER", gBeforeEnterY[playerid]);
			dini_FloatSet(file, "Z_ENTER", gBeforeEnterZ[playerid]);
		}
		else if(PlayerToPoint(3.0, playerid, COCKTAIL))
		{
		    SetPlayerInterior(playerid, 1);
		    SetPlayerPos(playerid, 681.66, -453.32, -25.61);
		    SendClientMessage(playerid, COLOR_WHITE, "Welcome to Cocktail bar!");
		    dini_FloatSet(file, "X_ENTER", gBeforeEnterX[playerid]);
			dini_FloatSet(file, "Y_ENTER", gBeforeEnterY[playerid]);
			dini_FloatSet(file, "Z_ENTER", gBeforeEnterZ[playerid]);
		}
		else if(PlayerToPoint(3.0, playerid, JIZZY))
		{
			SetPlayerInterior(playerid, 3);
			SetPlayerPos(playerid, -2637.69, 1404.24, 906.46);
			SendClientMessage(playerid, COLOR_WHITE, "Welcome to Jizzy's Bar!");
			dini_FloatSet(file, "X_ENTER", gBeforeEnterX[playerid]);
			dini_FloatSet(file, "Y_ENTER", gBeforeEnterY[playerid]);
			dini_FloatSet(file, "Z_ENTER", gBeforeEnterZ[playerid]);
		}
		else if(PlayerToPoint(3.0, playerid, STACKEDPIZZA1))
		{
		    SetPlayerInterior(playerid, 5);
		    SetPlayerPos(playerid, 372.3520, -131.6510, 1001.4922);
		    SendClientMessage(playerid, COLOR_WHITE, "Welcome to Well Stacked Pizza!");
		    dini_FloatSet(file, "X_ENTER", gBeforeEnterX[playerid]);
			dini_FloatSet(file, "Y_ENTER", gBeforeEnterY[playerid]);
			dini_FloatSet(file, "Z_ENTER", gBeforeEnterZ[playerid]);
		}
		else if(PlayerToPoint(3.0, playerid, BURGERSHOT1) || PlayerToPoint(3.0, playerid, BURGERSHOT2) || PlayerToPoint(3.0, playerid, BURGERSHOT3))
		{
		    SetPlayerInterior(playerid, 10);
		    SetPlayerPos(playerid,  363.4129, -74.5786, 1001.5078);
		    SendClientMessage(playerid, COLOR_WHITE, "Welcome to Burger Shot!");
		    dini_FloatSet(file, "X_ENTER", gBeforeEnterX[playerid]);
			dini_FloatSet(file, "Y_ENTER", gBeforeEnterY[playerid]);
			dini_FloatSet(file, "Z_ENTER", gBeforeEnterZ[playerid]);
		}
		else if(PlayerToPoint(3.0, playerid, CLUCKINGBELL1) || PlayerToPoint(3.0, playerid, CLUCKINGBELL2))
		{
		    SetPlayerInterior(playerid, 9);
		    SetPlayerPos(playerid, 365.7158, -9.8873, 1001.8516);
			SendClientMessage(playerid, COLOR_WHITE, "Welcome to Well Clucking Bell!");
			dini_FloatSet(file, "X_ENTER", gBeforeEnterX[playerid]);
			dini_FloatSet(file, "Y_ENTER", gBeforeEnterY[playerid]);
			dini_FloatSet(file, "Z_ENTER", gBeforeEnterZ[playerid]);
		}
		else if(PlayerToPoint(3.0, playerid, DRIVINGSCHOOL))
		{
		    SetPlayerInterior(playerid, 3);
		    SetPlayerPos(playerid, -2028.1779,-105.1037,1035.1719);
		    SendClientMessage(playerid, COLOR_WHITE, "Welcome to driving school! You can get a license here!");
		    dini_FloatSet(file, "X_ENTER", gBeforeEnterX[playerid]);
		    dini_FloatSet(file, "Y_ENTER", gBeforeEnterX[playerid]);
			dini_FloatSet(file, "Z_ENTER", gBeforeEnterZ[playerid]);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: Be near a enter!");
		}
		return 1;
	}
	if(strcmp(cmd, "/exit", true) == 0)
	{
	    if(GetPlayerInterior(playerid) == 17 && PlayerToPoint(3.0, playerid, BankExit))
		{
		    SetPlayerInterior(playerid, 0);
		    SetPlayerPos(playerid, gBeforeEnterX[playerid], gBeforeEnterY[playerid], gBeforeEnterZ[playerid]);
			DisablePlayerCheckpoint(playerid);
		}
		else if(GetPlayerInterior(playerid) == 10 && PlayerToPoint(3.0, playerid, SFPDExit))
		{
		    SetPlayerInterior(playerid, 0);
		    SetPlayerPos(playerid, gBeforeEnterX[playerid], gBeforeEnterY[playerid], gBeforeEnterZ[playerid]);
		    DisablePlayerCheckpoint(playerid);
		}
		else if(GetPlayerInterior(playerid) == 10 && PlayerToPoint(2.0, playerid, 363.5669,-74.7354,1001.5078))
		{
		    SetPlayerInterior(playerid, 0);
		    SetPlayerPos(playerid, gBeforeEnterX[playerid], gBeforeEnterY[playerid], gBeforeEnterZ[playerid]);
		    DisablePlayerCheckpoint(playerid);
		}
		else if(GetPlayerInterior(playerid) == 10 && PlayerToPoint(2.0, playerid, 365.7158, -9.8873, 1001.8516))
		{
		    SetPlayerInterior(playerid, 0);
		    SetPlayerPos(playerid, gBeforeEnterX[playerid], gBeforeEnterY[playerid], gBeforeEnterZ[playerid]);
		    DisablePlayerCheckpoint(playerid);
		}
		else if(GetPlayerInterior(playerid) == 5 && PlayerToPoint(2.0, playerid, 372.2957,-133.1207,1001.4922))
		{
		    SetPlayerInterior(playerid, 0);
		    SetPlayerPos(playerid, gBeforeEnterX[playerid], gBeforeEnterY[playerid], gBeforeEnterZ[playerid]);
		    DisablePlayerCheckpoint(playerid);
		}
		else if(GetPlayerInterior(playerid) == 3 && PlayerToPoint(2.0, playerid, -2028.1779,-105.1037,1035.1719))
		{
		    SetPlayerInterior(playerid, 0);
		    SetPlayerPos(playerid, gBeforeEnterX[playerid], gBeforeEnterY[playerid], gBeforeEnterZ[playerid]);
			DisablePlayerCheckpoint(playerid);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: Be near a exit!");
		}
		return 1;
	}
	if(strcmp(cmd, "/help", true) == 0)
	{
	    SendClientMessage(playerid, COLOR_GREY, "SERVER: Choose your topic.");
	    SendClientMessage(playerid, COLOR_WHITE, "/accounthelp, /bankhelp");
	    SendClientMessage(playerid, COLOR_WHITE, "/cophelp");
	    return 1;
	}
	if(strcmp(cmd, "/bankhelp", true) == 0)
	{
	    SendClientMessage(playerid, COLOR_CYELLOW, " * BankHelp");
	    SendClientMessage(playerid, COLOR_WHITE, "There are 3 banks in San Fierro. 2 in DownTown district, one in West San Fierro");
	    SendClientMessage(playerid, COLOR_WHITE, "They are also marked on map with a \"$\" sign and a sign on ground.");
	    SendClientMessage(playerid, COLOR_WHITE, "Enter a bank with \"/enter\" command, then use menu to make your transitions");
	    SendClientMessage(playerid, COLOR_WHITE, "Menu will open when you walk into the red marker.");
	    return 1;
	}
	if(strcmp(cmd, "/cophelp", true) == 0)
	{
	    SendClientMessage(playerid, COLOR_CYELLOW, " * CopHelp");
	    SendClientMessage(playerid, COLOR_WHITE, "The SFPD is located in East San Fierro, ");
	    SendClientMessage(playerid, COLOR_WHITE, "You can become a police officer by going into SFPD and walking into red marker");
	    SendClientMessage(playerid, COLOR_WHITE, "A menu will come up & ask whether you want to go on or off-duty.");
	    SendClientMessage(playerid, COLOR_WHITE, "As a police officer, you can use following commands:");
	    SendClientMessage(playerid, COLOR_WHITE, "\"/suspect\", \"/unsuspect\", \"/suspects\", \"/jail\"");
	    return 1;
	}
	if(strcmp(cmd, "/suspect", true) == 0 || strcmp(cmd, "/su", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /suspect [ID] [REASON]");
		giveplayerid = strval(tmp);
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /suspect [ID] [REASON]");
		if(gTeam[playerid] != TEAM_COP)
		{
		    SendClientMessage(playerid, COLOR_WHITE, "You must be a police officer to use this command. Go on duty at SFPD");
			return 1;
		}
		if(gTeam[playerid] == TEAM_COP && gTeam[giveplayerid] == TEAM_COP)
		{
		    SendClientMessage(playerid, COLOR_WHITE, "You can't suspect a fellow officer!");
		    return 1;
		}
		if(gTeam[giveplayerid] == TEAM_CRIMINAL && gTeam[playerid] == TEAM_COP)
		{
		    SendClientMessage(playerid, COLOR_DBLUE, "HQ: Seems that player is already suspected.");
		    return 1;
		}
		if(IsPlayerConnected(giveplayerid))
		{
			if(gTeam[playerid] == TEAM_COP)
			{
				SetPlayerCriminal(giveplayerid, cmdtext[8]);
			}
		}
		else
		{
			format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
			SendClientMessage(playerid, COLOR_GREY, string);
		}
		return 1;
	}
	if(strcmp(cmd, "/unsuspect", true) == 0 || strcmp(cmd, "/unsu", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /suspect [ID]");
		giveplayerid = strval(tmp);
		if(gTeam[playerid] != TEAM_COP)
		{
		    SendClientMessage(playerid, COLOR_WHITE, "You must be a police officer to use this command. Go on duty at SFPD");
			return 1;
		}
		if(gTeam[playerid] == TEAM_COP && gTeam[giveplayerid] == TEAM_COP)
		{
		    SendClientMessage(playerid, COLOR_WHITE, "You can't un-suspect a fellow officer!");
		    return 1;
		}
		if(gTeam[giveplayerid] == TEAM_CIVILIAN && gTeam[playerid] == TEAM_COP)
		{
		    SendClientMessage(playerid, COLOR_DBLUE, "HQ: This person isn't suspected.");
			return 1;
		}
		if(IsPlayerConnected(giveplayerid))
		{
			if(gTeam[giveplayerid] == TEAM_CRIMINAL && gTeam[playerid] == TEAM_COP)
			{
			    new ClearReason[10] = "****";
				gSuspectReason[giveplayerid] = ClearReason[5];
				
				new SuspectName[24];
				GetPlayerName(giveplayerid, SuspectName, sizeof(SuspectName));
				format(string, sizeof(string), "SFPD: You have been unsuspected by officer %s", sendername);
				SendClientMessage(giveplayerid, COLOR_BLUE, string);
				SetPlayerColor(playerid, COLOR_WHITE);
				gTeam[giveplayerid] = TEAM_CIVILIAN;
			    return 1;
			}
		}
		else
		{
			format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
			SendClientMessage(playerid, COLOR_GREY, string);
		}
		return 1;
	}
	if(strcmp(cmd, "/jail", true) == 0)
	{
		new time;
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_GREY, "Usage: /ajail [id] [time]");
		giveplayerid = strval(tmp);

		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_GREY, "Usage: /ajail [id] [time]");
		time = strval(tmp);

		if(gTeam[playerid] != TEAM_COP) return SendClientMessage(playerid, COLOR_GREY, "You must be officer!");
		if(!PlayerToPoint(20.0, playerid, 216.9701, 119.5194, 999.0156))
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You and criminal must be near cells!");
		    return 1;
		}
		if(!PlayerToPoint(20.0, giveplayerid, 216.9701,119.5194,999.0156))
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You and criminal must be near cells!");
		    return 1;
		}
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		if(gLogged[playerid] == 1)
		{
		    if(PlayerInfo[playerid][pAdmin] >= 1)
		    {
		        if(gTeam[giveplayerid] != TEAM_CRIMINAL)
		        {
		            format(string, sizeof(string), "%s(%i) isn't a criminal!", giveplayer, giveplayerid);
		            SendClientMessage(playerid, COLOR_GREY, string);
				}
				format(string, sizeof(string), "SFPD: You've jailed %s(%i)", giveplayer, giveplayerid);
				SendClientMessage(playerid, COLOR_BLUE, string);
				format(string, sizeof(string), "SFPD: Officer %s(%i) has jailed you for %d seconds", sendername, playerid, time);
				SendClientMessage(playerid, COLOR_BLUE, string);
				format(string, sizeof(string), "~g~Jailed by ~r~%s", sendername);
				GameTextForPlayer(giveplayerid, string, 1000, 1);
				format(string, sizeof(string), "~b~Good job, ~n~~w~$1600!");
				GameTextForPlayer(playerid, string, 1000, 1);
				SetPlayerInterior(giveplayerid, 3);
				SetPlayerPos(giveplayerid, 197.6661,173.8179,1003.0234);
				SetPlayerArmour(giveplayerid, 0);
				ResetPlayerWeapons(giveplayerid);
				SetTimerEx("CUnjail", time*1000, 0, "i", giveplayerid);
			}
			else
			{
	            SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
	 			return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/wantedlevel", true) == 0 || strcmp(cmd, "/wanted", true) == 0 || strcmp(cmd, "/setwanted", true) == 0)
	{
		new Level;
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_GREY, "Usage: /wantedlevel [id] [level]");
		giveplayerid = strval(tmp);

		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_GREY, "Usage: /wantedlevel [id] [level]");
		Level = strval(tmp);

		if(Level >= 7) return SendClientMessage(playerid, COLOR_GREY, "Wrong usage: level from 0 to 6!");

		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));

  		if(gLogged[playerid] == 1)
  		{
  		    if(PlayerInfo[playerid][pAdmin] >= 3)
  		    {
  		        if(IsPlayerConnected(giveplayerid))
  		        {
					format(string, sizeof(string), "AdmCMD: You have set %s(%i)'s wanted level to %d", giveplayer, giveplayerid, Level);
					SendClientMessage(playerid, COLOR_BLUE, string);
					format(tmp, sizeof(tmp), "AdmCMD: %s(%i) has set Your wanted level to %d", sendername, playerid, Level);
					SendClientMessage(giveplayerid, COLOR_BLUE, string);
					SetPlayerWantedLevel(giveplayerid, Level);
				}
				else
				{
				    format(string, sizeof(string), "%d is not an active player.", giveplayerid);
					SendClientMessage(playerid, COLOR_RED, string);
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, "You do not have permission to use that command!");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, "You Must be logged in to use this command!");
		}
		return 1;
	}

	if(strcmp(cmd, "/setskin", true) == 0)
	{
	    new Skin;
        tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_GREY, "Usage: /setskin [id] [skin id]");
		giveplayerid = strval(tmp);

		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_GREY, "Usage: /setskin [id] [skin id]");
		Skin = strval(tmp);

		if(Skin >= 300) return SendClientMessage(playerid, COLOR_GREY, "Skins: 0 - 299");

		if(gLogged[playerid] == 0) return SendClientMessage(playerid, COLOR_RED, "You must be logged in to use this command!");
		if(PlayerInfo[playerid][pAdmin] >= 2)
		{
		    if(IsPlayerConnected(giveplayerid))
		    {
				format(string, sizeof(string), "AdmCMD: You have set %s(%i)'s skin to %d", sendername, playerid, Skin);
				SendClientMessage(playerid, COLOR_BLUE, string);
				SetPlayerSkin(giveplayerid, Skin);
			}
			else
			{
			    format(string, sizeof(string), "%d is not an active player.", giveplayerid);
				SendClientMessage(playerid, COLOR_RED, string);
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, "You Must be logged in to use this command!");
		}
		return 1;
	}
    if(strcmp(cmd, "/suspects", true) == 0)
	{
	    if(gTeam[playerid] != TEAM_COP) return SendClientMessage(playerid, COLOR_WHITE, "You must be a police officer to use this command. Go on duty at SFPD");
		new Suspect, CRIMINAL[24];
		SendClientMessage(playerid, COLOR_DBLUE, "HQ: Current Suspects:");
	    for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && gTeam[i] == TEAM_CRIMINAL)
			{
				GetPlayerName(i, CRIMINAL, sizeof(CRIMINAL));
				format(string, sizeof(string), "%s%s(%i)", string, CRIMINAL, i);

				Suspect ++;
				if(Suspect > 3)
				{
				    SendClientMessage(playerid, COLOR_DBLUE, string);
				    Suspect = 0;
					format(string, sizeof(string), "");
				}
				else
				{
					format(string, sizeof(string), "%s, ", string);
				}
			}
		}

		if(Suspect <= 3 && Suspect > 0)
		{
			string[strlen(string)-2] = '.';
		    SendClientMessage(playerid, COLOR_DBLUE, string);
		}
		return 1;
	}
   	if(strcmp(cmd, "/register", true) == 0)
	{
		gettime(Hour, Minute, Second);
		getdate(Year, Month, Day);
	    tmp = strtok(cmdtext, idx);
 		GetPlayerName(playerid, playername, sizeof(playername));
        if(14 < strlen(tmp) || strlen(tmp) < 4)
		{
			SendClientMessage(playerid, COLOR_RED, "Error! You must use a password: Longer than 3, Shorter than 14 characters.");
			return 1;
		}
	    if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /register [password]");
		}
		else
		{
			if(!dini_Exists(file))
			{
				TotalRegs += 1;
                dini_IntSet("/VirtualScriptingRP/Stats/registrations.cfg", "TotalREG", TotalRegs);
			    GetPlayerIp(playerid, playerip, sizeof(playerip));
				dini_Create(file);
				dini_IntSet(file, "HashPW", udb_hash(tmp));
				dini_Set(file,"RegPW", tmp);
				dini_IntSet(file,"AdminLevel", 0);
				dini_Set(file, "IP", playerip);
				dini_IntSet(file, "RegYear", Year);
				dini_IntSet(file, "RegMonth", Month);
				dini_IntSet(file, "RegDay", Day);
				dini_IntSet(file, "ReadTutorial", 0);
				dini_IntSet(file, "License", 0);
				dini_IntSet(file, "Passport", 0);
				dini_IntSet(file, "BankCash", 0);
				dini_IntSet(file, "UserID", TotalRegs);
				dini_IntSet(file, "Officer", 0);
				format(string, sizeof(string), "-AccServer- Account %s successfully registered (Password: %s) (UserID: %d)", sendername, tmp, TotalRegs);
				SendClientMessage(playerid, COLOR_BGREEN, string);
				format(string, sizeof(string), "-AccServer- Registration Date: %d/%d/%d (DD/MM/YY)", Day, Month, Year);
				SendClientMessage(playerid, COLOR_BGREEN, string);
				GameTextForPlayer(playerid, "~n~~n~~n~~g~Use ~w~/login~g~ now.", 3000, 3);
				PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
			}
			else
			{
				format(string, sizeof(string), "SERVER: \"%s\" is already registered on this server!", playername);
				SendClientMessage(playerid, COLOR_GREY, string);
			}
		}

		return 1;
	}
	if(strcmp(cmd, "/login", true) == 0)
	{
	    new PassportText[30], LicenseText[30], AdminText[40];
		if(gLogged[playerid] == 1)
		{
		    SendClientMessage(playerid, COLOR_RED, "You already are logged in!");
		    return 1;
		}
	    tmp = strtok(cmdtext, idx);
 		GetPlayerName(playerid, playername, sizeof(playername));
	    if(!strlen(tmp))
	    {
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /login [password]");
		}
		else
		{
			if(dini_Exists(file))
			{
				tmp2 = dini_Get(file, "HashPW");
			  	if(udb_hash(tmp) != strval(tmp2))
				{
	  			    GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
	  			    format(string, sizeof(string), "Error! You have specified the wrong password for %s", PlayerName);
	  			    SendClientMessage(playerid, COLOR_RED, string);
				}
				else
				{
					gLogged[playerid] = 1;
					dini_Set(file, "RegPW", tmp);
					GivePlayerMoney(playerid, dini_Int(file, "HandMoney"));
		            PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		            PlayerInfo[playerid][pRegDate] = dini_Int(file, "RegDay");
		            PlayerInfo[playerid][pRegMonth] = dini_Int(file, "RegMonth");
		   	        PlayerInfo[playerid][pRegYear] = dini_Int(file, "RegYear");
		   	        PlayerInfo[playerid][pTutorial] = dini_Int(file, "ReadTutorial");
		   	        PlayerInfo[playerid][pLicense] = dini_Int(file, "License");
		   	        PlayerInfo[playerid][pPassport] = dini_Int(file, "Passport");
		   	        PlayerInfo[playerid][pBankCash] = dini_Int(file, "BankCash");
		   	        PlayerInfo[playerid][pUserID] = dini_Int(file, "UserID");
		   	        PlayerInfo[playerid][pCop] = dini_Int(file, "Officer");
		   	        PlayerInfo[playerid][pSkin] = dini_Int(file, "Skin");
		   	        SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
		   	        gBeforeEnterX[playerid] = dini_Float(file, "X_ENTER");
					gBeforeEnterY[playerid] = dini_Float(file, "Y_ENTER");
					gBeforeEnterZ[playerid] = dini_Float(file, "Z_ENTER");
		   	        
					if(PlayerInfo[playerid][pPassport] == 1)
					{
					    format(PassportText, sizeof(PassportText), "Yes");
					}
					else
					{
					    format(PassportText, sizeof(PassportText), "No");
					}
					if(PlayerInfo[playerid][pLicense] == 1)
					{
					    format(LicenseText, sizeof(LicenseText), "Yes");
					}
					else
					{
					    format(LicenseText, sizeof(LicenseText), "No");
					}
					if(PlayerInfo[playerid][pAdmin] >= 1)
					{
						if(PlayerInfo[playerid][pAdmin] == 1) format(AdminText, sizeof(AdminText), "(Trial Moderator)");
						if(PlayerInfo[playerid][pAdmin] == 2) format(AdminText, sizeof(AdminText), "(Moderator)");
						if(PlayerInfo[playerid][pAdmin] == 3) format(AdminText, sizeof(AdminText), "(Administrator)");
						if(PlayerInfo[playerid][pAdmin] == 4) format(AdminText, sizeof(AdminText), "(Main Administrator)");
					}
					if(PlayerInfo[playerid][pAdmin] == 0)
					{
					    format(AdminText, sizeof(AdminText), "Regual RPG'er");
					}
					
		            GameTextForPlayer(playerid, "~b~Successfully logged in!",2000,1);
		            PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		            
		            if(PlayerInfo[playerid][pAdmin] == 0)
		            {
	  				   	format(string, sizeof(string), "SERVER: Logged in as %s.", AdminText);
	  				   	SendClientMessage(playerid, COLOR_WHITE, string);
	  				   	format(string, sizeof(string), "SERVER: Passport: %s. License: %s.", PassportText, LicenseText);
	  					SendClientMessage(playerid, COLOR_WHITE, string);
	  					format(string, sizeof(string), "SERVER: Money (in hand): $%d Money (in bank): $%d", GetPlayerMoney(playerid), PlayerInfo[playerid][pBankCash]);
	  					SendClientMessage(playerid, COLOR_WHITE, string);
					}
					if(PlayerInfo[playerid][pAdmin] >= 1)
				   	{
	  				   	format(string, sizeof(string), "SERVER: Logged in as level %s admin %s.", PlayerInfo[playerid][pAdmin], AdminText);
	  				   	SendClientMessage(playerid, COLOR_WHITE, string);
	  				   	format(string, sizeof(string), "SERVER: Passport: %s. License: %s.", PassportText, LicenseText);
	  					SendClientMessage(playerid, COLOR_WHITE, string);
	  					format(string, sizeof(string), "SERVER: Money (in hand): $%d Money (in bank): $%d", GetPlayerMoney(playerid), PlayerInfo[playerid][pBankCash]);
	  					SendClientMessage(playerid, COLOR_WHITE, string);
					}
					return 1;
				}
			}
			else
			{
			    format(string, sizeof(string), "The account %s, does not exist on this server. Please type /register [password] to create an account.", playername);
				SendClientMessage(playerid, COLOR_RED, string);
			}
		}

		return 1;
	}
// === [Adminhelp] ===
	if(strcmp(cmd, "/adminhelp", true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
	    if(gLogged[playerid] == 1)
	    {
		    if(PlayerInfo[playerid][pAdmin] >= 1)
		    {
				if(PlayerInfo[playerid][pAdmin] == 1)
				{
					SendClientMessage(playerid, COLOR_RED, ">>-+== Level 1 Admin commands =====================================================================================");
					SendClientMessage(playerid, COLOR_YELLOW, Level1Commands1);
					SendClientMessage(playerid, COLOR_YELLOW, Level1Commands2);
				}
				if(PlayerInfo[playerid][pAdmin] == 2)
				{
				    SendClientMessage(playerid, COLOR_RED, ">>-+== Level 2 Admin commands =====================================================================================");
			 		SendClientMessage(playerid, COLOR_YELLOW, Level1Commands1);
					SendClientMessage(playerid, COLOR_YELLOW, Level1Commands2);
					SendClientMessage(playerid, COLOR_YELLOW, Level2Commands1);
					SendClientMessage(playerid, COLOR_YELLOW, Level2Commands2);
				}
				if(PlayerInfo[playerid][pAdmin] == 3)
				{
				    SendClientMessage(playerid, COLOR_RED, ">>-+== Level 3 Admin commands =====================================================================================");
					SendClientMessage(playerid, COLOR_YELLOW, Level1Commands1);
					SendClientMessage(playerid, COLOR_YELLOW, Level1Commands2);
					SendClientMessage(playerid, COLOR_YELLOW, Level2Commands1);
					SendClientMessage(playerid, COLOR_YELLOW, Level2Commands2);
					SendClientMessage(playerid, COLOR_YELLOW, Level3Commands1);
					SendClientMessage(playerid, COLOR_YELLOW, Level3Commands2);
				}
				if(PlayerInfo[playerid][pAdmin] == 4)
				{
				    SendClientMessage(playerid, COLOR_RED, ">>-+== Level 4 Admin commands =====================================================================================");
				    SendClientMessage(playerid, COLOR_YELLOW, Level1Commands1);
					SendClientMessage(playerid, COLOR_YELLOW, Level1Commands2);
					SendClientMessage(playerid, COLOR_YELLOW, Level2Commands1);
					SendClientMessage(playerid, COLOR_YELLOW, Level2Commands2);
					SendClientMessage(playerid, COLOR_YELLOW, Level3Commands1);
					SendClientMessage(playerid, COLOR_YELLOW, Level3Commands2);
					SendClientMessage(playerid, COLOR_YELLOW, Level4Commands1);
				}
				return 1;
			}
			else
			{
	   			SendClientMessage(playerid, COLOR_RED, "You do not have permission to use that command!");
				return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
	}
	if(strcmp(cmd, "/time", true) == 0 || strcmp(cmd, "/settime", true) == 0)
	{
	    new time;
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_GREY, "Usage: /time [time]");
		time = strval(tmp);
		if(time >= 25) return SendClientMessage(playerid, COLOR_GREY, "Time from 0 to 23!");
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 3)
			{
				SetWorldTime(time);
				format(string, sizeof(string), "AdmCMD: %s(%i) has changed time to %d", sendername, playerid, time);
				SendClientMessageToAll(COLOR_BLUE, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, "You do not have permission to use that command!");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, "You Must be logged in to use this command!");
		}
		return 1;
	}
// === [Explode] ===
	if(strcmp(cmd, "/explode", true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /explode [playerid]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 3)
			{
			    if(IsPlayerConnected(giveplayerid))
			    {
					format(string, sizeof(string), "AdmCMD: %s was exploded by %s",giveplayer, sendername);
					SendClientMessageToAll(COLOR_CRED, string);
					SetPlayerHealth(giveplayerid, 10);
					new Float:boomx, Float:boomy, Float:boomz;
					GetPlayerPos(giveplayerid,boomx, boomy, boomz);
					CreateExplosion(boomx, boomy , boomz + 3, 7, 10);
				}
				else
				{
				    format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
					SendClientMessage(playerid, COLOR_GREY, string);
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === [Asay] ===
	if(strcmp(cmd, "/asay", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		new length = strlen(cmdtext);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result) && PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /asay [text]");
			return 1;
		}
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 1)
			{
				format(string, sizeof(string), "Admin %s: %s", sendername, result);
				SendClientMessageToAll(COLOR_CRED,string);
	     	}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
				return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === [Goto] ===
 	if(strcmp(cmd, "/goto", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
	    PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /goto [playerid]");
			return 1;
		}
		new Float:plocx,Float:plocy,Float:plocz;
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 2)
			{
				if(IsPlayerConnected(giveplayerid))
				{
				    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "AdmCMD: You teleported Yourself to %s(%i)", giveplayer, giveplayerid);
					SendClientMessage(playerid, COLOR_CRED, string);
					GetPlayerPos(giveplayerid, plocx, plocy, plocz);
					new intid = GetPlayerInterior(giveplayerid);
					SetPlayerInterior(playerid,intid);
					if (GetPlayerState(playerid) == 2)
					{
						new tmpcar = GetPlayerVehicleID(playerid);
						SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
					}
					else
					{
							SetPlayerPos(playerid,plocx,plocy+2, plocz);
					}
				}
				else
				{
				    format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
					SendClientMessage(playerid, COLOR_GREY, string);
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === [Gethere] ===
	if(strcmp(cmd, "/gethere", true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /gethere [playerid]");
			return 1;
		}
		new Float:plocx,Float:plocy,Float:plocz;
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 2)
			{
			    if(IsPlayerConnected(giveplayerid))
			    {
				    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "AdmCMD: You were teleported to %s(%i)",sendername,playerid);
					SendClientMessage(giveplayerid, COLOR_CRED, string);
					format(string, sizeof(string), "AdmCMD: You teleported %s(%i) to Yourself", giveplayer, giveplayerid);
					SendClientMessage(playerid, COLOR_CRED, string);
					GetPlayerPos(playerid, plocx, plocy, plocz);
					new intid = GetPlayerInterior(playerid);
					SetPlayerInterior(giveplayerid,intid);
					if (GetPlayerState(giveplayerid) == 2)
					{
						new tmpcar = GetPlayerVehicleID(giveplayerid);
						SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
					}
					else
					{
							SetPlayerPos(giveplayerid,plocx,plocy+2, plocz);
					}
				}
				else
				{
	                format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
					SendClientMessage(playerid, COLOR_GREY, string);
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
            SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === {Getall] ===
	if(strcmp(cmd, "/getallhere", true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
	    if(gLogged[playerid] == 0)
	    {
	        SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 3)
			{
			    for(new i = 0; i < MAX_PLAYERS; i ++)
			    {
			        if(IsPlayerConnected(i))
			        {
						format(string, sizeof(string), "AdmCMD: %s has teleported everyone to himself", sendername);
						SendClientMessage(i, COLOR_CRED, string);
						new Float:ix, Float:iy, Float:iz;
						GetPlayerPos(playerid, ix, iy, iz);
						SetPlayerInterior(i, GetPlayerInterior(playerid));
						SetPlayerPos(i, ix, iy, iz+1);
					}
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === [Time] ===
	if(strcmp(cmd, "/time", true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /time [0-23]");
			return 1;
		}
		new time;
		time = strval(tmp);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 3)
			{
			    if(time > 23)
				{
					SendClientMessage(playerid, COLOR_RED, "Invalid time! 0 - 23!");
				}
				else
				{
		            SetWorldTime(time);
					format(string, sizeof(string), "AdmCMD: Admin %s set the time to: %d",sendername,time);
					SendClientMessageToAll(COLOR_CRED, string);
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === [Weather] ===
	if(strcmp(cmd, "/weather", true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
		PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /weather [weather]");
			SendClientMessage(playerid, COLOR_DBLUE, "Weather IDs: /weatherids");
			return 1;
		}
		if(gLogged[playerid] == 0)
		{
			SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		new weather;
		weather = strval(tmp);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 3)
			{
	            SetWeather(weather);
				format(string, sizeof(string), "AdmCMD: Admin %s set the weather to: %d",sendername,weather);
				SendClientMessageToAll(COLOR_CRED, string);
				SendClientMessage(playerid, COLOR_DBLUE, "See wheater IDs at: /weatherids");
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === [Weatherids] ===
 	if(strcmp(cmd, "/weatherids", true) == 0 || strcmp(cmd, "/weathers", true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
		PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			SendClientMessage(playerid, COLOR_RED, ">>+-=================================== [Weather Ids: ] ================================");
			SendClientMessage(playerid, COLOR_YELLOW, ">>| 1 - Blue | 2 - Lighter Blue | 3 - Light (No color) | 4 - Even more lighter");
			SendClientMessage(playerid, COLOR_YELLOW, ">>| 5 - Normal Sun | 7 - (My PC = Beeped) | 8 - Rainy | 9 - Foggy | 10 - Standard weather");
			SendClientMessage(playerid, COLOR_YELLOW, ">>| 12 - Colourless, with alittle fog | 13 - Less foggy  | 15 - Little fog ");
			SendClientMessage(playerid, COLOR_YELLOW, ">>| 16 - Rainy | 17 - Hot | 19 - Sandstorm | 20 - Dark | 21 - Some very wierd weather ");
			SendClientMessage(playerid, COLOR_YELLOW, ">>| 23 - Atmosphere style (?) | 25 - Abit foggy | 27 - Abit \"White\" | 30 - Thunderstorm ");
			SendClientMessage(playerid, COLOR_YELLOW, ">>| 32 - Foggy | 33 - Hot | 35 - City weather | 37 - Warm | 38 - Even more city weather ");
			SendClientMessage(playerid, COLOR_YELLOW, ">>| 39 - Industrial weather | 40 - Yellow weather | 42 - Black fog | 43 - Industrial fog ");
			SendClientMessage(playerid, COLOR_YELLOW, ">>| 44 & 45 - Some wierd weather. -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+- (c) IDs by PaoloP");
			SendClientMessage(playerid, COLOR_RED, ">>+-====================================================================================");
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
		}
		return 1;
	}
	if(strcmp(cmd,"/report",true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		GetPlayerName(giveplayerid, giveplayer, sizeof(sendername));
		if(!strlen(tmp))
		{
			SendClientMessage(playerid,COLOR_DBLUE,"Correct Usage: /report [id] [reason]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if(IsPlayerConnected(giveplayerid))
		{
		    if(PlayerInfo[giveplayerid][pAdmin] == 0)
		    {
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' ')) {
				idx++;
				}
				new offset = idx;
				new result[64];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))) {
				result[idx - offset] = cmdtext[idx];
				idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result))
				{
					SendClientMessage(playerid,COLOR_WHITE,"SERVER: /report [id] [reason]");
					return 1;
				}
				GetPlayerName(giveplayerid, giveplayer, sizeof(sendername));
				format(string,sizeof(string),"AdmReport: Report on %s(%i) by %s(%i). Reason: \"%s\"", giveplayer, giveplayerid, sendername, playerid,result);
				for(new i=0;i<MAX_PLAYERS;i++)
				{
					if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] >= 1)
					{
						SendClientMessage(i,COLOR_RED,string);
					}
				}
			}
		}
		else
		{
			format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
			SendClientMessage(playerid, COLOR_GREY, string);
		}
		return 1;
	}
// === [Slap] ===
 	if(strcmp(cmd, "/slap", true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /slap [playerid]");
			return 1;
		}
		new Float:health;
		new Float:plX, Float:plY, Float:plZ;
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 1)
			{
			    if(IsPlayerConnected(giveplayerid))
			    {
					GetPlayerHealth(giveplayerid, health);
					SetPlayerHealth(giveplayerid, health-5);
					GetPlayerPos(giveplayerid, plX, plY, plZ);
					SetPlayerPos(giveplayerid, plX, plY, plZ+5);
					SetCameraBehindPlayer(giveplayerid);
					format(string, sizeof(string), "AdmCMD: %s was slapped by %s",giveplayer, sendername);
					SendClientMessageToAll(COLOR_CRED, string);
				}
				else
				{
				    format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
					SendClientMessage(playerid, COLOR_GREY, string);
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === [Reloadbans] ===
	if(strcmp(cmd,"/reloadbans",true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		if(gLogged[playerid] == 1)
		{
		    if(PlayerInfo[playerid][pAdmin] == 4)
		    {
				SendClientMessage(playerid, COLOR_RED, "You have successfully re-loaded bans!");
				SendRconCommand("reloadbans");
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === [Reloadlogs] ===
	if(strcmp(cmd,"/reloadlogs",true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] == 4)
			{
				SendRconCommand("reloadlogs");
				SendClientMessage(playerid, COLOR_RED, "You have successfully re-loaded logs!");
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === [Giveweapon] ===
    if(strcmp(cmd,"/giveweapon",true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		new weaponid;
		new giveammo;
		tmp = strtok(cmdtext, idx);
		if(gLogged[playerid] == 0)
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_DBLUE,"Correct Usage: /giveweapon [id] [weaponid] [ammo]");
			return 1;
		}
        if(IsStringAName(tmp))
		{
		    giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_DBLUE,"Correct Usage: /giveweapon [id] [weaponid] [ammo]");
			return 1;
		}
		weaponid = strval(tmp);
		if(weaponid < 0 || weaponid > 46)
		{
		    SendClientMessage(playerid, COLOR_RED, "ERROR: Invalid weapon ID.");
		    return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			giveammo = 100000;
		}
		giveammo = strval(tmp);
		if(giveammo < 0 || giveammo > 100000)
		{
		    SendClientMessage(playerid, COLOR_RED, "ERROR: Invalid ammo.");
		    return 1;
		}
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 3)
			{
			    if(IsPlayerConnected(giveplayerid))
			    {
					GivePlayerWeapon(giveplayerid, weaponid, giveammo);
					GetPlayerName(playerid, sendername, sizeof(sendername));
					new weaponname[20];
					GetWeaponName(weaponid, weaponname, sizeof(weaponname));
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					format(string,sizeof(string),"AdmCMD: You gave %s \"%s\" with %d ammo",giveplayer, weaponname, giveammo);
					SendClientMessage(playerid, COLOR_CRED, string);
					format(string,sizeof(string),"AdmCMD: Admin %s gave you \"%s\" with %d ammo",sendername, weaponname, giveammo);
					SendClientMessage(giveplayerid, COLOR_CRED, string);
				}
				else
				{
				    format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
					SendClientMessage(playerid, COLOR_GREY, string);
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
            SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
	
	if(strcmp(cmd, "/eject", true) == 0)
	{
	    PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid,COLOR_DBLUE,"Correct Usage: /eject [playerid]");
			return 1;
		}
		giveplayerid = strval(tmp);
		GetPlayerName(playerid, sendername, sizeof(sendername));
	    GetPlayerName(giveplayerid, giveplayer, sizeof(sendername));
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 2)
			{
				if(IsPlayerConnected(giveplayerid))
				{
				    if(playerid != giveplayerid)
				    {
					    if(IsPlayerInAnyVehicle(giveplayerid))
					    {
					        RemovePlayerFromVehicle(giveplayerid);
					        format(string, sizeof(string), "Administrator %s has ejected You!", sendername);
					        SendClientMessage(giveplayerid, COLOR_RED, string);
					        format(string, sizeof(string), "AdmCMD: %s has been ejected by %s", giveplayer, sendername);
					        SendClientMessageToAll(COLOR_BLUE, string);
					        return 1;
						}
						else
						{
							format(string, sizeof(string), "Error! %s isn't in a vehicle!");
							SendClientMessage(playerid, COLOR_RED, string);
							return 1;
						}
					}
					else if(playerid == giveplayerid)
					{
					    if(IsPlayerInAnyVehicle(playerid))
					    {
					        RemovePlayerFromVehicle(playerid);
					        SendClientMessage(playerid, COLOR_RED, "You have ejected yourself!");
					        format(string, sizeof(string), "AdmCMD: %s has been ejected by %s", giveplayer, sendername);
					        SendClientMessageToAll(COLOR_BLUE, string);
					        return 1;
						}
						else
						{
							SendClientMessage(playerid, COLOR_RED, "Error! You aren't in a vehicle!");
							return 1;
						}
					}
				}
				else
				{
				    format(string, sizeof(string), "%d is not an active player.", giveplayerid);
					SendClientMessage(playerid, COLOR_RED, string);
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_RED, "You do not have permission to use that command!");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, "You Must be logged in to use this command!");
		}

		return 1;
	}
	
	if(strcmp(cmd, "/flip", true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /flip [playerid]");
	    giveplayerid = strval(tmp);
		if(gLogged[playerid] == 1)
		{
		    if(PlayerInfo[playerid][pAdmin] >= 1)
		    {
		        if(IsPlayerConnected(giveplayerid))
		        {
		            if(IsPlayerInAnyVehicle(giveplayerid))
		            {
		                new Float:X, Float:Y, Float:Z;
						SetCameraBehindPlayer(giveplayerid);
						GetPlayerPos(giveplayerid, X, Y, Z);
		                SetVehiclePos(GetPlayerVehicleID(giveplayerid), X, Y, Z);
		                SetVehicleZAngle(GetPlayerVehicleID(giveplayerid), 0);
					}
					else
					{
					    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					    format(string, sizeof(string), "Error! %s(%i) isn't in a vehicle!", giveplayer, giveplayerid);
					    SendClientMessage(playerid, COLOR_GREY, string);
					}
				}
				else
				{
				    format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
					SendClientMessage(playerid, COLOR_GREY, string);
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
	if(strcmp(cmd,"/skick",true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
	    tmp = strtok(cmdtext, idx);
	    GetPlayerName(playerid, sendername, sizeof(sendername));
		if(!strlen(tmp))
		{
			SendClientMessage(playerid,COLOR_CRED, "Correct Usage: /skick [id] [reason]");
			return 1;
		}
        giveplayerid = strval(tmp);
		giveplayerid = strval(tmp);
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 1)
			{
				if(IsPlayerConnected(giveplayerid))
				{
					new length = strlen(cmdtext);
					while ((idx < length) && (cmdtext[idx] <= ' ')) {
					idx++;
					}
					new offset = idx;
					new result[64];
					while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))) {
					result[idx - offset] = cmdtext[idx];
					idx++;
					}
					result[idx - offset] = EOS;
					if(!strlen(result))
					{
						result = "No reason";
					}
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					Kick(giveplayerid);
				}
				else
				{
				    format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
					SendClientMessage(playerid, COLOR_GREY, string);
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
	if(strcmp(cmd,"/sban",true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /sban [id] [reason]");
			return 1;
		}
		giveplayerid = strval(tmp);
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 2)
			{
				if(IsPlayerConnected(giveplayerid))
				{
					new length = strlen(cmdtext);
					while ((idx < length) && (cmdtext[idx] <= ' ')) {
					idx++;
					}
					new offset = idx;
					new result[64];
					while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))) {
					result[idx - offset] = cmdtext[idx];
					idx++;
					}
					result[idx - offset] = EOS;
					if(!strlen(result))
					{
						result = "No reason";
					}
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					BanEx(giveplayerid, result);
				}
				else
				{
				    format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
					SendClientMessage(playerid, COLOR_GREY, string);
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
				return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/fix", true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		if(gLogged[playerid] == 1)
		{
		    if(PlayerInfo[playerid][pAdmin] >= 1)
			{
   				if(IsPlayerInAnyVehicle(playerid))
   				{
					SetVehicleHealth(GetPlayerVehicleID(playerid), 1000);
				}
				else
				{
				   	SendClientMessage(playerid, COLOR_RED, "You must be in a vehicle!");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === [Sethealth] ===
	if(strcmp(cmd,"/sethealth",true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		new health;
		GetPlayerName(playerid, sendername, sizeof(sendername));
		GetPlayerName(giveplayerid, giveplayer,sizeof(giveplayer));
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid,COLOR_DBLUE,"Correct Usage: /sethealth [id] [health]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
		    giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid,COLOR_DBLUE,"Correct Usage: /sethealth [id] [health]");
			return 1;
		}
		health = strval(tmp);
		if(health < 0 || health > 100)
		{
		    SendClientMessage(playerid,COLOR_RED,"ERROR: Invalid health.");
		    return 1;
		}
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 2)
			{
				if(IsPlayerConnected(giveplayerid))
				{
				    GetPlayerName(giveplayerid, giveplayer,sizeof(giveplayer));
	    			SetPlayerHealth(giveplayerid,health);
					format(string,sizeof(string),"AdmCMD: You have been set %s 's health to %d",giveplayer, health);
					SendClientMessage(playerid,COLOR_RED,string);
					format(string,sizeof(string),"AdmCMD: Admin %s set your health to %d",sendername, health);
					SendClientMessage(giveplayerid,COLOR_RED,string);
				}
				else
				{
				    format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
					SendClientMessage(playerid, COLOR_GREY, string);
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === [Playerinfo] ===
	if(strcmp(cmd, "/playerinfo", true) == 0 || strcmp(cmd, "/stats", true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /playerinfo [playerid]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if(gLogged[playerid] == 0)
		{
			SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 1)
			{
				if(IsPlayerConnected(giveplayerid))
				{
				    new Float:health;
				    new Float:armour;
					new intr = GetPlayerInterior(giveplayerid);
					GetPlayerHealth(giveplayerid,health);
					GetPlayerArmour(giveplayerid,armour);
					new playerammo = GetPlayerAmmo(giveplayerid);
					new score = GetPlayerScore(giveplayerid);
					new skin = GetPlayerSkin(giveplayerid);
					new money = GetPlayerMoney(giveplayerid);
					GetPlayerIp(giveplayerid, playerip, sizeof(playerip));
					new ping = GetPlayerPing(giveplayerid);
					if(gLogged[giveplayerid] == 0)
					{
						format(string, sizeof(string),"Information on player %s (ID: %i)(Player isn't logged in) :",giveplayer, giveplayerid);
						SendClientMessage(playerid, COLOR_CRED, string);
					}
					else
					{
						format(string, sizeof(string),"Information on player %s (ID: %i) :",giveplayer, giveplayerid);
						SendClientMessage(playerid, COLOR_CRED, string);
					}
					format(string, sizeof(string), "Health [%.1f] | Armour [%.1f] | Money [%d] | Interior [%d] | IP [%s]",health, armour, money, intr,playerip);
					SendClientMessage(playerid, COLOR_RED,string);
					format(string, sizeof(string), "Ammo [%d] | Score[%d] | Skin [%d] | Ping [%d] | Times Warned: %d",playerammo, score, skin, ping, gWarned[giveplayerid]);
					SendClientMessage(playerid, COLOR_RED,string);
				}
				else
				{
				    format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
					SendClientMessage(playerid, COLOR_GREY, string);
				}
			}
			else
			{
	            SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
	            return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/restart", true) == 0 || strcmp(cmd, "/gmx", true) == 0)
	{
		if(gLogged[playerid] == 1)
		{
		    if(PlayerInfo[playerid][pAdmin] == 4)
		    {
      			for(new i = 0; i < MAX_PLAYERS; i++)
				{
				    SetPlayerColor(i, COLOR_YELLOW);
					ResetPlayerMoney(i);
					GivePlayerMoney(i, 1337);
				}
		        format(string, sizeof(string), "AdmCMD: %s has restarted the server, please wait");
		        SendClientMessageToAll(COLOR_RED, string);
		        SetTimerEx("Restart", 5000, 0, "i", playerid);
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === [IP] ===
	if(strcmp(cmd, "/ip", true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
	    tmp = strtok(cmdtext, idx);
		if(!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /ip [playerid]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 1)
			{
			    if(IsPlayerConnected(giveplayerid))
			    {
					GetPlayerIp(giveplayerid, playerip, sizeof(playerip));
					format(string, sizeof(string),"AdmCMD: Checked IP on %s(%i): %s ",giveplayer, giveplayerid, playerip);
					SendClientMessage(playerid, COLOR_CRED, string);
				}
				else
				{
				    format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
					SendClientMessage(playerid, COLOR_GREY, string);
				}
			}
			else
			{
	            SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
	            return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === [Givemoney] ===
	if(strcmp(cmd, "/givemoney", true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 3)
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /givemoney [playerid] [amount]");
			return 1;
		}
		new money;
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if(gLogged[playerid] == 0)
		{
			SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		money = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 3)
			{
				GivePlayerMoney(giveplayerid, money);
				format(string, sizeof(string), "AdmCMD: You sent %s(%i) $%d", giveplayer,giveplayerid, money);
				SendClientMessage(playerid,COLOR_CRED, string);
				format(string, sizeof(string), "AdmCMD: You received $%d from Admin %s", money,sendername);
				SendClientMessage(giveplayerid,COLOR_CRED, string);
			}
			else
			{
	            SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
	 			return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/healall", true) == 0)
	{
	    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(gLogged[playerid] == 1)
		{
		    if(PlayerInfo[playerid][pAdmin] >= 2)
			{
			    for(new i = 0; i < MAX_PLAYERS; i++)
				{
				    SetPlayerHealth(i, 100);
				    format(string, sizeof(string), "AdmCMD: Admin %s has healed everyone.", sendername);
				    SendClientMessage(i, COLOR_CRED, string);
				    GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
				    printf("[Command] %s has used /healall to heal everyone", PlayerName);
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/armourall", true) == 0)
	{
	    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(gLogged[playerid] == 1)
		{
		    if(PlayerInfo[playerid][pAdmin] >= 2)
			{
			    for(new i = 0; i < MAX_PLAYERS; i++)
				{
				    SetPlayerArmour(i, 100);
				    format(string, sizeof(string), "AdmCMD: Admin %s has armoured everyone.", sendername);
				    SendClientMessage(i, COLOR_CRED, string);
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/ajail", true) == 0)
	{
		new time;
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_GREY, "Usage: /ajail [id] [time]");
		giveplayerid = strval(tmp);

		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_GREY, "Usage: /ajail [id] [time]");
		time = strval(tmp);

		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		if(gLogged[playerid] == 1)
		{
		    if(PlayerInfo[playerid][pAdmin] >= 1)
		    {
				format(string, sizeof(string), "AdmCMD: You've jailed %s(%i)", giveplayer, giveplayerid);
				SendClientMessage(playerid, COLOR_BLUE, string);
				format(string, sizeof(string), "AdmCMD: %s(%i) has jailed you for %d seconds", sendername, playerid, time);
				SendClientMessage(playerid, COLOR_BLUE, string);
				format(string, sizeof(string), "~g~Jailed by ~r~%s", sendername);
				GameTextForPlayer(giveplayerid, string, 1000, 1);
				SetPlayerInterior(giveplayerid, 3);
				new Float:bPosX, Float:bPosY, Float:bPosZ;
				GetPlayerPos(playerid, bPosX, bPosY, bPosZ);
				SetPlayerPos(giveplayerid, 197.6661,173.8179,1003.0234);
				SetPlayerArmour(giveplayerid, 0);
				TogglePlayerControllable(giveplayerid, 0);
				ResetPlayerWeapons(giveplayerid);
				SetTimerEx("Unjail", time*1000, 0, "ifff", giveplayerid);
			}
			else
			{
	            SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
	 			return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}

	if(strcmp(cmd, "/setmoney", true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 3)
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /setmoney [playerid] [amount]");
			return 1;
		}
		new money;
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if(gLogged[playerid] == 0)
		{
			SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		money = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 3)
			{
			    ResetPlayerMoney(giveplayerid);
				GivePlayerMoney(giveplayerid, money);
				format(string, sizeof(string), "AdmCMD: You set %s(%i)'s money to $%d", giveplayer,giveplayerid, money);
				SendClientMessage(playerid,COLOR_CRED, string);
				format(string, sizeof(string), "AdmCMD: Admin %s has set Your money to %d", sendername, money);
				SendClientMessage(giveplayerid,COLOR_CRED, string);
			}
			else
			{
	            SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
	 			return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === [Kick] ===
	if(strcmp(cmd,"/kick",true) == 0)
	{
	    tmp = strtok(cmdtext, idx);
	    GetPlayerName(playerid, sendername, sizeof(sendername));
		if(!strlen(tmp))
		{
			SendClientMessage(playerid,COLOR_CRED, "Correct Usage: /kick [id] [reason]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		giveplayerid = strval(tmp);
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 1)
			{
				if(IsPlayerConnected(giveplayerid))
				{
				    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					new length = strlen(cmdtext);
					while ((idx < length) && (cmdtext[idx] <= ' ')) {
					idx++;
					}
					new offset = idx;
					new result[64];
					while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))) {
					result[idx - offset] = cmdtext[idx];
					idx++;
					}
					result[idx - offset] = EOS;
					if(!strlen(result))
					{
						result = "No reason";
					}
					format(string, sizeof(string), "AdmCMD: %s was kicked by admin %s for: %s", giveplayer, sendername, result);
					SendClientMessageToAll(COLOR_CRED, string);
					Kick(giveplayerid);
				}
				else
				{
				    format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
					SendClientMessage(playerid, COLOR_GREY, string);
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/kickall", true) == 0)
	{
	    new reason;
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /kickall [reason]");
	    reason = strval(tmp);
		if(gLogged[playerid] == 1)
		{
		    if(PlayerInfo[playerid][pAdmin] >= 2)
		    {
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
				    if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] == 0)
				    {
				        format(string, sizeof(string), "AdmCMD: Admin %s(%i) has kicked everyone (Reason: %s)", sendername, playerid, reason);
				        SendClientMessage(i, COLOR_CRED, string);
				        Kick(i);
					}
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/banall", true) == 0)
	{
	    new reason;
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /bankall [reason]");
	    reason = strval(tmp);
		if(gLogged[playerid] == 1)
		{
		    if(PlayerInfo[playerid][pAdmin] >= 3)
		    {
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
				    if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] == 0)
				    {
				        format(string, sizeof(string), "AdmCMD: Admin %s(%i) has banned everyone (Reason: %s)", sendername, playerid, reason);
				        SendClientMessage(i, COLOR_CRED, string);
				        Ban(i);
					}
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}

// === [Warn] ===
	if(strcmp(cmd, "/warn", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		tmp2 = strtok(cmdtext, idx);

		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /warn [PlayerID] [Reason]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		giveplayerid = strval(tmp);
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 1)
			{
				if(gWarned[giveplayerid] == 0)
				{
					gWarned[giveplayerid]+=1;
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof (sendername));
					format(string, sizeof (string), "AdmCMD: %s was warned by %s for: %s [1/3 Warnings]", giveplayer, sendername, cmdtext[8]);
					SendClientMessageToAll(COLOR_CRED, string);
					print(string);
					return 1;
				}
				if(gWarned[giveplayerid] == 1)
				{
				    gWarned[giveplayerid]+=1;
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof (sendername));
					format(string, sizeof (string), "AdmCMD: %s was warned by %s for: %s [2/3 Warnings]", giveplayer, sendername, cmdtext[8]);
					SendClientMessageToAll(COLOR_CRED, string);
					print(string);
					return 1;
				}
				else if(gWarned[giveplayerid] == 2)
				{
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof (sendername));
					format(string, sizeof (string), "AdmCMD: %s was kicked by %s for: %s [3/3 Warnings]", giveplayer, sendername, cmdtext[8]);
					SendClientMessageToAll(COLOR_CRED, string);
					Kick(giveplayerid);
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
				return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
	}
// === [Freeze] ===
	if(strcmp(cmd, "/freeze", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
        if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 1)
			{
			    if(IsPlayerConnected(giveplayerid))
			    {
			        if(gFreeze[giveplayerid] == 1)
			        {
			            SendClientMessage(playerid, COLOR_RED, "The player is already frozen!");
			            return 1;
					}
					else
					{
				        gFreeze[giveplayerid] = 1;
						GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						TogglePlayerControllable(giveplayerid, 0);
						format(string, sizeof(string), "AdmCMD: %s was frozen by %s.",giveplayer, sendername);
						SendClientMessageToAll(COLOR_CRED, string);
						return 1;
					}
				}
				else
				{
				    format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
					SendClientMessage(playerid, COLOR_CRED, string);
				}
			}
			else
			{
	 			SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
	 			return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === [Unfreeze] ===
	if(strcmp(cmd, "/unfreeze", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
        if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if(!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /unfreeze [playerid]");
			return 1;
		}
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 1)
			{
			    if(IsPlayerConnected(giveplayerid))
			    {
			        if(gFreeze[giveplayerid] == 1)
			        {
		      			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						TogglePlayerControllable(giveplayerid, 1);
						gFreeze[giveplayerid] = 0;
						format(string, sizeof(string), "AdmCMD: %s was thawed by %s", giveplayer,sendername);
						SendClientMessageToAll(COLOR_CRED, string);
						return 1;
					}
					else
					{
					    SendClientMessage(playerid, COLOR_RED, "This player can't be thawed, he already is!");
					    return 1;
					}
				}
				else
				{
				    format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
					SendClientMessage(playerid, COLOR_GREY, string);
				}
			}
			else
			{
	 			SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
	 			return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === [Setadmin] ===
	if(strcmp(cmd, "/setadmin", true) == 0 || strcmp(cmd, "/setlevel", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		PlayerInfo[giveplayerid][pAdmin] = dini_Int(file, "AdminLevel");
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if(!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /setadmin [playerid] [level]");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /setadmin [playerid] [level]");
			return 1;
		}
		PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		gLevel[playerid] = strval(tmp);
		if(gLevel[playerid] < 0)
		{
			SendClientMessage(playerid, COLOR_RED, "Invalid Admin Level");
            return 1;
		}
		if(gLevel[playerid] > 4)
		{
			SendClientMessage(playerid, COLOR_RED, "Invalid Admin Level");
            return 1;
		}
		if(gLevel[playerid] == PlayerInfo[giveplayerid][pAdmin])
		{
            format(string, sizeof(string), "That player already has level %d admin privileges.", gLevel[playerid]);
            SendClientMessage(playerid, COLOR_CRED, string);
            return 1;
		}
		if(gLogged[playerid] == 1)
		{
			if(IsPlayerAdmin(playerid) || PlayerInfo[playerid][pAdmin] >= 3)
			{
			    if(IsPlayerConnected(giveplayerid))
			    {
			        if(gLogged[giveplayerid] == 0)
					{
						SendClientMessage(playerid, COLOR_RED, "The player You're setting rights to must be logged in!");
						return 1;
					}
					else
					{
					    if(giveplayerid != playerid)
					    {
							GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							GetPlayerName(playerid, sendername, sizeof(sendername));
							dini_IntSet(file, "AdminLevel", gLevel[playerid]);
							format(string, sizeof(string), "You have given %s level %d admin powers.", giveplayer, gLevel[playerid]);
							SendClientMessage(playerid, COLOR_CRED, string);
							format(string, sizeof(string), "You were made a level %d admin by %s (id: %d).", gLevel[playerid], sendername, playerid);
							SendClientMessage(giveplayerid, COLOR_CRED, string);
							PlayerInfo[giveplayerid][pAdmin] = dini_Int(file, "AdminLevel");
						}
						else
						{
							dini_IntSet(file, "AdminLevel", gLevel[playerid]);
							format(string, sizeof(string), "AdmCMD: You set your level to: %d", gLevel[playerid]);
							SendClientMessage(playerid, COLOR_CRED, string);
							PlayerInfo[giveplayerid][pAdmin] = dini_Int(file, "AdminLevel");
						}
					}
				}
				else
				{
				    format(string, sizeof(string), "%d is not an active player ID number.", giveplayerid);
	            	SendClientMessage(playerid, COLOR_GREY, string);
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === [Ban] ===
	if(strcmp(cmd,"/ban",true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /ban [id] [reason]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 2)
			{
				if(IsPlayerConnected(giveplayerid))
				{
					new length = strlen(cmdtext);
					while ((idx < length) && (cmdtext[idx] <= ' ')) {
					idx++;
					}
					new offset = idx;
					new result[64];
					while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))) {
					result[idx - offset] = cmdtext[idx];
					idx++;
					}
					result[idx - offset] = EOS;
					if(!strlen(result))
					{
						result = "No reason";
					}
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					format(string, sizeof(string), "AdmCMD: %s was banned by admin %s for: %s", giveplayer, sendername, result);
					SendClientMessageToAll(COLOR_CRED, string);
					BanEx(giveplayerid, result);
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
				}
			}
			else
			{
				format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
				SendClientMessage(playerid, COLOR_GREY, string);
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/jetpack", true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
	    if(gLogged[playerid] == 1)
	    {
	        if(PlayerInfo[playerid][pAdmin] >= 3)
	        {
	            SetPlayerSpecialAction(playerid, 2);
	            SendClientMessage(playerid, COLOR_CRED, "AdmCMD: You've created a jetpack!");
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
            SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === [Mute] ===
	if(strcmp(cmd, "/mute", true) == 0)
	{
	    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		tmp = strtok(cmdtext, idx);
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if(!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /mute [ID]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 1)
			{
				if(IsPlayerConnected(giveplayerid))
				{
					if(gMute[giveplayerid] == 0)
					{
						gMute[giveplayerid] = 1;
						format(string, sizeof(string), "AdmCMD: %s was muted by %s",giveplayer ,sendername);
						SendClientMessageToAll(COLOR_CRED, string);
					}
					else
					{
						gMute[giveplayerid] = 0;
						format(string, sizeof(string), "AdmCMD: %s was un-muted by %s",giveplayer ,sendername);
						SendClientMessageToAll(COLOR_CRED, string);
					}
				}
				else
				{
					format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
					SendClientMessage(playerid, COLOR_GREY, string);
				}
			}
			else
			{
	 			SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
	 			return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === [Announce] ===
	if(strcmp(cmd, "/announce", true) == 0 || strcmp(cmd, "/ann", true) == 0)
	{
        tmp = strtok(cmdtext, idx, strlen(cmdtext));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
 		if (!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 2)
  		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /announce [message]");
 			return 1;
      	}
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 2)
			{
	  			format(string, sizeof(string), "~w~%s", tmp);
				GameTextForAll(string, 5000, 3);
			}
	 		else
	  		{
	 			SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
        return 1;
	}
// === [CNN] ===
	if(strcmp(cmd, "/cnn", true) == 0)
	{
        tmp = strtok(cmdtext, idx, strlen(cmdtext));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
 		if (!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 2)
  		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /cnn [message]");
 			return 1;
      	}
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 2)
			{
	  			format(string, sizeof(string), "~b~%s~r~: ~w~%s", sendername, tmp);
				GameTextForAll(string, 5000, 3);
			}
	 		else
	  		{
				SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
        return 1;
	}
// === [Akill] ===
	if(strcmp(cmd, "/akill", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
        if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if(!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /akill [playerid]");
			return 1;
		}
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 1)
			{
			    if(IsPlayerConnected(giveplayerid))
			    {
			    	GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					SetPlayerHealth(giveplayerid, -999);
					format(string, sizeof(string), "AdmCMD: You have murdered %s.", giveplayer);
					SendClientMessage(playerid, COLOR_CRED, string);
					return 1;
				}
				else
				{
				    format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
					SendClientMessage(playerid, COLOR_GREY, string);
				}
			}
			else
			{
	 			SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
	 			return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
	}
	if(strcmp(cmd, "/akillall", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(gLogged[playerid] == 1)
		{
		    if(PlayerInfo[playerid][pAdmin] >= 2)
		    {
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
				    if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] == 0)
				    {
				        SetPlayerHealth(i, 0.0);
						format(string, sizeof(string), "AdmCMD: %s(%i) has killed everyone", sendername, playerid);
						SendClientMessage(i, COLOR_CRED, string);
					}
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}

// === [Admins] ===
	if(!strcmp(cmdtext, "/admins", true))
	{
	    SendClientMessage(playerid, COLOR_CRED, "Checking for administrators online...");
		new count=0;
		for(new i=0; i<MAX_PLAYERS; i++)
		{
	    	if(IsPlayerConnected(i))
	    	{
	    	    if(gLogged[i] == 1)
	    	    {
					if(PlayerInfo[i][pAdmin] >= 1)
					{
						new str[256];
						new pname[24];
						GetPlayerName(i, pname, 24);
						format(str, 256, "Administrator %s [Level %d] ", pname, PlayerInfo[i][pAdmin]);
						SendClientMessage(playerid, COLOR_RED, str);
						count++;
					}
				}
			}
		}
		if(count == 0)
		{
	    	SendClientMessage(playerid, COLOR_RED, "There aren't any administrators online on the server!");
		}
		return 1;
	}
// === [Tele] ===
	if(strcmp(cmd, "/tele", true) == 0)
	{
		new telename[MAX_PLAYER_NAME];
		new teleid;
		new Float:plX, Float:plY, Float:plZ;
		tmp = strtok(cmdtext, idx);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		if(PlayerInfo[playerid][pAdmin] == 0)
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
		    return 1;
		}
		if(!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessage(playerid, COLOR_DBLUE, "USAGE: /tele [teleportee id] [destination id]");
			return 1;
		}
		giveplayerid = strval(tmp);

		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessage(playerid, COLOR_DBLUE, "USAGE: /tele [teleportee id] [destination id]");
			return 1;
		}
 		teleid = strval(tmp);
 		if(gLogged[playerid] == 1)
 		{
	        if(PlayerInfo[playerid][pAdmin] == 2 || PlayerInfo[playerid][pAdmin] == 3  || PlayerInfo[playerid][pAdmin] == 4)
	        {
	            if(IsPlayerConnected(giveplayerid) && IsPlayerConnected(teleid))
	            {
	            	GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerName(teleid, telename, sizeof(telename));
					GetPlayerPos(teleid, plX,plY,plZ);
					SetPlayerPos(giveplayerid, plX,plY,plZ);
					format(string, sizeof(string), "AdmCMD: You teleported %s to %s.", giveplayer,telename);
					SendClientMessage(playerid, COLOR_CRED, string);
					format(string, sizeof(string), "AdmCMD: You have been teleported to %s by Admin %s.", telename,sendername);
					SendClientMessage(giveplayerid, COLOR_CRED, string);
					return 1;
				}
				else
				{
					if(!IsPlayerConnected(giveplayerid))
					{
						format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
						SendClientMessage(playerid, COLOR_GREY, string);
					}
					if(!IsPlayerConnected(teleid))
					{
						format(string, sizeof(string), "SERVER: %d isn't a active player ID!", teleid);
						SendClientMessage(playerid, COLOR_GREY, string);
					}
				}
			}
			else
			{
		 		SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/force", true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		tmp = strtok(cmdtext, idx);
		if	(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GREEN, "USAGE: /force [playerid]");
			return 1;
		}
		giveplayerid = strval(tmp);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		if(gLogged[playerid] == 1)
		{
		    if(PlayerInfo[playerid][pAdmin] >= 1)
		    {
		        if(IsPlayerConnected(giveplayerid))
		        {
					format(string, sizeof(string), "AdmCMD: You have forced %s(%i) to class selection", giveplayer, giveplayerid);
					SendClientMessage(playerid, COLOR_CRED, string);
					SetPlayerHealth(giveplayerid, 0.0);
					ForceClassSelection(giveplayerid);
					format(string, sizeof(string), "AdmCMD: %s(%i) has forced You to class selection", sendername, playerid);
					SendClientMessage(giveplayerid, COLOR_CRED, string);
				}
				else
				{
				    format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
					SendClientMessage(playerid, COLOR_GREY, string);
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
	if(strcmp(cmd,"/reloadbans",true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		if(gLogged[playerid] == 1)
		{
		    if(PlayerInfo[playerid][pAdmin] == 4)
		    {
				SendClientMessage(playerid, COLOR_RED, "You have successfully re-loaded bans!");
				SendRconCommand("reloadbans");
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/servername", true) == 0)
	{
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_DBLUE,"Correct Usage: /servername [new name]");
	    if(gLogged[playerid] == 1)
	    {
	        if(PlayerInfo[playerid][pAdmin] >= 4)
	        {
	            format(tmp,sizeof(tmp),"hostname %s",cmdtext[11]);
	            SendRconCommand(tmp);
	            GetPlayerName(playerid, sendername, sizeof(sendername));
	            format(string, sizeof(string), "AdmCMD: %s(%i) has changed server name to: %s",sendername, playerid, cmdtext[11]);
	            SendClientMessageToAll(COLOR_CRED,string);
	        }
	        else
	        {
	            SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
	        }
	    }
	    else
	    {
	        SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
	    }
	    return 1;
	}
	if(strcmp(cmd, "/mapname", true) == 0)
	{
	    tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_DBLUE,"Correct Usage: /mapname [new name]");
			return 1;
		}
		if(gLogged[playerid] == 1)
		{
		    if(PlayerInfo[playerid][pAdmin] >= 4)
		    {
				format(tmp,sizeof(tmp),"mapname %s",cmdtext[8]);
				SendRconCommand(tmp);
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "AdmCMD: %s(%i) has changed maps name to: %s",sendername, playerid, cmdtext[8]);
				SendClientMessageToAll(COLOR_CRED,string);
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/setname", true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		new tmpp[256];
		tmpp = strtok(cmdtext, idx);
		if(!strlen(tmpp))
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /setname [playerid] [new nick]");
			return 1;
		}
		giveplayerid = strval(tmpp);
		tmp = strtok(cmdtext, idx);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(gLogged[playerid] == 1)
		{
		    if(PlayerInfo[playerid][pAdmin] >= 3)
		    {
		        if(IsPlayerConnected(giveplayerid))
		        {
					SetPlayerName(giveplayerid, tmp);
					format(string, sizeof(string), "AdmCMD: %s(%i) has changed Your name to %s", sendername, playerid, tmp);
					SendClientMessage(giveplayerid, COLOR_CRED, string);
					format(string, sizeof(string), "AdmCMD: You have changed ID %i's name to %s", giveplayerid, tmp);
					SendClientMessage(playerid, COLOR_CRED, string);
				}
				else
				{
				    format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
					SendClientMessage(playerid, COLOR_GREY, string);
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
	  	return 1;
  	}
	if(strcmp(cmd,"/reloadlogs",true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] == 4)
			{
				SendRconCommand("reloadlogs");
				SendClientMessage(playerid, COLOR_RED, "You have successfully re-loaded logs!");
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/setarmour", true) == 0)
	{
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
		new armor;
		GetPlayerName(playerid, sendername, sizeof(sendername));
		GetPlayerName(giveplayerid, giveplayer,sizeof(giveplayer));
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid,COLOR_DBLUE,"Correct Usage: /setarmour [id] [armor]");
			return 1;
		}
		giveplayerid = strval(tmp);
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid,COLOR_DBLUE,"Correct Usage: /setarmour [id] [armor]");
			return 1;
		}
		armor = strval(tmp);
		if(armor < 0 || armor > 100)
		{
		    SendClientMessage(playerid,COLOR_RED,"ERROR: Invalid armor.");
		    return 1;
		}
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 2)
			{
				if(IsPlayerConnected(giveplayerid))
				{
	    			SetPlayerArmour(giveplayerid, armor);
	    			GetPlayerName(giveplayerid, giveplayer,sizeof(giveplayer));
					format(string,sizeof(string),"AdmCMD: You have been set %s 's armour to %d",giveplayer, armor);
					SendClientMessage(playerid,COLOR_RED,string);
					format(string,sizeof(string),"AdmCMD: Admin %s set your armour to %d",sendername, armor);
					SendClientMessage(giveplayerid,COLOR_RED,string);
				}
				else
				{
				    format(string, sizeof(string), "SERVER: %d isn't a active player ID!", giveplayerid);
					SendClientMessage(playerid, COLOR_GREY, string);
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/a", true) == 0 || strcmp(cmd, "/admin", true) == 0 || strcmp(cmd, "/achat", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /a [text] [admin chat]");
			return 1;
		}
		if(gLogged[playerid] == 1)
		{
			if(IsPlayerAdmin(playerid) || PlayerInfo[playerid][pAdmin] >= 1)
			{
				format(string, sizeof(string), "Admin %s(%i): %s", sendername, playerid, result);
    			for(new i = 0; i < MAX_PLAYERS; i ++)
				{
				    if(IsPlayerConnected(i))
				    {
				        if(PlayerInfo[i][pAdmin] >= 1)
				        {
				            SendClientMessage(i,COLOR_CRED, string);
						}
					}
				}
	            return 1;
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, "You aren't able to use administration chat!");
	            return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
	}
	if(strcmp(cmdtext, "/clearchat", true) == 0)
	{
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] == 1 || PlayerInfo[playerid][pAdmin] == 2 || PlayerInfo[playerid][pAdmin] == 3)
			{
				SendClientMessageToAll(COLOR_SYSTEM, " ");
				SendClientMessageToAll(COLOR_SYSTEM, " ");
				SendClientMessageToAll(COLOR_SYSTEM, " ");
				SendClientMessageToAll(COLOR_SYSTEM, " ");
				SendClientMessageToAll(COLOR_SYSTEM, " ");
				SendClientMessageToAll(COLOR_SYSTEM, " ");
				SendClientMessageToAll(COLOR_SYSTEM, " ");
				SendClientMessageToAll(COLOR_SYSTEM, " ");
				SendClientMessageToAll(COLOR_SYSTEM, " ");
				SendClientMessageToAll(COLOR_SYSTEM, " ");
				SendClientMessageToAll(COLOR_SYSTEM, " ");
				SendClientMessageToAll(COLOR_SYSTEM, " ");
				SendClientMessageToAll(COLOR_SYSTEM, " ");
				SendClientMessageToAll(COLOR_SYSTEM, " ");
				SendClientMessageToAll(COLOR_SYSTEM, " ");
				SendClientMessageToAll(COLOR_SYSTEM, " ");
				GameTextForAll("Chat cleared!", 1000,1);
				return 1;
			}
			else
			{
	 			SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
				return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
	}

// === [Disarm] ===
	if(strcmp(cmd, "/disarm", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
        if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if(!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessage(playerid, COLOR_DBLUE, "USAGE: /disarm [playerid]");
			return 1;
		}
		if(gLogged[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] >= 3)
			{
			    if(IsPlayerConnected(giveplayerid))
				{
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					ResetPlayerWeapons(giveplayerid);
					format(string, sizeof(string), "AdmCMD: Admin %s has disarmed %s.", sendername,giveplayer);
					SendClientMessageToAll(COLOR_CRED, string);
					format(string, sizeof(string), "AdmCMD: Admin %s disarmed you.", sendername);
					SendClientMessage(giveplayerid, COLOR_CRED, string);
				}
				else
				{
	   				format(string, sizeof(string), "%d is not an active player ID.", giveplayerid);
					SendClientMessage(playerid, COLOR_GREY, string);
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
				return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/disarmall", true) == 0)
	{
	    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(file, "AdminLevel");
        if(gLogged[playerid] == 1)
        {
			if(PlayerInfo[playerid][pAdmin] >= 3)
			{
			    for(new i = 0; i < MAX_PLAYERS; i ++)
				{
		  			if(IsPlayerConnected(i))
					{
						ResetPlayerWeapons(i);
						format(string, sizeof(string), "AdmCMD: Admin %s has disarmed everyone.", sendername);
						SendClientMessage(i, COLOR_CRED, string);
					}
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "SERVER: You don't have permission to use this command.");
				return 1;
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "SERVER: You must be logged in to use this command!");
		}
		return 1;
	}
// === [Animations] ===
	if(strcmp(cmd, "/animations", true) == 0 || strcmp(cmd, "/anims", true) == 0)
	{
	    SendClientMessage(playerid, COLOR_CYAN, "=============================== Animations ===============================");
	    SendClientMessage(playerid, COLOR_WHITE, "/phone, /handsup, /drunk, /bomb, /laugh, /chat, /slapass  /dance, /taichi, /bitchslap, /balls, /kiss");
        SendClientMessage(playerid, COLOR_WHITE, "/crossarms, /lay, /hide, /vomit, /eat, /wave, /deal, /crack, /smoke, /groundsit, /dead, /fucku, /robman");
        return 1;
	}
	if(strcmp(cmd, "/getarrested", true) == 0)
	{
	    if(gFreeze[playerid] == 0)
	    {
			LoopingAnim(playerid,"ped", "ARRESTgun", 4.0, 0, 1, 1, 1, -1);
			gLoopingAnim[playerid] = 1;
		}
		else
		{
 			SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
 			return 1;
		}
		return 1;
	}
    if(strcmp(cmd, "/robman", true) == 0)
	{
	    if(gFreeze[playerid] == 0)
	    {
			LoopingAnim(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0);
			gLoopingAnim[playerid] = 1;
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
		  	return 1;
		}
		return 1;
	}
	if(strcmp(cmd, "/fucku", true) == 0)
	{
	    if(gFreeze[playerid] == 0)
	    {
	 		OnePlayAnim(playerid,"PED","fucku",4.0,0,0,0,0,0);
	 		gLoopingAnim[playerid] = 1;
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
		}
		return 1;
	}
    if(strcmp(cmd, "/dead", true) == 0)
	{
	    if(gFreeze[playerid] == 0)
	    {
	 		LoopingAnim(playerid,"PED","dead",4.1,0,1,1,1,1);
	 		gLoopingAnim[playerid] = 1;
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
		}
		return 1;
	}
	if(strcmp(cmd, "/groundsit", true) == 0)
	{
	    if(gFreeze[playerid] == 0)
	    {
	 		LoopingAnim(playerid,"BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0);
	 		gLoopingAnim[playerid] = 1;
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
		}
		return 1;
	}
	if(strcmp(cmd, "/kiss", true) == 0)
	{
	    if(gFreeze[playerid] == 0)
	    {
	 		OnePlayAnim(playerid,"PED","kiss",4.1,0,1,1,1,1);
	 		gLoopingAnim[playerid] = 1;
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
		}
		return 1;
	}
    if(strcmp(cmd, "/balls", true) == 0)
	{
	    if(gFreeze[playerid] == 0)
	    {
	 		LoopingAnim(playerid,"MISC","balls",4.1,0,1,1,1,1);
	 		gLoopingAnim[playerid] = 1;
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
		}
		return 1;
	}
	if(strcmp(cmd, "/bitchslap", true) == 0)
	{
	    if(gFreeze[playerid] == 0)
	    {
	 		OnePlayAnim(playerid,"MISC","bitchslap",4.1,0,1,1,1,1);
	 		gLoopingAnim[playerid] = 1;
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
		}
		return 1;
	}
	if(strcmp(cmd, "/taichi", true) == 0)
	{
	    if(gFreeze[playerid] == 0)
	    {
	 		LoopingAnim(playerid,"PARK","Tai_Chi_Loop",4.0,1,0,0,0,0);
	 		gLoopingAnim[playerid] = 1;
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
		}
		return 1;
	}
// === [Handsup] ===
 	if(strcmp(cmd, "/handsup", true) == 0 || strcmp(cmd, "/surrender", true) == 0 || strcmp(cmd, "/sur", true) == 0)
 	{
 	    if(gFreeze[playerid] == 0)
 	    {
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
			gLoopingAnim[playerid] = 1;
        	return 1;
		}
		else
		{
 			SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
 			return 1;
		}
    }
// === [Phone animations] ===
 	if(strcmp(cmd, "/phone", true) == 0 || strcmp(cmd, "/cellphone", true) == 0)
	{
	    if(gFreeze[playerid] == 0)
	    {
	        if(gPhone[playerid] == 0)
	        {
	            gPhone[playerid] = 1;
				SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
				gLoopingAnim[playerid] = 1;
        		return 1;
			}
			else
			{
			    gPhone[playerid] = 0;
			    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
			    gLoopingAnim[playerid] = 1;
        		return 1;
			}
		}
		else
		{
 			SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
 			return 1;
		}
    }
// === [Drunk] ===
    if(strcmp(cmd, "/drunk", true) == 0)
	{
	    if(gFreeze[playerid] == 0)
	    {
			LoopingAnim(playerid,"PED","WALK_DRUNK",4.0,1,1,1,1,0);
			gLoopingAnim[playerid] = 1;
			return 1;
		}
		else
		{
 			SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
 			return 1;
		}
    }
// === [Bomb] ===
    if (strcmp("/bomb", cmdtext, true) == 0)
	{
	    if(gFreeze[playerid] == 0)
	    {
			ClearAnimations(playerid);
			OnePlayAnim(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
			gLoopingAnim[playerid] = 1;
			return 1;
		}
		else
		{
 			SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
 			return 1;
		}
	}
// === [Laugh] ===
    if (strcmp("/laugh", cmdtext, true) == 0)
	{
	    if(gFreeze[playerid] == 0)
	    {
			OnePlayAnim(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0, 0);
			gLoopingAnim[playerid] = 1;
			return 1;
		}
		else
		{
 			SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
 			return 1;
		}
	}
// === [Crossarms] ===
    if (strcmp("/crossarms", cmdtext, true) == 0)
	{
	    if(gFreeze[playerid] == 0)
	    {
			LoopingAnim(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1);
			gLoopingAnim[playerid] = 1;
			return 1;
		}
		else
		{
 			SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
 			return 1;
		}
	}
// === [Lay] ===
    if (strcmp("/lay", cmdtext, true, 6) == 0)
	{
		if(gFreeze[playerid] == 0)
		{
			LoopingAnim(playerid,"BEACH", "bather", 4.0, 1, 0, 0, 0, 0);
			gLoopingAnim[playerid] = 1;
			return 1;
		}
		else
		{
 			SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
 			return 1;
		}
    }
// === [Hide] ===
    if (strcmp("/hide", cmdtext, true, 3) == 0)
	{
	    if(gFreeze[playerid] == 0)
	    {
			LoopingAnim(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0);
			gLoopingAnim[playerid] = 1;
			return 1;
		}
		else
		{
 			SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
 			return 1;
		}
	}
// === [Vomit] ===
    if (strcmp("/vomit", cmdtext, true) == 0)
	{
		if(gFreeze[playerid] == 0)
		{
			OnePlayAnim(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0);
			gLoopingAnim[playerid] = 1;
			return 1;
		}
		else
		{
 			SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
 			return 1;
		}
	}
// === [Wave] ===
    if (strcmp("/wave", cmdtext, true) == 0)
	{
		if(gFreeze[playerid] == 0)
		{
   			LoopingAnim(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0);
			gLoopingAnim[playerid] = 1;
			return 1;
		}
		else
		{
 			SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
 			return 1;
		}
	}
// === [Slapass] ===
    if (strcmp("/slapass", cmdtext, true) == 0)
	{
	    if(gFreeze[playerid] == 0)
	    {
			OnePlayAnim(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0);
			gLoopingAnim[playerid] = 1;
			return 1;
		}
		else
		{
 			SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
 			return 1;
		}
	}
// === [Deal] ===
    if (strcmp("/deal", cmdtext, true) == 0)
	{
	    if(gFreeze[playerid] == 0)
		{
			OnePlayAnim(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0);
			gLoopingAnim[playerid] = 1;
			return 1;
		}
		else
		{
 			SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
 			return 1;
		}
	}
// === [Crack] ===
    if (strcmp("/crack", cmdtext, true, 6) == 0)
	{
		if(gFreeze[playerid] == 0)
		{
			LoopingAnim(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
			gLoopingAnim[playerid] = 1;
			return 1;
		}
		else
		{
 			SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
 			return 1;
		}
	}
// === [Smoke] ===
    if (strcmp("/smoke", cmdtext, true, 4) == 0)
	{
	    if(gFreeze[playerid] == 0)
	    {
			LoopingAnim(playerid, "SMOKING", "F_smklean_loop", 4.0, 1, 0, 0, 0, 0);
			gLoopingAnim[playerid] = 1;
			return 1;
		}
		else
		{
 			SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
 			return 1;
		}
	}
// === [Chat] ===
    if(strcmp(cmd, "/chat", true) == 0)
	{
		if(gFreeze[playerid] == 0)
		{
			OnePlayAnim(playerid,"PED","IDLE_CHAT",4.0,0,0,0,0,0);
			gLoopingAnim[playerid] = 1;
			return 1;
		}
		else
		{
 			SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
 			return 1;
		}
    }
// === [Dance] ===
 	if(strcmp(cmd, "/dance", true) == 0)
	{
		new dancestyle;
	    if(gFreeze[playerid] == 0)
		{
      		tmp = strtok(cmdtext, idx);
			dancestyle = strval(tmp);
			if(!strlen(tmp) || dancestyle < 1 || dancestyle > 4)
			{
		    	SendClientMessage(playerid,COLOR_RED,"USAGE: /dance [1-4]");
		    	return 1;
			}
			if(dancestyle == 1)
			{
		    	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
		    	gLoopingAnim[playerid] = 1;
			}
			else if(dancestyle == 2)
			{
		    	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
		    	gLoopingAnim[playerid] = 1;
			}
			else if(dancestyle == 3)
			{
		    	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
		    	gLoopingAnim[playerid] = 1;
			}
			else if(dancestyle == 4)
			{
		    	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
		    	gLoopingAnim[playerid] = 1;
			}
 	  		return 1;
		}
		else
		{
 			SendClientMessage(playerid, COLOR_RED, "Applying animations while frozen is not allowed!");
 			return 1;
		}
	}
	if(strcmp(cmdtext, "/refuel", true) == 0)
	{
		new PlayerVehicle = GetPlayerVehicleID(playerid);
		if(PlayerToPoint(15.0, playerid, G1) || PlayerToPoint(15.0, playerid, G2) || PlayerToPoint(15.0, playerid, G3) ||
		PlayerToPoint(15.0, playerid, G4) || PlayerToPoint(15.0, playerid, G5) || PlayerToPoint(15.0, playerid, G6) ||
		PlayerToPoint(15.0, playerid, G7) || PlayerToPoint(15.0, playerid, G8) || PlayerToPoint(15.0, playerid, G9) ||
		PlayerToPoint(15.0, playerid, G10) || PlayerToPoint(15.0, playerid, G11) || PlayerToPoint(15.0, playerid, G12) ||
		PlayerToPoint(15.0, playerid, G13) || PlayerToPoint(15.0, playerid, G14) || PlayerToPoint(15.0, playerid, G15) ||
		PlayerToPoint(15.0, playerid, G16) || PlayerToPoint(15.0, playerid, G17) || PlayerToPoint(15.0, playerid, G18) ||
		PlayerToPoint(15.0, playerid, G19) && IsPlayerInAnyVehicle(playerid))
		{
		    if(VehGas[PlayerVehicle] == 100)
			{
				format(string, sizeof(string), "ERROR! This %s is already full of gas!", vehName[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
				SendClientMessage(playerid, COLOR_RED, string);
				return 1;
			}
			else
			{
		 	    RefuelStart = SetTimerEx("StartRefuel", 100, false, "i", playerid);
			}
		}
		else
		{
			if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED, "You must be in a vehicle!");
			else return SendClientMessage(playerid, COLOR_RED, "You must be at Gas station to refuel!");
		}
		return 1;
	}
																																							/*			                                                                             */
	if(strcmp(cmdtext, "/fuel", true) == 0)
	{
	    new PlayerVehicle = GetPlayerVehicleID(playerid);
		if(IsPlayerInAnyVehicle(playerid))
		{
		    format(string, sizeof(string), "You have got %d fuel left in Your %s's tank.", VehGas[PlayerVehicle], vehName[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
			SendClientMessage(playerid, COLOR_WHITE, string);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, "You must be in a vehicle!");
		}
		return 1;
	}
	if(strcmp(cmd, "/setfuel", true) == 0)
	{
	    if(PlayerInfo[playerid][pAdmin] >= 1)
	    {
		    new fuel;
		    tmp = strtok(cmdtext, idx);
	    	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_GREEN, "USAGE: /setfuel [amount (0-100)] (Your own vehicle)");
	    	fuel = strval(tmp);
	    	if(fuel >= 100) return SendClientMessage(playerid, COLOR_GREEN, "Please use fuel amount from 0 to 100, otherwise the command has no effect!");
			new PlayerVehicle = GetPlayerVehicleID(playerid);
			VehGas[PlayerVehicle] = fuel;
		}
		return 1;
	}
	else
	{
	    new RandERROR[][] =
	    {
			"ERROR! What's the command \"%s\"? Never heard of it...",
			"ERROR! \"%s\" isn't a command!",
			"ERROR! UNKNOWN Command - \"%s\"!",
			"ERROR! \"%s\" isn't a command in VirtualScripting RPG!"
		};
		format(string, sizeof(string), RandERROR[random(sizeof(RandERROR))], cmdtext);
	    SendClientMessage(playerid, COLOR_GREY, string);
	    UnSuccessCommands += 1;
		dini_IntSet("/VirtualScriptingRP/Stats/commands.cfg", "Unsuccessful", UnSuccessCommands);
	    return 1;
	}
}

public Unjail(giveplayerid, Float:bPosX, Float:bPosY, Float:bPosZ)
{
	new giveplayer[MAX_PLAYER_NAME];
	GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
	SetPlayerInterior(giveplayerid,0);
	SetPlayerPos(giveplayerid, bPosX, bPosY, bPosZ);
	GameTextForPlayer(giveplayerid, "~r~Unjailed, ~w~~N~Be a better citizen next time!", 1000,1);
}

public CUnjail(giveplayerid)
{
	new giveplayer[MAX_PLAYER_NAME];
	GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
	SetPlayerInterior(giveplayerid,0);
	SetPlayerPos(giveplayerid, 246.5255,118.2471,1003.2188);
	GameTextForPlayer(giveplayerid, "~r~Unjailed, ~w~~N~Be a better citizen next time!", 1000,1);
}
// === [IsStringAName] ===
public IsStringAName(string[])
{
	for(new i = 0; i <= MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			new testname[MAX_PLAYER_NAME];
			GetPlayerName(i, testname, sizeof(testname));
			if(strcmp(testname, string, true, strlen(string)) == 0)
			{
				return 1;
			}
		}
	}
	return 0;
}
// === [GetPlayerID] ===
public GetPlayerID(string[])
{
	for(new i = 0; i <= MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			new testname[MAX_PLAYER_NAME];
			GetPlayerName(i, testname, sizeof(testname));
			if(strcmp(testname, string, true, strlen(string)) == 0)
			{
				return i;
			}
		}
	}
	return INVALID_PLAYER_ID;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new string[128];
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    if(VehGas[GetPlayerVehicleID(playerid)] != 0)
	    {
		    format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~Fuel: ~b~%d", VehGas[GetPlayerVehicleID(playerid)]);
			GameTextForPlayer(playerid, string, 3000, 3);
		}
		else
		{
		    RemovePlayerFromVehicle(playerid);
		    format(string, sizeof(string), "You've entered a %s, it has NO fuel left!", vehName[GetVehicleModel(GetPlayerVehicleID(playerid))-400], VehGas[GetPlayerVehicleID(playerid)]);
		    SendClientMessage(playerid, COLOR_CRED, string);
		}
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 420 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 438)
		{
		    if(gLicenseTest[playerid] == 0)
		    {
				SendClientMessage(playerid, COLOR_CYELLOW, "You can start TaxiDriver duty, use \"/taxi [fee]\".");
				InfoTextDraw(playerid, "~w~Go on taxidriver duty, write ~y~/taxi [fee]", 5000);
			}
			else
			{
			    SendClientMessage(playerid, COLOR_RED, "You can't start license driving test in this vehicle!");
				RemovePlayerFromVehicle(playerid);
			}
			format(string, sizeof(string), "You've entered a %s, it has %d% fuel left.", vehName[GetVehicleModel(GetPlayerVehicleID(playerid))-400], VehGas[GetPlayerVehicleID(playerid)]);
			SendClientMessage(playerid, COLOR_CRED, string);
		}
		if(gLicenseTest[playerid] == 1)
		{
		    SetPlayerCheckpoint(playerid, -1885.5433, 832.5999, 35.1641, 10.0);
			DriveCountT = SetTimer("DriveCount", 1000, true);
			format(string, sizeof(string), "You've entered a %s, it has %d% fuel left.", vehName[GetVehicleModel(GetPlayerVehicleID(playerid))-400], VehGas[GetPlayerVehicleID(playerid)]);
			SendClientMessage(playerid, COLOR_CRED, string);
		}
		if(IsCopCar(GetPlayerVehicleID(playerid)) && gTeam[playerid] != TEAM_COP && gTeam[playerid] != TEAM_CRIMINAL)
		{
		    if(!IsPlayerCriminal(playerid))
		    {
			    SetPlayerCriminal(playerid, "Stealing Operative Vehicle");
			    InfoTextDraw(playerid, "~r~Suspected~w~: Stealing operative vehicle!", 6000);
			}
		}
		format(string, sizeof(string), "You've entered a %s, it has %d% fuel left.", vehName[GetVehicleModel(GetPlayerVehicleID(playerid))-400], VehGas[GetPlayerVehicleID(playerid)]);
		SendClientMessage(playerid, COLOR_CRED, string);
	}
	if(newstate == PLAYER_STATE_ONFOOT)
	{
	    gTaxiFee[playerid] = 0;
	    gTeam[playerid] = TEAM_CIVILIAN;
	    SetPlayerColor(playerid, COLOR_WHITE);
	    if(gLicenseTest[playerid] == 1)
	    {
	    	KillTimer(DriveCountT);
	    	gLicenseTest[playerid] = 0;
	    	SendClientMessage(playerid, COLOR_RED, "You can't come out of your vehicle. You have failed the test.");
	    	DisablePlayerCheckpoint(playerid);
	    	InfoTextDraw(playerid, "~r~Driving School~w~: Test failed.", 5000);
		}
	}
}

public LoseFuel()
{
	new string[256];
	for(new playerid = 0; playerid < MAX_PLAYERS; playerid++)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
		    new PlayerVehicle = GetPlayerVehicleID(playerid);
		    VehGas[PlayerVehicle] -= 1;
			format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~Fuel: ~b~%d", VehGas[GetPlayerVehicleID(playerid)]);
			GameTextForPlayer(playerid, string, 3000, 3);
			if(VehGas[PlayerVehicle] == 90 ||
			   VehGas[PlayerVehicle] == 80 ||
			   VehGas[PlayerVehicle] == 70 ||
			   VehGas[PlayerVehicle] == 60 ||
			   VehGas[PlayerVehicle] == 50 ||
			   VehGas[PlayerVehicle] == 40 ||
			   VehGas[PlayerVehicle] == 30 ||
			   VehGas[PlayerVehicle] == 20 ||
			   VehGas[PlayerVehicle] == 10 ||
			   VehGas[PlayerVehicle] == 5)
			{
			    format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~Fuel: ~b~%d", VehGas[GetPlayerVehicleID(playerid)]);
				GameTextForPlayer(playerid, string, 3000, 3);
			}
			else if(VehGas[PlayerVehicle] == 0)
		    {
			    format(string, sizeof(string), "You can't keep driving Your %s anymore! Fuel has dropped to 0%!", vehName[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
			    SendClientMessage(playerid, COLOR_RED, string);
			    RemovePlayerFromVehicle(playerid);
			    InfoTextDraw(playerid, "~r~Warning~w~: Your vehicle is out of fuel", 5000);
			}
		}
	}
}

public RefuelVehicle(playerid)
{
    new PlayerVehicle = GetPlayerVehicleID(playerid);
	new string[256];
	if(VehGas[PlayerVehicle] <= 99)
 	{
 	    if(VehGas[PlayerVehicle] >= 90)
 	    {
			if(GetPlayerMoney(playerid) <= 9)
			{
			    SendClientMessage(playerid, COLOR_RED, "You don't have money to refuel!");
			    KillTimer(RefuelTimer);
			    KillTimer(RefuelStart);
			}
			else
			{
	 	        GivePlayerMoney(playerid, -10);
				VehGas[PlayerVehicle] = 100;
				format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~Fuel: ~b~%d", VehGas[GetPlayerVehicleID(playerid)]);
				GameTextForPlayer(playerid, string, 3000, 3);
			}
		}
		else
		{
		    if(GetPlayerMoney(playerid) <= 9)
			{
			    SendClientMessage(playerid, COLOR_RED, "You don't have money to refuel!");
			    KillTimer(RefuelTimer);
			    KillTimer(RefuelStart);
			}
			else
			{
				GivePlayerMoney(playerid, -10);
				VehGas[PlayerVehicle] += 10;
				format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~Fuel: ~b~%d", VehGas[GetPlayerVehicleID(playerid)]);
				GameTextForPlayer(playerid, string, 3000, 3);
			}
		}
	}
	if(VehGas[PlayerVehicle] == 100)
	{
	    new RefueledAmount = 100 - OldFuel;
	    format(string, sizeof(string), "You have bought %d litres of fuel, the tank of Your %s is full now!", RefueledAmount, vehName[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
	    SendClientMessage(playerid, COLOR_YELLOW, string);
		format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~Fuel: ~b~%d", VehGas[GetPlayerVehicleID(playerid)]);
		GameTextForPlayer(playerid, string, 3000, 3);
		KillTimer(RefuelTimer);
		KillTimer(RefuelStart);
	}
	return 1;
}

public OnGameModeExit()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    TextDrawHideForPlayer(i, ZoneText[i]);
	    TextDrawHideForPlayer(i, Textie[i]);
		TextDrawDestroy(ZoneText[i]);
		TextDrawDestroy(Textie[i]);
	}
}

public StartRefuel(playerid)
{
	new string[256];
	RefuelTimer = SetTimerEx("RefuelVehicle", 3000, true, "i", playerid);
	OldFuel = VehGas[GetPlayerVehicleID(playerid)];
	format(string, sizeof(string), "Re-fueling Your %s started!", vehName[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
	SendClientMessage(playerid, COLOR_WHITE, string);
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	VehGas[vehicleid] = RandGas[random(sizeof(RandGas))][0];
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(gLoopingAnim[playerid] == 1)
	{
		if(IsKeyJustDown(KEY_SPRINT,newkeys,oldkeys))
		{
	    	StopLoopingAnim(playerid);
    	}
	}
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	TogglePlayerControllable(playerid, true);
	return 1;
}

public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		return 1;
	}
	return 0;
}

public StopMusic(playerid)
{
	PlayerPlaySound(playerid, 1069, 0.0, 0.0, 0.0);
}

IsKeyJustDown(key, newkeys, oldkeys)
{
	if((newkeys & key) && !(oldkeys & key)) return 1;
	return 0;
}

OnePlayAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
	ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp);
}

LoopingAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
    gLoopingAnim[playerid] = 1;
    ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp);
}

StopLoopingAnim(playerid)
{
	gLoopingAnim[playerid] = 0;
    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
}

public LoadZoneText(playerid)
{
	ZoneText[playerid] = TextDrawCreate(37.000000, 427.000000, " ");
	TextDrawAlignment(ZoneText[playerid], 0);
	TextDrawBackgroundColor(ZoneText[playerid], 0x000000ff);
	TextDrawFont(ZoneText[playerid], 1);
	TextDrawLetterSize(ZoneText[playerid], 0.499999, 1.600000);
	TextDrawColor(ZoneText[playerid], 0xffffff99);
	TextDrawSetOutline(ZoneText[playerid], 1);
	TextDrawSetProportional(ZoneText[playerid], 1);
	TextDrawSetShadow(ZoneText[playerid], 1);
	TextDrawShowForPlayer(playerid, ZoneText[playerid]);
	ZoneTimer = SetTimer("UpdateZone", 1000, true);
}

public UpdateZone(playerid)
{
	new Text[120];
	if(GetPlayerInterior(playerid) == 10)
	{
	    format(Text, sizeof(Text), "SFPD");
	}
	else if(GetPlayerInterior(playerid) == 17)
	{
	    format(Text, sizeof(Text), "Bank");
	}
	else if(GetPlayerInterior(playerid) == 1)
	{
	    format(Text, sizeof(Text), "Cocktail Bar");
	}
	else if(GetPlayerInterior(playerid) == 3)
	{
	    format(Text, sizeof(Text), "Jizzy's");
	}
	else if(GetPlayerInterior(playerid) == 0)
	{
		new Zone[MAX_ZONE_NAME];
		GetPlayer2DZone(playerid, Zone, MAX_ZONE_NAME);
	    format(Text, sizeof(Text), "%s", Zone);
		TextDrawSetString(ZoneText[playerid], Text);
	}
}

stock GetPlayer2DZone(playerid, zone[], len)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}

stock GetPlayer3DZone(playerid, zone[], len)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4] && z >= gSAZones[i][SAZONE_AREA][2] && z <= gSAZones[i][SAZONE_AREA][5])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}

stock IsPlayerInZone(playerid, zone[])
{
	new TmpZone[MAX_ZONE_NAME];
	GetPlayer3DZone(playerid, TmpZone, sizeof(TmpZone));
	for(new i = 0; i != sizeof(gSAZones); i++)
	{
		if(strfind(TmpZone, zone, true) != -1)
			return 1;
	}
	return 0;
}

stock CheckName(playerid)
{
	new string[256];
	gettime(Hour, Minute, Second);
	getdate(Year, Month, Day);
	GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
	for(new names = 0; names < MAX_ILLEGALNAMES; names++)
	{
	    if(strcmp(PlayerName, IllegalNames[names], true) == 0)
		{
		    format(string, sizeof(string), "You have been kicked, %s!", PlayerName);
		    SendClientMessage(playerid, COLOR_PINK, string);
		    format(string, sizeof(string), "REASON: Your name, \"%s\" violates the server rules.", PlayerName);
		    SendClientMessage(playerid, COLOR_GREY, string);
		    format(string, sizeof(string), "TIME: %d:%d (hh:mm) DATE: %d/%d/%d (dd/mm/yy)", Hour, Minute, Day, Month, Year);
		    SendClientMessage(playerid, COLOR_GREY, string);
		    for(new i = 0; i<MAX_PLAYERS; i++)
		    {
		        if(IsPlayerConnected(i) && i != playerid)
		        {
				    format(string, sizeof(string), "- SF:RP - %s(%i) was automatically kicked because the name \"%s\" violates server rules.", PlayerName, playerid, PlayerName);
				    SendClientMessage(i, COLOR_CRED, string);
				}
			}
			InfoTextDraw(playerid, "~r~This is a forbidden name!", 10000);
			Kick(playerid);
		}
	}
}

stock ShutDown()
{
	SendRconCommand("GMX");
}


stock SetPlayerCriminal(playerid, reason[])
{
	new pName[24], string[128], zone[28];
	GetPlayer2DZone(playerid, zone, 28);
	GetPlayerName(playerid, pName, sizeof(pName));
	if(gTeam[playerid] == TEAM_CRIMINAL)
	{
	    printf("ERROR 01: \"SetPlayerCriminal\" - Player %s(%i) is already a criminal!", pName, playerid);
	    return 1;
	}
	if(gTeam[playerid] == TEAM_COP)
	{
		printf("ERROR 02: \"SetPlayerCriminal\" - Player %s(%i) is a cop!", pName, playerid);
		return 1;
	}
	strmid(PlayerInfo[playerid][pCrime], reason, 0, strlen(reason), 255);
	format(string, sizeof(string), "%s(%i) suspected for: %s", pName, playerid, reason);
	aLog("SetPlayerCriminal.txt", string);
	printf("%s(%i) suspected for: %s", pName, playerid, reason);
	gTeam[playerid] = TEAM_CRIMINAL;
	SetPlayerColor(playerid, COLOR_ORANGE);
	format(string, sizeof(string), "SFPD: You are now suspected. Reason: \"%s\".", reason);
	SendClientMessage(playerid, COLOR_BLUE, string);
	format(string, sizeof(string), "HQ: We got a suspect %s(%i) located at %s", pName, playerid, zone);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(gTeam[i] == TEAM_COP)
	    {
			SendClientMessage(i, COLOR_BLUE, string);
		}
	}
	format(string, sizeof(string), "HQ: Reason: \"%s\"", reason);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(gTeam[i] == TEAM_COP)
	    {
			SendClientMessage(i, COLOR_BLUE, string);
		}
	}
	format(string, sizeof(string), "~r~Suspected~w~: %s", reason);
	InfoTextDraw(playerid, string, 6000);
	SetPlayerColor(playerid, COLOR_ORANGE);
	return 1;
}

stock IsPlayerCriminal(playerid)
{
	if(GetPlayerColor(playerid) == COLOR_ORANGE && gTeam[playerid] == TEAM_CRIMINAL)
	{
	    return 1;
	}
	return 0;
}

aLog(file[], msg[])
{
	new fName[256], entry[256], File: hFile;
	gettime(Hour, Minute, Second);
	getdate(Year, Month, Day);

	format(fName, sizeof(fName), "/VirtualScriptingRP/Logs/%s", file);
	if(!fexist(fName))
	{
		dini_Create(fName);
		format(entry, sizeof(entry), "[%d/%d] [%d:%d] File created!\r\n", Day, Month, Hour, Minute);
		hFile = fopen(fName, io_append);
		fwrite(hFile, entry);
		format(entry, sizeof(entry), "[%d/%d] [%d:%d] %s\r\n", Day, Month, Hour, Minute, msg);
		fwrite(hFile, entry);
		fclose(hFile);
	}
	else
	{
		format(entry, sizeof(entry), "[%d/%d] [%d:%d] %s\r\n", Day, Month, Hour, Minute, msg);
		hFile = fopen(fName, io_append);
		fwrite(hFile, entry);
		fclose(hFile);
	}
}

stock aGivePlayerHealth(playerid, Float:health)
{
	new Float:OHealth;
	GetPlayerHealth(playerid, OHealth);
	SetPlayerHealth(playerid, OHealth + health);
}
