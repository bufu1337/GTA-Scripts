// Version 1.0
killreward_Death(playerid,killerid,reason) {
#pragma unused reason
#pragma unused killerid
#pragma unused playerid
#if DISABLE_WIN_ON_TEAMKILL == 1
	if(killerid != INVALID_PLAYER_ID){
		if (GetPlayerTeam(killerid)==GetPlayerTeam(playerid)) return 0;
	}
#endif
	
#if WIN_SCORE_ON_KILL != 0
	if(killerid != INVALID_PLAYER_ID){
		SetPlayerScore(killerid,GetPlayerScore(killerid)+(WIN_SCORE_ON_KILL));
	}
#endif

#if WIN_MONEY_ON_KILL != 0
	if(killerid != INVALID_PLAYER_ID){
		GivePlayerMoney(killerid,WIN_MONEY_ON_KILL);
	}
#endif
	return 0;
}