
#define PICKUP_LIMIT 100

enum Loc
{
	Float:x1,Float:y1,Float:z1,ID,Float:Range
}
new xPickups;
new xID[PICKUP_LIMIT][Loc];

PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tmpposx, Float:tmpposy, Float:tmpposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	tmpposx = (oldposx -x);
	tmpposy = (oldposy -y);
	tmpposz = (oldposz -z);
	if (((tmpposx < radi) && (tmpposx > -radi)) && ((tmpposy < radi) && (tmpposy > -radi)) && ((tmpposz < radi) && (tmpposz > -radi)))
	{
		return 1;
	}
	return 0;
}

stock xAddPickup(model,type,Float:x,Float:y,Float:z)
{
	xID[xPickups][x1] = x;
	xID[xPickups][y1] = y;
	xID[xPickups][z1] = z;
	xID[xPickups][ID] = xPickups;
	xPickups++;
	return AddStaticPickup(model,type,x,y,z);
}

stock xAddPickupWRange(Float:range,model,type,Float:x,Float:y,Float:z)
{
	xID[xPickups][x1] = x;
	xID[xPickups][y1] = y;
	xID[xPickups][z1] = z;
	xID[xPickups][ID] = xPickups;
	xID[xPickups][Range] = range;
	xPickups++;
	return AddStaticPickup(model,type,x,y,z);
}

public xCheck()
{
	for(new i=0; i<MAX_PLAYERS; i++) { if(IsPlayerConnected(i))
		for(new x=0; x<xPickups; x++) {
			if(PlayerToPoint(1.8,i,xID[x][x1],xID[x][y1],xID[x][z1]))
			xOnPlayerGetPickup(i,xID[x][ID]);
			if(xID[x][Range] > 0)
			if(PlayerToPoint(xID[x][Range],i,xID[x][x1],xID[x][y1],xID[x][z1]))
	      	                   xOnPlayerEnterPickupRange(i,xID[x][ID]);
		}
	}
}

public xOnPlayerGetPickup(playerid,pickup)
{
	GameTextForAll("~r~Worked",1000,1);
	return 1;
}

public xOnPlayerEnterPickupRange(playerid,pickup)
{
	GameTextForAll("~r~Worked",1000,1);
	return 1;
}