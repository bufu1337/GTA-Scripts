#include <a_samp>

#define DS 10000

// Airstriking FS by CJ101
// Do Not remove credits.

new CalledStrike[MAX_PLAYERS];
new Airstrike[MAX_PLAYERS];
new Adromada;
new Airstriking[MAX_PLAYERS];

public OnPlayerConnect(playerid)
{
    Airstriking[playerid] = 0;
	CalledStrike[playerid] = 0;
	Airstrike[playerid] = 0;
	Adromada = 0;
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DS) // Cars
    {
		if(listitem == 0)
        {
        if(!response) return 1;
        if(Airstriking[playerid] == 1) return SendClientMessage(playerid,0xFF0000AA,"Please Wait");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		Airstrike[playerid] = 1;
		Adromada = CreateObject(14553,x-55,y,z+75,0.000000,0.000000,90);
        MoveObject(Adromada,x+250,y,z+75,29);
        Airstriking[playerid] = 1;
		SetTimerEx("AirstrikeGo",5000,false,"dfffd",playerid,x,y,z,Airstrike[playerid]);
		}

		if(listitem == 1)
        {
        if(!response) return 1;
        if(Airstriking[playerid] == 1) return SendClientMessage(playerid,0xFF0000AA,"Please Wait");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		Airstrike[playerid] = 2;
		Adromada = CreateObject(14553,x-55,y,z+75,0.000000,0.000000,90);
        MoveObject(Adromada,x+250,y,z+75,29);
        Airstriking[playerid] = 1;
		SetTimerEx("AirstrikeGo",5000,false,"dfffd",playerid,x,y,z,Airstrike[playerid]);
		}

		if(listitem == 2)
        {
        if(!response) return 1;
        if(Airstriking[playerid] == 1) return SendClientMessage(playerid,0xFF0000AA,"Please Wait");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		Airstrike[playerid] = 3;
		Adromada = CreateObject(14553,x-55,y,z+75,0.000000,0.000000,90);
        MoveObject(Adromada,x+250,y,z+75,29);
        Airstriking[playerid] = 1;
		SetTimerEx("AirstrikeGo",5000,false,"dfffd",playerid,x,y,z,Airstrike[playerid]);
		}

		if(listitem == 3)
        {
        if(!response) return 4;
        if(Airstriking[playerid] == 1) return SendClientMessage(playerid,0xFF0000AA,"Please Wait");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		Airstrike[playerid] = 4;
		Adromada = CreateObject(14553,x-55,y,z+75,0.000000,0.000000,90);
        MoveObject(Adromada,x+250,y,z+75,29);
        Airstriking[playerid] = 1;
		SetTimerEx("AirstrikeGo",5000,false,"dfffd",playerid,x,y,z,Airstrike[playerid]);
		}

		if(listitem == 4)
        {
        if(!response) return 1;
        if(Airstriking[playerid] == 1) return SendClientMessage(playerid,0xFF0000AA,"Please Wait");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		Airstrike[playerid] = 5;
		new Float:ang;
		GetPlayerFacingAngle(playerid,ang);
		Adromada = CreateObject(14553,x-55,y,z+75,0.000000,0.000000,90);
        MoveObject(Adromada,x+250,y,z+75,29);
        Airstriking[playerid] = 1;
		SetTimerEx("AirstrikeGo",5000,false,"dfffd",playerid,x,y,z,Airstrike[playerid]);
		}

		if(listitem == 5)
        {
        if(!response) return 1;
        if(Airstriking[playerid] == 1) return SendClientMessage(playerid,0xFF0000AA,"Please Wait");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		Airstrike[playerid] = 6;
  		Adromada = CreateObject(14553,x-55,y,z+75,0.000000,0.000000,90);
        MoveObject(Adromada,x+250,y,z+75,29);
        Airstriking[playerid] = 1;
		SetTimerEx("AirstrikeGo",5000,false,"dfffd",playerid,x,y,z,Airstrike[playerid]);
		}

		if(listitem == 6)
		{
        if(!response) return 1;
        if(Airstriking[playerid] == 1) return SendClientMessage(playerid,0xFF0000AA,"Please Wait");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		Airstrike[playerid] = 7;
  		Adromada = CreateObject(14553,x-55,y,z+75,0.000000,0.000000,90);
        MoveObject(Adromada,x+250,y,z+75,29);
        Airstriking[playerid] = 1;
		SetTimerEx("AirstrikeGo",5000,false,"dfffd",playerid,x,y,z,Airstrike[playerid]);
		}

		if(listitem == 7)
        {
        if(!response) return 1;
        if(Airstriking[playerid] == 1) return SendClientMessage(playerid,0xFF0000AA,"Please Wait");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		Airstrike[playerid] = 8;
  		Adromada = CreateObject(14553,x,y,z+75,0.000000,0.000000,90);
        MoveObject(Adromada,x+250,y,z+75,26);
        Airstriking[playerid] = 1;
		SetTimerEx("AirstrikeGo",5000,false,"dfffd",playerid,x,y,z,Airstrike[playerid]);
		}

		if(listitem == 8)
        {
        if(!response) return 1;
        if(Airstriking[playerid] == 1) return SendClientMessage(playerid,0xFF0000AA,"Please Wait");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		Airstrike[playerid] = 9;
  		Adromada = CreateObject(14553,x-55,y,z+75,0.000000,0.000000,90);
        MoveObject(Adromada,x+250,y,z+75,29);
        Airstriking[playerid] = 1;
		SetTimerEx("AirstrikeGo",5000,false,"dfffd",playerid,x,y,z,Airstrike[playerid]);
		}

		if(listitem == 9)
        {
        if(!response) return 1;
        if(Airstriking[playerid] == 1) return SendClientMessage(playerid,0xFF0000AA,"Please Wait");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		Airstrike[playerid] = 10;
  		Adromada = CreateObject(14553,x-55,y,z+75,0.000000,0.000000,90);
        MoveObject(Adromada,x+250,y,z+75,29);
        Airstriking[playerid] = 1;
		SetTimerEx("AirstrikeGo",5000,false,"dfffd",playerid,x,y,z,Airstrike[playerid]);
		}

		if(listitem == 10)
	  	{
        if(!response) return 1;
        if(Airstriking[playerid] == 1) return SendClientMessage(playerid,0xFF0000AA,"Please Wait");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		Airstrike[playerid] = 11;
  		Adromada = CreateObject(14553,x-50,y,z+75,0.000000,40.000000,90);
        MoveObject(Adromada,x+250,y,z+75,29);
        Airstriking[playerid] = 1;
		SetTimerEx("AirstrikeGo",6000,false,"dfffd",playerid,x,y,z,Airstrike[playerid]);
		}

		if(listitem == 11)
	  	{
        if(!response) return 1;
        if(Airstriking[playerid] == 1) return SendClientMessage(playerid,0xFF0000AA,"Please Wait");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		Airstrike[playerid] = 12;
  		Adromada = CreateObject(354,x,y,z+75,0.000000,0.000000,0.000000);
        MoveObject(Adromada,x,y,z,29);
        Airstriking[playerid] = 1;
		SetTimerEx("AirstrikeGo",4000,false,"dfffd",playerid,x,y,z,Airstrike[playerid]);
		}

		if(listitem == 12)
	  	{
        if(!response) return 1;
        if(Airstriking[playerid] == 1) return SendClientMessage(playerid,0xFF0000AA,"Please Wait");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		Airstrike[playerid] = 13;
  		Adromada = CreateObject(354,x,y,z+75,0.000000,0.000000,0.000000);
        MoveObject(Adromada,x,y,z,29);
        Airstriking[playerid] = 1;
		SetTimerEx("AirstrikeGo",3000,false,"dfffd",playerid,x,y,z,Airstrike[playerid]);
		}

		if(listitem == 13)
	  	{
        if(!response) return 1;
        if(Airstriking[playerid] == 1) return SendClientMessage(playerid,0xFF0000AA,"Please Wait");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		Airstrike[playerid] = 14;
  		Adromada = CreateObject(354,x,y,z+75,0.000000,0.000000,0.000000);
        MoveObject(Adromada,x,y,z,30);
        Airstriking[playerid] = 1;
		SetTimerEx("AirstrikeGo",3000,false,"dfffd",playerid,x,y,z,Airstrike[playerid]);
		}

		if(listitem == 14)
	  	{
        if(!response) return 1;
        if(Airstriking[playerid] == 1) return SendClientMessage(playerid,0xFF0000AA,"Please Wait");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		Airstrike[playerid] = 15;
  		Adromada = CreateObject(354,x,y,z+75,0.000000,0.000000,0.000000);
        MoveObject(Adromada,x,y,z,30);
        Airstriking[playerid] = 1;
		SetTimerEx("AirstrikeGo",3000,false,"dfffd",playerid,x,y,z,Airstrike[playerid]);
		}
	}

	return 1;
}

forward AirstrikeGo3(playerid,Float:x,Float:y,Float:z,type);
public AirstrikeGo3(playerid,Float:x,Float:y,Float:z,type)
{
	if(type == 1)
	{
 		CreateExplosion(x,y+5,z,6,5);
	    CreateExplosion(x,y+6,z,6,5);
     	CreateExplosion(x,y+7,z,6,5);
     	CreateExplosion(x,y+8,z,6,5);
  	}

  	if(type == 2)
	{
  		CreateExplosion(x,y,z,7,10);
	    CreateExplosion(x,y,z+3,7,10);
	    CreateExplosion(x,y,z+6,7,10);
	    CreateExplosion(x,y,z+9,7,10);
	    CreateExplosion(x,y,z+12,7,10);
	    CreateExplosion(x,y,z+15, 7, 10);
	    CreateExplosion(x,y,z+18,7,10);
	    CreateExplosion(x,y,z+21,7,10);
	    CreateExplosion(x,y+3,z+21,7,10);
	    CreateExplosion(x,y-3,z+21,7,10);
	    CreateExplosion(x+3,y,z+21,7,10);
    	CreateExplosion(x-3,y,z+21,7,10);
	}

	if(type == 3)
	{
		CreateExplosion(x,y,z,6,5);
	    CreateExplosion(x+3,y,z,6,5);
	    CreateExplosion(x+2,y,z,6,5);
	    CreateExplosion(x+4,y,z,6,5);
	    CreateExplosion(x+6,y,z,6,5);
	    CreateExplosion(x+8,y,z,6,5);
	    CreateExplosion(x+10,y,z,6,5);
	    CreateExplosion(x+12,y,z,6,5);
	    CreateExplosion(x+14,y,z,6,5);
	    CreateExplosion(x+16,y,z,6,5);
	    CreateExplosion(x+18,y,z,6,5);
	    CreateExplosion(x+20,y,z,6,5);
	    CreateExplosion(x+22,y,z,6,5);
	    CreateExplosion(x+24,y,z,6,5);
	    CreateExplosion(x+26,y,z,6,5);
	    CreateExplosion(x+28,y,z,6,5);
	    CreateExplosion(x+30,y,z,6,5);
	    CreateExplosion(x+32,y,z,6,5);
	}

	if(type == 4)
	{
	    CreateExplosion(x,y,z,6,5);
	    CreateExplosion(x+1,y,z,6,5);
	    CreateExplosion(x+3,y,z,6,5);

	}
	return 1;
}

forward AirstrikeGo2(playerid,Float:x,Float:y,Float:z,type);
public AirstrikeGo2(playerid,Float:x,Float:y,Float:z,type)
{
	if(type == 1)
	{
 		CreateExplosion(x,y+5,z,6,5);
	    CreateExplosion(x,y+6,z,6,5);
     	CreateExplosion(x,y+7,z,6,5);
     	CreateExplosion(x,y+8,z,6,5);
  	}

	if(type == 2)
	{
 		CreateExplosion(x-8,y,z,6,5);
	    CreateExplosion(x+8,y+6,z,6,5);
	    CreateExplosion(x-12,y,z,6,5);
	    CreateExplosion(x+12,y+6,z,6,5);
	    SetTimerEx("AirstrikeGo3",2000,false,"dfffd",playerid,x,y,z,1);

  	}

	if(type == 3)
	{
 		CreateExplosion(x+4,y,z,6,5);
	    CreateExplosion(x-4,y,z,6,5);
	    CreateExplosion(x+4,y+2,z+2,6,5);
	    CreateExplosion(x-4,y+2,z+2,6,5);
	    SetTimerEx("AirstrikeGo3",2000,false,"dfffd",playerid,x,y,z,2);

  	}

  	if(type == 4)
	{
 		CreateExplosion(x,y,z+7,6,5);
	    CreateExplosion(x+3,y,z+7,6,5);
	    CreateExplosion(x+2,y,z+7,6,5);
	    CreateExplosion(x+4,y,z+7,6,5);
	    CreateExplosion(x+6,y,z+7,6,5);
	    CreateExplosion(x+8,y,z+7,6,5);
	    CreateExplosion(x+10,y,z+7,6,5);
	    CreateExplosion(x+12,y,z+7,6,5);
	    CreateExplosion(x+14,y,z+7,6,5);
	    CreateExplosion(x+16,y,z+7,6,5);
	    CreateExplosion(x+18,y,z+7,6,5);
	    CreateExplosion(x+20,y,z+7,6,5);
	    CreateExplosion(x+22,y,z+7,6,5);
	    CreateExplosion(x+24,y,z+7,6,5);
	    CreateExplosion(x+26,y,z+7,6,5);
	    CreateExplosion(x+28,y,z+7,6,5);
	    CreateExplosion(x+30,y,z+7,6,5);
	    CreateExplosion(x+32,y,z+7,6,5);
	    SetTimerEx("AirstrikeGo3",2000,false,"dfffd",playerid,x,y,z,3);
	}

	if(type == 5)
	{
		CreateExplosion(x,y,z,6,5);
	    CreateExplosion(x+3,y,z,6,5);
	    CreateExplosion(x+2,y,z,6,5);
	    CreateExplosion(x+4,y,z,6,5);
	    CreateExplosion(x+6,y,z,6,5);
	    CreateExplosion(x+8,y,z,6,5);
	    CreateExplosion(x+10,y,z,6,5);
	    CreateExplosion(x+12,y,z,6,5);
	    CreateExplosion(x+14,y,z,6,5);
	    CreateExplosion(x+16,y,z,6,5);
	    CreateExplosion(x+18,y,z,6,5);
	    CreateExplosion(x+20,y,z,6,5);
	    CreateExplosion(x+22,y,z,6,5);
	    CreateExplosion(x+24,y,z,6,5);
	    CreateExplosion(x+26,y,z,6,5);
	    CreateExplosion(x+28,y,z,6,5);
	    CreateExplosion(x+30,y,z,6,5);
	    CreateExplosion(x+32,y,z,6,5);
	    CreateExplosion(x+32,y-1,z,6,5);
	    CreateExplosion(x+32,y-2,z,6,5);
	    CreateExplosion(x+32,y-3,z,6,5);
     	CreateExplosion(x+32,y+1,z,6,5);
	    CreateExplosion(x+32,y+2,z,6,5);
	    CreateExplosion(x+32,y+3,z,6,5);
	    SetTimerEx("AirstrikeGo3",2000,false,"dfffd",playerid,x,y,z,4);

	}
	return 1;
}

forward AirstrikeGo(playerid,Float:x,Float:y,Float:z,type);
public AirstrikeGo(playerid,Float:x,Float:y,Float:z,type)
{
	if(type == 1)
	{
		 Airstriking[playerid] = 0;
	     DestroyObject(Adromada);
	     CreateExplosion(x,y,z,6,5);
	}

    if(type == 2)
	{
		Airstriking[playerid] = 0;
		DestroyObject(Adromada);
	    CreateExplosion(x+4,y,z,6,5);
	    CreateExplosion(x+6,y,z,6,5);
	}

 	if(type == 3)
	{
	    Airstriking[playerid] = 0;
	    DestroyObject(Adromada);
	    CreateExplosion(x,y+1,z+1,6,5);
	    CreateExplosion(x,y+4,z+1,6,5);
	    CreateExplosion(x,y+6,z+1,6,5);
	}

	if(type == 4)
	{
		Airstriking[playerid] = 0;
		DestroyObject(Adromada);
	    CreateExplosion(x,y,z,6,5);
	    CreateExplosion(x+3,y,z,6,5);
	    CreateExplosion(x+2,y,z,6,5);
	    CreateExplosion(x+4,y,z,6,5);
	    CreateExplosion(x+6,y,z,6,5);
	    CreateExplosion(x+8,y,z,6,5);
	    CreateExplosion(x+10,y,z,6,5);
	    CreateExplosion(x+12,y,z,6,5);
	    CreateExplosion(x+14,y,z,6,5);
	    CreateExplosion(x+16,y,z,6,5);
	    CreateExplosion(x+18,y,z,6,5);
	    CreateExplosion(x+20,y,z,6,5);
	    CreateExplosion(x+22,y,z,6,5);
	    CreateExplosion(x+24,y,z,6,5);
	    CreateExplosion(x+26,y,z,6,5);
	    CreateExplosion(x+28,y,z,6,5);
	    CreateExplosion(x+30,y,z,6,5);
	    CreateExplosion(x+32,y,z,6,5);
	    CreateExplosion(x+34,y,z,6,5);
	    CreateExplosion(x+36,y,z,6,5);
	    CreateExplosion(x+38,y,z,6,5);
	    CreateExplosion(x+40,y,z,6,5);
	    CreateExplosion(x+42,y,z,6,5);
	}

	if(type == 5)
	{
	    Airstriking[playerid] = 0;
	    DestroyObject(Adromada);
  		CreateExplosion(x,y,z,7,10);
	    CreateExplosion(x,y,z+3,7,10);
	    CreateExplosion(x,y,z+6,7,10);
	    CreateExplosion(x,y,z+9,7,10);
	    CreateExplosion(x,y,z+12,7,10);
	    CreateExplosion(x,y,z+15, 7, 10);
	    CreateExplosion(x,y,z+18,7,10);
	    CreateExplosion(x,y,z+21,7,10);
	    CreateExplosion(x,y,z+24,7,10);
	    CreateExplosion(x,y,z+26,7,10);
	    CreateExplosion(x,y,z+29,7,10);
	    CreateExplosion(x,y,z+32,7,10);
		CreateExplosion(x,y,z+36,7,10);
	    CreateExplosion(x,y,z+40,7,10);
	    CreateExplosion(x,y,z+43,7,10);
	    CreateExplosion(x,y,z+46,7,10);
	    CreateExplosion(x,y+3,z+46,7,10);
	    CreateExplosion(x,y-3,z+46,7,10);
	    CreateExplosion(x+3,y,z+46,7,10);
    	CreateExplosion(x-3,y,z+46,7,10);
    	CreateExplosion(x+6,y+1,z+46,7,10);
    	CreateExplosion(x-6,y-1,z+46,7,10);
    	CreateExplosion(x+8,y+2,z+46,7,10);
    	CreateExplosion(x-8,y-2,z+46,7,10);
	}

	if(type == 6)
	{
		Airstriking[playerid] = 0;
	    DestroyObject(Adromada);
	    CreateExplosion(x,y+1,z,6,5);
	    CreateExplosion(x,y+2,z,6,5);
     	CreateExplosion(x,y+3,z,6,5);
     	CreateExplosion(x,y+4,z,6,5);
     	SetTimerEx("AirstrikeGo2",3000,false,"dfffd",playerid,x,y,z,1);
	}

	if(type == 7)
	{
		Airstriking[playerid] = 0;
	    DestroyObject(Adromada);
	    CreateExplosion(x+2,y,z,6,5);
	    CreateExplosion(x-2,y,z,6,5);
     	CreateExplosion(x+4,y,z,6,5);
     	CreateExplosion(x-4,y,z,6,5);
   		CreateExplosion(x+6,y,z,6,5);
     	CreateExplosion(x-6,y,z,6,5);
     	SetTimerEx("AirstrikeGo2",2000,false,"dfffd",playerid,x,y,z,2);
	}

	if(type == 8)
	{
		Airstriking[playerid] = 0;
	    DestroyObject(Adromada);
	    CreateExplosion(x+2,y,z,6,5);
	    CreateExplosion(x-2,y,z,6,5);
     	SetTimerEx("AirstrikeGo2",2000,false,"dfffd",playerid,x,y,z,3);
	}

	if(type == 9)
	{
		Airstriking[playerid] = 0;
	    DestroyObject(Adromada);
	    CreateExplosion(x+2,y-1,z+2,6,5);
	    CreateExplosion(x-2,y+1,z+4,6,5);
     	CreateExplosion(x,y,z+6,6,5);
	    CreateExplosion(x,y,z+8,6,5);
	   	CreateExplosion(x,y,z+12,6,5);
	    CreateExplosion(x,y,z+14,6,5);
	    CreateExplosion(x-1,y,z+12,6,5);
	    CreateExplosion(x+1,y,z+14,6,5);
	}

	if(type == 10)
	{
		Airstriking[playerid] = 0;
	    DestroyObject(Adromada);
	    CreateExplosion(x+4,y+10,z+7,6,5);
	    CreateExplosion(x+8,y+8,z+7,6,5);
	    CreateExplosion(x+12,y+6,z+7,6,5);
	    CreateExplosion(x+16,y+8,z+7,6,5);
	    CreateExplosion(x+18,y+6,z+7,6,5);
	    CreateExplosion(x+20,y+10,z+7,6,5);
	}

	if(type == 11)
	{
		Airstriking[playerid] = 0;
	    DestroyObject(Adromada);
	    CreateExplosion(x,y,z+15,6,5);
	    CreateExplosion(x+3,y,z+15,6,5);
	    CreateExplosion(x+2,y,z+15,6,5);
	    CreateExplosion(x+4,y,z+15,6,5);
	    CreateExplosion(x+6,y,z+15,6,5);
	    CreateExplosion(x+8,y,z+15,6,5);
	    CreateExplosion(x+10,y,z+15,6,5);
	    CreateExplosion(x+12,y,z+15,6,5);
	    CreateExplosion(x+14,y,z+15,6,5);
	    CreateExplosion(x+16,y,z+15,6,5);
	    CreateExplosion(x+18,y,z+15,6,5);
	    CreateExplosion(x+20,y,z+15,6,5);
	    CreateExplosion(x+22,y,z+15,6,5);
	    CreateExplosion(x+24,y,z+15,6,5);
	    CreateExplosion(x+26,y,z+15,6,5);
	    CreateExplosion(x+28,y,z+15,6,5);
	    CreateExplosion(x+30,y,z+15,6,5);
	    CreateExplosion(x+32,y,z+15,6,5);
	    CreateExplosion(x+26,y-1,z+15,6,5);
	    CreateExplosion(x+28,y-2,z+15,6,5);
	    CreateExplosion(x+30,y-3,z+15,6,5);
	    CreateExplosion(x+32,y-4,z+15,6,5);
	    SetTimerEx("AirstrikeGo2",2000,false,"dfffd",playerid,x,y,z,4);
	}

	if(type == 12)
	{
		Airstriking[playerid] = 0;
	    DestroyObject(Adromada);
	    CreateExplosion(x,y-1,z,6,5);
	    CreateExplosion(x+6,y+1,z,6,5);
	    CreateExplosion(x+12,y,z,6,5);
	    CreateExplosion(x-6,y,z,6,5);
	    CreateExplosion(x+8,y,z,6,5);
	    CreateExplosion(x,y-1,z,6,5);
	    CreateExplosion(x+6,y+6,z,6,5);
	    CreateExplosion(x+12,y+12,z,6,5);
	    CreateExplosion(x-6,y-6,z,6,5);
	    CreateExplosion(x+8,y+8,z,6,5);
	    CreateExplosion(x,y-1,z,6,5);
	    CreateExplosion(x+6,y+6,z+2,6,5);
	    CreateExplosion(x+12,y+12,z+2,6,5);
	    CreateExplosion(x-6,y-6,z+4,6,5);
	    CreateExplosion(x+8,y+8,z+4,6,5);
	}

	if(type == 13)
	{
		Airstriking[playerid] = 0;
	    DestroyObject(Adromada);
	    CreateExplosion(x,y-1,z,6,5);
	    CreateExplosion(x,y-2,z,6,5);
	    CreateExplosion(x,y-3,z,6,5);
	    CreateExplosion(x,y-4,z,6,5);
	    CreateExplosion(x,y-6,z,6,5);
	    CreateExplosion(x,y-8,z,6,5);
	    CreateExplosion(x,y-12,z,6,5);
	    CreateExplosion(x,y-14,z,6,5);
	    CreateExplosion(x,y-16,z,6,5);
	    CreateExplosion(x,y-18,z,6,5);
    	CreateExplosion(x,y,z,7,10);
	    CreateExplosion(x,y,z+3,7,10);
	    CreateExplosion(x,y,z+6,7,10);
	    CreateExplosion(x,y,z+9,7,10);
	    CreateExplosion(x,y,z+12,7,10);
	    CreateExplosion(x,y,z+15, 7, 10);
	    CreateExplosion(x,y,z+18,7,10);
	    CreateExplosion(x,y,z+21,7,10);
	    CreateExplosion(x,y,z+24,7,10);
	    CreateExplosion(x,y,z+26,7,10);
	    CreateExplosion(x,y,z+29,7,10);
	    CreateExplosion(x,y,z+32,7,10);
	}

	if(type == 14)
	{
		Airstriking[playerid] = 0;
	    DestroyObject(Adromada);
	    CreateExplosion(x-1,y,z,6,5);
	    CreateExplosion(x-2,y,z,6,5);
	    CreateExplosion(x-3,y,z,6,5);
	    CreateExplosion(x-4,y,z,6,5);
	    CreateExplosion(x-5,y,z,6,5);
	    CreateExplosion(x-6,y,z,6,5);
     	CreateExplosion(x-7,y,z,6,5);
	    CreateExplosion(x,y,z-3,7,10);
	    CreateExplosion(x,y,z-6,7,10);
	    CreateExplosion(x,y,z-9,7,10);
	    CreateExplosion(x,y,z-12,7,10);
	    CreateExplosion(x,y,z-15,7,10);
	    CreateExplosion(x,y,z-18,7,10);
	    CreateExplosion(x,y,z-21,7,10);
	    CreateExplosion(x,y,z-24,7,10);
	    CreateExplosion(x,y,z-26,7,10);
	    CreateExplosion(x,y,z-29,7,10);
	    CreateExplosion(x,y,z-32,7,10);
	}

	if(type == 15)
	{
		Airstriking[playerid] = 0;
	    DestroyObject(Adromada);
		Airstriking[playerid] = 0;
	    DestroyObject(Adromada);
	    CreateExplosion(x-1,y,z,6,5);
	    CreateExplosion(x-2,y,z,6,5);
	    CreateExplosion(x+1,y,z,6,5);
	    CreateExplosion(x+2,y,z,6,5);
	    CreateExplosion(x+3,y,z+1,6,5);
	    CreateExplosion(x+2,y,z+2,6,5);
	    CreateExplosion(x+4,y,z+3,6,5);
	    CreateExplosion(x+6,y,z+4,6,5);
	    CreateExplosion(x+8,y,z+6,6,5);
	    CreateExplosion(x+10,y,z+7,6,5);
	    CreateExplosion(x+12,y,z+8,6,5);
	    CreateExplosion(x+14,y-4,z+8,6,5);
	    CreateExplosion(x+16,y+4,z+8,6,5);
	    CreateExplosion(x+18,y+8,z+8,6,5);
	    CreateExplosion(x+20,y-8,z+8,6,5);
	}

    Airstrike[playerid] = 0;
	return 1;
}


public OnPlayerCommandText(playerid,cmdtext[])
{

	if (strcmp(cmdtext, "/airstrike", true) == 0)
	{
		ShowPlayerDialog(playerid,DS,2,"Airstrikes","Vehicle Smasher \nEnemy Wave Attack \nTank Buster \nCarpet Bomb \nNuke \nAir Attack \nAir Bomber \nMegaNuke \nVehicle Nuke \nAircracker bomb \nAirCluster Bomb \nDestructorBomb \nFireCluster \nSplitterMissile \nMOAB ","Ok","Cancel");
		return 1;
	}

	return 0;
}