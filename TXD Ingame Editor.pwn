#include <a_samp>
// TXD Ingame Editor by O.K.Style
new Text:TDS[1024];
public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256], idx;
	cmd = strtok(cmdtext, idx);

	if(strcmp(cmd, "/txd", true) == 0)
	{
		new tmp[30], tmp1[30];
		tmp = strtok(cmdtext, idx);
		tmp1 = strtok(cmdtext, idx);
		SetPVarInt(playerid, "TDID", strval(tmp));
		SetPVarString(playerid, "TDNAME", tmp1);
		SetPVarFloat(playerid, "X", 1.0);
		SetPVarFloat(playerid, "Y", 1.0);
		SetPVarFloat(playerid, "W", 30.0);
		SetPVarFloat(playerid, "H", 30.0);
		TDS[strval(tmp)] = TextDrawCreate(GetPVarFloat(playerid, "X"), GetPVarFloat(playerid, "Y"), tmp1);
		TextDrawFont(TDS[strval(tmp)], 4);
		TextDrawLetterSize(TDS[strval(tmp)], GetPVarFloat(playerid, "W"), GetPVarFloat(playerid, "H"));
		TextDrawShowForPlayer(playerid, TDS[strval(tmp)]);
		return 1;
	}
	if(strcmp(cmd, "/mode", true) == 0)
	{
	    new tmp[30];
	    tmp = strtok(cmdtext, idx);
	    SetPVarInt(playerid, "Mode", strval(tmp));
	    return 1;
	}
	if(strcmp(cmdtext, "/tdpos", true) == 0)
	{
	    new string[128];
	    format(string, sizeof(string), "X: %.4f Y: %.4f WIDTH: %.4f HEIGHT: %.4f", GetPVarFloat(playerid, "X"), GetPVarFloat(playerid, "Y"), GetPVarFloat(playerid, "W"), GetPVarFloat(playerid, "H"));
		SendClientMessage(playerid, 0xFFFFFFFF, string);
		return 1;
	}
	return 0;
}
public OnPlayerUpdate(playerid)
{
	if(GetPVarInt(playerid, "Editing") == 0) return 1;
	new Keys, ud, lr;
	GetPlayerKeys(playerid, Keys, ud, lr);

	if(ud > 0)
	{
	    new tdid = GetPVarInt(playerid, "TDID");
	    TextDrawHideForPlayer(playerid, TDS[tdid]);
	    TextDrawDestroy(TDS[tdid]);

		new tdname[30];
		GetPVarString(playerid, "TDNAME", tdname, sizeof(tdname));

	    if(GetPVarInt(playerid, "Mode") == 0) SetPVarFloat(playerid, "Y", GetPVarFloat(playerid, "Y") + 1.0);
	    else if(GetPVarInt(playerid, "Mode") == 1) SetPVarFloat(playerid, "H", GetPVarFloat(playerid, "H") + 1.0);

	    TDS[tdid] = TextDrawCreate(GetPVarFloat(playerid, "X"), GetPVarFloat(playerid, "Y"), tdname);
	    TextDrawFont(TDS[tdid], 4);
	    TextDrawTextSize(TDS[tdid], GetPVarFloat(playerid, "W"), GetPVarFloat(playerid, "H"));
	    TextDrawShowForPlayer(playerid, TDS[tdid]);
	}
	else if(ud < 0)
	{
	    new tdid = GetPVarInt(playerid, "TDID");
	    TextDrawHideForPlayer(playerid, TDS[tdid]);
	    TextDrawDestroy(TDS[tdid]);

		new tdname[30];
		GetPVarString(playerid, "TDNAME", tdname, sizeof(tdname));

	    if(GetPVarInt(playerid, "Mode") == 0) SetPVarFloat(playerid, "Y", GetPVarFloat(playerid, "Y") - 1.0);
	    else if(GetPVarInt(playerid, "Mode") == 1) SetPVarFloat(playerid, "H", GetPVarFloat(playerid, "H") - 1.0);

	    TDS[tdid] = TextDrawCreate(GetPVarFloat(playerid, "X"), GetPVarFloat(playerid, "Y"), tdname);
	    TextDrawFont(TDS[tdid], 4);
	    TextDrawTextSize(TDS[tdid], GetPVarFloat(playerid, "W"), GetPVarFloat(playerid, "H"));
	    TextDrawShowForPlayer(playerid, TDS[tdid]);
	}
	else if(lr > 0)
	{
	    new tdid = GetPVarInt(playerid, "TDID");
	    TextDrawHideForPlayer(playerid, TDS[tdid]);
	    TextDrawDestroy(TDS[tdid]);

		new tdname[30];
		GetPVarString(playerid, "TDNAME", tdname, sizeof(tdname));

	    if(GetPVarInt(playerid, "Mode") == 0) SetPVarFloat(playerid, "X", GetPVarFloat(playerid, "X") + 1.0);
	    else if(GetPVarInt(playerid, "Mode") == 1) SetPVarFloat(playerid, "W", GetPVarFloat(playerid, "W") + 1.0);

	    TDS[tdid] = TextDrawCreate(GetPVarFloat(playerid, "X"), GetPVarFloat(playerid, "Y"), tdname);
	    TextDrawFont(TDS[tdid], 4);
	    TextDrawTextSize(TDS[tdid], GetPVarFloat(playerid, "W"), GetPVarFloat(playerid, "H"));
	    TextDrawShowForPlayer(playerid, TDS[tdid]);
	}
	else if(lr < 0)
	{
	    new tdid = GetPVarInt(playerid, "TDID");
	    TextDrawHideForPlayer(playerid, TDS[tdid]);
	    TextDrawDestroy(TDS[tdid]);

		new tdname[30];
		GetPVarString(playerid, "TDNAME", tdname, sizeof(tdname));

	    if(GetPVarInt(playerid, "Mode") == 0) SetPVarFloat(playerid, "X", GetPVarFloat(playerid, "X") - 1.0);
	    else if(GetPVarInt(playerid, "Mode") == 1) SetPVarFloat(playerid, "W", GetPVarFloat(playerid, "W") - 1.0);

	    TDS[tdid] = TextDrawCreate(GetPVarFloat(playerid, "X"), GetPVarFloat(playerid, "Y"), tdname);
	    TextDrawFont(TDS[tdid], 4);
	    TextDrawTextSize(TDS[tdid], GetPVarFloat(playerid, "W"), GetPVarFloat(playerid, "H"));
	    TextDrawShowForPlayer(playerid, TDS[tdid]);
	}
	return 1;
}
stock strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' ')) index++;
	new offset = index, result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}