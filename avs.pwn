//==========================================================
// 	  Advanced Vehicle System version 1.0 by MadeMan
//==========================================================
#define FILTERSCRIPT
#include <a_samp>
//=========================SETTINGS=========================
#undef MAX_PLAYERS
#define MAX_PLAYERS 100
#define MAX_DVEHICLES 200
#define MAX_DEALERSHIPS 10
#define MAX_FUEL_STATIONS 10
#define VEHICLE_FILE_PATH "AVS/Vehicles/"
#define DEALERSHIP_FILE_PATH "AVS/Dealerships/"
#define FUEL_STATION_FILE_PATH "AVS/FuelStations/"
#define MAX_PLAYER_VEHICLES 3
#define FUEL_PRICE 5
#define GAS_CAN_PRICE 500
#define ALARM_TIME 10000  // alarm duration in milliseconds (1 second = 1000 milliseconds)#define DEFAULT_NUMBER_PLATE "123 ABC"
//==========================================================
#define COLOR_BLACK 0x000000FF
#define COLOR_RED 0xEE0000FF
#define COLOR_GREEN 0x00CC00FF
#define COLOR_BLUE 0x0000FFFF
#define COLOR_ORANGE 0xFF6600FF
#define COLOR_YELLOW 0xFFFF00FF
#define COLOR_LIGHTBLUE 0x00FFFFFF
#define COLOR_PURPLE 0xC2A2DAFF
#define COLOR_GREY 0xC0C0C0FF
#define COLOR_WHITE 0xFFFFFFFF
#define VEHICLE_DEALERSHIP 1
#define VEHICLE_PLAYER 2
#define CMD:%1(%2)          \
			forward cmd_%1(%2); \
			public cmd_%1(%2)
#define ShowErrorDialog(%1,%2) ShowPlayerDialog(%1, DIALOG_ERROR, DIALOG_STYLE_MSGBOX, "ERROR", %2, "OK", "")
enum{
	DIALOG_NONE=12345,
	DIALOG_ERROR=12346,
	DIALOG_VEHICLE=500,
	DIALOG_VEHICLE_BUY,
	DIALOG_VEHICLE_SELL,
	DIALOG_FINDVEHICLE,
	DIALOG_TRUNK,
	DIALOG_TRUNK_ACTION,
	DIALOG_VEHICLE_PLATE,
	DIALOG_FUEL,
	DIALOG_EDITVEHICLE
};
new maintimer;
new speedotimer;
new savetimer;
new SaveVehicleIndex;
new RefuelTime[MAX_PLAYERS];
new TrackCar[MAX_PLAYERS];
new DialogReturn[MAX_PLAYERS];
//new Text:SpeedoBox;
new Text:SpeedoText[MAX_PLAYERS];
new Float:Fuel[MAX_VEHICLES] = {100.0, ...};
new VehicleSecurity[MAX_VEHICLES];
new VehicleCreated[MAX_DVEHICLES];
new VehicleID[MAX_DVEHICLES];
new VehicleModel[MAX_DVEHICLES];
new Float:VehiclePos[MAX_DVEHICLES][4];
new VehicleColor[MAX_DVEHICLES][2];
new VehicleInterior[MAX_DVEHICLES];
new VehicleWorld[MAX_DVEHICLES];
new VehicleOwner[MAX_DVEHICLES][MAX_PLAYER_NAME];
new VehicleNumberPlate[MAX_DVEHICLES][16];
new VehicleValue[MAX_DVEHICLES];
new VehicleLock[MAX_DVEHICLES];
new VehicleAlarm[MAX_DVEHICLES];
new VehicleTrunk[MAX_DVEHICLES][5][2];
new VehicleMods[MAX_DVEHICLES][14];
new VehiclePaintjob[MAX_DVEHICLES] = {255, ...};
new Text3D:VehicleLabel[MAX_DVEHICLES];
new DealershipCreated[MAX_DEALERSHIPS];
new Float:DealershipPos[MAX_DEALERSHIPS][3];
new Text3D:DealershipLabel[MAX_DEALERSHIPS];
new FuelStationCreated[MAX_FUEL_STATIONS];
new Float:FuelStationPos[MAX_FUEL_STATIONS][3];
new Text3D:FuelStationLabel[MAX_FUEL_STATIONS];
new VehicleNames[][] = {
	"Landstalker","Bravura","Buffalo","Linerunner","Perennial","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus",
	"Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat","Mr Whoopee","BF Injection",
	"Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie",
	"Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
	"Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
	"Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3 50","Walton","Regina",
	"Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo","Greenwood",
	"Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa","RC Goblin","Hotring Racer A","Hotring Racer B",
	"Bloodring Banger","Rancher","Super GT","Elegant","Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain",
	"Nebula","Majestic","Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover",
	"Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A",
	"Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight","Trailer",
	"Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer A","Emperor",
	"Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)",
	"Police Car (LVPD)","Police Ranger","Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
	"Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};
enum MainZone{
	Zone_Name[28],
	Float:Zone_Area[6]
}
static const SanAndreasZones[][MainZone] = {

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
{"Randolph Industrial",         {1558.00,596.30,-89.00,1823.00,823.20,110.90}},
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
{"Four Dragons Casino",         {1817.30,863.20,-89.00,2027.30,1083.20,110.90}},
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
	// Citys Zones
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
forward MainTimer();
forward Speedometer();
forward SaveTimer();
forward StopAlarm(vehicleid);
stock PlayerName(playerid){
	new pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
	return pName;
}
stock IsPlayerSpawned(playerid){
	switch(GetPlayerState(playerid)){
		case 1,2,3: return 1;
	}
	return 0;
}
stock IsMeleeWeapon(weaponid){
	switch(weaponid){
		case 2 .. 15, 40, 44 .. 46: return 1;
	}
	return 0;
}
stock RemovePlayerWeapon(playerid, weaponid){
	new WeaponData[12][2];
	for(new i=1; i < sizeof(WeaponData); i++){
		GetPlayerWeaponData(playerid, i, WeaponData[i][0], WeaponData[i][1]);
	}
	ResetPlayerWeapons(playerid);
	for(new i=1; i < sizeof(WeaponData); i++){
		if(WeaponData[i][0] != weaponid){
			GivePlayerWeapon(playerid, WeaponData[i][0], WeaponData[i][1]);
		}
	}
}
stock IsBicycle(vehicleid){
	switch(GetVehicleModel(vehicleid)){
		case 481,509,510: return 1;
	}
	return 0;
}
stock PlayerToPlayer(playerid, targetid, Float:dist){
	new Float:pos[3];
	GetPlayerPos(targetid, pos[0], pos[1], pos[2]);
	return IsPlayerInRangeOfPoint(playerid, dist, pos[0], pos[1], pos[2]);
}
stock PlayerToVehicle(playerid, vehicleid, Float:dist){
	new Float:pos[3];
	GetVehiclePos(vehicleid, pos[0], pos[1], pos[2]);
	return IsPlayerInRangeOfPoint(playerid, dist, pos[0], pos[1], pos[2]);
}
stock GetClosestVehicle(playerid){
	new Float:x, Float:y, Float:z;
	new Float:dist, Float:closedist=9999, closeveh;
	for(new i=1; i < MAX_VEHICLES; i++){
		if(GetVehiclePos(i, x, y, z)){
			dist = GetPlayerDistanceFromPoint(playerid, x, y, z);
			if(dist < closedist){
				closedist = dist;
				closeveh = i;
			}
		}
	}
	return closeveh;
}
stock ToggleEngine(vehicleid, toggle){
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, toggle, lights, alarm, doors, bonnet, boot, objective);
}
stock ToggleAlarm(vehicleid, toggle){
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, engine, lights, toggle, doors, bonnet, boot, objective);
}
stock ToggleDoors(vehicleid, toggle){
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, engine, lights, alarm, toggle, bonnet, boot, objective);
}
stock ToggleBoot(vehicleid, toggle){
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, toggle, objective);
}
stock StripNL(str[]){
	// credits to Y_Less for y_utils.inc
	new	i = strlen(str);
	while (i-- && str[i] <= ' ') str[i] = '\0';
}
stock IsNumeric(const string[]){
	for(new i=0; string[i]; i++){
		if(string[i] < '0' || string[i] > '9') return 0;
	}
	return 1;
}
stock GetVehicleModelIDFromName(const vname[]){
	for(new i=0; i < sizeof(VehicleNames); i++){
		if(strfind(VehicleNames[i], vname, true) != -1) return i + 400;
	}
	return -1;
}
stock GetPlayer2DZone(playerid){
	new zone[32] = "San Andreas";
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i < sizeof(SanAndreasZones); i++){
		if(x >= SanAndreasZones[i][Zone_Area][0] && x <= SanAndreasZones[i][Zone_Area][3]
		&& y >= SanAndreasZones[i][Zone_Area][1] && y <= SanAndreasZones[i][Zone_Area][4]){
			strmid(zone, SanAndreasZones[i][Zone_Name], 0, 28);
			return zone;
		}
	}
	return zone;
}
stock GetPlayer3DZone(playerid){
	new zone[32] = "San Andreas";
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i < sizeof(SanAndreasZones); i++){
		if(x >= SanAndreasZones[i][Zone_Area][0] && x <= SanAndreasZones[i][Zone_Area][3]
		&& y >= SanAndreasZones[i][Zone_Area][1] && y <= SanAndreasZones[i][Zone_Area][4]
		&& z >= SanAndreasZones[i][Zone_Area][2] && z <= SanAndreasZones[i][Zone_Area][5]){
			strmid(zone, SanAndreasZones[i][Zone_Name], 0, 28);
			return zone;
		}
	}
	return zone;
}
stock GetPlayerSpeed(playerid, bool:kmh = true){
	new	Float:xx;
	new	Float:yy;
	new	Float:zz;
	new	Float:pSpeed;
	if(IsPlayerInAnyVehicle(playerid)){
		GetVehicleVelocity(GetPlayerVehicleID(playerid),xx,yy,zz);
	}
	else
{
		GetPlayerVelocity(playerid,xx,yy,zz);
	}

	pSpeed = floatsqroot((xx * xx) + (yy * yy) + (zz * zz));
	return kmh ? floatround((pSpeed * 165.12)) : floatround((pSpeed * 103.9));
}
/*SafeGivePlayerMoney(playerid, money){
	return CallRemoteFunction("SafeGivePlayerMoney","dd",playerid, money);
}
#define GivePlayerMoney SafeGivePlayerMoney

SafeGetPlayerMoney(playerid){
	return CallRemoteFunction("SafeGetPlayerMoney","d",playerid);
}
#define GetPlayerMoney SafeGetPlayerMoney*/
IsAdmin(playerid, level){
	if(IsPlayerAdmin(playerid)) return 1;
	if(CallRemoteFunction("GetPlayerAVSAdmin", "d", playerid) >= level) return 1;
	return 0;
}
LoadVehicles(){
	new string[64];
	new File:handle, count;
	new filename[64], line[256], s, key[64];
	for(new i=1; i < MAX_DVEHICLES; i++){
		format(filename, sizeof(filename), VEHICLE_FILE_PATH "v%d.ini", i);
		if(!fexist(filename)) continue;
		handle = fopen(filename, io_read);
		while(fread(handle, line)){
			StripNL(line);
			s = strfind(line, "=");
			if(!line[0] || s < 1) continue;
			strmid(key, line, 0, s++);
			if(strcmp(key, "Created") == 0) VehicleCreated[i] = strval(line[s]);
			else if(strcmp(key, "Model") == 0) VehicleModel[i] = strval(line[s]);
			else if(strcmp(key, "Pos") == 0) sscanf(line[s], "p,ffff", VehiclePos[i][0], VehiclePos[i][1],
				VehiclePos[i][2], VehiclePos[i][3]);
			else if(strcmp(key, "Colors") == 0) sscanf(line[s], "p,dd", VehicleColor[i][0], VehicleColor[i][1]);
			else if(strcmp(key, "Interior") == 0) VehicleInterior[i] = strval(line[s]);
			else if(strcmp(key, "VirtualWorld") == 0) VehicleWorld[i] = strval(line[s]);
			else if(strcmp(key, "Owner") == 0) strmid(VehicleOwner[i], line, s, sizeof(line));
			else if(strcmp(key, "NumberPlate") == 0) strmid(VehicleNumberPlate[i], line, s, sizeof(line));
			else if(strcmp(key, "Value") == 0) VehicleValue[i] = strval(line[s]);
			else if(strcmp(key, "Lock") == 0) VehicleLock[i] = strval(line[s]);
			else if(strcmp(key, "Alarm") == 0) VehicleAlarm[i] = strval(line[s]);
			else if(strcmp(key, "Paintjob") == 0) VehiclePaintjob[i] = strval(line[s]);
			else{
				for(new t=0; t < sizeof(VehicleTrunk[]); t++){
					format(string, sizeof(string), "Trunk%d", t+1);
					if(strcmp(key, string) == 0) sscanf(line[s], "p,dd", VehicleTrunk[i][t][0], VehicleTrunk[i][t][1]);
				}
				for(new m=0; m < sizeof(VehicleMods[]); m++){
					format(string, sizeof(string), "Mod%d", m);
					if(strcmp(key, string) == 0) VehicleMods[i][m] = strval(line[s]);
				}
			}
		}
		fclose(handle);
		if(VehicleCreated[i]) count++;
	}
	printf("  Loaded %d vehicles", count);
}
SaveVehicle(vehicleid){
	new filename[64], line[256];
	format(filename, sizeof(filename), VEHICLE_FILE_PATH "v%d.ini", vehicleid);
	new File:handle = fopen(filename, io_write);
	format(line, sizeof(line), "Created=%d\r\n", VehicleCreated[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Model=%d\r\n", VehicleModel[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Pos=%.3f,%.3f,%.3f,%.3f\r\n", VehiclePos[vehicleid][0], VehiclePos[vehicleid][1],
		VehiclePos[vehicleid][2], VehiclePos[vehicleid][3]);
	fwrite(handle, line);
	format(line, sizeof(line), "Colors=%d,%d\r\n", VehicleColor[vehicleid][0], VehicleColor[vehicleid][1]); fwrite(handle, line);
	format(line, sizeof(line), "Interior=%d\r\n", VehicleInterior[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "VirtualWorld=%d\r\n", VehicleWorld[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Owner=%s\r\n", VehicleOwner[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "NumberPlate=%s\r\n", VehicleNumberPlate[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Value=%d\r\n", VehicleValue[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Lock=%d\r\n", VehicleLock[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Alarm=%d\r\n", VehicleAlarm[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Paintjob=%d\r\n", VehiclePaintjob[vehicleid]); fwrite(handle, line);
	for(new t=0; t < sizeof(VehicleTrunk[]); t++){
		format(line, sizeof(line), "Trunk%d=%d,%d\r\n", t+1, VehicleTrunk[vehicleid][t][0], VehicleTrunk[vehicleid][t][1]);
		fwrite(handle, line);
	}
	for(new m=0; m < sizeof(VehicleMods[]); m++){
		format(line, sizeof(line), "Mod%d=%d\r\n", m, VehicleMods[vehicleid][m]);
		fwrite(handle, line);
	}
	fclose(handle);
}
UpdateVehicle(vehicleid, removeold){
	if(VehicleCreated[vehicleid]){
		if(removeold){
			new Float:health;
			GetVehicleHealth(VehicleID[vehicleid], health);
			new engine, lights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx(VehicleID[vehicleid], engine, lights, alarm, doors, bonnet, boot, objective);
			//new panels, doorsd, lightsd, tires;
			//GetVehicleDamageStatus(VehicleID[vehicleid], panels, doorsd, lightsd, tires);
			DestroyVehicle(VehicleID[vehicleid]);
			VehicleID[vehicleid] = CreateVehicle(VehicleModel[vehicleid], VehiclePos[vehicleid][0], VehiclePos[vehicleid][1],
				VehiclePos[vehicleid][2], VehiclePos[vehicleid][3], VehicleColor[vehicleid][0], VehicleColor[vehicleid][1], 3600);
			SetVehicleHealth(VehicleID[vehicleid], health);
			SetVehicleParamsEx(VehicleID[vehicleid], engine, lights, alarm, doors, bonnet, boot, objective);
			//UpdateVehicleDamageStatus(VehicleID[vehicleid], panels, doorsd, lightsd, tires);
		}
		else{
			VehicleID[vehicleid] = CreateVehicle(VehicleModel[vehicleid], VehiclePos[vehicleid][0], VehiclePos[vehicleid][1],
				VehiclePos[vehicleid][2], VehiclePos[vehicleid][3], VehicleColor[vehicleid][0], VehicleColor[vehicleid][1], 3600);
		}
		LinkVehicleToInterior(VehicleID[vehicleid], VehicleInterior[vehicleid]);
		SetVehicleVirtualWorld(VehicleID[vehicleid], VehicleWorld[vehicleid]);
		SetVehicleNumberPlate(VehicleID[vehicleid], VehicleNumberPlate[vehicleid]);
		for(new i=0; i < sizeof(VehicleMods[]); i++){
			AddVehicleComponent(VehicleID[vehicleid], VehicleMods[vehicleid][i]);
		}
		ChangeVehiclePaintjob(VehicleID[vehicleid], VehiclePaintjob[vehicleid]);
		if(VehicleLock[vehicleid]) ToggleDoors(VehicleID[vehicleid], VEHICLE_PARAMS_ON);
		if(VehicleAlarm[vehicleid]) VehicleSecurity[VehicleID[vehicleid]] = 1;
		UpdateVehicleLabel(vehicleid, removeold);
	}
}
UpdateVehicleLabel(vehicleid, removeold){
	if(VehicleCreated[vehicleid] == VEHICLE_DEALERSHIP){
		if(removeold){
			Delete3DTextLabel(VehicleLabel[vehicleid]);
		}
		new labeltext[128];
		format(labeltext, sizeof(labeltext), "%s\nID: %d\nDealership: %s\nPrice: $%d", VehicleNames[VehicleModel[vehicleid]-400],
			vehicleid, VehicleOwner[vehicleid], VehicleValue[vehicleid]);
		VehicleLabel[vehicleid] = Create3DTextLabel(labeltext, 0xBB7700DD, 0, 0, 0, 10.0, 0);
		Attach3DTextLabelToVehicle(VehicleLabel[vehicleid], VehicleID[vehicleid], 0, 0, 0);
	}
}
IsValidVehicle(vehicleid){
	if(vehicleid < 1 || vehicleid >= MAX_DVEHICLES) return 0;
	if(VehicleCreated[vehicleid]) return 1;
	return 0;
}
GetFreeVehicleID(){
	for(new i=1; i < MAX_DVEHICLES; i++){
		if(!VehicleCreated[i]) return i;
	}
	return 0;
}
GetVehicleID(vehicleid){
	for(new i=1; i < MAX_DVEHICLES; i++){
		if(VehicleCreated[i] && VehicleID[i] == vehicleid) return i;
	}
	return 0;
}
GetPlayerVehicles(playerid){
	new playername[24];
	GetPlayerName(playerid, playername, sizeof(playername));
	new count;
	for(new i=1; i < MAX_DVEHICLES; i++){
		if(VehicleCreated[i] == VEHICLE_PLAYER && strcmp(VehicleOwner[i], playername) == 0){
			count++;
		}
	}
	return count;
}
GetPlayerVehicleAccess(playerid, vehicleid){
	if(IsValidVehicle(vehicleid)){
		if(VehicleCreated[vehicleid] == VEHICLE_DEALERSHIP){
			if(IsAdmin(playerid, 1)){
				return 1;
			}
		}
		else if(VehicleCreated[vehicleid] == VEHICLE_PLAYER){
			if(strcmp(VehicleOwner[vehicleid], PlayerName(playerid)) == 0){
				return 2;
			}
			else if(GetPVarInt(playerid, "CarKeys") == vehicleid){
				return 1;
			}
		}
	}
	else
{
		return 1;
	}
	return 0;
}
LoadDealerships(){
	new File:handle, count;
	new filename[64], line[256], s, key[64];
	for(new i=1; i < MAX_DEALERSHIPS; i++){
		format(filename, sizeof(filename), DEALERSHIP_FILE_PATH "d%d.ini", i);
		if(!fexist(filename)) continue;
		handle = fopen(filename, io_read);
		while(fread(handle, line)){
			StripNL(line);
			s = strfind(line, "=");
			if(!line[0] || s < 1) continue;
			strmid(key, line, 0, s++);
			if(strcmp(key, "Created") == 0) DealershipCreated[i] = strval(line[s]);
			else if(strcmp(key, "Pos") == 0) sscanf(line[s], "p,fff", DealershipPos[i][0],
				DealershipPos[i][1], DealershipPos[i][2]);
		}
		fclose(handle);
		if(DealershipCreated[i]) count++;
	}
	printf("  Loaded %d dealerships", count);
}
SaveDealership(dealerid){
	new filename[64], line[256];
	format(filename, sizeof(filename), DEALERSHIP_FILE_PATH "d%d.ini", dealerid);
	new File:handle = fopen(filename, io_write);
	format(line, sizeof(line), "Created=%d\r\n", DealershipCreated[dealerid]); fwrite(handle, line);
	format(line, sizeof(line), "Pos=%.3f,%.3f,%.3f\r\n", DealershipPos[dealerid][0],
		DealershipPos[dealerid][1], DealershipPos[dealerid][2]);
	fwrite(handle, line);
	fclose(handle);
}
UpdateDealership(dealerid, removeold){
	if(DealershipCreated[dealerid]){
		if(removeold){
			Delete3DTextLabel(DealershipLabel[dealerid]);
		}
		new labeltext[32];
		format(labeltext, sizeof(labeltext), "Vehicle Dealership\nID: %d", dealerid);
		DealershipLabel[dealerid] = Create3DTextLabel(labeltext, 0x00BB00DD, DealershipPos[dealerid][0],
			DealershipPos[dealerid][1], DealershipPos[dealerid][2]+0.5, 20.0, 0);
	}
}
IsValidDealership(dealerid){
	if(dealerid < 1 || dealerid >= MAX_DEALERSHIPS) return 0;
	if(DealershipCreated[dealerid]) return 1;
	return 0;
}
LoadFuelStations(){
	new File:handle, count;
	new filename[64], line[256], s, key[64];
	for(new i=1; i < MAX_FUEL_STATIONS; i++){
		format(filename, sizeof(filename), FUEL_STATION_FILE_PATH "f%d.ini", i);
		if(!fexist(filename)) continue;
		handle = fopen(filename, io_read);
		while(fread(handle, line)){
			StripNL(line);
			s = strfind(line, "=");
			if(!line[0] || s < 1) continue;
			strmid(key, line, 0, s++);
			if(strcmp(key, "Created") == 0) FuelStationCreated[i] = strval(line[s]);
			else if(strcmp(key, "Pos") == 0) sscanf(line[s], "p,fff", FuelStationPos[i][0],
				FuelStationPos[i][1], FuelStationPos[i][2]);
		}
		fclose(handle);
		if(FuelStationCreated[i]) count++;
	}
	printf("  Loaded %d fuel stations", count);
}
SaveFuelStation(stationid){
	new filename[64], line[256];
	format(filename, sizeof(filename), FUEL_STATION_FILE_PATH "f%d.ini", stationid);
	new File:handle = fopen(filename, io_write);
	format(line, sizeof(line), "Created=%d\r\n", FuelStationCreated[stationid]); fwrite(handle, line);
	format(line, sizeof(line), "Pos=%.3f,%.3f,%.3f\r\n", FuelStationPos[stationid][0],
		FuelStationPos[stationid][1], FuelStationPos[stationid][2]);
	fwrite(handle, line);
	fclose(handle);
}
UpdateFuelStation(stationid, removeold){
	if(FuelStationCreated[stationid]){
		if(removeold){
			Delete3DTextLabel(FuelStationLabel[stationid]);
		}
		new labeltext[32];
		format(labeltext, sizeof(labeltext), "Fuel Station\nID: %d\n/fuel", stationid);
		FuelStationLabel[stationid] = Create3DTextLabel(labeltext, 0x00BBFFDD, FuelStationPos[stationid][0],
			FuelStationPos[stationid][1], FuelStationPos[stationid][2]+0.5, 20.0, 0);
	}
}
IsValidFuelStation(stationid){
	if(stationid < 1 || stationid >= MAX_FUEL_STATIONS) return 0;
	if(FuelStationCreated[stationid]) return 1;
	return 0;
}
public MainTimer(){
	new string[128];
	new Float:x, Float:y, Float:z;

	for(new i=0; i < MAX_PLAYERS; i++){
		if(IsPlayerConnected(i)){
			if(GetPlayerState(i) == PLAYER_STATE_DRIVER){
				new vehicleid = GetPlayerVehicleID(i);
				if(!IsBicycle(vehicleid) && Fuel[vehicleid] > 0){
					Fuel[vehicleid] -= GetPlayerSpeed(i)/1000.0;
					if(Fuel[vehicleid] <= 0){
						ToggleEngine(vehicleid, VEHICLE_PARAMS_OFF);
						GameTextForPlayer(i, "~r~out of fuel", 3000, 3);
						SendClientMessage(i, COLOR_RED, "This vehicle is out of fuel!");
					}
				}
			}
			if(RefuelTime[i] > 0 && GetPVarInt(i, "FuelStation")){
				new vehicleid = GetPlayerVehicleID(i);
				Fuel[vehicleid] += 2.0;
				RefuelTime[i]--;
				if(RefuelTime[i] == 0){
					if(Fuel[vehicleid] >= 100.0) Fuel[vehicleid] = 100.0;
					new stationid = GetPVarInt(i, "FuelStation");
					new cost = floatround(Fuel[vehicleid]-GetPVarFloat(i, "Fuel"))*FUEL_PRICE;
					if(GetPlayerState(i) != PLAYER_STATE_DRIVER || Fuel[vehicleid] >= 100.0 || GetPlayerMoney(i) < cost
					|| !IsPlayerInRangeOfPoint(i, 10.0, FuelStationPos[stationid][0], FuelStationPos[stationid][1], FuelStationPos[stationid][2])){
						if(GetPlayerMoney(i) < cost) cost = GetPlayerMoney(i);
						GivePlayerMoney(i, -cost);
						format(string, sizeof(string), "~r~-$%d", cost);
						GameTextForPlayer(i, string, 2000, 3);
						format(string, sizeof(string), "You pay $%d for fuel", cost);
						SendClientMessage(i, COLOR_WHITE, string);
						SetPVarInt(i, "FuelStation", 0);
						SetPVarFloat(i, "Fuel", 0.0);
					}
					else
{
						RefuelTime[i] = 5;
						format(string, sizeof(string), "~w~refueling...~n~~r~-$%d", cost);
						GameTextForPlayer(i, string, 2000, 3);
					}
				}
			}
			if(TrackCar[i]){
				GetVehiclePos(TrackCar[i], x, y, z);
				SetPlayerCheckpoint(i, x, y, z, 3);
			}
		}
	}
}
public Speedometer(){
	new vehicleid, Float:health;
	new engine, lights, alarm, doors, bonnet, boot, objective;
	new fstring[32], string[512];

	for(new i=0; i < MAX_PLAYERS; i++){
		if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i)){
			vehicleid = GetPlayerVehicleID(i);
			GetVehicleHealth(vehicleid, health);
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

			string = "~b~~h~vehicle: ~w~";
			strcat(string, VehicleNames[GetVehicleModel(vehicleid)-400], sizeof(string));

			strcat(string, "~n~~b~~h~gps: ~w~", sizeof(string));
			strcat(string, GetPlayer3DZone(i), sizeof(string));

			strcat(string, "~n~~b~~h~health: ~g~", sizeof(string));
			fstring = "iiiiiiiiii";
			if(health > 1000.0) strins(fstring, "~r~", 10, sizeof(fstring));
			else if(health < 0.0) strins(fstring, "~r~", 0, sizeof(fstring));
			else strins(fstring, "~r~", floatround(health/100.0), sizeof(fstring));
			strcat(string, fstring, sizeof(string));

			strcat(string, "        ~b~~h~fuel: ~g~", sizeof(string));
			fstring = "iiiiiiiiii";
			if(Fuel[vehicleid] > 100.0) strins(fstring, "~r~", 10, sizeof(fstring));
			else if(Fuel[vehicleid] < 0.0) strins(fstring, "~r~", 0, sizeof(fstring));
			else strins(fstring, "~r~", floatround(Fuel[vehicleid]/10.0), sizeof(fstring));
			strcat(string, fstring, sizeof(string));

			strcat(string, "        ~b~~h~", sizeof(string));
			if(GetPVarInt(i, "Speedo")) format(fstring,sizeof(fstring),"mph: ~w~%d", GetPlayerSpeed(i, false));
			else format(fstring,sizeof(fstring),"kph: ~w~%d", GetPlayerSpeed(i, true));
			strcat(string, fstring, sizeof(string));

			strcat(string, "~n~~b~~h~engine: ", sizeof(string));
			if(engine == 1) strcat(string, "~g~on", sizeof(string));
			else strcat(string, "~r~off", sizeof(string));

			strcat(string, "        ~b~~h~alarm: ", sizeof(string));
			if(VehicleSecurity[vehicleid] == 1) strcat(string, "~g~on", sizeof(string));
			else strcat(string, "~r~off", sizeof(string));

			strcat(string, "        ~b~~h~doors: ", sizeof(string));
			if(doors == 1) strcat(string, "~r~locked", sizeof(string));
			else strcat(string, "~g~unlocked", sizeof(string));

			TextDrawSetString(SpeedoText[i], string);
		}
	}
}
public SaveTimer(){
	SaveVehicleIndex++;
	if(SaveVehicleIndex >= MAX_DVEHICLES) SaveVehicleIndex = 1;
	if(IsValidVehicle(SaveVehicleIndex)) SaveVehicle(SaveVehicleIndex);
}
public StopAlarm(vehicleid){
	ToggleAlarm(vehicleid, VEHICLE_PARAMS_OFF);
}
/*forward GetVehicleIDFromPlate(Plate[]);
public GetVehicleIDFromPlate(Plate[]){
    for(new i=1; i < MAX_DVEHICLES; i++)    {
        if(VehicleCreated[i] == VEHICLE_PLAYER && strcmp(VehicleNumberPlate[i], Plate) == 0)        {
            return i;
        }
    }
    return 0;
}*/
public OnFilterScriptInit(){
	print("\n------------------------------------------------");
	print("     Advanced Vehicle System 1.0 by MadeMan");
	print("------------------------------------------------");

	LoadVehicles();
	LoadDealerships();
	LoadFuelStations();

	/*SpeedoBox = TextDrawCreate(345.000, 363.000, "~n~~n~~n~~n~");
	TextDrawAlignment(SpeedoBox, 2);
	TextDrawLetterSize(SpeedoBox, 0.500, 1.400);
	TextDrawUseBox(SpeedoBox, 1);
	TextDrawBoxColor(SpeedoBox, 153);
	TextDrawTextSize(SpeedoBox, 0.000, 340.000);*/

	for(new i=0; i < MAX_PLAYERS; i++){
		if(IsPlayerConnected(i)){
			OnPlayerConnect(i);
		}
	}
	for(new i=1; i < MAX_DVEHICLES; i++){
		UpdateVehicle(i, 0);
	}
	for(new i=1; i < MAX_DEALERSHIPS; i++){
		UpdateDealership(i, 0);
	}
	for(new i=1; i < MAX_FUEL_STATIONS; i++){
		UpdateFuelStation(i, 0);
	}

	maintimer = SetTimer("MainTimer", 1000, true);
	speedotimer = SetTimer("Speedometer", 555, true);
	savetimer = SetTimer("SaveTimer", 2222, true);

	print("------------------------------------------------\n");
	return 1;
}
public OnFilterScriptExit(){
	KillTimer(maintimer);
	KillTimer(speedotimer);
	KillTimer(savetimer);
	//TextDrawDestroy(SpeedoBox);
	for(new i=0; i < MAX_PLAYERS; i++){
		if(IsPlayerConnected(i)){
			OnPlayerDisconnect(i, 1);
		}
	}
	for(new i=1; i < MAX_DVEHICLES; i++){
		if(VehicleCreated[i]){
			DestroyVehicle(VehicleID[i]);
			if(VehicleCreated[i] == VEHICLE_DEALERSHIP){
				Delete3DTextLabel(VehicleLabel[i]);
			}
		}
	}
	for(new i=1; i < MAX_DEALERSHIPS; i++){
		if(DealershipCreated[i]){
			Delete3DTextLabel(DealershipLabel[i]);
		}
	}
	for(new i=1; i < MAX_FUEL_STATIONS; i++){
		if(FuelStationCreated[i]){
			Delete3DTextLabel(FuelStationLabel[i]);
		}
	}
	print("\n------------------------------------------------");
	print("     Advanced Vehicle System 1.0 Unloaded");
	print("------------------------------------------------\n");
	return 1;
}
public OnPlayerConnect(playerid){
	RefuelTime[playerid] = 0;
	TrackCar[playerid] = 0;

	SpeedoText[playerid] = TextDrawCreate(180.000, 362.000," ");
	TextDrawAlignment(SpeedoText[playerid], 1);
	TextDrawFont(SpeedoText[playerid],2);
	TextDrawLetterSize(SpeedoText[playerid], 0.310, 1.400);
	TextDrawSetShadow(SpeedoText[playerid],0);
	TextDrawUseBox(SpeedoText[playerid], 1);
	TextDrawBoxColor(SpeedoText[playerid], 0x99);
	TextDrawTextSize(SpeedoText[playerid], 520.000, 0.000);

	return 1;
}
public OnPlayerDisconnect(playerid, reason){
	TextDrawDestroy(SpeedoText[playerid]);
	return 1;
}
public OnVehicleSpawn(vehicleid){
	VehicleSecurity[vehicleid] = 0;
	new id = GetVehicleID(vehicleid);
	if(IsValidVehicle(id)){
		if(VehicleColor[id][0] >= 0 && VehicleColor[id][1] >= 0)			ChangeVehicleColor(vehicleid, VehicleColor[id][0], VehicleColor[id][1]);
		LinkVehicleToInterior(vehicleid, VehicleInterior[id]);
		SetVehicleVirtualWorld(vehicleid, VehicleWorld[id]);
		for(new i=0; i < sizeof(VehicleMods[]); i++){
			AddVehicleComponent(vehicleid, VehicleMods[id][i]);
		}
		ChangeVehiclePaintjob(vehicleid, VehiclePaintjob[id]);
		if(VehicleLock[id]) ToggleDoors(vehicleid, VEHICLE_PARAMS_ON);
		if(VehicleAlarm[id]) VehicleSecurity[vehicleid] = 1;
	}
	return 1;
}
CMD:avshelp(playerid, params[]){
	new info[512];
	strcat(info, "/v  /fix  /flip  /tow  /eject  /ejectall\n", sizeof(info));
	strcat(info, "/vlock  /valarm  /fuel  /trunk  /kph  /mph  /clearmods  /sellv  /givecarkeys  /trackcar\n", sizeof(info));
	if(IsAdmin(playerid, 1)){
		strcat(info, "/addv  /editv  /setfuel  /rac (respawnallcars)  /rtc (respawnthiscar)\n", sizeof(info));
		strcat(info, "/adddealership  /deletedealership  /movedealership  /gotodealership\n", sizeof(info));
		strcat(info, "/addfuelstation  /deletefuelstation  /movefuelstation  /gotofuelstation", sizeof(info));
	}
	ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_MSGBOX, "Advanced Vehicle System Help", info, "OK", "");
	return 1;
}
CMD:fix(playerid, params[]){
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_RED, "You are not driving a vehicle!");
	new vehicleid = GetPlayerVehicleID(playerid);
	RepairVehicle(vehicleid);
	SendClientMessage(playerid, COLOR_WHITE, "Vehicle fixed");
	return 1;
}
CMD:flip(playerid, params[]){
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_RED, "You are not driving a vehicle!");
	new vehicleid = GetPlayerVehicleID(playerid);
	new Float:angle;
	GetVehicleZAngle(vehicleid, angle);
	SetVehicleZAngle(vehicleid, angle);
	SendClientMessage(playerid, COLOR_WHITE, "Vehicle flipped");
	return 1;
}
CMD:tow(playerid, params[]){
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_RED, "You are not driving a vehicle!");
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsTrailerAttachedToVehicle(vehicleid)){
		DetachTrailerFromVehicle(vehicleid);
		SendClientMessage(playerid, COLOR_WHITE, "You are not towing anymore");
		return 1;
	}
	new Float:x, Float:y, Float:z;
	new Float:dist, Float:closedist=8, closeveh;
	for(new i=1; i < MAX_VEHICLES; i++){
		if(i != vehicleid && GetVehiclePos(i, x, y, z)){
			dist = GetPlayerDistanceFromPoint(playerid, x, y, z);
			if(dist < closedist){
				closedist = dist;
				closeveh = i;
			}
		}
	}
	if(!closeveh) return SendClientMessage(playerid, COLOR_RED, "You are not close to a vehicle!");
	AttachTrailerToVehicle(closeveh, vehicleid);
	SendClientMessage(playerid, COLOR_WHITE, "You are now towing a vehicle");
	return 1;
}
CMD:kph(playerid, params[]){
	SetPVarInt(playerid, "Speedo", 0);
	SendClientMessage(playerid, COLOR_WHITE, "Speedometer units set to KPH");
	return 1;
}
CMD:mph(playerid, params[]){
	SetPVarInt(playerid, "Speedo", 1);
	SendClientMessage(playerid, COLOR_WHITE, "Speedometer units set to MPH");
	return 1;
}
CMD:eject(playerid, params[]){
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_RED, "You are not driving a vehicle!");
	new pid, msg[128];
	if(sscanf(params, "u", pid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /eject [player]");
	if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_RED, "Invalid player!");
	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsPlayerInVehicle(pid, vehicleid)) return SendClientMessage(playerid, COLOR_RED, "Player is not in your vehicle!");
	RemovePlayerFromVehicle(pid);
	format(msg, sizeof(msg), "Vehicle driver %s (%d) has ejected you", PlayerName(playerid), playerid);
	SendClientMessage(pid, COLOR_WHITE, msg);
	format(msg, sizeof(msg), "You have ejected %s (%d) from your vehicle", PlayerName(pid), pid);
	SendClientMessage(playerid, COLOR_WHITE, msg);
	return 1;
}
CMD:ejectall(playerid, params[]){
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_RED, "You are not driving a vehicle!");
	new vehicleid = GetPlayerVehicleID(playerid);
	new msg[128];
	format(msg, sizeof(msg), "Vehicle driver %s (%d) has ejected you", PlayerName(playerid), playerid);
	for(new i=0; i < MAX_PLAYERS; i++){
		if(IsPlayerConnected(i) && i != playerid && IsPlayerInVehicle(i, vehicleid)){
			RemovePlayerFromVehicle(i);
			SendClientMessage(i, COLOR_WHITE, msg);
		}
	}
	SendClientMessage(playerid, COLOR_WHITE, "You have ejected all passengers");
	return 1;
}
CMD:clearmods(playerid, params[]){
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_RED, "You are not driving a vehicle!");
	new vehicleid = GetPlayerVehicleID(playerid);
	new id = GetVehicleID(vehicleid);
	if(GetPlayerVehicleAccess(playerid, id) < 2)		return SendClientMessage(playerid, COLOR_RED, "This is not your vehicle!");
	for(new i=0; i < sizeof(VehicleMods[]); i++){
		RemoveVehicleComponent(VehicleID[id], GetVehicleComponentInSlot(VehicleID[id], i));
		VehicleMods[id][i] = 0;
	}
	VehiclePaintjob[id] = 255;
	ChangeVehiclePaintjob(VehicleID[id], 255);
	SaveVehicle(id);
	SendClientMessage(playerid, COLOR_WHITE, "You have removed all modifications from your vehicle");
	return 1;
}
CMD:trackcar(playerid, params[]){
	if(TrackCar[playerid]){
		TrackCar[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
		SendClientMessage(playerid, COLOR_WHITE, "You are not tracking your vehicle anymore");
		return 1;
	}
	new playername[24];
	GetPlayerName(playerid, playername, sizeof(playername));
	new info[256], bool:found;
	for(new i=1; i < MAX_DVEHICLES; i++){
		if(VehicleCreated[i] == VEHICLE_PLAYER && strcmp(VehicleOwner[i], playername) == 0){
			found = true;
			format(info, sizeof(info), "%sID: %d  Name: %s\n", info, i, VehicleNames[VehicleModel[i]-400]);
		}
	}
	if(!found) return SendClientMessage(playerid, COLOR_RED, "You don't have any vehicles!");
	ShowPlayerDialog(playerid, DIALOG_FINDVEHICLE, DIALOG_STYLE_LIST, "Find Your Vehicle", info, "Find", "Cancel");
	return 1;
}
CMD:v(playerid, params[]){
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_RED, "You are not driving a vehicle!");
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsBicycle(vehicleid)) return SendClientMessage(playerid, COLOR_RED, "You are not driving a vehicle!");
	new id = GetVehicleID(vehicleid);
	if(GetPlayerVehicleAccess(playerid, id) < 1)		return SendClientMessage(playerid, COLOR_RED, "You don't have the keys for this vehicle!");
	SetPVarInt(playerid, "DialogValue1", id);
	ShowDialog(playerid, DIALOG_VEHICLE);
	return 1;
}
CMD:sellv(playerid, params[]){
	new pid, id, price, msg[128];
	if(sscanf(params, "udd", pid, id, price)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /sellv [player] [vehicleid] [price]");
	if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_RED, "Invalid player!");
	if(GetPlayerVehicleAccess(playerid, id) < 2)		return SendClientMessage(playerid, COLOR_RED, "You are not the owner of this vehicle!");
	if(price < 1) return SendClientMessage(playerid, COLOR_RED, "Invalid price!");
	if(!PlayerToPlayer(playerid, pid, 10.0)) return SendClientMessage(playerid, COLOR_RED, "Player is too far!");
	SetPVarInt(pid, "DialogValue1", playerid);
	SetPVarInt(pid, "DialogValue2", id);
	SetPVarInt(pid, "DialogValue3", price);
	ShowDialog(pid, DIALOG_VEHICLE_SELL);
	format(msg, sizeof(msg), "You have offered %s (%d) to buy your vehicle for $%d", PlayerName(pid), pid, price);
	SendClientMessage(playerid, COLOR_WHITE, msg);
	return 1;
}
CMD:givecarkeys(playerid, params[]){
	new pid, id, msg[128];
	if(sscanf(params, "ud", pid, id)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /givecarkeys [player] [vehicleid]");
	if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_RED, "Invalid player!");
	if(!IsValidVehicle(id)) return SendClientMessage(playerid, COLOR_RED, "Invalid vehicleid!");
	if(GetPlayerVehicleAccess(playerid, id) < 2)		return SendClientMessage(playerid, COLOR_RED, "You are not the owner of this vehicle!");
	if(!PlayerToPlayer(playerid, pid, 10.0)) return SendClientMessage(playerid, COLOR_RED, "Player is too far!");
	SetPVarInt(pid, "CarKeys", id);
	format(msg, sizeof(msg), "You have given your car keys to %s (%d)", PlayerName(pid), pid);
	SendClientMessage(playerid, COLOR_WHITE, msg);
	format(msg, sizeof(msg), "%s (%d) has given you car keys", PlayerName(playerid), playerid);
	SendClientMessage(pid, COLOR_WHITE, msg);
	return 1;
}
CMD:vlock(playerid, params[]){
	new vehicleid;
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
		vehicleid = GetPlayerVehicleID(playerid);
	}
	else
{
		vehicleid = GetClosestVehicle(playerid);
		if(!PlayerToVehicle(playerid, vehicleid, 5.0)) vehicleid = 0;
	}
	if(!vehicleid) return SendClientMessage(playerid, COLOR_RED, "You are not close to a vehicle!");
	new id = GetVehicleID(vehicleid);
	if(!IsValidVehicle(id)) return SendClientMessage(playerid, COLOR_RED, "You don't have the keys for this vehicle!");
	if(GetPlayerVehicleAccess(playerid, id) < 2)		return SendClientMessage(playerid, COLOR_RED, "You don't have the keys for this vehicle!");
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	if(doors == 1){
		doors = 0;
		VehicleLock[id] = 0;
		GameTextForPlayer(playerid, "~g~doors unlocked", 3000, 6);
	}
	else
{
		doors = 1;
		VehicleLock[id] = 1;
		GameTextForPlayer(playerid, "~r~doors locked", 3000, 6);
	}
	SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SaveVehicle(id);
	return 1;
}
CMD:valarm(playerid, params[]){
	new vehicleid;
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
		vehicleid = GetPlayerVehicleID(playerid);
	}
	else
{
		vehicleid = GetClosestVehicle(playerid);
		if(!PlayerToVehicle(playerid, vehicleid, 5.0)) vehicleid = 0;
	}
	if(!vehicleid) return SendClientMessage(playerid, COLOR_RED, "You are not close to a vehicle!");
	new id = GetVehicleID(vehicleid);
	if(!IsValidVehicle(id)) return SendClientMessage(playerid, COLOR_RED, "You don't have the keys for this vehicle!");
	if(GetPlayerVehicleAccess(playerid, id) < 2)		return SendClientMessage(playerid, COLOR_RED, "You don't have the keys for this vehicle!");
	if(VehicleSecurity[vehicleid] == 0){
		VehicleSecurity[vehicleid] = 1;
		VehicleAlarm[id] = 1;
		GameTextForPlayer(playerid, "~g~alarm on", 3000, 6);
	}
	else
{
		ToggleAlarm(vehicleid, VEHICLE_PARAMS_OFF);
		VehicleSecurity[vehicleid] = 0;
		VehicleAlarm[id] = 0;
		GameTextForPlayer(playerid, "~r~alarm off", 3000, 6);
	}
	SaveVehicle(id);
	return 1;
}
CMD:trunk(playerid, params[]){
	new vehicleid = GetClosestVehicle(playerid);
	if(!PlayerToVehicle(playerid, vehicleid, 5.0)) vehicleid = 0;
	if(!vehicleid || IsBicycle(vehicleid) || IsPlayerInAnyVehicle(playerid))		return SendClientMessage(playerid, COLOR_RED, "You are not close to a vehicle!");
	new id = GetVehicleID(vehicleid);
	if(!IsValidVehicle(id)) return SendClientMessage(playerid, COLOR_RED, "You don't have the keys for this vehicle!");
	if(GetPlayerVehicleAccess(playerid, id) < 2)		return SendClientMessage(playerid, COLOR_RED, "You don't have the keys for this vehicle!");
	ToggleBoot(vehicleid, VEHICLE_PARAMS_ON);
	SetPVarInt(playerid, "DialogValue1", id);
	ShowDialog(playerid, DIALOG_TRUNK);
	return 1;
}
CMD:fuel(playerid, params[]){
	for(new i=1; i < MAX_FUEL_STATIONS; i++){
		if(FuelStationCreated[i]){
			if(IsPlayerInRangeOfPoint(playerid, 15.0, FuelStationPos[i][0], FuelStationPos[i][1], FuelStationPos[i][2])){
				SetPVarInt(playerid, "FuelStation", i);
				ShowDialog(playerid, DIALOG_FUEL);
				return 1;
			}
		}
	}
	SendClientMessage(playerid, COLOR_RED, "You are not in a fuel station!");
	return 1;
}
CMD:rtc(playerid, params[]){
	if(!IsAdmin(playerid, 1)) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED, "You are not in a vehicle!");
	SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	SendClientMessage(playerid, COLOR_WHITE, "Vehicle respawned");
	return 1;
}
CMD:rac(playerid, params[]){
	if(!IsAdmin(playerid, 1)) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	new bool:vehicleused[MAX_VEHICLES];
	for(new i=0; i < MAX_PLAYERS; i++){
		if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i)){
			vehicleused[GetPlayerVehicleID(i)] = true;
		}
	}
	for(new i=1; i < MAX_VEHICLES; i++){
		if(!vehicleused[i]){
			SetVehicleToRespawn(i);
		}
	}
	new msg[128];
	format(msg, sizeof(msg), "Admin %s (%d) has respawned all unused vehicles", PlayerName(playerid), playerid);
	SendClientMessageToAll(COLOR_YELLOW, msg);
	return 1;
}
CMD:setfuel(playerid, params[]){
	if(!IsAdmin(playerid, 1)) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED, "You are not in a vehicle!");
	new amount, msg[128];
	if(sscanf(params, "d", amount)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /setfuel [amount]");
	if(amount < 0 || amount > 100) return SendClientMessage(playerid, COLOR_RED, "Invalid amount! (0-100)");
	Fuel[GetPlayerVehicleID(playerid)] = amount;
	format(msg, sizeof(msg), "You have set your vehicle fuel to %d", amount);
	SendClientMessage(playerid, COLOR_WHITE, msg);
	return 1;
}
CMD:addv(playerid, params[]){
	if(!IsAdmin(playerid, 1)) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	if(!IsPlayerSpawned(playerid)) return SendClientMessage(playerid, COLOR_RED, "You can't use this command now!");
	new model[32], modelid, dealerid, color1, color2, price;
	if(sscanf(params, "dsddd", dealerid, model, color1, color2, price))		return SendClientMessage(playerid, COLOR_GREY, "USAGE: /addv [dealerid] [model] [color1] [color2] [price]");
	if(!IsValidDealership(dealerid)) return SendClientMessage(playerid, COLOR_RED, "Invalid dealerid!");
	if(IsNumeric(model)) modelid = strval(model);
	else modelid = GetVehicleModelIDFromName(model);
	if(modelid < 400 || modelid > 611) return SendClientMessage(playerid, COLOR_RED, "Invalid model ID!");
	if(color1 < 0 || color2 < 0) return SendClientMessage(playerid, COLOR_RED, "Invalid color!");
	if(price < 0) return SendClientMessage(playerid, COLOR_RED, "Invalid price!");
	new Float:X, Float:Y, Float:Z, Float:angle;
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, angle);
	X += floatmul(floatsin(-angle, degrees), 4.0);
	Y += floatmul(floatcos(-angle, degrees), 4.0);
	for(new i=1; i < MAX_DVEHICLES; i++){
		if(!VehicleCreated[i]){
			new msg[128];
			VehicleCreated[i] = VEHICLE_DEALERSHIP;
			VehicleModel[i] = modelid;
			VehiclePos[i][0] = X;
			VehiclePos[i][1] = Y;
			VehiclePos[i][2] = Z;
			VehiclePos[i][3] = angle+90.0;
			VehicleColor[i][0] = color1;
			VehicleColor[i][1] = color2;
			VehicleInterior[i] = GetPlayerInterior(playerid);
			VehicleWorld[i] = GetPlayerVirtualWorld(playerid);
			VehicleValue[i] = price;
			valstr(VehicleOwner[i], dealerid);
			VehicleNumberPlate[i] = DEFAULT_NUMBER_PLATE;
			for(new d=0; d < sizeof(VehicleTrunk[]); d++){
				VehicleTrunk[i][d][0] = 0;
				VehicleTrunk[i][d][1] = 0;
			}
			for(new d=0; d < sizeof(VehicleMods[]); d++){
				VehicleMods[i][d] = 0;
			}
			VehiclePaintjob[i] = 255;
			VehicleLock[i] = 0;
			VehicleAlarm[i] = 0;
			UpdateVehicle(i, 0);
			SaveVehicle(i);
			format(msg, sizeof(msg), "Added vehicle id %d to dealerid %d", i, dealerid);
			SendClientMessage(playerid, COLOR_WHITE, msg);
			return 1;
		}
	}
	SendClientMessage(playerid, COLOR_RED, "Can't add any more vehicles!");
	return 1;
}
CMD:editv(playerid, params[]){
	if(!IsAdmin(playerid, 1)) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
		new id = GetVehicleID(GetPlayerVehicleID(playerid));
		if(!IsValidVehicle(id)) return SendClientMessage(playerid, COLOR_RED, "This is not a dynamic vehicle!");
		SetPVarInt(playerid, "DialogValue1", id);
		ShowDialog(playerid, DIALOG_EDITVEHICLE);
		return 1;
	}
	new vehicleid;
	if(sscanf(params, "d", vehicleid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /editv [vehicleid]");
	if(!IsValidVehicle(vehicleid)) return SendClientMessage(playerid, COLOR_RED, "Invalid vehicleid!");
	SetPVarInt(playerid, "DialogValue1", vehicleid);
	ShowDialog(playerid, DIALOG_EDITVEHICLE);
	return 1;
}
CMD:adddealership(playerid, params[]){
	if(!IsAdmin(playerid, 1)) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	if(!IsPlayerSpawned(playerid)) return SendClientMessage(playerid, COLOR_RED, "You can't use this command now!");
	for(new i=1; i < MAX_DEALERSHIPS; i++){
		if(!DealershipCreated[i]){
			new msg[128];
			DealershipCreated[i] = 1;
			GetPlayerPos(playerid, DealershipPos[i][0], DealershipPos[i][1], DealershipPos[i][2]);
			UpdateDealership(i, 0);
			SaveDealership(i);
			format(msg, sizeof(msg), "Added dealership id %d", i);
			SendClientMessage(playerid, COLOR_WHITE, msg);
			return 1;
		}
	}
	SendClientMessage(playerid, COLOR_RED, "Can't add any more dealerships!");
	return 1;
}
CMD:deletedealership(playerid, params[]){
	if(!IsAdmin(playerid, 1)) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	new dealerid, msg[128];
	if(sscanf(params, "d", dealerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /deletedealership [dealerid]");
	if(!IsValidDealership(dealerid)) return SendClientMessage(playerid, COLOR_RED, "Invalid dealerid!");
	for(new i=1; i < MAX_DVEHICLES; i++){
		if(VehicleCreated[i] == VEHICLE_DEALERSHIP && strval(VehicleOwner[i]) == dealerid){
			DestroyVehicle(VehicleID[i]);
			Delete3DTextLabel(VehicleLabel[i]);
			VehicleCreated[i] = 0;
		}
	}
	DealershipCreated[dealerid] = 0;
	Delete3DTextLabel(DealershipLabel[dealerid]);
	SaveDealership(dealerid);
	format(msg, sizeof(msg), "Deleted dealership id %d", dealerid);
	SendClientMessage(playerid, COLOR_WHITE, msg);
	return 1;
}
CMD:movedealership(playerid, params[]){
	if(!IsAdmin(playerid, 1)) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	new dealerid, msg[128];
	if(sscanf(params, "d", dealerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /movedealership [dealerid]");
	if(!IsValidDealership(dealerid)) return SendClientMessage(playerid, COLOR_RED, "Invalid dealerid!");
	GetPlayerPos(playerid, DealershipPos[dealerid][0], DealershipPos[dealerid][1], DealershipPos[dealerid][2]);
	UpdateDealership(dealerid, 1);
	SaveDealership(dealerid);
	format(msg, sizeof(msg), "Moved dealership id %d here", dealerid);
	SendClientMessage(playerid, COLOR_WHITE, msg);
	return 1;
}
CMD:gotodealership(playerid, params[]){
	if(!IsAdmin(playerid, 1)) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	new dealerid, msg[128];
	if(sscanf(params, "d", dealerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /gotodealership [dealerid]");
	if(!IsValidDealership(dealerid)) return SendClientMessage(playerid, COLOR_RED, "Invalid dealerid!");
	SetPlayerPos(playerid, DealershipPos[dealerid][0], DealershipPos[dealerid][1], DealershipPos[dealerid][2]);
	format(msg, sizeof(msg), "Teleported to dealership id %d", dealerid);
	SendClientMessage(playerid, COLOR_WHITE, msg);
	return 1;
}
CMD:addfuelstation(playerid, params[]){
	if(!IsAdmin(playerid, 1)) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	if(!IsPlayerSpawned(playerid)) return SendClientMessage(playerid, COLOR_RED, "You can't use this command now!");
	for(new i=1; i < MAX_FUEL_STATIONS; i++){
		if(!FuelStationCreated[i]){
			new msg[128];
			FuelStationCreated[i] = 1;
			GetPlayerPos(playerid, FuelStationPos[i][0], FuelStationPos[i][1], FuelStationPos[i][2]);
			UpdateFuelStation(i, 0);
			SaveFuelStation(i);
			format(msg, sizeof(msg), "Added fuel station id %d", i);
			SendClientMessage(playerid, COLOR_WHITE, msg);
			return 1;
		}
	}
	SendClientMessage(playerid, COLOR_RED, "Can't add any more fuel stations!");
	return 1;
}
CMD:deletefuelstation(playerid, params[]){
	if(!IsAdmin(playerid, 1)) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	new stationid, msg[128];
	if(sscanf(params, "d", stationid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /deletefuelstation [stationid]");
	if(!IsValidFuelStation(stationid)) return SendClientMessage(playerid, COLOR_RED, "Invalid stationid!");
	FuelStationCreated[stationid] = 0;
	Delete3DTextLabel(FuelStationLabel[stationid]);
	SaveFuelStation(stationid);
	format(msg, sizeof(msg), "Deleted fuel station id %d", stationid);
	SendClientMessage(playerid, COLOR_WHITE, msg);
	return 1;
}
CMD:movefuelstation(playerid, params[]){
	if(!IsAdmin(playerid, 1)) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	new stationid, msg[128];
	if(sscanf(params, "d", stationid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /movefuelstation [stationid]");
	if(!IsValidFuelStation(stationid)) return SendClientMessage(playerid, COLOR_RED, "Invalid stationid!");
	GetPlayerPos(playerid, FuelStationPos[stationid][0], FuelStationPos[stationid][1], FuelStationPos[stationid][2]);
	UpdateFuelStation(stationid, 1);
	SaveFuelStation(stationid);
	format(msg, sizeof(msg), "Moved fuel station id %d here", stationid);
	SendClientMessage(playerid, COLOR_WHITE, msg);
	return 1;
}
CMD:gotofuelstation(playerid, params[]){
	if(!IsAdmin(playerid, 1)) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	new stationid, msg[128];
	if(sscanf(params, "d", stationid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /gotofuelstation [stationid]");
	if(!IsValidFuelStation(stationid)) return SendClientMessage(playerid, COLOR_RED, "Invalid stationid!");
	SetPlayerPos(playerid, FuelStationPos[stationid][0], FuelStationPos[stationid][1], FuelStationPos[stationid][2]);
	format(msg, sizeof(msg), "Teleported to fuel station id %d", stationid);
	SendClientMessage(playerid, COLOR_WHITE, msg);
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[]){
	new pos, funcname[32];
	while(cmdtext[++pos] > ' '){
		funcname[pos-1] = tolower(cmdtext[pos]);
	}
	strins(funcname, "cmd_", 0, sizeof(funcname));
	while (cmdtext[pos] == ' ') pos++;
	if(!cmdtext[pos]){
		return CallLocalFunction(funcname, "is", playerid, "\1");
	}
	return CallLocalFunction(funcname, "is", playerid, cmdtext[pos]);
}
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger){
	if(!ispassenger){
		new id = GetVehicleID(vehicleid);
		if(IsValidVehicle(id) && VehicleCreated[id] == VEHICLE_PLAYER){
			new msg[128];
			format(msg, sizeof(msg), "This vehicle belongs to %s", VehicleOwner[id]);
			SendClientMessage(playerid, COLOR_GREY, msg);
		}
	}
	return 1;
}
public OnPlayerStateChange(playerid, newstate, oldstate){
	if(IsPlayerInAnyVehicle(playerid) && !IsBicycle(GetPlayerVehicleID(playerid))){
		//TextDrawShowForPlayer(playerid, SpeedoBox);
		TextDrawShowForPlayer(playerid, SpeedoText[playerid]);
		new vehicleid = GetPlayerVehicleID(playerid);
		if(VehicleSecurity[vehicleid] == 1){
			ToggleAlarm(vehicleid, VEHICLE_PARAMS_ON);
			SetTimerEx("StopAlarm", ALARM_TIME, false, "d", vehicleid);
		}
	}
	else
{
		//TextDrawHideForPlayer(playerid, SpeedoBox);
		TextDrawHideForPlayer(playerid, SpeedoText[playerid]);
	}
	if(newstate == PLAYER_STATE_DRIVER){
		new vehicleid = GetPlayerVehicleID(playerid);
		new id = GetVehicleID(vehicleid);
		if(IsValidVehicle(id)){
			if(VehicleCreated[id] == VEHICLE_DEALERSHIP){
				SetPVarInt(playerid, "DialogValue1", id);
				ShowDialog(playerid, DIALOG_VEHICLE_BUY);
				return 1;
			}
		}
		if(IsBicycle(vehicleid)){
			ToggleEngine(vehicleid, VEHICLE_PARAMS_ON);
		}
		if(Fuel[vehicleid] <= 0){
			ToggleEngine(vehicleid, VEHICLE_PARAMS_OFF);
		}
	}
	return 1;
}
public OnVehicleMod(playerid, vehicleid, componentid){
	new id = GetVehicleID(vehicleid);
	if(IsValidVehicle(id)){
		VehicleMods[id][GetVehicleComponentType(componentid)] = componentid;
		SaveVehicle(id);
	}
	return 1;
}
public OnVehiclePaintjob(playerid, vehicleid, paintjobid){
	new id = GetVehicleID(vehicleid);
	if(IsValidVehicle(id)){
		VehiclePaintjob[id] = paintjobid;
		SaveVehicle(id);
	}
	return 1;
}
public OnVehicleRespray(playerid, vehicleid, color1, color2){
	new id = GetVehicleID(vehicleid);
	if(IsValidVehicle(id)){
		VehicleColor[id][0] = color1;
		VehicleColor[id][1] = color2;
		SaveVehicle(id);
	}
	return 1;
}
ShowDialog(playerid, dialogid){
	switch(dialogid){
		case DIALOG_VEHICLE:
{
			new vehicleid = GetPVarInt(playerid, "DialogValue1");
			new caption[32], info[256];
			format(caption, sizeof(caption), "Vehicle ID %d", vehicleid);
			strcat(info, "Engine\nLights\nHood\nTrunk", sizeof(info));
			strcat(info, "\nFill Tank", sizeof(info));
			if(GetPlayerVehicleAccess(playerid, vehicleid) >= 2){
				new value = VehicleValue[vehicleid]/2;
				format(info, sizeof(info), "%s\nSell Vehicle  ($%d)\nPark Vehicle\nEdit License Plate", info, value);
			}
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, caption, info, "Select", "Cancel");
		}
		case DIALOG_VEHICLE_BUY:
{
			new vehicleid = GetPVarInt(playerid, "DialogValue1");
			new caption[32], info[256];
			format(caption, sizeof(caption), "Vehicle ID %d", vehicleid);
			format(info, sizeof(info), "This vehicle is for sale ($%d)\nWould you like to buy it?", VehicleValue[vehicleid]);
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, caption, info, "Yes", "No");
		}
		case DIALOG_VEHICLE_SELL:
{
			new targetid = GetPVarInt(playerid, "DialogValue1");
			new id = GetPVarInt(playerid, "DialogValue2");
			new price = GetPVarInt(playerid, "DialogValue3");
			new info[256];
			format(info, sizeof(info), "%s (%d) wants to sell you a %s for $%d.", PlayerName(targetid), targetid,
				VehicleNames[VehicleModel[id]-400], price);
			strcat(info, "\n\nWould you like to buy?", sizeof(info));
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, "Buy Vehicle", info, "Yes", "No");
		}
		case DIALOG_TRUNK:
{
			new vehicleid = GetPVarInt(playerid, "DialogValue1");
			new name[32], info[256];
			for(new i=0; i < sizeof(VehicleTrunk[]); i++){
				if(VehicleTrunk[vehicleid][i][1] > 0){
					GetWeaponName(VehicleTrunk[vehicleid][i][0], name, sizeof(name));
					format(info, sizeof(info), "%s%d. %s (%d)\n", info, i+1, name, VehicleTrunk[vehicleid][i][1]);
				}
				else
{
					format(info, sizeof(info), "%s%d. Empty\n", info, i+1);
				}
			}
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, "Trunk", info, "Select", "Cancel");
		}
		case DIALOG_TRUNK_ACTION:
{
			new info[128];
			strcat(info, "Put Into Trunk\nTake From Trunk", sizeof(info));
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, "Trunk", info, "Select", "Cancel");
		}
		case DIALOG_VEHICLE_PLATE:
{
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, "Edit License Plate", "Enter new license plate:", "Change", "Back");
		}
		case DIALOG_FUEL:
{
			new info[128];
			strcat(info, "Refuel Vehicle  ($" #FUEL_PRICE ")\nBuy Gas Can  ($" #GAS_CAN_PRICE ")", sizeof(info));
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, "Fuel Station", info, "OK", "Cancel");
		}
		case DIALOG_EDITVEHICLE:
{
			new vehicleid = GetPVarInt(playerid, "DialogValue1");
			new caption[32], info[256];
			format(caption, sizeof(caption), "Edit Vehicle ID %d", vehicleid);
			format(info, sizeof(info), "1. Value: [$%d]\n2. Model: [%d (%s)]\n3. Colors: [%d]  [%d]\n4. License Plate: [%s]",
				VehicleValue[vehicleid], VehicleModel[vehicleid], VehicleNames[VehicleModel[vehicleid]-400],
				VehicleColor[vehicleid][0], VehicleColor[vehicleid][1], VehicleNumberPlate[vehicleid]);
			strcat(info, "\n5. Delete Vehicle\n6. Park Vehicle\n7. Go To Vehicle", sizeof(info));
			strcat(info, "\n\nEnter: [nr] [value1] [value2]", sizeof(info));
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, caption, info, "OK", "Cancel");
		}
	}
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]){
	if(dialogid == DIALOG_ERROR){
		ShowDialog(playerid, DialogReturn[playerid]);
		return 1;
	}
	DialogReturn[playerid] = dialogid;
	if(dialogid == DIALOG_VEHICLE){
		if(response){
			switch(listitem){
				case 0:
{
					new vehicleid = GetPlayerVehicleID(playerid);
					new engine, lights, alarm, doors, bonnet, boot, objective;
					GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					if(engine == 0 && Fuel[vehicleid] <= 0){
						ShowErrorDialog(playerid, "This vehicle is out of fuel!");
						return 1;
					}
					if(engine == 1) { engine = 0; lights = 0; }
					else { engine = 1; lights = 1; }
					SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
				}
				case 1:
{
					new vehicleid = GetPlayerVehicleID(playerid);
					new engine, lights, alarm, doors, bonnet, boot, objective;
					GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					if(lights == 1) lights = 0; else lights = 1;
					SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
				}
				case 2:
{
					new vehicleid = GetPlayerVehicleID(playerid);
					new engine, lights, alarm, doors, bonnet, boot, objective;
					GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					if(bonnet == 1) bonnet = 0; else bonnet = 1;
					SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
				}
				case 3:
{
					new vehicleid = GetPlayerVehicleID(playerid);
					new engine, lights, alarm, doors, bonnet, boot, objective;
					GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					if(boot == 1) boot = 0; else boot = 1;
					SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
				}
				case 4:
{
					if(!GetPVarInt(playerid, "GasCan")){
						ShowErrorDialog(playerid, "You don't have a gas can!");
						return 1;
					}
					new vehicleid = GetPlayerVehicleID(playerid);
					if(Fuel[vehicleid] < 80.0) Fuel[vehicleid] += 20.0;
					else Fuel[vehicleid] = 100.0;
					SetPVarInt(playerid, "GasCan", 0);
					SendClientMessage(playerid, COLOR_WHITE, "You have filled the fuel tank with 20 fuel");
				}
				case 5:
{
					new id = GetPVarInt(playerid, "DialogValue1");
					if(GetPlayerVehicleAccess(playerid, id) < 2){
						ShowErrorDialog(playerid, "You are not the owner of this vehicle!");
						return 1;
					}
					new msg[128];
					VehicleCreated[id] = 0;
					new money = VehicleValue[id]/2;
					GivePlayerMoney(playerid, money);
					format(msg, sizeof(msg), "You have sold your vehicle for $%d", money);
					SendClientMessage(playerid, COLOR_WHITE, msg);
					RemovePlayerFromVehicle(playerid);
					DestroyVehicle(VehicleID[id]);
					SaveVehicle(id);
				}
				case 6:
{
					new vehicleid = GetPVarInt(playerid, "DialogValue1");
					if(GetPlayerVehicleAccess(playerid, vehicleid) < 2){
						ShowErrorDialog(playerid, "You are not the owner of this vehicle!");
						return 1;
					}
					GetVehiclePos(VehicleID[vehicleid], VehiclePos[vehicleid][0], VehiclePos[vehicleid][1], VehiclePos[vehicleid][2]);
					GetVehicleZAngle(VehicleID[vehicleid], VehiclePos[vehicleid][3]);
					VehicleInterior[vehicleid] = GetPlayerInterior(playerid);
					VehicleWorld[vehicleid] = GetPlayerVirtualWorld(playerid);
					SendClientMessage(playerid, COLOR_WHITE, "You have parked this vehicle here");
					UpdateVehicle(vehicleid, 1);
					PutPlayerInVehicle(playerid, VehicleID[vehicleid], 0);
					SaveVehicle(vehicleid);
				}
				case 7:
{
					ShowDialog(playerid, DIALOG_VEHICLE_PLATE);
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_VEHICLE_BUY){
		if(response){
			if(GetPlayerVehicles(playerid) >= MAX_PLAYER_VEHICLES){
				ShowErrorDialog(playerid, "You can't buy any more vehicles! Max: " #MAX_PLAYER_VEHICLES );
				return 1;
			}
			new id = GetPVarInt(playerid, "DialogValue1");
			if(GetPlayerMoney(playerid) < VehicleValue[id]){
				ShowErrorDialog(playerid, "You don't have enough money to buy this vehicle!");
				return 1;
			}
			new freeid = GetFreeVehicleID();
			if(!freeid){
				ShowErrorDialog(playerid, "Vehicle dealership is out of stock!");
				return 1;
			}
			GivePlayerMoney(playerid, -VehicleValue[id]);
			new dealerid = strval(VehicleOwner[id]);
			VehicleCreated[freeid] = VEHICLE_PLAYER;
			VehicleModel[freeid] = VehicleModel[id];
			VehiclePos[freeid] = DealershipPos[dealerid];
			VehicleColor[freeid] = VehicleColor[id];
			VehicleInterior[freeid] = VehicleInterior[id];
			VehicleWorld[freeid] = VehicleWorld[id];
			VehicleValue[freeid] = VehicleValue[id];
			GetPlayerName(playerid, VehicleOwner[freeid], sizeof(VehicleOwner[]));
			VehicleNumberPlate[freeid] = DEFAULT_NUMBER_PLATE;
			for(new d=0; d < sizeof(VehicleTrunk[]); d++){
				VehicleTrunk[freeid][d][0] = 0;
				VehicleTrunk[freeid][d][1] = 0;
			}
			for(new d=0; d < sizeof(VehicleMods[]); d++){
				VehicleMods[freeid][d] = 0;
			}
			VehiclePaintjob[freeid] = 255;
			VehicleLock[freeid] = 0;
			VehicleAlarm[freeid] = 0;
			UpdateVehicle(freeid, 0);
			SaveVehicle(freeid);
			new msg[128];
			format(msg, sizeof(msg), "You have bought this vehicle for $%d", VehicleValue[id]);
			SendClientMessage(playerid, COLOR_WHITE, msg);
		}
		else
{
			new id = GetPVarInt(playerid, "DialogValue1");
			if(GetPlayerVehicleAccess(playerid, id) < 1){
				RemovePlayerFromVehicle(playerid);
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_VEHICLE_SELL){
		if(response){
			if(GetPlayerVehicles(playerid) >= MAX_PLAYER_VEHICLES){
				ShowErrorDialog(playerid, "You can't buy any more vehicles! Max: " #MAX_PLAYER_VEHICLES );
				return 1;
			}
			new targetid = GetPVarInt(playerid, "DialogValue1");
			new id = GetPVarInt(playerid, "DialogValue2");
			new price = GetPVarInt(playerid, "DialogValue3");
			if(GetPlayerMoney(playerid) < price){
				ShowErrorDialog(playerid, "You don't have enough money to buy this vehicle!");
				return 1;
			}
			new msg[128];
			GetPlayerName(playerid, VehicleOwner[id], sizeof(VehicleOwner[]));
			GivePlayerMoney(playerid, -price);
			GivePlayerMoney(targetid, price);
			SaveVehicle(id);
			format(msg, sizeof(msg), "You have bought this vehicle for $%d", price);
			SendClientMessage(playerid, COLOR_WHITE, msg);
			format(msg, sizeof(msg), "%s (%d) has accepted your offer and bought the vehicle", PlayerName(playerid), playerid);
			SendClientMessage(targetid, COLOR_WHITE, msg);
		}
		else
{
			new targetid = GetPVarInt(playerid, "DialogValue1");
			new msg[128];
			format(msg, sizeof(msg), "%s (%d) refused your offer", PlayerName(playerid), playerid);
			SendClientMessage(targetid, COLOR_WHITE, msg);
		}
		return 1;
	}
	if(dialogid == DIALOG_FINDVEHICLE){
		if(response){
			new id;
			sscanf(inputtext[4], "d", id);
			if(IsValidVehicle(id)){
				TrackCar[playerid] = VehicleID[id];
				SendClientMessage(playerid, COLOR_WHITE, "Your vehicle's location is shown on your minimap");
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_TRUNK){
		if(response){
			SetPVarInt(playerid, "DialogValue2", listitem);
			ShowDialog(playerid, DIALOG_TRUNK_ACTION);
		}
		else
{
			new id = GetPVarInt(playerid, "DialogValue1");
			ToggleBoot(VehicleID[id], VEHICLE_PARAMS_OFF);
		}
		return 1;
	}
	if(dialogid == DIALOG_TRUNK_ACTION){
		if(response){
			new id = GetPVarInt(playerid, "DialogValue1");
			new slot = GetPVarInt(playerid, "DialogValue2");
			switch(listitem){
			case 0:
{
				new weaponid = GetPlayerWeapon(playerid);
				if(weaponid == 0){
					ShowErrorDialog(playerid, "You don't have a weapon in your hands!");
					return 1;
				}
				VehicleTrunk[id][slot][0] = weaponid;
				if(IsMeleeWeapon(weaponid)) VehicleTrunk[id][slot][1] = 1;
				else VehicleTrunk[id][slot][1] = GetPlayerAmmo(playerid);
				RemovePlayerWeapon(playerid, weaponid);
				SaveVehicle(id);
			}
			case 1:
{
				if(VehicleTrunk[id][slot][1] <= 0){
					ShowErrorDialog(playerid, "This slot is empty!");
					return 1;
				}
				GivePlayerWeapon(playerid, VehicleTrunk[id][slot][0], VehicleTrunk[id][slot][1]);
				VehicleTrunk[id][slot][0] = 0;
				VehicleTrunk[id][slot][1] = 0;
				SaveVehicle(id);
			}
			}
		}
		ShowDialog(playerid, DIALOG_TRUNK);
		return 1;
	}
	if(dialogid == DIALOG_VEHICLE_PLATE){
		if(response){
			if(strlen(inputtext) < 1 || strlen(inputtext) >= sizeof(VehicleNumberPlate[])){
				ShowErrorDialog(playerid, "Invalid length!");
				return 1;
			}
			new id = GetPVarInt(playerid, "DialogValue1");
			new vehicleid = VehicleID[id];
			strmid(VehicleNumberPlate[id], inputtext, 0, sizeof(VehicleNumberPlate[]));
			SaveVehicle(id);
			SetVehicleNumberPlate(vehicleid, inputtext);
			SetVehicleToRespawn(vehicleid);
			new msg[128];
			format(msg, sizeof(msg), "You have changed vehicle number plate to %s", inputtext);
			SendClientMessage(playerid, COLOR_WHITE, msg);
		}
		else ShowDialog(playerid, DIALOG_VEHICLE);
		return 1;
	}
	if(dialogid == DIALOG_FUEL){
		if(response){
			switch(listitem){
			case 0:
{
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER){
					ShowErrorDialog(playerid, "You are not driving a vehicle!");
					return 1;
				}
				new vehicleid = GetPlayerVehicleID(playerid);
				if(IsBicycle(vehicleid)){
					ShowErrorDialog(playerid, "Your vehicle doesn't have a fuel tank!");
					return 1;
				}
				if(Fuel[vehicleid] >= 100.0){
					ShowErrorDialog(playerid, "Your vehicle fuel tank is full!");
					return 1;
				}
				if(GetPlayerMoney(playerid) < FUEL_PRICE){
					ShowErrorDialog(playerid, "You don't have enough money!");
					return 1;
				}
				RefuelTime[playerid] = 5;
				SetPVarFloat(playerid, "Fuel", Fuel[vehicleid]);
				GameTextForPlayer(playerid, "~w~refueling...", 2000, 3);
			}
			case 1:
{
				if(GetPVarInt(playerid, "GasCan")){
					ShowErrorDialog(playerid, "You already have a gas can!");
					return 1;
				}
				if(GetPlayerMoney(playerid) < GAS_CAN_PRICE){
					ShowErrorDialog(playerid, "You don't have enough money!");
					return 1;
				}
				GivePlayerMoney(playerid, -GAS_CAN_PRICE);
				SetPVarInt(playerid, "GasCan", 1);
				SendClientMessage(playerid, COLOR_WHITE, "You have bought a gas can for $" #GAS_CAN_PRICE );
			}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_EDITVEHICLE){
		if(response){
			new id = GetPVarInt(playerid, "DialogValue1");
			new nr, params[128];
			sscanf(inputtext, "ds", nr, params);
			switch(nr){
			case 1:
{
				new value = strval(params);
				if(value < 0) value = 0;
				VehicleValue[id] = value;
				UpdateVehicleLabel(id, 1);
				SaveVehicle(id);
				ShowDialog(playerid, DIALOG_EDITVEHICLE);
			}
			case 2:
{
				new value;
				if(IsNumeric(params)) value = strval(params);
				else value = GetVehicleModelIDFromName(params);
				if(value < 400 || value > 611){
					ShowErrorDialog(playerid, "Invalid vehicle model!");
					return 1;
				}
				VehicleModel[id] = value;
				for(new i=0; i < sizeof(VehicleMods[]); i++){
					VehicleMods[id][i] = 0;
				}
				VehiclePaintjob[id] = 255;
				UpdateVehicle(id, 1);
				SaveVehicle(id);
				ShowDialog(playerid, DIALOG_EDITVEHICLE);
			}
			case 3:
{
				new color1, color2;
				sscanf(params, "dd", color1, color2);
				VehicleColor[id][0] = color1;
				VehicleColor[id][1] = color2;
				SaveVehicle(id);
				ChangeVehicleColor(VehicleID[id], color1, color2);
				ShowDialog(playerid, DIALOG_EDITVEHICLE);
			}
			case 4:
{
				if(strlen(params) < 1 || strlen(params) > 8){
					ShowErrorDialog(playerid, "Invalid length!");
					return 1;
				}
				strmid(VehicleNumberPlate[id], params, 0, sizeof(params));
				SaveVehicle(id);
				SetVehicleNumberPlate(VehicleID[id], params);
				SetVehicleToRespawn(VehicleID[id]);
				ShowDialog(playerid, DIALOG_EDITVEHICLE);
			}
			case 5:
{
				DestroyVehicle(VehicleID[id]);
				if(VehicleCreated[id] == VEHICLE_DEALERSHIP){
					Delete3DTextLabel(VehicleLabel[id]);
				}
				VehicleCreated[id] = 0;
				SaveVehicle(id);
				new msg[128];
				format(msg, sizeof(msg), "You have deleted vehicle id %d", id);
				SendClientMessage(playerid, COLOR_WHITE, msg);
			}
			case 6:
{
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER){
					ShowErrorDialog(playerid, "You are not driving the vehicle!");
					return 1;
				}
				GetVehiclePos(VehicleID[id], VehiclePos[id][0], VehiclePos[id][1], VehiclePos[id][2]);
				GetVehicleZAngle(VehicleID[id], VehiclePos[id][3]);
				VehicleInterior[id] = GetPlayerInterior(playerid);
				VehicleWorld[id] = GetPlayerVirtualWorld(playerid);
				SendClientMessage(playerid, COLOR_WHITE, "You have parked this vehicle here");
				UpdateVehicle(id, 1);
				PutPlayerInVehicle(playerid, VehicleID[id], 0);
				SaveVehicle(id);
				ShowDialog(playerid, DIALOG_EDITVEHICLE);
			}
			case 7:
{
				new Float:x, Float:y, Float:z;
				GetVehiclePos(VehicleID[id], x, y, z);
				SetPlayerPos(playerid, x, y, z+1);
				new msg[128];
				format(msg, sizeof(msg), "You have teleported to vehicle id %d", id);
				SendClientMessage(playerid, COLOR_WHITE, msg);
			}
			}
		}
		return 1;
	}
	return 0;
}
stock sscanf(string[], format[], {Float,_}:...){
	#if defined isnull
	if (isnull(string))	#else
	if (string[0] == 0 || (string[0] == 1 && string[1] == 0))	#endif
	{
		return format[0];
	}
	new
		formatPos = 0,
		stringPos = 0,
		paramPos = 2,
		paramCount = numargs(),
		delim = ' ';
	while (string[stringPos] && string[stringPos] <= ' '){
		stringPos++;
	}
	while (paramPos < paramCount && string[stringPos]){
		switch (format[formatPos++]){
			case '\0':
{
				return 0;
			}
			case 'i', 'd':
{
				new
					neg = 1,
					num = 0,
					ch = string[stringPos];
				if (ch == '-'){
					neg = -1;
					ch = string[++stringPos];
				}
				do
{
					stringPos++;
					if ('0' <= ch <= '9'){
						num = (num * 10) + (ch - '0');
					}
					else
{
						return -1;
					}
				}
				while ((ch = string[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num * neg);
			}
			case 'h', 'x':
{
				new
					num = 0,
					ch = string[stringPos];
				do
{
					stringPos++;
					switch (ch){
						case 'x', 'X':
{
							num = 0;
							continue;
						}
						case '0' .. '9':
{
							num = (num << 4) | (ch - '0');
						}
						case 'a' .. 'f':
{
							num = (num << 4) | (ch - ('a' - 10));
						}
						case 'A' .. 'F':
{
							num = (num << 4) | (ch - ('A' - 10));
						}
						default:
{
							return -1;
						}
					}
				}
				while ((ch = string[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num);
			}
			case 'c':
{
				setarg(paramPos, 0, string[stringPos++]);
			}
			case 'f':
{
				new
					end = stringPos - 1,
					ch;
				while ((ch = string[++end]) && ch != delim) {}
				string[end] = '\0';
				setarg(paramPos,0,_:floatstr(string[stringPos]));
				string[end] = ch;
				stringPos = end;
			}
			case 'p':
{
				delim = format[formatPos++];
				continue;
			}
			case '\'':
{
				new
					end = formatPos - 1,
					ch;
				while ((ch = format[++end]) && ch != '\'') {}
				if (!ch){
					return -1;
				}
				format[end] = '\0';
				if ((ch = strfind(string, format[formatPos], false, stringPos)) == -1){
					if (format[end + 1]){
						return -1;
					}
					return 0;
				}
				format[end] = '\'';
				stringPos = ch + (end - formatPos);
				formatPos = end + 1;
			}
			case 'u':
{
				new
					end = stringPos - 1,
					id = 0,
					bool:num = true,
					ch;
				while ((ch = string[++end]) && ch != delim){
					if (num){
						if ('0' <= ch <= '9'){
							id = (id * 10) + (ch - '0');
						}
						else
{
							num = false;
						}
					}
				}
				if (num && IsPlayerConnected(id)){
					setarg(paramPos, 0, id);
				}
				else
{
					#if !defined foreach
						#define foreach(%1,%2) for (new %2 = 0; %2 < MAX_PLAYERS; %2++) if (IsPlayerConnected(%2))						#define __SSCANF_FOREACH__
					#endif
					string[end] = '\0';
					num = false;
					new
						name[MAX_PLAYER_NAME];
					id = end - stringPos;
					foreach (Player, playerid){
						GetPlayerName(playerid, name, sizeof (name));
						if (!strcmp(name, string[stringPos], true, id)){
							setarg(paramPos, 0, playerid);
							num = true;
							break;
						}
					}
					if (!num){
						setarg(paramPos, 0, INVALID_PLAYER_ID);
					}
					string[end] = ch;
					#if defined __SSCANF_FOREACH__
						#undef foreach
						#undef __SSCANF_FOREACH__
					#endif
				}
				stringPos = end;
			}
			case 's', 'z':
{
				new
					i = 0,
					ch;
				if (format[formatPos]){
					while ((ch = string[stringPos++]) && ch != delim){
						setarg(paramPos, i++, ch);
					}
					if (!i){
						return -1;
					}
				}
				else
{
					while ((ch = string[stringPos++])){
						setarg(paramPos, i++, ch);
					}
				}
				stringPos--;
				setarg(paramPos, i, '\0');
			}
			default:
{
				continue;
			}
		}
		while (string[stringPos] && string[stringPos] != delim && string[stringPos] > ' '){
			stringPos++;
		}
		while (string[stringPos] && (string[stringPos] == delim || string[stringPos] <= ' ')){
			stringPos++;
		}
		paramPos++;
	}
	do
{
		if ((delim = format[formatPos++]) > ' '){
			if (delim == '\''){
				while ((delim = format[formatPos++]) && delim != '\'') {}
			}
			else if (delim != 'z'){
				return delim;
			}
		}
	}
	while (delim > ' ');
	return 0;
}
