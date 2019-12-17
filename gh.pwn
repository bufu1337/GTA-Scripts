#include <a_samp>
#include <gh>

main() { }

public OnGameModeInit()
{

}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[128];
	new idx;
	cmd = strtok(cmdtext, idx);
	if (!strcmp(cmd, "/holder", true))
	{
	    cmd = strtok(cmdtext, idx);
	    new model = strval(cmd);
		SetHolderWeapon(playerid, model);
		return 1;
	}
	if (!strcmp(cmd, "/remove", true))
	{
		RemoveHolderWeapon(playerid);
	    return 1;
	}
	return 0;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
