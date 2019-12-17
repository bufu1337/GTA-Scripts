/*
Deer Hunting v1.01 for SAMP - by Dinnozor
English Version

Hunt deers in the country near LS !

v1.01 fixes :
-Use of GetPlayerCameraFrontVector instead of GetPlayerFacingAngle : checks the Z coord, you can't "cheat" only using your facing angle :)
-Modified the FinDeer function because it had a bug when you picked the meat. If you clicked several times on LMB you could take more. -Fixed
-Corrected a bug of the deer orientation during its movement
-a few little bugs fixed

Please don't remove credits if shared. Modify, customize and use as you want to.
Enjoy !
*/

#include <a_samp>

#include <streamer>
#include <OPVD>

#define MAX_ANIM 20
#define DEER_SPAWN_LOC 21

forward MovingDeer(DeerID);
forward DestroyDeer(DeerID);
forward FinDeer(DeerID,playerid);

forward Float:Distance(Float:xA,Float:yA,Float:zA,Float:xB,Float:yB,Float:zB);

new Deers[MAX_ANIM],DeerKO[MAX_ANIM],DeerObject[MAX_ANIM];
new DeerMeat[MAX_ANIM],InfectedDeer[MAX_ANIM],DeerMove[MAX_ANIM],MeatPick[MAX_PLAYERS];

enum pInfo
{
	Viande
}
;
new PlayerInfo[MAX_PLAYERS][pInfo];

//Spawn Locations for deers. Of course, if you add areas below, add at least a spawning location for every added area, or the deers will never be belo them...
//You can add as many spawning locations as you want. You just need to replace the DEER_SPAWN_LOC in the top of the script by the actual number of locations (originally it is 21)

new Float:DeerSpawn[DEER_SPAWN_LOC][3]=
{


	{
		-604.803588,-1308.452636,22.106567

	}
	,


	{
		-702.036621,-1309.305297,63.694377

	}
	,


	{
		-630.591491,-889.400268,108.452827

	}
	,


	{
		-992.249938,-930.179138,129.602951

	}
	,


	{
		-935.597717,-1146.799194,129.202728

	}
	,


	{
		-394.224884,87.232124,28.368480

	}
	,


	{
		-636.897583,-92.761047,64.660194

	}
	,


	{
		-2447.039794,-2192.797851,28.498489

	}
	,


	{
		-2224.478759,-2367.201416,32.494483

	}
	,


	{
		-1803.133300,-2423.008789,26.044141

	}
	,


	{
		-1690.161499,-2070.091308,42.189098

	}
	,


	{
		2006.325439,-766.786865,131.285568

	}
	,


	{
		-1817.458251,-1867.854980,86.802558

	}
	,


	{
		2176.190429,-897.414916,84.565956

	}
	,


	{
		2647.276855,-840.732543,70.997520

	}
	,


	{
		2601.860351,-436.280792,73.739181

	}
	,


	{
		2365.430664,-356.828186,59.507225

	}
	,


	{
		927.202453,-10.505444,91.440376

	}
	,


	{
		1092.987304,15.023153,68.779556

	}
	,


	{
		1504.512084,192.802429,22.368137

	}
	,


	{
		1083.728637,362.787322,25.921319

	}
}
;

public OnGameModeInit()
{
	for(new i=0;i<MAX_ANIM;i++)

	{
		new rand=random(DEER_SPAWN_LOC);
		new Float:X=DeerSpawn[rand][0];
		new Float:Y=DeerSpawn[rand][1];
		CreateDeer(X,Y);


	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	MeatPick[playerid]=0;
	return 1;
}

//You need the MapAndreas Include (see my post on SAMP Forums for the link)
stock Float: GetPointZPos(const Float: fX, const Float: fY, &Float: fZ = 0.0)
{
	if(!((-3000.0 < fX < 3000.0) && (-3000.0 < fY < 3000.0)))
	{
		return 0.0;

	}
	static
	File: s_hMap
	;
	if(!s_hMap)
	{
		s_hMap = fopen("SAfull.hmap", io_read);

		if(!s_hMap)
		{
			return 0.0;

		}

	}
	new
	afZ[1]
	;
	fseek(s_hMap, ((6000 * (-floatround(fY, floatround_tozero) + 3000) + (floatround(fX, floatround_tozero) + 3000)) << 1));
	fblockread(s_hMap, afZ);

	return (fZ = ((afZ[0] >>> 16) * 0.01));
}

stock IsPlayerAimingPoint(playerid, Float:X2,Float:Y2,Float:Z2, Float:range,Float:accuracy)
{
	new Float:Dist, Float:xv,Float:yv,Float:zv,Float:xc,Float:yc,Float:zc,Float:xt,Float:yt,Float:zt;
	GetPlayerCameraPos(playerid,xc,yc,zc);
	GetPlayerCameraFrontVector(playerid,xv,yv,zv);

	xt=xc+range*xv;
	yt=yc+range*yv;
	zt=range*zv+zc;

	Dist=floatsqroot(floatpower(floatabs(xt-X2), 2) + floatpower(floatabs(yt-Y2), 2)+floatpower(floatabs(zt-Z2),2));
	if(range<=30)
	{
		if (Dist<=(accuracy+0.017*range))

		{
			return true;

		}

	}
	else
	{
		if (Dist<=(accuracy+0.025*range))

		{
			return true;

		}

	}
	return false;
}

public Float:Distance(Float:xA,Float:yA,Float:zA,Float:xB,Float:yB,Float:zB)
{
	new Float:Dist=floatsqroot((xB-xA)*(xB-xA)+(yB-yA)*(yB-yA)+(zB-zA)*(zB-zA));
	return Dist;
}

public OnPlayerUpdate(playerid)
{
	for(new i=0;i<MAX_ANIM;i++)
	{
		if(IsValidDynamicObject(DeerObject[i])&&Deers[i]>0)

		{
			new Float:xd,Float:yd,Float:zd;
			GetDynamicObjectPos(DeerObject[i],xd,yd,zd);
			if(IsPlayerInAnyVehicle(playerid))

			{
				if(GetVehicleCategory(GetPlayerVehicleID(playerid))!=21)

				{
					if(IsPlayerInRangeOfPoint(playerid,25,xd,yd,zd))

					{
						MovingDeer(i);


					}


				}
				else

				{
					if(IsPlayerInRangeOfPoint(playerid,10,xd,yd,zd))

					{
						MovingDeer(i);


					}


				}


			}
			else if(IsPlayerInRangeOfPoint(playerid,2,xd,yd,zd)&&InfectedDeer[i]==1&&DeerKO[i]==0&&random(15)==0)

			{
				new Float:phealth;
				GetPlayerHealth(playerid,phealth);
				SetPlayerHealth(playerid,floatround(phealth-1,floatround_round));
				OnePlayAnim(playerid,"ped","HIT_wall",4,0,1,1,0,0);
				GameTextForPlayer(playerid,"A deer is attacking you !",3000,6);


			}
			else

			{
				if(IsPlayerInRangeOfPoint(playerid,15,xd,yd,zd))

				{

					if(InfectedDeer[i]==1&&DeerKO[i]==0&&DeerMove[i]==0)

					{
						new Float:xp,Float:yp,Float:zp;
						GetPlayerPos(playerid,xp,yp,zp);
						GetPointZPos(xp,yp,zp);
						if(IsPosInDeerZone(xp,yp))

						{
							DeerMove[i]=1;
							switch(random(2))

							{
								case 0:MoveDynamicObject(DeerObject[i],xp-1,yp,zp+0.3,8,0,0,atan((yp-yd)/(xp-xd)));
								case 1:MoveDynamicObject(DeerObject[i],xp,yp-1,zp+0.3,10,0,0,atan((yp-yd)/(xp-xd)));


							}


						}
						else MovingDeer(i);


					}
					else MovingDeer(i);


				}


			}


		}

	}
	new iCurWeap = GetPlayerWeapon(playerid);
	new iCurAmmo = GetPlayerAmmo(playerid);
	if(iCurWeap==GetPVarInt(playerid,"iCurrentWeapon")&&iCurAmmo!=GetPVarInt(playerid,"iCurrentAmmo"))
	{
		OnPlayerShoot(playerid,GetPVarInt(playerid, "iCurrentAmmo"), iCurAmmo,iCurWeap);
		SetPVarInt(playerid,"iCurrentAmmo",iCurAmmo);

	}
	return 1;
}

stock OnPlayerShoot(playerid,oldammo,newammo,weapon)
{
	for (new i=0;i<MAX_ANIM;i++)

	{
		new Float:X,Float:Y,Float:Z,Float:rx,Float:ry,Float:rz,Float:Z2,Float:xp,Float:yp,Float:zp;
		GetDynamicObjectPos(DeerObject[i],X,Y,Z);
		if(IsPlayerInRangeOfPoint(playerid,100,X,Y,Z))
		{
			GetPlayerPos(playerid,xp,yp,zp);
			new Float:Dist=Distance(xp,yp,zp,X,Y,Z);

			if(IsPlayerAimingPoint(playerid,X,Y,Z,Dist,2.50)==true)

			{
				GetDynamicObjectRot(DeerObject[i],rx,ry,rz);
				GetPointZPos(X,Y,Z2);
				MoveDynamicObject(DeerObject[i],X+0.1,Y,Z2+0.15,0.4,90,0,rz);
				switch(GetPlayerWeapon(playerid))

				{
					case 22,23,33,34:DeerMeat[i]--;
					case 25..27:DeerMeat[i]-=3;
					default:DeerMeat[i]-=2;


				}
				DeerKO[i]=1;


			}

			else

			{
				if(IsPlayerInRangeOfPoint(playerid,45,X,Y,Z)) MovingDeer(i);//Shooting will frighten near deers

			}

		}

	}
}

public OnPlayerCommandText(playerid,cmdtext[])
{
	if (!strcmp(cmdtext,"/resetdeers",true))


	{
		if (PlayerInfo[playerid][AdminLvl]<1) SendClientMessage(playerid,COLOR_RED,"You are not allowed to use this command.");
		else

		{
			for(new i=0;i<MAX_ANIM;i++)

			{
				DestroyDeer(i);
				new rand=random(DEER_SPAWN_LOC);
				new Float:X=DeerSpawn[rand][0];
				new Float:Y=DeerSpawn[rand][1];
				CreateDeer(X,Y);


			}


		}
		return 1;


	}
	return 0;
}

stock CreateDeer(Float:X,Float:Y)
{
	new DeerID=-1;
	for (new i=0;i<MAX_ANIM;i++)

	{
		if(Deers[i]==0)

		{
			DeerID=i;
			i=MAX_ANIM;


		}


	}
	if(DeerID!=-1)

	{
		new Float:Z;
		GetPointZPos(X,Y,Z);
		DeerObject[DeerID]=CreateDynamicObject(19315,X,Y,Z+1,0,0,0,-1,-1,-1,300);
		Deers[DeerID]=1;
		DeerMeat[DeerID]=5+random(10);
		DeerKO[DeerID]=0;
		MovingDeer(DeerID);
		if(random(100)<3) InfectedDeer[DeerID]=1;//Here it will "infect" 3% of the deers. If you don't want any "crazy" deer, just replace these lines with "InfectedDeer[DeerID]=0;". You can also change the 3%, just replace the 3...
		else InfectedDeer[DeerID]=0;


	}
}

public DestroyDeer(DeerID)
{
	DeerMeat[DeerID]=0;
	Deers[DeerID]=0;
	DestroyDynamicObject(DeerObject[DeerID]);
	return 1;
}

public MovingDeer(DeerID)
{
	if(DeerKO[DeerID]==0&&DeerMove[DeerID]==0)

	{
		new Float:X,Float:Y,Float:Z,Float:Xrand,Float:Yrand,Float:Zrand,Float:speedRand,Float:Angle,Float:coef,Float:X2,Float:Y2;
		GetDynamicObjectPos(DeerObject[DeerID],X,Y,Z);
		new rand1=random(2),rand2=random(2);
		if(rand1==0) Xrand=X+10+float(random(10));
		else Xrand=X-10-float(random(10));
		if(rand2==0) Yrand=Y+10+float(random(10));
		else Yrand=Y-10-float(random(10));
		Zrand=GetPointZPos(Xrand,Yrand,Zrand);
		speedRand=7+float(random(9));
		if((Xrand-X)>0&&(Yrand-Y)>0)Angle=atan((Yrand-Y)/(Xrand-X));
		else Angle=atan((Yrand-Y)/(Xrand-X))-180;

		if(floatabs(Zrand-Z)<3.0)

		{
			if(IsPosInDeerZone(Xrand,Yrand))

			{
				GetPointZPos(Xrand,Yrand,Zrand);
				SetDynamicObjectRot(DeerObject[DeerID],0,0,Angle);
				MoveDynamicObject(DeerObject[DeerID],Xrand,Yrand,Zrand+0.3,speedRand,0,0,Angle);
				DeerMove[DeerID]=1;
				SetTimerEx("MovingDeer",10000+random(40000),false,"i",DeerID);//On peut changer la fréquence des mouvements


			}
			else MovingDeer(DeerID);


		}
		else MovingDeer(DeerID);


	}
	return 1;
}

stock IsPosInDeerZone(Float:X,Float:Y)//Areas where the deers can walk/run ; they will not exit them. It is easy to add some areas : take the coords Xmax, Xmin, Ymax and Ymin of the area, and you are done. Note : These zones are around Los Santos, there are none around LV or SF so just add some if you want to.
{
	if(X>-1590.561645&&X<-395.603057&&Y<-816.069274&&Y>-1717.792480) return 1;
	else if(X>-689.845947&&X<197.757766&&Y<138.800338&&Y>-258.169403) return 1;
	else if(X>567.683715&&X<1504.512084&&Y<376.543304&&Y>-37.922641) return 1;
	else if(X>1787.830322&&X<2753.750976&&Y<-310.041870&&Y>-954.100341) return 1;
	else if(X>-2527.260498&&X<-1637.774780&&Y<-1732.938232&&Y>-2647.622802) return 1;
	else return 0;
}

public OnPlayerKeyStateChange(playerid,newkeys,oldkeys)
{
	if (GetPlayerState(playerid)==1)
	{
		if(GetPlayerWeapon(playerid)==4||GetPlayerWeapon(playerid)==8||GetPlayerWeapon(playerid)==9)

		{
			//Knive, katana, chainsaw
			if(HOLDING(KEY_FIRE))

			{
				for(new i=0;i<MAX_ANIM;i++)

				{
					new Float:xd,Float:yd,Float:zd;
					GetDynamicObjectPos(DeerObject[i],xd,yd,zd);
					if(IsPlayerInRangeOfPoint(playerid,3,xd,yd,zd))

					{
						if(IsPlayerAimingPoint(playerid,xd,yd,zd,5,3))

						{
							if(DeerMeat[i]>0&&InfectedDeer[i]==0)

							{
								if(DeerKO[i]==0)

								{
									new Float:X,Float:Y,Float:Z,Float:rx,Float:ry,Float:rz;
									GetDynamicObjectPos(DeerObject[i],X,Y,Z);
									GetDynamicObjectRot(DeerObject[i],rx,ry,rz);
									MoveDynamicObject(DeerObject[i],X,Y,Z,90,ry,0);
									DeerKO[i]=1;


								}
								else

								{
									LoopingAnim(playerid,"BOMBER","BOM_Plant_Loop",4,1,1,1,0,DeerMeat[i]*1000);
									GameTextForPlayer(playerid,"Picking up the meat...",3000,6);
									if(MeatPick[playerid]==0)
									{
										SetTimerEx("FinDeer",1000+random(3000),false,"ii",i,playerid);
										MeatPick[playerid]=1;

									}

								}


							}
							else

							{
								DestroyDeer(i);
								SendClientMessage(playerid,COLOR_GREEN,"You could not find any edible meat on this animal.");
								new rand=random(DEER_SPAWN_LOC);//if you've added any spawn locations, replace the 21
								new Float:X=DeerSpawn[rand][0];
								new Float:Y=DeerSpawn[rand][1];
								CreateDeer(X,Y);


							}


						}


					}


				}


			}

		}
	}
	return 1;
}

public FinDeer(DeerID,playerid)
{
	new str[128];
	PlayerInfo[playerid][Viande]+=DeerMeat[DeerID];//Add this variable to the PlayerInfo. 'viande' means 'meat' FYI ;)
	MeatPick[playerid]=0;
	format(str,sizeof(str),"You picked up %d kg of meat.",DeerMeat[DeerID]);
	DestroyDeer(DeerID);
	SendClientMessage(playerid,COLOR_GREEN,str);
	format(str,sizeof(str),"You are carrying %d kg of meat.",PlayerInfo[playerid][Viande]);
	SendClientMessage(playerid,COLOR_GREEN,str);
	new rand=random(DEER_SPAWN_LOC);//Replace the 21 if you've added locations...
	new Float:X=DeerSpawn[rand][0];
	new Float:Y=DeerSpawn[rand][1];
	CreateDeer(X,Y);
	return 1;
}

public OnDynamicObjectMoved(objectid)
{
	for(new i=0;i<MAX_ANIM;i++)

	{
		if(IsValidDynamicObject(DeerObject[i]))

		{
			DeerMove[i]=0;


		}


	}
	return 1;
}

public OnPlayerVehicleDamage(playerid,vehicleid,Float:damage)
{
	for(new i=0;i<MAX_ANIM;i++)

	{
		new Float:xd,Float:yd,Float:zd;
		GetDynamicObjectPos(DeerObject[i],xd,yd,zd);
		if(IsPlayerInRangeOfPoint(playerid,5,xd,yd,zd))

		{
			new Float:rx,Float:ry,Float:rz;
			GetDynamicObjectRot(DeerObject[i],rx,ry,rz);
			GetPointZPos(xd,yd,zd);
			MoveDynamicObject(DeerObject[i],xd+0.1,yd,zd+0.15,0.3,90,0,rz);
			DeerMeat[i]-=4;
			DeerKO[i]=1;


		}


	}
	return 1;
}

OnePlayAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
	ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp,1);
}