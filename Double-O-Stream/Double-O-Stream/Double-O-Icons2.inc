#include <a_samp>

#define DISTANCE 300
#define MAX_ICONS 500
#define INVALID_ICON_ID -1
#define ICON 1
#define IsPosInDistance(%0,%1,%2,%3,%4,%5,%6) \
        (((%0 - %3) * (%0 - %3)) + ((%1 - %4) * (%1 - %4)) + ((%2 - %5) * (%2 - %5)) <= %6 * %6)// BIG THX to Goldkiller

new Float:IconPos[MAX_ICONS][3];
new IconModel[MAX_ICONS];
new IconColor[MAX_ICONS];
new IconActive[MAX_ICONS];
new Slot[MAX_PLAYERS][MAX_ICONS];
new SlotUsed[MAX_PLAYERS][32];
new IconCount[MAX_PLAYERS];

forward InitMapIconStreaming();
public InitMapIconStreaming()
{
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

        printf("[mapicon] Zerstoere Mapicon %d!",id);
        IconActive[id]=false;
        for(new i=0;i<MAX_PLAYERS;i++)
        {
            if(IsPlayerConnected(i) && Slot[i][id]!=INVALID_ICON_ID)
            {
                RemovePlayerMapIcon(i,Slot[i][id]);
                SlotUsed[i][Slot[i][id]]=false;
                Slot[i][id]=INVALID_ICON_ID;
                IconCount[i]--;
            }
        }
        printf("[mapicon] Zerstoeren von Mapicon %d erfolgreich!",id);
        return 1;
}

forward MapIconUpdate();
public MapIconUpdate()
{
        new Float:x,Float:y,Float:z,s;
        for(new i=0;i<MAX_PLAYERS;i++)
        {
            if(GetPlayerPos(i,x,y,z))
            {
                for(new j=0;j<MAX_ICONS;j++)
                {
                    if(IconActive[j])
                    {
                        if(IsPosInDistance(x,y,z,IconPos[j][0],IconPos[j][1],IconPos[j][2],DISTANCE))
                        {
                            if(Slot[i][j]==INVALID_ICON_ID)
                            {
                                s=GetFreeSlot(i);
                                if(IconCount[i]<32 && s!=INVALID_ICON_ID)
                                {
                                    SetPlayerMapIcon(i,s,IconPos[j][0],IconPos[j][1],IconPos[j][2],IconModel[j],IconColor[j]);
                                    SlotUsed[i][s]=true;
									Slot[i][j]=s;
                                    IconCount[i]++;
                                }
                            }
                        }
                        else
                        {
                            if(Slot[i][j]!=INVALID_ICON_ID)
                            {
                                RemovePlayerMapIcon(i,Slot[i][j]);
                                SlotUsed[i][Slot[i][j]]=false;
                                Slot[i][j]=INVALID_ICON_ID;
                                IconCount[i]--;
                            }
                        }
                    }
                }
            }
        }
        return 1;
}

stock ResetMapIconVariables(playerid)
{
        for(new i=0;i<MAX_ICONS;i++)
            Slot[playerid][i]=INVALID_ICON_ID;
		for(new i=0;i<32;i++)
		    SlotUsed[playerid][i]=false;
        IconCount[playerid]=0;
        return playerid;
}

stock GetFreeSlot(playerid)
{
	for(new i=0;i<32;i++)
	    if(!SlotUsed[playerid][i])
	        return i;
	return INVALID_ICON_ID;
}

#undef IsPosInDistance