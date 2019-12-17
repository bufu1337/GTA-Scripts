
// Data Storage System [ mic_data ]

/*
native LoadPlayer(playerid,info[],key[]);
native SavePlayer(playerid,info[],key[]);
native LoadProperty(name[],info[],key[]);
native SaveProperty(name[],info[],key[]);
*/

public LoadPlayer(playerid,info[],value[]){
new filen[256],name[256];
GetPlayerName(playerid,name,255);
format(filen,256,"%s.zip",name);
new data[256];
new front;
new len;
if (fexist(filen)){}
else{
new File:open = fopen(filen,io_write);
fclose(open);
}
new File:Read = fopen(filen,io_read);
fread(Read,data);
len = strlen(data);
front = strfind(data,info,true);
if (front == -1){
return 0;
}
else{
strdel(data,0,front);
front = strfind(data,"=");
strdel(data,0,front);
front = strfind(data,";");
strdel(data,0,1);
strdel(data,front-1,len);
format(value,sizeof(data),data);
return 1;
}
}

public SavePlayer(playerid,info[],value[]){
new sta[256];
new filen[256],name[256];
GetPlayerName(playerid,name,255);
format(filen,256,"%s.zip",name);
if (fexist(filen)){}
else{
new File:open = fopen(filen,io_write);
fclose(open);
}
format(sta,256,"%s=",info);
new data[256],fnd;
new File:Check = fopen(filen,io_read);
fread(Check,data);
fclose(Check);
fnd = strfind(data,sta);
if(fnd ==-1){
new File:Read = fopen(filen,io_append);
format(data,256,"%s=%s;",info,value);
fwrite(Read,data);
fclose(Read);
//print("meee");
}
else{
new len,str;
new string[256];
new File:Read = fopen(filen,io_read);
fread(Read,data);
//print(data);
str = strfind(data,info);
len = strfind(data,";",true,str);
strdel(data,str,len+1);
//print(data);
format(string,256,"%s=%s;",info,value);
strins(data,string,str);
//print(data);
fclose(Read);
new File:Write = fopen(filen,io_write);
fwrite(Write,data);
fclose(Write);
//print("me");
}
}
public LoadProperty(name[],info[],value[]){
new filen[256];
format(filen,256,"%s.zip",name);
new data[256];
new front;
new len;
if (fexist(filen)){}
else{
new File:open = fopen(filen,io_write);
fclose(open);
}
new File:Read = fopen(filen,io_read);
fread(Read,data);
len = strlen(data);
front = strfind(data,info,true);
if (front == -1){
//print("loop ");
return 0;
}
else{
strdel(data,0,front);
front = strfind(data,"=");
strdel(data,0,front);
front = strfind(data,";");
strdel(data,0,1);
strdel(data,front-1,len);
format(value,sizeof(data),data);
//print("loop ");
return 1;
}
}

public SaveProperty(name[],info[],value[]){
new sta[256];
new filen[256];
format(filen,256,"%s.zip",name);
format(sta,256,"%s=",info);
new data[256],fnd;
if (fexist(filen)){}
else{
new File:open = fopen(filen,io_write);
fclose(open);
}
new File:Check = fopen(filen,io_read);
fread(Check,data);
fclose(Check);
fnd = strfind(data,sta);
if(fnd ==-1){
new File:Read = fopen(filen,io_append);
format(data,256,"%s=%s;",info,value);
fwrite(Read,data);
fclose(Read);
//print("meee");
}
else{
new len,str;
new string[256];
new File:Read = fopen(filen,io_read);
fread(Read,data);
//print(data);
str = strfind(data,info);
len = strfind(data,";",true,str);
strdel(data,str,len+1);
//print(data);
format(string,256,"%s=%s;",info,value);
strins(data,string,str);
//print(data);
fclose(Read);
new File:Write = fopen(filen,io_write);
fwrite(Write,data);
fclose(Write);
//print("me");
}
}
