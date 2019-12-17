#include <a_samp>
#include <a_mysql>
#include <zcmd>
#include <sscanf2>
#include <streamer>
#include <crashdetect>

#define MYSQL_HOST  "localhost"
#define MYSQL_USER  "root"
#define MYSQL_UPASS ""
#define MYSQL_DB    "inventory"

#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define PLAYERS 24

#define MAX_GLOBAL_OBJECTS  1536
#define MAX_OBJECT_ACTIONS  3

new PlayerText:Inv[PLAYERS][24],
    PlayerText:GeneralTxt[PLAYERS][5],
    PlayerText:InventoryObjectsHead[PLAYERS][4][4],
    PlayerText:InventoryObjectsSlots[PLAYERS][7*5][4],
    PlayerText:GlobalObjectsHead[PLAYERS][4][4],
    PlayerText:GlobalObjectsSlots[PLAYERS][7*5][4],
    PlayerText:ActionMenu[PLAYERS][5],
    /*actions*/
    action[PLAYERS][3],
    actionname[PLAYERS][3][24],
    objecttype[PLAYERS],
    objectorigin[PLAYERS],
    memoryslot[PLAYERS][2],
    objectuses[PLAYERS][2], // 0 will store current uses, 1 will store current total uses
    objectflags[PLAYERS][5], // 0, 1 & 4: `objects` flags; 2 & 3: `playerobjects`
    Float:headerystored[PLAYERS][4],

    /*player objects*/
    objectsstored[PLAYERS][35][4],
    slotused[PLAYERS][35][4],
    slots[PLAYERS][4],
    slotbelongsto[PLAYERS][4],
	objectcap[PLAYERS][4],
	objectsize[PLAYERS][35][4],
	objectdisplay[PLAYERS][35][4],
	objecttypes[PLAYERS][35][4],
	objectscap[PLAYERS][35][4],
	containerdisplay[PLAYERS][4],
	containertype[PLAYERS][4],
	containersize[PLAYERS][4],

	container[PLAYERS][4], //when listing object headers to store their actual Object ID
	/*global objects*/
	g_objectsstored[PLAYERS][35][4],
	g_slotused[PLAYERS][35][4],
	g_objectsize[PLAYERS][35][4],
	g_objectdisplay[PLAYERS][35][4],
	g_objectscap[PLAYERS][35][4],
	g_slots[PLAYERS][4],
	g_slotbelongsto[PLAYERS][4],
	g_objectcap[PLAYERS][4],
	g_container[PLAYERS][4],
	g_objecttypes[PLAYERS][35][4],
	g_containerdisplay[PLAYERS][4],
	g_containertype[PLAYERS][4],
	g_containersize[PLAYERS][4],
	
	
	listing[PLAYERS][10],
	
    HideTDTimer[PLAYERS][5];
new dbHandle, query[128], medquery[256], bigquery[512], infquery[2048], nname[24], msg[144];


enum GlobalObjectInfo
{
	PlayerID,
	RealID,
	O_Name[32],
	Size,
	TypeID,
	Carry,
	Display,
	Position,
	Status,
	GameObject,
	AreaID,
	IsNear[PLAYERS],
	Float:WorldX,
	Float:WorldY,
	Float:WorldZ
}

new GlobalObject[MAX_GLOBAL_OBJECTS][GlobalObjectInfo];

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" 	Inventory script by CuervO			");
	print("Objects, Inventory, Actions - All In One!");
	print("--------------------------------------\n");
	
	ConnectMySQL();
	
	for(new i = 0; i < PLAYERS; i ++)
	    if(IsPlayerConnected(i))
	        OnPlayerConnect(i);
	
	return 1;
}

forward LoadGlobalObjects();
public LoadGlobalObjects()
{
	new rows, fields;
	cache_get_data(rows, fields);
	for(new i = 0; i < rows; i ++)
	{
	    if(cache_get_field_content_int(i, "PlayerObjectStatus") == 4)
	    {
            RemoveObjectFromDatabase(cache_get_field_content_int(i, "PID"), true);
            continue;
		}
            
	    GlobalObject[i][PlayerID] = cache_get_field_content_int(i, "PID");
	    GlobalObject[i][RealID] = cache_get_field_content_int(i, "ID");
	    
	    new temp[32];
	    cache_get_field_content(i, "Name", temp);
	    format(GlobalObject[i][O_Name], 32, "%s", temp);
	    
        GlobalObject[i][Size] = cache_get_field_content_int(i, "H_Size");
        GlobalObject[i][TypeID] = cache_get_field_content_int(i, "TypeID");
        GlobalObject[i][Carry] = cache_get_field_content_int(i, "Carry");
        GlobalObject[i][Display] = cache_get_field_content_int(i, "Display");
        GlobalObject[i][Position] = cache_get_field_content_int(i, "Position");
        GlobalObject[i][Status] = cache_get_field_content_int(i, "PlayerObjectStatus");
        GlobalObject[i][WorldX] = cache_get_field_content_float(i, "WorldX");
        GlobalObject[i][WorldY] = cache_get_field_content_float(i, "WorldY");
        GlobalObject[i][WorldZ] = cache_get_field_content_float(i, "WorldZ");

		GlobalObject[i][GameObject] = CreateDynamicObject(GlobalObject[i][Display], GlobalObject[i][WorldX], GlobalObject[i][WorldY], GlobalObject[i][WorldZ], 0.0, 0.0, 0.0);
		GlobalObject[i][AreaID] = CreateDynamicRectangle(GlobalObject[i][WorldX]-1, GlobalObject[i][WorldY]-1, GlobalObject[i][WorldX]+1, GlobalObject[i][WorldY]+1);
	}
	print("[INVENTORY SUCCESS]: Loaded all the global objects.");
	return 1;
}


public OnFilterScriptExit()
{
    for(new i = 0; i < PLAYERS; i ++)
	    if(IsPlayerConnected(i))
	        OnPlayerDisconnect(i, 1);

	for(new i = 0; i < MAX_GLOBAL_OBJECTS; i ++)
	{
	    if(GlobalObject[i][PlayerID] != 0)
	    {
	        DestroyDynamicObject(GlobalObject[i][GameObject]);
	        DestroyDynamicArea(GlobalObject[i][AreaID]);
	    }
	}
	
	for(new a = 0; a < MAX_GLOBAL_OBJECTS; a ++)
		GlobalObject[a][PlayerID] = 0;
		
	return 1;
}



forward ConnectMySQL();
public ConnectMySQL()
{
    mysql_close(1);
  	mysql_log(LOG_ERROR | LOG_WARNING | LOG_DEBUG);
	dbHandle = mysql_connect(MYSQL_HOST,MYSQL_USER,MYSQL_DB,MYSQL_UPASS);
	if (!mysql_errno())
	{
	    print("[INVENTORY SUCCESS]: Connection to database succcessfully establishied.");
	    
	    mysql_format(dbHandle, medquery, sizeof medquery, "SELECT * FROM playerobjects \
		JOIN objects ON playerobjects.O_ObjectID = objects.ID WHERE playerobjects.PlayerObjectStatus = 3 OR playerobjects.PlayerObjectStatus = 4");
		mysql_tquery(dbHandle, medquery, "LoadGlobalObjects", "");
	    return 1;
	}
	else
	{
		print("[CRITICAL INVENTORY]: Connection to database could not pass. Filterscript wont work.");
		return 0;
	}
}

public OnPlayerConnect(playerid)
{
	CreateInventory(playerid);
	CreatePlayerTextdraws(playerid);
	
	for(new i; i != sizeof InventoryObjectsHead[]; ++i)
        InventoryObjectsHead[playerid][i][0] = PlayerText:INVALID_TEXT_DRAW,
        InventoryObjectsHead[playerid][i][2] = PlayerText:INVALID_TEXT_DRAW,
        InventoryObjectsHead[playerid][i][3] = PlayerText:INVALID_TEXT_DRAW,
        InventoryObjectsHead[playerid][i][1] = PlayerText:INVALID_TEXT_DRAW;
	
	for(new i; i != sizeof InventoryObjectsSlots[]; ++i)
        InventoryObjectsSlots[playerid][i][0] = PlayerText:INVALID_TEXT_DRAW,
        InventoryObjectsSlots[playerid][i][2] = PlayerText:INVALID_TEXT_DRAW,
        InventoryObjectsSlots[playerid][i][3] = PlayerText:INVALID_TEXT_DRAW,
        InventoryObjectsSlots[playerid][i][1] = PlayerText:INVALID_TEXT_DRAW;
        
    for(new i; i != sizeof GlobalObjectsHead[]; ++i)
        GlobalObjectsHead[playerid][i][0] = PlayerText:INVALID_TEXT_DRAW,
        GlobalObjectsHead[playerid][i][2] = PlayerText:INVALID_TEXT_DRAW,
        GlobalObjectsHead[playerid][i][3] = PlayerText:INVALID_TEXT_DRAW,
        GlobalObjectsHead[playerid][i][1] = PlayerText:INVALID_TEXT_DRAW;

	for(new i; i != sizeof GlobalObjectsSlots[]; ++i)
        GlobalObjectsSlots[playerid][i][0] = PlayerText:INVALID_TEXT_DRAW,
        GlobalObjectsSlots[playerid][i][2] = PlayerText:INVALID_TEXT_DRAW,
        GlobalObjectsSlots[playerid][i][3] = PlayerText:INVALID_TEXT_DRAW,
        GlobalObjectsSlots[playerid][i][1] = PlayerText:INVALID_TEXT_DRAW;
        
    for(new i; i != sizeof ActionMenu[]; ++i)
        ActionMenu[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
	
	for(new i = 0; i < sizeof(objectsstored[]); i ++)
	{
	    for(new a = 0; a < 4; a ++)
	    {
		    objectsstored[playerid][i][a] = 0;
		    slotused[playerid][i][a] = -1;
		    objectsize[playerid][i][a] = 0;
		    objectdisplay[playerid][i][a] = 0;
		    objecttypes[playerid][i][a] = 0;
		    objectscap[playerid][i][a] = 0;
		    
		    g_objectsstored[playerid][i][a] = 0;
		    g_slotused[playerid][i][a] = -1;
		    g_objectsize[playerid][i][a] = 0;
		    g_objectdisplay[playerid][i][a] = 0;
		    g_objecttypes[playerid][i][a] = 0;
		    g_objectscap[playerid][i][a] = 0;
		}
	}
	for(new a = 0; a < 4; a ++)
	{
	    slots[playerid][a] = 0;
		slotbelongsto[playerid][a] = 0;
		objectcap[playerid][a] = 0;
		
		g_slots[playerid][a] = 0;
		g_slotbelongsto[playerid][a] = 0;
		g_objectcap[playerid][a] = 0;

		container[playerid][a] = 0;
		g_container[playerid][a] = 0;
		containerdisplay[playerid][a] = 0;
		g_containerdisplay[playerid][a] = 0;
		containertype[playerid][a] = 0;
		g_containertype[playerid][a] = 0;
		containersize[playerid][a] = 0;
		g_containersize[playerid][a] = 0;
	}
	
	for(new i = 0; i < MAX_GLOBAL_OBJECTS; i ++)
	{
	    if(GlobalObject[i][PlayerID] == 0) continue;

	   	GlobalObject[i][IsNear][playerid] = 0;
	}

	SetPVarInt(playerid, "DisplayingPage", 0);
	SetPVarInt(playerid, "SelectedContainer", 0);
	return 1;
}


public OnPlayerUpdate(playerid)
{
	if(GetPVarInt(playerid,"OnHand") != 0)
	{
	    new ammo, weapon;
	    GetPlayerWeaponData(playerid, GetWeaponSlot(GetPVarInt(playerid,"OnHandWeapon")), weapon, ammo);
	    
	    if(GetPVarInt(playerid,"OnHandWeapon") != GetPlayerWeapon(playerid) && ammo != 0)
	        if(ammo > 0)
		        SetPlayerArmedWeapon(playerid, GetPVarInt(playerid,"OnHandWeapon"));

        if(ammo <= 0)
			SetPlayerArmedWeapon(playerid, 0);
		
	}

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    if(GetPVarInt(playerid,"OnHandWeapon") != 0)
    {
		OnPlayerRemoveWeaponFromHand(playerid);
    }
	if(GetPVarInt(playerid,"OnHand") != 0)
	{
		SetPVarInt(playerid,"OnHand", 0);
     	RemovePlayerAttachedObject(playerid, 0);
	}

    SetPVarInt(playerid,"SwappingStep", 0);
	DestroyInventory(playerid);
	DestroyPlayerTextdraws(playerid);
	DestroyInventoryObjects(playerid);
	DestroyActions(playerid);
	DestroyNearInventoryObjects(playerid);
	return 1;
}

CMD:spawnobject(playerid, params[])
{
	new id[32];
	if(sscanf(params,"s[32]", id)) return Usage(playerid,"/spawnobject <object id or (part of) name>");

    new Float:fX,Float:fY,Float:fZ;
    GetPlayerPos(playerid, fX, fY, fZ);
    GetXYInFrontOfPlayer(playerid,fX,fY,1.0);

	SetPVarInt(playerid,"SearchPhase", 1);

	if(IsNumeric(id))
	{
		mysql_format(dbHandle, query, sizeof query, "SELECT * FROM objects WHERE ID = %d LIMIT 0,1",strval(id));
		mysql_tquery(dbHandle, query, "SpawnObject", "fffisiii", fX,fY,fZ, playerid, id,-1,0,3);
	}
	else
	{
	    mysql_format(dbHandle, query, sizeof query, "SELECT * FROM objects WHERE Name = '%e'",id);
	    mysql_tquery(dbHandle, query, "SpawnObject", "fffisiii", fX,fY,fZ, playerid, id,-1,0,3);
	}
	return 1;
}

CMD:remobject(playerid, params[])
{
	new id[32];
	if(sscanf(params,"s[32]", id)) return Usage(playerid,"/remobject <object id or (full) name>");

	if(IsNumeric(id))
		mysql_format(dbHandle, query, sizeof query, "DELETE FROM objects WHERE ID = %d",strval(id));
	else
	    mysql_format(dbHandle, query, sizeof query, "DELETE FROM objects WHERE Name = '%e'",id);

	mysql_tquery(dbHandle, query);
	return 1;
}

stock SpawnObjectOnPosition(const ObjectName[], Uses, Condition, Float:fX, Float:fY, Float:fZ)
{
    if(IsNumeric(ObjectName))
	{
		mysql_format(dbHandle, query, sizeof query, "SELECT * FROM objects WHERE ID = %d LIMIT 0,1",strval(id));
		mysql_tquery(dbHandle, query, "SpawnObject", "fffisiii", fX,fY,fZ, -1, id, Uses, Condition, 4);
	}
	else
	{
	    mysql_format(dbHandle, query, sizeof query, "SELECT * FROM objects WHERE Name = '%e'",id);
	    mysql_tquery(dbHandle, query, "SpawnObject", "fffisiii", fX,fY,fZ, -1, id, Uses, Condition, 4);
	}
	return 1:
}



forward SpawnObject(Float:fX,Float:fY,Float:fZ,playerid, const Obj[], uses, condition, type);
public SpawnObject(Float:fX,Float:fY,Float:fZ,playerid, const Obj[], uses, condition, type)
{
    new rows, fields;
    cache_get_data(rows, fields);
    if(rows)
    {
        if(uses == -1)
            uses = cache_get_field_content_int(0, "Uses");
    
		mysql_format(dbHandle, medquery, sizeof medquery, "INSERT INTO playerobjects (O_ObjectID, Uses, TotalUses, PlayerObjectStatus) VALUES (%d, %d, %d, %d)",
		cache_get_field_content_int(0, "ID"), uses, cache_get_field_content_int(0, "Uses"), type);
		mysql_tquery(dbHandle, medquery, "OnNewObjectAdded", "fffi",fX,fY,fZ,type);
    }
    else
    {
        if(playerid != -1)
        {
	        if(!IsNumeric(Obj))
	        {
		        if(GetPVarInt(playerid,"SearchPhase") == 2)
		        {

		        	TDError(playerid,"No such object.");
		            SetPVarInt(playerid,"SearchPhase", 0);
				}
				else
				{
				    SetPVarInt(playerid,"SearchPhase",2);
				    mysql_format(dbHandle, query, sizeof query, "SELECT * FROM objects WHERE Name LIKE('%%%e%%') LIMIT 0,1",Obj);
				    mysql_tquery(dbHandle, query, "SpawnObject", "fffisiii", fX,fY,fZ, playerid, Obj, uses, condition, type);

				}
			}
			else
			{
			    if(playerid != -1)
		        	TDError(playerid,"No such object.");
			}
		}
	}

	return 1;
}

forward OnNewObjectAdded(Float:fX,Float:fY,Float:fZ, status);
public OnNewObjectAdded(Float:fX,Float:fY,Float:fZ, status)
{
    mysql_format(dbHandle, query, sizeof query, "INSERT INTO objectinventory (OI_ObjectID) VALUES (%d)",cache_insert_id());
	mysql_tquery(dbHandle, query);

    mysql_format(dbHandle, medquery, sizeof medquery, "SELECT * FROM playerobjects \
	JOIN objects ON playerobjects.O_ObjectID = objects.ID WHERE playerobjects.PID = %d", cache_insert_id());
	mysql_tquery(dbHandle, medquery, "DropObjectOnPosition", "iifffi",-1, cache_insert_id(), fX, fY, fZ, status);
	return 1;
}

CMD:actions(playerid, params[])
{
    if(!IsPlayerAdmin(playerid))
        return 0;

    new actionid;
	sscanf(params,"i",action);

	if(actionid == 0)
	{
	    mysql_format(dbHandle, medquery, 256, "SELECT * FROM actions ORDER BY `TypeID`");
		mysql_tquery(dbHandle, medquery, "OnPlayerRequestListActions", "i", playerid);

		SetPVarInt(playerid, "listviewingmax", 10);
	    SetPVarInt(playerid, "listviewingmin", 0);
	}
    else
    {
        mysql_format(dbHandle, medquery, 256,
		"SELECT actions.ActionID, actions.TypeID, actions.Action, types.TypeChar \
		FROM actions JOIN types ON actions.TypeID = types.TID \
		WHERE ActionID = %d",actionid);
		mysql_tquery(dbHandle, medquery, "OnPlayerRequestEditAction", "ii", playerid, actionid);

		SetPVarInt(playerid, "listviewingmax", 10);
	    SetPVarInt(playerid, "listviewingmin", 0);
    }
	return 1;
}

CMD:newaction(playerid, params[])
{
    if(!IsPlayerAdmin(playerid))
        return 0;

    if(!isnull(params)) return Usage(playerid,"/newaction");

    mysql_format(dbHandle, query, 128, "INSERT INTO `actions` (Action,TypeID) VALUES ('New_Action',0)");
	mysql_tquery(dbHandle, query, "OnPlayerCreateAction", "i", playerid);

	SetPVarInt(playerid, "listviewingmax", 10);
	SetPVarInt(playerid, "listviewingmin", 0);
	return 1;
}

CMD:remaction(playerid, params[])
{
	new id[32];
	if(sscanf(params,"s[32]", id)) return Usage(playerid,"/remaction <object id or name>");

	if(IsNumeric(id))
		mysql_format(dbHandle, query, sizeof query, "DELETE FROM actions WHERE ActionID = %d",strval(id));
	else
	    mysql_format(dbHandle, query, sizeof query, "DELETE FROM actions WHERE Action = '%s'",id);

	mysql_tquery(dbHandle, query);
	return 1;
}

CMD:types(playerid, params[])
{
    if(!IsPlayerAdmin(playerid))
        return 0;

    new type;
	sscanf(params,"i",type);

	if(type == 0)
	{
	    mysql_format(dbHandle, medquery, 256, "SELECT * FROM types ORDER BY `TID`");
		mysql_tquery(dbHandle, medquery, "OnPlayerRequestListTypes", "i", playerid);

		SetPVarInt(playerid, "listviewingmax", 10);
	    SetPVarInt(playerid, "listviewingmin", 0);
	}
    else
    {
        mysql_format(dbHandle, medquery, 256, "SELECT * FROM types WHERE TID = %d",type);
		mysql_tquery(dbHandle, medquery, "OnPlayerRequestEditType", "ii", playerid, type);

		SetPVarInt(playerid, "listviewingmax", 10);
	    SetPVarInt(playerid, "listviewingmin", 0);
    }
	return 1;
}

CMD:newtype(playerid, params[])
{
    if(!IsPlayerAdmin(playerid))
        return 0;

    if(!isnull(params)) return Usage(playerid,"/newtype");

    mysql_format(dbHandle, query, 128, "INSERT INTO `types` (TypeChar,TypeInt) VALUES ('New_Type',-1)");
	mysql_tquery(dbHandle, query, "OnPlayerCreateType", "i", playerid);

	SetPVarInt(playerid, "listviewingmax", 10);
	SetPVarInt(playerid, "listviewingmin", 0);
	return 1;
}

CMD:remtype(playerid, params[])
{
	new id[32];
	if(sscanf(params,"s[32]", id)) return Usage(playerid,"/remtype <object id or name>");

	if(IsNumeric(id))
		mysql_format(dbHandle, query, sizeof query, "DELETE FROM types WHERE TID = %d",strval(id));
	else
	    mysql_format(dbHandle, query, sizeof query, "DELETE FROM types WHERE TypeChar = '%s'",id);

	mysql_tquery(dbHandle, query);
	return 1;
}


CMD:objects(playerid, params[])
{
    if(!IsPlayerAdmin(playerid))
        return 0;

    new object;
	sscanf(params,"i",object);
	
	if(object == 0)
	{
	    mysql_format(dbHandle, query, 128, "SELECT * FROM `objects` JOIN types ON objects.TypeID = types.TypeInt ORDER BY `ID`");
		mysql_tquery(dbHandle, query, "OnPlayerRequestListObjects", "i", playerid);

		SetPVarInt(playerid, "listviewingmax", 10);
	    SetPVarInt(playerid, "listviewingmin", 0);
	}
    else
    {
        mysql_format(dbHandle, query, sizeof(query),"SELECT * FROM `objects` JOIN types ON objects.TypeID = types.TypeInt WHERE `ID` = %d", object);
		mysql_tquery(dbHandle, query, "OnPlayerRequestEditObject", "ii", playerid, object);
		
		SetPVarInt(playerid, "listviewingmax", 10);
	    SetPVarInt(playerid, "listviewingmin", 0);
    }

    
	return 1;
}

CMD:newobject(playerid, params[])
{
    if(!IsPlayerAdmin(playerid))
        return 0;

    if(!isnull(params)) return Usage(playerid,"/newobject");

    mysql_format(dbHandle, query, 128, "INSERT INTO `objects` (Name) VALUES ('New_Object')");
	mysql_tquery(dbHandle, query, "OnPlayerCreateObject", "i", playerid);
	
	SetPVarInt(playerid, "listviewingmax", 10);
	SetPVarInt(playerid, "listviewingmin", 0);
	return 1;
}





forward OnPlayerCreateObject(playerid);
public OnPlayerCreateObject(playerid)
{
    mysql_format(dbHandle, query, sizeof(query),"SELECT * FROM `objects` JOIN types ON objects.TypeID = types.TypeInt WHERE `ID` = %d", cache_insert_id());
	mysql_tquery(dbHandle, query, "OnPlayerRequestEditObject", "ii", playerid, cache_insert_id());
	return 1;
}


forward OnPlayerRequestListObjects(playerid);
public OnPlayerRequestListObjects(playerid)
{
    new rows, fields, characterstr[1536], result[32];
    cache_get_data(rows, fields);
    if(rows)
    {
        new title[64], temp, internal;
        SetPVarInt(playerid, "listviewingtotal", rows);
        new objects = GetPVarInt(playerid,"listviewingmin");
        
        for(new i = 0; i < 10; i ++)
            listing[playerid][i] = -1;

        while(objects < rows && objects < GetPVarInt(playerid,"listviewingmax"))
        {
            temp = cache_get_field_content_int(objects, "ID");
            format(characterstr, 1536, "%s{FF6600}ID: {FFFFFF}%02d",characterstr,temp);
            listing[playerid][internal] = temp;

            cache_get_field_content(objects, "Name", result);
			format(characterstr, 1536, "%s\t{FF6600}Name: {FFFFFF}%s",characterstr, result);
			if(strlen(result) < 8)
			    format(characterstr, 1536, "%s\t\t",characterstr);
			else if(strlen(result) < 16)
			    format(characterstr, 1536, "%s\t",characterstr);


            cache_get_field_content(objects, "TypeChar", result);
			format(characterstr, 1536, "%s\t{FF6600}Type: {FFFFFF}%s",characterstr, result);

			format(characterstr, 1536, "%s\n",characterstr);
			objects ++;
			internal ++;
        }

        if(rows > 10)
        {
            new Float:totalpages;
			new Float:currentpage;

			totalpages = floatround(rows/10.0, floatround_ceil);
			currentpage = floatround(GetPVarInt(playerid,"listviewingmax")/10.0, floatround_ceil);

            format(title, sizeof(title),"{FFFFFF}Click the object to edit it. {BBBBBB}(%d/%d)", floatround(currentpage), floatround(totalpages));
            ShowPlayerDialog(playerid, 900, DIALOG_STYLE_LIST, title,characterstr,"Expand","Next >");
        }
        else
        {
            ShowPlayerDialog(playerid, 900, DIALOG_STYLE_LIST, "Select the list item to edit object",characterstr,"Expand","Exit");
        }
    }
    else
    {
        TDInfo(playerid, "Invalid objects.");
        return 1;
	}

	return 1;
}

forward OnPlayerRequestEditObject(playerid, ObjectID);
public OnPlayerRequestEditObject(playerid, ObjectID)
{
	new rows, fields;
    cache_get_data(rows, fields);
    if(rows)
    {
		new listingmessage[1024 + 512];
		new title[32], tempresult[32];
		format(title, sizeof title,"Object ID %d Edition", cache_get_field_content_int(0, "ID"));
		
		cache_get_field_content(0, "Name", tempresult);
		format(listingmessage, sizeof listingmessage, "{FF6600}Name:\t\t{FFFFFF}%s\n",tempresult);
		format(listingmessage, sizeof listingmessage, "%s{FF6600}Size:\t\t{FFFFFF}%d\n",listingmessage, cache_get_field_content_int(0, "H_Size"));
		cache_get_field_content(0, "TypeChar", tempresult);
        format(listingmessage, sizeof listingmessage, "%s{FF6600}Type:\t\t{FFFFFF}%s\n",listingmessage, tempresult);
        format(listingmessage, sizeof listingmessage, "%s{FF6600}Slots:\t\t{FFFFFF}%d\n",listingmessage, cache_get_field_content_int(0, "Carry"));
        format(listingmessage, sizeof listingmessage, "%s{FF6600}Max Uses:\t{FFFFFF}%d\n",listingmessage, cache_get_field_content_int(0, "Uses"));
        format(listingmessage, sizeof listingmessage, "%s{FF6600}Display:\t\t{FFFFFF}%d\n",listingmessage, cache_get_field_content_int(0, "Display"));
        format(listingmessage, sizeof listingmessage, "%s{FF6600}Display Zoom:\t{FFFFFF}%.1f\n",listingmessage, cache_get_field_content_float(0, "DisplayZoom"));
        format(listingmessage, sizeof listingmessage, "%s{FF6600}Display X:\t{FFFFFF}%.1f\n",listingmessage, cache_get_field_content_float(0, "DisplayXOffset"));
        format(listingmessage, sizeof listingmessage, "%s{FF6600}Display Y:\t{FFFFFF}%.1f\n",listingmessage, cache_get_field_content_float(0, "DisplayYOffset"));
        format(listingmessage, sizeof listingmessage, "%s{FF6600}Display Z:\t{FFFFFF}%.1f\n",listingmessage, cache_get_field_content_float(0, "DisplayZOffset"));
        format(listingmessage, sizeof listingmessage, "%s{FF6600}Display Color:\t{FFFFFF}%08x\n",listingmessage, cache_get_field_content_int(0, "DisplayColor"));
        format(listingmessage, sizeof listingmessage, "%s{FF6600}Flag 1:\t\t{FFFFFF}%d\n",listingmessage, cache_get_field_content_int(0, "SpecialFlag_1"));
        format(listingmessage, sizeof listingmessage, "%s{FF6600}Flag 2:\t\t{FFFFFF}%d\n",listingmessage, cache_get_field_content_int(0, "SpecialFlag_2"));
        format(listingmessage, sizeof listingmessage, "%s{FF6600}Flag 3:\t\t{FFFFFF}%d\n",listingmessage, cache_get_field_content_int(0, "SpecialFlag_3"));
        
        SetPVarInt(playerid, "EdittingObject", ObjectID);
        ShowPlayerDialog(playerid, 901, DIALOG_STYLE_LIST, title, listingmessage, "Edit", "Exit");
	}
	else
	{
	    TDError(playerid,"Invalid object.");
	}
	return 1;
}

forward OnPlayerRequestListTypes(playerid);
public OnPlayerRequestListTypes(playerid)
{
    new rows, fields, characterstr[1536], result[32];
    cache_get_data(rows, fields);
    if(rows)
    {
        new title[64], temp, internal;
        SetPVarInt(playerid, "listviewingtotal", rows);
        new objects = GetPVarInt(playerid,"listviewingmin");

        for(new i = 0; i < 10; i ++)
            listing[playerid][i] = -1;

        while(objects < rows && objects < GetPVarInt(playerid,"listviewingmax"))
        {
            temp = cache_get_field_content_int(objects, "TID");
            format(characterstr, 1536, "%s{FF6600}ID: {FFFFFF}%02d",characterstr,temp);
            listing[playerid][internal] = temp;
            
            temp = cache_get_field_content_int(objects, "TypeInt");
            format(characterstr, 1536, "%s\t{FF6600}Number: {FFFFFF}%02d",characterstr,temp);

            cache_get_field_content(objects, "TypeChar", result);
			format(characterstr, 1536, "%s\t{FF6600}Name: {FFFFFF}%s",characterstr, result);

			format(characterstr, 1536, "%s\n",characterstr);
			objects ++;
			internal ++;
        }

        if(rows > 10)
        {
            new Float:totalpages;
			new Float:currentpage;

			totalpages = floatround(rows/10.0, floatround_ceil);
			currentpage = floatround(GetPVarInt(playerid,"listviewingmax")/10.0, floatround_ceil);

            format(title, sizeof(title),"{FFFFFF}Click the type to edit it. {BBBBBB}(%d/%d)", floatround(currentpage), floatround(totalpages));
            ShowPlayerDialog(playerid, 950, DIALOG_STYLE_LIST, title,characterstr,"Expand","Next >");
        }
        else
        {
            ShowPlayerDialog(playerid, 950, DIALOG_STYLE_LIST, "Select the list item to edit type",characterstr,"Expand","Exit");
        }
    }
    else
    {
        TDInfo(playerid, "Invalid types.");
        return 1;
	}

	return 1;
}

forward OnPlayerRequestEditType(playerid, ObjectID);
public OnPlayerRequestEditType(playerid, ObjectID)
{
	new rows, fields;
    cache_get_data(rows, fields);
    if(rows)
    {
		new listingmessage[1024 + 512];
		new title[32], tempresult[32];
		format(title, sizeof title,"Type ID %d Edition", cache_get_field_content_int(0, "TID"));

		cache_get_field_content(0, "TypeChar", tempresult);
		format(listingmessage, sizeof listingmessage, "{FF6600}Name:\t\t{FFFFFF}%s\n",tempresult);
		format(listingmessage, sizeof listingmessage, "%s{FF6600}Integer:\t\t{FFFFFF}%d\n",listingmessage, cache_get_field_content_int(0, "TypeInt"));

        SetPVarInt(playerid, "EdittingType", ObjectID);
        ShowPlayerDialog(playerid, 951, DIALOG_STYLE_LIST, title, listingmessage, "Edit", "Exit");
	}
	else
	{
	    TDError(playerid,"Invalid type.");
	}
	return 1;
}

forward OnPlayerCreateType(playerid);
public OnPlayerCreateType(playerid)
{
    mysql_format(dbHandle, query, sizeof(query),"SELECT * FROM types WHERE `TID` = %d", cache_insert_id());
	mysql_tquery(dbHandle, query, "OnPlayerRequestEditType", "ii", playerid, cache_insert_id());
	return 1;
}

forward OnPlayerRequestListActions(playerid);
public OnPlayerRequestListActions(playerid)
{
    new rows, fields, characterstr[1536], result[32];
    cache_get_data(rows, fields);
    if(rows)
    {
        new title[64], temp, internal;
        SetPVarInt(playerid, "listviewingtotal", rows);
        new objects = GetPVarInt(playerid,"listviewingmin");

        for(new i = 0; i < 10; i ++)
            listing[playerid][i] = -1;

        while(objects < rows && objects < GetPVarInt(playerid,"listviewingmax"))
        {
            temp = cache_get_field_content_int(objects, "ActionID");
            format(characterstr, 1536, "%s{FF6600}ID: {FFFFFF}%02d",characterstr,temp);
            listing[playerid][internal] = temp;

            temp = cache_get_field_content_int(objects, "TypeID");
            format(characterstr, 1536, "%s\t\t{FF6600}Attached Type: {FFFFFF}%02d",characterstr,temp);

            cache_get_field_content(objects, "Action", result);
			format(characterstr, 1536, "%s\t{FF6600}Action: {FFFFFF}%s",characterstr, result);

			format(characterstr, 1536, "%s\n",characterstr);
			objects ++;
			internal ++;
        }

        if(rows > 10)
        {
            new Float:totalpages;
			new Float:currentpage;

			totalpages = floatround(rows/10.0, floatround_ceil);
			currentpage = floatround(GetPVarInt(playerid,"listviewingmax")/10.0, floatround_ceil);

            format(title, sizeof(title),"{FFFFFF}Click the action to edit it. {BBBBBB}(%d/%d)", floatround(currentpage), floatround(totalpages));
            ShowPlayerDialog(playerid, 850, DIALOG_STYLE_LIST, title,characterstr,"Expand","Next >");
        }
        else
        {
            ShowPlayerDialog(playerid, 850, DIALOG_STYLE_LIST, "Select the list item to action type",characterstr,"Expand","Exit");
        }
    }
    else
    {
        TDInfo(playerid, "Invalid actions.");
        return 1;
	}

	return 1;
}

forward OnPlayerRequestEditAction(playerid, ObjectID);
public OnPlayerRequestEditAction(playerid, ObjectID)
{
	new rows, fields;
    cache_get_data(rows, fields);
    if(rows)
    {
		new listingmessage[1024 + 512];
		new title[32], tempresult[32];
		format(title, sizeof title,"Action ID %d Edition", cache_get_field_content_int(0, "ActionID"));

		cache_get_field_content(0, "Action", tempresult);
		format(listingmessage, sizeof listingmessage, "{FF6600}Action:\t\t\t{FFFFFF}%s\n",tempresult);
		cache_get_field_content(0, "TypeChar", tempresult);
		format(listingmessage, sizeof listingmessage, "%s{FF6600}Attached Type:\t\t{FFFFFF}%d (%s)\n",listingmessage, cache_get_field_content_int(0, "TypeID"), tempresult);

        SetPVarInt(playerid, "EdittingAction", ObjectID);
        ShowPlayerDialog(playerid, 851, DIALOG_STYLE_LIST, title, listingmessage, "Edit", "Exit");
	}
	else
	{
	    TDError(playerid,"Invalid type.");
	}
	return 1;
}

forward OnPlayerCreateAction(playerid);
public OnPlayerCreateAction(playerid)
{
    mysql_format(dbHandle, medquery, sizeof(medquery),
	"SELECT actions.ActionID, actions.TypeID, actions.Action, types.TypeChar \
	FROM actions JOIN types ON actions.TypeID = types.TypeInt \
	WHERE ActionID = %d", cache_insert_id());
	mysql_tquery(dbHandle, medquery, "OnPlayerRequestEditAction", "ii", playerid, cache_insert_id());
	return 1;
}


public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == 850)
	{
		if(response)
		{
      		mysql_format(dbHandle, medquery, sizeof(medquery),
	 		"SELECT actions.ActionID, actions.TypeID, actions.Action, types.TypeChar \
			FROM actions JOIN types ON actions.TypeID = types.TypeInt \
			WHERE ActionID = %d", listing[playerid][listitem]);
		    mysql_tquery(dbHandle, medquery, "OnPlayerRequestEditAction", "ii", playerid, listing[playerid][listitem]);
		}
		else
		{
			if(GetPVarInt(playerid, "listviewingtotal") > 10)
			{
			    if(GetPVarInt(playerid, "listviewingmax") == GetPVarInt(playerid,"listviewingtotal"))
			    {
			        SetPVarInt(playerid, "listviewingmin", 0);
			        SetPVarInt(playerid, "listviewingmax", 10);
			        mysql_format(dbHandle, query, 128, "SELECT * FROM actions ORDER BY `TypeID`");
					mysql_tquery(dbHandle, query, "OnPlayerRequestListActions", "i", playerid);
			        return 1;
			    }


			    SetPVarInt(playerid, "listviewingmin", GetPVarInt(playerid,"listviewingmin") + 10);
			    if(GetPVarInt(playerid, "listviewingmin") > GetPVarInt(playerid, "listviewingtotal"))
			        SetPVarInt(playerid, "listviewingmin", GetPVarInt(playerid,"listviewingtotal") - 10);


	            SetPVarInt(playerid, "listviewingmax", GetPVarInt(playerid,"listviewingmax") + 10);
	            if(GetPVarInt(playerid, "listviewingmax") > GetPVarInt(playerid, "listviewingtotal"))
			        SetPVarInt(playerid, "listviewingmax", GetPVarInt(playerid,"listviewingtotal"));

	            mysql_format(dbHandle, query, 128, "SELECT * FROM actions ORDER BY `TypeID`");
				mysql_tquery(dbHandle, query, "OnPlayerRequestListActions", "i", playerid);
				return 1;
			}
		}
		return 1;
	}

	if(dialogid == 851)
	{
		if(response)
		{
		    if(listitem == 0)
		        ShowPlayerDialog(playerid, 852, DIALOG_STYLE_INPUT, "New name", "Type below the new name for the action", "Ok", "Back");
		    else if(listitem == 1)
		        ShowPlayerDialog(playerid, 852, DIALOG_STYLE_INPUT, "New type", "Type below the new attached type for the action", "Ok", "Back");


		    SetPVarInt(playerid, "Editting", listitem);

		}
		else
	    {
	        ShowPlayerDialog(playerid, 853, DIALOG_STYLE_MSGBOX, "What do you want to do?", "Do you want to go back to edit the actions or leave the dialog?", "Actions", "Leave");
	    }
	}
	if(dialogid == 852)
	{
	    if(response)
	    {
	        if(GetPVarInt(playerid,"Editting") == 0)
			{ // action name
			    if(strlen(inputtext) > 32)
			        return ShowPlayerDialog(playerid, 852, DIALOG_STYLE_INPUT, "New name", "Type below the new name for the action\n\n{FF0000}ERROR: {AA0000}Name too long.", "Ok", "Back");

				mysql_format(dbHandle, query, sizeof query,"UPDATE actions SET Action = '%e' WHERE ActionID = %d",inputtext, GetPVarInt(playerid,"EdittingAction"));
				mysql_tquery(dbHandle, query, "", "");
			}
			else if(GetPVarInt(playerid,"Editting") == 1)
			{ // type id attached
			    if(!IsNumeric(inputtext))
			        return ShowPlayerDialog(playerid, 852, DIALOG_STYLE_INPUT, "New attached ID", "Type below the new attached type of the action\n\n{FF0000}ERROR: {AA0000}Must be a number", "Ok", "Back");


			    mysql_format(dbHandle, query, sizeof query,"UPDATE actions SET TypeID = '%d' WHERE ActionID = %d",strval(inputtext), GetPVarInt(playerid,"EdittingAction"));
				mysql_tquery(dbHandle, query, "", "");
			}

			mysql_format(dbHandle, medquery, sizeof(medquery),
			"SELECT actions.ActionID, actions.TypeID, actions.Action, types.TypeChar \
			FROM actions JOIN types ON actions.TypeID = types.TypeInt WHERE ActionID = %d", GetPVarInt(playerid,"EdittingAction"));
		    mysql_tquery(dbHandle, medquery, "OnPlayerRequestEditAction", "ii", playerid, GetPVarInt(playerid,"EdittingAction"));
	    }
	    else
	    {
		    mysql_format(dbHandle, medquery, sizeof(medquery),
			"SELECT actions.ActionID, actions.TypeID, actions.Action, types.TypeChar \
			FROM actions JOIN types ON actions.TypeID = types.TypeInt WHERE ActionID = %d", GetPVarInt(playerid,"EdittingAction"));
		    mysql_tquery(dbHandle, medquery, "OnPlayerRequestEditAction", "ii", playerid, GetPVarInt(playerid,"EdittingAction"));
	    }

	}


	if(dialogid == 853)
	{
	    if(response)
	    {
	        mysql_format(dbHandle, query, 128, "SELECT * FROM actions ORDER BY `ActionID`");
			mysql_tquery(dbHandle, query, "OnPlayerRequestListActions", "i", playerid);
	    }
	}

 	if(dialogid == 900)
	{
		if(response)
		{
      		mysql_format(dbHandle, query, sizeof(query),"SELECT * FROM `objects` JOIN types ON objects.TypeID = types.TypeInt WHERE `ID` = %d", listing[playerid][listitem]);
		    mysql_tquery(dbHandle, query, "OnPlayerRequestEditObject", "ii", playerid, listing[playerid][listitem]);
		}
		else
		{
			if(GetPVarInt(playerid, "listviewingtotal") > 10)
			{
			    if(GetPVarInt(playerid, "listviewingmax") == GetPVarInt(playerid,"listviewingtotal"))
			    {
			        SetPVarInt(playerid, "listviewingmin", 0);
			        SetPVarInt(playerid, "listviewingmax", 10);
			        mysql_format(dbHandle, query, 128, "SELECT * FROM `objects` JOIN types ON objects.TypeID = types.TypeInt ORDER BY `ID`");
					mysql_tquery(dbHandle, query, "OnPlayerRequestListObjects", "i", playerid);
			        return 1;
			    }


			    SetPVarInt(playerid, "listviewingmin", GetPVarInt(playerid,"listviewingmin") + 10);
			    if(GetPVarInt(playerid, "listviewingmin") > GetPVarInt(playerid, "listviewingtotal"))
			        SetPVarInt(playerid, "listviewingmin", GetPVarInt(playerid,"listviewingtotal") - 10);


	            SetPVarInt(playerid, "listviewingmax", GetPVarInt(playerid,"listviewingmax") + 10);
	            if(GetPVarInt(playerid, "listviewingmax") > GetPVarInt(playerid, "listviewingtotal"))
			        SetPVarInt(playerid, "listviewingmax", GetPVarInt(playerid,"listviewingtotal"));

	            mysql_format(dbHandle, query, 128, "SELECT * FROM `objects` JOIN types ON objects.TypeID = types.TypeInt ORDER BY `ID`");
				mysql_tquery(dbHandle, query, "OnPlayerRequestListObjects", "i", playerid);
				return 1;
			}
		}
		return 1;
	}
	
	if(dialogid == 901)
	{
		if(response)
		{
		    if(listitem == 0)
		        ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new name for the object", "Ok", "Back");
		    else if(listitem == 1)
		        ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new size for the object", "Ok", "Back");
		    else if(listitem == 2)
		        ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new type for the object", "Ok", "Back");
            else if(listitem == 3)
		        ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new slots for the object", "Ok", "Back");
            else if(listitem == 4)
		        ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new max uses for the object", "Ok", "Back");
            else if(listitem == 5)
		        ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new display id for the object", "Ok", "Back");
            else if(listitem == 6)
		        ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new display zoom for the object", "Ok", "Back");
            else if(listitem == 7)
		        ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new display x offset for the object", "Ok", "Back");
            else if(listitem == 8)
		        ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new display y offset for the object", "Ok", "Back");
            else if(listitem == 9)
		        ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new display z offset for the object", "Ok", "Back");
            else if(listitem == 10)
		        ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new display color for the object", "Ok", "Back");
            else if(listitem == 11)
		        ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new flag 1 for the object", "Ok", "Back");
		    else if(listitem == 12)
		        ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new flag 2 for the object", "Ok", "Back");
		    else if(listitem == 13)
		        ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new flag 3 for the object", "Ok", "Back");
		        
		    SetPVarInt(playerid, "Editting", listitem);
		
		}
		else
	    {
	        ShowPlayerDialog(playerid, 903, DIALOG_STYLE_MSGBOX, "What do you want to do?", "Do you want to go back to edit the objects or leave the dialog?", "Objects", "Leave");
	    }
	}
	if(dialogid == 902)
	{
	    if(response)
	    {
	        if(GetPVarInt(playerid,"Editting") == 0)
			{ //name
			    if(strlen(inputtext) > 32)
			        return ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new name for the object\n\n{FF0000}ERROR: {AA0000}Name too long.", "Ok", "Back");
			        
				mysql_format(dbHandle, query, sizeof query,"UPDATE objects SET Name = '%e' WHERE ID = %d",inputtext, GetPVarInt(playerid,"EdittingObject"));
				mysql_tquery(dbHandle, query, "", "");
			}
			else if(GetPVarInt(playerid,"Editting") == 1)
			{ // size
			    if(!IsNumeric(inputtext))
			        return ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new size of the object\n\n{FF0000}ERROR: {AA0000}Must be a number", "Ok", "Back");
			
			    if(strval(inputtext) > 35)
			        return ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new size of the object\n\n{FF0000}ERROR: {AA0000}Can't be higher than 35", "Ok", "Back");
			        

			    mysql_format(dbHandle, query, sizeof query,"UPDATE objects SET H_Size = '%d' WHERE ID = %d",strval(inputtext), GetPVarInt(playerid,"EdittingObject"));
				mysql_tquery(dbHandle, query, "", "");
			}
			else if(GetPVarInt(playerid,"Editting") == 2)
			{ // type
			    if(IsNumeric(inputtext))
                    mysql_format(dbHandle, query, sizeof query,"SELECT * FROM types WHERE TypeInt = %d",strval(inputtext));
				else
				    mysql_format(dbHandle, query, sizeof query,"SELECT * FROM types WHERE TypeChar LIKE('%%%s%%')",inputtext);
			    
				mysql_tquery(dbHandle, query, "OnPlayerRequestTypeData", "i", playerid);
				return 1;
			}
			else if(GetPVarInt(playerid,"Editting") == 3)
			{ // slots
			    if(!IsNumeric(inputtext))
			        return ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new slots of the object\n\n{FF0000}ERROR: {AA0000}Must be a number", "Ok", "Back");

			    if(strval(inputtext) > 35)
			        return ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new slots of the object\n\n{FF0000}ERROR: {AA0000}Can't be higher than 35", "Ok", "Back");


			    mysql_format(dbHandle, query, sizeof query,"UPDATE objects SET Carry = '%d' WHERE ID = %d",strval(inputtext), GetPVarInt(playerid,"EdittingObject"));
				mysql_tquery(dbHandle, query, "", "");
			}
			else if(GetPVarInt(playerid,"Editting") == 4)
			{ // uses
			    if(!IsNumeric(inputtext))
			        return ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new max uses of the object\n\n{FF0000}ERROR: {AA0000}Must be a number", "Ok", "Back");


			    mysql_format(dbHandle, query, sizeof query,"UPDATE objects SET Uses = '%d' WHERE ID = %d",strval(inputtext), GetPVarInt(playerid,"EdittingObject"));
				mysql_tquery(dbHandle, query, "", "");
			}
			else if(GetPVarInt(playerid,"Editting") == 5)
			{ // display
			    if(!IsNumeric(inputtext))
			        return ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new displaying id of the object\n\n{FF0000}ERROR: {AA0000}Must be a number", "Ok", "Back");


			    mysql_format(dbHandle, query, sizeof query,"UPDATE objects SET Display = '%d' WHERE ID = %d",strval(inputtext), GetPVarInt(playerid,"EdittingObject"));
				mysql_tquery(dbHandle, query, "", "");
			}
			else if(GetPVarInt(playerid,"Editting") == 6)
			{ // display zoom
			    if(!IsFloat(inputtext))
			        return ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new displaying zoom of the object\n\n{FF0000}ERROR: {AA0000}Must be a float", "Ok", "Back");


			    mysql_format(dbHandle, query, sizeof query,"UPDATE objects SET DisplayZoom = '%f' WHERE ID = %d", floatstr(inputtext), GetPVarInt(playerid,"EdittingObject"));
				mysql_tquery(dbHandle, query, "", "");
			}
			else if(GetPVarInt(playerid,"Editting") == 7)
			{ // display x
			    if(!IsFloat(inputtext))
			        return ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new displaying x offset of the object\n\n{FF0000}ERROR: {AA0000}Must be a float", "Ok", "Back");


			    mysql_format(dbHandle, query, sizeof query,"UPDATE objects SET DisplayXOffset = '%f' WHERE ID = %d", floatstr(inputtext), GetPVarInt(playerid,"EdittingObject"));
				mysql_tquery(dbHandle, query, "", "");
			}
			else if(GetPVarInt(playerid,"Editting") == 8)
			{ // display y
			    if(!IsFloat(inputtext))
			        return ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new displaying y offset of the object\n\n{FF0000}ERROR: {AA0000}Must be a float", "Ok", "Back");

			    mysql_format(dbHandle, query, sizeof query,"UPDATE objects SET DisplayYOffset = '%f' WHERE ID = %d", floatstr(inputtext), GetPVarInt(playerid,"EdittingObject"));
				mysql_tquery(dbHandle, query, "", "");
			}
			else if(GetPVarInt(playerid,"Editting") == 9)
			{ // display z
			    if(!IsFloat(inputtext))
			        return ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new displaying z offset of the object\n\n{FF0000}ERROR: {AA0000}Must be a float", "Ok", "Back");


			    mysql_format(dbHandle, query, sizeof query,"UPDATE objects SET DisplayZOffset = '%f' WHERE ID = %d", floatstr(inputtext), GetPVarInt(playerid,"EdittingObject"));
				mysql_tquery(dbHandle, query, "", "");
			}
			else if(GetPVarInt(playerid,"Editting") == 10)
			{ // display color
                if(strlen(inputtext) != 8)
			        return ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new color of the object\n\n{FF0000}ERROR: {AA0000}Must be a hex (and alpha)", "Ok", "Back");

			    mysql_format(dbHandle, query, sizeof query,"UPDATE objects SET DisplayColor = '%d' WHERE ID = %d",HexToInt(inputtext), GetPVarInt(playerid,"EdittingObject"));
				mysql_tquery(dbHandle, query, "", "");
			}
			else if(GetPVarInt(playerid,"Editting") == 11)
			{ // flag 1
			    if(!IsNumeric(inputtext))
			        return ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new flag 1 of the object\n\n{FF0000}ERROR: {AA0000}Must be a number", "Ok", "Back");

			    mysql_format(dbHandle, query, sizeof query,"UPDATE objects SET SpecialFlag_1 = '%d' WHERE ID = %d",strval(inputtext), GetPVarInt(playerid,"EdittingObject"));
				mysql_tquery(dbHandle, query, "", "");
			}
			else if(GetPVarInt(playerid,"Editting") == 12)
			{ // flag 2
			    if(!IsNumeric(inputtext))
			        return ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new flag 2 of the object\n\n{FF0000}ERROR: {AA0000}Must be a number", "Ok", "Back");

			    mysql_format(dbHandle, query, sizeof query,"UPDATE objects SET SpecialFlag_2 = '%d' WHERE ID = %d",strval(inputtext), GetPVarInt(playerid,"EdittingObject"));
				mysql_tquery(dbHandle, query, "", "");
			}
			else if(GetPVarInt(playerid,"Editting") == 13)
			{ // flag 3
			    if(!IsNumeric(inputtext))
			        return ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new flag 3 of the object\n\n{FF0000}ERROR: {AA0000}Must be a number", "Ok", "Back");

			    mysql_format(dbHandle, query, sizeof query,"UPDATE objects SET SpecialFlag_3 = '%d' WHERE ID = %d",strval(inputtext), GetPVarInt(playerid,"EdittingObject"));
				mysql_tquery(dbHandle, query, "", "");
			}
			
			mysql_format(dbHandle, query, sizeof(query),"SELECT * FROM `objects` JOIN types ON objects.TypeID = types.TypeInt WHERE `ID` = %d", GetPVarInt(playerid,"EdittingObject"));
		    mysql_tquery(dbHandle, query, "OnPlayerRequestEditObject", "ii", playerid, GetPVarInt(playerid,"EdittingObject"));
	    }
	    else
	    {
		    mysql_format(dbHandle, query, sizeof(query),"SELECT * FROM `objects` JOIN types ON objects.TypeID = types.TypeInt WHERE `ID` = %d", GetPVarInt(playerid,"EdittingObject"));
		    mysql_tquery(dbHandle, query, "OnPlayerRequestEditObject", "ii", playerid, GetPVarInt(playerid,"EdittingObject"));
	    }
	
	}
	
	
	if(dialogid == 903)
	{
	    if(response)
	    {
	        mysql_format(dbHandle, query, 128, "SELECT * FROM `objects` JOIN types ON objects.TypeID = types.TypeInt ORDER BY `ID`");
			mysql_tquery(dbHandle, query, "OnPlayerRequestListObjects", "i", playerid);
	    }
	}
	
	
	if(dialogid == 950)
	{
		if(response)
		{
      		mysql_format(dbHandle, query, sizeof(query),"SELECT * FROM types WHERE `TID` = %d", listing[playerid][listitem]);
		    mysql_tquery(dbHandle, query, "OnPlayerRequestEditType", "ii", playerid, listing[playerid][listitem]);
		}
		else
		{
			if(GetPVarInt(playerid, "listviewingtotal") > 10)
			{
			    if(GetPVarInt(playerid, "listviewingmax") == GetPVarInt(playerid,"listviewingtotal"))
			    {
			        SetPVarInt(playerid, "listviewingmin", 0);
			        SetPVarInt(playerid, "listviewingmax", 10);
			        mysql_format(dbHandle, query, 128, "SELECT * FROM types ORDER BY `TID`");
					mysql_tquery(dbHandle, query, "OnPlayerRequestListTypes", "i", playerid);
			        return 1;
			    }


			    SetPVarInt(playerid, "listviewingmin", GetPVarInt(playerid,"listviewingmin") + 10);
			    if(GetPVarInt(playerid, "listviewingmin") > GetPVarInt(playerid, "listviewingtotal"))
			        SetPVarInt(playerid, "listviewingmin", GetPVarInt(playerid,"listviewingtotal") - 10);


	            SetPVarInt(playerid, "listviewingmax", GetPVarInt(playerid,"listviewingmax") + 10);
	            if(GetPVarInt(playerid, "listviewingmax") > GetPVarInt(playerid, "listviewingtotal"))
			        SetPVarInt(playerid, "listviewingmax", GetPVarInt(playerid,"listviewingtotal"));

	            mysql_format(dbHandle, query, 128, "SELECT * FROM types ORDER BY `TID`");
				mysql_tquery(dbHandle, query, "OnPlayerRequestListTypes", "i", playerid);
				return 1;
			}
		}
		return 1;
	}

	if(dialogid == 951)
	{
		if(response)
		{
		    if(listitem == 0)
		        ShowPlayerDialog(playerid, 952, DIALOG_STYLE_INPUT, "New name", "Type below the new name for the type", "Ok", "Back");
		    else if(listitem == 1)
		        ShowPlayerDialog(playerid, 952, DIALOG_STYLE_INPUT, "New integer", "Type below the new integer for the type", "Ok", "Back");


		    SetPVarInt(playerid, "Editting", listitem);

		}
		else
	    {
	        ShowPlayerDialog(playerid, 953, DIALOG_STYLE_MSGBOX, "What do you want to do?", "Do you want to go back to edit the types or leave the dialog?", "Types", "Leave");
	    }
	}
	if(dialogid == 952)
	{
	    if(response)
	    {
	        if(GetPVarInt(playerid,"Editting") == 0)
			{ // typename
			    if(strlen(inputtext) > 32)
			        return ShowPlayerDialog(playerid, 952, DIALOG_STYLE_INPUT, "New name", "Type below the new name for the type\n\n{FF0000}ERROR: {AA0000}Name too long.", "Ok", "Back");

				mysql_format(dbHandle, query, sizeof query,"UPDATE types SET TypeChar = '%e' WHERE TID = %d",inputtext, GetPVarInt(playerid,"EdittingType"));
				mysql_tquery(dbHandle, query, "", "");
			}
			else if(GetPVarInt(playerid,"Editting") == 1)
			{ // typeinteger
			    if(!IsNumeric(inputtext))
			        return ShowPlayerDialog(playerid, 952, DIALOG_STYLE_INPUT, "New name", "Type below the new integer of the type\n\n{FF0000}ERROR: {AA0000}Must be a number", "Ok", "Back");


			    mysql_format(dbHandle, query, sizeof query,"UPDATE types SET TypeInt = '%d' WHERE TID = %d",strval(inputtext), GetPVarInt(playerid,"EdittingType"));
				mysql_tquery(dbHandle, query, "", "");
			}

			mysql_format(dbHandle, query, sizeof(query),"SELECT * FROM types WHERE `TID` = %d", GetPVarInt(playerid,"EdittingType"));
		    mysql_tquery(dbHandle, query, "OnPlayerRequestEditType", "ii", playerid, GetPVarInt(playerid,"EdittingType"));
	    }
	    else
	    {
		    mysql_format(dbHandle, query, sizeof(query),"SELECT * FROM types WHERE `TID` = %d", GetPVarInt(playerid,"EdittingType"));
		    mysql_tquery(dbHandle, query, "OnPlayerRequestEditType", "ii", playerid, GetPVarInt(playerid,"EdittingType"));
	    }

	}


	if(dialogid == 953)
	{
	    if(response)
	    {
	        mysql_format(dbHandle, query, 128, "SELECT * FROM types ORDER BY `TID`");
			mysql_tquery(dbHandle, query, "OnPlayerRequestListTypes", "i", playerid);
	    }
	}
	
	return 1;
}

forward OnPlayerRequestTypeData(playerid);
public OnPlayerRequestTypeData(playerid)
{
    new rows, fields;
    cache_get_data(rows, fields);
    if(rows)
    {
        mysql_format(dbHandle, query, sizeof query,"UPDATE objects SET TypeID = %d WHERE ID = %d",cache_get_field_content_int(0, "TypeInt"), GetPVarInt(playerid,"EdittingObject"));
		mysql_tquery(dbHandle, query, "", "");

        mysql_format(dbHandle, query, sizeof(query),"SELECT * FROM `objects` JOIN types ON objects.TypeID = types.TypeInt WHERE `ID` = %d", GetPVarInt(playerid,"EdittingObject"));
		mysql_tquery(dbHandle, query, "OnPlayerRequestEditObject", "ii", playerid, GetPVarInt(playerid,"EdittingObject"));
    }
	else
	{
		ShowPlayerDialog(playerid, 902, DIALOG_STYLE_INPUT, "New name", "Type below the new type of the object\n\n{FF0000}ERROR: {AA0000}Type not found", "Ok", "Back");
	}

	return 1;
}


CMD:inventory(playerid, params[])
{
    if(!isnull(params)) return Usage(playerid,"/inventory");

    DestroyInventoryObjects(playerid);
    PlayerTextDrawDestroy(playerid, Inv[playerid][16]);
    Inv[playerid][16] = CreatePlayerTextDraw(playerid, 636.500000, 125.000000, "_");
	PlayerTextDrawAlignment(playerid, Inv[playerid][16], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][16], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][16], 1);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][16], 0.509999, 34.199996);
	PlayerTextDrawColor(playerid, Inv[playerid][16], -1442840321);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][16], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][16], 1);
	PlayerTextDrawUseBox(playerid, Inv[playerid][16], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][16], -1157627734);
	PlayerTextDrawTextSize(playerid, Inv[playerid][16], 0.000000, 4.000000);
	
    PlayerTextDrawDestroy(playerid, Inv[playerid][22]);
    Inv[playerid][22] = CreatePlayerTextDraw(playerid, 208.900000, 125.000000, "_");
	PlayerTextDrawAlignment(playerid, Inv[playerid][22], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][22], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][22], 1);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][22], 0.509999, 34.199996);
	PlayerTextDrawColor(playerid, Inv[playerid][22], -1442840321);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][22], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][22], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][22], 1);
	PlayerTextDrawUseBox(playerid, Inv[playerid][22], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][22], -1157627734);
	PlayerTextDrawTextSize(playerid, Inv[playerid][22], 0.000000, 4.000000);
	ShowInventoryBase(playerid);
	
	LoadObjects(playerid, 1);
	LoadNearObjects(playerid, 1);
	
	SelectTextDraw(playerid, 0xFFFFFFFF);
	SetPVarInt(playerid, "DisplayingPage", 1);
	SetPVarInt(playerid, "MinDisplay", 0);
	SetPVarInt(playerid, "DisplayingPage_Near", 1);
	SetPVarInt(playerid, "MinDisplay_Near", 0);
	return 1;
}

stock LoadNearObjects(playerid, first)
{
    for(new i = 0; i < sizeof(objectsstored[]); i ++)
	{
	    for(new a = 0; a < 4; a ++)
	    {
		    g_objectsstored[playerid][i][a] = 0;
		    g_slotused[playerid][i][a] = -1;
		    g_objectsize[playerid][i][a] = 0;
		    g_objectdisplay[playerid][i][a] = 0;
		    g_objecttypes[playerid][i][a] = 0;
		    g_objectscap[playerid][i][a] = 0;
		}
	}
	for(new a = 0; a < 4; a ++)
	{
		g_slots[playerid][a] = 0;
		g_slotbelongsto[playerid][a] = 0;
		g_objectcap[playerid][a] = 0;

		g_container[playerid][a] = 0;
		g_containerdisplay[playerid][a] = 0;
		g_containertype[playerid][a] = 0;
		g_containersize[playerid][a] = 0;
	}

    new ids[512];
	for(new i = 0; i < MAX_GLOBAL_OBJECTS; i ++)
  	{
  	    if(GlobalObject[i][PlayerID] == 0) continue;

  	    if(GlobalObject[i][IsNear][playerid] == 1)
  	    {
			format(ids, sizeof(ids),"%s%d,",ids, GlobalObject[i][PlayerID]);
  	    }
  	}
  	strdel(ids, strlen(ids)-1, strlen(ids));
	if(strlen(ids) == 0)
	    ids = "0";

    DestroyNearInventoryObjects(playerid);
    mysql_format(dbHandle, infquery, sizeof(infquery),
	"SELECT * FROM `playerobjects` \
 	JOIN `objects` ON playerobjects.O_ObjectID = objects.ID \
  	WHERE (playerobjects.PlayerObjectStatus = 3 OR playerobjects.PlayerObjectStatus = 4) AND playerobjects.PID IN(%s)", ids);
	mysql_tquery(dbHandle, infquery, "OnPlayerRequestNearObjects", "ii", playerid, first);
	
	return 1;
}

stock LoadObjects(playerid, first)
{
	for(new i = 0; i < sizeof(objectsstored[]); i ++)
	{
	    for(new a = 0; a < 4; a ++)
	    {
		    objectsstored[playerid][i][a] = 0;
		    slotused[playerid][i][a] = -1;
		    objectsize[playerid][i][a] = 0;
		    objectdisplay[playerid][i][a] = 0;
		    objecttypes[playerid][i][a] = 0;
			objectscap[playerid][i][a] = 0;
		}
	}
	for(new a = 0; a < 4; a ++)
	{
	    slots[playerid][a] = 0;
		slotbelongsto[playerid][a] = 0;
		objectcap[playerid][a] = 0;

		container[playerid][a] = 0;
		containerdisplay[playerid][a] = 0;
		containertype[playerid][a] = 0;
		containersize[playerid][a] = 0;
	}

    DestroyInventoryObjects(playerid);
    mysql_format(dbHandle, bigquery, sizeof(bigquery),
	"SELECT * FROM `playerobjects` \
 	JOIN `objects` ON playerobjects.O_ObjectID = objects.ID \
 	JOIN `objectinventory` ON playerobjects.PID = objectinventory.OI_ObjectID \
  	WHERE playerobjects.`PlayerName` = '%s' AND \
  	playerobjects.PlayerObjectStatus = 1 ORDER BY Position", PlayerName(playerid));
    mysql_tquery(dbHandle, bigquery, "OnPlayerRequestObjects", "ii", playerid, first);
    return 1;
}

stock SetObjectUses(ObjectID, Uses)
{
    format(query, sizeof query,"UPDATE playerobjects SET Uses = %d WHERE PID = %d",Uses, ObjectID);
    mysql_tquery(dbHandle, query, "", "");
	return 1;
}

stock RemoveObjectFromDatabase(ObjectID, bool:inventoryerase)
{
    format(query, sizeof(query),"DELETE FROM playerobjects WHERE PID = %d", ObjectID);
	mysql_tquery(dbHandle, query, "", "");

	if(inventoryerase)
	{
	    format(query, sizeof(query),"DELETE FROM objectinventory WHERE OI_ObjectID = %d", ObjectID);
		mysql_tquery(dbHandle, query, "", "");
	}
	return 1;
}

forward OnMoveToObjectPos(playerid, object, type, source, sourcetype, dest, desttype, newowner, carry, objsize, drop);
public OnMoveToObjectPos(playerid, object, type, source, sourcetype, dest, desttype, newowner, carry, objsize, drop)
{//checking new position for an object.
	new finalpos = -2;
    new rows, fields;
	cache_get_data(rows, fields);

	new totalslots[35];
	for(new i = carry; i < 35; i ++)
	    totalslots[i] = -999; //nullify all slots that are not on the object


	new pos, size;
	for(new i = 0; i < rows; i ++) //map the object slots with this loop
	{
	    if(totalslots[i] == -999) continue;
	
		pos = cache_get_field_content_int(i, "Position");
		size = cache_get_field_content_int(i, "H_Size");
		
		for(new a = pos; a < pos+size; a ++)
		{
		    totalslots[a] = 1;
		}
	}
	
	new tempsize;
	for(new i = 0; i < 35; i ++)
	{
		if(totalslots[i] == -999) continue;
		
		for(new a = 0; a < objsize; a ++)
		{
		    if(totalslots[i+a] != 1 && totalslots[i+a] != -999)
		    {
				tempsize ++;
		    }
		    else
		    {
		        tempsize = 0;
		        break;
		    }
		}
		if(tempsize == objsize)
		{
		    finalpos = i;
		    break;
		}
	}
	
	if(rows == 0) finalpos = 0;
	
	if(drop == 1 && finalpos == -2)
		finalpos = -4;
	
	mysql_format(dbHandle, medquery, sizeof medquery, "SELECT OI_ObjectID, InsideIDs FROM objectinventory WHERE OI_ObjectID = %d OR OI_ObjectID = %d", source, dest);
	mysql_tquery(dbHandle, medquery, "MoveObjectToObject","iiiiiiiii", playerid, finalpos, object, type, source, sourcetype, dest, desttype, newowner);
	return 1;
}



forward CheckBulletLimit(playerid, mainobject, bulletsource, sourcetype);
public CheckBulletLimit(playerid, mainobject, bulletsource, sourcetype)
{
    new rows, fields;
    cache_get_data(rows, fields);
    if(rows != 2)
        return 1;

	new bulletrow, weaprow;
	for(new i = 0; i < rows; i ++)
	{
        if(cache_get_field_content_int(i, "TypeID") == 7) bulletrow = i;
        if(cache_get_field_content_int(i, "TypeID") == 11) weaprow = i;
	}

	new uses = cache_get_field_content_int(bulletrow, "Uses");
	new chamber = cache_get_field_content_int(weaprow, "SpecialFlag_3");
	new bulletobj = cache_get_field_content_int(bulletrow, "O_ObjectID");
	new bulletpid = cache_get_field_content_int(bulletrow, "PID");
	new totaluses = cache_get_field_content_int(bulletrow, "TotalUses");

	if(uses > chamber)
	{
	    new splitamount = uses - chamber;

	   	CreateNewObject(playerid, bulletobj, bulletsource, sourcetype, splitamount, totaluses, PlayerName(playerid));
	    format(query, sizeof query, "UPDATE playerobjects SET Uses = %d WHERE PID = %d",chamber, bulletpid);
	    mysql_tquery(dbHandle, query);
	}

	return 1;
}

stock CreateNewObject(playerid, ObjectDataID, Dest, DestType, Uses, TotalUses, const Owner[])
{
	format(medquery, sizeof medquery, "INSERT INTO playerobjects (PlayerName, O_ObjectID, Uses, TotalUses, PlayerObjectStatus) VALUES ('%s',%d,%d,%d,2)",Owner, ObjectDataID, Uses, TotalUses);
	mysql_tquery(dbHandle, medquery, "InsertObjectInventory", "iiii", playerid, 7, Dest, DestType);
	return 1;
}

forward InsertObjectInventory(playerid, Type, Dest, DestType);
public InsertObjectInventory(playerid, Type, Dest, DestType)
{
	format(medquery, sizeof medquery, "INSERT INTO objectinventory (OI_ObjectID, InsideIDs) VALUES (%d, '')",cache_insert_id());
	mysql_tquery(dbHandle, medquery, "OnObjectSplitted", "iiiii", playerid, Type, Dest, DestType, cache_insert_id());
	return 1;
}

forward OnObjectSplitted(playerid, Type, Dest, DestType, Object);
public OnObjectSplitted(playerid, Type, Dest, DestType, Object)
{
    mysql_format(dbHandle, bigquery, sizeof bigquery,
	"SELECT a.OI_ObjectID, a.InsideIDs, c.Carry, c.H_Size \
	FROM objectinventory as a \
	JOIN playerobjects as b ON a.OI_ObjectID = b.PID \
	JOIN objects as c ON b.O_ObjectID = c.ID \
	WHERE OI_ObjectID = %d OR OI_ObjectID = %d", Dest, Object);
	mysql_tquery(dbHandle, bigquery, "MoveObjectToObject","iiiiiiiii", playerid, -3, Object, Type, 0,
	0, Dest, DestType, playerid);
	return 1;
}

forward MoveObjectToObject(playerid, pos, object, type, source, sourcetype, dest, desttype, newowner);
public MoveObjectToObject(playerid, pos, object, type, source, sourcetype, dest, desttype, newowner)
{
    if(!OnServerObjectMoved(playerid, object, type, source, sourcetype, dest, desttype, newowner))
		return 1;

	if(pos == -2)
	{
	    RenderMessage(playerid, 0xFF6600FF, "There's no space for that object.");
	    return 1;
	}
	if(pos == -4)
	{
	    mysql_format(dbHandle, medquery, sizeof medquery, "SELECT * FROM objectinventory WHERE OI_ObjectID = %d", source);
		mysql_tquery(dbHandle, medquery, "DropObject","iiii", playerid, object, type, source);
	    return 1;
	}
	

		
	//format(msg, sizeof(msg), "player: %d  pos: %d  object: %d  type: %d  source: %d   sourcetype: %d  dest: %d  desttype: %d   newowner: %d",
	//playerid, pos, object, type, source, sourcetype, dest, desttype, newowner);
	//RenderMessage(playerid, 0xFF0000FF, msg);

    new rows, fields;
	cache_get_data(rows, fields);
    new destrow, sourcerow, objectrow;
	for(new i = 0; i < rows; i ++)
	{
	    if(cache_get_field_content_int(i, "OI_ObjectID") == dest) destrow = i;
	    if(cache_get_field_content_int(i, "OI_ObjectID") == source) sourcerow = i;
	    if(cache_get_field_content_int(i, "OI_ObjectID") == object) objectrow = i;
	}
	
	if(pos == -1 || pos == -3)
	{//-1 do not allow the player, -3 drop the object if no space
	    new carry = cache_get_field_content_int(destrow, "Carry");
	    new size = cache_get_field_content_int(objectrow, "H_Size");

		new inventory[140];
        cache_get_field_content(destrow, "InsideIDs", inventory);
        if(strlen(inventory) == 0)
            inventory = "0";
        
        mysql_format(dbHandle, bigquery, sizeof bigquery,
        "SELECT playerobjects.Position, playerobjects.PID, objects.H_Size \
		FROM playerobjects \
		JOIN objects \
		ON playerobjects.O_ObjectID = objects.ID \
		WHERE playerobjects.PID IN (%s)", inventory);

		new drop;
		if(pos == -3) drop = 1;

		mysql_tquery(dbHandle, bigquery, "OnMoveToObjectPos","iiiiiiiiiii", playerid, object, type, source, sourcetype, dest, desttype, newowner, carry, size, drop);
		return 1;
	}
	mysql_format(dbHandle, medquery, sizeof medquery,"UPDATE `playerobjects` SET `Position` = %d, `PlayerObjectStatus` = 2 WHERE `PID` = %d", pos, object);
	mysql_tquery(dbHandle, medquery, "", "");
	
	

	if(dest != source)
	{
		//format(msg, sizeof(msg), "Destrow: %d   sourcerow: %d", destrow, sourcerow);
		//RenderMessage(playerid, 0xFF0000FF, msg);

	    new objectstr[140], tempobjects[35];

		cache_get_field_content(sourcerow, "InsideIDs", objectstr);
		sscanf(objectstr, "p<,>a<i>[35]", tempobjects);
		objectstr = "";

		new done;
		for(new i = 0; i < sizeof tempobjects; i ++)
		{
		    if(tempobjects[i] == object && done == 0)
		    {
		        tempobjects[i] = 0;
		        done = 1;
		        //object = -1;
			}
			if(tempobjects[i] != 0)
			{
		    	format(objectstr,sizeof(objectstr),"%s%d,",objectstr,tempobjects[i]);
			}
		}
		strdel(objectstr, strlen(objectstr)-1, strlen(objectstr));

		mysql_format(dbHandle, medquery, sizeof medquery,"UPDATE objectinventory SET InsideIDs = '%s' WHERE OI_ObjectID = %d",objectstr,source);
		mysql_tquery(dbHandle, medquery, "", "");

		cache_get_field_content(destrow, "InsideIDs", objectstr);
		if(strlen(objectstr))
			format(objectstr,sizeof(objectstr),"%s,%d",objectstr,object);
		else
		    format(objectstr,sizeof(objectstr),"%d",object);

	    mysql_format(dbHandle, medquery, sizeof medquery,"UPDATE objectinventory SET InsideIDs = '%s' WHERE OI_ObjectID = %d",objectstr,dest);
		mysql_tquery(dbHandle, medquery, "", "");
	}
	
	if(playerid != INVALID_PLAYER_ID)
	{
	    SetPVarInt(playerid,"SelectedObject", 0);
		SetPVarInt(playerid,"SelectedContainer", 0);
    	SetPVarInt(playerid,"SelectedObjectIn", 0);
    	SetPVarInt(playerid,"SelectedObjectSize", 0);
	
		LoadObjects(playerid, 0);
		LoadNearObjects(playerid, 0);
	}

    for(new i = 0; i < MAX_GLOBAL_OBJECTS; i ++)
	{
	    if(GlobalObject[i][PlayerID] == object)
	    {
	        DestroyDynamicObject(GlobalObject[i][GameObject]);
	        DestroyDynamicArea(GlobalObject[i][AreaID]);
	        GlobalObject[i][PlayerID] = 0;

	        for(new a = 0; a < PLAYERS; a ++)
	        {
	            if(!IsPlayerConnected(a)) continue;
	            if(a == playerid) continue;
				if(GlobalObject[i][IsNear][a] == 1)
				    GlobalObject[i][IsNear][a] = 0,
				    LoadNearObjects(a, 0);
			}
	        break;
	    }
	}
	if(newowner != INVALID_PLAYER_ID)
	{
	    mysql_format(dbHandle, query, sizeof query, "UPDATE playerobjects SET PlayerName = '%s', WorldX = '0.0', WorldY = '0.0', WorldZ = '0.0' WHERE PID = %d", PlayerName(playerid), object);
	    mysql_tquery(dbHandle, query, "", "");
	}
	return 1;
}

forward SwapObjectWithObject(playerid, objectsource, object2source, object, object2, type1, type2, type3, type4, pos1, pos2, mem);
public SwapObjectWithObject(playerid, objectsource, object2source, object, object2, type1, type2, type3, type4, pos1, pos2, mem)
{
    if(!OnObjectSwapped(playerid, objectsource, object2source, object, object2, type1, type2, type3, type4))
    	return 1;
    	
	if(mem != -1)
	{
	    //selected objects fits where the other object is?
	    if(GetPVarInt(playerid,"SelectedObjectSize") > objectcap[playerid][mem]-pos2)
	    {
	        RenderMessage(playerid,0xFF6600FF,"The objects wont fit in their new position.");
	        SetPVarInt(playerid,"SwappingStep", 0);
			return 1;
	    }
	    //second object fits where selected object is?
	    if(objectsize[playerid][pos2][mem] > GetPVarInt(playerid,"SelectedObjectCapacity")-GetPVarInt(playerid,"SelectedObjectPosition"))
	    {
	        RenderMessage(playerid,0xFF6600FF,"The objects wont fit in their new position.");
	        SetPVarInt(playerid,"SwappingStep", 0);
			return 1;
	    }
	}
	
	//format(msg, sizeof(msg),"Pos1: %d   Pos2: %d", pos1, pos2);
	//RenderMessage(playerid, 0xFF0000FF, msg);

    new rows, fields;
	cache_get_data(rows, fields);
	if(rows == 2)
	{
  		new obj1row, obj2row;
		if(cache_get_field_content_int(0, "OI_ObjectID") == objectsource)
		    obj1row = 0, obj2row = 1;
		else if(cache_get_field_content_int(0, "OI_ObjectID") == object2source)
		    obj1row = 1, obj2row = 0;


	    new objectstr[140], tempobjects[35], done;

	    //object1
  		cache_get_field_content(obj1row, "InsideIDs", objectstr);
		sscanf(objectstr, "p<,>a<i>[35]", tempobjects);
		objectstr = "";


		for(new i = 0; i < sizeof tempobjects; i ++)
		{
		    for(new a = 0; a < sizeof tempobjects; a ++)
				if(tempobjects[i] == tempobjects[a] && a != i)
				    tempobjects[i] = 0;
		
		    if(tempobjects[i] == object && done == 0)
		    {
		        tempobjects[i] = object2;
				done = 1;
			}
			if(tempobjects[i] != 0)
			{
		    	format(objectstr,sizeof(objectstr),"%s%d,",objectstr,tempobjects[i]);
			}
		}
		strdel(objectstr, strlen(objectstr)-1, strlen(objectstr));

		mysql_format(dbHandle, medquery, sizeof medquery,"UPDATE objectinventory SET InsideIDs = '%s' WHERE OI_ObjectID = %d",objectstr,objectsource);
		mysql_tquery(dbHandle, medquery, "", "");

		for(new i = 0; i < 35; i ++)
		    tempobjects[i] = 0;

		done = 0;
		cache_get_field_content(obj2row, "InsideIDs", objectstr);
		sscanf(objectstr, "p<,>a<i>[35]", tempobjects);
		objectstr = "";

		for(new i = 0; i < sizeof tempobjects; i ++)
		{
		    for(new a = 0; a < sizeof tempobjects; a ++)
				if(tempobjects[i] == tempobjects[a] && a != i)
				    tempobjects[i] = 0;
		
		    if(tempobjects[i] == object2 && done == 0)
		    {
		        tempobjects[i] = object;
		        done = 1;
			}
			if(tempobjects[i] != 0)
			{
		    	format(objectstr,sizeof(objectstr),"%s%d,",objectstr,tempobjects[i]);
			}
		}
		strdel(objectstr, strlen(objectstr)-1, strlen(objectstr));

		mysql_format(dbHandle, medquery, sizeof medquery,"UPDATE objectinventory SET InsideIDs = '%s' WHERE OI_ObjectID = %d",objectstr,object2source);
		mysql_tquery(dbHandle, medquery, "", "");

        mysql_format(dbHandle, medquery, sizeof medquery,"UPDATE `playerobjects` SET `Position` = %d, `PlayerObjectStatus` = 2 WHERE `PID` = %d", pos2, object);
		mysql_tquery(dbHandle, medquery, "", "");

		mysql_format(dbHandle, medquery, sizeof medquery,"UPDATE `playerobjects` SET `Position` = %d, `PlayerObjectStatus` = 2 WHERE `PID` = %d", pos1, object2);
		mysql_tquery(dbHandle, medquery, "", "");

	  	if(playerid != INVALID_PLAYER_ID)
		{
			SetPVarInt(playerid,"SwappingStep", 0);
			
			SetPVarInt(playerid,"SelectedObject", 0);
			SetPVarInt(playerid,"SelectedContainer", 0);
	    	SetPVarInt(playerid,"SelectedObjectIn", 0);
	    	SetPVarInt(playerid,"SelectedObjectSize", 0);
	    	
	    	LoadObjects(playerid, 0);
			LoadNearObjects(playerid, 0);
		}
	}
	return 1;
}

forward InternalSwapObject(playerid, objectsource, object, object2, type1, type2, type3, type4, pos1, pos2, mem);
public InternalSwapObject(playerid, objectsource, object, object2, type1, type2, type3, type4, pos1, pos2, mem)
{
    if(!OnObjectSwapped(playerid, objectsource, objectsource, object, object2, type1, type2, type3, type4))
    	return 1;
    	
	if(mem != -1)
	{
	    for(new z = pos2; z < pos2+GetPVarInt(playerid,"SelectedObjectSize"); z ++)
		{
		    if(slotused[playerid][z][mem] != -1)
		    {
		        if(slotused[playerid][z][mem] != slotused[playerid][pos2][mem])
		        {
			        RenderMessage(playerid,0xFF6600FF,"The objects wont fit in their new position.");
			        SetPVarInt(playerid,"SwappingStep", 0);
			        return 1;
				}
		    }
		}
		if(GetPVarInt(playerid,"SelectedObjectSize") > objectcap[playerid][mem]-pos2)
	    {
         	RenderMessage(playerid,0xFF6600FF,"The objects wont fit in their new position.");
         	SetPVarInt(playerid,"SwappingStep", 0);
			return 1;
	    }
		

		for(new z = GetPVarInt(playerid, "SelectedObjectPosition"); z < GetPVarInt(playerid, "SelectedObjectPosition")+objectsize[playerid][pos2][mem]; z ++)
		{
		    if(slotused[playerid][z][mem] != -1)
		    {
		        if(slotused[playerid][z][mem] != GetPVarInt(playerid,"SelectedObject"))
		        {
			        RenderMessage(playerid,0xFF6600FF,"The objects wont fit in their new position.");
			        SetPVarInt(playerid,"SwappingStep", 0);
			        return 1;
				}
		    }
		}
		if(objectsize[playerid][pos2][mem] > objectcap[playerid][mem]-pos1)
	    {
	        RenderMessage(playerid,0xFF6600FF,"The objects wont fit in their new position.");
	        SetPVarInt(playerid,"SwappingStep", 0);
			return 1;
	    }
	}

//	printf("%d, %d", pos1, pos2);

    mysql_format(dbHandle, medquery, sizeof medquery,"UPDATE `playerobjects` SET `Position` = %d, `PlayerObjectStatus` = 2 WHERE `PID` = %d", pos2, object);
	mysql_tquery(dbHandle, medquery, "", "");

	mysql_format(dbHandle, medquery, sizeof medquery,"UPDATE `playerobjects` SET `Position` = %d, `PlayerObjectStatus` = 2 WHERE `PID` = %d", pos1, object2);
	mysql_tquery(dbHandle, medquery, "", "");

  	if(playerid != INVALID_PLAYER_ID)
	{
		SetPVarInt(playerid,"SwappingStep", 0);
		
		SetPVarInt(playerid,"SelectedObject", 0);
		SetPVarInt(playerid,"SelectedContainer", 0);
    	SetPVarInt(playerid,"SelectedObjectIn", 0);
    	SetPVarInt(playerid,"SelectedObjectSize", 0);
    	
    	LoadObjects(playerid, 0);
		LoadNearObjects(playerid, 0);
	}
	return 1;
}

forward DropObjectOnPosition(playerid, object, Float:fX, Float:fY, Float:fZ, status);
public DropObjectOnPosition(playerid, object, Float:fX, Float:fY, Float:fZ, status)
{
	new i = -1;
	for(new a = 0; a < MAX_GLOBAL_OBJECTS; a ++)
	{
		if(GlobalObject[a][PlayerID] == 0)
		{
		    i = a;
		    break;
		}
	}
	
	
	fZ -= 0.7;
	
	GlobalObject[i][PlayerID] = cache_get_field_content_int(0, "PID");
    GlobalObject[i][RealID] = cache_get_field_content_int(0, "ID");
    cache_get_field_content(0, "Name", GlobalObject[i][O_Name]);
    GlobalObject[i][Size] = cache_get_field_content_int(0, "H_Size");
    GlobalObject[i][TypeID] = cache_get_field_content_int(0, "TypeID");
    GlobalObject[i][Carry] = cache_get_field_content_int(0, "Carry");
    GlobalObject[i][Display] = cache_get_field_content_int(0, "Display");
    GlobalObject[i][Position] = cache_get_field_content_int(0, "Position");
    GlobalObject[i][Status] = cache_get_field_content_int(0, "PlayerObjectStatus");
    GlobalObject[i][WorldX] = fX;
    GlobalObject[i][WorldY] = fY;
    GlobalObject[i][WorldZ] = fZ;
    
    format(medquery, sizeof(medquery), "UPDATE playerobjects SET PlayerName='', PlayerObjectStatus = %d, WorldX = '%f', WorldY = '%f', WorldZ = '%f' WHERE PID = %d", status, fX, fY, fZ, object);
    mysql_tquery(dbHandle, medquery, "", "");

	GlobalObject[i][GameObject] = CreateDynamicObject(GlobalObject[i][Display], GlobalObject[i][WorldX], GlobalObject[i][WorldY], GlobalObject[i][WorldZ], 0.0, 0.0, 0.0);
	GlobalObject[i][AreaID] = CreateDynamicRectangle(GlobalObject[i][WorldX]-1, GlobalObject[i][WorldY]-1, GlobalObject[i][WorldX]+1, GlobalObject[i][WorldY]+1);
	
	for(new a = 0; a < PLAYERS; a ++)
	{
		if(!IsPlayerConnected(a)) continue;
		Streamer_Update(a);
	}
	
	if(playerid != -1)
	{
		SetPVarInt(playerid,"SelectedObject", 0);
		SetPVarInt(playerid,"SelectedContainer", 0);
    	SetPVarInt(playerid,"SelectedObjectIn", 0);
    	SetPVarInt(playerid,"SelectedObjectSize", 0);

    	LoadObjects(playerid, 0);
		LoadNearObjects(playerid, 0);
	}
	
	CallLocalFunction("OnObjectDropped","iifff",playerid, object, fX, fY, fZ);
	return 1;
}


forward DropObject(playerid, object, type, source);
public DropObject(playerid, object, type, source)
{
    new objectstr[140], tempobjects[35];
	cache_get_field_content(0, "InsideIDs", objectstr);
	sscanf(objectstr, "p<,>a<i>[35]", tempobjects);
	objectstr = "";
	
	new Float:fPos[3];
	GetPlayerPos(playerid, fPos[0], fPos[1], fPos[2]);

	if(source != -1)
	{
	    if(type == 6 || type == 7)
		{
			format(query, sizeof query, "UPDATE playerobjects SET P_SpecialFlag_1 = 0 WHERE PID = %d AND P_SpecialFlag_1 = %d", source, object);
			mysql_tquery(dbHandle, query, "", "");
		}
	
		for(new i = 0; i < sizeof tempobjects; i ++)
		{
		    if(tempobjects[i] == object)
		    {
		        tempobjects[i] = 0;
				mysql_format(dbHandle, medquery, sizeof medquery, "SELECT * FROM playerobjects \
				JOIN objects ON playerobjects.O_ObjectID = objects.ID WHERE playerobjects.PID = %d", object);
				mysql_tquery(dbHandle, medquery, "DropObjectOnPosition", "iifffi",playerid, object, fPos[0], fPos[1], fPos[2],3);
		        object = -1;
			}
			if(tempobjects[i] != 0)
			{
		    	format(objectstr,sizeof(objectstr),"%s%d,",objectstr,tempobjects[i]);
			}
		}
		strdel(objectstr, strlen(objectstr)-1, strlen(objectstr));
		mysql_format(dbHandle, query, sizeof query,"UPDATE objectinventory SET InsideIDs = '%s' WHERE OI_ObjectID = %d",objectstr,source);
		mysql_tquery(dbHandle, query, "", "");
		
		return 1;
	}
	else
	{
	    mysql_format(dbHandle, medquery, sizeof medquery, "SELECT * FROM playerobjects \
		JOIN objects ON playerobjects.O_ObjectID = objects.ID WHERE playerobjects.PID = %d", object);
		mysql_tquery(dbHandle, medquery, "DropObjectOnPosition", "iifffi",playerid, object, fPos[0], fPos[1], fPos[2],3);
		return 1;
	}
}

forward OnPlayerAddObjectToObject(playerid, object, dest);
public OnPlayerAddObjectToObject(playerid, object, dest)
{
    new objectstr[140];
	cache_get_field_content(0, "InsideIDs", objectstr);
	if(strlen(objectstr) == 0)
        format(objectstr,sizeof(objectstr),"%d",object);
	else
    	format(objectstr,sizeof(objectstr),"%s,%d",objectstr,object);

    mysql_format(dbHandle, query, sizeof query,"UPDATE objectinventory SET InsideIDs = '%s' WHERE OI_ObjectID = %d",objectstr,dest);
	mysql_tquery(dbHandle, query, "", "");

	if(playerid != INVALID_PLAYER_ID)
	{
		SetPVarInt(playerid,"SelectedObject", 0);
		SetPVarInt(playerid,"SelectedContainer", 0);
    	SetPVarInt(playerid,"SelectedObjectIn", 0);
    	SetPVarInt(playerid,"SelectedObjectSize", 0);

    	LoadObjects(playerid, 1);
	}
	return 1;
}

forward AddObjectToObject(playerid, object, dest);
public AddObjectToObject(playerid, object, dest)
{
	format(query, sizeof(query),"SELECT InsideIDs FROM objectinventory WHERE OI_ObjectID = %d", dest);
	mysql_tquery(dbHandle, query, "OnPlayerAddObjectToObject", "iii", playerid, object, dest);
	return 1;
}

forward RemoveObjectFromObject(playerid, object, source);
public RemoveObjectFromObject(playerid, object, source)
{
	format(query, sizeof(query),"SELECT InsideIDs FROM objectinventory WHERE OI_ObjectID = %d", source);
	mysql_tquery(dbHandle, query, "OnPlayerRemoveObjectFromObject", "iii", playerid, object, source);
	return 1;
}

forward OnPlayerRemoveObjectFromObject(playerid, object, source);
public OnPlayerRemoveObjectFromObject(playerid, object, source)
{
	//printf("OnPlayerRemoveObjectFromObject(playerid, %d, %d)", object, source);

    new objectstr[140], tempobjects[35];
	cache_get_field_content(0, "InsideIDs", objectstr);
	sscanf(objectstr, "p<,>a<i>[35]", tempobjects);
	objectstr = "";
	
	for(new i = 0; i < sizeof tempobjects; i ++)
	{
	    if(tempobjects[i] == object)
	    {
	        tempobjects[i] = 0,
	        object = -1;
		}
		if(tempobjects[i] != 0)
		{
	    	format(objectstr,sizeof(objectstr),"%s%d,",objectstr,tempobjects[i]);
		}
	}
	strdel(objectstr, strlen(objectstr)-1, strlen(objectstr));
	mysql_format(dbHandle, query, sizeof query,"UPDATE objectinventory SET InsideIDs = '%s' WHERE OI_ObjectID = %d",objectstr,source);
	mysql_tquery(dbHandle, query, "", "");
	
	if(playerid != INVALID_PLAYER_ID)
	{
		SetPVarInt(playerid,"SelectedObject", 0);
		SetPVarInt(playerid,"SelectedContainer", 0);
    	SetPVarInt(playerid,"SelectedObjectIn", 0);
    	SetPVarInt(playerid,"SelectedObjectSize", 0);
    	
    	LoadObjects(playerid, 1);
	}
	return 1;
}

forward OnPlayerClickAction(playerid, ObjectID, ActionID, const ActionName[], ObjectType, CurrentUses, TotalUses, Flag1, Flag2, Flag3, objectsource, SpFlag1, SpFlag2, mem1, mem2);
public OnPlayerClickAction(playerid, ObjectID, ActionID, const ActionName[], ObjectType, CurrentUses, TotalUses, Flag1, Flag2, Flag3, objectsource, SpFlag1, SpFlag2, mem1, mem2)
{
    memoryslot[playerid][0] = 0;
    memoryslot[playerid][1] = 0;
    SetPVarInt(playerid,"ActionObject", 0);
    DestroyActions(playerid);
    
    
    //Food eating example, auto remove if uses reach to 0
    if(ObjectType == 5)
    {//Food object on DB
        if(ActionID == 7) // Eat Food
        {
            if(SpFlag1 == 1) //example on food condition?
				RenderMessage(playerid, 0xFF6600FF, "You ate some awesome food.");
            else if(SpFlag1 == 2)
            	RenderMessage(playerid, 0xFF6600FF, "You ate some awfull food.");
            
            new Float:HP;
            GetPlayerHealth(playerid, HP);
            HP = HP + float(Flag1);
            if(HP > 100)
                HP = 100;
            
            SetPlayerHealth(playerid, HP);
            SetObjectUses(ObjectID, CurrentUses - 1);
            
            if(CurrentUses-1 != 0)
            {
            	format(query, sizeof query,"UPDATE playerobjects SET Uses = %d WHERE PID = %d",CurrentUses - 1, ObjectID);
            	mysql_tquery(dbHandle, query, "", "");
			}
			else
			{
			    if(objectsource == -1)
			    {//food was depleted from outside an object
			        RemoveObjectFromDatabase(ObjectID, true);
			        LoadObjects(playerid, 1);
			    }
			    else
			    {
			        RemoveObjectFromObject(playerid, ObjectID, objectsource);
			        RemoveObjectFromDatabase(ObjectID, true);
			    }
			    RenderMessage(playerid, 0xFF6600FF, "You ate the remaining food on the can.");
			}
			return 1;
        }
		else if(ActionID == 6) // Eat All Food
		{
		    if(SpFlag1 == 1)
            	RenderMessage(playerid, 0xFF6600FF, "You ate the whole can of awesome food.");
            else if(SpFlag1 == 2)
            	RenderMessage(playerid, 0xFF6600FF, "You ate the whole can of awfull food.");
		    
		    new Float:HP;
            GetPlayerHealth(playerid, HP);
            HP = HP + float(Flag1*CurrentUses);
            if(HP > 100)
                HP = 100;

            SetPlayerHealth(playerid, HP);
            if(objectsource == -1)
		    {//food was depleted from outside an object
		        RemoveObjectFromDatabase(ObjectID, true);
		        LoadObjects(playerid, 1);
		    }
		    else
		    {
		        RemoveObjectFromObject(playerid, ObjectID, objectsource);
		        RemoveObjectFromDatabase(ObjectID, true);
		    }
		}
		return 1;
    }
    if(ObjectType == 6 || ObjectType == 10) // magazine or ammo box (for add/swap)
    {
        if(ActionID == 12) // check ammo
        {
			if(SpFlag1 >= 1)
			{//ammo inside
			    format(query, sizeof query, "SELECT Uses FROM playerobjects WHERE PID = %d", SpFlag1);
			    mysql_tquery(dbHandle, query, "OnPlayerRequestAmmo", "iii", playerid, ObjectID, SpFlag1);
			}
			else
			{
			    RenderMessage(playerid, 0xFF6600FF, "The magazine is empty.");
			}
        }
        else if(ActionID == 8) //empty magazine
        {
            if(SpFlag1 >= 1)
            {
                mysql_format(dbHandle, bigquery, sizeof bigquery,
				"SELECT a.OI_ObjectID, a.InsideIDs, c.Carry, c.H_Size \
				FROM objectinventory as a \
				JOIN playerobjects as b ON a.OI_ObjectID = b.PID \
				JOIN objects as c ON b.O_ObjectID = c.ID \
				WHERE OI_ObjectID = %d OR OI_ObjectID = %d OR OI_ObjectID = %d",
				objectsource, ObjectID, SpFlag1);
				mysql_tquery(dbHandle, bigquery, "MoveObjectToObject","iiiiiiiii", playerid, -3, SpFlag1, 7, ObjectID,
				6, objectsource, 1, playerid);
            }
            else
            {
                RenderMessage(playerid, 0xFF6600FF, "The magazine is empty.");
            }
        }
        
        if(ActionID == 2)
        {//add into
            SetPVarInt(playerid,"SwappingStep", 0);
        
            if(ObjectType == 6) // magazine
            {
                if(SpFlag1 > 0)
                    return RenderMessage(playerid, 0xFF6600FF, "That magazine already haves ammo inside!");
                    
                mysql_format(dbHandle, medquery, sizeof medquery, "SELECT OI_ObjectID, InsideIDs FROM objectinventory WHERE OI_ObjectID = %d OR OI_ObjectID = %d", GetPVarInt(playerid,"SelectedObjectIn"),ObjectID);
				mysql_tquery(dbHandle, medquery, "MoveObjectToObject","iiiiiiiii", playerid, 0, GetPVarInt(playerid,"SelectedObject"), GetPVarInt(playerid,"SelectedObjectType"), GetPVarInt(playerid,"SelectedObjectIn"),
				GetPVarInt(playerid,"SelectedObjectInType"), ObjectID, ObjectType, playerid);
        	}
        	else if(ObjectType == 10) // Ammo Box
            {
                mysql_format(dbHandle, bigquery, sizeof bigquery,
				"SELECT a.OI_ObjectID, a.InsideIDs, c.Carry, c.H_Size \
				FROM objectinventory as a \
				JOIN playerobjects as b ON a.OI_ObjectID = b.PID \
				JOIN objects as c ON b.O_ObjectID = c.ID \
				WHERE OI_ObjectID = %d OR OI_ObjectID = %d OR OI_ObjectID = %d",
				GetPVarInt(playerid,"SelectedObjectIn"),ObjectID, GetPVarInt(playerid,"SelectedObject"));
				mysql_tquery(dbHandle, bigquery, "MoveObjectToObject","iiiiiiiii", playerid, -1, GetPVarInt(playerid,"SelectedObject"), GetPVarInt(playerid,"SelectedObjectType"), GetPVarInt(playerid,"SelectedObjectIn"),
				GetPVarInt(playerid,"SelectedObjectInType"), ObjectID, ObjectType, playerid);
            }
		}
		else if(ActionID == 1)
        {//Swap
            if(objectsource != GetPVarInt(playerid,"SelectedObjectIn"))
            {
	            mysql_format(dbHandle, medquery, sizeof medquery, "SELECT OI_ObjectID, InsideIDs FROM objectinventory WHERE OI_ObjectID = %d OR OI_ObjectID = %d", GetPVarInt(playerid,"SelectedObjectIn"),objectsource);
				mysql_tquery(dbHandle, medquery, "SwapObjectWithObject","iiiiiiiiiiii", playerid, GetPVarInt(playerid,"SelectedObjectIn"),objectsource, GetPVarInt(playerid,"SelectedObject"),
				ObjectID, GetPVarInt(playerid,"SelectedObjectType"), ObjectType, containertype[playerid][mem2], GetPVarInt(playerid,"SelectedObjectInType"),
				GetPVarInt(playerid,"SelectedObjectPosition"), mem1, mem2);
			}
			else
			{
			    InternalSwapObject(playerid, GetPVarInt(playerid,"SelectedObjectIn"), GetPVarInt(playerid,"SelectedObject"), ObjectID,
				GetPVarInt(playerid,"SelectedObjectType"), ObjectType, containertype[playerid][mem2], GetPVarInt(playerid,"SelectedObjectInType"),
				GetPVarInt(playerid,"SelectedObjectPosition"), mem1, mem2);
			}
		}
    }
    if(ObjectType == 7)
    {
        if(ActionID == 10)
        {//split
			if(CurrentUses == 1)
			    return RenderMessage(playerid, 0xFF6600FF, "You can't split a single bullet.");
        
            new newammo, oldammo;
            newammo = CurrentUses / 2;
            oldammo = CurrentUses / 2;
            
            if(CurrentUses % 2 == 1)
				newammo ++;
        
            format(query, sizeof query, "SELECT O_ObjectID FROM playerobjects WHERE PID = %d", ObjectID);
            mysql_tquery(dbHandle, query, "SplitAmmo", "iiiiii", playerid, ObjectID, newammo, oldammo, objectsource, TotalUses);
        }
        else if(ActionID == 13)
        {//combine
			mysql_format(dbHandle, medquery, sizeof medquery,
			"SELECT playerobjects.Uses, objects.SpecialFlag_1 \
			FROM playerobjects \
			JOIN objects ON playerobjects.O_ObjectID = objects.ID \
			WHERE PID = %d",GetPVarInt(playerid,"SelectedObject"));
			mysql_tquery(dbHandle, medquery, "CheckForBulletCombining", "iiiiiii", playerid, ObjectID, CurrentUses, TotalUses, GetPVarInt(playerid,"SelectedObject"), GetPVarInt(playerid,"SelectedObjectIn"), Flag1);
        }
        else if(ActionID == 1)
        {//swap
            if(objectsource != GetPVarInt(playerid,"SelectedObjectIn"))
            {
	            mysql_format(dbHandle, medquery, sizeof medquery, "SELECT OI_ObjectID, InsideIDs FROM objectinventory WHERE OI_ObjectID = %d OR OI_ObjectID = %d", GetPVarInt(playerid,"SelectedObjectIn"),objectsource);
				mysql_tquery(dbHandle, medquery, "SwapObjectWithObject","iiiiiiiiiiii", playerid, GetPVarInt(playerid,"SelectedObjectIn"),objectsource, GetPVarInt(playerid,"SelectedObject"),
				ObjectID, GetPVarInt(playerid,"SelectedObjectType"), ObjectType, containertype[playerid][mem2], GetPVarInt(playerid,"SelectedObjectInType"),
				GetPVarInt(playerid,"SelectedObjectPosition"), mem1, mem2);
			}
			else
			{
			    InternalSwapObject(playerid, GetPVarInt(playerid,"SelectedObjectIn"), GetPVarInt(playerid,"SelectedObject"), ObjectID,
				GetPVarInt(playerid,"SelectedObjectType"), ObjectType, containertype[playerid][mem2], GetPVarInt(playerid,"SelectedObjectInType"),
				GetPVarInt(playerid,"SelectedObjectPosition"), mem1, mem2);
			}
        }
    }
    //CallRemoteFunction("OnPlayerClickAction","iiisiiii",playerid, ObjectID, ActionID, ActionName, ObjectType, CurrentUses, TotalUses, umemoryslot);
	return 1;
}

forward SplitAmmo(playerid, ObjectID, newammo, oldammo, ObjectSource, TotalUses);
public SplitAmmo(playerid, ObjectID, newammo, oldammo, ObjectSource, TotalUses)
{
    new rows, fields;
	cache_get_data(rows, fields);
	if(rows == 0)
	    return 1;

    new objectdata = cache_get_field_content_int(0, "O_ObjectID");

    CreateNewObject(playerid, objectdata, ObjectSource, 0, newammo, TotalUses, PlayerName(playerid));
    RenderMessage(playerid, 0xFF6600FF, "Splitted the ammo. You might have dropped the bullets if you had no space.");
    
    mysql_format(dbHandle, query, sizeof query, "UPDATE playerobjects SET Uses = %d WHERE PID = %d", oldammo, ObjectID);
    mysql_tquery(dbHandle, query);
	return 1;
}

forward CheckForBulletCombining(playerid, destobject, destuses, desttotaluses, source, source_source, destcaliber);
public CheckForBulletCombining(playerid, destobject, destuses, desttotaluses, source, source_source, destcaliber)
{
    if(destuses == desttotaluses)
	    return 1;

    new rows, fields;
	cache_get_data(rows, fields);
	if(rows == 0)
	    return 1;
	    
	new sourcecaliber = cache_get_field_content_int(0, "SpecialFlag_1");
	if(sourcecaliber != destcaliber)
	    return RenderMessage(playerid, 0xFF6600FF, "You can't combine different caliber bullets.");
	    

	new sourceammo = cache_get_field_content_int(0, "Uses");
	new ammoneeded = desttotaluses - destuses;

	if(sourceammo > ammoneeded)
	{//just reduce the first ammo
	    format(query, sizeof query,"UPDATE playerobjects SET Uses = %d WHERE PID = %d",sourceammo-ammoneeded, source);
	    mysql_tquery(dbHandle, query);
	    
	    format(query, sizeof query,"UPDATE playerobjects SET Uses = %d WHERE PID = %d",destuses + ammoneeded, destobject);
	    mysql_tquery(dbHandle, query);
	}
	else
	{//remove ammo object
        RemoveObjectFromDatabase(source, true);
        RemoveObjectFromObject(playerid, source, source_source);
	
	    format(query, sizeof query,"UPDATE playerobjects SET Uses = %d WHERE PID = %d",destuses + sourceammo, destobject);
	    mysql_tquery(dbHandle, query);
	}
	
	RenderMessage(playerid, 0xFF6600FF, "Successfully combined the bullet stacks.");
	return 1;
}

forward OnPlayerRequestAmmo(playerid, mag, ammoid);
public OnPlayerRequestAmmo(playerid, mag, ammoid)
{
    new rows, fields;
	cache_get_data(rows, fields);
	if(rows == 0)
		return RenderMessage(playerid, 0xFF6600FF, "Unknown database error. (Ammo checking).");
	
	new ammo = cache_get_field_content_int(0, "Uses");
	format(msg, sizeof(msg),"There's currently %d bullets inside this magazine.", ammo);
	RenderMessage(playerid, 0xFF6600FF, msg);
	return 1;
}

forward OnPlayerPutObjectInHand(playerid, object, object_type);
public OnPlayerPutObjectInHand(playerid, object, object_type)
{
	format(bigquery, sizeof bigquery, "SELECT playerobjects.O_ObjectID, objects.DisplayZoom, objects.DisplayXOffset, objects.DisplayYOffset, objects.DisplayZOffset, \
	objects.DisplayColor, objects.Display FROM playerobjects JOIN objects ON playerobjects.O_ObjectID = objects.ID WHERE playerobjects.PID = %d", object);
	mysql_tquery(dbHandle,bigquery,"OnPlayerRequestHandDisplay", "i", playerid);
    
    SetPVarInt(playerid,"OnHand",object);
    SetPVarInt(playerid,"OnHandType",object_type);
    SetPVarInt(playerid,"OnHandWeapon", 0);
    SetPVarInt(playerid,"OnHandAmmoID", 0);
    SetPVarInt(playerid,"OnHandMagID", 0);
    
    if(object_type == 2) //weapon (only accepts magazines)
    {
        format(bigquery, sizeof bigquery,
        "SELECT a.PID, a.Uses, a.TotalUses, a.P_SpecialFlag_1, b.ID, b.Name, b.SpecialFlag_1, b.SpecialFlag_2, b.Display, b.TypeID \
		FROM playerobjects as a \
		JOIN objects as b ON (a.O_ObjectID = b.ID) \
		WHERE a.PID = %d \
		OR a.PID = (SELECT P_SpecialFlag_1 from playerobjects WHERE PID = %d) \
		OR a.PID = (SELECT P_SpecialFlag_1 from playerobjects WHERE PID = (SELECT P_SpecialFlag_1 from playerobjects WHERE PID = %d))", object, object, object);
        mysql_tquery(dbHandle, bigquery, "OnPlayerPutWeaponOnHand", "ii", playerid, object);
    }
    if(object_type == 11) //bolt weapon (only accepts ammo, not magazines)
    {
        format(bigquery, sizeof bigquery,
        "SELECT a.PID, a.Uses, a.TotalUses, a.P_SpecialFlag_1, b.ID, b.Name, b.SpecialFlag_1, b.SpecialFlag_2, b.Display, b.TypeID \
		FROM playerobjects as a \
		JOIN objects as b ON (a.O_ObjectID = b.ID) \
		WHERE a.PID = %d \
		OR a.PID = (SELECT P_SpecialFlag_1 from playerobjects WHERE PID = %d)", object, object);
        mysql_tquery(dbHandle, bigquery, "OnPlayerPutWeaponOnHand", "ii", playerid, object);
    }
	return 1;
}

forward OnServerObjectMoved(playerid, object, type, source, sourcetype, dest, desttype, newowner);
public OnServerObjectMoved(playerid, object, type, source, sourcetype, dest, desttype, newowner)
{
	//if(type == TYPE_AMMO && desttype == TYPE_WEAPON) <- Ammo added to a weapon, for example... Use Special flags variables in the DB to store the ID of the ammo that was just added
	//OnPlayerWeaponShot to decrease the ammo? Or even less resourceful, when disconnecting or moving/dropping the object

	if(desttype == 2 && type != 6)
	{
	    RenderMessage(playerid, 0xFF6600FF, "You can only attach magazines on weapons.");
	    return 0;
	}
	if(desttype == 11 && type != 7)
	{
	    RenderMessage(playerid, 0xFF6600FF, "You can only attach ammo on bolt action weapons.");
	    return 0;
	}
	if(desttype == 6 && type != 7)
	{
	    RenderMessage(playerid, 0xFF6600FF, "You can only attach ammo on magazines.");
	    return 0;
	}
	if(desttype == 10 && type != 7)
	{
	    RenderMessage(playerid, 0xFF6600FF, "You can only put ammo on the ammo boxes.");
	    return 0;
	}


	if(type == 7 && desttype == 6)
	{//ammo into mag
	    format(query, sizeof query,"UPDATE playerobjects SET P_SpecialFlag_1 = %d WHERE PID = %d",object, dest);
	    mysql_tquery(dbHandle, query, "", "");
	}
	else if(type == 7 && sourcetype == 6)
	{//ammo outside mag
	    format(query, sizeof query,"UPDATE playerobjects SET P_SpecialFlag_1 = 0 WHERE PID = %d", source);
	    mysql_tquery(dbHandle, query, "", "");
	}
	
	else if(type == 7 && desttype == 11)
	{//bullet into weapon
	    format(query, sizeof query,"UPDATE playerobjects SET P_SpecialFlag_1 = %d WHERE PID = %d",object, dest);
	    mysql_tquery(dbHandle, query, "", "");
	    
	    format(bigquery, sizeof bigquery,
		"SELECT playerobjects.PID, playerobjects.Uses, playerobjects.O_ObjectID, objects.SpecialFlag_3, playerobjects.TotalUses, objects.TypeID \
		FROM playerobjects JOIN objects ON playerobjects.O_ObjectID = objects.ID \
		WHERE PID = %d OR PID = %d", object, dest);
	    mysql_tquery(dbHandle, bigquery, "CheckBulletLimit", "iiii", playerid, object, source, sourcetype);
	}
	else if(type == 7 && sourcetype == 11)
	{//bullet outside weapon

	    if(GetPVarInt(playerid,"OnHandAmmoID") == object)
	        return 0;

	    format(query, sizeof query,"UPDATE playerobjects SET P_SpecialFlag_1 = 0 WHERE PID = %d", source);
	    mysql_tquery(dbHandle, query, "", "");
	}
	
    else if(type == 6 && desttype == 2)
	{//mag into weapon
	    format(query, sizeof query,"UPDATE playerobjects SET P_SpecialFlag_1 = %d WHERE PID = %d",object, dest);
	    mysql_tquery(dbHandle, query, "", "");
	}
	else if(type == 6 && sourcetype == 2)
	{//mag outside weapon
	
	    if(GetPVarInt(playerid,"OnHandMagID") == object)
	        return 0;
	
	    format(query, sizeof query,"UPDATE playerobjects SET P_SpecialFlag_1 = 0 WHERE PID = %d", source);
	    mysql_tquery(dbHandle, query, "", "");
	}

	return 1;
}

forward OnObjectSwapped(playerid, object1source, object2source, object, object2, object1type, object2type, object1desttype, object1sourcetype);
public OnObjectSwapped(playerid, object1source, object2source, object, object2, object1type, object2type, object1desttype, object1sourcetype)
{
	new
		object1dest = object2source;

	if(object1desttype == 2 && object1type != 6)
	{
	    RenderMessage(playerid, 0xFF6600FF, "You can only attach magazines on weapons.");
	    return 0;
	}
	if(object1desttype == 6 && object1type != 7)
	{
	   	RenderMessage(playerid, 0xFF6600FF, "You can only atatch bullets on magazines.");
	    return 0;
	}
	if(object1desttype == 11 && object1type != 7)
	{
	   	RenderMessage(playerid, 0xFF6600FF, "You can only atatch bullets on magazines.");
	    return 0;
	}
	
	if(object1type == 7 && object2type == 7 && object1desttype == 11)
	{
	    format(bigquery, sizeof bigquery,
		"SELECT playerobjects.PID, playerobjects.Uses, playerobjects.O_ObjectID, objects.SpecialFlag_3, playerobjects.TotalUses, objects.TypeID \
		FROM playerobjects JOIN objects ON playerobjects.O_ObjectID = objects.ID \
		WHERE PID = %d OR PID = %d", object, object1dest);
	    mysql_tquery(dbHandle, bigquery, "CheckBulletLimit", "iiii", playerid, object, object1source, object1sourcetype);
	}
	
	
	if(GetPVarInt(playerid, "SwappingStep") == 0)
	{
		if((object2type == 6 || object2type == 10) && object1type == 7)
		{//ammo into mag - already found, check if he wants to swap or add them
	    	SetPVarInt(playerid,"SwappingStep", 1);
	    	
			for(new i = 0; i < sizeof(slotused[]); i ++)
			{
			    for(new a = 0; a < sizeof(slotused[][]); a ++)
			    {
			        if(slotused[playerid][i][a] == object2)
			        {
			            if(objectsize[playerid][i][a] == 0) continue;
			        
						memoryslot[playerid][0] = a;
						memoryslot[playerid][1] = i;
						break;
			        }
			    }
			}
			SetPVarInt(playerid, "ActionObject", object2);
			BringActionMenu(playerid, object2, memoryslot[playerid][0], 1, object2source);
		    return 0;
		}
		if(object2type == 7 && object1type == 7)
		{
		    SetPVarInt(playerid,"SwappingStep", 2);

			for(new i = 0; i < sizeof(slotused[]); i ++)
			{
			    for(new a = 0; a < sizeof(slotused[][]); a ++)
			    {
			        if(slotused[playerid][i][a] == object2)
			        {
			            if(objectsize[playerid][i][a] == 0) continue;

						memoryslot[playerid][0] = a;
						memoryslot[playerid][1] = i;
						break;
			        }
			    }
			}
			SetPVarInt(playerid, "ActionObject", object2);
			BringActionMenu(playerid, object2, memoryslot[playerid][0], 1, object2source);
		    return 0;
		}
	}


	if(object1type == 7 && object1sourcetype == 6)
	{//ammo outside mag
	    format(query, sizeof query,"UPDATE playerobjects SET P_SpecialFlag_1 = %d WHERE PID = %d",object2, object1source);
	    mysql_tquery(dbHandle, query, "", "");
	}

    else if(object1type == 6 && object1sourcetype == 2)
	{//mag outside weapon
	    if(GetPVarInt(playerid,"OnHandMagID") != 0)
	        return 0;
	
	    format(query, sizeof query,"UPDATE playerobjects SET P_SpecialFlag_1 = %d WHERE PID = %d",object2, object1source);
	    mysql_tquery(dbHandle, query, "", "");
	}
	
	if(object1type == 6 && object1desttype == 2)
	{//mag into weapon
	    if(GetPVarInt(playerid,"OnHandMagID") != 0)
	        return 0;
	
	    format(query, sizeof query,"UPDATE playerobjects SET P_SpecialFlag_1 = %d WHERE PID = %d",object, object1dest);
	    mysql_tquery(dbHandle, query, "", "");
	}
	
	else if(object1type == 7 && object1desttype == 6)
	{// ammo into mag
	    format(query, sizeof query,"UPDATE playerobjects SET P_SpecialFlag_1 = %d WHERE PID = %d",object, object1dest);
	    mysql_tquery(dbHandle, query, "", "");
	}


	if(object1type == 7 && object1desttype == 11)
	{// ammo into weapon
	    format(query, sizeof query,"UPDATE playerobjects SET P_SpecialFlag_1 = %d WHERE PID = %d",object, object1dest);
	    mysql_tquery(dbHandle, query, "", "");
	}
	if(object1type == 7 && object1sourcetype == 11)
	{//ammo outside weapon
	    format(query, sizeof query,"UPDATE playerobjects SET P_SpecialFlag_1 = %d WHERE PID = %d",object2, object1source);
	    mysql_tquery(dbHandle, query, "", "");
	}

		
		
	return 1;
}

forward OnObjectDropped(playerid, object, Float:fX, Float:fY, Float:fZ);
public OnObjectDropped(playerid, object, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

forward UpdateObjectLastPosition(playerid, object);
public UpdateObjectLastPosition(playerid, object)
{
	new rows, fields;
	cache_get_data(rows, fields);
	if(rows == 0)
	    return 1;
	    
    new maxpos = cache_get_row_int (0, 0);
    format(query, sizeof(query),"UPDATE playerobjects SET position = %d WHERE PID = %d", maxpos+1, object);
    mysql_tquery(dbHandle, query, "", "");
    
    if(playerid != -1)
    {
        //SetPVarInt(playerid, "MinDisplay", maxpos);
        //SetPVarInt(playerid, "DisplayingPage", maxpos);
        LoadObjects(playerid, 0);
    }
	return 1;
}


forward OnPlayerRequestHandDisplay(playerid);
public OnPlayerRequestHandDisplay(playerid)
{
    new rows, fields;
	cache_get_data(rows, fields);
	if(rows == 0)
	    return TDError(playerid,"Could not load your object displaying values.");

    new display = cache_get_field_content_int(0, "Display");
    new color = cache_get_field_content_int(0, "DisplayColor");
    new Float:fRotX = cache_get_field_content_float(0, "DisplayXOffset");
    new Float:fRotY = cache_get_field_content_float(0, "DisplayYOffset");
    new Float:fRotZ = cache_get_field_content_float(0, "DisplayZOffset");
    new Float:fZoom = cache_get_field_content_float(0, "DisplayZoom");

    PlayerTextDrawHide(playerid, Inv[playerid][18]);
    PlayerTextDrawSetPreviewModel(playerid, Inv[playerid][18], display);
    PlayerTextDrawSetPreviewRot(playerid, Inv[playerid][18], fRotX, fRotY, fRotZ, fZoom);
    PlayerTextDrawColor(playerid, Inv[playerid][18], color);
    PlayerTextDrawShow(playerid, Inv[playerid][18]);

    SetPlayerAttachedObject(playerid, 0, display, 6);
	return 1;
}

forward OnPlayerPutWeaponOnHand(playerid, object);
public OnPlayerPutWeaponOnHand(playerid, object)
{
    new rows, fields;
	cache_get_data(rows, fields);
	//printf("%d", rows);

	new weaprow, ammorow, magrow;
	for(new i = 0; i < rows; i ++)
	{
	    if(cache_get_field_content_int(i, "TypeID") == 2 || cache_get_field_content_int(i, "TypeID") == 11) weaprow = i;
	    else if(cache_get_field_content_int(i, "TypeID") == 6) magrow = i;
	    else if(cache_get_field_content_int(i, "TypeID") == 7) ammorow = i;
	}

    SetPVarInt(playerid,"OnHandAmmoID", cache_get_field_content_int(ammorow, "PID"));
    SetPVarInt(playerid,"OnHandMagID", cache_get_field_content_int(magrow, "PID"));

	new ammo = cache_get_field_content_int(ammorow, "Uses");
	new weapon = cache_get_field_content_int(weaprow, "SpecialFlag_1");
	new weaponmag = cache_get_field_content_int(weaprow, "SpecialFlag_2");
	new ammotype = cache_get_field_content_int(ammorow, "SpecialFlag_1");
	new magtype = cache_get_field_content_int(magrow, "SpecialFlag_1");
    new weaptype = cache_get_field_content_int(weaprow, "TypeID");
    
    SetPVarInt(playerid,"OnHandWeapon", weapon);
    SetPVarInt(playerid,"OnHandAmmo", ammo);
    ResetPlayerWeapons(playerid);

	if((weaptype == 2 && rows != 3) || (weaptype == 11 && rows != 2))
	{
	    RenderMessage(playerid, 0xFF6600FF, "The weapon is now on your hand. It doesn't seem to have any ammo inside.");
	    SetPVarInt(playerid, "InvalidAmmo", 1);
	    return 1;
	}
	if(weaptype == 2)
	{
		if(ammotype != magtype)
		{
		    RenderMessage(playerid, 0xFF6600FF, "The weapon is now on your hand, but the ammo wont fit the magazine caliber so you're out of ammo.");
		    SetPVarInt(playerid, "InvalidAmmo", 1);
		    return 1;
		}
		if(magtype != weaponmag)
		{//example of invalid mag on weapon
	        RenderMessage(playerid, 0xFF6600FF, "The weapon is now on your hand, but your magazine is not the weapon's caliber, so you're out of ammo.");
	        SetPVarInt(playerid, "InvalidAmmo", 1);
	    	return 1;
		}
	}
	else if(weaptype == 11)
	{
	    if(ammotype != weaponmag)
	    {
	        RenderMessage(playerid, 0xFF6600FF, "The weapon is now on your hand. The ammo doesn't fit the weapon's caliber.");
		    SetPVarInt(playerid, "InvalidAmmo", 1);
		    return 1;
	    }
	}

	if(ammo > 0 && rows > 1)
	{
		GivePlayerWeapon(playerid, weapon, ammo);
		SetPVarInt(playerid, "InvalidAmmo", 0);
		RenderMessage(playerid, 0xFF6600FF, "You've put the weapon on your hand.");
	}
	else
	{
	    SetPVarInt(playerid, "InvalidAmmo", 1);
		RenderMessage(playerid, 0xFF6600FF, "You've put the weapon on your hand, it seems not to have ammo.");
	}
	return 1;
}

forward OnPlayerRemoveWeaponFromHand(playerid);
public OnPlayerRemoveWeaponFromHand(playerid)
{
	if(GetPVarInt(playerid, "InvalidAmmo") == 0)
	{
	    new weapon = GetPVarInt(playerid,"OnHandWeapon");
		new dweapon, dammo;
	    GetPlayerWeaponData(playerid, GetWeaponSlot(weapon), dweapon, dammo);
		if(dammo <= 0)
		{//ammo depleted
		    RemoveObjectFromObject(playerid, GetPVarInt(playerid,"OnHandAmmoID"), GetPVarInt(playerid,"OnHandMagID"));
            RemoveObjectFromDatabase(GetPVarInt(playerid,"OnHandAmmoID"), true);
            
            format(query, sizeof query,"UPDATE playerobjects SET P_SpecialFlag_1 = 0 WHERE PID = %d", GetPVarInt(playerid,"OnHandMagID"));
			mysql_tquery(dbHandle, query, "", "");
		}
		else
		{
		    format(query, sizeof query,"UPDATE playerobjects SET uses = %d WHERE PID = %d", GetPlayerAmmo(playerid), GetPVarInt(playerid,"OnHandAmmoID"));
			mysql_tquery(dbHandle, query, "", "");
		}
		ResetPlayerWeapons(playerid);

		SetPVarInt(playerid,"OnHandWeapon", 0);
	    SetPVarInt(playerid,"OnHandAmmoID", 0);
	    SetPVarInt(playerid,"OnHandMagID", 0);
	}

	return 1;
}


public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == ActionMenu[playerid][3])
    {
        memoryslot[playerid][0] = 0;
        memoryslot[playerid][1] = 0;
        SetPVarInt(playerid,"ActionObject", 0);
        SetPVarInt(playerid,"SwappingStep", 0);
        DestroyActions(playerid);
        return 1;
    }
    for(new i = 0; i < sizeof(ActionMenu[]); i ++)
    {
        if(playertextid == ActionMenu[playerid][i])
        {
			CallLocalFunction("OnPlayerClickAction","iiisiiiiiiiiiii",playerid, GetPVarInt(playerid,"ActionObject"), action[playerid][i],
			actionname[playerid][i], objecttype[playerid], objectuses[playerid][0], objectuses[playerid][1], objectflags[playerid][0], objectflags[playerid][4], objectflags[playerid][1],
			objectorigin[playerid], objectflags[playerid][2], objectflags[playerid][3], memoryslot[playerid][1], memoryslot[playerid][0]);
			return 1;
        }
    }

    if(playertextid == Inv[playerid][14])
    {
        HideInventoryBase(playerid);
        CancelSelectTextDraw(playerid);
        DestroyInventoryObjects(playerid);
        DestroyActions(playerid);
        DestroyNearInventoryObjects(playerid);
        
        for(new i = 0; i < sizeof(objectsstored[]); i ++)
		{
		    for(new a = 0; a < 4; a ++)
		    {
			    objectsstored[playerid][i][a] = 0;
			    slotused[playerid][i][a] = -1;
			    objectsize[playerid][i][a] = 0;
			    objectdisplay[playerid][i][a] = 0;
			    objecttypes[playerid][i][a] = 0;

			    g_objectsstored[playerid][i][a] = 0;
			    g_slotused[playerid][i][a] = -1;
			    g_objectsize[playerid][i][a] = 0;
			    g_objectdisplay[playerid][i][a] = 0;
			    g_objecttypes[playerid][i][a] = 0;
			}
		}
		for(new a = 0; a < 4; a ++)
		{
		    slots[playerid][a] = 0;
			slotbelongsto[playerid][a] = 0;
			objectcap[playerid][a] = 0;
			
			g_slots[playerid][a] = 0;
			g_slotbelongsto[playerid][a] = 0;
			g_objectcap[playerid][a] = 0;
			

			container[playerid][a] = 0;
			g_container[playerid][a] = 0;
			containerdisplay[playerid][a] = 0;
			g_containerdisplay[playerid][a] = 0;
			containertype[playerid][a] = 0;
			g_containertype[playerid][a] = 0;
            containersize[playerid][a] = 0;
			g_containersize[playerid][a] = 0;
		}
		
		SetPVarInt(playerid,"SelectedObject", 0);
		SetPVarInt(playerid,"SelectedContainer", 0);
	    SetPVarInt(playerid,"SelectedObjectIn", 0);
	    SetPVarInt(playerid,"SelectedObjectSize", 0);
	    SetPVarInt(playerid,"DisplayingPage", 0);
	    SetPVarInt(playerid,"ActionObject", 0);
        return 1;
    }
    else if(playertextid == Inv[playerid][13])
    {
        if(GetPVarInt(playerid,"OnHandWeapon") != 0)
        {
			OnPlayerRemoveWeaponFromHand(playerid);
        }
    
        PlayerTextDrawSetPreviewModel(playerid, Inv[playerid][18], 19300);
		SetPVarInt(playerid,"OnHand", 0);
		SetPVarInt(playerid,"OnHandWeapon", 0);
	    SetPVarInt(playerid,"OnHandAmmoID", 0);
	    SetPVarInt(playerid,"OnHandMagID", 0);
     	RemovePlayerAttachedObject(playerid, 0);
		PlayerTextDrawHide(playerid, Inv[playerid][18]);
		return 1;
    }
    else if(playertextid == Inv[playerid][15])
	{ //up
		if(GetPVarInt(playerid, "DisplayingPage") == 1)
		    return 1;
	        
	    new mindisplay = GetPVarInt(playerid, "MinDisplay");
        SetPVarInt(playerid, "MinDisplay", mindisplay - 2);
        SetPVarInt(playerid, "DisplayingPage", GetPVarInt(playerid, "DisplayingPage") -1);
        OnPlayerClickPlayerTextDraw(playerid, ActionMenu[playerid][3]);
        
        LoadObjects(playerid, 0);
	        
		PlayerTextDrawDestroy(playerid, Inv[playerid][16]);

		new Float:ypos = ((GetPVarInt(playerid,"DisplayingPage")-1)*300)/GetPVarInt(playerid,"DisplayingPages") + 125;
	    Inv[playerid][16] = CreatePlayerTextDraw(playerid, 636.500000, ypos, "_");
		PlayerTextDrawAlignment(playerid, Inv[playerid][16], 2);
		PlayerTextDrawBackgroundColor(playerid, Inv[playerid][16], 255);
		PlayerTextDrawFont(playerid, Inv[playerid][16], 1);
		new Float:barsize = 34.2/float(GetPVarInt(playerid,"DisplayingPages"));
		if(barsize < 0.2)
	    	barsize = 0.2;
		PlayerTextDrawLetterSize(playerid, Inv[playerid][16], 0.509999, barsize);
		PlayerTextDrawColor(playerid, Inv[playerid][16], -1442840321);
		PlayerTextDrawSetOutline(playerid, Inv[playerid][16], 0);
		PlayerTextDrawSetProportional(playerid, Inv[playerid][16], 1);
		PlayerTextDrawSetShadow(playerid, Inv[playerid][16], 1);
		PlayerTextDrawUseBox(playerid, Inv[playerid][16], 1);
		PlayerTextDrawBoxColor(playerid, Inv[playerid][16], -1157627734);
		PlayerTextDrawTextSize(playerid, Inv[playerid][16], 0.000000, 4.000000);
		PlayerTextDrawShow(playerid, Inv[playerid][16]);
	        
		return 1;
	}
	else if(playertextid == Inv[playerid][23])
	{ // up
	    if(GetPVarInt(playerid, "DisplayingPage_Near") == 1)
		    return 1;

	    new mindisplay = GetPVarInt(playerid, "MinDisplay_near");
        SetPVarInt(playerid, "MinDisplay_Near", mindisplay - 1);
        SetPVarInt(playerid, "DisplayingPage_Near", GetPVarInt(playerid, "DisplayingPage_Near") - 1);

        LoadNearObjects(playerid, 0);

		PlayerTextDrawDestroy(playerid, Inv[playerid][22]);

		new Float:ypos = ((GetPVarInt(playerid,"DisplayingPage_Near")-1)*300)/GetPVarInt(playerid,"DisplayingPages_Near") + 125;
	    Inv[playerid][22] = CreatePlayerTextDraw(playerid, 208.900000, ypos, "_");
		PlayerTextDrawAlignment(playerid, Inv[playerid][22], 2);
		PlayerTextDrawBackgroundColor(playerid, Inv[playerid][22], 255);
		PlayerTextDrawFont(playerid, Inv[playerid][22], 1);
		new Float:barsize = 34.2/float(GetPVarInt(playerid,"DisplayingPages_Near"));
		if(barsize < 0.2)
	    	barsize = 0.2;
		PlayerTextDrawLetterSize(playerid, Inv[playerid][22], 0.509999, barsize);
		PlayerTextDrawColor(playerid, Inv[playerid][22], -1442840321);
		PlayerTextDrawSetOutline(playerid, Inv[playerid][22], 0);
		PlayerTextDrawSetProportional(playerid, Inv[playerid][22], 1);
		PlayerTextDrawSetShadow(playerid, Inv[playerid][22], 1);
		PlayerTextDrawUseBox(playerid, Inv[playerid][22], 1);
		PlayerTextDrawBoxColor(playerid, Inv[playerid][22], -1157627734);
		PlayerTextDrawTextSize(playerid, Inv[playerid][22], 0.000000, 4.000000);
		PlayerTextDrawShow(playerid, Inv[playerid][22]);
	}
	else if(playertextid == Inv[playerid][20])
	{ // down
	    if(GetPVarInt(playerid, "DisplayingPage_Near") == GetPVarInt(playerid, "DisplayingPages_Near"))
	        return 1;

        new mindisplay = GetPVarInt(playerid, "MinDisplay_Near");
        SetPVarInt(playerid, "MinDisplay_Near", mindisplay + 1);
        SetPVarInt(playerid, "DisplayingPage_Near", GetPVarInt(playerid, "DisplayingPage_Near") + 1);
        OnPlayerClickPlayerTextDraw(playerid, ActionMenu[playerid][3]);

        LoadNearObjects(playerid, 0);

        PlayerTextDrawDestroy(playerid, Inv[playerid][22]);
  		new Float:ypos = ((GetPVarInt(playerid,"DisplayingPage_Near")-1)*300)/GetPVarInt(playerid,"DisplayingPages_Near") + 125;
	    Inv[playerid][22] = CreatePlayerTextDraw(playerid, 208.900000, ypos, "_");
		PlayerTextDrawAlignment(playerid, Inv[playerid][22], 2);
		PlayerTextDrawBackgroundColor(playerid, Inv[playerid][22], 255);
		PlayerTextDrawFont(playerid, Inv[playerid][22], 1);
		new Float:barsize = 34.2/float(GetPVarInt(playerid,"DisplayingPages_Near"));
		if(barsize < 0.2)
	    	barsize = 0.2;
		PlayerTextDrawLetterSize(playerid, Inv[playerid][22], 0.509999, barsize);
		PlayerTextDrawColor(playerid, Inv[playerid][22], -1442840321);
		PlayerTextDrawSetOutline(playerid, Inv[playerid][22], 0);
		PlayerTextDrawSetProportional(playerid, Inv[playerid][22], 1);
		PlayerTextDrawSetShadow(playerid, Inv[playerid][22], 1);
		PlayerTextDrawUseBox(playerid, Inv[playerid][22], 1);
		PlayerTextDrawBoxColor(playerid, Inv[playerid][22], -1157627734);
		PlayerTextDrawTextSize(playerid, Inv[playerid][22], 0.000000, 4.000000);
		PlayerTextDrawShow(playerid, Inv[playerid][22]);

	    return 1;
	}
	else if(playertextid == Inv[playerid][8])
	{ // down
	    if(GetPVarInt(playerid, "DisplayingPage") == GetPVarInt(playerid, "DisplayingPages"))
	        return 1;
	        
        new mindisplay = GetPVarInt(playerid, "MinDisplay");
        SetPVarInt(playerid, "MinDisplay", mindisplay + 2);
        SetPVarInt(playerid, "DisplayingPage", GetPVarInt(playerid, "DisplayingPage") + 1);
	        
		LoadObjects(playerid, 0);

        PlayerTextDrawDestroy(playerid, Inv[playerid][16]);
  		new Float:ypos = ((GetPVarInt(playerid,"DisplayingPage")-1)*300)/GetPVarInt(playerid,"DisplayingPages") + 125;
	    Inv[playerid][16] = CreatePlayerTextDraw(playerid, 636.500000, ypos, "_");
		PlayerTextDrawAlignment(playerid, Inv[playerid][16], 2);
		PlayerTextDrawBackgroundColor(playerid, Inv[playerid][16], 255);
		PlayerTextDrawFont(playerid, Inv[playerid][16], 1);
		new Float:barsize = 34.2/float(GetPVarInt(playerid,"DisplayingPages"));
		if(barsize < 0.2)
	    	barsize = 0.2;
		PlayerTextDrawLetterSize(playerid, Inv[playerid][16], 0.509999, barsize);
		PlayerTextDrawColor(playerid, Inv[playerid][16], -1442840321);
		PlayerTextDrawSetOutline(playerid, Inv[playerid][16], 0);
		PlayerTextDrawSetProportional(playerid, Inv[playerid][16], 1);
		PlayerTextDrawSetShadow(playerid, Inv[playerid][16], 1);
		PlayerTextDrawUseBox(playerid, Inv[playerid][16], 1);
		PlayerTextDrawBoxColor(playerid, Inv[playerid][16], -1157627734);
		PlayerTextDrawTextSize(playerid, Inv[playerid][16], 0.000000, 4.000000);
		PlayerTextDrawShow(playerid, Inv[playerid][16]);

	    return 1;
	}
	else if(playertextid == Inv[playerid][9])
	{
		if(GetPVarInt(playerid, "SelectedContainer") == 0 && GetPVarInt(playerid,"SelectedObject") == 0)
		{
	        PlayerTextDrawSetPreviewRot(playerid, Inv[playerid][9], 0, 0, GetPVarFloat(playerid,"RotZ")+45.0, 1.0);
    	    PlayerTextDrawShow(playerid, Inv[playerid][9]);
        	SetPVarFloat(playerid, "RotZ", GetPVarFloat(playerid,"RotZ") + 45.0);
			return 1;
		}
		else
		{
		    if(GetPVarInt(playerid,"SelectedObjectType") == 2)
			    if(GetPVarInt(playerid,"OnHand") == GetPVarInt(playerid,"SelectedObject"))
			        return 1;

            if(GetPVarInt(playerid,"SelectedObjectType") == 7)
			    if(GetPVarInt(playerid,"OnHandAmmoID") == GetPVarInt(playerid,"SelectedObject"))
			        return 1;

            if(GetPVarInt(playerid,"SelectedObjectType") == 6)
			    if(GetPVarInt(playerid,"OnHandMagID") == GetPVarInt(playerid,"SelectedObject"))
			        return 1;
		
			if(GetPVarInt(playerid,"SelectedObjectCapacity") == 0)
			    return 1;
				   
		
		    mysql_format(dbHandle, medquery, sizeof medquery,"UPDATE playerobjects SET PlayerObjectStatus = 1, PlayerName = '%s', Position = 0, WorldX = '0.0', WorldY = '0.0', WorldZ = '0.0' WHERE PID = %d",PlayerName(playerid), GetPVarInt(playerid,"SelectedObject"));
		    mysql_tquery(dbHandle, medquery, "", "");
		    
		    mysql_format(dbHandle, medquery, sizeof medquery,"SELECT MAX(position) FROM playerobjects WHERE PlayerName = '%s' AND PlayerObjectStatus = 1", PlayerName(playerid));
			mysql_tquery(dbHandle, medquery, "UpdateObjectLastPosition", "ii", playerid, GetPVarInt(playerid,"SelectedObject"));

			new found;
            for(new i = 0; i < MAX_GLOBAL_OBJECTS; i ++)
			{
			    if(GlobalObject[i][PlayerID] == 0) continue;
			
			    if(GlobalObject[i][PlayerID] == GetPVarInt(playerid,"SelectedContainer") || GlobalObject[i][PlayerID] == GetPVarInt(playerid,"SelectedObject"))
			    {
			        DestroyDynamicObject(GlobalObject[i][GameObject]);
			        DestroyDynamicArea(GlobalObject[i][AreaID]);
			        GlobalObject[i][PlayerID] = 0;
			    
			        for(new a = 0; a < PLAYERS; a ++)
			        {
			            if(!IsPlayerConnected(a)) continue;
						if(GlobalObject[i][IsNear][a] == 1)
						    GlobalObject[i][IsNear][a] = 0,
						    LoadNearObjects(a, 0);
					}
			        break;
			    }
			}
			if(found == 0)
			{
			    if(GetPVarInt(playerid,"SelectedObjectType") == 6 || GetPVarInt(playerid,"SelectedObjectType") == 7)
			    {
			    	format(query, sizeof(query),"UPDATE playerobjects SET P_SpecialFlag_1 = 0 WHERE P_SpecialFlag_1 = %d",GetPVarInt(playerid,"SelectedObject"));
			    	mysql_tquery(dbHandle, query, "", "");
				}
			
			    RemoveObjectFromObject(playerid, GetPVarInt(playerid,"SelectedObject"), GetPVarInt(playerid,"SelectedObjectIn"));
			}
			else
			{
				LoadObjects(playerid, 0);
				LoadNearObjects(playerid, 0);
			}
			return 1;
		
		}
	}
	
	for(new i = 0; i < 4; i ++)
	{
	    if(playertextid == InventoryObjectsHead[playerid][0][i])
	    {
	        if(GetPVarInt(playerid,"LastClick") > GetTickCount())
	        {
	            SetPVarInt(playerid,"LastClick", GetTickCount()-500);
	            OnPlayerClickPlayerTextDraw(playerid, playertextid);
	            BringActionMenu(playerid, container[playerid][i], i, 2, -1);
	            memoryslot[playerid][0] = i;
	            memoryslot[playerid][1] = 0;
	            SetPVarInt(playerid,"ActionObject", container[playerid][i]);
	            return 1;
	        }
	        if(GetPVarInt(playerid,"ActionObject") != 0)
	            return 1;
	        
	        SetPVarInt(playerid,"LastClick", GetTickCount()+300);
			if(GetPVarInt(playerid, "SelectedObject") == 0)
			{
		        SetPVarInt(playerid,"SelectedObject", container[playerid][i]);
		        SetPVarInt(playerid,"SelectedObjectIn", container[playerid][i]);
		        SetPVarInt(playerid,"SelectedContainer",container[playerid][i]);
		        SetPVarInt(playerid,"SelectedObjectCapacity",objectcap[playerid][i]);
		        SetPVarInt(playerid,"SelectedObjectSize",containersize[playerid][i]);
		        SetPVarInt(playerid,"SelectedObjectDisplay",containerdisplay[playerid][i]);
		        SetPVarInt(playerid,"SelectedObjectType",containertype[playerid][i]);
		        SetPVarInt(playerid,"SelectedObjectInType",containertype[playerid][i]);
		        SetPVarInt(playerid,"SelectedObjectGlobal", 0);

				//RenderMessage(playerid, 0x00FF00FF, "Container selected.");

		        PlayerTextDrawHide(playerid, InventoryObjectsHead[playerid][0][i]);
	            PlayerTextDrawBoxColor(playerid, InventoryObjectsHead[playerid][0][i], 0xFF660044);
	            PlayerTextDrawShow(playerid, InventoryObjectsHead[playerid][0][i]);
			}
			else
			{
			    if(GetPVarInt(playerid,"SelectedObject") == container[playerid][i])
			    {
			        SetPVarInt(playerid,"SelectedObject", 0);
					SetPVarInt(playerid,"SelectedContainer", 0);
			        SetPVarInt(playerid,"SelectedObjectCapacity",0);
			        SetPVarInt(playerid,"SelectedObjectIn", 0);
			        
			        //RenderMessage(playerid, 0x00FF00FF, "Container deselected.");
			        
			        PlayerTextDrawHide(playerid, InventoryObjectsHead[playerid][0][i]);
		            PlayerTextDrawBoxColor(playerid, InventoryObjectsHead[playerid][0][i], 0x00000044);
	          	  	PlayerTextDrawShow(playerid, InventoryObjectsHead[playerid][0][i]);
			    }
			    else
			    {//position swap
					format(medquery, sizeof medquery, "SELECT Position,PID FROM playerobjects WHERE (PID = %d OR PID = %d) AND PlayerObjectStatus = 1",GetPVarInt(playerid,"SelectedContainer"),container[playerid][i]);
					mysql_tquery(dbHandle, medquery, "SwapContainerPosition", "iii", playerid, GetPVarInt(playerid,"SelectedContainer"), container[playerid][i]);
			    }
			}
			return 1;
	    }
	    else if(playertextid == GlobalObjectsHead[playerid][0][i])
	    {
	        if(GetPVarInt(playerid, "SelectedObject") == 0)
			{
		        SetPVarInt(playerid,"SelectedObject", g_container[playerid][i]);
		        SetPVarInt(playerid,"SelectedObjectCapacity", g_objectcap[playerid][i]);
		        SetPVarInt(playerid,"SelectedObjectIn", g_container[playerid][i]);
		        SetPVarInt(playerid,"SelectedContainer",g_container[playerid][i]);
		        SetPVarInt(playerid,"SelectedObjectSize", g_containersize[playerid][i]);
		        SetPVarInt(playerid,"SelectedObjectDisplay", g_containerdisplay[playerid][i]);
		        SetPVarInt(playerid,"SelectedObjectType", g_containertype[playerid][i]);
		        SetPVarInt(playerid,"SelectedObjectInType", g_containertype[playerid][i]);
		        SetPVarInt(playerid,"SelectedObjectGlobal", 1);

				//RenderMessage(playerid, 0x00FF00FF, "Container selected.");

		        PlayerTextDrawHide(playerid, GlobalObjectsHead[playerid][0][i]);
	            PlayerTextDrawBoxColor(playerid, GlobalObjectsHead[playerid][0][i], 0xFF660044);
	            PlayerTextDrawShow(playerid, GlobalObjectsHead[playerid][0][i]);
			}
			else
			{
			    if(GetPVarInt(playerid,"SelectedObject") == g_container[playerid][i])
			    {
			        SetPVarInt(playerid,"SelectedObject", 0);
			        SetPVarInt(playerid,"SelectedObjectCapacity",0);
			        SetPVarInt(playerid,"SelectedObjectIn", 0);
			        SetPVarInt(playerid,"SelectedContainer", 0);

			        //RenderMessage(playerid, 0x00FF00FF, "Container deselected.");

			        PlayerTextDrawHide(playerid, GlobalObjectsHead[playerid][0][i]);
		            PlayerTextDrawBoxColor(playerid, GlobalObjectsHead[playerid][0][i], 0x00000044);
	          	  	PlayerTextDrawShow(playerid, GlobalObjectsHead[playerid][0][i]);
			    }
			}
	        return 1;
	    }
	}
	
	for(new i = 0; i < sizeof(GlobalObjectsSlots[]); i ++)
	{
	    for(new a = 0; a < sizeof(GlobalObjectsSlots[][]); a ++)
	    {
			if(playertextid == GlobalObjectsSlots[playerid][i][a])
			{
			    if(g_slotused[playerid][i][a] == -1 || (g_slotused[playerid][i][a] == GetPVarInt(playerid,"SelectedObject") && g_objectsize[playerid][i][a] == 0))
			    {//empty slot found

			        if(GetPVarInt(playerid,"SelectedObject") != 0)
			        {//move object check
						new capacity = g_objectcap[playerid][a];
						if(i + GetPVarInt(playerid,"SelectedObjectSize") > capacity)
						{
						    RenderMessage(playerid,0xFF6600FF,"The object wont fit in it's new position.");
						    return 1;
						}

						for(new z = i; z < i+GetPVarInt(playerid,"SelectedObjectSize"); z ++)
						{
						    if(g_slotused[playerid][z][a] != -1 && g_slotused[playerid][z][a] != GetPVarInt(playerid,"SelectedObject"))
						    {
						        RenderMessage(playerid,0xFF6600FF,"The object wont fit in it's new position.");
						        return 1;
						    }
						}
						if(GetPVarInt(playerid,"SelectedContainer") == g_container[playerid][a])
						    return RenderMessage(playerid, 0xFF0000FF, "Can't put a container inside itself.");
						
					    mysql_format(dbHandle, medquery, sizeof medquery, "SELECT * FROM objectinventory WHERE OI_ObjectID = %d OR OI_ObjectID = %d", GetPVarInt(playerid,"SelectedObjectIn"),g_slotbelongsto[playerid][a]);
						mysql_tquery(dbHandle, medquery, "MoveObjectToObject","iiiiiiiii", playerid, i, GetPVarInt(playerid,"SelectedObject"), GetPVarInt(playerid,"SelectedObjectType"), GetPVarInt(playerid,"SelectedObjectIn"),
						GetPVarInt(playerid,"SelectedObjectInType"),g_slotbelongsto[playerid][a], g_containertype[playerid][a], playerid);

						return 1;
			        }
					return 1;
				}
				else if(g_slotused[playerid][i][a] == 0)
				{//
				    //format(msg, sizeof(msg),"Slot belongs to: %d",slotbelongsto[playerid][a]);
			        //SendClientMessage(playerid, 0xFFFF00FF, msg);
				    //SendClientMessage(playerid, 0xFF0000FF, "Used!");
					return 1;
				}
				else
				{
				    if(GetPVarInt(playerid,"SelectedObject") == 0)
				    {
				        if(g_objectsize[playerid][i][a] == 0)
				        	return 1;

					    SetPVarInt(playerid,"SelectedObject", g_slotused[playerid][i][a]);
					    SetPVarInt(playerid,"SelectedObjectIn", g_slotbelongsto[playerid][a]);
					    SetPVarInt(playerid,"SelectedContainer",0);
					    SetPVarInt(playerid,"SelectedObjectSize", g_objectsize[playerid][i][a]);
					    SetPVarInt(playerid,"SelectedObjectDisplay", g_objectdisplay[playerid][i][a]);
					    SetPVarInt(playerid,"SelectedObjectType", g_objecttypes[playerid][i][a]);
					    SetPVarInt(playerid,"SelectedObjectPosition", i);
					    SetPVarInt(playerid,"SelectedObjectCapacity", g_objectscap[playerid][i][a]);
					    SetPVarInt(playerid,"SelectedObjectGlobal", 1);
					    //printf("%d",objectcap[playerid][a]-i);

					    PlayerTextDrawHide(playerid, GlobalObjectsSlots[playerid][i][a]);
                        PlayerTextDrawBackgroundColor(playerid, GlobalObjectsSlots[playerid][i][a], 0xFF660066);
                        PlayerTextDrawShow(playerid, GlobalObjectsSlots[playerid][i][a]);

                        for(new z = i; z < i+GetPVarInt(playerid, "SelectedObjectSize"); z ++)
                        {
                            PlayerTextDrawHide(playerid, GlobalObjectsSlots[playerid][z][a]);
	                        PlayerTextDrawBackgroundColor(playerid, GlobalObjectsSlots[playerid][z][a], 0xFF660066);
	                        PlayerTextDrawShow(playerid, GlobalObjectsSlots[playerid][z][a]);
                        }



					    //format(msg, sizeof(msg),"Selected object ID %d",g_slotused[playerid][i][a]);
				        //RenderMessage(playerid, 0xFF0000FF, msg);
				        return 1;
					}
					else
					{
					    if(GetPVarInt(playerid,"SelectedObject") == g_slotused[playerid][i][a])
					    {
					        if(g_objectsize[playerid][i][a] == 0)
				        		return 1;

					        for(new z = i; z < i+GetPVarInt(playerid, "SelectedObjectSize"); z ++)
	                        {
	                            PlayerTextDrawHide(playerid, GlobalObjectsSlots[playerid][z][a]);
		                        PlayerTextDrawBackgroundColor(playerid, GlobalObjectsSlots[playerid][z][a], 0x00000066);
		                        PlayerTextDrawShow(playerid, GlobalObjectsSlots[playerid][z][a]);
	                        }

                            SetPVarInt(playerid,"SelectedObject", 0);
					    	SetPVarInt(playerid,"SelectedObjectIn", 0);
					    	SetPVarInt(playerid,"SelectedObjectSize", 0);
					    	SetPVarInt(playerid,"SelectedContainer", 0);

					    	PlayerTextDrawHide(playerid, GlobalObjectsSlots[playerid][i][a]);
					    	PlayerTextDrawBackgroundColor(playerid, GlobalObjectsSlots[playerid][i][a], 0x00000066);
                        	PlayerTextDrawShow(playerid, GlobalObjectsSlots[playerid][i][a]);

					    	//format(msg, sizeof(msg),"DeSelected object ID %d",g_slotused[playerid][i][a]);
				        	//RenderMessage(playerid, 0xFF0000FF, msg);
				        	return 1;
					    }
					    else
					    {
							if(g_slotbelongsto[playerid][a] != GetPVarInt(playerid,"SelectedObjectIn") && g_objectsize[playerid][i][a] != 0 && GetPVarInt(playerid,"SelectedContainer") == 0)
							{//one object from one to another pack

           						//selected objects fits where the other object is?
							    if(GetPVarInt(playerid,"SelectedObjectSize") > g_objectcap[playerid][a]-i)
							    {
							        RenderMessage(playerid,0xFF6600FF,"The object wont fit in it's new position.");
						    		return 1;
							    }
							    //second object fits where selected object is?
							    if(g_objectsize[playerid][i][a] > GetPVarInt(playerid,"SelectedObjectCapacity")-GetPVarInt(playerid,"SelectedObjectPosition"))
							    {
							        RenderMessage(playerid,0xFF6600FF,"The object wont fit in it's new position.");
						    		return 1;
							    }

								//then move second object
                                mysql_format(dbHandle, medquery, sizeof medquery, "SELECT OI_ObjectID, InsideIDs FROM objectinventory WHERE OI_ObjectID = %d OR OI_ObjectID = %d", GetPVarInt(playerid,"SelectedObjectIn"),g_slotbelongsto[playerid][a]);
								mysql_tquery(dbHandle, medquery, "SwapObjectWithObject","iiiiiiiiiiii", playerid, GetPVarInt(playerid,"SelectedObjectIn"),g_slotbelongsto[playerid][a], GetPVarInt(playerid,"SelectedObject"),
								g_slotused[playerid][i][a], GetPVarInt(playerid,"SelectedObjectType"), g_objecttypes[playerid][i][a], g_containertype[playerid][a], GetPVarInt(playerid,"SelectedObjectInType"),
								GetPVarInt(playerid,"SelectedObjectPosition"), i, -1);
								return 1;
							}
					    }
					}
				    //format(msg, sizeof(msg),"Object ID: %d in place",slotused[playerid][i][a]);
				    //SendClientMessage(playerid, 0xFFFF00FF, msg);
					return 1;
				}
			}
		}
	}
	    
	for(new i = 0; i < sizeof(InventoryObjectsSlots[]); i ++)
	{
	    for(new a = 0; a < sizeof(InventoryObjectsSlots[][]); a ++)
	    {
			if(playertextid == InventoryObjectsSlots[playerid][i][a])
			{
			    if(slotused[playerid][i][a] == -1 || (slotused[playerid][i][a] == GetPVarInt(playerid,"SelectedObject") && objectsize[playerid][i][a] == 0))
			    {//empty slot found
			    
			        if(GetPVarInt(playerid,"SelectedObject") != 0)
			        {//move object check
						new capacity = objectcap[playerid][a];
						if(i + GetPVarInt(playerid,"SelectedObjectSize") > capacity)
						{
						    RenderMessage(playerid,0xFF6600FF,"The object wont fit in it's new position.");
						    return 1;
						}
						
						for(new z = i; z < i+GetPVarInt(playerid,"SelectedObjectSize"); z ++)
						{
						    if(slotused[playerid][z][a] != -1 && slotused[playerid][z][a] != GetPVarInt(playerid,"SelectedObject"))
						    {
						        RenderMessage(playerid,0xFF6600FF,"The object wont fit in it's new position.");
						        return 1;
						    }
						}
						if(GetPVarInt(playerid,"SelectedContainer") == container[playerid][a])
						    return RenderMessage(playerid, 0xFF0000FF, "Can't put a container inside itself.");
						
					    mysql_format(dbHandle, medquery, sizeof medquery, "SELECT * FROM objectinventory WHERE OI_ObjectID = %d OR OI_ObjectID = %d", GetPVarInt(playerid,"SelectedObjectIn"),slotbelongsto[playerid][a]);
						mysql_tquery(dbHandle, medquery, "MoveObjectToObject","iiiiiiiii", playerid, i, GetPVarInt(playerid,"SelectedObject"), GetPVarInt(playerid,"SelectedObjectType"), GetPVarInt(playerid,"SelectedObjectIn"),
						GetPVarInt(playerid,"SelectedObjectInType"), slotbelongsto[playerid][a], containertype[playerid][a], playerid);

						return 1;
			        }
					return 1;
				}
				else if(slotused[playerid][i][a] == 0)
				{//
				    //format(msg, sizeof(msg),"Slot belongs to: %d",slotbelongsto[playerid][a]);
			        //SendClientMessage(playerid, 0xFFFF00FF, msg);
				    //SendClientMessage(playerid, 0xFF0000FF, "Used!");
					return 1;
				}
				else
				{
				    if(GetPVarInt(playerid,"LastClick") > GetTickCount())
			        {
			            if(objectsize[playerid][i][a] == 0)
				        	return 1;
			        
			            memoryslot[playerid][0] = a;
			            memoryslot[playerid][1] = i;
			            BringActionMenu(playerid, slotused[playerid][i][a], a, 1, slotbelongsto[playerid][a]);
			            SetPVarInt(playerid,"LastClick", GetTickCount()-500);
			            OnPlayerClickPlayerTextDraw(playerid, playertextid);
			            SetPVarInt(playerid, "ActionObject", slotused[playerid][i][a]);
			            return 1;
			        }
			        if(GetPVarInt(playerid,"ActionObject") != 0)
	            		return 1;
			        
			        SetPVarInt(playerid,"LastClick", GetTickCount()+300);
				
				    if(GetPVarInt(playerid,"SelectedObject") == 0)
				    {
				        if(objectsize[playerid][i][a] == 0)
				        	return 1;
				    
					    SetPVarInt(playerid,"SelectedObject", slotused[playerid][i][a]);
					    SetPVarInt(playerid,"SelectedObjectIn", slotbelongsto[playerid][a]);
					    SetPVarInt(playerid,"SelectedObjectSize", objectsize[playerid][i][a]);
					    SetPVarInt(playerid,"SelectedObjectDisplay", objectdisplay[playerid][i][a]);
					    SetPVarInt(playerid,"SelectedObjectType", objecttypes[playerid][i][a]);
					    SetPVarInt(playerid,"SelectedObjectInType", containertype[playerid][a]);
					    SetPVarInt(playerid,"SelectedContainer",0);
					    SetPVarInt(playerid,"SelectedObjectPosition", i);
					    SetPVarInt(playerid,"SelectedObjectCapacity",objectscap[playerid][i][a]);
					    SetPVarInt(playerid,"SelectedObjectGlobal", 0);
					    //printf("%d",objectcap[playerid][a]-i);
					    
					    PlayerTextDrawHide(playerid, InventoryObjectsSlots[playerid][i][a]);
                        PlayerTextDrawBackgroundColor(playerid, InventoryObjectsSlots[playerid][i][a], 0xFF660066);
                        PlayerTextDrawShow(playerid, InventoryObjectsSlots[playerid][i][a]);
                        
                        for(new z = i; z < i+GetPVarInt(playerid, "SelectedObjectSize"); z ++)
                        {
                            PlayerTextDrawHide(playerid, InventoryObjectsSlots[playerid][z][a]);
	                        PlayerTextDrawBackgroundColor(playerid, InventoryObjectsSlots[playerid][z][a], 0xFF660066);
	                        PlayerTextDrawShow(playerid, InventoryObjectsSlots[playerid][z][a]);
                        }
                        
                        

					    //format(msg, sizeof(msg),"Selected object ID %d (%d)",slotused[playerid][i][a],objecttypes[playerid][i][a]);
				        //RenderMessage(playerid, 0xFF0000FF, msg);
				        return 1;
					}
					else
					{
					    if(GetPVarInt(playerid,"SelectedObject") == slotused[playerid][i][a])
					    {
					        if(objectsize[playerid][i][a] == 0)
				        		return 1;
					    
					        for(new z = i; z < i+GetPVarInt(playerid, "SelectedObjectSize"); z ++)
	                        {
	                            PlayerTextDrawHide(playerid, InventoryObjectsSlots[playerid][z][a]);
		                        PlayerTextDrawBackgroundColor(playerid, InventoryObjectsSlots[playerid][z][a], 0x00000066);
		                        PlayerTextDrawShow(playerid, InventoryObjectsSlots[playerid][z][a]);
	                        }
					    
                            SetPVarInt(playerid,"SelectedObject", 0);
					    	SetPVarInt(playerid,"SelectedObjectIn", 0);
					    	SetPVarInt(playerid,"SelectedObjectSize", 0);
					    	SetPVarInt(playerid,"SelectedContainer", 0);
					    	
					    	PlayerTextDrawHide(playerid, InventoryObjectsSlots[playerid][i][a]);
					    	PlayerTextDrawBackgroundColor(playerid, InventoryObjectsSlots[playerid][i][a], 0x00000066);
                        	PlayerTextDrawShow(playerid, InventoryObjectsSlots[playerid][i][a]);
					    	
					    	//format(msg, sizeof(msg),"DeSelected object ID %d",slotused[playerid][i][a]);
				        	//RenderMessage(playerid, 0xFF0000FF, msg);
				        	return 1;
					    }
					    else
					    {
							if(slotbelongsto[playerid][a] != GetPVarInt(playerid,"SelectedObjectIn") && objectsize[playerid][i][a] != 0 && GetPVarInt(playerid,"SelectedContainer") == 0)
							{//one object from one to another pack
                                mysql_format(dbHandle, medquery, sizeof medquery, "SELECT OI_ObjectID, InsideIDs FROM objectinventory WHERE OI_ObjectID = %d OR OI_ObjectID = %d", GetPVarInt(playerid,"SelectedObjectIn"),slotbelongsto[playerid][a]);
								mysql_tquery(dbHandle, medquery, "SwapObjectWithObject","iiiiiiiiiiii", playerid, GetPVarInt(playerid,"SelectedObjectIn"),slotbelongsto[playerid][a], GetPVarInt(playerid,"SelectedObject"),
								slotused[playerid][i][a], GetPVarInt(playerid,"SelectedObjectType"), objecttypes[playerid][i][a], containertype[playerid][a], GetPVarInt(playerid,"SelectedObjectInType"),
								GetPVarInt(playerid,"SelectedObjectPosition"), i, a);
								return 1;
							}
							else if(GetPVarInt(playerid,"SelectedObjectIn") == slotbelongsto[playerid][a] && objectsize[playerid][i][a] != 0 && GetPVarInt(playerid,"SelectedContainer") == 0)
							{
                                InternalSwapObject(playerid, GetPVarInt(playerid,"SelectedObjectIn"), GetPVarInt(playerid,"SelectedObject"), slotused[playerid][i][a],
								GetPVarInt(playerid,"SelectedObjectType"), objecttypes[playerid][i][a], containertype[playerid][a], GetPVarInt(playerid,"SelectedObjectInType"),
								GetPVarInt(playerid,"SelectedObjectPosition"), i, a);
								return 1;
							}
					    }
					}
				    //format(msg, sizeof(msg),"Object ID: %d in place",slotused[playerid][i][a]);
				    //SendClientMessage(playerid, 0xFFFF00FF, msg);
					return 1;
				}
			}
		}
	}
	
	if(playertextid == Inv[playerid][11])
	{
		if(GetPVarInt(playerid,"SelectedObject") != 0 && GetPVarInt(playerid,"SelectedObjectGlobal") == 0)
		{
			if(GetPVarInt(playerid,"OnHand") != 0)
			    return 1;
			    
		    CallLocalFunction("OnPlayerPutObjectInHand", "iii", playerid, GetPVarInt(playerid,"SelectedObject"), GetPVarInt(playerid,"SelectedObjectType"));
		}
	
	    return 1;
	}
	else if(playertextid == Inv[playerid][17])
	{
	    if(GetPVarInt(playerid,"SelectedObject") != 0)
	    {
			new source = GetPVarInt(playerid,"SelectedObjectIn");
			if(GetPVarInt(playerid,"SelectedContainer") != 0)
			    source = -1;

			if(GetPVarInt(playerid,"SelectedObjectType") == 2)
			    if(GetPVarInt(playerid,"OnHand") == GetPVarInt(playerid,"SelectedObject"))
			        return RenderMessage(playerid, 0xFF6600FF, "You can't drop your weapon while you have it on your hands.");
			        
            if(GetPVarInt(playerid,"SelectedObjectType") == 7)
			    if(GetPVarInt(playerid,"OnHandAmmoID") == GetPVarInt(playerid,"SelectedObject"))
			        return RenderMessage(playerid, 0xFF6600FF, "You can't drop bulets while you have them attached on your current weapon magazine.");

            if(GetPVarInt(playerid,"SelectedObjectType") == 6)
			    if(GetPVarInt(playerid,"OnHandMagID") == GetPVarInt(playerid,"SelectedObject"))
			        return RenderMessage(playerid, 0xFF6600FF, "You can't drop a magazine while you have it attached on your current weapon.");

	        mysql_format(dbHandle, medquery, sizeof medquery, "SELECT * FROM objectinventory WHERE OI_ObjectID = %d", GetPVarInt(playerid,"SelectedObjectIn"));
			mysql_tquery(dbHandle, medquery, "DropObject","iiii", playerid, GetPVarInt(playerid,"SelectedObject"), GetPVarInt(playerid,"SelectedObjectType"), source);

			RenderMessage(playerid, 0x00FF00FF,"Object dropped successfully");
		}
	    return 1;
	}
	else if(playertextid == Inv[playerid][1])
	{
	    RenderMessage(playerid, 0x00FF00FF, "Clicked on the inventory!");
	    return 1;
	}
    //SendClientMessage(playerid, 0xFF0000FF, "Clicked!");
	return 0;
}


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_CTRL_BACK))
	{
		if(GetPVarInt(playerid, "DisplayingPage") == 0)
	    	return cmd_inventory(playerid, "");
		else
		{
		    CancelSelectTextDraw(playerid);
	    	return OnPlayerClickPlayerTextDraw(playerid, Inv[playerid][14]);
		}
	}
	return 1;
}

public OnPlayerEnterDynamicArea(playerid, areaid)
{
	for(new i = 0; i < MAX_GLOBAL_OBJECTS; i ++)
	{
	    if(GlobalObject[i][PlayerID] == 0) continue;
	
	    if(areaid == GlobalObject[i][AreaID])
	    {
	        GlobalObject[i][IsNear][playerid] = 1;
	    }
	}
	return 1;
}

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
	for(new i = 0; i < MAX_GLOBAL_OBJECTS; i ++)
	{
	    if(GlobalObject[i][PlayerID] == 0) continue;

	    if(areaid == GlobalObject[i][AreaID])
	    {
	        GlobalObject[i][IsNear][playerid] = 0;
	    }
	}
	return 1;
}

forward OnPlayerRequestNearObjects(playerid,first);
public OnPlayerRequestNearObjects(playerid,first)
{
	new objects = cache_get_row_count();
	new mindisplay = GetPVarInt(playerid, "MinDisplay_Near");
	new Float:x = 8.5;
	new resti;
	
    new tempslots = -1, lines[50] = {-1, ...}, finaldisplay=-1, totallines, totalpages;
   	if(objects == 1) //display that only object
   	{
	   	finaldisplay = 0;
	   	for(new i = 0; i < objects; i ++)
	    {
	        tempslots = cache_get_field_content_int(i, "Carry");
			lines[i] = floatround(float(tempslots) / 6, floatround_ceil);
	    }
	}
	else
	{
	    for(new i = 0; i < objects; i ++)
	    {
	        tempslots = cache_get_field_content_int(i, "Carry");
			lines[i] = floatround(float(tempslots) / 6, floatround_ceil);
	    }
		for(new i = 0; i < sizeof(lines); i ++)
		{
		    if(lines[i] == -1)
		        continue;

		    totallines += lines[i];
		}
		finaldisplay = mindisplay+3;

		new attempts = 0;
		while(totallines > 9)
		{
		    attempts ++;

			if(attempts == 1)
				totallines = lines[0+mindisplay]+1 + lines[1+mindisplay]+1 + lines[2+mindisplay]+1,
				finaldisplay = mindisplay+2;
			else if(attempts == 2)
			    totallines = lines[0+mindisplay]+1 + lines[1+mindisplay]+1,
			    finaldisplay = mindisplay+1;
			else if(attempts == 3)
			    totallines = lines[0+mindisplay]+1,
			    finaldisplay = mindisplay;
		}

	}
	if(first == 1)
	{
 		totalpages = objects;
		SetPVarInt(playerid, "DisplayingPages_Near", floatround(float(totalpages)/2.0,floatround_ceil));
		new Float:barsize = 34.2/float(totalpages);
		if(barsize < 0.2)
	    	barsize = 0.2;
		PlayerTextDrawLetterSize(playerid, Inv[playerid][22], 0.509999, barsize);
		PlayerTextDrawShow(playerid, Inv[playerid][22]);
	}

	if(finaldisplay > objects)
	    finaldisplay = objects-1;

 	DestroyNearInventoryObjects(playerid);


	new Float:headery = 159.0, name[64];
	for(new i = 0; i <= finaldisplay ; i ++)
	{
	    if(lines[i+mindisplay] == -1)
	        break;

	    if(i != 0)
	    {
	        //headery = 159.0 + 45.0 * i + 39 * lines[i-1] * i;
		    x = 8.5;
		    resti = 0;
	    }

	    GlobalObjectsHead[playerid][0][i] = CreatePlayerTextDraw(playerid, 95.000000, headery-39.0, "_"); //object header box
		PlayerTextDrawAlignment(playerid, GlobalObjectsHead[playerid][0][i], 2);
		PlayerTextDrawBackgroundColor(playerid, GlobalObjectsHead[playerid][0][i], 255);
		PlayerTextDrawFont(playerid, GlobalObjectsHead[playerid][0][i], 1);
		PlayerTextDrawLetterSize(playerid, GlobalObjectsHead[playerid][0][i], 0.300000, 4.000000);
		PlayerTextDrawColor(playerid, GlobalObjectsHead[playerid][0][i], 0);
		PlayerTextDrawSetOutline(playerid, GlobalObjectsHead[playerid][0][i], 0);
		PlayerTextDrawSetProportional(playerid, GlobalObjectsHead[playerid][0][i], 1);
		PlayerTextDrawSetShadow(playerid, GlobalObjectsHead[playerid][0][i], 0);
		PlayerTextDrawUseBox(playerid, GlobalObjectsHead[playerid][0][i], 1);
	  	if(GetPVarInt(playerid,"SelectedObject") == cache_get_field_content_int(i+mindisplay, "PID"))
			PlayerTextDrawBoxColor(playerid, GlobalObjectsHead[playerid][0][i], 0xFF660044);
		else
		    PlayerTextDrawBoxColor(playerid, GlobalObjectsHead[playerid][0][i], 0x00000044);
		PlayerTextDrawTextSize(playerid, GlobalObjectsHead[playerid][0][i], 50.000000, 216.000000);
		PlayerTextDrawSetSelectable(playerid, GlobalObjectsHead[playerid][0][i], 1);
		PlayerTextDrawShow(playerid, GlobalObjectsHead[playerid][0][i]);

		GlobalObjectsHead[playerid][1][i] = CreatePlayerTextDraw(playerid, 95.000000, headery, "Object_Body");
		PlayerTextDrawAlignment(playerid, GlobalObjectsHead[playerid][1][i], 2);
		PlayerTextDrawBackgroundColor(playerid, GlobalObjectsHead[playerid][1][i], 255);
		PlayerTextDrawFont(playerid, GlobalObjectsHead[playerid][1][i], 1);
		PlayerTextDrawLetterSize(playerid, GlobalObjectsHead[playerid][1][i], 0.300000, 4.1 * lines[i+mindisplay]);
		PlayerTextDrawColor(playerid, GlobalObjectsHead[playerid][1][i], 0);
		PlayerTextDrawSetOutline(playerid, GlobalObjectsHead[playerid][1][i], 0);
		PlayerTextDrawSetProportional(playerid, GlobalObjectsHead[playerid][1][i], 1);
		PlayerTextDrawSetShadow(playerid, GlobalObjectsHead[playerid][1][i], 0);
		PlayerTextDrawUseBox(playerid, GlobalObjectsHead[playerid][1][i], 1);
		PlayerTextDrawBoxColor(playerid, GlobalObjectsHead[playerid][1][i], 0x00000044);
		PlayerTextDrawTextSize(playerid, GlobalObjectsHead[playerid][1][i], 0.000000, 216.000000);
		PlayerTextDrawShow(playerid, GlobalObjectsHead[playerid][1][i]);


		GlobalObjectsHead[playerid][2][i] = CreatePlayerTextDraw(playerid, 2.0000000, headery-35.0, "666");
		PlayerTextDrawBackgroundColor(playerid, GlobalObjectsHead[playerid][2][i], 0);
		PlayerTextDrawFont(playerid, GlobalObjectsHead[playerid][2][i], 5);
		PlayerTextDrawLetterSize(playerid, GlobalObjectsHead[playerid][2][i], 0.500000, 1.000000);
		PlayerTextDrawSetOutline(playerid, GlobalObjectsHead[playerid][2][i], 0);
		PlayerTextDrawSetProportional(playerid, GlobalObjectsHead[playerid][2][i], 1);
		PlayerTextDrawColor(playerid, GlobalObjectsHead[playerid][2][i], cache_get_field_content_int(i+mindisplay, "DisplayColor"));
		PlayerTextDrawSetPreviewModel(playerid, GlobalObjectsHead[playerid][2][i], cache_get_field_content_int(i+mindisplay, "Display"));
		PlayerTextDrawSetPreviewRot(playerid, GlobalObjectsHead[playerid][2][i], cache_get_field_content_float(i+mindisplay, "DisplayXOffset"),
		cache_get_field_content_float(i+mindisplay, "DisplayYOffset"),cache_get_field_content_float(i+mindisplay, "DisplayZOffset"),
		cache_get_field_content_float(i+mindisplay, "DisplayZoom"));
		PlayerTextDrawSetShadow(playerid, GlobalObjectsHead[playerid][2][i], 1);
		PlayerTextDrawUseBox(playerid, GlobalObjectsHead[playerid][2][i], 1);
		PlayerTextDrawBoxColor(playerid, GlobalObjectsHead[playerid][2][i], 255);
		PlayerTextDrawTextSize(playerid, GlobalObjectsHead[playerid][2][i], 30.000000, 30.000000);
		PlayerTextDrawShow(playerid, GlobalObjectsHead[playerid][2][i]);

		cache_get_field_content(i+mindisplay, "Name", name);
		GlobalObjectsHead[playerid][3][i] = CreatePlayerTextDraw(playerid, 30.000000, headery-33.0, name);
		PlayerTextDrawAlignment(playerid, GlobalObjectsHead[playerid][3][i], 1);
		PlayerTextDrawBackgroundColor(playerid, GlobalObjectsHead[playerid][3][i], 255);
		PlayerTextDrawFont(playerid, GlobalObjectsHead[playerid][3][i], 2);
		PlayerTextDrawLetterSize(playerid, GlobalObjectsHead[playerid][3][i], 0.400000, 2.400000);
		PlayerTextDrawColor(playerid, GlobalObjectsHead[playerid][3][i], -1);
		PlayerTextDrawSetOutline(playerid, GlobalObjectsHead[playerid][3][i], 1);
		PlayerTextDrawSetProportional(playerid, GlobalObjectsHead[playerid][3][i], 1);
		PlayerTextDrawShow(playerid, GlobalObjectsHead[playerid][3][i]);
		g_container[playerid][i] = cache_get_field_content_int(i+mindisplay, "PID");
		g_containerdisplay[playerid][i] = cache_get_field_content_int(i+mindisplay, "Display");
		g_containertype[playerid][i] = cache_get_field_content_int(i+mindisplay, "TypeID");

		new objectslots = cache_get_field_content_int(i+mindisplay, "Carry");
		g_objectcap[playerid][i] = objectslots;
		g_containersize[playerid][i] = cache_get_field_content_int(i+mindisplay, "H_Size");
		//printf("Objectslots (%d) = %d", i, objectslots);
		for(new a = 0; a < objectslots; a ++)
		{
		    GlobalObjectsSlots[playerid][a][i] = CreatePlayerTextDraw(playerid, x+31*(a-resti), headery+0.4, "object_slot");
			PlayerTextDrawAlignment(playerid, GlobalObjectsSlots[playerid][a][i], 2);
			PlayerTextDrawBackgroundColor(playerid, GlobalObjectsSlots[playerid][a][i], -1145324664);
			PlayerTextDrawFont(playerid, GlobalObjectsSlots[playerid][a][i], 5);
			PlayerTextDrawLetterSize(playerid, GlobalObjectsSlots[playerid][a][i], 1.100000, 1.000001);
			PlayerTextDrawColor(playerid, GlobalObjectsSlots[playerid][a][i], -1);
			PlayerTextDrawSetOutline(playerid, GlobalObjectsSlots[playerid][a][i], 0);
			PlayerTextDrawSetProportional(playerid, GlobalObjectsSlots[playerid][a][i], 1);
			PlayerTextDrawSetPreviewModel(playerid, GlobalObjectsSlots[playerid][a][i], 19300);
			PlayerTextDrawSetShadow(playerid, GlobalObjectsSlots[playerid][a][i], 1);
			PlayerTextDrawUseBox(playerid, GlobalObjectsSlots[playerid][a][i], 1);
			PlayerTextDrawBoxColor(playerid, GlobalObjectsSlots[playerid][a][i], -1145324647);
			PlayerTextDrawSetSelectable(playerid, GlobalObjectsSlots[playerid][a][i], 1);
			PlayerTextDrawTextSize(playerid, GlobalObjectsSlots[playerid][a][i], 30.000000, 36.000000);
			PlayerTextDrawShow(playerid, GlobalObjectsSlots[playerid][a][i]);
            g_slotused[playerid][a][i] = -1;

			if((a+1) % 6 == 0)
			{
				headery += 37;
				x = 8.5;
				resti = a+1;
			}
		}

		g_slotbelongsto[playerid][i] = cache_get_field_content_int(i+mindisplay, "PID");
		g_slots[playerid][i] = objectslots;

		mysql_format(dbHandle, query, sizeof(query),"SELECT * FROM objectinventory WHERE OI_ObjectID = %d", cache_get_field_content_int(i+mindisplay, "PID"));
		mysql_tquery(dbHandle, query, "LoadGlobalObjectInventory", "iii", playerid, cache_get_field_content_int(i+mindisplay, "PID"), i);

  		if(lines[i+mindisplay] == 1)
			headery = headery + 45.0 + 39;
		else
		    headery = headery + 45.0 + 2;
	}
	return 1;
}


forward LoadGlobalObjectInventory(playerid, ObjectID, memslot);
public LoadGlobalObjectInventory(playerid, ObjectID, memslot)
{
	new objectstr[140], tempobjects[35];
	cache_get_field_content(0, "InsideIDs", objectstr);
	sscanf(objectstr, "p<,>a<i>[35]", tempobjects);


	for(new i = 0; i < sizeof(tempobjects); i ++)
	{
	    for(new a = 0; a < sizeof tempobjects; a ++)
			if(tempobjects[i] == tempobjects[a] && a != i)
				tempobjects[i] = 0;

	    g_objectsstored[playerid][i][memslot] = tempobjects[i];
	}

	for(new i = 0; i < sizeof(g_objectsstored[]); i ++)
	{
	    if(g_objectsstored[playerid][i][memslot] == 0)
			continue;

		mysql_format(dbHandle, query, sizeof(query),"SELECT * FROM objects \
		JOIN playerobjects ON objects.ID = playerobjects.O_ObjectID \
		WHERE playerobjects.PID = %d LIMIT 0,1", g_objectsstored[playerid][i][memslot]);
		mysql_tquery(dbHandle, query, "OnGlobalObjectDataLoaded", "iii", playerid, ObjectID, memslot);
	}
	return 1;
}

forward OnGlobalObjectDataLoaded(playerid, ObjectID, memslot);
public OnGlobalObjectDataLoaded(playerid, ObjectID, memslot)
{
	new position = cache_get_field_content_int(0, "Position");
	new display = cache_get_field_content_int(0, "Display");
	new trueid = cache_get_field_content_int(0, "PID");

	g_objectdisplay[playerid][position][memslot] = display;
	g_objectscap[playerid][position][memslot] = cache_get_field_content_int(0, "Carry");
	g_objecttypes[playerid][position][memslot] = cache_get_field_content_int(0, "TypeID");

	PlayerTextDrawHide(playerid, GlobalObjectsSlots[playerid][position][memslot]);
	PlayerTextDrawSetPreviewModel(playerid, GlobalObjectsSlots[playerid][position][memslot], display);
	
	
	PlayerTextDrawSetPreviewRot(playerid, GlobalObjectsSlots[playerid][position][memslot], cache_get_field_content_float(0, "DisplayXOffset"), cache_get_field_content_float(0, "DisplayYOffset"),
 	cache_get_field_content_float(0, "DisplayZOffset"), cache_get_field_content_float(0, "DisplayZoom"));
	PlayerTextDrawColor(playerid, GlobalObjectsSlots[playerid][position][memslot], cache_get_field_content_int(0, "DisplayColor"));
	
	if(GetPVarInt(playerid,"SelectedObject") == trueid)
		PlayerTextDrawBackgroundColor(playerid, GlobalObjectsSlots[playerid][position][memslot], 0xFF660066);
	else
	    PlayerTextDrawBackgroundColor(playerid, GlobalObjectsSlots[playerid][position][memslot], 0x00000066);
	PlayerTextDrawShow(playerid, GlobalObjectsSlots[playerid][position][memslot]);
	g_slotused[playerid][position][memslot] = trueid;


	new HorizontalSize = cache_get_field_content_int(0, "H_Size");
	g_objectsize[playerid][position][memslot] = HorizontalSize;

    if(HorizontalSize >= 1)
    {
        for(new i = 1; i < HorizontalSize; i ++)
        {
            if(GetPVarInt(playerid,"SelectedObject") == trueid)
	            PlayerTextDrawBackgroundColor(playerid, GlobalObjectsSlots[playerid][position+i][memslot], 0xFF660066);
			else
			    PlayerTextDrawBackgroundColor(playerid, GlobalObjectsSlots[playerid][position+i][memslot], 0x00000066);
			    
			PlayerTextDrawColor(playerid, GlobalObjectsSlots[playerid][position+i][memslot], cache_get_field_content_int(0, "DisplayColor"));
   	 		PlayerTextDrawShow(playerid, GlobalObjectsSlots[playerid][position+i][memslot]);

   	 		g_slotused[playerid][position+i][memslot] = trueid;
        }

    }


	return 1;
}

forward SwapContainerPosition(playerid, container1, container2);
public SwapContainerPosition(playerid, container1, container2)
{
    new rows, fields;
	cache_get_data(rows, fields);
	if(rows != 2)
	    return 1;

	new container1row, container2row;
	for(new i = 0; i < rows; i ++)
	{
	    if(cache_get_field_content_int(i, "PID") == container1) container1row = i;
	    if(cache_get_field_content_int(i, "PID") == container2) container2row = i;
	}
	
	new pos1 = cache_get_field_content_int(container1row, "Position");
	new pos2 = cache_get_field_content_int(container2row, "Position");
	
	format(query, sizeof query, "UPDATE playerobjects SET Position = %d WHERE PID = %d", pos1, container2);
	mysql_tquery(dbHandle, query, "", "");
    format(query, sizeof query, "UPDATE playerobjects SET Position = %d WHERE PID = %d", pos2, container1);
	mysql_tquery(dbHandle, query, "", "");

	if(playerid != -1)
	{
	    LoadObjects(playerid, 0);
	}

	return 1;
}


forward OnPlayerRequestObjects(playerid,first);
public OnPlayerRequestObjects(playerid,first)
{
	new objects = cache_get_row_count();
	//printf("Objects: %d", objects);
	new mindisplay = GetPVarInt(playerid, "MinDisplay");
	new Float:x = 415.0;
	new resti;

    new tempslots = -1, lines[50] = {-1, ...}, finaldisplay=-1, totallines, totalpages;
   	if(objects == 1) //display that only object
   	{
	   	finaldisplay = 0;
	   	for(new i = 0; i < objects; i ++)
	    {
	        tempslots = cache_get_field_content_int(i, "Carry");
			lines[i] = floatround(float(tempslots) / 7, floatround_ceil);
	    }
	}
	else
	{
	    for(new i = 0; i < objects; i ++)
	    {
	        tempslots = cache_get_field_content_int(i, "Carry");
			lines[i] = floatround(float(tempslots) / 7, floatround_ceil);
	    }
		for(new i = 0; i < sizeof(lines); i ++)
		{
		    if(lines[i] == -1)
		        continue;
		
		    totallines += lines[i];
		}
		finaldisplay = mindisplay+3;

		new attempts = 0;
		while(totallines > 9)
		{
		    attempts ++;

			if(attempts == 1)
				totallines = lines[0+mindisplay]+1 + lines[1+mindisplay]+1 + lines[2+mindisplay]+1,
				finaldisplay = mindisplay+2;
			else if(attempts == 2)
			    totallines = lines[0+mindisplay]+1 + lines[1+mindisplay]+1,
			    finaldisplay = mindisplay+1;
			else if(attempts == 3)
			    totallines = lines[0+mindisplay]+1,
			    finaldisplay = mindisplay;
		}

	}
	if(first == 1)
	{
		totalpages = objects;
		SetPVarInt(playerid, "DisplayingPages", floatround(float(totalpages)/2.0,floatround_ceil));
		new Float:barsize = 34.2/float(totalpages);
		if(barsize < 0.2)
	    	barsize = 0.2;
		PlayerTextDrawLetterSize(playerid, Inv[playerid][16], 0.509999, barsize);
		PlayerTextDrawShow(playerid, Inv[playerid][16]);
	}

	if(finaldisplay > objects)
	    finaldisplay = objects-1;

 	DestroyInventoryObjects(playerid);


	new Float:headery = 159.0, name[64];
	for(new i = 0; i <= finaldisplay ; i ++)
	{
	    if(lines[i+mindisplay] == -1)
	        break;
		if(i > 3)
		    break;
	
	    if(i != 0)
	    {
	        //headery = 159.0 + 45.0 * i + 39 * lines[i-1] * i;
		    x = 415.0;
		    resti = 0;
	    }
	    headerystored[playerid][i] = headery;
	    
	    InventoryObjectsHead[playerid][0][i] = CreatePlayerTextDraw(playerid, 523.000000, headery-39.0, "_"); //object header box
		PlayerTextDrawAlignment(playerid, InventoryObjectsHead[playerid][0][i], 2);
		PlayerTextDrawBackgroundColor(playerid, InventoryObjectsHead[playerid][0][i], 255);
		PlayerTextDrawFont(playerid, InventoryObjectsHead[playerid][0][i], 1);
		PlayerTextDrawLetterSize(playerid, InventoryObjectsHead[playerid][0][i], 0.300000, 4.000000);
		PlayerTextDrawColor(playerid, InventoryObjectsHead[playerid][0][i], 0);
		PlayerTextDrawSetOutline(playerid, InventoryObjectsHead[playerid][0][i], 0);
		PlayerTextDrawSetProportional(playerid, InventoryObjectsHead[playerid][0][i], 1);
		PlayerTextDrawSetShadow(playerid, InventoryObjectsHead[playerid][0][i], 0);
		PlayerTextDrawUseBox(playerid, InventoryObjectsHead[playerid][0][i], 1);
		if(GetPVarInt(playerid,"SelectedObject") == cache_get_field_content_int(i+mindisplay, "PID"))
			PlayerTextDrawBoxColor(playerid, InventoryObjectsHead[playerid][0][i], 0xFF660044);
		else
		    PlayerTextDrawBoxColor(playerid, InventoryObjectsHead[playerid][0][i], 0x00000044);
		PlayerTextDrawTextSize(playerid, InventoryObjectsHead[playerid][0][i], 50.000000, 216.000000);
		PlayerTextDrawSetSelectable(playerid, InventoryObjectsHead[playerid][0][i], 1);
		PlayerTextDrawShow(playerid, InventoryObjectsHead[playerid][0][i]);

		InventoryObjectsHead[playerid][1][i] = CreatePlayerTextDraw(playerid, 523.000000, headery, "Object_Body");
		PlayerTextDrawAlignment(playerid, InventoryObjectsHead[playerid][1][i], 2);
		PlayerTextDrawBackgroundColor(playerid, InventoryObjectsHead[playerid][1][i], 255);
		PlayerTextDrawFont(playerid, InventoryObjectsHead[playerid][1][i], 1);
		PlayerTextDrawLetterSize(playerid, InventoryObjectsHead[playerid][1][i], 0.300000, 4.1 * lines[i+mindisplay]);
		PlayerTextDrawColor(playerid, InventoryObjectsHead[playerid][1][i], 0);
		PlayerTextDrawSetOutline(playerid, InventoryObjectsHead[playerid][1][i], 0);
		PlayerTextDrawSetProportional(playerid, InventoryObjectsHead[playerid][1][i], 1);
		PlayerTextDrawSetShadow(playerid, InventoryObjectsHead[playerid][1][i], 0);
		PlayerTextDrawUseBox(playerid, InventoryObjectsHead[playerid][1][i], 1);
		PlayerTextDrawBoxColor(playerid, InventoryObjectsHead[playerid][1][i], 0x00000044);
		PlayerTextDrawTextSize(playerid, InventoryObjectsHead[playerid][1][i], 0.000000, 216.000000);
		PlayerTextDrawShow(playerid, InventoryObjectsHead[playerid][1][i]);

		InventoryObjectsHead[playerid][2][i] = CreatePlayerTextDraw(playerid, 412.000000, headery-35.0, "666");
		PlayerTextDrawBackgroundColor(playerid, InventoryObjectsHead[playerid][2][i], 0);
		PlayerTextDrawFont(playerid, InventoryObjectsHead[playerid][2][i], 5);
		PlayerTextDrawLetterSize(playerid, InventoryObjectsHead[playerid][2][i], 0.500000, 1.000000);
		PlayerTextDrawColor(playerid, InventoryObjectsHead[playerid][2][i], cache_get_field_content_int(i+mindisplay, "DisplayColor"));
		PlayerTextDrawSetOutline(playerid, InventoryObjectsHead[playerid][2][i], 0);
		PlayerTextDrawSetProportional(playerid, InventoryObjectsHead[playerid][2][i], 1);
		PlayerTextDrawSetPreviewModel(playerid, InventoryObjectsHead[playerid][2][i], cache_get_field_content_int(i+mindisplay, "Display"));
		PlayerTextDrawSetPreviewRot(playerid, InventoryObjectsHead[playerid][2][i], cache_get_field_content_float(i+mindisplay, "DisplayXOffset"),
		cache_get_field_content_float(i+mindisplay, "DisplayYOffset"),cache_get_field_content_float(i+mindisplay, "DisplayZOffset"),
		cache_get_field_content_float(i+mindisplay, "DisplayZoom"));
		PlayerTextDrawSetShadow(playerid, InventoryObjectsHead[playerid][2][i], 1);
		PlayerTextDrawUseBox(playerid, InventoryObjectsHead[playerid][2][i], 1);
		PlayerTextDrawBoxColor(playerid, InventoryObjectsHead[playerid][2][i], 255);
		PlayerTextDrawTextSize(playerid, InventoryObjectsHead[playerid][2][i], 30.000000, 30.000000);
		PlayerTextDrawShow(playerid, InventoryObjectsHead[playerid][2][i]);

		cache_get_field_content(i+mindisplay, "Name", name);
		InventoryObjectsHead[playerid][3][i] = CreatePlayerTextDraw(playerid, 450.000000, headery-33.0, name);
		PlayerTextDrawAlignment(playerid, InventoryObjectsHead[playerid][3][i], 1);
		PlayerTextDrawBackgroundColor(playerid, InventoryObjectsHead[playerid][3][i], 255);
		PlayerTextDrawFont(playerid, InventoryObjectsHead[playerid][3][i], 2);
		PlayerTextDrawLetterSize(playerid, InventoryObjectsHead[playerid][3][i], 0.400000, 2.400000);
		PlayerTextDrawColor(playerid, InventoryObjectsHead[playerid][3][i], -1);
		PlayerTextDrawSetOutline(playerid, InventoryObjectsHead[playerid][3][i], 1);
		PlayerTextDrawSetProportional(playerid, InventoryObjectsHead[playerid][3][i], 1);
		PlayerTextDrawShow(playerid, InventoryObjectsHead[playerid][3][i]);
		container[playerid][i] = cache_get_field_content_int(i+mindisplay, "PID");
		containerdisplay[playerid][i] = cache_get_field_content_int(i+mindisplay, "Display");
		containertype[playerid][i] = cache_get_field_content_int(i+mindisplay, "TypeID");
		containersize[playerid][i] = cache_get_field_content_int(i+mindisplay, "H_Size");

		new objectslots = cache_get_field_content_int(i+mindisplay, "Carry");
		objectcap[playerid][i] = objectslots;
		//printf("Objectslots (%d) = %d", i, objectslots);
		for(new a = 0; a < objectslots; a ++)
		{
		    InventoryObjectsSlots[playerid][a][i] = CreatePlayerTextDraw(playerid, x+31*(a-resti), headery+0.4, "object_slot");
			PlayerTextDrawAlignment(playerid, InventoryObjectsSlots[playerid][a][i], 2);
			PlayerTextDrawBackgroundColor(playerid, InventoryObjectsSlots[playerid][a][i], -1145324664);
			PlayerTextDrawFont(playerid, InventoryObjectsSlots[playerid][a][i], 5);
			PlayerTextDrawLetterSize(playerid, InventoryObjectsSlots[playerid][a][i], 1.100000, 1.000001);
			PlayerTextDrawColor(playerid, InventoryObjectsSlots[playerid][a][i], -1);
			PlayerTextDrawSetOutline(playerid, InventoryObjectsSlots[playerid][a][i], 0);
			PlayerTextDrawSetProportional(playerid, InventoryObjectsSlots[playerid][a][i], 1);
			PlayerTextDrawSetPreviewModel(playerid, InventoryObjectsSlots[playerid][a][i], 19300);
			PlayerTextDrawSetShadow(playerid, InventoryObjectsSlots[playerid][a][i], 1);
			PlayerTextDrawUseBox(playerid, InventoryObjectsSlots[playerid][a][i], 1);
			PlayerTextDrawBoxColor(playerid, InventoryObjectsSlots[playerid][a][i], -1145324647);
			PlayerTextDrawSetSelectable(playerid, InventoryObjectsSlots[playerid][a][i], 1);
			PlayerTextDrawTextSize(playerid, InventoryObjectsSlots[playerid][a][i], 30.000000, 36.000000);
			PlayerTextDrawShow(playerid, InventoryObjectsSlots[playerid][a][i]);
            slotused[playerid][a][i] = -1;

			if((a+1) % 7 == 0)
			{
				headery += 37;
				x = 415.0;
				resti = a+1;
			}
		}
		slotbelongsto[playerid][i] = cache_get_field_content_int(i+mindisplay, "PID");
		slots[playerid][i] = objectslots;
		
		//printf("%d+%d : %d", i, mindisplay, cache_get_field_content_int(i+mindisplay, "ID"));
		/*mysql_format(dbHandle, query, sizeof(query),"SELECT * FROM objectinventory \
		JOIN objects ON objectinventory.OI_ObjectID  = objects.ID \
		JOIN playerobjects ON objects.ID = playerobjects.O_ObjectID \
		WHERE objectinventory.OI_ObjectID = %d LIMIT 0,1", cache_get_field_content_int(i+mindisplay, "ID"));*/
		
		mysql_format(dbHandle, query, sizeof(query),"SELECT * FROM objectinventory WHERE OI_ObjectID = %d", cache_get_field_content_int(i+mindisplay, "PID"));
		mysql_tquery(dbHandle, query, "LoadObjectInventory", "iii", playerid, cache_get_field_content_int(i+mindisplay, "PID"), i);
		
		if(lines[i+mindisplay] > 0)
			headery = headery + 45.0 + 39;
		else
		    headery = headery + 45.0 + 2;
	}
	return 1;
}


forward LoadObjectInventory(playerid, ObjectID, memslot);
public LoadObjectInventory(playerid, ObjectID, memslot)
{
	new objectstr[140], tempobjects[35];
	cache_get_field_content(0, "InsideIDs", objectstr);
	sscanf(objectstr, "p<,>a<i>[35]", tempobjects);
	
	
	for(new i = 0; i < sizeof(tempobjects); i ++)
	{
	    for(new a = 0; a < sizeof tempobjects; a ++)
			if(tempobjects[i] == tempobjects[a] && a != i)
				tempobjects[i] = 0;

	    objectsstored[playerid][i][memslot] = tempobjects[i];
	}

	for(new i = 0; i < sizeof(objectsstored[]); i ++)
	{
	    if(objectsstored[playerid][i][memslot] == 0)
			continue;
	    
		mysql_format(dbHandle, query, sizeof(query),"SELECT * FROM objects \
		JOIN playerobjects ON objects.ID = playerobjects.O_ObjectID \
		WHERE playerobjects.PID = %d LIMIT 0,1", objectsstored[playerid][i][memslot]);
		mysql_tquery(dbHandle, query, "OnObjectDataLoaded", "iii", playerid, ObjectID, memslot);
	}
	return 1;
}

forward OnObjectDataLoaded(playerid, ObjectID, memslot);
public OnObjectDataLoaded(playerid, ObjectID, memslot)
{
	new position = cache_get_field_content_int(0, "Position");
	new display = cache_get_field_content_int(0, "Display");
	new trueid = cache_get_field_content_int(0, "PID");
	
	objectdisplay[playerid][position][memslot] = display;
	objectscap[playerid][position][memslot] = cache_get_field_content_int(0, "Carry");
	objecttypes[playerid][position][memslot] = cache_get_field_content_int(0, "TypeID");
	
	PlayerTextDrawHide(playerid, InventoryObjectsSlots[playerid][position][memslot]);
	PlayerTextDrawSetPreviewModel(playerid, InventoryObjectsSlots[playerid][position][memslot], display);
	
	PlayerTextDrawSetPreviewRot(playerid, InventoryObjectsSlots[playerid][position][memslot], cache_get_field_content_float(0, "DisplayXOffset"), cache_get_field_content_float(0, "DisplayYOffset"),
 	cache_get_field_content_float(0, "DisplayZOffset"), cache_get_field_content_float(0, "DisplayZoom"));
	PlayerTextDrawColor(playerid, InventoryObjectsSlots[playerid][position][memslot], cache_get_field_content_int(0, "DisplayColor"));
	
	if(GetPVarInt(playerid,"SelectedObject") == trueid)
		PlayerTextDrawBackgroundColor(playerid, InventoryObjectsSlots[playerid][position][memslot], 0xFF660066);
	else
	    PlayerTextDrawBackgroundColor(playerid, InventoryObjectsSlots[playerid][position][memslot], 0x00000066);
	PlayerTextDrawShow(playerid, InventoryObjectsSlots[playerid][position][memslot]);
	slotused[playerid][position][memslot] = trueid;
	

	//new VerticalSize = cache_get_field_content_int(0, "V_Size");
	new HorizontalSize = cache_get_field_content_int(0, "H_Size");
	objectsize[playerid][position][memslot] = HorizontalSize;
    /*if(VerticalSize >= 1)
    {
        for(new i = 1; i < VerticalSize; i ++)
        {
            PlayerTextDrawBackgroundColor(playerid, InventoryObjectsSlots[playerid][position+(7*i)][memslot], 0x00000066);
   	 		PlayerTextDrawShow(playerid, InventoryObjectsSlots[playerid][position+(7*i)][memslot]);
        }

    }*/
    if(HorizontalSize >= 1)
    {
        for(new i = 1; i < HorizontalSize; i ++)
        {
            if(GetPVarInt(playerid,"SelectedObject") == trueid)
	            PlayerTextDrawBackgroundColor(playerid, InventoryObjectsSlots[playerid][position+i][memslot], 0xFF660066);
			else
			    PlayerTextDrawBackgroundColor(playerid, InventoryObjectsSlots[playerid][position+i][memslot], 0x00000066);
			    
			PlayerTextDrawColor(playerid, InventoryObjectsSlots[playerid][position+i][memslot], cache_get_field_content_int(0, "DisplayColor"));
   	 		PlayerTextDrawShow(playerid, InventoryObjectsSlots[playerid][position+i][memslot]);
   	 		
   	 		slotused[playerid][position+i][memslot] = trueid;
        }

    }


	return 1;
}

stock DestroyNearInventoryObjects(playerid)
{
    for(new i; i != sizeof InventoryObjectsHead[]; ++i)
    {
        if(GlobalObjectsHead[playerid][i][0] != PlayerText:INVALID_TEXT_DRAW)
        {
			PlayerTextDrawDestroy(playerid, GlobalObjectsHead[playerid][i][0]);
            GlobalObjectsHead[playerid][i][0] = PlayerText:INVALID_TEXT_DRAW;
		}
		if(GlobalObjectsHead[playerid][i][1] != PlayerText:INVALID_TEXT_DRAW)
        {
			PlayerTextDrawDestroy(playerid, GlobalObjectsHead[playerid][i][1]);
            GlobalObjectsHead[playerid][i][1] = PlayerText:INVALID_TEXT_DRAW;
		}
		if(GlobalObjectsHead[playerid][i][2] != PlayerText:INVALID_TEXT_DRAW)
        {
			PlayerTextDrawDestroy(playerid, GlobalObjectsHead[playerid][i][2]);
            GlobalObjectsHead[playerid][i][2] = PlayerText:INVALID_TEXT_DRAW;
		}
		if(GlobalObjectsHead[playerid][i][3] != PlayerText:INVALID_TEXT_DRAW)
        {
			PlayerTextDrawDestroy(playerid, GlobalObjectsHead[playerid][i][3]);
            GlobalObjectsHead[playerid][i][3] = PlayerText:INVALID_TEXT_DRAW;
		}
	}
	for(new i; i != sizeof InventoryObjectsSlots[]; ++i)
	{
        if(GlobalObjectsSlots[playerid][i][0] != PlayerText:INVALID_TEXT_DRAW)
        {
            PlayerTextDrawDestroy(playerid, GlobalObjectsSlots[playerid][i][0]);
            GlobalObjectsSlots[playerid][i][0] = PlayerText:INVALID_TEXT_DRAW;
		}
		if(GlobalObjectsSlots[playerid][i][1] != PlayerText:INVALID_TEXT_DRAW)
        {
			PlayerTextDrawDestroy(playerid, GlobalObjectsSlots[playerid][i][1]);
            GlobalObjectsSlots[playerid][i][1] = PlayerText:INVALID_TEXT_DRAW;
		}
		if(GlobalObjectsSlots[playerid][i][2] != PlayerText:INVALID_TEXT_DRAW)
        {
			PlayerTextDrawDestroy(playerid, GlobalObjectsSlots[playerid][i][2]);
            GlobalObjectsSlots[playerid][i][2] = PlayerText:INVALID_TEXT_DRAW;
		}
		if(GlobalObjectsSlots[playerid][i][3] != PlayerText:INVALID_TEXT_DRAW)
        {
			PlayerTextDrawDestroy(playerid, GlobalObjectsSlots[playerid][i][3]);
            GlobalObjectsSlots[playerid][i][3] = PlayerText:INVALID_TEXT_DRAW;
		}
	}
	return 1;
}

stock DestroyActions(playerid)
{
    for(new i; i != sizeof ActionMenu[]; ++i)
    {
        if(ActionMenu[playerid][i] != PlayerText:INVALID_TEXT_DRAW)
        {
			PlayerTextDrawDestroy(playerid, ActionMenu[playerid][i]);
            ActionMenu[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
		}
	}
	return 1;
}

stock DestroyInventoryObjects(playerid)
{
    for(new i; i != sizeof InventoryObjectsHead[]; ++i)
    {
        if(InventoryObjectsHead[playerid][i][0] != PlayerText:INVALID_TEXT_DRAW)
        {
			PlayerTextDrawDestroy(playerid, InventoryObjectsHead[playerid][i][0]);
            InventoryObjectsHead[playerid][i][0] = PlayerText:INVALID_TEXT_DRAW;
		}
		if(InventoryObjectsHead[playerid][i][1] != PlayerText:INVALID_TEXT_DRAW)
        {
			PlayerTextDrawDestroy(playerid, InventoryObjectsHead[playerid][i][1]);
            InventoryObjectsHead[playerid][i][1] = PlayerText:INVALID_TEXT_DRAW;
		}
		if(InventoryObjectsHead[playerid][i][2] != PlayerText:INVALID_TEXT_DRAW)
        {
			PlayerTextDrawDestroy(playerid, InventoryObjectsHead[playerid][i][2]);
            InventoryObjectsHead[playerid][i][2] = PlayerText:INVALID_TEXT_DRAW;
		}
		if(InventoryObjectsHead[playerid][i][3] != PlayerText:INVALID_TEXT_DRAW)
        {
			PlayerTextDrawDestroy(playerid, InventoryObjectsHead[playerid][i][3]);
            InventoryObjectsHead[playerid][i][3] = PlayerText:INVALID_TEXT_DRAW;
		}
	}
	for(new i; i != sizeof InventoryObjectsSlots[]; ++i)
	{
        if(InventoryObjectsSlots[playerid][i][0] != PlayerText:INVALID_TEXT_DRAW)
        {
            PlayerTextDrawDestroy(playerid, InventoryObjectsSlots[playerid][i][0]);
            InventoryObjectsSlots[playerid][i][0] = PlayerText:INVALID_TEXT_DRAW;
		}
		if(InventoryObjectsSlots[playerid][i][1] != PlayerText:INVALID_TEXT_DRAW)
        {
			PlayerTextDrawDestroy(playerid, InventoryObjectsSlots[playerid][i][1]);
            InventoryObjectsSlots[playerid][i][1] = PlayerText:INVALID_TEXT_DRAW;
		}
		if(InventoryObjectsSlots[playerid][i][2] != PlayerText:INVALID_TEXT_DRAW)
        {
			PlayerTextDrawDestroy(playerid, InventoryObjectsSlots[playerid][i][2]);
            InventoryObjectsSlots[playerid][i][2] = PlayerText:INVALID_TEXT_DRAW;
		}
		if(InventoryObjectsSlots[playerid][i][3] != PlayerText:INVALID_TEXT_DRAW)
        {
			PlayerTextDrawDestroy(playerid, InventoryObjectsSlots[playerid][i][3]);
            InventoryObjectsSlots[playerid][i][3] = PlayerText:INVALID_TEXT_DRAW;
		}
	}
	return 1;
}

stock CreateInventory(playerid)
{
	Inv[playerid][0] = CreatePlayerTextDraw(playerid, 650.000000, 105.000000, "HeadBox");
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][0], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][0], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, Inv[playerid][0], -1);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][0], 1);
	PlayerTextDrawUseBox(playerid, Inv[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][0], 255);
	PlayerTextDrawTextSize(playerid, Inv[playerid][0], -10.000000, 0.000000);

	Inv[playerid][1] = CreatePlayerTextDraw(playerid, 650.000000, 111.000000, "BodyBox");
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][1], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][1], 0.500000, 38.000000);
	PlayerTextDrawColor(playerid, Inv[playerid][1], -1);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][1], 1);
	PlayerTextDrawUseBox(playerid, Inv[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][1], 0x00000000);
	PlayerTextDrawTextSize(playerid, Inv[playerid][1], 412.000000, 600.000000);
	PlayerTextDrawSetSelectable(playerid, Inv[playerid][1], 1);

	Inv[playerid][2] = CreatePlayerTextDraw(playerid, 532.000000, 106.000000, "Inventory");
	PlayerTextDrawAlignment(playerid, Inv[playerid][2], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][2], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][2], 2);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][2], 0.200000, 0.699999);
	PlayerTextDrawColor(playerid, Inv[playerid][2], -1);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][2], 1);

	Inv[playerid][3] = CreatePlayerTextDraw(playerid, 213.000000, 111.000000, "_");
	PlayerTextDrawAlignment(playerid, Inv[playerid][3], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][3], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][3], 0.500000, 39.000000);
	PlayerTextDrawColor(playerid, Inv[playerid][3], -1);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][3], 1);
	PlayerTextDrawUseBox(playerid, Inv[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][3], 255);
	PlayerTextDrawTextSize(playerid, Inv[playerid][3], 9.000000, -2.000000);

	Inv[playerid][4] = CreatePlayerTextDraw(playerid, 413.000000, 111.000000, "_");
	PlayerTextDrawAlignment(playerid, Inv[playerid][4], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][4], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][4], 0.500000, 39.000000);
	PlayerTextDrawColor(playerid, Inv[playerid][4], -1);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][4], 1);
	PlayerTextDrawUseBox(playerid, Inv[playerid][4], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][4], 255);
	PlayerTextDrawTextSize(playerid, Inv[playerid][4], 9.000000, -2.000000);

	Inv[playerid][5] = CreatePlayerTextDraw(playerid, 101.000000, 106.000000, "Proximity");
	PlayerTextDrawAlignment(playerid, Inv[playerid][5], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][5], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][5], 2);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][5], 0.200000, 0.699999);
	PlayerTextDrawColor(playerid, Inv[playerid][5], -1);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][5], 1);

	Inv[playerid][6] = CreatePlayerTextDraw(playerid, 633.000000, 111.000000, "_");
	PlayerTextDrawAlignment(playerid, Inv[playerid][6], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][6], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][6], 0.500000, 38.000000);
	PlayerTextDrawColor(playerid, Inv[playerid][6], -1);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][6], 1);
	PlayerTextDrawUseBox(playerid, Inv[playerid][6], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][6], 255);
	PlayerTextDrawTextSize(playerid, Inv[playerid][6], 9.000000, -2.000000);
	
	Inv[playerid][15] = CreatePlayerTextDraw(playerid, 637.000000, 114.000000, "_"); // real UP arrow
	PlayerTextDrawAlignment(playerid, Inv[playerid][15], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][15], 0);
	PlayerTextDrawFont(playerid, Inv[playerid][15], 1);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][15], 0.180000, 1.300000);
	PlayerTextDrawColor(playerid, Inv[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][15], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][15], 0);
	PlayerTextDrawUseBox(playerid, Inv[playerid][15], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][15], 0);
	PlayerTextDrawTextSize(playerid, Inv[playerid][15], 5.000000, 5.000000);
	PlayerTextDrawSetSelectable(playerid, Inv[playerid][15], 1);

	Inv[playerid][7] = CreatePlayerTextDraw(playerid, 637.000000, 124.000000, "V"); //up
	PlayerTextDrawAlignment(playerid, Inv[playerid][7], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][7], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][7], 0.180000, -1.200000);
	PlayerTextDrawColor(playerid, Inv[playerid][7], -1);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][7], 0);
	PlayerTextDrawUseBox(playerid, Inv[playerid][7], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][7], 255);
	PlayerTextDrawTextSize(playerid, Inv[playerid][7], 10.000000, 5.000000);

	Inv[playerid][8] = CreatePlayerTextDraw(playerid, 637.000000, 436.000000, "V"); //down
	PlayerTextDrawAlignment(playerid, Inv[playerid][8], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][8], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][8], 1);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][8], 0.180000, 1.200000);
	PlayerTextDrawColor(playerid, Inv[playerid][8], -1);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][8], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][8], 0);
	PlayerTextDrawUseBox(playerid, Inv[playerid][8], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][8], 255);
	PlayerTextDrawTextSize(playerid, Inv[playerid][8], 10.000000, 5.000000);
	PlayerTextDrawSetSelectable(playerid, Inv[playerid][8], 1);

	Inv[playerid][9] = CreatePlayerTextDraw(playerid, 247.000000, 110.000000, "1");
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][9], 0);
	PlayerTextDrawFont(playerid, Inv[playerid][9], 5);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][9], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, Inv[playerid][9], -1);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][9], 1);
	PlayerTextDrawSetPreviewModel(playerid, Inv[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][9], 1);
	PlayerTextDrawUseBox(playerid, Inv[playerid][9], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][9], -1);
	PlayerTextDrawTextSize(playerid, Inv[playerid][9], 140.000000, 200.000000);
	PlayerTextDrawSetSelectable(playerid, Inv[playerid][9], 1);

	Inv[playerid][10] = CreatePlayerTextDraw(playerid, 313.000000, 339.000000, "Put");
	PlayerTextDrawAlignment(playerid, Inv[playerid][10], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][10], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][10], 1);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][10], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, Inv[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][10], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][10], 0);
	PlayerTextDrawUseBox(playerid, Inv[playerid][10], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][10], 255);
	PlayerTextDrawTextSize(playerid, Inv[playerid][10], 80.000000, 197.000000);

	Inv[playerid][11] = CreatePlayerTextDraw(playerid, 313.000000, 351.000000, "_"); //handsbody
	PlayerTextDrawAlignment(playerid, Inv[playerid][11], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][11], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][11], 1);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][11], 0.500000, 11.299997);
	PlayerTextDrawColor(playerid, Inv[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][11], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][11], 0);
	PlayerTextDrawUseBox(playerid, Inv[playerid][11], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][11], 0x00000044);
	PlayerTextDrawTextSize(playerid, Inv[playerid][11], 80.000000, 197.000000);
	PlayerTextDrawSetSelectable(playerid, Inv[playerid][11], 1);

	Inv[playerid][12] = CreatePlayerTextDraw(playerid, 230.000000, 340.000000, "Hands");
	PlayerTextDrawAlignment(playerid, Inv[playerid][12], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][12], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][12], 2);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][12], 0.200000, 0.699999);
	PlayerTextDrawColor(playerid, Inv[playerid][12], -1);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][12], 1);

	Inv[playerid][13] = CreatePlayerTextDraw(playerid, 409.000000, 339.000000, "X");
	PlayerTextDrawAlignment(playerid, Inv[playerid][13], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][13], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][13], 2);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][13], 0.270000, 1.000000);
	PlayerTextDrawColor(playerid, Inv[playerid][13], -16776961);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][13], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][13], 0);
	PlayerTextDrawUseBox(playerid, Inv[playerid][13], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][13], -587202424);
	PlayerTextDrawTextSize(playerid, Inv[playerid][13], 5.000000, 5.000000);
	PlayerTextDrawSetSelectable(playerid, Inv[playerid][13], 1);

	Inv[playerid][14] = CreatePlayerTextDraw(playerid, 4.000000, 105.000000, "X");
	PlayerTextDrawAlignment(playerid, Inv[playerid][14], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][14], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][14], 2);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][14], 0.270000, 1.000000);
	PlayerTextDrawColor(playerid, Inv[playerid][14], -16776961);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][14], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][14], 0);
	PlayerTextDrawUseBox(playerid, Inv[playerid][14], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][14], -587202424);
	PlayerTextDrawTextSize(playerid, Inv[playerid][14], 5.000000, 5.000000);
	PlayerTextDrawSetSelectable(playerid, Inv[playerid][14], 1);
	
	Inv[playerid][16] = CreatePlayerTextDraw(playerid, 636.500000, 125.000000, "_");
	PlayerTextDrawAlignment(playerid, Inv[playerid][16], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][16], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][16], 1);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][16], 0.509999, 34.199996);
	PlayerTextDrawColor(playerid, Inv[playerid][16], -1442840321);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][16], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][16], 1);
	PlayerTextDrawUseBox(playerid, Inv[playerid][16], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][16], -1157627734);
	PlayerTextDrawTextSize(playerid, Inv[playerid][16], 0.000000, 4.000000);
	
	Inv[playerid][17] = CreatePlayerTextDraw(playerid, 88.000000, 117.000000, "_");//proximity box
	PlayerTextDrawAlignment(playerid, Inv[playerid][17], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][17], 0);
	PlayerTextDrawFont(playerid, Inv[playerid][17], 1);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][17], 3.099998, 37.000000);
	PlayerTextDrawColor(playerid, Inv[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][17], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][17], 1);
	PlayerTextDrawUseBox(playerid, Inv[playerid][17], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][17], 0x00000000);
	PlayerTextDrawTextSize(playerid, Inv[playerid][17], 300.000000, 230.000000);
	PlayerTextDrawSetSelectable(playerid, Inv[playerid][17], 1);
	
	Inv[playerid][18] = CreatePlayerTextDraw(playerid, 263.000000, 360.000000, "_"); //hands item
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][18], 0);
	PlayerTextDrawFont(playerid, Inv[playerid][18], 5);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][18], 1.300000, 6.000000);
	PlayerTextDrawColor(playerid, Inv[playerid][18], -1);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][18], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][18], 1);
	PlayerTextDrawSetPreviewModel(playerid, Inv[playerid][18], 19300);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][18], 1);
	PlayerTextDrawUseBox(playerid, Inv[playerid][18], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][18], 255);
	PlayerTextDrawTextSize(playerid, Inv[playerid][18], 100.000000, 80.000000);
	
	Inv[playerid][23] = CreatePlayerTextDraw(playerid, 209.000000, 113.000000, "_"); // actual up
	PlayerTextDrawAlignment(playerid, Inv[playerid][23], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][23], 0);
	PlayerTextDrawFont(playerid, Inv[playerid][23], 1);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][23], 0.180000, 1.299999);
	PlayerTextDrawColor(playerid, Inv[playerid][23], 0);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][23], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][23], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][23], 0);
	PlayerTextDrawUseBox(playerid, Inv[playerid][23], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][23], 0);
	PlayerTextDrawTextSize(playerid, Inv[playerid][23], 5.000000, 5.000000);
	PlayerTextDrawSetSelectable(playerid, Inv[playerid][23], 1);
	
	Inv[playerid][19] = CreatePlayerTextDraw(playerid, 209.000000, 124.000000, "V"); // up
	PlayerTextDrawAlignment(playerid, Inv[playerid][19], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][19], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][19], 1);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][19], 0.180000, -1.200000);
	PlayerTextDrawColor(playerid, Inv[playerid][19], -1);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][19], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][19], 0);
	PlayerTextDrawUseBox(playerid, Inv[playerid][19], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][19], 255);
	PlayerTextDrawTextSize(playerid, Inv[playerid][19], 5.000000, 5.000000);
	//PlayerTextDrawSetSelectable(playerid, Inv[playerid][19], 1);
	
	Inv[playerid][20] = CreatePlayerTextDraw(playerid, 209.000000, 436.000000, "V"); // down
	PlayerTextDrawAlignment(playerid, Inv[playerid][20], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][20], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][20], 1);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][20], 0.180000, 1.200000);
	PlayerTextDrawColor(playerid, Inv[playerid][20], -1);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][20], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][20], 0);
	PlayerTextDrawUseBox(playerid, Inv[playerid][20], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][20], 255);
	PlayerTextDrawTextSize(playerid, Inv[playerid][20], 5.000000, 5.000000);
	PlayerTextDrawSetSelectable(playerid, Inv[playerid][20], 1);

	Inv[playerid][21] = CreatePlayerTextDraw(playerid, 205.000000, 111.000000, "_");
	PlayerTextDrawAlignment(playerid, Inv[playerid][21], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][21], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][21], 1);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][21], 0.500000, 38.000000);
	PlayerTextDrawColor(playerid, Inv[playerid][21], -1);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][21], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][21], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][21], 1);
	PlayerTextDrawUseBox(playerid, Inv[playerid][21], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][21], 255);
	PlayerTextDrawTextSize(playerid, Inv[playerid][21], 9.000000, -2.000000);

	Inv[playerid][22] = CreatePlayerTextDraw(playerid, 208.899993, 125.099998, "_");
	PlayerTextDrawAlignment(playerid, Inv[playerid][22], 2);
	PlayerTextDrawBackgroundColor(playerid, Inv[playerid][22], 255);
	PlayerTextDrawFont(playerid, Inv[playerid][22], 1);
	PlayerTextDrawLetterSize(playerid, Inv[playerid][22], 0.509998, 34.199966);
	PlayerTextDrawColor(playerid, Inv[playerid][22], -1442840321);
	PlayerTextDrawSetOutline(playerid, Inv[playerid][22], 0);
	PlayerTextDrawSetProportional(playerid, Inv[playerid][22], 1);
	PlayerTextDrawSetShadow(playerid, Inv[playerid][22], 1);
	PlayerTextDrawUseBox(playerid, Inv[playerid][22], 1);
	PlayerTextDrawBoxColor(playerid, Inv[playerid][22], -1157627734);
	PlayerTextDrawTextSize(playerid, Inv[playerid][22], 0.000000, 4.000000);
	return 1;
}

stock BringActionMenu(playerid, object, memoryslotused, type, slot)
{
	if(GetPVarInt(playerid,"SwappingStep") == 0)
	{
		mysql_format(dbHandle, bigquery, sizeof bigquery,
		"SELECT playerobjects.Uses, objects.Name, objects.TypeID, playerobjects.TotalUses, objects.SpecialFlag_1, objects.SpecialFlag_2, \
		playerobjects.P_SpecialFlag_1, playerobjects.P_SpecialFlag_2, actions.ActionID, actions.Action FROM playerobjects \
		JOIN objects ON playerobjects.O_ObjectID = objects.ID \
		JOIN types ON objects.TypeID = Types.TypeInt \
		JOIN actions ON Types.TypeInt = actions.TypeID \
		WHERE playerobjects.PID = %d", object);
	}
	else if(GetPVarInt(playerid,"SwappingStep") == 1)
	{
	    mysql_format(dbHandle, bigquery, sizeof bigquery,
		"SELECT playerobjects.Uses, objects.Name, objects.TypeID, playerobjects.TotalUses, objects.SpecialFlag_1, objects.SpecialFlag_2, \
		playerobjects.P_SpecialFlag_1, playerobjects.P_SpecialFlag_2, actions.ActionID, actions.Action FROM playerobjects \
		JOIN objects ON playerobjects.O_ObjectID = objects.ID \
		JOIN types ON objects.TypeID = Types.TypeInt \
		JOIN actions ON (actions.ActionID = 1 OR actions.ActionID = 2) \
		WHERE playerobjects.PID = %d", object);
	}
	else if(GetPVarInt(playerid,"SwappingStep") == 2)
	{
	    mysql_format(dbHandle, bigquery, sizeof bigquery,
		"SELECT playerobjects.Uses, objects.Name, objects.TypeID, playerobjects.TotalUses, objects.SpecialFlag_1, objects.SpecialFlag_2, \
		playerobjects.P_SpecialFlag_1, playerobjects.P_SpecialFlag_2, actions.ActionID, actions.Action FROM playerobjects \
		JOIN objects ON playerobjects.O_ObjectID = objects.ID \
		JOIN types ON objects.TypeID = Types.TypeInt \
		JOIN actions ON (actions.ActionID = 1 OR actions.ActionID = 13) \
		WHERE playerobjects.PID = %d", object);
	}
	
	mysql_tquery(dbHandle, bigquery, "OnPlayerRequestActionList", "iiiii", playerid, object, memoryslotused, type, slot);
	return 1;
}

forward OnPlayerRequestActionList(playerid, object, memoryslotused, type, slot);
public OnPlayerRequestActionList(playerid, object, memoryslotused, type, slot)
{
	new Float:fX, Float:fY;
	if(type == 2)
	{
	    fY = headerystored[playerid][memoryslotused];
	    fX = 415 + 30;
	}
	else
	{
		new actualposition = memoryslot[playerid][1];
		new in_line = floatround( float(actualposition+1) / 7.0, floatround_ceil);
	    fY = headerystored[playerid][memoryslotused] + (37.0 * float(in_line)) + 1.0;
	    fX = 446.0 + 31.0 * float(actualposition % 7);
	}
	if(fY > 430.0)
	    fY = fY-50.0;
	if(fX > 630.0)
	    fX = fX-32.0;


	DestroyActions(playerid);

    new rows, fields;
	cache_get_data(rows, fields);
	if(rows != 0)
	{
	    new name[40];
		cache_get_field_content(0, "Name", name);
		
		if(cache_get_field_content_int(0, "TotalUses") != 0)
			format(name, sizeof name,"%s (%d)", name, cache_get_field_content_int(0, "Uses"));
		else
		    format(name, sizeof name,"%s", name);
		    
		ActionMenu[playerid][4] = CreatePlayerTextDraw(playerid, fX,fY, name);
		PlayerTextDrawAlignment(playerid, ActionMenu[playerid][4], 2);
		PlayerTextDrawBackgroundColor(playerid, ActionMenu[playerid][4], 255);
		PlayerTextDrawFont(playerid, ActionMenu[playerid][4], 1);
		PlayerTextDrawLetterSize(playerid, ActionMenu[playerid][4], 0.159999, 0.799999);
		PlayerTextDrawColor(playerid, ActionMenu[playerid][4], -1);
		PlayerTextDrawSetOutline(playerid, ActionMenu[playerid][4], 1);
		PlayerTextDrawSetProportional(playerid, ActionMenu[playerid][4], 1);
		PlayerTextDrawUseBox(playerid, ActionMenu[playerid][4], 1);
		PlayerTextDrawBoxColor(playerid, ActionMenu[playerid][4], 0xFF000044);
		PlayerTextDrawTextSize(playerid, ActionMenu[playerid][4], 10.000000, 60.000000);
		PlayerTextDrawShow(playerid, ActionMenu[playerid][4]);
		fY += 10.55;
	
		for(new i = 0; i < rows; i ++)
		{
		    if(i >= MAX_OBJECT_ACTIONS)
				break;
		
            cache_get_field_content(i, "Action", actionname[playerid][i]);
            action[playerid][i] = cache_get_field_content_int(i, "ActionID");
            objecttype[playerid] = cache_get_field_content_int(i, "TypeID");
            objectorigin[playerid] = slot;
            objectuses[playerid][0] = cache_get_field_content_int(i, "Uses");
            objectuses[playerid][1] = cache_get_field_content_int(i, "TotalUses");
            objectflags[playerid][0] = cache_get_field_content_int(i, "SpecialFlag_1");
            objectflags[playerid][1] = cache_get_field_content_int(i, "SpecialFlag_2");
            objectflags[playerid][4] = cache_get_field_content_int(i, "SpecialFlag_2");
            
            objectflags[playerid][2] = cache_get_field_content_int(i, "P_SpecialFlag_1");
            objectflags[playerid][3] = cache_get_field_content_int(i, "P_SpecialFlag_2");
            
		    ActionMenu[playerid][i] = CreatePlayerTextDraw(playerid, fX,fY, actionname[playerid][i]);
			PlayerTextDrawAlignment(playerid, ActionMenu[playerid][i], 2);
			PlayerTextDrawBackgroundColor(playerid, ActionMenu[playerid][i], 255);
			PlayerTextDrawFont(playerid, ActionMenu[playerid][i], 1);
			PlayerTextDrawLetterSize(playerid, ActionMenu[playerid][i], 0.159999, 0.799999);
			PlayerTextDrawColor(playerid, ActionMenu[playerid][i], -1);
			PlayerTextDrawSetOutline(playerid, ActionMenu[playerid][i], 1);
			PlayerTextDrawSetProportional(playerid, ActionMenu[playerid][i], 1);
			PlayerTextDrawUseBox(playerid, ActionMenu[playerid][i], 1);
			PlayerTextDrawBoxColor(playerid, ActionMenu[playerid][i], -10092476); //
			PlayerTextDrawTextSize(playerid, ActionMenu[playerid][i], 10.000000, 60.000000);
			PlayerTextDrawSetSelectable(playerid, ActionMenu[playerid][i], 1);
			PlayerTextDrawShow(playerid, ActionMenu[playerid][i]);
		
		    fY += 10.55;
		}
	}
	
	ActionMenu[playerid][3] = CreatePlayerTextDraw(playerid, fX,fY, "Close");
	PlayerTextDrawAlignment(playerid, ActionMenu[playerid][3], 2);
	PlayerTextDrawBackgroundColor(playerid, ActionMenu[playerid][3], 255);
	PlayerTextDrawFont(playerid, ActionMenu[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, ActionMenu[playerid][3], 0.159999, 0.799999);
	PlayerTextDrawColor(playerid, ActionMenu[playerid][3], -1);
	PlayerTextDrawSetOutline(playerid, ActionMenu[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, ActionMenu[playerid][3], 1);
	PlayerTextDrawUseBox(playerid, ActionMenu[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid, ActionMenu[playerid][3], -10092476);
	PlayerTextDrawTextSize(playerid, ActionMenu[playerid][3], 10.000000, 60.000000);
	PlayerTextDrawSetSelectable(playerid, ActionMenu[playerid][3], 1);
	PlayerTextDrawShow(playerid, ActionMenu[playerid][3]);
	return 1;
}

stock DestroyInventory(playerid)
{
	for(new i = 0; i < sizeof(Inv[]); i ++)
		PlayerTextDrawDestroy(playerid, Inv[playerid][i]);
	return 1;
}

stock ShowInventoryBase(playerid)
{
	PlayerTextDrawSetPreviewModel(playerid, Inv[playerid][9], GetPlayerSkin(playerid));

    for(new i = 0; i < sizeof(Inv[]); i ++)
		PlayerTextDrawShow(playerid, Inv[playerid][i]);
	return 1;
}

stock HideInventoryBase(playerid)
{
    for(new i = 0; i < sizeof(Inv[]); i ++)
		PlayerTextDrawHide(playerid, Inv[playerid][i]);
	return 1;
}

stock PlayerName(playerid)
{
  	GetPlayerName(playerid, nname, MAX_PLAYER_NAME);
  	return nname;
}

stock TDTip(playerid, const tip[], time = 6000)
{
    format(msg, sizeof(msg),"INFO: ~w~%s",tip);
	PlayerTextDrawSetString(playerid, GeneralTxt[playerid][4], msg);
	PlayerTextDrawShow(playerid, GeneralTxt[playerid][4]);
	KillTimer(HideTDTimer[playerid][4]);
	HideTDTimer[playerid][4] = SetTimerEx("GeneralTxtHide",time,false, "ii",playerid,4);
	return 1;
}
stock TDInfo(playerid, const info[], time = 6000)
{
    format(msg, sizeof(msg),"INFO: ~w~%s",info);
	PlayerTextDrawSetString(playerid, GeneralTxt[playerid][3], msg);
	PlayerTextDrawShow(playerid, GeneralTxt[playerid][3]);
	KillTimer(HideTDTimer[playerid][3]);
	HideTDTimer[playerid][3] = SetTimerEx("GeneralTxtHide",time,false, "ii",playerid,3);
	return 1;
}
stock TDAdmin(playerid, const info[], time = 6000)
{
    format(msg, sizeof(msg),"ADMIN: ~w~%s",info);
	PlayerTextDrawSetString(playerid, GeneralTxt[playerid][1], msg);
	PlayerTextDrawShow(playerid, GeneralTxt[playerid][1]);
	KillTimer(HideTDTimer[playerid][1]);
	HideTDTimer[playerid][1] = SetTimerEx("GeneralTxtHide",time,false, "ii",playerid,1);
	return 1;
}
stock TDWarning(playerid, const warning[], time = 6000)
{
    format(msg, sizeof(msg),"WARNING: ~w~%s",warning);
	PlayerTextDrawSetString(playerid, GeneralTxt[playerid][2], msg);
	PlayerTextDrawShow(playerid, GeneralTxt[playerid][2]);
	KillTimer(HideTDTimer[playerid][2]);
	HideTDTimer[playerid][2] = SetTimerEx("GeneralTxtHide",time,false, "ii",playerid,2);
	return 1;
}
stock Usage(playerid, const error[], time = 6000)
{
    format(msg, sizeof(msg),"WRONG SYNTAX: ~w~%s",error);
	PlayerTextDrawSetString(playerid, GeneralTxt[playerid][1], msg);
	PlayerTextDrawShow(playerid, GeneralTxt[playerid][1]);
	KillTimer(HideTDTimer[playerid][1]);
	HideTDTimer[playerid][1] = SetTimerEx("GeneralTxtHide",time,false, "ii",playerid,1);
	return 1;
}
stock TDError(playerid, const error[], time = 6000)
{
    format(msg, sizeof(msg),"ERROR: ~w~%s",error);
	PlayerTextDrawSetString(playerid, GeneralTxt[playerid][1], msg);
	PlayerTextDrawShow(playerid, GeneralTxt[playerid][1]);
	KillTimer(HideTDTimer[playerid][1]);
	HideTDTimer[playerid][1] = SetTimerEx("GeneralTxtHide",time,false, "ii",playerid,1);
	return 1;
}

forward GeneralTxtHide(playerid, txt);
public GeneralTxtHide(playerid, txt)
{
	PlayerTextDrawHide(playerid, GeneralTxt[playerid][txt]);
	return 1;
}

stock CreatePlayerTextdraws(playerid)
{
	// big info
    GeneralTxt[playerid][0] = CreatePlayerTextDraw(playerid, 310.000000, 50.000000, "_");
	PlayerTextDrawAlignment(playerid, GeneralTxt[playerid][0], 2);
	PlayerTextDrawBackgroundColor(playerid, GeneralTxt[playerid][0], 255);
	PlayerTextDrawFont(playerid, GeneralTxt[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, GeneralTxt[playerid][0], 0.500000, 2.900000);
	PlayerTextDrawColor(playerid, GeneralTxt[playerid][0], -1);
	PlayerTextDrawSetOutline(playerid, GeneralTxt[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, GeneralTxt[playerid][0], 1);

	//error
	GeneralTxt[playerid][1] = CreatePlayerTextDraw(playerid, 2.000000, 430.000000, "ERROR:");
	PlayerTextDrawBackgroundColor(playerid, GeneralTxt[playerid][1], 255);
	PlayerTextDrawFont(playerid, GeneralTxt[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, GeneralTxt[playerid][1], 0.359999, 1.500000);
	PlayerTextDrawColor(playerid, GeneralTxt[playerid][1], 0xFF0000DD);
	PlayerTextDrawSetOutline(playerid, GeneralTxt[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, GeneralTxt[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, GeneralTxt[playerid][1], 1);
	PlayerTextDrawUseBox(playerid, GeneralTxt[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, GeneralTxt[playerid][1], 0xFF000066);
	PlayerTextDrawTextSize(playerid, GeneralTxt[playerid][1], 1080.000000, 160.000000);

	//warning
	GeneralTxt[playerid][2] = CreatePlayerTextDraw(playerid, 2.000000, 430.000000, "WARNING:");
	PlayerTextDrawBackgroundColor(playerid, GeneralTxt[playerid][2], 255);
	PlayerTextDrawFont(playerid, GeneralTxt[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, GeneralTxt[playerid][2], 0.359999, 1.500000);
	PlayerTextDrawColor(playerid, GeneralTxt[playerid][2], 0xFFFF00DD);
	PlayerTextDrawSetOutline(playerid, GeneralTxt[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, GeneralTxt[playerid][2], 1);
	PlayerTextDrawUseBox(playerid, GeneralTxt[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid, GeneralTxt[playerid][2], 0xFFFF0066);
	PlayerTextDrawTextSize(playerid, GeneralTxt[playerid][2], 1080.000000, 160.000000);

	//info
	GeneralTxt[playerid][3] = CreatePlayerTextDraw(playerid, 2.000000, 430.000000, "INFO:");
	PlayerTextDrawBackgroundColor(playerid, GeneralTxt[playerid][3], 255);
	PlayerTextDrawFont(playerid, GeneralTxt[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, GeneralTxt[playerid][3], 0.359999, 1.500000);
	PlayerTextDrawColor(playerid, GeneralTxt[playerid][3], 0x00FFFFDD);
	PlayerTextDrawSetOutline(playerid, GeneralTxt[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, GeneralTxt[playerid][3], 1);
	PlayerTextDrawUseBox(playerid, GeneralTxt[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid, GeneralTxt[playerid][3], 0x00FFFF99);
	PlayerTextDrawTextSize(playerid, GeneralTxt[playerid][3], 1080.000000, 160.000000);

	//tip
	GeneralTxt[playerid][4] = CreatePlayerTextDraw(playerid, 2.000000, 430.000000, "TIP:");
	PlayerTextDrawBackgroundColor(playerid, GeneralTxt[playerid][4], 255);
	PlayerTextDrawFont(playerid, GeneralTxt[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, GeneralTxt[playerid][4], 0.359999, 1.500000);
	PlayerTextDrawColor(playerid, GeneralTxt[playerid][4], 0x009900DD);
	PlayerTextDrawSetOutline(playerid, GeneralTxt[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, GeneralTxt[playerid][4], 1);
	PlayerTextDrawUseBox(playerid, GeneralTxt[playerid][4], 1);
	PlayerTextDrawBoxColor(playerid, GeneralTxt[playerid][4], 0x00990066);
	PlayerTextDrawTextSize(playerid, GeneralTxt[playerid][4], 1080.000000, 160.000000);
	return 1;
}

stock DestroyPlayerTextdraws(playerid)
{
	for(new i = 0; i < sizeof(GeneralTxt[]); i ++)
		PlayerTextDrawDestroy(playerid, GeneralTxt[playerid][i]);

	return 1;
}

stock RenderMessage(top, color, const text[])
{
    new temp[156], tosearch = 0, colorint, posscolor, lastcol[12];
    new mess[356], colors, tempc; format(mess, 356, "%s",text);

    while(strlen(mess) > 0)
	{
	    if(strlen(mess) < 140)
	    {
			SendClientMessage(top, color, mess);
			break;
		}

	    strmid(temp, mess, 0, 128);
	    while(strfind(temp, "{", true) != -1)
	    {
	        tempc = strfind(temp, "{", true);
	        if(temp[tempc+7] == '}')
	        {
				colors ++;
				strdel(temp, tempc, tempc+7);
			}
			else
   			{
   			    temp[tempc] = '0';
   			    continue;
   			}
	    }
	    temp = "";

	    if(strfind(mess," ",true,100+colors*8) != -1)
		{
	        tosearch = strfind(mess," ",true,100+colors*8)+1;
	        while(tosearch > 140)
	        {
	        	colors --;
	        	tosearch = strfind(mess," ",true,100+colors*8)+1;
			}
		}

		if(strfind(mess,"{",true) != -1) //color codes detection , YAY
		{
			posscolor = strfind(mess,"{",true);

			if(mess[posscolor+7] == '}') //detected one color
		        colorint = posscolor;

            while(strfind(mess,"{",true,colorint+1) != -1) //repeat until none are found
			{
			    posscolor = strfind(mess,"{",true,colorint+1);
			    if(posscolor > tosearch) //if next color will be on the other line, use last color found to render on the next line
			    {
					posscolor = colorint;
			    	break;
			    }
				if(mess[posscolor+7] == '}') //if found, then assign the color
				{
					colorint = posscolor;
				}
				else
				{
				    posscolor = colorint; //else, leave the last color.
				    break;
				}
			}

            if(colorint == posscolor) //if the color position equals the one that was found
				strmid(lastcol,mess,colorint,colorint+8); //get the last used color string.
		}

        strmid(temp, mess, 0, tosearch);
        SendClientMessage(top, color, temp);
		strdel(mess, 0, tosearch);
		strins(mess, lastcol, 0); //insert last used color into the new line to be processed.


    	temp = "";
		tosearch = 0;
		colors = 0;
	}
	return 1;
}

stock RenderMessageToAll(color, const text[])
{
    new temp[156], tosearch = 0, colorint, posscolor, lastcol[12];
	new mess[356], colors, tempc; format(mess, 356, "%s",text);

    while(strlen(mess) > 0)
	{
		strmid(temp, mess, 0, 128);
	    while(strfind(temp, "{", true) != -1)
	    {
	        tempc = strfind(temp, "{", true);
	        if(temp[tempc+7] == '}')
	        {
				colors ++;
				strdel(temp, tempc, tempc+7);
			}
			else
   			{
   			    temp[tempc] = '0';
   			    continue;
   			}
	    }
	    temp = "";

	    if(strfind(mess," ",true,100+colors*8) != -1)
		{
	        tosearch = strfind(mess," ",true,100+colors*8)+1;
	        while(tosearch > 140)
	        {
	        	colors --;
	        	tosearch = strfind(mess," ",true,100+colors*8)+1;
			}
		}
	    if(tosearch <= 0)
	    {
			SendClientMessageToAll(color, mess);
			break;
		}

		if(strfind(mess,"{",true) != -1) //color codes detection , YAY
		{
			posscolor = strfind(mess,"{",true);

			if(mess[posscolor+7] == '}') //detected one color
		        colorint = posscolor;

            while(strfind(mess,"{",true,colorint+1) != -1) //repeat until none are found
			{
			    posscolor = strfind(mess,"{",true,colorint+1);
			    if(posscolor > tosearch) //if next color will be on the other line, use last color found to render on the next line
			    {
					posscolor = colorint;
			    	break;
			    }
				if(mess[posscolor+7] == '}') //if found, then assign the color
				{
					colorint = posscolor;
				}
				else
				{
				    posscolor = colorint; //else, leave the last color.
				    break;
				}
			}

            if(colorint == posscolor) //if the color position equals the one that was found
				strmid(lastcol,mess,colorint,colorint+8); //get the last used color string.
		}

        strmid(temp, mess, 0, tosearch);
        SendClientMessageToAll(color, temp);
		strdel(mess,0,tosearch);
		strins(mess, lastcol, 0);

    	temp = "";
		tosearch = 0;
		colors = 0;
	}
	return 1;
}

stock GetWeaponSlot(weaponid)
{
	new slot;
	if(weaponid == 0 || weaponid == 1)
	    slot = 0;
	else if(weaponid >= 2 && weaponid <= 9)
	    slot = 1;
	else if(weaponid >= 10 && weaponid <= 15)
		slot = 10;
	else if((weaponid >= 16 && weaponid <= 18) || weaponid == 39)
	    slot = 8;
	else if(weaponid >= 22 && weaponid <= 24)
	    slot = 2;
	else if(weaponid >= 25 && weaponid <= 27)
	    slot = 3;
	else if(weaponid == 28 || weaponid == 29 || weaponid == 32)
	    slot = 4;
	else if(weaponid == 30 || weaponid == 31)
	    slot = 5;
	else if(weaponid == 33 || weaponid == 34)
	    slot = 6;
	else if(weaponid >= 35 && weaponid <= 38)
	    slot = 7;
	else if(weaponid == 40)
	    slot = 12;
	else if(weaponid >= 41 && weaponid <= 43)
	    slot = 9;
	else if(weaponid >= 44 && weaponid <= 46)
	    slot = 11;

	return slot;
}

// not by me

HexToInt(string[]){
   if (string[0]==0) return 0;
   new i;
   new cur=1;
   new res=0;
   for (i=strlen(string);i>0;i--) {
     if (string[i-1]<58) res=res+cur*(string[i-1]-48); else res=res+cur*(string[i-1]-65+10);
     cur=cur*16;
   }
   return res;
 }
 
 
stock RemovePlayerWeapon(playerid, weaponid)
{
    if(!IsPlayerConnected(playerid) || weaponid < 0 || weaponid > 50)
        return;

    new
        saveweapon[13],
        saveammo[13];

    for(new slot = 0; slot < 13; slot++)
        GetPlayerWeaponData(playerid, slot, saveweapon[slot], saveammo[slot]);

    ResetPlayerWeapons(playerid);

    for(new slot; slot < 13; slot++)
    {
        GivePlayerWeapon(playerid, saveweapon[slot], saveammo[slot]);
    }
    //GivePlayerWeaponEx(playerid, 0, 1);
}

stock IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
    {
   		if (string[i] > '9' || string[i] < '0') return 0;
   	}
   	return 1;
}

stock IsFloat(buf[])
{
    new l = strlen(buf);
    new dcount = 0;
    for(new i=0; i<l; i++)
    {
        if(buf[i] == '.')
        {
            if(i == 0 || i == l-1) return 0;
            else
            {
                dcount++;
            }
        }
        if((buf[i] > '9' || buf[i] < '0') && buf[i] != '+' && buf[i] != '-' && buf[i] != '.') return 0;
        if(buf[i] == '+' || buf[i] == '-')
        {
            if(i != 0 || l == 1) return 0;
        }
    }
    if(dcount == 0 || dcount > 1) return 0;
    return 1;
}

stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}
