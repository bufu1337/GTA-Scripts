//3DMenu. Author: SDraw
#include <streamer>
#include <YSI\y_hooks>
#include <foreach>
#define MAX_MENUS (128)
#define MAX_BOXES (16)
enum pinfo {
	Selected3DMenu,
	Selected3DBox
};
enum Menu3dParams {
	Float:Rotation,
	Boxes,9
	bool:IsExist,
	Objects[MAX_BOXES],
	Float:AddingX,
	Float:AddingY
	};
new Menu3dInfo[MAX_MENUS][MenuParams];
new PlayerInfo[MAX_PLAYERS][pinfo];
forward OnPlayerSelect3DMenuBox(playerid,MenuID,selected);
forward OnPlayerSet3DMenuBox(playerid,MenuID,selected);
stock Create3DMenu(Float:x,Float:y,Float:z,Float:rotation,boxes,playerid){
	if(boxes > MAX_BOXES || boxes <= 0) return -1;
	for(new i = 0; i < MAX_MENUS; i++){
	    if(!MenuInfo[i][IsExist]){
	        MenuInfo[i][Rotation] = rotation;
			MenuInfo[i][Boxes] = boxes;
			if(rotation == 0 || rotation == 360) { MenuInfo[i][AddingX] = 0.0; MenuInfo[i][AddingY] = -0.25; }
			if(rotation == 180) { MenuInfo[i][AddingX] = 0.0; MenuInfo[i][AddingY] = 0.25; }
			if(rotation == 90) { MenuInfo[i][AddingX] = 0.25; MenuInfo[i][AddingY] = 0.0; }
			if(rotation == 270) { MenuInfo[i][AddingX] = -0.25; MenuInfo[i][AddingY] = 0.0; }
			if((rotation > 0 && rotation < 90) || (rotation > 270 && rotation < 360)){
				MenuInfo[i][AddingX] = 0.25*floatsin(rotation,degrees);
				MenuInfo[i][AddingY] = -floatcos(rotation,degrees)*0.25;
			}
			if((rotation > 90 && rotation < 180) || (rotation > 180 && rotation < 270)){
				MenuInfo[i][AddingX] = 0.25*floatsin(rotation,degrees);
				MenuInfo[i][AddingY] = -floatcos(rotation,degrees)*0.25;
			}
	        for(new b = 0; b < boxes; b++){
				if(b < 4) MenuInfo[i][Objects][b] = CreateStreamObject(2661,x,y,z+0.55*b,0,0,rotation,100.0, 1);
				if(b >= 4){
				    new Float:NextLineX,Float:NextLineY;
				    NextLineX = floatcos(rotation,degrees)+0.05*floatcos(rotation,degrees); NextLineY = floatsin(rotation,degrees)+0.05*floatsin(rotation,degrees);
				    if(b < 8) MenuInfo[i][Objects][b] = CreateStreamObject(2661,x+NextLineX,y+NextLineY,z+0.55*(b-4),0,0,rotation,100.0,1);
				    if(b > 7 && b < 12) MenuInfo[i][Objects][b] = CreateStreamObject(2661,x+NextLineX*2,y+NextLineY*2,z+0.55*(b-8),0,0,rotation,100.0,1);
				    if(b > 11 && b < 16) MenuInfo[i][Objects][b] = CreateStreamObject(2661,x+NextLineX*3,y+NextLineY*3,z+0.55*(b-12),0,0,rotation,100.0,1);
	            	HideStreamObject(MenuInfo[i][Objects][b]);
				}
			}
			MenuInfo[i][IsExist] = true;
			return i;
		}
	}
	return -1;
}
stock Destroy3DMenu(MenuID){
    if(!MenuInfo[MenuID][IsExist]) return -1;
    foreach(Player,i) if(PlayerInfo[i][Selected3DMenu] == MenuID) CancelSelect3DMenu(i,MenuID);
    for(new i = 0; i < MenuInfo[MenuID][Boxes]; i++){
		DestroyStreamObject(MenuInfo[MenuID][Objects][i]);
		MenuInfo[MenuID][Objects][i] = INVALID_OBJECT_ID;
	}
 	MenuInfo[MenuID][Boxes] = 0;
 	MenuInfo[MenuID][IsExist] = false;
 	MenuInfo[MenuID][AddingX] = 0.0;
 	MenuInfo[MenuID][AddingY] = 0.0;
	return 1;
}
stock Show3DMenuForPlayer(playerid, MenuID){
	if(!MenuInfo[MenuID][IsExist] || IsPlayerConnected(playerid)) return -1;
	for(new b = 0; b < MenuInfo[MenuID][Boxes]; b++){
		ShowStreamObjectForPlayer(playerid,MenuInfo[MenuID][Objects][b]);
	}

	return 1;
}
stock Hide3DMenuForPlayer(playerid, MenuID){
	if(!MenuInfo[MenuID][IsExist] || IsPlayerConnected(playerid) ) return -1;
	for(new b = 0; b < MenuInfo[MenuID][Boxes]; b++){
		HideStreamObjectForPlayer(playerid,MenuInfo[MenuID][Objects][b]);
	}
	return 1;
}
stock SetBoxText(MenuID,box,text[],materialsize,fontface[],fontsize,bold,fontcolor,backcolor,textalignment){
	if(!MenuInfo[MenuID][IsExist]) return -1;
	if(box == MenuInfo[MenuID][Boxes] || box < 0) return -1;
	if(MenuInfo[MenuID][Objects][box] == INVALID_OBJECT_ID) return -1;
	SetDynamicObjectMaterialText(MenuInfo[MenuID][Objects][box],0,text,materialsize,fontface,fontsize,bold,fontcolor,backcolor,textalignment);
	return 1;
}
stock Select3DMenu(playerid,MenuID){
	if(!MenuInfo[MenuID][IsExist]) return -1;
	new Float:x,Float:y,Float:z;
	PlayerInfo[playerid][Selected3DBox] = MenuInfo[MenuID][Boxes]-1;
	PlayerInfo[playerid][Selected3DMenu] = MenuID;
 	GetDynamicObjectPos(MenuInfo[MenuID][Objects][PlayerInfo[playerid][Selected3DBox]],x,y,z);
	SetDynamicObjectPos(MenuInfo[MenuID][Objects][PlayerInfo[playerid][Selected3DBox]],x+MenuInfo[MenuID][AddingX],y+MenuInfo[MenuID][AddingY],z);
	return 1;
}
stock CancelSelect3DMenu(playerid,MenuID){
    if(!MenuInfo[MenuID][IsExist]) return -1;
	new Float:x,Float:y,Float:z;
 	GetDynamicObjectPos(MenuInfo[MenuID][Objects][PlayerInfo[playerid][Selected3DBox]],x,y,z);
	SetDynamicObjectPos(MenuInfo[MenuID][Objects][PlayerInfo[playerid][Selected3DBox]],x-MenuInfo[MenuID][AddingX],y-MenuInfo[MenuID][AddingY],z);
	PlayerInfo[playerid][Selected3DMenu] = -1;
	PlayerInfo[playerid][Selected3DBox] = -1;
	return 1;
}
public OnPlayerSelect3DMenuBox(playerid,MenuID,selected){
	return 1;
}
public OnPlayerSet3DMenuBox(playerid,MenuID,selected){
	return 1;
}
hook OnFilterScriptInit(){
	for(new i = 0; i < MAX_PLAYERS; i++){
 		PlayerInfo[i][Selected3DMenu] = -1;
		PlayerInfo[i][Selected3DBox] = -1;
	}
	for(new i = 0; i < MAX_MENUS; i++){
	    for(new b = 0; b < MAX_BOXES; b++) MenuInfo[i][Objects][b] = INVALID_OBJECT_ID;
     	MenuInfo[i][Boxes] = 0;
	 	MenuInfo[i][IsExist] = false;
	 	MenuInfo[i][AddingX] = 0.0;
 		MenuInfo[i][AddingY] = 0.0;
	}
}
hook OnFilterScriptExit(){
	for(new i = 0; i < MAX_MENUS; i++){
		if(MenuInfo[i][IsExist]) Destroy3DMenu(i);
	}
}
hook OnGameModeInit(){
	for(new i = 0; i < MAX_MENUS; i++){
	    for(new b = 0; b < MAX_BOXES; b++){
			MenuInfo[i][Objects][b] = INVALID_OBJECT_ID;
		}
	    MenuInfo[i][Boxes] = 0;
	    MenuInfo[i][IsExist] = false;
	    MenuInfo[i][AddingX] = 0.0;
 		MenuInfo[i][AddingY] = 0.0;
	}
}
hook OnGameModeExit(){
	for(new i = 0; i < MAX_MENUS; i++){
		if(MenuInfo[i][IsExist]) Destroy3DMenu(i);
	}
}
hook OnPlayerConnect(playerid){
    PlayerInfo[playerid][Selected3DMenu] = -1;
	PlayerInfo[playerid][Selected3DBox] = -1;
}
hook OnPlayerKeyStateChange(playerid,newkeys,oldkeys){
	if(PlayerInfo[playerid][Selected3DMenu] != -1){
		new MenuID = PlayerInfo[playerid][Selected3DMenu];
		new Float:x,Float:y,Float:z;
	    if(newkeys == KEY_YES){
	        GetDynamicObjectPos(MenuInfo[MenuID][Objects][PlayerInfo[playerid][Selected3DBox]],x,y,z);
			SetDynamicObjectPos(MenuInfo[MenuID][Objects][PlayerInfo[playerid][Selected3DBox]],x-MenuInfo[MenuID][AddingX],y-MenuInfo[MenuID][AddingY],z);
			PlayerInfo[playerid][Selected3DBox]++;
			if(PlayerInfo[playerid][Selected3DBox] == MenuInfo[MenuID][Boxes]) PlayerInfo[playerid][Selected3DBox] = 0;
			GetDynamicObjectPos(MenuInfo[MenuID][Objects][PlayerInfo[playerid][Selected3DBox]],x,y,z);
			SetDynamicObjectPos(MenuInfo[MenuID][Objects][PlayerInfo[playerid][Selected3DBox]],x+MenuInfo[MenuID][AddingX],y+MenuInfo[MenuID][AddingY],z);
			CallLocalFunction("OnPlayerSet3DMenuBox","idd",playerid,MenuID,PlayerInfo[playerid][Selected3DBox]);
		}
		if(newkeys == KEY_NO){
	        GetDynamicObjectPos(MenuInfo[MenuID][Objects][PlayerInfo[playerid][Selected3DBox]],x,y,z);
			SetDynamicObjectPos(MenuInfo[MenuID][Objects][PlayerInfo[playerid][Selected3DBox]],x-MenuInfo[MenuID][AddingX],y-MenuInfo[MenuID][AddingY],z);
			PlayerInfo[playerid][Selected3DBox]--;
			if(PlayerInfo[playerid][Selected3DBox] < 0) PlayerInfo[playerid][Selected3DBox] = MenuInfo[MenuID][Boxes]-1;
			GetDynamicObjectPos(MenuInfo[MenuID][Objects][PlayerInfo[playerid][Selected3DBox]],x,y,z);
			SetDynamicObjectPos(MenuInfo[MenuID][Objects][PlayerInfo[playerid][Selected3DBox]],x+MenuInfo[MenuID][AddingX],y+MenuInfo[MenuID][AddingY],z);
			CallLocalFunction("OnPlayerSet3DMenuBox","idd",playerid,MenuID,PlayerInfo[playerid][Selected3DBox]);
		}
		if(newkeys == KEY_SPRINT) CallLocalFunction("OnPlayerSelect3DMenuBox","idd",playerid,MenuID,PlayerInfo[playerid][Selected3DBox]);
	}
}


