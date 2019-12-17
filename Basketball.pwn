#include <a_samp>

new HavingBall[MAX_PLAYERS];
new Anim[MAX_PLAYERS];
new Ball;
new BallStatus;
new Baller;
new ShootingBall;
new BallBounce;

public OnFilterScriptInit()
{
	Baller = 999;
	DestroyObject(Ball);
	Ball = CreateObject(2114, 2782.3027,-2019.0826,13.5547-0.8, 0, 0, 96);
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnObjectMoved(objectid)
{
    new i = Baller;
    if(ShootingBall == 2)
    {
		BallDown2(i);
		return 1;
    }
    else if(ShootingBall == 3)
    {
		BallDown3(i);
		return 1;
    }
    else if(ShootingBall == 4)
    {
		BallDown4(i);
		return 1;
    }
    else if(ShootingBall == 5)
    {
		BallDown5(i);
		return 1;
    }
    else if(ShootingBall == 6)
    {
        ApplyAnimation(i,"BSKTBALL","BBALL_walk",4.1,1,1,1,1,1);
		HavingBall[i] = 1;
		Anim[i] = 0;
    }
    if(BallBounce == 1)
    {
        new Float:x, Float:y, Float:z;
	    GetObjectPos(Ball, x, y, z);
	    MoveObject(Ball, x, y, z+1.2, 4);
	    BallBounce = 2;
	}
	else if(BallBounce == 2)
    {
        new Float:x, Float:y, Float:z;
	    GetObjectPos(Ball, x, y, z);
	    MoveObject(Ball, x, y, z-1.2, 4);
	    BallBounce = 3;
	}
	else if(BallBounce == 3)
    {
        new Float:x, Float:y, Float:z;
	    GetObjectPos(Ball, x, y, z);
	    MoveObject(Ball, x, y, z+0.8, 3);
	    BallBounce = 4;
	}
	else if(BallBounce == 4)
    {
        new Float:x, Float:y, Float:z;
	    GetObjectPos(Ball, x, y, z);
	    MoveObject(Ball, x, y, z-0.8, 3);
	    BallBounce = 5;
	}
	else if(BallBounce == 5)
    {
        new Float:x, Float:y, Float:z;
	    GetObjectPos(Ball, x, y, z);
	    MoveObject(Ball, x, y, z+0.5, 2);
	    BallBounce = 6;
	}
	else if(BallBounce == 6)
    {
        new Float:x, Float:y, Float:z;
	    GetObjectPos(Ball, x, y, z);
	    MoveObject(Ball, x, y, z-0.5, 2);
	    BallBounce = 7;
	}
	else if(BallBounce == 7)
    {
        new Float:x, Float:y, Float:z;
	    GetObjectPos(Ball, x, y, z);
	    MoveObject(Ball, x, y, z+0.2, 1);
	    BallBounce = 8;
	}
	else if(BallBounce == 8)
    {
        new Float:x, Float:y, Float:z;
	    GetObjectPos(Ball, x, y, z);
	    MoveObject(Ball, x, y, z-0.2, 1);
	    BallBounce = 0;
	}
    if(!HavingBall[i]) return 1;
	new Keys, ud, lr;
	GetPlayerKeys(i, Keys, ud, lr);
    if(Anim[i])
    {
        switch(BallStatus)
	    {
			case 0:
			{
				BallStatus = 1;
				new Float:x, Float:y, Float:z;
				GetPlayerPos(i, x, y, z);
				StopObject(Ball);
				new Float:x2, Float:y2;
		 	    GetXYInFrontOfPlayer(i, x2, y2, 0.4);
				MoveObject(Ball, x2, y2, z+0.1, 5.5);
			}
			case 1:
			{
        		BallStatus = 0;
        		new Float:x, Float:y, Float:z;
				GetPlayerPos(i, x, y, z);
				StopObject(Ball);
				new Float:x2, Float:y2;
				GetXYInFrontOfPlayer(i, x2, y2, 0.4);
				MoveObject(Ball, x2, y2, z-0.8, 5.5);
			}
		}
		return 1;
    }
    if(Keys & KEY_SPRINT)
	{
        ApplyAnimation(i,"BSKTBALL","BBALL_run",4.1,1,1,1,1,1);
        switch(BallStatus)
		{
			case 0:
			{
				BallStatus = 1;
				new Float:x, Float:y, Float:z;
				GetPlayerPos(i, x, y, z);
				StopObject(Ball);
				new Float:x2, Float:y2;
		        GetXYInFrontOfPlayer(i, x2, y2, 1.5);
				MoveObject(Ball, x2, y2, z+0.1, 8);
			}
			case 1:
			{
        		BallStatus = 0;
        		new Float:x, Float:y, Float:z;
				GetPlayerPos(i, x, y, z);
				StopObject(Ball);
				new Float:x2, Float:y2;
				GetXYInFrontOfPlayer(i, x2, y2, 1.5);
				MoveObject(Ball, x2, y2, z-0.8, 8);
			}
		}
		return 1;
    }
    else
    {
        ApplyAnimation(i,"BSKTBALL","BBALL_walk",4.1,1,1,1,1,1);
    }
	switch(BallStatus)
	{
		case 0:
		{
			BallStatus = 1;
			new Float:x, Float:y, Float:z;
			GetPlayerPos(i, x, y, z);
			StopObject(Ball);
			new Float:x2, Float:y2;
		    GetXYInFrontOfPlayer(i, x2, y2, 1.2);
			MoveObject(Ball, x2, y2, z+0.1, 5);
		}
		case 1:
		{
        	BallStatus = 0;
        	new Float:x, Float:y, Float:z;
			GetPlayerPos(i, x, y, z);
			StopObject(Ball);
			new Float:x2, Float:y2;
			GetXYInFrontOfPlayer(i, x2, y2, 1.2);
			MoveObject(Ball, x2, y2, z-0.8, 5);
		}
	}
    return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    HavingBall[playerid] = 0;
    Anim[playerid] = 0;
    if(HavingBall[playerid]) Baller = 999;
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    HavingBall[playerid] = 0;
    if(HavingBall[playerid]) Baller = 999;
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/ball", cmdtext, true, 6) == 0)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		DestroyObject(Ball);
		Ball = CreateObject(2114, x+random(3), y+random(3), z-0.8, 0, 0, 96);
		return 1;
	}
	return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if ((newkeys & KEY_CROUCH) && !(oldkeys & KEY_CROUCH) && !IsPlayerInAnyVehicle(playerid))
	{
		if(HavingBall[playerid])
		{
            ApplyAnimation(playerid,"BSKTBALL","BBALL_idleloop",4.1,1,1,1,1,1);
		}
		else
		{
            ApplyAnimation(playerid,"BSKTBALL","BBALL_def_loop",4.0,1,0,0,0,0);
		}
		Anim[playerid] = 1;
	}
	if (!(newkeys & KEY_CROUCH) && (oldkeys & KEY_CROUCH) && !IsPlayerInAnyVehicle(playerid))
	{
		ClearAnimations(playerid);
		Anim[playerid] = 0;
	}
	if(newkeys & KEY_FIRE && !IsPlayerInAnyVehicle(playerid))
	{
        if(!HavingBall[playerid])
		{
			new Float:x, Float:y, Float:z;
			GetObjectPos(Ball, x, y, z);
			if(IsPlayerInRangeOfPoint(playerid, 1.5, x, y, z))
			{
				HavingBall[playerid] = 1;
				ApplyAnimation(playerid,"BSKTBALL","BBALL_pickup",4.0,0,0,0,0,0);
				if(Baller != 999)
				{
					HavingBall[Baller] = 0;
					ClearAnimations(Baller);
					ApplyAnimation(Baller, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0);
					ApplyAnimation(playerid,"BSKTBALL","BBALL_walk",4.1,1,1,1,1,1);
				}
				Baller = playerid;
				BallStatus = 1;
				new Float:x2, Float:y2;
				GetXYInFrontOfPlayer(playerid, x2, y2, 0.8);
				GetPlayerPos(playerid, x, y, z);
				StopObject(Ball);
				MoveObject(Ball, x2, y2, z, 2.5);
				Anim[playerid] = 0;
				BallBounce = 0;
			}
		}
		else
		{
            if(IsPlayerInRangeOfPoint(playerid, 2, 2795.5237,-2019.6152,13.5547))
			{
				MoveObject(Ball, 2794.9612,-2019.5415,15.5075, 7.5);
				SetPlayerPos(playerid, 2795.5237,-2019.6152,13.5547);
				ApplyAnimation(playerid,"BSKTBALL","BBALL_Dnk",4.0,1,0,0,0,0);
				HavingBall[playerid] = 0;
				SetTimerEx("ClearAnim", 1100, 0, "d", playerid);
				SetTimerEx("BallDown2", 1100, 0, "d", playerid);
				return 1;
			}
            else if(IsPlayerInRangeOfPoint(playerid, 4, 2795.5237,-2019.6152,13.5547) && IsPlayerFacingPoint(playerid, 20, 2795.5237,-2019.6152,13.5547))
			{
				new rand = random(1);
				if(rand == 0)
				{
					MoveObject(Ball, 2794.9612,-2019.5415,15.5075, 10.5+random(4));
					ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
					ShootingBall = 2;
					HavingBall[playerid] = 0;
					return 1;
				}
				ShootMiss(playerid);
				return 1;
			}
            else if(IsPlayerInRangeOfPoint(playerid, 7, 2795.5237,-2019.6152,13.5547) && IsPlayerFacingPoint(playerid, 20, 2795.5237,-2019.6152,13.5547))
			{
				new rand = random(2);
				if(rand == 0)
				{
					MoveObject(Ball, 2794.9612,-2019.5415,15.5075, 11.0+random(4));
					ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
					ShootingBall = 2;
					HavingBall[playerid] = 0;
					return 1;
				}
				ShootMiss(playerid);
				return 1;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 10, 2795.5237,-2019.6152,13.5547) && IsPlayerFacingPoint(playerid, 20, 2795.5237,-2019.6152,13.5547))
			{
				new rand = random(3);
				if(rand == 0)
				{
					MoveObject(Ball, 2794.9612,-2019.5415,15.5075, 11.5+random(4));
					ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
					ShootingBall = 2;
					HavingBall[playerid] = 0;
					return 1;
				}
				ShootMiss(playerid);
				return 1;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 2, 2768.3669,-2019.6644,13.5547))
			{
				MoveObject(Ball, 2768.6289,-2019.7227,15.6287, 7.5);
				SetPlayerPos(playerid, 2768.3669,-2019.6644,13.5547);
				ApplyAnimation(playerid,"BSKTBALL","BBALL_Dnk",4.0,1,0,0,0,0);
				HavingBall[playerid] = 0;
				SetTimerEx("ClearAnim", 800, 0, "d", playerid);
				SetTimerEx("BallDown3", 1100, 0, "d", playerid);
				return 1;
			}
            else if(IsPlayerInRangeOfPoint(playerid, 4, 2768.3669,-2019.6644,13.5547) && IsPlayerFacingPoint(playerid, 20, 2768.3669,-2019.6644,13.5547))
			{
				new rand = random(1);
				if(rand == 0)
				{
					MoveObject(Ball, 2768.6289,-2019.7227,15.6287, 10.5+random(4));
					ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
					ShootingBall = 3;
					HavingBall[playerid] = 0;
					return 1;
				}
				ShootMiss2(playerid);
				return 1;
			}
            else if(IsPlayerInRangeOfPoint(playerid, 7, 2768.3669,-2019.6644,13.5547) && IsPlayerFacingPoint(playerid, 20, 2768.3669,-2019.6644,13.5547))
			{
				new rand = random(2);
				if(rand == 0)
				{
					MoveObject(Ball, 2768.6289,-2019.7227,15.6287, 11.0+random(4));
					ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
					ShootingBall = 3;
					HavingBall[playerid] = 0;
					return 1;
				}
				ShootMiss2(playerid);
				return 1;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 10, 2768.3669,-2019.6644,13.5547) && IsPlayerFacingPoint(playerid, 20, 2768.3669,-2019.6644,13.5547))
			{
				new rand = random(3);
				if(rand == 0)
				{
					MoveObject(Ball, 2768.6289,-2019.7227,15.6287, 11.5+random(4));
					ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
					ShootingBall = 3;
					HavingBall[playerid] = 0;
					return 1;
				}
                ShootMiss2(playerid);
				return 1;
			}
			for(new i; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(IsPlayerFacingPlayer(playerid, i, 15))
					{
						new Float:x, Float:y, Float:z;
						GetPlayerPos(i, x, y, z);
						if(IsPlayerInRangeOfPoint(playerid, 20.0, x, y, z))
						{
							Baller = i;
							HavingBall[playerid] = 0;
							ClearAnimations(playerid);
							ApplyAnimation(playerid,"BSKTBALL","BBALL_def_loop",4.0,1,0,0,0,0);
							SetTimerEx("ClearAnim", 700, 0, "d", playerid);
							MoveObject(Ball, x, y, z, 13+random(4));
							Anim[i] = 0;
							ShootingBall = 6;
							ApplyAnimation(i,"BSKTBALL","BBALL_def_loop",4.0,1,0,0,0,0);
							return 1;
						}
					}
				}
			}
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);
			HavingBall[playerid] = 0;
			new Float:x2, Float:y2;
			GetXYInFrontOfPlayer(playerid, x2, y2, 6.0);
			SetTimerEx("BallDown", 600, 0, "df", playerid, z);
			MoveObject(Ball, x2, y2, z+random(8)+3, 10.0+random(4));
			ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
			ShootingBall = 0;
		}
	}
	return 1;
}

stock IsPlayerFacingPoint(playerid, Float:dOffset, Float:pX, Float:pY, Float:pZ)
{
	#pragma unused pZ
	new
		Float:X,
		Float:Y,
		Float:Z,
		Float:pA,
		Float:ang;

	if(!IsPlayerConnected(playerid)) return 0;

	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, pA);

	if( Y > pY ) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	else if( Y < pY && X < pX ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	else if( Y < pY ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);

	if(AngleInRangeOfAngle(-ang, pA, dOffset)) return true;

	return false;

}

stock IsPlayerFacingPlayer(playerid, targetid, Float:dOffset)
{

	new
		Float:pX,
		Float:pY,
		Float:pZ,
		Float:pA,
		Float:X,
		Float:Y,
		Float:Z,
		Float:ang;

	if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)) return 0;

	GetPlayerPos(targetid, pX, pY, pZ);
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, pA);

	if( Y > pY ) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	else if( Y < pY && X < pX ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	else if( Y < pY ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);

	if(AngleInRangeOfAngle(-ang, pA, dOffset)) return true;

	return false;

}

stock AngleInRangeOfAngle(Float:a1, Float:a2, Float:range)
{

	a1 -= a2;
	if((a1 < range) && (a1 > -range)) return true;

	return false;

}

forward BallDown(playerid, Float:oldz);
public BallDown(playerid, Float:oldz)
{
    new Float:x, Float:y, Float:z;
	GetObjectPos(Ball, x, y, z);
	new Float:a;
	new Float:x2, Float:y2;
	GetPlayerPos(playerid, x2, y2, a);
	GetPlayerFacingAngle(playerid, a);
	x2 += (16 * floatsin(-a, degrees));
	y2 += (16 * floatcos(-a, degrees));
	MoveObject(Ball, x2, y2, oldz-0.8, 10.0+random(3));
	Baller = 999;
	ShootingBall = 0;
	BallBounce = 1;
	return 1;
}

forward BallDown2(playerid);
public BallDown2(playerid)
{
	MoveObject(Ball, 2795.5237,-2019.6152,13.5547-0.8, 10.0+random(3));
	Baller = 999;
	ShootingBall = 0;
	GameTextForPlayer(playerid, "Goal :D!", 3000, 3);
	BallBounce = 1;
	return 1;
}

forward BallDown3(playerid);
public BallDown3(playerid)
{
	MoveObject(Ball, 2768.3669,-2019.6644,13.5547-0.8, 10.0+random(3));
	Baller = 999;
	ShootingBall = 0;
	GameTextForPlayer(playerid, "Goal :D!", 3000, 3);
	BallBounce = 1;
	return 1;
}

forward BallDown4(playerid);
public BallDown4(playerid)
{
	MoveObject(Ball, 2795.5237+random(5),-2019.6152+random(5),13.5547-0.8, 10.0+random(3));
	Baller = 999;
	ShootingBall = 0;
	GameTextForPlayer(playerid, "Missed :(!", 3000, 3);
	BallBounce = 1;
	return 1;
}

forward BallDown5(playerid);
public BallDown5(playerid)
{
	MoveObject(Ball, 2768.3669+random(5),-2019.6644+random(5),13.5547-0.8, 10.0+random(3));
	Baller = 999;
	ShootingBall = 0;
	GameTextForPlayer(playerid, "Missed :(!", 3000, 3);
	BallBounce = 1;
	return 1;
}

forward ShootMiss(playerid);
public ShootMiss(playerid)
{
	MoveObject(Ball, 2794.9612+random(2), -2019.5415+random(2), 15.5075+random(2), 12.5+random(4));
	ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
	ShootingBall = 4;
	HavingBall[playerid] = 0;
	return 1;
}

forward ShootMiss2(playerid);
public ShootMiss2(playerid)
{
	MoveObject(Ball, 2768.6289+random(2),-2019.7227+random(2),15.6287+random(2), 12.5+random(4));
	ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
	ShootingBall = 5;
	HavingBall[playerid] = 0;
	return 1;
}

forward ClearAnim(playerid);
public ClearAnim(playerid)
{
	ClearAnimations(playerid);
	return 1;
}

GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	if (GetPlayerVehicleID(playerid))
	{
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}