// Busineses [ mic_biz ]

/*
native AddStaticBiz(Float:x,Float:y,Float:z,Float:ix,Float:iy,Float:iz,ii);
native SetBizCost(bizid,cost);
native GetBizInfo(bizid,info[],value[]);
native SetBizInfo(bizid,info[],value[]);
native SetPlayerInBiz(playerid,bizid);
native SetPlayerOutBiz(playerid,bizid);
native IsPlayerAllowedInBiz(playerid,bizid);
native GetBizOwner(bizid);
native SetBizOwner(bizid,name[]);
native GetBizCost(bizid);
*/

public GetBizInfo(bizid,info[],value[])
{
new str[100];
new ret;
format(str,100,"biz%d",bizid);
ret = LoadProperty(str,info,value);
return ret;
}


public SetBizInfo(bizid,info[],value[]){
new str[100];
format(str,100,"biz%d",bizid);
SaveProperty(str,info,value);
}

public AddStaticBiz(Float:x,Float:y,Float:z,Float:ix,Float:iy,Float:iz,ii){
bid++;
BP[CreatePickup(1272,2,x,y,z)] = bid;
BIX[bid] = ix;
BIY[bid] = iy;
BIZ[bid] = iz;
BII[bid] = ii;
BOX[bid] = x;
BOY[bid] = y;
BOZ[bid] = z;
new str[256];
format(str,256,"Biz%d.zip",bid);
if (!fexist(str)){
new File:Biz = fopen(str,io_write);
fclose(Biz);
SetBizInfo(bid,"Owner","none");
SetBizInfo(bid,"Fee","0");
SetBizInfo(bid,"Cost","50000");
}
return bid;
}


public OnPlayerEnterBizz(playerid,bizid){
ShowMenuForPlayer(Bmenu,playerid);
BID[playerid] = bizid;
}

public SetPlayerInBiz(playerid,bizid){
PIB[playerid] = bizid;
SetPlayerPos(playerid,BIX[bizid],BIY[bizid],BIZ[bizid]);
SetPlayerInterior(playerid,BII[bizid]);
ShowMenuForPlayer(Bexit,playerid);
CallLocalFunction("OnPlayerEnterBiz","ii",playerid,bizid);
new str3[100],str2[256];
format(str3,100,"biz%d",bizid);
LoadProperty(str3,"Fee",str2);
new cost = strval(str2);
GivePlayerMoney(playerid,-cost);
}

public SetPlayerOutBiz(playerid,bizid){
PIB[playerid] = 0;
SetPlayerPos(playerid,BOX[bizid],BOY[bizid],BOZ[bizid]);
SetPlayerInterior(playerid,0);
CallLocalFunction("OnPlayerLeaveBiz","ii",playerid,bizid);
}

public IsPlayerAllowedInBiz(playerid,bizid){
new str[256];
GetBizInfo(PIB[playerid],"Fee",str);
new mon = strval(str);
if (GetPlayerMoney(playerid) >= mon){
return 1;
}
else{
return 0;
}
}



