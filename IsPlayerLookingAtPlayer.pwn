#include <a_samp>

/*
native SavePVars(playerid);
native LoadPVars(playerid);
native IsPlayerLookingAtPoint(playerid,Float:X,Float:Y,Float:Z,Float:ViewWidth,Float:ViewHeight);
*/

stock SavePVars(playerid)
{
	new tmp[512],File:file,pvar,index;
	GetPlayerName(playerid,tmp,24);
	format(tmp,512,"Accounts/%s.samp",tmp);
	printf("Saving PVars at \"%s\"  --  PlayerID=%d",tmp,playerid);
	file=fopen(tmp,io_write);
	index=GetPVarsUpperIndex(playerid);
	while(pvar<index)
	{
		GetPVarNameAtIndex(playerid,pvar,tmp,512);
		switch(GetPVarType(playerid,tmp))
		{
		    case PLAYER_VARTYPE_STRING:
		    {
		        new tmp2[256];
		        GetPVarString(playerid,tmp,tmp2,256);
		        format(tmp,512,"STRING %s%c%s\n",tmp,1,tmp2);
		        fwrite(file,tmp);
		    }
		    case PLAYER_VARTYPE_INT:
		    {
		        new tmp2;
		        tmp2=GetPVarInt(playerid,tmp);
		        format(tmp,512,"INT    %s%c%d\n",tmp,1,tmp2);
		        fwrite(file,tmp);
		    }
		    case PLAYER_VARTYPE_FLOAT:
		    {
		        new Float:tmp2;
		        tmp2=GetPVarFloat(playerid,tmp);
		        format(tmp,512,"FLOAT  %s%c%f\n",tmp,1,tmp2);
		        fwrite(file,tmp);
		    }
		}
		pvar++;
	}
	print("Successful");
	fclose(file);
}

stock LoadPVars(playerid)
{
	new tmp[512],File:file;
	new spacer[2];
	format(spacer,2,"%c",1);
	GetPlayerName(playerid,tmp,24);
	format(tmp,512,"Accounts/%s.samp",tmp);
	if(!fexist(tmp))return printf("Loading \"%s\" failed  --  PlayerID=%d",tmp,playerid);
	printf("Loading PVars from \"%s\"  --  PlayerID=%d",tmp,playerid);
	file=fopen(tmp,io_read);
	fread(file,tmp);
	while(tmp[0])
	{
		if(!strcmp(tmp,"STRING",false,6))
		{
		    new tmp2[256];
		    strmid(tmp2,tmp,strfind(tmp,spacer)+1,strlen(tmp)-1);
		    strmid(tmp,tmp,7,strfind(tmp,spacer));
		    printf("%s=%s",tmp,tmp2);
		    SetPVarString(playerid,tmp,tmp2);
		}
		if(!strcmp(tmp,"INT   ",false,6))
		{
		    new tmp2[256];
		    strmid(tmp2,tmp,strfind(tmp,spacer)+1,strlen(tmp)-1,256);
		    strmid(tmp,tmp,7,strfind(tmp,spacer),256);
		    printf("%s=%d",tmp,strval(tmp2));
		    SetPVarInt(playerid,tmp,strval(tmp2));
		}
		if(!strcmp(tmp,"FLOAT ",false,6))
		{
		    new tmp2[256];
		    strmid(tmp2,tmp,strfind(tmp,spacer)+1,strlen(tmp)-1,256);
		    strmid(tmp,tmp,7,strfind(tmp,spacer),256);
		    printf("%s=%f",tmp,floatstr(tmp2));
		    SetPVarFloat(playerid,tmp,floatstr(tmp2));
		}
		fread(file,tmp);
	}
	print("Successful");
	fclose(file);
	return 1;
}

new Float:_IPLAP[13];
stock IsPlayerLookingAtPlayer(playerid,playerid2)
{
	GetPlayerPos(playerid,_IPLAP[0],_IPLAP[1],_IPLAP[2]);

	GetPlayerCameraUpVector(playerid,_IPLAP[3],_IPLAP[4],_IPLAP[5]);
	_IPLAP[0]+=_IPLAP[3];
	_IPLAP[1]+=_IPLAP[4];
	_IPLAP[2]+=_IPLAP[5];

	GetPlayerCameraFrontVector(playerid,_IPLAP[6],_IPLAP[7],_IPLAP[8]);

	GetPlayerPos(playerid2,_IPLAP[9],_IPLAP[10],_IPLAP[11]);

	_IPLAP[12]=floatsqroot( ((_IPLAP[9]-_IPLAP[0])*(_IPLAP[9]-_IPLAP[0])) + ((_IPLAP[10]-_IPLAP[1])*(_IPLAP[10]-_IPLAP[1])) + ((_IPLAP[11]-_IPLAP[2])*(_IPLAP[11]-_IPLAP[2])) );

	_IPLAP[0]=_IPLAP[6]*_IPLAP[12]+_IPLAP[0];
	_IPLAP[1]=_IPLAP[7]*_IPLAP[12]+_IPLAP[1];
	_IPLAP[2]=_IPLAP[8]*_IPLAP[12]+_IPLAP[2];

	if( (_IPLAP[0]>(_IPLAP[9]-0.25)) && (_IPLAP[0]<(_IPLAP[9]+0.25)) && (_IPLAP[1]>(_IPLAP[10]-0.25)) && (_IPLAP[1]<(_IPLAP[10]+0.25)) && (_IPLAP[2]>(_IPLAP[11])) && (_IPLAP[2]<(_IPLAP[11]+2.0)) ) return 1;
	return 0;
}
stock IsPlayerLookingAtPoint(playerid,Float:X,Float:Y,Float:Z)
{
	GetPlayerPos(playerid,_IPLAP[0],_IPLAP[1],_IPLAP[2]);

	GetPlayerCameraUpVector(playerid,_IPLAP[3],_IPLAP[4],_IPLAP[5]);
	_IPLAP[0]+=_IPLAP[3];
	_IPLAP[1]+=_IPLAP[4];
	_IPLAP[2]+=_IPLAP[5];

	GetPlayerCameraFrontVector(playerid,_IPLAP[6],_IPLAP[7],_IPLAP[8]);

	GetPlayerPos(playerid2,_IPLAP[9],_IPLAP[10],_IPLAP[11]);

	_IPLAP[12]=floatsqroot( ((X-_IPLAP[0])*(X-_IPLAP[0])) + ((Y-_IPLAP[1])*(Y-_IPLAP[1])) + ((Z-_IPLAP[2])*(Z-_IPLAP[2])) );

	_IPLAP[0]=_IPLAP[6]*_IPLAP[12]+_IPLAP[0];
	_IPLAP[1]=_IPLAP[7]*_IPLAP[12]+_IPLAP[1];
	_IPLAP[2]=_IPLAP[8]*_IPLAP[12]+_IPLAP[2];

	if( (_IPLAP[0]>(X-0.25)) && (_IPLAP[0]<(X+0.25)) && (_IPLAP[1]>(Y-0.25)) && (_IPLAP[1]<(Y+0.25)) && (_IPLAP[2]>(Z)) && (_IPLAP[2]<(Z+2.0)) ) return 1;
	return 0;
}