#include <a_samp>

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_BLACK 0x000000AA
#define COLOR_TRANS 0xFFFFFF00
#define CHECKPOINT_BLA 0
#define MAX_STRING 255

forward GameModeExitFunc();

//---------------------------------------------------------

main()
{
	print("\n-------------------------------");
	print("      MovieMakerMod - MMM\n");
	print("            -By Tape\n");
	print("-------------------------------\n");
}

//---------------------------------------------------------


public OnGameModeInit()
	{
	SetGameModeText("MovieMakerMod");

	AddPlayerClass(280,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //0 -
	AddPlayerClass(281,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //1 -
	AddPlayerClass(282,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //2 -
	AddPlayerClass(283,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //3 -
	AddPlayerClass(284,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //4 -
	AddPlayerClass(285,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //5 -
	AddPlayerClass(286,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //6 -
	AddPlayerClass(287,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //7 -

	AddPlayerClass(254,1958.3783,1343.1572,15.3746,0.0,0,0,24,300,-1,-1);      //8
	AddPlayerClass(255,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //9 -
	AddPlayerClass(256,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //10 -
	AddPlayerClass(257,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //11 -
	AddPlayerClass(258,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //12 -
	AddPlayerClass(259,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //13 -
	AddPlayerClass(260,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //14 -
	AddPlayerClass(261,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //15
	AddPlayerClass(262,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //16
	AddPlayerClass(263,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //17
	AddPlayerClass(264,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //18 -
	AddPlayerClass(274,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //19 -
	AddPlayerClass(275,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //20 -
	AddPlayerClass(276,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //21 -

	AddPlayerClass(1,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //22 -
	AddPlayerClass(2,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //23
	AddPlayerClass(290,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //24
	AddPlayerClass(291,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //25
	AddPlayerClass(292,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //26
	AddPlayerClass(293,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //27
	AddPlayerClass(294,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //28
	AddPlayerClass(295,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //29
	AddPlayerClass(296,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //30 -
	AddPlayerClass(297,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //31
	AddPlayerClass(298,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //32
    AddPlayerClass(299,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //33

	AddPlayerClass(277,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //34 -
	AddPlayerClass(278,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //35 -
	AddPlayerClass(279,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //36 -
	AddPlayerClass(288,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //37
	AddPlayerClass(47,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //38
	AddPlayerClass(48,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //39
	AddPlayerClass(49,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //40
	AddPlayerClass(50,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //41
	AddPlayerClass(51,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //42
	AddPlayerClass(52,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //43
	AddPlayerClass(53,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //44
	AddPlayerClass(54,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //45
	AddPlayerClass(55,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //46
	AddPlayerClass(56,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //47
	AddPlayerClass(57,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //48
	AddPlayerClass(58,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //49
	AddPlayerClass(59,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //50
	AddPlayerClass(60,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //51
	AddPlayerClass(61,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //52 -
	AddPlayerClass(62,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //53
	AddPlayerClass(63,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //54 -
	AddPlayerClass(64,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //55 -
	AddPlayerClass(66,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //56
	AddPlayerClass(67,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //57
	AddPlayerClass(68,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //58
	AddPlayerClass(69,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //59
	AddPlayerClass(70,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //60
	AddPlayerClass(71,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //61
	AddPlayerClass(72,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //62
	AddPlayerClass(73,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //63
	AddPlayerClass(75,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //64 -
	AddPlayerClass(76,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //65
	AddPlayerClass(78,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //66 -
	AddPlayerClass(79,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //67 -
	AddPlayerClass(80,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //68 -
	AddPlayerClass(81,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //69 -
	AddPlayerClass(82,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //70 -
	AddPlayerClass(83,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //71 -
	AddPlayerClass(84,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //72 -
	AddPlayerClass(85,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //73 -
	AddPlayerClass(87,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //74 -
	AddPlayerClass(88,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //75
	AddPlayerClass(89,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //76
	AddPlayerClass(91,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //77
	AddPlayerClass(92,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //78 -
	AddPlayerClass(93,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //79 -
	AddPlayerClass(95,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //80
	AddPlayerClass(96,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //81
	AddPlayerClass(97,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //82 -
	AddPlayerClass(98,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //83
	AddPlayerClass(99,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //84
	AddPlayerClass(100,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //85
	AddPlayerClass(101,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //86
	AddPlayerClass(102,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //87 -
	AddPlayerClass(103,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //88 -
	AddPlayerClass(104,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //89 -
	AddPlayerClass(105,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //90 -
	AddPlayerClass(106,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //91 -
	AddPlayerClass(107,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //92 -
	AddPlayerClass(108,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //93 -
	AddPlayerClass(109,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //94 -
	AddPlayerClass(110,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //95 -
	AddPlayerClass(111,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //96
	AddPlayerClass(112,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //97
	AddPlayerClass(113,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //98
	AddPlayerClass(114,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //99 -
	AddPlayerClass(115,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //100 -
	AddPlayerClass(116,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //101 -
	AddPlayerClass(117,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //102
	AddPlayerClass(118,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //103
	AddPlayerClass(120,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //104
	AddPlayerClass(121,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //105
	AddPlayerClass(122,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //106 -
	AddPlayerClass(123,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //107
	AddPlayerClass(124,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //108
	AddPlayerClass(125,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //109
	AddPlayerClass(126,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //110
	AddPlayerClass(127,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //111
	AddPlayerClass(128,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //112
	AddPlayerClass(129,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //113
	AddPlayerClass(131,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //114
	AddPlayerClass(133,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //115
	AddPlayerClass(134,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //116
	AddPlayerClass(135,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //117
	AddPlayerClass(136,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //118
	AddPlayerClass(137,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //119 -
	AddPlayerClass(138,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //120 -
	AddPlayerClass(139,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //121 -
	AddPlayerClass(140,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //122 -
	AddPlayerClass(141,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //123
	AddPlayerClass(142,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //124
	AddPlayerClass(143,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //125
	AddPlayerClass(144,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //126 -
	AddPlayerClass(145,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //127 -
	AddPlayerClass(146,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //128 -
	AddPlayerClass(147,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //129
	AddPlayerClass(148,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //130
	AddPlayerClass(150,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //131
	AddPlayerClass(151,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //132
	AddPlayerClass(152,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //133 -
	AddPlayerClass(153,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //134
	AddPlayerClass(154,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //135 -
	AddPlayerClass(155,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //136
	AddPlayerClass(156,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //137
	AddPlayerClass(157,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //138 -
	AddPlayerClass(158,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //139 -
	AddPlayerClass(159,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //140 -
	AddPlayerClass(160,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //141 -
	AddPlayerClass(161,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //142 -
	AddPlayerClass(162,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //143 -
	AddPlayerClass(163,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //144 -
	AddPlayerClass(164,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //145 -
	AddPlayerClass(165,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //146 -
	AddPlayerClass(166,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //147 -
	AddPlayerClass(167,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //148 -
	AddPlayerClass(168,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //149
	AddPlayerClass(169,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //150
	AddPlayerClass(170,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //151
	AddPlayerClass(171,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //152
	AddPlayerClass(172,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //153
	AddPlayerClass(173,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //154 -
	AddPlayerClass(174,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //155 -
	AddPlayerClass(175,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //156 -
	AddPlayerClass(176,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //157
	AddPlayerClass(177,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //158
	AddPlayerClass(178,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //159 -
	AddPlayerClass(179,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //160 -
	AddPlayerClass(180,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //161
	AddPlayerClass(181,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //162
	AddPlayerClass(182,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //163
	AddPlayerClass(183,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //164
	AddPlayerClass(184,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //165
	AddPlayerClass(185,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //166
	AddPlayerClass(186,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //167
	AddPlayerClass(187,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //168
	AddPlayerClass(188,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //169
	AddPlayerClass(189,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //170
	AddPlayerClass(190,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //171
	AddPlayerClass(191,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //172
	AddPlayerClass(192,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //173
	AddPlayerClass(193,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //174
	AddPlayerClass(194,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //175
	AddPlayerClass(195,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //176
	AddPlayerClass(196,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //177
	AddPlayerClass(197,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //178
	AddPlayerClass(198,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //179
	AddPlayerClass(199,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //180
	AddPlayerClass(200,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //181
	AddPlayerClass(201,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //182
	AddPlayerClass(202,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //183
	AddPlayerClass(203,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //184 -
	AddPlayerClass(204,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //185 -
	AddPlayerClass(205,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //186 -
	AddPlayerClass(206,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //187
	AddPlayerClass(207,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //188
	AddPlayerClass(209,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //189
	AddPlayerClass(210,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //190
	AddPlayerClass(211,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //191
	AddPlayerClass(212,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //192
	AddPlayerClass(213,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //193 -
	AddPlayerClass(214,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //194
	AddPlayerClass(215,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //195
	AddPlayerClass(216,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //196
	AddPlayerClass(217,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //197
	AddPlayerClass(218,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //198
	AddPlayerClass(219,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //199
	AddPlayerClass(220,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //200
	AddPlayerClass(221,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //201
	AddPlayerClass(222,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //202
	AddPlayerClass(223,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //203
	AddPlayerClass(224,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //204
	AddPlayerClass(225,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //205
	AddPlayerClass(226,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //206
	AddPlayerClass(227,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //207
	AddPlayerClass(228,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //208
	AddPlayerClass(229,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //209 -
	AddPlayerClass(230,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //210 -
	AddPlayerClass(231,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //211
	AddPlayerClass(232,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //212
	AddPlayerClass(233,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //213
	AddPlayerClass(234,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //214
	AddPlayerClass(235,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //215
	AddPlayerClass(236,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //216
	AddPlayerClass(237,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //217
	AddPlayerClass(238,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //218
	AddPlayerClass(239,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //219
	AddPlayerClass(240,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //220
	AddPlayerClass(241,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //221 -
	AddPlayerClass(242,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //222 -
	AddPlayerClass(243,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //223
	AddPlayerClass(244,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //224
	AddPlayerClass(245,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //225
	AddPlayerClass(246,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //226 -
	AddPlayerClass(247,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //227
	AddPlayerClass(248,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //228
	AddPlayerClass(249,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //229 -
	AddPlayerClass(250,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //230
	AddPlayerClass(251,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //231
	AddPlayerClass(253,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,-1,-1);      //232 -

	AddStaticVehicle(482,1366.0486,-2207.3179,13.5469,270.0,-1,-1); // burrito
	AddStaticVehicle(482,1364.6278,-2210.7576,13.5469,270.0,-1,-1); // burrito
	AddStaticVehicle(482,1365.3701,-2214.6147,13.5469,270.0,-1,-1); // burrito
	AddStaticVehicle(482,1411.3604,-2330.6201,14.2605,0.0,-1,-1); // burrito
	AddStaticVehicle(482,1414.8036,-2330.6064,14.2386,0.0,-1,-1); // burrito
	AddStaticVehicle(522,1365.0952,-2217.9014,13.5469,270.0,-1,-1); // nrg500
	AddStaticVehicle(522,1365.0498,-2221.6072,13.5469,270.0,-1,-1); // nrg500
	AddStaticVehicle(522,1364.6146,-2225.1790,13.5469,270.0,-1,-1); // nrg500
	AddStaticVehicle(522,1364.9265,-2228.7825,13.5469,270.0,-1,-1); // nrg500
	AddStaticVehicle(522,1398.2279,-2330.6719,14.2599,0.0,-1,-1); // nrg500
	AddStaticVehicle(522,1401.4025,-2330.6592,14.2605,0.0,-1,-1); // nrg500
	AddStaticVehicle(522,1404.7955,-2330.6458,14.2386,0.0,-1,-1); // nrg500
	AddStaticVehicle(522,1407.9689,-2330.6331,14.2605,0.0,-1,-1); // nrg500
	AddStaticVehicle(579,1364.4519,-2232.0415,13.5469,270.0,-1,-1); // huntley
	AddStaticVehicle(579,1364.9235,-2235.5168,13.5469,270.0,-1,-1); // huntley
	AddStaticVehicle(579,1385.0646,-2330.7251,14.2386,0.0,-1,-1); // huntley
	AddStaticVehicle(579,1388.4359,-2330.7114,14.2605,0.0,-1,-1); // huntley
	AddStaticVehicle(420,1364.7314,-2239.2551,13.5469,270.0,-1,-1); // taxi
	AddStaticVehicle(420,1364.2582,-2242.6699,13.5469,270.0,-1,-1); // taxi
	AddStaticVehicle(420,1492.4818,-2361.4929,14.2555,0.0,-1,-1); // taxi
	AddStaticVehicle(420,1495.8484,-2361.4792,14.2550,0.0,-1,-1); // taxi
	AddStaticVehicle(567,1364.4469,-2246.1516,13.5469,270.0,-1,-1); // savanna
	AddStaticVehicle(567,1364.5934,-2250.0266,13.5469,270.0,-1,-1); // savanna
	AddStaticVehicle(567,1364.1650,-2253.4646,13.5469,270.0,-1,-1); // savanna
	AddStaticVehicle(567,1499.0719,-2361.4663,14.2555,0.0,-1,-1); // savanna
	AddStaticVehicle(567,1502.2711,-2361.4539,14.2555,0.0,-1,-1); // savanna
	AddStaticVehicle(495,1364.4114,-2256.7329,13.5469,270.0,-1,-1); // sansking
	AddStaticVehicle(495,1364.2938,-2260.4412,13.5469,270.0,-1,-1); // sandking
	AddStaticVehicle(495,1391.6350,-2330.6985,14.2386,0.0,-1,-1); // sansking
	AddStaticVehicle(495,1395.1023,-2330.6846,14.2599,0.0,-1,-1); // sansking
	AddStaticVehicle(416,1398.5946,-2570.3145,13.6787,0.0,-1,-1); // ambulance
	AddStaticVehicle(416,1401.9622,-2570.3127,13.6786,0.0,-1,-1); // ambulance
	AddStaticVehicle(416,1518.6034,-2361.3889,14.2336,0.0,-1,-1); // ambulance
	AddStaticVehicle(416,1521.9249,-2361.3755,14.2549,0.0,-1,-1); // ambulance
	AddStaticVehicle(427,1406.9174,-2570.3105,13.6785,0.0,-1,-1); // enforcer
	AddStaticVehicle(427,1409.8728,-2570.3091,13.6784,0.0,-1,-1); // enforcer
	AddStaticVehicle(427,1533.1326,-2361.3311,14.2548,0.0,-1,-1); // enforcer
	AddStaticVehicle(427,1536.3093,-2361.3184,14.2555,0.0,-1,-1); // enforcer
	AddStaticVehicle(470,1412.7765,-2570.3076,13.6783,0.0,-1,-1); // patriot
	AddStaticVehicle(470,1415.2661,-2570.3064,13.6783,0.0,-1,-1); // patriot
	AddStaticVehicle(470,1418.5615,-2570.3044,13.6782,0.0,-1,-1); // patriot
	AddStaticVehicle(470,1421.3202,-2570.3032,13.6781,0.0,-1,-1); // patriot
	AddStaticVehicle(470,1526.4675,-2361.3577,14.2336,0.0,-1,-1); // patriot
	AddStaticVehicle(470,1529.8851,-2361.3442,14.2549,0.0,-1,-1); // patriot
	AddStaticVehicle(490,1424.6658,-2570.3015,13.6780,0.0,-1,-1); // fbi-ranch
	AddStaticVehicle(490,1428.3268,-2570.2993,13.6779,0.0,-1,-1); // fbi-ranch
	AddStaticVehicle(490,1539.7516,-2361.3049,14.2555,0.0,-1,-1); // fbi-ranch
	AddStaticVehicle(490,1542.9005,-2361.2922,14.2555,0.0,-1,-1); // fbi-ranch
	AddStaticVehicle(599,1546.2937,-2361.2786,14.2555,0.0,-1,-1); // copcarru
	AddStaticVehicle(599,1549.3727,-2361.2661,14.2336,0.0,-1,-1); // copcarru
	AddStaticVehicle(599,1552.6917,-2361.2534,14.2555,0.0,-1,-1); // copcarru
	AddStaticVehicle(599,1556.5021,-2361.2378,14.2555,0.0,-1,-1); // copcarru
	AddStaticVehicle(597,1430.4028,-2570.2983,13.6779,0.0,-1,-1); // copcar
	AddStaticVehicle(597,1433.7966,-2570.2969,13.6778,0.0,-1,-1); // copcar
	AddStaticVehicle(597,1437.2135,-2570.2952,13.6777,0.0,-1,-1); // copcar
	AddStaticVehicle(597,1439.8743,-2570.2937,13.6776,0.0,-1,-1); // copcar
	AddStaticVehicle(597,1561.0062,-2338.4309,14.2089,90.0,-1,-1); // copcar
	AddStaticVehicle(597,1561.0342,-2335.0852,14.1869,90.0,-1,-1); // copcar
	AddStaticVehicle(597,1561.0616,-2331.7898,14.2089,90.0,-1,-1); // copcar
	AddStaticVehicle(497,1561.0892,-2328.4946,14.1869,90.0,-1,-1); // copmav
	AddStaticVehicle(497,1561.1719,-2318.5806,14.2089,90.0,-1,-1); // copmav
	AddStaticVehicle(497,1442.4611,-2570.2925,13.6775,0.0,-1,-1); // copmav
	AddStaticVehicle(497,1453.1064,-2570.2869,13.6772,0.0,-1,-1); // copmav
	AddStaticVehicle(523,1561.1161,-2325.2725,14.2089,90.0,-1,-1); // copbike
	AddStaticVehicle(523,1561.1438,-2321.9504,14.1869,90.0,-1,-1); // copbike
	AddStaticVehicle(523,1446.1227,-2570.2905,13.6774,0.0,-1,-1); // copbike
	AddStaticVehicle(523,1449.1263,-2570.2891,13.6774,0.0,-1,-1); // copbike
	AddStaticVehicle(544,1505.5914,-2361.4407,14.2549,0.0,-1,-1); // firela
	AddStaticVehicle(544,1508.8147,-2361.4280,14.2549,0.0,-1,-1); // firela
	AddStaticVehicle(544,1512.2344,-2361.4143,14.2549,0.0,-1,-1); // firela
	AddStaticVehicle(544,1515.5039,-2361.4011,14.2555,0.0,-1,-1); // firela
	AddStaticVehicle(411,1414.6274,-2241.6362,13.5469,180.0,-1,-1); // infernus
	AddStaticVehicle(411,1411.2855,-2241.4385,13.5469,180.0,-1,-1); // infernus
	AddStaticVehicle(411,1365.1862,-2323.3833,13.9924,270,-1,-1); // infernus
	AddStaticVehicle(411,1365.1663,-2326.8484,13.9924,270,-1,-1); // infernus
	AddStaticVehicle(541,1407.6749,-2241.1296,13.5469,180.0,-1,-1); // bullet
	AddStaticVehicle(541,1404.7186,-2242.2129,13.5469,180.0,-1,-1); // bullet
	AddStaticVehicle(541,1365.0033,-2355.0671,13.9924,270,-1,-1); // bullet
	AddStaticVehicle(541,1364.9828,-2358.6057,13.9924,270,-1,-1); // bullet
	AddStaticVehicle(415,1401.1993,-2241.7595,13.5469,180.0,-1,-1); // cheetah
	AddStaticVehicle(415,1398.0126,-2241.2207,13.5469,180.0,-1,-1); // cheetah
	AddStaticVehicle(415,1365.1455,-2330.4370,13.9924,270,-1,-1); // cheetah
	AddStaticVehicle(415,1365.1252,-2333.9548,14.0143,270,-1,-1); // cheetah
	AddStaticVehicle(415,1365.1052,-2337.4219,14.0143,270,-1,-1); // cheetah
	AddStaticVehicle(451,1394.9819,-2241.5388,13.5469,180.0,-1,-1); // turismo
	AddStaticVehicle(451,1391.7078,-2241.9209,13.5469,180.0,-1,-1); // turismo
	AddStaticVehicle(451,1365.0432,-2348.1580,14.0143,270,-1,-1); // turismo
	AddStaticVehicle(451,1365.0240,-2351.4778,13.9924,270,-1,-1); // turismo
	AddStaticVehicle(559,1388.2388,-2241.3916,13.5469,180.0,-1,-1); // jester
	AddStaticVehicle(559,1384.7164,-2241.3411,13.5469,180.0,-1,-1); // jester
	AddStaticVehicle(559,1365.0845,-2341.0337,14.0143,270,-1,-1); // jester
	AddStaticVehicle(559,1365.0647,-2344.4502,14.0143,270,-1,-1); // jester
	AddStaticVehicle(418,1385.0450,-2225.3545,13.5469,0.0,-1,-1); // moonmeam
	AddStaticVehicle(418,1388.4071,-2226.3333,13.5469,0.0,-1,-1); // moonmeam
	AddStaticVehicle(418,1407.9314,-2347.7449,14.2250,180.0,-1,-1); // moonmeam
	AddStaticVehicle(418,1404.5133,-2347.7117,14.2257,180.0,-1,-1); // moonmeam
	AddStaticVehicle(426,1391.5687,-2226.2078,13.5469,0.0,-1,-1); // premier
	AddStaticVehicle(426,1394.9786,-2226.1248,13.5469,0.0,-1,-1); // premier
	AddStaticVehicle(426,1394.7455,-2347.6177,14.2257,180.0,-1,-1); // premier
	AddStaticVehicle(426,1391.5488,-2347.5867,14.2253,180.0,-1,-1); // premier
	AddStaticVehicle(445,1398.4316,-2226.1243,13.5469,0.0,-1,-1); // admiral
	AddStaticVehicle(445,1401.5532,-2226.3713,13.5469,0.0,-1,-1); // admiral
	AddStaticVehicle(445,1414.6696,-2347.8093,14.2257,180.0,-1,-1); // admiral
	AddStaticVehicle(445,1411.1547,-2347.7756,14.2251,180.0,-1,-1); // admiral
	AddStaticVehicle(413,1404.8827,-2225.9185,13.5469,0.0,-1,-1); // Pony
	AddStaticVehicle(413,1408.1858,-2226.0723,13.5469,0.0,-1,-1); // Pony
	AddStaticVehicle(413,1401.3881,-2347.6814,14.2038,180.0,-1,-1); // Pony
	AddStaticVehicle(413,1398.1169,-2347.6497,14.2038,180.0,-1,-1); // Pony
	AddStaticVehicle(404,1411.3131,-2225.7202,13.5469,0.0,-1,-1); // peren
	AddStaticVehicle(404,1415.1265,-2225.4392,13.5469,0.0,-1,-1); // peren
	AddStaticVehicle(404,1388.3269,-2347.5557,14.2249,180.0,-1,-1); // peren
	AddStaticVehicle(404,1384.8113,-2347.5225,14.2038,180.0,-1,-1); // peren
	AddStaticVehicle(444,1518.7466,-2569.7632,13.6787,0.1354,-1,-1); // monster
	AddStaticVehicle(444,1525.2189,-2569.7476,13.6785,0.1354,-1,-1); // monster
	AddStaticVehicle(444,1534.7375,-2569.7246,13.6782,0.1354,-1,-1); // monster
	AddStaticVehicle(457,1540.9384,-2569.7100,13.6780,0.1354,-1,-1); // caddy
	AddStaticVehicle(457,1549.6807,-2569.6895,13.6777,0.1354,-1,-1); // caddy
	AddStaticVehicle(457,1559.3719,-2569.6665,13.6773,0.1354,-1,-1); // caddy
	AddStaticVehicle(425,1515.2412,-2210.9133,13.5547,180.0,-1,-1); // hunter
	AddStaticVehicle(425,1507.0619,-2211.3533,13.5547,180.0,-1,-1); // hunter
	AddStaticVehicle(425,1497.4672,-2210.9841,13.5469,180.0,-1,-1); // hunter
	AddStaticVehicle(520,1486.5895,-2229.9534,13.5469,270.0,-1,-1); // hydra
	AddStaticVehicle(520,1486.9357,-2220.4670,13.5469,270.0,-1,-1); // hydra
	AddStaticVehicle(520,1407.7775,-2465.4526,14.0216,180.0,-1,-1); // hydra
	AddStaticVehicle(520,1424.1268,-2464.0815,14.0217,180.0,-1,-1); // hydra
	AddStaticVehicle(487,1529.7244,-2211.2676,13.5547,180.0,-1,-1); // maverick
	AddStaticVehicle(487,1536.3156,-2211.3386,13.5547,180.0,-1,-1); // maverick
	AddStaticVehicle(487,1542.9760,-2211.0007,13.5547,180.0,-1,-1); // maverick
	AddStaticVehicle(487,1549.2572,-2211.0632,13.5547,180.0,-1,-1); // maverick
	AddStaticVehicle(469,1561.2726,-2237.8054,13.5469,90.0,-1,-1); // sparrow
	AddStaticVehicle(469,1561.0455,-2244.5896,13.5469,90.0,-1,-1); // sparrow
	AddStaticVehicle(469,1561.2260,-2250.7656,13.5474,90.0,-1,-1); // sparrow
	AddStaticVehicle(469,1561.7146,-2257.4868,13.5480,90.0,-1,-1); // sparrow
	AddStaticVehicle(417,1438.0736,-2225.9648,13.5469,0.0,-1,-1); // leviathn
	AddStaticVehicle(563,1448.0824,-2225.4885,13.5469,0.0,-1,-1); // raindance
	AddStaticVehicle(548,1457.8755,-2225.4177,13.5469,0.0,-1,-1); // cargobob
	AddStaticVehicle(519,1564.6801,-2635.6287,13.5469,0.0,-1,-1); // shamal
	AddStaticVehicle(519,1537.0996,-2634.9717,13.5469,0.0,-1,-1); // shamal
	AddStaticVehicle(519,1527.3412,-2460.1272,13.5547,180.0,-1,-1); // shamal
	AddStaticVehicle(519,1560.0114,-2458.5129,13.5547,180.0,-1,-1); // shamal
	AddStaticVehicle(511,1512.2844,-2634.9714,13.5469,0.0,-1,-1); // beagle
	AddStaticVehicle(511,1492.3168,-2635.2180,13.5469,0.0,-1,-1); // beagle
	AddStaticVehicle(511,1588.4104,-2458.7314,13.5547,180.0,-1,-1); // beagle
	AddStaticVehicle(511,1613.1025,-2457.9099,13.5547,180.0,-1,-1); // beagle
	AddStaticVehicle(593,1469.7400,-2635.2546,13.5469,0.0,-1,-1); // dodo
	AddStaticVehicle(593,1458.6179,-2635.7932,13.5469,0.0,-1,-1); // dodo
	AddStaticVehicle(593,1484.5128,-2459.0173,14.0438,180.0,-1,-1); // dodo
	AddStaticVehicle(513,1439.9518,-2635.8184,13.5469,0.0,-1,-1); // stunt
	AddStaticVehicle(513,1425.5192,-2635.6389,13.5469,0.0,-1,-1); // stunt
	AddStaticVehicle(513,1501.4459,-2457.5972,14.0438,180.0,-1,-1); // stunt
	AddStaticVehicle(432,1443.4818,-2287.2026,13.5469,90.0,-1,-1); // tank
	AddStaticVehicle(432,1505.1625,-2286.8174,13.5469,270.0,-1,-1); // tank
	AddStaticVehicle(409,1452.4882,-2208.5920,13.5469,90.0,-1,-1); // limo
	AddStaticVehicle(409,1428.3097,-2208.6936,13.5469,90.0,-1,-1); // limo
	AddStaticVehicle(409,1365.2273,-2316.2529,13.9924,270,0,0); // limo
	AddStaticVehicle(409,1365.2061,-2319.9402,14.0139,270,0,0); // limo
	AddStaticVehicle(409,1364.9617,-2362.2432,14.0138,270,1,1); // limo
	AddStaticVehicle(409,1364.9413,-2365.7578,13.9924,270,1,1); // limo
	AddStaticVehicle(510,1419.5200,-2262.0593,13.5469,0.0,-1,-1); // mountainbike
	AddStaticVehicle(510,1422.4208,-2261.7336,13.5537,0.0,-1,-1); // mountainbike
	AddStaticVehicle(510,1424.8226,-2261.4199,13.5469,0.0,-1,-1); // mountainbike
	AddStaticVehicle(601,1496.7335,-2566.8191,13.5469,0.6366,-1,-1); // swatvan
	AddStaticVehicle(601,1486.7909,-2566.1338,13.5469,357.7440,-1,-1); // swatvan
	AddStaticVehicle(601,1477.1450,-2567.0544,13.5469,357.7440,-1,-1); // swatvan
	AddStaticVehicle(601,1561.1987,-2315.3574,14.1869,90.0,-1,-1); // swatvan
	AddStaticVehicle(601,1561.2256,-2312.1335,14.2089,90.0,-1,-1); // swatvan
	AddStaticVehicle(601,1561.2542,-2308.7141,14.1869,90.0,-1,-1); // swatvan
	AddStaticVehicle(437,1467.9613,-2566.2173,13.5469,357.7440,-1,-1); // coach
	AddStaticVehicle(437,1460.9382,-2567.7346,13.5469,357.7440,-1,-1); // coach
	AddStaticVehicle(473,1229.8671,-2510.9927,0.8629,79.0809,-1,-1); // boat-dingy
	AddStaticVehicle(473,1230.1289,-2509.6487,0.7307,80.7616,-1,-1); // boat-dingy
	AddStaticVehicle(473,1228.4160,-2520.1812,0.7306,80.7616,-1,-1); // boat-dingy
	AddStaticVehicle(473,1227.3069,-2527.0007,0.7306,80.7616,-1,-1); // boat-dingy
	AddStaticVehicle(473,1226.2997,-2533.1951,0.7307,80.7616,-1,-1); // boat-dingy
	AddStaticVehicle(493,1225.2452,-2539.6785,0.7306,80.7616,-1,-1); // boat-jetmax
	AddStaticVehicle(493,1224.0459,-2547.0540,0.7306,80.7616,-1,-1); // boat-jetmax
	AddStaticVehicle(484,1222.8312,-2554.5239,0.7307,80.7616,-1,-1); // boat-marquis
	AddStaticVehicle(484,1222.1888,-2558.4746,0.7306,80.7616,-1,-1); // boat-marquis
	AddStaticVehicle(452,1221.3737,-2563.4878,0.7306,80.7616,-1,-1); // boat-speeder
	AddStaticVehicle(452,1220.7273,-2567.4622,0.7306,80.7616,-1,-1); // boat-speeder
	AddStaticVehicle(430,1220.0809,-2571.4363,0.7306,80.7616,-1,-1); // boat-predator
	AddStaticVehicle(430,1219.1405,-2577.2190,0.7306,80.7616,-1,-1); // boat-predator
	AddStaticVehicle(430,1218.3761,-2581.9197,0.7306,80.7616,-1,-1); // boat-predator
	AddStaticVehicle(430,1217.5026,-2587.2915,0.7306,80.7616,-1,-1); // boat-predator
	AddStaticVehicle(447,1243.9099,-2595.8901,0.7307,80.7616,-1,-1); // seasparrow
	AddStaticVehicle(447,1241.8647,-2608.4651,0.7306,80.7616,-1,-1); // seasparrow
	AddStaticVehicle(447,1239.7522,-2621.4539,0.7306,80.7616,-1,-1); // seasparrow
	AddStaticVehicle(447,1238.1340,-2631.4045,0.7307,80.7616,-1,-1); // seasparrow

	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
new string[MAX_STRING];
if(strcmp(cmdtext, "/help", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN,"Movie-Maker-Mod Help");
		SendClientMessage(playerid, COLOR_YELLOW,"This mod is maded for movie-making,");
		SendClientMessage(playerid, COLOR_YELLOW,"and got alot of commands you can use.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /commands and /commands2 to get a list's of commands.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /teleports to get a list of teleport-list's.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /pimps to get a list of tranfenders.");
		return 1;
	}
if(strcmp(cmdtext, "/commands", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN,"Commands");
		SendClientMessage(playerid, COLOR_ORANGE,"Use /commands2 to get another list of commands.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /pimps to get a list of tranfenders.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /teleports to get a list of teleport-list's.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /weapons to get a list of weapon-commands.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /wtime1, /wtime2, /wtime3 ect. (Max /wtime23) to change time.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /flip to set your car on wheels if you tip over.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /vid to get the vehicle number.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /credits to view who created this mod.");
		return 1;
	}
if(strcmp(cmdtext, "/commands2", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN,"Commands2");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /remove to disarm yourself");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /skins to get a list of skin categories.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /spawn to save your corently posision as spawnposision.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /unspawn to set your spawnposision as normal.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /colors to get a list of colors (namecolor and blip-color(on minimap)).");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /1, /2, /3 ect. (MAX /18) to change player interior, default is /0");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /lock and /unlock to lock or unlock you vehicle.");
		return 1;
	}
if(strcmp(cmdtext, "/credits", true) == 0 && IsPlayerConnected(playerid)) {
		SendClientMessage(playerid, COLOR_GREEN,"Credits:");
		SendClientMessage(playerid, COLOR_LIGHTBLUE,"This mod is created by: [MOB]Tape");
		SendClientMessage(playerid, COLOR_LIGHTBLUE,"Email/MSN: puddithomas@hotmail.com");
		SendClientMessage(playerid, COLOR_LIGHTBLUE,"Name: Thomas Alexander Pedersen");
		return 1;
	}
if(strcmp(cmdtext, "/teleports", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"Use /tele-1, /tele-2 and /tele-3 to get some list's of normal teleports.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /city-1 and /city-2 to get some list's of teleports to small cityes.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /parkinglots to get a list of parkinglots.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /ships to get a list of ships.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /airports to get a list of airports.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /bridges to get a list of bridges.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /stadiums to get a list of stadiums.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /trainstations to get a list of trainstations.");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /sea to get a list of sea-teleports");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /back to get back to start.");
		return 1;
	}
	if(strcmp(cmdtext, "/pimps", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN,"Pimps");
		SendClientMessage(playerid, COLOR_ORANGE,"/sf1 (Teleports you to San Fierro pimp 1)");
		SendClientMessage(playerid, COLOR_ORANGE,"/sf2 (Teleports you to San Fierro pimp 2)");
		SendClientMessage(playerid, COLOR_ORANGE,"/ls1 (Teleports you to Los Santos pimp 1)");
		SendClientMessage(playerid, COLOR_ORANGE,"/ls2 (Teleports you to Los Santos pimp 2)");
		SendClientMessage(playerid, COLOR_ORANGE,"/lv1 (Teleports you to Las Venturas pimp 1)");
		return 1;
	}
	if(strcmp(cmdtext, "/weapons", true) == 0) {
	SendClientMessage(playerid, COLOR_GREEN,"Weapons");
		SendClientMessage(playerid, COLOR_ORANGE,"Class 1: /knife, /baseballbat, /flowers");
		SendClientMessage(playerid, COLOR_ORANGE,"Class 2: /pistol, /silenced /dildo");
		SendClientMessage(playerid, COLOR_ORANGE,"Class 3: /mp5 /tec9, /uzi");
		SendClientMessage(playerid, COLOR_ORANGE,"Class 4: /m4, /ak47, /combat ");
		SendClientMessage(playerid, COLOR_ORANGE,"Class 5: /sawnoff /flamethrower, /katana ");
		return 1;
	}
	if(strcmp(cmdtext, "/colors", true) == 0) {
		SendClientMessage(playerid, COLOR_ORANGE,"Available Colors:");
		SendClientMessage(playerid, COLOR_YELLOW,"/grey /green /blue /red /yellow /lblue /orange /black /white");
		SendClientMessage(playerid, COLOR_YELLOW,"Use /trans to get invisible on the map.");
		return 1;
	}
if(strcmp(cmdtext, "/tele-1", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/tele1 teleports you to the military in sf.");
		SendClientMessage(playerid, COLOR_YELLOW,"/tele2 teleports you to wang exports in sf.");
		SendClientMessage(playerid, COLOR_YELLOW,"/tele3 teleports you to the bike school in sf.");
		SendClientMessage(playerid, COLOR_YELLOW,"/tele4 teleports you to the mountain.");
		SendClientMessage(playerid, COLOR_YELLOW,"/tele5 teleports you to growstreet.");
		SendClientMessage(playerid, COLOR_YELLOW,"/tele6 teleports you to the dock in ls.");
		SendClientMessage(playerid, COLOR_YELLOW,"/tele7 teleports you to the quarry.");
		SendClientMessage(playerid, COLOR_YELLOW,"/tele8 teleports you to the watercanal in ls.");
		return 1;
	}
if(strcmp(cmdtext, "/tele-2", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/tele9 teleports you to a park.");
		SendClientMessage(playerid, COLOR_YELLOW,"/tele10 teleports you to a shoppingcenter in ls.");
		SendClientMessage(playerid, COLOR_YELLOW,"/tele11 teleports you to big smokes.");
		SendClientMessage(playerid, COLOR_YELLOW,"/tele12 teleports you to the dam.");
		SendClientMessage(playerid, COLOR_YELLOW,"/tele13 teleports you to lv policestation.");
		SendClientMessage(playerid, COLOR_YELLOW,"/tele14 teleports you to the tivoli.");
		SendClientMessage(playerid, COLOR_YELLOW,"/tele15 teleports you to a camping-park.");
		SendClientMessage(playerid, COLOR_YELLOW,"/tele16 teleports you to the moviestudie in ls.");
		return 1;
	}
if(strcmp(cmdtext, "/tele-3", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/tele17 teleports you to area 51.");
		SendClientMessage(playerid, COLOR_YELLOW,"/tele18 teleports you to the four dragons casino.");
		SendClientMessage(playerid, COLOR_YELLOW,"/tele19 teleports you to caligula's casino.");
		SendClientMessage(playerid, COLOR_YELLOW,"/tele20 teleports you to a high building in sf.");
		SendClientMessage(playerid, COLOR_YELLOW,"/tele21 teleports you to a high building in ls (STAR).");
		return 1;
	}
if(strcmp(cmdtext, "/city-1", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/city1 teleports you to Red Contry.");
		SendClientMessage(playerid, COLOR_YELLOW,"/city2 teleports you to Angel Pine.");
		SendClientMessage(playerid, COLOR_YELLOW,"/city3 teleports you to Bayside.");
		SendClientMessage(playerid, COLOR_YELLOW,"/city4 teleports you to El Quebrados.");
		SendClientMessage(playerid, COLOR_YELLOW,"/city5 teleports you to Los Barrancas.");
		SendClientMessage(playerid, COLOR_YELLOW,"/city6 teleports you to Fort Carson.");
		SendClientMessage(playerid, COLOR_YELLOW,"/city7 teleports you to Las Payasadas.");
		SendClientMessage(playerid, COLOR_YELLOW,"/city8 teleports you to Blueberry.");
		return 1;
	}
if(strcmp(cmdtext, "/city-2", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/city9 teleports you to Montgomery.");
		SendClientMessage(playerid, COLOR_YELLOW,"/city10 teleports you to Palomino Creek.");
		return 1;
	}
if(strcmp(cmdtext, "/parkinglots", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/parkinglot1 teleports you to a parkinglot in ls.");
		SendClientMessage(playerid, COLOR_YELLOW,"/parkinglot2 teleports you to a parkinglot in ls.");
		SendClientMessage(playerid, COLOR_YELLOW,"/parkinglot3 teleports you to a parkinglot in ls.");
		SendClientMessage(playerid, COLOR_YELLOW,"/parkinglot4 teleports you to a parkinglot in ls.");
		SendClientMessage(playerid, COLOR_YELLOW,"/parkinglot5 teleports you to a parkinglot in sf.");
		return 1;
	}
if(strcmp(cmdtext, "/ships", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/ship1 teleports you to the military-ship.");
		SendClientMessage(playerid, COLOR_YELLOW,"/ship2 teleports you to a container-ship.");
		SendClientMessage(playerid, COLOR_YELLOW,"/ship3 teleports you to a container-ship.");
		SendClientMessage(playerid, COLOR_YELLOW,"/ship4 teleports you to a container-ship.");
		return 1;
	}
if(strcmp(cmdtext, "/airports", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/airport1 teleports you to ls airport.");
		SendClientMessage(playerid, COLOR_YELLOW,"/airport2 teleports you to lv airport.");
		SendClientMessage(playerid, COLOR_YELLOW,"/airport3 teleports you to sf airport.");
		SendClientMessage(playerid, COLOR_YELLOW,"/airport4 teleports you to the old airport.");
		return 1;
	}
if(strcmp(cmdtext, "/bridges", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/bridge1 teleports you to one of the bridges in sf.");
		SendClientMessage(playerid, COLOR_YELLOW,"/bridge2 teleports you to one of the bridges in sf.");
		SendClientMessage(playerid, COLOR_YELLOW,"/bridge3 teleports you to one of the bridges in sf (TRAIN).");
		return 1;
	}
if(strcmp(cmdtext, "/stadiums", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/stadium1 teleports you to the stadium in ls.");
		SendClientMessage(playerid, COLOR_YELLOW,"/stadium1 teleports you to the stadium in sf.");
		SendClientMessage(playerid, COLOR_YELLOW,"/stadium1 teleports you to the stadium in lv.");
		return 1;
	}
if(strcmp(cmdtext, "/trainstations", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/train1 teleports you to ls trainstation (underground).");
		SendClientMessage(playerid, COLOR_YELLOW,"/train2 teleports you to sf trainstation.");
		return 1;
	}
if(strcmp(cmdtext, "/sea", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/sea1 teleports you to ls watercanal");
		SendClientMessage(playerid, COLOR_YELLOW,"/sea2 teleports you to ls dock");
		SendClientMessage(playerid, COLOR_YELLOW,"/sea3 teleports you to lv dock");
		SendClientMessage(playerid, COLOR_YELLOW,"/sea4 teleports you to bone contry dock");
		SendClientMessage(playerid, COLOR_YELLOW,"/sea5 teleports you to sf dock");
		SendClientMessage(playerid, COLOR_YELLOW,"/sea6 teleports you to the dam");
		SendClientMessage(playerid, COLOR_YELLOW,"/sea7 teleports you to mountain");
		SendClientMessage(playerid, COLOR_YELLOW,"/sea8 teleports you to sf airport");
		return 1;
	}
//---------------------------------------------------------------------------------------------SKIN-COMMANDS
if(strcmp(cmdtext, "/skins", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/cop /fun /gang /bitch /karate /fat /boxer /rich /poor /elvis");
		SendClientMessage(playerid, COLOR_YELLOW,"/special /contry /agent /beach /pilot /medic /fire /lady");
		return 1;
	}
	if(strcmp(cmdtext, "/gang", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/grove (Grove Street Families) /ballas (The Ballas) /vagos (Los Santos Vagos)");
		SendClientMessage(playerid, COLOR_YELLOW,"/varrios (Varrios Los Aztecas) /nang (Da Nang Boys) /rifa (San Fierro Rifa)");
		return 1;
	}
if(strcmp(cmdtext, "/cop", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/cop1 /cop2 /cop3 /cop4  /cop5 (biker) /cop6 (In-black) /cop7 (FBI)");
		SendClientMessage(playerid, COLOR_YELLOW,"/cop8 (military) /cop9 (Girl-Cop)");
		return 1;
	}
if(strcmp(cmdtext, "/fun", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/fun1 (clown) /fun2 (chicken) /fun3 (burger)");
		return 1;
	}
if(strcmp(cmdtext, "/grove", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/grove1 /grove2 /grove3");
		return 1;
		}
if(strcmp(cmdtext, "/ballas", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/ballas1 /ballas2 /ballas3");
		return 1;
		}
if(strcmp(cmdtext, "/vagos", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/vagos1 /vagos2 /vagos3");
		return 1;
		}
if(strcmp(cmdtext, "/varrios", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/varrios1 /varrios2 /varrios3");
		return 1;
		}
if(strcmp(cmdtext, "/nang", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/nang1 /nang2 /nang3");
		return 1;
		}
if(strcmp(cmdtext, "/rifa", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/rifa1 /rifa2 /rifa3");
		return 1;
		}
		
if(strcmp(cmdtext, "/bitch", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/bitch1 /bitch2 /bitch3 /bitch4 /bitch5 /bitch6 /bitch7 /bitch8 /bitch9 /bitch10");
		return 1;
	}
if(strcmp(cmdtext, "/karate", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/karate1 /karate2");
		return 1;
	}
if(strcmp(cmdtext, "/boxer", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/boxer1 /boxer2");
		return 1;
	}
if(strcmp(cmdtext, "/rich", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/rich1 /rich2");
		return 1;
	}
if(strcmp(cmdtext, "/poor", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/poor1 /poor2 /poor3 /poor4 /poor5 /poor6 /poor7 /poor8 ");
		return 1;
	}
if(strcmp(cmdtext, "/special", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/speciall /special2 /special3 /special4 (worker) /special5 (ammoman)");
		return 1;
	}
if(strcmp(cmdtext, "/contry", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/contry1 /contry2 /contry3 /contry4 /contry5 /contry6");
		return 1;
	}
if(strcmp(cmdtext, "/agent", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/agent1 /agent2 /agent3 /agent4");
		return 1;
	}
if(strcmp(cmdtext, "/elvis", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/elvis1 /elvis2 /elvis3");
		return 1;
	}
if(strcmp(cmdtext, "/beatch", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/beatch1 /beatch2");
		return 1;
	}
if(strcmp(cmdtext, "/pilot", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/pilot1 /pilot2 /pilot3");
		return 1;
	}
if(strcmp(cmdtext, "/medic", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/medic1 /medic2 /medic3");
		return 1;
	}
if(strcmp(cmdtext, "/fire", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/fire1 /fire2 /fire3");
		return 1;
	}
if(strcmp(cmdtext, "/fat", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/fat1 /fat2 /fat3 /fat4");
		return 1;
	}
if(strcmp(cmdtext, "/lady", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW,"/lady1 /lady2 /lady3 /lady4 /lady5");
		return 1;
	}
//---------------------------------------------------------------------------------------------SKIN-COMMANDS
//--------------------------------------------/cop
if(strcmp(cmdtext, "/cop1", true) == 0) {
SetPlayerSkin(playerid,280);
		return 1;
	}
if(strcmp(cmdtext, "/cop2", true) == 0) {
SetPlayerSkin(playerid,281);
		return 1;
	}
if(strcmp(cmdtext, "/cop3", true) == 0) {
SetPlayerSkin(playerid,282);
		return 1;
	}
if(strcmp(cmdtext, "/cop4", true) == 0) {
SetPlayerSkin(playerid,283);
		return 1;
	}
if(strcmp(cmdtext, "/cop5", true) == 0) {
SetPlayerSkin(playerid,284);
		return 1;
	}
if(strcmp(cmdtext, "/cop6", true) == 0) {
SetPlayerSkin(playerid,285);
		return 1;
	}
if(strcmp(cmdtext, "/cop7", true) == 0) {
SetPlayerSkin(playerid,286);
		return 1;
	}
if(strcmp(cmdtext, "/cop8", true) == 0) {
SetPlayerSkin(playerid,287);
		return 1;
	}
if(strcmp(cmdtext, "/cop9", true) == 0) {
SetPlayerSkin(playerid,246);
		return 1;
	}
//--------------------------------------------/fun
if(strcmp(cmdtext, "/fun1", true) == 0) {
SetPlayerSkin(playerid,264);
		return 1;
	}
if(strcmp(cmdtext, "/fun2", true) == 0) {
SetPlayerSkin(playerid,167);
		return 1;
	}
if(strcmp(cmdtext, "/fun3", true) == 0) {
SetPlayerSkin(playerid,205);
		return 1;
	}
//--------------------------------------------/grove
if(strcmp(cmdtext, "/grove1", true) == 0) {
SetPlayerSkin(playerid,105);
		return 1;
		}
if(strcmp(cmdtext, "/grove2", true) == 0) {
SetPlayerSkin(playerid,106);
		return 1;
		}
if(strcmp(cmdtext, "/grove3", true) == 0) {
SetPlayerSkin(playerid,107);
		return 1;
		}
//--------------------------------------------/ballas
if(strcmp(cmdtext, "/ballas1", true) == 0) {
SetPlayerSkin(playerid,102);
		return 1;
		}
if(strcmp(cmdtext, "/ballas2", true) == 0) {
SetPlayerSkin(playerid,103);
		return 1;
		}
if(strcmp(cmdtext, "/ballas3", true) == 0) {
SetPlayerSkin(playerid,104);
		return 1;
		}
//--------------------------------------------/vagos
if(strcmp(cmdtext, "/vagos1", true) == 0) {
SetPlayerSkin(playerid,108);
		return 1;
		}
if(strcmp(cmdtext, "/vagos2", true) == 0) {
SetPlayerSkin(playerid,109);
		return 1;
		}
if(strcmp(cmdtext, "/vagos3", true) == 0) {
SetPlayerSkin(playerid,110);
		return 1;
		}
//--------------------------------------------/varrios
if(strcmp(cmdtext, "/varrios1", true) == 0) {
SetPlayerSkin(playerid,173);
		return 1;
		}
if(strcmp(cmdtext, "/varrios2", true) == 0) {
SetPlayerSkin(playerid,174);
		return 1;
		}
if(strcmp(cmdtext, "/varrios3", true) == 0) {
SetPlayerSkin(playerid,175);
		return 1;
		}
//--------------------------------------------/nang
if(strcmp(cmdtext, "/nang1", true) == 0) {
SetPlayerSkin(playerid,121);
		return 1;
		}
if(strcmp(cmdtext, "/nang2", true) == 0) {
SetPlayerSkin(playerid,122);
		return 1;
		}
if(strcmp(cmdtext, "/nang3", true) == 0) {
SetPlayerSkin(playerid,123);
		return 1;
		}
//--------------------------------------------/rifa
if(strcmp(cmdtext, "/rifa1", true) == 0) {
SetPlayerSkin(playerid,114);
		return 1;
		}
if(strcmp(cmdtext, "/rifa2", true) == 0) {
SetPlayerSkin(playerid,115);
		return 1;
		}
if(strcmp(cmdtext, "/rifa3", true) == 0) {
SetPlayerSkin(playerid,116);
		return 1;
		}
//--------------------------------------------/bitch
if(strcmp(cmdtext, "/bitch1", true) == 0) {
SetPlayerSkin(playerid,1);
		return 1;
		}
if(strcmp(cmdtext, "/bitch2", true) == 0) {
SetPlayerSkin(playerid,85);
		return 1;
		}
if(strcmp(cmdtext, "/bitch3", true) == 0) {
SetPlayerSkin(playerid,178);
		return 1;
		}
if(strcmp(cmdtext, "/bitch4", true) == 0) {
SetPlayerSkin(playerid,87);
		return 1;
		}
if(strcmp(cmdtext, "/bitch5", true) == 0) {
SetPlayerSkin(playerid,157);
		return 1;
		}
if(strcmp(cmdtext, "/bitch6", true) == 0) {
SetPlayerSkin(playerid,75);
		return 1;
		}
if(strcmp(cmdtext, "/bitch7", true) == 0) {
SetPlayerSkin(playerid,256);
		return 1;
		}
if(strcmp(cmdtext, "/bitch8", true) == 0) {
SetPlayerSkin(playerid,257);
		return 1;
		}
if(strcmp(cmdtext, "/bitch9", true) == 0) {
SetPlayerSkin(playerid,63);
		return 1;
		}
if(strcmp(cmdtext, "/bitch10", true) == 0) {
SetPlayerSkin(playerid,64);
		return 1;
		}
//--------------------------------------------/karate
if(strcmp(cmdtext, "/karate1", true) == 0) {
SetPlayerSkin(playerid,203);
		return 1;
		}
if(strcmp(cmdtext, "/karate2", true) == 0) {
SetPlayerSkin(playerid,204);
		return 1;
		}
//--------------------------------------------/boxer
if(strcmp(cmdtext, "/boxer1", true) == 0) {
SetPlayerSkin(playerid,80);
		return 1;
		}
if(strcmp(cmdtext, "/boxer2", true) == 0) {
SetPlayerSkin(playerid,81);
		return 1;
		}
//--------------------------------------------/rich
if(strcmp(cmdtext, "/rich1", true) == 0) {
SetPlayerSkin(playerid,249);
		return 1;
		}
if(strcmp(cmdtext, "/rich2", true) == 0) {
SetPlayerSkin(playerid,296);
		return 1;
		}
//--------------------------------------------/poor
if(strcmp(cmdtext, "/poor1", true) == 0) {
SetPlayerSkin(playerid,212);
		return 1;
		}
if(strcmp(cmdtext, "/poor2", true) == 0) {
SetPlayerSkin(playerid,78);
		return 1;
		}
if(strcmp(cmdtext, "/poor3", true) == 0) {
SetPlayerSkin(playerid,79);
		return 1;
		}
if(strcmp(cmdtext, "/poor4", true) == 0) {
SetPlayerSkin(playerid,230);
		return 1;
		}
if(strcmp(cmdtext, "/poor5", true) == 0) {
SetPlayerSkin(playerid,239);
		return 1;
		}
if(strcmp(cmdtext, "/poor6", true) == 0) {
SetPlayerSkin(playerid,213);
		return 1;
		}
if(strcmp(cmdtext, "/poor7", true) == 0) {
SetPlayerSkin(playerid,137);
		return 1;
		}
//--------------------------------------------/elvis
if(strcmp(cmdtext, "/elvis1", true) == 0) {
SetPlayerSkin(playerid,82);
		return 1;
		}
if(strcmp(cmdtext, "/elvis2", true) == 0) {
SetPlayerSkin(playerid,83);
		return 1;
		}
if(strcmp(cmdtext, "/elvis3", true) == 0) {
SetPlayerSkin(playerid,84);
		return 1;
		}
//--------------------------------------------/special
if(strcmp(cmdtext, "/special1", true) == 0) {
SetPlayerSkin(playerid,145);
		return 1;
		}
if(strcmp(cmdtext, "/special2", true) == 0) {
SetPlayerSkin(playerid,146);
		return 1;
		}
if(strcmp(cmdtext, "/special3", true) == 0) {
SetPlayerSkin(playerid,152);
		return 1;
		}
if(strcmp(cmdtext, "/special4", true) == 0) {
SetPlayerSkin(playerid,260);
		return 1;
		}
if(strcmp(cmdtext, "/special5", true) == 0) {
SetPlayerSkin(playerid,179);
		return 1;
		}
//--------------------------------------------/contry
if(strcmp(cmdtext, "/contry1", true) == 0) {
SetPlayerSkin(playerid,157);
		return 1;
		}
if(strcmp(cmdtext, "/contry2", true) == 0) {
SetPlayerSkin(playerid,158);
		return 1;
		}
if(strcmp(cmdtext, "/contry3", true) == 0) {
SetPlayerSkin(playerid,159);
		return 1;
		}
if(strcmp(cmdtext, "/contry4", true) == 0) {
SetPlayerSkin(playerid,160);
		return 1;
		}
if(strcmp(cmdtext, "/contry5", true) == 0) {
SetPlayerSkin(playerid,161);
		return 1;
		}
if(strcmp(cmdtext, "/contry6", true) == 0) {
SetPlayerSkin(playerid,162);
		return 1;
		}
//--------------------------------------------/agent
if(strcmp(cmdtext, "/agent1", true) == 0) {
SetPlayerSkin(playerid,163);
		return 1;
		}
if(strcmp(cmdtext, "/agent2", true) == 0) {
SetPlayerSkin(playerid,164);
		return 1;
		}
if(strcmp(cmdtext, "/agent3", true) == 0) {
SetPlayerSkin(playerid,165);
		return 1;
		}
if(strcmp(cmdtext, "/agent4", true) == 0) {
SetPlayerSkin(playerid,166);
		return 1;
		}
//--------------------------------------------/beach
if(strcmp(cmdtext, "/beach1", true) == 0) {
SetPlayerSkin(playerid,97);
		return 1;
		}
if(strcmp(cmdtext, "/beach2", true) == 0) {
SetPlayerSkin(playerid,154);
		return 1;
		}
//--------------------------------------------/pilot
if(strcmp(cmdtext, "/pilot1", true) == 0) {
SetPlayerSkin(playerid,255);
		return 1;
		}
if(strcmp(cmdtext, "/pilot2", true) == 0) {
SetPlayerSkin(playerid,61);
		return 1;
		}
if(strcmp(cmdtext, "/pilot3", true) == 0) {
SetPlayerSkin(playerid,253);
		return 1;
		}
//--------------------------------------------/midic
if(strcmp(cmdtext, "/medic1", true) == 0) {
SetPlayerSkin(playerid,274);
		return 1;
		}
if(strcmp(cmdtext, "/medic2", true) == 0) {
SetPlayerSkin(playerid,275);
		return 1;
		}
if(strcmp(cmdtext, "/medic2", true) == 0) {
SetPlayerSkin(playerid,276);
		return 1;
		}
//--------------------------------------------/fire
if(strcmp(cmdtext, "/fire1", true) == 0) {
SetPlayerSkin(playerid,277);
		return 1;
		}
if(strcmp(cmdtext, "/fire2", true) == 0) {
SetPlayerSkin(playerid,278);
		return 1;
		}
if(strcmp(cmdtext, "/fire3", true) == 0) {
SetPlayerSkin(playerid,279);
		return 1;
		}
//--------------------------------------------/lady
if(strcmp(cmdtext, "/lady1", true) == 0) {
SetPlayerSkin(playerid,92);
		return 1;
		}
if(strcmp(cmdtext, "/lady2", true) == 0) {
SetPlayerSkin(playerid,93);
		return 1;
		}
if(strcmp(cmdtext, "/lady3", true) == 0) {
SetPlayerSkin(playerid,138);
		return 1;
		}
if(strcmp(cmdtext, "/lady4", true) == 0) {
SetPlayerSkin(playerid,139);
		return 1;
		}
if(strcmp(cmdtext, "/lady5", true) == 0) {
SetPlayerSkin(playerid,140);
		return 1;
		}
//--------------------------------------------/fat
if(strcmp(cmdtext, "/fat1", true) == 0) {
SetPlayerSkin(playerid,258);
		return 1;
		}
if(strcmp(cmdtext, "/fat2", true) == 0) {
SetPlayerSkin(playerid,259);
		return 1;
		}
if(strcmp(cmdtext, "/fat3", true) == 0) {
SetPlayerSkin(playerid,241);
		return 1;
		}
if(strcmp(cmdtext, "/fat4", true) == 0) {
SetPlayerSkin(playerid,242);
		return 1;
		}
//---------------------------------------------------------------------------------------------MISC-COMMANDS
if(strcmp(cmdtext, "/spawn", true) == 0) {
new Float:x;
new Float:y;
new Float:z;
GetPlayerPos(playerid,x,y,z);
SetSpawnInfo(playerid,1,285,x,y,z,0.0,0,0,24,300,0,0);
GameTextForPlayer(playerid,"Spawn posision saved.",2000,5);
return 1;
	}
if(strcmp(cmdtext, "/unspawn", true) == 0) {
SetSpawnInfo(playerid,1,285,1376.0348,-2233.1184,14.5700,0.0,0,0,24,300,0,0);
GameTextForPlayer(playerid,"Spawn posision deleted.",2000,5);
return 1;
	}

if (strcmp(cmdtext, "/flip", true)==0)
{
			new VehicleID, Float:X, Float:Y, Float:Z;
            GetPlayerPos(playerid, X, Y, Z);
  VehicleID = GetPlayerVehicleID(playerid);
  SetVehiclePos(VehicleID, X, Y, Z);
  SetVehicleZAngle(VehicleID, 0);
    return 1;
}
if (strcmp(cmdtext, "/remove", true)==0)
{
ResetPlayerWeapons(playerid);
    return 1;
}
if (strcmp(cmdtext, "/vid", true)==0)
        {
	new vid;
	vid = GetPlayerVehicleID(playerid);
            format(string, sizeof(string), "Vehicle ID: %d",vid);
                SendClientMessage(playerid,COLOR_GREEN,string);
            return 1;
}
	if (strcmp(cmdtext, "/lock", true)==0)
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new State=GetPlayerState(playerid);
				if(State!=PLAYER_STATE_DRIVER)
				{
					SendClientMessage(playerid,0xFFFF00AA,"You can only lock the doors as the driver.");
					return 1;
				}
				new i;
				for(i=0;i<MAX_PLAYERS;i++)
				{
					if(i != playerid)
					{
						SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 1);
					}
				}
				SendClientMessage(playerid, 0xFFFF00AA, "Vehicle locked!");
		    	new Float:pX, Float:pY, Float:pZ;
				GetPlayerPos(playerid,pX,pY,pZ);
				PlayerPlaySound(playerid,1056,pX,pY,pZ);
			}
			else
			{
				SendClientMessage(playerid, 0xFFFF00AA, "You're not in a vehicle!");
			}
		return 1;
		}

 if (strcmp(cmdtext, "/unlock", true)==0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new State=GetPlayerState(playerid);
			if(State!=PLAYER_STATE_DRIVER)
			{
				SendClientMessage(playerid,0xFFFF00AA,"You can only unlock the doors as the driver.");
				return 1;
			}
			new i;
			for(i=0;i<MAX_PLAYERS;i++)
			{
				SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
			}
			SendClientMessage(playerid, 0xFFFF00AA, "Vehicle unlocked!");
			new Float:pX, Float:pY, Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			PlayerPlaySound(playerid,1057,pX,pY,pZ);
		}
		else
		{
			SendClientMessage(playerid, 0xFFFF00AA, "You're not in a vehicle!");
		}
	return 1;
	}
	//-----------------------------------------------------------------------------------------TRANSFENDER-TELEPORTS
		if(strcmp(cmdtext, "/sf1", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-2006.1509,228.1003,28.1947);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-2006.1509,228.1003,28.1947);
				}
			return 1;
		}
	if(strcmp(cmdtext, "/sf2", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-2703.1340,217.4770,4.1797);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-2703.1340,217.4770,4.1797);
				}
			return 1;
		}
	if(strcmp(cmdtext, "/ls1", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,2656.7410,-2004.2413,13.3828);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,2656.7410,-2004.2413,13.3828);
				}
			return 1;
		}
	if(strcmp(cmdtext, "/ls2", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,1060.1434,-1039.7543,31.9436);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,1060.1434,-1039.7543,31.9436);
				}
			return 1;
		}
	if(strcmp(cmdtext, "/lv1", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,2402.5559,1033.0907,10.8130);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,2402.5559,1033.0907,10.8130);
				}
			return 1;
		}
		
	//-----------------------------------------------------------------------------------------TELEPORTS
if(strcmp(cmdtext, "/back", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    new VehicleID;
    	VehicleID = GetPlayerVehicleID(playerid);
		SetVehiclePos(VehicleID,-1976.2927,289.1692,35.1719);
		SetPlayerInterior(playerid,0);
		}
else{
		SetPlayerInterior(playerid,0);
        SetPlayerPos(playerid,-1976.2927,289.1692,35.1719);
	}
return 1;
}
	//--------------------------------------------------------------------------TELE-TELEPORTS
					if(strcmp(cmdtext, "/tele1", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-1540.9540,463.9418,7.1875);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-1540.9540,463.9418,7.1875);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/tele2", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-1984.9027,264.8299,35.1794);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-1984.9027,264.8299,35.1794);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/tele3", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-2043.4966,-132.4037,35.2779);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-2043.4966,-132.4037,35.2779);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/tele4", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-2327.7019,-1631.3575,483.7007);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-2327.7019,-1631.3575,483.7007);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/tele5", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,2491.8354,-1668.1565,13.3438);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,2491.8354,-1668.1565,13.3438);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/tele6", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,2763.6157,-2447.9072,13.5153);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,2763.6157,-2447.9072,13.5153);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/tele7", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,614.4579,849.3126,-43.0445);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,614.4579,849.3126,-43.0445);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/tele8", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,1892.7506,-1827.4911,3.9844);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,1892.7506,-1827.4911,3.9844);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/tele9", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,1970.0704,-1200.2939,25.6321);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,1970.0704,-1200.2939,25.6321);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/tele10", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,1129.3180,-1442.0913,15.7969);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,1129.3180,-1442.0913,15.7969);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/tele11", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,1291.2689,-788.1290,96.4609);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,1291.2689,-788.1290,96.4609);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/tele12", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-716.0689,2061.3584,60.3828);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-716.0689,2061.3584,60.3828);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/tele13", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,2287.3149,2413.2195,10.8810);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,2287.3149,2413.2195,10.8810);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/tele14", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,369.8532,-2032.2129,7.6719);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,369.8532,-2032.2129,7.6719);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/tele15", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-60.5679,-1595.1840,2.6430);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-60.5679,-1595.1840,2.6430);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/tele16", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,910.7578,-1221.4493,16.9766);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,910.7578,-1221.4493,16.9766);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/tele17", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,188.6851,1910.3362,17.6443);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,188.6851,1910.3362,17.6443);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/tele18", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,2041.5160,1007.4940,10.6719);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,2041.5160,1007.4940,10.6719);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/tele19", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,2176.6470,1676.7559,10.8203);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,2176.6470,1676.7559,10.8203);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/tele20", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-1753.5652,885.9987,295.8750);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-1753.5652,885.9987,295.8750);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/tele21", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,1544.8800,-1353.4958,329.4740);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,1544.8800,-1353.4958,329.4740);
				}
			return 1;
		}
		
	//--------------------------------------------------------------------------CITY-TELEPORTS
	
	if(strcmp(cmdtext, "/city1", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,716.5837,-534.2272,16.1815);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,716.5837,-534.2272,16.1815);
				}
			return 1;
		}
			if(strcmp(cmdtext, "/city2", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-2146.8655,-2410.1284,30.4688);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-2146.8655,-2410.1284,30.4688);
				}
			return 1;
		}
					if(strcmp(cmdtext, "/city3", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-2260.9924,2307.6384,4.8202);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-2260.9924,2307.6384,4.8202);
				}
			return 1;
		}
					if(strcmp(cmdtext, "/city4", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-1498.3317,2601.1155,55.6911);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-1498.3317,2601.1155,55.6911);
				}
			return 1;
		}
					if(strcmp(cmdtext, "/city5", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-800.0779,1577.5492,26.9609);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-800.0779,1577.5492,26.9609);
				}
			return 1;
		}
					if(strcmp(cmdtext, "/city6", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-104.5705,1097.9807,19.5938);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-104.5705,1097.9807,19.5938);
				}
			return 1;
		}
					if(strcmp(cmdtext, "/city7", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-256.3529,2700.9072,62.5391);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-256.3529,2700.9072,62.5391);
				}
			return 1;
		}
					if(strcmp(cmdtext, "/city8", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,233.7724,-137.2319,1.4297);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,233.7724,-137.2319,1.4297);
				}
			return 1;
		}

					if(strcmp(cmdtext, "/city9", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,2318.2649,1899.3151,10.6719);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,2318.2649,1899.3151,10.6719);
				}
			return 1;
		}
					if(strcmp(cmdtext, "/city10", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,2294.2275,41.8093,26.3359);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-2146.8655,-2410.1284,30.4688);
				}
			return 1;
		}
	//--------------------------------------------------------------------------PARKING-TELEPORTS
						if(strcmp(cmdtext, "/parkinglot1", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,2060.5173,2458.3171,10.6818);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,2060.5173,2458.3171,10.6818);
				}
			return 1;
		}
								if(strcmp(cmdtext, "/parkinglot2", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,1927.2258,2215.5293,10.6719);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,1927.2258,2215.5293,10.6719);
				}
			return 1;
		}
								if(strcmp(cmdtext, "/parkinglot3", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,2305.4292,1375.1725,10.8448);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,2305.4292,1375.1725,10.8448);
				}
			return 1;
		}
							if(strcmp(cmdtext, "/parkinglot4", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,1318.8854,315.2429,19.4127);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,1318.8854,315.2429,19.4127);
				}
			return 1;
		}
								if(strcmp(cmdtext, "/parkinglot5", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-1811.1765,1271.3563,14.8379);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-1811.1765,1271.3563,14.8379);
				}
			return 1;
		}
	//--------------------------------------------------------------------------SHIP-TELEPORTS
								if(strcmp(cmdtext, "/ship1", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-1341.2367,507.3179,18.2344);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-1341.2367,507.3179,18.2344);
				}
			return 1;
		}
								if(strcmp(cmdtext, "/ship2", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,2824.8413,-2431.3943,12.0878);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,2824.8413,-2431.3943,12.0878);
				}
			return 1;
		}
								if(strcmp(cmdtext, "/ship3", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-2466.1431,1546.6107,23.6641);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-2466.1431,1546.6107,23.6641);
				}
			return 1;
		}
								if(strcmp(cmdtext, "/ship4", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-1470.8608,1489.0396,8.2501);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-1470.8608,1489.0396,8.2501);
				}
			return 1;
		}
	//--------------------------------------------------------------------------AIRPORT-TELEPORTS
							if(strcmp(cmdtext, "/airport1", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,1505.0350,-2616.3782,13.5469);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,1505.0350,-2616.3782,13.5469);
				}
			return 1;
		}
								if(strcmp(cmdtext, "/airport2", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,1691.6326,1611.9042,10.8203);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,1691.6326,1611.9042,10.8203);
				}
			return 1;
		}
								if(strcmp(cmdtext, "/airport3", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-1358.3328,-235.8711,14.1440);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-1358.3328,-235.8711,14.1440);
				}
			return 1;
		}
								if(strcmp(cmdtext, "/airport4", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,417.0450,2501.3586,16.4844);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,417.0450,2501.3586,16.4844);
				}
			return 1;
		}
	//--------------------------------------------------------------------------BRIDGE-TELEPORTS
								if(strcmp(cmdtext, "/bridge1", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-2681.9409,1305.8148,55.4297);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-2681.9409,1305.8148,55.4297);
				}
			return 1;
		}
								if(strcmp(cmdtext, "/bridge2", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-1647.1440,565.1022,39.6656);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-1647.1440,565.1022,39.6656);
				}
			return 1;
		}
								if(strcmp(cmdtext, "/bridge3", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-1573.5327,534.7707,32.8446);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-1573.5327,534.7707,32.8446);
				}
			return 1;
		}
	//--------------------------------------------------------------------------STADIUM-TELEPORTS
								if(strcmp(cmdtext, "/stadium1", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,2673.2363,-1682.4967,9.3831);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,2673.2363,-1682.4967,9.3831);
				}
			return 1;
		}
								if(strcmp(cmdtext, "/stadium2", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-2130.8103,-444.2751,35.3359);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-2130.8103,-444.2751,35.3359);
				}
			return 1;
		}
								if(strcmp(cmdtext, "/stadium3", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,1099.3812,1606.6039,12.5469);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,1099.3812,1606.6039,12.5469);
				}
			return 1;
		}
	//--------------------------------------------------------------------------TRAIN-TELEPORTS
    						if(strcmp(cmdtext, "/train1", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,816.9129,-1347.2032,13.5278);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,816.9129,-1347.2032,13.5278);
				}
			return 1;
		}
								if(strcmp(cmdtext, "/train2", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-1989.3280,133.2599,27.5391);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-1989.3280,133.2599,27.5391);
				}
			return 1;
		}
								if(strcmp(cmdtext, "/back", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,1376.0348,-2233.1184,14.5700);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,1376.0348,-2233.1184,14.5700);
				}
			return 1;
		}
	//--------------------------------------------------------------------------SEA-TELEPORTS

					if(strcmp(cmdtext, "/sea1", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,688.8911,-1964.2723,3.6027);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,688.8911,-1964.2723,3.6027);
				}
			return 1;
		}
					if(strcmp(cmdtext, "/sea2", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,2421.9736,-2318.2021,2.0936);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,2421.9736,-2318.2021,2.0936);
				}
			return 1;
		}
					if(strcmp(cmdtext, "/sea3", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,2168.6367,478.8972,2.3758);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,2168.6367,478.8972,2.3758);
				}
			return 1;
		}
					if(strcmp(cmdtext, "/sea4", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,261.5638,2955.2473,2.9122);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,261.5638,2955.2473,2.9122);
				}
			return 1;
		}
					if(strcmp(cmdtext, "/sea5", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-1890.7693,1534.7864,3.7009);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-1890.7693,1534.7864,3.7009);
				}
			return 1;
		}
					if(strcmp(cmdtext, "/sea6", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-938.7398,2254.4944,50.0793);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-938.7398,2254.4944,50.0793);
				}
			return 1;
		}
					if(strcmp(cmdtext, "/sea7", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-2971.0669,-1026.1926,3.6790);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-2971.0669,-1026.1926,3.6790);
				}
			return 1;
		}
					if(strcmp(cmdtext, "/sea8", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:a;
					new Float:b;
					new Float:c;
				        new VehicleID;
				        GetPlayerPos(playerid, a, b, c);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-1047.4282,-304.7124,2.5207);
					SetPlayerInterior(playerid,0);
					}
else{
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,-1047.4282,-304.7124,2.5207);
				}
			return 1;
		}

	//--------------------------------------------------------------------------Interiors
if (strcmp(cmdtext, "/0", true)==0)
{
{
					SetPlayerInterior(playerid,0);
                }
        return 1;
}

if (strcmp(cmdtext, "/1", true)==0)
{
{
					SetPlayerInterior(playerid,1);
                }
        return 1;
}

if (strcmp(cmdtext, "/2", true)==0)
{
{
					SetPlayerInterior(playerid,2);
                }
        return 1;
}

if (strcmp(cmdtext, "/3", true)==0)
{
{
					SetPlayerInterior(playerid,3);
                }
        return 1;
}

if (strcmp(cmdtext, "/4", true)==0)
{
{
					SetPlayerInterior(playerid,4);
                }
        return 1;
}

if (strcmp(cmdtext, "/5", true)==0)
{
{
					SetPlayerInterior(playerid,5);
                }
        return 1;
}

if (strcmp(cmdtext, "/6", true)==0)
{
{
					SetPlayerInterior(playerid,6);
                }
        return 1;
}

if (strcmp(cmdtext, "/7", true)==0)
{
{
					SetPlayerInterior(playerid,7);
                }
        return 1;
}

if (strcmp(cmdtext, "/8", true)==0)
{
{
					SetPlayerInterior(playerid,8);
                }
        return 1;
}

if (strcmp(cmdtext, "/9", true)==0)
{
{
					SetPlayerInterior(playerid,9);
                }
        return 1;
}

if (strcmp(cmdtext, "/10", true)==0)
{
{
					SetPlayerInterior(playerid,10);
                }
        return 1;
}

if (strcmp(cmdtext, "/11", true)==0)
{
{
					SetPlayerInterior(playerid,11);
                }
        return 1;
}

if (strcmp(cmdtext, "/12", true)==0)
{
{
					SetPlayerInterior(playerid,12);
                }
        return 1;
}

if (strcmp(cmdtext, "/13", true)==0)
{
{
					SetPlayerInterior(playerid,13);
                }
        return 1;
}

if (strcmp(cmdtext, "/14", true)==0)
{
{
					SetPlayerInterior(playerid,14);
                }
        return 1;
}

if (strcmp(cmdtext, "/15", true)==0)
{
{
					SetPlayerInterior(playerid,15);
                }
        return 1;
}

if (strcmp(cmdtext, "/16", true)==0)
{
{
					SetPlayerInterior(playerid,16);
                }
        return 1;
}
if (strcmp(cmdtext, "/17", true)==0)
{
{
					SetPlayerInterior(playerid,17);
                }
        return 1;
}

if (strcmp(cmdtext, "/18", true)==0)
{
{
					SetPlayerInterior(playerid,18);
                }
        return 1;
}
//-------------------------------------------------------------------------------Time

if (strcmp(cmdtext, "/wtime0", true)==0)
{
{
            SetWorldTime(0);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime1", true)==0)
{
{
            SetWorldTime(1);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime2", true)==0)
{
{
            SetWorldTime(2);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime3", true)==0)
{
{
            SetWorldTime(3);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime4", true)==0)
{
{
            SetWorldTime(4);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime5", true)==0)
{
{
            SetWorldTime(5);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime6", true)==0)
{
{
            SetWorldTime(6);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime7", true)==0)
{
{
            SetWorldTime(7);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime8", true)==0)
{
{
            SetWorldTime(8);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime9", true)==0)
{
{
            SetWorldTime(9);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime10", true)==0)
{
{
            SetWorldTime(10);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime11", true)==0)
{
{
            SetWorldTime(11);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime12", true)==0)
{
{
            SetWorldTime(12);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime13", true)==0)
{
{
            SetWorldTime(13);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime14", true)==0)
{
{
            SetWorldTime(14);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime15", true)==0)
{
{
            SetWorldTime(15);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime16", true)==0)
{
{
            SetWorldTime(16);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime17", true)==0)
{
{
            SetWorldTime(17);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime18", true)==0)
{
{
            SetWorldTime(18);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime19", true)==0)
{
{
            SetWorldTime(19);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime20", true)==0)
{
{
            SetWorldTime(20);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime21", true)==0)
{
{
            SetWorldTime(21);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime22", true)==0)
{
{
            SetWorldTime(22);
                }
        return 1;
}
if (strcmp(cmdtext, "/wtime23", true)==0)
{
{
            SetWorldTime(23);
                }
        return 1;
}
//-------------------------------------------------------------------------------------------------Weaponcommands
//------------------------------------------------------------------------------------Class 1
	if (strcmp(cmdtext, "/knife", true)==0)
	{
GivePlayerWeapon(playerid,4,1);
GameTextForPlayer(playerid,"~g~knife",4000,5);
return 1;
	}

//--------------------------

	if (strcmp(cmdtext, "/baseballbat", true)==0)
	{
GivePlayerWeapon(playerid,5,1);
GameTextForPlayer(playerid,"~g~baseballbat",4000,5);
return 1;
	}

//--------------------------

	if (strcmp(cmdtext, "/flowers", true)==0)
	{
GivePlayerWeapon(playerid,14,1);
GameTextForPlayer(playerid,"~g~flowers",4000,5);
return 1;
	}

//------------------------------------------------------------------------------------------Class 2

	if (strcmp(cmdtext, "/pistol", true)==0)
	{
GivePlayerWeapon(playerid,22,100000);
GameTextForPlayer(playerid,"~y~pistol",4000,5);
return 1;
	}

//--------------------------

	if (strcmp(cmdtext, "/silenced", true)==0)
	{
GivePlayerWeapon(playerid,23,100000);
GameTextForPlayer(playerid,"~y~silenced",4000,5);
return 1;
	}

//--------------------------

	if (strcmp(cmdtext, "/dildo", true)==0)
	{
GivePlayerWeapon(playerid,10,1);
GameTextForPlayer(playerid,"~y~dildo",4000,5);
return 1;
	}

//------------------------------------------------------------------------------------------Class 3

	if (strcmp(cmdtext, "/mp5", true)==0)
	{
GivePlayerWeapon(playerid,29,100000);
GameTextForPlayer(playerid,"~r~mp5",4000,5);
return 1;
	}

//--------------------------

	if (strcmp(cmdtext, "/tec9", true)==0)
	{
GivePlayerWeapon(playerid,32,100000);
GameTextForPlayer(playerid,"~r~tec9",4000,5);
return 1;
	}

//--------------------------

	if (strcmp(cmdtext, "/uzi", true)==0)
	{
GivePlayerWeapon(playerid,28,100000);
GameTextForPlayer(playerid,"~r~uzi",4000,5);
return 1;
	}

//------------------------------------------------------------------------------------------Class 4

	if (strcmp(cmdtext, "/m4", true)==0)
	{
GivePlayerWeapon(playerid,31,100000);
GameTextForPlayer(playerid,"~p~m4",4000,5);
return 1;
	}

//--------------------------

	if (strcmp(cmdtext, "/ak47", true)==0)
	{
GivePlayerWeapon(playerid,30,100000);
GameTextForPlayer(playerid,"~p~ak47",4000,5);
return 1;
	}

//--------------------------

	if (strcmp(cmdtext, "/combat", true)==0)
	{
GivePlayerWeapon(playerid,27,100000);
GameTextForPlayer(playerid,"~p~combat",4000,5);
return 1;
	}

//------------------------------------------------------------------------------------------Class 5

	if (strcmp(cmdtext, "/sawnoff", true)==0)
	{
GivePlayerWeapon(playerid,26,100000);
GameTextForPlayer(playerid,"~b~sawnoff",4000,5);
return 1;
	}

//--------------------------

	if (strcmp(cmdtext, "/flamethrower", true)==0)
	{
GivePlayerWeapon(playerid,37,100000);
GameTextForPlayer(playerid,"~b~flamethrower",4000,5);
return 1;
	}

//--------------------------

	if (strcmp(cmdtext, "/katana", true)==0)
	{
GivePlayerWeapon(playerid,8,1);
GameTextForPlayer(playerid,"~b~katana",4000,5);
return 1;
	}
//--------------------------------------------------------------------------------------------COLOR-COMMANDS
if(strcmp(cmdtext, "/grey", true) == 0) {
SetPlayerColor(playerid, COLOR_GREY);
		return 1;
	}
if(strcmp(cmdtext, "/green", true) == 0) {
SetPlayerColor(playerid, COLOR_GREEN);
		return 1;
	}
if(strcmp(cmdtext, "/red", true) == 0) {
SetPlayerColor(playerid, COLOR_RED);
		return 1;
	}
if(strcmp(cmdtext, "/yellow", true) == 0) {
SetPlayerColor(playerid, COLOR_YELLOW);
		return 1;
	}
if(strcmp(cmdtext, "/white", true) == 0) {
SetPlayerColor(playerid, COLOR_WHITE);
		return 1;
	}
if(strcmp(cmdtext, "/blue", true) == 0) {
SetPlayerColor(playerid, COLOR_BLUE);
		return 1;
	}
if(strcmp(cmdtext, "/lblue", true) == 0) {
SetPlayerColor(playerid, COLOR_LIGHTBLUE);
		return 1;
	}
if(strcmp(cmdtext, "/orange", true) == 0) {
SetPlayerColor(playerid, COLOR_ORANGE);
		return 1;
	}
if(strcmp(cmdtext, "/black", true) == 0) {
SetPlayerColor(playerid, COLOR_BLACK);
		return 1;
	}
if(strcmp(cmdtext, "/trans", true) == 0) {
SetPlayerColor(playerid, COLOR_TRANS);
		return 1;
	}
		return 0;
}
//---------------------------------------------------------
public OnPlayerConnect(playerid)
{
	GameTextForPlayer(playerid,"~r~Movie~l~-~y~Maker~l~-~g~Mod",7000,5);
	SendClientMessage(playerid, COLOR_GREEN, "Please type /help to get started :)");
	return 1;
}

//---------------------------------------------------------

public OnPlayerRequestClass(playerid, classid)
{
	SetupPlayerForClassSelection(playerid);
	return 1;
}

//---------------------------------------------------------
public OnPlayerDeath(playerid, killerid, reason)
{
	new name[MAX_PLAYER_NAME+1];
	new string[256];
	GetPlayerName(playerid, name, sizeof(name));
	format(string, sizeof(string), "*** %s died.", name, reason);
	SendClientMessageToAll(COLOR_RED, string);
 	return 1;
}
//---------------------------------------------------------
SetupPlayerForClassSelection(playerid)
{
 	SetPlayerInterior(playerid,0);
	SetPlayerPos(playerid,1256.1487,-791.2058,92.0313);
	SetPlayerFacingAngle(playerid, 28.4421);
	SetPlayerCameraPos(playerid,1254.3755,-787.7794,92.0302);
	SetPlayerCameraLookAt(playerid,1256.1487,-791.2058,92.0313);
}
//---------------------------------------------------------
public OnPlayerSpawn(playerid)
{
 	SetPlayerCheckpoint(playerid,1378.6001,-2241.1985,13.5469,4.0);
 	GivePlayerMoney(playerid,100000);
	return 1;
}

//---------------------------------------------------------
public OnPlayerEnterCheckpoint(playerid)
{
SetPlayerHealth(playerid,100);
	    return;
	}

//---------------------------------------------------------

public GameModeExitFunc() {
	GameModeExit();
}
