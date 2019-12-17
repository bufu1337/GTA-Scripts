/*
 *            DCallbacks 1.1
 *       (c) Copyright 2006 by DracoBlue
 *
 * @author    : DracoBlue (http://dracoblue.com)
 * @date      : 26th July 2006
 * @update    : 25th November 2007
 *
 * This file is provided as is (no warranties).
 *
 * Feel free to use it, a little message in
 * about box is honouring thing, isn't it?
 *
 */

#if defined _dcallbacks_included
  #endinput
#endif

#define _dcallbacks_included
#pragma library dcallbacks

// Update the following line to make more areachecks possible.
#define MAX_AREAS_TO_CHECK 100

forward TIMER_DCallbacks();

new Float:AREACHECK_Coords[MAX_AREAS_TO_CHECK][4];
new AREACHECK_Player[MAX_PLAYERS];
new AREACHECK_Count=0;
/*
 *  Return the AreaId, starts with 1 not 0.
 */
stock AddAreaCheck(Float:x_min,Float:x_max,Float:y_min,Float:y_max) {
	AREACHECK_Coords[AREACHECK_Count][0]=x_min;
	AREACHECK_Coords[AREACHECK_Count][1]=x_max;
	AREACHECK_Coords[AREACHECK_Count][2]=y_min;
	AREACHECK_Coords[AREACHECK_Count][3]=y_max;
	AREACHECK_Count++;
	return AREACHECK_Count;
}

public TIMER_DCallbacks() {
	new i,z;
	new Float:x,Float:y,Float:zcoord;
	for (i=0;i<MAX_PLAYERS;i++) {
		if (IsPlayerConnected(i)) {
			GetPlayerPos(i,x,y,zcoord);
			for (z=0;z<AREACHECK_Count;z++) {
				if ( (AREACHECK_Coords[z][0]<x)&&(AREACHECK_Coords[z][1]>x) &&
					(AREACHECK_Coords[z][2]<y)&&(AREACHECK_Coords[z][3]>y) ) {
					if (z!=AREACHECK_Player[i]-1) {
						// Is new in this area
						AREACHECK_Player[i]=z+1;
						OnPlayerEnterArea(i,z+1);
					}
				} else {
					if (z==AREACHECK_Player[i]-1) {
						// Player was in this Area
						OnPlayerLeaveArea(i,z+1);
						AREACHECK_Player[i]=0;
					}
				}
			}
		}   
	}
}
