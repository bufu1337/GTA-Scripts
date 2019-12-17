#include <a_samp>

new moveableobject[256];

public OnPlayerCommandText(playerid, cmdtext[])
{
if (strcmp("/hoch", cmdtext, true)==0)
{
MoveObject(moveableobject[0],-1797.607,557.023,235.383,3);//hoch

return 1;
}
if (strcmp("/runter", cmdtext, true)==0)
{
MoveObject(moveableobject[0],-1797.506,557.279,35.981,3);//runter

return 1;
}
return 0;
}

public OnFilterScriptInit()
{
moveableobject[0] = CreateObject(5837,-1797.506,557.279,35.981,0.0,0.0,-118.593);
return 1;
}

