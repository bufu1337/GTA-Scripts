//------------------------------------------------------------------------------

//

//Coded By Nate660

//Help By Kansas

//------------------------------------------------------------------------------



#include <a_samp>

#include <core>

#include <float>

//Global stuff and defines for our gamemode

static gTeam[MAX_PLAYERS]; // Tracks the team assignment for each player

new gPlayerClass[MAX_PLAYERS];
new ConnectName[30], str[256];
new Grove;
new Ballas;
new Aztecs;
new Italy;
new Nang;
new Vagos;
new Russian;
new Bikers;
new igate;
new igate2;
new GangKills;
new MAX_ZONE_KILLS;
new MAX_TAKE_KILLS;

//Color Defines

#define COLOR_GREY 0xAFAFAFAA

#define COLOR_GREEN 0x33AA33AA

#define COLOR_RED 0xAA3333AA

#define COLOR_YELLOW 0xFFFF00AA

#define COLOR_PINK 0xFF66FFAA

#define COLOR_BLUE 0x0000BBAA

#define COLOR_LIGHTBLUE 0x33CCFFAA

#define COLOR_DARKRED 0x660000AA

#define COLOR_ORANGE 0xFF9900AA

#define COLOR_PURPLE 0x800080AA

#define COLOR_LIGHTBLUE 0x33CCFFAA

#define COLOR_BLACK 0x000000AA

#define COLOR_WHITE 0xFFFFFFAA

#define COLOR_GREEN1 0x33AA33AA



//Team Defines

#define TEAM_GROVE 0

#define TEAM_BALLAS 5

#define TEAM_AZTEC 10

#define TEAM_NANG 14

#define TEAM_VAGOS 18

#define TEAM_RUSSIAN 21

#define TEAM_ITALYMAFIA 25

#define TEAM_BIKER 30

#define TEAM_TRIAD 33


forward SetupPlayerForClassSelection(playerid);
forward GameModeExitFunc();




// Round duration

new gRoundTime = 3600000; // 60 mins

//new gRoundTime = 900000; //15 mins

//new gRoundTime = 300000; // 5 mins



//------------------------------------------------------------------------------



main()

{

        print("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

        print("  LS GangWar Coded By Nate");

        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");

}



//------------------------------------------------------------------------------



public OnGameModeInit()

{
    GameTextForAll("Hacks Bannable", 10, 3);

    EnableZoneNames(1);

        SetGameModeText("LS Gangwar");

        SetTeamCount(9);

        ShowNameTags(true);

        ShowPlayerMarkers(true);

        SetWorldTime(18);

        AddPlayerClass(105,2482.4531,-1685.9695,13.5078, 0, 4, 500, 32, 250, 30, 250);//GROVE

        AddPlayerClass(106,2482.4531,-1685.9695,13.5078, 0, 4, 500, 32, 250, 30, 250); //GROVE

        AddPlayerClass(107,2482.4531,-1685.9695,13.5078, 0, 4, 500, 32, 250, 30, 250); //GROVE

        AddPlayerClass(195,2482.4531,-1685.9695,13.5078, 0, 4, 500, 32, 250, 30, 250); //GROVE

        AddPlayerClass(207,2482.4531,-1685.9695,13.5078, 0, 4, 500, 32, 250, 30, 250); //GROVE

        AddPlayerClass(102, 2229.8271,-1166.7804,25.7707, 0, 4, 500, 32, 250, 30, 250); //BALLAS 1

        AddPlayerClass(103,2229.8271,-1166.7804,25.7707, 0, 4, 500, 32, 250, 30, 250); //BALLAS 2

    AddPlayerClass(104,2229.8271,-1166.7804,25.7707, 0, 4, 500, 32, 250, 30, 250); //BALLAS 3

    AddPlayerClass(13,2229.8271,-1166.7804,25.7707, 0, 4, 500, 32, 250, 30, 250); //BALLAS 4

    AddPlayerClass(173,1832.2875,-1677.5171,17.1507, 0, 4, 500, 32, 250, 30, 250); // AZTEC

    AddPlayerClass(174,1832.2875,-1677.5171,17.1507, 0, 4, 500, 32, 250, 30, 250); // AZTEC2

    AddPlayerClass(175,1832.2875,-1677.5171,17.1507, 0, 4, 500, 32, 250, 30, 250); // AZTEC3

    AddPlayerClass(114,1832.2875,-1677.5171,17.1507, 0, 4, 500, 32, 250, 30, 250); // AZTEC4

    AddPlayerClass(115,1832.2875,-1677.5171,17.1507, 0, 4, 500, 32, 250, 30, 250); // AZTEC5

    AddPlayerClass(116,1832.2875,-1677.5171,17.1507, 0, 4, 500, 32, 250, 30, 250); // AZTEC6

        AddPlayerClass(121,1208.0321,-1746.3037,13.5933,38.4730, 4, 500, 32, 250, 30, 250); //NANG

    AddPlayerClass(122,1208.0321,-1746.3037,13.5933,38.4730,4, 500, 32, 250, 30, 250); //NANG

    AddPlayerClass(123,1208.0321,-1746.3037,13.5933,38.4730, 4, 500, 32, 250, 30, 250); //NANG

    AddPlayerClass(263,1208.0321,-1746.3037,13.5933,38.4730, 4, 500, 32, 250, 30, 250);//NANG

    AddPlayerClass(108,2810.3608,-1177.2137,25.3201,172.5518, 4, 500, 32, 250, 30, 250); //VAGOS

        AddPlayerClass(109,2810.3608,-1177.2137,25.3201,172.5518, 4, 500, 32, 250, 30, 250); //VAGOS

        AddPlayerClass(110,2810.3608,-1177.2137,25.3201,172.5518, 4, 500, 32, 250, 30, 250); //VAGOS

        AddPlayerClass(113,1725.9430,-1633.0537,20.2154,10.1108, 4, 500, 32, 250, 30, 250); // Russian Spawn

        AddPlayerClass(111,1725.9430,-1633.0537,20.2154,10.1108, 4, 500, 32, 250, 30, 250); // Russian Spawn

        AddPlayerClass(112,1725.9430,-1633.0537,20.2154,10.1108, 4, 500, 32, 250, 30, 250); // Russian Spawn

        AddPlayerClass(243,1725.9430,-1633.0537,20.2154,10.1108, 4, 500, 32, 250, 30, 250); // Russian Spawn

        AddPlayerClass(124,2130.9968,-2279.8772,20.6643,317.9167, 4, 500, 32, 250, 30, 250); // italyspawnblack

        AddPlayerClass(125,2130.9968,-2279.8772,20.6643,317.9167, 4, 500, 32, 250, 30, 250); // italyspawnblack

        AddPlayerClass(126,2130.9968,-2279.8772,20.6643,317.9167, 4, 500, 32, 250, 30, 250); // italyspawnblack

        AddPlayerClass(127,2130.9968,-2279.8772,20.6643,317.9167, 4, 500, 32, 250, 30, 250); // italyspawnblack

        AddPlayerClass(214,2130.9968,-2279.8772,20.6643,317.9167, 4, 500, 32, 250, 30, 250); // italyspawnblack

        AddPlayerClass(100,1221.6252,-1815.5408,16.5938,189.5336, 4, 500, 32, 250, 30, 250); // bikerspawn

        AddPlayerClass(247,1221.6252,-1815.5408,16.5938,189.5336, 4, 500, 32, 250, 30, 250); // bikerspawn

        AddPlayerClass(248,1221.6252,-1815.5408,16.5938,189.5336, 4, 500, 32, 250, 30, 250); // bikerspawn

        AddPlayerClass(117,863.4913,-1638.3412,14.9521,176.9822, 4, 500, 32, 250, 30, 250); // TriadSpawn

        AddPlayerClass(118,863.4913,-1638.3412,14.9521,176.9822, 4, 500, 32, 250, 30, 250); // TriadSpawn

        AddPlayerClass(120,863.4913,-1638.3412,14.9521,176.9822, 4, 500, 32, 250, 30, 250); // TriadSpawn

        AddPlayerClass(141,863.4913,-1638.3412,14.9521,176.9822, 4, 500, 32, 250, 30, 250); // TriadSpawn

        AddStaticVehicle(596,2148.5220,-94.8024,2.4455,297.5038,0,0); // copcarspawn

        AddStaticVehicle(596,2146.5576,-90.8221,2.4709,303.8008,0,0); // copcarspawn

        AddStaticVehicle(596,2144.4209,-88.7737,2.4996,310.3036,0,0); // copcarspawn

        AddStaticVehicle(596,2142.2039,-86.1142,2.5330,312.5618,0,0); // copcarspawn

        AddStaticVehicle(596,2140.2556,-83.9066,2.5809,301.6049,0,0); // copcarspaw

        AddStaticVehicle(596,2133.5325,-64.9764,2.1123,214.3671,0,0); // copcarspawn

        AddStaticVehicle(596,2136.5371,-63.0391,2.4975,216.3774,0,0); // copcarspawn

        AddStaticVehicle(523,2114.6833,-93.6905,2.2455,298.9620,0,0); // copbikespawn

        AddStaticVehicle(523,2116.5176,-96.7271,2.2320,308.9887,0,0); // copbike spawn

        AddStaticVehicle(596,2137.4980,1652.3304,10.4875,115.5810,0,0); // lcncar

    AddStaticVehicle(445,2144.8218,1656.5636,10.4836,123.7945,0,0); // lcncar

    AddStaticVehicle(545,2150.2139,1661.0162,10.4836,132.5124,0,0); // lcncar

    AddStaticVehicle(445,2154.5781,1666.0719,10.4836,142.7669,0,0); // lcncar

    AddStaticVehicle(545,2158.2061,1672.1649,10.4895,156.3207,0,0); // lcncar

    AddStaticVehicle(455,2158.6636,1688.2588,10.4839,19.1098,0,0); // lcncar

    AddStaticVehicle(545,2155.4165,1695.0338,10.4837,30.6791,0,0); // lcncar

    AddStaticVehicle(455,2151.3674,1700.1495,10.4836,44.3734,0,0); // lcn car

    AddStaticVehicle(545,2146.5359,1704.9728,10.4837,50.8707,0,0); // lcncar

    AddStaticVehicle(455,2139.5830,1709.7482,10.5625,58.5306,0,0); // lcncar

    AddStaticVehicle(580,2159.3342,1679.7607,10.5683,87.0391,0,0); // lcnimportantcar

    AddStaticVehicle(457,-2659.7441,-289.6562,8.0920,313.6239,-1,-1);

        AddStaticVehicle(457,-2642.9949,-301.7552,8.0090,47.6567,-1,-1);

        AddStaticVehicle(421,-2681.7434,-276.2391,8.0605,44.2241,-1,-1);

        AddStaticVehicle(575,-2618.9480,1376.7870,7.7322,181.1998,-1,-1);

        AddStaticVehicle(411,-2645.5964,1376.7522,7.8935,267.8349,-1,-1);

        AddStaticVehicle(409,-2628.6924,1377.4845,7.9350,180.7913,-1,-1);

        AddStaticVehicle(409,-2633.1638,1332.7010,7.9953,269.6430,-1,-1);

        AddStaticVehicle(405,-2126.2573,650.7344,53.2421,88.8335,-1,-1);

        AddStaticVehicle(405,-2125.8604,658.0598,53.3040,92.1547,-1,-1);

        AddStaticVehicle(445,-2158.0305,657.3961,53.2440,272.5298,-1,-1);

        AddStaticVehicle(522,-2151.1257,629.7889,52.8293,180.7068,-1,-1);

        AddStaticVehicle(484,-1476.5386,700.1740,1.1248,355.3123,-1,-1);

        AddStaticVehicle(446,-1571.3143,1263.2914,1.2879,269.1020,-1,-1);

        AddStaticVehicle(446,-1720.0265,1436.3821,1.4272,3.3108,-1,-1);

        AddStaticVehicle(445,-2156.6838,942.3219,80.8784,269.6746,-1,-1);

        AddStaticVehicle(480,-2223.2629,1083.2794,80.7819,359.6700,-1,-1);

        AddStaticVehicle(444,-2517.2996,1229.3512,38.7999,209.3221,-1,-1);

        AddStaticVehicle(522,-1654.1005,1211.9901,14.2380,315.9562,-1,-1);

        AddStaticVehicle(415,-1660.4161,1213.3704,8.0209,295.4768,-1,-1);

        AddStaticVehicle(415,-1553.3494,1089.8568,7.9584,89.1789,-1,-1);

        AddStaticVehicle(420,-1497.4607,845.8477,7.9671,88.5197,-1,-1);

        AddStaticVehicle(421,-1699.4597,1035.9624,46.0932,91.6588,-1,-1);

        AddStaticVehicle(559,-1786.6871,1206.5266,25.7813,178.8742,-1,-1);

        AddStaticVehicle(559,-1703.9169,1339.6957,7.8358,133.6003,-1,-1);

        AddStaticVehicle(539,-1835.1257,1425.9342,1.5476,184.1130,-1,-1);

        AddStaticVehicle(539,-2441.2109,1414.1995,1.4429,86.1079,-1,-1);

        AddStaticVehicle(547,-2438.0117,1340.9783,8.7316,86.7979,-1,-1);

        AddStaticVehicle(411,-2166.5498,1251.0760,28.2782,1.6030,-1,-1);

        AddStaticVehicle(411,-2636.3838,932.3286,72.5378,187.1212,-1,-1);

        AddStaticVehicle(461,-2566.5906,989.6594,78.8568,358.1472,-1,-1);

        AddStaticVehicle(461,-2464.8860,896.7036,63.6223,0.6326,-1,-1);

        AddStaticVehicle(542,-2273.8679,921.3689,67.3102,359.9958,-1,-1);

        AddStaticVehicle(400,-2459.9055,786.4501,36.2643,89.8722,-1,-1);

        AddStaticVehicle(400,-2673.5830,802.1517,51.0693,0.3607,-1,-1);

        AddStaticVehicle(539,-2952.4602,495.9247,1.9517,0.4375,-1,-1);

        AddStaticVehicle(446,-2970.6746,497.2838,1.3557,4.0073,-1,1);

        AddStaticVehicle(444,-2902.7820,342.5712,6.3723,138.7612,-1,-1);

        AddStaticVehicle(444,-2876.3977,26.3173,7.2123,118.5961,-1,-1);

        AddStaticVehicle(470,-1382.4279,455.8060,7.1838,359.9849,-1,-1);

        AddStaticVehicle(470,-1439.3396,455.1034,7.1739,0.1531,-1,-1);

        AddStaticVehicle(542,-1465.0304,455.6730,7.9280,358.9676,-1,-1);

        AddStaticVehicle(571,-1677.1865,438.8195,7.4635,227.1910,-1,-1);

        AddStaticVehicle(476,-1433.3817,-504.8247,15.8794,158.2625,-1,-1);

        AddStaticVehicle(476,-1464.6495,-522.4009,15.8899,234.2019,-1,-1);

        AddStaticVehicle(593,-1354.2429,-467.9689,15.6386,162.9646,-1,-1);

        AddStaticVehicle(593,-1387.8518,-484.0513,15.6341,247.9289,-1,-1);

        AddStaticVehicle(487,-1162.1279,-460.9374,15.3257,53.8622,-1,-1);

        AddStaticVehicle(553,-1317.8910,-260.4665,16.4827,288.2876,-1,-1);

        AddStaticVehicle(553,-1362.9397,-183.5522,16.4848,308.6994,-1,-1);

        AddStaticVehicle(447,-1187.9520,26.1456,15.1604,45.3312,-1,-1);

        AddStaticVehicle(447,-1222.7996,-10.4235,15.1594,45.5780,-1,-1);

        AddStaticVehicle(475,-1872.5575,-820.7949,32.8273,90.7921,-1,-1);

        AddStaticVehicle(444,-1898.3019,-915.5814,33.3947,91.2857,-1,-1);

        AddStaticVehicle(496,-2124.4800,-929.0856,32.7397,269.1853,-1,-1);

        AddStaticVehicle(496,-2133.3015,-847.1439,32.7396,88.8312,-1,-1);

        AddStaticVehicle(516,-2134.1038,-775.5048,32.8568,91.5838,-1,-1);

        AddStaticVehicle(516,-2134.1428,-453.9576,36.1699,95.0875,-1,-1);

        AddStaticVehicle(541,-2035.6851,170.2529,29.4610,268.9087,-1,-1);

        AddStaticVehicle(500,-2219.7209,-83.2318,36.4367,2.0481,-1,-1);

        AddStaticVehicle(541,-2018.4379,-98.9675,35.7890,358.5420,-1,-1);

        AddStaticVehicle(541,-2352.0959,-126.8848,35.9374,179.5324,-1,-1);

        AddStaticVehicle(405,-2180.1277,41.8536,36.1953,269.9865,-1,-1);

        AddStaticVehicle(522,-2269.4526,69.5823,35.7279,89.6104,-1,-1);

        AddStaticVehicle(522,-2266.0090,145.0206,35.7322,92.0045,-1,-1);

        AddStaticVehicle(475,-2129.2864,787.6249,70.3666,87.1679,-1,-1);

        AddStaticVehicle(475,-2424.9958,740.8871,35.8205,177.6701,-1,-1);

        AddStaticVehicle(400,-2684.7639,636.4294,14.5454,179.2696,-1,-1);

        AddStaticVehicle(496,-2545.7666,627.5895,15.1684,89.1952,-1,-1);

        AddStaticVehicle(496,-2428.7107,514.7900,30.6451,207.9893,-1,-1);

        AddStaticVehicle(429,-2498.4822,357.5526,35.7969,58.0823,-1,-1);

        AddStaticVehicle(429,-2664.9673,268.9968,5.0156,357.6026,-1,-1);

        AddStaticVehicle(420,-2626.5276,-53.6779,5.1144,357.7703,-1,-1);

        AddStaticVehicle(434,-2718.5354,-124.4790,5.3071,269.1429,-1,-1);

        AddStaticVehicle(434,-2487.5295,-125.3075,26.5715,90.9363,-1,-1);

        AddStaticVehicle(400,-2486.0298,51.5018,27.7954,177.2178,-1,-1);

        AddStaticVehicle(400,-2574.9736,146.5981,5.4279,1.8790,-1,-1);

        AddStaticVehicle(559,-2800.0251,205.2155,7.8399,92.2606,-1,-1);

        AddStaticVehicle(549,-1741.0009,811.0599,25.5879,270.6703,-1,-1);

        AddStaticVehicle(549,-1920.7559,875.2713,36.1113,270.0973,-1,-1);

        AddStaticVehicle(500,-2040.4465,1107.7076,54.4032,89.8491,-1,-1);

        AddStaticVehicle(500,-1968.8488,465.6065,36.2766,89.3124,-1,-1);

        AddStaticVehicle(401,-1938.2876,584.4863,35.9137,1.1244,-1,-1);

        AddStaticVehicle(401,-1825.2035,-0.4858,15.8965,270.0104,-1,-1);

        AddStaticVehicle(579,-1820.0182,-175.9391,10.3323,87.9147,-1,-1);

        AddStaticVehicle(429,-1687.9076,1003.5587,18.2656,91.3972,-1,-1);

        AddStaticVehicle(439,-1704.8613,1058.0004,18.4810,182.3475,-1,-1);

        AddStaticVehicle(579,-1702.2262,1028.7677,18.5187,270.2923,-1,-1);

        AddStaticVehicle(480,-1735.9534,1016.0621,18.3580,268.5771,-1,-1);

        AddStaticVehicle(400,-2782.3508,442.1533,5.5383,57.1401,-1,-1);

        AddStaticVehicle(400,-2836.3665,865.6495,44.1470,268.7662,-1,-1);

        AddStaticVehicle(415,-2899.3823,1112.4786,27.3954,268.9744,-1,-1);

        AddStaticVehicle(516,-2654.5662,615.2198,15.2873,0.1598,-1,-1);

        AddStaticVehicle(416,-2618.7363,627.2617,15.6024,179.6464,-1,-1);

        AddStaticVehicle(401,-1968.8031,-400.9335,35.1227,88.2282,-1,-1);

        AddStaticVehicle(516,-1904.3373,-599.6174,24.4277,344.2378,-1,-1);

        AddStaticVehicle(475,-1639.3912,-567.4948,13.9482,80.1914,-1,-1);

        AddStaticVehicle(475,-1405.5500,-309.2615,13.9504,174.9827,-1,-1);

        AddStaticVehicle(475,-2132.1143,160.2086,35.1341,270.0023,-1,-1);

        AddStaticVehicle(500,-2151.4924,428.9210,35.1902,176.6156,-1,-1);

        AddStaticVehicle(500,-2304.8279,360.0154,35.2835,201.6184,-1,-1);

        AddStaticVehicle(522,-1696.7413,977.0867,17.1574,7.0263,-1,-1);

        AddStaticVehicle(429,-2641.7395,1333.0645,6.8700,356.7557,-1,-1);

        AddStaticVehicle(457,-2650.6292,-280.5106,7.0874,132.0127,-1,-1);

        AddStaticVehicle(421,-1409.6693,456.0711,7.0672,3.2988,-1,-1);

        AddStaticVehicle(487,-1681.5756,706.4234,30.7777,266.5047,-1,-1);

    AddStaticVehicle(603,-2617.2964,1349.0765,7.0217,358.1852,-1,-1); //

        AddStaticVehicle(475,-2129.8242,288.0418,34.9864,269.9582,-1,-1); //

        AddStaticVehicle(475,-2664.0950,-259.9579,6.5482,74.4868,-1,-1); //

        AddStaticVehicle(597,-1628.6875,652.5107,6.9568,0.9097,-1,-1); //

        AddStaticVehicle(597,-1616.7957,652.5980,6.9551,0.6199,-1,-1); //

        AddStaticVehicle(597,-1594.2644,672.5858,6.9564,176.7420,-1,-1); //

    AddStaticVehicle(597,-1593.5823,652.3891,6.9567,1.3142,0,1); //

        AddStaticVehicle(597,-1611.9730,673.5499,6.9567,181.6088,0,1); //

        AddStaticVehicle(580,2516.4792,-1672.2496,13.7134,58.9978,86,86); // grovecar1

        AddStaticVehicle(580,2510.5398,-1687.1321,13.3584,50.9197,86,86); // grovecar2

        AddStaticVehicle(580,2516.3401,-1663.6854,13.7062,127.6044,86,86); // grovecar3

        AddStaticVehicle(580,2480.4858,-1654.1302,13.1872,266.2330,86,86); // grovecar4

        AddStaticVehicle(580,2473.2944,-1695.4388,13.3121,359.0142,86,86); // grovecar5

        AddStaticVehicle(580,2491.3098,-1684.2821,13.2161,270.8374,86,86); // grovecar6

        AddStaticVehicle(580,2205.5364,-1173.3594,25.5240,270.2225,5,5); // ballascar

        AddStaticVehicle(580,2205.9761,-1168.2751,25.5262,261.5072,5,5); // ballascar

        AddStaticVehicle(580,2205.6670,-1160.7697,25.5305,269.1792,5,5); // ballascar

        AddStaticVehicle(580,2216.8789,-1161.0822,25.5227,264.7917,5,5); // ballascar

        AddStaticVehicle(580,2217.3040,-1166.0198,25.5227,270.6133,5,5); // ballascar

        AddStaticVehicle(412,1214.3103,-1732.5437,13.5758,320.4523,124,124); // nang car

        AddStaticVehicle(412,1234.4064,-1727.9963,13.5702,267.4985,124,124); // nang car1

        AddStaticVehicle(412,1129.3843,-1705.2550,13.5469,191.6945,124,124); // nang car2

        AddStaticVehicle(412,1212.9415,-1698.3743,13.5469,87.9801,124,124); // nang car3

        AddStaticVehicle(412,1187.8851,-1729.4308,13.5605,179.1610,124,124); // nang car5

        AddStaticVehicle(412,1211.9354,-1746.6093,13.5942,131.8472,124,124); // nang car6

        AddStaticVehicle(412,1192.0967,-1759.9099,13.5807,170.0742,124,124); // nang car7

        AddStaticVehicle(412,1829.3723,-1691.0593,13.5469,94.0469,7,7); // aztecs car

        AddStaticVehicle(412,1827.8174,-1675.2429,13.5469,95.6136,7,7); // aztecs car1

        AddStaticVehicle(412,1911.3422,-1776.1532,13.3828,179.5644,7,7); // aztecs car2

        AddStaticVehicle(412,1939.1145,-1766.3964,13.3828,174.5510,7,7); // aztecs car3

        AddStaticVehicle(412,1939.0929,-1778.0176,13.3906,174.2611,7,7); // aztecs car4

        AddStaticVehicle(412,1943.6978,-1778.8237,13.3906,357.5628,7,7); // aztecs car5

        AddStaticVehicle(412,1943.8369,-1769.0461,13.3906,357.5628,7,7); // aztecs car6

        AddStaticVehicle(412,1926.1571,-1698.0398,13.5469,268.9120,7,7); // aztecs car7

        AddStaticVehicle(412,1926.3702,-1706.8046,13.5469,268.9120,7,7); // aztecs car8

        AddStaticVehicle(412,1926.4028,-1715.7394,13.5469,88.9120,7,7); // aztecs car9

        AddStaticVehicle(412,1925.1254,-1726.7428,13.5469,85.1520,7,7); // aztecs car10

        AddStaticVehicle(412,1925.1206,-1737.6246,13.5469,81.5369,7,7); // aztecs car11

        AddStaticVehicle(412,1924.7032,-1667.3715,13.5469,275.7821,7,7); // aztecs car12

        AddStaticVehicle(412,1924.4641,-1660.5222,13.5469,275.1554,7,7); // aztecs car13

        AddStaticVehicle(412,1923.6123,-1651.6923,13.5469,95.1554,7,7); // aztecs car14

        AddStaticVehicle(412,1923.7577,-1640.5507,13.5469,260.1153,7,7); // aztecs car15

        AddStaticVehicle(412,1923.9928,-1632.3308,13.5469,73.0769,7,7); // aztecs car16

        AddStaticVehicle(474,2806.8813,-1183.3680,25.1339,220.2208,6,6); // vagoss

        AddStaticVehicle(474,2819.4688,-1181.3314,25.0038,85.4792,6,6); // vagoss

        AddStaticVehicle(474,2831.2871,-1163.3269,24.7314,2.5131,6,6); // vagoss

        AddStaticVehicle(474,2847.9690,-1177.1644,24.5211,180.5938,6,6); // vagoss

        AddStaticVehicle(474,2850.0503,-1193.3774,24.2992,188.7579,6,6); // vagoss

        AddStaticVehicle(474,2837.6409,-1204.7365,23.7197,18.9415,6,6); // vagoss

        AddStaticVehicle(509,2235.8101,-1143.6821,25.5026,254.0831,25,15); // gangcar

        AddStaticVehicle(510,2251.9292,-1148.0607,26.1995,254.6402,35,45); // gangcar

        AddStaticVehicle(558,2264.6477,-1236.7975,23.7724,176.1888,65,75); // gangcar

        AddStaticVehicle(559,2243.8801,-1294.6589,23.7731,88.6895,85,95); // gangcar

        AddStaticVehicle(560,2198.0364,-1295.8950,23.6916,90.9296,95,105); // car

        AddStaticVehicle(561,2132.5918,-1294.5702,23.7714,93.6120,105,115); // gangcar

        AddStaticVehicle(562,2061.8809,-1323.2242,23.6946,181.1816,115,125); // gangcar

        AddStaticVehicle(563,2093.1621,-1377.8721,23.7846,273.0439,125,5); // gangcar

        AddStaticVehicle(596,2127.0315,-1406.3431,23.7025,180.3051,51,52); // gangcar

        AddStaticVehicle(597,2130.7661,-1491.7856,23.6084,356.7974,52,53); // gangcar

        AddStaticVehicle(598,2107.4709,-1585.4358,25.7587,181.7594,53,54); // gangcar

        AddStaticVehicle(599,2119.2222,-1659.2321,15.0223,174.7155,54,55); // gangcar

        AddStaticVehicle(560,2121.1707,-1773.9164,13.1887,94.9881,56,57); // gangcar

        AddStaticVehicle(561,2076.2532,-1865.4305,13.2550,181.7226,58,59); // gangcar

        AddStaticVehicle(562,2052.3323,-1904.3202,13.3431,3.2642,4,15); // gangcar

        AddStaticVehicle(563,1828.3253,-1913.3474,13.3215,357.3608,45,26); // gangcar

        AddStaticVehicle(415,1776.5583,-1912.7288,13.1830,271.6415,84,26); // gangcar

        AddStaticVehicle(474,1776.3618,-1925.2787,13.1811,271.2030,76,49); // gangcar

        AddStaticVehicle(475,1792.0237,-1932.1536,13.1816,4.4822,67,51); // gangcar

        AddStaticVehicle(476,1765.9498,-1818.2317,13.3487,70.1505,15,51); // gangcar

        AddStaticVehicle(477,1694.9153,-1659.6415,13.2577,357.8813,25,56); // gangcar

        AddStaticVehicle(478,1746.8011,-1595.1498,13.2527,254.6547,55,58); // gangcar

        AddStaticVehicle(479,1838.3705,-1483.9680,13.3427,7.1613,75,59); // gangcar

        AddStaticVehicle(480,2348.2151,-1161.2832,27.1249,272.6089,55,25); // gangcar

        AddStaticVehicle(481,2377.6423,-1322.1522,23.7962,177.5052,15,65); // gangcar

        AddStaticVehicle(482,2401.5159,-1390.9469,23.8456,3.6411,75,95); // gangcar

        AddStaticVehicle(483,2452.0122,-1557.0447,23.7967,2.5122,25,45); // gangcar

        AddStaticVehicle(484,2509.1118,-1854.0313,13.3430,178.1022,85,65); // gangcar

        AddStaticVehicle(485,2532.3057,-1937.4261,13.2381,267.2349,45,65); // gangcar

        AddStaticVehicle(486,2676.3799,-1925.9478,13.3430,267.8046,25,85); // gangcar

        AddStaticVehicle(412,1739.9867,-1613.6279,13.3839,358.5750,0,0); // russiancar

        AddStaticVehicle(412,1730.3237,-1614.8462,13.3844,356.9822,0,0); // russiancar

        AddStaticVehicle(412,1721.0916,-1609.3046,13.3854,93.2818,0,0); // russiancar

        AddStaticVehicle(412,1713.0714,-1616.7672,13.3882,356.0697,0,0); // russiancar

        AddStaticVehicle(461,1200.3756,-1833.5081,13.2361,4.9721,7,7); // bikercar

        AddStaticVehicle(463,1196.2322,-1834.2725,13.2447,356.5813,7,7); // bikercar

        AddStaticVehicle(463,1198.8773,-1827.9011,13.2446,274.4635,7,7); // bikercar

        AddStaticVehicle(468,1223.5638,-1835.1733,13.2267,187.8177,7,7); // bikercar

        AddStaticVehicle(468,1230.0758,-1834.9415,13.2286,185.5253,7,7); // bikercar

        AddStaticVehicle(463,1238.6196,-1834.8768,13.2286,182.9206,7,7); // bikercar

        AddStaticVehicle(561,2174.4668,-2267.2534,13.1978,227.3613,58,59); // italy

        AddStaticVehicle(561,2167.2207,-2274.2463,13.1952,227.4184,58,59); // italy

        AddStaticVehicle(561,2160.6382,-2281.0276,13.1969,227.6990,58,59); // italy

        AddStaticVehicle(561,2225.1804,-2209.8831,13.3602,228.3391,58,59); // italy

        AddStaticVehicle(561,2222.0906,-2214.6807,13.3607,46.9784,58,59); // italy

        AddStaticVehicle(561,2215.8130,-2216.7722,13.3608,227.7257,58,59); // italy

        AddStaticVehicle(561,2210.8108,-2224.0249,13.3606,43.3097,58,59); // italy

        AddStaticVehicle(561,2205.6438,-2226.4224,13.3605,223.8929,58,59); // italy

        AddStaticVehicle(561,2204.7710,-2230.2168,13.3610,44.5764,58,59); // italy

        AddStaticVehicle(561,2198.3391,-2235.1033,13.3601,224.2885,58,59); // italy

        AddStaticVehicle(412,870.2476,-1658.4238,13.3838,358.0815,124,124); // triad

        AddStaticVehicle(412,869.9180,-1668.1870,13.3836,357.5095,124,124); // triad

        AddStaticVehicle(412,874.6411,-1657.7109,13.3933,356.8999,124,124); // triad

        AddStaticVehicle(412,874.3600,-1668.6803,13.3847,359.3384,124,124); // triad

        AddStaticVehicle(412,879.1808,-1657.7527,13.3855,355.5392,124,124); // triad

        AddStaticVehicle(412,878.5628,-1668.6459,13.3859,1.3827,124,124); // triad

        AddStaticVehicle(412,883.6476,-1657.7158,13.4046,356.7072,124,124); // triad

        AddStaticVehicle(412,883.1293,-1668.7096,13.3836,0.6852,124,124); // triad

        AddStaticVehicle(412,888.6406,-1657.7531,13.3847,357.5479,124,124); // triad

        AddStaticVehicle(412,888.1874,-1668.1315,13.3842,356.3751,124,124); // triad

        AddStaticVehicle(412,892.3967,-1657.7495,13.3865,357.5911,124,124); // triad

        AddStaticVehicle(412,891.9304,-1668.5259,13.3887,356.9620,124,124); // triad

        AddStaticVehicle(412,874.1088,-1678.1108,13.3848,90.7278,124,124); // triad

        AddStaticVehicle(412,888.0291,-1677.9346,13.3844,90.7277,124,124); // triad

//Trains

//      AddStaticVehicle(537,-1943.3127,158.0254,27.0006,357.3614,121,1);

//      AddStaticVehicle(569,-1943.3127,158.0254,27.0006,357.3614,121,1);

//      AddStaticVehicle(569,-1943.3127,158.0254,27.0006,357.3614,121,1);

//      AddStaticVehicle(569,-1943.3127,158.0254,27.0006,357.3614,121,1);

//Pickups

        AddStaticPickup(370, 15, -2209.4707,294.1174,35.1172); // jetpack

        AddStaticPickup(370, 15, -1765.4392,-174.7473,3.5547); // jetpack

        AddStaticPickup(1240,2,2223.0151,-1163.7944,25.7331);//BallasHealthPickup

        AddStaticPickup(1242,2,2222.6230,-1160.8033,25.7331);//BallasArmor

        AddStaticPickup(355,2,2222.8564,-1167.8424,25.7331);//BallasM4

        AddStaticPickup(372,2,2222.9568,-1171.2338,25.7266);//BallasRPG

        AddStaticPickup(1240,2,2462.5701,-1700.3900,19.6250); // grovearmor

        AddStaticPickup(1242,2,2520.4915,-1694.7148,18.8742); // grovehealth

        AddStaticPickup(355,2,2493.8225,-1693.8153,23.5024); // guns1

        AddStaticPickup(372,2,2494.4333,-1700.5466,23.6408); // guns2

        AddStaticPickup(358,2,2494.0598,-1708.5504,23.6003); // guns3

        AddStaticPickup(1240,2,1206.5338,-1727.9563,13.5702); // nang gunz

        AddStaticPickup(1242,2,1197.3468,-1728.1719,13.5680); // nang gunz1

        AddStaticPickup(355,2,1196.1560,-1738.4722,13.5781); // nang gunz2

        AddStaticPickup(372,2,1198.9290,-1734.1022,13.5738); // nang gunz3

        AddStaticPickup(358,2,1193.2297,-1725.6244,14.0607); // nang gunz4

        AddStaticPickup(1240,2,1828.9779,-1694.2731,13.5469); // aztecs

        AddStaticPickup(1242,2,1829.2250,-1686.1115,13.5469); // aztecs1

        AddStaticPickup(355,2,1828.9879,-1679.6185,13.5469); // aztecs2

        AddStaticPickup(372,2,1828.8510,-1672.0320,13.5469); // aztecs3

        AddStaticPickup(372,2,2831.8074,-1182.6426,24.8195); // vag guns1

        AddStaticPickup(355,2,2833.3801,-1189.5232,24.6294); // vag guns2

        AddStaticPickup(1242,2,2834.7771,-1196.0183,24.4110); // vag guns3

        AddStaticPickup(1240,2,2835.0151,-1201.3669,24.1898); // vag guns4

        AddStaticPickup(1240,2,2150.6438,-2271.9050,14.2344); // gun1

        AddStaticPickup(1242,2,2147.8552,-2269.2341,14.2344); // gun2

        AddStaticPickup(355,2,2145.9407,-2267.0979,14.2344); // gun3

        AddStaticPickup(372,2,2147.2861,-2265.1370,14.4545); // gun4

        AddStaticPickup(358,2,2149.6641,-2267.3726,14.4545); // gun5

        igate = CreateObject(980,2233.875732,-2214.911865,13.546875,0.000000,0.000000,315.433532);

        igate2= CreateObject(980,2241.851318,-2222.769287,13.546875,0.000000,0.000000,315.120422);

        Grove = GangZoneCreate(2220.01, -1950.308, 2634.519, -1437.102);

        Ballas = GangZoneCreate(2010.854, -1448.945, 2509.025, -951.5297);

        Aztecs = GangZoneCreate(1862.543, -1926.622, 2193.39, -1397.625);

        Italy = GangZoneCreate(2079.305, -2435.881, 2547.053, -1950.308);

        Nang = GangZoneCreate(1075.356, -1934.517, 1531.696, -1369.99);

        Vagos = GangZoneCreate(2566.068, -1673.966, 2927.337, -1058.119);

        Russian = GangZoneCreate(1501.274, -1997.681, 1824.515, -1437.102);

        Bikers = GangZoneCreate(428.8739, -1942.413, 911.8341, -1504.214);

        SetTimer("GameModeExitFunc", gRoundTime, 0);

        return 1;

 }



//------------------------------------------------------------------------------



public OnPlayerConnect(playerid)

{
    GetPlayerName(playerid, ConnectName, 30);

        format(str, 256, "%s (%d) has joined the server.", ConnectName);

        SendClientMessageToAll(COLOR_ORANGE, str);

        GameTextForPlayer(playerid,"WELCOME TO OUR GANG WARS!",2500,5);

        SendClientMessage(playerid, COLOR_YELLOW,"For A list of Colors type /color /color2"); //62

        SendClientMessage(playerid, COLOR_ORANGE,"For a List Of Commands Type /commands"); //62

        GivePlayerMoney(playerid, 1000);

        SetPlayerHealth(playerid, 50);

        SetPlayerColor(playerid, COLOR_GREY); // Set the player's color to inactive

        return 1;

}
public OnPlayerDisconnect(playerid, reason)
{
        //New
        new name[MAX_PLAYER_NAME+1];
        new string[256];
        //GetPlayerName
        GetPlayerName(playerid, name, sizeof(name));
        //Text
        format(string, sizeof(string), "%s (%d) Has Left The Server.", name, playerid);
        SendClientMessageToAll(COLOR_WHITE, string);
        return 1;
}



//------------------------------------------------------------------------------



public OnPlayerSpawn(playerid)
{


    GameTextForPlayer(playerid,"~g~LS GangWars",5000,5);

    SetPlayerInterior(playerid,0);

        if(gTeam[playerid] == TEAM_GROVE) {

        SetPlayerColor(playerid,COLOR_GREEN); // Yellow

                }



        else if(gTeam[playerid] == TEAM_BALLAS) {

        SetPlayerColor(playerid,COLOR_PURPLE); // blue

                }

        else if(gTeam[playerid] == TEAM_AZTEC) {

        SetPlayerColor(playerid,COLOR_LIGHTBLUE); // green

                }

        else if(gTeam[playerid] == TEAM_NANG) {

        SetPlayerColor(playerid,COLOR_DARKRED);

                }
        else if(gTeam[playerid] == TEAM_VAGOS) {

        SetPlayerColor(playerid,COLOR_YELLOW);

                }
        else if(gTeam[playerid] == TEAM_RUSSIAN) {

        SetPlayerColor(playerid,COLOR_RED);

                }
        else if(gTeam[playerid] == TEAM_ITALYMAFIA) {

        SetPlayerColor(playerid,COLOR_BLACK);


                }
        else if(gTeam[playerid] == TEAM_BIKER) {

        SetPlayerColor(playerid,COLOR_ORANGE);

                }
        else if(gTeam[playerid] == TEAM_TRIAD) {

        SetPlayerColor(playerid,COLOR_WHITE);




        ShowNameTags(0);

        ShowPlayerMarkers(0);
}

        GangZoneShowForPlayer(playerid, Grove, 0x23C93C96);
        GangZoneShowForPlayer(playerid, Ballas, 0x8016A396);
        GangZoneShowForPlayer(playerid, Aztecs, 0x00FFFF96);
        GangZoneShowForPlayer(playerid, Italy, 0x00000096);
        GangZoneShowForPlayer(playerid, Nang, 0x95133496);
        GangZoneShowForPlayer(playerid, Vagos, 0xFFFF0096);
        GangZoneShowForPlayer(playerid, Russian, 0xFF000096);
        GangZoneShowForPlayer(playerid, Bikers, 0xFF800096);
        return 1;

}



//------------------------------------------------------------------------------



public OnPlayerDeath(playerid, killerid, reason)
{
if(GangKills == MAX_ZONE_KILLS)
GangKills = 3;
GangKills ++;
GangKills = killerid ;
GangZoneFlashForAll(Grove,0xCA0000FF);
SendClientMessageToAll(COLOR_GREEN,"GangZone Message: Ganton is being attacked");

new GangTake;
if(GangTake == MAX_TAKE_KILLS)
GangTake = 5;
GangTake ++;
GangTake = killerid ;
new zone;

if(GangTake == MAX_TAKE_KILLS ) // If the zone kills equals the max kills allowed to win zone. Stop the flashing
                                {
                                        GangZoneStopFlashForAll(Grove);
                                        GangZoneHideForAll(Grove);
                                        GangZoneShowForAll(zone, GetPlayerColor(killerid) ); // Sets the zones color to the killers
                                        GangTake = killerid;
                                        GetPlayerColor(killerid);
                                        GangTake = 0;

  }
if(killerid == INVALID_PLAYER_ID)
{
SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
}

//VALID KILL

else
{
if(gTeam[killerid] != gTeam[playerid])
{
SendDeathMessage(killerid,playerid,reason);
SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
GivePlayerMoney(killerid, 1000);
}

//TEAM KILL

else
{
SendClientMessage(killerid, COLOR_RED, "Teamkilling! Be careful the next time!");
SendDeathMessage(killerid,playerid,reason);
SetPlayerScore(killerid,GetPlayerScore(killerid)-3);
GivePlayerMoney(killerid, -2000);
SetPlayerHealth(killerid,0);
if(GetPlayerScore(killerid) == -3)
SetPlayerWantedLevel(playerid,2);
{
SendClientMessage(killerid, COLOR_RED, "Once again and you will be kicked!");
}
if(GetPlayerScore(killerid) == -6)
{
Kick(killerid);
new string[256];
new name[MAX_PLAYER_NAME];
GetPlayerName(killerid,name, sizeof(name));
format(string, sizeof(string), "The AntiTeamkill system kicked %s for teamkilling!",name);
SendClientMessageToAll(COLOR_GREEN, string);
}
}
}
return 1;
}















//------------------------------------------------------------------------------

public OnPlayerRequestClass(playerid, classid)

{

        SetPlayerClass(playerid, classid);

        gPlayerClass[playerid] = classid;

        switch (classid) {

            case 0:

                {

                                GameTextForPlayer(playerid, "~g~Grove", 500, 3);
                                {SetPlayerPos(playerid, 2482.4531,-1685.9695,13.5078);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 2479.531,-1682.5695,13.5078);
                                 SetPlayerCameraLookAt(playerid, 2482.4531,-1685.9695,13.5078);}

                        }

                case 1:

                    {

                                GameTextForPlayer(playerid, "~g~Grove", 500, 3);
                                {SetPlayerPos(playerid, 2482.4531,-1685.9695,13.5078);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 2479.531,-1682.5695,13.5078);
                                 SetPlayerCameraLookAt(playerid, 2482.4531,-1685.9695,13.5078);}

                        }

                case 2:

                {

                                GameTextForPlayer(playerid, "~g~Grove", 500, 3);
                                {SetPlayerPos(playerid, 2482.4531,-1685.9695,13.5078);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 2479.531,-1682.5695,13.5078);
                                 SetPlayerCameraLookAt(playerid, 2482.4531,-1685.9695,13.5078);}

                        }

                case 3:

                {

                                GameTextForPlayer(playerid, "~g~Grove", 500, 3);
                                {SetPlayerPos(playerid, 2482.4531,-1685.9695,13.5078);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 2479.531,-1682.5695,13.5078);
                                 SetPlayerCameraLookAt(playerid, 2482.4531,-1685.9695,13.5078);}

                        }

                case 4:

                {

                                GameTextForPlayer(playerid, "~g~Grove", 500, 3);
                                {SetPlayerPos(playerid, 2482.4531,-1685.9695,13.5078);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 2479.531,-1682.5695,13.5078);
                                 SetPlayerCameraLookAt(playerid, 2482.4531,-1685.9695,13.5078);}

                        }

                case 5:

                {

                                GameTextForPlayer(playerid, "~p~Ballas", 500, 3);
                                {SetPlayerPos(playerid, 2229.8271,-1166.7804,25.7707);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 2226.4271,-1163.3804,25.7707);
                                 SetPlayerCameraLookAt(playerid, 2229.8271,-1166.7804,25.7707);}

                        }

                case 6:

                {

                                GameTextForPlayer(playerid, "~p~Ballas", 500, 3);
                                {SetPlayerPos(playerid, 2229.8271,-1166.7804,25.7707);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 2226.4271,-1163.3804,25.7707);
                                 SetPlayerCameraLookAt(playerid, 2229.8271,-1166.7804,25.7707);}

                        }

                case 7:

                {

                                GameTextForPlayer(playerid, "~p~Ballas", 500, 3);
                                {SetPlayerPos(playerid, 2229.8271,-1166.7804,25.7707);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 2226.4271,-1163.3804,25.7707);
                                 SetPlayerCameraLookAt(playerid, 2229.8271,-1166.7804,25.7707);}

                        }
                case 8:

                {

                                GameTextForPlayer(playerid, "~p~Ballas", 500, 3);
                                {SetPlayerPos(playerid, 2229.8271,-1166.7804,25.7707);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 2226.4271,-1163.3804,25.7707);
                                 SetPlayerCameraLookAt(playerid, 2229.8271,-1166.7804,25.7707);}

                        }
                        case 9:

                {

                                GameTextForPlayer(playerid, "~b~Aztec", 500, 3);
                                {SetPlayerPos(playerid, 1832.2875,-1677.5171,17.1507);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 1829.875,-1674.1171,17.1507);
                                 SetPlayerCameraLookAt(playerid, 1832.2875,-1677.5171,17.1507);}
            }
                        case 10:

                {

                                GameTextForPlayer(playerid, "~b~Aztec", 500, 3);
                                {SetPlayerPos(playerid, 1832.2875,-1677.5171,17.1507);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 1829.875,-1674.1171,17.1507);
                                 SetPlayerCameraLookAt(playerid, 1832.2875,-1677.5171,17.1507);}
            }
                        case 11:

                {

                                GameTextForPlayer(playerid, "~b~Aztec", 500, 3);
                                {SetPlayerPos(playerid, 1832.2875,-1677.5171,17.1507);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 1829.875,-1674.1171,17.1507);
                                 SetPlayerCameraLookAt(playerid, 1832.2875,-1677.5171,17.1507);}

            }
                        case 12:

                {

                                GameTextForPlayer(playerid, "~b~Aztec", 500, 3);
                                {SetPlayerPos(playerid, 1832.2875,-1677.5171,17.1507);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 1829.875,-1674.1171,17.1507);
                                 SetPlayerCameraLookAt(playerid, 1832.2875,-1677.5171,17.1507);}
                                }
                                case 13:

                {

                                GameTextForPlayer(playerid, "~b~Aztec", 500, 3);
                                {SetPlayerPos(playerid, 1832.2875,-1677.5171,17.1507);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 1829.875,-1674.1171,17.1507);
                                 SetPlayerCameraLookAt(playerid, 1832.2875,-1677.5171,17.1507);}
                                }
                                case 14:

                {

                                GameTextForPlayer(playerid, "~b~Aztec", 500, 3);
                                {SetPlayerPos(playerid, 1832.2875,-1677.5171,17.1507);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 1829.875,-1674.1171,17.1507);
                                 SetPlayerCameraLookAt(playerid, 1832.2875,-1677.5171,17.1507);}

}

                case 15:

                {

                                GameTextForPlayer(playerid, "~r~Nang", 500, 3);
                                {SetPlayerPos(playerid, 1208.0321,-1746.3037,13.5933);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 1205.321,-1743.037,13.5933);
                                 SetPlayerCameraLookAt(playerid, 1208.0321,-1746.3037,13.5933);}

                        }

                case 16:

                    {

                                GameTextForPlayer(playerid, "~r~Nang", 500, 3);
                                {SetPlayerPos(playerid, 1208.0321,-1746.3037,13.5933);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 1205.321,-1743.037,13.5933);
                                 SetPlayerCameraLookAt(playerid, 1208.0321,-1746.3037,13.5933);}

                        }

                case 17:

                {

                                GameTextForPlayer(playerid, "~r~Nang", 500, 3);
                                {SetPlayerPos(playerid, 1208.0321,-1746.3037,13.5933);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 1205.321,-1743.037,13.5933);
                                 SetPlayerCameraLookAt(playerid, 1208.0321,-1746.3037,13.5933);}

                        }

                case 18:

                {

                                GameTextForPlayer(playerid, "~r~Nang", 500, 3);
                                {SetPlayerPos(playerid, 1208.0321,-1746.3037,13.5933);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 1205.321,-1743.037,13.5933);
                                 SetPlayerCameraLookAt(playerid, 1208.0321,-1746.3037,13.5933);}

                        }

                case 19:

                {

                                GameTextForPlayer(playerid, "~y~Vagos", 500, 3);
                                {SetPlayerPos(playerid, 2810.3608,-1177.2137,25.3201);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 2807.608,-1174.137,25.3201);
                                 SetPlayerCameraLookAt(playerid, 2810.3608,-1177.2137,25.3201);}

                        }


                case 20:

                    {

                                GameTextForPlayer(playerid, "~y~Vagos", 500, 3);
                                {SetPlayerPos(playerid, 2810.3608,-1177.2137,25.3201);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 2807.608,-1174.137,25.3201);
                                 SetPlayerCameraLookAt(playerid, 2810.3608,-1177.2137,25.3201);}

                        }

                case 21:

                {

                                GameTextForPlayer(playerid, "~y~Vagos", 500, 3);
                                {SetPlayerPos(playerid, 2810.3608,-1177.2137,25.3201);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 2807.608,-1174.137,25.3201);
                                 SetPlayerCameraLookAt(playerid, 2810.3608,-1177.2137,25.3201);}

                        }

                case 22:

                {

                                GameTextForPlayer(playerid, "~r~Russian", 500, 3);
                                {SetPlayerPos(playerid, 1725.9430,-1633.0537,20.2154);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 1722.5430,-1630.0537,20.2154);
                                 SetPlayerCameraLookAt(playerid, 1725.9430,-1633.0537,20.2154);}


                        }
                        case 23:

                {

                                GameTextForPlayer(playerid, "~r~Russian", 500, 3);
                                {SetPlayerPos(playerid, 1725.9430,-1633.0537,20.2154);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 1722.5430,-1630.0537,20.2154);
                                 SetPlayerCameraLookAt(playerid, 1725.9430,-1633.0537,20.2154);}

                        }
                        case 24:

                {

                                GameTextForPlayer(playerid, "~r~Russian", 500, 3);
                                {SetPlayerPos(playerid, 1725.9430,-1633.0537,20.2154);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 1722.5430,-1630.0537,20.2154);
                                 SetPlayerCameraLookAt(playerid, 1725.9430,-1633.0537,20.2154);}

                        }
                        case 25:

                {

                                GameTextForPlayer(playerid, "~r~Russian", 500, 3);
                                {SetPlayerPos(playerid, 1725.9430,-1633.0537,20.2154);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 1722.5430,-1630.0537,20.2154);
                                 SetPlayerCameraLookAt(playerid, 1725.9430,-1633.0537,20.2154);}

                        }
                        case 26:

                {

                                GameTextForPlayer(playerid, "~r~Italian~n~Mafia", 500, 3);
                                {SetPlayerPos(playerid, 2130.9968,-2279.8772,20.6643);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 2127.5968,-2276.4772,20.6643);
                                 SetPlayerCameraLookAt(playerid, 2130.9968,-2279.8772,20.6643);}

                        }
                        case 27:

                {

                                GameTextForPlayer(playerid, "~r~Italian~n~Mafia", 500, 3);
                                {SetPlayerPos(playerid, 2130.9968,-2279.8772,20.6643);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 2127.5968,-2276.4772,20.6643);
                                 SetPlayerCameraLookAt(playerid, 2130.9968,-2279.8772,20.6643);}

                        }
                        case 28:

                {

                                GameTextForPlayer(playerid, "~r~Italian~n~Mafia", 500, 3);
                                {SetPlayerPos(playerid, 2130.9968,-2279.8772,20.6643);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 2127.5968,-2276.4772,20.6643);
                                 SetPlayerCameraLookAt(playerid, 2130.9968,-2279.8772,20.6643);}

                        }
                        case 29:

                {

                                GameTextForPlayer(playerid, "~r~Italian~n~Mafia", 500, 3);
                                {SetPlayerPos(playerid, 2130.9968,-2279.8772,20.6643);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 2127.5968,-2276.4772,20.6643);
                                 SetPlayerCameraLookAt(playerid, 2130.9968,-2279.8772,20.6643);}

                        }
                        case 30:

                {

                                GameTextForPlayer(playerid, "~r~Italian~n~Mafia", 500, 3);
                                {SetPlayerPos(playerid, 2130.9968,-2279.8772,20.6643);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 2127.5968,-2276.4772,20.6643);
                                 SetPlayerCameraLookAt(playerid, 2130.9968,-2279.8772,20.6643);}

                        }
                        case 31:

                {

                                GameTextForPlayer(playerid, "~r~Biker", 500, 3);
                                {SetPlayerPos(playerid, 1221.6252,-1815.5408,16.5938);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 1218.2252,-1812.1408,16.5938);
                                 SetPlayerCameraLookAt(playerid, 1221.6252,-1815.5408,16.5938);}

                        }
                        case 32:

                {

                                GameTextForPlayer(playerid, "~r~Biker", 500, 3);
                                {SetPlayerPos(playerid, 1221.6252,-1815.5408,16.5938);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 1218.2252,-1812.1408,16.5938);
                                 SetPlayerCameraLookAt(playerid, 1221.6252,-1815.5408,16.5938);}

                        }
                        case 33:

                {

                                GameTextForPlayer(playerid, "~r~Biker", 500, 3);
                                {SetPlayerPos(playerid, 1221.6252,-1815.5408,16.5938);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 1218.2252,-1812.1408,16.5938);
                                 SetPlayerCameraLookAt(playerid, 1221.6252,-1815.5408,16.5938);}

                        }
                        case 34:

                {

                                GameTextForPlayer(playerid, "~w~Triad", 500, 3);
                                {SetPlayerPos(playerid, 863.4913,-1638.3412,14.9521);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 860.913,-1635.412,14.9521);
                                 SetPlayerCameraLookAt(playerid, 863.4913,-1638.3412,14.9521);}

                        }
                        case 35:

                {

                                GameTextForPlayer(playerid, "~w~Triad", 500, 3);
                                {SetPlayerPos(playerid, 863.4913,-1638.3412,14.9521);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 860.913,-1635.412,14.9521);
                                 SetPlayerCameraLookAt(playerid, 863.4913,-1638.3412,14.9521);}

                        }
                        case 36:

                {

                                GameTextForPlayer(playerid, "~w~Triad", 500, 3);
                                {SetPlayerPos(playerid, 863.4913,-1638.3412,14.9521);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 860.913,-1635.412,14.9521);
                                 SetPlayerCameraLookAt(playerid, 863.4913,-1638.3412,14.9521);}

                        }case 37:

                {

                                GameTextForPlayer(playerid, "~w~Triad", 500, 3);
                                {SetPlayerPos(playerid, 863.4913,-1638.3412,14.9521);
                                 SetPlayerFacingAngle(playerid,630);
                                 SetPlayerCameraPos(playerid, 860.913,-1635.412,14.9521);
                                 SetPlayerCameraLookAt(playerid, 863.4913,-1638.3412,14.9521);}

                        }





 }



        return 1;

}



//------------------------------------------------------------------------------



public GameModeExitFunc()

 {

        GameModeExit();

        return 1;

 }



//------------------------------------------------------------------------------



SetPlayerClass(playerid, classid) {

        if(classid == 0) {

        gTeam[playerid] = TEAM_GROVE;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 1) {

        gTeam[playerid] = TEAM_GROVE;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 2) {

        gTeam[playerid] = TEAM_GROVE;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 3) {

        gTeam[playerid] = TEAM_GROVE;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 4) {

        gTeam[playerid] = TEAM_GROVE;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 5) {

        gTeam[playerid] = TEAM_BALLAS;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 6) {

        gTeam[playerid] = TEAM_BALLAS;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 7) {

        gTeam[playerid] = TEAM_BALLAS;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 8) {

        gTeam[playerid] = TEAM_BALLAS;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 9) {

        gTeam[playerid] = TEAM_AZTEC;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 10) {

        gTeam[playerid] = TEAM_AZTEC;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 11) {

        gTeam[playerid] = TEAM_AZTEC;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 12) {

        gTeam[playerid] = TEAM_AZTEC;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 13) {

        gTeam[playerid] = TEAM_AZTEC;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 14) {

        gTeam[playerid] = TEAM_AZTEC;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 15) {
        gTeam[playerid] = TEAM_NANG;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 16) {

        gTeam[playerid] = TEAM_NANG;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 17) {

        gTeam[playerid] = TEAM_NANG;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 18) {

        gTeam[playerid] = TEAM_NANG;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 19) {

        gTeam[playerid] = TEAM_VAGOS;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 20) {

        gTeam[playerid] = TEAM_VAGOS;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

        } else if(classid == 21) {

        gTeam[playerid] = TEAM_VAGOS;
        GivePlayerWeapon(playerid,32,400);
        GivePlayerWeapon(playerid,22,200);

         } else if(classid == 22) {

         gTeam[playerid] = TEAM_RUSSIAN;
         GivePlayerWeapon(playerid,32,400);
         GivePlayerWeapon(playerid,22,200);

         } else if(classid == 23) {

         gTeam[playerid] = TEAM_RUSSIAN;
         GivePlayerWeapon(playerid,32,400);
         GivePlayerWeapon(playerid,22,200);

         } else if(classid == 24) {

         gTeam[playerid] = TEAM_RUSSIAN;
         GivePlayerWeapon(playerid,32,400);
         GivePlayerWeapon(playerid,22,200);

         } else if(classid == 25) {

         gTeam[playerid] = TEAM_RUSSIAN;
         GivePlayerWeapon(playerid,32,400);
         GivePlayerWeapon(playerid,22,200);

         } else if(classid == 26) {

         gTeam[playerid] = TEAM_ITALYMAFIA;
         GivePlayerWeapon(playerid,32,400);
         GivePlayerWeapon(playerid,22,200);

         } else if(classid == 27) {

         gTeam[playerid] = TEAM_ITALYMAFIA;
         GivePlayerWeapon(playerid,32,400);
         GivePlayerWeapon(playerid,22,200);

         } else if(classid == 28) {

         gTeam[playerid] = TEAM_ITALYMAFIA;
         GivePlayerWeapon(playerid,32,400);
         GivePlayerWeapon(playerid,22,200);

         } else if(classid == 29) {

         gTeam[playerid] = TEAM_ITALYMAFIA;
         GivePlayerWeapon(playerid,32,400);
         GivePlayerWeapon(playerid,22,200);

         } else if(classid == 30) {

         gTeam[playerid] = TEAM_ITALYMAFIA;
         GivePlayerWeapon(playerid,32,400);
         GivePlayerWeapon(playerid,22,200);

         } else if(classid == 31) {

         gTeam[playerid] = TEAM_BIKER;
         GivePlayerWeapon(playerid,32,400);
         GivePlayerWeapon(playerid,22,200);

         } else if(classid == 32) {

         gTeam[playerid] = TEAM_BIKER;
         GivePlayerWeapon(playerid,32,400);
         GivePlayerWeapon(playerid,22,200);

         } else if(classid == 33) {

         gTeam[playerid] = TEAM_BIKER;
         GivePlayerWeapon(playerid,32,400);
         GivePlayerWeapon(playerid,22,200);

         } else if(classid == 34) {

         gTeam[playerid] = TEAM_TRIAD;
         GivePlayerWeapon(playerid,32,400);
         GivePlayerWeapon(playerid,22,200);

         } else if(classid == 35) {

         gTeam[playerid] = TEAM_TRIAD;
         GivePlayerWeapon(playerid,32,400);
         GivePlayerWeapon(playerid,22,200);

         } else if(classid == 36) {

         gTeam[playerid] = TEAM_TRIAD;
         GivePlayerWeapon(playerid,32,400);
         GivePlayerWeapon(playerid,22,200);

         } else if(classid == 37) {

         gTeam[playerid] = TEAM_TRIAD;
         GivePlayerWeapon(playerid,32,400);
         GivePlayerWeapon(playerid,22,200);


                }

 }



public OnPlayerCommandText(playerid, cmdtext[])


{
        if(!strcmp(cmdtext,"/color",true)) {
    SendClientMessage(playerid, COLOR_RED,"Red=Russians"); //62
    SendClientMessage(playerid, COLOR_BLACK,"Black=ItalyMafia"); //62
    SendClientMessage(playerid, COLOR_YELLOW,"Yellow=Vagos"); //62
    SendClientMessage(playerid, COLOR_PURPLE,"Purple=Ballas"); //62
    SendClientMessage(playerid, COLOR_PURPLE,"Green=Grove"); //62
    SendClientMessage(playerid, COLOR_WHITE,"To See more colors type /color2"); //62
        return 1;
}
        if(!strcmp(cmdtext,"/color2",true)) {
    SendClientMessage(playerid, COLOR_ORANGE,"ORANGE=Bikers"); //62
    SendClientMessage(playerid, COLOR_LIGHTBLUE,"LightBlue=Aztecs"); //62
    SendClientMessage(playerid, COLOR_DARKRED,"Darkred=Nangs"); //62
    SendClientMessage(playerid, COLOR_WHITE,"White=Triads"); //62
    return 1;
}

        if(!strcmp(cmdtext,"/iwanttofly",true)){
        SetPlayerPos(playerid, -1722.6364,883.3743,415.6206);
    return 1;
}


        if(!strcmp(cmdtext,"/grove",true)) {
    SetPlayerPos(playerid, 2467.194, -1673.966, 15);
    return 1;
}
        if(strcmp(cmdtext, "/kill", true) == 0)
        {
            SetPlayerHealth(playerid,0.0);
        return 1;
 }
        if(strcmp(cmdtext, "/opengate", true) == 0) {
   if (gTeam[playerid] == TEAM_ITALYMAFIA) {
   MoveObject(igate,2242.175732,-2205.911865,13.546875,2.5);
   SendClientMessage(playerid, COLOR_GREEN1,"Opening gate now, please wait...");
   }else{
   SendClientMessage(playerid, COLOR_RED, "You are not an official Italy Mafia Member!!");
}
   return 1;
}


    if(strcmp(cmdtext, "/closegate", true) == 0) {
   if (gTeam[playerid] == TEAM_ITALYMAFIA) {
   MoveObject(igate,2233.875732,-2214.911865,13.546875,2.5);
   SendClientMessage(playerid, COLOR_GREEN1,"Closing gate now, please wait...");
    }else{
        SendClientMessage(playerid, COLOR_RED, "You are not an official Italy Mafia Member!!");
}
   return 1;
}
        if(!strcmp(cmdtext,"/a",true)) {
    SetPlayerPos(playerid, 2230.875732,-2214.911865, 15);
    return 1;
}
    return 0;

}

