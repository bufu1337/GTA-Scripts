// Zones [ mic_zone ]

/*
native CreateZone(color,Float:x1,Float:y1,Float:x2,Float:y2,Float:x3,Float:y3,Float:x4,Float:y4)
native SetZoneColor(zoneid,color);
native DestroyZone(zoneid);
native IsPlayerInZone(playerid,zoneid);
native IsVehicleidInZone(vehicleid,zoneid);
*/


public SetZoneColor(zoneid,color)
{
GangZoneShowForAll(zoneid,color);
}

public CreateZone(color,Float:x1,Float:y1,Float:x2,Float:y2,Float:x3,Float:y3,Float:x4,Float:y4)
{
new Float:i,Float:j;
new Float:mx,Float:my,Float:MX,Float:MY;
new zoneid;
new cmp1,cmp2,cmp3;

// minimum X
cmp1 = floatcmp(x1,x2);
cmp2 = floatcmp(x3,x4);
if(cmp1 == -1){ i = x1; }
else{ i = x2; }
if(cmp2 == -1){ j = x3; }
else{ j = x4; }
cmp3 = floatcmp(i,j);
if(cmp3 == -1){ mx = i; }
else { mx = j; }

// minimum Y
cmp1 = floatcmp(y1,y2);
cmp2 = floatcmp(y3,y4);
if(cmp1 == -1){ i = y1; }
else{ i = y2; }
if(cmp2 == -1){ j = y3; }
else{ j = y4; }
cmp3 = floatcmp(i,j);
if(cmp3 == -1){ my = i; }
else { my = j; }

// maximum X
cmp1 = floatcmp(x1,x2);
cmp2 = floatcmp(x3,x4);

if(cmp1 == 1){ i = x1; }
else{ i = x2; }
if(cmp2 == 1){ j = x3; }
else{ j = x4; }
cmp3 = floatcmp(i,j);
if(cmp3 == 1){ MX = i; }
else { MX = j; }

// maximum Y
cmp1 = floatcmp(y1,y2);
cmp2 = floatcmp(y3,y4);

if(cmp1 == 1){ i = y1; }
else{ i = y2; }
if(cmp2 == 1){ j = y3; }
else{ j = y4; }
cmp3 = floatcmp(i,j);
if(cmp3 == 1){ MY = i; }
else { MY = j; }

zoneid = GangZoneCreate(mx,my,MX,MY);
ZonemX[zoneid] = mx;
ZonemY[zoneid] = my;
ZoneMX[zoneid] = MX;
ZoneMY[zoneid] = MY;
printf(" mx , my , MX , MY : %f , %f , %f , %f",mx,my,MX,MY);
return zoneid;
}

public DestroyZone(zoneid)
{
GangZoneDestroy(zoneid);

ZonemX[zoneid] = 0;
ZonemY[zoneid] = 0;
ZoneMX[zoneid] = 0;
ZoneMY[zoneid] = 0;
}

public IsPlayerInZone(playerid,zoneid)
{
	new Float:minx = ZonemX[zoneid];
	new Float:miny = ZonemY[zoneid];
	new Float:maxx = ZoneMY[zoneid];
	new Float:maxy = ZoneMY[zoneid];
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if (x > minx && x < maxx && y > miny && y < maxy)
	{
		return 1;
	}
	else
	{
 	return 0;
	}
}

public IsVehicleInZone(vehicleid,zoneid)
{
	new Float:minx = ZonemX[zoneid];
	new Float:miny = ZonemY[zoneid];
	new Float:maxx = ZoneMY[zoneid];
	new Float:maxy = ZoneMY[zoneid];
	new Float:x, Float:y, Float:z;
	GetVehiclePos(vehicleid, x, y, z);
	if (x > minx && x < maxx && y > miny && y < maxy) return 1;
	return 0;

}

public ZoneHandler()
{
new i,j;// i is zoneid, j is playerid
for(i=0;i<=MAX_ZONES;i++){
for(j=0;j<=MAX_ZONES;j++){
if(IsPlayerInZone(j,i)==1){
if(PlayerInZone[i][j] == 0){
PlayerInZone[i][j] = 1;
CallLocalFunction("OnPlayerEnterZone","ii",j,i);
}}
else{
if(PlayerInZone[i][j] == 1){
PlayerInZone[i][j] = 0;
CallLocalFunction("OnPlayerLeaveZone","ii",j,i);
}}
}}}

