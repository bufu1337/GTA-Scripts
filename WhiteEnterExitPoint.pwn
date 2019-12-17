/*
 *      Enter Exit entrys (Server Side) [INC]
 *
 *          Uses: foreach; streamer; a_samp
 *          codename: a_enterexits.inc
 *
 *      Created by Lorenc (c)
*/

#include 						<a_samp>
#tryinclude 					<foreach>
#tryinclude 					<streamer>

#define FILE_VERSION            "1.0"

/* FIXES BY LORENC!!!! */
#if !defined foreach
	#define foreach(%1,%2) for (new %2 = 0; %2 < MAX_PLAYERS; %2++) if (IsPlayerConnected(%2))
	#define __SSCANF_FOREACH__
#endif

#if !defined _streamer_included
stock CreateDynamicObject(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid, interiorid, playerid, Float:distance)
{
	#pragma unused worldid
	#pragma unused interiorid
	#pragma unused playerid
	return CreateObject(modelid, x, y, z, rx, ry, rz, distance);
}
stock IsValidDynamicObject(objectid) return IsValidObject(objectid);
stock MoveDynamicObject(objectid, Float: x, Float: y, Float: z, Float: speed) return MoveObject(objectid, x, y, z, speed);
#define _streamer_included
#endif

/* ** Configuration ** */
#define POINT_UPDATE_TICKRATE   1000    //DEFAULT
#define MAX_POINTS         		15
#define MAX_P_STR               24
#define function%1(%2)          forward %1(%2); public%1(%2)
enum P_DATA{
	Float: P_LOCATION_X,
	Float: P_LOCATION_Y,
	Float: P_LOCATION_Z,
	P_OBJECT,
	P_TAG[ MAX_P_STR ],
	bool: P_UP,
	bool: P_CREATED,
}

static
	gPointData					[ MAX_POINTS ][ P_DATA ],
	cp_Count = -1,

	bool: g_Spawned             [ MAX_PLAYERS ],
	bool: g_Entered             [ MAX_PLAYERS ]
;
forward OnPlayerEnterPoint(playerid, pointid);
forward OnPlayerLeavePoint(playerid, pointid);
stock GetTotalPoints() return cp_Count;
stock IsValidPoint(pointid){
	if(gPointData[ pointid ][ P_CREATED ] == true)
		return true;
	else
	    return false;
}
stock DestroyDynamicPoint(pointid){
	if(IsValidPoint(pointid))	{
		DestroyDynamicObject(gPointData[ cp_Count ][ P_OBJECT ]);
		gPointData[ cp_Count ][ P_CREATED ] = false;
	}
}
stock GetPointTag(pointid){
	new tag[ MAX_P_STR ] = "Invalid Point Tag";
	if(IsValidPoint(pointid)) format(tag, sizeof(tag), "%s", gPointData[ cp_Count ][ P_TAG ]);
	return tag;
}
stock CreateDynamicPoint(&id, tag[], Float: x, Float: y, Float: z){
	if(cp_Count > MAX_POINTS) return print("Cannot create anymore points..."), 0;
	cp_Count++;
	id = ( cp_Count );
	gPointData[ cp_Count ][ P_LOCATION_X ] = x;
	gPointData[ cp_Count ][ P_LOCATION_Y ] = y;
	gPointData[ cp_Count ][ P_LOCATION_Z ] = z + 1.0;
	gPointData[ cp_Count ][ P_CREATED ] = true;
	format(gPointData[ cp_Count ][ P_TAG ], MAX_P_STR, "%s", tag);
    gPointData[ cp_Count ][ P_OBJECT ] = CreateDynamicObject(1559, gPointData[ cp_Count ][ P_LOCATION_X ], gPointData[ cp_Count ][ P_LOCATION_Y ], gPointData[ cp_Count ][ P_LOCATION_Z ], 0, 0, 0, -1, -1, -1, 200.0);
	return 1;
}
public OnFilterScriptInit(){
	print("\nThis server is using EnterExits by Lorenc - FILE VERSION ( "#FILE_VERSION" )\n");
	SetTimer("PointUpdate", POINT_UPDATE_TICKRATE, true);
	return CallLocalFunction("enex_OnFilterScriptInit", "");
}
public OnGameModeInit(){
	print("\nThis server is using EnterExits by Lorenc - FILE VERSION ( "#FILE_VERSION" )\n");
	SetTimer("PointUpdate", POINT_UPDATE_TICKRATE, true);
	return CallLocalFunction("enex_OnGameModeInit", "");
}
function PointUpdate(){
    foreach(Player, playerid){
        if(!IsPlayerConnected(playerid)) continue;
		if(g_Spawned[playerid] == true){
	        for(new point; point < MAX_POINTS; point++){
	            if(!IsValidPoint(point)) continue;
	            if(IsValidDynamicObject(gPointData[ point ][ P_OBJECT ])){
				    if(gPointData[point][P_UP] == true)
				    	MoveDynamicObject(gPointData[ point ][ P_OBJECT ], gPointData[ point ][ P_LOCATION_X ], gPointData[ point ][ P_LOCATION_Y ], gPointData[ point ][ P_LOCATION_Z ] - 0.2, 0.9), gPointData[ point ][ P_UP ] = false;
					else
						MoveDynamicObject(gPointData[ point ][ P_OBJECT ], gPointData[ point ][ P_LOCATION_X ], gPointData[ point ][ P_LOCATION_Y ], gPointData[ point ][ P_LOCATION_Z ] + 0.4, 0.9), gPointData[ point ][ P_UP ] = true;
	   			}
              	if(IsPlayerInRangeOfPoint(playerid, 1.0, gPointData[ point ][ P_LOCATION_X ], gPointData[ point ][ P_LOCATION_Y ], gPointData[ point ][ P_LOCATION_Z ] - 1.0) && !GetPVarInt(playerid, "EnteredPoint") && g_Entered[ playerid ] == false){
                   	SetPVarInt(playerid, "EnteredPoint", point);
                    CallLocalFunction("OnPlayerEnterPoint", "dd", playerid, point);
                    g_Entered[playerid] = true;
                    continue;
               	}
               	else if(!IsPlayerInRangeOfPoint(playerid, 1.0, gPointData[ point ][ P_LOCATION_X ], gPointData[ point ][ P_LOCATION_Y ], gPointData[ point ][ P_LOCATION_Z ] - 1.0) && GetPVarInt(playerid, "EnteredPoint") == point && g_Entered[ playerid ] == true){
					CallLocalFunction("OnPlayerLeavePoint", "dd", playerid, GetPVarInt(playerid, "EnteredPoint"));
                    DeletePVar(playerid, "EnteredPoint");
                    g_Entered[playerid] = false;
                    continue;
				}
	        }
		}
    }
}
public OnPlayerDeath(playerid, killerid, reason){
    g_Spawned[ playerid ] = false;
    return CallLocalFunction("enex_OnPlayerDeath", "ddd", playerid, killerid, reason);
}
public OnPlayerSpawn(playerid){
    g_Spawned[ playerid ] = true;
    return CallLocalFunction("enex_OnPlayerSpawn", "d", playerid);
}
public OnPlayerDisconnect(playerid, reason){
    g_Spawned[ playerid ] = false;
    g_Entered[ playerid ] = false;
    return CallLocalFunction("enex_OnPlayerDisconnect", "dd", playerid, reason);
}
public OnPlayerEnterPoint(playerid, pointid){
    return 1;
}

public OnPlayerLeavePoint(playerid, pointid){
    return 1;
}