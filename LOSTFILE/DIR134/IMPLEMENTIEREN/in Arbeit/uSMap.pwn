#include <a_samp>
#include <Y_Objects>
#include <YSI/Visual/YSI_objects.own>
#if defined FILTERSCRIPT
#endif
public OnFilterScriptInit()
{
print("\n--------------------------------------");
print(" Object Streamer FilterScript by Benni");
print("--------------------------------------\n");
Object_Object();
/////////////////////OBJECTS////////////////////////////////////////////////////
//CreateDynamicObject(3664, 2500.8213, 2740.0022, 9, -45, 0, 90); <<<<< Hier einfach alle Objekte einfügen
return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
Object_OnPlayerDisconnect(playerid, reason);
return 1;
}


