#include <a_samp>
//$ region Zombie defines
	#define PRESS 123
	#define HOLD 456
	#define MAX_ZOMBIES 100
	#define brazo1 1
	#define brazo2 2
	#define pierna1 4
	#define pierna2 8
	#define delay 500

//$ endregion Zombie defines
//$ region Zombie forwards
	forward HoldingFire();
	forward zombieAtaca(playerid);
	forward attacknearest();
	forward QuitarArmasZombie(playerid);
	forward DevolverArmasZombie(playerid);
	forward CreateRandomZombie();

//$ endregion Zombie forwards
//$ region Zombie enums
	enum weapParts{
		WeapId,
		allow,
		Float:range,
		Float:wide,
		damageMin,
		damageMax,
		cutting,
		instaGib,
		continua,
		mnsg[150]
	};
	enum zombiPos{
		partModel,
		Float:RelX,
		Float:RelY,
		Float:RelZ,
		Float:RelrX,
		Float:RelrY,
		Float:RelrZ
	}
	enum zpart{
		rLegZ,
		rArmZ,
		torsoZ,
		lArmZ,
		headZ,
		lLegZ
	}
	enum zombiParts{
		rArm,
		lArm,
		rLeg,
		lLeg,
		head,
		torso,
		pedazos,
		HP,
		Float:ArmAngle,
		Float:ArmStatus,
		Float:angulo,
		Float:speed,
		LegsH,
		undead,
		target
	};
	enum zArm{
		Float:AZ,
		Float:AA
	};
	enum tipo{
		der,
		izq
	};
	enum WeaponType{
		pWeapId,
		pAmmo
	};

//$ endregion Zombie enums
//$ region Zombie vairables
	new Ticket[MAX_PLAYERS];
	new weapL[55][weapParts]={
		//  ID                  	allow	range   wide	dMin	dMax	cutting	insGib	continua    msng
		{0,                     true,   1.0,    45.0,    5,		10,    	false,	false,	false,  "~n~~n~~n~~n~~n~~n~~n~~w~Punch!!!"},
		{WEAPON_BRASSKNUCKLE,	true,	1.5,	45.0,	5,		15,		false,	false,	false,	"~n~~n~~n~~n~~n~~n~~n~~y~Plack~w~!!!"},
		{WEAPON_GOLFCLUB,		true,	2.0,	35.0,	20,		25,		false,	false,	false,	"~n~~n~~n~~n~~n~~n~~n~~w~Fiuuuff!!! ~b~~h~Fiuuuff~w~!!!"},
		{WEAPON_NITESTICK,		true,	1.5,	35.0,	10,		15,		false,	false,	false,	"~n~~n~~n~~n~~n~~n~~n~~b~~h~Plafff~w~!!!"},
		{WEAPON_KNIFE,			true,	1.5,	15.0,	10,		15,		false,	false,	false,	"~n~~n~~n~~n~~n~~n~~n~~r~Fisss~w~!!!"},
		{WEAPON_BAT,			true,	2.0,	35.0,	10,		15,		false,	false,	false,	"~n~~n~~n~~n~~n~~n~~n~~g~~h~Paffffff~w~!!!"},
		{WEAPON_SHOVEL,			true,	2.0,	35.0,	10,		25,		true,	false,	false,	"~n~~n~~n~~n~~n~~n~~n~~r~~h~~h~PlanK~w~!!!"},
		{WEAPON_POOLSTICK,		true,	2.0,	35.0,	10,		15,		false,	false,	false,	"~n~~n~~n~~n~~n~~n~~n~~g~~h~Paffffff~w~!!!"},
		{WEAPON_KATANA,			true,	2.0,	45.0,	20,		45,		true,	false,	false,	"~n~~n~~n~~n~~n~~n~~n~~b~SWIFT~w~! ~b~SWIFT~w~!"},
		{WEAPON_CHAINSAW,		true,	2.5,	35.0,	20,		35,		true,	false,	true,	"~n~~n~~n~~n~~n~~n~~n~~g~BRRRRRRRNNNNNN~w~!!!!"},
		{WEAPON_DILDO,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_DILDO2,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_VIBRATOR,		false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_VIBRATOR2,		false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_FLOWER,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_CANE,			true,	2.0,	35.0,	10,		15,		false,	false,	false,	"~n~~n~~n~~n~~n~~n~~n~~g~~h~Paffffff~w~!!!"},
		{WEAPON_GRENADE,		false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_TEARGAS,		false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_MOLTOV,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{-1,					false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{-1,					false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{-1,					false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_COLT45,			true,	20.0,	7.0,	10,		15,		false,	false,	true,	"~n~~n~~n~~n~~n~~n~~n~~r~Bang~w~!!~r~Bang~w~!!"},
		{WEAPON_SILENCED,		true,	20.0,	3.0,	10,		15,		false,	false,	false,	"~n~~n~~n~~n~~n~~n~~n~~r~Piuufff~w~!!"},
		{WEAPON_DEAGLE,			true,	25.0,	3.0,	15,		20,		false,	true,	true,	"~n~~n~~n~~n~~n~~n~~n~~r~Baaang~w~!!"},
		{WEAPON_SHOTGUN,		true,	18.0,	7.0,	10,		25,		true,	true,	true,	"~n~~n~~n~~n~~n~~n~~n~~r~BUM~w~!!!!"},
		{WEAPON_SAWEDOFF,		true,	12.0,	10.0,	12,		18,		true,	true,	true,	"~n~~n~~n~~n~~n~~n~~n~~r~BUM~w~!!~r~BUM~w~!!"},
		{WEAPON_SHOTGSPA,		true,	18.0,	7.0,	25,		45,		true,	true,	true,	"~n~~n~~n~~n~~n~~n~~n~~r~BUUUM~w~!!!!"},
		{WEAPON_UZI,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_MP5,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_AK47,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_M4,				false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_TEC9,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_RIFLE,			true,	50.0,	2.0,	0,		50,		false,	true,	true,	"~n~~n~~n~~n~~n~~n~~n~~g~PUUUM~w~!!!!"},
		{WEAPON_SNIPER,			true,	100.0,	1.0,	0,		60,		false,	true,	false,	"~n~~n~~n~~n~~n~~n~~n~~g~PUUUUUUUUMMMMM~w~!!!!"},
		{WEAPON_ROCKETLAUNCHER,	false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_HEATSEEKER,		false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_FLAMETHROWER,	true,	8.0,	15.0,	10,		20,		false,	false,	true,	"~n~~n~~n~~n~~n~~n~~n~~r~Fuuu~y~uffffff~w~!!!!"},
		{WEAPON_MINIGUN,		true,	25.0,	3.0,	1,		99,		true,	true,	true,	"~n~~n~~n~~n~~n~~n~~n~~r~MUAJAJAJAJAJAJ~w~!!!!!"},
		{WEAPON_SATCHEL,		false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_BOMB,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_SPRAYCAN,		true,	2.0,	25.0,	10,		0,		false,	false,	true,	"~n~~n~~n~~n~~n~~n~~n~~y~FS~b~SS~r~SS~g~SS~y~SS~w~!!!"},
		{WEAPON_FIREEXTINGUISHER,true,	3.5,	15.0,	10,		0,		false,	false,	true,	"~n~~n~~n~~n~~n~~n~~n~~w~Fuuuusssshhh~b~!!!!"},
		{WEAPON_CAMERA,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{-1,					false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{-1,					false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_PARACHUTE,		false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{-1,					false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{-1,					false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_VEHICLE,		false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{-1,					false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{-1,					false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{-1,					false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_DROWN,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
		{WEAPON_COLLISION,		false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."}
	};
	new setNumber = 0;
	new set[6][3][2]={
		{{WEAPON_KATANA,1000},		{WEAPON_SHOTGUN,50},			{WEAPON_FIREEXTINGUISHER,500}},
		{{WEAPON_KATANA,1000},		{WEAPON_SILENCED,100},			{WEAPON_SAWEDOFF,25}},
		{{WEAPON_NITESTICK,1000},	{WEAPON_COLT45,100},			{WEAPON_SHOTGUN,25}},
		{{WEAPON_GOLFCLUB,1000},	{WEAPON_FIREEXTINGUISHER,400},	{WEAPON_FLAMETHROWER,50}},
		{{WEAPON_SHOVEL,1000},		{WEAPON_SHOTGSPA,100},			{WEAPON_RIFLE,25}},
		{{WEAPON_KNIFE,1000},		{WEAPON_SHOTGSPA,100},			{WEAPON_SNIPER,25}}
	};
	new NOFZombies=0;
	new TOTALZombies=10;
	new Float:Zspeed = 2.0;
	new ZTimerSpeed = 500;
	new Float:vaiven = 5.0;
	new Float:oX,Float:oY,Float:oZ;
	new zombie[MAX_ZOMBIES][zombiParts];
	new zombie1[zpart][zombiPos]={
		{2905,-0.115479,-0.023924, -1.280131, -90.000000, 90.000000,0.000000},
		{2906, -0.218995, 0.200928, -0.253135, 0.000000, 180.000000, 0.000000},
		{2907, -0.032227, -0.045897, -0.544213, 270.000000, 0.000000, 0.000000},
		{2906, 0.187987, 0.158448, -0.265793, 0.000000, 0.000000, 0.000000},
		{2908, 0.000000, 0.000000, 0.000000, 270.000000, 90.000000, 0.000000},
		{2905, 0.101074, -0.012694, -1.288253, 270.000000, 90.000000, 0.000000}
	};
	new zombie2[6][zombiPos]={
		{2905, 0.005614, -0.110107, -1.280131, -90.000000, 90.000000, 90.000000},
		{2906, -0.148926, -0.180663, -0.253135, 0.000000, 180.000000, 90.000000},
		{2907, 0.047852, -0.039061, -0.544213, 270.000000, 0.000000, 90.000000},
		{2906, -0.152343, 0.171387, -0.265793, 0.000000, 0.000000, 90.000000},
		{2908, 0.000000, 0.000000, 0.000000, 270.000000, 90.000000, 90.000000},
		{2905, 0.000977, 0.090332, -1.288253, 270.000000, 90.000000, 90.000000}
	};
	new A1[tipo][zArm]={
		{-0.253135,0.0},
		{-0.265793,0.0}
	};
	new A2[tipo][zArm]={
		{-0.359635, -90.0},
		{-0.338874, -90.0}
	};
	new TimerAtaca=-1;
	new TimerAPO=-1;
	new PlayerDeath[MAX_PLAYERS];
	new apocalipsis = false;
	new WeaponList[MAX_PLAYERS][12][WeaponType];
	new LastWeaponUsed[MAX_PLAYERS];
	new money[MAX_PLAYERS];
	new scorez=0;
	new scorep=0;

//$ endregion Zombie vairables
public OnFilterScriptExit(){
	cleanZombies();
	return 1;
}
public OnGameModeExit(){
    cleanZombies();
	return 1;
}
public OnPlayerSpawn(playerid){
    PlayerDeath[playerid]=false;
    if (apocalipsis)    {
    	ResetPlayerMoney(playerid);
		ResetPlayerWeapons(playerid);
 	 	GivePlayerWeapon(playerid,set[setNumber][0][0],set[setNumber][0][1]);
 	 	GivePlayerWeapon(playerid,set[setNumber][1][0],set[setNumber][1][1]);
 	 	GivePlayerWeapon(playerid,set[setNumber][2][0],set[setNumber][2][1]);
	}
	return 1;
}
public OnPlayerDeath(playerid, killerid, reason){
    PlayerDeath[playerid]=true;
	if (apocalipsis && killerid==INVALID_PLAYER_ID)	{
	    new tmp[255];
	    format(tmp,255,"~w~SCORE~n~~r~Zombies~w~: %d ~y~+1 ~n~~b~Humans~w~: %d",scorez,scorep);
	    scorez++;
	    GameTextForAll(tmp,2000,4);
	    attacknearest();
	}

	return 1;
}
public OnPlayerConnect(playerid){
	if (apocalipsis)	{
	    money[playerid]=GetPlayerMoney(playerid);
	    ResetPlayerMoney(playerid);
	    QuitarArmasZombie(playerid);
	}
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[]){
	new cmd[256];
	new tmp[255];
	new idx;
    cmd = strtok(cmdtext, idx);
    if (IsPlayerAdmin(playerid))
    {
		//$ region Zombie mod
			if 	(strcmp(cmd, "/zspeed", true)==0)	{
				tmp = strtok(cmdtext, idx);
				if	(!strlen(tmp))
				{
					SendClientMessage(playerid, 0xFFFFFFAA, "USE: /zspeed [speed]");
					return 1;
				}
				Zspeed=floatstr(tmp);
				return 1;
			}
			if 	(strcmp(cmd, "/ZTimerSpeed", true)==0)	{
				tmp = strtok(cmdtext, idx);
				if	(!strlen(tmp))
				{
					SendClientMessage(playerid, 0xFFFFFFAA, "USE: /ZTimerSpeed [timer speed]");
					return 1;
				}
				ZTimerSpeed=strval(tmp);
				OnPlayerCommandText(playerid, "/zstop");
				OnPlayerCommandText(playerid, "/zstart");
				return 1;
			}
			if (strcmp(cmd, "/zo", true)==0)	{
				new Float:pX,Float:pY,Float:pZ,Float:Ang;
				GetPlayerPos(playerid,pX,pY,pZ);
				GetPlayerFacingAngle(playerid,Ang);
				pX=pX+3.0*floatsin(-Ang,degrees);
				pY=pY+3.0*floatcos(-Ang,degrees);
				pZ=pZ+0.7;
				CrearZombie(pX,pY,pZ,Ang+180.0);
				return 1;
			}
			if 	(strcmp(cmd, "/zstart", true)==0)	{
				if (NOFZombies>0)
				{
					new id;
					tmp = strtok(cmdtext, idx);
					if	(!strlen(tmp))
					{
						id = playerid;
					}
					else
					{
						if (!IsPlayerConnected(strval(tmp)))
						{
							SendClientMessage(playerid, 0xFFFFFFAA, "That player is not conected!");
							return 1;
						}
						id = strval(tmp);
					}
					if (TimerAtaca!=-1){KillTimer(TimerAtaca);}
					for (new j=0;j<TOTALZombies;j++){zombie[j][target]=id;}
					TimerAtaca=SetTimer("zombieAtaca",ZTimerSpeed,1);
					return 1;
				}
				SendClientMessage(playerid, 0xFFFFFFAA, "There are no zombies");
				return 1;
			}
			if 	(strcmp(cmd, "/zstop", true)==0)	{
				if (NOFZombies>0)
				{
					if (TimerAtaca!=-1)
					{
						KillTimer(TimerAtaca);
					}
					for (new j=0;j<TOTALZombies;j++)
					{
						if (zombie[j][undead])
						{
							StopObject(zombie[j][head]);
							StopObject(zombie[j][torso]);
							StopObject(zombie[j][rArm]);
							StopObject(zombie[j][lArm]);
							StopObject(zombie[j][rLeg]);
							StopObject(zombie[j][lLeg]);
						}
					}
					return 1;
				}
				SendClientMessage(playerid, 0xFFFFFFAA, "There are no zombies");
				return 1;
			}
			if 	(strcmp(cmd, "/zclean", true)==0)	{
				cleanZombies();
				SendClientMessage(playerid, 0xFFFFFFAA, "There are no zombies anymore!");
				return 1;
			}
			if 	(strcmp(cmd, "/ttt", true)==0)	{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, 0xFFFFFFAA, "USO: /ttt [hora]");
					return 1;
				}
				new hora = strval(tmp);
				SetWorldTime(hora);
				format(tmp, sizeof(tmp), "Ahora la hora es: %d", hora);
				SendClientMessage(playerid, 0xFFFFFFAA, tmp);
				return 1;
			}
			if 	(strcmp(cmd, "/www", true)==0)	{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, 0xFFFFFFAA, "USO: /www [weather]");
					return 1;
				}
				new www = strval(tmp);
				SetWeather(www);
				format(tmp, sizeof(tmp), "Ahora el clima es: %d", www);
				SendClientMessage(playerid, 0xFFFFFFAA, tmp);
				return 1;
			}
			if 	(strcmp(cmd, "/zcantZombies", true)==0)	{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, 0xFFFFFFAA, "USO: /zcantZombies [cuantity]");
					return 1;
				}
				cleanZombies();
				TOTALZombies = strval(tmp);
				return 1;
			}
			if 	(strcmp(cmd, "/ambient", true)==0)	{
				SetWorldTime(0);
				SetWeather(8);
				return 1;
			}
			if 	(strcmp(cmd, "/apocalipsison", true)==0)	{
				apocalipsis = true;
				for (new i=0;i<MAX_PLAYERS;i++)
				{
					if(IsPlayerConnected(i))
					{
						QuitarArmasZombie(i);
						money[playerid]=GetPlayerMoney(playerid);
						ResetPlayerMoney(playerid);
					}
				}
				scorez=0;
				scorep=0;
				SetWorldTime(0);
				SetWeather(8);
				GameTextForAll("~r~apocalipsis ~w~mode:~b~on~w~! ~n~~n~~n~~g~ZOMBIES~w~!!!",5000,5);
				if (TimerAPO!=-1){KillTimer(TimerAPO);}
				TimerAPO = SetTimer("attacknearest",10000,1);
				if (TimerAtaca!=-1){KillTimer(TimerAtaca);}
				TimerAtaca=SetTimer("zombieAtaca",ZTimerSpeed,1);
				while (NOFZombies<TOTALZombies)CreateRandomZombie();
				attacknearest();
				return 1;
			}
			if 	(strcmp(cmd, "/apocalipsisoff", true)==0)	{
				if (apocalipsis)
				{
					for (new i=0;i<MAX_PLAYERS;i++)if(IsPlayerConnected(i)){DevolverArmasZombie(i);GivePlayerMoney(i,money[i]);}
					format(tmp,255,"~w~SCORE ~r~Zombies~w~: %d ~b~Humans~w~: %d~n~~n~~r~apocalipsis ~w~mode:~b~off~w~",scorez,scorep);
					GameTextForAll(tmp,6000,4);
					apocalipsis = false;
					SetWorldTime(12);
					SetWeather(7);
					cleanZombies();
				}
				if (TimerAPO!=-1){KillTimer(TimerAPO);}
				if (TimerAtaca!=-1){KillTimer(TimerAtaca);}
				return 1;
			}
			if  (strcmp(cmd, "/vaiven", true)==0)    {
				tmp = strtok(cmdtext, idx);
				if      (!strlen(tmp))
				{
                    SendClientMessage(playerid, 0xFFFFFFAA, "USO: /vaiven [angulo]");
                    return 1;
				}
				vaiven=floatstr(tmp);
				return 1;
			}
			if  (strcmp(cmd, "/zSetWeaponSet", true)==0)    {
				tmp = strtok(cmdtext, idx);
				if      (!strlen(tmp))
				{
                    SendClientMessage(playerid, 0xFFFFFFAA, "USO: /zSetWeaponSet [SET]");
                    return 1;
				}
				if      (strval(tmp)<sizeof(set))
				{
                    format(tmp,sizeof(tmp),"Please pick a number beetwen 0-%d",sizeof(set));
                    SendClientMessage(playerid, 0xFFFFFFAA, tmp);
                    return 1;
				}
				setNumber=strval(tmp);
				return 1;
			}
			if  (strcmp(cmd, "/zGetWeapon", true)==0)    {
				tmp = strtok(cmdtext, idx);
				if      (!strlen(tmp))
				{
                    SendClientMessage(playerid, 0xFFFFFFAA, "USO: /zGetWeapon [weapon]");
                    return 1;
				}
				GivePlayerWeapon(playerid,strval(tmp),10000);
				return 1;
			}
			if  (strcmp(cmd, "/zGiveWeaponForAll", true)==0)    {
				tmp = strtok(cmdtext, idx);
				if      (!strlen(tmp))
				{
                    SendClientMessage(playerid, 0xFFFFFFAA, "USO: /zGiveWeaponForAll [weapon]");
                    return 1;
				}
				new w = strval(tmp);
				for (new i=0;i<MAX_PLAYERS;i++)if(IsPlayerConnected(i))
				GivePlayerWeapon(i,w,10000);
				return 1;
			}

		//$ endregion Zombie mod
    }
	return 0;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
	if ((NOFZombies>0) && (newkeys & KEY_FIRE)&&(!IsPlayerInAnyVehicle(playerid))&&(Ticket[playerid]<tickcount()))    {
        fire(playerid,PRESS);
    }
}
//$ region Zombie mod
	fire(playerid,STAT){
		new tmp[250];
		new  weap = GetPlayerWeapon(playerid);
		format(tmp,sizeof(tmp),"ARMA ID : %d ", weap);
		SendClientMessageToAll(0xFFFF00AA,tmp);
		if (!weapL[weap][allow])
		{

			GameTextForPlayer(playerid,weapL[weap][mnsg],2000,5);
			return 1;
		}
		if (!weapL[weap][continua] && STAT==HOLD)
		{
			return 1;
		}
		Ticket[playerid]=tickcount()+delay;

		new Float:pX,Float:pY,Float:pZ,Float:pA,Float:PEPE,Float:PIPO;
		new Float:zzX,Float:zzY,Float:zzA;
		GetPlayerPos(playerid,pX,pY,pZ);
		GetPlayerFacingAngle(playerid,pA);
		pZ=pZ+0.7;
		new ran;
		for (new j=0;j<TOTALZombies;j++)
		{
			if (IsValidObject(zombie[j][torso]))
			{
				GetObjectPos(zombie[j][head],oX,oY,oZ);
				zzX=oX-pX;zzY=oY-pY;zzA=atan2(zzX,zzY);if(zzA>0)zzA-=360.0;
			}
			if (zombie[j][undead]&&(floatsqroot(floatpower(zzX,2)+floatpower(zzY,2)))<weapL[weap][range] && (floatabs(zzA+pA)<weapL[weap][wide]))
			{
				oZ-=1.7;
				zombie[j][HP]-= random(weapL[weap][damageMax]-weapL[weap][damageMin])+weapL[weap][damageMin];
				GameTextForPlayer(playerid,weapL[weap][mnsg],delay-100,5);
				PEPE = floatsin((zombie[j][angulo]*3.14159/180.0));
				PIPO = floatcos((zombie[j][angulo]*3.14159/180.0));
/*			if (weapL[weap][cutting] || weapL[weap][instaGib])
			{
				ran = random (30);
			    if (ran < 5)
			    {
			        zombie[j][undead]=false;
			        NOFZombies--;
	   				if (apocalipsis)
					{
						format(tmp,sizeof(tmp),"~w~SCORE~n~~r~Zombies~w~: %d ~n~~b~Humans~w~: %d ~y~+1",scorez,scorep);
						scorep++;
						GameTextForAll(tmp,2000,4);
						SetTimer("CreateRandomZombie",10000,0);
						attacknearest();
					}
					Z+=1.7;
					DestroyObject(zombie[j][head]);
	                StopObject(zombie[j][torso]);
	     			if (zombie[j][pedazos] & brazo1)
					MoveObject(zombie[j][rArm],X+zombie1[rArmZ][RelX]*PIPO+PEPE*zombie2[rArmZ][RelX],Y+zombie1[rArmZ][RelY]*PIPO+PEPE*zombie2[rArmZ][RelY],Z-0.253135,100.0);
					if (zombie[j][pedazos] & brazo2)
					MoveObject(zombie[j][lArm],X+zombie1[lArmZ][RelX]*PIPO+PEPE*zombie2[lArmZ][RelX],Y+zombie1[lArmZ][RelY]*PIPO+PEPE*zombie2[lArmZ][RelY],Z-0.265793,100.0);
					if (zombie[j][pedazos] & pierna1)
					MoveObject(zombie[j][rLeg],X+zombie1[rLegZ][RelX]*PIPO+PEPE*zombie2[rLegZ][RelX],Y+zombie1[rLegZ][RelY]*PIPO+PEPE*zombie2[rLegZ][RelY],Z+zombie1[rLegZ][RelZ],100.0);
	                if (zombie[j][pedazos] & pierna2)
					MoveObject(zombie[j][lLeg],X+zombie1[lLegZ][RelX]*PIPO+PEPE*zombie2[lLegZ][RelX],Y+zombie1[lLegZ][RelY]*PIPO+PEPE*zombie2[lLegZ][RelY],Z+zombie1[lLegZ][RelZ],100.0);
					NOFZombies--;
					Z-=1.7;
			    }

			    else

*/			if (weapL[weap][cutting])
					{
					if  ((zombie[j][pedazos] & brazo1) || (zombie[j][pedazos] & brazo2))
					{
						if (ran < 20)
						{
							if (( ran < 10 || !(zombie[j][pedazos] & brazo2)) && (zombie[j][pedazos] & brazo1))
							{
								zombie[j][pedazos]-=brazo1;MoveObject(zombie[j][rArm],oX+zombie1[rArmZ][RelX]*PIPO+PEPE*zombie2[rArmZ][RelX],oY+zombie1[rArmZ][RelY]*PIPO+PEPE*zombie2[rArmZ][RelY],oZ,1.0);
							}
							else
							{
								zombie[j][pedazos]-=brazo2;MoveObject(zombie[j][lArm],oX+zombie1[lArmZ][RelX]*PIPO+PEPE*zombie2[lArmZ][RelX],oY+zombie1[lArmZ][RelY]*PIPO+PEPE*zombie2[lArmZ][RelY],oZ,1.0);
							}
						}
					}
					else if  (zombie[j][HP]<40 && (zombie[j][pedazos] & pierna1 ) && (zombie[j][pedazos] & pierna2))
					{
						if (ran < 15){zombie[j][pedazos]-=pierna1;MoveObject(zombie[j][rLeg],oX+zombie1[rLegZ][RelX]*PIPO+PEPE*zombie2[rLegZ][RelX],oY+zombie1[rLegZ][RelY]*PIPO+PEPE*zombie2[rLegZ][RelY],oZ,1.0);}
						else{zombie[j][pedazos]-=pierna2;MoveObject(zombie[j][lLeg],oX+zombie1[lLegZ][RelX]*PIPO+PEPE*zombie2[lLegZ][RelX],oY+zombie1[lLegZ][RelY]*PIPO+PEPE*zombie2[lLegZ][RelY],oZ,1.0);}
						zombie[j][speed]-=float(40);
					}
					//			}
				}
				if (zombie[j][HP]<0 && zombie[j][undead])
				{
					zombie[j][undead]=false;
					NOFZombies--;
					MoveObject(zombie[j][head],oX,oY,oZ,1.5);
					MoveObject(zombie[j][torso],oX+zombie1[torsoZ][RelX]*PIPO+PEPE*zombie2[torsoZ][RelX],oY+zombie1[torsoZ][RelY]*PIPO+PEPE*zombie2[torsoZ][RelY],oZ+0.4,1.5);
					if (zombie[j][pedazos] & brazo1)
					MoveObject(zombie[j][rArm],oX+zombie1[rArmZ][RelX]*PIPO+PEPE*zombie2[rArmZ][RelX],oY+zombie1[rArmZ][RelY]*PIPO+PEPE*zombie2[rArmZ][RelY],oZ,1.5);
					if (zombie[j][pedazos] & brazo2)
					MoveObject(zombie[j][lArm],oX+zombie1[lArmZ][RelX]*PIPO+PEPE*zombie2[lArmZ][RelX],oY+zombie1[lArmZ][RelY]*PIPO+PEPE*zombie2[lArmZ][RelY],oZ,1.5);
					if (zombie[j][pedazos] & pierna1)
					StopObject(zombie[j][rLeg]);
					if (zombie[j][pedazos] & pierna2)
					StopObject(zombie[j][lLeg]);
					if (apocalipsis)
					{
						format(tmp,sizeof(tmp),"~w~SCORE~n~~r~Zombies~w~: %d ~n~~b~Humans~w~: %d ~y~+1",scorez,scorep);
						scorep++;
						GameTextForAll(tmp,2000,4);
						ran = random(10);
						SetTimer("CreateRandomZombie",ran*1000,0);
						attacknearest();
					}
				}
			}
		}
		return 1;
	}
	public HoldingFire(){
		new keys,updown,leftright;
		for (new i=0;i<MAX_PLAYERS;i++)
		{
			if (IsPlayerConnected(i))
			{
				GetPlayerKeys(i,keys,updown,leftright);
				if ((keys & KEY_FIRE)&&(!IsPlayerInAnyVehicle(i))&&(Ticket[i]<tickcount()))
				{
					fire(i,HOLD);
				}
			}
		}
	}
	public CreateRandomZombie(){
		new playerid = random(MAX_PLAYERS);
		while (!IsPlayerConnected(playerid)&&GetPlayerInterior(playerid)==0)playerid = random(MAX_PLAYERS);
		new Float:pX,Float:pY,Float:pZ,Float:Ang;
		GetPlayerPos(playerid,pX,pY,pZ);
		Ang=float(random(360));
		pX=pX+50.0*floatsin(Ang,degrees);
		pY=pY+50.0*floatcos(Ang,degrees);
		pZ=pZ+0.7;
		CrearZombie(pX,pY,pZ,Ang);
	}
	public QuitarArmasZombie(playerid){
		LastWeaponUsed[playerid]=GetPlayerWeapon(playerid);GetPlayerWeapon(playerid);
		new WeaponId;
		new ammo;
		for (new i=0;i<11;i++)
        {
			GetPlayerWeaponData(playerid, i, WeaponId, ammo);
			WeaponList[playerid][i][pWeapId]=WeaponId;
			WeaponList[playerid][i][pAmmo]=ammo;
        }
		ResetPlayerWeapons(playerid);
		return 1;
	}
	public DevolverArmasZombie(playerid){
		new index;
		for (new i=0;i<11;i++)
        {
			if      (WeaponList[playerid][i][pWeapId]!=0)
			{
				if  (WeaponList[playerid][i][pWeapId]!=LastWeaponUsed[playerid])
                {
					GivePlayerWeapon(playerid,WeaponList[playerid][i][pWeapId],WeaponList[playerid][i][pAmmo]);
                }
				else
				{
					index=i;
				}
			}
        }
		GivePlayerWeapon(playerid,WeaponList[playerid][index][pWeapId],WeaponList[playerid][index][pAmmo]);
		return 1;
	}
	public attacknearest(){
		new Float:pX,Float:pY,Float:pZ;
		new Float:distNew,Float:distOld;
		new candidato;
		for (new j=0;j<TOTALZombies;j++)
		{
			if (zombie[j][undead])
			{
				distOld=9999.9;
				candidato=-1;
				GetObjectPos(zombie[j][head],oX,oY,oZ);
				for(new i=0;i<MAX_PLAYERS;i++)
				{
					if(IsPlayerConnected(i))
					{
						GetPlayerPos(i,pX,pY,pZ);
						distNew = floatabs(pX-oX) + floatabs(pY-oY);
						if (distNew<distOld)
						{
							distOld = distNew;
							candidato = i;
						}
					}
				}
				if (distOld>100.0)
				{
					DestroyObject(zombie[j][head]);
					DestroyObject(zombie[j][rLeg]);
					DestroyObject(zombie[j][lLeg]);
					DestroyObject(zombie[j][rArm]);
					DestroyObject(zombie[j][lArm]);
					DestroyObject(zombie[j][torso]);
					NOFZombies--;
					zombie[j][undead]=false;
					SetTimer("CreateRandomZombie",1000,0);
				}
				zombie[j][target]=candidato;
			}
		}
	}
	cleanZombies(){
		for (new j=0;j<TOTALZombies;j++)
		{
			zombie[j][undead]=false;
			if (IsValidObject(zombie[j][torso]))DestroyObject(zombie[j][torso]);
			if (IsValidObject(zombie[j][head]))	DestroyObject(zombie[j][head]);
			if (IsValidObject(zombie[j][rLeg]))	DestroyObject(zombie[j][rLeg]);
			if (IsValidObject(zombie[j][lLeg]))	DestroyObject(zombie[j][lLeg]);
			if (IsValidObject(zombie[j][rArm]))	DestroyObject(zombie[j][rArm]);
			if (IsValidObject(zombie[j][lArm]))	DestroyObject(zombie[j][lArm]);
			NOFZombies--;
		}
		if (TimerAPO!=-1){KillTimer(TimerAPO);}
		if (TimerAtaca!=-1){KillTimer(TimerAtaca);}
	}
	CrearZombie(Float:pX,Float:pY,Float:pZ,Float:angle){
		new Float:PEPE = floatsin((angle*3.14159/180.0));
		new Float:PIPO = floatcos((angle*3.14159/180.0));
		if (NOFZombies<TOTALZombies)
		{
			new j=0;
			while ((zombie[j][undead])){j++;}
			if (IsValidObject(zombie[j][torso]))
			{
				DestroyObject(zombie[j][head]);
				DestroyObject(zombie[j][rLeg]);
				DestroyObject(zombie[j][lLeg]);
				DestroyObject(zombie[j][rArm]);
				DestroyObject(zombie[j][lArm]);
				DestroyObject(zombie[j][torso]);
			}
			zombie[j][head]=CreateObject(zombie1[headZ][partModel],pX,pY,pZ,zombie1[headZ][RelrX],zombie1[headZ][RelrY],angle);
			zombie[j][torso]=CreateObject(zombie1[torsoZ][partModel],pX+zombie1[torsoZ][RelX]*PIPO+PEPE*zombie2[torsoZ][RelX],pY+zombie1[torsoZ][RelY]*PIPO+PEPE*zombie2[torsoZ][RelY],pZ+zombie1[torsoZ][RelZ],zombie1[torsoZ][RelrX],zombie1[torsoZ][RelrY],angle);
			zombie[j][lArm]=CreateObject(zombie1[lArmZ][partModel],pX+zombie1[lArmZ][RelX]*PIPO+PEPE*zombie2[lArmZ][RelX],pY+zombie1[lArmZ][RelY]*PIPO+PEPE*zombie2[lArmZ][RelY],pZ+zombie1[lArmZ][RelZ],zombie1[lArmZ][RelrX],zombie1[lArmZ][RelrY],angle);
			zombie[j][rArm]=CreateObject(zombie1[rArmZ][partModel],pX+zombie1[rArmZ][RelX]*PIPO+PEPE*zombie2[rArmZ][RelX],pY+zombie1[rArmZ][RelY]*PIPO+PEPE*zombie2[rArmZ][RelY],pZ+zombie1[rArmZ][RelZ],zombie1[rArmZ][RelrX],zombie1[rArmZ][RelrY],angle);
			zombie[j][rLeg]=CreateObject(zombie1[rLegZ][partModel],pX+zombie1[rLegZ][RelX]*PIPO+PEPE*zombie2[rLegZ][RelX],pY+zombie1[rLegZ][RelY]*PIPO+PEPE*zombie2[rLegZ][RelY],pZ+zombie1[rLegZ][RelZ],zombie1[rLegZ][RelrX],zombie1[rLegZ][RelrY],angle);
			zombie[j][lLeg]=CreateObject(zombie1[lLegZ][partModel],pX+zombie1[lLegZ][RelX]*PIPO+PEPE*zombie2[lLegZ][RelX],pY+zombie1[lLegZ][RelY]*PIPO+PEPE*zombie2[lLegZ][RelY],pZ+zombie1[lLegZ][RelZ],zombie1[lLegZ][RelrX],zombie1[lLegZ][RelrY],angle);

			zombie[j][LegsH]=true;
			zombie[j][speed]=random(100)+50;
			zombie[j][ArmAngle]=0;
			zombie[j][ArmStatus]=random(5)+5;
			zombie[j][undead]=true;
			zombie[j][HP]=100;
			zombie[j][pedazos]= brazo1 + brazo2 + pierna1 + pierna2;
			zombie[j][angulo]=angle;
			NOFZombies++;
		}
		return 1;
	}
	public zombieAtaca(){
		new Float:pX,Float:pY,Float:pZ,Float:angle,Float:PEPE,Float:PIPO,Float:AA1,Float:AA2,Float:H;
		new vehicleStatus;
		if (NOFZombies<1 && !apocalipsis)
		{
			if (TimerAPO!=-1){KillTimer(TimerAPO);}
			if (TimerAtaca!=-1){KillTimer(TimerAtaca);}
		}
		HoldingFire();
		for (new j=0;j<TOTALZombies;j++)
		{
			if(zombie[j][undead]&&IsPlayerConnected(zombie[j][target]) && GetPlayerInterior(zombie[j][target])==0)
			{
				vehicleStatus = IsPlayerInAnyVehicle(zombie[j][target]);
				GetPlayerPos(zombie[j][target],pX,pY,pZ);
				pZ+=0.7;
				GetObjectPos(zombie[j][head],oX,oY,oZ);
				angle = 180.0-atan2(oX-pX,oY-pY);
				angle+=vaiven;
				vaiven*=-1;
				PEPE = floatsin((angle*3.14159/180.0));
				PIPO = floatcos((angle*3.14159/180.0));
				zombie[j][angulo]=angle;
				if(floatabs(zombie[j][ArmAngle])>10.0){zombie[j][ArmStatus]*=-1;}
				zombie[j][ArmAngle]+=zombie[j][ArmStatus];

				zombie[j][LegsH]=!zombie[j][LegsH];

				AA1 = floatcos(zombie[j][ArmAngle]*3.14159/180.0);
				AA2 = floatsin(zombie[j][ArmAngle]*3.14159/180.0);

				if ((pZ-oZ)>3.0)
				{
					oZ+=1.0;
				}
				else if((pZ-oZ)<-3.0)
				{
					oZ-=1.0;
				}
				//we destroy the old zombi
				DestroyObject(zombie[j][torso]);
				DestroyObject(zombie[j][head]);
				if (zombie[j][pedazos] & brazo1) DestroyObject(zombie[j][rArm]);
				if (zombie[j][pedazos] & brazo2) DestroyObject(zombie[j][lArm]);
				if (zombie[j][pedazos] & pierna1) DestroyObject(zombie[j][rLeg]);
				if (zombie[j][pedazos] & pierna2) DestroyObject(zombie[j][lLeg]);

				//we recreate the zombie
				zombie[j][head]=CreateObject(zombie1[headZ][partModel],oX,oY,pZ,zombie1[headZ][RelrX],zombie1[headZ][RelrY],angle+vaiven);
				zombie[j][torso]=CreateObject(zombie1[torsoZ][partModel],oX+zombie1[torsoZ][RelX]*PIPO+PEPE*zombie2[torsoZ][RelX],oY+zombie1[torsoZ][RelY]*PIPO+PEPE*zombie2[torsoZ][RelY],pZ+zombie1[torsoZ][RelZ],zombie1[torsoZ][RelrX],zombie1[torsoZ][RelrY],angle);
				if (zombie[j][pedazos] & brazo1)
				zombie[j][rArm]=CreateObject(zombie1[rArmZ][partModel],oX+zombie1[rArmZ][RelX]*PIPO+PEPE*zombie2[rArmZ][RelX],oY+zombie1[rArmZ][RelY]*PIPO+PEPE*zombie2[rArmZ][RelY],pZ+A1[der][AZ]*AA1+AA2*A2[der][AZ],(-1)*zombie[j][ArmAngle],zombie1[rArmZ][RelrY],angle);
				if (zombie[j][pedazos] & brazo2)
				zombie[j][lArm]=CreateObject(zombie1[lArmZ][partModel],oX+zombie1[lArmZ][RelX]*PIPO+PEPE*zombie2[lArmZ][RelX],oY+zombie1[lArmZ][RelY]*PIPO+PEPE*zombie2[lArmZ][RelY],pZ+A1[izq][AZ]*AA1-AA2*A2[izq][AZ],zombie[j][ArmAngle],zombie1[lArmZ][RelrY],angle);
				if (zombie[j][pedazos] & pierna1)
				zombie[j][rLeg]=CreateObject(zombie1[rLegZ][partModel],oX+zombie1[rLegZ][RelX]*PIPO+PEPE*zombie2[rLegZ][RelX],oY+zombie1[rLegZ][RelY]*PIPO+PEPE*zombie2[rLegZ][RelY],pZ+zombie1[rLegZ][RelZ]+float(zombie[j][LegsH])*0.2,zombie1[rLegZ][RelrX],zombie1[rLegZ][RelrY],angle);

				if (zombie[j][pedazos] & pierna2)
				zombie[j][lLeg]=CreateObject(zombie1[lLegZ][partModel],oX+zombie1[lLegZ][RelX]*PIPO+PEPE*zombie2[lLegZ][RelX],oY+zombie1[lLegZ][RelY]*PIPO+PEPE*zombie2[lLegZ][RelY],pZ+zombie1[lLegZ][RelZ]+float(!zombie[j][LegsH])*0.2,zombie1[lLegZ][RelrX],zombie1[lLegZ][RelrY],angle);

				if ( (floatabs(pX-oX) + floatabs(pY-oY) + floatabs(pZ-oZ) )>(2.0+6.0*vehicleStatus))//The zombie will move to your position to eat you because if you are too far away
				{
					MoveObject(zombie[j][head],pX,pY,pZ,zombie[j][speed]*0.01*Zspeed);
					MoveObject(zombie[j][torso],pX+zombie1[torsoZ][RelX]*PIPO+PEPE*zombie2[torsoZ][RelX],pY+zombie1[torsoZ][RelY]*PIPO+PEPE*zombie2[torsoZ][RelY],pZ+zombie1[torsoZ][RelZ],zombie[j][speed]*0.01*Zspeed);
					if (zombie[j][pedazos] & brazo1)
					MoveObject(zombie[j][rArm],pX+zombie1[rArmZ][RelX]*PIPO+PEPE*zombie2[rArmZ][RelX],pY+zombie1[rArmZ][RelY]*PIPO+PEPE*zombie2[rArmZ][RelY],pZ+A1[der][AZ]*AA1+AA2*A2[der][AZ],zombie[j][speed]*0.01*Zspeed);
					if (zombie[j][pedazos] & brazo2)
					MoveObject(zombie[j][lArm],pX+zombie1[lArmZ][RelX]*PIPO+PEPE*zombie2[lArmZ][RelX],pY+zombie1[lArmZ][RelY]*PIPO+PEPE*zombie2[lArmZ][RelY],pZ+A1[izq][AZ]*AA1-AA2*A2[izq][AZ],zombie[j][speed]*0.01*Zspeed);
					if (zombie[j][pedazos] & pierna1)
					MoveObject(zombie[j][rLeg],pX+zombie1[rLegZ][RelX]*PIPO+PEPE*zombie2[rLegZ][RelX],pY+zombie1[rLegZ][RelY]*PIPO+PEPE*zombie2[rLegZ][RelY],pZ+zombie1[rLegZ][RelZ]+float(zombie[j][LegsH])*0.2,zombie[j][speed]*0.01*Zspeed);
					if (zombie[j][pedazos] & pierna2)
					MoveObject(zombie[j][lLeg],pX+zombie1[lLegZ][RelX]*PIPO+PEPE*zombie2[lLegZ][RelX],pY+zombie1[lLegZ][RelY]*PIPO+PEPE*zombie2[lLegZ][RelY],pZ+zombie1[lLegZ][RelZ]+float(!zombie[j][LegsH])*0.2,zombie[j][speed]*0.01*Zspeed);
				}
				else//the zombie EATS you unless you are in a vehicle or you are alredy dead
				{
					StopObject(zombie[j][head]);
					StopObject(zombie[j][torso]);
					StopObject(zombie[j][rArm]);
					StopObject(zombie[j][lArm]);
					StopObject(zombie[j][rLeg]);
					StopObject(zombie[j][lLeg]);
					GetPlayerHealth(zombie[j][target],H);
					if ( !vehicleStatus && !PlayerDeath[zombie[j][target]])
					{
						SetPlayerHealth(zombie[j][target],H-5.0);
					}
				}
			}
		}
		return 1;
	}

//$ endregion Zombie mod
strtok(const string[], &index){
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
