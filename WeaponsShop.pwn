#include <a_samp>
#include <zcmd>
//-------------------------- Configurations (Weapons prices) --------------------//
//1.SMG's.
#define UZI_PRICE  			(3000)
#define UZI_AMMO  			(150)
#define TEC9_PRICE  		(3000)
#define TEC9_AMMO  			(150)

//2.Pistols
#define Deagle_PRICE  		(1000)
#define Deagle_AMMO  		(200)
#define S9mm_PRICE  		(1000)
#define S9mm_AMMO  			(200)
#define P9mm_PRICE  		(1000)
#define P9mm_AMMO  			(200)

//3.Shotguns
#define Swanoff_PRICE  		(5000)
#define Swanoff_AMMO  		(150)
#define Combat_PRICE  		(5000)
#define Combat_AMMO  		(150)

//4.Rifles
#define M4_PRICE  			(2000)
#define M4_AMMO  			(300)
#define AK47_PRICE  		(2000)
#define AK47_AMMO  			(300)
#define Sniper_PRICE  		(2000)
#define Sniper_AMMO  		(2000)
#define Country_PRICE  		(2000)
#define Country_AMMO  		(2000)

//5.Extra
#define Grenade_PRICE  		(6000)
#define Grenade_AMMO 		(20)
#define Molotov_PRICE  		(5000)
#define Molotov_AMMO 		(20)
#define Knife_PRICE  		(500)
#define Knife_AMMO  		(1)
#define Teargas_PRICE  		(500)
#define Teargas_AMMO  		(20)

/////////////////////Textdraws variables//////////////////////
new PlayerText:Textdraw0[MAX_PLAYERS];
new PlayerText:Textdraw1[MAX_PLAYERS];
new PlayerText:Textdraw2[MAX_PLAYERS];
new PlayerText:Textdraw3[MAX_PLAYERS];
new PlayerText:Textdraw4[MAX_PLAYERS];
new PlayerText:Textdraw5[MAX_PLAYERS];
new PlayerText:Textdraw6[MAX_PLAYERS];
new PlayerText:Textdraw7[MAX_PLAYERS];
new PlayerText:Textdraw8[MAX_PLAYERS];
new PlayerText:Textdraw9[MAX_PLAYERS];
new PlayerText:Textdraw10[MAX_PLAYERS];
new PlayerText:Textdraw11[MAX_PLAYERS];
new PlayerText:Textdraw12[MAX_PLAYERS];
new PlayerText:Textdraw13[MAX_PLAYERS];
new PlayerText:Textdraw14[MAX_PLAYERS];
new PlayerText:Textdraw15[MAX_PLAYERS];
new PlayerText:Textdraw16[MAX_PLAYERS];
new PlayerText:Textdraw17[MAX_PLAYERS];
new PlayerText:Textdraw18[MAX_PLAYERS];
new PlayerText:Textdraw19[MAX_PLAYERS];
new PlayerText:Textdraw20[MAX_PLAYERS];
new PlayerText:Textdraw21[MAX_PLAYERS];
new PlayerText:Textdraw22[MAX_PLAYERS];
new PlayerText:Textdraw23[MAX_PLAYERS];
new PlayerText:Textdraw24[MAX_PLAYERS];
/////////////////Player variables///////////////////
new bool:IsPlayerInSMGSelection[MAX_PLAYERS] = false;
new bool:IsPlayerInPistolsSelection[MAX_PLAYERS] = false;
new bool:IsPlayerInShotgunsSelection[MAX_PLAYERS] = false;
new bool:IsPlayerInRifleSelection[MAX_PLAYERS] = false;
new bool:IsPlayerInExtraSelection[MAX_PLAYERS] = false;
new CurrentPlayerWeapon[MAX_PLAYERS] = 0;
//////////////////////////////////////////////////////

/////////////////////////////////////////////////////////

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}
public OnPlayerConnect(playerid)
{
	Textdraw0[playerid] = CreatePlayerTextDraw(playerid, 501.375000, 113.499984, "usebox");
	PlayerTextDrawLetterSize(playerid, Textdraw0[playerid], 0.000000, 33.801387);
	PlayerTextDrawTextSize(playerid, Textdraw0[playerid], 98.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Textdraw0[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw0[playerid], 0);
	PlayerTextDrawUseBox(playerid, Textdraw0[playerid], true);
	PlayerTextDrawBoxColor(playerid, Textdraw0[playerid], 102);
	PlayerTextDrawSetShadow(playerid, Textdraw0[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw0[playerid], 0);
	PlayerTextDrawFont(playerid, Textdraw0[playerid], 0);

	Textdraw1[playerid] = CreatePlayerTextDraw(playerid, 241.250000, 120.166679, "Weapon shop");
	PlayerTextDrawLetterSize(playerid, Textdraw1[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, Textdraw1[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw1[playerid], -225902337);
	PlayerTextDrawSetShadow(playerid, Textdraw1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw1[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw1[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw1[playerid], 1);

	Textdraw2[playerid] = CreatePlayerTextDraw(playerid, 208.125000, 131.250000, ".");
	PlayerTextDrawLetterSize(playerid, Textdraw2[playerid], 15.769989, 0.899999);
	PlayerTextDrawAlignment(playerid, Textdraw2[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw2[playerid], -225902337);
	PlayerTextDrawSetShadow(playerid, Textdraw2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw2[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw2[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw2[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw2[playerid], 1);

	Textdraw3[playerid] = CreatePlayerTextDraw(playerid, 386.250000, 163.333328, "_");
	PlayerTextDrawLetterSize(playerid, Textdraw3[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Textdraw3[playerid], 108.125000, 91.583343);
	PlayerTextDrawAlignment(playerid, Textdraw3[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw3[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw3[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw3[playerid], 0);
	PlayerTextDrawFont(playerid, Textdraw3[playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewModel(playerid, Textdraw3[playerid], 325135);//Just unkown object to show the question mark object.

	Textdraw4[playerid] = CreatePlayerTextDraw(playerid, 377.500000, 11.083313, "I");
	PlayerTextDrawLetterSize(playerid, Textdraw4[playerid], 0.158123, 52.530815);
	PlayerTextDrawAlignment(playerid, Textdraw4[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw4[playerid], -225902337);
	PlayerTextDrawSetShadow(playerid, Textdraw4[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw4[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw4[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw4[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw4[playerid], 1);

	Textdraw5[playerid] = CreatePlayerTextDraw(playerid, 391.875000, 138.833328, "Weapon information:");
	PlayerTextDrawLetterSize(playerid, Textdraw5[playerid], 0.264373, 1.045832);
	PlayerTextDrawAlignment(playerid, Textdraw5[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw5[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw5[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw5[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw5[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw5[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw5[playerid], 1);

	Textdraw6[playerid] = CreatePlayerTextDraw(playerid, 385.625000, 271.833282, "- Ammo: 0~n~- Damage: 0~n~- Price: $0~n~- Accuracy: ~r~0%");
	PlayerTextDrawLetterSize(playerid, Textdraw6[playerid], 0.283122, 1.495000);
	PlayerTextDrawAlignment(playerid, Textdraw6[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw6[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw6[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw6[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw6[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw6[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw6[playerid], 1);

	Textdraw7[playerid] = CreatePlayerTextDraw(playerid, 393.750000, 383.833343, "Buy Weapon");
	PlayerTextDrawLetterSize(playerid, Textdraw7[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, Textdraw7[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw7[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw7[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw7[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw7[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw7[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw7[playerid], 1);

	Textdraw8[playerid] = CreatePlayerTextDraw(playerid, 387.500000, 380.333312, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, Textdraw8[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Textdraw8[playerid], 108.125000, 23.916624);
	PlayerTextDrawAlignment(playerid, Textdraw8[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw8[playerid], -225902337);
	PlayerTextDrawSetShadow(playerid, Textdraw8[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw8[playerid], 0);
	PlayerTextDrawFont(playerid, Textdraw8[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, Textdraw8[playerid], true);

	Textdraw9[playerid] = CreatePlayerTextDraw(playerid, 225.750000, 166.000030, "usebox");
	PlayerTextDrawLetterSize(playerid, Textdraw9[playerid], 0.000000, 1.056017);
	PlayerTextDrawTextSize(playerid, Textdraw9[playerid], 98.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Textdraw9[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw9[playerid], -1162167740);
	PlayerTextDrawUseBox(playerid, Textdraw9[playerid], true);
	PlayerTextDrawBoxColor(playerid, Textdraw9[playerid], -2139062017);
	PlayerTextDrawSetShadow(playerid, Textdraw9[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw9[playerid], 0);
	PlayerTextDrawFont(playerid, Textdraw9[playerid], 0);

	Textdraw10[playerid] = CreatePlayerTextDraw(playerid, 106.250000, 165.666610, "Choose category~n~~n~SMG ~>~~n~~n~Pistols ~>~~n~~n~Shotguns ~>~~n~~n~Rifles ~>~~n~~n~Extra ~>~");
	PlayerTextDrawLetterSize(playerid, Textdraw10[playerid], 0.331247, 0.964164);
	PlayerTextDrawAlignment(playerid, Textdraw10[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw10[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw10[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw10[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw10[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw10[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw10[playerid], 1);

	Textdraw11[playerid] = CreatePlayerTextDraw(playerid, 233.125000, 181.999984, "- First slot");
	PlayerTextDrawLetterSize(playerid, Textdraw11[playerid], 0.405624, 0.981666);
	PlayerTextDrawAlignment(playerid, Textdraw11[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw11[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw11[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw11[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw11[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw11[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw11[playerid], 1);

	Textdraw12[playerid] = CreatePlayerTextDraw(playerid, 232.250000, 199.333328, "- Second slot");
	PlayerTextDrawLetterSize(playerid, Textdraw12[playerid], 0.405624, 0.981666);
	PlayerTextDrawAlignment(playerid, Textdraw12[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw12[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw12[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw12[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw12[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw12[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw12[playerid], 1);

	Textdraw13[playerid] = CreatePlayerTextDraw(playerid, 232.000000, 214.333328, "- Third slot");
	PlayerTextDrawLetterSize(playerid, Textdraw13[playerid], 0.405624, 0.981666);
	PlayerTextDrawAlignment(playerid, Textdraw13[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw13[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw13[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw13[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw13[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw13[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw13[playerid], 1);

	Textdraw14[playerid] = CreatePlayerTextDraw(playerid, 232.375000, 229.333343, "- Fourth slot");
	PlayerTextDrawLetterSize(playerid, Textdraw14[playerid], 0.405624, 0.981666);
	PlayerTextDrawAlignment(playerid, Textdraw14[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw14[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw14[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw14[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw14[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw14[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw14[playerid], 1);

	Textdraw15[playerid] = CreatePlayerTextDraw(playerid, 101.250000, 181.416656, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, Textdraw15[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Textdraw15[playerid], 122.500000, 14.000000);
	PlayerTextDrawAlignment(playerid, Textdraw15[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw15[playerid], 102);
	PlayerTextDrawSetShadow(playerid, Textdraw15[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw15[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Textdraw15[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw15[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, Textdraw15[playerid], true);

	Textdraw16[playerid] = CreatePlayerTextDraw(playerid, 101.250000, 198.916687, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, Textdraw16[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Textdraw16[playerid], 123.125000, 12.833343);
	PlayerTextDrawAlignment(playerid, Textdraw16[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw16[playerid], 85);
	PlayerTextDrawSetShadow(playerid, Textdraw16[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw16[playerid], 0);
	PlayerTextDrawFont(playerid, Textdraw16[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, Textdraw16[playerid], true);

	Textdraw17[playerid] = CreatePlayerTextDraw(playerid, 101.000000, 215.666671, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, Textdraw17[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Textdraw17[playerid], 122.500000, 14.000000);
	PlayerTextDrawAlignment(playerid, Textdraw17[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw17[playerid], 102);
	PlayerTextDrawSetShadow(playerid, Textdraw17[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw17[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Textdraw17[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw17[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, Textdraw17[playerid], true);

	Textdraw18[playerid] = CreatePlayerTextDraw(playerid, 100.750000, 233.583343, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, Textdraw18[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Textdraw18[playerid], 122.500000, 14.000000);
	PlayerTextDrawAlignment(playerid, Textdraw18[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw18[playerid], 102);
	PlayerTextDrawSetShadow(playerid, Textdraw18[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw18[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Textdraw18[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw18[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, Textdraw18[playerid], true);

	Textdraw19[playerid] = CreatePlayerTextDraw(playerid, 101.125000, 250.916748, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, Textdraw19[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Textdraw19[playerid], 122.500000, 14.000000);
	PlayerTextDrawAlignment(playerid, Textdraw19[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw19[playerid], 102);
	PlayerTextDrawSetShadow(playerid, Textdraw19[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw19[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Textdraw19[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw19[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, Textdraw19[playerid], true);

	Textdraw20[playerid] = CreatePlayerTextDraw(playerid, 230.875000, 181.333435, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, Textdraw20[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Textdraw20[playerid], 122.500000, 14.000000);
	PlayerTextDrawAlignment(playerid, Textdraw20[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw20[playerid], 102);
	PlayerTextDrawSetShadow(playerid, Textdraw20[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw20[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Textdraw20[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw20[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, Textdraw20[playerid], true);

	Textdraw21[playerid] = CreatePlayerTextDraw(playerid, 231.250000, 196.916748, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, Textdraw21[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Textdraw21[playerid], 122.500000, 14.000000);
	PlayerTextDrawAlignment(playerid, Textdraw21[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw21[playerid], 102);
	PlayerTextDrawSetShadow(playerid, Textdraw21[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw21[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Textdraw21[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw21[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, Textdraw21[playerid], true);

	Textdraw22[playerid] = CreatePlayerTextDraw(playerid, 231.625000, 211.916732, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, Textdraw22[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Textdraw22[playerid], 122.500000, 14.000000);
	PlayerTextDrawAlignment(playerid, Textdraw22[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw22[playerid], 102);
	PlayerTextDrawSetShadow(playerid, Textdraw22[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw22[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Textdraw22[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw22[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, Textdraw22[playerid], true);

	Textdraw23[playerid] = CreatePlayerTextDraw(playerid, 230.125000, 227.500091, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, Textdraw23[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Textdraw23[playerid], 122.500000, 14.000000);
	PlayerTextDrawAlignment(playerid, Textdraw23[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw23[playerid], 102);
	PlayerTextDrawSetShadow(playerid, Textdraw23[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw23[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Textdraw23[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw23[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, Textdraw23[playerid], true);

    Textdraw24[playerid] = CreatePlayerTextDraw(playerid, 486.875000, 107.916664, "x");
	PlayerTextDrawLetterSize(playerid, Textdraw24[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, Textdraw24[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw24[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw24[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw24[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw24[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw24[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw24[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Textdraw24[playerid], true);

	return 1;
}
CMD:weapons(playerid)
{
	PlayerTextDrawShow(playerid,Textdraw0[playerid]);
	PlayerTextDrawShow(playerid,Textdraw1[playerid]);
	PlayerTextDrawShow(playerid,Textdraw2[playerid]);
	PlayerTextDrawShow(playerid,Textdraw3[playerid]);
	PlayerTextDrawShow(playerid,Textdraw4[playerid]);
	PlayerTextDrawShow(playerid,Textdraw5[playerid]);
	PlayerTextDrawShow(playerid,Textdraw6[playerid]);
	PlayerTextDrawShow(playerid,Textdraw7[playerid]);
	PlayerTextDrawShow(playerid,Textdraw8[playerid]);
	PlayerTextDrawShow(playerid,Textdraw9[playerid]);
	PlayerTextDrawShow(playerid,Textdraw10[playerid]);
	PlayerTextDrawShow(playerid,Textdraw15[playerid]);
	PlayerTextDrawShow(playerid,Textdraw16[playerid]);
	PlayerTextDrawShow(playerid,Textdraw17[playerid]);
	PlayerTextDrawShow(playerid,Textdraw18[playerid]);
	PlayerTextDrawShow(playerid,Textdraw19[playerid]);
	PlayerTextDrawShow(playerid,Textdraw24[playerid]);//Escape button
	SelectTextDraw(playerid, 0x00FF00FF);
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	PlayerTextDrawDestroy(playerid,Textdraw0[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw1[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw2[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw3[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw4[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw5[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw6[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw7[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw8[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw9[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw10[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw11[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw12[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw13[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw14[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw15[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw16[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw17[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw18[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw19[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw20[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw21[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw22[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw23[playerid]);
	PlayerTextDrawDestroy(playerid,Textdraw24[playerid]);
	return 1;
}
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	new string[126];
    if(playertextid == Textdraw15[playerid])
    {
        ReShowCategory(playerid);
        IsPlayerInSMGSelection[playerid] = true;// I like to reset the variables to avoide bugs you may remove them!
        IsPlayerInPistolsSelection[playerid] = false;
		IsPlayerInShotgunsSelection[playerid] = false;
		IsPlayerInRifleSelection[playerid] = false;
		IsPlayerInExtraSelection[playerid] = false;
    	PlayerTextDrawSetString(playerid,Textdraw11[playerid],"- UZI");
        PlayerTextDrawSetString(playerid,Textdraw12[playerid],"- Tec9");
        PlayerTextDrawShow(playerid,Textdraw11[playerid]);
        PlayerTextDrawShow(playerid,Textdraw12[playerid]);
        PlayerTextDrawShow(playerid,Textdraw20[playerid]);
        PlayerTextDrawShow(playerid,Textdraw21[playerid]);
    }
    if(playertextid == Textdraw16[playerid])
    {
        ReShowCategory(playerid);
        IsPlayerInSMGSelection[playerid] = false;// I like to reset the variables to avoide bugs you may remove them!
        IsPlayerInPistolsSelection[playerid] = true;
		IsPlayerInShotgunsSelection[playerid] = false;
		IsPlayerInRifleSelection[playerid] = false;
		IsPlayerInExtraSelection[playerid] = false;
    	PlayerTextDrawSetString(playerid,Textdraw11[playerid],"- Desert eagle");
        PlayerTextDrawSetString(playerid,Textdraw12[playerid],"- S. 9mm");
       	PlayerTextDrawSetString(playerid,Textdraw13[playerid],"- 9mm");
        PlayerTextDrawShow(playerid,Textdraw20[playerid]);
        PlayerTextDrawShow(playerid,Textdraw21[playerid]);
        PlayerTextDrawShow(playerid,Textdraw22[playerid]);
        PlayerTextDrawShow(playerid,Textdraw11[playerid]);
        PlayerTextDrawShow(playerid,Textdraw12[playerid]);
        PlayerTextDrawShow(playerid,Textdraw13[playerid]);
    }

   	if(playertextid == Textdraw17[playerid])
    {
        ReShowCategory(playerid);
        IsPlayerInSMGSelection[playerid] = false;// I like to reset the variables to avoide bugs you may remove them!
        IsPlayerInPistolsSelection[playerid] = false;
		IsPlayerInShotgunsSelection[playerid] = true;
		IsPlayerInRifleSelection[playerid] = false;
		IsPlayerInExtraSelection[playerid] = false;
    	PlayerTextDrawSetString(playerid,Textdraw11[playerid],"- Swan-off");
        PlayerTextDrawSetString(playerid,Textdraw12[playerid],"- Combat Shotgun");
        PlayerTextDrawShow(playerid,Textdraw20[playerid]);
        PlayerTextDrawShow(playerid,Textdraw21[playerid]);
        PlayerTextDrawShow(playerid,Textdraw11[playerid]);
        PlayerTextDrawShow(playerid,Textdraw12[playerid]);
  	}
  	if(playertextid == Textdraw18[playerid])
    {
        ReShowCategory(playerid);
        IsPlayerInSMGSelection[playerid] = false;// I like to reset the variables to avoide bugs you may remove them!
        IsPlayerInPistolsSelection[playerid] = false;
		IsPlayerInShotgunsSelection[playerid] = false;
		IsPlayerInRifleSelection[playerid] = true;
		IsPlayerInExtraSelection[playerid] = false;
    	PlayerTextDrawSetString(playerid,Textdraw11[playerid],"- M4");
        PlayerTextDrawSetString(playerid,Textdraw12[playerid],"- AK-47");
        PlayerTextDrawSetString(playerid,Textdraw13[playerid],"- Sniper Rifle");
        PlayerTextDrawSetString(playerid,Textdraw14[playerid],"- Country Rifle");
        PlayerTextDrawShow(playerid,Textdraw20[playerid]);
        PlayerTextDrawShow(playerid,Textdraw21[playerid]);
        PlayerTextDrawShow(playerid,Textdraw22[playerid]);
        PlayerTextDrawShow(playerid,Textdraw23[playerid]);
        
        PlayerTextDrawShow(playerid,Textdraw11[playerid]);
        PlayerTextDrawShow(playerid,Textdraw12[playerid]);
        PlayerTextDrawShow(playerid,Textdraw13[playerid]);
        PlayerTextDrawShow(playerid,Textdraw14[playerid]);
  	}
  	if(playertextid == Textdraw19[playerid])
    {
        ReShowCategory(playerid);
        IsPlayerInSMGSelection[playerid] = false;// I like to reset the variables to avoide bugs you may remove them!
        IsPlayerInPistolsSelection[playerid] = false;
		IsPlayerInShotgunsSelection[playerid] = false;
		IsPlayerInRifleSelection[playerid] = false;
		IsPlayerInExtraSelection[playerid] = true;
    	PlayerTextDrawSetString(playerid,Textdraw11[playerid],"- Grenade");
        PlayerTextDrawSetString(playerid,Textdraw13[playerid],"- Molotov");
        PlayerTextDrawSetString(playerid,Textdraw12[playerid],"- Knife");
        PlayerTextDrawSetString(playerid,Textdraw14[playerid],"- Tear Gas");
        PlayerTextDrawShow(playerid,Textdraw20[playerid]);
        PlayerTextDrawShow(playerid,Textdraw21[playerid]);
        PlayerTextDrawShow(playerid,Textdraw22[playerid]);
        PlayerTextDrawShow(playerid,Textdraw23[playerid]);
        PlayerTextDrawShow(playerid,Textdraw11[playerid]);
        PlayerTextDrawShow(playerid,Textdraw12[playerid]);
        PlayerTextDrawShow(playerid,Textdraw13[playerid]);
        PlayerTextDrawShow(playerid,Textdraw14[playerid]);
  	}
  	if(playertextid == Textdraw20[playerid])
  	{
  	    if(IsPlayerInSMGSelection[playerid] == true)
  	    {
            CurrentPlayerWeapon[playerid] = 28;
            PlayerTextDrawSetPreviewModel(playerid,Textdraw3[playerid], 352);
            PlayerTextDrawSetPreviewRot(playerid, Textdraw3[playerid], 0.0, 0.0, 0.0, 2.5);
            format(string,sizeof(string),"- Ammo: %d~n~- Damage: ~r~10~n~~w~- Price: $%d~n~- Accuracy: ~y~50%",UZI_AMMO,UZI_PRICE);
            PlayerTextDrawSetString(playerid,Textdraw6[playerid],string);
            PlayerTextDrawShow(playerid,Textdraw6[playerid]);
            PlayerTextDrawShow(playerid,Textdraw3[playerid]);
  	    }
  	    else if(IsPlayerInPistolsSelection[playerid] == true)
  	    {
            CurrentPlayerWeapon[playerid] = 24;
            PlayerTextDrawSetPreviewModel(playerid,Textdraw3[playerid], 348);
            PlayerTextDrawSetPreviewRot(playerid, Textdraw3[playerid], 0.0, 0.0, 0.0, 2.5);
            format(string,sizeof(string),"- Ammo: %d~n~- Damage: ~g~49~n~~w~- Price: $%d~n~- Accuracy: ~g~80%",Deagle_AMMO,Deagle_PRICE);
            PlayerTextDrawSetString(playerid,Textdraw6[playerid],string);
            PlayerTextDrawShow(playerid,Textdraw6[playerid]);
            PlayerTextDrawShow(playerid,Textdraw3[playerid]);
  	    }
  	    else if(IsPlayerInShotgunsSelection[playerid] == true)
  	    {
            CurrentPlayerWeapon[playerid] = 26;
            PlayerTextDrawSetPreviewModel(playerid,Textdraw3[playerid], 350);
            PlayerTextDrawSetPreviewRot(playerid, Textdraw3[playerid], 0.0, 0.0, 0.0, 2.5);
            format(string,sizeof(string),"- Ammo: %d~n~- Damage: ~y~46~n~~w~- Price: $%d~n~- Accuracy: ~y~50%",Swanoff_AMMO,Swanoff_PRICE);
            PlayerTextDrawSetString(playerid,Textdraw6[playerid],string);
            PlayerTextDrawShow(playerid,Textdraw6[playerid]);
            PlayerTextDrawShow(playerid,Textdraw3[playerid]);
  	    }
  	    else if(IsPlayerInRifleSelection[playerid] == true)
  	    {
            CurrentPlayerWeapon[playerid] = 31;
            PlayerTextDrawSetPreviewModel(playerid,Textdraw3[playerid], 356);
            PlayerTextDrawSetPreviewRot(playerid, Textdraw3[playerid], 0.0, 0.0, 0.0, 2.5);
            format(string,sizeof(string),"- Ammo: %d~n~- Damage: ~y~20~n~~w~- Price: $%d~n~- Accuracy: ~g~90%",M4_AMMO,M4_PRICE);
            PlayerTextDrawSetString(playerid,Textdraw6[playerid],string);
            PlayerTextDrawShow(playerid,Textdraw6[playerid]);
            PlayerTextDrawShow(playerid,Textdraw3[playerid]);
  	    }
  	    else if(IsPlayerInExtraSelection[playerid] == true)
  	    {
            CurrentPlayerWeapon[playerid] = 16;
            PlayerTextDrawSetPreviewModel(playerid,Textdraw3[playerid], 342);
            PlayerTextDrawSetPreviewRot(playerid, Textdraw3[playerid], 0.0, 0.0, 0.0, 2.5);
            format(string,sizeof(string),"- Ammo: %d~n~- Damage: ~g~82~n~~w~- Price: $%d~n~- Accuracy: ~y~50%",Grenade_AMMO,Grenade_PRICE);
            PlayerTextDrawSetString(playerid,Textdraw6[playerid],string);
            PlayerTextDrawShow(playerid,Textdraw6[playerid]);
            PlayerTextDrawShow(playerid,Textdraw3[playerid]);
  	    }
  	}
  	if(playertextid == Textdraw21[playerid])
  	{
  	    if(IsPlayerInSMGSelection[playerid] == true)
  	    {
            CurrentPlayerWeapon[playerid] = 32;
            PlayerTextDrawSetPreviewModel(playerid,Textdraw3[playerid], 372);
            PlayerTextDrawSetPreviewRot(playerid, Textdraw3[playerid], 0.0, 0.0, 0.0, 2.5);
            format(string,sizeof(string),"- Ammo: %d~n~- Damage: ~r~10~n~~w~- Price: $%d~n~- Accuracy: ~y~50%",TEC9_AMMO,TEC9_PRICE);
            PlayerTextDrawSetString(playerid,Textdraw6[playerid],string);
            PlayerTextDrawShow(playerid,Textdraw6[playerid]);
            
            PlayerTextDrawShow(playerid,Textdraw3[playerid]);
  	    }
  	    else if(IsPlayerInPistolsSelection[playerid] == true)
  	    {
            CurrentPlayerWeapon[playerid] = 23;
            PlayerTextDrawSetPreviewModel(playerid,Textdraw3[playerid], 347);
            PlayerTextDrawSetPreviewRot(playerid, Textdraw3[playerid], 0.0, 0.0, 0.0, 2.5);
            format(string,sizeof(string),"- Ammo: %d~n~- Damage: ~r~10~n~~w~- Price: $%d~n~- Accuracy: ~y~50%",S9mm_AMMO,S9mm_PRICE);
            PlayerTextDrawSetString(playerid,Textdraw6[playerid],string);
            PlayerTextDrawShow(playerid,Textdraw6[playerid]);
            PlayerTextDrawShow(playerid,Textdraw3[playerid]);
  	    }
  	    else if(IsPlayerInShotgunsSelection[playerid] == true)
  	    {
            CurrentPlayerWeapon[playerid] = 27;
            PlayerTextDrawSetPreviewModel(playerid,Textdraw3[playerid], 351);
            PlayerTextDrawSetPreviewRot(playerid, Textdraw3[playerid], 0.0, 0.0, 0.0, 2.5);
            format(string,sizeof(string),"- Ammo: %d~n~- Damage: ~y~39~n~~w~- Price: $%d~n~- Accuracy: ~y~50%",Combat_AMMO,Combat_PRICE);
            PlayerTextDrawSetString(playerid,Textdraw6[playerid],string);
            PlayerTextDrawShow(playerid,Textdraw6[playerid]);
            PlayerTextDrawShow(playerid,Textdraw3[playerid]);
  	    }
  	    else if(IsPlayerInRifleSelection[playerid] == true)
  	    {
            CurrentPlayerWeapon[playerid] = 30;
            PlayerTextDrawSetPreviewModel(playerid,Textdraw3[playerid], 355);
            PlayerTextDrawSetPreviewRot(playerid, Textdraw3[playerid], 0.0, 0.0, 0.0, 2.5);
            format(string,sizeof(string),"- Ammo: %d~n~- Damage: ~r~20~n~~w~- Price: $%d~n~- Accuracy: ~g~80%",AK47_AMMO,AK47_PRICE);
            PlayerTextDrawSetString(playerid,Textdraw6[playerid],string);
            PlayerTextDrawShow(playerid,Textdraw6[playerid]);
            PlayerTextDrawShow(playerid,Textdraw3[playerid]);
  	    }
  	    else if(IsPlayerInExtraSelection[playerid] == true)
  	    {
            CurrentPlayerWeapon[playerid] = 4;
            PlayerTextDrawSetPreviewModel(playerid,Textdraw3[playerid], 335);
            PlayerTextDrawSetPreviewRot(playerid, Textdraw3[playerid], 0.0, 0.0, 0.0, 2.5);
            format(string,sizeof(string),"- Ammo: %d~n~- Damage: ~r~1 - ~g~(100)~n~~w~- Price: $%d~n~- Accuracy: ~g~100%",Knife_AMMO,Knife_PRICE);
            PlayerTextDrawSetString(playerid,Textdraw6[playerid],string);
            PlayerTextDrawShow(playerid,Textdraw6[playerid]);
            PlayerTextDrawShow(playerid,Textdraw3[playerid]);
  	    }
  	}
  	if(playertextid == Textdraw22[playerid])
  	{
   		if(IsPlayerInPistolsSelection[playerid] == true)
  	    {
            CurrentPlayerWeapon[playerid] = 22;
            PlayerTextDrawSetPreviewModel(playerid,Textdraw3[playerid], 346);
            PlayerTextDrawSetPreviewRot(playerid, Textdraw3[playerid], 0.0, 0.0, 0.0, 2.5);
            format(string,sizeof(string),"- Ammo: %d~n~- Damage: ~r~12~n~~w~- Price: $%d~n~- Accuracy: ~r~40%",P9mm_AMMO,P9mm_PRICE);
            PlayerTextDrawSetString(playerid,Textdraw6[playerid],string);
            PlayerTextDrawShow(playerid,Textdraw6[playerid]);
            PlayerTextDrawShow(playerid,Textdraw3[playerid]);
  	    }
  	    else if(IsPlayerInRifleSelection[playerid] == true)
  	    {
            CurrentPlayerWeapon[playerid] = 34;
            PlayerTextDrawSetPreviewModel(playerid,Textdraw3[playerid], 358);
            PlayerTextDrawSetPreviewRot(playerid, Textdraw3[playerid], 0.0, 0.0, 0.0, 2.5);
            format(string,sizeof(string),"- Ammo: %d~n~- Damage: ~y~50~n~~w~- Price: $%d~n~- Accuracy: ~g~100%",Sniper_AMMO,Sniper_PRICE);
            PlayerTextDrawSetString(playerid,Textdraw6[playerid],string);
            PlayerTextDrawShow(playerid,Textdraw6[playerid]);
            PlayerTextDrawShow(playerid,Textdraw3[playerid]);
  	    }
  	    else if(IsPlayerInExtraSelection[playerid] == true)
  	    {
            CurrentPlayerWeapon[playerid] = 18;
            PlayerTextDrawSetPreviewModel(playerid,Textdraw3[playerid], 344);
            PlayerTextDrawSetPreviewRot(playerid, Textdraw3[playerid], 0.0, 0.0, 0.0, 2.5);
            format(string,sizeof(string),"- Ammo: %d~n~- Damage: ~r~N/A~n~~w~- Price: $%d~n~- Accuracy: ~r~N/A",Molotov_AMMO,Molotov_PRICE);
            PlayerTextDrawSetString(playerid,Textdraw6[playerid],string);
            PlayerTextDrawShow(playerid,Textdraw6[playerid]);
            PlayerTextDrawShow(playerid,Textdraw3[playerid]);
  	    }
  	}
  	if(playertextid == Textdraw23[playerid])
  	{
 		if(IsPlayerInRifleSelection[playerid] == true)
  	    {
            CurrentPlayerWeapon[playerid] = 33;
            PlayerTextDrawSetPreviewModel(playerid,Textdraw3[playerid], 357);
            PlayerTextDrawSetPreviewRot(playerid, Textdraw3[playerid], 0.0, 0.0, 0.0, 2.5);
            format(string,sizeof(string),"- Ammo: %d~n~- Damage: ~r~10~n~~w~- Price: $%d~n~- Accuracy: ~g~90%",Country_AMMO,Country_PRICE);
            PlayerTextDrawSetString(playerid,Textdraw6[playerid],string);
            PlayerTextDrawShow(playerid,Textdraw6[playerid]);
            PlayerTextDrawShow(playerid,Textdraw3[playerid]);
  	    }
  	    else if(IsPlayerInExtraSelection[playerid] == true)
  	    {
            CurrentPlayerWeapon[playerid] = 17;
            PlayerTextDrawSetPreviewModel(playerid,Textdraw3[playerid], 343);
            PlayerTextDrawSetPreviewRot(playerid, Textdraw3[playerid], 0.0, 0.0, 0.0, 2.5);
            format(string,sizeof(string),"- Ammo: %d~n~- Damage: ~r~0~n~~w~- Price: $%d~n~- Accuracy: ~r~N/A",Teargas_AMMO,Teargas_PRICE);
            PlayerTextDrawSetString(playerid,Textdraw6[playerid],string);
            PlayerTextDrawShow(playerid,Textdraw6[playerid]);
            PlayerTextDrawShow(playerid,Textdraw3[playerid]);
  	    }
  	}
  	if(playertextid == Textdraw8[playerid])
  	{
  	    if(CurrentPlayerWeapon[playerid] == 0) return SendClientMessage(playerid,0xFF0000FF,"[ERROR] {FFFFFF}Select a weapon from the category first.");
  	    switch(CurrentPlayerWeapon[playerid])
  	    {
  	        case 28:
	  		{
	  			if(GetPlayerMoney(playerid) < UZI_PRICE) return SendERROR(playerid);
	  			GivePlayerMoney(playerid,-UZI_PRICE);
			  	GivePlayerWeapon(playerid,28,UZI_AMMO);
			  	PurchaseMSG(playerid,28);
	  		}
     		case 32:
	  		{
	  			if(GetPlayerMoney(playerid) < TEC9_PRICE) return SendERROR(playerid);
	  			GivePlayerMoney(playerid,-TEC9_PRICE);
			  	GivePlayerWeapon(playerid,32,TEC9_AMMO);
			  	PurchaseMSG(playerid,32);
	  		}
   			case 24:
	  		{
	  			if(GetPlayerMoney(playerid) < Deagle_PRICE) return SendERROR(playerid);
	  			GivePlayerMoney(playerid,-Deagle_PRICE);
			  	GivePlayerWeapon(playerid,24,Deagle_AMMO);
			  	PurchaseMSG(playerid,24);
	  		}
  			case 23:
	  		{
	  			if(GetPlayerMoney(playerid) < S9mm_PRICE) return SendERROR(playerid);
	  			GivePlayerMoney(playerid,-S9mm_PRICE);
			  	GivePlayerWeapon(playerid,23,S9mm_AMMO);
			  	PurchaseMSG(playerid,23);
	  		}
  			case 22:
	  		{
	  			if(GetPlayerMoney(playerid) < P9mm_PRICE) return SendERROR(playerid);
	  			GivePlayerMoney(playerid,-S9mm_PRICE);
			  	GivePlayerWeapon(playerid,22,P9mm_AMMO);
			  	PurchaseMSG(playerid,22);
	  		}
  			case 26:
	  		{
	  			if(GetPlayerMoney(playerid) < Swanoff_PRICE) return SendERROR(playerid);
	  			GivePlayerMoney(playerid,-Swanoff_PRICE);
			  	GivePlayerWeapon(playerid,26,Swanoff_AMMO);
			  	PurchaseMSG(playerid,26);
	  		}
  			case 27:
	  		{
	  			if(GetPlayerMoney(playerid) < Combat_PRICE) return SendERROR(playerid);
	  			GivePlayerMoney(playerid,-Combat_PRICE);
			  	GivePlayerWeapon(playerid,27,Combat_AMMO);
			  	PurchaseMSG(playerid,27);
	  		}
  			case 31:
	  		{
	  			if(GetPlayerMoney(playerid) < M4_PRICE) return SendERROR(playerid);
	  			GivePlayerMoney(playerid,-M4_PRICE);
			  	GivePlayerWeapon(playerid,31,M4_AMMO);
			  	PurchaseMSG(playerid,31);
	  		}
  			case 30:
	  		{
	  			if(GetPlayerMoney(playerid) < AK47_PRICE) return SendERROR(playerid);
	  			GivePlayerMoney(playerid,-AK47_PRICE);
			  	GivePlayerWeapon(playerid,30,AK47_AMMO);
			  	PurchaseMSG(playerid,30);
	  		}
  			case 34:
	  		{
	  			if(GetPlayerMoney(playerid) < Sniper_PRICE) return SendERROR(playerid);
	  			GivePlayerMoney(playerid,-Sniper_PRICE);
			  	GivePlayerWeapon(playerid,34,Sniper_AMMO);
			  	PurchaseMSG(playerid,34);
	  		}
  			case 33:
	  		{
	  			if(GetPlayerMoney(playerid) < Country_PRICE) return SendERROR(playerid);
	  			GivePlayerMoney(playerid,-Country_PRICE);
			  	GivePlayerWeapon(playerid,33,Country_AMMO);
			  	PurchaseMSG(playerid,33);
	  		}
	  		//
  			case 16:
	  		{
	  			if(GetPlayerMoney(playerid) < Grenade_PRICE) return SendERROR(playerid);
	  			GivePlayerMoney(playerid,-Grenade_PRICE);
			  	GivePlayerWeapon(playerid,16,Grenade_AMMO);
			  	PurchaseMSG(playerid,16);
	  		}
  			case 18:
	  		{
	  			if(GetPlayerMoney(playerid) < Molotov_PRICE) return SendERROR(playerid);
	  			GivePlayerMoney(playerid,-Molotov_PRICE);
			  	GivePlayerWeapon(playerid,18,Molotov_AMMO);
			  	PurchaseMSG(playerid,18);
	  		}
  			case 4:
	  		{
	  			if(GetPlayerMoney(playerid) < Knife_PRICE) return SendERROR(playerid);
	  			GivePlayerMoney(playerid,-Knife_PRICE);
			  	GivePlayerWeapon(playerid,4,Knife_AMMO);
			  	PurchaseMSG(playerid,4);
	  		}
  			case 17:
	  		{
	  			if(GetPlayerMoney(playerid) < Teargas_PRICE) return SendERROR(playerid);
	  			GivePlayerMoney(playerid,-Teargas_PRICE);
			  	GivePlayerWeapon(playerid,17,Teargas_AMMO);
			  	PurchaseMSG(playerid,17);
	  		}
  	    }
  	}
  	if(playertextid == Textdraw24[playerid])
  	{
	 	PlayerTextDrawHide(playerid,Textdraw0[playerid]);
		PlayerTextDrawHide(playerid,Textdraw1[playerid]);
		PlayerTextDrawHide(playerid,Textdraw2[playerid]);
		PlayerTextDrawHide(playerid,Textdraw3[playerid]);
		PlayerTextDrawHide(playerid,Textdraw4[playerid]);
		PlayerTextDrawHide(playerid,Textdraw5[playerid]);
		PlayerTextDrawHide(playerid,Textdraw6[playerid]);
		PlayerTextDrawHide(playerid,Textdraw7[playerid]);
		PlayerTextDrawHide(playerid,Textdraw8[playerid]);
		PlayerTextDrawHide(playerid,Textdraw9[playerid]);
		PlayerTextDrawHide(playerid,Textdraw10[playerid]);
		PlayerTextDrawHide(playerid,Textdraw11[playerid]);
		PlayerTextDrawHide(playerid,Textdraw12[playerid]);
		PlayerTextDrawHide(playerid,Textdraw13[playerid]);
		PlayerTextDrawHide(playerid,Textdraw14[playerid]);
		PlayerTextDrawHide(playerid,Textdraw15[playerid]);
		PlayerTextDrawHide(playerid,Textdraw16[playerid]);
		PlayerTextDrawHide(playerid,Textdraw17[playerid]);
		PlayerTextDrawHide(playerid,Textdraw18[playerid]);
		PlayerTextDrawHide(playerid,Textdraw19[playerid]);
		PlayerTextDrawHide(playerid,Textdraw20[playerid]);
		PlayerTextDrawHide(playerid,Textdraw21[playerid]);
		PlayerTextDrawHide(playerid,Textdraw22[playerid]);
		PlayerTextDrawHide(playerid,Textdraw23[playerid]);
		PlayerTextDrawHide(playerid,Textdraw24[playerid]);
		CancelSelectTextDraw(playerid);
  	}
    return 1;
}
stock ReShowCategory(playerid)
{
	PlayerTextDrawHide(playerid,Textdraw20[playerid]);
	PlayerTextDrawHide(playerid,Textdraw21[playerid]);
	PlayerTextDrawHide(playerid,Textdraw22[playerid]);
	PlayerTextDrawHide(playerid,Textdraw23[playerid]);
	PlayerTextDrawHide(playerid,Textdraw11[playerid]);
	PlayerTextDrawHide(playerid,Textdraw12[playerid]);
	 PlayerTextDrawHide(playerid,Textdraw13[playerid]);
	PlayerTextDrawHide(playerid,Textdraw14[playerid]);
	return 1;
}
stock SendERROR(playerid)
{
    SendClientMessage(playerid,0xFF0000FF,"ERROR » {FFFFFF}You don't have enough money to buy this weapon.");
    return true;
}
stock PurchaseMSG(playerid,WeaponID)
{
	new string[126],gunname[32];
	GetWeaponName(WeaponID,gunname,sizeof(gunname));
	if(WeaponID == 18) gunname = "Molotov Cocktail";//Don't remove this line, the getweaponfunction won't get the molotov name.
	format(string,sizeof(string),"{5EFF00}Weapon shop » {FFFFFF}You have sucussfully bought %s.",gunname);
	SendClientMessage(playerid,-1,string);
	return 1;
}
