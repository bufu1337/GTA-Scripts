// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>
#define MAX_ENTER 24
#define COLOR_YELLOW 0xFFFF00AA

enum entr{
	Float:EX,
	Float:EY,
	Float:EZ,
	Float:EA,
	teleto
};
new Float:Entrence[MAX_ENTER][entr] = {
	{9.35, -3986.8, 1003.53, 180.0, 1},
	{1743.0, -1864.2, 13.57, 0.0, 0},
	{9.35, -4031.9, 1003.52, 0.0, 3},
	{1743.0, -1943.6, 13.57, 180.0, 2},
	{17.2, -3991.7, 1003.53, 90.0, 5},
	{1752.7, -1894.1, 13.57, 270.0, 4},
	{17.2, -4000.65, 1003.53, 90.0, 7},
	{1752.7, -1903.1, 13.57, 270.0, 6},
	{17.2, -4009.6, 1003.53, 90.0, 9},
	{1752.7, -1912.1, 13.57, 270.0, 8},
	{17.2, -4018.55, 1003.53, 90.0, 11},
	{1752.7, -1921.1, 13.57, 270.0, 10},
	{17.2, -4027.5, 1003.53, 90.0, 13},
	{1752.7, -1930.1, 13.57, 270.0, 12},
	{1.1, -3991.7, 1003.53, 270.0, 15},
	{1733.45, -1894.1, 13.57, 90.0, 14},
	{1.1, -4000.65, 1003.53, 270.0, 17},
	{1733.45, -1903.1, 13.57, 90.0, 16},
	{1.1, -4009.6, 1003.53, 270.0, 19},
	{1733.45, -1912.1, 13.57, 90.0, 18},
	{1.1, -4018.55, 1003.53, 270.0, 21},
	{1733.45, -1921.1, 13.57, 90.0, 20},
	{1.1, -4027.5, 1003.53, 270.0, 23},
 	{1733.45, -1930.1, 13.57, 90.0, 22}
};
main()
{
}

public OnGameModeInit()
{
	SetGameModeText("Blank Script");
	AddPlayerClass(0, 9.35, -3986.20, 3.53, 180.0, 0, 0, 0, 0, 0, 0);
	
	CreateObject(11568, -3.12, -3986.95, 982, 90, 270, 50);
	CreateObject(11568, -3.12, -3995.9, 982, 90, 270, 50);
	CreateObject(11568, -3.12, -4004.85, 982, 90, 270, 50);
	CreateObject(11568, -3.12, -4013.8, 982, 90, 270, 50);
	CreateObject(11568, -3.12, -4022.75, 982, 90, 270, 50);
	CreateObject(11568, -3.61, -3995.85, 982, 90, 270, 130);
	CreateObject(11568, -3.61, -4004.8, 982, 90, 270, 130);
	CreateObject(11568, -3.61, -4013.75, 982, 90, 270, 130);
	CreateObject(11568, -3.61, -4022.7, 982, 90, 270, 130);
	CreateObject(11568, -3.61, -4031.65, 982, 90, 270, 130);
	CreateObject(11568, -4, -3986.24, 982, 90, 270, 90);
	CreateObject(11568, -4, -3987.43, 982, 90, 270, 90);
	CreateObject(11568, -4, -3988.62, 982, 90, 270, 90);
	CreateObject(11568, -4, -3994, 982, 90, 270, 90);
	CreateObject(11568, -4, -3995.19, 982, 90, 270, 90);
	CreateObject(11568, -4, -3996.38, 982, 90, 270, 90);
	CreateObject(11568, -4, -3997.57, 982, 90, 270, 90);
	CreateObject(11568, -4, -4002.95, 982, 90, 270, 90);
	CreateObject(11568, -4, -4004.14, 982, 90, 270, 90);
	CreateObject(11568, -4, -4005.33, 982, 90, 270, 90);
	CreateObject(11568, -4, -4006.52, 982, 90, 270, 90);
	CreateObject(11568, -4, -4011.9, 982, 90, 270, 90);
	CreateObject(11568, -4, -4013.09, 982, 90, 270, 90);
	CreateObject(11568, -4, -4014.28, 982, 90, 270, 90);
	CreateObject(11568, -4, -4015.47, 982, 90, 270, 90);
	CreateObject(11568, -4, -4020.85, 982, 90, 270, 90);
	CreateObject(11568, -4, -4022.04, 982, 90, 270, 90);
	CreateObject(11568, -4, -4023.23, 982, 90, 270, 90);
	CreateObject(11568, -4, -4024.42, 982, 90, 270, 90);
	CreateObject(11568, -4, -4029.8, 982, 90, 270, 90);
	CreateObject(11568, -4, -4030.99, 982, 90, 270, 90);
	CreateObject(11568, -4, -4032.18, 982, 90, 270, 90);
	CreateObject(11568, 0.57, -4037.3, 990, 90, 270, 180);
	CreateObject(11568, 1.34, -3981.9, 982, 90, 270, 0);
	CreateObject(11568, 1.76, -4037.3, 990, 90, 270, 180);
	CreateObject(11568, 13.59, -4037.3, 990, 90, 270, 180);
	CreateObject(11568, 14.21, -3981.9, 982, 90, 270, 0);
	CreateObject(11568, 14.78, -4037.3, 990, 90, 270, 180);
	CreateObject(11568, 15.4, -3981.9, 982, 90, 270, 0);
	CreateObject(11568, 15.97, -4037.3, 990, 90, 270, 180);
	CreateObject(11568, 16.59, -3981.9, 982, 90, 270, 0);
	CreateObject(11568, 17.16, -4037.3, 990, 90, 270, 180);
	CreateObject(11568, 17.78, -3981.9, 982, 90, 270, 0);
	CreateObject(11568, 2.53, -3981.9, 982, 90, 270, 0);
	CreateObject(11568, 2.95, -4037.3, 990, 90, 270, 180);
	CreateObject(11568, 21.44, -3996.45, 982, 90, 270, 230);
	CreateObject(11568, 21.44, -4005.4, 982, 90, 270, 230);
	CreateObject(11568, 21.44, -4014.35, 982, 90, 270, 230);
	CreateObject(11568, 21.44, -4023.3, 982, 90, 270, 230);
	CreateObject(11568, 21.44, -4032.25, 982, 90, 270, 230);
	CreateObject(11568, 21.94, -3987.56, 982, 90, 270, 310);
	CreateObject(11568, 21.94, -3996.51, 982, 90, 270, 310);
	CreateObject(11568, 21.94, -4005.46, 982, 90, 270, 310);
	CreateObject(11568, 21.94, -4014.41, 982, 90, 270, 310);
	CreateObject(11568, 21.94, -4023.36, 982, 90, 270, 310);
	CreateObject(11568, 22.33, -3987.02, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -3988.21, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -3989.4, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -3994.78, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -3995.97, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -3997.16, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -3998.35, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -4003.73, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -4004.92, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -4006.11, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -4007.3, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -4012.68, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -4013.87, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -4015.06, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -4016.25, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -4021.63, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -4022.82, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -4024.01, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -4025.2, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -4030.58, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -4031.77, 982, 90, 270, 270);
	CreateObject(11568, 22.33, -4032.96, 982, 90, 270, 270);
	CreateObject(11568, 3.72, -3981.9, 982, 90, 270, 0);
	CreateObject(11568, 4.07, -4037.31, 990, 90, 270, 180);
	CreateObject(11568, 4.91, -3981.9, 982, 90, 270, 0);
	CreateObject(1235, 11.15, -3993.7, 1003.02, 0, 0, 0);
	CreateObject(1235, 11.15, -4002.65, 1003.02, 0, 0, 0);
	CreateObject(1235, 11.15, -4011.6, 1003.02, 0, 0, 0);
	CreateObject(1235, 11.15, -4020.55, 1003.02, 0, 0, 0);
	CreateObject(1235, 7.3, -4009, 1003.02, 0, 0, 0);
	CreateObject(1235, 7.3, -4019.2, 1003.02, 0, 0, 0);
	CreateObject(1360, 4.8, -4014.06, 1003.27, 0, 0, 90);
	CreateObject(14629, 14.56, -3978.7, 1011, 0, 0, 0);
	CreateObject(14629, 14.56, -4002.17, 1011, 0, 0, 0);
	CreateObject(14629, 14.56, -4010, 1011, 0, 0, 0);
	CreateObject(14834, 0.95, -4032.28, 1002.81, 0, 0, 0);
	CreateObject(14834, 17.38, -4032.28, 1002.81, 0, 0, 90);
	CreateObject(14834, 17.4, -3986.83, 1002.81, 0, 0, 180);
	CreateObject(1549, 11.23, -3998.43, 1002.53, 0, 0, 0);
	CreateObject(1549, 11.23, -4007.38, 1002.53, 0, 0, 0);
	CreateObject(1549, 11.23, -4016.33, 1002.53, 0, 0, 0);
	CreateObject(1549, 11.23, -4025.28, 1002.53, 0, 0, 0);
	CreateObject(1549, 3.7, -4008.9, 1002.53, 0, 0, 0);
	CreateObject(1549, 3.7, -4019.3, 1002.53, 0, 0, 0);
	CreateObject(1557, 10.86, -3985.6, 1002.5, 0, 0, 180);
	CreateObject(1557, 10.86, -4032.93, 1002.5, 0, 0, 180);
	CreateObject(1557, 7.83, -3985.6, 1002.5, 0, 0, 0);
	CreateObject(1557, 7.83, -4032.93, 1002.5, 0, 0, 0);
	CreateObject(1651, 3.64, -3995.91, 1002.47, 0, 0, 269.9);
	CreateObject(1703, 15.7, -3995.18, 1002.53, 0, 0, 270);
	CreateObject(1703, 15.7, -4004.13, 1002.53, 0, 0, 270);
	CreateObject(1703, 15.7, -4013.08, 1002.53, 0, 0, 270);
	CreateObject(1703, 15.7, -4022.03, 1002.53, 0, 0, 270);
	CreateObject(1713, 4.61, -4009.08, 1002.51, 0, 0, 0);
	CreateObject(1713, 4.61, -4026.97, 1002.51, 0, 0, 0);
	CreateObject(1713, 6.25, -4001.22, 1002.51, 0, 0, 180);
	CreateObject(1713, 6.25, -4019.1, 1002.51, 0, 0, 180);
	CreateObject(1723, 0.9, -4006.14, 1002.53, 0, 0, 90);
	CreateObject(1723, 0.9, -4024.03, 1002.53, 0, 0, 90);
	CreateObject(1723, 12.2, -3993.66, 1002.53, 0, 0, 0);
	CreateObject(1723, 12.2, -4002.61, 1002.53, 0, 0, 0);
	CreateObject(1723, 12.2, -4011.56, 1002.53, 0, 0, 0);
	CreateObject(1723, 12.2, -4020.51, 1002.53, 0, 0, 0);
	CreateObject(1723, 14.21, -3998.6, 1002.53, 0, 0, 180);
	CreateObject(1723, 14.21, -4007.55, 1002.53, 0, 0, 180);
	CreateObject(1723, 14.21, -4016.5, 1002.53, 0, 0, 180);
	CreateObject(1723, 14.21, -4025.45, 1002.53, 0, 0, 180);
	CreateObject(1723, 2.8, -4013.05, 1002.53, 0, 0, 270);
	CreateObject(1723, 3.76, -4015.09, 1002.53, 0, 0, 0);
	CreateObject(1723, 5.78, -4013.03, 1002.53, 0, 0, 180);
	CreateObject(1723, 6.75, -4015.07, 1002.53, 0, 0, 90);
	CreateObject(1843, -1.6, -4002.99, 1011.7, 0, 90, 0);
	CreateObject(1844, -1.6, -3989.27, 1011.7, 180, 90, 0);
	CreateObject(1844, -1.6, -3994.04, 1011.7, 0, 90, 0);
	CreateObject(1844, -1.6, -3998.22, 1011.7, 180, 90, 0);
	CreateObject(1844, -1.6, -4007.17, 1011.7, 180, 90, 0);
	CreateObject(1844, -1.6, -4011.94, 1011.7, 0, 90, 0);
	CreateObject(1844, -1.6, -4016.12, 1011.7, 180, 90, 0);
	CreateObject(1844, -1.6, -4020.89, 1011.7, 0, 90, 0);
	CreateObject(1844, -1.6, -4025.07, 1011.7, 180, 90, 0);
	CreateObject(1844, -1.6, -4029.84, 1011.7, 0, 90, 0);
	CreateObject(1844, 19.94, -3989.28, 1011.7, 0, 90, 180);
	CreateObject(1844, 19.94, -3994.05, 1011.7, 180, 90, 180);
	CreateObject(1844, 19.94, -3998.23, 1011.7, 0, 90, 180);
	CreateObject(1844, 19.94, -4003, 1011.7, 180, 90, 180);
	CreateObject(1844, 19.94, -4007.18, 1011.7, 0, 90, 180);
	CreateObject(1844, 19.94, -4011.95, 1011.7, 180, 90, 180);
	CreateObject(1844, 19.94, -4016.13, 1011.7, 0, 90, 180);
	CreateObject(1844, 19.94, -4020.9, 1011.7, 180, 90, 180);
	CreateObject(1844, 19.94, -4025.08, 1011.7, 0, 90, 180);
	CreateObject(1844, 19.94, -4029.85, 1011.7, 180, 90, 180);
	CreateObject(1847, -1.6, -3989.27, 1008.46, 180, 90, 0);
	CreateObject(1847, -1.6, -3991.65, 1013.62, 270, 90, 0);
	CreateObject(1847, -1.6, -3994.04, 1008.46, 0, 90, 0);
	CreateObject(1847, -1.6, -3998.22, 1008.46, 180, 90, 0);
	CreateObject(1847, -1.6, -4000.6, 1013.62, 270, 90, 0);
	CreateObject(1847, -1.6, -4002.99, 1008.46, 0, 90, 0);
	CreateObject(1847, -1.6, -4007.17, 1008.46, 180, 90, 0);
	CreateObject(1847, -1.6, -4009.55, 1013.62, 270, 90, 0);
	CreateObject(1847, -1.6, -4011.94, 1008.46, 0, 90, 0);
	CreateObject(1847, -1.6, -4016.12, 1008.46, 180, 90, 0);
	CreateObject(1847, -1.6, -4018.5, 1013.62, 270, 90, 0);
	CreateObject(1847, -1.6, -4020.89, 1008.46, 0, 90, 0);
	CreateObject(1847, -1.6, -4025.07, 1008.46, 180, 90, 0);
	CreateObject(1847, -1.6, -4027.45, 1013.62, 270, 90, 0);
	CreateObject(1847, -1.6, -4029.84, 1008.46, 0, 90, 0);
	CreateObject(1847, -1.61, -3987.15, 1006.5, 270, 90, 0);
	CreateObject(1847, -1.61, -3996.1, 1006.5, 270, 90, 0);
	CreateObject(1847, -1.61, -4005.05, 1006.5, 270, 90, 0);
	CreateObject(1847, -1.61, -4014, 1006.5, 270, 90, 0);
	CreateObject(1847, -1.61, -4022.95, 1006.5, 270, 90, 0);
	CreateObject(1847, -1.61, -4031.9, 1006.5, 270, 90, 0);
	CreateObject(1847, 15.73, -3984.31, 1006.5, 270, 90, 270);
	CreateObject(1847, 15.87, -4034.85, 1006.5, 270, 90, 90);
	CreateObject(1847, 19.94, -3989.28, 1008.46, 0, 90, 180);
	CreateObject(1847, 19.94, -3994.05, 1008.46, 180, 90, 180);
	CreateObject(1847, 19.94, -3998.23, 1008.46, 0, 90, 180);
	CreateObject(1847, 19.94, -4003, 1008.46, 180, 90, 180);
	CreateObject(1847, 19.94, -4007.18, 1008.46, 0, 90, 180);
	CreateObject(1847, 19.94, -4011.95, 1008.46, 180, 90, 180);
	CreateObject(1847, 19.94, -4016.13, 1008.46, 0, 90, 180);
	CreateObject(1847, 19.94, -4020.9, 1008.46, 180, 90, 180);
	CreateObject(1847, 19.94, -4025.08, 1008.46, 0, 90, 180);
	CreateObject(1847, 19.94, -4029.85, 1008.46, 180, 90, 180);
	CreateObject(1847, 19.95, -3987.15, 1006.5, 270, 90, 180);
	CreateObject(1847, 19.95, -3991.67, 1013.62, 270, 90, 180);
	CreateObject(1847, 19.95, -3996.1, 1006.5, 270, 90, 180);
	CreateObject(1847, 19.95, -4000.62, 1013.62, 270, 90, 180);
	CreateObject(1847, 19.95, -4005.05, 1006.5, 270, 90, 180);
	CreateObject(1847, 19.95, -4009.57, 1013.62, 270, 90, 180);
	CreateObject(1847, 19.95, -4014, 1006.5, 270, 90, 180);
	CreateObject(1847, 19.95, -4018.52, 1013.62, 270, 90, 180);
	CreateObject(1847, 19.95, -4022.95, 1006.5, 270, 90, 180);
	CreateObject(1847, 19.95, -4027.47, 1013.62, 270, 90, 180);
	CreateObject(1847, 19.95, -4031.9, 1006.5, 270, 90, 180);
	CreateObject(1847, 2.56, -4034.85, 1006.5, 270, 90, 90);
	CreateObject(1847, 2.63, -3984.31, 1006.5, 270, 90, 270);
	CreateObject(18766, 2.87, -3991.16, 1005.69, 270, 0, 90);
	CreateObject(18865, 2.75, -3986.75, 1003.4, 0, 0, 0);
	CreateObject(18866, 3.3, -3986.75, 1003.4, 0, 0, 0);
	CreateObject(18867, 3.85, -3986.75, 1003.4, 0, 0, 0);
	CreateObject(18868, 4.62, -3987.15, 1003.4, 0, 0, 270);
	CreateObject(18869, 4.62, -3987.7, 1003.4, 0, 0, 270);
	CreateObject(18870, 4.62, -3988.6, 1003.4, 0, 0, 270);
	CreateObject(18871, 4.62, -3989.15, 1003.4, 0, 0, 270);
	CreateObject(18872, 4.62, -3986.6, 1003.4, 0, 0, 270);
	CreateObject(18874, 1.9, -3986.75, 1003.4, 0, 0, 0);
	CreateObject(18875, 0.7, -3986.75, 1003.42, 0, 0, 0);
	CreateObject(19039, 4.63, -3992.4, 1003.4, 0, 0, 100);
	CreateObject(19040, 4.63, -3992.8, 1003.4, 0, 0, 100);
	CreateObject(19041, 4.63, -3993.2, 1003.4, 0, 0, 100);
	CreateObject(19042, 4.63, -3993.6, 1003.4, 0, 0, 100);
	CreateObject(19043, 4.63, -3994.38, 1003.4, 0, 0, 100);
	CreateObject(19044, 4.63, -3994.78, 1003.4, 0, 0, 100);
	CreateObject(19045, 4.63, -3995.18, 1003.4, 0, 0, 100);
	CreateObject(19046, 3.9, -3995.48, 1003.4, 0, 0, 10);
	CreateObject(19047, 3.5, -3995.48, 1003.4, 0, 0, 10);
	CreateObject(19048, 3.1, -3995.48, 1003.4, 0, 0, 10);
	CreateObject(19049, 2.7, -3995.48, 1003.4, 0, 0, 10);
	CreateObject(19050, 1.95, -3995.48, 1003.4, 0, 0, 10);
	CreateObject(19051, 1.55, -3995.48, 1003.4, 0, 0, 10);
	CreateObject(19052, 1.15, -3995.48, 1003.4, 0, 0, 10);
	CreateObject(19053, 0.75, -3995.48, 1003.4, 0, 0, 10);
	CreateObject(19171, 17.96, -4005.1, 1004.2, 90, 0, 270);
	CreateObject(19172, 0.38, -4014.05, 1004.1, 0, 0, 90);
	CreateObject(19176, 0, -3991.7, 1004, 0, 0, 90);
	CreateObject(19176, 0, -4000.65, 1004, 0, 0, 90);
	CreateObject(19176, 0, -4009.6, 1004, 0, 0, 90);
	CreateObject(19176, 0, -4018.55, 1004, 0, 0, 90);
	CreateObject(19176, 0, -4027.5, 1004, 0, 0, 90);
	CreateObject(19176, 18.3, -3991.7, 1004, 0, 0, 270);
	CreateObject(19176, 18.3, -4000.65, 1004, 0, 0, 270);
	CreateObject(19176, 18.3, -4009.6, 1004, 0, 0, 270);
	CreateObject(19176, 18.3, -4018.55, 1004, 0, 0, 270);
	CreateObject(19176, 18.3, -4027.5, 1004, 0, 0, 270);
	CreateObject(2311, 12.5, -3995.72, 1002.51, 0, 0, 0);
	CreateObject(2311, 12.5, -3996.66, 1002.51, 0, 0, 0);
	CreateObject(2311, 12.5, -4004.67, 1002.51, 0, 0, 0);
	CreateObject(2311, 12.5, -4005.61, 1002.51, 0, 0, 0);
	CreateObject(2311, 12.5, -4013.62, 1002.51, 0, 0, 0);
	CreateObject(2311, 12.5, -4014.56, 1002.51, 0, 0, 0);
	CreateObject(2311, 12.5, -4022.57, 1002.51, 0, 0, 0);
	CreateObject(2311, 12.5, -4023.51, 1002.51, 0, 0, 0);
	CreateObject(2433, 0.86, -3986.6, 1002.53, 0, 0, 0);
	CreateObject(2433, 1.86, -3995.58, 1002.52, 0, 0, 180);
	CreateObject(2433, 2.8, -3986.6, 1002.53, 0, 0, 0);
	CreateObject(2433, 3.8, -3995.58, 1002.52, 0, 0, 180);
	CreateObject(2433, 4.75, -3986.75, 1002.53, 0, 0, 270);
	CreateObject(2433, 4.75, -3988.69, 1002.53, 0, 0, 270);
	CreateObject(2433, 4.75, -3992.5, 1002.53, 0, 0, 270);
	CreateObject(2433, 4.75, -3994.44, 1002.53, 0, 0, 270);
	CreateObject(2654, 3.3, -3986.75, 1003.02, 0, 0, 90);
	CreateObject(2654, 3.3, -3995.5, 1003.02, 0, 0, 90);
	CreateObject(2654, 4.6, -3992.95, 1003.02, 0, 0, 0);
	CreateObject(2654, 4.65, -3989.2, 1003.02, 0, 0, 180);
	CreateObject(2833, 10.4, -3987.09, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -3989.06, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -3991.03, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -3993, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -3994.97, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -3996.94, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -3998.91, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -4000.88, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -4002.85, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -4004.82, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -4006.79, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -4008.76, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -4010.73, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -4012.7, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -4014.67, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -4016.64, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -4018.61, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -4020.58, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -4022.55, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -4024.52, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -4026.49, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -4028.46, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -4030.43, 1002.52, 0, 0, 90);
	CreateObject(2833, 10.4, -4032.4, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -3987.09, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -3989.06, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -3991.03, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -3993, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -3994.97, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -3996.94, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -3998.91, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -4000.88, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -4002.85, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -4004.82, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -4006.79, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -4008.76, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -4010.73, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -4012.7, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -4014.67, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -4016.64, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -4018.61, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -4020.58, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -4022.55, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -4024.52, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -4026.49, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -4028.46, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -4030.43, 1002.52, 0, 0, 90);
	CreateObject(2833, 9.3, -4032.4, 1002.52, 0, 0, 90);
	CreateObject(2966, 1.1, -3986.85, 1003.42, 0, 0, 0);
	CreateObject(2967, 1.5, -3986.75, 1003.4, 0, 0, 0);
	CreateObject(3278, 0, -3991.05, 1011.6, 0, 0, 90);
	CreateObject(3278, 0, -3991.05, 1008.6, 0, 0, 90);
	CreateObject(3278, 0, -3992.27, 1011.6, 0, 0, 90);
	CreateObject(3278, 0, -3992.27, 1008.6, 0, 0, 90);
	CreateObject(3278, 0, -4000, 1011.6, 0, 0, 90);
	CreateObject(3278, 0, -4000, 1008.6, 0, 0, 90);
	CreateObject(3278, 0, -4001.22, 1011.6, 0, 0, 90);
	CreateObject(3278, 0, -4001.22, 1008.6, 0, 0, 90);
	CreateObject(3278, 0, -4008.95, 1011.6, 0, 0, 90);
	CreateObject(3278, 0, -4008.95, 1008.6, 0, 0, 90);
	CreateObject(3278, 0, -4010.17, 1011.6, 0, 0, 90);
	CreateObject(3278, 0, -4010.17, 1008.6, 0, 0, 90);
	CreateObject(3278, 0, -4017.9, 1011.6, 0, 0, 90);
	CreateObject(3278, 0, -4017.9, 1008.6, 0, 0, 90);
	CreateObject(3278, 0, -4019.12, 1011.6, 0, 0, 90);
	CreateObject(3278, 0, -4019.12, 1008.6, 0, 0, 90);
	CreateObject(3278, 0, -4026.85, 1011.6, 0, 0, 90);
	CreateObject(3278, 0, -4026.85, 1008.6, 0, 0, 90);
	CreateObject(3278, 0, -4028.07, 1011.6, 0, 0, 90);
	CreateObject(3278, 0, -4028.07, 1008.6, 0, 0, 90);
	CreateObject(3278, 18.3, -3991.05, 1011.6, 0, 0, 270);
	CreateObject(3278, 18.3, -3991.05, 1008.6, 0, 0, 270);
	CreateObject(3278, 18.3, -3992.27, 1011.6, 0, 0, 270);
	CreateObject(3278, 18.3, -3992.27, 1008.6, 0, 0, 270);
	CreateObject(3278, 18.3, -4000, 1011.6, 0, 0, 270);
	CreateObject(3278, 18.3, -4000, 1008.6, 0, 0, 270);
	CreateObject(3278, 18.3, -4001.22, 1011.6, 0, 0, 270);
	CreateObject(3278, 18.3, -4001.22, 1008.6, 0, 0, 270);
	CreateObject(3278, 18.3, -4008.95, 1011.6, 0, 0, 270);
	CreateObject(3278, 18.3, -4008.95, 1008.6, 0, 0, 270);
	CreateObject(3278, 18.3, -4010.17, 1011.6, 0, 0, 270);
	CreateObject(3278, 18.3, -4010.17, 1008.6, 0, 0, 270);
	CreateObject(3278, 18.3, -4017.9, 1011.6, 0, 0, 270);
	CreateObject(3278, 18.3, -4017.9, 1008.6, 0, 0, 270);
	CreateObject(3278, 18.3, -4019.12, 1011.6, 0, 0, 270);
	CreateObject(3278, 18.3, -4019.12, 1008.6, 0, 0, 270);
	CreateObject(3278, 18.3, -4026.85, 1011.6, 0, 0, 270);
	CreateObject(3278, 18.3, -4026.85, 1008.6, 0, 0, 270);
	CreateObject(3278, 18.3, -4028.07, 1011.6, 0, 0, 270);
	CreateObject(3278, 18.3, -4028.07, 1008.6, 0, 0, 270);
	CreateObject(3503, 0.4, -3995.89, 1003.86, 0, 0, 0);
	CreateObject(3503, 5.07, -3990.14, 1003.86, 0, 0, 0);
	CreateObject(3503, 5.07, -3992.03, 1003.86, 0, 0, 0);
	CreateObject(3503, 5.07, -3995.89, 1003.86, 0, 0, 0);
	CreateObject(3503, 5.11, -3986.3, 1003.86, 0, 0, 0);
	CreateObject(3921, 4.9, -4005.15, 1003.06, 0, 0, 0);
	CreateObject(3921, 4.9, -4023.04, 1003.06, 0, 0, 0);
	CreateObject(3921, 5.97, -4005.15, 1003.06, 0, 0, 180);
	CreateObject(3921, 5.97, -4023.04, 1003.06, 0, 0, 180);
	CreateObject(4141, 1.5, -4009.7, 975.3, 270, 90, 90);
	CreateObject(4141, 1.5, -4044.4, 975.29, 270, 90, 90);
	CreateObject(5033, 39.5, -3981.05, 1016.08, 0, 0, 0);
	CreateObject(626, 7.3, -3986.6, 1004.57, 0, 0, 0);
	CreateObject(627, 12, -4032, 1004.31, 0, 0, 0);
	CreateObject(632, 12.5, -3986.5, 1002.98, 0, 0, 0);
	CreateObject(638, 2.7, -3996.29, 1003.22, 0, 0, 90);
	CreateObject(638, 5.45, -3988.3, 1003.22, 0, 0, 0);
	CreateObject(638, 5.45, -3993.9, 1003.22, 0, 0, 0);
	CreateObject(644, 6.3, -4032, 1002.82, 0, 0, 0);
	CreateObject(6989, -16.5, -4017.12, 976.61, 0, 0, 90);
	CreateObject(6989, 2.65, -4116.11, 976.61, 0, 0, 90);
	CreateObject(6989, 4.65, -3902.44, 976.61, 0, 0, 270);
	CreateObject(6989, 44.5, -4017.12, 976.61, 0, 0, 90);
	CreateObject(8187, -24.61, -3983.12, 1008.6, 0, 0, 90);
	CreateObject(8187, -24.91, -3936.1, 1008.23, 0, 0, 90);
	CreateObject(8187, -49.82, -3987.2, 1036.5, 90, 90, 90);
	CreateObject(8187, -49.82, -3996.05, 1036.5, 90, 90, 90);
	CreateObject(8187, -49.82, -4005, 1036.5, 90, 90, 90);
	CreateObject(8187, -49.82, -4013.95, 1036.5, 90, 90, 90);
	CreateObject(8187, -49.82, -4022.9, 1036.5, 90, 90, 90);
	CreateObject(8187, -49.82, -4031.85, 1036.5, 90, 90, 90);
	CreateObject(8187, 10.39, -3983.1, 1015.83, 0, 0, 90);
	CreateObject(8187, 43.02, -3983.12, 1008.4, 180, 0, 90);
	CreateObject(8187, 43.25, -3936.1, 1008.2, 180, 0, 90);
	CreateObject(8187, 68.16, -3987.3, 1036.5, 90, 90, 270);
	CreateObject(8187, 68.16, -3996.25, 1036.5, 90, 90, 270);
	CreateObject(8187, 68.16, -4005.2, 1036.5, 90, 90, 270);
	CreateObject(8187, 68.16, -4014.15, 1036.5, 90, 90, 270);
	CreateObject(8187, 68.16, -4023.1, 1036.5, 90, 90, 270);
	CreateObject(8187, 68.16, -4031.95, 1036.5, 90, 90, 270);
	CreateObject(8187, 7.95, -4036.66, 1015.83, 0, 0, 270);
	CreateObject(8187, 8.9, -3983.11, 1012.4, 0, 0, 90);
	CreateObject(8187, 8.9, -3983.13, 1010, 0, 0, 90);
	CreateObject(8187, 8.95, -4036.65, 1012, 0, 0, 270);
	CreateObject(8395, -66.4, -4004.47, 1027.8, 140, 0, 270);
	CreateObject(8395, 85, -4011.2, 1027.8, 140, 0, 90);
	CreateObject(8651, -0.28, -4000, 1006.45, 180, 0, 180);
	CreateObject(8651, -0.31, -4018.75, 1006.45, 180, 0, 180);
	CreateObject(8651, 18.42, -4000, 1006.45, 180, 0, 180);
	CreateObject(8651, 18.64, -4018.75, 1006.45, 180, 0, 0);
	CreateObject(948, 0.9, -4003.2, 1002.51, 0, 0, 0);
	CreateObject(948, 0.9, -4024.99, 1002.51, 0, 0, 0);
	CreateObject(955, 0.85, -3997.7, 1002.93, 0, 0, 90);
	CreateObject(955, 15, -4032.49, 1002.93, 0, 0, 180);
	CreateObject(956, 15, -3986.64, 1002.93, 0, 0, 0);
	CreateObject(956, 3.3, -4032.49, 1002.93, 0, 0, 180);
	CreateObject(1959, 4.65, -3989.82, 1003.57, 0, 0, 270);
	CreateObject(2412, 4.34, -3991.55, 1002.53, 0, 0, 90);
	CreateObject(2412, 4.34, -3989.94, 1002.53, 0, 0, 90);


	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1743.0, -1864.2, 13.57);
	SetPlayerCameraPos(playerid, 1743.0, -1864.2, 13.57);
	SetPlayerCameraLookAt(playerid, 1743.0, -1864.2, 13.57);
	return 1;
}
public OnPlayerConnect(playerid)
{
return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[255];
	new tmp[255];
	new idx;
	cmd = strtok(cmdtext, idx);
	if(strcmp("/getpos", cmd, true) == 0){
		new Float:xp,Float:yp,Float:zp,Float:ap;
		GetPlayerPos(playerid, xp, yp, zp);
		GetPlayerFacingAngle(playerid, ap);
	    format(tmp,255,"Position: X: %.4f   Y: %.4f   Z: %.4f   Angle: %.4f", xp,yp,zp,ap);
		SendClientMessage(playerid, COLOR_YELLOW, tmp);
		return 1;
	}
	if(strcmp(cmd,"/setpos", true) == 0){
		new Float:xp,Float:yp,Float:zp,Float:ap;
		new Float:xx,Float:yy,Float:zz;
		new tmpp[255];
		GetPlayerPos(playerid, xp, yp, zp);
		GetPlayerFacingAngle(playerid, ap);
	    tmp = strtok(cmdtext,idx);
		xx = strval(tmp);
		tmp = strtok(cmdtext,idx);
		yy = strval(tmp);
		tmp = strtok(cmdtext,idx);
		zz = strval(tmp);
		SetPlayerPos(playerid, xp+xx,yp+yy,zp+zz);
	    format(tmpp,255,"Position: X: %.4f   Y: %.4f   Z: %.4f   Angle: %.4f", xp+xx,yp+yy,zp+zz,ap);
		SendClientMessage(playerid, COLOR_YELLOW, tmp);
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_SECONDARY_ATTACK && !IsPlayerInAnyVehicle(playerid))
	{
	    for(new i = 0; i < MAX_ENTER; i++)
	    {
	        if(IsPlayerInRangeOfPoint(playerid,0.9, Entrence[i][EX], Entrence[i][EY], Entrence[i][EZ]))
	        {
         		SetPlayerPos(playerid, Entrence[Entrence[i][teleto]][EX], Entrence[Entrence[i][teleto]][EY], Entrence[Entrence[i][teleto]][EZ]);
				SetPlayerFacingAngle(playerid, Entrence[Entrence[i][teleto]][EA]);
				SetCameraBehindPlayer(playerid);
				return 1;
	        }
	    }
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
strtok(const string[], &index){
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
