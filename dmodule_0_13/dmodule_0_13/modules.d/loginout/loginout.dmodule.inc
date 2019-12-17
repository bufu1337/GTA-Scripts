// Version 1.0
loginout_CommandText(playerid, cmdtext[]) {
	dcmd(login,5,cmdtext);
	dcmd(logout,6,cmdtext);
	return 0;
}

	dcmd_login(const playerid, cmdtext[]) {
		if (Val(PlayerAuthed,playerid)) return SystemMsg(playerid,gettext(playerid,LOG_ALREADY));
		if (strlen(cmdtext)==0) {
			SystemMsg(playerid, gettext(playerid,LOG_HOWTO));
			return 1;
		}
		GTATCheckAuth(playerid,PlayerName(playerid),cmdtext);            
		return 1;
	}

	dcmd_logout(const playerid, const cmdtext[]) {
		#pragma unused cmdtext
		if (!Val(PlayerAuthed,playerid)) return SystemMsg(playerid,gettext(playerid,LOG_NOTYET));
		SetVal(PlayerAuthed,playerid,0);
		return 1;
	}

loginout_GTATAuthFailure(playerid,reason[]) {
	SystemMsg(playerid, reason);
}

loginout_GTATAuthSuccess(playerid) {
	SystemMsg(playerid, gettext(playerid,LOG_SUCCESS));
}