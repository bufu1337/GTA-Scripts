#include <a_samp>

new offfset=12;

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
enum hInfo {
	Float:x,
	Float:y,
	Float:z,
	Float:rx,
	Float:ry,
	Float:rz,
}
#define MAX_HAYSTAX 255
new HayStax[MAX_HAYSTAX][hInfo];
public OnFilterScriptInit()
{
	print("\n+------------------------------------+");
	print("|        Text To HayStack v1.2          |");
	print("|        Created By: Pghpunkid          |");
    print("+------------------------------------+\n");

	for(new f=31; f<MAX_HAYSTAX; f++)
	{
	    if(IsValidObject(f))
	    {
	        DestroyObject(f);
	    }
	}
	for(new p=31; p<MAX_HAYSTAX; p++)
	{
	    HayStax[p][x]=0.0;
	    HayStax[p][y]=0.0;
	    HayStax[p][z]=0.0;
	    HayStax[p][rx]=0.0;
	    HayStax[p][ry]=0.0;
	    HayStax[p][rz]=0.0;
	}
	if(!fexist("Haystax.ini"))
	    SaveHaystax();
	LoadHaystax();
	for(new l=31; l<MAX_HAYSTAX; l++)
	{
	    if(HayStax[l][x] != 0.0 && HayStax[l][y] != 0.0 && HayStax[l][z] != 0.0)
	    {
	        CreateObject(3374,HayStax[l][x],HayStax[l][y],HayStax[l][z],HayStax[l][rx],HayStax[l][ry],HayStax[l][rz]);
	    }
	}
	return 1;
}

public OnFilterScriptExit()
{
    for(new f=31; f<MAX_HAYSTAX; f++)
	{
	    if(IsValidObject(f))
	    {
	        DestroyObject(f);
	    }
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    new cmd[256];
	new tmp[256];
	new idx;
	cmd = strtok(cmdtext, idx);
	if (strcmp(cmd, "/clear", true) == 0)
	{
		new cleared=0;
		for(new f=31; f<MAX_HAYSTAX; f++)
		{
		    if(IsValidObject(f))
		    {
		        cleared++;
		        DestroyObject(f);
	 	        HayStax[f][x]=0;
				HayStax[f][y]=0;
				HayStax[f][z]=0;
				HayStax[f][rx]=0;
				HayStax[f][ry]=0;
				HayStax[f][rz]=0;
		    }
		    SaveHaystax();
		}
		new str[30];
		format(str,sizeof(str),"HAYSTAX: %d objects cleared.",cleared);
		SendClientMessage(playerid,COLOR_GREY,str);
		return 1;
	}
	if (strcmp(cmd, "/create", true) == 0)
	{
	    tmp =strtok(cmdtext,idx);
	    if(!strlen(tmp))
	    {
	        SendClientMessage(playerid,COLOR_GREY,"Error! /create [10 char string MAX]");
	        return 1;
	    }
	    new string[10];
	    strmid(string,tmp,0,sizeof(tmp),10);
		new Float:a, Float:b, Float:c;
		GetPlayerPos(playerid,a,b,c);
		new len = strlen(string);
		for(new p=0; p<=len; p++)
		{
		    if(string[p]==':')
		    {
		        CreateObject(3374,a,b+2,c+9,0,0,0);
		        CreateObject(3374,a,b+2,c+3,0,0,0);
		        b=floatadd(b,offfset-6);
		    }
		    if(string[p]=='!')
		    {
		        CreateObject(3374,a,b+2,c+12,0,0,0);
		        CreateObject(3374,a,b+2,c+9,0,0,0);
		        CreateObject(3374,a,b+2,c+6,0,0,0);
		        CreateObject(3374,a,b+2,c,0,0,0);
		        b=floatadd(b,offfset);
		    }
		    if(string[p]=='?')
		    {
		        CreateObject(3374,a,b+2,c+12,0,0,0);
		        CreateObject(3374,a,b+5,c+12,0,0,0);
		        CreateObject(3374,a,b+8,c+12,0,0,0);
		        CreateObject(3374,a,b+8,c+9,0,0,0);
		        CreateObject(3374,a,b+8,c+6,0,0,0);
		        CreateObject(3374,a,b+5,c+6,0,0,0);
	         	CreateObject(3374,a,b+2,c+6,0,0,0);
	         	CreateObject(3374,a,b+2,c+4,0,0,0);
		        CreateObject(3374,a,b+2,c,0,0,0);
		        b=floatadd(b,offfset);
		    }
		    if(string[p]=='a' || string[p]=='A')
		    {
				CreateObject(3374,a,b+2,c,0,0,0);
				CreateObject(3374,a,b+2,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+6,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+8,c,0,0,0);
				CreateObject(3374,a,b+8,c+3,0,0,0);
				CreateObject(3374,a,b+8,c+6,0,0,0);
				CreateObject(3374,a,b+8,c+9,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				CreateObject(3374,a,b+5,c+12,0,0,0);
				CreateObject(3374,a,b+5,c+6,0,0,0);
				b=floatadd(b,offfset);
			}
            if(string[p]=='b' || string[p]=='B')
		    {
				CreateObject(3374,a,b+2,c,0,0,0);
				CreateObject(3374,a,b+2,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+6,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+8,c,0,0,0);
				CreateObject(3374,a,b+8,c+3,0,0,0);
				CreateObject(3374,a,b+8,c+6,0,0,0);
				CreateObject(3374,a,b+7,c+9,0,0,0);
				CreateObject(3374,a,b+7,c+12,0,0,0);
				CreateObject(3374,a,b+5,c+12,0,0,0);
				CreateObject(3374,a,b+5,c+6,0,0,0);
				CreateObject(3374,a,b+5,c,0,0,0);
		        b=floatadd(b,offfset);
		    }
		    if(string[p]=='c' || string[p]=='C')
		    {
				CreateObject(3374,a,b+2,c,0,0,0);
				CreateObject(3374,a,b+2,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+6,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+8,c,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				CreateObject(3374,a,b+5,c+12,0,0,0);
				CreateObject(3374,a,b+5,c,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='d' || string[p]=='D')
		    {
				CreateObject(3374,a,b+2,c,0,0,0);
				CreateObject(3374,a,b+2,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+6,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+7,c+1,0,0,0);
				CreateObject(3374,a,b+7,c+3,0,0,0);
				CreateObject(3374,a,b+7,c+6,0,0,0);
				CreateObject(3374,a,b+7,c+9,0,0,0);
				CreateObject(3374,a,b+7,c+11,0,0,0);
				CreateObject(3374,a,b+5,c+12,0,0,0);
				CreateObject(3374,a,b+5,c,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='e' || string[p]=='E')
		    {
				CreateObject(3374,a,b+2,c,0,0,0);
				CreateObject(3374,a,b+2,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+6,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+5,c,0,0,0);
				CreateObject(3374,a,b+8,c,0,0,0);
				CreateObject(3374,a,b+5,c+6,0,0,0);
				CreateObject(3374,a,b+8,c+6,0,0,0);
				CreateObject(3374,a,b+5,c+12,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='f' || string[p]=='F')
		    {
				CreateObject(3374,a,b+2,c,0,0,0);
				CreateObject(3374,a,b+2,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+6,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+5,c+6,0,0,0);
				CreateObject(3374,a,b+8,c+6,0,0,0);
				CreateObject(3374,a,b+5,c+12,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='g' || string[p]=='G')
		    {
				CreateObject(3374,a,b+2,c,0,0,0);
				CreateObject(3374,a,b+2,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+6,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+5,c,0,0,0);
				CreateObject(3374,a,b+8,c,0,0,0);
				CreateObject(3374,a,b+8,c+3,0,0,0);
				CreateObject(3374,a,b+8,c+6,0,0,0);
				CreateObject(3374,a,b+5,c+12,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='h' || string[p]=='H')
		    {
				CreateObject(3374,a,b+2,c,0,0,0);
				CreateObject(3374,a,b+2,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+6,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+8,c,0,0,0);
				CreateObject(3374,a,b+8,c+3,0,0,0);
				CreateObject(3374,a,b+8,c+6,0,0,0);
				CreateObject(3374,a,b+8,c+9,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				CreateObject(3374,a,b+5,c+6,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='i' || string[p]=='I')
		    {
				CreateObject(3374,a,b+2,c,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+8,c,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				CreateObject(3374,a,b+5,c+0,0,0,0);
				CreateObject(3374,a,b+5,c+6,0,0,0);
				CreateObject(3374,a,b+5,c+3,0,0,0);
				CreateObject(3374,a,b+5,c+9,0,0,0);
				CreateObject(3374,a,b+5,c+12,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='j' || string[p]=='J')
		    {
				CreateObject(3374,a,b+2,c,0,0,0);
				CreateObject(3374,a,b+2,c+3,0,0,0);
				CreateObject(3374,a,b+5,c,0,0,0);
				CreateObject(3374,a,b+8,c+0,0,0,0);
				CreateObject(3374,a,b+8,c+6,0,0,0);
				CreateObject(3374,a,b+8,c+3,0,0,0);
				CreateObject(3374,a,b+8,c+9,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='k' || string[p]=='K')
		    {
				CreateObject(3374,a,b+8,c+12,0,0,0);
				CreateObject(3374,a,b+8,c+9,0,0,0);
				CreateObject(3374,a,b+8,c+3,0,0,0);
				CreateObject(3374,a,b+5,c+6,0,0,0);
				CreateObject(3374,a,b+8,c,0,0,0);
				CreateObject(3374,a,b+2,c+0,0,0,0);
				CreateObject(3374,a,b+2,c+6,0,0,0);
				CreateObject(3374,a,b+2,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='l' || string[p]=='L')
		    {
				CreateObject(3374,a,b+8,c,0,0,0);
				CreateObject(3374,a,b+5,c,0,0,0);
				CreateObject(3374,a,b+2,c+0,0,0,0);
				CreateObject(3374,a,b+2,c+6,0,0,0);
				CreateObject(3374,a,b+2,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='m' || string[p]=='M')
		    {
		        CreateObject(3374,a,b+2.5,c+11,0,0,0);
		        CreateObject(3374,a,b+7.5,c+11,0,0,0);
				CreateObject(3374,a,b+5.5,c+9,45,0,0);
				CreateObject(3374,a,b+4.5,c+9,315,0,0);
				CreateObject(3374,a,b+2,c+0,0,0,0);
				CreateObject(3374,a,b+2,c+6,0,0,0);
				CreateObject(3374,a,b+2,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+8,c+0,0,0,0);
				CreateObject(3374,a,b+8,c+6,0,0,0);
				CreateObject(3374,a,b+8,c+3,0,0,0);
				CreateObject(3374,a,b+8,c+9,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='n' || string[p]=='N')
		    {
				CreateObject(3374,a,b+5.5,c+6,315,0,0);
				CreateObject(3374,a,b+4.5,c+8,315,0,0);
				CreateObject(3374,a,b+2,c+0,0,0,0);
				CreateObject(3374,a,b+2,c+6,0,0,0);
				CreateObject(3374,a,b+2,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+8,c+0,0,0,0);
				CreateObject(3374,a,b+8,c+6,0,0,0);
				CreateObject(3374,a,b+8,c+3,0,0,0);
				CreateObject(3374,a,b+8,c+9,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='o' || string[p]=='O')
		    {
				CreateObject(3374,a,b+2,c,0,0,0);
				CreateObject(3374,a,b+2,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+6,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+8,c,0,0,0);
				CreateObject(3374,a,b+8,c+3,0,0,0);
				CreateObject(3374,a,b+8,c+6,0,0,0);
				CreateObject(3374,a,b+8,c+9,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				CreateObject(3374,a,b+5,c+12,0,0,0);
				CreateObject(3374,a,b+5,c,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='p' || string[p]=='P')
		    {
				CreateObject(3374,a,b+2,c,0,0,0);
				CreateObject(3374,a,b+2,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+6,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+5,c+6,0,0,0);
				CreateObject(3374,a,b+8,c+6,0,0,0);
				CreateObject(3374,a,b+5,c+12,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				CreateObject(3374,a,b+8,c+9,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='q' || string[p]=='Q')
		    {
				CreateObject(3374,a,b+2,c+1,0,0,0);
				CreateObject(3374,a,b+2,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+6,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+8,c+1,0,0,0);
				CreateObject(3374,a,b+8,c+3,0,0,0);
				CreateObject(3374,a,b+8,c+6,0,0,0);
				CreateObject(3374,a,b+8,c+9,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				CreateObject(3374,a,b+5,c+12,0,0,0);
				CreateObject(3374,a,b+5,c+1,0,0,0);
				CreateObject(3374,a,b+7,c+3,315,0,0);
				CreateObject(3374,a,b+9,c+0.5,315,0,0);
				b=floatadd(b,offfset);
			}
            if(string[p]=='r' || string[p]=='R')
		    {
				CreateObject(3374,a,b+2,c,0,0,0);
				CreateObject(3374,a,b+2,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+6,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+5,c+6,0,0,0);
				CreateObject(3374,a,b+7.5,c+5,315,0,0);
				CreateObject(3374,a,b+5,c+12,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				CreateObject(3374,a,b+8,c+9,0,0,0);
				CreateObject(3374,a,b+8,c+3,0,0,0);
				CreateObject(3374,a,b+5,c+6,0,0,0);
				CreateObject(3374,a,b+8,c,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='s' || string[p]=='S')
		    {
				CreateObject(3374,a,b+2,c,0,0,0);
				CreateObject(3374,a,b+8,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+6,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+5,c,0,0,0);
				CreateObject(3374,a,b+8,c,0,0,0);
				CreateObject(3374,a,b+5,c+6,0,0,0);
				CreateObject(3374,a,b+8,c+6,0,0,0);
				CreateObject(3374,a,b+5,c+12,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='t' || string[p]=='T')
		    {
				CreateObject(3374,a,b+5,c,0,0,0);
				CreateObject(3374,a,b+5,c+3,0,0,0);
				CreateObject(3374,a,b+5,c+6,0,0,0);
				CreateObject(3374,a,b+5,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+5,c+12,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='u' || string[p]=='U')
		    {
				CreateObject(3374,a,b+2,c,0,0,0);
				CreateObject(3374,a,b+2,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+6,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
                CreateObject(3374,a,b+8,c,0,0,0);
				CreateObject(3374,a,b+8,c+3,0,0,0);
				CreateObject(3374,a,b+8,c+6,0,0,0);
				CreateObject(3374,a,b+8,c+9,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				CreateObject(3374,a,b+5,c,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='v' || string[p]=='V')
		    {

				CreateObject(3374,a,b+3.5,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+6,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+6.5,c+3,0,0,0);
				CreateObject(3374,a,b+8,c+6,0,0,0);
				CreateObject(3374,a,b+8,c+9,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				CreateObject(3374,a,b+5,c,0,0,0);
				b=floatadd(b,offfset+3);
			}
			if(string[p]=='w' || string[p]=='W')
		    {

				CreateObject(3374,a,b+2.5,c+2,0,0,0);
		        CreateObject(3374,a,b+7.5,c+2,0,0,0);
				CreateObject(3374,a,b+4.5,c+2,45,0,0);
				CreateObject(3374,a,b+5.5,c+2,315,0,0);
				CreateObject(3374,a,b+2,c+0,0,0,0);
				CreateObject(3374,a,b+2,c+6,0,0,0);
				CreateObject(3374,a,b+2,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+8,c+0,0,0,0);
				CreateObject(3374,a,b+8,c+6,0,0,0);
				CreateObject(3374,a,b+8,c+3,0,0,0);
				CreateObject(3374,a,b+8,c+9,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='x' || string[p]=='X')
		    {
				CreateObject(3374,a,b+2.5,c+4.5,330,0,0);
		        CreateObject(3374,a,b+7.5,c+4.5,30,0,0);
				CreateObject(3374,a,b+2.5,c+7.5,30,0,0);
				CreateObject(3374,a,b+7.5,c+7.5,330,0,0);
				CreateObject(3374,a,b+2,c+0,0,0,0);
				CreateObject(3374,a,b+2,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+8,c+0,0,0,0);
    			CreateObject(3374,a,b+5,c+6,0,0,0);
				CreateObject(3374,a,b+8,c+3,0,0,0);
				CreateObject(3374,a,b+8,c+9,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='y' || string[p]=='Y')
		    {
				CreateObject(3374,a,b+2.5,c+7.5,30,0,0);
				CreateObject(3374,a,b+7.5,c+7.5,330,0,0);
				CreateObject(3374,a,b+5,c+3,0,0,0);
				CreateObject(3374,a,b+2,c+9,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+5,c+0,0,0,0);
    			CreateObject(3374,a,b+5,c+6,0,0,0);
				CreateObject(3374,a,b+8,c+9,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				b=floatadd(b,offfset);
			}
			if(string[p]=='z' || string[p]=='Z')
		    {
				CreateObject(3374,a,b+5,c+12,0,0,0);
				CreateObject(3374,a,b+8,c+12,0,0,0);
				CreateObject(3374,a,b+2,c+12,0,0,0);
				CreateObject(3374,a,b+7,c+8.5,45,0,0);
				CreateObject(3374,a,b+5.5,c+6.5,45,0,0);
				CreateObject(3374,a,b+4,c+4.5,45,0,0);
				CreateObject(3374,a,b+2.5,c+2.5,45,0,0);
				CreateObject(3374,a,b+5,c,0,0,0);
    			CreateObject(3374,a,b+2,c,0,0,0);
				CreateObject(3374,a,b+8,c,0,0,0);
				b=floatadd(b,offfset);
			}
		}
		SaveHaystax();
		return 1;
	}
	return 0;
}
stock SaveHaystax()
{
	for(new l=31; l<MAX_HAYSTAX; l++)
	{
	    if(IsValidObject(l))
	    {
	        GetObjectPos(l,HayStax[l][x],HayStax[l][y],HayStax[l][z]);
	        GetObjectRot(l,HayStax[l][rx],HayStax[l][ry],HayStax[l][rz]);
	    }
	}
	new string3[128];
	format(string3, sizeof(string3), "Haystax.ini");
	new File: hFile = fopen(string3, io_write);
	if (hFile)
	{
		new var[32];
		for(new l=31; l<MAX_HAYSTAX; l++)
		{
			format(var, 32, "%f\n", HayStax[l][x]);fwrite(hFile, var);
			format(var, 32, "%f\n", HayStax[l][y]);fwrite(hFile, var);
			format(var, 32, "%f\n", HayStax[l][z]);fwrite(hFile, var);
			format(var, 32, "%f\n", HayStax[l][rx]);fwrite(hFile, var);
			format(var, 32, "%f\n", HayStax[l][ry]);fwrite(hFile, var);
			format(var, 32, "%f\n", HayStax[l][rz]);fwrite(hFile, var);
		}
		fclose(hFile);
	}
	return 1;
}
stock LoadHaystax()
{
	new string2[128];
    format(string2, sizeof(string2), "Haystax.ini");
	new File: file = fopen(string2, io_read);
	if (file)
	{
		new valtmp[128];
		for(new l=31; l<MAX_HAYSTAX; l++)
		{
			fread(file, valtmp);HayStax[l][x] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);HayStax[l][y] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);HayStax[l][z] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);HayStax[l][rx] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);HayStax[l][ry] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);HayStax[l][rz] = strval(valtmp);DelPrint(valtmp);
		}
		fclose(file);
	}
	return 1;
}
stock DelPrint(string1[])
{
	strmid(string1, string1, 0, strlen(string1)-1, 255);
	printf("%s", string1);
	return 1;
}
strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
