
// Adminstration [ mic_admin ]

/*
native BanLT(playerid,time);                                        // time in hours
native UnBan(IP[]);
native Pause(time);
native Silence(playerid);
native UnSilence(playerid);
native Scan(playerid);
*/

public BanLT(playerid,time){
new IP[256];
new hour[256];
new str[256];
valstr(hour,time);
GetPlayerIp(playerid,IP,256);
SaveProperty("BanList",IP,hour);
format(str,256,"SERVER: You have been banned from the server for next %d hr(s).",time);
SendClientMessage(playerid,0xAFAFAFAA,str);
Kick(playerid);
}

public UnBan(IP[]){
SaveProperty("BanList",IP,"0");
}

public Pause(time){
new sec = time * 1000;
new i = tickcount();
while (tickcount() - i < sec){}
}

public Silence(playerid){
muted[playerid] = 1;
}

public UnSilence(playerid){
muted[playerid] = 0;
}
public OneHour(){
new seek;
new val;
new len;
new fd;
new str[256];
new st[256];
new File:hand = fopen("BanList.zip",io_read);
fread(hand,str);
fclose(hand);
len = strlen(str);
//printf("%d",len);
while(seek <= len-3){
seek = strfind(str,"=",true,seek);
fd = strfind(str,";",true,seek);
strmid(st,str,seek+1,len);
val = strval(st);
val = val -1;
valstr(st,val);
strdel(str,seek+1,fd);
strins(str,st,seek+1);
seek++;
}
new File:handd = fopen("BanList.zip",io_write);
fwrite(handd,str);
fclose(handd);
//print(str);

}
public Scan(playerid){
new dec,decc,st[256],Float:fl,Float:x,Float:y,Float:z;
GetPlayerName(playerid,st,256);
printf("Name: %s",st);
GetPlayerIp(playerid,st,256);
printf("IP: %s",st);
dec = GetPlayerScore(playerid);
printf("Score: %d",dec);
GetPlayerHealth(playerid,fl);
printf("Health: %f",fl);
GetPlayerArmour(playerid,fl);
printf("Armour: %f",fl);
dec = GetPlayerWantedLevel(playerid);
printf("Wanted Level: %d",dec);
dec = GetPlayerMoney(playerid);
printf("Cash: %d",dec);
GetPlayerPos(playerid,x,y,z);
printf("Player X cord: %f",x);
printf("Player Y cord: %f",y);
printf("Player Z cord: %f",z);
dec = GetPlayerInterior(playerid);
printf("Interior ID: %d",dec);
GetPlayerWeaponData(playerid,0,dec,decc);
GetWeaponName(dec,st,256);
printf("Weapon 0: %s",st);
GetPlayerWeaponData(playerid,1,dec,decc);
GetWeaponName(dec,st,256);
printf("Weapon 1: %s",st);
GetPlayerWeaponData(playerid,2,dec,decc);
GetWeaponName(dec,st,256);
printf("Weapon 2: %s",st);
GetPlayerWeaponData(playerid,3,dec,decc);
GetWeaponName(dec,st,256);
printf("Weapon 3: %s",st);
GetPlayerWeaponData(playerid,4,dec,decc);
GetWeaponName(dec,st,256);
printf("Weapon 4: %s",st);
GetPlayerWeaponData(playerid,5,dec,decc);
GetWeaponName(dec,st,256);
printf("Weapon 5: %s",st);
GetPlayerWeaponData(playerid,6,dec,decc);
GetWeaponName(dec,st,256);
printf("Weapon 6: %s",st);
GetPlayerWeaponData(playerid,7,dec,decc);
GetWeaponName(dec,st,256);
printf("Weapon 7: %s",st);
GetPlayerWeaponData(playerid,8,dec,decc);
GetWeaponName(dec,st,256);
printf("Weapon 8: %s",st);
GetPlayerWeaponData(playerid,9,dec,decc);
GetWeaponName(dec,st,256);
printf("Weapon 9: %s",st);
GetPlayerWeaponData(playerid,10,dec,decc);
GetWeaponName(dec,st,256);
printf("Weapon 10: %s",st);
GetPlayerWeaponData(playerid,11,dec,decc);
GetWeaponName(dec,st,256);
printf("Weapon 11: %s",st);
GetPlayerWeaponData(playerid,12,dec,decc);
GetWeaponName(dec,st,256);
printf("Weapon 12: %s",st);
dec = GetPlayerSkin(playerid);
printf("Skin: %d",dec);
}
