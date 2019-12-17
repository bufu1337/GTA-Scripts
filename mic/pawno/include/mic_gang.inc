// Gang System [ mic_gang ]

/*
native CreateGang(name[],color);
native DestroyGang(gangid);
native SetPlayerInGang(playerid,gangid);
native GetPlayerGangId(playerid);
native SendMessageToGang(gangid,color,const message[]);
native IsPlayerInGang(playerid,gangid);
*/


public CreateGang(name[],color)
{
gang_id++;
format(gang_name[gang_id],200,name);
gang_color[gang_id] = color;
return gang_id;
}

public DestroyGang(gangid)
{
format(gang_name[gangid],200,"0");
gang_color[gangid] = 0;
new i;
for(i=0;i<=MAX_PLAYERS;i++){
if (IsPlayerInGang(i,gangid)==1){
SetPlayerInGang(i,0);
}}
}


public SetPlayerInGang(playerid,gangid)
{
gang_player[playerid] = gangid;
SetPlayerColor(playerid,gang_color[gangid]);
}

public GetPlayerGangId(playerid)
{
return gang_player[playerid];
}

public IsPlayerInGang(playerid,gangid){
if(gang_player[playerid] == gangid){
return 1;
}
else{
return 0;
}}

public SendMessageToGang(gangid,color,const message[]){
new i;
for(i=0;i<=MAX_PLAYERS;i++){
if(IsPlayerInGang(i,gangid)==1){
SendClientMessage(i,color,message);
}}}
