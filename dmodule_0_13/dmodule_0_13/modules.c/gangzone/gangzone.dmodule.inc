#define MAX_GANG_ZONES							(1024)
#define INVALID_GANG_ZONE						(-1)

// Gang Zones
native GangZoneCreate(Float:minx, Float:miny, Float:maxx, Float:maxy);
native GangZoneDestroy(zone);
native GangZoneShowForAll(zone, color);
native GangZoneHideForAll(zone);
native GangZoneFlashForAll(zone, flashcolor);
native GangZoneStopFlashForAll(zone);
native GangZoneStopFlashForPlayer(playerid, zone);
native GangZoneFlashForPlayer(playerid, zone, flashcolor);
native GangZoneHideForPlayer(playerid, zone);
native GangZoneShowForPlayer(playerid, zone, color);