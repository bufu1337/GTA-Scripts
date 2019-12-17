// UseFull Function [ mic_more ]

// Clock System 
/*
native ToggleRealClock(toggle);
*/

public ToggleRealClock(toggle){
if (toggle == 1){
time();
}}

public time(){
new hour,minute,second;
TextDrawHideForAll(Clock);
gettime(hour,minute,second);
new string[256];
if (minute <= 9){format(string,25,"%d:0%d",hour,minute);}
else {format(string,25,"%d:%d",hour,minute);}
TextDrawSetString(Clock,string);
TextDrawShowForAll(Clock);
SetTimer("time",30000,0);
if (hour == 0){SetWorldTime(0);}
if (hour == 1){SetWorldTime(1);}
if (hour == 2){SetWorldTime(2);}
if (hour == 3){SetWorldTime(3);}
if (hour == 4){SetWorldTime(4);}
if (hour == 5){SetWorldTime(5);}
if (hour == 6){SetWorldTime(6);}
if (hour == 7){SetWorldTime(7);}
if (hour == 8){SetWorldTime(8);}
if (hour == 9){SetWorldTime(9);}
if (hour == 10){SetWorldTime(10);}
if (hour == 11){SetWorldTime(11);}
if (hour == 12){SetWorldTime(12);}
if (hour == 13){SetWorldTime(13);}
if (hour == 14){SetWorldTime(14);}
if (hour == 15){SetWorldTime(15);}
if (hour == 16){SetWorldTime(16);}
if (hour == 17){SetWorldTime(17);}
if (hour == 18){SetWorldTime(18);}
if (hour == 19){SetWorldTime(19);}
if (hour == 20){SetWorldTime(20);}
if (hour == 21){SetWorldTime(21);}
if (hour == 22){SetWorldTime(22);}
if (hour == 23){SetWorldTime(23);}
if (hour == 24){SetWorldTime(24);}
return 1;
}

// Gym System

/*
native EnableGantonGym(toggle);
*/

public EnableGantonGym(toggle){
if(toggle==1){
GantonGym = 1;
}
}

public IsInGym12(playerid){
if (GEOFF[playerid] ==1){
SetTimer("IsInGym12",50,0);
ApplyAnimation(playerid,"GYMNASIUM","gym_tread_jog",4.1,0,1,1,1,1);
ApplyAnimation(playerid,"GYMNASIUM","gym_tread_jog",4.1,0,1,1,1,1);
//print("GetGoing");
new Float:ghealth;
GetPlayerHealth(playerid,ghealth);
SetPlayerHealth(playerid,ghealth+2);
}}

public IsInGym1(playerid){
new keys,ud,lr;
GetPlayerKeys(playerid,keys,ud,lr);
if(keys == KEY_SECONDARY_ATTACK){
ApplyAnimation(playerid,"GYMNASIUM","gym_tread_geton",4.1,0,1,1,1,1);
ApplyAnimation(playerid,"GYMNASIUM","gym_tread_geton",4.1,0,1,1,1,1);
print("GetOn");
SetTimer("IsInGym12",3000,0);
GEOFF[playerid] = 1;
}
else if(keys == KEY_SPRINT){
GEOFF[playerid] = 0;
KillTimer(gymt1);
ApplyAnimation(playerid,"GYMNASIUM","gym_walk_falloff",4.1,0,1,1,1,1);
ApplyAnimation(playerid,"GYMNASIUM","gym_walk_falloff",4.1,0,1,1,1,1);
SetTimer("killgym",3500,0);
}
}
public killgym(playerid){
print("GetOff");
TogglePlayerControllable(playerid,1);
ClearAnimations(playerid);
ClearAnimations(playerid);
}

// Rotate Object
/*
native RotateObject(objectid,Float:rx,Float:ry,Float:rz,speed);
*/

public RobjectHandler(objectid,Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2,speed)
{
	new k = 0;
	if(x1 != x2)
	{
	SetObjectRot(objectid,x1+1,y1,z1);
//	SetTimerEx("RobjectHandler",speed,0,"iffffffi",objectid,x1+1,y1+1,z1+1,x2,y2,z2,speed);
	k = 1;
	}
	if(y1 != y2)
	{
	SetObjectRot(objectid,x1,y1+1,z1);
//	SetTimerEx("RobjectHandler",speed,0,"iffffffi",objectid,x1+1,y1+1,z1+1,x2,y2,z2,speed);
	k = 1;
	}
	if(z1 != z2)
	{
	SetObjectRot(objectid,x1,y1,z1+1);
//	SetTimerEx("RobjectHandler",speed,0,"iffffffi",objectid,x1+1,y1+1,z1+1,x2,y2,z2,speed);
	k = 1;
	}
	if(k == 1)
	{
		GetObjectRot(objectid,x1,y1,z1);
		SetTimerEx("RobjectHandler",speed,0,"iffffffi",objectid,x1,y1,z1,x2,y2,z2,speed);
	}
}

public RotateObject(objectid,Float:rx,Float:ry,Float:rz,speed)
{
	speed = 1000/speed;
	new Float:x,Float:y,Float:z;
	GetObjectRot(objectid,x,y,z);
	RobjectHandler(objectid,x,y,z,rx,ry,rz,speed);
}

/*
native strcut(string[],substring[]);
native fline(File:handle,line);
native fnew(const string[]);
native TakePlayerMoney(playerid,money);
*/
public strcut(string[],substring[]){
new fn = strfind(string,substring);
new ln = strlen(substring);
strdel(string,fn,fn+ln);
}

public fline(File:handle,line){
new str[256],siz,i,sav;
while(line-1 != i){
fread(handle,str);
siz = strlen(str);
sav = sav +siz;
fseek(handle,sav+siz+1);
i++;
}
}
public fnew(const string[]){
new File:handle = fopen(string,io_append);
fclose(handle);
}
