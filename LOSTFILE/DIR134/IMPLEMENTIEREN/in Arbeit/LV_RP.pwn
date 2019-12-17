#include <a_samp>
#include <dini>
#include <dudb>

#define HIV 1
#define AIDS 2
#define HERP 3
#define CRAB 4

#define dcmd(%1,%2,%3) if ((strcmp(%3, "/%1", true, %2+1) == 0)&&(((%3[%2+1]==0)&&(dcmd_%1(playerid,"")))||((%3[%2+1]==32)&&(dcmd_%1(playerid,%3[%2+2]))))) return 1

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x00FF00AA
#define COLOR_RED 0xFF0000AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_TAN 0xBDB76BAA
#define COLOR_PURPLE 0x800080AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_INVISWHITE 0xFFFFFF00
#define COLOR_LIGHTBLUE 0x1C86EEAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_ORANGE 0xFF9900AA

enum Info
{
	Age,
	Disease,
	Speed,
	Logged,
	KickP,
	ALevel
}
new pInfo[MAX_PLAYERS][Info];
new kicker;
main()
{
	print("\n\n   ::   ::            ::   ::");
	print("---------------------------------");
	print("   ----- Las Venturas RP -----");
	print("---------------------------------");
	print("   ::   ::            ::   ::\n\n");
}

stock Float:D(p1,p2)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	if (!IsPlayerConnected(p1) || !IsPlayerConnected(p2)) return -1.00;
	GetPlayerPos(p1,x1,y1,z1);
	GetPlayerPos(p2,x2,y2,z2);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

public OnGameModeInit()
{
	SetGameModeText("Las Venturas RP");

	SetTimer("AgeCheck",1800000,1);
	SetTimer("DiseaseCheck",15000,1);

	AddPlayerClass(1,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(2,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(47,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(48,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(49,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(50,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(51,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(52,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(53,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(54,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(55,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(56,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(57,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(58,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(59,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(60,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(61,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(62,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(63,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(64,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(66,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(67,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(68,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(69,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(70,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(71,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(72,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(73,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(75,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(76,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(78,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(79,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(80,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(81,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(82,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(83,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(84,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(85,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(87,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(88,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(89,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(91,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(92,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(93,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(95,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(96,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(97,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(98,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(99,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(100,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(101,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(102,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(103,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(104,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(105,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(106,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(107,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(108,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(109,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(110,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(111,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(112,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(113,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(114,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(115,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(116,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(117,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(118,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(120,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(121,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(122,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(123,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(124,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(125,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(126,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(127,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(128,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(129,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(131,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(133,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(134,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(135,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(136,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(137,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(138,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(139,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(140,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(141,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(142,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(143,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(144,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(145,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(146,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(147,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(148,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(150,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(151,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(152,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(153,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(154,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(155,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(156,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(157,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(158,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(159,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(160,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(161,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(162,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(163,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(164,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(165,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(166,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(167,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(168,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(169,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(170,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(171,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(172,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(173,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(174,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(175,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(176,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(177,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(178,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(179,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(180,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(181,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(182,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(183,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(184,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(185,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(186,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(187,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(188,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(189,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(190,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(191,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(192,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(193,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(194,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(195,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(196,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(197,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(198,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(199,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(200,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(201,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(202,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(203,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(204,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(205,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(206,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(207,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(209,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(210,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(211,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(212,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(213,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(214,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(215,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(216,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(217,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(218,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(219,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(220,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(221,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(222,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(223,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(224,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(225,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(226,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(227,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(228,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(229,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(230,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(231,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(232,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(233,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(234,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(235,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(236,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(237,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(238,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(239,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(240,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(241,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(242,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(243,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(244,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(245,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(246,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(247,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(248,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(249,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(250,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(251,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	AddPlayerClass(253,1680.0479,1447.4169,10.7739,269.8138,0,0,0,0,-1,-1);
	
	
	AddStaticVehicle(411,1938.6960,724.8140,10.5474,0.0000,123,1); //
	AddStaticVehicle(516,2153.8833,694.5912,10.6552,359.2178,119,1); //
	AddStaticVehicle(567,2442.7288,707.6910,11.1052,270.6363,88,64); //
	AddStaticVehicle(602,2514.3452,936.7757,10.6301,358.8408,69,1); //
	AddStaticVehicle(466,2462.4609,1019.5401,10.5610,89.6870,68,76); //
	AddStaticVehicle(405,2568.4561,1060.2512,10.6953,357.5957,24,1); //
	AddStaticVehicle(461,2572.9543,1239.2457,10.4063,0.5796,37,1); //
	AddStaticVehicle(436,2551.9146,1368.1577,10.5327,267.7091,87,1); //
	AddStaticVehicle(445,2433.5696,1564.4210,10.6955,0.0188,35,35); //
	AddStaticVehicle(410,2462.7449,1676.9330,10.4716,359.1939,9,1); //
	AddStaticVehicle(451,2543.2505,1966.8324,10.5273,269.8746,125,125); //
	AddStaticVehicle(400,2597.5593,2040.1541,10.9118,88.1217,123,1); //
	AddStaticVehicle(401,2595.6599,2148.7776,10.6008,359.5425,47,47); //
	AddStaticVehicle(402,2389.3538,2153.6570,10.5036,90.6956,13,13); //
	AddStaticVehicle(426,2339.8359,1951.0985,10.4209,179.7997,42,42); //
	AddStaticVehicle(415,2240.0151,2235.6265,10.5669,269.3337,25,1); //
	AddStaticVehicle(451,2040.0520,1319.2799,10.3779,183.2439,-1,-1);
	AddStaticVehicle(429,2040.5247,1359.2783,10.3516,177.1306,-1,-1);
	AddStaticVehicle(437,2110.4102,1398.3672,10.7552,359.5964,-1,-1);
	AddStaticVehicle(409,2074.9624,1479.2120,10.3990,359.6861,-1,-1);
	AddStaticVehicle(477,2075.6038,1666.9750,10.4252,359.7507,-1,-1);
	AddStaticVehicle(541,2119.5845,1938.5969,10.2967,181.9064,-1,-1);
	AddStaticVehicle(541,1843.7881,1216.0122,10.4556,270.8793,-1,-1);
	AddStaticVehicle(402,1944.1003,1344.7717,8.9411,0.8168,-1,-1);
	AddStaticVehicle(402,1679.2278,1316.6287,10.6520,180.4150,-1,-1);
	AddStaticVehicle(415,1685.4872,1751.9667,10.5990,268.1183,-1,-1);
	AddStaticVehicle(402,2034.5016,1912.5874,11.9048,0.2909,-1,-1);
	AddStaticVehicle(463,2172.1682,1988.8643,10.5474,89.9151,-1,-1);
	AddStaticVehicle(429,2245.5759,2042.4166,10.5000,270.7350,-1,-1);
	AddStaticVehicle(477,2361.1538,1993.9761,10.4260,178.3929,-1,-1);
	AddStaticVehicle(558,2243.3833,1952.4221,14.9761,359.4796,-1,-1);
	AddStaticVehicle(587,2276.7085,1938.7263,31.5046,359.2321,-1,-1);
	AddStaticVehicle(587,2602.7769,1853.0667,10.5468,91.4813,-1,-1);
	AddStaticVehicle(603,2610.7600,1694.2588,10.6585,89.3303,-1,-1);
	AddStaticVehicle(587,2635.2419,1075.7726,10.5472,89.9571,-1,-1);
	AddStaticVehicle(562,2577.2354,1038.8063,10.4777,181.7069,-1,-1);
	AddStaticVehicle(562,2394.1021,989.4888,10.4806,89.5080,-1,-1);
	AddStaticVehicle(510,1881.0510,957.2120,10.4789,270.4388,-1,-1);
	AddStaticVehicle(535,2039.1257,1545.0879,10.3481,359.6690,-1,-1);
	AddStaticVehicle(535,2009.8782,2411.7524,10.5828,178.9618,-1,-1);
	AddStaticVehicle(429,2010.0841,2489.5510,10.5003,268.7720,-1,-1);
	AddStaticVehicle(415,2076.4033,2468.7947,10.5923,359.9186,-1,-1);
	AddStaticVehicle(487,2093.2754,2414.9421,74.7556,89.0247,-1,-1);
	AddStaticVehicle(506,2352.9026,2577.9768,10.5201,0.4091,-1,-1);
	AddStaticVehicle(506,2166.6963,2741.0413,10.5245,89.7816,-1,-1);
	AddStaticVehicle(409,1960.9989,2754.9072,10.5473,200.4316,-1,-1);
	AddStaticVehicle(429,1919.5863,2760.7595,10.5079,100.0753,-1,-1);
	AddStaticVehicle(415,1673.8038,2693.8044,10.5912,359.7903,-1,-1);
	AddStaticVehicle(402,1591.0482,2746.3982,10.6519,172.5125,-1,-1);
	AddStaticVehicle(603,1580.4537,2838.2886,10.6614,181.4573,-1,-1);
	AddStaticVehicle(535,1455.9305,2878.5288,10.5837,181.0987,-1,-1);
	AddStaticVehicle(477,1537.8425,2578.0525,10.5662,0.0650,-1,-1);
	AddStaticVehicle(451,1433.1594,2607.3762,10.3781,88.0013,-1,-1);
	AddStaticVehicle(603,2223.5898,1288.1464,10.5104,182.0297,-1,-1);
	AddStaticVehicle(558,2451.6707,1207.1179,10.4510,179.8960,-1,-1);
	AddStaticVehicle(558,2461.8162,1629.2268,10.4496,181.4625,-1,-1);
	AddStaticVehicle(477,2395.7554,1658.9591,10.5740,359.7374,-1,-1);
	AddStaticVehicle(477,1553.3696,1020.2884,10.5532,270.6825,-1,-1);
	AddStaticVehicle(400,1380.8304,1159.1782,10.9128,355.7117,-1,-1);
	AddStaticVehicle(451,1383.4630,1035.0420,10.9131,91.2515,-1,-1);
	AddStaticVehicle(477,1445.4526,974.2831,10.5534,1.6213,-1,-1);
	AddStaticVehicle(400,1704.2365,940.1490,10.9127,91.9048,-1,-1);
	AddStaticVehicle(510,1677.6628,1040.1930,10.4136,178.7038,-1,-1);
	AddStaticVehicle(510,1383.6959,1042.2114,10.4121,85.7269,-1,-1);
	AddStaticVehicle(510,1064.2332,1215.4158,10.4157,177.2942,-1,-1);
	AddStaticVehicle(510,1111.4536,1788.3893,10.4158,92.4627,-1,-1);
	AddStaticVehicle(522,953.2818,1806.1392,8.2188,235.0706,-1,-1);
	AddStaticVehicle(522,995.5328,1886.6055,10.5359,90.1048,-1,-1);
	AddStaticVehicle(535,1439.5662,1999.9822,10.5843,0.4194,-1,-1);
	AddStaticVehicle(522,2156.3540,2188.6572,10.2414,22.6504,-1,-1);
	AddStaticVehicle(598,2277.6846,2477.1096,10.5652,180.1090,-1,-1);
	AddStaticVehicle(598,2268.9888,2443.1697,10.5662,181.8062,-1,-1);
	AddStaticVehicle(598,2256.2891,2458.5110,10.5680,358.7335,-1,-1);
	AddStaticVehicle(598,2251.6921,2477.0205,10.5671,179.5244,-1,-1);
	AddStaticVehicle(522,2476.7900,2532.2222,21.4416,0.5081,-1,-1);
	AddStaticVehicle(522,2580.5320,2267.9595,10.3917,271.2372,-1,-1);
	AddStaticVehicle(522,2814.4331,2364.6641,10.3907,89.6752,-1,-1);
	AddStaticVehicle(535,2827.4143,2345.6953,10.5768,270.0668,-1,-1);
	AddStaticVehicle(487,1614.7153,1548.7513,11.2749,347.1516,-1,-1);
	AddStaticVehicle(487,1647.7902,1538.9934,11.2433,51.8071,-1,-1);
	AddStaticVehicle(487,1608.3851,1630.7268,11.2840,174.5517,-1,-1);
	AddStaticVehicle(476,1283.0006,1324.8849,9.5332,275.0468,-1,-1);
	AddStaticVehicle(476,1283.5107,1361.3171,9.5382,271.1684,-1,-1);
	AddStaticVehicle(513,1283.6847,1386.5137,11.5300,272.1003,-1,-1);
	AddStaticVehicle(513,1288.0499,1403.6605,11.5295,243.5028,-1,-1);
	AddStaticVehicle(415,1319.1038,1279.1791,10.5931,0.9661,-1,-1);
	AddStaticVehicle(535,2822.3628,2240.3594,10.5812,89.7540,-1,-1);
	AddStaticVehicle(429,2842.0554,2637.0105,10.5000,182.2949,-1,-1);
	AddStaticVehicle(575,2494.4214,2813.9348,10.5172,316.9462,-1,-1);
	AddStaticVehicle(534,2327.6484,2787.7327,10.5174,179.5639,-1,-1);
	AddStaticVehicle(534,2142.6970,2806.6758,10.5176,89.8970,-1,-1);
	AddStaticVehicle(534,1904.7527,2157.4312,10.5175,183.7728,-1,-1);
	AddStaticVehicle(534,1613.1553,2200.2664,10.5176,89.6204,-1,-1);
	AddStaticVehicle(400,1552.1292,2341.7854,10.9126,274.0815,-1,-1);
	AddStaticVehicle(400,1357.4165,2259.7158,10.9126,269.5567,-1,-1);
	AddStaticVehicle(510,1281.7458,2571.6719,10.5472,270.6128,-1,-1);
	AddStaticVehicle(522,1305.5295,2528.3076,10.3955,88.7249,-1,-1);
	AddStaticVehicle(415,1512.7134,787.6931,10.5921,359.5796,-1,-1);
	AddStaticVehicle(522,2299.5872,1469.7910,10.3815,258.4984,-1,-1);
	AddStaticVehicle(522,2133.6428,1012.8537,10.3789,87.1290,-1,-1);
	AddStaticVehicle(415,2266.7336,648.4756,11.0053,177.8517,-1,-1);
	AddStaticVehicle(461,2404.6636,647.9255,10.7919,183.7688,-1,-1);
	AddStaticVehicle(506,2628.1047,746.8704,10.5246,352.7574,-1,-1);
	AddStaticVehicle(568,-441.3438,2215.7026,42.2489,191.7953,-1,-1);
	AddStaticVehicle(568,-422.2956,2225.2612,42.2465,0.0616,-1,-1);
	AddStaticVehicle(568,-371.7973,2234.5527,42.3497,285.9481,-1,-1);
	AddStaticVehicle(568,-360.1159,2203.4272,42.3039,113.6446,-1,-1);
	AddStaticVehicle(460,-1029.2648,2237.2217,42.2679,260.5732,-1,-1);
	AddStaticVehicle(536,95.0568,1056.5530,13.4068,192.1461,-1,-1);
	AddStaticVehicle(429,114.7416,1048.3517,13.2890,174.9752,-1,-1);
	AddStaticVehicle(409,-290.0065,1759.4958,42.4154,89.7571,-1,-1);
	AddStaticVehicle(522,-302.5649,1777.7349,42.2514,238.5039,-1,-1);
	AddStaticVehicle(522,-302.9650,1776.1152,42.2588,239.9874,-1,-1);
	AddStaticVehicle(535,-866.1774,1557.2700,23.8319,269.3263,-1,-1);
	AddStaticVehicle(522,-867.8612,1544.5282,22.5419,296.0923,-1,-1);
	AddStaticVehicle(554,-904.2978,1553.8269,25.9229,266.6985,-1,-1);
	AddStaticVehicle(429,-237.7157,2594.8804,62.3828,178.6802,-1,-1);
	AddStaticVehicle(463,-196.3012,2774.4395,61.4775,303.8402,-1,-1);
	AddStaticVehicle(519,-1341.1079,-254.3787,15.0701,321.6338,-1,-1);
	AddStaticVehicle(592,-1371.1775,-232.3967,15.0676,315.6091,-1,-1);
	AddStaticVehicle(513,-1355.6632,-488.9562,14.7157,191.2547,-1,-1);
	AddStaticVehicle(513,-1374.4580,-499.1462,14.7482,220.4057,-1,-1);
	AddStaticVehicle(553,-1197.8773,-489.6715,15.4841,0.4029,-1,-1);
	AddStaticVehicle(553,1852.9989,-2385.4009,15.4841,200.0707,-1,-1);
	AddStaticVehicle(511,1642.9850,-2425.2063,14.4744,159.8745,-1,-1);
	AddStaticVehicle(519,1734.1311,-2426.7563,14.4734,172.2036,-1,-1);
	AddStaticVehicle(415,-680.9882,955.4495,11.9032,84.2754,-1,-1);
	AddStaticVehicle(460,-816.3951,2222.7375,43.0045,268.1861,-1,-1);
	AddStaticVehicle(460,-94.6885,455.4018,1.5719,250.5473,-1,-1);
	AddStaticVehicle(460,1624.5901,565.8568,1.7817,200.5292,-1,-1);
	AddStaticVehicle(460,1639.3567,572.2720,1.5311,206.6160,-1,-1);
	AddStaticVehicle(446,2293.4219,517.5514,1.7537,270.7889,-1,-1);
	AddStaticVehicle(446,2354.4690,518.5284,1.7450,270.2214,-1,-1);
	AddStaticVehicle(446,772.4293,2912.5579,1.0753,69.6706,-1,-1);
	AddStaticVehicle(560,2133.0769,1019.2366,10.5259,90.5265,-1,-1);
	AddStaticVehicle(560,2142.4023,1408.5675,10.5258,0.3660,-1,-1);
	AddStaticVehicle(560,2196.3340,1856.8469,10.5257,179.8070,-1,-1);
	AddStaticVehicle(560,2103.4146,2069.1514,10.5249,270.1451,-1,-1);
	AddStaticVehicle(560,2361.8042,2210.9951,10.3848,178.7366,-1,-1);
	AddStaticVehicle(560,-1993.2465,241.5329,34.8774,310.0117,-1,-1);
	AddStaticVehicle(559,-1989.3235,270.1447,34.8321,88.6822,-1,-1);
	AddStaticVehicle(559,-1946.2416,273.2482,35.1302,126.4200,-1,-1);
	AddStaticVehicle(558,-1956.8257,271.4941,35.0984,71.7499,-1,-1);
	AddStaticVehicle(562,-1952.8894,258.8604,40.7082,51.7172,-1,-1);
	AddStaticVehicle(409,-1949.8689,266.5759,40.7776,216.4882,-1,-1);
	AddStaticVehicle(601,2277.3359,2432.0098,-7.4531,359.0811,0,0);
	AddStaticVehicle(601,2268.2959,2432.5803,-7.4531,359.0811,0,0);
	AddStaticVehicle(601,2259.5544,2432.8989,-7.4531,89.0811,0,0);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	new player[24];
	GetPlayerName(playerid,player,24);
	if(dini_Exists(udb_encode(player))) GameTextForPlayer(playerid,"~w~~n~~n~~n~~n~login to restor character",1000,5);
	else
	{
	    GameTextForPlayer(playerid,"~w~~n~~n~~n~~n~Young Adult ~b~Age 18",1000,5);
		pInfo[playerid][Age] = 18;
	}
	SetPlayerPos(playerid, 1961.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	new player[24];
	GetPlayerName(playerid,player,24);
	if(dini_Exists(udb_encode(player)))
	GameTextForPlayer(playerid,"~r~||~n~Login in 20 seconds or be kicked~n~||",1000,6);
	else
	GameTextForPlayer(playerid,"~b~||~n~Please register to save stats~n~||",1000,6);
	pInfo[playerid][Disease] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	new player[24];
	GetPlayerName(playerid,player,24);
	if(pInfo[playerid][Logged] == 0 && dini_Exists(udb_encode(player)))
	{
	    kicker = SetTimer("Kick_P",1000,1);
	    SendClientMessage(playerid,0x880000AA,"** Login in 20 seconds or you will be kicked by the server for not logging in.");
		pInfo[playerid][KickP] = 1;
	}
	GameTextForPlayer(playerid,"~n~~n~~n~~n~Regular chat is limited to 30 feet.",3000,3);
	GameTextForPlayer(playerid,"~r~/p [text] ~y~to chat ~n~without distance limit",1000,1);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	new Float:x,Float:y,Float:z;
	if(killerid != 255 && z > 700)
	{
	    GetPlayerPos(killerid,x,y,z);
	    Report(killerid,1);
	}
	return 1;
}

public OnPlayerText(playerid,text[])
{
	new player[24],str[86];
	GetPlayerName(playerid,player,24);
	format(str,sizeof(str),"* %s: %s",player,text);
	for(new i=0; i<MAX_PLAYERS; i++) if(IsPlayerConnected(i)) if(D(playerid,i) < 30)
	SendClientMessage(i,COLOR_WHITE,str);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	dcmd(help,4,cmdtext);
	dcmd(commands,8,cmdtext);
	dcmd(givecash,8,cmdtext);
	dcmd(p,1,cmdtext);
	dcmd(me,2,cmdtext);
	return 0;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public Kick_P()
{
    new strikes[MAX_PLAYERS],str[36];
	for(new i=0; i<MAX_PLAYERS; i++) if(IsPlayerConnected(i)) if(pInfo[i][KickP] == 1)
	{
		strikes[i]++;
		format(str,sizeof(str),"~n~~n~~n~~n~~w~Time Left: ~y~%d",strikes[i]);
		GameTextForPlayer(i,str,1000,3);
		if(strikes[i] >= 20)
		{
		    strikes[i] = -1;
		    SendClientMessage(i,0xFF0000AA,"** You have been kicked for not logging in");
		}
		if(strikes[i] == -1)
		{
			Kick(i);
			strikes[i] = 0;
			KillTimer(kicker);
		}
    }
}


stock Report(playerid,reason)
{
	new str[120],player[24];
    GetPlayerName(playerid,player,24);
	switch(reason)
	{
		case 1:
		format(str,sizeof(str),"Las Venturas RP Anticheat: %s detected possibly using [Indoor Weapons]",player);
	}
	for(new i=0; i<MAX_PLAYERS; i++) if(IsPlayerConnected(i)) if(pInfo[i][ALevel] >= 2)
	{
		SendClientMessage(i,COLOR_ORANGE,str);
	}
}

public AgeCheck()
{
	new str[100];
	for(new i=0; i<MAX_PLAYERS; i++) if(IsPlayerConnected(i))
	{
		pInfo[i][Age]++;
		GameTextForPlayer(i,"~y~Happy ~g~Birthday",1000,1);
		format(str,sizeof(str),"~n~~n~~n~~n~~w~Your new age: ~g~%d",pInfo[i][Age]);
		GameTextForPlayer(i,str,3000,3);
		if(pInfo[i][Age] > 40 && pInfo[i][Age] < 90)
		{
		    new disease = random(5) + 1;
		    if(disease == 4)
		    {
		        new dis = random(4) + 1;
		        pInfo[i][Disease] = dis;
		        format(str,sizeof(str),"* Disease: %s",Dis(pInfo[i][Disease]));
                SendClientMessage(i,COLOR_GREY,"* You have just caught a disease due to sharing food with a homeless man.");
				SendClientMessage(i,COLOR_GREY,str);
		    }
		}
		if(pInfo[i][Age] > 90 && pInfo[i][Age] < 100)
		{
			GameTextForPlayer(i,"~n~~n~~n~~n~You have just lived life without disease.",1000,3);
			GameTextForPlayer(i,"~g~Diseases will not ~n~kill you",1000,1);
			GameTextForPlayer(i,"~y~/newlife ~b~or continue with this life",3000,0);
		}
	}
}

public DiseaseCheck() for(new i=0; i<MAX_PLAYERS; i++) if(IsPlayerConnected(i)) if(pInfo[i][Disease] >= 1) SetPlayerHealth(i,-1);

stock Dis(dc)
{
	new str[86];
	switch(dc)
	{
		case 1:
        format(str,sizeof(str),"HIV - Slowly decreases your health and state until death occurs.");
		case 2:
        format(str,sizeof(str),"AIDS - Slowly decreases your health and limits activity.");
		case 3:
        format(str,sizeof(str),"Herpes - Decreases activity level and increases mood swings. Also decreases health.");
		case 4:
        format(str,sizeof(str),"Crabs - Slowly decreases health, increases mood swings, and also causes death.");
	}
	return str;
}

dcmd_help(playerid,params[])
{
	SendClientMessage(playerid,COLOR_RED,"________________________________________");
	SendClientMessage(playerid,COLOR_YELLOW,"* Welcome to the Las Venturas RP Help:");
	SendClientMessage(playerid,COLOR_GREY,"* Currently the Las Venturas RP gamemode is in 0.1 beta so it may have bugs.");
	SendClientMessage(playerid,COLOR_GREY,"* Only some commands have been added which may be found in /commands.");
	SendClientMessage(playerid,COLOR_RED,"________________________________________");
	#pragma unused params
	return 1;
}

dcmd_commands(playerid,params[])
{
	SendClientMessage(playerid,COLOR_RED,"________________________________________");
	SendClientMessage(playerid,COLOR_YELLOW,"* Las Venturas RP - Command Station V: 0.2a");
	SendClientMessage(playerid,COLOR_GREY,"* /help || /commands || /givecash [playerid] [amount] || /p [text] || /me [action]");
	SendClientMessage(playerid,COLOR_GREY,"* More commands will be added with the release of las Venturas RP - Command Station 0.3b");
	SendClientMessage(playerid,COLOR_RED,"________________________________________");
	#pragma unused params
	return 1;
}

dcmd_givecash(playerid,params[])
{
	new p2[24],string[86],player[24],tmp[255],x;
	GetPlayerName(playerid,player,24);
	if(!strlen(params))
	{
		SendClientMessage(playerid,COLOR_GREY,"* Proper Sintax: /givecash [playerid] [amount]");
		return 1;
	}
	new giveplayerid = strval(params);
	tmp = strtok(params,x);
	if(!strlen(params))
	{
		SendClientMessage(playerid,COLOR_GREY,"* Proper Sintax: /givecash [playerid] [amount]");
		return 1;
	}
	new moneys = strval(tmp);
	if(!IsPlayerConnected(giveplayerid))
	{
		SendClientMessage(playerid,COLOR_RED,"* Transaction Error: The given player is ether disconnected or has just crashed.");
		return 1;
	}
	GetPlayerName(strval(params),p2,24);
	if(GetPlayerMoney(playerid) <= moneys + 1)
	{
		SendClientMessage(playerid,COLOR_RED,"* Transaction Error: You do not have that much money to send.");
		return 1;
	}
	GivePlayerMoney(playerid, -moneys);
	GivePlayerMoney(giveplayerid, moneys);
	format(string, sizeof(string), "* You have transacted $%s to the player %s.",moneys,p2);
	SendClientMessage(playerid, COLOR_YELLOW, string);
	format(string, sizeof(string), "* Player %s has transacted $%s to you.",player);
	SendClientMessage(giveplayerid, COLOR_YELLOW, string);
	return 1;
}

dcmd_p(playerid,params[])
{
	new str[86],player[24];
	GetPlayerName(playerid,player,24);
	if(!strlen(params))
	{
	    SendClientMessage(playerid,COLOR_GREY,"* Proper Sintax: /p [text]");
		return 1;
	}
	if(strfind(params, "%s", true) == 0)
	{
	    SendClientMessage(playerid,COLOR_RED,"* Trying to use an exploit to crash the server is against the rules.");
		return 1;
	}
	format(str,sizeof(str),"* |OOC| %s: %s",player,params);
	SendClientMessageToAll(COLOR_GREY,str);
	return 1;
}

dcmd_me(playerid,params[])
{
	new str[86],player[24];
	GetPlayerName(playerid,player,24);
	if(!strlen(params))
	{
	    SendClientMessage(playerid,COLOR_GREY,"* Proper Sintax: /me [action]");
		return 1;
	}
	if(strfind(params, "%s", true) == 0)
	{
	    SendClientMessage(playerid,COLOR_RED,"* Trying to use an exploit to crash the server is against the rules.");
		return 1;
	}
	format(str,sizeof(str),"* %s %s",player,params);
	for(new i=0; i<MAX_PLAYERS; i++) if(IsPlayerConnected(i)) if(D(playerid,i) < 30)
	SendClientMessage(i,COLOR_ORANGE,str);
	return 1;
}
