/*
 *            DMap 0.4
 *       (c) Copyright 2008 by DracoBlue
 *
 * @author    : DracoBlue (http://dracoblue.com)
 * @date      : 26th Aug 2008
 * @update    : 31st Jan 2009
 * @requires djson 1.5.2
 *
 * This file is provided as is (no warranties).
 *
 * Feel free to use it, a little message in
 * about box is honouring thing, isn't it?
 *
 */
#include <djson>

forward dmap_TIMER();

new dmap_saved[MAX_PLAYERS];

public dmap_TIMER() {
	new Float:tmp_float;
	new Float:tmp_floatx,Float:tmp_floaty;
	new tmp[255];
	new tmp2[255];

	djAutocommit(false);
	for (new i=0;i<MAX_PLAYERS;i++) {
		if (IsPlayerConnected(i)) {
			if (!dmap_saved[i]) {
				dmap_saved[i] = true;

				format(tmp,255,"items/p%d/id",i);
				djSetInt("dmap_feed.json",tmp,i);

				GetPlayerName(i,tmp2,255);
				format(tmp,255,"items/p%d/name",i);
				djSet("dmap_feed.json",tmp,tmp2);

				format(tmp,255,"items/p%d/icon",i);
				djSet("dmap_feed.json",tmp,"58");
			}

			GetPlayerHealth(i,tmp_float);
			format(tmp2,255,"Health: %d",floatround(tmp_float));
			format(tmp,255,"items/p%d/text",i);
			djSet("dmap_feed.json",tmp,tmp2);

			GetPlayerPos(i,tmp_floatx,tmp_floaty,tmp_float);
			format(tmp,255,"items/p%d/pos/x",i);
			djSetInt("dmap_feed.json",tmp,floatround(tmp_floatx));
			format(tmp,255,"items/p%d/pos/y",i);
			djSetInt("dmap_feed.json",tmp,floatround(tmp_floaty));

		} else if (dmap_saved[i]) {
			// saved, but not connected, remove him!
			format(tmp,255,"items/p%d",i);
			djUnset("dmap_feed.json",tmp);
			dmap_saved[i] = false;
		}
	}
	djCommit("dmap_feed.json");
	djAutocommit(true);
}

dmap_GameModeExit() {
	djson_GameModeExit();
}

dmap_GameModeInit() {
	printf("  <dmap> DMap 0.3 // (c) 2008 DracoBlue // http://www.dracoblue.net");
	printf("  <dmap> Loading ...");
	djson_GameModeInit();
	djCreateFile("dmap_feed.json");
	SetTimer("dmap_TIMER",5000,1);
	printf("  <dmap> .. done!");
}