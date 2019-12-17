<html><head><title>JAdmin Version 3b</title>


<script type="text/javascript">
function select_all()
{
var text_val=eval("document.form1.type");
text_val.focus();
text_val.select();
}
</script>

</head>
<body bgcolor="#ffffff" text="#000000" link="#0000ff" vlink="#800080" alink="#ff0000">

<form name=form1 method=post action=''''>
<textarea name="script" onClick="select_all(); "style="margin-top: 2px; margin-bottom: 2px; height: 90%; margin-left: 2px; margin-right: 2px; width: 100%;">

/*Headshot system by Johnson_boy

Using this script you can enable "Boom Headshots", which means an instant kill when shooting to head with sniper.
This script has been created by Johnson_boy.
You are allowed to use this on your server, and modefy it to fit your needs.
You are NOT allowed to remove the credits and share as yours.
If you use this on your server, please place any kind of credits on your gamemode about this script.
It shouldn't be too much for this.
*/

#include <a_samp>

#define SERVER_MAX_PLAYERS 20 //Change to max players of your server

//define SHOWPATH if you want the path of bullet to be shown
#define SHOWPATH

new RecentlyShot[SERVER_MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("\n\n__________________________________________________________________");
	print(" Boom Headshot System by Johnson_boy loaded!");
	print(" Copyright Johnson_boy 2010");
	print("__________________________________________________________________\n\n");
	return 1;
}

public OnFilterScriptExit()
{
    print("\n\n__________________________________________________________________");
	print(" Boom Headshot System by Johnson_boy unloaded!");
	print(" Copyright Johnson_boy 2010");
	print("__________________________________________________________________\n\n");
	return 1;
}

public OnPlayerConnect(playerid) {
 	SendClientMessage(playerid, 0xFFFFFFFF, "This server is using Johnson_boy's Headshot script v2b");
	return 1;
}

public OnPlayerSpawn(playerid)
{
	GivePlayerWeapon(playerid, 34, 15);
	RecentlyShot[playerid] = 0;
	return 1;
}

public OnPlayerUpdate(playerid)
{

	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_FIRE && newkeys & KEY_HANDBRAKE) {
	    if(RecentlyShot[playerid] == 0) {
	        RecentlyShot[playerid] = 1;
	        SetTimerEx("AntiSpam", 1000, false, "d", playerid);
			if(GetPlayerWeapon(playerid) == 34) {
		        new Float:blahx, Float:blahy, Float:blahz;
				HeadshotCheck(playerid, blahx, blahy, blahz);
		        return 1;
		    }
			return 1;
		}
		return 1;
 	}
	return 1;
}

forward AntiSpam(playerid);
public AntiSpam(playerid) {
	RecentlyShot[playerid] = 0;
	return 1;
}

stock PlayerName(playerid) {
	new name[24];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

stock HeadshotCheck(playerid, &Float:x, &Float:y, &Float:z)
{
	new Float:fx,Float:fy,Float:fz;
	GetPlayerCameraFrontVector(playerid, fx, fy, fz);

 	new Float:cx,Float:cy,Float:cz;
 	GetPlayerCameraPos(playerid, cx, cy, cz);

	for(new Float:i = 0.0; i < 50; i = i + 0.5)
	{
 		x = fx * i + cx;
		y = fy * i + cy;
		z = fz * i + cz;

		#if defined SHOWPATH
		CreatePickup(1239, 4, x, y, z, -1);
		#endif

		for(new player = 0; player < SERVER_MAX_PLAYERS; player ++)
		{
		    if(IsPlayerConnected(playerid))
		    {
		    	if(player != playerid)
				{
		    		if(GetPlayerSpecialAction(player) == SPECIAL_ACTION_DUCK) //CROUCHING
					{
		        		if(IsPlayerInRangeOfPoint(player, 0.3, x, y, z))
		        		{
		        		    new string[128];
							format(string, sizeof(string), "Headshot: %s was shot to head by %s", PlayerName(player), PlayerName(playerid));
							SendClientMessageToAll(0xFF9900AA, string);

		            		GameTextForPlayer(playerid, "~r~HEADSHOT!", 2000, 6);
		            		GameTextForPlayer(player, "~r~HEADSHOT!", 2000, 6);

		            		SetPlayerHealth(player, 0.0);
		            		CallRemoteFunction("OnPlayerDeath", "ddd", player, playerid, 34);
		        		}
					}
					else //NOT CROUCHING
					{
		    			if(IsPlayerInRangeOfPoint(player, 0.3, x, y, z - 0.7))
						{
		        			new string[128];
							format(string, sizeof(string), "Headshot: %s was shot to head by %s", PlayerName(player), PlayerName(playerid));
							SendClientMessageToAll(0xFF9900AA, string);

							GameTextForPlayer(playerid, "~r~HEADSHOT!", 2000, 6);
							GameTextForPlayer(player, "~r~HEADSHOT!", 2000, 6);

							SetPlayerHealth(player, 0.0);
							CallRemoteFunction("OnPlayerDeath", "ddd", player, playerid, 34);
						}
					}
				}
			}
		}
	}
	return 1;
}

</textarea>
 <center><input type="button" value="Select All" onClick="javascript:this.form.script.focus();this.form.script.select();"></center>

</form>
</body>
</html>
<!-- www.000webhost.com Analytics Code -->
<script type="text/javascript" src="http://analytics.hosting24.com/count.php"></script>
<noscript><a href="http://www.hosting24.com/"><img src="http://analytics.hosting24.com/count.php" alt="web hosting" /></a></noscript>
<!-- End Of Analytics Code -->
