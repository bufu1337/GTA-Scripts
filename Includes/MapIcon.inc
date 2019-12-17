//////////////////////////////////////
/// Icon Control                   ///
///                                ///
///                                ///
///                                ///
///          Copyright by Rafelder ///
//////////////////////////////////////

#define MAX_ICONS 1000
#define MAX_SHOWED_MAPICONS 32 //Don't write more than 32!

new Float:XM[MAX_ICONS];
new Float:YM[MAX_ICONS];
new Float:ZM[MAX_ICONS];

new MarkerM[MAX_ICONS];
new ColorM[MAX_ICONS];

new IsValid[MAX_ICONS];
new Show[MAX_PLAYERS][MAX_ICONS];

new IconidM=-1;
new Set_Timer=0;
new Count=0;
new ShowedForPlayer[MAX_PLAYERS];
forward StreamTimer();


/*
native CreateMapIcon(markerid, color, Float:X, Float:Y, Float:Z);
native DestroyMapIcon(iconid);
native ResetMapIconVariables(playerid);

native IsValidMapIcon(iconid);
native IsIconActivatedForPlayer(playerid, iconid);
native IsIconActivatedForAll(iconid);

native SetMapIconPos(iconid, Float:X, Float:Y, Float:Z);
native SetMapIconIcon(iconid, markerid, color);
native SetMapIconColor(iconid, color);

native GetMapIconPos(iconid, &Float:X, &Float:Y, &Float:Z);
native GetMapIconIcon(iconid);
native GetMapIconColor(iconid);

native ShowMapIconForPlayer(playerid, iconid);
native ShowMapIconForAll(iconid);
native ShowAllMapIconForPlayer(playerid);
native ShowAllMapIconForAll();
native DisableMapIconForPlayer(playerid, iconid);
native DisableMapIconForAll(iconid);
native DisableAllMapIconForPlayer(playerid);
native DisableAllMapIconForAll();
*/

/***************************CREATE***************************/
stock CreateMapIcon(markerid, color, Float:X, Float:Y, Float:Z)
{
	if (Set_Timer == 0) {
	SetTimer("StreamTimer", 200, 1);
	Set_Timer=1;
	}

	if (IconidM >= MAX_ICONS) return 0;
	IconidM++;
	IsValid[IconidM]=1;
	XM[IconidM]=X;
	YM[IconidM]=Y;
	ZM[IconidM]=Z;
	MarkerM[IconidM]=markerid;
	ColorM[IconidM]=color;
	for(new i=0; i<MAX_PLAYERS; i++) {
	Show[i][IconidM]=1;
	}
	return IconidM;
}

stock DestroyMapIcon(iconid) 
{
	IsValid[iconid]=0;
	XM[iconid]=0.0;
	YM[iconid]=0.0;
	ZM[iconid]=0.0;
	MarkerM[iconid]=0;
	ColorM[iconid]=0;
	for(new i=0; i<MAX_PLAYERS; i++)
	Show[i][iconid]=0;
	return 1;
}

stock ResetMapIconVariables(playerid)
{
	for(new i=0; i<MAX_ICONS; i++) {
	Show[playerid][i]=1;
	}
	return 1;
}
/*****************************IS*****************************/
stock IsValidMapIcon(iconid)
{
	if (IsValid[iconid] == 1) return 1;
	return 0;
}


stock IsIconActivatedForPlayer(playerid, iconid)
{
	if (!IsValidMapIcon(icondid)) return 0;
	if (Show[playerid][iconid] == 1) return 1;
	return 0;
}

stock IsIconActivatedForAll(iconid)
{
	if (!IsValidMapIcon(icondid)) return 0;
	for(new i=0; i<MAX_PLAYERS; i++) {
	if (Show[i][iconid] == 1) return 1;
	return 0;
	}
}

/*****************************DO*****************************/
stock SetMapIconPos(iconid, Float:X, Float:Y, Float:Z)
{
	if (!IsValidMapIcon(icondid)) return 0;
	XM[iconid]=X;
	YM[iconid]=Y;
	ZM[iconid]=Z;
	return 1;
}

stock SetMapIconIcon(iconid, markerid, color)
{
	if (!IsValidMapIcon(icondid)) return 0;
	MarkerM[iconid]=markerid;
	ColorM[iconid]=color;
	return 1;
}

stock SetMapIconColor(iconid, color)
{
	if (!IsValidMapIcon(icondid)) return 0;
	ColorM[iconid]=color;
	return 1;
}

stock ShowMapIconForPlayer(playerid, iconid)
{
	if (!IsValidMapIcon(icondid)) return 0;
	Show[playerid][iconid]=1;
	return 1;
}

stock ShowMapIconForAll(iconid)
{
	if (!IsValidMapIcon(icondid)) return 0;
	for(new i=0; i<MAX_PLAYERS; i++)
	if (IsPlayerConnected(i))
	Show[i][iconid]=1;
	return 1;
}

stock ShowAllMapIconForPlayer(playerid)
{
	for(new m=0; m<MAX_ICONS; m++) {
	if (IsValidMapIcon(m))
	Show[playerid][m]=1;
	}
	return 1;
}

stock ShowAllMapIconForAll()
{
	for(new i=0; i<MAX_PLAYERS; i++) {
	if (IsPlayerConnected(i)) {
	for(new m=0; m<MAX_ICONS; m++) {
	if (IsValidMapIcon(m))
	Show[i][m]=1;
	}
	}
	}
	return 1;
}

stock DisableMapIconForPlayer(playerid, iconid)
{
	if (!IsValidMapIcon(icondid)) return 0;
	Show[playerid][iconid]=0;
	return 1;
}

stock DisableMapIconForAll(iconid)
{
	if (!IsValidMapIcon(icondid)) return 0;
	for(new i=0; i<MAX_PLAYERS; i++)
	Show[i][iconid]=0;
	return 1;
}

stock DisableAllMapIconForPlayer(playerid)
{
	for(new m=0; m<MAX_ICONS; m++) {
	if (IsValidMapIcon(m))
	Show[playerid][m]=0;
	}
	return 1;
}

stock DisableAllMapIconForAll()
{
	for(new i=0; i<MAX_PLAYERS; i++) {
	if (IsPlayerConnected(i)) {
	for(new m=0; m<MAX_ICONS; m++) {
	if (IsValidMapIcon(m))
	Show[i][m]=0;
	}
	}
	}
	return 1;
}
/****************************GET*****************************/
stock GetMapIconPos(iconid, &Float:X, &Float:Y, &Float:Z)
{
	if (!IsValidMapIcon(iconid)) return 0;
	X=XM[iconid];
	Y=YM[iconid];
	Z=ZM[iconid];
	return 1;
}

stock GetMapIconIcon(iconid)
{
	if (!IsValidMapIcon(icondid)) return 0;
	return MarkerM[iconid];
}

stock GetMapIconColor(iconid)
{
	if (!IsValidMapIcon(icondid)) return 0;
	return ColorM[inconid];
}
/***************************TIMER*****************************/
public StreamTimer()
{
	for(new i=0; i<MAX_PLAYERS; i++) {
		if (IsPlayerConnected(i)) {
			ShowedForPlayer[i]=0;
			for(new oldm=0; oldm<32; oldm++) {RemovePlayerMapIcon(i, oldm);}
			Count=0;
			for(new m=0; m<MAX_ICONS; m++) {
				if (IsValidMapIcon(m)) {
					if (ShowedForPlayer[i] < MAX_SHOWED_MAPICONS) {
						if (Show[i][m] == 1) {
							if (GetDistanceToMapIcon(i, m) <= 400) {
								SetPlayerMapIcon(i, Count, XM[m], YM[m], ZM[m], MarkerM[m], ColorM[m]);
								ShowedForPlayer[i]++;
								Count++;
							}
						
						}
					}
				}
			}
		}
	}
	return 1;
}
/**************************DISTANCE***************************/
stock GetDistanceToMapIcon(playerid, iconid)
{
	new Float:x1,Float:y1,Float:z1;
	new Float:x2,Float:y2,Float:z2;
	new Float:output;
	GetPlayerPos(playerid, x1, y1, z1);
	GetMapIconPos(iconid, x2, y2, z2);
	output = floatsqroot(floatpower(floatabs(floatsub(x2, x1)), 2)+floatpower(floatabs(floatsub(y2, y1)), 2));
	return floatround(output);
}

