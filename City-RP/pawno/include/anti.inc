// Union Anti Money Hack, Anti Illegal Weapon, Anti Jet-Pack (GodFather Compile) by chenza
// Support GM GodFather Only!!!

new ScriptMoney[MAX_PLAYERS];
new moneyhacktimer;
new weaponhacktimer;

forward CheckMoneyHack();
forward CheckWeaponHack();
forward Union_OnGameModeInit();
forward Union_GameModeExitFunc();
forward Union_GiveMoney(playerid, amounttogive);
forward Union_ResetMoney(playerid);
forward Union_GetMoney(playerid);

public Union_OnGameModeInit()
{
	moneyhacktimer = SetTimer("CheckMoneyHack",5000,1);
	weaponhacktimer = SetTimer("CheckWeaponHack",1000,1);
}

public Union_GameModeExitFunc()
{
	KillTimer(moneyhacktimer);
	KillTimer(weaponhacktimer);
}

public Union_GiveMoney(playerid, amounttogive)
{
	GivePlayerMoney(playerid, amounttogive);
	ScriptMoney[playerid] = (ScriptMoney[playerid] + amounttogive);
	return 1;
}

public Union_ResetMoney(playerid)
{
	ResetPlayerMoney(playerid);
	ScriptMoney[playerid] = 0;
	return 1;
}

public Union_GetMoney(playerid)
{
	return ScriptMoney[playerid];
}

public CheckMoneyHack() //Anti Money Hack By ChenZa!!
{
	for(new i = 0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			new string[256];
			new giveplayer[MAX_PLAYER_NAME];
			new money = GetPlayerMoney(i);
			new pcash = Union_GetMoney(i);
			if(pcash < money)
			{
				GetPlayerName(i, giveplayer, sizeof(giveplayer));
				new year, month,day;
				getdate(year, month, day);
				new moneynumber = money-pcash;
				format(string, sizeof(string), "AdmWarning : %s use Money Cheat amount: %d", giveplayer, moneynumber);
				SendAdminMessage(0xFFFF00AA, string);
				Union_ResetMoney(i);
				Union_GiveMoney(i, pcash);
			}
			else
			{
				ScriptMoney[i] = money;
			}
		}
	}
  	return 1;
}

public CheckWeaponHack() // Anti Illegal Weapon, Anti Jet-Pack
{
	new string[256];
	new giveplayer[MAX_PLAYER_NAME];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   	if(IsPlayerConnected(i))
	   	{
	   		if(GetPlayerWeapon(i) == 35 || GetPlayerWeapon(i) == 36 || GetPlayerWeapon(i) == 37 || GetPlayerWeapon(i) == 38 || GetPlayerSpecialAction(i) == SPECIAL_ACTION_USEJETPACK)
		    	{
				GetPlayerName(i, giveplayer, sizeof(giveplayer));
				format(string, sizeof(string), "AntiCheat: %s Was Kicked from the Server because He use Illegal Weapon (Rocket Launcher,Flamethrower,Minigun,Satchel Charge,Jet Pack) ", giveplayer);
				SendClientMessageToAll(0xFF6347AA, string);
				Kick(i);
			}
    		}
	}
	return 1;
}

#define GivePlayerMoney Union_GiveMoney
#define ResetPlayerMoney Union_ResetMoney
#define GetPlayerMoney Union_GetMoney
