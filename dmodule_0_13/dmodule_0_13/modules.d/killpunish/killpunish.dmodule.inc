// Version 1.0
killpunish_Death(playerid, killerid, reason){
#pragma unused reason
#pragma unused killerid
#pragma unused playerid
#if LOSE_SCORE_ON_SUICIDE != 0
	if(killerid == INVALID_PLAYER_ID){
		SetPlayerScore(playerid,GetPlayerScore(playerid)-(LOSE_SCORE_ON_SUICIDE));
	}
#endif

#if LOSE_SCORE_ON_TEAMKILL != 0
	if(killerid == INVALID_PLAYER_ID){
		if (GetPlayerTeam(killerid)==GetPlayerTeam(playerid)) {
			SetPlayerScore(playerid,GetPlayerScore(playerid)-(LOSE_SCORE_ON_TEAMKILL));
		}
	}
#endif
	
#if LOSE_MONEY_ON_DEATH != 0
	new old_money;
	old_money = GetPlayerMoney(playerid);
	if(old_money > LOSE_MONEY_ON_DEATH){
		GivePlayerMoney(playerid,-(LOSE_MONEY_ON_DEATH)+100);
	} else {
		GivePlayerMoney(playerid,-old_money);
	}
#endif
	return 0;
}