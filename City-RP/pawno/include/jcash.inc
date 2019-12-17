/* ====================== [JCASH BY JONYAVATI] ==================== */

/* INCLUDES */
#include <a_samp>

/* DEFINES */
#define JCASH_ACTIVATED 1 // 1 : Activated, 0 : Desactivated
#if JCASH_ACTIVATED == 1
#define ResetMoneyBar ResetPlayerMoney
#define UpdateMoneyBar GivePlayerCASHNAME

#define GivePlayerMoney GivePlayerCASHNAME
#define ResetPlayerMoney ResetPlayerCASHNAME
#define GetPlayerMoney GetPlayerCASHNAME
#endif

#define CASHNAME Moneyz // Modify Jcash to your cash name
/* VARIABLES */
new CASHNAME[MAX_PLAYERS];

/* STOCKS */
stock GivePlayerCASHNAME(playerid, money)
{
	CASHNAME[playerid] = CASHNAME[playerid] + money;
	return CASHNAME[playerid];
}

stock ResetPlayerCASHNAME(playerid)
{
	CASHNAME[playerid] = 0;
	return CASHNAME[playerid];
}
stock GetPlayerCASHNAME(playerid)
{
	return CASHNAME[playerid];
}

//#if JCASH_ACTIVATED == 0
//#define GivePlayerCASHNAME GivePlayerMoney
//#define ResetPlayerCASHNAME ResetPlayerMoney
//#define GetPlayerCASHNAME GetPlayerMoney
//#endif
