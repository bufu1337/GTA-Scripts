// -- Simple CountDown Filterscript --
// -- By Unnamed / Unnamed (2008) --

// -- It has basic protection against duel counts and negative numbers
// -- being used in the /count command....

#include <a_samp>

//Credit to Unnamed and OG_LOG 
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

new Counting;

dcmd_count(playerid, params[])
{
if (!strlen(params)) return SendClientMessage(playerid, 0xafafafff, "Use: /count [how many]");

if (!IsNumeric(params)) return SendClientMessage(playerid, 0xafafafff, "[how many] no more 30");

if (Counting) return SendClientMessage(playerid, 0xafafafff, "Counter is started");

Counting = true;

new ii = strval(params);

do
{
SetTimerEx("CountDown", (strval(params) - ii) * 1000, false, "i", ii);

ii --;
}
while (ii != -1);

SendClientMessage(playerid, 0xffe600ff, "*** Counter is started ***");

return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
dcmd(count, 5, cmdtext);

return 0;
}

forward CountDown(num);

public CountDown(num)
{
new str[2];

if (num)
{
format(str, sizeof(str), "%i", num);

GameTextForAll(str, 1001, 4);
}
else
{
GameTextForAll("~g~Go Go Go", 3000, 4);

Counting = false;
}
}

IsNumeric(const string[])
{
for (new i = 0, j = strlen(string); i < j; i++)
{
if (string[i] > '9' || string[i] < '0') return 0;
}
return 1;
}



