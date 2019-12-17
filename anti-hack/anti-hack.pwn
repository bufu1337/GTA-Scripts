#include <a_samp>

#define COLOR_RED 0xFF0000FF

forward weaponhack();

main()
{
	print("\n----------------------------------");
	print(" ANTI-WEAPON-HACK by Doerfler");
	print("----------------------------------\n");
}
public OnFilterScriptInit()
{
SetTimer("weaponhack", 100, 1);
}

public OnPlayerConnect()
{
SetTimer("weaponhack", 100, 1);
}

public weaponhack()
{
new string[256];
new sendername[256];
for(new i; i<MAX_PLAYERS; i++)
{
if(IsPlayerAdmin(i))
{
}
else{
new w7;
new a7;
GetPlayerWeaponData(i, 7, w7, a7);
if(w7 == 38 && a7 >= 1)
{
GetPlayerName(i, sendername, sizeof(sendername));
format(string, sizeof(string), "%s wurde wegen cheaten einer minigun gekickt", sendername);
SendClientMessageToAll(COLOR_RED, string);
Kick(i);
}
if(w7 == 18 && a7 >= 1)
{
GetPlayerName(i, sendername, sizeof(sendername));
format(string, sizeof(string), "%s wurde wegen cheaten eines Molotovs gekickt", sendername);
SendClientMessageToAll(COLOR_RED, string);
Kick(i);
}
if(w7 == 37 && a7 >= 1)
{
GetPlayerName(i, sendername, sizeof(sendername));
format(string, sizeof(string), "%s wurde wegen cheaten eines Flammenwervers gekickt", sendername);
SendClientMessageToAll(COLOR_RED, string);
Kick(i);
}
if(w7 == 36 && a7 >= 1)
{
GetPlayerName(i, sendername, sizeof(sendername));
format(string, sizeof(string), "%s wurde wegen cheaten eines Raketenwerfers gekickt", sendername);
SendClientMessageToAll(COLOR_RED, string);
Kick(i);
}
if(w7 == 35 && a7 >= 1)
{
GetPlayerName(i, sendername, sizeof(sendername));
format(string, sizeof(string), "%s wurde wegen cheaten eines Raketenwerfers gekickt", sendername);
SendClientMessageToAll(COLOR_RED, string);
Kick(i);
}
if(w7 == 40 && a7 >= 1)
{
GetPlayerName(i, sendername, sizeof(sendername));
format(string, sizeof(string), "%s wurde wegen cheaten von Rucksackbomben gekickt", sendername);
SendClientMessageToAll(COLOR_RED, string);
Kick(i);
}
}
}
}
