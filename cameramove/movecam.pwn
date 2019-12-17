#include <a_samp>
#include <a_cam>

public OnFilterScriptInit()
{
	print("Camera managment by Leopard (2008)");
	print(" Loaded.");
	return 1;
}

public OnFilterScriptExit()
{
	print("Camera managment by Leopard (2008)");
	print(" Unloaded.");
	return 1;
}

public OnPlayerConnect(playerid)
{
	Camera_Join(playerid)
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	Camera_Leave(playerid)
	return 1;
}



public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[30];
    new idx;
    cmd = strtok(cmdtext, idx);
	if(strcmp(cmd, "/setcampos", true) == 0)
	{
		new tmp[30];
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFFFFFFAA, "Usage: \"/setcampos <id>\"");
			return 1;
		}
		new value = strval(tmp);
		if(value >= 0 || value <= GetMaxPlayers())
		{
			new id = value;
			if(!IsPlayerConnected(id))
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "Player: Not connected.");
				return 1;
			}
			new Float:x, Float:y, Float:z;
			GetPlayerPos(id, x, y, z);
			SetCameraPosForPlayer(playerid, x, y, z);
			return 1;
		}
		SendClientMessage(playerid, 0xFFFFFFAA, "Not an ID.");
		return 1;
	}
	if(strcmp(cmd, "/setcamlook", true) == 0)
	{
		new tmp[30]
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFFFFFFAA, "Usage: \"/setcamlook <id>\"");
			return 1;
		}
		new value = strval(tmp);
		if(value >= 0 || value <= GetMaxPlayers())
		{
			new id = value;
			if(!IsPlayerConnected(id))
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "Player: Not connected.");
				return 1;
			}
			new Float:x, Float:y, Float:z;
			GetPlayerPos(id, x, y, z);
			SetCameraLookAtForPlayer(playerid, x, y, z);
			return 1;
		}
		SendClientMessage(playerid, 0xFFFFFFAA, "Not an ID.");
		return 1;
	}
	if(strcmp(cmd, "/movecam", true) == 0)
	{
		new tmp[30]
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFFFFFFAA, "Usage: \"/movecam <id> <optional:speed>\"");
			return 1;
		}
		new value = strval(tmp);
		if(value >= 0 && value <= GetMaxPlayers())
		{
			if(!IsPlayerConnected(value))
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "Player: Not connected.");
				return 1;
			}
		}
		new tmp2[30];
		tmp2 = strtok(cmdtext, idx);
		if(!strlen(tmp2))
		{
			new Float:x, Float:y, Float:z;
			GetPlayerPos(value, x, y, z);
			MoveCameraPosForPlayer(playerid, x, y, z, 2);
			return 1;
		}
		new Float:x, Float:y, Float:z;
		GetPlayerPos(value, x, y, z);
		MoveCameraPosForPlayer(playerid, x, y, z, strval(tmp2));
		return 1;
	}
	if(strcmp(cmd, "/shake", true) == 0)
	{
		new tmp[30];
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFFFFFFAA, "Usage: \"/shake <time>\"");
			return 1;
		}
		ShakeCameraForPlayer(playerid, strval(tmp), 50, 1);
		return 1;
	}
	if(strcmp(cmd, "/follow", true) == 0)
	{
		new tmp[30];
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFFFFFFAA, "Usage: \"/follow <id>\"");
			return 1;
		}
		SetCameraFollowPlayerForPlayer(playerid, strval(tmp), 10*1000);
		return 1;
	}
	if(strcmp(cmd, "/followcar", true) == 0)
	{
		new tmp[30];
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFFFFFFAA, "Usage: \"/followcar <vehicleid>\"");
			return 1;
		}
		SetCameraFollowVehicleForPlayer(playerid, strval(tmp), 10*1000);
		return 1;
	}
	if(strcmp(cmdtext, "/resetcam", true) == 0)
	{
		ResetCameraForPlayer(playerid);
		return 1;
	}
	if(strcmp(cmd, "/onjoin", true) == 0)
	{
		new tmp[30];
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFFFFFFAA, "Usage: \"/onjoin <id>\"");
			return 1;
		}
		Camera_Join(strval(tmp))
		return 1;
	}
	return 0;
}


strtok( const string[], &index, const seperator[] = " " )
{
	new
		index2,
		result[ 30 ];
 
	index2 =  strfind(string, seperator, false, index);
 
 
	if(index2 == -1)
	{
		if(strlen(string) > index)
		{
			strmid(result, string, index, strlen(string), 30);
			index = strlen(string);
		}
		return result; // This string is empty, probably, if index came to an end
	}
	if(index2 > (index + 29))
	{
		index2 = index + 29;
		strmid(result, string, index, index2, 30);
		index = index2;
		return result;
	}
	strmid(result, string, index, index2, 30);
	index = index2 + 1;
	return result;
}