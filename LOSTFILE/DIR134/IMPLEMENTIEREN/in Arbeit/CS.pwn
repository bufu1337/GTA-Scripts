
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
new DMTime;
new Count;
new IsBombPlanted = 0;
new DefuseCode = 0;
new Defused = 0;

forward DMTimer(playerid);
forward Counter(playerid);
forward Exiter(playerid);
forward ExitTheGameMode();
forward SendPlayerFormattedText(playerid, const string[], define);
forward OnPlayerEnterCheckpoint(playerid);
//------------------------------------------------------------------------------
main()
{
        print("\n----------------------------------");
        print("           Abandoned Island Counter-Strike");
        print("              by s1k            ");
        print("----------------------------------\n");
}
//------------------------------------------------------------------------------
public OnGameModeInit()
{
        SetGameModeText("Abandoned Island Counter-Strike");
        SetTeamCount(2);
        ShowNameTags(1);
        ShowPlayerMarkers(1);
        SetWorldTime(12);
    SetWeather(9);
    UsePlayerPedAnims();
        DMTime = 900;
        SetTimer("DMTimer", 999, 1);


        AddPlayerClass(29, 3147.8560,-1248.1599,57.9542, 360, 4, 0, 31, 100, 0, 0); //T
        AddPlayerClass(121, 3147.8560,-1248.1599,57.9542, 360, 4, 0, 34, 100, 0, 0); //T
        AddPlayerClass(28, 3147.8560,-1248.1599,57.9542, 360, 16, 5, 36, 100, 0, 0); //T
        AddPlayerClass(122, 3147.8560,-1248.1599,57.9542, 360, 4, 0, 26, 100, 0, 0); //T
        AddPlayerClass(285, 3163.6218,-1168.4437,30.3423, 270.0665, 3, 0, 24, 100, 0, 0); //CT
        AddPlayerClass(286, 3155.9600,-1130.2126,34.2338, 270.0665, 17, 10, 29, 100, 0, 0); //CT
        AddPlayerClass(287, 3198.0750,-1204.7925,41.6208, 270.0665, 3, 0, 27, 100, 0, 0); //CT
        AddPlayerClass(164, 3163.6218,-1168.4437,30.3423, 270.0665, 17, 10, 31, 100, 0, 0); //CT

CreateObject(10491, 3139.482910, -1136.145508, 25.931807, 0.0000, 0.0000, 225.0000);
CreateObject(656, 3189.495117, -1187.390625, 40.026009, 0.0000, 0.0000, 0.0000);
CreateObject(656, 3220.505371, -1140.323120, 28.999336, 0.0000, 0.0000, 0.0000);
CreateObject(656, 3177.282471, -1094.217896, 27.725098, 0.0000, 0.0000, 0.0000);
CreateObject(656, 3162.684570, -1065.087524, 23.018883, 0.0000, 0.0000, 0.0000);
CreateObject(656, 3156.025635, -1091.586914, 26.506607, 0.0000, 0.0000, 0.0000);
CreateObject(656, 3141.438477, -1138.929199, 28.094536, 0.0000, 0.0000, 0.0000);
CreateObject(656, 3138.147217, -1165.707397, 29.049080, 0.0000, 0.0000, 0.0000);
CreateObject(656, 3165.613525, -1179.692749, 33.739059, 0.0000, 0.0000, 0.0000);
CreateObject(656, 3184.946533, -1174.953613, 36.593452, 0.0000, 0.0000, 0.0000);
CreateObject(656, 3216.851074, -1112.306519, 21.160667, 0.0000, 0.0000, 0.0000);
CreateObject(656, 3242.649658, -1131.121094, 18.954613, 0.0000, 0.0000, 0.0000);
CreateObject(664, 3167.090576, -1204.596191, 35.899124, 0.0000, 0.0000, 0.0000);
CreateObject(664, 3119.545654, -1130.591797, 23.638235, 0.0000, 0.0000, 0.0000);
CreateObject(664, 3123.043701, -1106.209351, 26.695490, 0.0000, 0.0000, 0.0000);
CreateObject(664, 3136.610352, -1116.822754, 26.070587, 0.0000, 0.0000, 0.0000);
CreateObject(664, 3134.387207, -1132.630127, 25.206717, 0.0000, 0.0000, 0.0000);
CreateObject(670, 3106.176270, -1162.161377, 26.620535, 0.0000, 0.0000, 0.0000);
CreateObject(672, 3109.151611, -1178.873047, 27.011776, 0.0000, 0.0000, 0.0000);
CreateObject(672, 3142.122803, -1181.776611, 32.261639, 0.0000, 0.0000, 0.0000);
CreateObject(672, 3151.067139, -1206.695435, 37.757069, 0.0000, 0.0000, 0.0000);
CreateObject(672, 3174.245605, -1234.680664, 52.294117, 0.0000, 0.0000, 0.0000);
CreateObject(672, 3125.034668, -1228.381104, 47.424404, 0.0000, 0.0000, 0.0000);
CreateObject(672, 3151.725098, -1226.680908, 52.340984, 0.0000, 0.0000, 0.0000);
CreateObject(683, 3124.540039, -1178.848877, 27.769394, 0.0000, 0.0000, 0.0000);
CreateObject(683, 3097.950684, -1181.730591, 23.684801, 0.0000, 0.0000, 0.0000);
CreateObject(683, 3095.455566, -1116.519653, 20.622694, 0.0000, 0.0000, 0.0000);
CreateObject(683, 3090.371826, -1163.417725, 15.326273, 0.0000, 0.0000, 0.0000);
CreateObject(683, 3078.888428, -1175.784912, 16.008123, 0.0000, 0.0000, 0.0000);
CreateObject(3168, 3159.501953, -1252.885132, 57.633785, 348.8273, 359.1406, 337.5000);
CreateObject(3168, 3150.079102, -1257.694946, 59.315880, 0.0000, 330.7792, 270.0000);
CreateObject(3168, 3140.809570, -1250.932373, 57.061264, 15.4699, 0.8594, 202.5000);
CreateObject(983, 3135.148438, -1248.093506, 56.957611, 347.1084, 354.8434, 358.2811);
CreateObject(983, 3135.476563, -1253.858154, 58.421631, 333.3575, 355.7028, 23.2821);
CreateObject(983, 3138.729736, -1259.159546, 60.114929, 0.0000, 0.0000, 33.7500);
CreateObject(983, 3143.606445, -1262.864258, 61.470688, 0.0000, 0.0000, 67.5000);
CreateObject(983, 3149.630615, -1264.028198, 61.918877, 0.0000, 0.0000, 90.0000);
CreateObject(983, 3155.239746, -1262.220337, 61.296852, 0.0000, 0.0000, 315.0000);
CreateObject(983, 3159.964355, -1258.172485, 59.865364, 0.0000, 0.0000, 112.4999);
CreateObject(983, 3164.618164, -1254.149902, 58.442612, 0.0000, 0.0000, 315.0000);
CreateObject(11556, 3158.124512, -1275.174316, 14.396935, 0.0000, 0.0000, 22.5000);
CreateObject(11556, 3161.666504, -1265.487549, 28.927856, 0.0000, 0.0000, 45.0000);
CreateObject(11556, 3160.110107, -1270.138916, 37.904232, 0.0000, 0.0000, 33.7500);
CreateObject(11556, 3148.106934, -1278.041138, 49.094845, 0.0000, 0.0000, 0.0000);
CreateObject(16112, 3124.229736, -1255.829346, 47.807453, 0.0000, 0.0000, 0.0000);
CreateObject(16113, 3173.055908, -1251.816284, 42.939133, 0.0000, 0.0000, 67.5000);
CreateObject(16113, 3206.424072, -1227.362305, 41.939182, 0.0000, 0.0000, 78.7500);
CreateObject(16113, 3235.961182, -1189.715820, 35.226154, 0.0000, 0.0000, 67.5000);
CreateObject(16113, 3254.770752, -1160.630127, 20.467768, 0.0000, 0.0000, 78.7500);
CreateObject(16113, 3250.120117, -1122.507080, 13.409906, 0.0000, 0.0000, 0.0000);
CreateObject(16113, 3222.640137, -1096.337646, 13.174839, 0.0000, 0.0000, 0.0000);
CreateObject(16113, 3194.574951, -1066.828857, 12.455215, 0.0000, 0.0000, 0.0000);
CreateObject(16113, 3170.168701, -1034.293945, 11.391201, 0.0000, 0.0000, 0.0000);
CreateObject(16113, 3149.204590, -1014.772278, 8.033104, 0.0000, 0.0000, 0.0000);
CreateObject(971, 3252.344727, -1140.115112, 17.062750, 0.0000, 0.0000, 56.2500);
CreateObject(971, 3249.411377, -1165.239014, 32.989037, 0.0000, 0.0000, 236.2501);
CreateObject(971, 3235.956787, -1169.148804, 31.551754, 0.0000, 0.0000, 22.5000);
CreateObject(16116, 3096.948486, -1236.353027, 36.867958, 0.0000, 0.0000, 22.5000);
CreateObject(16116, 3081.297852, -1207.709473, 24.867954, 0.0000, 0.0000, 22.5000);
CreateObject(16116, 3065.881104, -1196.621460, 21.262932, 0.0000, 0.0000, 11.2500);
CreateObject(16116, 3109.501221, -1248.392700, 1.131866, 0.0000, 0.0000, 0.0000);
CreateObject(16116, 3106.934814, -1244.679932, 18.228083, 0.0000, 0.0000, 0.0000);
CreateObject(16116, 3108.688232, -1243.047729, 27.182878, 0.0000, 0.0000, 0.0000);
CreateObject(16116, 3095.856201, -1221.179565, 1.289328, 0.0000, 0.0000, 180.0000);
CreateObject(16116, 3087.164063, -1218.417236, 15.987613, 0.0000, 0.0000, 11.2500);
CreateObject(16116, 3052.884033, -1198.712402, 0.783089, 0.0000, 0.0000, 0.0000);
CreateObject(16116, 3071.072754, -1198.157837, 11.487455, 0.0000, 0.0000, 180.0000);
CreateObject(5131, 3188.641113, -1144.136597, 37.322491, 12.0321, 0.0000, 202.5000);
CreateObject(3361, 3193.360352, -1129.364258, 33.568272, 0.8594, 350.5462, 292.5000);
CreateObject(3361, 3194.803955, -1132.741699, 33.021000, 0.8594, 353.1245, 292.5000);
CreateObject(1681, 3156.453125, -1198.866943, 36.401871, 317.0282, 358.2811, 0.0000);
CreateObject(3526, 3194.510986, -1210.249390, 40.957470, 0.0000, 0.0000, 337.5000);
CreateObject(3526, 3191.952881, -1210.094849, 41.100292, 0.0000, 0.0000, 337.5000);
CreateObject(3526, 3189.264160, -1210.551636, 40.951843, 0.0000, 0.0000, 337.5000);
CreateObject(3526, 3185.757568, -1211.273682, 40.797623, 0.0000, 0.0000, 337.5000);
CreateObject(3526, 3177.235596, -1225.015991, 47.043934, 0.0000, 0.0000, 337.5000);
CreateObject(3526, 3173.887695, -1231.015137, 50.295773, 0.0000, 0.0000, 337.5000);
CreateObject(3526, 3170.698730, -1237.098877, 52.693035, 0.0000, 0.0000, 337.5000);
CreateObject(3526, 3165.931396, -1241.573975, 54.802326, 0.0000, 0.0000, 337.5000);
CreateObject(3526, 3199.003174, -1203.936523, 40.739330, 0.0000, 0.0000, 337.5000);
CreateObject(3526, 3207.022461, -1196.179199, 41.150234, 0.0000, 0.0000, 337.5000);
CreateObject(3526, 3211.341309, -1185.537964, 38.974270, 0.0000, 0.0000, 337.5000);
CreateObject(987, 3225.021484, -1167.733765, 36.849255, 0.0000, 0.0000, 303.7500);
CreateObject(656, 3133.281006, -1208.088867, 36.309273, 0.0000, 0.0000, 0.0000);
CreateObject(656, 3159.708740, -1160.805664, 29.158226, 0.0000, 0.0000, 0.0000);
CreateObject(656, 3121.411133, -1149.418091, 26.056000, 0.0000, 0.0000, 0.0000);
CreateObject(656, 3116.032227, -1170.553711, 27.822598, 0.0000, 0.0000, 0.0000);
CreateObject(656, 3134.332520, -1196.940063, 33.468674, 0.0000, 0.0000, 0.0000);
CreateObject(656, 3150.359375, -1221.681885, 46.442245, 0.0000, 0.0000, 0.0000);
CreateObject(9339, 3157.704346, -1239.029907, 55.233112, 0.0000, 0.0000, 247.5000);
CreateObject(3279, 3113.662354, -1215.728394, 36.214607, 0.0000, 0.0000, 348.7500);
CreateObject(1225, 3117.587646, -1217.637329, 52.297123, 0.0000, 0.0000, 0.0000);
CreateObject(16337, 3196.511963, -1206.847290, 41.231342, 0.0000, 0.0000, 337.5001);
CreateObject(853, 3163.959717, -1185.977539, 35.453518, 347.9679, 0.0000, 0.0000);
CreateObject(16093, 3144.274170, -1067.482300, 27.507671, 0.0000, 0.0000, 326.2500);
CreateObject(16093, 3101.853760, -1142.038330, 21.012653, 0.0000, 0.0000, 78.7500);
CreateObject(1318, 3194.268799, -1173.939941, 44.152325, 0.0000, 0.0000, 22.5000);
CreateObject(1636, 3143.522217, -1191.981689, 33.275848, 325.6225, 9.4538, 308.0472);
CreateObject(1636, 3148.981934, -1191.453613, 33.692894, 292.9640, 9.4538, 308.0472);
CreateObject(1654, 3193.480957, -1173.428711, 38.810005, 0.0000, 354.8434, 308.9840);
CreateObject(2044, 3192.335449, -1172.958740, 38.334454, 0.0000, 0.0000, 303.7500);
CreateObject(2036, 3192.054932, -1172.319824, 38.192158, 0.0000, 0.0000, 303.7500);
CreateObject(2035, 3191.724854, -1172.801147, 38.250523, 0.0000, 0.0000, 303.7500);
CreateObject(2034, 3191.200928, -1172.735107, 38.201153, 0.0000, 0.0000, 303.7500);
CreateObject(2033, 3191.424316, -1172.935669, 38.213829, 0.0000, 0.0000, 315.0001);
CreateObject(2064, 3146.968506, -1181.513306, 31.734112, 0.0000, 0.0000, 157.5000);
CreateObject(2064, 3148.010010, -1182.076050, 31.829645, 0.0000, 0.0000, 157.5000);
CreateObject(2060, 3121.063477, -1185.818970, 28.058252, 0.0000, 0.0000, 0.0000);
CreateObject(2060, 3121.145020, -1185.696655, 28.373705, 0.0000, 0.0000, 0.0000);
CreateObject(2060, 3121.123047, -1185.550537, 28.689157, 0.0000, 0.0000, 0.0000);
CreateObject(2060, 3122.232422, -1186.259155, 28.250242, 0.0000, 0.0000, 348.7500);
CreateObject(2060, 3122.235840, -1186.287231, 28.565695, 0.0000, 0.0000, 348.7500);
CreateObject(2060, 3122.267578, -1186.458740, 28.881147, 0.0000, 0.0000, 348.7500);
CreateObject(2060, 3123.321777, -1186.969482, 28.414694, 0.0000, 0.0000, 315.0000);
CreateObject(2060, 3123.314453, -1187.077881, 28.730146, 0.0000, 0.0000, 315.0000);
CreateObject(2060, 3123.354492, -1187.150879, 29.045599, 0.0000, 0.0000, 315.0000);
CreateObject(2060, 3119.907959, -1186.027344, 27.837530, 0.0000, 0.0000, 45.0000);
CreateObject(2060, 3119.810547, -1186.058105, 28.152983, 0.0000, 0.0000, 45.0000);
CreateObject(2060, 3119.820313, -1186.142456, 28.468435, 0.0000, 0.0000, 45.0000);
CreateObject(3361, 3150.504639, -1139.399292, 32.184853, 13.7510, 359.1406, 206.8745);
CreateObject(3361, 3146.756592, -1142.260010, 28.920502, 13.7510, 0.0000, 210.3123);
CreateObject(16093, 3157.061279, -1129.904175, 33.107727, 0.8594, 9.4538, 113.3594);
CreateObject(2060, 3162.608398, -1169.146484, 29.592371, 0.0000, 0.0000, 123.7499);
CreateObject(2060, 3162.529297, -1169.116089, 29.907824, 0.0000, 0.0000, 303.7500);
CreateObject(2060, 3162.553711, -1168.993652, 30.223276, 0.0000, 0.0000, 303.7500);
CreateObject(2060, 3162.546875, -1168.944580, 30.538729, 0.0000, 0.0000, 303.7500);
CreateObject(2060, 3162.014404, -1168.258667, 29.453363, 0.0000, 0.0000, 270.0000);
CreateObject(2060, 3161.949707, -1168.245361, 29.768816, 0.0000, 0.0000, 270.0000);
CreateObject(2060, 3161.990967, -1168.130493, 30.084269, 0.0000, 0.0000, 270.0000);
CreateObject(2060, 3161.938477, -1168.090576, 30.399721, 0.0000, 0.0000, 270.0000);
CreateObject(2060, 3162.449219, -1167.319458, 29.318167, 0.0000, 0.0000, 45.0000);
CreateObject(2060, 3162.525391, -1167.105713, 29.633619, 0.0000, 0.0000, 225.0000);
CreateObject(2060, 3162.598877, -1166.932495, 29.949072, 0.0000, 0.0000, 225.0000);
CreateObject(2060, 3162.673828, -1166.805420, 30.264524, 0.0000, 0.0000, 225.0000);
CreateObject(2060, 3163.783203, -1169.525635, 29.862209, 0.0000, 0.0000, 348.7500);
CreateObject(2060, 3163.743408, -1169.463623, 30.177662, 0.0000, 0.0000, 348.7500);
CreateObject(2060, 3163.850830, -1169.358887, 30.493114, 0.0000, 0.0000, 348.7500);
CreateObject(2060, 3163.949219, -1169.195313, 30.808567, 0.0000, 0.0000, 348.7500);
CreateObject(2060, 3165.017090, -1169.056274, 29.953945, 0.0000, 0.0000, 33.7500);
CreateObject(2060, 3165.047607, -1168.986328, 30.269398, 0.0000, 0.0000, 33.7500);
CreateObject(2060, 3165.172119, -1168.802979, 30.584850, 0.0000, 0.0000, 45.0000);
CreateObject(2060, 3164.929932, -1168.798218, 30.900303, 0.0000, 0.0000, 33.7500);
CreateObject(2064, 3162.325439, -1181.958252, 34.295662, 359.1406, 348.8273, 339.2189);
CreateObject(3282, 3157.964111, -1219.461060, 45.362762, 3.4377, 8.5944, 357.4990);
CreateObject(2634, 3199.836426, -1113.274414, 34.341003, 0.0000, 0.0000, 22.5000);

AddStaticPickup(1242, 2, 3175.5791,-1145.4833,32.5365);
AddStaticPickup(1242, 2, 3143.4187,-1256.2340,59.4030);

        return 1;
}
//------------------------------------------------------------------------------
public OnPlayerSpawn(playerid)
{

    SetPlayerCheckpoint(playerid,3200.0686,-1114.0719,34.3727,5.0);
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
        if(killerid == INVALID_PLAYER_ID) {
        SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
        } else {
        if(gTeam[killerid] != gTeam[playerid]) {
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
}
        }
        return 1;
}
//------------------------------------------------------------------------------
public OnPlayerRequestClass(playerid, classid)
{

        SetPlayerClass(playerid, classid);
        gPlayerClass[playerid] = classid;
        ResetPlayerMoney(playerid);

        switch (classid) {
            case 0:
                {
                                GameTextForPlayer(playerid, "~n~~n~~n~~r~TERRORIST / ATTACKERS", 500, 3);

                                SetPlayerPos(playerid,3841.220703, -1936.072998, 3.049613);
                                SetPlayerFacingAngle(playerid, 20.0);
                                SetPlayerCameraPos(playerid,3840.8694,-1927.6399,6.8892);
                                SetPlayerCameraLookAt(playerid,3841.220703, -1936.072998, 3.049613);
                        }
                case 1:
                    {
                                GameTextForPlayer(playerid, "~n~~n~~n~~r~TERRORIST / ATTACKERS", 500, 3);

                                SetPlayerPos(playerid,3841.220703, -1936.072998, 3.049613);
                                SetPlayerFacingAngle(playerid, 20.0);
                                SetPlayerCameraPos(playerid,3840.8694,-1927.6399,6.8892);
                                SetPlayerCameraLookAt(playerid,3841.220703, -1936.072998, 3.049613);
                        }
        case 2:
                {
                                GameTextForPlayer(playerid, "~n~~n~~n~~r~TERRORIST / ATTACKERS", 500, 3);

                                SetPlayerPos(playerid,3841.220703, -1936.072998, 3.049613);
                                SetPlayerFacingAngle(playerid, 20.0);
                                SetPlayerCameraPos(playerid,3840.8694,-1927.6399,6.8892);
                                SetPlayerCameraLookAt(playerid,3841.220703, -1936.072998, 3.049613);
                        }
        case 3:
                {
                                GameTextForPlayer(playerid, "~n~~n~~n~~r~TERRORIST / ATTACKERS", 500, 3);

                                SetPlayerPos(playerid,3841.220703, -1936.072998, 3.049613);
                                SetPlayerFacingAngle(playerid, 20.0);
                                SetPlayerCameraPos(playerid,3840.8694,-1927.6399,6.8892);
                                SetPlayerCameraLookAt(playerid,3841.220703, -1936.072998, 3.049613);
                        }
        case 4:
                {
                                GameTextForPlayer(playerid, "~n~~n~~n~~b~COUNTER-TERRORIST / DEFENCE", 500, 3);

                                SetPlayerPos(playerid,3742.5508, -1650.1516, 8.9869);
                                SetPlayerFacingAngle(playerid, 0.0);
                                SetPlayerCameraPos(playerid,3743.0801,-1640.6072,10.5810);
                                SetPlayerCameraLookAt(playerid,3742.5508, -1650.1516, 8.9869);
                        }
        case 5:
                {
                                GameTextForPlayer(playerid, "~n~~n~~n~~b~COUNTER-TERRORIST / DEFENCE", 500, 3);

                                SetPlayerPos(playerid,3742.5508, -1650.1516, 8.9869);
                                SetPlayerFacingAngle(playerid, 0.0);
                                SetPlayerCameraPos(playerid,3743.0801,-1640.6072,10.5810);
                                SetPlayerCameraLookAt(playerid,3742.5508, -1650.1516, 8.9869);
                        }
        case 6:
                {
                                GameTextForPlayer(playerid, "~n~~n~~n~~b~COUNTER-TERRORIST / DEFENCE", 500, 3);

                                SetPlayerPos(playerid,3742.5508, -1650.1516, 8.9869);
                                SetPlayerFacingAngle(playerid, 0.0);
                                SetPlayerCameraPos(playerid,3743.0801,-1640.6072,10.5810);
                                SetPlayerCameraLookAt(playerid,3742.5508, -1650.1516, 8.9869);
                        }
        case 7:
                {
                                GameTextForPlayer(playerid, "~n~~n~~n~~b~COUNTER-TERRORIST / DEFENCE", 500, 3);

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
        SendPlayerFormattedText(playerid,"<> Help: Terrorist are the red dots and the counter-terrorist are the blue dots.",0);
    SendPlayerFormattedText(playerid,"<> Help: Type /commands for all the commands available.",0);
        return 1;
        }

        if(strcmp(cmd, "/commands", true, 9) == 0) {
        SendPlayerFormattedText(playerid,"<> Commands: /me command.",0);
        SendPlayerFormattedText(playerid,"<> Commands: Type '!' followed by your message for team chat.",0);
        SendPlayerFormattedText(playerid,"<> Commands: Terrorists type /plant to plant the bomb.",0);
        SendPlayerFormattedText(playerid,"<> Commands: Counter-Terrorists use /defuse to defuse the bomb.",0);
        SendPlayerFormattedText(playerid,"<> Commands: Type /terrorist-help for all Terrorists objectives.",0);
        SendPlayerFormattedText(playerid,"<> Commands: Type /counter-terrorist-help for all Counter Terrorists objectives.",0);
        return 1;
        }

        if(strcmp(cmd, "/objective-t", true, 12) == 0) {
        SendPlayerFormattedText(playerid,"<> Terrorists objective is to plant the bomb or kill all Counter terrorists within the time limit.",0);
        SendPlayerFormattedText(playerid,"<> Don't allow Counter terrorists to defuse the bomb.",0);
        return 1;
        }

        if(strcmp(cmd, "/objective-ct", true, 13) == 0) {
        SendPlayerFormattedText(playerid,"<> Counter Terrorists objective is to kill all Terrorists and if they plant the bomb, defuse the bomb before it goes BOOM!",0);
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
            SetTimer("Counter", 1001, 1);
            Count = 30;
            TextDrawDestroy(Text:C);
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
            GameTextForAll("The bomb has been defused!", 3000, 5);
            GameTextForAll("~w~ The round is over, ~b~Counter Terrorists ~w~win!", 3000, 5);
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

    if (DMTime == 0)
    {
        for( new playerid = 0; playerid < MAX_PLAYERS; playerid ++ )
        {
        TogglePlayerControllable(playerid, 0);
        }
        GameTextForAll("Terrorists ran out of time!", 3000, 5);
        GameTextForAll("~w~ The round is over, ~b~Counter Terrorists ~w~win!", 3000, 5);
        SetTimer("ExitTheGameMode", 8000, 0);
   }
    return 1;
}
//------------------------------------------------------------------------------
public Counter()
{
    Count --;
    new tmp[256];
    TextDrawDestroy(Text:C);
    format(tmp, sizeof tmp, "Bomb will blow in : %s", TimeConvert(Count));

        C = TextDrawCreate(220.0, 310.0, tmp);
        TextDrawSetShadow(Text:C, 0);
        TextDrawSetOutline(Text:C, 1);
        TextDrawShowForAll(Text:C);

        if (Defused)
        {
     TextDrawDestroy(Text:C);
     SetTimer("ExitTheGameMode", 8000, 0);
        }
        else if (Count == 0)
    {
        for( new playerid = 0; playerid < MAX_PLAYERS; playerid ++ )
        {
        TogglePlayerControllable(playerid, 0);
        }

        GameTextForAll("The bomb has blown up!", 3000, 5);
        CreateExplosion(3200.0686,-1114.0719,34.3727,10,200000000.0);
        CreateExplosion(3200.0686,-1114.0719,34.3727,10,200000000.0);
        CreateExplosion(3200.0686,-1114.0719,34.3727,10,200000000.0);
		CreateExplosion(3200.0686,-1114.0719,34.3727,10,200000000.0);
        CreateExplosion(3200.0686,-1114.0719,34.3727,10,200000000.0);
        GameTextForAll("~w~ The round is over, ~r~Terrorists ~w~win!", 3000, 5);
                Count = 1;
        SetTimer("ExitTheGameMode", 8000, 0);
    }
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
        SetPlayerColor(playerid, COLOR_GREY); // Set the player's color to inactive
        new string[85],pname[24];
        GetPlayerName(playerid,pname,24);
        format(string,sizeof(string),"*** %s has joined the server. (ID:%d)",pname,playerid);
        SendClientMessageToAll(COLOR_CON_GREEN,string);
        SendPlayerFormattedText(playerid,"<> Welcome To The Abandoned Island Counter-Strike Mode By S1k",0);
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
public ExitTheGameMode()
{
    GameModeExit();
}
//------------------------------------------------------------------------------

