#include <a_samp>

#define MAX_ICONS 500
#define INVALID_ICON_ID -1
#define ICON 1

new Float:IconPos[MAX_ICONS][3];
new IconModel[MAX_ICONS];
new IconColor[MAX_ICONS];
new IconActive[MAX_ICONS];
new CurrentIcon[MAX_PLAYERS];

forward InitMapIconStreaming();
public InitMapIconStreaming()
{
 	for(new i=0;i<MAX_PLAYERS;i++)
		CurrentIcon[i]=INVALID_ICON_ID;
	
	SetTimer("MapIconUpdate",2350,1);
	print("[mapicon] Mapicons initialisiert!");
	return 1;
}

forward CreateMapIcon(modelid,color,Float:x,Float:y,Float:z);
public CreateMapIcon(modelid,color,Float:x,Float:y,Float:z)
{
	for(new i=0;i<MAX_ICONS;i++)
	{
		if(!IconActive[i])
		{
			IconPos[i][0]=x;
			IconPos[i][1]=y;
			IconPos[i][2]=z;
			IconModel[i]=modelid;
			IconColor[i]=color;
			IconActive[i]=true;
			return i;
		}
	}
	print("[mapicon] Erstellen von Mapicon fehlgeschlagen!");
	return INVALID_ICON_ID;
}

forward DestroyMapIcon(id);
public DestroyMapIcon(id)
{
	if(!IconActive[id]) return 0;
	
	IconActive[id]=false;
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i) && CurrentIcon[i]==id)
	    {
		    RemovePlayerMapIcon(i,ICON);
		    CurrentIcon[i]=INVALID_ICON_ID;
		}
	}
	return 1;
}

forward MapIconUpdate();
public MapIconUpdate()
{
	new id;
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
			id=GetClosestUnusedMapIcon(i);
			if(id!=CurrentIcon[i])
			{
				if(CurrentIcon[i]!=INVALID_ICON_ID)
				{
				    RemovePlayerMapIcon(i,ICON);
				    CurrentIcon[i]=INVALID_ICON_ID;
				}
				if(id!=INVALID_ICON_ID)
				{
				    SetPlayerMapIcon(i,ICON,IconPos[id][0],IconPos[id][1],IconPos[id][2],IconModel[id],IconColor[id]);
				    CurrentIcon[i]=id;
				}
			}
	    }
	}
	return 1;
}

stock ResetMapIconVariables(playerid)
{
	CurrentIcon[playerid]=INVALID_ICON_ID;
	RemovePlayerMapIcon(playerid,ICON);
	return playerid;
}

stock GetDistanceToPoint(playerid,Float:x,Float:y,Float:z)
{
	new Float:dis;
	new Float:x1,Float:y1,Float:z1;
	if (!IsPlayerConnected(playerid)) return -1;
	GetPlayerPos(playerid,x1,y1,z1);
	dis = floatsqroot(floatpower(floatabs(floatsub(x,x1)),2)+floatpower(floatabs(floatsub(y,y1)),2)+floatpower(floatabs(floatsub(z,z1)),2));
	return floatround(dis);
}

stock GetClosestUnusedMapIcon(playerid)
{
	new dis=50000,tmpdis,id=INVALID_ICON_ID;
	for(new i=0;i<MAX_ICONS;i++)
	{
	    if(IconActive[i])
		{
		    tmpdis=GetDistanceToPoint(playerid,IconPos[i][0],IconPos[i][1],IconPos[i][2]);
		    if(tmpdis<dis)
		    {
		        id=i;
				dis=tmpdis;
		    }
		}
	}
	return id;
}