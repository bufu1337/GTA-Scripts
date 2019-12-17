// Ammunation [ mic_ammu ]

/*
native EnableBlockAmmu(toggle);
native AddStaticAmmu(slot1,slot2,slot3,slot4,slot5,slot6,slot7);
native SetWeaponCost(ammuid,weaponid,cost);
native ShowAmmu(playerid,ammuid);
native IsPlayerInAmmu(Float:radi, playerid, Float:x, Float:y, Float:z);
*/
SelectedMenuAmmu(playerid,row){
new i;
new Menu:Cur = GetPlayerMenu(playerid);
for (i=0;i<=150;i++){
if (Cur == AN[i]){
switch (row){
case 0:{
ShowMenuForPlayer(AN1,playerid);
}
case 1:{
ShowMenuForPlayer(AN2,playerid);
}
case 2:{
ShowMenuForPlayer(AN3,playerid);
}
case 3:{
ShowMenuForPlayer(AN4,playerid);
}
case 4:{
ShowMenuForPlayer(AN5,playerid);
}
case 5:{
ShowMenuForPlayer(AN6,playerid);
}
case 6:{
ShowMenuForPlayer(AN7,playerid);
}
}
}
else if (Cur == AN1){
switch(row){
case 0:{
GivePlayerWeapon(playerid,22,50);
GivePlayerMoney(playerid,-st11[i]);
}
case 1:{
GivePlayerWeapon(playerid,23,50);
GivePlayerMoney(playerid,-st12[i]);
}
case 2:{
GivePlayerWeapon(playerid,24,50);
GivePlayerMoney(playerid,-st13[i]);
}
}
}
else if (Cur == AN2){
switch(row){
case 0:{
GivePlayerWeapon(playerid,32,50);
GivePlayerMoney(playerid,-st21[i]);
}
case 1:{
GivePlayerWeapon(playerid,28,50);
GivePlayerMoney(playerid,-st22[i]);
}
}
}
else if (Cur == AN3){
switch(row){
case 0:{
GivePlayerWeapon(playerid,25,50);
GivePlayerMoney(playerid,-st31[i]);
}
case 1:{
GivePlayerWeapon(playerid,26,50);
GivePlayerMoney(playerid,-st32[i]);
}
}
}
else if (Cur == AN4){
switch(row){
case 0:{
SetPlayerArmour(playerid,100);
GivePlayerMoney(playerid,-st41[i]);
}
}
}
else if (Cur == AN5){
switch(row){
case 0:{
GivePlayerWeapon(playerid,29,50);
GivePlayerMoney(playerid,-st51[i]);
}
}
}
else if (Cur == AN6){
switch(row){
case 0:{
GivePlayerWeapon(playerid,33,50);
GivePlayerMoney(playerid,-st61[i]);
}
case 1:{
GivePlayerWeapon(playerid,34,50);
GivePlayerMoney(playerid,-st62[i]);
}
}
}
else if (Cur == AN7){
switch(row){
case 0:{
GivePlayerWeapon(playerid,30,50);
GivePlayerMoney(playerid,-st71[i]);
}
case 1:{
GivePlayerWeapon(playerid,31,50);
GivePlayerMoney(playerid,-st72[i]);
}
}
}
}
}
public EnableBlockAmmu(toggle){
if (toggle == 0){
new i;
for(i =0; i<= MAX_PLAYERS; i++){
			if 	(IsPlayerInAmmu(20, i,292.0274,-36.0291,1001.5156))
			{
			new Float:ht = GetPlayerHealth(i,ht);
			SetPlayerHealth(i,ht-10);
			}
			else if(IsPlayerInAmmu(20, i,308.2740,-141.2833,999.6016))
			{
			new Float:ht = GetPlayerHealth(i,ht);
			SetPlayerHealth(i,ht-10);
			}
			else if(IsPlayerInAmmu(20, i,294.3212,-108.7869,1001.5156))
			{
			new Float:ht = GetPlayerHealth(i,ht);
			SetPlayerHealth(i,ht-10);
			}
			else if(IsPlayerInAmmu(20, i,288.8592,-80.4535,1001.5156))
			{
			new Float:ht = GetPlayerHealth(i,ht);
			SetPlayerHealth(i,ht-10);
			}
			else if(IsPlayerInAmmu(20, i,316.9583,-165.4707,999.6010))
			{
			new Float:ht = GetPlayerHealth(i,ht);
			SetPlayerHealth(i,ht-10);
			}
}}
SetTimerEx("EnableBlockAmmu",700,0,"i",0);
}


public AddStaticAmmu (slot1,slot2,slot3,slot4,slot5,slot6,slot7){
sto++;
st1[sto] = slot1;
st2[sto] = slot2;
st3[sto] = slot3;
st4[sto] = slot4;
st5[sto] = slot5;
st6[sto] = slot6;
st7[sto] = slot7;

AN[sto] = CreateMenu("Ammu-Nation",1,25,150,150,150);
AddMenuItem(AN[sto],0,"Pistols");
AddMenuItem(AN[sto],0,"Micro SMGs");
AddMenuItem(AN[sto],0,"Shotguns");
AddMenuItem(AN[sto],0,"Armor");
AddMenuItem(AN[sto],0,"SMG");
AddMenuItem(AN[sto],0,"Rifles");
AddMenuItem(AN[sto],0,"Assault");
if(st1[sto] == 0){DisableMenuRow(AN[sto],0);}
if(st2[sto] == 0){DisableMenuRow(AN[sto],1);}
if(st3[sto] == 0){DisableMenuRow(AN[sto],2);}
if(st4[sto] == 0){DisableMenuRow(AN[sto],3);}
if(st5[sto] == 0){DisableMenuRow(AN[sto],4);}
if(st6[sto] == 0){DisableMenuRow(AN[sto],5);}
if(st7[sto] == 0){DisableMenuRow(AN[sto],6);}

return sto;
}

public ShowAmmu(playerid,ammuid){
ShowMenuForPlayer(AN[ammuid],playerid);
}

public SetWeaponCost(ammuid,weaponid,cost){
switch(weaponid){
case 11:{
st11[ammuid] = cost;
}
case 12:{
st12[ammuid] = cost;
}
case 13:{
st13[ammuid] = cost;
}
case 21:{
st21[ammuid] = cost;
}
case 22:{
st22[ammuid] = cost;
}
case 31:{
st31[ammuid] = cost;
}
case 32:{
st32[ammuid] = cost;
}
case 41:{
st41[ammuid] = cost;
}
case 51:{
st51[ammuid] = cost;
}
case 61:{
st61[ammuid] = cost;
}
case 62:{
st62[ammuid] = cost;
}
case 72:{
st72[ammuid] = cost;
}
}
}

public IsPlayerInAmmu(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		////printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

