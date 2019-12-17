#include <a_samp>

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_DARKGRAY 0x33333366
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BLUE 0x4444C0AA

#define MYSQL_ADDRESS "localhost"
#define MYSQL_NAME "root"
#define MYSQL_PW "abc123"
#define MYSQL_DBNAME "samp"

#define MAX_BOMBS 16
#define MAX_BASES 8

#define FILTERSCRIPT

forward AutoAim(base, playerid, runs, fast, Float:x, Float:y, Float:z);
forward Rotator(base, Float:wanted);
forward GetKeyPressed(code, key);
forward Float:floatrandom(Float:max);
forward Float:GetGroundZ(Float:x, Float:y);
forward FireArtillery(base, playerid, Float:spo, Float:al, Float:r);
forward FireStationaryArtillery(playerid, base);
forward MoveBomb(base, id);
forward FireBomb(playerid, base, id);
forward RenewTowers();
forward Float:GetPlayerDistanceToPoint(playerid, Float:x, Float:y, Float:z);
forward SatelliteScan(base, playerid);
forward MoveScan(base, playerid);
forward AddBase(Float:x, Float:y, Float:z);
forward GetClosestPlayer(Float:x, Float:y, Float:z);
forward Follower(playerid, base, target);
forward RemoveBase(base);
forward ShowControlMenu(playerid, base);
forward HasPlayerControl(playerid, base, sscan);
forward SetRotation(playerid, base, Float:wa);
forward SetAngle(playerid, base, Float:wa);

new Float:sx[MAX_BASES];
new Float:sy[MAX_BASES];
new Float:sz[MAX_BASES];
new Float:flighttime[MAX_BASES][MAX_BOMBS];
new Float:speedo[MAX_BASES][MAX_BOMBS];
new Float:g = 9.81;
new Float:alpha[MAX_BASES][MAX_BOMBS];
new Float:rot[MAX_BASES][MAX_BOMBS];
new bomb[MAX_BASES][MAX_BOMBS];
new bombtimer[MAX_BASES][MAX_BOMBS];
new firecount[MAX_BASES];
new bombcount[MAX_BASES];

new Float:lastcurx[MAX_BASES][MAX_BOMBS];
new Float:curx[MAX_BASES][MAX_BOMBS];
new Float:cury[MAX_BASES][MAX_BOMBS];
new Float:lastcurz[MAX_BASES][MAX_BOMBS];
new Float:curz[MAX_BASES][MAX_BOMBS];
new Float:xo[MAX_BASES][MAX_BOMBS];
new Float:yo[MAX_BASES][MAX_BOMBS];
new Float:sp[MAX_BASES][MAX_BOMBS];

new Float:arotz[MAX_BASES];
new Float:aangle[MAX_BASES];
new Float:apower[MAX_BASES];
new Float:streuung[MAX_BASES];
new delay[MAX_BASES];
new arotator[MAX_BASES];
new Float:tx[MAX_BASES];
new Float:ty[MAX_BASES];
new Float:tz[MAX_BASES];
new Float:t;
new ttimer;
new basecount = 0;

new Float:atime = 0.1;

new Float:scanx[MAX_PLAYERS];
new Float:scany[MAX_PLAYERS];
new Float:scanz[MAX_PLAYERS];
new scanactive[MAX_PLAYERS];
new scanaimed[MAX_PLAYERS];

new followtimer[MAX_BASES];
new followtarget[MAX_BASES];

new atower[MAX_BASES];
new abase[MAX_BASES];

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
        print("\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
        print("X        Artillery filterscript  V0.93      X");
		print("X         created by Mauzen 2008/2009       X");
        print("XxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxX");
		SetTimer("RenewTowers", 60000, 1);
		AddBase(1609.4414,1654.029,23.3);
		AddBase(208.935,1931.253,23.142);

        return 1;
}

public OnFilterScriptExit()
{
        for(new i = 0; i < basecount; i ++) {
            DestroyObject(abase[i]);
            DestroyObject(atower[i]);
		}
		return 1;
}
#endif

public OnPlayerCommandText(playerid, cmdtext[])
{
        new idx;
        new cmd[256];
		cmd = strtok(cmdtext, idx);

		if(strcmp(cmd, "/addbase", true) == 0) {
			if(IsPlayerAdmin(playerid) ) {
				new Float:px;
			    new Float:py;
			    new Float:pz;
			    GetPlayerPos(playerid, px, py, pz);
			    SetPlayerPosFindZ(playerid, px, py, pz + 10);
			    new tmp[64];
			    format(tmp, 64, "Added a new base! ID: %d", AddBase(px, py, pz - 0.5));
				SendClientMessage(playerid, COLOR_RED, tmp);
			} else SendClientMessage(playerid, COLOR_RED, "This is an Admin-Only command!");
			return 1;
		}
		if(strcmp(cmd, "/removebase", true) == 0) {
		    if(IsPlayerAdmin(playerid) ) {
		        new tmp[32];
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
				    SendClientMessage(playerid, COLOR_RED, "Wrong syntax! Use /Removebase <id>");
					return 1;
				}
				RemoveBase(strval(tmp));
				SendClientMessage(playerid, COLOR_BLUE, "Base removed!");
		    } else SendClientMessage(playerid, COLOR_RED, "This is an Admin-Only command!");
			return 1;
		}

		if(strcmp(cmd, "/sscan", true) == 0) {
            new base = strval(strtok(cmdtext, idx));
			if(HasPlayerControl(playerid, base, 1)) {
				SatelliteScan(base, playerid);
			} else SendClientMessage(playerid, COLOR_RED, "You do not have the permittance to do that!");
		    return 1;
		}

		if(strcmp(cmd, "/setrotation", true) == 0) {
			new tmp[32];
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) return 0;
			new base = strval(tmp);
            if(HasPlayerControl(playerid, base, 0)) {
                tmp = strtok(cmdtext, idx);
				if(!strlen(tmp)) return 0;
				new Float:wa = floatstr(tmp);
				SetRotation(playerid, base, wa);
			} else SendClientMessage(playerid, COLOR_RED, "You do not have the permittance to do that!");
			return 1;
		}

		if(strcmp(cmd, "/setfirecount", true) == 0) {
            new base = strval(strtok(cmdtext, idx));
            if(HasPlayerControl(playerid, base, 0)) {
				firecount[base] = strval(strtok(cmdtext, idx));
			    SendClientMessage(playerid, COLOR_YELLOW, "Firecount set!");
		    } else SendClientMessage(playerid, COLOR_RED, "You do not have the permittance to do that!");
		    return 1;
		}

		if(strcmp(cmd, "/setspread", true) == 0) {
            new base = strval(strtok(cmdtext, idx));
            if(HasPlayerControl(playerid, base, 0)) {
				streuung[base] = floatstr(strtok(cmdtext, idx));
			    SendClientMessage(playerid, COLOR_YELLOW, "Spread set!");
		    } else SendClientMessage(playerid, COLOR_RED, "You do not have the permittance to do that!");
		    return 1;
		}

		if(strcmp(cmd, "/setangle", true) == 0) {
            new base = strval(strtok(cmdtext, idx));
			new Float:wa = floatstr(strtok(cmdtext, idx));
            if(HasPlayerControl(playerid, base, 0)) {
			    SetAngle(playerid, base, wa);
				new tmp[64];
				format(tmp, 64, "Base %d: Angle adjusted to %f! Distance changed to ~%dm", base, aangle[base], floatround((floatpower(floatround(apower[base]), 2) / 10) * floatsin(floatround(2 * aangle[base]), degrees)));
				SendClientMessage(playerid, COLOR_YELLOW, tmp);
			} else SendClientMessage(playerid, COLOR_RED, "You do not have the permittance to do that!");
			return 1;
		}

		if(strcmp(cmd, "/setpower", true) == 0) {
            new base = strval(strtok(cmdtext, idx));
            if(HasPlayerControl(playerid, base, 0)) {
				apower[base] = floatstr(strtok(cmdtext, idx));
				new tmp[64];
				format(tmp, 64, "Base %d: Power set to %f! Distance changed to ~%dm", base, apower[base], floatround((floatpower(floatround(apower[base]), 2) / 10) * floatsin(floatround(2 * aangle[base]), degrees)));
				SendClientMessage(playerid, COLOR_YELLOW, tmp);
				t = 0;
            } else SendClientMessage(playerid, COLOR_RED, "You do not have the permittance to do that!");
			return 1;
		}

		if(strcmp(cmd, "/setdelay", true) == 0) {
            new base = strval(strtok(cmdtext, idx));
            if(HasPlayerControl(playerid, base, 0)) {
	            delay[base] = strval(strtok(cmdtext, idx));
				new tmp[64];
				format(tmp, 64, "Base %d: Firedelay adjusted to %d!", base, delay[base]);
				SendClientMessage(playerid, COLOR_YELLOW, tmp);
			} else SendClientMessage(playerid, COLOR_RED, "You do not have the permittance to do that!");
			return 1;
		}

		if(strcmp(cmd, "/fire", true) == 0) {
			new tmp[32] = "0";
			new base;
			while(strlen(tmp)) {
				tmp = strtok(cmdtext, idx);
				if(strlen(tmp) > 0) {
				    base = strval(tmp);
                    if(HasPlayerControl(playerid, base, 0)) FireStationaryArtillery(playerid, base);
				}
			}
			return 1;
		}

		if(strcmp(cmd, "/check", true) == 0) {
			new base = strval(strtok(cmdtext, idx));
            if(HasPlayerControl(playerid, base, 0)) {
				new tmp[64];
				format(tmp, 64, "Parameters - Base %d", base);
				SendClientMessage(playerid, COLOR_BLUE, tmp);
				format(tmp, 64, "Rotation: %f/%f", arotz[base], aangle[base]);
				SendClientMessage(playerid, COLOR_BLUE, tmp);
				format(tmp, 64, "Power: %f (%d bombs/fire)", apower[base], firecount[base]);
				SendClientMessage(playerid, COLOR_BLUE, tmp);
				format(tmp, 64, "Spread: %f", streuung[base]);
				SendClientMessage(playerid, COLOR_BLUE, tmp);
				format(tmp, 64, "Airdistance (estimated): %dm", floatround((floatpower(floatround(apower[base]), 2) / 10) * floatsin(floatround(2 * aangle[base]), degrees)));
				SendClientMessage(playerid, COLOR_BLUE, tmp);
				if(followtimer[base] > -1) {
					format(tmp, 64, " - Following Player %d - ", followtarget[base]);
					SendClientMessage(playerid, COLOR_BLUE, tmp);
				}
            } else SendClientMessage(playerid, COLOR_RED, "You do not have the permittance to do that!");
		    return 1;
		}

		if(strcmp(cmd, "/follow", true) == 0) {
			new base = strval(strtok(cmdtext, idx));
            if(HasPlayerControl(playerid, base, 0)) {
			   	if(followtimer[base] == -1) {
					new tmp[32];
					followtarget[base] = strval(strtok(cmdtext, idx));
					followtimer[base] = SetTimerEx("Follower", 50, 1, "iii", playerid, base, followtarget[base]);
					format(tmp, 64, "Base %d: Following Player %d", base, followtarget[base]);
					SendClientMessage(playerid, COLOR_BLUE, tmp);
					return 1;
				}
			} else SendClientMessage(playerid, COLOR_RED, "You do not have the permittance to do that!");
		}

		if(strcmp(cmd, "/stopfollow", true) == 0) {
			new base = strval(strtok(cmdtext, idx));
            if(HasPlayerControl(playerid, base, 0)) {
				new tmp[32];
			    KillTimer(followtimer[base]);
			    followtimer[base] = -1;
			    format(tmp, 64, "Base %d: Stopped following Player %d", base, followtarget[base]);
				SendClientMessage(playerid, COLOR_BLUE, tmp);
            } else SendClientMessage(playerid, COLOR_RED, "You do not have the permittance to do that!");
			return 1;
		}

		if(strcmp(cmd, "/autoaim", true) == 0) {
		    AutoAim(strval(strtok(cmdtext, idx)), playerid, strval(strtok(cmdtext, idx)), 0, floatstr(strtok(cmdtext, idx)), floatstr(strtok(cmdtext, idx)), floatstr(strtok(cmdtext, idx)));
			return 1;
		}

		if(strcmp(cmd, "/pos", true) == 0) {    //still some debugging stuff - can be used for aiming ;)
			new Float:tax;
			new Float:tay;
			new Float:taz;
			new tmp[64];
			GetPlayerPos(playerid, tax, tay, taz);
			format(tmp, 64, "%f %f %f", tax, tay, taz);
			SendClientMessage(playerid, COLOR_BLUE, tmp);
			return 1;
		}

		return 0;
}


public Follower(playerid, base, target) {
        new Float:tax;
		new Float:tay;
		new Float:taz;
		GetPlayerPos(target, tax, tay, taz);
		AutoAim(base, playerid, 500, 1, tax, tay, taz);
		return 1;
}

public Rotator(base, Float:wanted) {
	//new Float:realrot;
	if((arotz[base] <= wanted) && (arotz[base] + 2 >= wanted)) {
		arotz[base] = wanted;
		SendClientMessage(0, COLOR_YELLOW, "Rotation adjusted!");
		SetObjectRot(atower[base], 0, 0, wanted * -1 + 360.0);
		KillTimer(arotator[base]);
		arotator[base] = -1;
	} else {
	    if(wanted - arotz[base] >= arotz[base] - wanted) arotz[base] += 2.0;
	        else arotz[base] -= 2.0;
	    if(arotz[base] > 360.0) arotz[base] -= 360.0;
	    if(arotz[base] < 0) arotz[base] += 360.0;
	    SetObjectRot(atower[base], 0, 0, arotz[base] * -1 + 360.0);
	}
}

// -----------------------------------------------------------------------------

//useful stuff

strtok(const string[], &index)
{
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

public GetKeyPressed(code, key) {
		for(new i = 65536; i > 0; i = i / 2) {
		    if(code >= i) {
		        code = code - i;
		        if(i == key) return 1;
			}
		}
		return 0;
}

public Float:floatrandom(Float:max) {
		new Float:rand;
		max = max * 100000;
		rand = floatdiv(float(random(floatround(max))), 100000.0);
		return rand;
}

public Float:GetPlayerDistanceToPoint(playerid, Float:x, Float:y, Float:z) {
		new Float:px;
		new Float:py;
		new Float:pz;
		GetPlayerPos(playerid, px, py, pz);
		return floatsqroot( floatadd( floatadd( floatpower(floatsub(x, px), 2), floatpower(floatsub(y, py), 2) ), floatpower(floatsub(z, pz), 2) ) );
}

public GetClosestPlayer(Float:x, Float:y, Float:z) {
		new Float:p;
		new closestp;
		new Float:closest = 999999;
		for(new i = 0; i < MAX_PLAYERS; i++) {
		    if(IsPlayerConnected(i)) {
		        p = GetPlayerDistanceToPoint(i, x, y, z);
		        if(p < closest) {
		            closest = p;
		            closestp = i;
				}
			}
		}
		return closestp;
}

public Float:GetGroundZ(Float:x, Float:y) {
		new Float:gz;
		new Float:px;
		new Float:py;
		GetPlayerPos(GetClosestPlayer(x, y, 0), px, py, gz);
		return gz;
}

// ----------------------- Externalized Controls -------------------------------------
// -----------------------------------------------------------------------------------

public SetRotation(playerid, base, Float:wa) {
	if(followtimer[base] == -1) {
		if(arotator[base] == -1) {
            SendClientMessage(playerid, COLOR_YELLOW, "Adjusting rotation...");
            if(wa > 360.0) {
                while(wa > 360.0) {
                    wa -= 360.0;
				}
			} else if(wa < 0.0) {
				while(wa < 0.0) {
				    wa += 360.0;
				}
			}
			t = 0;
			arotator[base] = SetTimerEx("Rotator", 50, 1, "if", base, wa);
		}
	}
}

public SetAngle(playerid, base, Float:wa) {
    if(wa > 90.0) {
		while(wa > 90.0) {
  			wa -= 90.0;
		}
	} else if(wa < 0.0) {
		while(wa < 0.0) {
		    wa += 90.0;
		}
	}
	aangle[base] = wa;
	t = 0;
}

public SatelliteScan(base, playerid) {
	new Float:startx;
	new Float:starty;
	new Float:startz;
	GetPlayerPos(playerid, startx, starty, startz);
	scanactive[playerid] = SetTimerEx("MoveScan", 50, 1, "ii", base, playerid);
	scanx[playerid] = startx;
	scany[playerid] = starty;
	scanz[playerid] = startz + 5;
	SetPlayerCameraPos(playerid, scanx[playerid], scany[playerid] + 0.01, scanz[playerid]);
	SetPlayerCameraLookAt(playerid, scanx[playerid], scany[playerid], 0);
	TogglePlayerControllable(playerid, 0);
	return 1;
}

public AutoAim(base, playerid, runs, fast, Float:x, Float:y, Float:z) {
	    new Float:w;
	    new Float:v = 50;
	    new Float:wanted;
	    new Float:ox;
		new Float:oy;
		new Float:oz;
	    new updown;
	    new Float:step = 4;
	    tx[base] = x;
	    ty[base] = y;
	    tz[base] = z;
	    GetObjectPos(atower[base], ox, oy, oz);
	    wanted = floatsqroot(floatpower(ox - x, 2) + floatpower(oy - y, 2));
		new i;
		for(i = 0; i < runs; i ++) {
	        w = ( (v * floatcos(aangle[base], degrees)) * (v * floatsin(aangle[base], degrees) + floatsqroot( floatpower(v, 2) * floatpower(floatsin(aangle[base], degrees), 2) + 2 * g * floatsub(oz, z)) ) ) / g;
			if(w < wanted) {
				if(updown == 1) step = step / 4;
				v += step;
				updown = 0;
			} else if(w > wanted) {
			    if(updown == 0) step = step / 4;
			    v -= step;
				updown = 1;
			} else {
			    break;
			}
		}
		z = w;
		apower[base] = v;
		w = atan2(ox - x, oy - y) + 180;
		t = ( v * floatsin(aangle[base], degrees) + floatsqroot( floatpower (v, 2) * floatpower ( floatsin(aangle[base], degrees), 2 ) + 2 * g * floatsub(oz, z) ) ) / g;
		if(!fast) {
			arotator[base] = SetTimerEx("Rotator", 50, 1, "if", base, w);
			new tmp[64];
			format(tmp, 64, "Autoaiming - Base %d", base);
			SendClientMessage(0, COLOR_BLUE, tmp);
	  		format(tmp, 64, "Rotation: %f/%f", arotz[base], aangle[base]);
			SendClientMessage(playerid, COLOR_BLUE, tmp);
			format(tmp, 64, "Power: %f (%d bombs/fire)", apower[base], firecount[base]);
			SendClientMessage(playerid, COLOR_BLUE, tmp);
			format(tmp, 64, "Spread: %f", streuung[base]);
			SendClientMessage(playerid, COLOR_BLUE, tmp);
			format(tmp, 64, "Airdistance (estimated): %dm", floatround((floatpower(floatround(apower[base]), 2) / 10) * floatsin(floatround(2 * aangle[base]), degrees)));
			SendClientMessage(playerid, COLOR_BLUE, tmp);
			//format(tmp, 64, "Tolerance / runs: %f / %d", wanted - z, i); //some debugging stuff
			//SendClientMessage(0, COLOR_BLUE, tmp);
			format(tmp, 64, "Airtime: %f", t);
			SendClientMessage(0, COLOR_BLUE, tmp);
   		} else {
				arotz[base] = w;
				SetObjectRot(atower[base], 0, 0, arotz[base] * -1 + 360.0);
		}
		return 1;
}

public FireStationaryArtillery(playerid, base) {
	if(abase[base] > 0) {
		GetObjectPos(atower[base], sx[base], sy[base], sz[base]);
		sz[base] ++;
		bombcount[base] = 0;
		new id = 0;
		while((id < MAX_BOMBS) && (bombcount[base] < firecount[base])) {
			if(bomb[base][id] == 0) {
				bomb[base][id] = -1;
				curz[base][id] = sz[base];
				flighttime[base][id] = 0.0;
				lastcurz[base][id] = 0.0;
				bombcount[base] ++;
				SetTimerEx("FireBomb", delay[base] * bombcount[base] + 100, 0, "iii", playerid, base, id);
			}
			id ++;
		}
	}
}

public MoveBomb(base, id) {
	lastcurx[base][id] = xo[base][id];
	sp[base][id] = floatsqroot( floatpower(speedo[base][id], 2) - 2 * speedo[base][id] * g * (flighttime[base][id] + 2 * atime) * floatsin(alpha[base][id], degrees) + floatpower(g, 2) * floatpower((flighttime[base][id] + 2 * atime), 2));
	xo[base][id] = speedo[base][id] * floatcos(alpha[base][id], degrees) * (flighttime[base][id] + 2 * atime);
	yo[base][id] = (-1) * (g / 2) * floatpower((flighttime[base][id] + 2 * atime), 2) + speedo[base][id] * floatsin(alpha[base][id], degrees) * (flighttime[base][id] + 2 * atime);

	curx[base][id] = sx[base] + floatsin(rot[base][id], degrees) * xo[base][id];
	cury[base][id] = sy[base] + floatcos(rot[base][id], degrees) * xo[base][id];
	lastcurz[base][id] = curz[base][id];
	curz[base][id] = sz[base] + yo[base][id];
	if(lastcurz[base][id] != 0.0) SetObjectRot(bomb[base][id], atan2(curz[base][id] - lastcurz[base][id], xo[base][id] - lastcurx[base][id]), 0, -1 * rot[base][id]);
		else SetObjectRot(bomb[base][id], alpha[base][id], 0, -1 * rot[base][id]);
	MoveObject(bomb[base][id], curx[base][id], cury[base][id], curz[base][id], sp[base][id]);
	for(new i = 0; i < MAX_PLAYERS; i++) {
	    if(GetPlayerDistanceToPoint(i, curx[base][id], cury[base][id], curz[base][id]) < 5) {
	        //new tmp[64];
			//format(tmp, 64, "Base %d: Bomb %d hit ground", base, id);
			//SendClientMessage(0, COLOR_YELLOW, tmp);
		    CreateExplosion(curx[base][id], cury[base][id], curz[base][id], 6, 6.0);
		    DestroyObject(bomb[base][id]);
		    bomb[base][id] = 0;
		    KillTimer(bombtimer[base][id]);
		    KillTimer(ttimer);
		    RemovePlayerMapIcon(0, 0);
		    SetPlayerMapIcon(0, 0, curx[base][id], cury[base][id], curz[base][id], 19, 0x00000000);
		    break;
		}
	}
	flighttime[base][id] += atime;

	if((curz[base][id] <= GetGroundZ(curx[base][id], cury[base][id]) - 1.5)) {
		//new tmp[64];
		//format(tmp, 64, "Base %d: Bomb %d hit ground", base, id);
		//SendClientMessage(0, COLOR_YELLOW, tmp);
	    CreateExplosion(curx[base][id], cury[base][id], curz[base][id], 6, 6.0);
	    DestroyObject(bomb[base][id]);
	    bomb[base][id] = 0;
	    KillTimer(bombtimer[base][id]);
	    KillTimer(ttimer);
	    RemovePlayerMapIcon(0, 0);
	    SetPlayerMapIcon(0, 0, curx[base][id], cury[base][id], curz[base][id], 19, 0x00000000);
	}
}

public FireBomb(playerid, base, id) {
		if(id == 0 || id == 4 || id == 8 || id == 12) {
			bomb[base][id] = CreateObject(345, sx[base] - 1, sy[base], sz[base] + 1, 0, alpha[base][id], -1 * rot[base][id]);
		} else if(id == 1 || id == 5 || id == 9 || id == 13) {
			bomb[base][id] = CreateObject(345, sx[base] + 1, sy[base], sz[base] + 1, 0, alpha[base][id], -1 * rot[base][id]);
		} else if(id == 2 || id == 6 || id == 10 || id == 14) {
			bomb[base][id] = CreateObject(345, sx[base] + 1, sy[base], sz[base] - 1, 0, alpha[base][id], -1 * rot[base][id]);
		} else if(id == 3 || id == 7 || id == 11 || id == 15) {
			bomb[base][id] = CreateObject(345, sx[base] - 1, sy[base], sz[base] - 1, 0, alpha[base][id], -1 * rot[base][id]);
		} else bomb[base][id] = CreateObject(345, sx[base], sy[base], sz[base], 0, alpha[base][id], -1 * rot[base][id]);
		speedo[base][id] = apower[base] + floatrandom(bombcount[base] * (streuung[base] * 0.5) + 0.2) - bombcount[base] * (streuung[base] * 0.25) - 0.1;
		alpha[base][id] = aangle[base] + floatrandom(bombcount[base] * streuung[base] + 0.4) - bombcount[base] * (streuung[base] / 2) - 0.2;
		rot[base][id] = arotz[base] + floatrandom(bombcount[base] * streuung[base] + 0.4) - bombcount[base] * (streuung[base] / 2) - 0.2;
		bombtimer[base][id] = SetTimerEx("MoveBomb", floatround(atime * 1000), 1, "ii", base, id);
		new tmp[64];
		format(tmp, 64, "Base %d: Bomb %d fired!", base, id);
		SendClientMessage(playerid, COLOR_YELLOW, tmp);
}

public RenewTowers() {
	new Float:x;
	new Float:y;
	new Float:z;
	for(new i = 0; i < basecount; i ++) {
  		GetObjectPos(atower[i], x, y, z);
		DestroyObject(atower[i]);
		DestroyObject(abase[i]);
		atower[i] = CreateObject(3267, x, y, z, 0, 0, -1 * arotz[i] + 360.0);
		abase[i] = CreateObject(3277, x, y, z, 0, 0, 0);
	}
	return 1;
}

public MoveScan(base, playerid) {
	new key1;
	new key2;
	new key3;
	GetPlayerKeys(playerid, key1, key2, key3);
	if(key3 == 65408) {
		scanx[playerid] = scanx[playerid] + 0.02 * scanz[playerid];
	} else if(key3 == 128) {
		scanx[playerid] = scanx[playerid] - 0.02 * scanz[playerid];
	}
	if(key2 == 65408) {
		scany[playerid] = scany[playerid] - 0.02 * scanz[playerid];
	} else if(key2 == 128) {
		scany[playerid] = scany[playerid] + 0.02 * scanz[playerid];
	}
	if(key1 == 32) {
		scanz[playerid] = scanz[playerid] + 1;
	} else if(key1 == 4) {
		scanz[playerid] = scanz[playerid] - 1;
	}
	SetPlayerCameraPos(playerid, scanx[playerid], scany[playerid] + 0.01, scanz[playerid]);
	SetPlayerCameraLookAt(playerid, scanx[playerid], scany[playerid], 0);
	if(key1 == 1) {
	    SetCameraBehindPlayer(playerid);
	    KillTimer(scanactive[playerid]);
	    scanactive[playerid] = 0;
		TogglePlayerControllable(playerid, 1);
		DisablePlayerCheckpoint(playerid);
	}
    if(key1 == 2 && scanaimed[playerid] != 1) {
		if(arotator[base] == -1) {
			AutoAim(base, playerid, 2500, 0, scanx[playerid], scany[playerid], GetGroundZ(scanx[playerid], scany[playerid]));
	        SetPlayerCheckpoint(playerid, scanx[playerid], scany[playerid], GetGroundZ(scanx[playerid], scany[playerid]), streuung[base] * 5);
	        scanaimed[playerid] = 1;
		} else SendClientMessage(playerid, COLOR_YELLOW, "Wait a moment, the tower is still rotating...");
	}
	if(key1 == 0 && scanaimed[playerid] == 1) {
	    scanaimed[playerid] = 0;
	}
	return 1;
}

public AddBase(Float:x, Float:y, Float:z) {
	if(basecount < MAX_BASES) {
		for(new i = 0; i < MAX_BASES; i ++) {
		    if(abase[i] == 0) {
		        atower[i] = CreateObject(3267, x, y, z, 0.0, 0.0, 0.0);
		        abase[i] = CreateObject(3277, x, y, z, 0, 0, 0);
		        arotator[i] = -1;
		        apower[i] = 25;
		        aangle[i] = 45;
		        firecount[i] = 1;
		        streuung[i] = 1;
		        delay[i] = 500;
		        followtimer[i] = -1;
		        basecount ++;
				return i;
			}
		}
	}
	return 0;
}

public RemoveBase(base) {
	if(abase[base] > 0) {
	    DestroyObject(atower[base]);
	    DestroyObject(abase[base]);
	    abase[base] = 0;
	    basecount --;
	}
}

public HasPlayerControl(playerid, base, sscan) {
	if(sscan) {
		//return 1 here, if <playerid> should be allowed to use the satellite aiming mode of base <base>
		//return 0, if he is not
		return 1;
	} else {
		//return 1 here, if <playerid> should be allowed to control everything else of base <base>, like power, rotation and fire
		//return 0, if he is not
		return 1;
	}
}