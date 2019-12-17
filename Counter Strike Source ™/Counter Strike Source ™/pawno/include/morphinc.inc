new pdistance = 1;
forward NameTimer();
Float:GetPointDistanceToPointExMorph(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2)
{
new Float:x, Float:y, Float:z;
x = x1-x2;
y = y1-y2;
z = z1-z2;
return floatsqroot(x*x+y*y+z*z);
}
stock SetPDistance(dista)
{
pdistance = dista;
}
stock GetPDistance()
{
return pdistance;
}
stock EnableDistancedNameTag(delay)
{
SetTimer("NameTimer",delay,1);
}
forward NameTimer();
public NameTimer()
	{
	for(new i = 0;i < MAX_PLAYERS;i++)
 	{
 	if(IsPlayerConnected(i))
 	{
 	for(new q = 0;q < MAX_PLAYERS;q++)
 	{
	if(IsPlayerConnected(q))
	{
 	new Float:p1x;
	new Float:p1y;
	new Float:p1z;
	new Float:p2x;
	new Float:p2y;
	new Float:p2z;
	if(IsPlayerConnected(i) && IsPlayerConnected(q))
	{
	GetPlayerPos(i,p1x,p1y,p1z);
    GetPlayerPos(q,p2x,p2y,p2z);
	if(GetPointDistanceToPointExMorph(p1x,p1y,p1z,p2x,p2y,p2z) < pdistance)
		{
	    ShowPlayerNameTagForPlayer(i,q,1);
	    }
	else
		{
		ShowPlayerNameTagForPlayer(i,q,0);
		}
	}}}}}
}