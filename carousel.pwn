////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////               - chain carousel -               ///////////////////////////////////////////////////////////
/////////////////////////////////////////////////                 - by [AW]Tom -                 ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include <a_samp>

new tmpobjid;
new chair1;
new chair2;
new chair3;
new chair4;
new chair5;
new chair6;
new chair7;
new chair8;
new pill1;
new pill2;
new pill3;
new pill4;
new pill5;
new pill6;
new pill7;
new pill8;
new ball;
new beam1;
new beam2;
new beam3;
new beam4;
new beam5;
new beam6;
new beam7;
new beam8;

forward rot();
new rot1;
new moving = 0;

public OnFilterScriptInit()
{
chair1 = CreateObject(945,398.246,-2072.635,14.845,0.000,0.000,0.000,300.000);//chair1
SetObjectMaterial(chair1, 0, 3922, "bistro", "sw_wallbrick_01", 51);
SetObjectMaterial(chair1, 1, -1, "none", "none", 51);
SetObjectMaterial(chair1, 2, -1, "none", "none", -65536);
SetObjectMaterial(chair1, 3, 19054, "XmasBoxes", "wrappingpaper1", -256);
tmpobjid = CreateObject(3440,394.286+0.01,-2072.632+0.01,9.204+3,0.000,0.000,0.000,300.000);
SetObjectMaterial(tmpobjid, 0, 3961, "lee_kitch", "metal6", -65536);
tmpobjid = CreateObject(3440,394.286,-2072.632,9.204,0.000,0.000,0.000,300.000);
SetObjectMaterial(tmpobjid, 0, 3961, "lee_kitch", "metal6", -65536);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.222,0.000,90.000,0.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.229,0.000,90.000,90.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.239,0.000,90.000,135.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.232,0.000,90.000,45.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.250,0.000,90.000,-42.999,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.241,0.000,90.000,-132.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.260,0.000,90.000,-40.999,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.251,0.000,90.000,-130.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.270,0.000,90.000,-38.999,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.262,0.000,90.000,-128.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.279,0.000,90.000,-178.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.272,0.000,90.000,91.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.288,0.000,90.000,-176.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.281,0.000,90.000,93.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.300,0.000,90.000,-174.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.291,0.000,90.000,95.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.310,0.000,90.000,-172.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.302,0.000,90.000,97.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.451,0.000,90.000,0.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.460,0.000,90.000,90.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.470,0.000,90.000,135.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.461,0.000,90.000,45.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.479,0.000,90.000,-42.999,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.472,0.000,90.000,-132.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.489,0.000,90.000,-40.999,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.482,0.000,90.000,-130.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.500,0.000,90.000,-38.999,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.491,0.000,90.000,-128.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.510,0.000,90.000,-178.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.501,0.000,90.000,91.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.520,0.000,90.000,-176.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.512,0.000,90.000,93.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.529,0.000,90.000,-174.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.522,0.000,90.000,95.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.538,0.000,90.000,-172.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.531,0.000,90.000,97.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.692,0.000,90.000,0.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.699,0.000,90.000,90.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.710,0.000,90.000,135.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.701,0.000,90.000,45.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.720,0.000,90.000,-42.999,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.711,0.000,90.000,-132.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.729,0.000,90.000,-40.999,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.722,0.000,90.000,-130.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.739,0.000,90.000,-38.999,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.732,0.000,90.000,-128.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.750,0.000,90.000,-178.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.741,0.000,90.000,91.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.760,0.000,90.000,-176.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.751,0.000,90.000,93.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.770,0.000,90.000,-174.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.762,0.000,90.000,95.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.779,0.000,90.000,-172.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.772,0.000,90.000,97.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.932,0.000,90.000,0.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.939,0.000,90.000,90.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.949,0.000,90.000,135.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.942,0.000,90.000,45.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.960,0.000,90.000,-42.999,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.951,0.000,90.000,-132.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.970,0.000,90.000,-40.999,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.961,0.000,90.000,-130.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.979,0.000,90.000,-38.999,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.972,0.000,90.000,-128.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.989,0.000,90.000,-178.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.982,0.000,90.000,91.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.000,0.000,90.000,-176.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,14.991,0.000,90.000,93.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.010,0.000,90.000,-174.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.001,0.000,90.000,95.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.020,0.000,90.000,-172.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.012,0.000,90.000,97.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.170,0.000,90.000,0.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.180,0.000,90.000,90.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.189,0.000,90.000,135.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.182,0.000,90.000,45.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.199,0.000,90.000,-42.999,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.192,0.000,90.000,-132.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.210,0.000,90.000,-40.999,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.201,0.000,90.000,-130.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.220,0.000,90.000,-38.999,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.211,0.000,90.000,-128.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.229,0.000,90.000,-178.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.222,0.000,90.000,91.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.239,0.000,90.000,-176.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.232,0.000,90.000,93.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.250,0.000,90.000,-174.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.241,0.000,90.000,95.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.260,0.000,90.000,-172.998,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
tmpobjid = CreateObject(19454,394.316,-2072.645,15.251,0.000,90.000,97.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -5570646);
beam1 = CreateObject(2960,396.596,-2072.612,13.786,180.000,0.000,0.000,300.000);//beam1
SetObjectMaterial(beam1, 0, -1, "none", "none", -16737793);
beam2 = CreateObject(2960,391.976,-2072.612,13.786,180.000,0.000,0.000,300.000);//beam2
SetObjectMaterial(beam2, 0, -1, "none", "none", -16737793);
chair2 = CreateObject(945,390.246,-2072.635,14.845,0.000,0.000,0.000,300.000);//chair2
SetObjectMaterial(chair2, 0, 3922, "bistro", "sw_wallbrick_01", 51);
SetObjectMaterial(chair2, 1, -1, "none", "none", 51);
SetObjectMaterial(chair2, 2, -1, "none", "none", -65536);
SetObjectMaterial(chair2, 3, 3967, "cj_airprt", "gun_ceiling3", -256);
SetObjectMaterial(chair2, 12, 3922, "bistro", "Tablecloth", 0);
chair3 = CreateObject(945,394.256,-2068.623,14.845,0.000,0.000,90.000,300.000);//chair3
SetObjectMaterial(chair3, 0, 3922, "bistro", "sw_wallbrick_01", 51);
SetObjectMaterial(chair3, 1, -1, "none", "none", 51);
SetObjectMaterial(chair3, 2, -1, "none", "none", -256);
SetObjectMaterial(chair3, 3, 7489, "vgntamotel", "vgncoctart1_256", -1);
chair4 = CreateObject(945,394.256,-2076.623,14.845,0.000,0.000,90.000,300.000);//chair4
SetObjectMaterial(chair4, 0, 3922, "bistro", "sw_wallbrick_01", 51);
SetObjectMaterial(chair4, 1, -1, "none", "none", 51);
SetObjectMaterial(chair4, 2, -1, "none", "none", -256);
SetObjectMaterial(chair4, 3, 19054, "XmasBoxes", "wrappingpaper16", -21846);
beam3 = CreateObject(2960,394.234,-2070.270,13.786,0.000,-180.000,-89.999,300.000);//beam3
SetObjectMaterial(beam3, 0, -1, "none", "none", -16737793);
beam4 = CreateObject(2960,394.234,-2074.891,13.786,0.000,-180.000,-89.999,300.000);//beam4
SetObjectMaterial(beam4, 0, -1, "none", "none", -16737793);
chair5 = CreateObject(945,391.424,-2069.787,14.845,0.000,0.000,135.000,300.000);//chair5
SetObjectMaterial(chair5, 0, 3922, "bistro", "sw_wallbrick_01", 51);
SetObjectMaterial(chair5, 1, -1, "none", "none", 51);
SetObjectMaterial(chair5, 2, -1, "none", "none", -16733441);
SetObjectMaterial(chair5, 3, 18845, "MickyTextures", "ws_gayflag1", -268369921);
chair6 = CreateObject(945,397.082,-2075.443,14.845,0.000,0.000,135.000,300.000);//chair6
SetObjectMaterial(chair6, 0, 3922, "bistro", "sw_wallbrick_01", 51);
SetObjectMaterial(chair6, 1, -1, "none", "none", 51);
SetObjectMaterial(chair6, 2, -1, "none", "none", -16733441);
SetObjectMaterial(chair6, 3, 14739, "whorebits", "AH_cheapbarpan", -256);
beam5 = CreateObject(2960,392.575,-2070.968,13.786,0.000,-180.000,-44.999,300.000);//beam5
SetObjectMaterial(beam5, 0, -1, "none", "none", -16737793);
beam6 = CreateObject(2960,395.841,-2074.235,13.786,0.000,-180.000,-44.999,300.000);//beam6
SetObjectMaterial(beam6, 0, -1, "none", "none", -16737793);
chair7 = CreateObject(945,391.415,-2075.447,14.845,0.000,0.000,-135.000,300.000);//chair7
SetObjectMaterial(chair7, 0, 3922, "bistro", "sw_wallbrick_01", 51);
SetObjectMaterial(chair7, 1, -1, "none", "none", 51);
SetObjectMaterial(chair7, 2, -1, "none", "none", -16711936);
SetObjectMaterial(chair7, 3, 2635, "pizza_furn", "CJ_TART_TABLE", -65536);
chair8 = CreateObject(945,397.074,-2069.790,14.845,0.000,0.000,45.000,300.000);//chair8
SetObjectMaterial(chair8, 0, -1, "none", "none", 51);
SetObjectMaterial(chair8, 1, -1, "none", "none", 51);
SetObjectMaterial(chair8, 2, -1, "none", "none", -16711936);
SetObjectMaterial(chair8, 3, 19054, "XmasBoxes", "wrappingpaper28", -256);
beam7 = CreateObject(2960,392.596,-2074.298,13.786,0.000,-180.000,45.000,300.000);//beam7
SetObjectMaterial(beam7, 0, -1, "none", "none", -16737793);
beam8 = CreateObject(2960,395.864,-2071.031,13.786,0.000,-180.000,45.000,300.000);//beam8
SetObjectMaterial(beam8, 0, -1, "none", "none", -16737793);
tmpobjid = CreateObject(19477,394.278,-2067.843,13.536,6.000,0.000,90.000,300.000);
SetObjectMaterial(tmpobjid, 0, 14865, "gf2", "mp_bobbie_pennant", 0);
tmpobjid = CreateObject(19477,397.428,-2069.052,13.560,6.000,0.000,45.000,300.000);
SetObjectMaterial(tmpobjid, 0, 14865, "gf2", "mp_bobbie_pennant", 0);
tmpobjid = CreateObject(3054,394.295,-2072.614,7.059,0.000,0.000,0.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -2236963);
SetObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "ws_whiteplaster_btm", 0);
ball = CreateObject(3054,394.295,-2072.614,13.500,180.000,0.000,0.000,300.000);///////////ball
SetObjectMaterial(ball, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", -2236963);
SetObjectMaterial(ball, 1, 10765, "airportgnd_sfse", "ws_runwaytarmac", -13369549);
tmpobjid = CreateObject(19477,390.894,-2069.427,13.604,6.697,0.000,-45.000,300.000);
SetObjectMaterial(tmpobjid, 0, 14865, "gf2", "mp_bobbie_pennant", 0);
tmpobjid = CreateObject(19477,389.502,-2072.781,13.543,6.000,0.000,1.598,300.000);
SetObjectMaterial(tmpobjid, 0, 14865, "gf2", "mp_bobbie_pennant", 0);
tmpobjid = CreateObject(19477,390.980,-2076.083,13.562,6.000,0.000,48.000,300.000);
SetObjectMaterial(tmpobjid, 0, 14865, "gf2", "mp_bobbie_pennant", 0);
tmpobjid = CreateObject(19477,399.088,-2072.531,13.571,6.000,0.000,1.000,300.000);
SetObjectMaterial(tmpobjid, 0, 14865, "gf2", "mp_bobbie_pennant", 0);
tmpobjid = CreateObject(19477,394.548,-2077.350,13.536,6.000,0.000,93.000,300.000);
SetObjectMaterial(tmpobjid, 0, 14865, "gf2", "mp_bobbie_pennant", 0);
tmpobjid = CreateObject(19477,397.997,-2075.735,13.576,6.000,0.000,-42.000,300.000);
SetObjectMaterial(tmpobjid, 0, 14865, "gf2", "mp_bobbie_pennant", 0);
tmpobjid = CreateObject(11431,404.113,-2058.375,8.204,0.000,0.000,90.000,300.000);
SetObjectMaterial(tmpobjid, 0, -1, "none", "none", -2228293);
SetObjectMaterial(tmpobjid, 1, -1, "none", "none", -256);
SetObjectMaterial(tmpobjid, 3, -1, "none", "none", -39322);
SetObjectMaterial(tmpobjid, 4, -1, "none", "none", -39322);
tmpobjid = CreateObject(2599,401.789,-2059.625,7.275,0.000,0.000,255.000,300.000);
SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_yellowline", 0);
SetObjectMaterial(tmpobjid, 1, 16640, "a51", "ws_metalpanel1", -11162966);
SetObjectMaterial(tmpobjid, 2, 3922, "bistro", "Tablecloth", 0);
tmpobjid = CreateObject(19477,401.239,-2060.739,7.004,0.000,-17.000,165.000,300.000);
SetObjectMaterial(tmpobjid, 0, 3922, "bistro", "StainedGlass", 0);
SetObjectMaterialText(tmpobjid, "BUY ", 0, 130, "Calibri", 50, 1, -65536, 0, 0);
tmpobjid = CreateObject(19477,401.196,-2060.624,6.793,0.000,-18.000,165.000,300.000);
SetObjectMaterialText(tmpobjid, "TICKETS ", 0, 130, "Calibri", 40, 1, -65536, 0, 0);
tmpobjid = CreateObject(19477,401.131,-2060.656,6.592,0.000,-17.000,165.000,300.000);
SetObjectMaterialText(tmpobjid, "HERE ", 0, 130, "Calibri", 50, 1, -65536, 0, 0);
tmpobjid = CreateObject(11435,402.906,-2058.010,8.817,0.000,0.000,79.500,300.000);
SetObjectMaterial(tmpobjid, 0, -1, "none", "none", 51);
SetObjectMaterial(tmpobjid, 2, 3967, "cj_airprt", "Road_blank256HV", -3342592);
tmpobjid = CreateObject(19477,402.647,-2058.479,10.840,0.000,0.000,169.000,300.000);
SetObjectMaterialText(tmpobjid, "! Tickets ! ", 0, 90, "Calibri", 110, 1, -2293760, 0, 1);
pill1 = CreateObject(2004,393.894,-2068.616,7.546+0.1,-90.000,0.000,0.000,300.000);//pill1
SetObjectMaterial(pill1, 0, 2707, "Shopping", "white", 51);
SetObjectMaterial(pill1, 1, -1, "none", "none", 51);
pill2 = CreateObject(2004,393.894,-2076.616,7.546+0.1,-90.000,0.000,0.000,300.000);//pill2
SetObjectMaterial(pill2, 0, 2707, "Shopping", "white", 51);
SetObjectMaterial(pill2, 1, -1, "none", "none", 51);
pill3 = CreateObject(2004,398.347,-2073.000,7.546+0.1,-90.000,-135.000,314.997,300.000);//pill3
SetObjectMaterial(pill3, 0, 2707, "Shopping", "white", 51);
SetObjectMaterial(pill3, 1, -1, "none", "none", 51);
pill4 = CreateObject(2004,389.894,-2072.616,7.546+0.1,-90.000,0.000,0.000,300.000);//pill4
SetObjectMaterial(pill4, 0, 2707, "Shopping", "white", 51);
SetObjectMaterial(pill4, 1, -1, "none", "none", 51);
pill5 = CreateObject(2004,391.092,-2070.115,7.546+0.1,-90.000,0.000,45.000,300.000);//pill5
SetObjectMaterial(pill5, 0, 2707, "Shopping", "white", 51);
SetObjectMaterial(pill5, 1, -1, "none", "none", 51);
pill6 = CreateObject(2004,396.808,-2069.475,7.546+0.1,-90.000,-135.000,179.998,300.000);//pill6
SetObjectMaterial(pill6, 0, 2707, "Shopping", "white", 51);
SetObjectMaterial(pill6, 1, -1, "none", "none", 51);
pill7 = CreateObject(2004,396.808,-2075.132,7.546+0.1,-90.000,-135.000,179.998,300.000);//pill7
SetObjectMaterial(pill7, 0, 2707, "Shopping", "white", 51);
SetObjectMaterial(pill7, 1, -1, "none", "none", 51);
pill8 = CreateObject(2004,391.152,-2075.132,7.546+0.1,-90.000,-135.000,179.998,300.000);//pill8
SetObjectMaterial(pill8, 0, 2707, "Shopping", "white", 51);
SetObjectMaterial(pill8, 1, -1, "none", "none", 51);
tmpobjid = CreateObject(7313,404.285,-2061.160,8.255,0.000,0.000,0.000,300.000);
SetObjectMaterial(tmpobjid, 0, 19054, "XmasBoxes", "silk9-128x128", 0);
tmpobjid = CreateObject(19477,406.256,-2061.211,8.765,0.000,0.000,270.000,300.000);
SetObjectMaterialText(tmpobjid, "By [AW]Tom ", 0, 90, "Calibri", 50, 1, -65536, 0, 1);


////////////////////////////attach/////////////////////////
//					attach pills to chairs				//
AttachObjectToObject(pill1, chair1, -0.5, 0, -7.25, 90, 0, 0, 1);
AttachObjectToObject(pill2, chair2, -0.5, 0, -7.25, 90, 0, 0, 1);
AttachObjectToObject(pill3, chair3, -0.5, 0, -7.25, 90, 0, 0, 1);
AttachObjectToObject(pill4, chair4, -0.5, 0, -7.25, 90, 0, 0, 1);
AttachObjectToObject(pill5, chair5, -0.5, 0, -7.25, 90, 0, 0, 1);
AttachObjectToObject(pill6, chair6, -0.5, 0, -7.25, 90, 0, 0, 1);
AttachObjectToObject(pill7, chair7, -0.5, 0, -7.25, 90, 0, 0, 1);
AttachObjectToObject(pill8, chair8, -0.5, 0, -7.25, 90, 0, 0, 1);
//                  attach beams to ball            //
AttachObjectToObject(beam1, ball, 2.301, 0, -0.286, 0, 0, 0, 1);
AttachObjectToObject(beam2, ball, -2.319, 0, -0.286, 0, 0, 1);
AttachObjectToObject(beam3, ball, -0.061, 2.344, -0.286, -180, -180, -90, 1);
AttachObjectToObject(beam4, ball, -0.061, -2.277, -0.286, -180, -180, -90, 1);
AttachObjectToObject(beam5, ball, -1.72, 1.646, -0.286, -180, -180, -45, 1);
AttachObjectToObject(beam6, ball, 1.546, -1.621, -0.286, -180, -180, -45, 1);
AttachObjectToObject(beam7, ball, -1.699, -1.684, -0.286, -180, -180, 45, 1);
AttachObjectToObject(beam8, ball, 1.569, 1.583, -0.286, -180, -180, 45, 1);
//                  attach chairs to ball          //
AttachObjectToObject(chair1, ball, 3.951, -0.021, -1.345, 0, 0, 0, 1);
AttachObjectToObject(chair2, ball, -4.049, -0.021, -1.345, 0, 0, 0, 1);
AttachObjectToObject(chair3, ball, -0.039, 3.991, -1.345, 0, 0, 90, 1);
AttachObjectToObject(chair4, ball, -0.039, -4.009, -1.345, 0, 0, 90, 1);
AttachObjectToObject(chair5, ball, -2.871, 2.827, -1.345, 0, 0, 135, 1);
AttachObjectToObject(chair6, ball, 2.787, -2.829, -1.345, 0, 0, 135, 1);
AttachObjectToObject(chair7, ball, -2.880, -2.833, -1.345, 0, 0, -135, 1);
AttachObjectToObject(chair8, ball, 2.779, 2.824, -1.345, 0, 0, 45, 1);
}


public OnPlayerSpawn(playerid)
{
    //remove           buildings
	RemoveBuildingForPlayer(playerid, 6283, 6966, -2063.4543, 7.8359, 10000.0);
	RemoveBuildingForPlayer(playerid, 6464, 6966, -2063.4543, 7.8359, 10000.0);
	RemoveBuildingForPlayer(playerid, 1529, 6966, -2063.4543, 7.8359, 10000.0);
	RemoveBuildingForPlayer(playerid, 1215, 6966, -2063.4543, 7.8359, 10000.0);
	RemoveBuildingForPlayer(playerid, 1340, 6966, -2063.4543, 7.8359, 10000.0);
	RemoveBuildingForPlayer(playerid, 1280, 6966, -2063.4543, 7.8359, 10000.0);
	RemoveBuildingForPlayer(playerid, 1308, 6966, -2063.4543, 7.8359, 10000.0);
	RemoveBuildingForPlayer(playerid, 1232, 6966, -2063.4543, 7.8359, 10000.0);
	GivePlayerWeapon(playerid, 24, 1000);
	GivePlayerWeapon(playerid, 25, 1000);
	GivePlayerWeapon(playerid, 34, 1000);
	GivePlayerWeapon(playerid, 31, 1000);
    return 1;
}

public rot()
{
    new Float:rotx, Float:roty, Float:rotz;
	GetObjectRot(ball, rotx, roty, rotz);

	new Float:X = 394.295, Float:Y = -2072.614, Float:Z = 13.500, Float:Speed= 4.0000;
	MoveObject(ball, X , Y , Z , Speed , rotx , roty , rotz + 0.35);
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp      (cmdtext, "/c", true) == 0)
	{
		SetPlayerPos(playerid, 370.1657, -2044.4690, 7.6719);
		return 1;
	}
	if(strcmp      (cmdtext, "/cstart", true) == 0)
	{
	    if(moving == 0)
	    {
			rot1 = SetTimer("rot", 1, true);
			moving = 1;
			return 1;
		}
	}
	if(strcmp      (cmdtext, "/cstop", true) == 0)
	{
		if(moving == 1)
	    {
			KillTimer(rot1);
			moving = 0;
			return 1;
		}
	}
    return 1;
}
