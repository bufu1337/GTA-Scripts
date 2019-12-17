Some stuff

//OnPlayerConnect
new string[128],player[24];
GetPlayerName(playerid, player, 24);
format(string, 128, "** %s joined the server ! **",player);
SendClientMessageToAll(COLOR, string);
//OnPlayerDisconnect
new string[128],player[24];
GetPlayerName(playerid, player, 24);
switch(reason)
{
case 0: format(string, 128, "** %s left the server ( Crashed ) **",player);
case 1: format(string, 128, "** %s left the server ( Leaving ) **",player);
case 2: format(string, 128, "** %s left the server ( Kicked ) **",player);
}
SendClientMessageToAll(COLOR, string);

