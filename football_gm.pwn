#include <a_samp>

#define version 1

#define POWER_PILL 1241

#define COLOR_RED 0xAA3333AA

#define KICK_NORMAL 1
#define KICK_HARD 2

#define TEAM_NORTH 3
#define TEAM_SOUTH 4

#define goal_south_x 1532.1807
#define goal_south_y -2543.4336
#define goal_south_z 13.5469

#define goal_north_x 1439.2238
#define goal_north_y -2543.0298
#define goal_north_z 13.5469

#define goal_middle_x 1489.0088
#define goal_middle_y -2543.4282
#define goal_middle_z 12.8469

#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

new ball;
new shoot;

new IsOnFootball[MAX_PLAYERS];
new Shooted[MAX_PLAYERS];
new Shooter[MAX_OBJECTS];
new Typer[MAX_OBJECTS];
new Replay;
new pick[MAX_PLAYERS];

new Text:OverMovie;
new Text:UnderMovie;

enum pos
{
	Float:X,
	Float:Y,
	Float:Z
};

new TMPOS[MAX_PLAYERS][pos];

forward ShootTimer();
forward ShootedOnce(playerid, Float:x, Float:y, Float:z);
forward IsObjectInArea(objectid, Float:maxx, Float:minx, Float:maxy, Float:miny); //By Alex "Y_Less" Cole
forward IsPlayerInArea(playerid, Float:maxx, Float:minx, Float:maxy, Float:miny); //By Alex "Y_Less" Cole
forward OnPlayerKickBall(playerid, type);
forward OnGoal(team);

new Float:kickX, Float:kickY, Float:kickZ, Float:kickAngle;

main()
{

}

public OnGameModeInit()
{
	printf("Loaded - V%d", version);
	
	UsePlayerPedAnims();
	ball = CreateObject(1598,  goal_middle_x, goal_middle_y, goal_middle_z, 0.0000, 0.0000, 0.0000);			//beachball
	
	CreateObject(3452,1544.027,-2540.660,15.571,0.0,0.0,90.705);
	CreateObject(3452,1483.640,-2577.291,15.521,0.0,0.0,0.0);
	CreateObject(3452,1510.057,-2577.358,15.721,0.0,0.0,0.0);
	CreateObject(3452,1461.698,-2577.445,15.771,0.0,0.0,0.0);
	CreateObject(3453,1434.601,-2571.372,15.771,0.0,0.0,-90.937);
	CreateObject(3452,1427.863,-2544.291,15.771,0.0,0.0,-89.218);
	CreateObject(3452,1427.941,-2527.419,15.771,0.0,0.0,-90.077);
	CreateObject(3453,1433.384,-2514.618,15.729,0.0,0.0,-179.295);
	CreateObject(3452,1459.485,-2508.066,15.779,0.0,0.0,-179.063);
	CreateObject(3452,1487.802,-2507.658,15.779,0.0,0.0,-179.063);
	CreateObject(3452,1513.825,-2507.204,15.779,0.859,0.0,-179.063);
	CreateObject(3453,1538.690,-2570.954,15.621,0.0,0.0,0.0);
	CreateObject(3453,1537.043,-2512.014,15.604,0.0,0.0,91.796);
	CreateObject(980,1535.276,-2532.845,15.320,0.0,0.0,90.705);
	CreateObject(980,1525.038,-2568.063,15.320,0.0,0.0,0.0);
	CreateObject(980,1513.720,-2568.132,15.320,0.0,0.0,0.0);
	CreateObject(980,1502.780,-2568.054,15.320,0.0,0.0,0.0);
	CreateObject(980,1492.308,-2568.157,15.220,0.0,0.0,0.0);
	CreateObject(980,1481.170,-2568.239,15.320,0.0,0.0,0.0);
	CreateObject(980,1470.248,-2568.104,15.320,0.0,0.0,0.0);
	CreateObject(980,1459.062,-2568.021,15.320,0.0,0.0,0.0);
	CreateObject(980,1447.861,-2568.177,15.320,0.0,0.0,0.0);
	CreateObject(980,1439.711,-2563.666,15.320,0.0,0.0,-53.749);
	CreateObject(980,1437.367,-2552.002,15.570,5.157,0.0,-91.564);
	CreateObject(980,1436.833,-2540.564,15.320,5.157,0.0,-91.564);
	CreateObject(980,1437.640,-2529.687,15.320,5.157,0.0,-91.564);
	CreateObject(980,1443.140,-2522.046,15.320,-0.859,0.0,-159.064);
	CreateObject(980,1453.606,-2520.218,15.320,-0.859,0.0,-178.204);
	CreateObject(980,1464.435,-2519.612,15.320,-0.859,0.0,-178.204);
	CreateObject(980,1475.058,-2519.011,15.320,-0.859,0.0,-178.204);
	CreateObject(980,1486.275,-2518.757,15.320,-0.859,0.0,-178.204);
	CreateObject(980,1495.352,-2518.321,15.320,-0.859,0.0,-178.204);
	CreateObject(980,1505.998,-2518.038,15.320,-0.859,0.0,-178.204);
	CreateObject(980,1515.372,-2517.864,15.320,-0.859,0.0,-178.204);
	CreateObject(980,1525.066,-2517.443,15.320,-0.859,0.0,-178.204);
	CreateObject(980,1533.204,-2522.376,15.320,-0.859,0.0,-245.704);
	CreateObject(1251,1441.732,-2548.031,12.177,-93.679,-6.875,-1.719);
	CreateObject(1251,1441.543,-2537.414,12.052,-91.960,1.719,-1.719);
	CreateObject(1278,1489.452,-2589.215,26.736,0.0,0.0,-179.691);
	CreateObject(1278,1418.297,-2549.476,26.736,0.0,0.0,-266.958);
	CreateObject(1278,1451.966,-2498.035,26.744,0.0,0.0,-349.464);
	CreateObject(1278,1515.904,-2497.030,26.744,0.0,0.0,-353.761);
	CreateObject(1278,1554.645,-2530.070,26.736,0.0,0.0,-446.262);
	CreateObject(980,1535.381,-2544.007,15.320,0.0,0.0,90.705);
	CreateObject(980,1535.319,-2555.356,15.320,0.0,0.0,90.705);
	CreateObject(980,1533.454,-2564.552,15.220,0.0,0.0,56.955);
	CreateObject(974,1438.108,-2537.305,12.675,0.0,-0.859,0.859);
	CreateObject(974,1438.321,-2547.918,12.475,0.0,-0.859,-0.859);
	CreateObject(974,1438.225,-2545.204,15.378,-90.241,-1.719,-0.859);
	CreateObject(974,1438.200,-2540.105,15.459,-90.241,-1.719,-0.859);
	CreateObject(1251,1530.907,-2538.137,12.652,-91.960,1.719,-1.719);
	CreateObject(1251,1530.883,-2548.228,12.727,-90.241,-86.803,-42.972);
	CreateObject(1251,1530.944,-2541.373,16.082,0.0,-53.285,0.0);
	CreateObject(1251,1530.943,-2544.895,16.102,0.0,-53.285,0.0);
	CreateObject(974,1534.328,-2548.188,13.325,0.0,0.0,0.0);
	CreateObject(974,1534.237,-2538.039,13.350,0.0,0.0,0.859);
	CreateObject(974,1534.308,-2540.675,16.075,-90.241,3.438,2.578);
	CreateObject(974,1534.251,-2545.500,16.114,-90.241,3.438,3.438);
	CreateObject(13631,1477.495,-2542.759,37.856,0.0,179.622,0.0);
	CreateObject(13650,1509.915,-2541.263,12.217,0.0,0.0,0.0);
	CreateObject(13650,1476.920,-2514.444,14.517,0.0,0.0,0.0);
	CreateObject(13650,1453.069,-2547.117,12.667,0.0,0.0,0.0);
	CreateObject(13650,1504.250,-2567.082,14.592,0.0,0.0,0.0);
	CreateObject(2735,1448.409,-2520.476,13.180,0.0,0.0,0.0);
	CreateObject(7304,1494.209,-2585.036,23.317,0.0,0.0,-90.077);
	CreateObject(7304,1493.675,-2497.870,22.997,0.0,0.0,91.564);
	CreateObject(9527,1543.910,-2580.678,21.094,0.0,0.0,219.689);
	CreateObject(9527,1547.333,-2507.180,21.581,0.0,0.0,309.689);
	CreateObject(1251,1441.624,-2544.491,15.447,-180.482,-11.173,0.0);
	CreateObject(1251,1441.645,-2540.663,15.433,-180.482,-11.173,0.0);
	CreateObject(980,1535.464,-2542.259,18.885,0.0,0.0,90.705);
	CreateObject(980,1535.639,-2551.742,16.523,1.719,-27.502,90.705);
	CreateObject(980,1535.169,-2532.727,16.453,1.719,-27.502,-78.045);
	CreateObject(980,1437.249,-2542.715,18.236,0.0,0.0,90.705);
	CreateObject(980,1437.144,-2533.292,15.836,1.719,-27.502,-92.656);
	CreateObject(980,1437.728,-2552.245,15.939,1.719,-27.502,-261.406);
	
	OverMovie = TextDrawCreate(1.000000,1.000000,"_");
	UnderMovie = TextDrawCreate(-7.000000,341.000000,"_");
	TextDrawUseBox(OverMovie,1);
	TextDrawBoxColor(OverMovie,0x000000ff);
	TextDrawTextSize(OverMovie,640.000000,-13.000000);
	TextDrawUseBox(UnderMovie,1);
	TextDrawBoxColor(UnderMovie,0x000000ff);
	TextDrawTextSize(UnderMovie,650.000000,-7.000000);
	TextDrawAlignment(OverMovie,0);
	TextDrawAlignment(UnderMovie,0);
	TextDrawBackgroundColor(OverMovie,0x000000ff);
	TextDrawBackgroundColor(UnderMovie,0x000000ff);
	TextDrawFont(OverMovie,3);
	TextDrawLetterSize(OverMovie,1.100000,11.500000);
	TextDrawFont(UnderMovie,3);
	TextDrawLetterSize(UnderMovie,10.100000,11.700000);
	TextDrawColor(OverMovie,0xffffffff);
	TextDrawColor(UnderMovie,0xffffffff);
	TextDrawSetOutline(OverMovie,1);
	TextDrawSetOutline(UnderMovie,1);
	TextDrawSetProportional(OverMovie,1);
	TextDrawSetProportional(UnderMovie,1);
	TextDrawSetShadow(OverMovie,1);
	TextDrawSetShadow(UnderMovie,1);
	
	AddPlayerClass(0, 1473.8656,-2543.1316,13.5469, 268.546, 0,0,0,0,0,0); //north
	AddPlayerClass(0, 1500.8422,-2543.8962,13.5469, 90.000, 0,0,0,0,0,0); //south
		
	shoot = SetTimer("ShootTimer", 500, 1);
	SetGameModeText("Football");
	SendRconCommand("hostname Leopard's Football [0.2x]");
	return 1;
}

public OnPlayerConnect(playerid)
{
	Shooted[playerid] = 0;
	IsOnFootball[playerid] = 1;
	new name[24];
	new string[50];
	GetPlayerName(playerid, name, 24);
	format(string, sizeof string, "%s joined", name);
	SendClientMessageToAll(0xFFFFFFAA, string);
	TextDrawShowForPlayer(playerid, OverMovie);
	TextDrawShowForPlayer(playerid, UnderMovie);
	PlayerPlaySound(playerid, 1062, 0.0, 0.0, 0.0);
	return 1;
}


public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(pick[playerid] == pickupid)
	{
		DestroyPickup(pickupid);
	}
}

stock SetBallPos(Float:x, Float:y, Float:z)
{
	DestroyObject(ball);
	ball = CreateObject(1598, x, y, z, 0.0000, 0.0000, 0.0000);			//beachball
}

public OnPlayerRequestClass(playerid, classid)
{
	if(classid == 0)
	{
		GameTextForPlayer(playerid, "~n~~r~North~n~~<~ or ~>~ to change team",  5, 4000);
	}
	if(classid == 1)
	{
		GameTextForPlayer(playerid, "~n~~g~South~n~~<~ or ~>~ to change team",  5, 4000);
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	TextDrawHideForPlayer(playerid, OverMovie);
	TextDrawHideForPlayer(playerid, UnderMovie);
	PlayerPlaySound(playerid, 1063, 0.0, 0.0, 0.0);
	SetTimerEx("WaitFunction", 500, 0, "i", playerid);
	return 1;
}


forward WaitFunction(playerid);
public WaitFunction(playerid)
{
	PlayerPlaySound(playerid, 1142, 0.0, 0.0, 0.0);
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp(cmdtext, "/test", true) == 0)
	{
		new string[50];
		format(string, 50, "IsOnFootball=%d", IsOnFootball[playerid]);
		SendClientMessage(playerid, 0xFFFFFFAA, string);
		return 1;
	}
	dcmd(sound, 5, cmdtext);
	return 0;
}

dcmd_sound(playerid, params[])
{
	if(strlen(params))
	{
		new soundid = strval(params);
		PlayerPlaySound(playerid, soundid, 0.0, 0.0, 0.0);
		return 1;
	}
	else
	{
		SendClientMessage(playerid, 0xFFFFFFAA, "Usage: /soundid <id>");
	}
	return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_FIRE)
	{
		if(IsOnFootball[playerid] == 1)
		{
			TogglePlayerControllable(playerid, 1);
			new Float:oX, Float:oY, Float:oZ;
			GetObjectPos(ball, oX, oY, oZ);
			new string[50];
			format(string, 50, "ObjectPos: %.2f, %.2f, %.2f", oX, oY, oZ);
			SendClientMessage(playerid, 0xFFFFFFAA, string);
			if(PlayerToPoint(playerid, oX, oY, oZ, 2))
			{
				if(Shooted[playerid] == 0)
				{
//					ApplyAnimation(playerid,"FIGHT_D","FightD_1",4.1,0,0,0,0,0);
					ShootBall(playerid);
					OnPlayerKickBall(playerid, KICK_NORMAL);
					return 1;
				}
				if(Shooted[playerid] == 1)
				{
					ShootHardBall(playerid);
					OnPlayerKickBall(playerid, KICK_HARD);
					return 1;
				}
				if(Shooted[playerid] == 2)
				{
					Shooted[playerid] = 0;
					return 1;
				}
			}
		}
	}
	return 1;
}


public OnPlayerKickBall(playerid, type)
{
//	TogglePlayerControllable(playerid, 1);
	Replay = 0;
	Shooter[ball] = 0;
	Shooter[ball] = playerid;
	Typer[ball] = type;
	GetPlayerPos(playerid, kickX, kickY, kickZ);
	GetPlayerFacingAngle(playerid, kickAngle);
}

public OnGoal(team)
{
	if(Shooter[ball] != INVALID_PLAYER_ID)
	{
		if(Replay == 0)
		{
			Replay = 1;
			new playerid=Shooter[ball];
			ToggleAllBallersControllable(false);
			SetPlayerPos(playerid, kickX, kickY, kickZ);
			SetPlayerFacingAngle(playerid, kickAngle);
			TogglePlayerControllable(playerid, 0);
			GetXYBehindPlayer(playerid, kickX, kickY, 1.5);
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);
			GetXYInFrontOfPlayer(playerid, x, y, 0.70);
			SetBallPos(x, y, z-0.65);
			for(new i = 0; i < GetMaxPlayers(); i++)
			{
				if(IsOnFootball[i] == 1)
				{
					SetPlayerCameraPos(i, kickX, kickY, kickZ+2);
					SetPlayerCameraLookAt(i, x, y, z+1);
				}
			}
			if(Typer[ball] == KICK_NORMAL) ShootBall(playerid);
			else if(Typer[ball] == KICK_HARD) ShootHardBall(playerid);
		}
		else if(Replay == 1) //replay done
		{
			Replay = 0;
			StopObject(ball);
			for(new i = 0; i < GetMaxPlayers(); i++)
			{
				if(IsOnFootball[i] == 1)
				{
					SetCameraBehindPlayer(i);
					TogglePlayerControllable(i, 1);
					ResetBall();
				}
			}
		}
	}
}


stock GameTextForBallers(msg[])
{
	for(new i = 0; i < GetMaxPlayers(); i++) if(IsOnFootball[i] == 1) GameTextForPlayer(i, msg, 4000, 4);
}

stock ToggleAllBallersControllable(bool:toggle)
{
	for(new i = 0; i < GetMaxPlayers(); i++) if(IsOnFootball[i] == 1) TogglePlayerControllable(i, toggle);
}

stock ResetBall()
{
	DestroyObject(ball);
	ball = CreateObject(1598, goal_middle_x, goal_middle_y, goal_middle_z, 0.0000, 0.0000, 0.0000);
	for(new i = 0; i < GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i) && IsOnFootball[i] == 1)
		{
			Shooted[i] = 0;
			TMPOS[i][X] = goal_middle_x;
			TMPOS[i][Y] = goal_middle_y;
			TMPOS[i][Z] = goal_middle_z;
		}
	}
	GameTextForBallers("FOOTBALL RESET!!");
}

public ShootTimer()
{
	for(new i = 0; i < GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i))
		{
			if(IsPlayerInArea(i, 1534.0, 1438.0, -2517.0, -2568.0))
			{
				IsOnFootball[i] = 1;
			}
		}
	}
	if(!IsObjectInArea(ball, 1534.0, 1438.0, -2517.0, -2568.0))
	{
		ResetBall();
		GameTextForBallers("BALL OUT!!");
	}
	else if(IsObjectInCircle(ball, goal_south_x, goal_south_y, 3))
	{
		ResetBall();
		GameTextForBallers("NORTH GOAL!!");
		OnGoal(TEAM_NORTH);
	}
	else if(IsObjectInCircle(ball, goal_north_x, goal_north_y, 3))
	{
		ResetBall();
		GameTextForBallers("SOUTH GOAL!!");
		OnGoal(TEAM_SOUTH);
	}
	new Float:x, Float:y, Float:z;
	GetObjectPos(ball, x, y, z);
	SetObjectPos(ball, x, y, z);
}

public OnGameModeExit()
{
	KillTimer(shoot);
}

stock DestroyObjects(...)
{
	for(new i = 1, j = numargs(); i < j; i++) DestroyObject(getarg(i));
}

stock ShootBall(playerid)
{
	TogglePlayerControllable(playerid, 0);
	ApplyAnimation(playerid,"FIGHT_D","FightD_1",4.1,0,0,0,0,0);
			
	Shooted[playerid] = 1;
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	GetXYInFrontOfPlayer(playerid, x, y, 8);
					
	GetPlayerPos(playerid, TMPOS[playerid][X], TMPOS[playerid][Y], TMPOS[playerid][Z]);
	GetXYInFrontOfPlayer(playerid, TMPOS[playerid][X], TMPOS[playerid][Y], 8);

	SetTimerEx("ShootedOnce", 350, 0, "ifff", playerid, x, y, z);
}

stock ShootHardBall(playerid)
{
	TogglePlayerControllable(playerid, 0);
	ApplyAnimation(playerid,"FIGHT_D","FightD_G",4.1,0,0,0,0,0);
	Shooted[playerid] = 2;
}


public ShootedOnce(playerid, Float:x, Float:y, Float:z)
{
	if(Shooted[playerid] == 1) //once shot, not double click
	{
		PlayerPlaySound(playerid, 1130, x, y, z);
		MoveObject(ball, x, y, z-0.65, 7);
		TogglePlayerControllable(playerid, 1);
		SetTimerEx("Slowing", 400, 0, "i", playerid);
		Shooted[playerid] = 0;
	}
	if(Shooted[playerid] == 2)//two shots, double click
	{
		GetPlayerPos(playerid, x, y, z);
		GetXYInFrontOfPlayer(playerid, x, y, 14);
		
		GetPlayerPos(playerid, TMPOS[playerid][X], TMPOS[playerid][Y], TMPOS[playerid][Z]);
		GetXYInFrontOfPlayer(playerid, TMPOS[playerid][X], TMPOS[playerid][Y], 16);
		
//		PlayerPlaySound(playerid, 1130, x, y, z);
		SetTimerEx("Back", 300, 0, "i", playerid);
		
		MoveObject(ball, x, y, z+0.5, 12);
		TogglePlayerControllable(playerid, 1);
		Shooted[playerid] = 0;
	}
}

forward Slowing(playerid);
forward Slowing2(playerid);
forward Back(playerid);

public Slowing(playerid)
{
	MoveObject(ball, TMPOS[playerid][X], TMPOS[playerid][Y], TMPOS[playerid][Z]-0.65, 5);
	SetTimerEx("Slowing2", 200, 0, "i", playerid);
}

public Slowing2(playerid)
{
	MoveObject(ball, TMPOS[playerid][X], TMPOS[playerid][Y], TMPOS[playerid][Z]-0.65, 3);
}

public Back(playerid)
{
	MoveObject(ball, TMPOS[playerid][X], TMPOS[playerid][Y], TMPOS[playerid][Z]-0.65, 12);
	SetTimerEx("Slowing", 200, 0, "i", playerid);
}

forward Float:GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance);
forward Float:GetXYBehindPlayer(playerid, &Float:x, &Float:y, Float:distance);

public Float:GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	if (IsPlayerInAnyVehicle(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	else GetPlayerFacingAngle(playerid, a);
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
    return a;
}

public Float:GetXYBehindPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
    new Float:a;
    GetPlayerPos(playerid, x, y, a);
	if (IsPlayerInAnyVehicle(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	else GetPlayerFacingAngle(playerid, a);
    x -= (distance * floatsin(-a, degrees));
    y -= (distance * floatcos(-a, degrees));
    return a;
}

GetPlayerDistanceToPointEx(playerid,Float:x,Float:y,Float:z)
{
	new Float:x1,Float:y1,Float:z1;
	new Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	tmpdis = floatsqroot(floatpower(floatabs(floatsub(x,x1)),2)+floatpower(floatabs(floatsub(y,y1)),2)+floatpower(floatabs(floatsub(z,z1)),2));
	return floatround(tmpdis);
}

stock IsObjectInCircle(Objectid, Float:xPos, Float:yPos, Float:radius)
{
	new Float:PPos[3];
	GetObjectPos(Objectid, PPos[0], PPos[1], PPos[2]);
	if (GetDistance(xPos, PPos[0], yPos, PPos[1]) < radius)
		return true;
	return false;
}

stock GetDistance(Float:xPos, Float:xPos2, Float:yPos, Float:yPos2)
{
	new Float:dist = floatabs(floatsqroot(floatpower(xPos - xPos2, 2) + floatpower(yPos - yPos2, 2)));
	return floatround(dist);
}


public IsObjectInArea(objectid, Float:maxx, Float:minx, Float:maxy, Float:miny)
{
	new Float:x, Float:y, Float:z;
	GetObjectPos(objectid, x, y, z);
	if (x > minx && x < maxx && y > miny && y < maxy) return 1;
	else return 0;
}

public IsPlayerInArea(playerid, Float:maxx, Float:minx, Float:maxy, Float:miny)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if (x > minx && x < maxx && y > miny && y < maxy) return 1;
	else return 0;
}

PlayerToPoint(playerid,Float:x,Float:y,Float:z,radius)
{
	if(GetPlayerDistanceToPointEx(playerid,x,y,z) < radius)
	{
		return 1;
	}
	return 0;
}

