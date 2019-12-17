// Version 1.0
modeconfig_GameModeInit() {
#if ENABLE_NAMETAGS == 1
	ShowNameTags(true);
#else
	ShowNameTags(false);
#endif

#if ENABLE_INTERIOR_WEAPONS == 1
	AllowInteriorWeapons(true);
#else
	AllowInteriorWeapons(false);
#endif

#if ENABLE_TIRE_POPPING == 1
	EnableTirePopping(true);
#else
	EnableTirePopping(false);
#endif

#if ENABLE_PED_WALKING_ANIMATIONS == 1
	UsePlayerPedAnims();
#endif
#if DISABLE_INTERIOR_ENTRANCES_AND_EXITS == 1
	DisableInteriorEnterExits();
#endif
}

#if START_MONEY_FOR_PLAYERS != 0
modeconfig_Connect(playerid) {
	GivePlayerMoney(playerid,GetPlayerMoney(playerid)+(START_MONEY_FOR_PLAYERS));
}
#endif